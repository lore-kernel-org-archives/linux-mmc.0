Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C34C83F29
	for <linux-mmc@archiver.kernel.org>; Thu, 31 Aug 2023 03:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345800AbjHaDWy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Aug 2023 23:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243984AbjHaDWx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Aug 2023 23:22:53 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC818CC2
        for <linux-mmc@vger.kernel.org>; Wed, 30 Aug 2023 20:22:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CpWH9o/bqnPhhK3hxwvf5KhJ7RMy2mwZVIkpgWugYbWd/v/878vCNj3yuDIKy3pCFdqNLeLXHcp5cI0BGYFQyWS7nOFfyJSXf0N4LXdYNmQ6NtHngOEurgLckucW8Jm89nde+fNaCiuIyZLwa2tGaY2bqSLnhehCuMUVfGgp7E6R35zj1TtWpn14UaeKj9arfCG+tuKY7NiJUCk4xfQaHpAumtYr1bVA8pbQQSweB1eFSfgZnOLbsD9cC484JNlwwH9r6SAILKWr0LAfiOfSf+t/hwG5sNf+RBN4slZVaZLP9BgoFjusNhOOMw27UgGA1OFcPVcx2Xm1zf11npQUAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpEuZXXK5Gqlgwc8Rmpbxxu+dv+Ruwbe4evPX78OHDc=;
 b=A+DjxrglqGNQ/lmByBS9Mqpj6til1uRjZvUo4ZqrHykSyxU5P8IgIit2+IGNBZzyDP/7b8kPzhzEvyolTUu1SpsflKMtp6FEafRRXvHSSv+PBr3VBymR8bUdTqt5kEWIzuH2RYvOl03NmPhH6Uh4Fu6KFbkLbc6QmKBZMvg3pNPyFvalPmsagV9zdEhUOupRa1qaftqH9dD8/9mTBfRo7M1gW3Qyl4dCMTcYYsQ1wxYQKNAvu6oOZL4z/QTu8fMqd1opwlCv4E/XcvD8DRg2lnDUQahyn93+5gNdIAL1SnpEHWX9cbThyda0vrUfcsPOMMDsEE7FDx2ldmNK4uLXlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpEuZXXK5Gqlgwc8Rmpbxxu+dv+Ruwbe4evPX78OHDc=;
 b=eRSbR4tLzyKmUa5z/Hw62hICZKwpSZa0TtHqHLYbj4r6mDA6Wa1TyrxdpVyAZJC5UUFjuYmVh6bQVAR4DwQJ9SDKyvm7iOdKTQdEmb1eVHrQPC+sbepFh+pA45UzvdvxBs9oDOeQj5GY9aS0M5wBNMpGZIpDC/pBygx+LFX9htc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AM8PR04MB7969.eurprd04.prod.outlook.com (2603:10a6:20b:24c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 03:22:45 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc%5]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 03:22:45 +0000
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Subject: [PATCH] mmc: sdhci-esdhc-imx: optimize the manual tuing logic to get the best timing
Date:   Thu, 31 Aug 2023 11:26:47 +0800
Message-Id: <20230831032647.3128702-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|AM8PR04MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: d0e7916e-0449-4950-f000-08dba9d18b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JAuk+HJUoFHQkgwnWd+mTCC24lzE4uDpHd3CKjc3+TOy1k00fftETQZV/My93a1mObCkL4e1tLh5koqhAV/Ggy6ROVRrIsI3VoIm3zroftvnY0GUfhPJxdKfjjLf2wotU0BLGh+bOtoSKszdfp3GirHaUQBzeNd9Gl9zYOMBQH58tYDUhDWXd4o1z93xft/kmdtVPF7fGeQ3PeoSsRMR8Rc8X/rJjYTCL2wkPeWA6kukrq75RY9ak9Tq6z6Yv46142P5/vKg3bSuwoA+Va6IYBfT7ToubjWCyzhiZBhSeNs4HDciQv7vdlF4I4kP4hMEOmYMcqsg8kAsw23mGoRpDYaE/u1MziA5AXGvro9Stn7kUv2qIytakcjGwjbwfzbMZ41UeEk32N9uN9NRPGx0B5c+jalznHqoFutRWCYCeq+fKI1JMLZ8NLMk2PQro0aE4gqvsyeu/x+aEUyHlCmm+xmPE4vfWbplpQzM2H0Ghm3m9d5O9dDgEh3uSMaKxvpGjq4kVAH1ZZsn+nKIjSZ3xSyTJ5WvGlQQV9EWxAfl1gjaBYti4IvadO4JTF6Wfke35W92LfEEw0tTJ+gFz/RNrJl86KF6KuqfwjAZRil83EryyiBowlBgPbEjts3ufJ0j1hvtBDh1bq6/VL8dl/vxl8zTz9U/PM0rZpP9Oa/vGrA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(346002)(396003)(186009)(1800799009)(451199024)(38350700002)(38100700002)(478600001)(2906002)(5660300002)(4326008)(8676002)(8936002)(66556008)(66476007)(316002)(66946007)(41300700001)(36756003)(86362001)(1076003)(26005)(2616005)(83380400001)(6486002)(6506007)(52116002)(6512007)(9686003)(28333003)(15583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0YoSFlCHXiStzwz7mx0mh52ZCZH2h/x5o8LdgqHk9C1tG/kRPs187QPzIoET?=
 =?us-ascii?Q?OGOpQ4jS104EHwWm1+Vab/+iXMOq4n9VfGR7UIpMdnDfXsooUZbaHnlwZnAJ?=
 =?us-ascii?Q?0bsayN7JRsWUeIzz+/k7LmQFyrsN8bU49ykGG7FqQOHLeZTLiqzeQzsQMbs9?=
 =?us-ascii?Q?VFZh7F5kykcLBsPXfaTi+vVsjceb+5gil3DZlvuAZWdCg3mPmUXZfYB9CT6A?=
 =?us-ascii?Q?osGeIfr/Y6HpVpaJBYrBfC2tn83zTQ1ada+F0Bw9IpskWY0JBS0Hbjyk+2gs?=
 =?us-ascii?Q?F123QjaVRtdrl/jLUbV7SZIDAfi9MWiffWJaHVGVNZyi7+AkW51W2dvJwQPw?=
 =?us-ascii?Q?GqymWE50Gt4Ztkv3mMfvFVrEuy+w3TgKjm7VLkhaO5Fahm9jVcBfFHfr2ku+?=
 =?us-ascii?Q?fLb75aZia3XWHi/eZyt5zy9uXaqUrllngQ+Qfs6N0m02bP4xRFcELzGjyOAk?=
 =?us-ascii?Q?Gfsttfh27dRs7BAonbW+fF+TPiSBioDRYPiAsxMFPmiHftREU1UxMDBmaFTS?=
 =?us-ascii?Q?BCLwM3ajPIZ6+S/lqIRcpHnPNXPYEQ0fnyCYw2/IPDiA44lg3KQNpq0i1n7t?=
 =?us-ascii?Q?zBMXkDs1EjQ9u6UmB2ckCaZq02z/n46vn0XF3LlK/JNAFQpAjVjqe55nSTm6?=
 =?us-ascii?Q?3AngdZaaN4ytz4WDqlTHwGJ+rddZsm7uUyyiLbWt5MtNqD8s5K5Y8LlZssBZ?=
 =?us-ascii?Q?akAfR/AkwojW5/2laANLLN0Ph9FHpXvOjDO2U9FyENbliOtVIPF3Di4VO8QJ?=
 =?us-ascii?Q?zCgQAhyb5z4U2rWmxxhoTSiwFgT8uZKKc0JPX1eAlyND9DOBGenCsORd8iok?=
 =?us-ascii?Q?MA2hZEEnH1q7w7Bp82VmIH002bWV5RdXIfHdbsh1X/0IEXDs1hfGB89k/wIG?=
 =?us-ascii?Q?35thCxhaCFDiJtNiStV4zqAqsq+oYcPcnbNKK1nhaCU1OeIhM3BMRvsktWHa?=
 =?us-ascii?Q?1ey3bVaQTX0Ed4ZG6u8X64k9Aa4Zq2sm45j0rbROGwGkLssXFy6ctM2ChJee?=
 =?us-ascii?Q?7EQrPLT1C/mB3zUBkE1iS0mmwrdj6duGm/hHpDdD4llvrvoM2zfWC9+PZw0R?=
 =?us-ascii?Q?jbiH3FjczJj9AhK6O7EEtngiftHhYVYL1ZADc7ROf4Fs5yXp67SuSvwiFKdV?=
 =?us-ascii?Q?nawjAYGu1Udb8OgSm7fD+OJ7gUAEkNCxy+3u9vk8L+nn/zmJXfPIhowN67jG?=
 =?us-ascii?Q?z1OjKqTofzVwKm4o//oXlX03783jfMTtTPsJaQJ2wOFDUNDE4jhDmLKIpbh9?=
 =?us-ascii?Q?Pwf1g3KJrGTrjuHWep4AAq+iiuOHZgIU7Vug4d3in/p1MxwZUwsxIK034oB7?=
 =?us-ascii?Q?HM3ahSILa0G/IaY4rLJ/KBI89PmtesHP/bZL5yyQipIofUphxLJ9afH3f36r?=
 =?us-ascii?Q?Ac4mQd21qFviX2cOp0I6LrD5TLg4gqiuPgza9qXz+Q5QIIapGKQxxCVPVbCE?=
 =?us-ascii?Q?WBvfRItMp0/mVji/apUyjpfQLgPgE0ZbktCAeKR8ttnh5JFFVZUw6Ax0cGHN?=
 =?us-ascii?Q?HbOaaFURt1FlKR7J61q0e7wWssRjBl+V7FOLUD7GJAB2XjMNIB2gJUMPX+uy?=
 =?us-ascii?Q?Hgl7S3APeexAih55ruoNXcl6yqNz6cD7yz5vrZjJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e7916e-0449-4950-f000-08dba9d18b47
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 03:22:45.6201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHb3vlqsVzHJQfiL3iadD9xMxCUSk5Q5Y9ptERpzJCjY8hEsWn94FodumK4SlKuTKXrABj3NZ0z0Mh4PeV0BEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7969
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Current manual tuning logic only get the first pass window, but
this pass window maybe not the best pass window.

Now find all the pass window, and chose the largest pass window,
and use the average value of this largest pass window to get the
best timing.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 52 +++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 6170b7121f36..4cbbc0a786a0 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1154,32 +1154,52 @@ static void esdhc_post_tuning(struct sdhci_host *host)
 	writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
 }
 
+/*
+ * find the largest pass window, and use the average delay of this
+ * largest window to get the best timing.
+ */
 static int esdhc_executing_tuning(struct sdhci_host *host, u32 opcode)
 {
 	int min, max, avg, ret;
+	int win_length, target_min, target_max, target_win_length;
 
-	/* find the mininum delay first which can pass tuning */
 	min = ESDHC_TUNE_CTRL_MIN;
-	while (min < ESDHC_TUNE_CTRL_MAX) {
-		esdhc_prepare_tuning(host, min);
-		if (!mmc_send_tuning(host->mmc, opcode, NULL))
-			break;
-		min += ESDHC_TUNE_CTRL_STEP;
-	}
-
-	/* find the maxinum delay which can not pass tuning */
-	max = min + ESDHC_TUNE_CTRL_STEP;
+	max = ESDHC_TUNE_CTRL_MIN;
+	target_win_length = 0;
 	while (max < ESDHC_TUNE_CTRL_MAX) {
-		esdhc_prepare_tuning(host, max);
-		if (mmc_send_tuning(host->mmc, opcode, NULL)) {
-			max -= ESDHC_TUNE_CTRL_STEP;
-			break;
+		/* find the mininum delay first which can pass tuning */
+		while (min < ESDHC_TUNE_CTRL_MAX) {
+			esdhc_prepare_tuning(host, min);
+			if (!mmc_send_tuning(host->mmc, opcode, NULL))
+				break;
+			min += ESDHC_TUNE_CTRL_STEP;
 		}
-		max += ESDHC_TUNE_CTRL_STEP;
+
+		/* find the maxinum delay which can not pass tuning */
+		max = min + ESDHC_TUNE_CTRL_STEP;
+		while (max < ESDHC_TUNE_CTRL_MAX) {
+			esdhc_prepare_tuning(host, max);
+			if (mmc_send_tuning(host->mmc, opcode, NULL)) {
+				max -= ESDHC_TUNE_CTRL_STEP;
+				break;
+			}
+			max += ESDHC_TUNE_CTRL_STEP;
+		}
+
+		win_length = max - min + 1;
+		/* get the largest pass window */
+		if (win_length > target_win_length) {
+			target_win_length = win_length;
+			target_min = min;
+			target_max = max;
+		}
+
+		/* continue to find the next pass window */
+		min = max + ESDHC_TUNE_CTRL_STEP;
 	}
 
 	/* use average delay to get the best timing */
-	avg = (min + max) / 2;
+	avg = (target_min + target_max) / 2;
 	esdhc_prepare_tuning(host, avg);
 	ret = mmc_send_tuning(host->mmc, opcode, NULL);
 	esdhc_post_tuning(host);
-- 
2.34.1

