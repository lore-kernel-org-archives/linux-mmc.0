Return-Path: <SRS0=zOov=BA=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7BAC433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jul 2020 01:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1569A20714
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jul 2020 01:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="eDsnM/ci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgGUB3c (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jul 2020 21:29:32 -0400
Received: from mail-eopbgr750130.outbound.protection.outlook.com ([40.107.75.130]:17521
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726029AbgGUB3b (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Jul 2020 21:29:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vj541ktkdzHmGPEWU8guOsv7CfVHPyJaZ1vEZJ2yn63yvFL5tkK4PeJ/MfkgnKYemmJxMiA22XzuCVAc9awE0FxCa0kIZhbUdViApwz6AMTnkdmtvr4G823eKRe0ooH71YW4xOoTCIetdnI4aRodrb3EBDuf2IgREtLHaMBcK5t+oy/LvxEzcsKLbtw1M2tSt+RnTRbMe5zz6hPyGdaZ4xr+hUe7cckOOA1ymfkttoppeqB/8C5QMer6+S+83eZTcOpGu9iw5SBgZsIU0rJ/eSbXs/h89bEaYQ7gagAOB9sAWjcaH29GRPEjOw46mLv+qQpkf1Sw7wpLe/ST1ZNgpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBvW30MycsHksVGJ/ydS7ds/MoYvY9jYhxsqEg/0DmU=;
 b=bylZ7iaj17f0beVcbMSJdt/+3UYshQeWZsdLCsTmPm3AGbAQe1IBHcxlJcF0nqVIJRjoyuozMyNkHh6YYmypOhnKa0B4t/iZg+bA7UnRxKd/j8yoVZ3Ef7nmVHuYHwEMct8X+YKVnbtuGcQwstn3xvNHMZlXfW6uXowzXxfVpFtbVsds3MCYwUWt3H514M7T2cPj/7Kd85vaW7Bv/v5d+6ZgoU3TShXKeyiR0bUUJ+HBYSsWG9vZBF+4dpFRo0dMQ5UwoJqdAxCz7315hFgKP9LwgLhnssjW1BZ1FUHqQ4aJvwoCo2c7Slrrc2LQLeI3k9ZdWCdJjsT7qZNdAzfjwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBvW30MycsHksVGJ/ydS7ds/MoYvY9jYhxsqEg/0DmU=;
 b=eDsnM/ciWTdjRXu4u0kmKr1xA/EZzzH6PuyFb8FCJdWj0br37psbcrv3HDRy5Bo0Dk5u9BfyvqXU1hxp/0HoF20pkpeOXRkL1Vyc62oWBgPr/SSk7CtIF1hR0VjL6GTeO/dpfDtAxsIKC7RMxkTQEu2ROkc1JcxnZOtS/JDds7k=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=bayhubtech.com;
Received: from BY5PR16MB3319.namprd16.prod.outlook.com (2603:10b6:a03:186::25)
 by BYAPR16MB2998.namprd16.prod.outlook.com (2603:10b6:a03:e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18; Tue, 21 Jul
 2020 01:29:27 +0000
Received: from BY5PR16MB3319.namprd16.prod.outlook.com
 ([fe80::fd57:47b2:eaeb:d004]) by BY5PR16MB3319.namprd16.prod.outlook.com
 ([fe80::fd57:47b2:eaeb:d004%5]) with mapi id 15.20.3195.025; Tue, 21 Jul 2020
 01:29:27 +0000
From:   shirley her <shirley.her@bayhubtech.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, chevron.li@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, max.huang@bayhubtech.com,
        shirley.her@bayhubtech.com
Subject: [PATCH V1 2/2] mmc: sdhci-pci-o2micro: Add HW tuning for SDR104 mode
Date:   Mon, 20 Jul 2020 18:27:00 -0700
Message-Id: <20200721012700.8564-1-shirley.her@bayhubtech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0054.namprd02.prod.outlook.com
 (2603:10b6:a03:54::31) To BY5PR16MB3319.namprd16.prod.outlook.com
 (2603:10b6:a03:186::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (209.36.105.184) by BYAPR02CA0054.namprd02.prod.outlook.com (2603:10b6:a03:54::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Tue, 21 Jul 2020 01:27:44 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [209.36.105.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ddaf357-9e4b-474b-9988-08d82d157d29
X-MS-TrafficTypeDiagnostic: BYAPR16MB2998:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR16MB29988B241806AD076D1021388B780@BYAPR16MB2998.namprd16.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TgA4h07uue7AcsTZIedVKSvnNEHnT0GoNiaypBLBzap8s61fJ1Gh6JHDtM7Yb3mzVEcR1IjnRoC2wh9sxmsuENPIvD4E9drCcacHDBWNzNticSR5OqhCTVqBbJXkEE70JGKoHJen3LyutJHtOoZF5vhM8WBQ9pIJoULCfQBIvmO+vMRf8AoXmLGklIUaveKCbQT+owQ/tagDm8mhL0btokXGwjr+W1b5fLEzawwqKw+QxNcxbl0dOOdYI/tJEcpMETtpHNxCM4JXTyhz+hn7RlIbvLaO4W7+A6sUPNFeMtzHB8h41Hhr0nAp2d6p4yNGz6ySB97GvkFhZsv1NcF9dP0vpJ0gGNioV/ofWIwfebeHfAcqJgKPadK1AHV7evqT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR16MB3319.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39830400003)(346002)(366004)(136003)(376002)(6666004)(6486002)(4326008)(6512007)(36756003)(1076003)(107886003)(52116002)(69590400007)(6506007)(956004)(2616005)(508600001)(16526019)(26005)(8936002)(186003)(316002)(83380400001)(2906002)(5660300002)(66556008)(66476007)(86362001)(8676002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Gy900oxOeBcjt0rOVHzyrWlQtcadCHqseJGeOpWH0gafK+jmDO0+NntxMeHaDE7OCBn8DCuLOLM2PfTQnDbfC0Xvhwk1QLTNKvjvJRuu+VkAyOlvQeWt1fuqcS8Gvnr6IFDKrieCq3I9CjXkFRKM6bPX3LDDUqA4D4G2ksSzFV0I/ulW0HxDVJfz34EezGz/A27THy1NFaW/3lQQPkXhAr3O7zPh69XEKZvuYGxqfz6V8wai36cS2ocj4PO25iJUi8LDGNdaHAnX9Nl4Un70JtayGUiHkI47tcu8ThTAGAugf8sOeSf1nniSCy/cqI2bpO1jeoawoORWoxf+TbShzv93YxZixM6qyk4WuvSfywVexzy5xjaI+fg1dYTEgwTbQUcH3bSUhkrnQjmAQyhR/tO/GoBOckAtbsAP7+oWv+brAJCvsqKl07jMRi+bv4Fk0fqHxQCehZvqZFpLv1YXt/aAAJ7ZwHswLFTxDTfEZdW3oF2tqfVBprVTaq38GSAG
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ddaf357-9e4b-474b-9988-08d82d157d29
X-MS-Exchange-CrossTenant-AuthSource: BY5PR16MB3319.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 01:29:27.8377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hm99ab7K8aQ6di6yRPhu4XGc+AmXXo2eB/sHfOvS/Nb+k/ATFP+36bYhj6AnL8QO2p59urnx0AusVizNAokwAwdA6Vrv/uqJZShBHAeuo/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR16MB2998
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add HW tuning support for SD host controller in SDR104 mode

Signed-off-by: Shirley Her <shirley.her@bayhubtech.com>
---
Change in V1:
1. Add HW tuning for SDR104 mode instead of SW tuning
2. Change clock base to 208Mhz in SDR104 mode
3. Add CMD and DATA line reset after HW tuning command
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 33 ++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index ed3c605fcf0c..fa76748d8929 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -196,7 +196,7 @@ static void __sdhci_o2_execute_tuning(struct sdhci_host *host, u32 opcode)
 {
 	int i;
 
-	sdhci_send_tuning(host, MMC_SEND_TUNING_BLOCK_HS200);
+	sdhci_send_tuning(host, opcode);
 
 	for (i = 0; i < 150; i++) {
 		u16 ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
@@ -305,10 +305,12 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	 * This handler only implements the eMMC tuning that is specific to
 	 * this controller.  Fall back to the standard method for other TIMING.
 	 */
-	if (host->timing != MMC_TIMING_MMC_HS200)
+	if ((host->timing != MMC_TIMING_MMC_HS200) &&
+		(host->timing != MMC_TIMING_UHS_SDR104))
 		return sdhci_execute_tuning(mmc, opcode);
 
-	if (WARN_ON(opcode != MMC_SEND_TUNING_BLOCK_HS200))
+	if (WARN_ON((opcode != MMC_SEND_TUNING_BLOCK_HS200) &&
+			(opcode != MMC_SEND_TUNING_BLOCK)))
 		return -EINVAL;
 	/*
 	 * Judge the tuning reason, whether caused by dll shift
@@ -342,6 +344,9 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		sdhci_set_bus_width(host, current_bus_width);
 	}
 
+	sdhci_reset(host, SDHCI_RESET_CMD);
+	sdhci_reset(host, SDHCI_RESET_DATA);
+
 	host->flags &= ~SDHCI_HS400_TUNING;
 	return 0;
 }
@@ -369,7 +374,6 @@ static void o2_pci_led_enable(struct sdhci_pci_chip *chip)
 	scratch_32 |= O2_SD_LED_ENABLE;
 	pci_write_config_dword(chip->pdev,
 			       O2_SD_TEST_REG, scratch_32);
-
 }
 
 static void sdhci_pci_o2_fujin2_pci_init(struct sdhci_pci_chip *chip)
@@ -497,6 +501,10 @@ static void sdhci_o2_enable_clk(struct sdhci_host *host, u16 clk)
 static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	u16 clk;
+	u8 scratch;
+	u32 scratch_32;
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct sdhci_pci_chip *chip = slot->chip;
 
 	host->mmc->actual_clock = 0;
 
@@ -505,6 +513,23 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
 	if (clock == 0)
 		return;
 
+	if ((host->timing == MMC_TIMING_UHS_SDR104) && (clock == 200000000)) {
+		pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
+
+		scratch &= 0x7f;
+		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
+
+		pci_read_config_dword(chip->pdev, O2_SD_PLL_SETTING, &scratch_32);
+
+		if ((scratch_32 & 0xFFFF0000) != 0x2c280000)
+			o2_pci_set_baseclk(chip, 0x2c280000);
+
+		pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
+
+		scratch |= 0x80;
+		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
+	}
+
 	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
 	sdhci_o2_enable_clk(host, clk);
 }
-- 
2.25.1

