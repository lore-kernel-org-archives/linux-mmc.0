Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013043.outbound.protection.outlook.com [40.107.162.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EB2313E11;
	Fri,  5 Dec 2025 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764922354; cv=fail; b=Tm1+2ys25L7P6oX7PpOb9n8olY622N6GExK32wbtlVN1NK8Mbcn/F/BHAfyYFxo4hOKQsZBMeTwCjU1pFlAsUUiJTGzfdvrkywF2vwXt2IvfK5QLgZmKNdmPkiUu0vACppYaiXxsqEHcsgcfw+w7rtxdKLiu+XU0xkni3bJ/qHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764922354; c=relaxed/simple;
	bh=1WuvWepsjHkMP5LDR9Ugw1wCWoRBAFDvMK8fR0rDtjE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NrRbwMucjrN+vqcJ3Z7pWamO3JPDyLH3JpAF66Qw4LLpM4EnwE1gw6Cr4lI6rD0PihWX1Nt92ZLuwUuGvtvfIbsoVWjyBovG9WCuwR9fM/oLKcx3X31zt74IIsaB9ixL5BY/ibb1z2tm86d3//6mlSSJPsF1aBXCE8SGo1tEcbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FxEABtlq; arc=fail smtp.client-ip=40.107.162.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FxEABtlq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clsdptzQ9EPw/065RmBA+g0hZLEggHxVZY+66AHdH1kPm2w38naJQG4Opap3TnCMpBoClyvvuQ/ODFax77h/i/eBctSItYbK41bGbLeaX0hq75w/lTrv27lSvaq6ZEcZm/8ekmJzPPZWgIPNJQyZQNJ16yYL8gXDxU0NH+IYF7kSbUkyvu4BYsWz5+Y6N9wBup7JwE/904Ms7ga76iTbmmfVtHO/Po2PbciF643I6g12lvEdVeIUCdeOkzWe4vgUTRo09k1sEBACMqah5JYtoiUbdfrMhWNx6h3ZGsCLqex7GHtC5GcZlolGP56/0WPRi5ggp5O3/3AQuG0oeSqdUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WuvWepsjHkMP5LDR9Ugw1wCWoRBAFDvMK8fR0rDtjE=;
 b=jQeYTSqU1c2ua9oEDXk1fVN4tSViLxdc3N/qwfj9gOoJ9ctL61GUdOpfgbcczcfpXHXbTyxI23O6Tg3sI1HFOwm0OGp3Pig32OxxULt1Les4DopKaNVa2pNIqyUnBVYRkZXhmwqlbECraI+y6ynz1JPmsifv7lt6LdBARMy0W0VSBQba+bdW8aPIv7xLwydA0PqIPXWumL3DU0DYJn0BmkXxJoyK176blux2DSqFr9TOv1D8YPluTSnyqktxGpk803Txj5Y6kokMfoDI0wYR078XZqqFcNro5vG7cZ6b5YYDyAycNfJ9H83ZDX4+IoMrTTNbQBYh/dWxnpSwVVve5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WuvWepsjHkMP5LDR9Ugw1wCWoRBAFDvMK8fR0rDtjE=;
 b=FxEABtlqH3YS+UDeNaAJPa4XByutK9NNC4GoyMyxN5cbo3N9b+6vwlp1lnqdpoBTI/KBJHhSG4mrJwKYhjKQ+283WQnTIlWibiBnIwHiS1f4lSghMuOImBH7LlqAtalk96xaZbMrHo8uSPq3n6DVwNha1WZIa/cRaBusr+TZBdbLTbKbbIlcA2BiLSz/09CVJ6ztp6mFiPlhtwxuOJWKrzfX2zFO+VSzlsTcSIXj30gOup5YfjTqe1/VB0M9NlzzE25+fe62mhzILIvQNE5r/1SGdT0svrM8X7UK+gBYnWMp2qxmz73vW6nidd83LngAQgUqUM8Pf+hMqcawIl9c0A==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AS8PR04MB7606.eurprd04.prod.outlook.com (2603:10a6:20b:23e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 08:12:12 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 08:12:12 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Luke Wang <ziniu.wang_1@nxp.com>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	dl-S32 <S32@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] mmc: sdhci-esdhc-imx: wait for data transfer
 completion before reset
Thread-Topic: [PATCH v2] mmc: sdhci-esdhc-imx: wait for data transfer
 completion before reset
Thread-Index: AQHcZbb4F9GLpxHcd0SM2WINy8lGOLUSr8jQ
Date: Fri, 5 Dec 2025 08:12:12 +0000
Message-ID:
 <DU0PR04MB94962D103B1A92354CDD1FE690A7A@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20251205071729.83857-1-ziniu.wang_1@nxp.com>
In-Reply-To: <20251205071729.83857-1-ziniu.wang_1@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|AS8PR04MB7606:EE_
x-ms-office365-filtering-correlation-id: 481f6534-02e7-48d0-0ad7-08de33d5feb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|7416014|366016|376014|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?gb2312?B?WjgxMG9oMkJ3Yzc4RUMxblpYYTZoRUpiQlhZQjBEOTM3OFF6OVlpVEVucUFX?=
 =?gb2312?B?SjVaNHNhWkpoSWcyekJ0R084S0M1OHBNVERUMElkL1YrQy96ZG1XcnpSL1lG?=
 =?gb2312?B?cEE4N0xPWSsySElDY3ZVRXAzY0pad3BIenNTVEhtSStSRjByei9tNVFOakdo?=
 =?gb2312?B?aXZZbHV4ZkprVm9aM1k0dlNQNW95K0ZmMEhnRjl5eFNreEUvZks4Zit2cnAr?=
 =?gb2312?B?eGN1ZXliU2lpVzZaeXJkSDRlb2dOQkhPcmlNcHlwaEgvckRVU0xPb1VFc0Fk?=
 =?gb2312?B?MUdLSXVYRFlBVzU0Ly9LTkxqQjRwRitNbjkyU0l3eGVLeFBOZGp6eDFaTkNp?=
 =?gb2312?B?bGc4UTFEc0VPMmJONm5IcG1Ubmw0MkhwL0ZSNEd2cWpiSFZkdFB0bVkrSXJV?=
 =?gb2312?B?eTJ1dzljNDU1ZlVHcE1DUGJVVFFodnY5U3lrZlRzSHV0UG5pZnhzR3ZkYkF4?=
 =?gb2312?B?YW9vZmlaYnRQZ0kyWE45Y2lpbHZsOHFSUURMVU5PekdFcUN0Kzc5Y1NyanE3?=
 =?gb2312?B?T0ZEYnZkR1F2OHpoTlExRjhGMkx0WHpUbk1zM3V3a0txMjdWdjBaOXBjV0Zm?=
 =?gb2312?B?anV0b1BOUnNGZjRweitrVmlVSVZmemJhQVNGMHFCcnZwUzVzOWtOeUU1ZzlN?=
 =?gb2312?B?QzBBNGxNZVA1eFdJOVhpSTNHL0JhOXhUeGp0RklzMlpxbHZXSS9rT05sZ2NU?=
 =?gb2312?B?ZjM3eTV2dFpNVDh5YzE5ajM3RFVOcER4VjJCUUI0U3dLd2piUE9iL0ZYaUZK?=
 =?gb2312?B?SzdsdGpZa0V6UWg5UW4wUHM0bW9OZ1p3RE0wTm44MWN5ZVBqYklHNWsycW5y?=
 =?gb2312?B?WlpSN1pkOHZTajR2TUo3dWN2Q3RSazBZVmFXMDBxMkFwWVVkRmFXNEFBMVRw?=
 =?gb2312?B?NEZiN21hd3lWYUk2aG80STlKdnlxTzFNTW5kOGNIVTY1a3pOM0FyS01NSWF4?=
 =?gb2312?B?RURmS1NpQlkraFVieHQvTDhqY2NDTXVLZ0tsM2ZZcTZUWWxwQmVxd0FXdFgx?=
 =?gb2312?B?WHNNREIvSzlZS2RlbUJpSGtRbTVVaUk5ZCtidzJ2MmVPM3RjR1RKekZKWjVR?=
 =?gb2312?B?YVlTUjRadDQ1bFVSN3FjMThpVzVLdDZPc09tZGpwRTRxWnUzTTVLNlFkcGRV?=
 =?gb2312?B?MEFHOGhobWIwaU5PcFltby9LSmY2SUVlZVFOU0QreGFsMndBOTJlRTIvNVU0?=
 =?gb2312?B?Mm5VYWF6ZEY1anVKL1ZFa0djNEthMGRORStjQVZudTY1VnZxYzdjNG9IU3RB?=
 =?gb2312?B?aFJOVWszQURKd01SaUhIaE1BMld4dWVPelhNOUJNc2JUaUNDS0dvS3U2S3ZT?=
 =?gb2312?B?aDBVSld6Q2dabjFZNTQ5TUdhb3Y0LzVYOGp5VHRMNTdhVkJuK2FndEdycWRX?=
 =?gb2312?B?eEhIR1RpRW04bmwzNDk1S1JIdnIwcEFVNU1Pd2Y3SVd0VU5EVXdJblNpcytn?=
 =?gb2312?B?dXN6S3ByRGJHQnkxNlJPZ0FpOUIvWjlNNXJtODh3alo3TjdXMjNtbmltUEZS?=
 =?gb2312?B?YWt3TTJrdWdPZ1ByY0pMdnZ4R3JNK3lmTWNNOHY4dE1jNUVGRGxuQVB0ZDlk?=
 =?gb2312?B?V2ZUUU5aMGFLRE5qL3k1NVRRbGJuVVhpaWVRNzVXU3lDdEoyckNMWFk5TkFI?=
 =?gb2312?B?MENpOXF5bFhWcXA3NE9FOTBZZURZdGpndDRxSzV0djdqWjQzYnRQNlhWdERI?=
 =?gb2312?B?ZE1tYVd5bHVjbTM0QjlvbW5KamZpd0xJNTdaZzZWK1h6eVJKU0kzQjRZbGR6?=
 =?gb2312?B?TGUwaVhvL2hNdFA3bEp6cXZQNDVMeEEvRy9ab2pEbWdsMkEzQW9SN2Q3VUxJ?=
 =?gb2312?B?Z0pablpud0ViNXNxbnp0ZkR2TUtCUE8yUTRuU3IvSGxTYUFiUnZnd2RtMktq?=
 =?gb2312?B?L3JvUHNVby83cGRxV0FLeFVwLzBNQTlmU0ExeFZiZ1dWdWFpc2hMOW03eCtp?=
 =?gb2312?B?d1ZMdFFtcXpjd0IyYmNyc2ZHUGIzNUo0aDNhVThMcjBNK3ROZ3g0ODlWS3R5?=
 =?gb2312?B?MWx2T2VFdTJTWjZrRWhFMXV1dmxFOXo1VEJodUt2OTJ1WkhmOWtDcmk2aGEx?=
 =?gb2312?Q?8I06si?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(366016)(376014)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?aktoZE05cXI0MDhubXN5eS83U0VCYzE1WHZncTQ1c2h0QUxnYkhZNVhibmgx?=
 =?gb2312?B?RzhmOHhyV0graUlNd2RveHYzczVYVGdjS016WXl3SWNOejM4MXVYWTBwb0NV?=
 =?gb2312?B?MFNMY0F3T3E1N2YrREFhTkJ1UVlkYUQxeXQ2KzFoOUNGZkJBZURhVWFRRmZz?=
 =?gb2312?B?d3FRTU9YUzBERXMxdGNxN3F5U2M4Z2tKZnVpS2R0bWsyU0RJUzJmNmJ6Vi9w?=
 =?gb2312?B?LzRPbmNORU0yTVN4Ykpqb093NkY0bnloWHFja0p4aVZYSld4clNhZUg1NVRF?=
 =?gb2312?B?UmNoc3hINzN3UHorRVNjVXNVVzFIUUxCZU1WbEZRbE5BUDVCNlhTMVFSbWYw?=
 =?gb2312?B?Q3BHNGtPR1l2QTlZdnlyQXoyY3dyMTBwcit6YThIQ2Jwcm9XdGloNmdWa1Jr?=
 =?gb2312?B?VTUwTEN4Q3pLZWVwU04ySGFMb04vRFBrVTJrV3d2Z3FseFpPQjlPRG8yMnN3?=
 =?gb2312?B?UjdWV09RamhoL2xzSEk0cFNBd0dnRWRJeWtRYWZFNC9Wc0F0VUJueWtFVDg1?=
 =?gb2312?B?SWVONTNoVTNWajdOcGxPS21QUnNIZDB4Q2JINy9GSVQ1dGpNQWhmeXMrVGY5?=
 =?gb2312?B?TGwrL05MeWpsSlhVR0l1Y3RWNm5SVlRsVmp3aGdHQzAwb0E2aW9YbGRKVE5J?=
 =?gb2312?B?QWhIUkFqTXM3TjdJVlBwTzhlL0lSOTZwaTdmNkpCMUFBaGV4emhSUkFQREZL?=
 =?gb2312?B?alBzb29pMjJhRGI4NUlrOVFrL3RHM1hLL1pGOHNqeExXSnhkREorU2I4QlZy?=
 =?gb2312?B?SXlKSGV5NE0yOHhOaC93L1F2Tjh2UVFoeU5ENGJxQnZ2WksxOElXRU9OanNj?=
 =?gb2312?B?Z1ZPTW83dW5tRGxuQUh1c3ZjSUJEQTh0WEZOLzB2RW91aWdxN096ZnRkNzZk?=
 =?gb2312?B?dG1LVEtlTmJzWVNRcWhsTXNGUXRnc0tuSldrK0xmcDVlVVBJSC8wTy8xb0xa?=
 =?gb2312?B?Z0g1NnFNWFlmeFVRWVYrSDJFallWZHFKZ1Z1WWtUaUo0dmxJS2ZyWDMrTG1S?=
 =?gb2312?B?N1B4UHZhVE5nb2EveGVCZlhJWENSZXhQd0h1MEVtUXNLNnFrT3A1YndTQkxX?=
 =?gb2312?B?YVRIdVRKT2pXNkEyZytCVk9qOHZURFNPN1hJOU5sYkUweTF5WnRybkZNSXUw?=
 =?gb2312?B?bUo0U3FWRkNqaUN6SlZzTy9HaGQ3VlQ1Q0Fac0hJK2lpSllkZEVoREhLYnFr?=
 =?gb2312?B?aHY5c1BVTXRTNUh6VlJEeTQ1dTc2UVlkZVlKVkZYcmtUbk9BaUhiMlVRaEpE?=
 =?gb2312?B?V285bFdXN0RUNVpmMVhMYW9DWGU0WWVJOVhUb3lKVGFodnIwVmZCc2JkWEdi?=
 =?gb2312?B?L01OQkRrVWxKMUxveEhUYXhJN3FWSTljS2ZHaFhhUTBCVDEvWm5lKzQ2dFBR?=
 =?gb2312?B?cWZ0bnQ2WTdhVlhacUVHdndzU2dVa2ZQbTY5Tm5TSUNZM0p0YTdGencvSTBa?=
 =?gb2312?B?WWp4TXY5b0xFOHdGalFMVkNPMTZyR3VRQlhFYTdDT3EwZHJJbHJ6emNZTU0y?=
 =?gb2312?B?WkN5UGJHZ0lIbE5CeC9IS3kwTzdocEtuSnd5YVB3S1hMZ3c5bmFRZmtLQlNz?=
 =?gb2312?B?cGUwQlNXVzZOY0Z6eVhjQnZoODNtR1Y4WEJON0U0MXZxMzZEVk5mR0tKZ1V4?=
 =?gb2312?B?emF6ZHVjTGtnUjcyTDlmMW1nb2gyUWN3a2Y3c2FXT085ckNqNFNYK2h6VkF6?=
 =?gb2312?B?S2lVL3RJWHVERDBaUHdVL2RnQmlPZG5Qam1zdlAwYUJGc2NSenl5RmhzdDN3?=
 =?gb2312?B?Wi8rYnRCZEVVdi9jTzhsdkJwRC9MU3ZlVGU1UDdBS3AvVWxIbko3cm94cXFI?=
 =?gb2312?B?TSt6eXYycVU1NVlycURWTXVPakdGSjl4MXV4ODd5Y1RLbkpsVjREbGxleE0x?=
 =?gb2312?B?b1VUTFRXbUpabXhtTG1aMWlyV0tRZjJRdk94MzZ5aGRSc1VMM0RYQjlaUW1F?=
 =?gb2312?B?QlZ5S1A3YzQ5SjRsN3k5OG1xRlJzczJpQ3ZXOWxDSnVDM0hQa2t6dlRZUzNS?=
 =?gb2312?B?S1V0cDZQRnlMV2Nha3U5T3pXREk2enpZSG00TnpVZkc5aDVYa3M2cTJacFNi?=
 =?gb2312?B?WDFSZCtIZmkxek9ENWJQejRybjdvVmRNVGIvVDUxbXFlU2U1TzlrYXVadi9z?=
 =?gb2312?Q?xZpo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 481f6534-02e7-48d0-0ad7-08de33d5feb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 08:12:12.7267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8bcox7fLrxzKDisTDDHwnPddkryegaAAnA3ryBCDAK0IvEDb+hSVKdEUjcshza3qiV9RDqp9jw3qS53qz3b0rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7606

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWtlIFdhbmcgPHppbml1Lndh
bmdfMUBueHAuY29tPg0KPiBTZW50OiAyMDI1xOoxMtTCNcjVIDE1OjE3DQo+IFRvOiBhZHJpYW4u
aHVudGVyQGludGVsLmNvbTsgQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPjsNCj4gdWxm
LmhhbnNzb25AbGluYXJvLm9yZw0KPiBDYzogc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBw
ZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBmZXN0ZXZhbUBnbWFpbC5j
b207IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXY7IGRsLVMz
Mg0KPiA8UzMyQG54cC5jb20+OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIIHYyXSBt
bWM6IHNkaGNpLWVzZGhjLWlteDogd2FpdCBmb3IgZGF0YSB0cmFuc2ZlciBjb21wbGV0aW9uDQo+
IGJlZm9yZSByZXNldA0KPiANCj4gRnJvbTogTHVrZSBXYW5nIDx6aW5pdS53YW5nXzFAbnhwLmNv
bT4NCj4gDQo+IE9uIElNWDdVTFAgcGxhdGZvcm1zLCBjZXJ0YWluIFNEIGNhcmRzIChlLmcuIEtp
bmdzdG9uIENhbnZhcyBHbyEgUGx1cykgY2F1c2UNCj4gc3lzdGVtIGhhbmdzIGFuZCByZWJvb3Rz
IGR1cmluZyBtYW51YWwgdHVuaW5nLiBUaGVzZSBjYXJkcyBleGhpYml0IGxhcmdlIGdhcHMNCj4g
KH4xNnVzKSBiZXR3ZWVuIHR1bmluZyBjb21tYW5kIHJlc3BvbnNlIGFuZCBkYXRhIHRyYW5zbWlz
c2lvbi4NCj4gV2hlbiBjbWQgQ1JDIGVycm9ycyBvY2N1ciBkdXJpbmcgdHVuaW5nLCB0aGUgY29k
ZSBhc3N1bWVzIGRhdGEgZXJyb3JzIGV2ZW4NCj4gdHVuaW5nIGRhdGEgaGFzbid0IGJlZW4gZnVs
bHkgcmVjZWl2ZWQgYW5kIHRoZW4gcmVzZXQgaG9zdCBkYXRhIGNpcmN1aXQuDQo+IA0KPiBQZXIg
SU1YN1VMUCByZWZlcmVuY2UgbWFudWFsLCByZXNldCBvcGVyYXRpb25zIChSRVNFVF9EQVRBL0FM
TCkgbmVlZCB0bw0KPiBtYWtlIHN1cmUgbm8gYWN0aXZlIGRhdGEgdHJhbnNmZXJzLiBQcmV2aW91
c2x5LCByZXNldHRpbmcgd2hpbGUgZGF0YSB3YXMgaW4tZmxpZ2h0DQo+IHdvdWxkIGNsZWFyIGRh
dGEgY2lyY3VpdCwgaW5jbHVkaW5nIEFETUEvU0RNQSBhZGRyZXNzLCBjYXVzaW5nIGRhdGEgdG8g
YmUNCj4gdHJhbnNtaXR0ZWQgdG8gaW5jb3JyZWN0IG1lbW9yeSBhZGRyZXNzLiBUaGlzIHBhdGNo
IGFkZHMgcG9sbGluZyBmb3IgZGF0YQ0KPiB0cmFuc2ZlciBjb21wbGV0aW9uIGJlZm9yZSBleGVj
dXRpbmcgcmVzZXRzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTHVrZSBXYW5nIDx6aW5pdS53YW5n
XzFAbnhwLmNvbT4NCj4gLS0tDQo+IHYyOiBhbWVuZCBjb21taXQgbWVzc2FnZQ0KPiAtLS0NCj4g
IGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMgfCAxNSArKysrKysrKysrKysrKysN
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBiL2RyaXZlcnMvbW1jL2hvc3Qv
c2RoY2ktZXNkaGMtaW14LmMNCj4gaW5kZXggYTdhNWRmNjczYjBmLi5hZmZkZTE5MzY1MTAgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gKysrIGIv
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBAQCAtMTQ1Myw2ICsxNDUzLDIx
IEBAIHN0YXRpYyB2b2lkIGVzZGhjX3NldF91aHNfc2lnbmFsaW5nKHN0cnVjdA0KPiBzZGhjaV9o
b3N0ICpob3N0LCB1bnNpZ25lZCB0aW1pbmcpDQo+IA0KPiAgc3RhdGljIHZvaWQgZXNkaGNfcmVz
ZXQoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsIHU4IG1hc2spICB7DQo+ICsJdTMyIHByZXNlbnRf
c3RhdGU7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCS8qDQo+ICsJICogRm9yIGRhdGEgb3IgZnVs
bCByZXNldCwgZW5zdXJlIGFueSBhY3RpdmUgZGF0YSB0cmFuc2ZlciBjb21wbGV0ZXMNCj4gKwkg
KiBiZWZvcmUgcmVzZXR0aW5nIHRvIGF2b2lkIHN5c3RlbSBoYW5nLg0KPiArCSAqLw0KPiArCWlm
IChtYXNrICYgKFNESENJX1JFU0VUX0RBVEEgfCBTREhDSV9SRVNFVF9BTEwpKSB7DQo+ICsJCXJl
dCA9IHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoaG9zdC0+aW9hZGRyICsgRVNESENfUFJTU1RB
VCwNCj4gcHJlc2VudF9zdGF0ZSwNCg0KSSdtIG9rYXkgd2l0aCB0aGUgcGF0Y2gsIGJ1dCBJIGZp
bmQgb25lIHRoaW5nIGhlcmU6DQoNCkkgbm90aWNlIHlvdSB1c2UgX2F0b21pYyBoZXJlLCBJIGd1
ZXNzIHlvdSB3YW50IHRvIGNvdmVyIHRoZSBjYXNlIHdoZW4gdGhlIHJlc2V0IGZ1bmN0aW9uIGlz
IGNhbGxlZCBpbiBoYXJkd2FyZSBpcnEgaGFuZGxlciBzZGhjaV9pcnEoKS4NCkknbSBub3Qgc3Vy
ZSB3aGV0aGVyIGl0IGlzIHN1aXRhYmxlIHRvIGFkZCBkZWxheSBpbiBoYXJkd2FyZSBpcXIgaGFu
ZGxlciwgSSBmaW5kIHRoZXJlIGlzIGFsc28gdWRlbGF5IGluIHNkaGNpX3Jlc2V0KCksIHNkaGNp
X3Jlc2V0IGNhbiBhbHNvIGJlIGNhbGxlZCBpbiBoYXJkd2FyZSBpcnEgaGFuZGxlciB3aGVuIHRo
ZXJlIGlzIGNtZF9jcmMvZGF0YV9jcmMgZXJyb3IuDQpBZHJpYW4vVWxmLCBkbyB5b3Ugbm90aWNl
IHRoaXMgaXNzdWUgYmVmb3JlPyBBbnkgY29tbWVudHM/DQoNClJlZ2FyZHMNCkhhaWJvIENoZW4N
Cg0KDQo+ICsJCQkJCQkhKHByZXNlbnRfc3RhdGUgJiBTREhDSV9EQVRBX0lOSElCSVQpLCAyLA0K
PiAxMDAwMDApOw0KPiArCQlpZiAocmV0ID09IC1FVElNRURPVVQpDQo+ICsJCQlkZXZfd2Fybiht
bWNfZGV2KGhvc3QtPm1tYyksDQo+ICsJCQkJICJ0aW1lb3V0IHdhaXRpbmcgZm9yIGRhdGEgdHJh
bnNmZXIgY29tcGxldGlvblxuIik7DQo+ICsJfQ0KPiArDQo+ICAJc2RoY2lfYW5kX2NxaGNpX3Jl
c2V0KGhvc3QsIG1hc2spOw0KPiANCj4gIAlzZGhjaV93cml0ZWwoaG9zdCwgaG9zdC0+aWVyLCBT
REhDSV9JTlRfRU5BQkxFKTsNCj4gLS0NCj4gMi4zNC4xDQoNCg==
