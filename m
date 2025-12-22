Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022091.outbound.protection.outlook.com [40.107.200.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F26C310774;
	Mon, 22 Dec 2025 08:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766393158; cv=fail; b=o7xk+uS90siTDcFKncKC3t5GDNrnD/TiYI2G/0Z8dpH6rsZx84/BKOl0NCoV69WdMGTSOP4MKIisWkwqpip7e4RT+6OC2g+AgbTgB1eGZCieX+yxmqcNy+cdC4kRebQefNJoAwywvlJNkq21Rf++8Mr+XKPBw7L1cb54lIoIo+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766393158; c=relaxed/simple;
	bh=dmc/1kiYtYphSCXrSljI/F465VUCBafnnnvmzoqji7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fcjreVW/max4v10D6SF0OfzpKn+WrigDIx78FBJaD/U0JxQKHIaEKnwW0khwf/ARWd43/YTAt0AVLz9tPMntO2bMHz/AcIMF8Oqqk+Vfo17R60Go/n1TD7ZqDdQQs/E1m4DAyIzStdGZM7YarkxeX3GLsfGkL1EZlfLP5fL0+UA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=gra+fiFS; arc=fail smtp.client-ip=40.107.200.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="gra+fiFS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBeN4kcdWGzfPdwLFfZ5+1ENJ47dUcAWKO0nf8BH1dkN4BlYu/Xp3MggEYimE2ZGRu/uJiCwfpt7PcNxzL3Og8OkFeNbD5eVKIKwG8+Q3NdB4mF+7bOBfgJSfY/u2PaOzM2Wlck1khjnplggXUdKeYOqr+eJHNZggtTvzkoEd1Or/5p3qwB4wqGpNSLiMgw/wGB90D/VzX3VNSf6kPRmQj91D39a+QSTx0mcb2LNhZDCNrMF10FxdS+SKsGiQsKCuf1cZTyQgy+IJTJWkr+gsGgYe4Ix3lHRgHpvv2YExItvxyqr/KaE/juP6NcA3NK8OKlXVrulUz90CR9/fYbQwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quLggUQ9OHJwwjYISdmwpBCZIH/SJ+H7AVtwUfrUWSM=;
 b=d4qLhCJt8tcDY8czcTdE2VdAKtiFIu2P9niDaGnqKi371BzcLFPIgaxXnlIgnkOzAmva3aG3Rnx/VT3bR8kaeAAgWsu/Oupz+U0+ed7+897hDU6Lomh2yiEZ+3o1U41jyqpc5uOVhZXRyiMQrAPTbki7w3NoDmkbE8uLAaLCPE7Dpal7FEU5+hEWkbk5YD3jI5F01WWnGy+/7L2b7r0OqT7he1OpT9LV2432Z1w9ly4PGMBQgA7Z3xXa2pZC+mtJnLE0wPEXhh88VaUBdhGLAFh2koxNC0IXoX4ZXDhGqVA+WTFQtWBG9oG9zJNY1tkKSG3q1Qt8MXrocbtcNCwAFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 4.227.125.105) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quLggUQ9OHJwwjYISdmwpBCZIH/SJ+H7AVtwUfrUWSM=;
 b=gra+fiFSNov+LP51zFEHqXkOnwKCkEbI5gl9ClXN4dhiT9RH5Yi9bmL077+ucOySm4NeQZkSg6P9vwe2xZx2PwFIbm7iakc1ADhmpgGPSPExOvKNgMLZ/BbqwPWw7PRNS3v53NRTxMonr6qvY+E5I1ML2IexeLTLsG5KgaVZHg6IDc08VXDVBonu4m94WLD2f5mErZI2uG5QPrgA2fI0Li/9mR9wa0n47kWPidORMjK+GC5N/jrWVDurJkYlv3ua5UGcSVmruv/5tvfmfgp9p9JiYfQO2xeJ70Kv6RiUPzDkxbivwW7lesvMwtnL7yyZ6RMu+wln2HSGc0+VL54LRQ==
Received: from PH8P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::23)
 by LV8PR18MB5807.namprd18.prod.outlook.com (2603:10b6:408:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 08:45:47 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::56) by PH8P220CA0015.outlook.office365.com
 (2603:10b6:510:345::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Mon,
 22 Dec 2025 08:45:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 4.227.125.105)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 4.227.125.105 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.227.125.105; helo=[127.0.0.1];
Received: from [127.0.0.1] (4.227.125.105) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.9
 via Frontend Transport; Mon, 22 Dec 2025 08:45:46 +0000
From: Tzu-Hao Wei <twei@axiado.com>
Date: Mon, 22 Dec 2025 16:45:07 +0800
Subject: [PATCH 8/8] arm64: dts: axiado: enable sdhci host
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-8-5457d0ebcdb4@axiado.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=824; i=twei@axiado.com;
 h=from:subject:message-id; bh=D+uGCrxDD/L2TxLlqilvLpFHyI34R/qs55k5zPPUSpc=;
 b=owEB7QES/pANAwAKAXgQMF3EWvHXAcsmYgBpSQUpAP6pop3dlGw+ftF87I2jBLFooQCfSVllv
 BKaA570MdiJAbMEAAEKAB0WIQSZyWINOowtFmDvdYF4EDBdxFrx1wUCaUkFKQAKCRB4EDBdxFrx
 16SFDAC/YfCSGcDccGsxFkZZTchY82smGjMnFp9Q6hfm9of3OqFpxH/RbgasbLDfKmR8LWF+CKI
 CPHPPlkyirFXjmp74eenVd4DLN5G8PFv+1kdW+aS8rgP8DTWxh+tXCi4Awf+cVFIkeAoplEveGa
 o7QVdVGJpev7iSd2ka9Y3p4dNjcgN81NhuVAl6yEKwiO6A6ieeOWDyip/GFhd+Rgsw3hyaU4lUn
 vhI9OqZljGOXCnBnlZF7Deo3Rq62aqSMB/pcP5ogTLS/8Az8lB0gOG3AqItl24PckvKJokk6S5J
 ZOFBvCPLVOJ9Pj1Di0fI0UcXUsM1p9u1lpx20wRNDTG2lYGhfisEzfJtPrZz2zKy0sW+9ZGeYet
 yOWNm2tvFTpjyezDcxHT74vNtTokmEYARjQ5lKt142G8qGPetERFON+IdWaEhPxtoyNmFrDyX5K
 3B43i7iAuu9xiGPb/2PIEsnNTUa9CsR2u5sRdWuVpDKMLbEFEgyxywEL/qiGyX+Dgpcqg=
X-Developer-Key: i=twei@axiado.com; a=openpgp;
 fpr=99C9620D3A8C2D1660EF75817810305DC45AF1D7
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|LV8PR18MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: 1307f357-7400-4664-9391-08de41368091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|34020700016|1800799024|7416014|376014|42112799006|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUgwRlpMMzM5WUpzWEpwcHVock5qWGUrODdrbEorSVVibjJmK0E1eDZDSzFw?=
 =?utf-8?B?a3E3OW9KMFlLcWhPZzhjZ2NsMU5CUVhLd1FyQXd4ZEUzd29RdHdxSDJRcncr?=
 =?utf-8?B?YnVEV01OZzV6c1R0OUlqMjVqZkdkOXg5c0VzT2ZZQk5DY3VrNVpXWGVtQmdp?=
 =?utf-8?B?ellHeXo3YWF3WWxlekNKOC9EbkxOUE5OUDJzRDRHeVRYZ0V6T0lkUjgvZldT?=
 =?utf-8?B?dnZrOGVkVTJPaGhOWHlpcTVxdWNQVGEzaVdUSkhJUGxRZEREKzk4TWFJcDNK?=
 =?utf-8?B?OFh6dk8zQXlEbkxFZko4ZUphYWJEY2lRNHdyK0VkVTJqa0xKS0tLSlQyS0ZT?=
 =?utf-8?B?WVdkY29Ha1RpeDBlZGVvMkk2K254NGhVam9SdXVRd0xFaTZpdDdUSTdZMVlx?=
 =?utf-8?B?VDVUYnpZc3ZzMWVxTlN3Vmo4K0JJZUFkNkdJdFBWS3JaTHlaN05EUWFlbFA2?=
 =?utf-8?B?c1pEdklneDhkYktTOUNFTU9VMGdqZUlXeG9DQ3A4VW5uMHhKZGZnTlFhQ3k0?=
 =?utf-8?B?VmNFWUFUaVRBUGI5d01laU1Cb01QTVpJZGQwZGpXMjVjeHdwMmh0cGNWanVH?=
 =?utf-8?B?WlBZYVdLOHoxUG9JYXp2N0NKdEdGYm92QWR1RmxSTWkzVmxweU91YWxBN0J2?=
 =?utf-8?B?enVOaHhHUjRvZTdLMzA5bkUweWoyeFd6ZnVCQnZWQndUOThscDhGZE5oTnls?=
 =?utf-8?B?VFJnckxNYVE0Mms5OFFZbERVUWkzT1JDYktseHJycFV1a3Rvd0JqSDlKWjlW?=
 =?utf-8?B?SDRld3g1MFZheGNKNkQwQkszZnhIRE1TMFJqS1NiV0c1L2RXcC9ab29La1d1?=
 =?utf-8?B?Y3NRMXNkTEZUYTV2M2hVTXZoR3ZvYjYzRnR5OTlQZVB1Qjd4T1E3K3ZzUmJ6?=
 =?utf-8?B?TDM0UkF4ZTBMVFJrVTVaMU54TlBNMitSNHZwLzUxbDRYNmxjL2FNbXBVRWZr?=
 =?utf-8?B?M3Z6SDJhRlNleFZSc2I5S0FwMDBUYTh3aEhnUC9LVlpNTkt1d0RXQ2VseFV2?=
 =?utf-8?B?UlUrZmVNVDV0bGpkaURFaEY0d0tyTDlmU2g2dkFHWmRGS3BjSmptQnBYcWwv?=
 =?utf-8?B?K0t1b01SVUx3cmVtQ2dBdGxpOGlsWVFyQ09LQXBEdjZYOGJQWDBRTnBXS1Ro?=
 =?utf-8?B?Sm14TzRxNEJFd2dFU2QyRy8zMGNXNFViMDlPQ0wxZHRvQXVGU0F4VUYyQVMv?=
 =?utf-8?B?VzhNTi9QeDZiVzlsYW43K3U4QzA1RTdLVEpuR0gyOWFIdC8wY1pvTFFvZWx5?=
 =?utf-8?B?U1ZOY3JFaEN1M1ZiSDZZS3RZY05mK2NyWnYyK1paT1FQSllHTGtjY1FiL1JL?=
 =?utf-8?B?YUMzWUNwcXQreTFPamZBcmUzQVkwWmVzeTFiWUlBN3ZuQmRyZGtsVitoUzBN?=
 =?utf-8?B?ejBtRC83QmtrT0xUZFhSckVQUG83S2RjdFd1K3J5dlZyc2tPYldyNjRHVm5R?=
 =?utf-8?B?NzN4OHdzKytwM0tPOVBrdzlVbmNmbm9kdHZhSkF0ZGliMXFBcytPQTNteWw0?=
 =?utf-8?B?VjBMQWVxenpHTW9nQTdWRG53emFyUi9XTUkyNFQ1MHd4L2xJeEdQbktKaXVu?=
 =?utf-8?B?ZWhac1JCNlVLMnJuWGFvVzhhaGp3cnFCcjFTOXBQTzZTNHdVZDJ4RkxUQld6?=
 =?utf-8?B?K2FFd041ZUhXejU1NXl4Y1pEcUdRNTdhbG9HTGtYU2o5RlJVcnpHc1lqYXN1?=
 =?utf-8?B?Uzk5V3dXRnduOUJBMnlJejRubG5Za0dHK0ZOVWZlRDJKNGtGZlZoMEFmOVBB?=
 =?utf-8?B?S2swWXdoU1hMek1iTkk0aXYyUDU3V2hPSHVGMlByelk0SENQK0MrT1R0aTdX?=
 =?utf-8?B?YlZIT0NkWkI5cHAzWk1XRjZNQU9udklWNVc4NmdHOXhHMDlBRTVyTGN4THZC?=
 =?utf-8?B?eE44S0g3SmVkaFowdjRBNnY5TkQ1THN0TU1UMlJXaVlnQk1rUzlpUjZzNnB4?=
 =?utf-8?B?SVZSR1MvWlVCQ3FRK0p0ZG1BZmI2dGYvSkl4KzVHTWlIRy8rSzNEUGhramxI?=
 =?utf-8?B?UHFoMkx3OGVjbjI2bUFta004Z3F2NktRVkxvY3F5MVY0VGovN2VQSUJZc0Fy?=
 =?utf-8?B?SmU5aEdLR3Jta0NHNlZpTW9aNHBzd1JnNGc5cllqYUxvK0VjcnZBRVU3Zmx5?=
 =?utf-8?Q?dinZ51gilVWMbbbpL1nuX7qn0?=
X-Forefront-Antispam-Report:
	CIP:4.227.125.105;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:[127.0.0.1];PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(34020700016)(1800799024)(7416014)(376014)(42112799006)(82310400026)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 08:45:46.4657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1307f357-7400-4664-9391-08de41368091
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[4.227.125.105];Helo=[[127.0.0.1]]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5807

From: SriNavmani A <srinavmani@axiado.com>

Enable the SDHCI host controller for eMMC support on the AX3000 EVK
evaluation board by referencing the SDHCI node defined in the SoC
device tree include file. This enables eMMC functionality on the
evaluation board.

Signed-off-by: Tzu-Hao Wei <twei@axiado.com>
---
 arch/arm64/boot/dts/axiado/ax3000-evk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/axiado/ax3000-evk.dts b/arch/arm64/boot/dts/axiado/ax3000-evk.dts
index b86e969625573bf92bdd5e4435ea571dd7500de2..a5cc75dfbe554749201b0910ec268c899bc5246c 100644
--- a/arch/arm64/boot/dts/axiado/ax3000-evk.dts
+++ b/arch/arm64/boot/dts/axiado/ax3000-evk.dts
@@ -80,3 +80,11 @@ &uart2 {
 &uart3 {
 	status = "okay";
 };
+
+&emmc_phy {
+	status = "okay";
+};
+
+&sdhci0 {
+	status = "okay";
+};

-- 
2.48.1

