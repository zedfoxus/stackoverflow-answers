<?php

$str = "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Table comment'";
$keys = array('ENGINE', 'DEFAULT CHARSET', 'COLLATE', 'COMMENT');

$str_array = explode('=', $str); 
/* result of the above will be
[0] => ENGINE
[1] => InnoDB DEFAULT CHARSET
[2] => utf8 COLLATE
[3] => utf8_unicode_ci COMMENT
[4] => 'Table comment' 
*/

$output = array();
$lastkey = '';

// loop through each split item
foreach ($str_array as $item) {
	
	// if the item is entirely one of the keys, just remember it as the last key
	if (in_array($item, $keys)) {
		$lastkey = $item;
		continue;
	}
	
	// check if item like InnoDB DEFAULT CHARSET contains one of the keys
	// if item contains a key, the key will be returned
	// Otherwise, item will be returned
	$result = item_has_a_key($item, $keys);
	
	if ($result === $item) {
		// if the result is exactly the item, that means no key was found in the item
		// that means, it is the value of the previously found key
		$output[$lastkey] = $item;
	} else {	
		// if the result is not exactly the item, that means it contained one of the keys
		// strip out the key leaving only the value. Assign the value to previously found key
		$output[$lastkey] = trim(str_replace($result, '', $item));
		
		// remember the key that was found
		$lastkey = $result;
	}
}

print_r($output);
/*
Result:
[ENGINE] => InnoDB
[DEFAULT CHARSET] => utf8
[COLLATE] => utf8_unicode_ci
[COMMENT] => 'Table comment'
*/


// $item can be InnoDB DEFAULT CHARSET
// $keys is the array of keys you have assigned (ENGINE, DEFAULT CHARSET etc.)
// if the item contains one of the keys, the key will be returned
// if the item contains no key, the item will be returned
function item_has_a_key($item, $keys) {
	foreach ($keys as $key) {
		if (strpos($item, $key) !== false) {
			return $key;
		}
	}
	return $item;
}
?>
