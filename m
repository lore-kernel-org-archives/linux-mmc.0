Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E8A2D3A7B
	for <linux-mmc@vger.kernel.org>; Mon, 17 Nov 2025 10:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374955; cv=fail; b=cwlUvJEkcroMgv0GgDlWt0zVfFoiuC1Qdz87j/SlFFgymCCyYBEpGkVGD4N0cPNOceaHo4BpBojAJRuKYY2uorwvxRXQRy5L/kJ+D0CRdYhiTF7wI2JYO+rbhgArn8jJkYKi3S1bp+NjIu1qndxTRNVsihu1N/4k0wO9lO5tEZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374955; c=relaxed/simple;
	bh=78hYZt0OGky7v50EoIt40qBolnxTglx5nRi0bihuo4g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NUfHE+TCnzMecbPpDvG49vkPby5w85WeWinkkQ03nIHpTIXCmQRw4zEWWXWtQwPOU0jcMSNaUXvFwffp8Zvt1LsReJ42KnLOhUvlrLTd+CijwUi4iO+1M5YfpDaCW7Lx8QWSp0BguqHjn9fsfysVs1vc+M3bqn3FrE4X7Jgjj1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZR1ZeVoF; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZR1ZeVoF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763374953; x=1794910953;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=78hYZt0OGky7v50EoIt40qBolnxTglx5nRi0bihuo4g=;
  b=ZR1ZeVoFhCj3oWVqj3RuCsaOtpmaahY2dFA0U84w7DQjHdYuRW5vWxqi
   1okmbMpWuY0M7+4OhfA8vDPMdkq0X4Pm6JisP7ogEYzpYhDsciOx+DTkP
   dLe8zCLggXXm5yMMlOWoRWxCJGvUep8PkvuapGTHlkIRL5Z+otZgR5vsG
   QUB3lZquIB1OLj2h73jb4bcwqoC7x0wvkiTD2S5ruh/CBKch/WxA8sIEJ
   pn+PL5gV99nsFTu/mjpzlTotZVDdN4bOr5M6ubevWnFb5n0ZovMS3Il+/
   Oo+AVLrod3KlKWICGj+rTJIYAky1pz3pwrLg85x85mpLzlHZf45JpFKsy
   w==;
X-CSE-ConnectionGUID: YFDP7hx5Qs6Dy0w0FXHUdA==
X-CSE-MsgGUID: 57VVcWd0ScmbbTLtbcFyRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="64574471"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="64574471"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 02:22:32 -0800
X-CSE-ConnectionGUID: YQIF8Q7vQauWHBq7kg2LFA==
X-CSE-MsgGUID: TO6iLPZ5TqqBZYM81T7KdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="221054821"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 02:22:32 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 02:22:31 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 02:22:31 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.50) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 02:22:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huMLzoGq5+6rVux834+SDyJLpPW3GPDyJ6KnJ7LVAWBae1UrEROVR8brOyhK341tFcUuirRwY6PYDdHX7jg1oIRzhPYqX0oWjKH+D0Zn0D6qKETLhZy03i4c4tIbz21vkQzMaYi7Yf0oaZ49+rj0WWoeh5L1Gp4gYwTZciw1SJp33PmQReE7szSkErqJ86SFAAMZbCuDC7fUmi9rtLWVJspxd0u8EdHy3xxCt71B7YlyGePB0FbrnDnlt8lVp1r3EE7JONYz1SdoY+KYg8pd0jKfOyUgDtkYJH2XWYXTCygaPuJc2+6FEG3ontMmSZwsUYobIjbw40U9FKt6QK++aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVPmeW73Mw/hl9msKz3xlMB1KzJ24IndgNUD6e5F598=;
 b=cHpJR7qTaF4i8ODzYJ9K+Es7YR+UFMqgQLtITlwMJTKh0zcSkVFcBkpyYMmlJJYm4CSsf74ywUJESQGwlW9h2NnDrZc/EDnAbRa8Y5c+BtfTUtp2ZfMsjDnbv/tyzzRlXBQjqF2lJdcg/WpqtalYAwllVnsboS45M0bFsyZhN8ibl094i/S2fSOqocOWeakluBoEftP8U6Z5GRMdSl2z/mrQ5CdARz0W+md7iOHweiVQzOBLT96JbL34OwrQ0UpoKzrFB4JWlpEfBQI03PD3+LHv0i6pytbHT3LIs6+qCYMPczGrMsc+SfnTykviNtZFh1JWzgvzI94z2ojvnp9jkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13)
 by PH3PPF55C5E51F2.namprd11.prod.outlook.com (2603:10b6:518:1::d20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Mon, 17 Nov
 2025 10:22:29 +0000
Received: from DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::9201:63e9:3175:5392]) by DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::9201:63e9:3175:5392%5]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 10:22:29 +0000
Message-ID: <89415639-96a6-4d85-bdee-f7364e4d3354@intel.com>
Date: Mon, 17 Nov 2025 12:22:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mmc: sdhci-of-dwcmshc: reduce CIT for better
 performance
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>
CC: <linux-rockchip@lists.infradead.org>, <linux-mmc@vger.kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>, Asutosh Das
	<quic_asutoshd@quicinc.com>, Ritesh Harjani <ritesh.list@gmail.com>
References: <1762933460-204066-1-git-send-email-shawn.lin@rock-chips.com>
 <1762933460-204066-2-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFqAwP=SDrQ_umkYk0qA50rVt=WJ5giDt8mt+RyBSCQDpQ@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <CAPDyKFqAwP=SDrQ_umkYk0qA50rVt=WJ5giDt8mt+RyBSCQDpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P250CA0022.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::6) To DS0PR11MB7215.namprd11.prod.outlook.com
 (2603:10b6:8:13a::13)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7215:EE_|PH3PPF55C5E51F2:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb95507-7a81-492e-2772-08de25c335d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUZPNVJJZHc4MUhpdVRQUW5Td1ZYWllObTlzRW5FUmU3NHFTK2daMVl1eFFh?=
 =?utf-8?B?bW0wbmozWXZnK3QwMWtFT1oxQ3poOWd4UGlPRG85YjlQREpieDJ2RlFXYmVp?=
 =?utf-8?B?K3p1Nmtrbk40eXBUNUtHSG8reXlLdFowZms4aWFoaFJud2hTK29VUEEvcTUz?=
 =?utf-8?B?MUdCaFhlbWtsZUFUU2pLSVNjUlJFTkFMMHBSdTJyMXFZbDNnNEJaWjdjdDZG?=
 =?utf-8?B?NmpIYnc4S2VQZm9vT1dNckFjU2xPQm5sQ1pxOEZHR3Bxck1TQTlBTFVUZVlk?=
 =?utf-8?B?ZVorczlOelZlOGZmSTRiTGlRTlBaN0c1OU5FWlFNNUV2VVVJOXIzb0NveEJK?=
 =?utf-8?B?dUFleGR0dXlTV1hwTHpFVVo1VWtoWmVzclFuUWVYazA0NGZLMDFSdTkxNVRu?=
 =?utf-8?B?TEhNYm9FMHJQR01Cd3BBZXdFbVNJTVdsRktuZEM0VVhCaGY1aXVvSy9MaXYr?=
 =?utf-8?B?MVN0Z0VhZFV0ZkoxSXJ1Y2ZoMDBXdVA2WW5iTm5yVng1Y01mOXYzcVFraHFV?=
 =?utf-8?B?aUk5R3hQWnNiNG5veEdlazhYSmRtaU40MGVVemsrbEFQeGNOQWNsbFplVFpo?=
 =?utf-8?B?WkIrdTlrUXNCcFhKYXJqRTJ2Z3JGNTUweEFGekNTZEdJVE9KSko4VWgrVkZC?=
 =?utf-8?B?YlUxVTJYV1UyL25UWGRmdHJtalJITDlnYVZyUm5nNnJLczExMUg2bW93Z05v?=
 =?utf-8?B?RjA2OW1MemlhUm1YejhkdFVBdUxJNDFST0NvQVdUNHBubTR4eWI1M3UybUZ5?=
 =?utf-8?B?S1daZHNnOXhXMjArUHU1Njl0WTUyaFpibWRMZ0ZsVllIUTNXNHlZVlhzR0JV?=
 =?utf-8?B?WFp6cTBaSk1UUTk2Ujl5a1dsRGx4SytzQzAwL0JDOTl5dG9Ibk5YNFhka2Fn?=
 =?utf-8?B?QlgyeWZScXRGb2xyWDlCQkFPNWdieWFiS3U0dGNiVEVFVy9FUEJXdldmTnRR?=
 =?utf-8?B?WFZNVWRCdW9TWVpYdUVwSno0THhpK2hQS1JFVXhQdGNZaU80YVR6Z0hpWTQ5?=
 =?utf-8?B?Z0xCWjFUUmNCQlNIcTc4Yk5QKytSUDE0Vm1aMGtJNnVneTUvVUVMRkVUVis5?=
 =?utf-8?B?UVBJbHlBdGIzUC9zZzdMQjhCTG9HUUxEam05Q01ZbkpsSUYwQzBBRmlUL2xt?=
 =?utf-8?B?Rm9Na1Y3QjgybmlOd1ZGYTlRNk9tRVR3YWI4UDM4RXZNWG9ta3JVbzdZUUdK?=
 =?utf-8?B?cmxqZzJ4SmZCN2NUb2dBa0ViTkxteWU0WmNnVWM3NjJQZEV5Z2cweFFZdnY1?=
 =?utf-8?B?MXV4ejg0VGpIWHdtS1VkN3NuTkNIM3JLdzI1MWVEMURSM1dPcmdFMGVVYTlj?=
 =?utf-8?B?Rjl3MmVDSkpBSFk4WElveU1ha0ZnS3h0QnY1c3lXa1NiOHV0UjBweTdPNFBr?=
 =?utf-8?B?MVZUR0N0WG5uQTNHS0U1Z3NpS2Jwa1d5K2szc3FkQWpWZDdpcC9TdktnZkl2?=
 =?utf-8?B?WHRYeXp2cHNRUUJaY01mRmdjRCtDN0sycHhudHk0UmYzbHd4V3EyMjRwSWpD?=
 =?utf-8?B?OGxRNU9oNXJyUDlKSG5Ja2xKdFpDT2tJUmNpNHhTWXJ5d2ZGcjVlTjhuaHZy?=
 =?utf-8?B?U3Y4a3M2b3JYUm5aVHQ0TVZzNllwV2ZVN21tZnMrSmpWUWwvaWZWTk5lcXpr?=
 =?utf-8?B?YUZKVERtMkt6QVN1SWE0eVU3UlBSZzBiSnZCZHdoZEJCTTY1WDVPQVpnanNq?=
 =?utf-8?B?aHE5SmEvQUh0WmJyVXQ4Z0xHeDFCMjF3OFRnMUc3QW1sUEJqNS9QK0c3VDU1?=
 =?utf-8?B?Mkl0cjhDU3FEU1ZORkMzdUl6a0tmc1FVZnBWQ0ZmUVRsMFIyU3kwaFN0ZC9Q?=
 =?utf-8?B?QU9GRjdQRmkrVHpaeW45c2p0aWRJNWx1a0JRYjhwU1VRSk1ObW9lVmJycTBr?=
 =?utf-8?B?cFpWQzNlV0RiR0hUbFJqZ0hFRERBUnQva0FCUVp0U3lXWjZJK2ovRzcwQTZL?=
 =?utf-8?Q?fmG2dgcjijcgiqcC2OoZp0m2yuLkSs04?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7215.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGE0MDJGSWxkdmRybFZnaU91eklzeUcvaEo2RFZBWFZUS0czR3EzMEprdHpP?=
 =?utf-8?B?VUlHSWlock5kTUlrWlZZVmVBNFR2YkRucGN0bEdOS240K252WERoYWg3d1Vm?=
 =?utf-8?B?ZVRGQWw1SU5jbTJRVmRoU21ReFdNYVZlY1B0MWFzakx5Qnd2a1Z3eXpRSmNL?=
 =?utf-8?B?QitzUERUUXZiZjNNK1JKM2w5REtpKzBCSXJ5R01IdTFQMUo3T09aWnRTT1Jp?=
 =?utf-8?B?MUdXKzIrSDlzRGxyYmthSnVhRXNIZmhhdUNrd2Y5T1BQa2JWNTJXZ2sydUcz?=
 =?utf-8?B?emwrTFlSQ3ZCU01YclNvcXp2NHNkODVxWm4ycEF3ZVQ0WFNXSzNTMHp4eHBK?=
 =?utf-8?B?KzRROHIrWVVDQ0RGa3N4VXFEUUZJZGFtcWtYbzBBQml3dE5BNHhYQzBEa081?=
 =?utf-8?B?SW9IbU1vZlYzelN5dVAwZGFOQzVBU1AySm1yMER2YitZanJNU0UzZ3Q3Ny9C?=
 =?utf-8?B?b2l1clpESmM5VWFBNjJzWHNBclRaTlFFZHFqK1poUmhjT3hTR0EybVJIWUlF?=
 =?utf-8?B?ajFBNFpGOUlqR1gvcEsvN1RGL09OdzRNZmljVVU4ZU1jOGtPZ1V1TGVLM0NC?=
 =?utf-8?B?Tmd2UmZKZUZMUW45SFY5RXZIY0dXeUtUakJTUDFWSXlSakpoWUttanhsNUxz?=
 =?utf-8?B?U3p0YjBGa2dESFNxYXdQVHdOcWpzT3VSYmtMYVA5cTJCcG93VWhxZjN3amVH?=
 =?utf-8?B?c2VNdGIvNHk0QVp0QlVqb3ZVcEczVVVudEpXTU5LNzkvVWhVUnp4dXNoT3Zs?=
 =?utf-8?B?NkN5YXNDNjlMZ2tXektrNW84RVArbnpsbUgzMEFnZklxbEtvVGU5ck43WHhw?=
 =?utf-8?B?WWJuTTVackJBZFIwWjkxWC9jbDVzT0tPVGtDNENHYWZwdG5tbUVMc2YwRlQz?=
 =?utf-8?B?eUYxUzBDdVdVc21QemZTMmZTeWlMUFl2MXhORVoxamZIYTRXZytaWElGbnRh?=
 =?utf-8?B?MWRocnBlUkc1MU5TbENBZXhiZkltdkxqM2s3SWVHQlRxbzg1Z0hsdVFxSmlq?=
 =?utf-8?B?NVEyQmxKVk1YRE9PU2hVSWplYUxEUW1GV21mS3BpRnNOMEx4TGcyd0NCbjE1?=
 =?utf-8?B?L256QWtXRlhTTGE1amdYOHZ2MHBqWlRYMGJiYWNQZWo3a2ZOSXJtdGlkaFkw?=
 =?utf-8?B?dTJyRDFRckJqT3dZclFYaDRHU3FQWWNOaTFPZTQzVmZjb2ZxRlVwV2pCZU1w?=
 =?utf-8?B?VmNtZkthUlN0ZHJrdWUwT29wbW94ZzlvWWV3VU1EUmMwZ0NsYlB3Sk5DemZD?=
 =?utf-8?B?OERVOXQ1UU91d3dQSjRQZUgzZnBFbGZsV3lQUWU4elRXVzhsczEraVo5Vkg5?=
 =?utf-8?B?cTFHYTVHVXVFZ2ZWZ0IxclpzMTc2b01Rb1U1akxiRVhPMlNjYWN2NE1EZk1w?=
 =?utf-8?B?Y0NaUE5lMVJmenI5Ujl2M3h0Y0tGWFc4NUdndlRPMmdxRVM0Wk5iSUkrSnlG?=
 =?utf-8?B?TkgxZWw1VXFNZEpqMzI3UjBuSFA4cU5JU2NzWk5lb0dOeW4rdUx1dlVrSVZy?=
 =?utf-8?B?dEh1TTBnZkxvdlJ0bDVhdmJraXhtWkxOTHVEQ3pEdXlCYmoyMGtxV0Q4K2h1?=
 =?utf-8?B?Uk9iOGwweFphL3EzZTl4UE8rRjhHMk9VNm95K0hwWk1HUlBDRHdnN1JBcHR1?=
 =?utf-8?B?eVp2dk1vdzU4ODBIdVJobmpweHJmcUgwYWdOSWNKbzU1eW5kQjhlQ3NZOXBJ?=
 =?utf-8?B?SDBpcy9QRHJrc0ZrWUFkbC9IdFpwNEE2R2pwNWUzYTIvR1VieThjcTRTOFY3?=
 =?utf-8?B?cmZxTktKOUxYQjJrVXliRW93SnZ4TWlmQ1pZbGljaFZWWDBxSXJUTE9Cell3?=
 =?utf-8?B?ZUxHeGl1cElXUVQwZEt0QzB5ZXluOHhDYThubTRWa0VzUDhXMmh6VUJtZEZ2?=
 =?utf-8?B?L2lwNWJYd0RkenRzYkJmV2VFbTRZcE10UDJ0Sk10R0JrRGQyWXFRRjc1WkhD?=
 =?utf-8?B?aTExTVhCeWgyZkRGZ1llZVBxVVdka1IvcHg2dDNZU3c1dlVUT1Vzbnp1Q1Vm?=
 =?utf-8?B?b2J6Y043ZGNBS05NdnBSRklRZWhxUGpYQWp5bFZaZ2VxbnY2ZWpLQzRBQTl2?=
 =?utf-8?B?RmlMZjk1OUJqOTJiQXJQS2dIVWRERjNEQnc0akhIbVR6VHRWdXZ6MWxkZW5w?=
 =?utf-8?B?alUyVFIyNnVjVy9sM0ZUZU9iZldBTUdBTTRVeFVhcUhJbUhsV2pKY1E1SGRS?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb95507-7a81-492e-2772-08de25c335d4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7215.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 10:22:29.0512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUPfL5ixAZZzC8AEOv80EpIZXLmAhPL0HU4ZH8nlYnGIyZemPc5EhhxF8LEoLVgd9plupvL+C7ZHbGRL3B/O6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF55C5E51F2
X-OriginatorOrg: intel.com

On 12/11/2025 14:03, Ulf Hansson wrote:
> + cqhci maintainers (Adrian, Asutosh, Ritesh)
> 
> On Wed, 12 Nov 2025 at 08:44, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>> CQHCI_SSC1.CIT indicates to the CQE the polling period to use for
>> periodic SEND_QUEUE_STATUS (CMD13) polling. Some eMMCs have only one
>> hardware queue, and CMD13 can only query one slot at a time for data
>> transmission, which cannot be processed in parallel. Modifying the
>> CMD13 query interval can increase the query frequency and improve
>> random write performance.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> No strong opinion on this, but I looped in the cqhci maintainers to
> allow them to chime in.

cqhci-core leaves CQHCI_SSC1 configuration to the default values
or for drivers to set for themselves.  When it comes to timing
values, eMMC has not really been one-size-fits-all, so that seems
appropriate.

So for both patches:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> Kind regards
> Uffe
> 
>> ---
>>
>>  drivers/mmc/host/cqhci.h            | 1 +
>>  drivers/mmc/host/sdhci-of-dwcmshc.c | 5 +++++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
>> index ce189a1..3668856 100644
>> --- a/drivers/mmc/host/cqhci.h
>> +++ b/drivers/mmc/host/cqhci.h
>> @@ -93,6 +93,7 @@
>>  /* send status config 1 */
>>  #define CQHCI_SSC1                     0x40
>>  #define CQHCI_SSC1_CBC_MASK            GENMASK(19, 16)
>> +#define CQHCI_SSC1_CIT_MASK            GENMASK(15, 0)
>>
>>  /* send status config 2 */
>>  #define CQHCI_SSC2                     0x44
>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
>> index e276a4e..cad5165 100644
>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
>> @@ -631,6 +631,11 @@ static void rk35xx_sdhci_cqe_pre_enable(struct mmc_host *mmc)
>>         struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
>>         u32 reg;
>>
>> +       /* Set Send Status Command Idle Timer to 10.66us (256 * 1 / 24) */
>> +       reg = sdhci_readl(host, dwc_priv->vendor_specific_area2 + CQHCI_SSC1);
>> +       reg = (reg & ~CQHCI_SSC1_CIT_MASK) | 0x0100;
>> +       sdhci_writel(host, reg, dwc_priv->vendor_specific_area2 + CQHCI_SSC1);
>> +
>>         reg = sdhci_readl(host, dwc_priv->vendor_specific_area2 + CQHCI_CFG);
>>         reg |= CQHCI_ENABLE;
>>         sdhci_writel(host, reg, dwc_priv->vendor_specific_area2 + CQHCI_CFG);
>> --
>> 2.7.4
>>

