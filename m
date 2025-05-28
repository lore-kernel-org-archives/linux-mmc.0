Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3318283CAF;
	Wed, 28 May 2025 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748434217; cv=fail; b=VeR6T7Mfxsqk0lsSzdVLLWzzWtNwvpeyZPZfKEmdQML+wb/AnrQ5v6WAJlx8YE43/y6IfHw4nWthiiDeYunZYYJmFfeBIeQv1pAeS6y8OvbwTqU/to/JihXvfQkoo8KKiEahaX0WAKDbBu7pYAILuNiZaEQuoROoNsA59cZJBOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748434217; c=relaxed/simple;
	bh=XISfYKEoOe+sZMPtYIMPBX7CWZARArrU6hjdYchaQ6E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SWTGZvv8YvZs0yWj5vnnlZRX60cz+RXFTp44V4bF2R6YmnjARnra16mr9kGtucD+X5NqVYDxAXFXZ/kDKBTWFT8i4c5jEgLYQXZXT9RVtRuJbaBvcAWG2T+xQBGI4/w12oVptZIdLxVYCQAIxfR2xrAefnuMDCe2J2BQx9bf7l8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SS7OFohJ; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SS7OFohJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748434216; x=1779970216;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XISfYKEoOe+sZMPtYIMPBX7CWZARArrU6hjdYchaQ6E=;
  b=SS7OFohJ4RU4Rmtaz4bivUBb85k959KPMg2gWss/Grm9wKjITNkb9rFc
   teOzSSSik6nnM7rLk30oVA9AWhGuSVWihI0OCCa/k2FlkEppJH+Bjvcyq
   MoINBvNPZftTHo0r0BTrALDUr2Py4gJGXolLO8NHbe9PYVJimrnAY/xSB
   NFXDwhEqBXlTA0EosF+fILG08QANuw8ixUm4cE7SyyefRmQK1cOIqkLRW
   4/jR8c3d5f+bpxD56g+0YoEMHLo6I1VRpnPDN2cqwKkTAKr+hBQx9s7yr
   yD2/cfhbae9/S6KU3ux7HVk16BpUTq5bJV6R1i3nVONKlshCsoHnfbQs6
   A==;
X-CSE-ConnectionGUID: UzqRDhB7S3mtlJyNCM1k+A==
X-CSE-MsgGUID: I9F2c7TZRXmyi1/RxKsGxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="53080615"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="53080615"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 05:10:15 -0700
X-CSE-ConnectionGUID: vJhEya/xSkWj4ysycNNmuQ==
X-CSE-MsgGUID: OkeB6+FVQk2f/Wv3OB0tlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="148263792"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 05:10:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 05:10:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 05:10:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.51)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 05:10:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geZrrLHvhX3MfHm69KirFJbI/HuFwgNLG2VE2/+z0TUDUZpWsPF9vk/IljsDRO8AYPSAJwHpp7/BPhI7DCcPZ5YyEloXiB1wiZ/2gRSbh3INELIGpL8CnFCn3A0y5NrBjdwo1DcSQR45bjtquBMr7gH7tXNpJHgmqzJ1u5kFsikGdgXir6boCPeVsg//ItpjdLWtTSXIQ76N2k62YW0X1bV6PIDZyJ3P9uMW8uHnvYtEkU9oXaSE4uB9RaYkPNVNPID20kITbMs1OH5w1prTZrucBM/eT+N3sWI4JVma1/bFrqnc5ELqD+3TdfSX05yTMexcA91NquH6d45AtD+RXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Or+vAXllEyWYiZQeDZDgXzbEG225rAbCpI+yfUqfYEc=;
 b=UK2reh0jQKBz98nMyFGPTQXQRd7fexGaT8C85w6cBZO+nADyYoNVAFvHU3pCWlYqv+4T9ZcGjtPN0NA/yhymxrTapsPdymBu3H6yQyfI7Hlv2qZ2cXFqeafNlLZF1IgermS3yld2BLgbw3oplfqtND4Rx6aYLkoq/iV9KwtQxc9GAt2KU3yAQXFYXEUFfaGAjKWEjmzum0iMkh7xi3LOztnINpz1TPbxTVVH6nu2qMTh8kvKEbkto2PoUrMOlox5TOhI1R9p0POH7cMW8vKw0+pZZh4EsOdbSmNQSX/8RnlSwI2CQI1+PA0NhJJ44ijNN1myYOmLBr/E5NOz0XeIqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8)
 by PH3PPFE1E3F709D.namprd11.prod.outlook.com (2603:10b6:518:1::d56) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 12:09:45 +0000
Received: from PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301]) by PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301%6]) with mapi id 15.20.8769.029; Wed, 28 May 2025
 12:09:45 +0000
Message-ID: <20d2730f-1e1b-4f47-b208-201468e21029@intel.com>
Date: Wed, 28 May 2025 15:09:39 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND V2 2/2] mmc: sdhci-uhs2: Adjust some error messages
 and register dump for SD UHS-II card
To: Victor Shih <victorshihgli@gmail.com>, <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<benchuanggli@gmail.com>, <HL.Liu@genesyslogic.com.tw>,
	<Greg.tu@genesyslogic.com.tw>, <Ben.Chuang@genesyslogic.com.tw>, Victor Shih
	<victor.shih@genesyslogic.com.tw>
References: <20250523110155.10451-1-victorshihgli@gmail.com>
 <20250523110155.10451-3-victorshihgli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250523110155.10451-3-victorshihgli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0087.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::18) To PH7PR11MB6054.namprd11.prod.outlook.com
 (2603:10b6:510:1d2::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6054:EE_|PH3PPFE1E3F709D:EE_
X-MS-Office365-Filtering-Correlation-Id: c58bc973-5d0b-4ba1-c9e8-08dd9de088c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUp5cUdBc08xTXcvRkIreXJGT0FzUDFhUmZqY1NJS3QrUGZyNnRJa0NWUm5B?=
 =?utf-8?B?OTIxZmd2ejJERTljWU0zVkpRbjk4V0hxQ0Z6NlpHTkZsdVo2MFU4bUMxTHFB?=
 =?utf-8?B?VFp0V2RFcStBaFhJQnIvdi9yc0p5am8zYkF2RWNydVpJY0szQzNnNkdyanNU?=
 =?utf-8?B?LzdNUlNzOXYzbnoxMUhldGFzRE04Sk4wZ3o4NG1YbHZoQ0pPNUlKeFpIejdG?=
 =?utf-8?B?bmc2UVk4cEU4akFmWTkzaEx4aFN2L0JjcW1wOE1LOC9XYWIra2dzdzV6TEI2?=
 =?utf-8?B?cHZaeUxHNUZTYjJWaCtUWmJpSFRRTHBEamM0TG5EZitmRTRzUHB2NzR0Zm0y?=
 =?utf-8?B?S3NseGlxNFYyR1EzOXVTemJ1WjBoQjNVT2FOeEVUZjVWT2x0L2xINnlrQmlH?=
 =?utf-8?B?bSs3WERWYmRFTCsxdHFDWG80WEFuVnRCd1JGYStvUzRzTFVsRWpId2drWUxB?=
 =?utf-8?B?Z3E4VVpFRXJUTEVYeXJLcjJ3VVdNUCsyN21WL25vc3RMSlZJaFV2WGpPUVU3?=
 =?utf-8?B?WEIvdFJUcDF5a0M3b3czZ29pV3hlTWdhOUZQN2FxMUltT3ZweUM3K2grN2hh?=
 =?utf-8?B?ZkxTRE1YR0VFdTd0ZnkwUHRoUkI4TzJaZkFaY3hHYTY4ZzZRbVg2bVRzeU5x?=
 =?utf-8?B?b0NKVjF2alZDVms3RmY1TFhROUpuRldWTDlSemxFVk12UkxzNjR5WTZNQ2hs?=
 =?utf-8?B?c3R6Vy9yZEZ5MWgycnQ1NUlaSkZVZ3RWUmJQbERFL1dOMDY0SWY1alRSeXMy?=
 =?utf-8?B?eVFVaFlqNS9qdWYyV0gyMTRFTXdUS05TN3VvUDJodmJRSmJTdXVpL3VLY2hO?=
 =?utf-8?B?Njg2V0JRMk4vTUZYYlVrNnBVS0MzY2VzUHVkQisrbzRkU1IrTW5vbEppeXpy?=
 =?utf-8?B?MGkwK213R3cyNXFvWERsR3RDLzcrZkJKSFJma2lhd3VtVmxDS1h1TzdmeWVj?=
 =?utf-8?B?alh0WWZyR3ZaTEd6UWVMcFJibVZnNnIrc0ZNOENqNDJqbmFOdmJDc0t2QjA4?=
 =?utf-8?B?V2hmNklUKys1Ti9zOVJVZDJ2Vzd3QlAvR2xvYk5hV1hSZzdYUXE5bHdSR25l?=
 =?utf-8?B?M2YrT3NjWjZHTGc1MW8wck5sUmtmUjZhd0MyWjZpRlNEZkZra0tuY2YyS1Bl?=
 =?utf-8?B?QjJRZE4ycGRLL0ZKVlJGSkxaTmFIWXFXR3lTUkQveHJDaEQrUW5aVDJORzhi?=
 =?utf-8?B?c0J6YjNlMTNMUm45ancybTljZU11d3BueGltWUhwdnVlb1A2VFR2VjhDSUNX?=
 =?utf-8?B?dkZKRllXY1d4MTRUOHNCeDdGMDFNU0NEM1ZjME1FUEpFOVdYOWkvajA4M1ZJ?=
 =?utf-8?B?Vi82ZlRRbmZDeklVVXllNW5ETGY0TVlORXhQNzRnWS9EZGpNaWNhc0ZGVGRK?=
 =?utf-8?B?STQ0SldqY0FkbW1ra2ttbmlOZ0JnRk5vYkRlcEc4RlRpTTF6SnY5bG15TE8y?=
 =?utf-8?B?SkhLenV4UW5vOUIvWW94ZCt5KzNWbGRtcUt4R2VEbDBIYmN3ZXVaNHpSZ2lY?=
 =?utf-8?B?eXVLRnB3cHh0U3EveU8zenhsVmdMdVR4T3Rncmt0Q1NIMWMwNlphVXJWQUt3?=
 =?utf-8?B?bkdodmkyZEtpNTdMVjlOZldYdXRYdWtXVzEwd2lXSlJCaHJ4c2wvQ254RUdj?=
 =?utf-8?B?QjZST3YvYnRGa2JKdEs3blRqK0VPd0tSQjZYVHFIemlGQXRISmpnUWtFM2hG?=
 =?utf-8?B?U2M0ZzI3dzF5Y21aRUgxRUZQTXRBUnRLNXpyamh0aDhXOHNxUGtJRFVLY3pC?=
 =?utf-8?B?NVpVQmpqL2RBK0xnbnNkU3hZcFBSb2ZFWHpwbW85NjdKZXJFUHpCTkFFSXIr?=
 =?utf-8?B?VHo2SjF5VzZONi9GSExsUVJtNkJZMll1ZVU0cDNCYXhYNmhrd0hCNm1BWi9I?=
 =?utf-8?B?K1FZaXF0TUZoVlRNTE1aWXFEWHIxRUlXT2t1eDk4K2pTdHg0Uk40TDlDQkg0?=
 =?utf-8?Q?mLkH/faSkpY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6054.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW44dnJlZHJpeG05THo4TktwYWFYRlVQUDBmcnJ1VkVtQjMwRVlVbVZpa1FT?=
 =?utf-8?B?OEREVjdvUEJuTnA1Z2RjT2MwSWZjdHVoNXNpM1prd0NjdnlCVGNnZTMyWUFG?=
 =?utf-8?B?N0tEMGNQR2g5TitCVlVTUjlnRFNoRURFUTlPWmFGNU9qeXhRM2t6eDIwV2N4?=
 =?utf-8?B?MEpSb01PV3k0VjUyb0MzenM3NTNrOTN0cE15RUdZTmlERS9xNWpiOW1aQ0Iy?=
 =?utf-8?B?amZkQ0FWOEZJQWVYc3VwaXVHMHkya0dTWGRJeEJBNlJITFBJaE5nZk9iMEZY?=
 =?utf-8?B?VXQyelV0b3REY1FRR3JoM3hxVTZBaW9Zemd5UU12SDJ0UzI3YXl3WGNPT3hP?=
 =?utf-8?B?K0Z5aW1mYnFmR2NXay84bmR0OUkyUFcxd0tza2dDekpQYWljdXRWdFJxeEto?=
 =?utf-8?B?Tm0yM1hrdENpalpycXlVOEZOcnU3bUhJRTRvV1g4ZFBMaFEyRC9QMldpS2F6?=
 =?utf-8?B?d1N5dmQzSGtnZ29rVTZpT21LMEQ3Sk4wd0c3QkxLd1I4Q1NuMGVJN3g2Wm83?=
 =?utf-8?B?Ync4bFNzWW92MlJNTzlwdlphaUNrbFJGbGQzazB0R3FLelFyRTBpQzY0WWw5?=
 =?utf-8?B?dVpEcVViLzE5a3hpY3RHYjhiUHdrT3A2WVFtRE54OGpEeXZoZGlJdS8vSXA5?=
 =?utf-8?B?Uy9kWkFIcHZHcFJ0TUJZOGZvZUdlY3lqZ0VoYUlhcGRNN2J1S1FQdDdlcml0?=
 =?utf-8?B?aE53cjlIa0UzeVNaL1ZhQ3ZKSUMxT1ZJWUdESnhaRVBOZS9vOVNTcCtwMmtJ?=
 =?utf-8?B?SjB3bVFhVTdrZDZkTlNSY2J6Z3M0Q2dPYVFKbUVhczlvYTh4Ym1XUVNzTnNv?=
 =?utf-8?B?V3BwRWFxUFE2QkNBYVpWankwQ0c0QTJ5enhjSUpYTVltT3lJakhwVVFjS1gr?=
 =?utf-8?B?TTRwTE5Hb3J2ZDZzRUtqbUxBNGI5bWN5WitwUmhxem8zVk5ReGw2Vmo5VjIy?=
 =?utf-8?B?Nk1zNEFoSFVQcTNCNWExcXlLdjRnZVduQS9YWkN0bzBFdXBhQ3o3SkZuSEkw?=
 =?utf-8?B?MC9QZnlFUTNYZ0JMeEIvVjRuR0pnemZ2WHpyaVNZWnMwS3NXQjhPb2hIREZi?=
 =?utf-8?B?dHVBSmM5Q1EyT2t2MFk1VzZsSmh6YnFkangxanJWZDhXRVRPR3p1cVFoUmtk?=
 =?utf-8?B?WHVHOGY4Z1ZOV0FDc0NLdVJYbXlTdThPejd5b3VrUnhxYVVVcXFUTjdvMWIv?=
 =?utf-8?B?Lyt1Y2NXWGh3bTh0NXBRMFMwTlU1OEwrSmVTTHZMR3l3UmJCaVRSc3NlQ1F0?=
 =?utf-8?B?RFFPUTEzeHpPUEI3M3cvTWNDZ3pPdHBscTFNU3hISkZDQ0t4aFdPbnFqcUF4?=
 =?utf-8?B?akJ4cVJRSldmZ2RyYTEyR0wzMkhWVHpER0ZxQXdraCtLYldIZFJlWlFJQ0t3?=
 =?utf-8?B?eEhVMTdBRVdzUkFNUkp6ajZCems4U1BTK1VZNUVHMFFpRDNoYk82ZCsrWEZZ?=
 =?utf-8?B?cVlPMENtOVZoSjdqMHpTZlMxVXkxaG1LeE1UM0IyeVVwd251Yjh5eVhCTmZX?=
 =?utf-8?B?UUtKb1IxRVN5MFVXTmJrYmxGbG1rM0NCdXVHR3ZoZWJpOHVBak1POXhjMVZ2?=
 =?utf-8?B?Ym5DUDlpZWg4MlBhZjhNS2JjOUorQk5rbmMrcnVSMzc5YzZXaWNsUkNoRzhq?=
 =?utf-8?B?R1Z0OTFZZ1FueGozSHZtQ3pJM2ZRdTlBdmJ5K1ZHTGptYTd6MU5kUXF6QjE1?=
 =?utf-8?B?dXVvaXFrUzU2L0liTU1sR0xEL0pRT3IvN1Q5OUdqUEtiVG5TeStjNWxKa2R4?=
 =?utf-8?B?V05kM1dVY21IWjlqRG5GUkhPa2tPS1JVS0JXNHhaME5IT1J5UmpCdndZMG92?=
 =?utf-8?B?NXF4Y0ZIZnRDQUZXNzBTQWJuZFFNVEErVDEyZkF1cmNMbDFMc0MydnptSjAz?=
 =?utf-8?B?WmRsa1l3VzYvSVc3MnlOWnVxVGZiV3FkNHdsNlhxcVorU0ZsdGF3TWlQSUpJ?=
 =?utf-8?B?c3Vpanl1RDBLSjJ4YW0wVDRSNmUvNHVPa3NrbGluN0lUbCtBSlAwbkhUdWd3?=
 =?utf-8?B?VUIrZVpkU3JaTm1Hck5CK2o3N2pYamtHRmd3dml1QWpuZXJzeCt6dldmRlFv?=
 =?utf-8?B?enpiUVkrcGN3aEw1VThuVENNRnYyVjk1TDRhcGVXR2dwY2ZZeGxyUmFsQVc5?=
 =?utf-8?B?ZEdlUzVpbXMyNERmUHdmSHRack5HakMrdFdJMnp5ZlBETnNGSVJXT2N3YSti?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c58bc973-5d0b-4ba1-c9e8-08dd9de088c1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6054.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 12:09:45.1710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LlnjdTIjVQ5rCegjqH/+Ay5gW+Ktekakjy9Oc5yRtTYmAU7bpbeI4sy9gbywWsM9HuiOBslWuUIBaryPpiSADg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFE1E3F709D
X-OriginatorOrg: intel.com

On 23/05/2025 14:01, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> Adjust some error messages to debug mode and register dump to dynamic
> debug mode to avoid causing misunderstanding it is an error.
> 
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>

I think Ulf asked for the drivers/mmc/host/sdhci.h change to be
a separate patch.

In any case:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-uhs2.c | 20 ++++++++++----------
>  drivers/mmc/host/sdhci.h      | 16 ++++++++++++++++
>  2 files changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index c53b64d50c0d..0efeb9d0c376 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -99,8 +99,8 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
>  	/* hw clears the bit when it's done */
>  	if (read_poll_timeout_atomic(sdhci_readw, val, !(val & mask), 10,
>  				     UHS2_RESET_TIMEOUT_100MS, true, host, SDHCI_UHS2_SW_RESET)) {
> -		pr_warn("%s: %s: Reset 0x%x never completed. %s: clean reset bit.\n", __func__,
> -			mmc_hostname(host->mmc), (int)mask, mmc_hostname(host->mmc));
> +		pr_debug("%s: %s: Reset 0x%x never completed. %s: clean reset bit.\n", __func__,
> +			 mmc_hostname(host->mmc), (int)mask, mmc_hostname(host->mmc));
>  		sdhci_writeb(host, 0, SDHCI_UHS2_SW_RESET);
>  		return;
>  	}
> @@ -335,8 +335,8 @@ static int sdhci_uhs2_interface_detect(struct sdhci_host *host)
>  	if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_IF_DETECT),
>  			      100, UHS2_INTERFACE_DETECT_TIMEOUT_100MS, true,
>  			      host, SDHCI_PRESENT_STATE)) {
> -		pr_warn("%s: not detect UHS2 interface in 100ms.\n", mmc_hostname(host->mmc));
> -		sdhci_dumpregs(host);
> +		pr_debug("%s: not detect UHS2 interface in 100ms.\n", mmc_hostname(host->mmc));
> +		sdhci_dbg_dumpregs(host, "UHS2 interface detect timeout in 100ms");
>  		return -EIO;
>  	}
>  
> @@ -345,8 +345,8 @@ static int sdhci_uhs2_interface_detect(struct sdhci_host *host)
>  
>  	if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_LANE_SYNC),
>  			      100, UHS2_LANE_SYNC_TIMEOUT_150MS, true, host, SDHCI_PRESENT_STATE)) {
> -		pr_warn("%s: UHS2 Lane sync fail in 150ms.\n", mmc_hostname(host->mmc));
> -		sdhci_dumpregs(host);
> +		pr_debug("%s: UHS2 Lane sync fail in 150ms.\n", mmc_hostname(host->mmc));
> +		sdhci_dbg_dumpregs(host, "UHS2 Lane sync fail in 150ms");
>  		return -EIO;
>  	}
>  
> @@ -417,12 +417,12 @@ static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
>  		host->ops->uhs2_pre_detect_init(host);
>  
>  	if (sdhci_uhs2_interface_detect(host)) {
> -		pr_warn("%s: cannot detect UHS2 interface.\n", mmc_hostname(host->mmc));
> +		pr_debug("%s: cannot detect UHS2 interface.\n", mmc_hostname(host->mmc));
>  		return -EIO;
>  	}
>  
>  	if (sdhci_uhs2_init(host)) {
> -		pr_warn("%s: UHS2 init fail.\n", mmc_hostname(host->mmc));
> +		pr_debug("%s: UHS2 init fail.\n", mmc_hostname(host->mmc));
>  		return -EIO;
>  	}
>  
> @@ -504,8 +504,8 @@ static int sdhci_uhs2_check_dormant(struct sdhci_host *host)
>  	if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_IN_DORMANT_STATE),
>  			      100, UHS2_CHECK_DORMANT_TIMEOUT_100MS, true, host,
>  			      SDHCI_PRESENT_STATE)) {
> -		pr_warn("%s: UHS2 IN_DORMANT fail in 100ms.\n", mmc_hostname(host->mmc));
> -		sdhci_dumpregs(host);
> +		pr_debug("%s: UHS2 IN_DORMANT fail in 100ms.\n", mmc_hostname(host->mmc));
> +		sdhci_dbg_dumpregs(host, "UHS2 IN_DORMANT fail in 100ms");
>  		return -EIO;
>  	}
>  	return 0;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index f9d65dd0f2b2..70ada1857a4c 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -900,4 +900,20 @@ void sdhci_switch_external_dma(struct sdhci_host *host, bool en);
>  void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable);
>  void __sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
>  
> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
> +	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
> +#define SDHCI_DBG_ANYWAY 0
> +#elif defined(DEBUG)
> +#define SDHCI_DBG_ANYWAY 1
> +#else
> +#define SDHCI_DBG_ANYWAY 0
> +#endif
> +
> +#define sdhci_dbg_dumpregs(host, fmt)					\
> +do {									\
> +	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
> +	if (DYNAMIC_DEBUG_BRANCH(descriptor) ||	SDHCI_DBG_ANYWAY)	\
> +		sdhci_dumpregs(host);					\
> +} while (0)
> +
>  #endif /* __SDHCI_HW_H */

