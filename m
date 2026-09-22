Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013043.outbound.protection.outlook.com [40.107.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3294F4CEB;
	Tue, 22 Sep 2026 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075571; cv=fail; b=EVkJJ3wN3rHBfvXrI6jSTaLUOAha/0RoyDyMRgyq0FhjHnMbP1p+uN/lYnVWxFABNbgUcUt0dZYir6AjkOeb60sXh5VR8VeE4z74By5KVtFRh47qNGOxPsIXum5TylAWr5frKZczts7d9+QZ0ghYaOdVog2fycDqCzt0YGC8/KU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075571; c=relaxed/simple;
	bh=Egge6oilgvvLYK8ouP5l4b7La4iu2ZrVyjvvjePhc7o=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sxRJCc9TIFkkBohdDeHFicN4+TbehsUUi0iH/U1ae7ANBHwi93v9TR0JnM8ht4yOIqs933Z8JHFORRzYp8n6QdIfKLRZg5Fh4qb8z3UIq6bKZPLbgwG7SaXjsq72+FysDGYTytXDGB1y8X8Ko4ISrMXmP+3u8k/CrTRxlnDoFio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=rPsj8/1y; arc=fail smtp.client-ip=40.107.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="rPsj8/1y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=de6BvcpvHUUUbZiTJPsxhFMfanA7z1Vahx5Z9rRs8ogp9T3bm4t5fZPKcx9TrZ7weQEtQeDRAneoFXQLkCRNEjEBtMJXG4ocOnMbPVaHNbUmZhDU2lRrddioMBR9a4L4GpNlHV0JezYjOm2Vfcfpam0kwV3IcdjyRfCy05UHNTe26AzN34REHW1YmgPFNb1X/V8N8uTpGUq0bQmSrDbSa8qcwOfxtePZrOoz8Qxy7+Quvilg9+TlMVpMjsrmlBcfBqd/afFxDdNdYrVu5WK7uNBvph6I9YAtMjX1F/dRcQ9FqAMLEUMwbqcMd798fsTn/OImdAja5ethLdJE3Zlfdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arwil+KuQjm5dLBrGvDJtSSWtrEJGJnVeV7Yi/Wn2y8=;
 b=Xs95wuatkmPBzmmSjwIQ7oBT5SvsBvQIbfE2uS7L68rgTwxs0Zmw2KSIDlCg++VBjEW+XXhXl+DIRphlN536Eyo/a2CI/BZ53+qyvfnu7/pqhlw/conxZp+SmW9942DiqvnXgxsIux46Gge0SiP9ZclsOKv0IT8v34Hif16IPLD50S3BnR8aydJtbfzrYYIOucZq++QyDDo+RU/hQ/GWpxHYrEJKb/+LyuUHETmAMgOX08n/KL49MpCyalIlrXSywbYBkBUAEdqIv10r7lGOsv5/rRtgyN2CgG/NzHZKhObwgbcxcS8/j3U6f4iznxLxR0/HFRi5e3mTlcV7MCTWPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arwil+KuQjm5dLBrGvDJtSSWtrEJGJnVeV7Yi/Wn2y8=;
 b=rPsj8/1yzHQBX2sNl/eKLjq9v4gVhyJPm9c/K05qYfVTk5z9rw0X98SfTgnUOHDyfQ+P2u2/n6x7Qf7//i0lWfeQxyNmS4488rVMrtEM+MsEiide59CxwmLM3xYYIxdTsXBe12uBWKdkrqBHwMrxKPYn11AuwfQyyMqUjJtedVrG6Qjtv1f6kkN5cV6gs7z1H0fI+MZCySZL+SCYk0BS3jqE7tHaMTN+c/rRf0w4Z3gA4GL9mgA+B+E8QgabkHyuYPpERaJCtH0TuXfVjnj7cItRpAaX4Ny0VV/4lYBBcJZEUcKsazod4AVc/J/jFKszEv1xfLTwlLuQHbAnb8bDIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by PH0PR03MB989354.namprd03.prod.outlook.com (2603:10b6:510:11a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Tue, 22 Sep
 2026 11:12:46 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 11:12:45 +0000
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
Subject: [PATCH 0/4] mmc: sdhci-cadence: SD6HC DDR50 read-path tuning and fixes
Date: Tue, 22 Sep 2026 19:12:34 +0800
Message-ID: <cover.1790074790.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
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
X-MS-Office365-Filtering-Correlation-Id: 3bf3df10-50de-461e-2c46-08df189a6d48
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|11063799006|10067099003|56012099006|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	46yL0MKMe14eJ+SiEh0GjdM/ojAsN3DjMSiOXUabP1r3Wv8apE85BLr6ZU1ezdp5G+KH6ws4XOybRoDJZzIYlpSvyx8uEslJYFTzR9YfFiRiO8DMMikzfs0N1AfqJwTmYsZ0QVS3g9kI9BDOwIS+GWVKthpfwCDlUwSSsOqVNqzWpVW6UO+QihhIQO8ZBiAUWmgVaa+VFE+buiUuKlf9flEMdyN4CoHvfwuToFWuf4CWyoRH0Wg7+aEAQzk3F13FeqSlAmXrO+k26+588mUf4HlXmApJW1btWU+dhNKS/e9Ugd/iEifUhmvR+NbbgYEES0PZP7CgsxBmkP1KFUyAYgxMpFOrV6JV2Dyh3OgxicTFeosfTLyukyfC1jLn+8Y1gUZWkXg9HTPyme97gJX/U+UG5XH2w6bBPNAbOa1m4myY2fXaV+Oz2RvoWhM/ReUNGbe+8R7N7uoAn9sIrbpv1tApdvmpEbCxmJMAzdXslmrFDHtFeC/TeYr2pMAWFMEUUnOLLb6Iz/VtajsJbmAzPnRqocTc+LEkbHADD58otcXg2Rgz9tzzz0+yQPPZpQQeGTgaLfyw4aiVs/mXpITZUZU2XQjFL+yQOshQOZu7DQJRdCrQYLmBdtm+ZSb0nVvG7UcdB0HX8UvLdIJ2/zhGjrp2ZVK7KAXWjAKBV5RRi5c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(11063799006)(10067099003)(56012099006)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OjdlkhQA44Vw9ITnPA/Hb3WtWErHCZ0lWBA/+Sha7N+eVhQ+bGQwTLzn5yZD?=
 =?us-ascii?Q?3BsPL1zeaCVDFwaV7/nG8gWBZtnY40Y+1mfyS9Ixf2ffmueO1LJNYCXG5xhI?=
 =?us-ascii?Q?Wln1gUN3bA8OTyENFnXmw1jsmkz3tEK2ZHUNRRM2TCNi/7AAvYKfsRKJUlBc?=
 =?us-ascii?Q?9QqIktE4z9O+0KEtAlfMEj3A5PRcKCL1wYFLA6ZmM6p50rSfJyZ6GOvtbKv3?=
 =?us-ascii?Q?GCITWk8aU4piK+foRc1zMQb2RGy/za56gl1C0Dv9AIp8OKsDD4uuhIAtstOo?=
 =?us-ascii?Q?M1p0vN6dU+uslWS4PXi2UGMBwjloMqF4c5V2YWmnPcs2vqpBHkmMIe77/Z+G?=
 =?us-ascii?Q?4Yk8JVQ6L1eNOIF2U3hfAistyiuhIwP1j3wyNVkG6oYK3erdDt3AFhyRtIdr?=
 =?us-ascii?Q?AYld8oamgE6wJyUP080pGJNYqyZtOhlsxrxTvrmv9ZgVqN0hZc/QhLFUDqYb?=
 =?us-ascii?Q?rMj8TLxHsXiO2d+ifQZ1bbHablAGAoh21Nogj68fEMn562AVZytx84J0Xt5/?=
 =?us-ascii?Q?bpBWqa4antUeXElwvYU3+p2HwG5f136pDKoUc5RxmrHxkUtqGmHv6ecGL8/F?=
 =?us-ascii?Q?Ptk9OsYBt4kpqf7QTfLCGZUY5DJAUT9slei4cn3OW3FbQJQJlYh8aMQvzag2?=
 =?us-ascii?Q?bOtxR54GNwrCDWgFqtJTCCPab2tO3cSHf2UBoGpfOPuyTP7Ajho5mJkI9/h6?=
 =?us-ascii?Q?bVJxKenjtww/UnIeZy8gqv/v8Ca+nsmKMiqpl1bOfXOdL8fEPgdS7xjjQOQA?=
 =?us-ascii?Q?s1yxz3//qI9E+3Rjw9VK6JCMxKhwfNRGi7Ml++BkXQf2k1vFCkFDzrAGbXCM?=
 =?us-ascii?Q?OfKR05QSmJLfSCngMspI2u9fqug5Gva9qeiwakyVB8YNmST2HsB9oz0UKEPb?=
 =?us-ascii?Q?cMC1CFO7Ya+h7KTUkgTEUKyyemAbfvuqeyVTkcz+gjiwgYx2+ooJoA51M4zy?=
 =?us-ascii?Q?K5jjYhFSMLArbti8JQNb1kIJbekrt5VLgEqqJF5FSFZe2G/3iT7SA0l3oYOG?=
 =?us-ascii?Q?BS7lwy9rxGy76AdO19w8rZgw4+QaYFxf+ZnKpgJqbs2PH1jOo5rGZo0UsejB?=
 =?us-ascii?Q?ITPvR+xs4LuxBbmTzro4znsyxx9AgC+QaVbc3zVRPGceNLuwDRtJKo7Vshhf?=
 =?us-ascii?Q?e82Z67RHZQE8IqfCqTPXEu3wjzes2JynIPfgbxpLHdf0hbi20Wc7L7fp2RqF?=
 =?us-ascii?Q?oYsfJrsE23Xd6rIviXg+OIkfGZIXLgAB/TFlIbDNfuDj2D/1lJ2bGZx7V6TX?=
 =?us-ascii?Q?mUbV7EguQK1OII34+PIV8/gyteG9r0uABAkpNUGBT21eoUvJ1ztsS1llDDli?=
 =?us-ascii?Q?dXcR6ew2so3H7+9nxgEOgtdloN94psuTtCaK9LOM7JtEEijn7yDMf8xSeBuV?=
 =?us-ascii?Q?lf2//cg9IlK/n0ZYrtBnp5IGMwHpuUz5iECcKInRz7dCS09BpXcDvbxUyjXy?=
 =?us-ascii?Q?S4gsSN5J97G+UwcX/+mgI3NsbiBnqKaf/bEx+uwCFVawos0hwTMGboM/v3Lm?=
 =?us-ascii?Q?QjFWjGaY/naQYOGcKjgXNMcjtVvvKUFHcL6OzrrikJztIeFKZXfFz94kKhC1?=
 =?us-ascii?Q?Ad2OD4NNbudeIIfiSM827MnnjeMJYmxnKgozXqEHbxB/H43E9TE8l8g8Sukd?=
 =?us-ascii?Q?/GVtFNsfQE4g5DKTlfZiMbgPsrCahMbWPhj1fCDv3nnxAZylyvC6/Ew8hhfa?=
 =?us-ascii?Q?h6TZKkroof6M7lSyuRR/MRUYKbPZG+vKdwsCLiUy43dHSQBZs2xriIE5F8ru?=
 =?us-ascii?Q?nh9OwUyEmQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf3df10-50de-461e-2c46-08df189a6d48
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 11:12:45.7997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MOG1wL5OZAMN7nb94PIMaE/sWnPZ36XeIWJX51LMgXPuot7N9SdGLRorSwOlmAG6jCX8Un4g3kGRKbUJFM4DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB989354

From: Tze Yee Ng <tze.yee.ng@altera.com>

This series enables DDR50 on the Cadence SD6HC (SD/eMMC v6) PHY. DDR50
has no CMD19 tuning, so the read path must be centred by static,
board/SoC-characterised PHY settings. Bringing it up on Agilex5 also
exposed PHY issues affecting the existing tuned modes.

  - Patch 1: add the post-tuning settle delay the PHY needs after the
    DLL re-locks, matching sdhci_cdns6_phy_init().
  - Patch 2: program PHONY_DQS_TIMING (left 0 in all modes); in
    extended-read DDR it must be the rebar pulse width in clk_phy cycles
    minus 1, else one DDR beat is duplicated.
  - Patch 3: document three optional SD6HC DDR50 read-path properties.
  - Patch 4: read those properties at probe and apply them in DDR50,
    and fix the DQS_TIMING read-modify-write so USE_LPBK_DQS is cleared
    before being reprogrammed.

The new cdns,ddr50-* properties are unused in this series; they will be
consumed by the socfpga_agilex5_socdk and socfpga_agilex5_socdk_emmc
device trees, submitted as a separate series.

Tested on Agilex5 SoCDK: SD DDR50 and eMMC DDR52.

Tze Yee Ng (4):
  mmc: sdhci-cadence6: add PHY settle delay after tuning DLL re-lock
  mmc: sdhci-cadence6: program PHONY_DQS_TIMING for extended-read DDR
  dt-bindings: mmc: cdns,sdhci: add SD6HC DDR50 read-path tuning
  mmc: sdhci-cadence: read SD6HC DDR50 tuning from device tree

 .../devicetree/bindings/mmc/cdns,sd6hc.yaml   | 27 ++++++
 drivers/mmc/host/sdhci-cadence-phy-v6.c       | 90 ++++++++++++++++++-
 2 files changed, 116 insertions(+), 1 deletion(-)

-- 
2.43.7

