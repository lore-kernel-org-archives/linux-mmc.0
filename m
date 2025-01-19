Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2100.outbound.protection.outlook.com [40.107.20.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0907190057;
	Sun, 19 Jan 2025 20:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737317721; cv=fail; b=se+uWr3DK1PFhx5RF/s/cKtC+IfGorTYR/hMpHOgkqtlIuvCAa73ADAWFyTiVbQH1515HWvMe50TT47VoQ9Iep1kdeiLsbJytwCcufUqA1dO1TQ01qBJ4f+BMUn6jRCyeNYEf53NQS04Crtjnm0zFKnxAl/MTDmM9c11VHF1Gao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737317721; c=relaxed/simple;
	bh=mFHbpOmmt5EuV0XVxI+CNl0DRo0MovZ7Sc+rAfspkS8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YOLnmjGYBg1KC2rg+4Zs63zKCkPs3KOemqMsv3XOqCoYFbl9myDKMjwwNWhVgmT8DW+LIKCtefNAlueNN3N3CMgEMOWs2iXNqS3fnj1v4mgOVWlTm5znz9TpKcpK1AanVSK8Ce+LNL/MABkUYtlHyCFoE2xOg/nYHLscHSEA8No=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=k7U5HnmV; arc=fail smtp.client-ip=40.107.20.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="k7U5HnmV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVQPw8W5FcyrMWTIwxf4bOU4hOS4nkuD5SW1x1J9dJo0G+YKxv4lISJafu4SWEbi/KktX7D7m1SgE2iAiv1eIaAcYw5JvyZnKuAJ82TVr/cAw9gjRpRq4qHeLpUr9dDsW6JpGF7f4pC2JhxOSt5U/sZ5nWhtBdy/0ih8ASqYl9GrFVlctK7AcFc1lD2Y7Miu563v6Ovv9BUnZ2HLVOtpF5G7OS30agUMwv/Ts7DsdYEVLDCUmAnWoHICka3mRtmy8+DHi0ps4Eu1R6b28NfRfb21AJQydfuN6wSY085HGX+MXlhItMYrpRthRSqD/HQ1DCk8kW4ioVXexb0sw8zfUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFHbpOmmt5EuV0XVxI+CNl0DRo0MovZ7Sc+rAfspkS8=;
 b=ciIDeIBEF7z+E6jPKUkj1lsfVix3UdUv/9pbbvHYtmdDXYmv/1T6U9b7MH9JVR3RXRh+o7ImAHNWF/eBEHbTAhpuI4DOy6ZzN+SPqUUQOwe+wGU0mvfAlpOjrMu604kLWeFDU1xdBkcdWoCRgS0IglIGu0vTiaHJSU4yTOAjeKwO2Vv5Gd58JZNxolJrTqC4F8QHaw/pPXMeU091oSVAA3d49rY6HCPLXZqT+CYm7EDbQz37ZXjmVBaoRWDg3YATw77qdYHj8MonhG6kbQ+5YAw0YS4UPogpHPzg02hKBGnNQT518H6QC5HqvHC722Fir6cJj0Jcx+UJTBC0nqFN1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFHbpOmmt5EuV0XVxI+CNl0DRo0MovZ7Sc+rAfspkS8=;
 b=k7U5HnmVkhTuR34mS63RbEuhIh2CYdG2DxTfw68ETF8Tf+tSaIkANoccAabOBnNDtHF5UJCPrzavbOXUJrB7Dk1JcnFG0BI0XuBYiRJ4IFd2M1nJO4KaND0vKQNizO+6ez0P/StO8zJiY1Wld66EIKYMUlLewI+kt5waWpxNdps=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Sun, 19 Jan
 2025 20:15:16 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8356.020; Sun, 19 Jan 2025
 20:15:16 +0000
From: Josua Mayer <josua@solid-run.com>
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mmc: sdhci_am654: Add
 sdhci_am654_start_signal_voltage_switch
Thread-Topic: [PATCH v2] mmc: sdhci_am654: Add
 sdhci_am654_start_signal_voltage_switch
Thread-Index: AQHbaq7a0Q+CvTyGKEO2ALjdrALpTg==
Date: Sun, 19 Jan 2025 20:15:16 +0000
Message-ID: <a70fc9fc-186f-4165-a652-3de50733763a@solid-run.com>
References: <20240913185403.1339115-1-jm@ti.com>
In-Reply-To: <20240913185403.1339115-1-jm@ti.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|PA4PR04MB7533:EE_
x-ms-office365-filtering-correlation-id: 0c89f26b-419e-4f4c-6793-08dd38c5fd2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d1NFVk1ldzB5VHNSZ05XRkpuZXJYblp0SFF2S1NtRVJ3Q2NJUkpxUWE0eDJS?=
 =?utf-8?B?cHZQcjdMM1lJUFR4Rzladm5LMy9DSlppTUZrdk0yVENqbFBibjZzaGRPRnRS?=
 =?utf-8?B?OEtiTDVrdEhzR25kSDJxdkhsa21vVEk4M1ExWjI3SVlnYnAvb00zU1FOdDQr?=
 =?utf-8?B?bk5hZFNwMHR3K2pvRk1yWVdqUmpncUp1a0h3REV3dFE1RmozNUNUUCtMdmk4?=
 =?utf-8?B?U1dVU214REhlUHE5Nldsa081Y05IaDdnKzl6OXgvUW5qZXZZOFpCcTR1Yy9S?=
 =?utf-8?B?UmNha1pNMVZ2SmIwUWYzMldZdHhaN0VFS0hZWU1FZHJyUy9lMS90ejErVGxC?=
 =?utf-8?B?MVNmRVJIZkpTZE5zVktUZWJyZ2c2MXJ0U2FFMXZNN081NWJFbFd1bFlkRU5u?=
 =?utf-8?B?a3dlaXdVN3FuRXdUN0l3ZE1iYzAreTNUOXVPdmR1b25ibnI1SGMyRU5BWTR4?=
 =?utf-8?B?Wi9UbzVKc241TWRpTkwxWnpoS1Q1aHp0OXl0RGFiZ0N1cmIyVDV1bCtsaTN3?=
 =?utf-8?B?QnhSbURpVjFBc29idENzbll4K1hweGdWcTM5WVFCeDgySlRwM05wS0Z2Yzhz?=
 =?utf-8?B?eWVVWUEwZHlrNURLc1NoUXhLZmh4YU5MV2JydGdzRGhzSFBOWGtxOUE1QjdG?=
 =?utf-8?B?djVJazdBWXRseDc5dHAvTjN6WDN6TXpFNWZvT3V5blpLTElDc3VVTEhKV3Az?=
 =?utf-8?B?MTVQejB2WlJuVWxsOXN2b3ErN1dtNDNMN3ZJWCtQUGx6ZkVqdjZlZ3ZNOVd6?=
 =?utf-8?B?aUpUVlc3K0RMclBnRWRPdlNxVExodzdsWTd3ZitrS2lRdFBmdXB2Z080dUdX?=
 =?utf-8?B?clYzc2tlYnE3SGRnTjV3bjUya2ZPcjFoc01QS1p3Q2d6andLZzhQOTBTdjd0?=
 =?utf-8?B?NjBNMkpiV1lGTW92eGhwbW5INFJiUjJrd0k2Q0VTOXlvbHhUR1B0K05uQVI5?=
 =?utf-8?B?WENqcnpUSmpZK2dLc29DSE52eWlBM0dMUmw1eVpWVHJSVGJRWk9UT3dsWU1F?=
 =?utf-8?B?MXl4dXcwbXBDU1ZnajVwUzFMZnJVakVscUdqem1HUWxGOVhOK2NwZ3ZFRDVG?=
 =?utf-8?B?Yk9iTldjUkZzVkxoOVF0TTJoYXF1ellRQjhXR2t0ZVJMZHhJV0o4YTZqb2th?=
 =?utf-8?B?OUMwdEZaZFYzbE9OaU1HRjFrcnErWUhRZi9TVGkwRUJCb1NmMVp4eWk0SHVz?=
 =?utf-8?B?SUNIdm52UmRZQkt1bmVtNktJbnlqMHg2NXQxc3gwM255NllIRFZtMW96SFF0?=
 =?utf-8?B?VlVWN2xEWHUvZk9lUkhFT1UxdVdMZzk5cUVyMlJ6amhMVzdYclo0c1VXZFcx?=
 =?utf-8?B?VFBuR3ZGcXFCQjVHbmxlUmxCY01UemloOXpjV3IxOHZaQjV5ZGFYNWFnR1hQ?=
 =?utf-8?B?dWdoMWQvZTY1UkMyL0pEK3VFeU1la1BDU0tSRkhhVnVUSEhJVWp0My93Nmxj?=
 =?utf-8?B?VjYxSUdtY2VKNjluR1g5WlNZQmpIVXRPQlJ0c1BxZXdhTXZHb0E2NkpXeDNw?=
 =?utf-8?B?cnI0WU41eW96MnJiaFZRVUFWYmJEYjgxVkt2NWU3RFdBd1pFVURzaFI4M3o4?=
 =?utf-8?B?bFV4VHoyK0ZqbGZPWHd4T0ExTFVxWUZpTmFYa1JhWUdYc1gxL1FPcGsrQzdw?=
 =?utf-8?B?a2FOYzBOZVBUNHFQaHhHTWhJQjE2a2U4LzJXM1RzNG12UXZHWlV3VEJFdUNq?=
 =?utf-8?B?QkRGWHl0VCtiOEpVNFo2dkkxSXZpUVV5c0ZSQjZmcTltKzFmVWFOU2VFNkxK?=
 =?utf-8?B?N3RvTHVCczhsQ001MU5xcUZyQkFQR2Z0RloyV2xQN2JSdmN5dG5zTTZidW9t?=
 =?utf-8?B?ZEZnYW10VWp0cHlVVWFWeUtBUERIUm5RZUQ2eFdkbEVIK0lPNkx5MFNFcHFi?=
 =?utf-8?B?K0k1c08rWVBuMUFaSUFwNUFDLzRLdHcxMk1HYkswaER2dldiZEl5UU54WUg3?=
 =?utf-8?Q?cT6ljurRZzRAabW0D/EXkR6lAY8C6VuV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WGM2UjlhODBDUHFxeGNXYVU5eWlsWlZObzkxWk5lNFhQbFNWYW5xS2huSkxi?=
 =?utf-8?B?TmhTYVBhMFNyVFcrRDQ2REIxR09WckZwdHpiSzhOZW9zVGY4NjA4ZTgvcHFV?=
 =?utf-8?B?WVhDM0tvS0ZFZENVcjJqYStObm1SMkoxeWdDd3lMZ1k0dDR2T25GUWlDa3BJ?=
 =?utf-8?B?QUR2d3RGTCtVQTJ1OU9UTStIWmM3RldGdVdkQUF5bWlCblZwQXBWSW95THda?=
 =?utf-8?B?dThzZEkvbU15WkZsMG43REpDOGtiSlFYWWVKblZVeDBTZi9tMDY4YTVzc1Q0?=
 =?utf-8?B?R3ppSEFSUGFyb3JaanE1WFpFWHd6SnRaRFhSTXZDVjk4M1VwUjVoU0lTcGx2?=
 =?utf-8?B?RFNqM2pyeEtmdkpGRlpSUzlzbnM1R2grUVhtWU85THZrRllFUGpGUTh5aFRC?=
 =?utf-8?B?SXJBRnMvaXVqeDJqTWMvd3IvU01hdCtDWWR5eEpDUVN1MCtWTGpzeEk0bzlK?=
 =?utf-8?B?TkV2dHp4WTROdlpmWkVUd3IrU1Zoaisxc0IxVTBkMGNSaUpkdGN6ZU9LckRu?=
 =?utf-8?B?Q0ZaNFdZTGUwNlRuSUZDdnZRTmRMWVpVcnVwUUd0QWMwVjdpS2U4Y1F1c0lJ?=
 =?utf-8?B?OUpvZi9Ub0x1MUd6Z3lYbHdSaHBLNHNPREhoM1RVV090YUNsM0tJd2pvZW9F?=
 =?utf-8?B?WXEyK01lWTBQbGQyenZkYnhnMzRzNXlDMjB4T2lpQm9UOEQxeXhoZ0QreWo2?=
 =?utf-8?B?clp6S0gzcUk2dldCYnQ3ZWNEWjJDM1h6d2lJM01XV25YcGFXOC96WTl5NGZk?=
 =?utf-8?B?bUY1VzBCankzZEo3N1l5aXNNNzFTSTA3YUVKa0d3Y21aZ05qN1NCZE0zSC9J?=
 =?utf-8?B?N2d1bm4rQmZDakFyOXJrQXZPN1JUQ2tkY012cjg2MTRyOUcwYlBRS2I5OUVH?=
 =?utf-8?B?M2xZMHRjLzBUaWVCdGZkSFZVcGJZd1NkNW01ckkyWWZZUExRaXY0VGtiUVVl?=
 =?utf-8?B?ZUkzL1M1ODZuUXBrakNoRVJHMXMwbVlVRTNHYzNoZUlQdmFKNjFESzMxbksx?=
 =?utf-8?B?WHh3emRIT09kMjZIbmJITW94UU9EYmp4R292T3VSTWUreFRvWng2NUhUdlVr?=
 =?utf-8?B?WGR4OWU1dktxcE5EdVEvZmIyTGtLSzN5U0R2YTl6ckNidzNORU1yNHBHNTZ2?=
 =?utf-8?B?UGYyMkZYR2hOWjd3eGp5QWpEQnpHODRIL3VqQ2hSZTZVT0p5blgzOTBuVS9u?=
 =?utf-8?B?QXNyemVWWUt4czhIR3ZMaG5VanFzNSs2WjhVYzM2SmFQVG9ZZVA1blkwUE1R?=
 =?utf-8?B?S1RQSlFKQVlHSklkOERRNWJCbFYvTnVnd2M4VWwxMExsZnBOVTI5bXJYK1Ev?=
 =?utf-8?B?bFNheEU4SlpIZEIxUWtEK2F0cFZUWFpNVXUrb2dRdzNqY2RmSlFibFRHK3FO?=
 =?utf-8?B?c3UwdWNVVENFajBpTEZzaThHa2ZXOVNpR0dVOUlSaXV1dU50K3dhQnFzcHhw?=
 =?utf-8?B?Yk4rTDRvK3RSR1FCa0xOeXZCT3ZyR2pBQzFDb1ZYeXdSb01yNzVMQndXcEZI?=
 =?utf-8?B?Ky9uSlMyM0tLek50dDFaRlZZenJXemJjSzBvaEZQQ0piem8xQUNGVmcwVXRq?=
 =?utf-8?B?V3dXdmhOYWNHb1lJaFZaM2xzZDNuM3R0YXErb1d5NjRNcnI5U0IwRW1KQmdv?=
 =?utf-8?B?Si8vWDZNbWo1S0xLenRPNTl4MnNVTDdPU21yUEVUMXd2SXozd2NMY3dSZEpL?=
 =?utf-8?B?ZldvNDAzdmRlekQzVExITURycnVZcXdJQTVLOU9DSVpuUW5hajVlMkxPODIr?=
 =?utf-8?B?SnVRK2RBdGFhUWFGWjBKWWtxc0o5eEVHdEJiVTFqSkpkU0YvNmU2aEwycWJV?=
 =?utf-8?B?ZDlYTXNxS2Zqb1hhbmljVjljV012Y2pxUGh1TVBNVXd1eERkc2RPdVcwU2FU?=
 =?utf-8?B?RG51T2NNYTBwSWlTR0h5UFB1UmUzVERDK1pKSFF0eDJua001bkhOSHU0SkZZ?=
 =?utf-8?B?ZEx2TGphcXpqbnFLU2JNTnVjK1d2ZVFiZHp4bGNISDVja2RxT0lzdWswQ0dw?=
 =?utf-8?B?VmM2dGExOTFaTW8wUGVMREl4S1IxMEk3dlZGSVNwcXlLREFTTmJxVXRmRXJz?=
 =?utf-8?B?L0htVFJNVDJIK0pMUkowTU9oVXhHdzJJV1ppallMdGNGN1MrZjZGbUNkTFVJ?=
 =?utf-8?Q?rdBc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72EB242C62EFD54CB3064C308516622E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c89f26b-419e-4f4c-6793-08dd38c5fd2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2025 20:15:16.3704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mXpsyb3TPJRJSggSnGiY2oO9JEMIn6mE2lKoz7MKcB/qUBVzPoujrgq1LmLOckAR+onPyiphf+ndFaT7P23p9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7533

SGkgSnVkaXRoLA0KDQpBbSAxMy4wOS4yNCB1bSAyMDo1NCBzY2hyaWViIEp1ZGl0aCBNZW5kZXo6
DQo+IFRoZSBzZGhjaV9zdGFydF9zaWduYWxfdm9sdGFnZV9zd2l0Y2ggZnVuY3Rpb24gc2V0cw0K
PiBWMVA4X1NJR05BTF9FTkEgYnkgZGVmYXVsdCBhZnRlciBzd2l0Y2hpbmcgdG8gMXY4IHNpZ25h
bGluZy4NCj4gVjFQOF9TSUdOQUxfRU5BIGRldGVybWluZXMgd2hldGhlciB0byBsYXVuY2ggY21k
L2RhdGEgb24gbmVnDQo+IGVkZ2Ugb3IgcG9zIGVkZ2Ugb2YgY2xvY2suDQo+DQo+IER1ZSB0byBz
b21lIGVNTUMgYW5kIFNEIGZhaWx1cmVzIHNlZW4gYWNyb3NzIGFtNjJ4IHBsYXRmb3JtLA0KPiBk
byBub3Qgc2V0IFYxUDhfU0lHTkFMX0VOQSBieSBkZWZhdWx0LCBvbmx5IGVuYWJsZSB0aGUgYml0
DQo+IGZvciBkZXZpY2VzIHRoYXQgcmVxdWlyZSB0aGlzIGJpdCBpbiBvcmRlciB0byBzd2l0Y2gg
dG8gMXY4DQo+IHZvbHRhZ2UgZm9yIHVocyBtb2Rlcy4NCkkgaGF2ZSBqdXN0IHRlc3RlZCB0aGlz
IHBhdGNoIG9uIGRvd25zdHJlYW0gVEkgTGludXggZm9yayB0YWdnZWQgMTAuMDEuMTANCih2Ni42
LjU4KSBhbmQgaXQgYnJlYWtzIHNkLWNhcmQgZGV0ZWN0aW9uIG9uIFNvbGlkUnVuIEFNNjQyIEh1
bW1pbmdCb2FyZC1UDQpzdXBwb3J0ZWQgaW4tdHJlZTogYXJjaC9hcm02NC9ib290L2R0cy90aS9r
My1hbTY0Mi1odW1taW5nYm9hcmQtdC5kdHMgc2luY2UgdjYuMTEuDQoNClRoZSBib2FyZCBmYWls
cyBkdXJpbmcgYm9vdCBmcm9tIHNkY2FyZDoNCm1tYzE6IGVycm9yIC0xMTAgd2hpbHN0IGluaXRp
YWxpc2luZyBTRCBjYXJkDQoNCkhlbmNlIEkgc3VzcGVjdCBzb21ldGhpbmcgaXMgbm90IG9rYXkg
d2l0aCB0aGUgaGV1cmlzdGljcyBlbmFibGluZyB0aGlzIHF1aXJrLg0KS2luZGx5IG5vdGUgSSBo
YXZlIG5vdCB0ZXN0ZWQgaXQgd2l0aCBwdXJlIDYuMTMtcmMxIHlldC4NCg0KTXkgZG93bnN0cmVh
bSB3b3JrYXJvdW5kIGluIGR0cyBpcyB0byBsaW5rIGEgZml4ZWQgcmVndWxhdG9yIHZtbWMtc3Vw
cGx5LA0KYnV0IHRoZSB1cHN0cmVhbSBkdHMgc3BlY2lmaWVzIG5laXRoZXIgdm1tYy0gbm9yIHZx
bW1jIHN1cHBsaWVzLg0KDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEp1ZGl0aCBNZW5kZXogPGptQHRp
LmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgc2luY2UgdjE6DQo+IC0gSW52ZXJ0IHF1aXJrIGxvZ2lj
DQo+IC0gU2ltcGxpZnkgc2RoY2lfYW02NTRfc3RhcnRfc2lnbmFsX3ZvbHRhZ2Vfc3dpdGNoKCkg
YW5kIGNhbGwNCj4gICBzZGhjaV9zdGFydF9zaWduYWxfdm9sdGFnZV9zd2l0Y2goKSB3aGVuIHRo
ZSBxdWlyayBkb2VzIG5vdCBhcHBseQ0KPiAtIFNpbXBseSBsb2dpYyB3aGVuIGRldGVjdGluZyB3
aGVuIHF1aXJrIHNob3VsZCBiZSBhcHBsaWVkDQo+IC0tLQ0KPiAgZHJpdmVycy9tbWMvaG9zdC9z
ZGhjaV9hbTY1NC5jIHwgMzAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
bWMvaG9zdC9zZGhjaV9hbTY1NC5jIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaV9hbTY1NC5jDQo+
IGluZGV4IDBhYTNjNDBlYTZlZDguLjlmZjA3YWFkYjJkOTEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvbW1jL2hvc3Qvc2RoY2lfYW02NTQuYw0KPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNp
X2FtNjU0LmMNCmN1dA0KPiBAQCAtODQ0LDYgKzg2OCwxMSBAQCBzdGF0aWMgaW50IHNkaGNpX2Ft
NjU0X2dldF9vZl9wcm9wZXJ0eShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiAgCWlm
IChkZXZpY2VfcHJvcGVydHlfcmVhZF9ib29sKGRldiwgInRpLGZhaWxzLXdpdGhvdXQtdGVzdC1j
ZCIpKQ0KPiAgCQlzZGhjaV9hbTY1NC0+cXVpcmtzIHw9IFNESENJX0FNNjU0X1FVSVJLX0ZPUkNF
X0NEVEVTVDsNCj4gIA0KPiArCS8qIFN1cHByZXNzIHYxcDggZW5hIGZvciBlTU1DIGFuZCBTRCB3
aXRoIHZxbW1jIHN1cHBseSAqLw0KPiArCWlmICghIW9mX3BhcnNlX3BoYW5kbGUoZGV2LT5vZl9u
b2RlLCAidm1tYy1zdXBwbHkiLCAwKSA9PQ0KPiArCSAgICAhIW9mX3BhcnNlX3BoYW5kbGUoZGV2
LT5vZl9ub2RlLCAidnFtbWMtc3VwcGx5IiwgMCkpDQo+ICsJCXNkaGNpX2FtNjU0LT5xdWlya3Mg
fD0gU0RIQ0lfQU02NTRfUVVJUktfU1VQUFJFU1NfVjFQOF9FTkE7DQo+ICsNCldhcyBpdCBpbnRl
bnRpb25hbCB0byBhcHBseSB0aGUgcXVpcmsgYm90aCB3aGVuIG5laXRoZXIsDQphbmQgd2hlbiBi
b3RoIHN1cHBsaWVzIGFyZSBzcGVjaWZpZWQ/DQo+ICAJc2RoY2lfZ2V0X29mX3Byb3BlcnR5KHBk
ZXYpOw0KPiAgDQo+ICAJcmV0dXJuIDA7DQo+IEBAIC05NDAsNiArOTY5LDcgQEAgc3RhdGljIGlu
dCBzZGhjaV9hbTY1NF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCQln
b3RvIGVycl9wbHRmbV9mcmVlOw0KPiAgCX0NCj4gIA0KPiArCWhvc3QtPm1tY19ob3N0X29wcy5z
dGFydF9zaWduYWxfdm9sdGFnZV9zd2l0Y2ggPSBzZGhjaV9hbTY1NF9zdGFydF9zaWduYWxfdm9s
dGFnZV9zd2l0Y2g7DQo+ICAJaG9zdC0+bW1jX2hvc3Rfb3BzLmV4ZWN1dGVfdHVuaW5nID0gc2Ro
Y2lfYW02NTRfZXhlY3V0ZV90dW5pbmc7DQo+ICANCj4gIAlwbV9ydW50aW1lX2dldF9ub3Jlc3Vt
ZShkZXYpOw0KPg0KPiBiYXNlLWNvbW1pdDogY2Y2NDQ0YmE1MjhmMDQzMzk4YjExMmFjMzZlMDQx
YTRkODY4NWNiMQ0K
