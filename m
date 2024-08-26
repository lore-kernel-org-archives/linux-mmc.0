Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECBC36AF2
	for <linux-mmc@vger.kernel.org>; Mon, 26 Aug 2024 07:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724655918; cv=fail; b=uq17JRWI8vRIVY3GBaHmpgtPX80cZ6Qgv0gRHE6AtQyBYWW68RUXKYgK9Qhd+CuAL+4JC4W59fP32OYIQV/Q4tE+IK3LSjeShqJbk09v2Xvzpf9qXJpPWXprt4gyr+RzCKI1YSHVvTXkRczAOWBw1c++Irxt2DnA5ZRQDUnTbtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724655918; c=relaxed/simple;
	bh=bEKT6IVqbBfZWpQBklNWnf/KO8C5YzWJMYVu0mOVhNg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hZPlHuarbg9YGeY28cQue3KFQr6SMGq9yTUsUvIb5oQ/4FPER1yb0qHr2ia265e+gFsb14ZiNL+aS473H7LWI234MrWRomPzBBLs4s1E1Ku4Z//gNMxUGAsRNbZOy69FtRxCEF+noyZ3pACHg4uhr8AUiiQZ0pc9YjSUAh+sXh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cpnGVRkK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=PvhHH13b; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cpnGVRkK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PvhHH13b"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724655916; x=1756191916;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bEKT6IVqbBfZWpQBklNWnf/KO8C5YzWJMYVu0mOVhNg=;
  b=cpnGVRkKp/UY0x/+H9pt0Yy5sGgX/ycyzUVEJhPLbSNIxNA4lvqLmBXL
   N9cBnXXyJ/p8YrH7UqVU6Koq/XvUrMsS9wOyeOoD3kyJzK/wBlM1RyLgf
   nOUpXaUHhxLtea3w1QefkDGy7+6/6RTw4pgYMM1Tm6LFgZ49jt6DDnAUL
   p8pYGT6nR+1bQ0aDu8KMOl7F2r1pOkmr4biO8UG2oRvjMtqtPc/l4XjKv
   xZLIws/+xluHVCPycFw+O7uEjxio2BBxaatDQvQ/l+S9M7SyTlYjpAwog
   B3sQl/enbKZAB8snqbNd5QiAF5B6b9rnySQgFiXKlSKqQBni49VIMnBWo
   A==;
X-CSE-ConnectionGUID: aB/O6CJFRuqsoeg+HEGuUA==
X-CSE-MsgGUID: TXfK5MWpREuJLZgP+sC/jw==
X-IronPort-AV: E=Sophos;i="6.10,176,1719849600"; 
   d="scan'208";a="25207359"
Received: from mail-westusazlp17012039.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([40.93.1.39])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2024 15:05:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8kw8WHUwUuNXskXB3L4wLgdxv4zhiWYXn5IrZlwFwJZz4p3dAPWCJxtQ0ofARWREWMour0pzxII+TI7k1PO2435WxRMShnuhNIiwQORQRyvff8u3bzKreJAZEpT2sssNMw/sNW7BURKMVKXNgrbCLC7jnZmevx9gd3cnPp3/b2sfH8gk2qD7G5H4h0rMqaYTHsp+HkDLyDLJI8N04e0E6/3G7bX/+QRVOjzPgWvsB9491ajM2WWLwMcYFVxVjdznyDTfG60IYjTBW2pMH+e9122WQDLHj66sywYApH/KcvNJeVEbon0mgMbEzMO474VLHZfnB/FtNS+h01puaDqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEKT6IVqbBfZWpQBklNWnf/KO8C5YzWJMYVu0mOVhNg=;
 b=Ss/tI1kqNBflfzNTikuavplbWxyDIiAH+pMsj+x7jx4AzCTXaDdnCo8NQfZaTsaoRNN3fe5DdO2rM2zC/aJS9HrRHCukHBUtrO7ZwxujFbJEKJWpC09kU5KvPCByjAqH5oI14rgLaquoHYo3mc8TqLeZR9yUN9Re28m+NJ8RFQJwdery/7RvYyXtpda9iQkNxDyKn52cqlbTu8XIbYKKtnkBrbxdE5FqsIca3ZEGgkPLqTMnyrhF109q3SHv/Ed1qMblrvrw8WLIhHgAJQiqkDOcoiExowXdVAZyXXGEYwUuRM1KV2rJfKnLMSqnJ35s7zie/rdmyv2Bs7IZbayHkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEKT6IVqbBfZWpQBklNWnf/KO8C5YzWJMYVu0mOVhNg=;
 b=PvhHH13bppd7BdS+YfbEzX87ZeYdPjzACTHFMbruPccDPYHsYQbkAnSE3c2VWYAV6i1C7vOabCsUKzh6om8NtUCzgDdcU7OkzDMWpmCUmFep7X1gDs/pH7jXZnKyDOsJ0tXTXb33TGk7UMtJLX4T86ITJbtR1gm7A8j3xX4xs5c=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB6493.namprd04.prod.outlook.com (2603:10b6:5:1bf::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.24; Mon, 26 Aug 2024 07:05:06 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 07:05:06 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Ricky WU <ricky_wu@realtek.com>
Subject: RE: [PATCH v4 2/9] mmc: sd: Add Extension memory addressing
Thread-Topic: [PATCH v4 2/9] mmc: sd: Add Extension memory addressing
Thread-Index: AQHa9sJ5VuwlKDM/lkeIafX03orLtbI5GO2AgAAEapA=
Date: Mon, 26 Aug 2024 07:05:06 +0000
Message-ID:
 <DM6PR04MB6575A7A3072DF1DEFF886433FC8B2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240825074141.3171549-1-avri.altman@wdc.com>
 <20240825074141.3171549-3-avri.altman@wdc.com>
 <2518dcfc-452c-4464-a989-b6e4e02772e5@intel.com>
In-Reply-To: <2518dcfc-452c-4464-a989-b6e4e02772e5@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM6PR04MB6493:EE_
x-ms-office365-filtering-correlation-id: 44f8839f-dbbd-4bfb-f755-08dcc59d6a50
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MFhkK3FxQktDRTZLZmxlSEs2OWQ3YTRLVGh3T2ExQWM1OElLMTNrOVN5Ymx0?=
 =?utf-8?B?VkVmT2VyUlV2bVVpQ1ZINVJXOGF3Y0tZNEZiUVNwOXJtMm1MVWdJNjA5ZVQ3?=
 =?utf-8?B?RU91R2xBdy9ZWXJZblc0UjJSSEk1UW1hMmdqSHArcHhQaG5TRGNSOTZocjkz?=
 =?utf-8?B?TmdpcTFQbEhLMjJtelc2VENpa01zbm03V2crazVWUlpNaEN6Y1lTaGlFREtJ?=
 =?utf-8?B?YTFMd1hhTWJRTEoyNVVkWlZ2UGpGYjRsMmdYb2Z2a25HNnR1b3M5SC9yYmlY?=
 =?utf-8?B?VWpHSzA0Y1FvYnV5MkpDblhqUnhLVW9JVHA1YlRzUWVOOStIU0lnZTRORzk1?=
 =?utf-8?B?SktISkdoTmlSdnpIc2NRNS9mVkx2bytBaE55RjVjVG0wem1LdkNEUEVNRytY?=
 =?utf-8?B?MFBDNkZuL05VT0tqOHI2UnBhUmg5VmVmZHJDdHg3MmlKemxmUDVicldJOHRC?=
 =?utf-8?B?OU1sWDdsdGRMN2JNSEFFTUZ6TXBObzdzb0wxUzVXa0RwZUVzTjNjUTRINUto?=
 =?utf-8?B?MUVzVU5VRTNmcE5QMyswK1dmMDhLb0NEUXJ5VmM0N1k0aStjQ3dHNmphczdK?=
 =?utf-8?B?Q1NnSTN2dzYzc3BnNVdLc3Q0aXJjU1dYLy8reFQyU0ZicWVydXU1R2hVZnpZ?=
 =?utf-8?B?cXlLcm96czhWQ0JlbldIeUNxeHpvM1pxSXBzbTdLUlRheWVsU3hONThkdGw3?=
 =?utf-8?B?cHpmVnlxVjQxWGtVaWVxcTRTZW50MDlmaGlOMFRWRFl5SmFVQ3lFY3RyWm10?=
 =?utf-8?B?VFVwSGd6YmtZcVlpU29Ra2pubjdNRktMNXorM2dXY3lMbG9ybFVub2VwcEZa?=
 =?utf-8?B?c01YWkFFaWVVSlZRU0E1S2U2MTFsdUhGeWZQRW5CajFYVUFJV1ptN0J0ZEJm?=
 =?utf-8?B?VGJVdnRMQzltNlVncWcwNndMVVpBNS9Nd2tlS1dra1VoVnRlNkVqaU1BS29X?=
 =?utf-8?B?TTV2Z1k0eWdialVVMy91bDRFL0xHTXJBWUpiSFYxbFJ2c0pTUjlXUzF0TTdk?=
 =?utf-8?B?M3NUK2cxcUMwOW1TRWt4MHorc1pRQmVLUFlESFdsYUtKdWFQMXRZTmI1Zm1s?=
 =?utf-8?B?SnJRczdwaXZXNWpyejhzSGZhT05VSDR1dERuZVgwS0E0aFB0U1lSTVZnaHgx?=
 =?utf-8?B?bXNTQnlhbWpFRzBISEJNYTJXem13bUppRGwxQlMxd0ZvYWlDOHpDb3N2ZE0z?=
 =?utf-8?B?Vk5GSURVRjhtQ0xwbUZuU3Z3Ry9SNzlWdk5CelR3WXhtVWx5L216Ukp4V2ls?=
 =?utf-8?B?R2FkZmdUcHVNTklSWjNKcVVFb3Y5cUt0dVJYUmRMWVhTbHR4bklmQnV3RjlE?=
 =?utf-8?B?Zm5HRmxLRFE2VVBCcHZMelk1Um9SMnNmZ090SlpiUjIwcXByL3pYUkEzMk13?=
 =?utf-8?B?ckFuRm9reU9UQ21XcVlQTFlPaHYxekIyQnNSeEUyTmhBUVpwbVF3ZVgvbDZH?=
 =?utf-8?B?Y0ZJNkZVWDlXaHBiU3d3SnZ3M0NyYUs3UjJhNGFpSjgxRGZaZE0wU3hRVklh?=
 =?utf-8?B?a0tENmtBd2x0MGRCZUVIZ3l0Vlo5NDFwMDU3dTAyVjhVSkpqR3dUZUR0b2pB?=
 =?utf-8?B?bXpXZlpVOEQrQ255YzNYS3dhelJKQXhqQU50aE1pRVNhMG9zd0E0K3BLVFQx?=
 =?utf-8?B?MjdDbUpIUWxieDlwK3R3YkgvcEdXU3dpcmNQQUV1L2hmVU96ME9DREVobVU4?=
 =?utf-8?B?QzRYTzMvYlNiTnZQOFRLR0ZHNUVDYWN5WlFQKys0NVhmWnV0cWlpWHNGUlIz?=
 =?utf-8?B?YzN4SlJhdG1ieEVNS3dWMlhpOTlOemJVT2JVb3lFUGFad2Y4L2pxcXhKekhz?=
 =?utf-8?B?L01GRFVadld6TjBkb3hrekRhMEl3Q09zUGRqZEZLVDZoUXROSlJNSU81QzhG?=
 =?utf-8?B?Wkh3MHppOXNWamhmQTZoWHd0N3lwc0ZhOTlpODFJV0wrcHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SmhYVjZkWVVjWFI4NjBWRUplQTVnMVdLUy9TN0dLeWsxZGNEQkRtVUZQZjJx?=
 =?utf-8?B?elgxRm43VE1nblI4WWRuR0FoUldUVWxXajdZV2J2OHo5NVZwYlo1SGtEVDVJ?=
 =?utf-8?B?NGJZSlZIV3N6YjBPa0F4N0Y0d2kycXFZN21KOFhHRk9vaitWSWZQVG00a2ho?=
 =?utf-8?B?RjM4Qm4rYnR2L0hVWlVaK1VMU2lodHhMN2UvSDNIb0RVZDI3NEt2WGF2SEpQ?=
 =?utf-8?B?R3krSmJZMmsrZWt3RXhKVGIxaFlUYytzd3NqOWpabGVvY05hUXdITXlFMlNG?=
 =?utf-8?B?eWpyWm40eWFpelU1VmJwU1YxdUNxUUUzeVR0TGZYVVBnZTJ0NXc4TXIzNnVo?=
 =?utf-8?B?Mm0yOTJpY0NGM0ZFT2x1VGtKeVNkQ0JVbndIT0RORlZ0Q1hvQmFCc09oL3A2?=
 =?utf-8?B?TkpydEwzOWxvWVhRWUgrMlFvK1JiRDVNdkZBRjd1U0YvYzJGTldidlNEWkFP?=
 =?utf-8?B?endBanpWZmZOYUdnSDRHKzljRC93dFdKdVdacmhycEVFUUtnd2VWSklEcEh3?=
 =?utf-8?B?R1JtZU8vQjJ6c0p3cmVLRTNNbHM2SUt6RXFRd2xRL3JJcXZueHB5M1Vpc3oz?=
 =?utf-8?B?VVRJNWhaVjJtcXl2R0FBMFptclZsSFZEK3oxa0pLOG9oM3VvcmFTUEM5NTJ1?=
 =?utf-8?B?djFBYU0rWHFMeFNJQjZiN2s3SXE1SkJTUnRidUpJUlVKaytuaHZvRjFCTW9N?=
 =?utf-8?B?NWRIeUlSWVRNajlWN0pSZjZZWmZubXNBSzRzeS9MMXVtb3FXTjI5STNLRFRx?=
 =?utf-8?B?aEtkQXhwem1HYkJ2cEM2UTQ2SGl4Z2QxRS81c3ZrOXErcFBSSzVVNG1md3Z5?=
 =?utf-8?B?YVZhRHY4WFdWM0lNMW1yNGY3T29sWmEzMkxuTmszOE1qd1EyVFVDVTlGcHBp?=
 =?utf-8?B?ckwySk1XQjVaemtLbG9qRVYyMzNDVE13NWxrRk42MVgxUGd1cEQwYnNoOUlx?=
 =?utf-8?B?MlJLOWliN0RXMFBFQjJYaDVjZ2FtclVmRjZlL0lQOTN5ZzJBdzBUUW5HV3Zr?=
 =?utf-8?B?RXdxSEk5bFRTZkFEMXdoZTVCeXRIODV6aXh2SWkwR2F2cFY1WitmekpPK3FE?=
 =?utf-8?B?N0xlZmFsNWw4RHZCTDRHV3FZVlhxU2FjL08zZ29zczE4YTYrTXpIcktsb2Yv?=
 =?utf-8?B?K25IcFlDWXFJTVFsYmMrYUViWEZLc1diRThmSFo0ZzBUVDJWY1lLanR1aGQ5?=
 =?utf-8?B?eWNrWGVOTisxZjRpVmNnTFl1MDZSOWVMU0lQTU1QcVRHVHRXQjI4SDBiR1ZH?=
 =?utf-8?B?cGQ4ZDhSZHgvUlBBanFwYnZ0MGIxT1Y2dk9aN0M5cHJGYnB6VHg2NTlyb0pS?=
 =?utf-8?B?Q2s5SUZDWGhYRFhiZ1NmM0xNWlpjaFBhN0tFQ2R1eFJ4N1dFZjArU0Y5NEM5?=
 =?utf-8?B?cGFvbmpCTThoTTRwSlpUa0VTWFl0Qmdub1ZETlNVREdnSXJnSjJuNXRxVk1Q?=
 =?utf-8?B?ZW9MdkNRazhuYzI3MHVkQkg5VGFHaXVsK0JGSmtIbndMZjkyUmdGdTFrMjRS?=
 =?utf-8?B?WnNpVmRaWkh3OUQ2R3ZJZWVlNlQrSGI4MmZrVVRwRG5xSldld0svenJTd1J6?=
 =?utf-8?B?V0t1RjBaSmZ3eThFWFVLd24zdkhSc0wrTjdxWHY5NFNZVUl1OHhsM2FqZ05j?=
 =?utf-8?B?b0RINTJWbVpBRUtaMVBxT3hEY054eEdpQTl5NXo1cGNIQWo3Z29yTEVhMHlQ?=
 =?utf-8?B?cTJRWG82T2dmcHIrMHBLUkRKOVF4WlN1bTgwenVselczaFJjWC8zVVVDZUdC?=
 =?utf-8?B?Q0E3YlErZUJDZnFHQ2JMWjQwNHpUUVdxNjhkRGxnY080dHNLZWc3M2YwV05x?=
 =?utf-8?B?S2hEVWJIUXJoVTN6bWgwZVVLdU5OZDN0c3pzZlk4UHNTRXdlS0p1SnlGMVc1?=
 =?utf-8?B?UGJkSDJzZzNDZXlpSCtHODlTVnBkT29aVEFoR3kxcUUyTGttbHJ1WjlUY3ZC?=
 =?utf-8?B?WFRNMFJVNFN1RFZrd0lONSsxa2w0UUZrL0l3Rm1XSEFCalVMVlNXSXVWaVY0?=
 =?utf-8?B?Z2QvZ2tuazZpRXNUODJVRUpUdzdZbUQ4T2QzNlJTZHFCN2cyQTdWVFhZZkpY?=
 =?utf-8?B?VElBT0Y3QUZWdnpSQzhxQWR4dVJlcmR2NFFlNjlVUjBjTnh2M1A5aEFhQXQy?=
 =?utf-8?Q?WYmWNLy6WWZ1rzBHLUgyTiF/l?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ti+NwLJnuojc9VgTFqcgD41q1Scs4dZ+0C4EONPbhPlo45OzHGfRWd/YUc9KQHNWWamM1vFYrNehI6zH87obHDRVNBapdDlKgEhdA596uu45OlFriP45uucmwx9oGD+tSrJAkXNwpXYECi5L6uQV//o+6FYmJBEBGDsRoGxGUiGG3aa9bVi11x8Tl1WEvPpdfmv+P+QGMlVbSpK2zi8CgDQTipVI1GCPdYmQk8TW0JZjXxjD2WRBlKI25R7Lt/ON8WgKxzfDEvFlu56q0u1eivN9e+o2YRGryZjtPKqXqHiYWPqjFgt7JD6JqT2B4f0bhnMPOUyvYhhAq88sCDlin955Eu3R38J+nNA2gNEwgTecvCXwGa29ImA0/ffEVcFGVLCxRm1Nq6V6GkbluMOxIXGbYgbqQwHprpf08F9ZVfBYQCEl6wktRBymdV+4vdoF8T1hoOi8UNuBC9gZjfcvXs7Pt1gtfj+W9wAUCLPgkAAUqiyGoywMv/kV2l8E/y7i6E2JQdjGbIiU+IhIRU2YwpY+26P1pwHUtecf79915IYVCXNDz+Zvkau1Lolo/cMEsvcSNvBf2LSTZQRx2MdHXyOIGqPTX4E6bKT6y0jpyWogIvOR80lxo4zzRzSogcDq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f8839f-dbbd-4bfb-f755-08dcc59d6a50
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 07:05:06.3720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w1NyzK+1Xvr+NN02r0V98lJJVOlCLeYtpDorMqLXvYX8X1m/TrAG/x+JLjrJuD5ztbvL5Xs+8+jVbv7wCbqtNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6493

PiANCj4gT24gMjUvMDgvMjQgMTA6NDEsIEF2cmkgQWx0bWFuIHdyb3RlOg0KPiA+IFNEVUMgbWVt
b3J5IGFkZHJlc3Npbmcgc3BhbnMgYmV5b25kIDJUQiBhbmQgdXAgdG8gMTI4VEIuICBUaGVyZWZv
cmUsDQo+ID4gMzggYml0cyBhcmUgcmVxdWlyZWQgdG8gYWNjZXNzIHRoZSBlbnRpcmUgbWVtb3J5
IHNwYWNlIG9mIGFsbCBzZWN0b3JzLg0KPiA+IFRob3NlIGV4dHJhIDYgYml0cyBhcmUgdG8gYmUg
Y2FycmllZCBieSBDTUQyMiBwcmlvciBvZiBzZW5kaW5nDQo+ID4gcmVhZC93cml0ZS9lcmFzZSBj
b21tYW5kczogQ01EMTcsIENNRDE4LCBDTUQyNCwgQ01EMjUsIENNRDMyLA0KPiBhbmQgQ01EMzMu
DQo+ID4NCj4gPiBDTUQyMiB3aWxsIGNhcnJ5IHRoZSBoaWdoZXIgb3JkZXIgNiBiaXRzLCBhbmQg
bXVzdCBwcmVjZWRlcyBhbnkgb2YgdGhlDQo+ID4gYWJvdmUgY29tbWFuZHMgZXZlbiBpZiBpdCB0
YXJnZXRzIHNlY3RvciA8IDJUQi4NCj4gPg0KPiA+IE5vIGVycm9yIHJlbGF0ZWQgdG8gYWRkcmVz
cyBvciBsZW5ndGggaXMgaW5kaWNhdGVkIGluIENNRDIyIGJ1dCByYXRoZXINCj4gPiBpbiB0aGUg
cmVhZC93cml0ZSBjb21tYW5kIGl0c2VsZi4NCj4gPg0KPiA+IFRlc3RlZC1ieTogUmlja3kgV1Ug
PHJpY2t5X3d1QHJlYWx0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEF2cmkgQWx0bWFuIDxh
dnJpLmFsdG1hbkB3ZGMuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9jb3JlL3NkX29w
cy5jIHwgMTYgKysrKysrKysrKysrKysrKw0KPiA+IGRyaXZlcnMvbW1jL2NvcmUvc2Rfb3BzLmgg
fCAgMSArDQo+ID4gIGluY2x1ZGUvbGludXgvbW1jL3NkLmggICAgfCAgMyArKysNCj4gPiAgMyBm
aWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9tbWMvY29yZS9zZF9vcHMuYyBiL2RyaXZlcnMvbW1jL2NvcmUvc2Rfb3BzLmMNCj4gPiBp
bmRleCA4YjliMzQyODZlZjMuLjc4MGM1ZGQ3MjY2ZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L21tYy9jb3JlL3NkX29wcy5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvY29yZS9zZF9vcHMuYw0K
PiA+IEBAIC0xNiw2ICsxNiw3IEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC9tbWMvc2QuaD4NCj4g
Pg0KPiA+ICAjaW5jbHVkZSAiY29yZS5oIg0KPiA+ICsjaW5jbHVkZSAiY2FyZC5oIg0KPiA+ICAj
aW5jbHVkZSAic2Rfb3BzLmgiDQo+ID4gICNpbmNsdWRlICJtbWNfb3BzLmgiDQo+ID4NCj4gPiBA
QCAtMTg4LDYgKzE4OSwyMSBAQCBpbnQgbW1jX3NlbmRfYXBwX29wX2NvbmQoc3RydWN0IG1tY19o
b3N0DQo+ICpob3N0LCB1MzIgb2NyLCB1MzIgKnJvY3IpDQo+ID4gICAgICAgcmV0dXJuIDA7DQo+
ID4gIH0NCj4gPg0KPiA+ICtpbnQgbW1jX3NlbmRfZXh0X2FkZHIoc3RydWN0IG1tY19ob3N0ICpo
b3N0LCBzZWN0b3JfdCBhZGRyKSB7DQo+ID4gKyAgICAgc3RydWN0IG1tY19jb21tYW5kIGNtZCA9
IHsNCj4gPiArICAgICAgICAgICAgIC5vcGNvZGUgPSBTRF9BRERSX0VYVCwNCj4gPiArICAgICAg
ICAgICAgIC5hcmcgPSAodTMyKSgoYWRkciA+PiAzMikgJiAweDNGKSwNCj4gDQo+IElmIGFkZHIg
d2VyZSBvdXRzaWRlIHRoZSBhY2NlcHRhYmxlIHJhbmdlLCB0aGVuIHRoZSBjb21tYW5kIHNob3Vs
ZCBmYWlsLA0KPiB3aGljaCBpcyB3aGF0IHdlIHdhbnQsIHNvIGJldHRlciB0byBsZWF2ZSBvdXQg
dGhlIG1hc2sgaS5lLg0KPiANCj4gICAgICAgICAgICAgICAgIC5hcmcgPSAodTMyKShhZGRyID4+
IDMyKSwNCkRvbmUuDQoNClRoYW5rcywNCkF2cmkNCg0KPiANCj4gDQo+ID4gKyAgICAgICAgICAg
ICAuZmxhZ3MgPSBNTUNfUlNQX1IxIHwgTU1DX0NNRF9BQywNCj4gPiArICAgICB9Ow0KPiA+ICsN
Cj4gPiArICAgICBpZiAoIW1tY19jYXJkX3VsdF9jYXBhY2l0eShob3N0LT5jYXJkKSkNCj4gPiAr
ICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+ICsNCj4gPiArICAgICByZXR1cm4gbW1jX3dhaXRf
Zm9yX2NtZChob3N0LCAmY21kLCAwKTsgfQ0KPiA+ICtFWFBPUlRfU1lNQk9MX0dQTChtbWNfc2Vu
ZF9leHRfYWRkcik7DQo+ID4gKw0KPiA+ICBzdGF0aWMgaW50IF9fbW1jX3NlbmRfaWZfY29uZChz
dHJ1Y3QgbW1jX2hvc3QgKmhvc3QsIHUzMiBvY3IsIHU4DQo+IHBjaWVfYml0cywNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdTMyICpyZXNwKSAgeyBkaWZmIC0tZ2l0DQo+ID4gYS9k
cml2ZXJzL21tYy9jb3JlL3NkX29wcy5oIGIvZHJpdmVycy9tbWMvY29yZS9zZF9vcHMuaCBpbmRl
eA0KPiA+IDc2NjdmYzIyM2I3NC4uNDYyZWZkNDNhY2ZhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvbW1jL2NvcmUvc2Rfb3BzLmgNCj4gPiArKysgYi9kcml2ZXJzL21tYy9jb3JlL3NkX29wcy5o
DQo+ID4gQEAgLTIxLDYgKzIxLDcgQEAgaW50IG1tY19zZW5kX3JlbGF0aXZlX2FkZHIoc3RydWN0
IG1tY19ob3N0ICpob3N0LA0KPiA+IHVuc2lnbmVkIGludCAqcmNhKTsgIGludCBtbWNfYXBwX3Nl
bmRfc2NyKHN0cnVjdCBtbWNfY2FyZCAqY2FyZCk7ICBpbnQNCj4gPiBtbWNfYXBwX3NkX3N0YXR1
cyhzdHJ1Y3QgbW1jX2NhcmQgKmNhcmQsIHZvaWQgKnNzcik7ICBpbnQNCj4gPiBtbWNfYXBwX2Nt
ZChzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QsIHN0cnVjdCBtbWNfY2FyZCAqY2FyZCk7DQo+ID4gK2lu
dCBtbWNfc2VuZF9leHRfYWRkcihzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QsIHNlY3Rvcl90IGFkZHIp
Ow0KPiA+DQo+ID4gICNlbmRpZg0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
bW1jL3NkLmggYi9pbmNsdWRlL2xpbnV4L21tYy9zZC5oIGluZGV4DQo+ID4gODY1Y2MwY2E4NTQz
Li5hZjVmYzcwZTA5YTIgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9tbWMvc2QuaA0K
PiA+ICsrKyBiL2luY2x1ZGUvbGludXgvbW1jL3NkLmgNCj4gPiBAQCAtMTUsNiArMTUsOSBAQA0K
PiA+ICAjZGVmaW5lIFNEX1NFTkRfSUZfQ09ORCAgICAgICAgICAgOCAgIC8qIGJjciAgWzExOjBd
IFNlZSBiZWxvdyAgIFI3ICAqLw0KPiA+ICAjZGVmaW5lIFNEX1NXSVRDSF9WT0xUQUdFICAgICAg
ICAgMTEgIC8qIGFjICAgICAgICAgICAgICAgICAgICAgIFIxICAqLw0KPiA+DQo+ID4gKy8qIENs
YXNzIDIgKi8NCj4gPiArI2RlZmluZSBTRF9BRERSX0VYVCAgICAgICAgICAgMjIgICAvKiBhYyAg
IFs1OjBdICAgICAgICAgICAgICBSMSAgKi8NCj4gPiArDQo+ID4gICAgLyogY2xhc3MgMTAgKi8N
Cj4gPiAgI2RlZmluZSBTRF9TV0lUQ0ggICAgICAgICAgICAgICAgIDYgICAvKiBhZHRjIFszMTow
XSBTZWUgYmVsb3cgICBSMSAgKi8NCj4gPg0KDQo=
