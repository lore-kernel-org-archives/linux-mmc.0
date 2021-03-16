Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44995C433DB
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Mar 2021 23:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1392764F91
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Mar 2021 23:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhCPXUO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 16 Mar 2021 19:20:14 -0400
Received: from mail-eopbgr680089.outbound.protection.outlook.com ([40.107.68.89]:55161
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229536AbhCPXUE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 16 Mar 2021 19:20:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJ8tnYzznKDCGvhbnGpCmQ6rdnT+JBMruSnz/QlPYOpMmdKmIs4NO2uPXgWcflO3S3ZoThRzKTX3JWLSySVCnxKIwRsBK0EIeTAfHAdW9WT7SHA1qbokMZZwuOFLYVM+gLORpcX3qF8igQVmIo1SyfaLVIshXxUP45Hw9zghGTtyG8JBPxpiNpM15rkWcTTEp0qvs0+0FsUIArHd9hR3mbtMsFg3b/GQqTgYZ+b6sNFoE4bcEEM8b6af59YW8724RBjkWVT7jqjwBSCSbCZyy3gp9qTeGFxhGKAcTeghZQdPMR0j5xZwB0zgB84WUaKogegqDAW258zQ2KszMksrKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORBRWXR60KeLitV095ZZaonQQxsAfdjtiJLrxLdWIFI=;
 b=oajHofh8rH9Ot2J8RXpMNIup/h1fPee7/WRP3vrLQU/xI5O1x4gB1biYNxn9qOZqfGet7htkDR5skyJN4bFXAssDzgC2Xe4wQXO8/Kv0W6hgdpyjJfMzSrsb+WhJhPwqM2YD9J/41IEze1CA23Wd6kyy1v0JS7BVvW8UqfUvMCIKVfmKDAvGJYMmUWsrGGzJT0qxgi7r/YhN/kz/DU+7BCBsMHP/Vv9QZCf4XKBbvrFY1m2Gz7AK6WfiuF+T47Ai5Y/9nrDvwfM+AOY2dMGdYtF2KH3ih9xDvI0ppeSQ06f+s+RL4zURB9TI80fQVe5fVe4e5QsC+s9qS9+zrJbPqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORBRWXR60KeLitV095ZZaonQQxsAfdjtiJLrxLdWIFI=;
 b=tZAuBwnrye9GJwHRN3XwoAcllEgwIdzX+MrhcUJB+nosqORbiyDXey0dWDtFZe36PSk0l1FL9wSBeBRMjRRYiQ4qMEuCw7ZXNlK3RwSt9R9hUrJmD8M/VKFlhoz31cPyeeUC+1ifopjWh5XpGZshjAgA4F+fDAhog/u8ssPwMpC8xfmOdzP2LGMXU6b1CnWDh9ylQDV9wMFyWDvMwzFJc5eO56bzhuAfF/qDFUjWyTsgSa7KglO5F1d6UZpJIBgO28EjL8mXQKxpC3JtYpL2AkXpef1vD1oa2L5eZxPxDgPJslBI08L5jY66mrNu8W7AxF/7UVc48MQ36UCRYAo4+w==
Received: from BN6PR22CA0063.namprd22.prod.outlook.com (2603:10b6:404:ca::25)
 by DM5PR12MB1628.namprd12.prod.outlook.com (2603:10b6:4:7::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.31; Tue, 16 Mar 2021 23:20:02 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::fe) by BN6PR22CA0063.outlook.office365.com
 (2603:10b6:404:ca::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Tue, 16 Mar 2021 23:20:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3955.18 via Frontend Transport; Tue, 16 Mar 2021 23:20:02 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 16 Mar
 2021 23:20:01 +0000
Received: from vdi.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Mar 2021 23:20:00 +0000
From:   Liming Sun <limings@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Khalil Blaiech <kblaiech@nvidia.com>
CC:     Liming Sun <limings@nvidia.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mmc: sdhci-of-dwcmshc: add ACPI support for BlueField-3 SoC
Date:   Tue, 16 Mar 2021 19:19:57 -0400
Message-ID: <1615936797-245197-1-git-send-email-limings@nvidia.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <b62a68d1f8488e7f95befc6723ba5c20d6781628.1615487235.git.limings@nvidia.com>
References: <b62a68d1f8488e7f95befc6723ba5c20d6781628.1615487235.git.limings@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 942f6a75-f928-4e74-b6a9-08d8e8d2067b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1628:
X-Microsoft-Antispam-PRVS: <DM5PR12MB162871B70FE621435592E192D36B9@DM5PR12MB1628.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lSI/f2HQJLgv+wQXwGVCi7YBUgzhZCE9FuH8JCqmF/gIbFyVVhjKav7d2czxshqfOE9IUKQOR1d8fHTeki/N9bhfM13SwlbJrUrvD3v+jkcv7vVu279RLdfVqfobP7yOpIMJbfW7Q7r1RczyNPgfHowqw0V+c8+a0MyGmBGONsjDjqUGo/SmraW/OV7USH/AZE4xSmEM0U0MIKqICDRrjMSDoe1pt47fL/ccJpx5AQFYy4ai3DgwwcdsIUK7pDo7mHwE7I8AwTfTVtPulyRhqJlzjODe+72ALvsss8rc8jmGyhgibicNEZfnv+pRaeChREpd24BOmVaNZsQJfZmjksu1HwefRWCqcr8ngaR6YI/yWLsR7i8z70rCUikJXSUFgUXU3PdT2WfAVlGkGRfsUNjft8ZP7q26hQskKcC4BO0FlgfdVGrFO+V49zCt00LTTE7ePyo33/zcnts/YekE+ADDuQQIgd/0QuXb9MzY/sA7OccY5jyVsTjpoU/yCD57fRz1uZFUyqYYsQJmDsxF6jo4v5jMo9Q3XrqVEqtLRdrG0MUsxy3V1FegmC+dTcdMV3NFKh/V141rjH/VOcQSu7pD+Lq2z6AmWA9YpdZbPo+S1HBqHUuHhVA9ZeBAqj3pD0CqyWRb9xHvcYX7UwbmVJwf8rMUBdYYv+ezuKfMDDiak15ofFDsk+PkxJqYtvBdrlh7TBUGnC5FMW78SH0wdA==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966006)(36840700001)(70206006)(36906005)(8676002)(70586007)(336012)(82740400003)(86362001)(316002)(26005)(36860700001)(7636003)(83380400001)(2616005)(5660300002)(54906003)(6636002)(110136005)(8936002)(36756003)(47076005)(356005)(7696005)(186003)(4326008)(6666004)(34020700004)(82310400003)(2906002)(478600001)(426003)(133343001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 23:20:02.0893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 942f6a75-f928-4e74-b6a9-08d8e8d2067b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1628
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
v1->v2:
   Changes for comments from Adrian Hunter <adrian.hunter@intel.com>:
   - Make changes in sdhci-of-dwcmshc instead.
v1: Initial version which was done in sdhci-acpi.c
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 50 ++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 59d8d96..bf5037a 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -7,6 +7,7 @@
  * Author: Jisheng Zhang <jszhang@kernel.org>
  */
 
+#include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/kernel.h>
@@ -51,6 +52,16 @@ static void dwcmshc_adma_write_desc(struct sdhci_host *host, void **desc,
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
@@ -104,7 +115,7 @@ static void dwcmshc_set_uhs_signaling(struct sdhci_host *host,
 	.set_clock		= sdhci_set_clock,
 	.set_bus_width		= sdhci_set_bus_width,
 	.set_uhs_signaling	= dwcmshc_set_uhs_signaling,
-	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
+	.get_max_clock		= dwcmshc_get_max_clock,
 	.reset			= sdhci_reset,
 	.adma_write_desc	= dwcmshc_adma_write_desc,
 };
@@ -117,6 +128,7 @@ static void dwcmshc_set_uhs_signaling(struct sdhci_host *host,
 
 static int dwcmshc_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_host *host;
 	struct dwcmshc_priv *priv;
@@ -131,7 +143,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	/*
 	 * extra adma table cnt for cross 128M boundary handling.
 	 */
-	extra = DIV_ROUND_UP_ULL(dma_get_required_mask(&pdev->dev), SZ_128M);
+	extra = DIV_ROUND_UP_ULL(dma_get_required_mask(dev), SZ_128M);
 	if (extra > SDHCI_MAX_SEGS)
 		extra = SDHCI_MAX_SEGS;
 	host->adma_table_cnt += extra;
@@ -139,19 +151,21 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	pltfm_host = sdhci_priv(host);
 	priv = sdhci_pltfm_priv(pltfm_host);
 
-	pltfm_host->clk = devm_clk_get(&pdev->dev, "core");
-	if (IS_ERR(pltfm_host->clk)) {
-		err = PTR_ERR(pltfm_host->clk);
-		dev_err(&pdev->dev, "failed to get core clk: %d\n", err);
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
+
+		priv->bus_clk = devm_clk_get(dev, "bus");
+		if (!IS_ERR(priv->bus_clk))
+			clk_prepare_enable(priv->bus_clk);
 	}
-	err = clk_prepare_enable(pltfm_host->clk);
-	if (err)
-		goto free_pltfm;
-
-	priv->bus_clk = devm_clk_get(&pdev->dev, "bus");
-	if (!IS_ERR(priv->bus_clk))
-		clk_prepare_enable(priv->bus_clk);
 
 	err = mmc_of_parse(host->mmc);
 	if (err)
@@ -239,11 +253,19 @@ static int dwcmshc_resume(struct device *dev)
 };
 MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id sdhci_dwcmshc_acpi_ids[] = {
+	{ .id = "MLNXBF30" },
+	{}
+};
+#endif
+
 static struct platform_driver sdhci_dwcmshc_driver = {
 	.driver	= {
 		.name	= "sdhci-dwcmshc",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = sdhci_dwcmshc_dt_ids,
+		.acpi_match_table = ACPI_PTR(sdhci_dwcmshc_acpi_ids),
 		.pm = &dwcmshc_pmops,
 	},
 	.probe	= dwcmshc_probe,
-- 
1.8.3.1

