Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.86
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794476707;
	b=ZyY/aYecsTBBY9aLtYQqr3maqU4xhlaTq/9DlswoFIl5MNmGszUMzwleGpedGX2LHjxa
	 GSdS+SK8zzvba3WtwWDX47v3y1CwAM8NsnhDlr/60Xwp8bvFBNNsR54grFtHgTBOKlI06
	 vKaNKqWAU+/D7UBktjZ2UAL3FrBfV9IFFoFp+4yjqekBsPwKkAriQGhlpx7EHAQFl1fRo
	 kEspk/4yQlh68YoNuNKYl8SXtNUul39zCYNB2Mrh6ZjDkCXsjA9Hm6fMYegXCX7aJSkOA
	 TBXJU/3M3M8+8qpre51znf9ISp9lKS+JaCkMTO2X3Y4wGebPPRvZmzO017eMjv9J6+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476707;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=xJf86uga8LX6kAsqEqoWI3o9dyaw3uhtLJsEJED/5nY=;
	b=vNis+vwDglCdTydLy3GC7HlwCaLzh3hF70chyr7/W/p+GwnZqKLCYHmkqZb+xIkJxE2Z
	 YNHoVros2A+FCx27th5bXR1zYj/JqutcjdDBZlTgr1p7An61aBa4z5QKhdJUfOiZ0p7o9
	 vFbf5X9qFQ1coXJIaHNwzJ50e6hxFEPG3Kozkak1RbPHktI0pCIyjsneVJZQ1pf1vUAx9
	 eR26SfIlAY2R/h2+BlqBvuErSIl8ZHH0tvj3kjgtV1WouNpYjmS0bektEZ0yB9DUY7LiD
	 FNlBTBnnTeo37UHF+rEAuyPfBuu7BBGT62SFYwz+C9aZoqJfseIjjXqE44A0iRQ8tJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lenze.com;
	spf=pass smtp.mailfrom=lenze.com;
	dkim=pass header.d=lenze.com header.i=@lenze.com header.a=rsa-sha256 header.s=selector1 header.b=Kv9PNiH9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.86
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021086.outbound.protection.outlook.com [40.107.130.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2810E606A31C;
	Thu, 12 Nov 2026 09:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2810E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lenze.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lenze.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lenze.com header.i=@lenze.com header.a=rsa-sha256 header.s=selector1 header.b=Kv9PNiH9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYG6T+8zo2SIqmcQ8v3ovNiUHhQyFwnqrbaTledc0OphjjSDbPJF5eB3ETAV5a7f8zfCsz14I5SmcPu4k/SBf4ZV84jcZMof/3hng7yNRCc2heYKNoKloinwXcrAla4TXW2T0AKkHdGam25m+olb0uTzMhrwSxEkOspuDE4lTglHuz5BRU7+i86hifygsklTSVkWbUxahsovpxK6QtsklL+8FJ7R6tbIssqURqIsI+RVRLw3MlvCXe3iDK1Iu9RBM0rB/zE+n+w9m8vtKkQhxJiUr4ded9c9YqvC3y6pZbYMEVssmoxhJkTTSklvdYEJrb7hodqjJHmGTr1hCgloYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJf86uga8LX6kAsqEqoWI3o9dyaw3uhtLJsEJED/5nY=;
 b=JI1buZJgU4nfLVgw05NN1KF/bi9DDo+2K3OrJevp2rvcbyCDGSaR3FRHSOpaU7TZ0VO0pXIIZrxj29L7igHpInlaPMAHhUI4+lIk9Yxb2zMHYxJjEIKIJqkMZRGoH8Dfosvd5o8noiaHRTkati/g6f/BMQ+FOu4G4uGqSs5Wi3NmigJdhspzgfnltQdNZqllXbedkGSBQ16lYVISJDuJKl1ucEfV8zAA2yDN9BWkOgHba+auHGtvfSDZyhKDOQE8ojztnd0qt2Znizq5W/4wlBRL+eqlY6HJjDjbQx+jYYL9Mjv8WGv7PF1LQeZzZehsHKuQv2V/HUeNkYzhY/y3qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenze.com; dmarc=pass action=none header.from=lenze.com;
 dkim=pass header.d=lenze.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenze.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJf86uga8LX6kAsqEqoWI3o9dyaw3uhtLJsEJED/5nY=;
 b=Kv9PNiH9qBC7yM+K3x/4VkTqaAQLLhifFkf7nxM9L9WyR4iFibhHnUMldn8IcFrGhp6m4O8dYzepYWZuarhjiZRKnljtNN8zubCdtOTEbeGt/9zfnOjhtqN9yt70DSvbpMkfbyzrWf3jS5U4nBcJhEz0hKhYWddF9Vd/BBQp6kT7XB6VNnviBAHy4hQc4Ji6gsxidC6+Iwhcw3FwBVOGQ9RyeiuxKl02kIbVEp8SJxR5Uv4vp5lyHzhW802uIAnt+41RzoadQx7JO7rlP2h/05PGssJny0Wl1vrwsrb84NIALZeLiJeVJflVQ1g4FRSZRk5kUngprzpSzB0MJzChnw==
Received: from ZR6P194MB918907.EURP194.PROD.OUTLOOK.COM (2603:10a6:910:da::23)
 by AM8P194MB1628.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:36f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 09:45:01 +0000
Received: from ZR6P194MB918907.EURP194.PROD.OUTLOOK.COM
 ([fe80::9250:9858:e034:cd34]) by ZR6P194MB918907.EURP194.PROD.OUTLOOK.COM
 ([fe80::9250:9858:e034:cd34%6]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 09:45:01 +0000
From: "Brandt, Oliver - Lenze" <Oliver.Brandt@lenze.com>
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC: "ulfh@kernel.org" <ulfh@kernel.org>, "jh80.chung@samsung.com"
	<jh80.chung@samsung.com>, "shawn.lin@rock-chips.com"
	<shawn.lin@rock-chips.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mmc: dw_mmc-pltfm: Fix usage of phase_map for SoCFPGA
Thread-Topic: [PATCH v2] mmc: dw_mmc-pltfm: Fix usage of phase_map for SoCFPGA
Thread-Index: AQHdcop8Kq3NbDgfOE6cAIDLsGKrMQ==
Date: Thu, 12 Nov 2026 09:45:01 +0000
Message-ID: <140317dff0feb9d62b580b1e3170ccb10b8af181.camel@lenze.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2-0+deb13u1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lenze.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR6P194MB918907:EE_|AM8P194MB1628:EE_
x-ms-office365-filtering-correlation-id: b5dc9114-391b-43bb-e6c9-08df40a19efb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|10067099003|11063799006|56012099006|261022105027099003|261022075727099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261102123227099003|261102130727099003|261009223027099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 2FlHFzwotTFMTAq336bbtLd+WLGVun2jtiV+r1RNKQzs1B36mE78rKx09613w4Gk7BOivNXGW3ouKKIXL4EFdurr80PCEIKm4jv33S/DVShkl0qgj8BLoL4STarjZUwPDQZOYfUAsxwiJb8ZZ7txGLhrhOKO4iHIuZHxiF/U8f7m/xev/wvkjQCfvWC/b3MOxRAAEF3RCN+hKydrbQgX5XQk8NMQHSBLui4A7eNewBgbbKIAdK2fwYs3wvxb7RUkzAAzbfO2p3w5iW07lqGCQ3I+L3R0oLcFUkuCJYtb5Nb/q/PHgANIB261Ir+lPK/CjihEdowcU8wbHkvWnjrhBveCH7lSsoRlCpay3VY99mXRXpvGi3/u0yxsBPOZbwZ0SA8NNbmq/ZF+T+QEJ2pml5rHGQG6J/PQ1/LcI/H89YRIwDiG+qgTUQv0QgWR4xvrdXQVWQkHzk3RrL6NAeOj/wz5O9c9S7r7XyyUMAnWxIajcO65LKw9byzuVznRuvfj8+OjiDVX4PQTcQ/2NtLSQMQDCWCLZq7RGH3JGAkFu6f7/FSnCLeUihlN56/CrufV/pAFSIQdn82rlqFmOV5waZV3MyqAwqL/MjthF3jihqeXcuU/Zywb0KG83iilFi0dI3pSABwy61GZkz1VkJFv6yf9CtB5sWCk1g7SitLGMPQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR6P194MB918907.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(10067099003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261102123227099003)(261102130727099003)(261009223027099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTdMZnZTbGJsZzFlRG1lcVA2UlR1M0xJckNFNTJpTFl2b0VQSE1LOUtjdlJG?=
 =?utf-8?B?SE4yTHlyZzUwbk9FV2VYR0plVndMR2tXbFA4bVF2bWk1QUtwU1ZyczBIVWh3?=
 =?utf-8?B?Zm9iaUQ2eVlxb0U4OHBJQndrMW1NREhtL0FIVTQ0b00xTjJwL0grZ0Fjdlhp?=
 =?utf-8?B?QTNMR0lCeHdRZWNUYkVWSTJSMG0zRVRwck5OOTZtQ0xFbm4xUXdqY25nMko1?=
 =?utf-8?B?WXZuNWxmSE5yRUhDNU1mVzFyMHIzY3AzR0FMc2oxaDlEbytseDY3UTBKUU9p?=
 =?utf-8?B?QVhpZTRoY2xUbkhaNy9JRHNhalZXb1hkVnAyeW84VnE1SUZXcC9TV2hlWXo2?=
 =?utf-8?B?OW1ieUEyZUxNNDFxc2pJR2E4SkV6cHlVWWl6R1VUZlpXVXMvTitUcnJyWmhS?=
 =?utf-8?B?QitDNW9DOGNydlM5RndycVRPaE1WczFneTJPYTNNQlpjU1IxcGJycTMvNWNY?=
 =?utf-8?B?VXl1dTR2ZUVGZlVFQ0JtamhhWGFRcnN1QlBzZjh2cWNwWXR3SGpWUGEyY0N3?=
 =?utf-8?B?aGFHM0RLYXZZeElrSnhxdnBHdFFGaXlwaHVSbEJ1cUIvazdkY0w4eklYNVpL?=
 =?utf-8?B?ZktyaE9HQkErVFpZcWxWTi9TOUtpSTVPbkgwS2pzc1RDVklFZWZBMEhkUW5x?=
 =?utf-8?B?ZDFiWW00RmE1WHJ1R3JLNmN2eHI5UWVDZWpseExTdFNMa2k5UE1LNDdHT21N?=
 =?utf-8?B?NjVObzZOaC9JTmpJSzdkMFVNL04rR0xUeWRWNklYTXA3VjVIS0Z5MzlLdlBj?=
 =?utf-8?B?Rk5DUFRVeEgzWkdVd1lma1N2SlJ3akpzcmVublgwUE9TMHFNcmR5elY1ZlYv?=
 =?utf-8?B?MjNYdlk5ZU1VeGwxbzFvTU1rMVpLTGRoZ3FlS3dwTWZ3Wnp5aFkvZ3dCNTl0?=
 =?utf-8?B?S256WWtvdUxwS2hSTmV3bDREUXN4Wm9McmtscjN4dUtEa2I5LzNsaHNKNnU3?=
 =?utf-8?B?aVE1NUxkNTlSRmd2eUtoOCtBREtZZGRnbkRBak9rUjM5bi9qaTUwWHdBMkxi?=
 =?utf-8?B?R1pWNStqVGZyN3dhbU1LeTc4MEVUaG00cWFHYjRncWZuL0orUVg3bzhPWCtV?=
 =?utf-8?B?RXQwLzBHM2NrRmRzd2hYNmpJK20vRlpjbWpoYUN2OG1HZDVyR1RrTElFWURp?=
 =?utf-8?B?ZE9CYUpNSjNzN210N2Q4V0pyb1JGSEdjUXN0WGJ1Y3U0STYvT3JDb3ZnVzBM?=
 =?utf-8?B?TGlSeFFNcTIvNkMvWjYybjc3OFJPR3pkRVFVMng5U2xQSmNHdDdzc3Y5SnBT?=
 =?utf-8?B?MTBUUGdPMU96dTU1OWVCaUJ6TjM2ZzBoeVhIc3FMLzRMKzFjcFFPMkxzQk1F?=
 =?utf-8?B?aEtPYnZFazM5MlhmMFVvYTA3eWlYQ09GOVIyaUlwMGZ3ZE9SaXVXVmxhVm42?=
 =?utf-8?B?UndVSzRQc080Q25jeG1GZnlkMEFQdVcvRDdSbk15UUVLTmJnWXVRK1ZOdmxH?=
 =?utf-8?B?LzJwVjRjRFEyTmszQnB4bWRBZlFFeGY5OWlZd3FuTHE2SDFBU2RvTmc2azhP?=
 =?utf-8?B?bjhzRmZLZm0xaXF4QjZVWGlmMDNPU3cxSCtDSmRuNDR6KzRka2lQbGZhZkRM?=
 =?utf-8?B?SkQ3dXRxYXlYUzZSeUZQMG9obk4rVDM0NVZBU1d4Qkl0ZGlIM3N0UldSWDc5?=
 =?utf-8?B?aitHZnovaDRXd1FZMjAwN0huTExsSm9MYUtSK3g2TGQ5UXp1VTdUY3c0d3dI?=
 =?utf-8?B?MHJIc0Exd0xoc1lQSjBldStkNzh5K2dWSk1nbE9vcThZZ0JLbW9VSVRtS3pU?=
 =?utf-8?B?YWhjWXROMGwzZ25hQkxkaWdOdHo0Y0VrbklMZVZ5ekxyQ2lUaTE0NE1mTERD?=
 =?utf-8?B?d002OWl0d2tZTDUxQy93TURoOE1YeXJvUUcwZkVUcUczaE82b0JFeFNiVWR0?=
 =?utf-8?B?bFVYNW9LUTFTS0V4QVI4eUtQbm1uVU5SNWxwN2FnTkcvU2ZueFFvUkJDU1RD?=
 =?utf-8?B?MTNlQ3lUK0tUNVhGTTVNcjYwV3ZTL2ZpdmtMQi9FWTZlcHpTVk1ZTzVhU2RB?=
 =?utf-8?B?Qm41VTdES2JhbXdmTk54MGF5V3dycWJOQWI5NUY0NUYzRmVmZzVERjNqcTJO?=
 =?utf-8?B?MlR5NEdHdkpzZGloREtTckUwSzljWWdFTG02YmNpelZHWnJSN2g0MWV3akFr?=
 =?utf-8?B?S21KbXIwNnVzeWdHOWRFSnVJdnVnZEtWbDlHQkhWa1RyYkJUbWJ0ZnpyQ0Vw?=
 =?utf-8?B?bXc4Ymt3MEFUbjA5TkdLQm15TnlObktEYkRNcUh2VVYxT1VFUmRMZDhZNUJN?=
 =?utf-8?B?Y3QrcEZKQzRrTWZ4bURxdDhmODM5QkVHYUswb2xtOTJ3Nkp1azYvQXVkeGFW?=
 =?utf-8?Q?AIOq94XhbHPzjAY3um?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79EA681AD06454428869715DF226F9B3@EURP194.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: lenze.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR6P194MB918907.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b5dc9114-391b-43bb-e6c9-08df40a19efb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 09:45:01.0590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 37cf0ce8-ac09-4e7d-9ff2-f1da44914b3e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1b46R2F+uREyUZg7ZKJCgnRd1niXwPsKKAc88ZGMzQuB1WJCEMOBfro6+l4LA/CUoVBVBE/41+Wn+4JCbf53ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P194MB1628

V2l0aCBhIGtlcm5lbCA3LjMuMyB3ZSBzYXcgdGhlIGZvbGxvd2luZyBvbiBhIFNvQ0ZQR0EgKEN5
Y2xvbmUgNSkgYmFzZWQKYm9hcmQgZHVyaW5nIGluaXRpYWxpemF0aW9uIHdoZW4gdXNpbmcgYSBo
aWdoLXNwZWVkIFNELWNhcmQ6CgogIGR3X21tYyBmZjcwNDAwMC5tbWM6IERXIE1NQyBjb250cm9s
bGVyIGF0IGlycSA1MywzMiBiaXQgaG9zdCBkYXRhIHdpZHRoLDEwMjQgZGVlcCBmaWZvCiAgZHdf
bW1jIGZmNzA0MDAwLm1tYzogR290IENEIEdQSU8KICBkd19tbWMgZmY3MDQwMDAubW1jOiBHb3Qg
V1AgR1BJTwogIG1tY19ob3N0IG1tYzA6IEJ1cyBzcGVlZCA9IDUwMDAwMDAwSHogKHJlcSA0MDAw
MDBIeiwgYWN0dWFsIDM5NjgyNUhaIGRpdiA9IDYzKQogIG1tY19ob3N0IG1tYzA6IEJ1cyBzcGVl
ZCA9IDUwMDAwMDAwSHogKHJlcSA1MDAwMDAwMEh6LCBhY3R1YWwgNTAwMDAwMDBIWiBkaXYgPSAw
KQogIG1tYzA6IGVycm9yIC0xMTAgd2hpbHN0IGluaXRpYWxpc2luZyBTRCBjYXJkCiAgbW1jX2hv
c3QgbW1jMDogQnVzIHNwZWVkID0gNTAwMDAwMDBIeiAocmVxIDMwMDAwMEh6LCBhY3R1YWwgMjk3
NjE5SFogZGl2ID0gODQpCiAgbW1jX2hvc3QgbW1jMDogQnVzIHNwZWVkID0gNTAwMDAwMDBIeiAo
cmVxIDUwMDAwMDAwSHosIGFjdHVhbCA1MDAwMDAwMEhaIGRpdiA9IDApCiAgbW1jMDogZXJyb3Ig
LTExMCB3aGlsc3QgaW5pdGlhbGlzaW5nIFNEIGNhcmQKICBtbWNfaG9zdCBtbWMwOiBCdXMgc3Bl
ZWQgPSA1MDAwMDAwMEh6IChyZXEgMjAwMDAwSHosIGFjdHVhbCAyMDAwMDBIWiBkaXYgPSAxMjUp
CiAgbW1jX2hvc3QgbW1jMDogQnVzIHNwZWVkID0gNTAwMDAwMDBIeiAocmVxIDUwMDAwMDAwSHos
IGFjdHVhbCA1MDAwMDAwMEhaIGRpdiA9IDApCiAgbW1jMDogZXJyb3IgLTExMCB3aGlsc3QgaW5p
dGlhbGlzaW5nIFNEIGNhcmQKICBtbWNfaG9zdCBtbWMwOiBCdXMgc3BlZWQgPSA1MDAwMDAwMEh6
IChyZXEgMTAwMDAwSHosIGFjdHVhbCAxMDAwMDBIWiBkaXYgPSAyNTApCiAgbW1jX2hvc3QgbW1j
MDogQnVzIHNwZWVkID0gNTAwMDAwMDBIeiAocmVxIDUwMDAwMDAwSHosIGFjdHVhbCA1MDAwMDAw
MEhaIGRpdiA9IDApCiAgbW1jMDogZXJyb3IgLTExMCB3aGlsc3QgaW5pdGlhbGlzaW5nIFNEIGNh
cmQKClRoZSBTRC1jYXJkIHdhcyBub3QgdXNhYmxlIGluIHRoZSBmb2xsb3dpbmcuCgpSZWFzb246
IFNpbmNlIGNvbW1pdCAzZjE2MjhiYWE1MWUgKCJtbWM6IGR3X21tYy1wbHRmbTogVXNlIHBoYXNl
X21hcCBmb3IKU29DRlBHQSBjbG9jayBwaGFzZSBjb25maWd1cmF0aW9uIikgaG9zdC0+cGhhc2Vf
bWFwIGlzIHVzZWQgaW4gb3JkZXIgdG8KZ2V0IHRoZSBwaGFzZSBzZXR0aW5ncyBmb3IgTU1DX1RJ
TUlOR19TRF9IUy4gVGhpcyBpcyBkb25lIGluIGRydl9kYXRhLT5pbml0Cihkd19tY2lfc29jZnBn
YV9wcml2X2luaXQoKSkgd2hpY2ggaXMgY2FsbGVkIGJlZm9yZSBkd19tY2lfaW5pdF9ob3N0KCku
IEFzCmhvc3QtPnBoYXNlX21hcCB3aWxsIGJlIGluaXRpYWxpemVkIG9ubHkgZHVyaW5nIGR3X21j
aV9pbml0X2hvc3QoKSwgd2UnbGwKY2FsbCBkd19tY2lfc29jZnBnYV9wcml2X2luaXQoKSB3aXRo
b3V0IHRoZSBuZWVkZWQgZGF0YS4KCkRvIGl0IGxpa2Ugb3RoZXIgdXNlcnMgb2YgZHdfbWNpX3Bs
YXRmb20gYW5kIHVzZSBkcnZfZGF0YS0+c2V0X2lvcy4KCkZpeGVzOiAzZjE2MjhiYWE1MWUgKCJt
bWM6IGR3X21tYy1wbHRmbTogVXNlIHBoYXNlX21hcCBmb3IgU29DRlBHQSBjbG9jayBwaGFzZSBj
b25maWd1cmF0aW9uIikKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTog
T2xpdmVyIEJyYW5kdCA8b2xpdmVyLmJyYW5kdEBsZW56ZS5jb20+Ci0tLQpDaGFuZ2VzIGluIHYy
OgotIEFkZCAncmV0dXJuJyBpbiBjYXNlIG9mIG1pc3NpbmcgcmVnbWFwIChTYXNoaWtvIEFJKS4K
LSBBdm9pZCByZXBlYXRlZCBleGVjdXRpb24gKFNhc2hpa28gQUkpLgotIFdyaXRlIHJlZ2lzdGVy
ICdoc190aW1pbmcnIGV2ZW4gaWYgTU1DX1RJTUlOR19TRF9IUyBpcyBub3QgcmVxdWVzdGVkCiAg
KFNhc2hpa28gQUkpLgotIExpbmsgdG8gdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LW1tYy8yYTAzYTIyMmM0YTlkMzMwZWJjNzE1N2RlMDllYzMzZjcyODc1ZjI4LmNhbWVsQGxlbnpl
LmNvbS9ULyN1CgogZHJpdmVycy9tbWMvaG9zdC9kd19tbWMtcGx0Zm0uYyB8IDE0ICsrKysrKyst
LS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvZHdfbW1jLXBsdGZtLmMgYi9kcml2ZXJzL21t
Yy9ob3N0L2R3X21tYy1wbHRmbS5jCmluZGV4IGNmMzhiYjExOGRjMmMuLmI1MTU3NGEwYTFmZTEg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvZHdfbW1jLXBsdGZtLmMKKysrIGIvZHJpdmVy
cy9tbWMvaG9zdC9kd19tbWMtcGx0Zm0uYwpAQCAtNTYsMjIgKzU2LDIzIEBAIGludCBkd19tY2lf
cGx0Zm1fcmVnaXN0ZXIoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwKIH0KIEVYUE9SVF9T
WU1CT0xfR1BMKGR3X21jaV9wbHRmbV9yZWdpc3Rlcik7CiAKLXN0YXRpYyBpbnQgZHdfbWNpX3Nv
Y2ZwZ2FfcHJpdl9pbml0KHN0cnVjdCBkd19tY2kgKmhvc3QpCitzdGF0aWMgdm9pZCBkd19tY2lf
c29jZnBnYV9wcml2X3NldF9pb3Moc3RydWN0IGR3X21jaSAqaG9zdCwgc3RydWN0IG1tY19pb3Mg
KmlvcykKIHsKIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gaG9zdC0+ZGV2LT5vZl9ub2RlOwog
CXN0cnVjdCBtbWNfY2xrX3BoYXNlIHBoYXNlOwogCXN0cnVjdCByZWdtYXAgKnN5c19tZ3JfYmFz
ZV9hZGRyOwogCXUzMiByZWdfb2Zmc2V0LCByZWdfc2hpZnQ7CiAJaW50IGhzX3RpbWluZzsKKwlz
dGF0aWMgaW50IHBoYXNlX2FscmVhZHlfc2V0OwogCiAJcGhhc2UgPSBob3N0LT5waGFzZV9tYXAu
cGhhc2VbTU1DX1RJTUlOR19TRF9IU107Ci0JaWYgKCFwaGFzZS52YWxpZCkKLQkJcmV0dXJuIDA7
CisJaWYgKCFwaGFzZS52YWxpZCB8fCBwaGFzZV9hbHJlYWR5X3NldCkKKwkJcmV0dXJuOwogCiAJ
c3lzX21ncl9iYXNlX2FkZHIgPSBhbHRyX3N5c21ncl9yZWdtYXBfbG9va3VwX2J5X3BoYW5kbGUo
bnAsICJhbHRyLHN5c21nci1zeXNjb24iKTsKIAlpZiAoSVNfRVJSKHN5c19tZ3JfYmFzZV9hZGRy
KSkgewogCQlkZXZfd2Fybihob3N0LT5kZXYsICJjbGstcGhhc2Utc2QtaHMgd2FzIHNwZWNpZmll
ZCwgYnV0IGZhaWxlZCB0byBmaW5kIGFsdHIsc3lzLW1nciByZWdtYXAhXG4iKTsKLQkJcmV0dXJu
IDA7CisJCXJldHVybjsKIAl9CiAKIAlvZl9wcm9wZXJ0eV9yZWFkX3UzMl9pbmRleChucCwgImFs
dHIsc3lzbWdyLXN5c2NvbiIsIDEsICZyZWdfb2Zmc2V0KTsKQEAgLTgyLDEyICs4MywxMSBAQCBz
dGF0aWMgaW50IGR3X21jaV9zb2NmcGdhX3ByaXZfaW5pdChzdHJ1Y3QgZHdfbWNpICpob3N0KQog
CiAJaHNfdGltaW5nID0gU1lTTUdSX1NETU1DX0NUUkxfU0VUKHBoYXNlLmluX2RlZywgcGhhc2Uu
b3V0X2RlZywgcmVnX3NoaWZ0KTsKIAlyZWdtYXBfd3JpdGUoc3lzX21ncl9iYXNlX2FkZHIsIHJl
Z19vZmZzZXQsIGhzX3RpbWluZyk7Ci0KLQlyZXR1cm4gMDsKKwlwaGFzZV9hbHJlYWR5X3NldCA9
IDE7CiB9CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZHdfbWNpX2Rydl9kYXRhIHNvY2ZwZ2FfZHJ2
X2RhdGEgPSB7Ci0JLmluaXQJCT0gZHdfbWNpX3NvY2ZwZ2FfcHJpdl9pbml0LAorCS5zZXRfaW9z
CT0gZHdfbWNpX3NvY2ZwZ2FfcHJpdl9zZXRfaW9zLAogfTsKIAogc3RhdGljIGNvbnN0IHN0cnVj
dCBvZl9kZXZpY2VfaWQgZHdfbWNpX3BsdGZtX21hdGNoW10gPSB7Ci0tIAoyLjQ3LjMKCg==
