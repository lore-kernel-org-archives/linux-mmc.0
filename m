Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010033.outbound.protection.outlook.com [52.101.228.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB58A37E5FF;
	Mon, 14 Sep 2026 10:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789382278; cv=fail; b=H2yxN+oYZMXAaXK0Ddyr2cjljTyPkmkKP6gGLf5voGd0s6GQ0ACtPOYRnfktfWppnAjc8PI8Hj+OlFoMdp6brTJWprIEWoOPT1QVQ12fMXGxTWa2Y0QE0SizecszUku3NZKGuTVpso36RjJZ23PXREzOIe47OZVGsbmmL72jXRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789382278; c=relaxed/simple;
	bh=rsNP8t5/QOz0YzgXSZrpP/YjClW9Ll3s5JEvJM3z7GI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RfxIriXM7WOkiCyKmLVtiLw8wxbfQDq8VHAw/YvQpsG8rt+BBAyWBjpssoWiS909lyAUM6v5t7tH3Lcyl0Qt+3pQ/nKlXtQ3jCQjLqDzL1QkwywE0tYTITrR3ufkkZoJbbHQb8UMbHVcew2ifFJ8QT96sJc7xcozgkr0+DEAhFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=WZQeVCJ2; arc=fail smtp.client-ip=52.101.228.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="WZQeVCJ2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wH/HPENWYOWZ6BJkkCqqqp1aVvEdPXdWTfSndUOX0M6xp0o/s6ED3cLJI90ScslgLJXGKcFkPL/X2vNDxDwgbKP55bETvsWgRUZ50ijZm459Pp8gNx6vH1wMXIe0CFHYW4f/09W279hrnzvqhr5v02IqM5j57lHuCYTOdMMAnehF5xpGgGqy8FCjRNuGLzL9FFT9U7sTOsdBIxmTQR7EBKjfnSQjr/LmVNyoirWzXrvb2/uQrWAqRpwXcKKDtGJzDTXmhIC+Rf9hdzQZs9ySHBGe3Cbim7SDjbqqKBQbf22KYcTzGdd3Y7c/3c84grfHfw+ixPevjCQVODYc3Ig3NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsNP8t5/QOz0YzgXSZrpP/YjClW9Ll3s5JEvJM3z7GI=;
 b=e5zQO7W4sMLpEmYp5APxLjqbsIYs1U1lkSq/7jdc+FgyHQyR/VSfDT+CHfbgJ2zPPd4iFMetBvl4Ky2E5sAQ51BNbpvylt6d1B2RnmNfSu34/M5q4TamzwTpCRThyWVLGvpTreVizk6hWPhJ6jHOm2m1mAYZdy27/45lFjzDIMViOAtZBsM9vk/AEBrdE16CiVowKIUoRA+BjtRUYtgmzYHEgWynfXCntJvERib3NH6VFvs9wP8016D+biM/8Gq61He8w+foGqHthzE4vWqvv5WvinhnSosZ3dDcUtIy7EAgC3Z8ivvigG/KMsPO9LIYwzXqgh3x6Vcn/hPiHuQjcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsNP8t5/QOz0YzgXSZrpP/YjClW9Ll3s5JEvJM3z7GI=;
 b=WZQeVCJ2nCr6Sq/DE+IF65SjLgkwt44BBigbpoHC9tK3FBPkz8qtckh1s1vVzS0NfdkExQCELW0x33zJopt6UbLZ8tR4RI9pa7RNX3wclrsa/SPbqBCqO4jDyt8iOjYnZH+SFX5gOpH8n+hxCuiVPT8Hx42zorXpOX8A894lJQg=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB14306.jpnprd01.prod.outlook.com (2603:1096:604:361::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 10:37:51 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 10:37:48 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: wsa+renesas <wsa+renesas@sang-engineering.com>
CC: "biju.das.au" <biju.das.au@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v24 07/15] mmc: renesas_sdhi: Add tuning delay support for
 RZ/G2L
Thread-Topic: [PATCH v24 07/15] mmc: renesas_sdhi: Add tuning delay support
 for RZ/G2L
Thread-Index: AQHdMMe9/TEErDJ1NE2Te++xaon3+La8rB0AgAHjRRCADl72AIABGVww
Date: Mon, 14 Sep 2026 10:37:48 +0000
Message-ID:
 <TY3PR01MB113466D19C9709220E79A2DED86BB2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-8-biju.das.jz@bp.renesas.com>
 <apk-J8is9MNm7I2R@shikoro>
 <TY3PR01MB113460485B6D3FD62D027C2AA86B52@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <aqbhsQTKkGfLsEXX@ninjato>
In-Reply-To: <aqbhsQTKkGfLsEXX@ninjato>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB14306:EE_
x-ms-office365-filtering-correlation-id: 74db0357-beca-4885-4256-08df124c38c3
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|4143699003|22082099003|18002099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info:
 aYzKTr6mZFpx+ygPb8x3/iwfizbbDNbu+bpzdfEAPbg801Z3WoRRA4/TDcXpt7mUKjuysObQg0udUezySgwXEhmRLf3yo7WaJgsrIGJ58KojbwFgnqM0dkgGkj/IaqJXeQHbx+NQdVBOMfjBFtvXEetZZz81pfjcYNF+dtXqkt+CbDE460NXpl1kvnYXj+Yma8JoT9PqoUfZMhgue4NIGEXJ8CU3WbjTdH2MpmYFfepZyT8kDWPP2TriPzH7VflLg/OxledlwScwNV5IsdtO2aaRKPAPh65cIW/ecMIfqL70z1YPq4mwH7J7noNELMmO7ySHV9QGLW/hRMkBNuB/4VothcQLwx4Sfj8dlasrs5qG6YvJhmsnokZfr2hwGY+tTNOCYy09FISd1InVfzpoXdMLEhS4CTpP7JYUVXhZ+Uz0WKu3DzpcnPkhBEGSmBeQ6urrT+if9QWLoSEc0k2VmjMedK83umN2UEc8qG+G8OYB1SUJLnmfQ/1Gi9J5M5FI4hxLr/PULZBPBW2ZqCHPz+xVm0UhwK1aqaPnFMCzsyXFVyc3WjdF+svCl5xlnWknrJx0WN8Iin+P3eyUbndVW/cns6sNmaXGBdKe91J94JJwjr+kHpe1ljKLUhVIG/+dnZS15LY+mf0xaTWP/kduKOwe6kslfTkLcr/i7UhiyEVp14kjBiGKwPq/p2vuaTDCO079C0kPjQy6EM5rJyh/vkuKXzbQ3pUzOZVxVxTGaHo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(4143699003)(22082099003)(18002099003)(56012099006)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qgh4pv/WWskRC7Ykhfxpk5fIZmx3IPb8Tr3MNC3y17yIl8QQXe3u8U+pvREf?=
 =?us-ascii?Q?HQMzXJqwVJ99oe8kHP2Bu/zaf3MikAZ6q33BwPxyM453OskXo7UJR32nizMf?=
 =?us-ascii?Q?sIvgX4SCzl6qWeakYHaByqiEfxlB4AWOP2gaTAwht6CfFEihpa7j5KuWtzmA?=
 =?us-ascii?Q?27zuGjC1uB4uCEJjS5IM4c2AYJNW/msUA0ZfxiNxBkI4fuz15WKrbom55ttb?=
 =?us-ascii?Q?rCi83W8lykm0zppae6Ef30F8XGzL3Tb1HkDefX7CW/toXsD9xWRgWh7pkmgQ?=
 =?us-ascii?Q?LCYQVVvnpfFRmRrviJ15ltFcrJpU29+7sJ5bEyqRtyiS5e2zoZI3TT4SK3Ah?=
 =?us-ascii?Q?I1DHrVyoI5S/qUvZ9Thz76xPtTiR0mGryPdxKUEtV8rfbFuoQeqopBZwuISo?=
 =?us-ascii?Q?GP9yRwiVLxQ3Tp4Cr23epow/0zfV2lFf3LtmfkAMHpCUdbaf3urmb94BigDM?=
 =?us-ascii?Q?WjgNAqcDwFtNa1jbfEj60dUoObyT4ceO7vW3kX7YjVUdy8gAwU95ofDbsdiN?=
 =?us-ascii?Q?LaRd3wOSIBX5RsOe41+Xm4EQdl5tp71Dj6GpeRILPHziayjge4OeKshTMIZN?=
 =?us-ascii?Q?JgR3QAx6mH/Oc0rl9I0VSruuf02PEmrBc1NVk3BDNMTDXesQpcIaU6ahUeIi?=
 =?us-ascii?Q?y1Lvi2JhzXaiU7Gp9QpDPZHyObgEWQKfqHIlXTYtB5TM0B9X2V5cVp4QLzm2?=
 =?us-ascii?Q?UftkWd0Ip4PKlLsmRNNynmUw/JK5eqX+qYUMfWhB34wpOCIsFfGW0MsfaYDm?=
 =?us-ascii?Q?6u2Xx0SBLlC32DQbI9Z89p+k2g2pYnRyUMcabJpyHEwjVu6j6V9cE7xk1gkl?=
 =?us-ascii?Q?loVxVlKH29XRXVSDEHYRFjCIzhM8mdjEb8fELmEJ7yGTJN+mLC+VUH3CRAhY?=
 =?us-ascii?Q?OEmkVTWyBp2NeJGvSPuQ0pFVtccyAb9C486AmQJZrKfkq58Z122CoO/mxGjG?=
 =?us-ascii?Q?SdzyZfLpl8FaF1F9YLfZl4g0VVTBXdjchbgBl5AtJbSro46yeJgILpp3Ews1?=
 =?us-ascii?Q?9iHRqtuZNECWXh1lIfYAnIuhQP4EPu4JvUV1cS7ojd8oGW5Rj9s5p40I2Ogn?=
 =?us-ascii?Q?Ayv82vSitzflVls1Tgz7ZRRqZBd0KbCDYbIU4GdJadmgfvkZ66IpqvbrU9CC?=
 =?us-ascii?Q?v+Zfe1EQtxInScvqDP9DgbDDqjlFQzo/zmGjnipFvCfakPfEjqXNAaVdc5NC?=
 =?us-ascii?Q?MUYSGoDp6UHAnbdnaVbee+vZ/oWGX6fWkx3APV7Aq6TzPFqBsHWSpLIAUoXx?=
 =?us-ascii?Q?AApKdjgjHBCtBaZ2lMgUcF71bSJYerrbbgOIwxgaN41S+AD5TNcDKH349SXw?=
 =?us-ascii?Q?DZjVnKzCrjgZ/thYjSio6A52SfQ+vokQxcUYslvD2RtpRrVoplFQnAWbP1h5?=
 =?us-ascii?Q?+cD+2xgc0LqCmK1QM0VBYbySO+j3P/DDXejWToJqJb5w0wlojJK/8Cz6d5bD?=
 =?us-ascii?Q?dg7qEbD1CYUPs+tSEIZFTrW9DKNgldow4nMQJuUYv9q9/6ZIsm+X/B9uKbtA?=
 =?us-ascii?Q?fZyaRG0lRxwtszlRrujQfQcTuxM49BssvoNhV649N6US79wCqwNWFgUbMRdp?=
 =?us-ascii?Q?BMpv0bE5NDH2HOyUnb+XsvT4BefPVb1j6T6kNt7LE/j6EWNYBZQMXJVksoEp?=
 =?us-ascii?Q?6iI5zkqg2/Qw2gdcN7bFPuh6Ss9DPVF49LPnA1aTVRkvyvU47mK0G7HOidnl?=
 =?us-ascii?Q?hWjgbIirYwsB22kXg346qDAZJhbTQnaMt02wx2M8b1QUQ5/9sgzaaAqCGwxU?=
 =?us-ascii?Q?fj+DqNC5vA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 74db0357-beca-4885-4256-08df124c38c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 10:37:48.8880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hn8ID3NhSgXXv8A92idJp3GZxDTf+ze3nNHVCLgxdbTBB+zPLURE+Smo+RnRVzq7bvP0t3FaiU5rT1yin0P0Ju7i02V/dTpdL7csXUoWNW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14306

Hi Wolfram,

Thanks for the feedback.

> -----Original Message-----
> From: wsa+renesas <wsa+renesas@sang-engineering.com>
> Sent: 13 September 2026 18:48
> Subject: Re: [PATCH v24 07/15] mmc: renesas_sdhi: Add tuning delay suppor=
t for RZ/G2L
>=20
> Hi Biju,
>=20
> > > > If an incorrect device tree binding or a hardware fault causes the
> > > > controller to report a version older than SDHI_VER_GEN2_SDR104,
> > > > priv->scc_ctl might not be mapped during probe.
> >
> > I agree if there is a memory corruption, any check can lead to
> > Unpredictable result.
>=20
> I was more worried about the incorrect DT binding than the memory corrupt=
ion.
>=20
> > > I agree. We should ensure in probe() that either
> > >
> > > a) TMIO_MMC_TUNING_DELAY has a valid SCC or bail out otherwise
> > >
> > > or
> > >
> > > b) clear the TMIO_MMC_TUNING_DELAY flag if there is no SCC present
> > >
> > > What do you think?
> >
> > I agree, we can add defensive check in probe().
> >
> > TBH, I am not convinced with Sashiko report here, but please recheck
> > my comments and provide feedback
>=20
> Well... your statements make sense with the current state of the driver.
> However, there is de-facto a new requirement added that TMIO_MMC_TUNING_D=
ELAY needs an SCC. This is
> currently handled correctly, but since it is not addressed explicitly, I =
would consider it a little
> fragile. SDHI is complex and I am worried that some future logic changes =
might break the logic chain you
> quoted above. This is why I think an explicit check makes sense - it cann=
ot break and it makes logic more
> obvious for future hackers.
>=20
> Can you agree?

Yes, I agree

Cheers,
Biju

