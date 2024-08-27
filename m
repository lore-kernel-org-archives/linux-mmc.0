Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB2219DFA3
	for <linux-mmc@vger.kernel.org>; Tue, 27 Aug 2024 08:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748375; cv=fail; b=qFayyYqL5k/4EDtxttYj0waR5ub31WeKKtwXpByUNuELPVkgS6Aw6NysxRZJTQFWTfIVvM09ypg/vplPJUGG2ltXONLSNJIMMDNxwtLyBL7JAl+lclLFBwRhiHzpsSeiqivzBzj198vP4SbxE3XCy5qM2fomNvvVoAyKnoV2xS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748375; c=relaxed/simple;
	bh=VYbjKruxU23tAEF9EYFkv7ZVXRYZAM+5dFez1mX0aPg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E9Y6x8/lgYann8XQpsl1EbNKQdCnn9BOgQt15kVLJYJ28WjG9D+nSCbQZtuXRAAP/rdqoq4Odx+R+3tga8A75Wfl0ky9nbZxhTmQo/UAa3UgmoYgkA+tWHse8dvKuwV6ggN7N+1GC99wgYnkH4LY/YD/QTM9w54Kwi/t1MN1CqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KPuTo7Ld; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=prlzPBy5; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KPuTo7Ld";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="prlzPBy5"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724748373; x=1756284373;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VYbjKruxU23tAEF9EYFkv7ZVXRYZAM+5dFez1mX0aPg=;
  b=KPuTo7Ld1Rfnw0piauG/Wuib+x61h8mxLqOtGbiVScB+pVwjf/02lGK+
   WYqZ70me9RYjzxQu7saizzp1vQ6Ev/D/axoQMLrnZkDXY4ZwSGYup/2SI
   srJP6+tZIh5rXvu/ZucZYLNwi2+o82SiVt7P4eY7RQ8g9V01Y1n1/4yk0
   g5dyJWEwm8g2I9gLGc7u9RnrmcKTjR37E0iO6tAbL4pvML8cqBddoZOUw
   bY96mHvrIw58pHWjBZrGNI/zqgdKLgVKf6VM1vzOAEZ5cU6+Y27Xw31N7
   cAIg5uyPo7SQhL6uaHioH9nAEiXKakXfWwQtzgX4W8s1ESMze2MNitU5G
   w==;
X-CSE-ConnectionGUID: UqhXh0qdSGerb9N4roddQw==
X-CSE-MsgGUID: T6nMv9MjTmurS61DMT2tmg==
X-IronPort-AV: E=Sophos;i="6.10,180,1719849600"; 
   d="scan'208";a="25611180"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2024 16:46:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTm7t39Zgt47W9UypD2wvH7Mn8JZ6RmmhYTh/+zmQtPl9aWXsOIgfQq5djt0bW5rQZV95wpM5uqufzOS0N5DLj+PKRjCJWeU5asqpRubcInzktz1Pn8igAzZihgcs3pPeNYynOqGoYzy4Pm0mGqk+48b8bZRbLprwbJnDFwWoxasng2tynmEe6rdO616LfTMyBxAl3eOI61BVHGG6Pqu17Y3NG5XxQgObiyCGSrPI3OqoGmwrss57Iak2n8btdlSZ/IMiL1pVcuh38Kq1PEs7m9n+WvrxAgJE7TDvqyNjqHoCCJ+sPh+ADnJzZ90XWitqRbdqoIMTi9fOD0Kdw/oUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYbjKruxU23tAEF9EYFkv7ZVXRYZAM+5dFez1mX0aPg=;
 b=JBlMIibCvNcY/fovwkm7fbpFp3XF8KkQFwaAN3x/zfbmJwCqSOtvchVkwXZ7BBzqTPA9AnLaFk1utnjlFNUgF0Od1E1KswZ9zsMDfxz7lN7SvtzSZjwVQV3xTCPTWl+lmxwvRDH39xaXXqntke092gg969v7/CiEY+N89sNQ2yRwkPW7Cj87wQTT5aUEX7Cv7Sqq5EJ2pwcDgNDTdT9PKoiYdXc5HKiMfUF1OjMh1/VwaXMoJjyu7lgoQ9MDHJKHpZ6LsGA7YvjuYBGS+xhJRmaOz65DRHDKghy6LbdpY5QoRVClBfMQ/Hr7M4J0ZeO2i4TWs8dI9a6kpuG6a3B2Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYbjKruxU23tAEF9EYFkv7ZVXRYZAM+5dFez1mX0aPg=;
 b=prlzPBy5GbFlU5lAcPiKpSW8JXkQpd6AL9/PpC31NOPJ4AbMYqcSySUJ3KdG6z5QNnU8P7HsTErxJXzQAJO3k5rJ7TDq3pWmrfx6/+THk0JFq7RK51gFiUp13pDvA9tvamQVlb85lppb0v7KCOMgBKp+7NDAlwqhD0/cMyObX5I=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH0PR04MB7589.namprd04.prod.outlook.com (2603:10b6:510:54::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.24; Tue, 27 Aug 2024 08:45:59 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 08:45:59 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Adrian Hunter <adrian.hunter@intel.com>
CC: Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>, Ulf
 Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v4 0/9] Add SDUC Support
Thread-Topic: [PATCH v4 0/9] Add SDUC Support
Thread-Index: AQHa9sJ1Fgtj888U6kGa1b/dDuzVu7I5GbsAgAADPMCAAZo3oIAACNUAgAAL2xA=
Date: Tue, 27 Aug 2024 08:45:59 +0000
Message-ID:
 <DM6PR04MB657568FC857DA6877F2BA7FFFC942@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240825074141.3171549-1-avri.altman@wdc.com>
 <3d7a9953-afed-4b45-a209-b797634e6bd8@intel.com>
 <DM6PR04MB65756CEE03C15524EF646C3BFC8B2@DM6PR04MB6575.namprd04.prod.outlook.com>
 <DM6PR04MB65751048E9B35CFED478F180FC942@DM6PR04MB6575.namprd04.prod.outlook.com>
 <cb9c225c-b5c2-43ba-a6d5-843dc2790fd4@intel.com>
In-Reply-To: <cb9c225c-b5c2-43ba-a6d5-843dc2790fd4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH0PR04MB7589:EE_
x-ms-office365-filtering-correlation-id: 1fe724af-a840-40bd-2d70-08dcc674acc9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Rk9vQjZRbVpuSC9NN2ZQVkRzTGsvTWpucUxTMVBaOUR6SkJLaWZ4Lys3RVkr?=
 =?utf-8?B?Q2JacVhQeUYxbkpuZThuSkYyelBPQU1Zc1ZkYVpnTCtxMFRMYzdtMEZzbndX?=
 =?utf-8?B?Y0Z3U0R3NUx4YU5IZXc0Y2laWE9teG5qQkZXY0ZxdTUrWFNZd3F0cHVHRE16?=
 =?utf-8?B?SHlsVHZSSk5La0N3Q1JyQmVJRENhRFdDQ2tBQWs2S2xVb0x2dDFRNnRGT0t4?=
 =?utf-8?B?c05wcStTL1VOdERzNFdQa1crNDdWQXlEVzBxNjljdGtqdE9Dc3pEUEsvc0Rq?=
 =?utf-8?B?aGgwSHRTVUZ3WjdEWlNzbERSWTNQVG9CU0kxQWVEc1VoQ3phYVFXNnZnTHlM?=
 =?utf-8?B?eUhVTmV2VjQwcUc4Vy9HOVNpZkp4SFhzNll4VzRhKzRDNlNuRkZ6bEhHU0tJ?=
 =?utf-8?B?Tkc0bVpkVzlqTENRQXlvVWVsUWNRbW5RbXovQ3pTWmpsdlIvdXdicXMwNWpY?=
 =?utf-8?B?TTRSb2gzdkRLeWQzRG4yd0lPbE43VS9FVXc3VE5vdjgvQWxWMW9aN2tILzdW?=
 =?utf-8?B?QXhLYS8yaFdXTHJXeWN2TTNySXN1RWRCdU9kT0UybHUxMkhnSFhFVjB1M0xC?=
 =?utf-8?B?Z1U2VnJmUE9LWGgzTU9naStiRHgxRU4vSEdJQkl1UWRjeGgrajBiekZKZkdo?=
 =?utf-8?B?cERsMEJ1dnc3c0MySTF4SkxndFNKemxkR0laamVYZndaR1oxbklvRm9wWVJZ?=
 =?utf-8?B?S1JmUWtmeUV4U1RtbU1OVGZrK2pNdWg3dC9sT3lEY3FrYTdPd1ppSHRhZjdH?=
 =?utf-8?B?dGZENHdWMEJUc2hwbFNtTk45TDhQZEJQWDIyTkxwVzlYQmk1dTV4OTlMc1JD?=
 =?utf-8?B?QUJkelJibU16cVp6YUlXZmpPTzRqbWM0eXRSS05DZ3hQOWtmQW54VUVmWXFR?=
 =?utf-8?B?eUdNb2V4Ry9sQ2w2WWRRcXlYL05JZWxIRzh2YnI0Vkx6dVQvalNjUlJJM1FE?=
 =?utf-8?B?cHNJOGdPNE1WK3ZhcDEvR203bjcyaDdTSUJGckk5WjNHYjRxVEd4R2o1QlNQ?=
 =?utf-8?B?Z2NVUHlvS2RpTmZ2eGFsVTY1MDM1RkRvUzJWSWNqajJtRm5WamtleVZXQll2?=
 =?utf-8?B?UmJ2by9ZTXduSEZNeUZ1WUxPYUgwYnhxVDFXZnV1L1Y1dG52alJWOEw4SXFv?=
 =?utf-8?B?MElRYkoyc0NYWEZzUXZWMHgwaHd3Ui9GdytUb3JjSFZtZGNoUGEyNUsxNDhU?=
 =?utf-8?B?TFFDWkdOOEU4a2ZDSGpYc1czN3dwTVFLOGorMlArQUhrWSthU0xzNHBvQXpr?=
 =?utf-8?B?YThaYTNRZys1dXRMVWNJeEdCTGJEUTBPWTVWbi94MzVxd1EycHhmbTZFWWZH?=
 =?utf-8?B?UTI2REs3MmZRSUVOaXBCYVNvQVRSbzN6NXVGQ3EvL1VVZ0RTYWNnSS9MSFpG?=
 =?utf-8?B?YzJiRHp3L1RFVHlHenZBdThYVW4rVjB3NG5XZk1OR1p0a1J5S3htL2lYempZ?=
 =?utf-8?B?bHRjY0R2NEJ4bS9XVnFHMmE0UDNObmhvQW1WTENOQXovN1dFUC9VcVM4SnJ0?=
 =?utf-8?B?dGh5dTMrU1FtUE54UGpPbWZpTiszY2hhMFZER1NocXlLenNMQmJ1dURaYmpP?=
 =?utf-8?B?SS9zQ3doakx1QjloSFJ3TC9PRkJseVcrS1p0OFo0T1NPVzhPUmJ1eDFuSThB?=
 =?utf-8?B?ZlM2ek5wZ3NUY0dadkpDd1ZPZ2dGTWtUZXlObE1mbWxFTHBtVFFBSUZTSEpj?=
 =?utf-8?B?VFRaSGc3dWJPS0lLQXJrQStCck4vemF0Yk4wZzhNcWxKMURkTXlCWW5FM3Ex?=
 =?utf-8?B?d1c5RkdXZWxiZ0doM2tJVVBuS3V5dTVocXdFQ0d2RUd3ZjFrVlgzWFJ6VVBx?=
 =?utf-8?Q?5bUKPPF8H8xhJPJIyDh/eUEYtxYHBPX6OfjmU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Qlp3aTEvd0lGdmREVS9sSTRSL1lNZUJpMldOOTdJMnhwU0NwRlM2RDRBc1lV?=
 =?utf-8?B?UEd5OEk3aVp2bW4vOXV5Z3ZOMFo2NE5BeTFuWllZWEdBeFRaNDQyWCtYWHFS?=
 =?utf-8?B?eXFveUR5UVFidy95NWpnMHZBM0tITHZZMll1c1dpQlJEd0VBcUMxVnd6NndE?=
 =?utf-8?B?NVMyWDR1V2pnVWFZa21YdktZZ0lUNzljdzVOZDJBL0xnWDY3VDZ6K2pHb253?=
 =?utf-8?B?MW9GY3BnSFJ1ZDhLOEsvK2syTUxPQk1XTXlBS25WNFI3dEVyZWtmZktNRWZn?=
 =?utf-8?B?RmRpbG1ZMmhwVTkwbjdoRmp0Y2hxTVZLeVZ6Z3Z1aksvazdoTHRlcjRKSzBJ?=
 =?utf-8?B?WXZYMi9Dc1Y3c2piZkhDM1NYbkRkRHRXczd6MXNNdW5rL1dVN1prVHM1UllJ?=
 =?utf-8?B?ZDUxbUxNeU5WcFlvMWZFM1ZTcXFTSUFqSmxKS1JmMXBaVXBaWGVqeXlBNUtt?=
 =?utf-8?B?azc2eVdCQVd0MTBvU2NWMVJVdnVzckZqRnFOUVBMVWpoV0Rubm50aERYMHJz?=
 =?utf-8?B?dnU0MEFjbG9wZXRLL2g1WS92STNRc0NzOGsraWppZFUxL0hrNmFuUWtiZE0z?=
 =?utf-8?B?dkhONnpxY2crVEVmM2xLSzZSK3dRVEZsc3h5MmNVaVNzUmEwbjNxUnc4K1B0?=
 =?utf-8?B?TWVMWVlhNVNRMEFHSVc4UDR5K2E4TFBJanNLeDR4aGlVTGE4S0NJMHJTQ1Na?=
 =?utf-8?B?ZHV3eXJKUlJBM2h1RFNFdXNGNzVYaDhmcDN0UmQ1dlVxWUxOUnRSaGJXQWJo?=
 =?utf-8?B?S3pWZ1NWSjY0R0hlcWVQS2FLdkR0N3RFK081MHhhYTYzc0tsZWcvOXVQaFBJ?=
 =?utf-8?B?QmV2cWFhTTRaZjJqUVd5dFFQODJiWWI3UjB3WnRoVUplUkJHYTBQeExGOTdW?=
 =?utf-8?B?WmJ0bWo3d2p5eVVMYUlzcHI5UzN5YUVkVWV4UGRmVm9WOWRLc1hVT3ZubnpY?=
 =?utf-8?B?Q2VOem0xb3M2RXJpQStEYWNMTGRqOEZCMUVhRm8yUUMralIwbm5XRTd3TFZt?=
 =?utf-8?B?V1hqUmVTdlppclpJZzRuR1Y3cU92azNuK01Dd3htL05ENUF2aXJ5M253bWhL?=
 =?utf-8?B?UUR2VEx5S1RUSFJaNDQzeDlMcUtLM3piNGRyYzFNNmhBVFdXVVBlMUJ1TUMz?=
 =?utf-8?B?Sld1ZjlLV2hoZ0VUMzJSSFFHaVRRZzl4K1MwLy9uUDUxaDRnRjVaSmVqMWlB?=
 =?utf-8?B?TUhESUZ6T0s1SUdXNW1rL1NyMUJkdVd0bnRCdFVBWko3M0FFVmk0c0pZSTE5?=
 =?utf-8?B?a0hvVUtOc2JpU0MrSkRoRFZub1RRSkk4elJGNFpzSVIzcmszOUo2OHh6N0ZS?=
 =?utf-8?B?TmZWc2Z0TEJta2UzTmFIakh3VCtuQjRndXREbnBBeEFkYVlvZGdZYmdjZGUz?=
 =?utf-8?B?ZVM1a2tPRU1KdGs1dlVyTnd5UWJMUTVLL1k0b24zaEVqOGpUTjJ3SFFhaVh2?=
 =?utf-8?B?MFgyS1hLWTJVRzJGMUpER1QxWDJUQWMvMlhPOTQwS0JXNnVaY01saFBPZy9m?=
 =?utf-8?B?aTFyOXZ6bllYSW9rZWFWb3gyazJZM2RVSmp5V0plK1lLb3pSbTNQRGhOS2VO?=
 =?utf-8?B?TXppb1o2TE5DZFdFdlpSOHFubjh2QjRhQ1RZTDVPUjVSWFh0dzFuU2pmUFdZ?=
 =?utf-8?B?SmdXRENFSXBQNXZlaCtlMk9ONW4zYnk0aDVaNjRXK21sd0dPN29KYnBXVlVH?=
 =?utf-8?B?ekNhd2RyMEs4cGRVZWtPYjZQNExXbkE3Snd3dm95OXI5TVhMYmVIcExDVUN1?=
 =?utf-8?B?ck9INi8yaG5mZlFJclYyTytrQmNSSm00elBQSFVETWRMNSs4bkdZYUdMTFBC?=
 =?utf-8?B?YW9tMTc0UEF1NDJGS0xwWjRjejlSZ2prellJTGZIcWZZTHBPSmx2UC9mb21S?=
 =?utf-8?B?aW1Eeml2RmlmZTZacG4xU21wY2JmTGU5QlFMYW04SWg2RVBhKzgwb3E2cWRz?=
 =?utf-8?B?SU9vK0Mra3VMMk5EbHQyZ3V3U1p1TXV0Y0hRcnQ4THFPN1JoL3k0d0o4NXVm?=
 =?utf-8?B?SXRGQkpmS0FLVWJyRXoycnZPbDhNL2tTM3NVOEVZQW5XU0NoN2NEVlZwcENa?=
 =?utf-8?B?U1NSeEpNd2NqemN4QkVFeVlZbXFzTkVzeElJWW4zQks1M3lqTU9QRG80bWJY?=
 =?utf-8?Q?00I7FnC3xLHOjF0YBS4R4QWk9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ViqIy6HhLUJUlNKGwLp5iCg4kBRVctG+qu8Omw6Q79rAQPN9Lac4twWNf0pIk21tSE1Y6HHkiimyG7vvrqBnvHAM8eNVKpQ+kIq0ye1gSevHqQPgNEJZvw34NNN7BUWFaf9yB7omYTVBlcjImTwm/2QIQfMsTHAbABG6BK2utYg53ehSNewxZWAejOB3GSZA8WzF13lwqA7wEeZfy5+gMCaSN3AjCa3ZjOOYkCvq+bJXr6bOsfABEQyIrAuS6roz2FON1k9XnLk9kL2t2Hie/ckJNJSousG9WIaK/BxxYuqaP2QdSb9/qs2WifwEXHP7cfpQliFfoj6JG8ohnNjJMbuu4X37H1bdKvw/vq/+cGtG0DHuX7NZGGi98YLmppQ429uRD7AXZd+EnckAOEMFFd0YfR1ljwUc2t921VP9HADMHHcX6945XigA5mr8bLxF0iny7GHmr6NGgnlLqDbaPLs6mLnqwIlLhzTCDWlfc8znV++WQmaLvLLLFzTrkLkI80pHFTJHPpqzh9JlD3t8fPAqyLjbsA+iJhAi9OR8bnTKYkoHwMs9aRLjYU7hOItyWawzUmThguATo9wTMnL3E6FFs9Sc5ypRn+xfxYSe5+wHF0W7QERak1JUNtAva8pU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe724af-a840-40bd-2d70-08dcc674acc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 08:45:59.7070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ziYhQZDPY7gV2F7kk/zrF0JLwB/nHagvsg6PG8+NWrDrMVu7B6Rs6XMPjE7U6hQsLLexN4deiEYyV1U/837/HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7589

PiBPbiAyNy8wOC8yNCAxMDo0NSwgQXZyaSBBbHRtYW4gd3JvdGU6DQo+ID4+PiBPbiAyNS8wOC8y
NCAxMDo0MSwgQXZyaSBBbHRtYW4gd3JvdGU6DQo+ID4+Pj4gVWx0cmEgQ2FwYWNpdHkgU0QgY2Fy
ZHMgKFNEVUMpIHdhcyBhbHJlYWR5IGludHJvZHVjZWQgaW4gU0Q3LjAuDQo+ID4+Pj4gVGhvc2Ug
Y2FyZHMgc3VwcG9ydCBjYXBhY2l0eSBsYXJnZXIgdGhhbiAyVEIgYW5kIHVwIHRvIGluY2x1ZGlu
ZyAxMjhUQi4NCj4gPj4+PiBUaHVzLCB0aGUgYWRkcmVzcyByYW5nZSBvZiB0aGUgY2FyZCBleHBh
bmRzIGJleW9uZCB0aGUgMzItYml0DQo+ID4+Pj4gY29tbWFuZCBhcmd1bWVudC4gVG8gdGhhdCBl
bmQsIGEgbmV3IGNvbW1hbmQgLSBDTUQyMiBpcyBkZWZpbmVkLCB0bw0KPiA+Pj4+IGNhcnJ5IHRo
ZSBleHRyYSA2LWJpdCB1cHBlciBwYXJ0IG9mIHRoZSAzOC1iaXQgYmxvY2sgYWRkcmVzcyB0aGF0
DQo+ID4+Pj4gZW5hYmxlIGFjY2VzcyB0byAxMjhUQiBtZW1vcnkgc3BhY2UuDQo+ID4+Pj4NCj4g
Pj4+PiBTRFVDIGNhcGFjaXR5IGlzIGFnbm9zdGljIHRvIHRoZSBpbnRlcmZhY2UgbW9kZTogVUhT
LUkgYW5kIFVIUy1JSSDigJMNCj4gPj4+PiBTYW1lIGFzIFNEWEMuDQo+ID4+Pj4NCj4gPj4+PiBU
aGUgc3BlYyBkZWZpbmVzIHNldmVyYWwgZXh0ZW5zaW9ucy9tb2RpZmljYXRpb25zIHRvIHRoZSBj
dXJyZW50DQo+ID4+Pj4gU0RYQyBjYXJkcywgd2hpY2ggd2UgYWRkcmVzcyBpbiBwYXRjaGVzIDEg
LSAxMC4gIE90aGVyd2lzZQ0KPiA+Pj4+IHJlcXVpcmVtZW50cyBhcmUgb3V0LW9mLXNjb3BlIG9m
IHRoaXMgY2hhbmdlLiAgU3BlY2lmaWNhbGx5LCBDTURRDQo+ID4+Pj4gKENNRDQ0K0NNRDQ1KSwg
YW5kIEV4dGVuc2lvbiBmb3IgVmlkZW8gU3BlZWQgQ2xhc3MgKENNRDIwKS4NCj4gPj4+Pg0KPiA+
Pj4+IEZpcnN0IHB1YmxpY2F0aW9uIG9mIFNEVUMgd2FzIGluIFsxXS4gIFRoaXMgc2VyaWVzIHdh
cyBkZXZlbG9wZWQNCj4gPj4+PiBhbmQgdGVzdGVkIHNlcGFyYXRlbHkgZnJvbSBbMV0gYW5kIGRv
ZXMgbm90IGJvcnJvdyBmcm9tIGl0Lg0KPiA+Pj4+DQo+ID4+Pj4gWzFdIGh0dHBzOi8vbHduLm5l
dC9BcnRpY2xlcy85ODI1NjYvDQo+ID4+Pg0KPiA+Pj4gUGVyaGFwcyBhZGQgc3VwcG9ydCBmb3Ig
bW1jX3Rlc3QNCj4gPiBBY3R1YWxseSwgSSBhbSBub3Qgc3VyZSB3aGF0IHNob3VsZCBiZSBhZGRl
ZCB0byBtbWNfdGVzdCBhcyBmYXIgYXMgU0RVQw0KPiBpbmRpY2F0aW9uOg0KPiA+IGZyb20gZG1l
c2cgd2UgaGF2ZToNCj4gPiBbIDQyNTMuOTIyMjIwXSBtbWMwOiBuZXcgdWx0cmEgaGlnaCBzcGVl
ZCBTRFIxMDQgU0RVQyBjYXJkIGF0IGFkZHJlc3MNCj4gPiBkNTU1IFsgNDI1My45MjI0MDldIG1t
Y2JsazA6IG1tYzA6ZDU1NSBTUjA0VCAzLjcyIFRpQg0KPiA+DQo+ID4gQWRkaXRpb25hbGx5LCB3
ZSBoYXZlIHRoZSBjYXJkIHNpemUgc3lzZnMgZW50cnk6DQo+ID4gIyBjYXQgL3N5cy9ibG9jay9t
bWNibGswL3NpemUNCj4gPiA3OTk5MjU4NjI0DQo+ID4NCj4gPiBBcyB3ZWxsIGFzIHRoZSBjc2Qg
d2hpY2ggaW1wbGllcyBpdHMgY2FwYWNpdHk6DQo+ID4gIyBjZCAvc3lzL2NsYXNzL21tY19ob3N0
L21tYzAvbW1jMDoqICYmIGNhdCBjc2QNCj4gPiA4MDBlMDAzMmRiNzkwMDc3MzJiZjdmODAwYTQw
NDAwMQ0KPiA+DQo+ID4gV2hhdCB0ZXN0IGRpZCB5b3UgaGFkIGluIG1pbmQ/DQo+IA0KPiBEb2Vz
bid0IGFsbCB0aGUgSS9PIG5lZWQgQ01EMjIgZmlyc3Q/DQpPb3BzIC0gUmlnaHQuDQoNClRoYW5r
cyBhIGxvdCwNCkF2cmkNCg0KPiANCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBBdnJpDQo+ID4NCj4g
Pj4+ICwgYW5kIGl0IHdvdWxkIGJlIGJldHRlciBpZiBlbmFibGluZyBTRFVDIHdhcyB0aGUgbGFz
dCBwYXRjaCwgc28NCj4gPj4+IGJpc2VjdGluZyBkb2Vzbid0IGxlYXZlIGEga2VybmVsIHRoYXQg
aGFsZi1zdXBwb3J0cw0KPiA+PiBTRFVDLg0KPiA+PiBEb25lLg0KPiA+Pg0KPiA+PiBUaGFua3Ms
DQo+ID4+IEF2cmkNCj4gPj4NCj4gPj4+DQo+ID4+Pj4NCj4gPj4+PiAtLS0NCj4gPj4+PiBDaGFu
Z2VzIGluIHY0Og0KPiA+Pj4+ICAtIFNxdWFzaCBwYXRjaGVzIDEgJiAyIChVbGYpDQo+ID4+Pj4g
IC0gQW1lbmQgU0RfT0NSXzJUIHRvIFNEX09DUl9DQ1MgaW4gbW1jX3NkX2dldF9jaWQgKFVsZikN
Cj4gPj4+PiAgLSBVc2UgY2FyZCBzdGF0ZSBpbnN0ZWFkIG9mIGNhcHMyIChSaWNreSAmIFVsZikN
Cj4gPj4+PiAgLSBTd2l0Y2ggcGF0Y2hlcyA1ICYgNiAoVWxmKQ0KPiA+Pj4+DQo+ID4+Pj4gQ2hh
bmdlcyBpbiB2MzoNCj4gPj4+PiAgLSBTb21lIG1vcmUga2VybmVsIHRlc3Qgcm9ib3QgZml4ZXMN
Cj4gPj4+PiAgLSBGaXggYSB0eXBvIGluIGEgY29tbWl0IGxvZyAoUmlja3kgV1UpDQo+ID4+Pj4g
IC0gRml4IEFDTUQyMiByZXR1cm5lZCB2YWx1ZQ0KPiA+Pj4+ICAtIEFkZCAnVGVzdGVkLWJ5JyB0
YWcgZm9yIHRoZSB3aG9sZSBzZXJpZXMgKFJpY2t5IFdVKQ0KPiA+Pj4+DQo+ID4+Pj4gQ2hhbmdl
cyBpbiB2MjoNCj4gPj4+PiAgLSBBdHRlbmQga2VybmVsIHRlc3Qgcm9ib3Qgd2FybmluZ3MNCj4g
Pj4+Pg0KPiA+Pj4+IC0tLQ0KPiA+Pj4+DQo+ID4+Pj4gQXZyaSBBbHRtYW4gKDkpOg0KPiA+Pj4+
ICAgbW1jOiBzZDogU0RVQyBTdXBwb3J0IFJlY29nbml0aW9uDQo+ID4+Pj4gICBtbWM6IHNkOiBB
ZGQgRXh0ZW5zaW9uIG1lbW9yeSBhZGRyZXNzaW5nDQo+ID4+Pj4gICBtbWM6IGNvcmU6IEFkZCBv
cGVuLWVuZGVkIEV4dCBtZW1vcnkgYWRkcmVzc2luZw0KPiA+Pj4+ICAgbW1jOiBjb3JlOiBBZGQg
Y2xvc2UtZW5kZWQgRXh0IG1lbW9yeSBhZGRyZXNzaW5nDQo+ID4+Pj4gICBtbWM6IGhvc3Q6IEFs
d2F5cyB1c2UgbWFudWFsLWNtZDIzIGluIFNEVUMNCj4gPj4+PiAgIG1tYzogaG9zdDogQWRkIGNs
b3NlLWVuZGVkIEV4dCBtZW1vcnkgYWRkcmVzc2luZw0KPiA+Pj4+ICAgbW1jOiBjb3JlOiBBbGxv
dyBtbWMgZXJhc2UgdG8gY2FycnkgbGFyZ2UgYWRkcmVzc2VzDQo+ID4+Pj4gICBtbWM6IGNvcmU6
IEFkZCBFeHQgbWVtb3J5IGFkZHJlc3NpbmcgZm9yIGVyYXNlDQo+ID4+Pj4gICBtbWM6IGNvcmU6
IEFkanVzdCBBQ01EMjIgdG8gU0RVQw0KPiA+Pj4+DQo+ID4+Pj4gIGRyaXZlcnMvbW1jL2NvcmUv
YmxvY2suYyAgfCA1NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+ID4+Pj4g
IGRyaXZlcnMvbW1jL2NvcmUvYnVzLmMgICAgfCAgNCArKy0NCj4gPj4+PiAgZHJpdmVycy9tbWMv
Y29yZS9jYXJkLmggICB8ICAzICsrDQo+ID4+Pj4gIGRyaXZlcnMvbW1jL2NvcmUvY29yZS5jICAg
fCA2MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tDQo+ID4+PiAtLQ0KPiA+
Pj4+ICBkcml2ZXJzL21tYy9jb3JlL2NvcmUuaCAgIHwgMTQgKysrKysrKy0tDQo+ID4+Pj4gIGRy
aXZlcnMvbW1jL2NvcmUvcXVldWUuaCAgfCAgMSArDQo+ID4+Pj4gIGRyaXZlcnMvbW1jL2NvcmUv
c2QuYyAgICAgfCAzNiArKysrKysrKysrKysrKy0tLS0tLS0tDQo+ID4+Pj4gIGRyaXZlcnMvbW1j
L2NvcmUvc2QuaCAgICAgfCAgMiArLQ0KPiA+Pj4+ICBkcml2ZXJzL21tYy9jb3JlL3NkX29wcy5j
IHwgMTYgKysrKysrKysrKw0KPiA+Pj4+IGRyaXZlcnMvbW1jL2NvcmUvc2Rfb3BzLmgNCj4gPj4+
PiB8ICAxICsNCj4gPj4+PiAgZHJpdmVycy9tbWMvY29yZS9zZGlvLmMgICB8ICAyICstDQo+ID4+
Pj4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYyAgfCA0MCArKysrKysrKysrKysrKysrKysrKyst
LS0tDQo+ID4+Pj4gaW5jbHVkZS9saW51eC9tbWMvY2FyZC5oICB8ICAyICstICBpbmNsdWRlL2xp
bnV4L21tYy9jb3JlLmggIHwgIDEgKw0KPiA+Pj4+ICBpbmNsdWRlL2xpbnV4L21tYy9zZC5oICAg
IHwgIDQgKysrDQo+ID4+Pj4gIDE1IGZpbGVzIGNoYW5nZWQsIDE5NSBpbnNlcnRpb25zKCspLCA1
MCBkZWxldGlvbnMoLSkNCj4gPj4+Pg0KPiA+DQoNCg==
