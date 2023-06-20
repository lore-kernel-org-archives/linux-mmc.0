Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81883EB64DD
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Jun 2023 10:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjFTKrw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Jun 2023 06:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjFTKrr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2023 06:47:47 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1A1E72
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 03:47:45 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id B56D886346;
        Tue, 20 Jun 2023 12:47:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1687258064;
        bh=CScvQWUtkhOT9THcU2nJyb9WlpQlI0dStzbXsk/unfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HuHpPvj/2eUEQ9eY2iIMfOFtNz7XVgiw4YQ++HXE4lKdeE3Nm/q/C/Czc/RURWthi
         S31Q+waDw532p3dHCW7iDxSwnjHJjwWHg4AH/B4y0kF1zgQM7Evw98qqf4MqehTBNI
         R6g5v97YtG+xwfQK3PNlTDJM+yfnc1ayeoWtdMeBHgiFyJHtFbN1AjPwHjL1/mNVKF
         UV75sP98GSXHVTAtNoAhCKZ0Kt/AhdTP//ZFgdFvetJ+G5/PMONoJYCmjC7rgoydvj
         4E+2Lj3Lw0iVsHubfeyZweUnu2bsnFFiMqAGxgmMxjDdBDqhCPYZPIJbSkliwZvks4
         aL6J+8H4DghlQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-mmc@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>, Bo Liu <liubo03@inspur.com>,
        Deren Wu <deren.wu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pierre Ossman <pierre@ossman.eu>,
        Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH 07/11] mmc: mmci: Use BIT() macro
Date:   Tue, 20 Jun 2023 12:47:18 +0200
Message-Id: <20230620104722.16465-7-marex@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230620104722.16465-1-marex@denx.de>
References: <20230620104722.16465-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Use the BIT(n) macro instead of (1<<n), no functional change.
Regex 's@(1 \?<< \?\([0-9A-Z_]\+\))@BIT(\1)' .

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Avri Altman <avri.altman@wdc.com>
Cc: Bo Liu <liubo03@inspur.com>
Cc: Deren Wu <deren.wu@mediatek.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Pierre Ossman <pierre@ossman.eu>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-mmc@vger.kernel.org
---
 drivers/mmc/host/mmci.h | 170 ++++++++++++++++++++--------------------
 1 file changed, 85 insertions(+), 85 deletions(-)

diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index e1a9b96a3396f..d34e6020548c3 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -8,18 +8,18 @@
 #define MCI_PWR_OFF		0x00
 #define MCI_PWR_UP		0x02
 #define MCI_PWR_ON		0x03
-#define MCI_OD			(1 << 6)
-#define MCI_ROD			(1 << 7)
+#define MCI_OD			BIT(6)
+#define MCI_ROD			BIT(7)
 /*
  * The ST Micro version does not have ROD and reuse the voltage registers for
  * direction settings.
  */
-#define MCI_ST_DATA2DIREN	(1 << 2)
-#define MCI_ST_CMDDIREN		(1 << 3)
-#define MCI_ST_DATA0DIREN	(1 << 4)
-#define MCI_ST_DATA31DIREN	(1 << 5)
-#define MCI_ST_FBCLKEN		(1 << 7)
-#define MCI_ST_DATA74DIREN	(1 << 8)
+#define MCI_ST_DATA2DIREN	BIT(2)
+#define MCI_ST_CMDDIREN		BIT(3)
+#define MCI_ST_DATA0DIREN	BIT(4)
+#define MCI_ST_DATA31DIREN	BIT(5)
+#define MCI_ST_FBCLKEN		BIT(7)
+#define MCI_ST_DATA74DIREN	BIT(8)
 /*
  * The STM32 sdmmc does not have PWR_UP/OD/ROD
  * and uses the power register for
@@ -30,21 +30,21 @@
 #define MCI_STM32_DIRPOL	BIT(4)
 
 #define MMCICLOCK		0x004
-#define MCI_CLK_ENABLE		(1 << 8)
-#define MCI_CLK_PWRSAVE		(1 << 9)
-#define MCI_CLK_BYPASS		(1 << 10)
-#define MCI_4BIT_BUS		(1 << 11)
+#define MCI_CLK_ENABLE		BIT(8)
+#define MCI_CLK_PWRSAVE		BIT(9)
+#define MCI_CLK_BYPASS		BIT(10)
+#define MCI_4BIT_BUS		BIT(11)
 /*
  * 8bit wide buses, hardware flow contronl, negative edges and clock inversion
  * supported in ST Micro U300 and Ux500 versions
  */
-#define MCI_ST_8BIT_BUS		(1 << 12)
-#define MCI_ST_U300_HWFCEN	(1 << 13)
-#define MCI_ST_UX500_NEG_EDGE	(1 << 13)
-#define MCI_ST_UX500_HWFCEN	(1 << 14)
-#define MCI_ST_UX500_CLK_INV	(1 << 15)
+#define MCI_ST_8BIT_BUS		BIT(12)
+#define MCI_ST_U300_HWFCEN	BIT(13)
+#define MCI_ST_UX500_NEG_EDGE	BIT(13)
+#define MCI_ST_UX500_HWFCEN	BIT(14)
+#define MCI_ST_UX500_CLK_INV	BIT(15)
 /* Modified PL180 on Versatile Express platform */
-#define MCI_ARM_HWFCEN		(1 << 12)
+#define MCI_ARM_HWFCEN		BIT(12)
 
 /* Modified on Qualcomm Integrations */
 #define MCI_QCOM_CLK_WIDEBUS_8	(BIT(10) | BIT(11))
@@ -65,7 +65,7 @@
 #define MCI_STM32_CLK_BUSSPEED		BIT(19)
 #define MCI_STM32_CLK_SEL_MSK		GENMASK(21, 20)
 #define MCI_STM32_CLK_SELCK		(0 << 20)
-#define MCI_STM32_CLK_SELCKIN		(1 << 20)
+#define MCI_STM32_CLK_SELCKIN		BIT(20)
 #define MCI_STM32_CLK_SELFBCK		(2 << 20)
 
 #define MMCIARGUMENT		0x008
@@ -95,7 +95,7 @@
 #define MCI_CPSM_STM32_CMDSTOP		BIT(7)
 #define MCI_CPSM_STM32_WAITRESP_MASK	GENMASK(9, 8)
 #define MCI_CPSM_STM32_NORSP		(0 << 8)
-#define MCI_CPSM_STM32_SRSP_CRC		(1 << 8)
+#define MCI_CPSM_STM32_SRSP_CRC		BIT(8)
 #define MCI_CPSM_STM32_SRSP		(2 << 8)
 #define MCI_CPSM_STM32_LRSP_CRC		(3 << 8)
 #define MCI_CPSM_STM32_ENABLE		BIT(12)
@@ -130,90 +130,90 @@
 #define MCI_DPSM_QCOM_RX_DATA_PEND BIT(20)
 /* Control register extensions in STM32 versions */
 #define MCI_DPSM_STM32_MODE_BLOCK	(0 << 2)
-#define MCI_DPSM_STM32_MODE_SDIO	(1 << 2)
+#define MCI_DPSM_STM32_MODE_SDIO	BIT(2)
 #define MCI_DPSM_STM32_MODE_STREAM	(2 << 2)
 #define MCI_DPSM_STM32_MODE_BLOCK_STOP	(3 << 2)
 
 #define MMCIDATACNT		0x030
 #define MMCISTATUS		0x034
-#define MCI_CMDCRCFAIL		(1 << 0)
-#define MCI_DATACRCFAIL		(1 << 1)
-#define MCI_CMDTIMEOUT		(1 << 2)
-#define MCI_DATATIMEOUT		(1 << 3)
-#define MCI_TXUNDERRUN		(1 << 4)
-#define MCI_RXOVERRUN		(1 << 5)
-#define MCI_CMDRESPEND		(1 << 6)
-#define MCI_CMDSENT		(1 << 7)
-#define MCI_DATAEND		(1 << 8)
-#define MCI_STARTBITERR		(1 << 9)
-#define MCI_DATABLOCKEND	(1 << 10)
-#define MCI_CMDACTIVE		(1 << 11)
-#define MCI_TXACTIVE		(1 << 12)
-#define MCI_RXACTIVE		(1 << 13)
-#define MCI_TXFIFOHALFEMPTY	(1 << 14)
-#define MCI_RXFIFOHALFFULL	(1 << 15)
-#define MCI_TXFIFOFULL		(1 << 16)
-#define MCI_RXFIFOFULL		(1 << 17)
-#define MCI_TXFIFOEMPTY		(1 << 18)
-#define MCI_RXFIFOEMPTY		(1 << 19)
-#define MCI_TXDATAAVLBL		(1 << 20)
-#define MCI_RXDATAAVLBL		(1 << 21)
+#define MCI_CMDCRCFAIL		BIT(0)
+#define MCI_DATACRCFAIL		BIT(1)
+#define MCI_CMDTIMEOUT		BIT(2)
+#define MCI_DATATIMEOUT		BIT(3)
+#define MCI_TXUNDERRUN		BIT(4)
+#define MCI_RXOVERRUN		BIT(5)
+#define MCI_CMDRESPEND		BIT(6)
+#define MCI_CMDSENT		BIT(7)
+#define MCI_DATAEND		BIT(8)
+#define MCI_STARTBITERR		BIT(9)
+#define MCI_DATABLOCKEND	BIT(10)
+#define MCI_CMDACTIVE		BIT(11)
+#define MCI_TXACTIVE		BIT(12)
+#define MCI_RXACTIVE		BIT(13)
+#define MCI_TXFIFOHALFEMPTY	BIT(14)
+#define MCI_RXFIFOHALFFULL	BIT(15)
+#define MCI_TXFIFOFULL		BIT(16)
+#define MCI_RXFIFOFULL		BIT(17)
+#define MCI_TXFIFOEMPTY		BIT(18)
+#define MCI_RXFIFOEMPTY		BIT(19)
+#define MCI_TXDATAAVLBL		BIT(20)
+#define MCI_RXDATAAVLBL		BIT(21)
 /* Extended status bits for the ST Micro variants */
-#define MCI_ST_SDIOIT		(1 << 22)
-#define MCI_ST_CEATAEND		(1 << 23)
-#define MCI_ST_CARDBUSY		(1 << 24)
+#define MCI_ST_SDIOIT		BIT(22)
+#define MCI_ST_CEATAEND		BIT(23)
+#define MCI_ST_CARDBUSY		BIT(24)
 /* Extended status bits for the STM32 variants */
 #define MCI_STM32_BUSYD0	BIT(20)
 #define MCI_STM32_BUSYD0END	BIT(21)
 #define MCI_STM32_VSWEND	BIT(25)
 
 #define MMCICLEAR		0x038
-#define MCI_CMDCRCFAILCLR	(1 << 0)
-#define MCI_DATACRCFAILCLR	(1 << 1)
-#define MCI_CMDTIMEOUTCLR	(1 << 2)
-#define MCI_DATATIMEOUTCLR	(1 << 3)
-#define MCI_TXUNDERRUNCLR	(1 << 4)
-#define MCI_RXOVERRUNCLR	(1 << 5)
-#define MCI_CMDRESPENDCLR	(1 << 6)
-#define MCI_CMDSENTCLR		(1 << 7)
-#define MCI_DATAENDCLR		(1 << 8)
-#define MCI_STARTBITERRCLR	(1 << 9)
-#define MCI_DATABLOCKENDCLR	(1 << 10)
+#define MCI_CMDCRCFAILCLR	BIT(0)
+#define MCI_DATACRCFAILCLR	BIT(1)
+#define MCI_CMDTIMEOUTCLR	BIT(2)
+#define MCI_DATATIMEOUTCLR	BIT(3)
+#define MCI_TXUNDERRUNCLR	BIT(4)
+#define MCI_RXOVERRUNCLR	BIT(5)
+#define MCI_CMDRESPENDCLR	BIT(6)
+#define MCI_CMDSENTCLR		BIT(7)
+#define MCI_DATAENDCLR		BIT(8)
+#define MCI_STARTBITERRCLR	BIT(9)
+#define MCI_DATABLOCKENDCLR	BIT(10)
 /* Extended status bits for the ST Micro variants */
-#define MCI_ST_SDIOITC		(1 << 22)
-#define MCI_ST_CEATAENDC	(1 << 23)
-#define MCI_ST_BUSYENDC		(1 << 24)
+#define MCI_ST_SDIOITC		BIT(22)
+#define MCI_ST_CEATAENDC	BIT(23)
+#define MCI_ST_BUSYENDC		BIT(24)
 /* Extended clear bits for the STM32 variants */
 #define MCI_STM32_VSWENDC	BIT(25)
 #define MCI_STM32_CKSTOPC	BIT(26)
 
 #define MMCIMASK0		0x03c
-#define MCI_CMDCRCFAILMASK	(1 << 0)
-#define MCI_DATACRCFAILMASK	(1 << 1)
-#define MCI_CMDTIMEOUTMASK	(1 << 2)
-#define MCI_DATATIMEOUTMASK	(1 << 3)
-#define MCI_TXUNDERRUNMASK	(1 << 4)
-#define MCI_RXOVERRUNMASK	(1 << 5)
-#define MCI_CMDRESPENDMASK	(1 << 6)
-#define MCI_CMDSENTMASK		(1 << 7)
-#define MCI_DATAENDMASK		(1 << 8)
-#define MCI_STARTBITERRMASK	(1 << 9)
-#define MCI_DATABLOCKENDMASK	(1 << 10)
-#define MCI_CMDACTIVEMASK	(1 << 11)
-#define MCI_TXACTIVEMASK	(1 << 12)
-#define MCI_RXACTIVEMASK	(1 << 13)
-#define MCI_TXFIFOHALFEMPTYMASK	(1 << 14)
-#define MCI_RXFIFOHALFFULLMASK	(1 << 15)
-#define MCI_TXFIFOFULLMASK	(1 << 16)
-#define MCI_RXFIFOFULLMASK	(1 << 17)
-#define MCI_TXFIFOEMPTYMASK	(1 << 18)
-#define MCI_RXFIFOEMPTYMASK	(1 << 19)
-#define MCI_TXDATAAVLBLMASK	(1 << 20)
-#define MCI_RXDATAAVLBLMASK	(1 << 21)
+#define MCI_CMDCRCFAILMASK	BIT(0)
+#define MCI_DATACRCFAILMASK	BIT(1)
+#define MCI_CMDTIMEOUTMASK	BIT(2)
+#define MCI_DATATIMEOUTMASK	BIT(3)
+#define MCI_TXUNDERRUNMASK	BIT(4)
+#define MCI_RXOVERRUNMASK	BIT(5)
+#define MCI_CMDRESPENDMASK	BIT(6)
+#define MCI_CMDSENTMASK		BIT(7)
+#define MCI_DATAENDMASK		BIT(8)
+#define MCI_STARTBITERRMASK	BIT(9)
+#define MCI_DATABLOCKENDMASK	BIT(10)
+#define MCI_CMDACTIVEMASK	BIT(11)
+#define MCI_TXACTIVEMASK	BIT(12)
+#define MCI_RXACTIVEMASK	BIT(13)
+#define MCI_TXFIFOHALFEMPTYMASK	BIT(14)
+#define MCI_RXFIFOHALFFULLMASK	BIT(15)
+#define MCI_TXFIFOFULLMASK	BIT(16)
+#define MCI_RXFIFOFULLMASK	BIT(17)
+#define MCI_TXFIFOEMPTYMASK	BIT(18)
+#define MCI_RXFIFOEMPTYMASK	BIT(19)
+#define MCI_TXDATAAVLBLMASK	BIT(20)
+#define MCI_RXDATAAVLBLMASK	BIT(21)
 /* Extended status bits for the ST Micro variants */
-#define MCI_ST_SDIOITMASK	(1 << 22)
-#define MCI_ST_CEATAENDMASK	(1 << 23)
-#define MCI_ST_BUSYENDMASK	(1 << 24)
+#define MCI_ST_SDIOITMASK	BIT(22)
+#define MCI_ST_CEATAENDMASK	BIT(23)
+#define MCI_ST_BUSYENDMASK	BIT(24)
 /* Extended status bits for the STM32 variants */
 #define MCI_STM32_BUSYD0ENDMASK	BIT(21)
 
-- 
2.39.2

