Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9516EC4332F
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Dec 2022 11:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbiLUL2z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Dec 2022 06:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbiLUL2w (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Dec 2022 06:28:52 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2055.outbound.protection.outlook.com [40.107.15.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34CD1C91C
        for <linux-mmc@vger.kernel.org>; Wed, 21 Dec 2022 03:28:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfthEdOs2ok77lD8gA+lvaGetPXplsQnLR/U5Rkurf7P3CWHzII4BkhhSmvgcogSKWd2EzKsNtSn8CS/LbghyyOFU/thSyXGEP2gz0+w/GIoeZf3pIPLO7ujDM0kbzhCwY4l3xMEWJjuHO1gor6xOEIwkMk+t7dE9qXwy2Wr4dXDien1IWoD7ri1oXgtZJFwz1yRiW++sk1s36L5jdBrN6u2bucHjX6fXUFswiIAyfirczyXnz2vGqMREeMU0M60SL74Ytr5vBOOhNfqgS0ELOawQvz4Qalof1NmxP5GQuG+j3qh4aiWYNbogX0N2kC3NkABSZMND/mF6/QjjBUVCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEjusuoUsKQpW02urhDVL9fzeP5ApRGZeBtrHWMp9aE=;
 b=i40K5vceA0ZcgWrYJBWe7hUBYlyGw/59oFaSFF6jBYaMJx/pXtQ1tJ4ZeE/GaO2rgqT3nfVz6Mj+3pyvjCXdOHxuetTGUr/8YSfEPzDqFPQayQ+zyg3g8ssnauqWhBSKlfUdE5CYH+rQAb+J36vTvOYmnKJjisDg2oAb2fFLuVwAjsVHhEJwE9SOndT57wWNMTDprykY6LhYqGUi+YbHoRGJDgbx28DD08Txp4lqdJ9nRz5DZGQVVoAHS9GsZoWtiGHgN0aO/+OqOzchf4XuJRTrVVYswQ/Kp/UrBqmyleyLM2NyrUXE8BNnPVdEXRL8pOoplgZitBCjZLz+C6yf5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEjusuoUsKQpW02urhDVL9fzeP5ApRGZeBtrHWMp9aE=;
 b=pmLjbapHXj1KiX/9/NCOXA+7oW9+uQiVxF+G7XZIpczOzLHj7Iass2uGao/7dljr5bcpcl+eRIzARsmVHce7LqiEeOhYtpaCabGQ0N254v6tEm0v6temMQskG7Eb+fQA23N4yCE6oy4amQ0lZGkC3bEKn6AsEFinjmlquyh18AQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 PAXPR04MB8575.eurprd04.prod.outlook.com (2603:10a6:102:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 11:28:48 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 11:28:48 +0000
From:   haibo.chen@nxp.com
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        kgroeneveld@lenbrook.com, haibo.chen@nxp.com
Subject: [PATCH v2 0/3] fix the sdio device DATA/CMD CRC and Timeout issue after tuning
Date:   Wed, 21 Dec 2022 19:28:50 +0800
Message-Id: <20221221112853.789675-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0227.apcprd06.prod.outlook.com
 (2603:1096:4:68::35) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|PAXPR04MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: 53683db8-bedb-42b0-634e-08dae34686eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: byrRr6asQjwdUw0MbPQ1VYw7dpr+GlDb7mrMB392o/82qWm3pXmAztkQAg8U0TcNX11XN1+RZfT2/1x5i7YKuVFyfHXwPUTb6zlfwfGasbM0JxcvWqKNpoxswh+zFQt6Li5eTD8cGlJqbe3zIiXkl3T28kLmlTDwm1SMb626OmsGoKF47jyoF/U4IRFyQSvDH4NcrHaXJTYeoETY7dIjYl+8PhPT4aQQAqvpqSkFftLJBDmLvu3qelXVChozZfUOt6cW6WVva5KNf8tLEqfLlSdc495MXSKYNR2ZCvcZAT0pAMQsnkwuj/XsZ3fQt6HvHugP+jRjvgn5fO0dwVbbINkW2nTBW5E++JDBwgEwLIbWw8dE+NJ9eUwUp0kVlkFtxf7HgRde5THBnjE0e8cVUvAC2uq5TxKnaDmpG26abu7v+CKqu58Ooj5tg1KPpvgB8K8dx7xj1tca4D3UlL7eWWlB20hnNF99ax93A0HEs9CqiW2is1las+U9C0IYyN+LBDYfnH55ydciRu5SheancpWOnrRQrlT5WY2fNPGDPcPWrFJSTD4sgyPSI3EaYQsByf1tMN5oFZGQnvBPxPP2pWuVqjI8j2sSt/YWOCJi+HacUsYTZK7SMvhn++SMUt+hYcGtDuM6tGhIzNFx6SSEyEyuQDo8tvvDoDkbDaAnzqe1PUcoGvIAKVQyKhw10l4/i85I/BWj7FJD67b3gFGDfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199015)(6506007)(52116002)(2906002)(6486002)(478600001)(26005)(6666004)(2616005)(66476007)(36756003)(66556008)(66946007)(4326008)(41300700001)(8676002)(1076003)(316002)(6512007)(9686003)(8936002)(186003)(5660300002)(83380400001)(38350700002)(86362001)(4744005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZNy0+iOzRdmcc+f78f3b1ZlKLLLbIStwzeUdY0E3FXRG7+NE97KSvjJ404jt?=
 =?us-ascii?Q?d9FUbo2OxmZlfQty/gY0FAjcIrUFGFeOIt+4dsRFt02OP7wnmyZ81pxkn164?=
 =?us-ascii?Q?2Unowdoui5wgc3mQ857Ym2Z9qqHIAw3Vaz5KXvFnRBf6rxlhbDO5sDXho1Jn?=
 =?us-ascii?Q?WFkofa60qc5DE7LRRFv3ndGGUpiLni0eb/PUJKdwn+la1ikIwl4PWhEyXMo7?=
 =?us-ascii?Q?BcTgutPqxZ2vreUg3rC7tIXSsHWt5vsdRRzrumXM+rWwDYhTfEijiUhSuGb8?=
 =?us-ascii?Q?B6xw7Ay4rWIeaOp9AbS5EZDxbcj5VQJzOKRoduAQDtQTIAC87HxHKmfwyfpR?=
 =?us-ascii?Q?uhunXu8rtxTAsJ/Y+bOfrAUlXvUlfq3D2Tvsut/dlqk7BbFS4qFfe7VIMnd3?=
 =?us-ascii?Q?tdQTdnApqXkQozUea/bFGLSZUlf9K/asAYE9oCpqE4u4mKA1EJy0sxwsud7e?=
 =?us-ascii?Q?1VFoX2e5c2YNnRL6bWnqAjwwxDMd0ZFOuOi2isjN1zrS3UnDxQMPbnawst+Z?=
 =?us-ascii?Q?WYnlKuuV6eWQ3zDdeOfvnHGtQQxLVK2c6M7I3uF6PBWQuCG3kxTi4dl4X1yw?=
 =?us-ascii?Q?qlGJi1Yuhwb30fTXGJGbf/eGdw93x7TBAtJd4q018MGJTk3wSBV5ld4PYoc0?=
 =?us-ascii?Q?EA1tmY2MTr6vvx3YejHZghupx9jkCCYjcbNnEbXwo0fZADclSR/EtaBZ/ZzF?=
 =?us-ascii?Q?xHaCPPC1zTGRn+pCZZNvUSIVpzDZh07rA98hW9d5YDu57nGPr2Uj75mXBGUR?=
 =?us-ascii?Q?RRDtSAFzZoC5BDNcPOwT8BKU1qLpyX8rkdOyQo7JWG85fc1vGh53avOoHJTi?=
 =?us-ascii?Q?jBoy/T/sPgXFP2I9RNrdGSrHOte03Bct+6pWDvguhC8k/F6jz40hBlzuLSDR?=
 =?us-ascii?Q?W8sPkB7oEFptb44dbOr2mZ/J2drcYpD0nPWWqIw9ciWsTEYZxK31VA8WgCVR?=
 =?us-ascii?Q?brIIHYV1wCdduoQvU9erhTwiAiU9lzD/y/DaX3tidMtMB+6EX+LmuYNo7Q6F?=
 =?us-ascii?Q?KO3G50N3mmWlflVCc1Q8MgjbfLNsMEESvY8VTPkICKX8PBfVhSzq1t2HrdaA?=
 =?us-ascii?Q?wFnUWTG9bclgHE+Ah9xYrETDMFZLKksLvD33V/WSWpL5t4unYLQUjBWZNLzx?=
 =?us-ascii?Q?rltXM5Se02zsBdkIUpfMpRBzRIU2I1dP7tC6tYggCvO0H/Tj4yq7yJspKj61?=
 =?us-ascii?Q?UDJm8UXEDjIkJ/E78/QRDiii9GcwV0Kq3lt1JY04taUUMTDYeFIyQpcflp5A?=
 =?us-ascii?Q?zmGgoM6d8pmBwXqkorSFMQ+2telOCJkmf0RAAaxGeg148w7vvFylmUoCuqyQ?=
 =?us-ascii?Q?Jud2Q8DhhN4JNq0CHiTs4Tt039tKB4e6bb21rIzlz+2U+kldivgioHUWv42Y?=
 =?us-ascii?Q?2TxS/PHRSwgLFJeAgv5wZvkMMZnF9kPBgN61jGU010XP5gpbcSw8YRnniHGe?=
 =?us-ascii?Q?mi0b20Ay+5vw29HjrmOL/GD1FYubIuFih2HI+9av4cALESEuLlgPi5MRbbEv?=
 =?us-ascii?Q?N045WEe+UtUoHuyOO9KY+q69IyT422c3d5zUi0fGurlGWkyKgjpvCgQHTi6S?=
 =?us-ascii?Q?SodZ7zev5q2BocFFU9p1P0UFzUaL1RhlqVRBJu/9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53683db8-bedb-42b0-634e-08dae34686eb
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 11:28:48.0729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQQlUhjnnyM7YMSn/05WvATHgVRNgrtucC0l2Cacm36xzyEA19ILw17a2EBqH9OIXlWQyqnehyIYITnyJ9CvHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8575
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

V2:
  - drop the dts/dt-binding change, since this is one IC limitation,
    so handle this directlly in driver.
  - simply the auto tuning code logic.
  - To detect the SDIO device in host driver side, add some change
    in common code, move host->card = card a bit upper.

Haibo Chen (3):
  mmc: sdhci-esdhc-imx: simplify the auto tuning logic
  mmc: let the host side can find card type during card init process
  mmc: sdhci-esdhc-imx: only enable DAT[0] and CMD line auto tuning for
    SDIO device

 drivers/mmc/core/mmc.c             |  9 ++++---
 drivers/mmc/core/sd.c              |  7 ++++--
 drivers/mmc/core/sdio.c            | 10 +++++---
 drivers/mmc/host/sdhci-esdhc-imx.c | 39 +++++++++++++++++++++++-------
 4 files changed, 46 insertions(+), 19 deletions(-)

-- 
2.34.1

