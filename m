Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC83116F841;
	Mon, 10 Feb 2025 05:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739165312; cv=fail; b=P0taBH1OpBYs/S8ohW4swg7DXdX+rqavJtO2rGqKJTM9F9TEGnCLczBOUM/w/mn3idi3XKaF1sjSwA+y9yYAzPvV+ouDMc03GEAdcAEnfmfUC84AM045DL07DNahucyAKBikgd4/bVepxXbKiGR4lA6ljEOJaXKu5e/eCvuw1jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739165312; c=relaxed/simple;
	bh=oCIi+WwhKNjGEbAVOCcJM8guLufOKo7vt8ADc1vab/w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NDvhmvobIOAcHlETmes1x9fp/IMJ7e66VswmpMwXjSN3RLZSdWKrzrKoeVsDpfM9tG7WFnb8qmyoGCTXLtv0dRxHpokE57R3+xnsZwwmXXLjQVLMaFgoGq0xl1cw0PuNHSkGebj8cifUUWMkeWAc5/kjEWwaX8XhkwsZyXnAtMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=awwNtFDj; arc=fail smtp.client-ip=40.107.95.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="awwNtFDj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2trN6SU81F9ujQ1esGBNUiPMtCz7GyUWfOX2CNJy6kuIW/xNrB+ma7KrbLmJBwZhqf4PspQydXbP1+eK02pJ8DfSlZvmJVkrKG/bSo9/d3nU43aDBWV5yuLDjroYZhM7S2omehBxylyxf1oci/Nz8lw93u6N8H4TTvnQJjgPJTq9mH5oto017yy9aJYHEw+esJ/25kvha8gamK9mdWHkI9LHk73rrZ9jQHocsgIf+shshlGIYLH5xI+ZJgKHBl7baskqhC7IAYa2IsmljYkFHg8bf3x5X7ODLovsgFFrmq8zHa22zLcGV7eeAKS/9Aqs1bRqqzpP3/lWsWKzjxChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCIi+WwhKNjGEbAVOCcJM8guLufOKo7vt8ADc1vab/w=;
 b=EG8gemexLUxsO2DZdhUFj33kZn9+YNfbNL9eQG9ECPg1qUSiGKogATE4IzFGyvr36yXOqvCCLG3JDQpAfzJW7yIDZIzhhLHPr2HAyTmpIVB7AGNpaKTu59s7HKQiRHto23XOYhEnJBgCLkZaLQRddm6pRKhhwmRqtJ96JqbqClytZqLlcB+HOe/Aw8hlRtsU20H26bgbX5/4zjrWVOhgkF1i/6IgisyXfeX6CSIVdnRJW6tExjHhuD9VGGA88StnirNdEVKy3DbKVAs8EQ0t+uMogM91XIFGutj0P9FVCeI2b8hS5pdsgZPNS4NGMab8pjNlynaEGfyZheC+c/oUlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCIi+WwhKNjGEbAVOCcJM8guLufOKo7vt8ADc1vab/w=;
 b=awwNtFDjBWlmuo5ckPt1PtTq4CSX/c1NH7rW6HyPMBA/d3k15aziCsYpVXOQQvr4o7rqPJtE/mnklKlKOjg6fef+b3kWvyu0hdxoErLnmvAqSbgCcDJEc4h5a9VUaA59nyaX/9Uu4MGTo2Ku98eQ7qNUIUA37JTKQD8d5jiOpIJH12lI8q+M6F05V3A783XbgARujv5lh/1I60NakM84oEG+4YvX/vSRiYdLZdb9ja+fE1tpmqgur2UfM4bTAxHBDheqlghXOC5BRUU64NURn0TtYyYtnHvTPOyvR295MFU3bK9cccBZc+dv9oMe2TUNTTYSlmPeD2faMXFqhozPTQ==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by LV8PR11MB8680.namprd11.prod.outlook.com (2603:10b6:408:208::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 05:28:28 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 05:28:28 +0000
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
Thread-Index: AQHbd4DiJT/2q7h3vk+co+F7jIgTKLM7jO4AgAACEoCAAAQ2gIAEdwIA
Date: Mon, 10 Feb 2025 05:28:27 +0000
Message-ID: <7de20917-3176-4e80-8ccd-9c01c037cc9a@microchip.com>
References: <20250205-mmc-slot-v2-1-da3c5f30e2d9@microchip.com>
 <f6d7ffa0-6c08-45fb-9153-5e4aad1ca86a@linaro.org>
 <003ffa44-c88a-4234-a54a-50cd1140982a@microchip.com>
 <7180babd-302a-4f86-8770-bdd9f5c773cf@linaro.org>
In-Reply-To: <7180babd-302a-4f86-8770-bdd9f5c773cf@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|LV8PR11MB8680:EE_
x-ms-office365-filtering-correlation-id: 84b4bf57-3944-448a-449f-08dd4993bf9d
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bFMySFRxZWdxZitmcDhaRGlMOWUzUWZiV0phRUxXaUorNlFETFI5VUxlMWhN?=
 =?utf-8?B?UEZKMDFSdUVvRm42TGRhUXlZR0k5emttUDYwK3lRTUNVSTQvMVZqL1QzOHZQ?=
 =?utf-8?B?dkd4TWVubmw1YzN3Y0haT2NUV1pIcjRZVnY2QUJhY3c3akV1ajJ6NFJJeHpo?=
 =?utf-8?B?dktnVVFrSXlFV3VtUm9rNmRSY2dSR3BlUWpIeDB2QlRvZktZVmQ3UC9FQXpO?=
 =?utf-8?B?SmlSaWdFcHdSR2FKTmViek5EQ0tnbGlkRC9iTXptaTlHdnNxWENjMm51Zk1S?=
 =?utf-8?B?ckhuZWZkVnFMYUF4NXNxeUIySEZ5WU5VWTU1YlFjMURNOTRZb3dRalUrdnkz?=
 =?utf-8?B?emlPTWJ4TDFUVks0Yzg3ZGlIWGlhMkdQYUFGTCt2Y3EwUk9ZdUpWSVpObis3?=
 =?utf-8?B?Zy9zYThxMmU3M0gzazJvQ2puV214dXo2bHZ5Q0lOWkJxa3NuckVkZmlobEY0?=
 =?utf-8?B?b1dmcmEwOHNqTGhtQmtvWUJQMnBSNkdhTkw1ejVsdERTNUxWS2Z4U20vYXM2?=
 =?utf-8?B?OEdudnppMGtxeWlldnVsMlZ5R1g1YkMrRDRINnU4NXYvb2JHNGg1dFhhYVdV?=
 =?utf-8?B?bU0xTzVnRmhNOVUvZmo3TWc2R1VUemNsaU5GSXFKbzFUNTVjTnhDQnUyTXc4?=
 =?utf-8?B?aG1QRE9OT1dEZjhNMzg1N1htYWZNRXJWMENiK1pUUmx5ckpqNEc1cGFQNlJZ?=
 =?utf-8?B?a295RVc3NGFYN2VUazFQSGFWZk14NmNoUy9hWFI2bGJNMnlmemladEtMOWNY?=
 =?utf-8?B?SDljaERwY24zZXQzbGpBMSsrektKd3ZEOHFydUZNcnBYS1FVUUl5YkVhT1No?=
 =?utf-8?B?SHkwRUFWTXduenFzK1BGYnZkMkE3K3M3aTNKMTh5R1dTRVVXWnlITFFaQncy?=
 =?utf-8?B?TFN4N0FOUmErZ3VlTmdwNGVRNGlQTmFNTmFWelFWdmdTSGh1cUx1ZHBhdjd1?=
 =?utf-8?B?Mmk5RFRqZHpTTll6aGVTazJLK2RCNXE0MHpJeUVsM3FkRHQyd3NKbFFDNnov?=
 =?utf-8?B?bFBDYmgvZVl4Z1hkamU2NHQ1UjhUUlQ3NXhTb1JzVVp5TjRGanpxdXUyZ0Qy?=
 =?utf-8?B?Nk1QZUQzSUlzeHAwNzVUVUV4ZmRWY2lrbXZiZ1p6ODhkVGJMTThDaXU5TzZ3?=
 =?utf-8?B?c3JFSVdCNG1jazVGTWdnN2JyT1hnbU5FUXlheGFMc0xiYU9EYUh6eWRKeFVJ?=
 =?utf-8?B?NkJaaWJjUWhBV0VkeUVXSk0zKzdHRXhLN0IwVEM4NlBWeXFQWG05UlkzS2Fq?=
 =?utf-8?B?aDRISDhoQUE2YVZLekFkT1ZSL2sxNGE2UGdwWk9ET2FqbDhldHZYdE9yakVX?=
 =?utf-8?B?N2w5MDFjNmpEeG02WGdrbzY1bDZRUWljKzk1ZWd4M3BocFliZmVNeklUa1Zk?=
 =?utf-8?B?aDN1clhiQ1VrbzRjTDFRUTY2MEROUGdhTGovUm9lVHg4Sm5CSktkU3dIcUtP?=
 =?utf-8?B?T1RCejA3SGlxWVhEcDBkcC9vUjF2dmZOUm1NaEdPTjh1QVRPTWZQL0R1bXBQ?=
 =?utf-8?B?UjNOUUpNS0xiSktYenFMaHVSY1dBRDVnUXBVYTdsdE5jdGYvYlB1VXkzRGdJ?=
 =?utf-8?B?S09GVERVNUhUOWV3bXJVRGc5TU9IaDBYUHM2UGNyc0VWRnZzYlVWZ3VhanhO?=
 =?utf-8?B?bjdiNXhhQi9OTDVVOFZvcnVMN0c5NENoV1N6UkVPaTJRL2ZYdy8rWE5IUncw?=
 =?utf-8?B?MTRGczF1aUY4Z3JEaS9yQkloSWZ2SE5ESDBlaGV2ZmUxczZGTWh2ai93SGlT?=
 =?utf-8?B?NnU3TlBRMTNKYjhWc2FXeTQ3RzY0ek4weGpCWlN0MEZvdFhycnhBdEJFZkNa?=
 =?utf-8?B?TGZzVld2VVUxSE9laFZIcjhBcjY3WjgyWGVPNWZYR216QVVYQUIzV09EN2J1?=
 =?utf-8?B?UDZMb1BJWUp6c0xFS2dTUnFkSm9XZlNrNzl2Ulp2WHVOSkNUVmxtU0RwcDY0?=
 =?utf-8?Q?kdBHxZ3D3XoJ+GAiLG7fdGjMqF/suZ3c?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Rm1GUGZyRFNhclB2VVJDVFZyUFo5bTZ1eG1zQ0xMaHovTW1aNlU3eXlDY01S?=
 =?utf-8?B?bnVrUUxBNkZ3T1VLcGNVL3VpbkpFanRaZGhSRjZaL25EUUlwLzdBSUNvMDZP?=
 =?utf-8?B?d1RaZWxLRGZwYXpFaDBnNjV3L3F2UXhrRDRIejQzVVJXbVlLTlluczltYVJG?=
 =?utf-8?B?UTFkcjhIU0Rqd3ZCckJKeHJMWGloUGZuRUQ5WFpjRzBtRFYwekpjTTk5bFpM?=
 =?utf-8?B?UU5UYngvVExxQ0FsMmhWTkJNTENUcHFPb1NXNW53UTlEV0RZWUV5d0JMaDBZ?=
 =?utf-8?B?dC9aLzg3SkFoa0YyWjV2YjBuYnd4aDhBdkR5Rnc0R3lzY3hROTZZOU9laEZh?=
 =?utf-8?B?UTc4Zk9RMVBnTTk4a09LTGQ5N3FoWHBtSCtUYkM2MGlrdVFJNlQ0YnIzRW1r?=
 =?utf-8?B?Tkl4eTZZUVYzNUhKUUcxbVErQkFyckVyTGsvdExFSWtxLy9QbXNKRDV1eHdh?=
 =?utf-8?B?WWxtLzFKaVR6K2prZDFXUy9vek9Gb2xaSVJJbktuK1ByclhtYWFMTkRQaVJs?=
 =?utf-8?B?alZIZktWWkhTaHYzbnN5NkhTRm1pa3I2UUM3WEx1bXNwUVFta2RPcG9ud1Qw?=
 =?utf-8?B?ZW1GMk5CRzRrT2Z6ZENrYUZlQ1c3bjBwL3VLVFkxMjdTZ24wajJXQllZeFda?=
 =?utf-8?B?d01iWHNWd3o4Qi9HK0pvWW0yYXRMY2pvQVpJMUphSFFPK3FCSEE5TEdiQWtk?=
 =?utf-8?B?c29BOGJTaytqcHl0b25XNStpK0tLWTg4aDRZOTFkYmdZU1BFcitLcUxZZjZX?=
 =?utf-8?B?dFBJWjlwcHhxbENSYmdUc21DbDh0V2NLZ3N5NWx4QVZsNWZkOENwOGxlcmp2?=
 =?utf-8?B?NThPZjgzSTlJa3JYQm9yb3JlNjA1RHBpUmVFWlBHV3pZWnZ5bkUyU3ZGQ05Y?=
 =?utf-8?B?YzEwUWVZSm9hd090dkVkaHVCWWE3T3JsdVA5N1RIOU96VDBRemRkTDB2SnI1?=
 =?utf-8?B?OVJ0aHc1YXBwdHhYZ1cyNkRWL2xRbGFRY0lPbVZETjR3eFA4bXFLZnVlVlNI?=
 =?utf-8?B?RW5WRUtYL1NuV1NEb1pqbkNVUlVqbTlCb3pSSHJtTFkzaFA3K1F4ZUNPaHMz?=
 =?utf-8?B?TGVMeUFhNUNFTEVIT29FYVFwQjNFTEVodThmdVRTNEEybXRJTjF4V2h0Ny81?=
 =?utf-8?B?R01BcDZ2TVFtdjJrcjNXZUJUWHpueWlyeWdmTGJMdUwzMUpMVlZtbkhra1E2?=
 =?utf-8?B?ZWFUSDBXVTcwTW5LMkFvNE16K0puQ1JKbmQ5TUhnam4rVFlUQmpES2VIZ0g4?=
 =?utf-8?B?b3VXaFUxMkJnaXF3MURMeVNTcDRsQWlpRkZnUFBERmtpVVpMUGJVRTZzMjlH?=
 =?utf-8?B?WDJRZjNac3FWWis2K1d0Zk5VRGRsMXJWVTFva1JVZDU4N2M0dFNzNTdPZkR5?=
 =?utf-8?B?ejR5NFJBaDVEMFc0aDY0YTRpMzJTWkxXSjNZN0ZuN2t0bzRxTDhIY2phY3BP?=
 =?utf-8?B?VzVuVk13TWtVbFNMNHIyNkl0MGR2MmJNYkJWWm9LYTkwNmhXUnp1SFQwZzk1?=
 =?utf-8?B?VzhzZ2pQQkJMVUxEb0QzVHlRUWd1aVdHNXlpOWVTWmJjeUtsVGlnRVNDeHNJ?=
 =?utf-8?B?aGVMZ3ZKUjZocjVSZWlQbTVrMUtOOGhtQnpXeFRyaTFQYmdYQlNWY0IzZGk4?=
 =?utf-8?B?aHNtZXFCWjJrdFQ0NEFrUU1ya3F5Y2JSVHU2dVhKNVIzTlZQVWpxcXFsa1lF?=
 =?utf-8?B?MzRWL0hzbFplbXE2T2lHQTNndlp4empXeUczTzkzVnlRUWdHQy8xNjhZVXMr?=
 =?utf-8?B?ZUxXMUhhRUlvY292U0U1dmtTRkdBSXY0eElPUGU4dnVYenhaeU1ITTJueitJ?=
 =?utf-8?B?OHA2OXBLSXlVbmZHWW9PcENCSU9uYWJJWExIY0NZT0hmbmhIbFVRYlZQbXdW?=
 =?utf-8?B?Ry9rN2lna2p1RXJDd2cyeVZBWm5YRU1IUkZoVDVxWjFOQUdneXhyNS9jY3c1?=
 =?utf-8?B?SUVzb01NUTdoai9ZWkIzRjVrek01SjFwR1VJZnVBQ041S01zSVluTFVKaHN6?=
 =?utf-8?B?S1lNWG5qTlJvS2ZiU2hONGYzSmpzenc0UTZvczVkQ2hycWdoV0hXUlBZbVpY?=
 =?utf-8?B?Y0k0dlZYYkhqZUNwWHBITmltVHdzdG45OUVrcEpMeUNRK1AyQThiNDRNWUlV?=
 =?utf-8?Q?Qo/D9npV+M07GGDhBrRWzMqHT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFE0F34C93E4594DBCA3D0FDF9B67D71@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b4bf57-3944-448a-449f-08dd4993bf9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 05:28:27.9806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k+Ix5zkvq6NfZIVBxWcfW5rg3ZxMZDR2baLtY1OJZ7Vg10bQLnTEI28M5DRhslFuKfUBHYfZXfMPdPIzkiym4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8680

T24gMDcvMDIvMjUgMjo0NyBwbSwgbmVpbC5hcm1zdHJvbmdAbGluYXJvLm9yZyB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyANCj4gdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMDcvMDIvMjAy
NSAxMDowMiwgRGhhcm1hLkJAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IE9uIDA3LzAyLzI1IDI6
MjUgcG0sIE5laWwgQXJtc3Ryb25nIHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3Qg
Y2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cNCj4+PiB0aGUg
Y29udGVudCBpcyBzYWZlDQo+Pj4NCj4+PiBPbiAwNS8wMi8yMDI1IDA0OjQ4LCBEaGFybWEgQmFs
YXN1YmlyYW1hbmkgd3JvdGU6DQo+Pj4+IFJlbW92ZSB0aGUgY29tcGF0aWJsZSBwcm9wZXJ0eSBm
cm9tIHRoZSBsaXN0IG9mIHJlcXVpcmVkIHByb3BlcnRpZXMgYW5kDQo+Pj4+IG1hcmsgaXQgYXMg
b3B0aW9uYWwuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IERoYXJtYSBCYWxhc3ViaXJhbWFu
aSA8ZGhhcm1hLmJAbWljcm9jaGlwLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+IENoYW5nZXMgaW4gdjI6
DQo+Pj4+IC0gSW5zdGVhZCBvZiBtb3ZpbmcgdGhlIGNvbXBhdGlibGUgc3RyaW5nIHRvIHRoZSBv
dGhlciBiaW5kaW5nLCBqdXN0DQo+Pj4+IG1ha2UgaXQNCj4+Pj4gwqDCoMKgIG9wdGlvbmFsIChy
ZW1vdmUgZnJvbSByZXF1aXJlZCBsaXN0KS4NCj4+Pj4gLSBMaW5rIHRvIHYxOiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9yLzIwMjQxMjE5LW1tYy1zbG90LXYxLTEtDQo+Pj4+IGRmYzc0N2EzZDNm
YkBtaWNyb2NoaXAuY29tDQo+Pj4+IC0tLQ0KPj4+PiDCoMKgIERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tbWMvbW1jLXNsb3QueWFtbCB8IDEgLQ0KPj4+PiDCoMKgIDEgZmlsZSBj
aGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL21tYy1zbG90LnlhbWwgYi8NCj4+Pj4gRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tbWMtc2xvdC55YW1sDQo+Pj4+IGluZGV4
IDFmMDY2NzgyODA2My4uY2EzZDAxMTRiZmM2IDEwMDY0NA0KPj4+PiAtLS0gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL21tYy1zbG90LnlhbWwNCj4+Pj4gKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tbWMtc2xvdC55YW1sDQo+Pj4+IEBA
IC0yOSw3ICsyOSw2IEBAIHByb3BlcnRpZXM6DQo+Pj4+IMKgwqDCoMKgwqDCoCBtYXhJdGVtczog
MQ0KPj4+Pg0KPj4+PiDCoMKgIHJlcXVpcmVkOg0KPj4+PiAtwqAgLSBjb21wYXRpYmxlDQo+Pj4+
IMKgwqDCoMKgIC0gcmVnDQo+Pj4NCj4+PiBJZiB5b3UgcmVtb3ZlIGl0IGZyb20gaGVyZSB0aGVu
IGl0J3Mgc3RpbGwgcmVxdWlyZWQgaW4gRG9jdW1lbnRhdGlvbi8NCj4+PiBkZXZpY2V0cmVlL2Jp
bmRpbmdzL21tYy9hbWxvZ2ljLG1lc29uLW14LXNkaW8ueWFtbA0KPj4+IHNvIHBsZWFzZSBhZGQg
aXQuDQo+Pg0KPj4gSWYgbW92aW5nIHRoZSBjb21wYXRpYmxlIHRvIGl0cyBzcGVjaWZpYyBiaW5k
aW5nIGlzbid0IGFwcHJvcHJpYXRlIChhcw0KPj4gcGVyIENvbm9yKSwNCj4+IGFuZCBpZiByZW1v
dmluZyBpdCBmcm9tIHRoZSByZXF1aXJlZCBsaXN0IGhlcmUgZG9lc27igJl0IHNlZW0gcmVhc29u
YWJsZQ0KPj4gdG8geW91LA0KPj4gdGhlbiBhZGRpbmcgYW4gdW5uZWNlc3NhcnkgY29tcGF0aWJs
ZSBzdHJpbmcgaW4gb3VyIERUUyBmaWxlcyBkb2VzbuKAmXQNCj4+IG1ha2Ugc2Vuc2UgdG8gbWUu
DQo+Pg0KPj4gV2hhdCBjb3VsZCBiZSB0aGUgc29sdXRpb24gdGhlbj8NCj4gDQo+IFRoZSBzb2x1
dGlvbiBpcyByaWdodCBidXQgeW91IG1vZGlmeSB0aGUgbWVzb24tbXgtc2RpbyBiaW5kaW5ncywg
c28NCj4gc2ltcGx5IGFkZCBjb21wYXRpYmxlIGluIGEgcmVxdWlyZWQgbGlzdCBmb3IgdGhlIHNs
b3Qgbm9kZS4NCg0KT2theSwgd2UgZGVjbGFyZSBjb21wYXRpYmxlIGFzIG9wdGlvbmFsIGluIHRo
ZSBnZW5lcmljIG1tYy1zbG90IGJpbmRpbmcgDQpidXQgbWFrZSBpdCByZXF1aXJlZCBpbiB0aGUg
bWVzb24tbXgtc2RpbyBiaW5kaW5nLCB3aGljaCBpbmhlcml0cyBmcm9tIGl0Lg0KDQpTbyB3aHkg
bm90IGRlZmluZSB0aGUgcHJvcGVydHkgZGlyZWN0bHkgaW4gdGhlIG1lc29uLW14LXNkaW8gYmlu
ZGluZyANCmluc3RlYWQ/DQoNCkl0IGZlZWxzIGxpa2UgdGhlIG1tYy1zbG90IGJpbmRpbmcgaXRz
ZWxmIHNlcnZlcyBubyByZWFsIHB1cnBvc2UuDQoNCj4gDQo+IFNvbWV0aGluZyBsaWtlOg0KPiA9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0NCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9tbWMvYW1sb2dpYyxtZXNvbi1teC0gDQo+IHNkaW8ueWFtbCBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvYW1sb2dpYyxtZXNvbi1teC0gDQo+IHNkaW8ueWFt
bA0KPiBpbmRleCAwMjI2ODJhOTc3YzYuLjBkNGQ5Y2E2YThkOSAxMDA2NDQNCj4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9hbWxvZ2ljLG1lc29uLW14LXNkaW8u
eWFtbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL2FtbG9n
aWMsbWVzb24tbXgtc2Rpby55YW1sDQo+IEBAIC02MCw2ICs2MCw5IEBAIHBhdHRlcm5Qcm9wZXJ0
aWVzOg0KPiAgwqDCoMKgwqDCoMKgIGJ1cy13aWR0aDoNCj4gIMKgwqDCoMKgwqDCoMKgwqAgZW51
bTogWzEsIDRdDQo+IA0KPiArwqDCoMKgIHJlcXVpcmVkOg0KPiArwqDCoMKgwqDCoCAtIGNvbXBh
dGlibGUNCj4gKw0KPiAgwqDCoMKgwqAgdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KPiAN
Cj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09DQo+IA0KPiBDb25vciwgSXMgaXQgcmlnaHQgPw0KPiANCj4gTmVp
bA0KPiANCj4+Pg0KPj4+IFRoYW5rcywNCj4+PiBOZWlsDQo+Pj4NCj4+Pj4NCj4+Pj4gwqDCoCB1
bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQo+Pj4+DQo+Pj4+IC0tLQ0KPj4+PiBiYXNlLWNv
bW1pdDogNDBiOGU5M2UxN2JmZjRhNGUwY2MxMjllMDRmOWZkZjVkYWE1Mzk3ZQ0KPj4+PiBjaGFu
Z2UtaWQ6IDIwMjQxMjE5LW1tYy1zbG90LTA1NzQ4ODlkYWVhMw0KPj4+Pg0KPj4+PiBCZXN0IHJl
Z2FyZHMsDQo+Pj4NCj4+DQo+Pg0KPiANCg0KDQotLSANCldpdGggQmVzdCBSZWdhcmRzLA0KRGhh
cm1hIEIuDQo=
