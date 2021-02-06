Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E80C433E0
	for <linux-mmc@archiver.kernel.org>; Sat,  6 Feb 2021 03:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 012F064F9C
	for <linux-mmc@archiver.kernel.org>; Sat,  6 Feb 2021 03:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhBFD2f (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 Feb 2021 22:28:35 -0500
Received: from mail-bn8nam11on2090.outbound.protection.outlook.com ([40.107.236.90]:64768
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231920AbhBFDT3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 5 Feb 2021 22:19:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McAixftzoosYfmaYkDlkvoA+yw69aZX9yTKB8x33dfKI4T+mFtLSpvG/nSoxJQGoLm32CSKdMrI2J17HdCYgMniyjKzNEbnfUxhxKhJv77CA60o/d8ae6nIALHkWo6e1H82xQq007maL3cifbNqeXzx2ucc8gObgIV9qYbdo13Z9ETf44UzQsmaQeBLEekq6DeDdVOcWBlZsK8a1ZJUTr7wD4BxKMVxer1L0g6b7RWp0uYwNNi2scmpAabi6OkY7FlYV4CCyyVjt9EcGQRrJmiDZaMy2I3AhwNSWvMRMr+LJnVMQ5+FGvziXfokpP7CJqstNRrwBFWMkZJJwO2nl6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3vOdL3NFBmvWoeSFuaYqS+F7qA47NxsQG+biV4KObM=;
 b=Em1/ab/vaH+z8DIIRyxuA2bIwdhKP3rYRvZVgLNDjq/jo4c012LzCrauVxL9VTTQsVwzU33878tfbSBfpnq3BZHexOIWDDwykGiivoHeodV7rB9pNhSczhuqD5jDa//ePc8luP2wQoI8qISlEva4qDHG2AS3x3zOvl0Np/W2U8hewxjcUGjDk/bqpBpiQc7QJ4k7NzENlkWqducx7TQOwP/RlWfVBSYX8NhULK00zKePY9v+B4W8PEjzGVo0Bgj59+kSBykZssPPVM2fdXwkx/TP8RT2Q1HHRSXyES1W3f+DOkmUyYmsq2gXACi0twM7Y6TXoTTQOVJVn1ZscjeRAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3vOdL3NFBmvWoeSFuaYqS+F7qA47NxsQG+biV4KObM=;
 b=lWXsaNnVloZeVTFvC4YJsxB3omOdGN1kqsWRREDdamNLPopVevyP8f4QxT77HMqyB5iQZoAKQ+y+Sa5qXC86GGGnnnQPj6A8G5wnaEnz0aqjkt5qJ09ZVO8PL9+ClTYLsQs6Z2fs+3erHbsx9q1AAi0aOkdf1l1gO2OOxUZgmuM=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=bayhubtech.com;
Received: from SJ0PR16MB4175.namprd16.prod.outlook.com (2603:10b6:a03:324::13)
 by BYAPR16MB2918.namprd16.prod.outlook.com (2603:10b6:a03:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Sat, 6 Feb
 2021 01:40:58 +0000
Received: from SJ0PR16MB4175.namprd16.prod.outlook.com
 ([fe80::ad55:4b6a:db35:1195]) by SJ0PR16MB4175.namprd16.prod.outlook.com
 ([fe80::ad55:4b6a:db35:1195%6]) with mapi id 15.20.3825.023; Sat, 6 Feb 2021
 01:40:58 +0000
From:   Shirley Her <shirley.her@bayhubtech.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     chevron.li@bayhubtech.com, shaper.liu@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com
Subject: [PATCH V1 1/1] mmc:sdhci-pci-o2micro: Bug fix for SDR104 HW tuning failure
Date:   Fri,  5 Feb 2021 17:40:51 -0800
Message-Id: <20210206014051.3418-1-shirley.her@bayhubtech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [209.36.105.184]
X-ClientProxiedBy: BYAPR01CA0034.prod.exchangelabs.com (2603:10b6:a02:80::47)
 To SJ0PR16MB4175.namprd16.prod.outlook.com (2603:10b6:a03:324::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (209.36.105.184) by BYAPR01CA0034.prod.exchangelabs.com (2603:10b6:a02:80::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Sat, 6 Feb 2021 01:40:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef7e92eb-ae65-4649-9f93-08d8ca404073
X-MS-TrafficTypeDiagnostic: BYAPR16MB2918:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR16MB291826F5BED456F25ECA74148BB19@BYAPR16MB2918.namprd16.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fngVlObrHcaXZeWxBSqkq7YLR/Ypp5LKd336GFiFh//xXk1fmjUQ0f/rR9cXBa3tsTyMET86iBgJfDL2ivb5H1GkDRjvlfpDwDnPqpTNlmZ3QoNJUYlq7goqlr+W0kLKyIbh4U8ubsDL5VZWbt4x0AczESUwWhgeim5U6M8nuUTj4akdW2OCEJ77GqZry4aoGmwXrc6erWKeGcetugRs2c4dO4m0EN91IcT/Btgz0J4OZAsdlprESgdj9KmlLQLxBjMvZneqOSxV8Ws/8ufeI54+7zSvQxZsYq7sjZ7iOF68N3YIpsrXaVMt4OU6uGsrOLBOL5KSsAkIzea3ozDYrGFyIiVcrX0JtDw+aCWOR6hY4KAuV+Rf5b6ovtauaoBnD1vQkVr5Z5eeHi1l2vtTUr5veksOq84v3SYeAnS2NKUSzJ/61+AzHekOBp/obD+dQZ01bWquwsGu+9C7dwynWuWSQoplRxdtw0nnlUavqWZa9sUpJCdFsY4uXugwS4kHxKhzfYaIShZ/naoZajwO4UKbnBiFK1n730ld67DEZTiS7YPOFxFFv1ZDTQBNj797B8MKNvze2iTEUCh2yXYWJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR16MB4175.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(366004)(396003)(376002)(346002)(136003)(478600001)(6506007)(107886003)(66946007)(6666004)(5660300002)(66476007)(2906002)(52116002)(86362001)(44832011)(186003)(4326008)(1076003)(8936002)(8676002)(26005)(36756003)(16526019)(69590400011)(6512007)(2616005)(6486002)(83380400001)(316002)(956004)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7HQeyJZMcbRe3GWNF06OciImXy42aj1vyX3cHuq9Sh2IlkNSNQIhyMED4eOy?=
 =?us-ascii?Q?an0edMIxDsfWFIdshJDT0+J5c6eeO85FXaoPbCvAUVxHi+2C7n4WpVJkYK4i?=
 =?us-ascii?Q?vgU0cppRZNI8mh30EAs5wb/7CetpDtt+ImKEk0JKXtV8GYk5ew/LzDXl90rB?=
 =?us-ascii?Q?NJLuux4aWhN+71hs+PnAPzgrBUlcs2jy76PN9u7fyTLc3yjxLxYf9MISAE20?=
 =?us-ascii?Q?osaglXH3fzHxAtKet2R/caLrh597MjdVbtQ6OTIzxhVtta1xfj3UXRQkvYf3?=
 =?us-ascii?Q?rMvp4qb7GwwDyAs+7oZWsE/SkECOqSjrjFKVzBkATbhXngiRFl29JAkGUpJb?=
 =?us-ascii?Q?CoSSZr7EAbc54k+tja/WitD6iupfbPHP2vRVMSBfbxUQFkoPMt7QfNjQEgqz?=
 =?us-ascii?Q?ZEYbHjr75ZG0PBwTFEWXx1dgd5vBQtSst8rzTGvLzG+aPVaXJJTxfS/ai48e?=
 =?us-ascii?Q?p4B7Ko3LRas0cPOTJvDpY5owwKD10OeuhgQCYjKl/tAVGQeyeRomCd4Hz1O1?=
 =?us-ascii?Q?dIS04qMmEtb9iPROK3Z7LsdSt97eqEnznB8RHBAV8lVD77g/5gAReeDhkJgS?=
 =?us-ascii?Q?6s0ITpOepreOC9a3KPf8ZpQLO480gg4b5dM4gjYaqPJse9Kg1uVUYkBZfpL8?=
 =?us-ascii?Q?gXevX/pvu71jVLdrvz389SJ9lJ6guxA8ROQ868cgoBrYZB2+s2v+3A0ZSMlN?=
 =?us-ascii?Q?heTay8g4ZiNyvOvRO16S7pIVKwbj0hzmfxiwOTSn8w8Y3v5slVygOA3sNa8/?=
 =?us-ascii?Q?7GqRbRFt1WNv8HJUTy5s8mVhje5lQekTPmF+vVh5J/QFom8kK+MVob+I5Bd/?=
 =?us-ascii?Q?Moji47Z0Fu+7v2VUQ+RQKHCsJgUtCUTzXuACCNXVfu6nrYSQTO3mhLHemQPD?=
 =?us-ascii?Q?C7yGPFK+hcUyGsnIGtkVV3cCbjqEK0SUVR7zcjzNg5KtOosjSG8lm2WOAwWE?=
 =?us-ascii?Q?6COCteKDi+QBc72REMseHDH0pbFUE/q2CdLfvu6xF2aX0AuVix9NkvW/BVjI?=
 =?us-ascii?Q?0DCJWUxGBBevinbk63jCBYvWASOiGGLatbrJObfH+CKWa77fSi11OG1QgEWO?=
 =?us-ascii?Q?TbBRd5q1C0vNEjDeMipaSo7ZiQaogOSRkueyDV/ZOTRXEJW3K/U945Csz1k7?=
 =?us-ascii?Q?RvNiqoVaXspt3g/teaN3GSM4wLoSw6jk/9U+P9ysQcDPVINBt6Ud+lEyhHtb?=
 =?us-ascii?Q?PWRFABn1t6FO5oH2UrXkci4mGGrXGwBaWsDiikEvxzJi4Ry6/W0Vj2u5I5pJ?=
 =?us-ascii?Q?lefmsOwEOnHsM5KIx3GkD/NMVZF66WNgHF9K2jrwczlcpKgo/O6HEnxN1Uix?=
 =?us-ascii?Q?0Xxw4Xeq2JtugrsIYTMjNuhZ?=
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7e92eb-ae65-4649-9f93-08d8ca404073
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR16MB4175.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2021 01:40:58.2654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYqNVtRgfJWD3q1K4WlbfiWsAi235LrktRoNm9fQc+ZXRd0CeucJ5WaSXckyPf7x4QEPyydsk6XmSjgwq4AN8QlkBGL1LapAOKx/8yPknOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR16MB2918
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Force chip enter L0 power state during SDR104 HW tuning to avoid tuning failure

Signed-off-by: Shirley Her <shirley.her@bayhubtech.com>
---
change in V1:
1. Force chip enter L0 power mode before HW tuning
2. Cancel force chip enter L0 power mode after HW tuning
---
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index fa76748d8929..94e3f72f6405 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -33,6 +33,8 @@
 #define O2_SD_ADMA2		0xE7
 #define O2_SD_INF_MOD		0xF1
 #define O2_SD_MISC_CTRL4	0xFC
+#define O2_SD_MISC_CTRL		0x1C0
+#define O2_SD_PWR_FORCE_L0	0x0002
 #define O2_SD_TUNING_CTRL	0x300
 #define O2_SD_PLL_SETTING	0x304
 #define O2_SD_MISC_SETTING	0x308
@@ -300,6 +302,8 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 	int current_bus_width = 0;
+	u32 scratch32 = 0;
+	u16 scratch = 0;
 
 	/*
 	 * This handler only implements the eMMC tuning that is specific to
@@ -312,6 +316,17 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	if (WARN_ON((opcode != MMC_SEND_TUNING_BLOCK_HS200) &&
 			(opcode != MMC_SEND_TUNING_BLOCK)))
 		return -EINVAL;
+
+	/* Force power mode enter L0 */
+	scratch = sdhci_readw(host, O2_SD_MISC_CTRL);
+	scratch |= O2_SD_PWR_FORCE_L0;
+	sdhci_writew(host, scratch, O2_SD_MISC_CTRL);
+
+	/* wait DLL lock, timeout value 5ms */
+	if (readx_poll_timeout(sdhci_o2_pll_dll_wdt_control, host,
+		scratch32, (scratch32 & O2_DLL_LOCK_STATUS), 1, 5000))
+		pr_warn("%s: DLL can't lock in 5ms after force L0 during tuning.\n",
+				mmc_hostname(host->mmc));
 	/*
 	 * Judge the tuning reason, whether caused by dll shift
 	 * If cause by dll shift, should call sdhci_o2_dll_recovery
@@ -344,6 +359,11 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		sdhci_set_bus_width(host, current_bus_width);
 	}
 
+	/* Cancel force power mode enter L0 */
+	scratch = sdhci_readw(host, O2_SD_MISC_CTRL);
+	scratch &= ~(O2_SD_PWR_FORCE_L0);
+	sdhci_writew(host, scratch, O2_SD_MISC_CTRL);
+
 	sdhci_reset(host, SDHCI_RESET_CMD);
 	sdhci_reset(host, SDHCI_RESET_DATA);
 
-- 
2.17.1

