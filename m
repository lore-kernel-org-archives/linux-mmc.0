Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986541C8712
	for <linux-mmc@vger.kernel.org>; Fri,  6 Sep 2024 10:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725617658; cv=fail; b=IFKOKI2cAuAjOQdnywLvk+eMyQ9webtWZQUO9YauhlQwmeLnNeLtZVU39hDXjXpSn2wzFQ6ZxtVTiUCtnT5IqVIMMlK1bNgEYdhEK73YFbpX+zTfH1C3POgntA4xOS0bsCqosyt8C+sYGZFXRp2yLE6ZqEPTrE7T8PVv5H0QEX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725617658; c=relaxed/simple;
	bh=zRLBeWyOvxtAkdGNb0d21Xp1bSHGbqqM1FGy04leGGM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GmmeFUUQoDTxqKxEuO87uXv9SbyQP7onTQpAxT0f/zgA6FOMlT16D63OPlJon0jgyrLXvFLSoB4nzLSTYssNoiDGvSaUJSYVJ1i4r/01ZllO6kq7W8GDQ+xkIq4IpRyNiUaBMgEwHP1OYJ+Uh4Gw24Hg8oXIGhrcuiWD7W4RtEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kaFPY5cu; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=uD2p7mKA; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kaFPY5cu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uD2p7mKA"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725617656; x=1757153656;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zRLBeWyOvxtAkdGNb0d21Xp1bSHGbqqM1FGy04leGGM=;
  b=kaFPY5cuReZGLOrOg00NzlFQs7j1HioFNRjWq5U9xYyWgFjcVxobD86V
   /UL0lRX8BRbfRdKkRu0dxVWPv4cX/HLZ1QNvOuSSoroEnSyFYiVadtgfR
   LAkoT0dLs2QCJoK2OAxnQKNfW59OWprVGCCDEClWfF5Gw34JPuBRig2RD
   4RY0XmjF0oeQwMp8cVm4042YkKqh4/8IpoTvEXe5hp62xVZca+GY/g/fp
   4l2Vy9tq+kaND6NJvLx6yXqQV21ED4gy96yqGwc6cGPnzuQuca9iPiSDo
   FSppJxTW7xepOLS+nnVEdtJnIJ+UgA5ijh68RhkfzbFQbSe2QBknTR74V
   w==;
X-CSE-ConnectionGUID: 3dFJKbaITIeec+j7dUi85w==
X-CSE-MsgGUID: 4nRPkwE8Su6UviqIKqauBw==
X-IronPort-AV: E=Sophos;i="6.10,207,1719849600"; 
   d="scan'208";a="26080906"
Received: from mail-westusazlp17012032.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([40.93.1.32])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2024 18:14:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7njCTiNjgPdtOkAOMPiK8Dh7sZ4fp3oEnSX4FQM0P9647nnjmXH55DaqyNuAJ1ZIqJFCzONf0MvCzA0akCR+PrVPAUdAyRVuRKd4BrjY5kxFfWdatPflSuTR3/SfjOLyzCx8xnjRjHtIoLVjlsplTqg+a2OaZqImDEo56SJDprqZLyOx5gB/jG7N6I+5HAdGy5vXt6ZP9EGhzYTgfK0ITMFKiievdh0LzkrJ9r839YSMwUYmLxYDo6+HiZFtdVgB0LctDhym2AfDuBskp51sBTbPkehxkV+1lCoM17cMOPNCJ/dQvh4KPDnOM0nfZdF4rv2xQKcrndpT/OPkErsDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRLBeWyOvxtAkdGNb0d21Xp1bSHGbqqM1FGy04leGGM=;
 b=Uolhgt90ztNnYbFT67DeQ/0CFdPJQotd8xiWGLyD+HEgPO4gI+zTBZbjXowkSaPnpQxDtFNJnwZRGQTNy+EABV12VzUQlw9c9a/k4l4L1HassDTakZrEVTdTNRDPPIuhA9rLpevW2mnU8LhugKqbdXVxZrxQ6e8HE2NyQ09mCxfkPvKXvvrEhoWyo034iQX+a812tL+NGdNCASEUeSm5Hp2hvacx3Ddv3PGVSvOV73NAZIR4izT5zk93r4IR5as8AcKxKLm+MLxtGgq21fqAYGFrdXXGc9xwZSfc3NXtnYwcH8tnprM74JMzrOgrzxYpgO10lkpTVsn+jb4L6ovikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRLBeWyOvxtAkdGNb0d21Xp1bSHGbqqM1FGy04leGGM=;
 b=uD2p7mKAhYWQA0cJg3TKUg53J9N3zSXodhlV7UIf7wxFKBXWd+c2IkTLpl7DeV3xfi66HkCnytfNwhk/rMjv1IP3P19/AuCjC8uC3sUq1HVX3CWNR1cotD0E8Qqcn4TZb5bhe7U2FonGHGmiw0+gYrstneE2kx+QO3SBVfpUv4c=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH0PR04MB7495.namprd04.prod.outlook.com (2603:10b6:510:57::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.28; Fri, 6 Sep 2024 10:14:14 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 10:14:14 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>
Subject: RE: [PATCH v6 6/9] mmc: core: Add Ext memory addressing for erase
Thread-Topic: [PATCH v6 6/9] mmc: core: Add Ext memory addressing for erase
Thread-Index: AQHa/tp0Sp78qIsDSkmEQO8d5QUI8LJKizcAgAAB1nA=
Date: Fri, 6 Sep 2024 10:14:14 +0000
Message-ID:
 <DM6PR04MB65756FB8EE93B2068E9EF4CAFC9E2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240904145256.3670679-1-avri.altman@wdc.com>
 <20240904145256.3670679-7-avri.altman@wdc.com>
 <1eb222ee-38f6-4791-849c-7c0376ee96f3@intel.com>
In-Reply-To: <1eb222ee-38f6-4791-849c-7c0376ee96f3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH0PR04MB7495:EE_
x-ms-office365-filtering-correlation-id: 6c49f5a3-0d52-4309-181c-08dcce5ca898
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VktZQ2JCUVNDMWNTcWcveS9lVlZFZ1A5Q1F0eFVrR2MvdStNc0FwZ2docmxt?=
 =?utf-8?B?bjZwYm9va0tkK2NDVDBTK2NWcUZuYVIyU1VpYXlKcEovS0FDSXJSb3hNeEJQ?=
 =?utf-8?B?TTMvdWFxRWk0anh2d0lZSW9ZRVJ4WEhUT2RGc0NtTHZLZkR4ZEQyMW9rVDky?=
 =?utf-8?B?aDY0WFlPSVpwaEZSNWFHVlhuVDdvQjgrSHZrOEtweVIwbmlpdFFmcUxMeFFI?=
 =?utf-8?B?Z0FaeXJ2YkhIM2s1bVdUS09XSEh0blpabFY2ZVRVanVtTXRoUjhGdlJWeXdw?=
 =?utf-8?B?b3RGR2JNa1drZkIzYUdYZDVneTVDK1N1MjlUSGhHZTlManNWRnpWMnBZdUVR?=
 =?utf-8?B?N0VRa3NmdmJ0aUlmeE9NQVd4N3RxZXV0ZkYzMUJib3RBNzl1ek5qNy9VVGRy?=
 =?utf-8?B?bWdtK3FXYkZkSElmTUN2Q2RTOU93bGpuMUtCWjB0WFFwM0k2UmRyUFJyNXB4?=
 =?utf-8?B?dThvSnVGQStBczNuemNxcmp3UnBEN1FDYUNIcXlYWStPRHpaYnQ2ZEs3d1Fa?=
 =?utf-8?B?WlZOZkcxcWF0Z1gvc244bmJaa2pFenRXZ0pGa09wUyszcGcrSXJLdU1SYi9V?=
 =?utf-8?B?Zi9hb0EvTHJwSVRDbE8vM3Z4WFdOUkhOdlhtTkVyR05Kc043U3lHNUtSckdw?=
 =?utf-8?B?SXNrWkNkeEd0SE9BVVp6S1l5K2d5TnFPZnhhM2ZTdzhvYmRVVUdzSVlGaUJq?=
 =?utf-8?B?bWV2WGZKRVJsZS9KK0JXdTFFMUZIVkREK2ZVV0xHVERJOGRwMlF4WnpDa09Q?=
 =?utf-8?B?N3VIb0FuOHZLZ0V4eTZjbEUrUVIycjYyUnNKT2xDeTRac0JjUkI5UVBObTN5?=
 =?utf-8?B?djVlUXpFNGlIcyt2TXJCV3VNeUp0NFNvK0xmbmMrTVhlNDZSclBLbVQ1MjNL?=
 =?utf-8?B?NjQxNk1BcEpVeUgzWk81TFZqMUVtZ1VmMXgvcmhacXNtOHcveW9kUmNxSlB4?=
 =?utf-8?B?dFRrMEUxZzhyVnB4OGo0SlRNMjhzblp3MFdaV3gwS1F0MGhQLzQzWWZDQXpu?=
 =?utf-8?B?VGFJak1jSXpNTDh3V0hHOUpBNGxoUTRiZlBNeVp2WUpWVUxaNFhpMDE5SmVW?=
 =?utf-8?B?L2pDbnlYN01ON0ZtRzFkbFNLZXdCNDA5OTVBdXlSOWR2RUZKdzRxK2ZuL1M4?=
 =?utf-8?B?d1EyQXVya0NVZ3N2RjRKRklTd296VDN4Z3ZaZXRuUFJFUVBGMkZuTGl3d0hW?=
 =?utf-8?B?aFBZSGxtY1RUVFhYUEQzTnJ3bitIc2d4RU9qMzNGeGFVaGQ4QVJQRHRoN2Ev?=
 =?utf-8?B?Tzh1dkRCSnV3dnRLaisxZHdLODd5ZVFOMERzOGFrMm05dzhjTk1pUmZRTm1L?=
 =?utf-8?B?V05aQXlGTDFrRVZhRUI1cXpFMEQyKzNFTyt5cWxISCtKdEVEZG8yRzBRYUFw?=
 =?utf-8?B?cllUM3ZNRFEzaHRKTVVDeFVqNE5VMWtEeEFqemh3elpzK3NMSjhia2FFQXh6?=
 =?utf-8?B?VS9vT1NuY1NKSGlRNnRrd21FTG9zcFVXWlVUdWQ5QmswMkRqOURVSDZxUmwz?=
 =?utf-8?B?Zk5zMHpyd1BrMWZVclV5Y1oyamdpZ3ExYUw4dXB0SjJvUjU4eU9zZ3hDS1Za?=
 =?utf-8?B?dE05aU1IczhYNW5pT3NSYWlPWkJDamVWUFRlUVdIeXJHZTJRNGJIRTlXZllD?=
 =?utf-8?B?cUVrNjBKYzJ3SHlYWS83RERQRzE5M0Z0MUVWU0gzWlVRckJyOUYxOURTTUZF?=
 =?utf-8?B?WDhLZGdwZWkxUytIQTVwREJYckU4NFUzRVNvcXNieEZ0RzY2MmVUaWdmSUhw?=
 =?utf-8?B?UmJDejdtS1RoeXBoaWg3Wmp5NmJkNFVTcWN0cjZuV1pCdVNxY1dQeDd4RGNK?=
 =?utf-8?B?VVg0eW9Gd2l2U2oyNytZSG5oU0NkUTdVWC9ScDllWG9iVGtaZmptUlVmUHVo?=
 =?utf-8?B?bGxwOWJLWUNxWUZqNjE3TmR5YjFiS2JsTHBUS1lzUU1WcEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eE5KVkxIK2ZCdHFqejFrYVV0QTJFajhiNjFGbHE1SGFpVHcwYi84OXNEVnlO?=
 =?utf-8?B?czZZUkl1NlNTV2g4SDFNTHNEcFVWejIrODhYNGNBQTBqQnRQbXNTVjdJV0Jw?=
 =?utf-8?B?a05XL2ZRRmVqcktNWDdOemlreDJodCtkdHAzcXh0SG1wNXFnV2VKUkN5RnZ2?=
 =?utf-8?B?MHZrVnFnMlZWbDEySWkwaUw3SHM4cGozd3JYTitmT1AybkZlMk9SeHBXTGht?=
 =?utf-8?B?VHI3b0tEODJVR2VJa1UvQ0xnOFJ6eUUyNTNqa1FrRXJRR21VNGVlNExXaG9t?=
 =?utf-8?B?djBRT1pGT1Q0Um9kbzhiSXhwMDRIcHA3MEEwaUw2NGVEZVczQ0czV3JybHRI?=
 =?utf-8?B?NDYrN3UzL0QyZXEzN0ErTGp5S1ZuWWpkNGtJRTlBYlFBQTJnaFlmcnUzcmlP?=
 =?utf-8?B?LzdPcWtjVGdKSzNRVWkvS2RmNTd5NVdPNzNkYXU4dW1lRFlkTXdXaTJwN3U1?=
 =?utf-8?B?WkkzQzUydUZ6MzJ0YzNJL3ZRL0tMM0FVYkVUM0JiTFl4TGN6TVJCd3R0NGpW?=
 =?utf-8?B?L2RhRHBEZEllRExZWW9lZDhOVzgrcjZkOXJZTDJJZkpKRG9ORTNJRitOb2xi?=
 =?utf-8?B?bmpWNXpneWIwNTY4WW1scmwrYjhPNXgzdlRNdHhOY0xNV2dXREQ0cVlYU1BT?=
 =?utf-8?B?OVVYZ0h2TlQxZkJPYnhaRmUrd0Z6N0NOM3ZNSmFia1hHNGhnUEdNNFR1cVhG?=
 =?utf-8?B?bzlobDdwSGFsbTI1ZWhRUUxYNVRtMjlPQmIwRlNRNDdWbjBQcmxPYVlGcFpN?=
 =?utf-8?B?MFRhR3N0LzZUL2ZxS0RLaEIydEVyL3R5TUd4YzVNRXpVbUNiME1XRkwwNkwr?=
 =?utf-8?B?MXV2dHh5bXdqdjJZSHUyVTBaMHZKTU81M25pZHhsdjRQRVgvNWVGdW9TV0ZI?=
 =?utf-8?B?bldrSzdVTDZsclJjNnU4RW1LSlpXbjhTR2kwUW0vaXA4OWJudG1KczFSejRs?=
 =?utf-8?B?TVFvaEVmeFpmSkMxTy9hZEtGT1l5a2N2SDVyblc3Mk0yOTd0T09pazhqMXVa?=
 =?utf-8?B?eFgrZHZBWTRzK2VLb3BSWGNnQytITjlQaEVOTDB1dk51ZGY3UGpYSlBBWkha?=
 =?utf-8?B?RkUwMVQ3V0ZLSUJ5akV5ZmZjTE1Td0hqbmNMMUxDK00xazBjMFRmNXRIZG4w?=
 =?utf-8?B?SVJBTzlZY1hkUGhpeFpvRGRYdVdGQnlJUTNTWXMwemhrbmFJWnU3ZlVLdUZm?=
 =?utf-8?B?SDR5NGtWYjBuSnhMTFdOd0txb3BaQllJanFZbWEyYy9aU1hqYXc1OXEvRlN5?=
 =?utf-8?B?MUVQVENwaEI3M3BVRXBoamZKakltaFlzVEtiOW5wY1hJNnBpalpqNXNNNHJN?=
 =?utf-8?B?WEdrY3A3WlRLSmVobzJLeWFLN1NnWjNYaHMvSG11UCtoblpLYUVteWNLNUtz?=
 =?utf-8?B?cTZXemdMcndkSkJKYkV6YUszM3NqdGZpUXdkVExaQmkyeTJ6ZU9iMDVELzBi?=
 =?utf-8?B?MExRQ3ZDNjRZWTRPVklFRHJhNUJJNkJLbmcvRk9hT1JOY1l4Zk9VUTNITkFQ?=
 =?utf-8?B?V3I1aHloY0IyNkhTaGJiZW1INGdubVZwRXRKQjI5ZXdlSXl4LzlzR01EaWF4?=
 =?utf-8?B?TTBJQVpKVnZvaXRxNnoxeGhUVmZtL1gyKzg5MjhKTEtyZFd0R21ZYUpwRGoz?=
 =?utf-8?B?UWx5c0xpY3dLNWpVT3cxNklKaEg3QU5YbGE4eEpuTm83RlE5cXJDU2dTUzVs?=
 =?utf-8?B?R1lLQUNacld1NGdUMW1STVQvdzJ6VE9ZQ1V0TlpjZVZxdGRHK2NadVh2MmNE?=
 =?utf-8?B?NmN1MElwTlVTQ2JkRXdZUm5zU0ptVGhRWnF0RE94UHcyWFdnZHBiVUJzZlJE?=
 =?utf-8?B?SWZYUkhDUjRrN2RDZ01Cd1FoNU9ucnMyMnhkbHhYSlZjcHJ0bU80cGxuWU04?=
 =?utf-8?B?cVRvdjFRcHlNTUJOcGRHMk5GUDRkM2s2TFJVZlhRWkNOajVEMzZvNTdYY2ph?=
 =?utf-8?B?YlpCOFppVTcxWmtISDlCQ2doMlZIcTAyWGVhM09GZkY3a0JKRm9halRJQ1hG?=
 =?utf-8?B?bHVsWVc2VWFTVGNqdlZlM0todDNFTDFXOEp2dDdDei9tc2VNVDFOelFlcW13?=
 =?utf-8?B?b2FqUVBMa3JjL2h6NjI2SUg2OUU3NnFVclA0d3F6NVZkeC9aYUpPVUticDha?=
 =?utf-8?Q?XN+aZwUTtVQm15y/GwdJ3TUxq?=
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
	fyijIoW4K+1pjNxezygGwNvVdtcdhwyGxi/PmXpWV63XP3jN9/z0xKnJzm8G5uwNnI1LMmfjPHG8aK9WtbIO+X7tpkXtEPeDJpe4/MHZjluk4LBwrRg2zsIVPoMWRCyW/KYeIKsTNDv8iaxk+ObBXiubfXC83emxHNmR2iWjWkSMg7D69YBS76AS8nybTxvr06LFpQzGkvOO6gNivDOA+HO4Y5DvcHYO4aOBBRGGlVkxXA5Eu8oaH8DzBdSz0i5mi82oNzjIaRv10Kg5+oPvFXqPnX7Gj//7gvX6Q+XL+jGtF5InSMWjwH2Blp+adwpD72VY2NvgH0SfwBTDYZ96tlLAVVIFyZz5tP57ZArhg2l8H1i7rVcuQpDbx29Cfuf72Dn2xrekG2CR3bwSuDsp/0Xxj8KvL/lTezONqUGcp07NLFRIRi1VuBq2/jbJFbCxort/I/+9vnlUq4lrWCdR+/alp9iHlNs06d8T4xMM5YZQ9b9FUDsiWSsYTnRGBR4Rse4IDCgH7Q4gUDtHX+fOEzdLTj+y03S5usTpRq4+2ozG+3XyKYKVT92LhHB5Xhksm9yygGcL8jEGHca6OJnebADe8phXezTnvk+jdj7jxYrexCOW1Vx1LtIpmn0r2sGq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c49f5a3-0d52-4309-181c-08dcce5ca898
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 10:14:14.0363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vA7h9BRX2Td2uhUp1VtDgDueS7+jNu+Byu9qda5GUAGBXncYhI/DvN33f9bO3nzGCY4ANk3Is7TzyIKqe4HH3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7495

PiBPbiA0LzA5LzI0IDE3OjUyLCBBdnJpIEFsdG1hbiB3cm90ZToNCj4gPiBDTUQyMiBzaGFsbCBw
cmVjZWRlIENNRDMyIGFuZCBDTUQzMyB0byBjb25maWd1cmUgMzgtYml0IGVyYXNlIHN0YXJ0DQo+
ID4gYWRkcmVzcyBhbmQgMzggYml0IGVyYXNlIHN0b3AgYWRkcmVzcy4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEF2cmkgQWx0bWFuIDxhdnJpLmFsdG1hbkB3ZGMuY29tPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL21tYy9jb3JlL2NvcmUuYyB8IDE2ICsrKysrKysrKysrKysrLS0NCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9jb3JlLmMgYi9kcml2ZXJzL21tYy9jb3JlL2Nv
cmUuYyBpbmRleA0KPiA+IDA2ZjYzZmJhYWRmYi4uOGQ5ZjJjNDRkMmEyIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvbW1jL2NvcmUvY29yZS5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvY29yZS9j
b3JlLmMNCj4gPiBAQCAtMTY0NSw4ICsxNjQ1LDE0IEBAIHN0YXRpYyBpbnQgbW1jX2RvX2VyYXNl
KHN0cnVjdCBtbWNfY2FyZCAqY2FyZCwNCj4gc2VjdG9yX3QgZnJvbSwNCj4gPiAgICAgICAgICAg
ICAgIGNtZC5vcGNvZGUgPSBTRF9FUkFTRV9XUl9CTEtfU1RBUlQ7DQo+ID4gICAgICAgZWxzZQ0K
PiA+ICAgICAgICAgICAgICAgY21kLm9wY29kZSA9IE1NQ19FUkFTRV9HUk9VUF9TVEFSVDsNCj4g
PiAtICAgICBjbWQuYXJnID0gZnJvbTsNCj4gPiArICAgICBjbWQuYXJnID0gZnJvbSAmIDB4RkZG
RkZGRkY7DQo+IA0KPiBOb3QgbmVlZGVkDQpEb25lLg0KDQo+IA0KPiA+ICAgICAgIGNtZC5mbGFn
cyA9IE1NQ19SU1BfU1BJX1IxIHwgTU1DX1JTUF9SMSB8IE1NQ19DTURfQUM7DQo+ID4gKw0KPiA+
ICsgICAgIGlmIChtbWNfY2FyZF91bHRfY2FwYWNpdHkoY2FyZCkpIHsNCj4gPiArICAgICAgICAg
ICAgIGNtZC5leHRfYWRkciA9IChmcm9tID4+IDMyKSAmIDB4M0Y7DQo+IA0KPiAnMHgzRicgbm90
IG5lZWRlZA0KRG9uZS4NCg0KPiANCj4gDQo+ID4gKyAgICAgICAgICAgICBjbWQuaGFzX2V4dF9h
ZGRyID0gMTsNCj4gDQo+ICd0cnVlJyBpZiB1c2UgYm9vbA0KRG9uZS4NCg0KPiANCj4gPiArICAg
ICB9DQo+ID4gKw0KPiA+ICAgICAgIGVyciA9IG1tY193YWl0X2Zvcl9jbWQoY2FyZC0+aG9zdCwg
JmNtZCwgMCk7DQo+ID4gICAgICAgaWYgKGVycikgew0KPiA+ICAgICAgICAgICAgICAgcHJfZXJy
KCJtbWNfZXJhc2U6IGdyb3VwIHN0YXJ0IGVycm9yICVkLCAiDQo+ID4gQEAgLTE2NjAsOCArMTY2
NiwxNCBAQCBzdGF0aWMgaW50IG1tY19kb19lcmFzZShzdHJ1Y3QgbW1jX2NhcmQgKmNhcmQsDQo+
IHNlY3Rvcl90IGZyb20sDQo+ID4gICAgICAgICAgICAgICBjbWQub3Bjb2RlID0gU0RfRVJBU0Vf
V1JfQkxLX0VORDsNCj4gPiAgICAgICBlbHNlDQo+ID4gICAgICAgICAgICAgICBjbWQub3Bjb2Rl
ID0gTU1DX0VSQVNFX0dST1VQX0VORDsNCj4gPiAtICAgICBjbWQuYXJnID0gdG87DQo+ID4gKyAg
ICAgY21kLmFyZyA9IHRvICYgMHhGRkZGRkZGRjsNCj4gDQo+IE5vdCBuZWVkZWQNCkRvbmUuDQoN
Cj4gDQo+ID4gICAgICAgY21kLmZsYWdzID0gTU1DX1JTUF9TUElfUjEgfCBNTUNfUlNQX1IxIHwg
TU1DX0NNRF9BQzsNCj4gPiArDQo+ID4gKyAgICAgaWYgKG1tY19jYXJkX3VsdF9jYXBhY2l0eShj
YXJkKSkgew0KPiA+ICsgICAgICAgICAgICAgY21kLmV4dF9hZGRyID0gKHRvID4+IDMyKSAmIDB4
M0Y7DQo+IA0KPiAnMHgzRicgbm90IG5lZWRlZA0KRG9uZS4NCg0KPiANCj4gPiArICAgICAgICAg
ICAgIGNtZC5oYXNfZXh0X2FkZHIgPSAxOw0KPiANCj4gJ3RydWUnIGlmIHVzZSBib29sDQpEb25l
Lg0KDQpUaGFua3MsDQpBdnJpDQo+IA0KPiA+ICsgICAgIH0NCj4gPiArDQo+ID4gICAgICAgZXJy
ID0gbW1jX3dhaXRfZm9yX2NtZChjYXJkLT5ob3N0LCAmY21kLCAwKTsNCj4gPiAgICAgICBpZiAo
ZXJyKSB7DQo+ID4gICAgICAgICAgICAgICBwcl9lcnIoIm1tY19lcmFzZTogZ3JvdXAgZW5kIGVy
cm9yICVkLCBzdGF0dXMgJSN4XG4iLA0KDQo=
