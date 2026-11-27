Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795792670;
	b=JZaooN9S72upoQp8pw59JNzXVEeE2y38UYvefR6CBXYQlop0xC5jqYWabYmVKcHlC35u
	 TVjqX6LZZE1SNruZxk5RlceuJi/hPG0eUewogb/g7VUO5l/M632UtCtEyTkMCM/6iOso/
	 INSeUFDIANGjUeQiKXIxv8H5uxUzacHiHuwDPXsA/n8c8JEM/SIjN8X75kWSSkeOFjvtH
	 3BxEvcMTyf/RkabM4ulbn2rNsWfGHp7Pwc+GzWNT2sa26lvJ+79Yo7NJ/qAXoBPKJm1ZR
	 RmBghpa3KwQLTdvEB4o3TH17tNhnZDac+tk7NxpZda33g6FjoIc7zJk1J8Cx/EGMuJA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795792670;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=QaV1WNKQNjcabBwkUa8i6fMnXDMMt1G3R2qcebtjKdE=;
	b=fbaJDkkxfJDDY2hIiA5HDCXXqduIq8MMEj9jPYkept+DV6h2VFAmkpthYxHKYz4x/+Lb
	 wqrRCXBTC2NHpQ7F0a5K6cMZ/Mrm666MYpr5FJJPzjC4wQ1y7lBzNxUOeC0z0XrSRFGFy
	 g/2q3VnMXZ7g46WnsIzdE/qusMgLpPxm8tZJAbLSwjhY6F43z7RK1kR5mZ83HCqXXEWDM
	 r+DsTauDPFF9MBujFf5G6fsq17KuxlIyoyE5uPT5EG0CtNa5KB+cUezRXjghKtVJhNuRf
	 FItH7NEc/LqItujYw2kxjzWM+7d5MUpuO7Q8WJli/EDtsYPA7BZY90fEBZ+RlKv+8Eg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fFJSVwm4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A18606A331;
	Fri, 27 Nov 2026 15:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43A18606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fFJSVwm4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795792671; x=1827328671;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MvyxKjXXIdWhXt1P1F7hkeEAVnyTmQrA0xWfiZEORE4=;
  b=fFJSVwm45VvRuBNuCGan0QZwoMnjbJ3at5aIgitoZxu28LYruvNa4Sl9
   FoO2uDKp/D12Ge/dUcOu/nKwtHEQXy5XJU4uUYZuRnmB2zLCVp2hdIbUB
   uHWE0RaZ2wmU9z2p+28J9ARaIzhapLFKOhjQ1mUCg35uPzsT4ImndFDnh
   JHuVDSz1c1sN9OzVQQ10pnK7d3cz1eSqvCBS4C/1tqP186P30Ci0ETrb0
   I0XdFPCejb/a/CIH22GoQNLNighM9YhU10TPoXwV4yd3tufgOaHR6HsMo
   CvVmv2gBT0Owv0QEHrzjkRtNPfv0015qZhiEAV8/0vYbyhWZ3XdN3NXOT
   g==;
X-CSE-ConnectionGUID: ebz4ZwJkRsWQ+YpGQilWMA==
X-CSE-MsgGUID: zrBGAJk9Rk6qFdkR14yLJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4725701"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4725701"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 07:17:50 -0800
X-CSE-ConnectionGUID: 58LRUk/uSLO5Vsn6gLyuvQ==
X-CSE-MsgGUID: hiY5lNX3QuKWFe3iWj1yHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="3953947"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 07:17:50 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 07:17:49 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Fri, 27 Nov 2026 07:17:49 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.39) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 07:17:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrPY9ELwthou/yzw2F4UNoxRCdIMW7H7YQXwG9Is/q4M35eJUBmPJyzm0mYgrqHoqkRdFlAwrfzxDBiBcn2u1Niu6LDsj2mkz79z3mMJA0PyXlc/brESJ6O+iE1lgNgCCh2iLOwFQm4rytRlbGsowyhBsQGQ78aLuo7H8Zc6p7tZsrFvdFRdCaWnksvtubKbB8JPENsrF93cwEi1z1GE77dsVi4ooQPSs6O1C5oYxMACz9d5kKq9Swiu7P4Qg/GXDCFPJIcjk28Aqviy5IJqtCfGRuEQ344NM00OUoLrCEDW9+Upl92dxpWpTmxNsxbxpu3zaHlZeXzEboFFJRRojg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaV1WNKQNjcabBwkUa8i6fMnXDMMt1G3R2qcebtjKdE=;
 b=qhvdbCuyRQOa3yKTVYE0rrIKjiP0K8FfqeMKIGBHQj2k49A8uEo6tSC3vooxIvs7ChI2wSbb0xjgtDLTwj3OfZKEe6swoYYYu7cSNegnIirrUmYwMvIvqafXltn2LczGwNuqAVqeKseNonmZjcfF98eLhg1ip4VMNTxnvWIZF+DVxhwnJ5m7ktTPvTDgn68VpzgkgND+aVGXBxY4ZUrAjc4t/cQR9wJwjM3K+aVDQnlEADnh+7qn/yzLnd6zXUBLI7Uc24EZ79FNQq7kr6cZxG9snn+SogYJ+tf1UXRHr1iGPXHRJzWVvwNl5cJjTwOHio/CXh66HFmycGjLFvGMrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH8PR11MB6659.namprd11.prod.outlook.com (2603:10b6:510:1c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 15:17:45 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 15:17:45 +0000
Message-ID: <25d69def-1b3b-423d-88e4-5a59c5de8723@intel.com>
Date: Fri, 27 Nov 2026 17:17:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Improve eMMC performance for the StarFive JHB100
 SoC
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>, Changhuang Liang
	<changhuang.liang@starfivetech.com>
CC: Ritesh Harjani <ritesh.list@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20261109081813.3846-1-changhuang.liang@starfivetech.com>
 <CAPx+jO_s2hPhY3vvStjucDqMUajknKFMYavqa9Dxki0HM4wpAg@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606-4,
 Domiciled in Helsinki
In-Reply-To: <CAPx+jO_s2hPhY3vvStjucDqMUajknKFMYavqa9Dxki0HM4wpAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0336.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::15) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH8PR11MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e744c54-1df3-4aea-b22b-08df4c999683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|261026140227099003|261026121527099003|261022075727099003|261022105027099003|261021121427099003|261028144727099003|261102123227099003|261102130727099003|261009223027099003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 7UfJEBrgvUY8RvZZyIjmsbxjX4DBAYaDSjRg4HdU/fwV6PJnfGy1L5DjYavbz5NtVNxqXnC45/J8tRYdA8wgxAeMXFz4MNcR0AAafHjzTAAyOv6Zv2O1ot3ZSjGJzOuPcQ2HjbWlFZHwX9ptOzUeZPx/OAjlRqIrkLbKLXoF1hXnOga1od2BUonqrVB5J1q1xhYSVtkEUjL5cmIQ4XNr9M33/nGX4JiHPSx+4GKrHlzMWPcN2Xf9HJmr8UkfwhsYysX2g6M211BYJHBvf2x0gAHKHTRKm4nNaMbquK+BUg5TnGJOvn3MxfK5wKa1QOlfJBGDMzF4AeRuge/XrArxtfiBqbMzsTOO5ngXhnT1iap47ttPiC7ae+X41N2Bn9WxW6xbWqnREnUhsmzSaCIsGHOLq5gXxhVWZjZmGSWdEsuDIanJQ0doZ9fKccMrRsk4DGzytm0jKFtXmaX0SJk6yhLpizpBQfxwiio+qZgeVxk6CX0onAF87cTtu9g2I1RKGEsi8UPiyALtmr8fLBM5x7/SnqUl24T7oJO6bAxeqrqOUWP1CS4NeOojO6yreabWRvZLAsHrTwO7qEu+AUMIcEw9aQx2SNIX/FXThILJnwkZYbpcq8UwaPVS+ImM2rKx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(261026140227099003)(261026121527099003)(261022075727099003)(261022105027099003)(261021121427099003)(261028144727099003)(261102123227099003)(261102130727099003)(261009223027099003)(22082099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enlVOHMxRkZiNTZTZExmL2ZkcHhDVmd5c0hkQTJUTzNZRWZ6dEdtMThKMklN?=
 =?utf-8?B?S3pQMmIzVmo1VHdQb3g4OWNzbG90bDNwbGF5U3RGbjZ2VHVXYWQvcXhGRm84?=
 =?utf-8?B?RXEreTdXSU15QmNsVnJ4TzVZQkFqWEcwQjYxanRhMmhKRk93RGtVU2d3czNX?=
 =?utf-8?B?QnJLaFpCTGNoSlIzanRUcUFybXAyZ1VrQXJhbUtpNXNGZUc0QitKMXVudno5?=
 =?utf-8?B?Z2dBRU03U21vc09YUmVDM1NiNDdRU3p3c3QzRmRiVUNwV3hMSHV4TFlYZDc0?=
 =?utf-8?B?d1B0REc2Z0ZkSDNqU1l5QTZTT1VEUHdOTVdtQy9WVFZxcndiNS9CRWtlS2Vm?=
 =?utf-8?B?L1JLeHZtK3p3VGFKbEFEOVhwL09PMGNhRzBZREtIYlR6UkhYcDljYlhIWkFw?=
 =?utf-8?B?dEFTR1ZReHhsSXJhTzIxL3ZYNTZ4VXpZUDc2T1JIdXpoTlZEclpCVmgrY1pN?=
 =?utf-8?B?R3oyZEFwQ3MyRXJkY29QVzBaZFZxNkw3dWphSSthczNhR21Ob09hWTBFQkV4?=
 =?utf-8?B?VS9ST1MxQ0RkbXhBdHpxMzlydmt2dmRmUnJSSGZsRTZpSlUrREVJOTVLVENa?=
 =?utf-8?B?Q2tUbEZDa3E5S1RuNlpwSm1TL1luS3pQSlBGRXc5WGtpTlZJVWxpWTAvcStQ?=
 =?utf-8?B?MnUrc2dZckdQRkpZUFA5UENqMXpvNXFrL3ZDSjZWL2ErM0FqN3drK2dCUUVn?=
 =?utf-8?B?YlBtKzZLL284VXJ4SWY5N00xTld1aTFNSXdRdUU0cUg1OVRyUzNIditFUitu?=
 =?utf-8?B?aVlXaUFYQjFkQk5WbkZ3SDFLMEI0clk4RlBzT3dPbHhjWEkzSE9mUEdnSnVs?=
 =?utf-8?B?Wkdob1FYM0V1ZlFNRi9FL0Q3WFhvNkJEL0Z1SThFNEtrbnhrVm56SmVsMlhv?=
 =?utf-8?B?ejhrbmxLUVl3a0V1TGNEQkpMWVFXcUVZTlB0ZzIvV041L0VaeGpqdDZtdFpu?=
 =?utf-8?B?RFNwS3VjNy9WSUNFUUR1bU5zZFhCeW9tTkVhaE45QzUxamNUTW00UXVsTnd0?=
 =?utf-8?B?OUY3c003S1N3ZGpLQlZPakJxV2ZOOWRVMVNTdUwzZWxpRG9ZUUdrRFM2a01p?=
 =?utf-8?B?SndJejZFdUtpNTYrU0xyaWE3TDFiWXJaVWpSZEttSnB4MU54cHJZNWd1MHo5?=
 =?utf-8?B?NHU3SzJkZGkrQXkraHJHU3JRNktUbUxtczRBMklwak1PaEtpdy9xSi93dG1w?=
 =?utf-8?B?aVJGelVXSmRkdm1WL2dFcm9wcmZibzFQb1g2MUQ0WXpqemFSbm12alJBbkE1?=
 =?utf-8?B?M0wwa3M2U1RZZkw5UHNkSWdHZksvNi9ud1NsMlN0M0I1cjRtd1pGOVNHM3ZG?=
 =?utf-8?B?Skxadk5ybjhBaTNVUUFMREhaTDNXajZzbEV1VG5GWGFVTGNLcVV5OUNkcGxO?=
 =?utf-8?B?YjNuallJRGRTMEdzcmc1VU9GV0RYN01qOU1EWXpmSnpKejBaN0pnVC8ySDRo?=
 =?utf-8?B?bTEvazBQMXpyYlNIV0VRZ2cwOVdMczNnNTFuTnhmc2REN0h6bjVuT1FvN1J3?=
 =?utf-8?B?WlRsdXVFZzRZZnJxcXB5dFNabzZ5V1JqelU4NjRSOVVwemFrbVlMNXd6KzM4?=
 =?utf-8?B?aVI4V1NmNGFsOUtBZzFGaVVYK2FwZGVTNERsUlh5cmV2ejlkSU40UVlMaWZm?=
 =?utf-8?B?aDVVdmtlMTZFWlhKa2djb0xiclhSK1RQcGZFWWRveXh0bUpFeE50YXF1cHRI?=
 =?utf-8?B?TlB1Rzh6d004OU1ibTRMKzJHemtkdVhYNkxFbHZZQkQ3LzhyNzNvV3VaWnZW?=
 =?utf-8?B?MWZZbjRlWUxUdDk2TDgyRXNVdXg4ejFSY3ZIeEQwUEtkWjlqZjhiK2pnR1F0?=
 =?utf-8?B?QkJhUDAyajVQcnV4TUgrN3NUckVSeDRrL3ZZWG11OFZOdFZ2QzZQeDVOZUJ5?=
 =?utf-8?B?VUNnYm0xMWtTQUtKQlN1S1FEQ1NwU3VGRWRua1pHdDVsTFYzUnJ1aTlHSVFs?=
 =?utf-8?B?MEVSUVNxcjBLaXNJUEp5NVRvdDZqa3g1SFNMYUFyUVB4akhHQjBxSWkyNU1U?=
 =?utf-8?B?a2p0VlJrUXp3R2VjdzdRN2kzMEVkTDA5akgvd1RyTENPcFB1T2tVWFNUNmNQ?=
 =?utf-8?B?YU9PaUJlUHVtdzNOMTB4NWRzYk9XZFBrUDdEenZqdGdSTy81USsrOHRmU2dk?=
 =?utf-8?B?MVJIL21TaGVhd1NZV3R1V2NiR1JraHYzYXJlRGFjb1pzTlJkYWgycjlERGNo?=
 =?utf-8?B?RHpXTUFyTHJaajU4U1NMbUdKc21WQld1Rk04MDBjcjdEUnNITmUwYUhOSExK?=
 =?utf-8?B?WEYvT0hzL0hTOG9RUmM5WFJ0QVBxaWlxUHVMRjBtUWhWT2VIMHhpQW5zOVBn?=
 =?utf-8?B?YXorSmpEQ0g2YUZUR05NWXQ0dytWc1RZVmMwWld4YUFaSWZZbjh4NEZubHMx?=
 =?utf-8?Q?U7yT1DGAiw2uSiPM=3D?=
X-Exchange-RoutingPolicyChecked: WdeKU0W1iMvPcNnOL3sR7aF0uHxrNcNac/PZg9AhMbUYxY4Ihu5hnPQ+La4yEWCW0ySJq7d+9pkIgrHa9ufDzwLXOW35yUGa29Y76APyUgSnBxW2YN3xf+mJm3hpGPkzd0YRAsJ9Q9Q4RxfMLbW0aL1niXQnQoEYGDOCkPE5TG7Dra2+6riWAe5RssCtgOCtI+1pT2Fal/vPLLOsz9Jq+oE5Jenqfu2IUvCB/ulWaZEQkNUPtJg2Vyc6j1C9so21g6lmvXtp5+HV0MyX4YUBVWR3BBFhhGW+dDXmpc7DdPNGvg3aaq4tjtL9UNofAP1vWkrIAF/pR2XbblMaD/jumw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e744c54-1df3-4aea-b22b-08df4c999683
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 15:17:45.2384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clxpsnGEr2KXtRhHl0ZQ2FlogBxpQOBiuyitgClbhZiUGCp8gpNBNSkMbFOmYav5vfQAqOpgkL0TlQMNzOS2BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6659
X-OriginatorOrg: intel.com

On 27/11/2026 16:21, Ulf Hansson wrote:
> On Mon, Nov 9, 2026 at 9:18 AM Changhuang Liang
> <changhuang.liang@starfivetech.com> wrote:
>>
>> This series implements programmable support for CIT, allowing host drivers to
>> set the Send Status Command Idle Timer (CIT) in CQHCI_SSC1, either in
>> nanoseconds or directly in internal timer clock cycles.
>> Different platforms can improve MMC performance by configuring their respective
>> CIT. This series has been tested on the JHB100 SoC.
>>
>> before:
>> dd if=/dev/mmcblk0 of=/dev/null bs=1M count=800
>> 838860800 bytes (839 MB, 800 MiB) copied, 9.38511 s, 89.4 MB/s
>> dd if=/dev/zero of=/dev/mmcblk0 bs=1M count=800
>> 838860800 bytes (839 MB, 800 MiB) copied, 12.2127 s, 68.7 MB/s
>>
>> after:
>> dd if=/dev/mmcblk0 of=/dev/null bs=1M count=800
>> 838860800 bytes (839 MB, 800 MiB) copied, 3.19472 s, 263 MB/s
>> dd if=/dev/zero of=/dev/mmcblk0 bs=1M count=800
>> 838860800 bytes (839 MB, 800 MiB) copied, 10.7587 s, 78.0 MB/s
>>
>> Changes since v2:
>>
>> Patch 1:
>> - cqhci_set_cmd_idle_time() is removed, along with its EXPORT_SYMBOL.
>> - A new internal helper, cqhci_init_cit(), computes the CIT during
>>   cqhci_init(), replacing cqhci_itcf_init().
>> - Replace itcf_hz with a driver-provided cit_ns field.
>>
>> Patch 2:
>> - simply assigns cq_host->cit_ns = pltfm_data->cqhci_cit_ns before cqhci_init().
>> - dropping the post-init cqhci_set_cmd_idle_time() call and its warning path.
>>
>> v2: https://lore.kernel.org/all/20261104112657.110536-1-changhuang.liang@starfivetech.com/
>> v1: https://lore.kernel.org/all/20261014121222.31385-1-changhuang.liang@starfivetech.com/
>>
>> Changhuang Liang (2):
>>   mmc: cqhci: Add support for setting the Send Status Command Idle Timer
>>   mmc: sdhci-of-dwcmshc: Set CQHCI command idle time for StarFive JHB100
>>
>>  drivers/mmc/host/cqhci-core.c       | 45 +++++++++++++++++++++++++++++
>>  drivers/mmc/host/cqhci.h            | 13 +++++++++
>>  drivers/mmc/host/sdhci-of-dwcmshc.c |  7 +++++
>>  3 files changed, 65 insertions(+)
>>
>> --
>> 2.25.1
> 
> Adrian, no rush, just wanted to point out that I am awaiting for your
> review of these before proceeding.

Thanks for the reminder.  For both patches:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

