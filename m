Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2050.outbound.protection.outlook.com [40.107.247.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD701D9341;
	Mon,  7 Oct 2024 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315168; cv=fail; b=jH0pifIRZbkZSvkjf8dfWT8dM8yZer3USYrQpWlgccr8FIJAzAymCPK2hPRew5CnrDl41G+wtBaaEj/z4nHtRfJbnEF6T2in8nV9fewuqDA4gcIRsFcTmEqVySsgduFo4I2PVF3ZSlZSrgBYZ15lA8dklQ+75FGK7HFaU00dHA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315168; c=relaxed/simple;
	bh=9aXEn+qGJCLER32ZXK/tnXbueuJAVT/aC34BvEarQQY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cu4EP3KxVS0JSkL9V/utx/TbPz1Iw4OFt9DWwtjTYg92gSdHwlJ0/EpMT9weGvnd8ecIpRUt85rthhXR2dzdF9qYgW0cnuMfjVZJ6GdH3is4JkysIA2VGMDJpdi2FzWyUzr0IkvJGQ3ESLR/RTd5r2NJcq9mnz854MKbieIS/64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=h71tizeT; arc=fail smtp.client-ip=40.107.247.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="h71tizeT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oy5emyblTHNRZuEl562P/ONkUslA+xDYdK91pRvzVP2idDwS0Zi482r4zoyA8btRpMMpc5ut1wNWNwsLoCvfvueF59weUcyoSZGT8j9pq+4mB7ttFLsnzl2MTq+yBnBoTmMz01xyWkFZfRCExQ0TXv9pQSa3QEuPlmIUEF/ql4Uv34vdkQg3KmUcrFs1u8yHsSegfO+ZKcuA1dVXVjB5TeY+xBvMer9/EiLGi1vHQ73DJKavn0VW18dMwJPlVsi5gW5ovzR/j8IZZ4kmAz5MLfdqwemDUSXhN8YY/ha4XfNsARugVwsI9kFNDH7cBHMGNb2XNWncLQTk2TUD1PCgLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9aXEn+qGJCLER32ZXK/tnXbueuJAVT/aC34BvEarQQY=;
 b=MQVHWM/aj3nmTZRjyy32jSXO2EsGWiVGOCazM7YpMBhMINddUtCZv49GQABwPi3krUMu35CuTBOlBnk7KjT8nd0YWN0LBtdRyFmGegYb2kysJ8p2XuOYPxM4RcDm4XpcSesgp+60VhuFiPTWfXO1jaa4i5mAf2M8qW52rWqBPp+pvNUV5F/Wq67YhnX653etujvX1EiMH64h8zb5dUibmkxlmqObQKiaobrfl7N0HV4uDL164ns9mcD6FdsHRwmxbJ0fskgXpGmGu9U7f/dgwxPbKVAL4nq3FWM/g5Z/mrv+/DtxjpbrFh4ebpk7uM0BiEKv8Ick3zrLuPMOTXfKIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aXEn+qGJCLER32ZXK/tnXbueuJAVT/aC34BvEarQQY=;
 b=h71tizeTk5rqEAYHjn2+L2s3SjAo32QClKhhh/8b/dRzAJ1RafwtsMeILkwDF3yzohlIzdR6BP/iSKLNE6HlyygXDtP01oJTG87vxSAVYB0p5JQ0VQv4h8vs1ZuDsZsG/gqpsHlkyVrhSPHPfirQDTE6CWUnPtyU0YcjwFAiuUk=
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com (2603:10a6:10:1a0::11)
 by AM9PR06MB8052.eurprd06.prod.outlook.com (2603:10a6:20b:3a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 15:32:42 +0000
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0]) by DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 15:32:42 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Rob Herring <robh@kernel.org>
CC: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: mmc-pwrseq-simple: add support for
 reset control
Thread-Topic: [PATCH 1/2] dt-bindings: mmc: mmc-pwrseq-simple: add support for
 reset control
Thread-Index: AQHbFlYFMAy48xaGhkKxPcYJRjcHabJ4e4gAgAL0GAA=
Date: Mon, 7 Oct 2024 15:32:42 +0000
Message-ID: <92a27d06-cd37-42ff-ac48-687981d24d41@leica-geosystems.com>
References: <20241004120740.2887776-1-catalin.popescu@leica-geosystems.com>
 <20241005182632.GA496820-robh@kernel.org>
In-Reply-To: <20241005182632.GA496820-robh@kernel.org>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBAPR06MB6901:EE_|AM9PR06MB8052:EE_
x-ms-office365-filtering-correlation-id: 1520e342-8851-4c8e-2c0b-08dce6e548d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S2N2ejVKM3VNNS9EaE1YU3R1Wlh2WHVtZGh5YmVxZk1rbnFRZzBWaGVKcDds?=
 =?utf-8?B?czExc0ZyOVF0c3hlU3haaE5ob3ZVaEhud1pMZFBmMmhNMzdSc0ppc0tBNmZ0?=
 =?utf-8?B?K2phdllrRGlZcldiVWswYktLbFRhcFJWNXN0QW1IQVVmVE9vbmxMYWVkTEJK?=
 =?utf-8?B?VVl1OWRhZjA2alRkM0QzUWJ4Y25EclR5Z0krUkZIVXhXVlk3bEVsV2hVcldT?=
 =?utf-8?B?dEFrWWF5dEdlcVZ0bHpJc0gveW9EWDlLY2ZQbkxMZDIyMXpxYlpYbndDL05Y?=
 =?utf-8?B?cWtvZzhGMVBIVVozK0tpM05rVmxpYzFobklSTzN0R3JJMStuZWxyZTZYK0l0?=
 =?utf-8?B?Z3FGeWk1c2FMa0JNTFFCR1lYMFF4L21jWEkvNlcxNUNINFpzNjBDWXFkeXQz?=
 =?utf-8?B?YmtWL3lUOG1ZTS8wMHVBMU50OTQzcStraEdOdWVaODV5NmpRVStnSGl5NkFj?=
 =?utf-8?B?OUFmdEZLNG04clQ4Q2YxS3ZOaUw2RzZVcytVb3FheFdZRVNzNmVrR3RjVEVl?=
 =?utf-8?B?RW4zQm02MXZ6dFYyRDJvTnZuK0JQdW10dXpqV0dsZDM1TXlhV0RWc3dSVUQr?=
 =?utf-8?B?ZG52Tjdkd1k4VzU3bFdSNnJ0RGJRTytvK2NlbDBWNFpWdXZhN2FHc0ZtS1h3?=
 =?utf-8?B?WnRIRUpJOGVyNXBBZzhSSEsrWlEySmcvUFh2WmxuSm1oVnpxNlcwSnVyblc2?=
 =?utf-8?B?RHliYVJqSUVTNWZxQjFhaEp1UHRXNVRBZ0Q5NXo0cnRRbGlZaHZXNUF3M1N6?=
 =?utf-8?B?ZUI3WGtYLzZDd2JWZ09CMVlCQk4zb3V4ZFRhQXZLdVU1WmpmNHBrOG0rV0oz?=
 =?utf-8?B?bXlHcDd4aTUxSVBQZGFYQ3BheStoTThqQm13c1V6MGJTaSs0Z2ZZTDFGV3Fr?=
 =?utf-8?B?a2RXM2RNYWk1aDNZcXJqaS9FZmVlWFZBanErRjg1UUxJaTlWS1lqZUw1Sk9y?=
 =?utf-8?B?Z0VHM3h4NTU1TjhWenZRa3NZSHZtTzhqR2JPSXRoMW9HRG50ajlkdisxYi9W?=
 =?utf-8?B?KzN3MTZqM2U5VnNCMWJwUlUraHBKYXc0WXFpZmR4R2xxbjZ0eWRxMVkzQUF5?=
 =?utf-8?B?YlVVUGhjYzBvR0JBcjBTemlkNU5veUJFTTlyaXA4c1o3WUVGQXd2MHRnUDlZ?=
 =?utf-8?B?NWNmTEdMMFlXczlkQzk0cmxIb0tzMlVnUSt5azllK3drRVRteVRFUVZ0TjV1?=
 =?utf-8?B?aGFSWXoyYmhRL2JIeDR1ZlhmcHZiZFF1QnpKb3NJdDBUWWV6Y0F5ZHFnaXBC?=
 =?utf-8?B?SE9MV3R5QzI2dkpEcWJxN0xMRWZ3aTFEazZCdkJFSlVUbDZzSWVteVlXYVRQ?=
 =?utf-8?B?WkxFcnpoZE1iWHNTWnh5V3Z1eFJnSng3cUo2clIwcGR2RW5xeitxVkd1UTJw?=
 =?utf-8?B?clRHS1RURWxUbncrUlJDREJPWVhLaWEwUEhGeWpZMGJoamVMYkE0cGhsOVRl?=
 =?utf-8?B?K3FEbU9FTkN3dGs1U0lDenNweWo2RlpYWjh1amdoUjM3R2VlOVJyZnV4SDRM?=
 =?utf-8?B?Vk05WWZxZ3k5S1ZhMnRIajN4QXlUWTlKZ0ZyZmdNY05JdkhSRllRcFFTMFlD?=
 =?utf-8?B?UUlBVXB2dHZDL2VUTUVDSlJWN1ZLd25YdFFVZVBpVVVyWHVwWStXZHR4eVZq?=
 =?utf-8?B?dnBhd0RLc3VkNWw5QzhYMHZUc2FReTMya00wODBsTnl4Q0lkMzlFa1B0Njdr?=
 =?utf-8?B?NU53bUhYWTF6NFQvcWJJU0NCRVpSN2x4K3BOeVBLcHdESWdUZlBadkxHeEMr?=
 =?utf-8?B?aHdneFpYV1dTcXV3SlhTSnZUYkNNTUhJT2tJU0FMcHZmekgzSUs3ai9iOVhP?=
 =?utf-8?B?M2VSUHNBRWx2NExJWkVXQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR06MB6901.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?czY0ekx4RnJyZDFvMG0rS1ZCakhoazJ0TTFKYVdteGZCOVFicG5RczExVExj?=
 =?utf-8?B?M2NzUWNycHBwMWludDRHb2tVakRkd1o2YU1ocktpT1lVazlscUQ0WDhzYzhr?=
 =?utf-8?B?ZDF5UE82Q0htME4xVlpvRWxYWmxJdzYvaW5aeURFRHhhajNRbnZnWVlUdnFi?=
 =?utf-8?B?dW5MQTE3WTVDb0tqTVdBT0QrSXZLZTNYSk9VRVVLMmVWcjBZbE55UUZLRGxI?=
 =?utf-8?B?WnZrR0R1OUNTZWZrWmVEV1Q3RkpORDFaUXRsRWpTL25YR2tPRkVlajNUSFNz?=
 =?utf-8?B?WGRHUWdPNzhxeHIzTWwxRUt1Tko3MjkyaTVySXBvWEJwR1AyUVVvOFE4c1BP?=
 =?utf-8?B?dFVGY2NOSGZkd3MvQjVoRzRyUjFZOWdzYk4zLzJoZGFMd3AzUEpDVHNqR2pJ?=
 =?utf-8?B?V2huMUJzL0FCdW1tZXhnVEtkQXgwd0FDRlN1NklHb2kxOWdjK2tUR2xKQlBB?=
 =?utf-8?B?WElSdXQ0Q2kvVEsxNnRudTNWa1EzYzZXaHFNNHlBV3Z5eXFNYktWM1BpdTVs?=
 =?utf-8?B?am5pSjZNa2g3QVhUMXg0dG1sN25iQW9mQ1gyZjRkNVRhQWRrVEkvWGpaOWVw?=
 =?utf-8?B?NlBkRnlyck42WTZGbFFIRGJxRXdsenhGUzBzS1BvZHFyZ2VlTlJnZys1MUpD?=
 =?utf-8?B?NDNuS3BKZ2ZQdlV5WjhKVG1zZ0RUL1lFTWorTXBMTXlpbmVtWldRM2xCMzNh?=
 =?utf-8?B?M05DcHJ4bmlVanNCRUxIUFJ1SGt4SE5BRW9qUVRNU1VtK3VyZ1l5UHYyV04x?=
 =?utf-8?B?Rm9wUnN0QVQ2NktEM3dzajFvc2ZQeHV6ellmb0dHcDZqV1NzVW5Ga3UyZzJ4?=
 =?utf-8?B?SEUzZzJ1Rk1UeHIrQkVzZU9zWDVHQzIzNUpjUVFLMkNoeG1HOUxmQkUyWUs1?=
 =?utf-8?B?Y0txME5wd0RkV2p6V3pFbHdqMEN2UmJlUlh1ek95SzBwM1NsYnRESTJaekVl?=
 =?utf-8?B?WlJmZ0hlaTFJdTQxSE5PdVc2T29UUzcrRVNUbWtBckVCZUMrUWFOYVNrL1Av?=
 =?utf-8?B?VEFycUM2eEIraTRLV0dIYUxKTkw4NXNWZkNmYk5ZSDZMaXd3aXFKek93UTJq?=
 =?utf-8?B?OHJlMGU0KzJaY0M5Z1FaeDZLbVBMQWFnWXVSQ2tEMkxFcUpMM3NDMUNUaElo?=
 =?utf-8?B?bFZENzlnanlmeDRDd0FKWE42T05DRU95aUV5VnF2dWNUa0ZlSklmaE40dyt0?=
 =?utf-8?B?TXVYNHRCdjVsa1kyM2xMYnE0eU51RnRkVGEveFdWYzAwOURyZDRSbEg3dXU5?=
 =?utf-8?B?dTg5bGdVMlpLdWdnV2dmWDIrU2lZd2gyVnFqaFVHbEsvZEF6UitzRVpkNkl2?=
 =?utf-8?B?aFZJalIyNlEvR3dMQkxMZlBWRzFLTHhoTTdtWjdMTXNRQ3BTdG5zNTZ1MXFP?=
 =?utf-8?B?dENyUml5VGJWYXR4TmZuV2s5VEEzSEUyUU8vUmZpd2pNVTVaTjB2TjFpUE9E?=
 =?utf-8?B?Zmg4MVpDdXFmY29pdHNqQndlcHk4RElsdytBUDNRM0hBWUhoeXptMEo3MWI0?=
 =?utf-8?B?c0hjODlEZjNsejJrb0FQUlVHMDBBM2Y4ODczalkwTTBQbEVBSFBoUHRpZnVa?=
 =?utf-8?B?R2hsOXpibkZ2dU9KVkJBTFMxOXZvWHVnaXdkeDRqdDFTVDJ6WGNjU3ZXU2V3?=
 =?utf-8?B?SUtUL0UvekZ1dU1ZNG9JREMramFEWGx0YmFRbmk4QVQwaWpWMjRmTUxXRmwy?=
 =?utf-8?B?aWJQNmVSazdpaXlqeldGZGNWV3BxUm9kRXAxSHB4dlpkK203ZzY3azhiTXQr?=
 =?utf-8?B?b00xaC83MTdjV2w0OGR3RVgyTVAvVFZDU2dWZ1NHYWgweFBUd0JVREgwcFZ1?=
 =?utf-8?B?Z0VobFJjVnN1U0twNGRlVEJDSktaTE95WWgwTHZSY0FweE53M0R3dzFGVUJ6?=
 =?utf-8?B?WUtuWlIrc1F0dzJMcXRkUUg3MCtCQlNoaUx1U3RJR1RLU3dTSC9wa3JIamJJ?=
 =?utf-8?B?YjIyK2xraXpPNkp6NzZkQ1VPMVc2RG9ZYk1vTjNHaWNCbEo2K0t2cStvbDZP?=
 =?utf-8?B?dWRLd1BiMlZFLzF4NjRRajVBY1psTU01UWZ2S0gyYTRLeFErNmlVblNTV09V?=
 =?utf-8?B?VFVZeERJTWkwTlV2TGhocEFLR25zUUFBcE9BL1hwVUhKMEFJSTRiL29DT1Rz?=
 =?utf-8?B?d1RCckV1V1BYNkZleTNFYUg0N2lTcFV0NmFaT2s4cmI0Qk5JZ2tsQkJMeFB2?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E26107912E2404449C95AC2C6240A7B6@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBAPR06MB6901.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1520e342-8851-4c8e-2c0b-08dce6e548d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 15:32:42.2921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tIySjs0DBeziUNGKx2+MJ0jqEv1SvCq2C8ynGmO19aehdXCYzv+fezlmU2feZZI+vclVLPqJxn1lI1Hi3AqsMA88Z4o5+fXId64R7wG6GjTGJd7BgSly89Gers0HKRSF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR06MB8052

T24gMDUvMTAvMjAyNCAyMDoyNiwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IFtTb21lIHBlb3BsZSB3
aG8gcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIHJvYmhA
a2VybmVsLm9yZy4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1z
L0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+DQo+IFRoaXMgZW1haWwgaXMgbm90
IGZyb20gSGV4YWdvbuKAmXMgT2ZmaWNlIDM2NSBpbnN0YW5jZS4gUGxlYXNlIGJlIGNhcmVmdWwg
d2hpbGUgY2xpY2tpbmcgbGlua3MsIG9wZW5pbmcgYXR0YWNobWVudHMsIG9yIHJlcGx5aW5nIHRv
IHRoaXMgZW1haWwuDQo+DQo+DQo+IE9uIEZyaSwgT2N0IDA0LCAyMDI0IGF0IDAyOjA3OjM5UE0g
KzAyMDAsIENhdGFsaW4gUG9wZXNjdSB3cm90ZToNCj4+IEFkZCBjb21wYXRpYmxlIHZhbHVlICJt
bWMtcHdyc2VxLXNpbXBsZS1yZXNldCIgdG8gc3VwcG9ydCByZXNldCBjb250cm9sDQo+PiBpbnN0
ZWFkIG9mIGdwaW9zLiBSZXNldCBjb250cm9scyBiZWluZyByZWZjb3VudGVkLCB0aGV5IGFsbG93
IHRvIHVzZQ0KPj4gc2hhcmVkIHJlc2V0cyBvciBncGlvcyBhY3Jvc3MgZHJpdmVycy4gU3VwcG9y
dCBvZiByZXNldCBjb250cm9sIGlzDQo+PiBsaW1pdGVkIHRvIG9uZSBzaW5nbGUgcmVzZXQgY29u
dHJvbC4NCj4gQ2FuJ3QgeW91IGRvIHRoaXMgd2l0aG91dCBhIGJpbmRpbmcgY2hhbmdlPyBKdXN0
IHVzZSByZXNldCBjb250cm9scyB3aGVuDQo+IHRoZXJlIGlzIG9ubHkgMSBHUElPLg0KDQpUaGF0
J3MgYSBnb29kIHF1ZXN0aW9uLiBUaGUgaWRlYSB3YXMgdG8ga2VlcCBpbiBwbGFjZSB0aGUgZ3Bp
byBzdXBwb3J0IA0Kdy9vIGltcGFjdGluZyBhbnkgcGxhdGZvcm0gdXNpbmcgcHdyc2VxLXNpbXBs
ZS4NCg0KQWxzbywgbGF0ZXIgb24gd2hlbiBzdXBwb3J0IGZvciBhIGxpc3Qgb2YgcmVzZXQgZ3Bp
b3Mgd2lsbCBiZSBhZGRlZCB0byANCnRoZSByZXNldCBmcmFtZXdvcmssIHRoaXMgd291bGQgbm90
IHdvcmsgYW55bW9yZS4uLg0KDQo+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDYXRhbGluIFBvcGVzY3Ug
PGNhdGFsaW4ucG9wZXNjdUBsZWljYS1nZW9zeXN0ZW1zLmNvbT4NCj4+IC0tLQ0KPj4gICAuLi4v
YmluZGluZ3MvbW1jL21tYy1wd3JzZXEtc2ltcGxlLnlhbWwgICAgICAgfCAyMSArKysrKysrKysr
KysrKysrKy0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KDQoNCg==
