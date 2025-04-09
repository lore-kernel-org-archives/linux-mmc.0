Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAFB2AEE1;
	Wed,  9 Apr 2025 07:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744185290; cv=fail; b=tf/7uGcwAhzbIIcqOASTjOBHE5Agk2tIIsT8pFHyku3Y1snh/9xz3d1aAo721XqcB1gXe1h/JvXGbUB1rpZwoPsrlJuaXGScFUFconQewycNG37Z9EGpLv7yRBD190P5oPlyDhX1A4bRCmE+7Snc1+AVIkjmsfZFVsV+C82Nkwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744185290; c=relaxed/simple;
	bh=+OmWru5rmK7kmRtxrNTWm3uGooycT8WYeD5VSECKrxo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ppQhQDb8+sN+ebvYH2pYZrjYnqPbKCTCK2Hs6x5MhupyqqgEh5/UokxtVWF9OAA3NBUHQAnI7Uj/kanoL75+mtnf8foiaXPmmgDQV4ypP2HTUfVh9l51bvSxGG9HOIS2DlXmqknN4YiBUqc3AKV2QRYIH9izthxXijGdw9Fhedo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fq4z2cu2; arc=fail smtp.client-ip=40.107.22.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fq4z2cu2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fS5/y1w7K3uk0XGKREcSe18rQOKJIJ8RL1HPVPtce2pB6N/YcC2GvSllG+GQV7PGyJo+OBK1sD2lQMEkyZqVQNZweNMwkt8oSqeh8RwdijeP6E+YHRcxud+beHwJzY4h3Uq6BkoJsEv+xPoa6nTIRX5EYkIoZL6PXDmRMB9TVzjW8L3JYHD8ehnatcz3KxcWrBff1qkV288PHfn0XSub7jsmXQ3hc0AF1HIE5GDB/EhKE8YJ595Ej0frNdo0atWjpPOPkmbnpZEcVf7r/gRT0FU0Kwh7TKIpsC5KvaW1WC7xeYMxtdHFHCrPBzqOp8iojWpzlMGAh+kQmMe1qwBELA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRMt6rcVHw8FzFmExv9rfQ2xNOILebh6h3JGaa2cpqk=;
 b=mij6t8srLo79owf5Y33OPGDKlDHA4C5ZN3tzm4/BnNSTBnRZRKFdRHymhrYbzNUSRIPXzwk/sHhPF912z9m8rGOmnJeA5LnXZAw9RITtzdqqN5c+6U5r+jRBamqezYGDQzZRN0FmWEQwRi40YzyXaHgxaDecg1m+Sz8iIm1f+aqkRobnx/sLcj2rA+biZsL0wqlUqcLfxOLc7oyPlfh2ZgF6iP12EVDI58JQmW0ApPg94gsgegqdJxCEP3KmaZCYmSttHgs9re/2uQeOP8lF5JNJ4SN01UMjcFWzFaF0ij1urNN+1PREZkEGWszKrZix+H2mlJnxLdC+mpkyst0BwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRMt6rcVHw8FzFmExv9rfQ2xNOILebh6h3JGaa2cpqk=;
 b=Fq4z2cu2wRdNYb9iNlCiRKZdxZ+3mBGBAO3SDwtibbWqIMeCcu6k6y9wpU0/aCtPPKz9Jv42iM8eqNXXUKGuM1/CEPiLJ+H02erlhjzxHUY87wiRBeYY7+dsz68twuftOJlphu7dfoHezILG99tGjSOMrPlxDb5W0OxEWbYKSNd91UjwqKAt0+W7UxRigottIEGptRVLwAsl//JfDzOOrDKgqesWu21A10KEen5e6bC/dM76f1ZTYfO4MtSUN0W1B+ITqTqRjS0ndaXAyS4hAyRjRcWgkUhFnuOWw36t0jOAUD0kSzMm70V6hoM2NANo0UEjRAjLUFRW4PIgdWCsMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by AM7PR04MB7077.eurprd04.prod.outlook.com (2603:10a6:20b:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Wed, 9 Apr
 2025 07:54:45 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 07:54:45 +0000
From: ziniu.wang_1@nxp.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	haibo.chen@nxp.com
Cc: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] enhance the tuning process reliability for i.MX uSDHC controller
Date: Wed,  9 Apr 2025 15:55:44 +0800
Message-Id: <20250409075550.3413032-1-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|AM7PR04MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: e7a12533-a54a-4ca1-711c-08dd773bcb19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kZEFz8CPb3W9B4MOyMwf5kjElaHWcxcvsfCFBWXSJjuyzMPBtB38ehjwHwme?=
 =?us-ascii?Q?EjFge7Xd4KmRZWqcrUWmUGA/p2Cg1xnZVug9rsUgVTP82a0CYh29Vk9ejwNB?=
 =?us-ascii?Q?S4G+W3Z+Hsp5ltOyeJxJv8TjVVdOL8EsEdGv18xuChF6DxrbRZIW/pi/00eN?=
 =?us-ascii?Q?/rdtAGeoTSZWr+soXXM9PH6sgY0BUZLRYhcdb+Fid/7uyIiXlt+iA4jwlOei?=
 =?us-ascii?Q?qDh2ZhtIl5hLDISFAh051g5QBDfugLPGayMYG9O5xTujstcmbrfRaAS2uEqu?=
 =?us-ascii?Q?O59S7NDeNoF/7zVSy4eKaI1JLKtcjCc6I8/vqP1BEVopEx9YpVMrlZJiMPQU?=
 =?us-ascii?Q?Jfk2UQrI98K1GLCcjV4n9WV6ras2VtbsE3wVjl0SZZVDvXiqTB2taBYfG2Be?=
 =?us-ascii?Q?lVFDzk+ZwfONTTDsc/2vP09sjtCQ8Q1A6PgJ901JOo4d1SG/pXjZG5r2T+by?=
 =?us-ascii?Q?hDQqh+E+pOy0GpfaPnq+fkEFQVbdiG8A6+P+zYUbbp4ygpgHCGvpflHontmm?=
 =?us-ascii?Q?kudlxLM9hzaNftC1a604I7ZKHnr7RwBlSNRrim24puA6fiDZHQFjMh5ZqIim?=
 =?us-ascii?Q?Fhnyba68CBDbFm1yohiJWWpopMei6bFdO7c4Bk2XnsMlZcXhlcOZONNHdGgm?=
 =?us-ascii?Q?Xg0FN8mWc6xtFucTm9p3RXHUSBGvL1VZ7om56BaTwmRe3Yr3SReudPB569GT?=
 =?us-ascii?Q?AlbG/tVeZwZLSrAaGFAzQCfGRN4xEdkVF8GWPFIZL4l+WksNi7BHsOAp5XIL?=
 =?us-ascii?Q?6xoKLMoK3qOB9qdiziO9MnE8/50mLyxbTrfWyNH5S7M61C0nY2676vuhlSgY?=
 =?us-ascii?Q?lMI58E9eeCIUBlsY7TS4kHV6mg46j0M99Spsx+3N8CEBoSjxlDlY8FIobN1D?=
 =?us-ascii?Q?rB5T4sQIGWHSZZ11bSxHazqrfgNGQco9FFZw7kVreYSNklhGvQ217FFhvjhy?=
 =?us-ascii?Q?jZxjBiOobfdzA4F5JsQ1shv2Vf4XN0KUQEJDcUkoqXCVcR8bTwijkY57BObS?=
 =?us-ascii?Q?KjJfUHzrnIdCRIepQ55lV0oeChCGnJJ8S3G3JF30t176MdnJLHRAzuyEp6bm?=
 =?us-ascii?Q?KOX6o7T3RV5N5LXQzzwyDxaVYGUClQW5PhhZdZm+rVfhUSxo10EC83DKIzNP?=
 =?us-ascii?Q?lyf4my900L67u7lu5XoUh1v2SF99vaCdIhOuTpA+HEap/iIK/3f4ITU673Lw?=
 =?us-ascii?Q?CGbF5S1MBSKjlQAaOTAKCjmMMAytby9vtNRTSPKd4oDnskinrjhK+MwU8VUg?=
 =?us-ascii?Q?Eh/L2B2YuAkFGo7JQRZjH0o5HE/EQUwZxY9O/k/a4JyveclKgFWfGFNY4KmP?=
 =?us-ascii?Q?8jwUL4hnMJdJ95vjqNWSTa1TEwUocAB1iYl3YYNlrm7ONka+UdJL4rt66aWP?=
 =?us-ascii?Q?TjZK3Gt9fkSJQnmDR+eWawzzTvtuNXnIaHv5owONbAL4bgDrFrMDZVfDxzbm?=
 =?us-ascii?Q?nhcbHERLnx99RS4km8NrGvzhbs0IrviXic7pqx/ijPNiP0CX+aOA3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1TGSbdbflQKctEP4kLhuHrpN92A45c48owinAUDk5i/6mbs5Of5/t6WCKNiW?=
 =?us-ascii?Q?iGSngh569dNCEzYjQRdgqcuw1NJ3hviykH6rrDhc2OUcxT3de6gBJir9igTK?=
 =?us-ascii?Q?4uAatzeMB6ZwFAT7LkH1cNg2Pnzc8O/bHWj8GvcUmHJwQlapvl2qSuf/d6c8?=
 =?us-ascii?Q?l2dD5DvyUMnxppSL+E+QO/joRvHte1EPeRH/IFlBJt8ymAxQ+KDe+pedFINE?=
 =?us-ascii?Q?6S04NgJQnb3Ixj9Kt9gXPS5pkY93FduRcb8I+E/YeeQj/FwJD8r/BAFZQR2I?=
 =?us-ascii?Q?ZEG20TWnD1lYAy9P8K3Wz8u1WhvbBgoYHKbhKZX59FWtvPvPvcNMZJJ7VxwK?=
 =?us-ascii?Q?6WnuCXb0SHZzHQ0XX+yOGwG8wGxoJa0qkTBosFa0pex7ak9ZtKZZtXxRK43x?=
 =?us-ascii?Q?MUGXUk7RLBmSsm8RRT30h5cjQOM5Y/wXP986ZhbcwqilD2Zo3pgK7/QbgmSW?=
 =?us-ascii?Q?NaAdaQ9kZme6xb59V4bsAxD5QOnkGNW3pi2XKQjmzNuMjhHsQmGLobY/vtnV?=
 =?us-ascii?Q?AYtG8+Yedw7WvCJBRQ5QywxLwyX5hPd2yiq39ZABcMTETJirvE/jma5kbMRQ?=
 =?us-ascii?Q?CS5biJCBt+jkfyW+csjd0T6YtwpUZ5D/WC6tTavvOSOm10bUd8/NyviWLwZD?=
 =?us-ascii?Q?W4AOEnYHXu1QF3iALdhRzDK8oYje9iPDf7iAzJko4aTMs3mdgeHwwhmpB1Vs?=
 =?us-ascii?Q?bMOF0vnU0KQcxxhDT7ebvcGFt4SyJzcCfzBVO1f77N+ttZ78H7nXpCiHaf2f?=
 =?us-ascii?Q?L8Qed6zCZEKsN/FQojprg6BQBfdlXuP5rKqAodsQTHVa9TxfKJ3cUofpk6mb?=
 =?us-ascii?Q?cynq96LHw9fAnfbE8BHY2QrfeXTmAFKnqRnVecUMEAIVsRhayeWyRIweRihk?=
 =?us-ascii?Q?m1oljG//lPnGnAQxXI6qx6Cz+Il3PTtNm464VoFtHhllbJZ4MqM1QwKtJPN/?=
 =?us-ascii?Q?Su+KZv5koC4tlk4nvGdeP7JB6xzkYh3MwWFWH7usKPABWdtCnrnSeycqYYU4?=
 =?us-ascii?Q?ygcxomb7SLmcj4p2nfai4dFubvbwUFWoCgPmZa0CwYIf/IFWj1mD6I9lheW9?=
 =?us-ascii?Q?ZNzffrjoMEN6KUpPdFQDgxToL/KyUY1lT1SlKtBCl1+HyQn1fTgjnWLKrj6b?=
 =?us-ascii?Q?+m6De34XtbsekcltO06p/53QbkrfiBG2o/yOEJLdcztB7mpA811Dlu+xDB1p?=
 =?us-ascii?Q?I6rmuFV0tfhVmtj7G5eKZF77UgAOZTpqQbdq3/yrekgKX/rPi4wZAhkkbvA0?=
 =?us-ascii?Q?XSh1pWDeyg7o+iY4B3EvK6VOmkaVhT+91n6872gAg3B0PclPzrhE+pQZbGGo?=
 =?us-ascii?Q?PggbCJygcatKQc/EFHfFJNIWNfKQ/w3s1m8Se6ONsPwpkQtxuiqECT1hcuV2?=
 =?us-ascii?Q?QfEKLk4sLP1Y+S9jO27Hf1m7a6VPMEyinuWSvgLYdIMStd5qaHlNbr6DtMoD?=
 =?us-ascii?Q?SmPRWhpW32KEpjJfn93SmDVkaSoGmbSnfmdioZ+uZuVRoNe54cY6ZrZi4bHq?=
 =?us-ascii?Q?DVtZWuvI9skuQAIw6yfypBkcSZ/jTHDzZCxUnrfT9eOaDE0Rmz5QXfjWyPGP?=
 =?us-ascii?Q?p17tOYnpnXTcO0x/ZHddrXyaI6oBX4l+z7NaZYYo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a12533-a54a-4ca1-711c-08dd773bcb19
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 07:54:45.4393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5bhnlkNNc1XtcY+wdZRmxzX/zGEzLIrnhUrMqWf6jC3F7RdLVtUTgvWU3niz81jJhim6T9MX1ULpBa39HsBrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7077

From: Luke Wang <ziniu.wang_1@nxp.com>

This patch series enhances the tuning process reliability for the i.MX
uSDHC controller by addressing several hardware-specific requirements and
improving alignment with the i.MX Reference Manual recommendations.

Haibo Chen (4):
  mmc: sdhci-esdhc-imx: explicitly reset tuning circuit via RSTT bit
  mmc: sdhci-esdhc-imx: reset async FIFO before sending manual tuning
    command
  mmc: sdhci-esdhc-imx: widen auto-tuning window for standard tuning
  mmc: sdhci-esdhc-imx: widen auto-tuning window for manual tuning

Luke Wang (2):
  mmc: sdhci-esdhc-imx: verify tuning control status after configuration
  mmc: sdhci-esdhc-imx: switch standard tuning to manual tuning
---
This series depends on:
[PATCH v2] mmc: host: sdhci-esdhc-imx: save tuning value for the card which keep power in suspend
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 86 +++++++++++++++++++++++++-----
 1 file changed, 74 insertions(+), 12 deletions(-)

-- 
2.34.1

