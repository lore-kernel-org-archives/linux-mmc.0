Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A65BA45;
	Mon,  9 Dec 2024 02:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733711864; cv=fail; b=F1jBBAbHB5ZKwikeHLx2sRMc3+mRNmPths99cSh/63xuPZcUQ57v8g3MErcjmSnf9sC2csEQnCKLyPtt6im+Ym5kWZ1Y3dB6DGZs2GhbvFkxH2J1cGisRGiS5TGACjxgCrRiMOmpVOFmc+ugmUPdaafpP9v/szUTgHJ79XaEykI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733711864; c=relaxed/simple;
	bh=yzUllefCTkqJqPvZBJnPiqeWckAaDqlOCmdQ+hQEo8Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rgj6sFQ2NYNmSnFPnTZET9MV7jk+FG66ErumaclIWpe2Ylva2nYq393imiKyTINWiB7Qws73JZLYgxowWNqTGpJN5Ok8itDHP9IQjQp8f3NTPfspU/a0PRB/Xw0rujHJwyFCHVOT8y56khNVu0n09ie09cNIHFccYUy0KbtaPJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=m14qrbNf; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="m14qrbNf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CjK+eMOpz+Bc8WBkGMyswQMQMT2lAUZHnAAUhJZlk0KiVEJJ7msRHPJ84j3ETPBsYXImAja26na9rnpwAe0vepgdxRY93I3rmvmzTz093OidXUhw2Sz4Lr+nZEyI2KehIy3RAps8ykFw9EJWGufUhM2iWfc76UfqheHd2QgQkJNWU6if8Eycv7IbkFmfNk76qNUS+/+oYRN9lLVUMqaCaTo9KSWG25EJJSVh6VkhKbDO4Ud75Q0+VUKUI/r302mzXEiIRQRd+Poy70Hxqa9jiWIyz+PSCVSZYOfXmYHU08uyHo4SLQ6WcYwKLODtJ6eSIuSLTTaL/miPykulHudYIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzUllefCTkqJqPvZBJnPiqeWckAaDqlOCmdQ+hQEo8Y=;
 b=TApN3zT3rWCwyOtJ6Vzr3Kvyx4CgfEwyxiLL/KTgnHXcsgwQyYxh/f3Gd0fVnPNriDLORTsgp+nwFNt//98fJZGhMam1nvQRWM2Mz1qOD+ieMEMARXHPFjZ9H+DqbWGBWRjUAWthU9R+rLzIcIYyQB4doqAcTqAi4DCNDlKe3lXibKhZnk+Nj/eekkIgASMEx65M0v+PUuakfE9ZHY/e/Ax3l56v33phEZ8+zqjCTOG6PuNwVSmkREA5I02mVMgbT4lhz2lFgrkhyCaieMjGQjU47fx9vN1PrsxHa/07AXNGuXDOq9riS121zmeLsrALxmxiXrK/wVJUu4JY+uUK6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzUllefCTkqJqPvZBJnPiqeWckAaDqlOCmdQ+hQEo8Y=;
 b=m14qrbNff/dSt8OfrzxnjA9UM4LWm8eO5ITFH+A+YS+qyrsujEANwilSe1TQ+ATB/gmjt5GEqdoWwWc7KMFDUaoiuZmn8nY24iPJD/s8xqNBGFYUaZzvn/maCzrWvqCXzS0pP9Olwr26Cn6u0ivylY5gH++Tl2kSu6fYfyvj6C1ATy0BNBp6vVtS8k2LPfFNozc1E4gn4ZXYuaWbhUcDZfF7mGINUzwZEAiCgAgsIsaaTS39gCUXL6wx/Kgmk06KBCVkX0sV8nbBgZbSRVhBOZKjX2xJDXv0scmoV22VchSDlv6pa+as9WTpjTmorewBnfWnSbXHrlxSno/p0eX93Q==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by DM4PR11MB7400.namprd11.prod.outlook.com (2603:10b6:8:100::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 02:37:37 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%4]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 02:37:37 +0000
From: <Dharma.B@microchip.com>
To: <conor@kernel.org>
CC: <ulf.hansson@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<Aubin.Constans@microchip.com>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: mmc: atmel,hsmci: Convert to json schema
Thread-Topic: [PATCH] dt-bindings: mmc: atmel,hsmci: Convert to json schema
Thread-Index: AQHbRvwf3qgInoB0eU2XMIzej7Xo6rLX7RUAgADA/oCAAMVQgIADxUKA
Date: Mon, 9 Dec 2024 02:37:37 +0000
Message-ID: <cc15c9de-4cf8-44e3-976a-936bf16b7ab2@microchip.com>
References: <20241205-hsmci-v1-1-5a25e622dfed@microchip.com>
 <20241205-trickster-rebate-d5e64bc29992@spud>
 <4e3a4154-9e05-40b4-961f-6d7e95ec0890@microchip.com>
 <20241206-untoasted-ripening-83ecf98bc42f@spud>
In-Reply-To: <20241206-untoasted-ripening-83ecf98bc42f@spud>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|DM4PR11MB7400:EE_
x-ms-office365-filtering-correlation-id: 27c04856-b03c-49e9-7be1-08dd17fa71b9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RkIvRHJUODc0eG43bGRzK3VVaTNueVRWTXlhcTVTeE5Dd1RBL2hTRyt0eEpC?=
 =?utf-8?B?bmtlSmVHTzJSWkh3NVdLb0Vqc1pLWFZkSFdCb25VTERIS2tVVTV6OXo2cE9v?=
 =?utf-8?B?SS9Vb09LaVRMZ1JNaGtJcUxLdlluMXVRM3NjK2c1UVJNVlFrQ1FqT3ZxalVa?=
 =?utf-8?B?RnFKT2dPaDByMXZBdzZpVWpRT1YyMmthVzRyTmYyZ2t4Nk9YaHZyOE1jTnFo?=
 =?utf-8?B?WVJhNHdnWUs3VUhNV3lBdWdLcHg5K0J3WlFaMWxVVmdaU1NuTXZXTHZHSVZ0?=
 =?utf-8?B?OUU5SC9VckltZUVZOG1PMzd2WUxtRkpWRlBTSUhsbGZJRFBQdjFFcXk3aWEv?=
 =?utf-8?B?azFaSks4R3ZINjdQaXhSWFY2R3NkSlFsM0xnakdneTgzRmphVnJtcVF3YlpX?=
 =?utf-8?B?M1ppazZ3N2dYYlNZRFFoMGlGTi93NjdiWkhhVzNKRjRJSVpnRHpYWVo2T214?=
 =?utf-8?B?TmZPc2c1T2N0dExhQlA4Z0o5QnJ2WEp5c3FDRTdhK3VWZ0NYSWcwRVBuTUNC?=
 =?utf-8?B?K1kzQWQ4MjZKRTVscklBaWN6VFZJUVpFMUFlNHo2WDVWaXFJeHkxaEMyYmxy?=
 =?utf-8?B?L3RaOEo1Z254bURpaXlIYXJZMXdLMnhaMWNZUFdSTHlDMW0zMnN2NDI0Tm9O?=
 =?utf-8?B?OXBtTGZ3c0N1eDdHMklKb1VuVEExb3NuZWltekh4dHpsbWM2dThvSUxPR01R?=
 =?utf-8?B?WVVRQ2xweTBFVnluV1o1NThTOFhuVEtJakxCemg4MWhBeUl0VVRGZ2w4Z09n?=
 =?utf-8?B?KzVLR3VxZXIxVjJuZHZPY3hvMWQxYVV5QmFBSGMwRXZVZlZtNmxZZThUdk14?=
 =?utf-8?B?N3VNOVZuNmZwcVZlb1VDaTFiSmgxays3dHlCeWRTeXlxL3MyL0JpSVRFSlhU?=
 =?utf-8?B?TG1JRGpoVTNtOS9UVFRwTGZHajR2QnA1ZnQ3Qnl6dnp3OUhJbVdYYzFzNDFX?=
 =?utf-8?B?c0llb2hVK0RBOHNzWWFDRDJEUW9ScXFTWXFZK0pwMXE0K2Z2T0FaZzV6Tk5R?=
 =?utf-8?B?c0ROV0hlRjNsR0pEdWx4RWZGZ0NWKzcrUXhLQlVpUWJsWXdPWUNoWUNhK2tI?=
 =?utf-8?B?TFhiTjdjZ2RmWVkvTXVIUTlxaHhxYVFmaTVkelVndHBrSHFJd0xCOTdHbWxD?=
 =?utf-8?B?YnV3b00yaWY4d0xrVzhjbHl2dzM4d2ppaFdtamthTDJBR3VqUVV1UXk2enY2?=
 =?utf-8?B?U3I4K0tHRnZTZ01lWGNLQk1SbVg3U1VoaTNuSEc1aDIxQ1owckt6L3pzWjJV?=
 =?utf-8?B?b0RWQk1ENk5HU0dIMXBsNkx3Q2hBZjdJd1lVa3kyVUhtYTRkRys3SHA4Qllh?=
 =?utf-8?B?QjhHWnZ4R0VOODBnS2ZRZ1BuczFwSUpieDF3eXN3c0p1NzNYUDY1Qzh2UEZO?=
 =?utf-8?B?dFdnNERXVG1ubFhQT0xiMU9UeWx4K2FMbktYbFgvYWJuQlcvY29QdHNQd2E2?=
 =?utf-8?B?VU5BMjVXUTZSN3BPc2RDK3BUaDE0WGpFdXVsUU5UTXZPU2RQeURreUsxb01V?=
 =?utf-8?B?WFZrd0VVZDhtcjZuR3JubzdaaFFjNzVFTzlLRUs1VGtRd25JbTBqbzcwRFBT?=
 =?utf-8?B?WGFKYTlBeDFXRVp3bVU5VDlwditNb2ZUM29LT1J3QmZucTVZUVJzdFlzQXk4?=
 =?utf-8?B?WEN0N1BBQVVNTENvUmJkMkxmWGV2ZXBWNlFGZ0plTS91bXkrV2EyMjlndi9h?=
 =?utf-8?B?OEI2TER1ZzU1UFBmeU5jcm5MT2lqdnZ2NnJ1N1cxT2NwVlVobnNybzlLVCtq?=
 =?utf-8?B?NmZZMTFaSWdCVDZkbHRDaVFMc2I2WkVKVkRmRmlrb1crbkR3MC9VRVNZcisv?=
 =?utf-8?B?Q29kOWRmSzMzMm9qL1VWaUJCTHEyQllVb1cvQlEvd25zdXFnL0cvaWhUQ29Z?=
 =?utf-8?B?dithTnZRS1hzWWVFbStVb3JKVExGSDRXN0hzNGNDc1g0c3c9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MUthOS9HSGpOeEswSnhWK1FoYzBSZmtWZS9xMThWZnRnYzNuZThLUzhNeVRJ?=
 =?utf-8?B?S0FaMVVpbE9JL1lnT2Jrb3BhcGRsb0l1a3IvZEFtM0x4SEJGcEFxU3pCNThx?=
 =?utf-8?B?RzlyRnYyRFlPdEt6SGNFeFE5bDFvK3hCV2FLTnduVlVFN3pGQTdQRjMrR2tW?=
 =?utf-8?B?Wityd0cyUStRRFI5OGFwMzZ2NXYrL1d4dmtBN2l0TmdiMUZtTU1yT0xkZC9s?=
 =?utf-8?B?WHVWNnZ0K01CTU9PM2hmMFc1Rmp5S21RMGJ4Nk1ScDRqSWRaY2xZR3NVaUVR?=
 =?utf-8?B?cUJxRExtS09rVmhMSkNtaFB6RHNGcksvWXZidzdzNWl6TlNqSWw1d0FiQTRl?=
 =?utf-8?B?bS9OS05DMXI4eFI1b0twSWRGUFFXaUJVdFNwQ2lsbHExejZtRGE5eGVydi9M?=
 =?utf-8?B?SXI2SjBLOVA2cHdQTWZxYWxvSFdDY2VHWUc2WFFqamdoclFEVmwwMk1vcHBs?=
 =?utf-8?B?S2lWblRTQVpDZ0JnajB0SUp2V0UrNG5NRVhKaGlvWk9zTFJIWTZrUmdWQ2p1?=
 =?utf-8?B?dSsxRFdJQzladDI5Y2g3OXNPT0ExeXY0OFhKZlRNVGdlam5VY1QvSWo3QVBU?=
 =?utf-8?B?Z3BpVmlFdmtOZUgzTUdEc2JwU0tHMzFPMFA2U3IrY0tZMG5WMGN4UEZvZ00w?=
 =?utf-8?B?WEtwbFNLVDk3VDREa2daL29DWXQwUElIU25CMStXc29jNU4zMnV1NC9scTVL?=
 =?utf-8?B?MzZWTnlxRFZLNm1DNDdyL1I1alF0TnJlL1RHTlExUG1jL00yNVJadkxETUNw?=
 =?utf-8?B?M2RsRk1FUHBLNWVjWnh4VkgzSmNrRXpQYjB3QVdYVC9TQ3M0d2ZMV3puNkFk?=
 =?utf-8?B?ZzlnU1B6TWhOKy9VOVRxWVlEUkpYK01LQ00vUStCWGZoS0NiQ0NCcy9TTjJI?=
 =?utf-8?B?MTh3VkFzSGFaS200NXVWcHVhOWFGc1VTb21GeFF4UWh2amxZSytJcnphUG9N?=
 =?utf-8?B?azdFYTlzTEc4amhTT1NqMHRhbXRPaGFiN0RLejJnbmpzQXU5NUFWRzNhd2hV?=
 =?utf-8?B?alpUOGVpL3UwRDRVRUYxQ0JrWVRxQi9lVkdVTHpvRkFhRi9sbUxYTFBFZGhK?=
 =?utf-8?B?MFkraDdyelU4ZWJiY2t6Yk1PeXZjbUJ4MnVzNG1JQ2VCUCtRN0ozM3RuQkMz?=
 =?utf-8?B?ajQ1QmNJeEMxTzc5QVRxMlhXcVlWUGhkWVpNdm9nM3NnVmlVNGJ1dkFzYllF?=
 =?utf-8?B?MUVDNjEzNmd1R05OeGZBN1ZCRHU3WDBiTGZFUFJRb3ozKzhOMDI4bkhya3Fu?=
 =?utf-8?B?Nm1yNlN4eE85SDF4eG1XZnBpNjdHM3hNZTg0MlhCRWpDR2xyMlRvRGRwRkpE?=
 =?utf-8?B?N0swRWt3b2VUemhOU0Q5VEVxcURJSjcrWGl0S0VMSUV0UXdQN1hiV1pSVlJB?=
 =?utf-8?B?KzEzcEQwT2gwQUg1ZnpKZGJ2aVlRcmNjSGJCTU9iQjBBakRqcnhjUTB5NjYv?=
 =?utf-8?B?QjF3VldsWlFrQmFoTm1zUy9xV05pT3paVlphZ211VzN4OTNjTk9mVzcyN0Fi?=
 =?utf-8?B?NXZRQ00xeFlueDNLWm1mNDF1Mm9hUnVtd0owdGZSQUtFZFpiL3Q1bVNKUVlT?=
 =?utf-8?B?UFNCZ05la0hHc2Q5ZGNvRmJmRUtFZC9UMitiZFd3azY1c3kwUjNzNzZZbEZ5?=
 =?utf-8?B?L2t0dVFybzBBYk81ckJxcnlrWnpjcDZJK29xa0o2L1RnRmxlNUZnTjRMU3U2?=
 =?utf-8?B?WEVwYVdtdTVDYm5iN2wyL1NYVGQvSXF4WTRtUGZXRE9lVVN1aXdmNnR3R1pn?=
 =?utf-8?B?bW9HYTRlbFlOTHhIMmwwMWJiQnZrcFM5alJLaHVZRXBqSjJFT3NWeUZ4V2Vy?=
 =?utf-8?B?UG94cVIvMWZLaTJlcytJdFVibURuOGVacG9lRERNUWV2VkFYNCtzT3pzTjU5?=
 =?utf-8?B?OTNSNzVGT2VoTGdDZncrbUpiTVhCb3FpU0FOSW5jSjBDYzN1SWtFWFk0VU10?=
 =?utf-8?B?c2NsKzNYamNnVXAzZGI3L2ZlNXhNOEVhZ25LeFdJRFNKWGlDSnFNOGVLZE1v?=
 =?utf-8?B?T2VwV2MwOU91TnBhcTBDai9QQThkdlFHTjg3bWZ1MEdxVXlGcXN2Wm1XaFhK?=
 =?utf-8?B?L0pQUTFQeWduenU4RTUrcXo0dHV6aE05ZERBS3ZhdHZMR3krNEd5OUFsVHVy?=
 =?utf-8?Q?lnI6b+FGOzP9GoxoOG5xKhP5L?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <397EF4151E2EAC4F9861475AC6E28DB5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c04856-b03c-49e9-7be1-08dd17fa71b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 02:37:37.3500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lEO/BJSl8G5X0E3ppYByNuTRopeClPYRPYmrwUBpIzxLcA+o5EabxDS7wQyeGUDDdtlE/PvFH+RzT0eZx8QGvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7400

T24gMDYvMTIvMjQgMTA6MzIgcG0sIENvbm9yIERvb2xleSB3cm90ZToNCj4gDQo+IE9uIEZyaSwg
RGVjIDA2LCAyMDI0IGF0IDA1OjE2OjM5QU0gKzAwMDAsRGhhcm1hLkJAbWljcm9jaGlwLmNvbSB3
cm90ZToNCj4+IEhpIENvbm9yLA0KPj4NCj4+IE9uIDA1LzEyLzI0IDExOjE1IHBtLCBDb25vciBE
b29sZXkgd3JvdGU6DQo+Pj4gT24gVGh1LCBEZWMgMDUsIDIwMjQgYXQgMDM6Mjc6MDJQTSArMDUz
MCwgRGhhcm1hIEJhbGFzdWJpcmFtYW5pIHdyb3RlOg0KPj4+DQo+Pj4+ICtwYXR0ZXJuUHJvcGVy
dGllczoNCj4+Pj4gKyAgIl5zbG90QFswLTldKyQiOg0KPj4+PiArICAgIHR5cGU6IG9iamVjdA0K
Pj4+PiArICAgIGRlc2NyaXB0aW9uOiBBIHNsb3Qgbm9kZSByZXByZXNlbnRpbmcgYW4gTU1DLCBT
RCwgb3IgU0RJTyBzbG90Lg0KPj4+PiArDQo+Pj4+ICsgICAgYWxsT2Y6DQo+Pj4+ICsgICAgICAt
ICRyZWY6IG1tYy1jb250cm9sbGVyLnlhbWwNCj4+Pj4gKw0KPj4+PiArICAgIHByb3BlcnRpZXM6
DQo+Pj4+ICsgICAgICByZWc6DQo+Pj4+ICsgICAgICAgIGRlc2NyaXB0aW9uOiBTbG90IElELg0K
Pj4+PiArICAgICAgICBtaW5pbXVtOiAwDQo+Pj4+ICsNCj4+Pj4gKyAgICAgIGJ1cy13aWR0aDoN
Cj4+Pj4gKyAgICAgICAgZGVzY3JpcHRpb246IE51bWJlciBvZiBkYXRhIGxpbmVzIGNvbm5lY3Rl
ZCB0byB0aGUgY29udHJvbGxlci4NCj4+Pj4gKyAgICAgICAgZW51bTogWzEsIDQsIDhdDQo+Pj4+
ICsNCj4+Pj4gKyAgICAgIGNkLWdwaW9zOg0KPj4+PiArICAgICAgICBkZXNjcmlwdGlvbjogR1BJ
TyB1c2VkIGZvciBjYXJkIGRldGVjdGlvbi4NCj4+Pj4gKw0KPj4+PiArICAgICAgY2QtaW52ZXJ0
ZWQ6DQo+Pj4+ICsgICAgICAgIHR5cGU6IGJvb2xlYW4NCj4+PiBUaGlzIHR5cGUgY29uZmxpY3Rz
IHdpdGggbW1jLWNvbnRyb2xsZXIueWFtbCwgaXQncyBhIGZsYWcgdGhlcmUuDQo+PiBZZXMsIEkg
b3Zlcmxvb2tlZCBpdC4gSSdsbCBzaW1wbHkgcmVtb3ZlIHRoZSB0eXBlIGhlcmUuDQo+Pg0KPj4+
PiArICAgICAgICBkZXNjcmlwdGlvbjogSW52ZXJ0cyB0aGUgdmFsdWUgb2YgdGhlIGNhcmQgZGV0
ZWN0aW9uIEdQSU8uDQo+Pj4+ICsNCj4+Pj4gKyAgICAgIHdwLWdwaW9zOg0KPj4+PiArICAgICAg
ICBkZXNjcmlwdGlvbjogR1BJTyB1c2VkIGZvciB3cml0ZSBwcm90ZWN0aW9uLg0KPj4+PiArDQo+
Pj4+ICsgICAgcmVxdWlyZWQ6DQo+Pj4+ICsgICAgICAtIHJlZw0KPj4+PiArICAgICAgLSBidXMt
d2lkdGgNCj4+Pj4gKw0KPj4+PiArICAgIHVuZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2UNCj4+
PiBEbyB5b3UgbWVhbiBhZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UgaGVyZT8gWW91IGxpc3Rl
ZCBwcm9wZXJ0aWVzDQo+Pj4gY29udGFpbmVkIGluIG1tYy1jb250cm9sbGVyLnlhbWwgd2hpY2gg
bWFrZXMgaXQgc2VlbSBsaWtlIHlvdSdyZQ0KPj4+IHJlc3RyaWN0aW5nIHRvIHRoaXMgc3Vic2V0
IHJhdGhlciB0aGFuIGFsbG93aW5nIGFsbCBwcm9wZXJ0aWVzIC0gYnV0IHlvdQ0KPj4+IG5lZWQg
YWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlIHRvIGRvIHRoYXQuDQo+PiBObywgSSdtIG5vdCBy
ZXN0cmljdGluZyB0aGUgcHJvcGVydGllcyB0byB0aGlzIHN1YnNldC4gVGhlcmUgYXJlDQo+PiBh
ZGRpdGlvbmFsIHByb3BlcnRpZXMsIHN1Y2ggYXMgIm5vbi1yZW1vdmFibGUsIiAiYnJva2VuLWNk
LCIgYW5kDQo+PiAiZGlzYWJsZS13cCwiIHRoYXQgYXJlIHVzZWQgaW4gb3VyIERUUyBmaWxlcyBi
dXQgYXJlIG5vdCBkZWZpbmVkIGluIHRoZQ0KPj4gb2xkIHRleHQgYmluZGluZ3MuIEZvciB0aGlz
IHJlYXNvbiwgSSB1c2VkIGB1bmV2YWx1YXRlZFByb3BlcnRpZXM6DQo+PiBmYWxzZWAgaW5zdGVh
ZCBvZiBgYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlYC4NCj4+IExldCBtZSBrbm93IGlmIGFu
DQo+PiBgYWxsT2ZgIHJlZmVyZW5jZSB0byBgbW1jLWNvbnRyb2xsZXJgIGFsb25lIHdvdWxkIGJl
IHN1ZmZpY2llbnQgaW4gdGhpcw0KPj4gY29udGV4dC4NCj4gWWVzLCB0aGVyZSdzIG5vIHBvaW50
IGR1cGxpY2F0aW5nIHByb3BlcnRpZXMgZnJvbSB0aGVyZSwgdW5sZXNzIHlvdSdyZQ0KPiByZXN0
cmljdGluZyB0byBhIHN1YnNldC4gSSB0aGluayBhbGwgeW91IG5lZWQgdG8ga2VlcCAob3RoZXIg
dGhhbiB0aGUNCj4gcmVmZXJlbmNlKSBpcyB0aGUgcmVxdWlyZWQgcHJvcGVydGllcyBsaXN0IGJl
Y2F1c2UgdGhlcmUgc2VlbXMgdG8gYmUNCj4gbm9uZSBpbiBtbWMtY29udHJvbGxlci55YW1sLg0K
DQpTdXJlLCBJIHdpbGwgdXBkYXRlIHRoZSBiaW5kaW5nIGFuZCB3aWxsIHNlbmQgYSB2Mi4NClRo
YW5rcy4NCg0KLS0gDQpXaXRoIEJlc3QgUmVnYXJkcywNCkRoYXJtYSBCLg0K
