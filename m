Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EC12E414
	for <linux-mmc@vger.kernel.org>; Sun, 17 May 2026 05:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778997449; cv=fail; b=S8nMK7Fvw4GcHPR5uKKfyWplI6GUQtjGCkU8fxO/5oWhd9WkwPAo4tFXw+LNRJnvc1KyI4TWrZ6ibLOyWtcuD6UhSiX3VBv/ciaz1QFbaMW8KW9KQI3xhHNMyKl6ohRs2wywS7t7ITdIcwu8PkgzJNLqAWDaWdL4xXQPG4FEM7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778997449; c=relaxed/simple;
	bh=UcACB2usJva+GhDunybPHWJTq81XnToJQgS/NLuLfrA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rO+pZxBcLlGxyqTloLOJVPsn1LFJGvhXirTOU7UfY51QI9gj57Y5VsznT1gpUYDC/tK1dzxKO+64nMwyx29CrboU+1IBdxXyEBaWu7tavx2Aqml6ZyvKHiw7uu1oeoulvn6gIAM/f+3sG+66QLBJxH/fhhWm/KimDHqUKKpi00Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=pudLEh1H; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="pudLEh1H"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1778997447; x=1810533447;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UcACB2usJva+GhDunybPHWJTq81XnToJQgS/NLuLfrA=;
  b=pudLEh1HzliCz2eDdCemRRZB9gaXgQ8pWK9TuQAi2ZIfcDWXTLDQ/VWV
   9ocky9kWidTDnFrJNb6TuScjPeWtAaVeNBTemC1qjIGdqv3fSXhyYk3h7
   fpnziy1I6BsXIpBjtKLN3aZcm34BS4Ose/J55/KCgpZ0ogxN3Jk3qDq8H
   x2s65+ez1gDcoE231prJpJkYFy9Y6q/4Ta8P+VajxI8vipC1BfAqHfV34
   F946MG1dIUOYGbvWBIVmnGay6Vc8N3ZEJw1PyjWDPanvPZ070r6WDDkNh
   ruyv3tjWfUy/Mer88hv10q/4iC9AaFjmSGmC+6MWqbkxsoJ7jz+p2czK5
   Q==;
X-CSE-ConnectionGUID: xkEprPIYS06WNX2+LkW3KQ==
X-CSE-MsgGUID: 9JyQJuDqSnaYG7Ma/Bd6RA==
X-IronPort-RemoteIP: 40.93.196.14
X-IronPort-MID: 22523128
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-southcentralusazon11013014.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.14])
  by ob1.hc6817-7.iphmx.com with ESMTP; 16 May 2026 22:57:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouQDOehhTl685rDjS+VeOvwSThJXOezDUWXG8Dc4wvcOleLAcb/YAg21bQc8ZfCIW5qCmmI2/Hji3uRz3r6Jic1avz+5nvLFpRfuisSTa0hq883b2FQKMLiiU8aWhNZKDbwWgCXNP5aGSbDUxyq9oa1dQGzUQF+tqxPbrpW0U6RzoMu8gNd69s4nE/PtoHJsMGl4E4PNU0M4a+10upxYcOhlCbGbSKN7Z89Aog1ccQDQrqQ+pcpr0hbJq9rjoyJ9jYTUFK5MiqDTiHBaQ4gwkxmUeviYDQNeNPtZbtJP2xE+ErzTjiYXUG/hvTqAB3KLB7ApZuxFzz9usFchecdxeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noQf9rHoIZZ8XonBw8ppG5f2VE+ZD+gv2rRvgs4Lh7E=;
 b=oWQ9leQLw9eSaPKnN31C4kOyzBAzduAZtrhRft4+vcWzm+GuS5OKF83vWHDCAaFXI2GHIvh/28cUMf2LxLc1cs3gVveW/YS8YdJBVpyqii0leLExcXVQxKtJeepW04+HncdPqGeLSANSceO8ySOs/aL/P8Tux/3LWWfKQLvhNRDEiHX54guK5ktKGvvWrJtvmHgtXFHlJGQkd4GYPoInEzMe2mZl2Snj5u6jluT0J5vGC5Xs+StTro1Yp74GxCgg1y5OzwXH+KVm+m1Q8qZF/favLCoDWIlDOAmCSgFcJ7SPPKysf9Zw7cfVSdwgbN2BYkqcpBzz2ocXZFabwJnSig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 SA6PR16MB6730.namprd16.prod.outlook.com (2603:10b6:806:411::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Sun, 17 May
 2026 05:57:24 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%6]) with mapi id 15.21.0025.016; Sun, 17 May 2026
 05:57:24 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Torstein Eide <torsteine@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Torstein Eide <torsteine+linux@gmail.com>
Subject: RE: [PATCH v2 4/5] mmc-utils: lsmmc: Add mmc list command
Thread-Topic: [PATCH v2 4/5] mmc-utils: lsmmc: Add mmc list command
Thread-Index: AQHc5LMxw1uUr63rEkuzcWUJIq97pLYRuZ+g
Date: Sun, 17 May 2026 05:57:24 +0000
Message-ID:
 <DS1PR16MB67538B5E159FD215CF4E9598E5022@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20260515213747.1452692-1-torsteine+linux@gmail.com>
 <20260515213747.1452692-5-torsteine+linux@gmail.com>
In-Reply-To: <20260515213747.1452692-5-torsteine+linux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|SA6PR16MB6730:EE_
x-ms-office365-filtering-correlation-id: b2f4904b-e3fd-4706-c175-08deb3d92b1a
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|55112099003|3023799003|38070700021|4143699003|11063799003|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 /nckX/noSDwca97SmjEun/3gw6GPopVRsjSx915Ae/WkxNVfLDwmFiqFg0VJig9Nj4EhzdaIvHsnBnZIbTVN9CqhUAAlxgeRtgWEv1HnjrBg8fF0lXJ5/Dt/IkpETGidi+AcQjY1trKBUBYwEG6yozdGSe32JBAjUhTR2aS4rgBxpc54EkBwzqtmDIoCs6WjB70ZQD+jdJbeo9HuGUsyYkPDL80RFEha7qTZbFfeTtdtnnWFcsgYCRIpY/B2+n2KZxvlXnB6iQhxMfWKijCDjDxDOxg+xaOtRYS3KQa3jxg8NrS0RUy4kq6la23ZOZJZNiAKes3uYYbf5OK0znMTrRVI8kKNdgtYSp0BrFZpy9BSktbhn1Ou5h9wRFgKcRftiswXid2Hdg9/Ur/A4laZ4m28FBhVMd/9KQZ5eTq8OBaWQcJjPpNprujk+XK++sQXP5va+jWKUH46+Mp9WtuH4x4pbMD6wQDkoypwlUjKxICLqLJ/jRWP3ymW4jkr9d4xcJt/q/Rmod00zb7J8bMd8011n40xVm0EOj03Vd8IrgP1fZfvEO37Xw9KLArGiBy4hBzlOcm1PUMBx0umDSbExLhj5B+czPSlcMjYLc0TY0iSoZjmAizH/7QqOOPZ85UU66ax/2BkRrVxumyrrp97rtM8JeOOWK8lm0/C6QNYxDUD0Y/yofck9UjlBz7g24NkYfrdAMFZXDLDzphXd+uSqVFFkxBYanRXL8Y1SLnC/Hiwwdutc0/vcfMRdjCvxPkJ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(3023799003)(38070700021)(4143699003)(11063799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZFuSeg5vTKuTyVnajXhSMM69EHF+dqx+l4wuj9k6sTDhYcmseaB0YrhBK4Fk?=
 =?us-ascii?Q?4ycuapWiwDM2wAG36bD0IHpjyvFS0JRrDQzXABZMmOzVeUaolKz3BY0xmErj?=
 =?us-ascii?Q?OUZFRPSG7lVdZwzmE05gG8B3zGk96KeU5W9aJWi2v8b4qOsnjwZK5fQUci/n?=
 =?us-ascii?Q?HpUfngP/AhefK2K6SXAYPhWga+eFFJnG8RAY7cEHBnY3Ksh1PuJaVpbGgBYv?=
 =?us-ascii?Q?tzF2zrZ8IjMRIgKMR9ihk/IinLUN32HQst4a1iBe8t9fmD/53cKK8zpT57tt?=
 =?us-ascii?Q?QSAnYDfmhJX3gIuHUZ/WW2rZveMIdL9s+j6za7WVORvDJ4Kx67lRfx4m1rH1?=
 =?us-ascii?Q?maxH13CBb0otodVhX9ImzrNHhgLl+mW3K/tm7XuDbUKsyI8s8kMu24MZMHCV?=
 =?us-ascii?Q?j63cRRU6Sahw9UT778HXkoSngqTaKL6y5+sOHUOpeCyw+INOCBZ11taxFH/w?=
 =?us-ascii?Q?xytPUQ/kpGaPWBja4YWn4IxyAio6TOsGWjG31BVDthcvfK7RazI5PWcJ3tbt?=
 =?us-ascii?Q?dsART54TKWV9cSkLJPAU/iPnVqwvCdZq0vGrnWCvUUj4A85TUNWY3/Wy6ZWC?=
 =?us-ascii?Q?KZ/5MtU48hB7PkN9Ti+5MNR5wAPPwhHDoFUoRFOGXkznGZ5SeL3uNIEJjP0y?=
 =?us-ascii?Q?Vgf2aJ3lo3TUbqrFrdpvLP1Hr4/2Dry9D7J5r6Ddz7ZIKsfgg3tL7lfCwZzu?=
 =?us-ascii?Q?3m/aUje5RTo2LltcDOZrmHFUpHYOl1e1S7Gw8EaKxk9eRWq0yKcGolRp8WjK?=
 =?us-ascii?Q?8/NI7hhna67XDCzXvU1n+4mjKF9XJXMsGxQV4RETotjRfYJEkRDfvSspZGuj?=
 =?us-ascii?Q?mZwX6gk3ZEY2xDiR5+AFUN9a4mRy1Y/XJKUOuXpj4tneUGQoyD+STI+LmsSO?=
 =?us-ascii?Q?/hIjzUyZ+yAFK+4vd3sV8mwoyDrlKvTHrc0ggw6mg9A8o75VLk6VVYcR5RXg?=
 =?us-ascii?Q?hSRGwOZ3m3mAcTeS7MqTLfHagHIfsBU4X99IowN7FU4qgwlsNBwo6zIf2/V3?=
 =?us-ascii?Q?MoSHZwYsqE8lswWuyWX0OnwM16034cpA6tzSJc6ujCOrvImgbOpxdnlZnIOt?=
 =?us-ascii?Q?puJw4TxWZ/qvDbmX7ELosBvc8Hhkbtg3a8Pd1YQL+FopCQjZFoeaOoIRGiu0?=
 =?us-ascii?Q?TndwlHtQflMyPO/ydgRLjaG74eTfxgctYiJoi1njoVYmELaUkvsp05M5y7TS?=
 =?us-ascii?Q?Em0DRkcLwkiACR9mePOJIWWI1TojDN7F9lkbChPgmR/6Ok5Vs78ek/lQXyYb?=
 =?us-ascii?Q?/gc4YCB2UaOmXB4Oql75y0kVPmAaKFew7F6S4hV8P0SWkp/YnVGJ/bQazd8V?=
 =?us-ascii?Q?vZNnHVqj0R7bGOyWRS5AqWI9Ue3ztGG60yPQPX1eesPIPy0+PMYmFJbQ9Sva?=
 =?us-ascii?Q?AWYaDpu3LF847p2Q9KhOjWx6PSaxAh1R5cYdqPS8rHQIwhJncs926m2dezuP?=
 =?us-ascii?Q?iqzkQguevXKjZNfV9CGdAy04DQKr+FOp7GP9xiR/8CU9K+SutZzqRTKk0OPJ?=
 =?us-ascii?Q?u5LcrFIGILRcsj9p98auPqD3XOSE+JVXjSgBO9RvLhpKXhrKodAsI/19S957?=
 =?us-ascii?Q?pB04DPU1X3bUSYW/n+zCf2wCaxtdevwt44bv20q0XIffUynMcQb0Uyng/Qwk?=
 =?us-ascii?Q?kzOE2a/fo4fAidJ+2O6E0Z7TIfwgJNEwhWmYjw1yEPc3FfZ7atgWWjhuLeBK?=
 =?us-ascii?Q?wNEtpgEJOANeym8TSTBKbFc8/XYkmQFU+d78hKUqEGQ6spa6NHkkLiqXv6f7?=
 =?us-ascii?Q?WAsWyTddJA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	AdXDrWmpD49mOoTsz1DN/4xjOb9JExDsRQB1fRL1vaKPitW/mbbiZtsYwh0igUITr8VV4yl+Tf5o+AhVNuGpfYKDUagdSktBHF0f6yYpKdBbNxHu/AxKjGpPtDQIov9ZphCF9/5UWpM4f9ExI5udyGN+Vie75e3DrKIeHwTU7SdR4M7WoMqy9kyKx2JeV+2tMWfsyd0LP0Q8Mi11st3NeQ+qNA5MfJIUms+3Sj49XqzLj7q+nIabwtVwhm5eNk+Z8bgNtGHymXTS3978Hq19ItWPHJwgaJiWq2diRx6uDHw7/okvxEuZQychjEhlrP1D9C77j9v59DEhWF2B48NoCw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R2tf6yEZqZ6EqyNnqQrl6o06fSZdzXWHZdKV3wD1P5uuHZaaODOtUroWSDb84CY/tHEC5PssKaZWqWccFrwjiu5LuqImwVmXbJmZHJH/nBlawXwLzzrxlRpddKaI5oEdg3AdugWJA4IJllz2NoGb0BcJ78XO/omsQ7dP3iPUNIyuWLAwVbF3QFsqymiL1D1fRpW2Hxsv9uwnaPcYSfkxKWVpaRl0iShf/vStIXPnG8csATXH3y2JVUH9RXIek+ld4kKJL0+a5vszUHMgkCG0ZBB8YMcjadTvqzkd/IUQTfVgNu86OA5HHCYtTXdNW4ef/MJ+dGILjlHeauJGGD8ZsKNw8U8pjDLxxnwQE+vyzVGw4AIiydgEazJ3iW5gt4OkVXbWvHYUhMW68oC5lkn48SpzfQQBfG0uNwMOMPMQM+aFDxxxISfBT31Rr5WYWf+9JfPmaJv3SQ4JLQij/+0SMfaAlaZ2Q6TyUPYhXG7Wl0Xf8Ap4QOKcINHdIhqMG2jORExYKjxZcTuIvZpW4DW9WIqugjFeKXkYsLbkq+S86RukD+35j7c9wyugWOx7IT51KdjTezK6Qrv1kujSgjavdJnhcs+MTGb/yMdYnZ+aImhsmizFUMfHyr9y6lyM3chr4z/FkXoktegrv+8yesGW3w==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f4904b-e3fd-4706-c175-08deb3d92b1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2026 05:57:24.5390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MWz1hkTad77o9lE+y3ydWxAUWqXok7OC2Ipozjtl0vsUwAyA/M4XtLsEagwuP8UR2zmLWMFGn44/5YgO2LySwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR16MB6730

>=20
> Add a 'mmc list' command that scans /sys/bus/mmc/devices/, resolves each
> card's sysfs path, and prints a one-line summary per device.
>=20
> find_block_devname() maps a sysfs device path back to its mmcblkN name by
> scanning /sys/class/block/mmcblkN/device symlinks.
>=20
> print_list_entry() parses the CID register and formats a fixed-width tabl=
e row with
> device name, /dev path, bus type, manufacturer, product, revision, serial=
 number,
> and manufacturing date.
>=20
> The header is printed once before the first result. Devices without a rea=
dable cid
> file are skipped silently via access() so unrelated sysfs entries do not =
produce
> spurious error messages.
>=20
> Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
> ---
>  docs/HOWTO.rst | 12 ++++++++++++
>  lsmmc.c        | 34 +++++++++++++++++++++++++++++++++-
>  mmc.c          |  6 +++++-

Looks like you are missing the do_list body in mmc_cmds.c ?

Thanks,
Avri

>  mmc_cmds.h     |  1 +
>  4 files changed, 51 insertions(+), 2 deletions(-)
>=20
> diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst index 76214a3..167a153 10064=
4
> --- a/docs/HOWTO.rst
> +++ b/docs/HOWTO.rst
> @@ -90,6 +90,18 @@ Running mmc-utils
>              sysfs:
> /sys/devices/platform/fe320000.mmc/mmc_host/mmc1/mmc1:aaaa
>              SCR Register: 0235800000000000
>=20
> +    ``list``
> +        List all MMC/SD devices present on the system. Output is a table=
 with
> +        columns: DEVICE (sysfs name), DEV (/dev path), TYPE (MMC or SD),
> +        MANUFACTURER, PRODUCT, REV, SERIAL, and DATE.
> +
> +        Example::
> +
> +            $ mmc list
> +            DEVICE          DEV            TYPE  MANUFACTURER         PR=
ODUCT    REV
> SERIAL      DATE
> +            mmc0:0001       /dev/mmcblk0   MMC   Samsung              MA=
G4FA     1.0
> 0x1a2b3c4d  2021-jan
> +            mmc1:aaaa       /dev/mmcblk1   SD    SanDisk              SP=
32G      8.0
> 0x5e6f7a8b  2020-mar
> +
>      ``ffu <image name> <device> [chunk-bytes]``
>        Default mode.  Run Field Firmware Update with `<image name>` on
> `<device>`. `[chunk-bytes]` is optional and defaults to its max - 512k. S=
hould be in
> decimal bytes and sector aligned.
>=20
> diff --git a/lsmmc.c b/lsmmc.c
> index 58d4609..0458d1b 100644
> --- a/lsmmc.c
> +++ b/lsmmc.c
> @@ -225,6 +225,39 @@ static char *get_manufacturer(struct config *config,
> unsigned int manid)
>         return NULL;
>  }
>=20
> +static char *find_block_devname(const char *sysfs_devpath) {
> +       DIR *d;
> +       struct dirent *ent;
> +
> +       d =3D opendir("/sys/class/block");
> +       if (!d)
> +               return NULL;
> +
> +       while ((ent =3D readdir(d)) !=3D NULL) {
> +               char linkpath[PATH_MAX];
> +               char resolved[PATH_MAX];
> +
> +               if (strncmp(ent->d_name, "mmcblk", 6) !=3D 0)
> +                       continue;
> +               if (strchr(ent->d_name + 6, 'p'))
> +                       continue;
> +
> +               snprintf(linkpath, sizeof(linkpath),
> +                        "/sys/class/block/%s/device", ent->d_name);
> +               if (realpath(linkpath, resolved) =3D=3D NULL)
> +                       continue;
> +               if (strcmp(resolved, sysfs_devpath) =3D=3D 0) {
> +                       closedir(d);
> +                       return strdup(ent->d_name);
> +               }
> +       }
> +
> +       closedir(d);
> +       return NULL;
> +}
> +
> +
>  /* MMC/SD file parsing functions */
>  static char *read_file_at(const char *dir, const char *name)  { @@ -2335=
,7
> +2368,6 @@ int do_list(int nargs, char **argv)
>         return 0;
>  }
>=20
> -
>  int do_read_csd(int argc, char **argv)
>  {
>         return do_read_reg(argc, argv, CSD); diff --git a/mmc.c b/mmc.c i=
ndex
> 077e901..01ad181 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -292,6 +292,11 @@ static struct Command commands[] =3D {
>           "4. The MMC will perform a soft reset, if your system cannot ha=
ndle that do
> not use the boot operation from mmc-utils.\n",
>           NULL
>         },
> +       { do_list, 0,
> +         "list", "\n"
> +               "List all MMC/SD devices with their /dev path and CID inf=
o.",
> +         NULL
> +       },
>         { NULL, 0, NULL, NULL }
>  };
>=20
> @@ -567,4 +572,3 @@ int main(int ac, char **av )
>=20
>         exit(func(nargs, args));
>  }
> -
> diff --git a/mmc_cmds.h b/mmc_cmds.h
> index 407cbe6..508776c 100644
> --- a/mmc_cmds.h
> +++ b/mmc_cmds.h
> @@ -49,6 +49,7 @@ int do_opt_ffu4(int nargs, char **argv);  int do_read_s=
cr(int
> argc, char **argv);  int do_read_cid(int argc, char **argv);  int do_read=
_csd(int
> argc, char **argv);
> +int do_list(int nargs, char **argv);
>  int do_erase(int nargs, char **argv);
>  int do_general_cmd_read(int nargs, char **argv);  int do_softreset(int n=
args,
> char **argv);
> --
> 2.53.0
>=20

