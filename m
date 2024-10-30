Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2139.outbound.protection.outlook.com [40.107.247.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684D41E32D7;
	Wed, 30 Oct 2024 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730291410; cv=fail; b=ISQ/GCjw1IaGgeEcMPbG32z/ilxymBl10QuWe9VTbvaxSy5L7Oa9E/nmcJgmH1jctBVl1EI8xSSZWCC2RJkVp1OhQTsENUwdj4sRwRwNShC84yvJ/HIQd+YPMz5S7r2gjwoo4qe56+TLQeM4Yhr4rKCESC7A5lFfdsyGDq/SuR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730291410; c=relaxed/simple;
	bh=UmkFIIRfIFWkEAwLADCMxUNqKoUu38uo7/+WVQgphYo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xvgm2/4T5/O7bbMqsxBdV3rS9egkKH4yzGRu4H4vtuTPJo7HE9cTa5Zp9SdGYjQs/O+w3gTTtTgbqBnfcAUlg+H0kS1yTHgRqceQF4sTyB1JY0Dr8fE6MuGYmV8WTDgf3lE6Tvfq1z5rZgd+2cEVWYK8/aK5ZszQqFGfqvFxwAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=eGPCbkVf; arc=fail smtp.client-ip=40.107.247.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="eGPCbkVf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfxTYf47B2lGUlVvyuR3YLkk/xeuF1mPkxZFYY3AFosuXn/U/FmhCZ4dSTOiEtZA9UZOBvZpXK25ul8fEqAgIm5t4hZ9Oj7KKNUks3sJHtQr5JHVSWzoftQLmAV555BOsliPb/b4xcIlyKK9xXWgFrDQKg2H0QKdghDBeEnCg4xy9HnsMyQQinzHPxTDstZYeLT/KO0/vFRFyTg66klVVkcmcNbAv8VestdLudRgnX4/X/drIYM+1VsOLfESmlRcz0BjEX1GCbqorGx8s70N/CvuNw4KHY2S8e5cMD1JpU4zE3m8F/+PWcjj9xqS49xOg8cxA5XfBxpJ40BKUHscYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmkFIIRfIFWkEAwLADCMxUNqKoUu38uo7/+WVQgphYo=;
 b=loeiv9Rq8yOEFU4s8oytT6NEFCp7p5DrbyPYQALMvKVqbfLn+9YrHzjGC3ebe69AfC33lLIftJk2F91/ZXGMLG1IKuYkOnhiYZm+uts5Bznn0H2WodFkLHX7mLSXKbhi2hbCvxcOcZlMgfW/I6By2kDsYXZDaI3w/ZQPruJAVYpCn1tvZ8FSDcv2eEqlVlZyy4QT+37OKHJ03UFjER17Y6NyqJt6u1AHgCJbB+srhQUV4mpk919Smv4KTpH7je4AJrBC7Ohfsa4i/5/iPm9HHw2glulXVYG4vlDi/NcAC+9WnbjweFH4sS7QPtWsH/6If00EnJgBlSCdsvsOOlNE+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmkFIIRfIFWkEAwLADCMxUNqKoUu38uo7/+WVQgphYo=;
 b=eGPCbkVfzX9dB3+tXAPLv97IeGOV6EdMrTzcMi2rVjj9NblSYuWr4/+gyXOL1v8qeJNorEGNhWpDcqCniXFPPoFUh3qS9/p4GQlXDw3MKWtyPmn9QQjs0O4zrTRZtttpWyJX8zwS26+DglyXB3kpYR0On/cTHxvPLkGPwf3A+Ro=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB7720.eurprd04.prod.outlook.com (2603:10a6:20b:299::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 12:30:04 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 12:30:04 +0000
From: Josua Mayer <josua@solid-run.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Bough Chen <haibo.chen@nxp.com>,
	Peng Fan <peng.fan@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: Yazan Shhady <yazan.shhady@solid-run.com>, Rabeeh Khoury
	<rabeeh@solid-run.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, dl-S32
	<S32@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: host: sdhci-esdhc-imx: implement emmc hardware reset
Thread-Topic: [PATCH] mmc: host: sdhci-esdhc-imx: implement emmc hardware
 reset
Thread-Index:
 AQHbKH5HOJuwCzLfNkCusXVof1dxZbKba/0AgAASVgCAAH3MgIABCNsAgABW5wCAAeIFgA==
Date: Wed, 30 Oct 2024 12:30:04 +0000
Message-ID: <b9faa7d7-98f8-4f3a-8249-ae12a6359a28@solid-run.com>
References: <20241027-imx-emmc-reset-v1-1-d5d0c672864a@solid-run.com>
 <PAXPR04MB84591664B7A4455E6F0BD19E884A2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <DU0PR04MB9496769805197714F198EC0F904A2@DU0PR04MB9496.eurprd04.prod.outlook.com>
 <913d8706-ec58-4197-889a-0d2d94c67ccc@solid-run.com>
 <DU0PR04MB949630B1EE9A0F19DACE3414904B2@DU0PR04MB9496.eurprd04.prod.outlook.com>
 <6c63e1ce-dd54-427f-baa6-4ff86cec3d16@intel.com>
In-Reply-To: <6c63e1ce-dd54-427f-baa6-4ff86cec3d16@intel.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|AS8PR04MB7720:EE_
x-ms-office365-filtering-correlation-id: 7c07fd43-b581-4f8e-80bb-08dcf8de94b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NjY5cXZTL29jbHJ6Z3hLOWYwbEp0THZjSlV5c2Y3RWpjNWdiMWxxUnoyRG14?=
 =?utf-8?B?L2d2RkphM1k3SG1qTHZWQmJMVHgrdDNudGZ2OUl4eWVHYW1CSDJnczA5MkVi?=
 =?utf-8?B?cmc3dlUzTFQ2d2lCWjJZSUVUR1A0M0ltSWJwVHBqRW5pcW9VNm9tdUpSaXYz?=
 =?utf-8?B?Um8vOGg4bVBoRUUxRHRIQ1N0VmdJczlyMXJZOUthNEkybXF4U3g3Y3AzdFJk?=
 =?utf-8?B?dUhYOTRwRlJkbEhsVnRkOGtVTlovSDZkMjdscGJnRHI5YXVFZ2piblJCaDNS?=
 =?utf-8?B?OW96RjV1QjZzR3J0ZFVvR2Q2LzdicUFEcWxGNHZYMThLckhpSXRnUW5FUHpp?=
 =?utf-8?B?Z2VrS25vZWt0MFJjY2lWVXBLSWxJWFl4RmZlYVQ2MnBaMEJLV3c0ZGh6TWhC?=
 =?utf-8?B?TkNWS0s0SXZRQXVrNUp2QzZ4UnFMOVF0VHVxcHp0eTEwL2lCUncrODdQQmJu?=
 =?utf-8?B?TEJuRTVDeTdZSzdYMzkzYUV6YUI5YlQydkhFQW8xSitaVHBTeW1SU2xLZ2Y0?=
 =?utf-8?B?anZIcXlXL2l1eHdHNy9sTVBFY0hleXRCVktWWGwyR21wb3BKbUFHVWFyYndK?=
 =?utf-8?B?Vk55dDRDdDVWYUF5OUNQcndpdk10and3di9wZXBsODM5OEtwaGREN1NNelU4?=
 =?utf-8?B?K2ZSRjdMLzlTZFdnUStjU3BpM0hydWx3Q1ZTTCt4Yzk2ZHNVaVA4ZU54bHBx?=
 =?utf-8?B?YzU5VTJzOTRlUG93UlZKZU4zbnJIUDBuRGtFVGI5MzBudXZscGJVeTB2OWpr?=
 =?utf-8?B?aVRkNDR5TUdxc2Z4MkNYaTVJNXcrYldpSWpUVlFmeE9aV0lXS3dPcDZNbkhM?=
 =?utf-8?B?cExyUW00YkQ4MWhqQnlZNmhuUVpCaTJMQVdEZGRYaU5GT1pkR1J6ZUVHNHdk?=
 =?utf-8?B?dGw2aVIyYVk3a21URWRjaEtCZkduWElZR09KeVBkaldnWkZCTnZpZ3Nta2Nm?=
 =?utf-8?B?ZGVRQzNrOWpaS01LM1BsbVYrTVNsWHdSeWo0QnJybjVnSG5kTjcwNCtnS0N1?=
 =?utf-8?B?eENlQit1UXpWd3o4ZE15MjhQWnIrVnBmL2VOOE5XVUQ5RUxBRXp2TXpQRG1Z?=
 =?utf-8?B?TEFwY29WTk1MZjM5NkZteWpqdW1pQWJyMHZYRUxDTmpNTEgxWG42cU9rVVNt?=
 =?utf-8?B?SjhNNmF6K3M1WmlkMUM3Qk02Slp2ODNTMGg4S2xqbXRBMW5aMGhaaGdaa0pR?=
 =?utf-8?B?dnA1WW9kZW04dW9WOVo0dVdiRmxsQTF2U3dtbXh6dEF6WDZLMlRIdFc4WDQx?=
 =?utf-8?B?SGZLNlFFOWFFR3NEUmpMdFJReVRhbzU5OFRJRlh0dFI2MjJpS3JyUUJ6V24r?=
 =?utf-8?B?MDBnVXA4NVV6eVVLdWYxbnFXSGl2UUd6bmJQbGF6dmlzZVRlbnhGdC9iNnpq?=
 =?utf-8?B?MHY0MUJPbVJTRmdpMFZXNVlybjRONi9XMlNGWXNZUFRBTDUyWERvZkR5QVBq?=
 =?utf-8?B?VWpNK3d2eFlXd3U2YXJRTGVycmxRL0dteDBNQ1A3MHVod0JUZUF1R3F0Qnk5?=
 =?utf-8?B?Ulk0ME5xZ0o4RHBKSURBVU1uOThjcjhOY2dKaDUzbklUK1pMSTNrNExKWGN6?=
 =?utf-8?B?cDNuZzVOODgxMmFsVzNLRnlhUWl1aHVDVDc4NlFYYUs3aVZweXBkZHRBU1Jp?=
 =?utf-8?B?RS9hK3BUQWN4UmExTXByL0pZNVdWRDhuODR1K0NIc0hJVTVSS1FmbVhTN0Uv?=
 =?utf-8?B?SkhoYkxaelRnQk9YeWc4eUFlZkJjZWNqY0RLYVZoRjdRb1RQUnhSNWRiOS9u?=
 =?utf-8?B?a1JETGVUSXlaS0VaNWxHSGxhTDV4QytMT2d3Znp3d0ZtamR1K1NBL1NHWEU3?=
 =?utf-8?Q?Wu7ZufKvypKFnm98ZfONSKe23MpBNmNRKIxdQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MzhBZTlDQ2JxQ0Z5cmRqamdPWE1BZ1NXU3gzb3VZWUEvYUM5a0dtTmlja0ZG?=
 =?utf-8?B?d2FsSXI4ZlIrN0pUS2lXSGhPMVJFMHlwMUFyN2RqYkd3Nit2Tm0xTnZYd09U?=
 =?utf-8?B?aEVQUW1mMW0xMnJBNVYrS1lLUGlLK0Y0ZXBZTlpXVE9MT1BEYXZFOERjclVl?=
 =?utf-8?B?SzlKaHVvbS8zY2NxSlI3dUU2dHA3eERzaWsycEJEQWRPYXB1dVMyMGZPYW5p?=
 =?utf-8?B?TmpXUHc2dmlEODRKd3VwMXBmNWhibk9qQWVYRzFpRldEN1FlZUF1TGNwbVB1?=
 =?utf-8?B?elJCeXF2dWNWQ3hLZVZnWVFidGR6d2dXWDIrK2FBVXBZbjZxVFAyZkdCcEVL?=
 =?utf-8?B?eUMwUytEaGx4MS9qTE5pUFE5QnVkc1hpVlJ3Q1Z1d3ZtZnZ3UmdhR3RRRFdE?=
 =?utf-8?B?OE9jTXloUVJNVEtKYjQxNWo2eGlBNTFOWStOK1ArNUllR3dKQklzRUpiV0I0?=
 =?utf-8?B?QnJTMC85dlAweDlTd05CRmp5RTRWQ2xKeTlFNUFkb3J6a3R6MDFoci9Td05k?=
 =?utf-8?B?N2M0WXBQNHNKOHdWK2pQUVdIUmJMamZGODFkQ2JMOXV4SXN5dFFRdjlTRDRH?=
 =?utf-8?B?c3MvREJUZk84OUdOS0NSN1B4OUIwUnMxRXR0bHBvOW16aFRUWk9nRkdESlNB?=
 =?utf-8?B?QUdBRGJueDJpcmVaaDR2Z2tMUFVXeklCd1E1S2RZV0FYUytVV3dMdjRKeDlP?=
 =?utf-8?B?TkxuT0xDWGpla3ZaanpyNzIwQk1RY2RGc1VzUityN3dTbFNnZDJyY1R1TXd0?=
 =?utf-8?B?V1QzMFVHSU5XcWFoU1ZzUXhhbjh6Mzl0RW5DVlR0ajdJbXJJYmR0M2ZhVy9o?=
 =?utf-8?B?RlNxNDFnOVFyOHQrVXVqZDI0VCtTQlNjU2hQcE9QSkpIQXExa2dyUDBoU1RC?=
 =?utf-8?B?VTFNcHpJOU41NkF2MVpNZFRHNi83TG04eUk2NVFKL2V3MlV1d08rWHQ5VENl?=
 =?utf-8?B?YzRWVEtVSzZlRVNxZmJGTkhnVmFxeUM5bzhGaHVTdHEyM3dBN3FqTCtiRHJG?=
 =?utf-8?B?UVdSTHdsemZ6aWs5Z1h5VnAvUUt2UDhBQzVWcnVyUFB5cjBEeEcvRW1GM25N?=
 =?utf-8?B?aEp5amJwbWd1NjEwVUwwaUNyRzUxWTY4N215TTh2cUJRNjZPYnU1TzlkdUhz?=
 =?utf-8?B?WU1URWIzeWNQM2thT3J4VGFXb1oyUkpLK2J0L21OSjdWL25GQ0k0SllCUWpG?=
 =?utf-8?B?VG16M25PWEZFUm8wSWlXQVk5NjlmTkd3aDlWQlhKeWp3V0JhWVJJaWoreSt5?=
 =?utf-8?B?ZXFONEdRemhKRlRoejY3dlhyVFdGdTFnQks5bmk1VG94R0J2OHJ1dk9wWUpX?=
 =?utf-8?B?NnJoN2pEUjdjM0RDNC9MSjg2ZGRTdjM1V00xSjlTT0dUV2xFSENHeFIxcjgr?=
 =?utf-8?B?cENYZGkwQVFKTVpycWlkeVhyek5hRDBqVDE0WGl3MnFzaHhyTWYybDFmTWls?=
 =?utf-8?B?ZkI3TjJaTzllQUpkRmdTb2NHSE1qdzV4NnY4VEQ3K0tZOXpRbHZPa0F4V21Q?=
 =?utf-8?B?U2wxN1VuS0xvdWcyWWtMeStKaHNBNVBaSWhNWkc1bXpmcmFYajRIUjZYUWlw?=
 =?utf-8?B?djRvQjlsbTJzVzRpRERjU0pKcEJZcCtiUUd3MS95RXZXWWhXd3NIaDNOSUVI?=
 =?utf-8?B?Q1lwRzl4Q2FJbzBxN2tyb2p6aUh6TnFQQUdJaE8yankwYmlWcW1sRE1vQTJP?=
 =?utf-8?B?bXRQUlVnZWRQUUx0YVdIK3ZmVEFTV21BcUdOSFhlSEg4U3cybkszTXB1UVBt?=
 =?utf-8?B?SW0vb2R3Z2o2VnltNytkektWNkZkTkxzaHBPV1dUdzNkRHRkNkJOV1FzSzhv?=
 =?utf-8?B?RkE4NkNVZWhLNGRwMy9OWHVhM0lTMXlVL2xGbDY1cHlEK3M5R3Q3N3Zjcmg5?=
 =?utf-8?B?QXI5dnBZLytxSmxJVEY3Si9sWFlQSEN0bjJUakR2OGFpWHNtOE9uT1ZwUkhX?=
 =?utf-8?B?a0tXUUt1T0VLZFZGanNTRlpMYUREQlVOaU9LblQrUnJnVkk3UUxXbGpwZUdW?=
 =?utf-8?B?TVZsNEtnaVp5Szc2Kzk5TEZ5MFNTeXBJcHV4QjBwMlIxUEN5OGNjcWZiazZl?=
 =?utf-8?B?UlAwd3FGTEZsYVlncnRTams3cTBJVEgxR0J1aFBjQ2dUUng0SmFMdEp6Vm15?=
 =?utf-8?Q?00oY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <192876F9F46C1C4E8AC9FCACD67EB5F7@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c07fd43-b581-4f8e-80bb-08dcf8de94b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 12:30:04.0161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dE4dUpdXLE0M5ULjoKJ+VI+0EOx4Q5Mx9hdV5PqgH/if+fWVS+ix2cJnnmM1Jrskjf2fezHGcbwPc9IBuchzuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7720

DQpBbSAyOS4xMC4yNCB1bSAwODo0NCBzY2hyaWViIEFkcmlhbiBIdW50ZXI6DQo+IE9uIDI5LzEw
LzI0IDA0OjMzLCBCb3VnaCBDaGVuIHdyb3RlOg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+Pj4gRnJvbTogSm9zdWEgTWF5ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+DQo+Pj4gU2Vu
dDogMjAyNOW5tDEw5pyIMjjml6UgMTg6NDYNCj4+PiBUbzogQm91Z2ggQ2hlbiA8aGFpYm8uY2hl
bkBueHAuY29tPjsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+Ow0KPj4+IEFkcmlhbiBIdW50
ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgVWxmIEhhbnNzb24NCj4+PiA8dWxmLmhhbnNz
b25AbGluYXJvLm9yZz47IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz47IFNhc2NoYSBI
YXVlcg0KPj4+IDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPjsgUGVuZ3V0cm9uaXggS2VybmVsIFRl
YW0NCj4+PiA8a2VybmVsQHBlbmd1dHJvbml4LmRlPjsgRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1A
Z21haWwuY29tPg0KPj4+IENjOiB5YXphbi5zaGhhZHkgPHlhemFuLnNoaGFkeUBzb2xpZC1ydW4u
Y29tPjsgUmFiZWVoIEtob3VyeQ0KPj4+IDxyYWJlZWhAc29saWQtcnVuLmNvbT47IGlteEBsaXN0
cy5saW51eC5kZXY7IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7DQo+Pj4gZGwtUzMyIDxTMzJA
bnhwLmNvbT47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4+PiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0gbW1jOiBo
b3N0OiBzZGhjaS1lc2RoYy1pbXg6IGltcGxlbWVudCBlbW1jIGhhcmR3YXJlDQo+Pj4gcmVzZXQN
Cj4+Pg0KPj4+IEFtIDI4LjEwLjI0IHVtIDA0OjE1IHNjaHJpZWIgQm91Z2ggQ2hlbjoNCj4+Pj4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4+PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5m
YW5AbnhwLmNvbT4NCj4+Pj4+IFNlbnQ6IDIwMjTlubQxMOaciDI45pelIDEwOjEwDQo+Pj4+PiBU
bzogSm9zdWEgTWF5ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+OyBBZHJpYW4gSHVudGVyDQo+Pj4+
PiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5j
b20+OyBVbGYNCj4+Pj4+IEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+OyBTaGF3biBH
dW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+Ow0KPj4+Pj4gU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBl
bmd1dHJvbml4LmRlPjsgUGVuZ3V0cm9uaXggS2VybmVsIFRlYW0NCj4+Pj4+IDxrZXJuZWxAcGVu
Z3V0cm9uaXguZGU+OyBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+Pj4+PiBD
YzogeWF6YW4uc2hoYWR5IDx5YXphbi5zaGhhZHlAc29saWQtcnVuLmNvbT47IFJhYmVlaCBLaG91
cnkNCj4+Pj4+IDxyYWJlZWhAc29saWQtcnVuLmNvbT47IGlteEBsaXN0cy5saW51eC5kZXY7DQo+
Pj4+PiBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOw0KPj4+Pj4gZGwtUzMyIDxTMzJAbnhwLmNv
bT47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4+Pj4+IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4+Pj4+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIG1tYzogaG9z
dDogc2RoY2ktZXNkaGMtaW14OiBpbXBsZW1lbnQgZW1tYw0KPj4+Pj4gaGFyZHdhcmUgcmVzZXQN
Cj4+Pj4+DQo+Pj4+Pj4gU3ViamVjdDogW1BBVENIXSBtbWM6IGhvc3Q6IHNkaGNpLWVzZGhjLWlt
eDogaW1wbGVtZW50IGVtbWMgaGFyZHdhcmUNCj4+Pj4+PiByZXNldA0KPj4+Pj4+DQo+Pj4+Pj4g
TlhQIEVTREhDIHN1cHBvcnRzIGNvbnRyb2wgb2YgbmF0aXZlIGVtbWMgcmVzZXQgc2lnbmFsIHdo
ZW4gcGlubXV4DQo+Pj4+Pj4gaXMgc2V0IGFjY29yZGluZ2x5LCB1c2luZyB1U0RIQ3hfU1lTX0NU
UkwgcmVnaXN0ZXIgSVBQX1JTVF9OIGJpdC4NCj4+Pj4+PiBEb2N1bWVudGF0aW9uIGlzIGF2YWls
YWJsZSBpbiBOWFAgaS5NWDZRIFJlZmVyZW5jZSBNYW51YWwuDQo+Pj4+PiBCdXQgdGhpcyByZWxp
ZXMgb24gdGhlIFBBRCBiZWVuIGNvbmZpZ3VyZWQgYXMgUkVTRVQsIHNob3VsZCB0aGlzIGZsb3cN
Cj4+Pj4+IGJlaW5nIGRlZmF1bHQgZW5hYmxlZCB3aGV0aGVyIHRoZSBQQUQgaXMgY29uZmlndXJl
ZCBhcyBSRVNFVCBvciBub3Q/DQo+Pj4+IE5vLCBmcm9tIG15IHVuZGVyc3RhbmRpbmcsIGV2ZW4g
dGhlIFBBRCBpcyBjb25maWd1cmVkIGFzIFJFU0VULCBzdGlsbCBuZWVkIFNXDQo+Pj4gdG8gY29u
ZmlnIElQUF9SU1RfTiB0byBjb250cm9sIHRoZSBvdXRwdXQgb2YgdGhpcyBwYWQuDQo+Pj4+IEpv
c3VhLCB5b3UgY2FuIGRvdWJsZSBjb25maXJtIHRoaXMgb24geW91ciBib2FyZC4NCj4+PiBDb3Jy
ZWN0LCBvbmx5IHdoZW4gYSBwYWQgaXMgY29uZmlndXJlZCBmb3IgZW1tYyByZXNldCBmdW5jdGlv
biBkb2VzIHRoZSByZXNldA0KPj4+IHNpZ25hbCBhZmZlY3QgYW55IGJvYXJkIGNpcmN1aXQuDQo+
Pj4NCj4+PiBXZSB0ZXN0ZWQgdGhpcyB3aGVuIHdlIGhhZCB3cm9uZyBwaW5tdXggYW5kIHJlc2V0
IGRpZCBub3QgdG9nZ2xlLg0KPj4+DQo+Pj4+IEJ5IHRoZSB3YXksIEkgY2hlY2sgdGhlIGNvZGUs
IHdoZW4geW91IGRvIHRoZSB0ZXN0IHRvIHN1cHBvcnQgdGhpcyByZXNldA0KPj4+IG9wZXJhdGlv
biBvbiBlTU1DLCBkaWQgeW91IGFkZCAgImNhcC1tbWMtaHctcmVzZXQiIGluIGR0cz8NCj4+Pg0K
Pj4+IENvcnJlY3Q6DQo+Pj4NCj4+Pj4gRnJvbSBjdXJyZW50IGNvZGUgbG9naWMsIHRoZSBjYWxs
YmFjayB5b3UgYWRkIGhlcmUgc2VlbXMgb25seSBjYW4gYmUgY2FsbGVkIGJ5DQo+Pj4gZU1NQyBk
ZXZpY2UsIHNvIHdpbGwgYmUgc2FmZSBmb3Igc2QgYW5kIHNkaW8gZGV2aWNlLiBBbmQgaWYgeW91
ciBhbnN3ZXIgZm9yIG15DQo+Pj4gcXVlc3Rpb24gaXMgInllcyIsIHRoZW4geW91ciBjaGFuZ2Ug
d2lsbCBhbHNvIGJlIHNhZmUgZm9yIGVNTUMgZGV2aWNlIHdoaWNoIGRvDQo+Pj4gbm90IHVzZSB0
aGlzIHJlc2V0IGZ1bmN0aW9uIGJlZm9yZS4NCj4+PiBJIGJlbGlldmUgc28uIE9ubHkgd2hlbiBk
dHMgZGVjbGFyZXMgdGhlIGNhcGFiaWxpdHkgd2lsbCBzZGhjaV9od19yZXNldA0KPj4+DQo+Pj4g
Z2V0IGNhbGxlZCwgYW5kIHRoZW4gaXQgd2lsbCBjYWxsIGVzZGhjLWlteCBkcml2ZXIgaHdfcmVz
ZXQuDQo+Pj4NCj4+PiBTZWUgYWxzbyBkcml2ZXJzL21tYy9jb3JlLmM6IF9tbWNfaHdfcmVzZXQN
Cj4+Pg0KPj4+Pg0KPj4+Pj4+IEltcGxlbWVudCB0aGUgaHdfcmVzZXQgZnVuY3Rpb24gaW4gc2Ro
Y2lfb3BzIGFzc2VydGluZyByZXNldCBmb3IgYXQNCj4+Pj4+PiBsZWFzdCAxMHVzIGFuZCB3YWl0
aW5nIGFuIGV4dHJhIDMwMHVzIGFmdGVyIGRlYXNzZXJ0aW9uLg0KPj4+Pj4+IFRoZXNlIHBhcnRp
Y3VsYXIgZGVsYXlzIHdlcmUgaW5zcGlyZWQgYnkgc3VueGktbW1jIGh3X3Jlc2V0IGZ1bmN0aW9u
Lg0KPj4+Pj4+DQo+Pj4+Pj4gVGVzdGVkIG9uIFNvbGlkUnVuIGkuTVg4RFhMIFNvTSB3aXRoIGEg
c2NvcGUsIGFuZCBjb25maXJtZWQgdGhhdA0KPj4+Pj4+IGVNTUMgaXMgc3RpbGwgYWNjZXNzaWJs
ZSBhZnRlciBib290LiBlTU1DIGV4dGNzZCBoYXMNCj4+Pj4+PiBSU1RfTl9GVU5DVElPTj0weDAx
LCBpLmUuDQo+Pj4+Pj4gcmVzZXQgaW5wdXQgZW5hYmxlZCwgTGludXggdjUuMTUuDQo+Pj4+Pj4N
Cj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBKb3N1YSBNYXllciA8am9zdWFAc29saWQtcnVuLmNvbT4N
Cj4+Pj4+PiAtLS0NCj4+Pj4+PiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYyB8
IDEyICsrKysrKysrKysrKw0KPj4+Pj4+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygr
KQ0KPj4+Pj4+DQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNk
aGMtaW14LmMNCj4+Pj4+PiBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4+
Pj4+PiBpbmRleA0KPj4+Pj4+IDhmMGJjNmRjYTJiMDQwMmZkMmEwNjk1OTAzY2YyNjFhNWI0ZTE5
ZGMuLmViY2ZhNDI3Y2NhNmNjMjc5MQ0KPj4+Pj4+IGExNzAxYTM1MTVlZjY1MTU3NzlhYTQgMTAw
NjQ0DQo+Pj4+Pj4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPj4+
Pj4+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4+Pj4+PiBAQCAt
MzMsNiArMzMsOCBAQA0KPj4+Pj4+ICAjZGVmaW5lIEVTREhDX1NZU19DVFJMX0RUT0NWX01BU0sJ
MHgwZg0KPj4+Pj4+ICAjZGVmaW5lCUVTREhDX0NUUkxfRDNDRAkJCTB4MDgNCj4+Pj4+PiAgI2Rl
ZmluZSBFU0RIQ19CVVJTVF9MRU5fRU5fSU5DUgkJKDEgPDwgMjcpDQo+Pj4+Pj4gKyNkZWZpbmUg
RVNESENfU1lTX0NUUkwJCQkweDJjDQo+Pj4+Pj4gKyNkZWZpbmUgRVNESENfU1lTX0NUUkxfSVBQ
X1JTVF9OCUJJVCgyMykNCj4+Pj4+PiAgLyogVkVORE9SIFNQRUMgcmVnaXN0ZXIgKi8NCj4+Pj4+
PiAgI2RlZmluZSBFU0RIQ19WRU5ET1JfU1BFQwkJMHhjMA0KPj4+Pj4+ICAjZGVmaW5lICBFU0RI
Q19WRU5ET1JfU1BFQ19TRElPX1FVSVJLCSgxIDw8IDEpDQo+Pj4+Pj4gQEAgLTE0MDIsNiArMTQw
NCwxNSBAQCBzdGF0aWMgdTMyIGVzZGhjX2NxaGNpX2lycShzdHJ1Y3Qgc2RoY2lfaG9zdA0KPj4+
Pj4+ICpob3N0LCB1MzIgaW50bWFzaykNCj4+Pj4+PiAgCXJldHVybiAwOw0KPj4+Pj4+ICB9DQo+
Pj4+Pj4NCj4+Pj4+PiArc3RhdGljIHZvaWQgZXNkaGNfaHdfcmVzZXQoc3RydWN0IHNkaGNpX2hv
c3QgKmhvc3QpIHsNCj4+Pj4+PiArCWVzZGhjX2NscnNldF9sZShob3N0LCBFU0RIQ19TWVNfQ1RS
TF9JUFBfUlNUX04sIDAsDQo+Pj4+Pj4gRVNESENfU1lTX0NUUkwpOw0KPj4+Pj4+ICsJdWRlbGF5
KDEwKTsNCj4+Pj4+PiArCWVzZGhjX2NscnNldF9sZShob3N0LCBFU0RIQ19TWVNfQ1RSTF9JUFBf
UlNUX04sDQo+Pj4+Pj4gKwkJCUVTREhDX1NZU19DVFJMX0lQUF9SU1RfTiwNCj4+Pj4+PiBFU0RI
Q19TWVNfQ1RSTCk7DQo+Pj4+Pj4gKwl1ZGVsYXkoMzAwKTsNCj4+Pj4+IFBsZWFzZSBhZGQgYSBj
b21tZW50IG9uIHdoeSAxMHVzIG9yIDMwMHVzPyBUaGlzIGlzIGJvYXJkIHJlbGF0ZWQgb3INCj4+
Pj4+IHNvYyByZWxhdGVkIG9yIGNhcmQgcmVsYXRlZD8NCj4+Pj4gQWdyZWUsIHBsZWFzZSBhZGQg
Y29tbWVudCBhbmQgZXhwbGFpbi4NCj4+PiBUaGV5IHdlcmUgY29waWVkIGZyb20gZHJpdmVycy9t
bWMvaG9zdC9zdW54aS1tbWMuYy4NCj4+Pg0KPj4+IEkgd2FzIGhvcGluZyBzb21lYm9keSBrbm93
cyBvciByZWNvZ25pc2VzIHRoZXNlIG1hZ2ljIG51bWJlcnMuDQo+Pj4gVGhleSBhcmUgaW50ZW5k
ZWQgdG8gYmUgZ2VuZXJpYyBhY3Jvc3MgYWxsIGVNTUMgKG5vdCBTb0MpLg0KPj4gSSBjaGVjayB0
aGUgZU1NQyBzcGVjLCByZWZlciB0byBKRURFQyBTdGFuZGFyZCBOby4gODQtQjUxLCAgNi4xNS4x
MCBIL1cgUmVzZXQgT3BlcmF0aW9uLCBvbiBwYWdlIDE1OQ0KPj4gVGhlIG1pbiB0aW1lIGZvciBy
ZXNldCBzaWduYWwga2VlcCBsb3cgaXMgMXVzLCBhbmQgdGhlbiB0aGUgbWluIHRpbWUgZm9yIHJl
c2V0IGtlZXAgaGlnaCBpcyAyMDB1cy4gU28geW91ciBjb25maWcgc2hvdWxkIGJlIG9rYXksIGJ1
dCBwbGVhc2UgYWRkIGNvbW1lbmQgZm9yIGVhY2ggZGVsYXkuDQo+Pg0KPj4gSGVyZSBpcyB0aGUg
ZXhhbXBsZToNCj4+IC8qIHRoZSBlTU1DIHNwZWMgcmVxdWlyZSBtaXggMXVzLCBoZXJlIGRlbGF5
IDEwdXMgKi8NCj4+IHVkZWxheSgxMCk7DQo+PiAuLi4NCj4+IC8qIHRoZSBlTU1DIHNwZWMgcmVx
dWlyZSBtaXggMjAwdXMsIGhlcmUgZGVsYXkgMzAwdXMgKi8NCj4+IHVkZWxheSgzMDApDQo+IEF0
IGxlYXN0IHRoYXQgb25lIHNob3VsZCB1c2UgdXNsZWVwX3JhbmdlKCkgcmF0aGVyIHRoYW4gdWRl
bGF5KCkuDQpUaGFuayB5b3UgZm9yIHRoZSB2ZXJib3NlIGV4YW1wbGUhIEkgd2lsbCBzdWJtaXQg
dmVyc2lvbiB0d28gc29vbi1pc2guDQoNCkJhc2VkIG9uIHRoZXNlIHJlY29tbWVuZGF0aW9ucyBJ
IHdhbnQgdG8gZ28gd2l0aA0KdXNsZWVwX3JhbmdlKDEsIDEwKTsNCnVzbGVlcF9yYW5nZSgyMDAs
IDMwMCk7DQoNCj4NCj4+IEJlc3QgUmVnYXJkcw0KPj4gSGFpYm8gQ2hlbg0KPj4NCj4+Pg0KPj4+
IHNpbmNlcmVseQ0KPj4+IEpvc3VhIE1heWVyDQo+Pj4NCj4+Pj4gUmVnYXJkcw0KPj4+PiBIYWli
byBDaGVuDQo+Pj4+PiBUaGFua3MsDQo+Pj4+PiBQZW5nLg0KPj4+Pj4NCj4+Pj4+PiArfQ0KPj4+
Pj4+ICsNCj4+Pj4+PiAgc3RhdGljIHN0cnVjdCBzZGhjaV9vcHMgc2RoY2lfZXNkaGNfb3BzID0g
ew0KPj4+Pj4+ICAJLnJlYWRfbCA9IGVzZGhjX3JlYWRsX2xlLA0KPj4+Pj4+ICAJLnJlYWRfdyA9
IGVzZGhjX3JlYWR3X2xlLA0KPj4+Pj4+IEBAIC0xNDIwLDYgKzE0MzEsNyBAQCBzdGF0aWMgc3Ry
dWN0IHNkaGNpX29wcyBzZGhjaV9lc2RoY19vcHMgPSB7DQo+Pj4+Pj4gIAkucmVzZXQgPSBlc2Ro
Y19yZXNldCwNCj4+Pj4+PiAgCS5pcnEgPSBlc2RoY19jcWhjaV9pcnEsDQo+Pj4+Pj4gIAkuZHVt
cF92ZW5kb3JfcmVncyA9IGVzZGhjX2R1bXBfZGVidWdfcmVncywNCj4+Pj4+PiArCS5od19yZXNl
dCA9IGVzZGhjX2h3X3Jlc2V0LA0KPj4+Pj4+ICB9Ow0KPj4+Pj4+DQo+Pj4+Pj4gIHN0YXRpYyBj
b25zdCBzdHJ1Y3Qgc2RoY2lfcGx0Zm1fZGF0YSBzZGhjaV9lc2RoY19pbXhfcGRhdGEgPSB7DQo+
Pj4+Pj4NCj4+Pj4+PiAtLS0NCj4+Pj4+PiBiYXNlLWNvbW1pdDogOTg1MmQ4NWVjOWQ0OTJlYmVm
NTZkYzVmMjI5NDE2YzkyNTc1OGVkYw0KPj4+Pj4+IGNoYW5nZS1pZDogMjAyNDEwMjctaW14LWVt
bWMtcmVzZXQtNzEyN2QzMTExNzRjDQo+Pj4+Pj4NCj4+Pj4+PiBCZXN0IHJlZ2FyZHMsDQo+Pj4+
Pj4gLS0NCj4+Pj4+PiBKb3N1YSBNYXllciA8am9zdWFAc29saWQtcnVuLmNvbT4NCj4+Pj4+Pg0K
