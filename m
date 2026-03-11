Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D18F2DB795;
	Wed, 11 Mar 2026 09:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773219943; cv=fail; b=S6pE+2G3h6QcORXcfv/W2AdXA0qo91DqeE4fqBg4M8uUsmTaHOX0VJUB3EMouIpBlPYnycSg40eYJLBs0cIh6xH9djzbR+KWBgJw0d533TQdOFvhNhztsDPk+KmbcsNAHyXzmAwEsrL+HDIJpwMUZkSdi4+Bym03rzhAIRkahOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773219943; c=relaxed/simple;
	bh=3wVvEEo3bdNrQRLKjvXbvO0VM0zmzf+mcxwlsjtG1TY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qyIplflqaIfUKQDhskBcmXMoydIF7aQY3AI0f7tbzFApOAC3NyOvQscvFFEtzSN8IzXE8kt/zWykltGUjUsatfbmOZEoMzSwab1NQSpaCVJtvnXIkwPoFUH4/tSl4GT5AWZufm/1deV8IhurY1A+jRDh/2G7zwZ5tJMoLhyrgoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DtqdZRIC; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DtqdZRIC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773219936; x=1804755936;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3wVvEEo3bdNrQRLKjvXbvO0VM0zmzf+mcxwlsjtG1TY=;
  b=DtqdZRICNOgC7bxdki/sYENC+rnU7VKmYV+BAkIvavAF+pr2y//eX+7L
   EVdPYNIUkBOwLSXl+kXrZRvsif4J17rvot2ZuWu+n3YV5e7239IItZ5zp
   rm70sz+aW9TBBxmXsZT1aXeA7Ism5/kXbF8kYWiTkbLPUURw3EVJHhGFV
   ZsSVP3y0JDasPz7LTwrdNcsbXBv743xoHiPaATM8tX/DWf/HH/wR3sFJg
   GiLM6UfhelTtxp2FW1WtPS9ww6JfPEBvyWJiBagZhvsx5fOz7cRzj56RP
   fS9fts4KJ3oiERHduV2gvpXkhbFaP58oAHRmOx7hG9hXCR9Zc1PyhoCGu
   Q==;
X-CSE-ConnectionGUID: XpI4yvY7ShSHXt1AUlBHGQ==
X-CSE-MsgGUID: Zxod9nAGQbuHzTT7e5nNAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="76891388"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="76891388"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:05:35 -0700
X-CSE-ConnectionGUID: 4nXsoBWjTQeDX16MmOm58A==
X-CSE-MsgGUID: f+Gtcv4rRaqIDlifSr4LkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="220580445"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:05:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:05:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:05:32 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.63) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:05:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLJYPKr2vp2HvWdMXWLZvsGfLCWaO20HhO0cWN4m6CDqLKdu/ZV/JuWEA9hHrlKQjR3HIUABX5flc0kikvYVOM5szALDTRjCyR3KhhsTghQZlHX9G4Z3qLnkf2UMeFrbndznVwBSwFV40wzmP0Jc7CMo38wGEIhp72y+sSnUfnzv4RVFlF+MIyG6ZY8Mzxv5CdHfB29xLjZXgUbBhGF3seotVydAlPbl3hdkgcZzycRleTZOZJin/9Bnkx9MFQ8f1xPGsey/2KdD0ioAnPwMSOUWZtDm8FjjmjAKuZ5CGT+nFqDABdavtINmvaQi2SapN6AidhdWfPiS3NFlsc3V8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIAe3mog4UksKB+/KLOz52TIE5p8L5etpLfC5vm6K00=;
 b=dDfzRG1vAwCdb7u2dhkI6vNAeEvYjRXdCEVH2wzm7VNcC/nA7ggHMkCh0e9NoTmargw+JZdA2k+vu6Roi1ldbTeD7ecgri2+3rrPDuFpfVdffkyLkLXBQBhpX0Lzel7tOOY8CD4sDTgZGFaGgBQ4sb5DIfdQ2+xOG5ySX5onk/h/8fdnT6jyKsARBxuvhTo1SmEBDUe7JVSgE/KDbljiBd58yOuEeY0QzWGtrQ7s7z/XBfKGkOLmaPO7bxLrX8Xf6onMX2tcExbnIbDF9XJQRR5lVYjQBJVl5JmzfBQ4mSrvaepGWqSxbFytMBvsiZXquR/DC6J7TtX/b/NPBAxzRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH0PR11MB5189.namprd11.prod.outlook.com (2603:10b6:510:3d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.8; Wed, 11 Mar
 2026 09:05:30 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:05:30 +0000
Message-ID: <181b3536-04d2-49d7-90bb-2ffc55d5ed18@intel.com>
Date: Wed, 11 Mar 2026 11:05:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mmc: sdhci-esdhc-imx: add 1-bit bus width support
To: <ziniu.wang_1@nxp.com>, <ulf.hansson@linaro.org>, <haibo.chen@nxp.com>
CC: <Frank.Li@nxp.com>, <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
	<festevam@gmail.com>, <imx@lists.linux.dev>, <linux-mmc@vger.kernel.org>,
	<s32@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20260303105006.989339-1-ziniu.wang_1@nxp.com>
 <20260303105006.989339-3-ziniu.wang_1@nxp.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260303105006.989339-3-ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR04CA0023.eurprd04.prod.outlook.com
 (2603:10a6:10:110::33) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH0PR11MB5189:EE_
X-MS-Office365-Filtering-Correlation-Id: f2203fe1-b518-4b96-555d-08de7f4d5842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KSp7pFnlHH64SAgolXJbpKMqmjxAj9odO1sqjspbIUDQILF4J0MvDsFQnaiZxg46588FagfEsUYasjnuWil4XboSm1yYJdhOepqzCfJ889siPHLzPkOxzKvde0+SjIEkKgvUIaN795b0rXNdHQMwRZDbk0SL65GagRoPs3Lae2QkYFFbccXt8pwYl76rn93KNwr9DVuPJH3l1FbfCxMkfxTBCv+Ic2qzMcwe++8FB2F0umwGh+sK1K2IXlJMgnogE8zFwt4gDi9C94CjBdRrJHC/XbbXxulFlDCrMaCu7dazHHtgv8d8b6sveIR8Y18cZrebVmZmuWwJmiir+5nt3hTiqbbUYGh8xBEPDtrC6tITQdKUfk1Xu8apNPXp5yTvFlBE0vouOYwt2RYIt+jDJSoSf4T8ykW3u8J4q6QJHhsWaVEVAfAQkrhTJ66qEFxEH94zSV+05nJbFWkpxBP/QzZG3fl3tQgbGogJlsR16OPdphGB8M+f1ONhgQLSrRtjgJq9cWfjteSFPeFxmzz2HNPc5NxeTNV3ZauT4fWKMH9KiacBcAkx/su81qP0Rf/ura+ZCMSCSckot3Kow8cswX2BfZPLVd4y35IeE8ny5TS11+bewiXBs53k4Wldi5FF9az3ifXwlhobzUbUZEmLaVgnsO6n8wWTkJZt2+YAu0UdgC70/yQOi4NLQgd5NkgOlra7TOmc+UVsV4pVgxs2LNOJjXEGSuIi0CN5weU+HEY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE9ta0pnSDhPTitRK0M2WFpNUXdKZDBIRndxMVd4eU1tL1dzbXNBVHExak9L?=
 =?utf-8?B?WDNtVTJTK1NMNEgvbmhxMnNOM1U1bnBvQTc0c1RrUXRzcEY1OG9jbEVsQnFN?=
 =?utf-8?B?elhjZGx4RHd4YVRhMDlsdXA2SWtUa2ZyeFZEb056WGpjR2FPTDgwN2VyQWVa?=
 =?utf-8?B?cUhiTm02V1hEWHlScEwzWHAzek9vQ0E3VHBtMncyRVhLNFN1N3BoM3I5dHBa?=
 =?utf-8?B?ZUhwR0pjWURUNlhsNGF1Z3FhTGxPL096MzY0RTNlaFJQL0JtbWc5bTlwcUlV?=
 =?utf-8?B?MEV6T0lhbFdyR1lESk5hWG14a0lpUWJoRWlzNWh5Ujg1UlhUZnNMazQzWVhZ?=
 =?utf-8?B?TFcwS1Q0dm1ucVBON2NxRGtIem1iZkN1b2Zyem9aQnRBZFZ4T0gxQlVBTlcz?=
 =?utf-8?B?L2VDMUJjWU9sOEp6bUZJV3EveXZOalFxMWlkcDZOZG1jM1VFSG1PSWowdkQz?=
 =?utf-8?B?QkhqTWVIY1loTlBvaDgxRW1HVXNhd1BEVFJFOHVsZjY3RVVVMTFvYTZlSmEv?=
 =?utf-8?B?LzZreWVZODR5bDRFSmZGZU5rYkJ6cndIRnhKR0lIMmpTcnR4OTBjZ0UvNXRk?=
 =?utf-8?B?OGZ1NFRmT3lBT3ZhYUlacmh4amZSck8vL21wOGRWM0VxSzJDOTJ0ck50RGRx?=
 =?utf-8?B?bGFqYWlYenVxb25qd3BPbllsWnhjRGJDN1dEdFFWanJaZForbVRmcGs5cVp3?=
 =?utf-8?B?TEtrU1VNUzZWMXJoazhDUnpsL3M5TEQwTmtUenc3alQzOTdVSlNPTER1VVdo?=
 =?utf-8?B?UXNMaEdIRVJyY1NqVmd0VE9TTklDOVNwRFVvdlJLVjdURGdKYjlKN0J4amk4?=
 =?utf-8?B?b2FxV1dwMUNybmZWOHZtUEphd2JHUnRhNjQyNWN3Q3d5MXJQQkFRUm9na0I0?=
 =?utf-8?B?Y3FmMUI0VTl4RktIKzBYVXYrQWVkdGNmbkFpWkNGckl3Y29HcDRXbUhGMHZJ?=
 =?utf-8?B?RXRUSXJYZmg2QmtpckJVb2o4YWRMeER4N3BHbkFaakxxcmUxL0lISHpwSU40?=
 =?utf-8?B?R3RKVFRvcEdTV1dFNW5zOCtvWUswdCtRMGswQjFMeDBrYWRMSWdJRXd0aVp1?=
 =?utf-8?B?dW82QTdyOEZKOWREVVdNMDlsQXdZeE1IT1BTOG4vdHFsWEJwaXd6WGNOVzhr?=
 =?utf-8?B?K01DYlRLVUFoSTRUNVJ6MVcrWWtMTXN6aHN5c0JSUkc5cXJleU1NS2J6Sm9h?=
 =?utf-8?B?SXFnNGIzQU8vL0tMVi9jM1V5VllwL0FqQ2pzeUNZRVNxWXlPUXJBRGpyOENw?=
 =?utf-8?B?NThJMmVmNEw2WGVEOWxKcTl5OWVvSGhONTZ6UTY5OEROY2w3TFpSdEhrQmdi?=
 =?utf-8?B?VmI2L0pzeHRLM0twVllkMG1NcGFEcS9WaVNiRVltZ0Q5aWxKazBSR2t4SlRM?=
 =?utf-8?B?UXpuQit5OHB3VmExR1ZhOGdQelQxS3V6WVhHcGVRSWp5MU4vZHh6RE9zdVZV?=
 =?utf-8?B?V2g3Q2VLRDErUGJxeWVhU0MwMHlLbW5WSmh6WFNwV2VibWlFVmYxdHp4Y2ww?=
 =?utf-8?B?U0IydTQvWDFpU1dNK0RwU1pEakhuUzJhS3VxckFzaHNtd2dvZ1hrZWNDRVhW?=
 =?utf-8?B?NnF5OGxnVkpSaVFURHlRQ05SVFZlalFYS0hJSDdxZXJTVWNVOVVHQkkwNTdm?=
 =?utf-8?B?c3VBUjcwUW0rUVdHdXJhbExwaEFUQkl5MXdQbm9uYitISGF2eUJwVDR6RXo1?=
 =?utf-8?B?ZFNsZWFQWUFmbFd5dC9pdFZEY1VMU0JCZVlOL2JWQnUxRVgxWUhuVGtnMnFI?=
 =?utf-8?B?TUZEYzlEMCt1akxMMGhIYXhMdktuNG04WW4ySDBlOEZBV2Q3aG5RZEtoRGVn?=
 =?utf-8?B?M1dOd3ZsN0hzSnNwQ3MzbVhnK2d0RVdtNTg5V0xMdG1jTGxlUG13c3VJMjIz?=
 =?utf-8?B?bkU3b3MvaG9TWk9Bdm9jT21oeHNZTWJaK3F4amY1SURjWjc0dDh0NFNYbUV3?=
 =?utf-8?B?MDI2Y083VmQvZFppRk5WdWwydWRqQzB1ci80ZXQyakx1RmNDbmJuSDlEVXha?=
 =?utf-8?B?ZjUwUjYyeFNYUllOc0VhK1Q1U2N3SE1wdllMaFVYREd6aExJSnBVM0JOd0U5?=
 =?utf-8?B?aHAzNGdRb0JDTHM1QXNLdXk4bEM1VmQwbHNwaDdRMmJqV0JXczRndGJFK280?=
 =?utf-8?B?cUUwN29aVzUzWmtaQnQyZy93TUU4THdDQmcrcEw2UlB6dGZTSUpSQjMyNVk4?=
 =?utf-8?B?R0hGV3FwbjM1UTJYelEydTdJUUU4TFhCRDZFdWxWR1EvZXhFQkRBUkk2bWdr?=
 =?utf-8?B?eklsMjkxeU5jR3daM05TdW9IZlpnSW93SFpMVnFuUEovTGRrbWM5WWFKTkJK?=
 =?utf-8?B?bGNReWJjQkRyR29URENkMWVWcEVCcmU3dlpZbXBYK1dSWjkxK0FRTUhxOWVn?=
 =?utf-8?Q?+jFO+qfDuZcY5uz0=3D?=
X-Exchange-RoutingPolicyChecked: HSjQJcgZkhHR8I2cIhW3ETbUwqZ/ZMUH1WPHAcTh3VibMZaX4NoFKsba+xoeWXhZu4sgl5ETaskF/DH104vorIQVqAvYhH1PUeQloIZ+sydwODXRM9RHkp4sjh3oV7AIOno0xQC/bgom//Wyc+Akh5j855ulTXsf0cOSeso5WSMiWltceqbX5q2GO7iMgIDtoeWSLAJPCs9sBlfhcvt9oUP8pIdK2Y2fdnViSMFmeSO1gJw0RGC8a5OTR0HIGjnz5h7+7fcOuLir7vyCsbPrUg4RtfuBn6g1bRW4RFyR4z7ssjhUor/AtUDJq2eoQsz2V81TEYh8+p1Ijhe+RI4CHQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f2203fe1-b518-4b96-555d-08de7f4d5842
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 09:05:30.5462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0YcFhn/3UxaEur9CtZUSsRYzixhtLI4sjcG341cyTtrEvN0Dq4EWwgnbYdLMoUnGzhhEKEkxetCcjCoVMghk0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5189
X-OriginatorOrg: intel.com

On 03/03/2026 12:50, ziniu.wang_1@nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
> 
> Add sdhci_get_property() call to parse common SDHCI DT properties,
> including "bus-width = <1>" which sets SDHCI_QUIRK_FORCE_1_BIT_DATA
> quirk for 1-bit data bus width configuration.
> 
> Remove the duplicate "no-1-8-v" property parsing since
> sdhci_get_property() already handles it.
> 
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 97461e20425d..b607d4ffc562 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1813,8 +1813,6 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>  
>  	of_property_read_u32(np, "fsl,strobe-dll-delay-target",
>  				&boarddata->strobe_dll_delay_target);
> -	if (of_property_read_bool(np, "no-1-8-v"))
> -		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>  
>  	if (of_property_read_u32(np, "fsl,delay-line", &boarddata->delay_line))
>  		boarddata->delay_line = 0;
> @@ -1833,6 +1831,8 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>  	if (ret)
>  		return ret;
>  
> +	sdhci_get_property(pdev);
> +
>  	/* HS400/HS400ES require 8 bit bus */
>  	if (!(host->mmc->caps & MMC_CAP_8_BIT_DATA))
>  		host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);

