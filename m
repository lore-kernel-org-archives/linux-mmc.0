Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADD0C433E0
	for <linux-mmc@archiver.kernel.org>; Sat,  6 Feb 2021 03:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1E4764F9C
	for <linux-mmc@archiver.kernel.org>; Sat,  6 Feb 2021 03:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhBFD20 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 Feb 2021 22:28:26 -0500
Received: from mail-dm6nam08on2130.outbound.protection.outlook.com ([40.107.102.130]:59361
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231872AbhBFDPn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 5 Feb 2021 22:15:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWJmBwXRe2pEa/Z6LDhMqSxZwYwNnrFQzqrmtViAJEH5iVeMLuQr6wvUud1zpGdXZwp8ORWR8D5EKVtPWtazdPLOgy/T9FgzJ9Q4vDCGV1pww+9vLpIpwVYeADGn14NhVrF8PdJdvzCWtWfTnfOecYWNLIMdNIN0tBtaAZ280rRcl4dJ1rWg0DOe5MDW6MeoX/4kd5765vjn4VsKCWXmK4WrMbqq0AsmTnWBBm45dk0iPrJ87c3TgeT/J5rcJVAkQtW+CaUnXA4jGVWWwuaauAi4teqdsygS/uwwy9pi7Jz/np+h4duYqkvGnhkwUEkvxEMJj5C+Jibv6XjT74Exew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3vOdL3NFBmvWoeSFuaYqS+F7qA47NxsQG+biV4KObM=;
 b=ZmeaxvBqVoYA0DPAu+4kJtWYWfbDA7pqsbpXNKU4q3qtaN4+otrduXLPuzGH2s1LnjP55rpoJpKIhOnuySrYhjqpFtPWYP4WyD51FXak6rl1gvumLNs2D8rczugoVtM2LMxMbJ8dpo+tlJLM0LoxlNaUjJvFi5ahZ5cW79598XCWmikumHe4x8Qg2oxm2jkKY98dbhlKHS7NM6AP968i3lQWOzFu0wMieVDnSbJ3PhiRqmNuI7xFec/qd/uZQeGNQmD7MGfbZpyje+g2y3OfCXS1CFftZDdgN7UgswESPznNcqk3wWRR/iJNzyyM+S6FsGT3k6meCBvSJqxWAXO+zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3vOdL3NFBmvWoeSFuaYqS+F7qA47NxsQG+biV4KObM=;
 b=Zhm8mvLCZUQylvZFZw6dhZupshvsWhfB+t5uAEXTl/OUdLSUF7qAwjP58q4Ed5s9GmcV1sYcu9DyGdao8n1vAjVaX1xtbuMweS+H8QJY4I64xoFj8j70FZcZKYbOrsqAuLVC/yDAqMy2qXGQQHuCuFZY2gF7m2FcRoJtZQcT7eg=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=bayhubtech.com;
Received: from SJ0PR16MB4175.namprd16.prod.outlook.com (2603:10b6:a03:324::13)
 by BYAPR16MB2918.namprd16.prod.outlook.com (2603:10b6:a03:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Sat, 6 Feb
 2021 01:37:08 +0000
Received: from SJ0PR16MB4175.namprd16.prod.outlook.com
 ([fe80::ad55:4b6a:db35:1195]) by SJ0PR16MB4175.namprd16.prod.outlook.com
 ([fe80::ad55:4b6a:db35:1195%6]) with mapi id 15.20.3825.023; Sat, 6 Feb 2021
 01:37:08 +0000
From:   Shirley Her <shirley.her@bayhubtech.com>
To:     adrian_hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     chevron.li@bayhubtech.com, shaper.liu@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com
Subject: [PATCH V1 1/1] mmc:sdhci-pci-o2micro: Bug fix for SDR104 HW tuning failure
Date:   Fri,  5 Feb 2021 17:37:02 -0800
Message-Id: <20210206013702.3362-1-shirley.her@bayhubtech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [209.36.105.184]
X-ClientProxiedBy: SJ0PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::7) To SJ0PR16MB4175.namprd16.prod.outlook.com
 (2603:10b6:a03:324::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (209.36.105.184) by SJ0PR05CA0032.namprd05.prod.outlook.com (2603:10b6:a03:33f::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.11 via Frontend Transport; Sat, 6 Feb 2021 01:37:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 078feb3f-8816-4409-acaa-08d8ca3fb79c
X-MS-TrafficTypeDiagnostic: BYAPR16MB2918:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR16MB29185CECA4661E6299A0667A8BB19@BYAPR16MB2918.namprd16.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MIDR1v4hRrP19qFGEtsEwvYgxYteEmRLjw4xyAQSb/lyrqgEJeP/rpW/hty5CBhJ6rm2Fz5cz2ACQQBZAs13FIYRzssfhSDc6uejcEk2GUM3i48DPY+k7cej4zD5YlVHGQeCrpkIG9wHa9gbsTSM77+HYqo2XZUfvxmAexdPxPzbZcBDdU1IfDYrUcjRZZiF+FBaAjNk8E7hoBWX/Ze1nJNPg/85fZVdA6ASh3vme+3LqsgXtWDC0Mcp2V+9+QWNb9L4mwQkx/FzOJeR3TQ9zgI4T/PgF3NihU3dShXSrcPVwQwiVjF0xGXqfgJzsvOoKBNyKsIEbMuLUp9utHdsl23gdsGqvdDhsZxyJlRpTv+SJZbYR92VwqhkaXn9dowQRkUIbBjDgqUww/khplGB6DCoPmlmsp8YBPdgAD1ucdnLbh/3wa72GP5pI+gyEiEjw2p6/a4MJYQuzsdshqq2o0aPUd46zFHttvtX1x6z/ZAxgVihrqbP/b56wJqhIdWUi2yazEPDAMZKUzt0QCw6pId+8L4JZruTDjQxig/V58OCmNjcb3mOJX9D+m6fw2VbxipiDjPG1EhNPfhUvJ0y3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR16MB4175.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(366004)(396003)(376002)(346002)(136003)(478600001)(6506007)(107886003)(66946007)(6666004)(5660300002)(66476007)(2906002)(52116002)(86362001)(44832011)(186003)(4326008)(1076003)(8936002)(8676002)(26005)(36756003)(16526019)(69590400011)(6512007)(2616005)(6486002)(83380400001)(316002)(956004)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?rFSy1lHNIWW5mo5w1UWE7XF3K54y+lRJFwBU+MIVjbS8zUY7CCuAhNuUieA6?=
 =?us-ascii?Q?BTUxfDrjlVjvSeKAe2HmolEL/jTdLWh060HuAn6w8OX0BKip7cIWzx0JM/7T?=
 =?us-ascii?Q?AG6PcbbGsO6qPX6+uLUR0V4aZDELuZ8A3LiKd8UnUUiB7P03zEw1CVyG0oq2?=
 =?us-ascii?Q?Aqb1q1AnYmNDrQxeofWQgv8njI6wyDY6iev4R//Kwl+VJzxXQ5QFud5wsMeH?=
 =?us-ascii?Q?h2mbEzk4zB01zrf4Xb+z5f+EwyQTXH6qpWwTxE+XKaLK2tpHDTRsdNpqu1Rt?=
 =?us-ascii?Q?NLz5IJnJ3dNnMDzYdlCWZpN+wpqCuR3vpzh8rucaSSKd9QtbPQQCPjD/SrBc?=
 =?us-ascii?Q?rPMrJEP1LFl49/DNX+JT1kBDcAUG16NVJf2jJRu3g6zk5MCGGiKFiGrQE4zO?=
 =?us-ascii?Q?/AzqvCgROdfDEwE6XVDNTNUNEDqTclhX4Nr7QFSz7nS/PS0VPfYNKm6L4JAo?=
 =?us-ascii?Q?SZq6iT66F+fbBcw9uSGcPfTB/KL3mVqlF0f2rcApXE/Z6HY0CaGFHYJDeZpQ?=
 =?us-ascii?Q?j+0XruHOGnBulEMLS4FYFvBZJihLjSLprzwulwFTaErUxiW17fY3NoeZJ7tu?=
 =?us-ascii?Q?U5CIdj55RLXaC5lid9giLDYtrv94uOikcIWqap9UdwhxQG02IaRoa4Clk6Vp?=
 =?us-ascii?Q?BlAdMLTiEgEdVIWVdZ4wx+6jld7eWzhEtL/xeFBmUHSDcYAd11CuzVUGstNv?=
 =?us-ascii?Q?I6FWHcv2VcvguzjgbJJj0n4hyBZ5eT0dGUHz96Ln9AQb20cFYjHZRe3GMw4Q?=
 =?us-ascii?Q?pff6Nfywil1SQeIzvM7eilEte5Sx1aoepjamlURDQgZoZWBGuLm6eGUrWW2e?=
 =?us-ascii?Q?kvtJglAUgs3QLhW3G9tbRs4NKjgY63QPuii7nf9/zIWHH5FbpcV2mQbQ0h7W?=
 =?us-ascii?Q?6Mc4rqHB77cp39lg74SwStNmBH1C00QTeR1CuJ86AvCuhm/cEEs1FbHAeGwN?=
 =?us-ascii?Q?Iw5udBRDR+ZYv09SLBntYUslnQ+EBKtqu9SRxfCSrscfhxaZYoPQ0IwIYAJS?=
 =?us-ascii?Q?qZhFhhDW47F3RtZAU2Jf+ZEbVybJzKZ7lYBNHI8GaTPbPOHKiVoakGFY8upX?=
 =?us-ascii?Q?T0ML5pXwstTz9l0qUXjjNj+RaS/qmeUv20J18osoc0Q6Z2CzGihtp5vlW6Am?=
 =?us-ascii?Q?ki1EsX13sYwVD5Jlc48os4mh3ei9mo/ivgPiwdf7KtcXgFb8/gnjDLCg8OpM?=
 =?us-ascii?Q?P1TIjfWyk3TEv7uTVtOEX3ZbWXpXpP5Na81kvhLX0AITGuSFRY4Twj3RudES?=
 =?us-ascii?Q?hJzsY35rOAKadLV9q8aGRoQAsJ9QoIr2AEavNuX5ET8tkPeTBhxAlyh0+Okl?=
 =?us-ascii?Q?CWFEQ1ysGtzumlQK4R0t7+up?=
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078feb3f-8816-4409-acaa-08d8ca3fb79c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR16MB4175.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2021 01:37:08.6826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBjiuYvgo73ij97oqLWqgBwsUKdYEyTkjJ8RVxsuJlN4dAu+Cbza4dBmeGXC1TfrAQwS+HoapQ2BmQES36qzmNreNze9cGgSgLiyRjDdvdc=
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

