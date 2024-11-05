Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010054.outbound.protection.outlook.com [52.101.69.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C54B33987;
	Tue,  5 Nov 2024 01:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730771828; cv=fail; b=qJRpe0eauS28r4+CmDMZFApVYqd+8dotPF3d9QY+CiCXP+TrPhCEh1CbtpTJGjzUNfaWOrWhuWegv2rM07hSDEAHltj+rkxLLX8TCoMW/U000xoi04TLK0YHy+1Plnco38nxqT3Ck7L1aZKc7C4EMVnaC3ds2k8Dc5PuOlfKztQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730771828; c=relaxed/simple;
	bh=lkVnESfhsnZ0DNSUi+VAkdAkjpeRj3y1EvMbamsbg+g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nov23LIxw1HbkSsoj2/bfjzcLqjJXcEQMNIcW2JwsU64CxP8iUoKMKfxZuCKuG1rJ+c7W/qkW6ra1wXkLWmjUqoeXL2pZiO0VVyOzh8cJYudmNWZkqLWB4SR+9Az5krNcGC4WkmV3Tk89j5gZAkdPBI/Kx25aajIs7RxsLejW2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a90TY7zt; arc=fail smtp.client-ip=52.101.69.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a90TY7zt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRWGvEDfByxqynP9W0pDTdimHgWyWXOTA6PTAtxRL0uWG7zCQmZtxlpVZiagd9FGPjsSyfFC8/2UmYTSx49oo++4az7jCHqIlgRqajsPON31fpQ95YcBd1HHp/F/Fae9dw27G6s16gh5XqCSFSyd8Jy0VT3IenWfxDX3e6P1uL5JTKg38GpEXPSXCYSZJeKR7ZCaDK63Ie8BWknuV/nqaV7nuwDB9KUcQfxZuYTp7jISY9PhO5PTa8hec9QllF9CMriOhtJGJNPGfoQs3OaYPsBbsohVEQ96ZDThGV9P5TIdy1YsbRpSsj6lpS3m40VA7L14lcon5o9rcaKVlkSqXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkVnESfhsnZ0DNSUi+VAkdAkjpeRj3y1EvMbamsbg+g=;
 b=nEsRQbBd2f+34uhzpM/DFBNFwe0E16vMcjpHJf0k227+UDtvAaTr6nz0ZXu7+4In9xUtMhXanrocupZwrfRCJaAmIcxOp2crRUqoj1w5c1j17uYFmIm+5cAtrihX9hmOsGJmaOCJHuOyw3vNIJYb7i/D2HAWCgo0bgbjqEGwNdDxIOyWwPnIXRlRYVXzU7+Gwvkq5D0zH+F3nBsq63Puy2CK6rMiZmIIsONV28TAxSVFfCU17IdBk7Xv4GxJ/XVZa0unrIQeMJuGHIj6YtotISZ35rMRWcB8+OTMtfJzd9xYGsu94X1BHRr3x0TCL6Q9futTSmN0q07GhxNgUeHWwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkVnESfhsnZ0DNSUi+VAkdAkjpeRj3y1EvMbamsbg+g=;
 b=a90TY7ztl39BStBoq1OXJZDM08q2JKeIsV6LCeGehC4dpqYFm11zojMvCUA1LTjJiVXmK2QzlKmUKWynBv+TqJA75Dl5SorSNXaPBwYrQVVcU10tumXL0tUufA9HAKJS8VIZrG+7grVbIFL+qKnYY9y4KfgxUjFKACmpq/JVSnlKQIO8J/mkYEjjWEWyONhT9vw7xpV5zliQKtxm2wj38pnqZq5AqnlqTbPDukVm0E0v/0vgVIsTRDsfyDVeommyR+1PEjpCfPlLl10EyLt1tqaSx5n3mmkZUdgee7Qrwp3B0lRslfeCb4JLqDQpP/7FSHAbVzcPF9hpHNSBYHycOg==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DBBPR04MB7963.eurprd04.prod.outlook.com (2603:10a6:10:1e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 01:57:02 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%7]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 01:57:02 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>, Ulf Hansson
	<ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, dl-S32 <S32@nxp.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] mmc: Use of_property_present() for non-boolean properties
Thread-Topic: [PATCH] mmc: Use of_property_present() for non-boolean
 properties
Thread-Index: AQHbLuzDSVyjH5ejRkGAdgSrdTTHSLKn653w
Date: Tue, 5 Nov 2024 01:57:02 +0000
Message-ID:
 <DU0PR04MB94961FC52847FCE53F1A5E2A90522@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20241104190707.275758-1-robh@kernel.org>
In-Reply-To: <20241104190707.275758-1-robh@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|DBBPR04MB7963:EE_
x-ms-office365-filtering-correlation-id: 3876cf04-4374-45fd-38f3-08dcfd3d2452
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?YktHQUlKYTh2UlNjZk1NWVdlOVhhTy9CZGhWQU1vbG11ajVjcHJuMkE5TERP?=
 =?gb2312?B?eGJOQ3J4Z3NzRmxiYjNOcDlwcGFoRjBnNlg3UFVZQWxCOC9sblFsbXhyS1Ey?=
 =?gb2312?B?Lzh0UTg1aHBhTXhNYncxV25lUmQ4cjVSSFcxRW1Ld0FQLzRuQWNodW5obFBO?=
 =?gb2312?B?Vitkb2hnQ0NQSUdwWHU3cGgwVGRTTDdKQkd1R3JOUkpuV1Z1clJEbzZFOGFV?=
 =?gb2312?B?SmhVZ3dGM04yVFZzYjE3cHNmK1RmcHkrREZZTDJncVU1V05PTGNLZ0NDcXc5?=
 =?gb2312?B?T2paRmFSWFF2VVZRZm1TR2NzcVhkWkxpSE1lRC9XMElMWHM1Y0hJS2FOUkZL?=
 =?gb2312?B?ZFpPTXhZQ2hPWUErOG8xMzh0RDd2ZU9QWHNzby95Y2k1dzQwOFV2OUxwUDNQ?=
 =?gb2312?B?dkNSTXo2dXBkUFBNdFo3T3h0NmxHZ2N3VlJNZFlSck9CcXdmNlNXQkpLSkpM?=
 =?gb2312?B?cVVwVGRWRzc4dm5CMjl3MTlEL0NRbmVia3hCUnNod3dCanNpcjhSaUpsMjhy?=
 =?gb2312?B?VERWa3R3MlZjRG5NQTg3OVhERXpCUzFEQzFjU1lpemNVTGVHVzgvQ21tam5D?=
 =?gb2312?B?NDkvaGFzSHlCN0F5TGY3ZS9odDR2RjJZbGRkSG9IaEZoZ2U4cHBOK2J3bnlP?=
 =?gb2312?B?ekRJZ0pmWkd3eUV0d3lFNEdETXRlZTJOd0d1WHpVQjdUNDNvM004djB2cHlm?=
 =?gb2312?B?bFdNT2Z3NzdCci92TlFPZmUvNlRsK2pTeHRHWDJ4UUNRd2tITTRBeEI0MTFX?=
 =?gb2312?B?Y3hXNGpRNzJHVlh0U2NjNUxUYzdtaG9LY0JBbnJXeklxQ3BWclpEMnM2aFVG?=
 =?gb2312?B?SlVPMzNhWTRaTWowMkpQL0dCNHVrOFE1ZjZDTmgrMXZSQzdieW1qL042bGNS?=
 =?gb2312?B?NGN2a25VNkZSdHVVY05TVmVmdkN0NFZ4UjFkMEpkb1RCWW5IdFhGZFRMY0M1?=
 =?gb2312?B?dmYxdGJmUkZDcmIyTStLTFpFaUx6RmlLVDZMOXZoaW5KZkE0SWVQQ2QvQURi?=
 =?gb2312?B?YXVkWTBUQ3dXcjdLRWFBVFdQL0M2cGNxK0liR2ZmV1daQlNESGxpK0UyZHF4?=
 =?gb2312?B?amwvTmlRN2U3d2J4K3lZajlyTkRHdy9PTHlydFh2SlIxVjhuWXNKTlpyeHln?=
 =?gb2312?B?a0JDYWl1ZktHOXRuR0hmeDA2czFQSWMzSm1GRnFaSmhkUkJ4VEVkcHYzb1NC?=
 =?gb2312?B?cjdEaWV5MXNBZmN1MitMMlBWc0IvWjRCS3VxM0JTNUp1M2hxeDVGeTBMOEl6?=
 =?gb2312?B?K0ZGek0wYWhmbitIWk04YXJMeGRFa2UyRmpHRWxteTI0Rjk5SGo4S1ZlYjRk?=
 =?gb2312?B?bFpUSWJkWE9mYjZVa0JKOFBwQlBPdGhMMy9RTTB3eXRzWXBiMnJjUWgvem1w?=
 =?gb2312?B?OGFCaXpuR1NjTmU2cUFYTEdZbjJIRFQySlU4ZzdDNlZMc0lnR3hFd01VT0hB?=
 =?gb2312?B?TmNwUzd4WFZjWkJ4YUhnU24xbDVCK25WNzc2TEJCb2dab3U1OC9xSnpheVNu?=
 =?gb2312?B?Z0JWVjhrSEEveDZObEszK1JaeS9UWXk0TTBDQUJZVEUzbThWM1pKb2t3M2lp?=
 =?gb2312?B?V0taN3huekxmVkNvSkppc1RnSVJiTVMyY1liQVVyS2xBcmhydGhZZG1rQXQ3?=
 =?gb2312?B?a0xSUkdxMm9TL1lwNE5CUHB4cXdudXN0S3RTWGd1bFp3a1F2bXZtZ1cwd3I2?=
 =?gb2312?B?L01WbWVUaDRraFFmTitsZld3eUxUQXdoeTN2VXc5dzcwUzRyWDAvMERKOU9p?=
 =?gb2312?B?L1ZoSngxQVlOQmtuVER6UU44UU1HSzNsZ3phdWNTazk2MzZHVFVOT0UzUTlm?=
 =?gb2312?Q?L13IgbYMYBV1jfZIyGFoQBOsnGL6xEldnt5X8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?MWRWWjRkQnhsNVROanp4N1E0b3RCRXRDdUJhYnZ4UmVrMHN0cmtDbWJwNTRY?=
 =?gb2312?B?V1hoK1RnTDhJUDU2bnBlOFFRanhtSHFjU1B2aEw3eWFkY0JyZXZyZENScFQz?=
 =?gb2312?B?djdhdVRaUGsxcHRZT3VwY2ZGZTJIWVpxS2hrWW5md3FlQ25kU2h4Qnd0L05S?=
 =?gb2312?B?NHlNUjVlMDlSMWQ3blJISGVLcGYxTGVJT29jNHROTUJyV3BYSnJ0VENXV09o?=
 =?gb2312?B?b2ZWbFQ2Qno4bUVkTkF0bmhRVGNteXpSWVJVUDJsdUo5YzljbmJ1Z0ZCeCtl?=
 =?gb2312?B?eXNQdnZ5R2dMSnFROVZQdnpoaTBhZDQ3aFZYaXdlNmtFT1RYcGdiUmM1SXhF?=
 =?gb2312?B?UkVaM0FlSGFvZEIyMDhqbDZSZit3U3hmaDNTczRmaDlqTm1BZ1JqWTI1UjRF?=
 =?gb2312?B?SzVSZE5xRGcyY3Rualg2dnNqd2krUjBreTVlMmRYaGxSV0htWVVkbVo3NDJ1?=
 =?gb2312?B?akVJNTZ6NUI3ZTRSczRvRjJzdXQwNkJWQ1c2QnoyeTZLT2I0Nm1jdlRDY01J?=
 =?gb2312?B?ZEZ1dzAyV2hMU05FZ1Zac2tCU0ZSVGt2MENWKzUyZDQ5QkhuRUhQWGZuUHFV?=
 =?gb2312?B?Y2ZNbWkrWWFjRVhIQ2o4TzlEazJscUhuUW54Q1N5QWYrbTBac1dGdk5xejR1?=
 =?gb2312?B?WWRTZWVtcUdhaUF3RHdEenlnRVVaYmRqU055TG50S0MzT1NZYm55RXlOUGhN?=
 =?gb2312?B?Tmlqd3UzajZ0dklvVjRvSmhvdTViSXArbzA2N3dnTW1hbTZaZTFLRTNlakNL?=
 =?gb2312?B?VHIyUTlVWk4wNXBmdnV5TFVUSG5wMXJjTngwVVRJWXVHSjB2UVY0dU5aeUhj?=
 =?gb2312?B?SU84cW41MjF6V3VobjhFUUpPQjZCOWdCTmVzMWRjcmEwRy9FQWpsd0RjWDBO?=
 =?gb2312?B?Ky9SRUg1RHo0V1VacTd5S01XaHIwd09QY0NJcGJ1RkxRWFIyajNycW9UUlRn?=
 =?gb2312?B?QzU2WXh6R1BmcHltaWVRN291U3BNVHFpMnlQUnNuM2dibGsrbm8ycDBQbmFq?=
 =?gb2312?B?Y2NvZ0psRjcxTWJUbDBzRm0xVFA0Z1c1RlhxSGJKSFZuZS8vS3BvbTJKb2xn?=
 =?gb2312?B?aFJ0QXdhbHVoZjRSNjI1YWxnVnR3eXRwR2JJRjBGNVdYeWdMSmxQbHltUTVT?=
 =?gb2312?B?UW5GVndQNTNpV1pnNjVYdkY0Vk56WUdrSndTcUZnVVFVa1ZYLzRaMTZCRkZH?=
 =?gb2312?B?bDFiUThQMFRvRGxwYVE5NG5nOTVOMGZMSUw3WjJVVVRqQlZEdkdEOHV2Ums4?=
 =?gb2312?B?MEtNbVo1Nk8vYUU5ZGFybGR1d0ZyaDlVZmxjY0xqU2l2WGdHQ3ZTWjhPNTNH?=
 =?gb2312?B?WFhFY2QrUm52Rkx4andXeU5DSVRJQ01oMlZBMVVxT0VtbmpVTnFYbUVOV00r?=
 =?gb2312?B?Um1oTjlNUGErMjhMc3gwU29uSDhkakFUMmZHeGVQZ1Y0STcxL1lJaWdQajdB?=
 =?gb2312?B?c2EyYUZyS2VIK1hJN1F4R3hIUUdtTlFYN0QzdkoxQnY4MnVOd0RlNmhoUEE5?=
 =?gb2312?B?enNJQ0NaSzZGbC9rK2pGWHhzZk1rYXhJd1JKdldxRXJTalRvYTMyd2ZOemhz?=
 =?gb2312?B?Z0FYbEhlVWlKTWJSUnpyVnAvakwrWHVmTnRKd3ZpeERQaXNGTnMvaUxrL0R0?=
 =?gb2312?B?bGVqcGNNU1l2L2JVVVZIa002MHdJZEhhMlNoTEFkVzFET24vVVFvbm5rNitW?=
 =?gb2312?B?QlZPYlk1cVNUVVM0QVZ6SkRSekc3QzlTdEl4U0ZEWUJFajlHV0g1THBVd3pM?=
 =?gb2312?B?bGZkTmQxL05tWjI2dHU0ZmsvOE4rZ3RHaWZxdEIxQTJUcThwZkxRNW5YWEFz?=
 =?gb2312?B?TlhoYlJQTWhiRUhCNDc0MWxNNFcrQ2lTYmFrRVdHNWJOWDR1V2VhdkkzQm5G?=
 =?gb2312?B?Q2xMMWhKc0lMRi9NRTFOUlpqSkEzakJZYjUwdFpCVGNmRnpJM1ByVXVtbXUw?=
 =?gb2312?B?dnRTdnNGOU82NGhIaVBlSDVTZHdpeXI5RjZQWTQzRnZtUWJmYy9RRGNGSmtN?=
 =?gb2312?B?bW9MSHdFYmNGaFdZRm4vb3ZFNDYyU1pBOUhVYmJIcGtRZS9TbWVQVXZ6Sisx?=
 =?gb2312?B?aTdtQzBzaklhaEh4UnNGNHFKd0QzN25PeUJmMWZKeHpKTEFuSU4zNVU3RGtx?=
 =?gb2312?Q?jO4s=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3876cf04-4374-45fd-38f3-08dcfd3d2452
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 01:57:02.3450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wOejf92ZEYxRP2kPIv3Awl1/1pG4dVR0DoOsqPk31rrD0Gooqb3X0ZHryWDVHPb957TrMRSR2I3XKntXpjPzZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7963

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyAoQXJtKSA8
cm9iaEBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDI0xOoxMdTCNcjVIDM6MDcNCj4gVG86IFVsZiBI
YW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPjsgQWRyaWFuIEh1bnRlcg0KPiA8YWRyaWFu
Lmh1bnRlckBpbnRlbC5jb20+OyBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+OyBTaGF3
biBHdW8NCj4gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVu
Z3V0cm9uaXguZGU+Ow0KPiBQZW5ndXRyb25peCBLZXJuZWwgVGVhbSA8a2VybmVsQHBlbmd1dHJv
bml4LmRlPjsgRmFiaW8gRXN0ZXZhbQ0KPiA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBDYzogbGlu
dXgtbW1jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4g
aW14QGxpc3RzLmxpbnV4LmRldjsgZGwtUzMyIDxTMzJAbnhwLmNvbT47DQo+IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0hdIG1tYzogVXNlIG9m
X3Byb3BlcnR5X3ByZXNlbnQoKSBmb3Igbm9uLWJvb2xlYW4gcHJvcGVydGllcw0KPiANCj4gVGhl
IHVzZSBvZiBvZl9wcm9wZXJ0eV9yZWFkX2Jvb2woKSBmb3Igbm9uLWJvb2xlYW4gcHJvcGVydGll
cyBpcyBkZXByZWNhdGVkIGluDQo+IGZhdm9yIG9mIG9mX3Byb3BlcnR5X3ByZXNlbnQoKSB3aGVu
IHRlc3RpbmcgZm9yIHByb3BlcnR5IHByZXNlbmNlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUm9i
IEhlcnJpbmcgKEFybSkgPHJvYmhAa2VybmVsLm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL21tYy9o
b3N0L214Y21tYy5jICAgICAgICAgIHwgNiArKystLS0NCj4gIGRyaXZlcnMvbW1jL2hvc3Qvc2Ro
Y2ktZXNkaGMtaW14LmMgfCAyICstDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L214
Y21tYy5jIGIvZHJpdmVycy9tbWMvaG9zdC9teGNtbWMuYyBpbmRleA0KPiAxZWRmNjUyOTEzNTQu
LmRjYjFhNzMzNjAyOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9teGNtbWMuYw0K
PiArKysgYi9kcml2ZXJzL21tYy9ob3N0L214Y21tYy5jDQo+IEBAIC0xMDQ4LDkgKzEwNDgsOSBA
QCBzdGF0aWMgaW50IG14Y21jaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2
KQ0KPiANCj4gIAlpZiAocGRhdGEpDQo+ICAJCWRhdDNfY2FyZF9kZXRlY3QgPSBwZGF0YS0+ZGF0
M19jYXJkX2RldGVjdDsNCj4gLQllbHNlIGlmIChtbWNfY2FyZF9pc19yZW1vdmFibGUobW1jKQ0K
PiAtCQkJJiYgIW9mX3Byb3BlcnR5X3JlYWRfYm9vbChwZGV2LT5kZXYub2Zfbm9kZSwgImNkLWdw
aW9zIikpDQo+IC0JCWRhdDNfY2FyZF9kZXRlY3QgPSB0cnVlOw0KPiArCWVsc2UNCj4gKwkJZGF0
M19jYXJkX2RldGVjdCA9IG1tY19jYXJkX2lzX3JlbW92YWJsZShtbWMpICYmDQo+ICsJCQkhb2Zf
cHJvcGVydHlfcHJlc2VudChwZGV2LT5kZXYub2Zfbm9kZSwgImNkLWdwaW9zIik7DQo+IA0KPiAg
CXJldCA9IG1tY19yZWd1bGF0b3JfZ2V0X3N1cHBseShtbWMpOw0KPiAgCWlmIChyZXQpDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+IGIvZHJpdmVy
cy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBpbmRleCA4ZjBiYzZkY2EyYjAuLmNkYTE4
NzI3NjllMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXgu
Yw0KPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+IEBAIC0xNjI5
LDcgKzE2MjksNyBAQCBzZGhjaV9lc2RoY19pbXhfcHJvYmVfZHQoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZQ0KPiAqcGRldiwNCj4gIAkgKiBSZXRyaWV2ZWluZyBhbmQgcmVxdWVzdGluZyB0aGUgYWN0
dWFsIFdQIEdQSU8gd2lsbCBoYXBwZW4NCj4gIAkgKiBpbiB0aGUgY2FsbCB0byBtbWNfb2ZfcGFy
c2UoKS4NCj4gIAkgKi8NCj4gLQlpZiAob2ZfcHJvcGVydHlfcmVhZF9ib29sKG5wLCAid3AtZ3Bp
b3MiKSkNCj4gKwlpZiAob2ZfcHJvcGVydHlfcHJlc2VudChucCwgIndwLWdwaW9zIikpDQoNCkZv
ciB0aGUgY2hhbmdlIGluIHNkaGNpLWVzZGhjLWlteC5jDQoNClJldmlld2VkLWJ5OiBIYWlibyBD
aGVuIDxoYWliby5jaGVuQG54cC5jb20+DQoNClJlZ2FyZHMNCkhhaWJvIENoZW4NCj4gIAkJYm9h
cmRkYXRhLT53cF90eXBlID0gRVNESENfV1BfR1BJTzsNCj4gDQo+ICAJb2ZfcHJvcGVydHlfcmVh
ZF91MzIobnAsICJmc2wsdHVuaW5nLXN0ZXAiLCAmYm9hcmRkYXRhLT50dW5pbmdfc3RlcCk7DQo+
IC0tDQo+IDIuNDUuMg0KDQo=
