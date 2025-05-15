Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBF8299A95;
	Thu, 15 May 2025 12:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313622; cv=fail; b=ZEpjGHoLfJk2vIR845Kel8VSWmMwqmcpWG9hG0Qin3x0RzTudpLKcS1rQBkrsiHuI8LbfHntU7UxAq5hwfnj12V2YfJ7kbzv08RZrTllIw9Vea2Tv3i7EtggDUe8tAtAQs1jnwgBsHPJMZKSNiiNQb8oT3MwuzcDuPz5a/SiZ+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313622; c=relaxed/simple;
	bh=D4QpZdqjGwaB86341FDYXBjq+B3L1Z492ClK97KTfO4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PdRSMCqkELFGd+vYw5PIPfBhHxZ4a8DbI+yuJvnJYguYxHE1Bv1R5k2WcFb2Dh7rHaFqaiIzzkqD8HeVUPGgOaqEWfFtvxfOihZwUuSDjA9xb1v9PPb/C2dzdq1kNzIfEer9OhquP5YH+MqLQtngkyojmpa99y0vyb93k6oxZMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FY6D9K92; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FY6D9K92"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747313621; x=1778849621;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D4QpZdqjGwaB86341FDYXBjq+B3L1Z492ClK97KTfO4=;
  b=FY6D9K92g1WLJ6tB+OibMNRhUNYwSdzkU5OyoMOObL4P+g1D3wjGy22A
   PUl07sWLj1ole7xxRgQcFglwV+wt91yx84Uk4f1JxA8N+DdeoNkzHqRwD
   0axHmIHXJxcU60jMJOdsZELZqTT1qIX3JJfE3YCY/pRPCf/yNTMrExM9X
   gwkDyyuvnn/t+uPqo3M6f9wl6+coafbUUU4zI1RjpXuyvsMXWMiuHZkCF
   RajXJ410+f6g5JN82f5qgMlo9zlNBeKH+dgoon8oBaLF6UcPadLdAM6WJ
   Fuq1GHO2YwtoEle6gXR5iy00QC8xb4jNCtNC2f99aHx8w5d3BzV3FEE1w
   w==;
X-CSE-ConnectionGUID: By3xiyRXS961rGL86HKIzw==
X-CSE-MsgGUID: hEbMx2DzQ3CCSQDQpBEvuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="51883018"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="51883018"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 05:52:53 -0700
X-CSE-ConnectionGUID: CvKi1g9LSTiqEd4LqOazUw==
X-CSE-MsgGUID: 9tD2hGigSpemN0CmbOzvQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="143245459"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 05:52:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 05:52:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 05:52:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 05:52:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IqI57LrgrVdcLNCLvEGfUUfzbbCz6xB2OKrv1M9X6YxbNMo6dFcJzT4v5kkrScd5gS5xjxBkxnBQrP8xklD5eYNRpmpGbCYpZ5UAAar+OEh91g+jbWz0eHy2hOAbZVOaCWLJjDzhYudXVVKDTqN4OVJiHECru9YPlRIZs9HmcouceVtWD+BaH25eYV7VxDVv7VI3P8lF6iZfYroiVyExT/S3iuLeEn4JLkThAzrVNdsyT57K22L1k0vRgAsDF3KO74t+c6i6XspXhBW/YpYVe1ArvJ/ZACq/VuxAnbe5BJri92km7gqswFIH+W3Ld6khgqp5yhQaBWp9e2xtvzVgSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KJV574X0z4zAym5nDQ0MXlT2jMYoZeyS1wsSPN0aOU=;
 b=aHr1QVOgN9IyaGPHxETeFB5gmQjaBHSSxGG4WWv20LfeoA5lI09W/anIb6WQXsm8Zvv/3isHfjUA/cVFX7pl7xrfgckRgLx1/gsE2/R3WPBGlshsfSfRIrfMYdKBoAwg8m6EWS2S1SHdz8+sbivQKdTtcbH7Eu2Kxo5J3+lY/C89q2rMp1Z/pw8JHt8kHaHNHIFQgZhJW3YeAeWQm0fPYAhkKRG+GrMUfeHQdRQTcLGpUXx2WaU1yP5755ialvqVP+YkhOm17lxRyZ5kslHTDFe3fmwvtNsLsySgTTlZMozQu4OgmqXYl1hN5sWS4nfuqALGgXyRXf6NiTrR2bs4wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8)
 by SA2PR11MB4972.namprd11.prod.outlook.com (2603:10b6:806:fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Thu, 15 May
 2025 12:52:49 +0000
Received: from PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301]) by PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301%5]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 12:52:49 +0000
Message-ID: <0bda0bba-cfc6-403d-b36f-9c625e5bafb2@intel.com>
Date: Thu, 15 May 2025 15:52:43 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mmc: host: sdhci-esdhc-imx: refactor the system PM
 logic
To: <ziniu.wang_1@nxp.com>, <ulf.hansson@linaro.org>,
	<linux-mmc@vger.kernel.org>
CC: <haibo.chen@nxp.com>, <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
	<kernel@pengutronix.de>, <festevam@gmail.com>, <imx@lists.linux.dev>,
	<s32@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20250514094903.1771642-1-ziniu.wang_1@nxp.com>
 <20250514094903.1771642-2-ziniu.wang_1@nxp.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250514094903.1771642-2-ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P194CA0010.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::13) To PH7PR11MB6054.namprd11.prod.outlook.com
 (2603:10b6:510:1d2::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6054:EE_|SA2PR11MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: 945c097d-4994-4135-8048-08dd93af65a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkxoUTZKOE9WVys4MnpQOFVXYzA3Y3NRQ2FndHp4em1TVUZyZGRXUWh4K2Rl?=
 =?utf-8?B?b243OGdyQldYVXlpbDJtVGVxb0ZOSk41clZNMi9kRDFmWVhmMDdqck1La2RW?=
 =?utf-8?B?VzRTZlUyWUF2RHBTbDhHTDNmMXZNenpPaVVqOGZWK0dkUnlDaXNqQU1XRFdo?=
 =?utf-8?B?KytoOFFOREdkc3hSdVJPTUJqWTl0ODRvQ2FERXk5dzFZNkNLN1ZvR3BtTFlP?=
 =?utf-8?B?NE9idFFsZ2lQZjNkY05lTUJZNkRMUXRIVGpheVBwRy9uL2VUbjVsN2ZJWFJ5?=
 =?utf-8?B?RTRoMmxuMUkyZTB6S2ZsOEFnY21kMVhqS2tlT0ZhT3FreHZpcWNtbHBoMjR1?=
 =?utf-8?B?TnFHZ3FtQitCNnUvL1l1bVI1dVJFbm9VVjZRSVVPUG1BMU02bVpFM0xzd01a?=
 =?utf-8?B?YjQwUEdmMjAvV0ZyR0x1T2lscnRCRllFMGdQRzdGa0NYaWlJaDFkbkdjcFBF?=
 =?utf-8?B?RmlETEEvZGxvRUtTd2RMd2pEcUowYVlUMlFucGRNdzV1SERCa0RqRURZRXZw?=
 =?utf-8?B?R0duM2hpWm91cjdNaE11MVBiUDN2M05HQ29BaVMrZ1NwODhnN29GdHh1Nlg5?=
 =?utf-8?B?bVBDWmNuVHpSeCsyZzZXTFJ0eWhTditaQ1B5TUVKZWUrRGxDUGlyUW5BdGI0?=
 =?utf-8?B?MkdzclVXOUR6dEJJYzVMdnJYclVDRjJ0dGFXRFBFK3ByNGVHcEt2UzF1K1FU?=
 =?utf-8?B?Wnh1cXY1VGFWUDdITHQ2YStLczQ5dHc4TmRXYlVNTmMwZGZaS0dPbW9GaCt4?=
 =?utf-8?B?a2pZK3VYcktJRXozd2xzdDJaZHZDRlRJV3FPcTdNYmVXaWxuY2Y1bmF4SjZ0?=
 =?utf-8?B?MGtkM0ZpMUIzcGd3VCt2a1pMREErRmpXbHlOeVJXVXFiNXh3Y1I5VkhHaEc5?=
 =?utf-8?B?WEJKdE5wS3ZvMGljdlBGZ0lTSmhXZlZucVVTZUU5VDV1Q2haaUdDaE9XNFRz?=
 =?utf-8?B?NjFGajlJcVlRbTIraDVtMnZDL2lGZmJoWXgwaCswQ3NqVGZ5TTNwTnVocjFI?=
 =?utf-8?B?ZUtIQy9WZUQyM2pzZVdFWENtQUhQdTFFbXk2VmVsSjE0L2c4dWN3NGpURXF3?=
 =?utf-8?B?UzZQWDFCa00rR3h6eVpwY3JQKy95RGZCdlNoU1NrTER3aXVEOHNTSGxRS0Zn?=
 =?utf-8?B?Mm5oR1c2ejJMRXF5T3NSeGNIOXkvak5pMWxTaDhYOWs4M0xOSGhKMHhuTjAz?=
 =?utf-8?B?K0twOW9Pcm9UQVZQRTVlZGl2MFZ0NmFlQ0tDYjc5SlJsYi9KakdpTTRELzRV?=
 =?utf-8?B?bEw3ckl0WjZKNjdGZkFPc3hGRGEySzJOWkQvMjltclVRbWFjb1M2UXo4WTJq?=
 =?utf-8?B?V1lDSStaaGkzZ3BwSktvenRIRERqbE5qT3o4ZmxmdkRNM1UzeURPVHB3VUxN?=
 =?utf-8?B?QkowMFdmemRKdG9uVUp5bkovNy8vQ2hBVFlhWTlMdXlrYXBZb3BhUmZFbGcv?=
 =?utf-8?B?eHNIMzhIeVE3TXdVVGNqMjJCdzVmNm5iTHM2SkpNaWhySjJpMVU5MXY0Zm9B?=
 =?utf-8?B?TUJtcy9CcVphNk5iVVlkekhFcEZMRDJYODRXb25ZZWRia3pIMzZWSWhYNm5l?=
 =?utf-8?B?YytyUXNZbmhtaU5JZWlyVjJCOG1vbUR1b01tWk5NeWJ0QnVseFFrZ2orSWhF?=
 =?utf-8?B?cnB6WGxETlN0ZTlJUjRZNkFOVlpTQ0JCdDFOaUwydzl2MDZic3ZyS2JsTDFl?=
 =?utf-8?B?SnptMVcydGJmSG5wb3NEV1FtMDVlTkZRSk9QdHVZQlpXWFdnd1gydE1BTDVG?=
 =?utf-8?B?WktMb0JGblFNTmRvaFM2MDRNVUdyY2pQa0tjdkczMWcxbWM5WUg2d25UUmlj?=
 =?utf-8?B?Vnk4dWRoM1lCODNhbHhPbEtoeFVTaG1rTWg2bVhZTU1FK0JTRDArT01mVUZM?=
 =?utf-8?B?TGNzREUweU1yR2swOEZLQTJQTjFzNHhKTUx6Q2pvSElZQ3JFSXN3ZVM5R0p6?=
 =?utf-8?Q?6Bp8O08IOcA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6054.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEdsVmNvWW83VkRVQ01JY29hZHZSakpzYWJxOHh4dDVrU1VxT0dBQ2MvVHEy?=
 =?utf-8?B?VHMwYUNMbktsYks0Z0VEbFdtTGtqV3ZxdEhoU202THZJeVRCRWR1cktCSFBl?=
 =?utf-8?B?RXJBbGp3MHA5ZEZqUVhnNG5BWlU1dk1paC8vRkJBV2srSlhhSFluSmN0VFky?=
 =?utf-8?B?TGJCaEFuVmZNTnFWSnNTL1VGakdTY2JxZmRMWDNJNndMQUtwQzBwWmE3c1k5?=
 =?utf-8?B?YTdwNm1Bc3MzYVFGYy9qTHMwY1YwZnkrWTh4L1dLK2x6Z0pORHVQWjhXUDdh?=
 =?utf-8?B?bVVyL3dJekVKR2xYVlBQNEVRMWxXUW9NS1RpdEtrNGxIZ2kySnBMcEhuZldO?=
 =?utf-8?B?OTBUZTRmdkpDU3h3UWVvYUdaWXMzTUc4NHdHTzBieGIySXR2SjhqNDBsb3pD?=
 =?utf-8?B?Z2xESUZzMmZiSC9kRDZmWlF2M2cwY004Tk1hcDFhWFRieDlhRnUyNDlFYU0v?=
 =?utf-8?B?Q0FLR05BNTJKM2NqV3Y0REJCZml1QXBhOWpxSzdab1grbEQrazVrZ3FqalFQ?=
 =?utf-8?B?NG9PVHQzNWYvcTVpZmJiUFBkZE1kRGVydzlpejF4cEtQZ2FJSkxSSlJiZlNW?=
 =?utf-8?B?ZVBZdkF2b29TNWQwbGtnWVh2ZkdsaUhkdG14UXc1Y2k3R2ZRSElybGs2dndi?=
 =?utf-8?B?UkRqamxaYTlOYUc2Zi9XT3JYV2h4MjcxZFI4RmNjMFlBaXFZVVRMUWJjaGhE?=
 =?utf-8?B?RDhYNWc4Q2VsdmdLQ2VXUThqSzRqb2xpMmh6emtvWUFpWEd5Q0FIWWswU0Q1?=
 =?utf-8?B?Z1NXRzBaTkVPY3lrRkg0dVBpeEJuSFYwRkQ3SFhzUmQ2a2JzNXBuMkhNOEFX?=
 =?utf-8?B?UWZjOVA2QlFIVXRoODduOC9UK2tzMWpSZTFHenZKN2lRNW5hN0gwRUhOWFhC?=
 =?utf-8?B?LzU3ajkvQm1sZjhaTktyUldNRVdxNXp4QTBGVGdGYjVNSUNOZEV1N1gxai9q?=
 =?utf-8?B?SUk3UDl2blZYNXJNTjNlZlg0ckhiWkJ4QU14dGQyY0RPbkU2ZDB0NWlPYXlK?=
 =?utf-8?B?K2J5bTd4eEMzV2o0Yk5GdVZ2Z1hkYWR1aU5KalBUeitNUkdQM01ZVG5tcDB6?=
 =?utf-8?B?TXNxRnRzbEhJOVhkRkREMG82SUs5RWIwb1A3RzRLbkxZUXZIVUVaT3JONmxS?=
 =?utf-8?B?MmFtOWhmcWp0SG1xbXNzS0RYT3gvK011Sjh4bjlTUUNnNUpmNlhsV09HY0J6?=
 =?utf-8?B?ZktlQVZNWEZHc3M0WVp6RzRhdnBkUUtBR0Z2SFM0NVhZOUxQR1drRGx3OEww?=
 =?utf-8?B?a1BQNi9HNHAxOUZTNWtOREFZRXFLQmlVVHArSFc1ZUJkMTlPbUdZTGp2OFVO?=
 =?utf-8?B?SjI1OGxCSjhtSDI0QmRrR1F4OFdJaEpkS2JBcWhyUThGOGx2REJGdHBtU0Jn?=
 =?utf-8?B?THJRSU56dVZua2huSDJ3MFpTY1U5UlkxYi9hYUV5ejlSZmhrTmthZ0E0V3ZO?=
 =?utf-8?B?SGRNd2V0QXpCNC9mdFpKL2p0TnhHOWJvbHZVZzJ6VHBCY1dISXNvMGFqdjBI?=
 =?utf-8?B?cG1DUDdTbEREMnROZit4K2dTUVBCTERzbktRSUJ2OWNZcnRUeVZiWWhaRVRS?=
 =?utf-8?B?QlluV05OV3M1ME1DVkxjUHpiNlIrZnBlbzRHeTdHT2p1bFJ3TFVoSTI0VHpI?=
 =?utf-8?B?Tkc3VGEvc0V1VmthWTAzbXIyYTYxMWlwVGtMK0M3NS9zeG12Q3hIbDljUUlo?=
 =?utf-8?B?VUM0WlQ2cVNodllQNXRDcGZMQmNXcnc1S1U1dmhKNkxqb3QwZTZaVkJWTkFK?=
 =?utf-8?B?QWpaMDVRZDRsNy9mSjY3YnFHWmxvaHZ0V245VzgzMWNsWkdWbURKYncwMFh0?=
 =?utf-8?B?UE5vZTF6Tzg2ZUV6Q0lTOWNLeDg5L3dlWDNQbjE0akt0S3hOS3lhTDBNQm1U?=
 =?utf-8?B?aS8vVWVwaXVxMlJMaUY4d0taS3lpaWJXQkduRVV0c2JZajVPTlptbDR3Zk02?=
 =?utf-8?B?bURDR3NoWUFmMGtkV0dWLy93SDdvY0xsMDhQVjl5Vlc5U21ZWDZzM3hpVGxT?=
 =?utf-8?B?S09Wc2hLMDFpU2IxSStwcHFRbHNmVG5jY3ZJRHBoeGlEN29hY3N1TFg5VUdv?=
 =?utf-8?B?eGUySXJNaXRqRXRqSnp3VkJzUHU2UEQxNUFRSXhVSk5SYk9aUThGYXRKMDhk?=
 =?utf-8?B?TmZuVm80cmxiWWpFVXV4WkgrWkc0N1JBa05SZjd5SU5UTUZxVlhveU1pdlJ0?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 945c097d-4994-4135-8048-08dd93af65a2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6054.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 12:52:49.2799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: POOT06plzEJEfSIZtnIuPVn/mTZ4ID/4pPdQOud4y2xkl5PbHRArjcxElP81qKmz+Bw6/gJxr+j4Nk4uc/50Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4972
X-OriginatorOrg: intel.com

On 14/05/2025 12:49, ziniu.wang_1@nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
> 
> Current suspend/resume logic has one issue. In suspend, will config
> register when call sdhci_suspend_host(), but at this time, can't
> guarantee host in runtime resume state. If not, the per clock is gate
> off, access register will hang.
> 
> In sdhci_esdhc_suspend/sdhci_esdhc_resume, remove sdhci_suspend_host()
> and sdhci_resume_host(), all are handled in runtime PM callbacks except
> the wakeup irq setting. For wakeup irq setting, use pm_runtime_get_sync()
> in sdhci_esdhc_suspend() to make sure clock gate on.
> 
> Remove pinctrl_pm_select_default_state() in sdhci_esdhc_resume, because
> pm_runtime_force_resume() already config the pinctrl state according to
> ios timing, and here config the default pinctrl state again is wrong for
> SDIO3.0 device if it keep power in suspend.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>

Looks OK to me, at least, although Ulf may still have comments.
Otherwise, for both patches:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 50 ++++++++++++++++++------------
>  1 file changed, 30 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index c0160c69a027..7611682f10c3 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -2009,11 +2009,14 @@ static int sdhci_esdhc_suspend(struct device *dev)
>  	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>  	int ret;
>  
> -	if (host->mmc->caps2 & MMC_CAP2_CQE) {
> -		ret = cqhci_suspend(host->mmc);
> -		if (ret)
> -			return ret;
> -	}
> +	/*
> +	 * Switch to runtime resume for two reasons:
> +	 * 1, there is register access (e.g., wakeup control register), so
> +	 *    need to make sure gate on ipg clock.
> +	 * 2, make sure the pm_runtime_force_resume() in sdhci_esdhc_resume() really
> +	 *    invoke its ->runtime_resume callback (needs_force_resume = 1).
> +	 */
> +	pm_runtime_get_sync(dev);
>  
>  	if ((imx_data->socdata->flags & ESDHC_FLAG_STATE_LOST_IN_LPMODE) &&
>  		(host->tuning_mode != SDHCI_TUNING_MODE_1)) {
> @@ -2021,9 +2024,6 @@ static int sdhci_esdhc_suspend(struct device *dev)
>  		mmc_retune_needed(host->mmc);
>  	}
>  
> -	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
> -		mmc_retune_needed(host->mmc);
> -
>  	/*
>  	 * For the device need to keep power during system PM, need
>  	 * to save the tuning delay value just in case the usdhc
> @@ -2033,9 +2033,13 @@ static int sdhci_esdhc_suspend(struct device *dev)
>  	    esdhc_is_usdhc(imx_data))
>  		sdhc_esdhc_tuning_save(host);
>  
> -	ret = sdhci_suspend_host(host);
> -	if (ret)
> -		return ret;
> +	if (device_may_wakeup(dev)) {
> +		/* The irqs of imx are not shared. It is safe to disable */
> +		disable_irq(host->irq);
> +		ret = sdhci_enable_irq_wakeups(host);
> +		if (!ret)
> +			dev_warn(dev, "Failed to enable irq wakeup\n");
> +	}
>  
>  	ret = pinctrl_pm_select_sleep_state(dev);
>  	if (ret)
> @@ -2043,6 +2047,12 @@ static int sdhci_esdhc_suspend(struct device *dev)
>  
>  	ret = mmc_gpio_set_cd_wake(host->mmc, true);
>  
> +	/*
> +	 * Make sure invoke runtime_suspend to gate off clock.
> +	 * uSDHC IP supports in-band SDIO wakeup even without clock.
> +	 */
> +	pm_runtime_force_suspend(dev);
> +
>  	return ret;
>  }
>  
> @@ -2053,16 +2063,19 @@ static int sdhci_esdhc_resume(struct device *dev)
>  	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>  	int ret;
>  
> -	ret = pinctrl_pm_select_default_state(dev);
> +	pm_runtime_force_resume(dev);
> +
> +	ret = mmc_gpio_set_cd_wake(host->mmc, false);
>  	if (ret)
>  		return ret;
>  
>  	/* re-initialize hw state in case it's lost in low power mode */
>  	sdhci_esdhc_imx_hwinit(host);
>  
> -	ret = sdhci_resume_host(host);
> -	if (ret)
> -		return ret;
> +	if (host->irq_wake_enabled) {
> +		sdhci_disable_irq_wakeups(host);
> +		enable_irq(host->irq);
> +	}
>  
>  	/*
>  	 * restore the saved tuning delay value for the device which keep
> @@ -2072,11 +2085,8 @@ static int sdhci_esdhc_resume(struct device *dev)
>  	    esdhc_is_usdhc(imx_data))
>  		sdhc_esdhc_tuning_restore(host);
>  
> -	if (host->mmc->caps2 & MMC_CAP2_CQE)
> -		ret = cqhci_resume(host->mmc);
> -
> -	if (!ret)
> -		ret = mmc_gpio_set_cd_wake(host->mmc, false);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
>  
>  	return ret;
>  }

