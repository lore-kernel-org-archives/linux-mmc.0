Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E473C433ED
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Apr 2021 09:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5299561363
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Apr 2021 09:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350258AbhDGJrE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Apr 2021 05:47:04 -0400
Received: from mail-co1nam11on2087.outbound.protection.outlook.com ([40.107.220.87]:17633
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350270AbhDGJrC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 7 Apr 2021 05:47:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjkF3Ced5rg8TBPdHAtKFlV0Km0UULmmT3TEq7U2+UE3BhPOygB5D65/0drN3OeKnRPFZUJItwTH8sWPsQ+2k1gHWqn8aFQZuK5RVw64neiD0bVIq14Mkwxd01sdqPs8mpTpMSYnS4NBKfS8XQ2axfhGOAycFMc7bOR+OwqZXcP7Kif4mQ1WdM+Ty9asisMC9ZUDGHVPahlIyslpM0jVXg3b07U78H2EUjoxt+EpmZ370noV1IC9RPb/VPk+2xuDyyvvXvkK9XA1ufxbLVfbSdFifzs4JX6UwCP70Pxq0xT0oONbi1rZ6zXaVbI9ScVF+2B78En7t79iGuyUAmnHkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YD+Gf6/1N9jseRlIgLbMCL/tPnja4F9c9bL8EBsJVXs=;
 b=Yq9eHSsdN1Ar6R+OM0kHgY7eYrvk3agGwD0lVCo/TMXAsTInnARjrFtHRSxf1e/BznnqrzrMkZt/pTKo57fayJmt1sQB8n01CO6dcS1XgSN5pG8THdgrUfi3Jl0S+KDu2bwdpMHlBqhYV0l2jcKQ9eME6oi7uZJ2O0zAmHg36dIJK2TU2li/T1zh/ScyjBBjk/5QsiJVcIjNDzK8YvoCEYPde6wFjWsqOYy0CiwsQOnlRJ7h1IM/0VSGOnsGXipB7CGYA9aS32JV7a4q+HsyYQX+z/tTqXGWgsKjs2Crpt3oQFCLGPQxfTi1m4hScG6tUdZdZCONu90gHzqxCqlFxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YD+Gf6/1N9jseRlIgLbMCL/tPnja4F9c9bL8EBsJVXs=;
 b=CwXK8HrCxdfDIi+UI++MRGdO8f/ZcmAnyA3mLSOFToH56If6UWK+YpFUnqxt4de0Zz2JsliCcSz3kcMTGYGLBRW6E+coTOSFbWIN3eGUvRjMKkcciVtjBHqLU4/YhpneUYDwMIbijmZ3GppP5D0JhoYjIza4yBpgqZs7CP1K9F8Jd7oHEG0so1FVkEK9gGu1YDrhAdsqIqt0HDow3WSdOg2zW45AZRyGk8ngJM/PlyWdcE/teT/Vb1OCFyjTbxNPuBV8To+pxrnwXKfeS0V7XKqpouy4WNsem+jJS3Ozx0QYPNq4Z4OUI35mfDuli5iA4r6ix6CXyhvQgSg/YbpnyQ==
Received: from DM6PR18CA0028.namprd18.prod.outlook.com (2603:10b6:5:15b::41)
 by DM6PR12MB2666.namprd12.prod.outlook.com (2603:10b6:5:4d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Wed, 7 Apr
 2021 09:46:52 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::38) by DM6PR18CA0028.outlook.office365.com
 (2603:10b6:5:15b::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Wed, 7 Apr 2021 09:46:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3999.28 via Frontend Transport; Wed, 7 Apr 2021 09:46:52 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 7 Apr
 2021 09:46:51 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 7 Apr
 2021 09:46:51 +0000
Received: from moonraker.home (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 7 Apr 2021 09:46:49 +0000
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        "Aniruddha Tvs Rao" <anrao@nvidia.com>,
        Kamal Mostafa <kamal@canonical.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] mmc: sdhci-tegra: Add required callbacks to set/clear CQE_EN bit
Date:   Wed, 7 Apr 2021 10:46:17 +0100
Message-ID: <20210407094617.770495-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e0adbed-ab71-4b5e-bf1f-08d8f9aa128a
X-MS-TrafficTypeDiagnostic: DM6PR12MB2666:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2666CB6010CE6961452C90B2D9759@DM6PR12MB2666.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ad6DVqQdP42DP3Mmhluv82nwLKIH9PKj+wx9KUTQYDe2HYuvH3TejDtjYWXV7kG8EHeh68JGbdPMnOJchJVhtkJovJm5rE9AAnVSWgoHZ2XEaATKa8PAA1qt9xWH5HGC7lTHtptGdG4UyncEBDH0WvzYozI8qRCmHXXXA5Qvj7C/84mOzXgEggdblVpCR/h1J+Db53pCiJZwgfuv3esvDN/DGvIhde7M75K+wsByTcKiWNKANQLOYEhN7S/ztJsKJDnQ7m3JlTeIYQJraK/fLqBsx8zO2vKMTFoOEnp3vvYr6vhfxBrknq6WuPPZUxjR7pS5XvbAIQeE98MwowexeK8s09hLV5YuS4cPG0Zf7aJlrw6cRcwivLGAwhOaWIqmEFmwabzfPlAT7kmuVOQht04YZFsn4ZWFzn7kO8l8pPGtk8M3g6z6BLXkdWl5Y//C7bJVNw0tiPoVXjRcg2hxk2ON9NPt4JJ7lkmSnRT3vUNiJjTUnULcIB3mVYB0ToDvW4fjDdTYonI/GVrww3bzRmchQPTC6agXW8n/zuWbymg2y26AjKqfQGzdtHP2Eoj+5XWl5w+R90NvX03BBNK0cniegkJ75cKzgAHcLLIAbvEmf67FrrxJNxYKnKImlKCc77ddjeKfrw5iA0Z9JxcnuzTbv2xeNbibFH2zEdjVa9I=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966006)(36840700001)(36860700001)(186003)(478600001)(4326008)(107886003)(70206006)(70586007)(7636003)(8936002)(83380400001)(36756003)(8676002)(1076003)(2616005)(6666004)(36906005)(110136005)(426003)(86362001)(47076005)(2906002)(82740400003)(26005)(82310400003)(336012)(316002)(5660300002)(54906003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 09:46:52.2625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0adbed-ab71-4b5e-bf1f-08d8f9aa128a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2666
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Aniruddha Tvs Rao <anrao@nvidia.com>

CMD8 is not supported with Command Queue Enabled. Add required callback
to clear CQE_EN and CQE_INTR fields in the host controller register
before sending CMD8. Add corresponding callback in the CQHCI resume path
to re-enable CQE_EN and CQE_INTR fields.

Reported-by: Kamal Mostafa <kamal@canonical.com>
Tested-by: Kamal Mostafa <kamal@canonical.com>
Signed-off-by: Aniruddha Tvs Rao <anrao@nvidia.com>
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index c61f797a853f..387ce9cdbd7c 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -119,6 +119,10 @@
 /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
 #define SDHCI_TEGRA_CQE_BASE_ADDR			0xF000
 
+#define SDHCI_TEGRA_CQE_TRNS_MODE	(SDHCI_TRNS_MULTI | \
+					 SDHCI_TRNS_BLK_CNT_EN | \
+					 SDHCI_TRNS_DMA)
+
 struct sdhci_tegra_soc_data {
 	const struct sdhci_pltfm_data *pdata;
 	u64 dma_mask;
@@ -1156,6 +1160,7 @@ static void tegra_sdhci_voltage_switch(struct sdhci_host *host)
 static void tegra_cqhci_writel(struct cqhci_host *cq_host, u32 val, int reg)
 {
 	struct mmc_host *mmc = cq_host->mmc;
+	struct sdhci_host *host = mmc_priv(mmc);
 	u8 ctrl;
 	ktime_t timeout;
 	bool timed_out;
@@ -1170,6 +1175,7 @@ static void tegra_cqhci_writel(struct cqhci_host *cq_host, u32 val, int reg)
 	 */
 	if (reg == CQHCI_CTL && !(val & CQHCI_HALT) &&
 	    cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT) {
+		sdhci_writew(host, SDHCI_TEGRA_CQE_TRNS_MODE, SDHCI_TRANSFER_MODE);
 		sdhci_cqe_enable(mmc);
 		writel(val, cq_host->mmio + reg);
 		timeout = ktime_add_us(ktime_get(), 50);
@@ -1205,6 +1211,7 @@ static void sdhci_tegra_update_dcmd_desc(struct mmc_host *mmc,
 static void sdhci_tegra_cqe_enable(struct mmc_host *mmc)
 {
 	struct cqhci_host *cq_host = mmc->cqe_private;
+	struct sdhci_host *host = mmc_priv(mmc);
 	u32 val;
 
 	/*
@@ -1218,6 +1225,7 @@ static void sdhci_tegra_cqe_enable(struct mmc_host *mmc)
 		if (val & CQHCI_ENABLE)
 			cqhci_writel(cq_host, (val & ~CQHCI_ENABLE),
 				     CQHCI_CFG);
+		sdhci_writew(host, SDHCI_TEGRA_CQE_TRNS_MODE, SDHCI_TRANSFER_MODE);
 		sdhci_cqe_enable(mmc);
 		if (val & CQHCI_ENABLE)
 			cqhci_writel(cq_host, val, CQHCI_CFG);
@@ -1281,12 +1289,36 @@ static void tegra_sdhci_set_timeout(struct sdhci_host *host,
 	__sdhci_set_timeout(host, cmd);
 }
 
+static void sdhci_tegra_cqe_pre_enable(struct mmc_host *mmc)
+{
+	struct cqhci_host *cq_host = mmc->cqe_private;
+	u32 reg;
+
+	reg = cqhci_readl(cq_host, CQHCI_CFG);
+	reg |= CQHCI_ENABLE;
+	cqhci_writel(cq_host, reg, CQHCI_CFG);
+}
+
+static void sdhci_tegra_cqe_post_disable(struct mmc_host *mmc)
+{
+	struct cqhci_host *cq_host = mmc->cqe_private;
+	struct sdhci_host *host = mmc_priv(mmc);
+	u32 reg;
+
+	reg = cqhci_readl(cq_host, CQHCI_CFG);
+	reg &= ~CQHCI_ENABLE;
+	cqhci_writel(cq_host, reg, CQHCI_CFG);
+	sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
+}
+
 static const struct cqhci_host_ops sdhci_tegra_cqhci_ops = {
 	.write_l    = tegra_cqhci_writel,
 	.enable	= sdhci_tegra_cqe_enable,
 	.disable = sdhci_cqe_disable,
 	.dumpregs = sdhci_tegra_dumpregs,
 	.update_dcmd_desc = sdhci_tegra_update_dcmd_desc,
+	.pre_enable = sdhci_tegra_cqe_pre_enable,
+	.post_disable = sdhci_tegra_cqe_post_disable,
 };
 
 static int tegra_sdhci_set_dma_mask(struct sdhci_host *host)
-- 
2.25.1

