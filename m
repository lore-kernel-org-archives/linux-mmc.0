Received: from esa.hc188666.iphmx.com (esa.hc188666.iphmx.com [68.232.145.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BAF17BA3
	for <linux-mmc@vger.kernel.org>; Fri,  3 Jan 2025 08:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.145.191
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735893197; cv=fail; b=VZmNs4Rp9xbAVIefO1em+ytvB+zCVmsCgT7KprranfOS9+lQNOCifQaOeZEFDgIwVqWW79HEFdmnu5czweNR/AY+hg7qm6sdsnNPywOH8Q2XgMU13qCUnGseFBbh/QNLes5Y62zt2b2Wkmcn1JlEuAZEbb9UBbHzyOsYRLRvUV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735893197; c=relaxed/simple;
	bh=Ea9hKJY7vOJ5dCyDsMfUncNOxzRLZuMNuKX6ti2fXlI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U3IgogKiJFGzjTl7mg6FKfvxg3YdMVgdvSd2o+ucuimmnYGzvJEbWQaoaCTOvKK929lG3+akxz41fgNHACBk2KKRr6VpSVotL7yAuh97y+N6vQ+cd649ExHnBnKI7xiQxqs+kTpdUSNM1fOCUPFMSbwV34yFRG4oPGV56LlodLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=conduent.com; spf=pass smtp.mailfrom=conduent.com; dkim=pass (2048-bit key) header.d=conduent.com header.i=@conduent.com header.b=KiSfwN12; dkim=pass (1024-bit key) header.d=conduent.com header.i=@conduent.com header.b=RuelTsr7; arc=fail smtp.client-ip=68.232.145.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=conduent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=conduent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=conduent.com header.i=@conduent.com header.b="KiSfwN12";
	dkim=pass (1024-bit key) header.d=conduent.com header.i=@conduent.com header.b="RuelTsr7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=conduent.com; i=@conduent.com; q=dns/txt; s=sept2021;
  t=1735893194; x=1767429194;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ea9hKJY7vOJ5dCyDsMfUncNOxzRLZuMNuKX6ti2fXlI=;
  b=KiSfwN12exJR0EM8oIcylxWy+zfv4nBg9gyZQ5wcLOE3Qz6k2vtm/64k
   T4Wh36dgHppa6wGd5PNCTeKI/FNc/QnK4NSigYAf7UCAPcrawZkv+mi40
   Q7gwwz9Q2tKMtAjQFLDmBX6Lh8SlgvccbxCpdkFzmrGYXHTiegs070/Jn
   KwQdNIUVF2D/tjzDOb7/B/Hy88hPtJmQven3e07Zq2bW8W/ss1jfi+UlH
   4F81WRrgTfytrq97Xh0ntLQ5aNKudeTvAD7nNlMrx7z8Oe/GFvpCazCAx
   pjdtwqTGgimbHlFtYinI5GR6SU2ilLc3cu3jaS2ktYocVaC136y4Hw3YI
   Q==;
X-CSE-ConnectionGUID: ejqzzQ9NQu25WC23Ba/XoQ==
X-CSE-MsgGUID: nWDDmnFzTWmMP8XbfIpzLg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.12,286,1728964800"; 
   d="scan'208";a="99170072"
Received: from mail-francecentralazlp17011024.outbound.protection.outlook.com (HELO PAUP264CU001.outbound.protection.outlook.com) ([40.93.76.24])
  by ob1.hc188666.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 03:33:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=il9qEQD2fERmI7tMMzcG/3eJf9AN263X3clFd6wo/wupZw4wNtuznOexVk6TbK7NdbIOIpRAOpwLjorxSVsX8PLUuZxpJZEm56Y3ltgnSt7tzoBnAyJcKUniRm+UYsJONerziYtPWEdm5K/8FqqGq5rhHEPOjzBWx2oiBilPsFycTMowtFVHWC11SmcHE+UUXuVJeOGGK3/eXJLmo26MBUUQTR4XUdh+ahnT3/8FUorMl8K7JeehoIa3yUIskZ0prUbLW6TGzQfLeEKyg0/uVmPgekIj4FvRpQo1sdUDdTeVxbRYrD5Ll/8a2nAmNwQuRhapx4ja1oeQOYY18+qsTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ea9hKJY7vOJ5dCyDsMfUncNOxzRLZuMNuKX6ti2fXlI=;
 b=wLCo4hPJqC14dxmGKjzaevaQvPS8phT9M9K2lSHRb7gosk1bcAJg5hTd5nowJ7yy88dViUswRp2wmrld+DVYYzheoGorJJXbm1OOA1SDEL4x8k9XPTb38wwdMGPP6kkPOKLyKQfixr72uyZr18z2iikifZzjwfypJVZDmlcgL5RyfY9kqEJ1ur4ZiVy1lUPs3RokXan4XtqlhQcQqlnER7CqUFCAvEsiB8aDpl+U7Ya6rJR2npg7n/60keynhxuMoUgA7ncW5oDvRMP507afRjjMWBsXjNdzvAI7ufJZC09KVkxfatvi9ut73yzSLRq93NWDIzPM+ZXbYhvpvR/aUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=conduent.com; dmarc=pass action=none header.from=conduent.com;
 dkim=pass header.d=conduent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=conduent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ea9hKJY7vOJ5dCyDsMfUncNOxzRLZuMNuKX6ti2fXlI=;
 b=RuelTsr7bLasHY+xnFKCtnEKm0yMK1f73+5FcHpg2nTx+KTdZNvDBrF7Sr2yGj3lEH669c9mHIhK3k0X6L82AJeHYGnyb2EkWDlGMUmPOSPfTjbxY47OkubMKh2IILjYHo/QdYPOOfwhXIlFSIGXBI0bg1zbCvgfGpaL3XuKSws=
Received: from PAYP264MB3440.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11c::12)
 by PASP264MB5314.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:439::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 08:32:59 +0000
Received: from PAYP264MB3440.FRAP264.PROD.OUTLOOK.COM
 ([fe80::dcdb:eb6d:38ef:853a]) by PAYP264MB3440.FRAP264.PROD.OUTLOOK.COM
 ([fe80::dcdb:eb6d:38ef:853a%6]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 08:32:59 +0000
From: "Torrelli, Maxime" <Maxime.Torrelli@conduent.com>
To: Christian Loehle <christian.loehle@arm.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: "Bove, Frederic" <Frederic.Bove@conduent.com>
Subject: Re: [External] - Re: [eMMC] - Partition on eMMC boot block device is
 not visible anymore in kernel v6.1.53 and above
Thread-Topic: [External] - Re: [eMMC] - Partition on eMMC boot block device is
 not visible anymore in kernel v6.1.53 and above
Thread-Index: AQHbXOpMPxhaTZEN9EGrb5ULucOC4rMDb6+AgAA3g3Q=
Date: Fri, 3 Jan 2025 08:32:59 +0000
Message-ID:
 <PAYP264MB3440ED2CBF0CF70DE532B02495142@PAYP264MB3440.FRAP264.PROD.OUTLOOK.COM>
References:
 <PAYP264MB3440EA9BD04E467466A0DAE495142@PAYP264MB3440.FRAP264.PROD.OUTLOOK.COM>
 <191d74ae-aefb-42fa-b96e-1904bfc4b329@arm.com>
In-Reply-To: <191d74ae-aefb-42fa-b96e-1904bfc4b329@arm.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
undefined: 4488684
composetype: reply
drawingcanvaselements: []
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=conduent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAYP264MB3440:EE_|PASP264MB5314:EE_
x-ms-office365-filtering-correlation-id: e81b9bcd-6890-48cc-bc5b-08dd2bd13af2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?dEfpYerJmJ49W1d/ysyD+0+Em29cMwke9nQk9WdwaNAlXLr9kVyjXwkVJ4?=
 =?iso-8859-1?Q?hEHkOaL9MAHopqLwSPTF4OfSgRnBl6hkaHMg08FX+FX5jEUPxMoUkxM3lB?=
 =?iso-8859-1?Q?1mt1yY9mEdXATVlO6HZsc3mq9EozNStIVNZrc/0GUpn0eikO+HP8IHcT32?=
 =?iso-8859-1?Q?YAoTFzTXv4AtXg1dPLC/Dxx0aUqBvfkYNtKGK+G/kngDgZeiMcbEgHOVtO?=
 =?iso-8859-1?Q?DrBypjXoAkOzu2p2/UGShHiCJX9uVLyfWWAXgyaFJ3+eBzBTZxu0YU1G73?=
 =?iso-8859-1?Q?4FOqdgzAcBaKJimLhr6dGDx/061QA1c2mJWUF/SZCSdw7EGqJHJXJeixUS?=
 =?iso-8859-1?Q?qkBAlPQt9Eo+DlZmr9mFW2+a4YbAlMxdZHIv2Uw/vxqAj8XRl9YMvZYN2m?=
 =?iso-8859-1?Q?2ZeUnC6c7Gj6BclVyFUeUtqhtbBvfNBVa0uS/HEYvTPipFgxe46qXYWq4f?=
 =?iso-8859-1?Q?smI6hKn4VYOUdVH2VandljLVNlPS1mOFMUma/vUMRN1OEDD0MJXT0jwPL/?=
 =?iso-8859-1?Q?aKwSH755PHJwKsqS08djQvEeIZ83uph+d4HoXBbD84TOkrZLFvd79xqJPl?=
 =?iso-8859-1?Q?ElkJTwe30X3sgynhD+LEVQ/Jf53FuN3OOLaKeQhBv/j7YMGSv2yrTzZ7z2?=
 =?iso-8859-1?Q?uo/Hs4KceWm5H5D+46hmEJIqJYx62cxBIl3xQCpqr2wbxpcf5epmFPu9Mv?=
 =?iso-8859-1?Q?Rde1LPaSHThO7Ndx5xuMUoHij+/GUxw/P/18iRWnI/ZaZHWYmTrcs5z77q?=
 =?iso-8859-1?Q?9fCQEzBdJisjntkWeCCVv8yx0YzZx5GLd1Xeuiqm76PiRlJkNqB+g/BU3S?=
 =?iso-8859-1?Q?LL0s3ZyZK4NBJFWLpH4Jkgx0WgU8ffdyWxEdEFoshJ+6sOlpO+V76871TT?=
 =?iso-8859-1?Q?vNXRQZpJiGh+v8sgWnXT8bRc/s5MgiRi+4Q2Mg09SKQQ9gBi6TPUcCmnQK?=
 =?iso-8859-1?Q?mh25G/ZYobC+pksTzUJQHdAJlqzVDew2YHhkRzYkTmyOwqglu911HMCxA6?=
 =?iso-8859-1?Q?8N4PYsokAQ1Bg6EvO0RUHQ9l2NEgPdxOBDTBecqJCwqKKa+flXIb2QmeIr?=
 =?iso-8859-1?Q?bx/CWqeZ+Gx+cepiwm3TjqZM2sqcxlz8/wKIGKD8ZQuIBWDCrUwj41iKVp?=
 =?iso-8859-1?Q?C9lksk6/in575HMwEHLJ50tonyyHE9+rk3rl3/FKXVgqbz8lpqiFTT48EB?=
 =?iso-8859-1?Q?yeopdDCe/otG7lyUZlvHQ9tW0+UndbO2P9A/8qznAdri5RhzfIkilXf08g?=
 =?iso-8859-1?Q?EGhBRHXFXq4YBm0RqtCXJG2d3YQunTsklN3NxkqzzzQe/Dk9eZGaA8avbo?=
 =?iso-8859-1?Q?Vo5Kk7Jy2d5si9oQoqCGvqbMRCS7nDsBNBVP3XyVjFhBAnrMZEBoRvsmbn?=
 =?iso-8859-1?Q?pnBf7mieeC91aWwBGGuqQ+OBbQVTyFOWI6762YX5kA1GQKkQOO0jovtPUg?=
 =?iso-8859-1?Q?oH9n5eerr0c6TSTGRJjvnjqxyPh7qz0cbqfRkW+jA8mXgljUXDw+rB1d/5?=
 =?iso-8859-1?Q?hYZ1Y0/OttYwYpLoRXECO9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3440.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?kbpXEwHvg/7hewc706HCJjiBqx5iNgD97mQTDP0jqL+OACKJqU4sRcsc6w?=
 =?iso-8859-1?Q?Ps7Ljj3DsGH8XLGai3fD7aCt/ANUYAbugLQMjSJ7vi9jOr6chW6V2xgAqh?=
 =?iso-8859-1?Q?psN1mi++a03QW+oKeT0RZ80IcckSEPXuZS6WKyTMbmQOb24wQDXbpTmwPh?=
 =?iso-8859-1?Q?yWLSTIhABNg83lqjC7yoqP8j7ryj3vUCZp+rY62+/5oCdAPkZE5BbzHlnL?=
 =?iso-8859-1?Q?xFawgEYMDq2YU+YkSNvicY1WII0xjsyVi++d+uGEcFJhJ4+2s9HkhXM6X8?=
 =?iso-8859-1?Q?cCU40Qpzd1+XycvSl7RGwKLbRJeN1WNBmlMOSxDxYKKvFDG9sKn80MQNSu?=
 =?iso-8859-1?Q?IcXY4m4JcuXWD1f8R5QMgHVU0Sgqw/gghLO2+AXeL4/4ifwEkq4iZ2gQD8?=
 =?iso-8859-1?Q?V6abqkXxd8ktd3+ifns2NAAbshpcpDd3jn8KSMGwCaZhtGvog2Z24maQWi?=
 =?iso-8859-1?Q?RJERkMFqgKXW1KzPIO3Zo5Wz5GTzDat7lmlbdRxG7H4UVhmH7jAtD23hWA?=
 =?iso-8859-1?Q?TWbuSZqP5D27lOAn89KlvSGt8xKa9PTdRLFMuBjdpxAfu95B214sGqMNXf?=
 =?iso-8859-1?Q?3wLzvIuPJFx6ImOEkEGkJEK+5keZf7fucUMSzvEog0vTiJQWFXSPCc2sk7?=
 =?iso-8859-1?Q?lfvX6A4Scg3ExVSFj3sXwiNPS2nsPdwbrFdFVCfkXBXtSe1Vf+Zb+a6Qv9?=
 =?iso-8859-1?Q?iDqBo8BGJN7f6ZfwqxRWkc/jC8CkWhFPBB1tf9ThluOFtxPAnYUKB6PbFM?=
 =?iso-8859-1?Q?a3WYhoEgfnNdvJoEwiVekKwVJy00BfcAN+ofX9q1/mf9XkEKUY1Zbsvr2O?=
 =?iso-8859-1?Q?/inRsVJIN+yiowzRey7odbx3+xtlgHT61UVaAQtGYPXXByW1xXcbY8teCN?=
 =?iso-8859-1?Q?H4IJtHv0YplX49B/0jl81LLHO/K+BEVUNqoCLd1M3/lCf/Y0X0nAVK8IBt?=
 =?iso-8859-1?Q?lL6VeM13hvYEc0wI/oLlGap3m6tY8FhK1tBggIvIydcI2TvEDg+4uWWZmL?=
 =?iso-8859-1?Q?qPqZZor+pg+JBrVW4cHkqT/B4fU7ZEokg4G0po01fY2dQkkYbucbLzne8A?=
 =?iso-8859-1?Q?7O5er0SXIL+p+AUlTTbdrtgxSHrcGlXEbicEZbxatJWW3YoGyw+YFlLzRL?=
 =?iso-8859-1?Q?sBwqVrGX2PYHOrBTipASEHD6sHl2jtuk9/mzM7aSZASC6wJQG+sz7js+TF?=
 =?iso-8859-1?Q?IObNErJFBbDHzioesiX/7D+mp//7Mn5DClueO9yQYYtt/OV3FJPhHas12z?=
 =?iso-8859-1?Q?UyMl1c7Ulrx1XwU2qIvwh/1+2RabMbmTKtyPLQGB/1v3VLpoJG1k21xKYE?=
 =?iso-8859-1?Q?kfgFGOo2wf1obAr2q5gnwg5SHO2edM3V8waVqv0bxyccPrU+/qrMkvFmGZ?=
 =?iso-8859-1?Q?qm7HhTK1m19ZzCon++w2YKJxzQuigkIAlRo+4muviNsmzOFj4+Je2uvKD5?=
 =?iso-8859-1?Q?oRK2GfKRMcemDDmsy2vuVm0kY2MC3M8JVVHb/3vl0uS3Pkh+I9RHUwrLPV?=
 =?iso-8859-1?Q?hHl4Y7sarKGpEufajJ6rlk/a+1UecqSTPH0Pa5OaD0vbr2ms2AAaLvNXvR?=
 =?iso-8859-1?Q?V3OUI1aiM/2mDBRd34QInCO/C1d0PDE4PJtEZr8chSuHtNN5FDuRJ3q8Pa?=
 =?iso-8859-1?Q?TqsGyE0iMHaRucOrpF4CGrfW7OuP/cfVRaLjBTf2EROy3QYcPz08VGgQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: conduent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3440.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e81b9bcd-6890-48cc-bc5b-08dd2bd13af2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2025 08:32:59.3025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1aed4588-b8ce-43a8-a775-989538fd30d8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kDcVcCHlXu0QMIJm+wSBEVwwbqlVUDR7Fp5YL04BP/T2uStE/eIiF0wGl0jqPinFPBOYnYoygViU1sZ2e6XogR2rnmDutjFWyQxa7m1B6mQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB5314

> Seems to only be consistent now with the definition of GENHD_FL_NO_PART. =
Your real issue is=0A=
> commit f5b4d71f72c5 ("mmc: card: Prevent partition scan for the eMMC boot=
 areas")=0A=
=0A=
The commit you mention stopped the partition /dev/mmcblk2boot0p1 from being=
 visible at boot. At this time, the disk flag was GENHD_FL_NO_PART_SCAN.=0A=
But we where able to make it appear after this commit by using the partx ut=
ility:=0A=
=A0=A0 * partx -a /dev/mmcblk2boot0=0A=
=0A=
After the patch a33df75c6328=A0/ "=0A=
block: don't add or resize partition on the disk with GENHD_FL_NO_PART" was=
 released (and then moved in patch 1a721de8489f=A0/ "block: Move checking G=
ENHD_FL_NO_PART to bdev_add_partition()" ), the partx command described abo=
ve fails.=0A=
=0A=
I can provide the strace output of the partx command for kernel 5.10 and 6.=
6 if you want to have a look at it.=0A=
=0A=
=0A=
> It was just deemed unlikely to be useful since most systems use eMMC boot=
 partition=0A=
> feature very early in the boot process to read blobs essentially.=0A=
=0A=
> What does yours do?=0A=
=0A=
Our system uses this partition to store 2 things:=0A=
* A file containing the block disk to use to boot. Indeed, the eMMC contain=
s 2 partitions containing the operating system.=0A=
When performing an OS update, the new OS is copied to the unused partition.=
 At the end of this phase, the file contained=0A=
inside /dev/mmcblk2boot0p1 is modified to point to the other partition.=0A=
* The logo displayed as a splash-screen during u-boot=0A=
=0A=
Having these data in a separate block disk and partition is a way to protec=
t them from a reliability point of view.=0A=
Using a file system is a way to simplify the editing and replacement of the=
se files compared to a situation where this data was stored in a raw format=
, without a file system.=0A=
=0A=
> If you know the offset the partition is at you can pass that to mount.=0A=
=0A=
Using the offset of the partition we were able to mount the partition with =
kernel 6.6. Thanks for your help. I appreciate it !=
