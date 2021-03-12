Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10483C433DB
	for <linux-mmc@archiver.kernel.org>; Fri, 12 Mar 2021 13:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D086F64FC9
	for <linux-mmc@archiver.kernel.org>; Fri, 12 Mar 2021 13:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhCLNtF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 12 Mar 2021 08:49:05 -0500
Received: from mail-dm6nam11on2067.outbound.protection.outlook.com ([40.107.223.67]:7237
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231439AbhCLNsn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 12 Mar 2021 08:48:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPBw8twNj81JLemJZruEeVoiBW+D4jY44s1S7KOeCvDMY9Vz1qyPy1ZAuDP/44JJjiFLxZrr9wW2Qi+o9ZJvc2qhBLO1YElW7X2RqNiBIIJ8RUDkr9rjQ5rqFC9Q2aBSTBhi58lxoA+u0Gbvtzoh2rmIgj/GaSxhpnvHlqGZadA0YA6ijjAjxUfJLMhofKfe34zMvGJr64eppUmq4BRo5wUl1bnuqlBfo1Q5bEroocilTBjmsSg0QkWtqUCe4LFYt4abjDpaIUkWtYja90BKLvkEBaKlvXh0F4fgi4WHcyF9j7WvIVk/XBBQAQoIybzGpFOag1jqSCPro/U4btEHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oYatm/g86UotSX4XSz8OVbaZjJIAz+3t/+2aJjxz9A=;
 b=VXhivv7hqdB0dmBcc8rMwMW/IrAXAIyWqeHKjOGnH8nDhW0IQeA11+ydSnJruiz3YjWqexpBWiGuJldCacbNCGdTsCLlBzx3NY7UJfbGSr2vzhRANyyAIpW2OjaTUY8OJgOIpc+VaxaY8gf1SHXqKzYchWCTchSKsU9akfVWv0MoH7DDsCsu51Es5j8++D4y01/Q0Cwdt6qzbXjFwT/rv1fLpG+z365QHfeI2Qa8zNqbyxSdtVv0wXDBcJmjhfb2VZYZNjrYK4gFWUivp3XiTZUZoUSnf5ky1rPM3th2cqsgtpDy67V9d3O3uKj0tRUuCDdSwm82zQgnuUpkIvrltg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oYatm/g86UotSX4XSz8OVbaZjJIAz+3t/+2aJjxz9A=;
 b=KTjACfEeq+KKT1N/ATvcj5X5/kgBzVqdKP2CvP9qzy7MSN/tqZBr+gENH5jCqwpzEXou/Ti7NHAHjO0YqmPa9JOREKYj33/1vti9+oZF8k5ZapCc3DUFNSxBwvv5OkyKi+LdAVn2OWd3blLebfM08TTQDY2LGkcveL7U46NMY8SAag/EPy+/fI81Fj2/IvDnEaMdw0YqIsScyaYWt9GdA9uPlkYP3r9FrqVuGKq8TFRdwxjwlqTp+Xtc7ji+frSqzLvPICP6n6YUjfLXh1/2MmLUFcrXiDOIR9rXj5JaHndfZRz1xxP/KDLcBJNJKKt/LTgo/ATLMNhNZ9GF9vHxDA==
Received: from DM6PR18CA0012.namprd18.prod.outlook.com (2603:10b6:5:15b::25)
 by BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Fri, 12 Mar
 2021 13:48:40 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::f) by DM6PR18CA0012.outlook.office365.com
 (2603:10b6:5:15b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 12 Mar 2021 13:48:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3933.31 via Frontend Transport; Fri, 12 Mar 2021 13:48:39 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 12 Mar
 2021 13:48:39 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 12 Mar
 2021 13:48:34 +0000
Received: from vdi.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 12 Mar 2021 13:48:37 +0000
From:   Liming Sun <limings@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Khalil Blaiech <kblaiech@nvidia.com>
CC:     Liming Sun <limings@nvidia.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] mmc: sdhci-acpi: Add support for NVIDIA BlueField-3 SoC
Date:   Fri, 12 Mar 2021 08:48:25 -0500
Message-ID: <b62a68d1f8488e7f95befc6723ba5c20d6781628.1615487235.git.limings@nvidia.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f13125f-939c-4dbc-6579-08d8e55d8b03
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5174FB1B85D9E94A0E2E8E23D36F9@BL1PR12MB5174.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:254;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OCLF5HShpAuJvnVW+E21IRKXTkpFqySQe75xv/Nq+P1231MDJ+CgLV9VfvYXroBoc8CW886MjwLtGxHoqrceQrG+304PfX84TBoTZNCUTqX9XQU0X+YxpGqufZxtIRiJ33BK70+mzgk0B7uPnGYYgdhBB/6azhrnPYgHWSYX5yLVGqSn2Fey5/8+0cbQjFhv2TSxYSf8YB+NUBjjBYSourLUOyolvsIm8eP1Z6dIb/O+EUD/mlzMor1DB3/nbGR/q9IWjvMAMArP3n2XGy3PQefjB+xkRFJfO/O/KH3myMUpoGD3JUat0i5NM+GLcuSXVMJoCZkuSwuqfsMnhw6q3iGFh3kIQS5y6bRQEz+WjNM3H7xi3y3cuTcw2jdelZOZbpUQgF2zkPrTteG69gnQKE96GLyy1ZwaXjePgVIvkqYASDjcrU6xHLlB4/L+dCxGz0NNbo95qgLmXJcPkee5LsOo9fZJUgNLeSqkEYTeLJoRQyE8KiND77rzZ2XTQ35jrNiDmWzJyCEW6UDt/LwgKqoHzO9jGVFZVsiFykU7s6MIzXOvzsGfY6tRSgRvZQAdv37MSea2JNcF0VonGb2FCd/lzJDEjjNrWRWjbeafQ/s9hRosUUtDcXu8k4UU5WHlQDP2ro/k27BmW9N3gCDysAY9X6OURcbHQpfgUPur58oKvMXRQCmU9adSg1wcPri3
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966006)(36840700001)(6636002)(70586007)(70206006)(316002)(54906003)(36906005)(478600001)(26005)(110136005)(8676002)(8936002)(36756003)(336012)(426003)(4326008)(86362001)(5660300002)(186003)(6666004)(2616005)(83380400001)(34020700004)(7696005)(82310400003)(2906002)(36860700001)(7636003)(356005)(82740400003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 13:48:39.6471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f13125f-939c-4dbc-6579-08d8e55d8b03
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5174
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This commit adds ACPI support for the BlueField-3 SoC which uses
the DWC_mshc eMMC controller. The boundary check logic in static
function dwcmshc_adma_write_desc() comes from sdhci-of-dwcmshc.c.

Signed-off-by: Liming Sun <limings@nvidia.com>
Reviewed-by: Khalil Blaiech <kblaiech@nvidia.com>
---
 drivers/mmc/host/sdhci-acpi.c | 64 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 54205e3..6448e94e 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -716,6 +716,68 @@ static int sdhci_acpi_emmc_amd_probe_slot(struct platform_device *pdev,
 	.priv_size	= sizeof(struct amd_sdhci_host),
 };
 
+/* Check DMA address/length boundary. */
+static inline bool dwcmshc_adma_boundary_ok(dma_addr_t addr, int len)
+{
+	return (addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1));
+}
+
+/*
+ * If DMA addr spans 128MB boundary, we split the DMA transfer into two
+ * so that each DMA transfer doesn't exceed the boundary.
+ */
+static void dwcmshc_adma_write_desc(struct sdhci_host *host, void **desc,
+				    dma_addr_t addr, int len, unsigned int cmd)
+{
+	int tmplen, offset;
+
+	if (likely(!len || dwcmshc_adma_boundary_ok(addr, len))) {
+		sdhci_adma_write_desc(host, desc, addr, len, cmd);
+		return;
+	}
+
+	offset = addr & (SZ_128M - 1);
+	tmplen = SZ_128M - offset;
+	sdhci_adma_write_desc(host, desc, addr, tmplen, cmd);
+
+	addr += tmplen;
+	len -= tmplen;
+	sdhci_adma_write_desc(host, desc, addr, len, cmd);
+}
+
+static int sdhci_acpi_emmc_nvda_bf_probe_slot(struct platform_device *pdev,
+					      struct acpi_device *adev)
+{
+	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
+	struct sdhci_host *host = c->host;
+	u32 extra;
+
+	/* Extra adma table cnt for cross 128M boundary handling. */
+	extra = DIV_ROUND_UP_ULL(dma_get_required_mask(&pdev->dev), SZ_128M);
+	extra = min(extra, (u32)SDHCI_MAX_SEGS);
+	host->adma_table_cnt += extra;
+
+	return 0;
+}
+
+static const struct sdhci_ops sdhci_acpi_ops_nvda_bf = {
+	.set_clock		= sdhci_set_clock,
+	.set_bus_width		= sdhci_set_bus_width,
+	.set_uhs_signaling	= sdhci_set_uhs_signaling,
+	.reset			= sdhci_reset,
+	.adma_write_desc	= dwcmshc_adma_write_desc,
+};
+
+static const struct sdhci_acpi_chip sdhci_acpi_chip_nvda_bf = {
+	.ops = &sdhci_acpi_ops_nvda_bf,
+};
+
+static const struct sdhci_acpi_slot sdhci_acpi_slot_nvda_bf_emmc = {
+	.chip		= &sdhci_acpi_chip_nvda_bf,
+	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
+	.probe_slot	= sdhci_acpi_emmc_nvda_bf_probe_slot,
+};
+
 struct sdhci_acpi_uid_slot {
 	const char *hid;
 	const char *uid;
@@ -740,6 +802,7 @@ struct sdhci_acpi_uid_slot {
 	{ "QCOM8051", NULL, &sdhci_acpi_slot_qcom_sd_3v },
 	{ "QCOM8052", NULL, &sdhci_acpi_slot_qcom_sd },
 	{ "AMDI0040", NULL, &sdhci_acpi_slot_amd_emmc },
+	{ "MLNXBF30", NULL, &sdhci_acpi_slot_nvda_bf_emmc },
 	{ },
 };
 
@@ -757,6 +820,7 @@ struct sdhci_acpi_uid_slot {
 	{ "QCOM8051" },
 	{ "QCOM8052" },
 	{ "AMDI0040" },
+	{ "MLNXBF30" },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
-- 
1.8.3.1

