Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FD0187FED
	for <linux-mmc@vger.kernel.org>; Tue, 10 Sep 2024 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725965791; cv=fail; b=myxyKTjtfjgmVeFFVFYz0yjOZIi8IN2mjGl6jWcM9jTKrSdAP87AsXnnCAJgGBwqUQZAt+3Z3kUkX7XHf+XqOBzIgrdzrr1gZ9+ZqZHYJ70cMGgPbA4eOpa/8bLcJ6F2yiuB+yl0SVXvRco/wl5WpyLi6nRyekCGcHraPmSh3rY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725965791; c=relaxed/simple;
	bh=5jGII2LHMjcaU01dT89Pqjlm+O+cw0gzM2VVWndMr4s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NqMVLrdNaAYlR4Ae6N6pmEbdAg+XYDx2cFXdAoXkKvGkhH2hnVY83hDi8a0kID2Hgo8QOTK4NSVxJzAJrX+9SH8ytEO2PrOQ23kYQdKZa57AnQpsNTMpvHIzokkr1aYNVXK7Okd4Fsfqg6NXGtwsHxIY2BKsyHphqXxjyfgkKDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VRePFLfP; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=YsWMiyiS; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VRePFLfP";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YsWMiyiS"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725965789; x=1757501789;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5jGII2LHMjcaU01dT89Pqjlm+O+cw0gzM2VVWndMr4s=;
  b=VRePFLfPwFna7et665B0AflXcxOAh5hifj9w0TTlzlp19Qf9pRFUDMcj
   FOWIuixx8j5sLsjd41LPjdQV3gPhoEQAPXObGLYy1CuVJ9hTTx6A/p2K0
   3mDsIChwIIZMAhy7YdECA50KbhFfp4F+s1PPc0CFnSmNPfn2w91ONBeNN
   GzGBkcc697Y2iYBnB3RR2ubkevzivHEHsCy41GG8iNx6tDrWPeMe3qWeu
   Dudx8745ZdJcjniOIFaGSi9bcCV8Thll2Zdth85AwFGQAzTTQ7HMv0i/k
   rTFjMvhvOufCpaEAAjTJULHfa/vFMxavOkRL9SETRBCifArW/wXUmTy1t
   Q==;
X-CSE-ConnectionGUID: V9V/o0lTRFOV5V2JpYFOPA==
X-CSE-MsgGUID: tC76h8W7SUaIJ9ycMzvrUQ==
X-IronPort-AV: E=Sophos;i="6.10,216,1719849600"; 
   d="scan'208";a="26345988"
Received: from mail-mw2nam10lp2045.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.45])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2024 18:56:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oeEcZT1dSb5IOX4bUXGNEWIM8GlydX4GGVnj2FjScW0JzGZSHfEiwAs2LbqKa7A4zdWusBdyFrS8/C1hA64ZrFzKQ3xWjQqtpJyzL6sOl8y8uxTHIda3rK6X1rd5lfijLCQb43D5GxNzajy+CUJS6M+uEbyP2OLP6l+JFIRw6G9+u/MHtImqGeb+aRIimZOTWuRKJrZ/NekNiB7/UvYNmpdM0OjvxwSZsxv4wDsF1u7i9RaY9oELh/ZxrUC6oDJ2I13LoMUmqJfssgUDeWt8+MvBGqlXHd8bKG9OxW0F2eNyzwLO8EDIyfSIpr8VPMlyRrNCESwKxmvy3GYYQkcvDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jGII2LHMjcaU01dT89Pqjlm+O+cw0gzM2VVWndMr4s=;
 b=BkLmvznNMWEhRVenw1oT5zVH9NDGMZuj54xABkK2dg4NUSu1tWT9Cq7RRX0OA1pj1jlDo8LITjkCabFfr1yHlQU8ELpjZhy8DpbnEYIO18vYyqiOXAoaqwKYbxBV6xiwuOr/uDrZRh/ty8ZV1J8CQz2LJHI4O3JL7Np/N1a8Z+3W2Ly9uR2incnbcsIj/eV6h913O9h6r8CxlnJIf7ImLP2BQGzjASuILUVuUy+3TueUVLUjgiZNYbA8hRV0eKFOYasJKl3dz/ZvZyuz3V/eoNqyHTMbZ+049TgnnLSi+9nptaxOYXc9TSP3MUkQOwf8MuQcwT6Y7F9kQJqSEa7w9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jGII2LHMjcaU01dT89Pqjlm+O+cw0gzM2VVWndMr4s=;
 b=YsWMiyiS88ONg15a6Xn2RroCzlRVZVR9ON3gv7KDlYS2msk6tJG6NyApO22uuxMkacA7ESvAAeYcaU+WaLDhpuVLN7brdOBMTHsJ3MUFNQ6uKquUBNCK9sgGGByMNCJeXne1ZpbpGa0xmCUzrqH2nu2Z0JfcH2DVj/nZZf7CpCk=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 LV3PR04MB8991.namprd04.prod.outlook.com (2603:10b6:408:1a7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Tue, 10 Sep 2024 10:56:20 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 10:56:19 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>,
	Christian Loehle <christian.loehle@arm.com>, Michael Wu
	<michael@allwinnertech.com>, Wenchao Chen <wenchao.chen@unisoc.com>
Subject: RE: [PATCH v7 00/10] Add SDUC Support
Thread-Topic: [PATCH v7 00/10] Add SDUC Support
Thread-Index: AQHbAdj4vMM0vFxPGUqJsXBRXsqJYLJPRK+AgAGWXdA=
Date: Tue, 10 Sep 2024 10:56:19 +0000
Message-ID:
 <DM6PR04MB65757BAB092322ACCE642A6DFC9A2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240908102018.3711527-1-avri.altman@wdc.com>
 <e157fc58-a571-4e57-b885-e011b7abdf28@intel.com>
In-Reply-To: <e157fc58-a571-4e57-b885-e011b7abdf28@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|LV3PR04MB8991:EE_
x-ms-office365-filtering-correlation-id: b42930a4-8533-4b2c-94f7-08dcd18733cb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N28rM1g1Vy84NCtLUGJJQ0oyZzZ1WUtnbGRlNndtNzRwWDFvWEx1VFNBTm9Y?=
 =?utf-8?B?czhCVnNZM3JYbldQdFlhckxQWCt5MTcyYk4vQTljcGNOOXRIQnl6b3hJckd6?=
 =?utf-8?B?UzVkbk53UXFUYmhJSlJlVGcvV3FuQTJRcnl0NHBVMEd4YTFjYlVpTkVCbndL?=
 =?utf-8?B?OC8wakVyUHY5Q0dWZWxJYy9nOWlZZUNscmhDVlJqbVZJUkp2VnkvcUxtSTFw?=
 =?utf-8?B?aExYZDhOL0lXU3kzemVPMHMyMUxVY0dvM05Da1lVRDB3Wng3TTBXME1HUDdi?=
 =?utf-8?B?cVdnSENmUXpMYlBWNC95dmdsQ0J0a0ZCUnBSK2kvb1dheXowalRrUGRDOTUw?=
 =?utf-8?B?ZVEzN1Z3V1UvYlAra0dhemEvUjE3QlloZElQeE9XNVZiSjBLLytYa0padHNG?=
 =?utf-8?B?KzBkSkkxL3E5czBBKzg5c283MFRobFVOallxRjlVWnJFcDhEV3FkTE9QWjl1?=
 =?utf-8?B?VFRvaUZCN2JjQ0w2dzByTWRjZUxHbXh5dDhHaDhPNHRPMFZaczFxY1dwaS9r?=
 =?utf-8?B?bXFTd1JkU0hNNUhLaERTYjZlYyt2S1l6VGg0VkJJaVZmYlZMajJjajkwMXh1?=
 =?utf-8?B?UkxwZGt1ejJkaHFsUHcrUmNaVzU4ejdFU1FIblNHUnd1ZGozME9TT2MwUmg4?=
 =?utf-8?B?MktwcVJNSnczOHhFcHhnVHRaak4zOFI1S3FKdjBOSjZuNU5OQ1JpK2tLbnJi?=
 =?utf-8?B?S2pLaURCWmI0bTJrV2dVV3FSZGlJd0g3TjYyR3VEUzcvVllid29lYTI0d0R3?=
 =?utf-8?B?MFBxRjJNL3cvcUkxekgwR2FHaUNNT1JLRDZiU3FPM0RqUk5jcmpDYnptQTBE?=
 =?utf-8?B?MUJjTWdnUEdOYVl3TXZCTmJhWUtvWGp0bDVUeUJxNDhBYUNtT0R0dmhNUmV0?=
 =?utf-8?B?VXlYeFVlWGdrT3BOM3hsdGZ5anQ4aVRpbWQ5UHBkaTlHTmt5SnJVWjBYS1F5?=
 =?utf-8?B?QnZTL0NDTlcwMVFQQ21oSjVZbVpqKzlwMEc3ZjZySTgxdG44QlVjeWl2NUFz?=
 =?utf-8?B?MlQ1Zm1ISHdVbHFQeTFiVkZGYUhHeldjVWsvek0vUUlpVXNWU2lxUE4yS1Fj?=
 =?utf-8?B?aGVndVZZZy9jMGlGKyt3TC9iZWFYcUJjUWE2dlkwUUdPelI2bCtoMXV6cHpR?=
 =?utf-8?B?b05YTWUyWXd3SkkxUTZwREtoV25UcCtSWTAyRDE4WEFicmdydVQyWGNwem13?=
 =?utf-8?B?TzRDMi92QlBZN0h2bzFmQ3dzSVJrRWxKSGZlakoxNWM1ZjVVcGNud1g2Mk84?=
 =?utf-8?B?RS9HcUY2dmNkVVkzS3Q3VWJrZDcydFp4UnJYU2oxR0kvWGlRN25DWHFIY1ZR?=
 =?utf-8?B?RDMyNms3VWtub1BDQWNrcW5qNjdKbENZL1o3amJzT0FvUEc3OFhXaXdraGVj?=
 =?utf-8?B?MlR5a3E5ZmZWS01xQzUrak5LM0o3TEY2UnI1YTRwVVRYWndteHphWVVKWVZO?=
 =?utf-8?B?UzE3eDhFQWdWa0RWcTgxc3YwbnVId29SNysvMGlzUU4xV1NCdzdFcWV3bG1N?=
 =?utf-8?B?RHF6M1hkcGlRVzJSVHk5TWxVZzV0bE1aY0F6aUNvdWNjRURsYi9MMHh4VzMy?=
 =?utf-8?B?elhhRVpxOENNSGNhT0VzTDllbWxTRlY5Nlg1ZnRmM21ORFNkWEcycnY4TXps?=
 =?utf-8?B?Ly9rdk1RQllhU2szRUhaU3labG9OR05ic3RrY2c1SG8xcVZNdTZqaUJ3OHV4?=
 =?utf-8?B?Nnd3cUZxOEpvODBmcVM3SzlkZ3NPTUNlcTdibEt2OWVYSm5MZ1VHdTloMDIy?=
 =?utf-8?B?NnJ2SU5YL2lSOHhkc0VjRDF6Yk5pT1dPK2FPMGlOR004bHk3M0NDV3RMVHEr?=
 =?utf-8?B?a2s0c2VibGFnV0dIRk0rTmJ1T3RlZHUrWU5sNnI5V0UzTWhMMzdvOTV0OTNz?=
 =?utf-8?B?dFBiT0NEUno5azdCVUJTakFYQ0VCUmsvN2pJUWZBVlU1VEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2FNcGp3a21ZNlRFVjFJQVdrbE9JdVE2Q0RBMWxNdVFlNndMc08vbm5UTVZR?=
 =?utf-8?B?WVN4YmpmS1p2d2ZMOTh1R1lZQVJWZzRBYU9xWGw2cktwQk1NL3VyS2Z2a3ov?=
 =?utf-8?B?UVh6SWdhem13MFdXamNUVkJtelNwMmZEUUFRa1ZwYXYwaENBZkFjZGhIcDBU?=
 =?utf-8?B?Qk1LTEhjR2wrOUR3STNuRU9vRHdUMVd5elpFejNzZ0p1THhjTEMwTG8wZlRS?=
 =?utf-8?B?RUdQWDJEMXFrbFFRVnF6OGczT3d5Qk9KdFRFMno4TUZZV1FLNUY1Q21LTlVC?=
 =?utf-8?B?bThhc0FhUkhyOFBNck1obWNzQkhJbTZQOGxZaS9rRFlpQmF1MVVWcUcwMGNW?=
 =?utf-8?B?OThRaDZKQnV1dWcwUGVlRUVycCs4NmtrNmMrT0J3dU80eDJpYUt4M2x4eXhC?=
 =?utf-8?B?OVBqOEZ5enVYM3FXOUJ4amoxR1FPQXc3YlVYUloxODQ1VkZGOTQvZWdlOFpU?=
 =?utf-8?B?YmZWTm9DK0orOFQ2cXFJLzl6VGw1TTlSUnFodWVXWGxvMXowNVpFa05yLzZT?=
 =?utf-8?B?bHBCS0YyMDJ0cnlxWnhFeS9RRkFIVjVCOERDcWVPa3Foa1A5SExGL0RPSHZj?=
 =?utf-8?B?aUp2MC9TT2NhMHVSUGhLazBpZEZvYVlUcjNxL1BBWGMyRGdHd2dpR3ljTGdN?=
 =?utf-8?B?SUVEV1ZEOWF0MU1WcDJaeGRvVXdUclNSS0phM1JWdkV5bHBIZDdJbXdKRFpH?=
 =?utf-8?B?eTRPQm5QdVZvMldYTWs0eksyVDBRTlFwa0xkcXdaWUc3eXBRbG9lQVROQk9m?=
 =?utf-8?B?Q3IwSG1xU3VnbnpMbFF3akptamlDSkRZL2x3b0w3Z09zc05KeWhhVGZKUVJR?=
 =?utf-8?B?QkJ4MUdySjJtU28vNW4vM3YrajNDY25uQzFZaUtaQkQ2N1NrZnp5U1czR21P?=
 =?utf-8?B?blQyeTZzdHVVREFwOWZmSGJWcUVPSDQzMlhOVSs2K3A3NFJzb21WUEw2R3RG?=
 =?utf-8?B?SHluc05NSXpjUHBucklBYS83cW1RRmpOVzUxb2ltTGpRNm1MR1l2Smo3Yjg1?=
 =?utf-8?B?RkdsTmMrVm9GTEpqVkR6SkNyM3pkNXFMaHByRVBSSHZnZUY4Sjc5OXR5Rkx4?=
 =?utf-8?B?K3hpbE1tUVNnS1VGdmIxTXVncjFFL3NmS25KMlZFUDBDMDV4QWY5UEVtamZW?=
 =?utf-8?B?QzI3R3RxWWxFcExnRjJmdmdRZUNjRitRL0ZqUHJHUUJRNGE0ZHgxaGEwUlQ1?=
 =?utf-8?B?dEoxd1o1c0FZOS8rMzdOQ2NGcTc3bkNVVlZiZlZxdVZBdUtaTXJmT2Z4N2h2?=
 =?utf-8?B?d3JJZElvM280cXBkRHVCRmQxb3FrNTJDL2wrVFVZRnhwSGlJZkNyZ2tDbGtK?=
 =?utf-8?B?RWdVSnkxV1RVUFNTRE5qQ3lNcUlxdlByYmRaNXA4eXFQb3B0NXdTL0xEdDdJ?=
 =?utf-8?B?YlJhVHl6TTZQUnJ4LytPNytZcEdoTEh2SktEMzVYdllsQXJpK1h0S3BJbFp1?=
 =?utf-8?B?K1FNQkE1UnVyRDdtcDFleGd2U0RqdG9LM0JVbjhRTFZmWXRIYVJpdVBpQWxG?=
 =?utf-8?B?TXkrVEw0SVZHUkRJZzhvc1dQelB3QU5yY1NLUVNEVHRQL2N0VlBSTVU1aHRD?=
 =?utf-8?B?c0hTeWgvL0VWU1JrTjJyZWFKWUVaZkU1WUdSUHNhcXcrZmlJaTBGS2pxejBk?=
 =?utf-8?B?a0FUWXRyNTFYOFZMOW0zQ2xKR1ZqS3d3bzVhbm5ranVTTll5VlJ1TWZ6SDcz?=
 =?utf-8?B?djJYeGdSRDhUTGlHbkp5ZVRFM3NtclR5TE81K3RGdElod2kzK3dEQXVBZU9G?=
 =?utf-8?B?THZTYmNJc1huRFlvdHQ3T1NEdUlVaXgrS09ZODMyc0I1VWFiZU5EbTJWMGdR?=
 =?utf-8?B?Rjlwc0FVMUVCamdTUTVsbCtMK25LN05rVFJsOFpDbHBXV3hkWlhkaG1RNE8r?=
 =?utf-8?B?TUJpWlQwNlpqZU5zR0tIVGlxVzc1b3hrcElyMHBvT3g2ZzRZM2lSelNyTXZ4?=
 =?utf-8?B?c0x1aGlLTXNTTUtMSWR1SlExbGFuS2hQeTlvSW01WnN3NC91WFh6N1hzZ1c3?=
 =?utf-8?B?S1Q1MjBCWWZWeHc4N0dTMGJ4b0FLbS9HYVZzRVpCQmpBWldmRlFtMlBBL3k0?=
 =?utf-8?B?MWRDMnJTZHJQRWlTMklhMFdwU2RjUUdPUzVMNzZWQzhOa2lEL3diVGM3Skpz?=
 =?utf-8?Q?zNtqdTkt7b1m0IboqeNTK1sjo?=
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
	u0yjlUvz5r/7x9sS+A2pPsdS2/A5hhFSk1be9hRlDJqG0Ds2NNfUt63tfsXyBMc6co522Ze1NTvxRMAdKXyk3TxepPVBFE09HPnUbjuSDkDuFFskK39TK4LzjfpoOwi9xJ6Q3xT9VuC+yc6lhb/cMN1DeivqWey5fvEAjxbBBpDvzxGbBsRspYhq+w8n7Czcz4ow5l752YOwZsb0JuJS19mEaa3n8D9Zy32hNc1857RXulyTunRhXYq+im+vodPCwlBL3Dr2NFs84pTeJI38X0DsA2x9iQGupvwf6G0E3O1PEHzDYmgqYyOpZ8r4R0BCcoBF3AUGRtrnO5l2ZkUTpn8xM3Qab1x4n8IMTGVlJXD8plFjiY6xz05EzRxtvoF2yx08cdMINfC7zJS0WK1DzwWacEruE2aAwULtpkJ/EY3oSL3YDosoHBa1Wq1Rx7Wz6f84UbUSb9nZqlYKBEyp59J/Hz8DuOWgKsbdXGfDHolCcdHhcl7KGaxAFNjCp3xyMomDiUMzt5+G+6xkBEuK/OcpLb3xa2LqYLXTwVVS1O+7wwllfhbVOZtUDQOcH/2JzelggnW7n9zet09sfok1s+nIqk5KaI0UuRXAWm9Ph/ZJ+r0n7sC5VQcJUodUcyvw
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42930a4-8533-4b2c-94f7-08dcd18733cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 10:56:19.9226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: StJP4P1rDuRR6PCZ51fDia3bQttcwJGV+jOgmduBxVGtll8I3PIWSauRONOcW2viQZFbYXLg756T/OBblzHDsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB8991

PiBJIGRpZG4ndCBhY3R1YWxseSBnaXZlIG15IFJldmlld2VkLWJ5IGluIHY2LCBidXQgSSBndWVz
cyBpdCBjYW4gc3RhbmQgZm9yIHRob3NlDQo+IHBhdGNoZXMuDQpTb3JyeSBhYm91dCB0aGF0IC0g
YXBwYXJlbnRseSwgSSBtaXN1bmRlcnN0b29kIHlvdXIgbGFzdCBjb21tZW50IHRvIHY2IDAvOQ0K
DQo+IA0KPiBGb3IgIm1tYzogY29yZTogUHJldmVudCBIU1EgZnJvbSBlbmFibGluZyBmb3IgU0RV
QyIgaXQgbmVlZHMgZmVlZGJhY2sgZnJvbQ0KPiBIU1EgdXNlcnMgLSBjYydlZCBNaWNoYWVsIFd1
IGFuZCBXZW5jaGFvIENoZW4NCj4gDQo+IE90aGVyd2lzZSBJIGhhdmUgbm8gZnVydGhlciBjb21t
ZW50cyBmb3Igbm93Lg0KVGhhbmtzLg0KDQpVbGYsDQpBbSBJIGV4cGVjdGVkIHRvIGRvIHNvbWV0
aGluZyBtb3JlPw0KDQpUaGFua3MsDQpBdnJpDQo=
