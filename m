Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA39E523A;
	Wed, 23 Jul 2025 05:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753248836; cv=fail; b=pS6mkFiB+qhyKzjCfK+MwjalbiIZQpkomheutVKRkMpf4mSh3udtBSZrq0HDhSl/9QeqGMD+EGAgqtQR9LwgNiSB05LIowTAnW2J9iMdDWOaHrqx7VMyFPcS4KP2LuQxKvQ1IyL3vvkuqxMNnlS7HMRZrg/AndzZWS/zR40vb44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753248836; c=relaxed/simple;
	bh=PQMwPlAKdPZx1FUx+KyG6l1HbaC9nBgwdGxaRTd/QXc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J+H/qjEeW9m9VYWbYWCJ6VIC+X100FAwxQnCPqPEHbhP993x+rhXZ1Qk7kJCKlsgPhuNFnTWMM0s5HacKRva2+Q1pK0wsBv6C9CyDLFJ4YLwoVmyLRhpahNYBiGLyP1r+AR4NK3CnKjwoCH96wWb9bSVb0XYYca+6VLe3yRB/sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nHxfGNyo; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nHxfGNyo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753248833; x=1784784833;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PQMwPlAKdPZx1FUx+KyG6l1HbaC9nBgwdGxaRTd/QXc=;
  b=nHxfGNyozyIy44xOv1epZtBEYsCznFtxi9A5z9mQ+I8H9IBQ9k/VB8+n
   J0VbVnp1syXYQVP3TGLYQfhkgtGj5DKx2cyzT9ZjYsJk5U9MgDhe/4jxe
   2FhkkrXLJ7j6eq+iYZlkfEi6Ko2NLfURRXXacIXV3CT9/CTF30GYgmiAS
   XNqy2Utp/1ndfy9tQezRlt2FSgKQ7z0/QM2xB+fIKbtB1e1FZu/1B5rSR
   eA5Jf7EycJCKpuknYbMzTMpRLbnptV92Uedu/ZXgZiiiUgEIleC1RWleS
   1fsFjNbMUaeX5VthNhKPfOzNL+qMAaDW/2nLF3M25LMBWoXJEGRfcgAaG
   w==;
X-CSE-ConnectionGUID: GeVk77szRa6bJGiXmD1LgA==
X-CSE-MsgGUID: zQCqRnvATMSOxE2yJaihrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="58135188"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="58135188"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 22:33:52 -0700
X-CSE-ConnectionGUID: D+qbN+hJQ6y61RQGnlM4YQ==
X-CSE-MsgGUID: Vtan6JRlT0+oCUUeDuJHbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="190296378"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 22:33:53 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 22:33:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 22:33:52 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.84)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 22:33:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R15EGVSmYsLbEydBQD+agmbld6xw2FlRB6cvPm4AgQ73/1Mmqd+iT+trpdMzyIEGLyBrjBAnpZKbBj1QjtpraW45LZ/qAa5g0ZO/4R2bAzGm2hjhDLXz/CIHcEWz9A7KaUK43az7nX/8ITeaFheWYRo0FJDFzdVwmht5BJWzQjvKFrmfS8Ul18ooeD9+4EHEkTbmT6U9Bz51mUOITOcKoTwbZvLhhFYgLBE4yy0LAYaIfCu/3T7Bt+kMvHPhq1iW7/N4rB5uhHKD8axEITJaE24jUGodC1nauSHsI7Ftnn9HoNdF2ewJFrmSsYeJLUgO8LuirRXdrHd8LSTaMU3r8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZr1fCZGfxQhnze7QP03MSIFL1tf6ZeNQjhFH9p76ig=;
 b=C+4ENRvJ8Fb/Ovl+Y41f0SMcEzs49u5S3l1c26sI59I8TFW7Vj4NPaDHZkGKsssdnR48jvyl4gDl4EYz9wSUTPghmP+uDL/p1Q3dzJrgbrX1Pto2oIw2KX+Ax2foQlwg4B5/jEC+Vmh9PCNwmNVO+5B3i8ccZ/nG69fDHCnneg8KZbtw0/OcAZkumw1lclg7++c/X0yEK6/OFUc2Aed90wPd8QsAVaJFz1Dyb5c4AZvGCbL9kRQHmva3TsiF2Vtui+57lVAzbFLXHQcf6wU4mTlCDFd1CDjmiVVSXB6fQ+BrAZoQRxJvdBXke0kwk/E3qnbC/wkxw43mq356o4s8Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by MN0PR11MB6136.namprd11.prod.outlook.com (2603:10b6:208:3c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Wed, 23 Jul
 2025 05:33:36 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%4]) with mapi id 15.20.8922.037; Wed, 23 Jul 2025
 05:33:36 +0000
Message-ID: <99899915-2730-41c7-b71a-f8d97bb6e59c@intel.com>
Date: Wed, 23 Jul 2025 08:33:29 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/8] mmc: sdhci-of-dwcmshc: add common bulk optional
 clocks support
To: Robin Murphy <robin.murphy@arm.com>, Chen Wang <unicornxw@gmail.com>,
	<aou@eecs.berkeley.edu>, <conor+dt@kernel.org>, <guoren@kernel.org>,
	<inochiama@outlook.com>, <jszhang@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
	<paul.walmsley@sifive.com>, <robh@kernel.org>, <ulf.hansson@linaro.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<chao.wei@sophgo.com>, <haijiao.liu@sophgo.com>, <xiaoguang.xing@sophgo.com>,
	<tingzhu.wang@sophgo.com>
CC: Chen Wang <unicorn_wang@outlook.com>, Drew Fustini <drew@pdp7.com>,
	Diederik de Haas <didi.debian@cknow.org>, "open list:ARM/Rockchip SoC..."
	<linux-rockchip@lists.infradead.org>
References: <cover.1722847198.git.unicorn_wang@outlook.com>
 <e57e8c51da81f176b49608269a884f840903e78e.1722847198.git.unicorn_wang@outlook.com>
 <f81b88df-9959-4968-a60a-b7efd3d5ea24@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <f81b88df-9959-4968-a60a-b7efd3d5ea24@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0228.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::23) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|MN0PR11MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c008b3b-3a2c-424b-432d-08ddc9aa784b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzBPQlkzUlc3djlJZzQwb2FFMEtSM0ZVTkdCSUxjNjZBUGRyeksvcUZoOTZa?=
 =?utf-8?B?TzQrZytqZTJ3TTJUMUdxNmFxVGFIcDE2ck96M05GdkJMM3VwUi9VTXZzWC84?=
 =?utf-8?B?NGlRQXZWYUViRGJVSkJGRDBmdDlCdElyN0ZSdTA1ZytQSFFpU1hhSG5zQkJZ?=
 =?utf-8?B?OUtGSzk4bGlzL3d1ZE9yNXp4a3JhUjZUZzVOR0FWclJYUEp2KzVObUMxSUtC?=
 =?utf-8?B?b1dncFNEK09jZEZaWnRnQzVPbkIxR1FjdXl6WjhBNDZSbmxFeU9nYVhYRTlo?=
 =?utf-8?B?UVg1RjVHUW5nSzc0TjcvV2w5eVVMUVZvVlZ2SEx0cGJveCtpSzIxOUlMODcz?=
 =?utf-8?B?NkFxUEVlMDBSc3N5L1BYbFNZMzNFdjlRaXB5U0xIc1doSVVEbzNVZjJYQng1?=
 =?utf-8?B?Y3lJM0RtUlp5WWwzZzNVRzM2bUxBNk0zTzRCbzl2aHozL3RUMHNFc2JEQ2Fy?=
 =?utf-8?B?SnRrOFRJdkpvdWVodjdJWnBOR1ZidGdRb3BFSFA0QnV0WTJId0U4dG1ZZy9q?=
 =?utf-8?B?elhtcDh6QTl1ODh2QkNnQUV6ZHlLRXZXcGY1UUlpRjVHSWVXWnRCWTlxTVc4?=
 =?utf-8?B?a1JSck5lTTQxRzJweEVIbGlPUkVLMEhRK0pwc3dSTkxHeFRMMlF4OWt1Y0JE?=
 =?utf-8?B?dkdjNVlsa3N6aGFUSGQ3MWFOb1hqdnQraGNRL1lXYVk5b1lSU2FXaDdxaDBK?=
 =?utf-8?B?UHJQZjBOelpNaUpFYmN2WGpPZFJIM3BHU095TVJBSXIwSGp0QkhEcmUyVDRV?=
 =?utf-8?B?d1hvMmU2K1NsN2ttSGdSMFFBMFVNejlBQ2liTzdVc2VoUUhrdU9ZRDhYakxU?=
 =?utf-8?B?S0JRQXQ1K2hDV2NHam43d1NlbnJiTkJQaU1XZjI4R2srbU1UcGowL1ptUHRx?=
 =?utf-8?B?c09sZ0psSlM5T2hvakV5QVBRTXZEdDZoUWFtNEJuWm9CN1MyQjdKMVZyMDVR?=
 =?utf-8?B?VGg0REJqbU5MdUV1Q08yRjFEd2V3blJ6Ly94VlRoRmFVRThSbVF2QUdWckRn?=
 =?utf-8?B?MkEwUzVsZjVyd0FLU21uUk5DUjRhWXFmZVllQ2VwTDNOM0NkNVJIRjBpR1Nx?=
 =?utf-8?B?WEc0ZWUvcXNSUG5LN1NYSGtNOTQyL3FGRmtRNVVpYnEwZ3IwcHgxSUEzaWR4?=
 =?utf-8?B?SllSQThGOTIyV1JiSmJrYWtIWXpKc2ZhODVhU1pucXQwSnp6S1VOelExdmZP?=
 =?utf-8?B?emluaytESjVYYm9qMXVRQ2dDNnh4QmE5K2NtYWI1UUNhajZUTFpCNkZCbnJv?=
 =?utf-8?B?Q2RJbHBqeFVFOUlsK0U5ajdnSFJhcmlpN0o5b0dJMTJxc3R1ay9QLzczQlJU?=
 =?utf-8?B?MFNEZDAzSDc0VUtrT1BubG9xYW9uZkxVVnB3eXlqUm9DYmlYWDFyWUdVQ3FL?=
 =?utf-8?B?cGZVeWNqbFpnekphcEJ6SXU1eTVqOHUwT1Bsb1FWYzZVMzZBWUNpWUtpeEo4?=
 =?utf-8?B?dFNwTGQrSnFqSmcva0VhODBQM2VEelRTN3B2UWxLWE40RmpWRk5wSFdvZlk3?=
 =?utf-8?B?akYvajdNWGRQeFpOQjJraFlqUzVYMC8wZGRWcXI5eTVyN0orWitaZjc4cHk4?=
 =?utf-8?B?MnEzNVpkUnc0NDNBU0tWQnNTazdxODZPcVQ1SzdHcC9EcHAreGc5bWgycG5K?=
 =?utf-8?B?a0xibEdWUE1nTks3UVdjcTBDODl0TlF1SkZSZ0w1RnNORXo4MTdnMzhhMURa?=
 =?utf-8?B?QkR0bHE1QXI4a3N0YUhBQnRRcW5GcUhacFlOd012VVdSTFRkYVVzcmNBU2hO?=
 =?utf-8?B?T3hjN2hIWmxaaHFvNnRtYmRGZ0NJa28yakd2aS9sblg1SUZUbkVjYldHTmh0?=
 =?utf-8?B?YzBweGE1LzJSL3YyYWJsVURCQjRBUHBnSFNHRFJ5czBRRS9tT1E2ZGkzYXJp?=
 =?utf-8?B?Yms5eXFuNGUxS3ZzMkhDeVFIVm5ESHZzZDFPM2EvNkM5a2ltKzFFQVRhSE13?=
 =?utf-8?B?Q05FMzN6YlRndFVTNTdnUXl6bzY3cDFoMEMrQVVsd2lTQUtHT3luS2U0WE5F?=
 =?utf-8?B?T3FYSm55bGtBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkxDajFISG8wT2Jqb2hPNU5pTENaYVFuN3ladzVPOE9CRUxKZTFGcjlnelVl?=
 =?utf-8?B?OVpWM0REN2R4S3plMThndlhJWXlvSjVQZzV3Y2gzcmtlZEpzWjhSeHR3TkNO?=
 =?utf-8?B?Y3EyZTZkVDN2ZmhKU0ZUTkhDUi92TDFBTUVRRTIwelVjYlNUSEQ0MG9BdjBa?=
 =?utf-8?B?bHBXdi9DT29lZUxPa3JFVk82dmZ6TjIxMmpwdTR2OTJ0NzB4c2RsdEtOWHFq?=
 =?utf-8?B?eFJxdW9ibFl2SFJqdVNVNVQ3M3lpUVQ4WC9TcTdELzQ5ZUgycmpSV2FFVytM?=
 =?utf-8?B?ZmtnWnZjWEtFVmpGWTZhY1FEaFM3THExMGVOcXFrOWRveG1qL25RdFRqU3Bs?=
 =?utf-8?B?VkoxWXlpTUNDVXB4RmN3MVNocHJ6VmxRT2kzUjlrWUFMNC9yUEI2dVhicnBE?=
 =?utf-8?B?d1pPWE1CWVh0Zi9MYlJ6QWsxWE5FMlU3NHcxL3BIN0FtS0NqSTA4c0ZLaloz?=
 =?utf-8?B?QkQrWm5sS0o3cjZLL3BpMndwZk9VeDNBY09qd1llNlZUNzMzYndJUmdyVHM1?=
 =?utf-8?B?RVcyQ1grY05NcmFRdVlwYmg3U3ZIN2xSLzNqOXNpZkEzTElDMlVDWTVNckhj?=
 =?utf-8?B?WVlGeWZjdE1BMDJDaVJqMi9TalRpbVN0UThURDR2RDhqUmg5ZkRoekZ1OUhJ?=
 =?utf-8?B?L2RjSkpqU2IwUTVtT1BHcE5QcTIxNytBT2hWeldSSkg5cGNoVnl4V21jRW5a?=
 =?utf-8?B?ai9Kdm9Mc2VPbFREY2wzWmdCbnFyUHlLRlJmeUgrQ3pwZXhxWm1pZ01CUndp?=
 =?utf-8?B?OTc0anloOGlWdDlic203NlB1bmNXL2hzc2ZudXovT1BmVWdOSGE5VmRCNDJV?=
 =?utf-8?B?cXhaVkRrQUhyVzhDd0FWMkxhZHlzZE9GR3JtTEhPYVZ2YmR6THJIUFFlUTBm?=
 =?utf-8?B?SVpQNnFlZFA2c1JDSXJ0ZXJLbmxoRk9wQStKT2hLOGRBOHo4NndjalZXcmlx?=
 =?utf-8?B?eUoyOGVnTHBJU2ZUOU9QemZ3aVRqbU9yQnlzM0VXSWE5UXRhalo4YVpqM1ly?=
 =?utf-8?B?UFF1OHBQenZxbTBOQ1l0WFFUQVVUU3psRUlacGZLc1J3b3pZamErRGlkbndx?=
 =?utf-8?B?YW54ZGhaSUNrWEpHbGQ1SldFaW4raWlxWHdDSVZlMCtmdDdVT0VpTm9lU0px?=
 =?utf-8?B?VXVtSVNqc202SUVyS3g1RFBjbGwvdDJNN1hEbDlsWko2VDFOL09UZTdoSWNu?=
 =?utf-8?B?YTFja2xLVml2RGhiczZEWHZIWmpJRU5HamwzTDh2Z3JzdWNtQ21vL2lGa0Zs?=
 =?utf-8?B?UklQNTVDKytOWE91WWY3Z2RqNmhVUUlLNjZkZDh6bHdGYVM5U1FGNUFIQ2l0?=
 =?utf-8?B?YUZTK3JRMmpURVIzV3NwL2xXZ3pXRFM2QTlnSlZCVnB2eDRxaE1EV3N5YmY4?=
 =?utf-8?B?SkVkZHhlREFYM0tHbkQwcUdQaHh6bENlZzRKZUxVbG1WR29RVFJReExQaTlO?=
 =?utf-8?B?dWlkbEhia2J5Qzh6VVhsRXRKL2xFVDd6ZVpmVkp1ZU9QWFhNUi9FdlZ0Rlhs?=
 =?utf-8?B?L3JONHdJTHJkdU9lMHFKd3NubGJTUHdoTytJZWpMU0ZzWFpwczEyWUtVZkgr?=
 =?utf-8?B?UUdZdXh4dUx3ZGtsb29jenhjUGlMMnJhbDlKTU5oS0wvSmc4N2lJcFRMdGN1?=
 =?utf-8?B?Vnk1TXVKWEZTOUhDNWFvN3lsYzRRa3Z6YzZqMlhmR1dIUWxwc1loU2VUa1pD?=
 =?utf-8?B?WWhRSWRFQWhpMWpDOVVqRjBMRUxzcDBBa21rZ1NvVHo4MzdRdjUyMlJxdzh4?=
 =?utf-8?B?YVQvM3JTQVdGV3hwWkNKYUdUcEJieVRaL3pVeUtXSThaUW5oUitucitGVnhJ?=
 =?utf-8?B?SGdyVFQ0cUNQWWNGYmphblVnaDBFdnFKMjgra0pYUkNpVTN6VUJUTXN3WGpV?=
 =?utf-8?B?Rm0yWllEQmsxY05GUFhjRTI0bmNDQ1pmT2lvWGZkdEhqcmVPdjVDMjNoaGZj?=
 =?utf-8?B?Zm8rRHNTRlAzaFNiK29ReGthUzdjZTMrRG5tdUxoVkcrSHBlbUYxR3ZnQjVG?=
 =?utf-8?B?TUVieVpUd1hoMVdHUUNxL0Evei9scDd4aEJmeEJrUG13VzNGcGVMbWN3TXFT?=
 =?utf-8?B?SFhlZHFCVlpaWVV6RjdoZ3R3SitqODUxdjRiS25qN1AyNkhCN1ZabXdiekpv?=
 =?utf-8?B?Yit4TXA2N1FjdFppalFGMEVEK2tWTSttZXg3d3BtWGp6U0NteXBlMjdzbFdv?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c008b3b-3a2c-424b-432d-08ddc9aa784b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 05:33:36.1965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/YKeKLN7S9Popx/dUPiY1IL5+9T29ermtO7+j4+GB8HJNjRMm6relkGqMSRxWwdFfkk3GVVDBvOf0UmzWTQMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6136
X-OriginatorOrg: intel.com

On 22/07/2025 21:33, Robin Murphy wrote:
> A bit late for a "review", but Diederik and I have just been
> IRC-debugging a crash on RK3568 which by inspection seems to be caused
> by this patch:
> 
> On 2024-08-05 10:17 am, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> In addition to the required core clock and optional
>> bus clock, the soc will expand its own clocks, so
>> the bulk clock mechanism is abstracted.
>>
>> Note, I call the bulk clocks as "other clocks" due
>> to the bus clock has been called as "optional".
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> Tested-by: Drew Fustini <drew@pdp7.com> # TH1520
>> Tested-by: Inochi Amaoto <inochiama@outlook.com> # Duo and Huashan Pi
>> ---
> [...]
>> +static int dwcmshc_get_enable_other_clks(struct device *dev,
>> +                     struct dwcmshc_priv *priv,
>> +                     int num_clks,
>> +                     const char * const clk_ids[])
>> +{
>> +    int err;
>> +
>> +    if (num_clks > DWCMSHC_MAX_OTHER_CLKS)
>> +        return -EINVAL;
>> +
>> +    for (int i = 0; i < num_clks; i++)
>> +        priv->other_clks[i].id = clk_ids[i];
>> +
>> +    err = devm_clk_bulk_get_optional(dev, num_clks, priv->other_clks);
> 
> This leaves a pointer into "priv" in the devres list...
> 
>> +    if (err) {
>> +        dev_err(dev, "failed to get clocks %d\n", err);
>> +        return err;
>> +    }
>> +
>> +    err = clk_bulk_prepare_enable(num_clks, priv->other_clks);
>> +    if (err)
>> +        dev_err(dev, "failed to enable clocks %d\n", err);
>> +
>> +    priv->num_other_clks = num_clks;
>> +
>> +    return err;
>> +}
>> +
>>   /*
>>    * If DMA addr spans 128MB boundary, we split the DMA transfer into two
>>    * so that each DMA transfer doesn't exceed the boundary.
> [...]
>> @@ -1280,9 +1300,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>>   err_clk:
>>       clk_disable_unprepare(pltfm_host->clk);
>>       clk_disable_unprepare(priv->bus_clk);
>> -    if (rk_priv)
>> -        clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
>> -                       rk_priv->rockchip_clks);
>> +    clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
>>   free_pltfm:
>>       sdhci_pltfm_free(pdev);
> 
> ...but upon, say, -EPROBE_DEFER from sdhci_setup_host() because a
> regulator isn't ready yet, that "priv" is freed here, so by the time the
> devres callbacks eventually run, that "devres->clks" pointer which used
> to represent "priv->other_clocks" points to who knows what, and this
> sort of thing happens:
> 
> [   12.470827] Unable to handle kernel paging request at virtual address 002df7b378917664
> [   12.472104] Mem abort info:
> [   12.472471]   ESR = 0x0000000096000004
> [   12.475991]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   12.476657]   SET = 0, FnV = 0
> [   12.477146]   EA = 0, S1PTW = 0
> [   12.477547]   FSC = 0x04: level 0 translation fault
> [   12.478127] Data abort info:
> [   12.478126] rockchip-gpio fdd60000.gpio: probed /pinctrl/gpio@fdd60000
> [   12.478413]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [   12.479826]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [   12.480418]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [   12.481282] [002df7b378917664] address between user and kernel address ranges
> [   12.482421] Internal error: Oops: 0000000096000004 [#1]  SMP
> [   12.482980] Modules linked in: sdhci_of_dwcmshc drm_dp_aux_bus gpio_rockchip(+) drm_display_helper dw_mmc_rockchip drm_client_lib sdhci_pltfm drm_dma_helper fwnode_mdio sdhci dw_mmc_pltf
> m libphy fixed rockchip_dfi drm_kms_helper cqhci pl330(+) phy_rockchip_naneng_combphy dw_wdt phy_rockchip_snps_pcie3 phy_rockchip_inno_usb2 dw_mmc mdio_bus dwc3 ehci_platform ohci_platform
> ehci_hcd drm ohci_hcd udc_core io_domain i2c_rk3x usbcore ulpi usb_common
> [   12.486871] CPU: 0 UID: 0 PID: 64 Comm: kworker/u16:3 Not tainted 6.16-rc7-arm64-cknow #1 PREEMPTLAZY  Debian 6.16~rc7-1
> [   12.487901] Hardware name: FriendlyElec NanoPi R5S (DT)
> [   12.488412] Workqueue: async async_run_entry_fn
> [   12.488879] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   12.489539] pc : __clk_put+0x2c/0x138
> [   12.489913] lr : __clk_put+0x2c/0x138
> [   12.490281] sp : ffff800080713b10
> [   12.490607] x29: ffff800080713b10 x28: ffff0001f001a120 x27: 0000000000000000
> [   12.491302] x26: ffff0001f98e01a0 x25: 0000000000000000 x24: ffff0001f0f35408
> [   12.491995] x23: ffffa8da199b4b40 x22: ffff800080713bb0 x21: ffff0001f0f35010
> [   12.492689] x20: ffff0001f94aafd0 x19: 0a2df7b378917634 x18: 00000000ffffffff
> [   12.493381] x17: 3d4d455453595342 x16: 555300307075656b x15: ffff0001f4885650
> [   12.494075] x14: 0000000000000000 x13: ffff0001f025b810 x12: 0000000000008000
> [   12.494765] x11: ffffa8da1a73ef98 x10: ffffa8da1a460000 x9 : 0000000000000078
> [   12.495454] x8 : 0000000000000049 x7 : ffffa8da18c2fbe0 x6 : 0000000000000001
> [   12.496145] x5 : 0000000000000004 x4 : 000000006cb6bb63 x3 : 0000000000000000
> [   12.496833] x2 : 0000000000000000 x1 : ffff0001f1365ac0 x0 : 0000000000000001
> [   12.497524] Call trace:
> [   12.497776]  __clk_put+0x2c/0x138 (P)
> [   12.498154]  clk_put+0x18/0x30
> [   12.498471]  clk_bulk_put+0x40/0x68
> [   12.498825]  devm_clk_bulk_release+0x24/0x40
> [   12.499248]  release_nodes+0x64/0xa0
> [   12.499608]  devres_release_all+0x98/0xf8
> [   12.500004]  device_unbind_cleanup+0x20/0x70
> [   12.500426]  really_probe+0x1e8/0x3a0
> [   12.500793]  __driver_probe_device+0x84/0x160
> [   12.501225]  driver_probe_device+0x44/0x128
> [   12.501640]  __driver_attach_async_helper+0x5c/0x108
> [   12.502125]  async_run_entry_fn+0x40/0x180
> [   12.502535]  process_one_work+0x23c/0x640
> [   12.502939]  worker_thread+0x1b4/0x360
> [   12.503315]  kthread+0x150/0x250
> [   12.503646]  ret_from_fork+0x10/0x20
> [   12.504015] Code: aa0003f3 b140041f 540006c8 97ffd9c4 (b9403260)
> [   12.504598] ---[ end trace 0000000000000000 ]---
> 
> 
> TBH I'm not sure what to do as a straight revert seems impractical by
> now, so we hope someone else might have a good idea.

Presumably the problem has gone away with:

	commit 91a001a1a0749e5d24606d46ac5dfd4433c00956
	Author: Binbin Zhou <zhoubinbin@loongson.cn>
	Date:   Sat Jun 7 15:39:01 2025 +0800

	    mmc: sdhci-of-dwcmshc: Drop the use of sdhci_pltfm_free()

which is in next.

In which case a separate fix is needed for stable.

