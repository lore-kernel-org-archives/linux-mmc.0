Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0026220330;
	Tue,  7 Oct 2025 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759851051; cv=fail; b=DYqH1r9bqjpoJhxcItI/OKGzIn0LGIegwKRqsz7oBv5/PGsiLJGtr66Erj9yrCOaokeDawVOoLN4FF8cSiuG3Pfscz4WrpW97ZrRXhdn7UCWrffN35cwGtImTSVM49AlaIdAinJnHATGpIcwO52JBhHbEtEeIGTrzPAR4P49IgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759851051; c=relaxed/simple;
	bh=cBg8Zg/E9baHTcKWJuoHVH7Gia1nHFUNZhgYW3l8mxk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pneo3pbMeCO38qT2i/0+qL6wauC4axR9vVjQcddxEsswxKQNLtEMaWKmZD0TtlhYFYJ3/luKzhxF894/h3AkjuhbN8r7EiaeNh6+CbPSCD4SCLeunLYcD+COeWAcUvcNEO7OiIMEU3ld4LANoqERKkOD+SgZB4RHFgDpKFQHrag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YaIi7TLE; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YaIi7TLE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759851049; x=1791387049;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cBg8Zg/E9baHTcKWJuoHVH7Gia1nHFUNZhgYW3l8mxk=;
  b=YaIi7TLE0GNX7Fk1wwO9ch5Yq0gMTk+ht+27EjGo5WRnRZ2GnhTq+oD4
   ya8F00GofshVH/i0zRM7Of76WIm7QNBJLQMhw2DLL4rA9XM1P1lMziZ2x
   b5ZjAaw96x90gyAxZ6m97YSFjzSsU8dp5PGRmKphlTQCyxNClpZcM8ywr
   NXLTqS3Vv49hzWnO7sL15acmHbVCVpMmdn7ZT3ZPNajyJNZRBnkvVoEdC
   8J3Loxk+9900v72xRmkC31EOnIfFb5oN7pcOn6g4AFD0FnkIEiJUXPLkW
   6iT2IUErPdiASVpcQsClUotkcqzo6ksGURNnyoYRQP0l5qdPqeBY627LS
   w==;
X-CSE-ConnectionGUID: lsNG+bxWQNO7XMqPIsG5Sw==
X-CSE-MsgGUID: xpzWQDjKQEyxKRXdBDrL+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="65683081"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="65683081"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 08:30:49 -0700
X-CSE-ConnectionGUID: AJx4AdxhRbax9baPP46KNg==
X-CSE-MsgGUID: mlSS/nt1TAusy9VAivniww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="180225324"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 08:30:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 08:30:47 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 08:30:47 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.3) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 08:30:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t558Tke/Sn985ewEwU7Db6lSTWGSHkjYzrClWNccCBDfzsB3DvWEuvbhXKADP0Oq8p2xabIjY0Q5HScMNKl0I0tnQ3e471Ww07ZCysVWx8MOKXdFYvXew5CrPmwlLfhv0CMF94DzZxfsiVaz3jkHShkadF20FdM0jomKWMmuj9VRDWLClq9IRhnjMeMYwC9Oj6bzFTcXROEV8MOGVJqT9apw9czSLAyPXuhizj6w0j1DZkxNsU6D8rnDpqJURNzOAKpHT65HN+usHArNo5aPl4jR5D8isE2P6Z2DoMKeU0gZG6/zfFbWZIIHA3qQucspkTYA/o2oEetSPnVQa/6ILA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUnqnnHAKdahFMOBqm6GeQ91lqrl4AhyX2BIP724EC8=;
 b=b+8ZCJBKJtWdeO775KIsTGVS5AryLphB7wjIuzvzW9zZ8hyhkKihArCN4zlB84qhTEFLw9uA4tHAXeARGjeP80PaCcSGMaHdWLTWkPM+IVWMPttOEacyPMUa9WFWvuyGq6Y4XQKshbOxE/TJRuFxvW4ZOZbT8I78jre4VF8N0hlZ4k7YMNxg0SNu5iISuVGuifRXmTAfrEI6n6IUO6qHc63IVXq8qg8USIVvGTtqFCaTc6D4SmzW4iAdfyAIgBGU7RnGJfMnxQIWzaohSoxMrAhb16Lf4XOdZqSVd/2iKmxTccsknI4It323ZJ88gQM6Pz9Ex2Z7YSt34tvGopMrTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CY5PR11MB6415.namprd11.prod.outlook.com (2603:10b6:930:35::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 15:30:40 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 15:30:40 +0000
Message-ID: <21b7c931-ac42-40ed-bf6e-94aa04986db2@intel.com>
Date: Tue, 7 Oct 2025 18:30:36 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci: Stop advertising the driver in dmesg
To: Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij
	<linus.walleij@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20251007-mmc-no-advert-v1-1-0e16989d28ef@linaro.org>
 <CAPDyKFoKV6K5AJgXHrJ0DBycCJZfx9D5cJhDUJjRnTR_W2EegA@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <CAPDyKFoKV6K5AJgXHrJ0DBycCJZfx9D5cJhDUJjRnTR_W2EegA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0251.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::16) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CY5PR11MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: ea11dccd-566e-41fb-db7b-08de05b67856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UThIY3IrTUMxUjh4Yk5DL2xEbWR6bHFBa053NndUTFErZi9SekkrVG94dVJR?=
 =?utf-8?B?QmJCWk1Ja2xPSkwzK2IxY2JYaVBwcTJjR0kvZUUyMXNIMkIyREZaMm5XQURW?=
 =?utf-8?B?VFpURWpoelVnaUorN3A1bHBnVTVWRzBSU25FTnI4MnFzQjE2dUJuUU1hb1k4?=
 =?utf-8?B?UFVkUnU3SktQUEwwaXpHZ0c0VHlZdDVVMUFSV3RkUk5VcWdOUjllRWJMa3Fi?=
 =?utf-8?B?QjZYcGVaa2VmaDQ0WGsxNDB0Vkd0dmo0L3lnOE96bjk0WTBRNFgvbHhrbHNP?=
 =?utf-8?B?bHlqVWRabHNPSXh3ZFoxaXU5aS9UVUd2Q1MvYlFNTG1oV1MvMnVOdXlLRjZa?=
 =?utf-8?B?b1hsZDZvNHFid2RRTFJHbjI4TnNVZEx5ZGdlU0J6eCs3OU1uc1NybDIrMGFI?=
 =?utf-8?B?T2x2OTVsNE9jaUV0eWVIdmhKRFQvSUJKT1lBVGJEUFp6c3V4UTZORXNqWC9U?=
 =?utf-8?B?YzFPSmJZTWwxWWNma2hpdlN4eW9MaEpwSDhCSFVuTU9RSEx2YTB4YkhWakt1?=
 =?utf-8?B?aVgwWFJuU0puam5KWFlJcHlpb3hOR1dtQzNBMG90bkxYMEp0aG9OWm12RWVq?=
 =?utf-8?B?WVdWVEVsOE9QckxRWE10N0tkK05pR1FWR2huditkRnRza0syT3JEcWsyeWpS?=
 =?utf-8?B?SGR0cGlLc1FMYzRrYTFWQzV3RVNLeis0MHNnY043MGM2NmdsUlNvY1puMjhn?=
 =?utf-8?B?eFFCdDFQWjk2Zi83NTlxQjdNNTFlTllWU1BMSFo2NEMvK0RmNnpoTytZQ3Ru?=
 =?utf-8?B?d3Z4azhHWHBodmhjd2gzREtlak9uWkU3dWNJVXpmNjdaQXZQS1BEQlRGZkIw?=
 =?utf-8?B?dnBQRzdUQVRyVjI5ZDNTRm1jZUlHcUJkbGtweVVhcEdaaHJ6UlJXdmxibUg0?=
 =?utf-8?B?UUlsbXdFK09XSlY3Zi9rek9LMXZ4aWtkWlZ1Zm4zNDNVeGxPdkVBSCtObmFa?=
 =?utf-8?B?dldpelEwYjZQMG5hRklxRHFFbTRrYkxXZWtXV2VDc2QvTFRMQTB2WFhNUWty?=
 =?utf-8?B?OFNkYlBKaUVXZkJ2blpmc1dYYVVWK240c055QTBNcCtSMWRBdG8raCtlaVQ5?=
 =?utf-8?B?QzdkcFY1NUIxWlBkZmJSR1NFbzJ4R1lEWkJjY3gyZkkxckljcnhKSG9BSU12?=
 =?utf-8?B?ZXpGcDhTWnZXZW9jMkhkME5Dc2V2TDlMU3A4L0NsVUhhSHBCU25tL2Y0SFdG?=
 =?utf-8?B?bDBWa2cyNXZ4WmlFSFJNeHdtbHcydEhqbGxQM052dHFvWEFzWGJRZ1RXOTBn?=
 =?utf-8?B?clhRK1BGdWhYZlFTaHkwNTJVd3owUDh4N2pITHJzOFZTTnU3TEVxMkI4djIy?=
 =?utf-8?B?M056OGFXaXJSN3ArWlM1OFdMUko3MGV5QWZaMmtMUGkxenZFdmlYZEFMa1Fa?=
 =?utf-8?B?T1JoNEdPSHZnVExsRS9lZ3k3UHlEYzJtUlh4RE0rUWtWbUpSdXgybnd1YXhu?=
 =?utf-8?B?ZE9mVDBpZDJXL0dpeGdCZkExMzZ4VjZjL2ZWOXBqUTZQZ3VRbThtLyswaldH?=
 =?utf-8?B?VXZKZEFBbHBjQ0NXRTZFRm9SeEthcHUwNDhGUGRzZ0FjcWxrV1RGYkZlaEhh?=
 =?utf-8?B?ZmVlZEZlb2FXUDFydUFDWVoyRjZhRnJrTzlrdkJhUk1ObHMzZ041aE04YTBo?=
 =?utf-8?B?WDVzZUh0d1RIWTlKLzVUZHRiNzNYRDZMRWtHemcyK3U0ZlN6MDM5ZkFTUEhr?=
 =?utf-8?B?dU5YbS82cHJ4QTFOVHRSUEpYUnJWT1FkUUNYd1NxcStzeFlzVjdNSGpNVWZZ?=
 =?utf-8?B?RGFSVWQ2V3JkWEVtc2tHZkNGSURuL05zZlh0WDJURW5wc0dGYnRtS01xQzFr?=
 =?utf-8?B?am9IalBHT3UrZ2hPK283WUJab29ZYXpzL01yY2ZHenRuUWVjei9nOFFmOHcr?=
 =?utf-8?B?R1hIdVlraWU5OG52cGI4S2pVaWVSNkxLSkVLSUJZNTZwUERyNGZmbnkwU0R5?=
 =?utf-8?Q?mHU1ApSIyDU75yjQH7FdQKa4aOuNx10I?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUVVQXBUTDNnNFdvUlJ1bTVCR1ZudUtZTHZDRmk5OUlzeER5ZnpCS24vOGNs?=
 =?utf-8?B?SjVJMzNzWE5iOXgxOGRwODVJOUpGQk1GZGhKQTZUSjV6dldNZWU5WW9vdHFa?=
 =?utf-8?B?a29zV1IxaExmNCs3YzhrRWllUVZHVStpaURqc3dPekE0b2ozQ0haamtGRTFY?=
 =?utf-8?B?YThIbmJRZm4xeCs0KzlEd1pUbGFNUE0zQTF4Rmw3THRseTAyOEkyM2RLbzNz?=
 =?utf-8?B?K3dCUytqUFJEc2dqMmJ4SVh6amFUOTE3Nm0zYTRqaitCc1R5QzFUQXc4NnR3?=
 =?utf-8?B?bk1ENk9jN05LUUJPZGRERWVHbDlBeC9LUFQ0NzV4N25DcjR0VXkrSi9PeUV6?=
 =?utf-8?B?M1prWHJ1cm9haGdlVFdpazJxZncrQVlPU0FDeXJ6OGEzNHRDMUtUdVptZnVB?=
 =?utf-8?B?eElkUWJ4Q2U4YmRQK3lhUzYvb2Y2cm0rRGNFUkVPVkk1TUZDeVFyUmlaNWpZ?=
 =?utf-8?B?cFg2WnMrSDJYRWlWWi9URG13REFIdElZd3JwdjFoQkV2MjE5MVFxT1ptcjFN?=
 =?utf-8?B?MGU3bHI3eStnZmhHT24rV3E0OXpBUHJQakpSTXdBTXZsQXVCRlE3M0p3RW0r?=
 =?utf-8?B?cmlGc0pNSFdDZTFrT0I0aGNNNVFTckNkeFRUVXZpMUEveU9MT3hXUGYyYklB?=
 =?utf-8?B?QkozY01kWDJrczk1eTd0U0JlbzQxSW8zOFFnSG1OTjE2RmZVNW1VaEhSSVRi?=
 =?utf-8?B?cmpPQkJzdjhJQ3pWZU5BMXlnNUlXOHcxRlFtcWIybW5uaWtpSjdDc0JSQVV5?=
 =?utf-8?B?K1l5QWxQQmpwb2RkYWlTUEdYdTNWMHdkdnJ3dFFpb0dtTmFvaTAxTzlpNHdC?=
 =?utf-8?B?S0dlMG1jNzZFQWlxOWFLOWFtb1lESm5wVE5DRDM1WTMwSStVd3F2Z1dkMGdz?=
 =?utf-8?B?eEJjYUoxc2RzYk0rbnc2eTh0Q0FxYjVrbzU0bm12SUY3ZWNTTkR6VVBqVnZH?=
 =?utf-8?B?ODBBWnNRT1pWTDJBQnlKK0JhT1o0Vm03QjFpZUJERGhtM1BHOVdjV0h6T20r?=
 =?utf-8?B?M1RudVFJdU56SWFjWDk4c3pvdnhxd0NhOUdIYVpNTXJQRVB6VG51VC9Nay9U?=
 =?utf-8?B?QXFaQS9wWGwxcmYzZkZ2SmRVbk1VWlNkdlRhNWdjUFhRNzdTTjQwekcrNksz?=
 =?utf-8?B?TkhBYnh4Q05qYVpRZC91UnIyRzNMc3Z4SHJnYlVLYmdsckdwUlFlTXc0QS9Y?=
 =?utf-8?B?WWVjbTQ1ajg2ZC82SDVDdG5Ub0tIeTQyT2IvY01jcXBEQjRuUHlTcDFLT25N?=
 =?utf-8?B?Uy96RWtSWnEyOXVibVhZYWxGcExldXF5eUpvcDF1RGNvRHA2cndmZHlQK0VT?=
 =?utf-8?B?NnFROXJ1L0IxSE9KYVNEOGQrSC9meDVvSjIyL0lTV3dQYzhkekluRFdiUXg5?=
 =?utf-8?B?Vk14a1VKS2NvMlpremtZWmFUQkxDOHNPZExMa3o4amZlY0c3dU53TnFpQUZv?=
 =?utf-8?B?Y1RPYmRVSzRKRXBRRHlVUHhIalRqZUtrUG0xaXZ6WkxybzFqWUNhWTZ1dERE?=
 =?utf-8?B?VlYzZjdiaisvcmEzdFJhZWtTWEdCTWVyZFlDaVNBdGtLY0EwcDM0aVUvTVFF?=
 =?utf-8?B?SlBicld4RTZiTkhVV1FmMEptd2xDWklncFhhbjRIVERyMHpRanF4ZEJTZHlR?=
 =?utf-8?B?OS8rRWhVd01LdUUrM1RhanlPS05ZQUdXRmFOVFpRenhVSUpabHIvUk9MclVP?=
 =?utf-8?B?RDUyLy91NkJpdjdLY0k5TEw5QmNqandCaFk0aTdtMC94c2F0dk9NNFpHVnUw?=
 =?utf-8?B?b20rcWFGOHVCNUVMS1dqKzZWekxoNnRFT1BpQ1pCV2hRSWhNL1Z4UU5RVTVB?=
 =?utf-8?B?RXdQUEw2TnpGU1FMS3JSYUt1MGhkQ2IvZ1J5LzZIT3FuQzJmUlJVRWlvN2Zl?=
 =?utf-8?B?TUF6Ui8yUzdJMkU4ZVlCeHl2K3Z2bElkNm9Ud3BFNG5Hd2dZbWVCUTdTQ1or?=
 =?utf-8?B?WmJvNFZTbGRUcTFrQ3cyV3pLKzVDSmlqUEh0c091QjZKTjllcEtoSi9HZlpO?=
 =?utf-8?B?WkVMVjQ5c2tSKzBNekNhcFhpYTJyYTF5QXNwQTFxZGZPbGJKdWN5NlB1NHMv?=
 =?utf-8?B?eXl0MUh3a2oxRnNJS25LRGFyREpDMkozQzlpcEUrL0RTRnpXOHkycFB4U0dt?=
 =?utf-8?B?ZVhBaWNqbk1nWTdjdFJ5bXVWSDgyeVM2dUNRbjZQcGZLRXhtRlcwVkxaWXZF?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea11dccd-566e-41fb-db7b-08de05b67856
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 15:30:39.9292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HeE1kB4N80Y/4qndIuB7r5lYrbkAoxD62uSKgp3Roq+ka/eYpgYxGxsfIA1jhvn6MZDJbaNSCEMfrqWSAp/ehg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6415
X-OriginatorOrg: intel.com

On 07/10/2025 17:20, Ulf Hansson wrote:
> On Tue, 7 Oct 2025 at 15:15, Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>> As much as we have grown used to seeing this message on
>> every kernel boot, it does not add any technical value.
>>
>> Demote the init banner to pr_debug() like other similar
>> messages in the driver and drop the copyright message
>> altogether.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>>  drivers/mmc/host/sdhci.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index ac7e11f37af71fa5a70eb579fd812227b9347f83..001802a3aa202c4d8f185ff4924838579ee44c4f 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -4999,9 +4999,8 @@ EXPORT_SYMBOL_GPL(sdhci_remove_host);
>>
>>  static int __init sdhci_drv_init(void)
>>  {
>> -       pr_info(DRIVER_NAME
>> -               ": Secure Digital Host Controller Interface driver\n");
>> -       pr_info(DRIVER_NAME ": Copyright(c) Pierre Ossman\n");
>> +       pr_debug(DRIVER_NAME
>> +                ": Secure Digital Host Controller Interface driver\n");
>>
> 
> Why do we need a print at all during module init?
> 
> Typically sdhci drivers end up printing a message at the log level if
> they succeed to probe in __sdhci_add_host() - along with the other
> error/debug messages during ->probe(). That seems sufficient to me,
> but I'm not sure what other people think.

I tend to agree.  In include/linux/module.h it says
/* Each module must use one module_init(). */
but I am not sure that is true.  If not, maybe sdhci_drv_init()
and sdhci_drv_exit() could be removed.

