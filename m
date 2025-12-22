Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020107.outbound.protection.outlook.com [52.101.61.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532EC3148AA;
	Mon, 22 Dec 2025 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766393154; cv=fail; b=dS6v9kw76hJDKGP4krnX18OkrYg1yh75vCAIJqy8WGislsUjqV/oZs6SjZrqpy0CzsoKZXNgYJBz4z1QOd1bp1ymBn1Qwj4vOaYVOv+/XdOp8Y/9fpqkc6ZUPOHXRCkwynIK33SJWVO1liNEoq4CrDHsmbSsWCNKz814/EGJEiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766393154; c=relaxed/simple;
	bh=MK1toXQSyWZH7a+gxf/LBepcPMLg67gwd+TqPEwdyFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k3dxE/UkyTaFFyTUQBn2PnBvoLW1DdjEJ6i3iGnw1odcuraw6xcqPrwKnVMuDG06t2+pnJbSxXB9W8utuSx9jEiWVm5BQ8FX+Ql7GRLVsxeIF7u6+ztUPCjASoCLUgUMAJmBUpQHhC9Dlr6iOARUz8lb/Y/AhewmDv4bgk8HB4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=W544Z5Pi; arc=fail smtp.client-ip=52.101.61.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="W544Z5Pi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j50qT3qslGwtGRVlLEVYUmziCXjFAW+kfPcsuwN/xnDAvPVdB3HCBBBnWwQfrHM9Lyys4eKgeUq9XfAzUfX/Ns0uTTwuwuo1AcgG8WlNThU0c3LoDGOzEzgbew6bKW6Qh7O5g5j0g/zeJrnUSWch2peez3b0LWb8htvoMe2smGithaGgJsPyf3u5DZy8uqV9BZOQQMGxBl224gFbfxWGKNzT2R+U+t12Vd/s4mHHls06ITNB+WxJV6FbPylOxBqiYMGUuVe+8eKgYZGxKT4dGlEyAqjXjuXFrw+hhefnJcJx7B8USxrl8QIrwSQdHpLj4yLOI5yVAoY/MpWIAgwuGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IerLkQQ/nw3nMBrSS3Zcu1AOev67qbrloMloWMqC6Ek=;
 b=JvYNFOfvDbtTyDxTOusSs0HjgAh59wH9vXJYR7HrwH8u0WShvyW9xx4KMz/zDxDSZR2zWuBEWso1+RU8f3PgWfD0mV3Wiq1TpMx4yBQ71Am9z05hh4F/yFgoI5Y7gAvnPQVGWw14ro4HDVUrRpgBvyQHG74144RZAy+rT6D2hTW2wXxT2xhD9IXTg3KeNhBDltp5XVsvnoSb/jFllVl4FoCN/Vh6GCNKNo9Vshu99u5LpEPxGFk/whAtfAV4Wyl1VhGW5cuVtmjO2f3eazQ0taZTbCRtgTMwwC114aZX1Opt/CoUWloSrpSiStj5hY8Lz13Ir/IKWLPxx2EbgPbrnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 4.227.125.105) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IerLkQQ/nw3nMBrSS3Zcu1AOev67qbrloMloWMqC6Ek=;
 b=W544Z5PiUDIjva8pl77eHnw7/xVHPeS81/NuDIx99B2SSpT9szwriod21JxQuzwmUaDuHV3wW54haF54UW5wjU3ToS95wIq+Ha9mKaGM/8YixqoqJhOZoldFykFUdoetp5gPns/BHTcTteTX51m5h47jj+bMdBl4T7m8GeD7pTMY/o60IzIV0OnQvWDirSlumgWopwSE9aWqYBbZNCBxOv9f/EPF6yFBcMOTO1ci9cTpLUHDlo+XWv49NzNV0v2MwZIl5NDfzuuJsHyLwGFSzyysv2jxIe/5LoOdztVzF+ZnoD2XhsqkTr94kCYISUZtCKwnaPsPGZy+XhbnowZp0A==
Received: from PH8P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::24)
 by SN7PR18MB3936.namprd18.prod.outlook.com (2603:10b6:806:f4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 08:45:46 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::4e) by PH8P220CA0004.outlook.office365.com
 (2603:10b6:510:345::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Mon,
 22 Dec 2025 08:45:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 4.227.125.105)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 4.227.125.105 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.227.125.105; helo=[127.0.0.1];
Received: from [127.0.0.1] (4.227.125.105) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.9
 via Frontend Transport; Mon, 22 Dec 2025 08:45:44 +0000
From: Tzu-Hao Wei <twei@axiado.com>
Date: Mon, 22 Dec 2025 16:45:06 +0800
Subject: [PATCH 7/8] arm64: dts: axiado: add common sdhci host node in dtsi
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-7-5457d0ebcdb4@axiado.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1210; i=twei@axiado.com;
 h=from:subject:message-id; bh=4QvpqKzGZ2O7g3cvJXL9OEQh2AIuK/woo6+ADbOLSaI=;
 b=owEB7QES/pANAwAKAXgQMF3EWvHXAcsmYgBpSQUpyy3ABdDhr8vs4hgpiBMTBxjiiFKEavMro
 YuczTHBoWuJAbMEAAEKAB0WIQSZyWINOowtFmDvdYF4EDBdxFrx1wUCaUkFKQAKCRB4EDBdxFrx
 12C7C/0cg/Q8FIj2ByW9tnFj6PD1oPALEMFmaV0eE+GHrMMCddJQ6VOjAblhRiwK3HnebD2/3PS
 4hNgQl9VNkylfYh384Ay/kxnAUXRErjjXC/2DbZH4PJvMl+HgT8wc4cJb2S24ozwN2uXrW4VAwf
 AonICN8dkId6gNn69XoFWOv04y8k4yeB0tfqad6GGXn4Bw3JkRlgcJA9HUisVe+2GcjYY/0JfN/
 kDerbMnffj4ZFRWZ0B8N5m3J9GY5WSmEBWoShDvbLrbmNSFnXmkhc0N5AgSE9hn6AkI4cMTvRjj
 TKXvx8TZd6E9+Uq4CSioTSQcuNW0tk1uIEx+q4NT5o7idoThsBSupxXa6MJz7bH4+Y7UCt7HrJD
 VDGLFZpgnvIt/ZvtvT9aAuqDhuDQourU3AUNClFqkpZ7/Kh2S4qAZY5PgdYYQEsfkCvV46lgKVs
 6xBmvheNVG3ULyWA41XC33p1YyepTtmheseeG3WhULZpKPpOlv90Cx/l4KSU6OtvBEgx8=
X-Developer-Key: i=twei@axiado.com; a=openpgp;
 fpr=99C9620D3A8C2D1660EF75817810305DC45AF1D7
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|SN7PR18MB3936:EE_
X-MS-Office365-Filtering-Correlation-Id: e0116e45-e634-4e01-9954-08de41367f97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|34020700016|42112799006|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVdwaEkvNmFIL3piSW9MNFF4dGhFbGNsOUIzdzEvRmlmckxoODdPWmFFV1ZM?=
 =?utf-8?B?MDBtakJNVGMzZVlHYjczMmFsd2tXOHJTUUN0YnE2RVR4QVQvODM2MzJuWUdT?=
 =?utf-8?B?NGEwbWJSZUI0V1BBNmMzN1dyLzRPMVV2c0F0M2FJay8wUEJWcythaHViRENs?=
 =?utf-8?B?R2oxZVc1ZGtKUjA0RUFoMFdHZjExR1Z0eWFvMkFNazZaVG4vRnRlcU4vTXVo?=
 =?utf-8?B?bjhzREVhZHptTm5WMklkdW1DdzNjSHo3RlNpN05pbkVDcUxNVEQzWUk0b1lJ?=
 =?utf-8?B?ZVQ5d0RzUEdsOGV6UzIxSzNEd3E3U2NDYVBHUWoweWJoUXZjWDF0dE5UTVp1?=
 =?utf-8?B?S1gyTjJ0Lys2QTh2UGxNcjVlSmFaN1NJL251Sjl5eXlzdVllYWZUbDZQOTBW?=
 =?utf-8?B?N0tTR0VRSHZKTzZNNmVaNWtwV3laaHp1bm9CZy9sK0tnRlltTU4zcXBDck1j?=
 =?utf-8?B?SW5UNjA2RjZQWTBpT0NUMzhFZmtkaTVrMEUzTnhIbnlTaGRmejR5TFZ2TjEz?=
 =?utf-8?B?MDA1MzhnZEVJUTBsNkszTFdyZkFCMkNpQkNuVld0TElIY2FjazBnM3hVUW53?=
 =?utf-8?B?SklHYWFNb21OTTFTemRGU3o4ZUU5ckdBSHN0M1d2WFRnWU1wNVVQVDU2bjhB?=
 =?utf-8?B?eWEra2EyT0lXOCtvbkhaVG9IQ3Z1VVVqQUJJUVRnQ3dLZHcrQWRJS3AzekRC?=
 =?utf-8?B?LzNKWmRHMWh0WjdVZGlzcURvaFdlaS9PNW1YZFlLMzRZMXM2QnIxRmllUWp0?=
 =?utf-8?B?OUdtV1JpZk5vb2hVV1creGs1STFVVjVQcXJGL0JjOFN3T1VuTUJJU2JlRFY1?=
 =?utf-8?B?amJCTTZSc1hDVkpHZU02M09qNkhKbm9UTURmaHd2RmJpUmVDeTM5TVYrai82?=
 =?utf-8?B?b2RzMzdXazlLTEpyNWlIOWNRbmhkRXNFMFowdEJHOEpvcHJVSnpncGxwWnVQ?=
 =?utf-8?B?U0UwYUhBSVp1YWhIelhBMHVtMFBiYU1EbkFwSmtLSGtacC9HZGxvejIxS1JU?=
 =?utf-8?B?M3BCVlloMVZIQ04wMVpod2EzYmQ0RkZmbW5zbSs5UkQzY1NVbzZLS0xCenRu?=
 =?utf-8?B?WThIK1pYbWVQVndDcHIvb0l5d0RpRTBUWitwTkQyOU5JV1BpS0EydHFZUkF1?=
 =?utf-8?B?d012S1dGV3FMSVZma0dzNTJab2ZIYXl3TXJEYzQxb3pMYlRFNnNTY0lTYVhn?=
 =?utf-8?B?UEJoeVBaSmZRWjIrMEVRVkYvSTJIdS9rR1Y1Z1R4QXVSbDRYRFdHTDljTkdy?=
 =?utf-8?B?VS9DUm1nQ25wN3VnSnc4TWdGOXZGQUR6cnN6U0Z4UDNhb2h4allMcGJKUURC?=
 =?utf-8?B?clBXT0hYZ2hzZFArNGdNNXUraFVnMTJ3REFlVTZ0eVVCN2JsYXBsYnplRVE4?=
 =?utf-8?B?dTlQVlpTNS9kblRweXhWUGovVFF4MS9OQUVXOHp2MjVqb2F1M3ZiVE5JWm5w?=
 =?utf-8?B?aUJmN1o3Nm0wNmVFcUFSR0lGek11NWNmSHZoWjUyeVZ0b0liSXB4VUFXVXJv?=
 =?utf-8?B?YVlUdzVYVnhzdDUvLzI5VmZCeDFTNXl3eWQvZjF5MVpaN2pOTTV3bUQ0ejBU?=
 =?utf-8?B?QUY3TGhDOHA1dnlTNUZTQk5xV3EvdTZHdDE1LzZCRzVrRWRuUStNSnFmK3FX?=
 =?utf-8?B?dWs5WjhvaUhQV0V4cDkvOGsvM2hDME9wNnlZdmFuTzVEMWozNUliZE1Wa0w1?=
 =?utf-8?B?NW4rc1pkQ3E0OWIzMEowdWp1VVNkT0M2ZkhuUDJWNkJsU0NRb0pob0tRalVh?=
 =?utf-8?B?eXBOVGRlNUFEUm9WajRZS2J0Tk5oMEVFelZSWXVOVUM5Yi9EVTdIOVBPYmhu?=
 =?utf-8?B?K3VxeFhabE03amRNeEtXVFVjU1VQSVBzTnUycXFicFRFeDBET3FUdTUrcURs?=
 =?utf-8?B?ejkwWCtyNUh0TTZEc3pqNmNUOVl2NTdFblp3bXFPdFZ2RGFGVnZRVGhhSUoz?=
 =?utf-8?B?WFN2STZwNGdSUFFnQ1h0ZzJpU0NERnhXQWJ2WlUrWWR5VldVSS9EKzdSWXZr?=
 =?utf-8?B?UE94VVJSM0NSRmsxQ1JZeWsrY3ZUcXVJT2xKTTRBbGtueWdMVzlpZ3dwbkUw?=
 =?utf-8?B?UlYzQ1JMWDViaHR6NTMrNWR5S3VtVE42ZmUySlFtVDc1WTl1czBxbS9tNlFU?=
 =?utf-8?Q?Xrkc=3D?=
X-Forefront-Antispam-Report:
	CIP:4.227.125.105;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:[127.0.0.1];PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(34020700016)(42112799006)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 08:45:44.8443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0116e45-e634-4e01-9954-08de41367f97
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[4.227.125.105];Helo=[[127.0.0.1]]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB3936

From: SriNavmani A <srinavmani@axiado.com>

Add the SDHCI host controller device tree node to the AX3000 SoC
device tree include file. This node defines the Arasan eMMC host
controller configuration, including register mappings, interrupts,
and clock references for the AX3000 SoC.

Signed-off-by: Tzu-Hao Wei <twei@axiado.com>
---
 arch/arm64/boot/dts/axiado/ax3000.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/axiado/ax3000.dtsi b/arch/arm64/boot/dts/axiado/ax3000.dtsi
index 0b64cf1245211ab0e9380dc27dae37dd9f3082e8..b963537001155d825f878156b2f930b202da1723 100644
--- a/arch/arm64/boot/dts/axiado/ax3000.dtsi
+++ b/arch/arm64/boot/dts/axiado/ax3000.dtsi
@@ -514,6 +514,19 @@ emmc_phy: emmc-phy@80801C00 {
 			#phy-cells = <0>;
 			status = "disabled";
 		};
+
+		sdhci0: mmc@86000000 {
+			compatible = "axiado,ax3000-sdhci-5.1-emmc", "arasan,sdhci-5.1";
+			reg = <0x0 0x86000000 0x00 0x1000>;
+			clock-names = "clk_xin", "clk_ahb";
+			clocks = <&clk_xin &clk_xin>;
+			interrupt-parent = <&gic500>;
+			interrupts = <0 123 4>;
+			bus-width = <8>;
+			phys = <&emmc_phy>;
+			phy-names = "phy_arasan";
+			status = "disabled";
+		};
 	};
 
 	timer {

-- 
2.48.1

