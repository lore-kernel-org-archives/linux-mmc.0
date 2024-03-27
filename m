Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD2812E1ED
	for <linux-mmc@vger.kernel.org>; Wed, 27 Mar 2024 18:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565039; cv=fail; b=qGWtcNo15gv4mtlJlGj9iHApsZ3KIZWHQ7K2I93ChHjcWI/SJWHc5rO5Qonqrdvxv3BbVn6ONnCPFe1TbvZQ718mteYTQwIiAL7BsI2WWtXuuStBm29L5XcItn8iWq9b73VLVOtKBqBE78g3gsLgcTGYeloaBu/cpOIYN4TZP+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565039; c=relaxed/simple;
	bh=01kZ5jMz9+u+G+Y7BjU58fLSujEje0TSHq+abmo1DJY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OuNH8db/wWS+sRR6HlZtIoiJaKkGSghWtXVQpNI77Jv6Tq27MtIsgHkr8Tafk1Wx9x/ghayOmXHq+ZR3gPCTKUIhVHwx/u2a3TkPD0DxFSBdDTJpOnk7dBhHY7PXwE/9IIWM2kbDDIojSEKLlXJRw/T99uRkDWxTNabV/2soyyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Npo7ALp2; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=OtgXfadE; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Npo7ALp2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OtgXfadE"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711565038; x=1743101038;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=01kZ5jMz9+u+G+Y7BjU58fLSujEje0TSHq+abmo1DJY=;
  b=Npo7ALp2gfacBTcx43C12MYQpZT0vSyKAt+wiA/iAaPI91EybdS+PSFI
   mwB2v4ddO0GDONEkIHleUNMVKaiNyzVwAKruoJkLnRFmhOgzXh2bsot2y
   7XJh5+efEROx59ZrXzFOZbBqF8TN6T63p9Di0J0KGHVNCsCWEO3D9qNCL
   8SXXg/LC821zcKPsMldIGyF4Q+oPKYWqyTUAild9aJFPHTLk3jcKmpyu3
   44QzXgW9ARdIx0zgrkzgwzub+d2jXfOFcitobomB2ALIMABLh5AlHDVc0
   wH48Wxz3cT6NzkmgCtx9UrFYeQ8+4zXhnzy2zDa0UlhWygY7hfluCnljq
   A==;
X-CSE-ConnectionGUID: yToTTktOTqeF39E5Yty/+w==
X-CSE-MsgGUID: YxRkq9zUQiONVWlbEV/tGw==
X-IronPort-AV: E=Sophos;i="6.07,159,1708358400"; 
   d="scan'208";a="12473346"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2024 02:43:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkD9IONqf2IUMuWE55y9cgLHtV5JWHwYyJyYw8J9EXXuOEVqmD73z7rjUL+frb3wPwS7JYMKPiBvpaN4354UjU2YxptKTssYawPW2EyYnFJdwPhZvLbvhgkqT5qKDIcNNSPI8BMtYb63zlTqgATx1zsFpiECPtotKyvDA45KAlS941Oa8S5ZZVIJSPcgsbAzcpbU0h6f9+OXT8VPxNb4RP7UQ6bjxS6JeQDrPjoyX6wISgx3VXtiRNoOPAas8K2jvDwej4CLFPmtFoMi6UVmTM3yc+tppSj5r8b3mKRn9bHcux3PSNl5vrahxggs420ZYtdT3849Qa9FsXqLqm3Emw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01kZ5jMz9+u+G+Y7BjU58fLSujEje0TSHq+abmo1DJY=;
 b=IqBWfsAFIos6LbiidAyGOwgjFKnIDIdi5jmCC8aK0L5P39lLiVM+EpHX46lD94L+0gY1FdonfdVc1EdAqfuvCdV8SxNZmq00OKhxFw/xikrDftCVtazcvhSsnIrH/AIRSdoI3uJeDMDX1lWzEUImEobE2ZLbU7ththZaNo05Jp2xXWnk4WSnqTA774Rzj4pCiXYJ2T6mAiUt2X6LmaFJ5/ipPo/dwxD3PWUkeCR/9IKT71jnZnCUgigIQzEwsdY9rjEYSev2zpRrGiaj5PqJq+ilZiX7zHhlRwZCev9ToXROWAGFNl7vDmgt/ENuuJkd/nYwMum0Q6xsViL2x9RPhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01kZ5jMz9+u+G+Y7BjU58fLSujEje0TSHq+abmo1DJY=;
 b=OtgXfadELlPpu7lsNHwpN9HiWsvGD53o1UBPjisMSg/RVuaiYKDE+7TW/UiCHSWixRVkinkTueujoZGXkewMnUxSgc+UQPZUI2G5YXYXjCt6eGOGub2JUAxX3M1Gd4a6xubVwR8OQWEaWUw1Rn8luH4lSdTN+63+oFjCrea/Pc4=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM8PR04MB7958.namprd04.prod.outlook.com (2603:10b6:8:1::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.33; Wed, 27 Mar 2024 18:43:46 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 18:43:46 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc-utils: man 1 mmc-utils
Thread-Topic: [PATCH] mmc-utils: man 1 mmc-utils
Thread-Index: AQHad7fC3h3I7R7vx0SjpOhzsx6Hr7FLvPcAgABA4VA=
Date: Wed, 27 Mar 2024 18:43:46 +0000
Message-ID:
 <DM6PR04MB6575F71F6A3046BCBA54944BFC342@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240316153636.30814-1-avri.altman@wdc.com>
 <CAPDyKFoAntcQRwbTju=x3bYe9S6dfEeyODdFGSVqHfcek=YFhA@mail.gmail.com>
In-Reply-To:
 <CAPDyKFoAntcQRwbTju=x3bYe9S6dfEeyODdFGSVqHfcek=YFhA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM8PR04MB7958:EE_
x-ms-office365-filtering-correlation-id: 61662495-4f11-4c86-4fcf-08dc4e8dd5c2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 plqroU0UUzUFHagBpABRIDstBzm+6KXqoeoVRpQvqGF0C5K2Bd6NMtOOVOXsCSoEZ0KbGHkElp6opefyxcrOOW7VI2kt1AvaX7vu5wdEVKBqvoRn1eWKYKqc3+MwgD5CbYJjAtlENJJNuevI9gBUHFfbZWT+dvO4NcInY4TxSjGzU6bF5dGllFkZaKJjPMvQEvWEpx/B6V+/5n5lRb4DVK0KkfH7c+uQsMIgKovPVX32fHxvbb6pZcz06Cp4y3KPVwuz4Z/D1H3MtrumijEIs0B7q1FbEYicVp4DHdywxCczq53tyuJzsk/naS+tr+wcwwvTX6cxVV9KUaLTU/NG8Gjs4ZYNBM/rQL2OfX5PhIFsmGuTAiM06P60QbrOni5GY096awloN1jzjh8uuHip/AsK2wkH3l9hudiGc6Zq1FoIz5T4M2VM0aO729dv9MgK/CIafqD4nrtpzWTTDJvdeI9vkVFSFQHECfqOxqxCkNHsQx0ZAdD5ffE7LrXQy/pB6hVppQhiED3ml4ZRBcMP7QUv9QE4OYPKrZ9jK2eNqGtOUtyJdR/faV/PBC4S0BPShnJEPO5N2Wo8gj/39STR2JpUilWTqYywfJVMF3UO9Abak3pGNQrWsPhYCgdLDHZnNU52TdSlngNoS6NZruE4Zua2WWIt8ipfFfqduWvHt2WuzR2VglZWhytP7IvrANX/N6mK+yhjLKf698SxemzdywTQMlFz80nVEgEAuUOy8iM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OW43NmZJZHJHREhlZDQ4QlVBVC9jai9FZ2NxUzQxdm5YWFlwa05RS3docXYy?=
 =?utf-8?B?SmU4ZnFkMkZXN2ZrQlViRG4rOUFibVdCd1BRN0IyR1ZmckNLSElKaEFzNWFD?=
 =?utf-8?B?OHNlcmhPZSs4aTY0ZENUa3RNeUdLTHA5Q28xZFQ1QTk2T2YrMjZFeFYxV0JT?=
 =?utf-8?B?TnRia3oyc2k1ZjM3Y2R4ajhuWVJ0cGpJWXZkUGMxRkUzVEFhaTZCWEh4ektP?=
 =?utf-8?B?L2FueHl3U1ljbWJTRHZWNFJweWE2ZE9wVlViUjdRUFZ3TGVCbkdoNkt5TGRH?=
 =?utf-8?B?VWhXQ2YwK3BJZjMybHV5NE12VXV5L3ZGNGNJd0ljc1NVamgyREhSK0tZTEJ2?=
 =?utf-8?B?VkFkMVRid1lQV2ZuUERDUTFvUE0yeHVybmZoaXRXcy9YMFpYTHRqd1VPbFNJ?=
 =?utf-8?B?RFZTWlVJVEU4VnV5VlJCUHB5dHpWdUZiN00rQ1I3bTNDUmJBSXpPVDI3Mlgx?=
 =?utf-8?B?RGJaQkRkT1BoeE8wcGVjOHpiUGZhVkczU29PcS9TRTRhMVVmOGJLUWNBTVZU?=
 =?utf-8?B?OThYQzRQbTZEKzlBSlFBNzdxaUxHeHR2cWphd3BYbzhZdHVsejRHUGtsZmRJ?=
 =?utf-8?B?RjZNUUNZZ3NCWGFzbUdmM1p2TDZ1SkIzOWh0ZGFSMTZweEVBcys5ODdub3FC?=
 =?utf-8?B?MStPemRnRUNzd2diaHZqQ0xwVjB1MUduTGMvRm5qaVlZS045OHNnTGdGUDkv?=
 =?utf-8?B?QktpZzBsT0VxNHpVaENQdSsvN1RiaElxWUFtQmMvT1c2NGtFenJRRUxTUDVW?=
 =?utf-8?B?bC9TKys0Uk1aWEdyYUFndVBsdGFMT05QY0pPYWNRQ2JXUU94aklJYTQ2dzVW?=
 =?utf-8?B?bUlEam9DREFuZk8yMy93N2xHa3ZoSDNQbzRtZ2tqR3F0bk8veFQzNmhFYnQ4?=
 =?utf-8?B?MkFFQmdEekFpQWExbzVRY1ZvTFJqSCs2UWp6Z0FFUlZFTTJ6VVlJUmN0eUM3?=
 =?utf-8?B?M0xjZytXV2EwN2ZYY1JhVi9obzEwS0dnM0pyMCttbzcxSUhmYWFYMzQ2Rmd1?=
 =?utf-8?B?WWlYbldsWVRsRVZ1YUMxNUhoaWw3YS9MMUFnSkg4Uk41YVZrSVZVRktSdFp4?=
 =?utf-8?B?b1lTK2tQbUJ3UktNMUFwaWVkeHl3YStwY2UrM0JMUVVuc0phekRaNmRVV2pq?=
 =?utf-8?B?bkJIZzBodEN0Q2l4SkZvb0JkaHF6L2NWeWR6UkJ4azllVzJjVjZMSXMyUXp5?=
 =?utf-8?B?cUYwQm1ESHJpRjFTOTRPeC9wQnZ5dTQzbzVWc1JEODJhNnN2d1VIcnR0RU54?=
 =?utf-8?B?RDNuRVBnN1ZFUStNemRtSS92UC9zVUdTT1o5ZXZ3QWR0Zlptb2t6Wm1EZ3gx?=
 =?utf-8?B?Y0xkejNzaDNETjE1NGFCR25ibExqdHhGaUIwOWZYZkxLT1k0Zy9NeHlMUmlp?=
 =?utf-8?B?RERQbDF1VS8rYllBSEgxaEpCYmlFK1ZIMTlVNkJEZkg1M09VUW1oN012amls?=
 =?utf-8?B?Y1JITEZtSEtteVI2T0NXWFlmM1BrMmo4MUxKYlYvVlllcSt1TnFlaGlYTDI3?=
 =?utf-8?B?RnR0dEVHemxtaDU2RkxwK20zbjR5NXNja1lVbzV5SDZ5NUVsMXh2cFYrUzV3?=
 =?utf-8?B?TjdLeVVsYVk5cmZwTjJsYW1maFVadHo5dzVHdHZGYk9SYzRvQnhjSTRKb044?=
 =?utf-8?B?NFdJUHFXaGswVHl5cjNIb0lldTRiTUNvRzhsWjFVbVdqNHZLOGF6M2JrWnh5?=
 =?utf-8?B?STAxdjkxUXh2NCsrdjNEaWk1dlN2dUVFL1gvdzkyNnVEYXZyL2pNSERpTGpU?=
 =?utf-8?B?Qmp1QlN0d0JTVmgzbEZLSVc4M3A3TDRtZys4NHRtZEUyaE9EbXRPeXRYVkQr?=
 =?utf-8?B?ZVZ0VmIvWkQ1b1dzS1gybUwxTXRmK0hnSUxlM0VYYkVrNjQzeGVVT2ZPemVO?=
 =?utf-8?B?K1VZc3dwYWlrT24wSk1VcHUxcFM4UCtsY0x6VkYrYlhLZ1RJWEdUdEc3dS9j?=
 =?utf-8?B?UWRHTkRqbkNiMzYweXVUbVVkYkhHeDRUS09YUmU1RG5aUHpWdUZRdk5sWHY1?=
 =?utf-8?B?UTJCQzhjRkwrN3ZDYVhaZlZzK1ppOE00L2NtM3J0UE92S3doZkoxWFREQVlq?=
 =?utf-8?B?QjV6ZGdDTjhKSUxCbXZRNWZRS0hmMGc0RE4wWGV5blErT1QxTU10amRqeStU?=
 =?utf-8?Q?wLBLNBnK+JsvKnKFTtLhNiCMK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HTDM7xeanWC62yopR8wSwuf3XQ571GmVCdZj/EQa1pe2tayVCiNgCX7Mw0GiIguH2F3oKhrFyB+s+sME8pJJkS99Alvl0W3bQx4Oml3sETrUO1jfaIzhIy82MlvorgbdXaf50OXOhz7T0nhMCWAeTsiktenHZg40ynuu1rNCOLNtJ0HEdKOIHrFX4NBxcTDUaYnGXs1pBN/szN/K/g7PDsk5N9iwgbPSQHNx5LcG6AaWjp3xe/FyMlge2bVBYT7flayzktoZGopt6yjKRmUQIOiTliVA6RFXWBKeJLbzlCPvYtbqDuyslfsons7WwRKbL8UhbWxvPsj+qEPV4vmDClHH9Z9elG+BX7RVImlLL98h0f4UqZ+xAiYS3X9sI1qEiOgw+NVM+7M6ghDyMekvdebZV7FotVHbFP8JRwyD3hQ7BkwX8/5JRJzaiC8JD/pHH5fxBE2meCTWEl7234cfAPgCSpgp3Jhb/qBYeOHj1Qh0sZphOiQlNSn7is2fVgbTmVF6qRMfx5BsrzcEgNbN5TM++UhZPagDOz3r/n1ZMB0JZ6bScD+SrADaH9EyATgpreUGwKE2VvQbonPRGyMn3nAZUiV77ijuNiCrfcagFRstEwTBqfvlcUNxJNPiBN/p
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61662495-4f11-4c86-4fcf-08dc4e8dd5c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 18:43:46.2913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bvK2Bv/ihch+Fk06ONuAc3BjKop2PbF1Y/imxGDyOZ2E51SKyQ1ok0w3KZoq+N4sExDRwo5GAvUlWU32SDB8ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7958

PiBPbiBTYXQsIDE2IE1hciAyMDI0IGF0IDE2OjM2LCBBdnJpIEFsdG1hbiA8YXZyaS5hbHRtYW5A
d2RjLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBJIGhhdmUgcHV0IHRvZ2V0aGVyIGEgZHJhZnQgbWFu
IHBhZ2UgZm9yIG1tYy11dGlscy4gIFRoZSBjb250ZW50cyBhcmUNCj4gPiBmcm9tIG1tYy11dGls
cyBoZWxwIGRvY3VtZW50cyBhbmQgZWRpdGVkIGZvciBicmV2aXR5LiAgVGhlIHBvaW50IGlzDQo+
ID4gbm90IHRvIHJlcGxhY2UgdGhlIGV4aXN0aW5nIGRvY21lbnRhdGlvbiwgYnV0IHRvIHNlcnZl
IGFzIGEgcXVpY2sgcmVmZXJlbmNlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQXZyaSBBbHRt
YW4gPGF2cmkuYWx0bWFuQHdkYy5jb20+DQo+IA0KPiBTZWVtcyBsaWtlIGEgZ29vZCBpZGVhISBX
aGlsZSByZXZpZXdpbmcsIEkgZm91bmQgYSBjb3VwbGUgb2Ygc3BlbGxpbmcgbWlzdGFrZXMNCj4g
YW5kIHNvbWV0aW1lcyB3b3JkcyBiZWluZyByZXBlYXRlZC4gQ2FuIHlvdSBwbGVhc2UgcnVuIGEg
c3BlbGwgY2hlY2tlciBhbmQNCj4gZml4IHRob3NlIHRoaW5ncyBhbmQgcmUtc3VibWl0Pw0KRG9u
ZS4NCg0KVGhhbmtzLA0KQXZyaQ0KDQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0K
