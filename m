Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011064.outbound.protection.outlook.com [52.101.125.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1187F46DFF4;
	Wed,  5 Aug 2026 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785934618; cv=fail; b=NX2t1upFk3pzhp1MoC5Uh5ENr3Cd3EiYzPtVRu1W8ppGPPtwqhrdS/lO3lu1ELClhsCF109Ym8G51J21iBn7t37hufaedjx++5pCU4WbV1sC8Md0fleDDewlEYHT6V+8krB1kqPrbIdh22AntCAML7QtqQoga3dE8GY+AtFO118=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785934618; c=relaxed/simple;
	bh=YjBpOvcvNzJapWTlgauFLmv7JRMepF9ZFX2xGLLyJf4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NDeFjyKIcJBwZfCBldKQLT47AVnsci8sE7M5JVG2gTmcS7YJmymuSyRFZGu5plopM/5iaPWeOyQgFAz4HDbUUyuhR7W5k8iAzP4fvIBs56ObEcEb0nNB/sbjJLIwPv2kNLoCMml00S6T4hw8H0kpiXQCzHiS0Wh2kcuhdmIhveg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=V4NcuaE5; arc=fail smtp.client-ip=52.101.125.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="V4NcuaE5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkecbTJkWSNzGqWRWeNrZ2yi4Zbv1nc/24GcNk6PqeFHeP5pDVvWbPPsHOppbIfOLssxm4PuFJPP6oku7FMS+LNVLLAFZJnwKTghU0blJXCfJ1vhGwJ9Zpj6vuu85/CK/Cg6kRj/7MFLDeGvfk1ipgkve0oDTMy4EEd5LFTpaZYE+MjEyVIEsrw8EYYKEUQCnSIlN2jAlzk+3INmafsO7YWKbCCa5y1VvxsuO5Qm/1SUyh9MWDsGPetLH0GSLDn7vMdIBW/lQ3PbEoO7lkk81QIi+ta/ZsA2ecV8GmHibpbZPxNKKri90FWx/p4Vszs6auF1ZVEyTyuDggPW8+SIiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTviZ6Y9esEpyRhY/oLUgvbLvkDO9+0t5OJrObfmvvo=;
 b=lB7zbkqNZ1paECnvc6pJRMWjOUfv+jjrfsfGAECp7l5+rykKrIcxeBPSYgiU2VWoAKzRxHlkuBJ9GAsExBSuenLSKu6U0Nzpw53BrgXuM7lVRFNj8CnaSTD5LoCMUrA4It7XC7cO0o8FnpyUAuOo+3nsN+aigROQGy7pTXRVhlRTjp4xPs3DVZu8yueG+XursUCQQbA9oeMxp4ef0hDucRkaXXr4tZFlnTyR8YFOZXcRmW4At6WBxW3KKwpnHTt/+LQX+e1I64l/VMnCOtAz9xJuoy1HH3MhuYCrrj9mo4L6cAwJ2MRrU4JNNwJ5oKX9pvbgypwc7XfubFvViNuybg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTviZ6Y9esEpyRhY/oLUgvbLvkDO9+0t5OJrObfmvvo=;
 b=V4NcuaE50NBc0VzNOvP0eH4yEZ6Ah8xDlppVwFEUbtEXhWrzKz7KvjKA9PMTP/X1lohIvxxLu8/2Rq8LWEr8BT4sfAAD/PJ3Nj8NO/2r25/+xlrk8AnwEx5XJQXBchbXWb/aiiZDHiFH9CWCZFMxjW71q8mEmOQ/4gPxmddGMe4=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSCPR01MB14996.jpnprd01.prod.outlook.com (2603:1096:604:3ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 12:56:50 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 12:56:50 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "biju.das.au" <biju.das.au@gmail.com>, Ulf Hansson <ulfh@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Philipp Zabel <p.zabel@pengutronix.de>, "magnus.damm" <magnus.damm@gmail.com>
CC: wsa+renesas <wsa+renesas@sang-engineering.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"biju.das.au" <biju.das.au@gmail.com>
Subject: RE: [PATCH v23 00/14] Add Renesas RZ/G3L SD/eMMC support
Thread-Topic: [PATCH v23 00/14] Add Renesas RZ/G3L SD/eMMC support
Thread-Index: AQHdIBcQqTRcf7MR9EyBG43WB7r4QLaPc24w
Date: Wed, 5 Aug 2026 12:56:50 +0000
Message-ID:
 <TY3PR01MB113463AADCC6D60F6995E36C486D32@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260730113200.36456-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260730113200.36456-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSCPR01MB14996:EE_
x-ms-office365-filtering-correlation-id: ca2f2402-f856-47f9-ea32-08def2f10429
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|7416014|366016|6133799003|22082099003|18002099003|11063799006|56012099006|10067099003|38070700021;
x-microsoft-antispam-message-info:
 P2oe6r8YgF4w23vdxZAmUEY5TeZ6KGpHlGu2vTsQGiiEpuDfZCfQxg+Zy5+1jZ516+wSwaD1glSDTak0+hZDnRG+hTuTF1iWI/JdOq+Akes19rdMsbB1xkE4TSdFP7u8l9+LdWjQeG59ZW/9od91/WO9aizFf0YZNK1woZekrTuh6DGoevnll/TX5+mn1cGCkJZ5hnUES9nQpQ3ae3EwSdXZ7V6ObBcEDkEcorXxVILGWEUn8Zfzu1tRgzKSt05piYdXRNvXUbxBwXbJevW6WNwwb8ESv7231vnOZ4/pOnudllxaHBAiPy6x4exl5IplbjcPtP7Kqttiq3bg2YhDpux2IuOOmp13WY7yTNgStxEZklp7Iq/rfaTUCuFYGxO5BuhI+o99WCyJECHD6F9waaDfhbCBqtK1DhW5MR1az3ZoH3twMGE3VtlnQDum42hqvjGezgyxwIOLJoVbKwOtExgRDELkh7NLu8lWHbdFcZpL0kXwWqM6S9vfBTkr3RwpWooP5t9SKRvR9mpYEVPB5Da48gc1K9Nbf2XntvBLAJpKs0SgfeI+QhRilxGBAqI07spCd7WodX3jIID4DAez3GgUASHeYGAH6dgZ8aMFFcuKJSfWH21R9wnWaEeRElK/VEv/MusS7xUmTZK2XroCQuw8zPMt+Uph9NYvsuRB8dQqwDOTNWpVYIfu280YjNCWqT+0WkS/OBVDKbFqH7djCA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(366016)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AO+eYDOzpOjNDIHic8GHes0JapnKnhDxOZ3ZlxGsYSYGEHse9QLVPX4N6s+I?=
 =?us-ascii?Q?wjOgrAwNQlXPhA49KTHeZ5RX8/BFX5tbRpHrv5xCCBg/iLZdjWVy90B/eQla?=
 =?us-ascii?Q?ebdtdjexfLXJr5IppTgWkAFbIBW2Jdp+NYID0qWfvXrdQpn7O8PT0e2r0j+9?=
 =?us-ascii?Q?TE6HQgFaxnPkbLUj1717XKz4e1xjzNPDnRAXGyROwtFUblqn8zjS0QRBoSHl?=
 =?us-ascii?Q?8ZaaZ/ANxeFXZfsJd+CvmqHA6QIObsWGTULtAROK/6O1B8P7qbpx2g0gixFf?=
 =?us-ascii?Q?KaWSekmNngkRlk+5c69M6N4JL0Y/VMMqd7kmLeSeM6s7g40/6SeY2FF70Skx?=
 =?us-ascii?Q?UdkUF/o+bnjIcrp4BiMr9MV56CLm4y8Tbv7WCx1uZKkK+wENG9Uyu+DehBfS?=
 =?us-ascii?Q?GAeUuqCadTryViTe9R6Y/RyXNBPEPKF6wG90+P/S5gUzLCZ6xb9TvmLXmhwE?=
 =?us-ascii?Q?dsgsJdiS4TwbFbhtauWQssQuTzKGrITwglCLW4RxEwFBrQL3hue/e3oZ+gg1?=
 =?us-ascii?Q?rIW6KPXFIvI/HtiqR2TiL4rF9oAGR9edvwCXWiJK8+0c8/4uuFq/yc75/QmM?=
 =?us-ascii?Q?DJNn2synILBfaXSldhCdwbcZ+kjrTVb9veUFB0n15LmOUFyWo1lygZRj/+SX?=
 =?us-ascii?Q?OpA3BcWJqYDzXqjg+mLEhDChe8YjZ/Bs/juscWD5NJo1gAz7RVdVSZRUdP2j?=
 =?us-ascii?Q?EE0rw2Nq3iTFnBPhL322DslsBzZPNuaE9X3GvM9+AURfH7fiNP7WKpe6szZy?=
 =?us-ascii?Q?BNtTTosRud9VLLb2WNnEi6D1U7NfEnogrwjLe/uN/LUlycRTmyE+LDEVkmRJ?=
 =?us-ascii?Q?UHgMI+nAxTrA71/PMDRATdOIP+mFSp6gVuryGQ5vlG7TLjQn+3wlLrDjgLN3?=
 =?us-ascii?Q?3yR6qve5lWOIA7KG4ax2XeiKejNqH52chzIMRMHTJ5ktnRhhhVrIog/E5ejV?=
 =?us-ascii?Q?Fxk2EjFrNR8/jI7yJ6ljnnHorSAi+hMkJppyXGTFQYmcxAdEWGPqZri8mSlV?=
 =?us-ascii?Q?UrsGwpjY0IlvomMdTre998BR6CnPhqdChOHqC/ySUpP3QnwBFSR0jYDvWykD?=
 =?us-ascii?Q?/PJyKRKvwQHq5LxxvcJaNBE2gPZRa8SJ8WU7S2be4I3C7gvojTT57zxlqC4b?=
 =?us-ascii?Q?g+jx0/MI/278kdYPkP6ZUdHIXMvEoUI2Rp7qxG8YLYjhrrHNOpmGwRQ9+U/Y?=
 =?us-ascii?Q?PRuuMFKa4BdTlEWAPly0sPOZX64wHP6gWdwosH/1LzQNXaTlYzEe7R+N5QDq?=
 =?us-ascii?Q?lZo+UkPDjUa499upAILU99uq6PPzDuzbQLs8kMbiqJqQ1FTyd4PBVKGF4Ifj?=
 =?us-ascii?Q?m8e2XshdrQKE/pGJkTyOO8odEBW6FYU1b1q0HznZIIS/bYZ7qA0oAI1VLP0D?=
 =?us-ascii?Q?15xuXxpw+dERtVdPOBEn2IQKGCc+sZ7JVir42xwpN3IU+zds70rLgLSW9UlU?=
 =?us-ascii?Q?+1zR+va59jectCWm17lxuX020YDUaJ6k+Qx95WVw+HgC+u989/qwg0lIlrGK?=
 =?us-ascii?Q?J8eGaa1k9Nvhreq1B6JGWbY36QTYy9WMhhHA/webTxIN4bD7bCK6cH4CDPpd?=
 =?us-ascii?Q?arG+/DLGnzldVs96qmvyKs8JD9DQhC75tRU3r119uwNNXEcwKC+3Nu6I/pCv?=
 =?us-ascii?Q?J5z8rfr/6Ardp7Ch6McaVc8FVE8nuWvz+S6kay8Um4vJbPG7KlfUXw8sbZJz?=
 =?us-ascii?Q?UtxepE8uCIwShZjUfFcf+uX3D/q8MEUT8Ni6J3Y5rOC8wf6Nho/fyXLfrOKW?=
 =?us-ascii?Q?W/PPcdmz3Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2f2402-f856-47f9-ea32-08def2f10429
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 12:56:50.3649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mzjF7QXbSlJG2A8f5jVxxihz3OrFgA/zsdxtFfH+pJQBgTLMzBbKAfgNRlUS9d3pn4BDfnzx3G5QOTY21SwxXzKSiVRSq8C2/QobuJ3GhRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14996

Hi All,

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 30 July 2026 12:32
> Subject: [PATCH v23 00/14] Add Renesas RZ/G3L SD/eMMC support
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Hi All,
>=20
> The Renesas RZ/G3L SoC has:
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
> This patch series support all modes. Please see the test logs for smarc-r=
zg3l[1]
>=20
> This patch series tested on smarc-rz{v2l,g2l,g2lc,g2ul,g3s,g3l,g3e},
> rz{v2h,t2h}-evk and hihope-rz{g2h,g2m,g2n} boards
>=20
> v22->v23:
>  * Added write32hook function for hardware idle synchronization for
>    CTL_SD_CARD_CLK_CTL writes.
>  * Changed the data type of max_divider from unsigned int to signed int.
>  * Assigned of_data->clk_div_mask in renesas_sdhi_probe().
>  * Updated commit description for patch#7.
>  * Updated tmio_mmc_reset() to handle 32 bit divider register in RZ/G3L.
> v21->v22:
>  * Added HS400 ES mode after fixing inode corruption when eMMC is
>    mounted as rootfs.
>  * Updated commit descriptions for patches #4, #5, #6, #7, #9, #12,
>    and #13.
>  * Added clk_div_mask to of_default_cfg and of_rcar_gen2_compatible.
>  * Added a renesas_sdhi_set_hw_adjustment_delay() call to
>    renesas_sdhi_init_tuning().
>  * Added renesas_sdhi_is_internal_divider_enabled() and
>    renesas_sdhi_clk_get_rate() to simplify the clock rate logic.
>  * Added `clock &=3D ~GENMASK(9, 8)` to clear the divider mask bits in
>    the register value.
>  * Added a renesas_sdhi_set_tmpport() helper to set delay values.
>  * Added a check in renesas_sdhi_is_internal_divider_enabled() to
>    return disabled status when in HS400 mode.
>  * renesas_sdhi_reset() now restores data strobe register values
>    after reset.
> v20->v21:
>  * Dropped HS400 ES support due to file system corruption, will add this
>    mode later after investigation.
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
> [1]
> Logs:
> HS200:(With internal divider)
> root@smarc-rzg3l:~# cat /sys/kernel/debug/mmc0/ios
> clock:          150000000 Hz
> actual clock:   150000000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      3 (8 bits)
> timing spec:    9 (mmc HS200)
> signal voltage: 1 (1.80 V)
> driver type:    1 (driver type A)
>=20
> SDR104:(With internal divider)
> root@smarc-rzg3l:~# cat /sys/kernel/debug/mmc1/ios
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
> HS400: (Without internal divider)
> root@smarc-rzg3l:~# cat /sys/kernel/debug/mmc0/ios
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
>=20
> HS400 ES: (Without internal divider)
> root@smarc-rzg3l:~# cat /proc/cmdline
> rw rootwait earlycon root=3D/dev/mmcblk0p2 net.ifnames=3D0 root@smarc-rzg=
3l:~# cat /sys/kernel/debug/mmc0/ios
> clock:          150000000 Hz
> actual clock:   150000000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      3 (8 bits)
> timing spec:    10 (mmc HS400 enhanced strobe)
> signal voltage: 1 (1.80 V)
> driver type:    1 (driver type A)
>=20
> s2ram:
> root@smarc-rzg3l:~# echo mem > /sys/power/state
> [   72.838238] PM: suspend entry (deep)
> [   72.864225] Filesystems sync: 0.021 seconds
> [   72.875166] Freezing user space processes
> [   72.883030] Freezing user space processes completed (elapsed 0.003 sec=
onds)
> [   72.890237] OOM killer disabled.
> [   72.893612] Freezing remaining freezable tasks
> [   72.900038] Freezing remaining freezable tasks completed (elapsed 0.00=
1 seconds)
> [   72.907677] printk: Suspending console(s) (use no_console_suspend to d=
ebug)
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
> [   72.951851] renesas-gbeth 11c30000.ethernet eth0: Link is Down
> [   72.955613] Disabling non-boot CPUs ...
> [   72.957320] psci: CPU3 killed (polled 4 ms)
> [   72.961085] psci: CPU2 killed (polled 0 ms)
> [   72.964897] psci: CPU1 killed (polled 0 ms)
> [   72.966874] Enabling non-boot CPUs ...
> [   72.967144] Detected VIPT I-cache on CPU1
> [   72.967202] GICv3: CPU1: found redistributor 100 region 0:0x0000000012=
460000
> [   72.967250] CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
> [   72.968284] CPU1 is up
> [   72.968428] Detected VIPT I-cache on CPU2
> [   72.968462] GICv3: CPU2: found redistributor 200 region 0:0x0000000012=
480000
> [   72.968493] CPU2: Booted secondary processor 0x0000000200 [0x412fd050]
> [   72.969465] CPU2 is up
> [   72.969633] Detected VIPT I-cache on CPU3
> [   72.969673] GICv3: CPU3: found redistributor 300 region 0:0x0000000012=
4a0000
> [   72.969714] CPU3: Booted secondary processor 0x0000000300 [0x412fd050]
> [   72.970760] CPU3 is up
> [   72.989187] dwmac4: Master AXI performs fixed burst length
> [   72.989231] renesas-gbeth 11c30000.ethernet eth0: No Safety Features s=
upport found
> [   72.989275] renesas-gbeth 11c30000.ethernet eth0: IEEE 1588-2008 Advan=
ced Timestamp supported
> [   72.990364] renesas-gbeth 11c30000.ethernet eth0: configuring for phy/=
rgmii-id link mode
> [   73.005175] dwmac4: Master AXI performs fixed burst length
> [   73.005205] renesas-gbeth 11c40000.ethernet eth1: No Safety Features s=
upport found
> [   73.005236] renesas-gbeth 11c40000.ethernet eth1: IEEE 1588-2008 Advan=
ced Timestamp supported
> [   73.006314] renesas-gbeth 11c40000.ethernet eth1: configuring for phy/=
rgmii-id link mode
> [   73.177702] OOM killer enabled.
> [   73.180837] Restarting tasks: Starting
> [   73.186007] Restarting tasks: Done
> [   73.189570] random: crng reseeded on system resumption
> [   73.195001] PM: suspend exit
> root@smarc-rzg3l:~# cat /sys/kernel/debug/mmc0/ios[   75.705532] renesas-=
gbeth 11c30000.ethernet eth0:
> Link is Up - 1Gbps/Full - flow control rx/tx
>=20
> clock:          150000000 Hz
> actual clock:   150000000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      3 (8 bits)
> timing spec:    10 (mmc HS400 enhanced strobe)
> signal voltage: 1 (1.80 V)
> driver type:    1 (driver type A)
> root@smarc-rzg3l:~#
>=20
> s2idle:
> root@smarc-rzg3l:~# echo freeze > /sys/power/state
> [   97.634564] PM: suspend entry (s2idle)
> [   97.655343] Filesystems sync: 0.016 seconds
> [   97.662352] Freezing user space processes
> [   97.666531] Freezing user space processes completed (elapsed 0.004 sec=
onds)
> [   97.676132] OOM killer disabled.
> [   97.679743] Freezing remaining freezable tasks
> [   97.687107] Freezing remaining freezable tasks completed (elapsed 0.00=
2 seconds)
> [   97.695071] printk: Suspending console(s) (use no_console_suspend to d=
ebug)
> [   97.744129] renesas-gbeth 11c30000.ethernet eth0: Link is Down
> [  100.135760] dwmac4: Master AXI performs fixed burst length [  100.1358=
05] renesas-gbeth
> 11c30000.ethernet eth0: No Safety Features support found [  100.135848] r=
enesas-gbeth 11c30000.ethernet
> eth0: IEEE 1588-2008 Advanced Timestamp supported [  100.137950] renesas-=
gbeth 11c30000.ethernet eth0:
> configuring for phy/rgmii-id link mode [  100.154860] dwmac4: Master AXI =
performs fixed burst length
> [  100.154890] renesas-gbeth 11c40000.ethernet eth1: No Safety Features s=
upport found [  100.154919]
> renesas-gbeth 11c40000.ethernet eth1: IEEE 1588-2008 Advanced Timestamp s=
upported [  100.154984] renesas-
> gbeth 11c40000.ethernet eth1: configuring for phy/rgmii-id link mode [  1=
00.246688] OOM killer enabled.
> [  100.249851] Restarting tasks: Starting [  100.254395] Restarting tasks=
: Done [  100.258012] random:
> crng reseeded on system resumption [  100.263468] PM: suspend exit root@s=
marc-rzg3l:~# root@smarc-
> rzg3l:~# cat /sys/kernel/debug/mmc0/ios[  102.690106] renesas-gbeth 11c30=
000.ethernet eth0: Link is Up -
> 1Gbps/Full - flow control rx/tx
>=20
> clock:          150000000 Hz
> actual clock:   150000000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      3 (8 bits)
> timing spec:    10 (mmc HS400 enhanced strobe)
> signal voltage: 1 (1.80 V)
> driver type:    1 (driver type A)
> root@smarc-rzg3l:~#
>=20
> SDIO testing:
> root@smarc-rzg3l:~# cat /sys/kernel/debug/mmc1/ios
> clock:          100000000 Hz
> actual clock:   100000000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      2 (4 bits)
> timing spec:    5 (sd uhs SDR50)
> signal voltage: 1 (1.80 V)
> driver type:    0 (driver type B)
> root@smarc-rzg3l:~#
> root@smarc-rzg3l:~# ping google.com
> PING google.com (142.250.151.139): 56 data bytes
> 64 bytes from 142.250.151.139: seq=3D0 ttl=3D112 time=3D7.679 ms
> 64 bytes from 142.250.151.139: seq=3D1 ttl=3D112 time=3D12.283 ms ^C goog=
le.com ping statistic packets
> transmitted, 2 packets received, 0% packet loss round-trip min/avg/max =
=3D 7.679/9.981/12.283 ms
>=20
> Biju Das (14):
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
>   mmc: renesas_sdhi: Add write32_hook for CTL_SD_CARD_CLK_CTL register
>     writes
>   mmc: renesas_sdhi: Add RZ/G3L SDHI support
>   mmc: renesas_sdhi: Save and restore IOVS across suspend/resume
>   mmc: renesas_sdhi: Make HS400 OSEL bit configurable per SoC
>   mmc: renesas_sdhi: Add RZ/G3L HS400 support
>   mmc: renesas_sdhi: Add HS400 enhanced strobe support for RZ/G3L
>=20
>  .../devicetree/bindings/mmc/renesas,sdhi.yaml | 108 ++++--
>  drivers/mmc/host/renesas_sdhi.h               |  12 +-
>  drivers/mmc/host/renesas_sdhi_core.c          | 337 +++++++++++++++---
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c |  78 +++-
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c      |  16 +-
>  drivers/mmc/host/tmio_mmc.h                   |   7 +
>  drivers/mmc/host/tmio_mmc_core.c              |  13 +-
>  include/linux/platform_data/tmio.h            |  19 +
>  8 files changed, 499 insertions(+), 91 deletions(-)
>=20

Gentle Ping.

Cheers,
Biju
