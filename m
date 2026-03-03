Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011031.outbound.protection.outlook.com [40.107.130.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6505437418D;
	Tue,  3 Mar 2026 03:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772509146; cv=fail; b=fRqX87oH8gCja8VlwFR8CLYGqUBAgXFAvRv7SlLnItoD0XBKit3CKha9rc5qFpcqzzDyX9GTiAkHbCocihVb7EbmC+owqrY41ewNxqFnF5HSdx8WSCZnlLlX4M61qky+V5dxgPyQAhT0yJFwtvZPksqSvUkengeIxWRljl8egoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772509146; c=relaxed/simple;
	bh=YT7Ss1UUDuXDVWnhcDmYAUscFkepBdl/ZPJFO5bDK3E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ep24RWmW4fY7kyjYEesoNNwiZrKpbzI4NmVtlX1V01Ew6M/NLCcFkv/LAP7Hb2D3rgCk4ui3In7raDUQGRx0P6nfrjQ1lvI6mqL1z6IsGFcv+bCSCgbWwbZWsJQeTmbKuiOMVnXsrxvN8Cgfmbwl9zIT8fuD2eIlfDhDPwd4pf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V7VfOQm8; arc=fail smtp.client-ip=40.107.130.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V7VfOQm8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hzay0bLcmvw0LoEUD8Aasyjj3Pql9wWu7Ev6aBnCunUtKswTeIZpNSsWo1MbhUXZRiONMcdAhX+YfX7hd44CaMoUemebCcW/J5iaOp6LcyPYlG+BVgVNrSuSn2lstkNxMM2x2RUbZr9/G9Ki0ZjL/5YRJY40SWBLFQ9w9E7QUAt3PKalcIbZ2Q+5Ro8xCUn7tFTwH57c4/6laL+FNwmITZXPsOX6jVkhOF4/kGx0GN4IWv+1fy7tUAAUoZo8h4Q7mOtOpClXHxwMSfac+mEGgEEUCPEE0tFpwZcj0hc1F2HM/6flgmjCjFVM9rlCwzxKAGR6nWEYrWoMy6VnPgTh7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YT7Ss1UUDuXDVWnhcDmYAUscFkepBdl/ZPJFO5bDK3E=;
 b=H6tbwcIJPeHsHOMeeluarKPZAaayjeErIHancupqXZk7riJp/E+8Po0SsrCHsHFjk7Uhep2FYO5R8YtA220PBrQx2NgZl9VnzFFtZearEJcTx3gcdUYQaDU75La++cFwh1T+gxT4FTUxxVLfzun8EPRVx6+niyVIoU2ojMxhR9MQwKwYjA8zFvYkNfs9yO2n+P/Hd7CN4kN/456eYWB8VqxCugPbGYcLA9YYmkRiCPpIDb8ioAzy4AdOZ2f8MzwAzuXXgyKCb8UjJolYkcsIqVx1oXSHFDHhFRU3RlbOv6XOm2SGYCCoHZ+1uaw3psLodM9l00Q68jt2UewJQDhOEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YT7Ss1UUDuXDVWnhcDmYAUscFkepBdl/ZPJFO5bDK3E=;
 b=V7VfOQm8PcmqA1o5Z2u5AOM81ATMQ8fbdnE1LTAzSWJjp1SMM5G7cTbnS4w9ZiK4rvFxAiN+h3HZpw6i6ngz11koaoortVelyZ0cLnY+rTFDCx/BxD6COyEZd2kWCaOjqOWVW/qKSHWiTUCcrRJ3/Q6i/OWk5nR4Vs+UeSVXUUK7cEv9XGBKkiCokvvfBuB8FPEoMUaT+dOv082cZyJJk73VBk156jlVyPpZDbWoVASyGcthyktKOXKJTmmjirOW99AhlRSfKLH1OceKNB0KBXyvhFyWLiZR8HK+CtxZ+/Rm9zFPibxOvhFE7DMnb5ovxGdnBRgP0qih6NJSkIUCBA==
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by DU4PR04MB11080.eurprd04.prod.outlook.com (2603:10a6:10:587::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 03:39:02 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%6]) with mapi id 15.20.9654.015; Tue, 3 Mar 2026
 03:39:01 +0000
From: Luke Wang <ziniu.wang_1@nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, Bough Chen <haibo.chen@nxp.com>
CC: Frank Li <frank.li@nxp.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, dl-S32 <S32@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH 0/4] mmc: sdhci-esdhc-imx: add 1-bit bus width
 support
Thread-Topic: [EXT] Re: [PATCH 0/4] mmc: sdhci-esdhc-imx: add 1-bit bus width
 support
Thread-Index: AQHcqhpyDXKua+xWcE27U1ItyJyBFbWbQT8AgADo3WA=
Date: Tue, 3 Mar 2026 03:39:01 +0000
Message-ID:
 <DU2PR04MB8567C32F1ECAA3AF45D4DA79ED7FA@DU2PR04MB8567.eurprd04.prod.outlook.com>
References: <20260302080057.974102-1-ziniu.wang_1@nxp.com>
 <6c7cadff-f078-4b02-97c5-b7f0635501c6@intel.com>
In-Reply-To: <6c7cadff-f078-4b02-97c5-b7f0635501c6@intel.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8567:EE_|DU4PR04MB11080:EE_
x-ms-office365-filtering-correlation-id: 2dff5c91-f230-4fc2-cf1c-08de78d6691a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 3QlMGH0QoGXPXVU8O6fi9OQw5zQtyaWAPXFACi6LKk/L8r4FsDzH6NZaxx0Ui8NHb6zShGwnDSGitUYjF3PkpABTp5hhyHnrp9+JrtJGn8TRVDpotaCA6GDLG4SJKBOkrZW5trCk8gTuXR+xGNHBAuhDiNDZYjARuFKu2uXPLJZbdy2+ErULGri2U/04HQkr6q60bMMfFUti69oABFvlDx1khvEnCz3ExrVAuIlxJpvnMYConN+BKHvsCBLkvqeBNyjX0m/taW/Thb5qySmGQzhSvgGgj8mDA3KSxFaM33/Rd6RMl3uMMyNfNdbW841LWI0yfQK3bxUiDghfvR9II6kCQ6QCfXdNwy4G7JYxIfBngdUgDg72WqEhJRWMW2f+7btozpywh6Ru3giq07AVbajnnWOqVDe+YZBTI1r+qghqoCQ5L3KrQbQpbMBcCuBl4QrH+xWF4mYwclvFgfAr0wh3Tv2FoeCgWXfuZEndjhS72Xh/87ucId3ajpbVQa7QSCk7RbM/wuk7rWO93dhK9IqthcFn0jkvNtaTKOxzfgikpqVmXbZWOKgcIx6dz2e0wHcP+lpODbhWu9bz9D+YGTOMyfcYzozt9O92z4GuhAUOybKdJ0xZj6WGh1K8esn9LXMXP+zqQ87JJqf9H0r0j0SS2nVPU1edvu6BwAljXl4Md2Hs+SU+Ws82/Bs1cJKTtiZ4WqIzLqbq4lbNBTP/KWHRjVA09y5DAJx2aMA6vjVOUo5r/pnQS9ELZMXh3LeqRqAPiG+TWyserfW2FtStfGHQualZysXHU/ug9cKH7SQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?STBHdmVERWNWblV0NVhPMEhhTXpIaGErdVY2QnIzS1dkckVyd2lLNjZ0NVh4?=
 =?utf-8?B?UnB6RWhYeWczTVZsYjVIYkJnTEN3WjNrUzZqamFrWW8xVkd4V29PL3kycks0?=
 =?utf-8?B?aEFtMEZZYVJ6RmRMempnMnl6MkVMMWN0cTc0Y2JDdnczdFVnYWJoOEN5QVFZ?=
 =?utf-8?B?VkVyeFJvWVVyZEpkbHRESzhVUTJ5Q1JPL2EyMEs1MWFZK2NOMVdRSml5T2tN?=
 =?utf-8?B?dEZ1L2dQT1g0VGZLRWQzVnk4RWViaEpBb1IrOHE3UG04NlJiZU84blRtSFJl?=
 =?utf-8?B?T29Db2FxRG50bHlYMzFPVEdCSld3N1dOemVWZXhKNEJvMTFsSnhSbEw2dkk2?=
 =?utf-8?B?ejdBOVoxMCtCdTZ2cDcxN0VrZnVJL1VPNys3MDhQemFZc0NlWnRQTjJSeFV2?=
 =?utf-8?B?L1V2K1JXMjhvWmNGTEVSY2NJdE9Ld3VFZWx5LzJONjBuUXBJd3prU0haQWVX?=
 =?utf-8?B?ZEdhb1k1MjhWclNMc0p1ZGt5UlplM0FVVzVoaDcwcE1laFNCUXcwYUVaNUdF?=
 =?utf-8?B?SmtMWmxpblQ2NFBVcXU5aEczNTdzTk5RSGQrajY4RHpPMmEraGhwWUZJZVdM?=
 =?utf-8?B?MHRIM1B0VnI5Qm9YM0x4UnlWaXRTNG9iZkZZTmNqdmZETnljVk1KY2E2WUVk?=
 =?utf-8?B?NHZMRW9reDF3ZmhFN0lINVpjVnJsM0EwOU9waXpWTlVWaW1zS05HMGJRWWZi?=
 =?utf-8?B?TkNOUXFqa0R6WUpYc3NxcUlhelZlRnc0a2JydTFPVjNta1J1cDhxRmFGem5y?=
 =?utf-8?B?ZkgvVnhkZkl5VmdTbUhTUVJTR2duUnFCWTVQTHpOdy9FUUpPRW1iR0s2U3dP?=
 =?utf-8?B?VFdjczE2NFBVYkJmWlRLamhScW1NM1U1S0ZaZWpPdmlndVo2dG9rMTdlVytR?=
 =?utf-8?B?ZVBTQjh5blRvSjBneDNxU0NRalRBSlJvMUlLOU4xVVJxY25xdWMrNXRWWVpX?=
 =?utf-8?B?RUhjQ2RXSUhSZnRmRkJxMHNMVk1qZDhIcnZGcVpmRWVWaThtaDZXMkJpTm5E?=
 =?utf-8?B?QjlCT29pNlg2MXVhR1plVGJWZEFXdThjR3ZoMHRHeCtpRDc5QzRyaHVWcytU?=
 =?utf-8?B?Ry9xTGFzY2lrUy9CSkRnR2FIVGZxR1d1a3FtK2NiQWZmMlhULzYyU3RmNndh?=
 =?utf-8?B?ODFSd1ZKdi9xRlJzdmRCSzJMazNtWEJGL1laUVVQUFl3ZHBkTXBNUXptZzlY?=
 =?utf-8?B?WWx4dFhQNHlyMmxVcE43VTVRb0N0cEljalVqTVN1M0FkaXJydXN1VEJLTXZ4?=
 =?utf-8?B?VmhrdkgxYXBZSFRwVm5LcGEybHh4SjNud0h3WHFWKzJrdXdGejBRMGYzTi9p?=
 =?utf-8?B?M29tWkFSQmNSVG1YeVNFcDlFbDZORVAvOUR6MTNCbWp2RDIvbVNva3ludzI3?=
 =?utf-8?B?VUZQdHQ1a1psWjJLYUdaZWhwTi9QZTBvaU4ySW5zMUUzclBTeG9mNFYrYlBJ?=
 =?utf-8?B?RG9SZE1SOHJpZWp2Ynh4aTdabjVaOTNwSDFWNFBHNU9jd1JsYnJVNTJLVTNS?=
 =?utf-8?B?dHZjdExmL0JhTUMrU0NLeE44VGIvaXI4eEgwemRmTlNZai9BajNTUjZ0MjlJ?=
 =?utf-8?B?cnF5d3hFRXpETVdmaTYxV0x1SXVqM0ViNDRMbFphS1BzT29ObXBDcFdYdmpz?=
 =?utf-8?B?ejRhbUw1UEVweG82NmxFUGpTcU5kekNBSmJ4aFlwZHFGMXBJTGFmRmErcG12?=
 =?utf-8?B?QjdmeFB5TGM1aU5RcmZ0UVpDWjdsVkFub2lKYXFleUNjNWNuWDg3STZldUNs?=
 =?utf-8?B?RlozWHE5UjZ5bkMvWC9DK2VvWGtTcHZqcFozMUR2dHFocllud0NiWFNYdmhF?=
 =?utf-8?B?ZTJtTVFlUmhjalN1M3VSVDlibDRNblJlUTZIZkVtWTQzQTdZNEhJL0tLTkpk?=
 =?utf-8?B?MkR4bG5RdmN1N29Ta01Gdk4zNmJ4S2E1c3MvNnFWeUNPNmgwL3hONmFUSnJT?=
 =?utf-8?B?aTJ2Y2piZnlENXJPdHVNcEJVbVR2MWlXYVYyc0Z2YnRIVVJTdTRzWDc0R3E0?=
 =?utf-8?B?cEZQSVFPSkg2Yjl1NUMxbXl2b2x3NVQycFBkdmZDelBWejN5YUVGdExBNi9W?=
 =?utf-8?B?RVBrempQVmF5ZnY1ZTFJS2w1bXl5S0paM0hzYXlwQVlHS2Q3NGZaK3FIOUhT?=
 =?utf-8?B?d0lnVHFUYm00OHM3OVcyWjUva3c1OExyUUNwQ0c5bm03NVFMeHpWMWEyZzFp?=
 =?utf-8?B?RGVNTVBBR1htMU4wdkszYjBveExaM0cyWWYrQUczZzVtWkNCTS9CZmxSR0Jh?=
 =?utf-8?B?ZDhHaS9LdWxqd24ySm1Nejd0Q0VuMTNyeVBPVzBWNVNnVVBldXlvRlE4Tjcy?=
 =?utf-8?B?TkdUejRSaDQzcXROY1R1OVhyL1ZGaDUwUG5HTGdRcFZ0NVZ3OCthdz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dff5c91-f230-4fc2-cf1c-08de78d6691a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 03:39:01.4300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hJuooV++CfNpTpK2ozeSzF65i0UskVPB9cCZH3I2W15HcHbZ++RwP9YtHO5iqH4M1ErJFlxhgjUc52DIT9jAsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11080

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWRyaWFuIEh1bnRlciA8
YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMiwgMjAyNiA5
OjQ1IFBNDQo+IFRvOiBMdWtlIFdhbmcgPHppbml1LndhbmdfMUBueHAuY29tPjsgdWxmLmhhbnNz
b25AbGluYXJvLm9yZzsgQm91Z2gNCj4gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiBDYzog
RnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiBr
ZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgaW14QGxpc3RzLmxpbnV4
LmRldjsgbGludXgtDQo+IG1tY0B2Z2VyLmtlcm5lbC5vcmc7IGRsLVMzMiA8UzMyQG54cC5jb20+
OyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggMC80XSBtbWM6IHNk
aGNpLWVzZGhjLWlteDogYWRkIDEtYml0IGJ1cyB3aWR0aA0KPiBzdXBwb3J0DQo+IA0KPiBDYXV0
aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xp
Y2tpbmcgbGlua3Mgb3INCj4gb3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVw
b3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0DQo+IHRoaXMgZW1haWwnIGJ1dHRvbg0K
PiANCj4gDQo+IE9uIDAyLzAzLzIwMjYgMTA6MDAsIHppbml1LndhbmdfMUBueHAuY29tIHdyb3Rl
Og0KPiA+IEZyb206IEx1a2UgV2FuZyA8emluaXUud2FuZ18xQG54cC5jb20+DQo+ID4NCj4gPiBU
aGlzIHNlcmllcyBhZGRzIDEtYml0IGJ1cyB3aWR0aCBzdXBwb3J0IGZvciBzZGhjaS1lc2RoYy1p
bXggZHJpdmVyLg0KPiA+DQo+ID4gQ3VycmVudGx5IHNkaGNpLWVzZGhjLWlteCBkb2Vzbid0IHN1
cHBvcnQgMS1iaXQgd2lkdGggYmVjYXVzZSBpdA0KPiA+IGRvZXNuJ3QgY2FsbCBzZGhjaV9nZXRf
cHJvcGVydHkoKSB0byBwYXJzZSAiYnVzLXdpZHRoID0gPDE+IiBhbmQNCj4gPiBzZXQgU0RIQ0lf
UVVJUktfRk9SQ0VfMV9CSVRfREFUQSBxdWlyay4NCj4gPg0KPiA+IEFmdGVyIGFkZGluZyBzZGhj
aV9nZXRfcHJvcGVydHkoKSwgYW5vdGhlciBpc3N1ZSBpcyBleHBvc2VkOg0KPiA+IG1tY19zZWxl
Y3RfaHMyMDAoKSByZXR1cm5zIDAgd2l0aG91dCBzd2l0Y2hpbmcgd2hlbiAxLWJpdCBidXMgaXMN
Cj4gPiB1c2VkLCBjYXVzaW5nIG1tY19zZWxlY3RfdGltaW5nKCkgdG8gc2tpcCBtbWNfc2VsZWN0
X2hzKCkuIFRoaXMNCj4gPiBsZWF2ZXMgZU1NQyBpbiBsZWdhY3kgbW9kZSAoMjZNSHopIGluc3Rl
YWQgb2YgSGlnaCBTcGVlZCAoNTJNSHopLg0KPiANCj4gSG93IGRvIHlvdSBlbmQgdXAgd2l0aCBp
bmNvbXBhdGlibGUgY2Fwcz8gIElmIHNkaGNpIGlzIGFkZGluZw0KPiB0aGVtLCB0aGVuIG1heWJl
IHN0b3AgdGhhdCBpbnN0ZWFkIG9mIHJlbW92aW5nIHRoZW0gbGF0ZXI/DQoNClRoZSBpbmNvbXBh
dGlibGUgY2FwcyBjb21lIGZyb20gc2RoY2lfc2V0dXBfaG9zdCgpIGluIHNkaGNpLmMsIHdoZXJl
DQpVSFMvRERSL0hTMjAwL0hTNDAwIGNhcHMgYXJlIGFkZGVkIGJhc2VkIG9uIGhhcmR3YXJlIGNh
cGFiaWxpdHkgcmVnaXN0ZXJzDQp3aXRob3V0IGNoZWNraW5nIGJ1cyB3aWR0aC4NCg0KSSBjYW4g
YWRkIGJ1cyB3aWR0aCBjaGVjayBkaXJlY3RseSBpbiB0aGUgY29uZGl0aW9uLCBsaWtlOg0KDQog
ICAgLyogQW55IFVIUy1JIG1vZGUgaW4gY2FwcyBpbXBsaWVzIFNEUjEyIGFuZCBTRFIyNSBzdXBw
b3J0LiAqLw0KKyAgIC8qIFVIUyBtb2RlcyByZXF1aXJlIGF0IGxlYXN0IDQtYml0IGJ1cyB3aWR0
aCAqLw0KLSAgIGlmIChob3N0LT5jYXBzMSAmIChTREhDSV9TVVBQT1JUX1NEUjEwNCB8IFNESENJ
X1NVUFBPUlRfU0RSNTAgfA0KLSAgICAgICAgICAgICAgICAgICAgICBTREhDSV9TVVBQT1JUX0RE
UjUwKSkNCisgICBpZiAoKG1tYy0+Y2FwcyAmIE1NQ19DQVBfNF9CSVRfREFUQSkgJiYNCisgICAg
ICAgKGhvc3QtPmNhcHMxICYgKFNESENJX1NVUFBPUlRfU0RSMTA0IHwgU0RIQ0lfU1VQUE9SVF9T
RFI1MCB8DQorICAgICAgICAgICAgICAgICAgICAgICBTREhDSV9TVVBQT1JUX0REUjUwKSkpDQog
ICAgICAgIG1tYy0+Y2FwcyB8PSBNTUNfQ0FQX1VIU19TRFIxMiB8IE1NQ19DQVBfVUhTX1NEUjI1
Ow0KDQpTaW1pbGFyIGNoYW5nZXMgZm9yIFNEUjEwNC9IUzIwMC9ERFI1MC9IUzQwMCBzZXR0aW5n
cy4NCg0KSXMgdGhpcyB0aGUgcmlnaHQgYXBwcm9hY2g/DQoNClRoYW5rcywNCkx1a2UNCg0KPiAN
Cj4gPg0KPiA+IEZpeCBieSBkcm9wcGluZyBpbmNvbXBhdGlibGUgVUhTL0REUi9IUzIwMC9IUzQw
MCBjYXBzIGluDQo+ID4gbW1jX3ZhbGlkYXRlX2hvc3RfY2FwcygpIGZvciAxLWJpdCB3aWR0aCwg
YW5kIGNsZWFuIHVwIGR1cGxpY2F0ZQ0KPiA+IGNvZGUgbm93IGhhbmRsZWQgYnkgY29tbW9uIGZy
YW1ld29yay4NCj4gPg0KPiA+IEx1a2UgV2FuZyAoNCk6DQo+ID4gICBtbWM6IGNvcmU6IGZpeCB0
aW1pbmcgc2VsZWN0aW9uIGZvciAxLWJpdCBidXMgd2lkdGgNCj4gPiAgIG1tYzogc2RoY2ktZXNk
aGMtaW14OiBhZGQgMS1iaXQgYnVzIHdpZHRoIHN1cHBvcnQNCj4gPiAgIG1tYzogc2RoY2ktZXNk
aGMtaW14OiByZW1vdmUgZHVwbGljYXRlIEhTNDAwIGJ1cyB3aWR0aCB2YWxpZGF0aW9uDQo+ID4g
ICBtbWM6IHNkaGNpLXBsdGZtOiByZW1vdmUgZHVwbGljYXRlIERUUyBwcm9wZXJ0eSBwYXJzaW5n
DQo+ID4NCj4gPiAgZHJpdmVycy9tbWMvY29yZS9ob3N0LmMgICAgICAgICAgICB8IDE5ICsrKysr
KysrKysrKysrLS0tLS0NCj4gPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYyB8
ICA2ICstLS0tLQ0KPiA+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLXBsdGZtLmMgICAgIHwgIDcg
LS0tLS0tLQ0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDE3IGRlbGV0
aW9ucygtKQ0KPiA+DQoNCg==
