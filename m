Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3EA5258
	for <linux-mmc@vger.kernel.org>; Thu, 24 Oct 2024 08:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729756860; cv=fail; b=k1dswlqKnzzTeTAb2ilGQfZbPc+CVUC+QmHLItN1Ygt4tIBR9E8TdDDEmakw8tSlQosq15uK34gIK1O4s9JIGaK1KVitCoQqSQ10f1DTbRKF9t6Grv5NWwxAMK6xd0k3Vho74lPTBt99D6B+vOneoLFpgJ9Xky+FIJicICsJXlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729756860; c=relaxed/simple;
	bh=DKQ6WdvHoust2Ajgy1OaC/0ZdgG5Qk3phH/E/xReGfA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BmfRfUXgCf+8+ZLi/wKUdbzoP//vp8OT0rnSYh0x1YY6L7udjle6LszS8YqXnuowaqhfN1PDtaVTVwhc7DEYXGzmJ1Eh3RZc99oyq2rGkVlYGJe+qvFaSigRtQljfLeIUKDG1HNjFSIEM1xmJA/hwqOV4F+cp2RaiAI8rMrUmJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gVWqpqUT; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=jVkfB45Q; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gVWqpqUT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jVkfB45Q"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729756859; x=1761292859;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DKQ6WdvHoust2Ajgy1OaC/0ZdgG5Qk3phH/E/xReGfA=;
  b=gVWqpqUTmx8poqbxDjUYPnzfOXsBpj7tWzzfbQi5AgbIS4qZpoDSaX38
   ZxwTvohcw07dCmk859rL3N/qClTowRkL9cjE0FNAakvdkulHGgznF17HK
   /Glhi2i/HzNGtmC+HuQISSnCmrGFUN1TnvY7pMfMuop0LX9hKwTne/1Rp
   MrRH/ByRv+oxrDPToEWwyoS/wbzEmIlx66gSybiA0FKhrnwyj74oVRaZi
   Xx+d6/bOiT5/QcFAJstfIqUnOBTg4jYdzt25GGqLqubp33JLZbLBrCcsO
   AKOij+BjsC0Qf54UQnij8OpsVG0H2uFYzuj2PZT9IFRbfzBe+Q/tSKm9h
   A==;
X-CSE-ConnectionGUID: p5N/mE21R42TUagHriCNig==
X-CSE-MsgGUID: XKA3EfTLSEipVJO4i4VFnw==
X-IronPort-AV: E=Sophos;i="6.11,228,1725292800"; 
   d="scan'208";a="29871882"
Received: from mail-westcentralusazlp17010001.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.1])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2024 16:00:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4HeKxC/UtT2WuNYU3UHrE0cCIOXAX8vzdd95b98wLXeekkYn0WlCeZOhltJI4vmSFL9mteuJLo6snuAfuhGt/WVPZp6a/9zxyYKGvsR1sXWTCViDLX2Zc/atromtgkt3vVloI7jaraQcQnmlHdz7M/F7JRqEVXkJ74dk8rs9k/QXT9g/CAJIMncm4OhsgiDM5tKkeMnXPuDbZ7Jqmipsbq9dD6NBr6F4RtxUwy9CFe9yIe+h9IrX1gQHErMA8fwkeqpqCyPZCab5SNcd8ob3g/gFV2fM3j3CsXfs1uyCf5semkzsnBMT/ngm35x3bzSh2BbMokWthVH+tETnurtog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlZdajkFQOm/1p0NCF629kmpGvkfACxYLXgxP8+KyjA=;
 b=RI6vgA2WrNI/qvPeMzexbXKgUbfGoR7gFKfwRLmqWG56j4oQssp/is4endc6m0mAg2r9T9bQnldhyISLh+5oUcY+YuLA8+hDLqdc1C4ejVve5dGr/YvYlC8Nt+zt4cOZht+ivMnGomlyUSAyqijwxvIoXnZUh+Nc7JN+9T188BpaHH4YEbUq0k1S4RXY4MwLFs9BKd1YlKnDyGJf3X4xdCkAH4pSjY1phQebV4aZmuRySk5Db9LzKNPYB80loIVR/27q8P22ae6nUO6WXEU3mJtkc2gqJwGMce6+nvVjVAoHIogX6ASqbVz79Kh9Nv8rBPcGfmtCiP0AbEsxE6Cvtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlZdajkFQOm/1p0NCF629kmpGvkfACxYLXgxP8+KyjA=;
 b=jVkfB45QhoC5qzVTdDdgAjG/Dq0GtNqBOV/cMCXRYk2f+P0Yi2KRAtX4mGhfjqlwGQD511hu6n2X3D6wrVxGmh9Q2L0mqzTag/YpHPUewI918tvF4v06HXL9PJ+iWpWUehunJcZcVHAGCkw1wikGRJaqQVkxfVLX8aWDuJjd32k=
Received: from BL0PR04MB6564.namprd04.prod.outlook.com (2603:10b6:208:17d::11)
 by SA3PR04MB9002.namprd04.prod.outlook.com (2603:10b6:806:39c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 24 Oct
 2024 08:00:50 +0000
Received: from BL0PR04MB6564.namprd04.prod.outlook.com
 ([fe80::bd7b:c391:6f87:5a9f]) by BL0PR04MB6564.namprd04.prod.outlook.com
 ([fe80::bd7b:c391:6f87:5a9f%4]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 08:00:50 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Bean Huo <beanhuo@iokpp.de>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "vfazio@xes-inc.com" <vfazio@xes-inc.com>
CC: Bean Huo <beanhuo@micron.com>
Subject: RE: [PATCH v4 2/5] mmc-utils: Add FFU mode 2
Thread-Topic: [PATCH v4 2/5] mmc-utils: Add FFU mode 2
Thread-Index: AQHbJVlT0y7rmkKGKU6F4HPVZG20oLKVihKw
Date: Thu, 24 Oct 2024 08:00:50 +0000
Message-ID:
 <BL0PR04MB6564794698F1DF0223380CC0FC4E2@BL0PR04MB6564.namprd04.prod.outlook.com>
References: <20241023143839.108572-1-beanhuo@iokpp.de>
 <20241023143839.108572-3-beanhuo@iokpp.de>
In-Reply-To: <20241023143839.108572-3-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR04MB6564:EE_|SA3PR04MB9002:EE_
x-ms-office365-filtering-correlation-id: 23d969a4-d958-48db-da21-08dcf401f9c5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?h8SncGSuX7oV3IzhuSKFUjFcDz6HucZk1OciEcN5osAgiMbGroYs1K7P2Xim?=
 =?us-ascii?Q?fsd4xDkfuU1udXpg8QybUNY4igNmomo5IDiLRC110I+74VA6IFGO2nGWAYS4?=
 =?us-ascii?Q?6ASYeh0qbO7HDoWJNMtMZmJzFbeeE1S40Wb16nJdXjjszCmjdk4oaaAirt/T?=
 =?us-ascii?Q?XNbN5j1D65zmQwEw/m/c2ffLGh4EHTlN9II7O3+OCqBtaLKv9ykvcqOuUHMj?=
 =?us-ascii?Q?U5JFxNANgp8QVbBKlz+ceqMv4xGq5HikZjkF1ojOrSpwKMV5iPFnbx5Tux7H?=
 =?us-ascii?Q?Pyfn3O5/C4nG+VDZwRKARFqpSfuR3+C88IKRo/jJ8Usat/7NYCNbGftXbEEV?=
 =?us-ascii?Q?qv49V54V+CBBB0V4VseHNS5tCEzE5gust819Om5lFuaHqgblYRCNpBbFgdba?=
 =?us-ascii?Q?Rgxz4eBj3BLKw0uXzYgbsuZ/koX/4f//GVv6osVesEB0LwpsvF0qwA1cDQma?=
 =?us-ascii?Q?0q5BGPHzvzEhKj7FluyB52SpOjvwu57yKqc02D9ZnYCzfi4tSuohmZkaZLJk?=
 =?us-ascii?Q?rV0FmRu4xTU7Hly6X7e2RXZINniE+rBfGfGvY6Q3aQKRfkOGzbR6VYooM3ZM?=
 =?us-ascii?Q?VmaQgTxLvnhcT+l96qFPcgHFdziGdZzT68sdIA+tm57I+Px5PnXSFEEsnESX?=
 =?us-ascii?Q?dEBN0CosErVAP8eKMwK/2mq2bBDFCx+VfhT2+2pp3Yj+YWQTi25VqnQlYnLz?=
 =?us-ascii?Q?CGG7qJVv5EmwCWftkhLZExs3/tzEiSPutgrjOHm0wvo7nJI9VJADZTit/khB?=
 =?us-ascii?Q?rEoRBk4Gsm3yPHO7kSMVx1R/eJZU/f9JZoLNNUewhUO1cE6M+XYG0+XgO5O7?=
 =?us-ascii?Q?KXI01ulZYVHbPJODGUzitnFERYE3OLdADAtoxoXmlOwisiU4NovrS7qWq/V3?=
 =?us-ascii?Q?Y+Qly5KKx9bOix4k/WlOATUNfFeNkh7OCKmlWroZKVz5KKLX7/xqzPrd5lth?=
 =?us-ascii?Q?3VOFsExzcZI6cCWFAq9XWZ6iUp9TW2gIwvNQhnbtbNCIJ02QPO0pjFELJ+z5?=
 =?us-ascii?Q?cKfeIeB53pJQbEdFzdRTKWnci2R5A0DCkl/mWcCFILOIMT/16/3pOLQPi2lZ?=
 =?us-ascii?Q?z0ctciY0+MAau5GbPTfdokxSUzWOVGpPRV8Z/tyWv5/76EphOu5DcncQ3JBL?=
 =?us-ascii?Q?Ygj5Sdoy60RuAca3SsC2lWFAhuwAJNqVN/U5jYvxv38YxpEfk3sMJUl3CW0L?=
 =?us-ascii?Q?SB3SgN6x/WJP4yYGSngKHzo5eP7kJ92UGgSgEXhXgncYOBvw6wX4Nsab6E58?=
 =?us-ascii?Q?kbV/nW6qTy5IqrVgQL5kw+VPCtmtsNiiXCZE8yYM0xcHzA3+au+kJuDcVCo8?=
 =?us-ascii?Q?rgNyhevxR8czN7Kf1B7ANRjHDEM5xjhr+e7U42QqYuuinP1kQ+Wyupwu1okc?=
 =?us-ascii?Q?q2QKR8k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6564.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bhYtkrLPl++K3RjJBsJp3wwDjFTq0XFerpJTFVOkO+wu+ngaGAzkLL62foik?=
 =?us-ascii?Q?VaT3SmBxz2l1KdxFiJ64T8HVWB+MlxNpdCmMq6/CJvvkbGbaad7gaH9hYMVW?=
 =?us-ascii?Q?0VUN00zR/pT6TM386ETWz7x0lBE3AopaCUYnqYw0kFbOS2x70cW8+5y8irlK?=
 =?us-ascii?Q?ac/nY+7nIERQtNcSgi5aUWI2v/bpAVuUXKn8gO/PNS/Z0Z7L2EihN/XJ8SuH?=
 =?us-ascii?Q?YDIXVGoaEHEMwFgqXJ3ZyQ2XmXgCifBWGVVtJLluj9wCUsHWvfEsLrJ4Tl1t?=
 =?us-ascii?Q?UaVTku2V/cTphS1VtEEaz9D87OB93b3ksEkRMgRVpUZb+K16Uh6GfpiWASEa?=
 =?us-ascii?Q?hiDo0oZ4z6dasg+Ra93qFXnEyx7Ip244jneHDjSqzZ0okbr1fC+LscaLF3qm?=
 =?us-ascii?Q?kSfxvwFHHNpdnMf3FonlMBiZXKd3S4XZ6FhkMu/lRucJ5QOOZUNq+4y73Yxm?=
 =?us-ascii?Q?s9HLBsq15H6ma2is+7zgM9GEILspesWiMbEAs5kfsiGL4Lls06g/Lag7d22l?=
 =?us-ascii?Q?ZEb+kqAzjfeEG83COMfqnKiDNnwot1DjG622fBAZOV/RP2AFG2tFJAimco7G?=
 =?us-ascii?Q?UpZCp85c1LpYBwQEgiIvB+jFCnLs+X4NC2TN5sD1z9IgTryjr8DLljU1NUY8?=
 =?us-ascii?Q?/Q3lMgv6m+jPvH57Fz78WOBPLajexXq5QGMjnTjlWZ18f71Zfz8PXzRd7P6q?=
 =?us-ascii?Q?0Ioh8Yk2irhUe4QC8I1naa3q/8Ixvi0Rd3kAHDb5DOrrVsbbmjXKjOfwAqrx?=
 =?us-ascii?Q?C52W0RWqdsWZerpBveJ4K9LJ/Id7YDeRxhwGsCjSse6KW3ZZOZt+m6iuVF2M?=
 =?us-ascii?Q?8rhm3TtWhoPJcNawXaG5xcNRAlASCpk2pbRALQkqpe1w2bEHKWxF3aLlyOSg?=
 =?us-ascii?Q?yS/u+C9LFKmFYOw7isKEXwiITRQ1jevNc+Jnm/aI/pZiTWMqYNJuagzAC8My?=
 =?us-ascii?Q?ucDo380PxcFTXdiDv7pXICe4bUQUaW0VykTwFFNksfeLVSz6C0WJvWy2F+lc?=
 =?us-ascii?Q?RCw50uxSPmb/WTuMy/nNSo8yrClio1k9zva7Sb9go5+deTk+OzhSlvHp5Vgw?=
 =?us-ascii?Q?QpOVOMmDgjIo7Ktkb/WTzf2IIVcOTTAdQksN3EEcJAH+vSVGyrtw4eFg8Beh?=
 =?us-ascii?Q?E7nLWwsIoLS/ZqKS3RzXwpDhgGwTRzIaNLf3Mfzi0GcrtqbIuu0GY4RwfmXs?=
 =?us-ascii?Q?QZKFX/jWdI3+FozTqx0JLwLisWJLIFtpGFDVRAv2Swk/Rs+gE08Wj5vQEPIp?=
 =?us-ascii?Q?KkZYqAx72IWWflofVsqZWA7B+I+Q31ACDoPDIHUJOzHD4U3gOBZ+XeLBjH4Z?=
 =?us-ascii?Q?V7c5AqJw8HiC2V0yFA0SB7aHfKzbWLoCVeM0O4XqI22oGPOMBjDtqCTJHyFo?=
 =?us-ascii?Q?JjM8g3tIIwbit30fDfzrRo08j46npqlCkiusy98pVr72LIRfzGSYuiFsBf5T?=
 =?us-ascii?Q?QMbsDWSIwy3SxLeYIzvm1Oda/ODXhd4SNCNP+O07rvooo6XoUknPye0yUWEt?=
 =?us-ascii?Q?RHQsao9KGDOZ7vtbXqHrcf8HXfleyoJhjNQhAjoMcbplDMZIxiHciXHX1G01?=
 =?us-ascii?Q?K2zzgK678FYlMfSFZmGERSCLJJLudZn+8/GohDO9?=
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
	MrHfho1CFPQo2BlEnLMhnp8vlsuaXjw6Cl2rp99ygSeCmxiHze/IAHpXVZUN8uJKkoxVpOBK9Rfr3EXQYRawLUnXOl9p32j5bVYnOjEvGgysoOuVtQfpEor3EiZhPb56gFSnvGsUzacQXpUcPywm9mqAWtR4MCIfMBeKK+Unh57FTN5PzbwO2P1BIVRQL4eJlbCkQZm5fxqbOtk5ySzb1dxWHYK7ajGuqXox1bATpBxtdjEH2xzKSqIOPoi+inb0ywFZeGizE5/h+gqa73JF5Z0cPMLw8+pK0II1zu5sKFO38KSStRHqRY0VqdHwcyvlZ/vkqS9i7ySw9HDPlmxFwZNKkAin3ngVv6XysSKHB7PSupZ0/cRSkkZJQ+fHAHTqvUqMlTaGKtPGOsF78X8P0D65I9ut1/DOzJu45BmdM00x+KtC+06oDrAUbBeWGxd/umAxt8F7XDuB0JogtzIzRmq/rmKxx0+oGfA/miwi2azFALog7UQ23/MZwIiNvt1qlMCca4jRgHjeF7APmf5GO4ruoVGBjcZrkg8bdA4gsB4PDwbC8F9VjI4X+miIcNf2t0EfO44WZ0ymt4WJcTBtPHqrk1fKnJWGe7CzSUDIk1bM1aWYMCNLDzvPXGcPyqb7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6564.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d969a4-d958-48db-da21-08dcf401f9c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 08:00:50.2228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G36+H63QU2wFkVu2vNfB0CLV49/d0d265Q6FlbWfXEK8/BsCEz7ct5NMFOYUyOJpzyrpiiUOzyN9X02/pNE5vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB9002

> -       { do_ffu, -2,
> -         "ffu", "<image name> <device> [chunk-bytes]\n"
> +       { do_ffu1, -2,
> +         "ffu1", "<image name> <device> [chunk-bytes]\n"
Ah, but didn't we establish that the current API should be retained to act =
as the default mode?

Thanks,
Avri

>                 "Run Field Firmware Update with <image name> on <device>.=
\n"
>                 "[chunk-bytes] is optional and defaults to its max - 512k=
. "
>                 "should be in decimal bytes and sector aligned.\n",
>           NULL
>         },
