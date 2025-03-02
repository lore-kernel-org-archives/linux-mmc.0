Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAB21CAA99
	for <linux-mmc@vger.kernel.org>; Sun,  2 Mar 2025 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740900632; cv=fail; b=rjtZoT4Xb2SyKJXuwENh9B+g0vCP/O2fBjOJvUKqHeEChnK6+om1pL5fECDMfgFmAReTKWz/uwW0Svdmklm/q3Kl1poaiy0Br3EAGkFnQljhTR4ZkrlbOQQnm2dnC+d2bw1yVT7caxBumj0SNFZrXJtBH0iuTgyd9fd2Zh58b6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740900632; c=relaxed/simple;
	bh=wbUyBDDqjg3yJhyS2DCIzAgcBHSrlCMz7K2Uz69nZ/U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m48hSCw8/O+g+u7BsSztMves8LHguL4vnKizRM++b/8aygDvdfzzDNHbvJu6G2NF4Zb/pDgh28rNqSX2f3/ExxQJnLoxLB+fQiDFE3gGkjvImZIhjNwPNIb6DL1PYsF36fKSLdmDQQsmVOyhMtJkNVjANFMzUrYhl33pLsSzkXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=ZHgW85w9; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="ZHgW85w9"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1740900630; x=1772436630;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wbUyBDDqjg3yJhyS2DCIzAgcBHSrlCMz7K2Uz69nZ/U=;
  b=ZHgW85w9SwvvwqDTdtXf0MgFt6OkLYZ97TP9NMWC2b9saUaOZ8d55VSN
   cg3ieQzaQjBo1OFqnszyEmMkLe+0TvVTDR/+iIcGNgVEDKq1/zxNGtdCa
   G/3nxSePwIoCi8m1tJzHmgbY/+O3GAw6EWB1ad8TrGwGfSwBBtSz9Yh1A
   1Ogkzmbb65UTg9Pk3cxGBgmzvl4snD18sMuXy1CHui3GKSE3v+nOohJ0C
   94mIUe1gClb4axH7acrzUFS+vjLlBFLRtZDQyaQLsZL9MydaaMGgYqJs8
   0qzxhRvZwHAaiSjidhLsRQel5x2GmChxTCtBQ+qfHSB0XVTSnaeTr0zNg
   Q==;
X-CSE-ConnectionGUID: V06zHU3QRJ6eBHDHRIkXBw==
X-CSE-MsgGUID: xjqgAjThTde5uq0H4y8KFg==
X-IronPort-AV: E=Sophos;i="6.13,327,1732550400"; 
   d="scan'208";a="39687725"
Received: from mail-dm6nam10lp2047.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.47])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2025 15:30:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvnmGG3bXU211RMXjDb8IhhPBjefLrdtueGWLLmaXNUDGI+bBIA+nyLiQmfuVE+9OxEVaitZgu79szp9jCWV8n7wUjFgU/Z01/LlA9lwzTcW1AvfWe0Jsbj6PNpgoYLubqdAC7xqmecK4dIobbyAxYaPydSrMwfPpMThMwO4NqLcsJ9ffhqE4Icf6CNZNnBdyFwNvXD1K3dTikr3x1xOaDL2Dpl4X5SpXgdPBh7ud6LBwV8W+xlProV2KkcriXqbaobNNzVtU/hFsLb93hkpHMOkG5fx8KAK/kKsLu6DWlq/naLwDUYpXGjCro5G7UL5EfKiddv3ZYr+Q0VICc2zsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyGJS0gTwkjmmWgre0FEX6eL3EYJJVN7RjRpfVX1ReI=;
 b=JZKNKIy42TQW9Ia57VlcMTRMt1OEeJIUo8Gcap54loEUw3Muw/G888OElANiqaB4nC7bHT56evfnQuiYJdy0kNMSA2cvi5C2QZ4run4RDIdq/yxDKg+nX0GdlNydtY5SXcj62zlQbnjXL+6KgFlSqHFssglczQdIUN/zKvFTU9D2j2nA2xjVJFcUC5gTh1wGx5//t17vSbgBRQ/Sq79W88h9zBWWWCFFhzXL4z6bshLXkhRLK295mpQCmhZAxGxceUob/4U+8mx3PJ0GshBeB2XEX8CKf8Y9teVmmC/vbR4OnHmercuSKIsnJLhGDs61GDFwftm13EOxVJJTjKLxLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by SJ5PPF07863BA94.namprd16.prod.outlook.com (2603:10b6:a0f:fc02::ac6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Sun, 2 Mar
 2025 07:30:22 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::58f:b34c:373c:5c8d]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::58f:b34c:373c:5c8d%4]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 07:30:22 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Avri Altman <Avri.Altman@wdc.com>, Gwendal Grignou <gwendal@chromium.org>
CC: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v2] Makefile: fix conditional around sparse
Thread-Topic: [PATCH v2] Makefile: fix conditional around sparse
Thread-Index: AQHbdmEmGDUg5KwgXEylUK5K+oyhPrM12AAAgCnFBmA=
Date: Sun, 2 Mar 2025 07:30:22 +0000
Message-ID:
 <PH7PR16MB6196CFC58A088026217F7FC8E5CE2@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250203172905.463629-1-gwendal@chromium.org>
 <BL0PR04MB656432C4EEB1A9EC3C6BDC0DFCF52@BL0PR04MB6564.namprd04.prod.outlook.com>
In-Reply-To:
 <BL0PR04MB656432C4EEB1A9EC3C6BDC0DFCF52@BL0PR04MB6564.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|SJ5PPF07863BA94:EE_
x-ms-office365-filtering-correlation-id: d52c4816-17a1-4bbe-1000-08dd595c17b8
wdcipoutbound: EOP-TRUE
wdcip_bypass_spam_filter_specific_domain_inbound: TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lOEp2r6XtdmPFVKedIkvYeHnxHDGQH8JcfwtP7x4y6F67EGsTYCpKnh/wtNI?=
 =?us-ascii?Q?pzkQ5tfZuQcuRvkq1il57mZnRwjaqoXc5F39ep6f5VHWn39/P8LsAXkyJ5D7?=
 =?us-ascii?Q?Po4WOvb+smLVis1Oi9TKMjG5JT8oe3AOCtQGAdMyTW0Zas+FNHyJuilloDrk?=
 =?us-ascii?Q?2GpgSY3lu8fblQNMEpe1Ll+77F6EE0y+FJKzZEVrpbaZiLcQGSTlidyutuwj?=
 =?us-ascii?Q?uQ4fVS0knP2L7Z5PWUPb2czajULLnHy5GHI5lzpxIeuY6zNUEdFoDdcCh9+j?=
 =?us-ascii?Q?W2rWGD9gFcDzE7sTFcddGQVcf8B7BItQDevZF9SNj1A5hBpxJBr8Q2JWfsDT?=
 =?us-ascii?Q?xxVMLKWsCYfFnIaqqBLbdBi2oEk7rWQohoA2WoRobDttQlBJzI+neChjl4Vc?=
 =?us-ascii?Q?30rnlb8s+675lVzEsK8ao/vAXnDL+Ng0R6tymY6UNeXDjmHcgnblDLdbQBbb?=
 =?us-ascii?Q?EZKIJGOOhNFzOoi5N9pmXP1ErWKkNq+S9baKnC6jMIdwHbECvOXiJ5dCQXDZ?=
 =?us-ascii?Q?CiCzIUAjuK9OFWdPADcXvKlAWP84mB25dj/xMAoxTx8vENQ6D3Pif1EhF7ge?=
 =?us-ascii?Q?qhvfGHiUlbvVBcmZr9pixaAGdwi1hdWoNpf1zyPlynDUVh6r+EWt6za6X4+L?=
 =?us-ascii?Q?b8xjbaXF2qrQC68o2uiWK6bvWT3Ro0q8CQ0PXxb9/MmFtBbKxXmAMfMXuXg7?=
 =?us-ascii?Q?aoHUtqSv51PPuuKYc/BzGeSK+ArJ9d1T4tr6tPQNhG2sWlrTBeadgoqW03D/?=
 =?us-ascii?Q?pVMtCwq5RNnV5OOzXpTWZHEi/NHtzqozGbNbw6eSKSO3zU+fHb9SjdDnRMhQ?=
 =?us-ascii?Q?N0i+uzMNyEZU89nLIEQg/+4/lLY6sUw9OdBf6w4Ox1kwC9svAXy3hP1kdyIe?=
 =?us-ascii?Q?HKWOG8KC40+q4D+tjWoi72ziy2krJtw8l1udTxRPwx3+v9KT7pLEmIRoM6Yu?=
 =?us-ascii?Q?WxdKOHpi+cokG4V/WXBjOmJt6UOUC82pE3vA/z9mPB8EB7IbEdK1fzfpytbh?=
 =?us-ascii?Q?VXRVmCRyKViZ3MJIMI0Z28dS7tG+RwloiE3KpjxHYthP9DBN2MPKxwYGu1kt?=
 =?us-ascii?Q?HeU/fsPOucmNn39D3Yncc9nFZyHJtQbHsHbTirJ11QcksBth8K23EYpUAcSe?=
 =?us-ascii?Q?Ku6VbiclhQW5GCf4qRQhtovEmW/Dv9ToYd3Z89jtFEuVbIuZrUMsGXEUQ+wR?=
 =?us-ascii?Q?ysCKsfTjDcnnXUqGaLVkzT1Nh/L5I/2lbMGm+w4MA5lf3m856tnepmu8wZTu?=
 =?us-ascii?Q?dS3fnoiGptkDHr0LXH6Ih0pcdGjd3xFHGE7rkcxVj1dLFobX4ibqBnKMe67Y?=
 =?us-ascii?Q?gnylSPewYw4NCKrIVGTpSXZvEYftB+JO2jFIMzqSTMDOk8/AsCejJ3uVg/L9?=
 =?us-ascii?Q?4V/dBSIF75tgB+mG1mUkRQow42ErPmIo0jRlo74Sq/lIR71b2x5SHP/snOVP?=
 =?us-ascii?Q?i1wcI+5R6h9OolbR9A384NE9nxbyl3ee?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iRjB3AETaMTSf/PLQWA4Ek0M4Ha0NzpqK5DsJIuY6F1RiKOZnItJOj2HImw8?=
 =?us-ascii?Q?FvER9F4N6pJox8H6Aw4FueJqEfJu5J4tyr74WEfJcvLE/Zm7EAXuEBl+v93r?=
 =?us-ascii?Q?cX06Ib6nWJjqNa4Vo5woZgpa1vtWZ/EZHbpEF0wQjJEuCZVC6r0m93kz3Ihh?=
 =?us-ascii?Q?ptlD+zpEq/h+othaDgOuR7mlrxlgqEijQdTye7KVKjLvO69xi3/xwrorCo1+?=
 =?us-ascii?Q?KGD7XqDuEkcZ0xxgMz0TujKWvLuDHotc00SOpcEGh4B0P/SiPOsZ3U3Wmg8d?=
 =?us-ascii?Q?3Su8WIIje8kdj9lvoAhcLHg8ul9GRx+nHP24YUFVpt8jW8Ql/T/J4A34fr2u?=
 =?us-ascii?Q?8KND0Ypj+sKgGWDdWKzWKxt+OAqpT9j1TJiFtf7d5Gy8x/9gahXGW01FvRBn?=
 =?us-ascii?Q?9pwoqtnKsZsUxf2lawwzra6Xajc9uGLzu9ohhzxDnvXlGc1aSFnQUlDK7jhS?=
 =?us-ascii?Q?lO4nrt2Mp9R7g7IGeSsaYgzT6886wmf6T+JUuOpuTt+XPRw//n4eQw4lSWer?=
 =?us-ascii?Q?yDpQMThsg+df1T9GbVL8qKjvjsCxag+K7UrW2ZBbpQ/OWHWHCa5AC4bXOIzp?=
 =?us-ascii?Q?TQWEC6la6UqyU58Aa7U0RRX3N+6nkhcaVbSuPpYlbJQs28zQdXMbB29Ovo7o?=
 =?us-ascii?Q?bhWT4G3baC7d/vjNoPy3MarXZ/JQKmXFPp5gVV/FClzkhG/cESuT6yX5ioCn?=
 =?us-ascii?Q?z77eip2XdTnMP66w65GzP2hI48E+OosK23/rEpFR3FBNrxYH4mIldSuGHAM8?=
 =?us-ascii?Q?iUqM9/nOMDbdGVAtQfLnyLkdrfKjDgw+oFZDU7AUhY4OELO6FDMQT11ykErx?=
 =?us-ascii?Q?WN83CHoVdtRadVE5KvYC2HU1xLZAIdN0JuLIRHSQQUmSGLoSwBmkdKOXXtwy?=
 =?us-ascii?Q?0Ep5nb28PhDU0UCm7Zq5xbX2GfGc8BfOCTsS3FibtPTrCJ3eBWoDJGLUdUIu?=
 =?us-ascii?Q?EJWv1yccsLY1GbIGkby5Oro04QUVM+9baoMuRa0xQmO3FUV2T43w+KMV93zp?=
 =?us-ascii?Q?sUmigSLma+bZIPdswwFrQgePcVTs/1U5M40f1xW7HPvOpg9vmhJPF9D/gFhT?=
 =?us-ascii?Q?z9KXq2EcpD90eTqSdouUyD16uJHBQCO/GKwa1OvkcTtt1xlMKzFNJquZ3s5b?=
 =?us-ascii?Q?iRio1tb1BzlAyERZE/D1AxI1XHYShwy3IbtTuTClFpjWwmAR55PWjDVV6QsP?=
 =?us-ascii?Q?MpZTL4nGkwl+0OYpAZ6t8D1NbbNRalCqU//Os0uCKpiKSwMnUhPTr8pQkFYK?=
 =?us-ascii?Q?Ok7IJVSYOyVl6T07Vf4yJkV08HLxlfvPDIBKXRwp9Eig3iPZzw2w0C+rXTdV?=
 =?us-ascii?Q?Ol+XgFx3ktPZOdafpFzmO6lxhvuc5QtPz0kNbkbXVrVIQVjcNPfGgjxDMKJx?=
 =?us-ascii?Q?G8X79k/3DAn/p1HPfVcGmmh4fEJ2Kn1kKJRY2/HMHSxl7zQZfnsB36L2btF7?=
 =?us-ascii?Q?ETtXjeq6Zkd5yEFUsBZ4lMRaUCWBORzhomWiDRbox0Ppzq0bR0gxrhrkIhQq?=
 =?us-ascii?Q?1Gp//90LinJN4Bgk9A+zD4AGG/+BVofdWHfZuS8omZR8EpvN2TB7bnY3F9OT?=
 =?us-ascii?Q?Noq2MAVY2TYe9VOPgExqGTkZSjwNO2HefIVHcINB2baNz71K/yORiDoWwD+X?=
 =?us-ascii?Q?Vm0Hn21Nd4XzA+RknzX7OPCfQrCrbV9sL4ZuyicP1qEb?=
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
	PBFtS3S7G5HHXtBo0UBjbUL2qQHIolNaHLQPF+rlK+6VKETVSYCpqPufQJMUoZoPSEv61kK/xwYozSrsQK+jlWZ6PmdDEAmWrDkf0pS/kLYDZ7GhpnkrYq7a1qUvmry9yy+cKK9nXwPqqGyIlL60f6srln6zXwz7DsKyKRSKC1OYbEks3P5bsbFOxXpXnEMHujYTfbeat5xOc91jmA23g7vTR19M6+Dt2PovZBELKojHFDltIE8JtN4rf1ivNKjuWJsdxJ76iCpWnS3Oo2mRhlipNcj7vaky3O7n7XqPyNQcKzx/kMUOKfBYc9b9xlN9CFc/9XlkVHFYkEQe6kTyEf5lj9PzNIARMs+T8zoHwZjk0Fs6Egt/7qoeznF65GkZvEg7Pdf643DwSV4pdRjHI+a4amAXgOc/lVIqtT4VhSC64Zf9HRDAyfCpuiODQ3o4PT2re+W72LBx6L+XhwyBQnHYhmzRF0OYvn6afvkJ4c9SPwt6iCXD+Oy6Qh95+tYygEC39KHrW4WyDQ0WgM6beSsM4dZx0aMt1RtsH1+a79+nIQOJnlmqkLZoAy2Shx+s86vMaxUFuXkgYFTeWxVrSUUKL0rXJBYpFFjj3rGCBnNHIZk+oEnS1Lui4ZrB0aos
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d52c4816-17a1-4bbe-1000-08dd595c17b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2025 07:30:22.6003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iQ5M0mlMi0oO7s8HkcmsUQrMqQWN7V5mJg5i4UIzixRl24N1fqolhqJ5Vj/6OkrsDEVcH8qF+ruLypK8pGYnKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF07863BA94

Ping.

Thanks,
Avri

> > sparse would always be invoked, since `ifdef C` is always true afet `C =
?=3D xx`.
> > Instead, use ifeq to check if C is 0 or 1.
> >
> > Check that `make C=3D0` does not invoke sprase.
> >
> > Fixes f884bfe684f ("mmc-utils: Make functions static for local scope
> > enforcement")
> Nit sha1 should be 12 characters.
>=20
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>
>=20
> > ---
> > Changes from v1:
> > - added signature
> > - add test line to enphasize it is not a revert.
> >
> >  Makefile | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 06ae0f7..c0284bb 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -27,14 +27,14 @@ progs =3D mmc
> >
> >  # make C=3D1 to enable sparse - default  C ?=3D 1 -ifdef C
> > +ifeq "$(C)" "1"
> >         check =3D sparse $(CHECKFLAGS) $(AM_CFLAGS)  endif
> >
> >  all: $(progs)
> >
> >  .c.o:
> > -ifdef C
> > +ifeq "$(C)" "1"
> >         $(check) $<
> >  endif
> >         $(CC) $(CPPFLAGS) $(CFLAGS) $(DEPFLAGS) -c $< -o $@
> > --
> > 2.48.1.362.g079036d154-goog
>=20

