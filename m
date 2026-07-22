Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011018.outbound.protection.outlook.com [52.101.125.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E405142A144;
	Wed, 22 Jul 2026 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784751216; cv=fail; b=LCQEUgbI/JdGI3Z74ngmfWgf0YysD5aUIy+LDj+OWagM7D929u6GCubj3wBgZKONs5BREfqbhKgckNEuHBoy8pYEXuPF/lPgIGfXE6FPxgNkzRj+QfJWhSXkYfW9DLMdgXFXUQ+7IHdT9h6T0fdSbEDBju6uMwK/oooP8TTIuP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784751216; c=relaxed/simple;
	bh=WH7UtMA59B1aA89gA8DQrZ8/qoaaj9vBh5N3fyfMt1o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CXtBHJfA6ws77Y+cs8X4xpXAU5w/kgRoAvYQ2tq30QGPukN/Y9KUdpnVtXBC6gFEUFvZcyIBG/kRkEhREgQL7oiyMHFqhq/ANnyEm1U1BkLEhz+v/2q48E6ksKid4QoR93oBl+Vv6kW3F4rCd2Rle56wIM2Lgi57Wg5UguMQJXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=VZktKtcC; arc=fail smtp.client-ip=52.101.125.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="VZktKtcC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFSfSLI9Ho/c/iXniZkWMIUVDG00pODbpYop8Ovw7HhsPmzSCTCpls7yW3Bc2Z2TOWyDSL1WX+fdvM/WGXlG2JUpCFld6XoVzPMEa2V5XTv5PUl2lJqsG6Uu/m2vnMREGsumV0YXqGsKi/hzLXFU/y90ROjHceECOO7TjVOFBesoi+9SrLizbBAapwYQE1TNAxmO6Toq4R4MkNetItoPZUg76XhRN+bkq3X04JPBZ5RFW1GztKFb/MDriDDOw764xPPYdpLQ5kLBjhPrLnfSYtgZTJFfWqJnMBEw+98MwgRgbGPz9UqSxYXbxOGqx1W5oOF3tpW2cxgUt63TNQAPyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYOxNu/R34rh6mh6AnmRcOt0kTiTvSXCpP7xeuRF6Fo=;
 b=LebYw4CE5i+6VBzLaPIkrq0MpLt1srK7UJCgUvJbej1QCv4lfrY8LvEwyKAYJaiH8DQ54J17Td/jPf4d9oL2VPNzNKDcdoozKnjHH2sdIqU5C7vSUBzeDo/4LCRXeHhMp28NfTl49QiQO4O6jV4iGHmkPdIehuJd75hYoJ5PKJpTketWr5leTvWNGu3sV59KltjdCAuWVp+RQpE7MCKVwYvQwbfe3jmHpCjY0m3wXFPUypN7yAbNA067AeeDC99aw1zsqe26GbWgaxq60dogHjVInjHRK2RmCSASvWN7EcqHR62Jl8X/JLwTH6DXU8K1aZGKQlDF4Z0SMKT9Rwa/Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYOxNu/R34rh6mh6AnmRcOt0kTiTvSXCpP7xeuRF6Fo=;
 b=VZktKtcCe3A0FjJyqEEup9YXJ3bbsTAstqUsCn67XbtMJEueWshiaDjRx7w7zhxtZ2mC6kTSvc9+n3/NyPhJOsrxdNrtUJ1rltkkFD0pviOeCSa2xpcJiV1uK8WcaLe7lNrBYd/9RnZyFWjFEsWssxXd1BmY8rz31w4laV8y9N0=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB12987.jpnprd01.prod.outlook.com (2603:1096:405:1c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 20:13:31 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 20:13:31 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: biju.das.au <biju.das.au@gmail.com>, Ulf Hansson <ulfh@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Philipp Zabel <p.zabel@pengutronix.de>, magnus.damm <magnus.damm@gmail.com>
CC: wsa+renesas <wsa+renesas@sang-engineering.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>
Subject: RE: [PATCH v21 00/12] Add Renesas RZ/G3L SD/eMMC support
Thread-Topic: [PATCH v21 00/12] Add Renesas RZ/G3L SD/eMMC support
Thread-Index: AQHdFrrDf5FauNJCNECAUdMxrTo0ObZ5/tDw
Date: Wed, 22 Jul 2026 20:13:30 +0000
Message-ID:
 <TY3PR01MB11346334F06B1B5B9E5D471FE86C12@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260718133838.152905-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260718133838.152905-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB12987:EE_
x-ms-office365-filtering-correlation-id: cae1ac38-b6c1-4d16-0a68-08dee82db31d
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|38070700021|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 D1mamXtL/vYSeAUNT1p0j25BuKFz8zNkbIz/j8KlVch622kpXCLRVsVdOP7opfBWY5QHoXBh/Xsm0pzklgNjPYiBM8LfEEBN/GF4I2VITGHjC8OEcuiL3bcBjYKdLP43Ag4VbPgsUkH6LN+wziKZS1U7HwYavJ8apPAcvCI4On6FGKt9gkb7PTJWSou8YtrJ3LGPiDXP231H8RYdVBfpXe8/Oovbe5paLmLMtVQPs6NDPpZl6lSMZKgg/N/QUSESFo8xjN/GQmnlcUHYPGH4y2dHx30mgBjiYZixJKt49DcSXx1kOz6ahPAfYDfSGL1+nQuKTrDw0+T5N2Cu+YepJs6qi4zGdgzJJ4z0LFbDd7doSenAuqIqxs2J56nubUxbOuSfASucg5o6tjbNr7sh8TZOFg4gKXM7xxLe1z7Zs38ci6kTfc63wXVs8jL8ra94KAbYHsOQpaUganq8jkd66WmTu6hsX22YyDKrpmfAvaGxgPB1xIeYKzV2yAIbcxWngJc8wqCeC4M5wkNzj9H7IIDvbyrBsDVqJDoU6Sf7z5AZgkiBFf1+++GhJkIW/e0rHAzsYk86kQNHnc7nl/bl+GEORG00iGtQnGX0c3nepkqufo2c+qmwIfbM198qhmb3Ve97BAsmzmiUcSdioadKJlzpXT987vzO4vEmOrozMWQk0oWQYlY46MpUiyhzBxBrQjXE2ZlzerDYDZtkaPTlPD+uu/Bafv5EavDxUowLBk8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(38070700021)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7pkHuYGTWz/Ux/JLJpcasbWFhV8jDlNMiK96HBpvqBQbRouMXm8WzhjAA3cn?=
 =?us-ascii?Q?Bdd1NiprHJ5JW9q5HQEplp3woPUArkVITytK6dPSQQA/bIbqh/CSAQT2Fnja?=
 =?us-ascii?Q?jWlU+sI2TUMRymxsNmNrczIoxSJ9oYamQrE15vU/OWHo3ZWED+aAfIOJVwOI?=
 =?us-ascii?Q?yVV/oGxKTAntEJ6YnEvsV7Hp8X/cZ2Z8p9zMfdCZ2g3jUtGWUfYqUVSeSBqD?=
 =?us-ascii?Q?q6htNEpAe0XRmPzKo5UIQexloeWTc4T0SA3xqrh5jec2iURjj3MQhxbe5ZkE?=
 =?us-ascii?Q?g+LZjILANl6jukoRae5wPUV2ROzoYzhtZKoq9myCTfG1JhYifZD5sPK3paDD?=
 =?us-ascii?Q?ABYuA6S0BadGZezIGKnyP9WivGV7hp70qND2M8OtBvdExrrvrw2JdaCYO5KV?=
 =?us-ascii?Q?QJJRacGc0uAFsKzp2JqgEb3kCsylGJ4RBcbkBxh9u0n2d5Nd871lM9Tugx5G?=
 =?us-ascii?Q?DkkCemygrsKLieJFHVuqItF3NyYH8jC5JI7jn2wf2An7Lxz5idW9T19AEWOv?=
 =?us-ascii?Q?yzdZAQorXbORPGcL4kikX83A7A/bC68V9LCgzn0J25z3ZTIn2I+Na5tDIKLK?=
 =?us-ascii?Q?v7aIRF2FJgMN3YSQb7cAxIPc8/z6uVq+EAYGFj9P1UGStYvg4A/Avyme6g2g?=
 =?us-ascii?Q?OcmwMBqvaIUyBRaEhnOmEquQ+CZ3rFNouAN784xCpwtO8ehyK12L+kaSlM3V?=
 =?us-ascii?Q?3WjrFkwCT9yh4Gobeyi/EL7iDFe3I4gjE5e2vHJGDzURxVbsWt01oXkGwhYd?=
 =?us-ascii?Q?/K/I+3by+DZam4ROp+YNhSWePm28dR24Q49u32H+bdpKReoF2pAm+dbAIJIs?=
 =?us-ascii?Q?ersBSEfGu3Q6KuKM9CLcRqESIoAj6i9GQYBIFIREGgZgKCJ1dMxvwgYJ8ceW?=
 =?us-ascii?Q?Csf6vRt2erNI0cYECSyeKZu45bXL/hyAIykXDNgDdbKQZXCsz2zIoziYmzHM?=
 =?us-ascii?Q?e74oWSFKQsz+L02g+ZrAONNL11JF6ihhKcudSarKI5erV+7s5mQ4eZ2G28it?=
 =?us-ascii?Q?71HgtiZ8vVFKPCxiY+0h/vwni9sQK13XfOFrWYbJpbHBQ4i4sZ/h+124IZ16?=
 =?us-ascii?Q?NdPSc/mfvL/Soj849N4Vsliz31/fwv9k1Iudqbj9Dd+ksq3DIN+tEY/SwuLZ?=
 =?us-ascii?Q?NnorOdKEwDPJvOqiRvs8bN/ZmOqmaOUgOJLzgIfRSxWpWB9UMES2sRycJHPw?=
 =?us-ascii?Q?GO5ARg6mjQc3LLVimmF0Z5lQh/0fwO3ZipyHLleySbSSbcOORjUoLrsZDh3P?=
 =?us-ascii?Q?2dk5Lm6ZniSAxH1oS6RSFZjot4ftMWXq13TNP9nRlbwnz6/HuD0JsjS6vB5j?=
 =?us-ascii?Q?R/MIYulA1Pv+mZkV1jhSwPUJz5UFE27Njre7mNFOwawQeozACbrU0yi4+c5A?=
 =?us-ascii?Q?4MioiFJ5witt9Dyh1wi+q108FJtPXGkRT3unFrCMk43Ws9tUsiajEHcD57T3?=
 =?us-ascii?Q?/X23hSFkfGKX8+CDucsyFkTlux3CnP45mMPL3G4tt5mHIwQP0lo3x/Sw4pXa?=
 =?us-ascii?Q?Tc4CzDWzQsY27CoPHKxzBapir1JFJvKP6mRBPdIXwSPt9VY2j0yp8C4QaiBQ?=
 =?us-ascii?Q?eaRFLfT90iQlSal130sglxL2s4IgGKKMsMIEW4LSlO8w58zXVks9gGrPPvbK?=
 =?us-ascii?Q?xgLJnqWPh7YL1ytAVANHiFw2eR7wfEHmU7rYVzPvm4zl40NKwy85AgmjckWN?=
 =?us-ascii?Q?6TZDh7fwXjp8Lw8HCHfm4PNu6hSkR9NZ5M6+nU+OL32CIMjMVxsw+oigdHcC?=
 =?us-ascii?Q?qlNeFnxsKw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cae1ac38-b6c1-4d16-0a68-08dee82db31d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 20:13:30.9181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SxCUSu/sWqsS6nfXyf+sP2EIjaGu22a8G1rR2o8DWGOfwye7Mphman25gpxcWBLTagciWjdTI/E67VnqwJjfKFy1XTWkVolQoolFGVymzE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12987

Hi All,

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 18 July 2026 14:38
> Subject: [PATCH v21 00/12] Add Renesas RZ/G3L SD/eMMC support
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Hi All,
>=20
> RZ/G3L SoC has:
>=20
> Channel 0 supports SD and eMMC (including HS400/HS400ES).
> Channel 1 supports SD and eMMC (except for HS400).
> Channel 2 supports SD.
>=20
> The SoC supports a maximum frequency of 150 MHz. The SD0 interface does n=
ot support IOVS and PWEN in the
> SDHI register (no internal regulator), unlike SD1 and SD2. It has an inte=
rnal divider for all modes
> except HS400.
> It also has a 2048-bit divider compared to 512 on others. Moreover RZ/G3L=
 supports HS400 enhanced strobe
> mode.
>=20
> This patch series support all Modes except HS400 ES mode.
> Please see the test logs[1]
>=20
> v20->v21:
>  * Dropped HS400 ES support due to file system corruption, will add this
>    mode later after investigation.

Found the root cause of the corruption. PM resume resets HS400ES related
registers leading to inode corruption after mounting rootfs on eMMC.

I will be sending v22 with this fix soon.

Cheers,
Biju

>  * Added support for make clock divider mask configurable
>  * Added clk_div_mask to RZ/G2L of_data.
>  * Added clk_div_mask to RZ/G3L of_data.
>  * Restored actual_clk calculation in renesas_sdhi_set_clock().
>  * Updated renesas_sdhi_set_clock() for RZ/G3L HS400 clock handling as
>    it supports only single clk divider value and other values are
>    prohibited.
>  * Updated commit description for patch#12.
> v19->v20:
>  * Replaced the check mmd->clk_mask with mmc_data->clk_mask and moved
>    the code after assignment of variable mmd, this ensures assigning
>    the default values for non-DT platforms and DT platforms with no
>    device data.
>  * Replaced the check mmd->max_divider with mmc_data->max_divider and
>    moved the code after assignment of variable mmd, this ensures
>    assigning the default values for non-DT platforms and DT platforms wit=
h
>    no device data.
>  * Fixed the ordering of resets in suspend/resume paths.
>  * Added bitfield.h header file.
>  * Reworked on renesas_sdhi_set_clock() to handle the 11-bit divider
>    case and the 32-bit register write.
>  * Updated resume() with scoped PM runtime call.
>  * SD_CLK_CTRL clk enable turned off before updating SCC_CKSEL_DTSEL
>    register.
> v18->v19:
>  * Updated commit description for patch#1,#2,#6,#8,#11 and #12
>  * Updated clock and reset description with AXI master and AXI slave
>  * Added else condition for reset and reset-names.
>  * Renamed aclk->aclkm and reordered the axi clocks similar to resets.
>  * Retained the tag got binding patch as the changes are trivial.
>  * Fixed the clk_mask for non-DT platforms.
>  * Fixed max-divider setting for non-DT platforms.
>  * Replaced the magic number '9' with ilog2 function in
>    renesas_sdhi_clk_enable().
>  * Dropped divider variable from struct renesas_sdhi.
>  * Updated renesas_sdhi_clk_update() to return rate for HS400 mode
>    and non HS400 mode(uses 1/2 internal divider).
>  * Updated handling for clk divider.
>  * Renamed TMIO_MMC_HWADJ2->TMIO_MMC_HWADJ to make it generic for
>    hardware tuning delays
>  * Dropped duplicate SH_MOBILE_SDHI_SCC_TMPPORT2 macro
>  * Updated suspend/resume with scoped runtime calls in suspend.
>  * Fixed extra space in HS400MODE2 comment block.
>  * Updated the comment HS400mode2->HS400MODE2.
>  * Dropped the updation of clk handling as it is taken care in
>    previous patches.
>  * HS400ES support is enabled based on of_data.
>  * Fixed the space in HS400ES comment block.
>=20
> v17->v18:
>  * Collected tag
>  * Merged patch #4 and #5 and updated commit description
>  * Annotated the empty sentinel entries in the OF match tables with a
>    "Sentinel." comment for clarity.
>  * Retained the tag as it is a trivial cleanup.
>  * New patches drop struct renesas_sdhi_hw_info, instead using
>    renesas_sdhi_of_data and tmio_mmc_data.
>  * Dropped clk, pinctrl, SoC, and board dtsi from this patch series;
>    will send later.
> v1->v17:
>  * Collected tag for binding patch.
>  * Resending the series as there is an issue with patch threading from
>    patch #14.
>=20
> [1]:
> Logs:
> root@smarc-rzg3l:~# dmesg | grep mmc
> [    0.000000] Kernel command line: rw rootwait earlycon root=3D/dev/mmcb=
lk0p2 net.ifnames=3D0
> [    1.954120] renesas_sdhi_internal_dmac 11c10000.mmc: mmc1 base at 0x00=
00000011c10000, max clock rate
> 150 MHz
> [    1.967729] renesas_sdhi_internal_dmac 11c00000.mmc: mmc0 base at 0x00=
00000011c00000, max clock rate
> 150 MHz
> [    1.978997] Waiting for root device /dev/mmcblk0p2...
> [    2.066736] mmc0: new HS400 MMC card at address 0001
> [    2.077061] mmcblk0: mmc0:0001 0IM20F 59.3 GiB
> [    2.095408]  mmcblk0: p1 p2
> [    2.098917] mmcblk0boot0: mmc0:0001 0IM20F 31.5 MiB
> [    2.106696] mmcblk0boot1: mmc0:0001 0IM20F 31.5 MiB
> [    2.113966] mmcblk0rpmb: mmc0:0001 0IM20F 4.00 MiB, chardev (510:0)
> [    2.228334] EXT4-fs (mmcblk0p2): mounted filesystem d267a6b0-3e0c-48b1=
-865c-8801ab27f2c2 r/w with
> ordered data mode. Quota mode: none.
> [    2.483088] mmc1: new UHS-I speed SDR104 SDXC card at address 5048
> [    2.496361] mmcblk1: mmc1:5048 SN64G 59.5 GiB
> [    2.504683]  mmcblk1: p1 p2
> [    4.455604] EXT4-fs (mmcblk0p2): re-mounted d267a6b0-3e0c-48b1-865c-88=
01ab27f2c2.
>=20
> root@smarc-rzg3l:~# cat /sys/kernel/debug/mmc*/ios
> clock:          150000000 Hz
> actual clock:   150000000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      3 (8 bits)
> timing spec:    10 (mmc HS400)
> signal voltage: 1 (1.80 V)
> driver type:    1 (driver type A)
> clock:          150000000 Hz
> actual clock:   150000000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      2 (4 bits)
> timing spec:    6 (sd uhs SDR104)
> signal voltage: 1 (1.80 V)
> driver type:    0 (driver type B)
>=20
> root@smarc-rzg3l:~# echo "test" > /1.txt root@smarc-rzg3l:~# mount -t aut=
o /dev/mmcblk1p1 /media/
> [  287.682702] EXT4-fs (mmcblk1p1): mounted filesystem 6fb3211d-4e8e-4ab0=
-b0ab-e0d2451b9b98 r/w with
> ordered data mode. Quota mode: none.
> root@smarc-rzg3l:~# echo "media" > /media/1.text root@smarc-rzg3l:~# cat =
/media/1.text media
>=20
> s2ram:
> root@smarc-rzg3l:~# echo mem > /sys/power/state [  333.723778] PM: suspen=
d entry (deep) [  333.743368]
> Filesystems sync: 0.015 seconds [  333.754880] Freezing user space proces=
ses [  333.762770] Freezing user
> space processes completed (elapsed 0.003 seconds) [  333.769795] OOM kill=
er disabled.
> [  333.773021] Freezing remaining freezable tasks [  333.778915] Freezing=
 remaining freezable tasks
> completed (elapsed 0.001 seconds) [  333.786358] printk: Suspending conso=
le(s) (use no_console_suspend to
> debug)
> NOTICE:  BL2: v2.10.5(release):2.10.5/rzg3l_1.0.1_rc2
> NOTICE:  BL2: Built : 11:18:41, Jul 15 2026
> INFO:    BL2: Doing platform setup
> INFO:    Configuring TrustZone Controller
> INFO:    Total 3 regions set.
> INFO:    Configuring TrustZone Controller
> INFO:    Total 1 regions set.
> INFO:    Configuring TrustZone Controller
> INFO:    Total 1 regions set.
> INFO:    eMMC boot from partition 1
> INFO:    Loading image id=3D39 at address 0x44428
> INFO:    emmcdrv_block_len: len: 0x00001000
> INFO:    Load dst=3D0x44428 src=3D(p:1)0x260000(4864) len=3D0x1000(8)
> INFO:    Image id=3D39 loaded: 0x44428 - 0x45428
> INFO:    DDR: Retention Exit (Rev. 02.05)
> NOTICE:  BL2: SYS_LSI_MODE: 0x12051
> NOTICE:  BL2: SYS_LSI_DEVID: 0x87d9447
> INFO:    BL2: Skip loading image id 3
> INFO:    BL2: Skip loading image id 5
> NOTICE:  BL2: Booting BL31
> INFO:    Entry point address =3D 0x44000000
> INFO:    SPSR =3D 0x3cd
> [  333.827014] renesas-gbeth 11c30000.ethernet eth0: Link is Down [  333.=
830869] Disabling non-boot
> CPUs ...
> [  333.833195] psci: CPU3 killed (polled 0 ms) [  333.837072] psci: CPU2 =
killed (polled 0 ms)
> [  333.840622] psci: CPU1 killed (polled 0 ms) [  333.842113] Enabling no=
n-boot CPUs ...
> [  333.842381] Detected VIPT I-cache on CPU1 [  333.842438] GICv3: CPU1: =
found redistributor 100 region
> 0:0x0000000012460000 [  333.842484] CPU1: Booted secondary processor 0x00=
00000100 [0x412fd050]
> [  333.843494] CPU1 is up [  333.843644] Detected VIPT I-cache on CPU2 [ =
 333.843678] GICv3: CPU2: found
> redistributor 200 region 0:0x0000000012480000 [  333.843708] CPU2: Booted=
 secondary processor
> 0x0000000200 [0x412fd050] [  333.844560] CPU2 is up [  333.844714] Detect=
ed VIPT I-cache on CPU3
> [  333.844750] GICv3: CPU3: found redistributor 300 region 0:0x0000000012=
4a0000 [  333.844781] CPU3:
> Booted secondary processor 0x0000000300 [0x412fd050] [  333.845804] CPU3 =
is up [  333.873259] dwmac4:
> Master AXI performs fixed burst length [  333.873305] renesas-gbeth 11c30=
000.ethernet eth0: No Safety
> Features support found [  333.873349] renesas-gbeth 11c30000.ethernet eth=
0: IEEE 1588-2008 Advanced
> Timestamp supported [  333.875449] renesas-gbeth 11c30000.ethernet eth0: =
configuring for phy/rgmii-id
> link mode [  333.892271] dwmac4: Master AXI performs fixed burst length [=
  333.892300] renesas-gbeth
> 11c40000.ethernet eth1: No Safety Features support found [  333.892329] r=
enesas-gbeth 11c40000.ethernet
> eth1: IEEE 1588-2008 Advanced Timestamp supported [  333.894274] renesas-=
gbeth 11c40000.ethernet eth1:
> configuring for phy/rgmii-id link mode [  334.066618] OOM killer enabled.
> [  334.069768] Restarting tasks: Starting [  334.075337] Restarting tasks=
: Done [  334.079175] random:
> crng reseeded on system resumption [  334.084885] PM: suspend exit root@s=
marc-rzg3l:~# [  336.680010]
> renesas-gbeth 11c30000.ethernet eth0: Link is Up - 1Gbps/Full - flow cont=
rol rx/tx
>=20
> root@smarc-rzg3l:~# cat /1.txt
> test
> root@smarc-rzg3l:~# cat /media/1.text
> media
> root@smarc-rzg3l:~# cat /sys/kernel/debug/mmc*/ios
> clock:          150000000 Hz
> actual clock:   150000000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      3 (8 bits)
> timing spec:    10 (mmc HS400)
> signal voltage: 1 (1.80 V)
> driver type:    1 (driver type A)
> clock:          150000000 Hz
> actual clock:   150000000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      2 (4 bits)
> timing spec:    6 (sd uhs SDR104)
> signal voltage: 1 (1.80 V)
> driver type:    0 (driver type B)
> root@smarc-rzg3l:~#
>=20
> s2idle:
> root@smarc-rzg3l:~# echo freeze > /sys/power/state [  450.999169] PM: sus=
pend entry (s2idle)
> [  451.017350] Filesystems sync: 0.013 seconds [  451.024258] Freezing us=
er space processes
> [  451.028222] Freezing user space processes completed (elapsed 0.003 sec=
onds) [  451.037188] OOM killer
> disabled.
> [  451.040460] Freezing remaining freezable tasks [  451.046419] Freezing=
 remaining freezable tasks
> completed (elapsed 0.001 seconds) [  451.053881] printk: Suspending conso=
le(s) (use no_console_suspend to
> debug) [  451.095285] renesas-gbeth 11c30000.ethernet eth0: Link is Down =
[  453.419781] dwmac4: Master
> AXI performs fixed burst length [  453.419827] renesas-gbeth 11c30000.eth=
ernet eth0: No Safety Features
> support found [  453.419869] renesas-gbeth 11c30000.ethernet eth0: IEEE 1=
588-2008 Advanced Timestamp
> supported [  453.420959] renesas-gbeth 11c30000.ethernet eth0: configurin=
g for phy/rgmii-id link mode
> [  453.437889] dwmac4: Master AXI performs fixed burst length [  453.4379=
21] renesas-gbeth
> 11c40000.ethernet eth1: No Safety Features support found [  453.437952] r=
enesas-gbeth 11c40000.ethernet
> eth1: IEEE 1588-2008 Advanced Timestamp supported [  453.439032] renesas-=
gbeth 11c40000.ethernet eth1:
> configuring for phy/rgmii-id link mode [  453.531484] OOM killer enabled.
> [  453.534640] Restarting tasks: Starting [  453.539474] Restarting tasks=
: Done [  453.543086] random:
> crng reseeded on system resumption [  453.548410] PM: suspend exit root@s=
marc-rzg3l:~# [  455.991868]
> renesas-gbeth 11c30000.ethernet eth0: Link is Up - 1Gbps/Full - flow cont=
rol rx/tx
>=20
> root@smarc-rzg3l:~# cat /1.txt
> test
> root@smarc-rzg3l:~# cat /media/1.text
> media
> root@smarc-rzg3l:~# cat /sys/kernel/debug/mmc*/ios
> clock:          150000000 Hz
> actual clock:   150000000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      3 (8 bits)
> timing spec:    10 (mmc HS400)
> signal voltage: 1 (1.80 V)
> driver type:    1 (driver type A)
> clock:          150000000 Hz
> actual clock:   150000000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      2 (4 bits)
> timing spec:    6 (sd uhs SDR104)
> signal voltage: 1 (1.80 V)
> driver type:    0 (driver type B)
> root@smarc-rzg3l:~#
>=20
> SDIO Testing:
> root@smarc-rzg3l:~# dmesg | grep mmc1
> [    1.750548] renesas_sdhi_internal_dmac 11c10000.mmc: mmc1 base at 0x00=
00000011c10000, max clock rate
> 150 MHz
> [    1.949973] mmc1: new UHS-I speed SDR50 SDIO card at address 0001
> root@smarc-rzg3l:~# ping google.com
> PING google.com (142.250.117.101): 56 data bytes
> 64 bytes from 142.250.117.101: seq=3D0 ttl=3D113 time=3D9.466 ms
> 64 bytes from 142.250.117.101: seq=3D1 ttl=3D113 time=3D13.376 ms
> 64 bytes from 142.250.117.101: seq=3D2 ttl=3D113 time=3D13.486 ms
>=20
> 3 packets transmitted, 3 packets received, 0% packet loss round-trip min/=
avg/
>=20
> Biju Das (12):
>   dt-bindings: mmc: renesas,sdhi: Document RZ/G3L (r9a08g046) SoC
>   mmc: renesas_sdhi: Clean up whitespace and add OF table sentinels
>   mmc: renesas_sdhi: Add clk_mask field to support flexible clock
>     divider widths
>   mmc: renesas_sdhi: Add max_divider field to support SoC-specific clock
>     ranges
>   mmc: renesas_sdhi: Make clock divider mask configurable
>   mmc: renesas_sdhi: Add tuning delay support for RZ/G2L
>   mmc: renesas_sdhi: Add TMIO_MMC_INTERNAL_DIVIDER flag
>   mmc: renesas_sdhi: Add optional axis/axim reset controls
>   mmc: renesas_sdhi: Add RZ/G3L SDHI support
>   mmc: renesas_sdhi: Save and restore IOVS across suspend/resume
>   mmc: renesas_sdhi: Make HS400 OSEL bit configurable per SoC
>   mmc: renesas_sdhi: Add RZ/G3L HS400 support
>=20
>  .../devicetree/bindings/mmc/renesas,sdhi.yaml | 108 ++++++--
>  drivers/mmc/host/renesas_sdhi.h               |  12 +-
>  drivers/mmc/host/renesas_sdhi_core.c          | 232 ++++++++++++++----
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c |  78 +++++-
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c      |  14 +-
>  include/linux/platform_data/tmio.h            |  16 ++
>  6 files changed, 375 insertions(+), 85 deletions(-)
>=20
> --
> 2.43.0

