Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EE4523A
	for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 07:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764054498; cv=fail; b=mbBAUGkA6DHM6ZNoMb1hef3ehWswLX1KWAmPziW/N7UMwSMAKS5aVkwFTmwwesN6IAfhBkMTC5SLwkQYBcH1Ua7+4u9ZXxx7ZsEsIsiVjlk0ZdFIHJ+i6fKyeLNk272ahpYr/5JNOVwNnj8Pn6I8pH2q8ZLKKgdK02BDgWFyuAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764054498; c=relaxed/simple;
	bh=gD2QvkV8a7384SsBcX9swWqrWILtkgeq9Iu97MamP9A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p/8T/0wxh7ghf6zRY+9r052/3Egu4albMJZ7g56dSPJ75AKmLSDqutznUbPAOodGonblV24ktyxen65rM8ucuWAxFG19z2SBEJc1mL6Anji7wZhlZ19XoUex+s4G8HR5lg5igGQ6WRLRjcZ6URqYpiJqpmE6xISn6J6pCTKurSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=MMv/87CU; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="MMv/87CU"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1764054496; x=1795590496;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gD2QvkV8a7384SsBcX9swWqrWILtkgeq9Iu97MamP9A=;
  b=MMv/87CUZuv6IHuilNAfYAHV0CbNIpzxA8i9u4nLxmeyM2KwWW92ZL4e
   vW+t1ibFjDOPje2RHUoMWY2H0KhvdbRHzC9xCVH2DhQBaFCHY4D7SbXD0
   t9TmsglPBjPL6Z8Y+EV/ahqtp0y2/Kfsje7NNEhrI1ODZOxKOlmxyiVFC
   iMpDoUDJgomOPX/EpETF7sEUQFirmUdpiTMn6/Bl9kMnloGQ+Q2KGeprU
   N1GImT+kKs0eplxcHC0X7nVUofVrSL4DDm5nCIQKLRIxopRn2b2wrtPC2
   MGxu7fHuRDnDXPZfOU+rksQauklwu52IQXQN1nKoL9pjKT62X5/gH7EQO
   w==;
X-CSE-ConnectionGUID: sWWp/6IZStKefRh5qznwwA==
X-CSE-MsgGUID: uCkd5lxKQDuCI4mZBKLHEA==
Received: from mail-westus3azon11022097.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.97])
  by ob1.hc6817-7.iphmx.com with ESMTP; 24 Nov 2025 23:07:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYeMAKSprVnOeu8VG+0qBgFtOuiAqaBDA++fVgpXlf6K6GthltCvCauFOCbMkohrIRVBJ2USvBhbGxGIYKYNjIqaQmbUfoVsWBSqip8icuk1S7SK1s7s0xDmR+7g2gsoaafUe/yp1WwSnIHWJSgJrvR78MdNQql6K0Egk3SD+j5tXc9JDD00/qYn76ESlo7/efp3x5PKfBeLQ1960gNtnCHc3vmE+ID99YmoCa2y4wluGE660Odw/n8EMVjhuC7Txna/f5xR0FAtUT52ywsaFkmhme1ZsCdphKSnnwee+dtv3tdNnteHhu1NHlY3xJReGsBVag73GMXkvNZCaVibaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gD2QvkV8a7384SsBcX9swWqrWILtkgeq9Iu97MamP9A=;
 b=kuyLfPFo/vMGqHpOGcRzyL1UYUvwbPCWjs7FFPq8/h7GNOAGN+3NE5Vxynwff4IyREmpgUT46E483EJRFb7rqSzw6P9XDlCeIwrmmayCB4YQPIsHi1BDXtG/CiPerbNLHPWuO7M64lQ0cobYfAC5bm+87cYESzyudgAa5Qq/TqP5uQAZKSwYWz+Qk1GvxDlvanf8TjZ1j8lCF8OYoief4eFeC/bdyTGxu8mXaP0ctuPM8jFOypWCCB1DkGvSpPEGB5+JsGHLV1AHkzLMIdgZG7X5ru5WsBtOaa5LdYy14qc4N1eM7ZYAYFyvZxOQ4S45EKVwK8dG7IX6DpDp2LDRNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 LV0PR16MB7012.namprd16.prod.outlook.com (2603:10b6:408:346::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 07:07:03 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%5]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 07:07:03 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: [PATCH 2/2] mmc: core: Add quirk for broken manufacturing date
Thread-Topic: [PATCH 2/2] mmc: core: Add quirk for broken manufacturing date
Thread-Index: AQHcW35Y+KUsWivi60iGUFRu2uMWZbUCkRaAgABrt5A=
Date: Tue, 25 Nov 2025 07:07:03 +0000
Message-ID:
 <DS1PR16MB6753C1E4EB804DA77041DAADE5D1A@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20251122070442.111690-1-avri.altman@sandisk.com>
 <20251122070442.111690-3-avri.altman@sandisk.com>
 <c0eefc16-9e85-4ca8-a32e-28878895c65c@rock-chips.com>
In-Reply-To: <c0eefc16-9e85-4ca8-a32e-28878895c65c@rock-chips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|LV0PR16MB7012:EE_
x-ms-office365-filtering-correlation-id: ce5d188c-4f28-4f02-11ef-08de2bf13c40
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cXZKS2VpZTdINkNpL0l6azZjUEpzeDFEYWVDVWRzWXBNc0gwTHlJSjVZTWxD?=
 =?utf-8?B?YytaRVcybERTKzkveUdVb0dyQllpMTBKN1k1OFFtamY0eVJpbnhGYVU1d3Yv?=
 =?utf-8?B?ZnRTOUxSZEVyKzBJdHUxYjFlc3VkeHRiUWRCc1lWYzUxWHVkbnhRNWl5dlU4?=
 =?utf-8?B?aEVCMU5BMUQ1OXBwQWg5ZXFJOVU4bG1FVm80MGpIQVpqM09MemV4MWwyd3p0?=
 =?utf-8?B?OUhlR1ZWTThNZitlWTRFcXFBN2hDRjREWHExdzNNRnYxN2ppMlVOOTViam5D?=
 =?utf-8?B?T3ZnLzJ3VjVJV0RWTkJSRVNiMnU4NzYra05JajBERjZJSkc2TU56T2l4UHh4?=
 =?utf-8?B?SGllZmpZUU1aSzBjejl1aDB4ZnUwRWttNklOUVBDRDhweHd4Y3lQYkwxaWpv?=
 =?utf-8?B?RWg1YWV1YlVUVlhYcW1mSCtwNUtFcG0wOHpWb0tZVytOYWhWK3UyNlNub1Jm?=
 =?utf-8?B?cXpCTFNidzhtM2lGYkt5M3RFQVkyNnU5bVQ1TGVYYmR2cnd3T1hoVitRaFYz?=
 =?utf-8?B?UGRmS1lvNXl2dkFERGdzWGZRR0Y3b2ZESm5kMFp3dnA3NXJEeTM4aStWK0ky?=
 =?utf-8?B?VnRwL0dOTkYyOSsvZ1JWYTNYb01IUERuSDExT1cxUERhMVdDUXk1VEVYaTQ0?=
 =?utf-8?B?QkRmZ3NCNm45bGt4RTlJQ1dGelk4U3NKeHZ4NVY5cUtqK2dPZjlOZ0lnMGRn?=
 =?utf-8?B?bC9idVZwdFhteFB3T1g1aHJsWkVMUDBQbzRvSnpiWU9VRk9vbmp1bitPNXNo?=
 =?utf-8?B?WVdHQng1Vlg0aUVINnd0eFdXMlhRYmpjSG1WTTRjbGZVdi8wVFpNd3R1ZmNN?=
 =?utf-8?B?SW9tMUw2R3JHWnI2Z3BXejg3TjZzZkk0bDNYSmVXREk1bEduTFY1L1BMcVpD?=
 =?utf-8?B?RmtJMkZVUkI3WEM1MGI3bW5iVjdLdE51b0dwaVdwcjdQYytEd29kRGFWVVZu?=
 =?utf-8?B?dGp3eldsOXZBY2FTazdXckRKYVlDcHNXbEdoNEY3WjNKMTlBYWVJRUNUWkJj?=
 =?utf-8?B?MUl6QTBEMXFQQkk3anB5S2JMZEs2MWpkbjB4cCtQajNFU2ViRENzY3IyZUdt?=
 =?utf-8?B?WjhWdDFuSHNCZ2ZmY2NQZXFuN0hRczV3OW9lKytDQW5UU09kWWRkYWF4SHNi?=
 =?utf-8?B?NldNQ1lBbU95UEM1cloyVXp0ODNKbzgrK1czTDBRREZqM05HaXRueWRIWE1i?=
 =?utf-8?B?WFd3UVRzeDFOTmlsSkhrTzhTMzRReW8vMHlFUUNWWUluWVVZN2tNYk9wa2lp?=
 =?utf-8?B?a3g2WUY2SkthckdWVjhFTTVKZGFlQVAzMnVNQmlpcG5USmYyamlMWmlQOGZa?=
 =?utf-8?B?NFg0ZFNCcFN2UGowQkdmb0VMdmV3dndWWW1OU2RDSm96WGc5YVUxNW9IQXVv?=
 =?utf-8?B?eXZiTEd5M2hpdThIREh5bDZRTzhlR2ltTnlHNEQzMzhzaW40QUlsQldOQTdx?=
 =?utf-8?B?eHE0MVhycUhTM1hmbkZkTlZaT25FeCtkYnkydkV5emNQME0yUW9MWnpaSm1P?=
 =?utf-8?B?NUUzc0NCZ0Z0enRrOXphWGsxT3g4L1VKaW03YWlzYnB2dWR1dlc3OHRzT1pM?=
 =?utf-8?B?TExSMEp0dFZIazJpS0hUdFNScnpYdlZEU20vSnc0TnZjTlFhZzVpRXFkNVl4?=
 =?utf-8?B?OGFCTUlVR0dzT1pIY3BmQlVKbXZ5ZlI3YVoxL3h4TVhLcU1BTFN4S1hYR0ho?=
 =?utf-8?B?WXNtMHBhaENrUjh3MU16M242ekE1NmNMT2dMR2Noem15QW5SemtkSUVHWFA3?=
 =?utf-8?B?enR5d0d3a0NrRlYxL0tWRHE3UCsrbWRaWFBCcFpmL1VMeWkrS1NpY0puQ0xj?=
 =?utf-8?B?VHhLTjBtejI1NGpFSk9JamFYaG10Y2l1eGcwblpZRG9ROGtLTEJ2cHpmUldF?=
 =?utf-8?B?SHdSNXR0STRFWTZ1dWVVQ1FWV0FnVDlscUJDOU4yM2VMMlc1bERoZDZQbjRa?=
 =?utf-8?B?dW82OWpuV0ZpMDFJNnJsWDNhZElud1M3Vk92U05HelVIQlBwYVFnVG9haXNM?=
 =?utf-8?B?QVZ0SFd0MXVuM2VwOGpqbGZDcUR2NjQ1YzA3NDl4ZjRZbmtWaHJZVVJ1cS82?=
 =?utf-8?Q?dnfjfv?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bzRncXp6UGFFVTFRMUxUZUwrdmxMMVhnQmpEWktxU1l4QS9kaFBYb1lVUm5q?=
 =?utf-8?B?am5ZVzRWQXorZGRPWmg1bHVtZ1VVVmw3QnpIYWMvaUFiMDFaNzFlQ01VM1Ew?=
 =?utf-8?B?eWJ4T082dVcxdWlOSXVEQUtKRHBlajdqa0tGV2llaHorV0pBbEd5empqZ00v?=
 =?utf-8?B?U0RYcDNnaVY1VVpiaVdJdEtnaTRLTXZUbjJzcWZrWkQzc0pDUWxvZnU1R2pj?=
 =?utf-8?B?Uy84QXd2aXFEWTh0YVFuNlB3eE9mUnpSYjhNa0dXZnc2cmNUTWE0cXcxZnpY?=
 =?utf-8?B?L1NzTUFtTDBjcUxYSzNiS2h1dGlSNnJmYmF2SjZ0YVZOWWg5NGprRE5rZGpO?=
 =?utf-8?B?OEtqbjRacFlwNUlONFNLclhRM3VOTCtmSllYdm1VejRpdFc5TDFzNEViNUhI?=
 =?utf-8?B?ODdTY08vWDJFNzVzUkFYSSsySmZTZjBmUFdwMU56R24rZEtLUS9zdmY3WFlw?=
 =?utf-8?B?czMxSTBiblNVbnlucHVPcG1OSDBITndmNCtJUlpQNE4vdlZWYW1CVzVPblhl?=
 =?utf-8?B?b0s3b1NpT2ZsSkh6RGFQaVRSeldQUnU2RHBNY0h5QkVodGt6enFnMU1HRzdo?=
 =?utf-8?B?Mm5TU3JsbmVwN3BLYzQzWHZSZmlUK2dMUC9xRUJUSFVBZWlDcWEzMjdEQU56?=
 =?utf-8?B?ZExLd0JxYkhuZDJ0K0N2Y243Rms4ckIzakhMSHAxcVBjN3JzbDR4SHV0b3FP?=
 =?utf-8?B?UGVMRERZNlJUK2labU8xZHk3alo0eHNOMlZOdHE1QTZsSFdRWTFNVjgrMlQw?=
 =?utf-8?B?YmpMbVFFblVUYkNtd1FSd1FuYUU2YVg5eUIxUXAwZnpqR09OaW91YjJqczF4?=
 =?utf-8?B?RkZUeXhEaXRNYW0zMDZHcDIrWlVDWU0xQjdRN2MrdjUzdFZHZERCOVBSUkg4?=
 =?utf-8?B?RytTUXMvWXkrbWFKMFcvM1RRVUl0VERJd1lWUnZwNEx0Smp4MWRYOC9XdG1M?=
 =?utf-8?B?TWw5TE55NFJRN2ZWbWJwUmg4aUEzNER6Q2hFZkh1azMrUmUyMzdoenQzdXl1?=
 =?utf-8?B?R0VlM3QvWm9CVkNNK3JLaWpGK09EQkZxVExZWUcyTG9hMTN3eWZFaS9uSlRo?=
 =?utf-8?B?TEJCVi9xRkNzd1VtV3lCTmJFWStmVkJucTF1WkRIRUtKS3lUS3lGbjh2QXBV?=
 =?utf-8?B?QzdpdXZKQ2JZU0hwK1FPM2R4MUlMeXJFcUQxTCtvd1Z5TEJlaUhPZXBRTjlt?=
 =?utf-8?B?RUdOU0ZrUnlNVStIYithd3lCZnJ6TU5QRE5qNDN0a0RKOUtlWU5Db3pLWUJt?=
 =?utf-8?B?aFUwcFFCdjNHazdsS0gzOFhXTUM0b1craGFhc01MblcvUlN1RTIyRkVXSW9C?=
 =?utf-8?B?TnpWWXBGY2RYWitQa3phQTY5eUhjaWZyMS9kcmxZVnQ5Q2FLN3dMUkhPVkZC?=
 =?utf-8?B?WTZ1MWtmcWhUekl2blJ2VHNlM0o2WldMS0pkZUJKWTNZWVFTVzRZMHhHZ0x2?=
 =?utf-8?B?VTVSMDlxc0ZEdzhkamszNXl2aXBVV3VWS3pMS01NRjdpeHA0RTM5MnZlTGZV?=
 =?utf-8?B?bjI2YWxSaGhNTXZuaitSRDJLVmpESno0ZkJsR1hmUVVMajNhVnJWOXVjZ2dM?=
 =?utf-8?B?YWFBcUxYaDFobHNTUC9qTGZ6ajlIVjNjU0xBL0t5bno5YXlWTXJteHpXeWps?=
 =?utf-8?B?VklsNG1jakhtLzgweEh3VXFvSHZZTVhqRW04bm5pWGNKV0dDNmhHaHA2ZmJm?=
 =?utf-8?B?Zk5HQng1dW1sN0hMd2liOG9iQzRSVGFkdHFXb2NITU1YQk9LeUR5RzhZZEdK?=
 =?utf-8?B?U0tCT2lFRkIxZC9tTHNxZk45b3VkQUhLR0I1RzhjM2Myam01WDZVM1hIbkFV?=
 =?utf-8?B?Z1dVVU5VdWNWaWpXUFpmb05hRlhpZTNPMUVidHo3aG9uTHdZL3hQd3R2UVhS?=
 =?utf-8?B?WElNUjBhaHhEMm5ERGRPRFEvdXdoMUhJRnM0UVlEK2ZUZjRpMG9uZ1ArL0tl?=
 =?utf-8?B?c2hNV1VjTkhUQ3ZJcS9yNnZOMnFLSVJ6Qi9YeGtLUU95dlRxRVpsOUdDQUwv?=
 =?utf-8?B?cGsycDRvaXNqY1RjWlhRZUIvQlUvTlFJUTZVUVhnRmhIT0drZWplVWd4L2Jt?=
 =?utf-8?B?aWV1c0JHN3N3V0xXUlhLWnB2Y2RPL2dHaENuandBUzhqdVpCb3h6N1h3WFhS?=
 =?utf-8?Q?xKQDvRoXFBkgeWDNv4DwMAf/9?=
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
	ShQL22DgqTWdaSLdAHex9B2O0xeVgMHQzxq14r6ViLSWvp7Rf/bsRrFyw9J7K11wOmZTny5s1Bf8rCaXnqhDh55Yt0QVl0gsN8qTB3EO04+5TCqOmSsAXO5Urjerb2hEyn0/+rm/hm1lcpPo40Ecb/gl0pGTmBK7+44SdC4Xc+EN8TGq7NIQW6C3oLtw7e32xNDUbNi29wnfwaFI68PReJXhaeJCYEX/pkCxi4rlhR5Gtk4vdGwnys4+ziqD4J2uKC5CmK8Gd89S5rSYsasn/cbtq9GekpIJQkQPc075H3m0F+djgqrg/1pYmzFqL0By/CxdeW8Zz5lu3u+NgTW7sBTSENo7chJsbKuGnLy8bjYFlgfwG2IPgf7huJAJGPj284dlQuSjqz6Zb0KU3l78sTKUKQa9AiFHaaHm4TlECkUPYg4NpHG3OGSACAO6EUWQ7WTHTfk8IYy4EsMX2oJuaUNkda/AnyqEgsNW51B9uvolRcMKk05+2WdcqOnoXgFK4oliNbv9eZr/KzVLt4FCheM48H53+QB0xqWIaV2qm7pSqYDFdpoqiQWQ8uJbAa2Ps9ZNr9G3IqjSgiWsTL8fdSIQoFx7pFn2umx3by+GUTEimDb4LVy99cH2bUZHEvb4svGfqmyraHtiUrGIi8bmvg==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5d188c-4f28-4f02-11ef-08de2bf13c40
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 07:07:03.0744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SfcQDGVfUSUzmKnwHvNgf6HcZKQPbBa4oQyMy9rEJ+kzSc+6pyb5lGN20ubJ6JG82W66ekxoELbdFu7yTcuBLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR16MB7012

PiBIaSBBdnJpLA0KPiANCj4g5ZyoIDIwMjUvMTEvMjIg5pif5pyf5YWtIDE1OjA0LCBBdnJpIEFs
dG1hbiDlhpnpgZM6DQo+ID4gU29tZSBlTU1DIHZlbmRvcnMgbmVlZCB0byByZXBvcnQgbWFudWZh
Y3R1cmluZyBkYXRlcyBiZXlvbmQgMjAyNSBidXQNCj4gPiBhcmUgcmVsdWN0YW50IHRvIHVwZGF0
ZSB0aGUgRVhUX0NTRCByZXZpc2lvbiBmcm9tIDggdG8gOS4gQ2hhbmdpbmcgdGhlDQo+ID4gRVhU
X0NTRCByZXZpc2lvbiBpcyBhIGZpcm13YXJlIG1vZGlmaWNhdGlvbiB0aGF0IHdvdWxkIGZvcmNl
IHRoZXNlDQo+ID4gdmVuZG9ycyB0byByZS1wYXNzIGFuIGV4aGF1c3RpdmUgYW5kIGNvc3RseSBz
ZXQgb2YgQXBwcm92ZWQgVmVuZG9yDQo+ID4gTGlzdA0KPiA+IChBVkwpIHF1YWxpZmljYXRpb25z
IHdpdGggdGhlaXIgY3VzdG9tZXJzLg0KPiA+DQo+IA0KPiBBY2ssIEkgZnVsbHkgdW5kZXJzdGFu
ZCB0aGlzIHNpdHVhdGlvbiwgYXMgd2UgYWxzbyBuZWVkIHJlLWNlcnRpZmljYXRlIGVNTUMgY2hp
cCBvbg0KPiBvdXIgQVZMIGlmIHZlbmRvciByZW5ldyB0aGUgZmlybXdhcmUuDQo+IA0KPiA+IFRv
IGF2b2lkIHRoaXMgcmUtcXVhbGlmaWNhdGlvbiBwcm9jZXNzLCBhIHdvcmthcm91bmQgaXMgbmVl
ZGVkLiBUaGlzDQo+ID4gcGF0Y2ggaW50cm9kdWNlcyBhIHRlbXBvcmFyeSBxdWlyayB0aGF0IHJl
LXB1cnBvc2VzIHRoZSB5ZWFyIGNvZGVzDQo+ID4gY29ycmVzcG9uZGluZyB0byAyMDEwLCAyMDEx
LCBhbmQgMjAxMiB0byByZXByZXNlbnQgdGhlIHllYXJzIDIwMjYsDQo+ID4gMjAyNywgYW5kIDIw
MjgsIHJlc3BlY3RpdmVseS4gVGhpcyBzb2x1dGlvbiBpcyBvbmx5IHZhbGlkIGZvciB0aGlzDQo+
ID4gdGhyZWUteWVhciBwZXJpb2QuDQo+ID4NCj4gPiBBZnRlciAyMDI4LCB2ZW5kb3JzIG11c3Qg
dXBkYXRlIHRoZWlyIGZpcm13YXJlIHRvIHNldCBFWFRfQ1NEX1JFVj05IHRvDQo+ID4gY29udGlu
dWUgcmVwb3J0aW5nIHRoZSBjb3JyZWN0IG1hbnVmYWN0dXJpbmcgZGF0ZSBpbiBjb21wbGlhbmNl
IHdpdGgNCj4gPiB0aGUgSkVERUMgc3RhbmRhcmQuDQo+ID4NCj4gPiBUaGUgYE1NQ19RVUlSS19C
Uk9LRU5fTURUYCBpcyBpbnRyb2R1Y2VkIGFuZCBlbmFibGVkIGZvciBhbGwgU2FuZGlzaw0KPiA+
IGRldmljZXMgdG8gaGFuZGxlIHRoaXMgYmVoYXZpb3IuDQo+IA0KPiANCj4gV291bGQgb3RoZXIg
dmVuZG9ycyBuZWVkIHRoaXMgcXVpcmsgYnV0IHdpdGggZGlmZmVyZW50IHBvbGljeS8gYWRqdXN0
bWVudD8NCldoYXQgZG8gaGF2ZSBpbiBtaW5kPw0KDQpUaGFua3MsDQpBdnJpDQo=
