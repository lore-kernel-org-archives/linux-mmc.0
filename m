From: Jerry Duan <jerryduan100@yahoo.com>
Subject: emmc trim issue with Freescale's eSDHC controller
Date: Tue, 28 Oct 2014 21:12:15 +0000 (UTC)
Message-ID: <loom.20141028T214728-110@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:43808 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750982AbaJ1WzI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Oct 2014 18:55:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1XjFfL-0007OO-Ud
	for linux-mmc@vger.kernel.org; Tue, 28 Oct 2014 23:55:06 +0100
Received: from 205.150.9.19 ([205.150.9.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Tue, 28 Oct 2014 23:55:03 +0100
Received: from jerryduan100 by 205.150.9.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Tue, 28 Oct 2014 23:55:03 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi, 

After searching a lot for my emmc/trim issue, I ran into this great mailing
list, which is exactly what I am looking for. 

In my system,  when I test the trim feature, I always got the following:
$fstrim /mnt/mymmc/
fstrim: /mnt/mymmc/: FITRIM ioctl failed: Operation not supported
$cat /sys/class/block/mmcblk0/queue/discard_max_bytes
0

the mmc_calc_max_discard() prints out:
   mmc0: calculated max. discard sectors 0 for timeout 402 ms.

My system information:
1.P5040,eSDHC controller, 
2.a Micron eMMC chip , EXT_CSD_TRIM_MULT is 15,
3. SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK, host->max_clk is 333333332MHz

the following thread
(https://www.mail-archive.com/linux-mmc%40vger.kernel.org/msg26133.html) has
a very similar issue, but I don't know how and where I can get a patch.

Thanks in advance,
Jerry


