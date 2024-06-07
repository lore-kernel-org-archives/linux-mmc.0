Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E22413C69B
	for <linux-mmc@vger.kernel.org>; Fri,  7 Jun 2024 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717747332; cv=fail; b=BbVSwfBrDI83sp4NqxnQ5YfPV6bjiW9RvdQ0FoL+BMM/fD8RM3K357cDrEgqxWG26utrXy0PlVNCP/A/k0DGJ8DtB26CfskmEvIDzzhAyc8PDj/C67shCEMudZ1CaXHZs14SRdbl8pE+uM6S92yVx6V8ga2xQ7CKjf2TahFkiCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717747332; c=relaxed/simple;
	bh=ld1s+T0QG67tttExDzNc8Xtct58+mv6aipKFNLK8Fks=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HuxDk4De6+uj9HBuzGIO1UNsZvMRwROIuYcDjJ5JknbZgWThz6gub1SED1RlEr7BDg3sFPDIc/tjMlsejGaTxelJ0+X3WucaqKUmPuRGr6dBMeOA95NUuM0MyooI9GDurGaBfoR0hOO8Amq3wBcz6wC5aEVdDqcGZvH+hpZD2wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kSJZTE6W; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=YfKZLrew; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kSJZTE6W";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YfKZLrew"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1717747330; x=1749283330;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ld1s+T0QG67tttExDzNc8Xtct58+mv6aipKFNLK8Fks=;
  b=kSJZTE6WAyl3u8hB/xVLR/TZzkj8dcYmNZ2eh9zAUZ4Y+zMXRVZSeK0w
   B/pA2VWrpLIO1Ulp69pRwR8MiDjJ0DXwim6+iawsPQD+YwF736bZfFjcX
   hxL1g92qKia2lyvf0oKNbe8KYPre4WoQ9Un2c/AUI78H6vbZJMiZDzbnN
   omh79Gd0qHhrIA2N78I5iMVaQ0gJm/LXsyV2NySZ7W2Hv4SYlAXxk8JdU
   CkRSH84unXdg2OsGeZzyTcDUsKVQAvr/DG+jC2G6DatRL6abaGyAcRFO6
   NyZURSQTaiPVwC3ZmC5SVS6bIcVVxTAvdcCDYvg3le3gCHEw5l44h94+g
   Q==;
X-CSE-ConnectionGUID: 1YUEoGnTTdeJAGA6GqND8Q==
X-CSE-MsgGUID: QVtahzOBTKCzrJa/UX7lOA==
X-IronPort-AV: E=Sophos;i="6.08,220,1712592000"; 
   d="scan'208";a="19328692"
Received: from mail-bn8nam04lp2049.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.49])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2024 16:02:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqR4/qnfJJB6c93O+zBTqz1FPBqXZrjQxBhSdSBhUBKVC3MiB5aZkekXW1PhmXeKS4afNTFCxTkhV9GPf1dIbdLVq2+OcJLvbbisVuNuto/GdLh1B7S933mUWNlNQwvu5BeDCJm52t4DnL1F10fNUQ9IUFkjsgOf7DIIGqvCR1aWbMMdqAfbDPQvQMMum7YUbp2KJxQ6eP0gMC7c51n86ehOZQ7BeiKt35uAckI6IoZzLIC0zTeVLCrbUCejrXFKdZ6q1wOmkpbZC/IcaK1Qjas9BhKiLbX3l1qrqhmiJcgB0lXMQwkOLJfGZAff0RYTR7x6ZSDufR3TXBsNBE8lzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luHyf90wfMqES1WX3KHS3lnwMUXAgAZjWx9PdAn+ukU=;
 b=Pqlb8cMnFcdS+obabQGv3XA/X2qRG+MAJoRrsKFv33AB3hCLxMF+8mRpdI413krMCCq2FKXjJ8bdsSd//tkU3/hThAueTEcgrscBKautPdaY9WgKD35A62G8ihUuo4AgQzegev1TkZBl5y1a3PuZD+voaiHtvBDRaxbeP54FojitOMyNtv8spG5hPh4ER2OZ/akBYuz98sg8pVCp7esoeqv1U3/RyxrGSRV0zw1lB4iAjOUztmYBg42Z0U7CCf6nCaVRBztKLIfxLtaG7mt+FeyidrG/EzHqzIQn23dS6MAZUN7vLaS9cgpEYdPvpLSKRC1xXlNA0XhOi7Hovq14dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luHyf90wfMqES1WX3KHS3lnwMUXAgAZjWx9PdAn+ukU=;
 b=YfKZLrewJEX2ABv5aYZO4Hwb7/T5jbTrwkVtN2yrLL2kLId9Z9zkHFIz7WdY7h1FWmoj/Kg+bUVA15Ye5I5tMKjaT0VoR6E42ZOivu5rpGFZokCn8HKN1aLrtCtUch2Urde9kDTGNeOW6pKl3G3ZFvF4GNN05ojLVop4xt/1dlc=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BY1PR04MB8773.namprd04.prod.outlook.com (2603:10b6:a03:532::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 08:01:59 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%6]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 08:01:59 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: "linux-mmc@danman.eu" <linux-mmc@danman.eu>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v2] mmc-utils: implemented CMD42 locking/unlocking
Thread-Topic: [PATCH v2] mmc-utils: implemented CMD42 locking/unlocking
Thread-Index: AQHas4fsA4nl8i8nIEOrNn71ENxcObG79vmQ
Date: Fri, 7 Jun 2024 08:01:59 +0000
Message-ID:
 <DM6PR04MB65757FCA620263AF74F120A3FCFB2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240531182517.929498-1-linux-mmc@danman.eu>
In-Reply-To: <20240531182517.929498-1-linux-mmc@danman.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BY1PR04MB8773:EE_
x-ms-office365-filtering-correlation-id: 780f7abe-2a2e-4342-11df-08dc86c81be0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8CJUnDMOV/+1+yOmSRsCX8EsRaH7f5lwNMohHNpK2ryZqCBct6YHzJWs4GKe?=
 =?us-ascii?Q?a+VXmz2JW4Ds2kAtUoXqC54br2jNFzqwFejEN0IF+EYrZDkTSRL0kOYVr1L8?=
 =?us-ascii?Q?0apaf9iutvMAbLVLidsxAZcR7Tj030yiww2mWewalYV/eOrRDj4oEPxQ7y/X?=
 =?us-ascii?Q?PbeTw6vSnUEMHb99SQmwk6gwTUqYj4sZIWlal13TjwxjjqJ/1CEOUwNq6Frm?=
 =?us-ascii?Q?8e2P+AsX89KZTn7M7YGWfJ9SscdmYlcgIk1ngK72iz3tecZm/rS1tLB1XH/c?=
 =?us-ascii?Q?V4HxBUHKpANR4Haw88c9h7ZtmfBhYoFzMEVFXGHomCtJxKNfZkOxV7tJuvXl?=
 =?us-ascii?Q?xfk2Lq0Dhg9uCxiVeeZUEZZlcSExRzqUjQxi5tamlBQTcjAShRkevgo6LamD?=
 =?us-ascii?Q?MITk0JNk+t2b4J76/qtcGXjbxEKsxRO+CFAcX5/skd+PeZtbFlukpIn53wi2?=
 =?us-ascii?Q?RX1Qs6/q5KjW5wuB6KdKGY8IaUssGDAzAI7XwrLGby2BR7zq+Re8fBGrxE3y?=
 =?us-ascii?Q?339RYhmAvKEESw9mUCph+H7eSpPE4LCq+W4M57h7MXNwYBinHgERPRFQdTYx?=
 =?us-ascii?Q?C5Mf8T8hdEuKh/rSrCtk5dKs3D6hSWbvgcYLYB3uQBCP2vCh7ZVP/HAPp7le?=
 =?us-ascii?Q?Ij1Bj2b80JUu8YOjkamvGRfzqa0OiJGhs0cdMjv3CFTDhVMc2QPbtpSVpodZ?=
 =?us-ascii?Q?wtU3r6rBtq5mcLcBxRgfR4JEf+tNPHBMr6X2y0Ovyi1tSILa23AA66S1RTdp?=
 =?us-ascii?Q?viVmTlhUm9M1QXLd23jDY1nMwAs6nERG2QvGpfNRzcVuFQml2CzB0Zlzq5Z/?=
 =?us-ascii?Q?LU9CXf4dMM+QYFSFVyCNCf/neLBrFbiskAvBdwOfDGNLsiodgGBvkCVHXqEj?=
 =?us-ascii?Q?D5rLSALXvKiMCQm0lcXGvrI+igcXshx/BnXzsllZCsUuWk14vpwS8bgf5c+D?=
 =?us-ascii?Q?ScBZSo+vD0cUTat15LUOUefpz7g6LXHz6Zd01rIzW8x9APB4pkSoW+4yr/hZ?=
 =?us-ascii?Q?C8iEYW1kK0uNGwyP08WhdWmm1mIW4MQ8HYPST3anKlVt5ZHellSsipLLwn4d?=
 =?us-ascii?Q?GudCoIPxwrBlrSnCNkMh/I2VG2moUR1krQ5GfdLl5INhqj/y8V8KHuhHByBH?=
 =?us-ascii?Q?ApX6zp77eBZH9RexRBNosv9MaT82/BzTZ9+Hs98j8WxVIXu1sVP4W4I64qKy?=
 =?us-ascii?Q?ISTfIemAYiKySY4Wqq4htyEnjvZcCjXIuuyq8dOOxbdBh8AQGwKloJi79faw?=
 =?us-ascii?Q?DU2X/WPJ+GZCfW7hi7bOSQCcB1Dv68xngy3YVC/XGCBPZQdv61CLllfJ14lV?=
 =?us-ascii?Q?wy3wiZHUVEynohSbmrHYBNXA57V2WlWCnTet8bTRvMYMd3bMeSrjcETWLGSi?=
 =?us-ascii?Q?AF2GbDA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QIxTkKfpwGIRkOHrl61pPpO1PAgQsqkzgvDO5yU6Gc72/LrdFrP8wH2FGnoY?=
 =?us-ascii?Q?Gr1z6/NWfr9Pp1vZmOAvDn5ALPsbEBK6jIRpfm9LavUwKjc4Qy6SPE7rvlRY?=
 =?us-ascii?Q?3zJtb1JCXWOpwzEktco6IkE40Y4tFtLyixm99OowJQXQWWuFK/pUWjJEz4zk?=
 =?us-ascii?Q?9iM/iVWTHTMbMwYgk4MfxezgfBSM0i+oKwgMF3wt4ti/fFcqUL2xvTYi99Fd?=
 =?us-ascii?Q?tCune24m6xI4ApGsDiYF4lya0kAF0N/kmTig6oTfFCimIFzFhajfiG0sofF5?=
 =?us-ascii?Q?QshQGMSYYqHWfltad18GEydTFKioeGdUOx7QnYaS3tV8eHUW5z2FOBB1aucI?=
 =?us-ascii?Q?Dxx/jTMpiIDW89f8Eo8Z5V7Q+nByYhHnF5KGTSSfPWGDsConsqndeZYyZhje?=
 =?us-ascii?Q?8CvdohRqOEaf8eFfNLb4VcuvJpso37m2PaHIKviER2zCf/QTIwbPqyfqZ4jN?=
 =?us-ascii?Q?bNApuMC/Cr2w4Gx/WpIdiCy1CUaFbtN+zKOhZSrgrzdNL4ajFDrf4dokIzSl?=
 =?us-ascii?Q?eHvvKYss7i3OuEChiMmuVDJiTZjivkarzFpannbaTXiqP3csFNmkGqeR67hU?=
 =?us-ascii?Q?irQsDcbKWQHJuLWapW7mY+jkUlz9/H203FT7qH+EXkwjaI+O2uv3TmP7XGo0?=
 =?us-ascii?Q?1UeWaQk22jo8ZGg+XHUCxr4XoGajUe70/GWN3vJWIzE/Tv/9Y/IZ3m1yokD/?=
 =?us-ascii?Q?1bZ2lFgMcNm60OYtvY4IJxwY+YjGk3b5uk70lH3PYpG/o6+zQCCZC37jGLlY?=
 =?us-ascii?Q?+oGNuy+FvBJC6pippxslKyKdCqM3IH8q5alHIfe+rAxBQ1xUkjfLHQjH8ACU?=
 =?us-ascii?Q?5eZzvKVPPdkD2J5K4FHeVi7ghVOZYN8DgVzKrKV0EHLNugYPVrE9AmW7Ihsw?=
 =?us-ascii?Q?Rxpf94QPy4oaUpw5JReMhGL7lzXvYScDUBC2x+CU1QLWqi+lgwNsaxgvMexT?=
 =?us-ascii?Q?MSrr6gYGEM68gY9VUKLqHx/8vMcFPBlchEBIJBDSMWWajOSmf1MO8pmNFhzR?=
 =?us-ascii?Q?ZBjLfc6ijS1jO5KaIsrdCTWis+Wg7nKyTKjmTU9cl63Ga/0Y6PFhYdHuU1ly?=
 =?us-ascii?Q?Ur23n2OQeCeZ8XuOJJDCt2VrMjmxzjtqP8aOeclXy9qK//JYL4zqYEpPTCra?=
 =?us-ascii?Q?vi2fCg+DxVscT7lyoNsLHFRZsS08Xn4FESgVfAgToPrZDK7JFbVt3SMP2jSM?=
 =?us-ascii?Q?rwcHv/jsNdg5movAZ/xyYufbhmKra3dgKws/q29W/aJsw1WsFUsg9AEfo5xi?=
 =?us-ascii?Q?Y6vHJP17tH5Y4OdSxD1YHICvP+I5ZMgU+M3TNBYuSac19L3c7iesY2VgR1RD?=
 =?us-ascii?Q?VDVGuHfIBkSSI3BNTo5ZrLtLKRdE28l8SSKrx1FBsSV13+7dx8qQ0Zb+JPPc?=
 =?us-ascii?Q?snrE0Nr3YavC+DODWoz7rRR5zLNEHRh10Sl4iTo5+Lkr1RnUUlAdcgGoHwrd?=
 =?us-ascii?Q?ESpU7thG2L0iC2WZPmSXvAJ5oJBE1Aj2LkZGQEq7qWOgLGg42Xi6LJZTnGIl?=
 =?us-ascii?Q?sCVLjac7T2H0cFk6eyfObW2+Cq9R2CN8g9L1OpMe0M3tR387nDSxrvGSMop1?=
 =?us-ascii?Q?1OUkGGF3jSh5Qli0UwutgznAB94WgEi1Qe7Csapt?=
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
	GaqEMFLg/ruHc1RLn/D2lJQhPB5eX3iTw4ECfn20Yp5CpXH4Cpfd56UYyS+SlmNz4oQB9EuS2JOTlq51Xg2anf2Lxa06auF4wG6QekwKA8AA5UFfGaW9zUzX00tcbXZ3+5pLGD/L8kBznEP11azMcz4ys/zNBmEv/GObb+/K8b6dIxWYj+63GhfxY4paEYionekDIVUDc7F3iyi7ZAnpgzh+r8eGxwkOFK/7mRDWXxby8JkLqiML24LpnqC2N4NBvMyLxjVlOMNyKd7kky5V/MlOe4GLxAOlk8Z9oyoqIczYN+GcC0xk21Xnsp3GDDHwDBeQN475GR1qAVHe6+yHN/lfd2YCTBxtvxU7vUOoM3VNqaBHFJXcefGIUzwZW9gKwAni94y/1EMx/BhKs20eEg8xn9d3pw/W0wXsLy8Zc8Bgn+zKTBDnxnhgtSI4n+V7mSuXq1Q3yKWuvTwsk12ibs8MsKDXpvQh9CCxypQI9rRBV2PWbIm8Cd3JA6d82kGCkTqECqOGh5ez+ry01OSBWSdc3Z2gGRz4y6oek88cMGaFnAkOD2mupy9c5NvUJmifWDNC37bx8EkKUH9hxNOJVG7n/WGptrbFEyvBG4fvbio4MB9evA9EeGqJdXVfFTB2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 780f7abe-2a2e-4342-11df-08dc86c81be0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 08:01:59.8524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K0Qj/coyDP+dZc/2qTaXMd3/T/vcqiELwLtlGT3F62z+cnoQ/dlZZ304U9Z0JDya4xr9vjvxIhPEIBui+QXxRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8773

> From: Daniel Kucera <linux-mmc@danman.eu>
>=20
> Implemented locking/unlocking using CMD42 according to Micron Technical N=
ote
>=20
> original link https://media-www.micron.com/-
> /media/client/global/documents/products/technical-note/sd-
> cards/tnsd01_enable_sd_lock_unlock_in_linux.pdf?rev=3D03f03a6bc0f8435fafa=
93a
> 8fc8e88988
> currently available at https://github.com/danielkucera/esp32-
> sdcard/blob/master/tnsd01_enable_sd_lock_unlock_in_linux.pdf
>=20
> Signed-off-by: Daniel Kucera <linux-mmc@danman.eu>
> ---
>  mmc.c      |  12 ++++
>  mmc.h      |  10 +++
>  mmc_cmds.c | 189
> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mmc_cmds.h |   1 +
>  4 files changed, 212 insertions(+)
>=20
> diff --git a/mmc.c b/mmc.c
> index bc8f74e..38e3e72 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -250,6 +250,18 @@ static struct Command commands[] =3D {
>                 "be 1.",
>         NULL
>         },
> +       { do_lock_unlock, -3,
> +       "cmd42", "<parameter> " "<device> " "[password] " "[new_password]=
\n"
> +               "Usage: mmc cmd42 <s|c|l|u|e> <device> [password]
> [new_password]\n"
> +               "<password> can be up to 16 character plaintext or hex st=
ring starting
> with 0x\n"
> +               "s\tset password\n"
> +               "c\tclear password\n"
> +               "l\tlock\n"
> +               "sl\tset password and lock\n"
> +               "u\tunlock\n"
> +               "e\tforce erase\n",
> +       NULL
> +       },
>         { do_softreset, -1,
>           "softreset", "<device>\n"
>           "Issues a CMD0 softreset, e.g. for testing if hardware reset fo=
r UHS works",
> diff --git a/mmc.h b/mmc.h index 6f1bf3e..ddbb06c 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -30,6 +30,7 @@
>  #define MMC_SEND_STATUS                13      /* ac   [31:16] RCA      =
  R1  */
>  #define R1_SWITCH_ERROR   (1 << 7)  /* sx, c */
>  #define MMC_SWITCH_MODE_WRITE_BYTE     0x03    /* Set target to value */
> +#define MMC_SET_BLOCKLEN       16  /* ac [31:0] block len R1 */
>  #define MMC_READ_MULTIPLE_BLOCK  18   /* adtc [31:0] data addr   R1  */
>  #define MMC_SET_BLOCK_COUNT      23   /* adtc [31:0] data addr   R1  */
>  #define MMC_WRITE_BLOCK                24      /* adtc [31:0] data addr =
       R1  */
> @@ -46,6 +47,7 @@
>                                               [1] Discard Enable
>                                               [0] Identify Write Blocks f=
or
>                                               Erase (or TRIM Enable)  R1b=
 */
> +#define MMC_LOCK_UNLOCK                42  /* adtc R1b */
>  #define MMC_GEN_CMD            56   /* adtc  [31:1] stuff bits.
>                                               [0]: RD/WR1 R1 */
>=20
> @@ -70,6 +72,14 @@
>  #define R1_EXCEPTION_EVENT      (1 << 6)        /* sr, a */
>  #define R1_APP_CMD              (1 << 5)        /* sr, c */
>=20
> +#define MMC_CMD42_UNLOCK       0x0 /* UNLOCK */
> +#define MMC_CMD42_SET_PWD      0x1 /* SET_PWD */
> +#define MMC_CMD42_CLR_PWD      0x2 /* CLR_PWD */
> +#define MMC_CMD42_LOCK         0x4 /* LOCK */
> +#define MMC_CMD42_ERASE                0x8 /* ERASE */
> +#define MAX_PWD_LENGTH         32 /* max PWDS_LEN: old+new */
> +#define MMC_BLOCK_SIZE         512 /* data blk size for cmd42 */
Those can be privet to mmc_cmds.c

> +
>  /*
>   * EXT_CSD fields
>   */
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 936e0c5..dbbaf8d 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -3245,3 +3245,192 @@ dev_fd_close:
>                 exit(1);
>         return 0;
>  }
> +
> +static int hex_to_bytes(char *input, char *output, int len) {
> +       int ilen =3D strlen(input);
> +
> +       if (ilen % 2) {
> +               printf("Error: hex string has odd number of characters\n"=
);
> +               exit(1);
> +       }
> +
> +       if (ilen / 2 > len) {
> +               printf("Error: hex string is too long\n");
> +               exit(1);
> +       }
> +
> +       for (int i =3D 0; i < (ilen / 2); i++) {
> +               if (sscanf(input + 2 * i, "%2hhx", &output[i]) !=3D 1) {
> +                       printf("Error: failed to parse hex string\n");
> +                       exit(1);
> +               }
> +       }
> +
> +       return ilen/2;
> +}
> +
> +static int parse_password(char *pass, char *buf) {
> +       int pwd_len;
> +
> +       if (!strncmp("0x", pass, 2)) {
> +               pwd_len =3D hex_to_bytes(pass+2, buf, MAX_PWD_LENGTH);
> +       } else {
> +               pwd_len =3D strlen(pass);
> +               strncpy(buf, pass, MAX_PWD_LENGTH);
> +       }
> +
> +       if (pwd_len > MAX_PWD_LENGTH) {
> +               printf("Password too long.\n");
> +               exit(1);
> +       }
> +
> +       return pwd_len;
> +}
Can the above be eliminated by using parse_bin() instead?
Are you expecting the old & new passwords as a single concatenated sequence=
?
If you do - this seems wrong to me.

> +
> +int do_lock_unlock(int nargs, char **argv) {
> +       int fd, ret =3D 0;
> +       char *device;
> +       __u8 data_block[MMC_BLOCK_SIZE] =3D {};
> +       __u8 data_block_onebyte[1] =3D {0};
Why is this needed?
Why not use data_block for erase as well?

> +       int block_size =3D 0;
> +       struct mmc_ioc_multi_cmd *mioc;
> +       struct mmc_ioc_cmd *idata;
> +       int cmd42_para;
> +       char pwd[MAX_PWD_LENGTH*2+1];
Please run checkpatch before re-submitting

Thanks,
Avri

P.S.
But wait - need to wait for your kernel fix to get accepted before re-submi=
tting -
you need to add a reference to it in your commit log.

Thanks,
Avri
> +       int pwd_len =3D 0, new_pwd_len;
> +       int min_args, max_args;
> +       __u32 r1_response;
> +
> +       min_args =3D 4;
> +       max_args =3D 4;
> +
> +       printf("Function: ");
> +       if (!strcmp("s", argv[1])) {
> +               cmd42_para =3D MMC_CMD42_SET_PWD;
> +               printf("Set password\n");
> +               max_args =3D 5;
> +       } else if (!strcmp("c", argv[1])) {
> +               cmd42_para =3D MMC_CMD42_CLR_PWD;
> +               printf("Clear password\n");
> +       } else if (!strcmp("l", argv[1])) {
> +               cmd42_para =3D MMC_CMD42_LOCK;
> +               printf("Lock the card\n");
> +       } else if (!strcmp("sl", argv[1])) {
> +               cmd42_para =3D MMC_CMD42_SET_PWD | MMC_CMD42_LOCK;
> +               printf("Set password and lock the card\n");
> +               max_args =3D 5;
> +       } else if (!strcmp("u", argv[1])) {
> +               cmd42_para =3D MMC_CMD42_UNLOCK;
> +               printf("Unlock the card\n");
> +       } else if (!strcmp("e", argv[1])) { #ifdef
> +DANGEROUS_COMMANDS_ENABLED
> +               cmd42_para =3D MMC_CMD42_ERASE;
> +               printf("Force erase (Warning: all card data will be erase=
d together with
> PWD!)\n");
> +               min_args =3D 3;
> +               max_args =3D 3;
> +#else
> +               printf("Erase is disabled unless compiled with
> DANGEROUS_COMMANDS_ENABLED\n");
> +               exit(1);
> +#endif
> +       } else {
> +               printf("Invalid parameter:\n" "s\tset password\n"
> +                       "c\tclear password\n" "l\tlock\n"
> +                       "sl\tset password and lock\n" "u\tunlock\n"
> +                       "e\tforce erase\n");
> +               exit(1);
> +       }
> +
> +       if ((nargs < min_args) || (nargs > max_args)) {
> +               fprintf(stderr, "Usage: mmc cmd42 <s|c|l|u|e> <device> [p=
assword]
> [new_password]\n");
> +               exit(1);
> +       }
> +
> +       if (nargs > 3) {
> +               pwd_len =3D parse_password(argv[3], pwd);
> +               printf("Using password '%s', length %d\n", argv[3], pwd_l=
en);
> +       }
> +
> +       if (nargs =3D=3D 5) {
> +               new_pwd_len =3D parse_password(argv[4], pwd+pwd_len);
> +               printf("New password '%s', length %d\n", argv[4],
> + new_pwd_len);
> +
> +               pwd_len +=3D new_pwd_len;
> +       }
> +
> +       device =3D argv[2];
> +
> +       fd =3D open(device, O_RDWR);
> +       if (fd < 0) {
> +               perror("open");
> +               exit(1);
> +       }
> +
> +       if (cmd42_para =3D=3D MMC_CMD42_ERASE)
> +               block_size =3D 2;
> +       else
> +               block_size =3D MMC_BLOCK_SIZE;
> +
> +       printf("Set data block length =3D %d byte(s).\n", block_size);
> +
> +       mioc =3D (struct mmc_ioc_multi_cmd *)
> +               calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
> +                       2 * sizeof(struct mmc_ioc_cmd));
> +       if (!mioc)
> +               return -ENOMEM;
> +
> +       mioc->num_of_cmds =3D 2;
> +
> +       idata =3D &mioc->cmds[0];
> +       set_single_cmd(idata, MMC_SET_BLOCKLEN, 0, 0, block_size);
> +
> +       if (cmd42_para =3D=3D MMC_CMD42_ERASE) {
> +               data_block_onebyte[0] =3D cmd42_para;
> +       } else {
> +               data_block[0] =3D cmd42_para;
> +               data_block[1] =3D pwd_len;
> +               memcpy((char *)(data_block+2), pwd, pwd_len);
> +       }
> +
> +       idata =3D &mioc->cmds[1];
> +
> +       idata->write_flag =3D 1;
> +       idata->opcode =3D MMC_LOCK_UNLOCK;
> +       idata->arg =3D 0;
> +       idata->flags =3D MMC_RSP_R1 | MMC_CMD_AC | MMC_CMD_ADTC;
> +       idata->blksz =3D block_size;
> +       idata->blocks =3D 1;
> +
> +       if (cmd42_para =3D=3D MMC_CMD42_ERASE)
> +               mmc_ioc_cmd_set_data((*idata), data_block_onebyte);
> +       else
> +               mmc_ioc_cmd_set_data((*idata), data_block);
> +
> +       ret =3D ioctl(fd, MMC_IOC_MULTI_CMD, mioc);
> +
> +       printf("Multi cmd response: %d\n", ret);
> +
> +       printf("Set block length response: 0x%08x\n",
> +               mioc->cmds[0].response[0]);
> +
> +       r1_response =3D mioc->cmds[1].response[0];
> +       printf("cmd42 response: 0x%08x\n", r1_response);
> +
> +       if (r1_response & R1_ERROR) {
> +               printf("cmd42 error! Error code: 0x%08x\n",
> +                       r1_response & R1_ERROR);
> +               ret =3D -1;
> +       }
> +
> +       if (r1_response & R1_LOCK_UNLOCK_FAILED) {
> +               printf("Card lock/unlock fail! Error code: 0x%08x\n",
> +               r1_response & R1_LOCK_UNLOCK_FAILED);
> +               ret =3D -1;
> +       }
> +
> +       close(fd);
> +       return ret;
> +}
> +
> diff --git a/mmc_cmds.h b/mmc_cmds.h
> index 5f2bef1..96da608 100644
> --- a/mmc_cmds.h
> +++ b/mmc_cmds.h
> @@ -50,3 +50,4 @@ int do_general_cmd_read(int nargs, char **argv);  int
> do_softreset(int nargs, char **argv);  int do_preidle(int nargs, char **a=
rgv);  int
> do_alt_boot_op(int nargs, char **argv);
> +int do_lock_unlock(int nargs, char **argv);
> --
> 2.34.1

