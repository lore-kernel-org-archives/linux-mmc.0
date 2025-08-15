Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA38717A310;
	Fri, 15 Aug 2025 03:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755228244; cv=fail; b=SWIVI1NMNp0uENIN3yNxXdDtLhS1MwYu5Kk0PHTjQP5iTndjr3oemY/uV4haUfZoSSH7J8Lg6HfNXtAgJGyOp1LoGSzSC2/OvmbeqPq53rSUw60qPj6vB6XuORWsMv/yDKFc11WPAzzVVFDRQ9tyfx92DN+MvlAhZvt5ak94n78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755228244; c=relaxed/simple;
	bh=qeVdXj3+nI3zguuJIkX9AAfbhRqJByuLshmPgkhHako=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gZOlnP6u8r9ChxEN7Xh0Qzj2NgV8rqwMugxYWOOms3dZGJ1Rb7+uMIS64V3bY6fA/cH4tqjoEKSHpGCu4cMLFwdam6Vq5E3MRQz6yPpfBxqYmn5+N5ssxL7fkqxBujIkD5M+xvZgudXthrE00Bf71OfAcI77nrx4+ONrtJIXzDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eiwpCxh3; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eiwpCxh3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iz1u2CvDcu7DQAql74n/ao1HRnC8siFn5f9OUceYhzOdIkYUh2g8BSlSCVfudy2y3Dk6Q6djLUULCWGn8q4VcdovA2vU4VxaWOVjUi5tiz0rE1cY62ng/kQmzv3kXjouiPBFaBjWTQ+62PE3M+piGPIdYt7T0xwcuGFJ2vTLIfLKQwYZgJf5vT6l1URUgFrqTzQtShfOB1wQXyKLORS+fSzT09l+T8fwrSuRESn68QbBHn/PD011Wy62PS04X3gt2qJKezJFyXSBiGUlXMfTS91wZp8g00zGkinWwX1fRwitbu6ETBcNp8yGR6XxDtpZbB6uEI7R0e2ADcglDjOiRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeVdXj3+nI3zguuJIkX9AAfbhRqJByuLshmPgkhHako=;
 b=Ilcx0+xcfFbkpGR2TVWBD0WixDqu3qLbHiz4TZHfTDwzBoWIUbxyUiPehM/Z6S62r3Caz+TEwX0hIC8V17nxViYHjNibkw/ST51gn1zqb98PnL7lfs/n9HRTGWlVYQJq5BPGoBSXLRhyXzeuLSOWxyEWro00NN6+iCQ/J5oNeXwG8F1tlvISiEG9DnO47Utxry6FMeFoKUtlgM3siyXidTcs/BRdZNPd1LZCnIMFjiUnPRZo5eMl9BNkiw8dWdBhCqifD61Tr+2MDT5edlfNrjiFl+u87GgT0HeqXJaJjqjIY0zIr5pkVZ5/NRH9IV0Ii7iHI3+UTiv+Vmbx9W5ylA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeVdXj3+nI3zguuJIkX9AAfbhRqJByuLshmPgkhHako=;
 b=eiwpCxh3HY0f2Vqr5pDso0n8aMKSfjyjXSPrnaVmW2+/VxOVDnfRIl7kVhdYBLJIAv/KP48U2ZlSQhPc93IGtNFuUnA4N9vurL3dJjMyjLyO98LGPcsBccP6pWPDvcU2L0lY9U7THDv8yCb9qdt5YlfOYlD/tNCPnrnzTMl9iaCM9OZ2UUzpjEKxzdoauNR/pJb5pw8/ybhNq7wCS792501HyZ97wa34fnI148rGxWgLSfWcBSP26nfIyyIR3DH0vQ/G3rTcXo2KsetHZV65NwqCGKNYcXD4wGF5QnD46Gv8mfyI3zPga2mVZT5JhLLoB7aju5XYjnfxWTNqbxIkNg==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DBBPR04MB7660.eurprd04.prod.outlook.com (2603:10a6:10:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 03:23:56 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.9052.006; Fri, 15 Aug 2025
 03:23:56 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Jisheng Zhang <jszhang@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Aubin Constans <aubin.constans@microchip.com>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	=?ks_c_5601-1987?B?TWljaGGpqSBNaXJvc6mpYXc=?= <mirq-linux@rere.qmqm.pl>,
	Jaehoon Chung <jh80.chung@samsung.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Heiko Stuebner
	<heiko@sntech.de>, Russell King <linux@armlinux.org.uk>, Chaotian Jing
	<chaotian.jing@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>, Kamal Dasu
	<kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Florian Fainelli
	<florian.fainelli@broadcom.com>, Michal Simek <michal.simek@amd.com>, Eugen
 Hristev <eugen.hristev@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>,
	Ben Dooks <ben-linux@fluff.org>, Viresh Kumar <vireshk@kernel.org>, Orson
 Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, Patrice Chotard
	<patrice.chotard@foss.st.com>, Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
	Alexey Charkov <alchark@gmail.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 18/38] mmc: sdhci-esdhc-imx: use modern PM macros
Thread-Topic: [PATCH 18/38] mmc: sdhci-esdhc-imx: use modern PM macros
Thread-Index: AQHcDYdwduwgOZLH7ECF9A+giqakjLRjDCug
Date: Fri, 15 Aug 2025 03:23:56 +0000
Message-ID:
 <DU0PR04MB94962993C99F922CCF93FB6F9034A@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20250815013413.28641-1-jszhang@kernel.org>
 <20250815013413.28641-19-jszhang@kernel.org>
In-Reply-To: <20250815013413.28641-19-jszhang@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|DBBPR04MB7660:EE_
x-ms-office365-filtering-correlation-id: b41a5105-ae25-47eb-2853-08dddbab2ae5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?ks_c_5601-1987?B?eXRDaXZsRE4vYUhPL0V2OEZMTTRkbUZObEttd2pqRVpCYnZlQkgr?=
 =?ks_c_5601-1987?B?NlZqQVFxaXVTYzYvREdzc2V5MmEvM1l6ZGlPZVk2WFZRZjVJOThI?=
 =?ks_c_5601-1987?B?SFlsRkJrWGYyQlZrclpRekMxVzlxYVdWR2JZU3lzQXdPSHpFcUVp?=
 =?ks_c_5601-1987?B?aC9kMmV4akVaWUZFTDJHOWErczRuTkxQR0dpSXFoenllZFpXU1U2?=
 =?ks_c_5601-1987?B?ZWkyWktaR3hLWU16aUQzQ0NXc3RGRUladjZXZHBWc3RpVXBaeHpB?=
 =?ks_c_5601-1987?B?VDR5dkgxNWhwVnozV2FOT1RkaXhLZTlZNFptZFhSbVNucktJRito?=
 =?ks_c_5601-1987?B?N293dGx1dDV3UlFaNVB6VDhNeXU1NzR3aW5DaHdYWXdWSXh2bkt4?=
 =?ks_c_5601-1987?B?bUhEWUNoUnRON09LclcxUzloNHNmeFFqSlBqbWJoanlSZmlrUC80?=
 =?ks_c_5601-1987?B?MC9iWlVqcXhHbUpJWHBnODcxazZGU0JsZDBWUzBwKzFJa3RJYXpt?=
 =?ks_c_5601-1987?B?YUdkVXdDbU95TGFjQThVMVlRcU1CSjNYY1FzYWcvWnpBQno2TUZX?=
 =?ks_c_5601-1987?B?ZmpVQ1V4Z0U5OEZqdmxZclJ5THRUWlVSZFM1WUZMSXdNQitKaThC?=
 =?ks_c_5601-1987?B?YTI1bmNzalFNYjg5SlpZRDFqQnpKTHhmbnVtUkE1S3A0M1NTSk9F?=
 =?ks_c_5601-1987?B?YmRkbVo1Y0NpemhDbDdZdmNIMUFsZmJvbm9lUVV5bVBoaUNKOHRG?=
 =?ks_c_5601-1987?B?ZmxwbjU0OWZzZkF4Wjc3WlNsVnhGV1pSUHlYWlJqV0s2dEVZa1lq?=
 =?ks_c_5601-1987?B?SEVlcVBaY1U1RFZpVjFTREF0RFN1MXYwRlJmQWJSZk5mQ29hbW5o?=
 =?ks_c_5601-1987?B?UnlCbjF4eU9rUW1WMk81RW9SMlNNOUxXV092SlUrYmRPN24yRFhx?=
 =?ks_c_5601-1987?B?NkxBc0FhN1QrdHN3OEp2R0p3TUxwOElJVWpJdFFWSW80aHNINk5X?=
 =?ks_c_5601-1987?B?a1RER3N2OGtNTXQ2eDVvdjdQL1JGdTdaQlQ2TloxY1VRVFdkbEtB?=
 =?ks_c_5601-1987?B?eVQwdnJ0U2c4UEdTTHVxakRzYXZOWTZLS1JEcGpDWkRHWmhhMDB4?=
 =?ks_c_5601-1987?B?Tk9DczU5QnFPczFyVGlaRExscFVGMnF5YUY1cVNKcTB6Z2hPTUFM?=
 =?ks_c_5601-1987?B?S3RUVU5oU003QjJmMjNTSEFOaUtGU3BFVDBjNEJPYy9zSzhuZ0RD?=
 =?ks_c_5601-1987?B?cDNaeTlVaHdRYkRyd0U5WTljelUrWGhYcDFTWTJFUnBBMlNBTkZ5?=
 =?ks_c_5601-1987?B?WDAvYTJhekR1QkVNQW1rVUFyeGZPV3FRQm9KM3FzS3ZHSEN6TnZp?=
 =?ks_c_5601-1987?B?MXh3UDhkaWhYcUMxUmNLQWxCWGZkVTVONll3dzVPUWR3VTMvY2Fk?=
 =?ks_c_5601-1987?B?TGdHaC91NkFKNWJsOTUrdFhpVGJWWXFYekgzZEJzWE9Qa2tTYjlB?=
 =?ks_c_5601-1987?B?YkFWSHFMa1ViZ3dLZnFUS25lMVNBOFJqYnExL3o5QlU3bCtwbGxQ?=
 =?ks_c_5601-1987?B?aElvZmUweFBQUStPckFIclJYbVFtWnVudEFMd2RWTWlTVHluUGcy?=
 =?ks_c_5601-1987?B?UDdFNWY5QU9QMEdheEFYQkJKRk1oTGhiQnFFaXUwQzFxcXVSK3FJ?=
 =?ks_c_5601-1987?B?TjQvOGZuUklGK1lYWWY5LzVqaitJWHVMK0RmaVRpUUREQUp0dWtx?=
 =?ks_c_5601-1987?B?dktQZFcwN3BaMWlobElQdTcyTW9yV08wRVZBZFdRL24wWUZwT3ZK?=
 =?ks_c_5601-1987?B?UnpUN1RQU1hQR09pS1Rza3g3NkIwMjRzV2xZeEJESkZsZnlsaGdx?=
 =?ks_c_5601-1987?B?d3d0MktvOFZLVGdaeDJoc0UvZlhsT2lBR05DMEViKzBTTnNmSU1B?=
 =?ks_c_5601-1987?B?UUtBcEhXcmJSeDVBcFhZMVVZNEY0bnM5NmR1QzdIWjJXL1NmWXZV?=
 =?ks_c_5601-1987?B?eGowYUpmTzZkOWdZZERlWGlRV0lkNkpkZ3AyaTVCM0dXMzlLUmti?=
 =?ks_c_5601-1987?B?YWNxK2E0dnRqMzhPS2dWenNOT2RRejExUUF6NUVqTDZiUGJrcGNY?=
 =?ks_c_5601-1987?B?SXFwTlNQaU5UTHluTGZxYm5WY0UySEk1bHRGVmJJZ2dCZ2NKR3Fi?=
 =?ks_c_5601-1987?B?SUoxaHllR1FaTmlkYUQwanhMSTVzVldnYnpTNlI0azdVMHhjS3BE?=
 =?ks_c_5601-1987?B?Y2pySk9JU2ZoTEFvMzh1UWt5TiswSlpObFgyQTl2dzFvMWU2ZW5D?=
 =?ks_c_5601-1987?Q?dWETqhYF4YtrCVUY8GJT5dn/zHGKCJ/Hw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?ks_c_5601-1987?B?bG1YbXZwNjhZdElrbU8vaFFVbkd1UTEyWVVOdlZJa0dZZ2pIRC9r?=
 =?ks_c_5601-1987?B?WVJHWUhXU2VzbG9jUDRBVUY5TFFFbHFJdlBudWFPRkRTNUV2TnYw?=
 =?ks_c_5601-1987?B?TUxzNVQ5a3BKRmNaajJ1eXZDNng5RDdkWUtmMFBnT3NsK20wMU1D?=
 =?ks_c_5601-1987?B?TDU1ZWltdmNRdlpXZVJPRGhIQW5GaStNbnBGeDJGaDFQYW5lM2Z4?=
 =?ks_c_5601-1987?B?VlJ1Rjg3aW5xdEw5Z0FtRk9lVC9qeHdWYkRHancvL2Zmb0dJSGRl?=
 =?ks_c_5601-1987?B?WUVvSWJEQTJWZ3JRTWJVZmU3cmJwbnJMMTFseGcycUQ1ZDV4MHlP?=
 =?ks_c_5601-1987?B?R0NERERLVjFiQWxkWk9FTTVYNXlWMWRZN0xuSUlhNld6alMxSzNP?=
 =?ks_c_5601-1987?B?bnhoNWxJZlU2ZWk1RTA2NjBEb1o5VDIwcmIyOWVkYkZsVFpjaEVM?=
 =?ks_c_5601-1987?B?aUtxSEQrbVcvQjA5clllK1hGVklpdDFtbG1QeGVzeENFVUd1R3U1?=
 =?ks_c_5601-1987?B?RHZuUExNczN3UW9kb0t1dWdtY2xEcFpvK2dvUitaTjBVblBHS1lG?=
 =?ks_c_5601-1987?B?T1QrYzF6QUw1eUxzbURaQ1JkUmFmbGNrbmVqL2VBcTdsRjJYUS9z?=
 =?ks_c_5601-1987?B?WG5wYm40QTVMRzNHSUVkc3orZnNUMi9xZENhMXFFOENmYlFaWHRM?=
 =?ks_c_5601-1987?B?NExCQlNjUFljK1c3SjI4NE1yWHdhSXNTMzR4WVRxMTNCKzM1Y2Nw?=
 =?ks_c_5601-1987?B?K0Z5aEpmRzh4YnhleXFMM3M0a2ZHZGNONWFJRjE4cDkybUU4UDRG?=
 =?ks_c_5601-1987?B?elBXdWZWOWk2UGgrdmRXYnhZNjkxMU94L245dzcvNFFnZDFINkxJ?=
 =?ks_c_5601-1987?B?d2tpbEhDQk9LcCtXMS9kRUEwb1M4Y0pGUzJqSXBpNnJMVFdKaW5K?=
 =?ks_c_5601-1987?B?bEt6NFRBYTdwaXdlKzJGOWRIZTFYN2YyUG5TTnVqMlBjTFl3Y2c3?=
 =?ks_c_5601-1987?B?d21zSUhVMUFMUStEd2prSEZtaTNsRTNnV29qRno4M2xhZ3M2OERK?=
 =?ks_c_5601-1987?B?dVRPWU9JbGZMcGlKSmVlU1RvWHorV1ZDdUtHNEw3MXFkV25YTnhw?=
 =?ks_c_5601-1987?B?ZmtVTUhMZUdaVmNZSkVLaDF5SEIxNktXSjk3NndFMEtGRHhEbjB5?=
 =?ks_c_5601-1987?B?Y2NtTTBTbDlPV1Q1cllpQ2V1aGlYTjRGTWZYRFhQZVA0eGRNNzA1?=
 =?ks_c_5601-1987?B?M3NNcFBLM2llWHhtKzdpYUlROXdpT3k5cVNZMXhXaTVsZkJxN0dt?=
 =?ks_c_5601-1987?B?R2dEd1c2YjB5UzhER0RMbm10cFhjK1A1bDAxaDFNWWdJcWh3S0Fr?=
 =?ks_c_5601-1987?B?Z1JpcHNUbkZmMWVlMDZzbEhWYUY5L2V1WWpRcU1OSHZRSTFwczlG?=
 =?ks_c_5601-1987?B?R2x4M2FzYWRKTHdZMEZDV0o5ZFJiL2Q3eFJnYUpGWW9iRTZJMnpl?=
 =?ks_c_5601-1987?B?aGtxblU3L0ZjS3VpbUdZV0dTaTg4YTJxazVnOU16VEQ5d2lJajl2?=
 =?ks_c_5601-1987?B?L1ZxMFJYc1VxY0d6QytBZEVPaHlXRmx6M0lsYlRZU092SmVqUVlo?=
 =?ks_c_5601-1987?B?bzQ1M2lCR2lpdllDZ0dKZjdXQWppa0U0d0VVQ21hbXVOOVptZUlW?=
 =?ks_c_5601-1987?B?eDhRUHpBeGhMa0tOaHlpWFFHRDF6aVpQaVNaSXkwREE3Z1RqenlM?=
 =?ks_c_5601-1987?B?N3dlTmhna1pJR2xoS2FZcVNEOHk2WmV1TmJtd0pXSVN3VUordjdB?=
 =?ks_c_5601-1987?B?dWFhMkhLTEVYRFJ3SFAwNlkzYUpuS3p2aFJlZG1pWE43NXkwaURB?=
 =?ks_c_5601-1987?B?MDBjUldLZjBRbnFVVXFzSFduTC8rV2tJdjJITzRmNngxTkJVUGJY?=
 =?ks_c_5601-1987?B?ejRFS0ViYU5KR0tEbEpIUDU5NG12MzdEOTBtbS8ycjZXVG1vZldw?=
 =?ks_c_5601-1987?B?cTdnZm8rSjVnVDVXTmNhbm9ZZXplT1NWZ3Y0Q0ttaC9PWHp5L1lG?=
 =?ks_c_5601-1987?B?dUZvTVlRSXZTK1NSandjSmw4Yjk1YmRtSFJnNDdKZlUxQzUvOG9O?=
 =?ks_c_5601-1987?B?ZE9UVVdnUzkxUVVTRERHOG1CcWFqaVIvSW1ITFVBMmpOLy84ZC9u?=
 =?ks_c_5601-1987?B?MUQyYk1yVWYyTzYrYnlwM0FpWmIzY1N3d1FWZlBQOFE0MmFvSTFk?=
 =?ks_c_5601-1987?B?c0hTRHNheEJOWWh6RDVjUGU0ZGgvU0J0WWRGTFgzVFNjWTRjZXFE?=
 =?ks_c_5601-1987?B?b3M1SUdBN1VOVXJsUDJBakI0blpIeGZ3MUFENkhidkFtVW9RbjJQ?=
 =?ks_c_5601-1987?B?T0dMY01QRGV3TzgzSFVhTkh6bXRnSGk0WTVyUjByRWlXYm9kaVBS?=
 =?ks_c_5601-1987?Q?MUhJb7wBhJASCQw9pe0=3D?=
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b41a5105-ae25-47eb-2853-08dddbab2ae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 03:23:56.1849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RlOFcsKWt1FNXY0IcFbnB4gZ600qkxta17MfGJcgTmfupyRNiIqOAzdmwfbZ9adWJNqvQaQWFurQg2cnWyGD9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7660

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKaXNoZW5nIFpoYW5nIDxqc3po
YW5nQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjXStDjqxTE17O0gOTozNA0KPiBUbzogVWxmIEhh
bnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+OyBBdWJpbiBDb25zdGFucw0KPiA8YXViaW4u
Y29uc3RhbnNAbWljcm9jaGlwLmNvbT47IE5pY29sYXMgRmVycmUNCj4gPG5pY29sYXMuZmVycmVA
bWljcm9jaGlwLmNvbT47IEFsZXhhbmRyZSBCZWxsb25pDQo+IDxhbGV4YW5kcmUuYmVsbG9uaUBi
b290bGluLmNvbT47IENsYXVkaXUgQmV6bmVhDQo+IDxjbGF1ZGl1LmJlem5lYUB0dXhvbi5kZXY+
OyBNYW51ZWwgTGF1c3MgPG1hbnVlbC5sYXVzc0BnbWFpbC5jb20+Ow0KPiBNaWNoYampIE1pcm9z
qalhdyA8bWlycS1saW51eEByZXJlLnFtcW0ucGw+OyBKYWVob29uIENodW5nDQo+IDxqaDgwLmNo
dW5nQHNhbXN1bmcuY29tPjsgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPjsg
QWxpbQ0KPiBBa2h0YXIgPGFsaW0uYWtodGFyQHNhbXN1bmcuY29tPjsgSGVpa28gU3R1ZWJuZXIg
PGhlaWtvQHNudGVjaC5kZT47DQo+IFJ1c3NlbGwgS2luZyA8bGludXhAYXJtbGludXgub3JnLnVr
PjsgQ2hhb3RpYW4gSmluZw0KPiA8Y2hhb3RpYW4uamluZ0BtZWRpYXRlay5jb20+OyBNYXR0aGlh
cyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPjsNCj4gQW5nZWxvR2lvYWNjaGlubyBE
ZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT47DQo+IFNo
YXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz47IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5n
dXRyb25peC5kZT47DQo+IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtIDxrZXJuZWxAcGVuZ3V0cm9u
aXguZGU+OyBGYWJpbyBFc3RldmFtDQo+IDxmZXN0ZXZhbUBnbWFpbC5jb20+OyBBZHJpYW4gSHVu
dGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47IEthbWFsDQo+IERhc3UgPGthbWFsLmRhc3VA
YnJvYWRjb20uY29tPjsgQWwgQ29vcGVyIDxhbGNvb3BlcnhAZ21haWwuY29tPjsNCj4gQnJvYWRj
b20gaW50ZXJuYWwga2VybmVsIHJldmlldyBsaXN0DQo+IDxiY20ta2VybmVsLWZlZWRiYWNrLWxp
c3RAYnJvYWRjb20uY29tPjsgRmxvcmlhbiBGYWluZWxsaQ0KPiA8Zmxvcmlhbi5mYWluZWxsaUBi
cm9hZGNvbS5jb20+OyBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+OyBNaWNoYWwNCj4g
U2ltZWsgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgRXVnZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3Rl
dkBsaW5hcm8ub3JnPjsNCj4gVmlnbmVzaCBSYWdoYXZlbmRyYSA8dmlnbmVzaHJAdGkuY29tPjsg
QmVuIERvb2tzIDxiZW4tbGludXhAZmx1ZmYub3JnPjsNCj4gVmlyZXNoIEt1bWFyIDx2aXJlc2hr
QGtlcm5lbC5vcmc+OyBPcnNvbiBaaGFpIDxvcnNvbnpoYWlAZ21haWwuY29tPjsNCj4gQmFvbGlu
IFdhbmcgPGJhb2xpbi53YW5nQGxpbnV4LmFsaWJhYmEuY29tPjsgQ2h1bnlhbiBaaGFuZw0KPiA8
emhhbmcubHlyYUBnbWFpbC5jb20+OyBQYXRyaWNlIENob3RhcmQgPHBhdHJpY2UuY2hvdGFyZEBm
b3NzLnN0LmNvbT47DQo+IFRoaWVycnkgUmVkaW5nIDx0aGllcnJ5LnJlZGluZ0BnbWFpbC5jb20+
OyBKb25hdGhhbiBIdW50ZXINCj4gPGpvbmF0aGFuaEBudmlkaWEuY29tPjsgQ2hlbi1ZdSBUc2Fp
IDx3ZW5zQGNzaWUub3JnPjsgSmVybmVqIFNrcmFiZWMNCj4gPGplcm5lai5za3JhYmVjQGdtYWls
LmNvbT47IFNhbXVlbCBIb2xsYW5kIDxzYW11ZWxAc2hvbGxhbmQub3JnPjsgQWxleGV5DQo+IENo
YXJrb3YgPGFsY2hhcmtAZ21haWwuY29tPg0KPiBDYzogbGludXgtbW1jQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0ggMTgvMzhd
IG1tYzogc2RoY2ktZXNkaGMtaW14OiB1c2UgbW9kZXJuIFBNIG1hY3Jvcw0KPiANCj4gVXNlIHRo
ZSBtb2Rlcm4gUE0gbWFjcm9zIGZvciB0aGUgc3VzcGVuZCBhbmQgcmVzdW1lIGZ1bmN0aW9ucyB0
byBiZQ0KPiBhdXRvbWF0aWNhbGx5IGRyb3BwZWQgYnkgdGhlIGNvbXBpbGVyIHdoZW4gQ09ORklH
X1BNIG9yDQo+IENPTkZJR19QTV9TTEVFUCBhcmUgZGlzYWJsZWQsIHdpdGhvdXQgaGF2aW5nIHRv
IHVzZSAjaWZkZWYgZ3VhcmRzLg0KPiANCj4gVGhpcyBoYXMgdGhlIGFkdmFudGFnZSBvZiBhbHdh
eXMgY29tcGlsaW5nIHRoZXNlIGZ1bmN0aW9ucyBpbiwgaW5kZXBlbmRlbnRseSBvZg0KPiBhbnkg
S2NvbmZpZyBvcHRpb24uIFRoYW5rcyB0byB0aGF0LCBidWdzIGFuZCBvdGhlciByZWdyZXNzaW9u
cyBhcmUgc3Vic2VxdWVudGx5DQo+IGVhc2llciB0byBjYXRjaC4NCg0KSGkgSmlzaGVuZywNCg0K
V2hlbiBJIHJlbW92ZSBhbGwgdGhlIGNvbmZpZ3MgdW5kZXIgUG93ZXIgbWFuYWdlbWVudCBvcHRp
b25zIEkgZ290IHRoZSBmb2xsb3dpbmcgYnVpbGQgd2FybmluZzoNCg0KZHJpdmVycy9tbWMvaG9z
dC9zZGhjaS1lc2RoYy1pbXguYzoyMDc5OjEyOiB3YXJuaW5nOiChrnNkaGNpX2VzZGhjX3Jlc3Vt
ZaGvIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1mdW5jdGlvbl0NCiAyMDc5IHwgc3Rh
dGljIGludCBzZGhjaV9lc2RoY19yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KICAgICAgfCAg
ICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fg0KICBDQyAgICAgIGRyaXZlcnMvbW1jL2hvc3Qv
Y3FoY2ktY29yZS5vDQpkcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jOjIwMTc6MTI6
IHdhcm5pbmc6IKGuc2RoY2lfZXNkaGNfc3VzcGVuZKGvIGRlZmluZWQgYnV0IG5vdCB1c2VkIFst
V3VudXNlZC1mdW5jdGlvbl0NCiAyMDE3IHwgc3RhdGljIGludCBzZGhjaV9lc2RoY19zdXNwZW5k
KHN0cnVjdCBkZXZpY2UgKmRldikNCiAgICAgIHwgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+
fn5+DQoNClJlZ2FyZHMNCkhhaWJvIENoZW4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEppc2hlbmcg
WmhhbmcgPGpzemhhbmdAa2VybmVsLm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL21tYy9ob3N0L3Nk
aGNpLWVzZGhjLWlteC5jIHwgMTMgKysrLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kt
ZXNkaGMtaW14LmMNCj4gaW5kZXggYTA0MGMwODk2YTdiLi5hN2E1ZGY2NzNiMGYgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gKysrIGIvZHJpdmVy
cy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBAQCAtMTY1MCw3ICsxNjUwLDYgQEAgc3Rh
dGljIHZvaWQgc2RoY2lfZXNkaGNfaW14X2h3aW5pdChzdHJ1Y3Qgc2RoY2lfaG9zdA0KPiAqaG9z
dCkNCj4gIAl9DQo+ICB9DQo+IA0KPiAtI2lmZGVmIENPTkZJR19QTV9TTEVFUA0KPiAgc3RhdGlj
IHZvaWQgc2RoY19lc2RoY190dW5pbmdfc2F2ZShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCkgIHsN
Cj4gIAlzdHJ1Y3Qgc2RoY2lfcGx0Zm1faG9zdCAqcGx0Zm1faG9zdCA9IHNkaGNpX3ByaXYoaG9z
dCk7IEBAIC0xNzA3LDcNCj4gKzE3MDYsNiBAQCBzdGF0aWMgdm9pZCBzZGhjX2VzZGhjX3R1bmlu
Z19yZXN0b3JlKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KQ0KPiAgCQkgICAgICAgaG9zdC0+aW9h
ZGRyICsgRVNESENfVFVORV9DVFJMX1NUQVRVUyk7DQo+ICAJfQ0KPiAgfQ0KPiAtI2VuZGlmDQo+
IA0KPiAgc3RhdGljIHZvaWQgZXNkaGNfY3FlX2VuYWJsZShzdHJ1Y3QgbW1jX2hvc3QgKm1tYykg
IHsgQEAgLTIwMTYsNw0KPiArMjAxNCw2IEBAIHN0YXRpYyB2b2lkIHNkaGNpX2VzZGhjX2lteF9y
ZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gIAkJY3B1X2xhdGVuY3lf
cW9zX3JlbW92ZV9yZXF1ZXN0KCZpbXhfZGF0YS0+cG1fcW9zX3JlcSk7DQo+ICB9DQo+IA0KPiAt
I2lmZGVmIENPTkZJR19QTV9TTEVFUA0KPiAgc3RhdGljIGludCBzZGhjaV9lc2RoY19zdXNwZW5k
KHN0cnVjdCBkZXZpY2UgKmRldikgIHsNCj4gIAlzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCA9IGRl
dl9nZXRfZHJ2ZGF0YShkZXYpOyBAQCAtMjExMiw5ICsyMTA5LDcgQEANCj4gc3RhdGljIGludCBz
ZGhjaV9lc2RoY19yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiANCj4gIAlyZXR1cm4gcmV0
Ow0KPiAgfQ0KPiAtI2VuZGlmDQo+IA0KPiAtI2lmZGVmIENPTkZJR19QTQ0KPiAgc3RhdGljIGlu
dCBzZGhjaV9lc2RoY19ydW50aW1lX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KSAgew0KPiAg
CXN0cnVjdCBzZGhjaV9ob3N0ICpob3N0ID0gZGV2X2dldF9kcnZkYXRhKGRldik7IEBAIC0yMTg4
LDEyICsyMTgzLDEwDQo+IEBAIHN0YXRpYyBpbnQgc2RoY2lfZXNkaGNfcnVudGltZV9yZXN1bWUo
c3RydWN0IGRldmljZSAqZGV2KQ0KPiAgCQljcHVfbGF0ZW5jeV9xb3NfcmVtb3ZlX3JlcXVlc3Qo
JmlteF9kYXRhLT5wbV9xb3NfcmVxKTsNCj4gIAlyZXR1cm4gZXJyOw0KPiAgfQ0KPiAtI2VuZGlm
DQo+IA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBkZXZfcG1fb3BzIHNkaGNpX2VzZGhjX3Btb3Bz
ID0gew0KPiAtCVNFVF9TWVNURU1fU0xFRVBfUE1fT1BTKHNkaGNpX2VzZGhjX3N1c3BlbmQsIHNk
aGNpX2VzZGhjX3Jlc3VtZSkNCj4gLQlTRVRfUlVOVElNRV9QTV9PUFMoc2RoY2lfZXNkaGNfcnVu
dGltZV9zdXNwZW5kLA0KPiAtCQkJCXNkaGNpX2VzZGhjX3J1bnRpbWVfcmVzdW1lLCBOVUxMKQ0K
PiArCVNZU1RFTV9TTEVFUF9QTV9PUFMoc2RoY2lfZXNkaGNfc3VzcGVuZCwgc2RoY2lfZXNkaGNf
cmVzdW1lKQ0KPiArCVJVTlRJTUVfUE1fT1BTKHNkaGNpX2VzZGhjX3J1bnRpbWVfc3VzcGVuZCwN
Cj4gK3NkaGNpX2VzZGhjX3J1bnRpbWVfcmVzdW1lLCBOVUxMKQ0KPiAgfTsNCj4gDQo+ICBzdGF0
aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBzZGhjaV9lc2RoY19pbXhfZHJpdmVyID0geyBAQCAt
MjIwMSw3ICsyMTk0LDcNCj4gQEAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgc2RoY2lf
ZXNkaGNfaW14X2RyaXZlciA9IHsNCj4gIAkJLm5hbWUJPSAic2RoY2ktZXNkaGMtaW14IiwNCj4g
IAkJLnByb2JlX3R5cGUgPSBQUk9CRV9QUkVGRVJfQVNZTkNIUk9OT1VTLA0KPiAgCQkub2ZfbWF0
Y2hfdGFibGUgPSBpbXhfZXNkaGNfZHRfaWRzLA0KPiAtCQkucG0JPSAmc2RoY2lfZXNkaGNfcG1v
cHMsDQo+ICsJCS5wbQk9IHBtX3B0cigmc2RoY2lfZXNkaGNfcG1vcHMpLA0KPiAgCX0sDQo+ICAJ
LnByb2JlCQk9IHNkaGNpX2VzZGhjX2lteF9wcm9iZSwNCj4gIAkucmVtb3ZlCQk9IHNkaGNpX2Vz
ZGhjX2lteF9yZW1vdmUsDQo+IC0tDQo+IDIuNTAuMA0KDQo=
