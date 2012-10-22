From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: reading from eMMC boot partions: timeout or ECC error?
Date: Mon, 22 Oct 2012 16:59:50 +0200
Message-ID: <17562013.0KIQZolflN@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:36428 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755157Ab2JVPHI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Oct 2012 11:07:08 -0400
Received: from comm.systec-electronic.de (95-91-85-164-dynip.superkabel.de [95.91.85.164])
	by webbox1416.server-home.net (Postfix) with ESMTPA id 629B427A6C1
	for <linux-mmc@vger.kernel.org>; Mon, 22 Oct 2012 17:05:47 +0200 (CEST)
Received: from ws-stein.localnet (unknown [192.168.10.70])
	by comm.systec-electronic.de (Postfix) with ESMTP id 2B1ED97C275
	for <linux-mmc@vger.kernel.org>; Mon, 22 Oct 2012 16:59:53 +0200 (CEST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello,

I'm currently investigating problems during accessing /dev/mmcblk1boot0 and
/dev/mmcblk0 simultaneously. Currenty I'm running a 3.6.2 kernel and enter the
following command directly after bootup:
> # dd if=/dev/mmcblk1boot0 of=/dev/null bs=4096 (bs is chosen arbitrary)
and get the following output:
> 64+0 records in
> 64+0 records out
> 262144 bytes (256.0KB) copied, 0.022922 seconds, 10.9MB/s
If I redo this, i get
> # dd if=/dev/mmcblk1boot0 of=/dev/null bs=4096
> 64+0 records in
> 64+0 records out
> 262144 bytes (256.0KB) copied, 0.719781 seconds, 355.7KB/s

And the following 2 lines in dmesg:
> [   39.794510] mmcblk1boot0: error -110 transferring data, sector 0, nr 32, cmd response 0x900, card status 0xb00
> [   39.805648] mmcblk1boot0: retrying using single block read

It seems the first read was successful and pretty fast and the 2nd one
eventually finished but it seems it got a timeout. The above message are
printed when the request status is MMC_BLK_ECC_ERR which in turn is set
when the following conditions is met:
drivers/mmc/card/block.c 726-728
> if ((status & R1_CARD_ECC_FAILED) ||
>     (brq->stop.resp[0] & R1_CARD_ECC_FAILED) ||
>     (brq->cmd.resp[0] & R1_CARD_ECC_FAILED))

So is this an ECC error or a timeout? Why doesn't it happen the 1st time?
Any hints?

Best regards,
Alexander

PS: Is arbitrary switching bewteen mmcblk1boot0 and mmcblk1 supported/intended?
Once I acces mmcblk1boot0 readin from mmcblk1 results in different errors.

