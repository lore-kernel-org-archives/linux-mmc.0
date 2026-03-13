Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B274395D9F;
	Fri, 13 Mar 2026 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407096; cv=fail; b=KCnbdEl8AQJP0xwWuS+Z4vjJF2Qdv/w6IsgPXJRysDLnzkV9IqnzfWofo43N/cw07KtOKbpZ0sTE3xW8W33rg/1gSFtaIH6Z0C2Xa3yPP9eU8sNvlQX/hF2cjy9y0S1412u9hNDS52Sbz2SNlzbIsETMHncFotEcQX6DlbvS3ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407096; c=relaxed/simple;
	bh=FWbMzhbaqpaBUtdoOFrWMcEftoAWXCmZVDsRdmquZns=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kD7DA3p1fmiwK15PaxHczO9ashDCz1UdZk8QtNXH8ZO9KF60L0UR5hOVMW595oNeZuKKVgaNkPUFoEAcM9KzeIWv9uwwfgQnWuUso5yg5YiBjWSkC5mVXPCnglRyHwFMyzmYjNYrKBYEY5Wib3CRJlz5zPeUkL+fqFBWCR6k5O8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJp8oclH; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TJp8oclH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773407095; x=1804943095;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FWbMzhbaqpaBUtdoOFrWMcEftoAWXCmZVDsRdmquZns=;
  b=TJp8oclHGuBu4rTh9KXHRaLNEHRWICK9LM3vAZ5UMrwiNgtcAWsjkJnG
   NmqxADGD6tgvqLRdrQCTqNRD52JCEblonrzfbamSw2u7Gi/G2d1hsHChV
   NIOGRQoh4d6z4NYt0nZ2UCEk4NzNk0Q6OWRPUIji0j96P+H5doDFbjaUc
   cmbNO+KUADqVSSfS3+8pPqPGcXCZyfIfqT42pBxGkYH4BgRbVGw29y5lP
   4M+PvPGc2xq5/Q8Qkrem284sD69Pdkb05F2dpFuti1IyyfUo+63U/kjr2
   q1XNDbsHbboMQbMNFWLo3dmgk++UVUrauEO7u4ncNwMj1uMQpa6vqnzBR
   Q==;
X-CSE-ConnectionGUID: d4Vi9TbpSPu5vi0RFc80Hg==
X-CSE-MsgGUID: KW2XRY6NQXOF90vU+VLSwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74550120"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74550120"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 06:04:54 -0700
X-CSE-ConnectionGUID: 8xlrADTUQsmld6/sLgIbgw==
X-CSE-MsgGUID: 2/By/RPmQ7GI7EYYq/6Amw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="259051415"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 06:04:53 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 06:04:52 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 06:04:52 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.26) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 06:04:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROqyEgve7Z7gVztHak7cTjflp7VQEir4gsGr8+Px8IDvlRB0/csq3Bqy18Jyea6/f3ZGMQq51g50gklvA3TRI1ZmI5054MiunRo3hRD2vOe4lgtyDNZqQhK/BH9NPqlhucqLmQiPj19hE0GqtfMplskiY1o9raJ1x480YUWodNLIG6kTfeFeYiUkex3clxPx6WyXJw9OWJM6JmQpuvbqrb/953RciTOMWjnQKCimjt77zuUDew93Xo3VLDRS/eheRHRLEM/o1Tk2F4HmAq7YsqS1wxjFRQBUpFQUj0O0vcj/9Hx0GgqAGiwCHhItqT4wLvK3RdjcuPcblaoHC9GYhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QC769X9RtLhNDx+m8rhvHvWaQJrUX4B9d13Fc3sv9lY=;
 b=T6elsr8jj/UO++KhIl3ZlVRHpyAM/+AT8ftYNUTAIMTIgq1c4yz0Rv0wwH2toAxH1M5ejfZ1IkS4blgs4cJ5PgegmpfVC7aOiMm+rBvpDm6B2MiRt1/0fpgmmmQ0Ox1XL5SuYFbyK6eOIYkEKxwgqDp4ORpBGaj36MQii5GBXSoVyOSlhdVU5gIMTzRkxsWHmEkvX2Cdoeqz6U8zL2knFqVsf0V52b+hrs9RW6cd6ktZB3fudKG7EQpGg2JfubJqKlL+yF/8mAtmy9Ow+46uDjLwIX0nDnUqoZ7p5PnCKuN7gjqnAQmycGpiYaNBi+AoczGT7RZmi4oqQWJ2Jc6X6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA3PR11MB8988.namprd11.prod.outlook.com (2603:10b6:208:57d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 13:04:49 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9723.006; Fri, 13 Mar 2026
 13:04:49 +0000
Message-ID: <6d983739-6455-4ba7-a530-95ab8c2dbc18@intel.com>
Date: Fri, 13 Mar 2026 15:04:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] mmc: sdhci-of-k1: add SDR tuning infrastructure
To: Iker Pedrosa <ikerpedrosam@gmail.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan
	<dlan@kernel.org>
CC: Michael Opdenacker <michael.opdenacker@rootcommit.com>, "Javier Martinez
 Canillas" <javierm@redhat.com>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com>
 <20260309-orangepi-sd-card-uhs-v2-3-5bb2b574df5d@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260309-orangepi-sd-card-uhs-v2-3-5bb2b574df5d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB9PR01CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::20) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA3PR11MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: a6c07392-4049-4c1d-9782-08de81011b6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: pJd/yPdUhrRIQOXfI2SOpqPzHuMaR6efsBzeZnwqBRpQnVuJ+g2Rm1BMrb2bvPLjaaIG6K6p3qCuEoa+xzB5R0bCvxzd60Ca9/aMkRvPua4WL9VY2y08yJzm7Fn01M0jY+3m1QnSzwOC6fRxv4SrsaHrSD4tPHcz3m1edj6NEq3q8gv9aa1rURlbTvBV99JjEZpgCQm/NjGEpbQdEHWY8N7zY9fbNNjaOQ7ITmBM97ubIVETp608yt417T3SWIOBFJniAG4PUwTF2HKbZE87TKNEwrjiJmOEaMEMqXnSzIkPGN+/7qhidKWiDHRGGy7NI2692Y2jcMu/+KThsOU1zQLCq5KuFhDHVP+2J/8fiEg68PhxHoEdcMwfzcZ04PCH29LpliGK/1l8cdGO34s8+Ulh01igFuj1w7deRhX76eqyDV//XDlpbTrMeC3rUC8DaSxLuSi7fEbzs8RUJ9t23xHWBT/OPBegD6c4gnIRLkk9Nx4aQsLV4+q+RP+Row+B0PGXSTgbOLWzVzc/YOA3wB47ZJKCxiPhU3ZKTjQuS5WwlEi1X3ltT+kxPn975NkIR44Eh8NtZ7Y39eAsJXZXNHjgDgvvIvz6bn71+spBLVi1YJ5YCZSSOoAbcDn7WSpc2ALpBSahKwOgxycxrWm4Q5t/HD33/bGsmWXIZFJvstx2ClaHtdp7WoNNJCkATCsZS3yRngOpXqwYEBmtL44HC5dScXlNdSxxd3DzQzFSttPNLygarhdQhVeN9seQIHzj1jcTmgUAkT/8xDYFtaehbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(22082099003)(56012099003)(18002099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG1LTGtrSDNudzlCNEo4UDI2Ymo3eG5qRGFhME5Dd3JPZlgydWQ2WmVCTnc3?=
 =?utf-8?B?ZG1aZHZIdWdJNWw4eHZiS2l5dzdnWmpaT3I5WlU4elZFQnhDNW5SVmxZQy9t?=
 =?utf-8?B?UlBKNmUxUVlKYVpFN2JUQ1J5S20yaFloNnhFNjhDVWZsM0ViSjVHRE5YVlRt?=
 =?utf-8?B?dEpQREtjN0dramcrWTA1NkswM3RFa0JpR2h6WWd0dDYyZnpXaStBUERMRDZa?=
 =?utf-8?B?bS9aS3R3d2ppZjRONVFoMkNiSk44czRwYi9DZkZnRlAwQU9SSUxnNi9XTktv?=
 =?utf-8?B?a2hTcXhzYTFsMk1iMkV6M011MVlnOHh3QWFNS2tDZ3dwUmZscmszZXNaVDQr?=
 =?utf-8?B?cVFFTUhFVlRKVTRJZm1pc3Z1MXNJR0xQTjlpaE43MVBrZXFkYktsN0xiOSs2?=
 =?utf-8?B?WkZOWDBSWTU3M1hUQVBoYzZMUlJBamk0YmZpdWx1TTUvSTE2OVZ4Z2pwNmRC?=
 =?utf-8?B?cmVOaFpIODlTK2hueVlMREV0Ti9yZ0VLVlpEYkVFRzhvbHcvOVE2SWNpbk84?=
 =?utf-8?B?VDM4MjR6VlkwRVk0elV6RGFwa1R1NXFTYnF5UTVGM2FsNkMweDQyNVNRdmow?=
 =?utf-8?B?Q0ZyWmpFcSs1MVJqKzdxTUdOdnc1Y0RZSVUxeXZ3MEtQNEVCcTYyV1pZUktF?=
 =?utf-8?B?SXo1VEZHTUxhQzU4SkU0d0NDSk0vWUwwTzBYYzZoNHN0OFB6WUNZdXpDRXgy?=
 =?utf-8?B?ZmhJRHZjNFBwTjQweWxZTU1Wc0w2dTRmWHJEckJWcUFtSkQxMFp4dXlUWVhu?=
 =?utf-8?B?T09raXRCRzlucUNVSVFSdklIZWJvSEdoTjNwaUdTSmxLNDlKYkoxK0NOcnNv?=
 =?utf-8?B?TjZnRDZwL3BZMW8wcm9BMVJDVjRnaHNxMHB6Qlk0L21xUnRnKzFMaDhSazJo?=
 =?utf-8?B?STBZU2w4NFl5UkFQajZzVGh5MlNoYlhKb1A3TzQybUJTRndyUG5aNXVnck1x?=
 =?utf-8?B?Ri9Kdk9hWk9qTjU5RkNEM1VoRUl4RjZkT2ZRQkJQNm1QcTc3eGJRYkxwaDg0?=
 =?utf-8?B?TUFxWlplWW1SenRJZTJhNU9kNmJKYy9Yb3ZGaXlmbkphV09XWk94U3dVcFpB?=
 =?utf-8?B?c2QvZEpFSURWS0l2MFBERFJOY2NoaE9LWnd4VkZDZ0hxVG5UZzJXRWduQi9j?=
 =?utf-8?B?WjhNMi9ycStIdGpwaFFicDdwdjJQa1lXRWR1UU14TDlLOEVZZEhWMkZKeXZJ?=
 =?utf-8?B?b3dEemQzc0l5ZDdqQUx1bmpWdmlTbzcrVEJoS0NuaTN0bm1weWNRVkpyQjJE?=
 =?utf-8?B?RWhYRElMTHRBcGJ1UGMwUXVXQVFEVHpoWDQ0Zm1PVllSWFBhZnQwdDRjak80?=
 =?utf-8?B?QW40Wll6SFdhOE56bVZOV0FvQ1QwRTYybWt4TzQ1YVBqaW9jc2ZSaWh3TlhE?=
 =?utf-8?B?d3VqdTltMWtESm00WDZjeklZcXAyUTdZYy9nODBjbWM0ejNHaHVVd1FSMjVP?=
 =?utf-8?B?Wk1kWVJWdUQvVnlSVmVXUnNtVitDY2x2T0RIR1JTRXlYQ2ZRcmxHR1prclVl?=
 =?utf-8?B?eTl4eFVmYzFCa2xpenZtVVkxMDRBR09oaWpxbktUaVMwQnkvYXAwc0g4Umpy?=
 =?utf-8?B?SjdWMGpORmpnT0dVNURLc3ozeVRTNVdmRGYrZ1JkUGs1Vm9kR2Fuem91ZS9F?=
 =?utf-8?B?Qkc1VVBMS3crZ1puREF5dGk0NXE2dFo1eVFwMWZSRStDR05tWTR3QTk3aUNy?=
 =?utf-8?B?UGw0bkJCci9jbFdZNVcybVFuVkdqZFBMUk84YTNrVGMvQmhwcXRUTjhvdmFw?=
 =?utf-8?B?Vy9uZkk4dHJUREJrZDdJVFVvUFN4ZWlibUN5QytpWTVaOW42b01GcU11aFIz?=
 =?utf-8?B?SHE4b0dhMHE1Q1dnZWxhMWwzNkYvYzBPZmJ6aXBMdEtHUDF1UTZBam9COVBP?=
 =?utf-8?B?blZQajlyZWlYNGNhN0orZU5vRjhYajEzRk9ZYjU4dnlQRFFEQlQxZzEvN093?=
 =?utf-8?B?SmlFd1loTFhqcGoyV2p0N01vRCtVTmZ1ZTdNQ1FDeER6VUl3b2IzK3N3Qk5o?=
 =?utf-8?B?RXlRN0FxOFNwVDNKei9PV210T2RNSFB4VHJIRUlmUUJYdlgwVEdEOTcwYkMx?=
 =?utf-8?B?L056RXJRNmtiSWNBMU1FQkY0SjBwdHBSM0hQckV0aXRIVU5BQnplZWkvNHg0?=
 =?utf-8?B?Wm9nRW5KUyt6ZzFDNVgrUHNkaVhNS0lLNmhibUJUaVErdCtwVDVUTTRiL2tp?=
 =?utf-8?B?Y1BYT0tJY1lvSXlPcTYxb2JZMmt4VlJoeWdpNmdPekJDOVlsQnFQMFpxNlhj?=
 =?utf-8?B?NUtEZzQvbEtHcnIxMWZueGxZOHFDMzE1Q3c3M2RjbExmUjJFZWxSNTRTaGZJ?=
 =?utf-8?B?NmFZNkJ6dCtuSi9UTVFsQWdQMjN1dkVZVjRReVZ0S1RrQ0JJU0VPN3NtM0FO?=
 =?utf-8?Q?b5wLq3OUXR1JKSxs=3D?=
X-Exchange-RoutingPolicyChecked: W8pS+EHEJD5iRTY/hivxUu0AbEiaCezv/6aHC2iljgIoUKOnl36j4AdjPtv7RfFW7KQcOZ0WKPP+RxACf60BFAxykLIID7LuTj/ePlvNAVXrOA+8zcauCh3bNYbZnDgYOQnKyhsnJNVH/w9qsrXmU9QeTMdM+hfzTAlW/8oAh5AwgI1HXTXju6irFLrGhIDtaHKyqSk3RPBn+CVtg1W0c0rALJDx4U1MkN+9XwwoyYEux6hDgSs3DEsurZYl+nt9b+6/nFW50CAbf3tJshT8GtclBF+Ez716JE2SPkMDkYzLTC9JCh81g42P3wFnxDn9OdCzcsz1b/YxFDLxVvrWbQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c07392-4049-4c1d-9782-08de81011b6a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:04:49.4817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OlySE1ZpcgtzORF1nb5R6KjDHlc7f7KCvI+e8SWpcpYyuOMeoA6N5u7/Ekxkt1UQQjsvE5CWzTAfaz1DINxr2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8988
X-OriginatorOrg: intel.com

On 09/03/2026 13:40, Iker Pedrosa wrote:
> Add register definitions and delay line control functions to prepare for
> SDR50/SDR104 tuning support:
> 
> - Add tuning register definitions (RX_CFG, DLINE_CTRL, DLINE_CFG)
> - Add delay line control helper functions
> - Add tuning preparation function
> 
> This infrastructure prepares for implementing the SDR tuning algorithm
> while maintaining all existing functionality.
> 
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
>  drivers/mmc/host/sdhci-of-k1.c | 61 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
> index 8af117a8e271c04a80d8dc7bb5ce12075652dd7a..79cb7c8d0b6d9c4206bf01721651c8efe8a173c9 100644
> --- a/drivers/mmc/host/sdhci-of-k1.c
> +++ b/drivers/mmc/host/sdhci-of-k1.c
> @@ -68,6 +68,23 @@
>  #define  SDHC_PHY_DRIVE_SEL		GENMASK(2, 0)
>  #define  SDHC_RX_BIAS_CTRL		BIT(5)
>  
> +#define SPACEMIT_SDHC_RX_CFG_REG        0x118
> +#define  SDHC_RX_SDCLK_SEL0_MASK        GENMASK(1, 0)
> +#define  SDHC_RX_SDCLK_SEL1_MASK        GENMASK(3, 2)
> +#define  SDHC_RX_SDCLK_SEL1             FIELD_PREP(SDHC_RX_SDCLK_SEL1_MASK, 1)
> +
> +#define SPACEMIT_SDHC_DLINE_CTRL_REG    0x130
> +#define  SDHC_DLINE_PU                  BIT(0)
> +#define  SDHC_RX_DLINE_CODE_MASK        GENMASK(23, 16)
> +#define  SDHC_TX_DLINE_CODE_MASK        GENMASK(31, 24)
> +
> +#define SPACEMIT_SDHC_DLINE_CFG_REG     0x134
> +#define  SDHC_RX_DLINE_REG_MASK         GENMASK(7, 0)
> +#define  SDHC_RX_DLINE_GAIN             BIT(8)
> +#define  SDHC_TX_DLINE_REG_MASK         GENMASK(23, 16)
> +
> +#define SPACEMIT_RX_DLINE_REG		9
> +
>  struct spacemit_sdhci_host {
>  	struct clk *clk_core;
>  	struct clk *clk_io;
> @@ -95,6 +112,50 @@ static inline void spacemit_sdhci_clrsetbits(struct sdhci_host *host, u32 clr, u
>  	sdhci_writel(host, val, reg);
>  }
>  
> +static void spacemit_sdhci_set_rx_delay(struct sdhci_host *host, u8 delay)
> +{
> +	spacemit_sdhci_clrsetbits(host, SDHC_RX_DLINE_CODE_MASK,
> +				  FIELD_PREP(SDHC_RX_DLINE_CODE_MASK, delay),
> +				  SPACEMIT_SDHC_DLINE_CTRL_REG);
> +}
> +
> +static void spacemit_sdhci_set_tx_delay(struct sdhci_host *host, u8 delay)
> +{
> +	spacemit_sdhci_clrsetbits(host, SDHC_TX_DLINE_CODE_MASK,
> +				  FIELD_PREP(SDHC_TX_DLINE_CODE_MASK, delay),
> +				  SPACEMIT_SDHC_DLINE_CTRL_REG);
> +}
> +
> +static void spacemit_sdhci_set_tx_dline_reg(struct sdhci_host *host, u8 dline_reg)
> +{
> +	spacemit_sdhci_clrsetbits(host, SDHC_TX_DLINE_REG_MASK,
> +				  FIELD_PREP(SDHC_TX_DLINE_REG_MASK, dline_reg),
> +				  SPACEMIT_SDHC_DLINE_CFG_REG);
> +}
> +
> +static void spacemit_sdhci_tx_tuning_prepare(struct sdhci_host *host)
> +{
> +	spacemit_sdhci_setbits(host, SDHC_TX_MUX_SEL, SPACEMIT_SDHC_TX_CFG_REG);
> +	spacemit_sdhci_setbits(host, SDHC_DLINE_PU, SPACEMIT_SDHC_DLINE_CTRL_REG);
> +	udelay(5);
> +}
> +
> +static void spacemit_sdhci_prepare_tuning(struct sdhci_host *host)
> +{
> +	spacemit_sdhci_clrsetbits(host, SDHC_RX_DLINE_REG_MASK,
> +				  FIELD_PREP(SDHC_RX_DLINE_REG_MASK, SPACEMIT_RX_DLINE_REG),
> +				  SPACEMIT_SDHC_DLINE_CFG_REG);
> +
> +	spacemit_sdhci_setbits(host, SDHC_DLINE_PU, SPACEMIT_SDHC_DLINE_CTRL_REG);
> +	udelay(5);
> +
> +	spacemit_sdhci_clrsetbits(host, SDHC_RX_SDCLK_SEL1_MASK, SDHC_RX_SDCLK_SEL1,
> +				  SPACEMIT_SDHC_RX_CFG_REG);
> +
> +	if (host->mmc->ios.timing == MMC_TIMING_MMC_HS200)
> +		spacemit_sdhci_setbits(host, SDHC_HS200_USE_RFIFO, SPACEMIT_SDHC_PHY_FUNC_REG);
> +}

Doesn't compile:

drivers/mmc/host/sdhci-of-k1.c:144:13: error: ‘spacemit_sdhci_prepare_tuning’ defined but not used [-Werror=unused-function]
  144 | static void spacemit_sdhci_prepare_tuning(struct sdhci_host *host)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/mmc/host/sdhci-of-k1.c:137:13: error: ‘spacemit_sdhci_tx_tuning_prepare’ defined but not used [-Werror=unused-function]
  137 | static void spacemit_sdhci_tx_tuning_prepare(struct sdhci_host *host)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/mmc/host/sdhci-of-k1.c:130:13: error: ‘spacemit_sdhci_set_tx_dline_reg’ defined but not used [-Werror=unused-function]
  130 | static void spacemit_sdhci_set_tx_dline_reg(struct sdhci_host *host, u8 dline_reg)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/mmc/host/sdhci-of-k1.c:123:13: error: ‘spacemit_sdhci_set_tx_delay’ defined but not used [-Werror=unused-function]
  123 | static void spacemit_sdhci_set_tx_delay(struct sdhci_host *host, u8 delay)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/mmc/host/sdhci-of-k1.c:116:13: error: ‘spacemit_sdhci_set_rx_delay’ defined but not used [-Werror=unused-function]
  116 | static void spacemit_sdhci_set_rx_delay(struct sdhci_host *host, u8 delay)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Squash it into the next patch I guess

> +
>  static void spacemit_sdhci_reset(struct sdhci_host *host, u8 mask)
>  {
>  	sdhci_reset(host, mask);
> 

