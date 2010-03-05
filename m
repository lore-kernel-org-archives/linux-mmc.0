From: Philip Rakity <prakity@marvell.com>
Subject: RE: Bug in mmc.c  == stops eMMC toshiba from working - sector check
 not good
Date: Thu, 4 Mar 2010 21:05:14 -0800
Message-ID: <43E4817426ED174AA81263BCECB4351D1315CEEB24@sc-vexch3.marvell.com>
References: <43E4817426ED174AA81263BCECB4351D1315CEEB23@sc-vexch3.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia2.marvell.com ([65.219.4.35]:53237 "EHLO
	dakia2.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab0CEFFb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Mar 2010 00:05:31 -0500
Received: from maili.marvell.com (maili.marvell.com [10.68.76.51])
	by dakia2.marvell.com (Spam & Virus Firewall) with ESMTP id B6A4CA236D
	for <linux-mmc@vger.kernel.org>; Thu,  4 Mar 2010 21:05:30 -0800 (PST)
Received: from maili.marvell.com (maili.marvell.com [10.68.76.51]) by dakia2.marvell.com with ESMTP id H9SOt8mh0mQBCa7l for <linux-mmc@vger.kernel.org>; Thu, 04 Mar 2010 21:05:30 -0800 (PST)
Received: from MSI-MTA.marvell.com (msi-mta.marvell.com [10.68.76.91])
	by maili.marvell.com (Postfix) with ESMTP id 9AD588763D
	for <linux-mmc@vger.kernel.org>; Thu,  4 Mar 2010 21:05:30 -0800 (PST)
In-Reply-To: <43E4817426ED174AA81263BCECB4351D1315CEEB23@sc-vexch3.marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Lennert Buijtenhek <buytenh@marvell.com>, Nicolas Pitre <nico@marvell.com>, Philip Rakity <prakity@marvell.com>


________________________________________
From: Philip Rakity
Sent: Thursday, March 04, 2010 9:01 PM
To: linux-mmc@vger.kernel.org
Cc: Lennert Buijtenhek; Nicolas Pitre
Subject: Bug in mmc.c  == stops eMMC toshiba from working - sector check not good

Folks

Toshiba part eMMC -- 2GB fails in standard linux.  The part is NOT sector addressable yet linux tries to do this.  See incorrect code below in mmc.c and notes below

The tosbiha part HAS  ext_csd.sectors

from mmc.c
static int mmc_read_ext_csd(struct mmc_card *card)

if (card->ext_csd.rev >= 2) {
card->ext_csd.sectors =
ext_csd[EXT_CSD_SEC_CNT + 0] << 0 |
ext_csd[EXT_CSD_SEC_CNT + 1] << 8 |
ext_csd[EXT_CSD_SEC_CNT + 2] << 16 |
ext_csd[EXT_CSD_SEC_CNT + 3] << 24;
if (card->ext_csd.sectors)
mmc_card_set_blockaddr(card);
}

when set cause code in block.c to not make address byte oriented

static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
.....
                brq.cmd.arg = blk_rq_pos(req);
                if (!mmc_card_blockaddr(card))
                        brq.cmd.arg <<= 9;


The Toshiba card HAS ext_csd.sectors even though the CMD1 response says it does not do sector addressing -- returning the ocr register.

The Simplified Physical Layer Spec defines for the OCR register
bit 29 as reserved and bit 30 as CCS -- High Capacity Card

The JEDEC Standard No. 84-A43 defines the OCR register Table 31 (OCR Register)
bits 29 and 30
00 == byte mode
10 == sector mode


I can change the code to save the ocr on the CMD1 and use the value of bit 30 to select Sector Mode IF there is a sector table.

Are there any other thoughts ?

regards,

Philip
