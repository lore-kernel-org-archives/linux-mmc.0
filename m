Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010011.outbound.protection.outlook.com [52.101.193.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960B134B669;
	Sat, 27 Jun 2026 20:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782591339; cv=fail; b=PC7tPoYycvlkdGEk8kbm0m3uNFnu8R3ApOz0G2fiRBzDkXogietx1Ec8Eg/8xzyAvbtqOSjWcPXX2l8Q5sW4yGeDGtk/LE1ELOLk4RoJ5sou3hUoz4Mri1Mbw7fs1nVR1pKt+CBZG8MnKME8cUlcMWTnwL+KcrBesCDUyUbzzEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782591339; c=relaxed/simple;
	bh=wwCiSOssnYBYE39BSZ3yGelq1L88D3upkfLIlfEBACI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TZRTtu3xypDreL7dCI2AVVtS68miBOXddQoVYUVenX3t1oJAlxHmYb/j59/4kWv/+X78u2YI6FkzlulbEkAwtP6T5dGbr89IOi1ve7MJEfFuvjuK6fUeWe3LYsuNSYOCoHgdzqS3YlJaDVJIcJOOtVTjdYEwJzlHQpF1QjHXEj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=AL7ZPSxw; arc=fail smtp.client-ip=52.101.193.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="AL7ZPSxw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WAvamovAhfHQ8NLKL1ZLnAqwnYd6UY+um08qt1uSSXirPZymrBca9fM3KC6ox4xeM7yU6BXkp7hjfB2ssmzexF5jac9PuREoO0t2B+Y2er75l672xO3WgHWBIuQOywE0CL3zaTv/b3P1V+OZ2aCZTCrGorag3PYWtPavV5ZgmFdqsjshPeV2X3ANbq7BChPi4Brz2NKuuM+VH94QR08xuAUFpMFectaVVDoL+DgBkpQihgPqkZM24NkV1f0CHkcA/ONVHlW6tRsefLuEe7M9ZnXz6UzTnAh485LbLoHCb99ljr/inDqJ+gAZYpSTBFN20pejZB08hmM5iI/UAmSr4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzMimHeCY7ygGOMTdlbPTz/s7j1m4kPoXRs43ZxatxI=;
 b=m41F+SoYz6lo6alq71omvr8TzekpudgTcwpa8+lnBhmfzpwi3swXPPoAGMzPSyFIOCvZ3VOopTTx+sGmD4MNN8aq49zMYnOfnx5sBzo5SElwFoSwaqDM1xfIjR28VzZhMenDzXpRNaZIRTq2NOP2xGXd9KNf2wdCTYwKN51mtiZbURrLJSWHda1Ud+R5AgrM6u4YlUXCF3LbYgzrWsvro3ZZkKicQAyT+xRLi+J3QLebyLTCumHLdOu9z5FFrxQVG3ZQQ/DeSun9S/NhHJ09A35VUb8CbV8xr09PibbgshlnnfjVjlDqjYNjvj2zpQ9mr+hVtPhHxoGe0Vh0vWj9Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzMimHeCY7ygGOMTdlbPTz/s7j1m4kPoXRs43ZxatxI=;
 b=AL7ZPSxwScIa+iLTYW1ck7bLQlSduwb3pZo4rZscdYwvMz2T1OCPVsTQsTMBglFJUBy2CBAlGuqHf0CbOkE13Pkz3wV9lnuuEwBOBb4XWiB+xoV08Z4pxDB/mZxsBsE2Hen88k841CiCcsdjLsVhrXBtwQQ13ZQeqOOsO2jHlldQdyePDjeGc0Gm4hBLwwAsDsVCg0ztdGC2LkoQTnypilLBZg+HL1mL/gDweSREYxUw3aZ56Wvs6nBQ6sZJMeFf4LAejABJMJ0gDXnhsJBONpz9EMiXXjZe1oClXkXU5tJUC72C6LXl3aUF2uCpAbQvutAkQaeENrVuBSZK6VVbFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SJ0PR03MB5837.namprd03.prod.outlook.com (2603:10b6:a03:2df::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 20:15:31 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0159.018; Sat, 27 Jun 2026
 20:15:31 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/9] dt-bindings: arm: intel: add Agilex5 SOCDK eMMC board variant
Date: Sat, 27 Jun 2026 13:14:49 -0700
Message-ID: <20260627201457.12318-5-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260627201457.12318-1-tanmay.kathpalia@altera.com>
References: <20260627201457.12318-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::33) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SJ0PR03MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: ccca700b-65ff-4e07-ceb2-08ded488d63e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	oUWiekPyoml4uI/q648+xsPow2frOynBn0XZm268BbiQEWjmAg9IFdF/0cNvlpTPqMP4XhSCKGiAC93e28oAIhJcwxOsmJqjHOPPMTB/NkAkn2PW30SvbrgY89l2KJNOZ97vBZeSO39TKZNaKvGaaUnxbgFRXDjIjQpQ5ePGYDSrJTSMh+hYfdCHKG7n9TFme45AQ7w4b2o8qVonvlKMgYjfIwWxlan08AuB/I2wgmGMigRPVbsHXqi7iAPUFvLJ+Bu9IEEcs79kjBgfGWY6f9XzyQoZXhZ2RYxl6hOHNKKx/CKcj/pdfYwl5dVwmdcIvMxiL1BJHD8wfTQ2HRaBfkUXCGgZ9kvI84Ue09WO4FSpK5KC3qUMECYCp5Jfz0mm18y0zJI8bmrbPYtV9RLs4Pv0PJLBz/ZbS3WOFw2hxfzheDFup5xjeIXPlsiFo00g5g8V42GJK/SoQbrQOUqfjgImYIQ/C3hocdl/pQQYU+vlMeGkesLWuhvQIs7qxzklDAgaBJ2RAAUbqyML+/5xAwspVhaN4hzKcu1kNjw7x9hjWiCljH5fe7KBQpD1xnD8k4WkLfX7cxFFF5ATNAvH+uVSL296kkn7Lb5IcpRNXVfgt4WrykmI/LjgZImHIMePesT7u/T8SOGLH+2va2cRqEbxtNXvhBq68c7EPKVRc8c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AN0PIlB90/8PKAgkwzDpn0PuIBOu86SjydYXQLU2RPZHu7YLGd0zi5JeuNtS?=
 =?us-ascii?Q?lycH0IJDvhSR8WJJ+N4CrlNYkpffwomdyvqaeDnaSjRocfkqwMDPgaNDpa8g?=
 =?us-ascii?Q?9Ti/7lyooWfBMwRXh0tsLbv45Rm670W5qOGL0kgcth7ek22VLrDYrLdQxRxS?=
 =?us-ascii?Q?c+jTNPFAX5fNqXKmglFucj+uLZzAMoaBM+VXuwTPRNcNm/mCzoBq9pzxISBT?=
 =?us-ascii?Q?f+6C2GjaCNjFddIwRyc+WUXcuRO6WHFA3CBbObU+2C9d/XSBG3/Vvo3uJ4Zu?=
 =?us-ascii?Q?FFlSg4qu0LRLb3iEEtMcZ/QKXfkl6Sa3OdLYNnewn/f5MoCqmWmKDkM95kXr?=
 =?us-ascii?Q?FBv+jv4q8Ho/1TTe1d730yFyRNl/KSrRHJcIM6tWEIDvSm+z8sAWAQYt7MFO?=
 =?us-ascii?Q?5ZR6i7jblIEJakZ9d/Ir6kCjFTYUmBiDqEwiwnGxmFiPWlCGS5Wfv7bXHG+k?=
 =?us-ascii?Q?dWXCHE2eR329v99W0HFv9H1/lPpDIIEUTi/avWF/UQOQAfYEqk1F64vwuw1l?=
 =?us-ascii?Q?m9Z52jOZdlJ3JBDeM/avaa7CwHGIiefhQz4CEmgZEeSNG/+giIh74/XGukF9?=
 =?us-ascii?Q?ZLJTztaQ9kx14V4P3LLTgvp08BpKJfsMBX5yT55+OFVwJ7g7Kgx/ScF5jMQj?=
 =?us-ascii?Q?woXfMLPZrdI4sb/n4YgTbjoia3GSotE+juG9eWZGtREX2TgYQakJXcgfx1o3?=
 =?us-ascii?Q?JZBpa4EHG1+g7+iCgfPmeqK5L3MPCPgf0MlMqxAzpvQ2tRW0jfN9yTeRkayT?=
 =?us-ascii?Q?MArEGVgFq2vKiYNOS+Tjh6Nxx1jQShms52fBC5NZf71AOAvL0C70T5zC26pc?=
 =?us-ascii?Q?yHhZPUiLDCza2Sf92DtwrD1xgp5cvJ30Mmpw8qlt/7+qtaOy7XRXT+1mUrdf?=
 =?us-ascii?Q?Zh/Bv2ypHnoNRxprdPemVAZE4BA360YeQ8DeyPoIKAPJ0d6PeEfs2rXESno/?=
 =?us-ascii?Q?4rab0y3jm1i7CxduewBP7ZJXZNowIY1z7P0eOsojdWf+dCyROl5n1AXd/iKG?=
 =?us-ascii?Q?UDyWLHeFaHds3BZ82XZ1RXVhRArL6b15KtaXHRrrwUtvIHu74lFyaC0A+kSc?=
 =?us-ascii?Q?KKYUZA3E7iTYE3T41rFD9B/nL/ByGw4csl0S3dlcjCGdxyuT/Tjxq2tHImsx?=
 =?us-ascii?Q?mU50f0TfDdi5zRL3dRkGyGHwTxV1MsV9DfMH6lefvMYVkBmlYRp7czD1vRwv?=
 =?us-ascii?Q?fcWvXpQ7N0lyBjkOPrN1TTXbH8vrdqHAjX90pmcM/Rlx46HrGnhJ0Wv24bZH?=
 =?us-ascii?Q?CVUavJWmbuUWuR8hkX7nAXp4VpXBZn4ZPaBtzIVrdkwX2q/VCoE+RbXwx27s?=
 =?us-ascii?Q?9XYbDoAMn26953ddI8KuPZghcLRj/Xq08mHP1MIDwKRyxFotYkFrHUFW14pE?=
 =?us-ascii?Q?/S5P6bm+degesTyLzhLC4RTQWPYaMySbtgxBL9a41fRPLHpfJ+yi78i7S6l6?=
 =?us-ascii?Q?/gMPyTuraQQDYnYvNWA/f1D2cDlWnx5RV9I55YiHBeNGU5N2PKlFNiQpve1x?=
 =?us-ascii?Q?7622XYNBRWXN+vlUQ5XNcE6WPzrVgpzvliDphSg22f0XpK6EVb1xJ90V+8uT?=
 =?us-ascii?Q?EAgIfnlqsZ8j/QKjKB+U14THeFRzSP82xGdbDKJ5dnaDQcB/DURoAnVsNXDl?=
 =?us-ascii?Q?DyXIuul8QEanOTFZeYAjxTSspKc1NnHYj1pgddNGB9HfIbsUUc7vAewL1DLp?=
 =?us-ascii?Q?mjnZF7Bs5mOL+QYmKJPqkEykocGCCNtNQxD0uCYUG7o2So9VkU2nOgbmuHQG?=
 =?us-ascii?Q?LtDnTdFatFYXoKdP2Hrr8Q68lWuu4xA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccca700b-65ff-4e07-ceb2-08ded488d63e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 20:15:31.0021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +QtCX3VI44jMmnGRVrYiJpM4izUJQBkAnVmODdae90q1XpqWDnEOCGd+mro5CZhVWTPPqCKcNhiLX05jT6spWGuouUQ/ToJxrb3hVOKe3qg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5837

Add "intel,socfpga-agilex5-socdk-emmc" compatible string for the
Agilex5 SOCDK board variant configured with eMMC storage.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 206686f3eebc..f5efcbc381b8 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -113,6 +113,7 @@ properties:
               - intel,socfpga-agilex5-socdk-013b
               - intel,socfpga-agilex5-socdk-modular
               - intel,socfpga-agilex5-socdk-nand
+              - intel,socfpga-agilex5-socdk-emmc
           - const: intel,socfpga-agilex5
 
       - description: SoCFPGA VT
-- 
2.43.7

