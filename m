Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE2D4C8C;
	Tue, 13 Aug 2024 13:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723554415; cv=fail; b=YLEc/3/+9uwFhEdGyltvTLT08xFG6291dwpbhSId8ZI+OOVtIFhq6BvqF2dAgmWQnjfFT0dsoMrPY9DLQ4c2KNTr/mKIuOYSd4TEdozp8WsmnQjswSgDq/bS/0aQXqxpc5esqRtZnYSx6lguqKPVKYv3HuTC4tX+ic/fcMDHq24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723554415; c=relaxed/simple;
	bh=XNIPZ/QdcFSd+jS703gZDTh27vGLpQc7YAqex+NjcPY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gf2E9uUYcTIA7t7Mjr+7UtlbRFdtD+/CNjpunZUQKXJ4XTlFxSgsTJEQoRth310xX3HMAF2o8YvRGFadiUAu44l1UC65tDP7HwzrxwD6gmHMWhOat6U2IZ9WSxl0eEb0MWMDbZ6dW5G1Lnr7mNAkzQwBuk8Kfqrv1/Zxeo194qQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=malcywrH; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="malcywrH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723554414; x=1755090414;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XNIPZ/QdcFSd+jS703gZDTh27vGLpQc7YAqex+NjcPY=;
  b=malcywrHqsYmA0gdFMKy3/Vh0B2HbQ27bZFDj6Nx87/F4bEew3dyv+UY
   5UsQhPPDpiAnuZTekUzmi2elpkx8QOIztsVCpgGe4+YKpyJfHn1UZq/uQ
   ou+WCV8toPa85/E9O8AEJklQiybijn3ZUsJpNpztuXZgnLmAtSPeQoOiq
   6cFaTPihiI59KLxCpL6Ye3R7z/LDxhsiC4CYKQFa63EKdDoPd6BHzxHCc
   Vi1N0/UqViIVRMNJZrSsvYK5hvgqsHqUGChKcQCEIbLhZ7YMaU1Xj2XrA
   r88+GLcFEbLnqSSslhI+tpvX+cHiNgUgnsd9tve//6sfdoZ2FsFlSidMC
   g==;
X-CSE-ConnectionGUID: dV7T0loiQCGBfIZsc6BgQw==
X-CSE-MsgGUID: 1CfXymIcR62Du36f6LZHkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="12984921"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="12984921"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 06:06:52 -0700
X-CSE-ConnectionGUID: kbkMnMh7S46XYCJddBSmfQ==
X-CSE-MsgGUID: 8kYoAHpdS6+Zj9E2ksY/AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="58608479"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 06:06:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 06:06:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 06:06:51 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 06:06:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2JwHRwrDhcne94GF+v7QjbeCSQC96Tw1Jod6saCBVG2H+bVnETVuHaDqZ5qaeK0fU98bkuQP5ayOKKkYdk8K3Kl4MyBlKwFYYO3ARrZBG3MDj9hwJs1bgm/V9Ap1X22IJvdD4OPgGn8tBCUCFfXZ7fcm6Y1N+VT4eKLyBAZnvRk8culFL9wI/IJzYNcDIIuqYi/9n8NhbSLC7mmGjPUbBJePS8tPf/YQVQcQFZ5OJNZeCVT2oqx+kHilg2bCkkEzcg/B8B/zyX5y69SavH5ELKnwSBgV1sVspq0cnzTAuqFmooge+O2KLkW7aMN1P1ziUn4r2NRly7iLGvz5hkwXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNIPZ/QdcFSd+jS703gZDTh27vGLpQc7YAqex+NjcPY=;
 b=OrQNxumA2eI0jKKsGffh4nUGAPXRhc1QhuuH+dnARzeEM9pa0maprliEzgdphxDGj48+YeCbfE8pZTEoQR8J+Apb8Do9zEPg47SFyKW4bEhyi2iN2j3BGhceM6K9O2/aVtM8nKZPwJaEvZwOkG6KO0JH5zXPFX2SVkgl4oAGCFNRuqJrfBjawyjyPrNvNlCoB4NoHQr+GAyfUuSFAKdPCcgtDcxqN9T76/ECx0F4DfpveCGp7q6JsvZyKdcoiipm0yhibdYOPqr9eHF/9jgM06uY/lHJd1CEFrYQhbrWEH3x1q3TOiAVnRwUDzc/SormDnZ9gVy9+z9wuufTQPXRsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5)
 by LV2PR11MB6024.namprd11.prod.outlook.com (2603:10b6:408:17a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 13 Aug
 2024 13:06:48 +0000
Received: from PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::d720:25db:67bb:6f50]) by PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::d720:25db:67bb:6f50%7]) with mapi id 15.20.7828.031; Tue, 13 Aug 2024
 13:06:48 +0000
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jens Wiklander <jens.wiklander@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "op-tee@lists.trustedfirmware.org"
	<op-tee@lists.trustedfirmware.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Shyam Saini <shyamsaini@linux.microsoft.com>, Linus Walleij
	<linus.walleij@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, "Arnd
 Bergmann" <arnd@arndb.de>, Manuel Traut <manut@mecka.net>, Mikko Rapeli
	<mikko.rapeli@linaro.org>, =?utf-8?B?QWxleCBCZW5uw6ll?=
	<alex.bennee@linaro.org>
Subject: RE: [PATCH v8 1/4] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Thread-Topic: [PATCH v8 1/4] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Thread-Index: AQHa7LwONeZ5Kj6JmEC+yxNK4Hs31LIk7SmAgAAgmQCAAALAAIAABfPAgAAMMwCAAAZcYA==
Date: Tue, 13 Aug 2024 13:06:48 +0000
Message-ID: <PH7PR11MB7605DCD728BA31F475816C8EE5862@PH7PR11MB7605.namprd11.prod.outlook.com>
References: <20240812133127.865879-1-jens.wiklander@linaro.org>
 <20240812133127.865879-2-jens.wiklander@linaro.org>
 <2024081346-dutiful-stalemate-0e07@gregkh>
 <CAHUa44HYQVhT0=E9py2JsO2X93wLhZ=YvH0fBqQpzFBujSGgtw@mail.gmail.com>
 <2024081346-riveting-unwired-d9dc@gregkh>
 <PH7PR11MB7605F50AC47D18361D933CE1E5862@PH7PR11MB7605.namprd11.prod.outlook.com>
 <2024081315-cofounder-stem-8b3d@gregkh>
In-Reply-To: <2024081315-cofounder-stem-8b3d@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7605:EE_|LV2PR11MB6024:EE_
x-ms-office365-filtering-correlation-id: d64762ee-093b-42b8-c47d-08dcbb98ca4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?djRxYjl2VG1pTG5uRGZvVVg4Z2RRYUY2c1JpbGVQWmhUc04yV01DYVlmWFBQ?=
 =?utf-8?B?Wmh6SVdaZk9LK0pmaUJ5U2VwUVhDVTV2MXJFVlhkQ2xSY29ncVZ2NDAxVjRz?=
 =?utf-8?B?a0wwYnVYcWVocVJ5a2l1aHZEMHR5QVpua2tiOW45M0liUnNmMUp2ajVEbnNr?=
 =?utf-8?B?UFV0MjdlU3JNUmx0VjZlb1VzWWtBZ284T1dLU1RoMllpYmN6d05ZODBvNnVn?=
 =?utf-8?B?S0NibFIvb0hIejRSVk9VNzJsbThEVldOTFpVOE9mcHRBbTE0bHAwbGdkM29M?=
 =?utf-8?B?M0lBeitrSHlWSU0zNE42NkhGVmIyTTFtWFkwS3pHY3dGdC9BTkRXU2JCZENQ?=
 =?utf-8?B?WVN4NXhKUGJ1V2xyZlFtMENLU0g2cFRMUUdiT1grUmpDUWNlV091eHROMlJT?=
 =?utf-8?B?U1ZNcXU0S2hJTFIyY3JFTEJ4YkoyRmh6ZlZMdGhpSjNmK280b2llMGoycUNi?=
 =?utf-8?B?RUN4bDdma3F0WTVTUE94aWlSM2xRaDYwd2RXK09xZkZPSWZ4US9heVVvZW8z?=
 =?utf-8?B?Y2E4OVFseExwOUNSQVFTVEwwWDVMc25LUmlOVndtY0swaHA2Ym1UYWdSQ1ln?=
 =?utf-8?B?bklWb0libFV1MVljdUhzVzh1U04xWUNKNWJpcnlRYXBiTFY4cjJpSVV1OXpH?=
 =?utf-8?B?MTQ3OEhxM0VnRGNNNVU4VitLZGh1ckpzWlUwWGUxaGlVNG0wLy80Tk9GeTNy?=
 =?utf-8?B?MXk4bzlYYVc1MTB5di85Q3Y2clNUc1lZTHRKUDFKVUlZTXBlbUplRHhEM0Rx?=
 =?utf-8?B?MXVzaTFKbyt0dkdqVCtnQjl3NXgweUpWT0VETWg0Tk42NC9vc25hYllBalEw?=
 =?utf-8?B?aHk2V3NKS2ZIalk1R2I4Rm5nZGc1UlJ1RmR4eEZ1cE52U3BaZ2RGV3NoUG50?=
 =?utf-8?B?QTgyajFrTFhidW5xam8xMDZWckNCTnkvMUZwZVhtbnhrVG9VWEhDY3ZDcXNR?=
 =?utf-8?B?MTNJSnBQcDVoVEszMjNKaGpSNlJIcER2ZEhwRFBwUWRid3ArN2h1eXVmMDNV?=
 =?utf-8?B?ZTFQeEIyNG9oOHFoTjhsZjd0NVkwZkt4Z1lsUFdBVjlMSlNNQTZXMEIvakVo?=
 =?utf-8?B?NldrOVNXOXlPa0lLMFlVTXlveFN6emU0UVg1OE9qdDFhZjJKRkw4a1dwRTBU?=
 =?utf-8?B?SThsRjdmS1BpK2k1SUkzTzROeXVZTVVOM1QybFNUMkR4STdhZi8yVCt5cU9o?=
 =?utf-8?B?QmJlUHFOblRjb29EOEZ4dHQ2elJsMGVxTEtoaGtGNDVkempwREZ0NWNqUlA0?=
 =?utf-8?B?TTJ1ZHMvWEpkTzYwYnlPWS9HTGtDN1hwKy93ZTR6MjJGd1AwZVdZOUsxQ2Y3?=
 =?utf-8?B?SWszbEtKK0V4VkNuR1RxbE9lWERZelJlLzZwdHBXbzlscTJHQXFOZEsxVUdt?=
 =?utf-8?B?Tjc0QWlGVWZHeUJEMUMrSEdPY0Vyamc4b1VCUVFaNGs1ZlFGVElOSU1GN08y?=
 =?utf-8?B?aEZ6MjRRYlB1RzlzWU43T2VxVHZvdnZwSmx3L203K0lleThFSFYzeTh6MDJT?=
 =?utf-8?B?eGpkUm5SQVlVbW5OY2xrU2NCUU5zZStUU0JZbE9jcHJ1alBMSGxGQjA5L2hL?=
 =?utf-8?B?R0F3SXp2NU1uK1dwdWhVd0tlZWFtL3l6SGpYdnlTZlBYTzhDWjhVWUQzdTlq?=
 =?utf-8?B?bU5rM3dJNXZUek9BRU1qZ0VaczNmeXFqcXExU0ZxNlFzeHMxOFFQOFZCdTFQ?=
 =?utf-8?B?dnFXZEV5dGJlSjNKZG9IMG5OWFoyYUg4dnlIVmdRV2R4c0JrZlhSekxpeEpx?=
 =?utf-8?B?V2JLaEdBUzF1SnQ5eTFnOGxocGd1RVFWeVdoOEdYUmxXZUpVYVNmVXgwZEJl?=
 =?utf-8?B?bUpVNFVSQkQzMzRMZVM2cGgxcEFXS2pWT0xDRHFKLzVXaTBtbjBUS2duRVln?=
 =?utf-8?B?MEJqTzRwNTdaUlpWamF3NERHTW1STVF4WFRJWUdUeXhZUHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aW0zc2FOL0ZXeitOVW5BWWZaTFlFNGpFb1JqZnRXRzV2bWhHNHJXYk01ZFUz?=
 =?utf-8?B?WW00SFgyZ1EwUExiYm5FNFVSWWF2c1Z0QkRzUEwrVTk1SjRvL09oZ1Fpdkla?=
 =?utf-8?B?VU83OWZsZGtodkdHNjNLK2ZLVXEvNUdXOW1YdkZXRDIxbG9iemhEYjdHSFIr?=
 =?utf-8?B?S24zMVRxK1duM0t0UXlQdVlleWYyblVyNkw5eW1mSlNzd3VIWk5PeUVCUUJ0?=
 =?utf-8?B?bDQvcGxUUUZkd3lRNUZwMFhLdHFraG9GRVcvWUJhaXkzR3NpN3ovVGtjMXVL?=
 =?utf-8?B?UVpmSkU2ckJHVXJlaE1nM3V4MC9xTTNZRlF6RzZRSDJPQmRURVpRSnNSSjIz?=
 =?utf-8?B?UjBNSndQZVVuaGExWHlzT293N0cwQ0RWbm12UkU3dUpZei9WL3N2d1l6Z05o?=
 =?utf-8?B?VHVjL3FoREovMHA1THRLS3E0YkJRTW5pNFRlc1pwclRhRjR1dWV2OVR2L040?=
 =?utf-8?B?OW9uaENQZWlwVFMya2RKWEFuWjdtbW5URnJxcmpNZzEwQjJubjlKeS9ZUmpl?=
 =?utf-8?B?aFRZVXd3eWN4Nk81cXYwc2IwV1JoM0k1emJ4Mk5NTGJhYk8rVk5KQ3RQclZi?=
 =?utf-8?B?YStWUXZBNmg4U3o2QWIxdzdVUkdXQXBPVTVzMW9IeEt3UVE2RUZudytpL3l6?=
 =?utf-8?B?dHpnNmVjSkpPd0R5QUlNOTdjWHBTcW5FYTZrNFNSWW8rekZWSVk3NWxYSkEv?=
 =?utf-8?B?Mk9TdWdEY1pEZXdSc3lpWCtiN1dEMCt0cEFuTUR5bkJPMUpSVFBPTU1aajVl?=
 =?utf-8?B?bXFBa1FQOU9ka2RLc2JNZ0g1Ky9MaVNYekh6TkJhZi94RksyalM4czhzODVv?=
 =?utf-8?B?S3lNWTdQVElEdUNidVVNYy9XclcyT2NKY1ZnVXRRK20ycEdvTW51N3BlVXY2?=
 =?utf-8?B?SVFTVU5RT2hWUEwvcWpPTFZzcFh4SjFhb3RXcS9MMDFFVkwyZE5oR3dYdUJ5?=
 =?utf-8?B?RHpDdnU3Y0hpVU56SkVqQmxjL0luV0JFbjhPWEVnaVl2QVdiUXh2NWdsdXB6?=
 =?utf-8?B?L3M0Skhxa2Nic3ZFd0ZhNldzcFNrVVdyeDQrdzlBSzZZVlhDbzIrL25WOU1G?=
 =?utf-8?B?aTJCSWJJNEtQNVZManFTVnpPQWZpSHp3Z3JnWVEwdCt3OG1PaXdvaTJVR0pl?=
 =?utf-8?B?YjYyOVk5d09xYzZYVjcxMlllUjFOZ2NNN3MySitpZjJZSHE4WXZnam9lSStX?=
 =?utf-8?B?cDRCOXVDTTFOREoyNmxpMkZqNXNPYUJwUUtWSGhTTUxRZ1hTcGQwa1RxeHhH?=
 =?utf-8?B?RzZ6L2xaZk9GZHRhUklxMjhGbmJQY0hGVlVjWk93anB0cUhMOUFzanhaV0tn?=
 =?utf-8?B?cGhtbU5QM3hBem5BV1VUR0FidWFrN2J0TWJOMVpvNHVSWG1JYzBXRUpmTnF4?=
 =?utf-8?B?bnlLQWVJczBqSzJya0wrZ1NRRXRzUGlhRlBDV01sVnNCbEhCcGRmc0t1REtD?=
 =?utf-8?B?bXVzSnhWRk1iSEtVbnZZcnJpT3ZoaXgzd3pRM2dTdktOMGFkaWxGT3p3SUFW?=
 =?utf-8?B?eFlqTHBkSE05dnVBS3FLVFVkdE05Umt0elpOdEg5NW9MR1Yrb3BxRFM2N0NB?=
 =?utf-8?B?UnlrR0VLMUxrWlVIVnEvaVFEWnNUalkrT2k2bjA2aEpuT1EvQm1sTFVOY3pS?=
 =?utf-8?B?WU5CeWlTZExiaVZYMjFqbE4wQXRvc1hCYVhOdi9NYTNDMWw4Znl4RittSk85?=
 =?utf-8?B?RzluS3FCbzRpakMyU1FsUkJ3cnlIeWdJVWJLU1ZRZEZqMlkwdmQ0QjIvTkNa?=
 =?utf-8?B?OVMxNDUraTJ1UEJPRGhQWnpRZExEZUpvbFQyZTNTVXFnTWtoWDdlWVZReEZT?=
 =?utf-8?B?Q3puSFdEdU5RZ2syY2NLVkV4Z2FWSFBxZjZqdFozVzgrWC9xQXdORTI4dU9h?=
 =?utf-8?B?ZlRDc0xmbHY5bk9mNWJwZXpTaERQRzdXVDBNMDhjRElQM3RoRGJ3RDVRVWNm?=
 =?utf-8?B?bnEyQWYzS3RHRUljeVZQRnd4eVBueENLRmZ6b3FjdmpTc0ZQNEhxRTRtWWo5?=
 =?utf-8?B?VlRTcGpqR0dXeHQ4Q2hORGUwaCszbk5tcXRZa3BUMjk0dmYxNCsvaTRGUFRQ?=
 =?utf-8?B?NjBqN05SelB5cWV3cHp4clR5azMyYjlRMXhyMGNrTWNpbWNuaTZUd2VrVDVl?=
 =?utf-8?Q?WCFaKiVMXlbaU1vogj3Y8VWCd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d64762ee-093b-42b8-c47d-08dcbb98ca4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 13:06:48.2737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iOoMBUsiSgILLwwH/F+sM3ZHnrvd3T4YYQKRKF/+hjpGtmvNjEOqS0GDleRP0kBmwPzmq1z/DuZkRuwAgHqXYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6024
X-OriginatorOrg: intel.com

DQoNCj4gDQo+IE9uIFR1ZSwgQXVnIDEzLCAyMDI0IGF0IDEyOjA0OjAzUE0gKzAwMDAsIFdpbmts
ZXIsIFRvbWFzIHdyb3RlOg0KPiA+ID4NCj4gPiA+IE9uIFR1ZSwgQXVnIDEzLCAyMDI0IGF0IDAx
OjI2OjE4UE0gKzAyMDAsIEplbnMgV2lrbGFuZGVyIHdyb3RlOg0KPiA+ID4gPiBPbiBUdWUsIEF1
ZyAxMywgMjAyNCBhdCAxMToyOeKAr0FNIEdyZWcgS3JvYWgtSGFydG1hbg0KPiA+ID4gPiA8Z3Jl
Z2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24g
TW9uLCBBdWcgMTIsIDIwMjQgYXQgMDM6MzE6MjRQTSArMDIwMCwgSmVucyBXaWtsYW5kZXIgd3Jv
dGU6DQo+ID4gPiA+ID4gPiAtLS0gL2Rldi9udWxsDQo+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJz
L21pc2MvcnBtYi1jb3JlLmMNCj4gPiA+ID4gPiA+IEBAIC0wLDAgKzEsMjMzIEBADQo+ID4gPiA+
ID4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gPiA+ID4gPg0KPiA+
ID4gPiA+IEZpbmUsIGJ1dDoNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gLS0tIC9kZXYvbnVsbA0K
PiA+ID4gPiA+ID4gKysrIGIvaW5jbHVkZS9saW51eC9ycG1iLmgNCj4gPiA+ID4gPiA+IEBAIC0w
LDAgKzEsMTM2IEBADQo+ID4gPiA+ID4gPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEJT
RC0zLUNsYXVzZSBPUiBHUEwtMi4wICovDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBSZWFsbHk/DQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiBXaHk/ICBJIG5lZWQgbG90cyBvZiBkb2N1bWVudGF0aW9uIGFu
ZCBhIGxhd3llciBzaWduIG9mZiBmb3Igd2h5DQo+ID4gPiA+ID4gdGhpcyBpcyBhIGR1YWwgbGlj
ZW5zZSBmb3IgYSBmaWxlIHRoYXQgaXMgb2J2aW91c2x5IG9ubHkgZm9yDQo+ID4gPiA+ID4gaW50
ZXJuYWwgTGludXgga2VybmVsIHN0dWZmLg0KPiA+DQo+ID4gVGhpcyB3YXMgbGVnYWwgYXBwcm92
ZWQuDQo+IA0KPiBUaGlzIGludGVybmFsIExpbnV4IGtlcm5lbCBoZWFkZXIgZmlsZSBmb3IgYW4g
aW50ZXJuYWwtb25seSBMaW51eCBrZXJuZWwgYXBpPw0KPiBXb25kZXJmdWwsIHBsZWFzZSBnZXQg
dGhlIEludGVsIGxhd3llciB3aG8gYWdyZWVkIHdpdGggdGhhdCB0byBzaWduIG9mZiBvbg0KPiB0
aGUgY29tbWl0IG5leHQgdGltZSBhcm91bmQgZXhwbGFpbmluZyB3aHkgaXQgbmVlZHMgdG8gYmUg
dGhpcyB3YXkuDQo+IA0KVGhpcyB3YXMgZmV3IHllYXJzIGFnbywgYW5kIHRoZXJlIHdhcyBmZXcg
dmVyc2lvbnMgb2YgdGhpcyBwYXRjaGVzdCwgDQogYnV0IGl0IGxvb2tzIGxpa2UgSmVucyBpcyBy
aWdodCwgYXMgaGUgd3JvdGUgaW4gYW5vdGhlciBlbWFpbCBteSBmaW5hbCBzdWJtaXNzaW9uIHdh
cyB3aXRoIEdQTC0yLjAgb25seS4gDQoNClRoYW5rcw0KVG9tYXMNCg0KDQo=
