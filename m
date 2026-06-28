Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3B63C2E
	for <linux-mmc@vger.kernel.org>; Sun, 28 Jun 2026 07:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782632253; cv=fail; b=td8ZVWxCHWz5SkiG/UZyojYfLe7a/ldmxMw/jyEff1G/7pvA3fJTRKZf/bunlVNSXT6106w60RrjkjxS8+XgMUK2MYRl3hPQGVk6COU1oIUCVB9xgt95/fkZ8mv53oesEXn0HlK+yg6IxsX3W9baGYSax1bvS81En8KJbW14MJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782632253; c=relaxed/simple;
	bh=N9OYovak/dGP6GQ+ucfhrjvcdgE9qwt7wDg/YI1OoWc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YeLsZFZMUA3vxxllfMuNc+xKQh+5/PQqI30i/YvvpvPuFvGUxhqO/DKQiiun4n6rlYnmW9+WVNQITjytKvZeaD+5gI+sJoh1X170FdRISnret/c6QK2gnnugt7RCnmBMpPdbPfd94NvaLvgxWs9q8udTgvTqHqOwsWKbppPJd8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=VfvoHrBW; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="VfvoHrBW"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1782632251; x=1814168251;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=N9OYovak/dGP6GQ+ucfhrjvcdgE9qwt7wDg/YI1OoWc=;
  b=VfvoHrBWZSkkkVSYVwGZZfK06OBDz4wMb0zmeOLXHFn4hyvOgJg5IJ2H
   WT57TiHGHLL4zh6AJbUDwwNBBHWSCE4a+l/MzTvoQKRJtyth4GjGOQJ7P
   g1EVFK0zkquu3rC12bMGhLDSzM4lXMIyc5YCwyPt8qUxa8V3kvvvXtpzs
   g+hP3GUDN9VOZQm+BIj/LJee7il0d81BrsdGGHovKb2Xp1OkMzcza8NiP
   BFSE8JkuymBbF0aXdQgnh5Mx+INceu5/OxgW/wVXtStUMWxTCht8UE15y
   VvCFhmcIaLOxhHmmuStRnQDDIYvckZeReR3MX4DKxiFHCnV3yVzZAKW/D
   g==;
X-CSE-ConnectionGUID: XGhlLZ76RuKxudqrINn5mw==
X-CSE-MsgGUID: JAR/5CU0QTehSq08BIYRfA==
X-IronPort-RemoteIP: 40.93.196.5
X-IronPort-MID: 25507904
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-southcentralusazon11013005.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.5])
  by ob1.hc6817-7.iphmx.com with ESMTP; 28 Jun 2026 00:37:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QM9D7ugd5QKVacABEX7CwyIS/8PU8sbtNIq3ffowkMGiPU+4ss96CcOaG2/X44scmbyS7Hh9/mGMZHu/Jbrk/XDCTRAsPERkYgQlYQnLQqlUgeOEqt0MgTJpKh7YMWexTsXBzdWlcsjRdQI38utK9H/E/xY/a3GpSM4QE1ZAL0KUKk3HJdBYKc9Yush6UZB4RHMYtKdoXSvKnfv+SHrrM9jGWfCprn3CIC2xpM65jO5hgJPJ6Tu5GFUl+LxuEoJ527lD4lfLAlLWrXEqb9Ttj4kDBziw0eRRIp1Sls2eS4ha5+UkcEbzfT9VQ9wQaggedx2kK6icNSj1FgGb4XXBkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMNphD7m9Rn03W0YBOrbfBk3xA3E173KpQ6ApoWn/xw=;
 b=ktc4bBvDdkMg4egdJTT2PxutasBu2IUe4QG8nX/qoR/1WVa0HhkxlCwB8y83TjeUfxVhob4glUF3L79jPQtnwM6BQ3GLEaAb87dbFf5YzAnLrDGlBqNyagB4fmWJyzwBwQ+UIlI3mz7IgVXdM/wG8+qifOzGbO8BpdqICkPG7chaD1im9TxyfRjD+RGaDSdVZQD+ioray8Or5G5ueq4ynG8IIW1bkMyjmWE984HvYPwkcUK0B0Ex/PWobrf+gZKlTSydyAd4toYhmLtCdabTsuGXbq8RdNQZDPrFnBxh+kDWSXbPFbdeYUfebnS9GdQt6mJLx/YqP3dEr6eQP2P4Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 CH4PR16MB6673.namprd16.prod.outlook.com (2603:10b6:610:22d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sun, 28 Jun
 2026 07:37:27 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%6]) with mapi id 15.21.0159.018; Sun, 28 Jun 2026
 07:37:27 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Torstein Eide <torsteine+linux@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v4 3/3] mmc-utils: Add bash completion
Thread-Topic: [PATCH v4 3/3] mmc-utils: Add bash completion
Thread-Index: AQHdBApPbl8+yCkJLEW4obzVenvPArZTmH9w
Date: Sun, 28 Jun 2026 07:37:26 +0000
Message-ID:
 <DS1PR16MB6753A6AFC7A9960096D8F40EE5E92@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20260624184824.2215718-1-torsteine+linux@gmail.com>
 <20260624184824.2215718-4-torsteine+linux@gmail.com>
In-Reply-To: <20260624184824.2215718-4-torsteine+linux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|CH4PR16MB6673:EE_
x-ms-office365-filtering-correlation-id: 79bb1ee8-9087-4445-421e-08ded4e81a2f
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|55112099003|3023799007|4143699003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 1/1+pWPym9XXww+yxDxR2IQPmVxc6A20U/TCWYSSMQ0Nxi1mOhKZTzv7JvrrHBTkFzsEk1pu5Ozuqww5UuE9+tZs4eirlVGqbljzWv2w13grsJj8DumL0judtpakN5ScrTmaOr2SLNxPaHCClMBYm6hPdSxi8ZJBnXDXqsnsqAmqQqCy2VeOchtWD1xLQnEHZrwsvxH2ICimi3b39QjbYXvD+qzT7pfBxKCdDiZgXxmvguFT/gyyIoVrLKNfM5MKuGxSJlNwxXSPj4sEWTWsEjOPfwhSh3tumnsru3J1pGsl/Jkl0vlMuv8IcRoCLQBOWLOfxcwscUbAlFttw3L112L0blTYBdLzG89sJcFG/yn1pj3v6Fddl68Dz4Ia/6IFS2qegNxvEJS8c9m0ShruaPTB59DGjk9yvtG+TfDkalQ3fEOu8BnnhaTuNRch4uzg+SSx+ThhZvZE8fwyijG+HhwrP1qxsgRvVljmvd7Iwyp/8ZmSbq5QMlkcxg39FgG1/NzF2ZeL0XBm01Ym8M5qrRuuybf+8tNILM1hRzx8zhnC2FbHhTPXYwPdX7Wnt2SJHCf4Kr55+swbvnEVE0SPuDXmzJYg5IOjHK2ulrjx4rtOsTmhwiszK5wheSDe9UwrkfazyKRTZSwlpDab+PvDNsj9ZNDuKDMVGi8wYd7vmtTLZmDmAS6B1ZiBlFDCJcKkW6BqLRKS2kqcojInkl+FRTzczTcgPM1irHLvBwSg9do=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(55112099003)(3023799007)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7iNORjuAHo63+00uahCLxWMiYYWHPgTAgr6F41GlZpxcCNlTrGX7G6B4YEDB?=
 =?us-ascii?Q?kg2F1GzJW4sI/5QhBxVB+XiDPON5uJvCFUWmkKkzlqTyDBl6sRH1gu914Gt4?=
 =?us-ascii?Q?0DmRBGzlJvc9xdBxHint3lq5miQy4UHTxE65WHSxqa5kRbynKu3KyS+gzu06?=
 =?us-ascii?Q?1GXQF+71svATUjDUAXfkMTKtaiKr83xcjwc9HvLc4/4c6mUYdv70eE9XNFea?=
 =?us-ascii?Q?w8nPaFZKjucfKAT9BdF4llw/x1H3glpQ+t1pQs1jNFSKs8oExwOf2N70rgOT?=
 =?us-ascii?Q?cOfDG1+aBp506oqyoezy0iToxOaaa1Lb07/kHpQ4MAG/Lf8HhGt9s+PZgFWa?=
 =?us-ascii?Q?qVfT68KRYDOpnGk3dnja3D47mLYV+LnT09jojLMIN2xDJM7o+Phe9+lPwpgJ?=
 =?us-ascii?Q?iQffYQGqXkKvq6oN6aUnWajpihGmOyH+yqdueWl+ZO9JDCnufAwNkBGUZ3BN?=
 =?us-ascii?Q?E1g6vrNycQIVGr27JgOVH6ti1fbXOUNIvA6jl39/sfdixo83fUoTKGaEJF8E?=
 =?us-ascii?Q?6UCqSuQP0xv2qt/LvIRL+7QxiSyGbNzrGFz3k5o/Q4MGZBrGWm1yCxf254w6?=
 =?us-ascii?Q?bIjMxfy7WScXCxyelCXayVOuv6B0gpKFO9WcU1gfNTSiK5AtwPMNel2zi5YS?=
 =?us-ascii?Q?Xs2r/Xz0Tx34wEFkQdXhS90IzTb1iiqOgdo66pD61iDw/i+zoWTaJGcE/wN5?=
 =?us-ascii?Q?X8a0V4bs/VGzZuZpk3pRnoRGPesheKYoZ/AsoHX5UVBGz2y91VOSSGksMJaY?=
 =?us-ascii?Q?mgz3l5pvE5dgmg5YT01KzyUx7PVYz22TX5YvfKWJCXChUFlrj6xY7qFXfXJ+?=
 =?us-ascii?Q?+ssGDCx39xYkyvzzxcqFv7RUU92noAheJNd3AvBpP6M1FmuD013KwNL9iUwC?=
 =?us-ascii?Q?ev/VlyrPCD007Y/8+k4PvkkFcIwXL6x4XqVIV79ciws415NLawVJCvnQNLqo?=
 =?us-ascii?Q?jZmHiAT3C7efX4qsvPh4WJBahURoOEsd1Vnv1TJ4tnd9G785hnYR1LN6Hrj5?=
 =?us-ascii?Q?lMPjk7Wm3Bw2JvI1aCnNbf5uwzhBN1CLLXX4AUYWXHkRFyeWMu1ajKL7iu9Q?=
 =?us-ascii?Q?7lGCGr0jQkXIPsO4NVWr6o7EHc9mz+v1v67NqwP8g0uZu2Ooz78oTRWL3IKu?=
 =?us-ascii?Q?yyw2RCAeBGGXB4dak5xLfQizAYr1fyQaGlfWanRNCzJc3btL8/EzAQP0f8nH?=
 =?us-ascii?Q?VItOtme8shQ6Iaxd5Ak9IqQC5lJEfg9NG7wgHRijpwMNDS4lC/sp6OVhtA4L?=
 =?us-ascii?Q?3A9qp6Rx1kqqDuREKVgMJUTyFO1lI8bT8cXKosqmLSifpnusU7RVY/rTRQd1?=
 =?us-ascii?Q?IXzx/PQLpr3Inuullw0gz3uSc90uy2hmrN/1DmDhdoXFGEjB/im8JK5r176j?=
 =?us-ascii?Q?dZGi2eI/z7YzQPHX0Ujihl8/6PI70IV24jeei0wSpA723WtdW8SZUhfi/Ogs?=
 =?us-ascii?Q?6G9/z/gzzkuFBZVSFnml+bN9jGjWVqoxge2AHrM32MCP2B97Q5nfla7eUEW9?=
 =?us-ascii?Q?Ppp5sjbFSo1nIYlivREddQ7W5KKcyYxq+c9nFZygG2nYDYX3wF92lnI395TD?=
 =?us-ascii?Q?WODF+5XBnAutiUoM04wwlTjcYOeiapXfGi3DwPvCTp/tF52G6RGZ7P/B14HR?=
 =?us-ascii?Q?L0L4/yAHWQQgdImKQDBPJwio5Q2/gaG1RrX5n07s59U4jU4es3Y32saZrXJU?=
 =?us-ascii?Q?jFi+eECza+wpnogI6ObHxfGORW6r+Z6o5wvH/9Xsnkn1FzaQZfvUs6gFbqWV?=
 =?us-ascii?Q?jRrDBz3oPg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	DiGyWS+OV9b9bs5+d5ZAHDGeYPaCpRar/gEjS8/TEoGf0OgBBflqgafjV82hWC5cAy+efEJy0lY3WHCgZQIIfXw1unRMOa090zFFjYy+CpehrZiQZ3IUQ4KRNQpiH7ydZxNuS0JVFdYovWLaflpxWQEOpts4IkgzqsRfBatcDUykn/XE/olSnaexTovHM34ehWxBW04Vciysf37kDTO2TkAV0p13eSZ9TeYJ5BiFjvgTWYERIZdKKqsgtT0SLX+xy0R1pZzXKEVCgrfZsGPpjfS/MUjf/NOiaPxQM3WCWJzDM1o8lC9zGaQQunpOFGRu9sdVAZ9h3qETbkSGSz9SuQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	86neI4Tu4YGFYRewaXMQaBu6vkjdtXHhel1FKUVIOlukC3RKyGEFDSFme+9XDbYZqql28q+OYjFIIxCDZup0IyTy6BdNzH8l5HzosOnyrz8jpbUzw9xZ5bgPId57aU64KOLTw/i5pquhqAVrNzSf/BCpiwsLUxdUjd6J9qr/GX/zwU3woloM3iR7a+eyIgU5LGQpuGtxkHEutUIQQD9+dqD8kBV17rtdwkBpr/VzLUAkb0kD+cSkyfsYoboUODlqv+ogZgXkGop6sf3hyyxSnPbHAQEThfcBizFgP+nJIrDBAx4ZS8YU+WQ+BGGmvuoic4ZYR5Sxtamc/ZwPK48ADLIIfq4xDLMlk7xFTAernnfKkv0qIRxATnID79nKJHT8thc7d5rzCWYz7MD0Uvp98/uiosQ/GhpnAfxZVMsgMA/kHgg6S/jMaH0k9rx8HaedGBIFjnydOzU06U8P3M1zOITfw+QEVVrW/QekCjwbCv8OF5FU24I6/xYssvd04z30BYxkwHz8EGSkT9JLc6hOP+vQ7prZMzJc4rbyIpf+oKoCQIWpt2WGQQRL3JEMGzGLlaUwNEW/4yZ9z3Gw09hgezjNXrLvIyCNyymQjyMpYyrOLPKGrqLYKiBx/UIAJVWrGzn0n/xhSUuvRYLLcMk5ug==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79bb1ee8-9087-4445-421e-08ded4e81a2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2026 07:37:26.9418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zfF2Ppi2LxOtfz5bsLq8aTqqmdUg9n/hRrQwBtwq8cwZIUodxRzd7mLuNRduQaOc1mq3fQn7OVLT2gJZzMlC2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR16MB6673

> Add a bash completion script in completion/mmc that completes subcommands
> and /dev/mmcblkN device paths for all mmc commands.
rpmb commands e.g. rpmb read-block/write-block etc take /dev/mmcblkNrpmb

>=20
> Subcommand completion is driven by parsing 'mmc help' output rather than
> maintaining a parallel hardcoded verb list, so it stays in sync as comman=
ds are
> added or removed.
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
>=20
> Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
> ---
>  Makefile       |  5 ++++-
>  completion/mmc | 52
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>  docs/HOWTO.rst |  6 ++++++
>  3 files changed, 62 insertions(+), 1 deletion(-)  create mode 100644
> completion/mmc
>=20
> diff --git a/Makefile b/Makefile
> index bf8c006..607d372 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -7,6 +7,8 @@ AM_CFLAGS =3D -D_FILE_OFFSET_BITS=3D64 -
> D_FORTIFY_SOURCE=3D2 \
>             -DSD_IDS_PATH=3D\"$(idsdir)/sdcard.ids\" \
>             -DMMC_IDS_PATH=3D\"$(idsdir)/multimediacard.ids\"
>  CFLAGS ?=3D -g -O2
> +idsdir =3D /usr/share/misc
> +bashcompletiondir =3D /usr/share/bash-completion/completions
>  objects =3D \
>         mmc.o \
>         mmc_cmds.o \
> @@ -23,7 +25,6 @@ override CFLAGS :=3D $(CHECKFLAGS) $(AM_CFLAGS)
> $(CFLAGS)  INSTALL =3D install  prefix ?=3D /usr/local  bindir =3D $(pref=
ix)/bin -idsdir ?=3D
> /usr/share/misc  LIBS=3D  RESTORE_LIBS=3D  mandir =3D /usr/share/man @@ -=
63,6
> +64,8 @@ install: $(progs)
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
> 0000000..1924c15
> --- /dev/null
> +++ b/completion/mmc
> @@ -0,0 +1,52 @@
> +_mmc_complete() {
> +       local cur prev words cword
> +       _init_completion || return
> +
> +       local devices
> +       devices=3D$(compgen -G "/dev/mmcblk*" 2>/dev/null | grep -E
> + '^/dev/mmcblk[0-9]+$')
> +
> +       local mmcbin
> +       mmcbin=3D$(type -P "${words[0]}") || return
> +
> +       # "mmc help" prints one "Usage for command\t<verb words...> <args=
...>"
> +       # line per command. Argument placeholders always start with '<', =
so
> +       # stripping from the first '<' onward leaves just the verb words.
> +       local verbs
> +       verbs=3D$("$mmcbin" help 2>/dev/null | sed -n 's/^Usage for
> command[[:space:]]*//p' | sed 's/<.*//')
> +       [[ -z $verbs ]] && return
> +
> +       local -a typed=3D("${words[@]:1:cword-1}")
> +       local -A next_words=3D()
> +       local have_leaf=3D
> +
> +       local line i match
> +       while IFS=3D read -r line; do
> +               [[ -z $line ]] && continue
> +               local -a w
> +               read -ra w <<<"$line"
> +               [[ ${#w[@]} -lt ${#typed[@]} ]] && continue
> +
> +               match=3D1
> +               for ((i =3D 0; i < ${#typed[@]}; i++)); do
> +                       if [[ ${w[i]} !=3D "${typed[i]}" ]]; then
> +                               match=3D0
> +                               break
> +                       fi
> +               done
> +               [[ $match -eq 0 ]] && continue
> +
> +               if [[ ${#w[@]} -gt ${#typed[@]} ]]; then
> +                       next_words[${w[${#typed[@]}]}]=3D1
> +               else
> +                       have_leaf=3D1
> +               fi
> +       done <<<"$verbs"
> +
> +       if [[ ${#next_words[@]} -gt 0 ]]; then
> +               COMPREPLY=3D($(compgen -W "${!next_words[*]}" -- "$cur"))
> +       elif [[ -n $have_leaf ]]; then
> +               COMPREPLY=3D($(compgen -W "$devices" -- "$cur"))
> +       fi
> +}
> +
> +complete -F _mmc_complete mmc
Nit: Maybe also register ./mmc - to allow testing what I've just compile?


Thanks,
Avri

> diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst index 0b486e4..3aba86f 10064=
4
> --- a/docs/HOWTO.rst
> +++ b/docs/HOWTO.rst
> @@ -2,6 +2,12 @@
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
>  **Name**
>      mmc - a tool for configuring MMC storage devices
>  **Synopsis**
> --
> 2.53.0
>=20

