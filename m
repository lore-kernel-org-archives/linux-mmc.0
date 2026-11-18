Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.97
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795021758;
	b=Ck8xM53+5Du19+YytxTqbfAjtHkgxdXUGlbedcHF4qnXnkkokbnEzdeV/OHqPHEnig80
	 /pxksHjmEYFsNhByWdOcltPVkP7+42LDT6rKy8JDUnMqVToMuXRiUqjCgE4y9R12OylgP
	 CeDGQpLQQp9VKkd/k8jz8ggtnpnMEBGUC99+QLv2fyi9u5EGpwIR+7nAqx2IRWQ+cAE+e
	 QuVZ/hyBd33IeUlRw1KMhusjmjTanuUNPNxBwvoSHNxor0SlASwMsqAoNq4eFqt50UxHv
	 5IfAdRrTn6B/IWnohhJdI0X6S89g5tjRLHMn/7XCrwxG/Vg3uPzajejmjPBWOMWt1cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021758;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
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
	bh=ObCZWNI+/WMmcHQnzcq2uAod6fKR3Azf75Zp8X/nFd8=;
	b=ejyS0+eX45wIH7cn4LI/pvcA53uRBMf//AFTS3lSic0XqefpXQ1v81Vlrg1vEPxBDQZD
	 trf5XCs4VoeB4EQCqU7luG2e2dxkna9K/lf7kvAbPDsJuLxnAN/RW0xs1hgEo4wcdeqQ1
	 PDu2SeCErDvrSLhBMYAD1ho9YfMnuY4pFsTiRvSRr5YjO2NNUcKhxf/sD+durdYuAIPVB
	 G6ocqD+4RdSY0oNP17tc66KkRSXj0i0jdjCoXOV9KszbuXN6hlVS60b+FkNfUKqz4pp3d
	 M04+UX0vr+jv75SlDRDd5iSgTDlBDrmngTfE2XYggqBaq8zwUZew7KL2y8JU6ZsYHFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lenze.com;
	spf=pass smtp.mailfrom=lenze.com;
	dkim=pass header.d=lenze.com header.i=@lenze.com header.a=rsa-sha256 header.s=selector1 header.b="PGxxf/M1";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.97
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020097.outbound.protection.outlook.com [52.101.69.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF6E60A2603;
	Wed, 18 Nov 2026 17:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BF6E60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lenze.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lenze.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lenze.com header.i=@lenze.com header.a=rsa-sha256 header.s=selector1 header.b=PGxxf/M1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNi+0kqMI44zU/m73drisk1Wdu506JqldlRdIrQ7RPlgHLu0UWpA3PTDKojymXM3ZmRpCaFelA2pZ46m2DwOGqTpyWSoWT5AvqqrlUpmF3anDRh6Qbxk6ClLi484YxHA9GrPHU2fXGcFSkbG+JqbbrVZk3l4x/e+1SGK/zXE6oJIyClrwp5c/7QUaSGkZD47c8gfaAc5vyQHpSL5PaP+Guc0are+HmW4pPQfwBaMGyXVMUrEocrogJVYmcWY7UpeRrc3sR5cQhwzPbhIdW+6KJYkhyKGys7aggpDJG661nqpP30soOaThII2Q8KHPJpW9cy26LFuTz9CnwGo+FNOCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObCZWNI+/WMmcHQnzcq2uAod6fKR3Azf75Zp8X/nFd8=;
 b=m6Lt5a94JaCJHAZ4vLN41r1z8c4po/8TlH66hM2ZT7Xo+mEv5Co+qxBq/bKwBx6Hb0LG23rxuuRMt58ipnVByER/CANrfshSP9gxfP0mrfeCHbne618b/obB+5YRT8a1IN+StgpTPcBO4IQe/qUncFxpjKNN59k+PZI2n9Yj2EXciQlKUwuP57tvCEHd+P0FpzcAETUSVj2o/da6FL63CgrP9hP6yo2mV/57qbieR+BgGG1l3fQC5U7r7n8FmMMLmxfN/U1Fb6VNaEgi1AEhfyKK/pcNJLc4yifwC5FdoFbLpSiW/2I3we5XYTt09wblOMEv1vaEsjGq4lmz60C6Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenze.com; dmarc=pass action=none header.from=lenze.com;
 dkim=pass header.d=lenze.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenze.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObCZWNI+/WMmcHQnzcq2uAod6fKR3Azf75Zp8X/nFd8=;
 b=PGxxf/M1qlbGWoiHlt1A+Yrqb+KdlAMHwKJyK9fTIBePdTJ7FIOAD6H4cqTJSO2Q9RUEPA+du+eNs+RVu453BiDvg7367tZvpOGEZzCodTxxS90l07oOC01ew5XAcQ9Wh/VJEdIP3K1A9LKnAePYpduWnpBVmymi4zxJ3XETmpRbKx027+tdn8EnvOi5A+StwzxVjIMKAZ+Be6zJC07Y46QphXxk49nap0N6aqDlubyhAS93AfrS6bYk+scTg4AowsnhHYX5RDdiPKEmUbxprCMwQ/inaPAZECN8TZL4aOuDCwKCDqYB9gQ+BBaeIrSzn/OKS+jbwZCsAS4ZibYBCg==
Received: from ZR6P194MB918907.EURP194.PROD.OUTLOOK.COM (2603:10a6:910:da::23)
 by DB8P194MB0568.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:15e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 17:09:12 +0000
Received: from ZR6P194MB918907.EURP194.PROD.OUTLOOK.COM
 ([fe80::9250:9858:e034:cd34]) by ZR6P194MB918907.EURP194.PROD.OUTLOOK.COM
 ([fe80::9250:9858:e034:cd34%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 17:09:11 +0000
From: "Brandt, Oliver - Lenze" <Oliver.Brandt@lenze.com>
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "ulfh@kernel.org"
	<ulfh@kernel.org>
CC: "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
	"shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: dw_mmc: Read clk-phase DT settings earlier
Thread-Topic: [PATCH] mmc: dw_mmc: Read clk-phase DT settings earlier
Thread-Index: AQHdcsEwqVwDFMPCbkurWCfb3enpSrc0GYyA
Date: Wed, 18 Nov 2026 17:09:11 +0000
Message-ID: <5134555fb592cdc7ec9b54b4893616e88b658306.camel@lenze.com>
References: <2c5f6a551f5375a5f92728b1aee036d05eebad7f.camel@lenze.com>
In-Reply-To: <2c5f6a551f5375a5f92728b1aee036d05eebad7f.camel@lenze.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2-0+deb13u1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lenze.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR6P194MB918907:EE_|DB8P194MB0568:EE_
x-ms-office365-filtering-correlation-id: 201018a1-505f-4014-2c28-08df4596aa7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|6133799003|22082099003|261009223027099003|18002099003|11063799006|56012099006|261026121527099003|261102123227099003|261021121427099003|261021123027099003|38070700021|261022075727099003|10067099003;
x-microsoft-antispam-message-info:
 szYkg0IoGeO9L78Gje7NIsd66QXtlhZkFFVzuiGoLqyDHxghT4HZ5o6uY4PL9pJhFamFqxOhLVJqvRt8NhuTAk+KKAO49kK/xbnl7aNLtPgbViq8Vuo0V3BgCymmBzwWUtedWv9UVGPFuAeOvuGit+OI52nkJLYhAnO/QTx4aSmjIoEInIvFYamtZmHjlfYC7UHWw+yqE2pZd8b5xd8HkvrFsa+lfi/ECM2ev07Un4/zKWrPVD802IUBw517aJnVbL0u6SH2xKhO7p93DeK6snMnT3oRiJ/1G7RO7Ba+3+dU66GalE6KpzKX0T+B+4n5j8L7cKSd/TPUig10u2W8jWZ/se7+EE4fYhJaup8wm6dzhoAmgOHDBD+SsBSePsJFztaLXFtgJBfdON247x+7wIgxJZV17RZezaJ7rFf48avaRewlIIoCkjZML9kofA1GWDQ9hApigabuG/w3iICbnBTjdKaqSTk7iLM/qAS0a2+e7ivOtZ3Q+TOuEv/walgIeGu1rC+cF9jpYLWu3nJ82EZ3mc8JXEm7H4J+gTO7ejOu7NqYZxAC6Wrsr83Dlv0pofoLae8ftyS+B7M0tZIRkrwkcDzhlgmNEKrwX/6DcJc8uH5i5V/9BxKnG5wVLSTaH1ulZPcsvf+4MKpZ03sSxe3l3y7Im1PIRG9H1GIYBiA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR6P194MB918907.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(22082099003)(261009223027099003)(18002099003)(11063799006)(56012099006)(261026121527099003)(261102123227099003)(261021121427099003)(261021123027099003)(38070700021)(261022075727099003)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R3I5K0VxcWIwM05aYkxsWWRSbWt3N1lBcWgzb1JWdFVJTUplNVV1WitMYll1?=
 =?utf-8?B?QzBzMjFlc0FhUjZOMVdqSk9OZ0xEQ1FkM3liMzYyMEUvWUQwOG9kUzZXUE41?=
 =?utf-8?B?OERDUXRxSUNRbkJucXVoYjQzT25RdlZsR2YxcnFsajFIc2Z6SjN1ZUt4REU3?=
 =?utf-8?B?Um4vWjJCdkFzOEt6SzVZOHNHajZMNm5SY05iT2FKNDhWRnpia1lIUmFmQWVW?=
 =?utf-8?B?OCs5MWx5RUpPQU5Sb2hBcEUwLzU4U3RzdkNHRXNoeUNzcTkybHIrSmVJUVlO?=
 =?utf-8?B?QWRTdU5EQ29HMldlNFFJcWFBMEFHV011aDFBZnNDZ3NzYlNObStUQk5vYndX?=
 =?utf-8?B?NW56bUJNYURpZERQSkFHSTlaYk4wbUpYSFo2OGtXQVU3Uy9TeklTVmxRYW1P?=
 =?utf-8?B?eFVnU2lCVXBGdmRUaXhSUHhlY1VNZGRka1FwdG5iM0MzVHdoVE5XSzZIbG5y?=
 =?utf-8?B?eFQ2S0xlbXc5UjZkOTN4TDV5aFVCWVF5dUlycWt3MlRqVFprNnZTUFVwaXg2?=
 =?utf-8?B?azdzTUhpWm5ySWJxckhQYmduclhKMmcxaUs2Y3YxYXMzTHMvbzcxd0J5dGxU?=
 =?utf-8?B?aGY5dUZqY21iWC9oa3ZlVzJqVUJ3d3lzclhkcWlvR3IzNmpValB3emFWNnR4?=
 =?utf-8?B?UG40RXlkZXg1VDdYUGNVYTBZVEdWemdoSVc0Vk0zRkRtUnhrZ0tGWUZGL2dU?=
 =?utf-8?B?Y1pXVG5nY2s4YldWK3pvOVZ3SHlxVU82d1FXWjYxR0tSeXg2REJXMFFib1pD?=
 =?utf-8?B?VzROWWthQjJyVFo4dnluUE80dkRwTUIwQzk5Nzk3dkthbkNuZEl4V3hMZkVT?=
 =?utf-8?B?djRFU28wNVpaOFNqMlMrMDIraFhmeVBET3J4UFBGZkhQTVg0TUxMaWFtUkNm?=
 =?utf-8?B?TTl0a2ZHNWJUK1FRZHlaTCtNb2EvMlZsZ09rT0hicVJJd1puTDhPMmkwZWRR?=
 =?utf-8?B?cVJTd3Vva3BURjJKQ3BGSDRiczdQbVYyWWRBRlJQNGdJQkQ4NVc5cUZZQmNr?=
 =?utf-8?B?RWljZWNRblZrYUllL2lCK2Yvdis5ZDlTbXBZOE1acW9GYjVqUjZNL0tVaDlZ?=
 =?utf-8?B?MjFRTDdadi9Eb2dWVDVpQWlEWDlIRWl6cVJ5RmpidG9rR1pxWlVsRURYSTg2?=
 =?utf-8?B?M1N3NWkzUVV6enB3Y0RaUmFqUmt3em00NnFJeXdadlRRWC81SWF5aEdDM3pZ?=
 =?utf-8?B?VGdmVlRqTFRQb1RZdUV2QmNFZTZwVWxubDRLWTB4MG5tZ1IvcllncloycmU5?=
 =?utf-8?B?RStXMDdLNEM1Snh5QWFQWVJrY3dCV3lzSWsvVzU0cC9jczdKZHlYdzRnb3BY?=
 =?utf-8?B?R2ZUaDdQOXRvM3JKSEsrcXQ4WU12dFk4OGprQkp2YTZhOEtVaWJjMmJpSkhm?=
 =?utf-8?B?czkrell4VFlWNEpSaUhtVk1lL0NQblY3c0txOUVJQmRtRUdCVWtYVndvaHNN?=
 =?utf-8?B?YTNRbG1xT1lOb1RGc0NtWlNORHdVZWZZTUwwS1FwdGIxWUJzQm52d1R4eVg4?=
 =?utf-8?B?Q0d0M2hsZjNDR29sYjB6NldmSjhTQWNPVE5wTDJIYlBCenBaVXdyTTVSWTFp?=
 =?utf-8?B?eDREcnl0MmtaTHBqczUwdFUwd3hIeTNqTGt4ZGw4c3NZQXVRblFVNzNxNzQr?=
 =?utf-8?B?Z05KUC9TalhsdURZOEErZzY5YUUrRDBESFFXczFTM3JaeWRZb1ZNaENnTFln?=
 =?utf-8?B?cTZ4eG1zVmdySEFOOHVoUTRoWDNpNmJhREtWOE9Tbjcra25nd2ROMXBieVdP?=
 =?utf-8?B?dXBybmFkRUpJM2FQSnZJSks1MzB0UE1uOTFCenJ2SEdXaHNjdVc0N0NjVmhY?=
 =?utf-8?B?cHkzZkNhZFplc3RxMTNqL3NCVFlxdVZZekp3UG91Qm5Zd3IwS3ZWb2UwdnRL?=
 =?utf-8?B?SjFlbmpXU1dMSldxTHVoaG5qeEtiYk5hZlhiWDdzYlQ2RE9LTHlnTDJ2K0pm?=
 =?utf-8?B?SW1rMDBLV2dvcWZuWjkrTzJZQUJqaDFXeVp1R1UrdmRBU3AvMndrMXpMQWFt?=
 =?utf-8?B?NHRzbkg3TURZaVl0LzN2Qk1KS0NUMUo4bkxUUEI5Tm5NNGUwVXkvYzNwN1Vk?=
 =?utf-8?B?QnlwWDR5VnRmb3NaVWJxRk8rNU5jbWdqT2JJVE1Fa3BhMjFXcUZDQWdEWDFm?=
 =?utf-8?B?Q1Z3MXZEeE0wbUd1cTJrVjRublBHeFp6U3lia0t1WnBBTUJWQlBKQllWcmJM?=
 =?utf-8?B?L1lpN0cvdy9Bdk1RbFdrZjNWYzA5TzVpbDlRaTBkMW1MQUxKWFFSWVBrTWth?=
 =?utf-8?B?Um1QSTc5cEg4alN4VGNGQkk4VjVId1B4NTdBRzRWbDRPTXFQdTB2SGU2QXcy?=
 =?utf-8?Q?uZlOui8WTpabkC8YjY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FE97A118AD637469E66A256EE6B0A03@EURP194.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 201018a1-505f-4014-2c28-08df4596aa7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 17:09:11.7323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 37cf0ce8-ac09-4e7d-9ff2-f1da44914b3e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zst0E8F7KlbGoz+bTPbxiVca1wgOfSnaoF5zulSENF7gAj7+Jw39muGJUkWb7ZJLxADAwSc/utkiRUJLqENVCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P194MB0568

T24gVGh1LCAyMDI2LTExLTEyIGF0IDE3OjE2ICswMTAwLCBPbGl2ZXIgQnJhbmR0IHdyb3RlOgo+
IFdpdGggYSBrZXJuZWwgNy4zLjMgd2Ugc2F3IHRoZSBmb2xsb3dpbmcgb24gYSBTb0NGUEdBIChD
eWNsb25lIDUpIGJhc2VkCj4gYm9hcmQgZHVyaW5nIGluaXRpYWxpemF0aW9uIHdoZW4gdXNpbmcg
YSBoaWdoLXNwZWVkIFNELWNhcmQ6Cj4gCj4gICBkd19tbWMgZmY3MDQwMDAubW1jOiBEVyBNTUMg
Y29udHJvbGxlciBhdCBpcnEgNTMsMzIgYml0IGhvc3QgZGF0YSB3aWR0aCwxMDI0IGRlZXAgZmlm
bwo+ICAgZHdfbW1jIGZmNzA0MDAwLm1tYzogR290IENEIEdQSU8KPiAgIGR3X21tYyBmZjcwNDAw
MC5tbWM6IEdvdCBXUCBHUElPCj4gICBtbWNfaG9zdCBtbWMwOiBCdXMgc3BlZWQgPSA1MDAwMDAw
MEh6IChyZXEgNDAwMDAwSHosIGFjdHVhbCAzOTY4MjVIWiBkaXYgPSA2MykKPiAgIG1tY19ob3N0
IG1tYzA6IEJ1cyBzcGVlZCA9IDUwMDAwMDAwSHogKHJlcSA1MDAwMDAwMEh6LCBhY3R1YWwgNTAw
MDAwMDBIWiBkaXYgPSAwKQo+ICAgbW1jMDogZXJyb3IgLTExMCB3aGlsc3QgaW5pdGlhbGlzaW5n
IFNEIGNhcmQKPiAgIG1tY19ob3N0IG1tYzA6IEJ1cyBzcGVlZCA9IDUwMDAwMDAwSHogKHJlcSAz
MDAwMDBIeiwgYWN0dWFsIDI5NzYxOUhaIGRpdiA9IDg0KQo+ICAgbW1jX2hvc3QgbW1jMDogQnVz
IHNwZWVkID0gNTAwMDAwMDBIeiAocmVxIDUwMDAwMDAwSHosIGFjdHVhbCA1MDAwMDAwMEhaIGRp
diA9IDApCj4gICBtbWMwOiBlcnJvciAtMTEwIHdoaWxzdCBpbml0aWFsaXNpbmcgU0QgY2FyZAo+
ICAgbW1jX2hvc3QgbW1jMDogQnVzIHNwZWVkID0gNTAwMDAwMDBIeiAocmVxIDIwMDAwMEh6LCBh
Y3R1YWwgMjAwMDAwSFogZGl2ID0gMTI1KQo+ICAgbW1jX2hvc3QgbW1jMDogQnVzIHNwZWVkID0g
NTAwMDAwMDBIeiAocmVxIDUwMDAwMDAwSHosIGFjdHVhbCA1MDAwMDAwMEhaIGRpdiA9IDApCj4g
ICBtbWMwOiBlcnJvciAtMTEwIHdoaWxzdCBpbml0aWFsaXNpbmcgU0QgY2FyZAo+ICAgbW1jX2hv
c3QgbW1jMDogQnVzIHNwZWVkID0gNTAwMDAwMDBIeiAocmVxIDEwMDAwMEh6LCBhY3R1YWwgMTAw
MDAwSFogZGl2ID0gMjUwKQo+ICAgbW1jX2hvc3QgbW1jMDogQnVzIHNwZWVkID0gNTAwMDAwMDBI
eiAocmVxIDUwMDAwMDAwSHosIGFjdHVhbCA1MDAwMDAwMEhaIGRpdiA9IDApCj4gICBtbWMwOiBl
cnJvciAtMTEwIHdoaWxzdCBpbml0aWFsaXNpbmcgU0QgY2FyZAo+IAo+IFRoZSBTRC1jYXJkIHdh
cyBub3QgdXNhYmxlIGluIHRoZSBmb2xsb3dpbmcuCj4gCj4gUmVhc29uOiBTaW5jZSBjb21taXQg
M2YxNjI4YmFhNTFlICgibW1jOiBkd19tbWMtcGx0Zm06IFVzZSBwaGFzZV9tYXAgZm9yCj4gU29D
RlBHQSBjbG9jayBwaGFzZSBjb25maWd1cmF0aW9uIikgaG9zdC0+cGhhc2VfbWFwIGlzIHVzZWQg
aW4gb3JkZXIgdG8KPiBnZXQgdGhlIHBoYXNlIHNldHRpbmdzIGZvciBNTUNfVElNSU5HX1NEX0hT
LiBUaGlzIGlzIGRvbmUgaW4gZHJ2X2RhdGEtPmluaXQKPiAoZHdfbWNpX3NvY2ZwZ2FfcHJpdl9p
bml0KCkpIHdoaWNoIGlzIGNhbGxlZCBiZWZvcmUgZHdfbWNpX2luaXRfaG9zdCgpLiBBcwo+IGhv
c3QtPnBoYXNlX21hcCB3aWxsIGJlIGluaXRpYWxpemVkIG9ubHkgZHVyaW5nIGR3X21jaV9pbml0
X2hvc3QoKSwgd2UnbGwKPiBjYWxsIGR3X21jaV9zb2NmcGdhX3ByaXZfaW5pdCgpIHdpdGhvdXQg
dGhlIG5lZWRlZCBkYXRhLgo+IAo+IENhbGxpbmcgbW1jX29mX3BhcnNlX2Nsa19waGFzZSgpIGZy
b20gZHdfbWNpX3BhcnNlX2R0KCkgaW5zdGVhZCBvZgo+IGR3X21jaV9pbml0X2hvc3QoKSBlbnN1
cmVzIHRoYXQgd2UgaGF2ZSB2YWxpZCBkYXRhIHdoZW4gY2FsbGluZwo+IGR3X21jaV9zb2NmcGdh
X3ByaXZfaW5pdCgpCj4gCj4gRml4ZXM6IDNmMTYyOGJhYTUxZSAoIm1tYzogZHdfbW1jLXBsdGZt
OiBVc2UgcGhhc2VfbWFwIGZvciBTb0NGUEdBIGNsb2NrIHBoYXNlIGNvbmZpZ3VyYXRpb24iKQo+
IEZpeGVzOiAwZDk0NDU3NmM5OWUgKCJtbWM6IGR3X21tYzogQWRkIHBhcnNpbmcgbW1jX2Nsa19w
aGFzZV9tYXAgc3VwcG9ydCIpCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPiBTaWduZWQt
b2ZmLWJ5OiBPbGl2ZXIgQnJhbmR0IDxvbGl2ZXIuYnJhbmR0QGxlbnplLmNvbT4KPiAtLS0KPiAt
IFJlcGxhY2VtZW50IGZvciBvYnNvbGV0ZSBwYXRjaDsgU2FzaGlrbyBoYXMgZm91bmQgYSBtdWNo
IHNpbXBsZXIgYW5kCj4gICBjbGVhbmVyIHNvbHV0aW9uLgo+IC0gTGluayB0byBvYnNvbGV0ZSBw
YXRjaDogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbW1jLzE0MDMxN2RmZjBmZWI5ZDYy
YjU4MGIxZTMxNzBjY2IxMGI4YWYxODEuY2FtZWxAbGVuemUuY29tLwo+IAo+ICBkcml2ZXJzL21t
Yy9ob3N0L2R3X21tYy5jIHwgNCArKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvZHdf
bW1jLmMgYi9kcml2ZXJzL21tYy9ob3N0L2R3X21tYy5jCj4gaW5kZXggY2Y1Y2VjYzU0OTFkNS4u
Y2Q0NDg5OGQ0NGYzYyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L2R3X21tYy5jCj4g
KysrIGIvZHJpdmVycy9tbWMvaG9zdC9kd19tbWMuYwo+IEBAIC0yODUwLDggKzI4NTAsNiBAQCBz
dGF0aWMgaW50IGR3X21jaV9pbml0X2hvc3Qoc3RydWN0IGR3X21jaSAqaG9zdCkKPiAgCWlmIChy
ZXQpCj4gIAkJcmV0dXJuIHJldDsKPiAgCj4gLQltbWNfb2ZfcGFyc2VfY2xrX3BoYXNlKGhvc3Qt
PmRldiwgJmhvc3QtPnBoYXNlX21hcCk7Cj4gLQo+ICAJcmV0ID0gZHdfbWNpX2luaXRfaG9zdF9j
YXBzKGhvc3QpOwo+ICAJaWYgKHJldCkKPiAgCQlyZXR1cm4gcmV0Owo+IEBAIC0zMTQzLDYgKzMx
NDEsOCBAQCBzdGF0aWMgaW50IGR3X21jaV9wYXJzZV9kdChzdHJ1Y3QgZHdfbWNpICpob3N0KQo+
ICAJaWYgKCFob3N0LT5idXNfaHogJiYgIWRldmljZV9wcm9wZXJ0eV9yZWFkX3UzMihkZXYsICJj
bG9jay1mcmVxdWVuY3kiLCAmY2xvY2tfZnJlcXVlbmN5KSkKPiAgCQlob3N0LT5idXNfaHogPSBj
bG9ja19mcmVxdWVuY3k7Cj4gIAo+ICsJbW1jX29mX3BhcnNlX2Nsa19waGFzZShob3N0LT5kZXYs
ICZob3N0LT5waGFzZV9tYXApOwo+ICsKPiAgCWlmIChkcnZfZGF0YSAmJiBkcnZfZGF0YS0+cGFy
c2VfZHQpIHsKPiAgCQlyZXQgPSBkcnZfZGF0YS0+cGFyc2VfZHQoaG9zdCk7Cj4gIAkJaWYgKHJl
dCkKCkhpIHRvZ2V0aGVyIQoKUGxlYXNlIGZvcmdpdmUgbWUgZm9yIGFza2luZywgYnV0IGlzIHRo
ZXJlIGFueXRoaW5nIEkgY2FuIGRvIHRvIGhlbHAgdGhpcyBwYXRjaCB0bwpnZXQgc29tZSBhdHRl
bnRpb24/CgpUaGlzIGlzIG15IGZpcnN0IHRyeSB0byAidXBzdHJlYW0iIGEgcGF0Y2ggb2YgbWlu
ZSBzbyBJJ20gYSBiaXQgbmVydm91cyA6LSkKCktpbmQgcmVnYXJkcywKT2xpdmVyCg==
