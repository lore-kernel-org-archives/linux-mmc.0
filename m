Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D701FF60C;
	Mon, 16 Dec 2024 09:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734341198; cv=fail; b=aDH12sfEp6BJ8Ojtg5y0ZUyoycVPOVhiXwX9e9mC1rU1+XBWH3q5+ST8k3PD81znFswqJi7NjBX4kcIn0sYAdK646/N4izdPh6BEARQcLi/gbMRfv+0sP7kaWEpyqzQDyuQRAZe36AOIRILPJEYa2eBn0890V20ZForb0sHtPSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734341198; c=relaxed/simple;
	bh=FToOq2GQfV0a7MT2+bE6NtVBJg6wyCUb5qfy+gaIBg8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=phlgvtuyVCKeNMdSkUrpDZbrpBp15TGhCKfJFiTveZ9hysSqpllqasH7QpQbMHFRAcu7rruynObJsM1PXrLLsbhWodnf9ulrdXdIAnNEUT9khhMcFfiEXzFBCppBgbgJVqgWNG3Q6O4DiXkTOgmgh6EqoejhyF2QupdSkwE8l6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tnuCDwWN; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tnuCDwWN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIb+zAY/xgaw6YLdVgyIbGYRQJOeaQn5WHpKPTkzNs/+YiQHGCygrHDQU7Dda4Nz+uPZbrs+T1AcAB7OaTber9YZYidz3S/924Qtp8vdH7XLZ0OAtdHSOfFTKQ6b2N4eEPv9oiOgKmGvRAxaKBKJ94i/uSjsJEH9cmIaMGL5GIyo923ci9ZV1h0bssL19TjBsE3k5xWcbiA8aOM1PPSiQyzc/mwlzoc68Bl2uQJsukRjCLW3nEcS6XprI7p9Rmq7KWf/mXqi6uf8oVD16CRrxtNhlykLZfC+buCi1o74qy/B8e3GLRMUCkwSi4CLSlEwYUIXez1s09wKNO+pxlRP/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FToOq2GQfV0a7MT2+bE6NtVBJg6wyCUb5qfy+gaIBg8=;
 b=ePkjajSNmjUBqxV9jmhLOftkNBwFTePsktYveQw1t3O+2x3XcwgFJiFhcouipVHllK0oLD0+CRIzduPcF6R7X9oB5XO762n2ERa6T1q3rojtcyx6FZrudu1ObTBJ/7NhDpYOUo3OVv7fECfF8CN8JmI2JMpN9lGzVd8dIpeNX3YYmp0uEiTAQbr9f6dNbHGGaYZyBk5FtGSm8GNnyfOFTDuls0nWOHPVr8FB8Fys3XPHURab5aJ5CTQBOpy8TfbUaYi3BMFr7Q/x0v4jbhEQGFACoKvWpMNE5zluL/dMfca0BP3jNMYGeAlj2HlZFowG/rsdiFvJ37NchOj+3aDAGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FToOq2GQfV0a7MT2+bE6NtVBJg6wyCUb5qfy+gaIBg8=;
 b=tnuCDwWNVVmGZ8FWI3TI5vplMJzKRW2lknV52OnlS/guUJ0CdUfdlusgUwi0sjnVExnvghe9400rgOT3dRnu9unB8nJVPUuPE72OhzDPUFnclTaBG5IIUepKnW9tlkBi+zfS8xCwXmN9TlwkMDNk/ygGWS+74N2WImT9+fuqoEbGn3N2rQWvybhlVWHI/jLsS9YvzReP7Ov9CbTuwI7wHYU36mVNxFkEsPmLJ18PaD0/17N7GFtEf+fkIXLQ7ISofubTRMCBhYO4Gs7RzJnigXGBhJwz0p7st7E19ugqoJ9Drbn6j5bEvbuP3toSZUweC0xCJDA/9vfGGbqO1gVj6w==
Received: from DS0PR11MB7410.namprd11.prod.outlook.com (2603:10b6:8:151::11)
 by CO1PR11MB4964.namprd11.prod.outlook.com (2603:10b6:303:9e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 09:26:33 +0000
Received: from DS0PR11MB7410.namprd11.prod.outlook.com
 ([fe80::bc90:804:a33d:d710]) by DS0PR11MB7410.namprd11.prod.outlook.com
 ([fe80::bc90:804:a33d:d710%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 09:26:33 +0000
From: <Charan.Pedumuru@microchip.com>
To: <Dharma.B@microchip.com>, <ulf.hansson@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<Aubin.Constans@microchip.com>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dt-bindings: mmc: atmel,hsmci: Convert to json schema
Thread-Topic: [PATCH v2] dt-bindings: mmc: atmel,hsmci: Convert to json schema
Thread-Index: AQHbT5yYkkteN2w5y0yLrMnpXfzY2w==
Date: Mon, 16 Dec 2024 09:26:32 +0000
Message-ID: <b814c215-8dd6-49af-b74f-a7bef2757b08@microchip.com>
References: <20241209-hsmci-v2-1-b5a6d7c59b67@microchip.com>
In-Reply-To: <20241209-hsmci-v2-1-b5a6d7c59b67@microchip.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7410:EE_|CO1PR11MB4964:EE_
x-ms-office365-filtering-correlation-id: e785e95b-9814-40ce-3da1-08dd1db3baf7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7410.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UCswWHNYUnk1ODV0VHI1aG56akxodlFTNkNmL2JKbHRjYzJQMFNxNWUyYWNz?=
 =?utf-8?B?dHk2dDVramIrUzhrQ1lsczVHd3BNcmUzQTlsTWdkRVhaSEtESlRWWlluM2I5?=
 =?utf-8?B?QmswUFcwMXJQd2ZxRnhXdVo5QkQ0bGNJQ1RlWUEraFZzSDFHZTc0aCtGeG9P?=
 =?utf-8?B?aWxIbUVSaTBac25jdW5LMDVjWkFMMVJrSzJWdGkxejhKM2RpekNuL1hYQXUv?=
 =?utf-8?B?NE9mbS9ycFY0RlAxa0EzTTFacnFHWFp6eC9IYlRaaWQwYlJPdmFEVTVmeUZa?=
 =?utf-8?B?Z0F3amc4SjlNcnVGTkx6VlRQQUg3YTl4b0RTZG05MkgyK3dLZnBUVjZMb1Ju?=
 =?utf-8?B?MkZlKytrcXhwMllrN0NNb0V1T0Y4enQ5Uzhlc0Z1WGJOUUdwdTJXNzNiWHl5?=
 =?utf-8?B?aGR0TmNyWTRzNy9DVGtJelBQMGN1VUlVVklCTk9HK21hRXRDc0JBRVFCTzBh?=
 =?utf-8?B?cDNLWUYzalVoVENZWVRPdXhzZDJLcDYyMUpDZEhkcHlGNzhCZzdLVFhMME0v?=
 =?utf-8?B?MWZlK3ZTWjdJOGhmMUdleGJFcENXT2RqYStaOXpBZW0xQjJzVXZiS0RQalR4?=
 =?utf-8?B?SHh5Z1FIN212bXlORkVMVWMxYXZKdHpDbkdoTDNMTVh3cHVmZlNWYkE0WWVZ?=
 =?utf-8?B?RVVJTitJOVlRSzNzdFdLTGhBYjlhS2xmVWlWU1VYajk5TXA4b3VxNXJvaUhv?=
 =?utf-8?B?dldHMmREc0t4VHVLbVlMODUzNU9LZUNDcUFRQU5XaFlKeGE2cHR2VkhnZXdR?=
 =?utf-8?B?cHNJdE5jd2djZ3RQMmpySlZCZjJ6MW5IbVB6TE1takRwNnQwWGRPVnNSTkh2?=
 =?utf-8?B?SlFEMzgzbENtQ2tmaklQTzRGRzYxc2ZEYTg3WGRoZEJIOVpQM1NYaXNjK20w?=
 =?utf-8?B?dHgzOS9tRWNaZkNTQTV3ZHF1ckJScVJ6aWgvTVdWeWZPbzNGaFJ6QytJcHRu?=
 =?utf-8?B?R012elJCemo0RkpEU05mRmJaM3NvT0djQ2s2VFFTR0gyZkVOYkV0S3Q5NFRh?=
 =?utf-8?B?ZitYTUJlSmtRNjZxc1JSSlQzVEZ3SDVQaEVrN1dPeVdvd0t4L0t4eUw4UmpV?=
 =?utf-8?B?N2RwY2UxL3k3Q2pzTHlBZURCNkp3QnBMM1FJQUxsQUVjNWRyMzZOeUY4aGFO?=
 =?utf-8?B?ZlJ5WFNpcmZFYVN1cGtVS1AyL3NkTktzaTZlQS9sQUJmeFRDcDBzTWZnYjJR?=
 =?utf-8?B?cWlMbUNhaERnRXNkaTdRRGNsQ0dpV0U2dVJhRHZCdFNEWWRkczR1TzdNbi9Z?=
 =?utf-8?B?amU1OUxXVzZpcC8vbXFpUTRtY0F1OWVqWEtpTWZIY2hkTWFwVm9mM3VRTGor?=
 =?utf-8?B?MXkwZGowb2RkUFZsWjNrUW9GNnpjRHRpdm44T25mbmFaeDc0aytrajBMOS9P?=
 =?utf-8?B?MWJESmJsVitGM05tSjAxSithQ0V6cU05azNZbmlRMkp3VisxZUV1R2pSckFO?=
 =?utf-8?B?WWNyNFhKK1I1d01rNWk5UGVndWZHVE9IaWc5Wjl6ZWZ1b29vb2gvU2dhUHh4?=
 =?utf-8?B?b3lLWGZpRTlMZURMTVJkTU1ndzdmMC8xL1kzUEJBaHgrNUVBdVVzZ3lJbmt2?=
 =?utf-8?B?SWQwaWVDcHFsOUkrajh0YnZhMEd6bENwNWN6OWx4bDcrUnI5UU0rcC9YdlV4?=
 =?utf-8?B?OG1xWTBKR0g4WWRnRjBTbzVjSG1YZ0VIU1VPOGxVYmdwZ2lmNytnd1hZRjJE?=
 =?utf-8?B?Q0N4VWk3N0pHSmdpKzhaQThwVDVCeVVOUldSWkVmMS9aalZCM3JQYUpQb1Fi?=
 =?utf-8?B?RHhkZFB3dXduZEFxSGxHTGN6N2FMc1dwaHdtSDdOSUJGdXFycm5ON0JYQ0I5?=
 =?utf-8?B?dHNEOFVnMDdmcEhCeGJDRms1bUFQeTZhdi9iZ3ZQUVphUm5VQVRsa0t1bHpD?=
 =?utf-8?B?TklNRjRoU2tuOG81R1RxcXRodEcwRXdXMmZtOVl3WnhpL0E9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cHlWUnhHallqdklqZzN0WHJleE9Bc1l2NUl4V28rWDZDaE96MHRqYjRqL3Vz?=
 =?utf-8?B?aFhicXNBSnZVMGZKQmxTTFNEK1FQdHdqZXQ1TWNITUZPS1cwT2V4bVpsK3Nm?=
 =?utf-8?B?UGVxb2hnaGcyOUdPbkdSL3ZBeHdJeVJHUldzVHd5a2pqUk9pNnRPaTN5L3dI?=
 =?utf-8?B?ZGtvUm5jVmVtVSsrZU9JU2h5bVFzOElnK0d3SndxSEZCU25YUlNPZHpjdkN0?=
 =?utf-8?B?b0lURUxueXVxcFA4VEVURFltQTBWbTVuZzVvSTBXYjZNZnpmemVHZ1QwRk9U?=
 =?utf-8?B?dGFrbm5LUUIzSEFOVyt6bHZnL2hMTGFZZXVBeHVWZmVFREZCcHBFRVJmN3RG?=
 =?utf-8?B?S0F4QzFoNDVBa3paYWhrMndLQmdhYVdMU1JGWGhQNkNOd1M2YmtpdGpVNjRP?=
 =?utf-8?B?aGJvcWZMbjhJbWhzdTIzL0NPS2dBZkJZZERWZW40dTFqSDh3cDl4SzhPaDRC?=
 =?utf-8?B?aGNPZVBVQjJLZEZYT043TW5yWXhITVUxSjgxSW1vaXF1OTc4Y2VlUks2QW1M?=
 =?utf-8?B?bTltNGsxMk1ueWlONDJsMXh4NkFzdEh4c0pNRDR6WHhLckZPSzNUQlJuQkpa?=
 =?utf-8?B?Yk54OThJNnU0UjdCVjRjNGxGbUx3Sm15TmdaVWg3V05kN1dYUnlKNG95bUdS?=
 =?utf-8?B?QlJWN20rYTQxRkRlM09Ec29QWDhuMDJLQktKOUFhNFVwYlBHdklKc1VzWEU1?=
 =?utf-8?B?Y01Ea1M2K1JnSzNYNE9kbEdrRWpRK1A3NjBzd0NZWWcxUjdQTm8rakdOZ1Ny?=
 =?utf-8?B?U0RqaWVyZUVKcStYTXBGMncyOWg1N08wWVBYekU3ejIvQW5tV2w1b29Ya1R2?=
 =?utf-8?B?OTlic1lFR0RWeWJWRGh4L05mM0lQNUxVVE5WWC9KRjZaek12YVJsQXdFSVk2?=
 =?utf-8?B?R0d2MWlRTUpqVE9IWWN3V0ExOW5DTnh4bXlNZHF4V0RpNWJkL0w4azBuQ01R?=
 =?utf-8?B?Szc3akxLL0RoVGFHdC9JcnBlVk52L3gyZ0FXdmV1OGM2VU5TSzZrdjBxMVha?=
 =?utf-8?B?bmdiRVNyUzNhVTdIU0NWb3VPTlA0RFdnWkZVQnlsanNFd2JnMEV6MFFQNVM0?=
 =?utf-8?B?THFON21YR2E4ME1wcFBiSHltVTZ5K2ZJMHF5akZnVFpRVXg1eE9PcVA0Q3dU?=
 =?utf-8?B?cUJwWmpFTGZDWXdXbkhhZEFLaHEwM1hOdzUzbi9oM2RNTlU0M1NROUR0R1ky?=
 =?utf-8?B?UWhVeTNKdWhwTE5uZU9jakxaMFZlbDM1QzZrSk5SM3kxR1BSWkhwcFk0cWhY?=
 =?utf-8?B?ZDAwSDJLdUJ6b2dJd2lyRmtVYlhIV1Zmc3hNMFlVVG9maVMvREpvYmpjSHVx?=
 =?utf-8?B?Z0x2R2pIQXdBR2IrT0U4MGJKRkZOcFMySkFsdTVRaEVMYXhZTkVVNWxxaEhF?=
 =?utf-8?B?QnFHN1hLTVp2VGkrcnQ5RFYyUFdDSkU2TFhJWldvOE9vYmxBc2Viak9kTXJs?=
 =?utf-8?B?Wmx3NkI5bVJGTG5RWGxsZ21MSEorRjRjdytueWpvWFcrWURyaFFKK2ZyUm9l?=
 =?utf-8?B?T2tXKzJnM3VSSmpEL0NnanYvTTR1VGZaUGNmeWNsTnBHem5SalRPNTNnRDFj?=
 =?utf-8?B?bnlHQ3A3VU1MWC9UMUIrdHVncW5ZUGg5MmJla1BselA2aFZMWXI4aVZZdUdG?=
 =?utf-8?B?Z3RUdWZpK20zM0FXbU1HMm5CM2FpNE9obkpFMkZIdDlVMldwU0FPcTBNa2Ex?=
 =?utf-8?B?d0JvWW9RUDg0OElTNWpJZnE2emo5WE42dHQxVmcxUzMrNWc1emQrS1F6Mm5t?=
 =?utf-8?B?OSs3dTVieUxRVVFHaHk2YnBhYSs4ZVJ0amJ5bXhscG9TdFJXRUE0TzJsVnBB?=
 =?utf-8?B?TytmZzZscWVES2M0RWNkeGFmSWlOL2wrVFBZTHBYb0o1dEtoRk1pMjdPK2Nm?=
 =?utf-8?B?KytJNHdQRU96b1o4MmNjUmNSRlpIZnFxUGp4RlZtc0lnQXgwaktOZEFHSmQ3?=
 =?utf-8?B?LzhCRWkyRGZZMjFpbTlLdVcxOThWdWc2TzBiRTBqKzg3RzNJZzYyOWhMeGxM?=
 =?utf-8?B?dnh1RUpsbThtL0RCWFJsMHVsWGNYUDZCU0JoeGpnZnlZYWIvdFZFbXc2Z3JW?=
 =?utf-8?B?a3U3UEg4WktmOWhQQlo0ZXFEazlPRWV2M0hZbmxlaGowcEZkZkVDdytVNHAv?=
 =?utf-8?B?Y2diZUN5QnVhNVZJVHN5b292Nzc2UjlVUmJmbDNCSWp4aTNuSHdnb3p3Sjhk?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5080D9958152E4ABF6BECB4E8FAF7A6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7410.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e785e95b-9814-40ce-3da1-08dd1db3baf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 09:26:32.9312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vv7gmWUOwLxnKFmqASlUHKsG0bC4jXecB4g8PbFqHnPxWGbF1e8a1pM2OdXZsXJ2THjcjJqmLR6634tN73FKezYvz4n2xRrfqR+Yi8er/zI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4964

T24gMDkvMTIvMjQgMTA6MDIsIERoYXJtYSBCYWxhc3ViaXJhbWFuaSB3cm90ZToNCj4gQ29udmVy
dCBhdG1lbCxoc21jaSBkb2N1bWVudGF0aW9uIHRvIHlhbWwgZm9ybWF0LiBUaGUgbmV3IGZpbGUg
d2lsbCBpbmhlcml0DQo+IGZyb20gbW1jLWNvbnRyb2xsZXIueWFtbC4NCj4NCj4gU2lnbmVkLW9m
Zi1ieTogRGhhcm1hIEJhbGFzdWJpcmFtYW5pIDxkaGFybWEuYkBtaWNyb2NoaXAuY29tPg0KDQpS
ZXZpZXdlZC1ieTogQ2hhcmFuIFBlZHVtdXJ1IDxjaGFyYW4ucGVkdW11cnVAbWljcm9jaGlwLmNv
bT4NCg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBEcm9wIHRoZSBkdXBsaWNhdGUgcHJv
cGVydGllcyBpbiB0aGUgc2xvdCBub2RlLg0KPiAtIExpbmsgdG8gdjE6IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL3IvMjAyNDEyMDUtaHNtY2ktdjEtMS01YTI1ZTYyMmRmZWRAbWljcm9jaGlwLmNv
bQ0KPiAtLS0NCj4gICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvYXRtZWwsaHNtY2kueWFt
bCAgICAgICB8IDExMCArKysrKysrKysrKysrKysrKysrKysNCj4gICAuLi4vZGV2aWNldHJlZS9i
aW5kaW5ncy9tbWMvYXRtZWwtaHNtY2kudHh0ICAgICAgICB8ICA3MyAtLS0tLS0tLS0tLS0tLQ0K
PiAgIDIgZmlsZXMgY2hhbmdlZCwgMTEwIGluc2VydGlvbnMoKyksIDczIGRlbGV0aW9ucygtKQ0K
Pg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9h
dG1lbCxoc21jaS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9h
dG1lbCxoc21jaS55YW1sDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAw
MDAwMC4uMjY2ODZhZGE2Mjg4DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9hdG1lbCxoc21jaS55YW1sDQo+IEBAIC0wLDAgKzEs
MTEwIEBADQo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJT
RC0yLUNsYXVzZSkNCj4gKyVZQU1MIDEuMg0KPiArLS0tDQo+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0
cmVlLm9yZy9zY2hlbWFzL21tYy9hdG1lbCxoc21jaS55YW1sIw0KPiArJHNjaGVtYTogaHR0cDov
L2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ICsNCj4gK3RpdGxlOiBB
dG1lbCBIaWdoLVNwZWVkIE11bHRpTWVkaWEgQ2FyZCBJbnRlcmZhY2UgKEhTTUNJKQ0KPiArDQo+
ICtkZXNjcmlwdGlvbjoNCj4gKyAgVGhlIEF0bWVsIEhTTUNJIGNvbnRyb2xsZXIgcHJvdmlkZXMg
YW4gaW50ZXJmYWNlIGZvciBNTUMsIFNELCBhbmQgU0RJTyBtZW1vcnkNCj4gKyAgY2FyZHMuDQo+
ICsNCj4gK21haW50YWluZXJzOg0KPiArICAtIE5pY29sYXMgRmVycmUgPG5pY29sYXMuZmVycmVA
bWljcm9jaGlwLmNvbT4NCj4gKyAgLSBBdWJpbiBDb25zdGFucyA8YXViaW4uY29uc3RhbnNAbWlj
cm9jaGlwLmNvbT4NCj4gKw0KPiArYWxsT2Y6DQo+ICsgIC0gJHJlZjogbW1jLWNvbnRyb2xsZXIu
eWFtbA0KPiArDQo+ICtwcm9wZXJ0aWVzOg0KPiArICBjb21wYXRpYmxlOg0KPiArICAgIGNvbnN0
OiBhdG1lbCxoc21jaQ0KPiArDQo+ICsgIHJlZzoNCj4gKyAgICBtYXhJdGVtczogMQ0KPiArDQo+
ICsgIGludGVycnVwdHM6DQo+ICsgICAgbWF4SXRlbXM6IDENCj4gKw0KPiArICBkbWFzOg0KPiAr
ICAgIG1heEl0ZW1zOiAxDQo+ICsNCj4gKyAgZG1hLW5hbWVzOg0KPiArICAgIGNvbnN0OiByeHR4
DQo+ICsNCj4gKyAgY2xvY2tzOg0KPiArICAgIG1heEl0ZW1zOiAxDQo+ICsNCj4gKyAgY2xvY2st
bmFtZXM6DQo+ICsgICAgY29uc3Q6IG1jaV9jbGsNCj4gKw0KPiArICAiI2FkZHJlc3MtY2VsbHMi
Og0KPiArICAgIGNvbnN0OiAxDQo+ICsgICAgZGVzY3JpcHRpb246IFVzZWQgZm9yIHNsb3QgSURz
Lg0KPiArDQo+ICsgICIjc2l6ZS1jZWxscyI6DQo+ICsgICAgY29uc3Q6IDANCj4gKw0KPiArcGF0
dGVyblByb3BlcnRpZXM6DQo+ICsgICJec2xvdEBbMC05XSskIjoNCj4gKyAgICB0eXBlOiBvYmpl
Y3QNCj4gKyAgICBkZXNjcmlwdGlvbjogQSBzbG90IG5vZGUgcmVwcmVzZW50aW5nIGFuIE1NQywg
U0QsIG9yIFNESU8gc2xvdC4NCj4gKw0KPiArICAgIGFsbE9mOg0KPiArICAgICAgLSAkcmVmOiBt
bWMtY29udHJvbGxlci55YW1sDQo+ICsNCj4gKyAgICBwcm9wZXJ0aWVzOg0KPiArICAgICAgcmVn
Og0KPiArICAgICAgICBkZXNjcmlwdGlvbjogU2xvdCBJRC4NCj4gKyAgICAgICAgbWluaW11bTog
MA0KPiArDQo+ICsgICAgcmVxdWlyZWQ6DQo+ICsgICAgICAtIHJlZw0KPiArICAgICAgLSBidXMt
d2lkdGgNCj4gKw0KPiArICAgIHVuZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2UNCj4gKw0KPiAr
cmVxdWlyZWQ6DQo+ICsgIC0gY29tcGF0aWJsZQ0KPiArICAtIHJlZw0KPiArICAtIGludGVycnVw
dHMNCj4gKyAgLSBjbG9ja3MNCj4gKyAgLSBjbG9jay1uYW1lcw0KPiArICAtICIjYWRkcmVzcy1j
ZWxscyINCj4gKyAgLSAiI3NpemUtY2VsbHMiDQo+ICsNCj4gK2FueU9mOg0KPiArICAtIHJlcXVp
cmVkOg0KPiArICAgICAgLSBzbG90QDANCj4gKyAgLSByZXF1aXJlZDoNCj4gKyAgICAgIC0gc2xv
dEAxDQo+ICsNCj4gK3VuZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2UNCj4gKw0KPiArZXhhbXBs
ZXM6DQo+ICsgIC0gfA0KPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29u
dHJvbGxlci9pcnEuaD4NCj4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svYXQ5MS5o
Pg0KPiArICAgIG1tY0BmMDAwODAwMCB7DQo+ICsgICAgICBjb21wYXRpYmxlID0gImF0bWVsLGhz
bWNpIjsNCj4gKyAgICAgIHJlZyA9IDwweGYwMDA4MDAwIDB4NjAwPjsNCj4gKyAgICAgIGludGVy
cnVwdHMgPSA8MTIgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ICsgICAgICBjbG9ja3MgPSA8Jm1j
aTBfY2xrPjsNCj4gKyAgICAgIGNsb2NrLW5hbWVzID0gIm1jaV9jbGsiOw0KPiArICAgICAgI2Fk
ZHJlc3MtY2VsbHMgPSA8MT47DQo+ICsgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gKw0KPiAr
ICAgICAgc2xvdEAwIHsNCj4gKyAgICAgICAgcmVnID0gPDA+Ow0KPiArICAgICAgICBidXMtd2lk
dGggPSA8ND47DQo+ICsgICAgICAgIGNkLWdwaW9zID0gPCZwaW9EIDE1IDA+Ow0KPiArICAgICAg
ICBjZC1pbnZlcnRlZDsNCj4gKyAgICAgIH07DQo+ICsNCj4gKyAgICAgIHNsb3RAMSB7DQo+ICsg
ICAgICAgIHJlZyA9IDwxPjsNCj4gKyAgICAgICAgYnVzLXdpZHRoID0gPDQ+Ow0KPiArICAgICAg
fTsNCj4gKyAgICB9Ow0KPiArLi4uDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbW1jL2F0bWVsLWhzbWNpLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tbWMvYXRtZWwtaHNtY2kudHh0DQo+IGRlbGV0ZWQgZmlsZSBtb2RlIDEw
MDY0NA0KPiBpbmRleCAwN2FkMDIwNzVhOTMuLjAwMDAwMDAwMDAwMA0KPiAtLS0gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL2F0bWVsLWhzbWNpLnR4dA0KPiArKysgL2Rl
di9udWxsDQo+IEBAIC0xLDczICswLDAgQEANCj4gLSogQXRtZWwgSGlnaCBTcGVlZCBNdWx0aU1l
ZGlhIENhcmQgSW50ZXJmYWNlDQo+IC0NCj4gLVRoaXMgY29udHJvbGxlciBvbiBhdG1lbCBwcm9k
dWN0cyBwcm92aWRlcyBhbiBpbnRlcmZhY2UgZm9yIE1NQywgU0QgYW5kIFNESU8NCj4gLXR5cGVz
IG9mIG1lbW9yeSBjYXJkcy4NCj4gLQ0KPiAtVGhpcyBmaWxlIGRvY3VtZW50cyBkaWZmZXJlbmNl
cyBiZXR3ZWVuIHRoZSBjb3JlIHByb3BlcnRpZXMgZGVzY3JpYmVkDQo+IC1ieSBtbWMudHh0IGFu
ZCB0aGUgcHJvcGVydGllcyB1c2VkIGJ5IHRoZSBhdG1lbC1tY2kgZHJpdmVyLg0KPiAtDQo+IC0x
KSBNQ0kgbm9kZQ0KPiAtDQo+IC1SZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiAtLSBjb21wYXRpYmxl
OiBzaG91bGQgYmUgImF0bWVsLGhzbWNpIg0KPiAtLSAjYWRkcmVzcy1jZWxsczogc2hvdWxkIGJl
IG9uZS4gVGhlIGNlbGwgaXMgdGhlIHNsb3QgaWQuDQo+IC0tICNzaXplLWNlbGxzOiBzaG91bGQg
YmUgemVyby4NCj4gLS0gYXQgbGVhc3Qgb25lIHNsb3Qgbm9kZQ0KPiAtLSBjbG9jay1uYW1lczog
dHVwbGUgbGlzdGluZyBpbnB1dCBjbG9jayBuYW1lcy4NCj4gLQlSZXF1aXJlZCBlbGVtZW50czog
Im1jaV9jbGsiDQo+IC0tIGNsb2NrczogcGhhbmRsZXMgdG8gaW5wdXQgY2xvY2tzLg0KPiAtDQo+
IC1UaGUgbm9kZSBjb250YWlucyBjaGlsZCBub2RlcyBmb3IgZWFjaCBzbG90IHRoYXQgdGhlIHBs
YXRmb3JtIHVzZXMNCj4gLQ0KPiAtRXhhbXBsZSBNQ0kgbm9kZToNCj4gLQ0KPiAtbW1jMDogbW1j
QGYwMDA4MDAwIHsNCj4gLQljb21wYXRpYmxlID0gImF0bWVsLGhzbWNpIjsNCj4gLQlyZWcgPSA8
MHhmMDAwODAwMCAweDYwMD47DQo+IC0JaW50ZXJydXB0cyA9IDwxMiA0PjsNCj4gLQkjYWRkcmVz
cy1jZWxscyA9IDwxPjsNCj4gLQkjc2l6ZS1jZWxscyA9IDwwPjsNCj4gLQljbG9jay1uYW1lcyA9
ICJtY2lfY2xrIjsNCj4gLQljbG9ja3MgPSA8Jm1jaTBfY2xrPjsNCj4gLQ0KPiAtCVsgY2hpbGQg
bm9kZSBkZWZpbml0aW9ucy4uLl0NCj4gLX07DQo+IC0NCj4gLTIpIHNsb3Qgbm9kZXMNCj4gLQ0K
PiAtUmVxdWlyZWQgcHJvcGVydGllczoNCj4gLS0gcmVnOiBzaG91bGQgY29udGFpbiB0aGUgc2xv
dCBpZC4NCj4gLS0gYnVzLXdpZHRoOiBudW1iZXIgb2YgZGF0YSBsaW5lcyBjb25uZWN0ZWQgdG8g
dGhlIGNvbnRyb2xsZXINCj4gLQ0KPiAtT3B0aW9uYWwgcHJvcGVydGllczoNCj4gLS0gY2QtZ3Bp
b3M6IHNwZWNpZnkgR1BJT3MgZm9yIGNhcmQgZGV0ZWN0aW9uDQo+IC0tIGNkLWludmVydGVkOiBp
bnZlcnQgdGhlIHZhbHVlIG9mIGV4dGVybmFsIGNhcmQgZGV0ZWN0IGdwaW8gbGluZQ0KPiAtLSB3
cC1ncGlvczogc3BlY2lmeSBHUElPcyBmb3Igd3JpdGUgcHJvdGVjdGlvbg0KPiAtDQo+IC1FeGFt
cGxlIHNsb3Qgbm9kZToNCj4gLQ0KPiAtc2xvdEAwIHsNCj4gLQlyZWcgPSA8MD47DQo+IC0JYnVz
LXdpZHRoID0gPDQ+Ow0KPiAtCWNkLWdwaW9zID0gPCZwaW9EIDE1IDA+DQo+IC0JY2QtaW52ZXJ0
ZWQ7DQo+IC19Ow0KPiAtDQo+IC1FeGFtcGxlIGZ1bGwgTUNJIG5vZGU6DQo+IC1tbWMwOiBtbWNA
ZjAwMDgwMDAgew0KPiAtCWNvbXBhdGlibGUgPSAiYXRtZWwsaHNtY2kiOw0KPiAtCXJlZyA9IDww
eGYwMDA4MDAwIDB4NjAwPjsNCj4gLQlpbnRlcnJ1cHRzID0gPDEyIDQ+Ow0KPiAtCSNhZGRyZXNz
LWNlbGxzID0gPDE+Ow0KPiAtCSNzaXplLWNlbGxzID0gPDA+Ow0KPiAtCXNsb3RAMCB7DQo+IC0J
CXJlZyA9IDwwPjsNCj4gLQkJYnVzLXdpZHRoID0gPDQ+Ow0KPiAtCQljZC1ncGlvcyA9IDwmcGlv
RCAxNSAwPg0KPiAtCQljZC1pbnZlcnRlZDsNCj4gLQl9Ow0KPiAtCXNsb3RAMSB7DQo+IC0JCXJl
ZyA9IDwxPjsNCj4gLQkJYnVzLXdpZHRoID0gPDQ+Ow0KPiAtCX07DQo+IC19Ow0KPg0KPiAtLS0N
Cj4gYmFzZS1jb21taXQ6IGZlZmZkZTY4NGFjMjlhM2I3YWVjODJkMmRmODUwZmJkYmRlZTU1ZTQN
Cj4gY2hhbmdlLWlkOiAyMDI0MTIwNS1oc21jaS03YWMzZWE5MTU3NzcNCj4NCj4gQmVzdCByZWdh
cmRzLA0KDQoNCi0tIA0KQmVzdCBSZWdhcmRzLA0KQ2hhcmFuLg0KDQo=
