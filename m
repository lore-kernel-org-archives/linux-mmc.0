Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010043.outbound.protection.outlook.com [52.101.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43C543D4E9;
	Mon,  7 Sep 2026 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769669; cv=fail; b=oNGbhVrPl99I2C/BNayuE5mlU3ARmuXo2ynnPcZ9MAWi0eqQADnMLnP1Ycr/HjJ5rtzP16g8EWVWPh8EDsL/37QcqXvbCZVuZFnyOamx0hLLrD9+X2Mh6y0V6ulWvkJa2uXBRW/P1Vl5GVIPu6hh7WH1E8hy8C6i9NLwGwDIq8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769669; c=relaxed/simple;
	bh=Xfwh6JxDl1q6koXq+KzvupTF+m1pVHqqzISR7Jysod0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Me6h/+QCUqU71WGaLZuc8EAZ8GVf9mpQ2ZScbxPZL8rI+cALnso309lXgl88D8AHOA7WNBJOeAqubnsxOkFzj2WGmtV851Xv92FCoyou9nd43BCYlGHloK+ROpMVhcgcVliWVv+IZhuRdklZGm6GFTqp8XlEejRpaIH3Edovb4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=HsX+Im++; arc=fail smtp.client-ip=52.101.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="HsX+Im++"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufTObfVYDxJgjTOrIaE/VG3hOHM9VYPM0mnFHbSZmwskFhEd0nPDs72r/JOAbkEm+gizQZ7s9nqHN51+Cy7GRm/Sk/KkIIFY0nMwn8/4IMMsJYoYywUtIEWRpKDpMe/NHxUMArRENEmtL5/XCRksPmz5xwFgff7xc0ea7+7beZfw5MYKHth8Z2TAi+LnedWbzxifhUBBRjJW0fDq8WCp8GBbJEDLmHupj3i/KoRaj9AfvWH0zOAocycqpCjmkVGWSjpCWMYy+vHPuAw2vTksJMb4gRdH96JEEoof5HvwWBIqWhuVTd4iTKe8B2pA/0qM1h8BraL8F5J+F6AyfkHEtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yt9jtXLa9pDJ020Ezqa1HXPRd8SuvsGcMdZPBIXcDbk=;
 b=IaAVsE0mmJ+NURxFldQFIz8Ehfb6atPzGnjuYv84wP/rr0l+4ULfm3yJiEqLwlAa7lrZ9j47dhZmDrDUerbKYy+8RC0nvwUws+oQ8h1neMOzRNkkKX1yxsKYmfVLoB4HdgdwQx6i5pjdEik1i5l/ODvwj3uX6gK0GUUeOUTxzEsil0oSUwKVtwyIU9tZA9xiZPegZ1zx0djnWmZ0yR+TVbFuKp4+DSx5863Jbi8WL8tE+pqgBIgBa5LWzNliw/edm6iOsKbpY7HeK5TJ5pKuxMtWE+b1GaIM+sxkRrZ9FxmvxAMAG6QTTtFJuP6d7OB+3zeC6lCD/i1ERQt/xKelQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yt9jtXLa9pDJ020Ezqa1HXPRd8SuvsGcMdZPBIXcDbk=;
 b=HsX+Im++awQ1DzbMJAQNR2hDNoxEtcvtwu8ITdD7ERO/Kj5uRWW/xpgdCY5m4lDUXZCIHjx79C1wzlD65nD0KkgT5hhV1O4HJG62Fv+LhUSevceSDtfkKv4+IUikL6Tfy4pED54gvXI85GlQyV4c8fN9t3cvj9dOravrjkTG2HI=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB17365.jpnprd01.prod.outlook.com (2603:1096:604:452::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 7 Sep
 2026 08:27:44 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 08:27:44 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: wsa+renesas <wsa+renesas@sang-engineering.com>, "biju.das.au"
	<biju.das.au@gmail.com>
CC: Ulf Hansson <ulfh@kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v24 10/15] mmc: renesas_sdhi: Add write32_hook for
 CTL_SD_CARD_CLK_CTL register writes
Thread-Topic: [PATCH v24 10/15] mmc: renesas_sdhi: Add write32_hook for
 CTL_SD_CARD_CLK_CTL register writes
Thread-Index: AQHdMMfAfNE6w/AmCUKaMfvf8hhQWra8vZYAgAYkctA=
Date: Mon, 7 Sep 2026 08:27:44 +0000
Message-ID:
 <TY3PR01MB11346DCB87BE26D185FE8017B86B22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-11-biju.das.jz@bp.renesas.com>
 <aplM1LLFJ4eo4YJ3@shikoro>
In-Reply-To: <aplM1LLFJ4eo4YJ3@shikoro>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB17365:EE_
x-ms-office365-filtering-correlation-id: c4e9d814-2f82-4a4b-b5d9-08df0cb9e3f7
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|38070700021|56012099006|4143699003|10067099003|11063799006|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 IX+vBodB0Ry2ULb40FSX25uTBPDIfFWzStOEGCQHQgdzqSsR/nxTXxTu29+/8tFzKFn66WcBAClbjr4tg9AFClHJoicQshGZjSXcIwe7w7rVU8OrURH/LLABjge8nHPleNcI1VM0y6XC698534yKsi3BII6iO5TiGJ2f0XkLcKEg0V3zF6w9OdAitMzq6e5hjEzLM27N7o1tGKykHA1fsQnU13ge5gxAxNddKYg3n74lh7AJdClPbPMOJ+NDK8GgQIavtzMnTXiu/sZ8DgStDJ+Qj+cCKrvFDTepMmp9DjAWurg6mrwH0uuufl90ONqxvI62vv0Gc5Wh4Od4LjCwkwzW8C3fmv+rBCU9C/jCCvR4Q/nBGHEKGTm3Y1Q4j9ctAXwmzPirBkkQUhh+/U51rB2Do7GAP07aBOZ54TsURVg6PjKR7UnMnQzV51a2aXIUfPsRM2LTXgaposcM9sgNwTHyOBIh394sB2OWP2G35TEhc8cclX7X3uVtjHPLlTaQtBTiD4E8cyaJ884bQ1eWrKrxk+DXZ8rdA4cuw1mOcww1d0zIURdELljrFLCDzuKXbjzVHbFTiRIUDVMCQlLOyGw51w0r3C4FmBfZ1rMZvY4kdqHEcSoztxc/ApvyM4Oyzvh27cD0Fk4Eh2KhZsQ4hUixgjOWiI2b8KwoCLswstv4fQOCfWHnd135VO7LYPAswLQIAyLT1pOvOYdFYJVBqdlIXs3YL+o3hkIYw3fBlng=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(56012099006)(4143699003)(10067099003)(11063799006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pviqQairwv/Mz7OwoOAqyeyo83ZUM3JUQ7geyNnEdY+NehGu+Ho9RvddF76O?=
 =?us-ascii?Q?AgLJ/k33MGjgX5OQWGnQaROEiK56Y3enKDDsFAf+ukEjg1ZuLVOtFDhM5A6J?=
 =?us-ascii?Q?Cyj6RPLAR2n3UL63/Dzhmo4HmOmmablx1eG9nnXmRekzdv4/q28us/JZycOI?=
 =?us-ascii?Q?muF8GhKO2V0zY6aPytdAWi1iucTFXgPJBDmLbxgsUEKoj0SzJPkOUmDrkqos?=
 =?us-ascii?Q?0hGCF6wyQcOJPsxghX+B7RRIVh9aOA2eX3rZBsqOVymTUHIafv4nLSZBWYu9?=
 =?us-ascii?Q?rjVvUruQE/JfoP9nAvcwcxMyzbmitvPWpTAjIy5U9rw3VCN9HZM7jS0as8Wj?=
 =?us-ascii?Q?JDKYFkOmejaQHiSo2hfbW9jfp5/CBVPH5/tuSMXLnRS+rWjO185MvFVAYvlW?=
 =?us-ascii?Q?WyGVnLnTKmVayOsQ32MPkymyKVom0p7tdEo1w3K4pVAza0z7l3UiKpElBFXa?=
 =?us-ascii?Q?iTAw7JgYLrTz/hrrd4CVsAAt4MsB518pT3MTswpUU4FhknYVjiAGQH3vJtla?=
 =?us-ascii?Q?OiY0vNob3oLKx4sxdKK/EPUNCkc97/Xc+siR/Bj3aLpycNu/t193KNvaNWZm?=
 =?us-ascii?Q?XOJa9PXtTi43AIBDwmuPTWir3OvT0fmmLWT7/COMrwKy8Qhmhu1Du0bwhsFr?=
 =?us-ascii?Q?W93if9IwpjUbWJ1HD+rbEWlXCYV6TgU+m5+9/BoZKo1fd/qSXQSaUDYROa9f?=
 =?us-ascii?Q?Ibli4Hgi0scZrdJAvJBeY9o+YFDb989W/OCkBUr5aZr5os+ldcK7lWeZxjIy?=
 =?us-ascii?Q?IJQv6/96D/vwnz9GOhId29VEf3AYwdAujSES4kRIMmzNB3wxbVdnpaVxSaiJ?=
 =?us-ascii?Q?fR43c41zahIqFcBjOEidhGEumdIfoNIEwNcUChWrz9B7fidWVqO+ic3Ex29j?=
 =?us-ascii?Q?LiK9/adJQqN2VL+z32cd88Xaickh1Oc/tEFBP4kRBB90eJ/VT36EjiqGtwmy?=
 =?us-ascii?Q?1sicguuTcDGbOLpQmjEdPxl4v9Vh8zMAv1mrlAhRImXauToGDFFS7HqRJ48g?=
 =?us-ascii?Q?2Ymm4u7BMqD7/tPJtCzRJX4zaGtdADSSTntoAJN/afqVablM5X3K/uxbJz0O?=
 =?us-ascii?Q?/eWSgDi8UcdV67MWoZhu9CLsF6tAyZ4sdvkk/fgM/Lb7sac15HijSSsxPWKC?=
 =?us-ascii?Q?j1mruhPNDbpt6dlXt1Wz7dRZV/1MZAWmseE9JmqN3l8zx2WuOvI9gSGLYzIE?=
 =?us-ascii?Q?+Pld7msJmxMxEtWEKt7Uix/bRssCSBcphgsLp1LdIYhvkmj/F/qnWFS5YGR2?=
 =?us-ascii?Q?tVWRVrpSTy1w3fKk8pAaBoasos6xsJNFRx02o0DzhqWdACsAytA/J0gK8WyF?=
 =?us-ascii?Q?Q1a095PTdMwSBINk91A9WnrWX1CBN/Pccy6BuIM9Wi6sUPlAAW7Gvdgr6puW?=
 =?us-ascii?Q?5+Kisqx2B6tZTfQyUQ/7j279ciuTVSAoftW03IEaTNt4Yqgfz3TinKEgDDch?=
 =?us-ascii?Q?tCKxIE4FQbT0nCc+M979JRGaHz2KXRtre6RC+zew6QqtB2Ue4P1NUcXZxgn6?=
 =?us-ascii?Q?tqzceUcMPbG89QJLBpx0TBaAjCXotpTN5H4T/rlfvyYspHqJhdMt939Qaa4g?=
 =?us-ascii?Q?1TdaUkUHtRuC0IDAdV0mV1Gz/EkC6bJVbp+sPUC2pqg3TnIWZdKU/MzFFTaB?=
 =?us-ascii?Q?Cx2hxNVd+3dZusveM6AxLFfBLjVCcotVtxuGOjEa83cs0HG41HbiXmgtoNMR?=
 =?us-ascii?Q?VTmDubDDe8ix+09n42LsyNAl83NCcyZytvnA1tPk5XxsYNe+fqPTEEbEY9Bd?=
 =?us-ascii?Q?qa8e1Ogyjg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e9d814-2f82-4a4b-b5d9-08df0cb9e3f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 08:27:44.2805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tj4UYNBVaWQSgB4Uh7cYKIXlznqWncr8HAYsJGmMe1UoRjZoBPc2rcGsZ7/E677i1U4I3UdYxj0LVH2KlOw7v+rQcaiP1M8HqKl5CUqk6ys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17365

Hi Wolfram,

Thanks for the feedback.

> -----Original Message-----
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Sent: 03 September 2026 11:33
> Subject: Re: [PATCH v24 10/15] mmc: renesas_sdhi: Add write32_hook for CT=
L_SD_CARD_CLK_CTL register
> writes
>=20
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [High] tmio_mmc_host_probe() clears write16_hook when TMIO_MMC_HAS_ID=
LE_WAIT is not set, but fails to
> clear the newly added write32_hook.
> > --
> >
> > --- Patch [10]: [PATCH v24 10/15] mmc: renesas_sdhi: Add write32_hook
> > for CTL_SD_CARD_CLK_CTL register writes --- commit
> > 57d55ff6257b421b4e27c4306c5ee441c02c3087
> > Author: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > mmc: renesas_sdhi: Add write32_hook for CTL_SD_CARD_CLK_CTL register
> > writes
> >
> > This patch introduces a write32_hook for the Renesas SDHI driver to
> > wait for the SD bus to become idle before 32-bit writes to the
> > CTL_SD_CARD_CLK_CTL register. Writes are skipped if the hook returns
> > an error.
> >
> > > diff --git a/drivers/mmc/host/renesas_sdhi_core.c
> > > b/drivers/mmc/host/renesas_sdhi_core.c
> > > --- a/drivers/mmc/host/renesas_sdhi_core.c
> > > +++ b/drivers/mmc/host/renesas_sdhi_core.c
> >
> > [ ... ]
> >
> > > @@ -1203,6 +1211,7 @@ int renesas_sdhi_probe(struct platform_device *=
pdev,
> > >  	}
> > >
> > >  	host->write16_hook =3D renesas_sdhi_write16_hook;
> > > +	host->write32_hook =3D renesas_sdhi_write32_hook;
> >
> > [Severity: High]
> > Should write32_hook also be conditionally cleared in
> > tmio_mmc_host_probe() when TMIO_MMC_HAS_IDLE_WAIT is missing?
> >
> > Looking at drivers/mmc/host/tmio_mmc_core.c:tmio_mmc_host_probe(),
> > write16_hook is actively cleared for devices without this flag:
> >
> >         if (!(pdata->flags & TMIO_MMC_HAS_IDLE_WAIT))
> >                 _host->write16_hook =3D NULL;
> >
> > If write32_hook remains set on older or fallback configurations
> > lacking this flag, polling for TMIO_STAT_SCLKDIVEN will time out after =
1ms.
> >
> > The hook would then return -EBUSY, causing sd_ctrl_write32() to skip
> > the register write entirely, which ultimately fails SD controller initi=
alization.
>=20
> Please check this, too.

For safer side I will add, considering this code is used by other vendors
they may call sd_ctrl_write32() in future with no TMIO_MMC_HAS_IDLE_WAIT fl=
ag.
Currently all Renesas SoCs have this flag set.

if (!(pdata->flags & TMIO_MMC_HAS_IDLE_WAIT)) {
                _host->write16_hook =3D NULL;
                _host->write32_hook =3D NULL;
}

Cheers,
Biju
