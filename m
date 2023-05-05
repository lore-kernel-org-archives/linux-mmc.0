Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F373C77B7D
	for <linux-mmc@archiver.kernel.org>; Fri,  5 May 2023 08:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjEEIrd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 May 2023 04:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjEEIra (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 May 2023 04:47:30 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0358F18DD1;
        Fri,  5 May 2023 01:47:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xe79NWp0imx7AnwUfPgwuSopYxMyuc/wyJDJo2cPD9DP3EuB4K+XZqf1Zq7ItwGoU4QQfu1mLyb45pn3/K3TOHtgq/7BwczcHo7/dZc1sNvfV90l7CfakbYYmcyx3bpfizuSyE7TgZhDgOwgRmbfwntCEd90iUbWcrSboFNZQX2ZXyTpT5reuAL5Dvbajo8kVcFNpBV2gF/lyalOI/5JSxg9UEQ65Gx2qVRiFggaywp+qeHH26+JYyY5/wBcwL+siNhZiap+LJSZRz6b+tG5AoAG/t8iMRiXZed3IQmAAuQn4vI74lrPRWaAZkU31EUg5tvRCYl9mRonCdeqbycp1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+k1mx8fDIGWP0iLTt0GLKxlUYwIIkQ4nAg6dUaaZEX4=;
 b=GMqEOJ7GITmdQYjRtg0RTPodbuEPQpAKNTbQtUO18X6tuQVGAYkhhDc4yj0p/w24PzWUuZKouZJARLS3/qHwX7CrRAeUVZxwAW9MThNaSHagoUCY7GB4AIFBmCPDMongAp2FHCBodFvp154Y/fux+oTdK/L4Y/8TvQFJk05dBZ9ee4An/KR3G6aMtpKD+mP1yZR4rtp9wJtuIaAE87y2poDQ6/Hnmjp0qgoJIOlpjNM99y+JdbYFJpwpea30A6hBMF9zj7NU37QUgSOwRo8msheEVN7DwP8tDgXc8IPxJYlBTMJTDC6hFq2m0Rfc7xsl/upD6qvDqvx80dHspBknuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+k1mx8fDIGWP0iLTt0GLKxlUYwIIkQ4nAg6dUaaZEX4=;
 b=onCmhHsGeDkWr7Yi156rJj3Pw2fPQCoItqcShQxGYB1Lp/CPGjUZ4cYWvlArQ5SFUgy1a8HueT68rPU25v+THnEQJH23IHC3TbZ7uXNZP/6yY/0uPrPVAjVCm+2DHr7OfGuGChkcf632BCnDQOYeZp9BRa4hecnc4qHW7h9Frfg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 VI1PR04MB7024.eurprd04.prod.outlook.com (2603:10a6:800:124::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.27; Fri, 5 May 2023 08:47:24 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::9d1e:facb:ae5a:25b6]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::9d1e:facb:ae5a:25b6%3]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 08:47:24 +0000
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, kernel@pengutronix.de,
        festevam@gmail.com, cniedermaier@dh-electronics.com,
        devicetree@vger.kernel.org, kernel@dh-electronics.com
Subject: [PATCH 2/4] mmc: sdhci-esdhc-imx: remove redundant write protect code
Date:   Fri,  5 May 2023 16:49:53 +0800
Message-Id: <20230505084955.238940-2-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230505084955.238940-1-haibo.chen@nxp.com>
References: <20230505084955.238940-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0121.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::25) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|VI1PR04MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: a95e98d1-43cf-4706-489f-08db4d4558d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zNhPkBdvoN2oqmgTPmbHeQeEIJd2Tgsq04akCSkAd+RFTgMGjnNJBTM2D+QhRa2QI+gl6F3nswrUcCaAT04ycOUwQnuQPAbBJDE3mbtYPeTwsXyTD7XwGaqihcjCpnxVFdXC5I3lCqGMij8UAluERo1g5OsauslHr+UzP6UCql9SnsUPrudUY+OUyuD6bCPzzFto09dryYMxmSXdUHOht/LdxZ/BPKmnztCsI0IDp/qgEwxitCCgAoLoJoc9IKT521kNuFEho/+4Hqg46FUfMF0LZmE/Oc2XBJz7sE4+WVfWFER5NQPKLQs53oJmUBUFFwaDPAvojuryLVgJk9MpNHWV5Q/wTkZtcG0U+OdO/+q6eqIRkZrYReukM6Hhw3mpvOqlpMxMo04tVIsWekZm4BeUhDrryR8CZyosiS/D+i7U9NDXIfmfyN4EVNtmxGC4qD0k9KqtEY9W9BJ+OIGnmTujD0aOsGZETLLziRTukkCos3o8O/IMsvrY5iui1EUG6FHR2G9BqH8ukbrpEB7jUsiR7hH5UgoP/HnT4pF8hrYe+5GkuVFhQ6Fx+XSamLDFuTAazk0tYDSFqVpjOBzvX47o+sqSHqUrz5/LUe9LAbB2bhFll2KIdqdBtuwORDVs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199021)(86362001)(36756003)(6666004)(52116002)(316002)(4326008)(66946007)(66556008)(66476007)(478600001)(6486002)(41300700001)(7416002)(5660300002)(8676002)(8936002)(2906002)(38350700002)(38100700002)(186003)(2616005)(6506007)(9686003)(1076003)(6512007)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nz5vVxYj1MBBi6hLMloebqfgg9xWofzSzNT73UjeWmkkiWdos7yDT7wwX660?=
 =?us-ascii?Q?6gOqCjFub9sdYhHh+eEkIB7yLIxFxVta+xz2UiydCzwPJmp9ogIs2FZDByIZ?=
 =?us-ascii?Q?VERl1IjSyQDhL3NQ5wBdo8QPbimxRSBZdj4wLaEuf0Dh95Az8h4cPwJA+fPs?=
 =?us-ascii?Q?xW730Av4XKuekmlSOekQYXVufZIiUoqocE5hn3JAUipXkkQHFVUjl/RnQrSm?=
 =?us-ascii?Q?4tHKO7y4aczoEIJaRSgoanpOLNHql8hIai4kEscFZnKo8pwheCB2rsuQCDCc?=
 =?us-ascii?Q?zlWo7MLGyv9TmPJmys51a9bgzpTqWomaTOaP28PGGiPfRJS7bRuFjAFlnoGS?=
 =?us-ascii?Q?+sDhd/Qer6PxEMjXRr6CAMDyU9ICWXyeeP/Rw+91eRq9BWnu9Yk1bNQA8aG9?=
 =?us-ascii?Q?lT7BhHEYkZBQiK04ycFhuF8Dz+YXWv3QRZ5goNM/og/AbK6/tKH4Fxw5qgg6?=
 =?us-ascii?Q?N4GOuY+WYp1JAMU/YQXCr7aSAhw1KlHLs59ChVlWDTQUyoP0wFmgHjW+5N9n?=
 =?us-ascii?Q?UuSgwf+Hj8vFHwTHYXXbegbu9HNIJUhC74yTygIkNOVuVutB4RMjfeumdxJD?=
 =?us-ascii?Q?umzh+g7XLo+qqz4u5/LdYQGgPgDS2RAYgJhuvk+ygl8dfT34NYWvgM3xS9JU?=
 =?us-ascii?Q?4vlC31WzPM8VOnAXDqfI0KnlkdDTjaQktwX5+olUVeMo8drAuTJjR2nUlGYN?=
 =?us-ascii?Q?WrHODxBQ31ODymjHinpHfwOfFjO7kHy6Nn/s5d8BowUZzcWAvk7jZ9ai5TvG?=
 =?us-ascii?Q?Kuk/9m+iK/uo9DT2fI6+zBvIMl2QBBS3//YKN0LNUKTUefixnWrNsROB6mPv?=
 =?us-ascii?Q?AWhcU3vK9yBJQDhuOPQm+xy30FhGBx33bDM0HIyjQ/jK4VXBep4jgos5YkUd?=
 =?us-ascii?Q?OBaY2eX3dBXZcjd6jFzyX4E5RfwIHmnUPoM8spdTdcpsh4z+aYC4WyNKKDsw?=
 =?us-ascii?Q?2Jb05FEMpmMYKvbcSpZubuUHSoinr3oBjhcxc6cppYbTpCj+5lmvsHmss0WI?=
 =?us-ascii?Q?MzAOuR/jLIvm2JqUhTL5oJptW4ct86DvcgusUUWaEzmkmRLXIS5kSKqrSPRj?=
 =?us-ascii?Q?KiyV0zvyY7gbKr8250jO8T1oL3fA7AXDni0wRjWQnW5LbQLtdbKqUxzVmQus?=
 =?us-ascii?Q?eMnOy2S52KyeyahlYC4aEyo7uwt+/FV12F/+el9oEml0urYLkd4gNG85A03E?=
 =?us-ascii?Q?POh5gPoA8FBOt1RR8Q30MMuRPS9Z/GP3EuZBtqKqjjKMogBnqMrF0c15eVXO?=
 =?us-ascii?Q?74A04nP7svdGJX/ndnHsjXytQTOtyuWFo/HF7E1QPAFtz/Btrc6z951wkk8x?=
 =?us-ascii?Q?3JD/hGpWBMEQ/UnPN5v8+nc7cE6nFW0kWXUqSsgZBpqIz/eOWeCCSeyKXPbL?=
 =?us-ascii?Q?Ndrp7/BvTg9HBcn7pGxhYRS1UZ6jYCHQV84Dw2hhJ/bI77Y2p+4tdcoeooT6?=
 =?us-ascii?Q?TYhcEUa3nU4zPVh4dZeu2VG+A0qeiVdXzadug+A7GDYmJnPNzhoCef1vtr17?=
 =?us-ascii?Q?UmDcdfS6tfjp4eeDAdLYDxYTg4Ic9WDTG/tQiOdkhrKgVdDnTWZxupBjnPM5?=
 =?us-ascii?Q?VSAR0ppf+iHQUDLife0TM85AXN8qXAVCnNx8hQSP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a95e98d1-43cf-4706-489f-08db4d4558d9
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 08:47:24.3626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zls6IkFVDqO+De1FhEKsBsN64A2X6pWk5n93lNnIaTQGu97weo4JA0yOtgb+v+Jq6t2sbAf2EqvOhP0gTRHBYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7024
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

The logic of the esdhc_pltfm_get_ro() is just the same with common
code sdhci_check_ro(). So remove this redundant code, depends on
mmc_of_parse() and sdhci_check_ro() to cover the write protect
logic.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 47 +-----------------------------
 1 file changed, 1 insertion(+), 46 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index c7db742f729c..54531aab70f0 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -201,22 +201,8 @@
 /* ERR004536 is not applicable for the IP  */
 #define ESDHC_FLAG_SKIP_ERR004536	BIT(17)
 
-enum wp_types {
-	ESDHC_WP_NONE,		/* no WP, neither controller nor gpio */
-	ESDHC_WP_CONTROLLER,	/* mmc controller internal WP */
-	ESDHC_WP_GPIO,		/* external gpio pin for WP */
-};
-
-/*
- * struct esdhc_platform_data - platform data for esdhc on i.MX
- *
- * ESDHC_WP(CD)_CONTROLLER type is not available on i.MX25/35.
- *
- * @wp_type:	type of write_protect method (see wp_types enum above)
- */
-
+/* struct esdhc_platform_data - platform data for esdhc on i.MX */
 struct esdhc_platform_data {
-	enum wp_types wp_type;
 	int max_bus_width;
 	unsigned int delay_line;
 	unsigned int tuning_step;       /* The delay cell steps in tuning procedure */
@@ -994,25 +980,6 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 
 }
 
-static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
-{
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
-	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
-
-	switch (boarddata->wp_type) {
-	case ESDHC_WP_GPIO:
-		return mmc_gpio_get_ro(host->mmc);
-	case ESDHC_WP_CONTROLLER:
-		return !(readl(host->ioaddr + SDHCI_PRESENT_STATE) &
-			       SDHCI_WRITE_PROTECT);
-	case ESDHC_WP_NONE:
-		break;
-	}
-
-	return -ENOSYS;
-}
-
 static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
 {
 	u32 ctrl;
@@ -1380,7 +1347,6 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.get_max_clock = esdhc_pltfm_get_max_clock,
 	.get_min_clock = esdhc_pltfm_get_min_clock,
 	.get_max_timeout_count = esdhc_get_max_timeout_count,
-	.get_ro = esdhc_pltfm_get_ro,
 	.set_timeout = esdhc_set_timeout,
 	.set_bus_width = esdhc_pltfm_set_bus_width,
 	.set_uhs_signaling = esdhc_set_uhs_signaling,
@@ -1588,17 +1554,6 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
 	int ret;
 
-	if (of_property_read_bool(np, "fsl,wp-controller"))
-		boarddata->wp_type = ESDHC_WP_CONTROLLER;
-
-	/*
-	 * If we have this property, then activate WP check.
-	 * Retrieveing and requesting the actual WP GPIO will happen
-	 * in the call to mmc_of_parse().
-	 */
-	if (of_property_read_bool(np, "wp-gpios"))
-		boarddata->wp_type = ESDHC_WP_GPIO;
-
 	of_property_read_u32(np, "fsl,tuning-step", &boarddata->tuning_step);
 	of_property_read_u32(np, "fsl,tuning-start-tap",
 			     &boarddata->tuning_start_tap);
-- 
2.34.1

