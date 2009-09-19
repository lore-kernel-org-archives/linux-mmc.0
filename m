From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: [PATCH  RFC] MMC card of Size > 4GB support in Linu
Date: Sat, 19 Sep 2009 17:52:23 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B02F64D8199@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43929 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751154AbZISMWq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Sep 2009 08:22:46 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Pierre Ossman <pierre@ossman.eu>
Cc: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "Benjamin.Telya@sandisk.com" <Benjamin.Telya@sandisk.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Kamat, Nishant" <nskamat@ti.com>

Pierre & all,

This is the email continuing the discussion about the 4GB MMC card support in Linux MMC/SD driver. Note that the discussion is for MMC card only, not for SD card.

There are two register as below are used to check the card capability including size of the Card.

1. The Card-Specific Data (CSD) register defines the data format, error correction type, maximum data access time, data transfer speed etc. used for how to access the card contents.

2.  And Extended CSD register (EXT_CSD: 512 bytes long) defines the card capabilities and cannot be modified by the host.
    This EXT_CSD is supported by MMC card only (not for SD).

I). How to check the card Size?
The Card size (C_SIZE) in CSD register used to compute the card capacity. And the maximal capacity which can be coded is 4 GBytes. But higher than 2GB of density of card the maximum possible value should be set to this register (0xFFF). 

II). How to check whether is card is >=4GBytes size?
We could check in access mode from OCR register and/or read the EXT_CSD register.  Check the SEC_COUNT filed in EXT_CSD register.
The device density is calculated from the value of SEC_COUNT and multiplying by 512B/sector. The maximum density possible to be indicated is thus 2 Tera bytes.

III). So we need to check / validate the response from card for CSD and EXT_CSD register.
Two of the fields in CSD Structure Version (CSD_STRUCTURE) and Extended CSD Revision (EXT_CSD_REV) and the details of the bit filed as follows. 
i.e. CSD_STRUCTURE should be >= 2 support card more than 4GB and EXT_CSD_REV should be <3; 

CSD_STRUCTURE| CSD structure version| Valid for System Specification Ver
------------------------------------------------------------------------
        0    | CSD version No. 1.0  | Version 1.0 - 1.2
        1    | CSD version No. 1.1  | Version 1.4 - 2.2
        2    | CSD version No. 1.2  | Version 3.1 - 3.2-3.31 - 4.0-4.1-4.2
      3-255  | Reserved for future use

EXT_CSD_REV  | Extended CSD Revision
-------------------------------------
       255-3 | Reserved 
           2 | Revision 1.2 
           1 | Revision 1.1 
           0 | Revision 1.0

IV). And what I understood from MMCA specification is that - 
EXT_CSD[EXT_CSD_REV]: Defines the fixed parameters and related to the EXT_CSD register, according to its revision. And it's nothing to do with MMCA specification version or to support > 4GB card.

V). But in current Linux MMC code it's expecting EXT_CSD_REV should be >=2; 
And if any card of size >= 4GB and EXT_CSD_REV field value is <2, 
And MMC card won't work.

I have seen cards which having EXT_CSD_REV is <2 and working in other OS.
So, Here I am sending the possible solution. `

----------------------------------------------------------------------------
>From 42d081b0db15c2a7923b16e5fa02eec6fb77c387 Mon Sep 17 00:00:00 2001
From: Sukumar Ghorai <s-ghorai@ti.com>
Date: Mon, 14 Sep 2009 14:28:01 +0530
Subject: [PATCH] There is small problem to support the MMC card >4 GByte.

EXT_CSD_REV could be any value <=2 and are valid as per MMCA Specification. And it was checking for CSD_STRUCTURE filed of EXT_CSD register.

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 drivers/mmc/core/mmc.c  |    2 +-
 include/linux/mmc/mmc.h |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 06084db..7b22a2e 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -216,7 +216,7 @@ static int mmc_read_ext_csd(struct mmc_card *card)
                goto out;
        }

-       if (ext_csd_struct >= 2) {
+       if (ext_csd[EXT_CSD_STRUCT_REV] >= 2) {
                card->ext_csd.sectors =
                        ext_csd[EXT_CSD_SEC_CNT + 0] << 0 |
                        ext_csd[EXT_CSD_SEC_CNT + 1] << 8 |
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 14b81f3..c4e97a9 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -252,6 +252,7 @@ struct _mmc_csd {
 #define EXT_CSD_BUS_WIDTH      183     /* R/W */
 #define EXT_CSD_HS_TIMING      185     /* R/W */
 #define EXT_CSD_CARD_TYPE      196     /* RO */
+#define EXT_CSD_STRUCT_REV 194     /* RO */
 #define EXT_CSD_REV            192     /* RO */
 #define EXT_CSD_SEC_CNT                212     /* RO, 4 bytes */

--
1.5.4.7

Thanks Regards,
Ghorai

