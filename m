Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE8BC56201
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Nov 2020 16:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57C162220B
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Nov 2020 16:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hF9s33V8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgKSQik (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Nov 2020 11:38:40 -0500
Received: from mail-eopbgr00079.outbound.protection.outlook.com ([40.107.0.79]:5121
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727768AbgKSQik (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Nov 2020 11:38:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2U9nx4pfdXRs3Y7VNbG4ncTIrIscC5K6uXu4H7VBuH4B5lrA+ytSnpxEvXSwHCU0ycJBCp8+nSFTrOGy8EPS783o35c27JFZmEy8AzImmBj71mI4o76OnvtajKtXVcZgMRXbS2/bhY3gO/a07s6t3h+2+c5vKn752YoTWFRguIixz/lEDeEcy1g9bN2WMQrrGk7tl1vnp37xDIx/6ec9KFzHvtHcAwYp8Z00jWo0ypc8baGdYaPhvjvFJr2swIosvZVCW03Zs4cJrmWDeYxJlNNZe+qnaqGAvY0PYzmw8sVPbePgOB7SOIvs0hduvaoOVjWyB798V9WyLoNJhiN7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8BdkVVhKUjvcFBOQ7tBzkg+/N5SXzAoqi4eENemrB8=;
 b=nxO5BAgVrfYKd0CEKHTKH3zf+SMnyFwZQgCFUiTG0+3tznyuc5yze8rXbehYEvOY2R+zcPAwVqKySgHNo8+WIrDntSdoM5Jl4iMdVwbyiT8wk8guINwxyTxziMwpUvw/Ct9qz8ASOc6rVYWAfsncWseefTO4cckKeJN9MGDYO1IUVzXf0XPdxvtrTBvjVuT1ZBhpkd+C7xQnd1S9aTb4VNHVI/Ih+YMTB/eNSLtIFV+9ywq42/IDu18HhKPcUTL32QJbIAv4YwMrTUkScW8BVEh8IW5Nvxj2ldlELrGKtkDeuDTPUARBdGrdLJG/3FpSDQMbh1LWn5Q3sTl/naWuww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8BdkVVhKUjvcFBOQ7tBzkg+/N5SXzAoqi4eENemrB8=;
 b=hF9s33V8S7ABqVQ/H/j8+BR7rtzmwo0YXRfxYKkNEw/nhFDs0foN0Rtz7drlYH2pjZM+1QuD5o6kVkokf7H+Ksp7JiwOIPk7YH+pc5xro5LYvENHFDVhuXhuWZozbtJp8MpQaX3KVHwQMO08sbQDRyIfKCc5Zm5DrzpLjggjpMU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5696.eurprd04.prod.outlook.com (2603:10a6:803:e7::13)
 by VI1PR04MB5501.eurprd04.prod.outlook.com (2603:10a6:803:d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Thu, 19 Nov
 2020 16:38:34 +0000
Received: from VI1PR04MB5696.eurprd04.prod.outlook.com
 ([fe80::2dd6:8dc:2da7:ad84]) by VI1PR04MB5696.eurprd04.prod.outlook.com
 ([fe80::2dd6:8dc:2da7:ad84%5]) with mapi id 15.20.3589.024; Thu, 19 Nov 2020
 16:38:34 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ashish Kumar <Ashish.Kumar@nxp.com>,
        Yangbo Lu <yangbo.lu@nxp.com>, Michael Walle <michael@walle.cc>
Subject: [PATCH v2] arm64: dts: ls1028a: make the eMMC and SD card controllers use fixed indices
Date:   Thu, 19 Nov 2020 18:38:21 +0200
Message-Id: <20201119163821.980841-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [188.25.2.177]
X-ClientProxiedBy: AM8P190CA0025.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::30) To VI1PR04MB5696.eurprd04.prod.outlook.com
 (2603:10a6:803:e7::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (188.25.2.177) by AM8P190CA0025.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Thu, 19 Nov 2020 16:38:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e998aa9b-053a-4da2-7064-08d88ca98e5f
X-MS-TrafficTypeDiagnostic: VI1PR04MB5501:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB550155FFC5A7C21B1428984EE0E00@VI1PR04MB5501.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nr1dT/ycFp+jWLv3vTuLbVRoiZlAXgJDufvpotZT8j7YeWFZlrE6rK5mAnJnMMM4lzYRoIzEXZs048VwWaUWitDm9t5qLIfevpxatdOGzbDfL45pPNoD48bxmiOz2p+/tQBhIun2SF4aV3jSBBEmmgXIzJYyiijYHoZYnM91gUssycxXjfYQmogjZcwejiXdhYeEXbrWWrH1TZDvpECXkgXsogDW3C8UpCEzJsJjekByPvYRQ72dmfNIpvGclVnDBVM+VQW6IgSdTVTY3rw8uN253YEyk+q0j4Rc+e7yRbXWH5lt7h5Hy/73MSO86O9/Ur3W6vv7Y/bBbaoyKZ8UxAfkwC85mtHA7k+XIRsmNJkDLXY6L9bEaAu2WWd4Xjga
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5696.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(8936002)(2906002)(66556008)(86362001)(54906003)(66476007)(110136005)(83380400001)(316002)(6506007)(5660300002)(44832011)(8676002)(52116002)(186003)(16526019)(36756003)(1076003)(69590400008)(6486002)(4326008)(6666004)(956004)(6512007)(2616005)(26005)(478600001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: bQjU1aXEKcZSNr3qHIXZBzW4fw0wHwURJlUrvt2rqF3KTXnD22hz2vE2ZuuGYVWV7SSYmMypLXKoxVr4dKWPd0dZ07PPf3yyPbGZbdMrjsIND8nFU2wsHg56s/jFefrn0p+B1TzgL9vv+uIS1xlv2Ruh/AtIfhjwdT9lC1QQXtU/+dGziJMmbg501ZmwHdPYK3KUn31M+kE8UYL2xLSDnZg4PabHnvAj6Sy6tFKBbGtXYF4fPb4kzd/TDA4fAUxdDR1d0JIi84O2yVTbIhmtaQ8skc+CoETZimPgvaxRIhELxJOkTkGgDtaxCSA+pwYYPkopNCiL0G3KdpJakiO35TC8GXFhuoFkYOthHloQVgGfjr06NYh33GwUhnCj5oHBofa2aQWcmRTblvDi+3JhRtVd1TsZIX7pKvbAAWyO65VXF+GPUp9yw0URZsx0q589TJ8lXr6jnvV2KMMPV4df4QByyUhFhXge5LW0ParxLwjtgW1cdDolcx4/tLAudeHmmcOZoRyexajJ76SV2V8UEvk1KCfkCLJ3vtUX2hzhdpK7g/L5Bsu8wlps8hPmU5Vyd+1Ql+u5rTeu1wPs0KSfUFPypoQY39hGXwKrYgCzWwWOeVFARxWT+8Np32cywi5UAyrvzavJ+JUsXXlk+Wj/1A==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e998aa9b-053a-4da2-7064-08d88ca98e5f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5696.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2020 16:38:34.0645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQ8hKG5rxLEWdAFrigF1RfAkC4RZ0Y84fccLQ3qQR5jY5M+9w0hYdPdegXdfe8ggC4PvZrGLm14H2nHnHCVowg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5501
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

As the boot order in the kernel continues to change, sometimes it may
happen that the eSDHC controller mmc@2150000 (the one for eMMC) gets
probed before the one at mmc@2140000 (for external SD cards). The effect
is that the eMMC controller gets the /dev/mmcblk0 name, and the SD card
gets /dev/mmcblk1.

Since the introduction of this SoC, that has never happened in practice,
even though it was never guaranteed in theory. Setting
"root=/dev/mmcblk0p2" in /proc/cmdline has always caused the kernel to
use the second partition from the SD card as the rootfs.

The NXP development boards are typically shipped with either
- LSDK, which uses "root=UUID=", or
- OpenIL, which uses "root=/dev/mmcblkNp2"

So for OpenIL, let's preserve that old behavior by adding some aliases
which create naming consistency (for LSDK it doesn't matter):
- the SD card controller uses /dev/mmcblk0
- the eMMC controller uses /dev/mmcblk1

For the Kontron SL28 boards, Michael Walle says that they are shipped
with "root=UUID=" already, so the probing order doesn't matter, but it
is more natural to him for /dev/mmcblk0 to be the eMMC, so let's do it
the other way around there.

The aliases are parsed by mmc_alloc_host() in drivers/mmc/core/host.c.

Cc: Ashish Kumar <Ashish.Kumar@nxp.com>
Cc: Yangbo Lu <yangbo.lu@nxp.com>
Cc: Michael Walle <michael@walle.cc>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts | 2 ++
 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts          | 2 ++
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts          | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
index 8161dd237971..99a17c187aa8 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
@@ -23,6 +23,8 @@ aliases {
 		serial2 = &lpuart1;
 		spi0 = &fspi;
 		spi1 = &dspi2;
+		mmc0 = &esdhc1;
+		mmc1 = &esdhc;
 	};
 
 	buttons0 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
index 13cdc958ba3e..c0786b713791 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
@@ -23,6 +23,8 @@ aliases {
 		gpio2 = &gpio3;
 		serial0 = &duart0;
 		serial1 = &duart1;
+		mmc0 = &esdhc;
+		mmc1 = &esdhc1;
 	};
 
 	chosen {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index 1efb61cff454..c1d1ba459307 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -19,6 +19,8 @@ aliases {
 		crypto = &crypto;
 		serial0 = &duart0;
 		serial1 = &duart1;
+		mmc0 = &esdhc;
+		mmc1 = &esdhc1;
 	};
 
 	chosen {
-- 
2.25.1

