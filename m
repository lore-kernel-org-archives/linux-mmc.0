Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011032.outbound.protection.outlook.com [52.101.70.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB4137C103;
	Tue, 24 Feb 2026 11:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931752; cv=fail; b=TD0xVjFO46ghNt77h1HUsCE0AgFiTaIEgiS4Mw0pS3xXih9BJHf54HjCDd8fYDLY2Kcfvkb6ez4Lj2D2QaHKhP0zOY5MA7sDD89p51vG/4UMR6aQ++dk15OvqEMYrVl/Y8YnTYdIYGq44/KUkUOtVpifPUnMrk3oO5x8KoRG/m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931752; c=relaxed/simple;
	bh=G625wDxJWKjl/LMSQCIBUXPTaU0T74g7tM1j8Nk3wkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OcV5O4KcFiSWh6lId60NtqIkOA0gIH3sg34AXMCgjYHt80lM2eZz6HKDph44O0B2PiYhgEfazLHupjqWh8Hz2U6e2w51pvvy7uNu4eo2bb/9LZ3/j7VSaHxaDwFHK7z33HPbMNCLQ+FboAIxEna3VcT04A4h+tJPuMNRSKKjuk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YhfEzK5y; arc=fail smtp.client-ip=52.101.70.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YhfEzK5y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssw8X0ymVDkbh+b3SQEsPGale9LoZEjzbSvUG1yEu5GBYro8OrQWghcb0+G+mTfQ0WgpxeEpL/fGIlVwG9+Dj2kI9n29l5FtapjoNCSuQqoi0UvNNmlEfddX0qaVS0KNRydA07OH2BwHGIv5VsSkSYs8cxQhTCWl8ibGs2ZYYob6uCFzCcCfMCAwttburDVP0W6ephIaBN8fmCSAhIe47NK4v/H7iTO0oQJLoFNMfYVL7iLv4gduGxcpfY8JJu3DNn4eNNBZyq3fgRAQEZU1r3upS9nHBf+fmBvJaq7WaN2+7nsIuKSvhItL8D+qmQqerSO+luUY1zyFdAh9OH1nsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrXKJx/LPC8KGC0hxXhELZvufGKE0Ey6sYq/g0s1XHY=;
 b=Nx8jERaiAEgcgmjKqosh1kGXEe99ksNVFOXP+W0R1Q+PkrDc5FV5jLECSIm8D7KkGHjZP46qy6G44iMjwFve3uy1FIl2LfodZBWL0I66fL2sy7EKMVP0/CZbkJbXEpHw6wyF9+jXW8G350AMzvRqXhcaJfBRn14icUaJqf5CV31pFvP3hYQQb7rZXN1whiqPgDjTE6jz2meT3ahsihSkdgQcuE1AOwsmg57ugGSexc8wxWBCc6C5fItvks2/KZXMJgDsyGGO9qPgyDKntodl9kyJVrCW+pd5nFvNrhksqfEl/tek2mjKaYB3OeQ4GST+n/5Y+Ic33QzIVNgOh/+0eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrXKJx/LPC8KGC0hxXhELZvufGKE0Ey6sYq/g0s1XHY=;
 b=YhfEzK5yuxrONB0rar/CEeJNuAz0yg0wOBcaq0QOMh8GoyXYZ/TZes9f5V6tq2IQPPwrp7U+uNKMgE8S2+EqIBe+r2K4ACjlUIn2wue+h/QJ3uaPzRKYhLbTfnDVEm9hBq/ExqkRkROoFpO+O1R9RIsRSjtdGc6JHd2fJSCL1wlGsnePqGwhEjNn9/UrF1x4P8QRP+O7BASnB0/tE4YlgzgmdlR/UaB2EJyKLNWmI05X6+hUkC1cnNMTK5JDPDUbctAjDTfwmT1OtAV+bGa3PryPr29wb18K3BOZ+W1qX+S95OgX4ieRFM/bp7LSf1Ujab3Ud5Qn31fZOYf0I0CtMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by VI0PR04MB12114.eurprd04.prod.outlook.com (2603:10a6:800:315::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 11:15:46 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 11:15:45 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>
Subject: [PATCH 3/4] dt-bindings: arm: fsl: Add NXP S32N79 SoC and RDB board
Date: Tue, 24 Feb 2026 12:15:32 +0100
Message-ID: <20260224111533.3194883-4-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224111533.3194883-1-ciprianmarian.costea@oss.nxp.com>
References: <20260224111533.3194883-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::16) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|VI0PR04MB12114:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b0c6b2-58d9-43a2-9251-08de73960e65
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTFUd0k2VlVkV1NaeWtvNDVKd05rYVF6YzA5REJxY3NVQ0NwNHA1SjF1dkxw?=
 =?utf-8?B?N1Zac0hpb1NnRndUcDM5K2pLa05KQnlxaWJLbmpRbnhHSGh5TC9uaytSemJL?=
 =?utf-8?B?YngzQzhIL3h0SWY4WkVJMjY4Zkh0YzBzWEpFcTYrblZhMTF3M0pteHZkV3V4?=
 =?utf-8?B?dTdzMW9tMW5oUnp5VFlRdUdodkNhQS81bEtuWUc5cEcrTVFvSmwwWjlGaHht?=
 =?utf-8?B?K0pRdy9pTUhmVzdPbUFsQXd6cXhTTDIyOG5zVXdXTFJaYVZpdG5GbDRpY2Y3?=
 =?utf-8?B?ZnA1N1dRSmpUa2VvdStuTk1Yb0t5V1hlekVuTWVOQTV1cXZwVmp3ODNhRmpQ?=
 =?utf-8?B?cXBsR1NBWEJlNitHZjR6RllUK1NUaE1ja2trd1pGSkFpWE8zZTNZSUUyeWp1?=
 =?utf-8?B?eHZmWkVTMFRpaXJ1QWJFd3E4eFJNQktoSmxodjNDb0dGdW9xYktscjdPTWt4?=
 =?utf-8?B?VDBCRXdUL3NGNlZMWis3NHorZmFzaUQxUzJGMVRaMDd1YXZTVGUxZEpaRDZ1?=
 =?utf-8?B?RzlNSFV2cml1OGRPTEM5N2FkSWZseXNrUVVWaFFvRTZJM09INm14MjQxUUdq?=
 =?utf-8?B?Zk93b1NmMjVlK0ZIdlVRN001R0x2Q2tZMzdXc1ZzVFlMa0ExWE1VcExaSDQ5?=
 =?utf-8?B?V3JTcDVXY2xlcGgyWGdTWWNyTjdBSU85SmRCb0V4NDhRem5oWkx4aFpvZXda?=
 =?utf-8?B?cjNVWEdURjZqQkFlbkZmZ21sRG84L0RLVS9TSE9QOG9CbFptOTdMdDNNL1Nn?=
 =?utf-8?B?SlBtc1lRK0U1djBKVlUwY3ovY0RlUWtGL3JoWUdiMTZTMVBhWTJoblA0TXRD?=
 =?utf-8?B?SWlmS1l4Y1BXbWM1dVBrd0xHalUxOHd0UmNnUldPNmh1OFJJbFJSdTBqUk1p?=
 =?utf-8?B?UXdxeG0vMUZDRVZrdHJSQ2NaNStLY2EwMUsyUkV4NVZqOFRMbmZYNlNvN0dE?=
 =?utf-8?B?WU9CbVBMRUhVZjNFYW5BMm93SHg4S01PSWs2NWZKUWo4UUdqVzlVV1ByaktB?=
 =?utf-8?B?YmlVa2lFdjlTUENWd1JoYjJPYnRyY1RuaEtoaElmNFdGR2kra3ZkUmZyckpF?=
 =?utf-8?B?MHd0QUxoV0xiL25jcTNKRThsNk8xWGwrZndlcStZR2Z5MGFTaWNjeGNlZ2VH?=
 =?utf-8?B?eUhObEExdGNBZng4QXptUWdjTnFRUXdqOFRONHhiSHN5emk3M3MvOU5Qckp2?=
 =?utf-8?B?b2ZqQ1Z0aUFUdEVWYVZVcHF5ckNXV1M1cTNSaXlRZGhrZ2JhdU9vR1FXZlpr?=
 =?utf-8?B?TWlyOS9mbmFqcDRobmtMSTJtWWNMRjF5S1NSUDF6M0J2K09uRHdqQmdkL2pB?=
 =?utf-8?B?YzRlaUtzdG9PRjZKUE1BTmFKcSt4b28wZUF5d3Z4ZU83Wmg1MnNNWnkyRmcz?=
 =?utf-8?B?Wm9kVVpKdG0xNjdPWEVSWCtOeTM1Q3pXeWFiYWszdWN0Q3J5Y3JQMG5uQm5C?=
 =?utf-8?B?MkJ4NmRGRjQrai92QWRmUW9XbU1PZGEyRUVWcWREd0pCazA4eitqSkZ1VElh?=
 =?utf-8?B?M0JiZGJtMUJYeTNUaFZxTnJvSC9rUXFNeVBVMjVGUFRNY002UGJYWmt2VHkw?=
 =?utf-8?B?eGdNR3g2Z003V01XVnhJZTZBM09FNWVma0syYyt2K1VuakhpY29sZHljUlk0?=
 =?utf-8?B?bGpuVllvc2NyLzZGczJxVUttbmNTbU0rSkhOKzU2T3RGRk1GT1FqbkRuTWNI?=
 =?utf-8?B?QTRXN0FuM29COFFoT3hFSVlqTDNrN2dJbkJ1bHJ1U1laRlhacEJkZFpWRmV0?=
 =?utf-8?B?RlRsa3FxSWcwMnpwSGplTXdPSXhRa29lRTdjZld0MnZ1RkhFMFNyL3MwelVF?=
 =?utf-8?B?R3o1dlNHdW9kZFVnTk40S0MwVndwOUw1d3RoUXF2MGN2QWFLUkZjSk1yR1M3?=
 =?utf-8?B?dndzK2o4czk0K3ovUE9YeGNDc2cyV2ppdnUxNXVHQ01mVk9RYTg3VENPSzRq?=
 =?utf-8?B?UDdYek1ZRUxpVkJuUWsraFpRd0EvS1ZBMWFlQTZtVjgwekUzSHpuY0cxWTkr?=
 =?utf-8?B?L0lpOGdFa2lCd3ljdXNBUEVVSTJhODExbldXS2kycDJhekJ3ZVlkYklySnJo?=
 =?utf-8?B?Y0hXMWJFSXg5TlZUQjQ5VG9ERVhnamM1Z3dLUTFSVk5ydHlwRnR2SThuUW5l?=
 =?utf-8?B?NHRFNTVnYnBsZHBzV241T0FyNDltcHdHVmF2QkxGTXlZWlRoM1hkZWhhZWFK?=
 =?utf-8?B?RHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXhIZFRIajZGY3ZCZlQ3SkFYOURkejhBS0oydFhwRVNObGxJZTdOSWg4bW1w?=
 =?utf-8?B?Mkc4aFVHb2EwanRCbThlaEp6STgwNjRrT2RmT0xJeTBOQkRISGNxWDkzd1ds?=
 =?utf-8?B?RDI5c1grUkU1dTc4YytwMCtwRVVxRE1jYUpNN2pyaUxodFJ5bXdSUnBhY0RJ?=
 =?utf-8?B?eHFGZ3JvUnVDcExIZzJaTlZ3cjJKam1QcC9KeDZPdTJVRDhBeW1YSktYL08v?=
 =?utf-8?B?amxLRGdwYk5MUUt4a2l2eHNaSk1DVEV6Tm1tajF3TlhFcmJOM3BHNVVId2VY?=
 =?utf-8?B?bkNlOVNoU0QyMmdPSjhRZk4reVBEM1RKZkZrd1hOb1dicThDSEh5elpWSFJu?=
 =?utf-8?B?dVVqc2M2d2hkYWpyRExIUDFHeTF0Vk43L29UYmRKdVQrb3Jleld2a2d4VzVa?=
 =?utf-8?B?SUZpbnd3dmI3MkplbklET1hRaHJJaDQxU1F5K01iMHk4NHJkdUdYRlFTNjBL?=
 =?utf-8?B?MnRLbFVGMU9zL0RBaUo1emNlNjVOOVRlSE1CTENTdDM3WjVicXRwQWZhMXFn?=
 =?utf-8?B?K050UlNjQlEyTnlkVUlyQURhSXdtbXA3OElDQ045TnRmb0VJR2krdE5CTmVa?=
 =?utf-8?B?RThuOUV6azNHRmN3Ymt1YmpyRCthY3J0SllMbVVIanFlOU5XZGJYRmZ4cERP?=
 =?utf-8?B?Mnh2S2VmKzN2bkFDOHl6SkhBMVpPV2lTM25udUJkMnUzZ2FXcEhIT3RoM0J0?=
 =?utf-8?B?N3RabzBRb2VGZy9TMTN2ZXFoY1NlRzEwYzgwNW1EQ0REcVFmT3Z4SVp1dTNC?=
 =?utf-8?B?NWRUTWhSQVE3WFlnWm9pRS9nQjcwRTVNdnYya0FyZEp2YnJDbEJjUHM0YzU5?=
 =?utf-8?B?dDRDaTdiZExkbU1sRVlnYkFPOU5qa0dEMS9lbGpmQVpVTGJMSithOCtQNjN1?=
 =?utf-8?B?aUYrMnJEU0hGMFh5cHVzK0R0MC83UzB4N0tXRWJyRWMxbjR6eEU5U0FRemxw?=
 =?utf-8?B?akxZbzNSZzN3WG84YUxpQnJhRUxpZzJsSGp6WkR4ZVhVL29OR0ZET04reHJj?=
 =?utf-8?B?SDUrNkFuQVRKc0FPaW9JV29vc0ZQdFZZQ2hZK1B0ckNJdlhGM2hDY3p5UnlU?=
 =?utf-8?B?enA4ZklGbkQwWk1BbGlmTGR1ZzVqNEFWcVdvZ0VMRzhTSkwzNmF2Vm1xUnQx?=
 =?utf-8?B?NldVRUFKbk9UTzlUbDduSFBxU3RmOUwwL2Fhb3NSaFVGMVc3cUNlTjVuejFk?=
 =?utf-8?B?VDlQck1xS0JxTU5vamhDemJpeSttYjFxZndSeEtZSzZPZ1A1YjVFMkE5NlVw?=
 =?utf-8?B?S3EzTnE0WEhZSjE0cHpFc01KSlZ0ZEh5WTFHSzl4RUFOMXMrS2JlSUpDbTdK?=
 =?utf-8?B?cW82VWR3a1pJQlIxdkl3WjMvSFlOem54Yis4WUxHeURCZE1HejYvNXpDeXNT?=
 =?utf-8?B?eFh5VW05L3JhZnRPY09SU2xmWnNHT25Tdk9pMnFTci82bisrREZPOS9MblZH?=
 =?utf-8?B?QnZCNWVZM0pnMnBzRDRkWC9NQXZicHZ4NkN3YXNJMVNrakZoczkvWHdUZEdr?=
 =?utf-8?B?Ri9kTGFLMFFGN01RZW5YZVZlKzF4YkZua21VL3BFYmxZWUsydkF6b1Z3aTVF?=
 =?utf-8?B?NkNSUzV2VTFxdm9XYlRRNlRwcXhsdHdiK0liUERIU25zN0lTVjVDb2czZEZr?=
 =?utf-8?B?alAzYWNKelFIajEyZlU2RE9ZSTVoM1ZNQ2FTYmJvT1dGdldvNFVYK21UbWdY?=
 =?utf-8?B?Z1RnNmIra3V3QUd3NTgyRlNaR1psWXdZcTA2cGJabjMwNkpvakJwMStyR3F5?=
 =?utf-8?B?SUpMVEhaWmtFSWZwU2tLUWtzVEZaU0pmN2ZCRm9PR2VPWjQ0UEg2SVRtS2RU?=
 =?utf-8?B?WmdRbzZuNXlSMkFqVmJXcnFtcEMwc2F4dndVWHZTWDRaejlOOG10dXhjcCtL?=
 =?utf-8?B?Zk5LSmNYbWZwV2E5QVlVeEdPNzk5WjZGZnZQVFgzZ1FUZ3lPL0dqajFrcGt0?=
 =?utf-8?B?WEwwVk5XTlJQanJyYWFUWFFlMVAvajZOUUxqSDd4dk9PQlZ5MGMrL2VNRVJi?=
 =?utf-8?B?UTc2MWEybm43RlVhTFN2SmsraDZ2Y1B2b3dISUVSckNCVmp1Z1doRWVyQTZE?=
 =?utf-8?B?M3kxb1daaEJSeE5WS1ZNcEpwNWN6enBBRG5sbkFCUUpwNUY0OGxocFEvWjhU?=
 =?utf-8?B?SXZGWHZSamF0aUNGL21PZk5CcDlzcE9GUHNIQWN5d042bWFFdUI3KzJ0WU5x?=
 =?utf-8?B?eGVQTk81MXFDVXBHTjBkdWdlQXA0WUkrbHJJeHlHNjk2NTlCdEJYaWFPcTQr?=
 =?utf-8?B?QnRsODF3djF1RFhEQVZYN3IxbHFKVGtCY2ZMN0lPWUtBZmFLQ2NWa3l4L3ly?=
 =?utf-8?B?VU12cVhEc1lYZUcyVXhHM0kwOWdybkxmZ3ZKLzYxdnVybmtTS2YzUlJ0Zkd3?=
 =?utf-8?Q?y4KmH2wmn5Rm5GZw=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b0c6b2-58d9-43a2-9251-08de73960e65
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 11:15:45.8978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0iBtkwiWI1oH0P8pyNwH9N0g/lTOT8JHVoDhRhyy/5I9S9r+m+a+f+Hst6l5gGAwqJB0JfPfg4f6+dyvpZ60gHJh7ir6zfxgdPtiWdGWQYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12114

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add device tree binding documentation for the NXP S32N79 automotive SoC
and the S32N79 Reference Design Board (S32N79-RDB).

The S32N79 is an automotive-grade SoC featuring eight ARM Cortex-A78AE
cores organized for high-performance networking and gateway applications
in vehicles.

Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 5716d701292c..415081423a30 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1827,6 +1827,12 @@ properties:
               - fsl,s32v234-evb           # S32V234-EVB2 Customer Evaluation Board
           - const: fsl,s32v234
 
+      - description: S32N79 based Boards
+        items:
+          - enum:
+              - nxp,s32n79-rdb
+          - const: nxp,s32n79
+
       - description: Traverse LS1088A based Boards
         items:
           - enum:
-- 
2.43.0

