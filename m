Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BC3E54B
	for <linux-mmc@vger.kernel.org>; Sun, 17 May 2026 05:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778994655; cv=fail; b=phqUHyCjJPH7ykXrWtiIZ303OkjQyyn3buvvA5bJHlRvEYW3ku5nyGgzi4TGfeayWyYL2xT94mEMU43+Pct7+6nqISRIGBSMFwdURUxm0Yvu6aU81Em0JOG5QxnmTVVgBgXp/xcjC7SrL7MmjbYDmz2o3j+f+mUj3A7EXhevNL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778994655; c=relaxed/simple;
	bh=R2fr1OqHNpukzDsS/6uS3Itvgm+PI34HoUCvFO2mEOU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gb8iBlDTpPk6+gRisoUaqmJ3d4DdyeEtllbpaBdUmVFHfzc8k+rLgwx0Vu++raDXOgeW1BY/MgTTghfSbKGcLmX/psfvNZaLOf/WjBr6JvxKJ8rVTdObnsJ46rKFNOnJ8hOX0GFKSdvlm1POYSlvQYFd68GYRiMNRCg6EesDu3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=bAQjqTxF; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="bAQjqTxF"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1778994653; x=1810530653;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R2fr1OqHNpukzDsS/6uS3Itvgm+PI34HoUCvFO2mEOU=;
  b=bAQjqTxFA1IeWUDxCd6jsZi1hOV2IEhiA9pwtlfXYT0ZWTIk3J2H1VZC
   CSPLgCuYpa/sT6V/mKP/+aUjAX123OsAoQy9Hp1s/KL1hQx/8C1siFQvu
   zxrpawL6wf+hWGD7n9UXCNKKty5pinHmH9u7pbbDE+owv3ze+ippwvhnF
   ELlT3gJZ6Dz9GAYzfjZ0oMakN7UbK74ncMQVthd69hxEBjgt9pbRzG0af
   U7GAl6XnPXso5SOTzxHLaHzmLqp1rvzz71mwl/5z5w8Plwo2wCqVrwLfV
   KPQa8wNjpSZlO6rwt8Su08+2VY4cd+F3hfywr00QkaXSp7snjoNhRu446
   g==;
X-CSE-ConnectionGUID: RX61JxceSwmpRwSdW7iDjA==
X-CSE-MsgGUID: 0ojhJRcET5WkCcbuixkZsw==
X-IronPort-RemoteIP: 40.107.201.53
X-IronPort-MID: 22526681
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-northcentralusazon11013053.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.53])
  by ob1.hc6817-7.iphmx.com with ESMTP; 16 May 2026 22:10:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WbfNhZ5S6/hPzi7I7YD8HHvyR/8NWnjdWWsoHiM5f3nOiGdY6kXZwyyIM+vsKd9XLQFiL8SuJBQuCZaB5qog91+0wevNNb5BcnKn3KjyIaZV6SCsBKLuHNemBgzOSo5ZS/vBr+WifKb5G7vXVw/xAyTuFOE/I4s8qpezET9ZdXA7+9M8Jt3DsLQsdn33V1NpyZsx0GKPEsKFX44nvxHTQdGBpyRFCbHfpjO8qTjb00hYfRiZ9/LuvtnMSyGpXhfDtoZJLK/zJH+AckS9UcAAjVoma2gZL8Vr0psfDWklFN9Nk5hKHjm8GhZmjEAeW/X8LVI7rtK6thXYfie0vujFdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2fr1OqHNpukzDsS/6uS3Itvgm+PI34HoUCvFO2mEOU=;
 b=GLhB8kvz+dj+bxp91qCz6x5RwJFs2nP3RZ/N2P8KQ8vBfyjBPxBLllCwVFk99PGuRGgf7bpbxLZTfuLN1A1afSrd4hyfd85MYN4kQcYU0d0u9oJA++4KLntV4taEYhjOyxSiXaLTyMMycwSzzV+Mk+dzyN6BpQtcpoGitX7PMPjfLox7hkRYcVkz6o/NB3y/odZ54+upGzFVJVTTbu0ddPjqzGdj8Jvy2s/x9K2XbhzRJ33t6+zYslG1LREYMbGD+40HbCTTZ1YheM+CGSu9XOHAoytsvOGahvFjBEOQXJ51YSK4PuZ6Pd9H7NK2lFehro/JhwIeYQHeNGqF+LGoaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 MW5PR16MB5024.namprd16.prod.outlook.com (2603:10b6:303:1c5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.22; Sun, 17 May 2026 05:10:44 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%6]) with mapi id 15.21.0025.016; Sun, 17 May 2026
 05:10:44 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Torstein Eide <torsteine@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Torstein Eide <torsteine+linux@gmail.com>
Subject: RE: [PATCH v2 2/5] mmc-utils: lsmmc: Use external .ids files for
 manufacturer lookup
Thread-Topic: [PATCH v2 2/5] mmc-utils: lsmmc: Use external .ids files for
 manufacturer lookup
Thread-Index: AQHc5LMptf4SKUAotkuNqsDTnTCiFbYRrXJA
Date: Sun, 17 May 2026 05:10:44 +0000
Message-ID:
 <DS1PR16MB67535F964F47738B8E7E26C3E5022@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20260515213747.1452692-1-torsteine+linux@gmail.com>
 <20260515213747.1452692-3-torsteine+linux@gmail.com>
In-Reply-To: <20260515213747.1452692-3-torsteine+linux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|MW5PR16MB5024:EE_
x-ms-office365-filtering-correlation-id: 8911e4e7-bd44-4a16-f234-08deb3d2a65f
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003|3613699012|38070700021|55112099003|11063799003|4143699003;
x-microsoft-antispam-message-info:
 TJztpvGXD/CKcJlzlnTyyDcDWPGA5cyAbEQOjrMgIT+i/N/10r3Y/P6yhDlusIjXyhkQCz0OGgNzpXG7XsXNifhqMUY+U0pEu7zxMvhDgGV1UYIzyaoJ1vayUmX3jLp1uUf7iA2ZFQ+YC0AERN6gxdnNT26EN2hy95TOFuxEN4hWKuMU8l+vJxdPIKZU6cllPCJc92PJ9vNcIxB+vzvCSMTeCR2vR78ZNgqoZEs5PYbhT1jFLi0W+alF8PbqzmTjWW5ja9eLJwed4XRihoag75MTW471zF+D+wvyf3STXLDqwTEwkuwUGy+VNIHCn7/C+5ET7f8gZiF7KywZhDkXkwlEfYLxbA0OZtxOn/BRfhm802S0kAb3KFQ2SmXzB6dQi1kGuV9ADHSda14xquRKyhkrxPCjv3Svfx6vs1YQXZd76DqesasBFXPwvZDzNmi08fo06OsxPnElVXazzWEXZVen5wY1DVPxlpj0GMjebSOnpZrVmRPM0FWxZv304TvPAzwgYhhL2egalxamYpu9CGStaC6MX/KeyUnnB7uTNaS4PT4ZYpYO+mTG0AUY3E4V+57s/GRdp+K5lVHHBRDgjABUtAqY/osMCZrKxtHcewzF5TPXQw37wJo/+IQuH2254PKRJ52SdSkxCGHqMlAN40KIJiogLtoLR1ualtOc9x4pO5YfyCAFS9xaxKWgxIHi5LLADLTvYugeCDCnIqBRXsqgv2qeFmBZWfgszJkPNsHQ6TJzcNMmTDOQNgtIgT5P5iyRbniCjJ+OaqKzrekrxw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(3613699012)(38070700021)(55112099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CJsda5m+RysmvG+Sn0tCo8HqoETNFE5hH7Brizj3LtmdbOlVKlZUUrFDoAVs?=
 =?us-ascii?Q?fWxkaWZOdyFR0vodT5HQbep7pi3ILAQOWmefB5Tla6frDeVBUEkOovRNb5ys?=
 =?us-ascii?Q?QWH78fwd9tynJh4mSlLHrLTkydQ/U3OWXjSbRRlnZTRPOm9GKxULWS2Im5Y0?=
 =?us-ascii?Q?ib/hC2kvXWjgwB+rZXVomXC4Z/7vOF2eGLJE5RC1n6FRb6wLQWH1HNrKExD0?=
 =?us-ascii?Q?D8gJCFqj+WzST/vkZSVZEq13Bnu6Egr1a6tgHnW35iDGxOrUmRVhocPPapHf?=
 =?us-ascii?Q?jeJGpREPOA7axuzpMBIFtXY5JP3UBcinogEzIEtqIHtvkxFtjgKnDpJs6r9S?=
 =?us-ascii?Q?QUA6TuEz0Bq1pRPvJKyOWstbJNDX5Nh+ZzJVaF2BnDAPc8SMr4voQbhSwX0P?=
 =?us-ascii?Q?VwBmiFc0pEDmsiD4NCSeWjkwRxEvg2atQRcksRLlVY9St0NPQGtTTdQuaQfd?=
 =?us-ascii?Q?o4KhU6BSWWuinwud/fnRKIbTajtQH5yarzDLhvELw7dH3L6mQ8cFnHPPBgHF?=
 =?us-ascii?Q?PYquc/Whln3pr+2rdW9KDpRKwB97RMgkrvEQL8wHwD+tisNZA7O0kkvVp2Pg?=
 =?us-ascii?Q?aZeEvCp266g1Ta8K8EXXLMSv8dEmpTSM8Q1i9KGgJlN5m/f5dh9v9yre0Y5Y?=
 =?us-ascii?Q?cT3ORbmsVo9W/6qStfpOW7n5J+6lLIeH/mBPsNVIjAPj0HVtg0A0dfK7N0RG?=
 =?us-ascii?Q?eT/KLTjLo+xLVVrvm/Kg0llv9Eq+JGehLrpYMfaP6iydTmm6h4YLqH3vzsvo?=
 =?us-ascii?Q?LzwbKMJ7tKpO6AkRBVbyQXdRDVpREy3gT2/uLnDPb3SXSLr5kZ30vMP/odfM?=
 =?us-ascii?Q?1+CR/DJZGX+slFlclZClMuyI0xDKKamxuJfTUIJzkocVoE4yYAKqiqAp+Dzn?=
 =?us-ascii?Q?UuS+5f7SgL20PuXJtMt9ew5L0hb5DBeZyGYIDHvJ7pvTPdtuuOnjIpQHUDGZ?=
 =?us-ascii?Q?wzbGEyRFqKemnx5OClsuNxMRN4PKzm4yRlgEffC3EF/vpQQYYu59B0J8lQaz?=
 =?us-ascii?Q?JPMetR4YGyWGim/MRHcw3Du9SngsTbyH+iv5MQnFY6BVh3PY14wQkoL5l9Nz?=
 =?us-ascii?Q?t5/jYF66vDb+OMnY6CAYfPgtNJadQ4l3NZM7ShBkKePuYfivfb+yGqf+RJ10?=
 =?us-ascii?Q?xCCIEFIAHmKYZTbGwKhM6j0Sc/awbTOm2aXQ3hiMPo94muJYJPse9TwSQ4Ht?=
 =?us-ascii?Q?KNK8QmEaMhhPEcswqr0lRcUDaxViRIP2SVDvUwhG9Js1+swLDtaXsC5+tc/o?=
 =?us-ascii?Q?T8jAudu84ZLBXo4vzA1J9IPuROVpoTMtkKztREoJb4ntPlKMv1vjnl37KN5k?=
 =?us-ascii?Q?U9P571WB2Um5/eLpDJ47FqpJszYK/KfSYuT/DJLmkf8YlcerecaYg2Bz1quB?=
 =?us-ascii?Q?anoO8h0z1uOxiaw7f3ygzM8Om4y9YdslraP0nbMqRgeTZ/wVmoO6zyUxgfZm?=
 =?us-ascii?Q?8eHPP4BKjkSjsJDgQqn/UGj/8zwZL4OJlMysjx6DRlOtvGY0l7qEVBFQDYC9?=
 =?us-ascii?Q?KxO3gKDN5cS8WgrvMKqTfJX1TPFh+JzTLwJCAkUCaK2JFPnaGo4/NtVB3yDe?=
 =?us-ascii?Q?59yjexSonhSTINkaOY2kegRCDnqD45zznPVC0BP7azgN7Zm4jtsXZMMVhDjq?=
 =?us-ascii?Q?NGayH2ia1+kIZIAyjdeWiVt1MFr5A/bF6wmJWauhzAMzZ7JVgO9RHsDjL3po?=
 =?us-ascii?Q?+iPnr3tow6VCRYPBFBPHDRhWm0D+xAwhq65SLk2QD+6qSAltRknjeLa0VGSP?=
 =?us-ascii?Q?bbWIaxp+GA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	lodblGkDpjC8lrZvtdac0Y6QATuYAyNPZMM3uDXYJm1peK00H3U4cDJbqKQ3tU0Yic2U0ZSKb6I+aTP63qDsPb5j5SZyqM0fUBIKqVEkwVywy+G9C3/Q6r9N7Aa7pKGGmMVfYbDTFno8i9VARP2hlxiFSjU2jNRoMO6nWwbmgTsr4/05nygastUtFP0ItZWuPb7FPOetF0y3aJ3S8tP/Aa2eW98mJ+NKOPxrYEXKd/lA9KshLgODIERfVnkgrYVkVwQyT+itf2X9lBEO+N8EPxZ6scfyaAofgLw65NYpyG1WfAnYl05G/8+MDkdvlYHAw4fl+3gn9J3iAWtxhiVo9Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TUtfsfC6Qrjk7vIv2l1eRACFCGIC4wbUP7OwQrFFiCrAK601iIwYK5Po5Vkk2KcAdLQtzQ/2yarVZCjNGs2qMMAyYECJpIfjb8AAtDIJw+90hemvmvAo/xPowcmfyiheRycmY3/K4OlA0Afl1aes0wOel0ZDOw0HD3+yhHIi7oONRUJW1cpRQov2cncnLNlsKBgueS0fIV7CLtwihD5kL9n3pdLBlQOk44NOB1fV8ruzgWFxabu0LcmtwB4V4fgPRHQ4kKn0D/XanmqzMvPRG6rT/xmKPdURg4e7kGgY4NoKJK0iWoHvPJ20lWE7hLvFLSwEJJ1QZafrT6d3bVU53IbbEuztOWUWX29COy4IkSiiIJC6mBjufQ+ZU05khzAWJevAptua+iBVyY90hEXIS9ivECoh88pF7gBdOTx9tIAFgXx+bUJvzxIW2xeejag77y9TlOwqSrcZrQt819xfBl9WtVatfZMLQTXVDVXGoUt9Z4Ci6FRUqDxGYkbHFeM3weQNH2OYcfR13Jh1DQMiGAQ8Mepz7soIqSp4tSkl3Iq+Y7wicPVvPvUnnkPYlAaaD5xMZDCG84yDS2Wu8Bu2PH/weR57pkaQa0/pZHor4YbnCSxamOhIPlCGxhw6b5Pr/b5JN7E110IU2Y3UFT1vHQ==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8911e4e7-bd44-4a16-f234-08deb3d2a65f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2026 05:10:44.8590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: he8wZ38yhiHiqvvfnmPAZ4NbdtMZNlREv3PO5+a+Jz05WPLTZ+qJP92vXrJa7PLo20XjTeWtt/PGVPBzocB9cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR16MB5024

> Similar to pci.ids and usb.ids, move the statically defined manufacturer =
ID arrays
> out of the source and into external sdcard.ids and multimediacard.ids fil=
es. This
> allows other programs to use the same database without an API, ABI, or cm=
d
> interface.
>=20
> Make the program able to read from the base directory to test without ins=
talling.
>=20
> Make it possible from the Makefile to change the install directory of the
> database.
>=20
> Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
Reviewed-by: Avri Altman <avri.altman@sandisk.com>
