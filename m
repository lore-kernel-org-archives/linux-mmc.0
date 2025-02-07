Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4091A239A;
	Fri,  7 Feb 2025 07:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738913913; cv=fail; b=U/eL8uZr3t1xGf1ZdjLouXG0tfHsXqjCjO+Yk2DfWujKddPQz2zgoycpIktb9sCmITaTLAN2V3rLIooqnUk8y0iIM3pMkskPs/aMx4KSE53RfyTzJl+ISE/LzC4CEdmkWXUDa6ck2VskOe5zOrHHaHeDvtiGWoO2/Uny/YQysE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738913913; c=relaxed/simple;
	bh=9gOT98F7OcLdgH7B3GEhZM8+V1QUH75kFCsCJrD6oYw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kusb8MtP1sykug3DxwQt0YeMuRa2gwqT1cbqiZpedTOJhA5PKHZYLEr2XGTP0t7TsOQfoPXPiO/4GIgPQpcd2iCicN9uk0NRVF+76JZ5nYN+nXkti7K732HB1umlUXQeWR6U69OuwxLh+B42eB7RNiEmnWlc+JxxRfGjcNSTx/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xp2dJk3J; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xp2dJk3J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6ju9y7bCDSzB5DeOQ5eP7ZuOT0AZMXQcsrjDJrvkBm5U/A/6Mr+NVOvqgW6ZBNHytMKeNG7zUEXvMpBUYYec2g+tPoA4DdORDot2ZHiuIyVEkw4swUxaZvgPPZ5Pv2Ohhp5acktUxH/WQrfRv+hNozsjN7+tVKCm51vJ/c/6ZW150xDEnSFhY1r7R+epIfTPer0SNouJoPQR+xKbPfKhbmIB11EvV01TF1TmwsjAJJXM7IC5/JC/8gTccJmDN6/O0lf3AXmZ2DL3ogMz9T3L0o9syD57WkYciUfKQmJ4+i/rGMKNcuImx63xoP/qYsQ1zxStBGQSnwIvEWQDXh7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gOT98F7OcLdgH7B3GEhZM8+V1QUH75kFCsCJrD6oYw=;
 b=F2auuQYz2KDpZELlE395GqUCtMBriszvtlO4xUlUSxvQPhawZpw+nPZ8V4E5K14lytWPiezR+6BnZCSb2MsdHx3zNJyytm+Wb+uT0V8kqyTAkX176/NZIreE4uwBi4TCVPGFOAqinyJ02VRNMzHDHGQU5h/MRZEBzperlx1J9pyEDVZ6ScSd4UvcYaYzCj4Zi3j7g3aaRixyVtZY9t1wF4I7f1Ho71gY19fc82TkdSjIJuT+vMk5Trx5fB8+MF4nFx8eUL2DycffxNPkLWpPi6Jwy9G1fHC/IyIv1ot9KdLQHbs0nRK+9NjWTOC1RvdWNWCSpeNeH6WfDoOc3P/oRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gOT98F7OcLdgH7B3GEhZM8+V1QUH75kFCsCJrD6oYw=;
 b=xp2dJk3J3DsLTQIeDWkRNTXM9ome17byaI1y8W9AX2EtDtxW4NsglmsROEfj0SKmpWJTlRM2938EzN7vXTepGFXyh2RH1cqywdbK4dCJ/Je3LaF5ZBM587fBKgwKiAc+osoBDcm+VynAvGbN0eP3kr3RnaY6Hp596ZXxzUrWabDYnDBj98WKLrsIpNK/OtC3TGVhtKqkPlzzY6oxcagx0Em3fUs6VLMTKdoBvAFQAAUxvVCJ92du02bgOHTSkGxKVPW7vitAbt8xUF7kdBqNmNeHxljhzfneZEeAVi90ucpew+ES5gFpbBjHH9cplTBw6pfzF/ANIoEx8sNbKPscHQ==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by CY8PR11MB7243.namprd11.prod.outlook.com (2603:10b6:930:96::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 07:38:28 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%6]) with mapi id 15.20.8422.009; Fri, 7 Feb 2025
 07:38:28 +0000
From: <Dharma.B@microchip.com>
To: <conor@kernel.org>
CC: <ulf.hansson@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
	<jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
	<linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2] dt-bindings: mmc: mmc-slot: make compatible
 property optional
Thread-Topic: [PATCH RFC v2] dt-bindings: mmc: mmc-slot: make compatible
 property optional
Thread-Index: AQHbd4DiJT/2q7h3vk+co+F7jIgTKLM6moOAgADdCIA=
Date: Fri, 7 Feb 2025 07:38:28 +0000
Message-ID: <a2a9a5e3-91fa-47db-907f-c69ecfb73526@microchip.com>
References: <20250205-mmc-slot-v2-1-da3c5f30e2d9@microchip.com>
 <20250206-drainer-vastly-34a3c738e2bf@spud>
In-Reply-To: <20250206-drainer-vastly-34a3c738e2bf@spud>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|CY8PR11MB7243:EE_
x-ms-office365-filtering-correlation-id: 4bc74840-4f5d-4032-346d-08dd474a6992
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Mkp0V3pxQjlQaEt1ek9MVEZhL1J2NnNiOVo2bjFiUGoyek12c3d1Y041MXAx?=
 =?utf-8?B?anpDRCtwaFc0TjV2ZUhSYlFUYjMvblVQaEp5OE50SklEV01jczlxWmNEYTRx?=
 =?utf-8?B?UmVPWGw2RmpEWWlKemh6dWwvNmRuQ0Fmb2d3bjdiMzBIMXhBQlIyMTJSWmF4?=
 =?utf-8?B?cVBCb0hUM3VsL1NabThqdmxETG5NaWZUbm5VSkI4WmNjZmNScERqSGl6cGdE?=
 =?utf-8?B?WGNBMEYvcnNkUzdXaUZGL2xYT1RhdnpHYWVsRkZBMFhOY3hYS2tPcHZuUEVN?=
 =?utf-8?B?UG0vKzBEYmQwK2IrZWpjUXp3SHlsNEMvclBQb1ZOSFJRa05UZ1dJcFl0UHV2?=
 =?utf-8?B?Tk9mUXpLdnlxR2JUZENncGNyVHZ5endneUFmWWFpTUpWbW1pMG1Gd2xxOTRv?=
 =?utf-8?B?UGFxVFBuQ3RTeUFjZE1PMHdROUJkb1E1ajNFWThsQXZCZit4eW5Nb1lKeU4y?=
 =?utf-8?B?OG54ZEpBUnBmTytHSmg1b0M4SWowaU1ZelZmK3hBRVBPTUZhdHJaRnk0RXMw?=
 =?utf-8?B?Y3g4VjdsSFk1U0g1Y3RHekdFRFJMUzMwN1YzNDVrSWNad3hiOVRacE1pTVY1?=
 =?utf-8?B?NTFqb09TZkVTbWhVdExWYk9PQ1JCZE9UemdOYmo4SGtJUEtTYTdzYnpzc1ND?=
 =?utf-8?B?VUZza29UZURiZ2lMN0lOcTlWSUdrclZJSTZDS0xQTmZ2eG5vWGtRUXpralBx?=
 =?utf-8?B?bUtmWThwcFNQakhPeExkdmlsSEVZTlgzVVAxUWhwV00xdG00eVpkNXJwaFpx?=
 =?utf-8?B?eGwxYThKcGVadlR6SVdnWmtNM0MxdHMyRzdVU0YvUWNuK2d4SWJSYWo0b05C?=
 =?utf-8?B?MklFUjhKTWQ1eDVibG5SVG9EWjJwb2NVd3hyL0ZjNkIrdHBpYUE1NVU3NGpj?=
 =?utf-8?B?cDNtNlBud0N2cGZQZjdtZ0V3ZjdUN2dtcHVOQ3RyYXJwOVREUFBhRW5yUmVS?=
 =?utf-8?B?NXIxZ3M4c1BBdCsxWEs4RHo4R2RjVmpnQWMwemFzc2NhRmlwTGs4Tmx5NVdV?=
 =?utf-8?B?NEFMNEZrM05sZ2Z4YWxyMWlsdmhlU05PNWh5VjY0OU5qdGxyT0tXU2lWRVFC?=
 =?utf-8?B?KzhDNVcyS1JhNlk4ZzI4QjNYeG81dXEydHhUTUt4dkxUM1NzTGlpWjZUSjh2?=
 =?utf-8?B?OFFYWnBNSDQzeExLRVJCSzZvb3g2VElRMml4MFR5Zm4rYjNjQnR1VHhLSWpK?=
 =?utf-8?B?b0RYMVcyYUkvc0FZWXZ0cms3enBNNzhjOEt6Ymh2U1hER1BzeFBPZHJLdE90?=
 =?utf-8?B?TGV1K2tEVmZxS0IwV3h0UDM0VFpIdFl6NjRsQTkxaXRHU2NZN1k3aHBuMXVK?=
 =?utf-8?B?cjJZVWVCTHNuajJEWlF5Yjd6dDdpOFlITE9NbSs4Y0dyZGlRdFNwM2d3UU1t?=
 =?utf-8?B?VnNUZGtPOGt5bnAwR0FnRGlzMENXcHhYVHJnWmJlWlU2TWdEUGsxSVI4dXZ2?=
 =?utf-8?B?eTFxd0hDWm0yTlk5ekxWNEk0NTNvV2NpRXRmUUJYUkdmMHlkM2ZOL1ZIczE1?=
 =?utf-8?B?YWlTbnl0WHdkeTNuZlovOFFFM1VWOFRxd0JVZWFtQUxNSzhPOXJZeGhSUEZv?=
 =?utf-8?B?dEdhOGZDQ2FoUjhEWTZNQU9BcUN1eS81NU5LZ2pBTFYydU9neHpSQjhqWFUv?=
 =?utf-8?B?eFNzR3dQcXZNbGV4WGx5TXU2dzhEOVcrSmNHTnd1UUZSUjNtZ2NTSk11ZlhR?=
 =?utf-8?B?QzE0NGgybU13Z29uQWtvSzhoUGJkc3JGVkpBUE1BSTJkbU9kdGN4VzYvZ1ZJ?=
 =?utf-8?B?RUxzK2tDbTQ1MUtjc0RXWjFDdE5HcTN4MnBjcDFJOVkwUDc5MXJ4dWEzU0d3?=
 =?utf-8?B?aUFSOVdUeTJqK1R1SnYvNGhOeVlEa3dWK2p6TVhqcGs2YjR6TmpoL01jY2Nl?=
 =?utf-8?B?YVV3YU5CYVVTcUxyOUxPRnhLaCs0Ry9pN0g4UG9ialhMRkJmOVdTcWR0anlV?=
 =?utf-8?Q?Vftm1vmF3hQu563ZTPRdJ38L9nrq0GRz?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V1dQN0RWSUExK2YvTXF5dDQyQ2Vpb2dEZnlVV2k0aitnbWZwRXdQazMzNlBn?=
 =?utf-8?B?cTc5V0IrR1ZDSTAwQU9HVTZnb0t3N09JQzlhY1hUZ3I2ZXU3SjRzRUp6OGpj?=
 =?utf-8?B?b1ZRaGpBNk5xU1NTcnl5TVpxVlVpL0VrSnkxbmYzM3RoeHhuQkVhSWg4QjEz?=
 =?utf-8?B?VitYNzNsZFhoYktscThNMWZSeXZFUGxZQm5Gb2pIU1RPWDZPRnIxZldnbVVY?=
 =?utf-8?B?ajRuU0hzSDNxeEVFb0xzakxiZDUyMHFPYW9Cdi9JYkh6eXFobWszbVRjbFpt?=
 =?utf-8?B?RFNtKzV2c3JQT3U1NDNXQkhKaFNKeUszOE82am5QbnBjVHJvaktKYXpTS0VE?=
 =?utf-8?B?eFZYNWd6NWIwc2g3emxtQzVFTnBYRDNzeE9uUnJ5RFF3WllYUEptYmUvdW55?=
 =?utf-8?B?aVU5VGowY3pFaE4wZm9nc1RpWnhJUTE0NXBQOTVmd3d5emlYYkZVc3lIWmQv?=
 =?utf-8?B?WmZ0TFAwWDMwL25hM0F4dU5qUkhWYUN0Y0V6cHB2QllXbCs0NnYyRVQxdmFD?=
 =?utf-8?B?VUpiZlJuU0RmRjBDNDI3V0xGUTJOSW9LdGJ6T0luSEJERXcyWnpQVW9pSkRB?=
 =?utf-8?B?clpOcEdzNjMrZ0tabmxxV2dYMUZaOU1yRE0vY1pkZkxhN1hHRUZBT2J6OWlK?=
 =?utf-8?B?UHBQYm0xSEFjOTlIdVcrWkZGb2hIUk5HYmpvY09IMlh1M2tHZkM5TmpDKzcw?=
 =?utf-8?B?azhoVkF5VkY3QVl0WmRaLzlBMnRkdWxiRWl1Z1Y4V0hONzNkaHAwUCt6ejlZ?=
 =?utf-8?B?S3pSOUVvYVZnNXBObytOQldZMVhpOVFtUDNxMmtBNi9wYkFWNnpKRnJkL2pr?=
 =?utf-8?B?OEhzYWswQ1pXNitzMnZVejNWc3dKQVJYUlZzaDA3UGxhaGNlbjRsQ0hjS2NC?=
 =?utf-8?B?NWV4Z2dYZEpkNWJNb1N2UjJlTzVSdVcrY0FnTVI1QVRGMEZpaXRNK2haTEx0?=
 =?utf-8?B?WmJNbllyUXI0aEoreHNyNnVBbmtFL0gzeERmUStlNVNCN0QvYjMxTGJOVlVV?=
 =?utf-8?B?L0pnTGprbmRmeXZDWnRHN3BzbktxK25CRi9BVk5RdjJ5NlIvRmRuZVNwZjFr?=
 =?utf-8?B?T0w4aWYxSUxHOEpyd0NIelNaRHRIZFhyZnpQWHN3UEthbGdwWFpuYjVlalpN?=
 =?utf-8?B?RjM0WHFZV2xnUnplanc0eE9tbTl3dVdjbndIdEI2RTUyTUhWUlBFRkNsTnc5?=
 =?utf-8?B?em9zOUpITnE3RlpGUy8waE10R1IxcjMwMWQrbWJpVTlrNFRSSVpWK0I1L3dh?=
 =?utf-8?B?V3V5ZjlSWnh0NTBpaE5IQ25qN29XQ0E4NXJjQlZTaVpHTDY3NFJrdE5EeDVG?=
 =?utf-8?B?Z2RoN1lmdDk0dGVJeFhQYjY1Nk1ZaTBPS0tGTFA0VzBhaDlhckQ1eW1JbVJk?=
 =?utf-8?B?UzVFTHYzRTVyQkFnaW51TkpHckN5RFgxbUw5eTQ3ajQ4alFjd1ZmSXhlQ0x6?=
 =?utf-8?B?NnVKT01sY3c2RjBIUnJLblhzNWZERXpvOTNHYkhkY1lwK1FCMEhOSzNvYkQ0?=
 =?utf-8?B?YmNUdDN6SkZKY2d2a0FKekdyQmpsbFJOSjQraEdwWnlOZkQ3UEMzWE4ycm9V?=
 =?utf-8?B?UWxNbkpCT29WVy9VUkgxa2MzeGwxNnhmUTM0a2VEWUdpeXhLV1hUUzFCU0pX?=
 =?utf-8?B?Z1JiakNDYmxyNG5QcTk0OHNwZ1pHaDNaaXkzM29CMUJzVU1MbERJTVBSQVlL?=
 =?utf-8?B?ZjI5SWZPRld5dTljTU5COVZuRDREUUNaNU9UT1QyNER0ZkpMWklGdDFHRE1s?=
 =?utf-8?B?TW5Gek9BTkJKS0NhUlNPYmhYcVBSeG1NUmRyRUdOU3YvSlJZUnJwTnZhVzZt?=
 =?utf-8?B?S0FobU9Ic0xEM0FHRnhVeDZHOWZLNGNFTmx6Q1REUnFZd1pNV3BPUjhiSmxH?=
 =?utf-8?B?Rmk4WUMwUlY4cDR1aXpvRThTUWVmWUVjZFRnWWxkVWMwTUNKeitjL29OVy9P?=
 =?utf-8?B?RXJZWG0yMjZGalJmWVM0bHZjckp6ZGlCYjNIYm4xcG5TZjVTQjgxT2RyZDEy?=
 =?utf-8?B?MDIxZFRpWFpKek00SFQyYWRIbzhmd091M2YyelVEa1J5SU5mRGRJRC9Mb3Y3?=
 =?utf-8?B?NnlUWmk5OHhESExrSkxvbkxvQlJzRjhEWklZM01KVDlvdVByRTNRZFVwYWxa?=
 =?utf-8?Q?/RTwE9vbNTUhrxQObximcpFjA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38B166D5B7D857469C55D812E45C21E2@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc74840-4f5d-4032-346d-08dd474a6992
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 07:38:28.0190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PlfIhNnHDmmcCwf1JoTrnRdD2HxExsNu2mx/Ww1yseNLHMQ9HaJ60IYNKmT/jukS9wqrcv/cIwpvmjWlae2U8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7243

T24gMDYvMDIvMjUgMTE6NTcgcG0sIENvbm9yIERvb2xleSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiANCj4gRm9yd2FyZGVkTWVzc2FnZS5lbWwNCj4g
DQo+IFN1YmplY3Q6DQo+IFJlOiBbUEFUQ0ggUkZDIHYyXSBkdC1iaW5kaW5nczogbW1jOiBtbWMt
c2xvdDogbWFrZSBjb21wYXRpYmxlIHByb3BlcnR5IA0KPiBvcHRpb25hbA0KPiBGcm9tOg0KPiBD
b25vciBEb29sZXkgPGNvbm9yQGtlcm5lbC5vcmc+DQo+IERhdGU6DQo+IDA2LzAyLzI1LCAxMTo1
NyBwbQ0KPiANCj4gVG86DQo+IERoYXJtYSBCYWxhc3ViaXJhbWFuaSA8ZGhhcm1hLmJAbWljcm9j
aGlwLmNvbT4NCj4gQ0M6DQo+IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPiwg
Um9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4sIA0KPiBLcnp5c3p0b2YgS296bG93c2tpIDxr
cnprK2R0QGtlcm5lbC5vcmc+LCBDb25vciBEb29sZXkgDQo+IDxjb25vcitkdEBrZXJuZWwub3Jn
PiwgTmVpbCBBcm1zdHJvbmcgPG5laWwuYXJtc3Ryb25nQGxpbmFyby5vcmc+LCBLZXZpbiANCj4g
SGlsbWFuIDxraGlsbWFuQGJheWxpYnJlLmNvbT4sIEplcm9tZSBCcnVuZXQgPGpicnVuZXRAYmF5
bGlicmUuY29tPiwgDQo+IE1hcnRpbiBCbHVtZW5zdGluZ2wgPG1hcnRpbi5ibHVtZW5zdGluZ2xA
Z29vZ2xlbWFpbC5jb20+LCBsaW51eC0gDQo+IG1tY0B2Z2VyLmtlcm5lbC5vcmcsIGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnLCBsaW51eC1hcm0tIA0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZywgbGludXgtYW1sb2dpY0BsaXN0cy5pbmZyYWRlYWQub3JnLCBsaW51eC0gDQo+IGtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gDQo+IA0KPiBPbiBXZWQsIEZlYiAwNSwgMjAyNSBhdCAwOTox
ODo0MEFNICswNTMwLCBEaGFybWEgQmFsYXN1YmlyYW1hbmkgd3JvdGU6DQo+PiBSZW1vdmUgdGhl
IGNvbXBhdGlibGUgcHJvcGVydHkgZnJvbSB0aGUgbGlzdCBvZiByZXF1aXJlZCBwcm9wZXJ0aWVz
IGFuZA0KPj4gbWFyayBpdCBhcyBvcHRpb25hbC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBEaGFy
bWEgQmFsYXN1YmlyYW1hbmk8ZGhhcm1hLmJAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gQ2hh
bmdlcyBpbiB2MjoNCj4+IC0gSW5zdGVhZCBvZiBtb3ZpbmcgdGhlIGNvbXBhdGlibGUgc3RyaW5n
IHRvIHRoZSBvdGhlciBiaW5kaW5nLCBqdXN0IG1ha2UgaXQNCj4+ICAgIG9wdGlvbmFsIChyZW1v
dmUgZnJvbSByZXF1aXJlZCBsaXN0KS4NCj4+IC0gTGluayB0byB2MTpodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9yLzIwMjQxMjE5LW1tYy1zbG90LXYxLTEtIA0KPj4gZGZjNzQ3YTNkM2ZiQG1pY3Jv
Y2hpcC5jb20NCj4gV2h5IGlzIHRoaXMgUkZDPyBJIGRvbid0IHNlZSBhbnkgY29tcGxhaW50cyBm
cm9tIFJvYidzIGJvdCwgc28gSSBhbQ0KPiBhc3N1bWluZyB0aGF0IHRoaXMgYWN0dWFsbHkgd29y
a3MgYW5kIHRoZSBlcnJvciB5b3UgbWVudGlvbmVkIGluIHRoZQ0KPiBwcmV2aW91c2x5IHZlcnNp
b24gaGFzIGJlZW4gcmVzb2x2ZWQ/DQoNCnllcywgaXQgaXMgcmVzb2x2ZWQuDQoNCkkgdXNlZCB0
aGUgUkZDIHByZWZpeCBiZWNhdXNlIE5laWwgcmVxdWVzdGVkIGl0Og0KKiJKdXN0IHNlbmQgYSB2
MiBhcyBSRkMsIHNvIHdlIGNhbiBjb21tZW50IG9uIGl0LiIqDQoNCj4gDQo+PiAtLS0NCj4+ICAg
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tbWMtc2xvdC55YW1sIHwgMSAt
DQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbW1jLXNsb3QueWFtbCBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbW1jLXNsb3QueWFtbA0KPj4gaW5k
ZXggMWYwNjY3ODI4MDYzLi5jYTNkMDExNGJmYzYgMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL21tYy1zbG90LnlhbWwNCj4+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbW1jLXNsb3QueWFtbA0KPj4gQEAgLTI5
LDcgKzI5LDYgQEAgcHJvcGVydGllczoNCj4+ICAgICAgIG1heEl0ZW1zOiAxDQo+PiAgIA0KPj4g
ICByZXF1aXJlZDoNCj4+IC0gIC0gY29tcGF0aWJsZQ0KPj4gICAgIC0gcmVnDQo+PiAgIA0KPj4g
ICB1bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQo+Pg0KPj4gLS0tDQo+PiBiYXNlLWNvbW1p
dDogNDBiOGU5M2UxN2JmZjRhNGUwY2MxMjllMDRmOWZkZjVkYWE1Mzk3ZQ0KPj4gY2hhbmdlLWlk
OiAyMDI0MTIxOS1tbWMtc2xvdC0wNTc0ODg5ZGFlYTMNCj4+DQo+PiBCZXN0IHJlZ2FyZHMsDQo+
PiAtLSANCj4+IERoYXJtYSBCYWxhc3ViaXJhbWFuaTxkaGFybWEuYkBtaWNyb2NoaXAuY29tPg0K
Pj4NCg0KDQotLSANCldpdGggQmVzdCBSZWdhcmRzLA0KRGhhcm1hIEIuDQo=
