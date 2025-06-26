Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0F6219E0;
	Thu, 26 Jun 2025 06:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750920723; cv=fail; b=ut0xx1Ff1Sm3j1fg/ZjGHQffsoUKprnMxLI5uFnNZVTU9toL+OGSJwaDASE1s/lYvRJj2FNEA3Vv/yjpBwP/TEEzH6UDLkPfkwAomVU+uOllEFDOAjJxlXEjazwyeAHeKdfG6EV+F5fT0giR2CWXblIfE62p0pLcrllOijwoFF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750920723; c=relaxed/simple;
	bh=2PAdhgBdnGKCJD68gy4hwn2GvsDGyKVf6wNv08H6GYY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h0zEP7kAT4Om5L+JXqL+AXSJf93NDiaCrdzDSPWfs8sEwQYzfx8qAApbipP8p7tQSi49J6pe168zTQDmg0fsXSl9hP6wuMv5Ah8AY5o46QGud0vekl8xkPJskZazkul3hTwIuomv79ZpMmmI94kmqG2cCasYFU5Ou1VRkkJ3/4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QEHBUHfq; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QEHBUHfq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750920722; x=1782456722;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2PAdhgBdnGKCJD68gy4hwn2GvsDGyKVf6wNv08H6GYY=;
  b=QEHBUHfqJL7omFlnWa2cvpTWUt4ZYLTXk+qFEFPYLasLdUctlpjsOhbw
   Z7sLW86MFaQpT03+Sn+ij4E9rBpt4skZcp4Oifmj2rthBsLVSGlVaAvKA
   yBjqomRzM25REqU8OVtG1hh4LuCjMEMGMTD2Hns2Zh/g/VlQZ6fxrqeJa
   hNWX+n/rF5IwzB1SO2orYtV6RCaZn6IZdn0fLd8EYtcze+Ih0NbjMGSnG
   UI3x2NDliwGzcBqxStNT256oduCI85MYDkb32Shn/lOpOaV+BhN+RvCyJ
   LgtNmnNgP3/q6wy/Fss6p6/80nnNvxQCpuZoJAv+c8lrpVaKgj5Zhax+E
   Q==;
X-CSE-ConnectionGUID: o/AQlqA8Tam1eoeVRCg1+w==
X-CSE-MsgGUID: 4OBHCFj6Szmw7oNz6Ff2ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="57011316"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="57011316"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 23:51:52 -0700
X-CSE-ConnectionGUID: nbE3MnNcTxGQYtZ+SawHtA==
X-CSE-MsgGUID: AL5WU9roRweIvzzMtmXV1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="151947805"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 23:51:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 23:51:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 23:51:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.56)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 23:51:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5R3jDTIIGKiCvRYjlvkejsJpgbhX5s1gIukkhnZuYobtrXzYJsGm7cpKeDHHNVeFHpe5TXvfoYoACnCwFFK/CP0zicc16A6+NmtysvIwizi2BlHsn0eZ+/rEkwjK6X/3waDksDcYLCNpV11HEZLd4VeHzfqtp9P0L0p+VzZdnZrka7nd2K+H9/dI7h3O7AteEVpX7NWo1t8hqw2iSFJkGpWz3Rn0NGXoe3VM6My33iy1xOo62eB1zqX7zgs2AHGca9oDZxEmEfV5/gaBVWwEBVDnAoL6l0ywXgVXI1cTIXUJDbyP36BoDAIljV/INtLRpqb7b5+fAPPBPJkMfu6aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aR4C6yQECsWVisJKQMipZAirWurqIkTHv+BxqytxM/4=;
 b=f2oZ9YOc/eWw3+eO/pzfTDjTRTn6ou2dWG/KjWwOvNvTwKGLqlxAMA+2hS/kzIBwz1HYxHzxEK9AgXNSHzEKYjvhqg8loul9YksD8j+UfVdEzb1y3Gsnjm51+d3NxR38tBR/KgT+QXaC4KEjYWeRJhiUci96cSFloPjIfQIPRsglGcx/XxTX8yruxA6i1YR5msPKkPlRt94FbwkXud4MaZw/jKQBmJYtYc3P+p4GjLehoOdul3mEH0nNNSfgiezGQHFMB+wSPpapn3MxdMtTjruNmw8vDJVUz+Bp+LgUBVmdfRYwVgzHe0Z3dDN09DgOtqvDmvQwopc/jDkuykHaNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2708.namprd11.prod.outlook.com (2603:10b6:406:a9::11)
 by DS0PR11MB7577.namprd11.prod.outlook.com (2603:10b6:8:142::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Thu, 26 Jun
 2025 06:51:34 +0000
Received: from BN7PR11MB2708.namprd11.prod.outlook.com
 ([fe80::6790:e12f:b391:837d]) by BN7PR11MB2708.namprd11.prod.outlook.com
 ([fe80::6790:e12f:b391:837d%5]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 06:51:34 +0000
Message-ID: <b473517d-3a59-4554-9673-a49b9e3a84f7@intel.com>
Date: Thu, 26 Jun 2025 09:51:28 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mmc: sdhci_am654: Workaround for Errata i2312
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Vignesh
 Raghavendra" <vigneshr@ti.com>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>
References: <20250624221230.1952291-1-jm@ti.com>
 <20250624221230.1952291-2-jm@ti.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250624221230.1952291-2-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0521.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::22) To BN7PR11MB2708.namprd11.prod.outlook.com
 (2603:10b6:406:a9::11)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2708:EE_|DS0PR11MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eb97752-88ba-4efa-11d6-08ddb47de33d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eForb3dCZEFaa2MwWWppZjR0OFRYUldVa01zT3BvK2tTUndqbGhReWZJMGVi?=
 =?utf-8?B?OG5FcTFuM25uZkdwWDRDaWpjKy83ZGNaZFdCRUp6RVo2MVErL1FUcUcyMHh1?=
 =?utf-8?B?dXJ5aUFGMDNPS3ZOdUQxZEFUTk1md1BTcjF4c25Xc1dzOEtNYTVGYkVlbXc2?=
 =?utf-8?B?NFNNbEtNSVQ2dHFHNk03UjJ1cFFKRnhVL0hjeWxxclI5TWM5VjFCYjg2eWVE?=
 =?utf-8?B?U1BDRUEzZ25saFRQVHlpN3NyM3ZIQ0JnZS91MlNtY2lXbFpzR0puLzlqY2lv?=
 =?utf-8?B?VFdhTzdZUHBCaDlEQUFGNU9OdjBjV0xMMnQ1MEdQUk5nU3RXODVRMlRlTEZR?=
 =?utf-8?B?amU3NVo0WFhEVmZsUTQ2L0xTZE45dGZwYnRzZFZhMFZLSXhMeVc3RDE4Z0hx?=
 =?utf-8?B?b2dSQitiUlV5ejk4MnR5RUQvM2pSWEF5Q2lnYWwrbkVNSzNaS3pKaDBRaTE0?=
 =?utf-8?B?QUptVjY3b1lBU2xWSloxanJ3SkkxRkplUzVwNEEvTy80L3RXSE44YU9NQ3Fh?=
 =?utf-8?B?YXEybklTek40YWRnd2F2Q25wK0gvZUZkcEtqU3NyOGlJM25LMVFHQUdyZWtJ?=
 =?utf-8?B?Q2ZCaWRhTnJhMWNpMXcyamxFWURkNEhJKzBQMW1XRlBXRHpsTVl4TW5HdnZr?=
 =?utf-8?B?UGZGaGxBdWluSTRKaDJHSzN0bU1CVEoxSHhKMEdnNHJQVm9hL2FnK2JIdG8v?=
 =?utf-8?B?WHMvN0ZoYmJRVU1hb1BBRWdhWGRibzMrUkNLbHJJUCtrbHVSWHE5QWFpYzgr?=
 =?utf-8?B?YndSR2NLRHJkWTdpQUtHeVpaTkIzSUk1WThXbm1oTXF6M0pXWEI4TC9aMVFZ?=
 =?utf-8?B?aW9RNlNKWHNmTFFrdG55VmVHRFN1bm5IOE52MzdnK25VNWVac3dtMmx4aDIz?=
 =?utf-8?B?Mi9pd1dXWUsyNmROV29Lbm0wbjJxcTJTNlNRQS9mK3A5SmVVenlWUzMwMGJY?=
 =?utf-8?B?MmlGQWZLUWN5ZVNLOHdsSFNsVGQ1UWlJRlZBckd6K0EzUmNtcmFmR2g3em9G?=
 =?utf-8?B?MCtURDNtaEgyVFovQ2NXQzJvSHR5V2I4N3ZGZW1WaE5DQ3hjZEo1Q1FmaW4r?=
 =?utf-8?B?MFZhVnV1dUxuMU9acTBPQ3YxRktNNGtNTUI2cmVpTDUvSlBHWWxhUnhXTFl2?=
 =?utf-8?B?d2pETDFydnRwYUdDcUg3andId2NFOUlweEUyVWRCYVBZT2FuWWdadjVubmVX?=
 =?utf-8?B?VUNDdHQ1Nk04Qzhib1RSYm9YTGdBbjNOcW5uZG4ram5hU1k2bXJmRCtVQUxv?=
 =?utf-8?B?U3ZwU2dGZGw0djhhcGNnRm1aVTlaOFcxY0hkQURBb0pHSm1HcXJSQi9rTnZE?=
 =?utf-8?B?c09QVHB0ZzJzakNicTluMkdYL25kcjIyRWc1QmNRYTNlNzk0bUFFaWxxeG1T?=
 =?utf-8?B?dDhSVFRVUGZZT3l6enByT3N0VjZFaXM3ZHVyQ1pDRkE4Q1QrQ2xYZzRXYVBC?=
 =?utf-8?B?UmZ1WjcvVS94b29vTW1xVmN4RmIvTTQ3c1F4RTI3QVI5dDdWNXNUbjY5UEJs?=
 =?utf-8?B?dGp1MFRnb1ZzaVl4Qnp3dk1NUUhrcWJFOENlRnk1S3B6SFJNcEtsQm91STZZ?=
 =?utf-8?B?ZmVsTVV0VU42bDNzOEsxcjJXNEhocy9jVW1JaDQxZW9wM2J0NVRXSHg0T2JQ?=
 =?utf-8?B?a0dPcmozWnloUXJPV3JwSTdtTG5TQzNYZ0xDWk1LdEVGVlhRQ0xvTHFWTW1O?=
 =?utf-8?B?N0cwYTZCTVFvU3RoYWtTZnk0MktUV0h6MFBHblVTNGNyc1FFcnp5akpOcm0r?=
 =?utf-8?B?SEZ5cTBvYUloV1JZY3E5ckFBVzkyN2dsNWJoY0tOc2M5YnQ4TThJOExSNWZa?=
 =?utf-8?B?OFdJd08veDVGWUQ4S0lIbU1JY3ptekZ0blVwVjY3bE5IVzNtYnplVEx6eXNx?=
 =?utf-8?B?QWpQYnMzY2pua0k4S3lKR20vNThMTWxOUHhiemZ3S2Y3RmU2T09pKzV2NnJ0?=
 =?utf-8?Q?NBZqxDlSFEI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2708.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGFkUklVc25YSGRnL1FHNmErMC8rTVFPOHphVEJMeGZFNVJvdFdmWmxyTGhw?=
 =?utf-8?B?aWtYK0tVcFhXakROOUQ1SHYrWXpmTDlpTFVFRk1OSDI4Z2tFemd3Z0VXR1Nu?=
 =?utf-8?B?c1ZnSzMzNWZ2YW00SkRGbFNleUNlUmp1YnZwQnFDUUpxcFF6NjRhazVFc0Jw?=
 =?utf-8?B?Sm5YQU53bHhoeXdqSmxXeU1HMkJVa2VhMmZFMWJTbEZzQ1BQMHZ1TVlxR2lT?=
 =?utf-8?B?cW0xL2NjRFVHV3JBNW1qUHVpTXBpWllpYlhZcDF3bWJHeEFIdVZPK0lsd1M5?=
 =?utf-8?B?ekxWSW9qVXFZRWtQUHdsNWd5M3ZtTWNLTndRMk5Nb1M5ZGtXTHd0TzRvd2F3?=
 =?utf-8?B?SDh1bXdlQTVYVk82SlowMUJURzBHYnpsZURzb3dMWVVEV3ZXaHZXaXNKTUJs?=
 =?utf-8?B?VW1BZjlYN2NNQVZPaFFXanpFamhiVUVmTHBVRWRyK28zTUJxampUUktPRWly?=
 =?utf-8?B?bVd4M0xBUFg0NTBSdkF0RFhRVUQ5cW1GY0IxNGhaaEduSkVsbkJKN1RobVBo?=
 =?utf-8?B?OTdUVjc4SzdGREk3M1JoRyt1aEk4aDE3L2NZQUhWQUZrVTNCeDVtcERnS2NC?=
 =?utf-8?B?RGdkZC9uVHZJZHNmWmxjTVhDeEJWK2FnVysxL2ROd2tuK1BiN1J5VlppZ21Y?=
 =?utf-8?B?ZDVVS1FNakViSUJwMTN2ZVRhUWZrSHlTUlcrdkdxMGY2SXNDVWw4K3o5R0I1?=
 =?utf-8?B?SEM4T0k0RnBYRUpxbnA0UklpQmFEYmlhbHI5VzNnaEtZZmxJTEYwL1hxdG5m?=
 =?utf-8?B?dCs4NThBZU81TG9Oc0ZNMk9RSnpKdFRlSFM0WmQzWmh3MzVGYWF2Z0twc1JQ?=
 =?utf-8?B?Nk0xcFNaRXZCNFNENFhpVEw0K3NWMUIzMklUNkU0emRYdDh5MlJqNHFJdkpx?=
 =?utf-8?B?K0xYOXhrNkdQRnF2RDJVQy9oaEUxUmgrYVpnS0dmSFhtSEtlc1k1VHYrQUl0?=
 =?utf-8?B?QXJHRkd3SEpDQkROM01VeFFpUGJ4Vzl6TmZNbURCSlVaV1NmRXhwTi9kMUR2?=
 =?utf-8?B?SmlQWTNCbGNCVm82RzJYMzczbjh1bXVZcW80c0lhdlFjV25TbzFBSnhIRzgy?=
 =?utf-8?B?M0ZGUTEvdFJCQUFpSVB0RDVuL3pIaGRwQ3dCZTY2QjlHNTdYL2NsM3FsVTdX?=
 =?utf-8?B?UGxNcEtyNkRBMjVaTG40dHd5c2pmTW83NlVHMkUrMEIvSm5pRmh3MnFBZmFP?=
 =?utf-8?B?RnlvQ0R6YWNLQXZ1TTVIdXUwTDI1TFp5akpQQTJhS2s0bjQvSE8rZnRYdTAx?=
 =?utf-8?B?UElIdk1hS2hDRWFCMXlyQnptS2Exdi84MzQ5SUVOQUF6SXA1S2dzSDFSclNr?=
 =?utf-8?B?SE5namVlcy82dWJnU3dwMmlkSC9Pbms0SmpBSitNT3JlQlIybGQvcEY5enl0?=
 =?utf-8?B?V3Rma2tNcHMyM2M5Q2pjeVlTK1hQYUg4cW1ucE4zQ05ENkl0SUx4dzVETXdK?=
 =?utf-8?B?VmxSb3dmQWx1SjVmZzJ3T2k2S0k1MUV4RHQ3N3RGMkc1aGlSVzFHb3d5K05S?=
 =?utf-8?B?NEZESFF1Myt4cTRBbzRBOGpVNGpvZCtXMXU3Q2dqaTFUM0V1VExqemJxT3BX?=
 =?utf-8?B?d3lpWldrRFVESitPWmZsNTBmT1ZIWjhUZy9MWWMrbVRWdGx1YVNBenFHZVZV?=
 =?utf-8?B?bnB0SFJaMFNFbXJyUTVvTkJMNnlXc0dqT2UxWURPNm81TzlDL2JlMlhTdHcz?=
 =?utf-8?B?R0lFV0NnbllkcFNNcDBIVmY5WXBhMWRkUHdCWTUzd0h5VDIrNHZOd0o1SHly?=
 =?utf-8?B?dnN0dDI5VVdKN1p1THZRMXVjR3dhN01mVTJZd01VdnA4S3drak8vMEJxNFZs?=
 =?utf-8?B?dk0vR1VpbGZKRFBWbkVTTFBTMkcxK2lxSkVMS2FVNXlaTWZydFhBOW5CTE1I?=
 =?utf-8?B?VDdaQ2ZkczYrRUs5RUhEVkhkWmtENi9RNTVLYktXVjFzOTg0bGNSMHN2ZmVL?=
 =?utf-8?B?S2tJNGRqRUlFb2tYUDZ5SnpCVCtsSE42ZmpzckhNd21ycUNCa2xoN3hyaE1w?=
 =?utf-8?B?WGI3Nk1wNlR0RStUSXgvOUg4QVJhV2I4Sm5Rdm55bXRUMmVlWDRxOTI4WDE0?=
 =?utf-8?B?OXlEdTZ1Y29OMFJ5eXE5cXdGNXNTbXB6cXozUS9LZ2VQUDRxOVNLbEFBVjB6?=
 =?utf-8?B?RW1PMzZRdE1qdzNyUGVtRHNwTWZ6QTdsN2g2ejVzR0RjK2EvMGNnd0tJNkk2?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb97752-88ba-4efa-11d6-08ddb47de33d
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2708.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 06:51:33.9938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjjZvUrlFrWegv9FiRz6JSUvwuriaW2KISwsgX0+y6Yp2VnGMuW4N1lMYDeYsFmCP6oxlUpTtiaFdtuTps0z2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7577
X-OriginatorOrg: intel.com

On 25/06/2025 01:12, Judith Mendez wrote:
> Errata i2312 [0] for K3 silicon mentions the maximum obtainable
> timeout through MMC host controller is 700ms. And for commands taking
> longer than 700ms, hardware timeout should be disabled and software
> timeout should be used.
> 
> The workaround for Errata i2312 can be achieved by adding
> SDHCI_QUIRK2_DISABLE_HW_TIMEOUT quirk in sdhci_am654.
> 
> [0] https://www.ti.com/lit/pdf/sprz487
> 
> Signed-off-by: Judith Mendez <jm@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci_am654.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index ea14d56558c4..86d87d8e0675 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -613,7 +613,8 @@ static const struct sdhci_ops sdhci_am654_ops = {
>  static const struct sdhci_pltfm_data sdhci_am654_pdata = {
>  	.ops = &sdhci_am654_ops,
>  	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> -	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +		   SDHCI_QUIRK2_DISABLE_HW_TIMEOUT,
>  };
>  
>  static const struct sdhci_am654_driver_data sdhci_am654_sr1_drvdata = {
> @@ -643,7 +644,8 @@ static const struct sdhci_ops sdhci_j721e_8bit_ops = {
>  static const struct sdhci_pltfm_data sdhci_j721e_8bit_pdata = {
>  	.ops = &sdhci_j721e_8bit_ops,
>  	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> -	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +		   SDHCI_QUIRK2_DISABLE_HW_TIMEOUT,
>  };
>  
>  static const struct sdhci_am654_driver_data sdhci_j721e_8bit_drvdata = {
> @@ -667,7 +669,8 @@ static const struct sdhci_ops sdhci_j721e_4bit_ops = {
>  static const struct sdhci_pltfm_data sdhci_j721e_4bit_pdata = {
>  	.ops = &sdhci_j721e_4bit_ops,
>  	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> -	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +		   SDHCI_QUIRK2_DISABLE_HW_TIMEOUT,
>  };
>  
>  static const struct sdhci_am654_driver_data sdhci_j721e_4bit_drvdata = {

