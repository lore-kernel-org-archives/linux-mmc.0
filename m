Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B12364028;
	Tue, 23 Jun 2026 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782208138; cv=fail; b=KPt4O3kHe33sEEsqBKvJ3CIpuc1r7Jg74+JEQjtSJM6k8Andb8rlpxuTN+AR0yuxNFv4sr8ieQY56br/lfl/5XUr1GuG9vNEqXIZu9jfARTLFeKbAWEj+sOWQH4rTcRi2EKRaDiQyP/V6nazHiEwlOdCbHhnLUYVYqphR/tieUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782208138; c=relaxed/simple;
	bh=SxW+AJX3L3JuRDIdHZMqKyUOPt+poekx9/aaUOtG7m8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V1PILlcnl6ryeEO0injEbGwmMoi6XE7ddPl8vt71hBVsN0lvnxqZojnzPfG136aQ1KpPtN4Xjh1S5PWF10sZIrQ95V49dIdXU9BbE/Q4CFML3UOgWdFoLmP3jXPiAgUu94KKrvchUdW3o30FWrmV+XfGa23W6bgI+6WxZi3usbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VezzhFTo; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VezzhFTo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782208137; x=1813744137;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=SxW+AJX3L3JuRDIdHZMqKyUOPt+poekx9/aaUOtG7m8=;
  b=VezzhFToz1qkNL1X7pBcxJncLGF+egagmTuu/rqRT4Y3FLYE0npc9WC6
   k/xk/UqBhl4j4sYj8cfBJ+k6xPV1SSViGndUHNJrqA2GlYzxyLnwhFnOx
   cT9Fu6KK8uQVB16fnqaOVY0NolP0rRkcto7c09xH23PZshtSqod2jcQSk
   SMpLlemRiERfxsnb3+CLcV0cBvS4eJD6hXds2nPpyVZTBt8XawwiQgnrg
   uBaFTcs1QGQvMfkoIKa1OhRJpOnnZ4Wxi1AjMvG39muHR0rAv8brSLYTY
   FszA0PB7zI+rX9HcS4QRKmGZ+/mVhdxol6MEWMKCJrwlOtKY23kQ7/10i
   Q==;
X-CSE-ConnectionGUID: K1H/8NzSQZqffOZ8Hx5CiQ==
X-CSE-MsgGUID: crXIHtfJT4O67MtYEP+uOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="93602251"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="93602251"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 02:48:56 -0700
X-CSE-ConnectionGUID: LxJeZ46SROOfCKgsdAHXRA==
X-CSE-MsgGUID: fmHKmIpSTaKZaVZaCxR0iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="253355388"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 02:48:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 02:48:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 23 Jun 2026 02:48:55 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.26) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 02:48:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoV044qUcqvLn2n74OydZAyMxW3Xt/NqE7IUMdIDkPXOLgNraYBhaaozHS/b0QAN/B3TO0x/9u9AEPmsFpmqhrlmoOKl5AVP6ZkarFF0L4MSgkPVi5RGf/ZEt6/Z6Ll1EIuR0xS7aQXVBvqb2TqGdZHt4guw44/0Jmap66T1tr3MS1UTGWj8C6w2aJJqHf5P40VWgs1JDKWd8fCJh4/f+t0B9XEaAn3qKL584DObv1Z6fcfwUZeybsOWkW7c9wyAeccWr8tCFu44axTI+wQHiI/0GCyYM0MNOm88Mn5bVIUJB5k+5xU5zSxD6PqhdD6hOxsRnmQaq/vhSGBVBfc/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bu7CSpLdfuAh5CMJE965ZJ6/aAClALRqEh3N9bke6jg=;
 b=UaQ9/k72+ewpGTeRcGVmMPNSJ1i4FRME/2ksJjnhBpA97y8IleZqsflyST/XZd9yw/r66i+9iSS9Zu6Lg9dITMllVaXdgjcmb8QLuBtTzXvm/TF2vVILKZJbYiuW54qDfRywfpqc8KYTNnYzgE+ZLt7TSvGxyEcfYtekd2Bd81oCmyYbMObX98Vo55eRbht3zoDyhIx4pzwXVanopmtKyeZ7fxkP7j2A3ueYpoiDW+Z57vq2byRcPz8Hh0/zpMx9iD+B4zKi5JLfY1jgcJereTe9qJsod80+6NdDwpPkxTCLXeikB0cYO9LMOrHgfez6fpyjwGeqy2FSWK/1atyWBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH7PR11MB6474.namprd11.prod.outlook.com (2603:10b6:510:1f2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 09:48:53 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0159.012; Tue, 23 Jun 2026
 09:48:53 +0000
Message-ID: <04a92d22-2ab4-414a-907b-f6515ab57a7e@intel.com>
Date: Tue, 23 Jun 2026 12:48:46 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: cqhci: fix to missed endian conversions
To: Ben Dooks <ben.dooks@codethink.co.uk>, Asutosh Das
	<quic_asutoshd@quicinc.com>, Ritesh Harjani <ritesh.list@gmail.com>, "Ulf
 Hansson" <ulfh@kernel.org>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260622145036.513129-1-ben.dooks@codethink.co.uk>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260622145036.513129-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0067.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::9) To DS0PR11MB7215.namprd11.prod.outlook.com
 (2603:10b6:8:13a::13)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH7PR11MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b54a7d7-4c9f-4fde-8769-08ded10ca201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: qqMj+1xTEyqvSMMwTnM3oMSe7jz1b95rv+U+uUJMaY/i242lxuczc4WoX5osZWm+XDtpjcNDmh0vaCsML3qnOAPzo2PqSCiHymsfjuXcwLErwJTk4bWSn+7bzU6dv0S6kJIb4ToKq9a5iMjDs3bI7K46Gf+9xAChb7NnG5Eo2DgjccLT5U9t9ISSzoWirTIDSC7yAqitd2cYd7FcWeHFNxnARskLAwC87m6JHA8QVX6IFk5cSw8bePi8uzL7GRLJEpJ4WrZPsY4zmSUyxIFAiBAUIpQhpPdSovaaTa3ARMRJ8/BHCCOBTK/o0IYEiabB1abNQXwQ4dC5xtCIBLA7he0fP1zk8lhrHsuiDeAkFC5Kjeut0DBLx8AoeuZqmOLFzV7z6viEIirz6g0BWiOmH+LF80pZ1WBwsDYTSOlvGD6YK/K5Bu5lcjCExBtivsR0YzJODXSXrEcYp/I1Y9WNlgABWOhRnHnm10zTf37T9QQxxpzvtv+7EHE62pacfRTWPfnYd9ixes+3FA+1khXwUz1l5ez8nwhABWsbYaGXMUPOt0bTOGrnQnC8eByS+MlPv0o/hh82bmTb2OZUrbUICXIRZQhig1pWdKE4Emg6uCfQ0YWyB5G4Y+X8AdGbUzDdrYGLtB8B16nTAP88y6Dl4Ut0V6YJYCqW9/+IBIpOFNA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkxMRzJkcVdHL1E1M25MOUJabUJwdk5ZSTg2VGVQK1hnaFhVMVJFUzU0dWQ5?=
 =?utf-8?B?Ui9DbVlWY2NwR3ptRnZjZU1pZ3Z5c1ArWGZOd1hicGVLdHQ0cVhtVTNxU3dS?=
 =?utf-8?B?S1NYYkxCaXNxejJqYjhPRnZYNkZuc3laYjM0T2w1amxFbTRqRGFzUHNpL2V1?=
 =?utf-8?B?U2krRi8vTTVNMUFhQWpsZkdoUkRoSGtwOWZCZzNnKytlV1RoK2E1dUp2TnNR?=
 =?utf-8?B?UlhFQW1PWSsxdy9ISlFqb0NvREhxV0NwTHc3bExPRjFmVmdlWXVNMFVQRmsw?=
 =?utf-8?B?QXpIdEZnTGl2eENhUWtlZ2U0dk0weEVlcE9LR29iREJCb2k3SnN5bHN2b05v?=
 =?utf-8?B?a0x4OERKM1RCajlqK3F3VnF3RlZjcnRxWGpRMUhzSXc1THROMXoxdnRCeE4z?=
 =?utf-8?B?ODlzdytCVDBpdlg5cXNpc3E3cUN4cnBLMEpEcGFZdmhFL2JLYTJ6YjVNQ2d6?=
 =?utf-8?B?QlNFSnpCbjNQRUdmdWZJWHVUUVltNGM0K0lGUnRBNjR5Q2xhdkMyMXpyYzhs?=
 =?utf-8?B?VHZsVjlwSjNrSC96TmRQLzJlN2hzQ0NLcEhnaGVQQVVjb1BVb2g5eHNuZElH?=
 =?utf-8?B?VFpBbnJsT3drWlJlaktpZGZDU09hRElhQU1MemVWQnpSeUlGd2ZEdi9XT2ZC?=
 =?utf-8?B?Wm05bzFxNG81NnpBb3JJRWtKZ0hwVEoyQXVKalJKbUt6dnBZa2ZtaVVDTW1T?=
 =?utf-8?B?VHVXVzJPV012cDhydFd2bkNjdXVSZUVmTjZxdWV3cFQ0TW1XWnRwbHhLR1Rv?=
 =?utf-8?B?OSt2a3c4VjlkWHJMM3BYbGRVNDQzNmErcEFtT1dXZ1RHRHZOcEVIcmVJbzI5?=
 =?utf-8?B?YUV6Z0dsZDVpMWk5RzJTaHpid1Jla2FwcjE1bHloOFBMV2xSaXAzdlA5WTk4?=
 =?utf-8?B?bWdoRnpKNmQ0cjVrUC9MRmZQRmVBMUhXejFpd0VkWlk4OThVZURha1IzbkNo?=
 =?utf-8?B?ZGZ4ZURvbGUvMko5WC96SUdITXJicDkrVko3VjFmRzdjUmlmNjNZTU44Ly9B?=
 =?utf-8?B?eC9xa1V5dmhBMHJwem0xdHp3THVNbGVHd3VOblRibkpoTTFZaXdaSFhSYk42?=
 =?utf-8?B?VFIyL2tmQlJiZno5TVZDdWJWVk9SQzhQbzBNWk4xMlpSdnRkVHh5cTh3aFpO?=
 =?utf-8?B?dnF1UlprU0s4ekNrN0FlM2pxUEY4VzRnWllJaFQxZGVUUW1xZitSSlNoUElj?=
 =?utf-8?B?dTh6dkZtS1hKSTJxMnBNb3dSdTlDdVpoQ1R4dGVjaEVFUEVCT05KazBuYnEx?=
 =?utf-8?B?MEYzNk92a1F0MXc3dlE4c0gvTGplZUp2a2FiWE9EVmY0VUM4dldrT2x3ZElz?=
 =?utf-8?B?WDVqS3FTRXQyWDJBd2pjT3VTUndTcm5NSmxxaWxEOWJWQS9Nc1BrK1U0WHBI?=
 =?utf-8?B?eStOaXFEQ0RjWDR4ZUEwd3B4RVlwbTZXQ0lZTUJ4UFU1TEdOY2U2SG9GR295?=
 =?utf-8?B?R213c1djYitNZFFRd3lxeHNzejYvN0Z0T1NPTm9qczNSaWtSUitTN0drZUJS?=
 =?utf-8?B?OU1WY1A0MTZYREl6U2Q2R2lsL1pPL21ZQzFycThoNkNESU5nZ204VkphcGVL?=
 =?utf-8?B?TzZQQ1k5YmluZnhKN2dReXIrWmN0RHFUc1VRMVJXUkJRNXRoS0xaWWw3NFR4?=
 =?utf-8?B?djlTY3l3WFJROUxqZE12T0hZV0JSc0xoV1phZmR5NXcxcG9RQTdDWVkzc0pp?=
 =?utf-8?B?T2I3eGVxNXh1T1RtNkNMbVRGb09nZ3pHVUpZZnZWNXJTTGdwVkdhekpZN2Jn?=
 =?utf-8?B?ejNmSVB2SkJBMm9tMVlSQ3VDbjJhLzJzTkkwWkh5M1RQZ3J1dFhDbDhDZ0FB?=
 =?utf-8?B?WTN5Q1Njc0MyL1AzQW9HMkg0WFIzL21FZis2Rldyd1VMS2l3YklBUzQ4STI1?=
 =?utf-8?B?MjdWb0w0Mlg3bGMvdytTc081czZ2UWlpMWVVQk1uZUVlT3pzZ0FkR2gyYlgz?=
 =?utf-8?B?MHNMNS9CSGpXNXlUY0FpdFJ5OHliamJxUVExaDZyRHZLeW15Um5wVXM0ajdw?=
 =?utf-8?B?T0F3OHRNYS9pUWVhWFdtRUtQUFViOTZTUHhYZWgzUW9paGRoMXV2M2IvRDBD?=
 =?utf-8?B?OUF1aXc0cWFWem9iRlZhTEtCSmFjZjNLY0hxNGJmNngzL2Ywa3h6U2wxN0Vl?=
 =?utf-8?B?cnBqSmJXY0dhTEFLbmk3M3h3ZzFMUjJhWWJHeEgzNXpGSys3U0p1OEhVWk0x?=
 =?utf-8?B?dUgrZWs5WTFRc0NlNXR3Ylp5bDV1Q2szbGNwaGR2UDZ2a05NODVYU3haMm5U?=
 =?utf-8?B?UU04SmwrdzNoNVAvMXJkaVhlYjBiQXBMRTN6MUExU2hNZmt0L1pDbzl2RFIx?=
 =?utf-8?B?UzRtWXJyWXJiQThyOWhteE9RODFwVlNQdGxMQWViNXB3SjlEbVVDS203VThL?=
 =?utf-8?Q?nJK0iOE8tdKbcxF8=3D?=
X-Exchange-RoutingPolicyChecked: dZBfuGxWpwoTxY3QhKWio+jmpiyvm/cPHBkH/Ig8AqstvRy+QFOGA4Lh1I47yi8CXYD5YIur9AWmt8qWf/yADE7G/UX2G24nysiIetM/Hrw98QWwEM6ZK5fAaP8PAzIgXWBh34faeth7A6dY9e4eN2ozbixDbvRxThWD54aG2joRb7d6egLuP3XdPGt7TRyD4P72TX/JntsLHE8kbjUYVs88fzFxyGEc5GI+DzQZY9aHowtHKDky1NJhrwtFPU/3N2ZeSlupWGZmQw/fYGzDPnFht/VdjTiz036APGByEOE+PfKu0bgZG28NvxhCQ7tspFoCGTST51HjSazMHG+YFw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b54a7d7-4c9f-4fde-8769-08ded10ca201
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7215.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 09:48:53.2245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: faCFQOczoy1rTCqrFmV4v6pzoVgNpt4PO6oizvOVMaJdc6DHjh/P7uud30YaRzNG0Mrs3KY00bHxPL/GUFlscA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6474
X-OriginatorOrg: intel.com

On 22/06/2026 17:50, Ben Dooks wrote:
> Fix two places where the wrong type or conversion of little-endian
> types to fix the following sparse warnings:
> 
> drivers/mmc/host/cqhci-core.c:487:15: warning: incorrect type in assignment (different base types)
> drivers/mmc/host/cqhci-core.c:487:15:    expected restricted __le32 [usertype]
> drivers/mmc/host/cqhci-core.c:487:15:    got int
> drivers/mmc/host/cqhci-core.c:566:19: warning: incorrect type in assignment (different base types)
> drivers/mmc/host/cqhci-core.c:566:19:    expected unsigned long long [usertype] *task_desc
> drivers/mmc/host/cqhci-core.c:566:19:    got restricted __le64 [usertype] *
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/cqhci-core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index 178277d90c31..00614b500b2b 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -484,11 +484,11 @@ void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end,
>  {
>  	__le32 *attr = (__le32 __force *)desc;
>  
> -	*attr = (CQHCI_VALID(1) |
> -		 CQHCI_END(end ? 1 : 0) |
> -		 CQHCI_INT(0) |
> -		 CQHCI_ACT(0x4) |
> -		 CQHCI_DAT_LENGTH(len));
> +	*attr = cpu_to_le32((CQHCI_VALID(1) |
> +			     CQHCI_END(end ? 1 : 0) |
> +			     CQHCI_INT(0) |
> +			     CQHCI_ACT(0x4) |
> +			     CQHCI_DAT_LENGTH(len)));
>  
>  	if (dma64) {
>  		__le64 *dataddr = (__le64 __force *)(desc + 4);
> @@ -542,7 +542,7 @@ static int cqhci_prep_tran_desc(struct mmc_request *mrq,
>  static void cqhci_prep_dcmd_desc(struct mmc_host *mmc,
>  				   struct mmc_request *mrq)
>  {
> -	u64 *task_desc = NULL;
> +	__le64 *task_desc = NULL;
>  	u64 data = 0;
>  	u8 resp_type;
>  	u8 *desc;
> @@ -574,7 +574,7 @@ static void cqhci_prep_dcmd_desc(struct mmc_host *mmc,
>  		 CQHCI_CMD_TIMING(timing) | CQHCI_RESP_TYPE(resp_type));
>  	if (cq_host->ops->update_dcmd_desc)
>  		cq_host->ops->update_dcmd_desc(mmc, mrq, &data);
> -	*task_desc |= data;
> +	*task_desc |= cpu_to_le64(data);
>  	desc = (u8 *)task_desc;
>  	pr_debug("%s: cqhci: dcmd: cmd: %d timing: %d resp: %d\n",
>  		 mmc_hostname(mmc), mrq->cmd->opcode, timing, resp_type);

