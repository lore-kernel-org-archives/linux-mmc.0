Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE4340D594
	for <linux-mmc@vger.kernel.org>; Fri, 19 Jun 2026 05:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781847618; cv=fail; b=St9GmXYobvmrUKLwc5GGk3MdYb6So7N715AeK9qe1LqcLMfYY4JPc6i9/TRGYiilD4jRkhJw5bjMtrcvIpdUJgjbYjyQP7YM/OVLceh0h5IrXEwyfx6VNwPW19Ih3eKY6AdU6m06TCZc3/Odd+49eqa4XjYc9lAgFJN7JbbtYJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781847618; c=relaxed/simple;
	bh=caewQtqW7deo7zOVJ5aoge6/xKs/5Xx2egoVk4CJCRs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CjCUrbA6gvxbsYVvMAJGwPDHUy2SBSh/rjBXoJ1zeD5E+cm+P0OYtIdkBH4nHvs8IEmSwON1Vc6ePoC/lKHLz5TQpEaGgxJnCy/znivgye6Kmqvf4b+kdmlqlTnu9UmUBodL5Vz0hlVIOPsKaMbdSq76vGVRS4+5AimB8jT1Ys0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=aX40YqvJ; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="aX40YqvJ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1781847617; x=1813383617;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=caewQtqW7deo7zOVJ5aoge6/xKs/5Xx2egoVk4CJCRs=;
  b=aX40YqvJahXn7SK45zbxmYdfgI3WbIViveqKL8VasAjA8j0i3im+ambz
   EfIomMmTlKnVW8ssCOt1r+HH/1y5jG0+akTmJoPwl7TWS1OWB6yLxS9K9
   Wwg6QDTFX303BUWyGcmZVPElEM2NrmztnBayThVNpoz570HwgSgkU1HQS
   0AwLlYSjSpYoq5WIwiWEtpoCTn7CNQnKMvUXm3Nr8xrQgMyHhRItntMlj
   4/NUQQdIufFzI3BD1dZ4c7qIQrOXsjnXG6W+8rr9ykKbeKdShHcHNFr+R
   djjoPQmQhCJQjJFUuShO82WnztaedN43a68scvq0f/gAToIi5Me2VOKya
   w==;
X-CSE-ConnectionGUID: dD+eSUAUR2mA6SMQ3mvgMA==
X-CSE-MsgGUID: /Pv7lln2S62EW5snPIe19Q==
X-IronPort-RemoteIP: 40.107.209.56
X-IronPort-MID: 24727164
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-westus3azon11012056.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.56])
  by ob1.hc6817-7.iphmx.com with ESMTP; 18 Jun 2026 22:39:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHG05CiFwm2cuwz/gQI24zrTQ1yW6i827Hsu4H1203t5AFEsVi2P4DbSOaGFx1vzxxb2ZajDK9Qv+xcBHu4oEVuDt1DaS4cvZJ7j9RyypkAMkY9d0kfTwQCREcQA+uOODAgfN52/Pq/yOmqOzjwE0/+esjJ4f2NiZwxbN+pv9x8UWBybtb6KkWGvKUoLHuiBT6LeGZODu8iuvE8lwnNRLnEK0E456E4BftCNr1lD34hat6Vi84Jax/q+dbEc3QUmT90jFrf6IFxGP2RpJyq+95r7Es1QkfgNMd7cLPs4QdKiYAU1AGHPFQYzl807Srw9KrzNp9mj5Tf4+ekikQLN6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXCloxO6JM9NHBuyZgDNlOUuH26jxYMvINeaw1MJFEk=;
 b=S3crdZy26u7H3vRMnmL7wRWWHDuIWZZs98bsvEmKsK0qxQEnmL4CcMLTz0WRDIZS9AGhpmCkNna2HivnllNlkKTJi/CR+uY0aU3coRQICHPNol7HXNLTujog6hQsHGwJHKvvFxHqXbyfL084pRd3WVsW8G0Hkn6hwJeXqdWyBhZ7XcGq+P0JmXbIWut8ZTx6dZvn2Wcr4LpF96MCtlt//M4iarYdSX5duW1tDz1uliJ49VZKUKVMicXNNzJzTGsAOxi56uoh1vNkTm3U6roLioT+EtlVktGcHxVRdvpT29Wadi3+nS74/KpEwA3z6TZgEk1uYYIX8SqUvX6NiehlCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 CH0PR16MB5319.namprd16.prod.outlook.com (2603:10b6:610:181::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.11; Fri, 19 Jun 2026 05:39:06 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%6]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 05:39:05 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Torstein Eide <torsteine+linux@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v3 4/4] mmc-utils: Add bash completion
Thread-Topic: [PATCH v3 4/4] mmc-utils: Add bash completion
Thread-Index: AQHc/n40GVKoPeteWUyzCl7bBJIN6bZFXaWA
Date: Fri, 19 Jun 2026 05:39:05 +0000
Message-ID:
 <DS1PR16MB6753EF9A5EFEFE0C2218246AE5E22@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20260617172411.42805-1-torsteine+linux@gmail.com>
 <20260617172411.42805-5-torsteine+linux@gmail.com>
In-Reply-To: <20260617172411.42805-5-torsteine+linux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|CH0PR16MB5319:EE_
x-ms-office365-filtering-correlation-id: 7d2786e1-5358-4b86-4f4d-08decdc513e9
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|11063799006|3023799007|4143699003|56012099006|38070700021|18002099003|22082099003|55112099003;
x-microsoft-antispam-message-info:
 mu/V9LJxCikASexe0N7XzATlmfWVBpXgDnE1uBE9ANLFhQaje9BmRA12STn8+1rlUGe+p7dX7ObHiGvA3E+r88CtF/Iag14B80fLwQPwDY130a+zbEfVWAQyj7ClGBAlzmekZnin+M0u5S9XTVy78Grv7QyDPw02Dphlp5PrdPrOGXKbdmJ9HSNSFfo5q5KstltqLYxJ2rdDgAS42kYXNykUcw+gUmjpTIT9ahaiNwshgoS2GjYoRNYm42TKhJnjL+LyqN+9v/nBfWaJx2NQ8Gj43cN41xxTJ3/Bf7dQ6W169wBG7okOQf8OTArURJ6N+MXo3fZd9HgmzFxzh+IS6Kg8kzsDS3gLMuxPv9HIKn9HtSLmtthZl12zz6i81KySI/QQVR6HLdWRDUdVHpdBEtORmVovjvamlXSxhx7WK0PMZHgcHL3KdfB7NBWxSW9LjfkngSvc6i54FIACyWCsYVcf8LvisXbX/HPJvXQQuyG4P79QE36o5QlD+RiuAz37sXx/3CVAsCCtBZc1oXiUxy59R9CQCEZMBcJMWVgfc8sK6rKh2/aEoSPSY/nf09u8TxAVPcgJDgDt4ING3nz88i4+na7MZNOiY2P7wx+6FON/HyzxGw/Z2JARSJx9Qc/vC5VNnR6N3CdUyFVlO/W6+MWBvYmPGXTYMjXM8PoJ0ngBTrjT83brimBkVNHM+u9KGbBjJf7V6kMZm7/0r2z25EHO8T6YaPdSMtv5aj+Rx7o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(11063799006)(3023799007)(4143699003)(56012099006)(38070700021)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NK2TiDH5vhI9R7IxT/D3H+be0q+eu2q31XNPZDdXX7vwqcanOs7OAo428LbQ?=
 =?us-ascii?Q?F8ZqJriSYH3WtUmKVXIQk06wXrpJ302wNGQrV/SLBY1e09QHFdzB2zxp7Z08?=
 =?us-ascii?Q?czTbhJ/YipkCt3pt6kD2xcE1zjh8aGyRE/MqczTfdQJ8e5HILY2ArQ9gQ1hc?=
 =?us-ascii?Q?MpYYwHXk5HpeMAn4pqbF7OxdtHCPQfGJT9Srh2EHwHlxSWESOMqVjggCvFc/?=
 =?us-ascii?Q?QsdgCY5ZUrD+kHzZ/kPNx2z/sZZeVHBKmYJru1wqSwY/3C548OSsYpPGAzv5?=
 =?us-ascii?Q?CHB+WDq6aqEASRz5oHB95c0GGDloWFbq6LZ4S/MPWU/lMozE5n5wIL+/EJE4?=
 =?us-ascii?Q?eG0TZVBSeqlhJZGbHpGKQAjc0d+CNdcBIVWqBnGZMSoM8dqVT7aro5wGO9eU?=
 =?us-ascii?Q?Scp3zGXomX8QTWUoZexd33BzViczEm7COWXijSM5VlABlWapFa2XZz9Hymqz?=
 =?us-ascii?Q?ShoNbAE2AFf4o4yHuqR4Z3RNjBidaU7yI26zu0RoI64y7Ia6yCVAQWZ5F7fh?=
 =?us-ascii?Q?VgmjGE2eJIgs4UUbRIwwU96i3bP5keLT9qSOAaLBVXJMAgzehyy6iT7Mn17r?=
 =?us-ascii?Q?fZBg9cchgOj4POvEWnhaYustH0IcHTwD/j/iHsnYtmbLyZxJA+b82Ayij6vn?=
 =?us-ascii?Q?eF3dzz54DDE4DLWbZQWzuspgVEh/YzXSCtSC7XLJxz307K1uwr6d5hInkFcp?=
 =?us-ascii?Q?AvxcHdXpqRV+RivlbrxqYSiH+s181Q/0jtx8PYW8Q/pkpiI3yQSFcqerF0Ip?=
 =?us-ascii?Q?MLjlpF+JCCWuTwwGIO83zNUzIv5PSunIvW0p25fabTbZcOXH0hWUqtXHx48k?=
 =?us-ascii?Q?DEcnPr0OdC3tLIPk7FGHHB2Kt1xi+kQESWz7uUvz3IXruO28RcI2oSyTmKaS?=
 =?us-ascii?Q?lnai/VVrnyJ8lcFNp1foxTAlzHFFgZvW8qU+k9IcNuZHCPjkAVLCPgvv5cNN?=
 =?us-ascii?Q?JkYPX3b5uqOFpA8qEZKDTG5hosG2PPytRqw+J6JX4z5/0Yo8m4M6V35VSOnT?=
 =?us-ascii?Q?r6jQ98iuFUt8amQZxuVWcExgwhx/4hZ+qR4W+KBU5+MH/bcu0eePwvGQdR3G?=
 =?us-ascii?Q?M0j6U1WLHBH0ZHsOk8DyDd0puHlYe+J2XPk7lzOE0Sf0BmmA7YX4VEx/s6at?=
 =?us-ascii?Q?Tq7tWHuyJAnEE8sFYYd8kU+0AcV/pzgY3XfZhFcXrOAhSWXydrONtoh+IE9m?=
 =?us-ascii?Q?VKwRiFclX3xehKqt6gNLZ/8KdxHMWFmZcJKd9yqELDTe4KJ+pHUinYOLVs1m?=
 =?us-ascii?Q?9YT3eCaffM+EL0c2BL6Ds2A51Z+NKjAhDbDHglg5SPS4L5BEYE4iMa1ZSxeb?=
 =?us-ascii?Q?QPUeLC24dOr23gRdzfQARKeBXHb63QvV/cdeZNt2c2FTT1BJSyQdNd9FAA66?=
 =?us-ascii?Q?9pEjPYtWMSNrU93yFImHcImdL8sk+drit2vRzE+R/MBsFdX8BFAyicJ5zJ7n?=
 =?us-ascii?Q?bkHnRPekf/Bs0ijRJWKSk2Ynd1GCT/p57X1ipVLml9AAu2isImPYUdN2SK7T?=
 =?us-ascii?Q?wcI0/73CF6ZyhzmCfyazsKBxBZ5p0IpTpNZmKP2KzBny9dMbaOFy2gNWXH/D?=
 =?us-ascii?Q?5beFJWVAFQFTSjtrVw16cMtvhJK1ldmCqo5V5l2CIaXMzlpRLVvtJAlM9NHc?=
 =?us-ascii?Q?oXBno1mrpmm6GHkn4DdGEaDk8VPWSCam0ciWuwupbD0SSGuoCeGxcjFxjSL2?=
 =?us-ascii?Q?2VaTKFVGyo+9UVwXpUVUcyvNMoPGBb4s5gUBzGYs6R/NqhMuKOgq1J2Y/14g?=
 =?us-ascii?Q?ZfHDPVaM1w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	IV8i2HDf6/4syHAn9ZlwMl1d3HhM2EQhd0cTmUK9FLy6yPbwWWyBSup6pP13O1HNlTMtVq0HdQe4DKgGF4tuV/8P4B5XjArLj8ZwQ/sJSOMkMPyeix/3LGe+7ASsLg4SOFuxqh01/rLw32B99pyqO8BwOja6M4JYxHW7T42v1fOSckdJxmM7iPONGSgZyXz1YTVlTlEnyZ9bhaFg6ebh287f2okOVkIwmF6/fowAfWP8bh7RCfCH/XbVBsqesHCckkLcI0SzCvW3+8V5wsEeKVBepNuPl3BsNLMixXp/rF0Ftbo4j5XOLHm+YbbIIWxzsmnFgzYZRZ3M984pQbLllA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1XGUuhINzYQ2N/bMEnV1Jc+ni+zjPYVY+Dr0xxgTsG0bLtfcRqCdbsUZT0tGrplOZZTjxsU1sTl5tBd9xwXfYiFnkZriU59s3IVT53DR43yDKT23iov2M256rFuIlWd2irGzPVol8aEQoLULX91sTGS95MpxqclK7M3sNQoASwLYwhtJJVMZ9A78xBeqkF6RanN/iwzIPzI+kEKvG/7USKZQkYzMFZwcbgEXzWzinKx1ICweVQSmHyrUbiidFVeSFaxe68oNbrQGnII9ANkP6EYXcHPGlDq4gqhQzqOS7ewKxU2gpdvFbhmHI32pVILU8exh5r0eocehMkiKRWSUb0SBW1/wRDL/wc0B3CBYsOEnfsyAn6X//FDpjudvKPG8lMPz30jnX6oww3nlbtZIQCCG4iqkeXMYIN40n2gmGQMIXN3WoaGt8gdLCQipiaKmNGn4T5TBngl/nQtVzM5amcD85b09cWSPZyikcMUQ7WEary5hYhripDg1W9hVzePAp/31PKdmjPwro3dSy0DeoQpO3o5Cir0LPc9eNEMYN0+jCn8VT2mSQT+sgdBUyFMs7HdoBcouUVDZd3Ht1w/paMlHLdfYIh9iRBk0y2JhyuoI9cFbMpQsWTDF3dUX6pcD9TCFcCmsqhAIkrRBp3zBuw==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2786e1-5358-4b86-4f4d-08decdc513e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 05:39:05.9367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: laICg4dayUcV8wIljttF2xF3da2DqxTHrCxF416HsthnsS+MsY+Hi2Fb5leoEX9djKCV5Nb+A6TI9QuDDVJsEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR16MB5319

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
>=20
> Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
> ---
>  Makefile       |  5 +++-
>  completion/mmc | 62
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>  docs/HOWTO.rst |  6 +++++
>  3 files changed, 72 insertions(+), 1 deletion(-)  create mode 100644
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
> 0000000..c759972
> --- /dev/null
> +++ b/completion/mmc
> @@ -0,0 +1,62 @@
> +_mmc_complete() {
Instead of hardcoding the entire command and sub-command list (I think you =
already drifted out of sync),
And since `mmc help` already enumerates every command from that table,
maybe you can drive the completion from its output instead of maintaining a=
 parallel hardcoded list.

Thanks,
Avri

> +       local cur prev words cword
> +       _init_completion || return
> +
> +       local devices
> +       devices=3D$(compgen -G "/dev/mmcblk*" 2>/dev/null | grep -E
> + '^/dev/mmcblk[0-9]+$')
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

