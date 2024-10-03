Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEB514B080
	for <linux-mmc@vger.kernel.org>; Thu,  3 Oct 2024 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727973066; cv=fail; b=rirg1aRcN1lq1/W7Wdfv9lNf1f52Kj+2WZVABgIuX1U3efUDQFPGvL66VLLH6guH4ixCY0pvLY7gg5UFNFFijIvWYyZ4BRm9H8jedHf8vkBnauMaQ2ZdrZ7V90KBiDmVIrbSepgw1EHsEz4tmaNc9vHaMJI/4QriIVNe2I+EQAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727973066; c=relaxed/simple;
	bh=u9+QLm2tCB0QMVABlp3II9C0UOwPNgolWGOmwUqROII=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jlxRsMRWbz09xShKtdNHibX9BaAcwlw04IIsG10yro23Qm8jVFccw7KRil41mKK/IdiTIRc0ApziRTfLsicHIvmLv5PYKs8SCU6EQ9QZy6s/DDiJieFBNQ1fZdMuJpho83ANI+pYGTHqL6CxVuVjr6LfbY1o+DP64R+KfQRqO2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pDwd+9Za; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=fxBxNAIT; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pDwd+9Za";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fxBxNAIT"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1727973064; x=1759509064;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u9+QLm2tCB0QMVABlp3II9C0UOwPNgolWGOmwUqROII=;
  b=pDwd+9ZaDR7f77QBeYK+H6eXpw2urkl+dvkmOV5est05JRt5XAxyo25z
   wLoNFxXqhb0B5/uJCxfTHNB9vQr8bMlDoeuyB3sblBPqV1f7k8UwoB//M
   +FfdZeQWDOCoM3+MKW/xh3oH+AYJ+btFji7tDFFrMDJYaB+dqnYFGZmOY
   o5BjD/5UdFKKLAh3aROytUE0WFaJ1qVaFCrjvOC7NrmywjstH8W8q/rh4
   FvIg5uF7qXKIdCqaAeI6rcUWVnmSOkxcmAkl16Z0fkkboMUJOFMD8OatI
   srefKXOMjByndFlAX5AOp4vlGtkhqK8AzMbeZEvfkPSI6pRXsk8x0suXi
   A==;
X-CSE-ConnectionGUID: Mcq6p0eCRsGoa9QydR4v4Q==
X-CSE-MsgGUID: 2jkLOHusSjKQ+KVKyhTqYg==
X-IronPort-AV: E=Sophos;i="6.11,175,1725292800"; 
   d="scan'208";a="28247952"
Received: from mail-westcentralusazlp17010007.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.7])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2024 00:31:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6Awvj3cztpBXOwpIuwt/j2VKsK3jk4bg2vdYee8cOmtpCAx4I0/lEpnbrIM38/N13IReCMS0469UBoueFD8jtXhO63QZctOUvbyZqfauVX+1+vk1q0bcGzSYFAq1NDfuO5xHsMXBsFFowiUlyNgNWk+UDWS2BqzeuUIwAbQu4UUaPNgfoyWUqHmkNs4gsNUKCitVo+gqGTjqhnngg/cQdslggk+hhXXmeazpc5abAJ0gyheBYZ5bYGvQZ8YQdzR6HhFVvl3Vq0fyVwIA6TF8w2lxFBRLOnXlUP/v/Sks7INXQz2uPFZkNqCA2zYj1/OMGCgIgByPgVWMZW5ABE5fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9+QLm2tCB0QMVABlp3II9C0UOwPNgolWGOmwUqROII=;
 b=uUe2BPsEa8bfuPeobNJuUUmQkZEOgRk/1NTB/s/RyHVpcX0zkP2gF0rZXCIfzkeXHGdw9AQg+jVdy1VlC4TvP/V+NmwQhjKcFJIZL31TEd+szprLGZ7Rg9OanQIO2z0y4cqtrtvNmRjIWbCrIn75oJaZRMlmhlr96XKNc8MtpZY8SPbyT5M5LnSq6jEfFPmzm5ni5rAvJ7IbEbN5WysTQUAgBUhjygtSrbwUrA3K1z+neEjwpLMLOom5kJX9WJN8bZsgjpoS7DMXPelJ4J3c6GxNV5OJLnDP7n7IwKOM3ouHeiC9gAEHAgyJ8DBX5X6BxbJjqqpfL0bkcV7ElRXibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9+QLm2tCB0QMVABlp3II9C0UOwPNgolWGOmwUqROII=;
 b=fxBxNAIT2xwbYNyoUpDlBxa/INTA5F6Cyh1UfPxeZTIl4BW/14/PeWgKO/nL4AwMNVOdmEcpcd6zC0cSjuw8fOWVACj5QAmZUwQBZCFbBDLI/Ls+8CLGERTUK9ENCNwe2rNYS6EtaQF41BrD5MF4GQ2SeGeVzVnePZFEKPVcLow=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN0PR04MB7999.namprd04.prod.outlook.com (2603:10b6:408:15a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.16; Thu, 3 Oct 2024 16:30:59 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%6]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 16:30:59 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter
	<adrian.hunter@intel.com>, Ricky WU <ricky_wu@realtek.com>, Shawn Lin
	<shawn.lin@rock-chips.com>, Christian Loehle <christian.loehle@arm.com>
Subject: RE: [PATCH v7 02/10] mmc: sd: Add Extension memory addressing
Thread-Topic: [PATCH v7 02/10] mmc: sd: Add Extension memory addressing
Thread-Index: AQHbAdj9YxKhLNvUhUW+Q6Jiz9Q4crJ1V2CAgAAH53A=
Date: Thu, 3 Oct 2024 16:30:59 +0000
Message-ID:
 <DM6PR04MB65755F48D1F6A263584F802BFC712@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240908102018.3711527-1-avri.altman@wdc.com>
 <20240908102018.3711527-3-avri.altman@wdc.com>
 <CAPDyKFpZJQ7kGngaUmLfgyKNwhVjjGEuDw96kFBY3s6hXaEJTw@mail.gmail.com>
In-Reply-To:
 <CAPDyKFpZJQ7kGngaUmLfgyKNwhVjjGEuDw96kFBY3s6hXaEJTw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN0PR04MB7999:EE_
x-ms-office365-filtering-correlation-id: 83eb8b69-fe70-47ac-6148-08dce3c8c379
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K1N6USt6SjlJL3l3MlZyZGhpY3R5aHh5MGcrMVFCKzFZUWtaUVNRYjZnOWRm?=
 =?utf-8?B?OXc2VFBadzA1cGpTMnhZNEVUeUo5RFFrbEp4dXBTRDFielJsVDIvQld3NTZT?=
 =?utf-8?B?ZDFEV1ltNHl2a2dkYXQxckNBaGI1N0EyR1pwRCtFSlNMZnYwRlhjS1hyZHhP?=
 =?utf-8?B?ZEVaTXA3TG0vbmhqU2k1VjZDcnhEQXNOTkN5bVcxWU5jOFpIeGFOUHJDUXV0?=
 =?utf-8?B?S3NVdFMrM2hhQ1JoWHUrSzlHbVV2TXFKeXlBdUlsT3hERFYwOFNPU1loYW9E?=
 =?utf-8?B?SGhsK04wK0hlNGNaczA0bEYxcDcyU0hJQ1BrVmp0UjJjMGV2RnZ0eUdJNkNH?=
 =?utf-8?B?RlllUFk4MSs4L1ljUm9VZmxrK2lieElNNzNCaWZSN1F2cGxtYi9nZFFiS2hZ?=
 =?utf-8?B?VTFMNlNPam81NjV0OGVwYnRqZXgvZ3ZsVExiZmZCWE5wUDFSSHF2ODBGK2cv?=
 =?utf-8?B?SHhWRFVheGh4c21NOXp5VktML2ZxQWZ5NGoyb243cmpxM0JkUVEzTWlScWFF?=
 =?utf-8?B?YStLTVAraTNlb2J3eDJ3RUtNOVE0dEZVVlFXWlN0eDU2SWxnNURsSDJlVklk?=
 =?utf-8?B?dGlMUloyQXN2MFV1RFFDUG9pVjF1dCtUbVRrTTRlbk5yV2Y5ZjVpSW0ydGxQ?=
 =?utf-8?B?MDZXVFI0QWRiQnZmQlNCWmpJM0prSGdEUWlGTUJkYXJ5SFozVEJ1c05LVm5p?=
 =?utf-8?B?eUEvTGR3T0d3K0szeSs1TmRTaUV1UTk4VUIxTHExVnZERm5jamUwRnAvL3k5?=
 =?utf-8?B?VlBFRUxrc3BiTWdIRVlZS0M1NkduUDJnYVdLRzJSVUZpSDBuTXZ5bFM3eFlw?=
 =?utf-8?B?OWZGQ0F1SjZYeE92cEIwYmwxYkI4eGRmMnIrOE1hU3hyVUR3emtVczJQNDNZ?=
 =?utf-8?B?bUllM0RWWTB6RmlrQ0JiWm1nNndLcFMzNnJTRmV5bDhBcnVIK2E0c2wyR1hj?=
 =?utf-8?B?a2c5S2N0QUlzZ09DUmNDM3BjOFpHT052VURuQVJ3Nmx1V01ibFpnWkVFcXZt?=
 =?utf-8?B?THpTaFFsUDdJZDVBU055YytRaUdaLzVsUTh4UlY4eStsUzJLR3htS0twbnJJ?=
 =?utf-8?B?M2FnTndlNldjbWhEbWttZWxvZVgzNEtWclV0MTkzeW1RdVNpWHdHanlmQ2p5?=
 =?utf-8?B?aEtmTEQrelArVzZuTXl1dzhLR01jajZPL3B1Q01oTFZ3ZTVEcXl4SEhkb0pC?=
 =?utf-8?B?ZjJJaXFuL2RENjlqK0M4RC9ZOWlHWDhaQVRSMDBCTTE3Z2pBcnR0cGcwY0xQ?=
 =?utf-8?B?NXBzaXQ0T055cnVRT1d3WGgrYUVTcVIrZ05uSVh5bVBzYU9qb2ZuUVp4ZUt5?=
 =?utf-8?B?aXRzMmIxVWRtRU12dmhsWHkrS05tUllVOXNPWEg5K2FjZGl1OEhjMlZCN1dF?=
 =?utf-8?B?dmlhM3JOcWEvajN5RXFscU5Heml6c3VZN0h5aHE3aFNsTG1JM3JScEFxWVND?=
 =?utf-8?B?U3VURTBPYjZFQXlGZDNKN3BNTExQaDJCdENEcU1iVmxIRGxKWkRKT3hNMUg1?=
 =?utf-8?B?eHlyWWxaZXlrQVUwTllRRzl1ZlNoMXZCUElGNlE1czNmY3I4VTJxdFdhSUd2?=
 =?utf-8?B?UGl6dXZqRGJ5enc0SURnam1tRDlSckhnT3FLRFN0dEFIdURLTFdvYmlLVmhl?=
 =?utf-8?B?YTBrN1dEQkRjM3lWUnF2VFNRM291V0NBNnEwWkxGRDlENERHV2Ryb2krMVJw?=
 =?utf-8?B?aWVaR3NVanBQU1dGSkJPdms2UlZhcmZERVZGNlJxNjVCL1VXc0hVQnhBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z1h4ZHZhUHdhOGlRNTF0bk5WNXpmNjJhOWw0bEtiNW5RS0hnS1BnM0ZUVTFw?=
 =?utf-8?B?RDVyUHh4VGlzNWFxejRUbkM1YmdKcyt2YWNSNGlOUkdwd2dMNzNGemJYc3cv?=
 =?utf-8?B?Y3BPWUd1TmtPVVVZMmFueUlFOTc2c0Z2dUNGV0NZZzE1RW1HMGdhSUtQT1da?=
 =?utf-8?B?S2FNWnJkeHJLMFAyUzErUGdDNXc1UEczY3pEWEJFaTRNQXp0bFZTNldqOXk4?=
 =?utf-8?B?R1NGMHFGU3VGMmpPeGNlcnJGUzNXZXRUT3hOY2g4djRNVTNzelVDSzF4VUQ4?=
 =?utf-8?B?YnBMSVRsNVFNMWlkODJrS3lQaUQxUit5U1o5UjVMS2pLMDhxalAvV1o5VXNR?=
 =?utf-8?B?aGpxTjd2VEMzTGZZK2pMcXJIVzdWM1dzVFhhdXpMUzZEVEpWRHdleitWTklW?=
 =?utf-8?B?Qy8wV05RK1R6VDIveFBWTnhicVZmMWRjNjNldG8welRtSmo1dFR5TUhLcGg1?=
 =?utf-8?B?eGVBMUtQaWpDTzNaeFpHTHB6V1pPUHBEZDdhUnlGWHkxYUFjUEJLSVM2Q2h3?=
 =?utf-8?B?RG5BUm9YSDc3QXVTNDJlenY4M004ZWVaU1NINldjRHRFZmlGREZBOFBGeW0z?=
 =?utf-8?B?NXNCT1A5eUErVTZMaEtNam1BSFczWWIzMTNEbnRjYkpMVUdvMUFVK083dk1r?=
 =?utf-8?B?OW1oZ3dWMFdtbzZkQng3UDcrOGxrSWUrZzlXQjhMY2RQNFgvU1JNWUJNN0VG?=
 =?utf-8?B?N3NEL0Uxb1hkOFVVaWJuaUg5TFF1YjY1TUo2TVdjZkdqcXNodjNqQjZzNFQr?=
 =?utf-8?B?a2VUcllZWHhUU0ExS2hqWnpwMkptNE95Mkdubk42SlRjdUVJbzdqMEpyYlN4?=
 =?utf-8?B?c3ZiL2wyTkpzTHRNQjZUNTVvVmQ0MWRQWmZrRDJpVTdKTC9Mei9pdkdQcVEv?=
 =?utf-8?B?dUo3RGJTQUFVN2p4WFk3ZWVTZHh1bW1KZnAzVml2TTJjQ1huVlhDaDZLdndW?=
 =?utf-8?B?dmpiekcxWlQwcGdWcW1mMTFEdzBYK3FrNGVtcXMvVllhRm52SGZKQmh6S1ZC?=
 =?utf-8?B?ZUdlR3JyTDlqZVdnWXc5ZGsxd3BvYkd2Nk9ERUhpVUR0d1RkMkVyRnRrV0U3?=
 =?utf-8?B?dXBVQmVyRElKWkhMSEdJNXhkTktVRWtHU1J1L20rZ3AyVWwzNHlmYmhTdDlM?=
 =?utf-8?B?cExjelF4YlNXeHg1clcxWFRTQU82Snd4Y3ZPRTM3ZXRqSDFPajNYQzVFL1F5?=
 =?utf-8?B?NmF5S0dOUk1zWm02Umx2SHN1emdUY0RaUzRWMG42b0ZOWit3S0phZXVmR1FY?=
 =?utf-8?B?Z1h5MXRiQnBZc3E1T1hRemkycEcwdDQ0WGJ3bmFsOFcxb2YrTUhra05MQ0FL?=
 =?utf-8?B?VGErQjVYb2RVSGVvVExoNmc5QnBBd3ZQRmJ6em5BOEtGNjVVYXVhWUR1dmNL?=
 =?utf-8?B?dW1yNUJNL0d6YjBkWUswTE4rdjc5NDlsZVVhR3dKK3hiclV1M1JCK00wOVR5?=
 =?utf-8?B?UENlWjM0NEVMZ3J2WWxHYk12ZytiOWp3RUVxQzk0dFFBM1lHcWloTkJJdmtW?=
 =?utf-8?B?RDZtZmZubUx0OUZTaG8zOWltR2EzcnIzMGxyM0hqakRSL2NPdTBZWU1Td2V5?=
 =?utf-8?B?bGd6a3lMbDJzdUwrdkM4SW1pdHZZeEFja29FK0pJeGFkbVplZXdVMEx6aEMx?=
 =?utf-8?B?L3Fic09wd1RKMU05Nk5TYUhBMXQxUGN0ZkFyY01Rd2VCYktyaHJZMlhzdWhZ?=
 =?utf-8?B?T0ZRTHRLWnREWFh4cTdXbUtsak00OXRtNFRhano4L2xoQmRZaXlzOGRKTy9h?=
 =?utf-8?B?WFRjU1dhcWJlNE5yVDNnWHA5cFBaNHlUdXN2aVZrWDJBdjZuMVRJUG1wNlo1?=
 =?utf-8?B?Qy9ER0JmQW5rVWVTL3krSmVHL0hJalY0MVRHeHl3Z0tsOCtSUUJSbzd3bE1Q?=
 =?utf-8?B?bDR0VjZ4UUdRSHAvdUpzWEQ2L2xtTVloMEtGcUNjdm9DTS92QUxKZUNyUDB4?=
 =?utf-8?B?ZWZYblRyMzM4ZDZzRWZRUEJidnpnUjBUaXhkdGdRYnVBRHB4eHdmMEg5eDR5?=
 =?utf-8?B?Snk5SDZ1dngxRkM1QmxyYjI1SVlUb0owandTV1VhK2VsQldlMm9CSm5pbVdz?=
 =?utf-8?B?b01jRlBDVE9TZ1F2NjdiSUpNU1NpekNnbTZnNkZnN1VuSEVBa0dGclF4U3hH?=
 =?utf-8?B?Y0M2ekVmUlh3MlJIbm1ZSkZEeVRaOHJSREljV0tSaVFWcVk1WGNYY3k3NVpX?=
 =?utf-8?Q?2Xo1SyDr5JwJAUfXGm714zTb4Xux7GpHmuAHA0WpM3fq?=
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
	ifC29HB36WpoPfP8E25a0x0cvjhuTfWG0xFWIySpJtRGUqrvpbUILzUvJ7qwCfQKh4y2CnnNUobH0n3N8Zz7wGZZzB3/8t6dRyo5yf/xHmAk2FmgyW27ViL/Hlw6B+n/x4Ze42w5IoDc9h/xmcMiGvtR8xryBBvXxT8t2v60vmpMRgIsqsKK0He4Ya0mMZmFSnSfpz8TOwZMQuhbjI9jqmekEWUdLzqCTlGt/2u9uHGVTtdawldCm7i8hQcq6B/wMzPG2rzZCPnCk9wscVtU9bSNyT8HV6z2tUJ9MrnTod/wD0pT8ESWuokN+57UxIZrborJKzFX567AWsNvMgfxS2+6i0yeoBljLfeg3H6BJi/dltw/6ffrlltlWnQLs/p3j0CYFVABft+csZZF4zKwsaVAL27cOaMgQ85zMRzL/x1cbEAY0dlnCvbTiIdU0zFrtSV7MRKuKIja+9SgUHvkaSrDNPkSVL1li6PAa2HU4B+UB8ROPO/QguD0tWyNwo2uuWzpxGDsddcQ/1iBU7aY8XeFfiD/sBxIinArj12+WfUE92cwg3nA9x2ihIVSTrA6zTM1eYd0dnDYXqGPtRCrC4GH12Hi5uYZ9oyEJ6x+LPz5s0jVMOSjvCyinamju+Hk
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83eb8b69-fe70-47ac-6148-08dce3c8c379
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 16:30:59.1748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EluXziCRIiBUD1V2m6MYV+zyBRWTVQIXBJ339dXwD95BDx4nGM7cEACzXmdyL8/xqAIEW4tAFco0JDuuBWwDhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7999

PiA+ICtpbnQgbW1jX3NlbmRfZXh0X2FkZHIoc3RydWN0IG1tY19ob3N0ICpob3N0LCB1MzIgYWRk
cikgew0KPiA+ICsgICAgICAgc3RydWN0IG1tY19jb21tYW5kIGNtZCA9IHsNCj4gPiArICAgICAg
ICAgICAgICAgLm9wY29kZSA9IFNEX0FERFJfRVhULA0KPiA+ICsgICAgICAgICAgICAgICAuYXJn
ID0gYWRkciwNCj4gPiArICAgICAgICAgICAgICAgLmZsYWdzID0gTU1DX1JTUF9SMSB8IE1NQ19D
TURfQUMsDQo+ID4gKyAgICAgICB9Ow0KPiA+ICsNCj4gPiArICAgICAgIGlmICghbW1jX2NhcmRf
dWx0X2NhcGFjaXR5KGhvc3QtPmNhcmQpKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsN
Cj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gbW1jX3dhaXRfZm9yX2NtZChob3N0LCAmY21kLCAw
KTsgfQ0KPiA+ICtFWFBPUlRfU1lNQk9MX0dQTChtbWNfc2VuZF9leHRfYWRkcik7DQo+IA0KPiBU
aGlzIGRvZXNuJ3QgbmVlZCB0byBiZSBleHBvcnRlZCBhcyBpdCdzIG9ubHkgdXNlZCBieSB0aGUg
Y29yZSBtb2R1bGUuDQpJJ3ZlIGdvdCBhIGtlcm5lbCB0ZXN0IHJvYm90IHdhcm5pbmcgb24gdGhp
cyBpbiB2MToNCmh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4LW1tYy9tc2c4MTUz
MC5odG1sDQoNClRoYW5rcywNCkF2cmkNCg0KPiANCj4gWy4uLl0NCj4gDQo+IEtpbmQgcmVnYXJk
cw0KPiBVZmZlDQo=
