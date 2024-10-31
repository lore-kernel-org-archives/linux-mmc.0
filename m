Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DAD28373;
	Thu, 31 Oct 2024 02:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730342239; cv=fail; b=eA9jTJTW/Zb4tkauW7TVTMG+vVWgy7/eWYrFObf+DBezNWVZkj7eiX8BrD+YkZvnnIB/Rx+eunFAgHIs0nVHQ2jGevdpH2bbjseqt+W4K908ViBtkvBT2jth2SJDc/bZUIbsYYBzy0MVoRAEVwI1GzPuVNFjQqloYqv4nJzgoME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730342239; c=relaxed/simple;
	bh=jsNYS4/QCiZ0Ig7DZDixEuCmFTpUOjBLee51ivZ25Ss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ldU8mupP1piEWzC35x8A9CZZlv0FBZ5PSyIbKvWEw1xspNKvwH6pqiNtQNh22yLdNO+og3UlQmJwxC4qVt8wq55SMhoi46rDDU30UpM2cV8lPfggFDCkoJe10f5zbcv6HYGi3XWlYaNI33fDoGbd+Aymz5RXwTWiBh08ROULrGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aWn7S+Hp; arc=fail smtp.client-ip=40.107.20.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aWn7S+Hp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMkeyy04gGBSogY2PJizhmhwkv98Xse2BG4MKqQrHjKpiLsnr4mtudLmbfBrDAvouLBLJveoKToElHUnAdlTC/rscfgxa8iySXgYBZjksz04Jop7W22QnKeyUHETbvbHMpsdzDog3JdnaxCligK+DNErFR8gNpttYhaqaoshrxRw4UoStBqk0vBCzK2T62gU0q2m39LDewEZu4Zo5zsFeXfwHX2PlQDIKFLP1xfjKgmGJ1f89iTRRHVg/E7//YJF8l0KjTleZbhaFGiQzhfwPla61Wa95HYKygj28O4ZNJ/lyyZNEco81z9kUo6RieABvwaybWRqtj9Qr+sCvkL3VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsNYS4/QCiZ0Ig7DZDixEuCmFTpUOjBLee51ivZ25Ss=;
 b=ILN8vyUQKh3d7y2NyFRcXRdM6C5blCOa17DYU9+Z7dD4yjVlHfHdQeHiuWw4XRVYEeU+JTh/NsHcloYrApzqtnP2Yk8n6ipxw63kta4dneP+WgGgnhmkgp2NTWQcNRvedueUMazEQUEr3Vfw770iTiJ9wyy+tGvQ7Nfu4piqxXkiqGgKwidGuuCrOqxGsFtB+UXGAtCs82krdsBN1i+S8cS6AynFwMxyhu4nXR8cSkZSl+TY5u+ZQP/DX0Ut9BjPoSlT9i4ikImmTLO0pQACr513Y7LLl5tgudS42Xqn0KZA5etmFBGtnYc8NhdSIX4TYzf488IzQ4HRIWMd3N5s9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsNYS4/QCiZ0Ig7DZDixEuCmFTpUOjBLee51ivZ25Ss=;
 b=aWn7S+HpFg5cmJtfFQxFB+oOXUvjUryiRQYmFGwL1uIrSepClK5VcjUctIdIwejUjnsNOo7RScu+BQX+ZBimtIa3pZ2lQQJNS+jv1mdptNUM/WWZWrU5icNIh+AIGdvmqm7HQrzJK3WKWfUe4QL7nX9m/moWfQRZizzo/oxvVkrGamP5pCXQ457btb6TjmBZ2zOrDj2lcHY16ZLyr8eRG/VMZlgTaMmDDzBXttRPXv1r95DJEB4l6vubFmiV2uoO0trBwAbVtRTEK4fZEbqpuVwxBF5saCwfa1xDtCA2mjIkddHyodpbwX+Bw29DwVOENkJ9cINaW42q7L2yRgRD/w==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DU2PR04MB8824.eurprd04.prod.outlook.com (2603:10a6:10:2e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 02:37:14 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%7]) with mapi id 15.20.8093.024; Thu, 31 Oct 2024
 02:37:08 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Josua Mayer <josua@solid-run.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: Mikhail Anikin <mikhail.anikin@solid-run.com>, Jon Nettleton
	<jon@solid-run.com>, yazan.shhady <yazan.shhady@solid-run.com>, Rabeeh Khoury
	<rabeeh@solid-run.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, dl-S32
	<S32@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] mmc: host: sdhci-esdhc-imx: update esdhc sysctl
 dtocv bitmask
Thread-Topic: [PATCH v2 2/2] mmc: host: sdhci-esdhc-imx: update esdhc sysctl
 dtocv bitmask
Thread-Index: AQHbKtDtgomlsJCw90ycdwXZhBf8BbKfTgwAgADXh0A=
Date: Thu, 31 Oct 2024 02:37:08 +0000
Message-ID:
 <DU0PR04MB94960BAD8A18149664F244C490552@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20241030-imx-emmc-reset-v2-0-b3a823393974@solid-run.com>
 <20241030-imx-emmc-reset-v2-2-b3a823393974@solid-run.com>
 <61fa7a34-fa77-4a7e-b6cb-45fb5e671249@solid-run.com>
In-Reply-To: <61fa7a34-fa77-4a7e-b6cb-45fb5e671249@solid-run.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|DU2PR04MB8824:EE_
x-ms-office365-filtering-correlation-id: b2c225ac-685b-4e0c-69dc-08dcf954ea2b
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a2VZR0RjY3JMK2ZxUXFpYnNHeUlxS01uMDFjWTFrbVdsaHVlbmJJc3hITlZv?=
 =?utf-8?B?OGQxRXoyOGxPdXVqZzE3eEFxT1dZcjd3KzdxU2FtOVRLVDAvR2JkSkNHSk9E?=
 =?utf-8?B?UkdnUEhnemFreE04OUNuOFFmbUtGZ0dZOUhaTnVWUFlOSVhaMng4QTJoeENN?=
 =?utf-8?B?aWd4Q20vbk9NSzZuWUZ6cGh3dGJteUV0Y3VNOFc0b3VjNGd5SUxxTVQ1aE9i?=
 =?utf-8?B?WmtDNThiRG1URGhQWldyTDN1RUZZNkxOR3BaWGRpU0lJdVVjQVlFc2l3ZUt2?=
 =?utf-8?B?aXJ1cERHM1V3a2RjVnJCTE5mTVJHTGRCSnFXNDdNVnZ6VU5HZFp3VUJhQlZE?=
 =?utf-8?B?Y3c1cVhXblVHVk5iR2JlVGZEQ2haOW0yVklwSy9mTWdNU1hHc1Q2a2RYN2pE?=
 =?utf-8?B?SHpyaUVNNkY0REZPVkU5TXgvNTVZWklNTXlCOUxuakNCVm9oa1NmMGhHMENZ?=
 =?utf-8?B?SU56MkpnVzBhWFJPdzl1RW9LZGp6blpoaU5DZXR4cHZnUHlRV1pzMkVCU2F0?=
 =?utf-8?B?ZzdIdUVSOFVPOTNSYS9OdmhpUldUNkdHeGpFZTdTTG0rSFZ3VVlEYlpEMVpN?=
 =?utf-8?B?NHhOMFZpZGFLVWthN3lCM25OT0VxNFQ1OFREdWFPMTZaL1BualY0aUdPV01Q?=
 =?utf-8?B?RE1CUTFnV3Z5ME80eFJjZm1QT0NqOHUvaHB6Nm1SdnhMRlRlcUtiVVRhZXNT?=
 =?utf-8?B?ZERpVzFJZHZCVnJqWGJ1bXRrMVlvejRUaVllZDM0aXpRZm1MQ0NuNVduSVhH?=
 =?utf-8?B?TmRka2w1SHFZUkI1NVEwTThNVi8xNVkydnVOQlZwR2hFenN3ZUlpclFrdWR2?=
 =?utf-8?B?SitPQ2VON0REUWpyUUNsOG83Q3U4VVFseHRweEJteWZrdVB1aWZLcGkxUldX?=
 =?utf-8?B?NGg4dWdKdWMzV3Y0cWZvS0NucVYyRWVqV1pmaEVmODFVcGlCNWcyRURNT0RE?=
 =?utf-8?B?aHd6OGlSOVRaaCtuSkFNenRxaUNMTlN6djJKZjZNNXV5ck9oM2s3VmlacWNV?=
 =?utf-8?B?NEJYSGVzU2VHMG1GTkdZZlFLcUxLMUg4WlNpUzZQWEU2ajV2dlFGM2VOSDk0?=
 =?utf-8?B?OGRsQXk4UkxmNllwYk1iRit1YzFzNTA4SmhEb0h4cml4a1NoRE9pSGVPRk5N?=
 =?utf-8?B?eno4bG9YRmJlVDBneTFTVFFKTVlPOEVOVndvcWpocGlrdWVheHE1OWFqbDVF?=
 =?utf-8?B?bGFJYmhxQWJxRk9oUVRxVHdGY09lU2s2SnBYUVBXaWlNUFFLWmdPU0VOWU0x?=
 =?utf-8?B?ZmNQWk9MN3lxQkN6aUdBTm5zN0ZmYXlFZjU5UEYxWlE3QjI2dW9RQnVWUWZn?=
 =?utf-8?B?VkdMbkQzdDdhRUR4Y2c4bFBtWlROdC9BdlNWbW5welBpR2p6bmlXMllkK1dq?=
 =?utf-8?B?Tkp0SmxXVmlIdlJRdjJ0b3ptNTVERDVrOWVZZXV4WFNJTi9iV0FTMjBHMGpx?=
 =?utf-8?B?YjRHNzdtbmlPaVlFMFZvN2cvT0FEekN6ckRPU0VNcXg5MlF6K1g0RE55alBZ?=
 =?utf-8?B?VElQV3d2VEcxSmVqbDlLQlFTaVhRbjE4N29JRmVpNFFwdU1XRzNiOW5tT1lX?=
 =?utf-8?B?Zk91UDFkOXQ2RllhZzF0R1RoTUQvMkhxQVR0dVRGTlg2UEZtWkg2MmZtSmtG?=
 =?utf-8?B?elFXTGtLOVcrSU14VStZbVIycjNSRHp5eXAxVU5XenZjQnhSaW1WU3BjenBR?=
 =?utf-8?B?d1ZuRkdUSGFzenl2bzI2bjJFT0drbWNzeTdqZzVlNjhyNTNSTnFkaXFtdldj?=
 =?utf-8?B?ZXJrVVhiMjZ5ZThqakR1Uzh5OE5DdlZUWUd5bVpDMk1CRzBUMEpudEdUYW5h?=
 =?utf-8?Q?vBCD1pzFUjOyDv881g3iRhzBfB1IWGy1mTxf4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S0tPbE9ETjkxQWI3Q2NrRUxTZ2hqNmE5cHdqQStuYjVRcnVxOENRZ2lOQTVD?=
 =?utf-8?B?eU5YU2JIbmlVYnNNQnYvWkpzbE1HZTJ0TWtzT0JoVm5wak1UYWhqU0dZUkNG?=
 =?utf-8?B?bVZtSDBwZW1LNUp6RmZLOVNLWGkzOHVSd3dXN3RGN3BrR21VVytGZUg4QW92?=
 =?utf-8?B?RnFGR2dJOVNyOHZtYXVsczEzSVRLeDhNcFU2TEJCemxCWHJiSmZVczU5SEls?=
 =?utf-8?B?T0VBYUwwVnR0UitOOTZGMWx2UWM4ODZGNnVObmtXVWo5bnVsMSsyb2lHL1c4?=
 =?utf-8?B?QWREM0RLZUhzUjJwWHUySm5BdFZCdmFHcmk0M05YMzRZdngxSm9qWlNmeFRw?=
 =?utf-8?B?Ym1xNXd5a3pzQ3dpMzNzaE95OEJqMTJrK09TSUhxZDdoNjBMZyt3bGZZeEtW?=
 =?utf-8?B?OWx3N283QTluOVBBYVNxMktKdENFU1FkZU13RG1aVVVPMjRFM3FoYzFjODdu?=
 =?utf-8?B?ZFI0RGhzTmRzS0YxSW9ZK2NuZkNWMUp0bUYwc1VzeGNOL2hjZjJjT1dqc1Zs?=
 =?utf-8?B?Vi91QytvUjRsdU1VVCt1TzZHeUIvT0JZdWxzZGpueFF4S1dMREx4YkNBcGlk?=
 =?utf-8?B?WlVhNDFwL1dnVnN2RVVhR2YrWklpVUdPUm4xeGNxZ09oZU1kK2s5bWRWSnp3?=
 =?utf-8?B?dUt2M1ZnZGZ4R2RhMXFhaTNPU3UvZVVXaTNIWmtkTDkyczBkb2VsWHhCdFZF?=
 =?utf-8?B?ZW1jTGN0UDUyWExycDB4eEI3T2pMZWtFMDR3U2pxN1N4VHROU3FSVWdHZmpN?=
 =?utf-8?B?b0EwVUFlVEdYWFBvMWZtbVN2c2xtVzV5N3pFSS9wYVp3UjI3cDZnWDRoc25U?=
 =?utf-8?B?Mk01UStCaDFVY3NoQi9qRUw0QXBuWkFUWmw5TGd5eXJxYXlEaHJNeE1rSjFq?=
 =?utf-8?B?NjdYMHUreGZiSlhBV0xydUFpSHNOajg4TFFkdHQyNzhFTWpnWGFGUUlQTHI4?=
 =?utf-8?B?ek00UFdZdzV0aW5IZ1ZiRjdhVm5UVHRJTUpzQkhNT2NxRnBwTHMyWFlCelEw?=
 =?utf-8?B?dTVnUWhQeVZ1dzBIRHdCUmdZNUU3cTc5MU90TUVDaGthR3dYMTVRZkxtdHBm?=
 =?utf-8?B?c3hMTnJQSnM5Z1RFa2d0V2tqSFMrUjRGbTN2L1VXY2s4dVhqbHN3RzlOYWp4?=
 =?utf-8?B?RnZnZXpxQzh4cmFBYlJONGQ2dXJ4ZlN0Tkp5UzJVaGl1R09MWGduOXBLSzcr?=
 =?utf-8?B?dE5rSmNBOHFueGlwUTlkb1FkdUlIUHowSG4yOUxRY1BNajh6b2M5TXd3VDZn?=
 =?utf-8?B?cUhOTmd2My9RcVZMNWM3UzBBOFpiTS9zRXZWcEM4Rlc4WkpBS3E2WWRSZlpm?=
 =?utf-8?B?NnliNXJEd25jTXJ3NHNtSnBpNFBaR2FUY1RxZHpDV25JL1dJbm1TZEQ0Rk8w?=
 =?utf-8?B?L2o2cmhZM3Mrc0FkSG9OQWI3aElJb2d0WUcvTURweDZoQ090Sk1BVEVSUGJR?=
 =?utf-8?B?dTFkbGJra3FMSTRHWkFacHFnMHFWdXBvTnZ4eitVNERkVUZNdTh1OHA3ZWNx?=
 =?utf-8?B?OUFDR0VTN2htb1A0K2t4TnJmaEhMREZMWng4TXRSbDBseHhJMG4wVkx6OGpj?=
 =?utf-8?B?cUh2Tmd6U2NhakpEMmprQUY1YnlZU3JneUpRcys5ckNQSFJrL1dEQ2hPSDIw?=
 =?utf-8?B?QkpXV2ZZYzlHbmZrcmh6R1h2aGdrSjdhL2s4WFF5VGUyU05YOGdNMkpkSXky?=
 =?utf-8?B?TjRkVDZMZVZnNEh6SkFITmcyTE9JZGZmN1VBRGU2SHlNM2I2a3NEZkpQbkFx?=
 =?utf-8?B?eCtKa1QzZ1BncGZoZU5hOHRtMjF1RldIaTVXYmZQTi9WWVNJWFliVVRzZlVF?=
 =?utf-8?B?NnRvMnZiRm1IZkZaUFhMOFNOU1Z4d1ZrTW1uUUhMUjhPRStEZnNuM3lRcjg1?=
 =?utf-8?B?bHFHME1PSDZRRzF1VjhWRWVML2hma1J0NXYyeng3UkJoVkFyRi9STTQxYVdk?=
 =?utf-8?B?R1pwNFNoZGxIVVlqVFZ3RS9OMEZsTTlpUmw5MGlpU0UvQU0rd1pFMnhtaTRj?=
 =?utf-8?B?eFNqM1Q3ZHdRYTF3c3lQTzR5S2EvZStlZVpIOU40Z0ZoWWRaR0lNL3dlbmhr?=
 =?utf-8?B?dC9lQ0hUSHpWZHg0bWFNbk93K09LQ083NStpZ1M0SnRlNUd1clBjUTdTalpG?=
 =?utf-8?Q?NtVQ=3D?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c225ac-685b-4e0c-69dc-08dcf954ea2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 02:37:08.0438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r/plEBYomIsR3P+arrPt5/inLZ0UvcTjym6HETA32+snmaBc2FXiO7J+LGchy1SlgnbkanjsY+nx/CNMqxovxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8824

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb3N1YSBNYXllciA8am9zdWFA
c29saWQtcnVuLmNvbT4NCj4gU2VudDogMjAyNOW5tDEw5pyIMzDml6UgMjE6NDQNCj4gVG86IEFk
cmlhbiBIdW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgQm91Z2ggQ2hlbg0KPiA8aGFp
Ym8uY2hlbkBueHAuY29tPjsgVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+OyBT
aGF3biBHdW8NCj4gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJA
cGVuZ3V0cm9uaXguZGU+Ow0KPiBQZW5ndXRyb25peCBLZXJuZWwgVGVhbSA8a2VybmVsQHBlbmd1
dHJvbml4LmRlPjsgRmFiaW8gRXN0ZXZhbQ0KPiA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBDYzog
TWlraGFpbCBBbmlraW4gPG1pa2hhaWwuYW5pa2luQHNvbGlkLXJ1bi5jb20+OyBKb24gTmV0dGxl
dG9uDQo+IDxqb25Ac29saWQtcnVuLmNvbT47IHlhemFuLnNoaGFkeSA8eWF6YW4uc2hoYWR5QHNv
bGlkLXJ1bi5jb20+OyBSYWJlZWgNCj4gS2hvdXJ5IDxyYWJlZWhAc29saWQtcnVuLmNvbT47IGlt
eEBsaXN0cy5saW51eC5kZXY7DQo+IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGRsLVMzMiA8
UzMyQG54cC5jb20+Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzJd
IG1tYzogaG9zdDogc2RoY2ktZXNkaGMtaW14OiB1cGRhdGUgZXNkaGMgc3lzY3RsDQo+IGR0b2N2
IGJpdG1hc2sNCj4gDQo+IEFtIDMwLjEwLjI0IHVtIDE0OjM3IHNjaHJpZWIgSm9zdWEgTWF5ZXI6
DQo+ID4gTlhQIEVTREhDIHN1cHBvcnRzIHNldHRpbmcgZGF0YSB0aW1lb3V0IHVzaW5nIHVTREhD
eF9TWVNfQ1RSTCByZWdpc3Rlcg0KPiA+IERUT0NWIGJpdHMgKGJpdHMgMTYtMTkpLg0KPiA+IEN1
cnJlbnRseSB0aGUgZHJpdmVyIGFjY2Vzc2VzIHRob3NlIGJpdHMgYnkgMzItYml0IHdyaXRlIHVz
aW5nDQo+ID4gU0RIQ0lfVElNRU9VVF9DT05UUk9MICgweDJFKSBkZWZpbmVkIGluIGRyaXZlcnMv
bW1jL2hvc3Qvc2RoY2kuaC4NCj4gPiBUaGlzIGlzIG9mZnNldCBieSB0d28gYnl0ZXMgcmVsYXRp
dmUgdG8gdVNESEN4X1NZU19DVFJMICgweDJDKS4NCj4gPiBUaGUgZHJpdmVyIGFsc28gZGVmaW5l
cyBFU0RIQ19TWVNfQ1RSTF9EVE9DVl9NQVNLIGFzIGZpcnN0IDQgYml0cywNCj4gPiB3aGljaCBp
cyBjb3JyZWN0IHJlbGF0aXZlIHRvIFNESENJX1RJTUVPVVRfQ09OVFJPTCBidXQgbm90IHJlbGF0
aXZlIHRvDQo+ID4gdVNESEN4X1NZU19DVFJMLiBUaGUgZGVmaW5pdGlvbiBjYXJyeWluZyBjb250
cm9sIHJlZ2lzdGVyIGluIGl0cyBuYW1lDQo+ID4gaXMgdGhlcmVmb3JlIGluY29uc2lzdGVudC4N
Cj4gPg0KPiA+IFVwZGF0ZSB0aGUgYml0bWFzayBkZWZpbml0aW9uIGZvciBiaXRzIDE2LTE5IHRv
IGJlIGNvcnJlY3QgcmVsYXRpdmUgdG8NCj4gPiBjb250cm9sIHJlZ2lzdGVyIGJhc2UuDQo+ID4g
VXBkYXRlIHRoZSBlc2RoY19zZXRfdGltZW91dCBmdW5jdGlvbiB0byBzZXQgdGltZW91dCB2YWx1
ZSBhdCBjb250cm9sDQo+ID4gcmVnaXN0ZXIgYmFzZSwgbm90IHRpbWVvdXQgb2Zmc2V0Lg0KPiA+
DQo+ID4gVGhpcyBzb2x2ZXMgYSBwdXJlbHkgY29zbWV0aWMgcHJvYmxlbS4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEpvc3VhIE1heWVyIDxqb3N1YUBzb2xpZC1ydW4uY29tPg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jIHwgNCArKy0tDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiA+IGIvZHJp
dmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiA+IGluZGV4DQo+ID4NCj4gYTgzMGQ5
YTk0OTA0MDhkMzE0OGI5MjdiZjFhY2M3MTlhMTNlODk3NS4uMTAxZmVhYmIyNGZiNDFiZDEwYTJl
Nzk2Zg0KPiA0ZjMNCj4gPiBmOGQ0MzU3ZGMyNDUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9t
bWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2Ro
Y2ktZXNkaGMtaW14LmMNCj4gPiBAQCAtMzAsMTAgKzMwLDEwIEBADQo+ID4gICNpbmNsdWRlICJz
ZGhjaS1lc2RoYy5oIg0KPiA+ICAjaW5jbHVkZSAiY3FoY2kuaCINCj4gPg0KPiA+IC0jZGVmaW5l
IEVTREhDX1NZU19DVFJMX0RUT0NWX01BU0sJMHgwZg0KPiA+ICAjZGVmaW5lCUVTREhDX0NUUkxf
RDNDRAkJCTB4MDgNCj4gPiAgI2RlZmluZSBFU0RIQ19CVVJTVF9MRU5fRU5fSU5DUgkJKDEgPDwg
MjcpDQo+ID4gICNkZWZpbmUgRVNESENfU1lTX0NUUkwJCQkweDJjDQo+ID4gKyNkZWZpbmUgRVNE
SENfU1lTX0NUUkxfRFRPQ1ZfTUFTSwlHRU5NQVNLKDE5LCAxNikNCj4gPiAgI2RlZmluZSBFU0RI
Q19TWVNfQ1RSTF9JUFBfUlNUX04JQklUKDIzKQ0KPiA+ICAvKiBWRU5ET1IgU1BFQyByZWdpc3Rl
ciAqLw0KPiA+ICAjZGVmaW5lIEVTREhDX1ZFTkRPUl9TUEVDCQkweGMwDQo+ID4gQEAgLTEzODcs
NyArMTM4Nyw3IEBAIHN0YXRpYyB2b2lkIGVzZGhjX3NldF90aW1lb3V0KHN0cnVjdCBzZGhjaV9o
b3N0DQo+ID4gKmhvc3QsIHN0cnVjdCBtbWNfY29tbWFuZCAqY21kKQ0KPiA+DQo+ID4gIAkvKiB1
c2UgbWF4aW11bSB0aW1lb3V0IGNvdW50ZXIgKi8NCj4gPiAgCWVzZGhjX2NscnNldF9sZShob3N0
LCBFU0RIQ19TWVNfQ1RSTF9EVE9DVl9NQVNLLA0KPiA+IC0JCQllc2RoY19pc191c2RoYyhpbXhf
ZGF0YSkgPyAweEYgOiAweEUsDQo+ID4gKwkJCWVzZGhjX2lzX3VzZGhjKGlteF9kYXRhKSA/IDB4
MEYwMDAwIDogMHgwRTAwMDAsDQo+ID4gIAkJCVNESENJX1RJTUVPVVRfQ09OVFJPTCk7DQo+IF5e
IFRoZXJlIGlzIGEgbWlzdGFrZSBoZXJlLCBpbnRlbmRlZDogRVNESENfU1lTX0NUUkwgKEkgY2hh
bmdlZCB0aGF0IGxhc3QNCj4gc2Vjb25kIHdoaWxlIHdyaXRpbmcgY29tbWl0IGRlc2NyaXB0aW9u
IDooICkNCg0KWWVzLCBwbGVhc2UgZml4IHRoaXMuDQoNClJlZ2FyZHMNCkhhaWJvIENoZW4NCj4g
PiAgfQ0KPiA+DQo+ID4NCg==
