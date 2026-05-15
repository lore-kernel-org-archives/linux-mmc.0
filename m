Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BAB30F957
	for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778855446; cv=fail; b=fUH4tKlH+9CYhZZdoOVD9rjpLPr/FJdr/JNLzvH6QAHOJgw0meIP/nMzJy+GgpI9gCzQP16K+NZw0ZDfKJj6lQkhsWjiWxUSO9EV/Lt9071yvlXpmFKI6GzFOwVKN2L49eS0yqca9CRPechEORcQAIlGxDqF2jc2NLc8SPiqaXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778855446; c=relaxed/simple;
	bh=nrGbZpAtOiAuylcnTSGzbIGNDhjVibz5nerHAsJ4c0o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kr4KCixoJi5XJleNieXsM0URA8Jm1Q7fQlpP1aY3vGZpCToy59yrEgFJ793fTXCCpj2kc+HARzhXkEXI3OOye33uwrTf87BpPYm3u1MEcUhflGXnRXr83gvxuDceWGm9Vxn/fSVbboYYIM6voaGpVK0gsnn0myjy5SioWfTQP9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=YP4PFe7M; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="YP4PFe7M"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1778855444; x=1810391444;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nrGbZpAtOiAuylcnTSGzbIGNDhjVibz5nerHAsJ4c0o=;
  b=YP4PFe7M9eT0zU2SR5sbikrsyNhQw1Coq09i9dJJNWabh/xX+bHcnkGV
   Gyhr1khTfikzZ4nDAu4FpcgN+k9i7RNvFPBuR+V+EK8TynHAMpt7WEKde
   6MDVdVAyFup/nJISGfCND1H6XczinmJ0PQn4gs3J6S2D195MyxSyCGtFR
   VxdbJ64Vtv6+YIpRimQkeCkWMNTw/vyW8ZK57Z/vR4nKZ0qLj+s+3EdBx
   HLkKocX8Ath0MnrWJ/gAO53ozVO3iiRaLSK9tlOfGXdGGEU75Mg6jBgup
   Z2dtoJ7rNkOV36sR0fCwBC0TAyK/F+5xcWPd9FBSObRqK6CtcFce4EVYG
   Q==;
X-CSE-ConnectionGUID: i/x2jQ2qRvmHTsreqJu37g==
X-CSE-MsgGUID: JRty3c+fTPOXSVz1E6DpPw==
X-IronPort-RemoteIP: 40.107.200.44
X-IronPort-MID: 22589499
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-northcentralusazon11012044.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.44])
  by ob1.hc6817-7.iphmx.com with ESMTP; 15 May 2026 07:29:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLvwmxwVVJBuHtdHSzVBjkypn/2hZT/QZY9PeaRKBJ1hcPwhEDhSXnNIaWJwtwFtPZwidgeX+AIdl2jb5kZM0YDRrK4W8MpC3Q5wuaQsDFV7LY6sUTxnTpXotGdVb4UNkuJH1WHB2HXDcf8ae104EQoe8jHIH7TwF+zU4nv/FuWm05OblBd+2Mf4yY0ooKIgfBWBAyw3TcoOhcI6EjOWUs59Pw4B4XjHGuNbkJ035t14dBY9hjri/FVgrN2PKDyMiIq6pBc/bfBANQzZUmrZwMRS2C7fOBatwKmMuCWGcFOutwtFX9NS9xt5eb82+i/oPbSlStwHk9urROCOu1JbZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/niPYEqTo+6hjzZnd6X9tVNVeEjAgpiDRS/wcC/D3yE=;
 b=GqpxnzGoPm2IsudXEyHnu0MnbRUptqgYDKujQ/tTVLbVbFabOzQKegoLY1FFjya8ijJi+Xp+Wocy99js2MU+4W+RkDIF7H7UF/alCNa1yJGzQSBHh3Y4QFOoEOg6tseE0PSJ0bh4ytIBYWW5Pw3+VNwYXydHgWzGMBSbTVL1Zl44k06FgwYZrvXy90YNEMdRTdh8nmk20kyD+QPEGAyrWXHONQz6chW5AaLoKhbQs36mrsCIlGRoNcPKqWhJtcP2LAsetM75mZTYTl+E8XPr7dkkWxmG88iaYpAoaKt+3MxzYQ8t9N6PYT6krlthJA+sao/wQHph8JxiW0ca/l63HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 BN0PR16MB4365.namprd16.prod.outlook.com (2603:10b6:408:160::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Fri, 15 May
 2026 14:29:33 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%6]) with mapi id 15.21.0025.016; Fri, 15 May 2026
 14:29:33 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Torstein Eide <torsteine@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Torstein Eide <torsteine+linux@gmail.com>
Subject: RE: [PATCH 0/4] mmc-utils: improve lsmmc usability
Thread-Topic: [PATCH 0/4] mmc-utils: improve lsmmc usability
Thread-Index: AQHc5EYsnUJ8HpUMLEmA4IQiTNAj9bYPJYfg
Date: Fri, 15 May 2026 14:29:33 +0000
Message-ID:
 <DS1PR16MB675343BEA9DE94B268CDE927E5042@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20260515083457.3690804-1-torsteine+linux@gmail.com>
In-Reply-To: <20260515083457.3690804-1-torsteine+linux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|BN0PR16MB4365:EE_
x-ms-office365-filtering-correlation-id: e94a30ee-af32-4480-6956-08deb28e61f8
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|55112099003|38070700021|11063799003|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 ADpNMAn7QcgcSTzZD6S0j73r07/em9GQ6iuPDKrNPUkUv2PS8am1XCo1pyw3YVpDRMO9CTt5GD9gPkTgrxFoeQVeQemmscPA5BDr0VwG0UaZFejMHILLY+yTk11tb4pVBpqGb6lkaNbVVLW2w+o6C+JRX7NWhd6Ea3uQAuWYjADms6IKk3t4kQm/z9ZDa+nXM9L199gYDCYyD8+i8gWybUEYzG2GnKO6TYanwYHzYE9yUzg19ucJgaBl7XrABgxrzm3sMNamPPpGJb+rDOda7PwOHRNO2ExwxopvFJWvfjYtq2/42zFV6qcCHkfV9e0dkVZy7dH4HDjlKBhxoL4p+sDaxo85JUArACSTeYLiIxCk9lYV2UIjxcOJoDCvyGCKt/0H6RgoC32L3MId2RQqGRn1UOP8/2o38JTJh37iXRIFxTTo17+RgskVjkZOGwsjZUOPnp4XI/DY2WucNG0OfRpTIrck/tU83yH6jWI89Sfu1NcwC3ezgJVnhyFMKI1ObFotJclJHkqQHtBtBXOdVwGFMHCxNOzOTQj5Xk2r1mID9Q9JmtZWAgRaLcdDFjlysOMdnc/2BPVmpkrsq7YtzJUHu7Im9Tu6pq2y7bCQHgasQ6wYIU0dgqu+orH01GpMlZrw8KjOUoUarI0FOARMqSNLLXP61OMYGX8SbBQ24vQQI030QtGGg8npm0PF4irj0QN7+f3Tw5SWInW7n2R19C/2+lKeiFYiYEq7rUHRCNbazk3fNgGwrRe/9Qhz6JNq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(38070700021)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?//XPQMBZG+r9U5/A/B2lZ4K4/ah2rkgB33+7YAXXzZTOmw5aCbBdzJr78TeG?=
 =?us-ascii?Q?zOyJXzA7wyrj5PAb8JPQwgg8KWByA5gTxkNZ3R4jDSblcqAyyMGC/JFnE+yD?=
 =?us-ascii?Q?PKG6pawd1f/Sgs1bZCFY/oY2GqkTNdSQpDM3sPgO7DuEHd8UnciJM4XCVokf?=
 =?us-ascii?Q?/srGbIaxQYVFIs/Vr3tcgzfgL/68Ll/aCOuDYX3lEttSP8ZyT93F8/33TaBf?=
 =?us-ascii?Q?mVb8itpK6RvBAmF1h4DmEyAA53fKepj4wB0v6lGtf7e19uRKwIIkibKji7c8?=
 =?us-ascii?Q?3YK7IWxE2yaXVr3bCPfLmTH+Pu1hlsCqKZ75u5L4pUt3fMLyr6YVKPQgaQcj?=
 =?us-ascii?Q?yBXx8/B5bhdGzPoFOPaulrSY5qUx2IvdxK5huhOdiHxWoXr0cp+WYObtpSVa?=
 =?us-ascii?Q?uFvMEIfL15LyiKaCWHl1QcUs6n0XOwU+zEANfkl82o3Gd4qcBlpOJOYOTU2t?=
 =?us-ascii?Q?ZokZc0G7Dnlti3DOTgQt4pt6XkC1H/XRwDGhzjgSMZ4r+IcKJSUE97+4O7EX?=
 =?us-ascii?Q?CKBAwbhQUIzZedXRnMPPVe0rgqEU+fI9jpuaLZxmhWNWdcFi47HYu1EA8cc2?=
 =?us-ascii?Q?KE4WSM+BCTmg/d3Fr7eJvXfI+UsQAEmMYW7lRwvF/NLP/nbG6aQCwbDV8LKx?=
 =?us-ascii?Q?L2c2kvvl9niHccrf2g9aCtBG95h+KhfNIgy0NYxLWztO9/rhmLgXaPmHGwrk?=
 =?us-ascii?Q?LjaGOkfDI3oM5a/QTHHoK3dFGZbX+IjUXZOR2tQrckIUbW+qXaYzpiOQX41r?=
 =?us-ascii?Q?l7y+6vH5tMLTRZL/PqtLKr9zA/7QwlH8gVtMot3jpt9y4C7B437dOvYdbIk4?=
 =?us-ascii?Q?1bp9C4BwukicdgW5cAjZJdK0W3xJJKQqqwDOeKKR/YJLzGLny5I+EzN6Nhv7?=
 =?us-ascii?Q?GT88drIXHTOe35Ry14N5dcXIcsunfI3+suZfCc1Wxcq8MMkjEdqnKTLj7diy?=
 =?us-ascii?Q?qD0lGvYJ0u6t9cicvWZ2U8Y7VuSTSEGxMxZ9DS0H50qLz8qjLNYxrsl0mK8s?=
 =?us-ascii?Q?HjPONujVFiTDbuyaof1aLCX0jmvkriXmI0ST4sBgUfVb+4yNcCn5oG+jrGBQ?=
 =?us-ascii?Q?cqxCqB4a+Q1fjz4m4PqAw8xaKtveAcS7tPWGiny9kaG5Fo0dRak+EY7Fj5h9?=
 =?us-ascii?Q?hTwn5PVlt6V2cB0/u2rjujaP7ljpvwrAe1bQMLvAD1EB2SNR5e2KksoFKoxq?=
 =?us-ascii?Q?+UM+uL94acnddxSkO8LEpoxkoegNXLUuFNdyGHpk/KZLuPtRpxwnC0mRdFvy?=
 =?us-ascii?Q?AgjjpV08dlFMgd7A+GqcAHq9mk9irWgt13mAGB++eJi2bjsXebWQr/gK9p0O?=
 =?us-ascii?Q?UuwyVFwwjZW30iTP1GEZVzjvwSdd3/UziP1WgBRnAnuq2+7dNJ468/TX7DkD?=
 =?us-ascii?Q?TFqiqZczQkvgmSl+BK+fR0YbDEdKHalckPTSoFCCaRG/DHIU1h64uAQ7Pdww?=
 =?us-ascii?Q?YGj2weiMm86KGSZbKfNZCZWDsmqUt2dJoN/0cb3VRf/l7vVnmESKDs5/Q2ee?=
 =?us-ascii?Q?wHT78ED66J2eiVSf5EydqbuEXebRQDOhcQilCz6ZJMTlhtMhY64pkeeoSdgu?=
 =?us-ascii?Q?ln5onJ3K2h5IgUaun//kXNoyC4sZB/y+s4KgNYmdxj7cIfKKpRAgGvaEtMyh?=
 =?us-ascii?Q?oqJ7VxU0bV5DIqUwkgSgy7kJyvPu86dEDYfUubGHPVa9ioQZ6Y4Y4tjuF/ce?=
 =?us-ascii?Q?agpEFGppX7g+cwSuikrGE3+5wu23NsWLLfb1pS35rBTC//c6+AYt/Ryr2ph1?=
 =?us-ascii?Q?i8mPfNvHtg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	kPihzxvq6u8cX+R6EwwTuBPeMz0PIA3lvdGVlsySLFoMOfafDo9K7oCseL089mJT31228bQLoe3tHeHaF7uMSTZoDPTxYqPU2dB7+T1nayHjAERLocmaU905Ugj3W/Rsb0H/BPTuClWKsl0JLmbWQRjdYU7/Th4/523VH4nlTDEu2rsd5GdulS1nOLZWofc6yZ+iU1fL+qHP3qQirj4uEm5CRjTFI3So+czkhHpFakMqyvGAqFDIUTR2iQtYvmeeQT0MRC2ZGZTNPxcExhAukvCzwWdX4BbJ6Jdz3Yl42WSa//GGC7DWlNI6ZU/bzfCt6oSnUGpIpC9tb5mB1k0lhA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	949GCoiC2/4r0b2PnNWwdY6xnvxtVIgQjre/UYmWmdI+V4CHt5xEAHvcFx5JwmGNvv+K8b5WdR1ZAfZn5e3spUWny10hmdLYcruT57S2n4KgqlnrhN03v3QZIlLWReBIYrnB+APIcTZM+rKvICkNgggf34FIAXpx82CrsWGiziLyB2558hhr90gBtxB1cyX0MyVH99LO2vh5hZAxAoaWi9hpOdDkIqqP4SnnR9j6gEPQPiGSnatszc8tlyFnbPhWTHB8CN9DJyuuoEPeewe1rKKzRkl6woNOYCQ4NV4X5dszOD8AXB80HD6n04NI+kTTdJPQc54MZVFEl/K3tvsUi3xCDDcDwgnb+cRhZaBcSxhsF3tLPFO6UGD1kB8YiXgGttp0Gnz71RxFf+ZXuxlxRfojRKb1/lQMWr8UXAd/YJPoH/OXltcBAerq5ORAA0Qb9REE8j/MpZufk7LG5fFsEdx8HgEJWORsNMDRSCBpMzznpmFnQQooSXHiJc7wwl9aHremFwpC5SVpAOb7i1R2ub5BfhgfkBTXrXOz7fRsfgjDxyUcd15TaEM0WuSJJPise9V9zBtOq/0dy8DbPuH9hAtCMnN6mn6cFgOVsjq6CckddBQXhdYUjxAC4E1VOXaq8S7RyJzeI7TbFoF1aVGiyA==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94a30ee-af32-4480-6956-08deb28e61f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 14:29:33.1669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UvYi2ZsidAybC+za9VqSbndA65WySfJG6jTgCYeymd2XTxvGlSJs6eblgWxS3HmNBCOWv67paWgt1T4eYukuyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR16MB4365

> Resend the lsmmc usability updates as an ordered series after the previou=
s
> submission could not be applied cleanly from patchwork or b4.
>=20
Thanks.  Still having some troubles applying it cleanly.
Please make sure you are rebasing it on recent master.
Will review your series anyway.

Thanks,
Avri

> This adds external manufacturer ID files, accepts /dev and /sys/block pat=
hs for
> register reads, adds an mmc list command, and installs bash completion fo=
r mmc-
> utils.
>=20
> Torstein Eide (4):
>   mmc-utils: lsmmc: Use external .ids files for manufacturer lookup
>   mmc-utils: lsmmc: Accept /dev and /sys/block paths for register reads
>   mmc-utils: lsmmc: Add mmc list command
>   mmc-utils: Add bash completion
>=20
>  Makefile           |  11 +-
>  completion/mmc     |  62 +++++++
>  docs/HOWTO.rst     |  77 +++++++-
>  lsmmc.c            | 434 ++++++++++++++++++++++++++++-----------------
>  mmc.c              |   6 +-
>  mmc_cmds.h         |   1 +
>  multimediacard.ids |  16 ++
>  sdcard.ids         |  23 +++
>  8 files changed, 452 insertions(+), 178 deletions(-)  create mode 100644
> completion/mmc  create mode 100644 multimediacard.ids  create mode 100644
> sdcard.ids
>=20
> --
> 2.53.0

