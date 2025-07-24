Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5102E8DE0;
	Thu, 24 Jul 2025 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753369101; cv=fail; b=bAMoUJP6Nr9af5mo9BLrTNDHqR2MFyn8NG6Q/I2E+ai1PV9S4sRbRjV4hsUNfirO0PDDM2M5PwdiWPDqZj8y0QXmYPlkIzSwTpoU0XCNMJul3MaNMmP6/SUyO/XlgO0Q1vOOnfGRF99eJJBkp0toxnCyGD84cMLLyaphOftIuHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753369101; c=relaxed/simple;
	bh=+0MgedeWyXFgOBizMvFn6d7htbEgMXoLkwmKmGFg/a8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ndBEaFJjd/IaEUkPYdIsldKtwXSwT6TbdDvJM5Kbh032eYv4MNESWadVHjKzicYEQjSx5Pwv/caRWsUHCctNg4L8BNxks5sNCt4br0h7icYlqyIIyaqANM0sACMsfUmDFwlbN062uybHPpIecSoovBNT4a4XgrrlH5QCzhQA708=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J446H8Ok; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J446H8Ok"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753369099; x=1784905099;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+0MgedeWyXFgOBizMvFn6d7htbEgMXoLkwmKmGFg/a8=;
  b=J446H8OkxFleZcFa4KIC712ZkGHijq2iiOz6QEm/P/YwdYDzc+kVYwGf
   ZE+zEFsqy29e+hDwXASjQ/wtQKQII5Ua6Hsm9B6JDJDqIv9/hV0k9SyI0
   jqUDfRhXqRgqMCS1FX6swNM+p2Tq9N9LFgQ+Q+oHhqTf26cz7RL+SEazm
   chqWhpwMT1aePiqPey74Y7nHNI8oM3AV1Gvh2D8Rv9CmpUGX7jesGujIr
   VVbHbnqGoOjlc6xVtGgAvrOH+ugt0Y0EtEr76Wo1SM2U0zGIupfsz9SKQ
   8iUZdmUBKBm8Q488a4rGo9hmgqrI7ymP9ycAtUJ7uJue0TY9EY4Cs66/t
   Q==;
X-CSE-ConnectionGUID: 7blt+kS5QlWNjfYNNAPDcA==
X-CSE-MsgGUID: j97Ru5XKQGmW9OBWeCBcQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="81132254"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="81132254"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 07:58:16 -0700
X-CSE-ConnectionGUID: R8lT8YreReyiJSN10Y9qxg==
X-CSE-MsgGUID: D6IRg2uHR6qoAU74ub41ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="164337252"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 07:58:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 07:58:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 24 Jul 2025 07:58:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.59)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 07:58:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHgbQ03IxVe0gTti3c6mSnK6OCanAEyCw0SpK1Vxf82AeSrVRSHj8b03xw9K0x9abbLSIIunVne57hn8FhY8TC4HUeyJZh/J322yHlNvkaeVCDGcD+m4Tr3UVJe3c+LSWiSxFmdocc8hnh1W3CI8jeFvtPVd71fTDe38qtzW3rCVVp0s63qEO+KRZk45De1JAPQKMlVyCXmoKPMeI8jERIi+R6VnOGktUPQDJ+1F++k54lvHyms23H+Fy+//4CCTHbU4wa4V5S0DPRz0f6SQnGD/mVTbrWxhI+9E7br3ZtM4vK4fBnRY9NFtJbu/pL1e+JVLRu2Sh4QAKhwLJY8HkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lHe/7yfjUc5LaBBCZvq1ERSzzXHStX4S/5XDpNrbHE=;
 b=kLzauAI/xF2qUaO7APZ4uFhEWSO5u45ykQKEKw89S82TM1UdCkS1crnaKT9l0Kkh4DKD9giMXCi04acN1kCPcYv5c2uyc5dKAsDvgVV9kctDlTZsz7N1Jc9lFZaS9JrZ0WJGGmQD4WgHM/nZdEdHwoToDyJ7OXa6+bu6l9PmWknYK8/Eug3wT/QsDyB2nIVz5Vt0dA3i0Q7w7b4Qf2AaJqZs9/3nNplBclBWXBoh5OGiohth+YCF6S1hBwkEXBkI4v+lhZ/+tdzO4UFN5XsIk0Ren3NjYNAIruzcRHEbASe+yV8H/++K2Y4BICFDuoDgnJhoVYGz6UTz4pTg2xcLJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by MN0PR11MB6159.namprd11.prod.outlook.com (2603:10b6:208:3c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 14:57:44 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 14:57:44 +0000
Message-ID: <30cb2e71-5e0b-4fa0-b0e0-3263d9aa8712@intel.com>
Date: Thu, 24 Jul 2025 17:57:38 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/8] mmc: sdhci-of-dwcmshc: add common bulk optional
 clocks support
To: Diederik de Haas <didi.debian@cknow.org>, Robin Murphy
	<robin.murphy@arm.com>, Chen Wang <unicornxw@gmail.com>,
	<aou@eecs.berkeley.edu>, <conor+dt@kernel.org>, <guoren@kernel.org>,
	<inochiama@outlook.com>, <jszhang@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
	<paul.walmsley@sifive.com>, <robh@kernel.org>, <ulf.hansson@linaro.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<chao.wei@sophgo.com>, <haijiao.liu@sophgo.com>, <xiaoguang.xing@sophgo.com>,
	<tingzhu.wang@sophgo.com>
CC: Chen Wang <unicorn_wang@outlook.com>, Drew Fustini <drew@pdp7.com>,
	<linux-rockchip@lists.infradead.org>
References: <cover.1722847198.git.unicorn_wang@outlook.com>
 <e57e8c51da81f176b49608269a884f840903e78e.1722847198.git.unicorn_wang@outlook.com>
 <f81b88df-9959-4968-a60a-b7efd3d5ea24@arm.com>
 <99899915-2730-41c7-b71a-f8d97bb6e59c@intel.com>
 <DBKCYCNRNTMZ.1XJU81M6EE2D0@cknow.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <DBKCYCNRNTMZ.1XJU81M6EE2D0@cknow.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0085.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::18) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|MN0PR11MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f06635-7da2-43e4-f9d0-08ddcac2721c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHA2NTRYV1o2TGdtVTJ3eXJXOTRoUGZ6T2JHOGNML25EZ2tEckZRVVhWZC9W?=
 =?utf-8?B?a3lRQ0JRZEk2Ky9hTFJIeThpTFpTcytBUzJpTGl0WkgzQkhqL1dzUklWRUx2?=
 =?utf-8?B?TERvV2pEdGZIS3NCenBIOG1zb01NaVJXMGJHQmV3TEQvZ2JjZmF0T25JVm9z?=
 =?utf-8?B?MGlaOXVRWmFkN3BDMEluZmJrNkNTaWpYZG9KbXhCVmpjVUt2M1dERzY5WUx6?=
 =?utf-8?B?c0thUzdpUjFVRDM2Y1RzekNvMmMwMkptWnZSeWJaemQwRHJPUkE5bmRZL2Vu?=
 =?utf-8?B?RGVnNWdWZTZmdW44b1hqUGJGUjlkLzBlWllZTzJIa2MyV1R1Q3U2NTk0d2tD?=
 =?utf-8?B?aFB1c3dNSkwxYmdXam94MlZxbzN6NXZqVWNNaDFkTUFxOEJjNlRicXFJbEVZ?=
 =?utf-8?B?L05jdDZyN1BKMlVsL2R2cFhhaFJrcVNUc0VHbGM4amtKN0VTdTRLVkNlUHN5?=
 =?utf-8?B?ZGJ1UnA2MU5ENGFRTEpVRlo3YjVYYVpwWTlwQ29vcjl0N2ZTK0NuTjhvWGc0?=
 =?utf-8?B?Y2xNN3RyaGwyVDAwZnNHQjdicnYvSTl4Z3hrZU54T256dC93dlNtUngySFlD?=
 =?utf-8?B?WGNucnpXK2VtTjFJeCsrVFlJRWVXN3lPNEh6bGp4eGExL2VTKy9uUENEMFZi?=
 =?utf-8?B?cE9UOXFqeTk4T2FzQVJMcERYeWNzYzVpWCt6V21EZXZROFhtcHNITjF3VkhG?=
 =?utf-8?B?aldpUktzNXZteE5ZSk1IbTJKQzh4anZaODF3SmtIRHU2eEdNMEFLUmRGTWFE?=
 =?utf-8?B?MlRLNnpYZ1oyQnY0b0VzY25wSTdpRmdqUm9iczJ5SGtnUnNMSE1YUmNMTlky?=
 =?utf-8?B?dzRrZUQxeDlwYUdtd2k2ejhFaklCWWZYL3I2NElYbXdxc1FzazJZd2wyRXYv?=
 =?utf-8?B?eDZ3RUloQU1qdzNDK3BTeVF2V0NUVGNrMFF0dmJ0SjczZCtCWURScFZXT0w5?=
 =?utf-8?B?T1RleHBpQzBpc3RGUXd5U3N4VmZYZGQ5dVQvYzdSVVRINkdDVkcrZERtd205?=
 =?utf-8?B?WDZUZDhyUnpYbzFpSmlON3k2ZEk2V1YyWFpISjRmT0xDNjR2RzRwQzJoL3RY?=
 =?utf-8?B?bWIvZUo3Zm5rQWxad3hwR0ZQbnVpeis5TktHSzFSNjluMVZiNjlCMU5qaEt4?=
 =?utf-8?B?Vi9qUDN5ZXpnZWZXQS9LcCtYbmNoWTRqamZxZHFJWGQrMXl5VjROZ3UxRXF1?=
 =?utf-8?B?SEpVd2VaZm5tbEpBS0xFUkl4NStONytKaVdnNzhSRzJxK09YZDdabExEVEVv?=
 =?utf-8?B?NWlPSDVzdUtPN3J2cEdEemowQTdBcDFhZFg3RTNGVERkWW4vY083Q3VMaEJX?=
 =?utf-8?B?T20xdGFXUnZjWHVwaktRQ3Z0OGsyKzhJaktKWSs3bmZJMzBUdGVMRWd4ZnhY?=
 =?utf-8?B?SFVKR2N1UlBxQnJObW1WeUM4Rkw2ZXNFaXg4dHYvMjBxRFdTbUpJQUxOOGZi?=
 =?utf-8?B?cDJBNFlkb3k3cFQrODRDYmNSQnFFMTFhdGl5UVpxYzg2VklwMVNXNm12ZWhT?=
 =?utf-8?B?ZHZLUHlwS25hVTZjNG8zWEYzc1YzdXVET2xnaE5UZlRUdk5lTHo3SWFmMEdE?=
 =?utf-8?B?TmR2TXhSWE1MWHpRWE54YVhhSERRWG9UKy9WYUZoMEFSOGNyaGp5d3BGWjlm?=
 =?utf-8?B?b2xwaTBPaW5qb1BZaVVZTGIrWXdTeWkxUTh2Y1RDQW5OOEFqcnJlbUNFOXEv?=
 =?utf-8?B?ZHEyU2ljenZJaDA2ODI0djBrei9zYzFIQTlvVExQSlp2NU1FbnIzbVk0S0VE?=
 =?utf-8?B?WGNPV2JWdnhBbUs1V1AwQklkcWdaVncyQW5hL05JNDkwYXNDemNZdzE4TzVs?=
 =?utf-8?B?eDdmVEpoRnp1TVg5S085eXlhckFxNnlKV3BqNXhaOGxOQk5KTDdIb0IyY2Jh?=
 =?utf-8?B?N0RzL0h4ZjJNZ3QrRVJnTTM3eWMvNkhUYVM1d2lPY1htV1hEYWV6bEc4eDl3?=
 =?utf-8?B?YjhnK2FhOFNFWDcwcWNyamFWdWV2Rys3aVA1NzBzcDFmWFh4aE9LeXFsVHMx?=
 =?utf-8?B?ck8xSHFtWGV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzB1Um9LbThSdHpHNXY3ZEJHQmhXT1JCK2RDb3E0aGFaWVhhcWZ0aklLeXZx?=
 =?utf-8?B?NHcyUitZME45RGI0QXlyWjFueXdobXdDdXNZbUJMTjF3enYwSWpnLzUweW9Q?=
 =?utf-8?B?U3duYVVCRG02MkpTWi84Q3cwNGRzSkwvcGMxcWZFTERQWkE3VlE5N21RVDcv?=
 =?utf-8?B?UHpIM1Y5QVpUVk9FY2IxSkFSUzFmWFdHNVJ0dlFXWWIzSVM3YllUSVFTejJ4?=
 =?utf-8?B?YjllZnFLN005Z0loZGN2Y0kvYTNvVi83NjdUUCtscWp1Q3A1Mnl1N0k0cVB6?=
 =?utf-8?B?UlRJSEhrdG1CZ0tCYlZEL3RKOEEyeXNLYzk5OHhnT1g5RGtiRG0zRkR1TXJF?=
 =?utf-8?B?aUFMSkRHQXVsTGRBT0xmYjhkeFVTbUJrMHZWeE12eVJiMlpUSXFGSUt4SzFj?=
 =?utf-8?B?L0pQeTVDWUM0RjhpcHNaNmVUZU5ZR2JiblRWdWJXTVVoNTdpSWFkcTB6bjdF?=
 =?utf-8?B?NTRzeDZyY0ZQRW85VE4zekRDNlFmVDV1UTVwc29TQ0lvWjNsWTNlaVYzZnRJ?=
 =?utf-8?B?MU1WQ1lZUFo2ektsbXlCR21va2ppbVdWVXN3M001d2l3Rk1SaS9naldlSHVT?=
 =?utf-8?B?MmovYVlGcUZWemNOWGpNWnpQQ21jRXA5RVRnOUhDa0dSU0s5NEo2b2dhNDdw?=
 =?utf-8?B?ZUlCQXFQWm1aeHJVc3VOZmlRbFQzWHRoMko1OTZqcVRzNVAyVVBscFRsQitR?=
 =?utf-8?B?cElOdW9XTWlHa2diTngvNXVkdS9PU3pRMk5JTGtaencwQXNtUkh6M1ZvTW1q?=
 =?utf-8?B?WXN3QUpWbXNPZFBUa202d1ZnOEZwMC9mV3ZpcWhqbEF0RTBnNERQdmpHcHFZ?=
 =?utf-8?B?OTl0QTE0NDNjU2FXZEdSVkUxdFNHYkxqd3IxNEJWc3pQN0hxS3R5RU5VRkdz?=
 =?utf-8?B?ZW5oVm10eWdvVjlneU85UFdRdENsRmo3ZzV1VnJsUkh1VUpOWWRLNlFwc3Fj?=
 =?utf-8?B?MFRBTzhXdkhBOEdWQ3BwdmpqY2VYTzY4dUpCdTFwOGZBTVdLMUl2TnBTRDJm?=
 =?utf-8?B?TlZiRHNLWEJMYlg3YUFuUlN1VXE0blhDeXFNbHZtbmFqR1lCK25XZCtwTTBT?=
 =?utf-8?B?dXdzdEZVYmZmK2dBMlFNaGJEQ0U3NGRXbjVXOHRRM2JSR2hqUE1rTVJYbmpj?=
 =?utf-8?B?M3lKd3BZUlJMOXpOa0ptQ0psai9oczBTd2pmS0s4WXBYcDgzNzNrRDdPeThq?=
 =?utf-8?B?aG9aa3QyaEl2OFJFSjU4RFRQM01ERkx6UlNpWWs4ajNMSXcya0xOanc5RlJp?=
 =?utf-8?B?dmpXU2NZa0FSd2I4TlI2bGV3Uk1ScW1mNjZqQlpJd0NqQk9vME10dHI0Yjh5?=
 =?utf-8?B?cFFWYk1PTjlmUnhmczBXQWtiQWRFeWVUZnYwc0FtWkEvNSt4S1l5cUNKMG44?=
 =?utf-8?B?TVV3YXMzMHE2Y0traFNQUkNudm1MbmZPS2RqUXBHYkRxMjdOWlBpdDZObXNR?=
 =?utf-8?B?N2g0dkxZN2FQZXc5a2oyV0dwRThBY3lOUmtaRlltS1B2RmtPMS9XVVRPbzBt?=
 =?utf-8?B?ZHhRZ05SSThhcXk5QWoxWm5SWTlyTU5TdkN4SFB2RlA5TXh4RFJUVHRSbkh5?=
 =?utf-8?B?a1lJV1d1TEE2aHNIZVJLSDNoMFpPUndhbUErMU5McHE0a2dKWFpGMy9ISVN4?=
 =?utf-8?B?ZVhXbS9nYktZMmVCUFA0SlhEeHlXRDQvcEZMalBmNk14N3ZYaTFsQnJYZU82?=
 =?utf-8?B?ZHFHVWkrd2l0RkV1UkNLNDhHZ2MvZHd0R1ptbHJLN1VGcVgvK3hIemhmcENx?=
 =?utf-8?B?V1FxZ21pYlZBb05NT0tpTEhCQmhDS0RlYm9ORU9uanN6VjZiRWZwVEtsRytT?=
 =?utf-8?B?OHdDanpodFNlbWJHZCthZnVyOXpsclBUUS9vVkdKZ1gyVklCeVhNSkNqN2du?=
 =?utf-8?B?VkcyRXNRNXhtYTFtTGc0VTAySERxdjFtV0twVVVhVlhoY08vYitwN1pEdFFP?=
 =?utf-8?B?eUEwY1JJUk9kanlxb2ZOM0lIOXF1MDFlRWRoajJ0NFRHa3dscFRiWW8yV0Nx?=
 =?utf-8?B?YXl3RXJuQUNybVc4U210MnFpTDhwT3ZjMzlncmxscHBueHlVWkFpdGVDdFFt?=
 =?utf-8?B?eExDcEFhSmxvVnNsalJ1aExIYXQxZ2hxdnhjelNrSWM1SEZSeHNtdVU2SFJV?=
 =?utf-8?B?dDZ0SGtrNTl1OGdPUUlraXkwYnhrejRPcStBL1lqalphcXNoS2h4MkxHaEhJ?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f06635-7da2-43e4-f9d0-08ddcac2721c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 14:57:44.5680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITRxTeO/OgmfznpjQgrzHrVrXiMdmtsJYAm1J4BchfxNswsrW2vaqH/yS436+2fttRbdvNpEVjqORgEkCvX2GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6159
X-OriginatorOrg: intel.com

On 24/07/2025 17:33, Diederik de Haas wrote:
> Hi Adrian,
> 
> On Wed Jul 23, 2025 at 7:33 AM CEST, Adrian Hunter wrote:
>> On 22/07/2025 21:33, Robin Murphy wrote:
>>> A bit late for a "review", but Diederik and I have just been
>>> IRC-debugging a crash on RK3568 which by inspection seems to be caused
>>> by this patch:
>>>
>>> On 2024-08-05 10:17 am, Chen Wang wrote:
>>>> From: Chen Wang <unicorn_wang@outlook.com>
>>>>
>>>> In addition to the required core clock and optional
>>>> bus clock, the soc will expand its own clocks, so
>>>> the bulk clock mechanism is abstracted.
>>>>
>>>> Note, I call the bulk clocks as "other clocks" due
>>>> to the bus clock has been called as "optional".
>>>>
>>>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>>>> Tested-by: Drew Fustini <drew@pdp7.com> # TH1520
>>>> Tested-by: Inochi Amaoto <inochiama@outlook.com> # Duo and Huashan Pi
>>>> ---
>>> [...]
>>>> +static int dwcmshc_get_enable_other_clks(struct device *dev,
>>>> +                     struct dwcmshc_priv *priv,
>>>> +                     int num_clks,
>>>> +                     const char * const clk_ids[])
>>>> +{
>>>> +    int err;
>>>> +
>>>> +    if (num_clks > DWCMSHC_MAX_OTHER_CLKS)
>>>> +        return -EINVAL;
>>>> +
>>>> +    for (int i = 0; i < num_clks; i++)
>>>> +        priv->other_clks[i].id = clk_ids[i];
>>>> +
>>>> +    err = devm_clk_bulk_get_optional(dev, num_clks, priv->other_clks);
>>>
>>> This leaves a pointer into "priv" in the devres list...
>>>
>>>> +    if (err) {
>>>> +        dev_err(dev, "failed to get clocks %d\n", err);
>>>> +        return err;
>>>> +    }
>>>> +
>>>> +    err = clk_bulk_prepare_enable(num_clks, priv->other_clks);
>>>> +    if (err)
>>>> +        dev_err(dev, "failed to enable clocks %d\n", err);
>>>> +
>>>> +    priv->num_other_clks = num_clks;
>>>> +
>>>> +    return err;
>>>> +}
>>>> +
>>>>   /*
>>>>    * If DMA addr spans 128MB boundary, we split the DMA transfer into two
>>>>    * so that each DMA transfer doesn't exceed the boundary.
>>> [...]
>>>> @@ -1280,9 +1300,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>>>>   err_clk:
>>>>       clk_disable_unprepare(pltfm_host->clk);
>>>>       clk_disable_unprepare(priv->bus_clk);
>>>> -    if (rk_priv)
>>>> -        clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
>>>> -                       rk_priv->rockchip_clks);
>>>> +    clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
>>>>   free_pltfm:
>>>>       sdhci_pltfm_free(pdev);
>>>
>>> ...but upon, say, -EPROBE_DEFER from sdhci_setup_host() because a
>>> regulator isn't ready yet, that "priv" is freed here, so by the time the
>>> devres callbacks eventually run, that "devres->clks" pointer which used
>>> to represent "priv->other_clocks" points to who knows what, and this
>>> sort of thing happens:
>>>
>>> [   12.470827] Unable to handle kernel paging request at virtual address 002df7b378917664
>>> [   12.472104] Mem abort info:
>>> [   12.472471]   ESR = 0x0000000096000004
>>> [   12.475991]   EC = 0x25: DABT (current EL), IL = 32 bits
>>> [   12.476657]   SET = 0, FnV = 0
>>> [   12.477146]   EA = 0, S1PTW = 0
>>> [   12.477547]   FSC = 0x04: level 0 translation fault
>>> [   12.478127] Data abort info:
>>> [   12.478126] rockchip-gpio fdd60000.gpio: probed /pinctrl/gpio@fdd60000
>>> [   12.478413]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>>> [   12.479826]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>>> [   12.480418]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>>> [   12.481282] [002df7b378917664] address between user and kernel address ranges
>>> [   12.482421] Internal error: Oops: 0000000096000004 [#1]  SMP
>>> [   12.482980] Modules linked in: sdhci_of_dwcmshc drm_dp_aux_bus gpio_rockchip(+) drm_display_helper dw_mmc_rockchip drm_client_lib sdhci_pltfm drm_dma_helper fwnode_mdio sdhci dw_mmc_pltf
>>> m libphy fixed rockchip_dfi drm_kms_helper cqhci pl330(+) phy_rockchip_naneng_combphy dw_wdt phy_rockchip_snps_pcie3 phy_rockchip_inno_usb2 dw_mmc mdio_bus dwc3 ehci_platform ohci_platform
>>> ehci_hcd drm ohci_hcd udc_core io_domain i2c_rk3x usbcore ulpi usb_common
>>> [   12.486871] CPU: 0 UID: 0 PID: 64 Comm: kworker/u16:3 Not tainted 6.16-rc7-arm64-cknow #1 PREEMPTLAZY  Debian 6.16~rc7-1
>>> [   12.487901] Hardware name: FriendlyElec NanoPi R5S (DT)
>>> [   12.488412] Workqueue: async async_run_entry_fn
>>> [   12.488879] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> [   12.489539] pc : __clk_put+0x2c/0x138
>>> [   12.489913] lr : __clk_put+0x2c/0x138
>>> [   12.490281] sp : ffff800080713b10
>>> [   12.490607] x29: ffff800080713b10 x28: ffff0001f001a120 x27: 0000000000000000
>>> [   12.491302] x26: ffff0001f98e01a0 x25: 0000000000000000 x24: ffff0001f0f35408
>>> [   12.491995] x23: ffffa8da199b4b40 x22: ffff800080713bb0 x21: ffff0001f0f35010
>>> [   12.492689] x20: ffff0001f94aafd0 x19: 0a2df7b378917634 x18: 00000000ffffffff
>>> [   12.493381] x17: 3d4d455453595342 x16: 555300307075656b x15: ffff0001f4885650
>>> [   12.494075] x14: 0000000000000000 x13: ffff0001f025b810 x12: 0000000000008000
>>> [   12.494765] x11: ffffa8da1a73ef98 x10: ffffa8da1a460000 x9 : 0000000000000078
>>> [   12.495454] x8 : 0000000000000049 x7 : ffffa8da18c2fbe0 x6 : 0000000000000001
>>> [   12.496145] x5 : 0000000000000004 x4 : 000000006cb6bb63 x3 : 0000000000000000
>>> [   12.496833] x2 : 0000000000000000 x1 : ffff0001f1365ac0 x0 : 0000000000000001
>>> [   12.497524] Call trace:
>>> [   12.497776]  __clk_put+0x2c/0x138 (P)
>>> [   12.498154]  clk_put+0x18/0x30
>>> [   12.498471]  clk_bulk_put+0x40/0x68
>>> [   12.498825]  devm_clk_bulk_release+0x24/0x40
>>> [   12.499248]  release_nodes+0x64/0xa0
>>> [   12.499608]  devres_release_all+0x98/0xf8
>>> [   12.500004]  device_unbind_cleanup+0x20/0x70
>>> [   12.500426]  really_probe+0x1e8/0x3a0
>>> [   12.500793]  __driver_probe_device+0x84/0x160
>>> [   12.501225]  driver_probe_device+0x44/0x128
>>> [   12.501640]  __driver_attach_async_helper+0x5c/0x108
>>> [   12.502125]  async_run_entry_fn+0x40/0x180
>>> [   12.502535]  process_one_work+0x23c/0x640
>>> [   12.502939]  worker_thread+0x1b4/0x360
>>> [   12.503315]  kthread+0x150/0x250
>>> [   12.503646]  ret_from_fork+0x10/0x20
>>> [   12.504015] Code: aa0003f3 b140041f 540006c8 97ffd9c4 (b9403260)
>>> [   12.504598] ---[ end trace 0000000000000000 ]---
>>>
>>>
>>> TBH I'm not sure what to do as a straight revert seems impractical by
>>> now, so we hope someone else might have a good idea.
>>
>> Presumably the problem has gone away with:
>>
>> 	commit 91a001a1a0749e5d24606d46ac5dfd4433c00956
>> 	Author: Binbin Zhou <zhoubinbin@loongson.cn>
>> 	Date:   Sat Jun 7 15:39:01 2025 +0800
>>
>> 	    mmc: sdhci-of-dwcmshc: Drop the use of sdhci_pltfm_free()
>>
>> which is in next.
>>
>> In which case a separate fix is needed for stable.
> 
> Adding that patch to my 6.16-rc7 kernel indeed stopped the OOPSies.
> Thanks!

You need the other patches that it depends on, otherwise you are
just leaking the memory.  Refer:

	https://lore.kernel.org/all/cover.1749127796.git.zhoubinbin@loongson.cn/

