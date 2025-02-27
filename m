Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B704D4A1A;
	Thu, 27 Feb 2025 07:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740643025; cv=fail; b=lCAzNulBhYW3n1MOZSLvq1lPyYs/8vParRaxcBvY7BnO0kj51Ob+NZXhmZbKqw7+1uN8hQGD3mjCXqCdWPPw8MuikBvEG5CeiUr1W7BKyUfUHkX8ELrHgv1t/sC2UjvafQ3Y+KPHmMWkfQwR13hgGY0g0R9UvS3FJrCqukixlBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740643025; c=relaxed/simple;
	bh=hZGbAXv9EtGkARMWM6yeiySuS7lXlOn13053XY+AV5I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ut8MPjnee4BYaTYI4gN9QJ9hZNscE6HOYJTb0d+gEDVW3I8JvPK/hk3i4WXp8IeLIzlBr9XQtdy7Gq7YI+zvbuw/2sWuvV6jRuCJtyqqxHXuUsd9WdJ861j3h75aW3KWUbNBxaD91ne+UN9/oyfEg6yhdg9o4/oPE1AleKCqc1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=CEjYPgMq; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="CEjYPgMq"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1740643023; x=1772179023;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hZGbAXv9EtGkARMWM6yeiySuS7lXlOn13053XY+AV5I=;
  b=CEjYPgMqoNK/SYzvt+B5/l0XEouyR/qzDKMwjP4GAnmJCjclK4Nv8ekT
   GUF2Raxd2GGq4jtiUc+egy1v1z5JSb2uwFCkRHCQWHnVRFBJ6DxYqo1Y2
   ibiRF9PL3Dun+534NrWYdoi1YR/OcDqkXLATAjzKgMxazRLT6lrJs6cWI
   vnd5aDj8gf/nHJ0JuT943WBRSu2FtllmEw8Cg2o7bznT5m4c8+pFGuGu6
   FQ64L0Xdn0Cs+DCdGaBcY4m9FSAKs2yHhWuDsGIAR1VOkI+bR9olw8Ipg
   jPuNQue9GBRwGY2aS+71vC/CEAKY3nY9QTWUklr54e1VDyiAUmQ5t2+pk
   Q==;
X-CSE-ConnectionGUID: 8N3SqJcEQoqo2S/t6GKOWA==
X-CSE-MsgGUID: iliCWtYuTVuA/RJau4jeNg==
X-IronPort-AV: E=Sophos;i="6.13,319,1732550400"; 
   d="scan'208";a="40305490"
Received: from mail-bn7nam10lp2044.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.44])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2025 15:57:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8ps3vXPcxzdlezrRBNuHxPS7OjhchstkQj2PZw7x5QspQMkI8NIQ8vrd37j0x2Txq+Kvmt9YVEgtUGE+yWE3poutPeGeZDhOdwmR0a0oDq3F8MXLal+NrvtRpo+AjiqiFlX4kMHy+86Q9TLiEZ7+OzL3G5Eo2O9sERnAmf2qb1fmdfEki8Ub7WNKxuIhUEcf+7ITnk8CmcyDqN9xo7L51p9+d1m0slAnKzbZwdZFFRmlSgpLG9entMTwKhhO34cEtnBg+dmUw/4xE1rb36FHFTdRmz0HA/Dh/Wcpp+iNeG/OC5dXQRfCtxb3427bXNxWZQToWBA+H4OdZwq7E5gdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epmLBVMYIo3Gun3nXbb1yW8ASoKC4epY8uaqtz2vPjk=;
 b=fPg0z09E5YIIY2uTWOUpsty09OpqbnK9sic43/SdhF3GHMugpSFpwURkrz/9KlfICMJ+27RqUbjLqlJEaAM0EGhx61h+7RxEyc8EPJSZqIdcDV+rRp6+2up2aKsRgaanapgPIdIkAep0fhxCrXKpyrXZ8QzzfmP9EHYa4wLaT0Ur+gmb7iAOeKbZqlxae+fFYvd9FVgfALPjmVIK7nn5Z3P4W1KlQ52P10WU+T+kK+13BasJnhgKR2WpoVPlIoYDVE6hpWlltznwexsRCqc4xDARXH50qO7I16JQLTpmoNYHSDWvRtgP1xDS2p+q0g+m7iiuB5/nhNGa+qGp3tZw7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by MW5PR16MB4691.namprd16.prod.outlook.com (2603:10b6:303:19f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 07:56:59 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::e087:8329:baea:5808]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::e087:8329:baea:5808%7]) with mapi id 15.20.8445.013; Thu, 27 Feb 2025
 07:56:59 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Dragan Simic <dsimic@manjaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "git@hrdl.eu"
	<git@hrdl.eu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: core: Trim trailing whitespace from card product
 names
Thread-Topic: [PATCH] mmc: core: Trim trailing whitespace from card product
 names
Thread-Index: AQHbiIRj0DknErNpa0q3yWcdwT9nzrNayR3A
Date: Thu, 27 Feb 2025 07:56:59 +0000
Message-ID:
 <PH7PR16MB6196EB7A2727F03A9CB0D6AFE5CD2@PH7PR16MB6196.namprd16.prod.outlook.com>
References:
 <fb7fcecae737f3e8b279854d7c853000527cba9a.1740597891.git.dsimic@manjaro.org>
In-Reply-To:
 <fb7fcecae737f3e8b279854d7c853000527cba9a.1740597891.git.dsimic@manjaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|MW5PR16MB4691:EE_
x-ms-office365-filtering-correlation-id: b1bb2116-7c6d-4207-adde-08dd5704504c
wdcipoutbound: EOP-TRUE
wdcip_bypass_spam_filter_specific_domain_inbound: TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?126p8d/CYzr5+KFRY49K0oEkAtWag8BAF905DtWDPz5enkPUihy7Se6tE+I3?=
 =?us-ascii?Q?iFgXIWwS2gEBjz5YqiaXLbRXcHCfvR6zowjPjhc7/zxE+v3O1LqMqdYKrXZN?=
 =?us-ascii?Q?sea1Oz5qtpkeKGQD4QaPCMFP3cZkkpNGL1jey6x1m/ULkBqC+MNLiLbiqNAF?=
 =?us-ascii?Q?Qg1ch65oZDLs90QHAovx+YAfOXLfjWsUhKZBazOc7YT6Fa3T3XZCm0FXhQvh?=
 =?us-ascii?Q?ZS7HTpKzayq40wPHtkd7Siia2OGjOMSon5NP3wAb5cgAxyvnFGTfKkDAuE85?=
 =?us-ascii?Q?lW8pLCBi57Bi9Gd3yLCKOtQbJLXvETHr6E67oRHfrfO6JLAxgCGEXFc5M0QN?=
 =?us-ascii?Q?R1vrvjit+QKaVBAUES8t5RrRDbfzLEVU2YLEo+USV+vCBwq4qMx8Sy7e3Xzn?=
 =?us-ascii?Q?EdE+s34XQSsRo4KhRVlV47Hffj9adoIFDSMNTzXD5fyp9Xg5lLfU7NmUMSlH?=
 =?us-ascii?Q?pXixo/IAjJMqiDWm54F5uYYc6tDuaJmBJGyGzJZFBSC3HHaX1ulUgWTKnLDK?=
 =?us-ascii?Q?HwxEM6Ai+of5evs5oOwROOXP6DRSDK06EkorKIREtfEQrS+N0/MO+yXrbbpf?=
 =?us-ascii?Q?7Eckd1pOZms3bmuYZ4m/qUdNjwxNkBXGiCY18Hn1Wkg++l9ebAVW0Tyhki+4?=
 =?us-ascii?Q?gxiVrwx8xI3p+AmIpv3SPCHym+e8kKnskaz3QghFbJYqyRJ/Au/8F5QWLW3m?=
 =?us-ascii?Q?2QPTZkR07653VZoTEsnp6A1oP5Jkwz+DkW+1OgtpOtOYXENI7hdf7flWfXtW?=
 =?us-ascii?Q?hsfcENzW7v8o1eMEzbwbmYvJyxdSXbdlhjfblkkcAg8cgZdJ9exGOLP+zAcN?=
 =?us-ascii?Q?jMCSHszLERZJWitO5T1ZyAwDrdmO9js2+LLKOPf+rD9vz5TregOot+aKLj3E?=
 =?us-ascii?Q?ECQ4blrsjkz1pynj2vKt6AsBq18fuwq68yGWsJcKvyebNAHQwyghVx/QpmH0?=
 =?us-ascii?Q?DxWsnejdw/TTJUCbFPyzI2lfZZShV4pJUwsOd6tCwZLTbksIR1qjqNRUSNcl?=
 =?us-ascii?Q?ugOtj9sc23TcdOpVrRu5zC+wOa1FRbVRiJoEjLSDrJZjBADfW7bA4nog4Beo?=
 =?us-ascii?Q?3/4bMc567HakqREfNx6jDnIMsihJlP6HcfQDf9YNIemWEV9nLHoTfrhwo9Rp?=
 =?us-ascii?Q?5DrDUnfY+npQg99CAuU6SVmwnDC1w+MOO6TORsq5K1oxSy6IKYfyKT4wtuhd?=
 =?us-ascii?Q?57pKwON6oHAaplX8YIT3iw1EMVvHFmA9fCxoj3uM1UD9O5JYgXWREocgGtWm?=
 =?us-ascii?Q?v4AZTJVsLCaHCO+3DJmWEtWAzbk5DTf3ykF8yl39UH3bdaDvnw2y8RYqYba8?=
 =?us-ascii?Q?gpvrMfEO5xG5TUD+BRZ81Dr1zFE5Nv8fFxkNrfnAgq6kp/NNtNEo5FN2PuTw?=
 =?us-ascii?Q?Zh9FF6fySkkfTAqp2ugT2KTDtDB+fCP2kjLqObUZNiTNgvU0uo8z+go+kXc7?=
 =?us-ascii?Q?F2Fbki9QnzalyhgfyRCA+N3qdgxPbHXP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PBhBLxUaa7+SWV3z4qFjYl+byvZhP2aYfyl7MeTrem5TKGbTBwuDpI7Ykt8c?=
 =?us-ascii?Q?UTVUB/LNLny4l7sC7LOkK2AdM4O/G3tvnOdYBi6HUY0XoQeryd3zL39PbQn6?=
 =?us-ascii?Q?ijrMZLgVCfiJRAluvsYJTUAdNZ/i4Kwil5GHIoPa0eZf/8SeAcwYUq9vzAkS?=
 =?us-ascii?Q?K4bUklfdUoWmI5ISJnzXD5mPI94rb7pyGCYgBfA2NP9b23+bVrQa/MVU77xS?=
 =?us-ascii?Q?mL7tyuo1SPEKaRXWdjX6ptxFeTCvBy5bmmBQpXyrKomkyy006BbIJEqEcjm6?=
 =?us-ascii?Q?B4tOdOAGiYamLLp8CI4OTcPPt5kZK8xWh0xtzGIVNKNSwtcw1hi53bfYxyWV?=
 =?us-ascii?Q?gdVTMEMKEqX2tVtz+L6fHfWKlPg92gHsXD7y1AAzkbncw9xsJEtSpaY3kXCx?=
 =?us-ascii?Q?DaIAMJevY5bWLsW3raeTCr4B5DHEZI1rFO8rlvjJTdVvrOK4VSt37KKHd2tF?=
 =?us-ascii?Q?Dx83gDUjBQbk2U4Z/kTQyKvLA6qKiZSImSFtE/tYUDwQs8A6CJSr96U5hsKs?=
 =?us-ascii?Q?swxL3CkI7tPIm6rdk5Z2z5Jpfqt8nf61wbbymlwn0pZrLrWKtwVX16xytGNr?=
 =?us-ascii?Q?JFFik/CJESH3WqcMo1RhxtrVNZ7ngZYFlirRwrN4CNdrAqnOkrVnbdo3gloH?=
 =?us-ascii?Q?vRVMOXHhOT4NreEwxGuU4FRXr+29ynqs0tQJ5yifWkyVbEm7ph9kS81QI1KU?=
 =?us-ascii?Q?4Kn4gb+Qngfo6/yVJGt9KDRkhXcbGCYGAi3OaqAC1P3wbXY3/zQ4oAWBQWY+?=
 =?us-ascii?Q?bfZqe2IWogLKId1FtK88P+ozs7wg2+Cjt+lHdUcirO2fobm6IgCyEpzKV8yV?=
 =?us-ascii?Q?aRwn5Q1Gk0R+RkWvHALGrBxdnHZyaVEx6knHrAkZKisd4lq2On+nWd+R7Kg9?=
 =?us-ascii?Q?rbXGnGw2+zoaSzQMfTLh/sRH4wqsGwdJy02GnKt1zGYf11s5U61nNppcnquI?=
 =?us-ascii?Q?EZQAUP6j/dmwgMb2jjfMLlK7EIwOCWtHu94nVS7N+WHt67DPjftAQzIZ4CLp?=
 =?us-ascii?Q?y/oXHpe8hslZZfJmisx2hOp+EL6NACElb5RqS7wF1h64qBS+60SbUh2DW0ng?=
 =?us-ascii?Q?aAh6e2uvRgliH9I+e3RfjaWfYoYPzf4HoweNecuQlsEdX2e0Y2iUI2IDOB4Z?=
 =?us-ascii?Q?0q1BgpbED6afPqV5CxfKjElhYyEcy+yndfcJPLkN+fLxvbaaT730RQ4KUETs?=
 =?us-ascii?Q?yYmFsnukJpSOHeizopHP0vBxeNoX3bvnKwizJi87wTL+uUMg+o8QCQZGTiO2?=
 =?us-ascii?Q?o3FkBW4r8L32Cbzw2PbKETcLk9zMZB29veGDXFnVyRzg0BH41wBeKXGzZT6T?=
 =?us-ascii?Q?XTNzzJwnF3Mbdi9CS2hMuP8JyeirEEIEaqgAhtrZOu3AaYytX5kJcASrH+oY?=
 =?us-ascii?Q?FRJPR2061l8tL/WJP1lvksuhNHMhS4dH4ca/EGL1qN0WjqK6xcsJdn8s3NRb?=
 =?us-ascii?Q?HgmHis9YEaTRiKmSMpMJGqatEnGVinBjZZOEG/hxoFSn6nJMIgWdJgJBsNrd?=
 =?us-ascii?Q?F4QmYPuxeMmoqxtlLOqnXPO2vGa45U6RxSxjSXh12XmbJLTlf8hu2Jh0BhSS?=
 =?us-ascii?Q?g07kww+3xyvRQAiQZndgSWhS8nD4R4YEIGgBchYTPp73AlL/rO0eP94xngJa?=
 =?us-ascii?Q?XIAIYq876oRNnFxtvYPktqGC11PaeP9bi+w2DLXIVF2L?=
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
	8LKrNhLgE75+KDKwxWXodANrHhmQ6PHNBxOezprxsFxRIb+dr3NO9azBmGAd28x2VWjtd9dBjajSBIgvfuOldiNVoFoRBhuPedhdZr5cEZU0ORPuAGUAs+rUfXNgC2TTB5h671dwpaxAI3bFU3oZxRPyh/J6s//UptLnbGdT99kTZ1PfiNMOlNZwC1PW8tNaOtIyW6INDp+a+u7y+UtAHhEEJGyfLWrjYZgUreE8acsQIHHfDO1Nk+GBO/k9p1NHKxKkk0AGsKsl86fEE0z2Vf54CDjlJjtOGf2R3q1cGgnXFkF289dmXX1nNdqB7u3Xv/xAy6HCJjxHZBGH26lZ4jomNgwvFIVHhg59grU22AnhR5crqGVEqLDTlk2uKuOr3bBt4Pe016yJJ8dn33CJZ25eYBk5zkIu0jGSkYt5ZFa9SQFTIbBNoQ04cnCSlLBKlmvrChtKV9en5KATzKP0RwWXv+jlPlZd0tHxu71FnaN1RcQ46gQ7PBQqofWM/+WHxUKLOaNypUOH8G5M0cfSqmJTbtg9mCsTjHCMBR1HL4FO1XD2suwKWKwG6k+ieN5NYF8y4L82aFhF/L7vAosBBfGf8e1UON/46+Dd3Vr6GS0vR+ngkdXbTkoEpEBf19INlcHh3lsvOMMhIjS4nUJdsA==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1bb2116-7c6d-4207-adde-08dd5704504c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 07:56:59.4673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VIRtWXoGU/Oxska48OaZDnvRbQlJh+tXfroXMPM3iWvyUgbvSnbS8A/RVzTU3bqlaekcrtK1MTLBT+92DiRRdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR16MB4691

> Product names for some eMMC chips can include trailing whitespace, which
> seems to be rather uncommon, but makes emitted messages and /sys
> properties
> somewhat unsightly.  Here's such an example from a Pine64 PineNote, in
> which
> "Biwin ", as the eMMC product name, contains trailing whitespace:
>=20
>   mmc0: new HS200 MMC card at address 0001
>   mmcblk0: mmc0:0001 Biwin  115 GiB
>   mmcblk0: p1 p2 p3 p4 p5 p6 p7
>   mmcblk0boot0: mmc0:0001 Biwin  4.00 MiB
>   mmcblk0boot1: mmc0:0001 Biwin  4.00 MiB
>   mmcblk0rpmb: mmc0:0001 Biwin  4.00 MiB, chardev (249:0)
>=20
> Trailing whitespace in /sys properties may even cause some unforeseen iss=
ues
> with some scripts, so let's have the trailing whitespace trimmed in produ=
ct
> names for eMMC chips.  Although not observed yet by the author of these
> changes, the same trailing whitespace may appear in SD card product names=
,
> so let's trim them as well, which can't hurt.
>=20
> Touch-up one commit as well, by using proper capitalization.
>=20
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
Acked-by: Avri Altman <avri.altman@sandisk.com>

> ---
>  drivers/mmc/core/mmc.c | 6 +++++-
>  drivers/mmc/core/sd.c  | 4 ++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 6a23be214543..1522fd2b517d 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -11,6 +11,7 @@
>  #include <linux/of.h>
>  #include <linux/slab.h>
>  #include <linux/stat.h>
> +#include <linux/string.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/random.h>
>  #include <linux/sysfs.h>
> @@ -66,7 +67,7 @@ static int mmc_decode_cid(struct mmc_card *card)
>=20
>  	/*
>  	 * The selection of the format here is based upon published
> -	 * specs from sandisk and from what people have reported.
> +	 * specs from SanDisk and from what people have reported.
>  	 */
>  	switch (card->csd.mmca_vsn) {
>  	case 0: /* MMC v1.0 - v1.2 */
> @@ -109,6 +110,9 @@ static int mmc_decode_cid(struct mmc_card *card)
>  		return -EINVAL;
>  	}
>=20
> +	/* some product names include trailing whitespace */
> +	strim(card->cid.prod_name);
> +
>  	return 0;
>  }
>=20
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index cc757b850e79..8eba697d3d86 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -11,6 +11,7 @@
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
>  #include <linux/stat.h>
> +#include <linux/string.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/random.h>
>  #include <linux/scatterlist.h>
> @@ -95,6 +96,9 @@ void mmc_decode_cid(struct mmc_card *card)
>  	card->cid.month			=3D unstuff_bits(resp, 8, 4);
>=20
>  	card->cid.year +=3D 2000; /* SD cards year offset */
> +
> +	/* some product names may include trailing whitespace */
> +	strim(card->cid.prod_name);
>  }
>=20
>  /*

