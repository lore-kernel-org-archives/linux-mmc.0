Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CA112D20D;
	Wed, 12 Jun 2024 22:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718232786; cv=fail; b=dTNzU/4TlriMylekBcY5fphg7jNIyd2r8I13mzsB+M/TA/wgaFLTPR5WkgpAM+tZ/F6bIn7jj7rQZjMzEbDPXGnruy76RKt6Yf3tVV6/NCTtLQztatNoHPKjfz1JXnSFvbsKhU3Sj3aLZYzgjPr78iItCqJN5nYNBxf0nZ6unmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718232786; c=relaxed/simple;
	bh=btz/JUpbdOfGUnQUIWutDYhjfKnA6CxAIOkzhKxxQXo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IC+6omuyrja/aLqoilI4oT6qULYQzJ0gwlcbPYD6BT/ix+lF09AuutAFhTogWOiBmIR6ijLd79XBLajrWyuFka9z459AP4tMY9WqVjny42KrSlXp0o3eV6omW4MPaHJCyB0tNCg9qd+1FPHmcb2sFwuhvM4Zb3/ffCyb5x5uTYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q2GqEdvZ; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q2GqEdvZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGhkIymK5Alle8SqNAk5nIDfT7r3RXjDvtMsA3BA/pKmy0ptnNHJ2MqJuTk0+1t5Rvx4df79KIvWgpP6kqmF/ta0/e1/i4STKMxtpb5EhZWw5FFwPqo4BbiaZBsYXUMCTjlkhwzQYkUp9RqGn2/+HgyatOpU1Vlongj0F+K4XlJFcJzs2laYL+pohuiHT5a4h0FB5k3D0xkVHasThciU5yw3gv0OygIab6R0F3D002nTjb0myMlm0EL2gChepX9X8hVXvHsLj9ORhEWVTJHHc4DBwpxZJzRG4+f6N7B4RaBS3U97gjmaa5OVFoUmhv7HWWnkz9xj90MuC6iiF3jV5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uhy8wDQVX6fZ7S2qwRFaBPshLQWogWW7AmXu1Uly0nY=;
 b=ZAZvk4ovtGECQRjOQF5l2g2t7MHVvdYJZinAtXDlQ0TUG/BETO3yDuLT9d5OCqNDqI9LfyfIItSLtJHlU+r6bsf0BVS9U73gdQAjiC5VzA7kvkBXRZNq3ZHRrbS75jJ/f3P+IurX8RmD4snvTUlI2xeDuKm2wOZfjBlRArf2oYo39hj30KM7GqDQ5AEcoLj+lQXLAwvyAarVLH9URwJn95mn25zOryxBa0d1oyYYnAPPmIefUxnzPLuqG7n+s0G76TVXZ2BAxM7R8wL+rt/OzRakPBnYJahcwuGwhgWk23DsA/CeVG/Xdjg9ISlatmEgx+Rrgfcrg+QhIAEnXJo99g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uhy8wDQVX6fZ7S2qwRFaBPshLQWogWW7AmXu1Uly0nY=;
 b=Q2GqEdvZIZatji0Yu530OFnxKhJ9yMa2NZrBGUT66F+FwVoSSW+kUwkeY9MZcHvKn9tZ3jF51ncQcSW23qUAWTF/1F1xX68F7AsZXE4lDD1zR7oiG83Ulg1tRXxssRwDmB5Elqw/UJ3fa+U+7eB4iG5ji5jGpm0Wzh+alHNbs5X3iElGHfc/hx/Wn5rE3Dht8V+cn3iFFzzqDOT4fOiapYxeuv/vF1IygCZcLGmmn2RNix+RUy9+nWWtBc48Jb8XQ1yB2d3xnXQSXcc1U0N5eYYTlWV7wvnCbUJ+GhZxficJBJeJm1YdGmd9vGRfhZpDwqcexAj6Mj/G1hi1EC7yoA==
Received: from PH8PR21CA0004.namprd21.prod.outlook.com (2603:10b6:510:2ce::11)
 by SA1PR12MB7248.namprd12.prod.outlook.com (2603:10b6:806:2be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 22:53:00 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::96) by PH8PR21CA0004.outlook.office365.com
 (2603:10b6:510:2ce::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.15 via Frontend
 Transport; Wed, 12 Jun 2024 22:52:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 22:52:59 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Jun
 2024 15:52:49 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 12 Jun 2024 15:52:49 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 12 Jun 2024 15:52:48 -0700
From: Liming Sun <limings@nvidia.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, David Thompson <davthompson@nvidia.com>
CC: Liming Sun <limings@nvidia.com>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/2] dw_mmc: support platform specific hw_reset()
Date: Wed, 12 Jun 2024 18:52:37 -0400
Message-ID: <3df02ffa8bdaa74f5261c8914d2545b97fb3478a.1718213918.git.limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1718213918.git.limings@nvidia.com>
References: <cover.1718213918.git.limings@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|SA1PR12MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 882d289d-c8e6-4a12-7b4b-08dc8b326897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|376008|1800799018|82310400020|36860700007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4/AMhA9zC/tr3AC/zPb/YsIMMhiE8REM7SKlL+s03zyN/5PGCLJrK2u7pn6o?=
 =?us-ascii?Q?Y1VKKM7EO95AtJD+e0EFZiWpknT762AjnsuCzPFt5mEqeJcWkOxqt/t7Gzmk?=
 =?us-ascii?Q?tlTsdF6Uo4bmXHuOSemPYB4riFhVzlddCrvwD3E4YbBrQ/LazN3AiuvCNs80?=
 =?us-ascii?Q?NId+FZzfH2wDzb1qRSUmnIlRLYgO0mvXMtwI/WxE0p74RP+9sRJ/dHGUuMRF?=
 =?us-ascii?Q?IINe+mmYcwOcS7didciwXzvZcyTZnqNpDzGHcGhN2aBlc7nzKyRjIdyTQXSv?=
 =?us-ascii?Q?pEt9wWRxsDqlZMp8zTaI0s/eXmsL5eYzYobrUdqCLbntwfU73bWT8d8oQbpM?=
 =?us-ascii?Q?qAHdNWGrobZd3nc80A654RCYcQMFJvo8iflYVnobYnfuSc/zOj8cyvHmTmIQ?=
 =?us-ascii?Q?eK5WHIasnnctQw09onjOdP3/SGhtAnivzcWqaWxzKaW1x1kRca19jUKh/UoL?=
 =?us-ascii?Q?I4Za7/jB28cKoD/te1EgAdmIrEwMP6zCIhaPeICmvh1JnDGUnhUDqO7wbyTE?=
 =?us-ascii?Q?hDzj+tLpl2lykF0hZUwkGFtYb4l+NUhPCx2/DkvBBZSJWTaqsaw6e6FNwT3/?=
 =?us-ascii?Q?nRsCW0pBbSXFxmJg68whCU2+TXjjRC+oMGO7Bd20kmHSjLxAL5MckZprpleO?=
 =?us-ascii?Q?x9qoyKlxCYGj75ejvkFZCI/eQ6R9JQciopHXU69HdNiJ+9iMMWlGjWPZmUha?=
 =?us-ascii?Q?n+WZn4VkG5pCTB4DrKVxvydEhswWjODeThuUHSBim3oCPl9S1CIofaYcL+ZS?=
 =?us-ascii?Q?BPPXLlWLeGrQgJCr5sDb4z5zKkLvSlFtwxIB0bykJpU6vtjn3kjx+g9C4slJ?=
 =?us-ascii?Q?DEJ48dkrgMvSK9YjzBgVqrxdK2Q4hp1TOlrOKFUgpANEJbzVRdXSLWHNR0sD?=
 =?us-ascii?Q?EVYtlH1/OiLe4OTFhtGuYZLPBSYTxs1EdGaAn0p7YoegQ2q0ipBwyIuISll+?=
 =?us-ascii?Q?pyKu8yJdJsoBAEsgObaq30FemAm1gMKjCdDjsr6uVc9ZqUPLkzCX6qx3L9oR?=
 =?us-ascii?Q?WfhxRf2H+pFWs7aDRexBRTaouQpjxJhNQ2OhyHZKeiEJCsdOkyQ9fFttZFCp?=
 =?us-ascii?Q?+1khyMh7kLkPiV+SDS5HHXcJ4iIDkIDa+z+dTWdgYo9Z4v8sGum7zbgePzfy?=
 =?us-ascii?Q?uUTZ2VMi7ZteOxAE5Q49dIoYVbGIqjcpa63ekKG6v9W74Re9BpGZCOJYlCLx?=
 =?us-ascii?Q?E/42Ane3OKWfoJZuSvb0Vfh5BA8ddrLdvCNS6p6nua8XHVuFCDDG8mjaAvwj?=
 =?us-ascii?Q?GMv5YNWd6m3VV0rT14+VShUNGxmWp1qxlb1omu5bW+6j2wSq3Ieyrw1SuRrw?=
 =?us-ascii?Q?QR/n9731SjKyuxpd/yPOti+xKVgtyr1rs/2h/v54ZpJE3+XngWZIxfLd5G2v?=
 =?us-ascii?Q?aVeuphTniajB+ui+rgb2PuIvJwxTWfVEjbQI7b2mpTfV7/nm0Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230034)(376008)(1800799018)(82310400020)(36860700007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 22:52:59.7588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 882d289d-c8e6-4a12-7b4b-08dc8b326897
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7248

This commit enhances the dw_mmc driver to support platform specific
hw_reset().

Reviewed-by: David Thompson <davthompson@nvidia.com>
Signed-off-by: Liming Sun <limings@nvidia.com>
---
 drivers/mmc/host/dw_mmc.c | 6 ++++++
 drivers/mmc/host/dw_mmc.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 8e2d676b9239..2d72da03fdfd 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1617,6 +1617,7 @@ static void dw_mci_hw_reset(struct mmc_host *mmc)
 {
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct dw_mci *host = slot->host;
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	int reset;
 
 	if (host->use_dma == TRANS_MODE_IDMAC)
@@ -1626,6 +1627,11 @@ static void dw_mci_hw_reset(struct mmc_host *mmc)
 				     SDMMC_CTRL_FIFO_RESET))
 		return;
 
+	if (drv_data && drv_data->hw_reset) {
+		drv_data->hw_reset(host);
+		return;
+	}
+
 	/*
 	 * According to eMMC spec, card reset procedure:
 	 * tRstW >= 1us:   RST_n pulse width
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 4ed81f94f7ca..1b86531a485c 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -565,6 +565,7 @@ struct dw_mci_slot {
  * @execute_tuning: implementation specific tuning procedure.
  * @set_data_timeout: implementation specific timeout.
  * @get_drto_clks: implementation specific cycle count for data read timeout.
+ * @hw_reset: implementation specific HW reset.
  *
  * Provide controller implementation specific extensions. The usage of this
  * data structure is fully optional and usage of each member in this structure
@@ -585,5 +586,6 @@ struct dw_mci_drv_data {
 	void		(*set_data_timeout)(struct dw_mci *host,
 					  unsigned int timeout_ns);
 	u32		(*get_drto_clks)(struct dw_mci *host);
+	void		(*hw_reset)(struct dw_mci *host);
 };
 #endif /* _DW_MMC_H_ */
-- 
2.30.1

