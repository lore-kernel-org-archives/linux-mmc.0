Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C697630C616
	for <linux-mmc@vger.kernel.org>; Wed, 10 Sep 2025 07:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757488591; cv=fail; b=Lo9xRoYxjfVOIE/gUW+saom78JjhfER7rTtGS/Cp8l73spsr1NnYIiDkLIIXczJBU5DZ2UHrk5BlBLLHv+YIlKYZEUaar5/0YThQlPEXdSY20NxVWn8J3nNs7XviPFpuM8YnvUmfqTmKhmRDmIjkJB4wgT4nKvz3U9zlk0fvJQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757488591; c=relaxed/simple;
	bh=9neHTlpcY8ud8NNLZxVBU5jAz6gRt7uQZCGMDTbNhO4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kB9DI3GCFgnl/MOStoKyFO5tQF7BfGML2D0MEFWIZU5g3LOmzARhNLTEJri4XDPjvyRypxTpfyO65Cpq4ajptKMMuEECVUOYOVfEoVDXQsO7+FuNmd7TaaWOwwqhTxbrM+ZkrNLN5I9SXtJYqJLpyxfzM7euuA0U7jQmwLwxDKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=UqLhtdQ7; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="UqLhtdQ7"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1757488589; x=1789024589;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9neHTlpcY8ud8NNLZxVBU5jAz6gRt7uQZCGMDTbNhO4=;
  b=UqLhtdQ7qu1hny5fYr8HXqach6m0OIOqmlWuET5QI47e6Ne5Ygj3N/DP
   kTw1SH4Y9vHl/OYmpGXEDwBmB8H5X6P9ay6ABg85Uz+92X1WHJM//V6hV
   OEuXHfTUQ0zA8s8hVaNXBpo6kuRmchyk5/B4HGbS2BNjecrLpNxYElVNu
   hNQzVODEfPyIRRDOgzrxohZk13vkZhayfUYRdVbez3i7oO4vo6QsLyWsp
   tWU7heUctGh+D8x9K/p29EwhPs7ZHulfNg6TEbsecm/+K8dG22yZHUdL+
   L8EZZGli1pI9plGqCtJUdhzf+KUHYFsjoRst2eVMHVb/WNP0tcl/4Llpe
   w==;
X-CSE-ConnectionGUID: meiGiCmGRKiV7zMWPjw6zQ==
X-CSE-MsgGUID: zdDQbO7TROWjLErEZ+gxwQ==
Received: from mail-bn8nam11on2112.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([40.107.236.112])
  by ob1.hc6817-7.iphmx.com with ESMTP; 10 Sep 2025 00:16:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dvt85mTUrhjVJQUb5DmNTtO12sHQ1C3sQya0aef+7BiGX1wETtE3xU/b5O4+LQ/pdqWUtpXwLDoQu6/13m8I1lc/52ZCltEBjMp2olT6ZoAXjsMpUnIYUAO67YM4OZ4awZ/SF/CgFGzTJfIdJ7p90icKWRiW64P2LEgF8rSCEOdVaNny8HIG8xT1UAaM8boMbCgdWoevteWhNMX84AsEnQRu0LtiIB+h3K7F2sNoCTsqyIcrgxJcfUPxYuQmWn1NgqO9X7UKPjEGQ4KLcREj5gqmYX4PCfw7kyWzDf4GDuI3GSWXskqr9TV21iWb0DKnpzcOZOc4WqEqOY8XIxjkEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NevBT01GoGPrFIZT497PKhMhAQEINp5xw/5+QjQPyVY=;
 b=hQ9cAkKnNLG0a3P9DO5RTdmCiTIWXDTC+i15KvCxRfe9eH9nRCCmfWyW5Fxb0apw6yGCHlGq8JPeyjg41Fl0GfEGaJ+7BX5IXcXEJs+IoHVh+MU7VYoiqNf3RZgT1VvblTmYjmsW7kzwuimKssTYmJ20+deNocI5r0Y552P1/kONYbM1BCLdJMngh6VO2Qp5Mw7dvIOSAOOKw8A4K50Hom5yFmJXag+viRwmW//KCE0/V68VZHgx9LtsqZq7li8889LI2hZwGWl7e+fl0BEAk5QfLvERGRTBPJIlSZU1z58F54lq57tFCtQ7myDe6zcNxVOUyL5BYVTavTqH9SZljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by MW3PR16MB3833.namprd16.prod.outlook.com (2603:10b6:303:44::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 07:16:19 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::d65f:a123:e86a:1d57]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::d65f:a123:e86a:1d57%7]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 07:16:19 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Bean Huo <beanhuo@iokpp.de>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "jens.wiklander@linaro.org"
	<jens.wiklander@linaro.org>
CC: Bean Huo <beanhuo@micron.com>
Subject: RE: [PATCH v1 2/2] mmc: core: Improve RPMB frame handling code
Thread-Topic: [PATCH v1 2/2] mmc: core: Improve RPMB frame handling code
Thread-Index: AQHcIc7N6mw+bsPdKk2+uz6fcaeYvLSL/F9g
Date: Wed, 10 Sep 2025 07:16:19 +0000
Message-ID:
 <PH7PR16MB61967841097FC4DC0CA94330E50EA@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250909211316.1857198-1-beanhuo@iokpp.de>
 <20250909211316.1857198-3-beanhuo@iokpp.de>
In-Reply-To: <20250909211316.1857198-3-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|MW3PR16MB3833:EE_
x-ms-office365-filtering-correlation-id: b0d771c1-e71d-45ca-597e-08ddf039f089
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nSXdC4AVzO3nvN+y+Iq29/nEJQ3M7dRpqrGwQVo5ueHJc5DEdW8Rgi2gKIjV?=
 =?us-ascii?Q?WZ1Avv2IVvAgf1dKLzVTqYqxzAoX4B2f/HjgLyYRxNvF683q9w+fht+PW16k?=
 =?us-ascii?Q?ncPpy1tsUuwye132deoAoX5o6B6j1vsa2dc4HS9Md0Hn/b9liWQRbvhXjn4I?=
 =?us-ascii?Q?Lo35FY8vKMw+jsP9nFcfq8xmxYWWmOnyrqMZzbnA0nqzqpgMvsHcPaUPolaM?=
 =?us-ascii?Q?oPqgfJ3G+CpuM3liifswX9ZFtwi/HLUabj6vQtALIGcQ9EEh24XFhTs3upRa?=
 =?us-ascii?Q?JXNZP2CNY1U1Z4PaQujlri0TFVrI68sDDIRk1YF/gDlJLActSqzcGB/Ocl8X?=
 =?us-ascii?Q?NFrjE0AUJvuC8dgkXGDzoQyWne84Ay5D29KIuYYSzn6Ibtsb8KKak0kJlYA9?=
 =?us-ascii?Q?XqNsbZglabU9pN9ljDXA5+zznXIhAJactkKRyMKccs7LNgphiYdnPGe12CMy?=
 =?us-ascii?Q?g+IXqfQt4JQAmWgB5O/d/r8wUFW/LY+CAekeU7u5rsUhNa+N9yndKn+yleP7?=
 =?us-ascii?Q?nocTD7B//WdIf2DblWsjeUb9ZvEVnHvmN0J9I6ce6wh/M8J5pS5QWNh37ZDr?=
 =?us-ascii?Q?27W/EPFrgAhEjZr4CaL260DNAmBNvyW3t3IF8fxcvjwWIWU1JP33tWZC+Md3?=
 =?us-ascii?Q?CLdxJ1b7Lpqihlg93CJxf3nekEM5V/Nc81XiX+A5XFBBEZOFxeuXLe1x0eDX?=
 =?us-ascii?Q?Qd08m3fHlQozN2P04pwLM4WC0JyLxrZShgXzcl5jnHilw4MfTVsUNwLvF+ec?=
 =?us-ascii?Q?DAi9yZR3v2W0px9MSFQCoaBue9gPMT+jb+iM6q466lKNXgaD9FzG7XBf6Msm?=
 =?us-ascii?Q?3w7e7JY/z340TRvb3wG307+cmDJSGHhMd9qgu+xa+RWHWqVQ7mRyoarcYK9J?=
 =?us-ascii?Q?qd08OeAhoHBYycrZHt3wAJ/3wywIuZDFqX+xX0JBKB4pLQ+6IWHhxS2BysOP?=
 =?us-ascii?Q?kpybMeWydwBs8VTIhiVe+C/v2rxWROzeQyCzUfCsPAChkUW8sgB9WaYioqI6?=
 =?us-ascii?Q?bNh/qKWLC/UW6SKqrgLrzHo90mGh8mINsSfEv35Vi464pwLBT0jp9drrVK8F?=
 =?us-ascii?Q?lCOQ/2s1NAP+R4ozWYZLD8/x/JukznteLbowHjMywvfNsVtF72rJ2JSXuygw?=
 =?us-ascii?Q?z30irxsZusQ86RAyGOubSYu9fsIkTrb3tUYU+I03eExvpFTZU43DP2p8oOO9?=
 =?us-ascii?Q?7agYBcagiB0JQDuI5boHsKJHA03JVgzd9F9x+K0xlbXYjBOW3zDCZvz3IAYP?=
 =?us-ascii?Q?y/wBTtcNPq1Fg2jVdJvHmoBpt/0wlcgbklhY6UTY6JOBTaGWS0Ut8Bi+or21?=
 =?us-ascii?Q?PXNc2Xc67o3gej0k60XsJRxAdTLRnNQFvH9Z8eRORYupPVxv15PlyjV4Ycye?=
 =?us-ascii?Q?8Qi+oPpZEr9CkcQw9GCgFdTmTRUftq4nn896Jq2w8bCQYRXFG/8xzhJ2ZUJU?=
 =?us-ascii?Q?DDcg+mDvS+v13zBK8TYIrtC6nN+yylkJDZpkIBXAcAV/J2pV7XYUe4Y+BQ4h?=
 =?us-ascii?Q?fn51fuBf0Gp6Z5c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dp8i5zDHf8v+stRGVEG0OSBEqbfIQNV8slWRADr1tNJAuX7N/u0aJTfIVxip?=
 =?us-ascii?Q?W1S2GM5NUi0XAS/00mXjLj5X3fwWRmQpeWKyquz7mdZDMuBz6G/Fma/mYuEC?=
 =?us-ascii?Q?b7hXY2fpRgjXDF09q5xlqb3/FWch27kyOkJUEyFs5S3j3e5YSKqDHxFRtiPG?=
 =?us-ascii?Q?8e8CACCaW/Wm82MFl9VVGHke//dzPce49zMv9aTl8mjp/17rMk3BAPseJmaL?=
 =?us-ascii?Q?lJiIUJYmvc4qeoT1d6CkVdVxkgGYrTa8+G7l/VwkgU1SrAmOJTX4NQcpC7hj?=
 =?us-ascii?Q?GP4SQ41dxkYzVbw68Q3Bs1HbYJmBZybUOv4dO/VwWzqco2g3Da7DFA+lyFZd?=
 =?us-ascii?Q?QvKxhcUOsIzPPUPA8CN6MgfHcU7EEXb1LOaPDSJmQTtuti83XQkYZkFAcz67?=
 =?us-ascii?Q?xmDe6Cw51O96B3dUz18kzLosm8mHp0OnJ78zKRSiESRm0910lg94UqQYaT+C?=
 =?us-ascii?Q?JZL1sDXJfwnCE7aMUrwuBU3g7CdkAz6SVA1fe1DMznS0fpwXsLTgk2HSgZb5?=
 =?us-ascii?Q?HPxux1CNor246uwXhY29gDBMIXY9BC8zOvk6YOh6HJtkel+UEBeSs8dAeTdI?=
 =?us-ascii?Q?neFmd7dQ35FGq/GF7KKYRCOUve/dkVyysOAUEfJGGS0X9+SishGV6Scaywfx?=
 =?us-ascii?Q?Ew82O9BflzYMJxfDQHD7JlW26NLYd2zyYpKueW+yx9av8JcPItsuyXuKlqFb?=
 =?us-ascii?Q?t/SyUPvtNoURqv8ds8u9yJ2IqT9gmureMlchU4MTI4JaltyMDiLExmia0HUN?=
 =?us-ascii?Q?QfPnVpE+z2qnH3WPjBXgFvJ6Ku6pUYRSWlkRK/IskzkHB/FZNWggNOGzyq9D?=
 =?us-ascii?Q?DuIwN4ldNUsJJOF5pbw1NDa7jtjD1ZqwAwXGlkxQoFwAkQcVqz4gVaxc7Kj4?=
 =?us-ascii?Q?1hQ98oCcKGBaMA9NAmMue76E28yPt9EfFueck8hRL09aS2Cu7s/sEoclh5/K?=
 =?us-ascii?Q?VPeLszXOLUM6TNBSmXIkS4uDR3OnpYp/KH6nPrU76Pf21e/hQkcYChHFw+li?=
 =?us-ascii?Q?AvN+wRTP+c6OCyJaIrVDL4BjnaFpWQFuvGi7Z6vFJkuvyu/BUjNQKqF3tZfU?=
 =?us-ascii?Q?nYaWs4/dEdi0SYBSNB9LUgBsHz2X1ta93ScGt7ZvjMYDDfZPPJ2NztdIwoe/?=
 =?us-ascii?Q?vYp/iyIlM41kMWev8QxuzuiNNnXcrN/a3ReOO8ze4kfL7i6zWXXuLjb8M1UQ?=
 =?us-ascii?Q?8nh8I33CRXPLDeXdljpyd0MPLfqFYsHLkEPMJKwJTMyOIEZtsLTu76dYaD3M?=
 =?us-ascii?Q?bzusqXAn0tcxI3Zpbh2J7GPPSmH9Yg3rUd9IlgAdvEQjJXWp+Uepl7yLEW/B?=
 =?us-ascii?Q?8Kwj+zUIYnGFMO9YS6zXtECUnSEiydOV+RxDHIxmq3D9FZyuAUzpruZ+5V8i?=
 =?us-ascii?Q?acHQok8BQ74W9TTw82qzvVM5FFjh9u2xETj43qVwLsEZ7Rv9+3YwXlmxWvax?=
 =?us-ascii?Q?PhJh0scpxMrP6TF9fgZuqplp1zMBjc7agR7FkqjBbGucsuHV/bmo+Z4ooxhk?=
 =?us-ascii?Q?JQTtPOT/yeJFPYADUNpXC12uE+Ht/Oi3BtWN285jGen0vNaKE4x6Rd2DE3vq?=
 =?us-ascii?Q?DrCQHKkfwkuh6CJoM1lPjuL084NTaofzRurgXu7n?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mjJn3rPDR+vAwtqfeKaTGkbWHUooEpyaprZKK+0CB29eKs0CX+WkkRtmJ0Ao9yFPoZ/SxUKmVk/3ghRVTeTmlbAH6QLakNIC5T7kgGEurwvAKpKssDQDFYsfkqWuTH4mCPaTIJLjnARp/NQXtGtbd1Ndn8rfrt6tIamvd0UM9mQlgQw23NxlXTDciSgh7udsB++Lpj+h4RtIbm+XI0NdbtnUJ6ORku/qvOCIcDFoh8tk4oUDqO6anuC2FZ741eljvmM+4/jge8UNm/LkGEB0WlOgL0gSANUAfi3L4XFojciXqrxt7s3Ep9lOQAGpkTofodhcu2vkm7GIhkhMCI2+2mgdwwfhu7efzUU7RRKx2ZKGTTlkg5sjUeOHOnC7LnorNo7kS2j3x3r+fxStH1ybvenCZWmDLXTYVIu9YyL7Vfy/nWNV40jwmlbhYLugyqQ0lgCjZZg/YvJqCrLv3fOr9I3B0rX665g1zBZg8mCMYQ5PlMw2lwON0rgAa7veLHITe80ke0L4PriF8ZxQ+A4B7QK5EF3kBE2DL7taqlHjY/6vniU7bK/2IOlS5Q0CGH1iH/c4q1z4nplfAxgng4WEJez3HFvYaNq1pZfual7GMfM1lwLiGLKsNKVFAGzg1tS7RO0mFpiz9CAmrQFSMkXkfg==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d771c1-e71d-45ca-597e-08ddf039f089
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 07:16:19.5402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RdNKbe/RYoPIoeWBUURLnG014zgNC0pYOKF3IHu0KdWz5T55A/kUvIU20yTFfchwp8o8Qwe4cu7k/KC2G1auYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR16MB3833

> From: Bean Huo <beanhuo@micron.com>
>=20
> Simplify the switch statement by combining RPMB_PROGRAM_KEY and
> RPMB_GET_WRITE_COUNTER
> cases which have identical validation logic. Add RPMB_FRAME_SIZE macro
> and replace all
> sizeof(struct rpmb_frame) occurrences for better maintainability and
> readability.
>=20
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> ---
>  drivers/mmc/core/block.c | 35 +++++++++++++++--------------------
>  1 file changed, 15 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index dd6cffc0df72..7fe9e8cc1ce4 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -121,6 +121,8 @@ struct rpmb_frame {
>  #define RPMB_READ_DATA         0x4    /* Read data from RPMB partition *=
/
>  #define RPMB_RESULT_READ       0x5    /* Read result request  (Internal)=
 */
>=20
> +#define RPMB_FRAME_SIZE        sizeof(struct rpmb_frame)
Since you only check !=3D and alignment, maybe you could further generalize=
 it by using:
#define CHECK_SIZE_NEQ(val) ((val) !=3D sizeof(struct rpmb_frame))
#define CHECK_SIZE_ALIGNED(val) IS_ALIGNED((val), sizeof(struct rpmb_frame)=
)

>  static DEFINE_MUTEX(block_mutex);
>=20
>  /*
> @@ -2864,12 +2866,12 @@ static void set_idata(struct mmc_blk_ioc_data
> *idata, u32 opcode,
>          * The size of an RPMB frame must match what's expected by the
>          * hardware.
>          */
> -       BUILD_BUG_ON(sizeof(struct rpmb_frame) !=3D 512);
> +       BUILD_BUG_ON(RPMB_FRAME_SIZE !=3D 512);
Maybe while at it change this to static_assert() ?

>=20
>         idata->ic.opcode =3D opcode;
>         idata->ic.flags =3D MMC_RSP_R1 | MMC_CMD_ADTC;
>         idata->ic.write_flag =3D write_flag;
> -       idata->ic.blksz =3D sizeof(struct rpmb_frame);
> +       idata->ic.blksz =3D RPMB_FRAME_SIZE;
>         idata->ic.blocks =3D buf_bytes /  idata->ic.blksz;
>         idata->buf =3D buf;
>         idata->buf_bytes =3D buf_bytes;
> @@ -2893,32 +2895,27 @@ static int mmc_route_rpmb_frames(struct device
> *dev, u8 *req,
>         if (IS_ERR(md->queue.card))
>                 return PTR_ERR(md->queue.card);
>=20
> -       if (req_len < sizeof(*frm))
> +       if (req_len < RPMB_FRAME_SIZE)
>                 return -EINVAL;
>=20
>         req_type =3D be16_to_cpu(frm->req_resp);
>         switch (req_type) {
>         case RPMB_PROGRAM_KEY:
> -               if (req_len !=3D sizeof(struct rpmb_frame) ||
> -                   resp_len !=3D sizeof(struct rpmb_frame))
> -                       return -EINVAL;
> -               write =3D true;
> -               break;
>         case RPMB_GET_WRITE_COUNTER:
> -               if (req_len !=3D sizeof(struct rpmb_frame) ||
> -                   resp_len !=3D sizeof(struct rpmb_frame))
> +               if (req_len !=3D RPMB_FRAME_SIZE ||
> +                   resp_len !=3D RPMB_FRAME_SIZE)
>                         return -EINVAL;
> -               write =3D false;
> +               write =3D (req_type =3D=3D RPMB_PROGRAM_KEY);
A little bit awkward?  Maybe leave this for now?

Thanks,
Avri

>                 break;
>         case RPMB_WRITE_DATA:
> -               if (req_len % sizeof(struct rpmb_frame) ||
> -                   resp_len !=3D sizeof(struct rpmb_frame))
> +               if (req_len % RPMB_FRAME_SIZE ||
> +                   resp_len !=3D RPMB_FRAME_SIZE)
>                         return -EINVAL;
>                 write =3D true;
>                 break;
>         case RPMB_READ_DATA:
> -               if (req_len !=3D sizeof(struct rpmb_frame) ||
> -                   resp_len % sizeof(struct rpmb_frame))
> +               if (req_len !=3D RPMB_FRAME_SIZE ||
> +                   resp_len % RPMB_FRAME_SIZE)
>                         return -EINVAL;
>                 write =3D false;
>                 break;
> @@ -2926,10 +2923,8 @@ static int mmc_route_rpmb_frames(struct device
> *dev, u8 *req,
>                 return -EINVAL;
>         }
>=20
> -       if (write)
> -               cmd_count =3D 3;
> -       else
> -               cmd_count =3D 2;
> +       /* Write operations require 3 commands, read operations require 2=
 */
> +       cmd_count =3D write ? 3 : 2;
>=20
>         idata =3D alloc_idata(rpmb, cmd_count);
>         if (!idata)
> @@ -2943,7 +2938,7 @@ static int mmc_route_rpmb_frames(struct device
> *dev, u8 *req,
>                           1 | MMC_CMD23_ARG_REL_WR, req, req_len);
>=20
>                 /* Send result request frame */
> -               memset(resp_frm, 0, sizeof(*resp_frm));
> +               memset(resp_frm, 0, RPMB_FRAME_SIZE);
>                 resp_frm->req_resp =3D cpu_to_be16(RPMB_RESULT_READ);
>                 set_idata(idata[1], MMC_WRITE_MULTIPLE_BLOCK, 1, resp,
>                           resp_len);
> --
> 2.34.1
>=20

