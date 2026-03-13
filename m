Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445E939020A;
	Fri, 13 Mar 2026 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407089; cv=fail; b=FPELLFiBCLzdSY45C2rc7b7WQ3OQfrdFnPQbDC2ZArWyW+ukL4Mcm0ZuR1VDCRXgi4QcTtDu6M/sH5lt3V9y2aHitQl+zdRkEiQpUY/shJkMF23wxZGcKGRsUrilbGMVgtIkvIEDAIbSB1vwMw5gUsWIoMzzKqwaZEjeZTBftJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407089; c=relaxed/simple;
	bh=pknY3T5wPWPhms1/u5TQGpEHHwxI6yCjuiABI9s8jio=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=leBu3LVrwn22j9nST7Klcd5EIHyOhBLgoC9xaCUHUmhvoAorRFQ615dnlwBSZzhUog0npO77uqZofUhMFXDDKhhzh81+wen2WtNBcZnXOx36zmStwJnuNeBL5q1xcqLXhmBd1Z0PoaXZiVK8AhLubl9UYdtQvTcap1Ifay6WC1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bnEM71+0; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bnEM71+0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773407087; x=1804943087;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pknY3T5wPWPhms1/u5TQGpEHHwxI6yCjuiABI9s8jio=;
  b=bnEM71+0nm7zrI6IF9S2Ge1BEql/Fc7k7LEoS2RSf6BeXT2ILKhZlKBF
   E0PYGPOK84wCcyEHK2LebBc4cFPA71MnWEyWBEu0ozDh7JeErA3hiabCr
   d4XJuLirf282qP9p2JOgkDX4j3idOlVslieJ6OAP3MARSHZOJRXiAzudX
   GjdnIkEl6Q3zU8KjRxj4rSg15uExyOcJjYjvStDaYSznRQTeXZNvB9g0u
   M7qoW3EAA+Maj0x6IsmLK77IuoraBZZ5UWD75K7NZ0JImohdNgupWuDgM
   FMPNpsimWfDt0eAGEIuRQvtwnKzsjCDNDQrjYe55PER4Qt3SUZCIa8WND
   w==;
X-CSE-ConnectionGUID: z/QzwhGxQI63jq5cxC2oag==
X-CSE-MsgGUID: bEOFYVbdSa+306WKeSVjjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74592544"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74592544"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 06:04:47 -0700
X-CSE-ConnectionGUID: Qtv8GYu5RV+d6yWJBb0gAw==
X-CSE-MsgGUID: OWo/s/YZQCmk/hDwhV4LBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="225845983"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 06:04:46 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 06:04:46 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 06:04:46 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.30) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 06:04:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5jIcWxhenfSLCA1KlcCnPQjF9qfqFLSqx4Vwl3Qfl75YTFcS94l2ZaL1DR2dTdRCihtpvmqnzN6UkiPyoB01INvnCsyOPAzhzB0SUZetPSNhbgSE1fSkZW/AsWJxFOeHfH647Zw5cUNBULLt0WGXuQlKG/BcFZNNilcfOOQIqoZKraq1GEJgbmPijg3B/odRhd7jfZ4pEnb53cXH5u0IWBMLCVCM7CEkjMkHHvJl5ocyjwcg1af0tceousVsEqIz71+TAkcr1YCjGt4KkQUcoNzz1g426+IIAve9qnYScLBb15MKETC2/lL62rT9y5NjVAfRpu488MEjJsng+/75A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2awkK6C8ovvIISVFzJFuG216hp3TQyDN6oTwTpBc10=;
 b=QegSudpAkQ5OOL9HQQkmXAgJR1/JLHEpFTQkoVDxse39BibFIggcqW3R3DXZThRoV0t2W/6zzBMlua0+yRZNbnJL/Lrax21uLFjrvyvWSv8Cp17G9kuIDa5UqPM0sHsj4uoh5LaPK0nmEnmkUF2lJtxVlE8Cda0SsJ29obQv7cOMauelf7t2PDEcg1xacLgJCu8G0apTcro9gq/zfYZyEHCDozqL5AnjncH+XqHyp8/FmjQt6z0z9M3XvqDFOzh4aRjCc7NFC8mEt05X9SvKeTUe27gSfgXkLJs0vgGJeWoCHtjBq5LZ2l+GrXL6utsEo7/MEaC5KeA0zRGynVE5Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA3PR11MB8988.namprd11.prod.outlook.com (2603:10b6:208:57d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 13:04:39 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9723.006; Fri, 13 Mar 2026
 13:04:39 +0000
Message-ID: <a416dc43-58fd-4462-9ec5-b3dadbbacf8b@intel.com>
Date: Fri, 13 Mar 2026 15:04:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] mmc: sdhci-of-k1: enable essential clock
 infrastructure for SD operation
To: Iker Pedrosa <ikerpedrosam@gmail.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan
	<dlan@kernel.org>
CC: Michael Opdenacker <michael.opdenacker@rootcommit.com>, "Javier Martinez
 Canillas" <javierm@redhat.com>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com>
 <20260309-orangepi-sd-card-uhs-v2-1-5bb2b574df5d@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260309-orangepi-sd-card-uhs-v2-1-5bb2b574df5d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR01CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::20) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA3PR11MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c698ae-ffad-4055-1a4f-08de8101158d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: ZcSV1dzQsnPx5F7xJTpXfjoHTKBYQ/pskAkvt6wgLw0iq04e5wbStnVBFPYcZy1IPs89TdapeveC0IyI8iEmYvn+haAoq2uahYS+ZsgzPLvdjr4wJ5pboHwLXNu/9eTrOfKsQbkp0vZHFlDkrL5sZMsBB+eQUItJOYIbQ01N2FWI1BYgFfUtUkD+IWErmsgkOhO6r3jFdUs7ocPwfk3hSVE49QXToVYOvHxAB4FHGxz1yu3AD9MKEKcNkEzeTwKq/ACE7tA4E/Dl+xeD4uvW1NajZMoAGzmtHFHbXUnDIB2NlZVKZb2f0wsS4SNOOp+cjKH3/sMwwYImnwzTa9rDrLkybxYGuChngq9yu3gxpKlDvxE5Z7AjspkpRm92dEGlY5gt8HFvom8xGAOnTy1Fg8klnaNvpjh2Xb+LMB5BaadD/hiVSj3ZXWQxspu3sU7cgT96lx2T84KoVO8snTY5hVz1EeOUpg71DIYS2Uc/jlmionme+1YCZ6HApofD1qFSwCkrWwIqY6JA//6oMattigg1g2Aku/6b4qK8jggzec+ACuc61v5qDGL10untZRrudl4jf8KHbA6I7iZqpymeEC/CVNpgTThyvpc8e48tSTgAZh6f6aJZYeLUFDsmsOZKaz3hNLFiBtzeMppXYDto53TFk73TfB8fUDsCLGUhaSEoAovzQ5sfbvw/XVLOcjoM9LVbp9JufZLNaF2L5IB48hbv3k8YDyitV3b5LmhONdgw1H46QQQ9AUDTSPpcdjL65weeLgXZn6WxrRzNDSVtUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(22082099003)(56012099003)(18002099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2lDWEZZbWJ0a2kyT0d6MU0vaGcyWGppQ3N1alNFRVlURnFUR3g4enJiTDlU?=
 =?utf-8?B?WU9QQjA1LzZWcGxNZjRPZXo2bEFGME5lamx2c2tydzhEbkh4blpoUFVzTFJn?=
 =?utf-8?B?V1pJQm5SUHFFZTF1QnVQYXVxYUNHTmxKenRpRUYwWWM5dlIwaTRzaURSdHRl?=
 =?utf-8?B?NllhOEh3RHRtVFBWQmRKMVhkdkpUQzM0NGluWEQ1cDEvenJsdUJlTnRYU3gy?=
 =?utf-8?B?Qi9GN002c051N2dJdlRZL0pFdG5uZWUya0ROTWsrbnU1YXpFUmZMdklQNVpa?=
 =?utf-8?B?cUp4aHdwYTFPQ1RHdUNnYlZoZTdsa3llajQ5Z3Q5WjJSK250SlRUZE9BZkNt?=
 =?utf-8?B?NjNXYnQ5QWJPdnR3WHF1cjN2RFZvcGlyRjVPOUJwUHFPK0VOUFJNeEJtWlRv?=
 =?utf-8?B?MXM3dGFjdnJPQzVkdGFuN0c0anhFWDZaZXVralJQUHJEcnQzWmdFNGtMWGFq?=
 =?utf-8?B?Z3I5RklJOENlTkNGWHhVM2RxbGJkYnEwQWZDV1dWbTUrL0IweWFvOUZ1VlY3?=
 =?utf-8?B?eDdIc0VPU2tjcEttZlZjRnhnZTJPL2xaWU5aa1VRanRwOTNYeVpGZ0NBZmZZ?=
 =?utf-8?B?ZE4rY2hueERNckNYSXd5cys0MzVyM1RWK25pYWl6R2d4T3N0TmpleExTSG9p?=
 =?utf-8?B?dFd5N0pORHAyOTdmRkxNc2dhckM4SjVSNE5EZG44UmJrZ3hSTXlPN01iN3Nh?=
 =?utf-8?B?U1g0YXUyTDB0V3haeUhVUGlacExJRm16Z2tLNVBCRU9vT3FjV3E0NjE5RU1E?=
 =?utf-8?B?Vkw3YXZuNklNeUM4bHhaOXlUUm12ZVNRRWZFM1d4S3BXSEtBT1YzWlZWeTh0?=
 =?utf-8?B?d0hqZi9qaG1zS0Yya1FHanBiSG40ZE5TV2lHV3ZZVEZYaExEOStuZmpUMk1k?=
 =?utf-8?B?NkM0WHVJSUpFNnh2RGUwOHVGN0VmSFpMS1NuVDVaUzFWU0pta2Y0UXlNRGRy?=
 =?utf-8?B?QUJ6TXJmQTQxUk1kUnI4Rmp0U3BDZW5QN3FJdm5HUVBWbVZsdVRZR0grWGE5?=
 =?utf-8?B?YjVDM2krQUpUL0NYb2xYb01ndlVDc3JEUERBT3lYTWViVE9TRVdYT2JWWlA5?=
 =?utf-8?B?ZWtBTzVvZmNlMEVsWDMxM0lxaTBOYndhM3RuMTdvZ0Z2Zlg2Z1lEVVZyczlx?=
 =?utf-8?B?VEp4WDdEYmpTUGk0aldvaFdpaDlGU0tES3FZYmtyL0NuUjFnVWl3NmNxVWhz?=
 =?utf-8?B?M0VRUjc2NVlpM0FBUGZ0d0dwd0FOR1JxbFltLzVRVWZkb01Ed0NyK2k0RXFO?=
 =?utf-8?B?bVdUeEJxSm8zbFNDRHo1MytvSWJNZGE2SzhHbWxUSy9SczQwNW9nZmlXTHhj?=
 =?utf-8?B?THlpSnljSEhzRktFdXlGc2JNUWpSSjc2OXIwZWJUelc0UWJoWWgzYXVHQzhK?=
 =?utf-8?B?OS8wQ1Q4ZmRJeFl5YUlqUUo2VnE3dFJBb2FGaEkyUkJrLzV4N05ENU9yVEdL?=
 =?utf-8?B?VkVzbElUdTZJOFBBK3dBbWtvUjNXMFBmditwa2ZSQ2hCVityaXJFeXFVUTJl?=
 =?utf-8?B?TERLSTNKUTZ5SitDbnVsU3dWNXhvNXNSY3ZLSS82eFMvKzNCdElLR09BVmZw?=
 =?utf-8?B?ekM2bkdRN1JtS3JNajRYREIxWWgwb0tZQm1ZRkIva0JFSkdXbTgwK0VzWURK?=
 =?utf-8?B?Z2w4aFVlZzFuWS9FTFdqRldDN2puOGcwZzdwVTVWYm1KVFBCVk8rN3FtSG1Z?=
 =?utf-8?B?WGdIbVhiUm9EejMrcEpCTkVXNW4xL3I2WnQwa2lpVjBkWmhncFVlNm05WCtk?=
 =?utf-8?B?QlBsNWkvM0UxeTQxZWh1SzlsRkYyczJhZk1UbjIvSWx4aU1yR0xtZ080NDEw?=
 =?utf-8?B?cHlwM2pwRFY1T1VVTFJrZFJYK0p2Q293Q2NFanpubTV5SW01bGcvT0Rvam1q?=
 =?utf-8?B?VnFPeHlZNVdHMGlPSXp4N2liY0MyY1hsTGxSNmtvQUR5QnhNMENpaEFLVDNI?=
 =?utf-8?B?S0dQQnA3b3VaeGt5K2JueXFKU0ZMdElDc1MwUFlFYm14M2U4OGRRcmlQbVZs?=
 =?utf-8?B?TjN3eFJEMVhjcmZnMGhIRzN3c3MxbjJSeU1Md2Zjc0ZqZVRSMVQwNStHWkpQ?=
 =?utf-8?B?dklNUENwQlVtbVZCRS9oZ3Q4anRSZjdsMXhram9GVWhwUGhqdHdLWmd4SDJS?=
 =?utf-8?B?cERieWRMelZwZi9YUHZlZnN5TFk5Y0UrOWtEQ0Y2dlhCWGY3SkpabkxoTUV1?=
 =?utf-8?B?VFVRTElra0x3d0FUWHlBWTJqWm1vTW4wakRWT0I0bDI5YnJIOVBZTWhGT25o?=
 =?utf-8?B?blJxWk5rYjFsdmhaOUg1VXliMjhCN0R0SVVhcmhUUkppNWpJUUE5QndzSFp3?=
 =?utf-8?B?STBrcW00cWlrbU81TFEwdi9veXJ2aUdld0FrbWlBdHAyNS9vbzJKeUJ0YzF1?=
 =?utf-8?Q?Pi3+Uxe+0LQ1Dvus=3D?=
X-Exchange-RoutingPolicyChecked: C2h7qy3c80QgEvBweGmQ8KmLfIZpgIJ2Eyi/CdgXL50bzTIxxugIW036fW93iXS79EoCK3kwD8bjF8i95CLMjqhpQ2v+jN2x+62PorzxI82S9ik0uhQCDzvi4B5QxK4iy6A5SL5/rpUpTLsvF4rrWWJVoef8vQySuETms+3yfp/ElzBYFK23Gx/gSX3Pan3kfJgopwKMnM9R1RFz//GS41ANx2EPI8zYCUF5xCEnhe1J1yA+KOY5wsTWyYh5iHqJmQTnShmDXCP8QAucZlwUAqwTfmNAFfxcp1sh8aJTyW6TPDsppBs7Qz3tidOGpT/fGfAYRA8/UizjpDEi5NBrsA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c698ae-ffad-4055-1a4f-08de8101158d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:04:39.3005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0tgxNSrjYp/3+Pz95XLk2BWZ4qyWTQikgRc3GZvsb9LRF/FjxO/sQ+GNtprTH9XXKIE5JpTe48js3jR21q4AUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8988
X-OriginatorOrg: intel.com

On 09/03/2026 13:40, Iker Pedrosa wrote:
> Ensure SD card pins receive clock signals by enabling pad clock
> generation and overriding automatic clock gating. Required for all SD
> operation modes.

Need to say why update to "SPACEMIT_SDHC_LEGACY_CTRL_REG" is Ok for
non-SD

> 
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
>  drivers/mmc/host/sdhci-of-k1.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
> index 0cc97e23a2f9c7b2f9376318a8a7ebb860571504..585c7eca6ebf253aac466dd37cef029deb63f692 100644
> --- a/drivers/mmc/host/sdhci-of-k1.c
> +++ b/drivers/mmc/host/sdhci-of-k1.c
> @@ -20,6 +20,13 @@
>  #include "sdhci.h"
>  #include "sdhci-pltfm.h"
>  
> +#define SPACEMIT_SDHC_OP_EXT_REG	0x108
> +#define  SDHC_OVRRD_CLK_OEN		BIT(11)
> +#define  SDHC_FORCE_CLK_ON		BIT(12)
> +
> +#define SPACEMIT_SDHC_LEGACY_CTRL_REG	0x10C
> +#define  SDHC_GEN_PAD_CLK_ON		BIT(6)
> +
>  #define SPACEMIT_SDHC_MMC_CTRL_REG	0x114
>  #define  SDHC_MISC_INT_EN		BIT(1)
>  #define  SDHC_MISC_INT			BIT(2)
> @@ -100,6 +107,12 @@ static void spacemit_sdhci_reset(struct sdhci_host *host, u8 mask)
>  
>  	if (!(host->mmc->caps2 & MMC_CAP2_NO_MMC))
>  		spacemit_sdhci_setbits(host, SDHC_MMC_CARD_MODE, SPACEMIT_SDHC_MMC_CTRL_REG);
> +
> +	spacemit_sdhci_setbits(host, SDHC_GEN_PAD_CLK_ON, SPACEMIT_SDHC_LEGACY_CTRL_REG);
> +
> +	if (host->mmc->caps2 & MMC_CAP2_NO_MMC)
> +		spacemit_sdhci_setbits(host, SDHC_OVRRD_CLK_OEN | SDHC_FORCE_CLK_ON,
> +				       SPACEMIT_SDHC_OP_EXT_REG);
>  }
>  
>  static void spacemit_sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned int timing)
> 

