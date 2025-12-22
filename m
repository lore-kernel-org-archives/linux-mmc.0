Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022072.outbound.protection.outlook.com [40.93.195.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F68330F94D;
	Mon, 22 Dec 2025 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766393141; cv=fail; b=joSf3JLr+me3CFHK9Kz9jc28CcphMstbNiPFPahzFpI8tOVv7Vwsh+o33BF5ZCuaxzpife7H9uIIlL6RkBRaUqpSPzlFPVXcxAyNkfoKCn0+HR88wAcJ6ryx1gY7dlL24A8EGnJrmAdfcJZs95KW7tv0TAXX/3FZhmNBycDUvy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766393141; c=relaxed/simple;
	bh=WQSux9BqRIs4T98HzQLnrgfuEu3LBeJLzt6qoWv+WTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DzlApcLl506c/xajoIEdp+vJiNHVhwArPDQgxN2ckVhLV/5dpXtHTaksMw7aJblR8S/DXcNs94gV/KQ5pRcJ02wZJ1kzuKGodIDel/1YDrBtFP93ud79KGsnadFd83VEL5mZvmlpf08QWswtRewLi2UqKNNr5yJTBMKiMp6aCsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=uf/juOil; arc=fail smtp.client-ip=40.93.195.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="uf/juOil"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7AC/fTs6YwFmXL7LT25LR3CUutWzQEDFTgLi7wxNzp5DMkvWq1DvSFgv1sRRJ35+RRuwBMFxBdS3soGRdvYo2NHcMfWvHF0501U1yAiDdGunYVLiNXaacJMaB6eN1V9v9n4erSuWUlTnvu7k7V8onHFAc44iWgCRMjpZyCyZCFZ1bDLEAfJLwE05J4kSC4ueGHWVXNpmTR6LOmmOMLfNYZdsu+tfG9IZ40ImYP35BWHYChcAQUMIvqsvEbCSkjZekJyTdCxuWsac/u3QAqGax2HAlTCKR7xtkbzhk6LVCL+G2mh6LN70QxyKQUjnVS6EZWtH5H6YeG+HwRoBAAlyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zb5MlTi0cWCnPV79md8nZ03MSciBFUMXTasIL1QUF1Q=;
 b=wCjZsRSXC4ISJ6MYprcUotQe+eGCbm656x4HRcsUfddOiaZ1vZcnaCEADCtF6VFmbO24KGMRZgi8zm2gkDaZoLNv0BS8OcOf0tlfqXgAsAP2RR32m6Jwxn3s7buHzOP1BOM+vTiQdCwpIV3+vmdAOFy47GaFCUZOqgmfDbzf2CxfHZyl7DtTYWBEReV1mspGZd5k4pNHayWfazW9p+lCqtZYiVeoERBqVzYiRQkK/HpCX+ZLIXJYtLCPLEp3IfuvblVF+ybfPh6fz7hseQl0cUIo8/ju5yLlvxmce9yn2dwKvju+g9WOlptBfmLFv6ZgYE6hwDf0e+Qr30/z/JYiWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 4.227.125.105) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zb5MlTi0cWCnPV79md8nZ03MSciBFUMXTasIL1QUF1Q=;
 b=uf/juOilb7o22XJtv6UpFTy26VxAhWlN3EtC6LGeDmpfSsyYx+OKeFgIx84+05uxjU3VjwdXnMfpftvHtVxo/XBWw58af1EIEhBkEhpXDUdwcFuPmfrLvVFm1E4kx1Qm1Cc/tTVqWo8I5Fl43PHJG2ptzsfpGQIXNouDdiqmAo2ZEd0ZyFda3eX22IfpLWjcTga1RpeUfXu6338JuUgDlEHyTSf52bGYgr/xDZFFo1I9FP5tVeJJF0CfJ7wtvJ+GJpue/DBPddvUdwICVOUL/BBSkK4TZq/FwplrLhErUbTXJv3LpQknGHIfj3YyUPUJfMRbhNdXEuphYRuRijhNKg==
Received: from PH8P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::22)
 by PH0PR18MB4391.namprd18.prod.outlook.com (2603:10b6:510:49::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 08:45:34 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::41) by PH8P220CA0007.outlook.office365.com
 (2603:10b6:510:345::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Mon,
 22 Dec 2025 08:45:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 4.227.125.105)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 4.227.125.105 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.227.125.105; helo=[127.0.0.1];
Received: from [127.0.0.1] (4.227.125.105) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.9
 via Frontend Transport; Mon, 22 Dec 2025 08:45:32 +0000
From: Tzu-Hao Wei <twei@axiado.com>
Date: Mon, 22 Dec 2025 16:45:00 +0800
Subject: [PATCH 1/8] dt-bindings: phy: axiado,ax3000-emmc-phy: add Axiado
 eMMC PHY document
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-1-5457d0ebcdb4@axiado.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1865; i=twei@axiado.com;
 h=from:subject:message-id; bh=hBiMYJvZq4y55xF4RoVb7Xw3tm/D9svFChvpZhMXZwk=;
 b=owEB7QES/pANAwAKAXgQMF3EWvHXAcsmYgBpSQUm4VnMo1vHmqIZIzp2zcJa3O3NzFNi54zyy
 wA5QXCbVJaJAbMEAAEKAB0WIQSZyWINOowtFmDvdYF4EDBdxFrx1wUCaUkFJgAKCRB4EDBdxFrx
 1xyyC/0V0qIzH4Dqy6qo+fuYk8HOtU/QUqq2WzqiyGhJxLXSzuiVTyvLgigOK9j8r+sFdw5KbFb
 dN8K46OJKK5ib+1qbYW8XhnmoD3sQFqcYGa6uCAjGkqxAKBgyAdS4sD8eHUq8eb1zstdMpfQIU/
 mSJyjWAdlf+E3gIOLFkxNESvQU+hMwbNbQcd5xtqRaFtaPfTBEUKq1j8AErj+5AjjjYTXggH+VS
 YQCw4PdiNpf8lCnImGIvuEOH0FZI3b3fvB4g/89uQr72uRECJEeDU+cIqkyMvbn99LjoJBwZSIf
 9oQeDPq6ktntjpTi8aKaRJJuznNC9ECFdFE1aNMmOt0cD8IV8QFnx8G5DMOgg61/7QlFwc9JPAi
 qwsyHth6Q35MED/tx5P+Gkf8eJHyimb49Bv7z07bYcyBUCLGgFOhhRKD7rHRK2m3zsNCVNS5tqp
 PG8oj27ruEQfL/0SmrhyhsXwpzhJJF+PIlkJVXdCEma7JJc2titgckJIbx7fTTR1MaBr4=
X-Developer-Key: i=twei@axiado.com; a=openpgp;
 fpr=99C9620D3A8C2D1660EF75817810305DC45AF1D7
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|PH0PR18MB4391:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f1083e3-0d73-475f-6640-08de41367888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|34020700016|42112799006|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjZ1YXVWbytsM3I1bXAxVm9YS1Y3cXNIOVFJQkhmNjQzZW1SeHI1QUMvdldW?=
 =?utf-8?B?RUh1YjJHbUt5cWczNjJpVm1Od3BRR2l3NG1veThXUHpBZHAzWFFqQXF1bnR6?=
 =?utf-8?B?Yzh4azlkMWZKNENSeDIvUHdnYWZUQ2d1M3RvSitZbFJhMFZCamlpQmdia1pI?=
 =?utf-8?B?bDh3SGRSbys2bkd6VmZZUDBUcCtmanNnMTFVQm9wL0xJVi9mbVgycFNPenBl?=
 =?utf-8?B?MTc1dEZ1VkNjSVVvaUVUaGNWZWhOdytaa01MOU1IOGVxYXNTeER2ZUFUT2pL?=
 =?utf-8?B?bjZwSlE1cXgrQ01jUFJzcTQvRGNHTDUyMlpGRndBdU01V1hwRHoyTEJQY3RV?=
 =?utf-8?B?eHZSVUdiMmNQU1UvVVFteFV5QmE5c21ua21jVXVzRHlTWHQ3ck8xL2xVdW11?=
 =?utf-8?B?MGY3ei8vV0t4akx2TUx5dndZMFlnWDdOUXlqY1NkeTZwL3p4S2o2TEpaUnQw?=
 =?utf-8?B?UnR3cnlCTml1MVN3SnpMdkVnRzlBTEc5SE5RVzBML2pTTEwyZnlZdDVqM21y?=
 =?utf-8?B?VFQrbFFpZUg3UUZFUVlyNkhFTVNUOWd6OFJOUWx4V2ljeHB6cElOR1VoOExZ?=
 =?utf-8?B?VkNMeFovNm5UVElrVzF2cXpSaHVvOTN3ZDdRT0R4REVxZlRwV0RJSDhobUdt?=
 =?utf-8?B?Vk15TlRUbDBndjlGMGdJSXlGZ25ycU9EbE1GelZDQ3RSTkJCekJCZU9yMk45?=
 =?utf-8?B?U0lRV3kzemZibkt6RVJjZWM3WWJmUTZvVm5lS1hONDhsYUsyRGZFNGhtaklS?=
 =?utf-8?B?VVNMVWRnNlJHUU5xRklXdmJCdm52czRiUE9mYmpXSlRvcUFkQjRmdDVMdTNM?=
 =?utf-8?B?RUtlODV2M3BQWkZieFVFb3h4YWo3S0RzSGl3allsUnowcEl6Mnc4YThZYXF5?=
 =?utf-8?B?RkpTMGFUMDI1eWVXQnNqaTdBUDU3OER6YmpLcG1lQVlKcEFUeVd3dUg0ZVNS?=
 =?utf-8?B?cFh6bHVyazBOc2lXS1lYeWVobk9icnF4UDhHb2dEUTY4ME1tbFp4YjFCK3lV?=
 =?utf-8?B?WTQ5MllxUEk2Wk40dGxvaEMwaUV3R3JnbFg5U1dqT1o2K28yQnZGc1FjZFF5?=
 =?utf-8?B?SEg3eWFQM2dFcEIwUE90dE5xb29XZlowTGtVVUdNQjUyTTNuVFdOYkxvZ3N1?=
 =?utf-8?B?bTQ3S1JzMmJoYWxxNUdiblZVTFRMaWhHdDJTWWgyM3l6ZEhVTmlOcHhTNzVO?=
 =?utf-8?B?KzJQU2VtdVRHbHVsME5GUmFud3lyM0o4SHppNWkvSkRSUkwrYS9xQzVWc2RO?=
 =?utf-8?B?dS9PY1g4TEJESDkyT2hNc0tnNEZqbjIyMURNT1BMcDQwTEd3Q2g4SjI2Uk5U?=
 =?utf-8?B?d1JHQ2ltU3JqSDNidjFFNnNqYWUzN2x5R2JlNVN5RHNmUG9LVDVDelM5aFBl?=
 =?utf-8?B?Wlltc3hJNENBdDcrNEovM3VTc0k3Rmc4TTNCMkwwLzJ5SWtIaVV6MHhtKzB0?=
 =?utf-8?B?L0VtUUhrVllMWTkydlZVS3A4TS9YdWd1K1ppb0xXeGNFSGJMOHBQM2UzSnAy?=
 =?utf-8?B?UGNqOHZ6TXgwdG1kNm81VzRrTFl5cHhJaXN4M20wUE0zanE4TzNVelBkcHBR?=
 =?utf-8?B?MDVRSlduOVE0dU9TeVg2ZEFkS1ZyRTRWOURpN2NGSjl2NzcyQ2dKeE41Z3lW?=
 =?utf-8?B?YVBGKzFpUmIvRDdyK1NkdHFjY25nMDJDLzJkWjBITXREeDZaNGE3c2lwR3lw?=
 =?utf-8?B?bFcrWGQ1MmFjbEdLRUhhSWFNcXU2ZURQTjhpbVB4QitUaGlzZHQzejdSMWpP?=
 =?utf-8?B?VVFmdGlBMGs5ckp0cjBrQ2pnbnhhNHh1YW5hV3ZCMUE0cStadmtHVnpVWFc4?=
 =?utf-8?B?STZoZ3VQSmpjb0E3d21lWXQySXlFVm5CL2daamdkUTMyTS9IVFdTb2YzKzNw?=
 =?utf-8?B?TGhjWDFvYVpJM0dJS3Y4bmF4MEJlZUJ1emhxUUZRaEFEcEsvK0JWS0gyVVFY?=
 =?utf-8?B?aTFoVnhaMWtyR004U0cvQmpWbUJMY21UcnUzeU02UEx5YmVlQWRsNHFkOWFy?=
 =?utf-8?B?NzJqNGREY0VqK1NVb3Vkd1I5STdiWmw4M2l5ZGttNm5Id0RLTXJyVlc1a1U2?=
 =?utf-8?Q?FI3I/B?=
X-Forefront-Antispam-Report:
	CIP:4.227.125.105;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:[127.0.0.1];PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(34020700016)(42112799006)(13003099007)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 08:45:32.9469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1083e3-0d73-475f-6640-08de41367888
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[4.227.125.105];Helo=[[127.0.0.1]]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4391

From: SriNavmani A <srinavmani@axiado.com>

Add device tree bindings for the Axiado AX3000 eMMC PHY. The bindings
define the required properties for configuring the external Arasan
eMMC PHY, including register base addresses and clock references
needed for HS200 mode operation.

Signed-off-by: SriNavmani A <srinavmani@axiado.com>
Signed-off-by: Tzu-Hao Wei <twei@axiado.com>
---
 .../bindings/phy/axiado,ax3000-emmc-phy.yaml       | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/axiado,ax3000-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/axiado,ax3000-emmc-phy.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..f88941ce60cbd99a73e8c504e0bf36c626bbf674
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/axiado,ax3000-emmc-phy.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/axiado,ax3000-emmc-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Axiado AX3000 Arasan eMMC PHY
+
+maintainers:
+  - SriNavmani A <srinavmani@axiado.com>
+  - Tzu-Hao Wei <twei@axiado.com>
+  - Prasad Bolisetty <pbolisetty@axiado.com>
+
+description: |+
+  Bindings for eMMC PHY on Axiado AX3000 SoC.
+
+  - compatible:         Should be one of the following:
+                        "axiado,ax3000-emmc-phy"
+  - reg:
+      maxItems: 1
+
+properties:
+  compatible:
+    enum:
+      - axiado,ax3000-emmc-phy
+
+  "#phy-cells":
+    const: 0
+
+  reg:
+    maxItems: 1
+
+required:
+  - "#phy-cells"
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    emmc_phy: emmc-phy@80801C00 {
+        compatible = "axiado,ax3000-emmc-phy";
+        reg = <0x80801C00 0x1000>;
+        #phy-cells = <0>;
+    };

-- 
2.48.1

