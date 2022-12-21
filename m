Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16422C10F1B
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Dec 2022 11:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbiLUL3G (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Dec 2022 06:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbiLUL3F (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Dec 2022 06:29:05 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2042.outbound.protection.outlook.com [40.107.15.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7606B1C91C
        for <linux-mmc@vger.kernel.org>; Wed, 21 Dec 2022 03:29:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVfoG6HHkPu76tX7syTqSfxTeRC+0ffHKGmf0H/XILFsfRlTuI4rJIMmLVhKNiN2FF9EjagvRWCFwNQgZEKQmkk0Y/bTMEPxQJ1EOCgzJLCkXlWAc+r41FoaMHKoZjYlwNMslJMXaDKGHnfqBDpB9RmgnhlnozwrDqJKgEPzVc9JjSH/hcwuuebMrN5RfMnMWY8c7ZZ6DsMlXUlFoP79xm9ud3qO3OO8z6g/IjCLdP54PFhDfoYiEcWWtp2yVMIKlhh1TaV/xfSuQrQqezyYKdX4dMHq6fZaXmwJgj46mYfKmdHmwX0MufgKKQLLhVFLSHfBYIkJT0vWtd8u5o7S6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ML+5xwYbhq1bjMhLMHk5QsNLZV9gNogbY34IhWHg+fo=;
 b=IxMyb+MTzZ7CJ500Zk2Xm5e/u5NtpBS3rD6wPv/M3CdWxN3iXlzeDdAgZexOAndPA35EvdBxlT0tF+WDb/svDT1gPuvAQk6ahHjSOHR4aScoaQ8g8g+CzURouIANWkYg60F4n6xJnJxpwwbYsaEdm0ws8ZwPM7Wwjkc1UpTbcP8B0Y9f/uelWpquqoYQkl2RAJwSutdTzOlMufLGEky7O7WbIpSxV8VpxMV6/EAdoW/yAVup0RxDG9F2OtXihnv4hL+EOkSXWFpu8uLX2H4qsPRA1qIPcelReWgDigIo+OF3CTQ/rXOSuDvO9J8HcHoy3GjIKGXMQg9KPiZnwG7tng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ML+5xwYbhq1bjMhLMHk5QsNLZV9gNogbY34IhWHg+fo=;
 b=APuNQbf6DBrCYKeuZdGrllo6C4zbAS+mbCK6BjBkUBQNQq6dQBYe+h4rG8dUX8L1Fu21Rh3xdwhnjNYujZp/fHIkxs5mjeCRZnEKVaS92e+/3/ISzc1uC6AEkP+jEqjyZKAfVnQ0SNk/TIfEUe0rE8Tml43IegranFjnJk992i4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 PAXPR04MB8575.eurprd04.prod.outlook.com (2603:10a6:102:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 11:29:01 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 11:29:01 +0000
From:   haibo.chen@nxp.com
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        kgroeneveld@lenbrook.com, haibo.chen@nxp.com
Subject: [PATCH v2 3/3] mmc: sdhci-esdhc-imx: only enable DAT[0] and CMD line auto tuning for SDIO device
Date:   Wed, 21 Dec 2022 19:28:53 +0800
Message-Id: <20221221112853.789675-4-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221221112853.789675-1-haibo.chen@nxp.com>
References: <20221221112853.789675-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0227.apcprd06.prod.outlook.com
 (2603:1096:4:68::35) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|PAXPR04MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: e490cca5-8003-4ab4-5d19-08dae3468d1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4VqiGSv+IERGtbt5BcLqvsYIT0CGlptWDc//zCWWmxOWHEaeckP2jMb3H/9zcCrOn0cLNPI95+9UfQoqV3PNLpxnbHKyz0B//0K/RsarD9HfO/zy5AtVndZ591pafVhId3oCS2jUItzHHugMRAeoUfLbdwZAaEi58QoE2QqxK11R3jamYo3GOQqgAgzTcWRnGTbSbBAEpgTYLee/X4uttT+OumBOm0abZMB9lT1ofUbGw1dcw1xZVDBUV+xuVrESMJ0VIH2ZhgkIgngrGymYGwWev8WwM1Y4x7i6ROVAK5W8uRUTYbdBIxa7ImrJ2EUGM64efF2QD27FfMml9P29pfRmQ+dU0sxSzj68OXhNHLPfgx8auRChumI1EgdlmpL5V4VsDJGVixlvQkz9m7xUQUeW0kFUiRBjnVfb7TFFE44A9Ptm3iQdVUBy/4UlvWD+OOfwAA8+r1tnDR1Dc+JVl/S5YKzhyshiiHGE+a8quWBRD8qiQ+y18d05l4tnh/CTDncda8uIlVpQrew/Pbk7E8EF9jmh6ITf1yoRLQtuhZ+pU9dASaJtBTj3sdlJ3Pnukr3w8PmOJkt31Nb+o5mcTEizMEE+QIatVdVf0aacBbeSIJ1aUj3LYCRTrmprZcT4Z8NTVbZR9+VDNAr3coUya+NeR9dsq+792jqmNgg8Z3OoWgFPYX3bYzzxZ4g1SATbVrUslfHXvMJp4nV/IRpEBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199015)(6506007)(52116002)(2906002)(6486002)(478600001)(26005)(6666004)(2616005)(66476007)(36756003)(66556008)(66946007)(4326008)(41300700001)(8676002)(1076003)(316002)(6512007)(9686003)(8936002)(186003)(5660300002)(83380400001)(38350700002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aYFhe228x8ldbdDeS7pC2louGg61lmzHukOhcGAdAWpWfnDNKGR4WHIMg+qh?=
 =?us-ascii?Q?cgpcvNM5nLAISQYYMeCNovvOv4vSTKERuj7KP2E496VV/XHDaJzNZmo63oks?=
 =?us-ascii?Q?BVlLC92ZNiP84JemtafuFilS2kY0+U7pbZZR9QRhFLDtoL9SmfrlzKTz1GcW?=
 =?us-ascii?Q?e3ZnS/YnTC2RCo3vm5fUCqrIZWj+RQIWBWXsJOX0LPXmjPeDGFtfp6I/2IIk?=
 =?us-ascii?Q?/NM4IJKcPEzEK9Z4vKhZCyLv/5rO3I8pb+8OijGMIGRfQheaRYb3lw7EiuBf?=
 =?us-ascii?Q?AvGT80KbhuypeMpgSCf6bfVyciYCzlb72vnQ8XmRXStSF3fRdDPS/6+gSl/X?=
 =?us-ascii?Q?sbmdhczybwt45YZvwSPAs28iwIENXYIQ4I3Uhx/OonBQ89nBgViDNLkNqvgz?=
 =?us-ascii?Q?aLi3YLQZ5VR9ZyPBrbjTGFug6YPpKZEAk+WjgLzFh5A8eGmjis9IxFfeONZ4?=
 =?us-ascii?Q?+nAauoTGCtNdtIMzFe9D/71NqCWpRPzpAmknS6ZQpUXs6pnMdV4ZHB3WFQyF?=
 =?us-ascii?Q?g2JoGY8lPlm91h2H/3ugY/B4WbwyyLwq4CxkNGfYztcj5ipGuXxIaJBXPB/n?=
 =?us-ascii?Q?2rw14Zn9YMi0+/QXDMNZ3bOkesEAyWdcg2kkYlMXt1AyLsaN31TnZYm1gjUw?=
 =?us-ascii?Q?TfnAq+S3Lv9U/UBisNpZ/MKnwZVcZQAecw8YaF3qracpWRARmvNfAkYNJNXx?=
 =?us-ascii?Q?sDOoUp2Ytj+WTyxN3l0ZtPVNhsLW19p9XUqwRFMWCp/EqI2CL8nzfkg1Uc+B?=
 =?us-ascii?Q?8p9wmQ5GqZAp6ayDZooErRV6Al8+NzsONhgmmYTcg74JAcutwh5ENSH2rNKK?=
 =?us-ascii?Q?gpv/+X9LVhtWZF3WjulaP4JmhwGH6u8zeD6Ct001+xBqrz2tE7qPEZ14Du+q?=
 =?us-ascii?Q?Qx7cab6GecRs9Y0Qs/noPpitRjiB0EbhKv/uxfHTEl2BZ7LZncWN4Xz2MerD?=
 =?us-ascii?Q?O7kH7eFueq6oUxbfqytbTSBpdNDLx3tK3EgBMnY4v5Ej/C0JnNzjpo+s56nb?=
 =?us-ascii?Q?+qimIDsWvkBpELQshYJIXXUiUMjfbKvkcMOM9t5cmfKBuMxrSbjUtHEYTIB9?=
 =?us-ascii?Q?xg8XDc5bo2uRHtUlsEUCAUnMoatPGjg604Z780NOl0FKqN2z9l22G/CSZutt?=
 =?us-ascii?Q?06Ab/1VHUgl5rYh7sfGKDaeGg22r6/5Os53XV6xH700mcntNyvjvEIyRtipZ?=
 =?us-ascii?Q?oxpyqwsG7AD8pmdtoz1mOmbHmtmHQUBrFEemtF8J0Gr4uTigADrSYtdHYcQQ?=
 =?us-ascii?Q?E2lCCmDTfH8BfmxW62lS30+U1EqjM47/yEHiJLfMEJBYSSqNstnRnyPFO54+?=
 =?us-ascii?Q?/oLZhJghWBqCgWP0bLAy/k3SyyMjm8UnrHq8tHTJNogouBzfmKK7v08bOs9L?=
 =?us-ascii?Q?to/kN+5oII5b1nsFwXlTRj6ynXz6IZg60wBfTW/e5ELJIDbTIqokZNMJMlAA?=
 =?us-ascii?Q?/7UhuZT+0UIxF5qE2WJcyAUMG/0kWvzbt7cGQxh5IXz2T8KmMer/JGXFObRj?=
 =?us-ascii?Q?3JQWi0cevlB4MzgEN18Cf55BHz42LIRZYAxGP9mZpBoS47PLgR114skI8xci?=
 =?us-ascii?Q?MdyPdEG1QJy8O9ePmgcUTBmknnc8wkL6YLqL86Ns?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e490cca5-8003-4ab4-5d19-08dae3468d1a
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 11:28:58.4314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ryABpxXnq96I9uCHGpZ9u78As0rtiUJd5D1qEp7Gpe1OhJIFQKnzmGJhwP7yULyzDu8Qb9HsU3U91RtQuFfgtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8575
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

USDHC IP has one limitation: the tuning circuit can't handle the async
sdio device interrupt correctly. When sdio device use 4 data lines,
async sdio interrupt will use the shared DAT[1], if enable auto tuning
circuit to check these 4 data lines, include the DAT[1], this circuit
will detect this interrupt, take this as data on DAT[1], and adjust the
delay cell wrongly, finally will cause the DATA/CMD CRC error.
So for SDIO device, only enable DAT[0] and CMD line for auto tuning.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index bf8d6f60a9ee..d6ce4c8d23dc 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -448,6 +448,20 @@ static inline void usdhc_auto_tuning_mode_sel_and_en(struct sdhci_host *host)
 		break;
 	}
 
+	/*
+	 * For USDHC, auto tuning circuit can not handle the async sdio
+	 * device interrupt correctly. When sdio device use 4 data lines,
+	 * async sdio interrupt will use the shared DAT[1], if enable auto
+	 * tuning circuit check these 4 data lines, include the DAT[1],
+	 * this circuit will detect this interrupt, take this as a data on
+	 * DAT[1], and adjust the delay cell wrongly.
+	 * This is the hardware design limitation, to avoid this, for sdio
+	 * device, config the auto tuning circuit only check DAT[0] and CMD
+	 * line.
+	 */
+	if (!host->mmc->card && mmc_card_sdio(host->mmc->card))
+		auto_tune_buswidth = ESDHC_VEND_SPEC2_AUTO_TUNE_1BIT_EN;
+
 	esdhc_clrset_le(host, ESDHC_VEND_SPEC2_AUTO_TUNE_MODE_MASK,
 			auto_tune_buswidth | ESDHC_VEND_SPEC2_AUTO_TUNE_CMD_EN,
 			ESDHC_VEND_SPEC2);
-- 
2.34.1

