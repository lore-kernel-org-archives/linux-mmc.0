Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3FFC10F1D
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Dec 2022 02:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbiLWCuG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Dec 2022 21:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbiLWCuF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Dec 2022 21:50:05 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586911F9D6
        for <linux-mmc@vger.kernel.org>; Thu, 22 Dec 2022 18:50:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjRcpI4fmTBlvs8G/UBnj0suGDcE/HyowHcfTkuDcFPONyxCvBkeGU/xYBeawiZ3QOOo5G+lVYzlyCs66mvl3CfcP0EE3Hq9rZdkn29YrtCHsJCu60CvFKOwLE1Lovsibp7NihCWTTElTzYHWt99p1Hn2XB4PMKfZgAtjCBBu4GmK13qJFk7cqQgYn71bQw7XVOW5f5DHPnyiJDcF/sbwgiPMr1Th3o1YTeObuWaoW2+yQ20Vyy9Oa2JqqLac6bvCQQqe/kyLfWjlRgTpqPIFBb/Zymtb9a6W1fLmN1xENZHcDfc93u3A1A7V4nGiiT1hiannqSex1js7RV2m5SISg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8uRlppJfmpn0m29G7TvPlOTMdCnlTuaGNK/V/1nB7M=;
 b=UMEv1WvHk5HfGnzeSd3fEI0XB3KkSMF0Z+5kism0IlSSNdqOdJRmrfmeUct5aCFyZblGjdEIggzwN47ingQ8JV7NCzXmgX3rXT7YjrVGEwQaZGsZaf8URluZJLpDVJ4fSypzW0FHMWWDgz1hU+WkpI4tYBknj8f+iLHEULkBZAJF5Tm2hWx8Dpy7tRXIKd25EpAZTKeatUaGor7tXkCa7adGGSlz2UaDdaAyLN8UBlzrE26q1e4y4B924aaEwnY2jQNC7CQ1llKLPXTWRF2nHaC7H7pR+cWsac1Y0V0yWw5zmTyG2IZDLRadoTJfiA/mwj0+x4WerRrvvSa3osTFXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8uRlppJfmpn0m29G7TvPlOTMdCnlTuaGNK/V/1nB7M=;
 b=Cczj8qVe1oEswhC4IwnkYFC8ZNVjWvbV+au2cWVJMUYhKCrgXEuMeYYACSIhs209wB7ProhFbFn1jSTMcpf3moX+G+VOA6VnKUqt/lobpQdXLxd4HkOxUhh0G98GZJYJcW+wkadO7T3wQREGR1d/fcOk70nZNG5S5zuyFNXiw9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 PA4PR04MB7709.eurprd04.prod.outlook.com (2603:10a6:102:e3::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.13; Fri, 23 Dec 2022 02:50:03 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.5924.016; Fri, 23 Dec 2022
 02:50:03 +0000
From:   haibo.chen@nxp.com
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        kgroeneveld@lenbrook.com, haibo.chen@nxp.com
Subject: [PATCH v3 1/2] mmc: sdhci-esdhc-imx: simplify the auto tuning logic
Date:   Fri, 23 Dec 2022 10:50:21 +0800
Message-Id: <20221223025022.1893102-2-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221223025022.1893102-1-haibo.chen@nxp.com>
References: <20221223025022.1893102-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|PA4PR04MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: 074b66c3-44e3-4dde-22d9-08dae49063e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LxgKP1bZWOGwOh2CJ+QAdu/Xhf/aI4rpj/+8Bi1NFFOifDo3pOhaSjQVqozTb+ksIz38iyprtKrzglhrgyjC1IrOubZ/Xm3kiLZZpFTG1Ssvu/We40zlU3A9Rj4tzu9WiLKJzzyXu3FVQK9PFHFQOeSPi/B4vzY0lQqTIP8dy6y2zfsC0mGg4O+VyuNsAyKy/0kl68Bmxs5++H12/KnB/T0LJRK1M4+FInqX7Fp4He6a5BIODkLUfzkXog7pFAZcEkpfumLfQeK4KXxZkEzA6/fA38F9Cu/9mHexZfFWZRilOs1jXWugGVr4dnXwEEAaBdxdrrPXEM7N6ALb/xyNIgy8dDAdvYKjecLMMa/dEjAT0hBbHDPmFmVNXhWixNb+DfM/WZYbgU13Wh1ChC4LgMwxyUEpnuqmhJBxCmW3fqcxHbzQNGl2xQVBbndc355zPID7vjBF9O6S/zL+7VDjfiHJgx6o1jjtdLDKgoJQ2KVYCrLVjqA39QUzVpk+G491AX8gRfGBvFhwStW4hvXraP9JLgcc5Z9dZCWUJ/6Jsngxct7SSyU14thMpJ4lUCxguvCEZxOsgnYiRCYusDwGhlSJVoWv1/jsSKsFNATyFUHer4pGh49KcUPg16gUikwiXX10KkHyXZwLS/8vNWnoGfX7HgFz6oLEB0GWb02q1snIrcJFXuGTGZhcZbKdDr1UoRoC7OmlILwOzXOeY6pIZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199015)(2906002)(38100700002)(38350700002)(36756003)(86362001)(52116002)(1076003)(6506007)(6666004)(26005)(9686003)(6512007)(186003)(6486002)(2616005)(478600001)(83380400001)(5660300002)(41300700001)(8936002)(4326008)(66946007)(66556008)(66476007)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mkM7Wc7tz82j3jGzAMIm2JRplghBvxtWo/nX7pjpUhkB01+D3oAURZ3dn9ko?=
 =?us-ascii?Q?5sORynKldJzzAyuk+8rJYGb665O9ogGydmN9y9h0hZrqikrEjZzrXjoMD/6J?=
 =?us-ascii?Q?C3sdl2PH8+eTOrbcbLlqBjuvmclh4OdgzR+LDGRYNVogSj0uhzdcE8WADBcr?=
 =?us-ascii?Q?5hQ8IYjMFldcxp96vSBZL34HH14iVFBK0xqw2RD44aRbG6NT4hQX4jkmcYea?=
 =?us-ascii?Q?sZ7kxTAOXJl4ngtnDI0N5zwgObdtFtc8IniA9VbmbMUmUMMlw6MddlxuWPrw?=
 =?us-ascii?Q?uVmQSETUtV3WEncdmyypN7ouwDPAvytjjq/tGT/z7kSqiZNBM1cxX4a04jgN?=
 =?us-ascii?Q?ZCBYR03H95rZQYb73c6gdUyeM60cZFl7zEt8+X2uqRKC+aXd7Gv8x6OBhcmc?=
 =?us-ascii?Q?5wJcONUXicjSdPcui2MwCtCG0l9Eul89G3dhAPEt0KO3s3EijhBvzBl6xcpg?=
 =?us-ascii?Q?ZV9FBcGGlIPtrZDMp/h/JO3tob6+qYp16xe0rVqsze7RUVIdnr8uQbrlbeYh?=
 =?us-ascii?Q?LjFZp8gMIaelcWhstyxHYpWqocndT1kqCUKYtp8ToyFQmB6nyj8EqaPd9cDz?=
 =?us-ascii?Q?TTQP1xr/OIrLoLdI+3DaB0bTTz2zH0oPRZBxMnJNc42PZk/K+hJJ8PFReKxN?=
 =?us-ascii?Q?6Qea47iZ6qHe702u3D+RzFftnCVy1ax9ISSvxeEvCvfSHLTaOWS7UVt/78Tg?=
 =?us-ascii?Q?i6UkgM/gYiiFr/hqW6DFthgMr7HMqdsBzbe7ZlsXArJnGxGlM9EMCdN0y+mn?=
 =?us-ascii?Q?kCxtVhyxtEKKJMZLQW3JuXe3D5WTV2gTKF8qQwsXJLGdnZuusiPwAHjPcsRl?=
 =?us-ascii?Q?vDJcLtNbaAatwY8ueerLaNrjy12iqjBzE8fwT3Y/F/TQXXPlWj9l0pMYbHfO?=
 =?us-ascii?Q?xF27t7L6qPkJw0IpCd8hiJU9F92tVEv5ZGKA47/vtLJe1zns8c5114yNfrtp?=
 =?us-ascii?Q?0/M07JMHWhkaaz6t3Duh53UfPDrX+86QVwuI/OVN4zPOfRrOjXte9Di/eWsL?=
 =?us-ascii?Q?NB9ZxhM0Ys0bYaqEv1VbBwWosUYLZ17J5C8uoL11GJ5RQOpQk1tR2e1oooFC?=
 =?us-ascii?Q?tFYhow3lbnm6D5/GYdNYpXId76+9LTMYUSmpZvjMfrqIyeZudwfg1muEAnsJ?=
 =?us-ascii?Q?FUQ8hQI57Kdks7sxY1ydViT1M0mF+Sba1CmHUrtnYb5FOs5nrCBjRMd7qQIM?=
 =?us-ascii?Q?x3uIdUgnIK6PIGmMLFweiTZj6EoAt3cIh+e/xrMm2bWIz05Vruw4u33nR6+y?=
 =?us-ascii?Q?iM5bGFdaSMEsimlSirxVZfzGHXnEDTkzvD5TALcVDvkG19whqplnszHL2zq9?=
 =?us-ascii?Q?wqlKD85AewPaQfCF+b5IVaCcwZc8IIZB2McCpxU/aTYFjCbZ+cJF4t6RO04Y?=
 =?us-ascii?Q?p9lJ1ujCEZLwA2FKw5/SB5BkjTEzmihw13pLpXUTtBUAURRjKb3ITcjjlM0k?=
 =?us-ascii?Q?bYWPpRabm4nE3JTFQqCs/4j7gtNDqMNm1lejgvugRbPSUidyR1OkPVvgbYRU?=
 =?us-ascii?Q?uzTImuqG2TMjyYy2qxV3Z+PPM2JlKpyuPIVWdykNKgI2VwOLQ1z82UsL3Zvn?=
 =?us-ascii?Q?SBNWiUsCKB6YKvD1wEw2+W9cAqB2R7Q+A2hrh33o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 074b66c3-44e3-4dde-22d9-08dae49063e8
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 02:50:03.1583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nN7el/rw+Ei5FgsQHnExqvkrqnnwROHpOzA7A8Wx0t7+fazQk6rKE0ISTwe1dlU/3w5AQPY88f6RQWpJaapkAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7709
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Clear auto tuning bit when reset tuning, and enable auto tuning
only after tuning done successfully for both standard tuning and
manual tuning.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 89ef0c80ac37..bf8d6f60a9ee 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -429,9 +429,10 @@ static inline void esdhc_wait_for_card_clock_gate_off(struct sdhci_host *host)
 }
 
 /* Enable the auto tuning circuit to check the CMD line and BUS line */
-static inline void usdhc_auto_tuning_mode_sel(struct sdhci_host *host)
+static inline void usdhc_auto_tuning_mode_sel_and_en(struct sdhci_host *host)
 {
 	u32 buswidth, auto_tune_buswidth;
+	u32 reg;
 
 	buswidth = USDHC_GET_BUSWIDTH(readl(host->ioaddr + SDHCI_HOST_CONTROL));
 
@@ -450,6 +451,10 @@ static inline void usdhc_auto_tuning_mode_sel(struct sdhci_host *host)
 	esdhc_clrset_le(host, ESDHC_VEND_SPEC2_AUTO_TUNE_MODE_MASK,
 			auto_tune_buswidth | ESDHC_VEND_SPEC2_AUTO_TUNE_CMD_EN,
 			ESDHC_VEND_SPEC2);
+
+	reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
+	reg |= ESDHC_MIX_CTRL_AUTO_TUNE_EN;
+	writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
 }
 
 static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
@@ -681,14 +686,11 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 			} else {
 				v &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
 				m &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
-				m &= ~ESDHC_MIX_CTRL_AUTO_TUNE_EN;
 			}
 
 			if (val & SDHCI_CTRL_EXEC_TUNING) {
 				v |= ESDHC_MIX_CTRL_EXE_TUNE;
 				m |= ESDHC_MIX_CTRL_FBCLK_SEL;
-				m |= ESDHC_MIX_CTRL_AUTO_TUNE_EN;
-				usdhc_auto_tuning_mode_sel(host);
 			} else {
 				v &= ~ESDHC_MIX_CTRL_EXE_TUNE;
 			}
@@ -1022,13 +1024,15 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
 
 	/* Reset the tuning circuit */
 	if (esdhc_is_usdhc(imx_data)) {
+		ctrl = readl(host->ioaddr + ESDHC_MIX_CTRL);
+		ctrl &= ~ESDHC_MIX_CTRL_AUTO_TUNE_EN;
 		if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
-			ctrl = readl(host->ioaddr + ESDHC_MIX_CTRL);
 			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
 			ctrl &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
 			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
 			writel(0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
 		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
+			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
 			ctrl = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
 			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
 			ctrl &= ~ESDHC_MIX_CTRL_EXE_TUNE;
@@ -1054,6 +1058,7 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
 static int usdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
+	int err;
 
 	/*
 	 * i.MX uSDHC internally already uses a fixed optimized timing for
@@ -1068,7 +1073,12 @@ static int usdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	 * correct delay cell.
 	 */
 	esdhc_reset_tuning(host);
-	return sdhci_execute_tuning(mmc, opcode);
+	err = sdhci_execute_tuning(mmc, opcode);
+	/* If tuning done, enable auto tuning */
+	if (!err && !host->tuning_err)
+		usdhc_auto_tuning_mode_sel_and_en(host);
+
+	return err;
 }
 
 static void esdhc_prepare_tuning(struct sdhci_host *host, u32 val)
@@ -1102,11 +1112,8 @@ static void esdhc_post_tuning(struct sdhci_host *host)
 {
 	u32 reg;
 
-	usdhc_auto_tuning_mode_sel(host);
-
 	reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
 	reg &= ~ESDHC_MIX_CTRL_EXE_TUNE;
-	reg |= ESDHC_MIX_CTRL_AUTO_TUNE_EN;
 	writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
 }
 
-- 
2.34.1

