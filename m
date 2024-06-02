Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2040A11C83
	for <linux-mmc@vger.kernel.org>; Sun,  2 Jun 2024 05:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717306006; cv=fail; b=LICrqjYQEpAnTOclNRK6dwQT+kLuMr3++phMUlKq8Phsz7cDjreYkNZgwAK6XPFfBLlmUfEDKkj1EHkoKJ/bkcvcN1oiNygT7tsj40xZ41MZqhTjSV+FaO0H7Q9upKdBzz6y24H0h2Jt/w+kawygOs6bgN4msHxBQQ8rs+yewn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717306006; c=relaxed/simple;
	bh=edzIByMac8IaZE8H77TOFpqAsa+2O6gKjNl6sUZnqGs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CU3PlO3M7zCJGC+c4md72+3891ZQ12hK+n8CW7pv7XP10ys/48nNa8mTAuuYps4A1Mtr9koJDLMwR89IkdVTd+NOcE9Lg7fPfj3w3spWfn/EBMbj8KShP97tTRUrWcCDqpj0OgUcacZMMGgjmoPHCUUscVQyqGqRrczIAop6rGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dbsq1UkJ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=s9O9Ffdw; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dbsq1UkJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="s9O9Ffdw"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1717306004; x=1748842004;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=edzIByMac8IaZE8H77TOFpqAsa+2O6gKjNl6sUZnqGs=;
  b=dbsq1UkJOuuNqwVN/1f4cJSSLuRFt/WP/vVKRL8jZ1Kt9gnQA7mDNo/w
   eCCrU1udtOZ2HuutEAiVZ+FMuMPCuvR3lbA3Zjk3mrFyAf42CR/K0v9+P
   YLnJU2Fvh0Wm3wBLOzfI0ozImARO2xPVSN5Xz5HVLKBx66p9GMCFtmhNm
   N/V3+eAXT0g+jVnlLVWm2qzdSlPiS3zUY4va27vzWAO3Oxv1SxjM+xBRv
   XqKdOiZIenxaS9z7S3LyL3fumnad5FBgol9qGn3jPZU92GZq64c/UCt5s
   upRThqkXEpIwioUBYcxCTIqFUHwzBnRV/ORBAmANHLVemWjnBqk60lBky
   w==;
X-CSE-ConnectionGUID: 1ezP87hrTEq/ZIF2KMn8cA==
X-CSE-MsgGUID: lBlyfJ5tTpyNApoW9rUDRQ==
X-IronPort-AV: E=Sophos;i="6.08,208,1712592000"; 
   d="scan'208";a="17637762"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2024 13:26:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lc3LFeHJbOSGGBwdb6/Nn1zfRvLnY4SGViqODNBU6k4Y9p+UetMxayTmZCUfc4JNFPrny1hBL1MPCBzsqCwYJMgPYC/l26yvbKAVEmDDqhcEEPTX1k3N+tBQEdIcm+WT/GtIchDbWwN2PcY/6T1ogxrZxQSNkdyh8zJWeCQ9+mLcKPKD2Ex93z+JsoISP8X6AtVq6d0LqrEtMeuYjbg1h1havO7pfCvvWG7fZtLvQ0Yb90rYj77dH4Jfh6AI7LHttgufVppYBLOxFg4yJE/YRWdzhB1jaM/eqBh5SAFVDHET51m/iV6ncR4GZDKW+rYmbLOz4f9vQwQMOvmVu4k8xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMhgnhwhEQVPui8qUqpwQUd/6fy8Luf6unvHSWDRrVI=;
 b=IrgmI8KDKhgGWOFuo4SEYgj+oc0+YHc/be1o1lMMsmE0EG3XDzDwDS66xSChO16pR8hg9ruwJ+2V5X8UDRIA33bmTDOPWMmVfbSEgSnpVPXgyolQmCmTdhYGE8bk5nJFImdoiaZ/2+zFp7m5pPxyNpGvjrGIjpf3iqu3+P5cmzTQYjHEkMQrqBnCxGFPqDuePp4DXtIJcGRJEANnuiuNku4EbD9n3uPedOYQvLqU+68CYQrsm2owmfIraSnqxfrGt6/dW9FschKqAameWnP3y+ayigXrCMmqHq9177//yT7PcbLy7y8+DBDgVYukxXa4aGNFK7A+kPO29L9rAMifbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMhgnhwhEQVPui8qUqpwQUd/6fy8Luf6unvHSWDRrVI=;
 b=s9O9Ffdw2XStOjlmNV8RUPvR4sDcwHgYL1vqMecRwbTZYTo49Ia16HZce/wnfM3nT+CdT9/GV3d1yz2SkXuwQZ4CtM2lOHCqPW4Q6mhVV0q9ZpYF1pAVT9e1fTYABHD9skjBqOnP1BJDxeVgcTRyUfelZQT+AK9s71UonnB+mIk=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 LV3PR04MB9220.namprd04.prod.outlook.com (2603:10b6:408:26e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.30; Sun, 2 Jun 2024 05:26:34 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%6]) with mapi id 15.20.7633.021; Sun, 2 Jun 2024
 05:26:34 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Daniel Kucera <linux-mmc@danman.eu>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>
Subject: RE: [PATCH v3] mmc: core: allow detection of locked cards
Thread-Topic: [PATCH v3] mmc: core: allow detection of locked cards
Thread-Index: AQHarRQjZ8lG3T2hpEC0yWy4Na5oXbGzfzGAgACAU9A=
Date: Sun, 2 Jun 2024 05:26:33 +0000
Message-ID:
 <DM6PR04MB65758D11355C0A516B10704DFCFE2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240523132016.599343-1-linux-mmc@danman.eu>
 <8e03fa17dd41180f53fede6897ab1bf8@danman.eu>
In-Reply-To: <8e03fa17dd41180f53fede6897ab1bf8@danman.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|LV3PR04MB9220:EE_
x-ms-office365-filtering-correlation-id: 31f176f8-7fa0-41dc-4ca6-08dc82c49120
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zKSGniPpZrkl8Z8v6sqviOLNXHsChtU3uWmB9FynDwJ+qBnfEo2svAry9voK?=
 =?us-ascii?Q?bc/gx+4BjxJjtUQmTFk1l1GDfyoOJW4uB490J+c7Q327z5fzVCqefqZU3Dd/?=
 =?us-ascii?Q?l/ayyuxzosCvDJHhsCpCwUguh1b4ENNDP8ynP3sXrT7jZnv/ZYBa/nYeOwI+?=
 =?us-ascii?Q?3W09Wm3p8cEuKNNnhDIF65xWEdVMPOx86oXxjToh8iFZFqt9vBDha6u/EXGy?=
 =?us-ascii?Q?pJ+JTcdJsuueFaza3v4tXPJOp6eyyZc2L/tcV8Wg/6otIqBwppm99ZCwoC+a?=
 =?us-ascii?Q?07hqBR+G5isV8vPwzdyumU3OBH93CX7zTXvF+2l5+bVofm7sQA30zwqZTZk1?=
 =?us-ascii?Q?jYtXVGBStng1HAIg5Ws1fE2K7zn4IgyzlEQcySrRN1dwEBip3nNBPJMRYF/f?=
 =?us-ascii?Q?X8Rzyuov9PTMKZzrhW2W//3DijwOV2RwYb9axDnXLQsrHw9zSOttTi0ufeX4?=
 =?us-ascii?Q?xtJiUg1IcdEB3cfZqULK1ywun1EaGpfs3Jw1T22ugP9pNMlU3ADhHcGfGRO4?=
 =?us-ascii?Q?HJimxNcjbOJwk0vHZGKWp+Vv9fu2EcHw9JFwDVR9Du3Oi1QjTk25irMiKc1w?=
 =?us-ascii?Q?7ePYeiyn8OmSggFCqGxk+5fPBeUB2kWQkrYCT9rbMZYb+SHeSgHKcNWsUqNz?=
 =?us-ascii?Q?9J5JmuaKuu2GF8raqA7BUxAF2G41Yy0RqQvpH8GIgZq+6XX3N2H9gXyeu8pm?=
 =?us-ascii?Q?gW1qaW8gsmbwKw60HDQP9KW04QI7eAtclm0+KdzXmJuBRgwWeF9cg8eFGOuK?=
 =?us-ascii?Q?UAr+DnaL4xbGg3GsrEnCeYQLPf9vFuFB9vpABpdt8BqhpRhldToUuhszJSoj?=
 =?us-ascii?Q?UJnIfqoMejGPgrh72vq0KKs3qT1lpYhad+yJ7R2JW331YeU8h0hl/I45sA2z?=
 =?us-ascii?Q?5WLkodmfAgM/QO9g4aYdR8cOlAtiQnzdSXMO5vN37MuzU6wqBU6v5P8woUNJ?=
 =?us-ascii?Q?DsBe33LiGIDTQ7Hs6vsQTF92r2zXHCdqXUqdlXnQ7lXUyraQL9nAQlBRKcoV?=
 =?us-ascii?Q?huP4bzbIfs8tzPzgFkEdmsGplYgCDk+7VVMWo2X4vkbnO8fLfs+xGu8Sini+?=
 =?us-ascii?Q?/47sDsllqLvviVJrBviRqRuy9HOLBrPTJ27g8aZJv3fGJFj3Te0Ieprbmc5t?=
 =?us-ascii?Q?lp68MO9JuS27ffAlGEOJN/1BNfikylR13ARCWQu1XEapa7RdJRSO2UbPPgCo?=
 =?us-ascii?Q?D1g8NlFXmCIoChqAS4cC1cf+fFsEVFDycb/ejeZFeKV8iKachjfmRM7EhaOe?=
 =?us-ascii?Q?0ly9fjW0LZSgMTy8ekdXsRj0iFlG4WVJwJhtcH0gWuJYuXg6UqdP8sc+MZUD?=
 =?us-ascii?Q?WihwWcJoaYbV7oRJ8Z1lbBlBJ6Tz97AZLahecDee0T/S6A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2/bT2/8BMi3NsSYWWi7we6QMgV2M3FuJN75Yip7I1qKz8FCcU1USYOJoHspw?=
 =?us-ascii?Q?G6J45wZ4+jtlor+pIZNhjoSxJrfDh4A55+0jFWn+xloNxD9As5UCBPKdmeG2?=
 =?us-ascii?Q?t8Ze4Zd7vlfr/Ej7PliZr+0Tc7ebt8CYTX9NWcYr5+7KDSB9X5rVeduK6DQy?=
 =?us-ascii?Q?3pq7OaOa/RnZ5yqzcpOZLyRR+nPFH4yzWwH3y5lRn4W4MTo+BnySMSyP2MGk?=
 =?us-ascii?Q?DvbWVm5IvB26lFH1+rcG0lRt8FLEk/Tn3HRutvJ1xUhoX0MtL9rwZ+XEq4To?=
 =?us-ascii?Q?8o3voNSIR1/2spHslmWtuC5FfK5eCVGwsYQY/cg0bPvnDXYdYfUsg4MqHsfb?=
 =?us-ascii?Q?Zw4llpZfy/HfktBnKUf/9A8xNccmGkGANdl2o0t29gAS/W+N/HO5ZWv2fu57?=
 =?us-ascii?Q?7WQ2oFoTihbXmd2+umOGsC8UKkgpxNg5xi9Ng9wgbfXyPIQ2+zFHiErZsG0F?=
 =?us-ascii?Q?nq4S46+0aYgrsLfZbKNQLVQZaOItiB8Ywo569nNv0KKZJoP4j+X1LHGDTiJO?=
 =?us-ascii?Q?go5jRPYEmddTfTSWNqgeSYZvowT2aHBdHjPtmnTeVOo5woX/DpcRFsRfRbs6?=
 =?us-ascii?Q?BUejzTX8KRe3YjKG0ChfMnT3Ba/i9c+oKrOoFwIjVy6N0vkzTFhowS94N5eR?=
 =?us-ascii?Q?sa0klEJifZSmt6cnj660SPxxIXqECtwUsW3JGv5otqub4By2bSYx5mDjhESZ?=
 =?us-ascii?Q?YSPc+RDfetpW9EHkVRo3fkmJQKjluAe2TQhf/NOs+f29hR0qB7DJlr7rlJg6?=
 =?us-ascii?Q?0BOMcdXnMO306rEImM+vDGLAfhEF+NnOcfCQkQM+O2XEBbkMGvTHkUCLN09P?=
 =?us-ascii?Q?5MJHzyt7JjonBRUEDv/a2xV+4jJwr2ZmUplVYYXyUhnO170FiNbpYrv6hy13?=
 =?us-ascii?Q?BTG2i0hVHL53A30nAVToVsoStE3jGWsHYswU0NgWL6QIU96gckilT3RM72fn?=
 =?us-ascii?Q?HGoBUo7VUji4zmfrwgFKHwA0c8b7NBCb80VEP53wyy1LI09aAeK7tQt2eyBA?=
 =?us-ascii?Q?rzWEySCXYbtjzc/RRSbs9UG3YsH1aPrfMs3goQW66CS0VQRUaYAjiOu+GgwC?=
 =?us-ascii?Q?+flhJXpsXu4dgTEyBhY3wHkjh30kZxamv1Rs5TR8p8ZMg/b46O96vNvTTb86?=
 =?us-ascii?Q?AIRSY4p+g2ZcGherfxIJOzJwkhUgaXuiytIULUXrZ/WhkjBH0vgYTOl+QBiP?=
 =?us-ascii?Q?JPi+JZLEJulO3nc/nTdDN3mRE7cjIkxWosXjbMbTIXSE7Riw/Ihw2yFGukZO?=
 =?us-ascii?Q?mrrfN7PnfsL3QFebAF82qWkauxfUdoACukooCB3KCLw+QoNubitd/FmNslmw?=
 =?us-ascii?Q?E/eLFuoovjcZW1umWNamGybrOxgIFekFAOwkr1DUHHHayL27/zU8lgI4MXix?=
 =?us-ascii?Q?wKOoHPrVqsDly1gBL9XrVkJGOcJ8TS6mSJaWeVlWTP93K7ShRbeJ6MGBYOtz?=
 =?us-ascii?Q?SCG8REyDRdM4jRtbSPoqPf/Mu9qY0mtqINOZ2GsKSC3MY00LT8dbLW59nS+D?=
 =?us-ascii?Q?OtlrppwvY47FDZehkcwnJnOUwq5jvvrdMrAfoSXSJsQgPMkBxBfMzvRFx+w+?=
 =?us-ascii?Q?G1/BELhetratol6WMqRR190ZNYR/rlwLrRIt7t81?=
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
	ctNQItS4Gl1UljWl3yFkaWu24fkGhjNxAn3ybcTATyUBZK4A1pawAErkDYFiHMMx5K5sDS8RwnkAIzaHs6HkxU1eOvlOXw6StnVMiBzv63FINmy5j1xMcSlp4Id4e5WyBxcb0IeYutDa6+ivBU8zo9hb+P64DMh8WwBgXplQMo5igeOx+0jch6bb2DznFhMOaLYnyu4WBJskKZBxCtyXfTOfo5WJGLDC80w38P8dDx8ie/ilddyeNHkBCeW6oafs6jdGK5x29n0KgfKqmOO2FzNf19CXe9/eMA7WIYiFfOWgV3v2f7y9+XFxmw9RgRxFwXe3/Uv2Q1080Kwlhqi9HMzD4rdBbIsBNG7rTuy43n4aRrXa9hyhDn6OKlQ58Cs3UNwv/P0c/82z76vK/9PSNodpvbg1u/AWPP2ubIzxtVMXxULdcjOHcvNiwMeBHVsPyElvcoTan4W5xm0fIotiriwtyKqHKR/HJ6kwKV6cfPR5ApOfv9ZyagaqfvJhjxClGL2PCWO+GgVVSUV4E5Wru8Q5AqT8I0j1BgJvRuo/p99+AdRMLa26FhPcRgXgmSwPo9IdNMKgCTHzJOMZAFXdSUTYJLmc7UoGqKQJ336pZtSrcWiO7eUVeZiDjZRxYnMG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f176f8-7fa0-41dc-4ca6-08dc82c49120
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2024 05:26:33.9190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mO1IjWtCx4tJfpTYWZT+TKMS9tGf+EJNW8MTOjzW/nNplUPIZlffY8bRM7smv9iQ3HRwY0Pn+6MElkHXlfU0/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB9220

> On 2024-05-23 15:20, linux-mmc@danman.eu wrote:
> > From: Daniel Kucera <linux-mmc@danman.eu>
> >
> > Locked card will not reply to SEND_SCR or SD_STATUS commands so it was
> > failing to initialize previously. When skipped, the card will get
> > initialized and CMD42 can be sent using ioctl to unlock the card or
> > remove password protection.
> > Until unlocked, all read/write calls will timeout.
> >
> > Signed-off-by: Daniel Kucera <linux-mmc@danman.eu>
> > ---
> >  drivers/mmc/core/sd.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
> > 1c8148cdd..ae821df7d 100644
> > --- a/drivers/mmc/core/sd.c
> > +++ b/drivers/mmc/core/sd.c
> > @@ -928,8 +928,19 @@ int mmc_sd_setup_card(struct mmc_host *host,
> > struct mmc_card *card,
> >       bool reinit)
> >  {
> >       int err;
> > +     u32 card_status;
> >
> > -     if (!reinit) {
> > +     err =3D mmc_send_status(card, &card_status);
> > +     if (err){
> > +             pr_err("%s: unable to get card status\n", mmc_hostname(ho=
st));
> > +             return err;
> > +     }
> > +
> > +     if (card_status & R1_CARD_IS_LOCKED){
> > +             pr_warn("%s: card is locked\n", mmc_hostname(host));
> > +     }
> > +
> > +     if (!reinit && !(card_status & R1_CARD_IS_LOCKED)) {
> >               /*
> >                * Fetch SCR from card.
> >                */
>=20
> Any feedback please?
You didn't address my comment from your v1 -=20
Since eMMC & SD shares the very same locking feature (non-COP SD that is) -=
=20
You should at least explain in your commit log why it isn't an issue for eM=
MC,
If indeed it is not.

Thanks,
Avri

>=20
> D.

