Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013043.outbound.protection.outlook.com [40.107.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B16539775;
	Tue, 22 Sep 2026 11:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075573; cv=fail; b=YNyxLZp1hIl9PGU4b+auTbVixEzdcAa26dY+y/i1Y6nXI6nHoL/9sZtq42PoTyZsHhxgrhO14j4X2LJspL/YW4KCEFtBlngBotTRYQsVMWF8sKKb+QwQEf9e3eCxhiBl9rvcg9bpjKs0MgkFROQU89aRBHWn3X4yUB0UEEFSGU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075573; c=relaxed/simple;
	bh=N6X60a0iVOh9vrGN1uw5kSr+NUzxxXwQOAzk4gzt7lQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LKZ+YJOjcf9ZDfO8XXVQuHLGKf01D+VnJDETjZX9NDdLpMnHOfD27R2hLNLyl/Q/bIRTItno0XTrsxqsuBBUgjkdFGSNny5zxy3b8/vkxzlIKQ2XQnf6tkPpfoni+977LX+S0TiHDDdJWPROKx3QE7CTK+o7PXdJTvzZZdaRDRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=hhRsGqs1; arc=fail smtp.client-ip=40.107.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="hhRsGqs1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxAuaM/ZDcl3ohaD53z3epHS48p7cl1gxZ85CkaIVB55vwruL1vRGVh/v5zdGBbJeaPIeHr979U5G9gcEBK3E2wIqdzkvKfWxnM7mBnf7fVSzA8DWP/Tv93g1w+UiWLWJ4M01HU176gelleSKa54L8up7cbApAgobO1/Cj2V3i2iQHZyGpuWgEWUYcwhbugnhJui3NyWyJYLmUL3mUsDrpnz8H/RqCQC3516AR4qQV1lJEDNeByLCLmAgt0lGIZCeqb/INrIhd4pAdX7AbhI4NCLMU31oEtWoPZIU7bVm1lb79fd72HMuUs/TYBMLJLxmnTLbvcbfTrmN3qt5sXydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4pJdX6k8c4HYzrMnpFNYVI1qpz+CD3UFqSMnT5q9B0=;
 b=w/X6M4fL2pfSsK5Ygsh/rrY0s1N8uJin+2HkBSXQQqqdccEHwe7ZELhpN9n5gzsNANS+1SD4MccEXRrpTv2ge08hkQbexpp7mGjgGesY2kvtKWPhrcHHDwyqfEbpBA497oyQRIkdopj0JkAighNxEfgd5vrKPIWxX3Pj9+c+4+xfGuAI77sNi9qjQVoFaMRuX87S3Dp4eDO46tn5Q1Hpqy+MYpgg8PICWLjo++IaFPfC/Zu2UnESkbl4mTIxbr48oXevMrztvVjwsCG/n4neZd8SnGFMGGPmJYHOD4k2YOUQZSOVAet0IdR5d22xG3t+FLUPrzjpoGJQXtwBMKGJGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4pJdX6k8c4HYzrMnpFNYVI1qpz+CD3UFqSMnT5q9B0=;
 b=hhRsGqs1OpqhhgvyjWWr+4gu02uPiwkVQHTnVxMip/piWB1fkRwm3e+fROYSTKL2SLlkwDPbefV67+OOzWhH3nMGJ01Dn6F3v0mXdt+4+qBfwIsa2SADFygwWZwI4mhV1ULgbWbBLhO7hHu0blq6+0elFIdb63mwDNMDT0I8DA4ZiyS2lEPcu4Ef0wmoWKv3UQxdVcMi5wle4z5VgnzXOb0JtQ3B6zZJfC9mz84FEvY6hUjL+nHNc51pkTktzwhIWFlN0xBQIw5a6/2Npa/+qH8nQ+WYRb6llw3JT9fJubUCjSyK40GxJlOjeyzpJ35BVqc9ybMJqei/1QbS1VPHAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by PH0PR03MB989354.namprd03.prod.outlook.com (2603:10b6:510:11a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Tue, 22 Sep
 2026 11:12:50 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 11:12:50 +0000
From: tze.yee.ng@altera.com
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH 1/4] mmc: sdhci-cadence6: add PHY settle delay after tuning DLL re-lock
Date: Tue, 22 Sep 2026 19:12:35 +0800
Message-ID: <a0edc86ec30949ca7b923f4939a911960e8b5395.1790074790.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1790074790.git.tze.yee.ng@altera.com>
References: <cover.1790074790.git.tze.yee.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0119.namprd05.prod.outlook.com
 (2603:10b6:a03:334::34) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|PH0PR03MB989354:EE_
X-MS-Office365-Filtering-Correlation-Id: b8ab3838-8dd7-4839-f6e7-08df189a7056
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|11063799006|10067099003|56012099006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hNhsjClLZLrZRi0ews9g/0cB53NURX3GuT795f3aZP9IRF9LsHzkA5i/z1JUfJor/hSkG1p2sQWL823J+LeHW35xw5PQzfm2fFSclIP5CQUGzDQ1f9gLqx036uqDyftQzLsRKBtM/FKi/muFQxfy3okmIPWb+Cx/28zThAyrBajVW+oj9c4a7kzSA50/UGLKKyyg0doUihIRpes9DEqOrnJM2aPu7l6T1eUVBDYmeYE821/YJGRCptvlRHtW7K/nTMRBq+C3hH7QMfu9yRW8XGmOwgS+ZKiznTFEmarnJ264zPy4+454/FxhUIH0RETwr4Pkwc7ZbqgDLsvlqmlg/6HhPIH26hXhp1XvaTrYTslkM+SUNOmJBWLLlUBr7wBaLO/hUZeSyi2svuRiWk8LxQt3VqLDBsr+chP5wszDG1XA8hWO81ZjHcidUczWdTXiJ/GmSA6+niDFjEyMTPeyK8j+4K3uIPXaf6VPVWZ89FRZLCHT/uE2f1mc4hzgfOdwfzWY5Bp1RV9JWmoTIvPGu84e46Kl7fZVnZA2t/vNDjnbXcFr5+DAbfSoJEtWDfX7wv/q42SMNO0GysXsq5l17cvovxOyVEVXUgBp5FkWENIMkXw6GfmuOteTvdSZKX1p0tRkNvCXrtaVgSzsjPRhvq7DId8bAAQ7NP4E/TT8GaQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(11063799006)(10067099003)(56012099006)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ap/1AplbhqPZ3QDrzI+kpYuRJ0yQCkMVJNos+JIqkzEJ2LiHnOH92XRE/tUz?=
 =?us-ascii?Q?7qFJ5iB55mkbFBxQgOrkLO71FrHg0/USRSBSzRaWUbLOcyqeDtPMD9RyNVSk?=
 =?us-ascii?Q?K6rKyCqpQHc0772+Zo5al/9ASyEw5/VfL59Dd4spud4FAt/TCWKD4fxgDq5i?=
 =?us-ascii?Q?oydKlhp3Wc4izfbZBmmZQqef71jtgFOeh3ufdlQohTgFr0D+A9ucaCxx/erH?=
 =?us-ascii?Q?SgWou1DBiT1QsjRzBpfe8mYfE7TMQXfnprU7Kx/AFLfqSVSi+0FaWX2yD8El?=
 =?us-ascii?Q?HhDY3i2fqHIrhZxXQpZzl1Wrtg1lwQ0jWYPHWUafKa5cMKFPsFCcI3ne9bkd?=
 =?us-ascii?Q?ylt35fYjc6PjceXe6ZxqN9jmX7x5e2uHNyd2zeypHkldshz8M9ODnCKelNc8?=
 =?us-ascii?Q?7RROESGxq7jur2x6FH3Bgo2ReM8+IMFKP8GrXIAOs1jEDb1Ujc/wipnitTdC?=
 =?us-ascii?Q?bDg360CZpbTfAR2qw4LCTTzfvASxRjBRW5mcDhNUtcCQq4732n3n4rDugA7q?=
 =?us-ascii?Q?hVslwJTGnCyjmwvymMxVml2BzWdgHBVPIkNDtGPEyx3UOBXR25s5Nti2Hy4n?=
 =?us-ascii?Q?ECM7E4MaazFIqx8KTeRw4y443dKmqBgr3Qpl7DqxR9OxaJA8IGQB5vNWeJX/?=
 =?us-ascii?Q?tMjGSqbj6qLLl0xq3i9QNmNtCO9+Io1maALcAXyblkF1bEunIBgssIIa3ZDj?=
 =?us-ascii?Q?gUYCmZhLsZ+BQ+JaXZtNmUmLTcpXUvNdIe+aR+zNJM87tI0vxsE7mNYnD3N5?=
 =?us-ascii?Q?5aKsR94X7nORIZzE9pMYO2bGUzbYfxnLI3VyR/MnW1zSdv5SR0Z+cLNv3jq4?=
 =?us-ascii?Q?GMv6z8Rt9g1npcxx0R4LHpahG0E6N7zGtokAmYBCK5ljVYgEq5NqkasWjjX2?=
 =?us-ascii?Q?Te8GUeWBR7mPCa8bCp/bCMe+zttPm98deRXsznMmDdExGQUnUxtvwdMPJCFs?=
 =?us-ascii?Q?6LzdqOXxIae/d78or2fADUeKZSbBC7xIbbVg1lFNvEQuInhO02m1ISzVY9Ec?=
 =?us-ascii?Q?JWZWHBFyxpFLSF6pSgnZWy84tW9rPFi0DkbbMEK6UvB/kJ/AOoIJv+DA/EsV?=
 =?us-ascii?Q?rtSfLS7SEj8JEH7vcwZWRhahL9F32nfi+CC7bkj2e0sePZGBDC2susdk5VVx?=
 =?us-ascii?Q?L0MviydiuLQIBiPZ9fjsb2b03R2G6iVc34Ul4S7ufH++ojSfxD8WppdU9sb9?=
 =?us-ascii?Q?v1IZ+fK0wP0aNRLoo5IISTRt/5PbYODhRbXt0+hKTkoGga+kS3MrsZSs8Xq8?=
 =?us-ascii?Q?1whg6i4HTAkQOAypScKmbtztL4uqcXwuaV+yChSSCMmiEEW4g8V07gAwYA1i?=
 =?us-ascii?Q?UvjZoCSdRb9R2QfcO1jQMcwR/1Ik7+4ZNeonepyscLX9Iw7Pg368sW66QTF1?=
 =?us-ascii?Q?mu7W+du8Lk8FFX0ZkpRO0J8ga8FgzW3OxWymcYcSftyCxvyTXIRANKwNKc7u?=
 =?us-ascii?Q?rNd/ppf8hOReUst3hUVn8x29WbgwSM0sPTnQi98CQe03vNdV9iNR6UFYV2ym?=
 =?us-ascii?Q?XnEG7QNg+Ll5mvPuodj3+B++VpeNP0VHYnUS8iwvvX+YOR8epiulbDxUV5c4?=
 =?us-ascii?Q?FvVUeEEI4RzSiMbQ/upKOPGRJCmPMZYzqXNcnuxK9pYh9Uoi8HXRkRhlyEYj?=
 =?us-ascii?Q?GlrX5BRiU/TXMWXUNb+19N5aTpxsCJ3pNMmHn3jmG7b0do9AmgxiRLDnE+Mv?=
 =?us-ascii?Q?+unaxC1/intTS3iBKA4DRODvEKab+YYXcTlf032A3577CaoevFpUi4pDMskC?=
 =?us-ascii?Q?StVaUHrbmQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ab3838-8dd7-4839-f6e7-08df189a7056
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 11:12:50.2204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IltW32eWJusM2bKM9nZbE/hFLT8e8v7A/fLpJnhTnUNRaC0xJbHGiF0mbd00rdKRCSv3k8jGIlf5hnfWIIzbVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB989354

From: Tze Yee Ng <tze.yee.ng@altera.com>

After re-locking the DLL, allow the same 5 to 5.5 ms for the clock and
PHY signals to stabilize as sdhci_cdns6_phy_init() does. Without this
settle time the command issued immediately after tuning (e.g. the R1b
CMD6 that switches eMMC from HS200 down to HS during HS400 selection)
can time out.

Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
 drivers/mmc/host/sdhci-cadence-phy-v6.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c b/drivers/mmc/host/sdhci-cadence-phy-v6.c
index 22d56bb46d75..35f35ef9c710 100644
--- a/drivers/mmc/host/sdhci-cadence-phy-v6.c
+++ b/drivers/mmc/host/sdhci-cadence-phy-v6.c
@@ -811,6 +811,9 @@ int sdhci_cdns6_set_tune_val(struct sdhci_host *host, unsigned int val)
 	if (ret)
 		dev_warn(mmc_dev(host->mmc), "%s: DLL reset release failed: %d\n", __func__, ret);
 
+	/* Allow 5 to 5.5 ms for clock and PHY signals to stabilize after configuration */
+	usleep_range(5000, 5500);
+
 	return ret;
 }
 
-- 
2.43.7

