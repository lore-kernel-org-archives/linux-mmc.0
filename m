Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A59E2E36E2
	for <linux-mmc@vger.kernel.org>; Tue,  8 Jul 2025 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989247; cv=fail; b=cUwLG4BI3qgtj1ZVnauXoQMRuoNLimtFabv1YYjGlvJ3Sg8OCJ438w85d4dwyaBuigtucYwLB1veBDj1wpFOPjICGEpr1pbvwtWPp43TxusYLrqRa2q0cKxJh0+6XPSBs4Wo2PT2lzk3tlR8jOobFsQOLwk1p8SPO9pzY8PJ+Ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989247; c=relaxed/simple;
	bh=hJ4jH8QRHG3CYI3d4tFuKZtPoIBlMn3ZHsYqKI6yHDg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K5cXtzwSvg/15qU6O2jRDiFOCJNiP4z/MlrJnw76NQgbxkgio9lTThoxDxbNU8EkjkcDaxh9mGnLYQHgFs0DSOPa+uzvv85slDopoDVch96HpocSr722ndVClV6E/ceFTLrxOJ8CJj7PuFKpayNLEnLpakhjvGxAvoanoKMF9YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=RXhRzMLF; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="RXhRzMLF"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1751989245; x=1783525245;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hJ4jH8QRHG3CYI3d4tFuKZtPoIBlMn3ZHsYqKI6yHDg=;
  b=RXhRzMLFFI61KDdPfPD3uKO2uLezCUkiYHzalNlv+e4S1vOQzENaiH95
   HGMIztbbWSZtdXtdirN++4PZS85r+1el70S/Qn3C77jIjYrZvf6Fo2otQ
   IJ9Pw/pZpBO9l68vVyRaHcCx3rQFS5l7L5Ab0cvVwYGc+daCTDgDID9CI
   xOTyA3LW5xM8L3w1Pi7y9lDhgQAW5dqAbaZ992HSUjmXdaGHsI8WDECwf
   3pdTSGuY7KGJc0M6a20U9swTX64QofvlqMAtQjZk6C6edocxIORZCeoRC
   tkCyvw1tKHgxDvmjChAlr/uNdPeF6AxyfdL0gPDD7ktfJLNsA8X5iUrYl
   Q==;
X-CSE-ConnectionGUID: JO3oCMzPQ5aoLU7ZIugsvg==
X-CSE-MsgGUID: uUSQp1xxQY+WXqtOrn0ONA==
Received: from mail-bn1nam02on2139.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([40.107.212.139])
  by ob1.hc6817-7.iphmx.com with ESMTP; 08 Jul 2025 08:40:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXcMhA9y2m4EqMKbQztT31quIkQd8P/sz7NWEKgliPbp/kpHSN43R1y3p6FloXwfrLrgHiK5r+jXa4MsN7Y/uD2xdgTef57xjlx/EuqIQxh13zKVI6FnMGC02iM+Ms9XSN2KBnKVkdT1rGaly0Ba9+2a2q0i0glfpnZTFvY9mxRRRufvn+Bm01dEVn0Xr8c9hurjfiuLP5t3Xy42oGqaxc+yK9YbLKdf+a6ln8PCQzYnSb03klM1PIdUYzojp/UxurGv645HbxTyQ6wQaJUdQNVVVL0saCoF1pAk+wfVhFUFR+3zdwj/J0LD+te76B1KmkjxtGcLXcBb1qCdNm5AwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7JcF2eS6RZblLaH3dj2g++llO4Q0PizSkDZXCS57Ak=;
 b=EtSwqYhRdc4Twmp5xMePfVpMX68rzGsWoyN7dXHjYDjMBWn3v1pMvwNTruyIiDmosDaxgsFrOpsCq//Eo1/f+gUBrW0eZhcU/1glevIe/1Dw02zRB6IVM8puZ+fPd+uFLqY0NHPNAYfXvpsyTfLPjU9iUh5LTZSAyCJM6pwsX6jp90kB4eGaPCXLvA2disf6uR57SmInUA++udaR5dZg82/wgemN8dBiUgH3463YscRdqwn2kapbjHBU36y4x2P2zi6UPzsOuFOq4CdvIS/wwhKCgnP3YJzNFMbc32LsU9bY+eDankXNAc/hDiDHqVMUb9NFU0/ta/a09gJGgrfm3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by CH1PPFF9B87097C.namprd16.prod.outlook.com (2603:10b6:61f:fc00::a2b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Tue, 8 Jul
 2025 15:40:36 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::3f03:3b5d:6737:8231]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::3f03:3b5d:6737:8231%7]) with mapi id 15.20.8901.021; Tue, 8 Jul 2025
 15:40:35 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Michele Dionisio <michele.dionisio@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: "avri.altman@wdc.com" <avri.altman@wdc.com>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, Michele Dionisio <michele.dionisio@powersoft.com>
Subject: RE: [PATCH 1/1] mmc-utils: add ability to flush optional eMMC cache
Thread-Topic: [PATCH 1/1] mmc-utils: add ability to flush optional eMMC cache
Thread-Index: AQHb7+FWalJ3IRKcjUeLu/CjZOn5V7QoWrBw
Date: Tue, 8 Jul 2025 15:40:35 +0000
Message-ID:
 <PH7PR16MB6196D50A37E3A318ED6B98BEE54EA@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250708082105.160653-1-michele.dionisio@gmail.com>
 <20250708082105.160653-2-michele.dionisio@gmail.com>
In-Reply-To: <20250708082105.160653-2-michele.dionisio@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|CH1PPFF9B87097C:EE_
x-ms-office365-filtering-correlation-id: 28d02603-82ac-43de-4acf-08ddbe35c842
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nawgqWlNoyHlJui+xtPjHi3uGEh1yEcIDocj7NoVfN2oOb4J9Ru0O4NaiDQ2?=
 =?us-ascii?Q?n58dXdfhfP0NV0eQY1DL29BgfIRlX+jqqBUvtMUJO3dgUzlJ4MbyrxVYi4AL?=
 =?us-ascii?Q?2dt63XSG80XJeSEBGWg42DqspXbPQIRG5rpz0UxvAxw8j3T1cMDqpDY3Z/iA?=
 =?us-ascii?Q?oijBTAt67nwY6JNKuf1uzd+t9br2slO9fCE/oSLP6mSfdwV6SP+UTs8AKmVl?=
 =?us-ascii?Q?/pYvxm/GvHRo3y5nhC7dxk+j8WG79a2xyGKX/y3+zNIR0OVLTzXoyhJNrW+2?=
 =?us-ascii?Q?5Jmx+6R9RTBT3jBngDK1MWLU/OQLLidJirCfAQbJLpddxBzgWofj77ZeI9wR?=
 =?us-ascii?Q?prBrp5kxUuoGFg9D4JeSC1Acg4f5K1r51DkM0IAAVHtei75Jeowkhp2zlRVz?=
 =?us-ascii?Q?IRU4kAReVTIRnBF/+lVqCwbCqKBmrAAYmturuJm0qRBEJrBc4iCZ7Ul3b207?=
 =?us-ascii?Q?iyILRxf/hnQV/eDEy23IaOhPRwKywtKL5NHcvCSn4alRizf1x12ZVPvvQuHK?=
 =?us-ascii?Q?pk0ux2Xq5PlfNXTCcFv117QpU02Revo2KQ8ySLJtsddpbsBS2v82eIFhRhXJ?=
 =?us-ascii?Q?2HaqXhz2tARIyUCFlvJocTJhOCEMUo1LpMhd3CXWepjDLW996cHaWuC2J2Ff?=
 =?us-ascii?Q?3xg3ugdEn3qAE/onQOiNAK/cjVYlNDVgf1rIDDKx7A46N9qx20cm+XpZjZMn?=
 =?us-ascii?Q?/Smt9wxs6FQ9TGOzRQlajYYzcQf/6AawRB8ujUFClyEJQlCaKgEwVWYarAus?=
 =?us-ascii?Q?2EWuf1+CltycJzWsFheP1cA754UMM/2r7NDdWB2aZ0ikyMtAHeaASZDOxEE9?=
 =?us-ascii?Q?c4rRXSf6QlHofTU+iY72D5tV3fX/n7Vt/RN2RQCFO3PHwmj/MHZGD6U8d5nh?=
 =?us-ascii?Q?lLAziICWCBdUz9iR7WtfeI0wl6Hh6FMu2CpbfDu7rR+WtR6FAd/a25MHNBz8?=
 =?us-ascii?Q?PQinznGb5TcyrNY6o8yoSono0m3nUxQIcy60avHQxJ0jgk91A3rWDjJcIUeh?=
 =?us-ascii?Q?z8m2qysB7PEwL2TyRXORkEuWw4xP9hTHUuba2m1fWFwgpB1rRgWCStJEFu66?=
 =?us-ascii?Q?me3aj1UCgSN2cLzgaQqj0KyYURRSjl5OkeoFl8C7yxMf62LIXj76lBwxwP5f?=
 =?us-ascii?Q?Tk/M9DQmZ6IOunC3oWF2TXXg9lzAqFV4tBBhMdDpSIvbqv0Ds8VitNxbs86j?=
 =?us-ascii?Q?x6jPjDPWRBCgouvc/Y8AGbebu3F2kpjDkyEpxvnf7QIGXLW27DhWUZ6ZNc/d?=
 =?us-ascii?Q?L72FT6cKumK+s8SHHDmbARx2dBMBB0z+cGL8zS4+0osnzblFjFRGg1d3Trrt?=
 =?us-ascii?Q?e8Po3Ym3GrQk1TrlyzTySl7A/er1sCEKgQpbpVVkMZ/0JUzc4tPE8ySeoix7?=
 =?us-ascii?Q?9UbAyjgeKpuYd/zNotlRnv4cBCp7Dc3IPyFrQK+SKOV+JCQgThq8kEYrjhOO?=
 =?us-ascii?Q?okUnpKNWQMFHDTuus1Et/vlt8aPiCR3RbBIXEKsis7qKySnTzR6m0A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?z5qOM4Z64r0bpSxpBDKtGNI3oc+BHnGNMslh3kWJm0Wyqm5F+LQ3axjltSXe?=
 =?us-ascii?Q?TEI7IeYj0r+MhClWqD/yfbc2laBJCaa81pZNgXd0K5N9XtrVBz5Qyrl0+bNI?=
 =?us-ascii?Q?kbsaaZ5ozsf6ho8rwwCOSz3BEaZNFXxiOtRdYuyfPyGo/f3OoJPVjPbTOuoV?=
 =?us-ascii?Q?aU77+jEkbXVvGAFi4DKFTUP2k+Xs0h9EWJG4PlupF/tpgfdYoBziDJuOcYvi?=
 =?us-ascii?Q?NwAtOwEfHN087ObosObeGlYkC28ytIuYsHS+g7C12yHQwC36krVSnaDMJmqC?=
 =?us-ascii?Q?PJCqRxsrCEH81RN3vTbRXfNVqgqsp+/3Wds9DnJlv5/NkmTFGgGVMW2lbMsR?=
 =?us-ascii?Q?1gAILzzyHK0As7VXaUrvBoy+KjpZd7D5oX1RYROdgcDlhXRiuFiAU1TUL+jI?=
 =?us-ascii?Q?KpIzB045bwDdMTFdSrilLUWDVhYrSuNPZIltuANI+Dvz7+DRNZ2pxdklMT2e?=
 =?us-ascii?Q?O83xLvEuufBrowHsjbuwtsPS+NxkfZdQXgjX/VQ1lmanVxEdcznzb/v9yX1U?=
 =?us-ascii?Q?q90SfSOrg9dwTEmXJfrNjxYN3wo7pm4wX8JQTkFIn+nQdO43GNhiiPqGu9ha?=
 =?us-ascii?Q?qYDde73XRwbpIL+4gCmnnM7LoHjY3pxcsz7qoIW8MYe57WA9jvqOPIDhAXSX?=
 =?us-ascii?Q?DKGvuHvtjoWzaakpnkbmaph/dSaJwuMq/lbMv3SIEZ21fQdBaHKfWXikPZm8?=
 =?us-ascii?Q?X2D6wwroZeBkVy7507V86R42iG+vA4L6p9Ho13zVS3H+xs7VB4HBW1bmevJK?=
 =?us-ascii?Q?Iy2Hcbmuv2mpN9K5LR/TC7p6aVw5CikM4tcmPPr6UEW0u3PzPJElojSdskbM?=
 =?us-ascii?Q?VYZP+43UJF5cJMS+0gUXNo+morxRQ7G1mhR3WAXEQULwtcBN9eQyiYq2jzTN?=
 =?us-ascii?Q?FrnPHWSRmokHEVUAzBDets5WW4GGc5n2qrBbWzpNMUzIVrclMq8+X4u9FAh9?=
 =?us-ascii?Q?tcU89IW45GxnMsLOiuyzDZ6YIRM/lYDF0omlnNNDKzh7gc3SqjZGlv9hopsr?=
 =?us-ascii?Q?jf5zZeRKkAd6J0g7NHoj71UaVFa6PjBPzGGXeHgsq/Y+yjnlSj/RiSfEy1id?=
 =?us-ascii?Q?Bf3zPS5mPc1rij4DDpRIZ8TbzcdyKomj+ntENdk3Rc2meVwSdPP0WzI53ThT?=
 =?us-ascii?Q?iyDmXJm3cVK24XvraTiULdDSOneidIqpVx9E0xWvBVoHyEVNpChlVkUfqdmV?=
 =?us-ascii?Q?abD/O+usVAlDk4hsyTZycQecFEzmvD2IEgOeH32BM3pXs8ziVhgPDVFuwHlH?=
 =?us-ascii?Q?vgIYXP9we0Y9wka6hp3hoJL4eKeQKLFqn6WXZz0p6C/iZbwXI1HiH+1jrssz?=
 =?us-ascii?Q?Zynvq7cdInRmkooeFnsve0YMhWB7arAsqSMVJhxGYbMun/ColZErH7quBmkD?=
 =?us-ascii?Q?sGsfxxbCCT/C0rHxUMOA0iSRbM1eZVeUcI/Cmq63iZ/l14Ks1aooWvHI2q/R?=
 =?us-ascii?Q?3dMAHz9HhakpaBuxUt9+Cq9X4mZKAo2eZ0MZOwtY+R6R8IVnsgcycHC0n+Cv?=
 =?us-ascii?Q?bAyTEB32iDomikafxGl0kaP+1xccjfkny7NXNrqSpmYUUuOzFpIxdCm3jgqZ?=
 =?us-ascii?Q?v6/QUiQ3ABOn1Vi2Zsm4mutgyXg3O0RPL+Bc9x2C?=
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
	uqv96+mnezja82cxsqfYaHR0qqa24HGBxR8jF8r5563IHSueVp1wsBGXU6MZWwGlXoyI0YdcP1GB8dkq3zWIKYuV99uONqhjMQWFEmRUJgpHplFCwbgUDVleRWxzfwYMMriFmcFv/LuA3LFfNDDszWwmyNDOGHiElKsnMiyEBSdFS1899onZ34QedABtGQjDpFMhok0WapPSdEcR55lM4STEe2V268q+KnudqcTA0/SM7krGRtJ0LcakBqQXYze1Yl3dHom893oFYiPx6FtpzNoFJ2PMXmFwgFrJ1uBGaOq4aUjCGRGJ7TKUA+HZE57M4LO/7fJFO2zZQKpfGdy1LVMbPcqZnUZMxGRA+85SJBJVfOQ1LnDNTGvqT+AamfGezpsr77JerEvzp4Gau6ADVN2Er+1TH2DI2OR9TX/hoMhJ9TeFvl27DbiC9VrD/coZCAUicucgT1yu/R9JQ/aaIpL+C+a0n8ydpDGbkUSANyrodFVxIGvmqFfrgrk30oljm70MOMd3TIK8F3hMzYXu+m+/abNq6tzM6tuwZdkKmqZQEVarB415wx82aaVJVxET7K5n8gKJR9K3aRponwGApAGRdgPPx75hJzwgxLr2EVKpIMgguMQhMEK5X0ENPZf6xOdztopbdKIRESONjMJuyA==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d02603-82ac-43de-4acf-08ddbe35c842
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 15:40:35.8433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JmvSPHPiyEojy0zGkW6v8Ut1cfUr+B4sBc9vDo+xTjChvYS6h1nddyS/E8SvdCHAzL7LXaKC5w1hdFTSdle7lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFF9B87097C

> From: Michele Dionisio <michele.dionisio@powersoft.com>
>=20
> The MMC 5.0 instroduce command to flush cache
Please elaborate.
E.g. A use case in which you find this functionality useful.

>=20
>=20
> Signed-off-by: Michele Dionisio <michele.dionisio@gmail.com>
> ---
>  man/mmc.1  |  4 ++++
>  mmc.c      |  5 +++++
>  mmc.h      |  1 +
>  mmc_cmds.c | 50
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>  mmc_cmds.h |  1 +
>  5 files changed, 61 insertions(+)
>=20
> diff --git a/man/mmc.1 b/man/mmc.1
> index bccabf3..665fe6d 100644
> --- a/man/mmc.1
> +++ b/man/mmc.1
> @@ -109,6 +109,10 @@ NOTE! The cache is an optional feature on devices >=
=3D
> eMMC4.5.
>  Disable the eMMC cache feature on <device>.
>  NOTE! The cache is an optional feature on devices >=3D eMMC4.5.
>  .TP
> +.BR "cache flush <device>"
> +Flush the eMMC cache on <device>.
> +NOTE! The cache is an optional feature on devices >=3D eMMC5.0.
> +.TP
>  .BR "<cmd> --help"
>  Show detailed help for a command or subset of commands.
Need to update docs/HOWTO.rst as well.


>=20
> diff --git a/mmc.c b/mmc.c
> index 6770a45..3c82504 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -231,6 +231,11 @@ static struct Command commands[] =3D {
>                 "Disable the eMMC cache feature on <device>.\n"
>                 "NOTE! The cache is an optional feature on devices >=3D e=
MMC4.5.",
>         },
> +       { do_cache_flush, -1,
Better reduce its scope and set it to 1 as you don't have any further argum=
ents

> +         "cache flush", "<device>\n"
> +               "flush the eMMC cache <device>.\n"
> +               "NOTE! The cache is an optional feature on devices >=3D e=
MMC4.5.",
> +       },
>         { do_read_csd, -1,
>           "csd read", "<device path>\n"
>                   "Print CSD data from <device path>.\n"
> diff --git a/mmc.h b/mmc.h
> index 9fc22ec..2bb346b 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -152,6 +152,7 @@
>  #define EXT_CSD_DATA_SECTOR_SIZE       61 /* R */
>  #define EXT_CSD_EXT_PARTITIONS_ATTRIBUTE_1     53
>  #define EXT_CSD_EXT_PARTITIONS_ATTRIBUTE_0     52
> +#define EXT_CSD_FLUSH_CACHE     32
>  #define EXT_CSD_CACHE_CTRL             33
>  #define EXT_CSD_MODE_CONFIG            30
>  #define EXT_CSD_MODE_OPERATION_CODES   29      /* W */
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index b16ac69..1b26f31 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2870,6 +2870,56 @@ int do_cache_dis(int nargs, char **argv)
>         return do_cache_ctrl(0, nargs, argv);  }
>=20
> +int do_cache_flush(int nargs, char **argv) {
> +       __u8 ext_csd[512];
> +       int fd, ret;
> +       char *device;
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
> +               fprintf(stderr, "Could not read EXT_CSD from %s\n", devic=
e);
How about reporting what kind of error you got?

> +               exit(1);
> +       }
> +
> +       if (ext_csd[EXT_CSD_REV] < EXT_CSD_REV_V5_0) {
> +               fprintf(stderr,
> +                       "The CACHE FLUSH option is only availabe on devic=
es >=3D "
> +                       "MMC 5.0 %s\n", device);
> +               exit(1);
> +       }
> +
> +       /* If the cache size is zero, this device does not have a cache *=
/
> +       if (!(ext_csd[EXT_CSD_CACHE_SIZE_3] ||
> +                       ext_csd[EXT_CSD_CACHE_SIZE_2] ||
> +                       ext_csd[EXT_CSD_CACHE_SIZE_1] ||
> +                       ext_csd[EXT_CSD_CACHE_SIZE_0])) {
> +               fprintf(stderr,
> +                       "The CACHE option is not available on %s\n",
> +                       device);
> +               exit(1);
> +       }
I think you need to check CACHE_EN bit in CACHE_CTRL [33] instead?

> +
> +       ret =3D write_extcsd_value(fd, EXT_CSD_FLUSH_CACHE, 1, 0);
> +       if (ret) {
> +               fprintf(stderr,
> +                       "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
> +                       EXT_CSD_FLUSH_CACHE, EXT_CSD_FLUSH_CACHE, device)=
;
Here also, otherwise do you really need ret?

> +               exit(1);
> +       }
> +
> +       close(fd);
> +       return ret;
ret is 0 here?

Thanks,
Avri

> +}
> +
>  static int erase(int dev_fd, __u32 argin, __u32 start, __u32 end)  {
>         int ret =3D 0;
> diff --git a/mmc_cmds.h b/mmc_cmds.h
> index ce35d3e..f767deb 100644
> --- a/mmc_cmds.h
> +++ b/mmc_cmds.h
> @@ -50,6 +50,7 @@ int do_rpmb_sec_wp_mode_clear(int nargs, char
> **argv);  int do_rpmb_sec_wp_en_read(int nargs, char **argv);  int
> do_cache_en(int nargs, char **argv);  int do_cache_dis(int nargs, char **=
argv);
> +int do_cache_flush(int nargs, char **argv);
>  int do_ffu(int nargs, char **argv);
>  int do_opt_ffu1(int nargs, char **argv);  int do_opt_ffu2(int nargs, cha=
r
> **argv);
> --
> 2.43.0

