Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D943DC433C1
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 22:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E54619A5
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 22:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhCVWrF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Mar 2021 18:47:05 -0400
Received: from mail-eopbgr760072.outbound.protection.outlook.com ([40.107.76.72]:26181
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230258AbhCVWrD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 22 Mar 2021 18:47:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsvKz+UCTYf9O5ZtRdO8iCoraJctxJ3dXLRz+gRIHA7JtxbQpGma9+GpfcXkCcz5RkF4sHO79a+a7SaOcgkbls3j9vEVapmYhQwDPLyx3t7Jcw67C7qVFJeIGS3h8HQfibwWuzw7k4QVu5GudplIgXUpH18TmR8bbdgX8l/9cFJaHdIIZ10ndqEJelHVYBDaewzdpvForq+dbGTiqJhYlCjZ5vAaYjUM25BAuofqKX93JONF/qh7OFWoMxXDoJaTAYEuRbWzgh0djMmmxko/Y6dQ2fuDyXkGfbXXTx7bz54CDZo6okrAwkvho8I1YiUv6ADTQF2noU/EvGf3ry+kJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zej0EsHeBAE8GFJ1xa+PRgNcyjGTOWHoO85fSdvxJIs=;
 b=CnZGmeoeIKegD5ir9KSG4QMBtdm07Uk1eY+p5092/z3hMHoq9NYLgIoSLvUnld8x8pJdZNtciTp2o+9WP4OC1+eeteTkqHvF+d2rYYDzYZcQsyTk/qKV432KqpN8/OZurRwgDSy8z6HVzsqB0fISwoVQVwwKZxUgQvrI5Tn427JMmjN9wipnxHHQRjNGaCQz6PyCPl7EO6Ywc4gOqMk4AXbG5CfUTsgwhOT7RMMBfPen/VKgY5L5YVcNr+CfQrNwl1CcPJQPFgn4+nSXjvlzTcwBH+AaMVL1Q2W+WAE9PnhQtgHIOB58P/exrB0NN6IVboSOyKCcRdgVesEPv0UlMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zej0EsHeBAE8GFJ1xa+PRgNcyjGTOWHoO85fSdvxJIs=;
 b=l+9Fql3JUE4lLI3yGDbXinzqr9iv6O42XKd6QGYept62NvKgwYUeNZinyEkptFsR738rTnoyr3R5ebcdW1ldrTpKE9SUBbrhEVcK78iMYLr8oD7hlRB82O6rvfp2UwXfq59fSUj7TWgVJE5TCFhZrgKNzE/8ZEu1AE+wLpk3+xPRAb4gJgdPfO1FFczF41P79IlnRtPvk7SfXXGHMNNnSYcnMRlJjVV/npjng38hS0rPW2sevg0kJKFTQXw/6OgGj9pY/qhvgZIt7IASIKlL8tOIjzA2BDA/L0H+8Nu47yhuv72n4YHgkWuMyypwiMq2LBuVJ+Txv9T5N0hSoNUptg==
Received: from MW4PR04CA0293.namprd04.prod.outlook.com (2603:10b6:303:89::28)
 by BY5PR12MB4818.namprd12.prod.outlook.com (2603:10b6:a03:1b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 22:47:02 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::2b) by MW4PR04CA0293.outlook.office365.com
 (2603:10b6:303:89::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Mon, 22 Mar 2021 22:47:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 22:47:01 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 22 Mar
 2021 22:47:01 +0000
Received: from vdi.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 22 Mar 2021 22:47:00 +0000
From:   Liming Sun <limings@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Khalil Blaiech <kblaiech@nvidia.com>
CC:     Liming Sun <limings@nvidia.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] mmc: sdhci-of-dwcmshc: add ACPI support for BlueField-3 SoC
Date:   Mon, 22 Mar 2021 18:46:51 -0400
Message-ID: <1616453211-275165-1-git-send-email-limings@nvidia.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <b62a68d1f8488e7f95befc6723ba5c20d6781628.1615487235.git.limings@nvidia.com>
References: <b62a68d1f8488e7f95befc6723ba5c20d6781628.1615487235.git.limings@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66707ab4-3126-4341-577e-08d8ed846879
X-MS-TrafficTypeDiagnostic: BY5PR12MB4818:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4818136CD5AF1292B9FE9B97D3659@BY5PR12MB4818.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3M2z72cHkn3a0jbRgRVdP1KNSh6uu6oCMV3L+GC14whIHAboWEC1xetyE6SdaT+MohV8k3dak+PkTUG2D+7Ij/hwtZR2roCXCLWUqAQJpTJl6vZUGyc9ceYpYs8HjOrVp2y8F9pT8pqkNlBTyiAsGW5nUkHB9dokgljB5IqJSwAKMDxeoiC3iyD/qtWu0iRO/sQ8K6GNxW9GoK4PvjFiWQ4NQ+S6xJTST27zgQC+rdlaQC9cq0aLnGFSPFbG67TM36Y5/wlRyooOnP4ZoeRM9dKu6kDkJy8nqc6LpB2pXniyrVRt+jVbxuOTNJXZDhoAg2zwGIpa7evfpuF6ERtbkcRrhfG0q+55wp+afARVS1GS4qw2MFXdBeUXKWayGSM3Tfn0wZtdwczZGdBfebH6fXhsqnBiK7mfW1PWk53rHbceatlmTSrPuKxoxmjPD+OsUVB1Yoj7zh8ELCGXAB5pkrWzVbuhQbTDAjuzfdwot9yV7NOV8WaQKLBDDxKyAKOjcGeyoqm15PH2I/9zqjOYhTiMJEe425z+7qyBIg5a48VC2HLzW4jggmKz6Hha9xS2+AUTk9mPSj9ujmYJWHkDTsc80nTwxx22BFhZ44HJCoPAIkkYvcvvqKqA0YuqjDnbeI7jZhaUvxOcCrCUnCHNTff4HMFWbNZQ5qIJzf96ZFS9d0LWLk6cya8r1+bJUTR+
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(36840700001)(46966006)(82310400003)(2616005)(6636002)(336012)(478600001)(86362001)(83380400001)(36860700001)(47076005)(82740400003)(7636003)(110136005)(54906003)(5660300002)(4326008)(8676002)(2906002)(70206006)(7696005)(356005)(36756003)(186003)(8936002)(70586007)(6666004)(26005)(316002)(426003)(36906005)(133343001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 22:47:01.6064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66707ab4-3126-4341-577e-08d8ed846879
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4818
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This commit adds ACPI support in the sdhci-of-dwcmshc driver for
BlueField-3 SoC. It has changes to only use the clock hierarchy
for Deviec Tree since the clk is not supported by ACPI. Instead,
ACPI can define 'clock-frequency' which is parsed by existing
sdhci_get_property(). This clock value will be returned in function
dwcmshc_get_max_clock().

Signed-off-by: Liming Sun <limings@nvidia.com>
Reviewed-by: Khalil Blaiech <kblaiech@nvidia.com>
---
v2->v3:
   Rebase to mmc next.
v1->v2:
   Changes for comments from Adrian Hunter <adrian.hunter@intel.com>:
   - Make changes in sdhci-of-dwcmshc instead.
v1: Initial version which was done in sdhci-acpi.c
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 50 ++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 0687368..1113a56 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -7,6 +7,7 @@
  * Author: Jisheng Zhang <jszhang@kernel.org>
  */
 
+#include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/iopoll.h>
@@ -94,6 +95,16 @@ static void dwcmshc_adma_write_desc(struct sdhci_host *host, void **desc,
 	sdhci_adma_write_desc(host, desc, addr, len, cmd);
 }
 
+static unsigned int dwcmshc_get_max_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	if (pltfm_host->clk)
+		return sdhci_pltfm_clk_get_max_clock(host);
+	else
+		return pltfm_host->clock;
+}
+
 static void dwcmshc_check_auto_cmd23(struct mmc_host *mmc,
 				     struct mmc_request *mrq)
 {
@@ -248,7 +259,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
 	.set_clock		= sdhci_set_clock,
 	.set_bus_width		= sdhci_set_bus_width,
 	.set_uhs_signaling	= dwcmshc_set_uhs_signaling,
-	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
+	.get_max_clock		= dwcmshc_get_max_clock,
 	.reset			= sdhci_reset,
 	.adma_write_desc	= dwcmshc_adma_write_desc,
 };
@@ -323,8 +334,16 @@ static int dwcmshc_rk3568_init(struct sdhci_host *host, struct dwcmshc_priv *dwc
 };
 MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id sdhci_dwcmshc_acpi_ids[] = {
+	{ .id = "MLNXBF30" },
+	{}
+};
+#endif
+
 static int dwcmshc_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_host *host;
 	struct dwcmshc_priv *priv;
@@ -347,7 +366,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	/*
 	 * extra adma table cnt for cross 128M boundary handling.
 	 */
-	extra = DIV_ROUND_UP_ULL(dma_get_required_mask(&pdev->dev), SZ_128M);
+	extra = DIV_ROUND_UP_ULL(dma_get_required_mask(dev), SZ_128M);
 	if (extra > SDHCI_MAX_SEGS)
 		extra = SDHCI_MAX_SEGS;
 	host->adma_table_cnt += extra;
@@ -355,19 +374,21 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	pltfm_host = sdhci_priv(host);
 	priv = sdhci_pltfm_priv(pltfm_host);
 
-	pltfm_host->clk = devm_clk_get(&pdev->dev, "core");
-	if (IS_ERR(pltfm_host->clk)) {
-		err = PTR_ERR(pltfm_host->clk);
-		dev_err(&pdev->dev, "failed to get core clk: %d\n", err);
-		goto free_pltfm;
-	}
-	err = clk_prepare_enable(pltfm_host->clk);
-	if (err)
-		goto free_pltfm;
+	if (dev->of_node) {
+		pltfm_host->clk = devm_clk_get(dev, "core");
+		if (IS_ERR(pltfm_host->clk)) {
+			err = PTR_ERR(pltfm_host->clk);
+			dev_err(dev, "failed to get core clk: %d\n", err);
+			goto free_pltfm;
+		}
+		err = clk_prepare_enable(pltfm_host->clk);
+		if (err)
+			goto free_pltfm;
 
-	priv->bus_clk = devm_clk_get(&pdev->dev, "bus");
-	if (!IS_ERR(priv->bus_clk))
-		clk_prepare_enable(priv->bus_clk);
+		priv->bus_clk = devm_clk_get(dev, "bus");
+		if (!IS_ERR(priv->bus_clk))
+			clk_prepare_enable(priv->bus_clk);
+	}
 
 	err = mmc_of_parse(host->mmc);
 	if (err)
@@ -489,6 +510,7 @@ static int dwcmshc_resume(struct device *dev)
 		.name	= "sdhci-dwcmshc",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = sdhci_dwcmshc_dt_ids,
+		.acpi_match_table = ACPI_PTR(sdhci_dwcmshc_acpi_ids),
 		.pm = &dwcmshc_pmops,
 	},
 	.probe	= dwcmshc_probe,
-- 
1.8.3.1

