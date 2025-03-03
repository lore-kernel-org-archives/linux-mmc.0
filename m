Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC95018FC6B;
	Mon,  3 Mar 2025 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991871; cv=fail; b=RR7p/Q9/+21PqdC9Cj9rYjmqC/i3pVn34vgiM2I+cO7ELYaXSZh/PQIkjfTm3WfeObVjBqv5gyah3dly+3LjWVBdzU3vflHw4ZNLs7cLGXGaMdNFCbNaqlzqhUz3dWEejA46ywbi3M+OPrY7/ANHz0RbIVg2Lb/UaqXIphHKtv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991871; c=relaxed/simple;
	bh=Rjlfmbz4hKq2O26E5ie9bJHPjbTHG3jaO/E83/S96nQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lce1I/k3a6jC9RIHZQOINwFrchWqVEffYD/Q2DMa9AFa5iBysl0DRJG9xshux+D1DUz9LKY3fhZ5RmxdV4ZcO0RQH6FHY/ldejLCejAlKbpTNZ7XLh5Nnhu6wbu+5cE5+OMuBvXNfaooRbgy5CexmtX9X2uL4ig3fRIV5oT/BH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=yeY1AZ+J; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="yeY1AZ+J"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1740991869; x=1772527869;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Rjlfmbz4hKq2O26E5ie9bJHPjbTHG3jaO/E83/S96nQ=;
  b=yeY1AZ+JpWzv/RXm48qQokUbtyR2lcznqB2yDlRDSC3hxOCNyGFdHMx1
   +YjrFbFzJIxpgZsju7h55yBDSWNZ/NcdlYjqxvfKLi/BWDCG3MRC/bJU/
   5UswJvHYOl2JU5AEdrftRkP/xaiwtDaC75stGCs+LSXbRsc9SXu3l8KpA
   aSkuBINgQAWN/870NKIsK0+6EERuLkjDAUoC/WYZFDVRiS1c/EPzvDx10
   BI35xamTSekYGrboHkHb2e8HtCXOz//jSOQec2GuqRl+9DHtjmWsIrdMY
   mCgqWrGRvnYAIwyfL6ymEZ84Xx2+xb0FODiKLi/wgetsH+eIINOgmtHmG
   Q==;
X-CSE-ConnectionGUID: LNbLDAxYRnaJsfTdYJqXqg==
X-CSE-MsgGUID: q+OBetpnR2OL2m1hhekc2A==
X-IronPort-AV: E=Sophos;i="6.13,329,1732550400"; 
   d="scan'208";a="39897836"
Received: from mail-bn1nam02lp2048.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.48])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2025 16:51:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6vlmQmPhltdYvlTGx+bJUcdCEmUmVwXik9ITO4g14ixd8WoKeDSC9OrNJa3AQuY7MQoOndvuDVBkcgRGCCdGgfFJTJ868IChVRzOdDgiHCesTs3+ROi+zuhPwGIwsMRJZ/pk7D8XKbilnu3mxnFkg8b8HnIE2tye2duiOl/ZrnhcZuAgarF5gjLu9+WRA/nKE8uUREixW0iDiKhlU2g14OkgBoJ07cnEcotpeHMsoXZY+7hatPPrBm1jWzKWCy3Iurl/0/sZnkVnfPIVKfStDI1kQ3k89qj8Kt4RBGL7YuRatooP8asP2GdP9lf52p+O5TDBh8FWl7qnZsvRx5hxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkNrTzeSL4zHYSDl3TTtMTpLBmtnSPQWc6HuL/vlcys=;
 b=oQgq0bEbCbUZUkUGyiI9JtCKMUktsgNfCcmvs9tuxHjHRka5+hdwI9AOqG5PvuH77IWpNn40xwngY012imZyM/XEOPUE/przzdHxGpiHSo93fM5JXlrrdvny6rxWQzTQCUu/qyzmLGqnpM4s31XR2bHBevuFKKH6PB8oZsGTPrsa2kkGTXdawzYbNkkHIdJ0innnKC+usy8sVL4zcx3najm2FHjiMjFw3lHbcCFZhSquKlifeKltSh0wt2nXPLmSbeXE/yhV15yBHa8787ynJCxtHqpAU/7wUnnlTA8XBLBGxOnC6WbPI7kzAg9UCmnCCnmh9xbSbqLdc8+oHCP8pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by LV8PR16MB6007.namprd16.prod.outlook.com (2603:10b6:408:1e9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 08:51:00 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::58f:b34c:373c:5c8d]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::58f:b34c:373c:5c8d%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 08:51:00 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Guan Wang <guan.wang.jy@renesas.com>, Guan Wang <guan.wang.jy@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
CC: Avri Altman <avri.altman@wdc.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Jens
 Axboe <axboe@kernel.dk>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: block: add reset workaround for partition switch
 failures
Thread-Topic: [PATCH] mmc: block: add reset workaround for partition switch
 failures
Thread-Index: AQHbhnkI2Zb3iXnL20S8S3IGdxu6ELNaxv2wgAXvwACAAG03cA==
Date: Mon, 3 Mar 2025 08:51:00 +0000
Message-ID:
 <PH7PR16MB61968D2B7621165EFC200CF1E5C92@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250224045918.3321394-1-guan.wang.jy@renesas.com>
 <PH7PR16MB6196112328A147FC59643B76E5CD2@PH7PR16MB6196.namprd16.prod.outlook.com>
 <TYWPR01MB118773DE1E42233671F2CF007D9C92@TYWPR01MB11877.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYWPR01MB118773DE1E42233671F2CF007D9C92@TYWPR01MB11877.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|LV8PR16MB6007:EE_
x-ms-office365-filtering-correlation-id: 32c5a58d-6996-4b48-2dfb-08dd5a30858f
wdcipoutbound: EOP-TRUE
wdcip_bypass_spam_filter_specific_domain_inbound: TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?ZkFobkkvZVBlQS9MYjNoMnp4VS8vK0tnWVU1cmRsWW5MVk5Wc0xDRTY2?=
 =?iso-2022-jp?B?SUt4cVJwd3Z6R3JqWFpZT3hMOGRBWTNvdTluVmI3NXlOZDAwMW9lZE8y?=
 =?iso-2022-jp?B?UTdzbWV0d1V2UWswemMrUzhseVIzNlE4S2RJeEtpUXhrUlI4V0Fza0lO?=
 =?iso-2022-jp?B?QTh4bFBHNy9PbndLcDdkZTRnUEp2NDQwWGpVaW9ZQjVqcXRPQmNHSTVI?=
 =?iso-2022-jp?B?cnVoZUxGS015UkxpVUMyRzUvUm1kYXVpQW4rc09GekRpcEYyY1hOUHRJ?=
 =?iso-2022-jp?B?QWFpRXd4ZytCU3VzRVR0U091cVlsc1o0aVhMei96Sm85WnJ6VHVlSmpM?=
 =?iso-2022-jp?B?TlNoKzhrbzE4amk3T3FUcHhXdEZOclhoR0E3V1NVb2MwOWlBeXQzNGJw?=
 =?iso-2022-jp?B?dDRyd0ZKSVN6NEtFNDdTNWhuUWlGcU52dGM1L0NINFB2RmZ4SHhrY0l4?=
 =?iso-2022-jp?B?aFJpWkpUaWh6ckFLTDVwMjIvdTZmMXhsSzVtZ0dRbDZLeUw3Z3RBY216?=
 =?iso-2022-jp?B?V1ZkSUkvdllyenV0WExuRjMycExMV0hmV2tpV2VNZE1rYkQwdFhjRkVT?=
 =?iso-2022-jp?B?YjlHMUp0YXBSUW5DUGxQU2h0QVphSjlmeUlmUmJlcm12aUJuanV1dUNt?=
 =?iso-2022-jp?B?emMrQTJHZGFmSmNnRVExNUxJdE1XY2RyenNDRzlFSitEVUVLWVUvTnAx?=
 =?iso-2022-jp?B?aE5peWVOdWtRUGVRcWxpazZrZXlmd0NFVy9jQlJjY0xLWHhwQjRnYytH?=
 =?iso-2022-jp?B?UExqQkdaUm1SdkF4cWZ5NFdkek1yNnVQM1NlNTdZRTBwYWlDQWhxckR2?=
 =?iso-2022-jp?B?NEFNMWlENnUwRDRNY3M0MnBLMU1XWTRza2NVbit1aTNQNDZxL1BTQVBB?=
 =?iso-2022-jp?B?dW1pWmNpdStlR2VQc0M1RHVPZEp5Uk5zMi8xa1ZFa0tnUysvWmZDOE4w?=
 =?iso-2022-jp?B?cWpNckd2QTgxOWJsVTRjbUtma0ZXOVZzTUVNM0dNVDdGTG9ueGpRNTZV?=
 =?iso-2022-jp?B?QzcyQ3hHYytqSy9xaGNOZ1NPdm5DV0JOeXF6R0ZIQ2JzRmJvbWlXWkhG?=
 =?iso-2022-jp?B?QUhyd0IvUnJhSk5sMEl2RzE5WTRRck1KMFRLT1Y0N242dHJ4WmZjSU5v?=
 =?iso-2022-jp?B?TlNRRFhnSGVtcVBKaGJGK0U3ODJvenQ2QVEzaUxwWVpJYTdaQm96eWNP?=
 =?iso-2022-jp?B?SEZsVHpwM0drZENMQ1VqL0VxZmp1aHNiSytzR2h5WUw1RytFMk1IYnRG?=
 =?iso-2022-jp?B?OUNtRGpSc0xhaDZZbGRmZzNTMW1DbmtRLzh4cEVmYTBTWjNOZHBvOTZk?=
 =?iso-2022-jp?B?STFDVEpPYW5vY2ZnakRSZk1EZjQzMXM0cUdnQzQwZ0VkKy9XRG1TNUhZ?=
 =?iso-2022-jp?B?MStsOU80TFAxSU40a0tKMjVBcjhpODZGVXpBQm9CU1V1Nkk2aVV2a1Zs?=
 =?iso-2022-jp?B?SjVjMlpOL0t6MDEzallTYm9YdnZRWWlXbFBHeHlxNmpYNnpKb3BIdVZS?=
 =?iso-2022-jp?B?S1p2dC9RMUQvdG1EOVJUSmw4d2w0UXdCbUZPb3p5RUVUV0cxVUdmeTFK?=
 =?iso-2022-jp?B?L1FKcEtaNnRuTkJldzVOcUp0RHd2YW9EQnJDd3NJN2dqTnJyWVlGVy9R?=
 =?iso-2022-jp?B?cWh5L3BMTzBZTlhPeTB1bnZnREFtVDlPZjdWKzI5VzIzU2MvbDhxaFR4?=
 =?iso-2022-jp?B?U2NSTkFiL29WdE9IQXMzYjBTZHdIcS9xUzMzaXIxd2hqeEt5ejd3eTYz?=
 =?iso-2022-jp?B?cUxuUkswWkFJY3l1VEZCSWRjalZVTWlEbVd5enprSFlHTlhPRU9pWTZq?=
 =?iso-2022-jp?B?dWdqbnY2bW9TS0t5aFNacm5zVUN5UjJsZXBjWVFUUG5sK1MxRUVwQUF3?=
 =?iso-2022-jp?B?VitNTDNDamdsUmlBM1ByUnBTV01idkxjcFBiOVQ0R2N0N1BEKzFCZ1Zh?=
 =?iso-2022-jp?B?dHFkUlRISVdhdmF2dEdRaHl1L1YvcUdhSURrbHgvcDZxUzZGbnplbm5N?=
 =?iso-2022-jp?B?U01sVjhidXRuKzFMU21Jd01zU1k3ZW5hb2hHMHRrWE1HbVVzWUtwd2M3?=
 =?iso-2022-jp?B?RCtnYnZhendMTk0rRUVWSHNTb3dxdE9kRGZiVkdGcXhoeWwyUERTTFVC?=
 =?iso-2022-jp?B?aVg=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?aEhtREprL296dXZDaUYxbzA2K1JvbzR6bGdhcTBENDBMMkNiRVgzOHpN?=
 =?iso-2022-jp?B?ZC9VdjdZVE9DbGU2SWJxMmFpd3R6dVQ1bnZQbjBweWRCZktaWXhPWVE1?=
 =?iso-2022-jp?B?eVFXK3JoOXVDVFhzK1dKUm8xeWt3WnJJQmttdjZXT2ZDRzV6QzRxYnZQ?=
 =?iso-2022-jp?B?ekI0ZXZBcE5IckNOcjdUZ1g5bk5KaWppR3JKUDcwMXJxYkdaUUdkWHEv?=
 =?iso-2022-jp?B?aTd5MDhVOFlKUDdidHgwVnNxMjV2MjdHU2VRYkx3VWxXKzRLS0hwUHMv?=
 =?iso-2022-jp?B?MzZ4a2llUkRZaWNOcGlxNDFvekpiWmFOTGN3MURWNDhiU1NNREpWN3J4?=
 =?iso-2022-jp?B?T0RCYkRvaGNxWk4wbmtsMVo2VGk5OXZxQmpmNzNuSUNQOU52M0hLd0pt?=
 =?iso-2022-jp?B?c0Y2YnBqVmJSckx5Wm9UWVU0TlByc2tFNzRxTlRnNExMRGdCWXptbzlG?=
 =?iso-2022-jp?B?NERDMGpFL1FsbHhYOStHVUJEUGJQOWxHZm9YN2hBSWRXSTFEZExCNk5F?=
 =?iso-2022-jp?B?YXRxSm0zalZpMjM0RVpvQTNFU0N2ZmVKQTdvd05mTm1zSWVjRUV5ZUFN?=
 =?iso-2022-jp?B?Y2d2NG1SbENQczdDaU1Kend1M0Z5eGgxdUNYdkd4dnJ5bS9iL3liajdL?=
 =?iso-2022-jp?B?WVpqOFFMTEt2dTVZaFpFbENlRVV2bldmNXUyeEVTSk1NYU8yMXlPd3NG?=
 =?iso-2022-jp?B?UGR5MEFCMzBiN252ZThUcWRYdDA5SEcyUUo4UFg0cnNVa29wcUJDbW5M?=
 =?iso-2022-jp?B?TVJldjZaQS9jdjFjRnpaaXhCOU8ra1lubDdaNWw1V1hwQVhCem1ndUFl?=
 =?iso-2022-jp?B?Qit5WHB0UmpMUllET0x5cUdPWjRIaEpzc3U5Q1IxMTRCWGx2OVliM3ds?=
 =?iso-2022-jp?B?L0JLVjloSzdOUVA3cmJuT0ZnZ3Bxdis2QnFZeWpZbUtlL1pZNXEwWENz?=
 =?iso-2022-jp?B?Q2E5cGVTYjl4SkVlemErZGtmRGlZU3Bxa0hudFp6eGNHamZtZFFEZ0Fv?=
 =?iso-2022-jp?B?bTRweWtMRFNMb1NzK1hjY0pGS3YyVkt1RWd3dVE3QXVJTHZBbmVSL3pu?=
 =?iso-2022-jp?B?QkdxWDZEU2hYdlFNMU82c2Qxd25iOS9aSXlydjNzYU1RYS9OZ0U2cE94?=
 =?iso-2022-jp?B?aGlZUExwWkdHZVYvMHAyU2dFakpDL1liUVBwaEtwQjRqWWFiWlRXaGd4?=
 =?iso-2022-jp?B?UXRyZDIvTTdOMExsN2VJdHNQVFg0M0RTbEJTSnlmY2lHaFlVeFcvZncr?=
 =?iso-2022-jp?B?aFBlRzYxeGMyYU03TFluMTBzazdneDdjcDBTU2hBdGcrekYwQTJ4VjA2?=
 =?iso-2022-jp?B?ZS9UeUlKWU4zZnZmdk1peWpJNTVkc2YvcTVDT1FwZ25ScWhvR3ozVmpv?=
 =?iso-2022-jp?B?cEJlRlErZnBGcDVtdXQ2VWFqdEtzTDcySzJqaWJHS1JzNEZMSUZULzR6?=
 =?iso-2022-jp?B?SXVtM0FsNGhnbW5UNG9HVVR2Z1p0RmlJVWpXUlhQOGNTQ3poekdVclI5?=
 =?iso-2022-jp?B?OE0rZlZVVVpUa0tYZkFNeTN1U1FyUVE0YjZnY0ZHYUErUzN2TTJiN2FS?=
 =?iso-2022-jp?B?eXhXTHBBWTNMOWFQVkZIWms0RUo1eTFscGZWN2dOZDM0dk9VVVI0eHBI?=
 =?iso-2022-jp?B?ZGlDQU1rM05DVlZ5SGd5dFlVQmhGMTRRNXppVlpMTmNuY05JeEVtMUtu?=
 =?iso-2022-jp?B?cXl2ZnpTNUVJL0srWXFIU2FGU1d2WU5BZjVvM0lTSHlyUVBCNlBYZEtJ?=
 =?iso-2022-jp?B?UFJKeXczQ09HTkpiblRrNldubTVld0czWnFTTUF6eWRVU3NWZ1Jqd3Bs?=
 =?iso-2022-jp?B?YnppVkgwTjRiMUxwNms4cUF3QVB1dE5RMnAxalRjcWlZbVRjaXNqUDRk?=
 =?iso-2022-jp?B?R3F3QnJpZmZpZzVlUGJlQk9RM012enpHdEhhK3dTU1FsNzB1eC9EcHlY?=
 =?iso-2022-jp?B?aS9sbDhLR1A5bEtvenR5ajNWaThXcXNFb2N5b1JIR0JrZi9nWlNOUHlu?=
 =?iso-2022-jp?B?cm9CZTY1VC8wNzJSRmYwNlV6RWlVOWpiYXFSLy84M0NGMVVlWmtlSm1K?=
 =?iso-2022-jp?B?QmxoWmpuL1RGTzNGK0Q1WXV5YU1NTWpPMFUwV1JVU0VJRWtFWTFrYis2?=
 =?iso-2022-jp?B?V2lwd3p5QUlpeFZ5dmRyMmU1THpSNGJyL01NRVJYRWhRei9mVDN2M2pO?=
 =?iso-2022-jp?B?RTdsdTZ2WHhxTXY5WHVjSnhpcVJzNVlTOWJuUEtnTmo1WG9ZVXUzbjJT?=
 =?iso-2022-jp?B?akZoTSs4bFVJUDJRMmhEZFRNZXF5YnVNMDEzQmNWRm1iVWxZeWIyN2pR?=
 =?iso-2022-jp?B?MjRiRQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C3JW7s5aQVioSYHgi3hZkfK/uYTKJxe5iO4Z+Bg1AxPZnLm0/lfAyLk+WuxG1HUNACn31NbUZmd+5rJAEkCfBSmlMUdP1uom8fMYyJ7fcRLRSbY3TM+qbyY+dtHWizRBISsl2McvqKgdQpAoFXVbKCRQaYkzJ/6nEqUjb6UaWPyVr8hdP8JG/G/hWl8MFWRzPlZ5q6sEhvh7ck6/d7/P85P3eOpj0/Horoo1CO5G4XWpg822skXEUFluosBBZe47HDTiEde4sWLYwv3eSb2wUxC8wEOCUDSUqnJcTLF/WSoBigiFQ6+KJa4FKchoLJkL4OFIVNYuAnT6HPMsp8xzCmICmWRJ2UIKemY9SQEO3LrFRSkji86V/o/op4UJF6p2XsgLgeTLvDOBMiCqhuHIRGNyLHShSFC9E5gs5baZS3QplDCmqyPgHg4PW3BhUHwH/o7i2jlCvzifsjLmtWNGLTjJb6Q0nFmgpO3WJ5yEx74Yum/PQPONoUsLhJEI3ROJ5y0woZJMXvSyi3NHChbEgByV1/KclIper4eD08ZeCu6NRgetriZy35txKNCtzmpXV0DIsyUbJt5hXIFUefxe7W+GzlQCUXheWqLouL7dS/aWGfZtseYcGLIBXuA9mIc4
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c5a58d-6996-4b48-2dfb-08dd5a30858f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 08:51:00.2140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DqCn1/CriZI2CmtjYpCMlWrmiDxTu4EqjPyYTjlVm4TlBhaUX3+v3+elzk7BEyZrJ9sWsJ+Y0LF6enQd/xfK1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR16MB6007

> Hello,
> >> Some eMMC devices (e.g., BGSD4R and AIM20F) may enter an
> unresponsive
> >> state after encountering CRC errors during RPMB writes (CMD25). This
> >> prevents the device from switching back to the main partition via
> >> CMD6, blocking further I/O operations.
> >Different cards on the same platform?
> >Can you share which platform, and few lines from the log supporting your
> analysis?
>=20
> I tested on R-Car Gen3/4 platforms, which use the same host controller IP=
 and
> the tmio_mmc host driver.
> The tests were conducted on different board and eMMC combinations:
> - Gen3 Board with Samsung eMMC (BGSD4R) =1B$B"*=1B(B Issue observed
> - Gen3 Board with Micron eMMC (AIM20F, new version) =1B$B"*=1B(B Issue ob=
served
> - Gen3 Board with Micron eMMC (AIM20F, old version) =1B$B"*=1B(B No issue
> - Gen4 Board with Micron eMMC (G1M15L) =1B$B"*=1B(B No issue
>=20
> The issue only occurs in the RPMB partition during write operations, wher=
e a
> CRC error is triggered.
> To investigate further, I hacked the host driver to generate a dummy CRC
> during the CMD25 data phase.
> The reproduced log is as follows:
> $ ./mmc rpmb read-counter /dev/mmcblk0rpmb
> [   75.557848] w_t: -->START_CMD6 (arg: 3b30301)
> [   75.557863] w_t:    resp[0]=3D900
> [   75.557875] w_t: -->START_CMD13 (arg: 10000)
> [   75.557884] w_t:    resp[0]=3D900
> [   75.557894] w_t: -->START_CMD23 (arg: 1)
> [   75.557903] w_t:    resp[0]=3D900
> [   75.557915] w_t: -->START_CMD25 (arg: 0)
> [   75.557924] w_t:    resp[0]=3D900
> [   75.557931] !!!!!!!!!!!!!!!!, make a dummy write CRC on DAT
> [   75.563631] w_t: (data_err) -84 stat=3D20820604 error=3D5800 (which me=
ans
> eMMC device feedbacked nagative CRC status)
> [   75.563672] renesas_sdhi_internal_dmac ee140000.sd:
> __mmc_blk_ioctl_cmd: data error -84
> [   75.573112] w_t: -->START_CMD6 (arg: 3b30001)
> [   75.573132] w_t: (cmd_err -110) stat=3D20c00401 error=3D12000
> [   75.573154] w_t: -->START_CMD6 (arg: 3b30001)
> [   75.573169] w_t: (cmd_err -110) stat=3D20c00401 error=3D12000
> [   75.573183] w_t: -->START_CMD6 (arg: 3b30001)
> [   75.573197] w_t: (cmd_err -110) stat=3D20c00401 error=3D12000
> [   75.573211] w_t: -->START_CMD6 (arg: 3b30001)
> [   75.573225] w_t: (cmd_err -110) stat=3D20c00401 error=3D12000
> After this issue occurs, the eMMC device no longer responds to CMD6, even
> subsequent accesses to the main partition proceed abnormally.
> However, if we perform an eMMC card reset at this point, the retry of CMD=
6
> works as expected.
Thank you for sharing it.

>=20
> BTW,
> I now believe that sending CMD12 is a better solution in this case rather=
 than
> performing a reset.
> According to information from the eMMC vendor, even in a closed-end write
> operation (CMD23 + CMD25), CMD12 is required if any communication error
> occurs.
> The JESD84 specification also mentions a similar requirement: "A stop
> command is not required at the end of this type of multiple block write u=
nless
> terminated with an error."
> I just simply tested this approach on the affected board, and it can work
> successfully.
OK.
Please note that some host controllers do that as auto-cmd.

>=20
> >>
> >> The root cause is suspected to be a firmware/hardware issue in
> >> specific eMMC models. A workaround is to perform a hardware reset via
> >> mmc_hw_reset()
> >> when the partition switch fails, followed by a retry.
> >Same fw bug in 2 different products?
> >
> >Why do we need to fix it here?
> >The ioctl will eventually return an error, and reset is needed anyway.
> >If the eMMC is the primary storage,  the platform is rebooting without b=
eing
> aware what went wrong.
>=20
> In the main partition, a similar reset operation is already implemented i=
n
> mmc_blk_issue_rw_rq(), So I believe applying the same approach for RPMB
> should be acceptable.
> 		case MMC_BLK_ABORT:
> 			if (!mmc_blk_reset(md, card->host, type))
> 				break;
> 			mmc_blk_rw_cmd_abort(mq, card, old_req, mq_rq);
> 			mmc_blk_rw_try_restart(mq, new_req, mqrq_cur);
> 			return;
The code that you are citing does no longer exist.
It was removed a while ago - see https://lore.kernel.org/linux-block/151196=
2879-24262-23-git-send-email-adrian.hunter@intel.com/

My point is that you are recovering silently on an ioctl error that is bett=
er for the sender to be aware of and recover by himself.

Thanks,
Avri

>=20
>=20
> Best Regards,
> Guan Wang
