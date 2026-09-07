Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810BF17C211
	for <linux-mmc@vger.kernel.org>; Mon,  7 Sep 2026 05:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788758401; cv=fail; b=mVSBo23LZZ4v1XviKlBlulHt+89lFLX0Eu2KEQk+f9aajs5aS7pc1yX5XkOIEVSEglWbv9qwYyzzEER7nXcaOZVPkvGSVL16jvlbS70wcVyXvomH7aeZanC0IGltWPWqaYcsj1PM90T9NRtt3zx7+qWDj0GBiZPrYLgSMmdrRxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788758401; c=relaxed/simple;
	bh=r3lfK277pgk4I9V9g8eFUOeX6ekgimEZrYAtZ2hGjHc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PU5Z4FhBHjAcUXIRgplWWrPWUK99cTe4xrJVLO4pOtjJVvKYwHUIbuA955qatngTR0dEoBwyNVdAfgHow+HEc5MrcPJtRP7wXO6ksVmNRZAYk5cojzvt6aemt1v1DweXwlNc+kjKRgAzExXm0mG+xJiQVC/Orqti2onp9rdsuPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=LJ3yTroE; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="LJ3yTroE"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1788758399; x=1820294399;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r3lfK277pgk4I9V9g8eFUOeX6ekgimEZrYAtZ2hGjHc=;
  b=LJ3yTroE69GcGZyEEPNrjwJ6Kw2ZkAjCPFDHHLljR2eresTuLNoTC3jc
   uiGWXlBG5e3Hr55rCr60QEorLnIJJLhQFvNST7dREusK86aK5GauXb0on
   zX6o7s6t9KHAdJWyx3yunziEX9fs/PB4v8C6bvHsEXa7/VF/WShWLrV6d
   76wpWNdPKqbKLwKxXEThyh/QtW0NCPPMwFq2mR2BTqSWsVBWOEy3o1me9
   Ynone9h4daRNl0ckFr+vB0X8VefBp2KvNvYnjop3r+7qr5/DofZuzOWbi
   Gh8T/nyVg/a4Ne0TeixPoSUMQWpxM/syUy7sTGbIXvrJW7XV0nnizuH4o
   w==;
X-CSE-ConnectionGUID: eJS3VglmSvGvlhq1eugtwQ==
X-CSE-MsgGUID: A3NDAO43QxqcURSi2H/f3A==
X-IronPort-RemoteIP: 40.93.198.80
X-IronPort-MID: 29745535
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-westcentralusazon11020080.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.80])
  by ob1.hc6817-7.iphmx.com with ESMTP; 06 Sep 2026 22:19:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPcYzqvoKHtQcj4hOXO9aMFd9hYTKU643N7A0OJMnZeKqtWF1oFBJU7S5OjsRm8KGD0WFZgqIW4S3vUCrYqmrEwH007xWG7ngKhoAiK0WQF3azER/3JVbbjmKj4ml/hFnwU2qjiCVSvcTW6RaDBza7L8PVz1Ht1Kivbf5+SyTFHBgboPMzgYn7TDh45xhGZ9XpiuKI4fmstpjHrTCeFg/b5CGZLbJoM3CtXkELNeeyXtpttbFpPhOkJg6JrtHu42Q1nRSBJgR963Ecg96yasGPQyElklDDkdySV94C3K79H8HSdVI8uoMyyVomNf1UCAs8AmfJPrhOd4HEQ+u9TWWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yEAd/SsC0FEQ0Dag1vKNZ9F5IfaIzWc5J8LpQXTKUw=;
 b=IPxio7qYt6GeiQYH1Jkkw5zYPoFCpXnMlsxovosgoB9KiZ1ItlQsmbkMT+fXIc0U6O+bOZ8W13L4++NZqBMoVc+HVcVacgd/GqZFvN1/DEgj2SeCxs9msVi/Ixb/7yrGl3A5qNh7U7qcNpTwD60R1SEXAp7NaXzqsD1ADuo5/ZDqm4CsdmluUUf+5uhvUPC0hY5aADMvO/sCFWxGmY+U2Hgu0S6UjT+UB5E8XjBabZT+vB0tOKmEAm4R+V/qjamk5mbRc9OMd8NDU7Z+Yyj3cikIFTbYRNzDHdTm/q3ww/09ctJVxrTv1Mx6Dil6UrGGBG9vlkNu0V16wveOCSP1PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 SA1PR16MB6243.namprd16.prod.outlook.com (2603:10b6:806:3d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 05:19:51 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%5]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 05:19:50 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Lin
	<shawn.lin@linux.dev>
Subject: RE: [PATCH v2 2/2] mmc-utils: Add health command for eMMC health
 reporting
Thread-Topic: [PATCH v2 2/2] mmc-utils: Add health command for eMMC health
 reporting
Thread-Index: AQHdPmSXZ7E0yniOmkSBQg0Xju/xi7bCjFkQ
Date: Mon, 7 Sep 2026 05:19:50 +0000
Message-ID:
 <DS1PR16MB675345F0B9E08E1415606172E5B22@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <1788742944-94637-1-git-send-email-shawn.lin@rock-chips.com>
 <1788742944-94637-3-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1788742944-94637-3-git-send-email-shawn.lin@rock-chips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|SA1PR16MB6243:EE_
x-ms-office365-filtering-correlation-id: 191f9b68-500b-4b68-da84-08df0c9fa45e
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|56012099006|11063799006|4143699003|6133799003|3023799007|18002099003|22082099003|55112099003|38070700021;
x-microsoft-antispam-message-info:
 n39dYfbNk5x9C9uRcJ2X/sx4wr3EL3KckRi+LyGur9zgSBT219ymFe+mZrmQjv7masV2QiDPP5bxEuHoprsF5gqukDXr164Pr3FS+4ub2fm5IRs9XRl99QowcccBtZaEvce5C/Sfbabir8LnOIKUOFIe7X8SDjOXlg/z/dxvl3VgCG35kQ62ocgaozk/gfZDhj1DuQ7+DAJBYe+wVQq52Tdm0XEj1JbEomToHKotwlLcJYz8MXK4XzFe282ZVqFndC1mQEwTAjsyb/6CN6WIeYhRiQ2ozCzfYfBAFTXTXnbIPDwc1VPyU9Ys5lULRldvLkEdsUB8rypFloSNOYxyh1WHwipSmccW0x1plIKo4T/o57iSi6Md+pMp2hfInMALRrQbA049id1C7r+u4swBGdSeIvL6ApYgPhH3Ev49s7rBy1GK/Q+AfioabeJz1/1YdP5xrwKLFAKq/xFSweyy3ypcAEvk5OUU5QU1CX1L7v2zP5mDQT/E1B2TsnmXJmFwrPsjMpLtEJJqCtKajR/pkSWCptzg8us5ehFH/Md6duH7ILb13dZ+ioSz6Yd1hX31VmkLOIQI8nubBPABeIitRWyV5tIxh/yMepPEaTiPYsWij0taUqQhICYqXlsC1P1PSkHcxVDReIKkAsT70iNRBPahr52O1bBwVUF4zR10On2SlVj3nMgCRxD5ngPaTVRE2lhXZ3yG5IbJU7zp/wR880utNfaafWNI1GkQ7UE/OmY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(3023799007)(18002099003)(22082099003)(55112099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fGyA3jCDeRQ4BXYBCYQMLCk2tHsA4Y2mYkStB1b2Iszt675A1fz+h+0kiPH1?=
 =?us-ascii?Q?+bAGAj3Hc53lXCAR99yyjd4gsublNiCzPJW3cVTeBD5LQVY5l6CSkAojS3Wf?=
 =?us-ascii?Q?UpP6rFALAsyKeNTs7xC6JMt5F3KjDue9Nuin6Ko/1xO/BcNJXGLdeVuuI4co?=
 =?us-ascii?Q?z93F4roSmqIrrRQnqrKiNZMhuaJ+m03ZHvnlpg99cJ0D475Jo56g6biWO9j6?=
 =?us-ascii?Q?KFCPra9tZK/1TdoVlmMR8tiCKkeE43sqeLDGtiNzTuwOS4GWk2Zul5KDHwrw?=
 =?us-ascii?Q?uZ52sQOK+/Br/kIsgHBloYyQrM8zha0TiEcTtz/YeRVJ6MtXYdtWd6eDbNU9?=
 =?us-ascii?Q?sLd28rH042TVGJtlpw4ubtDzdaurDE01NRnfjPJ7qeWz6nJ8UTmo75uzTllh?=
 =?us-ascii?Q?OjSdq43MClsaBWItrb3WSe/A8pQmfHqWd35IfKYkE0FTNagupAxs5IGEe6sn?=
 =?us-ascii?Q?WPktazZezWjmzE8kyXzH0MUqyUPzmfaCJygs/fS54TxzDo2Iqpcm4aQ+aN+K?=
 =?us-ascii?Q?asTbcCtFdtEOTKvda10jm6B34z7wlDzP+lkaMTU5jeiPDJivIaFNhWX7nNl/?=
 =?us-ascii?Q?JiXFl0RExAlR65YrpdnFdJw8WR2NS1DWzxbCgPv3YAbiyWo/Qoixlv7jq4yM?=
 =?us-ascii?Q?8HfTmNMmzoB1fF8eDMCgbMGK3+YPc7JfE23RwEdvPl0wWhQrI6WQON8GE0sg?=
 =?us-ascii?Q?/7FCjAY7TTqaavlsQRPOgbyeftbuRJH0sXoW5JYAKjobdtG93UERyiVVXnts?=
 =?us-ascii?Q?QN1TUysmq+yh7E9CnslN7T/hdq04ci+0p06Mse3CMXNNNUlOIo36h/fAjt4Y?=
 =?us-ascii?Q?VAX8d1F5oqDR3yEt9Zs7OGeFfyrbHIFGZdJGAN2Kp/FTagOqmzUamJsheHBU?=
 =?us-ascii?Q?uul7DCYcjd1OEswa88Oo+K6E9IhWeg7lMZ0ladioEdvQUO34SxZLYGe9WigS?=
 =?us-ascii?Q?y65g1BRbURb5SamNjxAHo4uDxu963DECBNZr4xWuCL24jJiy7s79uqsd1idP?=
 =?us-ascii?Q?YCV9VblMmHUl/Ym1gzRC+D82dMxwgsi7fTho7xYma7l3GhC3B0P0/jx0u6Pm?=
 =?us-ascii?Q?nI8U/8vHN7ITfZeMw1vQ3cVIKRwFD/s6BCRg0dMznN+1FQYDYQ49PSYxWya3?=
 =?us-ascii?Q?vE4HIPvfREJiHOHn1sV8Fh7VA2KDp/vTT7JY6mozf71O9/r1+/iNMdQIqsX7?=
 =?us-ascii?Q?dMhsMUCPnXIW12yATSKSVbPJL+z4tvdCiFhUbqqELS/BctlkfPRgjICo1mjs?=
 =?us-ascii?Q?NjZYqB7mAaZTv9ONcR0FNcV5gqWkZOCtKRpujwe707FRzvMzJcRLiQ5reXL+?=
 =?us-ascii?Q?pLhyDczxMUP9rjVC5zQe0shQuywWg6Dwjyp2g8ilhNA7GJprIJsu1t0P1Tcx?=
 =?us-ascii?Q?rxrGRoVTzSRT1s5j9nc3lzoohiSMR5dGxsTJeis0Hlq3tHI06tNf4p0i2Z2X?=
 =?us-ascii?Q?oqCcCxsR3E1IJRSEo4U9haLesvTeUWw/7w6PA193yqkTT0mDm58WcLLrVWhh?=
 =?us-ascii?Q?PbcETxDnay5LGmeWmr810CHVxyLvCyg2BF7/3mzJUJQZVpBgBRoUoHnoSEa6?=
 =?us-ascii?Q?BmFz6F8A7hpOGyEpfbPvnXu39vFbcQ/xQogfy0gHSrShr/5JuDZKkiLeRLof?=
 =?us-ascii?Q?NNgIAdRkmazVmwphrgC65TipdatYWOHQ43kCFgdO86Wg0OfBrOIj1cKE3oiO?=
 =?us-ascii?Q?lCG9oamOXitcdhbRc6Z89LmhFEo88nRi1lSrVnDSlhlPj23pT/t1Z5R2AZLZ?=
 =?us-ascii?Q?aL1ExD3B6Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	xKy5lNCuKVMYnvqLLaYdrwqUx30goqucBxeCzUA/WQuRFvynT+p1KpdGGs1cvwHM5eNH6HKomgQdUcs8nN0rj1uh8s10Q2IvcKmcHd7TDFf1OHTmnl93AG8UeMEvX2+juqUxbF/E9EqimFKhVFWHMXeFASbw7dwFIBeSFv1nnxwXE7f52uKCqlLk7HA95poQHS9/Qrl8aWHyWSxi+hJBuzETkBl+Ad0E8O/e5Mon1DTZCklP5ODac+F9g2Uq+Nj6Fzr363eZefVkeMUn2QRzuj/03fLMPa9S0cqqSCBlWNuInvBWTrS89XPslKHP9tMpAeiZR8bhKoUEfJI1/djZUQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PuMAZeBXESNF3t5AbvXScBE2T4w96UdRm8yCl7cUa+F6lj16UmFCOc2IVxmz/802w7koa++SfhcSnQTuRmfhXwKVyJa+Pm60E9C02Itnm+//WFhSznNnwZpTOlPcervm30yvUfoBCjsFUUL5j5Tb7WM0RXHGrpMNERjn/LmSV7hjcmct4txnxKpUkgq4LFkzyzlAvgtXrWzWz8jO/zvgFStC/jhg5bVKajqq+5ZiT1tln/v9QDR43B7OxHU0CHP/7nY29ZM0SZXMYB7uXgM/kVrM+BmoLhl4pDMrmb/CMsXUEYuWXgC9pnn5EzkSrRyriRko1IqyrcUn37zE71U1wOOTVPKyY9mXKfEz0It/EoySeWD6P/Zg8uz8ge9EoIGIG+JjH5OS0vz76HFGoD1Hq5NG8hsfG3AGpjTtc7419YBrQmqp0LAUweKpm1FRaNRWUZG96mWX0zJJaEhQrCT4kzDuXOcgN/bBB40bZM+ar3RppTsP2to6ckENltg0y6hS54z9UmzXRZIfJmoz7vza4ByJDDI27OTHH1ai5Ybj5S1rDvSR0qMvCaU/8BY2mw8+s+MAiYahcRiUcaYddgvWk7TMMnlQHIal6fTj4iJCqyPNrsSlf6CKgcIytT+GUG/vfFDsdvMFQvHHKeEDAw3Seg==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 191f9b68-500b-4b68-da84-08df0c9fa45e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 05:19:50.6883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dbwSsEU0/Kuwb/nFu++Ss48cuD/GYHup/P8R6eqCZV/Sx9E+R5WrorV5zgqsGmrVzLx3+xd7q1vz2KhUL+5X1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR16MB6243

> From: Shawn Lin <shawn.lin@linux.dev>
>=20
> Add a "mmc health <device>" command that prints a health summary of an
> eMMC device: Pre EOL info, device life time estimates (type A and B) and
> BKOPS status, each with a human readable decode of the field and a final
> verdict line.
>=20
> The per-field values and their level semantics come from the eMMC 5.0 spe=
c
> (JESD84-B50, EXT_CSD fields 267/268/269/246). The aggregated verdict
> takes the worst of the three wear related fields and maps it onto an exit=
 code,
> so the command can be used directly from production test scripts and CI:
>=20
>   0 healthy, 1 command failure, 2 wrong argument count, 3 warning,
This is weird - command failure doesn't really belong to this new health me=
asure.
I guess you will be needing a different scale.
But why you even get tangled up with inventing a health measure and a retur=
n value?
Isn't the printing sufficing?

>   4 urgent, 5 unsupported (eMMC < 5.0), 6 not an eMMC device.
>=20
> Note that this verdict is an mmc-utils derived indicator: the eMMC spec d=
oes
> not define such an aggregated health measure. Devices may additionally
> expose a vendor proprietary health report (EXT_CSD [301:270], read via
> CMD56), which is not covered by this command.
>=20
> The command is eMMC only: SD cards do not have EXT_CSD and do not report
> any standardized health data.
>=20
> Execution effect on an eMMC 5.1 device:
>=20
>   # mmc health /dev/block/mmcblk0
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     eMMC Health Report: /dev/block/mmcblk0
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Extended CSD rev: 1.8 (MMC 5.1)
>   Pre EOL info:     0x01 [Normal]
>   Life time type A: 0x01 [0%-10% of device life time used]
>   Life time type B: 0x01 [0%-10% of device life time used]
>   BKOPS status:     0x00 [No background operation required]
>   Result: HEALTHY
>=20
> Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
> ---
>  mmc.c      |  11 +++++
>  mmc.h      |   1 +
>  mmc_cmds.c | 141
> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mmc_cmds.h |   1 +
>  4 files changed, 154 insertions(+)
>=20
> diff --git a/mmc.c b/mmc.c
> index b0f1f9b..ce8b454 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -106,6 +106,17 @@ static struct Command commands[] =3D {
>           "status get", "<device>\n"
>           "Print the response to STATUS_SEND (CMD13).",
>         },
> +       { do_health, -1,
> +         "health", "<device>\n"
> +         "Print a health summary of the eMMC <device>: Pre EOL info,\n"
> +         "device life time estimates and BKOPS status. eMMC only, SD\n"
> +         "cards do not report health data.\n"
> +         "Note: the verdict is an mmc-utils derived indicator, the\n"
> +         "eMMC spec does not define an aggregated health measure.\n"
> +         "Exit code: 0 healthy, 1 command failure, 2 wrong argument\n"
> +         "count, 3 warning, 4 urgent, 5 unsupported (eMMC < 5.0),\n"
> +         "6 not an eMMC device.",
> +       },
>         { do_write_boot_en, -3,
>           "bootpart enable", "<boot_partition> " "<send_ack> " "<device>\=
n"
>                 "Enable the boot partition for the <device>.\nDisable the=
 boot
> partition for the <device> if <boot_partition> is set to 0.\nTo receive
> acknowledgment of boot from the card set <send_ack>\nto 1, else set it to
> 0.", diff --git a/mmc.h b/mmc.h index 2bb346b..89862bd 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -97,6 +97,7 @@
>  #define EXT_CSD_CACHE_SIZE_2           251
>  #define EXT_CSD_CACHE_SIZE_1           250
>  #define EXT_CSD_CACHE_SIZE_0           249
> +#define EXT_CSD_BKOPS_STATUS           246     /* RO */
>  #define EXT_CSD_SEC_FEATURE_SUPPORT    231
>  #define EXT_CSD_BOOT_INFO              228     /* R/W */
>  #define EXT_CSD_BOOT_MULT              226     /* RO */
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index c70c337..35663f1 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -1007,6 +1007,147 @@ static const char *extcsd_rev_to_string(__u8
> rev)
>         }
>  }
>=20
> +static const char *pre_eol_info_to_string(__u8 val) {
> +       switch (val) {
> +       case 0x00:
> +               return "Not defined";
> +       case 0x01:
> +               return "Normal";
> +       case 0x02:
> +               return "Warning: Consumed 80% of reserved block";
> +       case 0x03:
> +               return "Urgent";
> +       default:
> +               return "Reserved";
> +       }
> +}
> +
> +static const char *life_time_est_to_string(__u8 val) {
> +       static const char * const strs[] =3D {
> +               "Not defined",                                     /* 0x0=
0 */
> +               "0%-10% of device life time used",                 /* 0x0=
1 */
> +               "10%-20% of device life time used",                /* 0x0=
2 */
> +               "20%-30% of device life time used",                /* 0x0=
3 */
> +               "30%-40% of device life time used",                /* 0x0=
4 */
> +               "40%-50% of device life time used",                /* 0x0=
5 */
> +               "50%-60% of device life time used",                /* 0x0=
6 */
> +               "60%-70% of device life time used",                /* 0x0=
7 */
> +               "70%-80% of device life time used",                /* 0x0=
8 */
> +               "80%-90% of device life time used",                /* 0x0=
9 */
> +               "90%-100% of device life time used",               /* 0x0=
A */
> +               "Exceeded the maximum estimated device life time", /* 0x0=
B */
> +       };
> +
> +       if (val > 0x0B)
> +               return "Reserved";
> +
> +       return strs[val];
> +}
> +
> +static const char *bkops_status_to_string(__u8 val) {
> +       switch (val) {
> +       case 0x00:
> +               return "No background operation required";
> +       case 0x01:
> +               return "Level 1: background operation required (non-urgen=
t)";
> +       case 0x02:
> +               return "Level 2: background operation required (performan=
ce
> impacted)";
> +       case 0x03:
> +               return "Level 3: background operation required (urgent)";
> +       default:
> +               return "Reserved";
> +       }
> +}
> +
> +/*
> + * Print a health summary of the device. Exit codes:
> + *   0 healthy (or no degradation reported)
> + *   1 warning level
No longer true

> + *   2 urgent level
Couldn't find where this level is being returned.

> + *   3 health data not supported (eMMC < 5.0)
> + *   4 not an eMMC device (EXT_CSD read failed)
> + * Only meaningful for eMMC; SD cards do not report health data.
> + */
> +int do_health(int nargs, char **argv)
> +{
> +       __u8 ext_csd[512], ext_csd_rev, pre_eol, life_typ_a, life_typ_b, =
bkops;
> +       int fd, ret;
> +       char *device;
> +       const char *str;
> +
> +       if (nargs !=3D 2) {
> +               print_usage(do_health);
> +               exit(1);
> +       }
> +
> +       device =3D argv[1];
> +
> +       fd =3D open(device, O_RDWR);
> +       if (fd < 0) {
> +               perror("open");
> +               exit(1);
> +       }
> +
> +       ret =3D read_extcsd(fd, ext_csd);
> +       if (ret) {
> +               fprintf(stderr, "Could not read EXT_CSD from %s, "
> +                               "not an eMMC device?\n", device);
> +               close(fd);
> +               exit(6);
> +       }
> +
> +       ext_csd_rev =3D ext_csd[EXT_CSD_REV];
> +       pre_eol =3D ext_csd[EXT_CSD_PRE_EOL_INFO];
> +       life_typ_a =3D ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A];
> +       life_typ_b =3D ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B];
> +       bkops =3D ext_csd[EXT_CSD_BKOPS_STATUS] & 0x3;
> +
> +       printf("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D\n");
> +       printf("  eMMC Health Report: %s\n", device);
> +       printf("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D\n");
> +       str =3D extcsd_rev_to_string(ext_csd_rev);
> +       printf("Extended CSD rev: 1.%d (MMC %s)\n", ext_csd_rev,
> +              str ? str : "unknown");
> +       printf("Pre EOL info:     0x%02x [%s]\n", pre_eol,
> +              pre_eol_info_to_string(pre_eol));
> +       printf("Life time type A: 0x%02x [%s]\n", life_typ_a,
> +              life_time_est_to_string(life_typ_a));
> +       printf("Life time type B: 0x%02x [%s]\n", life_typ_b,
> +              life_time_est_to_string(life_typ_b));
> +       printf("BKOPS status:     0x%02x [%s]\n", bkops,
> +              bkops_status_to_string(bkops));
> +
> +       if (ext_csd_rev < EXT_CSD_REV_V5_0) {
This is still after the field printing.........
Also bkops status is from ext-csd-rev 4.41, so gating it to 5=20

> +               ret =3D 5;
> +               goto out;
> +       }
> +
> +       if (pre_eol =3D=3D 0x03 || life_typ_a =3D=3D 0x0B || life_typ_b =
=3D=3D 0x0B) {
> +               printf("Result: URGENT\n");
> +               ret =3D 4;
> +       } else if (pre_eol =3D=3D 0x02 || life_typ_a =3D=3D 0x0A ||
> +                  life_typ_b =3D=3D 0x0A) {
> +               printf("Result: WARNING\n");
> +               ret =3D 3;
> +       } else if (pre_eol =3D=3D 0x00 && life_typ_a =3D=3D 0x00 &&
> +                  life_typ_b =3D=3D 0x00) {
> +               printf("Result: UNKNOWN (device does not report health da=
ta)\n");
But ret is still 0 here, so again - this is confusing

> +       } else {
> +               printf("Result: HEALTHY\n");
> +       }
> +
> +       if (bkops =3D=3D 0x03)
> +               printf("Note: urgent background operation is pending, "
> +                      "do not power off the device right now\n");
> +
> +out:
> +       close(fd);
> +       return ret;
> +}

You also forgot to update the man page and readthedocs HOWTO.

Thanks,
Avri

> +
>  static unsigned int get_sector_count(__u8 *ext_csd)  {
>         return (ext_csd[EXT_CSD_SEC_COUNT_3] << 24) | diff --git
> a/mmc_cmds.h b/mmc_cmds.h index 033cc09..88caf85 100644
> --- a/mmc_cmds.h
> +++ b/mmc_cmds.h
> @@ -39,6 +39,7 @@ int do_hwreset_en(int nargs, char **argv);  int
> do_hwreset_dis(int nargs, char **argv);  int do_sanitize(int nargs, char
> **argv);  int do_status_get(int nargs, char **argv);
> +int do_health(int nargs, char **argv);
>  int do_create_gp_partition(int nargs, char **argv);  int do_enh_area_set=
(int
> nargs, char **argv);  int do_write_reliability_set(int nargs, char **argv=
);
> --
> 2.25.1

