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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1711DC433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Feb 2021 18:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8FB564E2F
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Feb 2021 18:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbhBJSjj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 10 Feb 2021 13:39:39 -0500
Received: from mail-db8eur05on2047.outbound.protection.outlook.com ([40.107.20.47]:60468
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234029AbhBJSh2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 10 Feb 2021 13:37:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrYhwyP18wSIGDB+BKItPKGr+QRak/US4c+PQwbwIYhJDIOnS/N1Odh4YHtv7h/J+SY2/bEtVFEyLfX8FX8VdetFJ6IYiMrlDL3HtEUPrManWevBpbmMOulKKexd3KIYf/ifduccdcuyY5V4EZGNW3vUG0ENtlG/TO7iGbprTrmOYVuNyZIiK9eHntUSay6vtwPEQfw8blnpcrCRTCIe/HyX7tWfQjZKXTBf+XQ2Wm/LcZsek1RZeY/o6SX2D6RFTfQkiyJ0s4MaUkXGjT4X3qKD+qARIiBWadZE439XhmA92fAsZJLIl87L1WO8OIkcFf7q0PLHuF1H7GU+t8sSWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/gqe+v6VQmzp6qghdZjeJ9Ed3FPYBCrknKjan19k+I=;
 b=LD/fyisyedul0155u0sJm5GP6vsXYyWqb9FJ5H35nLdrQqRp0tpws+wLRoK39T8a3nbEHdx5mlpYDCzy/6om9IUk6rfAnZ8JCiZlHGdrr/ZLttM3xe7HIdPh6X7ZXF07dFcJ3wvIX02cDfnJq3yMQTCa92n1oGDdEGksSspqzK6YglX7vEllfOg3TunQEq5rPXk46YtlXc8bj5D4J5wVR8HqVrppkIHwgQbKfOCnO840WoOo3asTKO6xGzGAxLJ7JIT5eT/qGgKmZhyiiV1iG5nrdUl3MjeifgkB06qPP8/HOGk5Ls9ec8FyXwgNObEOhwqb3Cf/ttzyDIYj2Ct1cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/gqe+v6VQmzp6qghdZjeJ9Ed3FPYBCrknKjan19k+I=;
 b=h8tutTEVO2ysAjujU/n306J7wRiI1lvkDDSaMzhZzrzzAuBwXKCvcgedKUA9q107hQyiGlZfqdMjp1FeyTmfP/arcNCBNXVP9fncRn4jDLgW0AjbgU4liG/nsHKOFB/xgEKnpsRioWaNsjEF07mXLP4r6Gxu59+aoIWnhZvAEow=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8053.eurprd04.prod.outlook.com (2603:10a6:20b:2ad::12)
 by AM6PR04MB4552.eurprd04.prod.outlook.com (2603:10a6:20b:1b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.25; Wed, 10 Feb
 2021 18:19:52 +0000
Received: from AS8PR04MB8053.eurprd04.prod.outlook.com
 ([fe80::b8d2:f45a:dfd2:588e]) by AS8PR04MB8053.eurprd04.prod.outlook.com
 ([fe80::b8d2:f45a:dfd2:588e%4]) with mapi id 15.20.3846.025; Wed, 10 Feb 2021
 18:19:52 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        s.hauer@pengutronix.de, linux-imx@nxp.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lznuaa@gmail.com, haibo.chen@nxp.com
Subject: [PATCH 1/1] mmc: imx: fix kernel panic when remove module.
Date:   Wed, 10 Feb 2021 12:19:33 -0600
Message-Id: <20210210181933.29263-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SJ0PR03CA0371.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::16) To AS8PR04MB8053.eurprd04.prod.outlook.com
 (2603:10a6:20b:2ad::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lizhi-Precision-Tower-5810.am.freescale.net (64.157.242.222) by SJ0PR03CA0371.namprd03.prod.outlook.com (2603:10b6:a03:3a1::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Wed, 10 Feb 2021 18:19:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 39813c51-f5a7-4c8c-c328-08d8cdf07570
X-MS-TrafficTypeDiagnostic: AM6PR04MB4552:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB45520B0340B6649D1B1ADBE5888D9@AM6PR04MB4552.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 60Esk8rFJyoqUSYPqngf2PrkC/xIbeo1Tsi4hWH2nLZXUdBjbCllvMnMwAKgf14Okd0IJqhukCOyOdotqTOU8T4Iku3OaaAFOdynS8WAHMohpOz45Wu3tpiCljFwXT/w5UvTFkhtlkYXspDpJgJ3qc0fuwxxBWSyn5/EljwYM9LZ2sLQtWK7mD0oaC7FviFEVzjdTlP85UJqTAynvAO6wlK0GTAJoT7ZnkRh/XLQsvAFwnK+uq/01ve0taB1GFUEkaHIGkEFuhUvi0lDKNMyUPRRbMXAOgnx9VHxuEAV4N7v6akIXaSaaF+cPXe2VCBPAXq9jX+90zQx7fhJsnnHdpS/093IOGFPzbMscKMTk5aBv5f9HJ5G6Vb2IGaJiO2fVzrwmaEdoHJzihlRZbREpx7sX7AEe9mBUfdxyc2N54IZ+Evsx3qH6YPVmQD6GDOv0fDjGzoXxkYteEwWhMiAjW9uQe0euXOMwlBcn6iR6xKf3gWE8CwlnzSRzgCANx8HJ+pyJxyeUiKDtGs71itAGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(36756003)(6636002)(1076003)(66946007)(83380400001)(26005)(2616005)(2906002)(16526019)(8676002)(8936002)(6666004)(45080400002)(478600001)(316002)(86362001)(52116002)(66556008)(6486002)(6512007)(6506007)(66476007)(186003)(956004)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7OfSOeoPCl0QT4IlhGAkrJMFkjjuNh12wv6j0iWcF3lxyImzS7kfTt9nMaVv?=
 =?us-ascii?Q?D6ksVyMVqoGfER/Rec1rfCe6k/wHQDsfUhacUP30iBlYeMXDbZ5ZUkIY1d8P?=
 =?us-ascii?Q?gHQ7E0Rq8gNcx/I++gY0dVsa9GxAWJ7Apq+7qrSYCbuH6/YpzrLIG6P2DH/Q?=
 =?us-ascii?Q?zy5MqS7u6nGYwjuu1d//cwIixoIHxx/h7QD0LtX2Id5Uut2uCmWn/MhhbVZ9?=
 =?us-ascii?Q?MRJKh5mBrhpyPM+Ee2YypuikW5IYQuzBEQ2QCWUtquxLbIETQeiByhPfLdtC?=
 =?us-ascii?Q?vc4mc3B7uXgJkKdozaCGPH5jc1Xt93ixwh1HsMezTCJ0t0TH499q55wyEh6p?=
 =?us-ascii?Q?+M6nj5EcFzqFDYK0kYrfd90aQ8VX9y45D3PYNeEG9ZUKJ3bm47kHHOjBXdY4?=
 =?us-ascii?Q?syktWTHPnGjhw+S4vZfPyKwuuhv2Hin+McADysnUOFndmuFYSfIgVgsR1KaT?=
 =?us-ascii?Q?URjrLywVePZ8BglIGQKHiC71TYYPxyFDZ/Jty73G042g5WXLvge1cdZUHjbm?=
 =?us-ascii?Q?sroenUJJK9eIdL+ZIkAoQ0G5BY36S+yMUtgUKOPVe17QBwybHDev0UnOc5ki?=
 =?us-ascii?Q?hqds2TwubrA1p5vA1L3OSiy12CootWmhBnCSg8iVWE0GlfM5v9w/AVi1RC1m?=
 =?us-ascii?Q?4ciC1tbkfN/+KaZAxdoaNy2DcJVtWz7WUJKad8SKQ+HNt/11pTsLy2ELHvBk?=
 =?us-ascii?Q?/q/ir/nSbJU2w1H2iPFeoNlZ7IUH/qcm7MruCPXQEbTXqLbpfjZJRNkmcH/o?=
 =?us-ascii?Q?/v+5dWJtrBSV1f5okFFO81fyezBiGVcLZL12J81gP4Zc5RzHZlGKNMv/sqDl?=
 =?us-ascii?Q?K6/3HTQbBWWhvS8D+bhRjpQJLZmDfQpiqViefqv9O3aUVRF9DfaBJ3Dy3q4+?=
 =?us-ascii?Q?kT9wfAAeiDA2RsYLRwfoGhtd2Iq6no9+rg151tgQiGDjDJvZRhClDdDg1sDr?=
 =?us-ascii?Q?xbahAHFjiQm7jExcRNFgNcDwTds64As25AMxDucdH/IS3i6KT7rYy55Qat7f?=
 =?us-ascii?Q?b9JCPNyyHbDNf0u66iT12nklJNXKwv50vIfoczWvGDyCA49T7bkPSPwmsM+y?=
 =?us-ascii?Q?Tq/pEK/qXlZHQkfcJa8M9o7j22Axc+dU9JbpLwO+KlHMgYk96iqkh5sBD4ha?=
 =?us-ascii?Q?51YSon4PuOv9yreXVuYDr8350tfAD0pgpeU9G4Ol4QeHHgK05wzPzMoJURGX?=
 =?us-ascii?Q?nlFlRWaCNsPbZLOeeifljEhVS7F70kl2ho1ihGK5e23I1W3S3C+1ldoORZ3k?=
 =?us-ascii?Q?+5qzCLP05RtCJ7d2OW7gS+ngnsh3QQK3aJyo9Fbc4y1R9/CPcG+k1ln+NHxj?=
 =?us-ascii?Q?zCGruRw7M2CQ49nw/dFdvhOb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39813c51-f5a7-4c8c-c328-08d8cdf07570
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 18:19:52.0518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AbGMeEFjPDYudhuiamxKxt99r9WokwZNDmCyXVttwPxmREhj8fj00lBDsbNbaPlEan7whoU3G1OLjxuU/vLdTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4552
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

sdhci_esdhc_imx_remove access a register before pm_runtime_get_sync
the clock may be closed by runtime pm when remove module.

Access register should be after pm_runtime_get_sync.

reduce pm_runtime_set_autosuspend_delay time can increase problem
reproduce rate.

[ 1811.323148] mmc1: card aaaa removed
[ 1811.347483] Internal error: synchronous external abort: 96000210 [#1] PREEMPT SMP
[ 1811.354988] Modules linked in: sdhci_esdhc_imx(-) sdhci_pltfm sdhci cqhci mmc_block mmc_core [last unloaded: mmc_core]
[ 1811.365726] CPU: 0 PID: 3464 Comm: rmmod Not tainted 5.10.1-sd-99871-g53835a2e8186 #5
[ 1811.373559] Hardware name: Freescale i.MX8DXL EVK (DT)
[ 1811.378705] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
[ 1811.384723] pc : sdhci_esdhc_imx_remove+0x28/0x15c [sdhci_esdhc_imx]
[ 1811.391090] lr : platform_drv_remove+0x2c/0x50
[ 1811.395536] sp : ffff800012c7bcb0
[ 1811.398855] x29: ffff800012c7bcb0 x28: ffff00002c72b900
[ 1811.404181] x27: 0000000000000000 x26: 0000000000000000
[ 1811.409497] x25: 0000000000000000 x24: 0000000000000000
[ 1811.414814] x23: ffff0000042b3890 x22: ffff800009127120
[ 1811.420131] x21: ffff00002c4c9580 x20: ffff0000042d0810
[ 1811.425456] x19: ffff0000042d0800 x18: 0000000000000020
[ 1811.430773] x17: 0000000000000000 x16: 0000000000000000
[ 1811.436089] x15: 0000000000000004 x14: ffff000004019c10
[ 1811.441406] x13: 0000000000000000 x12: 0000000000000020
[ 1811.446723] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
[ 1811.452040] x9 : fefefeff6364626d x8 : 7f7f7f7f7f7f7f7f
[ 1811.457356] x7 : 78725e6473607372 x6 : 0000000080808080
[ 1811.462673] x5 : 0000000000000000 x4 : 0000000000000000
[ 1811.467990] x3 : ffff800011ac1cb0 x2 : 0000000000000000
[ 1811.473307] x1 : ffff8000091214d4 x0 : ffff8000133a0030
[ 1811.478624] Call trace:
[ 1811.481081]  sdhci_esdhc_imx_remove+0x28/0x15c [sdhci_esdhc_imx]
[ 1811.487098]  platform_drv_remove+0x2c/0x50
[ 1811.491198]  __device_release_driver+0x188/0x230
[ 1811.495818]  driver_detach+0xc0/0x14c
[ 1811.499487]  bus_remove_driver+0x5c/0xb0
[ 1811.503413]  driver_unregister+0x30/0x60
[ 1811.507341]  platform_driver_unregister+0x14/0x20
[ 1811.512048]  sdhci_esdhc_imx_driver_exit+0x1c/0x3a8 [sdhci_esdhc_imx]
[ 1811.518495]  __arm64_sys_delete_module+0x19c/0x230
[ 1811.523291]  el0_svc_common.constprop.0+0x78/0x1a0
[ 1811.528086]  do_el0_svc+0x24/0x90
[ 1811.531405]  el0_svc+0x14/0x20
[ 1811.534461]  el0_sync_handler+0x1a4/0x1b0
[ 1811.538474]  el0_sync+0x174/0x180
[ 1811.541801] Code: a9025bf5 f9403e95 f9400ea0 9100c000 (b9400000)
[ 1811.547902] ---[ end trace 3fb1a3bd48ff7be5 ]---

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 16732759bfb0..4da4f4734641 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1791,9 +1791,10 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
-	int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
+	int dead;
 
 	pm_runtime_get_sync(&pdev->dev);
+	dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 
-- 
2.24.0.rc1

