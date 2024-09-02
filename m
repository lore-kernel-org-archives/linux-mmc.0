Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7A41E51D;
	Mon,  2 Sep 2024 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273636; cv=fail; b=sc+gFRSUmEnVXY73j5RZ/zb92qrmHjaY+KSaC3wJt7zrOTcYepzAuPvo7hOEs+dI1S8pmwofnNZz3Uaunj5PhLksiWhu0e2oF1tmmPPKlz11gUYVI8R+O/OhPm7za/QPQg/L3YrvQU4d9L3vcVZ8JSGMqzBEltai2APAV0j83/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273636; c=relaxed/simple;
	bh=BjNyCUoF6Y4ZuGs/ZCjd+J6ZowfMziPTIzAtT+TMS9A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oi1uVutJGV2MoRWPo0ZhrXGrYug1tVz8SCQm1ua+EnDDBnAe0zoCI3K7oZJwPCyGmmDH+/Lf95QWTkLJitOWPCi78KUtb9Ter1ODfyPPwA09KVmvWCety/TptLi30WiLbaMsFosr9kLvCwlqxR9OltyAtGEvtj0SHDSA8cohU+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XdjEl5aG; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XdjEl5aG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbpA6NcEiO8+PipcTL8PvbnwkRao/lt4RZxK8yY1pbBHlwIfbNCASj2iH8yi/gi10Hc/Anp05S7qMqfDlXP49cueRnRAJGvp8RVFVEcDTmi6AwTlwBr7RdX5jRP4OlIytX4Y3z6CPriMz9MzcssaYi1V4GLiM8A18V0d93sSESxjDn1suhOybLaD0Wmyy1KV9ADGTRroKZUaWuuqpYaXzKYEyLb7zXKxTbFfHuLnLPvTVi3ZK2VPvwr8SEqVW0qVbpQGEL7oyCTY2GESTBTFs9ITwGAYSVI3qPlFyWehFdOBpJ83pnJ3i8ccz9k0iWzIdYM39r8oG/lgr+sh1HAvTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjNyCUoF6Y4ZuGs/ZCjd+J6ZowfMziPTIzAtT+TMS9A=;
 b=lsnICpqZ9JAmWNzGPF2aDn2dMmUQ34cDEaJkiVhRJBCznmfI/Xdwxu3zSD09GZV75ar/EQ27liMJmMDY4gp6nTWYpiSIEjXUlxAsinN5mdRHavc9aYlAgJO7xHoW2tqTcT3cLoLeRP13XAl2TbGHUlOPLNAPyBKlAjgCFdkhbQcAvTSWyZXCP9oTBXt0SIA1VFz6FqsPoaJn6QCqo3uIERrc06kOy3ZqOmLul6wcsjeTesBifdhYRaBC36z+bEhKFZnXbQHvo9u6smYcANyIsPh3J1VaP/jvGW0MMfA8QFJgCfetAbaZUoXtwZAu2Ck5WYxiW5o0YGjaFCPwGFS9Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjNyCUoF6Y4ZuGs/ZCjd+J6ZowfMziPTIzAtT+TMS9A=;
 b=XdjEl5aGt+ql1Edf4NBf7FBnKBlWlbdN1IXX7TcOZQBlRTn+HQbvS5MuihyUUMa9JTVn7RPkLoOVoYmqDPk/li1DSBtoo6m+K38Hoxg96A1E1YpLjE7CwtYe4SK7uO99OQYQtflGI4JpNS6GI5mit+JmOgtgGV6m60qLTBeT3v2bhfm3hw7Ezk4GLpClcH+G8x/gxuNc4J5O2rAYCDzh9dsjHg2vr4BAaHGxw1c0BOraBkz7FL/WfNKu9bU2MGasBiDS4yRD3P8RDkv01pEpb7pUUXsYyHlxp86biYena+6Lmvfcgg2X/B2UL1PQc4q2u7iLBUiiafuRR+4lZA1XWw==
Received: from BL3PR11MB6436.namprd11.prod.outlook.com (2603:10b6:208:3bc::11)
 by LV8PR11MB8698.namprd11.prod.outlook.com (2603:10b6:408:205::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Mon, 2 Sep
 2024 10:40:29 +0000
Received: from BL3PR11MB6436.namprd11.prod.outlook.com
 ([fe80::dbcf:4176:b06b:3aaf]) by BL3PR11MB6436.namprd11.prod.outlook.com
 ([fe80::dbcf:4176:b06b:3aaf%3]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 10:40:27 +0000
From: <Dharma.B@microchip.com>
To: <krzk@kernel.org>
CC: <ulf.hansson@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<Aubin.Constans@microchip.com>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: mmc: atmel,sama5d2-sdhci: Add
 sama7d65 compatible
Thread-Topic: [PATCH v3 2/2] dt-bindings: mmc: atmel,sama5d2-sdhci: Add
 sama7d65 compatible
Thread-Index: AQHa+uxFfu+1V0z6EU6+8OxYXtwdIbJA5e6AgAAZVACAAGHwAIAC8gAA
Date: Mon, 2 Sep 2024 10:40:27 +0000
Message-ID: <428294e1-fcba-4be1-bc4c-060a09224bd0@microchip.com>
References: <20240830-atmel-sdhci-v3-0-7c97a0872af4@microchip.com>
 <20240830-atmel-sdhci-v3-2-7c97a0872af4@microchip.com>
 <3wysn3i3syox3n7howwnewuy6h7457goeafbrilptewxyuqitr@cdyjlzp5s7bu>
 <44e7a3a4-52f9-4985-b2dd-2bcf35d34737@microchip.com>
 <d275ea37-735a-4203-bb17-f0cd2320df07@kernel.org>
In-Reply-To: <d275ea37-735a-4203-bb17-f0cd2320df07@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6436:EE_|LV8PR11MB8698:EE_
x-ms-office365-filtering-correlation-id: 68c6a177-5c88-4433-4a8c-08dccb3ba885
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6436.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WktCaEdZUmkwUEwwd0paZmpsRjZ0SjB5OVh2bCtzM2l5c2s0TldGV2ZPOFdi?=
 =?utf-8?B?bU80SElEYVF3N211N2MxdzExSUZuc3Y3U1I5SXlRaWdEdzFRQTlLQVB0eHRY?=
 =?utf-8?B?OUZ5bnZTQW9iU01aUG1jbnFhaWRsaVo4dFdvSy9ib1lTUFJjOG12MXFaZVVD?=
 =?utf-8?B?RzVvR1htWVJBeUx6WGdXMW90d251SzNWaUo0cjFLMGtoUlRNN3VRY1JIQU9H?=
 =?utf-8?B?QjUwYXNvS2FIVDNaOWIyekR2RzhDMElaRHh0eXpmdCtXV093UTlhMzUrOFZS?=
 =?utf-8?B?ZHhMTUtrM0VyaW0xSUxjaFliQThyTHBRc2xLcFFvNmtXUDIyN3VKamc4cVhQ?=
 =?utf-8?B?Z3VaK09YTEVkMFZiS2ZhbVZXVUNLeVdvZFlYZ0lUdWUrMjJreVE3ZWRyR2Rr?=
 =?utf-8?B?MXBSTWxRZUJsaHU2SFhPYWdreHZoMThjVitBcDA4U3FZTHhFVHQ2R3dPcWxZ?=
 =?utf-8?B?dTlCUm1TOS8zZTR2aFBPRFBJc1NJczBUd2FQN0RDTDZRU1lGcWRGYWNENXJ5?=
 =?utf-8?B?Znppb29GNlZHRjRMaktaYWpac2xyeEdJVlRDRXNwNG1lWG4rV0VrckQyaXlK?=
 =?utf-8?B?UTg3czQ3cFdaWkJ5ZUxYNmwrRmJwNjBpUzhtQzYxZk5idFJRS3BCTXZ0emI1?=
 =?utf-8?B?cW9EdzExODZRV0I3bWhaNG44K0kzNTFJMDFzcWZyVVM3UnE4TEU2bSs3OEh0?=
 =?utf-8?B?S0xsNkdiWkdZVHJXUkF2cC9LS2RyN2dFWXd0eS9VME0yY0k2czIxUVYvNWhm?=
 =?utf-8?B?dFhDVmFiT2VPUXhEZlpudGFCNnVCMk92UXdyaFVYUkxrM1JwTTg5cmw5Rmdv?=
 =?utf-8?B?aFF2Y1VGSUEwVEJwMlgyR0ppWWl4azRWbUhucVFvMW94R0cyVDZybTlPMS82?=
 =?utf-8?B?c2MyRDcwSURnNy9SbGNsUUZLQ0FNZTRld285N3J3dzZ3VEd5aVdvUXNIQUNS?=
 =?utf-8?B?U2FKb3VsOHcxYkJwTklKQ200K2liLzZUSVBtMlIyMm83cEgzZ3B5b3pFQnhO?=
 =?utf-8?B?VTQrMmRpT2x2NE9oQjlhY0VKWkhhOHk2WVlNbUJ5MkV5OUxpbzR1aGNSRk1w?=
 =?utf-8?B?eFZEYjlLUkJNTmI5KzBGR3pPZ3BjRkh6OEg0NjcrcnVnRDNFaEE2cm1hSXZL?=
 =?utf-8?B?disvV0c5Yy9KK0tCRWh1T0pVTnJ2c0xncDd2eWFkSkRWQlFzNTR3bm45RllK?=
 =?utf-8?B?UVlDR0dVY1d6N1U4ZEowTnc5ZzVhMzVvMWF4SnhRUU9GSHkyWlJwVTQ0R2lX?=
 =?utf-8?B?REVvWWdpTXYybUdHcElaWDk3dGtNamVRVzVVbkFJOVJVVC9FWm41QTFUMUph?=
 =?utf-8?B?bm1kSThhQTlUSmFvVjZVTkkyekdjemhWTC9nVnRpTTBBQ2JZcEg5MWZCaWth?=
 =?utf-8?B?V3lCL2RCdHF3N09yZkR2S0hUU2tWbkpTWmJYT3RkNTZMdHZLRGg4V01zRDRy?=
 =?utf-8?B?TEI5RStUcUNHZUYzYW1EVHBzVFBCZDJkYjdVSTM4Rzh1K29RemViMWlPcU9p?=
 =?utf-8?B?RzRDYmtYSWF2Qm5JSTlNeTMrRG5TL0xKSURTVTl2bUxSSC82ZjRpZnNiUS8y?=
 =?utf-8?B?cDVXcDBTcFhtUmNTNGdOUTF3dkYzVGh5cmxNREduY2F4VVRIN2ZNYmdta1Bp?=
 =?utf-8?B?dGYvdkhHd0FnTVh5QlZucUVRN0IxMUVHeU1RQWUzWHY3dWJrT2hodUkwZ1NS?=
 =?utf-8?B?NzRxV0xMQXE4RUt6VzNkaXYvbytqaEhFbWY3cXpBVWpaNnJjZjlNVmJyU1pW?=
 =?utf-8?B?SENTbnp5UlZMN1czaklVTXlSSkJsMGZVOHJKQ0t2V3FVbWJEOTJ1NzgrVC9Q?=
 =?utf-8?B?NHpDYXpxNkxZZWJRV2VZKzFVZjVqSHFXL2hpbEFUYjJiVTh5MWh3M3ZCeDV5?=
 =?utf-8?B?eWRhMTEvMUdiSXNHL25hekJabUVDanhBMlh2ZkkwaHBab1E9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?clk2N204elVJeFkwK1hKOWdkN2t2TjR3UWdmZ2JYejlJVXJ0V0FoU0ZRTVpz?=
 =?utf-8?B?MmYzcEovWFlmVm5Icm96WFBuRkphdXFCbXNMdlEwTks1Mmc4bzdUekJOT0RJ?=
 =?utf-8?B?eTJYTDQ4R0Z6MWg1RDI1Y3A3amFMVnc1YjVvcE05QmdCMTgxVzJFRHdPaFdT?=
 =?utf-8?B?Z1cyMGJHamEyNlE5QVk0WHJvc2V6OWl2ZU00ZzlJd0NrQ1FxZXFFM3l5YTFs?=
 =?utf-8?B?N2JXMDRKMUJDd2NLWENjdkwwSGNwQzNYVFdBY2QySDVzM3FPU21LcVdaa1U2?=
 =?utf-8?B?dk5FYmNoNTNDVGR6aFBzNWl1NlBWRGhGeXpCSUZHTis2TUpxaUJxNHpIYVZG?=
 =?utf-8?B?bW9oSlU1bUZmMld4RlZqV0JhTjhyMlQ5Z1Raa3dRUFhQTVlXU053MnRQb0lz?=
 =?utf-8?B?S3FYTVJaVFB2aUV2VWJyU0J0MlZaYVpUNVBSbDRxcXBjNVN5MVpTVko4RGFV?=
 =?utf-8?B?MHZxZnBPY2ptRGU3c0ZvM3h3aS9xWUJweUVuMmJzekNySkJBc1VaYTB2bnVo?=
 =?utf-8?B?SEhSKy84aFVpVXlGWnJ4MmVNUndSVXVXZXcvSDN5dXlqV20rQUx0UzY0M2kr?=
 =?utf-8?B?dnUzRG9GTGFXbDZ3OVFqaGhXMnBidEphL0wyS01nZ3hKRnRNQ3FEcmUvYlNL?=
 =?utf-8?B?RUdZME5PNmZkcXA3NDcrT1RkSmpuYlhyNlQ5Z1R2WVdrR01RUGJhVXozbFoy?=
 =?utf-8?B?Wml5aHdPMDhhckpWczExTW5XbWh4SWdLME9PcllxTFFVL0dIbG9Wb3lLME9p?=
 =?utf-8?B?ZHBpZ3pGNTVhN2krMUlLK0grdkNhd1hRSEswbmV3d3J0R2t4OWs2a25EME5G?=
 =?utf-8?B?aVIyMlE3MUwzYWI1czJnd3F5WHlhek1IeTJlcU5NZW05Y0lTRURjaVJXYTlr?=
 =?utf-8?B?WjlvenVTbzFuV3ZKdnR1MXYzRGVvQm05bDRDSWJhRy92UEVMd2gxZi96elhR?=
 =?utf-8?B?RVUxQys0VitiU2lKazlZeWFKRktxclhuRE5hQ1I3SmpLMis5SUxpbTBpeU9t?=
 =?utf-8?B?K2t5OVp6Y016QlFkYXZRYm9lVXJPWlVFRFhpYzlTUnZ0SWhVTHhicG43YUhr?=
 =?utf-8?B?Z0g2aEVWQmFHZ1VzbHpjR1hwa21teTl3MHdEQ2pFSmd4WnR0aVhoVm5PalQr?=
 =?utf-8?B?aE5hSmh0eG9hdjNBVkRNK0pJWWk0UDBOVmJTREtEWjM3N1AzcnM2NjJIMmlT?=
 =?utf-8?B?Lzl6aXh2MUdsOEpoY2V6MDN3TFIvS1NqS0JvVXZvZkFuYmdoQ3YyRXJwZXFs?=
 =?utf-8?B?Z3E0UWtGS3hFdzlsUnI3czlrR05SeTZSdWlWOXVCVjF5eVl4QVArNmJGd1Na?=
 =?utf-8?B?RWgyc3FWQ3hqZFNNUjNxa3BJNDVVTEtielB1eXIxUUhjSG1yd21NVjJodFh0?=
 =?utf-8?B?aWhUNDFaaVVRc213MlhTUy82MlMxUzBIRCsxTmNPanNLWEQ0b2FqaW1mZlN5?=
 =?utf-8?B?VmNZT1EvTXhuZ2xmOTY3Y0tra3lOMHBURm5ycUsvRXhyY1gzN3grZlhaWkdK?=
 =?utf-8?B?QkhMWXN1Ri8xVzVrTG1zaE1qczRtdFo1MnZaK2Y4bzBYSUhpZ0ljZE9PTUYw?=
 =?utf-8?B?UW5UQlhnZUFhWW1WUE5kenJQaGtKcFJ5USt2d1FPWEdDandTNEtURVc0UVVj?=
 =?utf-8?B?dDBvTzRBcEZvQVJCaVZDaHVxWVEzWFg0QTZrODNEUTN5WUNCYUtJZ0Vhdi9k?=
 =?utf-8?B?NUxtM3ljdFV5Y2x5TkRHMzlrdmZucjM5eXp1T000dDMra3djT1FiaGFpRk9T?=
 =?utf-8?B?WGNBZzNwZTQxQWdtcnF3NXREYUNKK0xWMzRhVXBDcFdsdmx6dU1xZTBZejJ3?=
 =?utf-8?B?WVpjSnR2cnc0Y2FDZ2kyZW5sK1IwN2lzbmFuVVpodFNMOWFua1poOU1xcVZy?=
 =?utf-8?B?YzM3a0o4ZHo4a1RVK2NzN0Q5UXh4TGRmWEtNbUpFaGNtSHFodmYzMHNZNEhi?=
 =?utf-8?B?Q2Z0UkZ5cE9JemxVNUtmL1BzTXNreHpudzlaVXFHMkRkREpUSVViWTNVald5?=
 =?utf-8?B?MUxRRVg1akJNL21nZnhWdWhTdE9Bb2pYV3VySEJBM1gwdjhCc3h3c2pZUTVZ?=
 =?utf-8?B?MFlsWUNudzN3MWlqelNpVFRnZFdyZzBtT291cU4xTVJ1TGRCbXFJOFZLL0J6?=
 =?utf-8?Q?XEvbuamczlv5Bv8+Dg3dZbAlD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0D35986C8243D4BA52FAF34838F324C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6436.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c6a177-5c88-4433-4a8c-08dccb3ba885
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 10:40:27.0550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oKS5misoq0AahJykaijfK2ETIP8vfQf61+UspphUA4dqWCO+W7ad2jbrv20kugPfUcwmRA7lDvc29BgYIaTWCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8698

T24gMzEvMDgvMjQgNzoxMSBwbSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAzMS8wOC8yMDI0IDA5OjUxLCBE
aGFybWEuQkBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gSGkgS3J6eXN6dG9mLA0KPj4NCj4+IE9u
IDMxLzA4LzI0IDExOjUwIGFtLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPj4+IEVYVEVS
TkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4+DQo+Pj4gT24gRnJpLCBBdWcgMzAsIDIw
MjQgYXQgMDg6MjE6MjFQTSArMDUzMCwgRGhhcm1hIEJhbGFzdWJpcmFtYW5pIHdyb3RlOg0KPj4+
PiBBZGQgbW1jIGJpbmRpbmcgZG9jdW1lbnRhdGlvbiBmb3Igc2FtYTdkNjUuDQo+Pj4+DQo+Pj4+
IFNpZ25lZC1vZmYtYnk6IERoYXJtYSBCYWxhc3ViaXJhbWFuaSA8ZGhhcm1hLmJAbWljcm9jaGlw
LmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tbWMvYXRtZWwsc2FtYTVkMi1zZGhjaS55YW1sIHwgNSArKysrKw0KPj4+PiAgICAxIGZpbGUg
Y2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+Pj4+DQo+Pj4NCj4+PiBXaGVyZSBpcyBhbnkgdXNl
ciBvZiB0aGlzPyBXaHkgYXJlIHlvdSBhZGRpbmcgYmluZGluZ3Mgd2l0aG91dCB1c2Vycz8NCj4+
DQo+PiBXZSB3aWxsIHVwc3RyZWFtIHRoZSBzYW1hN2Q2NSBib2FyZCBkdHMgZmlsZXMgc29vbiwg
aGVuY2UgYWRkaW5nIHN1cHBvcnQNCj4+IGZvciBpdCBiZWZvcmUgaGFuZCBpbiBiaW5kaW5ncy4N
Cj4+DQo+IA0KPiBOb3Qgc29vbi4gVHdvIG9mIHlvdXIgb3RoZXIgcG9zdGluZ3MgYXJlIGNsZWFy
bHkgd3JvbmdseSBzcGxpdCwgc28gSQ0KPiBkb24ndCB0cnVzdCB0aGlzIG9uZSBlaXRoZXIuDQo+
IA0KPiBQb3N0IGV2ZXJ5dGhpbmcuIFlvdXIgZHJpdmVycyB3aXRoIHRoZWlyIGJpbmRpbmdzLiBZ
b3VyIERUUyBnb2VzIHdpdGgNCj4gYm9hcmQgYmluZGluZ3MsIGluIHNlcGFyYXRlIHBhdGNoc2V0
IChvbmUhKSB3aXRoIGxvcmUgbGluayB0byB0aGUgZHJpdmVyDQo+IGJpbmRpbmdzIHNvIHdlIGNh
biB2ZXJpZnkgaXQuDQoNCk9rYXksIEkgd2lsbCBkcm9wIHRoaXMgbm93LCBJIHdpbGwganVzdCBz
ZW5kIHRoZSBjb252ZXJzaW9uIGZyb20gdGV4dCB0byANCmpzb24gaW4gdGhlIG5leHQgcmV2aXNp
b24gb2YgdGhpcyBwYXRjaC4NCg0KV2lsbCBzZW5kIGl0IGFsb25nIHdpdGggdGhlIGR0cyBhcyB5
b3Ugc3VnZ2VzdC4NClRoYW5rcy4NCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YN
Cj4gDQoNCg0KLS0gDQpXaXRoIEJlc3QgUmVnYXJkcywNCkRoYXJtYSBCLg0K
