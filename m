Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3235A17C228;
	Mon, 28 Oct 2024 02:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730081405; cv=fail; b=Eua+2PGhjmZ+p5XcIbMZ383d6Q2kbkWYIIAnF+ouzrGoj7+Vm8jv0u6PypvWgrD5gPX5qXk5L8sQdfyydstdbd0VpFB7GEfZO7qkbIdMRi2qGmUZy8Elb8iSPyDh7jgXJ6tHh+f2FBLcYqQWZln356CtKOxrFYzYjiUt3+tVgBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730081405; c=relaxed/simple;
	bh=kLMgWeufwgssPC44uGlo3XCqhUigW91EarN1jM5EJls=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NDkgO5JOnqScH5vbd7m+ZeFQB0pkwFUcrT5hwgjWf2A3oEh+V6M5F8z5vqa+kIuGr5fOyWvUfH0Oygvo8s17bIb38gYLWIWfJf6gZMqtC03/x1QBK7j1wNAA1gxENFpCHa6rwnoaNQ5xRfltXOjpwbqWJwQuB58c3OJMD9sR6gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=adDbGY3s; arc=fail smtp.client-ip=40.107.22.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="adDbGY3s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPrcAgaGOSFYQdRVsBpR8lHahTnYoeSJiltxgO5Kwzeo3D4DX6rWL6z5zICBEcKY74k/YqEn0rhyJqResCfETIihAkI+G6Ns0M47eoSXJlM/NpLiNDny0J4pLvPlOjWvom+hcSaq5lvPuqVdC7BahxhSf5Y+7eBqcjf1I50z9rXDGmhSeLRbDoRlCTdlO9OPqeO9QYSFo/bWbfxmJKsXLki8+3MeN6M8eSH7rTHlFU1hS2kSvDDGxLVnNV/d5y0XmCbQeIRd86l7Yt/Jx347WdS+yhd1gd8UUZVHMJOyFTBRCUS0UasKUkv9tmrDJDJ8lMQM46NXe+D4YFCYex5bZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLMgWeufwgssPC44uGlo3XCqhUigW91EarN1jM5EJls=;
 b=uDiEyq8kn1CYJHg9RvQkyAjxeeRJeeDbZNwG2uJ3Dyn9ok8FA1DCa31HdaZclsRY/Og7H/879+PVrBKxK6Rc48Ru/k4c0z1Z2QAUwyLY6fV7FLDx7VSeMMttNGQv1kzL07mMBFwXBj2KXpstqYT5R7diw6F7iumS0hTZ8hsBcR4dz28kV5eF/n4pMn4ip6lr8pqo0pGCoSsEGz460G3cEGrHEzncyLhAvlieNsLqhhMNpik8JdVuPQ10JRUfpVY7exYm+YbzlQuxCccdSxqz1a+KepIKiO7yC0J96fLfSSC8t7O1Yu4ewM6BNJyUQjGgyWR6oJkFgJcTiLIuQEuhOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLMgWeufwgssPC44uGlo3XCqhUigW91EarN1jM5EJls=;
 b=adDbGY3sMueMxEeRC/z/kSmgkXL/WeZI2KKma6GU5wA5aDQpy1PxVVXw9QaiuATRXh0FnmZxWlVr+iX/BMJVBcDu4AKecnwYEN8j1EzWlGBXx6m2H4Mhz8fjfyWmRVGbH42LVb33Ut9kQM1HlpUEpSopa4D0JrSFmdO3YDFNbO1iB1aNxH/ObDv4GHsHKL/2uawi9tMYfTaO9RkXO6X9XFAiGEao686tyGXXjBH/EouZYHP0o4cRk6govGUXmbDJfnJY12lg/Geshq/JrFyTvfh6arBsMX/QATG2aTx8XTxR+xm8fCcwc0IXFyBh1/mqgO0Nl5d5F1Pln3tfL6ozWQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS1PR04MB9405.eurprd04.prod.outlook.com (2603:10a6:20b:4db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 02:09:59 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 02:09:59 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Josua Mayer <josua@solid-run.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Bough Chen <haibo.chen@nxp.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
CC: yazan.shhady <yazan.shhady@solid-run.com>, Rabeeh Khoury
	<rabeeh@solid-run.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, dl-S32
	<S32@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: host: sdhci-esdhc-imx: implement emmc hardware reset
Thread-Topic: [PATCH] mmc: host: sdhci-esdhc-imx: implement emmc hardware
 reset
Thread-Index: AQHbKH5nd7S6LjTbSUirVHK6LVTcubKbas4w
Date: Mon, 28 Oct 2024 02:09:58 +0000
Message-ID:
 <PAXPR04MB84591664B7A4455E6F0BD19E884A2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241027-imx-emmc-reset-v1-1-d5d0c672864a@solid-run.com>
In-Reply-To: <20241027-imx-emmc-reset-v1-1-d5d0c672864a@solid-run.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS1PR04MB9405:EE_
x-ms-office365-filtering-correlation-id: 72593672-63ff-4869-632d-08dcf6f59fe7
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M1lKWnd5aUF4M1JMRUFvcit4WVYyeFVqMUlkbnJERzJmSldJTDJvT3JyUXYx?=
 =?utf-8?B?bVdFYWJhWG9TelR2UFFzZThERFNia0VaS0pwOHJZcmRGNHZWSVlMeGIycFlW?=
 =?utf-8?B?WW0wamRoUXd3ZWFja2dnQXM4VXVnc0tMdlkzajdDM1l6cTBOdFdHOGlpbzNV?=
 =?utf-8?B?ZDY5OUt4WXloV0lsdnlmWW4rYndPYjZqMGMyWkt1T3ptZVkvTjVDV3BxVnhj?=
 =?utf-8?B?dE1QM3djeFU1ODRtcWtnQllVSXplTnc5RjlXOVNEVkFiSGxlU1BlcHBPTXc5?=
 =?utf-8?B?Qmt1VjAra2RLT2x6cmIrZjc5VElUQ0ZsMHpQa0llMUxCcWRIOFRDc1dIMUIw?=
 =?utf-8?B?OHBVSzZ3REMrS0V2amZROUZCZE1QOUV0d1R3RHhweUp4RU5saGFPMWV1OWMv?=
 =?utf-8?B?dWNXZ3VOZW42b1dRWlVNNDRPYVRzS1pMbHFlQzlvMlJqWStXWDJMek1tRnFG?=
 =?utf-8?B?V0FPclU5dzM2c2JWQndCQkxVaUx0bnpLYnFYbTJBMndsUndTdk5nVHI1RWJu?=
 =?utf-8?B?dzFBaW9RSFdodWx1blVCZmkxTnpqUHc2dU00cFBQRmRQZWQ3R2hQZTg1ejgy?=
 =?utf-8?B?dGpudlVkMWsvejJYSFVUZ00wMk80Z0Z5RnRNVFIzbktwZTdjbmVRNktON3NT?=
 =?utf-8?B?SDJpOVhqU3ZBUkZaRFo1N2ZEUDV3M25EbVpWZzk0eTBnWkhEbFdnWngrNGNo?=
 =?utf-8?B?dXJwdnphbkM0YmVLVVVuVXA2NC8wSHZjb1FtSXpkMDdDYlFhMXBuY0dUL1VQ?=
 =?utf-8?B?amxrVHJpdmRSSFRPaTA2SHRvUGc2KzFJVW15d1NDcFVPVXRmVlNGUVphdTkr?=
 =?utf-8?B?bmxuSnBuUXdwcGkzYVlGd1EvejhORm9pd0wrWnJraG12VjJjbVUrWmRlbVZ3?=
 =?utf-8?B?VXNjZWkvS1hOOWRvbTRockN0dkVjWTFMUGhIQ0t2THByQjRQenYvU1lUMFRV?=
 =?utf-8?B?V0tUZk5yQm1SVTQvYVVxbngxTFd0VE01NVV2KzF5dWpnaEY1ZzhHUTJyNDQr?=
 =?utf-8?B?Nnk5c1g1bHk4eVRzTzJHTW81Q3VtYlVEMEJ3WGRLdFIvK29aOU0vN29zb1l2?=
 =?utf-8?B?N3hGTCtJYkNkS2IxRGtia0JGYU14ZzhveS9CMFk1VjlSTnl3b1U1MkRiQldT?=
 =?utf-8?B?Ny9ZYTIxNDdNNmpsUTBtazRjODFIbzdWWDdnNURRbjFnNmlPMTVlb2xwV1Mx?=
 =?utf-8?B?OVIwZWtTaHpyWUlRaTR1ZW5mSmlBcEZNTVEyYXdpUmlrTk9DSjk3d0sxVFk5?=
 =?utf-8?B?WUkvVGV0V3I4akdtdTQwdm9XWVpPV083YkR1Ujg5UXRmUWR6QWhnVUhIa3JP?=
 =?utf-8?B?NnlhcVhVUG9kWDRDNzhlTHROdVB4dXo3eGZVOUNodmFsZnk3cFkvbDZjMW5D?=
 =?utf-8?B?V3RoLzlHYkFFejNvSDRmZFVheXMyeHFCb20wZkZBV2pwVm5TS2FMQXpCV0NZ?=
 =?utf-8?B?a2hTUHBGbEV6WjR0bWFGUWt0SkQxdXdXY1hMQjhHVDhnWnNKVFVWWGFRcmdt?=
 =?utf-8?B?NG42TDNKTGlYNFhRM1VmYm02cXFmNXhmSTV2dTE4c1NkNG1DazlaVlM1cWlm?=
 =?utf-8?B?WC9xSlJHSGdxdjVBRVIzME9wamczR0pibDlRRjJaRmNCUk4wL2tIVlNCR2J0?=
 =?utf-8?B?L0p2RGJsdk8rWVptY0xiMjcyRUpRU1hldmYrQXhTMnF6ZmpML2JVL3JsMnN1?=
 =?utf-8?B?M0I2dFlvdWx4aFRIaVRuV3JNZURscmNxcHd5dnplWXV3MmVEMXJWVUlSbVBG?=
 =?utf-8?B?MXhEUVAyS2VBMUJpdHZ1eWlFWGdlY0Z1TkRFZGVvZFNyTXJ0ZDBpT0RSQnAw?=
 =?utf-8?Q?RA/43n1zzkBNOlvdHOpruVS7IDGgPGfUsFmns=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cmtobHl2WjlUeW12UEt5ZkpWYnVkeDYzc1dwSWEzVEZIVFErZWlXeDQ5SFht?=
 =?utf-8?B?UzJ5WVNad1pQbkhYQmdoajl0SXNwS1AzQTdDaEsxMGxHTnpGNFliS0x0Ky9M?=
 =?utf-8?B?SFJUOE9CSWNIVWxWR2RHdjE5d3ZwbDluZjBCbHBGbTRFdi9lZDMvWTBKd1JS?=
 =?utf-8?B?cmZhdXpqOU5kcEFtOXR3dnNjVWtha1FEdHQ3YVFZMEpyb3ZzM0FBZXcxcE11?=
 =?utf-8?B?dUU4WTIvenpqVEt0bmdXL05ybWV2WXFvQVJHZHdUcC9rY0p4RTZxU1JEdXBl?=
 =?utf-8?B?VEJSK3FpVlg3NHFqR2JNM2duWDNxQjZoNVVST2dmck9wSzJ0Sngyc2xsRlBG?=
 =?utf-8?B?ZzdmSmRjUytNYnBJREFUdldUcTU2R2xpWVo1NW5zQjVXZ3ZIQmlLeWVMQnF3?=
 =?utf-8?B?OS82M0xJNlIwYjM0aUJPNEVhenIxeWs3ME5XR1NacldUcGpPUzFaNVM0V3hO?=
 =?utf-8?B?S0tRQytyNjJ5WDFMR09SMDE4N1hhZkRtSUo0WWdJbW9Eb0FPc3pnQlkwbzQx?=
 =?utf-8?B?d0xaZTNYN2cxdFEyank0c0lHUGI2UHh0L0E3dUp1akZmdDhnYjVWbWJ5Q09K?=
 =?utf-8?B?aXArS2tsNC9nZ1hvN2c1UGllcHlUMHFWdVFPZ2pTWHVBYyt4TVAvTGRjdkF2?=
 =?utf-8?B?SFJKS2pvV2VJaUZFLzVULzhtRGtJeXNmcTZ1SGJWRjd3WlRhQTBnWFFWeE9k?=
 =?utf-8?B?eVBUN1pvS0ZiTFovTm5sQmlYQzl4MWllUmlxQzJCNVJIaWRtR1JNT05Zalpl?=
 =?utf-8?B?cGNLUHlDbDlSc1F6RzNZVExObHl4emFlNStHS0pWclYwZC9lUTNYR2xHQlVq?=
 =?utf-8?B?NE43dkhWb1lmQ00zc0hiZXZQYVpycE1kREUrVVNscVc5STBwYmpYMk51VVFi?=
 =?utf-8?B?di9iOHJVZFpUOGxtQlE5WjdaVEVCV093U2hGN2xMRE5HQnNZcEJwcGhzbUdJ?=
 =?utf-8?B?L0lmMWFlYithSGdkTXFndzRsc1pUNTVNRGxvY1JCZHE4VGdmN2YzaXA5ZFNs?=
 =?utf-8?B?cExmQUM1SHpTWjArMVFsRnBPdk91elE0NUFrd0p0Y0RsZGVwK3lWdnM1QTJJ?=
 =?utf-8?B?V1RBYWhUNWdNcFJlOENTTnVUSjY2V01YQTN6SkJBMm9oV0pablFsMkg3ZXZH?=
 =?utf-8?B?bjNWYjgrM2liVVArc2x5cFlBWUwxRUpvblFwM2FveklrY3BOWGJUV0o3czA1?=
 =?utf-8?B?OXJIcmV3aTNyZEs0QlZJUytQSHk4RmJlT1BKbjJMek94UTBLaC84c3NiMTUr?=
 =?utf-8?B?dmNXUVhyR1NoakNwVktOUmpoa2xuazAxRnpHWWh6dWo0NWkzM3FlTW45djRF?=
 =?utf-8?B?anZQNzU2MzRlWU1CVWxNYlpKTWMxMW9HR283cGJza3BCbmVDekkwQnFyVVkw?=
 =?utf-8?B?amV1Ync3Z1JWajV3ZXVacnNkVmZkc25MaFIxbTltTllMMVh0UExmMmJGSzdR?=
 =?utf-8?B?K0plVVpYZHNtR1htME1QRWpkY05QbTE1cmpVL09UWGpzUVZldnN1a1FNbk15?=
 =?utf-8?B?OXVOZXZjNGdoQjh5ejhxTVdVOVFWbHlhWVozT3pqRDhqOGNjN3VlcGV6WkJR?=
 =?utf-8?B?RTNCaS81azJXd0gvVU55azh3TEhMMWhEQncxdUNRRHllY2Z0ZExrYjNjQVAv?=
 =?utf-8?B?czlodEpQcnU4eFh3b0JrODhFQWU5emljV1lDRWxGajdWb2VLOW5mcUVmY0tX?=
 =?utf-8?B?Q3BJUGxWYWxGNGFQMm5ONExvQ2xYNCt3VWcvUTV1YW5YbGhZZTlpd2dDN3FH?=
 =?utf-8?B?UUFkZ3JOZHVEZ0FKdU9iWlMrM1ZpVnNNbjN3dFU4d1lHTlViMWFXZlRqbzVw?=
 =?utf-8?B?R3lIelhnUTc4SmRmMldIMGJoN0JHWm1lZUtCc1l4aU9CQ1N6WEEvUTNNcFIx?=
 =?utf-8?B?MitWdVloUHpHME5mYmZKb3ZTcTU1OHI1WCtwcS9jc0xjUEpaL2ZnTEhlNDh5?=
 =?utf-8?B?NElYNDFWR1Q3cmlSaEpza2NFQXBEWGlsSEI2M3FuN1JZMnBrWGJySU1JRlZF?=
 =?utf-8?B?ZXE4ekphQWxqUlZrSDJLOUk1SGhDTi9mVWEvakF6RlVGdFJkYzNCbVVCUjU1?=
 =?utf-8?B?ai9mSGczdXhHdEwrdVJxVU9hZWNGR1Bzck1lWWpXV0VZbXgxNDRUWlpOaHdI?=
 =?utf-8?Q?ZkPk=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72593672-63ff-4869-632d-08dcf6f59fe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 02:09:58.9295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kapnESfxbXAkiXe+8ltAItbPvUYjaYy/J3J6azOmMQSKC8J+AcFgn3VZd/aEddVT3xVZUNYBYP7V0pAaLQHSGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9405

PiBTdWJqZWN0OiBbUEFUQ0hdIG1tYzogaG9zdDogc2RoY2ktZXNkaGMtaW14OiBpbXBsZW1lbnQg
ZW1tYw0KPiBoYXJkd2FyZSByZXNldA0KPiANCj4gTlhQIEVTREhDIHN1cHBvcnRzIGNvbnRyb2wg
b2YgbmF0aXZlIGVtbWMgcmVzZXQgc2lnbmFsIHdoZW4gcGlubXV4DQo+IGlzIHNldCBhY2NvcmRp
bmdseSwgdXNpbmcgdVNESEN4X1NZU19DVFJMIHJlZ2lzdGVyIElQUF9SU1RfTiBiaXQuDQo+IERv
Y3VtZW50YXRpb24gaXMgYXZhaWxhYmxlIGluIE5YUCBpLk1YNlEgUmVmZXJlbmNlIE1hbnVhbC4N
Cg0KQnV0IHRoaXMgcmVsaWVzIG9uIHRoZSBQQUQgYmVlbiBjb25maWd1cmVkIGFzIFJFU0VULCBz
aG91bGQgdGhpcw0KZmxvdyBiZWluZyBkZWZhdWx0IGVuYWJsZWQgd2hldGhlciB0aGUgUEFEIGlz
IGNvbmZpZ3VyZWQgYXMgUkVTRVQgb3INCm5vdD8NCg0KPiANCj4gSW1wbGVtZW50IHRoZSBod19y
ZXNldCBmdW5jdGlvbiBpbiBzZGhjaV9vcHMgYXNzZXJ0aW5nIHJlc2V0IGZvciBhdA0KPiBsZWFz
dCAxMHVzIGFuZCB3YWl0aW5nIGFuIGV4dHJhIDMwMHVzIGFmdGVyIGRlYXNzZXJ0aW9uLg0KPiBU
aGVzZSBwYXJ0aWN1bGFyIGRlbGF5cyB3ZXJlIGluc3BpcmVkIGJ5IHN1bnhpLW1tYyBod19yZXNl
dCBmdW5jdGlvbi4NCj4gDQo+IFRlc3RlZCBvbiBTb2xpZFJ1biBpLk1YOERYTCBTb00gd2l0aCBh
IHNjb3BlLCBhbmQgY29uZmlybWVkIHRoYXQNCj4gZU1NQyBpcyBzdGlsbCBhY2Nlc3NpYmxlIGFm
dGVyIGJvb3QuIGVNTUMgZXh0Y3NkIGhhcw0KPiBSU1RfTl9GVU5DVElPTj0weDAxLCBpLmUuDQo+
IHJlc2V0IGlucHV0IGVuYWJsZWQsIExpbnV4IHY1LjE1Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
Sm9zdWEgTWF5ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9tbWMv
aG9zdC9zZGhjaS1lc2RoYy1pbXguYyB8IDEyICsrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDEyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0
L3NkaGNpLWVzZGhjLWlteC5jDQo+IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXgu
Yw0KPiBpbmRleA0KPiA4ZjBiYzZkY2EyYjA0MDJmZDJhMDY5NTkwM2NmMjYxYTViNGUxOWRjLi5l
YmNmYTQyN2NjYTZjYzI3OTENCj4gYTE3MDFhMzUxNWVmNjUxNTc3OWFhNCAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiArKysgYi9kcml2ZXJzL21t
Yy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+IEBAIC0zMyw2ICszMyw4IEBADQo+ICAjZGVmaW5l
IEVTREhDX1NZU19DVFJMX0RUT0NWX01BU0sJMHgwZg0KPiAgI2RlZmluZQlFU0RIQ19DVFJMX0Qz
Q0QJCQkweDA4DQo+ICAjZGVmaW5lIEVTREhDX0JVUlNUX0xFTl9FTl9JTkNSCQkoMSA8PCAyNykN
Cj4gKyNkZWZpbmUgRVNESENfU1lTX0NUUkwJCQkweDJjDQo+ICsjZGVmaW5lIEVTREhDX1NZU19D
VFJMX0lQUF9SU1RfTglCSVQoMjMpDQo+ICAvKiBWRU5ET1IgU1BFQyByZWdpc3RlciAqLw0KPiAg
I2RlZmluZSBFU0RIQ19WRU5ET1JfU1BFQwkJMHhjMA0KPiAgI2RlZmluZSAgRVNESENfVkVORE9S
X1NQRUNfU0RJT19RVUlSSwkoMSA8PCAxKQ0KPiBAQCAtMTQwMiw2ICsxNDA0LDE1IEBAIHN0YXRp
YyB1MzIgZXNkaGNfY3FoY2lfaXJxKHN0cnVjdA0KPiBzZGhjaV9ob3N0ICpob3N0LCB1MzIgaW50
bWFzaykNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gDQo+ICtzdGF0aWMgdm9pZCBlc2RoY19od19y
ZXNldChzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCkgew0KPiArCWVzZGhjX2NscnNldF9sZShob3N0
LCBFU0RIQ19TWVNfQ1RSTF9JUFBfUlNUX04sIDAsDQo+IEVTREhDX1NZU19DVFJMKTsNCj4gKwl1
ZGVsYXkoMTApOw0KPiArCWVzZGhjX2NscnNldF9sZShob3N0LCBFU0RIQ19TWVNfQ1RSTF9JUFBf
UlNUX04sDQo+ICsJCQlFU0RIQ19TWVNfQ1RSTF9JUFBfUlNUX04sDQo+IEVTREhDX1NZU19DVFJM
KTsNCj4gKwl1ZGVsYXkoMzAwKTsNCg0KUGxlYXNlIGFkZCBhIGNvbW1lbnQgb24gd2h5IDEwdXMg
b3IgMzAwdXM/IFRoaXMgaXMgYm9hcmQNCnJlbGF0ZWQgb3Igc29jIHJlbGF0ZWQgb3IgY2FyZCBy
ZWxhdGVkPw0KDQpUaGFua3MsDQpQZW5nLg0KDQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBzdHJ1Y3Qg
c2RoY2lfb3BzIHNkaGNpX2VzZGhjX29wcyA9IHsNCj4gIAkucmVhZF9sID0gZXNkaGNfcmVhZGxf
bGUsDQo+ICAJLnJlYWRfdyA9IGVzZGhjX3JlYWR3X2xlLA0KPiBAQCAtMTQyMCw2ICsxNDMxLDcg
QEAgc3RhdGljIHN0cnVjdCBzZGhjaV9vcHMgc2RoY2lfZXNkaGNfb3BzID0gew0KPiAgCS5yZXNl
dCA9IGVzZGhjX3Jlc2V0LA0KPiAgCS5pcnEgPSBlc2RoY19jcWhjaV9pcnEsDQo+ICAJLmR1bXBf
dmVuZG9yX3JlZ3MgPSBlc2RoY19kdW1wX2RlYnVnX3JlZ3MsDQo+ICsJLmh3X3Jlc2V0ID0gZXNk
aGNfaHdfcmVzZXQsDQo+ICB9Ow0KPiANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2RoY2lfcGx0
Zm1fZGF0YSBzZGhjaV9lc2RoY19pbXhfcGRhdGEgPSB7DQo+IA0KPiAtLS0NCj4gYmFzZS1jb21t
aXQ6IDk4NTJkODVlYzlkNDkyZWJlZjU2ZGM1ZjIyOTQxNmM5MjU3NThlZGMNCj4gY2hhbmdlLWlk
OiAyMDI0MTAyNy1pbXgtZW1tYy1yZXNldC03MTI3ZDMxMTE3NGMNCj4gDQo+IEJlc3QgcmVnYXJk
cywNCj4gLS0NCj4gSm9zdWEgTWF5ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+DQo+IA0KDQo=
