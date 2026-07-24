Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEAD341062;
	Fri, 24 Jul 2026 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904625; cv=fail; b=U7kg8Rtoy2mF3TA16nz2ndC9tJPcoIijq87Qkdu9ZUwqzwIrPwREdwX4GG1zfpTIStG3et3t2SYn7BE4v6E/DtEOg3Q5WRYkYgk2iw381Fck0GwfHQlcIQvkBCfcT6wfx8H+iaz9CsNqcqqfmZjz18jOQp0Pd4kw2AdZBuMov4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904625; c=relaxed/simple;
	bh=JXmsy3whEbQ2U6UtoJj7fPfyiE0XgHIgAGYnM5AYajA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s1je+xpSoQxgXG45w71k31XoptpaXWlwruOz31O+uEX+WsKS1cGNLKTIBqvviKNb9QhwmWOFLKP6b72LFCERQp0BmWM43PkjTs+vSZBAqWPPzK4VenQTssw5gtwhOfhrWWg3Y8DDD47xN+YNFTeOBqZQKDIa7yeL0NGW0OsmRoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=DBJxFB7z; arc=fail smtp.client-ip=52.101.61.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="DBJxFB7z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0iZolvnu5P8hv1Zj0hhSfHTiride9vvBsaa9eF0Ieo67MMn4UrzuBsBT/0ufNRpt5rsLXKZUvEidBXj9evWc2yu1ZyTqBB+mRSLJbeFJsWt4VLPL7CbbD/5sMMqrsaJE5XmkfQn0ok5CPSaYM7KMbeX74d8WESOAIBtSnovpSXmfJtdWvs8Oy5aeoeEeDf5Gl/jMlX6czdEbKCaLX7TwnammLX4YVBH29Fv3HJoHBECPOmpQgMeGfsvDePoIQWAGXXuo8D2KuB9rob+lvlz3y7Pcy8/YsRHvXlSzwQxV+hyzG/vWV/uMwSsm/rwO/Ozzf+a844j1adnePBawdfWHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ln2eMeswqMt5dhQ+Of8f/mWdqi9PCzq+SEABzlqt4ko=;
 b=JGTyIQCCrjiuqkcU6DnQu9P3zEoWODGHLf6UrTY5PQwLGsSmn4vaGTZGc4xmNgPZPmujlrAdA1msE2/ty0VGIzgTgYtKaVxoyzOBcPNM6XXE+ejOwoYROvbIXGz+f+WNxa7F1P9uRw3WNE3ZW+zOSN8+d78N1TGJNShbbiRQSJoqZg+ETimhO3dJv5o+9r5/MbkcT34IZquayM5puPNNMqdZZuDJEq/9GTRytnUnfjPnjGTOjJEex+/jghAWPhxpKdO+BfhDSo+ncdLtgXWRriIeRUQY/P3eOEea+DqrvGWMi6lImkJ2FvSjWwf3ghDbROw9eQ4uJkGq42O0UqR9gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ln2eMeswqMt5dhQ+Of8f/mWdqi9PCzq+SEABzlqt4ko=;
 b=DBJxFB7zb7il9MvVqsTbBsFgE68nJVVF9CAbMvOd/xjlwN931TbQk1kTC5pImHLeyBoTg6yLegS03ew76qHLzzgsbm1GoTTKJ4MdJrpWg3iyTHeq32hBgKj7vpfZ6hIfUFV6ERLOsN4bzaCjbN0b6v+l9ChoKMW6SFVA2bG2AIVWTW6hkhHFW9DDHGieORbhiGHLJQ4OiwrLMLshvRg8BjMWreG4vDkUB7nV/sGmMODjkYBkWaK4rhgThbfj2rE5xY9eWF8NNoeIoVSol2hY4BCeTlILXErg0ub2ekgLOkAwDTfuVJnSE1Cj4p3TUeNoc0YTR5Oyi8oTZIbch8v7vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA6PR03MB7904.namprd03.prod.outlook.com (2603:10b6:806:42a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Fri, 24 Jul
 2026 14:50:18 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 14:50:18 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: linux-mmc@vger.kernel.org
Cc: ulfh@kernel.org,
	adrian.hunter@intel.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	p.zabel@pengutronix.de,
	devicetree@vger.kernel.org,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/8] dt-bindings: arm: altera: add Agilex5 SOCDK eMMC board variant
Date: Fri, 24 Jul 2026 07:50:02 -0700
Message-Id: <20260724145009.7456-3-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260724145009.7456-1-tanmay.kathpalia@altera.com>
References: <20260724145009.7456-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:a03:331::18) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA6PR03MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: 4822b997-e07e-4f07-a88a-08dee992e0e6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|10067099003|56012099006|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	Mip58A5HZVuAu13P9yWl37Jtiqakz7Sc0uej9AeTIunIbo309hXQQ0lXVKqVGUyuISWXqvhcn3Bsr1cuFlx6mztf4VXvC4oNL/4yQUz2xoh3Vj8wqoBP2SmqtRdc1KrS2lGe3z7k7UV5XkBx7nHfQ8I6jPvaYYemjw9c3ifuUrfaJ6pQG3MdSqfGLCCyf11xBwLfsx4tauaKzUeFru+wbwV9bLqzHwxWny83v8NpMKWVmlmrf444ZRAl6p//J/X7OwLvqvILLtUCZ/uxFx+irYDpQ1YbtzEjh8ptOi48HD3UGnGYDuNqLvqOPdX/PPA3FrhOGyjfzFJFNSL/e6lqWPxfoTeKRHZxjqZpOMuk2LP6MxNHVcNxeUH2CsynxiKl/7083ZTixqk6TvjSA55NQ6xeKRSPFRT/l8UAZAvApoyDS2Hu1xkHqdIoEAGmLPH991eko3sm9/PAEmj2vda8N0T3XnOfCHmRguG3bF2OoYWHPlViIQkFXR0J5GOOPhiK3BEFE/eQGSTJOKYGqaq+YuJ7Pg+D1UBBzJoiQdOVhhfotzj+YTo5/4gNTYEnZXcd9wka93k40Ny+i+/2A5cp8UGAOUTpLv76y/lSREz4/sJU7KJZ2c6kMtaUBBd/iL9litDCGY4b1gkK/murcxUm8izQDr81+N8NNMUiBQqeu8k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SYWCa9M0ZODdCA3FxMy2n0x6JUL6fL1F/sFk+gPevS7n1lbbwigJBEFqS5UM?=
 =?us-ascii?Q?zbD/mzvn2KIZsvL+Y1Ir6CXjPzy2vjOAOq+x3yeZNDK7rfawc7mmodxFOnv+?=
 =?us-ascii?Q?tN8VpG8SYpMv3MRhQkAMy2iiBhwaoaG4a0UzYKqZS4gpMdV3LR8XvaLWe2ZI?=
 =?us-ascii?Q?p6icjKsh1YIuIoyCzNljAC/LU4b9l/zbr14UDsxLsUyJzQFIUsNK/o666G+Q?=
 =?us-ascii?Q?Ctj7pOBm7/w4Acf1cAYkBirD5ebwzYwtuO0Dao/apyHnGp3LTj788mo6a9qJ?=
 =?us-ascii?Q?NHNk0IQR8zVqjctBkFh9DFAsMythh3WFU4LOSFw7UHBeYz7xoXs2p9czLLtg?=
 =?us-ascii?Q?sFi7bnX1l5AFV4tAHoCGB9CMjQgYA/gS28hV7D5QWTnhcAKu50mHGJvh829P?=
 =?us-ascii?Q?bc+JzIPuWN2rhieQWTxt63OL5nogDK9R9IhXpBNkcN7BnnLyyXM8sYGxm9Yk?=
 =?us-ascii?Q?lfmI8T+dcrM0Ajg1ML2OOdSYV+IS3sifibEBVNTPygl6EQgRY7R6OMV6X+R+?=
 =?us-ascii?Q?YaBBbdXQyB6KyPknSqXDFALiEkqtufdDSz/gUQiNKiNuR+en3WKC77+797es?=
 =?us-ascii?Q?zyxHzN49QJWt65nT7d2eaGXDkNFF54Zpw9bhy5UlSUpVU2+2Cq3V6Q4apR2X?=
 =?us-ascii?Q?qOowqxGffUFSqDMOR5RYMJG3DZ1pmLQGPVYJ0CAYQyfURnEnVnUL1crIqA7D?=
 =?us-ascii?Q?BNhyo2TbVrF7kScuu9U0t30Dbdck1HFQbtvXRyaJvGQPEzJdxdQSDeKXxoZA?=
 =?us-ascii?Q?9jAOhEmbA1HHRKCWSm4kdgzMzD115VBnIFLyjzc8LmpUsYSl8TJl9hI7PJsn?=
 =?us-ascii?Q?2Ep8QCf/lr8xvfNCl2Vw2kBFMw3KGzzL5nzNSnZuR0MTtyHRABmPXlnr7rzL?=
 =?us-ascii?Q?eJhYLWjZOyyBrAB3Bd3H6zwliOHCSBMlCeCcs9EqYJiAbGXshtqGM/+s/oCQ?=
 =?us-ascii?Q?+ZNWXpONmBIXW1hI0Hk33S4/mmXWWz+siCXydgJCowv20KWdDJMddyEDJN4H?=
 =?us-ascii?Q?iW4AxEka/MJmzu65SjYdsgtDU1X7L/nDqR6zR4tESvpyDhqTtv0kVfluvtbi?=
 =?us-ascii?Q?OYGxUwPisgMVppWU9QLGCvNzRUO0cT1/L6OhX+DdBXu8wxS0IdcMP3q+bjOB?=
 =?us-ascii?Q?UNE/O5V0B5zNjeSaUkC4eSGUC8K9VWK3+9gI8Fea+vJpBVoequ+F8oxQ07YX?=
 =?us-ascii?Q?UmzgtK9fvaDKDd9uzhFiFsVccejrohjbCDtHKsTOTowSXZWPXo/b8zZFVl42?=
 =?us-ascii?Q?OHhKIbiIPP8mzi4DV2uH/TvbrTEvZKpA1UHXXaA6FylZaiK6dAA5lQX+EAel?=
 =?us-ascii?Q?O3khtjXE7dFfOlPr5da0J3FQl1vwXmN7Z6rUju+GW75MVGhegIdZqAklQm34?=
 =?us-ascii?Q?nPkLZNqO+UcAyBM9E4sv4cXuUK9oMsl0hFFn9POVCEZeM6Fu06v+EGA743H9?=
 =?us-ascii?Q?geUL56iTLKX03mifCmkKEUeD00cBZvOxVe8DHVOhQgGpmQ5wpUnabW9Q/tk7?=
 =?us-ascii?Q?cxIDFAJNlFBZ5Cp3GMiD7QtQjOVkx0+ttrOy6svmhAZVfQRkLtyDw1hoFWu+?=
 =?us-ascii?Q?2tFyq0JOJQRm7xi64cHgdmxj3n5HQ3Rm9CeO/jQQJbbCzjYMReB0Hjg735k3?=
 =?us-ascii?Q?LmnNCtlbxy55MlCJ/+HABIF227BN2GtYmAANvBzNA3Q/s9UBP01C/YjzSMfA?=
 =?us-ascii?Q?fRQ5keq0H8xeWivopaMIzkQh41oMkRArMZpmal4Z0aZ7FbAF5oPCJtbnAHuM?=
 =?us-ascii?Q?Bulh0+RmYD4RSyPNNsfZ8fOeiqenGxE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4822b997-e07e-4f07-a88a-08dee992e0e6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 14:50:18.2832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/uKpa2Pribi6UnY5KTeDBsm1c+yftwX0PMEvoTY1pZFgey7O3MawsXBuhKRu4RWU7oLR2MsNn28S5ERSMEKdBl01JySsxSlY1vAs5RNe80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7904

Document the Agilex5 SoCDK with the eMMC daughter card, which uses the
shared HPS SD/eMMC host for onboard eMMC instead of an SD slot.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 0b418d9d60db..ce3a8c1679e5 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -112,6 +112,7 @@ properties:
               - intel,socfpga-agilex5-socdk
               - intel,socfpga-agilex5-socdk-013b
               - intel,socfpga-agilex5-socdk-debug
+              - intel,socfpga-agilex5-socdk-emmc
               - intel,socfpga-agilex5-socdk-modular
               - intel,socfpga-agilex5-socdk-nand
           - const: intel,socfpga-agilex5
-- 
2.43.7

