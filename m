Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C942736920E;
	Fri, 30 Jan 2026 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769770371; cv=fail; b=NrByw0EYvqQ0ERt3vTq9mo0Z355CD9JMdCt6IcfPStSWFyWmyEviPco1c/eeExXAI018mA3dYSAMhxvGaauU4tl33UVNFFo1HpkpZz5n6PJtx8TKnrvc0BmB1dCj/oecYrLe8yggRTGFJXTs0GvQBAFVlujUBHMvchejoPxdBk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769770371; c=relaxed/simple;
	bh=wva2jrhR/08leis/9mYTKvPzoyP1GBjPBgdQpTGpi48=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TwUqPMJKbmlIMvzBpPbWM9Ag96qCVVRKUrqXdE+0s+ZQKaDjPrd8BSHfbDAgmYxkRXTzYbRBsedZzqBcHwwDHrro8XN1yBWxqyBuivHQepNjbUkWnQXQv7CExvHVN/eTHAP4l7JnY3AfatNY0z0t7HpKMYDJ0w/zicCDNMnvobU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=blOXuOjQ; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="blOXuOjQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769770370; x=1801306370;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wva2jrhR/08leis/9mYTKvPzoyP1GBjPBgdQpTGpi48=;
  b=blOXuOjQPIGMIFghRO5Y323PfWRAy5ZAhLi5L4vgic+76yoBopT6mirN
   g9AFyP6nBlF9PKkI4maO8RXTVE712t81psMnmfVLu6bp9kTTUS/YUMYER
   dhm7arjkFA6B8Suwlpj8VZiT5Ha1jnSHDGEzoGmXbO4vwUFqTmBrvS3tu
   m7stLS/07PGjMYtbg2W3b2Wwc4yhwda+CU0aNsMhmczbGV0tAp9Hi4olz
   g3a8ybroZL/fvvl1BVjLBGT0hi7obg9kmdCR90LA3EPcs1hTLdvn0maoh
   PgU2kRNYdjCF5QcPvPLsP4fJnB88ADe5FSthM/pbvszHrNwjl3gOphUyx
   A==;
X-CSE-ConnectionGUID: 2schKjakTZ6cXbQqGg0kyw==
X-CSE-MsgGUID: jV9rPn5uQqGve0PhIFsTew==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="71056558"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="71056558"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 02:52:49 -0800
X-CSE-ConnectionGUID: K0AV/5QiRl69qsVT5goyXA==
X-CSE-MsgGUID: lD7XtI2+QQuYXOaiPVixXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="246451770"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 02:52:49 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 02:52:48 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 30 Jan 2026 02:52:48 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.0) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 02:52:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRmCPuijbnbxvad9Do1lEiymkIpD1mKIfLRmMbANDUMpSF+MJe1MEBR8sQyjyLipPIku7cP1Xw1awQUX9DFCYDmrtPVppwhVkAFcbwgvZrlFSRmcZiLprfwn0YGuP4uWmX7gp/1PJlL+JPlv6dyxw8yGR2vm6jiHiJr1Kk6VCvdRrKlxRDWj+d24lbDDcl2jqQjTf8TqY/1Bm75HH7yNTAjTKQcD4Av33ciwgvTj4fNon2723PIyWOGW0rNA/yixASt3ZZHNTfTCGwVkICRaYM0lA0FVYCExC180EPBdLIDJ20nADABApkEvYvM09wQ+bcTxMALII0LlhtICcFmYhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uloShqfcYJ4f9pVr7dZjpX2kuZY194TQ6w7Mki/KCHo=;
 b=RZvvU4uudehMSDCIBSOkmivBAJMyS4b6DX4PWP+IyHOBt8laoXCybvQV3o88el/FILd00Lq+3htgl9+NKOPRGTdkwQ/1uSMVAQuLBvXfBrp3NHthmqCs2fG/ZQhmhK4fOR4qvHIFGi+7L2a/iLoli92f41Y2gcNP/OOYi2zdxBL/cUaqSi7TpQFxeWmQkSRkfXuq02gANAHqWU3rWv9IzD1i+WyJFBJwTIc/x3LkMNctqLUcmUW8RoyGDAwJDjUgfv8pmZEXo4cMWbMa/0KCMhxgPuEyOF2S0oYJws8+D/a4ImkZkHAhItzJfppSUmEgD+FnyGXzlKJhYxKjLX99yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH7PR11MB6723.namprd11.prod.outlook.com (2603:10b6:510:1af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 10:52:41 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 10:52:40 +0000
Message-ID: <8efb0406-b9ce-46ec-bd8d-4763c12298e1@intel.com>
Date: Fri, 30 Jan 2026 12:52:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mmc: sdhci-pci-gli: fix GL9750 DMA write corruption
To: Matthew Schwartz <matthew.schwartz@linux.dev>, Ulf Hansson
	<ulf.hansson@linaro.org>, Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	"Victor Shih" <victor.shih@genesyslogic.com.tw>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260117234800.931664-1-matthew.schwartz@linux.dev>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260117234800.931664-1-matthew.schwartz@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0060.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::10) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH7PR11MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: ad0908f2-d69f-4d0d-3a06-08de5fedb095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QldJL1RUWEsycjFqSGlHaWhHU0x0WUY0OHNYTnhuc3JJVGFhYVNPTFVEZjFX?=
 =?utf-8?B?dk1jNzVYMVV5QUYweTZrNFk5eVczUENoVEtXclZseHFhZTM1OUxjUk9VUzBa?=
 =?utf-8?B?eW5JQnZXMHFNTVpodnphWkhDOG8xUG5wbWtNcnVlZFQxSThQdUdLcUs2ZjdI?=
 =?utf-8?B?WVoybjNLVWwwSjFNT2U0VGpGaGZrQ2VONnk5RHhkODk2RHNCbFVWZTdWd3gx?=
 =?utf-8?B?Y0w1Zit4dmhIQ1RlR3dIY2N0QmhNbkpPL3RiMEE3bmNqQ3NjWk04dVdua0R3?=
 =?utf-8?B?L2VkVGxuenNKTnRyRWVaUWNvY2lQRmlycktxbXQzMFRXVm1mSUdMVmM5TFJx?=
 =?utf-8?B?ZGxzSnZBbW1mRGF2RllMSWtIckVjUlFHMStvcWk4NCtsQjBoQXBHUmd1YnBQ?=
 =?utf-8?B?WkI4YUpiMysyTjhQM2dza05DNGpjRG5ESnBoU2ZWaiszRWsycUFTOGpEbVlo?=
 =?utf-8?B?V1BKYzBsY1pZeDNFSzdVcnplL3lMTUxGVWRKMG8xdEVNRFM3VmZ3QnlieXJ2?=
 =?utf-8?B?ekxmbDloQS9CdFk4K2pOZThXSDBTVnRYTmN0a05DOTh6TzB4WU14RHY2TkVu?=
 =?utf-8?B?cGlRUEpNTzVteS81dUF6YktNRzE4aS9rYndJZXVCdkpwakRLOHVkcEJNK2Jq?=
 =?utf-8?B?YUExRkdzT1RobG5sQW1HdFp2TUFpQUVMLzFMY0RPalY4dmNQWUxQclJxaFQr?=
 =?utf-8?B?QytYNWluQzdXZEJUUGwrRmYxWGFSd3doRlREVjNMQVR6NFYvR3VMaWhHZnp3?=
 =?utf-8?B?QXRBN29HZnhYd0ZPWm1QbEZEV3R6S1NxK25sSkR3WXp5RkdMYmhwT2ZWL0pU?=
 =?utf-8?B?VnRPUm1HRGFQTmorRjFyWU52c0xVSXB1RVBldko5MXRaVDFNOHhEYkNvVmhT?=
 =?utf-8?B?RE54TDhOS3FtQ0tYQmxEa3o1bzgxWXcwVFo3Y1E4UlNpdlBDWmZCNGxNQ0Fj?=
 =?utf-8?B?R3JFTFo4UnF3eDBXeUhvU2l6OWM4RVZDZzZacVNLd0hjVnN2MjVScUZkdWI3?=
 =?utf-8?B?LzFRY0hnTzFyVExseE5rRGVwdkQ0QkZRV0FubGdwTEhYVlcvcGV0ZEEvVXVB?=
 =?utf-8?B?VXR1RG9vdU1YMCtxajR4c2R0SDFSbWdjTnQ4bE5Bc0JVR2l2M3daMUIyZ05W?=
 =?utf-8?B?QzRpa3R3L0V6VVIxMmpXYnlaY3BzK0tlWm8xeGFaSytHeTY1RWQ1aW0yenJ5?=
 =?utf-8?B?RTJpVFZMa1NTdGdSOHk4OE13MkNZN0d1azhDRzJjQ3dWM3lQYTBaUnh5N3My?=
 =?utf-8?B?czY3ZzFKQTl1RUZyUEo4REowSnlHY0VrR3BGUVMyemtRZ1gxWjJ2SlNTNUxm?=
 =?utf-8?B?QWcyU0JIbGV2bEJ3VkloVHQyUFcvcEltd0pEL2RmN0l6TGZsaHYwaDBxL0hn?=
 =?utf-8?B?WlFCQ2NjODFtZ3Y1SGNyTWFUc3RoOUI2QlVQbXJTS0ZkTjdObStEMVR0WDBR?=
 =?utf-8?B?Y25RanRPM0x3bUVhTytNdStTSzhnNnFMdXh4UzdMeEZ0R08rbzFTUHNML3lz?=
 =?utf-8?B?VDdLOHc0UkpyQmtYQUZPWDU4NURCaGFpT013bXdiTzc3UUdxak14Y0tDOEM2?=
 =?utf-8?B?U0hqbHZ2NXRnL29abERxY0NtclpiMFdzQWozb2Nub2RtTGVIZnBKVW8zS1lx?=
 =?utf-8?B?VUwxZC96clJ0Mk9kSjRuVFFFZ0RjcUltaTZZRm5QZkVrY2lsYnB5bVorRjc1?=
 =?utf-8?B?MGdLUTFqRWdDU0tFWlJzUno1YnIxSzNoZUY4aGZOR0Faa0hLTlR3K005OS8w?=
 =?utf-8?B?NEN0Q2pCaXRkMWIrdkdWRjZKazRHMlZ4dmNFN1EzR0lzbzNFRER3cEJqWnY3?=
 =?utf-8?B?ZFpXcU14WWtIZW5INjdvb24zT1YxMlR6UWR2YUQrR1B0K3g0OTA0UjhvUDlZ?=
 =?utf-8?B?RDNKUjBLcno1bDVkYkZOWHpNMTJOdWVscTBUcGNXYWswVXhjWlI0eTErWS8x?=
 =?utf-8?B?V0RpREdSdEdaY3QxNDNSL0F0WWFja1o4SmRwUzEwRkhoV1d5THZLZzQxWk51?=
 =?utf-8?B?Wm54RGcxM2tEeno4K0pnWmY5cFNMNC84Tk1nRWk1cEJnWkRIOVkyZVZ4OVVG?=
 =?utf-8?B?RkpFNEQwRGtFc2wrUFoveE52c0VuODZiRFdHbHBzYklPVVFQR0JTOTQ0V29D?=
 =?utf-8?Q?xNdk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akNQWG1JbHE0SEExTE9nV3oxNGRhSVZqUG1ZWkFJL3UvRHFFUFowbVI4cVZF?=
 =?utf-8?B?RUkyUTdwRnlZQ05YZFE2a1VHSVpFUzNjQzlMK1phK0tvTW9QNjU2QUxobHVN?=
 =?utf-8?B?ZS9GTE4xTkcrMDZqem5Eb00wUHcwdTJzT1dMOUF4SUpCOHArck1RZlJ3ZERN?=
 =?utf-8?B?U0xZdkNsYTQvSDM5V1QvTnRpWllXcG9tQlRTb2dtNFBqYzg0OVlNczVuaDly?=
 =?utf-8?B?NVRXemJydFUxUC9XMTZtWHI5VlVRZ1FuWTlwZXg4OC9nZGJ1WFZNOVNMczBx?=
 =?utf-8?B?WEhaUkV4QmxRNm9nTE1NNi9saDZGdVBRYW5FZlFuMzNzZ2RNenNWYzFmUUhO?=
 =?utf-8?B?alY0VFJSc3E3c1RYcTkwWmtKbVJHUzZlUjMxL00xY05ReVpsRW1uNUtKK2Ry?=
 =?utf-8?B?RGM0aEtFdHRpNTlGRTIxTGVDeFpNckVJWGljeGlwYkZubzZ2QWJnREFxM3Br?=
 =?utf-8?B?YTRBVFVuR0tMQ25ER29XQVptYkxYRVdSbXQxS0dMcHBraXMzYlpoYWpzRW9C?=
 =?utf-8?B?UElqZlpsaXAxci93R1JOQXpNZmM0amd5a1BrY2Z1eitjRldKYmRJODZxMFVo?=
 =?utf-8?B?Z0xEZXVodGgrVmtvQVhCaDRSYkNVSGM3M2dRNUZoT3o5dVVlMjBzRXQ1ZDNx?=
 =?utf-8?B?cVZZcFNJQmllT3VjRmxUQ3YrWDl2cXhVUHg1Z1NUbnZUaFc2aXZtRGVEaDRq?=
 =?utf-8?B?QUVNbVRLYTUwTlVLeUpmRitBRnh0UVBVUXVlNXlQNlluMldBUUhNeEZNWUVI?=
 =?utf-8?B?bFVBekpaRU16bHdlNzROV29SSHdDZ00wSFRKbXU4V24xZGg4NjR3RStTRlBj?=
 =?utf-8?B?RFJoelNjS2tMaEFIbDlOK082YWhjdVVRZ2htYkVHWjdzUkU2cm1GUWRBR2E4?=
 =?utf-8?B?cndTYldSWUhkUlRZNHRJS2lhK0ZxSlpVcDN5elBZUE1KMTlXZG4rUXJIcU0z?=
 =?utf-8?B?dkx1Z2U2ZThjZ1RYbStNUFI5QjVvcSsrOUFsVDlOcitZQ01lSWhDOHB4dU9v?=
 =?utf-8?B?Z0dBamV6OHdlM002VkRxNjRyMUM5YUdMYkd5V21Dcm4rTlVjdlRuZmtQcEdX?=
 =?utf-8?B?cGFhT09xY2g2amt4eDhVSnhIeVdOTVE0Tm1rNGFKOXpTcEFTSkxNR3lINkxj?=
 =?utf-8?B?eGdaOUdQY0Y0R1ROZExTVkpyOGk1SjB1aGFKckovTjV0NFpFSVZJNTdNc3NV?=
 =?utf-8?B?TWg0Z0p1MUIvSCs4S1pmckR0RTFMMy81eG02czg2cVdIYUxmRjNHRHl3SXJm?=
 =?utf-8?B?VGxEcVN2SVU4MmFZNEh3ZFBMaHJtVUVtUG03VFBTVm1xbjFuMmw3UlpzaEND?=
 =?utf-8?B?dEQxUjdscmE4R0lRRTBLT09FV2hZbDNZc2pkdVNuckwxeEl3amZsMmFid0RP?=
 =?utf-8?B?Ky9Fa056SkNvSFR4VHZwY3UvZ21KRDA0T3lNSUZiQmI3NGxjczlrR3lJb2x6?=
 =?utf-8?B?NHl1cXhmNWZBSFU0aUFuV2RBdEQxeWg1YmNkTGRRZkJwajE1Nkk3OEFtS1J0?=
 =?utf-8?B?M3lZZXR5clVENk9EdWpjU1JwdlRWZndYTUUvdkdiTlRlN3BreUtGakhyTFBz?=
 =?utf-8?B?NUdySkZldEREcDZHb2REYmFpeWl6QlB4M1RPVTFlc01NTUpnWURDQjc0eFlJ?=
 =?utf-8?B?ZzAzRmNMVUcvMlExZzVPWUE2Nko3VmdKaWJFbk1QKzJSSURRTVRpTEZMOExE?=
 =?utf-8?B?RU1JYjZkN0NaenhLQnZpLzBlaTBZc3JnaDVwTjZmeXFLL3haR0xsdGp1K1JI?=
 =?utf-8?B?dzNITWg1UW5EbkVNRTAxRzBsZlZQZTVtN25DMERGQmYvUlIrdTBNYnJwNnJS?=
 =?utf-8?B?cVIvdXJxYzB2aVBGczNUYm04dG5CN09qUWhoYlJ4NUxCYjc0WDEwMzR6VGRL?=
 =?utf-8?B?ZmtvRnVPWjY2U1ZUaWZTVHFYeDJKSE15c2VacFA2Q1BoVmVycDFoUjFBYkZJ?=
 =?utf-8?B?R0l3aGdNY3N5N1ZTWG9tZTBaOUR3cmJaR0pBMUtUeGhpNHRQdUVhbDNtcXkw?=
 =?utf-8?B?ZVZ2TVd1RkFRMGV5aExyeGkvaWY0b0lYckVESVZWZEVDbjhuU0lDcHl0cUdr?=
 =?utf-8?B?aFdqTC9nNUp0N1BoRTZzcVBRZ2FtdWEza1hZK0NsTXozQUxWNUNMclk4b0VP?=
 =?utf-8?B?K0wwYjcyQ3RrRzl2b1RrTmo5OWFqSjNnc2krViszWGNxbzBHQUtYYi84RFRi?=
 =?utf-8?B?UHZnTDVhaUsxZlI1S0dPc0R6bG1EOTdaMVQzdlorb0M4bDRqNmhjc3hzUjBR?=
 =?utf-8?B?TGZXRWFMZmJEZHEzM0Q2Ukw1TE54cys3b2cyZWg1bUxUMytuMnpFemdkQlJr?=
 =?utf-8?B?TWorVDRsVGh3QVhESDZGVEw0MTQyb015bGxCWkFCZmY1SmZZSE5Sdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0908f2-d69f-4d0d-3a06-08de5fedb095
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 10:52:40.9551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfgEiVSYExga5Yi/LIr20fG4+E/oM0I5MII6GuVAcvmVqyNSWQs3X8/ggeP+VfAqtpcB+lkiwEaMBaEz77FqPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6723
X-OriginatorOrg: intel.com

Genesys folks : Any comment on this?

On 18/01/2026 01:48, Matthew Schwartz wrote:
> The GL9750 SD host controller has intermittent data corruption during
> DMA write operations, which has been traced to an incorrect burst
> configuration. This was discovered by comparing initialization sequences
> between the working GL9767 controller and GL9750 and seeing that the
> GM_BURST register was handled differently.
> 
> Clearing bits 16-17 eliminates the corruption with f3write/f3read tests
> while maintaining full DMA write/read performance.
> 
> Fixes: e51df6ce668a ("mmc: host: sdhci-pci: Add Genesys Logic GL975x support")
> Closes: https://lore.kernel.org/linux-mmc/33d12807-5c72-41ce-8679-57aa11831fad@linux.dev/
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> ---
> 
> Hi all,
> 
> I arrived at this after a whole bunch of guesswork based on the other
> Genesys card readers in the kernel that do work, like GL9767. I landed on
> register 0x510 which appears to be "GM_BURST_SIZE" and ended up going
> through each bit and either setting it or masking it. Eventually, I
> arrived at masking bits 16-17 which seemed to stabilize writes completely.
> 
> Could someone at Genesys confirm what this register is for on GL9750, and
> what those bits are? At least locally, I have been able to run 50GB of
> f3write/f3read without any corruption while before even 1GB would corrupt.
> This also maintains the same read/write speed as before this change. I
> tried searching online but was unable to find any relevant docs, and I'd
> like to confirm the purpose of those bits before sending this out as v1.
> 
> Thanks,
> Matt
> 
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index b0f91cc9e40e4..a06b0cf11f12d 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -26,6 +26,9 @@
>  #define   GLI_9750_WT_EN_ON	    0x1
>  #define   GLI_9750_WT_EN_OFF	    0x0
>  
> +#define SDHCI_GLI_9750_GM_BURST_SIZE		  0x510
> +#define   SDHCI_GLI_9750_GM_BURST_SIZE_MASK	    GENMASK(17, 16)
> +
>  #define SDHCI_GLI_9750_CFG2          0x848
>  #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
>  #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
> @@ -629,6 +632,11 @@ static void gl9750_hw_setting(struct sdhci_host *host)
>  
>  	gl9750_wt_on(host);
>  
> +	/* clear GM_BURST bits to avoid corruption with DMA writes */
> +	value = sdhci_readl(host, SDHCI_GLI_9750_GM_BURST_SIZE);
> +	value &= ~SDHCI_GLI_9750_GM_BURST_SIZE_MASK;
> +	sdhci_writel(host, value, SDHCI_GLI_9750_GM_BURST_SIZE);
> +
>  	value = sdhci_readl(host, SDHCI_GLI_9750_CFG2);
>  	value &= ~SDHCI_GLI_9750_CFG2_L1DLY;
>  	/* set ASPM L1 entry delay to 7.9us */

