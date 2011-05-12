From: Huang Changming-R66093 <R66093@freescale.com>
Subject: About the get_cd callback function
Date: Thu, 12 May 2011 09:13:05 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F1154C50F@039-SN1MPN1-005.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:20198 "EHLO
	TX2EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755362Ab1ELJNM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 May 2011 05:13:12 -0400
Received: from mail96-tx2 (localhost.localdomain [127.0.0.1])	by
 mail96-tx2-R.bigfish.com (Postfix) with ESMTP id 7D6AEAC026C	for
 <linux-mmc@vger.kernel.org>; Thu, 12 May 2011 09:13:11 +0000 (UTC)
Received: from TX2EHSMHS045.bigfish.com (unknown [10.9.14.239])	by
 mail96-tx2.bigfish.com (Postfix) with ESMTP id 602B0858051	for
 <linux-mmc@vger.kernel.org>; Thu, 12 May 2011 09:13:09 +0000 (UTC)
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi all,
I just posted three patches to use get_cd to detect the card (somebody has saw them, But I didn't receive them from Linux-mmc, I don't know why):
[PATCH 1/3] SDHCI: add sdhci_get_cd callback to detect the card
[PATCH 2/3] MMC/SD: add callback function to detect card
[PATCH 3/3] SDHC/MMC: add f_min to mmc_power_on

I had posted them last year, but them were not accepted :(
Now I will express my reason to add this function and welcome give your comment.

"mmc_send_status" (that is used to check if the card has been removed, in file sd.c and mmc.c) will timeout when there is not SD/MMC card in slot, system will generate too many interrupts; even if the SD/MMC card present, there will generate many interrupts to return the card status from the SD/MMC card. Which will downgrade the performance of the system because system will take many time to handle these interrupts.
Therefore, I use the callback function "get_cd" to read the Present State register and check the bit CINS, if the SD card present, which will be 1, otherwise it will be 0.


Thanks and Best Regards
Jerry Huang



