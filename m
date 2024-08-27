Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560DB148302
	for <linux-mmc@vger.kernel.org>; Tue, 27 Aug 2024 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744732; cv=fail; b=k0cAnrGZFMOQI+Rid4oaNGq0pdHVZW6OI/zYIPeuCTSZn/hsHKcc9kE4p469thxVhdO2pdADq29XHroUHBRD316rcVEAxh92n6ALyUrBpyKxPuyolX0jsLzrAsDO+1y/ZI7ZOmiHVtPA1CqDSquIOW+c4E36G1RM53iC6c/4ECg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744732; c=relaxed/simple;
	bh=54Kop4VOiZUGeZv6mWyCpb9DCgouAU257DsEyzuoTdE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kK5P0xLF8gNkNUt436qS9IAvWWzFu5nP86hzZ7InzwOymzsRChPr9yn+zGrP8BpzxZKww4js6za10sYvNSccr2GFM9tbliQfR3qyKsacPUVE0VMT/GukmTgVt+lUuPXtIJosjn92d6ngh92Au3mtQnKgiLLl9zzSKFo7auH2fS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jQwJhksd; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=V2O04CBU; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jQwJhksd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="V2O04CBU"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724744730; x=1756280730;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=54Kop4VOiZUGeZv6mWyCpb9DCgouAU257DsEyzuoTdE=;
  b=jQwJhksd7ID1efWLW1g3NpeTWxJDpAo+rAHhM+tFQx5p3DZWPbiXBMT9
   QiChdSo0gcQSDWpp+pgFkfiaMjHQKulOhiHvlFVbp9pFE18fEpLOFPM7C
   xAMnOvT0Ds69/YNG8cPLl4g62lQvmZNjISU3bNAln+n6YN0Lkct/qUOBQ
   AWqrkWLQYqjjHs+zYZhzv4iNDAF2SjQ5koxFb/8mt4fG0KUhfrpAGcKCl
   KS43uwGyCw5Ekz5tIcanc5UYIENLSyy6SYaMA0u716aOi3Xf8rW6AF7Ij
   KKf+4oMXAbJqDp8zVlwdSAlDIX1HX/3LfysqM8e/4Dy6m0+7TMKR5SoOW
   g==;
X-CSE-ConnectionGUID: +lL+5z88T4WwJXFgFS5ruQ==
X-CSE-MsgGUID: LuEm7Zv1Taau+PjSZi0d9A==
X-IronPort-AV: E=Sophos;i="6.10,179,1719849600"; 
   d="scan'208";a="26258302"
Received: from mail-eastus2azlp17010005.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([40.93.12.5])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2024 15:45:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DnoeZzzax+LAmm+uJqVqljaQg3H4P/2oZJTTLBGvpJAzYE+Tm01cWWfT/ODAHAvw4cnNDNXWYPapeZdCz1kULspcLOPVsG6syKGJGuTq4p1OtMyb1Lvja8vWqvQ7+3QE3kCez1FsGcpUPYXkxhJrxVXxZ/aqG2ZQpah/4lOHTLhbG1pImaXlCgBnwRzBTJPpbN6polKJaLB9ENJmGwCalIkdkVQz9GjVSqYP3BTbEAqIB/t9/KnEUYEI2X3xuDWQfb8dnJGcIXhqADqkTTtBxovAT1NiPlZUjJzNQWSPsriiROl7kZzbz/hTGqZygmw5obpazmf1mEmcjxi++4+bWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54Kop4VOiZUGeZv6mWyCpb9DCgouAU257DsEyzuoTdE=;
 b=ggr0AXpBwUGK72tAZdDCCiYzFRylDTlwtkg3Y+mqnnPsFHq5kCDJ74gMDl0UVuG8nNfAd3d15IXnmZkOdso2t7fHYlKnlZ95Rhf9qKHrq2GFZJVGFm7HHmsMS2hsiqByKpI3yUQkOWm928Y+k/kqEPvmWAavudIGlNceRf3CBlu1DDzveiY+fXoc2xNW6pxiPS7nPZM1AINK6tmdGGXaEzOlvTi4RpaUTC0BT5eDCQJjFDUEItur7NDS5LdM8pcE+Ew87ScCdqqEEpteierp0RpnqlURjK9qHDyed5fKvZWUBfjQBRlSNvXl+Ei5JUT1e98GhRKj6mk105w3T0iLkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54Kop4VOiZUGeZv6mWyCpb9DCgouAU257DsEyzuoTdE=;
 b=V2O04CBUKCsXUSsVYk8q0wkLd1+EPHTwtOYLhe63dVZitzPpUZuojzieZNFGIgpcqvjjTH3x7OfhWTsh0PvTM67qJZYcHey1IlxBOXJWzQr+IOGUp+l8uJ2nG5W7sReZ0Bpo652EnMDe3WJBGHrUpVb+igFyu0ZY+THXBSn2OEM=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH8PR04MB8613.namprd04.prod.outlook.com (2603:10b6:510:259::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 07:45:20 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 07:45:19 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Adrian Hunter <adrian.hunter@intel.com>
CC: Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>, Ulf
 Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v4 0/9] Add SDUC Support
Thread-Topic: [PATCH v4 0/9] Add SDUC Support
Thread-Index: AQHa9sJ1Fgtj888U6kGa1b/dDuzVu7I5GbsAgAADPMCAAZo3oA==
Date: Tue, 27 Aug 2024 07:45:19 +0000
Message-ID:
 <DM6PR04MB65751048E9B35CFED478F180FC942@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240825074141.3171549-1-avri.altman@wdc.com>
 <3d7a9953-afed-4b45-a209-b797634e6bd8@intel.com>
 <DM6PR04MB65756CEE03C15524EF646C3BFC8B2@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To:
 <DM6PR04MB65756CEE03C15524EF646C3BFC8B2@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH8PR04MB8613:EE_
x-ms-office365-filtering-correlation-id: b983ed2f-4c65-4681-cb65-08dcc66c3345
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VlpMay9CWFJGOGMwNDF0OG5JYk1ZNk5RZFBFMEg1Rk9na3dpTU9iUTVwZjZk?=
 =?utf-8?B?aHhpWlptWDlyYzhRc1lIQlZWL00wN1VWbGpYWHRmUW9NdElDcjhGNXBmOThG?=
 =?utf-8?B?dFh2L3poMUtVK2pOQVAvMWNaVHR2MGJ1dWNOV3dxWEZhSy9KNno3SE9UV2JD?=
 =?utf-8?B?MmM4UXJuaXNHeTd1dmk4dGdCOWx6WVEwdGd2RnE3d2JZemcyVWdNVDRILzE5?=
 =?utf-8?B?UzZJODdYU2dqYXduWnlCaWtOdCtISG8wZlNldFdYMEZpNWFUcnU1MGdqWDF4?=
 =?utf-8?B?V1NEVnFWNjkvQTZlTFcxajI5bVUvYnEvbGozSnVwS0F0OCsrQTBRT3VVbFY4?=
 =?utf-8?B?RXMwcTBTK3NueERVQ21rTkVVejg3bHE2ckZCYUlVTjJITHluSlhwYW1tbUtM?=
 =?utf-8?B?dzcyYnI2M3NEa3JkMXZSL0NSdzQybEMrM3E5N2lHNlJQOGdTOUhZdkhvcWdy?=
 =?utf-8?B?LzdNemVTUFVROGNkTFZGbnN0cjlTcG9uamRLeFN3aVc5WkM5SHdtdjBTekg4?=
 =?utf-8?B?TjVFYlE3elBrWkIyb0RoQ25Veis4dHhSb1dvM3BnMFlDOHM3WlpvVWdhbU84?=
 =?utf-8?B?SDE1RWV1bDhtUFJVOWNkdWt1V24vdVV0U0FaZzRqKzZGdkR0SGlUTW0rNElD?=
 =?utf-8?B?Uk1uckovbWZ1N2RkbGlqUkc2QWdCS2pGTWIxZXVvT003QkJRUUs3ZHUrcE1x?=
 =?utf-8?B?blJITHVmR2Qxdjd5QmNRS2Y2eS85cnIvTENkT1FIdzlaWndKVEMrd0QweUlC?=
 =?utf-8?B?UktWTWxtYVI5SjBodUo3SlNDN2E0RnVQcUdVd01zeDN6TW5Ed2VNb0RwcnV2?=
 =?utf-8?B?eGpKTUZFM3IzRXUrTm1ValkwM0k2OGxZR2RqZWR0SmR0WmE3dzlYRHdoaGw4?=
 =?utf-8?B?a01jL0p5WmZZVFRla1VVTXdmeXV2TjVtTUVqU0hSNWprTWxmTHJCNjhTZUFh?=
 =?utf-8?B?Q3ZDclNMWVc2N2pGbHVpL043UUVia2dYeG1zN2NNVHB6TUxEbG1iWXpxcC8y?=
 =?utf-8?B?SkZRMkhWWGhiOTd2anlTZXlySUxtQmdaMWtSQUxFTjFHRXRkVmRsZnpLWXl1?=
 =?utf-8?B?WjIxT0VpZXk0eE05M21TeXJDb3RhdEZBUU9McndNYVh0NWFaY3RTcXNsOUtQ?=
 =?utf-8?B?cHZSNGtPZFBIWk5tUzIzQXpUVHFMbDNTMFQrSGdpY2NYUytyRUk4cVgvTjhT?=
 =?utf-8?B?VjByMUp0TWZJYzJWNHBQcXJvcFNLSjBlUmNKbnZ4NzFGZTZCOUZ5dFU5czhv?=
 =?utf-8?B?VCtqdEJyaHBXZEpzbUFlc3l4YmlKd0paSFFZUGlKbUd2WDBtcTJXMWU2R3ZE?=
 =?utf-8?B?STdEY2pHNnprdk5xaXcya2ttR0psNkRNOVY4MzF5VHMvTGFURVFSdy84dUNx?=
 =?utf-8?B?MnFyV0VDZWZzaXZWWkJMMHpiTnRLSUs5YlVMcUdycGlHQ1lLaDhvZTlVQWdx?=
 =?utf-8?B?cmxTcGw2NEJ1M1pJWDk5YWwrMWhaVWtnSmV5TnhyQVgvWUtydlp0VjdJNllX?=
 =?utf-8?B?cHByaWQrQVlORkhGbTJhajE3YkpxcVJhdnl3eWZpNjVFbFJjM1ZoUDh3TmtQ?=
 =?utf-8?B?UC96TUwwNmZFQnVtYWJ6YkllOTd5OERjZHl2MWQ5cVAySjlzMXlmNDM4cWYz?=
 =?utf-8?B?RTN4U1BLbGIzMldROUI0YWw0UmIvTFpkdytJdTdPUWl5aGVGdTF5NEw5TTMz?=
 =?utf-8?B?Q29wSHdlbHYzSkhHcFZKZThITXpySkVQZU1pUmNISk42QnRtQW5NZ21aWXJJ?=
 =?utf-8?B?SmFvZjliU3Q1czh1UzlqaG91MDFNb2t5b014aUswekxHdERWbmNqSmkzYTJO?=
 =?utf-8?Q?V4BF73TpK0DDAh/MwscN82ylW3IqR9TOXyi8s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TGhxc2I4MkdxV3k0UnRFSDUzNERhL2hJRzRTekEzNGFJNnd6L2VRcXgwTFU5?=
 =?utf-8?B?eCtlTFljQjErUzAyTjRUdlVZMjROaW5VYWdNL1haNGk4LzJwRjFnVWFTMWg3?=
 =?utf-8?B?RnZRSlE3OVZPd0hNNTBrZGp5UXM3dlUwNGk5UVh0eCtOWDY0VWVVdzVSTEJN?=
 =?utf-8?B?dkpObDBQWkluaWZhN3hRRWNJR0ZoMlNYWmdPN2o1V09tV0JyQVEwRFhsU3h2?=
 =?utf-8?B?RnpPZVhVdUVkTWh5SENwOTBIakhlbk9sOTFmRmRmMis3MmRtY09RUEhrZDhw?=
 =?utf-8?B?dDhhQjdVSGltNHA0MzBYdkpRZ2Vwb2VyZm5XeFN1TmFqRDFlTjZCR1BsL013?=
 =?utf-8?B?bkFDVzFGbVovS3c5eDFHT2todGc0d1NVdVJlRE5wWlRrd0tJZ3BVemhSTFE3?=
 =?utf-8?B?dkcwSHFLaFdNUjdPWUI5YWJETG9Gd3BEdFBTQXNsa1IrUm0vRmlEUmV4YW1Z?=
 =?utf-8?B?VktOV1grdmFjTHJwbGd0amFnMlUxVGtraEoyanl3SnZndW1ubkFyTmtRdHFP?=
 =?utf-8?B?dFBqZVRUVXJ6a0JiS3c2VTVJL2I4NGF3UUpQRER3VTUrS2hmMWFhcmRJUTVM?=
 =?utf-8?B?MEFYSmF6Tk9idlFQMEpMUGFGVk0wKzEveUJ3SDBzWWVFclVlaFBzaVhpOG1o?=
 =?utf-8?B?R0xJL1NJdVJLSnkveGN0MmlsQ2h3VzViZDQ4UjFOaGpuMTBUQTA1cjdKWVEw?=
 =?utf-8?B?VFh4M0pWTlhmZEp1ZWhiNjhrcnp6UkhsTXFOdzhVTEk2Y1lIeXJQVVF2YVhI?=
 =?utf-8?B?cFgwVEtjcVZkdVUybkpHV2RMdUdERGpVYlFmVThoU1oxbDFUZjJKMDNhcmF1?=
 =?utf-8?B?WnRDV0ZpNjFqQ05sR1RDSzZZbFp4eTJCK1JSVERSSmhJVFMyajlBRGZ3bzdR?=
 =?utf-8?B?UGROS2xaRVdqcmVlbFltTExhZWNtQmxiK2FKMytEM0xqbWlZRncxY0M4UklI?=
 =?utf-8?B?WFpZNFlSQlRtbXJ0TzU3d21WWm44RmQzcVJqTHpYSW9mcDRxcDFQVExJbG1y?=
 =?utf-8?B?WVFaNGtjS3RvYkZ1cE1WNEcxZTFIODMrb3NMbnJaSzcyU3RxZ3VjTEFHRkR6?=
 =?utf-8?B?U1NNZ3FRMVVHbWptc3MrSll5YzJlTWNsQUFranlIQjBZZ2tNL21paS9Zay9w?=
 =?utf-8?B?SGdkRmlKTzhhRTFERmxUdFl1R21kV2R6Slc1b24yZDg0WWZFOFFTc0RVcjU3?=
 =?utf-8?B?c0dYZE9EYzJCanZzTnBHaU1GWUtGL1djalhxbmJHZFpSbFNmdEhsS0NIcEV6?=
 =?utf-8?B?cC9pcU01UWJPLzI2b213YlU1aXBBYmJwdnQ1S3JPeTEvVnpLeXB1WGxldWhE?=
 =?utf-8?B?d1plcXlNMEZlcVlIWjlBNzVlejJBaE9oME05UkdGY3RsYndGc2tIeGpQTnR1?=
 =?utf-8?B?WDFkbzVmWFA3ZjE2MkY0dXA4VjIrME5SNzVGZXYrZW5semZtOUFBbk9jdkc1?=
 =?utf-8?B?cXVQaTFWcnZmY3k0QXNDMFBxVmhYTUZEai9PSFlybTZRVmxmZTBsaG1YdVpC?=
 =?utf-8?B?WUoxc0NxWGkyR3lteXRWUllLV0gvR2lrczJIWlhaL0VMRGR6SXMwUk5CMTdr?=
 =?utf-8?B?U1dGVFZXOUkyMzFNb2FnS3NFcmtkNkkxdmF2NE1VcWRKWnk3a2pSWkRONGFa?=
 =?utf-8?B?SFNxR1BleHEzcFpCYXZxSDNWMnZjWVdlWmpuTTM5LzZnYXMxQi9XdDB1MVI5?=
 =?utf-8?B?WmhXcVRicDBJd3E3dW81UUhIZ1dZSlJLYUdhbFJHK1FWbm85bFRpUDRGQ1FL?=
 =?utf-8?B?T3BieWlZejgzYkZDQmtEamZpR0p0MEdzZG42U3AwWkRGWWFXaWt0WUhaL0Iy?=
 =?utf-8?B?dHlPS3pBWmhYaGRraU8rZjcxRzF1SFRlN1JPWTFrR2xxNUlVdm1lekRpRVRu?=
 =?utf-8?B?bUxWWWlUSURiSk1zMUJSQ1FkWG1XdkI4V0NFTkxNM3RVRTdUaDBhY2NyWklo?=
 =?utf-8?B?L0NveDN4VGRiQnlKTGF4N0NnS0FnQ1lZWVhiaDlyV3piUlNzNU9BNTBsc0wy?=
 =?utf-8?B?dzl1WmtzYnVLdm9WMVBMSk54WHdEL2l1YmhzVU8wZjFobjA1aEQ0aVNseGpC?=
 =?utf-8?B?cXhGZ0p3Kyt5OTdGN0FONVJibVA4TEdrUFBZaWdKTm9IMmxEUjdkekpLOEEr?=
 =?utf-8?Q?ybBjhal4JAxUR3GLbpDHB7jcP?=
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
	eVettN0lIG35ffVJuqP6P6OQCrq6bEG49DDfIVsh95aDb48JpNibTBfsGZy75mP1v9TOfOtGDJs+zFEvIGcll161nS+XqBXB+WQhrjUw1IN2TQmWJbF5lDnLn2bdbDmZJLn1Fk3QEyrWQ/8ZIbe1jkv349C/e2bKv9ZLUWGTP8PC933HAYByzI3H1RjrKIyKd84SjcJPJoQcmbN49geDipcytex2fvmGuzqWY8l+U0Pv4nFP4paHDK4MJukNBKXvIU4wIuno67I1EaVyeNZ6qBWZX/c51q3I/ZCYm1ZiNMHKJNt3FfyroQlatqigoZ3b8p6ATfewu+DdTRTxMveBQTdTU/Rris+n4C5B+5VeSGSm0gypBE22RXxTHmhHV6aL/nLD4kI6gfUOb/85UVVZtS4xXXOelDQO4FfKAx9/c6Juv6ON322Br2kvB9zCv2xO8lWEBLd+HYpMBj8Uv3V4NhI90YbwS3PHXlnS4arBmF9nJSAZw1ZVL7hEkVGOYerrtSpWKR62Gm3nqFKpxFrTm4XXH2wJPH6UdoPEYSZIkktuFFHTtqgeE+zjLeJRyleOb418WCBIwKDZCCuFsxIZnf4o+a42Aw3fxv8XzDb+r3jRAc0L4uSoq1Wtjo9RW3rp
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b983ed2f-4c65-4681-cb65-08dcc66c3345
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 07:45:19.8294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xc0JIL8S+QzO2lKi8iWaw/W5QeuHX6ip1X1VdQEBjNNArevgamUAE8nk4BoCDtTDbl0NRkR+DDFgJ91QkP/rFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8613

PiA+IE9uIDI1LzA4LzI0IDEwOjQxLCBBdnJpIEFsdG1hbiB3cm90ZToNCj4gPiA+IFVsdHJhIENh
cGFjaXR5IFNEIGNhcmRzIChTRFVDKSB3YXMgYWxyZWFkeSBpbnRyb2R1Y2VkIGluIFNENy4wLg0K
PiA+ID4gVGhvc2UgY2FyZHMgc3VwcG9ydCBjYXBhY2l0eSBsYXJnZXIgdGhhbiAyVEIgYW5kIHVw
IHRvIGluY2x1ZGluZyAxMjhUQi4NCj4gPiA+IFRodXMsIHRoZSBhZGRyZXNzIHJhbmdlIG9mIHRo
ZSBjYXJkIGV4cGFuZHMgYmV5b25kIHRoZSAzMi1iaXQNCj4gPiA+IGNvbW1hbmQgYXJndW1lbnQu
IFRvIHRoYXQgZW5kLCBhIG5ldyBjb21tYW5kIC0gQ01EMjIgaXMgZGVmaW5lZCwgdG8NCj4gPiA+
IGNhcnJ5IHRoZSBleHRyYSA2LWJpdCB1cHBlciBwYXJ0IG9mIHRoZSAzOC1iaXQgYmxvY2sgYWRk
cmVzcyB0aGF0DQo+ID4gPiBlbmFibGUgYWNjZXNzIHRvIDEyOFRCIG1lbW9yeSBzcGFjZS4NCj4g
PiA+DQo+ID4gPiBTRFVDIGNhcGFjaXR5IGlzIGFnbm9zdGljIHRvIHRoZSBpbnRlcmZhY2UgbW9k
ZTogVUhTLUkgYW5kIFVIUy1JSSDigJMNCj4gPiA+IFNhbWUgYXMgU0RYQy4NCj4gPiA+DQo+ID4g
PiBUaGUgc3BlYyBkZWZpbmVzIHNldmVyYWwgZXh0ZW5zaW9ucy9tb2RpZmljYXRpb25zIHRvIHRo
ZSBjdXJyZW50DQo+ID4gPiBTRFhDIGNhcmRzLCB3aGljaCB3ZSBhZGRyZXNzIGluIHBhdGNoZXMg
MSAtIDEwLiAgT3RoZXJ3aXNlDQo+ID4gPiByZXF1aXJlbWVudHMgYXJlIG91dC1vZi1zY29wZSBv
ZiB0aGlzIGNoYW5nZS4gIFNwZWNpZmljYWxseSwgQ01EUQ0KPiA+ID4gKENNRDQ0K0NNRDQ1KSwg
YW5kIEV4dGVuc2lvbiBmb3IgVmlkZW8gU3BlZWQgQ2xhc3MgKENNRDIwKS4NCj4gPiA+DQo+ID4g
PiBGaXJzdCBwdWJsaWNhdGlvbiBvZiBTRFVDIHdhcyBpbiBbMV0uICBUaGlzIHNlcmllcyB3YXMg
ZGV2ZWxvcGVkIGFuZA0KPiA+ID4gdGVzdGVkIHNlcGFyYXRlbHkgZnJvbSBbMV0gYW5kIGRvZXMg
bm90IGJvcnJvdyBmcm9tIGl0Lg0KPiA+ID4NCj4gPiA+IFsxXSBodHRwczovL2x3bi5uZXQvQXJ0
aWNsZXMvOTgyNTY2Lw0KPiA+DQo+ID4gUGVyaGFwcyBhZGQgc3VwcG9ydCBmb3IgbW1jX3Rlc3QN
CkFjdHVhbGx5LCBJIGFtIG5vdCBzdXJlIHdoYXQgc2hvdWxkIGJlIGFkZGVkIHRvIG1tY190ZXN0
IGFzIGZhciBhcyBTRFVDIGluZGljYXRpb246DQpmcm9tIGRtZXNnIHdlIGhhdmU6DQpbIDQyNTMu
OTIyMjIwXSBtbWMwOiBuZXcgdWx0cmEgaGlnaCBzcGVlZCBTRFIxMDQgU0RVQyBjYXJkIGF0IGFk
ZHJlc3MgZDU1NQ0KWyA0MjUzLjkyMjQwOV0gbW1jYmxrMDogbW1jMDpkNTU1IFNSMDRUIDMuNzIg
VGlCDQoNCkFkZGl0aW9uYWxseSwgd2UgaGF2ZSB0aGUgY2FyZCBzaXplIHN5c2ZzIGVudHJ5Og0K
IyBjYXQgL3N5cy9ibG9jay9tbWNibGswL3NpemUNCjc5OTkyNTg2MjQNCg0KQXMgd2VsbCBhcyB0
aGUgY3NkIHdoaWNoIGltcGxpZXMgaXRzIGNhcGFjaXR5Og0KIyBjZCAvc3lzL2NsYXNzL21tY19o
b3N0L21tYzAvbW1jMDoqICYmIGNhdCBjc2QNCjgwMGUwMDMyZGI3OTAwNzczMmJmN2Y4MDBhNDA0
MDAxDQoNCldoYXQgdGVzdCBkaWQgeW91IGhhZCBpbiBtaW5kPw0KDQpUaGFua3MsDQpBdnJpDQoN
Cj4+LCBhbmQgaXQgd291bGQgYmUgYmV0dGVyIGlmIGVuYWJsaW5nDQo+ID4gU0RVQyB3YXMgdGhl
IGxhc3QgcGF0Y2gsIHNvIGJpc2VjdGluZyBkb2Vzbid0IGxlYXZlIGEga2VybmVsIHRoYXQgaGFs
Zi1zdXBwb3J0cw0KPiBTRFVDLg0KPiBEb25lLg0KPiANCj4gVGhhbmtzLA0KPiBBdnJpDQo+IA0K
PiA+DQo+ID4gPg0KPiA+ID4gLS0tDQo+ID4gPiBDaGFuZ2VzIGluIHY0Og0KPiA+ID4gIC0gU3F1
YXNoIHBhdGNoZXMgMSAmIDIgKFVsZikNCj4gPiA+ICAtIEFtZW5kIFNEX09DUl8yVCB0byBTRF9P
Q1JfQ0NTIGluIG1tY19zZF9nZXRfY2lkIChVbGYpDQo+ID4gPiAgLSBVc2UgY2FyZCBzdGF0ZSBp
bnN0ZWFkIG9mIGNhcHMyIChSaWNreSAmIFVsZikNCj4gPiA+ICAtIFN3aXRjaCBwYXRjaGVzIDUg
JiA2IChVbGYpDQo+ID4gPg0KPiA+ID4gQ2hhbmdlcyBpbiB2MzoNCj4gPiA+ICAtIFNvbWUgbW9y
ZSBrZXJuZWwgdGVzdCByb2JvdCBmaXhlcw0KPiA+ID4gIC0gRml4IGEgdHlwbyBpbiBhIGNvbW1p
dCBsb2cgKFJpY2t5IFdVKQ0KPiA+ID4gIC0gRml4IEFDTUQyMiByZXR1cm5lZCB2YWx1ZQ0KPiA+
ID4gIC0gQWRkICdUZXN0ZWQtYnknIHRhZyBmb3IgdGhlIHdob2xlIHNlcmllcyAoUmlja3kgV1Up
DQo+ID4gPg0KPiA+ID4gQ2hhbmdlcyBpbiB2MjoNCj4gPiA+ICAtIEF0dGVuZCBrZXJuZWwgdGVz
dCByb2JvdCB3YXJuaW5ncw0KPiA+ID4NCj4gPiA+IC0tLQ0KPiA+ID4NCj4gPiA+IEF2cmkgQWx0
bWFuICg5KToNCj4gPiA+ICAgbW1jOiBzZDogU0RVQyBTdXBwb3J0IFJlY29nbml0aW9uDQo+ID4g
PiAgIG1tYzogc2Q6IEFkZCBFeHRlbnNpb24gbWVtb3J5IGFkZHJlc3NpbmcNCj4gPiA+ICAgbW1j
OiBjb3JlOiBBZGQgb3Blbi1lbmRlZCBFeHQgbWVtb3J5IGFkZHJlc3NpbmcNCj4gPiA+ICAgbW1j
OiBjb3JlOiBBZGQgY2xvc2UtZW5kZWQgRXh0IG1lbW9yeSBhZGRyZXNzaW5nDQo+ID4gPiAgIG1t
YzogaG9zdDogQWx3YXlzIHVzZSBtYW51YWwtY21kMjMgaW4gU0RVQw0KPiA+ID4gICBtbWM6IGhv
c3Q6IEFkZCBjbG9zZS1lbmRlZCBFeHQgbWVtb3J5IGFkZHJlc3NpbmcNCj4gPiA+ICAgbW1jOiBj
b3JlOiBBbGxvdyBtbWMgZXJhc2UgdG8gY2FycnkgbGFyZ2UgYWRkcmVzc2VzDQo+ID4gPiAgIG1t
YzogY29yZTogQWRkIEV4dCBtZW1vcnkgYWRkcmVzc2luZyBmb3IgZXJhc2UNCj4gPiA+ICAgbW1j
OiBjb3JlOiBBZGp1c3QgQUNNRDIyIHRvIFNEVUMNCj4gPiA+DQo+ID4gPiAgZHJpdmVycy9tbWMv
Y29yZS9ibG9jay5jICB8IDU2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0NCj4g
PiA+ICBkcml2ZXJzL21tYy9jb3JlL2J1cy5jICAgIHwgIDQgKystDQo+ID4gPiAgZHJpdmVycy9t
bWMvY29yZS9jYXJkLmggICB8ICAzICsrDQo+ID4gPiAgZHJpdmVycy9tbWMvY29yZS9jb3JlLmMg
ICB8IDYzICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0NCj4gPiAtLQ0KPiA+
ID4gIGRyaXZlcnMvbW1jL2NvcmUvY29yZS5oICAgfCAxNCArKysrKysrLS0NCj4gPiA+ICBkcml2
ZXJzL21tYy9jb3JlL3F1ZXVlLmggIHwgIDEgKw0KPiA+ID4gIGRyaXZlcnMvbW1jL2NvcmUvc2Qu
YyAgICAgfCAzNiArKysrKysrKysrKysrKy0tLS0tLS0tDQo+ID4gPiAgZHJpdmVycy9tbWMvY29y
ZS9zZC5oICAgICB8ICAyICstDQo+ID4gPiAgZHJpdmVycy9tbWMvY29yZS9zZF9vcHMuYyB8IDE2
ICsrKysrKysrKysNCj4gPiA+IGRyaXZlcnMvbW1jL2NvcmUvc2Rfb3BzLmgNCj4gPiA+IHwgIDEg
Kw0KPiA+ID4gIGRyaXZlcnMvbW1jL2NvcmUvc2Rpby5jICAgfCAgMiArLQ0KPiA+ID4gIGRyaXZl
cnMvbW1jL2hvc3Qvc2RoY2kuYyAgfCA0MCArKysrKysrKysrKysrKysrKysrKystLS0tDQo+ID4g
PiBpbmNsdWRlL2xpbnV4L21tYy9jYXJkLmggIHwgIDIgKy0gIGluY2x1ZGUvbGludXgvbW1jL2Nv
cmUuaCAgfCAgMSArDQo+ID4gPiAgaW5jbHVkZS9saW51eC9tbWMvc2QuaCAgICB8ICA0ICsrKw0K
PiA+ID4gIDE1IGZpbGVzIGNoYW5nZWQsIDE5NSBpbnNlcnRpb25zKCspLCA1MCBkZWxldGlvbnMo
LSkNCj4gPiA+DQoNCg==
