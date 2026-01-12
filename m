Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4959A331A4B;
	Mon, 12 Jan 2026 07:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203575; cv=fail; b=l/hThBvy1JhtWYyNRSQNyVFEVYT/pBdxm+CzL3OkVyxQqd954qHYGrMh+9hEessHf/fwHtyC6IaIz09Iykj1VMu8g4lPO8ICbfUFeEYY7cQIX9lnxvtvxAvqpNaqqM6QS8pXUwDmAQaiUASwJm+Z+49rbyzmQPSNNnmbI/YP0Iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203575; c=relaxed/simple;
	bh=oUbbYKWmy8s9TeVwNJtzwPok3GRkDzfG2bu4FEtYK2A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VNLjdf9Kcics0/nUbZxdYhJ7LDFWYZZy4lH7RJsS8c8XA0UVx7UYlcjNoOsctDJ68o1wpMxEBrwBHH+PdxT3pXREHLkMud36jYR7mhWIeE6eS58IgTZZFAxLQ3x4dToZFRlRXLrI1VrU78IpHcGa2C7UIBve7umzMY3KWsMDZn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MoMOK6Ic; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MoMOK6Ic"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768203575; x=1799739575;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oUbbYKWmy8s9TeVwNJtzwPok3GRkDzfG2bu4FEtYK2A=;
  b=MoMOK6IcpOa5BKuvVPpZmAjf3vaVchWA5STGwWjpPH0ACuZeWFkwYNFh
   fEI0Yy+/Fkt9FZs+puTJLfZH/C/wWce/ezr4HyiDj+NbAkLdLMyAowDVI
   A5yYXxn1dSf5paP2OOKPAegwUwN7sFXUpIbPmXHIw8USuaF7vgtzI/9m+
   u1xebaUTXb6auIepSRzsy+UynfGpi9xGcOl3FWZCwLIRb5l+a5h0SVt+r
   h2zn7disD/yTQca8wwGd/etW7KZttwZoCDY/a6dvndVK1vhpmdULgTUl0
   XaP0qVVL3LRs9zfmYzdP7DDY7O2g05XOWWyclEYaq91/9s57VESD1WNgO
   g==;
X-CSE-ConnectionGUID: /rPR3vEoRrOSpGPxtX3tTA==
X-CSE-MsgGUID: SFvoPxuxRTO++aahDQcQ1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="73106157"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="73106157"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 23:39:34 -0800
X-CSE-ConnectionGUID: uIQT0xo9RA6zdNmVLyFBhg==
X-CSE-MsgGUID: gKi1qvUISEmhIuF/R7laWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="241555339"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 23:39:34 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 11 Jan 2026 23:39:33 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Sun, 11 Jan 2026 23:39:33 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.50) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 11 Jan 2026 23:39:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRcwlznzAjuNzvKABaIow1hpowtG3iUUQ2SOJxlZHrIjMWt1Ys+WdyjuNIIh7oBBeakJcTIY7PWmO1x4p/HBw+VRTDmpZYdIjI172kccmDEqqZBaAG25E1FC+sonXK/VVqRqOJ69cx5WTktkfZHrcrVjRn12+gF35QM+L7wh2T5WbBaEHmyDmdnWnQa4iDdb08s37kI0rfZJ3Cq8ETBGG5IsLPd+2JXloBiReYdfwvdLa6mT1fhh9G0JhCHiXOTq78phaq3AHssCJ42Ed/fRxj6V+lJm2rd3JnUc5rUGlWU0mRXSuZCl5W8GkN5N2PTb2OQS34Fpcn/fvhjxprCVuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkAmCP5yHueHjaek0Bi27vntNh9MnOBRJg5KcDuf/vw=;
 b=qKN0adkEGo4Tya6U+K3MsgE84ET9SBSQk2DTh7zvmtXLOi26AUKjlgFotzuxhxa1VYiQRERrN5QGQw4b6qt4Tt8+bsW4SnNyOZJ8f55GIJvOXciTPp4xAsXb+QUWudulryAa/XsqVOOPSFNlwyOEehFk0XgdWY7aAOTxDsP07iP2sUrLkMfBkasc+QAPxVDzY8gCB100JJAQq2GACFSKqNX3Fog00P7boOkGB08v9O1IN8h9N7q5YpTysMMIasJWddA95sGQm6yU1nYzTci27QmO1GeDgx3DtIc7LZ7q4cXqQkhCgqpkvxnh3fheCoIly65HeX3xWmy5JeUe0KtywA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SJ0PR11MB5008.namprd11.prod.outlook.com (2603:10b6:a03:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 07:39:31 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 07:39:30 +0000
Message-ID: <b6ddabc6-dd9c-4230-b19c-b2b1f5192635@intel.com>
Date: Mon, 12 Jan 2026 09:39:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: rtsx_pci_sdmmc aborts suspend when /sys/power/wakeup_count is
 enabled
To: Tabby Kitten <nyanpasu256@gmail.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, <ricky_wu@realtek.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <a242799a-d427-48e1-85ef-923f34df843a@gmail.com>
 <CAPDyKFq55Vqfd7cMdmQZBzvS1Xr-Z4QaTzEeuWWn3EX4HBbP3A@mail.gmail.com>
 <CAL57YxZagMaZF1X1bpx-nB76s=vZMWhUDiVbvB9P3CLiXG-qHQ@mail.gmail.com>
 <CAPDyKFpRi8u3MPauT1hnYC1pW7L4kAohAZDsgS2pgQ=4_sjgNA@mail.gmail.com>
 <f91584df-eee3-4c26-b1da-a8049a4d77bd@intel.com>
 <b488f3d6-68bc-49ac-8cb3-0f9f05f41020@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <b488f3d6-68bc-49ac-8cb3-0f9f05f41020@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZP191CA0014.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::18) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SJ0PR11MB5008:EE_
X-MS-Office365-Filtering-Correlation-Id: 53839ba5-f9b1-4361-70c1-08de51adb8c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0RRT1hBQTdxUGV1NmY1TVNoT1ZHaTAyK2R3TFRiVXBvNzVsTUkyeEZEZGZs?=
 =?utf-8?B?VTg1QjJIeExSekxxRkhITnQwRnp4OUVwYUhrWmtnSTJwT294WXhiZ2V5U1pt?=
 =?utf-8?B?VjZFeWQ1L3lvNEhJKzh1K3kzTHlyZnI0cmgxUHh0RXBSWDA4RWd1eHI4RVNu?=
 =?utf-8?B?U1k5aWRsUDJ0YjZ2eHJkZ0lEaEdUeDQwZ2F1bC9JcVVwWWpJMk9kczB5YWVW?=
 =?utf-8?B?VndZNjlGcUU3U2FoSmsvdk0vclZtaTVDelkzWkp1WmViY05SdFpxY3hWK250?=
 =?utf-8?B?Ulpmc1RRb1pDTW9kNEsydEMySXVSQ1ZGRkNnUXRBUzhobXNXcTVRb0NoTk5M?=
 =?utf-8?B?Q0dMK3NGelhhYjZmd0RVOXJRSHZmNnZaaTd5cmI4NU1MZjhyaEJoaGZFWlJo?=
 =?utf-8?B?S0t0Y2FBanpBVDl4ZXVDaHZrbFFUQzVaTUEybHRoM3RNcm40RmM4NVdLYXZ1?=
 =?utf-8?B?dUUySXNkREViVEloN2s4SFQ1MzZFUnpBMWNGcFdITVFETkJtenM3YXVDRDV4?=
 =?utf-8?B?NmwvamtLMXdOQ1g3aDRQeHIvRDBqREpMNy9IbHJxbTdDRFFuMkh3eElJN2FC?=
 =?utf-8?B?UHF3bmFsWWhJK2tWbjhZNWVXOGcvUExTSXhURjljOGZwby9HV1VTUUlpNHRH?=
 =?utf-8?B?cGg4N1N4SkhUQ3plcHN1Rys0SVpmL0JycXQ5Z2lMakVOT2NtWi9mMzlkWDRQ?=
 =?utf-8?B?ZkR4UXZuRVE4WnRxQlZQeERtNVhTQjFwOGQyc0NEWVRUOWhXbHJIdXdGVE5j?=
 =?utf-8?B?b3l3cTVVK3N1RFEyT3hFTjBDYU9BakNKZThPRUNjRFNtUVJlU2tMZWhKRGNq?=
 =?utf-8?B?MXRZTXpWYmtRY3d2WUx0MUxQNHNNUGc0ZDFjdG5lWkhlT2UyUUlQOTE3VDMv?=
 =?utf-8?B?dG1zbXBzcmxuZWhiT3daRkJLVnk2QjFPTlJDYmJSSXZPTmdjbm5wZlJkSnZ1?=
 =?utf-8?B?T1hlSS8xRTRObmhHald0cEpOTDVNKzZHWmhLZWVGOGdFUkFhRStMdGpDTUdj?=
 =?utf-8?B?bS8vaXliNy9MYmpPai9QZ0dhM3VFaEtXSmhJMzd5WUFiSlFUZnp3LzBNK2Zx?=
 =?utf-8?B?elhjZjBObTNWTzdzWk1UZGFBSk1CdC9qcGRUUHVSQ0dzUmorampkYWQ0WUw3?=
 =?utf-8?B?YkQxVEhPMFJyMXExcW5JNXp2TUVFN1g3ODFReEVvdjc0QkRnMUlWWlU5b0Nv?=
 =?utf-8?B?WHhjcHVhYThyWjBGalpzVmNnYURsZmJVKzdMSE5wSmY1YytJcWRvYlV6UDVK?=
 =?utf-8?B?OGJzNUx1SVRIT0pYbkxwQTE0RDZiY25JR2N0QXI0Uk5FMm9LejVJZldiTVMy?=
 =?utf-8?B?NGxWNGlxR0lxZFZYQTNLZFRET1V6UDRVY25YZWE1Szg5R253REg5dVVLbjF0?=
 =?utf-8?B?UUJvWlZQYlFvRlRGRDFiRGlBaUFXaStyTUNGVkwrdEwrc1ZKY2hjM09iWGRz?=
 =?utf-8?B?enI3Wjd0VW9oZi9HNnBTSndvL1p2YkE5aUdJeklFTG1hL0N0S0hUTE9EYVVu?=
 =?utf-8?B?Nlg4NDhtVTRGSFRkZ0NiMFA2Ykx6dTZGTlVBVDdabm1IN1VmdXRPVUI4L2Rt?=
 =?utf-8?B?NVpLdWpDOGtIbzN3UTlac01Qekwvb2hmSlNrcnJpRlJGUzgzdThTbE53NkJx?=
 =?utf-8?B?VUJ2M05BREVpYlJTOFF6M1hVb2xvVGZxL3ZXOHBjNEFnc3ZUMFh5Lzh2VGM3?=
 =?utf-8?B?N3VNOG1rTTFvN2kxS2pXckNEaTdmVGdib0s1UTVHQWw1N05HeEs1UzcxUDNl?=
 =?utf-8?B?dFhkbjVEWHp4QWdGcHpZVXlkZ2RTLytkSDZEMUdZZmlUY2RkUEJYWXlEc0tq?=
 =?utf-8?B?Y0FtSTdjdlZqME5MNGJTZktuVnFXUVVTWWs4UDAzVXZoVkxFeFE0SHVBODZO?=
 =?utf-8?B?NEo0c2VucWoreUozb2VPeHVCQ3pwNzhackMyamEzamNPcnhiSThCK0JCK0l3?=
 =?utf-8?B?ZjlYc2NkNWJZNGl2bFhXeExTMzNTSmd0VjVMUEpncnBDektpZzg4OHlDc1Qx?=
 =?utf-8?B?ZmhMY1hhNk9nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dExhN08raDhSZDlzMVM5RC9BZFMxUnRxTlQxZFpOOWF1eDFCaEVycTZrYjgz?=
 =?utf-8?B?alRTbktCUWtTVC9YVitIQ3pnbjVOMUpFamFVaFlTUWdsSjhnZlkrOXluck5L?=
 =?utf-8?B?cG1NY24zMW10M1hGZHFVQUtEUWNFdGo0dlJXcGk2a1NJM2ZJaExxUkVrMjdx?=
 =?utf-8?B?MGZCODB2ZWFCWGtKWWdlUnJydi9pMnllTloxZDk2TEg5a3Y3S2tNRmZkVUZT?=
 =?utf-8?B?RFdqRU1WR0hmLzhjbGoyTmxGMll2alk3QkJhMk1nbGdDT3ZiaWV3YTYxaUVM?=
 =?utf-8?B?U2huSnJ4R0hzY2JPVzNiUk9GM0R5elVLaXJvSzBUR2Izak12Z2FyY2Q5WEND?=
 =?utf-8?B?akphQ0NQeXdQQ2xhN3gra0ZUVmJOS2RidzE1TTc2WWZ6TTFKUmVidjEvZHFH?=
 =?utf-8?B?Rmc4d1g2MEhUODBGOHNlODlzL1I1YWlRRkJKeUlQTUVCdkZKVER4U2RLTXpK?=
 =?utf-8?B?ZWpQRFY5cDhZK0tCTS8raFcxenFJVmdsSkU1U0JET280WDRocStoay9BQUM3?=
 =?utf-8?B?RWc2UHdRWkJMUTQ3ZzJSb1U5TmdUY2xROGhWYi9iRkxTVmUxeCtyaVlGdTNE?=
 =?utf-8?B?UFp0d3lobVhEWWdlZWp6c0NJWEZxSWttelVESXhLSWhtOVBMVFNETDNzZjk4?=
 =?utf-8?B?elFEeGZxMmZrd3ltd2d2MFhpV1Zxeno3TzIzRTd3eG40RVJuK2pKUzZmdXNj?=
 =?utf-8?B?ejRRV3gxcERHSUZyUDY3ZW8xZTdQUWdNdE9LUXpPYjlidjh6Yi9hNHI0R2Rl?=
 =?utf-8?B?cWZKa1FreVZjUkhRS0FYWlBpRkNqNDJCT3JQdUJsbkNwaXYzcWt6eWgwdmJH?=
 =?utf-8?B?RDhqdldMbXkvcUxqZGJHai9HZFNSQXJHS3lNUUtkdkozNk9TNEJndmNWcmFK?=
 =?utf-8?B?T2lwVUh0YWsrclQ2eVBEOEhVMi8yRWoxZm5oMytlakFETkxkTFBCYzJnMFZP?=
 =?utf-8?B?N3crN0I5U09OZmYyNFpaWm4rUzd1bitSTWw1eHlzYXl4d3JvOXN0M29YMGUw?=
 =?utf-8?B?QWl2U0JkUGZPVGhnZkNuckVsM2xBTnB6QUFvQWhHQWp4MlBPZ2ZPd2NsdWpq?=
 =?utf-8?B?cTR1U2lMMHhFMGRPRGVKMGxBUXB0VWZMUm5FbjJ4N1BzdnFpSWRJUDVRR0c3?=
 =?utf-8?B?VWR5bG4vQU5GaUpGNjIvTUYzTHFub0hHbHJpV2VRMHkzTDUxZTVLS0ZNZXFm?=
 =?utf-8?B?dTE2WnlBVVB0VTFrUFpiNEJhNDRxRzR5OWtsb3l2Y2JQN21RVngzODlDWkoz?=
 =?utf-8?B?dDNnMDZIOG54Umg1T2tLRzdOZmdvUmkya3NlM3dnNWROWVhlbm1ndldIRisr?=
 =?utf-8?B?VFkxc09HblBuMGdHYVJsTGEzZ2FKZGJXY1laTSs1MEl2eEZ6RmNPUHBzVHYr?=
 =?utf-8?B?Sm56R0IxSmkvQTNjN0c4YXBESEQ2aFBueDFqNUJTQVQ0anlOWEhhL1B3SW5x?=
 =?utf-8?B?SnFMd1RwUjJ2MEpGMkxNV2NVRVoxMzlCY1BUYkc0YTZlM3VTNGkvdGkrbWZY?=
 =?utf-8?B?WXo3UjEwUE1ubGp0WE9JMWdTNmY1c0hNUkEyK2ZrMjk2S3Bqc1lVcDI0SWUr?=
 =?utf-8?B?Z3RVaFp1dzVjNnVKd2oxa0Ziamp0aWVja2g0WkhuekxRWTQrYkVwaHhtUEs3?=
 =?utf-8?B?eGppNk4rRGhKY082RUt3MG1TZ0ppbk05blJLWlN6d1MvWDZMZklzNkU5bDhm?=
 =?utf-8?B?WG53MHlSR2t2Rmdvb0thMkJKU1cxblVMd2ZxbzcybTVaTlBvSkNURHlzNlVh?=
 =?utf-8?B?R1lRTDNOdVRZdDVFdWlvbmxady9LRHNGeGU5MzlENm5KWUZpbEpxcG1YU2JL?=
 =?utf-8?B?Q0l2WlJZZ2M1S21pbkZETFh0UXZldGZpU3J2YThDd2YyalhDWGQydERrRVNF?=
 =?utf-8?B?RnhUb1pBdEh4NCtQWnI5bWlhbDYvWTl6c3U2Qjd5WU93K0RNekowMUpYUzA2?=
 =?utf-8?B?VXU5ZWs4MUU2M3c2NEx6Z1NKUEF1MHFTbklSYzJsbTBOd0hxYUNpdGhvMzFt?=
 =?utf-8?B?ZFhIdkxEVUZTR1Q3dWVMa3VDL3dMUjdkMkNvc1ZHWm1FWnUzdWVuTStldFhL?=
 =?utf-8?B?ZGh0SjZTMlFGdXVyRWI4RU1HUjUvOG5iRnpxUnNiL1UyKzM2V2JpT2JvLzZG?=
 =?utf-8?B?T2ZRZVRzVnZOOFlVdjd1UVRpRUNZQ0Vma1F4THZJTTR3TDBaMnJhUlYrWnhm?=
 =?utf-8?B?eVdVdUdaVnFYNGsyUzdGYmJXbEduMG5yQXNpU09WbzNzZ2g0OVRvcjVpMnZC?=
 =?utf-8?B?TFRURjA0T0ZLaFE2MjY4SVVrZnJCZXNrOXBROVhDQ0xtZ0Rjb3NhVDhLckxJ?=
 =?utf-8?B?N2dNbjA2VUVFMnZVNDNZbzMxaUYxUzU2TVZwMlluUGxCcTd3UStJZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53839ba5-f9b1-4361-70c1-08de51adb8c6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 07:39:30.8850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9TlSjHAdKC56oV0tUWq4TdGNCByvt9REjppgTQcn4VZSymwZSQFzfuPmEI61DtoQNxaKFXLhXNut7RdVjPrsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5008
X-OriginatorOrg: intel.com

On 09/01/2026 04:46, Tabby Kitten wrote:
> On 1/5/26 4:31 AM, Adrian Hunter wrote:
>> Seems reasonable, but isn't there also:
>> 	bus_ops->suspend() == mmc_sd_suspend()
>> 		_mmc_sd_suspend()
>> 			mmc_claim_host(host)
>>
>> In general, it looks difficult to avoid runtime resume on
>> the suspend path.  PCI will usually runtime resume anyway
>> i.e. from pci_pm_suspend():
>>
>> 	/*
>> 	 * PCI devices suspended at run time may need to be resumed at this
>> 	 * point, because in general it may be necessary to reconfigure them for
>> 	 * system suspend.  Namely, if the device is expected to wake up the
>> 	 * system from the sleep state, it may have to be reconfigured for this
>> 	 * purpose, or if the device is not expected to wake up the system from
>> 	 * the sleep state, it should be prevented from signaling wakeup events
>> 	 * going forward.
>> 	 *
>> 	 * Also if the driver of the device does not indicate that its system
>> 	 * suspend callbacks can cope with runtime-suspended devices, it is
>> 	 * better to resume the device from runtime suspend here.
>> 	 */
>> 	if (!dev_pm_smart_suspend(dev) || pci_dev_need_resume(pci_dev)) {
>> 		pm_runtime_resume(dev);
>>
>> So maybe alter rtsx_pci_runtime_resume() to avoid calling
>> pcr->slots[RTSX_SD_CARD].card_event() == rtsx_pci_sdmmc_card_event()
>> when suspending.  Perhaps along the lines of the hack below:
>>
>> static int rtsx_pci_runtime_resume(struct device *device)
>> {
>> 	struct pci_dev *pcidev = to_pci_dev(device);
>> 	struct pcr_handle *handle = pci_get_drvdata(pcidev);
>> 	struct rtsx_pcr *pcr = handle->pcr;
>>
>> 	dev_dbg(device, "--> %s\n", __func__);
>>
>> 	mutex_lock(&pcr->pcr_mutex);
>>
>> 	rtsx_pci_write_register(pcr, HOST_SLEEP_STATE, 0x03, 0x00);
>>
>> 	rtsx_pci_init_hw(pcr);
>>
>> 	if (pcr->slots[RTSX_SD_CARD].p_dev != NULL) {
>> +#if IS_ENABLED(CONFIG_SUSPEND)
>> +		if (pm_suspend_target_state == PM_SUSPEND_ON)
>> +#endif
>> 		pcr->slots[RTSX_SD_CARD].card_event(
>> 			pcr->slots[RTSX_SD_CARD].p_dev);
>> 	}
>>
>> 	mutex_unlock(&pcr->pcr_mutex);
>> 	return 0;
>> }
>>
>>> WIP
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>>  drivers/mmc/core/core.c     | 18 ++++++++++++------
>>>  drivers/mmc/core/core.h     | 11 ++++++++---
>>>  drivers/mmc/core/queue.c    |  4 ++--
>>>  drivers/mmc/core/sdio_irq.c |  2 +-
>>>  4 files changed, 23 insertions(+), 12 deletions(-)
>>>
>>> ...
> 
> Me earlier:
> 
>> I'm attemping to manually replicate the changes on Fedora 43's
>> kernel-6.18.3 checkout
>> (https://docs.fedoraproject.org/en-US/quick-docs/kernel-build-custom/),
>> though I'm much less experienced building kernels here than on Arch
>> Linux (the Arch SSD is currently in another computer). I will be
>> replying back with results once I can build and test these patches.
> 
> I've built a test kernel based on Fedora's 6.18.3 along with these two
> patches. Now `sudo badsleep.sh` successfully completes on the machine
> with the Realtek card reader.
> 
>   * Adrian's code would not compile until I edited
>     drivers/misc/cardreader/rtsx_pcr.c and added #include <linux/suspend.h>.
>   * It looks a bit janky that the inner line of code is tied to a
>     different natural indentation level based on a compile-time flag.
>     With suspend enabled, the function call is on the same indentation
>     level as the if statement!
>       o One possibility is to indent the inner code one more level
>         (which is an extraneous indentation if the #if is inactive)
>       o Another is to move the added condition into the surrounding `if
>         (pcr->slots[RTSX_SD_CARD].p_dev != NULL)`, but this prevents us
>         from adding code that /doesn't/ check pm_suspend_target_state.

Currently (since v6.5) pm_suspend_target_state gets defined even
if !CONFIG_SUSPEND so, allowing up to 100 cols, it can be

-       if (pcr->slots[RTSX_SD_CARD].p_dev != NULL) {
-               pcr->slots[RTSX_SD_CARD].card_event(
-                               pcr->slots[RTSX_SD_CARD].p_dev);
-       }
+       if (pcr->slots[RTSX_SD_CARD].p_dev != NULL && pm_suspend_target_state == PM_SUSPEND_ON)
+               pcr->slots[RTSX_SD_CARD].card_event(pcr->slots[RTSX_SD_CARD].p_dev);

Could use a comment as well, noting that card_event() can call
mmc_detect_change() which prevents system sleep, so it must be
avoided if the system is suspending.

Note, this change should be sufficient to fix the issue by itself.

> 
> I ran into a possible bug:
> 
>   * On my first boot attempt, I tried running badsleep.sh, waking the
>     system, and inserted a microSD card. The card was not recognized in
>     Dolphin or listed in lsblk. rtsx_pci_sdmmc was present in lsmod, and
>     I saw no references to rtsx or mmc in the journal.
>   * I could not reproduce this error on subsequent boots. I rebooted the
>     computer, then tried badsleep.sh (with or without regular KDE sleep
>     beforehand), then inserted the microSD card. At this point it was
>     recognized properly. I also tried inserting the card /while/ the
>     system was asleep, which worked too. I'm not sure why it failed the
>     first time... dirty contacts? random bug?

Well, you need not only to reproduce it, but show that it doesn't
also happen with the old code, otherwise there is not enough information
to work with.

