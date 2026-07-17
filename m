Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011030.outbound.protection.outlook.com [52.101.125.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5531ADC83;
	Fri, 17 Jul 2026 08:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784276473; cv=fail; b=sRLpPEYCl36QWDSrhCCiDSUaOA5FBWtu0EDqgHj3hMRrVZI4FYuXg8zkiJFbZwSFb+SXt8tNI7LGh8V+xOtn20Lq3SFCYynrTq4K5mIpf5EH6blT1k3ORjjsbbzacx5AJPc9vho7jFjmDHQj9AKOoYZjneNzcgQoq0Vo5o4MvUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784276473; c=relaxed/simple;
	bh=hT7weDvz8qOjYaW88xZKWjhkbyTEoaIjEr8PccZ5Rno=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M5dWl/7C0i3nbDssPNAsy+xPPIZEaQOfdO+MRUNZSffATaL7LgdVa2IEEMKEVMdfQkQxe6sY3r25zScyVI5q6laBjEN8QjODwLJHvGGg0W9o7/Eo3Ho6Qc7cghpeWvTFHJmmllAmc82orZ9gDniwseC6cnuMWH/5BPKHLw20iAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Uvu6vl3v; arc=fail smtp.client-ip=52.101.125.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Uvu6vl3v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCNpjRkpZ0E/CwOIYYGefZpgCPX+ajj7Ou84+VZUA/HwPu/I4ajkiPkgs5BowrFRSTWmWSNImjOl486Mu593F4Mmd+W94Dal9C3E7p0BUO2XFwQ5ybkCd32ayLVRDSH/xvtbP5a/Wx6LFr8VuTO1Y4waRaUQ6oFOT1bZrhjltzaeI0QHhbxDjFz/6Vkv4r6XDS3yuzCalITXYZNJUqf4H2ZsSGwWyl0bxqSg32HLNtEA0Qqe0TZGbwyx+iYUaN8IIxd3S+zsoz/kI0OjU5bn/5EOHgRO25PVzQmX9w6+tAmDIZliKP6xnDnSfx1jf5U1DhXQEdMGCB2BF4a22YPFOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Qif4mMlWaDAije5zFfeWl3zW8jxTCHtqgM3P8LdH9M=;
 b=HzRxw+kkHZ6vmMeVS6aSLcOMpx3Qi8IgidqaYfO5YCrHINCgvb7q7ADPuQkD1FQm/wgswZtXwx05cp0WJaKqYcn4hdF4btKYXm8gClYvqwM2C+eK6YQZYASVnfAyAP7sjZQojRhx9tG1K10ZL3PMCXvHlYgPzYCoLHsWWTnvw2jgal34gmPZPzMtx2NlFbclvT43dNAbdyCrcIVNaZET+SvUHS4LBQvVua0iw/qNMx2yXM2fHnJs4Vu7fk0sYt0VlWwXlQk3PRCUdJrXmWKgK2s8X4QOhMfdMs2ITVCYEcxOluwMmMzn1ItALJwkclr+YcMc5nIvQTZPbTFWoYn0GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Qif4mMlWaDAije5zFfeWl3zW8jxTCHtqgM3P8LdH9M=;
 b=Uvu6vl3v/8bKlofWfI5zos4NlT5PO/F1SEGbcutpWc5lUH+YDqEaCyzw/uIDEd0EbeQrNcrLpa3RMb31GuGz8aZEB+WPSVFEKJntBWFupNktDXeYWUeeZ3+0ynhSLrYmHX43OtJUzl4WBfmFheshHLMzUMVFeZrbW66hA+klV/0=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB16381.jpnprd01.prod.outlook.com (2603:1096:405:13f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Fri, 17 Jul
 2026 08:21:07 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 08:20:59 +0000
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
Subject: RE: [PATCH v20 00/12] Add Renesas RZ/G3L SD/eMMC support
Thread-Topic: [PATCH v20 00/12] Add Renesas RZ/G3L SD/eMMC support
Thread-Index: AQHdEvBTpm2/T6tVwkGyyxXNgqGP6bZxY+gw
Date: Fri, 17 Jul 2026 08:20:59 +0000
Message-ID:
 <TY3PR01MB11346742C360354F9442B784E86C62@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260713175159.138334-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260713175159.138334-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB16381:EE_
x-ms-office365-filtering-correlation-id: fdc717ec-ea1f-4881-6dbe-08dee3dc5536
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|38070700021|10067099003|22082099003|56012099006|18002099003|11063799006;
x-microsoft-antispam-message-info:
 25TA0DvSLHWyy/2577hRkB/PsJ3ystgpz14J/sR+Iaoy5LKc4FES9h/Wy+wSL+74/L+7msjdG6AU2p6zDXPpIzWaklSlc14vQZEs8UxS3Uw+zRkP86saSAQEA7nsjD3w7Oz5GiMj9AXEPPHEKLSlQDGDRenaMy3jn9w4t+9M3YAYUsMXQ2KeMf5awKcyXGGVrtFEsJV1gR8sfXZwby/KI6YSTnsdb5tYWlp+DF8lPkjAhSGCOwcal1qFW3ugcPmsZGlT1ZYl3eui5aNIrhgIfX9gg0Xk3a9KIxnTze8mzWHrPSNHbGe2I15IQ+GzkCvX8qPAH6Wlz1FYMdIOuG9I4dyc9APSWnf5Lbm5uN3JxqeMt3D9Ehv/7OzTR5nc5cnxUmYycXTokuq+sJC7cmB+ZWn/FmeJlPDBAsar3u4c05Pd4agmUW8xpNn2aDa2+042eFjBfAWj6ifg1L0hvn1LxsIRwBsNIQWnPV4ZrQBFWV0B2lc35h9h7l3j1RbMgrCRehxi3HygF2vinhlLgAQayZgpkEUNs44qiZPEP1ffHhqhW6hC2kZz8/Mr5gRM16l32a8jSIiZ5pE/4siZnmQNgKjJJyh6kMEOV+NNMx5Hhm4oG4Zr62tYLqOlNBZLIRyF7Oyd54JWB/3EMf5029RKnrQXRSyDaECEPpfy+WMoK5lT/85rDixzLcqZrKtsSefHndGPFC6h/anszkOsrpw+mcsuhkUhoorIM3XlmR3b4uY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(38070700021)(10067099003)(22082099003)(56012099006)(18002099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-7?Q?MgNdcEOmNFvFU2fbXkNqIjJxU5mzh+EdZSQRR8Fob8tlxUbx5ZfF7On5iw?=
 =?iso-8859-7?Q?CPtgsYozYGPZflOeedq8vUSkNv7yrW98EoEly2vTAJS8aV0xq8XAs9u4Cm?=
 =?iso-8859-7?Q?6WBXt3PTtS3B4g1/NrOUEMZV5uEJkDpmaWu2CQ8W0YClbwqiZgRRA90IO7?=
 =?iso-8859-7?Q?zNvib1735e9FaBvRLdyC0uhaTsYTV/NTcIUmoIAvlTvecpTmP5PenKTPvx?=
 =?iso-8859-7?Q?4GNOQSyHtbxrQnobyZl5oAn8fqvICGVKC3SWPPIY4udC79CrewCv2wIcPW?=
 =?iso-8859-7?Q?v3jOnDmYiJ38WtOq+HVsXJ8XFDjXHFhEzcGjxG3F8Gpj0nqbBGuvy2U3zn?=
 =?iso-8859-7?Q?lm27wsrtVc4ySdLjOHjkRdDD6MR1rbPmVz+Iy61YZco8OmYCPvOEVVqNth?=
 =?iso-8859-7?Q?p+/qOnFUKjljbno4SF/8iNR31+9SGK+nAMThSykeeQF8fFLIWJOillkQF0?=
 =?iso-8859-7?Q?+/8C0A2OhjHILsGPX95XV7Run4O9t1ogVzNfsLQXHsW7DlzaCXepf8Ys8o?=
 =?iso-8859-7?Q?+ldSqZ8MQY3Uc43wdmIk1kmN67PHk4/NrOV+Fkgrq8JUrb7VC5A6AcHtC2?=
 =?iso-8859-7?Q?oMNZhdb9GF6UNHULuIAPbDjsKKY+MvxeEkNHQ1gUsGscxIhXMdHDvia9oE?=
 =?iso-8859-7?Q?geUBHcBxuWIgD3jQVp9U/spiKskNk4SRp5a3KAbsIVaAp5TKsk/qtHUQbK?=
 =?iso-8859-7?Q?V4KcYkbVl9FG0ElTchJvgy2cg/MFapXN2SnQsO7w4mKaPT2Aq5ZqmwkZ0I?=
 =?iso-8859-7?Q?n0Q+x/89gpMLIePgHvA8XHBw4kV1I9ZKcbuHyz5T0nhYDERWwQJypHJelr?=
 =?iso-8859-7?Q?BxkeF/c6vMRyIEmz6qNWmB7Ecx1pEeeWuIMtkXjbiU4Lo74xllxas0DtLf?=
 =?iso-8859-7?Q?6ceYn7220dvculwCv/k2HlAB2GG3cjXGmQlyByBU7tJbrfnAT+B6CE5n1q?=
 =?iso-8859-7?Q?yOfOoq4LykrzzZqZkzmL5ZfAJwkeuYoi5XKuMezuMNRfGuOVvVxhCNTx0X?=
 =?iso-8859-7?Q?8Sn6asi8+lAtTLweH1+0iA4szdy6PoQt4ZHtv1tH9w2/jlpcjMfyoWIsUV?=
 =?iso-8859-7?Q?/5aI6/t/yVeYVoFP8zEh9DOlcE7CwDRkDNw6YqzHPjnpJPiQXFABTWG42j?=
 =?iso-8859-7?Q?dzn8vHMDNfYY+UEEK+JiCBipFQ2R+kX3ds7qvjdJpw5nqa0WUmeM5SrEko?=
 =?iso-8859-7?Q?eimLNVgFxEqHJ5XRy7wZvQl0iqkB3oD5DcRwYzMesKiTRzrQ/TaW6aUbzg?=
 =?iso-8859-7?Q?umjnX/EScp4m06phQ60bhL/Ntw069kfWbnvJY0B4DabaBA08mKTFbojg1V?=
 =?iso-8859-7?Q?7NKC1HBduClAuC54EyJbFkTKRgn97UiNikx6FipZmjO4Wo7VksfuzghLlH?=
 =?iso-8859-7?Q?RQbte7Szrtve75wEvGxOG44CCIPac7FKFgeQ7oxhss+qcCNsFuCpBMo20i?=
 =?iso-8859-7?Q?gW6eVvK07zF/wWjt7CTQzzob+moYLyPKHouWXZIHev7iLY2qY65S4ZoCLm?=
 =?iso-8859-7?Q?02Wv6lelKJcrv6jVE9l0e4WalhqK4rFiYV2Y+IuqXDNi/KnHhb2Bm3IRRS?=
 =?iso-8859-7?Q?JPmaQ+4FWTA/6ODleJ4hg/3qcInm6cBtw8+3uiz7G/7zG/25vBzraBk0op?=
 =?iso-8859-7?Q?KgTnrNY97w3uMgxNzz7aFi8x2CKEeb4JpdpxDarnWIRVR92/CmZ9uvx4m9?=
 =?iso-8859-7?Q?UFyOCgItpf9BiWVrvhoa25Rddo8plPCSBG8NOQP3M5A1k3OVAQtVwln7Zk?=
 =?iso-8859-7?Q?s0ou1VRv2Va8QG+6/zsgUfxeD1VcKmZIyFCupUsRN+vIHhCjNITH0Hfo/G?=
 =?iso-8859-7?Q?KcOoqC/2Mw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-7"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc717ec-ea1f-4881-6dbe-08dee3dc5536
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 08:20:59.4921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gf0ETE2yy70dCud/nTKx2yC9ssicgS0qpmw/Jd8tIPo1L2trnx8XH9uoIX1LvuMlVEB1AG74WSSRZFfEtzV+Dpi1cg4qBN1cQhxWkQm2tGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16381


Hi All,

I got an update from hardware team for CLK divider bits for HS400 mode.
This change will incorporate in next version of hardware manual.


For HS400 mode:

00 0000 0000b: (SDx=F6/2)/2

Other settings are prohibited.

Cheers,
Biju

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 13 July 2026 18:52
> To: Ulf Hansson <ulfh@kernel.org>; Rob Herring <robh@kernel.org>; Krzyszt=
of Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Geert Uytterhoe=
ven <geert+renesas@glider.be>;
> Philipp Zabel <p.zabel@pengutronix.de>; magnus.damm <magnus.damm@gmail.co=
m>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; wsa+renesas <wsa+renesas@sang-=
engineering.com>; linux-
> mmc@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel=
.org; linux-renesas-
> soc@vger.kernel.org; Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.r=
enesas.com>; biju.das.au
> <biju.das.au@gmail.com>
> Subject: [PATCH v20 00/12] Add Renesas RZ/G3L SD/eMMC support
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
> Biju Das (12):
>   dt-bindings: mmc: renesas,sdhi: Document RZ/G3L (r9a08g046) SoC
>   mmc: renesas_sdhi: Clean up whitespace and add OF table sentinels
>   mmc: renesas_sdhi: Add clk_mask field to support flexible clock
>     divider widths
>   mmc: renesas_sdhi: Add max_divider field to support SoC-specific clock
>     ranges
>   mmc: renesas_sdhi: Add tuning delay support for RZ/G2L
>   mmc: renesas_sdhi: Add TMIO_MMC_INTERNAL_DIVIDER flag
>   mmc: renesas_sdhi: Add optional axis/axim reset controls
>   mmc: renesas_sdhi: Add RZ/G3L SDHI support
>   mmc: renesas_sdhi: Save and restore IOVS across suspend/resume
>   mmc: renesas_sdhi: Make HS400 OSEL bit configurable per SoC
>   mmc: renesas_sdhi: Add RZ/G3L HS400 support
>   mmc: renesas_sdhi: Add HS400 enhanced strobe support for RZ/G3L
>=20
>  .../devicetree/bindings/mmc/renesas,sdhi.yaml | 108 +++++--
>  drivers/mmc/host/renesas_sdhi.h               |  11 +-
>  drivers/mmc/host/renesas_sdhi_core.c          | 274 ++++++++++++++----
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c |  73 ++++-
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c      |  12 +-
>  include/linux/platform_data/tmio.h            |  18 ++
>  6 files changed, 408 insertions(+), 88 deletions(-)
>=20
> --
> 2.43.0

