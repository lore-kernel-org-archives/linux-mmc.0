Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C5016D4E5;
	Fri, 30 Aug 2024 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725027174; cv=fail; b=ljQVbpVU8n0OTGZ0egWd4SIHMX45GKUR5aNbKpCINxDgdozQPaOm8dhMFChBlDYYtavTLub23FocaaQJckp/+k9M8cd8grrPOkkzk+bCHJDzhHA0T0QI23+cuBYhOg7m8QQOGW6wIwx4NwBVbqN7MiyD12r4Why6rIWJNmbw28A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725027174; c=relaxed/simple;
	bh=pm/hgJUmc5VN8OM8VQ9VpbERA7gnBwY+mpHnP/9Rfxo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gWTKW7gEGTvF9Q8Zgp+LoLFfvAF1TpfdqYt3y3bQQc299yC1LaLjlBkgoNjpiS1w3tZxhqCDfowbv8M+bRkfQqQQyd/Gb5djUH3ahvmqaHhShVNUPe7k6SBaZdcwn2eSqY4bU+eEViQzDvwQ0crE0TElU139YwDgVcnQ7sNLniI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gG0L1Dq3; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gG0L1Dq3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWhrhJ5S/u4uu5C6PVkZeGFieNMNMMoUsxGgmYnEbhQGvJrya4Rjsdl2TbLB+Ee7koab41PPQzpf0F2c4BBYlKZGaDUFcwOBGnCfUjWWt/YDfJTPQ2SHrZeNtxUwU80lKW33xQAuA2u68rNBwNrp8hPMzzj/oPDP6YKyYI0RkO6+FOdIWILEHLSjZwHI3ZAeGJ6Vfw27XNmuMUU2PfKrRbsnM4e/2zvXAKdlXsirpUP5JJF8kbJBnyrK3IzHuiItHwnkwAlbZ9lA5L9s1SpSx7GFzSObwRaeocTnN+hJeBqlfQVJW/kLkQgnCTGZ5otnUTr8Iujr0nCovfl5Qn9fMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pm/hgJUmc5VN8OM8VQ9VpbERA7gnBwY+mpHnP/9Rfxo=;
 b=BI8gwMmn7CDJKigzYDH4szhBXI3B+q8mNg0BO8CIZhukJ8NKWLL7W2pmQPOnQE9TzWzS0zSm13GuOCAcNT95t3hGZDEOtgj9LJQas8y3JplzoEl2ENLwuS/AYTquH9Ncz3UZOs+X9oxJvImRwjCfDTbD+qKjYzn/XXgmdtz5BcaPSGdlcqFdqjeLeqX9CLkR7nH0fJ2ILq4zVh7RWqNxdWQ9UdsUluNPbJdLnVVIs/Nz7OCSwx+Q/GS3YJvBLUFI1vF4FVK1iu7RQybziX4bMNQ7cR9iiR6kV49zM3wGg3v1SDbKXek8fvqB+8OjYK6TI2WCFgZguTMSzHhpxzHc0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pm/hgJUmc5VN8OM8VQ9VpbERA7gnBwY+mpHnP/9Rfxo=;
 b=gG0L1Dq3wMCkTh7Asq4EcpJ67In5as8P9mnjtOFKhtENh/gvxWDKlRCN+5Wm6Sr6hOJj7//odHSZAQf1zIs/mii1INyNinRo1+Ikxed7f/WlTkwNFN6/BZ9a3UOxrsFyr64jaTX3iMunFFpbLmScjhepfo1zVHeq00M3xT8oPIY87OY9rUr0+AQu/dowZ0hbVDARGF8kPehF6ODujA6VFevlgNwyUwkpLtMSFNsGqXg3nr9qc3AjdTBCmN1MWoh+NQc8rmC87gy8a8R0YNMtFp7SB5IpiiyssmJtlHUKZc64pza9jIMKK7aDYlLEOfyOf6egb5rKCrxO7sgUJkUU0Q==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by DS7PR11MB6176.namprd11.prod.outlook.com (2603:10b6:8:98::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.17; Fri, 30 Aug 2024 14:12:48 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%6]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 14:12:48 +0000
From: <Dharma.B@microchip.com>
To: <conor@kernel.org>
CC: <ulf.hansson@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<Aubin.Constans@microchip.com>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: sdhci-atmel: Convert to json
 schema
Thread-Topic: [PATCH v2 1/2] dt-bindings: mmc: sdhci-atmel: Convert to json
 schema
Thread-Index: AQHa+rVxtm/j4HNzUkiWXokLlbvD27I/0SSAgAAG0AA=
Date: Fri, 30 Aug 2024 14:12:48 +0000
Message-ID: <9e9c8274-6bf2-45f9-8b65-ddc73a0802bc@microchip.com>
References: <20240830-atmel-sdhci-v2-0-b7f58973f3fc@microchip.com>
 <20240830-atmel-sdhci-v2-1-b7f58973f3fc@microchip.com>
 <20240830-satisfy-dislike-27ed075138b3@spud>
In-Reply-To: <20240830-satisfy-dislike-27ed075138b3@spud>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|DS7PR11MB6176:EE_
x-ms-office365-filtering-correlation-id: d3cf41e7-bd1a-49d4-b1d8-08dcc8fdd3aa
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dmNhVVBPTHNuaU12djZpQlFZR0dGSUd2bzJhVGZ1bDd1NDBSVjZ4Ym9CT2wv?=
 =?utf-8?B?R1c0TUs3MFBqVGdSS2RWUkRad25DNmwxbTd5bVZLenp4TXJVb1RsM1MyRHhR?=
 =?utf-8?B?VUJURWlHWlM3RktLMWpkRU90NXFlS3JmV0JuaGQvelU2N2ZncGlEbWZkczFH?=
 =?utf-8?B?UHMwc3d1Z285NFNZaVpkMGFJQlkyV1hlZmJReU9qamtzQ0puQ3dKSGF5YVpN?=
 =?utf-8?B?aUN0RFpmSTcxa1IrK0ZCM0tCMHRqdWVmaUwrMHBaQ3NQcnp3UVdzbTZ3MEZV?=
 =?utf-8?B?bXcveWR1L2lxQzRNbjMzVTZIYnNYMXVsY3cyOTdFbXdEWnlvWFk2UzJuMVdR?=
 =?utf-8?B?bFNKVnpXT2V1NEowTW5sMG05RzRHdFRCeE5WcXIxdTNrOVFidmoyY3AwWk1G?=
 =?utf-8?B?cUl0UzBZRzAxSHY4UVBGVUdTR25mWmFsLzRjOUpqM3V4dTZrOHNvWkliSHha?=
 =?utf-8?B?ZjdYS1h2ajh3ZlhkRFdaQjBrQVEyUUNFaGJ3K2tKbk5ISTZCQVFFeGlaRWZs?=
 =?utf-8?B?bGpxMDBsSksrUlNBTFJXUTFqU2xXWFJOcXpuNlFLbGhUWkYraXhibnRHU2Uv?=
 =?utf-8?B?M1gzSlc3YWVFdWwvZ0J0ekZ5SEVlOEcwNFR2bUFwNzVsbU9zMTNaWFlZQ2xv?=
 =?utf-8?B?a3hoT0lrR1FuSjFERUxEaHgyMjhNOG91T1hFMHVJSnVyTGZ1eVRZMVBkbXMz?=
 =?utf-8?B?MWcyZ0xoZjRqMmVyNnRsaGFqSW5DWWhKcERURWJmRVZGazF0bmRaUGREekZR?=
 =?utf-8?B?b0lFeGpNSkFYazZqZ2hxRlhhc3R5Zk1tTTFabVhXeHY0TDUvRGpTMDIyVDNl?=
 =?utf-8?B?SGtZK3UwNC83NnRxeVlIeTB4U3BxSHdNcGU5NnF1b0laL1FCTVlwZVdRNHpM?=
 =?utf-8?B?emNwRFhPT3kzY3JwMFFWSEJrYkJWWkpxeW51UzY1SmQzMFdEbnBKbVcvS01F?=
 =?utf-8?B?UnowQlc4UFhUMDNuS1pOaSsyazdhK3dHUWIwdjd6WHhoRjdSb0N2Z1UvNDBG?=
 =?utf-8?B?bW1Jd1VoM1JoTGE0c2VQa3JGQ1BVUVBTamFPS3BvYTFJUEwwOUsvdG1aNHV1?=
 =?utf-8?B?TmxEUGVsMTFiR0RoME81TW9LL2RoTkQ1TFRYcjBUa0hkZ3doWUpBSzd0SFow?=
 =?utf-8?B?RVQwZktJR1pnQms3RkllUGdEZTErZlc2RWh5WHRPWVRtNER6aldpajQ5L3NW?=
 =?utf-8?B?b05vSm1LRHVZanhpd3VDRDRlbEVCdE1VbGdVejR1WmFQQ1U3bDBUekRTZ0pX?=
 =?utf-8?B?UEZoalEyM0xKMXArOWRsYkFhM042SitDT3BrMXVSRGN6V0JUazk0V0pEd09l?=
 =?utf-8?B?ZmJVeW1FQXE4NjdhejM2R25TQStlVDNOMWw4TnBmdjB3TzY4QmREdXl2WEZL?=
 =?utf-8?B?bHdEWC93bHJnQmlENThEQ2MvcHFORU1DRy9lU0RUZUlYbGIwZXJVSmQ2YUkx?=
 =?utf-8?B?Y0hhYTE0UjF3cmdYM25NelFJeG1LeUJudG1jc3VPeHJjL1M2Q0xndWJZYUFY?=
 =?utf-8?B?QzRLTlFFVmh2RnJNdTZPemtjYkhudFJkNTgxNFFBVTE5b3JreUpjUFpvbVcy?=
 =?utf-8?B?dlBhS3d4Ym94SDVjaHRHSVpQK1Nqb2FidXRuK20xck42RXB2NlZFZUFlYnlq?=
 =?utf-8?B?TUVpMndza1c5UW5ZRlJvZWdWMEphVGl3dUNESmIzYlJPajdlOXlsT29EbG9I?=
 =?utf-8?B?NjBFTitVVzdlTmxtM2gxbkprejRJTHk3bVh0NlVwQ21lMVg2T3FIdk82TFh2?=
 =?utf-8?B?OVMwZ0gvZ2JSWTkwOVRzU2NqcVVrT3ZHVlkxK0ZwakU1TkVxZXZqTGlnV0JT?=
 =?utf-8?Q?owfLuJdlf3tLCtpitqiQ+CbifzYfib8vIjTlg=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b0tVbnRjdnUyMzdPc3NjTGJMc01tQUpxUnFxVnlJaXREbE44R1g0Q3pvSG9l?=
 =?utf-8?B?SFdKM014bnVPRmxTM3BQTk5XU0p4dlZJUU1HNjk1OTJXRUJhcHFSbVlrMXM1?=
 =?utf-8?B?Z09taC9NdWd0M3l4R21qbi9TMGtVVnpoVXl0QytwUVhFY1BGWWk0M3JTSjNM?=
 =?utf-8?B?U0ZDS2ZvcERmRWxISVhkenBnZll3eVExUmVpWnJnZ1pZZlFvREVNd202N3Nn?=
 =?utf-8?B?ejJiays4aFphZ1lncmc3aWYzaldLOFhyRjl3RE4yQ0NIaEdwM3c5VmQ2YzB2?=
 =?utf-8?B?NlVaMkFSc3BPSGNSZUYzVWVOTGIwcXovc1RJTFQ1RjV3ejZxUE9rVkYramNn?=
 =?utf-8?B?T3g4S3N5U3Y3MWcxamRaK0tEQll4Mk5hM3laQUdTTWJDMnVjWGNWdDhwdktR?=
 =?utf-8?B?Zi9MWEdvNUdRYnA4dG8vbjFSWWhEZVZybnh1SHJiU0FuNDI2UGFCa0UwWnBz?=
 =?utf-8?B?VFZvdThlck5RRnhIMVJPMEE3dUIxM2c4cGJTN3BzSEtIV3ZZQzFxL3BMTmVy?=
 =?utf-8?B?aWlkZjVXUW52RVdMRnlLcTJXU2NmeGI4ZXA5ZEdNYlpURE9RNEJqdkV0dzFs?=
 =?utf-8?B?bjJiVFdEWElRYTFKaGd6Ni9rc1I3THovOTJuMm1CUi9hRWt4UWtwZlJKMWhR?=
 =?utf-8?B?Y3hnNTNGamZicnpheVkzTWFtcWQ3bjl0VDM4azI0Y1lpMWlSNHdxcXVWMXU2?=
 =?utf-8?B?S1YvZzdGdU14c1ZDdVZBTHhHZFlZS0lrckM2aHBpY2FqaVdHNVZ4dm1EZFdE?=
 =?utf-8?B?cW9zTTg0TVErTjNUeGt1bFhTL3ZrZmxmNFZSUTNISDJHdDFNK2xpQVg1UVB6?=
 =?utf-8?B?OEVEYXJ1d2Vmd0NkMnVjcEp0RHIxcHJDU3RFQ0ExUDdqZzI4VXd2QSswMXA5?=
 =?utf-8?B?RnRhbVBvcmIxS1pwakRXZXBDc0k0U3NhY3gvSnBKOTJzL2cvKy93V1BVUW5W?=
 =?utf-8?B?NXlrVTVhbDZWUi9MYm5aamR3VlhzdzEySnlGUnJDc21BTWdiUkd2RXNnTVZ2?=
 =?utf-8?B?Y0pETjVMdlRhMloyTHhMeENtVStqY1owTzYxVGZ2c0JKMzdhWis5ZHErR3V3?=
 =?utf-8?B?dDE1RU5LMnAvMXJFTEI5V0s0RzlvWU13QUFOTGFpZTQxTjlwQ0pWV3NjelNr?=
 =?utf-8?B?SXJUQlVzRW5OdHVVV05jdS80OEtGbjNXeWVBcjZuMk82Q3ZJaTVHbnJia3pw?=
 =?utf-8?B?ejdXcHlVUmJhdjZ5TXZKaGYzTVgzSis5MXBETkJtaTh0cFk1K254Zzg3bUZB?=
 =?utf-8?B?VzhaSW1WZmErdW9aS2o4V21nUUVZSlZjMEZoOWhiN3ZLQ2diREdGeW01bGc1?=
 =?utf-8?B?NmZzeHRoSWZVcmlaeEZTNTRXSDNjd05wMlVYK1l0Q2cvNFQvKys3WHU5SkFv?=
 =?utf-8?B?Kzg1UitxK0NEbjhJTklQdlJzb241MlUvNnRCcXF4KzBBR3J4K2NuMWR5cHJN?=
 =?utf-8?B?aDRFUWdpbktvdlNoTVRKN2ozdTgraXhJYk1JbGhTSXU3MEJMeTJOcm02bkp3?=
 =?utf-8?B?c0ZZSVQzdW9VTXpsWk1kdzkrTzFXa2RTNWQ5UjZHZ3I3VjgzZVd4N1pzRlpC?=
 =?utf-8?B?VTF0Q0RaRFNHY0pyaGtqTmpxR01wbFo3YkRpbUtRTFNJKy9qNUhrdnFrWCtI?=
 =?utf-8?B?RnZEVkZiT1pTQ0psa0FTZWNETlM4Z3hkdHlraHN0TFFWWThITTB6OFhQc2Rm?=
 =?utf-8?B?T1U2S2FaakpDdFdIRi9UZFBtbUVKY2lKSDkwa2R0Y1VSaHN0OEUrVUcvem95?=
 =?utf-8?B?bmVkSU8xd3I2cUV0aks2NmJqaThhdjhoREdSK2lxQ0F0WEQyNUtTRHd3RGJn?=
 =?utf-8?B?aDA3VlpEL1J6TUYyWTBlNEdRRDB3d1BWWXVjaVRBWktVaHZqdGFqR2Z0NTNp?=
 =?utf-8?B?aDJnUHFJN1JtcWwxRmYxR2dhTGJBN2daYTVKOWh2d25UZ0gxbnd3d3ZKQ1Rl?=
 =?utf-8?B?UnFCNklwMXFPOWQ1TGkxYVRVT2d1aktObDdNV0VvcWpjRHkrbmJYTUdpZTlV?=
 =?utf-8?B?UzVUNXJYWHU2OG9sbEpwVXB5OXlVdU1CQk1ScDFWa1llcCtLWVRhUGJQVlJL?=
 =?utf-8?B?eDNPMDhicXlqY3QvZTErSkJ3SjF4SG1hR1U0QWFONjlIRFBzdmllQzBUYitq?=
 =?utf-8?Q?ZWMF9VkwHNZlWm5feVei4kNk6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBD2B27B7874474FA00B14009032B3A0@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d3cf41e7-bd1a-49d4-b1d8-08dcc8fdd3aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 14:12:48.2669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YiaMBwMdILF43TLG1zIjGEH7GDRRfoGnTX55Mgmjg5a4MyHTQvLq+XiWDz+REmPlV83/WR9WwQQqn9QP6if50g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6176

SGkgQ29ub3IsDQoNCk9uIDMwLzA4LzI0IDc6MTggcG0sIENvbm9yIERvb2xleSB3cm90ZToNCj4g
T24gRnJpLCBBdWcgMzAsIDIwMjQgYXQgMDE6NDk6NDJQTSArMDUzMCwgRGhhcm1hIEJhbGFzdWJp
cmFtYW5pIHdyb3RlOg0KPj4gQ29udmVydCBzZGhjaS1hdG1lbCBkb2N1bWVudGF0aW9uIHRvIHlh
bWwgZm9ybWF0LiBUaGUgbmV3IGZpbGUgd2lsbCBpbmhlcml0DQo+PiBmcm9tIHNkaGNpLWNvbW1v
bi55YW1sLg0KPj4NCj4+IE5vdGU6IEFkZCBtaWNyb2NoaXAsc2FtYTdnNS1zZGhjaSB0byBjb21w
YXRpYmxlIGxpc3QgYXMgd2UgYWxyZWFkeSB1c2UgaXQNCj4+IGluIHRoZSBEVC4NCj4+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBEaGFybWEgQmFsYXN1YmlyYW1hbmk8ZGhhcm1hLmJAbWljcm9jaGlwLmNv
bT4NCj4+IC0tLQ0KPj4gICAuLi4vYmluZGluZ3MvbW1jL2F0bWVsLHNhbWE1ZDItc2RoY2kueWFt
bCAgICAgICAgICB8IDk4ICsrKysrKysrKysrKysrKysrKysrKysNCj4+ICAgLi4uL2RldmljZXRy
ZWUvYmluZGluZ3MvbW1jL3NkaGNpLWF0bWVsLnR4dCAgICAgICAgfCAzNSAtLS0tLS0tLQ0KPj4g
ICAyIGZpbGVzIGNoYW5nZWQsIDk4IGluc2VydGlvbnMoKyksIDM1IGRlbGV0aW9ucygtKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL2F0
bWVsLHNhbWE1ZDItc2RoY2kueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tbWMvYXRtZWwsc2FtYTVkMi1zZGhjaS55YW1sDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
Pj4gaW5kZXggMDAwMDAwMDAwMDAwLi45MWQxOGIyNTQ1ZTENCj4+IC0tLSAvZGV2L251bGwNCj4+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvYXRtZWwsc2FtYTVk
Mi1zZGhjaS55YW1sDQo+PiBAQCAtMCwwICsxLDk4IEBADQo+PiArIyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+PiArJVlBTUwgMS4yDQo+
PiArLS0tDQo+PiArJGlkOmh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL21tYy9hdG1lbCxz
YW1hNWQyLXNkaGNpLnlhbWwjDQo+PiArJHNjaGVtYTpodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0
YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4+ICsNCj4+ICt0aXRsZTogQXRtZWwgU0RIQ0kgY29udHJv
bGxlcg0KPj4gKw0KPj4gK21haW50YWluZXJzOg0KPj4gKyAgLSBBdWJpbiBDb25zdGFuczxhdWJp
bi5jb25zdGFuc0BtaWNyb2NoaXAuY29tPg0KPj4gKyAgLSBOaWNvbGFzIEZlcnJlPG5pY29sYXMu
ZmVycmVAbWljcm9jaGlwLmNvbT4NCj4+ICsNCj4+ICtkZXNjcmlwdGlvbjoNCj4+ICsgIEJpbmRp
bmdzIGZvciB0aGUgU0RIQ0kgY29udHJvbGxlciBmb3VuZCBpbiBBdG1lbC9NaWNyb2NoaXAgU29D
cy4NCj4+ICsNCj4+ICtwcm9wZXJ0aWVzOg0KPj4gKyAgY29tcGF0aWJsZToNCj4+ICsgICAgb25l
T2Y6DQo+PiArICAgICAgLSBlbnVtOg0KPj4gKyAgICAgICAgICAtIGF0bWVsLHNhbWE1ZDItc2Ro
Y2kNCj4+ICsgICAgICAgICAgLSBhdG1lbCxzYW1hNWQzLXNkaGNpDQo+PiArICAgICAgICAgIC0g
YXRtZWwsc2FtYTVkNC1zZGhjaQ0KPj4gKyAgICAgICAgICAtIG1pY3JvY2hpcCxzYW05eDYwLXNk
aGNpDQo+PiArICAgICAgLSBpdGVtczoNCj4+ICsgICAgICAgICAgLSBlbnVtOg0KPj4gKyAgICAg
ICAgICAgICAgLSBtaWNyb2NoaXAsc2FtYTdnNS1zZGhjaQ0KPj4gKyAgICAgICAgICAtIGNvbnN0
OiBtaWNyb2NoaXAsc2FtOXg2MC1zZGhjaQ0KPj4gKw0KPj4gKyAgcmVnOg0KPj4gKyAgICBtYXhJ
dGVtczogMQ0KPj4gKw0KPj4gKyAgaW50ZXJydXB0czoNCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+
ICsNCj4+ICsgIGNsb2NrczoNCj4+ICsgICAgbWluSXRlbXM6IDINCj4+ICsgICAgbWF4SXRlbXM6
IDMNCj4+ICsgICAgZGVzY3JpcHRpb246IHwNCj4+ICsgICAgICBUaGUgc2FtYTVkMiBmYW1pbHkg
aW5jbHVkZXMgdGhyZWUgY2xvY2tzOiBgaGNsb2NrYCwgYG11bHRjbGtgLCBhbmQgYGJhc2VjbGtg
Lg0KPj4gKyAgICAgIEZvciBvdGhlciBmYW1pbGllcywgaW5jbHVkaW5nIHNhbTl4NjAgYW5kIHNh
bTl4Nywgb25seSBgaGNsb2NrYCBhbmQgYG11bHRjbGtgIGFyZSB1c2VkLg0KPiBUaGlzIHNob3Vs
ZCBpbnN0ZWFkIGJlIGFuIGl0ZW1zIGxpc3QsIHJhdGhlciB0aGFuIGEgdGV4dCBiYXNlZA0KPiBk
ZXNjcmlwdGlvbi4NClN1cmUsIEkgd2lsbCB1cGRhdGUgaXQgbGlrZSB0aGlzIGJlbG93DQoNCmNs
b2NrczoNCiAgIGl0ZW1zOg0KICAgICAtIGRlc2NyaXB0aW9uOiBoY2xvY2sNCiAgICAgLSBkZXNj
cmlwdGlvbjogbXVsdGNsaw0KICAgICAtIGRlc2NyaXB0aW9uOiBiYXNlY2xrDQogICBtaW5JdGVt
czogMg0KICAgbWF4SXRlbXM6IDMNCg0KPiANCj4+ICsNCj4+ICsgIGNsb2NrLW5hbWVzOg0KPj4g
KyAgICBtaW5JdGVtczogMg0KPj4gKyAgICBtYXhJdGVtczogMw0KPiBXZSBwcmVmZXIgdGhhdCB5
b3UgZGVzY3JpYmUgdGhlIGVudHJpZXMgYXQgdGhpcyBsZXZlbCwgYW5kIGNvbnN0cmFpbg0KPiB0
aGVtIGluIHRoZSBjb25kaXRpb25hbCBiaXRzIGJlbG93LiBJT1csIG1vdmUgdGhlIGl0ZW1zIGxp
c3QgaGVyZSwNCj4gYW5kIG9ubHkgdXNlIG1pbkl0ZW1zL21heEl0ZW1zIGJlbG93Lg0KDQpTdXJl
LCBJIHdpbGwgbW92ZSB0aGUgaXRlbXMgbGlzdCBoZXJlDQoNCmNsb2NrLW5hbWVzOg0KICAgaXRl
bXM6DQogICAgIC0gY29uc3Q6IGhjbG9jaw0KICAgICAtIGNvbnN0OiBtdWx0Y2xrDQogICAgIC0g
Y29uc3Q6IGJhc2VjbGsNCiAgIG1pbkl0ZW1zOiAyDQogICBtYXhJdGVtczogMw0KDQo+IA0KPj4g
Kw0KPj4gKyAgbWljcm9jaGlwLHNkY2FsLWludmVydGVkOg0KPj4gKyAgICB0eXBlOiBib29sZWFu
DQo+PiArICAgIGRlc2NyaXB0aW9uOg0KPj4gKyAgICAgIFdoZW4gcHJlc2VudCwgcG9sYXJpdHkg
b24gdGhlIFNEQ0FMIFNvQyBwaW4gaXMgaW52ZXJ0ZWQuDQo+PiArDQo+PiArcmVxdWlyZWQ6DQo+
PiArICAtIGNvbXBhdGlibGUNCj4+ICsgIC0gcmVnDQo+PiArICAtIGludGVycnVwdHMNCj4+ICsg
IC0gY2xvY2tzDQo+PiArICAtIGNsb2NrLW5hbWVzDQo+PiArDQo+PiArYWxsT2Y6DQo+PiArICAt
ICRyZWY6IHNkaGNpLWNvbW1vbi55YW1sIw0KPj4gKyAgLSBpZjoNCj4+ICsgICAgICBwcm9wZXJ0
aWVzOg0KPj4gKyAgICAgICAgY29tcGF0aWJsZToNCj4+ICsgICAgICAgICAgY29udGFpbnM6DQo+
PiArICAgICAgICAgICAgZW51bToNCj4+ICsgICAgICAgICAgICAgIC0gYXRtZWwsc2FtYTVkMi1z
ZGhjaQ0KPj4gKyAgICB0aGVuOg0KPj4gKyAgICAgIHByb3BlcnRpZXM6DQo+PiArICAgICAgICBj
bG9ja3M6DQo+PiArICAgICAgICAgIG1heEl0ZW1zOiAzDQo+IG1heEl0ZW1zOiAzIG9yIG1pbkl0
ZW1zOiAzPyBZb3VyIGFuc3dlciB3aWxsIGRlcGVuZCBvbiB3aGV0aGVyIG9yIG5vdA0KPiBiYXNl
Y2xrIGlzIG9wdGlvbmFsIG9uIHNhbWE1ZDIuDQoNCmJhc2VjbGsgaXMgbXVzdCwgaGVuY2UgSSB3
aWxsIG1vZGlmeSBpdCBhcyBiZWxvdw0KDQphbGxPZjoNCiAgIC0gJHJlZjogc2RoY2ktY29tbW9u
LnlhbWwjDQogICAtIGlmOg0KICAgICAgIHByb3BlcnRpZXM6DQogICAgICAgICBjb21wYXRpYmxl
Og0KICAgICAgICAgICBjb250YWluczoNCiAgICAgICAgICAgICBlbnVtOg0KICAgICAgICAgICAg
ICAgLSBhdG1lbCxzYW1hNWQyLXNkaGNpDQogICAgIHRoZW46DQogICAgICAgcHJvcGVydGllczoN
CiAgICAgICAgIGNsb2NrczoNCiAgICAgICAgICAgbWluSXRlbXM6IDMNCiAgICAgICAgIGNsb2Nr
LW5hbWVzOg0KICAgICAgICAgICBtaW5JdGVtczogMw0KDQoNCj4gDQo+IENoZWVycywNCj4gQ29u
b3IuDQo+IA0KPj4gKyAgICAgICAgY2xvY2stbmFtZXM6DQo+PiArICAgICAgICAgIGl0ZW1zOg0K
Pj4gKyAgICAgICAgICAgIC0gY29uc3Q6IGhjbG9jaw0KPj4gKyAgICAgICAgICAgIC0gY29uc3Q6
IG11bHRjbGsNCj4+ICsgICAgICAgICAgICAtIGNvbnN0OiBiYXNlY2xrDQo+PiArICAgIGVsc2U6
DQo+PiArICAgICAgcHJvcGVydGllczoNCj4+ICsgICAgICAgIGNsb2NrczoNCj4+ICsgICAgICAg
ICAgbWF4SXRlbXM6IDINCj4+ICsgICAgICAgIGNsb2NrLW5hbWVzOg0KPj4gKyAgICAgICAgICBp
dGVtczoNCj4+ICsgICAgICAgICAgICAtIGNvbnN0OiBoY2xvY2sNCj4+ICsgICAgICAgICAgICAt
IGNvbnN0OiBtdWx0Y2xrDQo+PiArDQo+PiArdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0K
Pj4gKw0KPj4gK2V4YW1wbGVzOg0KPj4gKyAgLSB8DQo+PiArICAgICNpbmNsdWRlIDxkdC1iaW5k
aW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCj4+ICsgICAgI2luY2x1ZGUgPGR0LWJp
bmRpbmdzL2Nsb2NrL2F0OTEuaD4NCj4+ICsgICAgbW1jQGEwMDAwMDAwIHsNCj4+ICsgICAgICAg
IGNvbXBhdGlibGUgPSAiYXRtZWwsc2FtYTVkMi1zZGhjaSI7DQo+PiArICAgICAgICByZWcgPSA8
MHhhMDAwMDAwMCAweDMwMD47DQo+PiArICAgICAgICBpbnRlcnJ1cHRzID0gPDMxIElSUV9UWVBF
X0xFVkVMX0hJR0ggMD47DQo+PiArICAgICAgICBjbG9ja3MgPSA8JnNkbW1jMF9oY2xrPiwgPCZz
ZG1tYzBfZ2Nsaz4sIDwmbWFpbj47DQo+PiArICAgICAgICBjbG9jay1uYW1lcyA9ICJoY2xvY2si
LCAibXVsdGNsayIsICJiYXNlY2xrIjsNCj4+ICsgICAgICAgIGFzc2lnbmVkLWNsb2NrcyA9IDwm
c2RtbWMwX2djbGs+Ow0KPj4gKyAgICAgICAgYXNzaWduZWQtY2xvY2stcmF0ZXMgPSA8NDgwMDAw
MDAwPjsNCj4+ICsgICAgfTsNCg0KDQotLSANCldpdGggQmVzdCBSZWdhcmRzLA0KRGhhcm1hIEIu
DQo=
