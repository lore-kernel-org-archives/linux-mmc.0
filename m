Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791981643A
	for <linux-mmc@vger.kernel.org>; Sun, 14 Jul 2024 06:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720939797; cv=fail; b=O6GrYxT7KanVoFiqtH4kvW6cxItJb9WYvCEE9L5fBjJg/p1AELZwfMjXBuwSzP16uskGj0kXM9n/1AsRIrF4aaP2TVgdvkAcvTXe+KlhWphJeOxLipEv3qQryjeLRB6olySDnABHYdT9TRvw5YiJo9hAf6hQttoC1YEca8dm5PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720939797; c=relaxed/simple;
	bh=eDOu+5ROuq1hbH+aXRCX1gZojsXbYcaPoV1ynKGRdOE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ocsn/mni+cHHwV6/pVOF7OBFGMbRn0HF3gvKhvmwOo9RMR2Z+t27ZgFxUOWzhg5GXw5unwZP25tGSiRPGm7lkWjFYVxu97S2JTEhUBCNqhCXA53OPg++AlYlau02v5bZxb9UG3A+P3nMrmu39lawkPbOWmSD9UGYl/z/gNjVX6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=A06L3CkO; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=GFR2cyGu; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="A06L3CkO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GFR2cyGu"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1720939795; x=1752475795;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eDOu+5ROuq1hbH+aXRCX1gZojsXbYcaPoV1ynKGRdOE=;
  b=A06L3CkOhuF3pH53JfLVo8sLeSMo5blDddI1Epd1NAw9KqjlZHAJL/p6
   0/Au+tnvyOhgjPSvGO+Uaht6WhoOTIn4hpz2XMAsq03fGlMs1sf6OGd/5
   7bUH63M5E+NO0ClxNDLjyPkvqgcjMBVixBzgrkVYjMN3G0OC8b7i2T5yh
   W8IgVjrPRAKe1Z5EzxJv2rP8yIZf5/WkVOAdyXerfLhX8lfHO9n9mIde6
   JIKL+IfzS8BzY8/16ajEg1mIEU66+19LcbZIwhPmwqhDzCYvQfxYqdXPe
   QLC4CQjwgafN/0Zv7O/7w0LlDbbbmv47MTVD40NjlQEXxkclDFqJ12GjD
   g==;
X-CSE-ConnectionGUID: p3C0y5XDQxibSnwJaYKKvA==
X-CSE-MsgGUID: LjcNVgWoTbW8UV2dbObFvQ==
X-IronPort-AV: E=Sophos;i="6.09,207,1716220800"; 
   d="scan'208";a="20887225"
Received: from mail-eastus2azlp17011029.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([40.93.12.29])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2024 14:49:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbGbxzOzEEB3tTYjiEHn7r7iOt3osTJF7UGLWgXrwG0pPTTJPVlOih7nVX5Q7lexE0KGq/OmbmAM1x6Fj8V+2JmbeLv5XiPlgsWtBPih7r+HDEsh/kazUJHwdffm82vYc2QkHap/DGqPspSBum5F6NIo3LWGkgNnED5SViH576/ssqfM60B2qoP0+v0dRswtTVc1CuKq8WTPj2tqU/smnsogv9MhWM3nzXyOvyVmWVK+eVIA3Lz48UNBtDR2Bsi8FAuw1Y6QVydyykj0KopDfTHVGepkiUWz8VCMIhUshlhgRFqWxn3PODij3i3OYwNlOnkACFTyoA/Np9p+no+kpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csGZ0i4+WhWlGOGzXqr3X9+SDQsKKOgrcUZeO/YYQBI=;
 b=OWdebsuJDm3lpAALIFGMQHegcLDWHMFiSSYOj0c5IseNURKmh9mscOO6iiRiL2mNpxVaqLAjPEz/GFHXDMy4Az2O9g3+p4bkSxDik9y7ruDdtJiSSVI8D58K2R1ONvxYV0M/zcGojpSDf0h4Oh1lzf1J8vd0c2PiJYHo+T0j9sI5tEgFbo4fdwwvYy/gzRQcUvKkytp5/ja8xo28s6bBxgYRAVpLlqv7n2es3tit/HvSGeWQZI6L+PI91REjsZliDuvPRjD1dxOyX4jKlb3rjXPSJolRXbTaHZGc69MG7C44Q+TzIOYQWugECzffsuArdeJ0CLE4oS7svl2rHT/QfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csGZ0i4+WhWlGOGzXqr3X9+SDQsKKOgrcUZeO/YYQBI=;
 b=GFR2cyGuOlzomvlhuOyg5F8cI14EQdd5c1KBW1bKZr548CnHdiC0CkmKg0KwKnTIY2olsWyJUR2wNRQzTofMbdwTks5J49H/CSKJYFXjGT8Fc5ppXBl6LRQXERfk058ylDqMZQ8PKBpQB1d2QZrRDQLrgyrA5uxNvB2V8WqQ9c4=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN0PR04MB8109.namprd04.prod.outlook.com (2603:10b6:408:15c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.24; Sun, 14 Jul 2024 06:49:45 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%5]) with mapi id 15.20.7762.025; Sun, 14 Jul 2024
 06:49:43 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Daniel Kucera <linux-mmc@danman.eu>, Ulf Hansson <ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v4] mmc: core: allow detection of locked cards
Thread-Topic: [PATCH v4] mmc: core: allow detection of locked cards
Thread-Index:
 AQHauBNeZ2lQZ81CBkKpvc0IuwzTHrHtCVmAgAH7aoCAAJ0sAIAAh1IAgAUzF4CAAKTRYA==
Date: Sun, 14 Jul 2024 06:49:43 +0000
Message-ID:
 <DM6PR04MB657562C7F927B272C7A185A0FCA02@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240606131222.1131880-1-linux-mmc@danman.eu>
 <CAPDyKFpvPaBwKdadCBC2LHTFGaEEjRN3ZrOC+PXp16aZKgPY=A@mail.gmail.com>
 <DM6PR04MB65756BE6093A5173C58CE9E4FCDB2@DM6PR04MB6575.namprd04.prod.outlook.com>
 <dc3524328a701be1ac3206af24b4a185@danman.eu>
 <CAPDyKFrQc610OB+VaG=cKQys7+3pyB4m1DA4BZXeGT5WgRYQ=A@mail.gmail.com>
 <43ef0045c1eb638b89160c7a7e9b617f@danman.eu>
In-Reply-To: <43ef0045c1eb638b89160c7a7e9b617f@danman.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN0PR04MB8109:EE_
x-ms-office365-filtering-correlation-id: d7d5d5ef-f5c3-4a3c-3f4a-08dca3d12457
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?rVWPp9zJhjjTjaRin4czOmnFYLm0FB+Nh66Hhqztukke9uCltLmrfyyhvG5L?=
 =?us-ascii?Q?8ZD1ZBK2+SJ7tHcKUylW0ycHvTbSA4y77Xyl636srJYyf5QkbPexbm8lNCJI?=
 =?us-ascii?Q?Yh5mIcaxYzih20XOaGP67P6fLroKDgtNLmCtT1s4PBWGqBf5MM9vUFhH+MZM?=
 =?us-ascii?Q?r53LzZHMh99UKStLGzrAX9WfHDkiLrrnJo37R8m1VI2KD8i/9qBH4ykw6WD1?=
 =?us-ascii?Q?dVbKR2+cxeOy5LH3n7TF4bLmavCzfrB6Ek0MHr3uKGHKNBS1fEM2R8bYTIHk?=
 =?us-ascii?Q?6WtE1LICwu21dNAbdad5Phicw3SI8C0Vrh9HSkqN7CvVoqelmpKka8XD2oud?=
 =?us-ascii?Q?72dwgwtsd1xXgyYgW1FsQv9f4A5w/7H0VQuEsR/0MC3llARJDZqHYCfjxYqF?=
 =?us-ascii?Q?GJ295hE5DuWiX16KgcKhV62P5yuNyuyJpS2LaJ4zGxNA+s7TJ/WeYueo+BaP?=
 =?us-ascii?Q?5lKAzWm6Yc0LJZzANqYpNHxs9tIPx3ANSIMpy1KyKDFijS5sa/j50/QjJ89m?=
 =?us-ascii?Q?WHi4oMiGYDkEY4Vmf2Lw1l7lJbBlfu8/m7+RCKhZWKIZT7M0tW2SPR7itnXv?=
 =?us-ascii?Q?NPoWKH6alKsg8JdIWsUdQ0Ez6V3mXCitoXtqWq47O9yp3BIn0b1ch+uTFZd8?=
 =?us-ascii?Q?hHjX4rdiUzrSislc4QZRZtVez8eh/CgKJbPAYqZDoC6/+4gh4xJladFpxOUG?=
 =?us-ascii?Q?v3vu8FJATIC8JwvoTpF62c7kKkAGL992cE4qiLf8HJ0SJLOf01dKyU6buVca?=
 =?us-ascii?Q?WSOd9aXQ3x4Eb5SKrXCdW6KxMNuydtpuxtM2PshqBAUYhedSG5kWsEZvjY8b?=
 =?us-ascii?Q?ml3vg4rpSaKxBzkwOIunF/nYD6pWezr7tXhgNX0399j2ibB2n6AUnLlgCYvp?=
 =?us-ascii?Q?IGR85Y0EtFryXb01ZgFaqm+bp7Ysb2PzmbagqwW416HqZGcoLpfco1il/tmy?=
 =?us-ascii?Q?mgttnK+OaXRUV58QJEr8Eo8Mh6pI4gKjJvbMoZneK0sZu3GhZLo5syLUF435?=
 =?us-ascii?Q?7ENpq+arCgR4x9yx/Q844vWjOlSmT9c0mfg3+XM6UwYCLyDCDEwcHU8d4omv?=
 =?us-ascii?Q?wB5TCqPW7raH/OglUu3dNdf1E77FlAOnVhNoCxGG8U9ejSDexm92fGUg3DaR?=
 =?us-ascii?Q?nkKJmf0ZDrsR0R9lgy4y7gbxSh7EHz30Dgi3yB6ank3G6Z2zm+nthnFJRp/T?=
 =?us-ascii?Q?pn8QaJ6RCKNQmgr9g4mHyYrzY2/+fGmMNpcjECf312Cjc6WuDdAJAtcvzQ/h?=
 =?us-ascii?Q?Bg7cMag6sDDNoVLpMHcbScnaeFGXOn5hdRqxeykXpnWRCYuSJYBWy2In060u?=
 =?us-ascii?Q?BiOhfpeWGFcNKynmqWJDia3AgjZTDojoAxA0VBVJHR8l2HndtwWsOO13P9hX?=
 =?us-ascii?Q?AauJSrJ5DrSj9xYe2DUx3GPkLQMez+2OQkrzX3ThpHb+CQLD2w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0T225O6+RZKs+JN9t+cdQJ08c6Y8YlpQpaYcOe+rzWAMPifGeplQfLd7h/lY?=
 =?us-ascii?Q?4hadiJX/qtaBY8IDL+oNcvXylGXHw1YODS4uo49O0Dya2FUymYHHznXlNlAy?=
 =?us-ascii?Q?DDz6MujGWookwI5Axag3NVxpMbibT8lTkZdlKKZjc58MrAGNYqQxiMvCBEW4?=
 =?us-ascii?Q?uCzYlXgLP9MGXtHmYnmQvwA7qBEdvqOc6IYw3CP+qMshT6s9aHFpP1xwteuD?=
 =?us-ascii?Q?8wKEs8H1p+yEI+w6irDpUAN9NzUH8s0vzNqasMDx/fX5k1sz2rDLOLiOdK4h?=
 =?us-ascii?Q?C4p+HsMXjBpwDj/D49lzh140zhbi39CqIucib8xqWREDXCPG9G+32xuEmRBY?=
 =?us-ascii?Q?RlXVco6+E3XpwzkxNXRvQlJP1quLG3l9oOvmrvSNjhOSEP2mfQftcaGWIcn4?=
 =?us-ascii?Q?EZOXzGCMz2cF+w5bdS4d8nTFaRCyFP+heGLvjnSBtGW9U8NHfucBzzPPLG0N?=
 =?us-ascii?Q?OC0m6oAGiUGgAmx+T0Ikq5d05ILqje8VZtWW19mJ7dSJISpyixnE9+39txaZ?=
 =?us-ascii?Q?l6Q+dhT3oFURHsepySPr4pmlwCNmzlSZxrBK4zOVgsxggAEMuBHkf6m/lcla?=
 =?us-ascii?Q?oGv2NF44VZ74T3MC46jrtuoMsUInFKNQEiCB3xbNg1TPMOK9mwA/05axwsXE?=
 =?us-ascii?Q?80mDh/jpblvpwOu28dkrIQ9qZNh1/KaEpIYoZoRqSEJl3M/sv1xFJ9w3JcRE?=
 =?us-ascii?Q?8FQ7PrPiafSTKyP6Wd7S+Z9YrEZJKTEPcGNE/9VCRrwLswxv+r/Jbpbpz2v/?=
 =?us-ascii?Q?+Q0oWrU1U53gE00u07sp1smWB4Wkw3m10axbaUE3tEOMZ0yZ9YDwiMOmi+mB?=
 =?us-ascii?Q?6poYGf5V7GkGjt1EiHF/647MOiBeHsVcnB69ms5Qn1bmlwMsfMGQ99CNXuAd?=
 =?us-ascii?Q?/3oomiFHZ/q1J22PpbZO3FfeNPI9KqNKwQJ/0/hHZYhNhsnasRUfB665SZMW?=
 =?us-ascii?Q?zXJVC2felUeHosYOm5+DnSUKmcEfUivYTTJAaib2dF6HhpZfMwCVW8SDw9up?=
 =?us-ascii?Q?YrSfgAO3wVDpsdwIxbJoAjFNcfu6hdIncmPxA0tnrxMEnPSpHvkky0Jnuuig?=
 =?us-ascii?Q?eM6DIG8TWXxGQf4cr/yNA8NocB0R8W94K6Iv6zG8UwlKp7IvuoM28/FG5iYj?=
 =?us-ascii?Q?gEFzlPSELUOa6/9J0Hdk3Dt1lpZMnlZIwpZSFTeW4WdmLcrquJAUJakujqX3?=
 =?us-ascii?Q?sXWrtF0dTrk/n0cYXVhLH+JXCHGZ4nqZ1kIYueKrpMlm/Yi8mp2oeJLuai/T?=
 =?us-ascii?Q?ZzPMlzpwYaa9ongX58ixveUO8eEQKiSDp9uw/VDUWdVQL+VR7y3OlT5EeRS0?=
 =?us-ascii?Q?qxOW0swQ67GzCzk8YZc7vA0IXIQ5XXp7eFTMiJHY4zVTkhVUJT2u5mBYFD9D?=
 =?us-ascii?Q?UVS3yKe/iNfXZG6X3Y3X1upngw/YBB2LS+a0z1VtmzlXn7ePgnaRg55NMgtP?=
 =?us-ascii?Q?yLjzqEblniX6tsFdx7y/W3Al5fCG6cfcdmZXG3qNdLeZnNI0UMKnKr0ZfA8J?=
 =?us-ascii?Q?owHS5iO+cAp7tG2IpWU4lmSSv3eaGpPKLXVP+ifGtMM5cxVAAK6RJtltE9+J?=
 =?us-ascii?Q?DJtOElnNBA8hhRq3K2UlRigbQQKxX6Mj1eOeZnSk?=
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
	VvBCo7m7em66AOIihTyJP7T1G/R1FVAIBzMXq0H3roqO/WvFBBILlC7/EUorcDXVlgarxSpPbVT2E6CDTariUzlF0i9f/kGSjaEhqORUswqZm2gNZyVNVh+0A0cPdfxg4uvVAk0VBjro+hf+9WK6zeLkqQeKkwKzhQBb/osK1vRdv+r/N0KEMQagm15FvbJPEVL7IE07tL4lfbSpWsH93JIYvK/TPrZ7xrUBvIimsO6sELQC66lvKck5HVZqmysy2A9Zn/CYV912r6WRj1jWVMUa3p3ihwlR06SH4Me2u7R9LR/KqenyAeDMZoaM0r5S2jOaFyZgAXWOIbULkRJtakeMIdoFnjC7e2M6mT2vyvEHRqtz2MMLyF5B4itLYVAQGcO3yocC93dVsLI6aZG2YzTaCVSkaG4L/4Hx3jo+3TDR+cM2LscohFujhrnIdPMF2lKbnvtZSTS595E0yHTpbnPqzucJ/RegEcCMrQIHBITAWp4INPbqwdNwRKYkuUQLKh/aoE2t00v5f6oAerzAex4/T9Py2474bhTNcz4WrGKHriAZZPXQDX4ejTaaM8ipRoNWbJSqtr52EHDvuqXf09TTStbQ/ZAh/BvpbS7eE909V76omMfd6yw4lsB4t3jm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d5d5ef-f5c3-4a3c-3f4a-08dca3d12457
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2024 06:49:43.2698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eRA7WQAhaE+1yzXsctBOBE9ZzNmKzHaldJJf9ZCaDmNFigmozUX1/B+Eky0hOCyuTn5GRyJGA8xhpnP9hrfsYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8109

>=20
> On 2024-07-10 15:26, Ulf Hansson wrote:
> > On Wed, 10 Jul 2024 at 07:21, Daniel Kucera <linux-mmc@danman.eu>
> > wrote:
> >>
> >> On 2024-07-09 22:06, Avri Altman wrote:
> >> >> If I understand correctly, there is no point in sending the CMD13
> >> >> above, unless this is the first attempt to initialize the card.
> >> >> Therefore, it's better to move the whole part above, inside the
> >> >> below if-clause too, otherwise we would end up sending a CMD13 in
> >> >> cases when it's not needed.
> >> > R1_CARD_IS_LOCKED is CMD13 response, but already in CMD7 response
> >> > as well, So theoretically you want to skip mmc_sd_setup_card
> >> > altogether.
> >>
> >> Do you mean to modify:
> >> mmc_select_card(struct mmc_card *card) to somehow return or save the
> >> R1 response to card struct?
> >
> > I quite like this, as it avoids us from sending an unnecessary command
> > during initialization.
>=20
> Okay, but what if the host is SPI?
Looking in the spec, In SPI mode, the card moves to transfer state post ACM=
D41+CMD58.
On the other hand, it does support lock/unlock functionality - identical to=
 SD mode,
And the R1_CARD_IS_LOCKED should be obtained from the results of CMD13 -=20
Just like you proposed.

So, looks like your original proposal is more inclusive, but let me ask aro=
und and get back to you.

Thanks,
Avri
>=20
>          if (!mmc_host_is_spi(host)) {
>                  err =3D mmc_select_card(card);
>                  if (err)
>                          goto free_card;
>          }
>=20
>          err =3D mmc_sd_setup_card(host, card, oldcard !=3D NULL);
>=20
> >
> > A suggestion is to let  _mmc_select_card() take an additional
> > out-parameter to provide the card's status. Then we can let
> > mmc_select_card() parse the status - and if it finds that the card is
> > locked, it can set a new state in card->state (similar to how we use
> > MMC_STATE_BLOCKADDR, for example).
> >
> > In another future step, we may also want to keep track of whether a
> > locked card becomes unlocked. Using the card->state should work fine
> > for that too, I think.
> >
> > [...]
> >
> > Kind regards
> > Uffe
