Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012005.outbound.protection.outlook.com [52.101.66.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B484D205E25;
	Wed, 10 Dec 2025 11:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765365498; cv=fail; b=Rbuc5B4AXpqE3a5Uq5PITVxDbsr/bz1u+epJMZPdQ/fy9WDJH8ZyBciMhU+gLhJadpuy38c2ehM1neP3oWEpuWUqCHbY0IHp1+FnDGkMvDTUxNdz9nH7uZCJ+6UfbhPTzBWgL+NAhxHKyrF8krkCyQdJ/VT+5bLA/jZeBxHU0WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765365498; c=relaxed/simple;
	bh=jnY9yet94s8LwkkqaR4LrhXiTqm4W4WtDCcU63oE3tw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jygqdrg/SbqVJkAO4iy8lLVsh4ZYkUTLDvDKSoXgeMer2ZKzfSC6U4tB2X3EyhOF8f7JFlevc5YTKnAJkiZ+J1sspbk+kzIkA7tV3uyLyWXcbbS2A4Ni8eQQoUtMa1OMssDJWEE3cSCFox22JjIkAry/cT4R0aim7dpk0uCfCdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G5N99nvC; arc=fail smtp.client-ip=52.101.66.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G5N99nvC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3h9VWRbPZsYZ9bQSGsizWJEHQxWEc9fAg9TgOEPS+o8CuqSCfHXMrL1JQUcyupXq8rXuRRC2qCtlJd/6Cs2LrBQ2DyZFxp4sAdZKhzZLOOG+kQ5nTnpvv53w6Ujz6t/6z8zoFX4EbyEsW49lQZ+PywfXXjfph8bSaOOlrMessRd8MvN7GlpZ2gG6NEVf59LjEIP/us9unRfxZI49VBX6MUXXkHyOosh45Rz06lZaZPp5OxbVVaxJcQpiZKLcACqL0D+nIkDSdYgwcBpNiho5ItcP0WedtMwOOnCWN5qchftraxaSdLm8gdT5HAbTaUVxXq+mHw1LLCO6vYVqVmCvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnY9yet94s8LwkkqaR4LrhXiTqm4W4WtDCcU63oE3tw=;
 b=InTXTy1rO5YJEULTMpSa7EIJcME7sdiM+tQxAPV+kh6fSVJtIPHIwGBCxrh1pncjUhA37RYUQMgRsHBfC9Oq3dbch5C8gj1X3KIykDGaSD+B6LGrfaemomkk8aljYfTax2RAFG/XGH1xrJQYpFLb2YORdgDNN6QJT/veeDTU0xO/gjd1+Sd688H2dxJdPjkxRgMl4IlY7y3txVegT6qnsT7lNjt4fOHcg+Dvq27HeWH1QJencJn+i2N/NapGxgf+55X/iVsDgfMF8dG5Y9qLDj6C/jwqRX9hliLLRz+EklLpxAe3f8CN2oqG8mJ3AOiqu4TlJQGOgdnnStR2XqSpkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnY9yet94s8LwkkqaR4LrhXiTqm4W4WtDCcU63oE3tw=;
 b=G5N99nvCum6JjvuOHJ9eI7vYMzvULyMBwx9/XMLBWXwAbC2niqEbfCXSc7yfaZvmvlxKtSQUpF6FsBaomVVu6qSkF0dSz/jIOycKZaz37/3S2f9szvAnLHyiNbazvIO23nHrGufpVYVKeTvG9GtSVVHw3R8AIV7QR2rqSteXFScD+RKc0FmCK8+s//B1tI+IPq6bwTNm/dtNymNc/4I6AzaVKTZhRzbzVrTtIiPD/w4A5pHBcgnrdJUXDqNYuW7ccGUTfUzrfEX+IdsKscHSc6QRc29FZgtxDJHMMsA2KrfLr7LzezxwwVWvbDG9XBJIic5yyBLBnmjo3C+VHH6WJQ==
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by VI0PR04MB11889.eurprd04.prod.outlook.com (2603:10a6:800:305::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Wed, 10 Dec
 2025 11:18:07 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%2]) with mapi id 15.20.9388.013; Wed, 10 Dec 2025
 11:18:07 +0000
From: Luke Wang <ziniu.wang_1@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Bough Chen <haibo.chen@nxp.com>
CC: "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	dl-S32 <S32@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v2] mmc: sdhci-esdhc-imx: wait for data transfer
 completion before reset
Thread-Topic: [EXT] Re: [PATCH v2] mmc: sdhci-esdhc-imx: wait for data
 transfer completion before reset
Thread-Index: AQHcZbb3dDQ/KGlRS0mE1SVoohrU5bUSskkAgAanAgCAAWNmgA==
Date: Wed, 10 Dec 2025 11:18:06 +0000
Message-ID:
 <DU2PR04MB8567DB3B818280EED81A36B2EDA0A@DU2PR04MB8567.eurprd04.prod.outlook.com>
References: <20251205071729.83857-1-ziniu.wang_1@nxp.com>
 <DU0PR04MB94962D103B1A92354CDD1FE690A7A@DU0PR04MB9496.eurprd04.prod.outlook.com>
 <CAPDyKFpYU3PZs-dSREyGyyyoptY0zCQmHP+mxMMgvYQL-xXQZA@mail.gmail.com>
In-Reply-To:
 <CAPDyKFpYU3PZs-dSREyGyyyoptY0zCQmHP+mxMMgvYQL-xXQZA@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8567:EE_|VI0PR04MB11889:EE_
x-ms-office365-filtering-correlation-id: 3264934f-9a0f-46b5-ef6a-08de37ddcba1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|19092799006|366016|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Qm1NdGRxMmx1WiswVW0vTDhzNnBtdGNwTW1xbk9RY0Z3Y0FtWDJua21YS3Np?=
 =?utf-8?B?TlZDRFN3VkkxNlpVOWtWYThjOHQ0ZTJlR05lL1V5dEZKQXVxck5ObHNCMTV0?=
 =?utf-8?B?R240cEgzNXRabEg5a0gvZ2d4eThDcVV0ak10cklOeFM5QjBhaExtVXZvaVVO?=
 =?utf-8?B?QmhzcnREWWJVWVhCM2tMTmRqN1lyZ3NyZEwzV2dFRG9xRkEwbElET1VJQ3J1?=
 =?utf-8?B?eXMrblp5aldvb3V2ajg2M0MrNUp4WkpBbzZ1WHVwSmJIVnp2Q004b0EwczN5?=
 =?utf-8?B?L2dHQmkzdTBnYTR1QkNZaEZpMGVvLzZKZmd6b2RKNDJvRjZid1J6MlVjNzcz?=
 =?utf-8?B?ZHlTTTQwOWxNN2VGSnNwaHoxd256YmZBMDBYcm1qZWxtcWYzSHZ1NXJwb0ls?=
 =?utf-8?B?cjZWSHZDbVV5S1JraUxXTUhsSXNydFRQcmdncDFyRUxPYVp6aHNYRXZXMFdY?=
 =?utf-8?B?UTR2VVNmK29kMVFURG50cjJRV2Q1TG9OWHMwUTFBZ2cweUtDZHk0bXJZSCth?=
 =?utf-8?B?dVcvZ3hXS2lheTRndVpOTDc1M1hnTy80cE5wQmZYNExBdml5QXgxTDRnNmww?=
 =?utf-8?B?bE84cFk1NWlWUUcrNC9WNnhpaTRMK0dEb2p2MmR6ZjBsa1lGS0RLc3ZCUHJJ?=
 =?utf-8?B?VjdJUHhmRmV2b0NMSEQ1Z2ZMZnMreVo2Nk8reUw0V3I2aUlPRWIwYmlNdXEv?=
 =?utf-8?B?WmdSdC8ycGdPcUo5M0hhWm5UR2tzQ1dsVXNibWNwTWllRDlQNUoyZ3BkWWZL?=
 =?utf-8?B?eUk2YnQrZDllakFtMXlPMFZrTDd0TFNRUVlmTDI4NkV3VzJQVFVidkM2VUVP?=
 =?utf-8?B?UTlWS0Zhb0wzOUMyekN1dzdLeTRBbnBMMWZqcmpRWVdPdFhSUUNldFVKSTdQ?=
 =?utf-8?B?VlcvOW1oREc5WklLZnlyTmhybTI5R1ZIQVdzOEgyTFJIeU5KK2FZZlFNOEk3?=
 =?utf-8?B?UHYxZGwrRENMb0FpRm5WLzNmRzRvVmFtRVNZeXhxRGtvNVExblFaUUdDSWVH?=
 =?utf-8?B?MHk1Z1h2MlVVdGlTVHZicFE5WUtpRTRON09qL2F3WHRoaEFhTCtnVWExZjVw?=
 =?utf-8?B?QTIyMWFQNkEzdVdiNjZtK09kb3haVlZ3Y3JWTWQyRzY5N0hpejk4N1cybDFF?=
 =?utf-8?B?MUJVTEtCYktGSVZIRGNBL1owK3QvV1NBSHFBRDQ2c3k4MENMWEY5M3lpcFJj?=
 =?utf-8?B?bnh1RmNLVFo4WjIyQitQTHlQZGw1bXlRUFhPcVY3cktSZTMrdlNRSGtTTDEw?=
 =?utf-8?B?U2lzbmN3WjJRMTgwUU11blZEYTY0MUNsb3ZkN0JsREs4RG1aMWVqR2sxZ1Rl?=
 =?utf-8?B?UzJoMWhiWEpuOStGdUZneldOVkl1b2lHZlhrOG5XSVdmWS85UmJjVnJNRnV1?=
 =?utf-8?B?UXhZc1J6WXc4Q3E1VTlIOEdtS0w3R24yNGI0L3o4Ynk1MENpdjJ0V2RNU0xh?=
 =?utf-8?B?UVYxU3Iza3BFWWQrN0ROcldROXEvOUVibk92VFVVTDVCMlpPREdERTlVZHpF?=
 =?utf-8?B?Q2xiSDBzS2lsRU5zZDFONW13RkJJUkZSdXlsd1ZBYW9sYTVrcUV5MzdUdW4z?=
 =?utf-8?B?anZpdXlJMUlqdTM1VWdLdnlLZjk5NkdldjBwbEtQNHE1THBBQW81cUhsQWFK?=
 =?utf-8?B?YTlKSmN5TGlvNGxjMmJ5N2NYZTlySjlLaEZSaG4rckIwdUZOVTkyc1pUTGNw?=
 =?utf-8?B?QWMvSi9NQkkzbkw1QU9JT2Rhek5XVjdNUDlvb2l0dmg5am8yUEV5ai9KOUhs?=
 =?utf-8?B?K3FldzhpT1dOSmo5NEtnYTF5KzZBVzNML3huRXlES3IxYUUxRXNPSTNxUy9N?=
 =?utf-8?B?YTdvQjVaais4Z29kTHZ3Qk5MWStjNFlidzkvZTg2Vkc0NGUxSDNEYTA3Q2pR?=
 =?utf-8?B?YTdvMVpGREZieTNGZE44RVBLVnpXemZlWGlHN2NHMzd6S3ZrUThPMW1hT0xP?=
 =?utf-8?B?azlqK0djbm53UGlzTk0yaGtZNjIrbThDUXJDTldBZ1dldk5YSFZtcW5MSXQ0?=
 =?utf-8?B?QjBnR0NaZmZGSEFRTmNHUjJIQ2wxdWFIRnE1SE0yU1l3dTlYa2txMXRkdUVs?=
 =?utf-8?Q?T8beTq?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(19092799006)(366016)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NkVMazlvQWd5aHdUWno3dURvNmw4T1JzR0Jta0F6MnlWS3RDUDBpL1E0eUlt?=
 =?utf-8?B?YVh3SnBpaTB1RUQxZGc5YjByS1BUa3Fka1QwSnB2UDc0cVZPQVJwcWJxcWw4?=
 =?utf-8?B?MmxyaTNBSTl5ZmtMb2UvYXh5RnE5elh3WVpDUkZIdTNLTVdleTJUelVPRE5S?=
 =?utf-8?B?cFdKV0lQcGthd3NDOVZkL1l3V0VIMjE2SXFvSUpJNmpYK3dnWEdWZHZJSm9M?=
 =?utf-8?B?aXJZcGxYUy8xbjYybHV3VS9EZS84eGtyZy9ZbjFYY2NqVTVFbXA0WGJyc3RC?=
 =?utf-8?B?WkpycGFFY2lvN0V1dEVjRyt1cUFHYVNSRnNIejRmSUh6OW5SblJONmtrMDJu?=
 =?utf-8?B?ZDFZdFVkSmhTMVVzZ2NQV3FEQmFCTy9pWHkvUUF4bDlqdWFxTHAzNnF1c1Jw?=
 =?utf-8?B?OEc0M0VsZXQxdmZNZ3FnaGpSRWc0WUxkK0NLWTQ5SU5YMXNmWWRVUWk3UHhC?=
 =?utf-8?B?aUczSjBjQ2RSQXQ2cTVKM1NRNGhySC9HRCtERTNmOWhJODZXUFZJTzB5LzV2?=
 =?utf-8?B?ejZlNHVNYzEzUVc5M2RzeGVzUXFaTlo2NzMrQlF0bld3WWwvS3ZBdkZOdFdu?=
 =?utf-8?B?MTBQUHBqR3RBbEVpK0Q2eFZmcFk4eTJVMjl2dzJzS0V4OHdxZU1ncEdHdE92?=
 =?utf-8?B?NzFTQXJSTmVKTWN1UkkyVE9nQWJTaVFiK1Z1UzdWL1F5U010VXZrQ2VRQ05P?=
 =?utf-8?B?c2FPSVU2UWpJNlE2dG1vclg5dFlIcW4zUnhua2JRS2s3U3pjK1JsR0ZBc1dx?=
 =?utf-8?B?UHBFaTR2NW5NbG1Nems2UUR5dnFhRFRTdnp0bnpTOGFnWklRVHA3WElnTDZO?=
 =?utf-8?B?aVVtTGlzZEFWRmswV3g0RENKRExBeTJuTE1WOHI4WFhSelZ6YjFQMmdKN2Uw?=
 =?utf-8?B?SnRsdmlDblUyd2l2QW1hODVKMkU0KytETktSaUFtamxLT2VlWkxNQWJpLys4?=
 =?utf-8?B?YUJQbEFSMEc0Q2EweXhwTGpuSldlQnhEcVJKYnhOb2YyL2U4L3pMWlVHL2FG?=
 =?utf-8?B?SUViaS9naG0zOU9EU3BKd1hYb0t6ZEVkY3VaVTlhVnBjdmc0YmtoMUVsYnNJ?=
 =?utf-8?B?MWdiam1LVjhZcmRzVnNiWHFhYnhzRmdCK2VWdjhjWWFKSnVtdlBJVWhPNGt2?=
 =?utf-8?B?eHN6WkpPaVJEOUR5MkxDR0doS3gzUnZvanlCeTZYbWVIVnpBSFAxQ1p2eXZL?=
 =?utf-8?B?dmlkdlg4cE1wK2RYeHhhRTRjcEU0ZUFUY0dMeDdIcDVvWmVDdFB0TzQzY3k0?=
 =?utf-8?B?K0JTazdGME9xb1E3Y2JFSlphYjE3WnBwWmJRR2Z3cmZEa21EcStsWW9yZjdO?=
 =?utf-8?B?MUNlUXdHeCtzdzZXV3hBYWkvdnNUYVFnU0d1YUxROGJuOEovMlpnQWl0MlVx?=
 =?utf-8?B?cWZqZ1FGNUpDdjMzUVMrVSthZ0pIWlZoekttaCtlQlF2UHlvWU1nL1R6VXJD?=
 =?utf-8?B?SDEwNlFLODhOTDRFZTVpdGtBUVhYd2tZQ1VtaVpHSDhWVkVNTllPQW10QVRt?=
 =?utf-8?B?cXI4bldWdHF5QUdWeVp6WkYwTXVoREVlUm8xMC9NT2tPRjFTWXdHbTRQTFp1?=
 =?utf-8?B?a2RLYjVodHcrYll2LzBUTFBBemdnUkxpMXgrVVZqcWRWdy9rVStrMUVVdjhj?=
 =?utf-8?B?YnVETWV2QU1xcGdvd3lrd1B4MHlpZElBayt3ZytIMnlTeEIvV3JFYzNWM3BP?=
 =?utf-8?B?Y0l5a1RIWXdCOFF2eFpLbnlIeUtQbVp4d0MwbFpSR1NyVFFpL2N6VTNPZGxt?=
 =?utf-8?B?YmU0MHh3OFE0L1dab2RtVWZrVHpuaitaUkxRM2t5QzJTcG02QjFtSS9vdGIz?=
 =?utf-8?B?ZEY4U1JtRDJONFlUZUdXby9vRmh4ZWZxNXk3cS9ZNTNyU0RUTFFmbVBlZnNC?=
 =?utf-8?B?WmZGVWtRcVRNY1VTaWNubUtHa3cvbFFEZExtajNqYlJKMTJ1ZU05NWNzMkc0?=
 =?utf-8?B?RGRvbmJ3V3RuOXpTMEViRm9mZFRiMEdRK3JrZEMyM1YyWFdEOFBuL3YxcVFz?=
 =?utf-8?B?RkFOWCtnVFV3ekxIanVLNCtGL040RmdUS2hyM2M3N3VuYm1VcjBuS1ZBYlFw?=
 =?utf-8?B?SXlZNVY0YWJ6L0l2eEV5TFQyZTRESjQrcUs1YnFDRkhZWnZSdkxHd2pmN05n?=
 =?utf-8?Q?mpPH6X3IaHb9EkJsMfaP/Wxr0?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3264934f-9a0f-46b5-ef6a-08de37ddcba1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 11:18:07.6318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IbqXmLzYXPfpm/9lQAfmLB377zr9H6aUgInzXnAQQw4JCldqiTWX3aaJw1zveupUeUwLdeZ6ef5Uz2sZpbPFTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11889

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVWxmIEhhbnNzb24gPHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDksIDIwMjUg
OTo0OCBQTQ0KPiBUbzogQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPjsgTHVrZSBXYW5n
DQo+IDx6aW5pdS53YW5nXzFAbnhwLmNvbT4NCj4gQ2M6IGFkcmlhbi5odW50ZXJAaW50ZWwuY29t
OyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxA
cGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gbGludXgtbW1jQHZnZXIua2Vy
bmVsLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRldjsgZGwtUzMyIDxTMzJAbnhwLmNvbT47DQo+IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHYyXSBtbWM6IHNkaGNpLWVzZGhj
LWlteDogd2FpdCBmb3IgZGF0YSB0cmFuc2Zlcg0KPiBjb21wbGV0aW9uIGJlZm9yZSByZXNldA0K
PiANCj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2Fy
ZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yDQo+IG9wZW5pbmcgYXR0YWNobWVudHMuIFdoZW4gaW4g
ZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0aGUgJ1JlcG9ydA0KPiB0aGlzIGVtYWls
JyBidXR0b24NCj4gDQo+IA0KPiBPbiBGcmksIDUgRGVjIDIwMjUgYXQgMDk6MTIsIEJvdWdoIENo
ZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBMdWtlIFdhbmcgPHppbml1LndhbmdfMUBueHAuY29t
Pg0KPiA+ID4gU2VudDogMjAyNeW5tDEy5pyINeaXpSAxNToxNw0KPiA+ID4gVG86IGFkcmlhbi5o
dW50ZXJAaW50ZWwuY29tOyBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+Ow0KPiA+ID4g
dWxmLmhhbnNzb25AbGluYXJvLm9yZw0KPiA+ID4gQ2M6IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMu
aGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gPiA+IGZl
c3RldmFtQGdtYWlsLmNvbTsgbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgaW14QGxpc3RzLmxp
bnV4LmRldjsNCj4gZGwtUzMyDQo+ID4gPiA8UzMyQG54cC5jb20+OyBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
DQo+ID4gPiBTdWJqZWN0OiBbUEFUQ0ggdjJdIG1tYzogc2RoY2ktZXNkaGMtaW14OiB3YWl0IGZv
ciBkYXRhIHRyYW5zZmVyDQo+IGNvbXBsZXRpb24NCj4gPiA+IGJlZm9yZSByZXNldA0KPiA+ID4N
Cj4gPiA+IEZyb206IEx1a2UgV2FuZyA8emluaXUud2FuZ18xQG54cC5jb20+DQo+ID4gPg0KPiA+
ID4gT24gSU1YN1VMUCBwbGF0Zm9ybXMsIGNlcnRhaW4gU0QgY2FyZHMgKGUuZy4gS2luZ3N0b24g
Q2FudmFzIEdvISBQbHVzKQ0KPiBjYXVzZQ0KPiA+ID4gc3lzdGVtIGhhbmdzIGFuZCByZWJvb3Rz
IGR1cmluZyBtYW51YWwgdHVuaW5nLiBUaGVzZSBjYXJkcyBleGhpYml0IGxhcmdlDQo+IGdhcHMN
Cj4gPiA+ICh+MTZ1cykgYmV0d2VlbiB0dW5pbmcgY29tbWFuZCByZXNwb25zZSBhbmQgZGF0YSB0
cmFuc21pc3Npb24uDQo+ID4gPiBXaGVuIGNtZCBDUkMgZXJyb3JzIG9jY3VyIGR1cmluZyB0dW5p
bmcsIHRoZSBjb2RlIGFzc3VtZXMgZGF0YSBlcnJvcnMNCj4gZXZlbg0KPiA+ID4gdHVuaW5nIGRh
dGEgaGFzbid0IGJlZW4gZnVsbHkgcmVjZWl2ZWQgYW5kIHRoZW4gcmVzZXQgaG9zdCBkYXRhIGNp
cmN1aXQuDQo+ID4gPg0KPiA+ID4gUGVyIElNWDdVTFAgcmVmZXJlbmNlIG1hbnVhbCwgcmVzZXQg
b3BlcmF0aW9ucyAoUkVTRVRfREFUQS9BTEwpIG5lZWQNCj4gdG8NCj4gPiA+IG1ha2Ugc3VyZSBu
byBhY3RpdmUgZGF0YSB0cmFuc2ZlcnMuIFByZXZpb3VzbHksIHJlc2V0dGluZyB3aGlsZSBkYXRh
IHdhcyBpbi0NCj4gZmxpZ2h0DQo+ID4gPiB3b3VsZCBjbGVhciBkYXRhIGNpcmN1aXQsIGluY2x1
ZGluZyBBRE1BL1NETUEgYWRkcmVzcywgY2F1c2luZyBkYXRhIHRvDQo+IGJlDQo+ID4gPiB0cmFu
c21pdHRlZCB0byBpbmNvcnJlY3QgbWVtb3J5IGFkZHJlc3MuIFRoaXMgcGF0Y2ggYWRkcyBwb2xs
aW5nIGZvciBkYXRhDQo+ID4gPiB0cmFuc2ZlciBjb21wbGV0aW9uIGJlZm9yZSBleGVjdXRpbmcg
cmVzZXRzLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEx1a2UgV2FuZyA8emluaXUud2Fu
Z18xQG54cC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IHYyOiBhbWVuZCBjb21taXQgbWVzc2FnZQ0K
PiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYyB8IDE1
ICsrKysrKysrKysrKysrKw0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCsp
DQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMt
aW14LmMNCj4gPiA+IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiA+ID4g
aW5kZXggYTdhNWRmNjczYjBmLi5hZmZkZTE5MzY1MTAgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2
ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+ID4gPiArKysgYi9kcml2ZXJzL21tYy9o
b3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+ID4gPiBAQCAtMTQ1Myw2ICsxNDUzLDIxIEBAIHN0YXRp
YyB2b2lkIGVzZGhjX3NldF91aHNfc2lnbmFsaW5nKHN0cnVjdA0KPiA+ID4gc2RoY2lfaG9zdCAq
aG9zdCwgdW5zaWduZWQgdGltaW5nKQ0KPiA+ID4NCj4gPiA+ICBzdGF0aWMgdm9pZCBlc2RoY19y
ZXNldChzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgdTggbWFzaykgIHsNCj4gPiA+ICsgICAgIHUz
MiBwcmVzZW50X3N0YXRlOw0KPiA+ID4gKyAgICAgaW50IHJldDsNCj4gPiA+ICsNCj4gPiA+ICsg
ICAgIC8qDQo+ID4gPiArICAgICAgKiBGb3IgZGF0YSBvciBmdWxsIHJlc2V0LCBlbnN1cmUgYW55
IGFjdGl2ZSBkYXRhIHRyYW5zZmVyIGNvbXBsZXRlcw0KPiA+ID4gKyAgICAgICogYmVmb3JlIHJl
c2V0dGluZyB0byBhdm9pZCBzeXN0ZW0gaGFuZy4NCj4gPiA+ICsgICAgICAqLw0KPiA+ID4gKyAg
ICAgaWYgKG1hc2sgJiAoU0RIQ0lfUkVTRVRfREFUQSB8IFNESENJX1JFU0VUX0FMTCkpIHsNCj4g
PiA+ICsgICAgICAgICAgICAgcmV0ID0gcmVhZGxfcG9sbF90aW1lb3V0X2F0b21pYyhob3N0LT5p
b2FkZHIgKyBFU0RIQ19QUlNTVEFULA0KPiA+ID4gcHJlc2VudF9zdGF0ZSwNCj4gPg0KPiA+IEkn
bSBva2F5IHdpdGggdGhlIHBhdGNoLCBidXQgSSBmaW5kIG9uZSB0aGluZyBoZXJlOg0KPiA+DQo+
ID4gSSBub3RpY2UgeW91IHVzZSBfYXRvbWljIGhlcmUsIEkgZ3Vlc3MgeW91IHdhbnQgdG8gY292
ZXIgdGhlIGNhc2Ugd2hlbiB0aGUNCj4gcmVzZXQgZnVuY3Rpb24gaXMgY2FsbGVkIGluIGhhcmR3
YXJlIGlycSBoYW5kbGVyIHNkaGNpX2lycSgpLg0KPiA+IEknbSBub3Qgc3VyZSB3aGV0aGVyIGl0
IGlzIHN1aXRhYmxlIHRvIGFkZCBkZWxheSBpbiBoYXJkd2FyZSBpcXIgaGFuZGxlciwgSQ0KPiBm
aW5kIHRoZXJlIGlzIGFsc28gdWRlbGF5IGluIHNkaGNpX3Jlc2V0KCksIHNkaGNpX3Jlc2V0IGNh
biBhbHNvIGJlIGNhbGxlZCBpbg0KPiBoYXJkd2FyZSBpcnEgaGFuZGxlciB3aGVuIHRoZXJlIGlz
IGNtZF9jcmMvZGF0YV9jcmMgZXJyb3IuDQo+ID4gQWRyaWFuL1VsZiwgZG8geW91IG5vdGljZSB0
aGlzIGlzc3VlIGJlZm9yZT8gQW55IGNvbW1lbnRzPw0KPiANCj4gWW91IGFyZSByaWdodC4gSW4g
Z2VuZXJhbCBpdCdzIGNlcnRhaW5seSBub3QgcHJlZmVycmVkIHRvIHBvbGwvZGVsYXkNCj4gaW4g
YW4gYXRvbWljIGNvbnRleHQuIEJ1dCBpZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5IGhlcmUsIHBv
bGxpbmcgaW4NCj4gYXRvbWljIGNvbnRleHQgc2hvdWxkIG5vdCBoYXBwZW4gdGhhdCBmcmVxdWVu
dGx5LCByaWdodD8NCj4gDQo+IE1vcmVvdmVyLCBJIHdvbmRlciBpZiB3ZSByZWFsbHkgbmVlZCB0
byBoYXZlIGEgcG9sbGluZy10aW1lb3V0IG9mDQo+IDEwMG1zPyBXaGVyZSBkaWQgdGhhdCB2YWx1
ZSBjb21lIGZyb20/DQoNCkkgcmVmZXJyZWQgdG8gdGhlIDEwMG1zIHRpbWVvdXQgc2V0dGluZyBv
ZiBzZGhjaV9yZXNldC4gDQoNCkFjdHVhbCBtZWFzdXJlbWVudHMgc2hvdyB0aGF0IGR1cmluZyB0
dW5pbmcsIHdhaXRpbmcgZm9yIGRhdGEgdHJhbnNmZXINCmNvbXBsZXRpb24gdHlwaWNhbGx5IG9u
bHkgcmVxdWlyZXMgdGVucyBvZiBtaWNyb3NlY29uZHMuIEhvd2V2ZXIsIGNvbnNpZGVyaW5nDQp0
aGF0IHRoZSB0dW5pbmcgYmxvY2sgc2l6ZSBpcyB2ZXJ5IHNtYWxsLCB3aGVuIHRyYW5zZmVycmlu
ZyBsYXJnZXIgYmxvY2tzLCBpdA0KbWF5IHJlcXVpcmUgYSBsb25nZXIgd2FpdGluZyB0aW1lLiAN
Cg0KVGhlIHByb2JhYmlsaXR5IG9mIGVuY291bnRlcmluZyBDUkMgZXJyb3JzIHRoYXQgcmVxdWly
ZSBhIHJlc2V0IHdoZW4gbm90IGluIHR1bmluZw0KaXMgcXVpdGUgbG93LCBzbyB3YWl0aW5nIGZv
ciBzb21lIGFkZGl0aW9uYWwgdGltZSBtYXkgbm90IGNhdXNlIHNpZ25pZmljYW50IGltcGFjdC4N
Cg0KPiANCj4gSW4gYW55IGNhc2UsIHBsZWFzZSBhZGQgYSBkZWZpbmUgdG8gc3BlY2lmeSB0aGUg
dGltZW91dCBhbmQgbWFrZSBzdXJlDQo+IHRoZSBkZWZpbmUtbmFtZSBoYXMgdGhlIHN1ZmZpeCBj
b3JyZXNwb25kaW5nIHRvIHRoZSB1bml0IChfVVMsDQo+IF9NUywuLi4pDQo+IA0KDQpTdXJlLCB3
aWxsIGRvIGluIG5leHQgdmVyc2lvbg0KDQpUaGFua3MsDQpMdWtlIFdhbmcNCg0KPiA+DQo+ID4g
UmVnYXJkcw0KPiA+IEhhaWJvIENoZW4NCj4gPg0KPiA+DQo+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIShwcmVzZW50X3N0YXRlICYgU0RIQ0lfREFU
QV9JTkhJQklUKSwgMiwNCj4gPiA+IDEwMDAwMCk7DQo+ID4gPiArICAgICAgICAgICAgIGlmIChy
ZXQgPT0gLUVUSU1FRE9VVCkNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICBkZXZfd2Fybiht
bWNfZGV2KGhvc3QtPm1tYyksDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
InRpbWVvdXQgd2FpdGluZyBmb3IgZGF0YSB0cmFuc2ZlciBjb21wbGV0aW9uXG4iKTsNCj4gPiA+
ICsgICAgIH0NCj4gPiA+ICsNCj4gPiA+ICAgICAgIHNkaGNpX2FuZF9jcWhjaV9yZXNldChob3N0
LCBtYXNrKTsNCj4gPiA+DQo+ID4gPiAgICAgICBzZGhjaV93cml0ZWwoaG9zdCwgaG9zdC0+aWVy
LCBTREhDSV9JTlRfRU5BQkxFKTsNCj4gPiA+IC0tDQo+ID4gPiAyLjM0LjENCj4gPg0KPiANCj4g
S2luZCByZWdhcmRzDQo+IFVmZmUNCg==
