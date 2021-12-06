Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2255C433F5
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Dec 2021 13:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244187AbhLFNSz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Dec 2021 08:18:55 -0500
Received: from mail-dm6nam10on2124.outbound.protection.outlook.com ([40.107.93.124]:64960
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244186AbhLFNSy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 6 Dec 2021 08:18:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gx+KJTeCtKgefe/vm07OL0HrYQuQ+zQDzYSmbTqecRSSBpWPrsFmrA+wT31VBBzdQKn8AROv8axneF1609DgXIn0hKZ2oW6QqnoR1g/rUruhSE4RCjVqLg/ZP5UKeMXEXVPk8HHLdP/+3d81M+4dpJN4GlupDrgmy1I0RDUCW6HwDxwM09Mxn1/TKVXKgtCKogmtHmEI0KMxaA2W5m02Gv9aUgQOTKqMtYLE2BGs5iWWsKx56AYMO25RtvW40O5cXcycaonG/er9z0twR+FHb3ImGRQiy1O5qARzMWAQX05kTHbWS/trepB7CR2HQ78lBS0+UcpdrkJ/ZqaBgNFLyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fw3A0hLdfqc19cxYN8iwd/8JZLKlmPYr+/dbPaWkO6Q=;
 b=fMlzEzM/AyqeSIJdJiuFRQzUNcrnz2zX+NIN5DU0J826PKwPrGqOpp+rsLzvStvnAsbjq9ZkvuwFtlK0pPI/Z0Zdm1K3EhKETbYMaZSQs7ND8T2v6BU4Hyi1m6ifmzmnjn8CHgHhVY5EaP5Rnr183YTSfQa8itEuelKfe54AfH+OKIEgyLlbCLJ0ZYK9OJE4nGRyqXNv/MoPlsw8Mk0lzzSBzCe4SFi6VuNjc4wgAnnhQouh6Rvs9ksMYXB58JxeFd8dHhSjsFuAeQwWUItyMRqEA0RX3XlK3NaPYDrevOroy6gGC8WHBV2PRcWRXG4bkJwomhrAl6hU7In2jHZoqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fw3A0hLdfqc19cxYN8iwd/8JZLKlmPYr+/dbPaWkO6Q=;
 b=x9ASG+TSXFe2orgT2YLk2c1ZKN/0ttn+aoCBvuuSlvgebzHeRI4PLhLMfgUdGMAk9WGOki8uXqKIQrmt8p83HtV0AKiUu31zWJcEthnMZbb180JHj2pYCBWKRq3Vl2ykKpwZMbThIxPAHXgxw2JgzwUoOq2lFVsVzTurfNzZFCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
Received: from BL3PR16MB4570.namprd16.prod.outlook.com (2603:10b6:208:349::24)
 by BL3PR16MB4369.namprd16.prod.outlook.com (2603:10b6:208:350::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Mon, 6 Dec
 2021 13:15:22 +0000
Received: from BL3PR16MB4570.namprd16.prod.outlook.com
 ([fe80::9597:403c:22ad:5479]) by BL3PR16MB4570.namprd16.prod.outlook.com
 ([fe80::9597:403c:22ad:5479%6]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 13:15:22 +0000
From:   fred <fred.ai@bayhubtech.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, chevron.li@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com,
        fred.ai@bayhubtech.com
Subject: [[PATCH V2]] mmc:sdhci-pci-o2micro: Change implementation of tuning for SDR104 and HS200 mode
Date:   Mon,  6 Dec 2021 05:15:06 -0800
Message-Id: <20211206131507.411-1-fred.ai@bayhubtech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0045.apcprd03.prod.outlook.com
 (2603:1096:202:17::15) To BL3PR16MB4570.namprd16.prod.outlook.com
 (2603:10b6:208:349::24)
MIME-Version: 1.0
Received: from DESKTOP-G2V7PLK.localdomain (2001:b011:4001:932d:e9b0:3414:63d3:c2c2) by HK2PR03CA0045.apcprd03.prod.outlook.com (2603:1096:202:17::15) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 6 Dec 2021 13:15:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bb28ee2-044a-483c-b676-08d9b8ba755e
X-MS-TrafficTypeDiagnostic: BL3PR16MB4369:EE_
X-Microsoft-Antispam-PRVS: <BL3PR16MB4369E7E85057AC74272A81FD996D9@BL3PR16MB4369.namprd16.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LEz0WMpSitPWWLS2DdyDaYLhFlByYKmKDymnIQrmK1I1dDPBS7OtxDGJiv0eX/i9IbEYnjXKhbPqF/sIXWDRIKJczyBOOxKhMStCGXueH9v/VH9ZKJ6EqP7w7glgQZB+99VbFRKCXK06i8w4FRfMMMoO/du+BjiGdwGqL89FeCLQ/zOLf7rAOE0k+Sb2rVuOnw0/w9HfxbTtWomJR9q2aPcgkLSlO65MMn1aIxLAZoUfnhbbuSTkE3bnt79TtV3yU7AKMaPD09ixAu7porDSse2soYMlPAHzmBDkhiLSlR1VPZnKn8hB44WTj9dkUhndMmHNb02bNH3pTwapB8DB2FOPBHiDLPPWX74eurWriYJBaKPA3VT0IPa0n6639jI6MMSrPe0kiM34xcFq6r1+f/8ZYVnfcMGAaC97jmQ0NkBSosTljswx5WZIZZivFQW2l2WmsBAmEy16FEAzYKzUozONLzcesjBKEANNKju+97jg3N9Aw7DKa7ix8SDmU1fj66cn3oxpSvRYT/cE6tDYSBYmk69rSZq7qLB9WJsfUyDBYNbNcHG/MmMV9k6uQhzatADQAYy6QTXLe0k3XaZFYJqKK04TeszDTKbxRU/zlhvZgsvL/f2JgW2JVMypiSOKSgCGN+hqCadaUmwNhnq/Iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR16MB4570.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39830400003)(376002)(396003)(136003)(346002)(1076003)(2616005)(5660300002)(2906002)(186003)(6506007)(8676002)(6512007)(8936002)(316002)(6486002)(36756003)(86362001)(38100700002)(508600001)(83380400001)(66476007)(66556008)(66946007)(107886003)(4326008)(52116002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VwBr7xDw5vaK75K3JSS8nd1Dz8VaiW9OqhESQoeNxUMZiGDw0+LkhcQ/jKkh?=
 =?us-ascii?Q?UD1goyuUI0ZDAnLcGlI/naEoAwmV7TM7TfLer5zAVBOuG414so34PQg89EIm?=
 =?us-ascii?Q?yC3XuX4YhV61dZYq2KTn5bdvVdPFSFP/XC08Ew2WWFHpIxH+xz/c5nqG6oM1?=
 =?us-ascii?Q?Owh5M43XE5yy96N5GWiPQT2e/XEvTBYIRPmPKhx4lOSxNsjz1cI61R35CuWG?=
 =?us-ascii?Q?iF57otSe0TY76bwZbWUWxKKDMTM/FxSv2Fe2C97E01Dky9izVYPHNddm27nP?=
 =?us-ascii?Q?YzzZeblxY5BrK/CQoBqrt7ZlZajpFU7fIFzXbf9AtnLBLkczNzN/c9WLxlQ5?=
 =?us-ascii?Q?3th4Wikf5Bq1MygE/sdpIJhhqLsPCeJJjMbf4zaVHftyxU+s24+CfCziz5GB?=
 =?us-ascii?Q?dkerxusF/c/njJNCIrYodqDCqNnFaQOAKQYv1WaXvL8xrLhrvxyIDdpTO/MK?=
 =?us-ascii?Q?rwTsKwM+EorSiWi4oCvYn53VGsr3WhdUlIawpHBE2BxhN4LuN17LUpKnWA/h?=
 =?us-ascii?Q?NYqE8sN3nZ3dQ8tCCfJg7ej8NgafWXQDAy76c3Gpu3l3i9DQ2gigW7mpxv+u?=
 =?us-ascii?Q?EWfx4lQ41PfunfJ2F3l8PFqFwFH1AYuW8l/d/BNTtMG+IMtD/nCBHn/yJSpu?=
 =?us-ascii?Q?JmmO1Qk9Nf+CW1nO/4Y3+pap+YeGUVEXo6TSs9qm33NLyF5tz3fRczbAAzR7?=
 =?us-ascii?Q?wt4F5/XZaaMV7vphbrwnEHsb4K/E58SELj6CDM6LtmWQ7Xhx7+IouuBW6Gcq?=
 =?us-ascii?Q?dqBW3XdfW4Uu7HlHTjiXnardpdw/uxA8di0jQIKnhetcYU1AtK7uY2v/KpuN?=
 =?us-ascii?Q?kOD7eSE+JwD7yccU5wHPKChVBVcRUS+5uLBp5yHCTQrBp0TlTd5/fkGsK9Ma?=
 =?us-ascii?Q?p3ieg+NttPujPd7mPI+ToK7uYOaPL3WZyur43ZwJCFqtXaw1pE6hpGFSBH7q?=
 =?us-ascii?Q?79OaJQY6zKcBET5J9BGTP7ZRJdpiIdp8xyI6xjPDhSHPFGKlNEOrN87P9kvy?=
 =?us-ascii?Q?qGwvu6Uwwpo5pUNS3647O12MW5Czs0rKbYTefeGMe6ok54kbqq0qS/GwP08u?=
 =?us-ascii?Q?Namix5ksiANTHpXZIt7hwseuvHAduTJNbhSin427gDKb/0Lt5YXNuzxpn89w?=
 =?us-ascii?Q?bIlo8waz5HUuZaCK2pBRdVZoxcS8c3nF6nbWio/8fbwf0c51t8dSLd8o8nsb?=
 =?us-ascii?Q?un9T47dBzlY0lApRBorcPVinqpSBE8a/m/X7xTC9c8QiWMg/05vlydve6hyY?=
 =?us-ascii?Q?B77wfJHT9WBBUXDou7V6Ja5AgnWDp4z3dNffLzJtogxpjSJcneIc2FEEmeox?=
 =?us-ascii?Q?8FJJhOGwoeyDolXZCTeaw6CL8W05w+iWNa6iGnKjvNBAfu28Cbj4Gjottck7?=
 =?us-ascii?Q?RR/7El8mwM+jYfxK3A83fWnxzMm1uCO5XdFrCKdAaGw7CbuuG+p4IK6WBiFt?=
 =?us-ascii?Q?b1Kl6u7I0PBV5122u7JoyojdD9L6l6fk5ywKwy1R6hrlpmB1aUGFfHVALYCZ?=
 =?us-ascii?Q?olW79k78byB9K5XP3zagSlt+B0Jjh/DWsK1i50+ZcxwHGL3AHCLP3j6zFaL/?=
 =?us-ascii?Q?1JWWG+zIYFRMceBRiYARSteIX6MXqYQ6uZqTvZDXLdEyIrk9GH30EMT8/GQE?=
 =?us-ascii?Q?0I90jSQ7WkX6CRczsLv5/t2ljuSMmxxPPnN+POhLb7btoWv7e3yIxrlxhH4i?=
 =?us-ascii?Q?tuL2G4JOKxAkdNUxlWAeVFn02oA=3D?=
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb28ee2-044a-483c-b676-08d9b8ba755e
X-MS-Exchange-CrossTenant-AuthSource: BL3PR16MB4570.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 13:15:22.5575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rVMV69c9efLb31nMkL+5szzkQzQyqW+UygMAqbo+BP5UywBw3wo+bh9tHztk1fjEbvIkOiVWrJTshipmsBnSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR16MB4369
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: "fred.ai" <fred.ai@bayhubtech.com>

Adjust the timing of an interface in SDR104 mode. After sending CMD6
successfully to switch card mode,driver need to select DLL output
clock as SD clock.Setting DLL output clock phase value 0x9 when
select DLL output clock source.

Signed-off-by: fred.ai <fred.ai@bayhubtech.com>
---
Change in V2:
1.Set register 0x354 bit 16 to select DLL clock
2.Set register 0x354 bit [23:20] to select fixed output tuning phase 0x9
3.Driver need to clear 0x354 bit 16 and bit [23:20] to 0 when setting clock
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 57 ++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index f045c1ee4667..98c1a17eb619 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -43,6 +43,7 @@
 #define O2_SD_CAP_REG0		0x334
 #define O2_SD_UHS1_CAP_SETTING	0x33C
 #define O2_SD_DELAY_CTRL	0x350
+#define O2_SD_OUTPUT_CLK_SOURCE_SWITCH	0x354
 #define O2_SD_UHS2_L1_CTRL	0x35C
 #define O2_SD_FUNC_REG3		0x3E0
 #define O2_SD_FUNC_REG4		0x3E4
@@ -301,9 +302,14 @@ static int sdhci_o2_dll_recovery(struct sdhci_host *host)
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
+	u8  dll_mode;
 
 	/*
 	 * This handler only implements the eMMC tuning that is specific to
@@ -322,6 +328,28 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	scratch |= O2_SD_PWR_FORCE_L0;
 	sdhci_writew(host, scratch, O2_SD_MISC_CTRL);
 
+	/* stop clk */
+	reg_val = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	reg_val &= ~(SDHCI_CLOCK_CARD_EN);
+	sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
+
+	/* UnLock WP */
+	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
+	scratch_8 &= 0x7f;
+	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
+
+	/* Set pcr 0x354[16] to choose dll clock, and set the default phase */
+	dll_mode = 0x9;
+	pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &reg_val);
+	reg_val &= 0xFF0EFFFF;
+	reg_val |= ((1 << 16) | (dll_mode << 20));
+	pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, reg_val);
+
+    /* start clk */
+	reg_val = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	reg_val |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
+
 	/* wait DLL lock, timeout value 5ms */
 	if (readx_poll_timeout(sdhci_o2_pll_dll_wdt_control, host,
 		scratch32, (scratch32 & O2_DLL_LOCK_STATUS), 1, 5000))
@@ -520,11 +548,11 @@ static void sdhci_o2_enable_clk(struct sdhci_host *host, u16 clk)
 
 static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
 {
-	u16 clk;
-	u8 scratch;
-	u32 scratch_32;
 	struct sdhci_pci_slot *slot = sdhci_priv(host);
 	struct sdhci_pci_chip *chip = slot->chip;
+	u32 scratch_32;
+	u8 scratch;
+	u16 clk;
 
 	host->mmc->actual_clock = 0;
 
@@ -533,22 +561,27 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
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
+	scratch_32 &= ~(1 << 16);
+	scratch_32 &= ~(0xf << 20);
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

