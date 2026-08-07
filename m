Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F495476CE6;
	Fri,  7 Aug 2026 12:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786104986; cv=fail; b=Znb0xRfbWprA2vCPdtAsrIi7nluCiCr2wtVxWmhb6pR+/FN2pVUrWIvejfLiMmdvscJrhEPiZN+okAW6acVN3VPuMZ23SsBkdXnwwhTs41KTvj9SKNfv+2WhakQHZ1jlMwZ6EAxj4Si3xNIQg2c6y6a+aS/bpSdyAFreb9DisBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786104986; c=relaxed/simple;
	bh=quLCYuae6WXFo0WHcRO9wodru3gRHxO0smbVq1xoLyU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X7oSDAS0MFGzTK2GgchLLgTp6ajG8+ZYecUWqlIskUTb90RE/VdKU5hXUr6RB5uY42FLx3aSCdpLJOrw5tg7yDjTWYQxgAzeM8QAypNpZtc8QYLteQ2aGgqwGamx4CVlBRgerRkLeo6dy4ljTEcVJ1fYEdXp2OeWb5b3QD+Yxog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WXa61fVf; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WXa61fVf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786104951; x=1817640951;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=quLCYuae6WXFo0WHcRO9wodru3gRHxO0smbVq1xoLyU=;
  b=WXa61fVfNt/1Yb4Dz9EBsYI8YOXa2npi2DiNe3pgV5gLc6CdOamuKjYd
   1Tgm4zZMgS1+0B14Ai+Pf+UCks8Tdj+FqsxrlhpYK730qegtTHiggUubr
   sWys42t3OENY71dxq3b/U7PGqUCab/m2IYRcdBw23WJp/At4cq08zXd7q
   eTQgQP3rd3Ghg0uDAKdNbcYqiu9Zbt+B1gTOqA15NPWXQylORcBEhGhsZ
   kgb8z/ZqMAfnPb1U6iQacYfFk6DCinY7F2iEWEbvYEj5FSOu8LhI3l+xF
   JmzfKQ7Srvt+6F6j15TnGoS0OwAMadj0jn29R7zVXaVMECqS7yYVbrpay
   g==;
X-CSE-ConnectionGUID: uaFBx90MSOuR01DVF4TDWg==
X-CSE-MsgGUID: EOrvP/9QRki8mQSGx8VfHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="98224116"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="98224116"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 05:15:44 -0700
X-CSE-ConnectionGUID: lP4+dh4MTXitMwz+o4URDw==
X-CSE-MsgGUID: X6ntGPHxQf6I9i1aoTcY3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="258075556"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 05:15:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 05:15:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 05:15:42 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.42) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 05:15:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wvrZ5uFlm7hJH1qsAgKxLOmtQbSlPGy2U6Hxl5STf8mEMOGPBmeuFPZdfdNEamA/oZp30rDdIOC7P96M/bKMf46WWza2iTlUDMYgFroXZz89NvNBte9U3Eg220Wxvan38kZLtgXypRSliieDMW5wKKi/V33gbo9TpWyKgrrTDBfQVfmYQCF5U9Z8tfMk628wbf3OD+YY3VZzkVIA8Lg25YoWH3ZJSusj+braz+KrcxGadE/+wI/F4xuGc4Ii3K7QZ1KRpdsXJyQBnTGkrvMYNmIDXhinMizaR8CPMCN2FufLAS3cRJJHELc6MdORUOOP75s/R2+76uxMeTmuMNOuSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLBvtNVbpA3Q2XAXIX4Ka8BGu25ZRcqgcVGdxV2ZhMk=;
 b=HpWPmO1Ggu5wqanUNiQpgaZiOZedoCWG7AR+thnVVQ3EkKG6p5UYvnzQdOEC0DPur3rszvBAmG3hPNsJj9lBONwaE/Mm/d/ijfS35a6I5poskyVo9WKM7qpOFVcSpJXKFwqAGhR98g2ABtfx3sDMBmwkrNgfh7Ky0yIBGNuV77h2ZJZ9pnqHcCcI8DxKLUlR3H9tgBlkUcPPjFPDJf9pLInD1Tm51TAwVk9Oeku7ZgBGj4OTBc1ExXR9fKq4zRr/wDwlsL6JTZR0+MsAqmESUWA4pOUDIo/xDCzajjpE1EjsS8e7aEhR9mVWhX3+t46+kHNcSqCMKXUhzaBGD7FIzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS3PR11MB9793.namprd11.prod.outlook.com (2603:10b6:8:363::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 12:15:41 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 12:15:41 +0000
Message-ID: <8be4de32-dd45-4bd8-8ea6-69cfa533a1f3@intel.com>
Date: Fri, 7 Aug 2026 15:15:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] mmc: sdhci-cadence: refactor driver structure for
 V6 controller support
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	<linux-mmc@vger.kernel.org>
CC: <ulfh@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<conor+dt@kernel.org>, <dinguyen@kernel.org>, <p.zabel@pengutronix.de>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260724145009.7456-1-tanmay.kathpalia@altera.com>
 <20260724145009.7456-6-tanmay.kathpalia@altera.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260724145009.7456-6-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P194CA0009.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::8) To DS0PR11MB7215.namprd11.prod.outlook.com
 (2603:10b6:8:13a::13)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS3PR11MB9793:EE_
X-MS-Office365-Filtering-Correlation-Id: eea3e4d8-90fd-42dd-12fc-08def47d9861
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|22082099003|10067099003|56012099006|4143699003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: rG7narrDixGkTdUjuAzIyrb3ujkhbR56nlV+kCYT90tyV+uYexYnMsxbvKNe1Q3q1Xa1eWIFii1IIAOiTUZxAv0W9DE2BevCzwl7vptjM2kNMFqQYljukLR3k9g0iaWJIFvVQJMKT4OcU9pduQ6m4zj0iTn0R7lTIlV9OfvacWGADay4NxIKEVekuV/TiMSrQicAKlFEatnp6Uh0jihpSdR/0/sMGyYKKzb4yCWNzzzsPPh92FzgutZa4+U3aEjZAhTYaT6N0/Aqo/zNbqgNAJ/0s+N1hivzbXrR9YbKG5DejazkrUUUuatwdfJ8ctiFZ20Sf36h/2iL7scERNIn3AtJWnFMoWz1G30VfBYR55+S8bbYmvgm2Ew7sOjHmoaqZZb8P2modFNMITibqWE9CODyCRxh93K0cXbXL98c5k4zCiTrOSO5onSa9fMQbVQDExG5WImJ2P8n9jlD7tm4oDb7fVUDfLQGomEBGRL2eCGRLJT88h43Hf6xHuAqp7meLdnkKqkEWF3ikG7KafjDhCigiPMK76dQC59KOhtAfsdZchb2s1WRuqp4ADCYVu8CoEQ/Ruw2v/mcKUITDZebA75oMT1SqfUUCcIvk9pWd0w0zDNvSRev6esuQwKVbJYI7nvqq7Wf/EWNyCB+jYx/DhjRnkVYlDl6sjV1QzcYeWQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(4143699003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3hPYmY4c09XdGJFYUtxemgvdGJ2ZytoNVlad0gyZm1iZXYvcGI0TjIvU2FQ?=
 =?utf-8?B?UThPSUVOZmlIYlFyY1FTeVpKME51dUV4L1hmUzZpZ05ZcEVxL2s5dFZIRmJE?=
 =?utf-8?B?VkJucFRLaFRhdGdXbU85VU1FTWlSdDI5aEJzOVFpTk9uZEVkcUFQTi9VZGpQ?=
 =?utf-8?B?UDc0bTdOTUlUQnJpTFN2dllTUnBEMElMc2tLd1BpcFk0d3RsWlVpWmpqS2Z5?=
 =?utf-8?B?ZHM1akY1NkVJa0U2S1UxUm94TmtFQkZ6WEpXVjMyQjlQZzhFaVhQUkhjVlFZ?=
 =?utf-8?B?bmlsRjBBcW1GcEc2ZDZQcjlTL3JMeG9EOWJHYkpNeDM1cTFWU1IwWThMd1My?=
 =?utf-8?B?d3dEOTZ0cyttRG5ENUdUWUpyK0F1UCt0d0RyTm8xbWprNUdsY3NXM0g1THU0?=
 =?utf-8?B?MnNHZmx1ckJUOEVCYXNBbno1TnNEbUpVZ1UvWU5nNmFiMHpGNVhBSnpacy8y?=
 =?utf-8?B?VDkyUnd1blZlKzNUSjg1RkFIOThFazJEUWh2ZjdyTXFsN1ljRTNpMWo2dFFF?=
 =?utf-8?B?eERKSjRuVDZPc1ZPcXh2ZnNiZUxBU1pjMnpFMFFmL01ya3JwQkhXT1VXelI3?=
 =?utf-8?B?aU9nTnc3ekVCa05wNGFWNFA3eFJiZktPMDM2YTA4Vk5OMmxIM0RVVXpqdDND?=
 =?utf-8?B?cHp5VEt0TklDSUxjL2JDYXRTTzc3bWhwRnIycldlQ2JLbmY3RVFUYkVrcHVi?=
 =?utf-8?B?YnNNSXlSNzlpOEVnaXhHdDhNRTJ4UGtlOTNuWDh2VGpNVWEyMDlUdCt3Y3dM?=
 =?utf-8?B?bERoeXRvYnNPY01qV2JxWEwzK3pwa1lHWkFRYmV1aE5ocHc2NzJ0YXllQXVI?=
 =?utf-8?B?bDRGR2RwQXlOTk9XQXd4ZEpzTFdXQXdZVWR5d2JPZThmL3FLYStoK1haRGFa?=
 =?utf-8?B?WCtVVDRMbzk5YVo0bXVDYWtjZFZRMWxoTGVnWndVM2tFd0tNVW1GVkkrWElw?=
 =?utf-8?B?UnRLSlVTbzh4NUIyRG5UOGRxR2E1TEdYbWNzdUpOOVhURElYOXBsS1R4T0Mx?=
 =?utf-8?B?c0JEQzhSSDEyV0dZUTlYaFN6NjBZYWNBeXJrV0hxR0w2RlFZR2Z6VUNyOFF5?=
 =?utf-8?B?a3hwWk1QQitsY3dxV1dUYVJsODlneHhBWURTSVU2c1QvL3Rpbm9kZlZxUGZq?=
 =?utf-8?B?ZmQvTnV4b3NqaDEwZU9WMS9yaFhIcERrWWZ0eHZkNi9uQnBhSysvT0VDSGNK?=
 =?utf-8?B?S04xd1VRRnNEN0hyYmN0TkZpYThmSGJtK0pNVEQzcXlncGY3eTVLcVE4Ty9n?=
 =?utf-8?B?c0VmZklpblBwMFE0bVV5eUZNam5XRVFQMm41WnVlZ1hhbEsrcFZyWWlEVjhh?=
 =?utf-8?B?RjNTalFFWi9UL3hoT2ZJcCtmMFU1M2d6cDVUTG5rVTA2dkRqb2JwenhTdmwy?=
 =?utf-8?B?R2Jod2I5UXg4UHl2WEZaYVE1eTU1bzNMZXpiZjc3U2NpS0w4VmhmdnBHWitO?=
 =?utf-8?B?OGRRTy8xaUUyVnVHK0JtdGwvcEs0SmpCYW43bjVPem9RbG9FR2NyaEV4YnBn?=
 =?utf-8?B?UytUbXUrTll2RDAzMXk0VWlSaGpNN0g1andaem9YUm03cWM1TG5GeDdrWE9h?=
 =?utf-8?B?THBxOWMvV1ZkY0txU0w5WWtwQWhreWVReCt3ZE93YU9KZ2JTcVBMYmRLcGU0?=
 =?utf-8?B?WElUM0ZSNndxZmRLZ1lEa0I0TXVQQTZTWUFpaTlYbVViRW9IQzdqUmEvallz?=
 =?utf-8?B?U2tUYTlTNkwyVU5NYkw1aW5ZbHpvMkozMXBZRXpJMnRNejZjN2pwdkJtYzBS?=
 =?utf-8?B?a0F1SEExZlErem94UVprRHpEdlBvSWxreDRYbDdweVN1R3lLT0tWVUZycGsr?=
 =?utf-8?B?bTZEaUk1aGNiZFFPendncmNvT2FXQnpWcmFGaEFoZEl3YWVQZlpBbDVCR0lu?=
 =?utf-8?B?RFpiRyt1NEkwY2FVU2p1Y0pqWTNWWUxyWURPVHhoY1YyUkNaTnJIY054aUo4?=
 =?utf-8?B?Y25palg5ZU53QUF0emtQU0Z1cUx2QlRwNHVSeEhwazhRd09IOTJGWU8ycTJJ?=
 =?utf-8?B?VGdBUzFRaExRZlUvVW5sRitBVFRFeEZCNGhuVEc5QjZsWisrRlBRM2pWL2Fq?=
 =?utf-8?B?ZjVBRzRzV01ndnNZOXU0YUlqS1JEZnZ4d1Uvb0xUTlVmMWZsR2ZKZ2I1eEx5?=
 =?utf-8?B?dksvNk5JanZtNzdjSFVreFpxRjBoeVZ5bEdPR0hxWlcxYzE5aklkelBkaWhO?=
 =?utf-8?B?OTArelRmN2xqSUdiazhpdE9zWkhIdEU0UnNMTkduNDY5VElQcE03SVVYbmEr?=
 =?utf-8?B?WVZBaGppc21Ub2J1cGV2UGNkMzdBWXFaeUM3VVVrWkk5dHEzaUJsUTN4c2NH?=
 =?utf-8?B?dThucTVxZytUVFU5Y0IzVUdLbEsyNllsNGQxRERYWU9kM3lsNVY4aFM4aGd4?=
 =?utf-8?Q?rZHI7du/bXxZYpNo=3D?=
X-Exchange-RoutingPolicyChecked: Y6k6Qmlab6NyB/FVdZ2V5Ac0wJKp3cm5KnkbeaSqAVI0csPCFn3j8/VpBYKioQDlT1gJwqXoxQzFKm2HwYz2oxFuKaSaq+Fp3GsXfXAp7M4B6hJBYpGO18DAOTBEle8eCa06KHzfUrVVfmhTXGOIu5A/ZOsvxndIHJsZrhFe8WiteNQLL5g/kulbLSB56vbFzwcTTAn0CAZj4t/R4R70h3LR/E0j7bmrs1lVPgae1DM4uWhL/utPgo1e37K1uTiMCBjyNjtSlQvstgn8CDtnjWjcTa/Gfi8p/FRu0KyCCZ+KYeWcp8CIpdMqAsxQl6zBlEyy6SiWFo5t3lxoldslog==
X-MS-Exchange-CrossTenant-Network-Message-Id: eea3e4d8-90fd-42dd-12fc-08def47d9861
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7215.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 12:15:41.0780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: plYjquayC4ss2vuPkboFh4jmm4MjT3wUXRUDYVvN2NYAJRE4Ku8oN7Ofhd9MZ5qUXb0b7NpzMZnt1AtcfZRCpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9793
X-OriginatorOrg: intel.com

On 24/07/2026 17:50, Tanmay Kathpalia wrote:
> Refactor the sdhci-cadence driver in preparation for adding SD6HC (V6
> controller) support. Separate PHY parameter handling into a dedicated
> sdhci_cdns4_phy structure and move PHY initialization logic into a
> dedicated sdhci_cdns4_phy_probe() function. This allows different
> controller versions to manage their PHY configurations independently
> while keeping shared logic in the main driver.
> 
> Each compatible entry now carries its own driver data, so drop the
> silent fallback to sdhci_cdns4_drv_data and return an error if platform
> data is missing.
> 
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-cadence.c | 54 ++++++++++++++++++++++----------
>  1 file changed, 37 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 8a6ef6d9d1dd..1fb23051a047 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -83,6 +83,11 @@ struct sdhci_cdns4_phy_param {
>  	u8 data;
>  };
>  
> +struct sdhci_cdns4_phy {
> +	unsigned int nr_phy_params;
> +	struct sdhci_cdns4_phy_param phy_params[];
> +};
> +
>  struct sdhci_cdns_priv {
>  	void __iomem *hrs_addr;
>  	void __iomem *ctl_addr;	/* write control */
> @@ -90,8 +95,7 @@ struct sdhci_cdns_priv {
>  	bool enhanced_strobe;
>  	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
>  	struct reset_control *rst_hw;
> -	unsigned int nr_phy_params;
> -	struct sdhci_cdns4_phy_param phy_params[];
> +	struct sdhci_cdns4_phy *phy;
>  };
>  
>  struct sdhci_cdns4_phy_cfg {
> @@ -167,9 +171,9 @@ static unsigned int sdhci_cdns4_phy_param_count(struct device_node *np)
>  	return count;
>  }
>  
> -static void sdhci_cdns4_phy_param_parse(struct device_node *np, struct sdhci_cdns_priv *priv)
> +static void sdhci_cdns4_phy_param_parse(struct device_node *np, struct sdhci_cdns4_phy *phy)
>  {
> -	struct sdhci_cdns4_phy_param *p = priv->phy_params;
> +	struct sdhci_cdns4_phy_param *p = phy->phy_params;
>  	u32 val;
>  	int ret, i;
>  
> @@ -186,11 +190,12 @@ static void sdhci_cdns4_phy_param_parse(struct device_node *np, struct sdhci_cdn
>  
>  static int sdhci_cdns4_phy_init(struct sdhci_cdns_priv *priv)
>  {
> +	struct sdhci_cdns4_phy *phy = priv->phy;
>  	int ret, i;
>  
> -	for (i = 0; i < priv->nr_phy_params; i++) {
> -		ret = sdhci_cdns4_write_phy_reg(priv, priv->phy_params[i].addr,
> -						priv->phy_params[i].data);
> +	for (i = 0; i < phy->nr_phy_params; i++) {
> +		ret = sdhci_cdns4_write_phy_reg(priv, phy->phy_params[i].addr,
> +						phy->phy_params[i].data);
>  		if (ret)
>  			return ret;
>  	}
> @@ -539,6 +544,24 @@ static void sdhci_cdns_mmc_hw_reset(struct mmc_host *mmc)
>  	usleep_range(300, 1000);
>  }
>  
> +static int sdhci_cdns4_phy_probe(struct platform_device *pdev, struct sdhci_cdns_priv *priv)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct sdhci_cdns4_phy *phy;
> +	unsigned int nr_phy_params;
> +
> +	nr_phy_params = sdhci_cdns4_phy_param_count(dev->of_node);
> +	phy = devm_kzalloc(dev, struct_size(phy, phy_params, nr_phy_params), GFP_KERNEL);
> +	if (!phy)
> +		return -ENOMEM;
> +
> +	phy->nr_phy_params = nr_phy_params;
> +	sdhci_cdns4_phy_param_parse(dev->of_node, phy);
> +	priv->phy = phy;
> +
> +	return sdhci_cdns4_phy_init(priv);
> +}
> +
>  static int sdhci_cdns_probe(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host;
> @@ -546,7 +569,6 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_cdns_priv *priv;
>  	struct clk *clk;
> -	unsigned int nr_phy_params;
>  	int ret;
>  	struct device *dev = &pdev->dev;
>  	static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;
> @@ -557,11 +579,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  
>  	data = of_device_get_match_data(dev);
>  	if (!data)
> -		data = &sdhci_cdns4_drv_data;
> +		return dev_err_probe(dev, -EINVAL, "missing platform driver data\n");
>  
> -	nr_phy_params = sdhci_cdns4_phy_param_count(dev->of_node);
> -	host = sdhci_pltfm_init(pdev, &data->pltfm_data,
> -				struct_size(priv, phy_params, nr_phy_params));
> +	host = sdhci_pltfm_init(pdev, &data->pltfm_data, sizeof(*priv));
>  	if (IS_ERR(host))
>  		return PTR_ERR(host);
>  
> @@ -569,7 +589,6 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	pltfm_host->clk = clk;
>  
>  	priv = sdhci_pltfm_priv(pltfm_host);
> -	priv->nr_phy_params = nr_phy_params;
>  	priv->hrs_addr = host->ioaddr;
>  	priv->enhanced_strobe = false;
>  	priv->priv_writel = cdns_writel;
> @@ -590,9 +609,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	sdhci_cdns4_phy_param_parse(dev->of_node, priv);
> -
> -	ret = sdhci_cdns4_phy_init(priv);
> +	ret = sdhci_cdns4_phy_probe(pdev, priv);
>  	if (ret)
>  		return ret;
>  
> @@ -650,7 +667,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
>  		.compatible = "mobileye,eyeq-sd4hc",
>  		.data = &sdhci_eyeq_drv_data,
>  	},
> -	{ .compatible = "cdns,sd4hc" },
> +	{
> +		.compatible = "cdns,sd4hc",
> +		.data = &sdhci_cdns4_drv_data,
> +	},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_cdns_match);

