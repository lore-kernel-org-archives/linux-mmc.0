Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38014206D;
	Tue, 13 Aug 2024 13:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723554437; cv=fail; b=Qv/ktrT1I3b7sj6S9Xpbq6jIx6F2htoSuvLGnHW4uJC3QvpXfHVsA6DHp8siLQ0SAtuK4Yg14/zQoEQIWOYVeZgmhjsihhiKuFvLKm/Lc9R2QJDsva9P5rzHIKDSpREIFtn1p0ot6NzMzxdJx8a6FupYLud9BMby8+2g3OIldOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723554437; c=relaxed/simple;
	bh=2vdErBOuT9EaEZVnd1sraLuxn3DVUQkHfAOPZfKnyOM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lArAxK6yY4L7J462hfZHDdH4wKDo3lCQ9TS8Xp8cdh+9mhfKMoNKqrkoiv/hfuY9oGMIC6TTK6IdKdY9Jo5f72RkHYIHA5fhht94Qxg4BJ98RsLDci2mFkIlyQaK7YtZsp58fbmbVo3qNrSQUSwdLZHvzz+6ziNQcA8L5yswCVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ft2hMTs4; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ft2hMTs4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723554435; x=1755090435;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2vdErBOuT9EaEZVnd1sraLuxn3DVUQkHfAOPZfKnyOM=;
  b=Ft2hMTs4nQWttrfLFUZ6YPGBFdazkXiv10fxB8EJ+gFevR6UUJvdTDMa
   8fiithgrSlupDUtJsa0hxxG3IozpBhO6TJj8AEWVX1D++Uuv7eYALmjwl
   otwSW1gvcQ3XEWfUmcAp8C/ZfUJSTucWS882suPIyvPPCGCY5vLp0NRz0
   I1CBnrE3MXaBEjxZIC4lu9QxoKPRH9pmq5NuxVLWWP91TP/cvN2+kzQ93
   9J0rr3GSYy3wBfzTU644Ztk5T1K0CQqcgi40zLYkqMqDJn+bNuQT0Hsmc
   rygnVAyHBxDSsstW1+8yNQej6n/YMPIiJk/NQrwct6jPmVST7l9zPqnI1
   A==;
X-CSE-ConnectionGUID: nFy8r1tHQvW5R/FYfAtkAA==
X-CSE-MsgGUID: plCb8HDqT/ymRMHef/wQcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21860704"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21860704"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 06:07:14 -0700
X-CSE-ConnectionGUID: v9jf5Q3GTBu6x9wrqcEmNw==
X-CSE-MsgGUID: e4K6o3mGQPuIkqBKXmpyYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="58627124"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 06:07:13 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 06:07:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 06:07:12 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 06:07:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMs53QR1ChX0A4cYDDL2eyJKFB1t1wbPzI7+FWW5EPMlmmeP9zlRlizl8T2NLkcv0OL6DvNRgNOObm2kXtGzyjbsfgo+WKOO1VfAfb99/uEehEP9OZPfG8smTxc91hr5QYDHPtnJMRC2jTS0GAdE29ZUptqbieVfwMdeo5fuFzHcyUDLckcnFUl7/u2lyX06LdnzeGBz4hpl+Dtir/4WpGDzhPaAx4odpAVAlGg46QDdG/qz1R/+205IoBVXNKzxeGtkOZlt+fCc2YQogdLTXWSDbsvozYKlifnDIkkvQl3bZMhCTX3CHBAkpOewWI53kWRxpk6SL2Rgd36uwcQxtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vdErBOuT9EaEZVnd1sraLuxn3DVUQkHfAOPZfKnyOM=;
 b=T6eVqTm9VMy+NsLtCrny1z2sN4zdomTdkX7F+8uYHfJQJkd6mpCRj3sD4vXx7KlIgDwADrVgts01kjdp+AeKyIsbn2kwz/QJmH53uCjstIFNX1Ptu5TLbz3LkrGRPUT7xKuI4rpehavLOdk2ocIJjiYJGKxyTa2OzUHLUzmurBqrp7hW8yqpc2xMFFHD8RIWZkSXJCE0vIThwUt5R8yW+8nbvoyJtNFa7WPxqh+iJYKWJEL08e/t51DLjUSbXNtMAScwtR4i79APj8cf9+B/rzTgPnKfHWZUGPKwPPr2P3wbe+eDyb3NkJtUtjKr4ywQo1E30wSybBS9W9dEMuG+bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5)
 by LV2PR11MB6024.namprd11.prod.outlook.com (2603:10b6:408:17a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 13 Aug
 2024 13:07:07 +0000
Received: from PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::d720:25db:67bb:6f50]) by PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::d720:25db:67bb:6f50%7]) with mapi id 15.20.7828.031; Tue, 13 Aug 2024
 13:07:07 +0000
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jens Wiklander <jens.wiklander@linaro.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, "Ulf
 Hansson" <ulf.hansson@linaro.org>, Shyam Saini
	<shyamsaini@linux.microsoft.com>, Linus Walleij <linus.walleij@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg
	<sumit.garg@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart
 Van Assche <bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, Ard
 Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Manuel Traut"
	<manut@mecka.net>, Mikko Rapeli <mikko.rapeli@linaro.org>,
	=?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Subject: RE: [PATCH v8 1/4] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Thread-Topic: [PATCH v8 1/4] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Thread-Index: AQHa7LwONeZ5Kj6JmEC+yxNK4Hs31LIk7SmAgAAgmQCAAALAAIAACjcAgAAPIVA=
Date: Tue, 13 Aug 2024 13:07:07 +0000
Message-ID: <PH7PR11MB7605877E4EE14DB19CBB26F0E5862@PH7PR11MB7605.namprd11.prod.outlook.com>
References: <20240812133127.865879-1-jens.wiklander@linaro.org>
 <20240812133127.865879-2-jens.wiklander@linaro.org>
 <2024081346-dutiful-stalemate-0e07@gregkh>
 <CAHUa44HYQVhT0=E9py2JsO2X93wLhZ=YvH0fBqQpzFBujSGgtw@mail.gmail.com>
 <2024081346-riveting-unwired-d9dc@gregkh>
 <CAHUa44GnG1uonKASAYHSt=rNC=73svDFgCfe6XyQT+c+xs+_XA@mail.gmail.com>
In-Reply-To: <CAHUa44GnG1uonKASAYHSt=rNC=73svDFgCfe6XyQT+c+xs+_XA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7605:EE_|LV2PR11MB6024:EE_
x-ms-office365-filtering-correlation-id: 2ef75ca7-7393-4e1a-3e3b-08dcbb98d5bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SXNPZWdXNmFxSnpIdzVZZUFyUElVVUNhZy8vMExKbTV0TFRxMHpZSTMxcE9U?=
 =?utf-8?B?SWw2blJ0VjNucEdZSVd1MXRCd0JVTENCcHVSU01IaHM2anlSRXpUbjRqSE5M?=
 =?utf-8?B?bGZlMCtSekFYSWNuTndDWFYrSEU3V1A1VWlwaEIvbXBXT24vN0tGVDJHMEJ1?=
 =?utf-8?B?WVM1emdwaGFITDNoNVlVRktRV3VqRUk1bFAxUmVzSVBtcUwrQXVtSDJKcFg5?=
 =?utf-8?B?bkFTc0JQVU13czBSVWJqZ01sNjk3Qk1jVmZ1eThocnh1c3hoVHFzVlMvelRS?=
 =?utf-8?B?ZVJUUDg2V0wzYWordjkwYTdlMG9meG0vWXJMYmQzMGtGNzdOdnhPM08xQW9r?=
 =?utf-8?B?aU5nM0dpUW12NWhHQnJCd29hOEl0SVJaTkpIUE5vOWs0bmNMVTQrUUlNeDJL?=
 =?utf-8?B?RDFBSXBCWVJhZ3ptVytjNzZJVGlOdFJlNmZoQnk3MXloMy9oL1dVaGdTdm8z?=
 =?utf-8?B?aC9FYWc2ZE9PNjBSNitvM3NQRVpETGFlVHFVNWhWZUtkYUxHSzVJZkdJVCtO?=
 =?utf-8?B?a2s0TkNoYVdhZlZ5dzhvbWY3MWZVa2YwWTBwOWt5anExWjFva1VGOXltLzJC?=
 =?utf-8?B?MzFZb0dtTVpkRnk5bXdqa1ZRQm5GWUdXbXJMZERYcGwrVFE5ZTE2T0R2QnZJ?=
 =?utf-8?B?Rkd1YmRHMlVQQkhnVTFaK0tGZHlHbk45UlFRSUFjQk1QT0gwS21MWFdycFht?=
 =?utf-8?B?ck9ld0psakkrMXNLSVpOVHF5bVRPK2R1T3VPU25UNnZHQms1WnpmM3N3eDJu?=
 =?utf-8?B?SDZabVBOZjZxRGpOa1ZLRXgydFlyNStrTXhBb2dmWVl3RCtlaXBFVTZreVdl?=
 =?utf-8?B?S1RhMjZ5UnZzdXdMc2hjY2pleUd5NDkvNVMvQmQ4VW1jYlg5MkNIZktObUFp?=
 =?utf-8?B?ZnA4a3VmTXNXaFVZcEFHaXVaVUlGNnBMb2NkWVdJOHJ4VFE5bEw3eHNCMHc5?=
 =?utf-8?B?bHB1eFp4Ri81Q3hJNTI3M0VhcGpYWitndUJqMndaTE9BUFlzcjZGd0JCdU9C?=
 =?utf-8?B?VUpRUmNJWjFxUXhINis2UDVkS1A0RW5MOG54Rk56cWhCdE1QUE9OUU5qSndT?=
 =?utf-8?B?eEpKdUFINUdiNU5YbEdCcStqN2VzRWtVUjhGL1Y3cVRNcE1qNDRMYUFiNVdp?=
 =?utf-8?B?TFNCaWxzbnZ1TUpjb1RKNDV1QzJTMmFYa2F5ZmhycXFaZlI0bnhXMFF0V1NP?=
 =?utf-8?B?c3dPMmF0ZzB1WSswb1RvOHdldmJJSDgvOXQzcmxTK0o4eHMzOHBJVVBNcVRN?=
 =?utf-8?B?WGFmRnhjbjBUZmwwbU4vSndubHF0S205Tk9idW5oOEs4dnUrZ3VRL0s4QjZn?=
 =?utf-8?B?RGcvcEhqMnA3bkdFc1RMUjlDUUo5UWY5aEw0OGtPTzV1NXJyeldaS0ppY3Nn?=
 =?utf-8?B?SThWcG5EYlFPbmd4WVUrOGdrbDFKb2wxMFo1bWV4bXlsSDRSOEltVWRrTkt5?=
 =?utf-8?B?UW1HVzVKdTAwcW5zZWk1U2JIWnYxUk9uTktWMDhrRTgzK0hNb2VqK245ZS9s?=
 =?utf-8?B?cFhqM3FGR0Y1K1NTYmRaZE1lcVdtakQrUjNuVnFNOFgrcy90REdjaHd3LzNa?=
 =?utf-8?B?YW9IMVBZQ2twczdsNnJIZlB6SEErN290SE5OSFUvUngrRE9YYUErbDErY0xE?=
 =?utf-8?B?aitJaVgrMFdaZXU0L3J5M3NwbWlwb0dpQ2U3aWM4ZjJaM2NXb2tSc2pJWVRI?=
 =?utf-8?B?ZnpRWmRER3dLL1JaWlJ3dG51M1grcGh5SFlFK1hUcDloWWJJbmFJYzliUUJV?=
 =?utf-8?B?VnQ1a2U2RE5menlQa0wwdUZXQ1cyN05hNVk4UUFmSWQ4S3pmeVpuM3BRYkxm?=
 =?utf-8?Q?m3dNyO7n8UaJzS6xHJSWbRAy2/Vjbf7uW18M0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGJudFBPdnZVOHZybDk5WnhzQkxtdDEyMjF1eU9OZGR2OUFTcEZFM20xb3Fp?=
 =?utf-8?B?MzJMeTErWGZUR0hRY2N1dDF1MjAxTjUxM2prV1JadW9HVXZ1ZHNOMUcyck1x?=
 =?utf-8?B?NVdjNGpJb3EwNTRETjJ2cWY2VlBuM2pnSGdhZWl0MG1tNjUyTE9vNkZ0N0ds?=
 =?utf-8?B?Q0dDSDN6T1EvSGNEdTQyQ1NTV3A5aWJlbVBaR1ZlL2hOTWJneXZDM2VEVmFT?=
 =?utf-8?B?Q0Zod0p0bytqVmZycW9vbE5PMDVOS05uZ1pTT1NDV0lJOWtYZmY5WCtvOE1q?=
 =?utf-8?B?SDhCL0pKdkxRLzBtKzZpSEoxMVJIWlB5Q0l4UDM1eWJYeFZHVTJHNGx3Wmc5?=
 =?utf-8?B?Umpoby9tNlpQUzVIWHJqUy9GeWVvekJDQTc1Z2hhWDIwem5hb3gyLzJqL3Az?=
 =?utf-8?B?TmhTRFA4Sm1icVRqaFFJdHBqenpCQ051RXRpTVptSERTVWduNVJDY2l4QlJ5?=
 =?utf-8?B?K016d0RTTkMwb0lSZEJwRmpaZ3NuamtCOFErMEp3MUFMN1l3enhRNW9FbFJO?=
 =?utf-8?B?ZWU1a2lHZzBxWTlqSzg0NmZCTkFhT0JHYi9yeEJ6NDVtSUNkeDJPdlZVZTZp?=
 =?utf-8?B?alB1OWljWkVuOXpNV0RwYjJKZW5zeXpjVHMrajdvSDN6Z3JEblJqY2h4Qmpu?=
 =?utf-8?B?ZXMzT0RYbFpJc1hwc0hrM2orcnZCRGYxWnp3UzVyOG5YQktCeU13aTRscTRy?=
 =?utf-8?B?SW5UOFFlbWc0N0NLTmhPQzlVUFdNN1FBWDRFTmoyRjcyQzNCVWxCSlg4ZnZE?=
 =?utf-8?B?UmErV0pqZi84dUFLVElaa3haVlhQbFkvK1pyUjdNOTNlS1l2SlNPc05KWVQ2?=
 =?utf-8?B?dEJpYTJrUHU2b0lJK3NHdHdTczNJY0ZSQ2lKczBvYlQ0eHdiaSs5Q0E0RDB2?=
 =?utf-8?B?bmNEeC9pSzFMaEZ2UE5vbUREY0pkaTNhV3VqWlp2SXBWaWhwREs0ZVJpV3la?=
 =?utf-8?B?MGdOcStmbSt3RVZkeGxOeHlBY3FqVEtneG9rNkphU0JNd2hacXdUdDBXaTMy?=
 =?utf-8?B?MEdKYXF4RXRIUzdwNVdJZUZPMUw2N1dkTDZ4cTZqbW9jM0hwZzRwaTRvYVdF?=
 =?utf-8?B?V0RkdGNIODZqN1I3em1jZ3RxSlU5Q2VjTzhTUk92Ky9zUG82NVdRNlVBVVNW?=
 =?utf-8?B?a2hJenVpcUl3VGN5cGU4RFd4RzBXSm1nZDN5WGlFRUx0T3BIU1BTYVQ4ekwv?=
 =?utf-8?B?ZllWdnVOZFlmbU1ENWd0TUtVSFY5UEFOU1grZWJCUFZiclR2TEI1enI3azE5?=
 =?utf-8?B?MFBqTjkvZFpoOG5DSEZodWI5cjc1UzQrdkp0R3ljb2JweHpTMWg1cVpEbzV5?=
 =?utf-8?B?STZvMkM5dlpNb0hJRTlNMm4yQzVDcS9FUGtUdVh6ck4va1k2SWJTaklieUZS?=
 =?utf-8?B?T3RVWVU3WXl5NmExSitJQVpoZ200OURLajZmS24ySk1sbHBaSHRuRGlqdkMr?=
 =?utf-8?B?Vm1iYWs1RUJIWXdHNDJWU08zaVJSL01ReWZUL0dVZHpWK1pxbTltaEo0d0Vt?=
 =?utf-8?B?c3FrU3ZMQ0NTbytxbCs4YzUxcFhVcDQzNlFBUTBBOGgyeGF3ZnltZitkTUhV?=
 =?utf-8?B?U3BMRklvU2s3cVRQZktpc3NycktOMk1BeXR6R2ViUTdORGdVenE5MFdkS0Iy?=
 =?utf-8?B?d3JVVjZjbnFrZXJmVXlGakYvbnlHamxIQXNyVHV5VFFKZEtINXRwQ0NTQ2M2?=
 =?utf-8?B?OWNBZlZzaUY4M3p0TmhlYTFtRmh2bkxoNzgvdUt6cGlPNzZFTU9WOW4zRWpp?=
 =?utf-8?B?T1RWZWtXV24zS1E1RU1UTnhDTVNiQklnVWVyVHJ3MFdmaHdaWWY5eHdQTWND?=
 =?utf-8?B?a3RvTmt6a00xdUpSbEZKS005cDVjbk9HakZvOUk4bDU0V3h1N2Fua1htMUFh?=
 =?utf-8?B?Wm5tVkpjaGFkRFloTmdyMEkvN3pHdXdwM0NtdEVBYUtVYlJSMldWK2Q0clBG?=
 =?utf-8?B?MWVabnNsRVY1aDlabnNFSU0wYWtwUUFXQWRmTnBuT0dKRnBCaEQ5UXpNVTlT?=
 =?utf-8?B?eFlqWkJqREdITHFvSkQrOTVXOFVFSjZuZk5NdVJEdm1pV0xXYnV2YytUQTYz?=
 =?utf-8?B?Y0ZhYis4Q1VzZEFsNkpQMnpCUFkzNGRXZDkwVjlnaGRKWmw4b2ZuUFFyMzdD?=
 =?utf-8?Q?XNXRaz0u0OJVsijLN6/mhYsvx?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef75ca7-7393-4e1a-3e3b-08dcbb98d5bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 13:07:07.4949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4/uZYarbkxg6jMNISYGYmRqgFFAwZRa4jRrrjvvtRnrEnZZYmlMpcR/2QIVpoNZ4tEgE4ITF+hxyxwcud98uLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6024
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVucyBXaWtsYW5kZXIg
PGplbnMud2lrbGFuZGVyQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAxMywg
MjAyNCAzOjEzIFBNDQo+IFRvOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1j
QHZnZXIua2VybmVsLm9yZzsgb3AtDQo+IHRlZUBsaXN0cy50cnVzdGVkZmlybXdhcmUub3JnOyBV
bGYgSGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz47DQo+IFNoeWFtIFNhaW5pIDxzaHlh
bXNhaW5pQGxpbnV4Lm1pY3Jvc29mdC5jb20+OyBMaW51cyBXYWxsZWlqDQo+IDxsaW51cy53YWxs
ZWlqQGxpbmFyby5vcmc+OyBKZXJvbWUgRm9yaXNzaWVyIDxqZXJvbWUuZm9yaXNzaWVyQGxpbmFy
by5vcmc+Ow0KPiBTdW1pdCBHYXJnIDxzdW1pdC5nYXJnQGxpbmFyby5vcmc+OyBJbGlhcyBBcGFs
b2RpbWFzDQo+IDxpbGlhcy5hcGFsb2RpbWFzQGxpbmFyby5vcmc+OyBCYXJ0IFZhbiBBc3NjaGUg
PGJ2YW5hc3NjaGVAYWNtLm9yZz47DQo+IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQu
b3JnPjsgQXJkIEJpZXNoZXV2ZWwNCj4gPGFyZGJAa2VybmVsLm9yZz47IEFybmQgQmVyZ21hbm4g
PGFybmRAYXJuZGIuZGU+OyBNYW51ZWwgVHJhdXQNCj4gPG1hbnV0QG1lY2thLm5ldD47IE1pa2tv
IFJhcGVsaSA8bWlra28ucmFwZWxpQGxpbmFyby5vcmc+OyBXaW5rbGVyLA0KPiBUb21hcyA8dG9t
YXMud2lua2xlckBpbnRlbC5jb20+OyBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5v
cmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggMS80XSBycG1iOiBhZGQgUmVwbGF5IFByb3Rl
Y3RlZCBNZW1vcnkgQmxvY2sNCj4gKFJQTUIpIHN1YnN5c3RlbQ0KPiANCj4gT24gVHVlLCBBdWcg
MTMsIDIwMjQgYXQgMTozNuKAr1BNIEdyZWcgS3JvYWgtSGFydG1hbg0KPiA8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gT24gVHVlLCBBdWcgMTMsIDIwMjQgYXQg
MDE6MjY6MThQTSArMDIwMCwgSmVucyBXaWtsYW5kZXIgd3JvdGU6DQo+ID4gPiBPbiBUdWUsIEF1
ZyAxMywgMjAyNCBhdCAxMToyOeKAr0FNIEdyZWcgS3JvYWgtSGFydG1hbg0KPiA+ID4gPGdyZWdr
aEBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gT24gTW9uLCBB
dWcgMTIsIDIwMjQgYXQgMDM6MzE6MjRQTSArMDIwMCwgSmVucyBXaWtsYW5kZXIgd3JvdGU6DQo+
ID4gPiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbWlzYy9ycG1i
LWNvcmUuYw0KPiA+ID4gPiA+IEBAIC0wLDAgKzEsMjMzIEBADQo+ID4gPiA+ID4gKy8vIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4gPiA+DQo+ID4gPiA+IEZpbmUsIGJ1dDoN
Cj4gPiA+ID4NCj4gPiA+ID4gPiAtLS0gL2Rldi9udWxsDQo+ID4gPiA+ID4gKysrIGIvaW5jbHVk
ZS9saW51eC9ycG1iLmgNCj4gPiA+ID4gPiBAQCAtMCwwICsxLDEzNiBAQA0KPiA+ID4gPiA+ICsv
KiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogQlNELTMtQ2xhdXNlIE9SIEdQTC0yLjAgKi8NCj4g
PiA+ID4NCj4gPiA+ID4gUmVhbGx5Pw0KPiA+ID4gPg0KPiA+ID4gPiBXaHk/ICBJIG5lZWQgbG90
cyBvZiBkb2N1bWVudGF0aW9uIGFuZCBhIGxhd3llciBzaWduIG9mZiBmb3Igd2h5DQo+ID4gPiA+
IHRoaXMgaXMgYSBkdWFsIGxpY2Vuc2UgZm9yIGEgZmlsZSB0aGF0IGlzIG9idmlvdXNseSBvbmx5
IGZvcg0KPiA+ID4gPiBpbnRlcm5hbCBMaW51eCBrZXJuZWwgc3R1ZmYuDQo+ID4gPg0KPiA+ID4g
SSdtIHNvcnJ5IHRoYXQgd2FzIGFkZGVkIHZpYSBvbmUgb2YgdGhlIHBhdGNoIHNldHMgYmVmb3Jl
IG1pbmUuIEknbGwNCj4gPiA+IHJldmVydCB0byBHUEwtMi4wIG9ubHkuDQo+ID4NCj4gPiBQbGVh
c2UgYmUgc3VyZSB0byBnZXQgcHJvcGVyIGxlZ2FsIGFwcHJvdmFsIHRvIGNoYW5nZSB0aGUgbGlj
ZW5zZSBvZg0KPiA+IGNvZGUgbm90IHdyaXR0ZW4gYnkgeW91IDopDQo+IA0KPiBUaGUgZHVhbCBs
aWNlbnNlIHdhcyBpbnRyb2R1Y2VkIGluDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwv
MjAyMjA0MDUwOTM3NTkuMTEyNjgzNS0yLQ0KPiBhbGV4LmJlbm5lZUBsaW5hcm8ub3JnLywNCj4g
YnV0IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW1tYy8xNDc4NTQ4Mzk0LTgxODQtMi1n
aXQtc2VuZC1lbWFpbC0NCj4gdG9tYXMud2lua2xlckBpbnRlbC5jb20vDQo+IHVzZXMgR1BMLTIu
MCBvbmx5LiBTbyByZXZlcnRpbmcgdG8gR1BMLTIuMCBvbmx5IHNob3VsZCBiZSBPSywgZG9uJ3Qg
eW91DQo+IGFncmVlPw0KDQoNCkFjay4gDQoNCg0K
