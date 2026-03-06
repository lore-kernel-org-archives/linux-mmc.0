Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010032.outbound.protection.outlook.com [52.101.69.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64CE3ACA5E;
	Fri,  6 Mar 2026 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809944; cv=fail; b=CSAo91UBorRfTGDUUYZIU/Fbs4JWHWph32wE+0wTcUMsYCDak2NqW37B/YGI8dsXQ9Bfs5TbOX2P7576EdixOBBwGpPGbjokmZ3FWApCgXtmbO0NDc5TlRKRuDiEmz6FwCsBichua/lfmoXFboTOkBdn4EHDw8Nyj41u0eMi8qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809944; c=relaxed/simple;
	bh=1SftWJqlanWGXx7KS+SnQyUPxwoMcZLvC24mco+SezA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k7IO46X+90V9fzb7DQqZA/4rQvcGZnxLqBAkJpk5gLmsvfWNBcI4MyvJEmrrNVT3pX+qRHVEW3byXzAKEL80RzrvxCpyDM+kU5ZONQ/lwdAWEWbrfyAtpFTU1J0ljTwLDvdwX2zuxYRg2DvKEdNFdN3geylmIcWWTsaLGlDFJ84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JrsIrCo/; arc=fail smtp.client-ip=52.101.69.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JrsIrCo/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBDNnuKsItuHmyMsQS15XfHIaGHIZxDyP0484a0pvpz22zF01NoFU06UPzBqSgwmlYQ1hXmpDbp5KigtOAeyioh6m3WSjb/H9zV4FqiC0gHo8tJscAmCmYop/LcQhN0b0EDRWH0iE1FH11e0yk8Z1qU7uNT+0XYArnlobVpbtvb8eVJkAOKeT4MK0X7nxINv8aQ3wipkr2cZ4n1OQyNMbDLFIJGYto5byQcAnnDJD0pY5P0AV+0PhUhp3A7XI/G+SOVYRGm0kR07bYiKyS93H9JOcOsUzM5Su7ZgNhHwX/L8iLMxXNJ/BNahhRI0ceSB8bmMX3SWrxIuxBSeYH3N7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWHtS1IvTrW3E2ojdDK9wL3dLyOsGmAwfriZDePt2zM=;
 b=iwM4Oz1P5BZ8yqo69x4dvZBafIxUnVHdbf+i2drXGm64yIJrMZmRtIcEApzjMmwsyFm384VxpEHiAYDDQXFjWs8zFRDREuasIzwW/joNO4nSK0ZRXs9+lS9SoX3/3UMB0UUMlKX16OUivfRt2i61rKxiQTFaK0OeZKJeAkcRa+M+RqPHmhdOjOJoHSv2NQPExuMHBlpp7XN/ZxGTFPzX1ryIRJysE7NRky+w3oiWHUQ59g8nAOo4d+SYDwSQuJMM0rEwzJXyo0hTEdKHCmzuNhQc2Ju/pUlx4sgSdj9NXnQzvmBV130NHYBxLMVK85VZWou081BU/1HqVKEQBRDSdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWHtS1IvTrW3E2ojdDK9wL3dLyOsGmAwfriZDePt2zM=;
 b=JrsIrCo/+D36aye8B9f/SQqj5GqKFjahPfCB2DRy/O7XkFcUQckfEcN6PbggtYFecX2LLjf1hIzF2+D7i5yi7GzubwWmeTxj2gaNz7PSHf6CBmB0ZSpVI7INWVo+iTijGLxkPxZpZH7giFMH+7Cx+qqmzeMmeweH/dHKfN2tvYV+uZrpuFSWMD6F4At5G8By7HGZlwporqzcg9Rd9vprckugbhAkPA2PO25vEfi+LJtvK8ycbkR9FBqZKLwfqsmfvMnBhFTGklImGk4Tz90naIw/3luof5EO+HTkRFhn4fW2HGEsSeYzsMkPpPcc3ShicoQdxzjX2jCUC5kRkFFg2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DU4PR04MB11908.eurprd04.prod.outlook.com (2603:10a6:10:61c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 15:12:02 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 15:12:02 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Andra-Teodora Ilie <andra.ilie@nxp.com>,
	Andrei Cherechesu <andrei.cherechesu@nxp.com>
Subject: [PATCH v3 8/8] arm64: dts: freescale: Add NXP S32N79-RDB board support
Date: Fri,  6 Mar 2026 16:11:47 +0100
Message-ID: <20260306151147.24446-9-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306151147.24446-1-ciprianmarian.costea@oss.nxp.com>
References: <20260306151147.24446-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::16) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DU4PR04MB11908:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d97ea08-8faf-4fae-2455-08de7b92b865
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	N90uhZOXx12/DnUwvsLMLt8sJSTSJXVR+F1z9FIRNVwQQLikt6DhfhymgEv1E5X51e0RTOL3slH8nvtE2XkuUt8YMQDP2ybrivaqJQ6fLMOoh7CONf7VPfl7b8DU3cVFkJtE38SfQhsJ4MR53NCqdD2EtCzfQ0ig3OpWdNpQb7Bu7BMfpqQhCmvMIPJutUEhhrXupQTTFRIE0LdFgDlWkIsxkGnc4eZE4NkOzijXQLVrBQQ7JRzD2z/7/QFXN6389b4gpR2/fTyB9tdER7rh4/AXczhIuwobXOe6s0PkkcxyWVwxOldh5C1cNs9x/B9nb/QhijoKeuOtb60BxTTyPYZfFc8Fpv3d1gWtVTkLhSNzF9WOBnJPSaylqZvzG8uoJGVgB2rrnVvGTlQsAQ0vhTfvBzwDVj/LYW7+ejMWezvtc+r4ih3s8hd0/B/49mmyFzBLBPVZoT16Ljt9HO+b9JhX63/bxduztcpz/YWPXBRH8ns1IrF7RBa5augOGx3Xl7SnkmLv7nr6ubnPPOg39Y+EDUhc52MrejjLeYoCq1HhzvA8qCaOLCQkKOGlbqH+w2HgbpvRDLpeKXQ5mt5vmNlqG0rwPNnAUXnTof2X9ZWjjhPEhW4yxIjz1WU6P8wXj5WxdWuAV+AFxMLLcWDOAuQMM5k+2gcfO/PYtSjLJbWfF+05LVPMU3/bO/dmBl3m6o8QGmLB7+DCMQr4C3aMaJcEiee01LFt6bpL3fJMOtY8+l1TwuIEgHxHzfJS0pgyRKABgcqIbmAU60HZMnvy597oMVTEhlv1o+sDcv4ISVk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEJFaERzb01PVEtLL1dVN28zenFXYmc1T1IveityWjNnbFpoZlMzbmpKTjdC?=
 =?utf-8?B?MlhpOHdPdmNQVm1RM1BmTS9HVG40VnZheE1TcXgycWpUYWFQcERRa0crTXJL?=
 =?utf-8?B?MlFYWDI2OHFCNW1vRkt0eU1nMjZheUNNbUJ1WlRLa1lvL3BYeDIvb1RrTzRD?=
 =?utf-8?B?TkRUUHpiSHVNV04xbTFOQTlwWHNQK094U1AxamlNb21nZDl1dXZJVlhFUUZr?=
 =?utf-8?B?R1B2TktqRFVjTnE5d0NjUkxLamp1ZFlPcFZTZUFyR1ZRSDVCVnlpdllzZVNy?=
 =?utf-8?B?UGNMdURrY2o1Uld6OHM0VFpDb1F3cG51VkZ3SWFWQTdTKys0cmZQOUdINldG?=
 =?utf-8?B?dmQyOFR3Q09NZzc5Ym1LdVVNbGV4S1lFclVSblk4dmVCMENMNmlHaDdjUE5v?=
 =?utf-8?B?d3RPU3pWNVB3bnc3MFN0QXd3dVBMKzV4aGkzdloxVEFkM002OXljVElZdjNx?=
 =?utf-8?B?bTJ0Tmk3dFpiczAxUnE4ZHhXcTZnNy9JVkNUNzBvb0pWQ1RiVXB5MmVMT0ZI?=
 =?utf-8?B?U2RvM2NidVpYUGFZVkVnYStRTmRjUmF5UUlLbllFTjIvTmY2ODJUNGhLbmFh?=
 =?utf-8?B?YnpSMGNnVFMxb28xMUJBbDhTY0RUbWhkK3JzTUpFTnBaUkt3WTFPWk5oQ3Zw?=
 =?utf-8?B?bmxPQ1FpRERyZTdIK3BDS0QweUpLRy9RVEUvZ1pYSlB6cFFjZGFOWEllTnRR?=
 =?utf-8?B?VElPY0g4N2N0ZGJQdS9UTnRyd1lTUHRpTE1mZFNvNHZobUlaUDdzWTZaTW43?=
 =?utf-8?B?SnJPQklHUTNaM3NOODRyNkFSUFBScnBCSkc0V2M0cXBSSDhJMnF2MC9DRlFv?=
 =?utf-8?B?MnF5WU5IUDNrTGRWVUthekpYK0JUMTdoRTZkQjY2ZENYbmRaN0dPTyt4UG1Z?=
 =?utf-8?B?QVJ5N2l2NEViaDZrNWR0c0xHQkNNSnpGcVB6Uk10cHE1Q3ZEbUJxZGhCUjZB?=
 =?utf-8?B?OXZSQjd4VTJRVTdsUXBWREEyUTFvaEF4cFZCM1JNcCtQWmVnbng2dXp4UjJv?=
 =?utf-8?B?bzBKZERXc1BQNGJJSVg3dlozam83RTJYMWVXdGtTM2RyaEdoSk9IUFR5MlhG?=
 =?utf-8?B?WmZaci9kdFJ0cXF1Nm0wMERFeUV6bHczd0VBMEo4THdPbHd5NVR4eDc3c3N5?=
 =?utf-8?B?ZkhGR2ZpRjhFalk4WE9hUVBIVld5Rk9STElCd2lLY0x2RWZkNTZTeHU5a1Qw?=
 =?utf-8?B?emVJK3JnTWtteStEK1BpT21MZUtMWVZvd0tOTGIzTklsMnl4NWp0cWlUam9D?=
 =?utf-8?B?bUlQM0R1S3N6UHlPZ1A2dGxiVnVZRjVWcldZRTNGQTFFOXNUMFY2V2VGd0Jv?=
 =?utf-8?B?UTJyeFNlN3RiSklTcmhlVjFCRDQzQU4zanhJbk9lQzFYajBqZlZ0UHhSVWFM?=
 =?utf-8?B?ZXJKRlJ2d2htaDBUd2tuZ0ZYTS8xSGlPNnpBL2kzTEN3SWx4WlRyaWlpci9k?=
 =?utf-8?B?d1dTRnEvcGZRY2xmaXBDSHdEa3NxL01UN2ZYVm42T3poZGRJU08vcnZrMzRT?=
 =?utf-8?B?dDFiWk9tWTZJQlZ2ZDkrVjVUbzYvczQwM1laZHd0MFdQV3FUQlZWcW5QUU5V?=
 =?utf-8?B?UVdjakczMHJqSXBjWGpvci82V3NDaEYxTU9UTjNlYm1VbkRIakVJRXhZQ0xT?=
 =?utf-8?B?aURpNTNiOGtJV1g3TmNkMXl0WlVUYzdFVDIwVFE2dzlVZ09DWnJ2RTNwSXcv?=
 =?utf-8?B?R1piRnQ4RE41aXpWRHU0ZU9nMmlVeFlTdGRNdEdNNXcyRFBmRldESDN5Vk5w?=
 =?utf-8?B?eUJYSHJELzZ2SmhaQ1VDRzMrdmU3VkxicU5FSU9rWVlFajlHSld4aG1mUU1J?=
 =?utf-8?B?cHRiSWd3NEVJMlBQZXJsVDF4Yy8zTjd6dWdsSVRVMk1PZjg5NjJHaWxmek9I?=
 =?utf-8?B?QUdLak4yUkhSVW9wU1FmK2tMWUwxLzEwQ0JLdUQrc08vZzEvMzZXTWFaRTBC?=
 =?utf-8?B?elBUeE5GOE5sRk5kV1MwM3VqbU9abCt0MDRJU0ZESVFCbHcwbE1xcU12cG1P?=
 =?utf-8?B?QmZpbHhpSGxzSEpycndzb1JnWFNYWEhSemwwVnU1cmdiVFhDakIrN2Z6YWJ0?=
 =?utf-8?B?VCt1Y2QrcTJ5V2NLTEdpRVdsRWZzUHF3TitvODJPTTVvM3pEc0VUSDhyWFRj?=
 =?utf-8?B?bUdqeTcveWZPbEx3UEVETHh6dkozZmV0QU9OZ1gvOWFrdE85QVlRcVdwYzEr?=
 =?utf-8?B?VGM0NWJLUklwajVjQ3JhTXJrSmtqVTJLSVRpUnc2aHZLQjdyYldyd2dwZWoy?=
 =?utf-8?B?Y3A1eHZEOHQweEd0TU15MWNESHFQWU10N3ZOYTArVEQxNVFrcWpycmNlc05X?=
 =?utf-8?B?eEVXL01XdklTWWRZbE1uQ3RaYi9US2E4bGZtZXpDa29MZzlJR2RGdHZiSTdn?=
 =?utf-8?Q?YtJ1HshHKc5EgYuw=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d97ea08-8faf-4fae-2455-08de7b92b865
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:12:02.4440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXXwYBnmOMajivWoPmP17KpsNnsOQG0/e9HEoVPazO9h4oKaRSj/a7sHXCsdesNQ3AHdJfdTwo4JmgxqBVT8Ghhykjvtwm9g8W06KnY8eLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11908

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add device tree support for the NXP S32N79 Reference Design Board
(RDB) [1].

The S32N79-RDB enables the following peripherals:
- PL011 UART controllers (uart0, uart5, uart6, uart7)
- uSDHC controller
- IRQ steering controller

The board has 32GB of DRAM memory with 28GB usable and 4GB reserved
for ECC logic.

[1] https://www.nxp.com/products/processors-and-microcontrollers/s32-automotive-platform/s32n-vehicle-super-integration-processors:S32N

Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Co-developed-by: Andrei Cherechesu <andrei.cherechesu@nxp.com>
Signed-off-by: Andrei Cherechesu <andrei.cherechesu@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile       |  1 +
 arch/arm64/boot/dts/freescale/s32n79-rdb.dts | 70 ++++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/s32n79-rdb.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 700bab4d3e60..e79807bf1820 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -501,4 +501,5 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-phygate-tauri-l-rs232-rs485.dtb
 dtb-$(CONFIG_ARCH_S32) += s32g274a-evb.dtb
 dtb-$(CONFIG_ARCH_S32) += s32g274a-rdb2.dtb
 dtb-$(CONFIG_ARCH_S32) += s32g399a-rdb3.dtb
+dtb-$(CONFIG_ARCH_S32) += s32n79-rdb.dtb
 dtb-$(CONFIG_ARCH_S32) += s32v234-evb.dtb
diff --git a/arch/arm64/boot/dts/freescale/s32n79-rdb.dts b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
new file mode 100644
index 000000000000..1feccd61258e
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright 2026 NXP
+ *
+ * NXP S32N79 Reference Design Board (S32N79-RDB)
+ */
+
+/dts-v1/;
+#include "s32n79.dtsi"
+
+/ {
+	compatible = "nxp,s32n79-rdb", "nxp,s32n79";
+	model = "NXP S32N79-RDB";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart5;
+		serial2 = &uart6;
+		serial3 = &uart7;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	reserved-memory {
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		scmi_shbuf: memory@93000000 {
+			compatible = "arm,scmi-shmem";
+			reg = <0x0 0x93000000 0x0 0x80>;
+			no-map;
+		};
+	};
+
+	memory@80000000 {
+		reg = <0x00 0x80000000 0x00 0x80000000>,
+			<0x88 0x00000000 0x03 0x40000000>,
+			<0xc0 0x00000000 0x03 0x40000000>;
+		device_type = "memory";
+	};
+};
+
+&irqsteer_coss {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&uart6 {
+	status = "okay";
+};
+
+&uart7 {
+	status = "okay";
+};
+
+&usdhc0 {
+	disable-wp;
+	no-sdio;
+	status = "okay";
+};
-- 
2.43.0

