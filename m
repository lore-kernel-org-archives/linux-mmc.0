Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A8936B
	for <linux-mmc@vger.kernel.org>; Mon, 14 Oct 2024 06:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728888981; cv=fail; b=DwQv48gPQvY50DRdt4kr2CL1DF4Uv0NU1VYYZycsAX3eqBC044e0AWouy/l0zSY6rAneM5rbmQJ9SfCfHquAaXPc6QBGE/9gujiMEYUAew3An4qZ+cSACKocfglbpSc4JvqlPz174tUT3NoUBjVBLaXH3C25Uyv7+qIYmbzypzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728888981; c=relaxed/simple;
	bh=MNmL0f5WOu4Ecm8r0Q4A91fif78rTTLsBFfS821UluY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vCoOhW9CkeNn3UKgHo8GISZegyqYwCDDzA5BJYLUkyFLcFNHxLVZzzZ5r9v3ZwiIX1ritfMo/TpC3VU/8FOdYTHzKPJGtX7OSfi3siBioEBlTPjdgE+gtHw/MLxCHA8eetWW72h1nB0lPosxMkAlNr9fQ24aW1YkJ2KN5AVa5Eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RqiI2sTZ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=rMQkzxdj; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RqiI2sTZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rMQkzxdj"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728888979; x=1760424979;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MNmL0f5WOu4Ecm8r0Q4A91fif78rTTLsBFfS821UluY=;
  b=RqiI2sTZx4GOWqQBuIUBhJAVT67B2rJ5YbIMwAG9EbHu/0/RwF/tU/j7
   dXeEJI3V4pXMAkiQAb5DIz7RQPTCcisn0w5Ss2V9NR09UTX/3R1kRWgtC
   C+Qs9GHGg57upjCKe5CyI3I10vXWBBIAlFtbagHJtX8WTLqStRBgL/yCA
   YwxVxoUQQyfXy6Bmddp28zuRfoHfYoTzZT+kf0Ca5tn2wv9RIr3fWtOSY
   1ccZOZEh9c7qFCAw+i7OOpzvVOIYqjZ1XoN5JPKEAtcj1aUHaKmPIj38v
   Om7QQbUS8aHEDshVA0lLOvo2NEC/LIiO8M9NDNpsAi/ExPe98XYBuiiQd
   w==;
X-CSE-ConnectionGUID: jMNSKiVDSm2RogLnoyejzQ==
X-CSE-MsgGUID: mLSMp3SqSHuKwJtpQLdb8Q==
X-IronPort-AV: E=Sophos;i="6.11,202,1725292800"; 
   d="scan'208";a="28890100"
Received: from mail-northcentralusazlp17010002.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.2])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2024 14:56:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EoBQ9pnr3GbamWc+vWp1QFsnD1OOeTg97uUsG1yYYhVE2SECCLZ/NA9JRkvS4+KiSFLxlovQTqlw/QpmEVhM/dGBsy5L836veKdat0kk0xI8wGAC9pyn+7puTpPoQUbT/jv+8AM3a9yO9+3pby/6uajwXk7JwdyZzHAvL5IQ85613L4ltPix2QP8hwYdG1D6kTg9pFkWZ/lOfflKJdWnltADp71yK9ppSM1/ViONXdi4NxHXMhaWQUe33bdBOc6B2wdfceqW/P95ajwvj2H9OCKMIXMbnufg0Lf5oiurcyP1WK8gBQ6Z4cEvFLyti92+ahnBCPkc9Wj6GNUmvUPkyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLYMhh21EfZ4+FJylYJtPgYEcrqJJEexD5pdn8AWgj8=;
 b=WiGwT0K5avZ9FPT9XjM7NJME3Bek9e669p2DIwwdqKSLY/rIgGVqoThzUppHh7bgI+PrZpt9HJrvnsRucSGyPJ8GC07gzZ18OZvZgJmKvpbm067CPlA8J2FUXHdWQo9t5REmmHbVf6UnnKtnaQXOJlSgfQh2kBcK5JWTXKQqaw/mWnSF8NSr647pm2EVvgvyJtTQpFWSBvrz3YcoL1DgsexMTM/iN2XBk93K1vqcC6rMCtlhTvwVVF98niLj1TF0OOl8gsq7nES/MtEjPe1OWFpFCvXcfB4qkqpupfYM0Hi9Pe1T0uThDam3mrTKNrwanxpIQKY9xorRESGnGiXUeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLYMhh21EfZ4+FJylYJtPgYEcrqJJEexD5pdn8AWgj8=;
 b=rMQkzxdjc9yuHfYeufSJLdFjL38rwh9CSKrNrd1GIIRIzqLFj5Tb2oBXlAm0KpJwWKnCWyPXfDy9W8OGaMVRVnlW/5DnN1ZHHAmzyoztVAucbta0/Zj/yaMQue1+nLRvAdp4UuAt/lgfcB/9vpgZgNfyZZpRBp9xLSaDrLg/8fw=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN0PR04MB7997.namprd04.prod.outlook.com (2603:10b6:408:158::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 06:56:11 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 06:56:11 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Bean Huo <beanhuo@iokpp.de>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "vfazio@xes-inc.com" <vfazio@xes-inc.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC: Bean Huo <beanhuo@micron.com>
Subject: RE: [RESENT PATCH v3 2/5] mmc-utils: Add FFU mode 2
Thread-Topic: [RESENT PATCH v3 2/5] mmc-utils: Add FFU mode 2
Thread-Index: AQHbHbRABQVe0P0iN02JdBh4Xm0Nz7KFusMg
Date: Mon, 14 Oct 2024 06:56:11 +0000
Message-ID:
 <DM6PR04MB657560CB169629A671BE4D40FC442@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20241013210925.123632-1-beanhuo@iokpp.de>
 <20241013210925.123632-3-beanhuo@iokpp.de>
In-Reply-To: <20241013210925.123632-3-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN0PR04MB7997:EE_
x-ms-office365-filtering-correlation-id: 8ec96245-ac35-4ebd-aec6-08dcec1d49ab
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?F/mB81Mu2paWrcput7C+ix2AmPUA6qUD4SpU7X/CrZtyMjczOYgWC5gp1Xqz?=
 =?us-ascii?Q?5N/MYWdTPzPeEM38bt1BRnuNEdu5FOz+r1H7UctQ7PukvAJGqLGGET6WTqR7?=
 =?us-ascii?Q?LkLUbsdiZ2C5O8G306hcRVFZxaqivdjUj9fazrTD6CnBnPENXmN9xJuhj3P0?=
 =?us-ascii?Q?UPhbOpIi3zvqkvmJSaH6K7cCi5DdhFsr7Q1LNULByATs/v5Ogg/QEoc+7u4q?=
 =?us-ascii?Q?IJv9jWG5z9kRPMteXfZz+5xNM40br6SyGudq1Q5Ayt26KBm9S49aPrWX0oCP?=
 =?us-ascii?Q?iuyQJuSHm5o1IElAxQia3GuuCRRMgg1O7GLyuDzBTPuz7IV+7JNWrVvAaipV?=
 =?us-ascii?Q?GkAw1iSWik01M+qRhBINIMLGrNGv4sG3GWFjY+EbUuqa6+SWQ3ddc1TFxeQI?=
 =?us-ascii?Q?STKOAlV6rt1NAPy1uwAWTiaMt72o0HQb/8H5Or6zPMbo38Xt6JQRs8Y/t9Jj?=
 =?us-ascii?Q?1tGckUK3XbYtF4YbSry20n8YHmS7tcRzhTUiGqHGav3QEWIM1H7mj749Py5a?=
 =?us-ascii?Q?+hAM0KUl9PAzexvSm/PIiz/Vu+yau3FxLm/X4gRLxKRfiAZMQfRku1YsK275?=
 =?us-ascii?Q?3BUq9v8mtkZMwNNdRgVrSq9E65n3bYfne4zYBSrQljhDzR+rHbE+oMm1Oes6?=
 =?us-ascii?Q?oN69ksU3ux3Y1ezFayO+M5+4WFS2MyKZ97XTJEtRUaPFT5ZPtvpSxtlDTZpp?=
 =?us-ascii?Q?HJCUVPc78FR0k1uLjsRbT8crMwS1O2Lgy/Tukgd1pxaF7MvRzVUirJRCq0Eh?=
 =?us-ascii?Q?P1/WR024fhYsVpQLLG6XdUnxL5A3UtzjbVRIS3TPV8614JKKyFjYnr5MgGb2?=
 =?us-ascii?Q?remBNs3+riP7HiiQBErceG+q1SwVGtalJS2seeqIU1R9QzB2n9Lwk+vkr7Qg?=
 =?us-ascii?Q?z8eA8fkR8j+ZI2DI806gf0XFgRNDAWgXOeG7pwuWtmfmR1f23fvBXPyo+0Xo?=
 =?us-ascii?Q?gBRx/DluayBxcXOUse2bU4oaZKJXPAY/8ZHu81ERwpgvvPn6a+INqx/iDcMN?=
 =?us-ascii?Q?MgwnTLcQCAbyD05i8F4/+cu/hzbU5lb0tXX8znVXPcTDrjwY4FWaQ4tn4C0V?=
 =?us-ascii?Q?mtITLqS93Ag4ZnhfxPPic4psr44ZrZsFP9YryqG018bQ9A/crs2QANZstvF8?=
 =?us-ascii?Q?RhhSCR2LbFM+5Fqcm7tGY2PlxJSRhSNYOIJoY69XWBdauoCMqv6WVPFf5mxX?=
 =?us-ascii?Q?G5xZo1xhxgDFCbyjfyOWiMgaQC3zawNax3+Dy5f7kOtq4SSnzpqNbU/62fXv?=
 =?us-ascii?Q?i+aGyfw/Xzi36BTNvn9d3EHDW+68WHydTHIEOxL6x96mGChMOapcLQz2sD1g?=
 =?us-ascii?Q?5YL2D92Wh1+/ijqCD5kcp/IQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?u4KCxVFOtooQygCvkAkLBMcW1s9/vYafwE6t/54MenJKLAg+PHe4w9YZau3h?=
 =?us-ascii?Q?nvseeq77QaKqIkpw0lAzvLIX93E039aM+/h8XMY21BY2g/a8gPs27KQMVv1X?=
 =?us-ascii?Q?B8fjIxsKdwTBNivhnOYQVb9YmLGL5xU0USLrXXJGuPd1Kei5NMM5fW0m+cZa?=
 =?us-ascii?Q?NUrDN8Nd0Op+mQAa514bWJX1dInW907s02LiGyKkiNa8dNauFG2H6TOPDhR+?=
 =?us-ascii?Q?aZmXNWk+8rnKlgj9Ty/a5aRrKTXzEH85FEbHRUOCD4VC2hOrEjmW0Y5rylPI?=
 =?us-ascii?Q?sguAt9OFH1USHtDUjgFoBbjfuKBdxidA98eS3WGXnJyKV6MoIiWM9F8ZLuc2?=
 =?us-ascii?Q?EXjkq2P0Pim6+DzbFaHcQgi06eLY+P10+DIHmSNAPiYY0utz/Hgf20zOjeGS?=
 =?us-ascii?Q?tXeCdCmGpv73nqHL74yG2n1zGOYWB6RHIq7VsNrmw6vnhNI7ecanGxc8wwgi?=
 =?us-ascii?Q?uqJ0ki9ajSbiwn8WbT1gljSbbXi+5fJyxcsJ+Fx0K2RYJw9l1z+tYQG720SC?=
 =?us-ascii?Q?4fWZbZnqiZLJrWkiq1CEa/bO2k2DIUouvNdofYasF65zXOXAlpNKLRJPed9L?=
 =?us-ascii?Q?rl7wSTsLxM6W/UdXyYSN1s/H5kareFtuAi2m7YXaTWexmEEo5Mv3g517tgld?=
 =?us-ascii?Q?gXIQ9anpcZY7BLYrvO3h4b9h9+ZK8BZa/YtP6OKZ2YgTrngiH1RVnwoAW2GQ?=
 =?us-ascii?Q?Rbfk9f0o0W09ze9Ayx44RVxO0kwAXcLAFokwqVhEPnwAzbcR1/dcopFlVnGl?=
 =?us-ascii?Q?xWS3kg5SSiifgh9cHZASypjzQfCt1uMyryT2gWx9OLHeMWP9ifjx9D+BKCE5?=
 =?us-ascii?Q?RKlfA1hHkUO2kpCvlN0xJU4rR4nZ4rewylP/IW5zw8CICBu/vAzr5adB7H8e?=
 =?us-ascii?Q?lNU52FxFCnPeNSAnf5GZA6UWFGGooFsWuJkMEbZR4Ur7/sY86CyoUy/3/8Q8?=
 =?us-ascii?Q?NLzhFANg4c1EiyqSlgYAMA7Voq2xrhk0jku0UjDPbVh5bEFHFcyVAOZpEoA8?=
 =?us-ascii?Q?3vae5X5BK9icHtJwj8ZTtzsgdRINMALqft/T4D5/G34P2QtAFfKyWRc0QLW0?=
 =?us-ascii?Q?NzF0gVAoAutROpB7FbWDSUavKCsu1PhaTn6GdZU04+2p8b5xmGzOUVNw+hkT?=
 =?us-ascii?Q?wb/GYtLUAHq0rA0iZR9K2pcPI2QIlOI6IcK0bbXdmbNFIWXO4SSzZtDLIKba?=
 =?us-ascii?Q?RtHrEXu9xRbZ+z6dv6SAQFTA7ZzSlnbzhf2KjsGlXS3HYn1BB+67un7PUyM3?=
 =?us-ascii?Q?ljMbq88ukLMs7ujbpNdAOtmFIvApfYjU6qK14xADrliIg+ADukUe5SuEJy83?=
 =?us-ascii?Q?Wj1W+n53nkw+Ee+a5HLh/f8OG9rNfsPpJE8S9buNvJJes4ZM3cPLl71bTuzX?=
 =?us-ascii?Q?o55eIdkDUentyZu1IOQgHjC25RnB9r4OvgEFof91Q0GMWDSDVwwTvIoDPyx5?=
 =?us-ascii?Q?sPuEPEpqLFGN7/sPGaNPbM7s2/v73CCkQtdmwasRLTcD3sn7UISxyD+QbInk?=
 =?us-ascii?Q?jWcVxMGiMnU6dLWsz1i2MCXHn4cOfShseFYCrIE3eqEpYiYT2u4v2O+8W1d3?=
 =?us-ascii?Q?7DuBL15QJ8+euoTW6g9DhtvFRdgidChtFJFAEZ5Q?=
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
	MB+xvGdrFcbQ2aCoiUSxSED4j0Hf8eXcYhtyGQIqpMOyCWiGlQwKG1CuTqo7MWrnbilx2r4rSRCBPsh8hhmEnnP3bXnZWpBiUtZaNuwuCKFbKVirjUfn26LKgEDQtvNziXrTkodoqs1hZh03fYINNrbsDabMuCglLL7bFL+GwMcBg8vruGF+yd7p3NcpMS3d/OfpygjH0nihYDanXVfzyG+lRt3/CLcWRY5m5BNYkg/u6stLekeSFvGwk2GGusDe7p/+nz0fBYilLFYWvxHO1zwal/Unu7itDGwfxblwCZ+APgKrijq+R51zQZDx4KSnF7RcdNxZWQpeR9VtFOavOYG8xna/tLJWMonN+fZGY8SXWRtF1j+1oScWV8gXE3V8ietef1HfwsPQ9zfrw3KoOd6aYqm29Uz7k/43MKHsjhkiUpIr75VYt63gGYvNvjZs50orIuLcNyNcv75PdI+0vxgwbgoucmSZSP4nGf5ec+CgRAWDCzEqtm7d+lvCXOo+IJ2mWykenoxby2UInojRsdfKJG+xt96x0v4lOqADr35QzzffOvjd8gm9v5CI/QBLuAmbPCHdgf/C0W/AQ2d01gJnQkxZZGu6XJeMoi3c8OeyC2A4dTWhyXaf2qbE+lYe
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec96245-ac35-4ebd-aec6-08dcec1d49ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 06:56:11.3408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g6idpRigI3ssL9PK3RhkrQL6bjUIk1j8XzOD8SqMbYkvyn9A+fQkFja0aP1FMGqsFOy7vUuFNNYiAA/wtr/gDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7997

> +       } else if (ffu_mode =3D=3D 2) {
> +               set_single_cmd(&multi_cmd->cmds[0], MMC_SET_BLOCK_COUNT,
> 0, 0, bytes / 512);
> +               multi_cmd->cmds[0].flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 =
|
> MMC_CMD_AC;
> +               set_single_cmd(&multi_cmd->cmds[1],
> MMC_WRITE_MULTIPLE_BLOCK, 1, bytes / 512, arg);
> +               mmc_ioc_cmd_set_data(multi_cmd->cmds[1], buf + offset);
> +       }
> +}
Actually, I was hoping to avoid the "ffu_mode" extra argument.
So that each do_ffu<x> has its own fluf encapsulation logic.

Thanks,
Avri
