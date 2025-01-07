Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6141259493;
	Tue,  7 Jan 2025 03:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736220883; cv=fail; b=MJO4jsA5MVXpnpyhGLD0A/OojRL1sTo7uRybpIKTq9JHAlP0+Y4vWtQT191F7jZM40srGKFBGnaBInTC8HrVI7HBKh/aM1+LGQG0uUWLzAM5EEkI2p9WD5PZGioxZORf6hMnCt0cKayvzLhqz5+DT5Tph2lI7N5P6zPo7c9u6ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736220883; c=relaxed/simple;
	bh=tQhA+2fY1cCHOaTEo1D7LHL1aSc6304iFW1C4nOwjek=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iv0D08yIL9YZ7NBl+qv1RynRpmwz5JESX/SBMUIy+YWUgNLjesMvyDKyFpIxE1D090nq3562XF8yInG93K4sHFy9JknDRGiNsr/lBqnbK2DownMsKF9I+O8cpfoiQIp2gUmYPbt+KA738FZzK27c+3TsGHvX5zVoALmAoIAO9IY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=q4/Ka5Gu; arc=fail smtp.client-ip=40.107.100.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="q4/Ka5Gu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKAEM5HujNtj1h++gWA/ipHHd2tDI/gDlw5IQxnCBPiSCbC/XLUiq2taWYY+6yUnnltueB8uTErOz/hJ5QXQflTpEXqDUyloesZ5mouBgL7aWkiSJ9lBkwqkNdXjEKAdlZUfvkmYnSPQ4DDTqFa/TWUMgf1/Sw60tRSQEJ2xUaIM0dBZCmlxL0/HsNBzCLbJPKh+u5bpd8vZ0ETLaTtbucbtY+fmsFSsID3j/nOUbbMOzQKxOozgDUyZ3a/T8TYVjTWDaVZMt2s9yXuYz+jSGmaY3pdkOVwO4lBkDTac35oS82dmuIGDCy1U5jNvocnElh2C4MttNnmgEGWNBYzwHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQhA+2fY1cCHOaTEo1D7LHL1aSc6304iFW1C4nOwjek=;
 b=HkenKkKEV5JBsrSXSZVZ61VIXfVTu7chk41JqutF5byDVvDqiurP5HqKlYYTHoT4U20jNLanF0EToW4TgKb6Du39L5GGhDdkJkRr/aEkezn3yEMVNEk6SYOm6E6ftcZIkFM4LKj4rPWF0x/DAzhhGtGIFTDMu+b1fe0mKr97Hp7pLmCy0gMu5pPjB70WBQeuiWWAZYlDNrfWbdPsQxgLtIvnYwULCavwiG7xD9nNGwkcIquNaW1CC77kUzrcLtIVltZaspu5mmrAtG+poJ0ltrelFd6pWc1rJcito1kP070f3p3zZlgc6XXIs4X0oBBkobNrZmbYFjG6P0s70l/t4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQhA+2fY1cCHOaTEo1D7LHL1aSc6304iFW1C4nOwjek=;
 b=q4/Ka5GuUZY5lBBVDIUzLtxzbqIXaaKfdwta2TJVE18IZrGRcMX28tW7k4R0Wp2QYmZX0M81w6/qwUzAiqksr8Y9/BBobSJg1nT1+X4P+uTRgz8wgDzPqLpI7yGfZpbyWCy0oULTDT7k+/nDk9I3Uc558SJ8OVgnP6vZU0BHeqBuXH+dAsA2YCWr15Xh2xpQJIZuw/krG/ZXmp/4tEYbId8lJHd9dPv8nHllUnNJk2WVO3pcH2pHLhHtlM+B117OA6lKJlBQAGwVx3vh0WcyWtY19EqpIRdQCaR2MpfMKGaDtyhd+lKMBhUwgy4kj2EPAQ8kCwsUbIaMM9J2vGlXOQ==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by MW3PR11MB4731.namprd11.prod.outlook.com (2603:10b6:303:2f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 03:34:33 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%5]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 03:34:33 +0000
From: <Dharma.B@microchip.com>
To: <conor@kernel.org>
CC: <ulf.hansson@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
	<jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
	<linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: mmc: move compatible property to its
 specific binding
Thread-Topic: [PATCH] dt-bindings: mmc: move compatible property to its
 specific binding
Thread-Index: AQHbUcwFXFHAxHVg1UOmapSBwIyZUrLuAKyAgBzF3oA=
Date: Tue, 7 Jan 2025 03:34:33 +0000
Message-ID: <91dfdd42-6ddb-490f-acda-41ce55782959@microchip.com>
References: <20241219-mmc-slot-v1-1-dfc747a3d3fb@microchip.com>
 <20241219-scenic-revision-17da9231d61a@spud>
In-Reply-To: <20241219-scenic-revision-17da9231d61a@spud>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|MW3PR11MB4731:EE_
x-ms-office365-filtering-correlation-id: f66196c0-1165-4d44-816b-08dd2ecc339f
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cWN4MVBnVU4yV2g5eXdSNTB0NFlGTjJhZWMyd2YzNlgvdDhkaW81RGlqdWN2?=
 =?utf-8?B?dGFaYlM0aU8xbUNUd0t6VkRsNHVzUEdvZUdZSHA1YTRlSXl4QnJOaElpajI0?=
 =?utf-8?B?M204MHZrWS9JTGozMUJDVjYyalMzS3FYTTJ2OWdvbG1QVGxYeExySU0wYS92?=
 =?utf-8?B?SEZadnJTZlpnZjY3NDg1ZVlxTnN1SnBSdktQazhMaCswanZsSmJwQ0d2T1lJ?=
 =?utf-8?B?amJMNXI3OUYyaWFzcUo0K1BneEpvRk1NbWhvS3h5WHQzOTRoNnhXMHVqeWty?=
 =?utf-8?B?UWg2VVgyV29qeDhTbkpWY3pUbW0reEFjU1FwT21xK2NrRDNpS1F5RWVvWTMv?=
 =?utf-8?B?MVFVR1JGREl6MHc2NmlicTJRdE9NQWFsaGhMZWxUNExObmlGVUFLL3Z3OHZY?=
 =?utf-8?B?UHZFMmpXdU4yYWhaUU1kUjZqdFBhWUJJa01MZ3gzam5KZ0QzcDRXOTRuMFBx?=
 =?utf-8?B?MkRmdG1Qd2s2cDArd2ZlSHRlNzFJUmlmVy9NbFVjbHVOZHJhOGowSDhyRjN0?=
 =?utf-8?B?MC9FRGxKQU8ya25adDBOVnBNL2R1TkJ1QllLejA4Z3BzU1dXYml5MGJqVXh0?=
 =?utf-8?B?b205T0VDQXU4Mm11YXg3eXVTYlhkeE8wN0pkUk1jK1QvS09SNUkwYVlKK0NW?=
 =?utf-8?B?ZXdLejdpcHFHMXhvRURrY2RLYlNtQzc1N1pBTjl1SHViVEcwc2VjM0FMbzFl?=
 =?utf-8?B?QzU2dkFEWDJFNUluUGkyVGJHc3h3NXRKYlp0blhqWHlKUEQram85eXBEZitq?=
 =?utf-8?B?VG5CblVhZGdNMm9OTnQvOUhqMlk2NkxjQTI4enJjaFI5d0RnSW1YSzg4UXFu?=
 =?utf-8?B?dXlMbkkxWXhEOGNRbXhMUlp3RWNLZzlpN2VhR1BsOVJzTWh3a0hDczhqdzFD?=
 =?utf-8?B?RVpacjQ2YWMwWnRtKzJ0bFhCR0xsQUtFL0RJMm5TZDlzSG9HSktLUElwaFNX?=
 =?utf-8?B?dWVIeVhkZkF5L2czOHZnb2VhcVJrWnNIbFFjZDlaRU01SFVORWJrTUN0SDNI?=
 =?utf-8?B?dFVreGNYcUo2RzROK2E5NU5OM1dQZ2R2UUxPbERXLy9yWEZHbkhJMm9vUUdt?=
 =?utf-8?B?UFBvakx0MnFwdXBaWmsvUm1yOTZVenBEcWVEOUpLNHBlNG9wczRrQnhCT05Z?=
 =?utf-8?B?U0RQWWxRSXFBNjBHcFYybERsRzV6dysvODZVZVAvcFpsSGhKdkh0eVRLRENq?=
 =?utf-8?B?UG1jVzF6YmZyVWJhcG5LVGJ1NkY4dU5YVVZZNC96dG43S2YyK0Vob3JrN0RO?=
 =?utf-8?B?bFdLWXZwREhWNHY2azl6M1MwWHprTTBmZExHTHNCWUVyRkpHV3JCclBFQnN1?=
 =?utf-8?B?YUt6YXpidkwrK0tUNUVSZHZqZUd4SWRkNnRWc29wOTJncHpReTNrV2hkNjdz?=
 =?utf-8?B?d3I0OTFSNFZzbUE5TjliSUxOdTVzbm51L0tZWnZMbG4zeFRXYTZFM2NPbzJU?=
 =?utf-8?B?NVFNRmVtcjNZTjhyZlN1VDNzUU5PU1pFeW4xZ0xrNHVleXVNNExyQ0xiV3R2?=
 =?utf-8?B?R1l0WGx1YVo4SFhCZXVwV0dJTGJ5WDA1NlNGQnpQREhBR05oU3ppRm1ScWp1?=
 =?utf-8?B?NkU4Q1JmY2pYVGhVelZDVFd1OFhNWCtrcjZoK0E4TVJKVldmR3pUbEZxRVQv?=
 =?utf-8?B?VE96VnBKOC9ZYlZHS2N0LzRaaEZ1VDcwbkFlQ1UvR2l5R21iQnpFNzRmK0VI?=
 =?utf-8?B?d1RiZ0dGTFJaUlArc2VxUzVtNWZwbTZHZE9ERGRwU3B2aVBheU5wYVJlL3VG?=
 =?utf-8?B?NkJtZm1kVU5ZQ1J0OXIyak0yZ1FxY0lCUG1xQXZydWZvczlGRXY0L1dqUmFI?=
 =?utf-8?B?UWo1TEp4UnhWdHE0Qk1BS09UM0g5NzRERFNiMmxGVTlnNTVJMlREWEQ1M09s?=
 =?utf-8?B?d3V6dWxPSWNLdG9yVjU0ekpvQW9tNWVBYUxUVmdSUkREMDRiU3dtQnRGNDZQ?=
 =?utf-8?Q?zkonPSmjvvRxogp8aSA0WyFa2ccpoGNg?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NTJSejE4MnhjRlhJUkFPeFVFVU9TMDB4dE9odHRxTmlKTzBCYXNPbnorODZu?=
 =?utf-8?B?WE1LYVZlWS84N1NoQjlnZWFuWTQ5RVhCa0V3M0FnT3dSbzJDeWYxOWVsR0Fw?=
 =?utf-8?B?aTdYWDJoS3VmMWZTRmV4Y2dnK2FhZjNXeURmaWhhTnJpSlJkZTE4YUIvdkM1?=
 =?utf-8?B?Nng5b25ZdVVTeUFNR1hYWEdJTkpXalR5Q3NwWHk1dmp1UXhaTW45Q08vNElQ?=
 =?utf-8?B?R0wvUysxN0tRUU0wek9HSTlUSWtMR21EeVhCaVVITUVoSngySHVqNUY5VVk5?=
 =?utf-8?B?N1B2SnYvVHhKQTFSbHc1K3pXWEo5NjlDRFllWm5qRUZBeXpPZ1REcFl5bGxr?=
 =?utf-8?B?czZXRTZ6ZDEvZW5ONXFxT2FPWWM3aWpvVllXQ2ozaS80QVdIbHo5U0NBNzhp?=
 =?utf-8?B?T25yVU9UTnhVOFlBNEZteXAzWmU1ZWs4QUJ0UUEvRDJISnBZQnlqZnQySi9R?=
 =?utf-8?B?MWQzSWptbWNjcStwOFZzcVdPYXN4WTJGa2hwZGJORXdHK3B5TVpiK0tIK2ZS?=
 =?utf-8?B?Z0h4c240VWJ2WXRlYkZPNkZDNWl4dmdIQ2Z0Z2FhWkdpR0xabDBpY3hQVmFm?=
 =?utf-8?B?Tkp4U2hubDV0VE5qbEk0U0Zxa2tLaXpPNVhnR2tLZnQydWJZK1dTVENxK1Jz?=
 =?utf-8?B?MXlwMGxHMkZJVlZ2S2JkL1d0WXlIQ0Q5bndZTDFxdXAxYUpWRkVlVTVYUytQ?=
 =?utf-8?B?UG54VGhtSmIzSXlPdlNORENnR01aVUl2aUxySFBtMDFGZlRWUjBaR1hMcVdR?=
 =?utf-8?B?Z0JyZjlnWGlQNlEwaDRQeWZaS1plbkNKK1JsaXRZR3IvSVVCV3pSbGpPOTlh?=
 =?utf-8?B?bDdHWURDL3B0b1VZNmpDZlpKYTcrQVlBV1crZUtCSlE5czZQd2xnZzBaaHRF?=
 =?utf-8?B?dG82ZVpIbStNanJnTnAzc24xcGNaVFZraWg2dytMdXBuWnpWUW9DY05IeEZR?=
 =?utf-8?B?MjZLTlRINnZjR3JQODVuQTMwSzhwa1VZSGo1RWU3Qk1pc0Q1Y3l0bzFLTkxY?=
 =?utf-8?B?VldCeHlqc293NERNSDlya3dFeHRPemY0OGhvK2tIa0hpWmZZdittOE9zeDNS?=
 =?utf-8?B?aVBBaS9WdUN2RDdUNmozY3NwcTY2NWYrbmdCV3FaVjhyZFBWT2t6U3BDaDNN?=
 =?utf-8?B?V1ZCdFUrRm5oZEFPYWhzVmZWc3l4alIvV20wZkFXRS9BckQrQUJQM1Vubk9O?=
 =?utf-8?B?UG9xQ0xEV2grTnltVFpZMFl3eERvZ3MzZTVkRTQ2UVJHclZ2dXB4RnV2N2po?=
 =?utf-8?B?b3ZxaXRKSFcreXl3WVJWbi9TY3RWSHZMY0xRMHB0ZG5acFhyY0RxWFhydTBC?=
 =?utf-8?B?ZnFvQm5kbDBIWU53eUtGemNySVVTS2x4Z1NjZlpMTExjdzdjZ2djTm5PSTR6?=
 =?utf-8?B?WVR2cmU2aWxjRWR4Qm9nL0p3bVRNUElXcUV3UHNLOWw2bk9XeWxKUFl3d0U0?=
 =?utf-8?B?dWF5cFhSZXJZOFVDWXZPdmpUVE9WTTdVNEJxdVpnZGMxNldXQ0pKSEE4dUVC?=
 =?utf-8?B?V2lpYkIrbzFPMk4wa0Z0N1QvNSs3SGFucmdmY3VGRmJqOHRac0VMVFdCMGgr?=
 =?utf-8?B?OG0yZEk1RldKOUlkeHlmUVhOVm45NWRTT0xiUXRJWndDSktwZ053TzExU2lS?=
 =?utf-8?B?QVFLTHNtb2pONVA3M0ZXMjI1OHh3SHVMMVM0c2VjU2ZEMkx6dGFHcUVsemRm?=
 =?utf-8?B?U3RkMTRHZ3duWXBnek5scElVWlpvYk9YQ09NUk5YVUJUUk5CK2N2R293elBo?=
 =?utf-8?B?MmNZcDFTSGRqZzA2SmNSRjJaZ2t1QXB5SlE4NC9pbnJ2R0ljWmNnM29qb1Bj?=
 =?utf-8?B?Tklqb3hveEFnRzlmenhUVE1zMVRZZStrcHdnM3lUdmYvWVE1OUNPTmIwVFJa?=
 =?utf-8?B?TzJYWFd6cXlKbzZ6cUtxRndhVWRWWHhuQ3ZuRFQ2TUhHaGRRRUJrUkdkNGpY?=
 =?utf-8?B?bjEwQms2cDNLMGNtcDhXMFBnVWkzbHFHNmdIWmZRamM5ZXRpU0lpbmhEOXNX?=
 =?utf-8?B?d1NubUdndXdlUzltU0F4Mjc3NVNFVzVvcU1NenMwbVdiNnNEQ1hKU1JPOHNK?=
 =?utf-8?B?RzJTTFdmYjZMcDl1djFNU2lHcEpDYTdzaU1ueDV1RWNUZm5mTm5oVlBUeSts?=
 =?utf-8?Q?fuuh9rAlz/Aw1kF0y13KXnM7P?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01D4A007BE72B3458312E0AC5A1C1934@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f66196c0-1165-4d44-816b-08dd2ecc339f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 03:34:33.0492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T+wXii2QpJ+/4dF2DHU42AVGiO8rLrsO7mf7JREM+6MYQi6xwTLVt8MaUu7yNLeGlk9uOlGuNtLudpn41VI0gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4731

T24gMjAvMTIvMjQgMTo0MSBhbSwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBPbiBUaHUsIERlYyAx
OSwgMjAyNCBhdCAwOTo0MDo0MUFNICswNTMwLCBEaGFybWEgQmFsYXN1YmlyYW1hbmkgd3JvdGU6
DQo+PiBNb3ZlIHRoZSBgY29tcGF0aWJsZWAgcHJvcGVydHkgaW50byBpdHMgc3BlY2lmaWMgYmlu
ZGluZyB0byBtYWtlIHRoZSBNTUMNCj4+IHNsb3QgbW9yZSBnZW5lcmljIGFuZCBtb2R1bGFyLg0K
PiBUaGlzIG1ha2VzIG5vIHNlbnNlLCBhcyBwcmVzZW50ZWQuIFdoYXQncyB0aGUgcmVhbCByZWFz
b24gZm9yIHRoaXMNCj4gY2hhbmdlPyBZb3Ugd2FudCB0byByZWYgbW1jLXNsb3QueWFtbCBidXQg
dGhlIGNvbXBhdGlibGUgaXMgY2F1c2luZyBhDQo+IGRyaXZlciB0byBwcm9iZT8NCg0KV2UgZG9u
4oCZdCBoYXZlIHRoZSBjb25maWd1cmF0aW9uIGZvciB0aGF0IGRyaXZlciBlbmFibGVkLiBXb3Vs
ZG7igJl0IA0KaW5jbHVkaW5nIHRoZSBjb21wYXRpYmxlIGluIHRoZSBEVFMgZmlsZXMgd2l0aG91
dCB0aGUgYWN0dWFsIGRyaXZlciBiZSANCnJlZHVuZGFudD8NCg0KSXMgaXQgdGhlIGNvcnJlY3Qg
YXBwcm9hY2ggdG8gYWRkIHRoZSBjb21wYXRpYmxlIGp1c3QgdG8gZml4IHRoZSBkdCANCmJpbmRp
bmcgZXJyb3JzPw0KDQpyZWxhdGVkIGRpc2N1c3Npb246IA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGttbC82MzQ3MzQ3NS1mMjllLTRhNjUtYTBhYS0xZjFlNDExMmI1N2RAbWljcm9jaGlwLmNv
bS8NCg0KPiBPdGhlcndpc2UsIGlmIHRoaXMgaXMganVzdCB0byBhdm9pZCBoYXZpbmcgdG8gZml4
IHVwIHNvbWUgZGV2aWNldHJlZQ0KPiBzb3VyY2UgZmlsZXMsIEkgZG9uJ3QgdGhpbmsgd2Ugc2hv
dWxkIGRvIHRoaXMuDQo+IA0KPiBUaGFua3MsDQo+IENvbm9yLg0KPiANCj4+IFNpZ25lZC1vZmYt
Ynk6IERoYXJtYSBCYWxhc3ViaXJhbWFuaTxkaGFybWEuYkBtaWNyb2NoaXAuY29tPg0KPj4gLS0t
DQo+PiAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvYW1sb2dpYyxtZXNv
bi1teC1zZGlvLnlhbWwgfCA0ICsrKysNCj4+ICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21tYy9tbWMtc2xvdC55YW1sICAgICAgICAgICAgICB8IDcgKy0tLS0tLQ0KPj4gICAy
IGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4+DQo+PiBk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9hbWxvZ2lj
LG1lc29uLW14LXNkaW8ueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
bWMvYW1sb2dpYyxtZXNvbi1teC1zZGlvLnlhbWwNCj4+IGluZGV4IDAyMjY4MmE5NzdjNi4uNzYw
MGE0OTg4ZWNhIDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21tYy9hbWxvZ2ljLG1lc29uLW14LXNkaW8ueWFtbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9hbWxvZ2ljLG1lc29uLW14LXNkaW8ueWFtbA0KPj4g
QEAgLTU0LDYgKzU0LDEwIEBAIHBhdHRlcm5Qcm9wZXJ0aWVzOg0KPj4gICAgICAgICBBIG5vZGUg
Zm9yIGVhY2ggc2xvdCBwcm92aWRlZCBieSB0aGUgTU1DIGNvbnRyb2xsZXINCj4+ICAgDQo+PiAg
ICAgICBwcm9wZXJ0aWVzOg0KPj4gKyAgICAgIGNvbXBhdGlibGU6DQo+PiArICAgICAgICBpdGVt
czoNCj4+ICsgICAgICAgICAgLSBjb25zdDogbW1jLXNsb3QNCj4+ICsNCj4+ICAgICAgICAgcmVn
Og0KPj4gICAgICAgICAgIGVudW06IFswLCAxLCAyXQ0KPj4gICANCj4+IGRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL21tYy1zbG90LnlhbWwgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL21tYy1zbG90LnlhbWwNCj4+IGluZGV4
IDFmMDY2NzgyODA2My4uODRjNDYwNTY1OGUwIDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tbWMtc2xvdC55YW1sDQo+PiArKysgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL21tYy1zbG90LnlhbWwNCj4+IEBAIC0yMCwx
OSArMjAsMTUgQEAgcHJvcGVydGllczoNCj4+ICAgICAkbm9kZW5hbWU6DQo+PiAgICAgICBwYXR0
ZXJuOiJec2xvdChALiopPyQiDQo+PiAgIA0KPj4gLSAgY29tcGF0aWJsZToNCj4+IC0gICAgY29u
c3Q6IG1tYy1zbG90DQo+PiAtDQo+PiAgICAgcmVnOg0KPj4gICAgICAgZGVzY3JpcHRpb246DQo+
PiAgICAgICAgIHRoZSBzbG90IChvciAicG9ydCIpIElEDQo+PiAgICAgICBtYXhJdGVtczogMQ0K
Pj4gICANCj4+ICAgcmVxdWlyZWQ6DQo+PiAtICAtIGNvbXBhdGlibGUNCj4+ICAgICAtIHJlZw0K
Pj4gICANCj4+IC11bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQo+PiArYWRkaXRpb25hbFBy
b3BlcnRpZXM6IHRydWUNCj4+ICAgDQo+PiAgIGV4YW1wbGVzOg0KPj4gICAgIC0gfA0KPj4gQEAg
LTQwLDcgKzM2LDYgQEAgZXhhbXBsZXM6DQo+PiAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+
Ow0KPj4gICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4+ICAgICAgICAgc2xvdEAwIHsNCj4+
IC0gICAgICAgIGNvbXBhdGlibGUgPSAibW1jLXNsb3QiOw0KPj4gICAgICAgICAgIHJlZyA9IDww
PjsNCj4+ICAgICAgICAgICBidXMtd2lkdGggPSA8ND47DQo+PiAgICAgICAgIH07DQo+Pg0KPj4g
LS0tDQo+PiBiYXNlLWNvbW1pdDogN2ZhMzY2ZjFiNmUzNzZjMzg5NjZmYWE0MmRhN2YwZjJlMDEz
ZmRhYg0KPj4gY2hhbmdlLWlkOiAyMDI0MTIxOS1tbWMtc2xvdC0wNTc0ODg5ZGFlYTMNCj4+DQo+
PiBCZXN0IHJlZ2FyZHMsDQo+PiAtLSANCj4+IERoYXJtYSBCYWxhc3ViaXJhbWFuaTxkaGFybWEu
YkBtaWNyb2NoaXAuY29tPg0KDQoNCi0tIA0KV2l0aCBCZXN0IFJlZ2FyZHMsDQpEaGFybWEgQi4N
Cg==
