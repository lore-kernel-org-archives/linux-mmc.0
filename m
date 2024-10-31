Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2064.outbound.protection.outlook.com [40.107.249.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1737845025;
	Thu, 31 Oct 2024 01:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730338748; cv=fail; b=RX4+CbTZkpp+1vOA0rqwC95TE6eYfct9JWeV3tibLkt8YGMEQBWf7V4OC9yVPZakAZ4NcJ90j6f0k7YTwmogUo517Tpa4e16CmN0bx3So9eV6baddH4Nr+wNrcAP2npaFq01FVK2dOlDD3G/RSgda2vRQskpYHwdx8J0Jxcq8r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730338748; c=relaxed/simple;
	bh=tsyLwfC+Q3+2hbbb9+usbP9q0/p/jRB7aqpQr29YvC8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OvOA1JfjpdXRJkPyU97nu6wpIeKWR7LCdGgqoXPaB5/Aa5ZwYtuqtFNKkPp0YS9M+RNzC3kTVxzdLQYTgAjStPpPTjNTLZlyUi3Lu/SmIqpWXL1pvXjUvjay7n+evNXhIhK2akSmP5GV4C7LWwuAyJff2wVmA/3l/KuFre7Pt84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nkM9TRHu; arc=fail smtp.client-ip=40.107.249.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nkM9TRHu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hkfmXzxWl1y0Qeg8hnL5Hc79FOMYL/pofutsH2oEJ52t7OzujiwTdZ4Mj1B9XIbtRNhzdtrAJ3e72dH/sJhuSgxB4tUXUh+TRn9nqL3DJ9KIfrGuqnKzu7mkI8hf3hs/uMZXuRWjiURaB8UHwg0wp5OQILk5anMmBaD+b9QJb4s7RBbjANn2aclEQN/cwMuDQOu3PZsjM93gscaO0MXCplEWjoS+UlE9+HqsR7Jc8q4o1raMyOaMp9BB4Fww6nliBWDLlG8dFjXjNQfBqk1NVTJSz/HsbXfMX/rCdcpDtd+5tSRmy1jvVh8NdW9suWw27pNLzRm6B8FYq8pf7KlL3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsyLwfC+Q3+2hbbb9+usbP9q0/p/jRB7aqpQr29YvC8=;
 b=vO29zZwsA2/8WjZwsWQav1WBZcqabv0oCbcDhRyJk2itZrnb3LYfrg9T2XFfEFVvd3ThXZYWiOtxfp3uCeraw1NndRgkLxH2WUhE2HypxjnzeKuMmESYe2DNsfNHscJyEPywnW2GlWiNl6xHu9hWtSI8HXVvFGQIQg3R3sibXzsXUKzpIe5W8ih6zaNS5GFvy16vkl7JWLFO50VOJxv4C9IDVRb+p0IZKfS59CiYayzBHtVm2zM2/AXHRXEnggWgEFDwwEzcPI/wS2RT5n9YRjTdiiEb6hP0d3POZ9XAAXF+pAC9J0ctd3fe78sw82M3g1DGVYl0XNYuw+4Bj+7HtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsyLwfC+Q3+2hbbb9+usbP9q0/p/jRB7aqpQr29YvC8=;
 b=nkM9TRHuJgC+t7DiTT4RvAV2zZ4dDagPtoob9Xs8E1zuhUAy+HlHqaEJT3t6QEoyhzgbfC9heGG+iUKiRvxDwSsm11utvB7qeIV2vKmGsqtdM+XCZEltB5ZbQoIMjWOh7xGbktk/NNYKCairkduv5T8ZkATu8q94ebtMLU/u309l7risHrEqiDjKLVrTEOGnT3+NyVMZWaNRpBl3hiJTW1CGAu7BWqQuYjP9Cf0vjwvWvOZBRvZNrLnHUeVdWrfMbiJ6sQuWPqv6lnuWExfUi79QuL24OyaHnWXepWrQxjNBC6sefUayFMd9i9mLPPvbebp+8LjVM4NIyGuP6q1OiA==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AM9PR04MB8794.eurprd04.prod.outlook.com (2603:10a6:20b:409::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 01:39:03 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%7]) with mapi id 15.20.8093.024; Thu, 31 Oct 2024
 01:39:02 +0000
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
Subject: RE: [PATCH v2 1/2] mmc: host: sdhci-esdhc-imx: implement emmc
 hardware reset
Thread-Topic: [PATCH v2 1/2] mmc: host: sdhci-esdhc-imx: implement emmc
 hardware reset
Thread-Index: AQHbKtDtcgszgIY87ESxeapb9u4RHbKgFIaA
Date: Thu, 31 Oct 2024 01:39:02 +0000
Message-ID:
 <DU0PR04MB94960B8DC51D38061FAE880D90552@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20241030-imx-emmc-reset-v2-0-b3a823393974@solid-run.com>
 <20241030-imx-emmc-reset-v2-1-b3a823393974@solid-run.com>
In-Reply-To: <20241030-imx-emmc-reset-v2-1-b3a823393974@solid-run.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|AM9PR04MB8794:EE_
x-ms-office365-filtering-correlation-id: 843a0866-d585-417b-e763-08dcf94cccba
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZEFZN1dURTBRZ1h4K2FFTjdNUE4rOUlEVENFeWFoOXphQ0UzN2FxL0dJWG42?=
 =?utf-8?B?cXFqWENldFcyMmYzV3B2L1FRYUNzVjRGbEF2NEV1Ti9ZTUI4UURXeFRhdkgv?=
 =?utf-8?B?L1l1S2FWd2JYNDFtQkVvMnAzaDY1ZU5IL09HbnZsdFNBYlpYZ2UrQVdnYmdI?=
 =?utf-8?B?YWlmWFRxSUdGSitqTUxZejFRdEdTODVhbCtOVGRENjl2bG5yaVR4YnN1UlF0?=
 =?utf-8?B?V09XWDluZlJSek9zakE1cWtuTWpDNFI0WmpzMlFnR3ViWlVhLzQ5N3B2SURL?=
 =?utf-8?B?bCtETkFVMHVlZnJmR0x0Vmh6VlBQVzRtVDBMdWpYbFJPWHZuWmJtN0NxYmdW?=
 =?utf-8?B?MVNaOWpTMUEydjRqbHgyaXhzdUJmc0M5Z1dlUm5JR2NndVNJb2FGeldyVWxC?=
 =?utf-8?B?UU9UaW1HbU5KaUNRWkJ5bURoWWZpejZxbXdCaFU5dng0UTczRFpCY253R3dO?=
 =?utf-8?B?MFZncVZnc0VkdDdWTmx3cVFqRjc5Q2pycW5CWWhDbkZyQUp6L21NTUdHY0gy?=
 =?utf-8?B?K1N3SktKWkowNm1scHV3cVlRajhXVEoyK1hlcUlEdEUxMjZzZkJmSnF6Z1Uy?=
 =?utf-8?B?SFpMZ1RqYlQvRHI4U3F2K0lQWmIxZmRvMk1lQ3loZnFQTlFKRkVpQ2NrMXdq?=
 =?utf-8?B?N0NNTWpOdldYZWhLQkpmTlNpZXRrVWRHdkF6eVIzZkxVYlNoeGxLMjN0TXFR?=
 =?utf-8?B?RGVwZllpRWlna1V6dHZVTGdRRjRBWWgwR1NJckEvelhzL2dhOEhJSzh3T3k4?=
 =?utf-8?B?NVozYUFlYURraldkbzFiMXA5YXdlTEFVVUI3MmNFVjNQc3dnK0Rzd25BMFNn?=
 =?utf-8?B?SGpxdVJnSlhmdEZQOXcrNFlObjZOY3A2SWhWVFllRUpBc2VLdnVZYVpNMURn?=
 =?utf-8?B?UWJvZTZWQm1WK2lHd0prNXJNS0JzTUprbzJLK2NaSldSRVFlZ25vUlE3cSs2?=
 =?utf-8?B?U1FzclU5U1Z4MElaajI2dk03NDBnZkNZc1podVVZOW9QOHh4S3VxQUJsTlVU?=
 =?utf-8?B?dWVvVHV2MFkxZ1NFcTJneS8zZ0p6Q3N0dHpCU0gyQUZubnNPWGRmRmJqT3FS?=
 =?utf-8?B?VW1MMlRQYk5rR1hYQ0FVN2NZU0dacGxXMnBEdXlzRzVDSDc0S2d2dE5ENFkr?=
 =?utf-8?B?cWcrdjZBQjU5V01sKzNlRTBOZjAwSWRWSGh4V3p2alBlVFRaUVRyOVBQMnFI?=
 =?utf-8?B?NkFRYnpoZ2I5dUpzVGlpdHowS1JCeEVTOTlHTEJGRk9iUWxyNm1oOVJhQWdV?=
 =?utf-8?B?aVF4WGhXTS9PSTNYVGl2ZkoreTV3MnUzNEFCbmtvdHltYkVhMURXZFVxQU9l?=
 =?utf-8?B?c3JZUGs3dHM0aitxdU14OWRyWGowYU1DczJYY25VOG5CZDhTNXJ3S242R0ds?=
 =?utf-8?B?ZGNEM0xCRmsySFlLcVk5QUNwaVlvWHlZVnR1bENmcVhKTmRsTTNmK3VKeDQ3?=
 =?utf-8?B?ZXo2VHhIWWVvOU1yVTE4c2xUNTJCZU9Ua2MzN05KaVlNS05ZK1lzdWl6Mk9V?=
 =?utf-8?B?RGpkMmxneThoSmtMN25iOENUR0RtVFNSako1OG5TWEJXQVNXWjc4U3BVa2ht?=
 =?utf-8?B?YTJRR2E4SDM2K0dzNno2ZFZOTmtBZ2NJbVFvdkRXdGFlT014UllNblRqVmh2?=
 =?utf-8?B?T25IZFBzNnlwU0VjUC8zSUNOM1FlUFl5cjdXRDdlaUpQaGNrd01ZVXhNRENw?=
 =?utf-8?B?a1BIUkM2M3k3U2I0TWVxYjB2cDNRSmttT3pTc2VwUE5Jbi91SnlrWFo3QjYy?=
 =?utf-8?B?WW44Nlc5N3FqeDhQRVNrRitUQkM1MUliZ1NkTlVKalVDVmNjckxtcHRVM3hH?=
 =?utf-8?Q?d7A5aVoFGf9GI7w3rxjapJy9iEeJrY9cpMQ1k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NnBEVFJXcE9sTVZpbXRmZ243RlJ2S1RXL094bTlpdFRZbjIvQ3FaNTZMUEFh?=
 =?utf-8?B?ajd0eHhWQ1FFUWh4WmNjbG5EVXNTNUFLYmxKTUhZN3dpb1ExeDE4UEdKRlBW?=
 =?utf-8?B?WUxyQmhOS0tCNEZ3d2tzcm1xK2FxYlVQTE1rWDJ3MnF4bFhDQ3ZVVTZoY2ND?=
 =?utf-8?B?UmtaeDQ1YmQvNTJQQ0loQm5BYnc0S210Zk5KajVvRVUzeWZRRXU1aUgrM3lZ?=
 =?utf-8?B?SmdXSUhuV2JjTC85TWIxdlk0akRkYzMreUg3aW5KNGpMaEU4WDlzdmRhT3R0?=
 =?utf-8?B?dGREVlFhUDlNSWREV25kMlMrbWV4ZWFVRjdNbmpPSXR4VUZtbE1XdGF3bHN0?=
 =?utf-8?B?Um5OWmVHd3FFRUoxc3FhL1RKNzY1L21Odi9GUHpadXZnaml0VkpZcTdFT0l4?=
 =?utf-8?B?a2kyUnY3NlBiWjRINVVYTFBjcmpzRC9jSzNrVTRlejJ4TEd4UHViZEU1ckNp?=
 =?utf-8?B?SzlpVzJEYjdkVmtOR2docWRIUFNERER2ekpkeHNZejgxVGJldXRVMVI3QmRl?=
 =?utf-8?B?SDRMZUI2Ym1ic2ZNMGhsK1pCR0NmS2JGWHpHOG56T3Z5ZTh4UFMyRndIeHov?=
 =?utf-8?B?R2FyYkdpd1RrNFNLVy84T3lyUGN3ZkZmMFRRZmJ3Mll1Z3NnT1ZMcTZxRWtB?=
 =?utf-8?B?U3VwMXJLZ1B0L2FnNUVFZ0l2enlIbm02a1FnN0E5SWVKNXdtU3ZUaWRwTnJE?=
 =?utf-8?B?YitBSzMyVytUVHYrRk5BS0dKbjRSZmhFc3VKR3ZpT0g4UHBlZi83SGJWVE41?=
 =?utf-8?B?bnpFTWZZN0c4RGpnTGtmbDJWeEtuYmpRdHl6Yzg5VkVlYXBBYW1GUStRemxP?=
 =?utf-8?B?azJlSms2ZHRKa0p0ZENSWFN6c0dkTWZ3VFkyOHBGSEtGRENXYU9DV1RMbG5s?=
 =?utf-8?B?V294OGlRRkpaOU5OaWdabTUwT1ZocGd3ZDB4VGFiTXZCMmtCbUhsNjlYMW1w?=
 =?utf-8?B?YlBjaGJUbEYrM3VDdFBoaEFUN21pZ3A5YzM3dDQxMUx1b1VCbzFxMURRTllB?=
 =?utf-8?B?ZlVxeFVuTjgrVjZGbDg3bE1pVVUvb281clIreXp2NS9uUnA3Z24wYVJWTTNT?=
 =?utf-8?B?OGUwRlVHT2JMWmU3N0VVaUFuTmlYendTSGpIUGFCOG5SdnRKK2lZYWNDZytr?=
 =?utf-8?B?dVRrRWFJRjVhTVlFa1Ztd3M5aTZwa3ErekZFR1BmVkF4V3BlNy9iWUJ2bUN0?=
 =?utf-8?B?K0NTejh1Q3FyNzhycmRXQUVtdVlpQ2FVbUY2VVlPb0xPc2xDWEF3b2x6WWFV?=
 =?utf-8?B?dFdsczlkWHdmNjdzb0daZHZxT1JJdmR3T0NmM1E2TFhvamlEQjcyRGpKcGhq?=
 =?utf-8?B?S2VVWERYKzM1M0huZFFGZmd0dFZDNXo1cHBNRHlta3NzeEVxdDlvMEFkdERu?=
 =?utf-8?B?dlRhOUo3VElUeU1tNE5Oem5yV3pWWVQ2dTdQTTJKbEx4d1MzMHFWL2UvRnho?=
 =?utf-8?B?TGEzOWRpVUFWTmRIM3pzZVl5Zk45aHd4T0ZMNFkyZ09xMXhOemcyQXYyM1Bl?=
 =?utf-8?B?emhKMUk4bnVxdHBwZ3lQRkQ3VUV6ZzVmYlI4eXZyMFdoRzFzWDZ0Znp2cDgv?=
 =?utf-8?B?bHhGSUppTjBLbHVMYUdZRmMycEczd2Z0OC9td242bzc3cnp3VDIzdnA1WWhB?=
 =?utf-8?B?UXpiMUs3ZERpenVGeEZTdkk5V1piSlRURnFSMjN4L3NKdzdWRkw0VmNqZHBP?=
 =?utf-8?B?dzhqZ0JFRDFzTVdKS2F3ZDlrWW5PdkQ0emdVOWVYQUJZK2RaQ3FWZDVWY3Jq?=
 =?utf-8?B?ZFlpb24zbU9CSnV1U2paOGtldm1wY3ZtZ1cvclg0UWdVT2xIQm4vaks5K3Vi?=
 =?utf-8?B?cFJpeGI3bWl0Nkh3WjNJblhEbFZZOGl4c0ZObWF3LzllTDZ5WWxXd3kvT2pL?=
 =?utf-8?B?di9tVm5RUldYSnA3WEJWY0t1UkRXYStiZjdwUDladUtCMEZwMi9vbmoxZ0lX?=
 =?utf-8?B?MlNRbFZmQTVNRjkzdlNBN3daaW1lOU1IanRMSSsxYmNQMm5ka01FWmRjMUZP?=
 =?utf-8?B?OG1iazZLTHN0NlprNG80MnQ1dkRtdFk4U2xPQWdKVWQzQ0hLVFJDQ3BKWW1Q?=
 =?utf-8?B?QkJIZ0JzOEZPYm0vd3IzR2R0aGkyOVRpTDh1NnlaaXBmWkkzQnB1ZlVmRzYr?=
 =?utf-8?Q?tNUI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 843a0866-d585-417b-e763-08dcf94cccba
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 01:39:02.6868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iu91RQbmQ5DkyhcwgFKOEdz/CgcsAsECpuyYrQj6+uprvAxyfYxLybJLzAMNPDI6Mu5OhQc1oUuwSeCWL+MjSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8794

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb3N1YSBNYXllciA8am9zdWFA
c29saWQtcnVuLmNvbT4NCj4gU2VudDogMjAyNOW5tDEw5pyIMzDml6UgMjE6MzgNCj4gVG86IEFk
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
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEpvc3VhDQo+IE1heWVyIDxqb3N1YUBzb2xpZC1y
dW4uY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjIgMS8yXSBtbWM6IGhvc3Q6IHNkaGNpLWVzZGhj
LWlteDogaW1wbGVtZW50IGVtbWMNCj4gaGFyZHdhcmUgcmVzZXQNCj4gDQo+IE5YUCBFU0RIQyBz
dXBwb3J0cyBjb250cm9sIG9mIG5hdGl2ZSBlbW1jIHJlc2V0IHNpZ25hbCB3aGVuIHBpbm11eCBp
cyBzZXQNCj4gYWNjb3JkaW5nbHksIHVzaW5nIHVTREhDeF9TWVNfQ1RSTCByZWdpc3RlciBJUFBf
UlNUX04gYml0Lg0KPiBEb2N1bWVudGF0aW9uIGlzIGF2YWlsYWJsZSBpbiBOWFAgaS5NWDZRIFJl
ZmVyZW5jZSBNYW51YWwuDQo+IA0KPiBJbXBsZW1lbnQgdGhlIGh3X3Jlc2V0IGZ1bmN0aW9uIGlu
IHNkaGNpX29wcyBhc3NlcnRpbmcgcmVzZXQgZm9yIGF0IGxlYXN0IDF1cw0KPiBhbmQgd2FpdGlu
ZyBhdCBsZWFzdCAyMDB1cyBhZnRlciBkZWFzc2VydGlvbi4NCj4gTG93ZXIgYm91bmRzIGFyZSBi
YXNlZCBvbjoNCj4gSkVERUMgU3RhbmRhcmQgTm8uIDg0LUI1MSwgNi4xNS4xMCBIL1cgUmVzZXQg
T3BlcmF0aW9uLCBwYWdlIDE1OS4NCj4gVXBwZXIgYm91bmRzIGFyZSBjaG9zZW4gYWxsb3dpbmcg
ZmxleGliaWxpdHkgdG8gdGhlIHNjaGVkdWxlci4NCj4gDQo+IFRlc3RlZCBvbiBTb2xpZFJ1biBp
Lk1YOERYTCBTb00gd2l0aCBhIHNjb3BlLCBhbmQgY29uZmlybWVkIHRoYXQgZU1NQyBpcw0KPiBz
dGlsbCBhY2Nlc3NpYmxlIGFmdGVyIGJvb3Q6DQo+IC0gZU1NQyBleHRjc2QgaGFzIFJTVF9OX0ZV
TkNUSU9OPTB4MDENCj4gLSBzZGhjIG5vZGUgaGFzIGNhcC1tbWMtaHctcmVzZXQNCj4gLSBwaW5t
dXggc2V0IGZvciBFTU1DMF9SRVNFVF9CDQo+IC0gTGludXggdjUuMTUNCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEpvc3VhIE1heWVyIDxqb3N1YUBzb2xpZC1ydW4uY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMgfCAxNCArKysrKysrKysrKysrKw0KPiAgMSBm
aWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1l
c2RoYy1pbXguYw0KPiBpbmRleA0KPiA4ZjBiYzZkY2EyYjA0MDJmZDJhMDY5NTkwM2NmMjYxYTVi
NGUxOWRjLi5hODMwZDlhOTQ5MDQwOGQzMTQ4YjkyN2JmDQo+IDFhY2M3MTlhMTNlODk3NSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiArKysgYi9k
cml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+IEBAIC0zMyw2ICszMyw4IEBADQo+
ICAjZGVmaW5lIEVTREhDX1NZU19DVFJMX0RUT0NWX01BU0sJMHgwZg0KPiAgI2RlZmluZQlFU0RI
Q19DVFJMX0QzQ0QJCQkweDA4DQo+ICAjZGVmaW5lIEVTREhDX0JVUlNUX0xFTl9FTl9JTkNSCQko
MSA8PCAyNykNCj4gKyNkZWZpbmUgRVNESENfU1lTX0NUUkwJCQkweDJjDQoNCk5vIG5lZWQgdGhp
cyBkZWZpbml0aW9uLCBhbHJlYWR5IGRvbmUgaW4gZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2Ro
Yy5oDQoNCiNkZWZpbmUgRVNESENfU1lTVEVNX0NPTlRST0wgICAgICAgICAgICAweDJjDQoNClJl
Z2FyZHMNCkhhaWJvIENoZW4NCg0KDQo+ICsjZGVmaW5lIEVTREhDX1NZU19DVFJMX0lQUF9SU1Rf
TglCSVQoMjMpDQo+ICAvKiBWRU5ET1IgU1BFQyByZWdpc3RlciAqLw0KPiAgI2RlZmluZSBFU0RI
Q19WRU5ET1JfU1BFQwkJMHhjMA0KPiAgI2RlZmluZSAgRVNESENfVkVORE9SX1NQRUNfU0RJT19R
VUlSSwkoMSA8PCAxKQ0KPiBAQCAtMTQwMiw2ICsxNDA0LDE3IEBAIHN0YXRpYyB1MzIgZXNkaGNf
Y3FoY2lfaXJxKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LA0KPiB1MzIgaW50bWFzaykNCj4gIAly
ZXR1cm4gMDsNCj4gIH0NCj4gDQo+ICtzdGF0aWMgdm9pZCBlc2RoY19od19yZXNldChzdHJ1Y3Qg
c2RoY2lfaG9zdCAqaG9zdCkgew0KPiArCWVzZGhjX2NscnNldF9sZShob3N0LCBFU0RIQ19TWVNf
Q1RSTF9JUFBfUlNUX04sIDAsIEVTREhDX1NZU19DVFJMKTsNCj4gKwkvKiBlTU1DIHNwZWMgcmVx
dWlyZXMgbWluaW11bSAxdXMsIGhlcmUgZGVsYXkgYmV0d2VlbiAxLTEwdXMgKi8NCj4gKwl1c2xl
ZXBfcmFuZ2UoMSwgMTApOw0KPiArCWVzZGhjX2NscnNldF9sZShob3N0LCBFU0RIQ19TWVNfQ1RS
TF9JUFBfUlNUX04sDQo+ICsJCQlFU0RIQ19TWVNfQ1RSTF9JUFBfUlNUX04sIEVTREhDX1NZU19D
VFJMKTsNCj4gKwkvKiBlTU1DIHNwZWMgcmVxdWlyZXMgbWluaW11bSAyMDB1cywgaGVyZSBkZWxh
eSBiZXR3ZWVuIDIwMC0zMDB1cyAqLw0KPiArCXVzbGVlcF9yYW5nZSgyMDAsIDMwMCk7DQo+ICt9
DQo+ICsNCj4gIHN0YXRpYyBzdHJ1Y3Qgc2RoY2lfb3BzIHNkaGNpX2VzZGhjX29wcyA9IHsNCj4g
IAkucmVhZF9sID0gZXNkaGNfcmVhZGxfbGUsDQo+ICAJLnJlYWRfdyA9IGVzZGhjX3JlYWR3X2xl
LA0KPiBAQCAtMTQyMCw2ICsxNDMzLDcgQEAgc3RhdGljIHN0cnVjdCBzZGhjaV9vcHMgc2RoY2lf
ZXNkaGNfb3BzID0gew0KPiAgCS5yZXNldCA9IGVzZGhjX3Jlc2V0LA0KPiAgCS5pcnEgPSBlc2Ro
Y19jcWhjaV9pcnEsDQo+ICAJLmR1bXBfdmVuZG9yX3JlZ3MgPSBlc2RoY19kdW1wX2RlYnVnX3Jl
Z3MsDQo+ICsJLmh3X3Jlc2V0ID0gZXNkaGNfaHdfcmVzZXQsDQo+ICB9Ow0KPiANCj4gIHN0YXRp
YyBjb25zdCBzdHJ1Y3Qgc2RoY2lfcGx0Zm1fZGF0YSBzZGhjaV9lc2RoY19pbXhfcGRhdGEgPSB7
DQo+IA0KPiAtLQ0KPiAyLjQzLjANCg0K
