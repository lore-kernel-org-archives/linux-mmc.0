Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B691C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Dec 2021 04:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhLUEJ7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Dec 2021 23:09:59 -0500
Received: from mail-bn8nam11on2100.outbound.protection.outlook.com ([40.107.236.100]:36577
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231712AbhLUEJ6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Dec 2021 23:09:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELUB9WgMDhZt5IZdYwELUzqZxb5r28MnmnDjVLW729vbTs6UrtTpKuyUYzDEs5qD+784rtV0qB2DP0nTwdksrUqH/TYROO9AlPYmbch02kjMj7xwhCwSiA/60v/8ZMWfYef14a/Wx3vbpxIrV6b77JIRDacsG7mRus+RsxeP80f8nAb/3vRUlGD8m8i6IjwODQaDfxBJdKZuCvaCicPJdNELsxFtSqCZpFnWZ56ptBfq33QPvEihiXCN5noX3OiRP+fh7qs0MWC/Q9nfuSUndVAt9ae6dLq6gSC2quj8uGPqIIikx5kPHL1zw16v/4RbTfpx1OJMTIyik2KTfW1jxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ANEcc8lAJ13mowZlOoMDFd7L9cCKh82mpjlch0K4cI=;
 b=Pwj+2RtUx47L4TXEpGzs2d2XKmsoxr4ZjNCo/GHtL+ZEd35JeDpL7rYDnNTZsebZPwoYTgheGJJBeNw/GcfuGPfOt828dmJqkBi+5SpAiGexfPgl0Rfa92Kxgqk+O1CdEE2sjLu7OOhOOHoxoKnB8ehSwPkfifx9aZjkFU4Xw9yWMYAJomxVDVuXtG+HOGS7ovy4R2NBg5TKWIGkDfm/sEuaC/LtkNZxaqL51Wt1H+tWRbBcRnp9MIzaeWTv8qRLhpMVajzhglGfwrSPEW+g7Pmw3Ek76pkVhpNY+sB7kqTe+bk5K+5k9ikITEAUtqMVBPQfJNoY+F27M3bu/ayKjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ANEcc8lAJ13mowZlOoMDFd7L9cCKh82mpjlch0K4cI=;
 b=G9trI8C6uqkYx2CqkAI6/davRwkOGy2sPCODwzYFi1SxJsDVmZU9Pd29K1X8E38Qy845o1JNk8Ox6VLAqKGHCrtQvYBCdx1ZqhLqcs59+Xjm4Yf/G9Mpk6ap5I+w2WfEo0E4xPz1Am57WhUylejpzIPFAxXJCdTF+pQrZ2YgLGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
Received: from BL3PR16MB4570.namprd16.prod.outlook.com (2603:10b6:208:349::24)
 by BL3PR16MB4370.namprd16.prod.outlook.com (2603:10b6:208:351::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Tue, 21 Dec
 2021 04:09:55 +0000
Received: from BL3PR16MB4570.namprd16.prod.outlook.com
 ([fe80::5899:464c:e5ea:4746]) by BL3PR16MB4570.namprd16.prod.outlook.com
 ([fe80::5899:464c:e5ea:4746%2]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 04:09:55 +0000
From:   fred <fred.ai@bayhubtech.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, chevron.li@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com,
        fred.ai@bayhubtech.com
Subject: [PATCH V4 1/2] mmc:sdhci-pci-o2micro:Improve card input timing at SDR104/HS200 mode
Date:   Mon, 20 Dec 2021 20:09:40 -0800
Message-Id: <20211221040940.484-1-fred.ai@bayhubtech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0008.apcprd03.prod.outlook.com
 (2603:1096:202::18) To BL3PR16MB4570.namprd16.prod.outlook.com
 (2603:10b6:208:349::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc204996-10db-4acf-296a-08d9c437be5b
X-MS-TrafficTypeDiagnostic: BL3PR16MB4370:EE_
X-Microsoft-Antispam-PRVS: <BL3PR16MB4370857A84B770636D4C7EF4997C9@BL3PR16MB4370.namprd16.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZX2iQ1CoxxvxsG/Uq5SKLZu8lpnthJ+S4gAOfi5bGzaiXalLw9gLRZjBclnrgXooN1ncNEnd5lCYMUzPenYOeEaipVKNHtytwnbSDeD1nTz5rxzVYVVusT1OYNF25Jn7hrXXG9//wptUK1M8bD0LwB2saqaHKsUiOwXGEExRCoLnksoFi0pcy7/yShZ+llSRNxa8JPFiO79cIa2T5+1yvhtMKPR2CEzBN0pCbNiLy8hThAC6y87OCXYH3Jg8c3XgPN+xMyA0d52o95L2Bq7sim1J+vgTLgw1rGEW0WZ+CpBE8Ismoy7yhvstaRej3+fwmMFUuTvJsEdz1tT5C3uKjF5wnF1Tuo+Wi0tF+WCPs9A5DqYCAKVjoKsG9nn7OuNJ4+25fs9kFKa5NrLXc9SCGIrX5izhOn8QC7Le3dik91AjtCgpyWGoBoUOTwAiy3o3pGPInaDv0wmC64oSnhW2cXAW6ufMZQ4e1/LJ6xTvfwQK25iegHZWB+D8gpaBGPpUG6ozfivUfIR9VBPBmNDwYke0SClwUDRJMuGWlxlEM52VX9OMdMrKsYzvMCEDy2151hh7TxulwxWMsymsxtbNudI3CEEmsiZrrBrfq2bEUyHVD0ptS+ZAkMfGxKZYwc1a9hOpvJh8+JWUZZj+XK26Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR16MB4570.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(39840400004)(376002)(66556008)(66476007)(83380400001)(2616005)(66946007)(86362001)(107886003)(6486002)(316002)(508600001)(2906002)(8936002)(4326008)(1076003)(36756003)(6666004)(5660300002)(52116002)(6506007)(38100700002)(8676002)(6512007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BktdcblnoxjIh7wtegLtw7ILw8UhzbpzCiqGeknHoc33G8ePkon5sx9HaKWS?=
 =?us-ascii?Q?k3G21yFKYQZ8sVIUrGLn2GXlkMyqiIRq7d5tt5si7Su173SKFNzzG/J/qH1O?=
 =?us-ascii?Q?ZFbGCvsoE0ScrLbVAdtnu7Lys7HHe+Ps0xFe4d/oErkh//WDadav41emTED9?=
 =?us-ascii?Q?SZgD0qcFRBNDskVnD6LMqjg1cCcFk2X6PofeicR6lK6cQ/rEMETU+JZr67za?=
 =?us-ascii?Q?kjQCI+wZG/Sd6h78OgQCkx9MfK5EOP4XUNLPletSpFGTYolyXn1T8ZCuSRSI?=
 =?us-ascii?Q?KInDdUL2rF6OA4IOaAP95YV9bNXk595/dUu3l2naphLIco0nU46qo3pX+CFO?=
 =?us-ascii?Q?IE3dFQ3l3yBmYksfrt72vc7eOye0CEtGygIqVH7fyeaLSLMeE4A5xM80al7F?=
 =?us-ascii?Q?SvQxi0rIeyghgmum1t8c4AYOJLIQ9NAsM3UWwfpTwB2RXARjBm4flkpjfmho?=
 =?us-ascii?Q?Rrq8zTKse+ghAQYL2ohoySF97wSFzTbnbQcvaMpap6TayjUTesp9ep2lEAdB?=
 =?us-ascii?Q?lJQSFhpvYcT1j3lZRFbGNz48tA4dGJx2zTNtjDg+Qy9fT3aRHWig1O1aO2LY?=
 =?us-ascii?Q?LrwiPeAEkLChDWnGV9HC9QRDjpkNO4Hxsuoz9aBzut4VMo/LwBaxn46VNYVz?=
 =?us-ascii?Q?LGGQ1rDsMkiF98kW8/fKWB9L+AXeyxN4zq8ZKYDWazyKJ4E0yD04Hfzfzkqr?=
 =?us-ascii?Q?x62AJ/e76db9hR/ZXfGkYm+796Fiuf41NEAeAkAXBSjNMoY6S78E10QQH3rZ?=
 =?us-ascii?Q?ADkKzTgwULNLwOWEm9No9Obya94L4U13BksaQ0bSn3QOsoSW6U0n28ioC5n/?=
 =?us-ascii?Q?oaBfRK3WBqIn65CWa3yJ9yDVR5YTNbrrV/mqziYf2U2E8PntUu4qWJn2xQJA?=
 =?us-ascii?Q?pg4TGJoXKobQql+bC3BEyLH9NLm5TCXaBYRRmoph+8JtVjUp1xfsl4z1ctQj?=
 =?us-ascii?Q?JsR/y04e44upGFS3YbOnwhNBO685FbnE4v6iLw2YMgRZjllGVgbS6bpP7f0x?=
 =?us-ascii?Q?mUaeFFZ98K32g3sZPRz8l6Q+F5qvC3Ces2/68CmrHoEhti/9zhj90sDK3N//?=
 =?us-ascii?Q?v+2f7MQGPF8UKXrjxgSlcvD4w+pwZyR1s10oq4mRk8nLlOHGI4t9bi/UePE8?=
 =?us-ascii?Q?1LeoptzsqZP0kf3vOCUxgoDMPKNWzSOAOLOlFo4PkWPhpaLE2ni1B04zI+AJ?=
 =?us-ascii?Q?C3LyAOHPtznQDMvlQR9tOqNkzp7ANiRARk+nA7LiFwsOwSv3/nOhr0K94Up5?=
 =?us-ascii?Q?536vH/4RRkEU+jmdqfahmm5kwra/B1+E3T99hjibXvs6iPRQP2d2oOdjvM1c?=
 =?us-ascii?Q?9TtzkrxKvsk341Q6UkHDsb/DE8AD0xwc148qktLNrkVJ2qtll9F1e+7sMexp?=
 =?us-ascii?Q?m0aXLI7Q+ZhR7u5dMXAQOzSRsBFuY8M5xwZfAvYhyN6HR+a6UTGCsoTMr5Mb?=
 =?us-ascii?Q?2633aLnb1KHy1V+Vtu5mxUAlv5jf2XAIYUjdqmL8okhHsuv0GB9iTaSx7p24?=
 =?us-ascii?Q?jGn7rw8JrUdYB43hHF+xxlR8+PufUukP98C8MF8PwrroQ4K+G4xwmvZ5CG6h?=
 =?us-ascii?Q?0N3ZIcMcMYozc3erVlzklT4ed1PubAVcU59z3RsWn+QFu1BGWeLGEs7JI7jh?=
 =?us-ascii?Q?Je9HDVjuZR4pn5p4ZJ5QSJV6lk7LLPE5BOR3o8AV8utm+PWvg4rZ/xFephIV?=
 =?us-ascii?Q?AicibuP+2LklLynI3uKujYjTdUU=3D?=
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc204996-10db-4acf-296a-08d9c437be5b
X-MS-Exchange-CrossTenant-AuthSource: BL3PR16MB4570.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 04:09:54.9119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKSZBbQ+1U2FCIO5Ri8YH+7tXGY8wb4izYG3J8no1hh9yfh7DPyQrChY/PPqyknbo4lw8XiMUDet3WfIw2Zw/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR16MB4370
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Fred Ai <fred.ai@bayhubtech.com>

Card input timing is margin, need to adjust the hold timing of card input.

Signed-off-by: Fred Ai <fred.ai@bayhubtech.com>
---
Change in V4:
1.Select suit DLL phase's output clock as SD interface clock at SDR104/HS200 mode.
2.Deselect DLL output phase as SD interface clock before next card initialization.
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 57 +++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index f045c1ee4667..56e9f93999c4 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -12,6 +12,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
+#include <linux/bitfield.h>
 
 #include "sdhci.h"
 #include "sdhci-pci.h"
@@ -43,12 +44,16 @@
 #define O2_SD_CAP_REG0		0x334
 #define O2_SD_UHS1_CAP_SETTING	0x33C
 #define O2_SD_DELAY_CTRL	0x350
+#define O2_SD_OUTPUT_CLK_SOURCE_SWITCH	0x354
 #define O2_SD_UHS2_L1_CTRL	0x35C
 #define O2_SD_FUNC_REG3		0x3E0
 #define O2_SD_FUNC_REG4		0x3E4
 #define O2_SD_LED_ENABLE	BIT(6)
 #define O2_SD_FREG0_LEDOFF	BIT(13)
+#define O2_SD_SEL_DLL		BIT(16)
 #define O2_SD_FREG4_ENABLE_CLK_SET	BIT(22)
+#define O2_SD_PHASE_MASK	GENMASK(23, 20)
+#define O2_SD_FIX_PHASE		FIELD_PREP(O2_SD_PHASE_MASK, 0x9)
 
 #define O2_SD_VENDOR_SETTING	0x110
 #define O2_SD_VENDOR_SETTING2	0x1C8
@@ -301,9 +306,13 @@ static int sdhci_o2_dll_recovery(struct sdhci_host *host)
 static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct sdhci_pci_chip *chip = slot->chip;
 	int current_bus_width = 0;
 	u32 scratch32 = 0;
 	u16 scratch = 0;
+	u8  scratch_8 = 0;
+	u32 reg_val;
 
 	/*
 	 * This handler only implements the eMMC tuning that is specific to
@@ -322,6 +331,32 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	scratch |= O2_SD_PWR_FORCE_L0;
 	sdhci_writew(host, scratch, O2_SD_MISC_CTRL);
 
+	/* Stop clk */
+	reg_val = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	reg_val &= ~SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
+
+	/* UnLock WP */
+	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
+	scratch_8 &= 0x7f;
+	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
+
+	/* Set pcr 0x354[16] to choose dll clock, and set the default phase */
+	pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &reg_val);
+	reg_val &= ~(O2_SD_SEL_DLL | O2_SD_PHASE_MASK);
+	reg_val |= (O2_SD_SEL_DLL | O2_SD_FIX_PHASE);
+	pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, reg_val);
+
+	/* Lock WP */
+	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
+	scratch_8 |= 0x80;
+	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
+
+	/* Start clk */
+	reg_val = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	reg_val |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
+
 	/* wait DLL lock, timeout value 5ms */
 	if (readx_poll_timeout(sdhci_o2_pll_dll_wdt_control, host,
 		scratch32, (scratch32 & O2_DLL_LOCK_STATUS), 1, 5000))
@@ -533,22 +568,26 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
 	if (clock == 0)
 		return;
 
-	if ((host->timing == MMC_TIMING_UHS_SDR104) && (clock == 200000000)) {
-		pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
-
-		scratch &= 0x7f;
-		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
+	/* UnLock WP */
+	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
+	scratch &= 0x7f;
+	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
 
+	if ((host->timing == MMC_TIMING_UHS_SDR104) && (clock == 200000000)) {
 		pci_read_config_dword(chip->pdev, O2_SD_PLL_SETTING, &scratch_32);
 
 		if ((scratch_32 & 0xFFFF0000) != 0x2c280000)
 			o2_pci_set_baseclk(chip, 0x2c280000);
+	}
 
-		pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
+	pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &scratch_32);
+	scratch_32 &= ~(O2_SD_SEL_DLL | O2_SD_PHASE_MASK);
+	pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, scratch_32);
 
-		scratch |= 0x80;
-		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
-	}
+	/* Lock WP */
+	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
+	scratch |= 0x80;
+	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
 
 	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
 	sdhci_o2_enable_clk(host, clk);
-- 
2.32.0

