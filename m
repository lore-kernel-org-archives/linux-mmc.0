Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1F9C2FD
	for <linux-mmc@vger.kernel.org>; Sun,  9 Mar 2025 06:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741503154; cv=fail; b=qlqk7uOc479lw/3Ytvp2os0E24C20Tlgz0hWSVKA0NvsKmWB9pb/5VL2cp7mdVs7/80uZPK4zNXfsI7LjiPctesvVaLNdmMIbiOUMypo0hIgdsMVXacSxCWn9wLZYhaKqrUPpNy3frCSZWAcMVenOd3b2CUTuKpIxvlMh4G6+D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741503154; c=relaxed/simple;
	bh=1iQ9NlZQTfC6+NoKaSrFkCXtkZI1Qgi1OBpPJstw04U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BapbHWKamjgp3YnpErhcjlThlT0He1vYSw17D2E0vtzil736lJzXL0yZVquoDu1lpevcOHmeB4MT3lr6vrMfm3nSldgK5dxX24/S03jtQCo3hcuYv2i+pgZle+dR6LwDn8dloeruV1n2aFmCafSS95Nb0dN0tXCPSEimbLczqVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=1QB9PWb1; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="1QB9PWb1"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1741503152; x=1773039152;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1iQ9NlZQTfC6+NoKaSrFkCXtkZI1Qgi1OBpPJstw04U=;
  b=1QB9PWb159cdbzSXbl33Si4b7NOV3GyS6T3qzf8y8dzTNbfZroUH4eLd
   vhuINRl8fHffz7Hte04W+gdhMTZX+moyAFeeQyG5TCwRUoSovGGCPiz/r
   NPQ4v0AD1mdLIXRQRId+PBsfBbe1RiTLFkDICdOUKvkRS/A7zW0L9SQjm
   bIZKx232xutftNIX11BT7sx7u+AcQK7nmU3bBGgsHKasKhg8xFcvip3t2
   T2BvcLhmyJGT5Tg41jORyv/uVqTgQ3RkW3uKKujFWZZuomYyJsIrCwy5P
   8Kx1a7HIjzaqJG18k1ClRgaGzj72GCKBxtpoIVU9FiXbdle37V80+0YCx
   g==;
X-CSE-ConnectionGUID: WcNV0i8bTv6yZJA5lfWIhg==
X-CSE-MsgGUID: 0e9LXwgDSHmAYfpYw8xl+A==
X-IronPort-AV: E=Sophos;i="6.14,233,1736784000"; 
   d="scan'208";a="45443205"
Received: from mail-bn7nam10lp2041.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.41])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2025 14:52:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2P89mZW3gu7vAKOKQo7o5CwTj9RWYYbAqxEYTMBlG3mCQRyjmvFttRl8BXp9BMpXadE69m73A113s1HhLWIS+kIPcR3NNOTx8jqZ2ziXtrpVpg3WtrM9Jfk8PBWiwt35t2kniT1MwgMykmCvvl3jpJkAo7c11Cc7EsE7nyXACi6FEwOeCdHxR7dh8laKhmHxUf5oEhSysz8O0DN5pQBigrJPPTn5YVjDVJ+PuTqnOjC1GsIsy7NBzmhXxl99cQpDPYZplqai2QLgYzP05X3SvrCuWjR5UPQkA4yKtDvDgosemZAwnL2lt8VX8pd/pH+cAZfkx9k+hdOqYl46vMrWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbkzmRuyxE9OvzsYjr6VWod+F4s2Fmq/VBQs3RuS9NU=;
 b=VpMi7dVb65KoaA/4iS3J6sJBGPERKZpLpVNonQgZRSJOwhLUhE6SHZHAMLwkmRHTCOCT8wDEqN1W5UEkCMxxeyezf5St3xUfWrWuJ1+Tl22xbZWO58VGMwgexeE4tVKMd1Kg2GyAsPuXYMDz9eA6CINp5/o2zjUWCe5R88SMouvfGZdyeA47Z+CPAASkerbnMABMEU5U2BbjwRT12EceoNb4N0/O/mnTdcJ+SQtxxGXmseqHXL7NxYkmxy/XZjUZIKizOCNMHULRWCtiFkublexLRQV+FjZslYXsMRyOPjKS5heLJV2a1AffAaKAnNDYvF9PCEVZUjmlr87ZoIBIKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by SA6PR16MB6799.namprd16.prod.outlook.com (2603:10b6:806:40b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Sun, 9 Mar
 2025 06:52:29 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::58f:b34c:373c:5c8d]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::58f:b34c:373c:5c8d%4]) with mapi id 15.20.8511.025; Sun, 9 Mar 2025
 06:52:29 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Gwendal Grignou
	<gwendal@chromium.org>
Subject: RE: [PATCH v2] Makefile: fix conditional around sparse
Thread-Topic: [PATCH v2] Makefile: fix conditional around sparse
Thread-Index: AQHbdmEmGDUg5KwgXEylUK5K+oyhPrM12AAAgCnFBmCACvT5sA==
Date: Sun, 9 Mar 2025 06:52:28 +0000
Message-ID:
 <PH7PR16MB619611843B35AC242A83DFDDE5D72@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250203172905.463629-1-gwendal@chromium.org>
 <BL0PR04MB656432C4EEB1A9EC3C6BDC0DFCF52@BL0PR04MB6564.namprd04.prod.outlook.com>
 <PH7PR16MB6196CFC58A088026217F7FC8E5CE2@PH7PR16MB6196.namprd16.prod.outlook.com>
In-Reply-To:
 <PH7PR16MB6196CFC58A088026217F7FC8E5CE2@PH7PR16MB6196.namprd16.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|SA6PR16MB6799:EE_
x-ms-office365-filtering-correlation-id: db0106dc-1aea-4f64-c60c-08dd5ed6f573
wdcipoutbound: EOP-TRUE
wdcip_bypass_spam_filter_specific_domain_inbound: TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2PpsEodzBt2jB8e9l2SldfPBziqkcoi25BZmP+HkoPBna4t6s7rjvZ/z6n1j?=
 =?us-ascii?Q?YqLu+OGkFD4t3jVPDk1pt7ZDkPikUJpjsu00wZhfYzuq85dL3E4rBRdOX6G9?=
 =?us-ascii?Q?eq4+XxPD3YXxop27ho20LhDu3NkbM2qv66z3ju7YPLwYg5noknf0nCHt3QBl?=
 =?us-ascii?Q?zWMZKT5s841Cn9S4/cJDxGePv84MUnD6nOldyKmwb5jKCGy1oNOQPu8MmO32?=
 =?us-ascii?Q?GsADJ5Rnfmj21Bva2LK+KmcyYdgvdU3rH0EksUUGjgQqQsJrv6Ep022rK8A7?=
 =?us-ascii?Q?jIBCJ8CpEt+RKPHxjqU8nSNKUh1VgLLu6sQNn6g0eFx1fNHn/sdi2mjO2gZ5?=
 =?us-ascii?Q?fXjcdgCU4sCxWEHLDKmwulYePzAIhfqJ+W4MmS2ZPTEV4yIUqw/Q3M55oN2q?=
 =?us-ascii?Q?4Bfvbdi+Xa6BRvrX0KKpSjacmFGp0f1YvAWirOvUpxNIToSbTvDiCBzhsgMP?=
 =?us-ascii?Q?kj040PpE9U3EoXMzKrowzpvasZH99l3Q/AQRycvlUnMxM+akXP/kL1nDMstR?=
 =?us-ascii?Q?LOkIzXHS7hJdA3Mvk5W8XEsWdxVqslqz5WtCEHHNTKxtNOD1a09x75BDuJAS?=
 =?us-ascii?Q?pOh5PBXLlkAZdhcOlfSy+JBJEVmb8ko2twdLwex2IGvA4k+PYkNKNOhXi3q2?=
 =?us-ascii?Q?LteiHx7lb5gxuREyHFmXBHJ9Onup4TbIoY7ZfrTKWevaT07ewiKb4yUlgHWT?=
 =?us-ascii?Q?ge7EtR14ueZHE9xI1ey1g19Tq4XQUXXKrHjhjssHxx4t5gCDz2glVd/QOU0L?=
 =?us-ascii?Q?yKECX347Orhx+9gB4z9xUU/Dyt4mOGJZX67vnwBRR7xFp3yhGn/7nS5DYyfq?=
 =?us-ascii?Q?rvpNWxGBb5dhv6SWn8K6vpsVTD53/YbLeSg3yg7WGAKS41M+5nQS4ro/plEm?=
 =?us-ascii?Q?oo1oIyek5/vPO+Lpba4wYzeR8Ku55Cmgr4/eBdBqRpI2vfY+0SWvuyHgn0m2?=
 =?us-ascii?Q?rw3J8dHvTM071yg3q+wurkPFR5qtrAhfoXkO3x524kRWOkuSveAqEj3VdNpr?=
 =?us-ascii?Q?6KkYNzi7PtWnTuHJVxxz1Rp6kK6NuNsNq2Ry59H6cOkiaT3pbrpmrhHNB55e?=
 =?us-ascii?Q?v+TCXKdCF3Y6XaIZf7sw7jDAf3qUHXAV9XoMXjhvsPBez3jPrGT5t10Yp/Up?=
 =?us-ascii?Q?cr+r5jfpqjEPC1520nWBzTfh7hWxIAjFtxFh3Als0NKvUndB36Ml3x8wifPL?=
 =?us-ascii?Q?fAkel4XeS9olWS7dKoauAdr5WlMVWG7yUpjmcPVcsRUGOqelL4f2+37p//A2?=
 =?us-ascii?Q?7r9ddySobjbE1WLMwUn5f3Ox5Wtiu5VRCnCI0OhOlXrg4Ayxp5DUJudGMjsF?=
 =?us-ascii?Q?3Qkdmg0eulCh61EHEMkSxMh5PRoP2PzINXsd11YcK5ETIRVhLyDraSCZdFJd?=
 =?us-ascii?Q?JPn2naeDC2/VcEXA5WKjDY6EmPWMKXZIOhuGIV0dsj6t45Mp2P6ZytzySS5f?=
 =?us-ascii?Q?aSZ079f0UoySLA9yBcIYFFhZ0ygEvZ2E?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nkM1lUxReGIiKF09h8kJslz20O2vfv5QmrW5VCZKCP0EZZRH+hWZH8A4FcFQ?=
 =?us-ascii?Q?crysTsgbFAujw++oyuiRNDzr/B9oiVIXCnDFFv9gkDJi8a8pEsEXRpfmjg4v?=
 =?us-ascii?Q?C+pMKyywxY3KW7Gcd2ChS3Emoeta8jZv+XslK7I8Y3HbYsCPX8wpOkjSYxYg?=
 =?us-ascii?Q?NelzKCmbuioIt/BLtfpFCzFaczEl+5flqxL8YhLwUG+WN8/aA54oLOXRijcu?=
 =?us-ascii?Q?pq4bgyXW33/6g78hIfEKo6c+u5CqNeuVIBD/MVnpGtmvGBDW1thEfe1jL75e?=
 =?us-ascii?Q?IwcpT/FPPnta7Mkn4+Qh3ZYvfncqtYrCfObJYY++OqtlvdFXyeryV7qNNGzf?=
 =?us-ascii?Q?vm5ERXaI1+8GMoqxmJkmViiImUtWrBthQFo6upHsvTfQ1kurOm4cQPhXkeHS?=
 =?us-ascii?Q?OOymE1UtxwO38h+Xrtxfw/elIPhku+Uo4C2CdfFtP5EAqWEZ5X6Ml7TCg7AP?=
 =?us-ascii?Q?35tDuOQgxCIihUcSEOfd49/ZvuJ1s9jKk2q4Hua0ktN1wN3hIOVZdtIPkftg?=
 =?us-ascii?Q?RHa6i1vN7OxqAFdes1i+fdxAE+88RuZLfvc6DieUbiBBZPFiJdffUK5qz2Ih?=
 =?us-ascii?Q?LHQhg7lz1rGVi4emQ2TBZvKmvTChKEs0apMqhIpq0rJn/bnIomh7jMepVPLT?=
 =?us-ascii?Q?fyuHrjYeW3R7Tknnn46nP/ayTI59l+xyDrp94lxc6+ZFaufD3xkeF6X77TWw?=
 =?us-ascii?Q?xbm7eNJvYU5rbt2dSz1mJNQe2H8QB5eiWMBjvdMzyzfEjKtT8ZlU0OMReyI9?=
 =?us-ascii?Q?6mVIUjzNDN0lzQFFP/OEClB4PFuFROB5g+h9xJGNG7iUlmV6xFTpsZa5miov?=
 =?us-ascii?Q?lc8xhqhicMoyo0tURv83y/d3sSMOgzQbWVmP6m4Wj6XCQ4LZvhX6X4sQXFFK?=
 =?us-ascii?Q?R/7Pxjx5OldUP3BF7fWC3TDiLokhcGA4MrjIWlupS5qZtvDnEGfbut/8v9KS?=
 =?us-ascii?Q?WaMx61FUHUlG+XfWONaCxIUoViysO2EsucH1n1hohCd+cULuQX4Qf63Isrf/?=
 =?us-ascii?Q?oCqxM/gQiy8x0sxTXa3lJ8/aN0qUVu7hGMAntzU4w2db4cs7Y+JX/Islxqn+?=
 =?us-ascii?Q?b6aO1He8IHn/WtHIaEEhqlkPHLDOkNvCZsmDZw75Y36+W7rVqhJbRhelstAu?=
 =?us-ascii?Q?QAC4wlbk0ZwX1hkm027eYW8/BRUYOcEXI/h1lyRkml2GfVdWhNCT0G2uma6T?=
 =?us-ascii?Q?3th9msFpZXp446gXOWTnkdIDknGiHsi+wKer1jy4RV0KttkoDi76w7tr0Wtv?=
 =?us-ascii?Q?hu7WOlFnvxHaNj3TJtFA459U4Otq3uNhXGyjeN7Ydye+IcZfFOriCnetRZiv?=
 =?us-ascii?Q?01NSrpd7JYiMP808kUWRQ/+sEoCJol8XUp5pFWJS9Ta7jNTTu/jh+IIRl4BO?=
 =?us-ascii?Q?iq9F6so61eP79A+dQLrawqeGxEEpZq1bRMHZUzg4zwsEN8rtfeaAiJ9fTjQH?=
 =?us-ascii?Q?MF0zGjHqHVq1q8wZbbu37hoU6N4tD4C357G9HuhwzTLPSfYyyZoF3q6JQrMU?=
 =?us-ascii?Q?5IeLg6bNNbGyewoDvDzFWe/CMooxQ6TzSCkCPqYI78iZew9tlMZRhQkInCf0?=
 =?us-ascii?Q?UHxesF7UlLmt61/J7irCraVymKLu+rflzNGbo9Aiwmczb0LpgaqGX1htxrMw?=
 =?us-ascii?Q?Tf2HY5bYi16Gzuh+PleDMJX9KP+RrLxqRwFJDJE3nmmo?=
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
	nMNH0FYiGlgFv/Bn2yRJiVq/bwgFUiuvYyMVE/LI0a/onItkna0JwY1uDW2+Lbgqg1VJ0q9NbMlU5pscSerZPApyhGGQjxp1IyNRrCvhvbmz68EwyGtIJyjwk2h4z9wgKQmtd1kUplsr8YKe6qxuB+VrYhQcz5lftGj8lNoUxXq/vm2FciF2u2e4IN0BWwUfVpR2GYIlYDBxOYhlJy4TJMhZKaP5sH86Itec4LalMzmZQ22VOEedx4NmldpVKnXhQ2ZEfGtCIyZo30h595TnMn/UoiBj6jWBIsBiR3MrzQZ1V/wY2PGQG0B2tIm+WHjxDAK2aTvagxQ2fUnpBKqpjQMG129Q5aF+CahOjM7PVIUa57HEnLS63TuqBIblQwdcMuyGFW914s1jzUx6kzYNuzx0YBvY8YxgBjYhnFxYVvBkw/Lx8DeF36B23AOHr9L6RAk4kT8EH+1UivN3RK9zIeiPq0llhOv3qD88QnjHgo6m8ZeURQjwq7OFsxVD+Wi5IHJicRxi6Kd9KBLy1gBcWs2ZGKMeBZfmCTc8MTX6u4Z30dDLuHLwIxrWAxFNHQam82McVZ6tIIcOlMcw+Szo5VDM791ZdYTVaeiyu1YHIgqtQcms9ZCjRqavLekFoHCa
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db0106dc-1aea-4f64-c60c-08dd5ed6f573
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2025 06:52:29.0116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nKcT2uxR/Cv7Lo/nXXQwxuQ1KvdyNEqi4Zn3rvGawRvqSW1rIQnnLmzeEazb8ZznlMNC7JJxRd/Vkt87veeUuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR16MB6799

=20
> Ping.
And a second one.

Ulf, there are couple of fixes waiting to be pulled.
Those are blocking some new stuff waiting for a while.
Would appreciate your help.

Thanks,
Avri

>=20
> Thanks,
> Avri
>=20
> > > sparse would always be invoked, since `ifdef C` is always true afet `=
C ?=3D xx`.
> > > Instead, use ifeq to check if C is 0 or 1.
> > >
> > > Check that `make C=3D0` does not invoke sprase.
> > >
> > > Fixes f884bfe684f ("mmc-utils: Make functions static for local scope
> > > enforcement")
> > Nit sha1 should be 12 characters.
> >
> > >
> > > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > Reviewed-by: Avri Altman <avri.altman@wdc.com>
> >
> > > ---
> > > Changes from v1:
> > > - added signature
> > > - add test line to enphasize it is not a revert.
> > >
> > >  Makefile | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index 06ae0f7..c0284bb 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -27,14 +27,14 @@ progs =3D mmc
> > >
> > >  # make C=3D1 to enable sparse - default  C ?=3D 1 -ifdef C
> > > +ifeq "$(C)" "1"
> > >         check =3D sparse $(CHECKFLAGS) $(AM_CFLAGS)  endif
> > >
> > >  all: $(progs)
> > >
> > >  .c.o:
> > > -ifdef C
> > > +ifeq "$(C)" "1"
> > >         $(check) $<
> > >  endif
> > >         $(CC) $(CPPFLAGS) $(CFLAGS) $(DEPFLAGS) -c $< -o $@
> > > --
> > > 2.48.1.362.g079036d154-goog
> >

