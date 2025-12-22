Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020106.outbound.protection.outlook.com [40.93.198.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CAC311597;
	Mon, 22 Dec 2025 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766393150; cv=fail; b=WO0VLEa3u4ii7jfSQNquMsKsM7ufyQOiHcnLmLI4vB69Jktc+nyE+qzR+QYFf/+LaVRp8Vu5X40LVSs/TepJIle8iNdsx+O7XI2OGGjhDZStHDV8WK9Vg75k3zNP78TQ2onN0lcTGtWBtIXPye3lmbjzJlcc1tIfx1zg99uoNnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766393150; c=relaxed/simple;
	bh=nzO2+u99Xvn7Y/Ig5C8ohzP40POjDs5U7BJeFj3a3kY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t/zIdKH6FObdI/1Eyxr+evA6R6dnSxx6lzX8NPB92KlIy+nmGsRo9M+DcUhAQQi9KzD2TzdqpqUNOHeGBhBNfRblnl6ezVP+TSgivxZDFknt/vvmvQYqhoz5hQT6oIzd5A4iWgvysjMw2CnFV6mic2GNtwXFxVVbqyXVdqWXxag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=R0yC2PZo; arc=fail smtp.client-ip=40.93.198.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="R0yC2PZo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pW+ubs0J9lzCOtFUfhSiSe9BleOxT5ZmmaCSTogrgGMRkXEux+GdnfK85bczHbale9POB/iQondQ86kv39QN+Wm0SH3145F+BTvj/tPjmwSJvmJZFEcgBfHicTicpNyiqrLprNdtPVQ0q9ZNdngI79swVdeHPJiuUObRQYHaf/tgdwcyPyiWrBw10MajqF/KD3B8k1P+zNRK7Nszy7Tk6sdO6ShZOAD3fiAbsIbP0ix6lkyBl9Csns+z8bkRTV8VAWYv3hGO3NZx387NqjcxbCaGsBN/B0wbQXHp8iTIBwm57T6dYGKccGs1tU00d0PgA9O8ee8iQ8tMsM3PcNQrEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBxITn9WwBIGZfX5X7R7GsPeshLsiLtZcc2MmzO3U14=;
 b=ZIMAX6wOZg9FNc5omWvGVDGrC7mC225G88o6DOxFyVvMSPRFtEAsyKWreL8CdbTjURg5zVrH+jNkiH2nE/KGkKr5n/FB6A0aXLv28VPnoRyt+A4LAzhq16IdSM95jtwEur6wkcouxFahG1qlS0LHsVzyVo0Wp2aEVEcAZJ0BGSIhdw7nJy3wkR3BHksb3BQYV1KVOb/WDLUsI+XquV267Ar9stPH1hRf9C4YPGXVUNKsg6Gldq7UoukysqeZaBpGgC0I+ci7RLqowN4M+2leB9B+ptTs5LCAdVBCqxnLMix4A2E6E7pZm9OQm4pR1iPNnidk4xdKwmN9gBoJpJfx3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 4.227.125.105) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBxITn9WwBIGZfX5X7R7GsPeshLsiLtZcc2MmzO3U14=;
 b=R0yC2PZocoVzONzrj4F2Z4ys4pOHQK1Tk3oiIVpjnMc30egFsdWYd0U3IbKGs/RSivrDbmuAme/6QNB5sOQyYDoO++WoohTBAiI9uXitH8UR9s/mezvBNkpCBG9M8F3KZSsloVBty4FUiCZDA5Xus9QGAYNPFrd93QmMepliUc4P9SmL+MnmWoYi0kyL4bDoKxD3DyROkmDLYP+WvsJrXROeAf/hyiJk4ncs9fJHD96U4dH25Du1uWMkYHCc0XlCCQ379ki10JmkPMZkPmF+uuhI8bBrV5NsztcT5BPJp6OG6wEa9mS3o4Wd5RpoIPymSSXhjbSR/aurihICMvSCLA==
Received: from PH8P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::26)
 by IA3PR18MB927557.namprd18.prod.outlook.com (2603:10b6:208:544::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 08:45:42 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::60) by PH8P220CA0016.outlook.office365.com
 (2603:10b6:510:345::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Mon,
 22 Dec 2025 08:45:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 4.227.125.105)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 4.227.125.105 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.227.125.105; helo=[127.0.0.1];
Received: from [127.0.0.1] (4.227.125.105) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.9
 via Frontend Transport; Mon, 22 Dec 2025 08:45:41 +0000
From: Tzu-Hao Wei <twei@axiado.com>
Date: Mon, 22 Dec 2025 16:45:04 +0800
Subject: [PATCH 5/8] dt-bindings: mmc: axiado: Add axiado eMMC variant
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-5-5457d0ebcdb4@axiado.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1731; i=twei@axiado.com;
 h=from:subject:message-id; bh=jKwc5SkNl9g1D3wY/4i0cZeG1APZTBh79FsFD+zqKNU=;
 b=owEB7QES/pANAwAKAXgQMF3EWvHXAcsmYgBpSQUo4TUuEy/bvSnNkRCVp9CIUj0Erg15KQbJz
 vVWgsDt7weJAbMEAAEKAB0WIQSZyWINOowtFmDvdYF4EDBdxFrx1wUCaUkFKAAKCRB4EDBdxFrx
 1y2HDACRdLsc91r1OojL2ZnpC1yRYSHRdtP3TbCegyIpZj8Wo0IFKY17dhNi8rj4dcngzabwuOG
 iC8HNVP8+tUAA4xuLoYi/tkNVR6FWh8rtORpO8ze7TwJgsgxB/C81O5xQQj8YjOhzHlU5x0ufsf
 zY0dJLtMkVzscXGEKroUtgBVdfTr5kES9FLNOjd54oGmpK5WT/BUzzy07qRCMH63cB+0SkaNGkc
 GWf6+l4DQ7fRZXljT52pfuMAug2hlOmgenxoPnbgIHRWDxVzfXSDLNjpDQLkLIo6LoLDoyiJFqH
 jaQor3/cIBE6ifcUlXP0oqQ5sV9gBkatwzZDHYjXoaj6qk5GK1GVjnKXP2XNEHuE+V82Fi+oIwm
 N8lewxsPZ6rF6rMrw1P6e6Vq7sZQ2ysZj4JWA0cZ6OOMm/fzZ8aIg3qeJS2Rlpo7kdMMQN++zU5
 KpLSQBkxLu8HAwtdpzgli1kzVoO917W0JS+44x3FOkXmgKXZh23TAlE1EJzvDGgB2lPxw=
X-Developer-Key: i=twei@axiado.com; a=openpgp;
 fpr=99C9620D3A8C2D1660EF75817810305DC45AF1D7
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|IA3PR18MB927557:EE_
X-MS-Office365-Filtering-Correlation-Id: f3125078-c01f-4b21-a21b-08de41367d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|34020700016|36860700013|42112799006|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WW1OeHpoR1BTQk0xTDFYSlFWZWhWNmp4NFB6bHRrUlAvcG9UcEFOM0EzVFN5?=
 =?utf-8?B?S2lIQk5DeTF2VjFVcTZ3VXl4NXZhTyszYWNYTjZvbW9jT0lWZG9aOFRPL201?=
 =?utf-8?B?Q0tnaC81ekd4VEhjWUQwUDd1amVWQ1NpSnZSRWFXc1pwZTlqNHJ6dHp2S0M3?=
 =?utf-8?B?cVhUOVQvZkF1RkNCVmkvMkI3Mzc5TGJhd2puK3NveXNlRnphYzVnQlkvN1hJ?=
 =?utf-8?B?c3pSck1lVllNTGZJUXNiQ3pVZlBiRjhPUWZReEkrQ3dHczFzV01wdDlxaWZ6?=
 =?utf-8?B?S3BQTWd0MDVzRUJlbk41MHBVQmdIbjhZUFdjVDlFNW5qb094US9JU2JPdkQv?=
 =?utf-8?B?QmpOaEtkZlVCM0h4VUdPd2VLVkg0Q1VLZnZCL29lQlhYVXUwY2lhZjdNSm9p?=
 =?utf-8?B?TWw0ZEpsdjlxOW5VUFhsUnVFOVE5a2lqTnFzS2owZWhwVktWY1ArRnAvU0dC?=
 =?utf-8?B?Smx1b05tbG5xSEVYRkt6YlB5Yjk0dlJISlM0cTMrWlFZcWY3YktaMnc3bGZh?=
 =?utf-8?B?N1pidHgwbTR3Q1Z3d1BoYjlnZStyaDNXNkhRTVpuUC9NTC9FZ1ViVC8xSXp2?=
 =?utf-8?B?YVNRNlVidm9saHc0cU9mcEhFakd3VDk3d1pEWUNDSnRNUG5nTFc0djVlS01U?=
 =?utf-8?B?UFYxMFQ4UExhRjFhTS9QSGh2aGMrQW02OFlUTnBkVkRsVFcwR2oweGxVWHBX?=
 =?utf-8?B?ZjA3aXBCNzQzVU85MmlOenhRSStDOWZJMFNQZStkUWhQNHpsOGdlOWxuOXJn?=
 =?utf-8?B?andnR1hhaVYxL2lBY3k2dnVKNC9aK09NNHVnMThZTHkrREoxRzdnOUZBYmVo?=
 =?utf-8?B?aEFXRjRlUHZ0MEZaSDFqY0d3MHh4bGlqTU1nQXA0dzhQWS9ieGw5c2RrTzFT?=
 =?utf-8?B?YnVrTjdmT2oxZ2hJYWhHV2NxQlZBWHVaby9menpmZU5DOFFQSEd0enU2dW5V?=
 =?utf-8?B?eDBLQStXREF6WWpCL0VZalN0dmw0eXY4SUx2V3VZSTFqMTRYV1pTUUMwNHdS?=
 =?utf-8?B?dW5oTWNUT04wV012blpLWHYzUXo3aFE5MFNtbzV2K0M0dXFPangzdkdDWWYz?=
 =?utf-8?B?UWloMWxaMmdOWmNZTkc0WnhCcmVYNnNEbFBPcG41S0NEMlpUbTkxbkxjdTk3?=
 =?utf-8?B?SmFmUU9scTNmYXJodFRka3ZqdkUyckJiZFJUQVUvWDluVGpuaDlReVUvc1hR?=
 =?utf-8?B?c2t2ZHNSSEZUa084cThyZzdtZTA0ZUE1MXdsYlBwVWxOZDhCeS90eEZ3dHBK?=
 =?utf-8?B?dldGa3BVRFNWNlM4NnBaMWtkOWwwenVKemZ3L1pMWUZQS0d3bk9nUStETmVv?=
 =?utf-8?B?Zk5uOUVKOGNsU0RBMk4vblJDUXozVGxSUWdxbTQyV3d0LzlMNUgycFBQSHBX?=
 =?utf-8?B?UjBsU0tyYVVFTTdOV2t4MHNWaWRYV095djg3MFpRSU5Cc3BET0JQK0xhUVFM?=
 =?utf-8?B?YzhYRGJqenhncFM0bmRyZjNSS21kaHpKcFhIUGlENWg1OTdySnRUN24vd294?=
 =?utf-8?B?ZVFpQ2EyMmZkSXpNaFFzYlVnbWFaYTZGVVNpWmF5QzJ6L2lRcW5YQ3RLV3hG?=
 =?utf-8?B?TkhBbWFIM2pSZzZCQ1V5b2xSWmZKOXN6Q0NyK3dGSUJvSlVMR0ZoWkYybGlK?=
 =?utf-8?B?T01uZTNIR3puRmdmaXF5Qkd3NWZNL2RyQjFUYTluR1JoUW1vS1B4UGtNblZH?=
 =?utf-8?B?bXZxc3dSM1kxWkFEdjdaNEsxV1hyVTVzeVg0VS9DcDE4QUJzS05QRDVnd1Rk?=
 =?utf-8?B?RE1jSzhVbUMyTUhPWHNOZi83c2M5U1pRVVdIMG1GSnhYNTg2L2hNNzI3aUdt?=
 =?utf-8?B?YzlUZFFmNVFOZHB6cno0c1IvZnBwUTFJeTAzek9zODdYN2NIZURXdWo2REV5?=
 =?utf-8?B?WTUxd3VkOGNYQmZMdWZocVAybjYyWTYxY0dRams5am5ZUzZaeDJCWm1NazJR?=
 =?utf-8?B?Mk0zUTdvMjI5MDA5eHBRS1hLd0U2ZXhra3ViMUh3dm9yanlZZ3l5SFlVczZ6?=
 =?utf-8?B?Ukk4OHovUmQrSTI4WEY0YjJJb09rend1S3VqQk44ZU9JbFFZTGNQeVRUR1lS?=
 =?utf-8?B?c3NKYk8xWEQwM2RRSFo2aldNMkZCVGowbjRlVjE5RGF6SkxEV25DUFNQUDRI?=
 =?utf-8?Q?uO76/37K13qJALnxo2aEmVB2S?=
X-Forefront-Antispam-Report:
	CIP:4.227.125.105;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:[127.0.0.1];PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(34020700016)(36860700013)(42112799006)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 08:45:41.0771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3125078-c01f-4b21-a21b-08de41367d58
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[4.227.125.105];Helo=[[127.0.0.1]]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR18MB927557

From: SriNavmani A <srinavmani@axiado.com>

Add device tree binding variant for the Axiado AX3000 Arasan eMMC
controller. This variant identifies the specific eMMC controller
implementation used on the AX3000 SoC and enables the appropriate
driver configuration.

Signed-off-by: Tzu-Hao Wei <twei@axiado.com>
---
 .../devicetree/bindings/mmc/arasan,sdhci.yaml          | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
index 8e79de97b242a698a2c555b0b94e2975b1761710..47d0e35efea00bf7b1927bd0cfa39c86f0137d44 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
@@ -106,6 +106,12 @@ properties:
         description:
           For this device it is strongly suggested to include
           arasan,soc-ctl-syscon.
+      - items:
+          - const: axiado,ax3000-sdhci-5.1-emmc
+          - const: arasan,sdhci-5.1
+        description:
+          For this device it is strongly suggested to include
+          clock-output-names and '#clock-cells'.
 
   reg:
     maxItems: 1
@@ -334,3 +340,15 @@ examples:
                    <&scmi_clk KEEM_BAY_PSS_SD0>;
           arasan,soc-ctl-syscon = <&sd0_phy_syscon>;
     };
+
+  - |
+    mmc@86000000 {
+          compatible = "axiado,ax3000-sdhci-5.1-emmc", "arasan,sdhci-5.1";
+          reg = <0x86000000 0x1000>;
+          clock-names = "clk_xin", "clk_ahb";
+          clocks = <&clk_xin &clk_ahb>;
+          interrupt-parent = <&gic500>;
+          interrupts = <0 123 4>;
+          phys = <&emmc_phy>;
+          phy-names = "phy_arasan";
+    };

-- 
2.48.1

