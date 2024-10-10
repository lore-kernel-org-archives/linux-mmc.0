Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425051A304A
	for <linux-mmc@vger.kernel.org>; Thu, 10 Oct 2024 06:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728542796; cv=fail; b=WUXxa00Rsw77zdmWvvHUsiRjw+InDoxzawV53vllx7ZwX0703PnzmQKyVFatPLaTQh91577j/5/GHyG2EDKggi9+q8jgruIyDwaJKbDyuqOUCZPuXnSSZMSPXpb6YXLUdUaGX0dUN+Hs3Xg+A/dLm55Xh85QmTpS6fx84L2QEdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728542796; c=relaxed/simple;
	bh=q5fp1/UiZfCs3jSj+5VbqTPXY91d2A8PgbDKVDJxrX4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lPmbUMETBb5vLbIfPFh/huXjim4Yu2Lqecg/vquwJyr0lvGNcbhKKhFBoHiuFL1VizIUhq3qgZcqvr1A8GAv4aZAPT4hisaaS49phrsugYdsC8Ijeyu4bl7RrInyEA5KP5n580wgFLKugitxgRkE7i0apfw7WJ5S+neDLnr+2vU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SGIWDKta; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=FGyQtf5L; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SGIWDKta";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FGyQtf5L"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728542795; x=1760078795;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q5fp1/UiZfCs3jSj+5VbqTPXY91d2A8PgbDKVDJxrX4=;
  b=SGIWDKtatz/npP85LjdEXcXjuf9iQmIRyaMneBzC+VvauMgYo6JKnQnf
   3bci5NbQXul9Rx7cVrvOiKrWjfcw/5Ez4AdpZemAudAgjQZOZbtsnXkrd
   1mNWggaAgezS7tmh32GLwZAYqv4YlythtOeu4N0tm3/rTqTAc32YrT6DX
   S9I36ttVt6KQ7SER5LceNArh9Ibk0NEEhxw/b80pVQdVklhlz0VOus+HR
   JUUUh2lfisT5Uqo7iONWCZgxUw3vqXROOYeSkhh1jrPELHTrs4VxTZpmD
   gtGqQ6MJcglh/PPsTWFRlHbtQNUFI1GsLdas4wRqwaF1orPdbgh9ZJa41
   A==;
X-CSE-ConnectionGUID: CxMXhlTOQgaS5XyMHQBvuw==
X-CSE-MsgGUID: Ci4RKXLPRUKCWuzRyQ6zRQ==
X-IronPort-AV: E=Sophos;i="6.11,192,1725292800"; 
   d="scan'208";a="28745662"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2024 14:46:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpn0yOd2lm6PLMFTl8inrZ2Rq9NKoGDzHlIlPlmtIhx5/7452cNtK526TEtJRu7x7ce1XerDAf2j2+yLWblYrCzhpuO6Vw1yI9WZ/H0A9iDLNRRbXgrxMrzBEyAdOiQdt83y3OIPzPaSigFkOQCvMpO5Bqh0+iAjZPVExO+ji8SfUiZ1ZXhkSg0aqOt856JqF/bLGtdFSJBv6XDdz1QEAl7KVLIQF3QwkJy7EHL2ohTFibhs5ojM4rL33M96baKlBCtIE49KICRsh1/WH3H2m8mx+aYrPpoHkH1y7ViTn11Gu6mh//qfORUQjol0ODzpujLBzfUS0bVOeHyQf9qydA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjuPtOMdQgULuRgNtbS8aIqiqd/eZJUDP5ASxFakfFM=;
 b=JId5y46JOHNitmMUL+14jHrtA5INC1cNzbUNfU1852nI3v01Hhyz4gUMCuXfge6mDvn0kJ+fpMpxz6BMPe0tVFO8iky9X4G8UAeYzz+fk6Zf2y56yCJD5Y/VdqBNdrESYClfI7nS4C9sh3HwO2NDQRh8LNmXIrRe0oQ8D+8lcRgRl/Ajcmo6AJ/zzu7dPEuHODlj1JXyZGs6XcNyUVY9CpTHGJMmdo9Px8BrbuSpSh8WrU75EmN7uWG9Rf2/Dh6AhXoOPNHaSUmzwa8JBpB83Q7/xGfNY1aQfytn6JwqjoPMIrwjB8vYCd6tbfHOCB6CnuaZVVK8YbMjWIgnS7glQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjuPtOMdQgULuRgNtbS8aIqiqd/eZJUDP5ASxFakfFM=;
 b=FGyQtf5LOIXXSnApsv4bg5WWudxQnq/QRVDPQAbQawHL+oqJHIPAP9A2xDJ6IpX4HeoTbxLFW0OIyqCUtmBy0mLHsds2wOx+56D1W6FOuaXLt63x+lvZZ1J1hixldsxB0IIfaNxAwwh3g7QUoHCeJGbWU61U6CT8WBP0v9BoS+Y=
Received: from BL0PR04MB6564.namprd04.prod.outlook.com (2603:10b6:208:17d::11)
 by CH2PR04MB7128.namprd04.prod.outlook.com (2603:10b6:610:9a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 06:46:32 +0000
Received: from BL0PR04MB6564.namprd04.prod.outlook.com
 ([fe80::bd7b:c391:6f87:5a9f]) by BL0PR04MB6564.namprd04.prod.outlook.com
 ([fe80::bd7b:c391:6f87:5a9f%4]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 06:46:32 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [bug report] mmc: core: Add open-ended Ext memory addressing
Thread-Topic: [bug report] mmc: core: Add open-ended Ext memory addressing
Thread-Index: AQHbGliHIHb4TwjJP0eCvszVX765rLJ/izBw
Date: Thu, 10 Oct 2024 06:46:32 +0000
Message-ID:
 <BL0PR04MB65648610842C0404E801DCA0FC782@BL0PR04MB6564.namprd04.prod.outlook.com>
References: <345be6cd-f2f3-472e-a897-ca4b7c4cf826@stanley.mountain>
In-Reply-To: <345be6cd-f2f3-472e-a897-ca4b7c4cf826@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR04MB6564:EE_|CH2PR04MB7128:EE_
x-ms-office365-filtering-correlation-id: a62c59af-7c5f-4b2e-cdbb-08dce8f746e6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WWBh0/zwEtldpKxL3Fl4bN5j3aVCBYULJBrflrLprNdKl4Re+hydMe801yVa?=
 =?us-ascii?Q?NlSLmZmo7EZn4XK7PuWAci49W/v2gkh4m7NdqnK3I4fKA1NmM9MPrwi+CRws?=
 =?us-ascii?Q?Qz1ZG3BLwpJ6Yyv+0AaXp1UIf/BqEpHTXLbPYz1jsJkTfP3x79lpaB5C3H1i?=
 =?us-ascii?Q?lH1GOWdxeMoENRU+pfnUZCaepbaTFQLOcyRsHrxi6AG3oJVrgcRrIhi48A+d?=
 =?us-ascii?Q?xyu8jGtrWZ8WrdkEYBr8RJvL1N6Ch3ZUIdBsLNxgeQibsl3EuBQ30pfb8ked?=
 =?us-ascii?Q?Jag07okHlzQdDpk5NNdSloJi7Hjk3opmfOxb9cW0lHcSXUcwUcy/eyjya+um?=
 =?us-ascii?Q?cDkGm0GZk3Dki/gxuorfjCzjTMAyiDQdCMJd9nkKwy9v6eC34WZ2YUCaoUYB?=
 =?us-ascii?Q?HyORPMu3eMEvdbKJIm8LwOUpSfdu7k6JWUZGlbdYQrsvuUYifBUmuhYG0Rit?=
 =?us-ascii?Q?hM+kiEDlB3+l9JTOJglj+p8ukyIhxxbF4xFpo6a94YeSsVFc5XtfZX0dTCeD?=
 =?us-ascii?Q?oIpa0Zn4lCbMdhfpdKEaSSym0peXc84Avsbo1M3QEFUDD005XyEUrIeVib/b?=
 =?us-ascii?Q?zBvTwTgI767z8v/qKAMh/WNV2SJnerKsR+R6lzgNhIfLliuynw8ASVyasja9?=
 =?us-ascii?Q?ovjCa2ShaJo8CgDcgEYgyAkiyNlgJyBDrxTwdVEasVM8jUrpGYYfd6+BRsgR?=
 =?us-ascii?Q?w2hcupAJuy1RZk8Ur56+tIIsgCWFd+JBYGeJYRFdMFUp+1cox7g7qVRe7ujw?=
 =?us-ascii?Q?ybSk/vW3jCbhLMJm3aHLfKSqDPJzbOEDgOxcmpDx6MAIM36cVFHLCZE6vydt?=
 =?us-ascii?Q?Rt5KbJ37d3WyJI4UV/uxQnFe+h4vzoa8oODM+czbY1rj32uT4TSQNxkG+HZ2?=
 =?us-ascii?Q?pBxr38B2k3FoqW9IuOR5UsYBp0KYEz6dAVhpBjUDoujHJOc32dy89tZIFkEw?=
 =?us-ascii?Q?IFUdKOIFPh0NK5weU0RG0S/Jwjd0IGtXu2rHk0Q+3w7nv6qFk43Y+I583uOy?=
 =?us-ascii?Q?qmMyJCb1vxEW1fMnEgmwwIQOQaCNPIbbkFi/TAGEflubm05EWKt+dNSbx90i?=
 =?us-ascii?Q?YVq5MphsR1ub/8m+hHd+4uQUECdkRCvrvg1kXXnOKS3l1NjSMixlMSp0Msmu?=
 =?us-ascii?Q?xRVw4qLppIBQCg6uwrus/sHkntgjAvlyvJjSJyJ/3nPbtlsWHmZwV3Tkcjcq?=
 =?us-ascii?Q?mKfTh+Zf9vmgWYYiZ4kSZMVRYGKNgUuAhPzfvUZvWkE9GRkymjTVkjqiOpbg?=
 =?us-ascii?Q?IKRfNw4c2xyu6Uq4n1nG8rWMOnTh6NwTaYRQSd66k9RpvV3DsKQ6b+VMl12x?=
 =?us-ascii?Q?Ua+zsoSQptPXJk9SXYcSkL6a+xK+my6+AAl21fo9BXsdIg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6564.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?U0UBXAOu6kA6RgPSAjai9Yj7RvnrRZmogz2hZWaPjLKUE7r1dPWxMW/t/Ifi?=
 =?us-ascii?Q?+jaN/H1n3WO6lIfjhVTcjfqCoHlyq5DuBW/vY0k1WGFOP+s2k9efr08jyEQu?=
 =?us-ascii?Q?D444vv7lY2TtHtXLpFf4nkRA5O0mEL3WHYIZAzaKIrBPxnfqXSJBMrqE3+9G?=
 =?us-ascii?Q?PYVB3G6uDGsErjseTWFy5EKVZXl4PbRKY7PSeHti/R43hBx0K8vg2WxwL/q2?=
 =?us-ascii?Q?xZzTkRymLVKj1MSoE+blK7jYAoKakLOi7XXlPvd615ecgQL/bQi0LbxLyPXH?=
 =?us-ascii?Q?VTLtUZizwgBvtkQTWSSUM43J1HixIXcKosDgj0yHHBJU1JsYklWkS3hL6iTs?=
 =?us-ascii?Q?E5I1KOd1Ii4hPRK6vNBBWwkwx1ipaBTEKqFTibTkC8YdtSGkSSFpSX1JOuNO?=
 =?us-ascii?Q?QxaIqYyqHWYMCXno45MvwEkJEuuEYC15EnilhHo2/aVRIQs45DuE8juBGH/6?=
 =?us-ascii?Q?9VUClpuT9PrRDu1uHZ000fTnz3nreNh6RaYaxgR9mPRoCU0ajmlX3oKOM1Wp?=
 =?us-ascii?Q?nK/AzCjoJIrwJVT2W9E63ocK1ITNckFJOmbfMohr3XP6NtcV16i3IjPkb2i9?=
 =?us-ascii?Q?PLyYdq805sjWMHvxVfxBXpkX6C+o7klLQco3x4oCrlUEPEC6vTPnOKfudRsB?=
 =?us-ascii?Q?3Rxn1nmeH+S9X5PGLM+0x75TC7qjyT4KsMes5eU/emBPIF7QqFNI9sj8RMVQ?=
 =?us-ascii?Q?QCV4EcrXlb5h2U9/gYL2a3BMFq55IGyIn/zLE3IdLSk+c5pNkQigJ0qSTvkm?=
 =?us-ascii?Q?1PFfiF5WR3VVAY63aTqKnYrFipm889cOua5Bm2G8/2NY9u/hfKjIJo1I6Lwj?=
 =?us-ascii?Q?3cCNQPXU2/P4zL70jnNRMEyY/ze4d3ohQOaL2Mwc0VyIA1EhnjpBwu/Puf9h?=
 =?us-ascii?Q?ice9ntjz8nbGHy3dLyhbMb1gXI8+6A5uKLcSLwh+jxZXQ7vuMnZwJwz0hiXa?=
 =?us-ascii?Q?aJB5Bnhim40Vto4AlBF4C7kxE4rF5wl2aNco7i0WFC2CSGUBRmuHbePrI0yR?=
 =?us-ascii?Q?H3i+EjTdbQgIgWIIt14cuc0QZHVNzoVY0zQIUETuKhWk2wzuZZ2r286K/4LV?=
 =?us-ascii?Q?JsNq/jQ0vqDBsTmgZgVYoFBdQi7d0jD0drw04gsXJCDnLfjzV7Zd42OQTTwe?=
 =?us-ascii?Q?ffXZipKt+dIykDjQDv63XpMy+iOtkeNusX7AZvuUd9ApeR1lZEjpA8tKsIZ4?=
 =?us-ascii?Q?PLEzGCMxEql5Nf6WGpjwDAfoYlchBYZiQcwQpkj7wcvEijmoVZ0+DfzHd2xu?=
 =?us-ascii?Q?Yp2IggzsYyhDKW0nPsM/YypOCEUpF3k0VtDVg8bbDCssc871Gbj1+JXf+mnv?=
 =?us-ascii?Q?ny3qzsjyNg9sqwUgBo6uQVwZ1h13+0Y9APr20+vl3uaSoEkV3pf+4GvGyYHv?=
 =?us-ascii?Q?encxy8UMfn5lSVm1o/UlM2rjT5pmZlqh8BnMQ6wK6qRCM2gQxq9IV+zPY1tr?=
 =?us-ascii?Q?J56xaasLOAG6TgQ3loNtve2GzikxUqIu/PiiYOH4rBl+fNA91/pcGFxcLIpm?=
 =?us-ascii?Q?/zJZzUdkYK9M5diQeObZBCmaiNfWkhSqxnA0GkLOgrjaCKaNYQguKTXJXH+j?=
 =?us-ascii?Q?fC5L4Q84JJzmITzYZfoZkQdrqOBYRLwYDz2xqdGq?=
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
	tmY7yM/Lq0LQN4PnUn9dTFWy5vgHW+std+1MSjh/dTzFAC0+1h2GLqHODLlotntR2e/zI0vNJzIdY2R8946Z1pH0MRzLkL2GK1KxxfC0fiGTROBkfP3bOCfoxDik7gEXwP5q3NCUa385gSJxRmjpDmyl4jg7HSv5w+5qe1vujPOFWciHLTRegzlU1XoH2XuoP5i3DnPSFXDXkbUbrfDI4JqbTD/kXvQDIUpV/i1q/Jd/RtkR53WNUzZYLa/hBBUoSh9eM2ZLPnhVf3g9VMU/zpyEbsNsA91BfS6qSif6Bwh20R1Bc4HgP4l1YMMDaERDCG3xoy0W6i4v8siG5LLn4Tvzo/Dd1+D1VblTWLPYL6ej9Xn4QpQyqDxBYNLCZ9teNz/yPATyLCM2DpjGom5uJdelWpUQwgqmGMTYHwkyPvdYmvOCx1bGfmVpUu6OOGrp9CN32DHZzeYSP42OxLUvM82lf2+8WYNAvfjUvs6iniqbMXobZ3TiF51xUCG/t3gDluuc719522MubRZRV7S4qYMTC0+z9ftGS6ZzgSMbxlfYAgofB/2a0Pc/YKTMVzjgozcYhxJCQxoOM0oAXsSEZztz9+bUFlDvyYUK/lNpEysin/TrnR7Lvi3huIDZweSp
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6564.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62c59af-7c5f-4b2e-cdbb-08dce8f746e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 06:46:32.3532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7smf4miEq5jrUHdjv7p78+oOwtUEOvDNnTTNWUQanhE/m35IrvEAK0uZbv5KbjPAXAjAivlk9Iy9thfamzMymw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7128

> Commit 737d220bb2be ("mmc: core: Add open-ended Ext memory
> addressing") from Oct 6, 2024 (linux-next), leads to the following Smatch
> static checker warning:
>=20
>         drivers/mmc/core/core.c:358 mmc_start_request()
>         error: we previously assumed 'mrq->cmd' could be null (see line 3=
39)
>=20
> drivers/mmc/core/core.c
>    335  int mmc_start_request(struct mmc_host *host, struct mmc_request
> *mrq)
>    336  {
>    337          int err;
>    338
>    339          if (mrq->cmd && mrq->cmd->has_ext_addr)
>                     ^^^^^^^^
> The patch addes this NULL check
Thanks for reporting.
Will remove it as part of a larger cleanup series.

Thanks,
Avri

>=20
>    340                  mmc_send_ext_addr(host, mrq->cmd->ext_addr);
>    341
>    342          init_completion(&mrq->cmd_completion);
>    343
>    344          mmc_retune_hold(host);
>    345
>    346          if (mmc_card_removed(host->card))
>    347                  return -ENOMEDIUM;
>    348
>    349          mmc_mrq_pr_debug(host, mrq, false);
>    350
>    351          WARN_ON(!host->claimed);
>    352
>    353          err =3D mmc_mrq_prep(host, mrq);
>    354          if (err)
>    355                  return err;
>    356
>    357          led_trigger_event(host->led, LED_FULL);
>    358          __mmc_start_request(host, mrq);
>                                           ^^^ But if mrq->cmd is NULL the
> __mmc_start_request() function will crash.
> Hopefully, we can just remove the NULL check.
>=20
>    359
>    360          return 0;
>    361  }
>=20
> regards,
> dan carpenter
