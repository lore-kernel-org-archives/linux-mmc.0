Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010019.outbound.protection.outlook.com [52.101.228.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E59A43B489;
	Mon,  7 Sep 2026 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769208; cv=fail; b=gOZKRc2vZWYo1IqDw2Al+MVRTvPQT7TE1UyDWX/kvPwdXtB/tIl5lVSzN73MopxyEGpGsegPayamvCj+gFgi0zzzh9TS8mzLFb+mXru6BYiQokRRmhvGHKE2JoJf//uomIwpk96guwRmFty9ZWerZ1uFmL6O5Uk5pdRMcFBr3q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769208; c=relaxed/simple;
	bh=6RAJ0gAueCDwmNaW/SxKV251hU4swg3jZKcjkEgjp+I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EEELzgfDMXvTYZATQrT64JxWznrrBNqs1CjWBCFVB5vnbpR0XtdUV0zkMu3mniCfz8LhdtpAqyq9808ElQ0FFTTDyGjxPyigDSmOejcL5yOxuFv2Glhh7bT+DIallljshDNPiHgOysSlaneJPmGAblau2WCnlDkZ5I7FCyg8Ifs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=PUIj9GV1; arc=fail smtp.client-ip=52.101.228.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="PUIj9GV1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSYnauK7FF2NtRCrD1dkiZ9F7G77e0tKbOjrHZiv6swy7M6tY0mBLy/gX4jUiafRwbUZ4o/ZNEy2UO0YLunjd4EwqfaOEajetarZEdCnLZJyDNCfClHwLzb2/lRVOc4yTIoDeudShrqdhDGPjGVHduGIrhLTia0PB3jfNYPkkF6RqOqwSaYjyQcgCOeDz00w7McmDdKHJk8Bvk9E0S8yJgCU1VSXCObiXIKMAsYhC1h82MXCPdASgJQjyBpRfQv39pO4d9k8tQMQdedsYZOBcBELy0xLuylaHu+mBa4MRZeoHcRH12kp0O6/W1UDGhICKyz08INplRt9eO8gavEwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/TrPMxMfsdB1KhQizaC0+zCdfSKSgU7HCZLBiGGE+4=;
 b=HyeCPeMcW3kxZXbEDyDuwG6pj1Mc7EYG4qqV7a4pr8g56cm510pmPSLYtycssqacUFuXCPJp/25BcQjFFD7q3u2on1JMgyFUQ1nib5EBgIUCYFmiDErdC7SIDds5eQf+eIaYteCoZTAWycnXQ5UoQFmaBmT/8GYBQXmSfmIzzcnwdFCJQ2odA1IU4LBqhapW7ycDmnxThdcTuZPs6GJ42IckExZQXUDB0MbBoDcRKHRw48vKtt3JmnhZX6VLL7U908/EZB+30AAYrWfPWj/YEr3lEo0SSFqEhS16KkH+odY8wzS8UyN54daCowArZGEvb1OeeU4Rhk85GiwCVLvjDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/TrPMxMfsdB1KhQizaC0+zCdfSKSgU7HCZLBiGGE+4=;
 b=PUIj9GV1E6fUlhY+aVVlS6hioYATsMIscRy6ovpxHpfJM3tXGIrYVb+JtLDCTETgCW8RdLaK85dVDeSND5fwv3iCld9y6DTMbCoeh4U5kLPVRnGFly/C8/cndgQDmCwLtmTsjJCJordMBHjusyWNhUjCMFIgMhFcYWihUZvOEdI=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB11137.jpnprd01.prod.outlook.com (2603:1096:400:3f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 08:19:57 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 08:19:57 +0000
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
Thread-Index: AQHdMMfAfNE6w/AmCUKaMfvf8hhQWra8vN2AgAYjnwA=
Date: Mon, 7 Sep 2026 08:19:57 +0000
Message-ID:
 <TY3PR01MB113465A077155B664C7B4502186B22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-11-biju.das.jz@bp.renesas.com>
 <aplMNoRlIYbVZH5-@shikoro>
In-Reply-To: <aplMNoRlIYbVZH5-@shikoro>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB11137:EE_
x-ms-office365-filtering-correlation-id: 09a8ea94-b012-4812-88aa-08df0cb8cda2
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 /sYTRmJO4972orN4YXXX7OxyKRg4uOnKlJwsoBe+lNmj7WbVCWFrQKcQMuQerj3AKU9UOFWI2dZbLgYKitmf33wO7LjSFXH6Js91K7X5ARq6xn7auNqxPDZv8YD3QNYXfuadzIXfFRH8RH6ulxpzvl3lKnS1BANyp2+g8AkD97X9iwzX65LYmCcouWb0PhA1+MdUhxfDsUUNRhGGMnWX3KC5QFJTCqD409sTexzQ/q62JHbXuziHHC8mga7RR8GU28Xcnut91NyCZlKo7J5P64uDKEWAVrYHkVv0H9dDpYJ8KGqH9xLhh1ankfwpmPeDD4gzmd+q+9gat53pZ7h1WwQNsxzH3cUfLNcExInLKfT1o83buINQGHx96v3aFSJnkI9lCV5/NKjx8xv3lmLYGBR3IW3AkWGz2BVOvkdFflyMuY9SoDJcNm0ISAWBZqa3XPNSNiawR1nh3On964pav3BsjDmxwmoWeFHAtFR9GhEzvJgOvHjviEMK9HLkgCiM4T25Xca9BNYlsPy3ZDA2KmIHXMfqCZNa3dks5oT/J6eg9Lkrhdp4jZEYbHnu3lXDB+n/4eNSBXd2xx7zLCHvVw1ibzB67PN4CpFK2SmApAg2vD34sQNY3ZArOz50Vm8FUE02Ptk+BD8wcqlT+H5GbsyewhuswEuuHhlbhqfAZBeHbSo9rntq1+P8v5fvWlzsKVOZZ58qrmzCHjhgpXnyD/E/5/lamSRjQr7N4WrJ7os=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?w+S260Ai4f4QH9ErKLM0mH8xDre+wmNZeVWxHd3LFcCA3dBgwyUktxkd1JkM?=
 =?us-ascii?Q?rNNF4UNMpj6iYQcFUrKJcjDaBedES/OqI986t5cXt48KZ86usFxXi4ZsgcHh?=
 =?us-ascii?Q?BgSd0D2KwO/fCEAr95vsknA9aR5k7lbA6wznMucnNt0kJb9tP3LuAT+qBtlD?=
 =?us-ascii?Q?LW66sOX2iyvNLSoWRmzZbRsNESelCzfMtsGCoEmo6ZwKzPgPFmnGzAWXGZ4a?=
 =?us-ascii?Q?MGWMrh7bWd6Jz2Yyd2czeFqIfYGg8IXxYHxlfgQFl5AFUAUZ8V4naDTsERMg?=
 =?us-ascii?Q?GwrSfplIIQRdMEbF/FzDNLLHy7cbQP6D9MCWqNpOqPr8D0gfF9oIsnyuLSVZ?=
 =?us-ascii?Q?QdlXJ1Mw1v01VlaadKMTMecmDNhF/bjmkb9Tg/WplZUZI4kqWMLa+YGg9Qha?=
 =?us-ascii?Q?lHLiq9N6oO+TBSc+vFSzzu5n9EcV4W+0RRmE5bBr0nbErdN7ub+U7mMt0t0m?=
 =?us-ascii?Q?dRnfHjLJ4SiL4YcZPw8C8SBh2RjwbJF+3qM4g3WhogUsBbZWiO8YPE546UCn?=
 =?us-ascii?Q?/qMLWjmQgLzxjeBVXeKOSX9eh/FcQYd1rJ5q0dkg+r61ftLnIhvRX6b6rCdW?=
 =?us-ascii?Q?H74fDbVWerCh+FxkoEkdq+cNWspdzIOboHcSJD+xl3QE1OZ54Z/0g5ok7V/E?=
 =?us-ascii?Q?TezRADOxuJMSYyePH0so2D00fl+h2aGhGxXdcXrUsM5wHjfyWQCnBuLbmz8q?=
 =?us-ascii?Q?KE6onQlvhoIQl1ExXV5G5SB0oH9xgBkwBSviMuEjFVmvKdrlfrUvgvDP3tqi?=
 =?us-ascii?Q?qirUcBc7qFjGGSU15fuxodMg+YuWBZpFgGSThzxLSz9ODbSkb5/MyQxNChCc?=
 =?us-ascii?Q?Jk57BDjDU2gi1UnMN1S3h0psw/Xvox0RQXHMn2ekDp9xOJKboI/G4V7D28rN?=
 =?us-ascii?Q?iC47M5yKoyzA3e7iJODA1E1Ntp5UEQe2HrAKGsMJEoMjXF2a8Q0n04Cw2Sks?=
 =?us-ascii?Q?wE4DLNZpx1jXYzzW48mcXWmkGjKmKy8dQN1F+kksnNFEwr1du/K+ndsx2rSC?=
 =?us-ascii?Q?WLofVqTjRJtoBbBw6E9Ycxnqzn5pg5xF727SidzkTeJMq0qzyKvDX2CZt3ku?=
 =?us-ascii?Q?YCLEVwXF6uigD450wR0bD5bZyRMSsy/CV0AO/150/lc9Gyc3t+YOMCVinV4G?=
 =?us-ascii?Q?RRfF0raAgMZGe4up/DPCWq+Ex3x74wwyeXiYv0t3kPufwS0+zgUSd8gUHiFA?=
 =?us-ascii?Q?y9yEQOHhHMpKo2BfXGIGoNau17AhTSL7lNltNPQmTxdzaPwXDZywz/bn5HlM?=
 =?us-ascii?Q?AYZiLByQx5gKmN6tzB0ASic/CFXaQ0D30jG3oiIcrFrKF4roVuWda7pZffKW?=
 =?us-ascii?Q?y1hVktaDsFsVoVJvc92M1M4gJNkNwh3DdJKJjEpkw3yt9fHZk0XavmRrsTf1?=
 =?us-ascii?Q?QAkq/Y0+CYf5wlAjFlXXooBdaj+1HJb6vg23xuovdrYo98TAZvLb6Sx9vVNF?=
 =?us-ascii?Q?aNu8ZlkAsGH7hLPWYKeLdQjiq2sS3d/jHHg6ro9rDL1OybuDoq4YoPBo5h6m?=
 =?us-ascii?Q?N2n78V7tbRPLgbwi8zpxWI6/feQw7HwyKTWmU0SuIMCZ2/z0/u25W9sN3j0n?=
 =?us-ascii?Q?xQ+r+aY49aMWuRAahA9t3yx0nPNieOBzRjHMXalAJOJwzt+cHM5svNIyRHB5?=
 =?us-ascii?Q?ZYwjzz6b99pnXmqgZb1GlndHIltiWVi8gFnylH11gXx8RZRzllFxgImAinMk?=
 =?us-ascii?Q?zGKd1nXjoOyGH4wTgS/xEz0ZllSB2RTs+29M9UwptLtU8i2/TiOv8W1pqti2?=
 =?us-ascii?Q?8iV2mVMrSQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a8ea94-b012-4812-88aa-08df0cb8cda2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 08:19:57.2968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tThMizgJOHaW8SS8thW0E5pgYrSglfPd9o6Jyz+scHjYRWihBMCmRZttl2Z+YtJ+FD4xGos8fTnz9zsYQ8X1xmmi8CIA+Vod7Y4g+Hpp66U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11137

Hi Wolfram,

Thanks for the feedback.

> -----Original Message-----
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Sent: 03 September 2026 11:30
> Subject: Re: [PATCH v24 10/15] mmc: renesas_sdhi: Add write32_hook for CT=
L_SD_CARD_CLK_CTL register
> writes
>=20
> On Thu, Aug 20, 2026 at 06:16:40PM +0100, Biju wrote:
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > Add a write32_hook, analogous to the existing write16_hook, so that
> > sd_ctrl_write32() can wait for the SD bus to become idle before
> > certain 32-bit register writes.
> >
> > renesas_sdhi_write32_hook() checks whether the target register is
> > CTL_SD_CARD_CLK_CTL and, if so, waits for TMIO_STAT_SCLKDIVEN via
> > renesas_sdhi_wait_idle() before the write proceeds. Other registers
> > are unaffected. As with write16_hook, the write is skipped if the hook
> > returns a non-zero error.
>=20
> While technically correct, the commit message is totally not helpful beca=
use it misses to say WHY the
> change is needed. It only says WHAT is done but I can see that. G3L excee=
ds the 16-bit width, this is why
> we need to change the code here.=20

Oops, I will add that info into commit message.

I know you use AI to assist with commit messages but please keep a
> suspicious eye on the results.
>=20
> > +	host->write32_hook =3D renesas_sdhi_write32_hook;
>=20
> Have you checked that all SoCs handled by this driver support 32-bit acce=
ss to this register?

Only RZ/G3L has bits more than 16-bits for SD_CLK_CTRL,
This patch is a preparatory patch and has no impact on other SoCs.

Cheers,
Biju

