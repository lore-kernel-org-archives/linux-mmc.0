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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0DAC56201
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Nov 2020 15:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C91C9246CA
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Nov 2020 15:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n9OG2s6W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgKSPu4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Nov 2020 10:50:56 -0500
Received: from mail-am6eur05on2040.outbound.protection.outlook.com ([40.107.22.40]:34529
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727428AbgKSPuz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Nov 2020 10:50:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvKMGZ84nSsheJPX+Evft02OP88aeClZOGSi9iMhQFVON3TDkIid596UpyfG40axJjt7hDtj1J5QY4KjwDO3xJ3Q9XSQRY0/hKL4G6F7RJyqFMkP38JDDBT51LQJ7JQeIsIIy3gS9fz/x4yILG6M42VkgQeSi0tZfWdX67QiWId1e/R/Nw1ENOgd2Jj8bPYjmc/Yt4zZrv9m8uiOLfP279+zhsgrQ7FQlff4rXIBoZu/Qd4VTt+T/diWGyekVoYEOQANvVK3ysuJfiS+bdIchRPPzpiMySv8yTaOiAHqSfKAMdy4/NcMwwCBPRl8CRKBKHME1W/CNl1N/vWni6dbCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKvnFACw6HePI5+XWl5N70lQ8GELU9Xl/CMUrplLAYU=;
 b=OAXZJuj5WnvPqe6cSaP68LTtowCbxV7dMGCCacj0+ieH9oeUf9nGLN8MapyJ38mhakFiLeG77hfwVrr7HEcE++LogN+JK4raX4lHGjlYNIl90BBaPg8hJq+r5ybf+GBD7GCe35028nCxbwjNbj+JOGQVwERwIhM/qALD5QEt7RBM5XTDsi6bQM+fWq+kEDVU8fyWPcykuPymUIgcms4Rs3ykKZ1gDDTs4QeqvpiqVjVWhv7MMTqKG8duzTaISAnTKovtDgSy4h8DjEKfVURcp8MyRNEtmZacHFF7L+GzdtDYpL2DK8csqReDj2/ESGG86UDNTVFOul0C4xNlZJFylA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKvnFACw6HePI5+XWl5N70lQ8GELU9Xl/CMUrplLAYU=;
 b=n9OG2s6WTaYywvRnhyUvb4hy+EZvQBuLpsJXkJhmp5AdF+01YFq33jbBkwtyYxrjGc/CC4GVPgTtHZ4X3XSzqlX8QXKBsIn2qWCPs8F9wVgsJ9s0b6v2rSl7llNrHwfXt2w6xuEgbI4FOpCOhoPDaASFQOpGN2sjlvoIBf5R9xc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5696.eurprd04.prod.outlook.com (2603:10a6:803:e7::13)
 by VI1PR04MB5503.eurprd04.prod.outlook.com (2603:10a6:803:d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Thu, 19 Nov
 2020 15:50:50 +0000
Received: from VI1PR04MB5696.eurprd04.prod.outlook.com
 ([fe80::2dd6:8dc:2da7:ad84]) by VI1PR04MB5696.eurprd04.prod.outlook.com
 ([fe80::2dd6:8dc:2da7:ad84%5]) with mapi id 15.20.3589.024; Thu, 19 Nov 2020
 15:50:50 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ashish Kumar <Ashish.Kumar@nxp.com>,
        Yangbo Lu <yangbo.lu@nxp.com>, Michael Walle <michael@walle.cc>
Subject: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card controllers use fixed indices
Date:   Thu, 19 Nov 2020 17:50:25 +0200
Message-Id: <20201119155025.965941-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [188.25.2.177]
X-ClientProxiedBy: AM0PR01CA0172.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::41) To VI1PR04MB5696.eurprd04.prod.outlook.com
 (2603:10a6:803:e7::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (188.25.2.177) by AM0PR01CA0172.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21 via Frontend Transport; Thu, 19 Nov 2020 15:50:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f9fcff52-d3ca-4c5c-a376-08d88ca2e37d
X-MS-TrafficTypeDiagnostic: VI1PR04MB5503:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5503E82824ECCBC86F80F9C1E0E00@VI1PR04MB5503.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kj4D2M/pleVTXi8uw6UUIrVxT88qAp312Mj58GENZzXqUuU5i3bJGEddal/bQRuWtmHQECfm5xa1e2dsXbfAMHApeA04Cc7HbKr+u4EiAaPNbBTuhrwKeJazLZ7HVHzIo2qSH+JSEbgjuMnJeevpMGVDP5KXpsPBeWDdi8sHJ4L8sxIWnCXx0GMc1/IEsUfy9Vtx5mdij9hkdX17iksZaYhfbUT6O/SzIa0hvoQMYAOD9MGdOHR7F5sFdCFY/4J9vB+Z34beAS5BtburYlkyX6mKhfOk72oeX+r7oxaKBouASJUyP084T6qv7af/Q+2/WsR08+lmrPkjSP/nTmASKg6vc3fbCiHRc9vvoHzFRRZu38mZbY8NM+JdBRTNDvdc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5696.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(5660300002)(52116002)(86362001)(66556008)(66476007)(66946007)(6512007)(6666004)(2906002)(6486002)(36756003)(8936002)(2616005)(956004)(186003)(16526019)(316002)(44832011)(8676002)(1076003)(83380400001)(54906003)(26005)(478600001)(4326008)(6506007)(110136005)(69590400008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1Y9FyEOJOeq+SWIaYF9L8CrdU9j+XVXWY9uoC3Jk4rCrwLkkD1RzaARJHZJSJRyaDfQ/m6QdVyDtxuZo7x3i03XTQZWa6jv93PzlA+BfbkwY8xxXxn+v9/fTKPkgY0TABHJO/cqmvl5mnhZz1ScuMWJDrUp+Rqvs3z+T5qpOTZ0Mxyr57Du/a7LIxkpJKuaYlhqEDBiwgXHmvvOYlcVPRfTU7rjy7KIvH15cmkzP8sLdK/BSdh/Ro+yWQPFFTpiUwmM4pMEyYihj3iAAVFYqfuYlBoCdH3qDyo77Jz35T1S3IyupQalnKE5YttBQvyymtBI0Ssjr24Rn2+3qJWG9tyCWeFAXGlzwnssuvCFBkcNVN+CILAnGO3ATvro2A1unC/0RaM1/2BnUldyY6acYMVDxCiDP8Ig0NB2fE9BUVT7eIB/sddewLczgnYXjrmZItI2RHi9/L+N6h+tVA3nSSEu0+8f3kM0FJTaSqgJhTqEQpOjJ1IiWhLvVLke98YZTa8ZNT6VYZTvoVyJ8gGc4T6jSH09KV3UfLW6X2MKS2O2xh4rOHjzbKxsHK6ZP9QYsOhPDCuO1WJZoFmMUlYD4mwaf4OClvWZZr7jh8Ei3JJmRA1GY69F9jhlRduKTvdlZs3NQBglbhJ2ErG1RBIOc9A==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fcff52-d3ca-4c5c-a376-08d88ca2e37d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5696.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2020 15:50:50.4496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gr9OURlqzIEORCGUXhbap6FM74j8lErFuypnR3mvYwVcIquFvILD7zP6PIk3/W2GTsbULHtT4+gwEm0U6RE+ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5503
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

Preserve that old behavior by adding some aliases which create naming
consistency:
- the SD card controller uses /dev/mmcblk0
- the eMMC controller uses /dev/mmcblk1

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
index 8161dd237971..7d292999f8da 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
@@ -23,6 +23,8 @@ aliases {
 		serial2 = &lpuart1;
 		spi0 = &fspi;
 		spi1 = &dspi2;
+		mmc0 = &esdhc;
+		mmc1 = &esdhc1;
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

