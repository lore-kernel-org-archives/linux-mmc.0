Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEA04B1E72
	for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 08:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747730223; cv=fail; b=mxDW8BQb/3eXhVI9BZJq8/jJJAWbfrIvz6Z1aJhrcAl3eT2cGN2635s+xqlBVH0NpjzCGx9QIpkg/Quq6Rz2X0OuDR3LknUjI2ukmzNYlDQYvts4DdBpSSO5EuVZQAgZPB93S6l6UjqMPC/D7u7uZtF7rw+qkClqjiy9fELZMtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747730223; c=relaxed/simple;
	bh=F2hR/QOiQ+kuJMZwolnApQyJJ3BmaX57/NzAqo2EkXE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CRNyAAmlm8yMDd69RPEtIloIfkKqpejGG45xq0AFZ5maIPi9QSnUpqZhcXZFqZ6Ep4DwXe3wxZaKyR8s5+QI/HLJEVk+BhgOEfzl0/523Y1s4ua6wXwPY4QFXYzCunwegM77/7JUlxATMSCK6MmLskwp74ggCqxmHQWeBCzbrTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=vqNnuQku; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="vqNnuQku"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1747730222; x=1779266222;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F2hR/QOiQ+kuJMZwolnApQyJJ3BmaX57/NzAqo2EkXE=;
  b=vqNnuQkuSt7Bv5vn2GVPGtmOORaJfM0XYDEkD7YrrBV8+YpuMeZ570gj
   g5cVuBRzabacvdQ2KFXnvAo2VZBf9yzqF2lhcvsSQLO0/ZdlpK7zSztA5
   FXn2EVpxHqqzFxUuhQfBb1ZSfxvfHagPrCuTN+E1OA6WwNOXyJaH5CNmV
   MKdBz1Vwta+LW4EPYokTcNLI6lVGGPq6XC6MytO9W+WJuD6zTJZzsTu+l
   d//zO9D0SxjUVJlz8EM3NR2nY9OJcb2Qoez0KkepRRqOwkifFkAVY4xjk
   9sBogS/nd33b5hr8LmNhgF4Xb5p2aH03MOUeABNlBEnUykmif5pO0wx/k
   Q==;
X-CSE-ConnectionGUID: /ku9rWayQzK1g7zT2czJHg==
X-CSE-MsgGUID: UEkuTna9TjKM3VhRKoSHLg==
X-IronPort-AV: E=Sophos;i="6.15,302,1739808000"; 
   d="scan'208";a="84591050"
Received: from mail-mw2nam10lp2049.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.49])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2025 16:36:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hi85iYSmfzah/BhsjEQy/DBJGQ8XULb0d2XW2Sz9ZzXuKiy25dPU8fbJfkbdCCxe1G+OrDCdKvBmUJfFhbPcBoSgNYuqRk4ujIP+CfGVT7vi48evtFOfmYRWYS0mylUr6LIZeB08r9UOPSSM6K2cPa8/zfVVoca7b8j0tY0TYeS0e+wReMVAgMyxaq9hTbgPbuZpWK/0WWmshbMUF2y18HLmYtD7+FCD8y34VDSWSYjeVoxTq0s+KzlG76HofjSZFbvZGBjRwoNbVBlnK4b0qfTWwpPUPyQqHYl0po5fO85+nFnOwI75ttZi4QNCRXkHaEb6zK/nnw0xenskYhIqCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaySLobzYo7WA/TNjhdCnZxXIX8FFsz0qX80WzS9aMo=;
 b=ud+efhG+GLk+s+YGIwzTem1rhZbeqaB/qcGpQqU408HL6nz4zXHaRzwzqskysz5adynSs9f55aJ0tKHym4k/CAzkXbR8vC+x2qzAKgKdA2ShjxJSFaqOqMikgINPwDEX5FILoSYoG0tbJiEN7n22lfaCowsukCIFMxZu4RxeBmCe8z3pHLWyCg/uvV3hJ1D1ClxMJQKrUvr170aSy3ITgs89fozUqfeJ9boToiqJvUYuunjsQ5A/NatjfH+hy89TTbJ1GIDQwdN3XbyhmAKVcqhgzMEZabAgtlOdgQCL4Ddu5TlNGnsrM3sQuqllY+mYREfCNQc5iX6jXus0Wov9PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by DS0PR16MB5389.namprd16.prod.outlook.com (2603:10b6:8:167::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 08:36:52 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::436c:8204:2171:b839]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::436c:8204:2171:b839%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 08:36:52 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc: card: Scan the eMMC boot areas for partition table
Thread-Topic: [PATCH] mmc: card: Scan the eMMC boot areas for partition table
Thread-Index: AQHbv1eFmGIX/DVh60WoLjnN3nQlFLPbRPWA
Date: Tue, 20 May 2025 08:36:52 +0000
Message-ID:
 <PH7PR16MB61963BD3A3CDEB4F9D982BDEE59FA@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250507134538.575912-1-loic.poulain@oss.qualcomm.com>
In-Reply-To: <20250507134538.575912-1-loic.poulain@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|DS0PR16MB5389:EE_
x-ms-office365-filtering-correlation-id: 8fa101b0-faca-4f13-0173-08dd9779789f
x-ms-exchange-atpmessageproperties: SA
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Kod4ko1huSpa9WaoYokHQxYxHCocrt2vvdNjWiPrI5XrNFy3UV/x3SdI2+aR?=
 =?us-ascii?Q?1paWWcSgXu3DSKT8tO142zSxUtAKwTW/qR3p1sN5Q50xgafJKCKM7Ar66JmX?=
 =?us-ascii?Q?FBByUn+5R30/WKC0K6lCnp0KZDB2zaFQLi2bs4lx8i5Ao6mQ820Uuq+iBwcy?=
 =?us-ascii?Q?UqhJO/rM5vQfMM1VbpaFs9XcZ/nxqOEVZEyKgj355f95ZbtLK1Dh8RcXDWeK?=
 =?us-ascii?Q?AMFB0g/rJzKhXg0AX+Y4m6tVaKv/FwGqKh4c5BDnGHWo+pnTKFzcyhyFbeR+?=
 =?us-ascii?Q?tfT2yWphCp5GtQtlQCLht2X+sPjj8iKR9jzzSIqaDM9E5EAF6TcQtvEDIc0j?=
 =?us-ascii?Q?Ie6XVu7TUqOw3mwW9UfF5cKaVz1rMjf8Pa2zrI/7EuTLoq49VAndqQVUROil?=
 =?us-ascii?Q?AZe6j7AxK2c2+vxMqcSSTTTFCQqvTUdo7keFffk7cq/U9DnsUQvPskirYErp?=
 =?us-ascii?Q?lsvzvcbqnvKAP/2G9usuoCL/Esh+mWoXBhB/M+OoSlziTPXx8OKicgjOjDio?=
 =?us-ascii?Q?Nw5lDbm/x/OzNiHq0MTGwtgCg8kvS7uC5lHY3V6VwRbFUGjE1NmaINncs2Sj?=
 =?us-ascii?Q?vzdm6KiQq2X8WLpvvLrXcZenYgr8bGFwqsycXC+QlESiEaHecghMusKma1I/?=
 =?us-ascii?Q?rDHJZdETDvYbr9ceRm1Rn3+BUm8aPM/9lAM8wjhOMGJApx7x2EoSUdXC4UOJ?=
 =?us-ascii?Q?eWlADDsR1HI3bf7syYh2/ufZXsPHqGH7YuZmbAnovBED2sonUkBr8yKsED7n?=
 =?us-ascii?Q?JXl0zMgTHzhBqom1WkQsFsMQxhnlvhdOCfpcgD0r1B/cmtMyFGPkxZ0IObz5?=
 =?us-ascii?Q?JfuBnfSGik/4ywRDC0CfSUNLihov74OxXeG25oJObecUDfALcBEhDZA1YuaA?=
 =?us-ascii?Q?zeIHz9CbgDicNnmCD3qOaASL853VtObxoqcL0+rQxU7R5XY7fES3VLjd6MEj?=
 =?us-ascii?Q?I+70HG0G0FJ/DJw2MgsvUzitr2foGtMnlDxvgKSMFziQHlmPSuhjHgaon9SY?=
 =?us-ascii?Q?pexRahGBGTbGvoMeRwsy+veJLNr1u/elbeWn6tDuVmNXjJECmRWFkuOiFs10?=
 =?us-ascii?Q?gnF8zrsRA9Uk1rFhVrIuCf97ORWy9iaLxvEsYQW1w6WGaieCXdvGUShzDjcO?=
 =?us-ascii?Q?CwLvZQdSp55dCBOXgM7g67yb85Rd1HEtldMLpUXXAZTnJ3oAckxsDjNbPNlc?=
 =?us-ascii?Q?2OIhfK2uMU3NambnvWNF4cxt6W6MVwyi6I1Ej2R4XPD+XeYxnI3F+GD48C01?=
 =?us-ascii?Q?0SsaktoO1y1hp/Vc5pEJn6k2ScsStJhsLqRWb5UPZy3oMhNDfMz/NiWwTIRJ?=
 =?us-ascii?Q?0C6p8XScTZoC5kiCYURNr0ENj8AzZDSlvzsAB4BbygKlGEMVeZl8UcO+Nagu?=
 =?us-ascii?Q?2HLDvaXg05QvYyNgV0avi0ZyQ+f3QbPkNM1wTRTk66NMQupuaP5S+HFdSOnS?=
 =?us-ascii?Q?XDA/XVJiYav4tcSi+9ESqCoTwTX1v0cUDI2fNaUQM4f5Ey9uK8/zlw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?C0LzecAyfArUoHhm7jec+X9HnPjKqH1+f70q349FYfTWvchST4yrXe/U//01?=
 =?us-ascii?Q?o2Ty9v5MJ9sccKp/Bn327Pk4xgKzOZQpiQbL8XXNfrRNRRn6CiIlbfEbDvp8?=
 =?us-ascii?Q?pbyPLNIeHHIfqXRWSqRLo9f3ROqT4OtHp7JcsbzU8AurQDrHxcmFayzQBNT6?=
 =?us-ascii?Q?o6IzUcnqGX2R3V2zUa810hpSHqtj9gTViDn9OhaO0uLtJLuAg36IdoNqqJQj?=
 =?us-ascii?Q?lrKad7Nimf+XO5QjAMt4FyPNPi4pm6Vk82ewB7gfl9uAUed2f3NSlBeRT/K5?=
 =?us-ascii?Q?fVnVbk/wGdSj1NECFCPs3eVoBDZlEkMmCVMfM9T3r8p+lXnrmrWXbEOS3/qG?=
 =?us-ascii?Q?u9w9OlKbpRXhzUgLY4i1H/TfEJ91XI9Mi5QY0Sew/H4qBNjwdXh7qd9Won/2?=
 =?us-ascii?Q?NOczhuXrxDW2U13CRW/3VAq1USQ63h2teiyzIOCDlcSfY9Hc5nNY+oemOdFk?=
 =?us-ascii?Q?clwl/1Cv+vDZBfL7mMhllYrDk3cIFElFiTuxIqVyhCzGdkwfCIDKLnOgdnmC?=
 =?us-ascii?Q?gX3qM921/wgXQfKouzDbDIlBv8YCaXhjAaDW0KjTRDny1e0VGrgVGM3IbwOr?=
 =?us-ascii?Q?5WuDVdSLSGbiqrMP9pM7MUAs51l3PGYr1jYNRunXYlizvxslSuuYWsNSvxIP?=
 =?us-ascii?Q?dH/JaQzpDtQ3/7faTYci49hulyiusJDOPncOLVE93gwZzvWD4CI+zOyPuk/m?=
 =?us-ascii?Q?wGS5wfrXqM/LJ6c+yCOZn9ez5ooEOyR02nmgRfD6Mxmg7RjQXcDFozLO+1oA?=
 =?us-ascii?Q?+MrU4kjASv+b+K3jSV9jNnAP/17wYoULAUVSQoOgjFCeQgG28istP6+IfETT?=
 =?us-ascii?Q?MLsO1rV89BUvspOuU7xNrJsDfmTwbI9qG2US6qsHNyL/QV+c4STjKUbuq1zy?=
 =?us-ascii?Q?QkPtZT+vL8JFWeETWE0QVmFKlwf4eaZJZ9WyEM3I/Z5gCI1j384LwBg8uUzM?=
 =?us-ascii?Q?5JlWJa2qv0QUyv6jSjxS3iUOakzkq6Des3zP0kl7qXEtkyyFIvVL2fHXyazZ?=
 =?us-ascii?Q?L7X/btBJHgXpfSm8sbwcK6PdkEptGUeXvLVMUwrXr99OxshRBo4BJrGHrcPx?=
 =?us-ascii?Q?CpvwBmtfoVGQYqhnQ1zbqKElV401N3W85MBGD086a37MshalOS8rE9hiRl6d?=
 =?us-ascii?Q?mtArbdsOqLdfSoEEyIwixTqfpH8ORvTJ4vFSMo6n/r2QzjFWacKVpMtrwJJ9?=
 =?us-ascii?Q?qvrXJHfBz0uT9KfZ6VGmYyl9jflzlIxa9xe6XTs8oDnXFDwKYJ/XMQ9q1MNZ?=
 =?us-ascii?Q?BEvBo41L5SHSIU3LdqgEUNPM47P/wsFthCKeclXLCaZ/ztdv9tpeo0MFHCq/?=
 =?us-ascii?Q?WXIDTPH+PF0WiCDOdgTX9yd54h2m59vYINZmaZIIiMlduai5AjGw/jvtLE1e?=
 =?us-ascii?Q?fTM5QH0y+WaaEVAyqj7LdzCvSR9sgY4IDg5A6glZqNgxuH0bAycRiJ61OU2/?=
 =?us-ascii?Q?gaynRNHJKI9zWA4NsOARZgzmCp5WZ/UPDL6LpzwnHQlroAIVuZnLJ7W+sU51?=
 =?us-ascii?Q?w5/GaEi8NSEFwBgrieNvqS3xqyK7dNLlXKYWhElp1o4ZnG1ZjT/KAx0684bT?=
 =?us-ascii?Q?ovZ3xuUNIu3IHc/j8tsrH8J8OJ0G7Ajt/paIq92E?=
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
	5Dry3S5TNsLMP3A5+O43MPT+RDmhbx4XTJh0OCi+vKJ5Zb10EMLBHrJ1+lFBBWkgyONntrGs+CTH3a5m57Pcw8yCYtI6HyzOdstp5oR1zyG+Dv71ORJkQuXx+ad1pSdsOJ32N/ytG8r/Schdy6gq22Q1RA+CFUPxNaAN1pVwc3VaDPC6iFS4x0wXtyxAemWXDk4mmtszP/u2jYHRY3QlAYcK0OnMy1Gg2I6lOpeppxo4wSqP/vyupYCLQ54Q4agCKVfX1U9/Omn2SW0yP9M32HTS0D3mjFxiA8dzq5rvE376mlWAKd7hSf4fW/sb/4eVNJEq6Xp7CvEw1unYS8tm9bhXBrahgqL32JFezDrO1thx2sPYpqVontypAEMySGvp7duhNVru+/fC2mXI+bvSZHfc/e3o5dIEbkZ+lOK+YJYGGx/UXvJ5cSGFmKOYTn4PYuU7nBmQqu8D5LtTNmMDpudb7aCdLVgasLn3w3iTK3s1MYEjheOwGO0/Bi/sLZvucg59R3Ip0MtmDqFFaWK7IUZCBEGp4tu7iFSj49ANj8/sGhnaHvFS/Ez3a9ZlJh+VnqD5CHpVF83whuHSpi9Mo4RMS9jGfH7G0fQ1lZ+FNNFtZC917CrTYecENfx60r2l4bkYXuUDksjemi+ck9EVXg==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa101b0-faca-4f13-0173-08dd9779789f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 08:36:52.6731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/K2YWntqqc8pkh9asYrupMXAZ63Z+f5dDw6vwJGHg67TOgKDp1EP9ufExz9g9YruHyZVs+CSOROE5habjPKVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR16MB5389

> It appears that some vendors provision the boot areas with valid part
> tables (GPT) in order to have identifiable partitions for device and
> firmware specific data, such has the qualcomm CDT (Qualcomm Config
> Data Table). Additionally, these boot areas can be utilized to host
> device-specific IDs, calibration data, and other critical information.
>=20
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/mmc/core/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 4830628510e6..c81925194509 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2655,7 +2655,7 @@ static struct mmc_blk_data
> *mmc_blk_alloc_req(struct mmc_card *card,
>  	md->disk->private_data =3D md;
>  	md->parent =3D parent;
>  	set_disk_ro(md->disk, md->read_only || default_ro);
> -	if (area_type & (MMC_BLK_DATA_AREA_RPMB |
> MMC_BLK_DATA_AREA_BOOT))
> +	if (area_type & MMC_BLK_DATA_AREA_RPMB)
>  		md->disk->flags |=3D GENHD_FL_NO_PART;
Given that the boot area is now exposed to accidental overwrites,
Maybe add here a proper comment. Also even advise on boot wp options.

Thanks,
Avri

>=20
>  	/*
> --
> 2.34.1
>=20

