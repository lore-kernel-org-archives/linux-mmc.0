Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207771494BB;
	Wed, 18 Dec 2024 04:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734495114; cv=fail; b=TSoaqxgiswCRsn/glqiA8I/2dTS8fGJcUKp/YTqfKm29gVHAzX9kuV4HugddbNuNg1NktrwEegwO8/OfCXOVB6BBkr5QkozyYqLP+AdOAKKgWuz7KA/gcqcuV9MEiGMsFah21uT6rqCe7wZ9Be9aPkMbeds5vKJL65MY479SAII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734495114; c=relaxed/simple;
	bh=bSHPTm69VuZWAApidwk1w7k5aX22CUlJTbo8VeRL6sk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pZVoOPBESiLGzcLEmQhGX8yy2031MlLI5BZ4+/9CtdOi9ff7IuYi9caH1b6eCz/LQzvPVeaFruqI6WzCu0bABqOXfpbGqEzbxOATQbF86UN8PoXM7/zk8WHIOCskNKuIOaQyPm2Qbqh9K26YlnmMLk6d8leKZBk8u+AfZZu6/L0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Z2ZjsCq+; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Z2ZjsCq+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDBz5u6sM+hGAK318fa6aX7CChu4K1DR6TLRcWKeDGBwQHM1UOYx3l1DSsoOcBL6AYdLVt+HlVQk5zTw/H1FkixZixh4wJp27TuKwgRa8DAFyhu/gtXWPMKizD6inlcr8UsHdWhOyAga3VlmFSIdWLp5o5+RYzvt6uL9dQfPJx7rIqc69s/bGIVk4zMq3Lz7lTLjspxd3Fht9wrz5o4jMBINm+OKctx7x4NH3CLNzHHId4nTuKveXeMnJY/HTxm6eeBlHH80FLRoGUkAW5z55dKLBMBzIcwomobPT51j/f0EGs2EblMhRsxmHIV+lDSUZ+9sHb8RqdpdmCIRxma6BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSHPTm69VuZWAApidwk1w7k5aX22CUlJTbo8VeRL6sk=;
 b=buKeCZ3svXIpVCkW6cwmO3D0OXcHQh3ZcYhTk4ZeufytgBLjMIH/VACTur0PB5uno/XIRftHLUQ5kn10eOqf09Wuad1iEwbxUGTK5eD5YrnDrcyWkgPWvA32pYtzFIzecd4Ox9wdl1/aZ7U1Y/wBmVLjOX5zNIP8BlNnAyMkYAowEoZuZLJz0EKgiW77ZfoViMhMxyzTGFbWpdOTJUu/P0N/iZYaAJbnBniP2Mq8+fTdWzYbyZ7mhTPe0OL2doxN/kbPOHL9atULb4NAMaO/vIXyAtrtrxRe1yRpfrAxUJnT/k9beoXH0o0mzH7amhSNHEpiPJhwZ1EdOly0zRajcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSHPTm69VuZWAApidwk1w7k5aX22CUlJTbo8VeRL6sk=;
 b=Z2ZjsCq+Rr/+rAtvRL932z4fLqPi+ehIAYBWTDQ2dlytfvBSNeeeHnFNcTaZ9SZevmAUjbFVFNTVWFdG6b/GAHUcGKbqK3g0Mm6KygwIMQri2s/yEp2wX0NJfsH99ev5d+xE8YthDskZPfriliiBBEDts3N/fSV6mQLijAD76HF6Q4E9BVx1L2znydgvmSzTRLLOpc0BqAkVK3Kk6rJ9rw0Yk2/MaAOQZ1Gbk+frwgDT6x9YxRxOdlopdFietY/1aavMPGMO6sOwYLUzhGTajiScXghrI4c8RQeHZwrt/JSY5JKYvY18NnF84smIwho4ksCcws/VGIGDWSERaNXBPg==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by SA3PR11MB8119.namprd11.prod.outlook.com (2603:10b6:806:2f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 04:11:50 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%4]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 04:11:50 +0000
From: <Dharma.B@microchip.com>
To: <robh@kernel.org>
CC: <ulf.hansson@linaro.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <Aubin.Constans@microchip.com>,
	<linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dt-bindings: mmc: atmel,hsmci: Convert to json schema
Thread-Topic: [PATCH v2] dt-bindings: mmc: atmel,hsmci: Convert to json schema
Thread-Index: AQHbSfNlxhx505vyIkmoypzABVPigrLqbpUAgAEDcYA=
Date: Wed, 18 Dec 2024 04:11:50 +0000
Message-ID: <63473475-f29e-4a65-a0aa-1f1e4112b57d@microchip.com>
References: <20241209-hsmci-v2-1-b5a6d7c59b67@microchip.com>
 <20241217124316.GA1136537-robh@kernel.org>
In-Reply-To: <20241217124316.GA1136537-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|SA3PR11MB8119:EE_
x-ms-office365-filtering-correlation-id: 72998960-1f5d-422c-ac0a-08dd1f1a1902
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SkRoalZGTkp1SEs2TlBHNVQzbjQvd0pOS0RadENZQ0pJNUdvVVpnRzBDZzZJ?=
 =?utf-8?B?VnViMmgxbFZVSDZONWZDckRGcFNzU0ZVbkN6dWFkLy9TazJIRHVROW5FNE94?=
 =?utf-8?B?SjhjdE5BWlZuc3UxajhLUkl6NkJlamN5U0VRTm8vcmhJaXFtRGJGN0NuV2VJ?=
 =?utf-8?B?ZTF5TjcweEFOcGQxYlVPUzFnMSt3alJZbDRISUxmWjdiVXVPUGpDZExadlUr?=
 =?utf-8?B?TTFKNXdmYTBlSFBGMmFhbXlBTmtrbHowT0prUG1pS3NXTEZadVpyWGZJT2Jp?=
 =?utf-8?B?T3MvZlJxRFF4N3hTdGhhR3prUlVsdG5kS1BKK2FOWDRBblRjMG8yQXBnMHd0?=
 =?utf-8?B?YjJvQytVWmFBWG1jQnVMVWk2ZUNzQWJWS1VwQi91NkZOUjdCRFZkNmF5SGU4?=
 =?utf-8?B?cnRwMEdMb2ZvNDFVOWFKRHdZa3FvYU5BVzV6UkdTcmxKMENWOFdKRGlwMkxm?=
 =?utf-8?B?MjNvY0FFTi9yR2dHa0ZlVmo0cVJFaCt1SWcyZkNKYUt1ZWxvVVZBZmwzbkNN?=
 =?utf-8?B?ajk5SE1QbUhMekdMWVlwTTV4M3NUbXEwc3NCRHJRNW1uVlNrd3ZjYis0VTdy?=
 =?utf-8?B?cmt2MUlsODJFS3JlV1JCNXZGbEhmVnVETDBMQzdZYXdsUU81SEQ3eE5SdEFr?=
 =?utf-8?B?aTRDR2dqN05MTGNqa3NzZTRFVHd5U2t4VjFHbWRJellzZVZrOStsWWlWZjJM?=
 =?utf-8?B?eEtNMEVDZE4xMmFVL0Z6Y05oZUF3eHJIckxZNzVyQ2RhbzJuREYyVUEydWw3?=
 =?utf-8?B?MVFhWkxPTDNNVXVQelJ6T050VnZubDlVTnpGd0hqbEhYNFRObllFRkxndTZn?=
 =?utf-8?B?dUNGUENQcUdGL0h4aTBIbGs1QjZDVGIya0FOMEk3MnJuNXZFU2RDTHg2UXJJ?=
 =?utf-8?B?QzN4YmQ2NkQ3Zk5Ydm1KZHNEcHkrNEZkM3hlUldBYmlnVTRLa00rRWw1eG83?=
 =?utf-8?B?MVNmZFJsSXIwaU40V1BaTzFMUHNiQzFlU2lpbDFuK2ZsQ0pQb05iSDVaVzhN?=
 =?utf-8?B?eXdsbVY4YmRRa3lBVVZkVndPaEh0NW5NQVhDL0N5ZDlSaWJjRmkwemlhWmR6?=
 =?utf-8?B?VlhsbzI3NmwydHlyVVgvU0lVeUJSNVhTRE5saUNBVSswVnlCYUY2eHpOWVUz?=
 =?utf-8?B?T1h0STRYYjAzK24wcmVvQ2s0RGpkcGRPYjgzOVpJVHJ6ZFdockRSWlBLT212?=
 =?utf-8?B?ZllDMXpWT29xdHY0T05zZTVrd2JVMHVncTFoQ2hsQlQ4djFxelNPYnpMVHAw?=
 =?utf-8?B?WmZGT3N3eWQ1QXQ4ZzlPeHJLeVExNFIxQUhGbGtDeEpCY29EekRoWWNXcmVV?=
 =?utf-8?B?TE1xU3RUdjBMaHhoRVR3elhxeUFZVzRvaitJakJKdEg1SGVVWWo4ZDc0d2JB?=
 =?utf-8?B?bVo5MFRpOFJBR2JUb1Q0emdBemwvQ2pPZ2dudzZDKzRWTXFHNnczbjFHNGRT?=
 =?utf-8?B?NnBSUUp3TmtFYUZrQ1NHQVhlbTEwczIyeHdxWStORTNYVVJEYlRDNXhGZmdB?=
 =?utf-8?B?TUF3WTlwUzZvMEhUQ2RJUzhjTCtFSHNRNFR2QVFmSTJPc0gveGhEUG52V2Fr?=
 =?utf-8?B?K3l4YjJrS2tGYXBDbzJoVmMwS1hoZG92MWxpVjk2SHcyYkpmcmtaS1I4ZkFt?=
 =?utf-8?B?MnFMVE9lNXpBYUk0a0loNkN6d3ZLVGkrNC9makVIaWZOY253S1l5a005dDZr?=
 =?utf-8?B?UFFUd1ErdGdJU2lPamt6RjhPS1k2VzNDbGlsMzh1TEhlRlVJUVJheFkwL0h5?=
 =?utf-8?B?VFl0ZTdFRXBrRzhGTGQweXN5cXFxK3JOc2Z0bVVYNm1QVFZzQXJYTDd4cnFI?=
 =?utf-8?B?Wnh0TWZlZEdSMzFZYU8wYjJHR3RveDFSeEFRKzQwK1FEZlhPbWp3Q0g0L1kw?=
 =?utf-8?B?TXI5TWRXWnZBb2trbW5McnhoL1A2eXJDd2lvYnlQU1Ryd0E9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VkpXTU05ZERXR1J6MG9rYkh3TnFRZXRDRkh4U0xqVXI0R05sZ0NyNmk2aGt5?=
 =?utf-8?B?dTdrTHFTWSs3aG9YKzRHcWNJTEw5dVJuWFZoNlZVODVzbDBKdldlQW1NNGpK?=
 =?utf-8?B?bjlxeHUrVWk4SUFhVi9LUFhvMk1YYVJBKzcrWHd6N0ZPL3RlV1hiUkh5L09q?=
 =?utf-8?B?SytmWTZSOE5Wd08wWDdsQlVGR1BnTmhpM2EvMkhLV25kUWNiUDY3ekttRmJk?=
 =?utf-8?B?OXlNanlzM2F5bDM1WHhkS0xrSnRRVWQxRXgrdDh3bEtxTUpGbGNsUllQTlVo?=
 =?utf-8?B?MW9LRnY1N2t2d0xPOEpJQ2IvYkFEWWVVdHUxV0d5bkpoK0svdk84NXduQmMy?=
 =?utf-8?B?bUxneDVUK25mekZUeHg3M0Q2QnQrTEZ1LzYzak5seU1yUFo1dTVzbVRsc1h0?=
 =?utf-8?B?aVVETUFjdmFZSFNoTDlGR0UxNUJjcDBEenJLNkg5cit3UGlXVDF3TEJIRTAv?=
 =?utf-8?B?d3hkL1ZLWkJwSDVNVTVDT3AvRHJweGoxdWlIa1lCaGthMHdLMVQzcEUxTURx?=
 =?utf-8?B?Q0J6RTlXQkRnOXF2UlBUNUZTdVhuS1QyWEJpdGV6QTNPWlkrZkpwQ0ZxYzFU?=
 =?utf-8?B?R2podWN6ZXU0Y0hqZHNjRUUyaFFFNXhxNUx2REsrcFB3UTRHNCtVcXBvbkk4?=
 =?utf-8?B?UlUrWXdjVmdzL2o2bllVR2VQYy81L2ZhU1lNQXd2YWgxMUs5N1dkN0E1SUo5?=
 =?utf-8?B?U2w5aUpVVTRUZ1owaytoSXpCTnBjenllVmM3YlVBZHdPbnk4NzZVV09TU2hk?=
 =?utf-8?B?VlYzUnJoalU3a3E0WWhuZ2J2b1JqVXFOZ2h6bDE5Zm51WW0wL1dpNTFkalVp?=
 =?utf-8?B?dWZ2RjVHNTc5aktnQTZ5ZlJFakY4MytDNnhsbmg4Q0hFcS9JN0VrOCtxSG9m?=
 =?utf-8?B?K1V6cXA1YUZBNXV1a1k0RmEwd3BZNWRvem0zY2dIMWh3TVd4SnBSbkkzTTVK?=
 =?utf-8?B?anlFVlR4K29ud3phODlWTDhIRTcrUEc5L2pRUm9sbytFd014Zmk2ZlB1SVNN?=
 =?utf-8?B?MUNuOG45RWNwemY0UFJURStxZHZZRHMrL290Uk12YTg3VzMwZmI4OVZsaUJF?=
 =?utf-8?B?cjlPV0luNG40Nm4rR0V2UXQzZDVRK3B0SWJLeU8yeGdXdlFjamFGZmgxdnR1?=
 =?utf-8?B?NUg2YnVXYmJ0aW9MblFYZFYwRU03NE8vMS9FaFhudUloSW1nV2loSTVqYmV2?=
 =?utf-8?B?YzRncHZLRVJScjFVdGtyNHdUK0pUZWVJWVVScXYzOWw1RVFkL0NaeGk5TmxM?=
 =?utf-8?B?d255REdNUzhVajlNS1pHV0lHcDc5YnNCeEJ3dzhkTkRINzNsNmFCdkI3c3JH?=
 =?utf-8?B?d0VPcHpSOVVJaCs0dlpia1c2NXA1STdBSU1DNnFOT3RDRmV0ejlIV09tY3gy?=
 =?utf-8?B?WjYxb0kvT3JPc1k4ZURPQkQ3dGxTcktZZWtPNkl3KzNRUmYzVWRxVmlYalJ0?=
 =?utf-8?B?S1NSYmM5a3Q1K01zTEFaUkh2Tm5ZZ3Bha1FRQ3NpS0wwRzZUTHJwWmVRVmhO?=
 =?utf-8?B?VnYwcFMycFFUU3V1cFI3VnBlWFRnUWg1WnNkZmN0Z1lUTFNHUVJjSTBvTUNY?=
 =?utf-8?B?VVRFcVBXdStsZmRPL0plbWppN0xBdWp1VkxabnJUaisvQlFSTE1BOFpWU1Ay?=
 =?utf-8?B?bnRmRkR2SEhNRVNkYVhuMGdtOWltVnpUc3pRNk1SbEphdWlHdGlneXVWQ2Q5?=
 =?utf-8?B?SGdhZ3BoZUxaNUFjaUFDWVhXSlhuM1AwTXFDY29jb2FHb2puaXpWVXV4SG9I?=
 =?utf-8?B?MTI3MFRPNkpVKy9PZjhSdmxhelBWaXJ1Z2NvU3EyeFhFSVNZVkF0aVdjUmRT?=
 =?utf-8?B?bjIzbllCMFZiTXhrQlRPdzJQV2lmUDdNdXR2OFB2ME9BWjN4QUh4TEt4SjYx?=
 =?utf-8?B?VjI2NEdtdXFKNnc3Yy9VRDNnWjZxSGVSTXluRVZTY2dOek4xM1hUOEg4eU9p?=
 =?utf-8?B?ZlRaajduRmRoU2svWHdTeG9mYi9CS0NBVU1RaHRvUHZhU29pTHdjMVVnTG42?=
 =?utf-8?B?VUk5Q2ZjTE9YejBxNzM5b2s2bmx2V3hLSFRxVjhCSFBscUR0YVlaSXNKeHdS?=
 =?utf-8?B?cFBZVlplN1VoakZvQjA4bW5BYzN0blNxS2FVdUdtWjdIbVRBYm1VbUJmdTh4?=
 =?utf-8?Q?qfVkg+UgVC1VYg/F5aao0NIse?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD7D9809C23CB74DA4715683AE164F4E@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 72998960-1f5d-422c-ac0a-08dd1f1a1902
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 04:11:50.5563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XQ8YyDHZaP3oYZAWTwkk2jTLcaRjWd8abHuiYibqPRKrTvRhj80Dw2RJ3M0HaKWBFRdn/vTGW0Q26Khxy/szNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8119

SGkgUm9iLA0KDQpPbiAxNy8xMi8yNCA2OjEzIHBtLCBSb2IgSGVycmluZyB3cm90ZToNCj4gRVhU
RVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBNb24sIERlYyAwOSwgMjAy
NCBhdCAxMDowMjozMEFNICswNTMwLCBEaGFybWEgQmFsYXN1YmlyYW1hbmkgd3JvdGU6DQo+PiBD
b252ZXJ0IGF0bWVsLGhzbWNpIGRvY3VtZW50YXRpb24gdG8geWFtbCBmb3JtYXQuIFRoZSBuZXcg
ZmlsZSB3aWxsIGluaGVyaXQNCj4+IGZyb20gbW1jLWNvbnRyb2xsZXIueWFtbC4NCj4+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBEaGFybWEgQmFsYXN1YmlyYW1hbmkgPGRoYXJtYS5iQG1pY3JvY2hpcC5j
b20+DQo+PiAtLS0NCj4+IENoYW5nZXMgaW4gdjI6DQo+PiAtIERyb3AgdGhlIGR1cGxpY2F0ZSBw
cm9wZXJ0aWVzIGluIHRoZSBzbG90IG5vZGUuDQo+PiAtIExpbmsgdG8gdjE6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL3IvMjAyNDEyMDUtaHNtY2ktdjEtMS01YTI1ZTYyMmRmZWRAbWljcm9jaGlw
LmNvbQ0KPj4gLS0tDQo+PiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9hdG1lbCxoc21j
aS55YW1sICAgICAgIHwgMTEwICsrKysrKysrKysrKysrKysrKysrKw0KPj4gICAuLi4vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tbWMvYXRtZWwtaHNtY2kudHh0ICAgICAgICB8ICA3MyAtLS0tLS0tLS0t
LS0tLQ0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDExMCBpbnNlcnRpb25zKCspLCA3MyBkZWxldGlv
bnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21tYy9hdG1lbCxoc21jaS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21tYy9hdG1lbCxoc21jaS55YW1sDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5k
ZXggMDAwMDAwMDAwMDAwLi4yNjY4NmFkYTYyODgNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvYXRtZWwsaHNtY2kueWFtbA0K
Pj4gQEAgLTAsMCArMSwxMTAgQEANCj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BM
LTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4+ICslWUFNTCAxLjINCj4+ICstLS0NCj4+ICsk
aWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL21tYy9hdG1lbCxoc21jaS55YW1sIw0K
Pj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1s
Iw0KPj4gKw0KPj4gK3RpdGxlOiBBdG1lbCBIaWdoLVNwZWVkIE11bHRpTWVkaWEgQ2FyZCBJbnRl
cmZhY2UgKEhTTUNJKQ0KPj4gKw0KPj4gK2Rlc2NyaXB0aW9uOg0KPj4gKyAgVGhlIEF0bWVsIEhT
TUNJIGNvbnRyb2xsZXIgcHJvdmlkZXMgYW4gaW50ZXJmYWNlIGZvciBNTUMsIFNELCBhbmQgU0RJ
TyBtZW1vcnkNCj4+ICsgIGNhcmRzLg0KPj4gKw0KPj4gK21haW50YWluZXJzOg0KPj4gKyAgLSBO
aWNvbGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+DQo+PiArICAtIEF1Ymlu
IENvbnN0YW5zIDxhdWJpbi5jb25zdGFuc0BtaWNyb2NoaXAuY29tPg0KPj4gKw0KPj4gK2FsbE9m
Og0KPj4gKyAgLSAkcmVmOiBtbWMtY29udHJvbGxlci55YW1sDQo+PiArDQo+PiArcHJvcGVydGll
czoNCj4+ICsgIGNvbXBhdGlibGU6DQo+PiArICAgIGNvbnN0OiBhdG1lbCxoc21jaQ0KPj4gKw0K
Pj4gKyAgcmVnOg0KPj4gKyAgICBtYXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgaW50ZXJydXB0czoN
Cj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICsgIGRtYXM6DQo+PiArICAgIG1heEl0ZW1z
OiAxDQo+PiArDQo+PiArICBkbWEtbmFtZXM6DQo+PiArICAgIGNvbnN0OiByeHR4DQo+PiArDQo+
PiArICBjbG9ja3M6DQo+PiArICAgIG1heEl0ZW1zOiAxDQo+PiArDQo+PiArICBjbG9jay1uYW1l
czoNCj4+ICsgICAgY29uc3Q6IG1jaV9jbGsNCj4+ICsNCj4+ICsgICIjYWRkcmVzcy1jZWxscyI6
DQo+PiArICAgIGNvbnN0OiAxDQo+PiArICAgIGRlc2NyaXB0aW9uOiBVc2VkIGZvciBzbG90IElE
cy4NCj4+ICsNCj4+ICsgICIjc2l6ZS1jZWxscyI6DQo+PiArICAgIGNvbnN0OiAwDQo+PiArDQo+
PiArcGF0dGVyblByb3BlcnRpZXM6DQo+PiArICAiXnNsb3RAWzAtOV0rJCI6DQo+PiArICAgIHR5
cGU6IG9iamVjdA0KPj4gKyAgICBkZXNjcmlwdGlvbjogQSBzbG90IG5vZGUgcmVwcmVzZW50aW5n
IGFuIE1NQywgU0QsIG9yIFNESU8gc2xvdC4NCj4gDQo+IFRoZXJlJ3MgYSBzY2hlbWEgZm9yIHNs
b3RzIG5vdyBxdWV1ZWQgZm9yIDYuMTRbMV0uIFlvdSBzaG91bGQgdXNlIHRoYXQuDQoNClN1cmUs
DQpJIHdpbGwgZHJvcCB0aGVzZSBhbmQgd2lsbCBqdXN0IGFkZCB0aGUgUkVGIHRvIG1tYy1zbG90
DQoNCiAgcGF0dGVyblByb3BlcnRpZXM6DQogICAgIl5zbG90QFswLTldKyQiOg0KLSAgICB0eXBl
OiBvYmplY3QNCi0gICAgZGVzY3JpcHRpb246IEEgc2xvdCBub2RlIHJlcHJlc2VudGluZyBhbiBN
TUMsIFNELCBvciBTRElPIHNsb3QuDQotDQotICAgIGFsbE9mOg0KLSAgICAgIC0gJHJlZjogbW1j
LWNvbnRyb2xsZXIueWFtbA0KLQ0KLSAgICBwcm9wZXJ0aWVzOg0KLSAgICAgIHJlZzoNCi0gICAg
ICAgIGRlc2NyaXB0aW9uOiBTbG90IElELg0KLSAgICAgICAgbWluaW11bTogMA0KKyAgICAkcmVm
OiBtbWMtc2xvdC55YW1sDQoNCj4gT25lIGlzc3VlIGlzICdjb21wYXRpYmxlJyBpcyByZXF1aXJl
ZC4gRWl0aGVyIHRoYXQgd291bGQgaGF2ZSB0byBiZQ0KPiBkcm9wcGVkIGFzIHJlcXVpcmVkIA0K
SG93IHRvIGRvIHRoYXQ/DQoNCmR0X2JpbmRpbmdfY2hlY2sgY29tcGxhaW5zIHRoYXQgbW1jQGYw
MDA4MDAwOiBzbG90QDA6ICdjb21wYXRpYmxlJyBpcyBhIA0KcmVxdWlyZWQgcHJvcGVydHkuDQoN
CklmIHRoZSBtbWMtc2xvdCB5YW1sIGlzIGEgZ2VuZXJpYyBiaW5kaW5nIHRoZW4gc2hhbGwgd2Ug
bW92ZSB0aGUgDQpjb21wYXRpYmxlIHRvIGl0cyBzcGVjaWZpYyBiaW5kaW5nKGFtbG9naWMsbWVz
b24tbXgtc2Rpby55YW1sKT8NCg0Kb3IgeW91IGNvdWxkIGp1c3QgYWRkIGl0IGluIHlvdXIgLmR0
cyBmaWxlcy4NCg0KV29uJ3QgaXQgYmUgcmVkdW5kYW50IHRvIGhhdmUgaXQ/DQo+IA0KPiBSb2IN
Cg0KDQotLSANCldpdGggQmVzdCBSZWdhcmRzLA0KRGhhcm1hIEIuDQo=
