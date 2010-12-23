From: Sujit Reddy <sujitreddy243@gmail.com>
Subject: eMMC sector/byte access mode validation
Date: Thu, 23 Dec 2010 13:35:03 +0530
Message-ID: <AANLkTinn8EOuiB7ufMFxu=4vCf1K1==oj7Yqni_pbMjc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34333 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532Ab0LWIFF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Dec 2010 03:05:05 -0500
Received: by pzk35 with SMTP id 35so45236pzk.19
        for <linux-mmc@vger.kernel.org>; Thu, 23 Dec 2010 00:05:04 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, akpm@linux-foundation.org, prakity@marvell.com

Hi,

According to eMMC spec v4.3, Section 6.1 says that greater than 2GB
density cards are sector addressable and less than 2GB are byte addressable.
But Section 7.3.3 says that OCR bit 30 needs to be used which access mode
the host must use for all its future transactions.

In mainline kernel the support for less than 2GB cards is by checking
the density of card.
If it is greater than 2GB it is assumed to be supporting sector addressing.

But actually we need to check the OCR value to determine the correct access mode
See patch (http://www.spinics.net/lists/linux-mmc/msg01466.html) by Philip.

Some eMMC cards even though less than 2GB have SEC_COUNT value defined
in EXT_CSD register but does not support sector access mode.

I have a couple of questions here:
1) Are there any cards that support only byte access mode even though
the density is
greater than 2GB?
2) If there are cards which have capacity less than 2GB and supports only sector
access mode then what's the solution? I am not sure If there are any such cards.

Philip's patch handles both these scenarios effectively.
Can anyone mention the reason not taking Philip's patch into account,
which I feel is much
more fool proof than the implementation in mainline kernel
(http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg02307.html)?

Thanks
Sujit
