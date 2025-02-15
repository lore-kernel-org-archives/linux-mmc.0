Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA2A32C85;
	Sat, 15 Feb 2025 01:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739581611; cv=fail; b=RNagH0qe7Zn/xQtioeVkOPu7HJPj2MD+4jit8XtsfVcI8BCNbYYDy1xpSxho5A3PaXy79aLkaBuPP5a4P6wkOivTRiLUevTA/6rt0hCJ+j/UwqPwASoYFBrMNhA+eTnUqjxQsMz9m7QAe0l4Dpet95TojG2HDX6AiaUCTna9470=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739581611; c=relaxed/simple;
	bh=CGuJzrThsucELXeOpxurodWLq5qH5M+HvyQcGoHDjag=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZowmVnr+cfy4RTRHA7RXQ7+kX43KwAR8HzQRVaNghelKSR4arBVMPAKK2A89MYEIUOp3Akv6aruj2REC6WWbrQR3mOBlB2z8ypC95npaqJE4QL0ZAH3Jy9FjAspuIw0wFgwUNG/my9Qm9BrxDcmnmZQFVO7BMw6XXGv2sM2FFl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NOFa8p9G; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NOFa8p9G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739581610; x=1771117610;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CGuJzrThsucELXeOpxurodWLq5qH5M+HvyQcGoHDjag=;
  b=NOFa8p9GIzsL4EU34a0uPsnjz7pBSujpA7sIhjITxcjJiwsC0NqtdaqI
   nXL1RZbwEuZBklDkxnGiYpySTC16opaahyQzoq7K+EYnUldVu3jaEIBFC
   MGwRc9lytgyuF6ntBCP7T6oXik1cUwrVwZGfqJ/tdkTM8nQD+B0J9gURs
   H2TDbtx4JF0pgjqIQPrP/F5qr/Z3mq1JcWkC+HeZhOlGHTF7tm411HnfH
   bpgdfc0Od4JNb0vG29IKCYBC2422snDorBToujZ1DncLB2ssskqq7O3N6
   9sownEQWMTjQcJRafuJsGrYAqSZS1aSiGmt7cor4AvGhHvQ+gHrHO++FI
   g==;
X-CSE-ConnectionGUID: Jd/NQxRDSlO8Vv6ewUW+LQ==
X-CSE-MsgGUID: 63pIfuVyQmCV4nDRMb8ozg==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="50555141"
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="50555141"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 17:06:48 -0800
X-CSE-ConnectionGUID: JzNzcfsrRmCRKBsM1k2alw==
X-CSE-MsgGUID: Od+FdSWRRSu1OJHlEYCYDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="118711352"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2025 17:06:47 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Feb 2025 17:06:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 14 Feb 2025 17:06:46 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Feb 2025 17:06:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqLNwNra5HGDzam2DvWvzVqaWyeRsHzx3H0sD7CKB8+VIweJEBBzqpy/gJxPj11EhniHCwAiEfaTsLltB9gICR2BTKGKkMqRUbC5i9EO5VyrkfzO+qq3gWNBKLQmX2AfabzuWfeyCtyu/rbn8fCb283rH2GmMJK38R6cC02XlFnlsUB7h9jZhUv0uVoqXJ/+7wGD/rxhH0Nj2U99mZK8FnqKuUGroy8SJ17zx/6qYps6Qy8JsAKg6eLbtmYwYVjEriasvuZgbjOkjEF4egg9N8RzKg7aMS5w2oPLONU1TMBqaneK9/C/E8EYZ3twsz9kv2XxWPpQz+kyXv1f2xyP2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdEgmGHynI2F9peNWhcEJ5onrUyYyVxxkTordK+R4es=;
 b=xAqbK7UpBMVmq0FD2V5XDCN8o8iselqw9wWDNS8F7RkucTE78G1xQAIR7ZYaoR+TyNauXQWLZ4zqYtXNHRCCdHJw0dM70KxciBAu9dCWzfQ/Wcqa92ulSV7cutib+34nt87GAmRoXm4EuFENI+2W3iPoQUGVXMDNl+u4SmDOf8MoSKcJ3U/vloxHBKqz4ixowA2QNF5ODwauHYS84hPTphyaIFQGFeH/99ELdOx8/A5RhExxgIBDaQcMm0aQ3cWtQhiK8txWBAYzCsJYTirIayERdChRlQyxIlP2p1C+/alMMIeWqxw8+OuwfLABAAOH4GCy6qyjmiCD7/APVgE14w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by SA3PR11MB7526.namprd11.prod.outlook.com (2603:10b6:806:31c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Sat, 15 Feb
 2025 01:06:09 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%4]) with mapi id 15.20.8422.015; Sat, 15 Feb 2025
 01:06:09 +0000
Message-ID: <8002f01b-97cd-4c30-b00c-c73d0cbccdc3@intel.com>
Date: Sat, 15 Feb 2025 03:05:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V2 1/2] mmc: Update sdhci tune function to return
 errors
To: Erick Shepherd <erick.shepherd@ni.com>, <linux-kernel@vger.kernel.org>
CC: <linux-mmc@vger.kernel.org>, <ulf.hansson@linaro.org>,
	<avri.altman@wdc.com>, <wsa+renesas@sang-engineering.com>,
	<quic_jjohnson@quicinc.com>, <andy-ld.lu@mediatek.com>,
	<victor.shih@genesyslogic.com.tw>, <keita.aihara@sony.com>,
	<dsimic@manjaro.org>, <cw9316.lee@samsung.com>, <ricardo@marliere.net>
References: <20250206210835.2980500-1-erick.shepherd@ni.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250206210835.2980500-1-erick.shepherd@ni.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|SA3PR11MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 421e6bc5-7021-403b-9e92-08dd4d5cee84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UCsrbjNBTHVwVmNQbmtMT0ZOL05PK29valk4WUhvS2R3YlJmTzJWODlIVStG?=
 =?utf-8?B?N295VDFicWpkUDVMc3R1OWorVFNmdEJEUWkrZDhHNmVENDBZRWEyOTVjdUlE?=
 =?utf-8?B?MXl2QkJoQWhDK3l2SjFlRkViTWxJdVdYT3lTQlpaSnRCZVFrTHp4VWFCVkts?=
 =?utf-8?B?SHlWbW1DMXNXR2d3ZzJnb0p6NnJ3QlEzc3hocmsyMXpjZnNYdHAvcW14L20w?=
 =?utf-8?B?RWhHeTdOaEpSckdpd29QNUg2dXNyU2YrQ2VhcHViRGExYjJCMTJEeVJvM25q?=
 =?utf-8?B?OFl0RnZoNFpRbk8xUDZUaUxleWZBekRGUHJwaWo5Ym5ZY1BlSmx5S3hrSXIz?=
 =?utf-8?B?bE52SXVpRUFzOE1iM0o2eS8yelhzbTFHdHlmMnVBVFVhbFJLa09zUk9tUnlw?=
 =?utf-8?B?TzlSc25wUEFuVGRIczlyVE1MSC91SzlOaEdQSi9ZSG8zSE5NRVdFUVN3YWFU?=
 =?utf-8?B?ZTFHckxYc2VFNTRwdWxrN3FUTUdVZjdyb05DZ2dOS2toNXJiOGo3NjBSVUpV?=
 =?utf-8?B?WnE3bDE3aFR5bWhUNlFzVHQrNmdCeWdOdy9ReXR3UXl6akZCYkN4YTJOc3B2?=
 =?utf-8?B?WE9xaS9BRGxLZzB6TUtnbGwyRE5PcVVFWnVZWUtZa2RxWFFhMnUxU0RsRWV1?=
 =?utf-8?B?dVdoSk5kVmR0OFBsYlZHWDUxVThWZGNSckpPR2xRR05PYUIwclcvVXNhdjhC?=
 =?utf-8?B?Y2ZLZnRCc3dDQnV5MEdHQ3FqTUZtZ1hwRW1lU1ZkQmRMY25PZWp0S1VlNFhP?=
 =?utf-8?B?eWJZN1dZZy8rNFVNYW9EK3FreUxGR3VhMXQyZVhSaWpLcEQ2UmlCOHRxSUY0?=
 =?utf-8?B?cllBeGxpdTRoQi9URURPVlJiU1Q4Um9tQUNDSEVpUGo2NlFZNzVwNnkvell2?=
 =?utf-8?B?bDd5bDJwdXRYbVBPZGVqSEROZEl0M3JTYkc1alFSMisrTm5DSkowV2dZcEtu?=
 =?utf-8?B?czFwUWhyZ3VUSk15dDZhU0QwV0hONmFNeW00SjJNeVVUQVdPT3A0RXUrSC9q?=
 =?utf-8?B?T2dPWDFpOHZaVEFjOWJnWEdEUHFVTGs0MThUdmlHR040WVJ0dDVJS3l4M1JH?=
 =?utf-8?B?OTgzYmNHa0RNaDBlY3NBd0RubUk0YlZKYkVUZmRUNTQwWFRYR05nejZtODRR?=
 =?utf-8?B?TmFLMU11bWxuaWk0aXFJcXpRMldtNVJlSE5FQUhxN1NFWldIM2NvRkduRkZp?=
 =?utf-8?B?TDVrTGIvc2JLN3JKZVBVaXhSSjd1TmhKVEdFZlNNQ0hNT3ltdXVXcHBBVVBy?=
 =?utf-8?B?Z1RsRW9IaEVwSUlpZk5wYnh4U25mQUEzbTVZUWRST0NHenA0SVFHYnNGcHlW?=
 =?utf-8?B?cmZheUxic3F6b2hTUHFsTUhHZE5iTTY2UFVzZURXa2JaS096dlEraTZqNW9D?=
 =?utf-8?B?bGNIalRqM25yaHcvamw4RExENHFsRmQrbzRBTTVHMXJxQk9iakpKWVY2bERo?=
 =?utf-8?B?TnlSQkZkMi9OUWtwR3ZiYnhwSlR3YVJFV1FrR3k4SHRjdmtjVXArdGFlSm15?=
 =?utf-8?B?YlNZLzVsRkcrb0pYWEwwVllBamxyQnlhVlJsNnF0SmZacW8yTko3ZURtMEha?=
 =?utf-8?B?VnVnZVBram9oSmc0YVlHZnRDSm01dnR1K05MaFIwcmFLYmF1RzdHYnBGT3FU?=
 =?utf-8?B?Rlh5Lzk3dlR3UkxoOEZFMmVRa28yTUhKcVRkL2tPOCtsb0k0V3ptTWcxaHow?=
 =?utf-8?B?Zy9MM0VnZmY3TnhnV2g0bm9GOEF0a1VJOGVsQjg1TWNtclVHRjFEOXhIL08x?=
 =?utf-8?B?OGlYZ2pkaEYwNVIyMVlxcGxxUGg4UFByak9OMW5oelR2MWN4Rk9PeEM3ODVp?=
 =?utf-8?B?SnhOdXlVQml0TWlZZERmU2pRYWdhMFpUZkFUZTJTMGtRTG5VUFN5Y0JVWnZZ?=
 =?utf-8?Q?XLoA1w50NMEgg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGs4R2pjOTYxRmlVVzhpL2NpaFVITU1IUEl0dzF1bDFPMGx3MU44dTdRVzdi?=
 =?utf-8?B?R0Y2anJEMTc1dVR2dmdTZXViVEJWanlxalRCeUpuZ3FZUi9JVVBlNVpnTGEx?=
 =?utf-8?B?bHFhNkpzTHlpVHhLd3hnQ1psQmV3TXJvZng5K1pjU3Q0Wm1iZGdEdi9jUDl1?=
 =?utf-8?B?NmwzaEIxQkp6K3JjSjdBYXJyeFVuMlFNOGxkMlVoYWFQNnI4QkFJN2pxaEJJ?=
 =?utf-8?B?TnNQb0RtMTExMTlPUUlJWmRYdVVQOUZvZkEvYWVHMjYrd29ocVJLQXlIQ04y?=
 =?utf-8?B?aG5FT0Y2Sllhc0dQSE1tTi95aXRPY0pYTjV4SFhXSjlERE5TcURTSDV1bFRW?=
 =?utf-8?B?ODIwZi9ZMEI2QWd0YU9zNm5zejV3Sncxa29aTEY4cEUycEIrTEliVkVoWWZF?=
 =?utf-8?B?UjRoZWFybHhMLzhKNU8zZkE5RHNWY3gra3BwRnhPdEpGTlZPbUYxQnZJQzQv?=
 =?utf-8?B?dUN5VXVDR05aNHpzZW42R1dKcTVhcmF1SjZrUGx2M1E5cm5Fb3p2ZHRUR2Nr?=
 =?utf-8?B?UHBxZDBFcFd1MjRVOWhaVHNNeEN3N2ZJaGdlbGxjOEt6bjgyWUQvUHJSRGlS?=
 =?utf-8?B?R0ZRM1dUNkV3R3NBY2l5RTBRaytxcFZjeTl5dExDN3BKQVh5bGlWbkVHdUU5?=
 =?utf-8?B?VmUyU1ZibXRvU2RFUUdIS1ZEQzlhREVwWTNKUU5wZUVxSDI4MGhtSzRJeGcw?=
 =?utf-8?B?dDVOT3BKZStyRTFuSW0vbG16b3B6MExMTXFEOXNwNEdlWmJRaFVjaDlibjAz?=
 =?utf-8?B?bUl4YklHN2xUYW1WcjlIRWRBMGVuallRdTUvRTZrTmNMNnFPY3hETTZEME54?=
 =?utf-8?B?a2dBR1YxVTEreXFIU2dpQmNkZ1lPendrOVNqZGM4NGxKdXNhZ1BEeUR5V1Zi?=
 =?utf-8?B?dTBNQzh2blVLRStmd3FZQmxtN2hhbythLzc1WE1xK0FSRDYvZ2xnbE1CWHN2?=
 =?utf-8?B?K1A4Z292QjZBa3FkRTlQTlZadHNEK25heFZhNjluWGhBbm1UY082cnlZb2Y5?=
 =?utf-8?B?b1FvcnpDVHk0Q0UzNHpBVTd4SnpJRW1tTE1NRXl0OEVoSEJoT2I1S0N2QURW?=
 =?utf-8?B?MVlEMmh5NU42MGl6Y1N0bXpiNFZaU0xBRlByaUZoSHY1MDcwVWhpZTd3N3g4?=
 =?utf-8?B?RWVORHZwZGVkS2FNZDgrRVM5a0k4a1pRRmRQVzRtZ0xCekI4NEF6TkRCa09L?=
 =?utf-8?B?eW9LdENwZ1NoSk1kNjJQYm14Wlp3c2F4TkxXWjlCS3VlV1RRSTBLdlRJOThv?=
 =?utf-8?B?ZmZ5RVlnS0JvWlh3cWIrdG9nQ0d3Y0ZBY0c1WTVTWW05L0pOOEdFS1pEaW1l?=
 =?utf-8?B?MVFCR0JxVDJTdW13R2ZjYVBpN3lTc2E2eUdpNHFZWkE1SWY3eFpBN1pRbysw?=
 =?utf-8?B?cU1TUDMyMFNxWldXWENzNlZTcWlZcWN0NEN1Q1NIMFJhVFBuMnp4SzVVSlVo?=
 =?utf-8?B?ZWRxMjBVQURSajN4Ym9zclhJeTQ5MWk4aFBndXJLMUxyem5TdHJjc3k3djZt?=
 =?utf-8?B?SzllUDMyVHlxQ2xkdnJSTW15S3dRd2R1OUhJSi9hc2JsZm13cUVwLzRpZWlq?=
 =?utf-8?B?T0dXMjZuYVArZDNpalpPakYxT2hkUUxwN1JTV2dlRWMvaytDNWpSTkZ5dlNU?=
 =?utf-8?B?KzlDRzgrL3lVc1JBZVROdUhLVVVYcWRrN2RXREpkSE52WGJEcVZ3NVlIN0Jt?=
 =?utf-8?B?YWVLd3JWNHQ5RmV5YjQyYW5iUDhpL2ZnU2tXUElPUVYvaUdEUzZ6KzVWQmVs?=
 =?utf-8?B?dzErUld5WjFwalphaFRwdmtraFlqWHI4cmNwRm94WjV3ZDNMc08xUHZoZlpp?=
 =?utf-8?B?eXJ2c0drTE8zWDdIbkc3eEJDY2UzcC9LMkIrVFlhSnpGOFR0ZndsUTNjMmlx?=
 =?utf-8?B?NWIwOWxuNGxNcndiUDk4UC83YWJXSVNCL0tUaytUMloydVp3QnIyeXhVbEdn?=
 =?utf-8?B?NXhLYzc4TTdPNmFnbUFyU29RZnBKSk9adzYvUHZ3TUhxZm1WMnR2eERFeWcz?=
 =?utf-8?B?M01wekNYTmx0WmFkN1N3Zk1CMzRxeDc5RURiYkR3RktZd28yUjJQVDFOUWxt?=
 =?utf-8?B?cGY5dVZndzRRSFpEcGgwWFpRaHNuNTY0YzE1MzdUUmU4YVJOVXowNDRhUmhH?=
 =?utf-8?B?cFdrVGtnT2N6YjB6dXBMNGFDUVFtY0s5dElxeVlBZnlnRUs2aW9rUmlYbmVE?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 421e6bc5-7021-403b-9e92-08dd4d5cee84
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2025 01:06:09.3635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dbTPGmpDoBDicYRZc3Bzo6tFoE/SIeU3LdffX+rHxsniI1TF5jJxxKKU92SIKua/KL7rD2NA0G1+PxwUE/7XuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7526
X-OriginatorOrg: intel.com

On 6/02/25 23:08, Erick Shepherd wrote:
> Updates the sdhci_execute_tuning function to return the error code
> that was returned by the __sdhci_execute_tuning function.
> Previously this code was only stored in host->tuning_err and not
> actually returned.
> 
> Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>
> ---
>  drivers/mmc/host/sdhci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f4a7733a8ad2..b35b8917fa1e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2967,7 +2967,8 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  
>  	sdhci_start_tuning(host);
>  
> -	host->tuning_err = __sdhci_execute_tuning(host, opcode);
> +	err = __sdhci_execute_tuning(host, opcode);
> +	host->tuning_err = err;

SDHCI uses fixed sampling clock if tuning fails.

It is up to drivers to decide what to do with tuning_err.  A driver
can provide the tuning mmc host op, call sdhci_execute_tuning()
and return tuning_err it that is preferred.

>  
>  	sdhci_end_tuning(host);
>  out:

