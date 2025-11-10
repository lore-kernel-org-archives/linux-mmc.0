Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87A12F12D4;
	Mon, 10 Nov 2025 07:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762761519; cv=fail; b=p2FC/iZoUd5Eai1Tk7rUvzcNNcM7HkMPe1NoQYUQG7agvAeC1A3uMTnZuJ0TI3mK75n774UB7fwSbF6ADbQSb7kYtpcNdzJN+KvyOE4wDgOTgNroz2SPAOWOcTu+2AsZXWpey4KOR1Yl7QgelzVUdnjTbEWDNcJp0BzZZk548Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762761519; c=relaxed/simple;
	bh=6X31F61gYwMuUmvUGOKjX88KKytuiKHKar17cjekyk4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JTeOX1tYJ0A0NaT+7njKLTw7Ax12xxYLDX4Z7v/yKr8HndKrC4gXGDBj+q/f8GK2o7PB13jq+2LuUj7GbdhCA5DjWJZSfbkXn1WAErtCdQmhBKeCyBCPYjxxLOAY0RroTost5q9dHr+aLsfF9M3j3p5mH8vYWXTmGZGJ67De/Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KzKkQMaH; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KzKkQMaH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762761517; x=1794297517;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6X31F61gYwMuUmvUGOKjX88KKytuiKHKar17cjekyk4=;
  b=KzKkQMaHxOhEtMSTYUPgYKtr/JFLDIT9QX7CMlI6s9q0OlLq7cBrUXJd
   acUF8hd6M0Puy0cVxyURDZV6017jBK5OOyZQSaXMeKPHTIiRyvovX1/3U
   tG49BX3J3qm9KBc9h75lq9S8ZrIb6YrkdQhNkbRwzAP4uvI9/loklKfGy
   f2qAOEBdIUfO/XTVI1nuijDg5KwLJPpHXKq7jipL18yhTExQyK9f+curo
   XNWv/p9m53AuSa8Kiu50O03zUdvJvQqXBE6SuBJd12OlGZMkEOAvFi0tJ
   I1kM5VUeHcTVZmaC9LLKI6BPC45OBKCVQYWn2WOIKHzRgxgH5Rho+tYGE
   Q==;
X-CSE-ConnectionGUID: vEX46kjmTaCVeK1iZtj/gA==
X-CSE-MsgGUID: uPT020odRoeC66GdG4X9fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64735343"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64735343"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 23:58:36 -0800
X-CSE-ConnectionGUID: iunm/PObShmn0Aw8bxJK+Q==
X-CSE-MsgGUID: NmCdyfM+QWSRAMAKdULC0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="188446232"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 23:58:36 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 9 Nov 2025 23:58:35 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 9 Nov 2025 23:58:35 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.30) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 9 Nov 2025 23:58:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfMuRupgqFnmsLq2DGcScec5leMzKTL0Cugv29CZjmuHD+jl+o0kZT6YhfkpwCqoknqzytZXqHePPjAt4j3avBTPC4+mvLRq655/NNnrWfYb9jpIbJ14gx/tx5RHDsbiCOP4ZtEsKwD+RCp1T4VGnKrGJY4VrEgHwRF3SlN1idTfRq/DIAgxIN7b4rl2vYKKtfXmVA3jOqdp8qpep5CHl0XlUK8U9GBgEpHHC17UIX1Gdlo5wJNZ3kbhtSV744RU0Cmfwgm3Qh5KmdxGTnOTyjaCDe9wjdztH8clU4COKYrQQOl9waA14gCEuBegS572iFvVWB5J1ATxywUwKHuV5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8WmskQsmnByjJr7rBEGkSTDN2MlD6olssyobd/BntE=;
 b=vv5Zq5u1KieN37ujN6d7F3u7u/rujiVBPqWXD4x3KZY0f7REV52Nr+esiDofnHM/C8d6Ja0Epieg0hKbZEyQKI7f+rprdRnVeIjphigAewWawvUWkknJs4MoSUupxZt4xSLsdle6XBeMAvRBP9LnWEgBwgz9p2bvXuwQfKRAa3h5YnwycYLzlx0PjXGBeJdY8z46br1WCIe7L59+4FL9XFkVczHPcKxZeFzsmRhEklfNpL3vNg+NUJUklyCumP92vlDTUINc3O3XUp37EPt9YDer+vYi7GP9eJRvD5TSVH7bkZZ1tgM+wbL2U/BLVVDpjlzDOSpe9e9c3M22hhlniw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SN7PR11MB7019.namprd11.prod.outlook.com (2603:10b6:806:2ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 07:58:28 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%7]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 07:58:28 +0000
Message-ID: <abb4a253-6f4b-4547-a238-db6f60ee3244@intel.com>
Date: Mon, 10 Nov 2025 09:58:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mmc: sdhci-of-dwcmshc: Add command queue support
 for rockchip SOCs
To: Sebastian Reichel <sebastian.reichel@collabora.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner
	<heiko@sntech.de>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
	<kernel@collabora.com>, Yifeng Zhao <yifeng.zhao@rock-chips.com>
References: <20251031-rockchip-emmc-cqe-support-v2-0-958171f5edad@collabora.com>
 <20251031-rockchip-emmc-cqe-support-v2-1-958171f5edad@collabora.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20251031-rockchip-emmc-cqe-support-v2-1-958171f5edad@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0236.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::31) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SN7PR11MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d33df5f-8ad3-4bba-9bce-08de202eef15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUNBeHVhUVQzUXh4NXAxdTlHLzQzUzBSNTNISVVXYXNtb3hHRHV5ZThpamdJ?=
 =?utf-8?B?K2x2ektvOUVScmROaVgrRnJxd0FxcExaTXA0emx6ZTZ5aWJxeUVEQW85L3Zx?=
 =?utf-8?B?MmRhRWtnY0k3S09XdXByQkNmM0hvSE91N2lJSUhWRFJnM1NuVWo0c29MUi90?=
 =?utf-8?B?SjdrNTd4L0U0UkhKOVRjRktEbGsxZTR1bEZMeGFXc0NXcGwzRzQ1K0FQcStT?=
 =?utf-8?B?NlJVazRyTTB5WGowbHRBRTlReUNqZEprdmZZQjBiSjQ2am5CZ2ZZLzU2emEv?=
 =?utf-8?B?bGlwMmlQcWJXaWtCbzFqcE42MEVTTUpBaEw4VHdPaTFJNjRXdzJYT3IwSEpM?=
 =?utf-8?B?YjNsQ1pUSER4RTJCd3pUV285dEROdnVoL2g3Zk52K1B5a2Y4c3hWTFdJMmRY?=
 =?utf-8?B?NjFZUnp4SzFKS0I0dWdHWVluZ3hOOGZ6dm9ZUHlhTVVvelFMVi9YUlFQeUtK?=
 =?utf-8?B?Zm9oYWhQdm9Vc0NlRHBNNU00dmlXWS91M0NzUEFFVGgxNk53cjJoUThiNHF4?=
 =?utf-8?B?NWYyWEtwbHhYdnpWaVVsM2xaZ0R0T3VlcDJTc2NxcHZJNDVxMm5DWDQzVENn?=
 =?utf-8?B?ZG1wVmRidnNzeVE4Umw1RGdZVVNxNTRSS0JSMDJRaHkyU1kwRFgrRXd6Z2d3?=
 =?utf-8?B?MWs5bmhxLzYrU3pKMTJ5S0loQ1FkQ2h1RlJJU0lPcm9wT1BFb1p5bmtXb3kv?=
 =?utf-8?B?RWdKSGliZjFzYlJLcnlEdEhaUGRPZnJaUmtBeGtjQUg3T3Y2TVNmb1ltSkE3?=
 =?utf-8?B?bFlOL3NKTlFxUlM4TUlDTGM3UUlvdm9ib1lCYklDbWdKcG1DR0tUNml0ODlx?=
 =?utf-8?B?blBHNFJld1RSYnkzTWdSR2c4ZVpSZVNVYis5eTgxV2tJczBUcXFuR0hzZ1R5?=
 =?utf-8?B?dzBpaWJaN2JvSENwOHE4bUxhRVBOdktpclgyNWd0bCtTK0hyZ2ZaSTUyNmYy?=
 =?utf-8?B?UUlSbGdOOG1hVzNUdi8xcTZYRnY2QlYvNXJHTGV6M0lTZnJ1dDNZY0k4TjNj?=
 =?utf-8?B?cEg2NTdwb3VWUWxhNTZRTjNhNmFwdjEwTkRhVEJ1NUJpTSszYlRYbTVpOUdz?=
 =?utf-8?B?K2RjS01qSmZMOHFocHJCY0hnK1N0WVRyMDlBRlo2MmVmUGZ5QlMxSE12ODdo?=
 =?utf-8?B?dGNaUC9rOFBLTTMyMXYyS1pSVFNSUXNoZHdzelU2cmwvOHFsRFhZdFM3RC80?=
 =?utf-8?B?UEVoZXBGd1VJYnY4ZlJrWjRKanVBcG8yaHpCaHQrSXV6bVdyRWY3ODhWMWhm?=
 =?utf-8?B?ZWxpRkp3cm9mVzl0blo5SHB3MzZNZTN5OVFPYWxlS29Jb0wxNUVCK1J1MFly?=
 =?utf-8?B?NVJCaUk5UG5QdEZaSTVKWWFaN0J0aFRrQ2VDY2hmTVdCNnhWTk1lcmhaS1pW?=
 =?utf-8?B?V0xsd3owN0V1RVp4SUJ5c2tVVlgxTEhyczQyWkdLR3ZrRFRiL1ZJMnorUWc4?=
 =?utf-8?B?ZFVqRzdJNVQ5Mlh5QU1nelFpVGhCKzBvbmtsWVY1bHUwTytlWmZqb3dOTW8r?=
 =?utf-8?B?eFNBTVpPU0hSallmMHNGTllRSnBnQmpJRHNnRitEMHBVa2lqazIybEhRY04v?=
 =?utf-8?B?bnpDdC9VZGhPcXNpQVhoS0Z2SHZWQ2hER0haVGVOL0crRForbkRvdWJVVE5B?=
 =?utf-8?B?c3BSSzgrMEZpNGtlcXM5SERBUmNDY1QyNXFDOUQ5Znd5SXo0SVVBN0cwNE9t?=
 =?utf-8?B?dFhSU24zTjhDbDFCRnk4KzdHYktvNUhzUVN4UUp0bnF5VWhBUm93RUtINHk5?=
 =?utf-8?B?TWFOVW1jcWtMRUg3UlY5RWRjc2NONFBtcHd2TEgzdWJxdWQ3T29XNkxhWHl1?=
 =?utf-8?B?S1BwbDZkekVYRUpSb1BNSTIrZlJGNVE4cDh0WDdrcnA2RXc5SldqMDNseVdN?=
 =?utf-8?B?dDdSaGZUYTg4d1p3YVhHcDFmR0lRVy9rL01ibk93OEJ2L25aVmd2akEvY3NK?=
 =?utf-8?Q?6FZoaKPuF1e9+/Ox/HaLXxCxKv7sdWa5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjZaeHVjaEVqYWxPeFlvR2hhYm5DUVhJZ1JqS3prWHVOaWh0STBZQ21Xb3lC?=
 =?utf-8?B?WE1uZDVBdHVyNVVsZmdVaEFraUExSndpTGdyaWlKS25PdGtXWHJlNnc0b0Jh?=
 =?utf-8?B?ZWFXbnE1WFF4L24xa3puSjgyUzJpWTErTVcvMW5MZExyQlBQa2NMU1ZRcHdn?=
 =?utf-8?B?MExici9SZFJpRlNQZ05qWVJnUkpVQi8xT283NWxhRmtBcXR6NHVGQnQ4ZWNr?=
 =?utf-8?B?Y1hkeGp3LzlaV0pmUnY3d1ZycHRKZ3FYNWpJN3pVVVBkOWdSdFFLRG9jY2Zm?=
 =?utf-8?B?Um8yV0xRV2M4ZllsTlUxOVprTjRNOUVaaklUVWp6ZGtjTGZvVzVTQ0d0cGEy?=
 =?utf-8?B?czgzSXA5QlRXYndFSjJ0Tk9ONkc4dkp5M0w4eTBUUHp5eXY2bEN4RTBhV3ha?=
 =?utf-8?B?RWp0K3ExMkhRMzJIZ0JZWkJmMnhyLzNjeHpUK2NGNE1MblJVckFTMVdPUndi?=
 =?utf-8?B?SEU3VThiMXB6bWpjWkxLbUNQc3AvL3YzcXQvMlBMdFp4N20vUnV1SncvbHdM?=
 =?utf-8?B?MlF3Q1M0b3Jjb2xEQmd6bU9WSkFvR0JleHQxR2svRTQyejU0TkZlNzRVQlV0?=
 =?utf-8?B?d2RLblZZalVjZTFQOUN1WGxSckNEVERibTNmNTBselNnSERLZ0puWUxJbXA5?=
 =?utf-8?B?d05lOUQvUXZhbzh6WStJa3paM09nTENGQjhyaHI4Q1dBblR1aUZwd05DYVRk?=
 =?utf-8?B?VHJZR2tub01WSDFBdlFHZENaRVFrcFozSmFZUENpeEtTWXZhQlU3SFVabWVU?=
 =?utf-8?B?OGxhTmMxeVBJSGpRQ3Fmd0VVeVVCTHh5RzFhSkhGcHpXbm8vWGRSeldnMkZn?=
 =?utf-8?B?dkd5MHBmVjRoNWNBYjBWSkFtYjRxaEhKN3YvaFdRZGw1dE1SSm9DTmZQSDdl?=
 =?utf-8?B?UjFYN0dwcktYR0c0UlkxRFJZeVFOamdYZk9FdGNHWUdxbEFCN0JZTXByZG83?=
 =?utf-8?B?dGZ4UnJtMmhLaS9UNzJyZ0tHTElqSy8vSUl4b2JpSlA0TzFTNzJsWFBaQUxQ?=
 =?utf-8?B?LzZaaGJsM1Jxcklkc2pLSk5XcTB1Q3N4UDkrMTQ2OXFZaHRwOUdZN1hJb1hh?=
 =?utf-8?B?TzBjWGtZRlg2aUVsWFpCcCtpQngvaHpFeFVCeVhtaXdNNGdnK29GK1Y1NUlw?=
 =?utf-8?B?cVVwQ0VvdG9zY3hQSEJNVzVMOVhXVGkwMzNJMXV4TUd2cW0yRElzaUNhUGdp?=
 =?utf-8?B?MnpYS29VNjJGUzJjK0treTMvei9ycWhwZG52cGRkeHhwWVlwYW91R0xLSUFu?=
 =?utf-8?B?UHNIVG1vTW1VMWY3VjJCNzJSZTVzUm8yN1lVSy9VeWZNNkJvaFNUNWJNMzhD?=
 =?utf-8?B?NHhZdmJNeWRoM050NndXSGk2TEJPdHRqNzNFWkZlWTNDVzBZZzRjclpvY2JR?=
 =?utf-8?B?RDNSQkJBTitVL1h1UDMvNXN4NUhZTTY5VFVKT3hKR2ZPOVBmRm5iWWozN3RD?=
 =?utf-8?B?alNhNEJDRk5JeTZQdmI1S3NOZXIzL2FIaXhYV1ZwdTZtVER2YWIzVUJYZmhI?=
 =?utf-8?B?VlVOeVlvSFZvd3pLQXdJNlhrV3BUTVdrMGlNc0hyb1ZaYXJzL0NtVlliQno2?=
 =?utf-8?B?RVAwaVZRWmhici9GVFZ1NlJtdFY1K3M4N3RuUVN1MTdQTHVRbldEY1FoWFFh?=
 =?utf-8?B?aW9ySVZPekkwV2ovakxjejJET0RGQWtCZzBseW00T0ZxWUF4L0NkOXZJMng0?=
 =?utf-8?B?S2cvYm9GbnlQNmRaWlowRWVSMGdCN0ZvUVR4ZTB5K1FlY2p0ck8yTitYTU4z?=
 =?utf-8?B?MmlFV0tYeXhOampyTnhGNGhwUlZoMG9GVUJVT2JNN1d4UlhXNjB4aGdsUEta?=
 =?utf-8?B?TWNyQzBCbU5MZFFGbkZOTFZoTkVtbFR3UDNlckZQb1ZFc1cwSkFEeURTeGE1?=
 =?utf-8?B?TTZELzhuOGMrYTIzVll3aEYvOXR3eDNSSDFsZmI5ZnN4ajNFOUltUi9NMGJa?=
 =?utf-8?B?Q2hZanA5ZmRWV1BWdWRncWVSdW1tNXpCcVB5dE5tWmFxdWpHdys1UDR4RnpB?=
 =?utf-8?B?MVBtcFFndGI1WjVjOHczRnF1KzdRaXc0RUdMdWprVkU0VkRtVGR6cXhPUWx6?=
 =?utf-8?B?RUhQNnR1Ly92TmRZVm9DTFJLT0tPMklqZDdlVkw5MU02VEFycndJaCtTVlhM?=
 =?utf-8?B?MGxLOUhGdXQrb1daQ1lCR08yZGo4MHRYMW1TNVdnODVtSWtTR090bGJUTWZD?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d33df5f-8ad3-4bba-9bce-08de202eef15
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 07:58:28.7615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MC64eJlX4Xc9QiLikWF+039AAL6ws8WS9QpCeEEdfDulb2wL/Or0muyePkmBmmwd1ue0RS5/9wqkmBzzCrhoYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7019
X-OriginatorOrg: intel.com

On 31/10/2025 17:58, Sebastian Reichel wrote:
> This adds CQE support for the Rockchip RK3588 and RK3576 platform. To
> be functional, the eMMC device-tree node must have a 'supports-cqe;'
> flag property.
> 
> As the RK3576 device-tree has been upstreamed with the 'supports-cqe;'
> property set by default, the kernel already tried to use CQE, which
> results in system hang during suspend. This fixes the issue.
> 
> Co-developed-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

One question below, otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 93 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 90 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index eebd45389956..47509435254b 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -24,6 +24,7 @@
>  
>  #include "sdhci-pltfm.h"
>  #include "cqhci.h"
> +#include "sdhci-cqhci.h"
>  
>  #define SDHCI_DWCMSHC_ARG2_STUFF	GENMASK(31, 16)
>  
> @@ -82,6 +83,8 @@
>  #define DWCMSHC_EMMC_DLL_TXCLK		0x808
>  #define DWCMSHC_EMMC_DLL_STRBIN		0x80c
>  #define DECMSHC_EMMC_DLL_CMDOUT		0x810
> +#define DECMSHC_EMMC_MISC_CON		0x81C
> +#define MISC_INTCLK_EN			BIT(1)
>  #define DWCMSHC_EMMC_DLL_STATUS0	0x840
>  #define DWCMSHC_EMMC_DLL_START		BIT(0)
>  #define DWCMSHC_EMMC_DLL_LOCKED		BIT(8)
> @@ -234,6 +237,7 @@ struct dwcmshc_priv {
>  
>  struct dwcmshc_pltfm_data {
>  	const struct sdhci_pltfm_data pdata;
> +	const struct cqhci_host_ops *cqhci_host_ops;
>  	int (*init)(struct device *dev, struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
>  	void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
>  };
> @@ -561,6 +565,68 @@ static void dwcmshc_cqhci_dumpregs(struct mmc_host *mmc)
>  	sdhci_dumpregs(mmc_priv(mmc));
>  }
>  
> +static void rk35xx_sdhci_cqe_pre_enable(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +	u32 reg;
> +
> +	reg = sdhci_readl(host, dwc_priv->vendor_specific_area2 + CQHCI_CFG);
> +	reg |= CQHCI_ENABLE;
> +	sdhci_writel(host, reg, dwc_priv->vendor_specific_area2 + CQHCI_CFG);
> +}
> +
> +static void rk35xx_sdhci_cqe_enable(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	u32 reg;
> +
> +	reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
> +	while (reg & SDHCI_DATA_AVAILABLE) {
> +		sdhci_readl(host, SDHCI_BUFFER);
> +		reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
> +	}
> +
> +	sdhci_writew(host, DWCMSHC_SDHCI_CQE_TRNS_MODE, SDHCI_TRANSFER_MODE);
> +
> +	sdhci_cqe_enable(mmc);
> +}
> +
> +static void rk35xx_sdhci_cqe_disable(struct mmc_host *mmc, bool recovery)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	unsigned long flags;
> +	u32 ctrl;
> +
> +	/*
> +	 * During CQE command transfers, command complete bit gets latched.
> +	 * So s/w should clear command complete interrupt status when CQE is
> +	 * either halted or disabled. Otherwise unexpected SDCHI legacy
> +	 * interrupt gets triggered when CQE is halted/disabled.
> +	 */
> +	spin_lock_irqsave(&host->lock, flags);
> +	ctrl = sdhci_readl(host, SDHCI_INT_ENABLE);
> +	ctrl |= SDHCI_INT_RESPONSE;
> +	sdhci_writel(host,  ctrl, SDHCI_INT_ENABLE);
> +	sdhci_writel(host, SDHCI_INT_RESPONSE, SDHCI_INT_STATUS);
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	sdhci_cqe_disable(mmc, recovery);
> +}
> +
> +static void rk35xx_sdhci_cqe_post_disable(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +	u32 ctrl;
> +
> +	ctrl = sdhci_readl(host, dwc_priv->vendor_specific_area2 + CQHCI_CFG);
> +	ctrl &= ~CQHCI_ENABLE;
> +	sdhci_writel(host, ctrl, dwc_priv->vendor_specific_area2 + CQHCI_CFG);
> +}
> +
>  static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -679,6 +745,10 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
>  	struct rk35xx_priv *priv = dwc_priv->priv;
> +	u32 extra = sdhci_readl(host, DECMSHC_EMMC_MISC_CON);
> +
> +	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL))
> +		cqhci_deactivate(host->mmc);
>  
>  	if (mask & SDHCI_RESET_ALL && priv->reset) {
>  		reset_control_assert(priv->reset);
> @@ -687,6 +757,9 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
>  	}
>  
>  	sdhci_reset(host, mask);
> +
> +	/* Enable INTERNAL CLOCK */
> +	sdhci_writel(host, MISC_INTCLK_EN | extra, DECMSHC_EMMC_MISC_CON);

rk35xx_sdhci_reset() is in sdhci_dwcmshc_rk35xx_ops.
sdhci_dwcmshc_rk3576_pdata also uses sdhci_dwcmshc_rk35xx_ops but isn't
supporting CQE ops.  Is this change OK for rk3576?

>  }
>  
>  static int dwcmshc_rk35xx_init(struct device *dev, struct sdhci_host *host,
> @@ -1188,6 +1261,15 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_bf3_pdata = {
>  };
>  #endif
>  
> +static const struct cqhci_host_ops rk35xx_cqhci_ops = {
> +	.pre_enable	= rk35xx_sdhci_cqe_pre_enable,
> +	.enable		= rk35xx_sdhci_cqe_enable,
> +	.disable	= rk35xx_sdhci_cqe_disable,
> +	.post_disable	= rk35xx_sdhci_cqe_post_disable,
> +	.dumpregs	= dwcmshc_cqhci_dumpregs,
> +	.set_tran_desc	= dwcmshc_set_tran_desc,
> +};
> +
>  static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
>  	.pdata = {
>  		.ops = &sdhci_dwcmshc_rk35xx_ops,
> @@ -1196,6 +1278,7 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
>  		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>  			   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>  	},
> +	.cqhci_host_ops = &rk35xx_cqhci_ops,
>  	.init = dwcmshc_rk35xx_init,
>  	.postinit = dwcmshc_rk35xx_postinit,
>  };
> @@ -1245,7 +1328,8 @@ static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
>  	.set_tran_desc	= dwcmshc_set_tran_desc,
>  };
>  
> -static void dwcmshc_cqhci_init(struct sdhci_host *host, struct platform_device *pdev)
> +static void dwcmshc_cqhci_init(struct sdhci_host *host, struct platform_device *pdev,
> +			       const struct dwcmshc_pltfm_data *pltfm_data)
>  {
>  	struct cqhci_host *cq_host;
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -1275,7 +1359,10 @@ static void dwcmshc_cqhci_init(struct sdhci_host *host, struct platform_device *
>  	}
>  
>  	cq_host->mmio = host->ioaddr + priv->vendor_specific_area2;
> -	cq_host->ops = &dwcmshc_cqhci_ops;
> +	if (pltfm_data->cqhci_host_ops)
> +		cq_host->ops = pltfm_data->cqhci_host_ops;
> +	else
> +		cq_host->ops = &dwcmshc_cqhci_ops;
>  
>  	/* Enable using of 128-bit task descriptors */
>  	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
> @@ -1443,7 +1530,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  		priv->vendor_specific_area2 =
>  			sdhci_readw(host, DWCMSHC_P_VENDOR_AREA2);
>  
> -		dwcmshc_cqhci_init(host, pdev);
> +		dwcmshc_cqhci_init(host, pdev, pltfm_data);
>  	}
>  
>  	if (pltfm_data->postinit)
> 

