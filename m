Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011037.outbound.protection.outlook.com [52.101.125.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437DE472536;
	Fri,  4 Sep 2026 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788526123; cv=fail; b=NwkLKIqHY1QDcHRJF/HVLTN0hdQM1r9ZBY8uv4haBBxTxnMU7dkOydn98asLAssdhnzazcYJZKS7C3SWJteoNbOyWbVPFfZIYlUp+zWG9gFtuyqfHDQMKDd1v+LrWyAc2Bl7DxgHPU+hVCPJ7q5aRzgXEEHOxbpmyBbgC3uoeOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788526123; c=relaxed/simple;
	bh=gzEUE1AeJy4kXQRkEChaprwM7xN468NBm+Bubj3oTuE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GQORmnvP5oaAKxWX4589owuwb7EPzvf2/TgoiGFpf5OcXm2hG8r3i0gOalYVhcPug4xm6BxQGoKuy2vRHCIrbQwnS6oYeangrQvOJ7KxiiVJmQmTvAOOR/Dp8RyPyYIFclNzXNe4OMdhjF2M9cFUkPBrwizEr7iI/75lDTnjpKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=tFBCYXeW; arc=fail smtp.client-ip=52.101.125.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="tFBCYXeW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAAE4LWq0JePRTBDWh706S16ydvMOqSIVV4tg8KGURdQNcetMfECmuYfQ3CVmIIku0Yer6bSQAeHEIAUd4hyYqPwPiRRnMbkhgJR8KvskWD+cPpUMKpeD9pzDSJoy2XkwoV42vLgqup8WXivg199lRgPDUmhd4SZoeLo4LaJlQI5TjVqXeAEBpEqzyycybNOMn4GC2Jy3ZBsBEGClFu2fk0zr03VNBP+IU3W7u0Tpgy1z26ro1BTXVBHnonL7hrnoy7geV47uOJMiaAYnxPdXNdDLfQNXfIAp0Hhmzu1+T6f8doizIVB/wilnfOEFyGgNTvSyR0drw5gc48ZqRijIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpBpEBri3ieTc4mXbIf7Gdwem2AnoDBrFQFfDos2Ylw=;
 b=RiRRNxCa6txPSLPPxjlKkqkazwJszb513yKHXsbKPPuJVaIDRXCqghxuwQgFVu2CIffdDDc/f9eDieZZ9OMDBl6BtP2fSUdqGtUcbXxJfE+cZSvHfcL24tttPDFg6CB5LdCWx6Tl+Dynw5gFs5lE0HNc60WzXgFU7iuvuLmMH618Gkc/nsiZ0RuOMV4jcp6lVmHaSzUrzAUC3QqwaOrCntyvfJAd4QQZ0rTEIpft7oaUZ9jHVtTQZe2miWbjmcmjIhHUDTdwsFgEC/yrq4Eak50fghM9x7NIq2cKIqGxPBLLFubECQ9rmfz/wZCP/PouigzLNHcZVf77LRs7o1Gvlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpBpEBri3ieTc4mXbIf7Gdwem2AnoDBrFQFfDos2Ylw=;
 b=tFBCYXeW7HQ+2YbdJPHKZKJOwzAg2sGrJsEisumHZciAeUjrYjscHTLX3q4+GTkOQC7K43OFZUzycXguOVpuZIlER4f/LuuF98MVJPlypEsurUnGwXDYb/T5zJLxxxqM3HJz8WcXKdQcGZMTzfQT5wEKvf30BstZT33lATfE73c=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB12011.jpnprd01.prod.outlook.com (2603:1096:604:23e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 12:48:39 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 12:48:39 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: wsa+renesas <wsa+renesas@sang-engineering.com>, "biju.das.au"
	<biju.das.au@gmail.com>
CC: Ulf Hansson <ulfh@kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v24 06/15] mmc: renesas_sdhi: Make clock divider mask
 configurable
Thread-Topic: [PATCH v24 06/15] mmc: renesas_sdhi: Make clock divider mask
 configurable
Thread-Index: AQHdMMe8aY3ganuJd0OgnZYfbwjJpba7NY4AgANAEHA=
Date: Fri, 4 Sep 2026 12:48:39 +0000
Message-ID:
 <TY3PR01MB11346AFFB8BFB5395EDFB917986B52@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-7-biju.das.jz@bp.renesas.com>
 <apgD-Kn_Cz8wg0PC@shikoro>
In-Reply-To: <apgD-Kn_Cz8wg0PC@shikoro>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB12011:EE_
x-ms-office365-filtering-correlation-id: 5a13407a-4211-4549-c22e-08df0a82d820
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|56012099006|22082099003|18002099003|38070700021|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info:
 G6W6AMlgfnXTzmbUmueXSMgAchv69alAcWWzaXYL604cZx1mwNcJwBNcjIeSGoFIGTGQt4/67eTiPJMYx9tcee8B4cI9TOjQvIPkkq2lr8083813vZUvusaL0XGYvqu1QKbsrzul8QNmp2ZdWdtkbty8lA8ZpaABQkiKC9tdh2JoPDQotvpvVAON2bU/vYGSQxxrfeoW4bni4xHO3CLNGdWwYS5apu83p9Y/9vSBruykSxquJpDEaWZzvCY+jdW6iLx1dApoq+KrY9qAlAQZbdc8G6wLvlQdW7GT2f5MRBPfobHRsPNyjya8dKb80BPnzfLylFO3u5eRlNBh1evshh6fhDxU8mCD7skGCDuRfIlkrDlVjG2EVqUjITPGtAmpfsXUzJazhm9YDR3dhTFIlnAZQKU2v6vST7gmCFmmEhvVUGlEgAV15Vktbjsdj/BEOWWhCFM7RVxGCkKqcOHf0DzzSgdQauCILnm4BIrm3u3KtIwMNd0KgLrNddCtd81yuC/UqZZsrA2AFZC1+iBngapbeNIlrtDrGsedebVTFtjnUmerG5P93AiH9q1CSanuThGvoYPcnLkeyIRxNK0q96BYg33MsXC3kCTQwJd9qo6vAWSy8C2grzIeD7EaEu2ELOc2Bk3F7EpHTJtNqpTJLTHWJs+3ylsGqlZ4g6DWekqufUF1FmYnLYwCCD6i2EEVX2YuBaNHXkAa8o/8Jaim6aaaOzuSi/QpY2pEtsFEfDA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(22082099003)(18002099003)(38070700021)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/kUNfAXrH2HWgSd9YnQXL2lxhfN+FqW8DsYLtT1V5AHQBaVR9bbiW3oVxF+S?=
 =?us-ascii?Q?OL8ZbciH3rk/45W6xklXrEmL29J3Lo1eDnl2aBpixDqalIfoArNfeE4z8shC?=
 =?us-ascii?Q?UdeKhO4yaQzFWQc0xG/vP45sfRaAPMzXOUMpnYMbo1gcQMyOGfL6cw/4kbwn?=
 =?us-ascii?Q?cPqnVo/+RD8IJzPIv6yXNOVIYrUq7kMkTxPr/ZPeg1kxCswGW4ULAIsjt5Gy?=
 =?us-ascii?Q?L0wVuXW8MPebWTTsPgV2SRE6NvUkDbB6w1qccFdQjhp+8V3RAbFsIa8M+6Bb?=
 =?us-ascii?Q?SL3/UfVNA6ISPKA5Z/m+oN2XoVGZjCvwGTwqKtibH4+OzC3lEV2Wp4IlY4DH?=
 =?us-ascii?Q?3trBugr4rC5AGJxNUDJQdcwzE7vUW5XwwTMm/KSiSlJkHvxKiGkk12lU1gq0?=
 =?us-ascii?Q?SsdH/1SYMZeLqv8y0x2VmQ4So7dDSrRZuDUuDeUcFLO7wk73dwCXzypxH4kb?=
 =?us-ascii?Q?G34eld7FU4wHOTsqPzf7a4mxGKQnNWnqoK9M5YBAygm04FxWuRmhmaub+9Gb?=
 =?us-ascii?Q?23TZVCenpbEhiOAtZViVwWz46BOMDgsS5BAAW2iFsyQJNlOiiLihvJRnoEVL?=
 =?us-ascii?Q?AOVqE3ZMssJMafehgBAtwyZgRaP5a/G6by0QtLtS+A1/ii1kMvi5wI7cTdBU?=
 =?us-ascii?Q?z+stjs1fO8S69+M9aSgHfQ3blLvg8jag5e9DvwnNGm5PJnypMAuo+zqWmUGx?=
 =?us-ascii?Q?uxaYryXDBR1iY7lEPSQQnRoigYf93u24TaQmOjXHEqZPF7qRTL8Lr0gAHjQB?=
 =?us-ascii?Q?buc0q5U7bkWPKqI3/z+DsrcY2bKI2LwWZZlV6NR951BBieO4fn8CHQ19BjTK?=
 =?us-ascii?Q?BOg/07sfx51iaY/pX3voe1Rm/KOniyiNixuxPBJUNL4sM/CJzbHuNjcKU+fL?=
 =?us-ascii?Q?9cD7XAj/QQVxXeOM1IJoO1OV0msOLAp5VwerLDxeA+DuiUH6gDunHNz8ex0b?=
 =?us-ascii?Q?87g2Y99UbYHwZ2YJFsnE7ltnmfnxblhzWxtDxbxgyiSSZFfuki2OHK5SUJ7j?=
 =?us-ascii?Q?tPIV6QISev/2bCGj3+po/wTR+7Ej4Hq/XcUg9IWUDCag4qCe3Cs+n19wrQFN?=
 =?us-ascii?Q?COBHbyAULlYzccPRBWNeGRAhbtHxeZc1+SCmXpnbbSje/AOrU7EJAbAfa2LB?=
 =?us-ascii?Q?yniiCuGIJF7qwJP0mvGZx39wlZk4KHXXl5YKM+iksBVSz3c/2MWgaqhok23f?=
 =?us-ascii?Q?N9irXJfhK9QXRdvFSDoE8kRK3+3cga395Ds2pbNgZn74FpEIlprNSA8V6b0v?=
 =?us-ascii?Q?EQD+zQ0qaBxW2YyWTxm67HL+aQyJHN7BEsZAIZd3V7A1yqJaXqBbbRVCrRuw?=
 =?us-ascii?Q?mlcU1QgVG3uNf8YZeKJQV8Ok77RdR+utzIj5Lqo8HC/5EJ7LkMjuoqShXLF3?=
 =?us-ascii?Q?R8BEs3Z8L3eWQls0Svxy5xUtWVtm3o+34kezldV9sVPQIxDgCjzaFLzSbq0k?=
 =?us-ascii?Q?VatxuCWK2dISs4Vsqb1HJ7AUKF4Xv6hSFrmo670w6JmYqd/TrxXPdxU+GQJb?=
 =?us-ascii?Q?FG85mHqrhgA+YIa/sHB/wW6Uak8T+OEnoBFgePtIS1Bs6Q7J7rJRqyy/Pv9N?=
 =?us-ascii?Q?ldA/lfoJRsjMJO/yddcTkIqZ5p+klV2BJ9sQzVl5n0rg3S89TjPFl2yFgZ0t?=
 =?us-ascii?Q?Pr69udh6zZsv5E6T0xbKU8kBa3NQtuw1rSU5sAXnj00xxNPdFe+s4NXdqjlA?=
 =?us-ascii?Q?vN4glIgk8VUlQ1CjwxfCJp/5o9TIln5p0WiWqtoGfltVw2Zq2lvRf5y6S0LG?=
 =?us-ascii?Q?pBHY5r9f5A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a13407a-4211-4549-c22e-08df0a82d820
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 12:48:39.7893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8qscEYiz7Tfak4TaY71NLE6RMfEVX5KXh8bgF8QdNWZZw98GernfgWuQ6CYoz//yz2ybF1925NT4uypaL639QJhlhCUWO5wzZYHxx6NiqtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB12011

Hi Wolfram,

> -----Original Message-----
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Sent: 02 September 2026 12:10
> <geert+renesas@glider.be>; Prabhakar Mahadev Lad <prabhakar.mahadev-lad.r=
j@bp.renesas.com>
> Subject: Re: [PATCH v24 06/15] mmc: renesas_sdhi: Make clock divider mask=
 configurable
>=20
>=20
> > @@ -103,6 +103,7 @@ static const struct renesas_sdhi_of_data of_data_rz=
a2 =3D {
> >  	.max_segs	=3D 1,
> >  	.clk_mask	=3D SDHI_CLK_MASK_DEFAULT,
> >  	.max_divider	=3D SDHI_MAX_DIVIDER_DEFAULT,
> > +	.clk_div_mask	=3D CLK_CTL_DIV_MASK,
>=20
> No defaults?

OK will remove this in next version.

Cheers,
Biju

