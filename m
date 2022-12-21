Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84186C4332F
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Dec 2022 11:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbiLUL3F (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Dec 2022 06:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbiLUL3E (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Dec 2022 06:29:04 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2042.outbound.protection.outlook.com [40.107.15.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B63C10AF
        for <linux-mmc@vger.kernel.org>; Wed, 21 Dec 2022 03:29:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZWtlsoeU4/9X9xmU+hWuZpw4Ak7b5xYmfHcoqQFKWgA87SVaUFsOqjt/b0Z8KZPiWbxAm9NO2Swxn/bBjCNqtLG/+rpe07aSSjXvcPMjmBb3J3Pik8Qagbh3DUfvCDoK9nps7et54E7s2XH0Bj6Bo1IwIjiNNnMi2Zn0meItBKbKozqEhbRPxGXs9EkU5AG1iQ+zLYkQyCqtuxpki2ZFZEzPZn1nRwzSHIxf0GqlPLeRYzcKUBpQRVQlWl9AQojRvVed0LG7nSMZfCBXv212mZm/JlueMt54lO+xvxNqpErmw+47BAC3q1tLOWAqh690qaBVSk7vjSOsd02gunVmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKZIZVAV7cvdwnLxIDpaw7Mk3dnd0ggHxmACbgFuV+Y=;
 b=SmJ5FZ1UxKiqclEa5yYVGHMhIQHP6YPEPHp1NCSOtdrO66xFnmn9aWOZ+Mn0JeklWRcK/igtnEPkKZRpSEwe58//SAr5v2auGG/a/1Bu2jDX0jmOYwhkfOLloVtIpJ94B7bySPwszalFeLJNZKrYZ0ntSSe6xxdFLLAv5WOoXsopDtrlCqt7sTcCtYtH8KRjGnq8fftD8yy8A/8pQNpNhtJRC6yA73hvh+/zdCzYVIXDh18+wX8L7fKlLiWY9zvONDU3jwtOyKb9rJQ3ABEfVj9bqvSDkddBjgGOyCsJVnXxOb+szL+NE4glXmGPUR0mHRdA/kUsuXT/61IuxjxTsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKZIZVAV7cvdwnLxIDpaw7Mk3dnd0ggHxmACbgFuV+Y=;
 b=SWiNW5cI9pYBuclMCXC88hAbv7dwiEt1X8UT1d5LbvoO5zuZy0/EEUWoNAt70fIeaD3bOccjsZTSdD0jIlIb7FOgeloSrtyr0zhoFf2yGZdBynQsfkTUDm2NgmMS8LVhggMKmgVw5Dp4xIIQKJovDjNPQ3rPOpK4QlMDaoH1ocM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 PAXPR04MB8575.eurprd04.prod.outlook.com (2603:10a6:102:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 11:29:00 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 11:28:55 +0000
From:   haibo.chen@nxp.com
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        kgroeneveld@lenbrook.com, haibo.chen@nxp.com
Subject: [PATCH v2 2/3] mmc: let the host side can find card type during card init process
Date:   Wed, 21 Dec 2022 19:28:52 +0800
Message-Id: <20221221112853.789675-3-haibo.chen@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 581dd4d1-ad6b-4148-4488-08dae3468b10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YJDPVkOmgO6Gnak37cXSc4y768cTq9xbdiMtDp7+QxdvE9FW9XlSM3xbUoaFNNHhWGwrHX0/KZU02KMLILzGTMew3lrHL1N7SZRFzuSa8hBF8krcGxj1NX0BjcjvV9M9yxC1tNI8HZWYAtVMrlqBHiO9Qk1KdPL8dY5x5VUGrX7KxBpJutN3HaTe7T6UgJ4WSfYecrOGsnuW4CELVbdSB7M113L8ybUX7jJIHo1At3XvEkbqag84kuIT9+otOftjSNpr7hb5xLiIziOtLgS+bmPZJN4yPa0FnP3FQzlT6apWrTpkgNQQXZn2VAtiFimbNDkXbrvWIK8r3Si6S3QQ8e1WbsQBbyNbFiKK0l4Q6SZsOBuFa4+66SZnir02VKB8BY+tsMIb89Yl7V84+DuqvXOcbyxdTDkZB4UHtlP9Wa3fTtwoN9WEPH7tAOTizPYmyuID/kcsTs8ei2giXs9BbSqFfPFlPyTxogeD5+dlVbkYZL2bvniaNpaspQUuKWOl6QA505UO+5c8ptiAzTsIZ5Tqv/8/SmBj2PCCxauQaW8d+7xqvg0f9O+5eORrHGTXg5cuZbD1/tHeP02FcpLVI0nG26ODuURj0Wpzv0EOCG1s4W43FMWFQ3SWaqqWH9QcUQ6iSsfYMRu3yqUTIjMW430pkoan9pgI1BdNPn5d7r4vsGQt+griGs9KxbT3er4Q7vB0Kx7Bkhk5UPaeEM8h+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199015)(6506007)(52116002)(2906002)(6486002)(478600001)(26005)(6666004)(2616005)(66476007)(36756003)(66556008)(66946007)(4326008)(41300700001)(8676002)(1076003)(316002)(6512007)(9686003)(8936002)(186003)(5660300002)(83380400001)(38350700002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VeKDG6nNALcrnG3YhGdOrLhlIgsiOxVNSbBV5y7oZN/fD2yQxLVEV1ruJC2Z?=
 =?us-ascii?Q?+lvAGFQDUc4cbKI6cNw9AlHJSYXzys5SfF1fxjUjephviDqZxRBNIXUai/Gr?=
 =?us-ascii?Q?aLrOhAIUX06WwBuCTOfVLibZrhrR/QmKzQtcniI/4mN7nCt/fr6/wwc6y47p?=
 =?us-ascii?Q?j51hO0JsRlsA08nHJnDP2giIGQhj///yIo6C5iiUDvZUxNkCBN8fLQ5i6cwT?=
 =?us-ascii?Q?LjCR05ZhOqOjDQvnPvgyKtlEdc4hR6xbSPnSx219IPu6j+LLy3Kz5XYF175j?=
 =?us-ascii?Q?QnlWW4Ov2dorxzOy+0YbZmQZLP/btZntzmmXeXutzaVHe1IG5TD+/FVCSnCD?=
 =?us-ascii?Q?fARGmFLpiPYh8GZHjs0ZDbFnBYf/42bJkrLiRrO/0qT6VOfY7vs8q+wfiHvY?=
 =?us-ascii?Q?jGMFdyZadahKyOKuxc8idtEvt423JvkFt/gSrcs+oAoTs5PBJgPz3tFc/LZs?=
 =?us-ascii?Q?bzFVNqZV3qLoCXBs8xK8RVMlqwYU+YDkQarrYZpSx3T4iuDjdFb7MAHroJWu?=
 =?us-ascii?Q?Oj1FajziI+r5nqjyFaV8/eemqNbX66Rn1JmyPBKeyzPDn5RwXcZHyYwSrVfF?=
 =?us-ascii?Q?gVKyWEUrc3e7/qXHtaRdx7ltsS3dmp3BZ7wnKMj6jWc8QyauPzBypJ+3Yiak?=
 =?us-ascii?Q?WELyLWax0R0xtGSzkotnGZVH0lt8pXm7GYNrbvgPdI3TdlgnPeS8fZ4sSQCc?=
 =?us-ascii?Q?n07CNj5+MHR2qpuaG/Cym0571ZMIuIpcKIg/YtS6Aup0e3IGZOMPwQ0BzV6B?=
 =?us-ascii?Q?Oo+/lQ8Ql86IF/NONZh9LX/v+c6AqKzyT0EkppnrQocxuODc+R8qHW7IlO3Q?=
 =?us-ascii?Q?EdcOh1qli8MmimvPzHTRLoaISa12aSgq3HVU4IE3O5UG98oH9CZd1qmKaEFM?=
 =?us-ascii?Q?TnGged78yLdyrooJojJSnCy9LC8ZkqPztx8qDLf0dF+L7C1uF7kxLKaBIi84?=
 =?us-ascii?Q?zCAqekwBlk8wX24Wogu5b/5+7ms0D62kef3/HZ9/3I1ZvgQQsGuAKCnjkgk9?=
 =?us-ascii?Q?BaE5Mws0Fhw+exJZhTkJhyGElMS5rF32DVIs9Mxyp5r8hDIG3s4A8t99xzmd?=
 =?us-ascii?Q?cUcBohNcnsqxT/ABsNy8JyKm5IcwzETTmbiCt73nVuti5lzamMJzZ6fM3IT6?=
 =?us-ascii?Q?voakOwabJF7UmEZCFnsd5qQKQYJLlz2lXbQjDsmxDAV76f7IOrXNUAC2wt1W?=
 =?us-ascii?Q?ZjeoWHNJkH9x1gk/V1ym8meqZvRbhxo1QForLN4js+10jKUS4sTjoPoWBewk?=
 =?us-ascii?Q?ZmYHlQD973JaluYxZCjE3zn5/hc4npFhqEfziOS+ByfvhH8NBzXXfziF/X4S?=
 =?us-ascii?Q?znCKVKxdGWb09UcaiHlMqFwP3xtJJo2HAsz0ZN72elzXVOBRbaQ0UNBIiJmi?=
 =?us-ascii?Q?4c4LmmwluflbRGUBLS1Eliiil8xQ+LJ6fWrvXhgVs81EYf5nABpSMBtXps29?=
 =?us-ascii?Q?/9mKnF6gCBFDlIUbqdnQGfzFeAd9e35Re5Ykp79PMxZXwEmc7FNlWh3zWmo1?=
 =?us-ascii?Q?exD5WIC9e597COJAA/EnOEtDHH4pruqiA5F9+DE1MSDdVlCQwRbDVaIYpo2g?=
 =?us-ascii?Q?H6hTcJmi7gIrzWMx24AJNKATldEHQ7Q2LqCxB8MI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 581dd4d1-ad6b-4148-4488-08dae3468b10
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 11:28:54.9473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wk+md4iWrgcXrqcHONhSsVOlf0QqAwe6d5mwd0ie2QYlpKsjDHo8Wl1GIYrkEiknZqRCTnAac7UABmjjRtjlxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8575
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

During the card init, the host side sometimes may need to distinguish
the card type to handle accordingly. So need to give host->card value
earlier.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/core/mmc.c  |  9 +++++----
 drivers/mmc/core/sd.c   |  7 +++++--
 drivers/mmc/core/sdio.c | 10 ++++++----
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 89cd48fcec79..63de76a51be3 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1658,6 +1658,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			goto err;
 		}
 
+		host->card = card;
+
 		card->ocr = ocr;
 		card->type = MMC_TYPE_MMC;
 		card->rca = 1;
@@ -1926,14 +1928,13 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		goto free_card;
 	}
 
-	if (!oldcard)
-		host->card = card;
-
 	return 0;
 
 free_card:
-	if (!oldcard)
+	if (!oldcard) {
 		mmc_remove_card(card);
+		host->card = NULL;
+	}
 err:
 	return err;
 }
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 72b664ed90cf..147b188b916e 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1431,6 +1431,8 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 		if (IS_ERR(card))
 			return PTR_ERR(card);
 
+		host->card = card;
+
 		card->ocr = ocr;
 		card->type = MMC_TYPE_SD;
 		memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
@@ -1563,12 +1565,13 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 		goto free_card;
 	}
 
-	host->card = card;
 	return 0;
 
 free_card:
-	if (!oldcard)
+	if (!oldcard) {
 		mmc_remove_card(card);
+		host->card = NULL;
+	}
 
 	return err;
 }
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index f64b9ac76a5c..5bcf4ada4738 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -699,6 +699,9 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	if (IS_ERR(card))
 		return PTR_ERR(card);
 
+	if (!oldcard)
+		host->card = card;
+
 	if ((rocr & R4_MEMORY_PRESENT) &&
 	    mmc_sd_get_cid(host, ocr & rocr, card->raw_cid, NULL) == 0) {
 		card->type = MMC_TYPE_SD_COMBO;
@@ -800,8 +803,6 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 
 		if (oldcard)
 			mmc_remove_card(card);
-		else
-			host->card = card;
 
 		return 0;
 	}
@@ -898,14 +899,15 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 		goto remove;
 	}
 
-	host->card = card;
 	return 0;
 
 mismatch:
 	pr_debug("%s: Perhaps the card was replaced\n", mmc_hostname(host));
 remove:
-	if (oldcard != card)
+	if (oldcard != card) {
 		mmc_remove_card(card);
+		host->card = NULL;
+	}
 	return err;
 }
 
-- 
2.34.1

