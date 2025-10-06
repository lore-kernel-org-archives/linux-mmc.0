Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB8821FF4C;
	Mon,  6 Oct 2025 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745355; cv=fail; b=qTpJGal8aWAsk9WKzIPn8+5P9tUcXjEZeC3PlSZXXnkVf1qOpL09ZtdEmgJNvHERF3+4Tdm9bqyY2SK7iNYIFTxfsGlxMedf9q5zbxAuZ12p9i+oES8pg6t03cOAroS27xRjZGTrXPXmDRorWSfZQzUVBsxXxtbUOMEorrhCnrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745355; c=relaxed/simple;
	bh=qCk5wY5kJcgB2GYeeagI3S83bsvs5LwFOjVCWERLnFI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W5N7IX2EiiLBwDgzkDaFGySGawPgYyzAI1+aosNUbfMwD9bRviqcvZw+eQkt2/RTyQTXKueO0m+NVaai1ixmpCL+1MYXNlblRpIy7xiKlDyOO+Qgtq4AYCvUvztn479BbJXju5uzsp+RIp3vH3dqUIJOqiaheraeqdgH5GlsQls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0UNIxZs; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0UNIxZs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759745353; x=1791281353;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qCk5wY5kJcgB2GYeeagI3S83bsvs5LwFOjVCWERLnFI=;
  b=W0UNIxZswxptaqNEQjehiQjCCWqzb5Q/He95XZH/b1a0MsGh1HTIqAIR
   X1cPQpLMgo120YTPKrCVCCXbpxDlFBMhE3XUJpTARs4jCLIc6gIX8e1iJ
   DFg2AwBm8SnTA4a3GIjc+t54WV3u/OqV18FFQvxBMqDfZI4IHzNIyS5oN
   IFUfK2sBD0F1j0Zz2i9iJsDMifKTvy+wyIKTNrmnfZz6uKWzTuHeeQMgO
   rpzH7uvuCQYT81R3KzgzqxUV1dCAtVN6qNM+kku1IkJGleaFR49/qkgaF
   8Pn8/+PvXD+QZFYjCHoBzYlYsDQ/lShoXG7/a2ewPVWVjxTmtKAKI3rpi
   g==;
X-CSE-ConnectionGUID: icXNi7x6TRW/QCdQYAyA9w==
X-CSE-MsgGUID: 1xQB2SooQ/O1k6qXpeK2fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11573"; a="65766376"
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="65766376"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 03:09:13 -0700
X-CSE-ConnectionGUID: Z982IGIsTtuaqdx6TZr3OA==
X-CSE-MsgGUID: Dql3k8yySH2gjY1OVmZh0g==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 03:09:12 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 03:09:11 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 6 Oct 2025 03:09:11 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.64) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 03:09:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U91RRzDX2TqGQBJrVuQW3EuoOhBgCgUvTGpL1CL9wwD2P1lQrxak/Lrgt5CmmR5ew1qoYLbmaVuZUVNg8ZYoyoQq3odUTmAZPase0/lnh2O6fGMlesjAw3Mmyo/O2KTtYwGJhqtgrLoObojlq977KmvXrCwM/C0K4yWv9qi4nVn/JnAgp/SwiI30N+JmMR/DlK1IpHgFSznwQQlRekrXjV65swGyuynsdzMb6IMh9OGNOljfKa8JYz/Qhbo+EYy3DW07rSpwVMaz9pbsLADvQS8GhPg++EnBks5EwWzMeZjxqu6PeZe2bN4zGVfwVco9WuNntwQ5/Lh0Ftuyhkp3CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7g11Cw+pZW+f/vNpWhhXbRpUSph/jrP51WiDE3a1eI=;
 b=oY4Eqv3ki7Sgk3wlpT+TP7ZaBlfmvIoRdpt25RLcoJpWOx5vWGy6nWeCd4yJrGf9d2+ntDnsZj9dW2fvIhWoN/AQsd+bp2y8H+VANIutlylM4DPNlE9nnkNdR9CRN+v1fgYUrRbI1ZPB8Rn894puf825n97TyNdTUX58RcgW6vOfDn/PKob0hwN9JVU/LvCcC/kBHLy0wiZ4O0EepipP5QoLOA4YYt6tf1+CYzIv49QWmF4o07pRslhMjKul+PUBUVnYxIRpCcyUeZiprjfnNkwmIhkXUYPOWO8Mz2pbO8s58rddyDF+hdhvuc1DKpxMa5bVr97d+fjNbiIHESGJvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH0PR11MB4805.namprd11.prod.outlook.com (2603:10b6:510:32::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 10:09:02 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 10:09:02 +0000
Message-ID: <24a58a70-b4db-4925-8454-78dea4fb22b2@intel.com>
Date: Mon, 6 Oct 2025 13:08:57 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mmc: brcmstb: save and restore registers during PM
To: Kamal Dasu <kamal.dasu@broadcom.com>, <andersson@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<florian.fainelli@broadcom.com>, <ulf.hansson@linaro.org>
CC: <bcm-kernel-feedback-list@broadcom.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>
References: <20251002210426.2490368-1-kamal.dasu@broadcom.com>
 <20251002210426.2490368-4-kamal.dasu@broadcom.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20251002210426.2490368-4-kamal.dasu@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::34) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH0PR11MB4805:EE_
X-MS-Office365-Filtering-Correlation-Id: 73753c16-668d-46eb-15b3-08de04c05fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUxmQ0NrRWVBYloyQlVhZVBTZHBtVEUrbGVuejQyUnpYTjJkdE5FU3VySUk5?=
 =?utf-8?B?OXFUc0wyOFowSExGM2JwMlB2cTRYcE8yV1haTjNZUHRqc3RVOWNFTGlpR0Ry?=
 =?utf-8?B?bktrVGRBeGljWFJVNmhuSGhKRkFhdjBCZ3lLSWdyRHZhQ1Rqcng5S0VNZktB?=
 =?utf-8?B?OHk4T0xFN2FLbTgrdnk1dnVoNklTNmFmQ3VoU3psaDRENzNtRWhqeUZQd1I4?=
 =?utf-8?B?RklSUzZCTTZlUHd5QTZEc1JIUllKZFhMUkhzSWEvSE9KWWJ1aDg0eGRLTnNV?=
 =?utf-8?B?MlZmUHhlVGFWMTM2aWhNUUEwS2d4cHYxZkNBVGVqSzlRUUpkcHA1RmJLSkl1?=
 =?utf-8?B?UmpRbDV3SmNmTVJWU25rcm1NUlViOTlUVUNVZXhOSC9uZTFXVS9EMmNUTzB6?=
 =?utf-8?B?Q3VZTEFoc0VrQXdQNkxKNmxDT1U4c2MvM1FUbmdXUHlUa0Q4c3hyTkdaUGtj?=
 =?utf-8?B?V0pMN0NPakpnemJDdW0wNW50TERXTnBjanVUVHp6NmFBSDdGWk4vLzJaVzAw?=
 =?utf-8?B?a0hEYit6Q1QrS3N1SncwdXVNTnZOVnpGa2xaNGx3a0h4WWRzb1FWWWFIL3dX?=
 =?utf-8?B?ektmWkZEMGI0bFpsSGtURlBXNVZ5MkdXRnl3TkxYL3U3dS9MQVNGTTh4Ry9i?=
 =?utf-8?B?U3EvQnhhb3lNN1FGWXNZTm02RjYzWkIyVlZPT1NEbVh0Ui9acUFsemZtdVhR?=
 =?utf-8?B?NEUzNUsyNjhqR3FWeU5kY3RJb0N2WkliRERtczJiQVJBenc5dmNleHh2THdv?=
 =?utf-8?B?eUpETWNsOFlmWklob3VrdGNHOFlIWXNZWVFCOFpKL29VNGxQZm1haUVjNFJ2?=
 =?utf-8?B?YnMweTcraUdFdEhueFgxS1lRTmtET3lBT3BCaUtuWWFLNWNWYk1USkVqcm1a?=
 =?utf-8?B?MjNBYnlVcm9rcTY2T1ZjUW1KTlhFb3YvU3BYT0p1Ymc2U2NiUC9ETU45QTdj?=
 =?utf-8?B?a0R0aUVSUy9ueFlab2hlWlFNVlVjbmdDYlFrNEN3VHlBaDFTNXZlNUVmbldw?=
 =?utf-8?B?RkRGdkFtVGJkV1NaSFdIdXV2WjVxYjJYTHlVZGRGQ0dZY3hWcFhRUUpMVnN0?=
 =?utf-8?B?bkc1cmFFdEJBTFdPc0VpZEd6bzFUdDNhbUhqTVA0amw2Y1NOR0dhVk1Tc2Ir?=
 =?utf-8?B?ZVVyL2tVWWNzUWVBQjRoM0V4WXczZTg0Q3ZBTERkRTZMOUM2QjlVMmVCRndo?=
 =?utf-8?B?TW5zWlBzeDhnakVxR2xMOUxUbU1acnE4NE52dmFGbTNnbXF5MHlYSGhKN0VM?=
 =?utf-8?B?RXRFV05IckJkUEp1aldkTlNES0NkZThWeEZNSTU2RVZHblNnWEdsQWdYMEUr?=
 =?utf-8?B?RDlWUlVLYmN4VjdRcjdJS0ZFaUVKbGVvcmpzNEgzRGlYU3duUzdRMG1WalpX?=
 =?utf-8?B?di91NWNIbnlUbWFZc0tMZnd3NHZ3ZUJNUEdxQ1U5ZVJic3FNVDNLQjBRbS8z?=
 =?utf-8?B?QzArZlBrUnd3NHh4SzNsRzR3UmFDd0Vxd3EwUnkxMnNnSys1TlpIYWxSVHh3?=
 =?utf-8?B?Q0YvaENiMEEvQ1phOVNhS3hFNVdva2dxbW1HYzdkNDZvYXgxQVJGaGRweHZ0?=
 =?utf-8?B?MkRoallaeXNhNkZVdk43RThJV1M4S2hXUUszRWVsRElSQ2JiMmRhVG9MVHpS?=
 =?utf-8?B?UldRbGJPd3JaR2lrNDY2SDRmKzhSc3VTVFpsWmQxQWMyRTRrUnczb3pRbGZR?=
 =?utf-8?B?aHh0SVhoNWI4ek12czJ2KytzdHBEZUZTcjB6czVJUzVzdDluZFRGK0g5dllD?=
 =?utf-8?B?REhNWTJnUklHVE0zbUROVlRJQjZsOXV2bCtDQzVjdWhWVE11R1p1dFA1d3hk?=
 =?utf-8?B?dWx4ZU1pOWV1QWswMVRib212U2ZjZ1FENVJSa3oxT3VuQXRWMDlKM1VBRFJJ?=
 =?utf-8?B?V1RkWnUwOVgwSDBDQThETVZJUk0yamkzZEd0UXYxbzBOMEMrdnhPM3FCOGl2?=
 =?utf-8?Q?b7eckxUijePf3oS+/OfCKCZ+yb9vkBfA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3Y4Z2ZCQXlmb0JBcDJsbGdIcWx4Tm9mSzduQnFaODloME8rbEhlRGZaSHBs?=
 =?utf-8?B?V0psMG9PUE01NGUxZzA0RTNWRWJZR0R5bnRIc1hMb210b1JjZVptYkllUFY1?=
 =?utf-8?B?VlhPMnd4TFZSb2xhaXhiS05ZcVZnM0tSTElyNHRvemhjaVdYc3NLaEM1Y2tL?=
 =?utf-8?B?WlErMG1ZQTJGbVpTWm1Ebk5ISWZwK01mZ1lzczRuRlFZUlI0UnFZZUdSSjBv?=
 =?utf-8?B?aDlVb1J3elk3b0NacDI0d1FRdTR1WDJUQmtxeWNCNGR3YzRabWF2cTROdDhv?=
 =?utf-8?B?Z0JDa2xhaG5MZTRwcjJKTkRjUFMvNGhET1lFOEttempHc2pudTFsSk92QjlJ?=
 =?utf-8?B?QU1TREUyYzIvTkM0Y2IweTVuVUFsdkc4U0dUYVBjUlcrS25BS2g2Q2hQNVhG?=
 =?utf-8?B?MkF6MWtHQjl5R21ONWVXYm41bG5VcitjTHpZTUE3OGJkbHFwUWdpTXRJSEpj?=
 =?utf-8?B?Uy9keHo0K2tuN0tURDAzZis4RVJNa0tMYVdxVldNdXRBaU1ZRnkwTnlZUmZ2?=
 =?utf-8?B?T3lJbjFkOUpHaGdEM0dVQTR6VFgyUTRScVBkT25oVnZBa0tRck4veVJTeEhO?=
 =?utf-8?B?S2g4dUlMeXNXbGFudnhVd3htUTZTeHdVbzBzYlpHMnZzL2gxUWNoNGlSWVgy?=
 =?utf-8?B?eDYrY3pwUkg0d3g3QWJiejZIa1dJV1B3RDh3QWdBa0Q4VUV3NVJxV1NyMHkx?=
 =?utf-8?B?MWNlOEQ1aS9IT0FDQ2gwZHZNeGlYZ2EwdVE2UHNnNnNsZWtuemMvWkdGbkVW?=
 =?utf-8?B?UHBQSGFTaUc1d0tqQVpsdksvbWJNT2VWVUZHeGl2ZXJCRHcxU2pENHo4QU9l?=
 =?utf-8?B?dlpqUnNia3VxdFBHV1lvZnp4Y2hnY1E4dVRWTWFkVWdrYzBrM3VpYUxROWNw?=
 =?utf-8?B?TXR1UDhxbEZWVzFud0kzMHBScjNMRXpObjV6Rk8xL3RyV2tQbFJRL3NMU2RY?=
 =?utf-8?B?dmlEOEh1VitiN3E3Z2pEczZFR0JoMkxSbkczZUNtRnhPa0tFOXJQbDV1Y1Na?=
 =?utf-8?B?eFRGZlhmZUh2cGdEbnFtcytKR2t5YWcyOFFQb1RVOGw1Y3BBUlZPVFA4T3k2?=
 =?utf-8?B?SmhidFVpVDk5NC9ZeG9POEZZaVF0Q3c2ZWlHMDE4Z0FNdXplbG43NnQyTStJ?=
 =?utf-8?B?eFlReWZ5TWI2aHI4U0VtckNLL2ZUQVVNQjdNcTBmVWo3UitwQml6SHZsQjFI?=
 =?utf-8?B?R2ovSjFtcXN0V2dMRHJPTHdVaUNSZXkwR3dvbFZpK3h6bUdZMnpNV0pqTDdI?=
 =?utf-8?B?aFU1QWpkdmYwcGNWeVFpc2JxSmVlbmZhMXdjTUZHYUxMWjExb01RQkNtNlo2?=
 =?utf-8?B?d0hIYjIxNTM1UWZPbTdVam5yR2dGVWhpdHBhdkE4VnFBMkhqdnVEN0k0d2Vn?=
 =?utf-8?B?NmxjeG9RV0lycU9uMVZvY080TGZodkdOYmRsTDBQcDhuODgzN1ZqMmF4azZM?=
 =?utf-8?B?VzhjV05yVGcyTWtpWGlQM0FjUjFLb3lSK1JsUEF1aGUyaDVrQ0hqcU9zRlZ5?=
 =?utf-8?B?NGxMYnBnOHV4MW5EOEdDS0lMaU9YcGxVSmQ2cEFaWXlnbTZJL3lhTXh3cVQv?=
 =?utf-8?B?UGtyUFhKK0NLVW1wVmNxdlpVVVNBYmFtZ3R3d2w3ZGM2ZWt1a0dyZHJxVTRJ?=
 =?utf-8?B?MGZFSnduVnovSjhrcWgxUGZQU2V0b3lrTjVPWEFZNVJRKzhVYlMwVlY2Tity?=
 =?utf-8?B?SGdFM2FxUjVWOFRKTUlHbENlV0NMbkR0ZDhxODhTdnlZSUhNM0tlUXRnQlhn?=
 =?utf-8?B?Y2lmYnNDb1o2NWR5eTZRZTdPd3hja2laaXZBd1ZJeGEzSmRGMTRxUnlOYXBB?=
 =?utf-8?B?bEprVHM1RGl4VDVqQzRHTEorT1p0YTlrYlUzYXY0UU84Mnl4cXM0d29WWE43?=
 =?utf-8?B?SFpraStkSUUzOG5CbWNoZzFMU0ZzK0x3WjV3cE1MYmFnUFZWWW5JY1dzRDl3?=
 =?utf-8?B?K1V2VXZSTFJHMUVyYlZuaWI3cGdFMXZMY244Z0RIZHNqQkQ3VUgwRjFHdnNw?=
 =?utf-8?B?WFR0Z3pTN0lXS01nMFVFa2FsMFE1bDIwdEZGb3VsTEc5dFMxczNSM0NtVXdT?=
 =?utf-8?B?Y3I0bFo3TGFjM0UrL0gxbHFiSjBsQVZsYU1xZnpnaktkNEJrbHRVMXErYktj?=
 =?utf-8?B?Y2ZMMXZBU2UxK0d0ZHBseVpmTGxwUEVTd0lZUlFYb1RndXIva3Q5QytlZ3Yr?=
 =?utf-8?B?cWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73753c16-668d-46eb-15b3-08de04c05fbe
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:09:02.4845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+SGpWot6C/HqDCKqM6Q47De1EiZK7zjkJ7YDpemOr2N/Ske+KvBltLAuO9Zvb9+Uhw/tDzgpbOU75VQZfohzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4805
X-OriginatorOrg: intel.com

On 03/10/2025 00:04, Kamal Dasu wrote:
> Added support to save and restore registers that are critical
> during PM.
> 
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 124 +++++++++++++++++++++++++++++--
>  1 file changed, 119 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index 0905b316a24b..ffa602a99ab7 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -24,7 +24,9 @@
>  #define BRCMSTB_MATCH_FLAGS_NO_64BIT		BIT(0)
>  #define BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT	BIT(1)
>  #define BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE	BIT(2)
> -#define BRCMSTB_MATCH_FLAGS_USE_CARD_BUSY	BIT(4)
> +#define BRCMSTB_MATCH_FLAGS_HAS_CFG_V1		BIT(3)
> +#define BRCMSTB_MATCH_FLAGS_HAS_CFG_V2		BIT(4)
> +#define BRCMSTB_MATCH_FLAGS_USE_CARD_BUSY	BIT(5)
>  
>  #define BRCMSTB_PRIV_FLAGS_HAS_CQE		BIT(0)
>  #define BRCMSTB_PRIV_FLAGS_GATE_CLOCK		BIT(1)
> @@ -38,19 +40,39 @@
>  #define SDIO_CFG_OP_DLY_DEFAULT			0x80000003
>  #define SDIO_CFG_CQ_CAPABILITY			0x4c
>  #define SDIO_CFG_CQ_CAPABILITY_FMUL		GENMASK(13, 12)
> +#define SDIO_CFG_SD_PIN_SEL			0x44
> +#define SDIO_CFG_V1_SD_PIN_SEL			0x54
> +#define SDIO_CFG_PHY_SW_MODE_0_RX_CTRL		0x7C
>  #define SDIO_CFG_MAX_50MHZ_MODE			0x1ac
>  #define SDIO_CFG_MAX_50MHZ_MODE_STRAP_OVERRIDE	BIT(31)
>  #define SDIO_CFG_MAX_50MHZ_MODE_ENABLE		BIT(0)
>  
> +#define SDIO_BOOT_MAIN_CTL			0x0
> +
>  #define MMC_CAP_HSE_MASK	(MMC_CAP2_HSX00_1_2V | MMC_CAP2_HSX00_1_8V)
>  /* Select all SD UHS type I SDR speed above 50MB/s */
>  #define MMC_CAP_UHS_I_SDR_MASK	(MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104)
>  
> +enum cfg_core_ver {
> +	SDIO_CFG_CORE_V1 = 1,
> +	SDIO_CFG_CORE_V2,
> +};
> +
> +struct sdhci_brcmstb_saved_regs {
> +	u32 sd_pin_sel;
> +	u32 phy_sw_mode0_rxctrl;
> +	u32 max_50mhz_mode;
> +	u32 boot_main_ctl;
> +};
> +
>  struct sdhci_brcmstb_priv {
>  	void __iomem *cfg_regs;
> +	void __iomem *boot_regs;
> +	struct sdhci_brcmstb_saved_regs saved_regs;
>  	unsigned int flags;
>  	struct clk *base_clk;
>  	u32 base_freq_hz;
> +	void (*save_restore_regs)(struct mmc_host *mmc, int save);
>  };
>  
>  struct brcmstb_match_priv {
> @@ -60,6 +82,69 @@ struct brcmstb_match_priv {
>  	const unsigned int flags;
>  };
>  
> +static void sdhci_brcmstb_save_regs(struct mmc_host *mmc, enum cfg_core_ver ver)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	struct sdhci_brcmstb_saved_regs *sr = &priv->saved_regs;
> +	void __iomem *cr = priv->cfg_regs;
> +	bool is_emmc = mmc->caps & MMC_CAP_NONREMOVABLE;
> +
> +	/* save  */
> +	if (is_emmc && priv->boot_regs)
> +		sr->boot_main_ctl = readl(priv->boot_regs + SDIO_BOOT_MAIN_CTL);
> +
> +	if (ver == SDIO_CFG_CORE_V1) {
> +		sr->sd_pin_sel = readl(cr + SDIO_CFG_V1_SD_PIN_SEL);
> +		return;
> +	}
> +
> +	sr->sd_pin_sel = readl(cr + SDIO_CFG_SD_PIN_SEL);
> +	sr->phy_sw_mode0_rxctrl = readl(cr + SDIO_CFG_PHY_SW_MODE_0_RX_CTRL);
> +	sr->max_50mhz_mode = readl(cr + SDIO_CFG_MAX_50MHZ_MODE);
> +}
> +
> +static void sdhci_brcmstb_restore_regs(struct mmc_host *mmc,
> +						enum cfg_core_ver ver)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	struct sdhci_brcmstb_saved_regs *sr = &priv->saved_regs;
> +	void __iomem *cr = priv->cfg_regs;
> +	bool is_emmc = mmc->caps & MMC_CAP_NONREMOVABLE;
> +
> +	/* restore */
> +	if (is_emmc && priv->boot_regs)
> +		writel(sr->boot_main_ctl, priv->boot_regs + SDIO_BOOT_MAIN_CTL);
> +
> +	if (ver == SDIO_CFG_CORE_V1) {
> +		writel(sr->sd_pin_sel, cr + SDIO_CFG_SD_PIN_SEL);
> +		return;
> +	}
> +
> +	writel(sr->sd_pin_sel, cr + SDIO_CFG_SD_PIN_SEL);
> +	writel(sr->phy_sw_mode0_rxctrl, cr + SDIO_CFG_PHY_SW_MODE_0_RX_CTRL);
> +	writel(sr->max_50mhz_mode, cr + SDIO_CFG_MAX_50MHZ_MODE);
> +}
> +
> +static void sdhci_brcmstb_save_restore_regs_v1(struct mmc_host *mmc, int save)
> +{
> +	if (save)
> +		sdhci_brcmstb_save_regs(mmc, SDIO_CFG_CORE_V1);
> +	else
> +		sdhci_brcmstb_restore_regs(mmc, SDIO_CFG_CORE_V1);
> +}
> +
> +static void sdhci_brcmstb_save_restore_regs_v2(struct mmc_host *mmc, int save)
> +{
> +	if (save)
> +		sdhci_brcmstb_save_regs(mmc, SDIO_CFG_CORE_V2);
> +	else
> +		sdhci_brcmstb_restore_regs(mmc, SDIO_CFG_CORE_V2);
> +}
> +
>  static inline void enable_clock_gating(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -300,24 +385,33 @@ static struct brcmstb_match_priv match_priv_7425 = {
>  	.ops = &sdhci_brcmstb_ops,
>  };
>  
> -static struct brcmstb_match_priv match_priv_7445 = {
> +static struct brcmstb_match_priv match_priv_74371 = {
>  	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
>  	.ops = &sdhci_brcmstb_ops,
>  };
>  
> +static struct brcmstb_match_priv match_priv_7445 = {
> +	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT |
> +			BRCMSTB_MATCH_FLAGS_HAS_CFG_V1,
> +	.ops = &sdhci_brcmstb_ops,
> +};
> +
>  static struct brcmstb_match_priv match_priv_72116 = {
> -	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
> +	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT |
> +			BRCMSTB_MATCH_FLAGS_HAS_CFG_V1,
>  	.ops = &sdhci_brcmstb_ops_72116,
>  };
>  
>  static const struct brcmstb_match_priv match_priv_7216 = {
> -	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE,
> +	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE |
> +			BRCMSTB_MATCH_FLAGS_HAS_CFG_V2,
>  	.hs400es = sdhci_brcmstb_hs400es,
>  	.ops = &sdhci_brcmstb_ops_7216,
>  };
>  
>  static struct brcmstb_match_priv match_priv_74165b0 = {
> -	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE,
> +	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE |
> +			BRCMSTB_MATCH_FLAGS_HAS_CFG_V2,
>  	.hs400es = sdhci_brcmstb_hs400es,
>  	.ops = &sdhci_brcmstb_ops_74165b0,
>  };
> @@ -325,6 +419,7 @@ static struct brcmstb_match_priv match_priv_74165b0 = {
>  static const struct of_device_id __maybe_unused sdhci_brcm_of_match[] = {
>  	{ .compatible = "brcm,bcm2712-sdhci", .data = &match_priv_2712 },
>  	{ .compatible = "brcm,bcm7425-sdhci", .data = &match_priv_7425 },
> +	{ .compatible = "brcm,bcm74371-sdhci", .data = &match_priv_74371 },

Shouldn't adding brcm,bcm74371-sdhci be a separate patch?

>  	{ .compatible = "brcm,bcm7445-sdhci", .data = &match_priv_7445 },
>  	{ .compatible = "brcm,bcm72116-sdhci", .data = &match_priv_72116 },
>  	{ .compatible = "brcm,bcm7216-sdhci", .data = &match_priv_7216 },
> @@ -441,6 +536,19 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>  	if (res)
>  		goto err;
>  
> +	/* map non-standard BOOT registers if present */
> +	if (host->mmc->caps & MMC_CAP_NONREMOVABLE) {
> +		priv->boot_regs = devm_platform_get_and_ioremap_resource(pdev, 2, NULL);
> +		if (IS_ERR(priv->boot_regs))
> +			priv->boot_regs = NULL;
> +	}
> +
> +	if (match_priv->flags & BRCMSTB_MATCH_FLAGS_HAS_CFG_V1)
> +		priv->save_restore_regs = sdhci_brcmstb_save_restore_regs_v1;
> +
> +	if (match_priv->flags & BRCMSTB_MATCH_FLAGS_HAS_CFG_V2)
> +		priv->save_restore_regs = sdhci_brcmstb_save_restore_regs_v2;

It is not ideal to use a flag to set a callback.  Perhaps sdhci_brcmstb_priv
should have a pointer to brcmstb_match_priv, then ->save_restore_regs() could
just be put there, and BRCMSTB_MATCH_FLAGS_HAS_CFG_V* are not needed.

> +
>  	/*
>  	 * Automatic clock gating does not work for SD cards that may
>  	 * voltage switch so only enable it for non-removable devices.
> @@ -533,6 +641,9 @@ static int sdhci_brcmstb_suspend(struct device *dev)
>  	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
>  	int ret;
>  
> +	if (priv->save_restore_regs)
> +		priv->save_restore_regs(host->mmc, 1);
> +
>  	clk_disable_unprepare(priv->base_clk);
>  	if (host->mmc->caps2 & MMC_CAP2_CQE) {
>  		ret = cqhci_suspend(host->mmc);
> @@ -564,6 +675,9 @@ static int sdhci_brcmstb_resume(struct device *dev)
>  			ret = clk_set_rate(priv->base_clk, priv->base_freq_hz);
>  	}
>  
> +	if (priv->save_restore_regs)
> +		priv->save_restore_regs(host->mmc, 0);
> +
>  	if (host->mmc->caps2 & MMC_CAP2_CQE)
>  		ret = cqhci_resume(host->mmc);
>  

