Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E70B1E0E00;
	Tue,  8 Apr 2025 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744135163; cv=fail; b=mZGYX+qnwRjt/4POHp14TrUAdJTihYh+ba5GM2G5E/wAsRqZbPrcXH6Cg92OvWfYzURWrFTHgugPaXjvmin4tuoLJecRNlBPmUiZ3+XNvYBIDFLx6S6fPdUEqOMXIIDkEtshDu0TNU+QsC0Pj7bIqBPA3QaZw+CZSqIbsFP9h5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744135163; c=relaxed/simple;
	bh=wtbErmBJdPCK3CWcSFyEBkYRSACU/uWM/QqWpB/SxPc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AE8fSywosNSLkEaVC7+5ex3/gDqMj0uXHUOSEkh+FMVt3GqJPzWM7H/U3Q1ZfXQYk10CSWa0N//EH0dbTNXSZZex27+gnethOSVSYKmQtMjXq6VTCHTs+0j8TnQT1R/Nl/Lt5guk5qIqpXTcN8q0XTy0EbkJ17dS9mGOLmgXpbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WR0zwELd; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WR0zwELd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744135161; x=1775671161;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wtbErmBJdPCK3CWcSFyEBkYRSACU/uWM/QqWpB/SxPc=;
  b=WR0zwELdEjgnt6Qz6vF5vcOO7koMWjSf85CCTbMbzywK4z/89aM3ePnw
   aP0dro+dWHsj5g01vgUXwi9b0aHLDfjNAYW0B786HgdZJBuq7XDlXSixK
   +5a/sj1kqPiENd8zuNvUsW/NAKTtC5dAMu/shfX1zgNVDWaC+jLnpvD/f
   Yn8ZywSjDHwTt7pgYmump/5nBhaxdwyZZMX4bpjcoS/k0j7g48Q1MXKID
   iN93I9xaHEvujIHz3J+90zCiz+HcWhaA6O9JNJhkD2vyl4OSVTtih+B7s
   AH+5ZcOwQC+CuEmoI/fSIPklUU0fbzvsiLHOzuh36zfblbNjR40u+hPoD
   w==;
X-CSE-ConnectionGUID: 1olDY/vqSAKxzTm3p2c6Ww==
X-CSE-MsgGUID: HVunRGT6SzqhgiAp12WNyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45704108"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="45704108"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 10:59:20 -0700
X-CSE-ConnectionGUID: 5sPg+HRER065AP3T7Cf1+w==
X-CSE-MsgGUID: kYxNIOK1RI+aFcwBg8pVYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="133058727"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 10:59:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Apr 2025 10:59:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 10:59:18 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 10:59:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xi7OCC7MgHV64xuw1mOPtZ8BLm/C94rcjgELR/+VofrBKb8m0FyrK+RczBth4dTIRizW5SWSfqaDqG1ynP5Sod7CEF96DWnsNB0PoZ5+pr4+kwc248qj0tjePJAA1MumY7MCif7VING9PVowKJbwtZOuGL1rr5avD+KuWTOq6hxkiyIHXjjKlGCReMq3UiZF48yX6y8mwCm0aI4z0Nc2nAbU6sNSn0kB7klatbm1uPdYUeqiRdz2YqDHIp65/JkUje29dEK0H3BXxb2naxJS2DxsdxTBY4ekCwfgkjCDYnZUFBpF4FwCX0aLvD904pxiGwyI0NB/UTVz3/jVkHhrCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2it5QBX0TILYpCIRIpKPOgUMojQNgkQjzuK1kPITvF4=;
 b=PyVGrWN2bzmVxFeNUWV8BholaMVmMX91ltKiycGgvC/VvNTBpYFgJkiEeeDQpX+7WpYp06Tp5Oz999wZJiKOjFiIJP5cGKopaDugHg4bdPsDNnkU+krnzV9Q9M9q3zKmnuCXArLD0yg8cTlGI6PbpzT0Jc4GTHeg+kJsZwgxHVdnfMVQcfXDrYmqOS7lTMQs4hDejPrtLHitmkYkEHPs6Dr4CVwpwDBxW2WZ2CKA8JrM6I85TzaqmDqtUqroLgRmUHbZ4LPJV9M9gkOypnS+EYPLwwaPJdKOFAa/oNmw73LunFAD/LF6KnBzwxghQy9fBxoqHJeZOp4L9js9Ddp3yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by BN9PR11MB5226.namprd11.prod.outlook.com (2603:10b6:408:133::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Tue, 8 Apr
 2025 17:58:59 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%3]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 17:58:59 +0000
Message-ID: <72e24e74-8c9d-4d4e-8a22-c2f55941c6ef@intel.com>
Date: Tue, 8 Apr 2025 20:58:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mmc: sdhci-esdhc-imx: calclute data timeout value
 based on clock
To: <ziniu.wang_1@nxp.com>, <ulf.hansson@linaro.org>, <haibo.chen@nxp.com>
CC: <shawnguo@kernel.org>, <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
	<festevam@gmail.com>, <imx@lists.linux.dev>, <linux-mmc@vger.kernel.org>,
	<s32@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20250324092336.2231385-1-ziniu.wang_1@nxp.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250324092336.2231385-1-ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0009.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::9)
 To BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|BN9PR11MB5226:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f6a582-73a1-455c-9346-08dd76c70994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OW9FcWtmZ1c4SFVEZ2FtMitTQW1nVmgrcWxNaUVVRG8zWXNzbXY1U1E5eXFx?=
 =?utf-8?B?R3lYMER2bFhTYTNVbkZBbmtXd251SWtaM1Z3dUZKVXN3ZnN6enVNRUVEOHhN?=
 =?utf-8?B?bDVlVUJOeW94bFZuOERrRlAvcDFySTR0RFg1VVU3UFZDK3BzTWpmMXlTbXNL?=
 =?utf-8?B?QzlEYTkyU0dLZTFiVHNFYmR3UWVUQU1rU1J5UVU1RStuQ25rbW4xMVBJMVN2?=
 =?utf-8?B?NXMzQzVmcjJJMVF1YXpKNEdOaG9WaEVCS2U4djBjb1YxQXM1OGp3eGJmTnBm?=
 =?utf-8?B?Zi8veDVCQlZNdHBLZTcwbjd1UEtmbXFuL04wNEEwZ2Z0UEJtbHQ4Sy9iMHRw?=
 =?utf-8?B?SU1FQ293ODFEdmRmb09JVlA4TmlkTDlhSmJRTUJRTU5xc0pzRU5tWU96MFl0?=
 =?utf-8?B?Z0Fra01BdEFKYUhUazhoYUdZZXhaL0R6Z3pHR2J1VGNMeTRnNlVORkFRQjFp?=
 =?utf-8?B?dnpHUTI5U3dINms4SURzQ0xsaWtGYTVIcytxeCszSHdwSTNsZ2tOMHh4NGJQ?=
 =?utf-8?B?N09RVGlMVU9ycmlrc3ZxUldwdWdKNGtTSHhUNTZKODJzMzlsM0grTUREVU5K?=
 =?utf-8?B?MWpHcGErOUNOeGRYRUZTQnYzUlo2U0UrS3lXMUhPU29vUGF6dXptNm1ZbVFO?=
 =?utf-8?B?SitLbjc1eFB0ZU5RcnRNZHRLYW5Sb1RjUU9DeXBCQ2c4Z2xkS2tMYXFjUUVy?=
 =?utf-8?B?Mmc3cjQ0MWQ1RHRVSVVvQ2M4dlBKdDd4cndodzBmQTdQV1M3Um9wTFdwWlFZ?=
 =?utf-8?B?VUxyU29lWHdsdWhHU2dXcVNmOHBpZlR4eGZ3QWI4dWVsTEJCSkRCTnJVdXkv?=
 =?utf-8?B?ZVRCWjB2Vk41NVhJNDZOWkt5U3lmNUdwL0JCcTkwbllRMXNnL1MwM01SeU9Y?=
 =?utf-8?B?NThzbHkveUs5L0UrcG9qMEFJbTMwUFU0RHlZUUtHZlp6NFlCZC9haERXU2VQ?=
 =?utf-8?B?dHgyandGWVozSFdqaWdockVERWE4RldiTVd5QmtsdmIzNnZnbmJab001bUZS?=
 =?utf-8?B?bUd1TGw1aHlWNjg2Rjc5SEM0Rlh2cENYWDE0cHVIcG5ubmpQSVUrQ0NZOVFz?=
 =?utf-8?B?T1JWMmM5dituWVp1eDk3SFBpOG51WW1MUGNGUWl2SHhHRzZVUW5URVlwTTVP?=
 =?utf-8?B?YWd5RlVQcDMySVVNWU04UkF4Q2pBdnBER3VqR3VwUzVVYTQxOGhkMHlGS2FH?=
 =?utf-8?B?MjJQdHBvdmdLSGVuU2FFUGhkNFFmV3R1YnBVUGZyRUN1aldtL0cwbHRuZ1FQ?=
 =?utf-8?B?Wi9ZV1diNUxSbVowM2hWSkFVS1BpVVphbXc0Rjk0aVAxM05abVR6V1M5UVRG?=
 =?utf-8?B?dkxMMFN5SEJNb05JRW9GZzRsSnJVd05aY1hOWHZ6Y1FyKzE5MjF1WGJTd0w5?=
 =?utf-8?B?MURHdGF3WjV6OTB6eFQ0YmpjWGN4WmhNRm5kOWQ2b2g4b0RDcSthNFdXVmkv?=
 =?utf-8?B?ZGJ1R2xsS0NraEZrRWlkNk0zb1NqSW5ucm4xYzIrOStHZmYwZnVaR1k3YlR0?=
 =?utf-8?B?RkY2Sk1DMlo0Z0p4clIwRStkMENRZUxzbS8vM2NuNUN0clZhNzVIaDZ3OC83?=
 =?utf-8?B?cEZVdUd0VUIxM2RDbTVtbFpjN1hZWjZQcUFQbnEyaXdiM3p6M1ZjTW5qNnly?=
 =?utf-8?B?ZlBENTBZSnY2TEJaTk5obEFnTzR1TlA5QTZrRG1wdDRqSFdUY3QveCtiR3BM?=
 =?utf-8?B?anZ5V21TeTBTc0hDVGZlb1EwbVlibEVidnh5RGZ1QmZGaEdPanlnVU5QdG5X?=
 =?utf-8?B?Yy94UFlERTdHOEluMUpzWEJlKzFkZXNYSGsxSmJXd3Nsa0RnSTQwWGllMnpm?=
 =?utf-8?B?cUE1Q0hXTjc0R25ETWxQK0VWakxKVytFVzF2ZEpEa2Y4cElCaEsyT01tR0J2?=
 =?utf-8?Q?CDFCWUvd4RH6o?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUtvVzU5S0pCVmMyOXhieUhWR0FQYTQzMUIvUHhoS3JDK0VsRTYvdlhrdkh0?=
 =?utf-8?B?T3NtMUZGUFZNMHNQYUNzZnBZRVhFOUFDWWF0alZQaks2RGJGcGR2UHdkRlAy?=
 =?utf-8?B?Ynl2VDc3YktwZDlQcmJ6NDNXdlBSbjAxRmVWMDFtVjFnNllFbGl2U25wRU9M?=
 =?utf-8?B?T1NoRTI3bmt5cHBkUmMvUEhvQ1IwcXQ4KzV2ZkZ0S3FnYnJyRno5RnZwSktV?=
 =?utf-8?B?bHdUREVCZkQ1bmhCa3BCUWw3ZWxLN2QyU2ZMOWRqL29kQmlITGd5ZTRjMEJL?=
 =?utf-8?B?WTk2ajB5SUUrdUl3NEZuR294UFRualk1YmMvcldMTFAxTXFLSFR3ekhnYm9k?=
 =?utf-8?B?bmNnSUc3TG5pU25yYW5HMktlaURlOVpkNU04V0V6bi9BM2FTS2hnYUc1NnNt?=
 =?utf-8?B?bUN1alhmSHU0STIzVUZMUDlwcXVTWnlTb0lLMkgvSlRkZXloQ1A4SnNXbDlE?=
 =?utf-8?B?OEE4S3ZRUisxcVE5dW04bktITVhYemNkcTg2MU1HTUI2V0wremRRanhnK1Zy?=
 =?utf-8?B?TTdXYnRadDc2SXFSMkZEYTNYSVhrbytLN3hmdHVOcCtPdWJRaGIvMHZFRXNO?=
 =?utf-8?B?Um93WHpPNkdSSHB4VEY0eVdyZHk0MWFCSmtJdWxYYzZVTzg2MGdpVVVoczhF?=
 =?utf-8?B?VDcvN1hoM3R3YndXam5iQzMwYVFwd0cyUFkwZXhZNmUxWmoyUXQ0REU4ZkVx?=
 =?utf-8?B?QjlYSTl1RS8xN3oxb2cwRmlqYkZiZWJzWnVEL29KQ2dWNXZxL0VDdHlFWUFY?=
 =?utf-8?B?QWt3bDVReDdtRS8xTVVqY25OdnlLUXBLS1kzOEIvZzI1NHhsL2cxa3V6UGkv?=
 =?utf-8?B?aVpnYmhIMXRaMEswUmRYallVRnozRnFxVGNweWV2WWNIYTk3Q2dhbkF1N2Zs?=
 =?utf-8?B?QzNRYnZ6UDV2YUtXcFlHS01XM3pEbk03Y1lhL1RFQ01vdEY5aGFHVkIvWEs3?=
 =?utf-8?B?UHMxYnhFdEJvUGxCMmMvdmthOXNOUTFmbDBzSjFXenJza09TdUVINzhkbnRS?=
 =?utf-8?B?c3hnWFhOeDQ1T3l5RFF6K3hZbUdkR2tKNGUyZFA5aWVpR1hyQ2Z2TWE4R1dT?=
 =?utf-8?B?cDNQM0pPWS8yT09YZTlEcmNjYkxDQ0JVTHo2UDhLTTh3dmpKaVp0clIxUlNJ?=
 =?utf-8?B?d3BkalR4NGtpVnZNaVNuUzI4UlVTQ0QwUkc1bGxYOUNtNGx6QU1YQ2hwRDZR?=
 =?utf-8?B?OTl6akNyc2hmT2FMMXRMUHozTzlZWUlvV3hZTDU1RUNtaXptck5mS3JTSXQz?=
 =?utf-8?B?bkZ3Y0FWRjVqR2J2c3pCY2RvTG04UXJtQWoyQmZaVXlLZUZUME05N3hxVEtX?=
 =?utf-8?B?S0xoUFc2WW1haDJTUWlCN21CbUJraTlLdS9VZlZySGJpT1NETHFTVC9HRklC?=
 =?utf-8?B?UDNtb0FmVmliSDZpU2cwZzBZMlgzQWJieUpHeVRZYnRlMnZ5Yk11MHJndU15?=
 =?utf-8?B?RjM2eUU0WG5kd1F3SVVUcjYvR1NFTzA1dU16OFRrb2FQV1R3VytsV0NYb3NG?=
 =?utf-8?B?aG9KcGZNUHdTZzIrZDY1dUluMHNzZ0w2S2RyWDdESmFwVTNnV3ltbUJBWnQ0?=
 =?utf-8?B?anRWU0hydFlOZG1nM1EyOWtObTVIL0R6eGNsZkhLSHY0NnIvSlZVTWIzWXJi?=
 =?utf-8?B?TUVPdENLY1ZpK1FDMmF2OWdCczFRcW52d0NnckpNMUo1YmpTekFRK29GT05j?=
 =?utf-8?B?L3JERWZORkNCalFHKzRJVDJPdVZ0RzVwWFBZdnVZSjRHc3cwd2V6U0JBMzYv?=
 =?utf-8?B?ZllEN1dnQlNxZDYvN0JKdTgzYW5lc2lNYlFGbWhFS0ZhTENxOHFZb3c4a3Iw?=
 =?utf-8?B?L0dHNHA5Q1lqVXlHV1RzTzF5bFN0SkFxUzd5K21qUlNFc1JzVnRxS25kQUpM?=
 =?utf-8?B?QmZkSDl3YXZIVUdDZVhXUjNuRUd6aXBUb0RZcCtXckd3NFcxMmxxWE15RUVJ?=
 =?utf-8?B?K05Xb1dISnIzWjIzMERiSXo2akpjTFJtTTdJM29ETXZ0NnJGaFhBOVRJbVBV?=
 =?utf-8?B?TTZKVHh4ZWZtY29ZdmhNaTcyNnVReXBMTlF5WkliNnZXZmR5eGZkZGlYQ3JI?=
 =?utf-8?B?ZlpjMjNiZy9TWnF5dW8zektKV2NPcy9Jb0ZkL1hJN1g2eGVwTTlFTm93aE9M?=
 =?utf-8?B?ZUZBS0pwcDhNa3ZOSzN6QW9VV2FUQURkTnA2NFM0alZuMHdWSElyQVppVVQw?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f6a582-73a1-455c-9346-08dd76c70994
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 17:58:59.1143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wf5E3t5J2EVcsdhhowvz0dbD3Q88wnKlwR4f9vF6gBWJIPgSa8xN91bOv56Ar36u/clLVVhz7BaIKRVmdSSlBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5226
X-OriginatorOrg: intel.com

On 24/03/25 11:23, ziniu.wang_1@nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
> 
> Calclute data timeout value based on clock instead of using max value.

And the subject:

	Calclute -> Calculate

Presumably the driver has been working OK up until now with max value.
Is there any particular reason to change it?

> 
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index ff78a7c6a04c..e7316ecff64e 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -31,6 +31,7 @@
>  #include "cqhci.h"
>  
>  #define ESDHC_SYS_CTRL_DTOCV_MASK	GENMASK(19, 16)
> +#define ESDHC_SYS_CTRL_DTOCV_SHIFT	16
>  #define ESDHC_SYS_CTRL_IPP_RST_N	BIT(23)
>  #define	ESDHC_CTRL_D3CD			0x08
>  #define ESDHC_BURST_LEN_EN_INCR		(1 << 27)
> @@ -1387,12 +1388,16 @@ static unsigned int esdhc_get_max_timeout_count(struct sdhci_host *host)
>  
>  static void esdhc_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>  {
> -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> +	bool too_big = false;
> +	u8 count = sdhci_calc_timeout(host, cmd, &too_big);
>  
> -	/* use maximum timeout counter */
> +	/*
> +	 * ESDHC_SYSTEM_CONTROL bit[23] used to control hardware reset
> +	 * pin of the card. Write 0 to bit[23] will reset the card.
> +	 * Only write DTOCV filed here.

filed -> field ?

> +	 */
>  	esdhc_clrset_le(host, ESDHC_SYS_CTRL_DTOCV_MASK,
> -			esdhc_is_usdhc(imx_data) ? 0xF0000 : 0xE0000,
> +			count << ESDHC_SYS_CTRL_DTOCV_SHIFT,

Could use FIELD_PREP() here

>  			ESDHC_SYSTEM_CONTROL);

Another way to do this could be to add SDHCI_TIMEOUT_CONTROL to
esdhc_writeb_le() and remove esdhc_set_timeout().  That would
avoid having to export sdhci_calc_timeout() and is perhaps
slightly more consistent with other code in this driver.
Probably look something like below:

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index ff78a7c6a04c..66477fc0ba82 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -870,6 +870,16 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
 
 		esdhc_clrset_le(host, mask, new_val, reg);
 		return;
+	case SDHCI_TIMEOUT_CONTROL:
+		/*
+		 * ESDHC_SYSTEM_CONTROL bit[23] used to control hardware reset
+		 * pin of the card. Write 0 to bit[23] will reset the card.
+		 * Only write DTOCV field here.
+		 */
+		esdhc_clrset_le(host, ESDHC_SYS_CTRL_DTOCV_MASK,
+				FIELD_PREP(ESDHC_SYS_CTRL_DTOCV_MASK, val),
+				ESDHC_SYSTEM_CONTROL);
+		return;
 	case SDHCI_SOFTWARE_RESET:
 		if (val & SDHCI_RESET_DATA)
 			new_val = readl(host->ioaddr + SDHCI_HOST_CONTROL);
@@ -1385,17 +1395,6 @@ static unsigned int esdhc_get_max_timeout_count(struct sdhci_host *host)
 	return esdhc_is_usdhc(imx_data) ? 1 << 29 : 1 << 27;
 }
 
-static void esdhc_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
-{
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
-
-	/* use maximum timeout counter */
-	esdhc_clrset_le(host, ESDHC_SYS_CTRL_DTOCV_MASK,
-			esdhc_is_usdhc(imx_data) ? 0xF0000 : 0xE0000,
-			ESDHC_SYSTEM_CONTROL);
-}
-
 static u32 esdhc_cqhci_irq(struct sdhci_host *host, u32 intmask)
 {
 	int cmd_error = 0;
@@ -1432,7 +1431,6 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.get_min_clock = esdhc_pltfm_get_min_clock,
 	.get_max_timeout_count = esdhc_get_max_timeout_count,
 	.get_ro = esdhc_pltfm_get_ro,
-	.set_timeout = esdhc_set_timeout,
 	.set_bus_width = esdhc_pltfm_set_bus_width,
 	.set_uhs_signaling = esdhc_set_uhs_signaling,
 	.reset = esdhc_reset,


>  }
>  
> @@ -1777,6 +1782,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  		 * to distinguish the card type.
>  		 */
>  		host->mmc_host_ops.init_card = usdhc_init_card;
> +
> +		host->max_timeout_count = 0xF;
>  	}
>  
>  	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)

