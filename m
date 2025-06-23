Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9521E7C2E
	for <linux-mmc@vger.kernel.org>; Mon, 23 Jun 2025 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750667210; cv=fail; b=gFcBmPC+U+MzHye63DALDz4wG7kV5XRrbzZpgWGoMkbIbHR2nltDf3JML/5KPI63OtIwoD6m1NW3c8oYWiOwsFmJdMQKAaM7FLmSzdc7rDuvVvKwgjQmNAZHefEXy9NUqAVQ6xU2vvYh8sjSqpuStoPqGc2lmPAjENnF/AkOot8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750667210; c=relaxed/simple;
	bh=HuheRyWq/z/DHua88FE1JLuqEnQNT6rWGpi8972AOQU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qDAethAF3MW8loYiWhE1OlX5wjup8cql76LClFVzEinPrtogETquKI9Mimu6XGRQctVOvtapsGtCoszjhGLoX4gkhEiXjxz56lXTFK8/iNKsaUa2oo2l0VXPhP8eXeYH9upyTeltmvcKUW6D5zHOYpvzp+IzblFKDt3zfpdOHS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AxDkwlcB; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AxDkwlcB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750667209; x=1782203209;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=HuheRyWq/z/DHua88FE1JLuqEnQNT6rWGpi8972AOQU=;
  b=AxDkwlcB+UmpaiEqGzXysPq7WxxUrCPCxgpfsA5CHB5cs4aTTe2NS9WL
   HSPg2+F8siTk8Rdp56v60oVkffyKlBzmX1afQNwEscQROcvXvZuoL93+V
   BEaQy9ufTJG05lj0FUpgGsBBLPmLBz8lXAM+he0888o5c0sCgTpYyMoyT
   rtlgsBWREWyrajL9FBx/x6kbTBjGVumH5rhQ0/ng6BXLa7/tR6/t9SBia
   Ic2spKkDf16Q23qOvsCDNyu153prNu9XY50xgnfYfdLDzuCDitgFDl9OJ
   hMJHBHzZPz9zCs3wCppoEceG3LnylomPBbIT/1sBxBVJVI9OGOjVYEe9U
   g==;
X-CSE-ConnectionGUID: 3nfTAEW7S+GmyYkqoNW6cQ==
X-CSE-MsgGUID: W3QqANH1QBSEYqy/d30Mzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52996695"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="52996695"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 01:26:49 -0700
X-CSE-ConnectionGUID: pjMmgeuRTTehv/0U5R8mow==
X-CSE-MsgGUID: WbKA3XopSDefz3lsNzxUCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="155835385"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 01:26:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 01:26:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 23 Jun 2025 01:26:47 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.43)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 01:26:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmXeQdx3THhNAoPHVSPVeyRAOBN/SjNDgwJ2T7LnEShyKVuekLmSC5yle5npM4qidD/kJWbA5nFa/otgozRznq+ndN1SSDgk/FTk7+T4aMeB4VQKV96jRts7OOHAmpvkDiG2EUtgsstV0KsxGBaXXgIMiSynREd+Fc1n78XdzmiJk0DOA/7i4aNkz+6XacpLIbhAoc1LdZ30PebkkPsDFX1tEN58tYySgMK5oAheHYw6kWeYav94BkGP9ATEuPDzZ4flRC2KmHtOahQWfhAtKiGk5W78wg0SEAtvTLycQJ9GrDz3Y1lxTfDWpFZnpjuuMaky1WP3wL1EgzWlRZn2NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfMvIvbPA8JRYbRdEqunlawBOXJS9+0rfttueWnCd/Q=;
 b=X6+GHvOlZHJ8vBSqpO48AZZfLYjdx/eqBLYUrQVjvcvy3mLIe6M9iGH6Do5yrZoh64v3/S/+gwZJNNk2ufJGw3n7/CNs9osYo+r56a41qNtwwgCnWRwGTDByy93SKCujU/WZrhgs5O7hsOEvMu99U1q0PZK1/B+QAOBRSWK+WLHggcdm6N3hVFoSoMr+fLYmg3Fs3PfiLIrvFK1O9K6xrNkkkcoqn3AS/uSt+qSrWtxOD7GXXBBiP3Fxlci6N26eFpx6SJTPGVBBWbgisJCu6t8Q0Zyo01PNyLJYwS4+LGw2jU5bCHJoje6wOP8zRzYhmVmMSeov5NO0LrbMsM+gIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2708.namprd11.prod.outlook.com (2603:10b6:406:a9::11)
 by CY8PR11MB7034.namprd11.prod.outlook.com (2603:10b6:930:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Mon, 23 Jun
 2025 08:26:44 +0000
Received: from BN7PR11MB2708.namprd11.prod.outlook.com
 ([fe80::6790:e12f:b391:837d]) by BN7PR11MB2708.namprd11.prod.outlook.com
 ([fe80::6790:e12f:b391:837d%5]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 08:26:44 +0000
Message-ID: <0159771a-8e3b-4be3-99f8-b660830560f6@intel.com>
Date: Mon, 23 Jun 2025 11:26:39 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: UHS2 init fail
To: raoul via Bugspray Bot <bugbot@kernel.org>, <ulf.hansson@linaro.org>,
	<ben.chuang@genesyslogic.com.tw>, <victor.shih@genesyslogic.com.tw>,
	<linux-mmc@vger.kernel.org>
References: <20250510-b220103c0-216fec070bba@bugzilla.kernel.org>
 <20250622-b220103c2-e5b82e240db0@bugzilla.kernel.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250622-b220103c2-e5b82e240db0@bugzilla.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P250CA0012.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::25) To BN7PR11MB2708.namprd11.prod.outlook.com
 (2603:10b6:406:a9::11)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2708:EE_|CY8PR11MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: af974ce4-5950-4390-f966-08ddb22fafc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHYxaXg1KzA4WG5DQmdQWU13WFNvUWtHMzZlNGVGY1dQVWZMaExtMWdRN3VC?=
 =?utf-8?B?c0tjK2RJdHNxT093cXZQbUFGN3JhSXBXYW1KWnRpV1hhSkNLQklmRmRTeHB5?=
 =?utf-8?B?amNKZTRIaTE2NTF5RnZrWElGcG1MNEFXVkNrdkFFOEl5RVJPTkR2dkNYcTVR?=
 =?utf-8?B?UmtGVHpGaFR6d1R6QUdOQ2tJbVg4MGkvWjFOTnZFV3pMR1lOUjhvckl6UnFY?=
 =?utf-8?B?N3V0YmVuZUVVZ0hPWUlYdU5MVkVoanpmY1hMVy8wWi92ZjdnVUpLckN3VWlZ?=
 =?utf-8?B?Ukl2TU83dDZQbGdjWWxXQW0rbVVzY25WaWFqd0tLR0NuYkd1ZFRCM24zMkFt?=
 =?utf-8?B?N1JhQ2F2QVlYaVo2TUU4Ukpmb0l6dzZmTGJqRktVOVdUTTZCNHZsU0REVHpo?=
 =?utf-8?B?aUpVTURwTGFoa3pFUzFPeWd5NkNPc1hvY1ZzMTcxVjVzc09SYURlbFA1Yml1?=
 =?utf-8?B?RWQ1YUo4WGdRK2ltV1hWeWpxcUdoR1p1Z1lwNGhZY2xDMk41TC81QnNzd0dr?=
 =?utf-8?B?UW1UNHVKbEVoZHUvRHhCR2YzV3RUd0FmL0ZoVDRzU3F4NzZqRGx0bXVUTDl3?=
 =?utf-8?B?YVVLRzQ1cTlKYkQzMmpLSjJxQnNtUkEzVVJ1djhVU054cS9WS2pjQlFid3dV?=
 =?utf-8?B?NklUWVkwdkRxSlJJU0FsL0NISVpjMjFucFUrTHE5WjF6T3JFd2dvcTZWMUlB?=
 =?utf-8?B?Q1cra3J0c2tScUh6M3g5Vm9nV1FralNIeDYxVFUxV0hCUU9zMlFDWWxsanFD?=
 =?utf-8?B?MTE2RTN0UnlvTDR5ZUVKQ0JRVG14dVJFeHBXTU80SytvRklRUjlyZllESUdS?=
 =?utf-8?B?TmYyRUhMelNMNXlCbVllQkxaV2RWMFl0VzNmejVhSTZ3TW04TVhqY3BxT1k2?=
 =?utf-8?B?c09CNjVUVUM2ZkxidlhIK0dpZFlrTkJZaEIrY2dnTHNDTlg1amxIeHhzUlNX?=
 =?utf-8?B?TUhNcGFPd2xFMFhCOC9kNDJ4dytZNTFCQVFkd3FmU0c4WW4veEh3M0VaWjBO?=
 =?utf-8?B?OXB6RjltVURIaXgxamowb09RK0xMdFdiZ1ZycS9HTkNrRVBuSjN5bkp4ZVlq?=
 =?utf-8?B?QTQzeGk3V3BWdWtnQUdGblVET3J6dG15MHJDOHlxaXR0NzYvUG5UZVpBSHFH?=
 =?utf-8?B?VnRPNzNYM3pOejEwSzd2SjRZWGdVZ2lnMjZKK043WHUySmEzWGF2cFFDV205?=
 =?utf-8?B?NDBvRTVvVldFclpPOFE1Q1pDZEt6ZDFpcDlZanlGZGtDSGpHWkY0ZkphM0Vl?=
 =?utf-8?B?czB4a3h0QVJqTjJ4d0NRUFdxR3NRVGZwbXJBR3JVbXlBNWFaQVhTVjltV1dI?=
 =?utf-8?B?aDM2V1h1WEwwOHB6WEVyMkdxUEI3dkk3WkZpcnZyVi9LS3pYbTY4SHRuWTEw?=
 =?utf-8?B?MVV3bTdkeFNYQi9yc3hWU1V2N2o0RTV5V2tsU1FIUUlEOE5YQ1ZlRE5XRnc5?=
 =?utf-8?B?YTE5TDI3L2hoKzRCQ1pkbDRxOFo5bGxxVWhIbkZSV1dPbGI4TGtxd3IxN0Z4?=
 =?utf-8?B?ejdiQ0NIVkMvQzRZUmE4UFd2V1g4bHJxVTdvOTY2QXRjeUZ1QnppYzR4WGo2?=
 =?utf-8?B?TmhaZy9BZXpQQWJsZEhVeHRQc0RmaUNocmw4RjRINnNnWUZERlVMTVBqLzVF?=
 =?utf-8?B?N3ppOEpGSXMxVW5xMzVCeVMrNDRjOWt0UXdQVlA3U1NIZVk3ZGZQWENZcUxW?=
 =?utf-8?B?bHhuZFVHWjNKUDhmOElYK2hvNCtKUTBrQUJxdXJlZ3h4V0QvNHhoU0tjYnhE?=
 =?utf-8?B?dGZHME41RC9iRXRTK0NHNmFENktCTC9xcHFoZ3RuWUxlc012eFBjazhWTTVM?=
 =?utf-8?B?ZmJJR3UxV0JXd1d6Q2VQd0xTQ004bERjTEx6NisxMy9TYWxPMENrOTJ6Wlht?=
 =?utf-8?B?Wm0rVnFpYzROaHdPalRGeVRmMS9rdGpjR2ZhdlF2M0k3ZnMwWjZlQ1YzRC9w?=
 =?utf-8?Q?Gfr3q9d4VP8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2708.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG85WkZ0MFJjc0E1NFg3Mi8vaStCNjEzYmFZTExIYks4cFpZV0tCcnRSZi9t?=
 =?utf-8?B?OFdQc0Uyek1PRGRsamNyeThqUzFDYU1PbDRFVVF1Z1EwR25nUEJmd3hkVy9P?=
 =?utf-8?B?RVA1WDRnanFBUlhTRm9jZnRXQmJycVhRL1g1ZTh4QlRiR0hYM3MrL3Z1SEh4?=
 =?utf-8?B?VllkdmR4eXgwaUVSbDcxcWovcUlackpXaHVOWGlIbEdzb3JVUEdKYlEzLzE1?=
 =?utf-8?B?VjVScUFnTVV3MkVDMW5scHovZzFVMUMvSVpZTkZ0Vk85MzVUN05ZOTBSWVFQ?=
 =?utf-8?B?Rll6aE9uSmNRV01qY29KOENlL0QwQVNEcC9rM2NiMnBzMWpubDJoVExQK0NN?=
 =?utf-8?B?a1FqMTNPTlF4UHlEOG1OWlR4ZUFZdG9YUnJRajlRWTBFZm5RTGhWUEsxTlBC?=
 =?utf-8?B?UmFIclZsQ0I5K3o0VnZZRUJ5SHdYZjlKVHM4VWJVUzk3b2Vkc0NkVXJ0MllQ?=
 =?utf-8?B?UDRCb20rSHBNWisyMFYrV3VzOFVka2U1YzQ2SFRLQmF4dVJMRFJxdUNQd1Vt?=
 =?utf-8?B?bzQ2NFAyU203YWVrRFE5YmMwQU9KZzh2c1JaQ0lEaHpvT0J4MmdKekJ1K1k2?=
 =?utf-8?B?Mk5rajM5NTU0OGdCRTJhR1FFcTgwcWdzcEdseXhLYVAySlY2OWYzNFpRTFN2?=
 =?utf-8?B?ajdqU1padXlVdTlWVXd1c1hPNGNTcDJnd3NCRU1NZHJMR0NhWEp5dkJsdldP?=
 =?utf-8?B?NjZONEJUa1pTWlJzS1E5V0cvd3QySjNwRU5vRHJna2VzTWRGZ1RLb0hTWjJH?=
 =?utf-8?B?RWxWeDd0NWJRZWpxblpZdlR6ME4wb2QwYVRYZEtYTGVxazdNdGtuc0ZZYm9x?=
 =?utf-8?B?ejg4QmFEQnRUT1V0Ymxoc2ZxOUMyS3dlZVVtL2FmaEF5eUxzSGcyZU9QNEw5?=
 =?utf-8?B?dTZyWEg3b3dJU2xFRlZmb2xqZ0lKZjk0VDVYcmRzZmFlM3ZqRmF5a3ZlOEg3?=
 =?utf-8?B?MGdrZDlEYjFGV0NlUURHQTdiajhnSWYrQzh2NVFmRUNKT2RjQllzZXVTNzlr?=
 =?utf-8?B?Q1AyWkd6Q3N6K3RhZEdhWmJReXNIaHMvSGJxd3RnSjFYU3NkM240MFJaT3o0?=
 =?utf-8?B?Zk1GbHl2NlFZaTIzbWFvZVY4OEtaR041WW9Vb3MrMytFbkNCTkJrKzhXL0Nm?=
 =?utf-8?B?UzB6eWhpbm8rWkwvL09VVm82S2dJeVVOcmxWODJ1eHhkVmhicFR1cXk0MjZ1?=
 =?utf-8?B?Yk0vRkhQaDUzeVVXUjlGQjdQV2tiTk95bFp1TEdHL2czR1FjblhaYTQ1allN?=
 =?utf-8?B?NVB2RDNtNEQ2MktWTUtFYjNQcVRQQ3BOQzNLS0xJLzk1cnNXZnZ4Wmg3cHkz?=
 =?utf-8?B?R1p6K2RKdDM5YVhqZG1iM29FclZLcG16UHVSVDhnQmRVcEYvQVFqMEZRRXp1?=
 =?utf-8?B?SFgrNVlkRmxIaTBxdmhvZ1MzNkVWZmhybGkzdlVQK1d3UDlUdUtPR00rVHpo?=
 =?utf-8?B?R0RycGxKZFFML1YxY1lLTWlXWU9tZWFnOHIxSDRwM2N1cnZmOXM4N1B0UXhz?=
 =?utf-8?B?VW55cnFoRU5OYTE0bWNYOGZxVmVsOFkvZzJUTUNhL0dVdGxaR3E5VnVOcnpv?=
 =?utf-8?B?TUhHampTeE42V0lYNUJ3bEZMdWtza3BMeExSMHc5UDNDNTZId1ZxblFxSkFF?=
 =?utf-8?B?WFFLRy9JTU1PdnBpMjhjNXN1T0poQ3BqTThqWklycENQVUxKM2hQeEJQMDA3?=
 =?utf-8?B?R0JNc2ZSUnlZUEVpK1F4OHZkQ3NNRmpWRmdaWGF0M0oySGhpNncxeHZxTE5y?=
 =?utf-8?B?bnZQK283bXBQR1VHUTJ2UXZaSEp4NllGdGpiN1lQbUQ4Snh5MHFLUlFZT25I?=
 =?utf-8?B?RURtY1lsenlxZU9pQWkwY2pHRDZ6UU1pbXBpSlBmVXVUWjNXMGlHMkJPcHZG?=
 =?utf-8?B?Y3UzbEc0R2l4eVNHaHBlSWNtS2I4LzVjZDgyMyswOEFRSHFwUTViSElpV3FZ?=
 =?utf-8?B?UTR0eEFueklaQ3pic2MvaFkxWUJOcGlvYkhYeHZvZllaeVpsTndRblhLSGlT?=
 =?utf-8?B?aTZ1SHhDWGJNdEdKQllCb004MzBhbXZ4MXM1TWlUU0JvTnRPbnl4cTAvQlpR?=
 =?utf-8?B?ZXhBMkZuclJ0UkJrTGJMTnZXNWR1QmttUyt6TW5mVmVmOFk2RWVBREZYMXpq?=
 =?utf-8?B?Q1RXa0xscFpFbFIyeWtpOUdqQXMyeUIwRURGSXVEUTcyKzhxL0pkclUwTis2?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af974ce4-5950-4390-f966-08ddb22fafc2
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2708.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 08:26:44.1061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HO2MXP8Dp+ZdDfbLFX19J7sj9ugK6nAzlt+UqBjrvZkd2I56kRA6bVwDtjW//BTlSlLDsF/MyynnnUTi1WgYVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7034
X-OriginatorOrg: intel.com

On 22/06/2025 09:40, raoul via Bugspray Bot wrote:
> raoul writes via Kernel.org Bugzilla:
> 
> With kernel 6.15.3 and the latest linux-firmware (20250613), same sd card, I'm seeing this now:
> 
> [  396.669202] mmc0: UHS2 Lane sync fail in 150ms.
...
> [  396.679712] mmc0: failed to initial phy for UHS-II!

There are 3 patches that make all these messages debug-only.
The patches are queued for 6.17 but can be found in linux-next (1)
or mmc tree 'next' branch (2).

6f3a2f9fd8161cb6a04d982ab1027321f7c8709c mmc: sdhci-uhs2: Adjust some error messages and register dump for SD UHS-II card
757611fc4bc52d9e2986e54df1d12c914e2da08c mmc: sdhci: Add a helper function for dump register in dynamic debug mode
790dc30477f2dec029a47ca536bc945557541395 mmc: core: Adjust some error messages for SD UHS-II cards

(1) https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
(2) https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next

> [  396.925968] mmc0: new UHS-I speed SDR104 SDXC card at address 59b4
> [  396.947290] mmcblk0: mmc0:59b4 ED2S5 119 GiB
> [  396.948374]  mmcblk0: p1

IIRC the card was not a UHS-II card, so initializing
UHS-I is success.  The messages may be ignored, but
will not appear from 6.17 onward.

> 
> View: https://bugzilla.kernel.org/show_bug.cgi?id=220103#c2
> You can reply to this message to join the discussion.

