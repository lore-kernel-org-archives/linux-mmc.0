Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08542505AC;
	Thu, 17 Apr 2025 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744902796; cv=fail; b=sI16MxwccEU7KVdB0PcjENR5wxicvFc22PgqNl869XhuD/U8+qp3rsbOwEqggfCUS10cM6VwWPfJjqyA7HRZE2wDPPVyG2O3OwfixMAYbkvWdnTDgc3VgdUaIwPdp6j29ywC023oXra6zObe2TDXWUO/r/tr6bdbvo6j8JznLsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744902796; c=relaxed/simple;
	bh=Y10v/6kGEYr4f1Ki+0aYf+BHFXup5QkneNu9mh+hk00=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IWnANzT2g4JzkLKwAUFwTdQsfR5nW5Q7Z5tz5Be0XjnG9sgBuR6KP0i8nOPJHIrhPX+uC+vmtt7+8bgNnchLK3X/UixvNFUZlu9el2SMlvQljBzEj1tLFDSBLJdloabH9Rppsp6qy+DJS9+hwyc/hJtalIF3aVjqwX5WcKzshy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cluzJyTF; arc=fail smtp.client-ip=40.107.22.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cluzJyTF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3ZY391Re1wPsxvX36tHZu+Xb00n1CR9CX59sHzHEn7WX/57Ojgic9sfPpFHSdJPyLMpndOj7CX63k5gKcgnz6n6xLX8RDTy4817X4OHQEIyxZckoEm9SujhxJ6pU6zUb2V6S27vc6kPEchaIyO2Bfwh/Z1+kcvDf0lw7JXX3AqBt3FlyNUfm1ymZIRRzYTEVdKptPWjoMLg8jiPlDpzjMkA19+RR6beGTwAxpcr9oJkUXSX52wFtbC7lBiM4ztsobXfb8yRUj0LTSLKbCrum5+KXVPq16rOv/KDnuBodHWWegSF+roAapPSVp6U87WrcGsbfWT73QT2sQwcT+zuCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVIzq6ufQRI6sBArrbRPlj6d/HzIECqoYrBIqNhnsZE=;
 b=SFlBMsnZHqNvzkfPpYBXjocKSV562qlYD/lx/WT/rnaVmBNtZdby8TDP/eA8Fx/dxP/7JiQYrNEZyIwBzsPKh7jLIVPja54jC5Yy8uIvl1r9yQs3zy8z3Zdq5lYm7Dxi6A0qePQaHS3tgdB33zCnEWsrwhMblCeJGta5G5h5FkFAiDD0bwfrO3pAjSyQ9v+APjsKynKRDoad4RarZdM966fkb+TuUNn2q8wdISq53PVQBVApyAg26wXqwZuKQiCaxKwCmTriO3giRoOS5T+wsAxiExztQLdViflYNknh0q5Txgmr4OrXuxE3CxhHQgm4pTWtho/0jgk4LnNScpn6GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVIzq6ufQRI6sBArrbRPlj6d/HzIECqoYrBIqNhnsZE=;
 b=cluzJyTFMz7beBYGAJDUkkJBp0O4tW88B+BhkA7TApGBI75gOWktGN53nLuSHShgPq0V5ppYtjik0jCmR5d3z4z8+D/8qSnzWr8h842cR1tArfOURzMJTda4pJPAmefpVbmPo6SZjQzlGTRfLvtNCB95ja2we6Caw/Za5ZjkHxIYJcPXVTL5ANYEYFmxWZ8bHs8bgPNheKq8K5hIc9mKujqB+CkjLHyXkXFyNktesqQmTT/1K7NIoek/SPNIuCLa5FSSXosLGvnXNTLVDb41CPXvqArHQLPx/Zu7vzclFPbRCv5OaS1X2i7jszRixLC88iaivilwNPgKgpKO37utog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6817.eurprd04.prod.outlook.com (2603:10a6:208:17e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Thu, 17 Apr
 2025 15:13:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8632.035; Thu, 17 Apr 2025
 15:13:12 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND...),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: mmc: fsl,esdhc: add compatible string fsl,ls1021a-esdhc
Date: Thu, 17 Apr 2025 11:13:00 -0400
Message-Id: <20250417151300.3570021-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR22CA0008.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: ca633628-50d0-4d08-0aad-08dd7dc25eaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V5FdwngDmpSWnSRKcQhHS04rBEhZk3dW0SQPRzqQP6mJzOyZ7xG3OlqEYgoK?=
 =?us-ascii?Q?+11X2Vkk1eagWSDyulcEnwpIal7YU7oNtOeyLzI1y4bXUxldFpEv2IdqzBcJ?=
 =?us-ascii?Q?WcdQk4b9+fQMBxkwKAEwpQW46/rzK+Q/3X3TMnVhBqHweKix+8rCFiE6fC09?=
 =?us-ascii?Q?f/SM6wZPFTUcHszTVZhM+nodYbPKAgK8h/1jgxFSS0ZI0jJPjRyLDOcdfygM?=
 =?us-ascii?Q?N3Qy286ixYPiimC9NHWEaDGWlbE/ocG+kwZOkkX3yjvXXUq8etHjP3EdWUoN?=
 =?us-ascii?Q?Jc2f++r9ojERyPiV2DkRbH8NLxGsLUz4k5rJNYvhT2D/ZcsaDQEVGruNvEBh?=
 =?us-ascii?Q?sP3LrvI/RVFsh4QpsPWUBnP7qS0zGcXIYigcOs2FoCFEe4mDOimIaNphmtKq?=
 =?us-ascii?Q?3z9iCo4aKG73sXNHm7xRxCxcNEq6nmGJ21sjI3sKBmslTNGRWPsMZGlln5SJ?=
 =?us-ascii?Q?DdiL4f5zB7a35+oVSon5Baq8hnejFWGpEn8FU+pWZsIIgmDVEsjUEMjqND0r?=
 =?us-ascii?Q?NDIF8prfo4xtS9U36EbOq8c+4XzZ2gJ8INBFhkfZDzrMN/lNHFSBztIzdOJO?=
 =?us-ascii?Q?9UsvwyXk7h4+N5TJpWbxqNTYYtLojRKZ1YKd5FAxDi2ysTYWqDVv06k4/fOG?=
 =?us-ascii?Q?jV8Ff/o7/HfsGw3439DLGxjRXWJI/nohGTJ4HN2hgEkXfjVmsNXe55bVwuEs?=
 =?us-ascii?Q?/tDrEQi8znO+jCsSGB7y0U85Rna1BeboHX1gFOdyssfEg5QGUZ1iqNLBOdGK?=
 =?us-ascii?Q?bbXkfgFuFKKODUofXM/gWUiYdSOULh7IYiSsGp7nLnutlRN5EaQjEmQAkNa9?=
 =?us-ascii?Q?OsVg00X1so690XSCxDUibnpAAJmmg6p2in8wGudp3YBOBowKZ7Vd2LE9APEI?=
 =?us-ascii?Q?JVZOw4+WZUOcf69niEiUAsfL/iyC271PDLK0BdSs3v3efjGChbe1mGE/3zFc?=
 =?us-ascii?Q?WKBiCzaJHDSxvU9LqYfJV2q/R+ZZkB0QdzstHP5SRw1AJ3Gf0ba49Pfx7CK4?=
 =?us-ascii?Q?6KesdlGO6+MZz76huYXnt845ak4y3X/SW7oCHAQpSMEZyE4nmRpf1x7M/FNj?=
 =?us-ascii?Q?2LLf/UsV/xiYFTNWZ9DAmScFrOo6TST6yTLOdjNperjFsBkmXGpfc3sQ4NrL?=
 =?us-ascii?Q?1CNYP9jnwv/0p7EmjoWO0Djer6VouqwSXsqT5X8wMfTM6iRauPhypzlzU91G?=
 =?us-ascii?Q?zFr0fv6S4GVQGWhPeFW26C82UMkQOhUoNXVAnBYA2F+fbxvAC0jWOCwZ9E7b?=
 =?us-ascii?Q?tsTLItWP5nmVEnIxLWuwtab362WO/YwZUrsk15H9/aHXA/LHVkBNxgC1WABj?=
 =?us-ascii?Q?yivkILYjHu6XkNRdhhhagjFOoprFLz8oUh1hKFloKvPn2afQBZ4yzhIB5jP5?=
 =?us-ascii?Q?hkapVo0uCCw6EQjyvIb3tkVqPIkYvBiqTk5Bju7ssxaj+w0Eoi64affhHoXw?=
 =?us-ascii?Q?1SNmffXE9+yMrOBhK03dehOIZnOy1ly1SH610YLQGQ0+XBKHNDjW4w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5IW5U/a4S1RoKHgDTYPj0FYbHplKZtzU8zEc6TPzxi/8UtI6NhWehpjEALpT?=
 =?us-ascii?Q?5kkY4cUW283THFbgV2QiaDc+XsEgNOTmBGR/NlVjSbzTu4J7TOoSGS9OQtKS?=
 =?us-ascii?Q?o6aStVm8kejIbhKDLg11kDjrw6zKvL+yyG2LMVAaxIJGNGFvPFAj11qhgKpd?=
 =?us-ascii?Q?tww5+ZerWnK04CEj0XfaEnXkijVlIy+If2uZ+4i9KbJpJm2MCgjVfn5GKL9y?=
 =?us-ascii?Q?jTvo9EJA/bzx2rs6/iognMvY65jJMQWWRU9ZIxcnxForU3ZpUVGuic0xfSQn?=
 =?us-ascii?Q?pNUEO7DgxeYrFom2GxgTyuiscF/B6755bT4EdVEw/8d2I9IkDVKjBcZOPisx?=
 =?us-ascii?Q?ogNoegyZ2PL34W8ACHkEKTDeiVI7K6eO2UMniz4zUMAEqJ0gaw8vGL9mWyHi?=
 =?us-ascii?Q?e+/PA4a73D475pEnZ+AIuCY7lQs+Akjw3xQiQqXXEi+3HMelEjPBu8+nwBrf?=
 =?us-ascii?Q?ggTQHngRwM1mVjoc8nqMUUnmPZKtcpTUG1B287oyA7tSyujPsG+kjz23Nf9Y?=
 =?us-ascii?Q?FDr+39S4AjGmRdxtHpSVl80k3aXLaV3Hq2lHxC7v4tgpMRfFk9PAkwuiZ22k?=
 =?us-ascii?Q?78t1JRoPH7sCL4VIxPZe/b6cBQiBYSssI4MO/R0xtq0ITEYK9+hLD1Gjox30?=
 =?us-ascii?Q?3bFUwuDaP+Fa9X4lqsyWeOyxc4TPZbHoO67yXvx+6G2K8RLUDFjxCC5YBG+p?=
 =?us-ascii?Q?iJCOMGfHAaQjkK2ouhJYcgFF421dBlGaob/x7CkfV++6G073j2Pg+Joo0Otp?=
 =?us-ascii?Q?uWaU2KRATn81O0gGeEr0rchwuZRNOk+Le0N7k56g96mb5b1BgqZdEluMZLIK?=
 =?us-ascii?Q?QK5HNjLkoiGzYJM6Svk5akHiBK93DrFZJnCpDD6jc0xz6fe8hUvG0hn/mYKh?=
 =?us-ascii?Q?9SEH4C6ZRagu3apg6biWYAwwUrqIdsdvkDFTLDFZOs6h+NhKK9R6Ja6w94t7?=
 =?us-ascii?Q?b8nKkip1pTNnVmMnKldkzgV4ptaD+jzXG4dbUpYKYnJnHMAH1MUt13wOEHcW?=
 =?us-ascii?Q?meceybTqs7aIkJ6H1VROFPXJqGVTLiNrEv3/E02N5YvFCpzjlKzbTbVobVot?=
 =?us-ascii?Q?AndZyxEf76mTzpteLvvNiyrY6EJlLBpJ64V8r9l94IDmULClfhNCIVhlxTdX?=
 =?us-ascii?Q?cUn4GkS3eIeZS7+euu49wVqFOsJjX6UuxIb81o6pgJ6nYl9F/nvzx0wcTaha?=
 =?us-ascii?Q?cCsXfjrYz4y4N4amDxBV53m6SWubcm3D6RFBBrArYBmYP1ogCimfvo54HSnA?=
 =?us-ascii?Q?tdgU8R6opvuvKtYOAnAgYzHrMvb+qk7MIUSoWukAACuXc0MemzVRa/jOeU7u?=
 =?us-ascii?Q?VivAI8EqqCicxkHDyOv0ZOk5nCf0UXkAoDj7bRan8FL2rKzxIc99hvt28p/x?=
 =?us-ascii?Q?r7C4Ir9PYmcarFBtYjiICJzYEmJqBsgyPF6/0qEFa1bS1PddDsW+UvLCOqwG?=
 =?us-ascii?Q?ke5g0ePRtOYpDmpMDZ7iveX8y/jMBYkMaOFrLsKZE7EeUc1ACi+DMD5sTaY0?=
 =?us-ascii?Q?utTPtEvK/2WkhwX+kQbDdoOzEueyKnjPg6IXHzq97TbTJs0H/QHPB31OfGzW?=
 =?us-ascii?Q?oTaLr7BfBNfPN7GymqA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca633628-50d0-4d08-0aad-08dd7dc25eaf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 15:13:12.5707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipQZwxeJG9bQRABsA5mhsSzpvBn/7P98QewMM4yz/rMrLwffyMqGg/xpnjC6fX66d/831Hcy5koDWZQcg2rfLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6817

Add compatible string fsl,ls1021a-esdhc for LS1021a SoC.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml
index b86ffb53b18b5..62087cf920df8 100644
--- a/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml
@@ -24,6 +24,7 @@ properties:
           - fsl,t1040-esdhc
           - fsl,t4240-esdhc
           - fsl,ls1012a-esdhc
+          - fsl,ls1021a-esdhc
           - fsl,ls1028a-esdhc
           - fsl,ls1088a-esdhc
           - fsl,ls1043a-esdhc
-- 
2.34.1

