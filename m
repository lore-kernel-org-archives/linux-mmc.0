Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB8519ADA4;
	Tue,  4 Feb 2025 04:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738643045; cv=fail; b=qr7yNlchWIxc56gk+d224qNLjz+xQ34jRiRAWLzojtHYKCi4DbRlL33T2TvmHxpL0kuasTdJ8TK/4q1QrYqQzBilntn7GviJ7qRtE1J/T57q5syBfE/BDA5OTqtHzyIHhCBYmbExFDj3GV9NGoZ+/4WlkhSo39ZWOxDu+pTnV9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738643045; c=relaxed/simple;
	bh=kPOjGNH/9fdSQDT9K6eEvUzdbR5cZKIB+NMvFFIEkHI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HWYRon3xLx1bKNpKzmbf/R/kWWPfW1EmwqJMuAXfxpnbUbX7D1GzNP4WRjJqNvn7y/aFW5zPNZOeQTMkn0RmIpcqWBB40by3jA3+x2q7D3Qo9DiHzhCVhFTBWQDIch7zxuDUePZ8LOj5Dfu8SPLGVd8qDPfQiX/+0LEUSDT1wak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=unSMFVZI; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="unSMFVZI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqbSrE/ObNkHMJYNNOA7SXWsGgI14ZYBVqzAbkcKuEODUuAXGnMjCja4a3YUKgDa5Bbmra0B9UHvGJl9/wcjU5uwUbht4YZ4jPDUBefNtd3Glzwhiw0TCx6vpzT3x0xwki6vOA9rk6AlhyC5E62NvGP6+J0JS+y+7S4hl32YOGnfirJwDa9tnuvgWD8G6qoKiI/FjYPYicvamTobP8mRKClkgXbWnPZBQNqlYcn+NmHjExjVlrqRdc1aKg1xxAuUPnbmpNdhgPv0l12UxZmgp25YX8bYaYyxY3DMum/EC5qjnEOTGLpC8wAjzHTbWbAXgVhvw3ZMk+RQoASgVcg6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPOjGNH/9fdSQDT9K6eEvUzdbR5cZKIB+NMvFFIEkHI=;
 b=Iqhm4n6Zub6vcQaqEodM8ihggClF1JFiWDHJnL20Tf9cva+2sw396tpkfPsiCD3OipM/EKy0x5k81CKfXFW2UkOwgKgA5JyiSGZTjUit01dtlUOAuGPTAyevoCqsoEVUKEBZLaFEAFtr9yB0KjnrfXy0DVXVI0NwOfcaO0Nad+Z+iR9lVYO94ip/kKji2olcU4yH0vNiTS8s8lOpoZluO9djQ4pB8DG7b5Qxw1iHZWSCQHCztf7CDVqRNvs5ua9ps/ZrQXzY/aOYPxoKn4SnppS34USkEvFFwe6/jeQe7zJ5q4FgWUtrjpqd0VkNkFq+t4CVIUGpb1u5Uiom1YmKCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPOjGNH/9fdSQDT9K6eEvUzdbR5cZKIB+NMvFFIEkHI=;
 b=unSMFVZIdiPLirclJZ+d8k1b1gWFG1YvOhcAhxAHbNbSxFB3tP9IH450H1KpKAbdGGojqfkB8jwvW11Y4YDv6DK4LyGlu2ssaGggKhTdNmRHwPbB2QbXDFKxeKCUPz6ejgnpqAeDKfFyaEdF64Hj3bLc6V3fCceAl51W8vABImPkuXeE8XB13lDiuUOJKvzWUOgvm66Ijc1rGBckbMlM7/DAJTgD066vZkjND0gl/cZsyyg2dkDitS/NmcTRBrFRyoi3xwyVrCrqTmw8cHM7+JBhc9hyBQExIzhDJVN2t0SAbXOEjhsE9XKKT6B5ICIZ4xBFy8YX1u6z1QTgzP7Evw==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by DS0PR11MB7557.namprd11.prod.outlook.com (2603:10b6:8:14d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 04:24:00 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%6]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 04:24:00 +0000
From: <Dharma.B@microchip.com>
To: <robh@kernel.org>, <conor@kernel.org>
CC: <ulf.hansson@linaro.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<neil.armstrong@linaro.org>, <khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH] dt-bindings: mmc: move compatible property to its
 specific binding
Thread-Topic: [PATCH] dt-bindings: mmc: move compatible property to its
 specific binding
Thread-Index:
 AQHbUcwFXFHAxHVg1UOmapSBwIyZUrLuAKyAgBzF3oCAAR0SAIAAbuaAgAEpg4CAEch5gIAXkSEA
Date: Tue, 4 Feb 2025 04:24:00 +0000
Message-ID: <f312c7ff-8d9b-4317-a75b-ce3d0f94a7ae@microchip.com>
References: <20241219-mmc-slot-v1-1-dfc747a3d3fb@microchip.com>
 <20241219-scenic-revision-17da9231d61a@spud>
 <91dfdd42-6ddb-490f-acda-41ce55782959@microchip.com>
 <CAFBinCCxZjuXL0duy3ePPDtL1oJS_GZiX3=djXpHR+-6gLkN_w@mail.gmail.com>
 <39be0bea-c207-4bcd-b464-ca93e91cec93@microchip.com>
 <CAFBinCAO0bpd7PXaVJWMby4Mqj1On5DaqNZua4V3gPUDms8=LA@mail.gmail.com>
 <779651f3-e5d4-4de8-878a-84653735e5cb@microchip.com>
In-Reply-To: <779651f3-e5d4-4de8-878a-84653735e5cb@microchip.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|DS0PR11MB7557:EE_
x-ms-office365-filtering-correlation-id: 94c7c455-e7b0-4d0c-3079-08dd44d3c01c
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bExwdFg4RUo0eTNCWW5LVEsvVjlGc3NTVDZQd2FqQUNMU2FzU0p1b1QvYlFi?=
 =?utf-8?B?U0t2MHRSRlZUczNZclZINUt4MjhYVXJoUUpJTktYd2VQSmpNam9mNS9kZXJM?=
 =?utf-8?B?dkR6MlBoTHJrL0VZSUxwSEtvVEtOQUxTWUxDT3ZkdnhCTkxtSmNIY3A3YzBw?=
 =?utf-8?B?REs5bWJMMUUxWHBXNmxMdlpVUlNwRzRnS2hXVllrM0tWSWIrZXZjQkMzMDEw?=
 =?utf-8?B?ZGF0Vzg2aDRIZm1qSmZKSG51bFZHN0R3K1FpNFZuUEJtdlRZRDBYSTlIQ2lL?=
 =?utf-8?B?dlA4MXpYeGdyOTAxeVFLZDhMWWovRm1XZFplOWxqSU9UcWs3ODFxVXpyQ2NY?=
 =?utf-8?B?bGQvZWxwUklkTkc2bFRZRGlyNndFWUdJZzR4aGJINUxhY3J1RC9YNGpHT2hu?=
 =?utf-8?B?UHMzNWFIVDd3Wm5IeFpUTk5XTTJ5U0RBYXhQMTI5YU5qSlhidDlxdGRIdnBN?=
 =?utf-8?B?aTFyRWU2TmRoaWVueWIyd1JVckd2czhIWkliT05NL1pWRTJXRWg5NUxoejdL?=
 =?utf-8?B?RWsrdkQ5NGlKZ2FMUkJzSGRwVEViV0duTWpQeEw5MzZGSzhUNHhZUXN2cHY4?=
 =?utf-8?B?bVlJRlE2ZWJUVWJyVjNYbzlWRXlkSk5DOXJobXR2cE83UUtTNDZjd2ZsaHND?=
 =?utf-8?B?cDEwdXRKRHRwcWRhOCtzRDFxQVM1Njk5Qm92ZFkyWWZFMkt6eGFwc2FQSXRt?=
 =?utf-8?B?Z3g1cXM2aGhzaWhCMktJMTIzN2w4MG40cXYwT0pMaDVPSW1oWTBCUzF2NVNW?=
 =?utf-8?B?TWZ5MmxSWEZQTEpaNVdvR3JDemxHRVBDZlAxMi95VU9CaG1mZDc3Yi9lQTkz?=
 =?utf-8?B?L085bzFiajNFeW5UOHZsNVBzVEN1aUNGb2hsUmo4VTB5MURmS09WN1hRMEJI?=
 =?utf-8?B?VFNraVhvSys5elRnbGt5L1dBSzh4NUtGQ3Rsc3lIVDJWcktOaVR2c3BvZ1lx?=
 =?utf-8?B?Y21lcDJmMkpKL05LSXFUSzJuRC9DQ1FkYXV4VHZQaFpUdUtLUy96Yy9iNklt?=
 =?utf-8?B?V1ZySEs0Tk5JVnZCYVA4Q2UzbWs1dGJiSUpjcE0vVWxtSEVXS2xlOE01VDdZ?=
 =?utf-8?B?T09rWjVxRFdvU3d5cWo3OEFGUFI5YU9RSStyT2twTld5Q3JwSzg5M3hFZTJN?=
 =?utf-8?B?a3o2cVpCMDgvNHgrZUFWbjNLWE5od0RhcklFRXdGc2hiMTNibnRHVGhINUlJ?=
 =?utf-8?B?cmNaWE5kNFpZczBaZlpkTDYraHd0UkdRRzY1T2RkYmErYzBKVWZaRjRnbXVJ?=
 =?utf-8?B?UUR1SnRnbnV1bCs5KzRobTF3MzhTVUFzOGc4aHdvYzJpKzRKS2dSVXFMMnRo?=
 =?utf-8?B?Y01MckRaTlpobkN3YUhSUy9IOStOd0o0RHFUT01EeDg0RU1XeVpTSFMrMWR0?=
 =?utf-8?B?WjlKUFlvSjg1KzJYYkx1QXdOTE1uajJiN1ZPTEVmWjFPK0tVVWRmallRa1NX?=
 =?utf-8?B?anIycSt1MEFMRzltbURjSzlrS0RhbHhMMEdtUlF4RDZOSzUwWEN1d25SU3d5?=
 =?utf-8?B?U21MRzNLK2tGNW95ZlYyaWxzOUppOXVVekxVT2ppK2lSZVYxaTIrbzBRTUZT?=
 =?utf-8?B?bzR1Vk0vT1pNU3JuVkpIOHZHMmV1TTFzSFBPa3psTERoUnpqWjRlM09ibmJQ?=
 =?utf-8?B?QnN5WXFiSmNSeTRKMVYyYXR5TXlEZjFRNnFFZTd5anAxTEtkRzJ6Zk5va0Ev?=
 =?utf-8?B?QlM5YjI5M0laOHdTUUpZWXIwS0ZFT2NNN2FJZ1BJUmVhanBWdjI3cUV2a2kx?=
 =?utf-8?B?eW5CcG9ybHM3WHhlemN6NmN6ODRVb1NZRk9aczVyM0RSV0loVGptRXRMOCtH?=
 =?utf-8?B?bzEyOXZYRndDS3F5cnA3NC9qMy91TFd2cVNUQmtoNU9oWTQyQ3B5UGh6V1lM?=
 =?utf-8?B?NFViQVBvb09jcklBWGZzMmc2czRSRHZPMkhKM1g3QWIyazBmQTU4dHViZXNZ?=
 =?utf-8?Q?T/21s2M9haZwueHS63jRBj3lBYBsqnCI?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WGJrMGQwZ3lwS3pXUSt3dUR6dFM0RmQzaE15WUtOdVltM21qNXd2V0lFVXEv?=
 =?utf-8?B?ZHl5NXU0SFlHY3d4dE10YW1zV1lFbk5IdXRSYS9HYnlxMmYrWno3K3JCaEU0?=
 =?utf-8?B?VS8xWms0Z3NNYytabU9ISG1CVTc4MUpyN2VHdzB1RjVtSlo5ZVBrMXJUcHRU?=
 =?utf-8?B?dDlCUHFoSSttL0Z3TWpJSHpDOWw4Qm81RU9BOXoxc3ZHZXlFK3FrUkVMbDZ5?=
 =?utf-8?B?MVJQSDdRMlZiWXhQd3pVeEJ6bk92aUhyd3VQTDgzQkxSME1EL0JCM201Tkkr?=
 =?utf-8?B?WGJkUXIvMGg1NnpvWXlRckRhWkZycFBtWGZ0dWRpVVJQbGluMnJ2QkplL1Bw?=
 =?utf-8?B?cGJNajFPQTA3YVRlVDBVS1ltVGJMZFVtK0t3c3BwZUtUR1pBcm9TR1JNMUxK?=
 =?utf-8?B?K3JSYmx6eTIxL1dISVZjOTdOQ1dkTWQ1ZTlkajN6OTM4b2ZFeDRnRmIwai8w?=
 =?utf-8?B?cUxaQUxpV3JNdjkrTUVJZDgzZkVVM09lcXBYbnJoSWk0YU1Lc0JJcXYwc1o4?=
 =?utf-8?B?RGxYT3p0YkJnZ3BHSzlZZlBzd0xvM3ZjSHM0b2IyVWhGckJqU2x0S2dFN1hu?=
 =?utf-8?B?OTQxRm1lcm5NdUdnN3VJNlk5c2hKaDNzRDNvMFdPTXFGWkpJV0pBTWJwTjh3?=
 =?utf-8?B?RXVUL2F6bE9EQ3V2bURFLzk5ZU1HWXA2ZnF1anVmVlg2VG5SQjVZTVFaaXFn?=
 =?utf-8?B?czZ3UmQyTytCWmptYnlDWTRUZGtpL04wUHJub1BpVXdsMzdoZElBUkNRaUFN?=
 =?utf-8?B?NDdZYUYrUGptcjl4QzIzaTdTOHI3T3I0VUFweVNuaUMycVNHdVp1eGJLT2xU?=
 =?utf-8?B?M0RWbU1aajNsOG9TVWxtaXN0OThYRmRobDRXWmc4dkRnTmhpdXM2SGlRVExG?=
 =?utf-8?B?TlV4aU1SRFlnRGVqVFAzYlVzZjNsL2hRTWVJdGd2MTJvTVRQMGxVVnoxLzBU?=
 =?utf-8?B?a09XUVZGRllLbWFtZytacE44eURNNlBSd3U1Y2lhd08yK0toM0k1UTZuUklr?=
 =?utf-8?B?RE0rbzVZeFpONkpaaDNyMzNOeG5jaVFKd2VibnZvLzBnM0JtME9GejZ4alVH?=
 =?utf-8?B?TmZlWWZLSjVoUDYraVc2WE5VL2l3M3dIUXhhWXZSbUFnWDEvZUhhR2VoeHZJ?=
 =?utf-8?B?cDdNQmd2ak5vNFgySjhhSXJtNktjRlYyNS9aemk1UHJ4Mll5dFVQNjBBalU1?=
 =?utf-8?B?MnIyMWF0YWJwUDJJSEFCeGxrZEpYQzZ0M1BVeFRJSkF2WVFWMVRyZFpUcXpY?=
 =?utf-8?B?bXV5MG8xTzZMM3h6ZXRFTzdpd0dqdDZUQThTYWp4dFdRb0c5VURqVStDM2pF?=
 =?utf-8?B?ODVZR0hSTnBsM2hnRHo4aDVNZnhGaldPVVhET25qSnhsd1MzRHRwdHJVSkFz?=
 =?utf-8?B?RTcxa1A2TmZkN000a0RMRFpJbWJ0OU9hWnpRbXFMWklJeG5sOVEyMWI5c0tZ?=
 =?utf-8?B?SkdLU043UUE2cENGcytkL3dQb0ZrYVpPUmt0cmlTWUdGWC9Yc3paMFU2LzVK?=
 =?utf-8?B?Wk1hVDlMKy9iY2xjNjlCSjUrWk4xUENZVU5WeFZ0TENyVThXenovZ1plbXY1?=
 =?utf-8?B?aUFJaFMydDRhMTltdHgwazNSZ2YrejlWTzdHeURRZ1hXSXlrbmRXVkRUeDN5?=
 =?utf-8?B?dUlnUDRHeUtzTjViS1ZEUHQ2UzJNWlNDWDNadlZ0bUhZVXZEZEtoMUtlTHlN?=
 =?utf-8?B?cUJtOG5tMkVyQWJSaXJWaDZveXpuS1poVitMdk1PNXhwZWIrQjRRUGRiN1g2?=
 =?utf-8?B?SVBXckNsM3FHbXFQNE9xQS9wUGYyNUsyYWlPUDZKQWdmYVoxM0lBaVp2bGh3?=
 =?utf-8?B?OTdxMm5FRGpjYjVIcTgvN1RMbFE2bTF2b0hVNE1NYk0wcDNJVVByUUxOci8y?=
 =?utf-8?B?TTVSZGdVV1pORWVuUk5iKzVIUEhoQUR0TXlFTGJGMFZGWlJuVUxuUklqQTZa?=
 =?utf-8?B?R0szQ2M2NVdzNEd6RVhUclRySm4rTDZWTTdyY0pWUDYxUy9EaXZBai93dXFN?=
 =?utf-8?B?SmNENlV0YnRHd0dJUDJ0NFFOMi9QbkxQdmFpQnBkTlRqeFNuQlVuTDJ1cE9S?=
 =?utf-8?B?bWZCTEE2VWptOTQ0WTQ4ZjVVQ24za1lua1VtT1pXYUJyRjFDbnJ0VFA1SE9p?=
 =?utf-8?Q?14JpyMloHQ8xgoj+gWPfYbgJQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0148FA8B85C4646B9DAF596CC9BC0E6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c7c455-e7b0-4d0c-3079-08dd44d3c01c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 04:24:00.8224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dTNpOT1cLpTleVpH3aSD5T/p0UHxQ74r2ohzPgiepb0wjVn2wjXbGlS7SAAgyxgmeM5qC9HkRgnGN00cirZvwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7557

Um9iIC8gQ29ub3IsDQoNCk9uIDIwLzAxLzI1IDEwOjAwIGFtLCBEaGFybWEgQiB3cm90ZToNCj4g
SGkgUm9iL0Nvbm9yLA0KPiANCj4gT24gMDkvMDEvMjUgMjoyNiBhbSwgTWFydGluIEJsdW1lbnN0
aW5nbCB3cm90ZToNCj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgDQo+PiB0aGUgY29udGVudCBpcyBzYWZlDQo+
Pg0KPj4gSGkgRGhhcm1hLA0KPj4NCj4+IE9uIFdlZCwgSmFuIDgsIDIwMjUgYXQgNDoxMeKAr0FN
IDxEaGFybWEuQkBtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4+IFsuLi5dDQo+Pj4gIk9uZSBpc3N1
ZSBpcyAnY29tcGF0aWJsZScgaXMgcmVxdWlyZWQuIEVpdGhlciB0aGF0IHdvdWxkIGhhdmUgdG8g
YmUNCj4+PiBkcm9wcGVkIGFzIHJlcXVpcmVkLiINCj4+Pg0KPj4+IEluc3RlYWQgb2YganVzdCBk
cm9wcGluZyBpdCBmcm9tICJyZXF1aXJlZDoiLCBJIHJlbW92ZWQgdGhlIHByb3BlcnR5DQo+Pj4g
aXRzZWxmIGFuZCBtb3ZlZCBpdCB0byBhbm90aGVyIGJpbmRpbmcuDQo+Pj4NCj4+PiBJIHdpbGwg
c2VuZCBhIHYyIGJ5IHJlbW92aW5nIGl0IGZyb20gdGhlIHJlcXVpcmVkLCB3aWxsIGl0IGJlIGZp
bmU/DQo+PiBGb3IgbWUgdGhpcyBpcyBmaW5lLg0KPj4NCj4+IE15IHVuZGVyc3RhbmRpbmcgaXMg
dGhhdCBpZiB3ZSBkcm9wIHRoZSBjb21wYXRpYmxlIHByb3BlcnR5IGNvbXBsZXRlbHkNCj4+IHRo
ZW4gYW55IGNvbXBhdGlibGUgc3RyaW5nIHdpbGwgYmUgYWxsb3dlZCAoZm9yIGV4YW1wbGU6IGNv
bXBhdGlibGUgPQ0KPj4gInJhbmRvbSxuYW1lIikuIFRoaXMgaXMgYmVjYXVzZSBtbWMtc2xvdC55
YW1sIGluaGVyaXRzIHRoZSBwcm9wZXJ0aWVzDQo+PiBmcm9tIG1tYy1jb250cm9sbGVyLWNvbW1v
bi55YW1sIHdoaWNoIGl0c2VsZiBoYXMNCj4+ICJhZGRpdGlvbmFsUHJvcGVydGllczogdHJ1ZSIu
DQo+PiBIb3dldmVyLCBpZiB3ZSBhbGxvdyBpdCBidXQgbWFrZSBpdCBvcHRpb25hbCBpdCBtZWFu
cyB0aGF0IHRoZXJlJ3MNCj4+IG9ubHkgdHdvIHZhbGlkIHN0YXRlczoNCj4+IC0gbm8gY29tcGF0
aWJsZSBwcm9wZXJ0eSAob24gdGhlIEF0bWVsIC8gTWljcm9jaGlwIFNvQ3MpDQo+PiAtIGEgY29t
cGF0aWJsZSBwcm9wZXJ0eSB3aXRoIHRoZSB2YWx1ZSAibW1jLXNsb3QiIChhcyB1c2VkIG9uIEFt
bG9naWMNCj4+IE1lc29uIGFuZCBDYXZpdW0gVGh1bmRlciBTb0NzKQ0KPj4gLSAoYW55dGhpbmcg
ZWxzZSBpcyBjb25zaWRlcmVkIGludmFsaWQpDQo+Pg0KPj4gUm9iLCBDb25vcjogY2FuIGNvbmZp
cm0gdGhpcyBvciBjb3JyZWN0IG1lIHdoZXJldmVyIEkgZ290IHNvbWV0aGluZyANCj4+IHdyb25n
Lg0KPj4gSSBob3BlIHRoYXQgeW91ciBmZWVkYmFjayB3aWxsIGhlbHAgRGhhcm1hIHdyaXRlIGEg
Z29vZCBwYXRjaA0KPj4gZGVzY3JpcHRpb24gZm9yIHYyLg0KPiANCj4gU2hhbGwgSSBwcm9jZWVk
IHdpdGggdjIgYnkgZHJvcHBpbmcgdGhlIGNvbXBhdGlibGUgZnJvbSB0aGUgcmVxdWlyZWQgDQo+
IHByb3BlcnR5IGxpc3Q/DQoNCkkgaG9wZSB0aGlzIGVtYWlsIGZpbmRzIHlvdSB3ZWxsLiBKdXN0
IGZvbGxvd2luZyB1cCBvbiBteSBwcmV2aW91cyANCm1lc3NhZ2UgZnJvbSAyMC8wMS8yNSwgYXMg
aXQgc2VlbXMgdG8gaGF2ZSBhY2hpZXZlZCBhbiBpbXByZXNzaXZlIA0KZmVhdOKAlHBlcmZlY3Qg
c3RlYWx0aCBtb2RlLiBFaXRoZXIgbXkgcGF0Y2ggaXMgc28gZmxhd2xlc3MgdGhhdCBpdCBsZWZ0
IA0KZXZlcnlvbmUgc3BlZWNobGVzcywgb3IgaXQgaGFzIGJlZW4gc2lsZW50bHkgc2FjcmlmaWNl
ZCB0byB0aGUgaW5ib3ggDQpnb2RzLiDwn5iFDQoNCklmIHRoZXJlIGFyZSBhbnkgY29uY2VybnMs
IGZlZWRiYWNrLCBvciBhIHNlY3JldCByaXR1YWwgSSBuZWVkIHRvIA0KcGVyZm9ybSB0byBnZXQg
YSByZXNwb25zZSwgcGxlYXNlIGRvIGxldCBtZSBrbm93LiBXb3VsZCBsb3ZlIHRvIGhlYXIgDQp5
b3VyIHRob3VnaHRzIHdoZW4gdGltZSBwZXJtaXRzLg0KDQpMb29raW5nIGZvcndhcmQgdG8gYnJl
YWtpbmcgdGhlIHJhZGlvIHNpbGVuY2UhDQo+IA0KPj4NCj4+DQo+PiBCZXN0IHJlZ2FyZHMsDQo+
PiBNYXJ0aW4NCj4+DQo+IA0KPiANCg0KDQotLSANCldpdGggQmVzdCBSZWdhcmRzLA0KRGhhcm1h
IEIuDQo=
