Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813F2C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 11:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EE5A61C15
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 11:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhKOLle (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Nov 2021 06:41:34 -0500
Received: from mail-bn8nam11on2046.outbound.protection.outlook.com ([40.107.236.46]:5600
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231446AbhKOLlR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 15 Nov 2021 06:41:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwjiCiWms6tjftV91voXEfQsfnQNGzRz55xImIV3vVmzd7TW8+8EZTgl+sbUIUAoMdA5F42keuzXo4PcQfu0HdYO5XY6jXhfENcd7B7pt6FDb/Cr+Y1++ouQQAj5Xf0LRxFbtyUlekYGF+H3lGcJeXbg+foIH3hvkYe4dG0/WezQvsS5hIXdqwziXeF8fEctgz00YuiULwfaPclpjidJlQwbxMl+nGE4+H3MU5lmfxVbN1cNfthxvtYborK0DK1TjTynMjMzG9uv3EemWeCuoNYHhAZ2iarNpuPGUrQ10uf/q0PyvIqzzaPcO2DdIwoiTpicoM+tdDdqVL8HhP7rLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwrbW74UwKck9sI1uHrSSNjkbGXi7+pmPQga1NBI5Yw=;
 b=WE1S1vJR56RKsOi8f9FZq9pmtERibVvf9pR8E9sd1F0TDkLwH/La9x4qwPnIIgmLWIjLnCeBPRb1IZrQZHc8Lrq4Mg1JksfBaFT/kEELShMlLYmeUT/lsIRc2UPIxkg9AST7GSDhTBFEvr10X+n+pHUkr+rTRzztohxMRLkWCbn7viS7HacJgrsQcBzqJAlEUqlIBngcn7zM5GAf16oBR3UPVzrhuU8n2aK8RWLMPZomoIoRf7TKqSC6aR0cfCMfI7QsIlMnMk0xF8MoO6odv5GPD2vakWvKMuqMQv1/4tAghAuWinMDzNmEC3iyE2c8f50pDE2W7YhcrhVzwJCX2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwrbW74UwKck9sI1uHrSSNjkbGXi7+pmPQga1NBI5Yw=;
 b=LFmsPbFHafFmAfgCl1+qbDz1KsBrwaPtTPXunCfL6Ihih7QgP7UZc+RwqIk1sofFRvNIOmLuF5nE49f4aVe0TxXMJGU87gj/N9zoU1d6hf+FTUDCfyRKJcJ+BvNigGvuAybY6L91mWWOe8WP1DhJ+kHnjSOFiH8Js5ElTlQl6IXPK6WkCqyY6H0CI7blazh/Rt20DAw/PWM2+2IPKjqA+cw12paATsA22T1yIpLmTETauA0oLaNQbKb2gYRRB3BU/9UOleSTwXU67MZzc/+ltDIhAlNfvv+xxAThbCR7OOJNShbbaQVA9UNaOuuBdHSs2P4jPwZNQ15c1lU+FVxHeg==
Received: from DS7PR03CA0138.namprd03.prod.outlook.com (2603:10b6:5:3b4::23)
 by DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25; Mon, 15 Nov
 2021 11:38:18 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::24) by DS7PR03CA0138.outlook.office365.com
 (2603:10b6:5:3b4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend
 Transport; Mon, 15 Nov 2021 11:38:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4690.15 via Frontend Transport; Mon, 15 Nov 2021 11:38:17 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 15 Nov
 2021 03:38:17 -0800
Received: from moonraker.home (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 15 Nov 2021 11:38:15 +0000
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] mmc: spi: Add device-tree SPI IDs
Date:   Mon, 15 Nov 2021 11:38:13 +0000
Message-ID: <20211115113813.238044-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19e35c55-f950-48dd-c527-08d9a82c6b0e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4090:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4090E82CF623D3E3891F17EAD9989@DM6PR12MB4090.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TYvTSU3C+03cxCFo5rDywW++aoNQcI+JzO9anP6uhYd+j8GAAV4047lPnnI7IhRdOT74qPg1gjfGc9ZeNC/AW4ksMexUwuPy56UYHqE/Lw1ryoDuHtSI9/TbUDRvVgWAqTW2AMIvUxi/sEw0q7NaqyD86eRw3rMOyyAgMjwWWJn4HRWPN5iXkWnhvg+60+6VwtHYdspSkDlzLPMCWolt9LFoRnVLmypyF6wkbxUjA8ssQMxnloZrRD5TbAEQ/oc715A+NmVdR7Af6n0K2Pwxhj7LZvEC92RX8vd+DVuH5wR3AEVbvSio8s4cxbK5DEfj5OoimlgxyTPGSBQFSNx3odC79oBSywEO2e9bny6hZe4dwQZW58TK0huaDBtqaDpbsv0cxG7rwm8ygr/98i3vrrlNvdXFRa7V3LrSKndbdanws9c3MCs2vAcFxiDdE7Uc1PW3szZIAp7TG+ysAe8dMlbxWFTrJ9gXGVqfJfwG3IhtAZqrYwNjOfsVslGUDVe2yzzfqax85brlpogmvXSXibvv0zfQBaLuPj0WOCPtWyNme86wCXIgl+UFyKf35h3/CBuuek5nUToh9L6Qx9AxfPlWQlJlNFdYQ8PHD2DSrrA+ezMr+4VAmtNz++XBKdZeOlIg3kihIlB84U/kx2500fqWKkSvWQMWktM6HkBpNPOY9gkUCWMtrircfuSQhHGNjAzDyE3SL8eNFFZTIJ1hXw==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(83380400001)(82310400003)(316002)(186003)(508600001)(4326008)(54906003)(70586007)(8676002)(36756003)(6916009)(2906002)(26005)(426003)(70206006)(1076003)(47076005)(336012)(2616005)(356005)(107886003)(36860700001)(7636003)(8936002)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 11:38:17.5764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e35c55-f950-48dd-c527-08d9a82c6b0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Commit 5fa6863ba692 ("spi: Check we have a spi_device_id for each DT
compatible") added a test to check that every SPI driver has a
spi_device_id for each DT compatiable string defined by the driver
and warns if the spi_device_id is missing. The spi_device_id is
missing for the MMC SPI driver and the following warning is now seen.

 WARNING KERN SPI driver mmc_spi has no spi_device_id for mmc-spi-slot

Fix this by adding the necessary spi_device_id.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/mmc/host/mmc_spi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index f4c8e1a61f53..b431cdd27353 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1514,6 +1514,12 @@ static int mmc_spi_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct spi_device_id mmc_spi_dev_ids[] = {
+	{ "mmc-spi-slot"},
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, mmc_spi_dev_ids);
+
 static const struct of_device_id mmc_spi_of_match_table[] = {
 	{ .compatible = "mmc-spi-slot", },
 	{},
@@ -1525,6 +1531,7 @@ static struct spi_driver mmc_spi_driver = {
 		.name =		"mmc_spi",
 		.of_match_table = mmc_spi_of_match_table,
 	},
+	.id_table =	mmc_spi_dev_ids,
 	.probe =	mmc_spi_probe,
 	.remove =	mmc_spi_remove,
 };
-- 
2.25.1

