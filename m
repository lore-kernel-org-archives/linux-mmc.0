Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A39C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Dec 2021 06:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbhLPGIo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Dec 2021 01:08:44 -0500
Received: from mail-bn7nam10on2110.outbound.protection.outlook.com ([40.107.92.110]:49249
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231406AbhLPGIo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 16 Dec 2021 01:08:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElZ10oXsoPf8DpnGhSI7cuz0GQuBKm8lTW2aieth8yKSm7yn3dS1VM/IhgBdp1+bIkPrsbUZioU2NVmCFp4mZzAXBTAN3xq21Kj/+Mvh22gOAOiuATj5Ftoh4WHOFWb6IO7JdRf1VoQPG/O/3V9bcMJgGijrLVqm23paaX7/OveOI13LgbEiNEonBL+7qAgq6vZ8RCC4C3F3iEejchQbZDhswxEX48cVP+Ade9nMzvxe6J/xxej28RTHAYt/wLE7MHlINphzCnzcc7RJbXOMnsbapWACx9oIpafbknQsVJKVVh5IDpWCNyvq4uGrP4ns0hY79/RR+7W9qbfjMCnNSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBu6wr49wKOLYP8eqq0Mg8RxorY1eYQD2qpcR5jnN68=;
 b=DsSgIBpbMDHUo8lVhWbCYRcdQtYPPPnn9gJSioIqqTupMdeFni+6kXihgvz8C82fi+6PvOs/A8rkvsNfTYwPm7eevRI8qJ9FdXP5X0V2T10xBM/jw0yMjvqRWoo0gl2ID2N1C8BOHr+yIlDjNCEdqb+ihXa0C+n84UGrjcxoOw7SZJ72rBx587wu8umq+YXYS/FukQe5aXwXzHyBHjnQ7/TF1+F8wsbJ3ti14wZmqtYLNbOG3CZ5evzym0I/2bLdv1u1Kd80w6OaGk1CLsc7AKsgDAIUFDKhCKkV6Ia6kyb87XPoOITh46x/7XFa+DYTiLQ1Cr7iPTh5ynccLvHcfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBu6wr49wKOLYP8eqq0Mg8RxorY1eYQD2qpcR5jnN68=;
 b=WP1oy1hs5cua/+3LLSaZrXBKRYqRzrm5kzdGbU1cDHwAQPys8yzUU/nMLPuj5ODUf3hE8+6wZnDzl2W1of52RiukFFuAutMCh8Lb6oGVz/JJjaloAMsHVauCNRRSQB2ZDfuXyXXl4x59enj+oOssKkzc7+/X6DJkvDAaPByKibw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
Received: from BL3PR16MB4570.namprd16.prod.outlook.com (2603:10b6:208:349::24)
 by BL3PR16MB4556.namprd16.prod.outlook.com (2603:10b6:208:34b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 06:08:38 +0000
Received: from BL3PR16MB4570.namprd16.prod.outlook.com
 ([fe80::9597:403c:22ad:5479]) by BL3PR16MB4570.namprd16.prod.outlook.com
 ([fe80::9597:403c:22ad:5479%9]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 06:08:38 +0000
From:   fred <fred.ai@bayhubtech.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, chevron.li@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com,
        fred.ai@bayhubtech.com
Subject: [PATCH V3 1/2] mmc:sdhci-pci-o2micro:Improve card input timing at SDR104/HS200 mode
Date:   Wed, 15 Dec 2021 22:08:23 -0800
Message-Id: <20211216060824.357-1-fred.ai@bayhubtech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0066.apcprd03.prod.outlook.com
 (2603:1096:202:17::36) To BL3PR16MB4570.namprd16.prod.outlook.com
 (2603:10b6:208:349::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1434616b-0be3-4e2a-2e5c-08d9c05a8012
X-MS-TrafficTypeDiagnostic: BL3PR16MB4556:EE_
X-Microsoft-Antispam-PRVS: <BL3PR16MB4556887010C0C69725C4A47F99779@BL3PR16MB4556.namprd16.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Q8oSpJT4iu4Yhzb4B0XKXDYRdDnmhlma2PJqkbALMY3Nk+2ZGc4+JBfU3hW1cb+q+Z4NdpJkmeBvOe9xSctK2noHuvRm76lcfNoVwFXCbujN5uUEE5kpl5UPeTJD/nQKLNPByXqoL9iG3Z2AqGf0tBGFNEaxQ+MPgcwPgxdQIkxZimISwTkvCSWDN3yAlGfAvoQMuC3kOoACo3fQDt6NWsWUdQKhlujCbLFZWvX2adnzn8v9nqMvTrektHj+48IuE+8ITrvIhhFMUYU4yP2M4TJdahiQH8X7sbw8MFFfeXzqXbrQ5vnhzLLcFuTYNPVoR/jb5RkI/bpMzk3nAgfevgb5jY/n6nPyE1B2LOFFytKmdy5SNNcYFVTPm8v6aOXykuRg15pqtnFkPqqkMFoRxuHwsiHMz6UdOITahPTgoWI6Hna897YknQwCsMtOJYByWs5B3mtOPZqCBghX3uDEFxfa0UjD6Pv+hyyB7cHcgCBotf26WAdnu4AOOaFn1Jnrvdt5JEzoJucsrVMm2ewuCEPoqchLzn9oFT6Wpfy5QeW9MW9sYvXyWaYGGTveuNxgJf2V9IaLQOd8mSWBpod+zCARk3ILluqzN5wGwFV+mohOzU56rfoPUtMu9qGCtWEWWZhXzBIWg8dRoC/BfTmcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR16MB4570.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(39830400003)(376002)(366004)(316002)(186003)(38100700002)(2906002)(8936002)(1076003)(508600001)(107886003)(66946007)(8676002)(83380400001)(66476007)(66556008)(52116002)(36756003)(4326008)(6666004)(5660300002)(6486002)(2616005)(6512007)(6506007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xnNkRHBpaTi/3r/p0totEAZb3jdhhsZC5htELiT0gaGUt45o4Een7QzmB9pC?=
 =?us-ascii?Q?f6yay+GkkAorAR1NzbUYyKihvlbP5LUabrQJUviIbWP5IsZVM5z89/LEjXVk?=
 =?us-ascii?Q?Y1+8kA8nicl/DriZ4dQhv1uoLXN5tYGFLVkgBqcidxndi0LF4xtSKHx/PFuO?=
 =?us-ascii?Q?+v00JHCUJSEgL09t/Ekh8qpAIYUpj47pm6mMWD6BpRrW4WF4dXe7IivjLkv7?=
 =?us-ascii?Q?lk+5ga69SBwb2t9o8J9PJP+1ulkm8n3zqbL8R1MUR/3WgS163Z03EuiZ1SoW?=
 =?us-ascii?Q?jXKo2jWO2FrIRhcjb9Y8ZxVaWgHXEZaRkbhuc4uBi9vROdGrzGmxq460fu8V?=
 =?us-ascii?Q?5cR9eTy1qL+BgNxCmOgDiq7Qww8W1TGuIaHY18ulFgTave1utENC8JWCxAND?=
 =?us-ascii?Q?7q5KLMsGQa/Zk0k4zbspZ2ts842SDabO+sZ+ccXeZIDCcwQRdp9rltJafy5K?=
 =?us-ascii?Q?cLi3ZrK+EkZmxAscMJRNnRqGNvaN/tsHlrHfNQX4qkbAhKXjS83D9410BOBD?=
 =?us-ascii?Q?Q/nXxOmzROUWZMm0blwzbAGUwxkx566N5bbzmPYO/Nwdpn+ECfEYdVSE/3l3?=
 =?us-ascii?Q?K/1TJtXNcmgPWvpvjtPszvcGPwjunRLtOBNC1pstC8CVxgTAqVv1hQ8mDUal?=
 =?us-ascii?Q?8bTdU9zKhVz15DBekIzD5DVvOqwBrOPklRvmLh2cu85G8K3y25pbPeFkLNSo?=
 =?us-ascii?Q?yhwHLXAnmdhKWxGT2TG5CZJeW5aMNuNfb8WStuQinp2J8oJMGrENpeFEul12?=
 =?us-ascii?Q?Uja3lRB/XWtwJCTJGmgZ1v2BiAguKA8sD4jqlasl0s7Tf+r/5Wj1K6UyLijX?=
 =?us-ascii?Q?O2drBQ3W4g1a3gXUWK9v1fjcdjuo/d7/brByjYzYnGDCSgTaurVhmiwvhMOb?=
 =?us-ascii?Q?nJwrm2hbEwPhpqqlwIHvqVIcBd6cM6mf94K9UGognXGXzANjO4y4KcGvE70t?=
 =?us-ascii?Q?RhMvrcr/5417/eVpeuHnVVDocCd9YI3G/ItryqzJcQeFjjmc3aGSXXxa4Pbd?=
 =?us-ascii?Q?x3Hgy+WpXR457l5sa1utaTrB8yuhZWfh2OjMM2PgTqmHxxJFvvg2GZGn6tg0?=
 =?us-ascii?Q?gxYxGBgWkycQ7B+ZfqgaCymXFWemVkATML9HT5jwixKBZoJTSewn03lCeeE4?=
 =?us-ascii?Q?JsT/7uqaD2TGDkY1RuCvavl/7q8yLEMEefn9SclGNXRXYHGDPyVC1dav/jep?=
 =?us-ascii?Q?/O9zWCEtMpT0eP5nQZxakksJ5hpmnj956cjiCYmZiKPY4FEWj3gDAMTB9jmD?=
 =?us-ascii?Q?OMwFzn7x1berNPMX47hDAiSFQRk9JIlKKcdeCkV78xJ1WI21aegqODpDSER2?=
 =?us-ascii?Q?c3q+nKOAm2oA6STuw8uv2QzYFa0Bb95LlC9BWLGKO7lvjdCK4e1JNZMerJo0?=
 =?us-ascii?Q?+G2sBOQ04dsz9DDbgV8d4n+HNWG0vedrfreFTRUBnzc3pz/X6qmFeAKBhKTq?=
 =?us-ascii?Q?S0GLoJiVygQhPj33xYP5nRjk3mP2xMKm4tgEEjhsjqvlEHY38dRuLluMZptn?=
 =?us-ascii?Q?CZ6+H58vkz276aG/Kj563UWumoo769vjZ5A+bfjD3Hh01hmn83n2Ois/1DCK?=
 =?us-ascii?Q?mmZpeebSHsmSrwW/YPzhTK+yX0SSpTch5uTK3ZlHWNwI2cwTjwNVSsmznA1C?=
 =?us-ascii?Q?E3GYyPSc7jCUTqlsCzlKDf0PdjFcX5h1a48EyRTijJt0zwlb0D5FRb5HsGrF?=
 =?us-ascii?Q?zg4s8KaPAcfwQsxX0WkKBGdd/Js=3D?=
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1434616b-0be3-4e2a-2e5c-08d9c05a8012
X-MS-Exchange-CrossTenant-AuthSource: BL3PR16MB4570.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 06:08:38.1817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+mtN4pXpfdOkbTwsugFUjV0173RzosbzY3dB8jibEXdx6CbINk4HK2i53gwmuRxmz4jheY5Wehb/fbClpf1Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR16MB4556
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Fred Ai <fred.ai@bayhubtech.com>

Card input timing is margin, need to adjust the hold timing of card input.

Signed-off-by: Fred Ai <fred.ai@bayhubtech.com>
---
Change in V3:
1.Select suit DLL phase's output clock as SD interface clock at SDR104/HS200 mode.
2.Deselect DLL output phase as SD interface clock before next card initialization.
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 56 +++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index f045c1ee4667..f55602609f8c 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -43,11 +43,15 @@
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
+#define O2_SD_FIX_PHASE		(BIT(23) | BIT(20))
+#define O2_SD_PHASE_MASK	GENMASK(23, 20)
 #define O2_SD_FREG4_ENABLE_CLK_SET	BIT(22)
 
 #define O2_SD_VENDOR_SETTING	0x110
@@ -301,9 +305,13 @@ static int sdhci_o2_dll_recovery(struct sdhci_host *host)
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
@@ -322,6 +330,32 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
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
@@ -533,22 +567,26 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
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
+    /* Lock WP */
+	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
+	scratch |= 0x80;
+	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
 
 	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
 	sdhci_o2_enable_clk(host, clk);
-- 
2.32.0

