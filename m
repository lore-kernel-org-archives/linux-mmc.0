Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B04C1C8FDB
	for <linux-mmc@vger.kernel.org>; Fri,  6 Sep 2024 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725617714; cv=fail; b=WeT09esXVvIUMZCLeUnJqv0rKwJRcYQ6ZKbrKXsJddA3JExrctgtP0RQA8Bn7k9sJxx30blw0OOb9vvZgaXjfVIy9blgRbBAnb7PHI6ZIWtJKBearWgRJ0rWQ5W3DZZmeInF5seKM+WpMZn/tqPnsJR9ixctZMUVUzg2YMqYU74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725617714; c=relaxed/simple;
	bh=yuTXSlmRX4Qw1+f6JPjgZ/KY1kK4isY8fmEAZ0VxOYA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LYixf1varuErIE9vM25zlETvG7/0zj+5K+wHYjmsC25mq5itldtxgEYJbaD2mwJd+EvVWVoJHICm41SXjAdP5U0XdKULF4fC1gBFT9I41Cg6hrWOtB2PyixVbOrZkAKQ1OVhaQ8ZWtKa53TdoBiQV/Y4UvSsEbD4+MGQW7c65KQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TsTj0yvr; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=nEno1JU/; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TsTj0yvr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nEno1JU/"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725617712; x=1757153712;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yuTXSlmRX4Qw1+f6JPjgZ/KY1kK4isY8fmEAZ0VxOYA=;
  b=TsTj0yvrcC3GWOv0lGRG9FeFF00or6dkE/u0tOe7VfdYzFzGn7LAHjAx
   sIAUEw89+qKnghO6Qx8eWUIhuiQyIIEUdgbPpQuGkMk0CYmjn9ZFDjZGk
   FUryyXvNmWQyDKIECfUQGsRPSIz9gMUnDoWT3pWleqPoA58wK1RYXC+OT
   6ZeU1U1UwavyFa+0gdsuPtPB+BQpMd6zqjb78QkMdJTXSeb6W0tRzu+PW
   9WZqk3Wt2p1yCIdFiiGlJJPrldb9bNIuN9uwEtPPFn8p14kOboddSuDFa
   AL4487eAb2s1h2jR5hMQ5iqbBnQrx/rk8rm6u7tKFEBfzu9FmPMvWosii
   g==;
X-CSE-ConnectionGUID: ERH1vI45QFemt9EmCcxzuA==
X-CSE-MsgGUID: JHi7WqDKRS6H043vL7ncXQ==
X-IronPort-AV: E=Sophos;i="6.10,207,1719849600"; 
   d="scan'208";a="26465969"
Received: from mail-northcentralusazlp17010006.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.6])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2024 18:15:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zV4NDDWcSAJ9GTigmeGjRpW7xILsaE8YfnWhyf3bgaOhU87hM6LaMZ3dY7XeQL7Ms3la0LslYFxNG6xQPRRq4pfbDH/Cwaadu4yrBOfjsPu4JiXgkgf2Gbwxgv5Nbvrm8OBst4lhP+m2ViLoweualnEVimGGpyrgh1DE7Jsd8+h71DhmWdetOEAEsK5vOY2f2/6/UDPHYXaDMro2ES1lJVtHa/mjS5Qd5Cc9z/xEbnwnyL/hfWku7Oz9OivEAauxeewcMMIKEhxjPSaLRbHCSc8LN5I7RygjeQU2WHd8UDmMh8Yy7zdVCljmkOydYs5W1PwDQvYNglUhbyNH9ub2gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuTXSlmRX4Qw1+f6JPjgZ/KY1kK4isY8fmEAZ0VxOYA=;
 b=op+zy1kwWhpGQmQvduy4gEg6ZZ6F5d+eTlcdzTl0LRRmrCVBSwju6Ef4/HPhA6/WClcSOT/S5h5oTgWpxBr8iOvfWlJB12xWefqT96Zc0f6pyGt91AFl+kAfoWdc4sh70qNtbvDP2GUHl1scy6c6ntV9ymoFnDx/2NBbn/pRJZ0eFRzY/3fXfAJqOZcoPhIVLAQAZ4hgRQBs9LRSYsKsDn1xOMrQiWUJ3YFNujQj7KK1kuA6N9sAV5HMMysbZybL+FPe1ULCnw700lfg74H8UI/GXWPjeVoj2jas0ZEfFXaavfy9W/nqAMA5HBeFi1gC8BhYYPi6cssOSWxjwqnTBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuTXSlmRX4Qw1+f6JPjgZ/KY1kK4isY8fmEAZ0VxOYA=;
 b=nEno1JU/471O77Mhd1ai5WiEY8f8ztPVOcLm8MaW6ZeN9UCkALF9FEnQcYTob17+B4iVgQliWzJVdS+eCyopIeZD/pCuuIKCAkCDvd9GV/aL4506wLzYzl9Fe6UB/RZQPfO8SUr310FUcr2DRNdl6gtxZxbqi0srrQKnonqA0Ng=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH0PR04MB7495.namprd04.prod.outlook.com (2603:10b6:510:57::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.28; Fri, 6 Sep 2024 10:15:06 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 10:15:06 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>
Subject: RE: [PATCH v6 8/9] mmc: core: Disable SDUC for mmc_test
Thread-Topic: [PATCH v6 8/9] mmc: core: Disable SDUC for mmc_test
Thread-Index: AQHa/tp7LvDEZpXFCEy2pZ4IfTYjG7JKjF8AgAABAjA=
Date: Fri, 6 Sep 2024 10:15:06 +0000
Message-ID:
 <DM6PR04MB657533AE06955DBDEB4669CBFC9E2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240904145256.3670679-1-avri.altman@wdc.com>
 <20240904145256.3670679-9-avri.altman@wdc.com>
 <a8103403-caec-4fe0-a2cb-6ef262e0e400@intel.com>
In-Reply-To: <a8103403-caec-4fe0-a2cb-6ef262e0e400@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH0PR04MB7495:EE_
x-ms-office365-filtering-correlation-id: f325ba8c-0b81-4039-4871-08dcce5cc800
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZDg2c3B4Kys1YjBrRVlhUEdMM3p0Q2J4bEh4eU5MRVhWa1RiRE1iamQwd05t?=
 =?utf-8?B?djN6YTdOZXoyREFkNnNDZzJSOEIwWkxmNGw4b0RIM2xmU3laclA3bHpWRkJh?=
 =?utf-8?B?SjZtNlp1eFhrZUtQUFJQbjlHYVZaTzZHRlRHeDBsSFhJdVg0eW5KNDFOMUs3?=
 =?utf-8?B?SkxKVGl6eWpBbHVHem9wczNXUlVVcTJUbFJQcWYrb0V0OUlQNFZLdjJpNmtE?=
 =?utf-8?B?YmVVd0EzOUlUZDNlU2ZMUGxFVHdhZi90dE01RkdNdGk4cUdQNTlsR0F3TkJP?=
 =?utf-8?B?YzVrNmdDSkJna0FNWlRuQ0h1cGh3S3FicFo5RjJMSVVPaExSbFE4L3J2NERB?=
 =?utf-8?B?dWRUa0ZKd0tVY2tlb3JVUVJvVU1wSlU0czhkNm4wOVN5Nm9LUm5oSDNCb09r?=
 =?utf-8?B?dTlUd1NlcWd0cDJ1SGFzZlFtUTRQY1NERzJXbVNpZ3VBQ2VLUjQ3Vmc2eDhk?=
 =?utf-8?B?Wks3cVc4N01WV3QwZDNxaVR0cHE5dVRWcFovamoyM09VdHk2aVppclpvcDdM?=
 =?utf-8?B?UnVreFZ0czIyUnRncVpWcWdhNVo2MnRJdXJzL25XY1MyL2JHWTlrQXFYWnlh?=
 =?utf-8?B?SzVBWE1IVjF1S1RxcHVWTm5iY1RyK3ROVzhPRjBKNnVQdkZmbkRMSHcrYnpl?=
 =?utf-8?B?T29CUXord2FNaThPb0V0RTZST1pybFFRaTZPV0ZuRTBRUGRJU0lxR3AzS25n?=
 =?utf-8?B?aCtqTnVqUlhpczVtbzBpd1lBWSsxd2liZFlSSy9KYlFMZkEvb3N0WUpTMllD?=
 =?utf-8?B?SytLeGkzUG9McHkyakIwM3NLbG9vanBqOENUTjR1bE1UdXRMZXpMY0ZJVS9F?=
 =?utf-8?B?SW02dTk5RWhmay9Zakhnb3lhenVLblRWVGtaUFRpWjlMcXdVclkrTEJKZXJw?=
 =?utf-8?B?NFZCV2pDR28xYnpjYTNuMVNMRUI5ZmVpdmY4SjcwVmI0ZHlsT1RrbEpNalZL?=
 =?utf-8?B?ckxJZ3UzRDFhVjJVMGs3aG5VeVBCZ0wyaHBjUFNXcENpK0czUUZzUkNPS1pl?=
 =?utf-8?B?QThveU10R0c4YkF2ZHkrWUg0dDNueDZjWVZOdndMN0J5RCt5M0l3czhHR2xa?=
 =?utf-8?B?bGZrcEFQQVhHUjNGaEgzTUttNTNsVnlUT2M2d1RiM2FlNzV5UFZVNTNCOU5J?=
 =?utf-8?B?aGwwOW94RHRUN0hUSkNuTGdmbzh0OHJYb3dYSmJrQ3Q5dThvR1RzMkl5SFg3?=
 =?utf-8?B?dnlvdFE2QlY5WTFwSlVyZ2dVb2R1enVHbks3bno4eXg3NU53dHpwOWZmN1ZK?=
 =?utf-8?B?YmpzblVLNFhHQVJoNmEydFRRcVBuK3lOS3cwWWdxNmhMcU4xc01xZEFhOURZ?=
 =?utf-8?B?UGNiaGx5SGhRNGtsLzhBOFVSVDRCWVpHM0R4SE15dVZCOWk2MCtNODhDUFR6?=
 =?utf-8?B?NFJJd2FxVWJuM0s5U05sOE9odnEyckkwUHFRK0hRM1hnVXJPUXNHT0pFWExn?=
 =?utf-8?B?c1pGMFo3Ny9qdXpDeE9yMmRnVGNVRGJjR3FKVTVaY05zNXFkeTREWEt6L1pw?=
 =?utf-8?B?ZFR0aUw0ZWZJUEFienNZcnFxbjRNM3FVSHo2MjhKY2JIR1VVRUpvSDhWdHBs?=
 =?utf-8?B?UmhKVi9KYjd3bVh3bFZ1SzZzaU5yaGFOSHJ4K2VCbXZUVW1pN3I0VWpscXl1?=
 =?utf-8?B?NWRucVlqSE1rL1Jub215Y2x4OWJ6ZlFCWFFETUZqcmZGSTd3ZEwwcDNJQjIz?=
 =?utf-8?B?QWxmamkzYUhVWkJqbkpyS1ZqMHRFd25ENWpJaUtHMHlnc0lyOTR4R1FwQVA4?=
 =?utf-8?B?M3pZdTVzb1ErdUZibVBXK3dvVFozKzlvMzBReHpKQWJMaXVHTmhjRmR2ZW4y?=
 =?utf-8?B?d0hxbFZRNFJKZFVLelpkb2lTQTd4WmJvOFBrWTdEc2VidG9nV3hXaVp4YS82?=
 =?utf-8?B?eDJkbjFGcWxDc1BQbFBMYlRyUzJXQmlzN0swbXArVG44N1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YjNSSlN0dGJCQUNlTDQ3RlhsZ0NUdTRGYlE2Tm1nWlpiMXJIQlFqQ1ZjdjNz?=
 =?utf-8?B?SVdWcjMxY3lMbElBYm41OWIyZStuMUhtc3Z6bjlDVTZ4dStZYnMzcUFHL0c5?=
 =?utf-8?B?T3hIOFZkRkJ4dDhUV1ZNNm9ZOFA2VWRIZ2tWVS94bVZXaGIvakoyNmdKdU9u?=
 =?utf-8?B?ZXhJL1kxTnFDclZkaVRuOWxTcld0eGpJOGtEUVJsOWoxWmI1amhvY2RjdDFj?=
 =?utf-8?B?QWVuSmFkU3hHeWpobWFmUTlUbVRiUk9SaGR5OS9XOTlxTDRObHZBRkV1RmdL?=
 =?utf-8?B?NlppaFF3dWx5a3owakFVa1RpNDRVV3plUHhzcjk3cHIvNHBuV1FJNUZKMDZV?=
 =?utf-8?B?L2tYMHB2VDdXVTNISld0SlhRbXZHZFRvM0FiWU5uU0VieHdxbldOd1RkRTFG?=
 =?utf-8?B?bHdUM2lWazg0VGhGYzdYV2FHTm92WnJzMW9pR0RDekVsQVpSb3o1NFQ5OWE5?=
 =?utf-8?B?L0VpYUlxcGNqaksyb2NIc2NEMjdBL09aOU0yUU9rcHdCcGZuU1lxMTRmSHEz?=
 =?utf-8?B?eDhrSUplaVIvUWxDQ1ZmR0pTWFlpejJ6UFpCSUtHZGFndEx3cEEyY3AvaFRS?=
 =?utf-8?B?Wms5RHNlODB5cVF3MHZ2Q25BdXlPdzhuNEFyV0pSTk5zYXQyNUFQUEY5SFJy?=
 =?utf-8?B?eEJxR0M5cUp0UHlSaFRUZjVjcVhJQnZSd3AvanlXWmZoNXVneko1c2huQ3Az?=
 =?utf-8?B?VWtKVEp6Y2Vzb3FtMm5tZUcvdWNCK3gxd0VRVTBQS0I1dVg3NjlGUC9EWCtx?=
 =?utf-8?B?c1VkOU5PVFRzR3hKTzhJTmlwRkhMNjIvQWpVSWVsdUZ1R3JwdGZweXREQkI4?=
 =?utf-8?B?Z3VPVjdNZ2haOE1jSXVKUXFRemp5YVAxWkVjY24wR1lOeWRla21ISlYvVld1?=
 =?utf-8?B?QVRXa3g2VUtTZ2x6ZGc2UmVtQTdVSWVOaHYwVWdjSG1BejJOeHlxaGpadnk5?=
 =?utf-8?B?SlZiV1ZkT05OaWRIVHM5VmFBUkZ5ZHM1eGVkMGllRDRNNWJsakd3Z210VVRW?=
 =?utf-8?B?NGxmQnZJeWExZHpQVWVybnBKSWpXdEovd2RqTnh6NzF0c1N0dCs2TWJ2RWJM?=
 =?utf-8?B?TE4rTm44d0RpZHQwZ3pmMDBjYWNVVWRsSEFZNWxtM2ZFbnhMalRBeTJuZGs5?=
 =?utf-8?B?S1NaaHpkTzg3V0JGSjJsdk10bGs0QnVsQ3hpNWJDdVptTkgzL0syR3dRSStY?=
 =?utf-8?B?RFJoNUlSeWoweHVGSnhBZHZ6VGVtNmFCUVBTdklyalZ6dDhQZzFZZTYydGxS?=
 =?utf-8?B?bmdFSm5sR0YrazV3Z2NCd2trNHVDbUNTb0RLbVZWeWoyZUF0b1hKQjJSZ1VY?=
 =?utf-8?B?eFlibHViM3Q1N1k4eURKS0pkZnF3eklEdmlNeWRRaktRU2YwVWFBdzg2bUJI?=
 =?utf-8?B?ekc5YzE3Lzg1S3pZYUN2SGVhcWJWSU5zSHpkU3c2U2F2YzE3bUUzVHpwSm1X?=
 =?utf-8?B?clNNd0RnK1hWUzExb0s5bW12VVJNVVZLcGZFV1IxaWsvbGd1VHZILzg1djN1?=
 =?utf-8?B?YWJvM0RWTFhxU3gralN0WlBVY1JITGQ3Q3puWlVPUDBURldlaGZYTFV5LzM4?=
 =?utf-8?B?MmpCU0tsai9oM3lBOHRydzZ5VTAwV1JtK3FIaC9jejh0c2xOaitCTUhHbEFx?=
 =?utf-8?B?L0ljRjB1U2JVZlAwQUlKTGg1L045UWVLcWlzK3hGcHBpMDFTd0lmL0lEOElW?=
 =?utf-8?B?dTZDRHdzUmVCVllPUXFVY1A1TWU0WU1RNmtnRFFHNFpZZkNhVUFsWWcxemlh?=
 =?utf-8?B?UGF3Mlg1UnF2RElEZGNSUStWMmNFTFF0UmJaY3hISEhlaU5iRGN2SEFVZlVt?=
 =?utf-8?B?c3huOWwvWk85cERQK0hOZ0l0endWajZMRFBOSzRzeW5IWTVBV3hXUXNHTlhW?=
 =?utf-8?B?WkRJVHhJTWFDZUpybEphTGZ0Z0QrNlp2YzRMRmtuYnRPSlROMEVKOEFyd2VW?=
 =?utf-8?B?Q3RKN1cwMU5YbFZHSnhxNEJIYmRlaFVaeDJhTFlXd1VaOE4zU2VHYS9hNTRn?=
 =?utf-8?B?TkM0ZUs4bnhlSHdzY3U0dWJLMjlJVWU3UXdVMW9mVVU4cEpnaXE2UXhuWngv?=
 =?utf-8?B?NGY3cjJoSmw2Y0VQQzFZN2R4TXBtUm81MGNFeGlWa2N0OXB0aTNiaFF5VGJS?=
 =?utf-8?Q?LdXkNbcbbMw+Zfn+D5nItKp26?=
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
	1CyHn3Tr5ZyAYm85v1ps9giBKBAi9TNoEv5M7Hde87FZ73xNl3OFuqzPWByLDRx91/0Z9iW0DogYbNVEEB2u+LZ7QgkFLhLb7FVgDeTsO9fIXJ7N6PE84+nGvEIBaRF9PlUjr+4SoNTuZS/P4LnzNfNtYni2/D3+EjrR+Xh968q5LUEYfYCqEeruUvkj0quKqIoL8sO6GI4zej/w8Kgf8Q7fuKuREjKSGMt+n7xU9VcMlpEDm02W/xswAFq8n71KjMVsaEUy1/jjPDkuoKz+R/h7Vf74MUC8paUDrT2s7CCehs5QQNbaeQa94bilFwdzmZA6up7JdCwv4eyZBkSYJN/4gO8LDNz4eA434dI3WGqu81Pp1C6RmvHtAxj0jLG8dYVNw+rE8jkmXLKCD6zxsVkwU9egGQNYCwGh8hy3AU8fQF5/0OLRURDkBLOoe4cNzEK/N9u+MaKrcaX6svLEB2y20VVuNEE5xnppo3YWQIHZbkL23k0TLod+K0iZatRtzSxKtLxZxG6WtrxwLqWWczn1HoX7IB05HJBkJtcGRsZawU40+Zl5U94vv7/lWKDWv6H9t+Nx3S8mC1ZQ/DeP9G/BiSpyvZMKKIo1Q2zzIhcgBYLfE4MXmMs1mMgS6cu2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f325ba8c-0b81-4039-4871-08dcce5cc800
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 10:15:06.7452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NKO8Wjqi1EQrNAUj+tYi+4PYshi1L9hwUv9sCVgsVorpzjPhh7O0Or4MSJNKV6+mSkpKkJG9viq2KNa3eDbGbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7495

PiBPbiA0LzA5LzI0IDE3OjUyLCBBdnJpIEFsdG1hbiB3cm90ZToNCj4gPiBQYW5uaW5nIHRvIGFt
ZWxpb3JhdGUgaXQgaW4gdGhlIHZlcnkgbmVhciBmdXR1cmUuDQo+IA0KPiBQYW5uaW5nIC0+IFBs
YW5uaW5nDQpEb25lLg0KDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQXZyaSBBbHRtYW4g
PGF2cmkuYWx0bWFuQHdkYy5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbW1jL2NvcmUvbW1j
X3Rlc3QuYyB8IDcgKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9tbWNfdGVzdC5jIGIvZHJp
dmVycy9tbWMvY29yZS9tbWNfdGVzdC5jDQo+ID4gaW5kZXggYjdmNjI3YTlmZGVhLi5hMjhlMWEx
YWRlZDMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMvY29yZS9tbWNfdGVzdC5jDQo+ID4g
KysrIGIvZHJpdmVycy9tbWMvY29yZS9tbWNfdGVzdC5jDQo+ID4gQEAgLTMyMTgsNiArMzIxOCwx
MyBAQCBzdGF0aWMgaW50IG1tY190ZXN0X3JlZ2lzdGVyX2RiZ2ZzX2ZpbGUoc3RydWN0DQo+ID4g
bW1jX2NhcmQgKmNhcmQpDQo+ID4NCj4gPiAgICAgICBtdXRleF9sb2NrKCZtbWNfdGVzdF9sb2Nr
KTsNCj4gPg0KPiA+ICsgICAgIGlmIChtbWNfY2FyZF91bHRfY2FwYWNpdHkoY2FyZCkpIHsNCj4g
PiArICAgICAgICAgICAgIHByX2luZm8oIiVzOiBtbWMtdGVzdCBjdXJyZW50bHkgVU5TVVBQT1JU
RUQgZm9yIFNEVUNcbiIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIG1tY19ob3N0bmFtZShj
YXJkLT5ob3N0KSk7DQo+ID4gKyAgICAgICAgICAgICByZXQgPSAtRU9QTk9UU1VQUDsNCj4gPiAr
ICAgICAgICAgICAgIGdvdG8gZXJyOw0KPiA+ICsgICAgIH0NCj4gDQo+IFByb2JhYmx5IHNpbXBs
ZXIgdG8gcHV0IHRoZSBjaGVjayBpbiBtbWNfdGVzdF9wcm9iZSgpDQpEb25lLg0KDQo+IA0KPiA+
ICsNCj4gPiAgICAgICByZXQgPSBfX21tY190ZXN0X3JlZ2lzdGVyX2RiZ2ZzX2ZpbGUoY2FyZCwg
InRlc3QiLCBTX0lXVVNSIHwgU19JUlVHTywNCj4gPiAgICAgICAgICAgICAgICZtbWNfdGVzdF9m
b3BzX3Rlc3QpOw0KPiA+ICAgICAgIGlmIChyZXQpDQoNCg==
