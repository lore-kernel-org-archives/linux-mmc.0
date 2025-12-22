Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023113.outbound.protection.outlook.com [40.93.196.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1242FF16C;
	Mon, 22 Dec 2025 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766393146; cv=fail; b=J3jv9jq2zkGhA58Ty+5rTw1if/9ignzwnP2h7C5trwSjIkEcaWRB+lYHNh3G2NcfQOgu6qzaSqkJAHlNL2nPGS3TX7vbAEJf6GkYk1HWmm0GL4BE0n0hJmKk3O4C+IHqbMQqaIa5aBOmWIFBWPUsmd3oWUmqrZBbpT+GYRHjxtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766393146; c=relaxed/simple;
	bh=7pmuqaRvFdkYE8l0t+WXP0nQ+byR3fU7UkBgKgMzNfE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=axBCvabXAmOC4ofvYTeUlpnFfN2pzALdle+9dQP0lIB9KAr2h4Om/eQcdS4fzEK6xnhNd9GCUpgU+SqTadxoqSrJzpBK1Y7VRTi7C8QQ8nzEVfWnIq/oEvGzI2sKuXnrzN5gSyjLseY7zNZj9D65gQvdAe26r9zvMgymkE2WcFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=qTdXOupE; arc=fail smtp.client-ip=40.93.196.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="qTdXOupE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ao9GjZ2sNLiIifWYbQcDb3c7chtZokA8mHUaYReB/W0+XbGWjNCSwUKPFBEni//yNLclXLW1wjWulPoZo06DEIznMwMMiimBJ/ooRR/us0nahH5pzVjyO15DiD8v22YhRWhDJuWH3rsuKgual3k1d8xy2/GokurbTitE8aWP2Ce7mfV7Sd5lBjoEmb8EWYUO/0MqAGiriOfqNq7GmIZVPUVK4xvEc24Rg1RzSZ8xKzgXAl1YZUP/au2VN8Sadf/rUTAnP/7Pr2AYMgXJ1BgI5r6ygSca80DhVqXiogCpxblWSDIHNduMxc25LO6Tzg27PDe+JcIsUb6KgobL9fuBGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NHcLoS0Rx1oi9FaCLbPrV/fAfE4aWoQunPiQOJYk7M=;
 b=iimQiCS6NeFrs/bOk9N2wmqUmTiV6uqrw+MsZJJZ7qJZEwcbTTflhREWBb9xZ+QcBgExnHwHMnMiJqd/RPPItd5Q15fpAI4wg+OCQrPSysh0ub5yS/8ZbvRJq3rdIxoNaA7gOLckWyeuJigYZwdZBtITe4r4MXbyAIScekH8DP4DsoLwhHBxU5YT000RxWMXkJKTsn5TG42yta2sdWATSJCGoWq9mkj4oPOhP55zd2f9zEDO3lvZFJfxErMlXCF7kslK2t5zJWo572KoB+1IbBR00cM9HzHRixU0ruwFCNtHa/NJXM5zwhrBrBOxYgaDyWiq6/pYfTX30zz9YyophA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 4.227.125.105) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NHcLoS0Rx1oi9FaCLbPrV/fAfE4aWoQunPiQOJYk7M=;
 b=qTdXOupEGAhcArfppgzPMKJBZtvux2NB/qFEB0IT61dvxoxMUvb+QM5jCGqhKU5pE5Yjr1tPNQXxghw6Ipa+sfWkc7WlX+yziqgXW4g7O+YIvNQVAaPurO4PcuKtPwk2YWJF9Pfxcl6xQ2Hv2jE9dMchwZPeFO0E2+O3Fo1Fa1rzIVfZ5yfKmicFxPivB4MmjsovPN0qMwIWxPB8m19HTQSZAWMA81DDIydEUCLd4wgxoO3EGMPY4+PUWDxUf6BnM8WnZz92zlw7g68zoi9x7SAq75RA0Drq3hmfUJyLiLCbrT5j5VQeA397cq8nX4oBLEeOh2IsQZC9vfOpBzGTOg==
Received: from PH8P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::10)
 by BL1PR18MB4280.namprd18.prod.outlook.com (2603:10b6:208:311::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 08:45:36 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::31) by PH8P220CA0019.outlook.office365.com
 (2603:10b6:510:345::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Mon,
 22 Dec 2025 08:45:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 4.227.125.105)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 4.227.125.105 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.227.125.105; helo=[127.0.0.1];
Received: from [127.0.0.1] (4.227.125.105) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.9
 via Frontend Transport; Mon, 22 Dec 2025 08:45:34 +0000
From: Tzu-Hao Wei <twei@axiado.com>
Date: Mon, 22 Dec 2025 16:45:01 +0800
Subject: [PATCH 2/8] phy: axiado: add Arasan eMMC-PHY for Axiado
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-2-5457d0ebcdb4@axiado.com>
References: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-0-5457d0ebcdb4@axiado.com>
In-Reply-To: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-0-5457d0ebcdb4@axiado.com>
To: SriNavmani A <srinavmani@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Tzu-Hao Wei <twei@axiado.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10563; i=twei@axiado.com;
 h=from:subject:message-id; bh=GC+JHgflJPAr5eP6iC+HBSq5gumR84n+6oRHQ+aAxjk=;
 b=owEB7QES/pANAwAKAXgQMF3EWvHXAcsmYgBpSQUmdTgOF830YgU9929cis3PeL8WwjY+ZgeUp
 ET4+EVuVi2JAbMEAAEKAB0WIQSZyWINOowtFmDvdYF4EDBdxFrx1wUCaUkFJgAKCRB4EDBdxFrx
 122RC/0VXGy8vu1me1RnuzYB/2G36ET05L/bcAYd+vgVx/qZrzUVCR/O7+c4UCd36KzHVsdTUDf
 0ZKLmCD5jEEtwN+RFU+rqHm1pn5iR9EQWgNJZ1Mg+MsbZCXno7rAeaXRAFhFBKKnbf42IZ0mUQn
 yBsaEORJaC11alD4H3K3iU89RtUIklywJcH8L4CyhU9+MrpCMdk5wymxaO9z4QPaV3mYnSOsmDB
 87LW8n38hOm9HS1B7qL/yNnnOA2Z9G2S7YjXYEm1cPClF4p15DT9oZdl4z9rsy/wU60rn2dfYUD
 R6ey33uy+6pfhKrR57ZVDMo5H53MSudx4T7+ZD9g14uiIbOOKz8j1pHPIvkkeMF+g+wrwFt4Jew
 H+QokWBBRClTT3/Sxy8FSeB9W/J7RQOoIE79/GRNorgcfB2O3WULB0jux3uVdYH6VgY4pEiht6u
 HxGGpI2sH681EALInR0XakPOIPqj1qjv65M3B5846YJGE2JajcfnP0YErSEo7MqzrBkcI=
X-Developer-Key: i=twei@axiado.com; a=openpgp;
 fpr=99C9620D3A8C2D1660EF75817810305DC45AF1D7
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|BL1PR18MB4280:EE_
X-MS-Office365-Filtering-Correlation-Id: 310cee53-da02-404e-5837-08de41367976
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|34020700016|42112799006|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b25JQi96WWp4cEZJOGFvWTZhV3AvYVFVVWwvRWVYcWlFTWc4VktyZ1VUZnlE?=
 =?utf-8?B?c1IrSzM4cWs2dGtZRk1XMFNqTUJLa1RRUDArMHdFWmlXcmpuOUZ5cFhET3hM?=
 =?utf-8?B?S20xWStmbnQ0QzFXS2pzNFVLNXFEdGdJMVBJNmhUc3NpMkJjSlZkTEdTbjE0?=
 =?utf-8?B?eUdKZWFHOUR1VGJrdDQ2ekFQRmZ3NWQxMW1DV2xHVVJnVTlvOFNYVk4wRlI0?=
 =?utf-8?B?QjlOeGdjNnp2c01JWVNncWUwTmtRbDE5aVJmYVoxRzQrcGtER2xvdXFuUXRa?=
 =?utf-8?B?eTFWbDAzMGFpb2t1cE5ZZEkyaXJkeE51RFpOcjJuWDBGQUhCOUxmVG5tU0J2?=
 =?utf-8?B?UFZKUjJPZGUwWkw0bkRZdFhvNTlSbzRsRG5rbHUzblV5ektqMkdycDRBczdv?=
 =?utf-8?B?WjlXMFB1OWg3Z1JaUk1UekdrZU51YkNlWGl1Nk9lU04zMTNVR2RvRDZOMXo4?=
 =?utf-8?B?VC9xSFJZaVJTU0U2OVdZQk9oYVM5bEJrcVJiNDFzMTJqVEg0b1ZFcGJ3TGY3?=
 =?utf-8?B?UlN5NnB0MXRlbTNYUWRqaVdxUU8zeWN3d1UraFdOYksyTUdQWDVQNmVxSGRW?=
 =?utf-8?B?TEFkRVFyRE9HRm13U1IyZ3BLdDBhUHdHcGR5L0FONE1OeDJhZFlJZHBpV2w0?=
 =?utf-8?B?eElMSXRuTFptK1RFVXRUNkJ2aElMZnNEZFdvOHBHZHZHcnZNTFdMeVVGOFc2?=
 =?utf-8?B?MFlYaUtXRnpuMk8wbjh5MEUyVkxzSUw4akY1Yi9qTE4rRXY3U2xQb25BQVFY?=
 =?utf-8?B?OVFiOGllUDhHY0tVTjZuc245d2tyOW14V2swanVKZ1BJWWZWTHZpMlIrWDBs?=
 =?utf-8?B?eUV5NW1uTUhXSUFycmFtdm9OUXRYQ2dDempTcFdWSE4yQWVzYW90VXVLM1Zr?=
 =?utf-8?B?dVVZTmlhZnR1ekZsdmgrUXA5U0Y5ZVA2R2ttb1FEMktJL0h5Q3l2bE14SW1T?=
 =?utf-8?B?N0x4eXBrd3BDaDFoT1V5MXRPR05VQWZyZm0wTDlWdU5sTEl5OTZONTFJalFk?=
 =?utf-8?B?STZqc1UrVmM5ZGRCYnZabXlLd1l3L0prZmFNOXRUaFNoa0FUQ2ZMaVVpYXJm?=
 =?utf-8?B?aVJTVmNqUDNFUk5vYjkyVTh1bHpaRExmSTR2ZU9BNmxpcWRzKzdBekw2azRp?=
 =?utf-8?B?ZHdXdG9HN0RsMWdVb2UrRUQ5OUZmR0ZYTml3WHhUMktTbyszK3FuaGZpY2Ur?=
 =?utf-8?B?Vm1UTjFQcnV3RjZSMlhhREduLzQrU01wMWVCTkpwOHNneUZ5NGpTZUxML0Ew?=
 =?utf-8?B?b3lFc2dSbnNpQzZSU1E2OW5wVk1Qd2RiUlpmeVkvamxRamZWQWh5cDYwbm5J?=
 =?utf-8?B?V0Z2eTZxcFYzWXZCdVRJemNJRzdYVFpqcjJFbXA4eVJCdmVmNHFFa3gyUUJm?=
 =?utf-8?B?U1d4cEV3ekdKa01VRXJHL3MrbGhSeWZHZ01OL0I3Yjl1OThrT0lUcmk4QzVD?=
 =?utf-8?B?dkJwWnNtTENxV2dBRXFMZTBJMmZ0dFhBVTVqOFRkMG5yTStUTkVXMWt2TXNo?=
 =?utf-8?B?Y0x1cU5haHhLelRrSmdqY282RTFtcStkN0JHN08rTkpudlVKb0pKYmdQaytT?=
 =?utf-8?B?YUEyRlRiM3pZbVZOclU0NnBiWjZYQlBxNVEvOGoxUlVwVEc1Ykx4LytrdUNB?=
 =?utf-8?B?WlZ4WVZuVU9MTTByRUM3bGpRcW1PUGk3dWMvNWZRRlp1RWxBQzBQQytmOXo5?=
 =?utf-8?B?VEJhOGNXL3NVaW9JaTRLUXBqUWg1V3lWd0g2WGtJdXEvd2licEJNT0hSUmFC?=
 =?utf-8?B?S2gzaGk1MFZueVZmN1dibVYrc09IcGxqMjMvL0pQYjJhUEJXOXk1VlZ5NTgr?=
 =?utf-8?B?aityQUlSTGx1UU02V0lsajlWdFgvbDNmZTkrMHNycXR0dExkRWdSbGhVNlpv?=
 =?utf-8?B?YVNiaWhzN3EvR0NKZkJQb082TUU2aTNKQ21kZ1RYZEhldVdrRzI0cSs2VW9N?=
 =?utf-8?B?c1pMdUdNM1VMak00VkYyVFI4eE15WmhxOExKRzFXeUxab0lPeXluS1NpdzRo?=
 =?utf-8?B?RENsVUpSWjdtdERVSG1QRUZtdU10U3RHZThzTUVBOVRITG9SWnN0cUhid3p0?=
 =?utf-8?B?RUdGM2Z3NWlhWENjbDNmNk56QzQrbUFQVmxXMjVaS2lGMFIwNVI4VXJCL3lF?=
 =?utf-8?Q?qX/0WJZ5jjYGFUiUswYdROS+9?=
X-Forefront-Antispam-Report:
	CIP:4.227.125.105;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:[127.0.0.1];PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(34020700016)(42112799006)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 08:45:34.5412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 310cee53-da02-404e-5837-08de41367976
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[4.227.125.105];Helo=[[127.0.0.1]]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4280

From: SriNavmani A <srinavmani@axiado.com>

Add support for the Arasan eMMC PHY found on the AX3000 SoC. This
external PHY is required to achieve HS200 mode operation (200 MHz)
on the eMMC interface.

The existing sdhci-of-arasan.c driver supports internal PHY
configurations, but the AX3000 uses an external PHY that requires
different configuration. This driver was written based on the
reference implementation in sdhci-pci-arasan.c as suggested by the
Arasan team to provide the necessary PHY configuration for HS200
high-speed mode support.

Signed-off-by: SriNavmani A <srinavmani@axiado.com>
Signed-off-by: Tzu-Hao Wei <twei@axiado.com>
---
 drivers/phy/Kconfig                  |   1 +
 drivers/phy/Makefile                 |   1 +
 drivers/phy/axiado/Kconfig           |  15 ++
 drivers/phy/axiado/Makefile          |   1 +
 drivers/phy/axiado/phy-axiado-emmc.c | 260 +++++++++++++++++++++++++++++++++++
 5 files changed, 278 insertions(+)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 678dd0452f0aa0597773433f04d2a9ba77474d2a..b802274ea45a84bd36d7c0b7fb90e368a5c018b4 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -103,6 +103,7 @@ config PHY_NXP_PTN3222
 
 source "drivers/phy/allwinner/Kconfig"
 source "drivers/phy/amlogic/Kconfig"
+source "drivers/phy/axiado/Kconfig"
 source "drivers/phy/broadcom/Kconfig"
 source "drivers/phy/cadence/Kconfig"
 source "drivers/phy/freescale/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index bfb27fb5a494283d7fd05dd670ebd1b12df8b1a1..f1b9e4a8673bcde3fdc0fdc06a3deddb5785ced1 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_PHY_AIROHA_PCIE)		+= phy-airoha-pcie.o
 obj-$(CONFIG_PHY_NXP_PTN3222)		+= phy-nxp-ptn3222.o
 obj-y					+= allwinner/	\
 					   amlogic/	\
+					   axiado/	\
 					   broadcom/	\
 					   cadence/	\
 					   freescale/	\
diff --git a/drivers/phy/axiado/Kconfig b/drivers/phy/axiado/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..824114e6068da327308321b9884552ad33db9efc
--- /dev/null
+++ b/drivers/phy/axiado/Kconfig
@@ -0,0 +1,15 @@
+#
+# PHY drivers for Axiado platforms
+#
+
+config PHY_AX3000_EMMC
+	tristate "Axiado eMMC PHY driver"
+	select GENERIC_PHY
+	help
+	  This enables support for the eMMC PHY block found on the
+	  Axiado AX3000 SoCs. The PHY provides the physical layer
+	  interface used by the Arasan SDHCI host controller for emmc
+	  signaling and timing adjustment.
+
+	  If you are building a kernel for AX3000 platform with
+	  eMMC storage, say Y or N.
diff --git a/drivers/phy/axiado/Makefile b/drivers/phy/axiado/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..1e2b1ba016092eaffdbd7acbd9cdc8577d79b35c
--- /dev/null
+++ b/drivers/phy/axiado/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_PHY_AX3000_EMMC)		+= phy-axiado-emmc.o
diff --git a/drivers/phy/axiado/phy-axiado-emmc.c b/drivers/phy/axiado/phy-axiado-emmc.c
new file mode 100644
index 0000000000000000000000000000000000000000..a61a458c9a65915cd576b431bc6a0cf7e8b18add
--- /dev/null
+++ b/drivers/phy/axiado/phy-axiado-emmc.c
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Axiado eMMC PHY driver
+ *
+ * Copyright (C) 2022-2025 Axiado Corporation (or its affiliates).
+ *
+ * Based on Arasan Driver (sdhci-pci-arasan.c)
+ * sdhci-pci-arasan.c - Driver for Arasan PCI Controller with integrated phy.
+ *
+ * Copyright (C) 2017 Arasan Chip Systems Inc.
+ */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+
+/* Arasan eMMC 5.1 - PHY configuration registers */
+#define CAP_REG_IN_S1_LSB		0x00
+#define CAP_REG_IN_S1_MSB		0x04
+#define PHY_CTRL_1			0x38
+#define PHY_CTRL_2			0x3C
+#define PHY_CTRL_3			0x40
+#define STATUS				0x50
+
+#define DLL_ENBL	BIT(26)
+#define RTRIM_EN	BIT(21)
+#define PDB_ENBL	BIT(23)
+#define RETB_ENBL	BIT(1)
+
+#define REN_STRB	BIT(27)
+#define REN_CMD		BIT(12)
+#define REN_DAT0	BIT(13)
+#define REN_DAT1	BIT(14)
+#define REN_DAT2	BIT(15)
+#define REN_DAT3	BIT(16)
+#define REN_DAT4	BIT(17)
+#define REN_DAT5	BIT(18)
+#define REN_DAT6	BIT(19)
+#define REN_DAT7	BIT(20)
+#define REN_CMD_EN	(REN_CMD | REN_DAT0 | REN_DAT1 | REN_DAT2 | \
+		REN_DAT3 | REN_DAT4 | REN_DAT5 | REN_DAT6 | REN_DAT7)
+
+/* Pull-UP Enable on CMD Line */
+#define PU_CMD		BIT(3)
+#define PU_DAT0		BIT(4)
+#define PU_DAT1		BIT(5)
+#define PU_DAT2		BIT(6)
+#define PU_DAT3		BIT(7)
+#define PU_DAT4		BIT(8)
+#define PU_DAT5		BIT(9)
+#define PU_DAT6		BIT(10)
+#define PU_DAT7		BIT(11)
+#define PU_CMD_EN (PU_CMD | PU_DAT0 | PU_DAT1 | PU_DAT2 | PU_DAT3 | \
+		PU_DAT4 | PU_DAT5 | PU_DAT6 | PU_DAT7)
+
+/* Slection value for the optimum delay from 1-32 output tap lines */
+#define OTAP_DLY	0x02
+/* DLL charge pump current trim default [1000] */
+#define DLL_TRM_ICP	0x08
+/* Select the frequency range of DLL Operation */
+#define FRQ_SEL	0x01
+
+#define OTAP_SEL(x)		(((x) << 7) | OTAPDLY_EN)
+#define DLL_TRM(x)		(((x) << 22) | DLL_ENBL)
+#define DLL_FRQSEL(x)	((x) << 25)
+
+#define OTAPDLY_EN	BIT(11)
+
+#define SEL_DLY_RXCLK	BIT(18)
+#define SEL_DLY_TXCLK	BIT(19)
+
+#define CALDONE_MASK	0x40
+#define DLL_RDY_MASK	0x1
+#define MAX_CLK_BUF0	BIT(20)
+#define MAX_CLK_BUF1	BIT(21)
+#define MAX_CLK_BUF2	BIT(22)
+
+#define CLK_MULTIPLIER	0xC008E
+#define LOOP_TIMEOUT	3000
+#define TIMEOUT_DELAY	100
+
+struct axiado_emmc_phy {
+	void __iomem    *reg_base;
+};
+
+static void arasan_emmc_phy_write(struct axiado_emmc_phy *ax_phy, u32 offset, u32 data)
+{
+	writel(data, ax_phy->reg_base + offset);
+}
+
+static int arasan_emmc_phy_read(struct axiado_emmc_phy *ax_phy, u32 offset)
+{
+	u32 val = readl(ax_phy->reg_base + offset);
+
+	return val;
+}
+
+static int axiado_emmc_phy_init(struct phy *phy)
+{
+	u32 val;
+	ktime_t timeout;
+
+	struct axiado_emmc_phy *ax_phy = phy_get_drvdata(phy);
+
+	val = arasan_emmc_phy_read(ax_phy, PHY_CTRL_1);
+	arasan_emmc_phy_write(ax_phy, PHY_CTRL_1, val | RETB_ENBL | RTRIM_EN);
+
+	val = arasan_emmc_phy_read(ax_phy, PHY_CTRL_3);
+	arasan_emmc_phy_write(ax_phy, PHY_CTRL_3, val | PDB_ENBL);
+
+	/* Wait max 3000 ms */
+	timeout = ktime_add_ms(ktime_get(), LOOP_TIMEOUT);
+
+	while (1) {
+		bool timedout = ktime_after(ktime_get(), timeout);
+
+		if (arasan_emmc_phy_read(ax_phy, STATUS) & CALDONE_MASK)
+			break;
+
+		if (timedout) {
+			dev_err(&phy->dev, "CALDONE_MASK bit is not cleared.");
+			return -ETIMEDOUT;
+		}
+		udelay(TIMEOUT_DELAY);
+	}
+
+	val = arasan_emmc_phy_read(ax_phy, PHY_CTRL_1);
+
+	arasan_emmc_phy_write(ax_phy, PHY_CTRL_1, val | REN_CMD_EN | PU_CMD_EN);
+
+	val = arasan_emmc_phy_read(ax_phy, PHY_CTRL_2);
+	arasan_emmc_phy_write(ax_phy, PHY_CTRL_2, val | REN_STRB);
+
+	val = arasan_emmc_phy_read(ax_phy, PHY_CTRL_3);
+	arasan_emmc_phy_write(ax_phy, PHY_CTRL_3, val | MAX_CLK_BUF0 |
+			MAX_CLK_BUF1 | MAX_CLK_BUF2);
+
+	val = arasan_emmc_phy_read(ax_phy, CAP_REG_IN_S1_MSB);
+	arasan_emmc_phy_write(ax_phy, CAP_REG_IN_S1_MSB, CLK_MULTIPLIER);
+
+	val = arasan_emmc_phy_read(ax_phy, PHY_CTRL_3);
+	arasan_emmc_phy_write(ax_phy, PHY_CTRL_3, val | SEL_DLY_RXCLK |
+			SEL_DLY_TXCLK);
+
+	return 0;
+}
+
+static int axiado_emmc_phy_power_on(struct phy *phy)
+{
+	struct axiado_emmc_phy *ax_phy = phy_get_drvdata(phy);
+
+	u32 val;
+	ktime_t timeout;
+
+	val = arasan_emmc_phy_read(ax_phy, PHY_CTRL_1);
+	arasan_emmc_phy_write(ax_phy, PHY_CTRL_1, val | RETB_ENBL);
+
+	val = arasan_emmc_phy_read(ax_phy, PHY_CTRL_3);
+	arasan_emmc_phy_write(ax_phy, PHY_CTRL_3, val | PDB_ENBL);
+
+	val = arasan_emmc_phy_read(ax_phy, PHY_CTRL_2);
+	arasan_emmc_phy_write(ax_phy, PHY_CTRL_2, val | OTAP_SEL(OTAP_DLY));
+
+	arasan_emmc_phy_read(ax_phy, PHY_CTRL_2);
+
+	val = arasan_emmc_phy_read(ax_phy, PHY_CTRL_1);
+	arasan_emmc_phy_write(ax_phy, PHY_CTRL_1, val | DLL_TRM(DLL_TRM_ICP));
+
+	arasan_emmc_phy_write(ax_phy, STATUS, 0x00);
+
+	val = arasan_emmc_phy_read(ax_phy, PHY_CTRL_3);
+	arasan_emmc_phy_write(ax_phy, PHY_CTRL_3, val | DLL_FRQSEL(FRQ_SEL));
+
+	/* Wait max 3000 ms */
+	timeout = ktime_add_ms(ktime_get(), LOOP_TIMEOUT);
+
+	while (1) {
+		bool timedout = ktime_after(ktime_get(), timeout);
+
+		if (arasan_emmc_phy_read(ax_phy, STATUS) & DLL_RDY_MASK)
+			break;
+
+		if (timedout) {
+			dev_err(&phy->dev, "DLL_RDY_MASK bit is not cleared.");
+			return -ETIMEDOUT;
+		}
+		udelay(TIMEOUT_DELAY);
+	}
+	return 0;
+}
+
+static const struct phy_ops axiado_emmc_phy_ops = {
+	.init		= axiado_emmc_phy_init,
+	.power_on	= axiado_emmc_phy_power_on,
+	.owner		= THIS_MODULE,
+};
+
+static const struct of_device_id axiado_emmc_phy_of_match[] = {
+	{ .compatible = "axiado,ax3000-emmc-phy"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, axiado_emmc_phy_of_match);
+
+static int axiado_emmc_phy_probe(struct platform_device *pdev)
+{
+	struct axiado_emmc_phy *ax_phy;
+	struct phy_provider *phy_provider;
+	struct device *dev = &pdev->dev;
+	const struct of_device_id *id;
+	struct phy *generic_phy;
+	struct resource *res;
+
+	if (!dev->of_node)
+		return -ENODEV;
+
+	ax_phy = devm_kzalloc(dev, sizeof(*ax_phy), GFP_KERNEL);
+	if (!ax_phy)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	ax_phy->reg_base = devm_ioremap_resource(&pdev->dev, res);
+
+	if (IS_ERR(ax_phy->reg_base))
+		return PTR_ERR(ax_phy->reg_base);
+
+	id = of_match_node(axiado_emmc_phy_of_match, pdev->dev.of_node);
+	if (!id) {
+		dev_err(dev, "failed to get match_node\n");
+		return -EINVAL;
+	}
+
+	generic_phy = devm_phy_create(dev, dev->of_node, &axiado_emmc_phy_ops);
+	if (IS_ERR(generic_phy)) {
+		dev_err(dev, "failed to create PHY\n");
+		return PTR_ERR(generic_phy);
+	}
+
+	phy_set_drvdata(generic_phy, ax_phy);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static struct platform_driver axiado_emmc_phy_driver = {
+	.probe		 = axiado_emmc_phy_probe,
+	.driver		 = {
+		.name	 = "axiado-emmc-phy",
+		.of_match_table = axiado_emmc_phy_of_match,
+	},
+};
+module_platform_driver(axiado_emmc_phy_driver);
+
+MODULE_DESCRIPTION("AX3000 eMMC PHY Driver");
+MODULE_AUTHOR("Axiado Corporation");
+MODULE_LICENSE("GPL");

-- 
2.48.1

