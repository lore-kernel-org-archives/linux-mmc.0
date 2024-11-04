Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E09E3214;
	Mon,  4 Nov 2024 02:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730686295; cv=fail; b=lzr//gC7tum0knyobMmFuCrRETCVoWM3RkKMWeoGbUbTkXvaII0wkloT/91X1OCfVqPDzx5fyPQ8DaDk8NRVlLKgrPBMh9ahDo5juZ9cirioBnOyU4JV8a9lVnoxY81L4bBS/URZf6DG8+i5B2vtFOrmPqb8A+9s5MRxHALsfh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730686295; c=relaxed/simple;
	bh=yyVRHKHOxWIyNKapDAKkmEAk65VGDCsNTJNwMTVkG9k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DlasztlNCmh6vLAOMEZOexp5jFDBlwnSHdX3yBFoU5qLj6+yhJmzV02S8AJ1uLpuT2U0Fdhzrzm35GQzTP/1ZKWIJOylKlnoCJEK2MEszMCR6sFLT4EBu8U1hfCXgLPOf6vi0Sq+Ky6lxH8eqxIpHHVuVi+NAulDO1guesdSIa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e0GEXC/Q; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e0GEXC/Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwQtv7yDPM+W+VATtFmXmgZfkoLf6TF8QSA77NnWazVTW3+JLWUTwm4qVdMTu5QMjN+cCtTzbtH/V4//OnXEoKOye0w/JjK9AjY82I0t3pehCgl30GBJBOA44Zm84f0aNfCb3SKwrNJy8fpSkfQ26o9prDkiRwNlMs0iFSUJZyr5AjXll4mVNnPPHjlyL33snDPJMawwE8H3zdJn8CvPt5yLLTvbawLkhUMhLyHDvHwkOAkXpNw0053QhY5fhFMFNu5A9s0puKw58ZXRIafqgbjjMj70URisB5944p2lFGg4HO92nc1Y84jNszQ1RriweQLxhANfSRAgxMbjFbRdPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyVRHKHOxWIyNKapDAKkmEAk65VGDCsNTJNwMTVkG9k=;
 b=JkyWR2JOBZGfaCM7eLm0EjMGmEsW862I5e3XA83W8MCGPJmiG30/2771ufuFieXrlfk83KIjvFMFKwr2Ah5BjFwTBvqXBQyfGyAVsNpQ4jxilSetos0M8GbIM3Cvx2fr0OFJmgG5zymolLqpAQTa3ktzR99B4Sr5ZMKDvd4iioWI7eyjg4CMnyUO7KRApBBhF16FR4HbdoIR8W1TLtC7Sy5B9m5rYKSimYF76CEwV1odtld67zKJFxIxp3+mrtpowo2zhAsFM1bqHR7LkipB3XjuJBd91atTWxdk16LgXG/SYeubIgF/q98ym1qBtCITkjQ0XZ7DzUJY4ODGUv5vHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyVRHKHOxWIyNKapDAKkmEAk65VGDCsNTJNwMTVkG9k=;
 b=e0GEXC/QIaB9j/GAa4Y3PvJWxuIECiI/JPz0rOmjEkDAprukU4KiBKRPl69aetUTFtQBkcX//o7K+OshV/Oz0lLLffg+FhHuFZ181lEmeNCs+L2E3w4s4jrVcAyfyct6YHhsAs6rTunW0iAGpINQVhFJihdattleJPHS+C8qJtfFq0mhmZQNqGTE/ToWbNt/ndsGpoTYq6BZAbHsoP3XdGkcULBqmboMYuEb6u44bqtFGdo/S0/MBETgW1I7HL0d1VWWbZFN+T3DEzjJDgm+aWXkwoa1jlV66ViUMajVC44U3OawOJqjewHqQhctS9siSjLNNMo30TDuXsA5bYpzhQ==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AS8PR04MB8021.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.28; Mon, 4 Nov
 2024 02:11:30 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%7]) with mapi id 15.20.8114.015; Mon, 4 Nov 2024
 02:11:24 +0000
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
Subject: RE: [PATCH v3 1/2] mmc: host: sdhci-esdhc-imx: implement emmc
 hardware reset
Thread-Topic: [PATCH v3 1/2] mmc: host: sdhci-esdhc-imx: implement emmc
 hardware reset
Thread-Index: AQHbLFMlDJqFQyS9wUanxIIrLLdO9LKmZM/A
Date: Mon, 4 Nov 2024 02:11:24 +0000
Message-ID:
 <DU0PR04MB949697426763B794FC5BF47590512@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20241101-imx-emmc-reset-v3-0-184965eed476@solid-run.com>
 <20241101-imx-emmc-reset-v3-1-184965eed476@solid-run.com>
In-Reply-To: <20241101-imx-emmc-reset-v3-1-184965eed476@solid-run.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|AS8PR04MB8021:EE_
x-ms-office365-filtering-correlation-id: ff9dc88b-cf6d-455c-b175-08dcfc75fb99
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TzlWU2RvcGYyclVDU280SCtFUEJheCtpdVEzOCtETE11R3hTeTNjeG9EdVJ3?=
 =?utf-8?B?SGNPZFFacWFoam1KYmllOG85RFNzbHdjMVRUSUFoUjUxZUNxUURmRWN2M0lz?=
 =?utf-8?B?ZGVkVEFubHBUN0tzUTZtazNvRzB2UElmRVRVWnhwZHVKMkNDY2JNVTVMNWQ5?=
 =?utf-8?B?K0x2MUZkRHMxQmxucExoU0t0Y3dWb0Z6bDRIbVNURlN1ZWZUdXZJRWxYQnls?=
 =?utf-8?B?VllqZjNaMnVqbmRNbVVYd3hnS29ER01ISjQ3MWlQU3I2aE5Vc1grdHFiUVFQ?=
 =?utf-8?B?ekorSmVWN3pqdFJYbU15bHh3Zkx4Z2RQeGM0ektaWURoV3RVT01hK295aWpi?=
 =?utf-8?B?YlF4Q3dJeW9LT2cyV3lRYXhVU0FqRXBqOXFBczloKzBETzRhK2ltcWpKMDJV?=
 =?utf-8?B?R3E4aTArbjZ1VjJMRmpPVFhQM0RvNllDQWY5UHRpYmY3RXhTbXNlNUgxVjNt?=
 =?utf-8?B?bjdHRStFMEpKRm5sUnI4Z0N3c25zVFNKd0FidFF0ak4vMWtja0g0MXluRWtq?=
 =?utf-8?B?OWUraGxqOTFRYlA4TFMvRDRDWlZFQnlGVGRJU0dhSU5KRlU2MkRvQ1NMRnlJ?=
 =?utf-8?B?WE1ET0tiT0dEWE03cVo5MHNXZmRPWGpXRnhpdUI0M0FrNW9hMC9xaTB1S2xE?=
 =?utf-8?B?YnhIOUNteCsvdlQ5OUdpc3VpcUZieHIxRVpJb0ppcGErNDFWV09KVnBjRTdw?=
 =?utf-8?B?NTVPWHp2aDJ6ZlNkcjI4OXVRb2FNcW1ZVkNKQ29yRDhLVTlQWFVnQVc4dmNL?=
 =?utf-8?B?ZVYzVnBSR00wSDVvOURRdUptRzA4WjE1WGVER1lueGFTY01ScXQ1cWpQOTAz?=
 =?utf-8?B?bjAyUXJiVmlvSTFFU216Tit1eGpORlU0M0dSSUlSODNQMWZLSUFPcXJVTnMv?=
 =?utf-8?B?N3pLcjVsU1JWR1RYNlFWY2VxSU54M0s3Uk1xQjJZWU5LTGc0dklaV0YrUzdY?=
 =?utf-8?B?ZmlPclc5VXp1ckszZFBOWEpFNndOcm9xM050V3ArSWdYejNGcXpsejZjUEk2?=
 =?utf-8?B?Z1lBaC9xVUU0K3VuZnlUc1RzSS9aMVJrNUdFdjNGMnlsRVc5QnBKOUUvWFBq?=
 =?utf-8?B?b3kvaDFYYjlGZUpUbThUMGN6MVUvWFdrNGdUV3Jtd3ZVa3ZkaHRHVmVmcUZ1?=
 =?utf-8?B?RXRQR1p6K3pEVHdud0tHWko1RHBNVFVMRm1yUWF1R0lHTTlNbHdmUGo1YXJI?=
 =?utf-8?B?NlZ5bzB1NmRmU1NWOWI1WW5rbmdYVmJoV2RQWFlDSHRtMi9YenBvdjZEYWFj?=
 =?utf-8?B?R2tFWkxtMDU5TjNLK3Z6d05ya0czSEphdnNHY2w0T0xTdktDcC9Dd2pHSG1H?=
 =?utf-8?B?bzY4SnluNWQxODR6Z3p1cDljMkR1K1lpK1dMUE01ajB6UWNGWGtRUW9pVlhN?=
 =?utf-8?B?N1UzQWpYbk5CNjROQnBMYU1SaUExR0dQVEVVVXdOZFdwKytPeGJudG84TFdN?=
 =?utf-8?B?N2lvUG5TQ0lNSnNMcGx1RWZQQmZNN285eW9rVUM5Ty9sZ0JtMFZYbTFtRDNk?=
 =?utf-8?B?NVdjMEw5bnlTaHNDSWNza3VwN2tCeXdESUs4RWdTMitiV2xzSHpKY2UwRktx?=
 =?utf-8?B?dElxWWYwUHJZNWpQVWVUekQyVVVRcG9LaCtHeHBNTXlKaVZNbFNQN0VqSllv?=
 =?utf-8?B?OFB3RXBBUlJWM1IxNGwzQ2RWaVlyRzlxN1p0bGhobFBONDBMSll6b20rNVZB?=
 =?utf-8?B?RFFMQXNFK0FGd1VtN1NyK05nck9yM0FmbHE2KzJjY0N4em0wWG1sMU0zZVZR?=
 =?utf-8?B?Zy8xMEZvczVsU2VXN243YURiTktQQms4STVraGtwNTJUbS84SlI0WEgwRjdv?=
 =?utf-8?Q?8rPiIhFvrjbcLFNLX558eI/6987/ML+pC9W44=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OERwOWE1SEYwTmR4VzMvL0FGV3k4dGFMQWI4RUNTMERQS2NFeDkwSlJuRFFx?=
 =?utf-8?B?YnhlUVhpdUt6Z2FQcmZBQ00rdzZiNHd6ZXplTEc5aDNTSkdJQUxhajg5QnB2?=
 =?utf-8?B?ejBXNC9UUE4vWlJISXZybVIyUDlMOE9DcTdodlNnSXdRNFpuakVZWXh5WW1l?=
 =?utf-8?B?aHFNYXpaQUx2LzRDZkxoVjB6aitHbEE3cWVXSm9meCtpcHZXMUNDRGpiRW5z?=
 =?utf-8?B?OVVZcHJVaFo2d1ErNXBNREZ3V2l2Q2hyWnFDQ3pndUZRM2dWcWhDd1FqcldF?=
 =?utf-8?B?WC9YcjFNb2lSSmZ5Z0pZUXJ1M0dENCsvQWYxcHFLZ3hsUEpieWswODUyVkJM?=
 =?utf-8?B?TCsxcXhMV3RhQXhHMXg4YzZqc29acEk3OGNQTHcwaUFtUG1ZbnVjSkNxMmFH?=
 =?utf-8?B?WnhoNk5WNWdaZGVRYjRYbkI4Tjc4YnZCU1lncXVkUS9ZUDNON3hUZ2c1blFW?=
 =?utf-8?B?TW1KaWVGUzBieEVwNkRjVEdnb3dDRWEzakd4ejhGR1ZManpOd3BCWC9JYUJy?=
 =?utf-8?B?UENEVGREdGk5NVR6dVV1emRNcWdicTJ5VnFadlhlWHViR1JDbkNlMEZrYnBE?=
 =?utf-8?B?MWljTkVVeWFLa3FqSStLbVRtOGxDTWJmdWkxVnhQcGVoa0QrNHlJTTB6NWVU?=
 =?utf-8?B?M2ZyT3lSaGhXUkcrNENkQ0J1UVlwSit5R21EbGQxeFkvcjFjS3F4cFMrYW03?=
 =?utf-8?B?ME5ZVWpsbkxxQ0VsVTd1QS9vbzVQTnU3RmhBL21nNW1wUkVTNmJxRENoMmZW?=
 =?utf-8?B?QkZPYnZoOEhuampIZWF6ajFUYUpVUExZQ3hMcW82eC9iMmlaTlkwSHVwNGU1?=
 =?utf-8?B?LzE1WjUxQmtiYTM0eFQrWFBFOFd4N3h4MHptM2E2VG13eVZOVzBWRWtXT3c5?=
 =?utf-8?B?Q3B3UGlMK2FiNnN3dHI0MWhia2x6ODNQQ3lMTlV3UkpmMlFWWGlqOXhUdi9p?=
 =?utf-8?B?MXZOckhxdVFFS21pNFVRZWZwNWRueEJNbVRpYmY2eGx4RThpd3hiclJyZExt?=
 =?utf-8?B?ZHlIYnFzRWtRUEZDRXpJMzlWU3BzcnpUQnZIV3dkaDVCS2RpdEVtbml5RTNH?=
 =?utf-8?B?Zm1Mdi8vdlVSWDRUU2ptR01wTU9wa292RkxHY0NwRUFNQjhVTWgzcW5nRm1L?=
 =?utf-8?B?Mlc5b1MvUkkwcUtIdHB5a1N4K2RQVzBDNGgycjB2QTNGbUU4WVJvWXZqcUpk?=
 =?utf-8?B?YXkzaHdpc0FBdTE2cXhRK29kdkRUc1JkWVo0N2Y3MlNJMmUxc0lrOHlSRzQw?=
 =?utf-8?B?dlJFdTJBUWlTWEx0c1B5TEVnd25Tak0zd3J4OEljc3ZSM3g3V0VrRFNwdlB5?=
 =?utf-8?B?NXFkd1pLWDlRb2MvS0dLcFZsbFA3Sk16clpydnMyaGIyUWxENjFaUGtkZWk3?=
 =?utf-8?B?dlEra1VuK1hDM0NFWUsrRkw3aFZ1clo0aktrQnV5YnVOYjFWa2k0ZFp5d1Mw?=
 =?utf-8?B?TmVSTStFdUFFa3F2UmlBRGFkaHY5NXZHbmREUU5GWUMzMFQxQnFDM1hkV01t?=
 =?utf-8?B?a3VaZU1QN3U0Zk4vdW1JMHQ1NXVKaXlRQ2QzUDFpV2NKaEx5aWlBYmZvUzlD?=
 =?utf-8?B?amJUaGNERHJkYzZ5cUVhSFF4MGlIcXlUN29odjZWQTVOWGRnZlBLWkF6T0lE?=
 =?utf-8?B?OWdmRlBZMW1NbmJqSnB2Q3FZZFF0MHFrUStsZUZVSjhFUmxiam5ST0V0WEgr?=
 =?utf-8?B?THR1VFpmdWMyVzM4R3Zsam4zd3VxN0dzZmZ4MzVuN2p0eG9zM0JNekpUbi94?=
 =?utf-8?B?VU5XTDZNallXRGJYbG9OTmpWZno2QjdtaG05bjRKSFMweDB1ZC9jZXdmRFpG?=
 =?utf-8?B?Vy9qTlNQYVdTQXROTmJMNWw5cko1Ny9MQitXRmhVd1FWUnBpVzUxTjdMU21j?=
 =?utf-8?B?M3pRTDllZ0VvMllWbThwbVVvY3d4L20vVUZhYUc2cEZrWmZtOWk2Uk42VGp5?=
 =?utf-8?B?dUliOGZLT2tzNitoQ2tGanVmY1FTQkdBVVNrR1BQaCtGRWNZK0p3Tnd5cnhL?=
 =?utf-8?B?NEZNUDdqZzBHSFg5SlBwMlBsQTRIekpSUHZIUnBKWGlxVHlKZ1A5eFhPcjJq?=
 =?utf-8?B?MWppNFh6MHpIL3lKNi9hUGhyS0lIdGdPcUJZcWdSWVdGMldTSXkrWFJKRHVU?=
 =?utf-8?Q?aZso=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9dc88b-cf6d-455c-b175-08dcfc75fb99
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 02:11:24.1894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H210X4ikXyF6uS3omGQeK1z98pOe0pd/brC5TwyReCNslJ3qfJBFtS1LaYMNtTJIIqOssozfKJJJ0ChKaZqYyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8021

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvc3VhIE1heWVyIDxqb3N1
YUBzb2xpZC1ydW4uY29tPg0KPiBTZW50OiAyMDI05bm0MTHmnIgx5pelIDE5OjQyDQo+IFRvOiBB
ZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47IEJvdWdoIENoZW4NCj4gPGhh
aWJvLmNoZW5AbnhwLmNvbT47IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPjsg
U2hhd24gR3VvDQo+IDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgU2FzY2hhIEhhdWVyIDxzLmhhdWVy
QHBlbmd1dHJvbml4LmRlPjsNCj4gUGVuZ3V0cm9uaXggS2VybmVsIFRlYW0gPGtlcm5lbEBwZW5n
dXRyb25peC5kZT47IEZhYmlvIEVzdGV2YW0NCj4gPGZlc3RldmFtQGdtYWlsLmNvbT4NCj4gQ2M6
IE1pa2hhaWwgQW5pa2luIDxtaWtoYWlsLmFuaWtpbkBzb2xpZC1ydW4uY29tPjsgSm9uIE5ldHRs
ZXRvbg0KPiA8am9uQHNvbGlkLXJ1bi5jb20+OyB5YXphbi5zaGhhZHkgPHlhemFuLnNoaGFkeUBz
b2xpZC1ydW4uY29tPjsgUmFiZWVoDQo+IEtob3VyeSA8cmFiZWVoQHNvbGlkLXJ1bi5jb20+OyBp
bXhAbGlzdHMubGludXguZGV2Ow0KPiBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBkbC1TMzIg
PFMzMkBueHAuY29tPjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBKb3N1YQ0KPiBNYXllciA8am9zdWFAc29saWQt
cnVuLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIHYzIDEvMl0gbW1jOiBob3N0OiBzZGhjaS1lc2Ro
Yy1pbXg6IGltcGxlbWVudCBlbW1jDQo+IGhhcmR3YXJlIHJlc2V0DQo+IA0KPiBOWFAgRVNESEMg
c3VwcG9ydHMgY29udHJvbCBvZiBuYXRpdmUgZW1tYyByZXNldCBzaWduYWwgd2hlbiBwaW5tdXgg
aXMgc2V0DQo+IGFjY29yZGluZ2x5LCB1c2luZyB1U0RIQ3hfU1lTX0NUUkwgcmVnaXN0ZXIgSVBQ
X1JTVF9OIGJpdC4NCj4gRG9jdW1lbnRhdGlvbiBpcyBhdmFpbGFibGUgaW4gTlhQIGkuTVg2USBS
ZWZlcmVuY2UgTWFudWFsLg0KPiANCj4gSW1wbGVtZW50IHRoZSBod19yZXNldCBmdW5jdGlvbiBp
biBzZGhjaV9vcHMgYXNzZXJ0aW5nIHJlc2V0IGZvciBhdCBsZWFzdCAxdXMNCj4gYW5kIHdhaXRp
bmcgYXQgbGVhc3QgMjAwdXMgYWZ0ZXIgZGVhc3NlcnRpb24uDQo+IExvd2VyIGJvdW5kcyBhcmUg
YmFzZWQgb246DQo+IEpFREVDIFN0YW5kYXJkIE5vLiA4NC1CNTEsIDYuMTUuMTAgSC9XIFJlc2V0
IE9wZXJhdGlvbiwgcGFnZSAxNTkuDQo+IFVwcGVyIGJvdW5kcyBhcmUgY2hvc2VuIGFsbG93aW5n
IGZsZXhpYmlsaXR5IHRvIHRoZSBzY2hlZHVsZXIuDQo+IA0KPiBUZXN0ZWQgb24gU29saWRSdW4g
aS5NWDhEWEwgU29NIHdpdGggYSBzY29wZSwgYW5kIGNvbmZpcm1lZCB0aGF0IGVNTUMgaXMNCj4g
c3RpbGwgYWNjZXNzaWJsZSBhZnRlciBib290Og0KPiAtIGVNTUMgZXh0Y3NkIGhhcyBSU1RfTl9G
VU5DVElPTj0weDAxDQo+IC0gc2RoYyBub2RlIGhhcyBjYXAtbW1jLWh3LXJlc2V0DQo+IC0gcGlu
bXV4IHNldCBmb3IgRU1NQzBfUkVTRVRfQg0KPiAtIExpbnV4IHY1LjE1DQoNClJldmlld2VkLWJ5
OiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQoNCkJlc3QgUmVnYXJkcw0KSGFpYm8g
Q2hlbg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9zdWEgTWF5ZXIgPGpvc3VhQHNvbGlkLXJ1bi5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYyB8IDEzICsr
KysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBiL2RyaXZl
cnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gaW5kZXgNCj4gOGYwYmM2ZGNhMmIwNDAy
ZmQyYTA2OTU5MDNjZjI2MWE1YjRlMTlkYy4uZjEwNmUyOTFjMjc2ZDBjODA2M2U5YWM1OQ0KPiBh
MTI2YWNmNWU5ZTIzOWUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNk
aGMtaW14LmMNCj4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBA
QCAtMzEsNiArMzEsNyBAQA0KPiAgI2luY2x1ZGUgImNxaGNpLmgiDQo+IA0KPiAgI2RlZmluZSBF
U0RIQ19TWVNfQ1RSTF9EVE9DVl9NQVNLCTB4MGYNCj4gKyNkZWZpbmUgRVNESENfU1lTX0NUUkxf
SVBQX1JTVF9OCUJJVCgyMykNCj4gICNkZWZpbmUJRVNESENfQ1RSTF9EM0NECQkJMHgwOA0KPiAg
I2RlZmluZSBFU0RIQ19CVVJTVF9MRU5fRU5fSU5DUgkJKDEgPDwgMjcpDQo+ICAvKiBWRU5ET1Ig
U1BFQyByZWdpc3RlciAqLw0KPiBAQCAtMTQwMiw2ICsxNDAzLDE3IEBAIHN0YXRpYyB1MzIgZXNk
aGNfY3FoY2lfaXJxKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LA0KPiB1MzIgaW50bWFzaykNCj4g
IAlyZXR1cm4gMDsNCj4gIH0NCj4gDQo+ICtzdGF0aWMgdm9pZCBlc2RoY19od19yZXNldChzdHJ1
Y3Qgc2RoY2lfaG9zdCAqaG9zdCkgew0KPiArCWVzZGhjX2NscnNldF9sZShob3N0LCBFU0RIQ19T
WVNfQ1RSTF9JUFBfUlNUX04sIDAsDQo+IEVTREhDX1NZU1RFTV9DT05UUk9MKTsNCj4gKwkvKiBl
TU1DIHNwZWMgcmVxdWlyZXMgbWluaW11bSAxdXMsIGhlcmUgZGVsYXkgYmV0d2VlbiAxLTEwdXMg
Ki8NCj4gKwl1c2xlZXBfcmFuZ2UoMSwgMTApOw0KPiArCWVzZGhjX2NscnNldF9sZShob3N0LCBF
U0RIQ19TWVNfQ1RSTF9JUFBfUlNUX04sDQo+ICsJCQlFU0RIQ19TWVNfQ1RSTF9JUFBfUlNUX04s
IEVTREhDX1NZU1RFTV9DT05UUk9MKTsNCj4gKwkvKiBlTU1DIHNwZWMgcmVxdWlyZXMgbWluaW11
bSAyMDB1cywgaGVyZSBkZWxheSBiZXR3ZWVuIDIwMC0zMDB1cyAqLw0KPiArCXVzbGVlcF9yYW5n
ZSgyMDAsIDMwMCk7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBzdHJ1Y3Qgc2RoY2lfb3BzIHNkaGNp
X2VzZGhjX29wcyA9IHsNCj4gIAkucmVhZF9sID0gZXNkaGNfcmVhZGxfbGUsDQo+ICAJLnJlYWRf
dyA9IGVzZGhjX3JlYWR3X2xlLA0KPiBAQCAtMTQyMCw2ICsxNDMyLDcgQEAgc3RhdGljIHN0cnVj
dCBzZGhjaV9vcHMgc2RoY2lfZXNkaGNfb3BzID0gew0KPiAgCS5yZXNldCA9IGVzZGhjX3Jlc2V0
LA0KPiAgCS5pcnEgPSBlc2RoY19jcWhjaV9pcnEsDQo+ICAJLmR1bXBfdmVuZG9yX3JlZ3MgPSBl
c2RoY19kdW1wX2RlYnVnX3JlZ3MsDQo+ICsJLmh3X3Jlc2V0ID0gZXNkaGNfaHdfcmVzZXQsDQo+
ICB9Ow0KPiANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2RoY2lfcGx0Zm1fZGF0YSBzZGhjaV9l
c2RoY19pbXhfcGRhdGEgPSB7DQo+IA0KPiAtLQ0KPiAyLjQzLjANCg0K
