Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4D81BD9D0
	for <linux-mmc@vger.kernel.org>; Sat,  5 Jul 2025 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751726220; cv=fail; b=Go2lHQA6AHkj/yGzgI0goYwuPq1ePhaQpIBxdBP8Otfs+XL0v6wXJfA7meQerFK150OF8IOAgolh0OvYkxxwXYefHwydtO5SUGbca0ROqyD5XnLcAfu8keirHxQ/cFrvkZQNxjJ2HKHZsOekXeRl7CGT+NsjDlQboEF/t/ePH5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751726220; c=relaxed/simple;
	bh=q1zz7/hL1AQpDSNGsEnn35c6aEBCiBkQ73RLBZMCL9c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WhRkwzO8rj0jRQdp4jzw6XEN3OnP/RQ2HC1iMEjpjeq5gSOsxftkDwVCjK3gc/+asvt6S3hpDQ/LctyeGIJA2pmTjW1zFf5mJdNJ0WBP136P0/64M+UWZLAKo9WOoWun4jwAL+X+xElvrjPdhLe0ykpvTZGdVUBDCH8Xm/e5HTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=FMjcsKXa; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="FMjcsKXa"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1751726218; x=1783262218;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q1zz7/hL1AQpDSNGsEnn35c6aEBCiBkQ73RLBZMCL9c=;
  b=FMjcsKXaRD9iNPs2Ts0zIfg3mjxkOfrNzNG0AkbNeroaQPBzKOUeU7a4
   cs3C69XjVRWZBCoXD8gbMM28g9n0ip+HarDQosD5T5gwphHRp0O07AH2s
   zeCs4Tpc/4ZcdV8lAxfwXjPNNa4O0znE1tIONuAf7lShZSQ47rM5oQf2b
   cmC6N0r3ZdydUqhiwrscLADEBk5VQcKfvFU1C2zdZYRYrIeOS4C0hSsdw
   HCXODs4hEtZ+nHGyoV6FlHpcddbkxsacqo4q1TN56hYdFy5my0VE3wlI7
   jo2tKGaiC/2dv1bvJEcDZ644PKFPwt/JXJxuzwhHQB72+F3BVhm/sN3GD
   Q==;
X-CSE-ConnectionGUID: 2R14mro1Q76yF9QWnWWl1w==
X-CSE-MsgGUID: ZzGzqPkbQhmkHahXU5jDOw==
Received: from mail-mw2nam12on2139.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([40.107.244.139])
  by ob1.hc6817-7.iphmx.com with ESMTP; 05 Jul 2025 07:36:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmxAeoLtYMuSmQ9v1uVMYI7qAd1Hcbe5oqwcZmwUf4C0Ghh4US1z+JB1O9EbjvBHwS/+8qrerJN8KmHCuVDsQJCr9oY4VGZC/BRDjjX/F+qqPsWX6M7+VMVcFPrERO5lH6zFYdcnC/Vv/qkafoYtzEobxlytFN5AvrHviEPNthVWuhjm9pN0YhcUpePEnOuJ9nEu1GGv7+WOwAqGvxgFyBa1j8HySzcxnNJhYqOlKmWtZVPAZaPx1KIVh/zhCW4z/+/fHS+Ev+nRsq2CEDq40M6OEsH1/rhJtO5jRLwHbdgxAC1o3Fo4shUefdzo1wzIRIWhZX4nha+BijF0fhfLBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1zz7/hL1AQpDSNGsEnn35c6aEBCiBkQ73RLBZMCL9c=;
 b=e/YRTQhHm6U/31n7c7x7/OdJo3yaT1D6kRpSjTehrWrFZhXDmQgM8bsnDl6uwA6nyJvrlsX0Ea5YXIlWxPC4NN990TXQnVb6FGpTd7LqkuH5xm4kS9RA1KVMNzgTd1oocIyUNeiv+z3z1hDDP+k7U+2mg1oLhQErzX03ErUE+YwLkBvHH2qetjZh5WJXC2o9nNzGVW/lAtwZJi9mHkSlpOI9369CPB3BKA7O+UQPb2gbKHI22vtELamysPbKW1dJ9vCgtnVq43vBB+x5cdxwAyPPuWlCJqLH98yGJ6x4I6vU8x22EUL8G0EkCrZbWeIYohdc3boYz9mA3oOp5aPB9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by MW5PR16MB4617.namprd16.prod.outlook.com (2603:10b6:303:197::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Sat, 5 Jul
 2025 14:36:47 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::3f03:3b5d:6737:8231]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::3f03:3b5d:6737:8231%7]) with mapi id 15.20.8901.021; Sat, 5 Jul 2025
 14:36:46 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sarthak Garg
	<quic_sartgarg@quicinc.com>, Abraham Bachrach <abe@skydio.com>, Prathamesh
 Shete <pshete@nvidia.com>, Bibek Basu <bbasu@nvidia.com>, Sagiv Aharonoff
	<saharonoff@nvidia.com>
Subject: RE: [PATCH 0/2] mmc: Fix max current limit handling for SD cards
Thread-Topic: [PATCH 0/2] mmc: Fix max current limit handling for SD cards
Thread-Index: AQHb4PkOT2gvXeCCkU274biaQkvqTbQhsOwggAAjcgCAAdxQgA==
Date: Sat, 5 Jul 2025 14:36:46 +0000
Message-ID:
 <PH7PR16MB619675A495EBE9DCEA75EE28E54DA@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250619085620.144181-1-avri.altman@sandisk.com>
 <PH7PR16MB61960E4CD85BB8076FB1977DE542A@PH7PR16MB6196.namprd16.prod.outlook.com>
 <CAPDyKFomV-QiqHvh2ywC9GGFUhJmkoKoBn6OBNErspFG4fi1ww@mail.gmail.com>
In-Reply-To:
 <CAPDyKFomV-QiqHvh2ywC9GGFUhJmkoKoBn6OBNErspFG4fi1ww@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|MW5PR16MB4617:EE_
x-ms-office365-filtering-correlation-id: af5a5a6c-992c-49a0-b02f-08ddbbd15ec0
x-ld-processed: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4,ExtAddr
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MUNramhNeGttbFZqQ2lzSGtWUXN1M2Jic1MxbXc4MDBCZG1oZE9xdUJQS3dk?=
 =?utf-8?B?T21tTnduT0Rrb2JzaEJCdDJPTk50TFVkck5JMndsQXovenhJeGEwSkV6aWRR?=
 =?utf-8?B?OVhxUGRiOHN6Sjk1MUlySGVsOWpPOEpFbVBMV1E0eFMxRFBCcitaVTB3d3BR?=
 =?utf-8?B?TVUzbmJjZW04NmgwZXB3Wno2LzMrRndCb1RGeWJaWkFmSTNycTdlRlNrU3RN?=
 =?utf-8?B?cUZZeUtneUw2cHgxTVBHb2UrQ3ZKcjVJS3l5WnpTazVaMFNkNUIyTXNxc1Ni?=
 =?utf-8?B?YndteExBMk4yblVaZEJRR0F3dE5ZemZJby9PQ2gxaGN3QllEaloxbDVwT2Na?=
 =?utf-8?B?NVRqN1VXNHRzSEpyNDBXaHlqcEI4UjhoaE8yc3dnWWNGb1lyR0pwMkIwS3Y1?=
 =?utf-8?B?RlBCbHRMeTFkcVhLS3FWaldyMXhBZmRzS1dWeXlCVWllKzYxSmt4THY1d0Zx?=
 =?utf-8?B?cWtQU3RMU24rdkJ6ZmRvYXlYYnBHYWpZeTREMFhMalNMSVBieCtQUEdPaXpT?=
 =?utf-8?B?N0dTQk84K1Eyd1hxSm5FZUxqQWJzWVFzaUduZHlHZU0yNmxpSFhESHdnLzl2?=
 =?utf-8?B?dHdleXUyUmVGUXVYT0VnMTdQR251VFJZZW1MVXhDd091cFJYR05mQWl0T0R5?=
 =?utf-8?B?OGEwbGhZZlNUYXN6K1FoYnJKSGJ1TkdhOUc0TVNuSDFrQmFGQytjQ1BkcWkz?=
 =?utf-8?B?Kzh5Y1JmMVNWNUtVSHhQajFXSVV3UDMrMHJNM2RQb1NGNnE3K013TDJycURP?=
 =?utf-8?B?bHpQUm8zRVhBUThOQzB5b2U2MWpsMmZjTlZzMjBkNmFydDY2aFpKdExYeEtF?=
 =?utf-8?B?SzFzRmxzNEM0VG5ZdnBqMDRoalFOVkVMR0tCRkQ5RzN5QXhCZTRUMWVobk0r?=
 =?utf-8?B?S0dDbnczbnF6TDQwWkJpTkttd0pSd0p4S21BZHAvYUk5SkFmTVZnMTdQZ1VB?=
 =?utf-8?B?VkRidDl6cU8xdFF0SU1CWjhCZzdyaWpnZEhFM01GQmoxRU4wTW9nU1lXa1RQ?=
 =?utf-8?B?Yy8zcWF3am4xY1BpMUtjYXZEZ0ZpWXM3VHAvNTVUelpjNFZ1b3FBTldoZzBn?=
 =?utf-8?B?UzlHak9uSm1Qbm93cStEb3oxSitHTFlySUN2c2Y1SHNNNmVVMG1XdnhHcFVP?=
 =?utf-8?B?b2NaRkxsSXdwUFVrY0ZqUWFVRS93V3VWNWxyTlRpcTlNSWtiQm8zdDdxVkJl?=
 =?utf-8?B?dC9QT2x4UXpyRTI4ZGJoSW51elFJaG9wQlNBcFplQzJ2M21ERkhtTnIvMDVI?=
 =?utf-8?B?SXlDcFlLeWhLMWwvVFNkTE5VelB6dTBjdVdmbDJlUFNBUmdRaUNUT3l6Qzh3?=
 =?utf-8?B?Qy9KaHJsNFB1L3lGRDFjRjNXM1dtaEJKdk9zdHo1SW0zS0FZdHFFYnNGVjBV?=
 =?utf-8?B?ZlF5MHZQa3NQQjAzM0tHME9DcnJBWkdyZ0NjL2czSlAvaVhFM25mM3BoZWg1?=
 =?utf-8?B?cU9ucTVOdENXUUVpdjE0VExGRDcwTHlXeVV6Myt2S2ZGRytaQUlOTmNZTXl4?=
 =?utf-8?B?S0ZjV09LSSsvVUkrcFVxL2kvbHpmZThDM1MwcVQvdHNMOE5kS2FBL2FjazBE?=
 =?utf-8?B?Rnd2QnJIMElrMElOTmVnbDdNdXNDRVV6V1VPWUFPUlhCK3RHcFpQL1J6L1pT?=
 =?utf-8?B?eEtGT3lrZ1hsQTZSSFpzeWJyUDNBcVlvbVY1ZldNNDR3aldSKzd0UmdiM3BM?=
 =?utf-8?B?OXdsUlZ0Uzd2L0hna0pIdlRid2ZvR0w2WnR4dGM0cDd6NFJ3d2JLK1QrdlRw?=
 =?utf-8?B?MWE5L1FyS1M0VHI4QUdZVzZCTXJkUm02clljWW9YZStDeGcwNnBxSkxVUGNp?=
 =?utf-8?B?UjRRZXZiZVg0YmVaU2llbGRwcVNjbkJQMVZzT2ZxQjZxREJ1cWt2R0RBbytJ?=
 =?utf-8?B?L3dRcFYycktxNnpkRkFSMVBTY1prQnNYYnNUYnBLU1pRQnFXUkhldzFhTnNU?=
 =?utf-8?B?azhRUXg5VkVqd0xCMFpSR09jeFNuTE5yYmFyZW5WOTRmWXZmS2EyNStGclE2?=
 =?utf-8?B?anB1dXJ2QUhRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a0tjUHVkM2FIQllXNUhJdTNyRjVZaElYUUxWNnZ3UFRjdlBtQldhak9WSnRT?=
 =?utf-8?B?ZTNsdy9janZFNkI3RnFRV3RrS0V1VHlQU2wrNHEydElyeU04bUZLdzQ5dVV6?=
 =?utf-8?B?cGJKaUxQNFhEalY5NWxBa0QrZ0N4Vk5PUEMyWGtnM2VVcVk2RkpLcTI0bWlF?=
 =?utf-8?B?cWU0Y3RaYlhYajh0YXJKOVQvZVdKeUhYSEc4eDVTQ0VGaWRDWVMrQTVmU0xU?=
 =?utf-8?B?T0JWNGFDdTB4TG5jR2dKbitiT1d5N0lsNHo1bU9iNXpUb3Bqa2NtTFlMcmND?=
 =?utf-8?B?TFJaMTZ1RlRKN0REMnY3dW1STWFITnNhUnUzU1lXcVdaUDVwRlBOb1FFVFRr?=
 =?utf-8?B?MWN0cTZYZldPa1NDREJTT1U0TmNPMG5lZTFpVHdqR2RBTUZHZU9lS1JadHJw?=
 =?utf-8?B?LzJidkwvTjJ1ekNyL1lTbnJMci8xcTJ3UlV5QnVvNDFNRERzSDAvT1RBUUFt?=
 =?utf-8?B?VmEwdlFNMThEeDhlY2ZoNThvSEZCWnBnaFp0Um80d2g0djhJcVkwdW5rTWdu?=
 =?utf-8?B?dVp4Ym41WjV6bkkrU1BLbFdSUWkvaDZUUmFDNUdBWmUwYk9mekRPSTAxWnpH?=
 =?utf-8?B?ZWdscEtxVld5cldjREp3ZkpmSm1KTzVXRUMzSWVFU2YyTnVMcTNBQjRKS3dn?=
 =?utf-8?B?aFdwa1hLOHRaWlI3N0c1UUVIK25MUXFRYUFXRG9oMHZlZlRHc3hGd1VQb0JT?=
 =?utf-8?B?VE5lRmV1NkN3VWhFQlBxcmtmRFg2VlZ0VEltV3Y3ZWc1VTloMENkM2p0bFh3?=
 =?utf-8?B?V2RVUTZxUk1KaGxiTWlzckhoSTZPdzJDUGpKdnBITTFoYVZpTmprenU3Mk0r?=
 =?utf-8?B?N09wNHdlS3l0Y1JUSTFBWnNlRllyVWV0eG1ZMXc3eGJXSU44SVdxcDhnclZV?=
 =?utf-8?B?SXRyb0NKVVpDK3JaMVhvTFFaYjc2UTdTWGR0RWw0OXJjOTZ1MjlTRVZzMkZP?=
 =?utf-8?B?STdtc3ZYRU9FMHlSYmxydjM2K2JkUUJWV1pUWG9WYkx6T29TODVaWjg0dWhT?=
 =?utf-8?B?cjlRRytqbzZBcE1jT3FOeUNvS2Uvck5HcmVMVURyVnhZVXJpb0NmK2k1RTJi?=
 =?utf-8?B?YnUyYWVQRnh5MG1JMzk1SC9FTDZHVGp5Y281M25JS3VxMGpSVm9aU2lBMW5J?=
 =?utf-8?B?ZzdtdGFKVGNPd2hoZUtJL1h5WFZTMk43aWorQ25ZUjFwRE1ZeGpPcVM1NGtJ?=
 =?utf-8?B?Uk9pVFY2cGFScCttZXNKRTUweThOZ3hBcHRpL1F6Y2c0WDVsK2x2TTF5eGJK?=
 =?utf-8?B?Q2gvVnVCTjlJalB6bmVldHlRNm1MalFJRVFrdUdON0RVcUMyRmVoYlE3Njls?=
 =?utf-8?B?WXFHUVkxSEpsRHdhNEErZDVaVUhkUDlYb3RJcTlyZnBzdm1sdW50WnVEUHRQ?=
 =?utf-8?B?MmwxS2l2ZVJTWUw4Tnd5bjZSWStHTDQwTUQzblhrWGpTWXNsYWNEMWhYS0JE?=
 =?utf-8?B?MnIxNzhYT1V5UVFGeEptMkdheDE0V1ZwUi9GVW1FU0MzTS9oZ2VITGk1TjhU?=
 =?utf-8?B?MnpRV3RET1BnZzMrQlQwN2V2U3BHeUFYQ1pEWlRLT09WSDVOeUZNNUhlVWVm?=
 =?utf-8?B?eGt4SkpwV2JGc3hHVW9kQmVoQU5BamVHa1psVXhVUHdQZWljL1g2dmdyRC9Q?=
 =?utf-8?B?ZGRGTHZ5MzI3VnFYUUowb2xhblRCVHkwZ0dXTWdaQWVaZXpZUEpEUW1VU2dt?=
 =?utf-8?B?VWtoSXJDaXkybEYxUmgyTEZYTjdCbzFERHZTYUh2NTd4QXZpOGZYbmV0bW9S?=
 =?utf-8?B?TXA3bmkwdkU3VWtiRW9SSUVhSVhCMnl2MFdYV3ZtV3c3SVhIRWJKR2VpRHpP?=
 =?utf-8?B?cWFScVI4RzJPT21MRXlxbDhwZ3Q0d2diU0lhYk9WTGMyRzlRK3g5R2Z5MXQw?=
 =?utf-8?B?Q21OYUlwRnZlTDcxNmR6TU5IajdwdHA2dEl1a2xINWhIUHo4ZjJaZVlCeGVQ?=
 =?utf-8?B?MndXWCthY2hRY2ErMHh0MWdjVmxRNWV3VW9MTnNid0MxdmRTclNQU0dxZEtM?=
 =?utf-8?B?Q1VBL2VkVG9jTi8yUTRibFFqdEJmYzZOeHk5N0xIa0ozVjNsSE5tZzlnSi9r?=
 =?utf-8?B?WG5ydFFXNXVMQngxWEdwcWJvcGlPbm5SbE9NT0ErMkpiSjV0YjJBb2Jzci9z?=
 =?utf-8?Q?lehqUhJfQ9cFmXF5bKEETn9yt?=
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
	bW6/Ba91zr7NG3Bt0WhLX/72fmwzh+XXcGQUlSZ+ZeOrjBN8yzaYUbQpNO3gMB5y0Q4lG7ahZ9tp7XtZNrRQcR1I/cxLsoB+TIRtEi3lQ1/D8aDwYvFoh07h4L8C3EAUn4J6eET12s1/qpP+U8Qw4hZGpqGazXFBfzqVa1rJ5WzJzZulq+EOj89lf8MI+VudnD/8sQxk+mCBY7yzgaF+Cbh0UL0oXAiuP7VpcDOo2vZZiXIK/p+8EW8bRXpixxO+XFsS+27NEG+487noqxKQXnk4qjidjWClLPxNJLzha4fJbsebsGSJkqFnVzICm8PuTLHpgVQzwYS7b5Mio+xoqC+k6MpMUKZt95CCmJr8EywHt1ycgwO4MOY4YA2/LucDxOFoTs3ERNouzsdJ3oOGFD+utoI2/BUa+8LVfaAta0pUQGsB9NIACcQ5d14Fhebb9V0BpbxYqcxV7Au/T/xoc/hKJlTRIWciv+bB4wI/5jr0MovAQEBr2Pgch18lA0HuupQlbCtP57PtOtjcZamI95nyr9IDx1utYPckgnNJrpbL6NmUwNEXoQ7jxg0lueaC3KIfIPZHtcrpoLsBTUV+2ZKFH/gw2erX56Xri/d3ct1AN+if7oFDVqsquHVdG+zx86lDTxFGUUFENl3J04Bzig==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5a5a6c-992c-49a0-b02f-08ddbbd15ec0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2025 14:36:46.8082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2cMT/aeawUZR7YAvKIjUmjyjAGNSrEiNbvPwkaowW6V2yzfPrQDsokJYsdSMBbfbkbbGxQ9h5wuVKPkNUgCWxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR16MB4617

PiBPbiBGcmksIDQgSnVsIDIwMjUgYXQgMTA6MDEsIEF2cmkgQWx0bWFuIDxBdnJpLkFsdG1hbkBz
YW5kaXNrLmNvbT4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+ID4gVGhpcyBzZXJpZXMgYWRkcmVzc2Vz
IGEgbG9uZy1zdGFuZGluZyBpc3N1ZSBpbiB0aGUgbW1jIGRyaXZlcg0KPiA+ID4gcmVnYXJkaW5n
IHRoZSBzZXR0aW5nIG9mIHRoZSBtYXhpbXVtIGN1cnJlbnQgbGltaXQgZm9yIFNEIGNhcmRzLg0K
PiA+ID4NCj4gPiA+IFRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uLCB3aGljaCBkYXRlcyBiYWNr
IG5lYXJseSBhIGRlY2FkZSwNCj4gPiA+IG1pc3VuZGVyc3Rvb2QgdGhlIGludGVudGlvbiBvZiB0
aGUgU0Qgc3BlY2lmaWNhdGlvbi4gVG8gYmUgZmFpciwgdGhlDQo+ID4gPiByZWxldmFudCBzZWN0
aW9uIG9mIHRoZSBzcGVjIGlzIG5vdG9yaW91c2x5IGNvbmZ1c2luZyBhbmQgZGlmZmljdWx0DQo+
ID4gPiB0byBpbnRlcnByZXQuIEFzIGEgcmVzdWx0LCB0aGUgb2xkIGNvZGUgYWxtb3N0IGFsd2F5
cyBsaW1pdGVkIGNhcmRzDQo+ID4gPiB0byB0aGUgZGVmYXVsdCBsb3cgcG93ZXIgc2V0dGluZyBv
ZiAwLjcyVywgcmVnYXJkbGVzcyBvZiB0aGUgY2FyZOKAmXMNCj4gPiA+IGFjdHVhbCBjYXBhYmls
aXRpZXMuDQo+ID4gPg0KPiA+ID4gV2l0aCB0aGlzIGNoYW5nZSwgd2Ugd2lsbCBub3cgY29ycmVj
dGx5IHNldCB0aGUgbWF4aW11bSBjdXJyZW50DQo+ID4gPiBsaW1pdCwgYWxsb3dpbmcgU0QgY2Fy
ZHMgdG8gcmVjZWl2ZSBlbm91Z2ggcG93ZXIgdG8gb3BlcmF0ZSBhdCB0aGVpcg0KPiA+ID4gdHJ1
ZSBwb3RlbnRpYWwgYW5kIHVubGVhc2ggdGhlaXIgbWF4aW11bSBwZXJmb3JtYW5jZS4NCj4gPiBB
IGdlbnRsZSBwaW5nLg0KPiA+IFdvdWxkIGJlIGludGVyZXN0ZWQgdG8gZ2V0IHNvbWUgY29tbWVu
dHMgYW5kIHRlc3RpbmcuDQo+ID4gSW50ZXJuYWxseSwgSSBzYXcgYSArNjUlIGltcHJvdmVtZW50
LCBzaG91bGQgdGhlIHBsYXRmb3JtIGFsbG93IGhpZ2hlcg0KPiBwb3dlciB0aGFuIHRoZSAwLjcy
dyBkZWZhdWx0Lg0KPiANCj4gU29ycnkgZm9yIHRoZSBkZWxheSAtIGFuZCB1bmZvcnR1bmF0ZWx5
IG15IHJldmlldyBuZWVkcyB0byB3YWl0IGEgZmV3IG1vcmUNCj4gZGF5cywgYXMgSSBuZWVkIHRv
IGxvb2sgYXQgT2xla3NpaidzIHNlcmllcyBbMV0gZmlyc3QuDQo+IA0KPiBBbnl3YXksIHdoYXQg
ZG9lcyA2NSUgcGVyY2VudCBtZWFuPyBJdCBzdXJlIHNvdW5kcyBpbXByZXNzaXZlISBQZXJoYXBz
DQo+IHlvdSBjYW4gZWxhYm9yYXRlIGEgYml0IG9uIHRoZSB0ZXN0cyB5b3UgYXJlIHJ1bm5pbmcg
YW5kIHBvc3NpYmx5IGFsc28gd2hldGhlcg0KPiB0aGlzIGhhcyBhbiBpbXBhY3QgZnJvbSBhIGNv
bnN1bWVkIGVuZXJneSBwb2ludCBvZiB2aWV3Pw0KSSB3YXMgdXNpbmcgYSBwbGFpbiBkaXJlY3Qg
c2VxdWVudGlhbCB3cml0ZS4gIFRoZSByZXN1bHRzIGFyZSBzaW1pbGFyIGZvciBkaWZmZXJlbnQg
Y2h1bmsgc2l6ZS4NCkkga25vdyBpdCdzIHdlaXJkIHRoYXQgdGhlIHNwZWMgd2FzIG1pc2ludGVy
cHJldGVkIGZvciBzbyBtYW55IHllYXJzLg0KSXQgbWlnaHQgaGFwcGVuIHRoYXQgdGhlcmUgYXJl
IHZhcmlvdXMgaG9zdHMgaW4gdGhlIG1hcmtldCB0aGF0IHByZWZlciB0byBvcGVyYXRlIHRoZSBT
RCBjYXJkcw0KdXNpbmcgdGhlIGFtYmllbnQgdGVtcCB0aGVybWFsIGNvbmRpdGlvbnMgc3BlYyB3
aGljaCBpcyByZWxhdGluZyBvbmx5IHRvIGxvdyBwb3dlciBjYXJkcyB1cCB0byAwLjcyV+KApg0K
d2hpbGUgZnJvbSAxLjQ0VyBhbmQgYWJvdmUgKGhpZ2ggcG93ZXIgY2FyZHMpIHNob3VsZCBiZSB0
cmVhdGVkIGJ5IGhvc3RzIHdpdGggY29udHJvbCBvZiB0aGUgY2FzZSB0ZW1wIG9mIHRoZSBjYXJk
Lg0KV2hpbGUgbW9zdCBvZiB0aGUgVUhTLUkgY2FyZHMgc2VlbXMgdG8gb3BlcmF0ZSBxdWl0ZSB3
ZWxsIGFyb3VuZCAwLjcyVyBubyBib2R5IGZlbHQgdGhlIGRpZmZlcmVuY2XigKYNCmhvd2V2ZXIs
IGNhcmRzIHRoYXQgZGVtYW5kcyBjbG9zZXIgdG8gMS40NFcgbWlnaHQgc3VmZmVyIGZyb20gaXQg
4oCmIGFuZCBzdWNoIGhvc3RzIG1pZ2h0IHN1ZmZlciBmcm9tIHN1Y2ggcGVyZiBpc3N1ZS4NCg0K
VGhhbmtzLA0KQXZyaQ0KDQo+IA0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IEF2cmkNCj4gPg0KPiA+
ID4NCj4gPiA+IEF2cmkgQWx0bWFuICgyKToNCj4gPiA+ICAgbW1jOiBjb3JlIHNkOiBTaW1wbGlm
eSBjdXJyZW50IGxpbWl0IGxvZ2ljIGZvciAyMDBtQSBkZWZhdWx0DQo+ID4gPiAgIG1tYzogY29y
ZTogc2Q6IEZpeCBhbmQgc2ltcGxpZnkgU0QgY2FyZCBjdXJyZW50IGxpbWl0IGhhbmRsaW5nDQo+
ID4gPg0KPiA+ID4gIGRyaXZlcnMvbW1jL2NvcmUvc2QuYyAgICB8IDQzICsrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+ICBpbmNsdWRlL2xpbnV4L21tYy9jYXJk
LmggfCAgNyAtLS0tLS0tDQo+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCsp
LCAzNSBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiAtLQ0KPiA+ID4gMi4yNS4xDQo+ID4NCj4g
DQo+IEtpbmQgcmVnYXJkcw0KPiBVZmZlDQo+IA0KPiBbMV0NCj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzIwMjUwNjE2MTAyOTE3LjE2NzcxMTYtMS0NCj4gby5yZW1wZWxAcGVuZ3V0cm9u
aXguZGUvDQo=
