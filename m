Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2B7320F;
	Sat, 31 Aug 2024 07:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725090680; cv=fail; b=aELD2cECxBpQC/3bYev/AOw2UrABbXL6Cy0KZu2Ds0ThQM35eV6oilYrJsBy4l4+cAp4GDzlVWdcU4jZijPlyQjCQD0hyoS6ICcxiPuYLGuVtpftEK578g0n+2kWVsIyG6R2F1X5gSzy7NHIOS96zn/Xqpt6nUws79/hMF6CfR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725090680; c=relaxed/simple;
	bh=KKeeNw6xL862PS1G1Wf9MyWaWE8qpVoXJvP2+VGGs3c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ljkcwvZO5S4Ujr71YDYSZcB0TwjoJUAb7RRSrViIRBVVG6+L3V9nlbIR+buU7RCTZHZvA8Klg1zpjR/x/ue2SuiWpKbdME0XIFtY2ZwGyPJ+ul6bPR+5GiI0bG4cl1AZzHQXNwbLhThKfFsEF8diqzAkJFUDai+GEKLj+FN6C5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=to3f5aAJ; arc=fail smtp.client-ip=40.107.93.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="to3f5aAJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BpBHELj7nq7J9pcxlw66z9K8TtnBRAi6MtXSDgEEWzWHfqlHJ02oPLU1cxsfAS3Ve1hVZ35xyZCD9r1pRS2S32XrKTC4bFWLzxhwbVo/jAhAt6TIvCgmpf5myZHQusCjRpHKaXTLcrzlYwfmKwu5DBh2DCmYIvLS/mttdOpWPu6gxb+w8Kfh/8Kpa+UnnUy2IxNB75Ti4j9gtfrtHdegQSDnRHNNADbVcoKJl1Z3w4DqLdSYxpN7kdWTGBOUkV5URoBlaFw/mmD2chfQaiOyqeiIEqPkjzVNLlSvrYH9A5CZHlDJrUZFn/i5kSRQ22TI57v/H1qq80VH8ocfk1JHQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKeeNw6xL862PS1G1Wf9MyWaWE8qpVoXJvP2+VGGs3c=;
 b=BOG6JXayGimzPx3Eg8RxlWfzZf20FZOj02si0lGXuo2J5RAQprSxB5/Ff3Nv5BIt1UuCadF9CHqz846Me6Gu/DpLOKkP1vh37n9Z4aAj2rZ3GPlNk5S6qRsV8XserVrOkJyGqr8DVYxD/EYZquH+yhDvwOCEl7EjOba+WzqExp0UF+Bt4gCOCr9TPY7mYmMfKjjOSezfd3DTvPanXbH6izBOOKlVMjVnqYIl0w5VLWcIlMCbFrgPP7j9ucMAEcpa206JtwMMn6Dc9ySkQn6b9bE2L+emd3FueScOvbSzkFqgrfutOU9GrXpkeIn/a1m1SF3G9Udjd0k3+G/PV7K+2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKeeNw6xL862PS1G1Wf9MyWaWE8qpVoXJvP2+VGGs3c=;
 b=to3f5aAJtcJDzbvYqQ7PA3TFJZRTpZZcPzKUqLpPr467j9N06mPgWHZ8bgQ5aodqJTQj3WbAI7hsbBzN97tqikYwQlyJ/8OeWKrP68J2Zd+ts/FgmlQ5TgT2fIYcGgK0DceZ411omO6bfIKrZUA1JHJdI1PDyhDrT5GCmODCMqw7u+c9zm4Fr09ZKz7dT087fRQkbGCyKCUdHSdrJy+zxnqsrAUrtes8/MEKyWEFxC2XuRtlRlDTlhWyLo6UznE2x+ABmyIP5JZabAoLqzTy02853emKqPexR+Zb+W8HAJ/uFmOp1bW7Mi0oMXBNc5pe7UU0aQQQmCqLqyquol234w==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by PH8PR11MB6999.namprd11.prod.outlook.com (2603:10b6:510:221::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Sat, 31 Aug
 2024 07:51:15 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%6]) with mapi id 15.20.7918.019; Sat, 31 Aug 2024
 07:51:15 +0000
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
Thread-Index: AQHa+uxFfu+1V0z6EU6+8OxYXtwdIbJA5e6AgAAZVAA=
Date: Sat, 31 Aug 2024 07:51:15 +0000
Message-ID: <44e7a3a4-52f9-4985-b2dd-2bcf35d34737@microchip.com>
References: <20240830-atmel-sdhci-v3-0-7c97a0872af4@microchip.com>
 <20240830-atmel-sdhci-v3-2-7c97a0872af4@microchip.com>
 <3wysn3i3syox3n7howwnewuy6h7457goeafbrilptewxyuqitr@cdyjlzp5s7bu>
In-Reply-To: <3wysn3i3syox3n7howwnewuy6h7457goeafbrilptewxyuqitr@cdyjlzp5s7bu>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|PH8PR11MB6999:EE_
x-ms-office365-filtering-correlation-id: 8f6524c3-c4e9-4be3-1c15-08dcc991b115
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cFlwdnZFejFNd3k5ZytGVURwUGpJbUZZSU5WbWl4eVVZVlAxK2JqS2Q3dVRU?=
 =?utf-8?B?V3JiOUxocGYxZW1JUUlUS3c3amoxZ1RCamRVN3k0ME9XRnVRU1MzZjU2WWVs?=
 =?utf-8?B?bllhVG9Va2k1WS9XWG9USHA4ZVZzY0hNZlVsV0FPczQwNDl0dHhmb3l5ZC9i?=
 =?utf-8?B?S1hJYUpuSGJ6M0FIZ2NNVitndXMzNHBkNnNOZGtVOXFpMGRWTjZSV1lSSXFv?=
 =?utf-8?B?OUJBNVppQW41aHplTCs5R3dqTmwvQUI0d1dCZXdnZC9YN1UxUmZKakxnUVFs?=
 =?utf-8?B?eW1oa0x0WEJvT0hrTXd5MWU3ekhVVm9wOXp3WDZ3QXQwOWRVejh5dEhENFlV?=
 =?utf-8?B?REFVZ1Rybnp5VU5naThmV1RNb3FsbkcxNHhlZ3dmK2U5ZlF2elI1SmlXK2o4?=
 =?utf-8?B?MUlVNnhmc0pJSVl2c0lIWlo4SEd6QjVMRm5qeldzb2VKZXRRcFppSENkd2RY?=
 =?utf-8?B?M0NiYjd5SURqYmNDMHVONi8yZVdvQ0JsQUtMRFRHUURQbzNZWTU2c2NvMFVl?=
 =?utf-8?B?NytrdklUaVpKMEVocG1RUXlCcVpjdW9LZUNQaGhwOVJhRzVpbThJQmpBNmhG?=
 =?utf-8?B?V0tlVjVKQVJNaTZ2b2tGcW5pNEpOQklZM3RlV29zYmFZRVA0ZHJBWllVbHo3?=
 =?utf-8?B?VUNhZUI1aUlKeGEvL2lOTWNHTjJYQ2UyUkRmbUY3SXJ2MkhBNEJCUkFHZlVZ?=
 =?utf-8?B?QTF3YjJPWTVhNXArUndmOW00MmN6UUxVQU1QYTdCZVJjeTNyTGc1NFExRzgv?=
 =?utf-8?B?YS9IZXMxOGp5bDdab2xoNGVKaUpQTlVjenEySEVIakdOMExUN1dBSHREekZl?=
 =?utf-8?B?MVBhTHVFYS8xcFhRVDlFT1ZkZjZxVWdJNWMrY3JnWUZTbjNlK2N0dTRjZm1u?=
 =?utf-8?B?aUhodWFhRFlPZlZCK0ZNcS9IUExWcUVGYWZSSGY4a3pMWlpUME5yc0NIcERz?=
 =?utf-8?B?d2xiekxiMWZ5VWR5V2xBV3BoVHZUR0w5MEYzYU5xU1N2TGdwOFJyei9YVEx4?=
 =?utf-8?B?QitVZFRRR2VOaWJvdFBGRyt0cU1rMmpBUjBnRmxqUkN5WUdUVFR6a1Ywci8r?=
 =?utf-8?B?Vy9ydVptQ2J3YjlRaDRoWDVJbEIxSkxiTmpjWm5OL2MyUVpPcXo3VGRDTG83?=
 =?utf-8?B?ckx6bkpvWHBJRVBTbXM0cnBVQ2ZubW03ZitJU2NiSnN1NTRFWEFHWEpEUWtM?=
 =?utf-8?B?a3RKMUVRanVZa0NxN2R2Q0dJZ08yZ1NQWVB4Z1hXS1NyR1c4OE4xSEZlbDR5?=
 =?utf-8?B?SHJzcFVtUXUyNEUzRUhpRmV2UFkxSUpCYms1STdrdnRnRVNYbUhFUlhENFpu?=
 =?utf-8?B?UktGRGU3TVJFR2phWEZNTkZaYkNEZjNJNFJYNmJTT2hCa1VQRHVVU0Q2Sks5?=
 =?utf-8?B?TjBaTjVrQ244QnhkSUI4aFBZM0loam9iYnJvVm56Q1RpMGg3czVKNW5lclhL?=
 =?utf-8?B?VCs0VkcvVTg3NTBmYWVJb05LRUhyZ2MvYWRwQnR2ZHpVc284U21ESG0rTVR5?=
 =?utf-8?B?TzNCbW9DVTh6d2JEa0lKamN3MVJtcHBnUmxIcXl4UmNmK3g4Y01OcGVxbDda?=
 =?utf-8?B?WHJ5bDF1WFBWdm9yZEozOXVhM1VVcEZJZmxXeVlkVndQTU5OYVAxQ3pQVSs5?=
 =?utf-8?B?dEJTWU45bStwYW1BVHFKcS8xZTBJUUtxSlRXZW5aZVhPVmd0Wnd2bDR6MjNR?=
 =?utf-8?B?QTAyQjRlSm0yZk9xL3Q4MTlnSXhFZVZOYkRkcnZyWXNMUTd2djZkT0N0YzQ0?=
 =?utf-8?B?NkQ3Q2t2K1loS0FKaW1RaE9PSTRUcjIveWR6dGo2WUhtUkVwVGRSTUo0cm1L?=
 =?utf-8?B?NWtZNkZ1aDkrS3cwdFM2ZitZSkRzL2JKbGFuTit4b3JIbnpIK0o1akFPc3Mr?=
 =?utf-8?B?SXgzWStwSWs4RnZEQjdrcnB1N3IwcTJkNUcweUxqQlBHMFE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUFHaE9oenJDMllJelUxRUhVaFlxTGs4Ulo1M2YvQmVFR05rM0wzZDUyZXAv?=
 =?utf-8?B?NDJDUkcyUGVOTFNMN1pPam1LczY4d0oyTGJsSHlVN05aYTV0Q095ak5zRTRS?=
 =?utf-8?B?NU16ODlEUFhZc1VDSEcvUnNhTUR5SnBGcjNzd0s3NTdwVUVhdkhtRFFwZUxM?=
 =?utf-8?B?MXZoendUTVRkcFdwQ3ZaK0tYenR6MkV5dE94eU1Nakg0VzVUZGlWT3c5M3g2?=
 =?utf-8?B?YmFsa0lYbFQ3RUQwRTNKbXhKTHlvNE1TYVZNUUdMS1E1SU12Z09qdDB2c09O?=
 =?utf-8?B?N1BzQW9XMFVOR1R1RGp4aDRrczNLY0lzdTRrUElleHI5M3lnd1VkOUZnV2tp?=
 =?utf-8?B?Q0RGU1hNTVdmck9IY0V4VGZoWWJLa09wc3FXR1QvQzFWYWN2MGZDbnQzUTc4?=
 =?utf-8?B?Zm10aERjaEI2QWtHclFnUWtEQTdPczhSRUZTdVREYzljUElFOGU2akd0cDJH?=
 =?utf-8?B?bjMxbng2SitqRjIwSXUvdFZKWUxsTGo0blpaSVdCTXRUaGl2elFnc1pmdTlK?=
 =?utf-8?B?WWtsVU5RYWJyOU1vRmVQZi9GbXUxanplUzA4VnRSYUNFSUxrZXRURkFGb0pC?=
 =?utf-8?B?M05jU3k2ZjhNa01idTExNlF5ZGUxVWtVREZPbTk1NVJUaUVVU2JYMkZDTlZ5?=
 =?utf-8?B?V1QvNU92Q2tsZmUzWXViVlZ6cEVWd1d1ZUhCdWFrMG9jdU04RU81WXQ0UWg2?=
 =?utf-8?B?d2RlZys3Z0lUUlJWakZrK1RMaDJkTk9HcG90eTdUTXdhV3FUVGZyaUZuTEdu?=
 =?utf-8?B?Qktody9sS1c1K0pKY0VjS1J4SERkb3lnY0c0U29PWEkrcjgvUVpKV0FjdXhW?=
 =?utf-8?B?SDloZGk4V3YwSFNybEZVR1I4NUd6NEVUWWV1UysvVnQrdzBkdDlwSEsxTWtl?=
 =?utf-8?B?ZExPYTJxRk5tU1E5OW8vMmtKUlkzRDZsc00zMHBSMHNtdWhWdHFRQWRHbnFL?=
 =?utf-8?B?UjFtb1oySjlzRXN6d3BuUEdqZWQrY25ITUJzZnljTk1kVmtlNXdnM0VxTi8x?=
 =?utf-8?B?WW1uWEh2QnowWjV1UVZEVmp2NnByRzVNRW5zUTNJc0xEQkY0T3FSLzcyY1Ux?=
 =?utf-8?B?OW96VnJsV3E1dituTU56Y0V0TktiZHpha3NjOTduZE5kOGJBK3B6VHRnNEJy?=
 =?utf-8?B?dEdCWnJqNVdPQmdTUW1DR3E1QTZnajJSSk9pakxoc3hWdTlHK2UrN1ZHNkZI?=
 =?utf-8?B?SjZjcExOTUNlUjZ6K0FUKzRyNFpDS0ZwMzVVOTdWNVdZcWtpUk9NSnRzb0R4?=
 =?utf-8?B?azNCRTRGa09jaHZwWU5BK0Q1MXorQWFpQm5ZdnJkRmNpQTdna05YalVDMjZO?=
 =?utf-8?B?cVFiTFFKOXlpRHZPNVYwMUVNUGM4RTRITmVJcjNHS1Y1ZGFHdGFCOThFekhx?=
 =?utf-8?B?cllXaHZHUEhHelB2ZEdDaDNZRHVnNFRhdEZ3YnBDdEVJTzhyLysrV2FIaStz?=
 =?utf-8?B?OHkyaVFDNDBHMWlsQjJ4R1lYOGx1UlFQbGZsNW5kSFBhVVZGelY1bFhpRVJF?=
 =?utf-8?B?citDRjBlWm9YSzZjeHJGU25sanVxdmp5RWY1RkczcUhwa282cE4wWTJmVERH?=
 =?utf-8?B?K2ZtdDR6VFpiNmZnL2lGTlV4a25wemFMUmhDTEpmS1NDUHBFSHhvdzdOa3g4?=
 =?utf-8?B?RTV5ZTlTTEY4RS9tdXhCV0xNV1FjTEpCWGlYa3hDLy9ZSWdtYXVnclNDUm9P?=
 =?utf-8?B?WEtWbFg4WXVpNEVsNm43ZnJub2w2eERIeTNhRUxBTzVRQitMSTFwZGx4alFt?=
 =?utf-8?B?VjZoVDY1U0U4eHlFenJMSURpN2xUMkNsSkw3czQ0emJxMlRZMnhHNmV2aGFO?=
 =?utf-8?B?VmR4bkpZTzhJalBtdjMwSDFWRWRWWnE2THZZbVczWUtoVGl5aDB0RE1hUXlw?=
 =?utf-8?B?Q0lxL3hYZDZpOHp2cmNpSGhSZ1JrTFE5dWpveVR5ZjVjQ0tSbnJ2L1hpT3JL?=
 =?utf-8?B?ZURHUFF3SnE5cEJ2NlZVMFVaWHRCQnNUQjkvZFg5UUJhdmlYbGRrMlo3Qzdw?=
 =?utf-8?B?dXQzeno1RVoxSk8wOGJtVFVWK3NhS1RoQS9aaFYza3Ryb2wyVmsyNzNNQ295?=
 =?utf-8?B?dkd1S0lQZG5mNCtVRW83TlVsem1EMnNFTFBpSThHZXdrZEkxVk1LUzZmcElS?=
 =?utf-8?Q?z6BeIeQ796+S5A6y2JuxuN7zG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F1E988E37EC2D43AF5431A0DC51AF57@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6524c3-c4e9-4be3-1c15-08dcc991b115
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2024 07:51:15.7629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: otiqKAMSF3GoP8rm3lU/g7Qf3jaiivCkk3qClP6KMCqHTS1uFnzIW4MZt7e/s4EWQUTIqYDrXXQzc0tViKWTeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6999

SGkgS3J6eXN6dG9mLA0KDQpPbiAzMS8wOC8yNCAxMTo1MCBhbSwgS3J6eXN6dG9mIEtvemxvd3Nr
aSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBG
cmksIEF1ZyAzMCwgMjAyNCBhdCAwODoyMToyMVBNICswNTMwLCBEaGFybWEgQmFsYXN1YmlyYW1h
bmkgd3JvdGU6DQo+PiBBZGQgbW1jIGJpbmRpbmcgZG9jdW1lbnRhdGlvbiBmb3Igc2FtYTdkNjUu
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogRGhhcm1hIEJhbGFzdWJpcmFtYW5pIDxkaGFybWEuYkBt
aWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9tbWMvYXRtZWwsc2FtYTVkMi1zZGhjaS55YW1sIHwgNSArKysrKw0KPj4gICAxIGZpbGUg
Y2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+Pg0KPiANCj4gV2hlcmUgaXMgYW55IHVzZXIgb2Yg
dGhpcz8gV2h5IGFyZSB5b3UgYWRkaW5nIGJpbmRpbmdzIHdpdGhvdXQgdXNlcnM/DQoNCldlIHdp
bGwgdXBzdHJlYW0gdGhlIHNhbWE3ZDY1IGJvYXJkIGR0cyBmaWxlcyBzb29uLCBoZW5jZSBhZGRp
bmcgc3VwcG9ydCANCmZvciBpdCBiZWZvcmUgaGFuZCBpbiBiaW5kaW5ncy4NCg0KPiANCj4gQmVz
dCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQoNCg0KLS0gDQpXaXRoIEJlc3QgUmVnYXJkcywN
CkRoYXJtYSBCLg0K
