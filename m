Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338F91CDA2D;
	Fri,  7 Feb 2025 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738918951; cv=fail; b=PTGs819DOIM0lAGwfAX/RKUVLljS7okO1sgiQDdkx6R6gL/JyZAuO+AqwZ/CTkjapudsgj3ny3z9FVazxc3w8C/70VYpsUQ7BGvPeAUHoqwMi4eVts14xk388QFaD9Kgyhe/oft6p+SRDrdbGJmLn7lgOicru4/Eeo6aZ9zeS70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738918951; c=relaxed/simple;
	bh=GI7tbbeO36T8wJsvRPpqdavzTY93q2pDjxk+GcVnIkg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jhIaPIZWOW10wJH0IhTjYtFQM2i6yBc9+j1KdxlJeN7kQSuxnpczDE6z1CVhtqIk03RafxKHuvXmfu0SFoCqFQty2aBEBHI4tAUCRhbvQZxi7cn7ulowrHbqhxo8RBSB9WawTK3QwRPx0j7yqyqyuaFA7IHJArwcmjaTlEqeBj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EPg1hBAr; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EPg1hBAr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xy0UzqipNfRtusm6nhvdkMFWWZBeQU2dhiC3rCD71pR0+7fAlndepdx0eL8k4zWy2bdEAs7AlpSNAhY21TlCN8rLL6V5nJ2u3zZdIK4/ozZPrBs7XYhGdBhqN2bQ6XUrBCUYv7AutTPTBkSCSxZrhljAwV9NQl6A5XO7+QdBARWdpd6STCi4isLxtuLU8G20n+3y8XmcMzGSAHl8x1N3iGrc65Vfzg6JLYP9LR1mVqST9fGo5ccEFpQA9+VD2T6rWRlhP1xMDtjT5WtxdXnM1xXxeXkCLbCzIKG23MwYyrDDJjY2sFdwRoW8dQcgv6dYrbFeNok0ua/1JNon8MiEHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GI7tbbeO36T8wJsvRPpqdavzTY93q2pDjxk+GcVnIkg=;
 b=niTdmjTw6MUFGZK4t29fnkel9cdCxoZgI2PghHCUQ1K6pzo2m99O2fEYf5Q4liZcLC6W0FJkVkudy0QC8B1pbbj/WFrzTx/FlhC2Er6+K/Ci7wk7gsJYXIx0lkjih1RAFqKO5gA1W+AzHjl3A5P7DbkvFd5+h60Dqqh//R/a7W/kNvfCi9JQbpzEf2TgZkMIOXWhhMkJnEI+yyitpn6zbbjzWdkBvG7eUcRrDHlrlRkPDnJ5ZjgEwdXvVY1BQ3CAVhPINI+O/Pt0HhCGNcdqBZ7adV99JadmadOpgBJGf4NcbN8PKfXt9mrJvu8jsOcXqhaEb36EAhM3zOpdXE57tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GI7tbbeO36T8wJsvRPpqdavzTY93q2pDjxk+GcVnIkg=;
 b=EPg1hBArbUZFYV05Mn9KJRkyvDelhzoooX7qQfr5SS3WyQfYEly58UGT4cZuHLw+h0I4GXKzTkvpSQ327MablCuHG+1FG+2K+qv2jd9cc4p7np2S6YGjQkck6lHbi4HUvmnhBn98QwaGrQTMyU83wrlqoksSee1dC6RbyLN53lHapbuTiUZevdNlpRgdamJeNOrvBcstMY7nsFk75uuSGmI648sKi26TpuU+hIBxGTRPMwSYcxk11GCinhW8wOJtu3jsnB1hZxnc67CMzmawIkN2DsqCGSWULhhJuICX4xWNmS+xDr08cocHfbMf8b6ScNKl1PixD+eXzzqJRkZn3w==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by DM4PR11MB6143.namprd11.prod.outlook.com (2603:10b6:8:b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 09:02:26 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%6]) with mapi id 15.20.8422.009; Fri, 7 Feb 2025
 09:02:26 +0000
From: <Dharma.B@microchip.com>
To: <neil.armstrong@linaro.org>, <ulf.hansson@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <khilman@baylibre.com>,
	<jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2] dt-bindings: mmc: mmc-slot: make compatible
 property optional
Thread-Topic: [PATCH RFC v2] dt-bindings: mmc: mmc-slot: make compatible
 property optional
Thread-Index: AQHbd4DiJT/2q7h3vk+co+F7jIgTKLM7jO4AgAACEoA=
Date: Fri, 7 Feb 2025 09:02:25 +0000
Message-ID: <003ffa44-c88a-4234-a54a-50cd1140982a@microchip.com>
References: <20250205-mmc-slot-v2-1-da3c5f30e2d9@microchip.com>
 <f6d7ffa0-6c08-45fb-9153-5e4aad1ca86a@linaro.org>
In-Reply-To: <f6d7ffa0-6c08-45fb-9153-5e4aad1ca86a@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|DM4PR11MB6143:EE_
x-ms-office365-filtering-correlation-id: 27a84442-bbc4-4ae8-423a-08dd47562466
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bWhpUUw1V1ZWZ09OOUF3QXFWa0VLUkV6K2RkMEJ1SlNTOG4yVkJicXdQajFi?=
 =?utf-8?B?WHp4b2IzQ25IYVMya0h3QXNCc0pYRlNndGtnN3lvRjhwYi9lL2p6MHBVNG1C?=
 =?utf-8?B?Mk9sOU5qaE1tdTllOVFKekE2b2w3QkdRZ2ZlMXhHL3gwenQ4RXpiaTJqSElG?=
 =?utf-8?B?eVJPNGxpWmRhNkJuVlV5UGZ3ZzYxOVM4d2pCZG5YQ0RxYjZjdGc3ekJTRjhP?=
 =?utf-8?B?T3pQZ3FzK1RWSjhtSG5pTVhERXFHaW0rYVZVR1Q4aHc3WWVhUXJ3RWNnZUx1?=
 =?utf-8?B?RzJvSTBXbnk5Z01OeUYyU05BUGFTYyt3NkpDTWxJQ0NhTDFsRlBCdHNDVFhp?=
 =?utf-8?B?ZGdFaXNOY1ZKMXhoUW9kMGM1WUE2KzU1eVFkSkI4aVIzRUNzMEVxZ29uTXpk?=
 =?utf-8?B?Vy91L0ZzdGxMMTJjZm0rQm4zR1FrTEJpU242aTdSa1NUa1ErbzJOajZVT0hF?=
 =?utf-8?B?eG1aWEdSVGRCV1dzN2VyaXdFWHp3c0pBMURWU3RTRDVqZFpCZUV5UVV6TTJt?=
 =?utf-8?B?VjJBeWNVRGgrUEE1cFlPcU1mNmVXVjZUWHlmZmJZRVIvaHBqdzhGejJraERp?=
 =?utf-8?B?b0p1QXB4cDZObWd4NVVFd3FDc1crVFRiN2orckRYMDI5bG1WYnBBWFlWc3pY?=
 =?utf-8?B?eHRIc3BSV0MrcHlZcndMSkJKODNGTVVwK3ZKUEJiMDRwS1JNZlEwamNrYThZ?=
 =?utf-8?B?QTRjWWVoNmJYRU1obFpGVDI2RExuUEpnMXZ6NjdvMDd0OGg2TU9DOTdjUSsv?=
 =?utf-8?B?MWJ4ZWZzOHBEQm5Sci9mY0dBaXcyYnZKYUMyVlRZSUJnOWVKejFoT1FJUEVX?=
 =?utf-8?B?R3RmUStLbExjc3RnZWEwd21qSVZSTXF2VDlXTEV5cUlyNnR1WkMvNjEzSmIv?=
 =?utf-8?B?TTYwVkdLWnFRcTIxbEdDYUxvVEcwbnpIQktaRW0xUkpNNG00RTUxcFdqaEZD?=
 =?utf-8?B?aUQ3NXZ4OHMrN2g2WXo2LzA1MnduRWpxUnFSUGJhRmJnN2ZoREdrSVJPbUtT?=
 =?utf-8?B?cjdaWkJIb0d5bGN6RUpiTVhuOGdMb0xaRVYzeTNBTEhUeUk1dW1lVm91aHNl?=
 =?utf-8?B?cXJhNlZLam13dE04VXozWjk3TVJ6YVpsdFAxMUtjZ3A2Y1YwNmgyNVF2bXpI?=
 =?utf-8?B?MUh6K0p6dGwzWm9DVmtBS1NkekdzTkZyY0MzZFNFMTU5U2FGemVEUEJVeDNv?=
 =?utf-8?B?Z3dCSWd0N2dXTEJ3V29HNCs3S0NUMFo2ZTJJUmZLRFRYN3R3NFFHbmM0NUtl?=
 =?utf-8?B?MlZQb0ptQkN4UlBidmIzTFZPalFSRnVrQWpJZ09udjRPeWRnNkZDN2ROVXlz?=
 =?utf-8?B?WHpiOWFIS25GazNTanV2R0NWYkVhaldndU5DZjljRVgxVjRDLzduNGNKZEVj?=
 =?utf-8?B?bFZldE16TnVudDRBeGgzaVRqR0ZReldxODB1RlQrRXgzL0dxZnNnZmc0MG1S?=
 =?utf-8?B?NWRnVHdLWWI2Zk80RkYrUGVRTkEzMjUyM2J3czErNWRTWVNvemxtVWxIbHFr?=
 =?utf-8?B?bG14ZDd6MTUyVHpBY25NamZEanh4ZU0vVHFyWUxkbnhUZFN6S0k0M3dKOEZi?=
 =?utf-8?B?aVRDbXNhKzJtalIyV211TFA4MTJ0eENtcTF2Ynl6RGFTTlRjSVhnK0FiWkVN?=
 =?utf-8?B?bE53NnFnVzJIR0NPaEVCN2c0TndSODZYVVgxSndmMC83TFZIN0NNenZWUHk1?=
 =?utf-8?B?SjBYdlplUmlGSnQyTzZld3V4bDFmd044VjFTZnhOQmVJZHBrVVlTMmVyQStP?=
 =?utf-8?B?ZVllcXVkc01ubG9PdFl4aVJQMVk5Q1k0Z3IyUVRiZUNGVkZVeHpuN2JpVWNX?=
 =?utf-8?B?WnNadnZUb1hXL1ZzNG0vWjh4cW4vd2VhVzhvYzhaSWRoNk9obER0SGpEczhC?=
 =?utf-8?B?dXJqYjgxK2hrNFBDcFZ6SHJPbmRrV1dKRUp5Uk04djk1cGtLR0l4cG1RVkw5?=
 =?utf-8?Q?+JJm8Nfh0Tgd+IC+gP2E3TpUHChvDFJ3?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bXN3U1E0c2dDOVNyMDY2cThFdTRseGFPOGpCejVUSVhXbDdWbGtIZG0rZWFN?=
 =?utf-8?B?Tnp6ZlhtNS81UHQ3RXZVWDJ4VmNOMWE1amlLQzduYnhzMFhQREx5SmQ3VUJo?=
 =?utf-8?B?NUNtUE83WWVYSTRoenVVWmJpVG9QSEhCWmFqRVhMSXFrdCtBT05na2VxSGRG?=
 =?utf-8?B?U3EwRWY1Rmcya3phMEc3TVoyd1NSWkdpVzJUM1c5ZHFMNmdoMS9wQTBweGd5?=
 =?utf-8?B?N2tLZmMwUzd1bEtDekkwLzJDNWFEbVpiS1c4SDJ1ZlRtdkFsU3hlYVNUTWJj?=
 =?utf-8?B?SmdoYStpSU13dFNXSW53QjdWOS9PckRFWnJPb0ZQNEQzazY0dWExRU1PM09Q?=
 =?utf-8?B?Sk1VbnZxMkF5Qk8raC9YUVpINTF4SWdTbFNDMGxOcFVpVWF1c1BPT3Voc2lN?=
 =?utf-8?B?VUM0emd6UERSNktsQk43SmV2NE41SHVYVWFDNysvOG9URzNtblBsZC82b3V4?=
 =?utf-8?B?R0RtcGZaUDMvSk4vcFFJa2I0WkZ4c1Bpb2RIenhUaGdGU01iOTRFczF3dU9M?=
 =?utf-8?B?WHNiWUNxK1VDWWRUYVJRSmxaNjhQbldwY3F2NnNBSUdETkFHcXhyUXZEcmhF?=
 =?utf-8?B?MlFvUlJiVExORmlrVCt2NHpDTkRhSGc0aW1kRzRrWWV1dmVMcHVna2NOS1No?=
 =?utf-8?B?V3VXTjRNTE9MeGRvN0pBWlpUaWdPMHJBSElsZWE1NW4yTVRHOTQ1V0p1UUhh?=
 =?utf-8?B?WlpFd0Radjd6USt5L1NQS3ZVdE1HaGZTUXdVb213NkZ4blljV29veGFiOFdi?=
 =?utf-8?B?YWRLekNxcXBpYW9vbDBtUnhoellaeUxHRXM5V280bUNNcWRTbG55dVplSUdw?=
 =?utf-8?B?NHFNSEEwbWJOWUgxOWVjMWpEUXdsM2U5TVkyajN0bitYZlRNT2tNcnZSSXJD?=
 =?utf-8?B?end0Mi9GSFN5ak5jTHp2S1Uxd3orbklEZUJTQllyOFF5UkxXSGVEUzdIUGN6?=
 =?utf-8?B?RVdsTzhzSEFucGNvNk9naTg4dHVZRXFmQ2VEVXhMNkgyNXpCdVJRUXlJenFR?=
 =?utf-8?B?RTVuZUl2OWoydjNwYlpCY2RDb05LaVZzSDFpT1huWE42UjM3elRDZHJCdkla?=
 =?utf-8?B?OXIwSXhwZW43bjNqeWo1emU1MkJZblNFMlpPRk1TS05QQWJZVklpSmc2Qlpa?=
 =?utf-8?B?bEwzdXYyU3phQ0hzSEoyb2ZPQ0hwczVWSUpla1ZmbVpJM3p1YkNYWFo4Vk5N?=
 =?utf-8?B?bHBha0hxbk90QUgxVDdWSlZDQXpVVGdNSVZXdEZ0MXBraUt0VDcrMy8rWkVR?=
 =?utf-8?B?ZEtFbEdBMjRQT1YrTnBONWJRTWZRblN0d0tRbFpPaWJyTGlNQ3FXYzZOWTk2?=
 =?utf-8?B?bkRuZ3NSeGpjNlVSNVdYWUVMdVRQVzhIaThTRHZqek5pR3V4eW5CNjRZWGh0?=
 =?utf-8?B?aGowRTMrbmxiYSs4TU5UajNzL2pCRFljSjVsMlZzWFNDZnpZZjdMZmpRdXY5?=
 =?utf-8?B?TXowSVFocUQxdngyZEdnQUNNT25JYWhqZ3dQVjE1bklNdWJtbE8zY2luekhI?=
 =?utf-8?B?eUFlaXNFa3QxbCtEMk1LRFUweUx2S2JRaHdiMGtxVjFDdFF2RWhhZ3BUK3di?=
 =?utf-8?B?cVNrTUp0RGdXRkNDc0RrQnlTVFZUdkNKWi9JdkdCaXF0bXlCelo2RkJSRFc0?=
 =?utf-8?B?alhuR1NQYzFXbzlDaHBQdEZqczMyL1RxUzk3UzhBSjJDS3F3dmZiRkovTjM1?=
 =?utf-8?B?WjlqOXlPbE8vczg0ZHlsNTVqelkxelZHUFZvNDROSVk3TEMvd0h6a1NLWU5Q?=
 =?utf-8?B?dER3RHlMQmR2NHZWUjQ2MXBUaEdDVHFLUGF2NXEyeXFIUWRDbE9zTDZBSmxn?=
 =?utf-8?B?MWpZbm5jNGhCVHU0WTB1RysvT2d6K3NKK3plRE9JTVVaampBYTM2ZWN2Ui8z?=
 =?utf-8?B?QnBUOTlETDJPei9JM2doNHc4MFZtaU5TMmN0eTYzN2ZVZVM4VHBMV1pWM1V4?=
 =?utf-8?B?SHJoMWhSRzJEaHY3VDJ5QlUrQUZIdVppWHJOZElSOTNxa0x6K1lmNVo0RmVz?=
 =?utf-8?B?SDhsN0lnOGhNOXVuNXlpbnBvMnVWMEFUT05OYjcySlpYTzRZZlhBRHNvUUtZ?=
 =?utf-8?B?UVdTakNxMVE4VEF5dm0vSml0WG1IV3h6eHVFWEtudUxUM2dONnVRd1o4TklK?=
 =?utf-8?Q?Rpe7/WZwS4lD5diCFMF+k4ntp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8170B3658E737142B0E6745DED388C51@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a84442-bbc4-4ae8-423a-08dd47562466
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 09:02:25.9580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JIbZS3hdTg4Hn0YSZqZHKAdCN/dgnF1AfedTpG1MmLNX5vyr7tfEPAXmvqe5gF9RyReQBtA8AF7ihBUfFzA9mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6143

T24gMDcvMDIvMjUgMjoyNSBwbSwgTmVpbCBBcm1zdHJvbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgDQo+IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDA1LzAyLzIwMjUgMDQ6NDgsIERo
YXJtYSBCYWxhc3ViaXJhbWFuaSB3cm90ZToNCj4+IFJlbW92ZSB0aGUgY29tcGF0aWJsZSBwcm9w
ZXJ0eSBmcm9tIHRoZSBsaXN0IG9mIHJlcXVpcmVkIHByb3BlcnRpZXMgYW5kDQo+PiBtYXJrIGl0
IGFzIG9wdGlvbmFsLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IERoYXJtYSBCYWxhc3ViaXJhbWFu
aSA8ZGhhcm1hLmJAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gQ2hhbmdlcyBpbiB2MjoNCj4+
IC0gSW5zdGVhZCBvZiBtb3ZpbmcgdGhlIGNvbXBhdGlibGUgc3RyaW5nIHRvIHRoZSBvdGhlciBi
aW5kaW5nLCBqdXN0IA0KPj4gbWFrZSBpdA0KPj4gwqDCoCBvcHRpb25hbCAocmVtb3ZlIGZyb20g
cmVxdWlyZWQgbGlzdCkuDQo+PiAtIExpbmsgdG8gdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3IvMjAyNDEyMTktbW1jLXNsb3QtdjEtMS0gDQo+PiBkZmM3NDdhM2QzZmJAbWljcm9jaGlwLmNv
bQ0KPj4gLS0tDQo+PiDCoCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL21t
Yy1zbG90LnlhbWwgfCAxIC0NCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMv
bW1jLXNsb3QueWFtbCBiLyANCj4+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
bWMvbW1jLXNsb3QueWFtbA0KPj4gaW5kZXggMWYwNjY3ODI4MDYzLi5jYTNkMDExNGJmYzYgMTAw
NjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL21tYy1z
bG90LnlhbWwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMv
bW1jLXNsb3QueWFtbA0KPj4gQEAgLTI5LDcgKzI5LDYgQEAgcHJvcGVydGllczoNCj4+IMKgwqDC
oMKgwqAgbWF4SXRlbXM6IDENCj4+DQo+PiDCoCByZXF1aXJlZDoNCj4+IC3CoCAtIGNvbXBhdGli
bGUNCj4+IMKgwqDCoCAtIHJlZw0KPiANCj4gSWYgeW91IHJlbW92ZSBpdCBmcm9tIGhlcmUgdGhl
biBpdCdzIHN0aWxsIHJlcXVpcmVkIGluIERvY3VtZW50YXRpb24vIA0KPiBkZXZpY2V0cmVlL2Jp
bmRpbmdzL21tYy9hbWxvZ2ljLG1lc29uLW14LXNkaW8ueWFtbA0KPiBzbyBwbGVhc2UgYWRkIGl0
Lg0KDQpJZiBtb3ZpbmcgdGhlIGNvbXBhdGlibGUgdG8gaXRzIHNwZWNpZmljIGJpbmRpbmcgaXNu
J3QgYXBwcm9wcmlhdGUgKGFzIA0KcGVyIENvbm9yKSwNCmFuZCBpZiByZW1vdmluZyBpdCBmcm9t
IHRoZSByZXF1aXJlZCBsaXN0IGhlcmUgZG9lc27igJl0IHNlZW0gcmVhc29uYWJsZSANCnRvIHlv
dSwNCnRoZW4gYWRkaW5nIGFuIHVubmVjZXNzYXJ5IGNvbXBhdGlibGUgc3RyaW5nIGluIG91ciBE
VFMgZmlsZXMgZG9lc27igJl0IA0KbWFrZSBzZW5zZSB0byBtZS4NCg0KV2hhdCBjb3VsZCBiZSB0
aGUgc29sdXRpb24gdGhlbj8NCj4gDQo+IFRoYW5rcywNCj4gTmVpbA0KPiANCj4+DQo+PiDCoCB1
bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQo+Pg0KPj4gLS0tDQo+PiBiYXNlLWNvbW1pdDog
NDBiOGU5M2UxN2JmZjRhNGUwY2MxMjllMDRmOWZkZjVkYWE1Mzk3ZQ0KPj4gY2hhbmdlLWlkOiAy
MDI0MTIxOS1tbWMtc2xvdC0wNTc0ODg5ZGFlYTMNCj4+DQo+PiBCZXN0IHJlZ2FyZHMsDQo+IA0K
DQoNCi0tIA0KV2l0aCBCZXN0IFJlZ2FyZHMsDQpEaGFybWEgQi4NCg==
