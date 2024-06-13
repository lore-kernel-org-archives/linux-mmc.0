Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2083.outbound.protection.outlook.com [40.107.7.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B8F142E9D;
	Thu, 13 Jun 2024 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289158; cv=fail; b=tv/JhAoZbqvD8p6XfVEGyWrm3IknZE5d6v4JV7S0WnacrKxHFJ6L36ImHgZRqrTc1ne5F5jg7y0EMD+RFmRfiVq1cWMGx8fBpjiMW42nUkkwBSIrELyyJuZTYBAsBmaX1TkkJgHDQLp1UCGskrN+hMSAYcvFmzRPiiEM8+aOp8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289158; c=relaxed/simple;
	bh=KO/9Dii51hytfogf5YTfygqSFnJxkMKRwTRQWXcQWZY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=s7Z8b6XmeeS+w4lYRpjaNdi6uuvc9RHw6AMDxpYPMWzGPJQD0uKXMWJ+7du/BTwMFcPHc0GNzQV5qKEvobOjdQqn8jcByRCUQW908HnjHbbT5cSU1F0S4dbbJqkKLVdsC9eVLhXHAwTr6jFGz9sH6JL1vAvja+kdECxCSLXG+cE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=J7ScDJNq; arc=fail smtp.client-ip=40.107.7.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J7ScDJNq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WG8TvsVv6s1b+4fYYrj8xsRPj4JWXV6y5BorkuQUKhH4k39z/6Mse1Sdnh0bQV0zV2+DPC+rIiU/f+GCQ1LQswCxTfZKrtJfYi/06WkROj2flXPDFchhrEl7V9D7bGUc4qbW0hPZYrnKrVY+cvwZcQEytPd1aIpEhlHABHLhNMJ+3Ilu27DYO6ikhNldX0hNs0vxfOVxGDZfQB+rh8y6waG1rPa5GAXZkBgSedhjH4O3Wpw/NCHJ2ZlnMgr1WNNIGyVJEEyAVB1Ss58VKK/Tw7ukTLrW3TYerEhROs4Flyh8DG8Scp+66Zs3xSBFbZImeCY1A+xiKsVpJTRZ6xYmWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrGh1vSUxjxrYTHKhqnht0YI2ZzYqgsKipEZ3IzHndQ=;
 b=gMLP5FnnbZFVAZihvrJlperSOb4Phsu6wj+CYDhA/gr190+qtds13ok35smHSgd3aQvVT10jLxCfEVfacujMBm7t7rLLK3nYE8iyrj02iL587XCEcI6T2sC1koFQ6mYJJNK2kb3U3xLiRFBzZYxDnAKhS0ElGvVJcowMVth+FH37Es11n9o+WEsBbemd/0bu8pYqqnPPwyhQGpq+azPfM7PDl6J5zF/ES/P74XpM4oFYoTcx6n/7Ve/2Da8WNQ6GYGYczE5fq2IkM1wVkw0AiiL77BS/fQ9QmPOydgmiiCljffdclWBX2D7vDts/Ml8gIdixOL4pSF1ByHJ4wgxTzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrGh1vSUxjxrYTHKhqnht0YI2ZzYqgsKipEZ3IzHndQ=;
 b=J7ScDJNqI8AGGO0vDemG88z8V3nR2ujsgI16TS2amrj4JiwLQ7U/rjlTAFqw7OOn8xFoosZ5ljzBUpmmL++H94d+mZqSMJ5A1Zmyfhj33FaStq032NbT/PwDYqgwhDMNjHiQh7F2dHalqtZlYnDaNUjcB/RR7GtIQNCg8DbZI5w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8256.eurprd04.prod.outlook.com (2603:10a6:102:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 14:32:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 14:32:32 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 13 Jun 2024 10:32:06 -0400
Subject: [PATCH v5 2/3] dt-bindings: mmc: Convert fsl-esdhc.txt to yaml
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-ls_waring_esdhc-v5-2-36644e2fe21c@nxp.com>
References: <20240613-ls_waring_esdhc-v5-0-36644e2fe21c@nxp.com>
In-Reply-To: <20240613-ls_waring_esdhc-v5-0-36644e2fe21c@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718289143; l=6976;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=KO/9Dii51hytfogf5YTfygqSFnJxkMKRwTRQWXcQWZY=;
 b=l/lMHqciyUBU8tRo4FAyNsDO1amWBxYRxkqokENGNjbDDtvI/CgbREKHG5rx6G1fJ/rSHt3GE
 juttPMNN0pUAShcwWr5sr9Jx9EjR7CuWUy+YyxhlScYr1vol7JvvaRJ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b5b6c5e-916c-416d-ac1e-08dc8bb5a90b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|1800799019|366011|7416009|376009|52116009|38350700009;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUpnK3FvMllNbDFQRUpvdlhObkxzTnN0RXljZy8wbU1TS3ppUjh5Q0JGRDEx?=
 =?utf-8?B?K3p4dllZWVJPZXBqczQzYW9ibFJ1RlBOYU9GZzIyYkQ0dXl3amhRZnZ0TVUy?=
 =?utf-8?B?c3JGdzVrMmRPelNwZ0UvckJJc0NwKzAraDgvWTVqUHNOVUJtSGVBRXp5SVRx?=
 =?utf-8?B?aU9GbmMwY1ZMKzhEdm1oekZYZk1CYU1VaU9yVEl4NVdoTVgxcjBwK3h2b3N5?=
 =?utf-8?B?SzBSWmNiMjYxWFRYOE5mM3ZEeXZKemVIZjFIM1lBQlY5VDNqV0lVQ3REZFdN?=
 =?utf-8?B?ME9Vdzlha0VDMCtDek5aNVdhcDlYSmtUUlJZVUZtUXFhQjJrbnRHY2V2eFRi?=
 =?utf-8?B?ZmRybWNIaTdvVnZuS3pBc0w0VTl5LzBObXhBa0xqQ0N3NXZVYTNadmlzZUh5?=
 =?utf-8?B?S2VoUWVCMkJpMFB3dHlTNFZjREU5b21sOE9GZkFzMm1CYW5BV0hLY09FcnR1?=
 =?utf-8?B?Zm5QeVNyajYvSUgrWnJpZkJ3Z0lWbWZocFZ1REE5bjVmWHVuTUZsMmxVdnEz?=
 =?utf-8?B?K1ZNV1RHdFFnRGVIRkRMemdneWRXM2EvRGhCSGhsK2VIS0dScnY2NExqb3FV?=
 =?utf-8?B?cjBLYU5IMGk2dmdtdk9MOXVkclAvNTJMWThqS29VMTl1NnZ1R25KdGZqcVMw?=
 =?utf-8?B?dkFlZU9ObnZBdm8vZGRQM2xUU2Z4TzEyZlJsOW85L2hIUXNQYUh0M1NFdWRZ?=
 =?utf-8?B?YTZxc3hFenZrOHV0WHh2VlR3YUpjNVFnY3h3Y3ZPZmoyUTErSmxSTUF2LzNi?=
 =?utf-8?B?Qy8yOExoNmtIY1VSWEd2Z01kdlBSdi9GTWsxbCtqaXFmcmhmZXFsWVRVRFQ0?=
 =?utf-8?B?anVFNktqMDRrL1FrblZVSjdNQWpVN0FRcHNTMEVhN1JmMDRRaFF4RmdLT2dm?=
 =?utf-8?B?Wm1uM2pmZHNueVNQNytwTlNsOFhYdURMRng0aXBiSUtXeVBITzlyOERJOXVv?=
 =?utf-8?B?bmthbkZzb1NweDBTNXlBZndDVkZhaXNpT2h6THZwV2laVlhXYjFuS1N5T25i?=
 =?utf-8?B?bno0Mjdad1dmTjJRQ2JTdSsrRld2aEdDdi9ta2ZqUFBzSFhyQVZiZFY3UThJ?=
 =?utf-8?B?Y1FWQkpXUHBieDQvTmdwWE9mVzM4ckVRcGUra2JXVHo4dWNJRTQvMkkwclBl?=
 =?utf-8?B?QUJnVkt6REJTaHRjdlBvNU9Ncm1iVHhEcUxDeEVPYWpXRE02MkQ1MTNwNW94?=
 =?utf-8?B?R2ZDbzVZL1lqQVRQcGVmRTFMMGJoYkRSQkRvYTU4amZ2bUV3OUZTR21yUDA4?=
 =?utf-8?B?S2JuL1M3TXVad25WVGRPOGpUbW0zdkYvYU90OFkrdGhnb2w2Uys5WHBCdWQ2?=
 =?utf-8?B?ZEM5YlpZbEhEOHpJRWVDWHNFc0VtQW5aSmNuY0tXd1oyNmJQWVlzdmh1VjAv?=
 =?utf-8?B?SllzS1I0Slp6OVc3alRZWWRVaDJYaUpZd01DdmlyWXhEUVlQUnk2R1dJcTFw?=
 =?utf-8?B?c1luQTUyUG5mMWNXSk8rRmZCSnprUHptWlR6M0xmM1NETmhKcmlKdU1sVlpJ?=
 =?utf-8?B?bGlMYlJkVm9ubGN6bjhha2JkbUVvaG11MUtaVUpnOSsveENsQnU5TGRLRGVO?=
 =?utf-8?B?OWtwZy9uUEwxcXRpVllVaC8wdEl0MlQrT2ovWGpwbll3V0NFZUJCRHBldUV1?=
 =?utf-8?B?dnBYOEJLcjhQRnRPbFN0bUlTRmZwbDBWejgwQyt1di9xZnJObnFIUllPWWVS?=
 =?utf-8?B?aEZqUWZSMktDa1JOYVprY3pZdWJJQTIvSjRldThYcUVqek5LSVZndDJZcjRv?=
 =?utf-8?Q?CfV8fi/4vgrtKAV7CWQY4N7DbmIXw8cJP+Stq8C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009)(52116009)(38350700009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmNSQ0I0V05DS2plTVUrSE1veTFVZWQrUndrd2E0TE85Nis3QlhFQ3RlRkIw?=
 =?utf-8?B?VnlYNklTQzF4ekRxaUcyMnNwZGxyL0dGaGhLTEN6WmVLUjUzN2R2d3ZjZlZq?=
 =?utf-8?B?ekpTT2tIRTNTL2IrZEcrU0UzZS8raDM0a0xDN2Y3UmkzOEI5UEJUVGFvRmox?=
 =?utf-8?B?RUwwNVZLU2hNRjUvNzNZcHM1MkRHdnk4Y1NsSUczWW9CZnpEdFhiRFdCNlF0?=
 =?utf-8?B?bjd6bFdHdXlQenF5bGFtTURpSVFCUGZpeUhqUmx5clkwRExFNEpOVDRJbjgr?=
 =?utf-8?B?aE4wcDFWblN5OTRSN2htVVMrZGliU2daMEFmYzJiSTNCZ0hYVytHbVZCV2VI?=
 =?utf-8?B?T1Z4aU50UXdmWXI0dStHVGRHWkc2TXRVbml2NHFJejUrOWR2L1JNMU5ZbkEz?=
 =?utf-8?B?MlBMRDY4UHZyWXJSNjM2WXB2eVkvVjZsUU1sZnQzQmM1b3FCSjVxSks1N0VZ?=
 =?utf-8?B?eVM2aHFWMGVUakFpVEVFZDdNNDh1aEJMMGhSamVtbys5YlVBMk5iaysrcWEr?=
 =?utf-8?B?MFFjbmVYK04weHFwSmhPbnZmTE9xRjFycDI5Zy8rNk1wRGhqTUExR1hUNTRo?=
 =?utf-8?B?V3NmTEozM1o5N1M4dFU0MmJxMitUd2NaUEVHMHFQMklzVitNUjhzZ2dYaGRQ?=
 =?utf-8?B?eGVkWGkvbmtzT0tXdkdBVnR4bW53RHJzODFoSnh1NGt1Wm5JLzN6c0RlU0pp?=
 =?utf-8?B?S25DUHFTbEQ3M2wxbEUzZEhVQWlqOGhZRm56eUIzSVhYdnlsU2NaM2RmZFJ1?=
 =?utf-8?B?WWYvZVVJeUZMR0ZDaEhEQnRKS1hFdTR4cmIwaXQzREsrK2lLYmlQWFB3YzRq?=
 =?utf-8?B?M2xCYTJqMjk4RkRCaXROeUxEV0tRT0EzQ1Q1dDRtT1JQbWk4RHBBcUl1MmFr?=
 =?utf-8?B?SnBJNy9WZ0hjRFlsSGxKVlFEclBKK1NqcUtKbmtyRXZmUG9ldnJlaVZES2Vn?=
 =?utf-8?B?eHlmU0J4RzloOEREOVg2dlRvTXpPNDhMQVFrL2YyZ3JRSEZ1cmVxWmxhVVZM?=
 =?utf-8?B?bm1XYUF0TzB1bUJxZlgzSk1PRlNvVC9tOW4xeWJpdlNhcXh0Q052eHNEZnVi?=
 =?utf-8?B?Q1dSN04vZnVoMzREQXFKdEpINnpZcGtaU21CRWNEZXRGcnZnMUk1ei9Ceng3?=
 =?utf-8?B?L21Za3g2TmJ1WEFCdVphYWl4LzZtb2IxOWRhbnh0Y2RpdXpFQmwrdGVTT2h2?=
 =?utf-8?B?ZlFpVitnRzd0c1ZyejJuQ2xTbkF3RE9pWXhJeFR3V1R0dXo2N3JTSEcvaUlm?=
 =?utf-8?B?S0ZTQjZZN2tyYnNCZk9jMkt6WDd3RVc5TUxpRE8vUWJ2THhYNGtVeHJlMlJk?=
 =?utf-8?B?RjMxbVVYUmd4ZDlkN3JNWERzd3JjWnZOWGhHQXU5WG9yeGJ5bk1wRjVLS2N2?=
 =?utf-8?B?SkxJOS83U2ZKc2d4VlNXU3VSMzFSdytmY3JxU2xvT0o0QlFFbTI3UzdRT2Yy?=
 =?utf-8?B?cW15MnN4ZGxpTWhUcHhlWGhUcEQ5enBkY0pFRndhbjBPNVljMDNpZ2ZMbGc3?=
 =?utf-8?B?NU95L2p0R1NDK0dnYUp0QW1Od0xGWGY0WmhGaTgybnVMZWlHdHVTSEFXYnUy?=
 =?utf-8?B?Mlk1RmxFTk1STks4a05ZMU9LN05ZanVZUzluRnVSMk9UM2lYUWROUEVuRUdz?=
 =?utf-8?B?T21EVW9GcEYxZ1o5eFcwVFFoOURRZ0lqTlFUUGxzaW5jaDMxQjhEUVI2MGdo?=
 =?utf-8?B?WlN3YjcwcmVXYWZaTmpDVDBBNXJLc0JJcXY3U1ROSXlKa3YwUmE0MDk5MXBo?=
 =?utf-8?B?OTlTVzBGcDZVY1NnclNtR2hvN3FKWFBhc1ROU1VZcGhSRmUrSkUwQmY1Um5B?=
 =?utf-8?B?N3JSRFZwcnFEdlRqNVRTcVVINGNHam9sUW9qVUZaWjVHU0tkYStVSUkyVGJ3?=
 =?utf-8?B?N2FNU2xDVmVNcm5KM2JYZ0E3UUpobTFPZjhTa3Y5YWJrRXh3SXBPU0pVVkg4?=
 =?utf-8?B?bGJrN0RqNTg5Um1NNkhLeFFKZEtwRUxlb0xWQW00VlNrTTdvbHV4elpWNE9h?=
 =?utf-8?B?Rkt3RHBLSCt4Q1BCbDM0UDlhc20xL1J1VngxTTRwOWNhbHZqcFBSeGQ4dWcw?=
 =?utf-8?B?U092WU9BaGd5Mk9ORVFPOVpOa0dVaDBvRVJtQkRyZmR3SXFic2JCNmtlUGlL?=
 =?utf-8?Q?t1X1VGJmmvTWHTZBcW+c9ABXC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5b6c5e-916c-416d-ac1e-08dc8bb5a90b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 14:32:32.2353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A9CIPwo0p98HQRTcByjCU/34o7GdXU5kziOApPFyr34ecig6NPFg89aeDJLziUiQauKwoXpzoKujeWlmXh237w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8256

Convert layerscape fsl-esdhc binding doc from txt to yaml format.

Addtional change during convert:
- Deprecate "sdhci,wp-inverted", "sdhci,1-bit-only".
- Add "reg" and "interrupts" property.
- Change example "sdhci@2e000" to "mmc@2e000".
- Compatible string require fsl,<chip>-esdhc followed by fsl,esdhc to match
most existed dts file.
- Set clock-frequency to 100mhz in example.
- clock-frequency is not required now.
- Allow dma-coherence
- Add clocks

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v4 to v5
    - Add Krzysztof Kozlowski's review tag
Change from v3 to v4
    - Remove clock-frequency from required
    - Add dma-coherence
    - Add clocks
    - Not add Krzysztof Kozlowski review tag because some additional change.

Change from v2 to v3
    - add minItems and maxItems for voltage-ranges

    Change from v1 to v2
    - use filename fsl,esdhc.yaml
    - Add clock-frequency to required
    - change clock-frequency to 100mhz in example

    pass dt_binding_check
    make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,esdhc.yaml
      SCHEMA  Documentation/devicetree/bindings/processed-schema.json
      CHKDT   Documentation/devicetree/bindings
      LINT    Documentation/devicetree/bindings
      DTEX    Documentation/devicetree/bindings/mmc/fsl-ls-esdhc.example.dts
      DTC_CHK Documentation/devicetree/bindings/mmc/fsl-ls-esdhc.example.dtb
---
 .../devicetree/bindings/mmc/fsl,esdhc.yaml         | 105 +++++++++++++++++++++
 .../devicetree/bindings/mmc/fsl-esdhc.txt          |  52 ----------
 2 files changed, 105 insertions(+), 52 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml
new file mode 100644
index 0000000000000..b86ffb53b18b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Enhanced Secure Digital Host Controller (eSDHC)
+
+description:
+  The Enhanced Secure Digital Host Controller provides an interface
+  for MMC, SD, and SDIO types of memory cards.
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,mpc8536-esdhc
+          - fsl,mpc8378-esdhc
+          - fsl,p2020-esdhc
+          - fsl,p4080-esdhc
+          - fsl,t1040-esdhc
+          - fsl,t4240-esdhc
+          - fsl,ls1012a-esdhc
+          - fsl,ls1028a-esdhc
+          - fsl,ls1088a-esdhc
+          - fsl,ls1043a-esdhc
+          - fsl,ls1046a-esdhc
+          - fsl,ls2080a-esdhc
+      - const: fsl,esdhc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: specifies eSDHC base clock frequency.
+
+  sdhci,wp-inverted:
+    $ref: /schemas/types.yaml#/definitions/flag
+    deprecated: true
+    description:
+      specifies that eSDHC controller reports
+      inverted write-protect state; New devices should use the generic
+      "wp-inverted" property.
+
+  sdhci,1-bit-only:
+    $ref: /schemas/types.yaml#/definitions/flag
+    deprecated: true
+    description:
+      specifies that a controller can only handle
+      1-bit data transfers. New devices should use the generic
+      "bus-width = <1>" property.
+
+  sdhci,auto-cmd12:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      specifies that a controller can only handle auto CMD12.
+
+  voltage-ranges:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    items:
+      items:
+        - description: specifies minimum slot voltage (mV).
+        - description: specifies maximum slot voltage (mV).
+    minItems: 1
+    maxItems: 8
+
+  dma-coherent: true
+
+  little-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      If the host controller is little-endian mode, specify
+      this property. The default endian mode is big-endian.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - $ref: sdhci-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mmc@2e000 {
+        compatible = "fsl,mpc8378-esdhc", "fsl,esdhc";
+        reg = <0x2e000 0x1000>;
+        interrupts = <42 0x8>;
+        interrupt-parent = <&ipic>;
+        /* Filled in by U-Boot */
+        clock-frequency = <100000000>;
+        voltage-ranges = <3300 3300>;
+    };
diff --git a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
deleted file mode 100644
index edb8cadb95412..0000000000000
--- a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-* Freescale Enhanced Secure Digital Host Controller (eSDHC)
-
-The Enhanced Secure Digital Host Controller provides an interface
-for MMC, SD, and SDIO types of memory cards.
-
-This file documents differences between the core properties described
-by mmc.txt and the properties used by the sdhci-esdhc driver.
-
-Required properties:
-  - compatible : should be "fsl,esdhc", or "fsl,<chip>-esdhc".
-    Possible compatibles for PowerPC:
-	"fsl,mpc8536-esdhc"
-	"fsl,mpc8378-esdhc"
-	"fsl,p2020-esdhc"
-	"fsl,p4080-esdhc"
-	"fsl,t1040-esdhc"
-	"fsl,t4240-esdhc"
-    Possible compatibles for ARM:
-	"fsl,ls1012a-esdhc"
-	"fsl,ls1028a-esdhc"
-	"fsl,ls1088a-esdhc"
-	"fsl,ls1043a-esdhc"
-	"fsl,ls1046a-esdhc"
-	"fsl,ls2080a-esdhc"
-  - clock-frequency : specifies eSDHC base clock frequency.
-
-Optional properties:
-  - sdhci,wp-inverted : specifies that eSDHC controller reports
-    inverted write-protect state; New devices should use the generic
-    "wp-inverted" property.
-  - sdhci,1-bit-only : specifies that a controller can only handle
-    1-bit data transfers. New devices should use the generic
-    "bus-width = <1>" property.
-  - sdhci,auto-cmd12: specifies that a controller can only handle auto
-    CMD12.
-  - voltage-ranges : two cells are required, first cell specifies minimum
-    slot voltage (mV), second cell specifies maximum slot voltage (mV).
-    Several ranges could be specified.
-  - little-endian : If the host controller is little-endian mode, specify
-    this property. The default endian mode is big-endian.
-
-Example:
-
-sdhci@2e000 {
-	compatible = "fsl,mpc8378-esdhc", "fsl,esdhc";
-	reg = <0x2e000 0x1000>;
-	interrupts = <42 0x8>;
-	interrupt-parent = <&ipic>;
-	/* Filled in by U-Boot */
-	clock-frequency = <0>;
-	voltage-ranges = <3300 3300>;
-};

-- 
2.34.1

