From: Pavel Kiryukhin <vksavl@gmail.com>
Subject: cmd12 fails to stop out of range reads on Sandisk 2Gb microSD card.
Date: Thu, 04 Mar 2010 00:43:13 +0300
Message-ID: <4B8ED7F1.5040204@gmail.com>
Reply-To: vksavl@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:63751 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756620Ab0CCVll (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Mar 2010 16:41:41 -0500
Received: by bwz1 with SMTP id 1so291817bwz.21
        for <linux-mmc@vger.kernel.org>; Wed, 03 Mar 2010 13:41:39 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: vksavl@gmail.com

Hi,
There was an issue reported by Cliff Brake some time ago regarding 
Sandisk 2Gb SD card behavior.
(http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg00982.html)
It seems I have similar issue with Sandisk 2Gb microSD:
CMD18 read last 8 blocks available (512 bytes each). After the reception 
of last bytes of last block cmd12 is send to stop transmit. But while 
command is send card continue transmit. And the first byte received is 
data error token with valid value 0x8 - out of range. Then 0fxff follows 
and 8-th byte should be response to cmd12. The problem is: 2Gb sandisk 
card send 0xc2 and refuse accept any other commands - e.g. it responds 
with 0x4 to subsequent cmd17. But other card (no name) responds with 0 
instead of 0xc2.

8 ff ff ff ff ff ff ff c2 3f ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  [Sandisk (SU02G)]

8 ff ff ff ff ff ff ff 0 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff   [other card (SD02G)]

I can catch this condition, but it's not clear how to resume - card 
keeps sending 0x4 (illegal command) response.
Is this a known issue? I'm using rather old 2.6.19 code (with some 
backports form upstream), but I didn't find proper fix in later code. 
Workaround I use at the moment - report smaller disk size - violating 
block is not read and card can be mounted (m.b. with warnings related to 
cheat with size).
Any help would be highly appreciated!
--
Thanks,
Pavel Kiryukhin

