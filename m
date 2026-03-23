Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011044.outbound.protection.outlook.com [52.101.70.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11C518FC97;
	Mon, 23 Mar 2026 02:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774233523; cv=fail; b=ujWADvpE0I0DKht05Kg66ZaAweoN9B8AAHHF09DZgr2r1Tw8PcpTsw0797h/NrCEcD3iNfrxwlu6znan2PTGpa9ln9mj1LwRofYe+Y3LzcXixZm+HMSP4kz6TKl7qJsgprXLNwX2WrPs5GxsGmwfxtchQwiej4V2YTZ0WsoEffk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774233523; c=relaxed/simple;
	bh=qqMLHVPglfJng2V/cpB019KN90m5OUala1Ull5EnKE8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U+d1jDj5GxfPdejKUPbkm9PB7mJFIFV2qd2ifVo8DxdAUTD1E1TkTpKI5Q8hn3+/0kPIcdaHFh5XuEqejki6l+wgbaEob23vMACMdf0W6sdDJGVR2i/PFs+hyyJQav8P6Rsw6vUgq4MkLTrFvQIvxteScqcA5M1lNToGR+4NIB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DfLUmDwO; arc=fail smtp.client-ip=52.101.70.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DfLUmDwO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ep5Q9y989PjN9H+UyaIpHSMUKArsVbtM5u7V5Pt8prV0WDXNWL5vK+pxJKFZfw1eMwVBmpST0bOsuM4kJ6ouzfU4BEOJlhKaa64SgXxTrwavJA8dC8LtBLiaDVmuB87oPTTTdomhkjX8dgD9u8ycbe7LIEA3gmSDMB/eYe/9dB/jIMR2NJZ/I/htmxeWYX0eExumzS3NOiyh2Kq0B0m7le3QYgVnYYYiWeqmxFEiYXKFpbi1DUNGW3sNupA651VOYn9vz3mAVDrgVNXumFXYdxKpFoslnQQZ9pRafugKtd9HV6FzxGBJQTbJ5PJViNlOGbjHduEtbROSqtiHQvNyYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqMLHVPglfJng2V/cpB019KN90m5OUala1Ull5EnKE8=;
 b=ksNMxyeAntKlQ3llvHzrNEiRrRYQbyJyUF/EzgU6M5O5SP5i74FP0CQDfhL4v5CKxKaGpdJ2boFF7TjAeS2EWGzr+EWupZQcoCv8SLika4d9lNr9SRn6G+YGwlDpSB/bIlzc2axDt7DxntALa77Oufe3HlKxax3Er4riz5eyytOYeh2ePMzIoCtswOzkrtR6TFmEdTZMkcjIY/NWcSbQDcBibYLP21natpxEzVCT8GyITTLI3T2iVkIjVfS5zd5jaWyJiYZ25EnJ/gqJiJylApvwt5T+bb+4+epD/3kTkxSyNJObk5UTZEwlT+eKF1YDkdIi173PzVZOboHrXkzuXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqMLHVPglfJng2V/cpB019KN90m5OUala1Ull5EnKE8=;
 b=DfLUmDwOIfuFUg8tOfUTzaTU6B5bc82Lwo4in5JAkvycuZwqrL1Yad3v1/tQshteLN2VW76W0O3FzLqiBR7t5EqaWDxDdwoVj0Owzyo7Mae0rRrE0VAolDWFkMziQsQlWStAnSvJhIIBKeaDG4W+xmmySGD+97zho20Pulwd/If73AmXaq8i6u3xAcNVHiN4q21nmqcx7O6gn2Ri5b32uNs6G+X9OEROXo2+u41wZnXdBxsbcLcbd6fpA6xBg47NIFJU/J5XHiCQxwo7KtRQHcLI77iBE2Khf/jsiaX4EeLCG/KoO11LJV1SpikLdBSArOpuOYX+ZbKSiqt6VyrzqQ==
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by AM9PR04MB8794.eurprd04.prod.outlook.com (2603:10a6:20b:409::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 23 Mar
 2026 02:38:36 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%6]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 02:38:26 +0000
From: Luke Wang <ziniu.wang_1@nxp.com>
To: Fabio Estevam <festevam@gmail.com>,
	=?utf-8?B?QWRyacOhbiBHYXJjw61hIENhc2Fkbw==?= <adriangarciacasado42@gmail.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>, Bough Chen <haibo.chen@nxp.com>,
	Frank Li <frank.li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Miguel Ojeda
	<miguel.ojeda.sandonis@gmail.com>
Subject: RE: Re: [PATCH v8 3/3] mmc: sdhci-esdhc-imx: remove redundant mx25
 handling and consolidate soc data
Thread-Topic: Re: [PATCH v8 3/3] mmc: sdhci-esdhc-imx: remove redundant mx25
 handling and consolidate soc data
Thread-Index: AQHcum4gUY/JdolWhE+eDSAwTQVUgw==
Date: Mon, 23 Mar 2026 02:38:26 +0000
Message-ID:
 <DU2PR04MB8567934E6CAB063DE5CA0F3AED4BA@DU2PR04MB8567.eurprd04.prod.outlook.com>
References: <20260319200945.23333-1-adriangarciacasado42@gmail.com>
 <CAOMZO5DcaucpKj2=gO5kP3vd=f==ydzB+3FbGB4Jwg19Vi8fpg@mail.gmail.com>
In-Reply-To:
 <CAOMZO5DcaucpKj2=gO5kP3vd=f==ydzB+3FbGB4Jwg19Vi8fpg@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8567:EE_|AM9PR04MB8794:EE_
x-ms-office365-filtering-correlation-id: cc4dc8a6-4739-48c4-f6e4-08de888542d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 iGFL5/6InWj55pMq2cPa5ahCJCrYXRuBZ7aWACKAY3xifvnk07E6Hlmod/CX26V7TYChk6wybMVaIBuEKcFqQs6GI3RLYuz+z/wL8wXxySy6rRnoZT+cSmgztiiu0f4c8+hhbZOxpiKCVGwDiE+NGzC0JdPPIsKa7PHJCQ1nyZMD1yAgT3gbV3IwjJjj7KO8bK4T7NklHq/KQDf/c3M6exY+DnCLU4yGozb+XCxS1yHFSaFcmxL5S2WF22mLz78cfbz9FXVZDfbobThm+lYkrhc+P+ynOVwLJgxVer3uA4/qRO7L2Fj2C9j5DBfLKmf/93n33k36OeH9uua1BJaRpYy4XuzkQno/8LHB+Jx6hOwVnJaAzsOKL5YNeoQNUrkfaEaPYaN+WSaDe8EkhjsY/dE6Lmuvq7TlFw0L0UTbRp3iKCM/GhXOnn5H55tkh0PzWZxVRdJFsqeGc2ykjxzNxzoR/SJ8QI3LPHVBJt3eKU1E9PTfNp8UQPyDudQCPfCDr69n4ZrtXvMwQh913ytNkTS3qqs9B+o2G48wSOv/futgFyV0iXeuU3lKQE66tJiERnrto0fcRSoKfYikWK1XaJtNRwwM2t/6uO0mPQUH9sJTfTK2hH5wX5hepauS3QI1lhDFVb99WkRa6YN3GrGbrXFBmjCKeJ4LrbBUcqESPMtczc3OIi/xYofxWKKtaCwexnjtrbtRHtyCcdzyAckO+kaMoFaUe2hfyRhfYQYF1F6ylU4to9f/w8gqfTtipDYyvZcZv8KmzFhBzHX4/vQrXmu5dl4hpXnEJK8TqQ/pans=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N3ZZWHFhNm54MXJYRmF4NEdtTzBEanRYRDU3allrQ2l0ZkxkQnNTTURDbllK?=
 =?utf-8?B?QmN0YWREZnphRDBENTh3dDNyU0pwQmdlR2Jmai9DaWVWVGdBUmZjd2dBVDho?=
 =?utf-8?B?QmRKc1RTaE5wWWRvdnZkRHZkaFVzcWRYeGhuU2lINXRNTDg3c2Q0ajJkVDIx?=
 =?utf-8?B?ekNSMzhrZ1dEVEp5OFdNQWErVjEyVUhjbXJPYkJpOVdteW13ZEJSYVM3MUdL?=
 =?utf-8?B?eFVRWGdkQXV0WHFFYjZDNC94RXdBcmpXY20vSnZocThXZGVXTkk5U0xWY0xS?=
 =?utf-8?B?TXVIamhNaFZRamt6Q2FrNzNQSEJaY1VNcWlneUgzS0FnNi9kem9lU05RWE1X?=
 =?utf-8?B?NWM5VUdqZWpBTzkrSzMzeTdFblFCd0IyWnFSUExCaDl5NmxnbmNFOWRwRDdy?=
 =?utf-8?B?UGJva2ZGNys4bE1MOGF6Mk5uYnNLUHpSV2dmcWpaTy9WdnhQSENIcFYvN2Zp?=
 =?utf-8?B?TFNjeU9UZkNFN296clpZV3p3WTN4dFVzOXFtd2tLdnNhZFBXV0dRUERuUWY2?=
 =?utf-8?B?cGN2VHBkUUUzNndCc2lRcVAwRW9BWlk4OEJkcHE5QWE4QUpkNzZLdmdWZWtM?=
 =?utf-8?B?NzhRVlQrMFM3WHkvNXNnbWQwdHpRSFM5bWNMd2hiOGV0TlJVRWhvN09FcnIw?=
 =?utf-8?B?UVMvdUxtNjV3emxiQU1jTUV2VHRtY0ZKaHFKbFU2dXo3bkx4VGMrK0U4ZHdV?=
 =?utf-8?B?cXgxNlpjTzhCdUpQQ2lRaXpsZlRxekNjb0RmNE5rU0pHT01DcGNlZmNyYnI2?=
 =?utf-8?B?bVdHQXV3WXVDS0FDcExUVTNCUFUxNnkwNlRTWTAvSVA1K2F0RGQ5VlZkWjc3?=
 =?utf-8?B?M3Z0VTdvTnRnTkNmTWY2UFZJeXhpdERtMjY1SzBxNVRZRGVvUzZtMCszT25s?=
 =?utf-8?B?Zy9TWGxxeWxWdnFZUjJWTnlwRDBTMWFjb0NNZnVHbmJBbDBvdTdhdW5PVGdC?=
 =?utf-8?B?Y1Y3UDdTMDVSbDJZTFlMeDNUeDNRbkwwckRKNFlPTG5LK0pwTTdwR2hiTFhE?=
 =?utf-8?B?VitQQnRyS3I2T21wWGV4dndmd2Zyb0h3OWF6UjM4bDhOY2ZaeWdaNWcyTVlJ?=
 =?utf-8?B?UWI5UEQ5dTQwOHdzbEpqNnhrZlRMcExXUU9ZZXVYT2laOGV1bm8xSFRJYWVp?=
 =?utf-8?B?ZFpPR1E4L0l2TDFHc24vcTFxdkRLWUZDbEVERU91UFVNdWN2SEhlT2dnSUhN?=
 =?utf-8?B?YnFOcEJMTUJSRXZoS2tTSXIvNkZVZHh2bEtrZ01aay9HcmNBU2MzOWx4bU8v?=
 =?utf-8?B?UHdVY1lvVWZFUmtBdUhzUzBLdFhFblA0eHhlRHNOWlFIQ21XVS9vczRPbEZJ?=
 =?utf-8?B?ZmYzak9mdjB4NFdnYmp3OEdocHpQVDZqdkhKWkJacGdPZlZucVdmdVdzV1hL?=
 =?utf-8?B?SFY1bkNtVEtUdDN4NG1vekZ0Y2JpZTZGRWJXZXJYUVYxTkRacTMrRU1FZit1?=
 =?utf-8?B?UDF2dGlPUGpWclZsSS8xdHI5L3RMVUZDRXBrU3JpSlJWVXRpbkFvM1ZybzlC?=
 =?utf-8?B?aFRQY3hUMmRQVFhqNnRacG9YSnp6WnplMUVwTjlKMFF2bmxNNDR1OWVWeTFm?=
 =?utf-8?B?Ky9aMFRsS3RQaVNJMUUvVGJkekpnVEwxdDNIRmpCeExYRmdPemU4T0JrWmt3?=
 =?utf-8?B?OG5PYXVTTjZWN3VoS0ZsK1ZVakZScDVrMUZER3NBOEx6aVBOZGNKYXVlSVVu?=
 =?utf-8?B?ZXA5NXh4OWdnbXJNT3dUaHI4STZUa25hKzVxNHk5MEplRml6SldsY2p2Q2Zh?=
 =?utf-8?B?R3NEeG84d09SR0U3TGtlSWpOZ0srYmhZMkg1TExMcTdNdTVFMGhmQkp6ZVR0?=
 =?utf-8?B?cTdSZzR4NkJuc2dTWVVGK3hObzZLem9DQUNkcjVmOXI0bXRlbG5XYkI1THZo?=
 =?utf-8?B?Nm1PY25PMjdUdW1ROFJTMlNNOGJpanM2TmhXZks1ZE5DV1hTYmMvZ3pXOTN2?=
 =?utf-8?B?OC9xNDBEMjBiY1RTckxkVXhGUHVDbVFudkJqaDdhZG95NTUzQjlPMm1WU1lO?=
 =?utf-8?B?RWM2M0g0aTVrdWV3MU5lYk9rcGxkRHA1YWVreTdMQ3FTUmJwOTJzT1RnOG5h?=
 =?utf-8?B?RkNUTVl6blpPcGNraGNxRXdiSTNqbWl3MXU1Q3NRR3NRT2FHd0ZHNk4vQzBV?=
 =?utf-8?B?bGNLVzhBR0tLRnlWUjJVWkJVTTNGRHczeFZ5WnhrS3N2aFEvNEtURUxjb2xq?=
 =?utf-8?B?SkxmdjZGcnVlUDdHeVcwR0t3K1U4TzBEdVZjUk5TdGJreEhTSEp1K0tPQ0cy?=
 =?utf-8?B?NHRqdHIwTnVVUUxGaDE3VUZOSDlvczJpZW41WEpZRi93d0E2TXR3cHU0REVM?=
 =?utf-8?Q?IL4hqE2ENwhmy7mked?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4dc8a6-4739-48c4-f6e4-08de888542d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 02:38:26.6105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QN33waK5kJQSxYL+BUf3MKSe/+LUd/XnDj5m4sSmEewxfvvevvEp8OwvIDmGhWR8PXmHKqqSnAEtizNvYnBvjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8794

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8gRXN0ZXZhbSA8
ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDIwLCAyMDI2IDQ6Mzcg
QU0NCj4gVG86IEFkcmnDoW4gR2FyY8OtYSBDYXNhZG8gPGFkcmlhbmdhcmNpYWNhc2FkbzQyQGdt
YWlsLmNvbT4NCj4gQ2M6IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPjsgQm91
Z2ggQ2hlbg0KPiA8aGFpYm8uY2hlbkBueHAuY29tPjsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5j
b20+OyBTYXNjaGEgSGF1ZXINCj4gPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+OyBsaW51eC1tbWNA
dmdlci5rZXJuZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IE1pZ3Vl
bA0KPiBPamVkYSA8bWlndWVsLm9qZWRhLnNhbmRvbmlzQGdtYWlsLmNvbT4NCj4gU3ViamVjdDog
W0VYVF0gUmU6IFtQQVRDSCB2OCAzLzNdIG1tYzogc2RoY2ktZXNkaGMtaW14OiByZW1vdmUgcmVk
dW5kYW50DQo+IG14MjUgaGFuZGxpbmcgYW5kIGNvbnNvbGlkYXRlIHNvYyBkYXRhDQo+IA0KPiBD
YXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4g
Y2xpY2tpbmcgbGlua3Mgb3INCj4gb3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwg
cmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0DQo+IHRoaXMgZW1haWwnIGJ1dHRv
bg0KPiANCj4gDQo+IE9uIFRodSwgTWFyIDE5LCAyMDI2IGF0IDU6MTDigK9QTSBBZHJpw6FuIEdh
cmPDrWEgQ2FzYWRvDQo+IDxhZHJpYW5nYXJjaWFjYXNhZG80MkBnbWFpbC5jb20+IHdyb3RlOg0K
PiANCj4gPiBAQCAtODczLDExICs4NjUsOCBAQCBzdGF0aWMgdm9pZCBlc2RoY193cml0ZWJfbGUo
c3RydWN0IHNkaGNpX2hvc3QNCj4gKmhvc3QsIHU4IHZhbCwgaW50IHJlZykNCj4gPiAgICAgICAg
ICAgICAgICAgbmV3X3ZhbCA9IHZhbCAmIFNESENJX0NUUkxfTEVEOw0KPiA+ICAgICAgICAgICAg
ICAgICAvKiBlbnN1cmUgdGhlIGVuZGlhbm5lc3MgKi8NCj4gPiAgICAgICAgICAgICAgICAgbmV3
X3ZhbCB8PSBFU0RIQ19IT1NUX0NPTlRST0xfTEU7DQo+ID4gLSAgICAgICAgICAgICAgIC8qIGJp
dHMgOCY5IGFyZSByZXNlcnZlZCBvbiBteDI1ICovDQo+ID4gLSAgICAgICAgICAgICAgIGlmICgh
aXNfaW14MjVfZXNkaGMoaW14X2RhdGEpKSB7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAg
LyogRE1BIG1vZGUgYml0cyBhcmUgc2hpZnRlZCAqLw0KPiA+IC0gICAgICAgICAgICAgICAgICAg
ICAgIG5ld192YWwgfD0gKHZhbCAmIFNESENJX0NUUkxfRE1BX01BU0spIDw8IDU7DQo+ID4gLSAg
ICAgICAgICAgICAgIH0NCj4gDQo+IFRoaXMgcmVtb3ZhbCBvZiB0aGUgaS5NWDI1IGNoZWNrIGRv
ZXMgbm90IGxvb2sgY29ycmVjdC4NCg0KSGkgRmFiaW8sDQoNClRoZSBvcHRpb24gdG8gcmVtb3Zl
IHRoZSBpbXgyNS1yZWxhdGVkIGNvZGUgd2FzIGFjdHVhbGx5IHN1Z2dlc3RlZCBieSBtZSBkdXJp
bmcgdGhlIHY0IHBhdGNoIGRpc2N1c3Npb24uDQoNCiINClRoZSBvcmlnaW5hbCB1c2Ugb2YgaXNf
aW14MjVfZXNkaGMoKSB0byBhdm9pZCBzZXR0aW5nIERNQSBTRUxFQ1QgYml0cyB3YXMgYmVjYXVz
ZSBteDI1IGRvZXNuJ3Qgc3VwcG9ydCBBRE1BLCBpbnRyb2R1Y2VkIGluIGNvbW1pdCA5YTA5ODVi
NzhkNzAuDQoNCkhvd2V2ZXIsIGJlZm9yZSB0aGF0IGNvbW1pdCwgaW14MjUgd2FzIGFscmVhZHkg
dXNpbmcgU0RIQ0lfUVVJUktfQlJPS0VOX0FETUEgdG8gZGlzYWJsZSBBRE1BIChjb21taXQgOTdl
NGJhNmE1ZWE5KSwgd2hpY2ggdGhlb3JldGljYWxseSBzaG91bGQgcHJldmVudCB0aGUgRE1BIFNF
TEVDVCBiaXRzIGZyb20gYmVpbmcgc2V0Lg0KDQpUaGUgYWN0dWFsIHJlYXNvbiBETUEgU0VMRUNU
IHdhcyBiZWluZyBzZXQgaW5jb3JyZWN0bHkgd2FzIGR1ZSB0byBhIGJ1ZzogdTMyIG5ld192YWwg
d2FzIHVzZWQgd2l0aG91dCBiZWluZyBpbml0aWFsaXplZCwgY2F1c2luZyBETUEgU0VMRUNUIHRv
IHBvdGVudGlhbGx5IGJlIHNldCB0byByYW5kb20gdmFsdWVzLg0KDQpUaGUgbmV3X3ZhbCBpbml0
aWFsaXphdGlvbiBpc3N1ZSB3YXMgZml4ZWQgaW4gY29tbWl0IDgxYTBhOGJjMzgwZCwgYnV0IHRo
YXQgZml4IHdhcyBtYWRlIGZvciBhIGRpZmZlcmVudCByZWFzb24gLSBpdCB3YXMgbm90IHJlY29n
bml6ZWQgYXQgdGhhdCB0aW1lIHRoYXQgdGhlIERNQSBTRUxFQ1QgaXNzdWUgd2FzIGFsc28gY2F1
c2VkIGJ5IHRoZSB1bmluaXRpYWxpemVkIG5ld192YWwuIEFzIGEgcmVzdWx0LCB0aGUgaXNfaW14
MjVfZXNkaGMoKSBjaGVjayB3YXMgcHJlc2VydmVkLg0KDQpBZnRlciB0aGUgbmV3X3ZhbCBpbml0
aWFsaXphdGlvbiBmaXgsIGlzX2lteDI1X2VzZGhjKCkgc2hvdWxkIG5vIGxvbmdlciBiZSBuZWNl
c3NhcnkuIFNvIG1lcmdpbmcgbXgyNSBhbmQgbXgzNSBpcyBpbmRlZWQgdmFsaWQuIElmIHlvdSdk
IGxpa2UsIHlvdSBjYW4gZ28gZnVydGhlciBhbmQgcmVtb3ZlIHRoZSBpc19pbXgyNV9lc2RoYygp
IHJlbGF0ZWQgY29kZSBlbnRpcmVseS4NCiINCg0KUmVnYXJkcywNCkx1a2UNCg==
