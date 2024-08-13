Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBB7199246;
	Tue, 13 Aug 2024 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723550650; cv=fail; b=N2uinzG4MfmqoozlOXqJu+GiGRXPoSjnNlCrWya/3ibL94Pf+LjRqwbxV5nIBfIp0tBu7lqhZG5ySoPMrjcK+u5ZUWHRzrmrd+Rr2uEiWFP7culbHUrk5yGv7I2y1iPuN+TXh3d+/1lWjuBr5a4mTDuxWN1+puFbv8rHCdpDtZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723550650; c=relaxed/simple;
	bh=WeAPY0Xc9gYUEEQa+FNKABgwPl0nUGH2iEzg8/NjpvE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RcwhWvgGK+BgkaEYfbkzJ+EkgFsk/T/DUoG+/8wGbVuwGKsOJglx67deVoSGiaNWj0EsPKRWGcH0LMuPCl9H7CIsox0Nc4aBNOvALE56nQWEKp0bGCvTUNe2WYiuBQ5w7NUUts+so5nvchS6ikKsydMSWl46ZPMY8XQ7RnNi/08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aY+ngCH6; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aY+ngCH6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723550649; x=1755086649;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WeAPY0Xc9gYUEEQa+FNKABgwPl0nUGH2iEzg8/NjpvE=;
  b=aY+ngCH6Adr+e2FES6IBPUM0TRU7Xp/NRgEcFvj8/GxGoljPEtRAAw+2
   2Gq/XmrTGmZNvlfj0lb59F7MqaE6WG2RdvSQiPYt8vigGbgUS1GFZtIx9
   FubUTCYM06xmzbwynjDC15/qiQDy/ycHfhgOtPKgqNWiVzqjapCxhwS1K
   wNDUnUAeALoPoWrGavNeWMWfEiYQ9J3A1x/KBxBcLOjXuW0HEKGWWKjKB
   4rsRf2CtedRG6rBKLEwy+uWgtOyR/CWHte+o0NRWvtgM1GkPJg3jdLzbj
   3FSbqApJ6ctrafwY7YFvpfFrf3Im+Xsmu2/reIZTxUeBScVkJiwOKMVI0
   g==;
X-CSE-ConnectionGUID: tOus+GWfRI+6Z+4Xz5Exqg==
X-CSE-MsgGUID: xK279TMMSLK9CEUXipvCBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21852262"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21852262"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 05:04:08 -0700
X-CSE-ConnectionGUID: 36IdUYEYR7qygIQGB0KKWg==
X-CSE-MsgGUID: +kXINYW3R+WrV9vdrwdh4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="63328092"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 05:04:07 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 05:04:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 05:04:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 05:04:06 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 05:04:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvp7f9lZ6zqNqmS3tTuE62oYfiieG2C3NoyOpn1k03t8R+4EUaNDyd/0eT9x8/TXqIQWl2YTy14d5HZ9EKVRomAwm/JQmEOeQX/1un5+E3oA4drQ6NT/+Kej4pkdPU8CoA8dxJxm7fSwBsdLiiuBrujE5JdN48A18LesHH7KdV71ter0Nid7pBPThqYepNOqaRoS1SFPHzlMfhg3wQKfYQzauM+LbtwWzOGnmnJIVKOTdWb90R33EbI/FT9DVmJymZljt54O8AtJB2oPVydPtRo4gZDGp9ZPLmLUs8xolw68kkM0KUYn+rwoLm/4sLML/e1xJxWLl4Ffa1HAMKa/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WeAPY0Xc9gYUEEQa+FNKABgwPl0nUGH2iEzg8/NjpvE=;
 b=CALt9Qsp0OZfSLPyKcm2qDbPAL8MW3kmWknv/2JyCaaJDFlednN3S8BAoRLiI5W3/oSXIcdU/ZhN1+hAOcqA/hDfTGjXSEa8O3JiNYBo4UKSh/Gmb0JMen7Au2QFhN1sccZWmIrVGPfIpwi8rvgGiHObCIRICYee/wD4S/VjpD+VUj1UVT57OctFg941jrPiGL2hbsYBtD02yzjeLA4y2gs0ewkjxiOQQPhGl8hbHncWCoF/iAgYJuy5GM9NR5c5/twu4UQWPlaFFPvbwUF6Fb7BCq1L/W7M+9HoZYnrBzbUTW9asNVfsdEz5Zw+7jUpRaS0EH2gXjGzCslo0pKZ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5)
 by CYXPR11MB8690.namprd11.prod.outlook.com (2603:10b6:930:e5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Tue, 13 Aug
 2024 12:04:03 +0000
Received: from PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::d720:25db:67bb:6f50]) by PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::d720:25db:67bb:6f50%7]) with mapi id 15.20.7828.031; Tue, 13 Aug 2024
 12:04:03 +0000
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jens Wiklander
	<jens.wiklander@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, "Ulf
 Hansson" <ulf.hansson@linaro.org>, Shyam Saini
	<shyamsaini@linux.microsoft.com>, Linus Walleij <linus.walleij@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg
	<sumit.garg@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"Bart Van Assche" <bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Ard Biesheuvel" <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Manuel
 Traut <manut@mecka.net>, Mikko Rapeli <mikko.rapeli@linaro.org>,
	=?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Subject: RE: [PATCH v8 1/4] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Thread-Topic: [PATCH v8 1/4] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Thread-Index: AQHa7LwONeZ5Kj6JmEC+yxNK4Hs31LIk7SmAgAAgmQCAAALAAIAABfPA
Date: Tue, 13 Aug 2024 12:04:03 +0000
Message-ID: <PH7PR11MB7605F50AC47D18361D933CE1E5862@PH7PR11MB7605.namprd11.prod.outlook.com>
References: <20240812133127.865879-1-jens.wiklander@linaro.org>
 <20240812133127.865879-2-jens.wiklander@linaro.org>
 <2024081346-dutiful-stalemate-0e07@gregkh>
 <CAHUa44HYQVhT0=E9py2JsO2X93wLhZ=YvH0fBqQpzFBujSGgtw@mail.gmail.com>
 <2024081346-riveting-unwired-d9dc@gregkh>
In-Reply-To: <2024081346-riveting-unwired-d9dc@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7605:EE_|CYXPR11MB8690:EE_
x-ms-office365-filtering-correlation-id: 91a791bd-2718-45d1-0b65-08dcbb900626
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?REFCc0dqeXpZRUdwWXJqMjRObWRSeGJDclJnQ1haVnhsaFh0bHN6Ujd1THI3?=
 =?utf-8?B?Uk5sY1R6ZmxFLysyUzY5WU1hM2svbFQ4eTBMMHpZT0orUTBBWjZrNXk3TmdI?=
 =?utf-8?B?dTFMNXkvZVpEVVY3Tk44cGFRcU96aVFrc1kxY3o1TUNDZUVyQkJKdW4yRXlo?=
 =?utf-8?B?Q3loVkI0OTZIMWk5d2VNeGxWNnJKVXorOXl5c0lNMG9Jc0RmSUpQVWk1Qm10?=
 =?utf-8?B?d3RKbGpSd1Nhcm5mVzVGMzBDc1MxaGJvRSs1ekc4Y1VmMmpibTBBTmk3UWtz?=
 =?utf-8?B?d1B6TGtjWEh0cSt6bG54Wk9WWmNRcVdUaUVCZXlJZFFSbmN3REJhT1dCV2Ra?=
 =?utf-8?B?anEvRVNVdkJtblc4QnZpTzhpK05GRGFxa1p4NUgxYjNSd25HWnowWklESENp?=
 =?utf-8?B?T1ZWeUhyZTJQWE5zWDV6eXk3TFA0Sld0ZGxjMzhkT3VtaFNUQ3E5RmU3SWRo?=
 =?utf-8?B?Q1RGT3JTaFNCc25QK0xuOFJrYmppekZ6c0sxdTlmOEZwcTJYZ3dmV0NROHl0?=
 =?utf-8?B?blVHclJaOW9hWVd2M3FwVElORDZoNWo3N3Q2QXk0aFRPSDNHak4vcm1UcGpE?=
 =?utf-8?B?aEwzVHdWZnNSKzhicUlFcW1XQVAzb20yd2JVSDBGZytOOHdvRUcvcG9PTGQ4?=
 =?utf-8?B?bjJ6Yko2NGYwV0dqTnJSeWxnUHpDMUlUY0psREIyVm9qR2VHeXE1RHI5MWYw?=
 =?utf-8?B?WitGOHRmemY4S3JFWGRraDQyOW1rc0M4RzV4T2d1MkhSb28rZWRZR0ZOajJq?=
 =?utf-8?B?NHpPNUJiTTB6bTd3aG11akovUWpTWFVzZnRFS1ZqSlFyaGVOaUJyWUdLVko5?=
 =?utf-8?B?NWhlVTQ4ODVKVHFUTFJpSDc3ckliNGVwVE1jQ0V3ZUp5aDA0OVYvTW1TbDgw?=
 =?utf-8?B?T0FaenNBS0RFU1E5SVh0WEs1WS8yZEZGd1pTM2hBbVdzYTl6TjRuemdZQVFR?=
 =?utf-8?B?Q2FVVWp3d01GbU1ScGVsOWIzNG53aHJmbU1DWlliR1pCaEpsdTgyeGc3bmZM?=
 =?utf-8?B?QTRDa1I2RFBSZmdEc1pwejFYc2hJVUcvZmtTUGhKVURPSkc5MlZ0dTlLbHZF?=
 =?utf-8?B?S1Q0UDdiTUlnVzM3MENRUnZieTRuRGw0cGwzYnJ3NVpWaFREdVJPTzhyL09v?=
 =?utf-8?B?bDJkNEtpaHYvd3FwYVgzSEwwekQ4NWdKVlh0aXdGeVJaRlJmYWFRdWg3Y1hv?=
 =?utf-8?B?MGQ4SC8zN0lqSThvZVhQM0pDdWJRdGUwSzFFYjA2aDZQR0NVREQ5UEI1Vm1C?=
 =?utf-8?B?Q0haZmU1anlmV1ZxZklvbFhaQVZjMXFRTzVacTZYd1c4Yms1RHIyUGozQXJJ?=
 =?utf-8?B?d3JzZzBhOURWemtZdWJaeTR2cm42UHk3OTZoeHRKK2J4Z205UEJCTEpRVEE1?=
 =?utf-8?B?MG4vZ0pPODRvNUo0WlBUMHNyRWFNUmszVExWYjdXUTVJM0lMcW1TWkNxSE1y?=
 =?utf-8?B?b1NHNTNDYm5QUXlBTElsL1plZitTMXp5MTFsMUhvVXQrUlFQTE5XdmlJSGpa?=
 =?utf-8?B?ajUzL2NZWkhFVnh0Q2RNMDJCZ29VVGlrT0c5UU1xZ0kraE5rZS9rTHdjalli?=
 =?utf-8?B?dWxPSWVYRm9sWm9YaUY2VWlHYlhjdEl0NVNUaExGK0x4WmpkSFpzdWNBMDlo?=
 =?utf-8?B?S1BWMDJoYjY5bkF3clJPTVRnRjBjaTFvckNZSkd1V290bTJ3N0VDTS9vRUZl?=
 =?utf-8?B?OHZHUUtPSitNZ1JCNWhDcVM1Q1RrQ3pkMDdjMlFEZjFTTWY0S21mWEpORTFz?=
 =?utf-8?B?UEpHL3JZZnMvNnJiWis4V09KQzVGTjNwdnB3NlpxL2FQT2ZpVzc2TExZM1RS?=
 =?utf-8?Q?nOvHqVokoswCfIe0GuXazWMKs3X9TNW7zDd4U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnBuNEVTVEx3OERtak43aHdoVHVmaEZzclRSUTZPOUhOVEdPOUgrYUVnQThU?=
 =?utf-8?B?SGhXSEJDOFV4OHZnVm4xY0FoUUhyYWt6N2FPSU1LeDl5T2hTbW9TNjBWWWtn?=
 =?utf-8?B?WWtUQmVxckdXWGN0bHRWeXpUMWZyU25ab0ptQzRGR29UR0dFOE9peVIwcm5i?=
 =?utf-8?B?YWI5RW1ZUGo2ZGlYQVdUT3ZhaFNwVG9KYVVWai9PZEtzOXpML0J5QUU3b1RO?=
 =?utf-8?B?REFLeDlLZzlYRmRvdlRsUEUxb1ExNitBV082YWkrWjZLUDExaFFRZndEVENF?=
 =?utf-8?B?VWRXNm9qWnFycnRhWjB5NE4zNzBVdGF0a2dvenBFNkZ4MkxFdEJXUm1DVi9U?=
 =?utf-8?B?WG15Q2VVcDVUMUY5bzFBUGtFcUNOMzBqb24zL2VlaXlRdmVQSWVyLzFQcC9u?=
 =?utf-8?B?ZHV0TWJXQTIwY1grVUNjcTk0QVJjbHN3VG5XNVQxZTBnNFlwOFN0SDlqd0xO?=
 =?utf-8?B?clJpbDhZbi9BMDVKUGVzYlNEM1c0RUFaSFptT0ZWT1VJMVEvc2NEeXZ4Z0ZZ?=
 =?utf-8?B?NloyMUg4SFlveldjRTNtT0lzanNiYU1iN2hOMFhoUExycDBkTTFpTUdQcU5L?=
 =?utf-8?B?Q3M5ZlVFYlZiTzh3Z3R3cjhpM0JMeTdkVFBYRCtyM1d2bnNQblU4aE45WjNG?=
 =?utf-8?B?Z2xEamVwTUoyVW1WU0lXanB2UGROMzhxOWZ4YWxIRWFkMnVKc1VicWJMcXUv?=
 =?utf-8?B?anNWMFQrT3FrbmtKdkZpa1VqN3BsTG5HZzVQWjJVU3AzNGhMdTJNaXY2NmdW?=
 =?utf-8?B?TTVWM2NkUjEvNUpaR0Y2UTZ0dDNaSkZyQ1BuSVN6cUxvV2NMNDhja1Vrc0ZG?=
 =?utf-8?B?WEUxdWRIR09ESjdLdHp6bmtSU2M3RkkzbHpaUVo2Y0dsNTRUakxCUzBzeVdI?=
 =?utf-8?B?VXFrMElXUTBFamY3cCtiV2VIdStIeE11Z1RjdlNBd1U2YVdnNEphUFhRVmJE?=
 =?utf-8?B?QW4xSC9PbmVtYjE1eXdWcStNU25pcjdQdlBWb0E3S2JEOGVoQjJRRVkzM1Ey?=
 =?utf-8?B?ZGNsZmtmQ1FTUktOVmRaSitRN0tzUDI1cEw2N2pIYjlYMHRVNHhVenl1c0xJ?=
 =?utf-8?B?TGY3bkdBSmpyc1ROMy9kWjBFZlFDeHYxTG1VYzdudVF4VUlTb21DYU02RFFo?=
 =?utf-8?B?dlZhNEkxcWYwaXFpMVJYcTZHSDJmUVE2bnprRUg4NUFUWFl0Z2FubWpQUExh?=
 =?utf-8?B?dHpSK1J1Q2pXN0U4aktVRXdOeFI3ZzRRK0FRQzNjUGtXR094TThnZit6NjdZ?=
 =?utf-8?B?ZXN3R1hpclRXS0RFTHo3a1N4Sm9VT0E1K2p3dmdVSGpVaEVHeWhudnMrY1dE?=
 =?utf-8?B?djNlUG5hTFhSS0ZyQURGaHlNYTdEeGxvdGQyZ1NLSitrZkhIMlZocDczd0dy?=
 =?utf-8?B?aEtBSnNmTmhhRy95SVVNL3loSTY0OE14bkRDaCtjSnlXdXBubzJqcmxvdUcr?=
 =?utf-8?B?UStKRkFSMU9VeVVpN0FmL2diaThna0NNMmVLbWwrU2k2Q2tiWjJwSWFMdTBT?=
 =?utf-8?B?VUlHTTNBWlF6eE1GbDBFOGdsMEdIaHVDdkR1WGRqWG9vcjIwQlNrZ25YbGVy?=
 =?utf-8?B?U2c0ZktIVVpqdzFYYXlJQ3ZITmdBWXlSUUV6SDZvL3pVVjlNczdReUF1U1Ri?=
 =?utf-8?B?VFJYWDRBR1E1WjNQalpFUzJnOGJUVi9ObkllVHJxQ2tPNGtyaDVYYm9yL1Ix?=
 =?utf-8?B?TDJQaitLU1V0Y0xMRHh5Mk4zU0ZNK0d2ZGxSZVAxRlBlZ1VHbjVIeXo2WExV?=
 =?utf-8?B?WnhZcEVlcUVDTEkrRlRaNzBKcjVwRlZHZ1VwU2FLeWVES3c2WTVFVFZpQnZE?=
 =?utf-8?B?UWdESElGRUdCa2JDODdMNlBDN2VZanFyNDJCd3U1MXdnWDhKYnJ5eXFOT2ln?=
 =?utf-8?B?U3d3czc4MEd6MWY2S1NBSzB3YXlyUk44aFkveHJQWDdRODdSWnNtNmFMa2ph?=
 =?utf-8?B?NEhnRkFCQ1haYVZwQTVmQWxtYjRlN3gvWXF5TWRsRlZ0TFFBYzkySHJ5TjMz?=
 =?utf-8?B?Z0JSYmwvMXEvZHJmWTRqZmp4d2VEK0Z0TVhFVWpza1Z6VTBLNUJaWjYwUytC?=
 =?utf-8?B?SXN3cUNzeU9XdHJnSlVHSlhkZm9vL3poL0NBYjhlTkgyZThUSExJVXg0N2xE?=
 =?utf-8?Q?3oOwoYuCpvx8snw31AlSjJmeT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a791bd-2718-45d1-0b65-08dcbb900626
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 12:04:03.2534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VnNxQYXIeEELZajmd3c4KrSXUOxqcL2x1G0r4z8zrTABPfHbr79KPKx03uX+Dpy8oXzfrUY5chBamFMm/XTkag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8690
X-OriginatorOrg: intel.com

PiANCj4gT24gVHVlLCBBdWcgMTMsIDIwMjQgYXQgMDE6MjY6MThQTSArMDIwMCwgSmVucyBXaWts
YW5kZXIgd3JvdGU6DQo+ID4gT24gVHVlLCBBdWcgMTMsIDIwMjQgYXQgMTE6MjnigK9BTSBHcmVn
IEtyb2FoLUhhcnRtYW4NCj4gPiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0K
PiA+ID4NCj4gPiA+IE9uIE1vbiwgQXVnIDEyLCAyMDI0IGF0IDAzOjMxOjI0UE0gKzAyMDAsIEpl
bnMgV2lrbGFuZGVyIHdyb3RlOg0KPiA+ID4gPiAtLS0gL2Rldi9udWxsDQo+ID4gPiA+ICsrKyBi
L2RyaXZlcnMvbWlzYy9ycG1iLWNvcmUuYw0KPiA+ID4gPiBAQCAtMCwwICsxLDIzMyBAQA0KPiA+
ID4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gPiA+DQo+ID4gPiBG
aW5lLCBidXQ6DQo+ID4gPg0KPiA+ID4gPiAtLS0gL2Rldi9udWxsDQo+ID4gPiA+ICsrKyBiL2lu
Y2x1ZGUvbGludXgvcnBtYi5oDQo+ID4gPiA+IEBAIC0wLDAgKzEsMTM2IEBADQo+ID4gPiA+ICsv
KiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogQlNELTMtQ2xhdXNlIE9SIEdQTC0yLjAgKi8NCj4g
PiA+DQo+ID4gPiBSZWFsbHk/DQo+ID4gPg0KPiA+ID4gV2h5PyAgSSBuZWVkIGxvdHMgb2YgZG9j
dW1lbnRhdGlvbiBhbmQgYSBsYXd5ZXIgc2lnbiBvZmYgZm9yIHdoeQ0KPiA+ID4gdGhpcyBpcyBh
IGR1YWwgbGljZW5zZSBmb3IgYSBmaWxlIHRoYXQgaXMgb2J2aW91c2x5IG9ubHkgZm9yDQo+ID4g
PiBpbnRlcm5hbCBMaW51eCBrZXJuZWwgc3R1ZmYuDQoNClRoaXMgd2FzIGxlZ2FsIGFwcHJvdmVk
Lg0KDQpUaGUgcHJvamVjdCB3YXMgdXNlZCBpbiBodHRwczovL3Byb2plY3RhY3JuLm9yZy8gd2hp
Y2ggaXMgdW5kZXIgQlNELg0KDQo+ID4NCj4gPiBJJ20gc29ycnkgdGhhdCB3YXMgYWRkZWQgdmlh
IG9uZSBvZiB0aGUgcGF0Y2ggc2V0cyBiZWZvcmUgbWluZS4gSSdsbA0KPiA+IHJldmVydCB0byBH
UEwtMi4wIG9ubHkuDQo+IA0KPiBQbGVhc2UgYmUgc3VyZSB0byBnZXQgcHJvcGVyIGxlZ2FsIGFw
cHJvdmFsIHRvIGNoYW5nZSB0aGUgbGljZW5zZSBvZiBjb2RlIG5vdA0KPiB3cml0dGVuIGJ5IHlv
dSA6KQ0K
