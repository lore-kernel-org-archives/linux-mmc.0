Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2515B2E3715;
	Mon, 28 Jul 2025 09:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753693898; cv=fail; b=laM3PQO5O2lUXXiYoKuvsc7Qf8R05gFGJ/nbzv3RxQ7NuwD0zYzGiR9fatYzFJOyCbibJp8IvLWQJTxoTxIpB2O5+KyrUa9WJcEE54O0H4GqNKeK5a/8pEvFRq2ur1NPFO/6Ak0R3qu2R+LqRkOaIymz565ic9Hyiyg1DagkTgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753693898; c=relaxed/simple;
	bh=SR56B+T7IUDB6rBfHBGAdheycMNfyvUBfBlLHFWugdw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kul5urFp9+TqLWdPLtCZmpb7D3Zpyx8tU0/gXN+/rPkahGrneEl6b8c5RosYTQNkRuc0jevNVqoxOAN3VXPK68qbYmq3KPucKlsQAca7J2JNTfllCY9R01Fb2eYLjtHPFyGLBQKduXdfFnprlaESBnixlkZ+S7/mB4HjX4nt3Ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m8/0JfSo; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m8/0JfSo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753693897; x=1785229897;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SR56B+T7IUDB6rBfHBGAdheycMNfyvUBfBlLHFWugdw=;
  b=m8/0JfSoV9OzSvaxwsClUcfLv2eW5dFLTBOyD+l33rScV7xriYOjQ7Rh
   2ReFOItRjcTp4taQqJfZV+006xmmNwW8DHBbq552ESBM1JhXiThzLloBK
   pVXdsOEt26xNP27XN2hr546PSa0jB2cBtP7VeajBhVCIg8Y9ch6jgLQLi
   F31Y09dq8iqVSB/6SoIa0FbGd1ZeGQoEPlB+JjfpfVoQdkQYZpcO71q3G
   uNNeFlA/b5mVhxq+rGMbqytqzKxH/4zKQoUzMCKi+iUQWRietmjsIoJkK
   itYCYX8W1RoSgoppNQjO1NhLiE2fLDjg/qdAIerCGVhVFlv8x+n8urQ+9
   g==;
X-CSE-ConnectionGUID: oMkbiA7HT4OfSzoVbq18uw==
X-CSE-MsgGUID: C2vVGAy4S3mCEXeoGpNsZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="59755075"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="59755075"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 02:11:28 -0700
X-CSE-ConnectionGUID: SBIOylzzTPmbS2bN97KAqw==
X-CSE-MsgGUID: xGKUlGoNSgGnk7wfA7nUQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="162240082"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 02:11:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 02:11:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 28 Jul 2025 02:11:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.66)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 02:11:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggxy4UsSntG2h14Wq5Ps9hUO4h4s07hjKi+xywWk0gxZxi3E+JwzHk2gIAgWeJy52ZBD9aUoSz+0C2oRUXSOtL6rR3Dk2l4qieMLGES4oPIFxI7y03ocj2MwOZpcxzfUyb/EmsTDcYMVEFSqXje+AYVVuLoAxZ+V/K7GKr2kG7tHpl0K5BMbdO2LYN0vWPnm6k2PoBpNOjrvG6UkvH8HYdluVVOMjLJfTByZ7iPwHbxHMK/TCaGq4F0E2zPdzCmAMSk0avtwgZb9nTmxVjg/yqRXnUc2UPEpTyYDjtVwem/n8VKOPGzMoDK23WAue6S6ZVjs4PdzFa66SAGp4VieYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Z2WXO1gAtD9YCNeiywPE7yvbc3roC2fs+9U69qjTh0=;
 b=DOOIYfqYD6zcf88aY7dHf7aasbWbsi3fsOwtXRwmUIkUnkfBdqnQgF9/gmcG/XvpAn5ws6JZCgYF2hhrMZtjdiQQu0j+hL959aWtMQsb9MDW+ebHXP15Amyx5aiV7I94IHApOhOkh/cQO7xErMdy7LE0XWmG74afD7c4h81sJ/vAga5qkMSFJ/zbi6ZjHnBvZshHEuFdgbTr8tSOABbKPkNbgwKKYltyB0NTS5W84y2E50BtUffS/FIn0++s6ti3Ta1+SP72EKbQNmkckLyV7U4k2dwX2Bs5d7tCpT0+W3QzvTAPhFKi73CnoMeGveUW8uHr4l12kb9eqxns42EDQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by MW5PR11MB5907.namprd11.prod.outlook.com (2603:10b6:303:1a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Mon, 28 Jul
 2025 09:11:25 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 09:11:25 +0000
Message-ID: <d542b1fa-6e2a-4af1-a14b-eee32a7f3de6@intel.com>
Date: Mon, 28 Jul 2025 12:11:19 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mmc: sdhci-brcmstb: rpmb sharing by claiming host for
 TZOS
To: Kamal Dasu <kamal.dasu@broadcom.com>, <andersson@kernel.org>,
	<baolin.wang@linux.alibaba.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <florian.fainelli@broadcom.com>,
	<ulf.hansson@linaro.org>
CC: <bcm-kernel-feedback-list@broadcom.com>,
	<linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>
References: <20250711154221.928164-1-kamal.dasu@broadcom.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250711154221.928164-1-kamal.dasu@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0109.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::28) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|MW5PR11MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: 36be5eca-43a7-417f-9dbb-08ddcdb6ba57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWJYLzRiK1lzaCtYalZGVDVNdFFCNDMrZUhVTXVjcXBDK0IwVW1lWDF6ZUlu?=
 =?utf-8?B?SFV4TWxGbTBjM2ZNeUpRcW0zUjBBM0Fqb1FwOGJ1bEFJMDhDRlNpMEt2TzFS?=
 =?utf-8?B?TTAvL1ZDZFR1aHhneXdJVHljZk4xVjkza21yVlB0d1IzSlZTQUNUSmhZdzN3?=
 =?utf-8?B?Zmdaa05CTG9LMlordUZHOVV5WFJ4ZXlTYjlid2VMejR5dnhhc1Y1a2VtUVlH?=
 =?utf-8?B?Tms1WUJndUJkT3NjbG9SUTVZT2p6dHpQMGZmczZTZmtKR3Zid0NkcExieEpT?=
 =?utf-8?B?cEw5KzkvQnErUWpFa3EwcE1rNjJ1dmpjdVE5NmYzMWN1RHp1NkhzdGJmVVc3?=
 =?utf-8?B?alZOR1luQ3hhOXUrMzJMT2ZSdngxZjlkZDJtTDdwZGVIRjNmSGVmc0Fzc0lF?=
 =?utf-8?B?M1dKVkdMRHNBZnpuWlIwWGpRODlvRUFLSE5UZlNzVXVjd3FIamVrSVBhTXpV?=
 =?utf-8?B?VkRNSU5sd0gzVjRlakNIZzU1SExTaWxvU2c0UXJoTkhBeFc5bjBYbnNPN09E?=
 =?utf-8?B?WERMUWxwN0xiRXlocjI4ekdpR1dWWHI1bDFRVFhCdmlRQnh2MlMyazh3WW5X?=
 =?utf-8?B?NHJJU01Pdk5yaCtYLzR1bjRUenNCQ1RwTkNaclQycm00L2NuVEl3YW9FZGVB?=
 =?utf-8?B?cVpIT2l1VnZEa0VtZDMyc0dGbTFxZVlEbVNqRFliNHpQVlprY2VnN2g5UzRD?=
 =?utf-8?B?WGRVMHprdmh1TEMzQnZPRFhHVWQ2ektxRlJXMkxmNjFadkJia0lNRFIyMjBa?=
 =?utf-8?B?SHMwYlpjODR6Y3dtWUxBZkR4ZjNTYkpKYWFvTWoxZkNrNkdFY3BuZzRxVmpI?=
 =?utf-8?B?cjVTbzROQ1RtUUJrMTU2MHg3R2dPRTR4NXJ3OVV3OERsa0tGNnpkWWh1eHEz?=
 =?utf-8?B?Z3ZCazBEZjlDb1p6czhYTlRrM0V6MUV3a1JRRXJYekEyS291NG96Tkw5R003?=
 =?utf-8?B?QmlrU0ZUeHdJbmhFQzJqaGQ4aHVuWURyQ3hQZTNEdXFzQi9aWEExMlViaGJk?=
 =?utf-8?B?dUhJY0JWVFM1UVhMZWM4R2ZENCtsdXZobFZxakFkdmUrZ1dxS1MxdjZXVmlz?=
 =?utf-8?B?WUhjQmhXUzFRZE1YbXdVekVuR25naFdRU3BNeG9TblJlVWxCdWpUdFUyS0Zl?=
 =?utf-8?B?d2l5NmVmd25RdGZjZHdOQ3BTbXREN1BtU2xITlRCSHRSNmVYcisxNDZiNjFu?=
 =?utf-8?B?N3UwTnQ2UFQzWFp2ZTZ1Y0lYQVpFN2VwWHNpNUtObXZBajBSQjRSU3VndDJk?=
 =?utf-8?B?NkhGUHE0QUJlRmYvRzVvNVo0c2NDT1RpeXh1MHBTRE9YUFJNbVdqbUFxd0Ev?=
 =?utf-8?B?aG9yeXVFYjV6UUlXZE5RNjkxN3VXcUZvQnpKYnRFclhiRlNQRkV2eXcrRDQ1?=
 =?utf-8?B?aUVhYWZpbTZRdkZKdFJjUlJ6WTdZNHF6eXI2MTZKWndPdXFicnlXY2tkMnND?=
 =?utf-8?B?NXdFZkZ5ODl6SithY3NuQVBuWXNhMExQMkhpWTB2N2ttRnJHOGxZMVZoMGd3?=
 =?utf-8?B?dlZzWVhqcVg4U1pOYjVDTzZ1c3dFUjY1WmNha0dqbUdEWmRaZk9scmhjOVVI?=
 =?utf-8?B?UUZud0syOEhPMFVWL29OdHk2WmxyMmg4V2JMQlF4OW9DZW5tS1Z4S29DbVRu?=
 =?utf-8?B?c1EwcUxFZmk1YVZrenN2aWlPWDVYV25SUTZzOU01Sis5Uk10OWFMYzd3V2NW?=
 =?utf-8?B?WnhxZUNSdDlBYWh1ZlpIZFBWTHFWSVNRT1lzLzV2NTEvWFdXK0FaMlFTcVF6?=
 =?utf-8?B?RWhmU3ZyT1d6dUJ4MkxLekE5TzB0OXJrSVQzTGo1YkxXeXR5MXZ2NWl5WnRJ?=
 =?utf-8?B?Q1ArM1B1emdLMGJtWk9GbklpcmZYelA5emM2eWlBM3lqajRRZnlod05DcE0w?=
 =?utf-8?Q?8ehEi2RFAFN4f?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkVZbzFUa2J0QW1yOFV4cGMyWFdna20rK0ZWY1YrZFoxZW5LQWN2KzM2ZzlZ?=
 =?utf-8?B?ZE45S1NxWW1iMk1pRkRkNysxb2FCUEtabm8raFpMem16K3YyWjR1SjU3VXJK?=
 =?utf-8?B?ZmF2MUp6bFZUZWs5WkZwcnN2RE9TWStUcWt0YkQrMkZDaXJsbkVLRkhKNXg4?=
 =?utf-8?B?Q2I3dTN3NXVyUHMvSmlMMjV6NmQ5b1hDOUgwclZPZXJnRHlld0ZUTndVUC9L?=
 =?utf-8?B?eDlSTURRQ3F3YjI2VTBBNElaRHRzelJRZ3FzanNINmhZL1F1N0xkV0NpZ21j?=
 =?utf-8?B?NndKcXJKcE5ManJEOFR1Q1dkZFJldmZUaU0yaWVLTkFzUFRNU1NEcVRiUDJT?=
 =?utf-8?B?RUgvT0JlS0pnNjF2SG5iMDlaREtBU3lxUXlWNlNuTTMycy9BY3NudWZoR0NU?=
 =?utf-8?B?cThnUlZtaXJ0dG5MRXBxai9pWlVhYy9JZWNac044ai9ZdDZsdDBLbUdsTzBx?=
 =?utf-8?B?QURORy9ONkhNSzFLWFdWNzRTOHB4ckdnNmx5eDVYUzlTVWVBdnlHTEp4b0lK?=
 =?utf-8?B?QXBVRTE3T3YrZGR3SFpuUFcvQ1k2SzNQRUdWb0hKOExZbUpXYWYyT0E5bnB2?=
 =?utf-8?B?czB0ZHdtcTJQZWRKMnJJSi9YanQyNisvd0dEaFpRZkxxTTZoVFA5UkNELy80?=
 =?utf-8?B?V0d0ZjJNSXBRUjBvYVgrNWlzbWVoNUxROFpJTkUzQlljZzRRQnlWZXlGSFFI?=
 =?utf-8?B?eUxQNjlYcWVnd1NXZ29KbzZXSmJ3eUNVREZRVGJWNWIyWjg4VHcvUmRoTlFk?=
 =?utf-8?B?ODg1SHpGMlJ2U08ycEl4Zlh0MUpIMndEUEY3b2dGT1pYMldMUXZqSFRUVzVV?=
 =?utf-8?B?cU1vam1HWW81QXdFTHgwSzRFd1dqbVlyNVd2elpCNzZOVUwranQ4R2VjWWFZ?=
 =?utf-8?B?MDJYYlNyNjcyQks2UTZzUUdYZEdlUVdKSVEzTzNaOGdxbWFiY01kUi9nNjBz?=
 =?utf-8?B?WVBiWHNBQzBGUXRhKy8reFk5OFQrVk9ER0kzTThGZjZZVzU4QUlmVTVaM0dU?=
 =?utf-8?B?V0JKTkpkWGViYUYzSER4SEhHN2ZtUXVZUmhBZW5zSDQzV1UySFZKTWg5Mlk1?=
 =?utf-8?B?NnQvSUZya1hPOEN4bTlYVi9SeHRSWG1qMXo5dnRBaFFvdXBBMld1TWtPYTZW?=
 =?utf-8?B?Wm1pYVpGQXQvQk51Y0toSHVvVU9tMHRGcExwaWM1NXBkSHh3Yi9HUWJNcU45?=
 =?utf-8?B?Y3NFaXJvRnE5TVFtVXR3NUdlUUJRUHloZ3NDWk9FUmNXdFR3TkRkdmNHbEhB?=
 =?utf-8?B?SjJ3NG9ZS000TFozQjZyeDErYysxa0dBNnFGWVhPV1lQVFV4dkZFSlR6QzFa?=
 =?utf-8?B?WlZWVWpwdUF2YjVKK2lQRWhkR2VBcWlsMklYSDB6TlBsMGZrNnhucEpEV1Nq?=
 =?utf-8?B?RVZRNUZkRzdvam9NQUhkYlZsS1pLWVNMUlpoRUhMR1JyQlowTHRDc20vWVJv?=
 =?utf-8?B?dEE3Ris4Ui9QdG9OZ0M0SWRBWUdyVzR0UFgwQlpObVdKdDluVUdtcGRwVmxy?=
 =?utf-8?B?QTQ0QVRIUk1YQVZXMmgrT0tLUlNuUVJFeTdoRzhMdUgzQmlnZW1yTkpRK3A5?=
 =?utf-8?B?YTdKLzJjNVRYdmpEZFEwVDhOODRvZm5xdzVUUXVCOGtDcFBGc29Gd2hqQnhM?=
 =?utf-8?B?M055Tk5zTytDVDZUUVBMblE4dCtJYzUvSlRlOEdIaWFrWnRscHVJVE1YN2cv?=
 =?utf-8?B?VXJzTFJOeStnVS9keWpWWk02cWIwQVdONTFVU3VCYVJZeWZNdlUwODVRZWkv?=
 =?utf-8?B?UElDVW5rMTRXZFNNK3FSSDMxcEtHQ21SLzFmZzlIRW5iM0I1bjZtcHpzbnk0?=
 =?utf-8?B?WVhmak56eVRpcWlPVmNlMWlOd09Oa3FocXMvZHVjTWxoVjNZMXJYMFJ5cVBz?=
 =?utf-8?B?ZUluTk5wSmVkdk51Ylg0TG9vbUxTVy9SZTkySXUzUi8vZFhxbERoNDlZeFFo?=
 =?utf-8?B?VTlaeTZOYWJibXNNSG9RY2x0UnFkd2lGZkk5R2pJYUdxOHdORmpmbmVhVElC?=
 =?utf-8?B?UHJaM0ZSMFo4ZWRKZC9uN0JlazluZlNLY0JtZ2tPRVMvWTRMYnovTW9xRDUw?=
 =?utf-8?B?YUxldHZzVlhPQ2ZZRXRGcWJoTFh3NnpWbzZjanpwY3lpT3NaSThJOERXRlBu?=
 =?utf-8?B?UjNUZTlLUEVscmI0T2FnZm1rbU1BZFUvejRseEFBTkFpZEwxU3p3TjE2OW5P?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36be5eca-43a7-417f-9dbb-08ddcdb6ba57
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 09:11:25.4464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URgc4WdIkeqpqLp06lEarBACvK4/NiKlztrs56JzYgqHw50dgLgO+bSFDydRombf6mWokr4Bct72LhDfVtqBAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5907
X-OriginatorOrg: intel.com

On 11/07/2025 18:42, Kamal Dasu wrote:
> This patch adds support to claim host for TZOS RPMB access and synchronized
> access to the controller hardware using hwspinlock framework.
> To achieve this Linux OS and the secure TZOS make use of:
> - shared hardware semaphore register
> - a set of SDIO shared work registers and
> - IPI interrupt registers 
> 
> The currently running OS that needs access to the controller puts itself in its
> slot of work register and if its next in line it can try to grab the hardware
> semaphore and complete its mmc requests. The shared work registers indicate next
> in queue to access the controller, and current agent in the queue. Next agent
> queue state is changed under the hwspinlock is owned by the current OS accessing
> the controller hardware before release the semaphore, send and receive IPI
> interrupts between linux and secure world are used to indicate completion of
> transaction to the waiting OS. TZOS has its own RPMB driver which accesses
> partition when it wants to read/write RPMB frames. Current implementation
> assumes Linux and TZOS as the two work agents.
> 
> This patchset is an alternative method to initial RFC patch:
> [PATCH RFC 0/3] mmc: sdhci-brcmstb: Add rpmb sharing support	
> https://lkml.org/lkml/2025/2/6/1711

Does it address Ulf's comments? i.e.

	https://lore.kernel.org/all/CAPDyKFrCjo8gGnxmXWP6V39N+b1o62VQH9zwMUNb2_+D3-qrdw@mail.gmail.com/

> 
> Kamal Dasu (4):
>   dt-bindings: brcmstb-hwspinlock: support for hwspinlock
>   hwspinlock: brcmstb hardware semaphore support
>   dt-bindings: mmc: add brcmstb share register and hwlocks reference
>   mmc: sdhci-brcmstb: rpmb sharing by claiming host for TZOS
> 
>  .../hwlock/brcm,brcmstb-hwspinlock.yaml       |  36 +++
>  .../bindings/mmc/brcm,sdhci-brcmstb.yaml      |  29 ++-
>  drivers/hwspinlock/Kconfig                    |   9 +
>  drivers/hwspinlock/Makefile                   |   1 +
>  drivers/hwspinlock/brcmstb_hwspinlock.c       |  98 +++++++
>  drivers/mmc/host/sdhci-brcmstb.c              | 243 +++++++++++++++++-
>  6 files changed, 413 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwlock/brcm,brcmstb-hwspinlock.yaml
>  create mode 100644 drivers/hwspinlock/brcmstb_hwspinlock.c
> 

