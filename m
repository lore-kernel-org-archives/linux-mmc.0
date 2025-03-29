Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011013.outbound.protection.outlook.com [52.101.125.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2121B4244;
	Sat, 29 Mar 2025 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743252605; cv=fail; b=muacUkWfk628s1crdTY6MJGYAZdHR4BEjl0tAVK3sAKUHlKO/Mq1fzjQLYM180y7ko+Th9UXtZB2Hxvh+boQDKXatUqbqiQ5qqfgQc+TMjhT5CBvZYoEre/uR8vizRFXGeemxO+W2EZ78v+WVvVv4lQno4F/Od0hVygFkQh4Fn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743252605; c=relaxed/simple;
	bh=rXO/28q8k2PB5cdOYax59V1DjvrCZMiqX73WlUxucfs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uH/VHh7G1eLMclAlNuuUqckStdu/OM27BQ3u6nrRwk6qEawAcpm2mF2Iq0QHacql7aK1sNDQqaldSemVEOafF6dTnG3Zjac42iYP7cp4Uxvyn1fyhoBJqvym7eksjYGhdT0xvsMo2VK9h8NAqqJV94hZkdDDeiWSJYuk0CYthXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=tfs4WVjc; arc=fail smtp.client-ip=52.101.125.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="tfs4WVjc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8QCoQN6UBipFt/5WnrEtxkmQwn24YWrASF8+kjYpvwMo06vg/HBYiOVJt5EPVUGthXzohS04rnb/M37rxsVVKvix3mx2mj73y+yYHovZlubHAoA9B2/EnDwDLb8/Zt4YwAmGk9nZqnvbJA30/wsXBFidKrJeIyUUx0hNAmtcrxY6nLQUi7rQ7eevwg18cMjgFEpJVTySqhY5xAjEC3F3dPJQYZgVZuK9r80eIawmh7W5d0wjf3Tmq9yaB6jujL8gWtP6iYssTKz395uGjtyoGpeCubbDqQ3U8fF0wwlpfE5N+DGKoTKPlp9fdEKKgMT0L+qrm2icDBvm3sIGL7Q4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8xfiPAxGmIDKSrjHNgqAdoTnHfas28b7PDMmimHVwQ=;
 b=WwyNxtEceVItJhPjLDrwOlbp/9AFijPtkmOoRVdwDZ6xzOA+OpjJUubM4Ly9o8cGVOJfg+5+noBl7joL7+7EN+SW+mk32DedTp32dnOllnT6r28K23+SXqs+9m6kqmllYfnptxlUqIG8CmP82VK9b+hWc8Fl/HJ2vH4nePdK9nbSxLkxOOLuLXpa9DHOm+I2JBMcq6A+mECEmjKREa3wq91KdTTblLOI5PRUk1nAcwIsQjUTAY9W4Agg1t+S+FFOj7+9FVo9qRq1h2QRCHI7JWLgopoFnqbE3w8Axk0R4nj1KDJT3HvVFMIG6FMrgsGPL0V7h39GiRG/ax1StVafYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8xfiPAxGmIDKSrjHNgqAdoTnHfas28b7PDMmimHVwQ=;
 b=tfs4WVjcgwZzsoQgWAnYDp8pM9s4G3jxe8H3sDn3QBopYxCA+cddAwZI8BX5nEVLNGut567ZIPhvCbRDmpc2OquyN0J36g5rhY3k12JLa1P8RTtl+I6mytuRCo24DhLI9rRlYzHL3Sp+UQW7aHYkbBB4+ykyoB1T9KeVub8gj4k=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYVPR01MB11336.jpnprd01.prod.outlook.com (2603:1096:400:365::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.28; Sat, 29 Mar
 2025 12:49:59 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8583.028; Sat, 29 Mar 2025
 12:49:54 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Arnd Bergmann
	<arnd@arndb.de>
CC: Arnd Bergmann <arnd@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, "linux-mmc @ vger . kernel . org"
	<linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: renesas_sdhi: add regulator dependency
Thread-Topic: [PATCH] mmc: renesas_sdhi: add regulator dependency
Thread-Index: AQHboIOVT+Oay99TvUaVM+eZuaRA6rOJ3cSAgAAQxQCAABD6AIAADP6Q
Date: Sat, 29 Mar 2025 12:49:54 +0000
Message-ID:
 <TY3PR01MB11346D37C0C25E66DF33ECB2086A32@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250329082123.2325267-1-arnd@kernel.org>
 <Z-fBYVzkxZOqZixB@shikoro>
 <70367c55-81c9-4387-b332-1e19ab8397d2@app.fastmail.com>
 <Z-fdsBZgcO6bruIN@shikoro>
In-Reply-To: <Z-fdsBZgcO6bruIN@shikoro>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYVPR01MB11336:EE_
x-ms-office365-filtering-correlation-id: 4a0232de-abeb-4736-0f8d-08dd6ec03419
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8JSBkSexIqiYjKu+kDPgtXUXpA13YHBCPzpvvOIa48hogeH9XWo8MNlxDWgn?=
 =?us-ascii?Q?ID3M1N2AkhuZnEtMlByCGe8n3p40fCRzEaB5LfcGQ/x4pr/qncmWi3I6HPVE?=
 =?us-ascii?Q?VAKaHc4IY3DhmPuskHJVQylYk3G197yhKEXgdduzUlIymWonfFdFDPhHcycc?=
 =?us-ascii?Q?lwPc6ZweC9cTx1XY2V9OgbLqC/o5bk43poqcV+jsSjgTGXhPmu+8QdVRgkQO?=
 =?us-ascii?Q?ot3Ryli7vytN5zn2y1rmXpJwOkZ9GR6lHudFjlqUNZDbdhAXXTQRPaK3beEU?=
 =?us-ascii?Q?AMjMVE5w8d89EQER1p5gcPT4M9Or8m1h9wG54JLXIEV7B4HQlIFHWBhME72u?=
 =?us-ascii?Q?D3Fc82bu1fJjmhSs1vFnLRo7vQHbdnvr8Um7XHb2MnVWBAEXgr4ksAq1vB37?=
 =?us-ascii?Q?nFrJfF9+LDRGfaRW/+Thhaz0RUXRHNFhdnxg7hFCEx1OWz+UJwUKeq7PK3tG?=
 =?us-ascii?Q?3s6orDhHIANZn/+z/Dqvh1qEgqFjiYyKVQIhNTHCIpb6VhrTb+SUG4scHcPl?=
 =?us-ascii?Q?VKNZ5rbZwLs4uO7pVfpTy+LbGO79j6/GXVzpWwIqJzVdcmva/pY/4Ung2r0K?=
 =?us-ascii?Q?dH5oeh10pm64KQa5ZFiVRb+tUBIewQuphs+eU59IXpTZQC0L3yezJ5TJCDvG?=
 =?us-ascii?Q?Nv10woZiCdcdv2ZVfVHraBT6lEiEGP4BXsZAfgk+Ga87u69LgFbysHNW4pUM?=
 =?us-ascii?Q?kowqAiYQBZORl1xTo4smbj1lr3rRlbqnEObDTERSfkDZ+3qqLJrmyMr5qcK/?=
 =?us-ascii?Q?Yxh2XYPFgYhnrEA4eM21vyIwsPpQ46LQmBWGulB+MBd7Gbl0dLoVHOb3/ESR?=
 =?us-ascii?Q?oKcXbjOrK+bubS/6r9o4hSY86UOHg4abPUDqWFBRwPRiju/mK2Ez+Guv+5bN?=
 =?us-ascii?Q?zmih8Xx/rtaWEM7IsCSF3hI97AvZ4oq/BunFQ5rNdxFvjOupnu+Yr32hF9wy?=
 =?us-ascii?Q?3PnNoSh23z4TCqzwCWFaQkOtFueJkxiVGmGppjKWNt0ZAUkA/tNSe8LmUOq6?=
 =?us-ascii?Q?wbJ1fJCQ5J21js/EvUue4W70zZ+rg8mjYoKeGrYJg8LeOAW3X/29Wz1gMudb?=
 =?us-ascii?Q?xyzHAXOyRNzQaF/dRv5PGPbdZtQ5mP8uOzD5fzAOFNoSSdjRawSgDu5sS8pR?=
 =?us-ascii?Q?skCIf0fJAzwIc+TWb0zVbgrbKoq3L+a+JHRnd1OsCDUhHWStdU630nghINdb?=
 =?us-ascii?Q?mLzh30h+JXQYlABpR8bT9pZV/ZrAfKi0aJKt4vKw4U9KP0lV5nHCdUSJ4Ffn?=
 =?us-ascii?Q?iUlR4UT//FAYKS7VWl229vNJqq36j+YABmHDvIK3TW4bTxmatlIMtt24Avds?=
 =?us-ascii?Q?yXcyR6ULoWVZYKF8/qQHmhhjb8c4Qb+SUHiuzFyA700VdCpnAzE8XbBNwcah?=
 =?us-ascii?Q?VBLKWBnT677S4KDDX8KgIvTfgqKYh+YE/sWXP5lHAaaTwtaTZ9RWooIhxlNf?=
 =?us-ascii?Q?lQ/Zy3AhxZr51u0ykFX+DPORYJCRQmhmEJ+bUOhu0x91C+qRQSqtf6DlkR/e?=
 =?us-ascii?Q?zfp83YFiKwiekSE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EX/mTnelcRhA2TkV7LHFEHLUY1oWzYWlPLQll7mol13JfPknieB/coDu8+JA?=
 =?us-ascii?Q?Nq5vexmow+Lhi4icQ9k3p9qolXyJ+GZF3EN1rVZ4/uWZwGLHlLa3475Dp8d/?=
 =?us-ascii?Q?XjBv2bkiJY49UECLEwXnNLxZYdcxNkGttgU6WdK+3e4u3w9zTcykbeqlIees?=
 =?us-ascii?Q?Z1PVpnnRLYrw0lFOzVq1MEmRsDmfc/S4so3RqpgpprE1xe6pfy0JKRkSyicy?=
 =?us-ascii?Q?tjchMZyRt1ERnvBHXFF5hZvrQzHcZ5TvMbuMgw3HAfL6t336+F36iUoHBYNN?=
 =?us-ascii?Q?/g6+leZ5aP9EvHpC+ZqMdtZZGVuAIiS8aSItoyF4GJEzwGA2lcP28Ea7KBs2?=
 =?us-ascii?Q?2sh5bU9uopCW4xwKGCyPZXZWnF/++MI4cWQx1tth7fz+XZfCb8mIC7tOUZg/?=
 =?us-ascii?Q?Fusaz2Op+BAJlqDbdrKLb8MsdRQ6XGwMbsrYFO3nGlkoRqwimwt04SGtb7c2?=
 =?us-ascii?Q?vlnbNEgG2ZR9OGKymp8neaCbXYOiyIabsBAME2/WENBPsrJRhRDxT23nZ417?=
 =?us-ascii?Q?WSYIZp+wZyNhF2eYIzj/Rzb6MBnUQxmExUCWGtiRtPT9lu2xy+IMYA1PJBL8?=
 =?us-ascii?Q?wMh7yZMT0yBn/BNYOaCZ1XgkbBQ6svyrpT2LCe9FG4EJmwhlpYqEKkLnYXiL?=
 =?us-ascii?Q?gcN5GJh946XpP1cwECGxcsGrMpBMkWlvMCqB2A6xhpEslIl6+SvRex+6U5e7?=
 =?us-ascii?Q?p/E6Lohc2GbK55u0YkinVqzkPe5UNxPzLsr/pF/AhUrDh+9zVa3M25VCEYRR?=
 =?us-ascii?Q?upGd/UExUXreUM//Tf+f799kaVfuEpe4LT5Tx7vpF6p/WgvfTg7L8Avmjq6n?=
 =?us-ascii?Q?Dk7xI9QHHYq/6KIK/IPtfFlQvZBz4PPzAHX4ghCGqP+/tLzywB4EYyPHjXCE?=
 =?us-ascii?Q?1stFBo9V+cMcy+rqKXi/IK42iCtbOaeGg4nst4EAwe3rBpy/OW2kHgksmbQ0?=
 =?us-ascii?Q?f0S/sl8RUVqRVII3UkChmEzK79ibfQNYJgz5JRQ0q/enFMXLbwL5NwaPBiyX?=
 =?us-ascii?Q?9tK1K9LTcmhfDZjwaASGvO5kmZstNy3F0AO5KMK6poqpCAPuMrhXEPdz4hwX?=
 =?us-ascii?Q?WJet1+jxHjk8QUyliAbWCwPumriXNzOKkdP6svy/isB/Y28td0emR5wfx/sF?=
 =?us-ascii?Q?rMLmMW2HRrKV2GqUpHMzI172T5LypW/FKSvU8BJmnJiNBVDnPw3t3/1F36de?=
 =?us-ascii?Q?ye/Ug/xNtFPQwaMuNMRS0pP9rK538UHQin6CVA+J39JewKuG/aIS3mnNPYbR?=
 =?us-ascii?Q?svhX3tLAeVMGg3vwLBmT0W8sjZts80kDerWWWgAZwObF1ATrAQxtIJoyuEE+?=
 =?us-ascii?Q?hiDcE/cHDwTE64DiIv8KLWPvHjT0wq0PAXAiY2lLdGnb4aAtLQwRGZFv7vCh?=
 =?us-ascii?Q?zzXM0Jr5mpi0nx19JEVRlzkgpdKxI6VhMZxr6gW2qzAzaK+jyZy0guUBUyEp?=
 =?us-ascii?Q?jLM9uRgc4qv7fHcK5iXxQqlf1sZsSlBk31JwE/plQkyRcTq0g5qLEiemPFQB?=
 =?us-ascii?Q?+BITEyAnv+g/X8goqkkjWrqQqAJdpTFpWeG4xXr7fq1h7S7CXVGjxVKxXqS9?=
 =?us-ascii?Q?n4vUnPrn6PLSD72boS5iJE1OjH3H+38DxYLrJYeUzzBNVMWqk2f3nspdRY/q?=
 =?us-ascii?Q?7w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0232de-abeb-4736-0f8d-08dd6ec03419
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2025 12:49:54.2868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DdWtW6UxVG8WOHolbd0lWx4vSFfUuAhrim8/FFtdEooqKw0bTiOIvXRMLIurIGv/LkPv7JDeJaOZlpoBy+HO8bOzqmmmQxTnTGm1+KePf4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11336

Hi All,

> -----Original Message-----
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Sent: 29 March 2025 11:47
> Subject: Re: [PATCH] mmc: renesas_sdhi: add regulator dependency
>=20
> On Sat, Mar 29, 2025 at 11:46:10AM +0100, Arnd Bergmann wrote:
> > On Sat, Mar 29, 2025, at 10:46, Wolfram Sang wrote:
> > > On Sat, Mar 29, 2025 at 09:20:52AM +0100, Arnd Bergmann wrote:
> > >
> > >>  config MMC_SDHI
> > >>  	tristate "Renesas SDHI SD/SDIO controller support"
> > >> -	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
> > >> +	depends on SUPERH || (ARCH_RENESAS && RESET_CONTROLLER) || COMPILE=
_TEST
> > >> +	depends on REGULATOR
> > >
> > > Hmm, this is too strict IMO. SuperH does not need REGULATOR.
> >
> > I haven't tried building on sh, but I don't see why it wouldn't need
> > the regulator dependency. The code that calls it is
> >
> >         rcfg.of_node =3D of_get_child_by_name(dev->of_node, "vqmmc-regu=
lator");
> >         if (!of_device_is_available(rcfg.of_node)) {
> >                 of_node_put(rcfg.of_node);
> >                 rcfg.of_node =3D NULL;
> >         }
> >
> >         if (rcfg.of_node) {
> >                 rcfg.driver_data =3D priv->host;
> >                 rdev =3D devm_regulator_register(dev, &renesas_sdhi_vqm=
mc_regulator, &rcfg);
> >         ...
> >
> > which sounds like regulators are always needed when
> > of_get_child_by_name() may return a non-NULL pointer, i.e.
> > when CONFIG_OF is enabled.
>=20
> rcfg.of_node will be NULLed when the regulator device is not available.
> Which is only true for a few SoC variants. Most other SoCs use 'vmmc-supp=
ly' instean
d of 'vqmmc-
> regulator'.

Yes, Only few SoCs has internal regulator support and is based on
of_device_is_available().


>=20
> > If this is correct, maybe this is the best variant:
> >
> > config MMC_SDHI
> >   	tristate "Renesas SDHI SD/SDIO controller support"
> > 	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
> >         depends on (REGULATOR && RESET_CONTROLLER) || !OF
> >
> > CONFIG_ARCH_RENESAS is only set when CONFIG_OF is also set, so both
> > subsystem dependencies are covered by that, while SUPERH doesn't
> > currently enable OF, but will need the regulator and reset controller
> > if that patch is ever merged.
>=20
> Even given the above, I like this approach and think it still works.
> But Biju is the SDHI regulator expert here.

Tested-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju
