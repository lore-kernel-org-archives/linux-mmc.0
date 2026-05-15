Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DFB35AC1D
	for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 07:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830684; cv=fail; b=b3jPV5n/XVlRDSJGzO300/WMibl1nZgczAj23zsqKdlVbKygcTwzx+XoAbRVECZcS4FuPqRcBUdXYbnjlsCSOeFqfXl5BsQRovLukvE7LFh7Bn/C8mj5qeJ8WsNLKNFyCXN19ugSV8di0Nhu+Gu6hswyhYAI+y3fX3D1151rYCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830684; c=relaxed/simple;
	bh=ngDURz+Zv+VNdLK1WzDhoaY0B1fyf4Xi75cNVIl7UcI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XhmBjwiOoTMuxqvD1stSDgcoJnk0nHqtc4yt5K56Tlvr1LZy9IZYh9yxrS5XbxUOCUhHlPVKDj+CylbVsXcbiijquppP7u9UQzTriK+P0PKSgIxU4OvNIJeL43pjZGO5dHFRV3xbcv8MxLsXtuKpxz6N1x2CAn8zJZxArpswOg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=IVnmkWj6; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="IVnmkWj6"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1778830681; x=1810366681;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ngDURz+Zv+VNdLK1WzDhoaY0B1fyf4Xi75cNVIl7UcI=;
  b=IVnmkWj6hJunAQS5CThhoYl/BDRAm6v4twTHzPUPLXQOZyTS6av2aYhf
   5KCnEEQ7qyLl0Ee77LECH301iJlo6ML4HUIn9iPfqKWcOw7xkKiGhovP+
   eo0yRvxzkojrKep9oIJ8M4sOKNnX73HFpeciGy7TE6Xi8CmFiaCn5gw5O
   zXdV9XatAxyp6O4ybY4GS2vfa6dMROwQZaAvyp1lOZL+AR8ZNc7PDLjFW
   x8JkTGXoySpdFfl3gGFoR+ro21Pn4Ox9cKCgamyeUySvRU0A5wP27s8So
   WcKVKvgWQm5QlPTbdhZzcl0JAlCk/XJ3D+y8WXPVerl1nftmI1bcAEgJU
   A==;
X-CSE-ConnectionGUID: 3Gy6SbU9QSG0gP58JzM+wg==
X-CSE-MsgGUID: uq+Jl9UsSZuPukwc1oKCTw==
X-IronPort-RemoteIP: 52.101.56.67
X-IronPort-MID: 22384636
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-eastus2azon11010067.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.67])
  by ob1.hc6817-7.iphmx.com with ESMTP; 15 May 2026 00:36:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxVbwitXMLeZfeuCN2R2fVybCBvA+PPRNr93kXRuc8qdY0L3nKi3Vavwe8SEBeNLLckesAK8aw40xe02zm0ZqOJ05f7A1J9MqYgJZg+VDm9p6uCp+TVIaGQC11nNvawjqcXex0jsdWNgiyfJTL7BzbmrGW7mrh5S9PAD+VP2511SF+kbkfCyViqSWlfTdYbU14hOEo890Jbq/epCI9MWBfv6Xg3V3yFTwjb66iBaTOcMOcFHbUBSGg0bDCQvbqsozK/ikXpllxaaIvrQ6z38WVZt9aLVCRtOe0vsmAkNbrWZPQBteKpxsuMZcnnTkEZeYnqe1XEblwIA+HHdyj3Fmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvexbOA+bZ56mt2u50lu5nP4xeSwXUtYEHszizIkRzg=;
 b=RogcCy1D2IsnpejDb3aqtP2zCESNBFfWQ22J9Zrqoaj1xv28jzO13/CoKwp1vFeagFtN/PM6MB4tJEwFnNkOir+ezNcnFsQcLQSll0lxdCgMsV2fxBJs9O96Awxdut0ivLi3+Ulfj9+bPvnBdxGKFavNIMXhnwbj++grAcZLU21y/TuwFavZlUTf8bRQrWXwxLqSonsPEJTvrIo7T3+B7NOMeL1oFa8BHoFKesrzy7qzDKtmOVgnP93gwN08l6+fDhavjve5ly+4gqQS1qzmIGcUgD9TzG9n/USLF3MXqjvUbwfEqC2SnJBOTUdFZgHyG1Z7b2Y4sA3XW8mRi7VhsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 PH7PR16MB6094.namprd16.prod.outlook.com (2603:10b6:510:302::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 07:36:49 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%6]) with mapi id 15.21.0025.016; Fri, 15 May 2026
 07:36:49 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Torstein Eide <torsteine@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Torstein EIde <torsteine+linux@gmail.com>
Subject: RE: [PATCH 1/1] mmc-utils: Add bash completion
Thread-Topic: [PATCH 1/1] mmc-utils: Add bash completion
Thread-Index: AQHc4jKoGnU2jnGyIESLi2Ok3Zp1TrYOtSUg
Date: Fri, 15 May 2026 07:36:49 +0000
Message-ID:
 <DS1PR16MB6753E1BCC21E2681FD6375F2E5042@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20260512171227.36584-1-torsteine+linux@gmail.com>
In-Reply-To: <20260512171227.36584-1-torsteine+linux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|PH7PR16MB6094:EE_
x-ms-office365-filtering-correlation-id: 52bda9c8-3441-4bc2-1b6d-08deb254b97c
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|55112099003|38070700021|56012099003|18002099003|22082099003|11063799003|3023799003;
x-microsoft-antispam-message-info:
 Hz7ggfkvSqC9wSk15HoxujzBbq4g7hE30xmsp5F5PiEyuzKblBDlq7qqTPYLt8OwJ8OliY/+C/6eXVx4VXYYr/D3gpZlKvNDwzUVIxp4Ht1cBZK6OdMsQ5H9Vl4tLMkoBMNa0k31Id+/jJ9Vcwn1GE3syzIBUV7AUztGjhz8ZVz/cOr3vYEsTwChxrA/E9yDltMsvLOBWRTvB+TNy96hsgdKhcKQDHK1zb+A/9Wqhsr73tlTuUU51YjvKK18JTWli8xf4U34aE6FSNT6wC3MUDkA1+91BByQPSKn3zHUboaiavd71LE6QbQx28NbXqZkaN4vfF0VAXwNw8AwfOsb6HV2DcZWX4UFED4Ou67Ymowk7lC5WRqnzyCDWv9mh0gUp4SDErCvKwoC2zAzmLRSKmEmb3dP9LTMLjHHq5T7vsZqBJNXg9XExdbUYkJlNYD/0EXy6EXsMOfU+2fPA3sPoxdubZIx1wCI6GLCmyYxNSda0E1Oa4eDxfofI439616M3Q4wYyOmkUaffRUaA/hrBxim1UjYZO9vAEzrLpqI5XFayxWaJ9WIoHWo1euKgRBDk7PJenSrs8XPR8Ei2vod7v7uBNci4U3jUlIzmYZEDvCEJazINIn0Z+fPTCSzoeZ5ZKo1vw9b5ef9f+cWwxu1cnINa2xv+FzD4bicJogAPpcK8wYiahvuJJlOKKOWxXpv/pP14bP08TGzXY8ghFCoDKnL208Wp0kZLAvkQVkzfINuu8sp3V/0wewg/zRc7Pwp
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(38070700021)(56012099003)(18002099003)(22082099003)(11063799003)(3023799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6mHwd8eBQ2xgm7SK/IC78VLsNHyqiCG6qGedcLLeF3MhGOWH1rhP3aYggqr2?=
 =?us-ascii?Q?4EkO00o5sCU0VGp0VV9gobgzUewpVbCEZMKRy0D2C28O5AJjHq3dRWBnuGm8?=
 =?us-ascii?Q?7bF92m4ha/WAmct3TwhNw0IShgZf3H7RHiydRC1OTd/f1b/icZPHOmI9FBr/?=
 =?us-ascii?Q?EaeoSKKaoQQACzTYrnSp8JC4g2iGrQTYJy5qwipGKptd+GIWRXrF14mc7sxm?=
 =?us-ascii?Q?sDUhhNW2CqUbNnbb5zg/KKu4oVCKUYcFuNi9gx++zlC8aLt4oCOHECXmBQ5k?=
 =?us-ascii?Q?kvBE7s44CCxQqq5OpM1JJJgHmTuPPHqhzWbkHYvR8G87U70JdTHAnShbIiY6?=
 =?us-ascii?Q?qneeaiamAbPGIMVkala1uYHhYN90+Gs/jMZh7P9oOWCWzEbvmBgwoT+GoVgf?=
 =?us-ascii?Q?tjo5KUE/P5X+ziwbRr8zrxfo5FQUyDsmF83GOWcJAVP6hN8kuytkKeRn6P4p?=
 =?us-ascii?Q?F8rFax1aVHXNTRehIonW36a6qYIy1NronnOdCQtmC8yDeVe7jkE2dYqgeSwk?=
 =?us-ascii?Q?1/dUL+wi5COMtuUlAA5X89fD8iIMLYIIkSdTWXzXb265feFUMi+lcAfSPr9A?=
 =?us-ascii?Q?JKr/GrI0whKim6Xlgfw11q0wjCjwWrseNa90OhOEgaIarTQITTqNFFfWWqEl?=
 =?us-ascii?Q?aTtYljescMPc1tZ9U2pCrTCQZoZj4wTXgRAzTfBBZcUdN3ztQMXhSy1v+bmF?=
 =?us-ascii?Q?Sjq9Xpm/2GAaJmV7NfjWF1cibY3r/SGVc45Ty3E3D4gzmt8tfG8/VDfTe/LQ?=
 =?us-ascii?Q?Ps9dwQNGNxLzznoos1Fe6+oHMuXe5EJl9597uSiGDKct5ETbVzNsfmcu9exU?=
 =?us-ascii?Q?268zWP2WCdfZtt+OQpdvcDUndfN2wAhWmzjUcAXX7yY17a6AXqsoWS3h+n0H?=
 =?us-ascii?Q?jvk7qLt2RshP7sKX70raeQfGbcciHKedJU6//hElBemKiObLyPSGh/yhKKg6?=
 =?us-ascii?Q?LPgxQvQI0ADe2K7HUdvwidb/4E2JLJ//KnqBFZiaaEl5hObXBcUTHZ0W/mHH?=
 =?us-ascii?Q?q1o1DHFd/W/ovfHhLDdoi7O3fbhMjKrgx4VCp58W2NtkJYZdCmHqM4sxPGJ3?=
 =?us-ascii?Q?uhd4zMrwSMhXY3aQHoCi60fLQwydxmrdftoiiGKVimmXUL+BF42CVRKf1m/I?=
 =?us-ascii?Q?L295eqwx8aT3yvs7csAp7Z0iUMUmzkePjXRqHRjLHuuDG3q+CJXsdAWO6nA2?=
 =?us-ascii?Q?33VwRCLsNe37V1FnhNLpteiKoZtZkMHrIrpoICN8wzKzAsKLIgSArQVNQQnB?=
 =?us-ascii?Q?6uGxT4DsJJyPmec7rWi/ulanVg/3GILZIObZ6LtmowjfIdm8UvixzpxGE//m?=
 =?us-ascii?Q?p9EzWquHB80ugAaYcjeHjVhy5IKOon6zhBmK0QcizVD+gViCbGfCqRhsmiur?=
 =?us-ascii?Q?5ca1vTvougBS2UzJBBgeqXrCaTfR49luEFfilBPYtrZ4BEYH94cGxe7rOJyq?=
 =?us-ascii?Q?yNSwv8PEvYFBkfwQFuaa7mrLnCkSwJ2QRXiTZk4eIyGSF0yxJCVZZrHDOZQM?=
 =?us-ascii?Q?8NqiUfgpeg+dyKR4LlVF4+9nI1YD0aloTU8Os5OYBSBC3APCi/ZFydjYxv29?=
 =?us-ascii?Q?aLu5DE23wsFEtOtFANiuLO1hDVwVcmpr8bcVZkapJqMwB++0XfxQmDUVaSN5?=
 =?us-ascii?Q?CYZF6aenUm13bgtEEtlQekkoVufx35hEYqi2W5nU/y2z2wdf3hGY0qU03SPX?=
 =?us-ascii?Q?NhNvoj97fYzNnK+lucWeVvdPD3UgGHPMK48Rk47d1MnSKphPhQBOzQdEOYh1?=
 =?us-ascii?Q?nOiDgZAYyg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	q4SOeW9bcqsBvoyc2GFyK1xOI9URyFgH0s23r5ZA55RJj+FLiTOxpFObpduXcr3ik1gVmRnLhiVrkT9oq37OVJfT2VjoKYOCF+qVcUZyeoShTvtbaJ1jvZ2OmKS1PNuPH2UDjlM2KTHDK7ZEFFVY0gduwS4+sZ6O8SfUm5S7HFNml3oiVV9Gt8D+Z53pLv8coEddugSj5TmP3EFf8tx/LGLbxd9S2d/r415C5TC3BaWtpY98rfEu+1rzEC44OtDXPnC838xBRr8A4/vekM1RTQHlH7NzlmmbmF+7HVWR0GrngNhmMlsaXHxS/4EnLWhpEDyR4wMUliFm60TWYuBv6Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EMRE7auCB9vlWpfNj9OYTkL2fMqxub+XeUvrqZFwVod3rzsD7iYjmUWaBcool8H3PTcw1/uTc1bcZREWCvwfV4vk5qbq+GQjil6/+c7oeqDOmMORO2YEdNAwUCgr/ty7svzWP8tAmBW8czmPt0RWoJqwpPDNYVru9/zbjBNL+o5c1h3NlGYVGS7hRxrQOGP+KMFeHn+jf/X0yagqjqT1gZ93HVk2SBTl9UgEfhs6IdjN1E56MaRiTn35C+T0GxUppEm+hOaB1gHWPehmMblklRJ3P7lh+2gyexOY1ak32XGXjJHIw2IaoxJr75cE9VQakT046YhHQn4sfgxjH2lfBW4NsXC4H/CPgWJdza8TP1qQojMO1tP8kwsV00B+S93F2cscd2sjZcFgjDjINGhjiNjIgrkLfVLV2KgmAGWHugs82O8xo4gaSU3fGn2MPVpDxij4HtrYq0/Ljku08jnFswtkN6X5izHgGr+j+O+7JAn0y7HSm/b3i4LVhJrkgkWCZngMLAn3MCqyCNIQi0H4OEGMalWDWXSwLhoqN2939j8e38veYrYcfuPWpdENyVgim4FpSzIWV3uURDyBJJcJwGRo0GCQ1BvzXPoHnhVU73zQV7KIkQe7naAh+GeKDF1Uvoq/5qttXkVS0ZolBDkiKA==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52bda9c8-3441-4bc2-1b6d-08deb254b97c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 07:36:49.1890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r1vs6OZqBoe1rVNMxBCJ1nG/8DonvLxDeU0dxuWIW3+COtmdgFjn+swQnjmfR8j5lAzL92Ijdb34UgOrRRqpQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR16MB6094

Hi Torstein,
=20
> From: Torstein EIde <torsteine+linux@gmail.com>
>=20
> Add a bash completion script in completion/mmc that completes subcommands
> and /dev/mmcblkN device paths for all mmc commands.
>=20
> The completion directory is named 'completion/' rather than 'bash-complet=
ion/'
> so shell-specific scripts for other shells (zsh, fish, etc.) can be place=
d alongside it
> without renaming.
>=20
> Add bashcompletiondir variable to the Makefile (defaulting to the standar=
d
> /usr/share/bash-completion/completions) and install the script as part of=
 'make
> install'. The install path can be overridden at build time with make
> bashcompletiondir=3D<path>.
> ---
>  Makefile       |  3 +++
>  completion/mmc | 62
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>  docs/HOWTO.rst | 14 ++++++++++++
>  3 files changed, 79 insertions(+)
>  create mode 100644 completion/mmc
>=20
> diff --git a/Makefile b/Makefile
> index 11685b9..5389bf9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -22,6 +22,7 @@ INSTALL =3D install
>  prefix ?=3D /usr/local
>  bindir =3D $(prefix)/bin
>  idsdir ?=3D /usr/share/misc
depends on the .ids patch ?

Thanks for the patches - they look like nice and useful additions to mmc-ut=
ils. External .ids files, /dev/ path support, mmc list, and bash completion=
 are all welcome improvements.
Unfortunately, I couldn't cleanly apply them - the diff hunks appear to be =
truncated (missing trailing context lines), which causes git am to fail wit=
h "corrupt patch" errors. This happens both when downloading from patchwork=
 and via b4.

Better ordered as a series and resend.

Thanks,
Avri

> +bashcompletiondir ?=3D /usr/share/bash-completion/completions
>  LIBS=3D
>  RESTORE_LIBS=3D
>  mandir =3D /usr/share/man
> @@ -61,6 +62,8 @@ install: $(progs)
>         $(INSTALL) -m755 -d $(DESTDIR)$(idsdir)
>         $(INSTALL) -m 644 sdcard.ids $(DESTDIR)$(idsdir)
>         $(INSTALL) -m 644 multimediacard.ids $(DESTDIR)$(idsdir)
> +       $(INSTALL) -m755 -d $(DESTDIR)$(bashcompletiondir)
> +       $(INSTALL) -m 644 completion/mmc
> + $(DESTDIR)$(bashcompletiondir)/mmc
>=20
>  -include $(foreach obj,$(objects), $(dir $(obj))/.$(notdir $(obj)).d)
>=20
> diff --git a/completion/mmc b/completion/mmc new file mode 100644 index
> 0000000..07e4c25
> --- /dev/null
> +++ b/completion/mmc
> @@ -0,0 +1,62 @@
> +_mmc_complete() {
> +       local cur prev words cword
> +       _init_completion || return
> +
> +       local devices
> +       devices=3D$(compgen -G "/dev/mmcblk[0-9]" 2>/dev/null)
> +
> +       case $cword in
> +       1)
> +               local verbs=3D"extcsd writeprotect disable gp enh_area \
> +                       write_reliability status bootpart bootbus hwreset=
 bkops \
> +                       sanitize rpmb cache csd cid scr ffu opt_ffu1 opt_=
ffu2 \
> +                       opt_ffu3 opt_ffu4 erase gen_cmd softreset preidle=
 \
> +                       boot_operation list"
> +               COMPREPLY=3D($(compgen -W "$verbs" -- "$cur"))
> +               ;;
> +       2)
> +               case $prev in
> +               extcsd)
> +                       COMPREPLY=3D($(compgen -W "read write" -- "$cur")=
) ;;
> +               writeprotect)
> +                       COMPREPLY=3D($(compgen -W "boot user" -- "$cur"))=
 ;;
> +               bootpart)
> +                       COMPREPLY=3D($(compgen -W "enable" -- "$cur")) ;;
> +               bootbus)
> +                       COMPREPLY=3D($(compgen -W "set" -- "$cur")) ;;
> +               hwreset)
> +                       COMPREPLY=3D($(compgen -W "enable disable" -- "$c=
ur")) ;;
> +               bkops)
> +                       COMPREPLY=3D($(compgen -W "enable" -- "$cur")) ;;
> +               rpmb)
> +                       COMPREPLY=3D($(compgen -W "read-counter read-bloc=
k write-block
> write-key" -- "$cur")) ;;
> +               cache)
> +                       COMPREPLY=3D($(compgen -W "enable disable" -- "$c=
ur")) ;;
> +               csd|cid|scr)
> +                       COMPREPLY=3D($(compgen -W "read" -- "$cur")) ;;
> +               gen_cmd)
> +                       COMPREPLY=3D($(compgen -W "read" -- "$cur")) ;;
> +               status)
> +                       COMPREPLY=3D($(compgen -W "get" -- "$cur")) ;;
> +               gp)
> +                       COMPREPLY=3D($(compgen -W "create" -- "$cur")) ;;
> +               enh_area|write_reliability)
> +                       COMPREPLY=3D($(compgen -W "set" -- "$cur")) ;;
> +
> sanitize|softreset|preidle|ffu|opt_ffu1|opt_ffu2|opt_ffu3|opt_ffu4|erase|=
boot
> _operation)
> +                       COMPREPLY=3D($(compgen -W "$devices" -- "$cur")) =
;;
> +               esac
> +               ;;
> +       3)
> +               case ${words[1]} in
> +               writeprotect)
> +                       COMPREPLY=3D($(compgen -W "get set" -- "$cur")) ;=
;
> +
> csd|cid|scr|extcsd|gen_cmd|status|bootpart|bootbus|hwreset|bkops|cache|g
> p|enh_area|write_reliability)
> +                       COMPREPLY=3D($(compgen -W "$devices" -- "$cur")) =
;;
> +               esac
> +               ;;
> +       *)
> +               COMPREPLY=3D($(compgen -W "$devices" -- "$cur")) ;;
> +       esac
> +}
> +
> +complete -F _mmc_complete mmc
> diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst index 45c440b..9a460e4 10064=
4
> --- a/docs/HOWTO.rst
> +++ b/docs/HOWTO.rst
> @@ -2,6 +2,13 @@
>=20
>  Running mmc-utils
>  -----------------
> +**Bash completion**
> +    Source ``completion/mmc`` to enable tab-completion for all subcomman=
ds
> and
> +    device paths. When installed via ``make install``, the file is place=
d in
> +    ``$(bashcompletiondir)`` (default: ``/usr/share/bash-
> completion/completions/mmc``)
> +    and loaded automatically by bash-completion.
> +
> +
>=20
> --
> 2.53.0
>=20

