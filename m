Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F85CDB483
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Oct 2023 07:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbjJQH0j (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Oct 2023 03:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbjJQH0i (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Oct 2023 03:26:38 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2047.outbound.protection.outlook.com [40.107.8.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B062B83
        for <linux-mmc@vger.kernel.org>; Tue, 17 Oct 2023 00:26:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfYILswWjG9VYA7UTII3mSPEyjOX/2wT+bwjyYNUCym2F2tmfReTQ3E0G4qpukBDEHkgOlbaYMcIbqInRqWhT5baKo+oVcwhAsyxPkGWEuOzvKAnp400Xq7c0xfyenAXE9ZwsRbdFEi+dmZA+FjKJ3z/UuibrByuIzSiJ3vUtcI6kei8Wl2CEdvHQz/WEuOtpIIe3h0o+Ac84f52IwcnJj9llanPktJdgk6+HJ03/mmkpQUdCSFaRVHZ8clKqcU3Hy9npzULZotGE4BVCJvGZwTUWP35HonHo4XjZP816Ukfre5GnhlB/xRX/7x4d3bpqdaLkh3tUZDZMflcFBiJbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mx67icOaOItH+VC2LwWUA2rwtXYPfFtyumnMCXIO8ZQ=;
 b=c2PogFHZs8BIRXVrbCMzAca8XHCU3w/c7uYuGBX9BG5pfDshBitG6lxNQnHYwNMge54GEYrEDGqQZGiJH4yyAdvXsLMJfP1K8O7bbQ/nWaAcj6quYt5eEAVSxLkrVP8GfK1cRPi0Hym7S246vlJW5+x7P2gY1ZZK74zTQG6qr1lRPJyhPUroI9FXa1AxhOYxbyzdb/0+SlTni5TeCupNeMBqR/DpIb+oAtRirg4uKnL3gGvSrVh7kUfOWtzQ5xz6KXHR1ucNRcDXWpV5gy9H7cMohgpSrvvgpcRA8QOXj8y+TDUZrcWV7Lo4r6ufU9v0O+3ryNDAbczRQua/MwA1WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mx67icOaOItH+VC2LwWUA2rwtXYPfFtyumnMCXIO8ZQ=;
 b=Kx0saMiI+l5G6vAGiiT9Yrvv6j6Q4lGASsH6KxtYRbyEy6tb29XcHPMSIUJQ8zEJQzVdbn3Z6vnczgm3dAOny7FW95HNPZqPaUiL1DHeUe4U0FMnMSK2u2BheJsRmp0xMJUGbViu/mrzi32vWYOIdMm3UpSUutfIYf1EP8ByfUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 PA4PR04MB7552.eurprd04.prod.outlook.com (2603:10a6:102:ec::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.21; Tue, 17 Oct 2023 07:26:33 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::e796:8366:5d4:4188]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::e796:8366:5d4:4188%4]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 07:26:33 +0000
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Subject: [PATCH] mmc: host: sdhci-esdhc-imx: let usr to config the wakeup for gpio cd pin through sysfs
Date:   Tue, 17 Oct 2023 15:31:29 +0800
Message-Id: <20231017073129.1406748-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|PA4PR04MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e79c9a1-9311-4b01-4dfa-08dbcee26346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CC/I26CTFqYQLxeWBN6wq9JC357USYYqntJIl7SktrObS0jIwPYeqaUCMRvTuySUUo9I/HOhOf4qcUuqjdAVPRLswP7GLXWwsL7YRmG+8u7PSPvelK9TSmhnIYyWvkrtW1eXVBNu7L2a1EEdKun6vcjI7JmsIGFeVnf3Qs1BrUMjtJvPWOqYDPIwiie+o10El7ZjWba4fqezTo1YrB/G/yEM7Wt6L4e5Ht358A7EWrn/wjzJTvhRcTgaTPqjFV5uMKbV3+nefnDFZOdPfQrJkRtnexijCnIqUE4WU89jYz3CuNSv756Dw5aO5h1JM4+RfvsZe5smgHZBE83/DBWitOYhQpB3LjOQAxRQHh562VnVKDSnd5EhUv7D8+0J1grd05b29gJrpDzN3QeACX5KDx9gkFS88gu1HuKLIdYqoFOxEIUb8+jdrOzW1sZ2ruJXfhpsC+rfa6KqP8PU7ER6xH/mCNviGSvjgPOHawTUBTRoUDuaB2cP2+wJxxBK/7JmxHKkjWiJdXxa8vKMpaz6O30AzRJNGvnDnUah2uB7/x8WugIJPFpmSnVoyvgyy84t6ChNKOHlzUjfa54eLoZqzNOl4DoFPXzhTBTQOtKGicJMXA3HG5pvWFI3E3t2JpjF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(1076003)(478600001)(38100700002)(52116002)(6506007)(2616005)(38350700005)(83380400001)(26005)(6486002)(9686003)(6512007)(6666004)(41300700001)(5660300002)(4326008)(8936002)(8676002)(316002)(66476007)(66946007)(86362001)(2906002)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oXAMFyIo/hc3W3A5FpfRW5D1eQn1uTIXz1xvE3zq8/KVitFLw6y5l7GuAUdD?=
 =?us-ascii?Q?sSX+xV4kGCTloDYlAynyhBxcC5KIKYFNsNtpd88hxmkOaLykTnbJbsZ+HtLl?=
 =?us-ascii?Q?Pm0IP40K/QGY4KGUw8uhsstYoFVSHk00UA7rPYAx2i/SZnAvqJsmcXlKsOVo?=
 =?us-ascii?Q?3pi19hYzGaBtwaLIhDjxwuhOhpq8Fmw1Q4z3YMnIOriMPAbSw/MBWmWVc8fc?=
 =?us-ascii?Q?3vPp7rPkQHK05ZP+hJQgiX6F4sHI9H3gH1ASivW2xa/A5mNrzyhpIXUpGWiM?=
 =?us-ascii?Q?/eswxkyQcCRhiVO2Lr06sxjpqG2cNFJTvMWtQizbVy5cawTRYf6HjNc3ml0c?=
 =?us-ascii?Q?obYDjwYB/kOMmZW/V654Arkfn4eBGWW+NNjCn4cea2iZ8F4u/sEbay8HWnDG?=
 =?us-ascii?Q?DX9e5lqPaLkKx7mGFaUjvcBZnRHH/30WN7VIqNst3/EOo42X6vPB8XFy2gHR?=
 =?us-ascii?Q?yt5brIIdDSctTRcEt0WAy1fl+rKa3uAlzeLb3qoC92Hi9jrmKtUaxTk20Yuq?=
 =?us-ascii?Q?YCoe4CzRt17LiFFWzh1yBVbsfh74RWbCBskJ6cpOiXukgZrwQvT1IiBt+BWN?=
 =?us-ascii?Q?Iwjoqe+tIYagiR+FYW3Y83wV9NdwMrxquEBkamw8dz5XoOOS798EqQ28e0HB?=
 =?us-ascii?Q?PlMAOvDhYdbqjvkeFY8l5tunyVeqQvZL5G8oT+cOYJC5ACTKC5QU7BD8ld1y?=
 =?us-ascii?Q?wiwa/v/hj6i8MYHmmYLgexUp1t07nAdd860W/KokyUBClDLv9N4xf6+5j0Q3?=
 =?us-ascii?Q?vVGdbbL5n4DOh1coBfiGApf8mJvkn0KT/KqDYyF2pstVBaVNEe+Gk9ho1XVF?=
 =?us-ascii?Q?9exYQHdPveaB361zv17kAWxx8qJ7Cl99l2wP/8unK52GQdp3Y4EuzfFMIMwJ?=
 =?us-ascii?Q?APoHn7eoDxK3uSC13rWABxliLebw1vneU41qjirLKbEDYDiHRHZYbjh+rQ8l?=
 =?us-ascii?Q?iyimFhf4Gb0iHrlLy2F4ID5onOq8CkaXuoA9f/zTwi8imYNDIrkGNtsitoFN?=
 =?us-ascii?Q?mBztJnr4LwiJh4PiArTPCUVv31BcCX2rpCrsYUu/KgNrb+5uhlhWiWdYVmsF?=
 =?us-ascii?Q?DXzZPmyiHIRZx5LUmySxr0dFbGvapd1gXle2VotX3OzPqdhv4RX8ivEOOcZI?=
 =?us-ascii?Q?8IZK9PzGQr1HbdCy/Pn5YpR+xdTRjdgsMu8NUUBkErJ6RRWWY4/zi18rUHJP?=
 =?us-ascii?Q?6+5D8FzPl56zw5srd5KvBQWm2DzV5V1IJan0yFIeD5+FVImMkZnp/y0E90wv?=
 =?us-ascii?Q?aR9Bf1StKsMx6qMVTT4qUPCPEZdO9SL3lajHn3gwkvBwHQIuQaeMlTnKpd1Q?=
 =?us-ascii?Q?bBT73NCmaHe9hBTRWDMryhN1t0ulnBlIA8INu/8SuqWCy70qDjafhguLvLgg?=
 =?us-ascii?Q?43fvGQE5I/UkpZslbKY88rPrvhUWxwZuxm4cut6BLm5K9g8lRWaGmS6i7uPf?=
 =?us-ascii?Q?Du3dF9iYZp5QmlrP8inGT37zN7+ajio4DzdbQ3x31cBgIdyZG78IcraUgZOi?=
 =?us-ascii?Q?6mkgt7FIjPF+XZLYVfCgB7ueauMIffiH2edMAhkuD8gR2olL8Qy1kGNZMHZa?=
 =?us-ascii?Q?9BAwWisOW7kISoOoou2Vs/jIvfyQDgEre3FQie+z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e79c9a1-9311-4b01-4dfa-08dbcee26346
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:26:33.2451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrVDjIa8OvBmF7mcw0vKjF5fvF2OMfwW0+kErK+VNWfnd9Q+nQ5zRoy4TGTVB4gKySZxjFaCb4Lr7hpKoxnLIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7552
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Currently default enable the gpio cd pin wakeup, this will waste
power after system suspend if usr do not need this cd pin wakeup
feature. Now let usr to config the wakeup for gpio cd pin through
sysfs.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 40a6e2f8145a..2e46648344ba 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1797,9 +1797,12 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	/*
 	 * Setup the wakeup capability here, let user to decide
 	 * whether need to enable this wakeup through sysfs interface.
+	 * First check the SDIO device, second check the gpio CD pin.
 	 */
-	if ((host->mmc->pm_caps & MMC_PM_KEEP_POWER) &&
-			(host->mmc->pm_caps & MMC_PM_WAKE_SDIO_IRQ))
+	if (((host->mmc->pm_caps & MMC_PM_KEEP_POWER) &&
+			(host->mmc->pm_caps & MMC_PM_WAKE_SDIO_IRQ)) ||
+	    ((host->mmc->caps & MMC_CAP_CD_WAKE) &&
+			 host->mmc->slot.cd_irq >= 0))
 		device_set_wakeup_capable(&pdev->dev, true);
 
 	pm_runtime_set_active(&pdev->dev);
@@ -1878,7 +1881,8 @@ static int sdhci_esdhc_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = mmc_gpio_set_cd_wake(host->mmc, true);
+	if (device_may_wakeup(dev))
+		ret = mmc_gpio_set_cd_wake(host->mmc, true);
 
 	return ret;
 }
@@ -1901,8 +1905,10 @@ static int sdhci_esdhc_resume(struct device *dev)
 
 	if (host->mmc->caps2 & MMC_CAP2_CQE)
 		ret = cqhci_resume(host->mmc);
+	if (ret)
+		return ret;
 
-	if (!ret)
+	if (device_may_wakeup(dev))
 		ret = mmc_gpio_set_cd_wake(host->mmc, false);
 
 	return ret;
-- 
2.34.1

