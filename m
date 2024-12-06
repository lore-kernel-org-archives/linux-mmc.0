Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCD812FB0A;
	Fri,  6 Dec 2024 05:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733462205; cv=fail; b=NbkjP7lq08R/scEJiv93HzUrxvwaqUSWqOAD7a9P4WVkZ/7VGtY5lcnPzIbCe3wGUfcoc7uVUEIkvuxqZowt2zPL26vZ/BfU7oF2QS8oa6wlvsKq/knIr6Wcmgmj8mgYgekhf0U5t90DmAA6yGsPEfRBT0FP0Y32lBEqGP6cRiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733462205; c=relaxed/simple;
	bh=BnJqqHOJeeTywx1ywewvrauswA3oZLe9I7APX++pr8s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LHMVd+JSwzeDxkU7JzHeRH2qH0QlE7zZeGqNdiQVvDHexXbccHppwMPQc3miJSVn5ukScCIaDcLUOZ7H9CK7cA3+GBW2/psrMFtk6aJYlDhsI1gZTDaqML0sa5uvZ8vujZtuZ04M+Xn5IhGVMnp4sZLZ8d8pzPYZhfnNslZEcBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zReV3Q1R; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zReV3Q1R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUF7zo5NNEpY5RfpIYVT3PS/qmU9O4+6otqKIGYbBTpvWboi+rT+ytPMXoMBco7Klph981/Z1lAWKuxgPD3hWNEAOPT+6tXFn3LsPF+FJ1R/J9QPyEMJRK14UrNzTt1ljoi9SSxkits7UWKfKmjE09MxsesM7ONSERaQJ6iaibpGWesXOmDA8y01+C7DEnzc1HLD1Ub7VAMD8nfiEehW4I1P6I/W7UhZ0Ecc8ChCThelt9SwzjtjgKAh+5UL7qzosQggA6qYgDrc3fkP+4OjMXDOxpFpkyUvYiFi8nvkPA/aOgE9iTfyo/5VoVJbzQhUJkGWn3Re8e6bzcvakVhVNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnJqqHOJeeTywx1ywewvrauswA3oZLe9I7APX++pr8s=;
 b=H/MTBl2aZQ3KpZBjVwweozVMDCJZOZFcifK5SUTCk4VW8CKEDjzzok+s9KJ8NehF+Hbh+sCGjzJsUuECtmSyBVRCfPHZT3tSB9xbFGP+00Y8kxwCtQCc4lM5RE5KfvKTVDOpODDQd6sMo5DALH/wnqqYndXctlngzJ0nik19iLrHAxxzHd9LBM/wLWvmcaBlm8ZgJbzanu42qxC/vUnZff+gk7De+35yisRwEtpdliz5nfWdPYIGhuPX+4aXfiysw25YVE+lvW6IQmtI0aUroyk+mm2H6caJA0dwI7OOgD4pCzlQoXpn5OXRjxBVDxxeMGSDhN/0L276OZGRvih0wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnJqqHOJeeTywx1ywewvrauswA3oZLe9I7APX++pr8s=;
 b=zReV3Q1R3O+JFM+g7WSv5pTM70vjute7LVGI51iI8o6DcrxrZ0uTXicETwvjdgTnD4GcfL/yjZHIr7H6mxmjwxk1hlsj8KYh5Uy2IiTo/jII+9fIvlc2nMvsW6BlOGlSWgyAeZS60Uu44xSNe2PMfeIY5Pk5uKQf3D0opQzYj8Og7xFLX5ni1Kd6fl15UWuu0CHdiwuohsGMc6J5K+5db+xH2j/VbJdxR9QWI3mYGz5MWVNRF6CrY08miiJTJbhHCJZPOtdOmrzS+WY0pcnTN7ria7tS3f9IfZlODUJDIiVJ1AKmUna7CKTvBuxlVGk625wPn/Fgqoa1aEgEPkYNjA==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by DS0PR11MB7787.namprd11.prod.outlook.com (2603:10b6:8:de::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.23; Fri, 6 Dec
 2024 05:16:39 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%4]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 05:16:39 +0000
From: <Dharma.B@microchip.com>
To: <conor@kernel.org>
CC: <ulf.hansson@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<Aubin.Constans@microchip.com>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: mmc: atmel,hsmci: Convert to json schema
Thread-Topic: [PATCH] dt-bindings: mmc: atmel,hsmci: Convert to json schema
Thread-Index: AQHbRvwf3qgInoB0eU2XMIzej7Xo6rLX7RUAgADA/oA=
Date: Fri, 6 Dec 2024 05:16:39 +0000
Message-ID: <4e3a4154-9e05-40b4-961f-6d7e95ec0890@microchip.com>
References: <20241205-hsmci-v1-1-5a25e622dfed@microchip.com>
 <20241205-trickster-rebate-d5e64bc29992@spud>
In-Reply-To: <20241205-trickster-rebate-d5e64bc29992@spud>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|DS0PR11MB7787:EE_
x-ms-office365-filtering-correlation-id: 1a6053d7-f08d-4007-6421-08dd15b529e1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y05aL3llb0RiTFRWaVRNR09xN3h5WHAzTkZ3M0lacndGOFpKRm55L3QyQmU1?=
 =?utf-8?B?UVE3MmFMa1JiWlFjYm5mUHI1WVNSM0dkUGI2VVhHdDd6WEEzMTd2V3d0TStU?=
 =?utf-8?B?Y0czUVoxa2x5bmVtUHVVM3pDUFk3dHpQTzhjbFpLVmM2aUNmcmhpb3pXZVh1?=
 =?utf-8?B?THZ4N200SWl2Yzg0SGc4Wno2TC96NkRlSVNkeHRWbWpKWXZzeDlFZlRwcU4y?=
 =?utf-8?B?VEFONVRRMkcybjl6bk50SWtuZ3JKbjcxYm1neHd0c2pmZWRTa3BXaVN5STdh?=
 =?utf-8?B?UzBqVm13cWZhL3NhYkJXR1YxWVVTSGsyZGdJdGFsb3dwVHhRV1lLdE9PUnZk?=
 =?utf-8?B?ZDZDZXUwb1U3UW0xZ1BVTlRGMHhnQkg5WjZKa1BmcElFVEYrcy9tOUxCWHpW?=
 =?utf-8?B?d1lYSjZHSkcrVVhrUFAyS1ZubkRqaXNBNDJ5TmV6dHgzWlpRaUxpYUFFZUts?=
 =?utf-8?B?YWVsM0tPK0hEVUFZaU9WOUd2VzZjL0s0dGorVWE1c3FyYTU2ZVQ3MkI2amZq?=
 =?utf-8?B?RjlObjJydk8wOGVYdGtvd3VFQ243Z3ZZeWlMQjZkaFdVcVBKUDJwaGF2RlB3?=
 =?utf-8?B?MVpYR2NpbEtVTUQwOFB5Y2p0emVXNDFBYmFaMXlZSm02UUh1cFV0VlAyVDVr?=
 =?utf-8?B?VUJSR0N3YVI3UEwwbDYrR0o5NnBqdW9yQUNTUUpwVVFrck1XSTkwMnFoelFr?=
 =?utf-8?B?WHZjSUFMZ1NjbWh4eExjODc4T3BDc0hUalNCRHRkM2JxNUpBS3Bpdjh2dkJS?=
 =?utf-8?B?UHQ3ZE1ZYTFiT1YzRUx6eVprQ29vMzlsVEEvbUJHUWxuUEoyTzhialB4NTBL?=
 =?utf-8?B?RDVQaEdvUXZtejFQNEJzTHpiblVIN2xodDk3TXdOMWQzcUJWL2VKa1FnaURu?=
 =?utf-8?B?ejVDdXFLVS8zVkZqZ3dteWtSTk1xK2tWWUp3RVZsdjVQbTEyVlhvMEowRHh4?=
 =?utf-8?B?L05DaDduRE1ZRk1TUjFkajhRYytMdE9EYmVsYlFEbk9UZ2NFeHZ2dTU5Zlc1?=
 =?utf-8?B?b2ZGWXJJcWRDcncxbW8zN0lPaGwvTDNFMzV3RUxGNzlFcnBLK2dCOTYyZDN0?=
 =?utf-8?B?ZjBOUGJYL3c2TGU2NzJudzBIL1FKREVRa3hrSUxka1p6VE9HK2RqdUhvQXNY?=
 =?utf-8?B?U2hPRlNYU0YwbHNHQUJmb3MrQmovbGtDNUZZUmorbkw0MWdibmhIVDdJbUlk?=
 =?utf-8?B?TFl5RG0ybi9Uc2FVdVMzanB0ZG9wVVlBVklhVXA2aVNKL0dOdGdsczJ0Qjdp?=
 =?utf-8?B?alRQaXpyQmdoMlFiSzhyRXJZOGhrMGdpOG1KRFZaY1daNjVueHpmSm9KU1Fy?=
 =?utf-8?B?Q2hrNDE1b0VTeGpreDZGYUI1emZKeVJ0Nk9ReUdOT3BwbG1iUWlEWTkvNm1S?=
 =?utf-8?B?QkoycG45SVI3Ym1MWXlhbUQxSHhvMjJEblU2amRIZlJBUHl6a1lvUXJiTEVa?=
 =?utf-8?B?VmluSXQ5M3JEbFJNTEZUTDF4TkRqdWMvNXBVYmFyVE11UWxkWFdUUGllTmpH?=
 =?utf-8?B?QVlQVE5ISXk3V1lsSTI2T2tRZ1hkR2IwbWpQNkVublpmMHdiR2ZKSnFxZDli?=
 =?utf-8?B?R3ZvOHpoRVpWRmd3WkFtOWhtSWF3R2M1bGlsQ1RXQzNYaytxVjBxcmdrRit6?=
 =?utf-8?B?VDF5T0xTelZQRDY5VXRxRnVneEFIVC82b002U21Gcm5rVmVLVnViVzJBUjkr?=
 =?utf-8?B?R0NEZXZIOFY1U3FCbEJnWUwvU0Y2c1ZOYkhxZVBOZUR1UXVSekdabWpJd1Q4?=
 =?utf-8?B?ODR3VnlSVVYreVRtUmY2a2NDc1MreEFsQzk0NWdKRG1hdmRZZmFrQlp0cVor?=
 =?utf-8?B?dHdzK0ppR29JSWRtTkljRWdORStEVEtva3pPZm1Lc2hxL29MNU5jU1F2M0FI?=
 =?utf-8?B?OFoyenBRNnlpZEFieUo5ZnZwRWJHUDNCWjJZbGU1MFRXTWc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NzZHRHlFV01zbHZGNG9IVHFremo3Y2tRVGdzbGRrZUQwMG8zMGtrUm0vS2tr?=
 =?utf-8?B?RDlNQTdNQ3dYbFBXakNlQk9yRUQxc1JWVjFGaDFuRzk0NWlNTHprSTlweDky?=
 =?utf-8?B?NDZFTy8wcUZrZnBkeHpOQTVubW8rbDRHdjlSdU5RM2JibGl2bjZDNXdwZ3JM?=
 =?utf-8?B?YTIxN0txbmgydlVmOTZhWEdocXBRY3FONmFwWUpBMTUzcnlPMmE1dVhuWmNn?=
 =?utf-8?B?eEtqbld6MEs4UXVLdFM4dUVPaFNCWXcvVDBrZzY0VVhTM21rdVFTUENnZkZ6?=
 =?utf-8?B?M25FYk51YXpMV2Jvdm12eWR5SzFrYWZiTzNodVFlaEptZU01My9ZL1ZOdXo4?=
 =?utf-8?B?Q1V5TXJRdFdKMVlZVUd4dUZlV3hBcW0wWkNjZDFLR01BMlNtWUY3dzBYUHg0?=
 =?utf-8?B?VU1jNlVKTG52VXpEZ3hZR2kxVkJzZHdWV1hKWEFENkgrTi9PcWpuRDl4citC?=
 =?utf-8?B?RGdUMG9yR21hdEFzOGRzUllzTzYzdmpyKzhjQmNXaUE1TmRJYjBCbDlEa0FG?=
 =?utf-8?B?aXVTYnhsQWVzdUwxSUNyRUcyUWZTajhleThCSnJUTUdJZE5lbmtHT1g3ak5y?=
 =?utf-8?B?YmQrZ3RUVHg3UVFjNXQ0Uk1uWm43eHBQZXZnbHBMYmluT2NMbW9CNUhnT2h0?=
 =?utf-8?B?MGVlYWRQclljb1NYVGw1bXVFa3VuOC9RVGMxbkVPNGhiZTd1K1NvMDBZcjlF?=
 =?utf-8?B?VzNuNDRXVVMrY3VEV2hhK215RVVORVViQ09tY0dFd3FTeFJ0RHJJUCtTYVpq?=
 =?utf-8?B?MDF3MG5oYnZ2S3hEaStZa3ZRNC9lcGpSZXN2U2lweVRqYmlBOTdwZFIrcVRq?=
 =?utf-8?B?SVdrblNoNENyRlJDTlhKOFBQVEFUY3kxdFAwcDJQU3p0alhxQzFoWmlENWhn?=
 =?utf-8?B?SHNtRDRDRW9EWFplMVZHNzB2eDhhVmNHVm5kYnZkbGJtbnErcG9SSVBpYjhj?=
 =?utf-8?B?UnRlVGNPYVdOOWxZMUFMN2JRcnFhRnpDajBiRjdFVjZCSzlDSlExMHowWkVT?=
 =?utf-8?B?R3hMMXVNa3hvSEltZ0oyb21Vbk1kZnExVCtheE9HYjZ4UVlTa0tVUnRPeXFG?=
 =?utf-8?B?c1lQZWJOYzViT0x2RHFrWDJQai94d2xrMHc1REg1MW1PTld6a2x5SjI0SjJy?=
 =?utf-8?B?R2NEb0RUNURxeGRTRDhubVVtV3VPVTZrK1l0ckJIT2Q0MWtRd2ZJNzFLZWlF?=
 =?utf-8?B?NFduQktnWU9SdE10MlpYZ0hON3ZuaThJT0RhU1J2Vk1oU2pVbkp2eGV5bUl2?=
 =?utf-8?B?c0RQRXJtTTNlSGRCOC8waGtzV21GSTlCWWM1WWdDQTFSbWNZZVNjaG0wdE9O?=
 =?utf-8?B?KzBnZmhKenZqSnFkWWNDbHdJWXJqam44c3dGYVY5UjBQRVFOamd5MnQyc1Ez?=
 =?utf-8?B?cW5oQUFzd25QRis0YmhSdTRLRURmQUlrNEFDK1BPelY1R2pCeGNvRUpDTGJW?=
 =?utf-8?B?SmFveGN5bXNiaW1mZUhCV1ZCRlNtUlRrOFRQNVRmOU5JQWNTNVRZeVZrZ2xD?=
 =?utf-8?B?YTFLRm1KNUtKSXVGOUxzMUdhbUpnS3NtN2FLbzVnOEFuNDRIRFFlWitzU3Vv?=
 =?utf-8?B?VVF4bU4wSUR2eko2R0l1enFySEJqZlhEQTZxYmNFS0NYTGN4SWFIMjUvSGhm?=
 =?utf-8?B?bzl2YnU4WEJqZmkrWGpjQVEyZ21aQ0NRU3M0dUxxZmRXUmJmenpWTFNmZEcr?=
 =?utf-8?B?b25tV0Q3dnUwakxUeVdWM0REM2Z3ZlRybWVlZDZwK1NadnM3SEFJWkE3OHlQ?=
 =?utf-8?B?L2VCYmMvb0d6NEd5aEl4V1FXUnBFajRRMnpBOEc0Y3AwUTV6dHUvTW9GSjE0?=
 =?utf-8?B?RGNKdk5SYlRZcFVuYlhHcitGNzJyelNJSHJIMExYMGQ2YnVRZ2Z4QmdLNkJz?=
 =?utf-8?B?bnBtK2NDZ0lEd3lValcvdUtzUXJOMkY0ZldqdU92YWwyN08xazNSa3MzTzR6?=
 =?utf-8?B?OWFaWXkzQyswOThWOFZOeUEzMC8rb1VyUXVONmtkbWN1eWgzcnlIZk9NQVNr?=
 =?utf-8?B?MnhSZXFjODIybDQ4c25DUkU1N3pZQXJpdVcrYTFKNE0wZVE2bFB6N1pRSXRR?=
 =?utf-8?B?dDlCYmE4dFVwbFVNeGwwQU42U1RvRlV0Z05VbmNMandOQ3JoaXFOTUw2UW9t?=
 =?utf-8?Q?hvyumHIWvR6OSqNp14t+FZlL5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2707E5222F5ED4DB222CE13B6B6A91C@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6053d7-f08d-4007-6421-08dd15b529e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 05:16:39.1882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6aLPnvGICJF8PwPnoBylcBcMAIGtPiOfO6Io7y0iLeEMol0DEJ5akXa4fPt8A+C09VHKRXMu/oCDuca4MkWI/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7787

SGkgQ29ub3IsDQoNCk9uIDA1LzEyLzI0IDExOjE1IHBtLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIFRodSwgRGVjIDA1LCAyMDI0IGF0IDAzOjI3OjAyUE0gKzA1MzAsIERoYXJtYSBCYWxhc3Vi
aXJhbWFuaSB3cm90ZToNCj4gDQo+PiArcGF0dGVyblByb3BlcnRpZXM6DQo+PiArICAiXnNsb3RA
WzAtOV0rJCI6DQo+PiArICAgIHR5cGU6IG9iamVjdA0KPj4gKyAgICBkZXNjcmlwdGlvbjogQSBz
bG90IG5vZGUgcmVwcmVzZW50aW5nIGFuIE1NQywgU0QsIG9yIFNESU8gc2xvdC4NCj4+ICsNCj4+
ICsgICAgYWxsT2Y6DQo+PiArICAgICAgLSAkcmVmOiBtbWMtY29udHJvbGxlci55YW1sDQo+PiAr
DQo+PiArICAgIHByb3BlcnRpZXM6DQo+PiArICAgICAgcmVnOg0KPj4gKyAgICAgICAgZGVzY3Jp
cHRpb246IFNsb3QgSUQuDQo+PiArICAgICAgICBtaW5pbXVtOiAwDQo+PiArDQo+PiArICAgICAg
YnVzLXdpZHRoOg0KPj4gKyAgICAgICAgZGVzY3JpcHRpb246IE51bWJlciBvZiBkYXRhIGxpbmVz
IGNvbm5lY3RlZCB0byB0aGUgY29udHJvbGxlci4NCj4+ICsgICAgICAgIGVudW06IFsxLCA0LCA4
XQ0KPj4gKw0KPj4gKyAgICAgIGNkLWdwaW9zOg0KPj4gKyAgICAgICAgZGVzY3JpcHRpb246IEdQ
SU8gdXNlZCBmb3IgY2FyZCBkZXRlY3Rpb24uDQo+PiArDQo+PiArICAgICAgY2QtaW52ZXJ0ZWQ6
DQo+PiArICAgICAgICB0eXBlOiBib29sZWFuDQo+IFRoaXMgdHlwZSBjb25mbGljdHMgd2l0aCBt
bWMtY29udHJvbGxlci55YW1sLCBpdCdzIGEgZmxhZyB0aGVyZS4NCg0KWWVzLCBJIG92ZXJsb29r
ZWQgaXQuIEknbGwgc2ltcGx5IHJlbW92ZSB0aGUgdHlwZSBoZXJlLg0KDQo+IA0KPj4gKyAgICAg
ICAgZGVzY3JpcHRpb246IEludmVydHMgdGhlIHZhbHVlIG9mIHRoZSBjYXJkIGRldGVjdGlvbiBH
UElPLg0KPj4gKw0KPj4gKyAgICAgIHdwLWdwaW9zOg0KPj4gKyAgICAgICAgZGVzY3JpcHRpb246
IEdQSU8gdXNlZCBmb3Igd3JpdGUgcHJvdGVjdGlvbi4NCj4+ICsNCj4+ICsgICAgcmVxdWlyZWQ6
DQo+PiArICAgICAgLSByZWcNCj4+ICsgICAgICAtIGJ1cy13aWR0aA0KPj4gKw0KPj4gKyAgICB1
bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQo+IERvIHlvdSBtZWFuIGFkZGl0aW9uYWxQcm9w
ZXJ0aWVzOiBmYWxzZSBoZXJlPyBZb3UgbGlzdGVkIHByb3BlcnRpZXMNCj4gY29udGFpbmVkIGlu
IG1tYy1jb250cm9sbGVyLnlhbWwgd2hpY2ggbWFrZXMgaXQgc2VlbSBsaWtlIHlvdSdyZQ0KPiBy
ZXN0cmljdGluZyB0byB0aGlzIHN1YnNldCByYXRoZXIgdGhhbiBhbGxvd2luZyBhbGwgcHJvcGVy
dGllcyAtIGJ1dCB5b3UNCj4gbmVlZCBhZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UgdG8gZG8g
dGhhdC4NCg0KTm8sIEknbSBub3QgcmVzdHJpY3RpbmcgdGhlIHByb3BlcnRpZXMgdG8gdGhpcyBz
dWJzZXQuIFRoZXJlIGFyZSANCmFkZGl0aW9uYWwgcHJvcGVydGllcywgc3VjaCBhcyAibm9uLXJl
bW92YWJsZSwiICJicm9rZW4tY2QsIiBhbmQgDQoiZGlzYWJsZS13cCwiIHRoYXQgYXJlIHVzZWQg
aW4gb3VyIERUUyBmaWxlcyBidXQgYXJlIG5vdCBkZWZpbmVkIGluIHRoZSANCm9sZCB0ZXh0IGJp
bmRpbmdzLiBGb3IgdGhpcyByZWFzb24sIEkgdXNlZCBgdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiAN
CmZhbHNlYCBpbnN0ZWFkIG9mIGBhZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2VgLiBMZXQgbWUg
a25vdyBpZiBhbiANCmBhbGxPZmAgcmVmZXJlbmNlIHRvIGBtbWMtY29udHJvbGxlcmAgYWxvbmUg
d291bGQgYmUgc3VmZmljaWVudCBpbiB0aGlzIA0KY29udGV4dC4NCg0KDQotLSANCldpdGggQmVz
dCBSZWdhcmRzLA0KRGhhcm1hIEIuDQo=
