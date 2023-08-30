Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09D9C83F1E
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Aug 2023 18:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjH3S3R (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242773AbjH3JfN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Aug 2023 05:35:13 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C987BE
        for <linux-mmc@vger.kernel.org>; Wed, 30 Aug 2023 02:35:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuISeHGFIfaYvIOw5StrAIxGZRfCcdBOV4SS/T/sjX1LPbKTk8pBPZsRAagKsecpdujupEhMgLgG3Ox63Ul2ZnUOR+qoMa1vlfxSpbIfhzJxl3g3hjJ0Lmvhs6RwkTZRdrTr/vUSvzOrsbu1hv/PPoeCkR84OEIyRExEtCfG8rW84L28057i66GGRRrAGhwViXFCVvjz9LY0EQDyAVYroF3U6+1NPsNhtCXZGk9HuDJCPS8uEl3coYNI0OJJLlKXZuCd1TQIxrgP5hh1s5LNf1ArTxMoUfaUCJfsV8qX/54qAbs99qIbK0TkhWxs7DM7l88W5WMhlSq+PKmNfs3quw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Yttdcak57NlwbclK1Ms8y7JXBQt6T3j006GVzEWYos=;
 b=bR3rHtJSmpKT8HJbfL5dfOV2VApb2qi0IT7AmWuuF5mAROOGpNQlDMq79qAcXO9O39ia4fGbUhZ+Km/Hd99BSWVjqu8vAKt/AM81D1QqjYlfypZXboSP1gxLIXQMrimdKFto89GDbCNOMNJUAvpDm65J8twuhPQSKc4t3lMKn8Wi1THbVKYOWY4QJE5Mom6emKgax3ymfDtj5cdwd7djDX5AQj/8l10QOCfdkr+zF6aB2yaLATMirnzZuSXFbnYDvGS8Ap7A6x+68ooU+Lz1XxalAcsHV9fqIGFtMnzmf6rIMvKpYptr1N36r8qo80BsBReFMeeNtVxYt33kS8N/Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Yttdcak57NlwbclK1Ms8y7JXBQt6T3j006GVzEWYos=;
 b=EZx6sn3jvS5qyS8y61akbER92unohyR/o8McxgM8evT7aRJoKTqrLTyP8UMgk2KFi2YvhkXKhdE6nbsRDMwKOXH4v65Kd8eZTbVX/y+57d1bizaopLWa8B7yVytAbI3jwGJn6iioUL37PD5hJKZUNtkM+d/JIisS4uxTerTMeN4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AM0PR04MB6818.eurprd04.prod.outlook.com (2603:10a6:208:186::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 30 Aug
 2023 09:35:03 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc%5]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 09:35:03 +0000
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, hkallweit1@gmail.com
Subject: [PATCH] mmc: core: sdio: hold retuning if sdio in 1-bit mode
Date:   Wed, 30 Aug 2023 17:39:22 +0800
Message-Id: <20230830093922.3095850-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|AM0PR04MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: be028b8f-f747-4759-094e-08dba93c6305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E7kje5+zzV7xuapnVAD19CBFUDwEgtdTxb5V8NzHpRYNy03xIt/q8gYdahmRd9G9jTED+80wCsjWysAHs1MaTbamttr23Rf3Az4zg0yGBnFmmYnxc2CFu8f1BEXhDudq61i7NVG8V7idjTM3gT54tjX5A69XwwB9WFewC1pJaRveu5iCgUa5IxGAbidBZJHAbtIVwkYAm1P0CBUdXlhs8vWeRSKOAEByUBJ8KxVw04C/y6da93/TG+uvG79iqOTK+Y8cTQE2C1TQPWQtKpJtVzzBSXRBDI26vq5uUv7h6eqSfIo2w5YGDI6mlVhRs0Z8U1ZSmzmPAlnskwNsNTKLW4TKALrFYEztJxIxUxFZc2ndISZPI09ZM2YHVbYrhLKzI+qIC+Rp6JOVDeNB9ID5E0EZU3n2CQi/+4rm2iabvTDsaCqSZv6tqZv7KlfTKDh/o3qmdFZrxE0uu/jSmwtNhMC08Il3Uk675z/hsggOnJTd/gZ2CLCVzs2QJz0fG7vb/hzeJ4YWuJ6ojSfcXiO7MUpF0Pxh3aSiT/0TUYdvjGbr7Qzc0q1jOwHYI95K59vDFK2NEgnHd7BT0FnZUIULfir843rO//SS1hlnTC+nFBItc3vkrdeJjSRCg4NUv1CR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(1800799009)(186009)(451199024)(66476007)(6512007)(66556008)(316002)(4326008)(8676002)(66946007)(8936002)(9686003)(2616005)(1076003)(41300700001)(36756003)(6666004)(478600001)(52116002)(5660300002)(83380400001)(2906002)(38100700002)(38350700002)(86362001)(6486002)(26005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RzoSUkC/7L7Y9WKb0GBW3MPkNEb3Vd539+t2XFSc4XBEIXae8j/rXFWyKDV/?=
 =?us-ascii?Q?FUbFegbcFxXxoTUZow9VLQ3tRho7BRoBmqGgXnb+AFPAcIRjlxj99dx3A1Zh?=
 =?us-ascii?Q?8pUq2MXUX0d/FwgpFIFziVriCKy2dN8QzvvkQOwRXB8Tm7032umM70RXZLXZ?=
 =?us-ascii?Q?Fi8f+rZVP5TGmq8BFEYScPidAuBaPHcRMkkX4nnxJRP3l1HjCkXRsgSkPxNe?=
 =?us-ascii?Q?GhYrCvFqljcNSwuPz3qgVylnplUKHaP3rV/LNHFtJ+y07yPvZg/tbWofjDRF?=
 =?us-ascii?Q?82kG3D3RHxrC+hEf1UauxG/b39Llf5EaCTurh79R8+609J8t3kfN2CwyeR2T?=
 =?us-ascii?Q?TpOFr96GeCbTZMQ8x2cyXA6LBZNjx3oE9dSbLr6YlFo2egQ5JHs87II4k+1u?=
 =?us-ascii?Q?soIn7xaelBP6iy31MrIGA+L5m/QAYZWOOsW4ydIzn6zSj0j46J4k5X9OjfJV?=
 =?us-ascii?Q?mJF80VkJbzuSg9nMrIcB+ufC4E1sVE0GsTEpU8cnKUVXsaOBksbtvI6EP3X0?=
 =?us-ascii?Q?d9MiKdEQdGUd510XOYAi5UghZuxrOo36z68My+Won3N/0r3nKk9zmW2ySNQi?=
 =?us-ascii?Q?RnHwAY/Kcelu0Lc0ucw14ORZmEEP0owA907nGjAU4bSPr+4pVgeXVTB0mL8X?=
 =?us-ascii?Q?rM57zSdEQTXpxafIyDhGxaoVYyIIpCsc5N1BpDwAApvDPHvWCrIljrv5VI9f?=
 =?us-ascii?Q?CSTZatY6Z8qdVVg5lcQjCz0LPcu0+s7gT5xwzpXi7HzFxMzeiCUY2wvksrmR?=
 =?us-ascii?Q?ni4C7ldQbS78mR6uF7Osd04idyqWfW/IzUCW+R76qNDpgGLgXCgeia9rpHfB?=
 =?us-ascii?Q?rVyq/Wuez6yL506zCz/Nhqp4GlsDYOMhoSmoUHwCbRvqdR00VXZ4xzQPHVhq?=
 =?us-ascii?Q?rPhR5zIw4FAeSIRZ6l2mirslcy7VX96b+BZ6UeFhzWhFhwLxlNO0SNaCEtXo?=
 =?us-ascii?Q?PMweAgMkllqDEi61ie607sDpAA/pbpw9CejEu2wMamXiFOf+jxGaF0QMw36p?=
 =?us-ascii?Q?X9lIuNZs04vpsLnC6o3fWt2IBF8pKc2amRPpejqBYX17VfPaw+X0CZx3fxwP?=
 =?us-ascii?Q?mCqnNr4UA3qAfk74GJjzu/whlNNAKvJcLw4WeGR7p+rPSXkuiilrwoFWzkND?=
 =?us-ascii?Q?s+exF7rQm/mcSIUlNpiP29hd/wGwf0YP6JtMUc9xOQdf93Yt3LB6THDYKtxS?=
 =?us-ascii?Q?ngW/xmCr6htIWax1jfnXo1v3LT/u7MBnIJGcjassm/0IE8hCkgByxig+uD8G?=
 =?us-ascii?Q?RDyU+JiSSh5SrLyEaS/e3aLbvWOg5T5r196bROYcLfOdFZCKVRzliBkANHfS?=
 =?us-ascii?Q?DZKXEm7ea/NkLe0gfGqccvPkXjsrbxNt/stDdUac8/4Lc/ag3C/k57pAf+Oq?=
 =?us-ascii?Q?nqp7FjA7POWAZ/fDT21pZ1kqgpudzi7c+m0lVSwZ/xTqfGCtOOxFP2ZmcKlU?=
 =?us-ascii?Q?WDKx9JD/3oJf24umFDNa7lR7mgQ9jK1CSemjFqu9wo85P8ASLQCpKQkxX9fH?=
 =?us-ascii?Q?sUlyUu3cZtPvoiUlunF9xsx2fwLZP04/suppBQyB0DXqQI3FskSMG9BJ9hA/?=
 =?us-ascii?Q?YXjcuATaEyG6T7++ieB579me92OOlwH+Pkr+Zr6q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be028b8f-f747-4759-094e-08dba93c6305
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 09:35:03.1134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfZPEcZ0aF5EvccC1aosdO+gzl5XydbwwXkiVF3ktAblaMIXvsmKlMLuCA94HEVDBMaLyNMCf67Hs9AsbmWTMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6818
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

tuning only support in 4-bit mode or 8 bit mode, so in 1-bit mode,
need to hold retuning.

Find this issue when use manual tuning method on imx93. When system
resume back, SDIO WIFI try to switch back to 4 bit mode, first will
trigger retuning, and all tuning command failed.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/core/sdio.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index f64b9ac76a5c..5914516df2f7 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1089,8 +1089,14 @@ static int mmc_sdio_resume(struct mmc_host *host)
 		}
 		err = mmc_sdio_reinit_card(host);
 	} else if (mmc_card_wake_sdio_irq(host)) {
-		/* We may have switched to 1-bit mode during suspend */
+		/*
+		 * We may have switched to 1-bit mode during suspend,
+		 * need to hold retuning, because tuning only supprt
+		 * 4-bit mode or 8 bit mode.
+		 */
+		mmc_retune_hold_now(host);
 		err = sdio_enable_4bit_bus(host->card);
+		mmc_retune_release(host);
 	}
 
 	if (err)
-- 
2.34.1

