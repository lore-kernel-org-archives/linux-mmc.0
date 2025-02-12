Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C611DC9B0;
	Wed, 12 Feb 2025 03:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739332314; cv=fail; b=oVM/dtGvHGPeceebQ2mr385d1tGt5cRSPr6RnDRkhfwjIEOV4gUdwzBCYFihz30+nMt4Q4bS/ocBXjFkULNsneBRPjdy0w9luRmTp8Gm2Dx8SCsDhbKUoVfz75eV2cb0KsJHZ892WTLnHWFcsx0+MM0hJuiYDMSE2NmyDA9/73c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739332314; c=relaxed/simple;
	bh=ZDAMKQk9oLNXwnN3umYQXCld4vnE4qVZGlpjgFr/Prw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ellnx7P9FiD9qXVWppHd3JFamqEWgy+dIO13qFWN2wd8hFZbMMqNLYG9preLlyvrgy1JZDSZ7shTjVqX6IGFnj7LTD8HxFCJQWwjAWTwlK4kbsY0wDryhnD9qBKiT/yNjSRujIjEPdreJAO3m/UIYk8cFFw6CgGSPRmy+dDMlaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=L2DHwUSl; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="L2DHwUSl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qivZbFEmQrD7rkP8TzTncyUvEn7oKUgr642TuD+AbLN4Sdydif4WZA0CLi4m1HiwApBtTAhLgvjkV4mixof5u1UefFdmWT88CftgUliTCdWn8YkLJguVedNy7Q+SeqL/W71GaB9E0qAGDKv2giWNDDCgnYvN6MZLoAr2eYgKGJcHbIADofjFbRmqKPc90l3oTbYq6E7Ge3GIYM+5b355AjAhn91D6mi8ZfKRyktokm8R0piU7cB7EuIdgrMX7oRnhlnVh6XDBQOiXmdsjfwOitwNleyKypB9ekCMO4jdlspBRBi9pLfRMXp19ZjmTpm9h6ik+fHg1BqjLiKcmBhTNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDAMKQk9oLNXwnN3umYQXCld4vnE4qVZGlpjgFr/Prw=;
 b=GhMUHdPPpx0XczXCu1TqUaVxlc5ErDBmYRx7xd6r5zHvATT9vgwXgg2kPgpY4PoFH8si9T72oqXIEPIOW0G89zENiCtCer9gybDzeMrbU4Od5BVr4u7iv9bqPzr35PKEh+LAC5C8p2SEUNjfAsMG4SSwFuOQpnU9bWIBpP0iUp8QCHN5I+HxhbRd6LGZgnvPuvIdn8USXrDz37hSKO2+JbJn61gNBG3WMgmu5XQdfb8YlXhtgMbZNcZWscWMGQTzhqK+dWKCRZFHw4PqgYJ7k6nMMQpKtKKBfNA4VOAjl65NoblEkCepUH4wsyyu/UkNxH+EgEAT0JYw3KkYui47Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDAMKQk9oLNXwnN3umYQXCld4vnE4qVZGlpjgFr/Prw=;
 b=L2DHwUSlg6j4CX3c+iOn8nhJ9h9xcLi+6WMLsD31okDmkpsfTAT8mGCQx1sQD8qeOLx7cb3NwJD/BGYDDL63T7WV5bGyCkeG9ytyKQlyvFTfGhNMWcQyF8tz5OKrxmkOVo7Rov9wPDwSfmWltqwZIDIrscsjVsG+DLHBwzK1oDsepcL7FC21mSoqN0LTL6Rs467Ae3+dgXMcm/5kuZ4CDMefXNCsvzsNTxnBlPdnNdzSYtcw/l2oDnQ0Pa9ltzwGnXzsTs3hz2LFkedXwzOW2fYdoysRSYkc8nsRyxcY1GmzIgRGbrdN1eKfj4R1CFdccUIPwosJEEkyt1RCFsOAmg==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by MN2PR11MB4535.namprd11.prod.outlook.com (2603:10b6:208:24e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 03:51:49 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%6]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 03:51:49 +0000
From: <Dharma.B@microchip.com>
To: <robh@kernel.org>
CC: <neil.armstrong@linaro.org>, <ulf.hansson@linaro.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <khilman@baylibre.com>,
	<jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
	<linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2] dt-bindings: mmc: mmc-slot: make compatible
 property optional
Thread-Topic: [PATCH RFC v2] dt-bindings: mmc: mmc-slot: make compatible
 property optional
Thread-Index:
 AQHbd4DiJT/2q7h3vk+co+F7jIgTKLM7jO4AgAACEoCAAAQ2gIAEdwIAgAKJVACAAIBUAA==
Date: Wed, 12 Feb 2025 03:51:49 +0000
Message-ID: <a04124a9-2bb8-46be-8e9d-e6f70c63f3bd@microchip.com>
References: <20250205-mmc-slot-v2-1-da3c5f30e2d9@microchip.com>
 <f6d7ffa0-6c08-45fb-9153-5e4aad1ca86a@linaro.org>
 <003ffa44-c88a-4234-a54a-50cd1140982a@microchip.com>
 <7180babd-302a-4f86-8770-bdd9f5c773cf@linaro.org>
 <7de20917-3176-4e80-8ccd-9c01c037cc9a@microchip.com>
 <20250211201230.GA600687-robh@kernel.org>
In-Reply-To: <20250211201230.GA600687-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|MN2PR11MB4535:EE_
x-ms-office365-filtering-correlation-id: c534c54a-acc2-4bdd-f5f5-08dd4b18943b
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?clVVZ3hoN05wa3hmWHhNRzFEVytXVHhPRG1CMnFpNWpaVmNLOWxteVduN2Fz?=
 =?utf-8?B?aWpXREI1Q2hnejhNaWU4VWpuWm5Nc3V6WERjajBldUIvMk5OaU05eFBiaTdN?=
 =?utf-8?B?ZnBsZyswZzY5V1lyZVRFU21qaVJUTUVjRUUxSGJqenVYQi9BM2tvaFM5Vzl2?=
 =?utf-8?B?dU1TUHl3RzdUQ2xwZVpnT0ZZMkliM2ZzbVVRMkwzSDdTeHdXbEZwaG9UY0pm?=
 =?utf-8?B?TXJXS0FBR1BCdU5ESG42dExWU2JwNEZucVFTL1JSZitVZCtmcWxCQjhuSW55?=
 =?utf-8?B?R1dqRURSeGFzQmNwMjY5ZXFseDk0NkFQeldmZU1WRWhjODk3andMNVc5ME9R?=
 =?utf-8?B?TFhQRDlIdk5lYlRRNjYxY1ZDaXRYODM3VFU5cmVWMWp3MWl0SzRRdWhtR01l?=
 =?utf-8?B?SkRvMzBsMWNneXR1Ymdod2FabUk5dEo2Wi9taWFadGgxWUxaNDNIZTFtbFNt?=
 =?utf-8?B?OHBlUmVabGFqWXFZV0hhSWhha3ViYmdxRVpzWFQxZUoyRm9iVFNzaDFsUFpv?=
 =?utf-8?B?dTlPYm9DbjhtV3VyQVhENGMwYXJnNEJTQ1hGNldVcEozK0cwODRaUEdTeTNv?=
 =?utf-8?B?aWxHSGwvK3ZSa1pjdUZHRDRENVh1eENrYVRBa1hlWDVXTllUNllYbktTNVQr?=
 =?utf-8?B?V0dvdlpKVXpSZk1XbE1vVjM3eG1USHFJNWl4dlZub2J1UmdoSDRFYlVpRzcw?=
 =?utf-8?B?UGx4MGhoaWhuK3k5QXhSK1Z3aHk0RXRTSzVuUVE0cG5xSU5vNStYWWlDMGNw?=
 =?utf-8?B?UlN2aEZwZm1iZWk2L1N0NFp6aTk2TzF3cDJkN2lKQlRqM2ZuYno1Z1laa0lZ?=
 =?utf-8?B?S3lSV2tadkxhaC9Ca0puZjJHdUJGSGlYWXRhSTlKdkpFVFJ0ZlVSR2xhZzBN?=
 =?utf-8?B?cWhua25xV3VSWWcva2RqVEJENGZDa0hHZjFKai8zRW9NNkxJTGhuTTZ5QzZR?=
 =?utf-8?B?NTdYWEVQZHlaMCt0b3g0QXBUcHNmOUJkM3ZyZnM2bWlORlRPWlBuQzNRUUZP?=
 =?utf-8?B?a1NoOUYwdk5DVTZBbTZGZC9RUW8ycEMxY0d5RjJWWVhJOFFwUWRQVWdTaFRP?=
 =?utf-8?B?ME1rbEg3bXZJSnNiRFpJOVNJRG5UeUh2TDFrMjljY0ZBVnNYZXJTQTNEcWI1?=
 =?utf-8?B?NUpwWndjbzFWNTBXNm1Oa2pFWTg2R2FrbFlGOG1jQVNVVG51dGhlRXhuNzZo?=
 =?utf-8?B?anY1RUtSOFdIcS9QN1dRMkxiNnkyT3VpbkRSSFdyUzBvNGZOenNtcmlvWHhK?=
 =?utf-8?B?NjdYbVh2OUhzOGlLRU9GZWd5VmRBcUdBVk44QUFkUnROYUVrU1BZeURsRDdt?=
 =?utf-8?B?TDJkdnpnWDEwdHlhYWo1NFhMVUkxdGhHRmNlR0ZiOEZ3Z3FrVUNEcENoZlVW?=
 =?utf-8?B?ZVUwbUpjbmNTakhFbXJwZy9WWXlUWWpyaUxldEduNmVYQXNlYmhyb3RjK2tq?=
 =?utf-8?B?ZHFqNHR4YlRyQkVLUkxxSERWOUlHRjlucWRUdzdISm5ZM3NTS05CejVPVXlD?=
 =?utf-8?B?eUdwRHczNnk1MEUzVGhyc3IzdFR5bXRWbEY3UEkvZHhRVlJwbzA1MC92RVpM?=
 =?utf-8?B?VjU2NjA0WXZJb244ZVp2ZVlUM2kwcjFESlJaY0djZ2xiUkpaSFBWQ1VqZ011?=
 =?utf-8?B?SjY0ZlM4Si9JWlR2UmVFKy9OUzlxakRsS1lYVjArRGVLc1Z1bGZQT011WHVK?=
 =?utf-8?B?TXNESlcwcmQ1My9UVzZ2aFNNaC9UQ3J3MDJmcjQ3c1NDY1ByOUcrbDlnWTJ4?=
 =?utf-8?B?QmtFVzFHc0oyU0FSUlF0WnEzY1ZSUFFIaXY2RFNuaUdtR0phQU5VZlNvQkJZ?=
 =?utf-8?B?RlEwVGl6YzNCZjlIWi9IRWhCakFtUm1QK1ZsY05ST0JWZTJVc2xGQ3FvZ29X?=
 =?utf-8?B?Mlkzem14QnphbEt6azdSK2xveXg3bkwxY0lidTExWWgvQmR0d1NFVkU1ck9a?=
 =?utf-8?Q?LyUv13nDZO2OUvFVxKzKMkQ2Z0Qayyol?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUZ2RnVaZ3grSG4wc2wrMkdjZ2VIdEFvc1o1cDR1TnFqU3ZMK3B0T3daVlU0?=
 =?utf-8?B?TVF5Y0w4OE4wZFk2b3JObjR6Y0JhcHVEem0rcFVtTXpaQlVDTjFPVHR5WDgr?=
 =?utf-8?B?eEZ0ODdaRGNsNko3YTV3ejNhcFNDTU9lWmNycUVaZTlHNGRWT3NsbGJOeVFt?=
 =?utf-8?B?eFNtSWhQeXp5a3JGbEQ4cGdRM1pXbGg4WXBjKzVSUVlOOWJDNjV4TzJRUFpC?=
 =?utf-8?B?K3RpZzZzdU02V2RTR3RKaU9CeWlHRlNIQmMzZTMzeUhTd3FqNXl6QWtVU1Rk?=
 =?utf-8?B?cnpIVWNVb1lCL1l5Syt3YXQzb3pKUVpWTlJKK05raURSZ0ZDRlhSRXlKYTNX?=
 =?utf-8?B?UklKdnBObmpaa3hvZ2pIT2dIWk0rYXZQSXprclJlNGYyTjkwYnp2c1htZ3Nn?=
 =?utf-8?B?N2ZyTlNZQUhrQzFjZUVZaW5VSWVlZlU5TEdzYWx3bGhFWmdTejdUUG5LaWxj?=
 =?utf-8?B?ZHpLR2FXcUVnZkNIVXNSL2lhRE1Yb3p6dFYvcGxsYytmZmUyZVVNYVZlRi93?=
 =?utf-8?B?ZEFGUmZxQ3BhVGJ4aVZQL0dpWldaZ24wVkxZWnZqNkZkbGJBcjFHMnNQdUJU?=
 =?utf-8?B?R3Q1OVQ4aEpPdEVOZ2xscHkvOTY4Ymd1cjVPQnVmQ0RZa3lYY0JyR0dNWFFq?=
 =?utf-8?B?cWpLL3h2S21tZTl1VGNyaXhKVmZSWXI4SktmOFdWMW5nb1NZNWRSV3VrN0VK?=
 =?utf-8?B?bG5QRysrZy92UGExa3J4Rm1ON1NqNUFhUHYwaG1BakJCc2xaSy8xT1hLa0dF?=
 =?utf-8?B?ZGkvcjZLeWtzTkZHRG1LUWx1TnFVOU9NUHB1YlZXMWdSWnlicEFtV3F4aEFt?=
 =?utf-8?B?enRXclBVUTNBdURpS2hyMkRnSDBPbnZXQW9vS1UrQVFTajQ5MGdNQU1HaEdG?=
 =?utf-8?B?UThuU1MyNW5nZVYzNHJ1VU5IU0QrTjBxU3BjWVNRNjY5RE1DczQzem5yUDlI?=
 =?utf-8?B?YVo3R0pjMmxwRUUvdUE4dG0vSGR1VnIxZzJCZGtreWtzV1l4R1lKWldDdDRD?=
 =?utf-8?B?V3AzcEJwUVVsTjB1TjVPcW1SYVRHcVNvYjM3YXhwRHNtU2ZVNGtxMWFNbEFk?=
 =?utf-8?B?T3hmajgxM3ZHOEhIbEFNNU03TUpzZTVYNjRUdzFwM0pYaEwzNUlnc05KZ3RH?=
 =?utf-8?B?U1pWZG5FUGZ3VjVqWFhKZnQ1N0xGbm9BR0hWdlNlM3lWYURwTjVjcHdkb21u?=
 =?utf-8?B?SkdOWXkyMEdiQVlEREMzTkIrOFBTeXB6SzJDREZ4K3FqV1cyZ253MlRUWHA2?=
 =?utf-8?B?T1NPSmlOSkNDemxza21ZMVlhSzBXSUVWeFZabmlwS3p1MW13T1ROK0hiS3Jx?=
 =?utf-8?B?dFVJTXZhZ0pLZWN4aVk4Zm14T3p6ei9NOHoxYTRHQ0d1L1pwVGQ0eGhjOS9C?=
 =?utf-8?B?cmRENThkYXV1b0ZNUG9xaWRsVlRZSUdiejdUblFEanhyZVJ2WjRmNkFMZzZp?=
 =?utf-8?B?NHpnYmVsd0ZNQlhoVWYzVUpTc1BDZnRKQzJUejU3U0lzM0w4K2Z4SmQ0SGo3?=
 =?utf-8?B?K2NzbWVUcW5veHdnUktDTFpNUExTS3hvUWp0L3JrY0REWnF2MDdqWEIwRFA4?=
 =?utf-8?B?a0VBWVRpNE1ZVHJqWnpzdDVHSGNkbC9WbVRBdTZrTjNTNmNTbjBDTm9GazBX?=
 =?utf-8?B?WXBmUFFwV1pydEJDa0svcC9pVHBidnRJaWhQSzJMMXAweFRYckM3cC9KNWF0?=
 =?utf-8?B?SVdGSXd4cTJDQ2M5SXRlc05wbEJSV2IrNlowdlhuVGlNVXFCMTdGUWZ6TmFx?=
 =?utf-8?B?QmhrTFQ3Y0tyd3RETStLRFVzK3J3OW9wb3gwd25SVEIwcXN4bzloK1U3UGpu?=
 =?utf-8?B?SzJ3MGQzNHN5b0t3RjdtUDZoclIzVVJ1d0tmRXBwNU42MmFaZjBzVENCTVQ2?=
 =?utf-8?B?TUpkNy9UMlVCTGtDa09HY0lORm4wSnhXV1cyTm5ldThIYzJ6bVFwODBGR2pr?=
 =?utf-8?B?blFUZStrcHBLWllMMVM5NFVNN2pVajR1UDUwN1dJeS9nZzhEb2RyTHpQUUFP?=
 =?utf-8?B?Ym9Ka0pkcVN6Z1VHY0ZXelBSQjZWV1RjZHRjQmNzc2ZrYmJsOEF0VGtxaDcx?=
 =?utf-8?B?am5wUkpJUzVNdXRpY3dVNklZeXp0WTl1ZmFzZEplTzNudTY3YXRHdUJlcHF6?=
 =?utf-8?Q?X6lCwZPWjypTHqRkRj7seAm8l?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6709100090BB2345B69B0E1B0D65DD7E@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c534c54a-acc2-4bdd-f5f5-08dd4b18943b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 03:51:49.4621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RbcKMjzT2fD7JJDBHRilvZ9yFQh/GBhgYf/LB9z6NbGG01X2kpLske1lmWNO92/Hv6TCr5Nip33nxXtRLT391Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4535

T24gMTIvMDIvMjUgMTo0MiBhbSwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gTW9uLCBGZWIgMTAsIDIwMjUgYXQgMDU6Mjg6
MjdBTSArMDAwMCwgRGhhcm1hLkJAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IE9uIDA3LzAyLzI1
IDI6NDcgcG0sIG5laWwuYXJtc3Ryb25nQGxpbmFyby5vcmcgd3JvdGU6DQo+Pj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdw0KPj4+IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IE9uIDA3LzAyLzIwMjUgMTA6
MDIsIERoYXJtYS5CQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pj4+IE9uIDA3LzAyLzI1IDI6MjUg
cG0sIE5laWwgQXJtc3Ryb25nIHdyb3RlOg0KPj4+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdw0KPj4+Pj4gdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPj4+Pj4NCj4+Pj4+IE9uIDA1LzAyLzIwMjUgMDQ6NDgsIERoYXJt
YSBCYWxhc3ViaXJhbWFuaSB3cm90ZToNCj4+Pj4+PiBSZW1vdmUgdGhlIGNvbXBhdGlibGUgcHJv
cGVydHkgZnJvbSB0aGUgbGlzdCBvZiByZXF1aXJlZCBwcm9wZXJ0aWVzIGFuZA0KPj4+Pj4+IG1h
cmsgaXQgYXMgb3B0aW9uYWwuDQo+IA0KPiBUaGUgZGlmZiB0ZWxscyB1cyB0aGF0LiBQbGVhc2Ug
c2F5IHdoeSAnY29tcGF0aWJsZScgYmVpbmcgcmVxdWlyZWQgaXMgYQ0KPiBwcm9ibGVtIGFuZCBu
ZWVkcyB0byBub3QgYmUgcmVxdWlyZWQuDQoNClN1cmUsIEkgd2lsbCBzZW5kIGEgdjMgd2l0aCB1
cGRhdGVkIGNvbW1pdCBkZXNjcmlwdGlvbiBhbmQgcmVtb3ZpbmcgUkZDIA0KcHJlZml4Lg0KDQo+
IA0KPj4+Pj4+DQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogRGhhcm1hIEJhbGFzdWJpcmFtYW5pIDxk
aGFybWEuYkBtaWNyb2NoaXAuY29tPg0KPj4+Pj4+IC0tLQ0KPj4+Pj4+IENoYW5nZXMgaW4gdjI6
DQo+Pj4+Pj4gLSBJbnN0ZWFkIG9mIG1vdmluZyB0aGUgY29tcGF0aWJsZSBzdHJpbmcgdG8gdGhl
IG90aGVyIGJpbmRpbmcsIGp1c3QNCj4+Pj4+PiBtYWtlIGl0DQo+Pj4+Pj4gICAgICBvcHRpb25h
bCAocmVtb3ZlIGZyb20gcmVxdWlyZWQgbGlzdCkuDQo+Pj4+Pj4gLSBMaW5rIHRvIHYxOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9yLzIwMjQxMjE5LW1tYy1zbG90LXYxLTEtDQo+Pj4+Pj4gZGZj
NzQ3YTNkM2ZiQG1pY3JvY2hpcC5jb20NCj4+Pj4+PiAtLS0NCj4+Pj4+PiAgICAgRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tbWMtc2xvdC55YW1sIHwgMSAtDQo+Pj4+Pj4g
ICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+Pj4+Pj4NCj4+Pj4+PiBkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tbWMtc2xvdC55YW1s
IGIvDQo+Pj4+Pj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tbWMtc2xv
dC55YW1sDQo+Pj4+Pj4gaW5kZXggMWYwNjY3ODI4MDYzLi5jYTNkMDExNGJmYzYgMTAwNjQ0DQo+
Pj4+Pj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tbWMtc2xv
dC55YW1sDQo+Pj4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21t
Yy9tbWMtc2xvdC55YW1sDQo+Pj4+Pj4gQEAgLTI5LDcgKzI5LDYgQEAgcHJvcGVydGllczoNCj4+
Pj4+PiAgICAgICAgIG1heEl0ZW1zOiAxDQo+Pj4+Pj4NCj4+Pj4+PiAgICAgcmVxdWlyZWQ6DQo+
Pj4+Pj4gLSAgLSBjb21wYXRpYmxlDQo+Pj4+Pj4gICAgICAgLSByZWcNCj4+Pj4+DQo+Pj4+PiBJ
ZiB5b3UgcmVtb3ZlIGl0IGZyb20gaGVyZSB0aGVuIGl0J3Mgc3RpbGwgcmVxdWlyZWQgaW4gRG9j
dW1lbnRhdGlvbi8NCj4+Pj4+IGRldmljZXRyZWUvYmluZGluZ3MvbW1jL2FtbG9naWMsbWVzb24t
bXgtc2Rpby55YW1sDQo+Pj4+PiBzbyBwbGVhc2UgYWRkIGl0Lg0KPj4+Pg0KPj4+PiBJZiBtb3Zp
bmcgdGhlIGNvbXBhdGlibGUgdG8gaXRzIHNwZWNpZmljIGJpbmRpbmcgaXNuJ3QgYXBwcm9wcmlh
dGUgKGFzDQo+Pj4+IHBlciBDb25vciksDQo+Pj4+IGFuZCBpZiByZW1vdmluZyBpdCBmcm9tIHRo
ZSByZXF1aXJlZCBsaXN0IGhlcmUgZG9lc27igJl0IHNlZW0gcmVhc29uYWJsZQ0KPj4+PiB0byB5
b3UsDQo+Pj4+IHRoZW4gYWRkaW5nIGFuIHVubmVjZXNzYXJ5IGNvbXBhdGlibGUgc3RyaW5nIGlu
IG91ciBEVFMgZmlsZXMgZG9lc27igJl0DQo+Pj4+IG1ha2Ugc2Vuc2UgdG8gbWUuDQo+Pj4+DQo+
Pj4+IFdoYXQgY291bGQgYmUgdGhlIHNvbHV0aW9uIHRoZW4/DQo+Pj4NCj4+PiBUaGUgc29sdXRp
b24gaXMgcmlnaHQgYnV0IHlvdSBtb2RpZnkgdGhlIG1lc29uLW14LXNkaW8gYmluZGluZ3MsIHNv
DQo+Pj4gc2ltcGx5IGFkZCBjb21wYXRpYmxlIGluIGEgcmVxdWlyZWQgbGlzdCBmb3IgdGhlIHNs
b3Qgbm9kZS4NCj4+DQo+PiBPa2F5LCB3ZSBkZWNsYXJlIGNvbXBhdGlibGUgYXMgb3B0aW9uYWwg
aW4gdGhlIGdlbmVyaWMgbW1jLXNsb3QgYmluZGluZw0KPj4gYnV0IG1ha2UgaXQgcmVxdWlyZWQg
aW4gdGhlIG1lc29uLW14LXNkaW8gYmluZGluZywgd2hpY2ggaW5oZXJpdHMgZnJvbSBpdC4NCj4+
DQo+PiBTbyB3aHkgbm90IGRlZmluZSB0aGUgcHJvcGVydHkgZGlyZWN0bHkgaW4gdGhlIG1lc29u
LW14LXNkaW8gYmluZGluZw0KPj4gaW5zdGVhZD8NCj4gDQo+IEJlY2F1c2UgbW1jLXNsb3QueWFt
bCBpcyBkZXNpZ25lZCB0byBiZSBjb21wbGV0ZSAoaGVuY2UNCj4gInVuZXZhbHVhdGVkUHJvcGVy
dGllczogZmFsc2UiKS4gVGhlcmUncyBhdCBsZWFzdCAyIGJpbmRpbmdzIHdoaWNoIHVzZQ0KPiBp
dCAod2l0aCAibW1jLXNsb3QiIGNvbXBhdGlibGUpLiBMZWF2aW5nIGl0IGF0IGxlYXN0IHByZXZl
bnRzIGZvbGtzIGZyb20NCj4gY29taW5nIHVwIHdpdGggdGhlaXIgb3duIHJhbmRvbSBjb21wYXRp
YmxlIHN0cmluZ3MgZm9yIG1tYy1zbG90Lg0KDQpBbHJpZ2h0LCBJIHdpbGwgdXBkYXRlIHRoZSBy
ZXF1aXJlZCBwcm9wZXJ0eSBpbiBtZXNvbi1teC1zZGlvIGJpbmRpbmcgYXMgDQpzdWdnZXN0ZWQg
YnkgTmVpbC4NCg0KPiANCj4gUm9iDQoNCg0KLS0gDQpXaXRoIEJlc3QgUmVnYXJkcywNCkRoYXJt
YSBCLg0K
