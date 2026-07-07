Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD58D39DBCF
	for <linux-mmc@vger.kernel.org>; Tue,  7 Jul 2026 06:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406298; cv=fail; b=WdximOlw4i5DoxbTEhaOB/QTMWS3Fe97eJ1Nfc7IDY4Uw319F1p98TIMLTaq1L5/JM/kzecT2Q5jb5LWr0vqKG0MFX+B0hre9Qrc0YzLemox0rR9VlQraHN4tqzuvYg2Tk4dzDGFQDk41UiyIyJTsDqem2aHUdqxL5n7z8/3wog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406298; c=relaxed/simple;
	bh=xnx6i89M//wjR0hwhVLA2yb4iPTL1hslnZOY5zIEc5g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UnBjxzKr6pxSBdFAbsMp+mTcydwE5e/iWl5aS2kUWAvoEuGLKsQLvx+R2JR69+b9ZoKvFw77ush5tYpJvEsHpJD/LZTOKB27tP1tIRjJuyb0Og541wxb4cBRnMN4bF/QJMtPt5MrCCWWxBfmuklobVMe1DvFUC1UFagoQjee280=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=BWP211Mh; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="BWP211Mh"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1783406296; x=1814942296;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xnx6i89M//wjR0hwhVLA2yb4iPTL1hslnZOY5zIEc5g=;
  b=BWP211Mhb56Px5eGPlZL5iiAH8KPS41kY1vkPEFGblZctNcX9Cia0kLt
   V+yvC9pySS04LVSDOsVMsJ981P1DIqpc762A49wjzgKaoYgAr6Jv4y39i
   OChRawC7frC2gKm35oPnuBadK9BSci9u3oOPEaAvGaUwj/mz9M17n18BA
   5d7hKN6GylqulMyeNzyLeYg86owPWmP/AOohkoKzEOokpDJDUxt4cyfcw
   Qs2v1qN9Nn/BJHTmcFV77WrA5bnVx3GwF0YabJWc58BGj1emvsd/+PBht
   adrNSrUdz0/nzXsa8gZf7j0sdH1mhvBWG4kPX4ZshZe91RYAtVsrFoOr5
   w==;
X-CSE-ConnectionGUID: SFZNL+bGTOC0WiFoCiaa0w==
X-CSE-MsgGUID: it7OvyqSQGmI75AcujMRpw==
X-IronPort-RemoteIP: 40.107.208.83
X-IronPort-MID: 25996820
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-westus3azon11021083.outbound.protection.outlook.com (HELO PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.83])
  by ob1.hc6817-7.iphmx.com with ESMTP; 06 Jul 2026 23:38:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSlowj8k2btF1SsUC6uXl5NeN08KTqwvrhFxVJJSve7CFuXN+ZH32Ay/VgUZIGjkC2y6s/+8PfXtv/mn0xWAd1ZerBB/FBZLrsuS29asKT8o4uSt7w+4kD8tig721YKtMVImoX8tCLAVYP5DkULcaK481SSQ4/kJRMxt+Nw/VMCWVxuX4hOYTxPecgwndYnBtlABupkIBc9DYg0wkMrSIqyOB9altu7kXY1aJPiwQnP9flUSdZeptlGT4rh655wPHKsdXyhqpV/UZh3xhalXVyET4D0uegfZkKhINgBfExaQl+9O2UwwpPuJAtbHRZUoZAtJ+apfqo8uboy5wI3BlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hodcDuJwS/kZJNsIdPdVJhyFwgTFSW+p/pjwWtKTL+4=;
 b=Ehv8Dp0YhZeTKWa/I8VympiyAYHm7F/P8NWTtC5okhuiiSrBv6aMMvJLpYFFkMvzt+avXcWFDwxkVWHbi00pNqMj05RZlGGn0BQLcKWk3VBV4WAk8D6v++cl2u8TCnkzFAyFwIJXyv+MZM2Zqk6t7M9ttYQdGLRrddEVkE5Dnoe1wQSn8qwi7a6Wh6szC4mg1Xhxm0YKNz6EQD8xsOxUNkwcqe4oBO3JEiBsp4MEOa8TnLLfbr7F5N6da7d4fzClgc6smljSGWbjr3A0dQ7dQIB2s2KZ1zpp6Gs8APimNqcY85FtdSUlmqzLLmbH3mZ1w0mYaVLad1L68Vq0+AvK2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 DS0PR16MB5245.namprd16.prod.outlook.com (2603:10b6:8:157::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Tue, 7 Jul 2026 06:38:07 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%6]) with mapi id 15.21.0181.010; Tue, 7 Jul 2026
 06:38:07 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, Avri Altman <avri.altman@wdc.com>
CC: Ulf Hansson <ulfh@kernel.org>
Subject: RE: [PATCH] mmc-utils: Update maintainers email
Thread-Topic: [PATCH] mmc-utils: Update maintainers email
Thread-Index: AQHdDWKBAFxJP1rvDkuUpDkM+ItYObZhmxzg
Date: Tue, 7 Jul 2026 06:38:07 +0000
Message-ID:
 <DS1PR16MB6753D48AC460C82A309E5E80E5F02@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20260706154253.125106-1-ulf.hansson@oss.qualcomm.com>
In-Reply-To: <20260706154253.125106-1-ulf.hansson@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|DS0PR16MB5245:EE_
x-ms-office365-filtering-correlation-id: b352ec48-aba6-46e5-54ad-08dedbf24e2e
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|11063799006|22082099003|55112099003|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info:
 CZKlt6IfN3EUnk4/sx+wCfOdYaPfGTTfaDa+T4qd772bnRK00mtppU8ARDf4XDEKl/Pv1VIZAjqdx9sXEIWAn8IrgiEtIg+TmnciNcC0126DaiXZlmcAeEabtzcB74g6xnSU2Fw7xrTykTOqm6r9mQ3eBWoNebs/HyLPimlOLbaCN8zpSeSTRNr/20fXBHD+fJim7V1oP3D4TOLJKNt11tlGd0quy5c7A/lVDg/W/2Who30Ht+1to7rKMvCI0+3ps7JaLJNsIqt2HBNO41xCsYwMVBf3RuSdQMfOkjp/tP1LKn4OZw6YPqwdeFJ3WgjB3WpWvtoIr+GXjlOUj0jVfdQ+EVNiPuWYkettQPYNEL23mKATs7Q1v54Y9Z4FJ/Ew8DQihSQVTthPg6mlxmrub9GPNQo2LPgmIwmqsM88rnnUcSZWnXP+QlNNzTe38tstPea0CnracTBsiEt6f0wnqzSsYEAACt9qytxDKTx+tzRRXA/gnfinvtKauYnVCG77Z0pz6MD5YPbkl9E5rsk4gITQtegptGr1Xsz8DYZwT4xlGPxMN+X5eNWs7WJ676FRiatl7qmITrPen14wjkwn7roeAibb19c5ktRIv1FxebwB0sp8ARifuG1LHiVqObHQy05qMVhwj7KXsW1Ppb9lbZEb9q7x4VpX6MUKBzAdpWPkhK81wWhVDpy/Njk8JwNDkjN0pzB71VPORt2BLLEE6FNeY0lDXoXu0JLBz2zNe9E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(11063799006)(22082099003)(55112099003)(18002099003)(56012099006)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uYhXXB2ghytP/GC4hezmf7ZeTFcfpxceWC8roRTZv0HNUAUE2AcRgtqTTDmN?=
 =?us-ascii?Q?gcOtoDbtOdymk/+w/kXe8IUuN81AX/TKzzpTvmvG6BVu6Vcc3mUiWTTJrKUC?=
 =?us-ascii?Q?ceFs2uGKfrZNo/FE+0CzCiWIrq0bT/d2GeyGPjMYHBJyrxSmJZKL9CPJuASG?=
 =?us-ascii?Q?Mu0YuRjNdIxyZcv8+YD9FdiZu1cUFheOj4js/gAzYSJ5TAn6UTM5/wNvl6kA?=
 =?us-ascii?Q?5sq+K7Fb9MLj3zDisxwkXTkSIiQ0SsCjXyBoD3KI5mR1MoM485u9D8D6P6XI?=
 =?us-ascii?Q?W9XpYZ4k1aR/MXRYGzlm7KUPuITaf2a/pPkIoy+brkk+ELw+FKOOZFEy46o5?=
 =?us-ascii?Q?e11mb3aPOipP8vHC4VAqyLTrLFYp5KbTPTPWbQEXZB/pAOP0WbKT60JQQwkV?=
 =?us-ascii?Q?oCpRGAXT08pj49GEkzcSOG8emqtfyiOF4bk6K03eK+Gnbb8T2YoKBqBuWlh/?=
 =?us-ascii?Q?+tbcmFVwxFSA6tgwAu6qclAi8BvsZYbv8s97Wc1ZldZuIyp1GzLY+v808sXQ?=
 =?us-ascii?Q?Luc9EGvKLxkju3ipqlqCgk2BP2DwXeJX2c4rcCJR5/uMeOaykAn8UOyvvsUA?=
 =?us-ascii?Q?l5H155pqXA61IZjHaTZJruWsomG4biq8jVLtuMF8ap8sTv0acP5FkOncjHSo?=
 =?us-ascii?Q?GPshmeCtHTb5/gSF8dxf6ec2kaofSbTWEs91UKShm8nyqqqkJlubqrDL5MVY?=
 =?us-ascii?Q?wpoTjgaDQGHmkc1AcO1tU3umZjx73hcBcreywq4dJNZGOOKFlk7dxEwFRiSR?=
 =?us-ascii?Q?F44ZBA/5ODLO0Zlwo/kDURcyGG4YTHXvxM3G+bNiQun/QrMguWdg5JoiRcm7?=
 =?us-ascii?Q?bJqQ943R6k93QB/IKG8v243WXHLXZ/5kALwbzRPUIgdyEpvNich+lN1YXWYg?=
 =?us-ascii?Q?frkcAPf466xZ0Igha+D8TkV0i5WxFmbk0L8Kr027bJjpQagI0LofIG+MM7IY?=
 =?us-ascii?Q?fg9nHHLgQv70DJz7Mncad5LGmb76JlIQITVJzzI09owgr+54i1+fumzwILNi?=
 =?us-ascii?Q?EOmZQNceBh23bUGERpzWWuAJwr/qHznb/zU8hMnovWKdTOv/ydHNPbDXSfNb?=
 =?us-ascii?Q?lxArycTz9ODgMJdIhItqTlgpBPtDT1wcTcDo2x7TNVOtOYFrL2gcE39z2qZK?=
 =?us-ascii?Q?3is4iYhDE2xkk5ShvBPRQEYaD9hL4vFEhHn//6ECHthHUKzJuPNfIQUR2JuR?=
 =?us-ascii?Q?SJ56HGpbjrO9rabrkjw13MxXfNRedqKAXtohJuvjQB+pchiccjaGlVHxW/4a?=
 =?us-ascii?Q?6tNphY3G/nztCWpKIy2JOrpG+1AVQojZUVTYf8X/BhY70eKoCpAQhKYc6s+i?=
 =?us-ascii?Q?+iNypZrSM9wodfFmzFvfwFjNgdCs6T2FIW6QBIND6aemCPSwk6a3JrvQ/vSD?=
 =?us-ascii?Q?g+qkFiUpBTyEOCizHoXr4ZH9WgsWJ0c4TN6xzf0AlQBv/neb3dtuL8p4VYAt?=
 =?us-ascii?Q?yDNGNgxFZ/7KhVq0KB+cOu+05VRm2VqHtwA/fek5wjWDzEZfpyNOkEQ8KFoP?=
 =?us-ascii?Q?J8y4SJPHtzreplUf6YGT2zLpDa9/zMb8p2qL5DZC6Tib1rt6//uRxgoBdRSW?=
 =?us-ascii?Q?yN4cO1itge7T+E1uBo96U063xk3f+augTBUAkASMbhCW2PoK8LdK8H26rAIV?=
 =?us-ascii?Q?HxEiubsPTPhZYiXjk9sQ3fyHHCPtk5Fscwy/crMjyHZijcKEHe0b6r6ypafX?=
 =?us-ascii?Q?gnxHfBNJrHH+r2KWq+yYhitt6tC6JXQrzrjf/f7WXzT4xJkQklvzG8vX/ykJ?=
 =?us-ascii?Q?IPWmwRHpNw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	IdVgN9EesQPE8M7qJSjmzvfaCNql7i0L9x9vxUGhcfWU6TWtxqPbnrP3qgttQe+weR5mnYbDGSaDFVcWmGDmwUgOYsIgIilAUS7e0ksVOInLKYPlm1guKIY31Vy6PNlW7beIk+PUk8T6YYPxXLoWpBCvbxzgIj3fpJD9xSLTOtmzN9+Q8j0wowVBi8QRsC40UzF9xQLXdqGJS5eX3dIbRsplIltpVxbiNoVgnRFfxer8QCWzaz6YMijZKAE1TIMrfGeNPIoAPZyVC6EsfLC0vz66ejajW8NrDwBhN0xV6UQgl/vke0KPRSJPL2pS4sDXI171oHZEiY9ueKKLiO74xg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J7X0V6fLebBQ3h7LDEfCFNmjGWa1BhglNiGDsaadzl936bZq2YD8vrQpVuEH80Y5bWOLLKIHPSEXv1NUiPOVV62SIxV9dW65oJPCIGGum5ChWZxXq62F5mhV8IX4aUjbkMaB9beQes9DMsq03GqGG+CA8RCG4gc1qmwqpnEr4j4WJmi3sDdYksEooUdlGQsCZGChqT7ev+yoCvMSPg8PzEBngVWBPX+1+/2UeDDkoXkPCSVUhxBrvasnHvFzPXWoLpAewOawTk3dyJrqfEaspCn+5rcgXWuFnM+/s2jNLhdKF63WhA+/Ox/ZoiJeq3Gx6lYetNz/nVXxjUdsnQ2+IdCLodfY0vTYVAwuHdFGbU3B8B/DOPUHa1VTzkr+DcHuJR6HV8yiy1WlODfX8BGQoQx1jF+TgilEM9A3mX5A0GNoqH6rohCkQxOs3RzDIGJ2tYABg4j1cNcN3i8LNZdSeECpH2ghRddZ7359Q8n1RBMXdoYY76fGsr4V3p+KwW/tcYTLWyPMHUCwYamjSezUBWwxbMadEe2AHabVLyz8DuShgxCYZkCWU5foUQudykv5tIUyq22Ko4mZ5Xhspl5xDzXpvSZQ0/HD+rlBBYi5Tk1q+YlZ0IVp1ilvM7iNZ3iJFjrl8v45F8BKk++T0d+sUQ==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b352ec48-aba6-46e5-54ad-08dedbf24e2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 06:38:07.2919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sysDN9hClBWp7tepipZ2iukMhTAft45UzKV4YuA1u51eNFkbFcirWniIx6ddBe8lBY1T9Xsl/pFGEmmNjZuZ5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR16MB5245

> From: Ulf Hansson <ulfh@kernel.org>
>=20
> I am no longer working for Linaro but have moved to Qualcomm. That said, =
I will
> continue to help maintaining mmc-utils. Update my email to my kernel.org =
alias
> to reflect this.
>=20
> Signed-off-by: Ulf Hansson <ulfh@kernel.org>
Reviewed-by: Avri Altman <avri.altman@sandisk.com>

> ---
>  README          | 2 +-
>  docs/README.rst | 2 +-
>  mmc.1           | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/README b/README
> index f18fcde..0c22710 100644
> --- a/README
> +++ b/README
> @@ -27,7 +27,7 @@ Maintainers
>  -----------
>=20
While at it:
>  Avri Altman <avri.altman@wdc.com>
Avri Altman <avri.altman@sandisk.com>

> -Ulf Hansson <ulf.hansson@linaro.org>
> +Ulf Hansson <ulfh@kernel.org>
>=20
>  License
>  -------
> diff --git a/docs/README.rst b/docs/README.rst index 9606501..b1e3366
> 100644
> --- a/docs/README.rst
> +++ b/docs/README.rst
> @@ -39,7 +39,7 @@ Maintainers
>  -----------
>=20
>  Avri Altman <avri.altman@wdc.com>
> -Ulf Hansson <ulf.hansson@linaro.org>
> +Ulf Hansson <ulfh@kernel.org>
>=20
>=20
>  Building
> diff --git a/mmc.1 b/mmc.1
> index e4ac7bd..f0b3c80 100644
> --- a/mmc.1
> +++ b/mmc.1
> @@ -363,7 +363,7 @@ $ mmc ffu IO4e0aC2056001801M1100042AE1.fluf
> /dev/mmcblk0 4096  .B mmc-utils  was written by Chris Ball <cjb@laptop.or=
g>
> and <chris@printf.net>.
>  .br
> -It is currently maintained by Ulf Hansson <ulf.hansson@linaro.org>.
> +It is currently maintained by Ulf Hansson <ulfh@kernel.org>.
>  .SH "REPORTING BUGS"
>  Report bugs to the \fBmmc\fR mailing list <linux-mmc@vger.kernel.org>.
>  .SH "SEE ALSO"
> --
> 2.43.0
>=20

