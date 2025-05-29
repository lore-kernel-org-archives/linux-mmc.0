Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE09F28DEE2;
	Thu, 29 May 2025 10:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748515749; cv=fail; b=sAuM9gRpKrpp+g3G2Qg0gqXf0W5aHG23sNfAnY26osoFadJBGDZmEmCN2dupZouhRXdCS4mhCM0B/+YSoyXXrj49P+6QU6x6BiEd7hhFxJwWw4AG2KkdHbwYLWLX4a6YU6tZguVyxcHN4bKRSVxf5Z5J/lXyeKXtRALx27K5XLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748515749; c=relaxed/simple;
	bh=15y8xPab6+PaKvNagfe/WDj6SgwH955IUhcw+jjpFCQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VkPlIfO7aoKFR9KYJv0i8huqGO0hWz9Z5c+ukCDfyqel4ilN1TJCjyhSsxxokBij5/mK5PPagpliAKf8XKCqbscEtoZkijFiHT/JsbvNo7qdYi+zJ4oQbCL8fDHkbf7Jm/lkhdhmUZ7tewXRPybk79ExcEB/9xawWCkaITNoETU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HgR2A9yw; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HgR2A9yw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+aaESt9jGlgO/aQam/RvVfG2Em1vdvka1ouYaWhwMOLOtQ+AjwCxckKaxIRucOCR32Mv9YCie73V2YoIBENrq0t9TV9w+gs/de7PT07tjM7H0AKDReJW32Qh1xgQF6IGKtlibRFKGbuWuG4AkxmVyEPAIZrWJgF+IGwbHtwZnCrltDmkPJrjg0xBRNCaNRdCscZtCncdfSu3B5f1BmMCXXnl+CqQkoCoawS1EQEM+dJTIdAq+ZLBNH74+vLj05JDfDaCQEa85OQlcuUsuEQNPU259I0ynk/Hi3KLf3dN6JN8/g+HyQGH+sO6595YKwVG0IIhBNLSMsJOqkhpeBnvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dxk32XT30AdQKw6UduYwujbUwqlCcLMbGl622/eV9dc=;
 b=X3OTukt8yylwilpuxVDL5SrH6o+p5Xu46D/klWTMqS2BYmZPXHCLVwjWJHVe7olS5xskTCQE2F9tqfqKrMwq1TYwDTV19UQkpnV3GITTrtfvNcT47tNlTur1AlrkrFNNFujEgGPnOFxfwLJQWJdNy3g7Qb4flk3SH2PwdCOiOLUoc2EULrHNtsO8kJbjatV1W2v91fcoaDDLdDmXin/nILrqYOmS1xsLGBMspKCRuJMjdUN1Qal+I0ogqJaEIPHMcaTH8ivOJBgtIBj0SQCNs7AoAqcj6h1huy7G3rtTg7MaAlw/40g2QjxCYB5FKOBeX8Jio9pfIrx8C9g6W+kUyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dxk32XT30AdQKw6UduYwujbUwqlCcLMbGl622/eV9dc=;
 b=HgR2A9yw71/ZfF0eETpLSlc96UaKbGdD8FdC+yMCUnE8qA82q/qz73nKTiafSg39504pQ+vr+87YSrxkLyEEbDWo0x+7RxVv/Q8pYjE8fO8ktbIiXNFudfYhwGIh1Lcu8UqUlgVVsvOU8/2z8glZWUEuvV1f1tBnUu/gKR7loYk=
Received: from MW4P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::22)
 by SJ1PR12MB6027.namprd12.prod.outlook.com (2603:10b6:a03:48a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Thu, 29 May
 2025 10:49:05 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:303:8b:cafe::70) by MW4P221CA0017.outlook.office365.com
 (2603:10b6:303:8b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 29 May 2025 10:49:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 10:49:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 05:49:02 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 05:49:01 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 29 May 2025 05:48:59 -0500
From: Paul Alvin <alvin.paulp@amd.com>
To: <michal.simek@amd.com>, <adrian.hunter@intel.com>,
	<ulf.hansson@linaro.org>
CC: <git@amd.com>, <alvin.paulp@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mmc: sdhci-of-arasan: Add shutdown callback
Date: Thu, 29 May 2025 16:18:53 +0530
Message-ID: <20250529104853.1987456-1-alvin.paulp@amd.com>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alvin.paulp@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|SJ1PR12MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: 450e0de8-8851-4431-3558-08dd9e9e6e78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qqFOLf/Ie6XndznW4ERRij5J1ESdM5Gd2YB4J4j0pZS12PUEvTTJZ1pNhkGZ?=
 =?us-ascii?Q?k93tpCiXseoysNUmQydkSgC0Ezplv/EAb/Ragh/X3cezIVyAuD7+1GXQdqcY?=
 =?us-ascii?Q?HwQlFBtDxnhMdDMwO29pFXSBD1KTv/oToR4TN+ikexpiL22Z8FrwPx3U+MQl?=
 =?us-ascii?Q?0q9hZ3PDXmpCiEQ6jEc1KjdId3z9m9wlEkoeIGOsySlyEWpAJGT2a1rXqaZv?=
 =?us-ascii?Q?YrFWieFn5y5ZHvy3ei70tTsmxATu8NZZPini7Ai7Ob04isJ/A0N3QT5TyuLa?=
 =?us-ascii?Q?On5RYGUn7m3rMb3vMqhsGYjuwgoX0+5397UojUqtbVyoc4uUV54E4SKacQm7?=
 =?us-ascii?Q?0O69GVIDSAB0+eSn9U8k9RxqMuVjBWgycBUFK5FMk8wvkq7eyNAwgVByw7Jn?=
 =?us-ascii?Q?BfTc3OIhITXTGZ1+JW3984i9pslKpSNq8PkFMxJAl8zuPpneRM2lXEfABnE9?=
 =?us-ascii?Q?nG5UuZUVI/9GmZmXPnguyoPi+jTeyKI1cHkNpGIdZlN2i7lGTfGkHxxSsRHU?=
 =?us-ascii?Q?W8qOXk7aPsUzMp03jZj42aV8z6Qgr9jYGEtzPBJBMeSRADvM81QSTU1aNg2N?=
 =?us-ascii?Q?Eq1woW63EBOGQ0EnWXkMQuBlh0rbAnZuJ6wAyHImNGYpn+YOV0kv3Erz4K+3?=
 =?us-ascii?Q?XiSIpLR2OIWuPfIKkaTTeEWHBJ/keJPepprU23/yNy9lyRLW4MB0kn8e1oKT?=
 =?us-ascii?Q?9Pr5jani4pM7OaObonrPedz+cdiZeFJ99+1clDyGqPc0jfJlCl/jkzoUBMfB?=
 =?us-ascii?Q?KstUOBGJ9ECaJWX6DadEciZhf4VxEfOv0QtVVzJGfHluLwmMK4BgZT/KjsGE?=
 =?us-ascii?Q?/pywx0CanbxIcT3PsmtZ/5CQCREhr0K0QT4Yp8/09icRPRSW5xWy9KapCffZ?=
 =?us-ascii?Q?Kj+LZLgHNyCNXn5zAJ85GTPfuioXgtNALUdISI7zKuQX8fwK2S1He4GcutWY?=
 =?us-ascii?Q?aur2F1g/iwWgJ+UNJ0XRENiHWCTYw/4/7IArOiIs3W5/GBQZBDELaehZT/Jk?=
 =?us-ascii?Q?fpAeIcdV6W6oMGR5MmHbt26asnvWwJbmIGovUOSm/jBCXxRnbLdyAQpjdASm?=
 =?us-ascii?Q?efYPZpnI2K3shO66YlsKJJsMCex4oG93Rv/DQrvn1Mn33bX4HDE3d7yXE9t5?=
 =?us-ascii?Q?cy51oDKHFjPY4wPVTn/mIdU99llB4kHteXVlB0iTUI8im3xpvOblnKL8CRkO?=
 =?us-ascii?Q?1GlnMdGwSv5S8yBU7rfw4vjXsUzqEV+IqYSO9Mrp1AOLmPonQZDrCQUB50g5?=
 =?us-ascii?Q?ejts9PErnfE3TzOf+KCHfsaBh84P6pwAM2JShwA2D52fm0XPyDRVLGEY/f8Y?=
 =?us-ascii?Q?UekgsbTdIIlmwepAmsTpTWGblA1PGLM0ran6cLDEy5x7J+x6Qixp8Kbvjh49?=
 =?us-ascii?Q?dCyI/eSgH3J0APhao4eJsz0mgdfpLkKyx4da46ktaoXhkVmlfCO2hdc9Tb6/?=
 =?us-ascii?Q?Wi2vvwD9XxldQHW6uaWJJbJLbGpp3bkniLCzlqsIdaDT3EIjWny78sdH0OI6?=
 =?us-ascii?Q?AcMdaWVVAaOlqV0IsH6cnxAHpQZRzt9ukwzx?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 10:49:05.0575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 450e0de8-8851-4431-3558-08dd9e9e6e78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6027

Implement shutdown hook to suspend host and disable all mmc clocks to
increase power saving during shutdown or reboot.

Signed-off-by: Paul Alvin <alvin.paulp@amd.com>
---

Changes in v2:
- Make use of platform suspend instead of driver suspend as driver
  suspend will only get defined if PMC_SLEEP is configured which 
  results in build failure if it is not configured.
- Updated commit description.

 drivers/mmc/host/sdhci-of-arasan.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 8c29676ab662..4abdad3c4e5b 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -2056,6 +2056,11 @@ static void sdhci_arasan_remove(struct platform_device *pdev)
 	clk_disable_unprepare(clk_ahb);
 }
 
+static void sdhci_arasan_shutdown(struct platform_device *pdev)
+{
+	sdhci_pltfm_suspend(&pdev->dev);
+}
+
 static struct platform_driver sdhci_arasan_driver = {
 	.driver = {
 		.name = "sdhci-arasan",
@@ -2065,6 +2070,7 @@ static struct platform_driver sdhci_arasan_driver = {
 	},
 	.probe = sdhci_arasan_probe,
 	.remove = sdhci_arasan_remove,
+	.shutdown = sdhci_arasan_shutdown,
 };
 
 module_platform_driver(sdhci_arasan_driver);
-- 
2.44.1

