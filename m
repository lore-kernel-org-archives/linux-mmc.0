Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E8F2E2DDD
	for <linux-mmc@vger.kernel.org>; Wed, 12 Aug 2026 07:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786518318; cv=fail; b=WY31EbK2sNwjT5Fm7xcAV10toIj/8hDEhQclRCwDPhlXyVPEmbX5jFQaae3TJwhZyBT4HMiyIZRda2V7WbcFcnDL37fKAPBfPY45edPgJ8JXnsPoKdbFzViJ/FBAew0rrUFqZ+1fmOoCK50XSlrg7cU4txf0lQmBwWdhoRvF0fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786518318; c=relaxed/simple;
	bh=DkJzurzP9l1AHRM4vZnhf7pNt3Awm+yS+bAiVZVRpso=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QxUm84YILlWEGL9io4W6L6fmyQx3cKSdHsRJ8h2q0q+mz4slAr0iQPal1Cgt8PY8aCHIot5bLvxaJ6R9CcAtJUkKeZeJTJw5jslmnljiowX/Fyc2tmhpPjwHGkk5ylBWNnQjtisHxCJ8OO1b6lktXgP4BuPpIidnVdStPq0pU9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=pP+mX0Qw; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="pP+mX0Qw"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1786518320; x=1818054320;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=DkJzurzP9l1AHRM4vZnhf7pNt3Awm+yS+bAiVZVRpso=;
  b=pP+mX0Qw4+Z2gzXMs5t4KUuubLQGJ2fbgzZMKK8nx0FtpJ3pjANKj+cL
   hIvuCX/x+rqP0QIA9YNBfHEAs0Lrn5x+FBu1WbdGAs+hEXS9ri8d5DMN5
   ihCgFBmQPUDqyNXDp3dueLWn9Mu5yJFlYVfsLAosr8dvUqy9I5qvJ8kct
   OTCb83E085H8bdVyECIFAXSzCL/mnVqAbo+ZP5QeuqigBvaBczOL740mu
   hEUjhX92iSY7qOUi0V5AxzyizWisTNa3pt0gVgq93OQ2E2Yf93BGluKR2
   gdXFjYg91cNAKsi2nvbbCAQSCFchDMSLGUKzf6FKP65B6mcQBYX63X4cC
   g==;
X-CSE-ConnectionGUID: UY0iJaLbSyqBvNRMro+DZg==
X-CSE-MsgGUID: QcRd9nblQC2jicBcLRnEpQ==
X-IronPort-RemoteIP: 52.101.62.106
X-IronPort-MID: 28213481
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-centralusazon11021106.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.106])
  by ob1.hc6817-7.iphmx.com with ESMTP; 12 Aug 2026 00:05:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLZzZaQt3EnKSKqmdrsss4um1x+d9xHwkWrtMNtKg20rhnC+luUPMETrAw0KplypqLsnWKEJkRx8+0WE5uCX+ndnnPWaW9QGFM9KcdRq9mefCGcMWs2u2UrIkWo9fTTo6SGvh+5s6RbOrGTPzUBmSS3WO2C07ShETEq6KIHYt5OTegTP4yaI17G0R2VjyH1gQ8PgiGX+FoatyGCaitr6SQhHfQ8oAWm7aqefIRwJjcSi9oVhGK+8f2B1EEuh3AvUZxSdoS9Hy9uOg1uOuVgZzFGVnAic65I3GkMNg4XJeKTE/qP3gX4BXJYZ3k29jDh9xnYCfLKe9FhnK9JpRjnxsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkJzurzP9l1AHRM4vZnhf7pNt3Awm+yS+bAiVZVRpso=;
 b=PkGPZgcAhM2SMPMNyYnDlZkSxpmbHUOCzSLszBaADcUVOALDuk0s5EDDAKUN3m87NmU26Xs6RMaq78Thb0GbR1rHMENsMn5Kk+n7RTQ0TrWFNYJeI4yYE/YOdsU2uOFjiseVAYxymx18LHQTlGfy80S0uAHix7as+gQTK6t0qUZtgy5XA3fyNUQbnUk1VGyIABuMLEv53FQcSCdaV/FFM0MBFWG3GxW/isBV8Qk8KbCJVsVQG33nbaOdSYByUJki4TuuxknIXsa9JnjWVUi+iMOUypfLepzvtrWsAqSh5e9YVGLnVuC3GEqaqzbH6LzK60gACxC1t319kRJUFBcgLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from LV8PR16MB6757.namprd16.prod.outlook.com (2603:10b6:408:259::17)
 by PH7PR16MB4727.namprd16.prod.outlook.com (2603:10b6:510:138::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 07:05:04 +0000
Received: from LV8PR16MB6757.namprd16.prod.outlook.com
 ([fe80::957:1faa:81bc:8876]) by LV8PR16MB6757.namprd16.prod.outlook.com
 ([fe80::957:1faa:81bc:8876%4]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 07:05:04 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Torstein Eide <torsteine+linux@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v2] mmc-utils: Add bash completion
Thread-Topic: [PATCH v2] mmc-utils: Add bash completion
Thread-Index: AQHdKOI5u9WQnIOOhUak/oNgDd0kELaZ/7XA
Date: Wed, 12 Aug 2026 07:05:03 +0000
Message-ID:
 <LV8PR16MB6757BF9C17DC21C4304F64C1E5DC2@LV8PR16MB6757.namprd16.prod.outlook.com>
References: <20260810153734.139186-1-torsteine+linux@gmail.com>
In-Reply-To: <20260810153734.139186-1-torsteine+linux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR16MB6757:EE_|PH7PR16MB4727:EE_
x-ms-office365-filtering-correlation-id: 318969e7-ef32-4590-b695-08def84008b3
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|56012099006|11063799006|3023799007|55112099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 xdI7Ckdjurv68ewsPxWPwAaJxgp3KtKuMf/irF1i4ahD9EGE3SYUHhMs8YRrkTKCtLt5haleMe+W0twJ9DgYKRFSo9WxfRACNSqWEoyFa0593PqyON1nhcWnpIjZs90EilOwWyqVvxpyqWxKmFQ+JdpzgxhkBR9FWlEHSuyteMHDq83sSGJznmTuUbqCgq4gNseJS5ajh/4xjVcGS6Mi0q8LW1DYnPA+Rv9V54znwjcWLn6VV5KfTSpCGIR1pLIvO6/wHkG2GqNp6GYr+mrSA/gFaV56o2TfQUq8lq8fooEz1GGqYdRrf86Ewv55/bYiAvhGK0zQYWyQRoDLPsWOZM6gQahnLHAw1Yi/MotvNc2SVtdWxEAnw3eJWRx3Az789dvtzxXL9/DdcguM10nZCTCiYjkiQCvp65/pyOJ0PSf1SUJzT0DcrtXR8KWvD2g/Pbv93X7WJ/JX2LDPDLdj49kE2MCX1vEvR0MQ2V9G1f8awlnSlawI6S5XTX7jllqIVYdkNwgE+iRMKhpj0EBoXNFvXAhdNjQjInyjUT3jexs5Ii2fA+4qrrqawmLtmyrA3nnYVvWk/xpCquFeA6mTxRvmY6SsTXcv0g6sRJTjH5MqYMXcLKvclcQdkc9mJukcdGT2sj+S/imbqCO6B5FuVEdOvfMT5oYfqN69NUcvZMuHNoEP2DtAlBPf/CeiEajUHRjsjSQZwMRB+aWAqtNjE6nK5HFHnp2/mQccvVwY3xI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR16MB6757.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(3023799007)(55112099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gsUyczfx0idkf77N9PmwQap3D2ixAPc9LaHUfsSsC2p9o73D6qtL8hk6SxZ1?=
 =?us-ascii?Q?ug5F6N7GzVXdQsu6HkucbzUeFK9CMjNX8S7B5n+WOR3Qds7/zOUACwPUDyJX?=
 =?us-ascii?Q?DVhDUDiBBceYMkWGs3j2+syPUf5/BSAETKyl8wK5zhL0MzGIUEzAUCCPfFMT?=
 =?us-ascii?Q?mdjGdt4JlRE0YW7xi+KDRpTk4W0AODeM1Ky2acPhDi1MzmeSxD3OL15dKjQp?=
 =?us-ascii?Q?S9SfyzO3kw25aLulPPb/xfC3yOAv02FGIlkOlQ6TwGGlnOA8XFTqqCf3k7Wa?=
 =?us-ascii?Q?B0JgxB6QnpBo0r2hoBn+FuAhhTA/WImYsTPOtkJeovmIZuBZuXOPfAloXIYs?=
 =?us-ascii?Q?xd0zqi2Nh5kDK6VdtkJyBYpkbvrKP8vnoDns4BAowFqD5KPgPRSVJz6a5qN9?=
 =?us-ascii?Q?KMcHoOvV1F4Wp8oiGWmzzCuW1qQekby8JsQ0XBI0k+9A2Dy/ZbyIOWLaHD96?=
 =?us-ascii?Q?9Zv0fmTw2jTFr4WV+nft/l6TXE7Pb8VzRvONjvJjmTXRuWToNVYlpb/+hsP0?=
 =?us-ascii?Q?nYuJHXAC71uMyBTKNSc0ZgnJdSxaKgsZkk/wsNaQtWGz+qU/WbM8sEOFMdVB?=
 =?us-ascii?Q?gzFtwVxDm60yvvWuzT9vGOtk03FkNc51iBfZrSPTRhGstJt12VBtLk15UJhx?=
 =?us-ascii?Q?FmABybdbFWzul+BhVJClLlkW+R6T4nWyzUyosrqllS9Va5dhkGoP182eJY5W?=
 =?us-ascii?Q?httnGkcYdsAELOaMs9Vvin18gFQIgggFmKaJPU2SQZAxxSqdO6OrwepeEJcJ?=
 =?us-ascii?Q?8Z3m9sP6Y1MjyVqidw9WIucVjKDUMBMwgGMoSctT2rf66kUFYAFWsP/z60xc?=
 =?us-ascii?Q?iA09nZjmL4y/SE9kyItxFK9aMfLj5Nr6pmyrJnRh9/SeGlALB+2ApqA13P3j?=
 =?us-ascii?Q?dzHuSsWX3tLwQNQZv1/Wk10/H21cE+6UesR9CFPMsA3HABzaen2joyHAgIhl?=
 =?us-ascii?Q?jay4tWRaWX/81NepLY4WOrikLpUf5gm/kJcfA2P9KpkL5Us4/Izssqbw3uHd?=
 =?us-ascii?Q?e6louKzB4qmiZPxmJag3Nm9C10paXT+5C/qIvxWVuceAZulA+4DvzefrL7FN?=
 =?us-ascii?Q?chjGdExR5AriptQ+kiBoglErt6W55thfYfgsnnOKkYppRqYBFRTiBxK5cqSf?=
 =?us-ascii?Q?DA0t2Mfa8L44Hw5KWH5pAUzIX2N+nSeZ17oCLfuTzFf9V3qJEl2YgurUGkAZ?=
 =?us-ascii?Q?T+WKey31ZYjdI4x2gddAVTV0dQRmuR8/WxM0MgXIBoPEIbEfMv4Vy+hoWDUj?=
 =?us-ascii?Q?QFNddVteXwTZefpdZUpc4s9bwtaoM0f5GFrErknv/NtTUe3IONFx6OUWwdUM?=
 =?us-ascii?Q?Fmh1KqIIo2HYJ+yhUfpRKAz41a0dpjrWMrhxhkHa2Hc0OE6YOWM3HkPsdxh7?=
 =?us-ascii?Q?y2RiFa0uMJnfmcvLf6KK7FB1TO/AbP2lsA/t8bdMGSkyD1t/gxIxxEuTqtCm?=
 =?us-ascii?Q?iTULmAg4hUa6Plv/9Ss++TzyqOVapksTbGDQR4IKX9ODfpBhnxM51qICZGwn?=
 =?us-ascii?Q?hqu7r87qMwu0EZYYBDAc4SpJWp9MgUW0dFnQ4zxVGH+dsns7cOGiqktAdg51?=
 =?us-ascii?Q?sVIlAbye8xQLXZYEncl5Awao40MSaNeM7xiEeGvX/FVkv+61PC1Ehjf1GwJR?=
 =?us-ascii?Q?6Fh1+99M0CxvoBFJE6dnJ1Y47XCroHTMhWrrfBXZ0H1gP5gFoBWVUAgLPr3d?=
 =?us-ascii?Q?o0ETcGGpIsBC7QD8+QLkpwhpRwTlkm5hZBL9zXlm1XWZBfa2qezNw0BWpyWL?=
 =?us-ascii?Q?VHtkb14zow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	cRWPwAwRewLr7CpQBPTA/3kdC/Nomo/jIC9+4uJH3BRQKJLaQgEj1qgrQEsCXOp407aJCfDm1POkTNs85ScmTWAdkzx5bZTHDaX+MvcJC0sd+7duPd9izABFWFN2tzqQQRAmBpSP7IGyjUZctKMDytuiKyVoQnriLbSh00VRDlNCXmLBwrK9Om7KRXS+XizU/z6F2xQEwHZhWBbaer9+LOW138YGAqFce77y4N5nnTsGm9GNz5TW1kwxsjn3AaemK2DIYCPQXS1KSgfVyr7fyEIrypbAJGzV/S50yMabHpBDXMqSeaxB9yI4WKSbH/v8bhSrxFMEghr6miOPY828FQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	20HVKbwjyI00qhJ6QGJK5q0fAukLjiPKJwD2QBtGVadMGfQjGiMNu4wTt2s7NWNGoc+9H4wdwx3GT3Li57JIdbGeqyrkbP4tH/2gmHsVZdvD5ckhF4T+qZqbiXkyCOfxi49hqJ1KvXmAbrzHQXL2zGEI2kkaHTHrYZXqBFVauRlzFoD8zL/z5XiOyVC6Bja3jFJ3CAlGA93zHyDXF5N5li9oHAFsXmau+KP/LdM3gIiXfXdgcZh48ut9w4GVREgVU0890ag4B63cTgOyFAE0+4WPwxEnWWw6a5mr0E63lFSEANYzz94g9SQuG8+m66NlW0Tyf0sScp07VhGpJ4fQ222ls3TQwIFalYyRybTQRllmp/5DMuI8lq8jwp5ziikxK/FUHUQTifqA/Cx3RED++Ydd5sudyP/DLhMN4HBKEgnJo/iZlGCP0cxm1l9/yhvgDcGCxsw1u9Gl2Uszipd2iK7D99Pa0KIak5uTClf4na0ac8OOkzh3WOUCg559up8U8LzUgargLERUgUnDEgLHp7fRyfkOCAzIGZoNHrykmDsxItI2ioAWNiTsz+cGhIvndLv6PJeACBv08cQMkUsXVylG8FQ73LiFybVVSWLvVm+6KN5KASmrXrdvIecws5lz6n9AK4XUYKLsRD/v0MAREw==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR16MB6757.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 318969e7-ef32-4590-b695-08def84008b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 07:05:04.0629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ciy9v9GmFKxHwzmnbmTb1BYo+rVYKp+eLMvl8tAnKTg7VALSspBp4u1YZp0QjIu56zk8tz3OPXqoycDwsreYUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR16MB4727

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
Reviewed-by: Avri Altman <avri.altman@sandisk.com>
