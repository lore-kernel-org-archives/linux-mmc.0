Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794408136;
	b=LYGFBdTGIpAz9RZAzQXBJm6iaZK7gNwmnnLhiY1o1dMoSg80RafUc0K726cF5OD/hom0
	 UL9GWBVuUh53Gr3vstxI0mDnWBK0fy8Ogj1CJGc34/cs2p8RyLrBxNRKLN5Re2qpMeul1
	 51YoOBLK0IS92DmWsShFSJecqCsfcpVrYgB3vImc+OIXlty3U7OYopkCkmzs1YyBIypwe
	 XVQtpl6ovAozCCn/656EqjTUFYBvjkMD9f1bGcDy/uEW4ETp/wwz3NN5gvHkJJGXKQPSd
	 z9IyNZb7Ktf8jU5jaYBYnxZJkKpaz4CfUZbwfPDsuHJeuKdUq7tdYsGwUx5Fr5qeNdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408136;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=4+Irat6nFB62ZQ5zBniOr2/LqEj+DrNIptLLT4jBJrY=;
	b=rzDWC8me4xtTICDtd3dEJXEhJNkKi+GEqonuctzKpw5M2gCNXwafPWBkfqJ1RAkDAGZI
	 b5krYzjdy/WNSkJsnd8DzIrQEHPJxJa2Q91Hl8yMHp6HZrn97kNCNkIfZP1Sv80yvQ/01
	 nkUgYzRdiapJD62Er183T00ELVDPLSuw7ESeg751ZGVCUyMBREpaWRPgp98Hl0vVGPrGu
	 ftu+1JoBrf1Q2Q41m6MSU9TSjZy11DmfT0UEUgdnC8qEPD8jywjvMqCGRE1TKL/x9T9yh
	 5pcV+WTM/+PuZt4ikDL1U0QCIYFAB8Syuh2ITUBxGjud/C4xcdErsriQ3l8jTh2UmwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=UUhcLZNP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.35
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010035.outbound.protection.outlook.com [52.101.229.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0610606A321;
	Wed, 11 Nov 2026 14:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0610606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=UUhcLZNP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yiFkh0qyKrMbpbq2BmhOcMZ9czswwa+iIRL8L/FWhGCmbvdaebie61MwgyJYIzCJhUu0LemT2Gb4N4I1L7rmS2I110NWjqZwakp1Fzs62vGrkk+bcKZ0sV38YRzwAu0iwyMUwNgPiEdLFlATFEb+/sF8blc+cX9OLFJ0LNJK2lB7SRYVTUPcnmKfUlYRtCshX4Tmcbd11gbobvXzwUNE+yRLhYtk/M4Oxn1AwW3d06wca5z+DoybvLkc0pPjRIv9axmcZ67mgXFc1Brk6i4eZVM9NUNOmu+XddKBwJN4kiusr6RzvPSRT9y2mr2PXnwx2c4Fapti0gpfksZZsxJWyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+Irat6nFB62ZQ5zBniOr2/LqEj+DrNIptLLT4jBJrY=;
 b=Qc7S4E0C6iVSOf5kKfPAZUV64EExC0BWEmw0/4PKPpkD3eEYLLhcG2h27Ds4vGPUCkPOlEMjSUF3YRIGDQW/MQZ74W3pY2K4atC1XWtI06SohPCQSTgUbLO0wFLqDol8wVpIe0gIyvORkLkfrxbaCZyz3G6ZzC5/UWdnSydXwcQfyd4piewNSGJIJ9jn+u7H5RkYT9y7VhNrxJ25FtI9LXdgA9OzmwHsM4WqO9sGhIdc6XkaqXH3oSLd0nNgZRex85Bjk9/iyjVfV+EROnI1SxUZzCjNA6ZgYSRf1VQRTq8tIPiYuwx3NR1ZTFyUOfuaO65MwU46INEwA6vd/cRa3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+Irat6nFB62ZQ5zBniOr2/LqEj+DrNIptLLT4jBJrY=;
 b=UUhcLZNPR4pTXI/Xr9mT9wHtk3DmZReUhrT6D38QBT3B/eFQ2oI00K8zNjB5P8a7Pq373OWfoYwi3jOT6k2O8+U+ocx0YyK3n5Y3g/m5p2twAUop9HnEVotrAcGrC4AieWZ57O9Hf4P3Gp7567Y6jT4sWubtZYIdgLQ+eg2L8lk=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by TY5PR01MB18237.jpnprd01.prod.outlook.com (2603:1096:405:3e4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 14:42:04 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 14:42:00 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: wsa+renesas <wsa+renesas@sang-engineering.com>, "biju.das.au"
	<biju.das.au@gmail.com>
CC: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, "magnus.damm"
	<magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: RE: [PATCH v25 00/11] Add Renesas RZ/G3L SD/eMMC support
Thread-Topic: [PATCH v25 00/11] Add Renesas RZ/G3L SD/eMMC support
Thread-Index: AQHdZtsKIVdgUVrim0CV11eBXE5E9rco13GAgAAwFRA=
Date: Wed, 11 Nov 2026 14:42:00 +0000
Message-ID:
 <TYYPR01MB6603343EE1D9AF5140FC080286712@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <20261028-rzg3l_sdhi-v25-0-57f16691c2ed@bp.renesas.com>
 <avRWDN43k3LcFVRa@ninjato>
In-Reply-To: <avRWDN43k3LcFVRa@ninjato>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|TY5PR01MB18237:EE_
x-ms-office365-filtering-correlation-id: 09dccdd9-f078-4708-27be-08df4001f1ee
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|38070700021|10067099003|11063799006|4143699003|56012099006|261026121527099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 neRdEKkPifY49jo+5LudlAY26N7o9itZhRxBn63kJx0aM26JUlzb+Xgc9xfheNyblPjB9/ADt0uW6nmjR120MqAiB1vFg1g4tbabXpfyv8F8KK8yw1iCZCn7QNhi8SIiKv3O6ZVKMKxog8RRhXeDOP9gcjxe6MOUuD620Tj2vq+LXegxi8qbIDHtc65AQjvGnD+2d4KDkDZQri+J2YJVA63Z/347sTHw/rXeDO8AtiGIac7Z72rAHi5prfUe5BgAUP9wQiS8bOoN6LVA4DhdxDoLuVELRXTJMMUwLpFbzliyPYrIiNmFZkQHsu1gKhjVKlPF1hktlFKBHbtotCXVV9Ic9QezwJg8QbUtk0QNa5W5U9iJphLF44iIte7MEjjnjz+GUQ/IAl/osdPU9KnX5Om+nMRiyWk8nyJvwQ0x6Q4vJ8nyc9DUc8sslzSjL5NTxx0Wg/rkrGLdg/kG5c5DTxhY50pgnrIGpOOB5eGdroegHaaOYW56bMFYS2JWi1g7Ld0mhcYgho4aSqBnTjRNuv8xJC59WWfs5FiHInAYN/hARreIvCDs1EMGXxuEhaCanZsmhVbE78QYvYlu1WetGRJ8bxJ1qI/YVKiYVUMXwmng2LdWYv84Wkq8tixrDtChU41MbFGLxh/8rn6UQk8SZ17u3tg3ERbifHio4bPsaPIODyXbR+CMBn3Ue4hWBb6z8kpem5kl7ugZZx7H77gPsw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6603.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(261026121527099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IOEcUyWKy2Oodlb6T+bMhn9F99M5osYR+PCo9UMMco5cuBchmVewUMjJdjDG?=
 =?us-ascii?Q?yJ3J4BxJUxvHYsOKKgYN1d9WDu4XETUKMwhZeAmlOkI4J3OJb+Rsuf+9b0vJ?=
 =?us-ascii?Q?mIcT5mPYVHaUi2pThIS7aJ8/LlwfaavhWdpYfet7EQuaPQXZViV+fdC8L8JK?=
 =?us-ascii?Q?r5aykZ+aWBhaNc2b3cc7DviRy6IbLcjd8rbFcSIQddsQlZySBC65t1NSf3uh?=
 =?us-ascii?Q?UX04nXsDR4MvOVt4AjhSCgm3t4+W3PqefM5JN38LxF2ApT9UwpnnDUex7+pD?=
 =?us-ascii?Q?MOa/180ZDe6ET+et7a5suu5NNDHCkjskW4tGih58C444Wc+hCVyq6bMHH4LB?=
 =?us-ascii?Q?Sif0Op3KLSDbBeQ7VE7KtLDYEiumtcoFRZtXoEMHoVq0b0IxhmcPiaPLqzdF?=
 =?us-ascii?Q?Zu8wWKma3+2qSXyHnZL0BU/HONcZokPAeYAL4fLbDYB4QHGUB1BcDRAwZgzN?=
 =?us-ascii?Q?Zlx46nwtq2EtIssGE14AGOq6SYzEpsE/wg0rF+TzTA3bb8wLpbSOFJMJv8ZI?=
 =?us-ascii?Q?z4/pdnXenV5BEM3lUXhZjQkoUkG4kaGSCxpkGnR+lgH4WD9LKA2BnQ2NPV0/?=
 =?us-ascii?Q?+IaccrX7DEJn/0ZSqInHlCmnkcBPQl5MGYT8GgeKYp/bx41QBoQjiUrrpxQm?=
 =?us-ascii?Q?wgMgswdS0ZtOJDxMFkI5e3wspmt9EB9bI68TkZYhZJODhkJHU2Q2vgHZQ6Mk?=
 =?us-ascii?Q?jJZq95YGtPvHyZzeR8UEBOb8kAYIWIv68NGYQuNbB+9hwUerD/AYRIgwdc24?=
 =?us-ascii?Q?9JHH7J5wI5qGqNjKHFw8K0XGUUVPSqbO2s+1lEUHYUaI4yOy6elxcOkejJn3?=
 =?us-ascii?Q?AiIgrxs6vtwbjuMSNRCwoYNbzGii3t/f0hQh1cqybViwV4jzZPTO50cOe1E/?=
 =?us-ascii?Q?A0kYJLzzgmWg0zn1cnZzwEtxxqK8X1V+CkOzCMlnv6U6aP1u+tKpVk2+Ee9Z?=
 =?us-ascii?Q?k5qaEnXPoe1ux5ivbt+UthZeikgFoF66vRRnkl68UAbjEekw/wLrsZZoA2eb?=
 =?us-ascii?Q?RpkhSwara5D7R4E3d3MfCeMJzqBbe5osU/tNScaD1yFmQ0nlIWjD47QtpVsc?=
 =?us-ascii?Q?93QavZ+5cxn0ATv5hN6nUmFEsVxOqwS+ug/n0ce+V2xyfRfyVaZi/t0Lo1e1?=
 =?us-ascii?Q?DX6r5sFeKPlmB/+qXPNMgODckl9LvfNud8YLnjv7W1bRGoLag+pxHOxLmUfB?=
 =?us-ascii?Q?jURDgYfjI/tNpz3PS1WaqAwEcQDtFivcVIA49cCeAgGoMDVZ3iorUBTXOW/Z?=
 =?us-ascii?Q?+V5yaCCD3b2Nlz+wjzmyYnkbXePswseiq+alz9mWQHGj1fWTcCPLoJeTHxGB?=
 =?us-ascii?Q?RUvgGwPIRTFqP2R0VSDcf9ZPSl0I4XwvIgjhA+Z5rKZJr2sZ3DvCp9hASVLd?=
 =?us-ascii?Q?Vf0EaxEJ5xeWwz+IqiQ0f/hI/UnDEWbU3f51HC7+KsPkY/JJoqZUkB7uE7Y/?=
 =?us-ascii?Q?AgnR/bu71vfDmjyzVoqZ5Nx9AbO5meM74YIVg9kp3+jvuG/pshhJSopz7gN7?=
 =?us-ascii?Q?cw3bO3etpp39aubDoUu9SCFMa61XH+jC3KAO87zWK/E3BPnOHbQmL9GTI69/?=
 =?us-ascii?Q?k57FXPSE69k3H2Yl0cYuWVg7z0BoWKlo3z6QNDvbXuRlxzuLJ5xP+e2HjQ4P?=
 =?us-ascii?Q?nzqSk6PUmDZULCaMfHxt0mxx95xGyhKAxn2iG9VCo/QsmBr+3LozqApzdbMI?=
 =?us-ascii?Q?kMI6kRhMJVJ+fYfgtUBZLqbf5AT2kK2IJylG0viQtVeCintzfeJYZJLeq8cQ?=
 =?us-ascii?Q?/T5IL6hVUA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6603.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09dccdd9-f078-4708-27be-08df4001f1ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 14:42:00.7495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DIaFEeJ05x4FnpONBQNS76gdVIK2WaxBtO0Q9RvPw05uCxHObalf356h6MEquk5y9+sukBW7Cd/7/CdeLVKGlkb3ox49RSnkeQQJN3XSzfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB18237

Hi Wolfram,

> -----Original Message-----
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Sent: 11 November 2026 11:49
> Subject: Re: [PATCH v25 00/11] Add Renesas RZ/G3L SD/eMMC support
>=20
> On Wed, Oct 28, 2026 at 12:51:17PM +0000, Biju Das wrote:
> > Hi All,
> >
> > The Renesas RZ/G3L SoC has:
> >
> > Channel 0 supports SD and eMMC (including HS400/HS400ES).
> > Channel 1 supports SD and eMMC (except for HS400).
> > Channel 2 supports SD.
> >
> > The SoC supports a maximum frequency of 150 MHz. The SD0 interface
> > does not support IOVS and PWEN in the SDHI register (no internal
> > regulator), unlike SD1 and SD2. It has an internal divider for all mode=
s except HS400.
> > It also has a 2048-bit divider compared to 512 on others. Moreover
> > RZ/G3L supports HS400 enhanced strobe mode.
> >
> > This patch series support all modes except HS400. HS400 support will
> > be added later.
> >
> > This patch series tested on smarc-rz{v2l,g2l,g2lc,g2ul,g3s,g3l,g3e},
> > rz{v2h,t2h}-evk and hihope-rz{g2h,g2m,g2n} boards
>=20
> Tested with a Renesas Salvator-XS board (R-Car M3N). I don't see bugs or =
performance regressions. I
> think the series is good to go!

Thanks for review and testing. The code is much better now
based on your review feedback.

Cheers,
Biju
