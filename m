Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079FD414DEE;
	Fri,  3 Jul 2026 15:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092175; cv=fail; b=UI/KIEWtENUXp+eTsK4o9lx03HH7e/OujBHmUT4Z0Wvf0bzigyrNMCF+BjUZy1z2X434tjZb4ge+kN/4IrR3Zq5Bd1tXr/XE5TO8D/yBRU3gCYtpEZsnZEirwjY8cRNkh/uR7NwwuX7vyUklS5+8VQ5JhkhEWgcNT3w/islc44Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092175; c=relaxed/simple;
	bh=t8npFfxrGKoVfbpk+uIyXWgRJnlo/N7PL4Jf866wsRY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hTAxEESEympmhFphMoqdfdn+Yom8Ll+Lt9Vv0Te/2QQ8hhNssjGO4TAMiGeeIM/pJ1Xo9dTiNHND6a/AeT/d/A4lDpRzfGeeNy7chlaZfBrcPKCodtLGOHUl+n/3C/rQ6S5Dx+PgO9AjREXboV4BUgAk53xj9lwub4Uzrmzinhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=USsz1BdN; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="USsz1BdN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783092173; x=1814628173;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t8npFfxrGKoVfbpk+uIyXWgRJnlo/N7PL4Jf866wsRY=;
  b=USsz1BdNI4SNiC6kHBFrVDOkIjC+CZtvnA0QuPTj8THlldQrXx7z3Snq
   HmxMDm4kDbNtiBIjFDnmc/D7ZqkGQaREOK19bRBNTyqkmQKs6VbL6Q7uJ
   Pzd+AV0tqRSewGUYb0S0HL4V0HwJ4kXKOkHYvHP7Sj09fcg9mujibBGQy
   bPURns0Gg0qDZybx1MvnxRpGUknzQr9PwEthHGcfVahbcifA26Ws3zTHi
   rXO8cbeKULQaBDRdi6xB82aDgjY2ye3TfJ0PFtS4fDlNmrqSlwyosRXSd
   aDdteTbwAiJOgPlHZ7D6LyMuj9J9yp2WS7lByJDbA5hUWtpdaRUGwjwQF
   g==;
X-CSE-ConnectionGUID: sajnMzlzQx6etKt3mDFmhQ==
X-CSE-MsgGUID: a7exDG/KQha1wleLGTEAwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11836"; a="94495141"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="94495141"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 08:22:52 -0700
X-CSE-ConnectionGUID: G8cqDQ7OQnu4xuyAlqNy3g==
X-CSE-MsgGUID: rZiH50vUTV2C61F6wIuyJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="256711113"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 08:22:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 08:22:51 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 3 Jul 2026 08:22:51 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.65) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 08:22:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YmJ3wJ7MW4/+GMigCgcdu7u2qoSeNoNdeSNAXRq5EUjDFFpia2684OajWs7HE3+JGIVIEdijZBwnOVt6khADxfor+5Z0M/SpfgJKlvMJiTL09fB3B9prJckfESKQLYe0l1sr2WRMLWL2Elnr8YzK7GPbq+np8peLkdULPQdi6A9ljHDLQJnVNAFClj0YrXK4vvB1+ZhhEG8LHZVnzeSejhM71ty4ReKB05pmeidAPdqgw7ghFD3K0pfLcSG9sk3JAoQ9osrK+PUA43TtTm8um3KRL0hb/ImkMde8G2iUmyxpahyXSXcMEVSotn1AQtMT9AffVeMUoIHoc7q/g27lYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pumbKpdMX2TJzb81tef+B055cvMXSlaFoGEU+JExVc=;
 b=SaM2kcl1iUNkfx0m9ys93crYHAxczP+hyrspAZKwr+r/qMaNEp37t0/JVEZPtVR3NZm84gRrtxMZeJis6Ysc4Y0MCwnsuN6A7x6A6CIyVlQc1qJKVjjHZspiceDQvKdLKKoN4I+4JVC0+s/X8nwvDI+OVMHpl2v2YQq4MpCyh7kWwfaEAKqIj/JJna9HHTF+0EPR8HbRHu4m4lodod3beCPf+a1yZRCB6J80pntu3QIdpXd8x4HZ2o2UZYlWgNJTn63NBi1FGvMfav+fKokVV+ETEl1iU+W/FzxfqK42iQzvTrde4RQeeI0tDPHvhvc73WbqTr3cliA5AzlACry04A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH7PR11MB7985.namprd11.prod.outlook.com (2603:10b6:510:240::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 15:22:39 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 15:22:39 +0000
Message-ID: <b398eeef-1141-4b66-b1a6-01bc6078ed5c@intel.com>
Date: Fri, 3 Jul 2026 18:22:35 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mmc: sdhci: return generic tuning failures
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260623140206.73221-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260623140206.73221-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P195CA0015.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::33) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH7PR11MB7985:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2f98dd-395c-480b-df0a-08ded916eb22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: W22aFRlG1PEVaT/8KQF9yE2CbDqOuqKs2JXCy1t4bBP9SF6n1Qfkm5GcDFamCcPJS1tdGBhnaw7++423kDONqhDaUv+9rrHEznXz8oQmzLTtq00blx83Io27Peq9S2NQJfrNr0uihnj7p7LFbjnP9mRrupw7LY+hFKX5JJdog2q2UFAX5DG9u1zY+KYg4q7mZbRn11EycjNZUPOSY8YIW84Z05o9PMibEQ404k6JvtNwE5uvmGBy/9NG9Or7pxaC+QlbZZZWS726tTxUmtWvkd0A2oFpT/SHR5d9hMTN9ES8hqY6ENJxrDQNgd9v6H1ELdHCg0Eyo218R3mCfOliuOj5UCyRk8/2O1XezZAKTVZLUdFjCUq8u/bTxEs3/DfvXF3cj+ISbENeqkbGcRwkVA4NCwI4pssc1CI6ukPEoeLYPAKhF/HSDUNDQ8r9uIl6xVKS5ZQmFoZjVADlpVLHscDhejtc3njhQUSxss7Fjo9ha0SavZAVHaurOeHsiPik7KSqF2QmDIk3HMLhXAixY563TjXtq1h9uQYKshusX07F5vHjlgSvqLCRe66H0PL+vUY44qcZfpXpAuly2+7XqkAkwjd7tUoUMlz2WVUB/zxlnhoMSMRaCYwgRiZpcU/zvE7JXoA0h7JIDMa64ktEknD9A7pAfxK0+eB3ho5SkVA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckp6Ulk2cHVObzUxbldjaDNVVUsvSHBuUU51QVQ1ZVcvc1l1alFpQWVxWW1D?=
 =?utf-8?B?UEE5Ry9QWDJIU3RTTjJiaGZxSzRzUCtFTk5Yd0hEMWwzWlhaTDlVdTZpSUZJ?=
 =?utf-8?B?R2lxTGJYMStMY3BLb1JjcUN1QVFCQldvSXpqbVM1bm1ZdlUrRFJXeEkzM2ZH?=
 =?utf-8?B?Wm9JcWJ0OUJHUm5SSmdzUjROZlo4TnlZejQyK3BLYzhqZkxwZkludndZdmFn?=
 =?utf-8?B?ZGpYbU8xM3BXMUVXakFzWXhzeUlHWE1RcWdZWjBLSFVhZ1JVZHFYRTRWb3RV?=
 =?utf-8?B?dTNjQk9SUEZTTGQzY2NxZWdpOTN2RGdNVUFWMmhwOW4xakIxYVROcmRMU3Ju?=
 =?utf-8?B?NWl4Mk1PQjNiWWNDdmE2QjZBbUlYaTYrN2pLSUVxT3k0VXU5NXdxaWNhU21o?=
 =?utf-8?B?TnRlTDdHeVN1QkNhclM2Z2V2b29xdWgzZXJKL0xMWE1XQ01DQW15ODRjVlZS?=
 =?utf-8?B?SXBnUHhIUXJIckxpMllQY2loRkgzNkYvMjdVeHFydURCTWNnTUwxdHh5Wmcr?=
 =?utf-8?B?VHlWOERmNmdNM0FRRkJFQXpaRnZDQ21PRjE4aERxbGFDOGVBRnptZnNtMkpB?=
 =?utf-8?B?RU9tTzdTV2JYQ3EzN2VoQ2ZTU0k3ZVhQTDRRQkhlK2g2NTBFcUM0K2p4WUU0?=
 =?utf-8?B?MXhXaHhaOG9vaWRQejBmN25lZW05QXJmRW5laHNBdk1hTDlpTzhSY3pQREFH?=
 =?utf-8?B?K2Z3elBRVEhQVU1pOW1SdEQzM291V0RISDhoVUFkdC80T1Q2dCtSN3ZSRERO?=
 =?utf-8?B?MWxLaEdqV0NHYlBtOUtoWWNwdWdTRGE1OFVETEFNN0ZyYjN3RUQ4K1VFV09l?=
 =?utf-8?B?YklBL3JpRG1Mb0RHTy92WUMwekY1UWswbTRHRndDTWJxamJ6QThEbjhJcjEv?=
 =?utf-8?B?aHNqbisrc1VXUm9YaHh6K0FBVjZ2Nm9EV2E5Y3FYMEFLY2gzMk1JSDN2OU5h?=
 =?utf-8?B?TENqM1NnQkt4VVp2YkhXcUdmWXY1TkFORnpQZDBaVFVoNHpIK05EYmJ0dFY2?=
 =?utf-8?B?NVJwVWFwQUlvNWpjVXZEaTd2bkVlZGNiTTZoTXVlWkN0UCtFejFUZUJtUG5v?=
 =?utf-8?B?WUY4elZKVWg5RGc5NUEwMzhUSUk2WEdOdEtXQkxLUEZpVjZRR1dHU0cyMVkr?=
 =?utf-8?B?U0IzU0hna2sxNCtEQUFhakFkbnpsUE9tQlIwN1V4S3NLNTFMUVlGY1grK3N1?=
 =?utf-8?B?SWxGaEhOVXZucGhCQk1VelRzcWoyV1cyck5BQWlVZFN4eS9xSVVWdmgrazRj?=
 =?utf-8?B?ZXJ6ajl5czI5Z0ZOY01JVU5CUGxpMHNScmsxV00zOWprSXBvQnI5ZE42VUxI?=
 =?utf-8?B?clB0S3dFUlFSbUFOYVVzK3J4alRkbHFTeEh5eFYzQU5VQUU4YVJ6ZHhXbUhy?=
 =?utf-8?B?OFlndTcyNS9GRTF4UDk2UFA5VnBPNU1SYTNYeE02LzIxdjkxR3pFdkVNYTU0?=
 =?utf-8?B?UHhGWmF3ZTlRN0I5MUV2VEVMbXJoS052OFg5QlZvaE9UbjFBRGwvc2J4VjdG?=
 =?utf-8?B?MThSc2xSOGdiTTlDVmhFU3RUOGhSV2FtTnFPUitMck5NTGRvUGx1MmxhZE1E?=
 =?utf-8?B?T1JrTDh4YXdOVDVmQk9mUmdRZEE3TUlIaHFzeUFsVjM1d215WkY1NFg1OE45?=
 =?utf-8?B?R2x1RG9UdWl5ZnR6K3FodGdhWHRPZnhJbG5odzkzeU90bHpWKy8ySm5EZFJN?=
 =?utf-8?B?NVlNbnNNTGtBZFpuUjhqUWRXMjJYRElmY1dhNmN5dzFPL2FTWWNHblZvVnlI?=
 =?utf-8?B?emZqZkZHamxDSThiV2g5aWVLZEx2cTUwTzZ6R2lVY0FkR2dlV3BJa2VaR2Zo?=
 =?utf-8?B?UVBDayt3RENTNWRONW15U21SMmRVemZLcTUxeDFJZXlsV1Jua3l6WHZaOTBZ?=
 =?utf-8?B?OGYzYlBDREwrVHhaN29DclBycDAwZWh5M3cwSjdVRCt3aG9EZFNMdENHRFlH?=
 =?utf-8?B?eURtRlVYQ3ArMFJkUGUyR3BJSmowYWhlZEtma0l5OEdyVkpMWm5LdVJ3Q1la?=
 =?utf-8?B?dWlxSWJ0eklDOXdaRWlKaXFvTnpiaFh5azY3Uk1xWkc4Q2ordGp4Z1Qyc2RG?=
 =?utf-8?B?MnhmSHF1dmVDei84QTZOL0ErL044TDVXWkkrQlZSQTJIMWVweFMvcDdxK0Rp?=
 =?utf-8?B?VklhdnFUNlhSazFmY2pvdjBjd25qMjQwWGJaMlU3c1hRK1RpVmlxOWJ4V1RG?=
 =?utf-8?B?YzZobHh1eE1WRFplcWR3UEdwZmM3aHBHS3ZxOVdyK2tJcmVFUFROYXlJbTlh?=
 =?utf-8?B?Tkk4NWlaTTlPcEJuUFZyb2xuMHBJaDQ0U2k4c05iOWloQklHZjBhNzY0RVl6?=
 =?utf-8?B?MGR1RXRMVTVLdjBKNnhjbVVkWk1zb05lVElkc1hmZ25UUmpVeUFBTStVQTNJ?=
 =?utf-8?Q?4nXPFdLIp7AB/i+E=3D?=
X-Exchange-RoutingPolicyChecked: Ms81foR7zW46QcUh/jI63VSczg2tEFT13CYv05YLqwcIwjIgxhWQCn6G6sNTZnb8MVxKBZHfIaKyCdnM2uQAmw0g3R7MWggvjcrZEAi3X2Oy8g4j9zWPqhd1eJ3tWASgYRk6jejpX3OoVsibFdvHEID1B+Nrb7NtBXWhU7DCMKqyQE2BL3xX8pVGwZI1vpjKPhG0U7x27/dWIxRsF/YLkle55gee6dlEt8i83FLbhdeqJ5SxZtODKcSS+HgTMC8RnDROOoeXFQUaX4MJDwgHUL+PX4N35QI60ZZJYEbA/Sv+LFZVnpjhIRIwYRGE9fVjWRfbRzf3S7FKNPq1ZgQ0hA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2f98dd-395c-480b-df0a-08ded916eb22
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 15:22:39.4213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0oGaYdKKnQygkE5jJJv3DhP2AxtuctWARL3OV2v17XY+8LdZO4JPq5f/EUL9S1aTaGuuFxe1PsZbPt+YKMNiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7985
X-OriginatorOrg: intel.com

On 23/06/2026 17:02, Pengpeng Hou wrote:
> __sdhci_execute_tuning() returns tuning errors such as -ETIMEDOUT and
> -EAGAIN. The generic sdhci_execute_tuning() path stores that value in
> host->tuning_err, but keeps its public return variable at zero, so
> callers see success even when generic tuning failed.

Callers that need to, check tuning_err

> 
> Return the generic tuning result while still preserving
> host->tuning_err. This is intended as an RFC patch because some users
> may rely on the historical fixed-clock fallback behavior.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/mmc/host/sdhci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index e3bf901b1..a90e48383 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2967,7 +2967,8 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  
>  	sdhci_start_tuning(host);
>  
> -	host->tuning_err = __sdhci_execute_tuning(host, opcode);
> +	err = __sdhci_execute_tuning(host, opcode);
> +	host->tuning_err = err;

No, the code is meant to be the way it is.

>  
>  	sdhci_end_tuning(host);
>  out:

