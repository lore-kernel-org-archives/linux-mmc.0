Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792762056;
	b=XQUzMO+7D2LZqrAPjChNMDlzTl4boGQ605w0OIKciUGz4hrmMRmDSWc3LiKPkEXuY0dP
	 Vil6bIbUk40PutGuMKSbxoc+yPQ5i+V0ssOXgdpEXD/0rkxNnyIFTvkhaV4xDRgnq0KWf
	 7Egl/UIsqtfble8eHiO8TQZQqbD0i06mjjnhheDUElUQyAkbTfMh8MYApOzPpX2p3aqRJ
	 xLHQacPGzgswPlk7+L1w0ZVr3tHrmLsiAJ/JQ+RbKRDuGQX3wdlGxoNhxS4eW2rh7BJ5u
	 88d9KMd0Cqzfvs6eb1FcQczwaH9wFg25YYz+PLHB3Jn/8SpBaY6C9DT7qkfgb2e/d4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762056;
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
	bh=IlNZD/4PKNMizq8QUWORg3xxNphiO/rkh0zpabn9eDE=;
	b=Ql8thfA0h7qSsbKQh7T+LUIsGazD0LHbj9Mi4aHCKGr0GE3W6p0uADa8Ydmaiq11AU1+
	 Ibrnyrf9IxcwHk+ijFiT9Ukt7TlY01CRLLMwPJzzdAJYPk/8slHA9IWAQgPpycv+2MzYa
	 5SQX0kxZkSmu4+qBB4NqY78WjTcRZJuovowS+KH58+L5W1vZe9wlj8lTiAdZxdPp61DM+
	 rbNzyqtz+rtSJFZnGukOv7B2Lup04GIB8TQBf+5XHpBN+Sfz/hwGNXteEyF/p4WtzJslv
	 p9XKQKTGmIItSbbPBVCASeO4DcClr/AxgFSNveb6QKjxdENj2dP0xMp5xQ082Wty/JQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Ap+Zbj9L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.2
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011002.outbound.protection.outlook.com [52.101.125.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B4D606A31D;
	Fri, 23 Oct 2026 13:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3B4D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Ap+Zbj9L
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJl78gijyp8DiUbixEqechlhiaBFEVQv2rPdkJr4bcX07fhEIA3N7lAKJsBanj4etA+mGvW9Nrs0+FuMo5g57iBMRRwKU4s6cdwdxk4uR/PpWnI3IoVT3+YeX+yjiWkQSqA7SySTdIxelVfIgnR/y/xdvCH2/gk0eRujqc22BbTSgNVhZZmRDChGbeVQeKxCnSPcdax0qjcjrxvsyBffD+qH3dkfOJ4Y7xzxScIHULneJpDAVkZbpZA4SLnY247ssm3UdKEMMEqDxTO4Q2StTfcntvGWJ1izQl3o/9vGQu58xxiFSjr8U80UJA3u2/ENuzJYzb81MLQxA82hJCyJDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlNZD/4PKNMizq8QUWORg3xxNphiO/rkh0zpabn9eDE=;
 b=WZDNE9TLbyu3XeNwMj7TPM/XnJ7DeETDCSI1IRKWvtQ3kJRiHIEcFZIEhX3mN4OJFxauK1Z9iL/5Uk/h5Y3SNNpA3HV/tYrApaYeMmKMf0Au4sQamWsIRbw5krhVfLKVnShArRkxiU8nKijnhMTqmCHR8qcv2LejkjTbKt4FrtHxKgLHwO0ZerrZVTHBaHgM/ONSijvrYAwRqcZE8HnuM7LduXbuQP6n59oyVcLlthpeBtKzKKPUN/2XfafO0y/lRvTm5isWj0qbSmvky800DVKMCgX2JLddQ2uq21gwAwM5KyzWAN0+1H3C3mq1SuxzRBspeDlE5zAEbG/UxxDfpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlNZD/4PKNMizq8QUWORg3xxNphiO/rkh0zpabn9eDE=;
 b=Ap+Zbj9LeKBVkWN/ZHNe4cyNUJmPV2KIBeAgACCsurEKZKFnxZWbNvWOt5JhmcW3LQwfgEY0LW1V24RYXFyGIQPNrLLYGpfMJ2imkJ2x6p0kgTg0kglzJO/jttSpQSvAZlKbuVpRucFJp5aVbbtsgFr342IVqtgMnhASBAyaz9g=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB16234.jpnprd01.prod.outlook.com (2603:1096:604:3df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 13:27:32 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0496.021; Fri, 23 Oct 2026
 13:27:32 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: wsa+renesas <wsa+renesas@sang-engineering.com>
CC: "biju.das.au" <biju.das.au@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v24 08/15] mmc: renesas_sdhi: Add
 TMIO_MMC_INTERNAL_DIVIDER flag
Thread-Topic: [PATCH v24 08/15] mmc: renesas_sdhi: Add
 TMIO_MMC_INTERNAL_DIVIDER flag
Thread-Index: AQHdMMe+SeXRDHnYx0S0S9Te31Iesba8rjuAgAYGtQCARvHmgIAB27Ww
Date: Fri, 23 Oct 2026 13:27:31 +0000
Message-ID:
 <TY3PR01MB113461A5CE186E8A2120B28D886642@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-9-biju.das.jz@bp.renesas.com>
 <apk_81IYqxrWZyJK@shikoro>
 <TY3PR01MB11346EC6636C810EEBA215F4E86B22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <atnRXPLulZyrkp_m@shikoro>
In-Reply-To: <atnRXPLulZyrkp_m@shikoro>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB16234:EE_
x-ms-office365-filtering-correlation-id: 7091dd33-bce2-40d5-8e88-08df3109646c
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|38070700021|4143699003|11063799006|56012099006|261022105027099003|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 xxbmB677bLVVLeTFUHywNEfBnMPiV8jb39oC4VaRLlPvctfrACsw9PiaE3S3133i0iFMZAWmHuNkCcqGOdl84rzrOsxFywDonsrp393YRkV3yBJPAgrYC4ZsO+7Mg7gWHT1uOA+l5sduKfIvqtGqlY2i9tr9HGxoDl2CAB9xb2mRAB4bYNUSTOt2EJ+HjvEh/KwdsMbvDWi6lNs54XFLsE8fSPnZvugIs0mKt2R5u3GI1RTTB7iArlLbh+8d8tpqUHF8s8kMYDTPJvbCOXY5iqMxcxYtd0ewjswsVEIVLsbPfNC0QpmwzAP13jr3VNGNSC9QPH1d5cmm7hN7d5nlRTcQt/3HiiQ3IIi7oxEli10WoBKmoR8JrHh3VIJE5oGFVdcMt5bmZCK2ZkJpCM9FIxvqF/z7BHe+tvHxaYiIZjPfQBmK80GairN7BPc2p1crVtXElS4X0A9DlCB1PB/62d3KFg++eLx/E898Q/zStVPgdysj4Xv1/wRN70syzLNuW0/80XJXWrOviepFsjvXP3IVXKIIN8/9pTtsQm81Y2dW+1Q+iBKceEHDcVP2G3cmXm6nlmNEu+H5ssS5i7ar3H4bwponDVxBXeQc7www3tJBsT4S5iP3KoIBGGPDmAMbcKypZ8dUzWbqQxY9wf81/BVTPpkVlw8Jc00f9ukG4BJp9cJO8sf1D242WlAg+dGpB5l0WmVMGhmXK834CGkStzyM5Y8g/sKf0AWhRjqmaRk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(4143699003)(11063799006)(56012099006)(261022105027099003)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BJEQwMOrcbSStwkC/Sy+ZaLUbX5AprlaWm82+654Fc/CGcRWqRtZSiuUybRA?=
 =?us-ascii?Q?FK4/81qkFMHVNaEKttVQWYNISuSOpisTmbwEmYbK3HnKPFm0sO8BxZ6SexBp?=
 =?us-ascii?Q?3pORHHtBEu2aHB2OQgpEZBXQJOGjyccqJ0BnD4rQyfDTbQ02dvBQ9g/M0Imi?=
 =?us-ascii?Q?rjK1x91vl04wQigSroChiBjVsqEfmtl1FO2met+aQW8KEmW24zxq7He1tBy2?=
 =?us-ascii?Q?5ZA6mO4ZN0p8x4nBJJpyxN2Kco9HRzg/fDE8a2geuwQxZMa32X+3Byp9jg9N?=
 =?us-ascii?Q?4za31rs3gTEnwuvaMSwEZFUuXYor567t5vLQ+v2XKlna2NpmHfZx2KGMQIYU?=
 =?us-ascii?Q?IEVpwMt/P/M7c6HSiOq2aq28fF8p6u8GJBmknQoIJlxkP+MDiFvETOaWCKF3?=
 =?us-ascii?Q?FK5kscoFYRcn93Pdt2fFopi2E7pufowvu8neJ9MQ3jchIY+J6+apKc73gR9y?=
 =?us-ascii?Q?l2eYDjsAiNtLGKJ5xqXoe9C6iboQHipJ7jxgLxC7VnMAidu/kK0urjhcZ+np?=
 =?us-ascii?Q?LYjmCR7+16LPO04WvmITYO/yc5rL0FKiE2CM/wWhMiTGi6kSSH6QkDovHSZg?=
 =?us-ascii?Q?X3f/XFeRya7g9cTmBlT2modW4BZtd/MxVRpr4YeKQvV5B2PZATO7gqJ7UVVN?=
 =?us-ascii?Q?9vSCEEvj7VGjeQmP+qXDWKn/EtbAshGBO7WIFx4c85C1N+SeOSk9nDnncR5q?=
 =?us-ascii?Q?kTbqPRJuC6Wi1pomdGIf5GsIt1jWfTBqpxrrZacg7eXI0itccgAFZuHm61Uk?=
 =?us-ascii?Q?qH3ksvOu/043dhrMXMZbaBFb8jeN10WzYp1YNnXp1OEQsi0HRhEJJD3uXxWP?=
 =?us-ascii?Q?reqhvq+u5K1d3L6OgYkYBbQAjWPieKwE8tPOr7kYGocvrZqRnjIY3DkUhBzM?=
 =?us-ascii?Q?ag70G8RL+Ojmdw49SO2t6dWbAMVghYeNnX8CtnVJiDKSwDYBpoXXHu/jgsSX?=
 =?us-ascii?Q?AD20C8g65dWVY+RuFw/hT4Wt1+0W21+5EZmeeGbA4Sy6WlVCgV0Qg96t5m55?=
 =?us-ascii?Q?+HPvfO9r7JNWnQaSno0P7Y0RJEEe2VneXIXLI+svs9zCfTp9emcoikQ0GqNs?=
 =?us-ascii?Q?A5CVeizwS/uHmcYLgECBb/iyoftR7CdcUknElNAuwhdMdBlBPQd2FcSkJ7bR?=
 =?us-ascii?Q?j9Mlj85T8Zbx1QqzKd1J088yp5L3IRVWgtOod6PFRODA1ZWQsg7z25q/alQx?=
 =?us-ascii?Q?GQlVvEbNjvBi+gAIOQPetZ6SebAyg/oYqp51sptPrrw5zwr8diej50+cJahm?=
 =?us-ascii?Q?SkdjVmWAQwVwJdwuWRUyOXCfrxUVcmZiGpokcJRJ2N50l8dXMYy/mGjLo4K9?=
 =?us-ascii?Q?ZkHQ2sjT9zBulgOJvn/tvKk/fdpb8sY5ihRoHEM2JBVOwqIaOoyb30LPTdGc?=
 =?us-ascii?Q?NiCNBdN//HrJlxTN7Y+rsV3JEGhv8RA8ObXm3XyVBn8b9og7L1ni0h23JS1f?=
 =?us-ascii?Q?UVBQxbMkMfd9BHFexFn6W7hl3X0m44dgb5FvP4hIZsPv0sIsFmSCGv7zvV5r?=
 =?us-ascii?Q?MfpSJ9LVvWVS+F2h0MVxGhG/GW0Azu4uECfpmbOpae++dZRqzn+6i9rs0V09?=
 =?us-ascii?Q?NU3uZHWC2hvzhwKp/gk/0Myvw8uAd09D7EH0dJoIUWjf3CTOXBAkd+QStAJo?=
 =?us-ascii?Q?p0VNP7fE3vRdLozu75uajKeSK1cFdbM3GfDn+mUnJeiR6aAdCnoXRBs8COsk?=
 =?us-ascii?Q?tgxj+B6wvwTjsqCNdG+miDzfNvBHFvqfSA7BSefixAhYtvkYHjtEs99Gk3AQ?=
 =?us-ascii?Q?IpRRke7JRQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7091dd33-bce2-40d5-8e88-08df3109646c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 13:27:31.8784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sv3gDp5bDU++0HI9t98Dn4ZZFHUaHaW1xgHmuyGEInYvCpOBPxeAQVMk3tAn5SvxbEd5DP+R9jmxHiEnmkJOfM+8KL+0LezsNPL2rzz6fUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16234

Hi Wolfram,

Thanks for the feedback.

> -----Original Message-----
> From: wsa+renesas <wsa+renesas@sang-engineering.com>
> Sent: 22 October 2026 10:03
> Subject: Re: [PATCH v24 08/15] mmc: renesas_sdhi: Add TMIO_MMC_INTERNAL_D=
IVIDER flag
>=20
> Hi Biju,
>=20
> > > > drivers/mmc/host/renesas_sdhi_core.c:renesas_sdhi_clk_enable() {
> > > >     ...
> > > > 	if (!mmc->f_max)
> > > > 		mmc->f_max =3D clk_get_rate(priv->clk);
> >
> > The SoC with TMIO_MMC_INTERNAL_DIVIDER has always frequency defined in
> > SoC dtsi and this condition is skipped. Please let me know should I add=
 a comment here??
>=20
> "has always defined" is not ensured currently, or?. So, to achieve that w=
e minimally should
>=20
> a) make 'max-frequency' a 'required' property for SoCs which have an inte=
rnal divider.
>=20
> To make everything more robust (and IMHO also more understandable) we sho=
uld also
>=20
> b) move the above 'if (!mmc->f_max)' block to probe (as 'f_max' only
>    needs to be set once unlike 'f_min')
> c) bail out in the above if block if TMIO_MMC_INTERNAL_DIVIDER is set
>    because it then is required. A small comment explaining why will make
>    it easier for our future selves ;)
>=20
> Makes sense?

Agreed. I will update the binding and driver.

Cheers,
Biju
