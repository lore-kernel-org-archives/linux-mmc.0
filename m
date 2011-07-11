From: Peter Warasin <peter@endian.com>
Subject: damn slow SDHC card
Date: Mon, 11 Jul 2011 19:39:29 +0200
Message-ID: <4E1B3551.1040505@endian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cerbero2.endian.it ([80.190.199.139]:49265 "EHLO
	smtp1.endian.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758403Ab1GKSGH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jul 2011 14:06:07 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by solaria.endian.it (Postfix) with ESMTP id 52E9A599384
	for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2011 19:39:40 +0200 (CEST)
Received: from smtp1.endian.com ([127.0.0.1])
	by localhost (solaria.endian.it [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KhPRGxutMChI for <linux-mmc@vger.kernel.org>;
	Mon, 11 Jul 2011 19:39:30 +0200 (CEST)
Received: from smtp.frangart.endian.com (unknown [192.168.201.129])
	by solaria.endian.it (Postfix) with ESMTP id CBFD1599363
	for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2011 19:39:30 +0200 (CEST)
Received: from localhost (localhost.localhost [127.0.0.1])
	by smtp.frangart.endian.com (Postfix) with ESMTP id 5D329116EC3
	for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2011 19:39:30 +0200 (CEST)
Received: from [10.7.5.53] (unknown [10.7.5.53])
	by smtp.frangart.endian.com (Postfix) with ESMTP id 330A6116EB9
	for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2011 19:39:30 +0200 (CEST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

hi guys

i have /var and swap on an SD card (sandisk class4 4GB) in an embedded
network device, which turns out to be reeeeally slow. System under
certain circumstances freezes and in top i see iowait at 90% and
processes which touch sd card, like kswapd, kjournald and *mmc*d are all
on io-wait (D)

i found some help at linaro for sorting out if it is the SD card, which
most probably is and try now to search a card which is fast enough

but tried also to sort out if maybe it is the kernel, because something
is fishy there.
can you guys help me a little on that?

the card is a high-speed card, but it is not running in highspeed mode:

cat /sys/kernel/debug/mmc0/ios
clock:		25000000 Hz
vdd:		20 (3.2 ~ 3.3 V)
bus mode:	2 (push-pull)
chip select:	0 (don't care)
power mode:	2 (on)
bus width:	2 (4 bits)
timing spec:	0 (legacy)


i then forced the card setting to highspeed mode (by commenting out some
returns in mmc_switch_hs() and found out that the card meets all
requirements for highspeed, but

card->sw_caps.hs_max_dtr is 0

is that value the maximum bus speed which the card can handle?
i assume when it is 0 it means it is limited to legacy specifications,
which is quite slow (?)

or is it regardless for performance if a SDHC card runs in legacy mode?

thank you in advance

kind regards,
peter


-- 
:: e n d i a n
:: open source - open minds

:: peter warasin
:: http://www.endian.com   :: peter@endian.com
