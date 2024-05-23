Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8AD282E2
	for <linux-mmc@vger.kernel.org>; Thu, 23 May 2024 03:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716435690; cv=fail; b=fN51EuXQWlqHIlPP135QXy0zKwCgUrVGElY6mxZ4BHOpc99vFnbowxfiz3XuHG1a0b9NPd8sfvHDjburrf0rPv56JHdfViBGy2qWMtbP6Srru1dtRfoMjuHgY14299CWpbXFliP2WqfdbRIj1Pdcu+ENFnf5z+KGvUZ897qgG9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716435690; c=relaxed/simple;
	bh=xOjRjwomktP28nXEnn3R2rI8NnJ3+p5bggBmz9kQFSw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gsqvIRP3CHKehEqQzrhrUdqjqOBrKw/8H05LcqxhCZmZqlT+mtM5gaLCfUZLv6EHyn9fv15q9zZCjTJ6ruZy+qw5le/OgYCtpjVJFAD2j3q8/roIOKacv/a0+ybup8ON5OBRFeWkemKDeMK+NydI0i6sCF02liOTivYzsLx3TVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=E58DtX9M; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=UZrUXS2a; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="E58DtX9M";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UZrUXS2a"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716435688; x=1747971688;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=xOjRjwomktP28nXEnn3R2rI8NnJ3+p5bggBmz9kQFSw=;
  b=E58DtX9ME0fTb3+wQAvYjs0IRLBRkno3d7+mPEro70tF3mlofVbpDs4N
   zK6+OuJ7M2QKttFXAta8RwuokaDNeN5hSGopnSQlfnjmOL1SRdX3scMWH
   h7xKVfzgw1jyyL+vpIa70dmbqnPapm2fg+3ZLiWxVXp4lwVHEhdFjDz6q
   SYySrApLGw6FFQ1mibK27p3UvwTn4dAvNKfRYvV52n3/uoSTDxi4PHmnv
   pKXHtZt+dLDxMexCDF1fk19cCOHc1cQVythb6j91vkSwbBSWk6Gt4lXx8
   u+2x1NCEHmWZjtqcBuDyyMfef17FDh+V5VwcmMf9q2t3lHJqcBV1vLMt/
   g==;
X-CSE-ConnectionGUID: 67Cb8lQGQ6qO9RmV9LvHCQ==
X-CSE-MsgGUID: W73Dv+OkTzW/4t7NvXFXkA==
X-IronPort-AV: E=Sophos;i="6.08,181,1712592000"; 
   d="scan'208";a="17024986"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 23 May 2024 11:41:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgyBSeEmovL35h1rAI6v8lYi5dLdOKTmb4NBve6EeAiwBRMbqu2/fH1LBuol2MuZlbgynWaDnyh8ymHSs+SfT68Wk/ENbqlYLDgTTmwFD79eHK6ynBEYVnVbMzGJlofe3I1C46hPoZTgTewd+Z/rUO89FDe9mgTJv/Ie3LFNoEvsgbk5QG5RyFk+zHVL5ec4zFjog0l1OH/NfQUfj8CGFfeu5XGAoxw0dLfpQ3Pj8qn9OUbChNrgusQGS2KUObQaROcelrbT8KrjiFsoAnGhY3R7XXHz8v8nW5Niv8SdcfcMNdKe0/qOtixnWaPB+/C4QR8m6yt1r+e1OghIDohBsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzKD6Gr7YF8tgO1jJ+EYDt/CFxTofpCdbvk8LivDmaE=;
 b=AlRq96Mo9bqVezJF7zJq06D7UFbomw8Z/P7loX+ColwqxyI2j26MdN6uwX41nFzslUlmr6DIGn4w7Y70S0ga+7gx8Wuy6knZWM1avdzfd038CgJJ4seWMCoqommPQSV5I/KqePc2qdIzTIOQpgxE+FXZ8Qpf8wPChihaWY5m4QWaYfv/NjWhPSFOfrnUWmjB9Uoxia0zHdG6hrjCnU5n3gcEpzJrHmJHwKdPwMkJvfHEtSYw8pFWuk3d7MWnvv+LvgELOvyLewq8K/NP0nfkbEInbjvHDQ+FJwVmkDMjmF/i+C4lzX4SjVdcQpdE7HgL2e5rnU/sb9Yk3TBgpEhjRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzKD6Gr7YF8tgO1jJ+EYDt/CFxTofpCdbvk8LivDmaE=;
 b=UZrUXS2aiFlqIo7pqjDw6/amx9p0cYNCflHFVo10YVQDFqPLZL1admh2O3rCVecR33BDFsA1y5XEiLoXDHnMNOsYnOGriM4EXRUqNtti9XhCUkWf4+CBJ2I/DTpL0rpwfcefgkY52LQAiAcLi5f5n8KeBPrUUj5/PUnleZbmt90=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB6652.namprd04.prod.outlook.com (2603:10b6:5:243::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.19; Thu, 23 May 2024 03:41:14 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%5]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 03:41:14 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: "linux-mmc@danman.eu" <linux-mmc@danman.eu>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>
Subject: RE: [PATCH] mmc: core: allow detection of locked cards
Thread-Topic: [PATCH] mmc: core: allow detection of locked cards
Thread-Index: AQHaq8Krv1Goun2C+EuFVrxR/MG8DbGkLdiA
Date: Thu, 23 May 2024 03:41:14 +0000
Message-ID:
 <DM6PR04MB6575668B7CAED3CCA18D0BCDFCF42@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240521210455.543587-1-linux-mmc@danman.eu>
In-Reply-To: <20240521210455.543587-1-linux-mmc@danman.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM6PR04MB6652:EE_
x-ms-office365-filtering-correlation-id: a6e5bcea-871f-4c3d-4db3-08dc7ada3271
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?P3mRVm8AxrHws0tEf6vluY05VDq9+QiKi0EPFOLRU4PJGrf614Zm8RRgKJaQ?=
 =?us-ascii?Q?P6+5FOH+PlEDmiESWztCgHw4UvcQRDQW9wc2EhFdYCNkrgi3D8w8butefiTX?=
 =?us-ascii?Q?D9cuGsWXHh857s6BEVSi45DgSHFY1b4rbcFkQAb1hixn/DLFPadGrqSu8XCe?=
 =?us-ascii?Q?+7oq5oTk21qd7uRuDmuMjEfdjqShw9LCKf4SbosrQIM1ucHJswu0+KsJ3ot7?=
 =?us-ascii?Q?digzS59+oTe1qKkCn8HmFR0ZrviyEe5VmFylMOHVhNWAiFSQ4siJKKSOJZIt?=
 =?us-ascii?Q?IoGPkD89XUugXJ9tq8tJQc0WEg87CbaHeJZLYyYTDsFr4wk01NdRy6moe3Bf?=
 =?us-ascii?Q?6H8Kule/KybX7JBL/9KxL47ljQA/hkGczl2O1ewjTpSL9+EV33XfcCdPRGSS?=
 =?us-ascii?Q?cwisPhCzlFUIWj+H8Jhh9bP2Joni68CAZf206Zte6s/PklSe3ERZ6Yb84NPm?=
 =?us-ascii?Q?sVs6lXK5Gz8DqyQJrflIhjHhvrJ9JH/jOdWP2XOByTbM0SLNsqmUhrXeIsrh?=
 =?us-ascii?Q?N6fedcOQ+SPz1DGg5BzsDXOSLJvqi+nhCorfg9PZHj81hCAovHEf0gPFFkql?=
 =?us-ascii?Q?fFrCuBhw25yIe3ucpcb3Qtz/trGs4V6QCHPgxDQmP31rvO1PvHcSYB6BbPst?=
 =?us-ascii?Q?/y7WTQFxeImSQNJHfmKPLbM6c7texDi1nurfdrlPjPB+jLoknOrP1aqAoHmh?=
 =?us-ascii?Q?97D3u+NFmG6X6QdT/vdh1O3q0ptiuJaWawMz/xN+O5AHoOGSfJnJZ5w+7IHX?=
 =?us-ascii?Q?TX0yL2KGacnuFSqN/lWT31mph+cIqzOiDQrd1DheOm3UttieZSiM+vpzjzBH?=
 =?us-ascii?Q?4qqc6jP+DOwv4w41wEI14rUqm4UF4NznNcxLrXAgneO+xznogqX5u1vKmK2G?=
 =?us-ascii?Q?xIc0bwd+MAn68B+u9lZ4+CTxcFUcy/RYVlxfYYEpCylZCaY/axjJFfykh1+I?=
 =?us-ascii?Q?UhbQQpz0GGE2SNckQyuttKfq3DVhLVE7CZX46M1yJD9WSXvpXomySmgCk54T?=
 =?us-ascii?Q?ISHDjPshY462uKf7x1vCQp+qBDHaBd/t7ABF5LxIfXN949XqvnLfwozEFUc0?=
 =?us-ascii?Q?RWNMI2w8SGuBfr+TfCK1wYZnrBcdKmuVi6NF/GAALQJzVH0xr3hROoPkA5eu?=
 =?us-ascii?Q?MWyzbhLU9709XhBuyLH8LO2rVyw9ujFi9Oot16YDk4RqQ8rGImB/Lsr8KfYG?=
 =?us-ascii?Q?uK2SIjrXc7+Mou88TdUERk5gBuqstO3bHTkzLZAxvepeUL4AzEUXWJo1YEqz?=
 =?us-ascii?Q?FEAMzlhdU9d+VwaxQg7Pl+d8aGbrIYjumqQpyBvgncSLbEK2/eebyqAq2GGn?=
 =?us-ascii?Q?6iR6uLcQ018SbGnQhxLoOo/LoHp94fXCRJjnP9NXOALHHA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xmBn1sgCKsE7s5PDUsDjAj38yTaHj+i/705C6miyLqFF2UDqGt/NWJMD5JbC?=
 =?us-ascii?Q?akQP7D8Fh1BVP9/tVBzDxmw/9T5qBtV9t52qMhW3+48TVa2vxqQ5cuTCkFZC?=
 =?us-ascii?Q?hbsEl48dCMCzKRolzWq3gu/nFy+c7SUGkZlhojrC7iQE6p7rmCONq91+1u6t?=
 =?us-ascii?Q?lcVof9oHBGccoj2D0UdzhrOFSX/jSOL7m2YbpNNYY/iB4PNLrJgYucrz52Cs?=
 =?us-ascii?Q?HwKtRk3Ly3CsbkoIPvphJjVgq+a0gWDXwoOmNF38l8EeURL4TYTDL+vf6ivS?=
 =?us-ascii?Q?u2sU4mKyA2jbfAQpo4IrcLLVRyvHBuALp/P4vAr/2iE+21C6jvK8NQpya8tV?=
 =?us-ascii?Q?NT1mVto/iJcgYimWDYTpYYN3nWyXHtQsFhoPd4c0mBcVMwZeEzXAm0lZWG06?=
 =?us-ascii?Q?spWvz0xH2JiTyJdmFJ73V86CoIl2N9XV4s/Dl6CStx4Xry2SSvMFtMjczsCm?=
 =?us-ascii?Q?obuRox5n11BFczBJxk6wKQBmUwQox5jJP77TL5qbthtl/MR9W41yymjRaylx?=
 =?us-ascii?Q?ZYeSeLZAcukWcY+h1Cy3gMWz4RI2qQRCz3Agfq97RPF4yIj5VRjzvAX7frLM?=
 =?us-ascii?Q?/ipm7Qwhq/08X/a2TVaqEdLuxXQZ9KAaHFLJSu2yY9ozfq1BWrArH9nhhA2I?=
 =?us-ascii?Q?R2JafYUI2v25fcCKX9xFiqR0QGebF+C1qVWiFtt2snOlQi1zITH8qNMHjJAo?=
 =?us-ascii?Q?mIzIYaEx9XfT9zrH77aC3Ul96E58pKCZOtLGhu5HE/WnVKHF4PcowEPuBXPw?=
 =?us-ascii?Q?RPi565qqRfGFaQXHEF/NCP2AZedipwOwyyNBJ8KFyNoRA98JBfcnN2N4oBTY?=
 =?us-ascii?Q?4FyCnj+CCcDXU6dRFYhVSsgzIM46fTXYFOL0IuC2tqc0iN5rqctNCmqivv76?=
 =?us-ascii?Q?AEUtPBaec8O++4yV0geXj7qe59SSSc6H1wtcRoCO8KehihBP7A2nyvg5Yvh5?=
 =?us-ascii?Q?/Qf0JGMzbw8ctPxKIf3d3hSFD4eI3cDPIDzzJYM3tqjfT6Kr7x/8+v41f1K9?=
 =?us-ascii?Q?E2L0ROGoF7b+rwrDqBcG4zmn04tN3jPdaA8K07KsvfUpDYPQBjukkR8cxIzL?=
 =?us-ascii?Q?Wp6mDqfdZUXUbmYMFCVwqcL8N91846RkslQgfiOGPx4mmM4zwu38ECgTDITe?=
 =?us-ascii?Q?ySh0jHz3pY/e2oPw6PFuRoHQ63dC1ZzDciuR6SWklKZAEXuXWWPVOD1L3UjL?=
 =?us-ascii?Q?3uOPYf4GQZN3heYoS7eq+Ivir+zdxU2OmA/2qSAEA4gIUZ+cy6HKcCWIEc2Y?=
 =?us-ascii?Q?pwokLgLVbY/Yd6SG6dQljm4aNQayJoiSGGw7WvMl463P5HW/jFGcR3r/XvBg?=
 =?us-ascii?Q?9FCBPuyEBgPhqQn1ZwKTb0xIt3ZosW1LQhn5Qjddg1BQ7Or14z4uDv2+FwKw?=
 =?us-ascii?Q?SgTU83/H6SLOmSoUthlmOErMqI/IOTOrcf77FtJxzna4HK/JunHmxjQWG3+b?=
 =?us-ascii?Q?BRyNxn5EXrU1+MTa7k7eCQ2nRnGlRs+BxfxyOE1cwCSluDjkYWvKI9k+QSyM?=
 =?us-ascii?Q?K+Y/TE4699VG4CvukzUmPDJ8nShpmIquxXMnG6PmsmEGYYFCC8DBWj8jV9Ln?=
 =?us-ascii?Q?AP0To7+gOzfvf1x6fd2PpldTU5Xa1Rs+IYGRK6JhAn1lOFQjEY0m/fxNYSCQ?=
 =?us-ascii?Q?D9nLkH3zhUEmkpgARStSOOrzUnUVZSISH4IVXmEfoCze?=
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
	jJ0NhHAQgpMg46yLLm3pTPSszz0yoGJQcHkAwtmwvyftXJh1ZWr5UNai3/t6YDbHGsdT9fnY/7tkxKNRYj69QBU31bhTx1lC4ZPsK5s+vUspNJt8A3uNUmzIhz/J6TRGcS2iISyatedUHO8zjlvdzpCil8xgLrvvpobzXGxdp3neD55p6g7QymB6H0M2brbGYDh2KaVsi7HJrShTQOXTml3lFXN1IB8P6JhUyYHJiMXo6rCOosxmTZCfxl/cdMqxZXwJFE1ast9pWRHRcKQOqtXgdLt7RfCqPEjfEkAXoo87NJOLUJhAHKqQy5Z6ulRt4FnfrVjfN0/9ey8gtr/JfN3bn9mofQmzOST5BPKl3wnbUkGAVq5PhKpUCCWAkdzLWlOxQPj3z1N2X9LYylqSDA58s/G3t9HELzDn3ZGabnpqk2qclXht3oeioWIPuFiE3gr7jEV2gtLkJf57vjIfJt5P50mWMKO+dTtVzK2qi7sderMfNhahJTPY6vB2i+736SywriFEd06u1I9d3CmfK1qlcVJgZJf8btU89kL9GfVl+DWkV7rtIzweKv/+EiN/yL7TUK7uhIx2hsrFcJgQJBxEKK0pZIUoVULf07XkE2WT24BIzm3lLZ+HiWI6PKyK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e5bcea-871f-4c3d-4db3-08dc7ada3271
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 03:41:14.7431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4NtDr6nAv0N+kgZGYL/QE63FVYuhD9s2eE2qosaATSE4RPvUzW5baf3yVR228GnIBdBR4rsSzJt899HPBvzv8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6652

>=20
> From: Daniel Kucera <linux-mmc@danman.eu>
Please don't leave the commit log empty.

>=20
> Signed-off-by: Daniel Kucera <linux-mmc@danman.eu>
> ---
>  drivers/mmc/core/sd.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
> 1c8148cdd..b22c30348 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1475,9 +1475,22 @@ static int mmc_sd_init_card(struct mmc_host
> *host, u32 ocr,
Aren't you be needing a similar handling for the eMMC side as well?

Thanks,
Avri
>                         goto free_card;
>         }
>=20
> -       err =3D mmc_sd_setup_card(host, card, oldcard !=3D NULL);
> -       if (err)
> -               goto free_card;
> +        u32 card_status;
> +
> +        err =3D mmc_send_status(card, &card_status);
> +        if (err){
> +                pr_err("%s: unable to get card status\n",
> +                        mmc_hostname(host));
> +                goto free_card;
> +        }
> +
> +        if (card_status & R1_CARD_IS_LOCKED){
> +                pr_warn("%s: card is locked\n", mmc_hostname(host));
> +        } else {
> +                err =3D mmc_sd_setup_card(host, card, oldcard !=3D NULL)=
;
> +                if (err)
> +                        goto free_card;
> +        }
>=20
>         /*
>          * If the card has not been power cycled, it may still be using 1=
.8V
> --
> 2.34.1
>=20

