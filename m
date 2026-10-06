Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E563769E6;
	Tue,  6 Oct 2026 05:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791266328; cv=fail; b=iJipe6yg2tabBhmoEedgL5O8JYhkccTXgl7QWSfJRjFAgm6juq6NDrYrAxPZBIz5kVzyzQrrAnWKqgcG38QUfSCJJNXamBgFrTG3H71uGaSio5EHtsE1yJJAV7pgM6kQ/P4od+ISNzZ55UvAsi0xfE15zXRuMbTDkMOiUk0Mu0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791266328; c=relaxed/simple;
	bh=6xlS3AHX355PNrepl2e0dBnsm51cDCGxE0CFJxELYPw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ioXTgYbfi6P7+snNACIBFdjWs30ahBb8ISnqc9bL1BpsQyxntkGrhWKvaEwea/Zgm26UYJiiLSqZ9CivpRk0veRsX9MlsL8urGWHmXs9yZZ0+9eqeC5XwvXI0zo3V2/imPevCeFmlMFpi/72u5ErMRlRFnosnXCXijSvbO21PkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YQPRSG51; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YQPRSG51"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791266326; x=1822802326;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6xlS3AHX355PNrepl2e0dBnsm51cDCGxE0CFJxELYPw=;
  b=YQPRSG519GCVjCdNJLtlyVeJ4U+aQi/byQZWMW4u1XV4k8S787hxUul2
   XcYPsgtsVkPJtplaPam3bjXYdvtbat3Q/LK6gr2rvMBUnCU3GaIOL5XCh
   fbvTkikZf5ix1xfb7Z6pLRgMtdX/eRoOmPb1MjeXr7wNhEb2gtSt2CXWe
   FeDnF7j8oej+0Wz8n8CZxOp2foEQJYktCnfRSBVxNAX1k9zHpIY6oD9I8
   /6/Vt+qj/3wXn+gJ4hM8Be56M6UviD1jzRKAkwATinsxmZEwfjhx+B8Y/
   XQYvzk2Cg6hOaoV1jm1x7N5B1zftmoMScatQzMNPLMrGHR5tqlAvvy3WS
   Q==;
X-CSE-ConnectionGUID: ln8atApJQ/yfEu/jtQeFEA==
X-CSE-MsgGUID: lcUc8ESlS/mf7xxqr9QIyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="101266670"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="101266670"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 22:58:46 -0700
X-CSE-ConnectionGUID: nOLmMfvhQBepsZbqi4DpaQ==
X-CSE-MsgGUID: NxpO86W2SqKlola1A/VBeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="303325256"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 22:58:45 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 22:58:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 22:58:45 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.48)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 22:58:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdkA5IeWSEZOqtiVPGX7zEx1q46KG5YMWPedloRR3F7VgCVmGPe3/NJmLd1XlwQAmRopKRimqQWmndy50BF3LHZoTh0wTsCNPKcWRW7UIDfMPSUN+Qst2IBVLeUChAk3E9oDPhqR0nnxIMmytKOpbe5x43LiQFfzMQQ9N112RlyeolLtObV2SylB+U9a9dKYM32Y0WD2RlJZHWvlphdGFF8udj4H+Zjhhut2dXXwjoMCvi7IG3MvtJn6v1nx964W0ravTeUCdAxWX86dMcbVgEXfnXI6EYtdXBTW7KWfv79xg42Sg0WXeEiBFlL6vPjrGJuAlqLd7qYylpI0gROuRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+WCphVAgu5L49KIyXVKeRGZGZbw6h0ZkNb/+QHTjsg=;
 b=YaHeUjE8jDtqqRiXvY3p5Blgzjo7CpljBnTA7OJ6ZbSBP0ftoChbz9Hwm3pfs4pzMKE5MggG/DnvMjMohSMDPdSBR8/RB/PSYpgei7i9KQViRGYQkGEyOGZGUU2hHh4zjpLMjF1xpgNl6Zf/kLhlPte4LkJuLmrig+pSJVJy2X3N8oYr02x7e2IHmjilTqENjr1ONE/zYsSuNjfbzkOzii8+VOsoS8lFUq6ntWNQbWP3XcmXsUVzTOiHC0HaNJ0yGLsT7N3PkChj0QBcv+TH6YWn2WS1n4N/5Ydqc0EJ03UGvn43l1tcaHDH5ETmhXYcejsJGwpC+BmRB7qUH0jqbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA4PR11MB9322.namprd11.prod.outlook.com (2603:10b6:208:562::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 05:58:43 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0472.015; Tue, 6 Oct 2026
 05:58:43 +0000
Message-ID: <79fca026-b992-4490-acc3-845f2a3a5e6f@intel.com>
Date: Tue, 6 Oct 2026 08:58:39 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mmc: core: Use the ios vdd when calculating vqmmc for
 3.3V signaling
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1790742751-245571-1-git-send-email-shawn.lin@rock-chips.com>
 <1790742751-245571-3-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <1790742751-245571-3-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0209.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::22) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA4PR11MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: 84148caa-007c-4122-dd53-08df236ee078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|10067099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: O9AIzw2v6lQGXBJSDsvAwez8X5ygt1xtHkEi/dRjrWVuavmS4HfsITta+jtGvZTmuTNDOLjBWs3zNsaAfStNpfExpMu/uJSp6JJzivfNapxAEEI1Aecj5BFaz1yHF722EBe7dA87pSPssICiIbrZ+knQupw6sWhttXhI/wGxfbY9v/EXglwVVUgZlE4UAZLwE1QX7976zvKzyOePdAMsg2RslwiKzfWx0dJf2wDezeg6ihNLgR7FqNacydMNpcDjCI3DqiZg3Pr8DExUNaoXE+AeCsuwem/qP6tS3UH1koKffcIZKcXRBbkhI9SXevDwWE/JXA39WWzgEFJJeDAzXB2pcZ3SBRwQ641BrtYdhnoBCX6CHsA8KuqfxIfe/n/7tZ3Lpt6ZCcXaelcf34wRJFoBqQIP4VD0/9H+Q2TBdR/tGbuexKUY9pQAFAevYLfiePzdy5NR/j5+uRU6O6iukzIRvISXWFdIQTJhlQaY2memIOTGofvQ3lAjXHzKzroB9SUXlMWTPdsrCA9MaOMx/8c2q2HkqJqqbbwJepWjZDYW6I7tflXBateS6OzTVEFLRNavMIMYCnpQaZkHGCoJ32eNkrrJ05pD4QJrC+1LtNhj7If21ovNIY20ng8CUPei4TfBOW6F+ROfuiDbcQxQAVNRcEDH3fqbO+mWGZ/HlZY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(10067099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3hvalNkWnNrSHJnWFhiUm1CNzJXdkYybXl0eDNlUTZjRUVVUzFYdHg3WjRF?=
 =?utf-8?B?N3JaNU8yU1d0N3lmdmtXTzVYMSttTzdpK3ZRbTZOalVBdkp4Q0srQzJpU3M2?=
 =?utf-8?B?NTNpSGxxOTluUWpQZUdWNHAzbDhsOVpmK2RYNXBDYlJyQmpoZ0lYR2pYbHZo?=
 =?utf-8?B?TENmTXE3eXB5emEzOFkrRkNOd2dlY1RaRDZGQ0YrWXZvMTVZUktPYklCQTZZ?=
 =?utf-8?B?eks4OW1DRkIrbHdVOVJaVmRlYzlUbGlobjRDN0lQalNQL1duVjBWU09LalVh?=
 =?utf-8?B?ODdsOU5oaUV3MEd6ZHNhaUlDWGVLSUM5ODlvK2xLYjIwdHdSOWkrdWlyYk5z?=
 =?utf-8?B?cU1odnMva3B6ekFJbTRYZUlKeE51OGZXMDV0T3hDWGFRaFlRaFlmVWJod1ho?=
 =?utf-8?B?Q1pET3VKcE4vT1BBdmMrNHRFcGZBT0JtMElPdGFvSXJLSkRqL0M3QUlpaE5X?=
 =?utf-8?B?eERmc3lLcFE4VmJQQ2RqamQ4UHMyZ3pjNVJIcW93WHVieWZNUDdmTmd1aFdN?=
 =?utf-8?B?THNUamI0OFJVZ2NoYnk4SVlyVU04UEN3bHBPMEhHbE1OV2ZkQmZWKzJCUGli?=
 =?utf-8?B?cVdKM0d4dEVqT2FlSnFQeVNIWlR2Y1hUcUxNellUYWltZEpJUHlITCtPZjc5?=
 =?utf-8?B?M3o3TC9idlBzNmFka2ZUMGxzQkpFN1FiS0w1b3U0V01tRktvZ2lQdFo3VGx5?=
 =?utf-8?B?clAyc3FlMnN6UlozOG1GdVZvQURzbm9tcjBubkRaVUZKdU9NbnFBUjRHajRT?=
 =?utf-8?B?QVBQb1E4OXlueFR3YWwvUWhwSzJnQ3BDN1lydDRWczRvbmpCS0dFaW0zMFlV?=
 =?utf-8?B?TkpYUFcyc05FZU1oVXNHTE0wSzJadExYREtjaXo1bGhkNG1nWjZ4UFcvK1Nw?=
 =?utf-8?B?Q2kybUlBVTM3cTc1dWhvdXVEdTJEb1dVWGNlMzFCZnU1ZVZrNnA5MWtwbzM1?=
 =?utf-8?B?Q3NtM1lRVnF2SXN0L2tubWhKUDZ4V0szdmtFZzNzRzhNV3MxZS94NHNRZWhW?=
 =?utf-8?B?VFFweml0YmlBMDZSRWZScFlYV2VpSVZSUkNnWWtkVWpZdVFDRkMvVWxZOGFq?=
 =?utf-8?B?ajUxaEViaFowY05zK0FhOEdScU5nM0dIbGJuZkRoaDA5K25IcjRQYTl0c0pU?=
 =?utf-8?B?TmM5cHkwcGpoOUV3c1k1eUU3eEMwT3RRVE8zNUhqYTlweUdWOUVhODZDSXlZ?=
 =?utf-8?B?UmU1RDVYbjVOLzlidjVTOG8vTnQ3QmdsYit5SngrU0FUV2IwY0VvQ1VhdDNs?=
 =?utf-8?B?NHVtOXdrKzBvTDdXOUtYOXNWSGx6OHQ1eWowRTYwS0xLdkRHUXQyS0VYS0hE?=
 =?utf-8?B?eWk2bmdHbldEZmxKdHZ5eHJpNGFUeENlYkhLeWdqZlBHbml6dXkwSWJueFdZ?=
 =?utf-8?B?V1J1dG1pWGoyNmJqUVgzUnQ5aVJERjVSZVhZS1BOaCsxdjdoKzgxNlZmcFJ6?=
 =?utf-8?B?aVZxTURDTXFuZC9kM2hmSHh0WnkyQlgwT0ZJMCtXU2dBS1IzaFFCMStWMm1k?=
 =?utf-8?B?ZndrNW9EWENqUWl0MTBMRm93cVlYcWpTMFM0WTBYTFdDbkcrbWpoajZJcnRz?=
 =?utf-8?B?UzZ2c1FTbG1aTDR5UlRKSzVkb09GV1ZDNWsyTnNndTVvZ3AydW8wd2JUVEtn?=
 =?utf-8?B?cXB5UlBleFFlR1AyMzNqR0JSSGhFUXNBR3R1c3IzUEZzeDdWWUhRMW50MHFT?=
 =?utf-8?B?a2dHYlJxQWkvU2p0SFU5OUd4K05jU1lXOUlzT2xYMnNsVElRbjhlZk1aSVhN?=
 =?utf-8?B?eTZ2WmI5OFpnQ1QwMldKOXQ2ekNISWROZGpneWFQQjQxZUpwd3J0Mnd1UHZ5?=
 =?utf-8?B?eWJ6bU84cU5iTWtaaTY5dGlGbTJ1a1ZlbnJwWjFuZjBFQ3R3d3puUHozcnc5?=
 =?utf-8?B?K0FpS2ZOSlFJNnd2bUZzS1NjOWJzMXdoaHFmOStSOEEzRDlpeGpVdVZWNTI3?=
 =?utf-8?B?Y0hVS1ArZjB2aUFLZU93bXVDaTNmZENwWkhNRzM3K2h1Mm84Q0Q1akF0MFpr?=
 =?utf-8?B?U2tYcDdLRkpMcStHZU83Z29sUnRVUFczTDE0N0YzQzRiNENvMlBOZDJ4Nk1a?=
 =?utf-8?B?TVB2SWpRRG8reHpZQVd1WjR2QXRlU0s3UG9lcXNOOFcxQk5neFEyUWZWRC9G?=
 =?utf-8?B?ZEdkOWw5TGJjbXFMYndqbFN2ZVE0SG1NUXhlQkV3TjhUcW1kK3JISk1ScFhh?=
 =?utf-8?B?TXNDdmxNNGkwQXlNTEJuRTdvYzJ2WjlDckZSTGFuMUlCQWVPeHRiL1VBT0tz?=
 =?utf-8?B?aTBVUkFiL1g0UFB1eWV6UVpDZlNmWER6UEI0Z1pUQWtXOXlQdEZ0aEYzdm9r?=
 =?utf-8?B?emwxVVYrVUdmcnlNcDNzaEhNZkp1MGFZcU5xT1FZV1FCOEpNTWNpU28vUmJv?=
 =?utf-8?Q?oTBEEZc6L/FXSizU=3D?=
X-Exchange-RoutingPolicyChecked: URkfrclNRqyQ1MiRv7i6LT9zSrjPU0zJHZ3ZkXWhuz9Ovn9iEIjMnpnWym1coG8NluhmIdnatwlkc/c3Iy/KPwCwxCP709mfVDgYN2PjXmq3tiQ9Size2gQQ2D66IGwwotlkrQsz8WTLdRHiUqgVZ0wdQJ8SQhuCtkva8DvwQ7GUnkbc/jklnlRv+a7DI4qwTYBQdqmjsY81Ld08pUj2B7uqLPOLVH6kl60rpqVGSQV3Q1seAtblP1VvA/KfvLuY8KO2BS82bmc6uTbvSW5MnzMbvZUirl5lQf1+evFSA2dWdK/diUL7WUusuy9cfIZv8nyPB58krnj7UL+8CXj2YA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 84148caa-007c-4122-dd53-08df236ee078
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 05:58:43.0866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJlasrDMa5ditLu9XyYJ44esPgEP74NUI/brHpOCRuyK/lzvLkVJpaWtux9Pi/9N3ftoy2CuOwIVvqliFBsqDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9322
X-OriginatorOrg: intel.com

On 30/09/2026 07:32, Shawn Lin wrote:
> mmc_regulator_set_vqmmc() takes an ios pointer and switches on its
> signal_voltage, but the MMC_SIGNAL_VOLTAGE_330 path looks up the VMMC
> voltage range using mmc->ios.vdd instead of ios->vdd. That mixes the
> ios passed by the caller with the global mmc->ios state, which do not
> have to agree.
> 
> mmc_set_signal_voltage() only updates host->ios.signal_voltage before
> invoking ->start_signal_voltage_switch(); host->ios.vdd is refreshed
> when the power supply is (re)configured, e.g. in mmc_power_up() after a
> new OCR has been selected. A host driver switching the signal voltage
> for a vdd that has not been committed to mmc->ios yet, or passing its
> own ios snapshot, would therefore get a vqmmc range computed for the
> previous, stale vdd instead of the signaling voltage it is switching
> to. With a stale vdd of the 1.65-1.95V range, the computed 3.3V window
> ends up with min_uV > max_uV and the vqmmc regulator is never set, so
> the signaling switch fails.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> ---
> 
>  drivers/mmc/core/regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
> index a85179f..c553356 100644
> --- a/drivers/mmc/core/regulator.c
> +++ b/drivers/mmc/core/regulator.c
> @@ -197,7 +197,7 @@ int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios)
>  		return mmc_regulator_set_voltage_if_supported(mmc->supply.vqmmc,
>  						1700000, 1800000, 1950000);
>  	case MMC_SIGNAL_VOLTAGE_330:
> -		ret = mmc_ocrbitnum_to_vdd(mmc->ios.vdd, &volt, &max_uV);
> +		ret = mmc_ocrbitnum_to_vdd(ios->vdd, &volt, &max_uV);
>  		if (ret < 0)
>  			return ret;
>  

