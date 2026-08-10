Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336692C08D0
	for <linux-mmc@vger.kernel.org>; Mon, 10 Aug 2026 06:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786343045; cv=fail; b=V/8pYBgWCJNnqG4L1y0pVJl3njqqyh0CCXCoZyNeQSqR+yg3OCs1pRaEJ3EPUzXqgW2xyilRw/q8tPpPHWK79odzo49rzR3tvYcUP1vWR6fuvfcGHfZpce7MWwU4YhyDQaOC4m0t/u4evnu0MRCizL8LfYaSCtn/FaytJAfW9eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786343045; c=relaxed/simple;
	bh=Rh1DopA1X03MQzlDB7NGAEwbf2bpHEpKIYSaASZBTI8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HBijyI+3kgzf/mS/sR+zTBkYlzfNYnj6Tln9bTcNVr7tgsLaugmqsLnbUO3UXnuZ9gLR/oYsuztP6PD5M13EU2YBUIxy2XtiH3KyJ+UFOE+OSRel7AoShQwQEk0EqGkoj/go5/RSF7qhPkp4Ur9hU6aWMuCBToAJ0kTxRWPXMXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=BTWWLWzX; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="BTWWLWzX"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1786343044; x=1817879044;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Rh1DopA1X03MQzlDB7NGAEwbf2bpHEpKIYSaASZBTI8=;
  b=BTWWLWzXIcUlXPWnaizDAStCYE/FGIWfIFiHnndD+H9jMjq9t2vq0gAH
   CAFBsQoYQ3iAwTkNZkvRtTlydw86W7czfAzlmZ7FtB+lLhxBn9qz0wfu0
   g8M1XnCzhY7vaXG35J6FIsoBipsNBr3wp7oHOpuLO2cqsUtDbxnaXySXq
   kQZx3eP3BodWIm4k2h6N8Jf21eH39YqFJ0DXfTCMUV9480ktcN7Eh2o2Z
   OHx6ejZWTSAtIuwDlbZakT9nq2pKAwaFPEmzCKO50+tyLfZ9+0hvfL42n
   dOA4RiW8h0A6jdGsiO0EE5yjgwzqEXNsXzA8rtTv6qgrMbfGEWkhnOn7Y
   g==;
X-CSE-ConnectionGUID: iymo6CafQ+u35l0+Xs0L1Q==
X-CSE-MsgGUID: ewX6ImdiTpKjEv+/3vzG1A==
X-IronPort-RemoteIP: 52.101.52.113
X-IronPort-MID: 28069246
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-eastusazon11021113.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.113])
  by ob1.hc6817-7.iphmx.com with ESMTP; 09 Aug 2026 23:22:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUZbF/9UFTxywbSJ95tKLM+7d9eE9V2Hu+QQp08w8iohFfd6hmXK6Kut6TrFQMeZwXZCWYknTQk1b3YyuDsVbN1X6dnRekCl2avhgpQ7r284mAyTUjRw8jpz8K6ZsbVnzShzlAUViwU7y+/GA+neZNxuAL+vshnllMOsNfqR74ts4cjzG+WPwY0P8M429J4be19LOxtkNXUskrF4W3A3hit3wu97VM/AzifHQXvhmY+0ZWFdBAYzEMb/p47WpwCXSwqQ8m1TWdvhnZ8+qvoGaGX2qrLpyF7olYdRO4FiPXSr+6p8NizcUw8Xukun70PAfQBkRW76No3VVDYsA5ojzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZiVxgaKWGfa3X1DLfrN883YzAGWj2iVkwZnkIRwpPA=;
 b=aCS9qbdh0NIZcnmuYaZyjKMoc3FpYLsLcDx1B6SFTRchwSTvCnqZDn9mzYBfHY3gxLU6HTCIZZ3DtCuTJDcuMvQ6hFRDG1+DtjsyqTW4I93/Qrw5o+ZQOeqDn3ZCDLBq+4AAIgLGSIHUjZIo1HHOHA+Tu5OQcR5TXLtTffc/uYXp0krnoGNlyrQ4zJGskasbAizHrDfyybDCLt7P2/FeSOhkGhZUpmR5fS2tAy0Sm7qP4sIbSmNkCxC8H7UV95+8RcTwStPt0GpbDtInxMY1ifEzkSEPzG3LowsxPcK/2wMm4GroWueXkjUN2Tu3SQVuZLuRV4uX4dju3HiEGZhH8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 IA3PR16MB6727.namprd16.prod.outlook.com (2603:10b6:208:51f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 06:22:52 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 06:22:51 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Torstein Eide <torsteine+linux@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc-utils: Add bash completion
Thread-Topic: [PATCH] mmc-utils: Add bash completion
Thread-Index: AQHdJ9Yrk9Y+yu/KI0GvbV/N7rVqqLaWz94Q
Date: Mon, 10 Aug 2026 06:22:51 +0000
Message-ID:
 <DS1PR16MB675305B57F157ACDBCBB5D7CE5DE2@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20260809080714.67754-1-torsteine+linux@gmail.com>
In-Reply-To: <20260809080714.67754-1-torsteine+linux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|IA3PR16MB6727:EE_
x-ms-office365-filtering-correlation-id: 1cf65604-9abe-49a0-b5e7-08def6a7ce96
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|10067099003|3023799007|38070700021|55112099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 QPsg1IQurNGNqx/YMvtnGMWGqI8ITI0LHkaO0YS156dSHgLoL6AKQZakd2MJczoQ2eoVXH3Y+ncF/CxiIKKxcDVnvxuuOuHdckmzaZ5D8AeYmO9N55syl5rqf2+BQ8qnf6c8stnjtHeDwCm7Tmig8POwXxmDJNN5kzMB2hCRftH4B+lqiz15lJu8yLODzqjDFTp4UoXyq12IhlC1AX51rnUV5JsDn5qPUuyvP86oYQq68LPmxRD9Ajc5aQqrVI/QTVp4Shg+xJ3Ihdf2TLNXB38Ovq0Bwg0nzX6GWuNEr57VISGqyu/HQdQ2de6Cv6j6E2u7ZGC9tH2cJL0mp5XizMVmykPcdVLqgvX+ubuQmJyxfcfPxe/ZtSe/XicHu9oOViQxCC/XgwOBdBY1q0kIC+zxHZjzNcsHni8C7bP2BbqZXYAfmJoe5JxD6pxKyjsqutSsWBqO7KMqv2MfMR1d2dbrvZD2p/aQ1yrme2fQdVZDKsAEQ0vnymSw2x6nITDkLeHw4qe47Omqkt1SX/CxOjBSLuHLAtf1dL0mIYwWAAHvQ7rPfVd/+1pmIUscEpWX+n6L+YIbOJuztGhh4aZsWhRbE9pEqxVtzf6BuxgpNujGXGhkx9Nr3B6gYIaFI5B6KodpuBXICVD6c2QD3eNEI/IKuH8nwh+8PTBhKp4axP861KNO6M+12elxbCw3eQcBtdFDILvGPtb81BJttDSNwQgCCYkKTMKe3yH43bXCDd4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(3023799007)(38070700021)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qdfQZ8DxEK8r0nPszDwaFo7Yp/AtLYAHMwhZdC1h5FK9LgJmpz5JyE8X66er?=
 =?us-ascii?Q?dIF3Cv5Equ7EJxQxJSbF3MMmxDDngpEUQiVUHJmS66UcT+gUKcJGXm71p/XG?=
 =?us-ascii?Q?NaBKvFz3EETS6LmWXx//Nmt+7hwLqOaRmybypiGRr+zbo5tNLKi8gE8kNdfW?=
 =?us-ascii?Q?ikaEFBsz0jW8Sf4SOOaXdUf2rpYpcMngfWAMaXswjaO2F5t7Xj9Zder5PkWQ?=
 =?us-ascii?Q?W/kCW2E+a+SpHYmuIKiKxpeqfN7235eIOZe8X9bzp2LMX9RAVtSeu93Iaujo?=
 =?us-ascii?Q?10JN9gq4xv7KO9eF1q5ac6EbrMoGlmaXDVsMFlmnAFouMCyVvYnQavF+9gto?=
 =?us-ascii?Q?ALOT0iKBt2nZ6P6Gje/saUshVRALrJgazjnfaT3AiOFO/Iaed56ClAYrOp43?=
 =?us-ascii?Q?ffaJjDuEt+ktEy26aWrrlb3H8YMQ9gcnElfaP6pIlIzj6vDI750W9J16ZDBc?=
 =?us-ascii?Q?SSID21BBO8p0gvztKRiw6Mvh6IbQCNKCUv+hOGVCOHWkOYh7ekQtOLLLCRzc?=
 =?us-ascii?Q?V3+HlTI7eGUnWETYm71u5mX5bgL0TqUQkrcKjh4jx8F7cr6SjL6Kkn2boJHo?=
 =?us-ascii?Q?sjqe7BxgdVWM6l10X6S9xErV60GTFcrY+mgt8ZRxSJaxzCWWM8r4joIwsKI0?=
 =?us-ascii?Q?wkMN7EdCS9OKVU/hxPuQ9ZJa+IHdUlLaaSUNDykGN89B8Gq2++wpYD1HprnZ?=
 =?us-ascii?Q?NbfTPF20hsXIq21+g2OVe7p1tRlOKoNsYI4rWtzDU6P0CVDTg9dEoMAXKeJa?=
 =?us-ascii?Q?9u2UYhBDzuzXjln/s2Bp1MI6Q1+Rp+jT6inrMyUwkq7TkWHXk43oLGclCl/Y?=
 =?us-ascii?Q?MW9uPgb2kb2pC3Y+Vohfg1cE6Hm65uxNyrjUdCMo8fO1u6EUdAQ38SBEmLRD?=
 =?us-ascii?Q?3ijF0uuXIJdrw+Ul9d96wXfnTJEA87QlZpLiLbjQSDgr9MIqc7c0yIu/Kgcc?=
 =?us-ascii?Q?J0qXnFAT2BJ26ly7brPL2njiNX9bCP+p2a76uIyXxT20PK38fqQb0BbJ8f/+?=
 =?us-ascii?Q?nihdY0QB0VCXdI4J2FoeY95x9jczTeNFWMm4CDwyTn5mcXS9d1Z/zS16P/qd?=
 =?us-ascii?Q?rqviHt5K6Djz01rwqdIS34y6/zcS7uKu2zfpXCjxO7nJSEqx2FcArxXlmKGF?=
 =?us-ascii?Q?z/FL3B+LGMA+bHL77ECSHjxiE0zRNeJ8MXQb5okCl+kdTzJ6xbyJLVOqXdAI?=
 =?us-ascii?Q?fzs2J25brBKWEHDPv3VJUCVpG+6ie59pMCaW2MHn3kRvUy9/jFCg8HDdqOHq?=
 =?us-ascii?Q?iZEzbrZVH/hQl8ei5ibejRGAeAwhWWzXpPTn8vFdzjGvyxpzwmIDkVYyIhxK?=
 =?us-ascii?Q?x6INYqZiD0cgS2gwxACkPnM4syAikPdP6vxKP4e5VrWnmZ/r3mljN73diIUd?=
 =?us-ascii?Q?vBDveARrzRUIeq17pEjYste4wYMxOuU/cWlpjCCv4wStNdznTn5M+MrkBkD4?=
 =?us-ascii?Q?f9x2MxYC3z7sakWUQ55bxJubySEHndNwHaSvmIoYPwjMz1qHFnhBkA75ZegD?=
 =?us-ascii?Q?cvkFPZ5tL4FY2WlEAMAa0KQHcx0ePz/jZ/kz8S3LCQKEP3m/Sz8RCBqYhv/3?=
 =?us-ascii?Q?XR/7pMmS6Nxe/FPDgF6rh/QKglqXbGxFl21YqjAKs815Us1SZN+eYPWThWeW?=
 =?us-ascii?Q?LZLmCauKAof1kvTVn1sArvTA6KIj3wjZ9bhncJjrnOvGc64Z9Nk4pUlPUYhZ?=
 =?us-ascii?Q?Hvs60McTrU/jDfl3oSJNPNsdkDpJQqIGuxYF3bb34cVu+weoMZKQ4scFoKJR?=
 =?us-ascii?Q?x5dGGHMBig=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	jHOSiYaEy83xvsmJkAtDeox6+0A8maCx5ApwCERfO8oHw3tSIjcqv2xeOF+ee5tGM8BsI570BnKMOOQa48mSgx/HEEFw55QErw546D+RTGWF0ExAo/cvJsRrpKk66Qex/slgFoZIM7VCXNumMV1VJOOHYAXNtdpA7cqBkFO6j0whA6tDoKydKWG1dl36e31f6UWlQLraw0oRUccz9M4+dc1+QKTh8f1JLV257AmW/e9TXd2X0p01+N/CLCetajs+tYRHGc9kzZ41rr3TF5kDUhzgAcJal78ETFOQga83tyi1QL6mVrbAnXWnoLb46fJ4eRAMElAXPg12PkFruDUqgw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S/21dgV/APofudH040wUGovLN9hH6IrXioU/OM5EM7sJQG9XjpcUxVIHAE3Y5p9UtHgDEQ1015FeQyFxdkrzSo+D8WmWM88NhXJ+tyJ3zcaB5AI56fRcyh/ylwJ0GjWedPGengt6DVP7JNpq0mOkW1d/2s4l3ru/3ujAF0/LYV80EF/7KTX/hYZHX+255kbRkABu9KrCp0SzK3FADr3JPsDKinmoVGjuCx5UGqQ0KCUEmwLUgFiiWRsZGVWvuWyUK7tj2strsx0Unmx39uUbL5xZKPe8T9SRZX2bj0BPU/FepS4pMvicEGG495GRuWPL+WUdX85dGUUfoSGOWDwXPTlu94bbHxyTjHwrrQdc92DM10uF54Kng4D6Pl1eKU37JLH3k0Nzkh1bzq/I8cBbmEx8z4VL5cWdFROd5dE+17ybaIYr9Nr/zzT+Flpnm4So51XDzGsbSkmdGxB9ahQd4QA53WzR7nWHGSsROu4Q4RRsl2/yVYyWdaj2s4DOz6Y/GvDrC1iMW9i1yM2PELDiBuoO+s4AHD8nL6QS3/rz+8oQmaLhMyJNkLKZvtW+Q/Spkdloh4oRHEs1t9virBYo5JTu1fdJdUz4EQIG9IMrpy8TrrBvqV3XhHdWQ3nNYw7qPnIywdb96NoBoy57WTY5Fg==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf65604-9abe-49a0-b5e7-08def6a7ce96
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 06:22:51.8704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d7TjguHH7lYo63y9LQWlsRfRWrRUwsYqRw0vd++9Hz55C1JLHiHrgp1/Pn+6GOlLaFubo2/btEh7TI2tp/WoLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR16MB6727

> Add a bash completion script in completion/mmc that completes
> subcommands and /dev/mmcblkN device paths for all mmc commands.
>=20
> Subcommand completion is driven by parsing 'mmc help' output rather than
> maintaining a parallel hardcoded verb list, so it stays in sync as comman=
ds are
> added or removed.
>=20
> The completion directory is named 'completion/' rather than 'bash-
> completion/' so shell-specific scripts for other shells (zsh, fish, etc.)=
 can be
> placed alongside it without renaming.
>=20
> Add bashcompletiondir variable to the Makefile (defaulting to the standar=
d
> /usr/share/bash-completion/completions) and install the script as part of
> 'make install'. The install path can be overridden at build time with mak=
e
> bashcompletiondir=3D<path>.
>=20
> Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
> ---
>  Makefile       |  5 ++++-
>  completion/mmc | 53
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>  docs/HOWTO.rst |  6 ++++++
>  3 files changed, 63 insertions(+), 1 deletion(-)  create mode 100644
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
I guess you are assuming here that the lsmmc series is applied first - whic=
h is fine IMHO.

>  CFLAGS ?=3D -g -O2
> +idsdir =3D /usr/share/misc
Ditto.
'?=3D' is perfectly fine.  I would just leave it

> +bashcompletiondir =3D /usr/share/bash-completion/completions
better '?=3D' Here also

>  objects =3D \
>         mmc.o \
>         mmc_cmds.o \
> @@ -23,7 +25,6 @@ override CFLAGS :=3D $(CHECKFLAGS) $(AM_CFLAGS)
> $(CFLAGS)  INSTALL =3D install  prefix ?=3D /usr/local  bindir =3D $(pref=
ix)/bin -idsdir
> ?=3D /usr/share/misc  LIBS=3D  RESTORE_LIBS=3D  mandir =3D /usr/share/man=
 @@ -
> 63,6 +64,8 @@ install: $(progs)
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
> 0000000..0a93bb1
> --- /dev/null
> +++ b/completion/mmc
> @@ -0,0 +1,53 @@
> +_mmc_complete() {
> +       local cur prev words cword
> +       _init_completion || return
> +
> +       local devices
> +       devices=3D$(compgen -G "/dev/mmcblk*" 2>/dev/null | grep -E
> + '^/dev/mmcblk[0-9]+$')
I think you are excluding rpmb nodes such as /dev/mmcblk0rpmb.

Thanks,
Avri
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
> +complete -F _mmc_complete ./mmc
> diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst index 0b486e4..3aba86f
> 100644
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

