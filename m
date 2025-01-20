Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E862623A9;
	Mon, 20 Jan 2025 04:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737347442; cv=fail; b=P7GNziUyhvCP2q7H0XFLtAj5Ej16trtFjwXh199HRIfjKNFW5GRVlB6p+OEEhB8Go+X5FboIBvdXl+4xrtqeXbmM/OUr0hOC6mfj4WgU0Bw2xDRUpNOKwFkQRknFYwqT4+ZpIc9Ome/NxySHKwvqoEV9tN9NEu47yFiLf5/KKjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737347442; c=relaxed/simple;
	bh=dBregWvodou3loCdAyOKDcOQIakUc75qWvEh/Ag3wy8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NDvhsKCL0+ZhcdVQ4Ht5+s7B3PyvddgzmKm3kdTr9uSB5VmaFJUQk8h0zP2JYrh/E9c5YgUvHtmZeYA7lTitTI9XtdNXNeycWBrytBNsKUVQDZyLt5God1/2Vhc7xQhttwTg1PT3LcpfWOHacI8cE7aCbhAlN1L5HAG69Ez948I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kdP4ozjV; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kdP4ozjV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0w2K4or8hXaSuuXHrxVDWVoP9S1Se9P2LpUeLqig+JIkDdCQgS8TqS+ZyVylqhgc1TjTMLHM7+PMg99bTrlQ4Yb5/tIZUc+ItHy0OUSIaD8W49Qsu7kqgG+bO6yG6q7M2POOiY1n44JhYH5cz8/eoMqGeCinRGo3guO70pSvuzQNVAzfsPQvZSxwsbfQQk9G1HGgx7GyNY5NhQFoXjQL4UYJaPrUFQwDIp0PngKgT03IINovebvTvwNacy9iJpnanbCj2QhmWGAYr0vkgG/5fm/i6TCwd6b/lOGb36lyc3vzE1bbyVjKzEjdDEibtxe+rnoKu7pWCvF3ixGu2znbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBregWvodou3loCdAyOKDcOQIakUc75qWvEh/Ag3wy8=;
 b=Afsf53serrqBiBuCu/yybukQY+cGFwps0Q/UsmqBpI0BsZCOa01eRWB5REBO1/U7ngkXFE11BCBzT9f4YYFAZyrTrpyfPQ+PkyD8K4oGRUQxxLu7O87wSNz/qHYR1i9a2G/eYTdCCHOgyo7e7rrPFlwUhVIugcOsSU2WQ77JLzXeAKRIz+PvOa9Jyq07Qeu7ju6ZOJZdLbXtY2ulULv7H+GSbbQL5MN4L3P3gDTmSTtrb2AniM5WoAQN6qbodG9ofy1JQrITI5+Ew9ThNykqZkakW8QTCuf3uAUofiEwxw4rf0pssQmrcfC5BbEYgmuehERRXJZzpQLDlddR/8fJ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBregWvodou3loCdAyOKDcOQIakUc75qWvEh/Ag3wy8=;
 b=kdP4ozjVZZ6RQRCdWBfKkHoOft9Uw6uRh/x2hVP9jfFefy2UNJY6wpiP4arPjWFaH5+GPnMS7GD2m80IHmNjHkm1YoanWGmNPMb0Vf2IByJt6dH56leOYJe9/QvMkgQfPc80X6fUVXRn6V6zLjzMQaErblB3oUzAkDMp/LjJdLJs7ZNamS8MZipTZWBoZseh4O2OyfAy90aoW4BFDUTMd/6O16ghaztDdJ79hNmEeOQfPb2/Gw4DS/acizcTznOJj3E8UHV/dNox4ZKtE2nbRLqvE43UUWgRRsTAeyXBPqJ9XdyS8DHHFUAhldQZo0nfIYJQXnLjIKE1BYGtYsEh5Q==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by DS0PR11MB8738.namprd11.prod.outlook.com (2603:10b6:8:192::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 04:30:35 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%6]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 04:30:34 +0000
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
 AQHbUcwFXFHAxHVg1UOmapSBwIyZUrLuAKyAgBzF3oCAAR0SAIAAbuaAgAEpg4CAEch5gA==
Date: Mon, 20 Jan 2025 04:30:34 +0000
Message-ID: <779651f3-e5d4-4de8-878a-84653735e5cb@microchip.com>
References: <20241219-mmc-slot-v1-1-dfc747a3d3fb@microchip.com>
 <20241219-scenic-revision-17da9231d61a@spud>
 <91dfdd42-6ddb-490f-acda-41ce55782959@microchip.com>
 <CAFBinCCxZjuXL0duy3ePPDtL1oJS_GZiX3=djXpHR+-6gLkN_w@mail.gmail.com>
 <39be0bea-c207-4bcd-b464-ca93e91cec93@microchip.com>
 <CAFBinCAO0bpd7PXaVJWMby4Mqj1On5DaqNZua4V3gPUDms8=LA@mail.gmail.com>
In-Reply-To:
 <CAFBinCAO0bpd7PXaVJWMby4Mqj1On5DaqNZua4V3gPUDms8=LA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|DS0PR11MB8738:EE_
x-ms-office365-filtering-correlation-id: 87555966-f71f-4264-0ac9-08dd390b2eba
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OXNmTFoxZFBBVFlMOENEUUZKVHV0WGhXaVJTeTFibnBKWXlhYkV2TnVXTFRZ?=
 =?utf-8?B?OXV0ZFZZbWhsMEFQc3U0TzVGVllFZDF5TFQyZ2lCcDZURjF4UmdBdXJTZE9E?=
 =?utf-8?B?QmwxZkwveWJsN3k3czNwV28wVEJkUWoyYXpPaXR5aE5lejV4RHNiNnNrVk40?=
 =?utf-8?B?d2o5N1h5clkzb0NKcWFKV2FOZExyZi9aQjQxQ1ZWL0NCWWw3N1VDTW5hWURG?=
 =?utf-8?B?aTJBWkd1UzN2VndrQ3lGK0huYXRtbnFLOGdGZStzNk1BV0R5NnBVQ2g1R1NZ?=
 =?utf-8?B?OFNSR2lHclJlZVdObU42OGZqU2dkUElpbnpjSHV3dExQNENyTG9wZGM0T2JM?=
 =?utf-8?B?YnZkLzVlbG5rQXZPT2ZCdTgyOSs2c2dwOWVqczhZVUVvb25yN0lVRENtTk1J?=
 =?utf-8?B?ck5hNWxoTjM4VHJIenlZK3dCViszSS9KUUlrRmtoSStuZStwdDB4cGxLTUEw?=
 =?utf-8?B?R0VxV3FlWWJSQkpxcUwzajlZSkc0TGJWYU1GR3lwd0NDWG9pbEQvbWt6by9m?=
 =?utf-8?B?WjVpWFMzQ0xKdjErVUdTNHRObFcwRkRLb1RUWjhCd1NmTzhScmFvRmFVaHlM?=
 =?utf-8?B?cVluQjNSVWJ5bjUwbUVERlR6eUgrVlVBZXQ3ZlltbWJUcHdkUzhZNzI1WUlY?=
 =?utf-8?B?Nm1jVXNqM0JQTnZSMU9Rc1MrazhOTU5QT1hSUkxTSy91b2g3M2JkSkZDWXIv?=
 =?utf-8?B?YnVuL0gzbExKTTNkbThnWC9aYk5RYndpRGRlMUpQVDRId3hXV3daVmZIdHFF?=
 =?utf-8?B?UGI3T2loNGxBRXI3L0U1SHJadHl0YTQrY3Z6d01CTW8zbXU1ZGFXTTBrNXB3?=
 =?utf-8?B?Q3NkMU5ZVm5GNmNwV1FXNHRQSVFOdlJVSk5XeUMyUW1WUmxhT1oxQWNmdDEx?=
 =?utf-8?B?eWtTaHJNL2ZETzN0bDFEYm4xT01wVEdUSWNSd0NIWEJRMjlQS1FvWWdJb0xJ?=
 =?utf-8?B?VVRORHc2WWlsZkFuUm00citpaGFNZkR6dXpUb3pzNllkV2k2MzJ1MmZBTzZz?=
 =?utf-8?B?bzhSNnl5NXVtWVVnSHZIeDZheldPK05ZMldUelZpMnFFclk1YlJBZ2N5TWta?=
 =?utf-8?B?L2xaM3hUQTJpajNxYzFDTjVMeGRSVGZ0aGlLbmN5ZGVzNzhtQktuOVNaRXVj?=
 =?utf-8?B?UnVhYnIwM3JFTHYzS0l3STRMVHJWRlVFOWd1UDRiOUVXUDMrcDgxRkp6Qjha?=
 =?utf-8?B?TnNLN2JmRU5VY0V2VzFtczRZdXM3MVJLMUNhMDB1NW5uM3hXM2k5UUkwSmNV?=
 =?utf-8?B?cnpidFZ4Wnd4NHJ5SXRadm9lSXllU1h0OTlBOXlac1VYR2pqTnJVbWNjeDdp?=
 =?utf-8?B?cHFMWXJjbythNlJBNFh6ZitKSjRDc0EwWEpPMHN5dHpPcmVFaXk3SjlGUEFV?=
 =?utf-8?B?NFIzWVJwMFVhTWxKMjFtdzhSRE5DV0FrT2pSckVtUktvbUlrcjJNWjFTeCt4?=
 =?utf-8?B?bFErbXoxRHhFT1hsTm5ZMnk2cWNXa3piVnpDNU9INDh4NkdTQnZIeVlTdmZX?=
 =?utf-8?B?NlhqbytMa3dVRjNvSWNYMDFxQlYrbEgya0NIRGg4TVQ4WFY3TU91RXM2bVhN?=
 =?utf-8?B?TjVYK1RLUDZvWncrbDM5VGpPczhGK2cyMXdVOGlHWkE4eGZKRjVlZEdJSEJy?=
 =?utf-8?B?VW5XZDdja2pTbjFkUGwzZkt5bCtENU5FYWY1Qjl4OEgyTjhNSUxzRnc2RjB5?=
 =?utf-8?B?d1lRR3hoWUF1bW5hbDVpNm9HZmNwLzdkNmZUa3U1aldEMWZmeGVpeFlTYnpy?=
 =?utf-8?B?MzRWRUZBUzNvcE1rQ1M5aWtxWkR0eU9QUDNhVi8zK2JBTlhySWJXdy9WbUd4?=
 =?utf-8?B?KzVQSllXamhEQUljK3FKUTJCSmd2eHN5NnJvMnFpUWVrY2Y2NFFLRGRhTlJk?=
 =?utf-8?B?ZUdrbTYxZnN0U1dQWWJUaEdSR20rWHpQY2NjVG9ROTZnaGh3RnRhdmtpWmZu?=
 =?utf-8?Q?XDRrM3Ca6sBnAhu27cXZOKjkYt4xZZlw?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YkdaWFN4REpGR1dPcVJlYWVSbmw0SlFQaXRBeSt5cXF4ek1BRTNURmF0UFNW?=
 =?utf-8?B?Y0tDSlJpT1FVcHBPY2Y1UXN1dVN6djZxWXhxeHVDU3RlbWVObzlVWWhEUGw4?=
 =?utf-8?B?NjFjTFd5UUtYZ1NpcVJmWXBZclBXMU1DTjEvbGc2Nm5nOEpkbG5YOUhlVjFE?=
 =?utf-8?B?bDJoaXNYNWxzYnYvNjE1d21PaTh2blhoZmpWWnNDVndRZWE1UXRXUFpza01Y?=
 =?utf-8?B?aStkUmVzZzNSbm5SSlpXK0hrWjV3Q3h2U0RpTjFsZG1lMHdNTlIzZjh0K2o5?=
 =?utf-8?B?WjdwS1ZGcmRJUWV4c0loM2ttUkRPTFR6WE5ucTFwclhwcG1NMnh5SXJlSVNx?=
 =?utf-8?B?dmJxVkFOOE9MNEc5RlJzWHJmZkoyVnJRSjVQa3BBUXE5QzZCV2hkODBDdVR1?=
 =?utf-8?B?a1VEK0ZNV25wSVR6SjF1dCtjbEdtNnJCNWJRK0c0aHJiVURaNkpQSmhzWHFI?=
 =?utf-8?B?OTFuRTR1MlExOHdVRGNLcDZMRWJLZ0R0Mkd3UWptaVMyYnFXY3N3eFRuZTgv?=
 =?utf-8?B?OVU1d1pwZHV1aVhveS9GWmFsRUc5ZnVGNzFkVEhSUEdubHc3emFoYURNZlY0?=
 =?utf-8?B?RUZvcGFFa3plOGVvQzVMcXFjdDJtallXSXljaEYzYk9kZ21jSnVTcVh4QXR5?=
 =?utf-8?B?VGt5RXVPamZtQ1dsa3hFRGRHZlU5dVZUeGJ3UXJodHRZVWdwRmVrZDNBTlBL?=
 =?utf-8?B?Z09MRkl5VXllOGQvcW93RlhuSCtVMTZEdTJLdXprbitwNzNVWHV2RW9WWXBM?=
 =?utf-8?B?SkF3YWFvOGRMcUFkNzhHR2ZnYWtWMVJVOTF5VmJKMUJyM2xuZUp2MEFaUldj?=
 =?utf-8?B?TXRDNTloTkgyVFZSZllpTjQ2WlFjOHhTVC9yTTU5bzh4WkNRRlpXcEpjaTgz?=
 =?utf-8?B?TzVveVkyMjV6eDJ0SmxXaDhkQWkxMHdxTEV2WW5CL1JWaTdEQ0FnT0dYYUVj?=
 =?utf-8?B?cFB6K3EzZWVRaUM4aHdqNVNiakhEbG5STk4zcUtsNk02WlhvSkNMdUpQQzFL?=
 =?utf-8?B?eHFFaE1odWIxVVh4ZlY4REZ6cnlhSDVxWW5EWWpLREU3UGMxZFpkWi80M2xv?=
 =?utf-8?B?bUgyVjlCUk5QT3kxZUhXc1dsNDRQWVNwOFpQRHpxcDlWZXBUT0JCTWdDUWYz?=
 =?utf-8?B?dlhPUVRnNkJ0RjU4bmlQbjRQMEZJbTJCeFRGTndVZjd6Sys2R1UyYXA4K0FT?=
 =?utf-8?B?NkZXVFVRWXhHeGl2VU93cHNYTUc1YWJ2ejRwaXNheHVvQ01hTmQzU3hjV3hy?=
 =?utf-8?B?SXNMQXdvQ2VsMG1Kd3dVQjJNWXNZallabEYvZk9NRXVxK2V0Y1pVZU9MSisy?=
 =?utf-8?B?aEwvQld4eHpCWEFRd1BIdE96ampRUHl1L0ZEbG5lZ0lTRkF6THJUbnAydkMz?=
 =?utf-8?B?dEh3SHJiOENiZ3lUa3g3MEx4TklsZXJONWtGTDJDa0o2L1JUeXBkYkFwNWlV?=
 =?utf-8?B?d3ZWMnVhYzNyOEZHWFRZNGVhOU9vWHZUd1lndUFOY1duZVpLWG9ONEdNcVJX?=
 =?utf-8?B?dFkzRkFkOXhHRm1QSDVvTncyelJWb2IwMENpL0M4OTVVK0k1bzluNzZmWVdS?=
 =?utf-8?B?aHFSTHh1M1pKcm1QMmlBVk1ZWWhCaVZNYWhFbGRsSm9SMUhsUkM0OWkxSWpK?=
 =?utf-8?B?eEszRFp0MytKR1NXVENLdFZ6bW9TcGRIMG1MWHFBc0pySWV5Y3ZFdG9ZZTdR?=
 =?utf-8?B?Q3pmTWd6Ym9qemwrQy9RRzBhUFRNbzlVTnJtdEpQME9CbDh2ZVA1YURDWjJQ?=
 =?utf-8?B?eUkrM2ZIRXA4NWlnUGJnb0RRK21DT05DNCtaZkxWWm4zTFowdnZkRDAzejhK?=
 =?utf-8?B?elJ5b1gxSkNzbjJHK3M2YzQ1NG9HcWxIVnlTemxCbDFMMXM4eWs2T1I2WC9O?=
 =?utf-8?B?b0d6S0pHdHdmaTJhWUlFZW13QXRxKy9LanpwTlFKY3hVbFZlWm1QSkhuTVNE?=
 =?utf-8?B?MyswYkE5RzhSaysxWldxNmdTSVh6RlVVYXZYVW5ndyt0M0Nzbm8xN3c5WGJT?=
 =?utf-8?B?eHpDL3dpUHRCeEw3M3VxWEo1cVVmT0NjMHdOcnJ3TlhJNVVLK0hkSHBXeTVn?=
 =?utf-8?B?U2kwR0ZCQ3p3eWxFYzdHVUppZWc5QTZyQWNvKzM0dmlCWSt6bjZoVnRmL3ND?=
 =?utf-8?Q?xQtpD+KnzlRdDO38KJtGbNgcR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B2EBE9A7A799F45B17E098E24FD6277@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 87555966-f71f-4264-0ac9-08dd390b2eba
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 04:30:34.7666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GFpJV/Qd6URePrDHZmxTEf8eFf9wJIKisrV8LA6as51JMDqW/JwFMFheo69K6/YqASbUQIkMYYiIzaounw/v3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8738

SGkgUm9iL0Nvbm9yLA0KDQpPbiAwOS8wMS8yNSAyOjI2IGFtLCBNYXJ0aW4gQmx1bWVuc3Rpbmds
IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpIERo
YXJtYSwNCj4gDQo+IE9uIFdlZCwgSmFuIDgsIDIwMjUgYXQgNDoxMeKAr0FNIDxEaGFybWEuQkBt
aWNyb2NoaXAuY29tPiB3cm90ZToNCj4gWy4uLl0NCj4+ICJPbmUgaXNzdWUgaXMgJ2NvbXBhdGli
bGUnIGlzIHJlcXVpcmVkLiBFaXRoZXIgdGhhdCB3b3VsZCBoYXZlIHRvIGJlDQo+PiBkcm9wcGVk
IGFzIHJlcXVpcmVkLiINCj4+DQo+PiBJbnN0ZWFkIG9mIGp1c3QgZHJvcHBpbmcgaXQgZnJvbSAi
cmVxdWlyZWQ6IiwgSSByZW1vdmVkIHRoZSBwcm9wZXJ0eQ0KPj4gaXRzZWxmIGFuZCBtb3ZlZCBp
dCB0byBhbm90aGVyIGJpbmRpbmcuDQo+Pg0KPj4gSSB3aWxsIHNlbmQgYSB2MiBieSByZW1vdmlu
ZyBpdCBmcm9tIHRoZSByZXF1aXJlZCwgd2lsbCBpdCBiZSBmaW5lPw0KPiBGb3IgbWUgdGhpcyBp
cyBmaW5lLg0KPiANCj4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IGlmIHdlIGRyb3AgdGhlIGNv
bXBhdGlibGUgcHJvcGVydHkgY29tcGxldGVseQ0KPiB0aGVuIGFueSBjb21wYXRpYmxlIHN0cmlu
ZyB3aWxsIGJlIGFsbG93ZWQgKGZvciBleGFtcGxlOiBjb21wYXRpYmxlID0NCj4gInJhbmRvbSxu
YW1lIikuIFRoaXMgaXMgYmVjYXVzZSBtbWMtc2xvdC55YW1sIGluaGVyaXRzIHRoZSBwcm9wZXJ0
aWVzDQo+IGZyb20gbW1jLWNvbnRyb2xsZXItY29tbW9uLnlhbWwgd2hpY2ggaXRzZWxmIGhhcw0K
PiAiYWRkaXRpb25hbFByb3BlcnRpZXM6IHRydWUiLg0KPiBIb3dldmVyLCBpZiB3ZSBhbGxvdyBp
dCBidXQgbWFrZSBpdCBvcHRpb25hbCBpdCBtZWFucyB0aGF0IHRoZXJlJ3MNCj4gb25seSB0d28g
dmFsaWQgc3RhdGVzOg0KPiAtIG5vIGNvbXBhdGlibGUgcHJvcGVydHkgKG9uIHRoZSBBdG1lbCAv
IE1pY3JvY2hpcCBTb0NzKQ0KPiAtIGEgY29tcGF0aWJsZSBwcm9wZXJ0eSB3aXRoIHRoZSB2YWx1
ZSAibW1jLXNsb3QiIChhcyB1c2VkIG9uIEFtbG9naWMNCj4gTWVzb24gYW5kIENhdml1bSBUaHVu
ZGVyIFNvQ3MpDQo+IC0gKGFueXRoaW5nIGVsc2UgaXMgY29uc2lkZXJlZCBpbnZhbGlkKQ0KPiAN
Cj4gUm9iLCBDb25vcjogY2FuIGNvbmZpcm0gdGhpcyBvciBjb3JyZWN0IG1lIHdoZXJldmVyIEkg
Z290IHNvbWV0aGluZyB3cm9uZy4NCj4gSSBob3BlIHRoYXQgeW91ciBmZWVkYmFjayB3aWxsIGhl
bHAgRGhhcm1hIHdyaXRlIGEgZ29vZCBwYXRjaA0KPiBkZXNjcmlwdGlvbiBmb3IgdjIuDQoNClNo
YWxsIEkgcHJvY2VlZCB3aXRoIHYyIGJ5IGRyb3BwaW5nIHRoZSBjb21wYXRpYmxlIGZyb20gdGhl
IHJlcXVpcmVkIA0KcHJvcGVydHkgbGlzdD8NCg0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4g
TWFydGluDQo+IA0KDQoNCi0tIA0KV2l0aCBCZXN0IFJlZ2FyZHMsDQpEaGFybWEgQi4NCg==
