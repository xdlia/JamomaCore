/*
 * Cache of common node addresses for speed
 * Copyright © 2011, Théo de la Hogue
 *
 * License: This code is licensed under the terms of the "New BSD License"
 * http://creativecommons.org/licenses/BSD/
 */

#include "TTAddressCache.h"


TTFOUNDATION_EXPORT TTAddressTable	gTTAddressTable;

// TODO: rename these to, e.g. kTTAddressEmpty
TTFOUNDATION_EXPORT TTAddress	kTTAdrsEmpty("");
TTFOUNDATION_EXPORT TTAddress	kTTAdrsRoot("/");
TTFOUNDATION_EXPORT TTAddress	kTTAdrsZero("0");
