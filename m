Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56301331202;
	Wed, 29 Jul 2026 05:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785301899; cv=fail; b=Ga2WCd1jckwXLXJcDCaGLr7Wtrg3P9qcLAuGosnkWq5vAWv+2gQKhJ45CWVC7B5EhWte500J9VijizURM/RwgNHe3TjrIWqQ9BxGnLbInIpdD6A/5h/svD0O9j0JjdXBDubyQ/dP9x1rQCwUpeAr1oEk0Gmi0PEP/mma208eW8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785301899; c=relaxed/simple;
	bh=SPxt+4aa23mJ4VWoHU9Xuh/h3Ch5QCtXSe66mM4Bf+Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=INqPLU9Ld9rtyeRj1sjxlibhPAmAJGi+fcHmqd6f2wFWmd3q6JnWybCqRwGv8aFBiADDFGidnEizzdma5ETRx0gD2VqxKWjI4IMqU0g+wJtk2Iehi2Ge3jQ/sVbWTzt/Wkin7FpkvmTMFf7BEbdNL1BBvxdlFGnGqAfPA1qlgJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=lV4YXcqW; dkim=fail (0-bit key) header.d=cadence.com header.i=@cadence.com header.b=OovyGen5 reason="key not found in DNS"; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="lV4YXcqW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=cadence.com header.i=@cadence.com header.b="OovyGen5"
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T4afEC324651;
	Tue, 28 Jul 2026 22:05:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=79ALOO33l8lOkTAF8bSY/tSRHWXhIrEGE6azQ99JAMA=; b=lV4YXcqWWSMG
	MMYuksO1hVDkvmkjMJ9R9bLBrQz6p3xV85K+NS/e6OzitlZf2x9yLpenf52Nb16X
	X1S7z6UGefbC6HsO3LrsFhMVduWqLIoqKTQXlW2fLAAMPmUoKnDAYfsdcsYuJ7Lh
	6cUpCw+j1Si5UipCt0lLJUGzVs86fU0TBE5gUQWF2oRHafwfj2r4THJ67v1tkoc+
	A3DvTpH0q0uP2j0lAAlq17P2raZVSXg/9FZ9FFMVCfVevTq5pdUtG692wwR3eeEU
	m/s54V8cynAcxHa2CZ6HiYcViiMldXmodqNAYjWi8U/CoG1HzbeokQwdUeOnsTWn
	0CW9cF+org==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011053.outbound.protection.outlook.com [52.101.52.53])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 4fpewdag15-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 22:05:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+mMgo0Dd173OxeFtTP1/a6n1bViXpZ91EpZgQLCG91Bu0/kjEApi990nfXzQHLVOcn4nd51Btl+HwbChD+2UBmWsIU1nH8MbtVv4pDlZ/t4207VysoAGC6mhySh7s5DxmdmkflRhHZ2YI35k1x8fCnQubwUl6njk1Ho15ucmsUCUbDdBgzQmffwdHbiCyMDCos/ufEcVQEc3IjP25RPnTBxPEdPhA3/haCaGvHXWDAlPdF7ZJHeE9jHttxuD0CyuwH5gUJISw1/4BsuB+9ebgq1mM85Sm3YjMlIjF239WWiudh21V3lIslnHHBoRYmPav3fdz50N/agYi1yqWUFUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79ALOO33l8lOkTAF8bSY/tSRHWXhIrEGE6azQ99JAMA=;
 b=lmBfT/FCEV8JmelQwmI+xarfMhwlZd1vufeYZGsMt27r5xbtLEUm+XEc14AGuisYVaMc1lxpAMTzH4M6EVG/auYh06L2FGLsudbZs1aBO9RKK6kczi6S2ysdOKvWEkPQ0dRdqdENXCNVTQOKrapBCYtMeYL3htSZt36qCt8nmq25oOLNCy/XWYLGNczUFLhFBiyBozZdHGnpWjFKZta7dU5ZcSbIrqnPvFJuwVe6FCqsBOtwiteOr4v7LGiARsgoHD50TbjF/jKp3hyILklxPKvQw53eNrfxYqwhgocYG6CuuXN8CLdFOuz43tsLno8KmivG0IDqWcZ0acEJ/HP55A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79ALOO33l8lOkTAF8bSY/tSRHWXhIrEGE6azQ99JAMA=;
 b=OovyGen5my8E0F3lg/9h10Bk5BbrlfrnARBxzTyQjYRXGjWD2V1hj1JJpQPzAKeEjw0bFgJ2WY7+DWAkdI2SRZorZf8FxHq4o3xchEgB4lGjU41M0da88aHBYZgZi3Dr2Tpr1OSajqbWTPCrM5Ixi9cCDH6zP16qVWy9wPt3V33+UGqSm4dFJwSSXwVgYVOs6zwM5ogAxFcluW9y/TKsPz9S/LgIaRwqxyG2J+N5+cipjtBPFRT+NuVfYRdrhGOuR2Vy72XueRvYuuR3v8uJTpJ/340I0X5ygmmn8ImsHwGOk65pLTaZEHanEp9oqEB/Xud8h7Gu7FQFP2hWb04fUw==
Received: from CH3PR07MB10625.namprd07.prod.outlook.com (2603:10b6:610:21a::6)
 by BY1PR07MB10652.namprd07.prod.outlook.com (2603:10b6:a03:5c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 05:05:43 +0000
Received: from CH3PR07MB10625.namprd07.prod.outlook.com
 ([fe80::8704:27e3:9e5:e5a0]) by CH3PR07MB10625.namprd07.prod.outlook.com
 ([fe80::8704:27e3:9e5:e5a0%6]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 05:05:43 +0000
From: Rohan Santosh Joshi <rohan1sj@cadence.com>
To: Conor Dooley <conor@kernel.org>
CC: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Masahiro
 Yamada <yamada.masahiro@socionext.com>,
        Adrian Hunter
	<adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        Pawel
 Laszczak <pawell@cadence.com>,
        Swapnil Kashinath Jakhade
	<sjakhade@cadence.com>,
        Manikandan Karunakaran Pillai <mpillai@cadence.com>,
        "razb@mobileye.com" <razb@mobileye.com>
Subject: RE: [PATCH v3 1/2] dt-bindings: mmc: cdns,sdhci: Add CQE support
Thread-Topic: [PATCH v3 1/2] dt-bindings: mmc: cdns,sdhci: Add CQE support
Thread-Index: AQHdGcdf1urGZZY2iUagUGPYAgn807Z5vSIAgAo0nyA=
Date: Wed, 29 Jul 2026 05:05:43 +0000
Message-ID:
 <CH3PR07MB106257D01FBAA8310F90C02C58CCA2@CH3PR07MB10625.namprd07.prod.outlook.com>
References: <20260722-cdns_sdhci_cqe-support-v3-0-4412856a4488@cadence.com>
 <20260722-cdns_sdhci_cqe-support-v3-1-4412856a4488@cadence.com>
 <20260722-nursing-shrine-9e9196d96f14@spud>
In-Reply-To: <20260722-nursing-shrine-9e9196d96f14@spud>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR07MB10625:EE_|BY1PR07MB10652:EE_
x-ms-office365-filtering-correlation-id: 6fc72aa8-e6cf-4d1e-3626-08deed2f0afb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|38070700021|6133799003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 Tb9W4UhsWg5ZFN6WypMAEgXK30ppsqPzhDnj9yOdBX7ZQFSk9sLVnfzQDPECdYUQEIojIrblxJY+sdTZd0KsFTRj+S/tbl6FYPnBp4dIz6ZIvYuixTKncfric75HGbFzDxEoOMo53WyIuMIMDUkJwCweuDPojiRBwkoGi15Leb4+jRzscmEG9+46SmvorcvvJ+ePR5Gxq2ZU4KIdKY+o8e7aNEXbt1B2+/YMYUZT5R8Uld3KmXNXCbdkST5fxO0ZrHsVzF8K3+TSLn1jrvkXYhR9aqxsaxUzY1ZU6y93gxN46XUDrrueIubYIo1i7oYACIyi55mXXR+MMJRt5OwHmJCTQNSb0RAsxSHJVcVfgVv2CUIjqc6AVZ2q+QI1qZFtNcm9aJIn4cwO/ROCx2ddNZ0FAM/WEa15iMj/nUtFBCMsyqbmuRKfWLIPUcf2yXgmpG0dq/FwE48X8HP6lsvBzTHmywG+Vxgs+rnNX5Gl6vOiShSi9WnGZuvXCYcEVsoBn+vj7Gb/JiZ9n+HGZDQZQBlUlB7Bs019+vO+ZBo5FkkF1X1Ar/4kFIcedA24iVu6y3NCVrYq+Ssf7P3SZ1HJJSNro9kyki5RsJJOL/c+MC3r2saVyn73ysZc6iaD8pHwzCoVE/aQ8VOjiSlRzvv3vExLbBwTIk3WlG8zikrZbfNmUyWxyPIFzXKTq9gDP1sCreDiQQ7Fqvmd2Ks+//opDGf+3KP4AphgYog/Fo97+WM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR07MB10625.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(38070700021)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Q9yY/Qs5HeS9yD4xdKRvGuIPucV1q1LXtyckVwDQbokm82sMV3tvtttcY6nt?=
 =?us-ascii?Q?tkLvhe2047/gOMMB+RDpRkNngVtOvLHX2g/QRh7ySQCuFExm9VlpbAMlguqR?=
 =?us-ascii?Q?ucwe+WpfCpIWkxRzlaYsaudT8d5c7yzmXcXIIvkwDuXRa79+QW376UG5xkNP?=
 =?us-ascii?Q?5EZsfbqzXJfR0PGmVfeBJSpFNRuigJwSS4JGLS87aAxPCx5PCoMqbN1fJvmL?=
 =?us-ascii?Q?4pGIJ673juTsYNSPGyhLViuAFB4oVqf6Z71tQxsdoXFI08Oz+yKoWekm4b2U?=
 =?us-ascii?Q?ylqy8XiYVnxdYTadI5dLWo6CiSCZkcwJysw51ljCdTAbqatx4TrmDY0Nvddp?=
 =?us-ascii?Q?a47A258XtaydO5tufDp6ErebTOF/kjmC/qhmh58rwyMBfZGSEez0pWiGHXgC?=
 =?us-ascii?Q?VjQDQMYz3V8T9jZ8u84Is7wCIT6oJiWre/ebzAXgY8NwesGz6nVgatIJW4Nc?=
 =?us-ascii?Q?grbqcRy7Uy7YJUSmkleprhZ/xoRqwwZs+NMfZb0ujNHRk0jaoriYvm+Rwsc4?=
 =?us-ascii?Q?lNKUK8p3npzejqPnUyPjbU+YPp+1P2KncSVbO8jbpQVngqFnJTSAT3Ffn0UP?=
 =?us-ascii?Q?Bt43U1roaBej81t9dxH+VbMDc0SSMzWZQF3lroDh+qCNRvDu8N/bKM7V52GQ?=
 =?us-ascii?Q?29IWJFdMdVOF2dQxd7Ed0QKs/JhD21foxMe30JXO7Uy3ZRzdNnAv+oK2xhSm?=
 =?us-ascii?Q?jryW29zhOzyvs8bkURmJ1342jkAHiOHBR5H+pXe7gtO03wbsRwtdPg+W1Zfo?=
 =?us-ascii?Q?TjS0UmASt66PINEOq8bnZecbUFIQZTQSUZlxlTQYnZ8BR/4sR4tC6UlWVkXI?=
 =?us-ascii?Q?Le9xiARPze1vogXSp3wT7qvJEMTqR6eVipKoP+5EhIu9R0fB1Q6xgDkDWdbk?=
 =?us-ascii?Q?WCbaptHkHzR2OeTyt8eJkIP4yIaF1kwm4zSTnSU+5FzIzYRBgrkg1x5PufNy?=
 =?us-ascii?Q?yMo6ni7LtWv3xPt+pnOb+bFUi+3/beiLBR8+5QIWYv13Wb/a4eAmu3VryCy7?=
 =?us-ascii?Q?d1mvutN5nu3S+jqPMzD4avxhq919xSCvKsOn6WeAPovnnhIxA/8h/g1DRVos?=
 =?us-ascii?Q?BDbQisY4qjJKCNNtxfv0HyP7Kjccb5Lf4JELSJvgfxk7480KkypIHgIWIuC7?=
 =?us-ascii?Q?zlj3L3ie7x6BZHg+a/IZluHZoCczzLs9K98VzvubwBo+9ohYZwSqpGwjDRct?=
 =?us-ascii?Q?oagMbX0g6GggNw/Fhd97w8NIEWnAkL3tKuaKVCroaK7nSQhhKtEr/DSdn+Xu?=
 =?us-ascii?Q?9S681qE2RN1AQPgALMR5aii9oNqY6tP4HLzIMXorvu2iJE9SGjqIiBhNMLnH?=
 =?us-ascii?Q?KJ3VMM+t8rVY8Et9H6Fvv4mjebm1cMAwi5wA+G05Bik7LGAmOETPwbabTccc?=
 =?us-ascii?Q?SjPTo3orDJODbiG8kaVRy+B4iHsZ+CQ/2CFVUhZeiFChjVfiH+aN+vhneNWc?=
 =?us-ascii?Q?UwXQC7QhlyyuvntTR1bVkuKfQNcDF/WOBI6dHY+3ceSVzkq2o2ZwS3EQi9lr?=
 =?us-ascii?Q?k+Ff+kWpwG1tSMkXu9Nz0j7Mvx0ROGWhbH6I2U2OGPt8ObMgzgeyj7FlBMyR?=
 =?us-ascii?Q?d0jX5dF+SGsqyJ4O5gOpWU6NutzigqP70FVQfqq74oY3XwfbTDWMkig3e/Zh?=
 =?us-ascii?Q?SKtAxpJxo/9DVvW7yN+FWW7mztmzfui2QlglVQPUb5bhucaFmilrJUpAJwfR?=
 =?us-ascii?Q?9h1TwON23LU0LkOyewzTAjaEgw9K11zVeVUp5R1qsd1CQrf1h6h8DFVdbR2x?=
 =?us-ascii?Q?yoZuQ9DRwg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	k0uXNo5xTCQz6+rVsYQ/JYGl5ZI7c1Tnvp1x+dHzfTZ1uhaBSSw089DDvK6xF6Cj9UuDzTRDI+y9/GkUFAFtgi2nOFCS1DVcu0st7BuGyk/m47ZIaoQWXbt9g7jij+t4u690yAQEM9OIhWHjNFIN4xgYkjBBCja/IDbpKQp4zOqcvODT1Srdakwo8IEEpIUUql0nIC9p+PD9S/Un90LYYvBxz+RWoJMJEykDV6OjCm6WjmVDpxdSCgHC6PV8H3FkXA/mtlguBjuhMplGPy4LRI/dRlQM/A0gbu6XNHPph1ZUNWE0YJqWej41nD98qy1EUZr/NSy1Am9oZLFb14cGYA==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR07MB10625.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc72aa8-e6cf-4d1e-3626-08deed2f0afb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 05:05:43.6535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uXu/ynZa9LOkXO5ZD5t4nA2ZEGHzmq5VBKRd1gdNQtzlIvt6u45972M+kGdZ+053szTOrU4p97cqcEYirgAH++tTjzoPEdcrEJDua+d+5V8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR07MB10652
X-Proofpoint-GUID: eEq0jqNWG8tY6ka3reC91WMllHVFVtMM
X-Proofpoint-ORIG-GUID: eEq0jqNWG8tY6ka3reC91WMllHVFVtMM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDAzOCBTYWx0ZWRfX6UUbhmPsKNVo
 EAAT4yYVTpLIQIRON+lG2OVQkEwoVfV4QqzaAami7razB67GP2xT1HeehmxqjRq4ReGY2SM7aJH
 s2fag59TjTK+DE+BjSYgE82MS3zs9/3Hov/M7zQxtSznh8vkmnmMRgY6d4hLvpOGZg0pl3zor4d
 /huk2nBT7Qp8y2XD45lUHydO7XIIFNmiZtP4bO5DrIHJ91WilQx2sD2oxcsA6vuVV+DFejoYyDq
 MbwqkRJ4V6TV2KMqjmiXwuH6SuXnU6GOxDgdHJo+bwLdDaJTcPxiDO986KeJ/toTjWK9sNP63n6
 DoDOQHSDHyT0O2c6Jk7e9TMFbGgU3oAU8GBWdgn7bXZ7jz52/4bcSPlHRgk99B60ZiaKamhuEUo
 +NcukC2PDxnaXOv4moLtN9+pp83GDB0HeES0kON/cgBah/wNaXuU97Cuu2zpbgWQBl67eT4MP56
 ntSyhT5W7Xj6rGoJGEw==
X-Authority-Analysis: v=2.4 cv=avOCzyZV c=1 sm=1 tr=0 ts=6a698a2b cx=c_pps
 a=H9d2Io+6O/etw3jU54J+0Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=Zpq2whiEiuAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W8fx6O4W8wtO2w6lYej3:22 a=jPItpJ3sizTKmla2ehJN:22 a=VwQbUJbxAAAA:8
 a=Br2UW1UjAAAA:8 a=c-n4J4-pAAAA:8 a=QyXUC8HyAAAA:8 a=JvO64EORAAAA:8
 a=qgyFSXN0kY_tQLgaTNQA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
 a=Qz6KxWHdQ2_aS5WpiCfK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDAzOCBTYWx0ZWRfXwZWOGc9T/p9j
 XQbWo/D7iGkGyBJuAsXxkK3ib3aaVdx1vokdnSsdH0lkm9pAmPRvQmivbOdvfyRjEuV8bf5EjLI
 mFAYCEc6ELAbwPEuj1PbS4VvlO5vqYvk//3523S+eEm3ANhSgvE/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_02,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check
 score=0 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290038

Hi Conor,

Currently, there is no public domain information that confirms if the elba =
supports CQE.

In the last (v2) patch series, Krzysztof mentioned about why the Pensando E=
lba is NOT being modified/considered for the CQE.
The current implementation marks CQE as optional space and the related driv=
er can take the CQE or non-CQE path depending on whether the DT defines it.
Please refer to the cover letter for additional details on this.

Given the above information, can you please confirm if the next patch shoul=
d modify the elba or restrict the new reg entries to device compatibles?=20

Best Regards,
Rohan=20

-----Original Message-----
From: Conor Dooley <conor@kernel.org>=20
Sent: Wednesday, July 22, 2026 10:07 PM
To: Rohan Santosh Joshi <rohan1sj@cadence.com>
Cc: Ulf Hansson <ulfh@kernel.org>; Rob Herring <robh@kernel.org>; Krzysztof=
 Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Masahi=
ro Yamada <yamada.masahiro@socionext.com>; Adrian Hunter <adrian.hunter@int=
el.com>; linux-mmc@vger.kernel.org; devicetree@vger.kernel.org; linux-kerne=
l@vger.kernel.org; Milind Parab <mparab@cadence.com>; Pawel Laszczak <pawel=
l@cadence.com>; Swapnil Kashinath Jakhade <sjakhade@cadence.com>; Manikanda=
n Karunakaran Pillai <mpillai@cadence.com>; razb@mobileye.com
Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: cdns,sdhci: Add CQE support

EXTERNAL MAIL


On Wed, Jul 22, 2026 at 04:18:37PM +0530, Rohan Joshi via B4 Relay wrote:
> From: Rohan Joshi <rohan1sj@cadence.com>
>=20
> Cadence host controller can optionally support CQE.
> Add optional CQE register space to cdns sdhci bindings.
>=20
> Signed-off-by: Rohan Joshi <rohan1sj@cadence.com>
> ---
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml        | 28 ++++++++++++++++=
+++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Docu=
mentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index 6c7317d13aa6..10bc9ac2073a 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -22,7 +22,14 @@ properties:
> =20
>    reg:
>      minItems: 1
> -    maxItems: 2
> +    maxItems: 3
> +
> +  reg-names:
> +    minItems: 1
> +    items:
> +      - const: hc
> +      - enum: [bctl, cqhci]
> +      - const: cqhci
> =20
>    interrupts:
>      maxItems: 1
> @@ -131,13 +138,27 @@ allOf:
>      then:
>        properties:
>          reg:
> +          minItems: 2
>            items:
>              - description: Host controller registers
>              - description: Elba byte-lane enable register for writes
> +            - description: CQE (Command Queuing Engine) registers (optio=
nal)

I see no explanation in your commit message for why the elba is being
modified.

This new reg entry should be restricted to only the device-specific
compatibles that actually support it.

pw-bot: changes-requested

Thanks,
Conor.

> +        reg-names:
> +          minItems: 2
> +          items:
> +            - const: hc
> +            - const: bctl
> +            - const: cqhci
>      else:
>        properties:
>          reg:
> -          maxItems: 1
> +          items:
> +            - description: Host Controller registers
> +            - description: CQE (Command Queuing Engine) registers (optio=
nal)
> +        reg-names:
> +          items:
> +            - const: hc
> +            - const: cqhci
> =20
>  unevaluatedProperties: false
> =20
> @@ -145,7 +166,8 @@ examples:
>    - |
>      emmc: mmc@5a000000 {
>          compatible =3D "socionext,uniphier-sd4hc", "cdns,sd4hc";
> -        reg =3D <0x5a000000 0x400>;
> +        reg =3D <0x5a000000 0x400>, <0x5a000400 0x060>;
> +        reg-names =3D "hc", "cqhci";
>          interrupts =3D <0 78 4>;
>          clocks =3D <&clk 4>;
>          bus-width =3D <8>;
>=20
> --=20
> 2.43.0
>=20
>=20
