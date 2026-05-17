Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931054502F
	for <linux-mmc@vger.kernel.org>; Sun, 17 May 2026 06:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778998021; cv=fail; b=YpmmiiPdkq08ImYTe6vItgAvc/97zh3laIYrHyUBREChgdq88aLUXzVUu1sH/kHn9VbiU5aTNrb9qsmTA4/tNmOWLqR5DJgo5Fqkd9Q0zDiJFsIkdiw9v6DxPdgiZYGQnJKcxOw3TczLVAFtcBtoO1GWLIpEuiqm1aHQi5sUsf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778998021; c=relaxed/simple;
	bh=L6sZveUpAdkWdBiDQPyAZ5yI7qvrYG1lGX1mv3YoMw8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bnw35sXj6cilL2/NYxiRQxdfBPoVwO+Xtwe3UiG/PgaWwZOzIDLgHXhcAi6mJVDE9Dh3A/vFnge00pJMf7rQ1E1jvRG8K3IH2ZTyXIEt3vBDn6lwu/fB0z4ZxjAb7GmwgSPneUav3FGJ5HJUr0S51RvJW41+pMzIk7sCeNaOG4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=v2Uip+mE; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="v2Uip+mE"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1778998019; x=1810534019;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L6sZveUpAdkWdBiDQPyAZ5yI7qvrYG1lGX1mv3YoMw8=;
  b=v2Uip+mEGMV90cSvJeMKJ1Wfrmgp6rQH4nCdSBzZmYhBCAKRPxrkl7Zu
   n0fWxpf6RAHAlwSymlvLzv8NKAsorzkVB595cN5BehzTbXR85uk6TZCb7
   RqyBaqhWXLXHK4GgcDh1kxrByd7e2+oqLN0tknqHHgYyF0onv3+nsoP9j
   AdX+94gpjJqMHr0NVdtbdurJTD8DY0Pnh6dw6ROgKb+Na3M6c0hxq7jpJ
   9qDekVOPS5OIXTGEsHXbSQwIPSP4el07jHns+jMy3OcxVew0Wi2Fj5gDw
   Chnqc13PINqfJyJDlwj5JFX3QqT7HqoPq9q9mzs6PBscia8vNEUEx4I4R
   g==;
X-CSE-ConnectionGUID: eB+4QbhWRwaleMITS7h23A==
X-CSE-MsgGUID: 60NyzSfNQYCnAESKpLITNw==
X-IronPort-RemoteIP: 52.101.56.7
X-IronPort-MID: 22821635
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-eastus2azon11010007.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.7])
  by ob1.hc6817-7.iphmx.com with ESMTP; 16 May 2026 23:06:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wdq4pxzYjuJYYFkVE4VXFAQE9MiEce0ELAWFejmzGK7IOgiJ/TStmk3/0S7yPclC9+Pgx1JHFMvTd3HeiOMWEEhfZtgD1Bp71D8Kt3gFfQJT18Yn2pN5BAd2fpZMSGMqAzbAmSRDw+ks8GfmH0QxwFgxAu4NKgB4ATOEpiRU2gSqIkrnzbqmoFbjGTg8mZd9xVs68V5XdaGRiZmuRGAp0a7PwbckAoJ0R/7mpWpseTMF1kWgmE6pN7bIIEeZ9GXK/DMEJA2iRCIhCkx2cpFkX5YCgZnr1hLC1N2LHwA78/6nDmpkBV/wneOTfhe+9l6NeKmUc6ryO1LwZDCOIDQ5YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Tkyou4DI9kYslzzbSHcx8KI6xC9j2DwTZMZZYN/Cd4=;
 b=Cjbdl8X1VWvqZ3Qw2YhdNhe1AAtkPM/h7eTxsEOcGSQ4fNHXrzDB9wnFNIf3liN7oy6J6afFfAAnDfOV9CaPb3KeryF6Ri+DdSU2YgmZwHb8ME8P6xsQ1yfzKyjB8FkaKbqkOX0JsZe4P2V3mZFUrBf2szBBDyWwwKp0ymTlYrQt5VGLV9zhN1XbZwE23bHK9unXOte2APnhktSmj+aHJaSPRyQ7JxBhQ6aC8/QM7Y8r4ulUy7wB5joGhwf3cijUOXp/818cXSzOELwkWJ7vV5E8iQRbBgtsCgb7hSA0LQwUknhLkZ2dGUhXrdGL4CpXzZKkAeqfidh8sErIy3WroA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 SA1PR16MB5942.namprd16.prod.outlook.com (2603:10b6:806:3ab::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.22; Sun, 17 May 2026 06:06:54 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%6]) with mapi id 15.21.0025.016; Sun, 17 May 2026
 06:06:54 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Avri Altman <Avri.Altman@sandisk.com>, Torstein Eide
	<torsteine@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Torstein Eide <torsteine+linux@gmail.com>
Subject: RE: [PATCH v2 4/5] mmc-utils: lsmmc: Add mmc list command
Thread-Topic: [PATCH v2 4/5] mmc-utils: lsmmc: Add mmc list command
Thread-Index: AQHc5LMxw1uUr63rEkuzcWUJIq97pLYRuZ+ggAACGxA=
Date: Sun, 17 May 2026 06:06:54 +0000
Message-ID:
 <DS1PR16MB675371AD8EDF1E70DE5070E4E5022@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20260515213747.1452692-1-torsteine+linux@gmail.com>
 <20260515213747.1452692-5-torsteine+linux@gmail.com>
 <DS1PR16MB67538B5E159FD215CF4E9598E5022@DS1PR16MB6753.namprd16.prod.outlook.com>
In-Reply-To:
 <DS1PR16MB67538B5E159FD215CF4E9598E5022@DS1PR16MB6753.namprd16.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|SA1PR16MB5942:EE_
x-ms-office365-filtering-correlation-id: db9f4b64-23d5-4887-6541-08deb3da7e9d
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|11063799003|3023799003|4143699003|38070700021|55112099003;
x-microsoft-antispam-message-info:
 NlpcE9Z4eNT7BcSC+NwFaaB35DEih5YfhKawoXCih1EkPKV6gJRL/ivFHPJd60nkkgd4HgsNGpCAdgSjkLE79VZOU19qfqYYJJuVb/2Wkx4N//985zTug+whoELURYK0lbzfc1RxcazTh8meTq1jYwXDcyHFlIvP6ZHyywpuCLs88UpJXOSpaBTSIW8+bAqqUwGhrdG+Dr/64W8r3y9LOpvuAFx9hhmCBYuPFC1hPJnu7uK3wwAVyM7SYB2x9GJIMTe9mDuvhzE+Lh3FA4oZWO74bHQeNQHFMcJ0Di3E9H+D3KmJv5+LHwC08Mon25yklUTi7pdPBDQBnRmqOYY14EftS41hEPymVSgYdSPT4RrLI1YppiNLfICWnczyO18n8/2aBuTUyPexblOzAq7ntuqGFDiIt30RyGn9qbDa1WPdLd+Uhwnm8F5q4tDkMl1FXWudIyFmz+b/QRgN2lmcsCHYk+DN09QKaONiwnwVtuGYLmEvqJz5hfQsvCxRQpdQSuXqrlgL0mnG6Bfe+T1GwFiygMxpF195OY64eixqbR+zRd0GVi81SWCir7avsk9EELKWfwaiAomRlfYWv/E53GxdWznOeKhy2nEWjjSw8Xk/BgsjX2eNo0TGguizPpOsFUcUnn1BNq9MNr6Xwqt2uxjdv3VFR6b0RayxHfXzeds7VWV6kyrKH3hi/xm/6vCxjPsjceQJpeUlN5FevyDfmLQt+h3QVnmYht8DcDpTzkC826JvgTPYKNdgnLRJw40o
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(11063799003)(3023799003)(4143699003)(38070700021)(55112099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XVCJefHy8bU6AmB7EeD9xJrJAC/mEAn4uQhXwEI1HUcpCKcQROhnbgyNcAhz?=
 =?us-ascii?Q?V/x3cV1PyXiB/jBjp1XYPDU7YQwtHOaEUl/+0KWFFBz7jek8rAkitDIrB7ir?=
 =?us-ascii?Q?uTD47roo3rmax9KFcmsLqlguMYRq4CI/Gs3YXfm2oXfyRKjfNSfI4W7saWgf?=
 =?us-ascii?Q?cb9knI09dWGumi3wu2kvcWQ6aE6rscph7dIqoO165Mw4BencYW3VmHTFacuD?=
 =?us-ascii?Q?Bb/9+mgtWvO0TQ60fqkvNYxk30Hti7wGCvnHBdJa8+lvZZXM350r4EjYZSZx?=
 =?us-ascii?Q?QH1PP/tl15WgSjOGnChiQi7CeCcjYUemtLQbjnTDyEmmgfkD0fiars7OSeDM?=
 =?us-ascii?Q?paRfd71wx1KmNB2uHTs/EKMyyM9ezCYpXyRemcDygPdSEBFOt7rGjpJ1iVZt?=
 =?us-ascii?Q?iHG7Bj3MfgSBQpttHCRLryRs+UgaB72PcsH7/v6Pv1aNIY486fjAITfbxieD?=
 =?us-ascii?Q?2ZVtmObP6tKChm1oAFyk3pPLfraeOWcVXKrCjOpkx75FnDx4iJbr6iQ3/4h9?=
 =?us-ascii?Q?Oy/QPul0JsZfevaZ+mHNzQhnW2iVLG1R/t1frh4G37PckMO5MKVEqfp2rrpP?=
 =?us-ascii?Q?TUsClMCeyqCHg1JJow6VbGrGbZPIloV3IFQTmdsjqV4/bobmnfNNpBGJ8R4m?=
 =?us-ascii?Q?HrlZnLIpQtsfpmFfPVfMk02xQkfvENmnYJ31lpAcG+sja+xBy+FQqzy3zOD7?=
 =?us-ascii?Q?RFToiHpYQF5bUm21RsiQaRTKcHTIBCwpS9nzal9IDxHEky5TtVZiSoINCD9r?=
 =?us-ascii?Q?lVM6LbEmMUU/ftANfQK9Cuzy72VO1AGuAbQX6T2fmC9LsKZxn85oiUOV9TMs?=
 =?us-ascii?Q?DCfp8y+smsJwBtd4cYASqciMiVz2YCajNVP3PljPLchAiMfxAw5nBy7Mi26y?=
 =?us-ascii?Q?a540H7cy0eZYSlTcVTTOH6k7arPHd/0y15HlD6Piibyk4mPNBflsXOh5sVHK?=
 =?us-ascii?Q?DraVM6uKOPfXDa+0zijTmmFBz9lyJsPXI3qBF8nMk2Il732fLQ5oqZ5XbxvW?=
 =?us-ascii?Q?k+wqAwntVf2hklxfVge2xadf9XC9oLvVEwmUXgeIeiNWp+MEoKUaqdXfAcCo?=
 =?us-ascii?Q?fexWkaRX/9C69DSYlwYrM4c/JJTt/gqQQeBXxWQSH/YUzvoWYJ6/wY7HT0PT?=
 =?us-ascii?Q?KKhlI065faQVe0xmTBYm5gePtZEoih90Sodt3SUgeoUC7T2dVi7r9Bt88dUC?=
 =?us-ascii?Q?UiliRC3MW9tvy71y8IOdCy4klOAAv/tHKL6xbitmDJATSKZt88z6s5f7t5Py?=
 =?us-ascii?Q?lnLzQMqxKxE2RbFRhbAdH9NPb9p+Y2FjNv9CTNP2HgWELNn18QVs6jjQOphe?=
 =?us-ascii?Q?9ZOzXsLoAmnmsvDYupqup1ILPBmWHCN3rpNCkrqUHdqAlGnx4vRoj2BsSWNm?=
 =?us-ascii?Q?7AaUMEBOn3mzLuYpTFzZ2pwppJ/xaiK/yf4HKlGLHFFdO3SiSFmO9NvxD1fx?=
 =?us-ascii?Q?3m0mlIhfQgT+xQPy8kNF0KszU2QmaTjIdnWSONmz3EhqwulwEW2WqlXW8f5o?=
 =?us-ascii?Q?jBQnuh0q1v4/Ag4Yu0DpFs9UWu/35fmwRvQBi6ECDHVn2pkmazrWAF95h1Bc?=
 =?us-ascii?Q?FU3zZZ5liR59PpzGdTZEXGWxQ0YexeFdk6iYsxVKhC04QRfKKC1a7ehwtNJJ?=
 =?us-ascii?Q?IjlJzRcIhxLomiWlxJLqp6xbawWiKuSypIGTUzZupX4FSbPP3esRxMsyces5?=
 =?us-ascii?Q?91HajaoOLQyCdLhTXb6vEJO5LMeMzd1X5K4/btABEMT4+Q+hn8p9rDcZ79CE?=
 =?us-ascii?Q?jmNPXxWlPg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	oef3tmUApTWOeGMaDxQ8LkECK8fcBaaEFadZA6bjyOHBnmWxPlH+VX0rLeG/K7/UT1+CxiFmCq2MPxDkIFfsj8rTOKy2bz7n1HP/h4IRfuWTAPKZ9Mk36FafhssPm65TzP03EyrFUEPdIBISVEA9k9d/Hl50NCzNJiqUqbTMi2b1ou1f3M0TayBB36JqcsJ14VmjpwfolS7jfOBdgdECdGqG8U5PRfIRtCVwmZvXTQvRtOap8PFJZ3vlF4Ped3A9+m1XPt7GnEPxZ3/9D8+h/ml/dFMnbWKUGEEH7MjW66DyPCH+kW8Y5H+C4FJd8g1O69ObWSK1Yb5zWYstUo3kcQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	coX+jHn2VwJT469FrnyyQgKOG/3FIHcuptWJxiYEmeRv2YpX9YgaDIrT1/t4zGqHONXIaJRqImhPbpwVzqKwp866V72ecsgAz8ANfC9nGuOfrRUAKcc+PyHJjAhEGygX0+C2OvZAZ0zwcyGR2TUXXbFe5IZ5vaa53AU4DbBz5/2qgTEeMqVGeApO6Z1ZoCI+ACH0j3ESgs3dhTz6fI7cMJ9C6OuHPqadfeRSAgHFFJ41bd226f9SthNmJbvBjfvlEt2QvQ/WhVUQMdIvKBfZaBpKGZr8f78kCqOQKl1EaFvtIZ++WcbKtmORkIiHhQ9UEX+ZiSEhJQofl46ZVIdYWlvnJesC+xuZgq1Y+RWpPa0b1xMydunoeg771KCEBi4mB1VnOiP2xqiKQKDstegGeFNYMv66Bjwfg4VLipCe5Icen+tPz4B8xQi35hcwYCPbkyNLZVZIWFTEf7HuJtn+fj8L2BGvWnwvITfYxzOr+6DGeLCVqCHTgaK8n5H1jvNNdV9OoRjIpTyBGnRv5f3EYZag2iQvO7F4ItNiudRJfUh5G2Pez+XXQGiT2McZy10E+Pg19jzhwuWYxhoZA0tHDyeVW51CuKBqME3Qrry3gK+8A3h/L8xtHPuJH/QsNgOy8g9WByVujy9MPYaiFgJxmw==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9f4b64-23d5-4887-6541-08deb3da7e9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2026 06:06:54.1618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U1j48UzKKaAh9f9BbcqJqXfgjFS1Up0YgaKMjyflU7KjwvUw4dpijXYkTRc/9Rgu2PMeB1DaXi/lp3EHFRk52Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR16MB5942

> > Add a 'mmc list' command that scans /sys/bus/mmc/devices/, resolves
> > each card's sysfs path, and prints a one-line summary per device.
> >
> > find_block_devname() maps a sysfs device path back to its mmcblkN name
> > by scanning /sys/class/block/mmcblkN/device symlinks.
> >
> > print_list_entry() parses the CID register and formats a fixed-width
> > table row with device name, /dev path, bus type, manufacturer,
> > product, revision, serial number, and manufacturing date.
> >
> > The header is printed once before the first result. Devices without a
> > readable cid file are skipped silently via access() so unrelated sysfs
> > entries do not produce spurious error messages.
> >
> > Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
> > ---
> >  docs/HOWTO.rst | 12 ++++++++++++
> >  lsmmc.c        | 34 +++++++++++++++++++++++++++++++++-
> >  mmc.c          |  6 +++++-
>=20
> Looks like you are missing the do_list body in mmc_cmds.c ?
Or in lsmmc.c.  Either way it is missing.

Thanks,
Avri

>=20
> Thanks,
> Avri
>=20
> >  mmc_cmds.h     |  1 +
> >  4 files changed, 51 insertions(+), 2 deletions(-)
> >
> > diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst index 76214a3..167a153
> > 100644
> > --- a/docs/HOWTO.rst
> > +++ b/docs/HOWTO.rst
> > @@ -90,6 +90,18 @@ Running mmc-utils
> >              sysfs:
> > /sys/devices/platform/fe320000.mmc/mmc_host/mmc1/mmc1:aaaa
> >              SCR Register: 0235800000000000
> >
> > +    ``list``
> > +        List all MMC/SD devices present on the system. Output is a tab=
le with
> > +        columns: DEVICE (sysfs name), DEV (/dev path), TYPE (MMC or SD=
),
> > +        MANUFACTURER, PRODUCT, REV, SERIAL, and DATE.
> > +
> > +        Example::
> > +
> > +            $ mmc list
> > +            DEVICE          DEV            TYPE  MANUFACTURER         =
PRODUCT    REV
> > SERIAL      DATE
> > +            mmc0:0001       /dev/mmcblk0   MMC   Samsung              =
MAG4FA     1.0
> > 0x1a2b3c4d  2021-jan
> > +            mmc1:aaaa       /dev/mmcblk1   SD    SanDisk              =
SP32G      8.0
> > 0x5e6f7a8b  2020-mar
> > +
> >      ``ffu <image name> <device> [chunk-bytes]``
> >        Default mode.  Run Field Firmware Update with `<image name>` on
> > `<device>`. `[chunk-bytes]` is optional and defaults to its max -
> > 512k. Should be in decimal bytes and sector aligned.
> >
> > diff --git a/lsmmc.c b/lsmmc.c
> > index 58d4609..0458d1b 100644
> > --- a/lsmmc.c
> > +++ b/lsmmc.c
> > @@ -225,6 +225,39 @@ static char *get_manufacturer(struct config
> > *config, unsigned int manid)
> >         return NULL;
> >  }
> >
> > +static char *find_block_devname(const char *sysfs_devpath) {
> > +       DIR *d;
> > +       struct dirent *ent;
> > +
> > +       d =3D opendir("/sys/class/block");
> > +       if (!d)
> > +               return NULL;
> > +
> > +       while ((ent =3D readdir(d)) !=3D NULL) {
> > +               char linkpath[PATH_MAX];
> > +               char resolved[PATH_MAX];
> > +
> > +               if (strncmp(ent->d_name, "mmcblk", 6) !=3D 0)
> > +                       continue;
> > +               if (strchr(ent->d_name + 6, 'p'))
> > +                       continue;
> > +
> > +               snprintf(linkpath, sizeof(linkpath),
> > +                        "/sys/class/block/%s/device", ent->d_name);
> > +               if (realpath(linkpath, resolved) =3D=3D NULL)
> > +                       continue;
> > +               if (strcmp(resolved, sysfs_devpath) =3D=3D 0) {
> > +                       closedir(d);
> > +                       return strdup(ent->d_name);
> > +               }
> > +       }
> > +
> > +       closedir(d);
> > +       return NULL;
> > +}
> > +
> > +
> >  /* MMC/SD file parsing functions */
> >  static char *read_file_at(const char *dir, const char *name)  { @@
> > -2335,7
> > +2368,6 @@ int do_list(int nargs, char **argv)
> >         return 0;
> >  }
> >
> > -
> >  int do_read_csd(int argc, char **argv)  {
> >         return do_read_reg(argc, argv, CSD); diff --git a/mmc.c
> > b/mmc.c index
> > 077e901..01ad181 100644
> > --- a/mmc.c
> > +++ b/mmc.c
> > @@ -292,6 +292,11 @@ static struct Command commands[] =3D {
> >           "4. The MMC will perform a soft reset, if your system cannot
> > handle that do not use the boot operation from mmc-utils.\n",
> >           NULL
> >         },
> > +       { do_list, 0,
> > +         "list", "\n"
> > +               "List all MMC/SD devices with their /dev path and CID i=
nfo.",
> > +         NULL
> > +       },
> >         { NULL, 0, NULL, NULL }
> >  };
> >
> > @@ -567,4 +572,3 @@ int main(int ac, char **av )
> >
> >         exit(func(nargs, args));
> >  }
> > -
> > diff --git a/mmc_cmds.h b/mmc_cmds.h
> > index 407cbe6..508776c 100644
> > --- a/mmc_cmds.h
> > +++ b/mmc_cmds.h
> > @@ -49,6 +49,7 @@ int do_opt_ffu4(int nargs, char **argv);  int
> > do_read_scr(int argc, char **argv);  int do_read_cid(int argc, char
> > **argv);  int do_read_csd(int argc, char **argv);
> > +int do_list(int nargs, char **argv);
> >  int do_erase(int nargs, char **argv);  int do_general_cmd_read(int
> > nargs, char **argv);  int do_softreset(int nargs, char **argv);
> > --
> > 2.53.0
> >
>=20

