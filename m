Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD593905F8
	for <linux-mmc@vger.kernel.org>; Mon,  1 Jun 2026 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305588; cv=fail; b=iL0BPL6EZWs/ENpd8vamH+7o/rI3mm0vXbmc0IImi+X3KV3y7BSeRx7IS1efY5Agg7WSom/382cBn1tgfxB2AkThZzntiTGpgU+n/0dgB9C8LJueGAb3PN/9heXzBlI9k5qDN66WCmzRUaQf0rrRY5ou8q5kgjb5sX81hIxJ1/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305588; c=relaxed/simple;
	bh=F1vimvpHoJJ1/J9EkXrSvjoD97zeJykukdybeqSz2xg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A0HiNWEZ76jdHkrhUqr894o8fUgvhwR2sbw/2vR0Fr6vcUEw7RH53UWxb9y6ZydCV0E9EqL6BHuvYUs56SS+OfNl2B7Gktouexdi0w/7LWmZm/LiDujG0FcIeELLnORdgME7lYQ+D7ufOTGvbtoPhzrABFc3PjQpdy9zVwMeAnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oCl6vseg; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oCl6vseg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780305585; x=1811841585;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F1vimvpHoJJ1/J9EkXrSvjoD97zeJykukdybeqSz2xg=;
  b=oCl6vsegKqSZ/TPYQyhExoq263oGxg6h6ERArtDGx1oe3pP6mIAmDDt0
   2iFkM01x2P8arTHkbMD6acGtoDcqRe8hj0CbJ6D79gEPdJcHV5fMAHMam
   FMJMRvSqaW4v75tkomBz7y+gH2mLgLH3hZ3fHtbCqdtHTsjClZRg2ydj9
   R81wQak+k3F6R3cv3qJVM6eOj1RrhiR0S8ELZxXGYh7al7BaXXg2ZpfNt
   KXhLnMTGC/jvN37uCpMByiTzGctU9Itm7nocO1rMyUnnA5+zKI/29c/Or
   sRDHEhLkbWoJeCRzBwszAm3H9d5zNp4QIsbwB89/M2G4gDeQKfKS86YHH
   A==;
X-CSE-ConnectionGUID: 0xKhjsVETsOuD9yKJcrXCw==
X-CSE-MsgGUID: qzA2iBkPT7arjVOp5eaB9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="98476438"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="98476438"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:19:44 -0700
X-CSE-ConnectionGUID: AiCGuyQvRkmRyf0OBB9CSg==
X-CSE-MsgGUID: LmtpMs1hSc2UBUXZD15Pew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="239114716"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:19:43 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 02:19:42 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 1 Jun 2026 02:19:42 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.52) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 02:19:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1nZr9xGQvdniRBX1KDaORsghLyq7wu+JTIJczX/8y7ChWQk6GRTRSRB538pLZQTymgiHCrIP711jMxb5oF8259KZZUBwKr9KNWEphw9PnlMbWA800FmRPkrOimyY3nGLqr9ADBVYfEQ3x5vYAD2E+xvV7dc7Q4eFTre10jTwfGBSza+VUOTsmQHxymAO2/tnk9+VLe0VoZ30uxtOxIES0SjhF4ie1ZuyHeEfD+h4ENQwD8Rz5EeI95xnuVp/RS7zMJnUyNBq8PQxlo8IywVKvtKOuT+SfMGFd2ZlBTY7U99t8HUByKuV5NZNBLEeZrh9puhedx1UO/bNfFefGInXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gy2qimZkB2a0kB766gQ7INeNqywiVkHN87yq5Hgz+Y=;
 b=TbpvYJVN3z+/ncOKEp5iBwbqfPKPEeQy9i6uoZjI9Hz/p4pVZnYgZuz8SLv6mVQawhlK64EOfUSzAFW30lfZZYUybNMn2rZKYv1VOrxHEnL7MrzVf2ut0ncUAffyzZanldXYzx+7g8jMlgNk96Mpkroy8wLLGZSxA4/uL1Hr2Irw/opKPZbUTJ4rSxMHvBEcIXqrVgn7aycPV97s8SmUbOz6qBGpEEDBIOw3Fl2dxFXsdag58OfGo4FTOOjTNIsTp+6azMirasBioMqCg4WxwuGMUXeBA8ktpnbqP6oqyS7KAh/1xl5sShiE5rS37BVHqRMbmhVikDvfRqTnixd4MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by MW4PR11MB6764.namprd11.prod.outlook.com (2603:10b6:303:209::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 09:19:38 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 09:19:38 +0000
Message-ID: <05400788-da59-4ef8-9c2b-4efff298be2a@intel.com>
Date: Mon, 1 Jun 2026 12:19:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: sdhci-of-dwcmshc: check bus clock enable result
 in the, probe() method
To: Sergey Shtylyov <s.shtylyov@auroraos.dev>, Ulf Hansson <ulfh@kernel.org>,
	<linux-mmc@vger.kernel.org>
CC: Jisheng Zhang <jszhang@kernel.org>
References: <b5dea73a-3c79-4beb-96cb-55d619a1f538@auroraos.dev>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <b5dea73a-3c79-4beb-96cb-55d619a1f538@auroraos.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0074.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::20) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|MW4PR11MB6764:EE_
X-MS-Office365-Filtering-Correlation-Id: 179f626e-0217-4fe1-6fd0-08debfbee76d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: LClDY9Ne5aQpPZNH1nveIl2SBPYxRg8yG43Vv/cFHkU0DD6N4tNgMQqamlzSo35zhUr+nfikQzZvsAHn9TfxPZFrhNt8vWT3Br4CBL+cw4rwf0lcbw7nZut+5X9MfRJh+6NEApSqoh1FKHQcPXFRc+1pRwp+3MJUT7l8KvumjnwjqpbYtDqUA4DKzOWAZYE0iarxCgcGO2jpy7zZIKyT6iSIaW/iG8az87XBszFug9hw8P2m3Q9Zd4DMzAFF4sRF8q5bdKJSpJr5jD+n/F+P34/1OgHLTUIo8WAb6dB1wEy4lnNJkZ+WDsl+IZzf1w+b0q65axoeKk7daciSGhkBOFJHt9qu0yc/H2za4vBecu5DW6Caah9RG277G4qeTFiGmk+XJwGYdW01Px5OfZNb+PSfh1Scyhz0Tg9inmKKwiiEz6+XHCEguU+qHl6KDhlZ5MggrlaPab2CJ1d9l2vnW0+NSwoR1agskdQ3ddKOg+VirlE0ALv5Ln6M/ufpQ/FHemrwlIDHm9NUt8EBVCyl4nTCOUjJXK/ie7a3bY7eivf3DOuWZmkK0qo+HirzDnRnq/sRsnywzTpN6fjkmFZye5HknwkoqDnkRGbfNqTZlYufnaiqPXeQPRYL4ZiPIfT0ZwlcLldU7QEBzieUAGQdq0hGsdaPlCqcT0CNKgYrJxclrizUnmC/zhdQasVQPJ2k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVF4TWtGV25GOVpFbVgyc2IzTXFxb2dkRm5tWDNvSEZ1cjJ4OERXUzNjREdC?=
 =?utf-8?B?SlpPNWxKemx3TWlkTlVRYlZTVTYzRW4vVXprc041d3MzYVA0MmV5czBtM091?=
 =?utf-8?B?NEdldlJsOThkeUlKbXFsQVhHNWlNdVN1R3F2Uks5Ny9BTWlYd0U5L0lnQitW?=
 =?utf-8?B?TmRibzJ5a1BaWWpDUnppVUZaTUEwZXJKQXcrY3lqWG1IKzFQLzI1ZTV2emFx?=
 =?utf-8?B?T3lxdGhBSm5OSlRTNVVWZERtcWZBNEQrUjlaMklRdFhZZk9DdENOQ0xaU1d3?=
 =?utf-8?B?UC82eHZKMG93YStaL2xadjVoOVluekpFbDlFNDhhVVNLcWtPMUlyN1JHbTBB?=
 =?utf-8?B?M2lsYnNtMHhCYWNVS0dpQmdWNU5CREhHYmpjNVRLVVh0cDVMVmJaUXhCRFJ3?=
 =?utf-8?B?bEtaWE5VdkExaFRUa0QydkpyYlI0OG9wRno5cWNOc01ESVloRmYwSmEwbVVa?=
 =?utf-8?B?eWRwWW45SS9sQjFzTVk2OHVyS04yS3VwM1M3OUlQaXo0c2RFOVp3cFc2UFda?=
 =?utf-8?B?dGR2dDR3Szc3WW02R01TbVRsWDZ6a2JoQnZlMjRNcVpuaTNJUzhxTzM3UjRN?=
 =?utf-8?B?VEJsdHM0QWpqMDFmVGNkc2ZGNVpYNnhsd1NiQnluWm9aM1M2MzV2Qlo2UVc5?=
 =?utf-8?B?VU9WQ2xiNTZMM2hVZTBSLzQzMmtUMVRWNVp3Sis1am96WkhTWmZQTVB2NkNo?=
 =?utf-8?B?VDJPeE5MV1IySWZ1VkRnOEtMK0dFMzJZbnFZL0VmWEtuYXVuNUJEMS9Xd0FN?=
 =?utf-8?B?cTZVMGtJWHdQYjI5VUVtVVljdDk2dzNFbkpQOWVscCtwM1VqQlZ0TXkvYmdX?=
 =?utf-8?B?N2RaS3M0Ny9KdEEwZWFzdjdKTzIwRjRlN3AySU85OUZ0MEd0cll6UDRKeHRv?=
 =?utf-8?B?Y3dNS0h1OGJ6dUNzRUhTNlpyakpsVDRiZERVVG1FNUQxZStXOVM0OHZoalNW?=
 =?utf-8?B?Z2EyZ0o5NkhORUVBU2JLdDN3V2h0QWNubGthWUNQYmtkcENqaGhiYlZvVW0y?=
 =?utf-8?B?ZmNzclQ2UkI5SGY4cjhqRXMraXViNmFKcFpmU0Rod0tQMEx2Z1N0WlBHcFgr?=
 =?utf-8?B?RXJSRnRZTUt2eVhRRGJvdTNZenE4TUFYU3Q4MTF4SFNPbzU5aDZtYUNoN2VB?=
 =?utf-8?B?cXNWYytFQTZQTU0yNTVRMnZZdUlSdGJibHpKdTR5clR0cGQ2bG1yc2w0L29t?=
 =?utf-8?B?WUltSDJ3UkdML1lhRkRhR3FJNHRFaHZlS0xpaTNELytKT0dUazRNNlRJSTRp?=
 =?utf-8?B?M2FVZHM1QTZuMHdYOGlqTWNyb01jZTBFQXI2NlhzcXhoOW5HaHlnQTV1M1ll?=
 =?utf-8?B?dTNOZ3loYithOVJLUktOUFRmd1VCSitmajNxa0Rlem5YWWUxY3lJM1NJNG9V?=
 =?utf-8?B?WHdac3h0UHBFUmxSQldOb1Buc3BqSVlJZE1JaHRnWjltRHpLalFuUzhRRkpG?=
 =?utf-8?B?Zlc3UW90L09PUkxya2NNZ1M3WTN1bm5scFhsbzErdmJZRjc0U2kya0s0ZWtE?=
 =?utf-8?B?L3o3Y00wZG12U0RLQ2d4aEtsWkR6bHgrSVpaN0xkZ3hGbkpKbjN4WmVRZUUy?=
 =?utf-8?B?WXloN0hpTU9ScDBNck1teklvZzhFOStiUENRQWNlblEwSTZUVkoyTmtxbzM0?=
 =?utf-8?B?RElPMEpkZC9FbkthRmtwakt1dWdYQWsxZDZTMWtrWk5FSXNobk02cVN0QWxw?=
 =?utf-8?B?ZE9sZytlcnZHazJlQ1RSSGJuOEdRVzYyam5qd0s0UUQ3NlQ3K2dncE5NYUlU?=
 =?utf-8?B?cTNLMStDNmlKMTdxb3UwcDM4dHpMY0RCVERuSXljRHl5aXZ5MkdoZmZxRk5S?=
 =?utf-8?B?NmsvakJwUXpxdnRtYWFVVm12MDRrdzZGOE5EeVJIR1FoQjFTOVV5RFlnUmkw?=
 =?utf-8?B?UXZIWFpndnhleGRML3c3UDBub1ZPaUNEbzhDbUg1WmZkZzVVREk5aC84YWVx?=
 =?utf-8?B?Ti9kSVZ0UHFSYXhNMHNNVTBseHZtNVE5eU5FMytWN2NBTFRqTHBpc1JUNitj?=
 =?utf-8?B?UkErUWdoQ2FSZUNQS1hWVGlQTFZuNC9DaWhuc04rbnAycGV5U3NNajJUY0dm?=
 =?utf-8?B?YzQvaGdXZlBuTGhmZFJVbm1JamhmNEwxM3Zpd1FNYUtFcmMwMDUvVEp0Q09W?=
 =?utf-8?B?dDkrY0t4aEttL0JxQytzQ2VTallIaTJHOW5tc0N5bDZWNi9OQXRPQkVNQkNz?=
 =?utf-8?B?YmRpSnBzdnBnRmhnWVRpR3RTQmQwdVFLeWYwWE1EQmU5QUxwUG5LS0djdCtl?=
 =?utf-8?B?S1pPck80SGp3Yld3YXJlRHdxVFNSdHVmcU1mQmhSWmIzdXNCZFJaOWNXL3pz?=
 =?utf-8?B?UU1xc2E3cG0ydFZOOTdpeGtoMTBkMDBnSHNoOHdjeENtOTBFM2ZhbHZPZVVD?=
 =?utf-8?Q?mlW60Sf0dbTRCfoM=3D?=
X-Exchange-RoutingPolicyChecked: CPupxNdW1ZjfeopRsMlagJb0OIqZnHj0zs0Ql6IJIojIg68VrBOFeS+imtS8LnubWDOAz02FzBpEVz0Y30fDQ9cytUKsJUltzksSr83D+jZPcuPs5Ko6VBrJ8HYDly69ePFM0AVrKfM+WE29VZHRHJgH08Pyg3sEstTMuar71Fhba1eai8Dr5Tqte2OD3n3mvrsR1f6wsnPccB0pVSR4qJ1LH/4JvCGobSku1J5eBJBG9LUNrPKARVYFvetx7d4Erdc7T/PNw9grLFXqdazjhqObv3wFR1H4ig/95BmTPXMfR+uqdGHyOfBMMfJqFqGXtuKsS+Z4lC4iUgMKZr+qXA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 179f626e-0217-4fe1-6fd0-08debfbee76d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 09:19:38.2644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9MWS2EOfiFfuuKqprxtIWBrkogrQsBkepYC7ufVnVGdn0szVlO/5VTVg45iQ+02KjJe9LvIokiZSP6smkf6ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6764
X-OriginatorOrg: intel.com

On 29/05/2026 23:28, Sergey Shtylyov wrote:
> In the driver's probe() method, clk_disable_unprepare() for the bus clock
> is called on the error path even if the prior clk_prepare_enable() call has
> failed (and the same thing happens in the remove() method as well) -- that
> would cause the prepare/enable counter imbalance.  Also, the same problem
> can happen in the driver's suspend() method; note that the resume() method
> does check the clk_prepare_enable()'s result -- let's be consistent and do
> that in probe() method as well.  BTW, I don't know for sure what does the
> bus clock control -- if it affects the register accesses, the driver will
> likely to cause (e.g. on ARM) a kernel oops if it fails to prepare/enable
> the bus clock in the probe() method...
> 
> Found by Linux Verification Center (linuxtesting.org) with the Svace static
> analysis tool.
> 
> Fixes: e438cf49b305 ("mmc: sdhci-of-dwcmshc: add SDHCI OF Synopsys DWC MSHC driver")
> Fixes: bccce2ec7790 ("mmc: sdhci-of-dwcmshc: add suspend/resume support")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> ---
> This patch is against the fixes branch of Ulf Hansson's mmc.git repo.
> 
> Changes in version 2:
> - mentioned the problem in the remove() method as well, somewhat rephrased
>   the patch description.
> 
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index b9ecd91f44ad..29af07561a86 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -2441,13 +2441,16 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  			return err;
>  
>  		priv->bus_clk = devm_clk_get(dev, "bus");
> -		if (!IS_ERR(priv->bus_clk))
> -			clk_prepare_enable(priv->bus_clk);
> +		if (!IS_ERR(priv->bus_clk)) {
> +			err = clk_prepare_enable(priv->bus_clk);
> +			if (err)
> +				goto err_clk;
> +		}
>  	}
>  
>  	err = mmc_of_parse(host->mmc);
>  	if (err)
> -		goto err_clk;
> +		goto err_bus_clk;
>  
>  	sdhci_get_of_property(pdev);
>  
> @@ -2461,7 +2464,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	if (pltfm_data->init) {
>  		err = pltfm_data->init(&pdev->dev, host, priv);
>  		if (err)
> -			goto err_clk;
> +			goto err_bus_clk;
>  	}
>  
>  #ifdef CONFIG_ACPI
> @@ -2507,9 +2510,10 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  err_rpm:
>  	pm_runtime_disable(dev);
>  	pm_runtime_put_noidle(dev);
> +err_bus_clk:
> +	clk_disable_unprepare(priv->bus_clk);
>  err_clk:
>  	clk_disable_unprepare(pltfm_host->clk);
> -	clk_disable_unprepare(priv->bus_clk);
>  	clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
>  	return err;
>  }

