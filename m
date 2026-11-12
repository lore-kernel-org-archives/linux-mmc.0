Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.83
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794472267;
	b=qFBu5cilCVZV2vJskP4TnnTbdHDwXr7OA7M+mM+VJUZC42VP9HqSsrI76MNuFYhzTHwy
	 GuH1F6WZ86hkQqSToBdkyZgGF/pcyz934yS33L4BS6NzmuyPou2n37tD1WA/Z8MJszp8E
	 t0Ns+ZIRWvCGNliCeJrUAx00kkzqCUvY89hojDrKE5CchX7gguJ0YJMkLLzoXODgj7X+S
	 WXD8iZ9LD9Il9G7r7b6a8mYA0l8o5JmVOCeVPMtVqjBzV0ruOrv/MwtvwOVpY01Ls3V3I
	 +AmtxwBMtvTzl7sMTcCCcVk6hWpoMcmgwXMOhEQKHiEqHv9hNMbMZiS+5XZb3TAKMXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472267;
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
	bh=5L2XZsp5fFBfGNnOZSen8DOZG8Q/SglML/kBl76TYQI=;
	b=dYad5K+pUqRXqxlq+dkk1vDE6Hzl3apEcn8tsI9K12WcsT0aJRnYslBpQACQa52NIhQn
	 c5QU6MlQOH97PWfaJJd3S1XAOc0tZ5/hdS6KA6fMyN2JsYuYnCPrA/oXAZdHZ7sTVyKse
	 AnQAZrH6yoeSu+k+xXCLUnchx5t/YrcW7zUG4d9PQvwN9E2iPQ/0ZnKeIWFwEv600AS8N
	 JpmBIcFRrxn7RG+5AF4pAHDbMIr/+TOZOfUaA3OeZ3ubnm7m2FneHG+g31q/eaF1/ZYXA
	 fRJ3GbVM+VWyNv42CLEbs9aHczlRzO+QuwhqmiQebigO6uQ/2FhT4BfGuxFoh3rsNxw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lenze.com;
	spf=pass smtp.mailfrom=lenze.com;
	dkim=pass header.d=lenze.com header.i=@lenze.com header.a=rsa-sha256 header.s=selector1 header.b="IQ0BkhN/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.83
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021083.outbound.protection.outlook.com [40.107.130.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B728D606A8A3;
	Thu, 12 Nov 2026 08:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B728D606A8A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lenze.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lenze.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lenze.com header.i=@lenze.com header.a=rsa-sha256 header.s=selector1 header.b=IQ0BkhN/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QM5I2ar8OZuYv93dWQucFnAkoDfMSP5mLLQtlVlJbCUx4NcFtrxJuYIRD49Dd/GHbI8LqmdEv4fROfQU+Ont5qv0L7HG6g1lzVhn9je+F8v9cnenqdW6s6TZ/vEzxM1bLYQTFAJl4oTg8oFdbc9Lpi0fwIdkgHu9ERivt0/me+/fzVveosKrDigzzf7k10ihoOmd/bnTOp7gJPtvlhaKGDrLikzz+F8kUXvvfq9VSXmfg60T5U1qmNiq1Klk7jfjMCYm7a8xOHDEKxNheASMtIaa9XCBPe1ZyW7vQk5/04at33q/NhgqLKZ+SdrZyAzzKqPRyTxN6DMs7nQmM7b/Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5L2XZsp5fFBfGNnOZSen8DOZG8Q/SglML/kBl76TYQI=;
 b=Qvr6S5X3x6qk0k5M5VFQ8m344MNbYdtWV2NZPTfo+MuGbzU61Ipe0+qzbLn9/nsQQitvQKxaROWqoHBN4s/DejsmaOKDGi2iwFcPlyX2q890JP0BcHUIH7R0NK6K7OXJ7PqGzlLvZvAPymv6795Z6Aq15fCO+lrscmSSxOv8fIrEpsqOH4T0LEDpkHNjFVtJ4osCpF7AXlLoCCL2rnuNOruPtvGy9BtLVNCc3gKJtqa4aELwtmz7HqqUQalSDFrgdbMX1lvrtE7zGR3tL72LYFhRgNyrI3hTXTXrcfFG5/f3Mj9GraidtPmupZug0JqmuF78gNWd4BkTa0YWJQ0UIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenze.com; dmarc=pass action=none header.from=lenze.com;
 dkim=pass header.d=lenze.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenze.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5L2XZsp5fFBfGNnOZSen8DOZG8Q/SglML/kBl76TYQI=;
 b=IQ0BkhN/IKT2t/f7BtXOdtxVtsuSfXP/Zh9lsSksu3jtfWvV4ecHsmmd3f8SyfF2sQdwqzXcAkb0FgC7az40Fumdnh+VNNdzjmbOb/0SDOQ5ReUUbXsL48LE6/p5bEgfCBE3VQt7Faab/DLxhtk724R03gW1F9ikc8I27cG615DnHGPC4olSBvDhlyDtQCZOFtFRI2uILxTKmRhndYdfR4NzSj6XQ1SjzrCQyc6Q5z6hQ5EFa70mUZjA2ST0w7Z/TjLeTXAkay6/AC9X552so7Vcl4OAX5bs4D03///11IS8MBrZqdU8PA2n++Me/GbGmI203RNgijRxDTLf7v0kBQ==
Received: from ZR6P194MB918907.EURP194.PROD.OUTLOOK.COM (2603:10a6:910:da::23)
 by PAXP194MB1437.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:199::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 08:31:00 +0000
Received: from ZR6P194MB918907.EURP194.PROD.OUTLOOK.COM
 ([fe80::9250:9858:e034:cd34]) by ZR6P194MB918907.EURP194.PROD.OUTLOOK.COM
 ([fe80::9250:9858:e034:cd34%6]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 08:31:00 +0000
From: "Brandt, Oliver - Lenze" <Oliver.Brandt@lenze.com>
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC: "ulfh@kernel.org" <ulfh@kernel.org>, "jh80.chung@samsung.com"
	<jh80.chung@samsung.com>, "shawn.lin@rock-chips.com"
	<shawn.lin@rock-chips.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: dw_mmc-pltfm: Fix usage of phase_map for SoCFPGA
Thread-Topic: [PATCH] mmc: dw_mmc-pltfm: Fix usage of phase_map for SoCFPGA
Thread-Index: AQHdcoAlEgY54a/9wUGtc67o1tq5MQ==
Date: Thu, 12 Nov 2026 08:31:00 +0000
Message-ID: <2a03a222c4a9d330ebc7157de09ec33f72875f28.camel@lenze.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2-0+deb13u1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lenze.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR6P194MB918907:EE_|PAXP194MB1437:EE_
x-ms-office365-filtering-correlation-id: 1af66e89-2b9c-480a-5361-08df4097486a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|38070700021|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261102130727099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 5RZGbZKDEJNY87YfwKNXOkEBGkp5W5i8gC4paC28DtgO/pNk87e38N0yeIP4QgT+LCw7esMaWMjr2ig8clNkxT1tg8njYCLG9LQJTOJp87JokX7CKiEa3v4iylutaSg7FIfw+iFN6uD0LzxemESI9mcc5lIGvC0BveX9wZHDmWpNIJTA+G9yKV2PNB5NPbMjTpnblBb7jBR09mb3Ff2iI4PJNlAb1war+HNdQ/QpXOzWnprvYS38C+3mD1Ni5wnYrDDfXkcKijoYSa4pdpyBYoAt6PL2HDLoEosM21G7yb48W8e2SBEtxHcraxt9djAuyVCMZoOAU3blDEBF/+Z4YG/OACqAFPwdAC0byps0ynGQaf/mAjynECdFK4AqKRQ2oJQT27J9qlBr/lYyrtueeAbNEEY7jMfAYLFGdiwM64hM8vXAZMq7aaqcwNtpgJ7a6FUEmAm8ojrDF5i8eCdeYsvmmwKYOde927I9gfuCi/JFS7khWTv6EY9yg1kxYfUMpoBMiBBmbD9jEPoV/vm5Kt9W7vLDLT8IDc1hG+kuOcJAvdmonAnJLbSgiWJtw0x3P3ZgUwuTdei/cn3UKUUaNVXJvxA/MeybZLE8pTQFyxnGGhoqNrl/3HYFJbOdlj2nSHblKIuEZCG1H6yw649JEMuDESqz5qMSpOhdrQ7Q4mhSFsUmw7Qg0fBR8vruhCRslAyUySHXyZ2yS7q8TNZVsR35KvlA2M1J8ZEV51CrMzw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR6P194MB918907.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261102130727099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cW5rVEQzOWxIbjQvYS85ektlSXdFaHRwSEpIMXI4QlF5aE55WUhkblVDUSts?=
 =?utf-8?B?TGlKUzBNZWdqYk1CNVlTNDRHZ1Z1SVRZV2d3Z0RVbkNrS3U2UWtGVHFiemRn?=
 =?utf-8?B?OFVIUkVZY25hcTBYMGFYaEo2SVJ2ekp6RjAya1l0QVc5UmZ6MEhQaHN1c3lU?=
 =?utf-8?B?bGJvVmRLWjI0cEU0OUNRVzRpUHE2OHdIMmNWYTh5TUQvTlJhZnlmekRuR1o5?=
 =?utf-8?B?SnRyUlYvbnE1NjNZckVDZGd6enA3N29HSkIyaXRpWk1BVGFGY05vaXR5V1ZB?=
 =?utf-8?B?WXJJUHJwdnVEMEFkTVk5cm13MGlkTEZVa1h5alAxZFZzNTdLbENpNHpWeER4?=
 =?utf-8?B?bmhyOFdKczdWNkRCazBkWks4Z3hqNXhCQ2MwOC91QTBlZmc0NmV0R2REMzkv?=
 =?utf-8?B?YUpHbkdmdE52TWJMSjZUSlNqMDRzdE4vYk9VYW00S3lxZUo2OUd2NXRldFEx?=
 =?utf-8?B?QnZqZnZ0TWhRTCtiYW5jUFoxRWpHSCtoUXB2SEZ2ZW1lMGtmRVVBamtKNUtk?=
 =?utf-8?B?OHB1N3BONGlETEhHNjYyQXRDY0t5emxIbHlmZXJvaVlOR244dGJ2bVlSbGtm?=
 =?utf-8?B?K0ZjenRZVUNvRVpoMUVSdGxCQzVPamQrRDh3TkhLcnJPTHN6VWMzTmtCa2hx?=
 =?utf-8?B?V3VvWkJ6M1VaOEVtR0JUNjVVLzgwY3pVYjR0ZVhBQkJOeHVrWWVGRFdLenk1?=
 =?utf-8?B?dUNwMFVabE9aN25TQzJoY3FaVWNWaE1mTnM3NmJ1Zk1jRzltcGtRSm5NNTg5?=
 =?utf-8?B?QTJ3c2VWd1NxNlhKa0JvNW4xcFUweEx0ZE5EeXQ2azFTZTh4dlF0UDk4R2NK?=
 =?utf-8?B?SFJGNTFNNUdZb0JFeDUvM3BueGNZMmI0ZnZXWWF3TkpMTnpTQTNYMTdpNVpl?=
 =?utf-8?B?cGQ1VUo3cjRjQnQvZTltZnJPTHZCU0FZV0VHTHB2Q0JrcEtRdDM3SzRiSWdM?=
 =?utf-8?B?SGpOV1YyNVhhWndhekZKdTM0dEREMXZWdnpXN3pSbjl6bzR6b1ZoUXBTTHBv?=
 =?utf-8?B?dFM2MkZIZE5GYkFKaXlHM2l5RSt2clpOclJFSVhZSkZFTllGb0FwcXkwcndz?=
 =?utf-8?B?dTFhTFlHVER1cVJlYk1zbUZMbHNiZ1ltYWcrV0libHRxZFJPOFZUTzJQcWZU?=
 =?utf-8?B?emQzaE1wSWh2VzE4UU1xSmpvTUNYaHluNW0vbzVvR291amtlYVRQVElxQ1l5?=
 =?utf-8?B?d1FCNHZnMGpUWVpUNnBFazdUaHIyQVpGcHRUQU5Rb0xLbnBJQ2RVcjBrWVNr?=
 =?utf-8?B?M0l4ZXM0V1NteVRpaVhTY2UwakdpdjBweEhEM1NIcFNQVlA4ei9EaVRuNXVH?=
 =?utf-8?B?WEpTRTloandGVWF2Z0dQVkRrQ0lHc0ZiWGRVR3JHU2prMFVsbDV3dEpJRXlz?=
 =?utf-8?B?K2MxajdPZGxnRGtxZEpzWmV4ODNHQjlpcHRPQlcxLzd3U2JjcG8raVIzRHVl?=
 =?utf-8?B?TWxrTkxJNU1adDRodWE0anNPQmV4ZHhwRUIwaVI4Mys4YnR5Y2lDUWVYRnQw?=
 =?utf-8?B?YitsMEE1c1VSZ0ZOYUY4Q3pFK2tpOXNSYUZpQ3cxZzdhZEhySVdHc0pvYXFY?=
 =?utf-8?B?Q3hXcWRnbWkvRFRwdHNmUzQ3R0R0TkkxQnY0NG5FZUpMOXY2ZmtNUkQ3VDdF?=
 =?utf-8?B?NWxWc0dDazJ0SU9Yakg1SkdDMkwrZHQyM2ZYWkNsVVRLYWZLc21SSjAxdjlW?=
 =?utf-8?B?em5WS0pwcDFuL0ZDWlhPTkdHSC9hZS9rbHFEbDBlZ0p1S3JxTXBpNExteCtp?=
 =?utf-8?B?TEtvMnNCZG5YeDA4ZGFlWmRqdHd2M3JCMVhFTXRwM21KcmdRWkNXclN1bEJw?=
 =?utf-8?B?N3dVUXM2clNOakdUZnNwaW9lQytLS2tyc2cxS2xlOFA4ODJCMEJPbGpLUmVR?=
 =?utf-8?B?clBvYmdTc2FSSllZakhnZW0yVEgxOFZvek9kaEtMV21lR2Z5SDhwSWdFU3E5?=
 =?utf-8?B?dWtQY2YzM0F6aTJaVEhDRG5mUVVjem85blNMcHZnUzhDMmdTT1lBZ3N5MXpy?=
 =?utf-8?B?bE5aaytIWThnYkxRQ1RDVkU2VndlZXJhNXhRZ1UrSFUxUTByZ3ZuUE9tckJP?=
 =?utf-8?B?UTh6bEVwZ1ZPa2xDVFhZVmtCbmdqaThRV0ZPejVndDBOWjIrRHRqYWY3QXIz?=
 =?utf-8?B?WW5mQkpBbmFLR1JDWUp4UjhLZUdITmhxeWtOaTVYRFROeUhRSjFJUk1YR0x6?=
 =?utf-8?B?OXBnVHUvWDc1MFZIcHVFaW5DVTlYZTU3OFNRcGtrNEc5eURuNXFYRCtvVkR5?=
 =?utf-8?B?NDZxTHF1aWpVaWRUb2JQeE5WZFRyOWJWMFVIRFlaY2xDOTJUNjlkWHNLTDVq?=
 =?utf-8?Q?76xHYjbeePW518b5Yx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47FFCCC9F8AB84438151B7CBAB4D36A9@EURP194.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af66e89-2b9c-480a-5361-08df4097486a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 08:31:00.8440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 37cf0ce8-ac09-4e7d-9ff2-f1da44914b3e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TiQQyU6YMYHc7CYji84qrriIQg1B1zuMm+X+X5ATaet3nUiUF/Jc9qr551N0+aAouvmky64+3XuTnK7IPAZ8rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP194MB1437

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
T2xpdmVyIEJyYW5kdCA8b2xpdmVyLmJyYW5kdEBsZW56ZS5jb20+Ci0tLQogZHJpdmVycy9tbWMv
aG9zdC9kd19tbWMtcGx0Zm0uYyB8IDEzICsrKysrLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMv
aG9zdC9kd19tbWMtcGx0Zm0uYyBiL2RyaXZlcnMvbW1jL2hvc3QvZHdfbW1jLXBsdGZtLmMKaW5k
ZXggY2YzOGJiMTE4ZGMyYy4uMzIwZDUwODg4MWY0OCAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMv
aG9zdC9kd19tbWMtcGx0Zm0uYworKysgYi9kcml2ZXJzL21tYy9ob3N0L2R3X21tYy1wbHRmbS5j
CkBAIC01Niw3ICs1Niw3IEBAIGludCBkd19tY2lfcGx0Zm1fcmVnaXN0ZXIoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldiwKIH0KIEVYUE9SVF9TWU1CT0xfR1BMKGR3X21jaV9wbHRmbV9yZWdp
c3Rlcik7CiAKLXN0YXRpYyBpbnQgZHdfbWNpX3NvY2ZwZ2FfcHJpdl9pbml0KHN0cnVjdCBkd19t
Y2kgKmhvc3QpCitzdGF0aWMgdm9pZCBkd19tY2lfc29jZnBnYV9wcml2X3NldF9pb3Moc3RydWN0
IGR3X21jaSAqaG9zdCwgc3RydWN0IG1tY19pb3MgKmlvcykKIHsKIAlzdHJ1Y3QgZGV2aWNlX25v
ZGUgKm5wID0gaG9zdC0+ZGV2LT5vZl9ub2RlOwogCXN0cnVjdCBtbWNfY2xrX3BoYXNlIHBoYXNl
OwpAQCAtNjQsMTQgKzY0LDEzIEBAIHN0YXRpYyBpbnQgZHdfbWNpX3NvY2ZwZ2FfcHJpdl9pbml0
KHN0cnVjdCBkd19tY2kgKmhvc3QpCiAJdTMyIHJlZ19vZmZzZXQsIHJlZ19zaGlmdDsKIAlpbnQg
aHNfdGltaW5nOwogCi0JcGhhc2UgPSBob3N0LT5waGFzZV9tYXAucGhhc2VbTU1DX1RJTUlOR19T
RF9IU107Ci0JaWYgKCFwaGFzZS52YWxpZCkKLQkJcmV0dXJuIDA7CisJcGhhc2UgPSBob3N0LT5w
aGFzZV9tYXAucGhhc2VbaW9zLT50aW1pbmddOworCWlmICgoaW9zLT50aW1pbmcgIT0gTU1DX1RJ
TUlOR19TRF9IUykgfHwgIXBoYXNlLnZhbGlkKQorCQlyZXR1cm47CiAKIAlzeXNfbWdyX2Jhc2Vf
YWRkciA9IGFsdHJfc3lzbWdyX3JlZ21hcF9sb29rdXBfYnlfcGhhbmRsZShucCwgImFsdHIsc3lz
bWdyLXN5c2NvbiIpOwogCWlmIChJU19FUlIoc3lzX21ncl9iYXNlX2FkZHIpKSB7CiAJCWRldl93
YXJuKGhvc3QtPmRldiwgImNsay1waGFzZS1zZC1ocyB3YXMgc3BlY2lmaWVkLCBidXQgZmFpbGVk
IHRvIGZpbmQgYWx0cixzeXMtbWdyIHJlZ21hcCFcbiIpOwotCQlyZXR1cm4gMDsKIAl9CiAKIAlv
Zl9wcm9wZXJ0eV9yZWFkX3UzMl9pbmRleChucCwgImFsdHIsc3lzbWdyLXN5c2NvbiIsIDEsICZy
ZWdfb2Zmc2V0KTsKQEAgLTgyLDEyICs4MSwxMCBAQCBzdGF0aWMgaW50IGR3X21jaV9zb2NmcGdh
X3ByaXZfaW5pdChzdHJ1Y3QgZHdfbWNpICpob3N0KQogCiAJaHNfdGltaW5nID0gU1lTTUdSX1NE
TU1DX0NUUkxfU0VUKHBoYXNlLmluX2RlZywgcGhhc2Uub3V0X2RlZywgcmVnX3NoaWZ0KTsKIAly
ZWdtYXBfd3JpdGUoc3lzX21ncl9iYXNlX2FkZHIsIHJlZ19vZmZzZXQsIGhzX3RpbWluZyk7Ci0K
LQlyZXR1cm4gMDsKIH0KIAogc3RhdGljIGNvbnN0IHN0cnVjdCBkd19tY2lfZHJ2X2RhdGEgc29j
ZnBnYV9kcnZfZGF0YSA9IHsKLQkuaW5pdAkJPSBkd19tY2lfc29jZnBnYV9wcml2X2luaXQsCisJ
LnNldF9pb3MJPSBkd19tY2lfc29jZnBnYV9wcml2X3NldF9pb3MsCiB9OwogCiBzdGF0aWMgY29u
c3Qgc3RydWN0IG9mX2RldmljZV9pZCBkd19tY2lfcGx0Zm1fbWF0Y2hbXSA9IHsKLS0gCjIuNDcu
MwoK
