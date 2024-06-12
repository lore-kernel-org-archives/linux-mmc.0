Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2995712C819;
	Wed, 12 Jun 2024 22:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718232792; cv=fail; b=U7ChgTKv2K4l1CbzDMQ5FCTxszQ0Bf9UjkOuov842XVpNBgKYlGoBdQr/N1rsGvrXdHFzWwgooBG/MLFvRPmYVUiGv7fOwc/MycbRu6kEMxJ179qSFU7pPxGSojrEOXbQXuYCgCKN9xkRqWQft/K4mj5WKdq8GxCyXHUqqK6E0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718232792; c=relaxed/simple;
	bh=A/Iek4gFA+rcS8Aoqs5GHU5+D/iMxWfsBHGnKE0IkYI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hCpaxJZEsf/Z5hSAANB5HDj1tyX3x28bRKZXeogGVge2VxFB79kmw4c0AIeFyNp3XzFSV2csmdJ0jvVYQ5hQcjdB9aIiSRNnMpqFq0zuuWzTK08aH1c+gpTkc1Whj9LjUZbiQCmK8efmer5Bp5n3CVZwtyQQO9huMUr4DfWET3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FpQmQoWI; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FpQmQoWI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPoghjDqLmQxYgiOCn0wCzUpnX+8Xh3HNl1aMwtNj4vDl/aTox8al9oeMvHAgvER6kngQkYCVhwSGJkj6KXzAjefX9DVLUMHaEpZkbsGzsWU+cKLQEC76g/PJTBoYM409wpL4mNHGn1ubsYFRiRtNwcWoo5nW5sU4kUityk3JBAW1+q9rJtZ39nakWOHv/Jyr2sD1P/6KfmEvSPRvMtzOt+uUJ+cZIiTii6OPklvph8U1pZvpRTLY912cheO8P3rx0tH+igNabYng+Z0BcsVeHxvrceHumWr/rvUKSwVXqJCNFf7on9DdPGPLMMIKTbRT87Ms8BAwYt2nSr++HCRhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kt30IILtiYed2iAPiRAUsTceMFu2f0FsHgPn5DBBUlU=;
 b=BxInusXlfHuZj71Ew5L8KcUbdGI2tLcUvR2r4UyBEDQOweth7zbnJzUMkVLpewljvQi4NV+rN/etJQDYwAUCHWuCAvdxENGf5Quu1PjjRYVoVRjbZNVTKQeUZOCE+TCKFuP1saSjdTqlSvf2l13DZSbWq5QAHmvpPPkPkFbIp0cvi0CwIqPvs8Tr8DA/OA2ZhA7wDOqS8jM7m1XVY3oA/MoWBIAJO6jVwBttULLXyEAuLk9Lzm/v5ZO8UG3Rjn82DI5OS/1fJ0Z77bUjBgRAumvLybkNjw1Xqkq/DpmUoYzAkXcXr4d0OZ2BuqXH3pkbWvX+LyouBvPWdJeinxWO8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kt30IILtiYed2iAPiRAUsTceMFu2f0FsHgPn5DBBUlU=;
 b=FpQmQoWIXHrhXpG5Fdepba9Da2zv36cxe2TT55nCld/BKmtNAE7fIAEb/yE9rW3v2cJZ2q3XU18yeq6UktGs0akV9WuVCUMiCtXOnG1Do9PqDyasmO9Z3uQ7z7ijDya585Tze8lqST05YoPC/tx2E9s6JJxMq8JT1L7B68D498nO++YC244wXylrvw7K54AcTsNPuR86XNnBGYNex4urAAExHmwtxjskBgW3eW+5JWCn6yQ1rzuYgFHWcZd4Om2u3f3aCoip4F+qYDbzoH/bwWrlex/97D9N4hinMBA2LSX4u93slCIBnt1PQV6n6/DOcQkdqEMFT3AONX7HvTmKYQ==
Received: from BLAP220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::24)
 by MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 22:53:07 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::fa) by BLAP220CA0019.outlook.office365.com
 (2603:10b6:208:32c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21 via Frontend
 Transport; Wed, 12 Jun 2024 22:53:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 22:53:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Jun
 2024 15:52:46 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 12 Jun 2024 15:52:45 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 12 Jun 2024 15:52:44 -0700
From: Liming Sun <limings@nvidia.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, David Thompson <davthompson@nvidia.com>
CC: Liming Sun <limings@nvidia.com>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/2] eMMC RST_N support on BlueField-2 SoC
Date: Wed, 12 Jun 2024 18:52:36 -0400
Message-ID: <cover.1718213918.git.limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|MN0PR12MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: f91033a4-6645-41f5-c017-08dc8b326d2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|376008|1800799018|82310400020|36860700007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5lMXmezcBHjQopucXYbUyP8M3PpLmbYqmJgPQddAdvhUHsdiynAIDxym93JD?=
 =?us-ascii?Q?IIwYU/NveGZG5q/aq38qs0LRKfAZSV3zzs+PlOgjeQnuf44UkcA/7Nx+afqr?=
 =?us-ascii?Q?N1aDageDDe7WAepdvbgzTP+QhSmVJYmUQSLhR0HE8/cgxV+Pdx1UzPSidLAG?=
 =?us-ascii?Q?X3dmgCVRPZ7Cr1cdhwS2MpT/uHCh+je9tQFCxjpr05fKy51gAp3wdAmAOIl5?=
 =?us-ascii?Q?GqqLq8JER+Wd6nWz/QJezx+ahOrMmefw89u9DepTZumZIRo5U32NzBZ2MQbD?=
 =?us-ascii?Q?SfczFZG6a0OINAtXJfMBbRkojiU+iFA3ld1kO/zdAFb+dJN+cecxaygXld0b?=
 =?us-ascii?Q?Jp3bkFRScNbE+Iz5B6GSoOE03K9b9A8NjgX/37MFA6EoSUxPzjlUc6Ik/JT1?=
 =?us-ascii?Q?n7SQU0KuUSHhEjqej3Slt8RjqwX/oDgjHVxO96qsjtGT4ncWBaj+o2u7XaDF?=
 =?us-ascii?Q?8Uicvn012tommm9ncDlrS0CyXQtnLFbToPveQPOPnJDVbUTDRPTvHtKzlPjP?=
 =?us-ascii?Q?EjR/L78gq/OuzyvTvTrqOFwjUD7DHmImcwbeLhAWUghwEaePYMjuFjwjr7aF?=
 =?us-ascii?Q?JnCkBGPNjJf9+PXQE0uu3uKw1BhOMkUnCaqnaVZvi1yL7nf3ryUVJZG8SQwk?=
 =?us-ascii?Q?3SEfaXZRn2assdUT/mMjDHu+e6P2Qq/yapT1riGtL1gbcSEtjSyG/GqxhuPR?=
 =?us-ascii?Q?qkpKlTN8Up6Ppojpcsl7Cgpn/2xOybVuoKrq/b9+wFnLb+4BwM/uN0SbWfcG?=
 =?us-ascii?Q?/tujr+F8ZnFSzcj3nsMoZiysRQEB5uOx4cOxZSyGtq4L0132I+db0UJC35uq?=
 =?us-ascii?Q?ja0SB9k2u1zsHos9FiVa4DMRWrbU0LTXPApU3UUpxHF5YiYJMbie00VzhqhR?=
 =?us-ascii?Q?SLNQJz7n2Htt9/xBPn6yweS6bAe9dT4clEH0/bnl7BGd/TdNeEySKwoeiizB?=
 =?us-ascii?Q?+80i2wHHAoGCVeCiL28j6+9LMZudU98bsXaQKOrFzPN6KgExTQ+FiWA4/vws?=
 =?us-ascii?Q?5gDVgqw6j+bws4zYX6EEAVaQ7uXrd64xIFJJ89+Yh3bT2HMwS1wOWfwc7MpP?=
 =?us-ascii?Q?SKVmdB2yUM4vE6yp6yv5+XWV5JnuI21GaZhVBIN8o+2j9bR6gkIEzrF4gLl2?=
 =?us-ascii?Q?jnLFpYBxrm9ibKmk2O+AQmQKl1+thv253VvavpRXfuHVZrcJSD4uRWkom/kj?=
 =?us-ascii?Q?+vxWg2WZYDQQgzumMijTImWA6+YH+4rV7gq0eacIJcFJbya4IHNlU+qwFI0A?=
 =?us-ascii?Q?r52epExv3+fIVBZEjZQocqCwz12moZVdQJUl0smlAvaToIM1qn2Ccl4s14AA?=
 =?us-ascii?Q?GeQVU7hDFta2fP8HPC5xAuxypZY/7FDYj2BU2Vl5yi/40Mmj3wHn0sKMa6nY?=
 =?us-ascii?Q?oIlqa4IgovPpykT/C1D/O2VRLfcjo/oTv+3pjL+RuBFXtXkDHg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230034)(376008)(1800799018)(82310400020)(36860700007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 22:53:07.4364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f91033a4-6645-41f5-c017-08dc8b326d2f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199

The dw_mmc driver supports eMMC RST_N recovery flow but doesn't work
on BlueField-2 SoC because the RST_N register is designed as secure
register. This patch series enhance the dw_mci_drv_data structure to
support platform-specific hw_reset(), then implements this function in
dw_mmc-bluefield.c to support RST_N via SMC call.

Liming Sun (2):
  dw_mmc: support platform specific hw_reset()
  dw_mmc-bluefield: add hw_reset() support

 drivers/mmc/host/dw_mmc-bluefield.c | 18 +++++++++++++++++-
 drivers/mmc/host/dw_mmc.c           |  6 ++++++
 drivers/mmc/host/dw_mmc.h           |  2 ++
 3 files changed, 25 insertions(+), 1 deletion(-)

-- 
2.30.1

