Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79891DDE9
	for <linux-mmc@vger.kernel.org>; Sun, 25 Aug 2024 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724592799; cv=fail; b=ktbNJXIwM0P2eOW4gxOHDM+PBpD/FD/cmCwWSs9xKhpApEfKHNtx1+OMXilw4c4x2CcaFZUSduddoiim4sZsjpYKXm6VkhAuuAXYWG4rA6S6ILKu1ueIcf2RkiL6nLR9nCuyKHb8Pf00b+mFH8ETrGdADvwZgIVTCo1EUsi1oNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724592799; c=relaxed/simple;
	bh=cEUVwAKzb/luzJojz/d2BoWbVQxzrWTqdNLTaOqCSxA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BpX6jAbx1K3GJ6MGD9TelbpdT6V1Pi8N/8h9ZL+INBc9VlNpWqPZOKE/4ZcYJNAOOJ/9pKT+qoL1GrlWAVOLmoVbZv1oTgg/BIZSCVMANnq9fktodiUDhqwA3M0vC1zlbkgV+ybkaMFND2e4ehrX15BUONNKxpN9x49lwSluXmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Q24kXaxm; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=fjWJub/4; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Q24kXaxm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fjWJub/4"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724592797; x=1756128797;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cEUVwAKzb/luzJojz/d2BoWbVQxzrWTqdNLTaOqCSxA=;
  b=Q24kXaxmeBkvSmETa9WSHN324yC0ejt6aUpjjo7LCyL0d9Aas9VwcsW5
   3uhHDTBRgbXkGtH24y0X2xdn9Aq+H1MTFF522Xchz1gj/FBaEYjnJt4G0
   G4nsknV4h8HZDrtntBY95veG4MN7PT6ZKTNCeYRKZjiQZaXcXcWXCqJVU
   NDz2VIWf7MTwKkLpwS2xgoF8rWCW/x6i8V8KKhfqrRMXqIHsHSZzUc7RO
   0h05taUYMrRmCQNkhicfnn0sNyHFZM7rhg1bH4GYvi85F7edvuNvAa892
   nHyIhU74fdwKj429j2GmcqSJO1Npu3Muh2570Gl51l7Yh95LBsowYzuM6
   g==;
X-CSE-ConnectionGUID: VOjQSrzRQ/m4KLbRCUm6lw==
X-CSE-MsgGUID: QuIizL0gRqOW0MfNzlecpw==
X-IronPort-AV: E=Sophos;i="6.10,175,1719849600"; 
   d="scan'208";a="24496857"
Received: from mail-southcentralusazlp17012048.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.14.48])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2024 21:33:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xs7e3P8Lqi+RPM/5Yk/mkwppZRPVkYVh1bSC2AoaXnTBuH0HdzOrm6bqxcYJ3Jwsb3glMrNMrS4/FDUg4qKjCp42uOCROCEHSaqOdvhSXYvlQ8lHFEAQC8POh2A0xWJkPDgBFVNC3iMhOcErZEAbgbhKrDwLFbSf6FghvWPNVbF/oqkNBLItWd9+kmPFcgyh6lY5vsRbNhgQuxDjIlN7fwdocB5SXT+ljtYKEzgZNdEYAsN7snd7UsQ9KXDUFnsVco2P+IM3F1+w+HLtg3bOtx7+LDkJBRUTo5BaTHa/eB+jvf0LTom50L28jhYDDA+8nBOQyHsgX98Pr6AkgwMHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8c0UWazbWpmYVT7nmBM2saF9p/Km1/Itd3XmPypATPM=;
 b=pK+pi3uHkKXj4cqNTwGLBD0NKe0clkmwNsNL5dgBaEnnBGb6reCp5mPB629FodCcyKR3WCr6DdhZHdQWTCfhmbXzkKoJ8lU9PV8BcwYNP/6bfO1rFttyRAhnkn1dZflOjAdG7zbCtborcCfLcQBZnVbDrPWPiyYB4eTjcrT7KdO5EekIk/vJh+TMZ5yGtIf0aQQrw6dmJYWSyYWKELKN9mdH6HvJGr55LvZ30RLyTgLdRni5yxXtWd7aO54OGFv2CFTnAvSxHokQSiUfdrcfuQpZ/do1ybuCKe6PwrAWODR9CnT2MV3zkSyFSvGcM7FL803Frjg6OeG9O88lhQEJ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8c0UWazbWpmYVT7nmBM2saF9p/Km1/Itd3XmPypATPM=;
 b=fjWJub/4aUj1fecVwMtgW0CTHHxISFwaUQ2Kb8Sr7G5OI40PNXTQaQF8+9MMGmBR3A21OmICE1emT1KpKNTpdmGHnBoTHx9/S6eLZSDDC10CBtHP420jZzGujW8OU9qvBEOiJYw/u5c7tRrpOk7yymsP4nKAOv6EYmVbfb+K2rw=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BL3PR04MB8153.namprd04.prod.outlook.com (2603:10b6:208:348::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Sun, 25 Aug
 2024 13:33:06 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7897.021; Sun, 25 Aug 2024
 13:33:06 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Avri Altman <Avri.Altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, Ricky WU <ricky_wu@realtek.com>
Subject: RE: [PATCH v4 6/9] mmc: host: Add close-ended Ext memory addressing
Thread-Topic: [PATCH v4 6/9] mmc: host: Add close-ended Ext memory addressing
Thread-Index: AQHa9sKCMnT3N71gN0SbTsX0y8dWBLI3+Dqw
Date: Sun, 25 Aug 2024 13:33:06 +0000
Message-ID:
 <DM6PR04MB6575A63BA23235ECB7691676FC8A2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240825074141.3171549-1-avri.altman@wdc.com>
 <20240825074141.3171549-7-avri.altman@wdc.com>
In-Reply-To: <20240825074141.3171549-7-avri.altman@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BL3PR04MB8153:EE_
x-ms-office365-filtering-correlation-id: 10022304-2bee-4407-b70b-08dcc50a73eb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2ZA0aL3gQL8h3QBCviJoDIUCHX9IRJ5LKPzfMR/F8LtqtrlIXBx0+aI6wn14?=
 =?us-ascii?Q?vF3QwCvygjUNo9rvty3HFjvQ4IBSO23FeKHMbwFSvNFCILTmJ2JinkT/ateT?=
 =?us-ascii?Q?l5+0tlnBO+PJINgQDsAj+ZjiWq6etwbU7AgCbzpcn+f1jOsSqlEwg+MdgBUE?=
 =?us-ascii?Q?fY1fSggZITdIJzIotWfGdKhQEvOfzGSKT9a7TPfcT99497Wpl3xYr5OZH8CU?=
 =?us-ascii?Q?ILfaHe/TBrR75rUeYyef9xXxzgc9UADOfEqqvCoKQwu94ZWxyIrrvD6HBqqJ?=
 =?us-ascii?Q?DovC4WN2qsOe17qKHw4BiOdqmoP2F7jpuRneGSMpsOfjYjGDMHFCb/YxqQDU?=
 =?us-ascii?Q?tbBeeiNA3HQC+gOG+Ws9x3/xc4O1vySaxZHibRDOAY/nHZg+HrXC52g1L5Az?=
 =?us-ascii?Q?TF8s+uaTq5Z3muV5yN6i5DE/9jojC7DI6euIT5Zf8V/giLJETSxHeFzS6xG0?=
 =?us-ascii?Q?CHhEymIMXS/3AcusQyI4j6AUMgSpzdKhd/nUG0Gr4bOdUx85SiTfK0xaCJxd?=
 =?us-ascii?Q?PyFaSdG/SoEjvh+yR6zz+fH7wSvXTcDqynvXAQcfskHwRa4IcN1aTvMuPUF7?=
 =?us-ascii?Q?p9u2syvFyp0yeT6fSLKZjahn73Jq+Fsp2qpB6C24jld5t8XN2bUaqFdD0wxc?=
 =?us-ascii?Q?F3qN9DtIE/lRg1VZl5VfmGDRmmeSZ75tIgNpuF0Z+OlaE+Z9nfo+tM81vGX5?=
 =?us-ascii?Q?UZDkA/hbOEegA8NQmAQIq0W76W1pTjodpBwHLzkVNp5DJAXDOBtx1WXIrM04?=
 =?us-ascii?Q?diBcbwZy7Ha+XDaQAdgZSmkhtRErpibDa/dFoEVgFpzqrhQsbcE1gwFGfZ6i?=
 =?us-ascii?Q?uPN44AF7omTo4fUErPIIGRBciOqfg0M6VK6wnHPpTEWYNb0XyAwZhSXpjUlA?=
 =?us-ascii?Q?Mg+4pDKfLCqH3k2RH2Fr5P+qrEYKkzX/y4QKzsc/ULMrSo1tnFcS+OsUqwuj?=
 =?us-ascii?Q?b9uRL9ZtZN2xcL7loXiv/YRkIN8HD1YQdaSdd20e0BULrrMtK1QpimLsogG8?=
 =?us-ascii?Q?ILU9V4d35EdA2ARt4K+PQSFI0Q92w7ccJcwvOZ2qUhL3rGswaSKr/MGiPmQt?=
 =?us-ascii?Q?uvfTYRXsxeBqmxGSkcsfj69VQb0uim7f4Fh81XARiJpH7PMU1xEK75Be12/M?=
 =?us-ascii?Q?iXfp6KK1eKEX8XeMD447jf93iy3SmNaA7aTp0OIYHnrwhCMKWAIx5ACk69Vq?=
 =?us-ascii?Q?RtGf7vCvdOr9jmfV41PUC1MSCMtUgYmYXtkVl/nXTTpXBct9RoCvCjfITP2L?=
 =?us-ascii?Q?IJVA/njkdak9wzLFAUGGfa9aavwLsRIWX565b6pxGM7X5+papKqqy3uzDJzr?=
 =?us-ascii?Q?vjiS6A+YLyNOzkgEGCRSysRmp8uGn2oW3ntUEQXskPc20pKLSFxhlOcqWxAz?=
 =?us-ascii?Q?TFHqfXJ+3ID5JdzzCpFhmerzblYqBMuNhY6O9mVDjjlBRAp7tQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JIqRBhsUOzoaVVyYsUddxLgjK1V3aIIyhzIVXu12JrMijGfdn13GVdsUPYnm?=
 =?us-ascii?Q?N++YDgYykc6DLDVTMFYYae/DdyMdQATOAJFo2D8oEPsc/2ZUdtdQ8mqQoa3u?=
 =?us-ascii?Q?WxkdrwQiA2y0IetYWg/Ns5e0uArffA30975Ztjb3LzZ3sfBQDCK3JgEVdMgl?=
 =?us-ascii?Q?2MP2CwMuuYZ1Usk/ewh5j/1trIU02dcB7yduw/O512dnA9vhOvAcOUC+rPw+?=
 =?us-ascii?Q?Y/GwxRHhCa4qrvxt/kDb39gEWADkJ6uQ29WxSXUfXCxXsBG9joshPDI7Ddzi?=
 =?us-ascii?Q?1MPCzL2qX7a+M8vXMYCM+kq956VZnuJlP+FZTim/gRVneioybZ/Qcua3ydcW?=
 =?us-ascii?Q?wp9hMA3/MrtOxjnQQFHwMEAHB3fBJVOEuPz6LwfxcPXFI/0SAPFQ97Cg/MjD?=
 =?us-ascii?Q?Pp7toZym6pTMn96r6TFv8vtKN94MqA1YUk7UhWWXWzuJN4U7ByQuKJB1KtLE?=
 =?us-ascii?Q?FNBO2IylNx1nCFsSFGmIB6ebDuxgFoFsDpnPNxGs7YSHwuKqKiJPaRN9opLS?=
 =?us-ascii?Q?qu5rxrH/uVYUSFPZZrpMvlR5Wbo+DKCg+76dQsvsRBMwZwxdFsZWAGqg3DIH?=
 =?us-ascii?Q?N8mRBsEteAnmjWg7vSgKFpJSTqxreafBGct7656Y3hSAqZz5XjW5zWF+NkV7?=
 =?us-ascii?Q?AzWku7VkcxHKd5HuFGrswH0Xlgou1GBwVfIYcjlKkSalnn2UjztpGe2PWgaZ?=
 =?us-ascii?Q?Dfe7yYDOlu5cXtk6La0D9pOKUegwAZTuN0EhtZ7kSxHg6rAqJQjNbXG0hRU7?=
 =?us-ascii?Q?cK6jiIPk2H9LPWGNrEbumwrodnh+In3fhaQdVV9j6H4Xmrcaq3cTka/0ILGj?=
 =?us-ascii?Q?sgqvA58wDHsBMCd05KODmmFBSTx4EeCWpoYl6MB8X0bZ7jaLWarKol+altgv?=
 =?us-ascii?Q?XEl6cu1OJYbJRaTcQNR0bfM9sBsUFshsbtBVaZ/ZxbI0AQX41xYEXvVHAA/5?=
 =?us-ascii?Q?MwcWlbrIok+oMtPdmI+6TvbEsyYc2J5aAcVPVh4SmR91XT17+rwKiTrW6n2+?=
 =?us-ascii?Q?J4ELKF8xO9ewZYvhuaEwKSl9XdOd6PJKG4xOBbE5rg1KzxLIkujQdlW1+7Ae?=
 =?us-ascii?Q?mTc18BzXioq7x1C7D0ys/hTt+TXl5zmO8qhhD+RvYzoGQwf9WxXx2Wm3xrhJ?=
 =?us-ascii?Q?qmGLR488q6KAmTVthsRButN6sXieV572KrHNwVOMWP3+YtJspF3868jti9iC?=
 =?us-ascii?Q?USwC6hWPnds1SlVHEUMVhf5DyXUoSopLdDURb+h8NqUZZCGWv/qSl52tpGSm?=
 =?us-ascii?Q?ROvLrY4cYJECD1y4pG0iDALgNoY+2MK0RQVTyWF6nvu6rYP6L6i1VMyMekNv?=
 =?us-ascii?Q?ZFMeTtNLjWIH6kjw+mIlxld6R8j64MllEYjteLW07/MyaGfQmJwYDJFJDbrb?=
 =?us-ascii?Q?+L/4gvpuZVXnJ+BhzQKdWtbLyciRT0UA/WfVQ3jzsYWpfeuZ5KM+qYVtcN1V?=
 =?us-ascii?Q?zDTgSt6kQmnkY9irilmTmq91VrMlfD4Q18UVUjoekWCc0zSH97mN4+Mnh/0m?=
 =?us-ascii?Q?vaEQxFemX8+7vidzFhfnmNIFiQyuaO7PsmXAC5Lsn2aEoAPWmcSN4mv1Muej?=
 =?us-ascii?Q?J4rCYBmSrSOfbfRqlhdVClOzngTuyNy43M1Lwr/E?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BE5rsJ2mhyVs2zRwS26EDcy7qFVncb5idGfRbPfeQcCCuoTvxKO6SkRIr7dztI+5vT2SvucqIqxQcPrQcIu8Ey6pInNIzq5U3wMGRvvXuIkzMP7efaUuVjAylbsSc1uJ6F4WgQA6HBxQ4Bf4H1PVGRhFhC7QldtZf+jnef5Y4rhNGW15pHjN2FCHb+TpqP+SZpn1/AJa4Mei06H5HygOL9wZatjez5BKv2ba2S/cdxuDN4iJHx+LyCx9YPE1SPsyYHPLgFolN8uK7cactSs3R730GnGvNViGRFwEH+BnhKo4KGObDPr1rxhAvKptQcwCttLMAfIPyYKiap9A5UBn9X7rUA2PSLlcnD3Byge07b56+HWZh0HmiDxgY+PFHFi9XuK/QjhD+O8R0dMcmqVW60CiSkm0rSk6L9onJ+n8oxxKK2os5yFYwqPk8gtMegp0cs0BWOmsr/nOzQi2JJV2wmiN/Iui9UUpBIMeJE/hQghbVHQdcoZplBui6srZlqzLGajhpcZU5Pg2zQi2K2tvg7xMQeS94dcCuORxMfWKHeVyfW6U5LcMakrvz5tPPctXREh9KVwKv4w0J3Ax6nacCktoo9q6IVNBA6GxZO8YkqLkRsUvksisaIF19cm6zipM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10022304-2bee-4407-b70b-08dcc50a73eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2024 13:33:06.4371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZqrZ/uMXzdj76MgSq3ioTy1Ez55npwmfc6Ev2CUIXKL8Mc3bYBDkbSrpgVyGQwL5YkXYLSnkmsarodvEgLXBLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8153

> In a close-ended multi-block data transfer, CMD23 shall precede CMD22.
> Handle that logic once the sbc is done.
>=20
> Host drivers that handle their own sbc logic, e.g. bcm2835 etc. are out o=
f scope of
> this change.
>=20
> Tested-by: Ricky WU <ricky_wu@realtek.com>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/host/sdhci.c | 36 ++++++++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index
> f62b489c9e9c..70c967029fe3 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1791,9 +1791,38 @@ static void sdhci_read_rsp_136(struct sdhci_host
> *host, struct mmc_command *cmd)
>  	}
>  }
>=20
> +static struct mmc_command *sdhci_get_sbc_ext(struct sdhci_host *host,
> +					     struct mmc_command *cmd)
> +{
> +	bool is_sduc =3D mmc_card_ult_capacity(host->mmc->card);
At this point, better move mmc_card_ult_capacity to include/linux/mmc/card.=
h.
Also better check host->mmc->card !=3D NULL as it can be until mmc_sd_init_=
card() concludes.

Thanks,
Avri

> +
> +	if (is_sduc) {
> +		/*  Finished CMD22, now send actual command */
> +		if (cmd =3D=3D cmd->mrq->ext)
> +			return cmd->mrq->cmd;
> +	}
> +
> +	/* Finished CMD23 */
> +	if (cmd =3D=3D cmd->mrq->sbc) {
> +		if (is_sduc) {
> +			/* send CMD22 after CMD23 */
> +			if (WARN_ON(!cmd->mrq->ext))
> +				return NULL;
> +			else
> +				return cmd->mrq->ext;
> +		} else {
> +			/* Finished CMD23, now send actual command */
> +			return cmd->mrq->cmd;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
>  static void sdhci_finish_command(struct sdhci_host *host)  {
>  	struct mmc_command *cmd =3D host->cmd;
> +	struct mmc_command *sbc_ext =3D NULL;
>=20
>  	host->cmd =3D NULL;
>=20
> @@ -1828,14 +1857,13 @@ static void sdhci_finish_command(struct sdhci_hos=
t
> *host)
>  		}
>  	}
>=20
> -	/* Finished CMD23, now send actual command. */
> -	if (cmd =3D=3D cmd->mrq->sbc) {
> -		if (!sdhci_send_command(host, cmd->mrq->cmd)) {
> +	sbc_ext =3D sdhci_get_sbc_ext(host, cmd);
> +	if (sbc_ext) {
> +		if (!sdhci_send_command(host, sbc_ext)) {
>  			WARN_ON(host->deferred_cmd);
>  			host->deferred_cmd =3D cmd->mrq->cmd;
>  		}
>  	} else {
> -
>  		/* Processed actual command. */
>  		if (host->data && host->data_early)
>  			sdhci_finish_data(host);
> --
> 2.25.1

