Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010015.outbound.protection.outlook.com [52.101.69.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835C078F4C
	for <linux-mmc@vger.kernel.org>; Mon,  9 Jun 2025 01:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749434294; cv=fail; b=o+Smo2pPUh8YFgyCig0iNqhhdHdw3xBqB3O05DmxRJx1fThXoBhMaeJnJ/ODbVrRntagonz1SWWQ6oXr1xvhod9o+mFllcn2un3sxPGIP+czEozpe+5OiuHLuaiL+WTQYDARngnRJsEZp8hH3yQCccWnUJs/4mZbcpxAyH1hfgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749434294; c=relaxed/simple;
	bh=9BEMQr5n1La6igTC4uoUqF8kVNVgQLVuR+TepB/e34k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fUYdT0zJxTpIWj6xBQ5M70PIszVsNNGPNBagBTc+Mq8KEE9Zlvq6+0GVHJrIb5vLGU2swPZpgV89iXqeTMfUu1Al8wiS43I9G3PSZ6jhp9PluYaQBMTYv5rOKBv6+0jLdjJjYm72EukbLBCIykWdEOzxdr+j16/vUjis6HnWimA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HJ/WPnQ7; arc=fail smtp.client-ip=52.101.69.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HJ/WPnQ7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ko/VsK/CsguH03PnHNGUL7dqlUqqXOhqJY2gQ5Ljf+ujSBFdcN37bW5PIPMuqNbN/OI1/e1OhI1KHByCEdeSO13EVwgKAYs5ncqz14GMaYsloZ9+14C1M7/aBet0xt+qqfvAXvJafV24UUznNYN9QNObT412/i0gSxkuHTSoWqzlzRhQAVgQ11r3whf0PPWjIs0uadNfQI6IVI8Is7ADoJVkiGzZIRTEviTg0cdKouchidfmH6ofPXiLGeBTvnchXKzuxllR+mJCLsgds4CI02uBUAKM5wvfSXQJaBqsx+CzWes01aIC5hBBC6w3Pgkf/84/+aNQsiZRMFS1AV0Obw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BEMQr5n1La6igTC4uoUqF8kVNVgQLVuR+TepB/e34k=;
 b=ESURvgLyGHltTVBb0+YoE27rA2XYmOjmDprbNZ9R01I9IAtz5Dn/NcQd0qCiPI5B4fFQD3HSJBrW9JCn158IectRA9Z+IBAl3mDHJ93xmCfidY3bdRVZk1hM0QB5i7ncf7obI9WL8rBbA5LG5Ck0ng2aHneOxwXx93omvsRghpwaXA7OpuK5a+1ai+9zYg+ppe3Q256m0XsruJVLXvofy6tOBZzk0z4+k7xbxX6lSU8XSmUlwqNEjKd+BBvTRIXtWjumvQmYLC+isRBCv8f+zmn1fQ++ryTtphNtPH751HoTnOySlAH+P51HONVKHS0wBoB0HaUh/q4qxe+h5qHeGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BEMQr5n1La6igTC4uoUqF8kVNVgQLVuR+TepB/e34k=;
 b=HJ/WPnQ7ngY9zdkmbF3V+y7HHa2x4MYK1sgXLyaCxAsNW81Dg5LuIWP6heKn9zd23yU7lG/oBj1PJW4bo9E+PpM9UfADLXxRty85qseuvCWtJxmpEofCtx5rn3AHVWvAEakSKggGllo02pZR4zgUGH/8usu8ooSxvEw59QUtHW5hYWV2xYhO5J5MuAMGKMNlYAbLz2Iog/8wEun7/iQo3vLsbrHJ2nxjbdX9eK5deu7vy1sL+aHX6bTM4B8l1jg14kbyV7mVG9pBOG5kVBzjav6I61AL1XyeDnx9+9qAQJ04vVVX917Y51N7QMsYewizgKUm3mD6D95D+H/ZP5EDSw==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AS8PR04MB8085.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Mon, 9 Jun
 2025 01:58:08 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%3]) with mapi id 15.20.8769.025; Mon, 9 Jun 2025
 01:58:08 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>, Binbin Zhou
	<zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, Ulf Hansson
	<ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
CC: Huacai Chen <chenhuacai@kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio
 Estevam <festevam@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v3 12/35] mmc: sdhci-esdhc-imx: Drop the use of
 sdhci_pltfm_free()
Thread-Topic: [PATCH v3 12/35] mmc: sdhci-esdhc-imx: Drop the use of
 sdhci_pltfm_free()
Thread-Index: AQHb1374FMyT+NSb40KbDaWfYhkQf7P6FKEQ
Date: Mon, 9 Jun 2025 01:58:08 +0000
Message-ID:
 <DU0PR04MB9496AAEF108AC4537D5F36F1906BA@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <cover.1749127796.git.zhoubinbin@loongson.cn>
 <9b9014749a9870a9cb3c2818fe9b38c013cb46ca.1749127796.git.zhoubinbin@loongson.cn>
In-Reply-To:
 <9b9014749a9870a9cb3c2818fe9b38c013cb46ca.1749127796.git.zhoubinbin@loongson.cn>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|AS8PR04MB8085:EE_
x-ms-office365-filtering-correlation-id: f5cc7a95-3ed6-4863-94db-08dda6f914be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?ekhJbkRkNUQ1RlhDNzlkSEhHcVBuNnlyVUs2eUhjb3YwRXFZQXhoVmxHL090?=
 =?gb2312?B?aHRJRVROVGdJYXFGallkNjRwakRYRkk1S1V5cWZLVGJYNTR5aWNObFozM3Rw?=
 =?gb2312?B?OXc5amFhbXpwTVNRWlVsOWVpWE12SXdwbjE2N0tiTTJidlZKVXVTSGtiVjNE?=
 =?gb2312?B?V0tiZmRJVkYyVGZwc2NXTE83eXNrTlg3d2MvRkZzbjB1NUFmcllvWUs1SDFN?=
 =?gb2312?B?WjVVY3NhaE13bS8vbDVIa0l4RjlRNlE0bjQwemp4anNFTlBPQlBxVko2RERX?=
 =?gb2312?B?RmFXSkx4WEZBTFBVNEsvMUxqUjAweXJwTjExZTNpKzhSczllOTBTV1psMW1V?=
 =?gb2312?B?SEUrcEZKbW1EdlFvNHgwdzNqeFpxRzNiblM2V0hUbGpLRmFIc1FZMmtRcTMv?=
 =?gb2312?B?N3ArekJENmpIbjdEc0tNeGNpSDBwbDZxLzhyMHY5QzErNXExaWswZ2JvK0pv?=
 =?gb2312?B?UkExNDJiYXdmSXRVbk9GbUJ6Z1hLRTAyOWVwMHVFUW5mQWcwb0RiN3VleHlj?=
 =?gb2312?B?NVhwUWdMS25McWo5eGw5dnV1NlFFOVNmVFJLekg2N01DNHFCaktYMm5wMEFP?=
 =?gb2312?B?M3BFOWdBUjMwMmxSSlM2SWpRSEw1OWd5OUhOSTJ5Z0I3Nm9HNy9wanY4bytQ?=
 =?gb2312?B?STg5ZjBmakpwd05MQy9rUEZGQnNObHYyb0QyZ2E5VkNmZ1NIYlBobnlxU3c1?=
 =?gb2312?B?N3hRUVF4bnJabWRKS1ZhUW0zNzhWeExCRzFIdmJqUGpNMENaRjY2Wkd3YjZJ?=
 =?gb2312?B?blFodVFpUmhtamx5MnlDYUlyd0VNVzhSMzB5M2JlckV6STBMZWJxWjNidjhq?=
 =?gb2312?B?R1NHMlN4Nk1IVUpxMDFkT2pPalNXNDNsSTBMUE43cm11aGNtNHAwSkNmT21a?=
 =?gb2312?B?Wm1WRlZhbWpVUU44Sy8ycVBCckd5QTdhd092SEhjdXZrZEN1UmFXV0RhemVK?=
 =?gb2312?B?QUNpU3NBbTFOR2NOZE1FMG5QclRhOSs4NkUwL21QNGRGbGJ0SCtES2dmSUZP?=
 =?gb2312?B?NXUvNTMyRldibnRLUVN5cGk1dlE2OEVkU2didzIyRXIwM2MxdzljRlVXQzNY?=
 =?gb2312?B?WTl4YXR5MlRPQWQ5LzZnWFNoSy9zWTJCUmtKbUJ6bTRjU1c1a1h2aDV6aHVt?=
 =?gb2312?B?RCtOOHI3Y3F1UGdLby9vb3BDdE51eGsreW5JcElJbUFmbEhaT0pzR3lNSHh6?=
 =?gb2312?B?b1ovcFgvS3lIem1zNFpaMGpPRVdLSjZDeFFVbXh4Q3ZkamJjQlpOUHNTb1U1?=
 =?gb2312?B?c0NRbnlWZDVaNDRlYmh1MGhWdG45elg2aUJjT2xSVWt3SkVLU0lUTWh4M0dY?=
 =?gb2312?B?bUdSTW1iekZxYlFhdFFlZ1dmSG9QblVFcVZIeEpML3ROOTlBaWlpcm1IUUlC?=
 =?gb2312?B?U3dZWWs1b0RaVnJIZjFpUGd1Nk96OWc0a0NwemNBZjYwYUh4S1pQVW1NMU1S?=
 =?gb2312?B?Z1ZsZnhMeXpEQlhSeVJqYzBsTUdhelE4MmNvVVM5U2Rsc3hoSDVwdkg5bVho?=
 =?gb2312?B?Z1ZZYjZydm1sbUwyY2ZmamNuTGVZSkgrUE81a3h1REY2bXJ3TjJGK1pEZGlJ?=
 =?gb2312?B?aGEzWFFqVmZyRWtTR09rZXhxL051QXA1VithcEZ3alNFTUFMT01ISndsa0VI?=
 =?gb2312?B?ZjlmMWlsVXBZcGttZm91YXJ4eGVTcXI4cjcvZjNUK1hjaG82OVFKQ3Evdzh5?=
 =?gb2312?B?eDNKbU1tdERmQmRSeC84bVZkYlRjNWh2UzUveHJQcWZyRDl1MGZrYzI4S0xq?=
 =?gb2312?B?RmRQdFYyUXBDZGFvelhCRm9uTVNraFg0M1NiOHNVYm14elhqamhZMG9MMTcy?=
 =?gb2312?B?ZnUvcXNBbVpLR0VDR0VITkROOGg0Zlczd0hOTkQ5a3VFYnFINFpuRDZRL1J2?=
 =?gb2312?B?d1VLdmVwUDViMUhOanhpdElDOHdWcjBNMkMzeGdpK3ZOOHEwQ0wzNUNGZEN0?=
 =?gb2312?B?WDRMZktOM1lENUhLSUNCU0JsRXhaaWdsaitMWG9FZkJNSDV2d2ZvUzVNd3F1?=
 =?gb2312?B?elZHYm1tNWVRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?VFN1MUp6b1VIa3ljd3YrWUxaeStWY0tQcDlGYWVQdGV4WUV3VzFQOVBaMmY4?=
 =?gb2312?B?N1Q0bTBLTWpySUN2em41elM1V2QrOU9QcUFFbFg5TVZ4bWFEdVdpL0hWTndU?=
 =?gb2312?B?NFlhcFkxb1hHR0VpTEJyZUFOQTE5bHIvbURuV2xUQUJPVVVzQ21VaXR4Rkds?=
 =?gb2312?B?UkpnMW1oQnhFbGM2d29JTTMwcElIUG5meXd3ZGgyeEV3ZUsra0w3NUdGajQz?=
 =?gb2312?B?YVdjQU5kUlhMejlUY0l4cUdxekRJdjB3bndYVmRuVXR0VFYxUHJBKzNPdlkz?=
 =?gb2312?B?WlhwTG5FYTRSY0tWMEVhRUJkVjRldHQxMFVuY0EvZllxSlo3ZXR2MWhDaDRT?=
 =?gb2312?B?WnFidWFCMWNyc2ZjQkVlZWRkVTA2bWE0bE1xV1VRMGJrT3grOXRuaUlQOTRr?=
 =?gb2312?B?ZWZGM1V1dHAwMkVNMkU0bWNmWnNKa1VuY2g4d3Z1ZUo5eWFyMXlNVkFldHVo?=
 =?gb2312?B?cVUvK2dxTVhJdFlKOGtQRndLTEtVKzl1QXF2QTVISkNEWVlKL21sSXRBOTF5?=
 =?gb2312?B?bXVaT1JXaXRIQjdBM0Zqb1RIYVl0NHBKa0dDVjJNU3Y0VE54czJCbGE0cWxi?=
 =?gb2312?B?OEcvQ1ZEUHdRMjI4aFNoTHk0VlIrbkkyeHhpTXdtYk1CejRsQ0RjdEV4d25C?=
 =?gb2312?B?SWJNSkd0VFBlcGFEMlZLRXQyeHF2Z0VNN2hjdDdZQnVPR3Y2bStkWnRBTVlu?=
 =?gb2312?B?dy9VQVRZWk1TZVVOTU8zNnpPdlZ6emJjRVVsUlNBVUswMkZvQmFkeXFPdERr?=
 =?gb2312?B?TjlQL2diQlZCbnZ5NWx6OHFvVHBLUk91aEN5UWpsQlRPLzgzQ0w4VVNxcmxm?=
 =?gb2312?B?ZWJlK0RFaWNxVWlVYzlwNWs5aGpvODFxZWxxSklOTVROeDR0SFVJbXp1b01M?=
 =?gb2312?B?YS9WU1JEaWxadVJNdjhRcG9URU4zZFFVNS9RcmlvUGI5MFV0NC9nNTY0VXBK?=
 =?gb2312?B?SVBwWXZBQkJtc0VVK1g1cmFvNHg2NUlZV2lwNlFUOWE2UzZvTmVEaWZEc2VV?=
 =?gb2312?B?dVg1dWJndDNYUk5wK2c2NzQ4OTB6Nit5NUh6SjFBQ0FUQVhsd0dCWHJTeENJ?=
 =?gb2312?B?MS92ZFR6ZWhqMTdHbGJ2a3ltc2xhVzBibnhnMGQ1UlhDcEVwaDlSMVk5RDIy?=
 =?gb2312?B?VUtnV2x1VE5zYlM3Z0tzOVp2ZHprV0tuSlJSdTdEeDVhdVdzaGUwNmRJc0NL?=
 =?gb2312?B?aFp2RFJSSzBXSXhYc0RnU21VbnJsb0N5VHRwY0V2Y1Z4SWNqTmVVelB4eFlW?=
 =?gb2312?B?MHpnRHMrSHB6K2NJUDlJTTdUelJNZ3Q1Yi95VTFHenNQd2FmZVNjdUZvNm1t?=
 =?gb2312?B?bHFvTGl4KzZObDJ4cjlPdVdVa3Z3KzZWcFhvVGZnWHljd2xDOWtmbmxhTFJZ?=
 =?gb2312?B?WnVTOUZLbWtkVEt1eFE5ZGFZbkRBbGYvcmRwNnZRNFNkUnQ3ZzczWTJha0lR?=
 =?gb2312?B?M1o2TnhYU1FweXBNaldxc2M0OEVFMGdLVVpDRjlmWDhNaWVyZ0xTVWIwNzZK?=
 =?gb2312?B?UXhIMTMvWjNML2ZIMUZ1cEQ2NHlVbHBpUExMNWl2cHErek5vSEQ3djdtaFVn?=
 =?gb2312?B?WCtGb3dKUTJET1RpeTkvbjZzMFZVRDcwL0RVcGdGeU94aEMzSkxzcytwY3A0?=
 =?gb2312?B?MTQrZXRLblZ4ckgrSlVtNWdEdVhOd21nQ0lCelNTN2lIWVFlaGMxQkRLUDRK?=
 =?gb2312?B?Q2lBeEhYeFFjVHZjQVdNZWZQK2U4ak43bGZDRjNmVnRiRVFMSzZBMEtaRXha?=
 =?gb2312?B?QTFUNkJiNk40U0FQTkZBaXRsN1Z2ZEVkYjR5ZlZxN1prTEQwc2tDRlR6TDFF?=
 =?gb2312?B?c1I2QUtvUkhBbGFGUlhoYjlQcFJZUDhqVlBDdklTN0g2OHlrL1lhQWlBTWdL?=
 =?gb2312?B?Tk5BYlN6MEJxdFhnQ29xM0dObEpTVGZDQUsvTGkxT1pvcXdEZFFPekh0T2F2?=
 =?gb2312?B?U2RBcTJ2dHpMWDFhVkUyWHptV2wwMm5ic1NVelg1cHpzWGNRbmo3NStZRGFQ?=
 =?gb2312?B?RFZCaHp0YjUyWVJmZ2JkT05HVkxoN01qMTkvWDlmeVFNRGxvcXNPeC9DVHFI?=
 =?gb2312?B?RzRRQ2tCRG1DZ3VOL3NjUklENGpZZHpoUkVtUklwTGEzQm56eGFKbkxTRENE?=
 =?gb2312?Q?jz1U=3D?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f5cc7a95-3ed6-4863-94db-08dda6f914be
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 01:58:08.1142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MEe0EZYg6zgTkE+S+wbyat7mcBVMjEhTWzklzTRXjd7WY9TyyYYXsdyRDTe/GSaYZaLbNNJSrrPEHJPMB43zsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8085

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCaW5iaW4gWmhvdSA8emhvdWJp
bmJpbkBsb29uZ3Nvbi5jbj4NCj4gU2VudDogMjAyNcTqNtTCN8jVIDE1OjM3DQo+IFRvOiBCaW5i
aW4gWmhvdSA8emhvdWJiLmFhcm9uQGdtYWlsLmNvbT47IEh1YWNhaSBDaGVuDQo+IDxjaGVuaHVh
Y2FpQGxvb25nc29uLmNuPjsgVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+OyBB
ZHJpYW4NCj4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT4NCj4gQ2M6IEh1YWNhaSBD
aGVuIDxjaGVuaHVhY2FpQGtlcm5lbC5vcmc+OyBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOw0K
PiBBbmRyZXcgSmVmZmVyeSA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgQmluYmluIFpo
b3UNCj4gPHpob3ViaW5iaW5AbG9vbmdzb24uY24+OyBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54
cC5jb20+OyBTaGF3biBHdW8NCj4gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBTYXNjaGEgSGF1ZXIg
PHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+OyBGYWJpbw0KPiBFc3RldmFtIDxmZXN0ZXZhbUBnbWFp
bC5jb20+OyBpbXhAbGlzdHMubGludXguZGV2DQo+IFN1YmplY3Q6IFtQQVRDSCB2MyAxMi8zNV0g
bW1jOiBzZGhjaS1lc2RoYy1pbXg6IERyb3AgdGhlIHVzZSBvZg0KPiBzZGhjaV9wbHRmbV9mcmVl
KCkNCj4gDQo+IFNpbmNlIHRoZSBkZXZtX21tY19hbGxvY19ob3N0KCkgaGVscGVyIGlzIGFscmVh
ZHkgaW4gdXNlLA0KPiBzZGhjaV9wbHRmbV9mcmVlKCkgaXMgbm8gbG9uZ2VyIG5lZWRlZC4NCg0K
UmV2aWV3ZWQtYnk6IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCg0KUmVnYXJkcw0K
SGFpYm8gY2hlbg0KPiANCj4gQ2M6IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4g
Q2M6IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4NCj4gQ2M6IFNhc2NoYSBIYXVlciA8
cy5oYXVlckBwZW5ndXRyb25peC5kZT4NCj4gQ2M6IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdt
YWlsLmNvbT4NCj4gQ2M6IGlteEBsaXN0cy5saW51eC5kZXYNCj4gU2lnbmVkLW9mZi1ieTogQmlu
YmluIFpob3UgPHpob3ViaW5iaW5AbG9vbmdzb24uY24+DQo+IC0tLQ0KPiAgZHJpdmVycy9tbWMv
aG9zdC9zZGhjaS1lc2RoYy1pbXguYyB8IDMgLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhj
LWlteC5jDQo+IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBpbmRleCBh
YzE4N2E4Nzk4YjcuLjAxMWI2MGQyMWE4MCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tbWMvaG9z
dC9zZGhjaS1lc2RoYy1pbXguYw0KPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhj
LWlteC5jDQo+IEBAIC0xOTczLDcgKzE5NzMsNiBAQCBzdGF0aWMgaW50IHNkaGNpX2VzZGhjX2lt
eF9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgZnJlZV9zZGhjaToN
Cj4gIAlpZiAoaW14X2RhdGEtPnNvY2RhdGEtPmZsYWdzICYgRVNESENfRkxBR19QTVFPUykNCj4g
IAkJY3B1X2xhdGVuY3lfcW9zX3JlbW92ZV9yZXF1ZXN0KCZpbXhfZGF0YS0+cG1fcW9zX3JlcSk7
DQo+IC0Jc2RoY2lfcGx0Zm1fZnJlZShwZGV2KTsNCj4gIAlyZXR1cm4gZXJyOw0KPiAgfQ0KPiAN
Cj4gQEAgLTE5OTcsOCArMTk5Niw2IEBAIHN0YXRpYyB2b2lkIHNkaGNpX2VzZGhjX2lteF9yZW1v
dmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gDQo+ICAJaWYgKGlteF9kYXRh
LT5zb2NkYXRhLT5mbGFncyAmIEVTREhDX0ZMQUdfUE1RT1MpDQo+ICAJCWNwdV9sYXRlbmN5X3Fv
c19yZW1vdmVfcmVxdWVzdCgmaW14X2RhdGEtPnBtX3Fvc19yZXEpOw0KPiAtDQo+IC0Jc2RoY2lf
cGx0Zm1fZnJlZShwZGV2KTsNCj4gIH0NCj4gDQo+ICAjaWZkZWYgQ09ORklHX1BNX1NMRUVQDQo+
IC0tDQo+IDIuNDcuMQ0KDQo=
