Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7CF37DE84;
	Mon, 11 May 2026 20:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530904; cv=fail; b=gHXfYD2mGTKF3qH+HuK9+u7BKrbHJg736lbagQqVWU6awbYcPcDu5pCUrRN6SsBOxWnrlcpOf5L+iSDQBpof2vU1tSWHmHR2lo6owBaRKdJn0aYl0yhFqw3NYEFgR1iqctKwvuHgaiqbgaCAMtGTTEUwUTmstuPEHh3n+NUJKhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530904; c=relaxed/simple;
	bh=cvEeNPFPSMGzBEp5URYcZNv+uSatXmN0BVT9zjxIy+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=prXx+RfBX+Fo9TEKLObEpm4HjggskfmHWdwq+Y0VbUMfKVE6Gv1WRtbAbvy9TB3byqdwmDnbys9oR47W2x3+jJo/Lt46NSxWAgJv/VtRlLcT9xZFhD4AdVicSUgPqRsQeEQFP1cdoOTS6FbxZti4EppmscKNmGCUdDfc+jN2VOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Y/17fgkX; arc=fail smtp.client-ip=40.107.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Y/17fgkX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eC3pOA4va5IRjtadejJx+dXJZNWXYR8eqZu6mwAgh/nr0qAUPmghk10tP3WIDLvpmLb12OuwHgz1p5Rulcca2V8vrhEKPqO3t2pxIufiM97JXr+mRp5+Dlx3Hf3ifcDwBv/HqJFIO3TK6U9+2plXDRCwx8wydunX50rSXE717lkxWNX6zc0FOOYp7dJBTaQ5v/KNX5ZpLqgfT0MafLgH9mYAQSjDFnTkFvJeLO454GdX2p3H75VrV1Zb3OYQFjlUzLRqsc2AcjxxvP8PR4q8HdvqLBJtxr5CJwObxwRzQtp4Tnjf2rHgDsumZ9ltc4gFflkE1KRP3Svz/C89zVhf5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6EGtquTCLEoHOOBApx6L+ViwBmk1YKmdhAWdxjHUW4=;
 b=ffXJ9dUWw16OV1dzF5oWVwduizMwkEFaGxRiLpqIV/QUT9srQcPcFEQaPkkxeHhe3qNwAA54iXYmP63svvpLjYzK5AWifmZzhxGxBEUkpJkr0v0ONOYDaU6PmsGDhQXLt0DR1b7GMz4Zh8XmlN0tcK9B600R4n64OikLHdz5OBbrPL2hV1+LrMBPOSiBUPwHE+NzCktU2oiNm+7T/o0NuLOj++5OfFfMjOAjuj/FGCIOFaW2o57rJsa3O998cKnq78p4JMcdKh9N56pljizmmdI1zkkUKvDCE7PkTHdlmaEoMwtIFqiTYnXiDvWJe3C5W3k1KficJtTdFFLtcIcT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6EGtquTCLEoHOOBApx6L+ViwBmk1YKmdhAWdxjHUW4=;
 b=Y/17fgkXcAhI7B2tXVXTGEHSRXJb1kwNWfE/KQgv3y6st6hhTTT20PG0KsyzYhOiJrncOCOXF7tWUA0+v6b6Pz187RbkbIYRlRQZqUQA8IwMDJVb7/briX/xPVlWEt06CG0LztDy62QOTqqvrr86/WlZIfi4Tgeag+i4iTMWM4Jck6/9UjVlk8eYWSCnNRgvsU91hHunb+5QlvZ8wV97VzKkBv9O+YcPFTP7NcfNIA18tq5L75S5Q3zL11/cISjIvjXGtJgoz6gI4gGQ5/G/NYrFZf0puUgNJig1iik83Er2yBf6E/tIWojoSN+qjplZDGVZUBFLVmzWU9Cr9NcnwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DS0PR03MB8296.namprd03.prod.outlook.com (2603:10b6:8:292::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 20:21:39 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 20:21:39 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/9] dt-bindings: reset: altr: add COMBOPHY_RESET for Agilex5
Date: Mon, 11 May 2026 13:21:23 -0700
Message-Id: <20260511202132.5597-2-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260511202132.5597-1-tanmay.kathpalia@altera.com>
References: <20260511202132.5597-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0066.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::43) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DS0PR03MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 158cafcd-cd0c-41f7-f995-08deaf9ae859
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	n9vMNPE2V1g3OHsLzVX7Ha/07aU2P+LfxiEk6ADYWubOh5y/Helv9T4xuP7gc6/XFIrMyQYiVpnC8n5QIENVnkXifzMKw3TofCj1roU2LlpxDvivJ+tR9JByomqpw/EbA8ojaQmn1r+s+S001PVe67S5pYxQph8gXDgMylRQwM1rSE33HcXrwNk8G8nV2fA8R734vmYYY7mbEUwu/fggTUZucuSyewbVkZO2Hv4i7KujOlJr/hCpMoMYpfTXkiEjn1cQSvp+YtPX0uhrpWX9FnGPg5/PNj3KKp8Tfk1T7ug4k3dV4YJ+37UH0LjOPA4f3x4wXcOQSz69BnVdgGNfQNIzl0eg2BYECThoubHZXIJuanqJ9VtDngNBjJdFRp/CG0u4/t2Mu3gl7w2jGlGyjdO6i3SiCbT5R5aOJDgo/UzjJEuZk3zOwC/iSu5Lu1SboLH6Yujg5+UWHefTynd5T5P105ilInzq7JBrX/g7IUoAcPXPrqxDDbviQl26dxPhK1TMhtEOiBpDYqTABq/JN8Zm/Uc7j3a5yJRIeXpLR1f22MP2QpcbXh9/eM0dqhcdGeyfexvmNXe0RUdzbbsLVAnCUk3axLvsmWEFNFCw7s+axtljLKT5fl427oNHDaM29PR32kOLQ3MY43LWdhxBLbdv9oCwGdwfSZN8Gq7wXQrvdKRXzSWZjdgW2ED6VvN4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n4Erln2zRPPND+5UO139hpKFdprTSsM1eSXXJz8onyV3TMGz1LgVUffNUkMs?=
 =?us-ascii?Q?qSfd2xRtFVACJrTDJk+dvbrIjILGp2LxiCJ3Qhi1TQTBAiwRwbZXjc2bjajk?=
 =?us-ascii?Q?rZm3DAlkQ0Afs2TIU9R0T5v+Qt/1QY+DbvHld1gOE0zct76ElSPa80YHhDNu?=
 =?us-ascii?Q?dbgNm7XochNRCPw14JXn4KhAoNtmmN/W3Q7uccb84H2oiPS68bPTWtn+49Kj?=
 =?us-ascii?Q?JdOzlqYWeFcb58gCpvxCHcEn+NGxZ8ZY5EtIYip+ILkXBA1vp7DqSxqjqngb?=
 =?us-ascii?Q?wUjQwYZYqdnqynM5vxB9SMhb0QKiRsutY9Sn/RLy/vammuQgm6QCvngA0WHr?=
 =?us-ascii?Q?yjl295+UZbz3oppHVhGA+1eKbET2t9frTACpuVb5KleRwBy96zjpbvuufUTi?=
 =?us-ascii?Q?RNtQN7ldsN1h8FtIfqGVuddjeM3BFQ93nZes5PpOkQxh0+Ajum9oN/sUasLB?=
 =?us-ascii?Q?r+3nImmk8jadFBe0OZY24QIlHuTnV3MciS/Okcc6hAK4JHCFlHTDpNo5UDYG?=
 =?us-ascii?Q?oIZsSqX8UyhCteG5SzP5U4bYlCT0NmAqp9g3/Lr5lWvioPgNZPqd9Q4Ha2UE?=
 =?us-ascii?Q?9Lzg8614KQvEy45xo7ySrzMtKgQNjQjPZ20d1uZ7OYRq3hTQZKq96z0qMFqT?=
 =?us-ascii?Q?eFtaX3eCVMizBMGdCjrf5h5fVtijwvKCzbnz6mQtcKuhaW9pkWq0+OoILZcd?=
 =?us-ascii?Q?dc8QjqYqk2tc2SnOCzLfhTUUicLydsLL0RC2kGNKmjcHbwoTHL/hIhh1xc4m?=
 =?us-ascii?Q?DexzqsziUZ0PkU/Uk7qeIGhc936mH0rnhy4MZ2ft4gJyM+aQZIeXn1fgWmY4?=
 =?us-ascii?Q?H3Oh6ShQYo/NsYsEDVz8xQ9hcKWyRbLMY180v6SEz3ktJbe1QUpf1PcrLPlI?=
 =?us-ascii?Q?c52DXmxB3XdMhOR4ijEs+GX03dZKCWE7joaiqplFeuSj8dTb6C6E8SOs6vp6?=
 =?us-ascii?Q?xPWIsRcq7yGF6BT8+o9HTwmMXyL4W8Wyig3hIa/jCIxHOF23AenvG2HBl4Bu?=
 =?us-ascii?Q?0N5FtvEqIBQJtF8FeIrIIXFc/2Z8M5H3S2g33Lm9cIdNv9whhQkuwnsqDnz/?=
 =?us-ascii?Q?V8Eum8TuH3wFK+DiczUfr2Dc21+6GDuhTJtBH64pVV7WOuj0ohknVRU2tlDe?=
 =?us-ascii?Q?3qrYcdLik9bCEhXUCSuOkxLZu2MCvI2ujPDWk1AUsvjeTHSINRZfjDbgw+/H?=
 =?us-ascii?Q?quNyYu3v6p2P6PSRzhry/YsBCoEVohBIHTeoAOnx8h5NfB4eKzEvIQMPbQ6n?=
 =?us-ascii?Q?1fuME6b7gCRCbGg4pZSXksrkxrn1GGIvCkzaAs2zIxK3YzPpoumsivlpEAzL?=
 =?us-ascii?Q?Ey6XIskxASFgzR0Wew0RHQxW5mdENkoOG+7coCYdC54svCR+5JPXj/x27V/4?=
 =?us-ascii?Q?HgazTtR5We6kzHN0nZPYIttfrWBMANOy60E2iZKwKy2pO2lKrsIQggUbWI/3?=
 =?us-ascii?Q?4g4q6hklZsKdQWqdZorcZ/vq5nmvTdLSvXkJ2dzfdVIq6cY+30Gbs3PxC3A0?=
 =?us-ascii?Q?WRG35bBtYeS9UXBPxrUoKgB1soyjOLcaQz9MpOXZNK8ntO7iZ76ZojyTrg95?=
 =?us-ascii?Q?FlMylPbZ3EFWXKVmInNjGrLsh3mkSZ8+XrZQkIO2As4ywlUMVbN5cd7w6FXh?=
 =?us-ascii?Q?4a3vDSSHNwxOSGlr3eE8Q/b6MGXGKR+k1wGPYbgjZUMln0NkjFGdwxGTRmpB?=
 =?us-ascii?Q?1waCIExDq6pu/vMVDHObYy1EFRfU9Pav4qpOiMt3bp8ttOQgTvjZZx68OQK4?=
 =?us-ascii?Q?MDWCFsj4VF7noFB5dWB3DEIsE/Wg73U=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158cafcd-cd0c-41f7-f995-08deaf9ae859
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 20:21:39.2954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pU7s4QkiACzrVySI/JYS/X6DLHcRPhIfRQeEZ/YAE9qZ3PlQ2Nyrub9La03hlEaIZV4QYSjgvFuTfVbDxw1vvg18oUR4NP4PN03ko+kMzlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB8296

Add COMBOPHY_RESET definition at index 38 for the combo PHY reset
control on Altera Agilex5 SoCs. This reset is used by peripherals
such as the SD/eMMC controller that share the combo PHY.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 include/dt-bindings/reset/altr,rst-mgr-s10.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/reset/altr,rst-mgr-s10.h b/include/dt-bindings/reset/altr,rst-mgr-s10.h
index 04c4d0c6fd34..c2505b9eb63e 100644
--- a/include/dt-bindings/reset/altr,rst-mgr-s10.h
+++ b/include/dt-bindings/reset/altr,rst-mgr-s10.h
@@ -22,7 +22,7 @@
 #define USB0_RESET		35
 #define USB1_RESET		36
 #define NAND_RESET		37
-/* 38 is empty */
+#define COMBOPHY_RESET		38
 #define SDMMC_RESET		39
 #define EMAC0_OCP_RESET		40
 #define EMAC1_OCP_RESET		41
-- 
2.43.7

