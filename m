Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DE74F8BB
	for <linux-mmc@vger.kernel.org>; Wed, 10 Jul 2024 05:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720590551; cv=fail; b=Oynd9BZR2uOjQYzYXRlUQVHX4scfFpGG+Rc9oopXg8BkBBR+Ibcn/gRHR0dafc4b/k9gt5QPJO/pgzJSILxltl7c2XLKZ/p37FGWJQIU8nBW57o8TeiD2hMm0VmKkFqiRyWDtHzbKnoov+UdfGWCFSlUcAdfWec6ggdXVKTOZno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720590551; c=relaxed/simple;
	bh=v3G2kO/ZNnxH6zeKYqWXJkSPb33ZL/OEL4b6XYYh5v4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OVdwDYepGgxHAmlUeGaOKQMVsQDg0Ek6LHh6KJwLRJnWPmExpgkxkdFYk8K8z8UrKywItaUvxG1R/HqjXp+7+5H/0r4VBgZBCgap4Kh7gI16+9mIhJUD2T9r3rcKk6VK/3Ipdu6gDsAaZQPcOF6RJjr5Dq2L33ejd/stQZBTv2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JX3Rtqk0; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=PqLjs/Zu; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JX3Rtqk0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PqLjs/Zu"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1720590548; x=1752126548;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v3G2kO/ZNnxH6zeKYqWXJkSPb33ZL/OEL4b6XYYh5v4=;
  b=JX3Rtqk0REsqZRvNcc4TYKdy6vp+7g270Tc9XOhhfkDVyRKZQpVQf1VB
   SHxc+iNw7ZVnHCP8HchJaELqh8NYwooEQF2GhQuplTksjtInsmPFBi0eM
   o0ZcGdjb6ieIgqFUdm+JSkpzMDLQFRIPpFcOagKavIzaOhcpRkQxDJm7i
   Kd4KBprQv5Bxx/jAnOmW3EaZT2IU+6PDj9DUPCZesv0M+ZF8YlxwoDCaN
   +fl7i4tGvt7Z7v+FuuSw9ljAkpz6KW/ImVNS5ToAle6gyuYnlzmLUDqfO
   ZjhfxcqImIoP9Tolwj6EO54uPVhfwUzGmRtbaH6JBC5kVvXoXat5CVBRJ
   Q==;
X-CSE-ConnectionGUID: eMYB9pc/Q9qDnbcBL6s1Cw==
X-CSE-MsgGUID: UNzFw5cORNGguV9iXOog6w==
X-IronPort-AV: E=Sophos;i="6.09,197,1716220800"; 
   d="scan'208";a="21342373"
Received: from mail-bn8nam04lp2047.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.47])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2024 13:49:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WI2SBbKDDN8qKwTOypdCIgeE+KLcrE3hZkVSrHMVPj5OAvjYHffSR20dryNHQrGidLbLoHZ6qEiVZXvPTSANVfgDzpnbcRuapQxCrA0mkscB+M+OsZGuZq1DpVTFmWSmoyx5dDk8cLu34mvbc9PUlPtAyDNumE0VjWrmYG0Ou6WUoJqaUd+F879DW2JbIAsDr5uO7FjTnCtOfF5DHT298Ph4xIuzX5fHt1p7UaoTePUUoVKmXgx+YrhF807hgwtmQMOI09l2JEnmm5PJljEvBN1Y3hg5Hg4U1spfO8fQAulMIpP6KIHcdTzfsdZQdrHVJPTwDpXvPy9yF4ojJXtipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7gd6Bl54LQzr92srTrqhShbdbZk+QvSv/Nemv1Snlg=;
 b=I+qCeRKafUcoPu97JxJ9suo/6xOaI3G13MT9nPgNktt9wz1h6iLO4vaCSRS6c5uSeuYZR95mf9mgTYjtirQB/+q0N7zuwSc8BZS3Br7ncNzOcDTyCMjqLZtgRN9ZayUeZMr9y7+BZOlDJfSq40CSIpi5b35mePtTZGu3DRdi8SWBBKxCV77FnmsmepSbkp07PR8e4AxUdyMjVo5wFbKIwewop5cHjgy+u2NIMPmJBnrNFBkYGqqDYCTocmV7nN7728aKFqU0LWIRWjxpMxfF9C7uiKhx+Ex2KlfR/dz7v8R5SSaQZ7sN80Bd2nR52HatrhxOCxTIPIKSW1LOy4SqUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7gd6Bl54LQzr92srTrqhShbdbZk+QvSv/Nemv1Snlg=;
 b=PqLjs/ZuT5pPdFgzXINH99DmbwdXVeI8+6kV6mdOVMlEgdLB7bbp+qwk9WSwNEvkT5helYetgws3KAzZo2MYk0npHcujkNj+214J88UFOxZ3fbd6RwUAZLYA0waoiQ9D6cQ3thw80YPg0nzN7UV6GtFdu03091bWESWIsprZ8bE=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB6411.namprd04.prod.outlook.com (2603:10b6:5:1e8::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.20; Wed, 10 Jul 2024 05:49:05 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%5]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 05:49:05 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Daniel Kucera <linux-mmc@danman.eu>
CC: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v4] mmc: core: allow detection of locked cards
Thread-Topic: [PATCH v4] mmc: core: allow detection of locked cards
Thread-Index: AQHauBNeZ2lQZ81CBkKpvc0IuwzTHrHtCVmAgAH7aoCAAJ0sAIAABorA
Date: Wed, 10 Jul 2024 05:49:05 +0000
Message-ID:
 <DM6PR04MB65759CBE25FE8902DE6652D6FCA42@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240606131222.1131880-1-linux-mmc@danman.eu>
 <CAPDyKFpvPaBwKdadCBC2LHTFGaEEjRN3ZrOC+PXp16aZKgPY=A@mail.gmail.com>
 <DM6PR04MB65756BE6093A5173C58CE9E4FCDB2@DM6PR04MB6575.namprd04.prod.outlook.com>
 <dc3524328a701be1ac3206af24b4a185@danman.eu>
In-Reply-To: <dc3524328a701be1ac3206af24b4a185@danman.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM6PR04MB6411:EE_
x-ms-office365-filtering-correlation-id: 00349e68-0e24-4366-6635-08dca0a40284
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pvQ0UW4QJ21NMk8LbPEH2X0xXEyUVMDIpD/FEp983/EWsYo2vucVvEbBw+dr?=
 =?us-ascii?Q?hFYco5/Vi5LmU01Px8qhEJLKu/h02Xg1sxhmiHA3AyotZ+VotBTc5mwNmTBJ?=
 =?us-ascii?Q?80wzJYRpBfAvsJCB3+XRcwBa8tBk7RO5JM7HsD7DbY1WANwwEXZYKiU0SF4w?=
 =?us-ascii?Q?61UdNcyfaFExaEohPU/SJbu9u4/bgp4MS+F5G9AunlcGPPnDwIhWs0zIisK+?=
 =?us-ascii?Q?+QyBCIejTPzXvJv2d997HxeH6HBV6gjv19P6hQ9DQwbrIzZ7s1/sW3EkH2Gk?=
 =?us-ascii?Q?CgMqVLFTgGv0O7wJ0VnwO8HNlEr1PsXKJ8rlzuSDnHQG07fdqXrmq5zFySu6?=
 =?us-ascii?Q?RYoTZeTd1wJsPf8AmX0qNlfchE38kyrV/jU6IrmuV/C+Bhy75TNzPXCGToQ9?=
 =?us-ascii?Q?LyeN7SQsZDFlnVpCmr3W3RvSN+p7mBanwgYPOjBKAUduKiuIob+qgDBdenMI?=
 =?us-ascii?Q?r4FDGf9xZz5dIPphtD1NiqnGGxtAfaWsaerV7IJ1F5J9U2YQrFmYeRnmDGzC?=
 =?us-ascii?Q?7dKhac67SlBzKW8EHOBumyYjIqN91oVHTQsbM6iflWVuZZiPDffQ6uPgcb9o?=
 =?us-ascii?Q?thT2m9tRLUdAn4dZJhfY6wqF9nOrzmAju0Jooie+Cyjcnjp5Qc1JmjXc5PHS?=
 =?us-ascii?Q?a76apsFaiGmV7UO9F9PFhhMDE6VwRauq/K75PIiP3sZHHPoh4gF+T9tAQqIR?=
 =?us-ascii?Q?Wz1XVTy4oh3frboBbuBZu9KONfOgJgmM9xIRR+wmHxYR9mfl/q0jbBwdYxaP?=
 =?us-ascii?Q?TwUhEx5+VNL0hOJl6eA27T//0bOuZawOzOLNjYGIh+nxT/+I8v7BRYBsSTFw?=
 =?us-ascii?Q?Uqe3q+ajUrgKMxDYh+s6qd+w3I/njZ6vgbxXfABdDEKw9lV291ecV738Shio?=
 =?us-ascii?Q?peSY/c8KvxsNhbddkTMkpVxzJIoZHA2K7ni52NWdOKUL++BnlaOKEhFIdbX/?=
 =?us-ascii?Q?xU+p7K4xeLx7GdeeowGSuE2SI//zdvJesDBPKJki278Fa8HRVt/Muu+tCs3A?=
 =?us-ascii?Q?htwYFO7CFqMdtpis4EG/E567pyiyXv9/Z2lfkzKkwsyA82hHqbgV94ZbwTVG?=
 =?us-ascii?Q?BP6RovFWvvoPkAsrkn1nFZYSeFjCbAW3pVp87Zze5lhSPf9ZTagFj5TfmwAr?=
 =?us-ascii?Q?+Hq7g1CqRuGgtVLASBjoQZiP58TVoOnOvJ9C+ZCehV7QfC4uRp28C+mFZ7xa?=
 =?us-ascii?Q?LUmbr5s6wiAw8utLgxqqlj+Bh3PsX4+JfE8RIdLp8v5AUEckY4NHXxF3bQdJ?=
 =?us-ascii?Q?VBbOw2VvrEuOZNfw0zrDxVeztJK8zEQk69RV2d5Xppf/dPNCNWQzZ8MRXLGR?=
 =?us-ascii?Q?+fcBVBUEeGzTU7sS73qeUeQvkhEIrtmGJK4mu4RJSQE/LkRUSQKZpUvrLkzI?=
 =?us-ascii?Q?WM6J70e/x06oo18hQ9Kdrjs209zt1G/y9SvNOkkzil5zy9ceew=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Tv69ws9ulifXRAy86R6FAQcHv8A4NRmJRwdewbuYHVmIGJADdUMnrNDQnBpF?=
 =?us-ascii?Q?NiO+tjwiau3Ad9MBE+iK+lchks5Hkvvc5xQWM1MMd8wWIofqdAJIxXGd9yF2?=
 =?us-ascii?Q?DpI3pdVLy/ys8rIrdlj+Yqi6zdq85cIOocTgh7DsPUgtsCY5x4eYw4ViU1LS?=
 =?us-ascii?Q?CtmVE+G7uT2z2mhV1qZgvGr5ARXSfbU5jOKmzksxPGTPPV0FbZva40mEH1cN?=
 =?us-ascii?Q?uey7ZMCNH8TY+in/MsfkWYtNPLI2wssOg7PDDJxj4bv5KKpBVofNev+jUy60?=
 =?us-ascii?Q?pCTFIOIBEC5VWN8JTfVEIzIoDOsLk3QoBIZkloCrpUQV9PbiX2DNm4/weV84?=
 =?us-ascii?Q?qfpzjXM1IDbtTZbF1LjIspNBu9F0wI5i16mig9sRalrTxQH1KPS7vtRpzo4Z?=
 =?us-ascii?Q?VSN6XSp8uALp82RjBWGUm/FhJUupeHb2YH2uR84PpcH2GZ5H4EVdL4CQUf0N?=
 =?us-ascii?Q?JVH0iEM3v5OpO0CodaYFsudDae3Na+u9f/3UCYzcRXn7H8y0Z5PnqN2w2ZLq?=
 =?us-ascii?Q?DAjyLfVkYL2CJkVOKIbq3uN/nlCVDT1bqpMEJiYHGnqzYo3DqmEDj9pcKUCF?=
 =?us-ascii?Q?27pdf+cKZ81Ej56OF2Uah71AAUV5b+D0bW8dJFe1mCTWHX3Bm/QO4ld/o/eu?=
 =?us-ascii?Q?crD5DlIqZaFNXznBVHdY7ppFzhyovHloDu9GK+v1tEI+/2NoA0UJy3oFh71E?=
 =?us-ascii?Q?jQ5dC4N+vcJveAtZ4TD8ilVDGOeTtq4KbppUY6LUwRpE71qyBSfMIfwBCFSv?=
 =?us-ascii?Q?pxJzwuAmDBkOa2ECLCnwfScvBHe2ReSpW2EjoC6GMau/B0RuaSlq2T1oAgD7?=
 =?us-ascii?Q?L7O9ybHsl8NL57lhPz0IDF4M9GSa7HtXSlV92p6GYt07gXu8bJBxjyYSNdE+?=
 =?us-ascii?Q?PXVI1aZnWPZ/r0Bz3eGbMTgG7i6bfsr2aXa+gsP69406u+9EHiBRHEbNNA6B?=
 =?us-ascii?Q?5fXJbGIytD+zp7S27ytuzl6RcaXgX6UPfKVjkdTKVTfNo9Oa+e/KSNmSrxzE?=
 =?us-ascii?Q?2UooMWRDgZgFuXcsvKiR1yZ2/2iZWPplixU4umbo5G5daBHTN5ZfYpAWz7Nq?=
 =?us-ascii?Q?hneSgil1yY/2/BWzBPvsSuztFnaZ17zic/SG42TC0qBIYwsGOYumrE1o0hfE?=
 =?us-ascii?Q?z2HLIysM5485ip8eFl2E+YluNWtmYvBy0UGxRgq5Zx+UyvLpdsmoHppojmXi?=
 =?us-ascii?Q?KRuvheDg8dqpWmwSkzuUJh7GT4lOArnL7NjHnHpZZGFqbWb0FuaesY+6Xq98?=
 =?us-ascii?Q?9wiXWm6L2Wb4F0Wj1G5iFA0syOpAo1QNCG3MltmsKoTD2wdOjhvAuqH/RlZx?=
 =?us-ascii?Q?3eerhxnwCiR6QqZXBPNw+LqUKPgobpEom2gSaDA2DfxyTbXHEixRmDqWon8F?=
 =?us-ascii?Q?NaZesix7NwVrOr7Q4ygw5+tbZ01cGQ90sZ+FkD5uk3pka6goSfRb/Wrk3HWT?=
 =?us-ascii?Q?Gq5rBrZyw2LFkLkVqcGhagCbYLOn2o4br+Mpt0tmDHG2nW+qnAsCWgEZhx94?=
 =?us-ascii?Q?kRXXLevqhSpEPbFhGSPPfpsyPFMUMi/ZA6YasonXjg4xBl5Igi2SSEUzy3s+?=
 =?us-ascii?Q?m2hsujhRDBp2Vnd1vnp/Thb72j1QpILxNNb6nzpn?=
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
	g/g9liIrqcqOPi1Y3K89duCEjb/I7kzOVOITQaYSIP2BOM0gMFDzfdo2B8UgI+lwh5vZqQILZWygb/VgdBgHtzmrKcyw9G2YPsvYPv8A5NHLBpmcIrDOowi+m/zbUYcZzyuwe7BhJsvst2r7bY1F6+HnZ+EHugP1PFvInMhlq5Q1mKqwwLGMaXdeZgIhXanSxm+bAn9tMXl6HQrkQI+5ybThklH/0MiCGCWrnWzaahAIUofb6EbmPMUM5i6pvAo5QBggPNRzzTN/4G4CaKCyQG5E2OEHX2MEeSzUnFIxmGlX7qRc5i1evAQPJolZ7xxB4Kx+ONILHjKB5DgaRn93wUq1bAbrSXyWqzbko+gqVL4YCNfCL6HQYRnlOFtjT9p28oBVjfLjHK6ecUzbU3CrBXxufGDtGeJniyPV4yX7rgyuZV9nofg07XfkQ1jM32isWxFgR6yQOipsuip69h6DbnZSBBu6bqAP7V9O31iEb9x3Q6WMaPYNf4m2MKhTtiPz5ECZNhRXr5U/Avu7CrlBduTqx+fIE/YvWOkZhdPORqOW0I1EelpZGNupCqxi56yf03cCWUm/cbUuCvEnNP5Aph2x+HeYFfvYhUi4ViObzJ1qn2NPp0SosMG167T0+D8u
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00349e68-0e24-4366-6635-08dca0a40284
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 05:49:05.6628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NCBPTOmQVMGsXz3Msrzcci4SuSLqWPKuEP71VkQEkeGCBDRuSeeK938u5hAzQpNtR7QVyFg+M1aFB2BwdECE+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6411

> On 2024-07-09 22:06, Avri Altman wrote:
> >> If I understand correctly, there is no point in sending the CMD13
> >> above, unless this is the first attempt to initialize the card.
> >> Therefore, it's better to move the whole part above, inside the below
> >> if-clause too, otherwise we would end up sending a CMD13 in cases
> >> when it's not needed.
> > R1_CARD_IS_LOCKED is CMD13 response, but already in CMD7 response as
> > well, So theoretically you want to skip mmc_sd_setup_card altogether.
>=20
> Do you mean to modify:
> mmc_select_card(struct mmc_card *card)
> to somehow return or save the R1 response to card struct?
>=20
> Because currently, it is not available.
Its just a suggestion - CMD13 does carry this bit as well.
Either way, the card will not respond to ACMD6, CMD6, and CMD19 while waiti=
ng for CMD42 to unlock the card,
Hence failing those should not eventually cause mmc_remove_card().

Thanks,
Avri

>=20
> Thank you,
> Daniel.
>=20
> > ACMD6, CMD6, and CMD19 should wait for CMD42 to unlock the card.
> >
> > Thanks,
> > Avri
> >
> >>
> >> > +
> >> > +       if (!reinit && !(card_status & R1_CARD_IS_LOCKED)) {
> >> >                 /*
> >> >                  * Fetch SCR from card.
> >> >                  */
> >> > --
> >> > 2.34.1
> >> >
> >>
> >> Kind regards
> >> Uffe
