Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6A6223DED;
	Mon,  6 Oct 2025 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759736318; cv=fail; b=GVjzQXH3Jd+OoLOKQqtqlxf4wAlTpTOBm5qg9+mKGzdiJVfHVa7wy1n8ys/jbEqf/Nuf7eiEAqCGRSvGfTLwAtx1xqnyWJz+nEOLPBtK7Mla0W04XXeq/8OkFcDBIl59AYCJweVlL4aNTlMt24BzmpASJYJu+BRyO947lCKHj5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759736318; c=relaxed/simple;
	bh=jN1jRC8MbX6oruI5WXz6ZB9NJzL8C1xooaTOVLuj9aw=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dE9Ck4/ahQUHhUYraZOvnGlbX2F358XBjDTIdS6TWR18nLN/qdrRaUmFM0smH/XwYPoG1q5tboVhgGVwvUgYENOy+0gOZOghFrsodceulPyItZVuWqve2uX/TJHEYjNBKIFFbUeVbL6u1BZHf6ymtS4Xv+m1yFFoAlv4mQaLH4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SzkY2Ity; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SzkY2Ity"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759736316; x=1791272316;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jN1jRC8MbX6oruI5WXz6ZB9NJzL8C1xooaTOVLuj9aw=;
  b=SzkY2Ity6jhKGVKnXsbo4I/foeYeMppGBQjpiqoeSKQ7fD/V35DjdAJN
   3igo70UT7N0XWJWG4Oe0iMSsb66Zrv4RF0llye2oWyFfkXTR6UV9zHVPA
   yWD0tkZ+5icodCd4brlaTEQxpgRZTy/r/Ny5iTPPAAlUER+cpGZ5cekcZ
   hLfCSeWSp6BdITQYn+paLsOGA77R/hMmVDx8ePiJ1oDpoCKSyqIwcsqcL
   zt9EewX6gcBwvzICe4JsxBBT69+qP2+lJsq9o+deDa4H5de3UKmmJVCWU
   mA/RS5UJX0AOqu09dGHboeQM1TXDTSow7TQrZUgpQliI2v46FNXNUJk5h
   g==;
X-CSE-ConnectionGUID: I3rz3f6SR/SpXk/LfJF8hQ==
X-CSE-MsgGUID: AMCPrKrnThyqE4SCU0UvCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11573"; a="73261578"
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="73261578"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 00:38:36 -0700
X-CSE-ConnectionGUID: SN1ttP/ATualM8EtGbvAtw==
X-CSE-MsgGUID: IxXjZCBbQCubd/kdbKkgSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="179850955"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 00:38:35 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 00:38:34 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 6 Oct 2025 00:38:34 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.36) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 00:38:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgIiKl8pFw1DDLrj4J38g1UOY4DvfKxCNVj00TpU41ba+PkGXxbF4attSqcu2kmOOeI330DBYVmFIRx79sN3i5QT12UKHVNW57U2lHQuKL9MyDf/VsZvp4fjMdLxivRF5tCMaY0Y4fH93d/3e9crMYoJlBugEEy0SMHSaHnDu9Qy26w6HHP/QWf8jFig6wJYoswtcqxoCQGcKe1jfnTOf+5JX5P9enS9cKu+mXjln5lplJQI65A7va1C5zMWSKEkBP/5DzwWZd0pdfZQ7tyCrW093vgi9XEIDp/oVXKRJU2ImdthOqlYaM6XrVOpH89svmteQSlO6wf2Jfq4ZdrpQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ao9ubvkVMzNWra0lhzI2Ls0O4Tj6nYJHO8L8XqX08II=;
 b=pf4wTmyy4tQrJj47LGqpzLz/bpn1aMP1jwpNnIfCIK2FwMsefvF9qxuKTw4ouChplHtUZ4IwTXLEjw/1by9RQFuZK+oLPTpAnGH4xjnslJVp1eayBAOlywED5dUlDEY3IlIl9v1SzGCpSrKzzs3ooX69JPix1DpAETUTULurLLm+QzH3fwISOtgAbJJz0KG8Cz3TYUMTHZ/AkpbN+2Jz0HNGdvYlXZTCVs09ZUOI8gaEgmp3A5wjrPlpAouO6uuJf5XBiPYtgbAD//Tb7AFudNH6U8utInwRmNGyHpexvNHl1ec5ZM2OkzriXk3aLoM4gRDRzzk0TE5zgbsyhvqOkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS0PR11MB9456.namprd11.prod.outlook.com (2603:10b6:8:290::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 07:38:26 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 07:38:26 +0000
Message-ID: <21d7f0c8-9a61-4759-b655-b12a6fad9885@intel.com>
Date: Mon, 6 Oct 2025 10:38:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mmc: sdhci: add quirk to disable bounce buffer
From: Adrian Hunter <adrian.hunter@intel.com>
To: Michael Garofalo <officialtechflashyt@gmail.com>, <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20251006013700.2272166-1-officialTechflashYT@gmail.com>
 <a9934d68-8b8f-49b8-b4a3-053e3949c666@intel.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <a9934d68-8b8f-49b8-b4a3-053e3949c666@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR06CA0045.eurprd06.prod.outlook.com
 (2603:10a6:10:120::19) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS0PR11MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ed95763-11bf-412d-0514-08de04ab55c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aW1pa2xqemh1OGpwa3d3VmVvWnNHWnZjWCtoY1o2ZTJKZURodEVnUGxSL0JN?=
 =?utf-8?B?ZStuSFhkcFMrUUVNWjhjSCttK2pJeE9RK3lkS3RlUmpYdVU0YjNNVXJMTFFD?=
 =?utf-8?B?ZFVlcWpXdFFFWEpTSjVBdDhsTlFmNHFpS3c0bmlRZnFDR1BvYkZQSHo5MHEx?=
 =?utf-8?B?VVdFWnV4VXF3a3Q2NHJSNitObEJnSmhaRVQvdjRULzkyVHlmanFJODhIeWhD?=
 =?utf-8?B?Q1Y1NGVMNVRFS2kxM1Y3MnlNNmdKdnBrbWUyVFJsQnlTbWlhejZVV2F2dlpi?=
 =?utf-8?B?SG9SVUg4UDkrckJyT0xnRGFNTVRzak9hREhURVg0Kzc0S2N6UDMxVWNnbGdU?=
 =?utf-8?B?MzFPOGI0TjRnZ001SndYU09RcnhHR2xyTk56d2lmU2dKWUtldFVGbU1pNFM3?=
 =?utf-8?B?RDUrNlZCN2c3WHJKU3Q3TWN1VmpEcTkwS3BwK01TRFp1bDYyZnlWdEcvL0Jw?=
 =?utf-8?B?ZC9iT2N4YnZWNUZLKzd6VVJVSkQrMWJXUjBRWVJIOG5XU2Rra0tES041T1o4?=
 =?utf-8?B?QjlmS3VBam9RSHZENHJRUXBDanJZVUptV3A2cXFNTWlZMWVDUkQ0S2dLbmZ5?=
 =?utf-8?B?ZzZSckZCemd2NStXaGhaWksyWGJ5ZGsxT1Y0SFJaMXNkc1QwQ3AvTUhlaDdm?=
 =?utf-8?B?T0UvTXg3NFVKT25MZFpWRHppUzdoaUdSUTVTK1kzUDR6cUE1YytjZXBBOExP?=
 =?utf-8?B?MXJ0ZmwwN2xmYUFjbmZRZThVUktGZjNBSVFoSGtrUEtVaTNLam5pcnk3N3ZE?=
 =?utf-8?B?VGhHR3FQNDhMSEhFcHc2dTdJQnpSQkc0MVlzZlRqaWpkeWFXK1NGY0UzMGt1?=
 =?utf-8?B?bXlnN1ZScjFqRDk5U3hJQWdzS2d2Ni9KOHdBSU5UV2Y3REpQUWQ5dHFiVmtN?=
 =?utf-8?B?cVNlVmJKN3VDWjlreVVrUk5qWlI2Z3pTRVREQk8yTGFzeGpIeUpxN0NzeUVH?=
 =?utf-8?B?RCt2UUlHSWJPcmJqNzI4RU9OSG1LZjlEVWJzVTdscGdlbGFrcGsxaE9SUlc0?=
 =?utf-8?B?aEc3R2FGdExmbkhtdm5KUTZXdnpOam1WQkhwblJvME1NTk9zYXEzZDduM2kx?=
 =?utf-8?B?SGp2QUY2Q01kaGtuV3JlUS9hVFBDcFhPZ2FoanRmUFpuWktaV0M2dUYrRTNN?=
 =?utf-8?B?dUFyNEtQZzFid0llOXk2TnAvK0lhRGdOUHU2TTFaZnEwYjJyMk9lNEQyQXg5?=
 =?utf-8?B?UXpIZ2NxUkxUTjdNRldyL0dSSEdnM1I4aEZ2enYwRVFEYkh5ZndMcmc3clhK?=
 =?utf-8?B?RlFSR0h4SlFYSUxXOXY5MEJSSm5TbHp2NEpaV3JzdmF3MDdkNnJCVnZ0SzNW?=
 =?utf-8?B?MGx4bjZhM2pkSjNlSXhPdFRMSjFEanVpNExucmdJTURFSVpkOExPcTNYRHQ3?=
 =?utf-8?B?bkZpSEhhbEVEQllFdWhzc01XdmxiSmlONjVtOVl1ZTF0L3AxdHdaTVEwaCtv?=
 =?utf-8?B?YUlkMDM3ZmhYMDg1bW5wdld1TWxWb2J6TXZ5THZhbzQxV2NRNmRrZlkyWE9G?=
 =?utf-8?B?S0hIQzFRQlEyYVRocGtjR0xxVHJ1c1ozdURzdVZzakxxT0lYZUxvVFBMbWNC?=
 =?utf-8?B?V2U4Z1Z2Nm92bjRQYlpmL21qVFlaSElwRFl2OFlwaEVEQzl5QldTRE5Tbit2?=
 =?utf-8?B?RFA2NVRReDczYmYzS0NZanR1TU1icHppWjh1WVVKVll3OXpHWlBEZVFXMWlX?=
 =?utf-8?B?TnhrWllPME00a2RMSWkxSDRMY08rdWZPUDAzb2xPTzlyYU1Xb3JQMTk5dmg1?=
 =?utf-8?B?ODRoS1hYOUJRSUQvUFZHMG5GT3Z4cTB2RitBSXZSOVI5RHZaK0Vra2FzeVZv?=
 =?utf-8?B?WUNQbUwvY2x3VXVpNTBTRjdRSDUvYnNCZGhCeHh1WFl4M3pTWTNaeTFSR29s?=
 =?utf-8?B?QmkzMzczVy9veTVFOUVFNnNUblVHRVZBdWF6Vkwvc3ZUa0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVk0dURML2tiU2lRTDAxL1AzVmxMY1dWRXkra2tDWmlEeWJ1RHAvWGpvSnpR?=
 =?utf-8?B?b1NKMUR6N3R3MWEyU2srb1VnWlBvRWZ6ZFhIWUYrUjh5OUdCQ1pRa0dLRGpq?=
 =?utf-8?B?bFpBVGNQZUNhWmtLT21kR0lqOWNRTmdaMGpTOXY1QmNpRlM1MlF3WDJ5dk9P?=
 =?utf-8?B?VzQzQ1NYU1RhbXJXWlVxTXpsUzFUSG4xdjlESlF3NUtqcDRQdkd3cVR1Qy9J?=
 =?utf-8?B?cklZRzR1dXVDTTJNbVhtZkU5SHdsUTcrR2xNVFhTajNyaWkrOWlWTUEzQ3d4?=
 =?utf-8?B?bitlTVF1RlJTNmIwSVRLMENwemROL3htT3E3OVVCeG1CdEMzZXhYdFFuNGpV?=
 =?utf-8?B?RFN6eDEra3lRQ1FpWDU0K3RveEdtQlp5SFRvZWNXQ0lSMjdBWFpDWDV6UHZh?=
 =?utf-8?B?aDVwSVVNQng2TGdHMEsvUjdkNnNmdUxFYWg4SjZ5RWtSSmNQYi9mdjFzN3Uy?=
 =?utf-8?B?YXYzcHg0TUVoaWVRN1F0Q1lidmFmU2RWVmFmd01aNU9NYk5YQXIxNi9kTDFT?=
 =?utf-8?B?STJ6bVFSZ0ErR0FIdUo2c29ZUkgvajdxVDFxYWpnejdDWWs4SFJLUk9TWG00?=
 =?utf-8?B?Z0MrS0N0NEgwRXQyRnE4RzJ6bk5lazZLMzB1Z2ZIOEVsQjFLTjV6ZXB1clFC?=
 =?utf-8?B?Zmx3TmFpeXB1YmF3bEFWT3F4L28vcXBQbnQ4bVI2YkgrVWx5bzZnMGVMMnM0?=
 =?utf-8?B?Yzl2cEhseFZaaU42eWszWDBncHo3OFpUdXRhbm5WaUNCNlNtMDZwK2dzdDY4?=
 =?utf-8?B?cm5udlFEZWlINXZEV0RkQnRrVnVRM3NmS0FYd3hUakloK1VEOUQ1M3dQajRv?=
 =?utf-8?B?K01tTElzRGdIUi9aS3ZnL2EwV3FIckYveG9ETEZ2QUNZK2xJWE13UTNDYUFW?=
 =?utf-8?B?N1dyRDgvR1dpNTVFUEVGQ0p5MmZpMFF4QVhCajJ5TDRoMGRKQ3BLeE5Dam5o?=
 =?utf-8?B?anhaRkRLck1wckN6WTlLYytFdUlCb3NxM2xDT1R6VndDK1BRN01JZ2FvdDFQ?=
 =?utf-8?B?V0Q4S3NPNnNuL2RPZk52ck1JSm1sdnRHS0hYbVAxVERTazZoTHUxdWVDMlRJ?=
 =?utf-8?B?aVBRMHRpV1hpU24rcmo0aGJRK3RmN21WeStXamUvQ253ZDM0RmZQbUZuWlhl?=
 =?utf-8?B?aW8rY1FBMjdGMkN1TWIwbzlrd0hwcjRJOWZtYmR2ZWpYd1V0UFZHT2szWHMy?=
 =?utf-8?B?Y3QzbE9ZUWxHQ3hiMGIrejFoSENxa2RtZW0wMXhwSlBCUjlCT2liS1daZlZG?=
 =?utf-8?B?SmNxSnE2NEEzUEt6Q0RkaE93dVdsOFVaMDNla3lHVkFQa3UySWtwamtPZG9o?=
 =?utf-8?B?RSt2cVZpS1V5TGRvUiswczVmR1BRaXcraVI4NUlEMk1CU3hnMkxzRFpaTUdh?=
 =?utf-8?B?SEtXMUN2VGhvWk1kbUhYL011eVY2TFZVbDVNTkNIN0pDVXNKcStPNTlROGxX?=
 =?utf-8?B?UUJXeHg0QWNpcjZLNTdHMDlZLzhlZCtScCt1emp1NjU2SHEvbWhqcmd3WWI1?=
 =?utf-8?B?VkVvU3ZxaXZBNEtueGtlT3N2U052N053YmdBTHBxZHM3NWh1a2Eyd1FFNXd6?=
 =?utf-8?B?ZlQ4UDIvTTBLNHJjcFVKWk8vcENZY2RQS3NPeHZ3SWtPT0dXUGtWZmtJcUtp?=
 =?utf-8?B?M0RpZkpzQ1BrYm5uOTJDWkI3V1BPMFBLS29JSUtyYUljaGczVmxtWThTOFBj?=
 =?utf-8?B?OG9vdU9nMk5Cek1aOXd6ZWsyQ1NUZGs1Z2VKVzdyT1NlN1dUZHVqVWFrOWlB?=
 =?utf-8?B?allCQzI4OWxkS2JHNFdDZVpTcEZ1SnhONmlZNWtGYkIwU1JkNWN1czdldVpN?=
 =?utf-8?B?Unc4aDF6Umc0V2YzazgxanUzWE0rZkJwM2h2cWFVSThOWi9pQjFUUjlwSU9I?=
 =?utf-8?B?cVhwWm14VUZLSXFyckVieUpiL0ZHeUViZHpPSndsVE1sNHFrMkRLdlhSczVW?=
 =?utf-8?B?M0NvWnJzOG5Ddks0U0hBYlU1QW5hRDE0eU1TZHh0TkRHN0crejBnNmpzVi82?=
 =?utf-8?B?Y3VzSkZwdlVROTNsOHppWlRhRUYvVUNORUYyZlZxU1IwUHhmclcvUnJHTlhJ?=
 =?utf-8?B?eHNUWllDTllkZnRveExHZFNUclJ4TzNJZGozUmJvNjhOV2xkekwzNTgyMUZS?=
 =?utf-8?B?MXF4TDhZWDRrNXRNN2l6YzlKZkNzdXdvWWRaTTZQTnBCckVOSUFIUjVLSWNF?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed95763-11bf-412d-0514-08de04ab55c4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 07:38:25.9588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qH/1M+l0smuGM5IMHu06tX+4DyfTluOOtgGdEjBEWMsHs9vtGhRZII1KKNp4H5DMJEvODo9YrEQdP7RbokvBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9456
X-OriginatorOrg: intel.com

On 06/10/2025 10:35, Adrian Hunter wrote:
> On 06/10/2025 04:36, Michael Garofalo wrote:
>> This patch series adds a new bit to quirks2 for disabling the bounce
>> buffer.  On some hardware, this is required for proper operation.  An
>> example of such hardware is the SDHCI controller of the Nintendo Wii's
>> "Hollywood" chipset.  Without this patch, the onboard Broadcom 4318
>> Wi-Fi fails to connect to any networks.
> 
> The bounce buffer should not make any difference, so it is likely
> a different problem that gets hidden when the bounce buffer is not
> used.
> 
> Could you enable dynamic debug messages and show the messages
> for the failing case?

Actually will also need to see the messages in the "fixed" case
to compare.

> 
> Dynamic debug for mmc
> ---------------------
> 
>     Kernel must be configured:
> 
>         CONFIG_DYNAMIC_DEBUG=y
> 
>     To enable mmc debug via sysfs:
> 
>         echo 'file drivers/mmc/core/* +p' > /sys/kernel/debug/dynamic_debug/control
>         echo 'file drivers/mmc/host/* +p' > /sys/kernel/debug/dynamic_debug/control
> 
>     To enable mmc debug via kernel command line:
> 
>         dyndbg="file drivers/mmc/core/* +p;file drivers/mmc/host/* +p"
> 
>     To disable mmc debug:
> 
>         echo 'file drivers/mmc/core/* -p' > /sys/kernel/debug/dynamic_debug/control
>         echo 'file drivers/mmc/host/* -p' > /sys/kernel/debug/dynamic_debug/control
> 
>     More general information in kernel documentation in kernel tree:
> 
>         Documentation/admin-guide/dynamic-debug-howto.rst
> 	https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html
> 
> 
>>
>> Patch 1 introduces the new quirk bit.
>> Patch 2 applies it to sdhci-of-hlwd.
>>
>> Michael Garofalo (2):
>>   mmc: sdhci: add quirk to disable the bounce buffer
>>   mmc: sdhci-of-hlwd: disable bounce buffer usage
>>
>>  drivers/mmc/host/sdhci-of-hlwd.c | 1 +
>>  drivers/mmc/host/sdhci.c         | 8 +++++---
>>  drivers/mmc/host/sdhci.h         | 4 ++++
>>  3 files changed, 10 insertions(+), 3 deletions(-)
>>
> 

