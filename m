Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2059.outbound.protection.outlook.com [40.107.241.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B28117A2E7;
	Wed,  9 Apr 2025 02:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744166135; cv=fail; b=DT3KNE0rSa6ZGgrjixmWBWw9oNpSpJjtCyy/kFgtpt78JOORiVaZUGD9xPx8H3mfKETi5QEk3RBnjlON3j90wQzIoK3JX3OV9/XsNQMiQrr417SAFAUmXWlR3TeTVUplbcDMckW+UKYNzU3PXbp2Jm8PBXUXQ/eLrubqk3LaKac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744166135; c=relaxed/simple;
	bh=nqRiE0ZWhh335lR352q/j99GDu601qG6XPGApWd/Olw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A80KGfdlr/KioT/Y3LPZGD2wVVk5lcuelTeamSaqEscdMH5dnDRS6ETy9yw2FZTSb35sYqd7MKUMVwBvJo+WDUcNbWMCHnI0dMp2btGQaTDJTAWpwzGl+jBcvkZ8a/5wxbJFiR2NQ9tpk/mGax3c+n+6u41ko8saPz53915jv4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IQAC1KIw; arc=fail smtp.client-ip=40.107.241.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IQAC1KIw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkCOxryxcl9FYgbkywBxMRKit7CuFEyrHVOEc1TUKLJXnxjDOrmheueU6TIKJlsbNEK/Us3BaXPLYcsOcHVsKy/hkE/LgafNKTaefklzsCl/Tlzls0/ij/BzZdZWOYKSvFaO8nyRHWj8IJ3V1XYuIjMYfb+iLSOnXONsB8gMRf2h7c5No7eLhKZ05aoSyrLT72ubCk1YYwocq3eaPgPNaMROy5/gunfZE0+XDGkKh+kVOtOs4QOXW1FbCldCKlIXQ5zwV0KecYI/QeCzkJXhpvfDfNPGEu1CDsfIaDvMD3p3SLz72btCLmWNV45WtclEBsToXLwLcFe7s6CJAfqk/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqRiE0ZWhh335lR352q/j99GDu601qG6XPGApWd/Olw=;
 b=g5QO/WADDRRQQd+b/dtZBHVYjWgZfG+XpOXhf7ZdbE5R4aryUUnlYOMd1XFmrFYMoi0xRLpXi9t6rHoJiNEtPEKySbYgu0h9Br+WY+IJZzCTmk69Mu+yQe4TuiCqyUNr4P8wDbRtjtsYxmEMLzVh2YnYNSI0y1/NDtXYy+qMOEJEFQsokmVgmDEQoIjmW5QQ/SQm+Rtxe/KbeYziadi7KR+HrJtIowJ6y9BI2NONDbu+o4NJcOnrQlzB9ew0lA7TwBeqC5Ll288TlsoDTI+Otf0ImkDH9jXkkKoLBFOV3JKAQXi9+GS0SynCQ9wSvlnSHektPqdSTTDaUdM486kkIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqRiE0ZWhh335lR352q/j99GDu601qG6XPGApWd/Olw=;
 b=IQAC1KIwggqCTaxZmRAuEXPZOPPN2QqfgeESt4Elx+I1tuX/hf7supT32izWfllSvUoGWDE59HiqIhQp+GVWsw+c6Qklsvgkn6CGs2JUQNu65Y1PbGgYo8OIUK5HCg/kcEcaTK0cA0VruJhcIMpx6quWWp+sLk7BVm4/MsSHz43XIWVHQHjGQMd3LnJxKQ4707aD8HYwZvb5CbCiR9QWXZme82mSneV7h5u07B+M7JBds16OU4BSGfjwtg560iA1v3sk5LZkXJAos1SFGsQZYqU7dUZc+r677uaYHcI3jNaM9WM0MpeNXFS8XIs87OZCf/zogiKXXF/j0vDOFpblZw==
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by DB9PR04MB10012.eurprd04.prod.outlook.com (2603:10a6:10:4c1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 02:35:27 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 02:35:27 +0000
From: Luke Wang <ziniu.wang_1@nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, Bough Chen <haibo.chen@nxp.com>
CC: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, dl-S32 <S32@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH 2/2] mmc: sdhci-esdhc-imx: calclute data timeout
 value based on clock
Thread-Topic: [EXT] Re: [PATCH 2/2] mmc: sdhci-esdhc-imx: calclute data
 timeout value based on clock
Thread-Index: AQHbnJ5ApXGDb86CUUKP5kCgsEfDmbOaJoaAgACKDzA=
Date: Wed, 9 Apr 2025 02:35:27 +0000
Message-ID:
 <DU2PR04MB85676D85B99A5E202EA93C4FEDB42@DU2PR04MB8567.eurprd04.prod.outlook.com>
References: <20250324092336.2231385-1-ziniu.wang_1@nxp.com>
 <72e24e74-8c9d-4d4e-8a22-c2f55941c6ef@intel.com>
In-Reply-To: <72e24e74-8c9d-4d4e-8a22-c2f55941c6ef@intel.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8567:EE_|DB9PR04MB10012:EE_
x-ms-office365-filtering-correlation-id: 89140f97-37dd-4087-d1e7-08dd770f3046
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MVFEWmk2cTlIcDdwenV5K2pNU2JBV2l1R0hyS2N4M2xHbHpUaDV2SE1zZFA1?=
 =?utf-8?B?ZDhpdjV1T3NsM2pjZCtqZTQyeVNMMVZJL0ZiL3dDMTc0dFFVZmE1bHg5Sktv?=
 =?utf-8?B?NmR3cGlqaXhLelNYZkowYVJLRTUwSHhQVEVpZ0ZUd1NnRi83RzBPMVp6SGdn?=
 =?utf-8?B?bzB5elZoZHdSNzZTWXlWWUpoRTVubTQvNUprdEJGbFBhazVwREowdWNPWk9x?=
 =?utf-8?B?Y2pZUXc4YTUxdXVLR0VFTTlMcHlMT254UU95UGUyKzE1N0d0YlBha0tJNDZj?=
 =?utf-8?B?QUd0M3d0VkZNOVZwKzlkRzNpaTNxYSsrT0lyTW52dUJaa0R1b1JFNDhYMVpa?=
 =?utf-8?B?U0FzckVaUnZaU3IrSGtrLzM0Y3VKZmc4NE1MK0h1aE9lRUZIRDdyNWwxeitT?=
 =?utf-8?B?M09CMzl6dGEwNThYVCtjblhtWVhPVXNCZjNwdDVnOXVQc1c3LytvREYxWCt2?=
 =?utf-8?B?elhvanR6UUJQbDVBbnd1aUhkM3VGb3hubElvdTJjVSt6Tk1Ybm5zZzU3U2pk?=
 =?utf-8?B?VUVnQnVWWkF4T0FrbzU0LzJIdXdVK3RTV3FYSTM1Z1RwYm4wTzFWNHdRM2dB?=
 =?utf-8?B?SHpyNVd0VnVGVy9UdVVtYy9UNDZSYk5CQk54enRsVENjNEhoSXJER09nd3pB?=
 =?utf-8?B?VW9HbDlZNWV1a2w4bWM5N0hkTmVzTHFrWVNoQWhXdENGRkJ6Z1l1eEorRGhX?=
 =?utf-8?B?WXhWVlFVUktBUEN1RkVybmEvM2lCaUNKY1VVSEN6M0pwVHhXZkh1Q1BZWjJ2?=
 =?utf-8?B?V1JXdzM0S3hHc1N6K1hYRVZtbmtoYmZWckUwZXVDcGN5RGs0MTRXSWJJWG9Z?=
 =?utf-8?B?K3hJdUJjUFUyQVNjK2xBVnVGaXZYQUg3ekc0Z2lEYkZDZnJ4ZUN4Z1lDbWlG?=
 =?utf-8?B?Y2xuTGc3cDVlckVJUEFPUDJPdmliMzYxTnNxU1d0ekFKeitjSnhLQ1NSanhk?=
 =?utf-8?B?elM3QWlhZ1M2Nmw4WnkzSXY4WmIwZkphME9wUkJIS3B2S3lPelF1bUVXcmZ2?=
 =?utf-8?B?TzJXQWhadVVBaHJ5MWxJbGkvSzRxYVcrSXNXWEsySTlpMXRNSnVVVjhVWWMz?=
 =?utf-8?B?blpTdXZBTzUxR0x3cDlUTkpsZlFlQjFzSkJFRzJKdG1VTHJPVmJkVjI2MTdu?=
 =?utf-8?B?eVFhUGJnY2VKb3UyR1lKbGh6SWlkVUt4R1UvKzZjZnBTN294QnRKdTMrUGFn?=
 =?utf-8?B?VVJaV1BPMjd4NEFIR1FuZWRlMmpZR1BBNXFEcmxPOUJpeldPVGRublJSYktq?=
 =?utf-8?B?QmYrK2VvZG54UEFnTGxQZ1pyb3lyRXhOMUUxUm00VFE2YkxEQzRmSUNSYSt0?=
 =?utf-8?B?eUlDTEtGYytpTWw2ZWU3Y0l3eG43M3c5QWI0T25Sa3RTRlFIMzNEWFB1UVpC?=
 =?utf-8?B?OFZVSVlqanlEZ1dySlBHalViUUhTOERXMDFoOGcvZGxXYk1ZVmVkRWE1OFlh?=
 =?utf-8?B?SDQ5V3dYSUhGYk1WSmp1WVZpVVpGSHJkVERPdTMyYk90ckhWdkxQTGUrZVZT?=
 =?utf-8?B?M25lZlZkNFZROWtPaHphZjd4aU52RzB3RXZuek9QNWxOYzdXTVFNckxnZUJu?=
 =?utf-8?B?YjNLRldaVkhpd3crc0o4Z09uNStXSVRDZTV6SXpKVlhIWDdKR004ZGtXUEJF?=
 =?utf-8?B?MDhOakF6SVBjRys5R1hmZ21UM29WZ0FlZjBGU3hlUWJzUjFBcXp1cUc2MnBE?=
 =?utf-8?B?eEp2WmVmZkhpL2NXSWdGRzVwZTd4QXpMalkwa29YUXp3WHFic25mazJDbWoy?=
 =?utf-8?B?bC9Rekk3bnBOZUV0WGlUNHh4MkV4TCsvcWFBQlZNd05WZC9SWGZ1cHR6eWpL?=
 =?utf-8?B?dExBWmNJaGdJOGx4bWZxZDdZc0toU1dkd0p1ZCtjUzgwRjRrc2ExcXZ4cFJP?=
 =?utf-8?B?MXhyYklhUTNEbTVDaW5UeGpNVE01NWNjQWc4VTJJRnA2NlJuWjF0TVkzY1Rn?=
 =?utf-8?B?ZFhzSHduTjM3RWNoVTdGdDZTbjAzamxpa1ExeW1tRThBT2JLNjZXc0ZVM2Nz?=
 =?utf-8?Q?Pf9Dl0HwcWD+AD3Pd5M5ALAhhfNctE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WS8yYnpFaVBhaDhieVNXVHZzeWFRMDl3TVJJY0h1d3h2N1VkRXpjamNMYzdQ?=
 =?utf-8?B?Q25Sa3FMbVRQeGJ4VDVtV3o5Q1Z0TCtLYWpkdGtKWEp0MTBGZGM2aThPTWQv?=
 =?utf-8?B?dU1TUjhVR2RqRlJRWWFTRzlob29nYitVcEUwdFd2RmtKWmhkVXg0WjJ2dVpu?=
 =?utf-8?B?SUVQNnovbUM0ZVlEZmdMY0RFZWtIVVBHZ3NaaGl3WEc0NHh2SVg5MVIyL1Zi?=
 =?utf-8?B?eXk5QmZSRXhNeGFvNGJUNHE4Q1NkSnFDeGlMdk9BeWxjZ2JhcVhHUDh6TmY0?=
 =?utf-8?B?dTY5K3RFTnk3d1lyeGtqbWptN3BsOG1GMHlNdk9ycmNEYlR2U04wSWVoUmJI?=
 =?utf-8?B?dklyYUxDUVUzWEJHbFA5YXQ5eVRydVNNSHdFcU5tSWlTL3EvdjlpbHZ2elR6?=
 =?utf-8?B?NWNUOEw2WmtRUFVEckFHeVdkaGxLOUZUdWg5VXg1bXZBaXY2czErN3ZzR0FN?=
 =?utf-8?B?MUVZQTNkZkdrbjVGc2hweXpEVUtSUFJ4NTdxTlFZT21TczYrTFFXeE5WcU9M?=
 =?utf-8?B?NEtXaFMyZk1CcE0vUFpHZHRydUswRjNFZ1RQVzlBS000NTZUV3c4cGJ4dWx2?=
 =?utf-8?B?eDEzRUVjajVYTlBHUG93NjlqY25uOGJSaGNCbEZ1NUlYVkVTV3NQdE9rV0Vl?=
 =?utf-8?B?RkZzWUlraG5QNHhCazdqblVNQkJTeVdwTGk4U2FVM2xFZmNvRjE0ZjdoaTBh?=
 =?utf-8?B?bXd0QmY0THF6RFEwcWFiT1JCSkRPNS91WE1ZVmNGbElXaGRnYXBacmpBVGxw?=
 =?utf-8?B?U3A2MXZHV21MSitOZ2pWcTlFemdtN3dzRThNelVyMk5Lb25VTlRrd0ZrNW84?=
 =?utf-8?B?dWhva0pMdzlnMUR5ZnBhVkJBbVoyVUdlczlhR1A5UEZsbEFEbTNHem1LVzJh?=
 =?utf-8?B?TjFLTDZVa3phY002Y3dMcHhLazBJU1dtREhiY2xOcVFwcGMzaFNYZjFteUVU?=
 =?utf-8?B?a2M5dU5NOTdJT2kyeVpVZDdHK1lrSVJERk5TcVVDWm9YaWFQQlNNNEhSczRV?=
 =?utf-8?B?aXNueStERk1zN3dsamFXNEZYbXRETUhvLzBTYVhxOU9GNndyK2U3SXhzUGMz?=
 =?utf-8?B?bzJ1dlhEVnFGeDdvSnNpTkN4YTJMS1RMSmhucUZkOUhvUC9CajhWUVZCWGxJ?=
 =?utf-8?B?b2VJSXBQVEkyZ2dabVFOaUc5N1N4RStOSmswajNId1lXSlgzS0ErNEFPZmMv?=
 =?utf-8?B?b1FsZmxscFRqL3JhcnVINDNqSWZBc0tMOTh5cG94THhwR3FhbzFoTVhaSGUz?=
 =?utf-8?B?VXZGblkrTVFtc290U2VyNm1QdnhWSUw3L0ttOWN3YTZseTdqUmg0RkpEL1Vl?=
 =?utf-8?B?N2ZKaE0vclhiTEp5d0tiRjJ4QzhuYzlTUnZZcmF0NndWbmFHamhKYWZNMU5i?=
 =?utf-8?B?aVRIc3ZIMlNxUHZNaE5vL0c5TlJBZDJ5bW00WWZsZTd6YUM3aFpQNjIwWlc0?=
 =?utf-8?B?dS9aSUNsREhKODRQS0pSRjkwVEtUZ3RYelRJVjhtNEFOd096cnFVSUcydG5y?=
 =?utf-8?B?Nm15V2J5TkIrYlV3UGd5NlQ3dm56Q3Y4c1dOSmo2WlYvdWNwcEYyUlJBdE56?=
 =?utf-8?B?VUZCTlB3cmw3MmxSMjBFUStHa2tRdHdGOXlMNDdoT2JoUFBBRVB5MlJXdXBm?=
 =?utf-8?B?eGRqZWxxYllBeDN0QlF4bGh1cCt6MlowTXkxdzZBYTJleGNBRXlwTXU1cGN2?=
 =?utf-8?B?NkpOaE9ON2lycUUwakx3NElrc1pGZzdnNUU3NVAwOVBrMlhiblRMSWNaTURo?=
 =?utf-8?B?MnA2MUV4MVVwUTNvemN5MEpsOGFRQS9BTkQ1dFRGcGgvSXhCSHVsN25UYTNr?=
 =?utf-8?B?Nk5HMXZNUU5waGFNQUlSVlduZktmK0puSExPUkFvUWJqeWtuZXhka1lQOGha?=
 =?utf-8?B?MWlRaW93VmRyazJ2MElzMDMrNlgyK1h1cEsycDdnTTRFTEFUblBadTVmWDN1?=
 =?utf-8?B?ei9uME5aakRDcnhkR0Z4azZrUURtR1VlVmYzUGU1UHEydHBUYkI2bThqSlJN?=
 =?utf-8?B?NzdQaVBid3RFUE03L0lmSUE5dU9HMGJHcjdRTERvRGdnVFY1dmlBRURGOFc4?=
 =?utf-8?B?OU8yTThjU3RhN3FkYWNuelBBbm1jaDBydHZDNldFZ1FJWU5UNTI3K1dnbkZp?=
 =?utf-8?Q?Vwk09fEO6pF0AYtJJc8WWVrVy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89140f97-37dd-4087-d1e7-08dd770f3046
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 02:35:27.4065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5fQpyuBBQEhZq+sAAziTuPPiHJryYqE5Uh6nkREqugxNAm+7NrSwGsfhAPaqCag9xy7m8LQ4PG11Fr/Afu6HhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10012

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWRyaWFuIEh1bnRlciA8
YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgOSwgMjAy
NSAxOjU5IEFNDQo+IFRvOiBMdWtlIFdhbmcgPHppbml1LndhbmdfMUBueHAuY29tPjsgdWxmLmhh
bnNzb25AbGluYXJvLm9yZzsgQm91Z2gNCj4gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiBD
Yzogc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4ga2VybmVs
QHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGlteEBsaXN0cy5saW51eC5kZXY7
IGxpbnV4LQ0KPiBtbWNAdmdlci5rZXJuZWwub3JnOyBkbC1TMzIgPFMzMkBueHAuY29tPjsgbGlu
dXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIDIvMl0gbW1jOiBzZGhjaS1l
c2RoYy1pbXg6IGNhbGNsdXRlIGRhdGEgdGltZW91dA0KPiB2YWx1ZSBiYXNlZCBvbiBjbG9jaw0K
PiANCj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2Fy
ZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yDQo+IG9wZW5pbmcgYXR0YWNobWVudHMuIFdoZW4gaW4g
ZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0aGUgJ1JlcG9ydA0KPiB0aGlzIGVtYWls
JyBidXR0b24NCj4gDQo+IA0KPiBPbiAyNC8wMy8yNSAxMToyMywgemluaXUud2FuZ18xQG54cC5j
b20gd3JvdGU6DQo+ID4gRnJvbTogTHVrZSBXYW5nIDx6aW5pdS53YW5nXzFAbnhwLmNvbT4NCj4g
Pg0KPiA+IENhbGNsdXRlIGRhdGEgdGltZW91dCB2YWx1ZSBiYXNlZCBvbiBjbG9jayBpbnN0ZWFk
IG9mIHVzaW5nIG1heCB2YWx1ZS4NCj4gDQo+IEFuZCB0aGUgc3ViamVjdDoNCj4gDQo+ICAgICAg
ICAgQ2FsY2x1dGUgLT4gQ2FsY3VsYXRlDQo+IA0KPiBQcmVzdW1hYmx5IHRoZSBkcml2ZXIgaGFz
IGJlZW4gd29ya2luZyBPSyB1cCB1bnRpbCBub3cgd2l0aCBtYXggdmFsdWUuDQo+IElzIHRoZXJl
IGFueSBwYXJ0aWN1bGFyIHJlYXNvbiB0byBjaGFuZ2UgaXQ/DQoNCkhpIEFkcmlhbiwNCg0KWWVz
LCB0aGUgbWF4IHZhbHVlIHdvcmtzIGZpbmUuIFdlIHdhbnQgdGhlIHZhbHVlIHRvIGFsaWduIHdp
dGggdGhlIHNwZWMgcmVjb21tZW5kYXRpb24uDQoNCj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBMdWtlIFdhbmcgPHppbml1LndhbmdfMUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jIHwgMTUgKysrKysrKysrKystLS0tDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMgYi9kcml2ZXJz
L21tYy9ob3N0L3NkaGNpLQ0KPiBlc2RoYy1pbXguYw0KPiA+IGluZGV4IGZmNzhhN2M2YTA0Yy4u
ZTczMTZlY2ZmNjRlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNk
aGMtaW14LmMNCj4gPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+
ID4gQEAgLTMxLDYgKzMxLDcgQEANCj4gPiAgI2luY2x1ZGUgImNxaGNpLmgiDQo+ID4NCj4gPiAg
I2RlZmluZSBFU0RIQ19TWVNfQ1RSTF9EVE9DVl9NQVNLICAgIEdFTk1BU0soMTksIDE2KQ0KPiA+
ICsjZGVmaW5lIEVTREhDX1NZU19DVFJMX0RUT0NWX1NISUZUICAgMTYNCj4gPiAgI2RlZmluZSBF
U0RIQ19TWVNfQ1RSTF9JUFBfUlNUX04gICAgIEJJVCgyMykNCj4gPiAgI2RlZmluZSAgICAgIEVT
REhDX0NUUkxfRDNDRCAgICAgICAgICAgICAgICAgMHgwOA0KPiA+ICAjZGVmaW5lIEVTREhDX0JV
UlNUX0xFTl9FTl9JTkNSICAgICAgICAgICAgICAoMSA8PCAyNykNCj4gPiBAQCAtMTM4NywxMiAr
MTM4OCwxNiBAQCBzdGF0aWMgdW5zaWduZWQgaW50DQo+IGVzZGhjX2dldF9tYXhfdGltZW91dF9j
b3VudChzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCkNCj4gPg0KPiA+ICBzdGF0aWMgdm9pZCBlc2Ro
Y19zZXRfdGltZW91dChzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgc3RydWN0DQo+IG1tY19jb21t
YW5kICpjbWQpDQo+ID4gIHsNCj4gPiAtICAgICBzdHJ1Y3Qgc2RoY2lfcGx0Zm1faG9zdCAqcGx0
Zm1faG9zdCA9IHNkaGNpX3ByaXYoaG9zdCk7DQo+ID4gLSAgICAgc3RydWN0IHBsdGZtX2lteF9k
YXRhICppbXhfZGF0YSA9IHNkaGNpX3BsdGZtX3ByaXYocGx0Zm1faG9zdCk7DQo+ID4gKyAgICAg
Ym9vbCB0b29fYmlnID0gZmFsc2U7DQo+ID4gKyAgICAgdTggY291bnQgPSBzZGhjaV9jYWxjX3Rp
bWVvdXQoaG9zdCwgY21kLCAmdG9vX2JpZyk7DQo+ID4NCj4gPiAtICAgICAvKiB1c2UgbWF4aW11
bSB0aW1lb3V0IGNvdW50ZXIgKi8NCj4gPiArICAgICAvKg0KPiA+ICsgICAgICAqIEVTREhDX1NZ
U1RFTV9DT05UUk9MIGJpdFsyM10gdXNlZCB0byBjb250cm9sIGhhcmR3YXJlIHJlc2V0DQo+ID4g
KyAgICAgICogcGluIG9mIHRoZSBjYXJkLiBXcml0ZSAwIHRvIGJpdFsyM10gd2lsbCByZXNldCB0
aGUgY2FyZC4NCj4gPiArICAgICAgKiBPbmx5IHdyaXRlIERUT0NWIGZpbGVkIGhlcmUuDQo+IA0K
PiBmaWxlZCAtPiBmaWVsZCA/DQoNClllcywgSSB3aWxsIHVzZSAtLWNvZGVzcGVsbCB0byBjaGVj
ayBuZXh0IHRpbWUuDQoNCj4gDQo+ID4gKyAgICAgICovDQo+ID4gICAgICAgZXNkaGNfY2xyc2V0
X2xlKGhvc3QsIEVTREhDX1NZU19DVFJMX0RUT0NWX01BU0ssDQo+ID4gLSAgICAgICAgICAgICAg
ICAgICAgIGVzZGhjX2lzX3VzZGhjKGlteF9kYXRhKSA/IDB4RjAwMDAgOiAweEUwMDAwLA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICBjb3VudCA8PCBFU0RIQ19TWVNfQ1RSTF9EVE9DVl9TSElG
VCwNCj4gDQo+IENvdWxkIHVzZSBGSUVMRF9QUkVQKCkgaGVyZQ0KDQpPSw0KDQo+IA0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICBFU0RIQ19TWVNURU1fQ09OVFJPTCk7DQo+IA0KPiBBbm90aGVy
IHdheSB0byBkbyB0aGlzIGNvdWxkIGJlIHRvIGFkZCBTREhDSV9USU1FT1VUX0NPTlRST0wgdG8N
Cj4gZXNkaGNfd3JpdGViX2xlKCkgYW5kIHJlbW92ZSBlc2RoY19zZXRfdGltZW91dCgpLiAgVGhh
dCB3b3VsZA0KPiBhdm9pZCBoYXZpbmcgdG8gZXhwb3J0IHNkaGNpX2NhbGNfdGltZW91dCgpIGFu
ZCBpcyBwZXJoYXBzDQo+IHNsaWdodGx5IG1vcmUgY29uc2lzdGVudCB3aXRoIG90aGVyIGNvZGUg
aW4gdGhpcyBkcml2ZXIuDQo+IFByb2JhYmx5IGxvb2sgc29tZXRoaW5nIGxpa2UgYmVsb3c6DQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYyBiL2Ry
aXZlcnMvbW1jL2hvc3Qvc2RoY2ktDQo+IGVzZGhjLWlteC5jDQo+IGluZGV4IGZmNzhhN2M2YTA0
Yy4uNjY0NzdmYzBiYTgyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVz
ZGhjLWlteC5jDQo+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4g
QEAgLTg3MCw2ICs4NzAsMTYgQEAgc3RhdGljIHZvaWQgZXNkaGNfd3JpdGViX2xlKHN0cnVjdCBz
ZGhjaV9ob3N0ICpob3N0LA0KPiB1OCB2YWwsIGludCByZWcpDQo+IA0KPiAgICAgICAgICAgICAg
ICAgZXNkaGNfY2xyc2V0X2xlKGhvc3QsIG1hc2ssIG5ld192YWwsIHJlZyk7DQo+ICAgICAgICAg
ICAgICAgICByZXR1cm47DQo+ICsgICAgICAgY2FzZSBTREhDSV9USU1FT1VUX0NPTlRST0w6DQo+
ICsgICAgICAgICAgICAgICAvKg0KPiArICAgICAgICAgICAgICAgICogRVNESENfU1lTVEVNX0NP
TlRST0wgYml0WzIzXSB1c2VkIHRvIGNvbnRyb2wgaGFyZHdhcmUgcmVzZXQNCj4gKyAgICAgICAg
ICAgICAgICAqIHBpbiBvZiB0aGUgY2FyZC4gV3JpdGUgMCB0byBiaXRbMjNdIHdpbGwgcmVzZXQg
dGhlIGNhcmQuDQo+ICsgICAgICAgICAgICAgICAgKiBPbmx5IHdyaXRlIERUT0NWIGZpZWxkIGhl
cmUuDQo+ICsgICAgICAgICAgICAgICAgKi8NCj4gKyAgICAgICAgICAgICAgIGVzZGhjX2NscnNl
dF9sZShob3N0LCBFU0RIQ19TWVNfQ1RSTF9EVE9DVl9NQVNLLA0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEZJRUxEX1BSRVAoRVNESENfU1lTX0NUUkxfRFRPQ1ZfTUFTSywgdmFs
KSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFU0RIQ19TWVNURU1fQ09OVFJP
TCk7DQo+ICsgICAgICAgICAgICAgICByZXR1cm47DQo+ICAgICAgICAgY2FzZSBTREhDSV9TT0ZU
V0FSRV9SRVNFVDoNCj4gICAgICAgICAgICAgICAgIGlmICh2YWwgJiBTREhDSV9SRVNFVF9EQVRB
KQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBuZXdfdmFsID0gcmVhZGwoaG9zdC0+aW9hZGRy
ICsgU0RIQ0lfSE9TVF9DT05UUk9MKTsNCj4gQEAgLTEzODUsMTcgKzEzOTUsNiBAQCBzdGF0aWMg
dW5zaWduZWQgaW50DQo+IGVzZGhjX2dldF9tYXhfdGltZW91dF9jb3VudChzdHJ1Y3Qgc2RoY2lf
aG9zdCAqaG9zdCkNCj4gICAgICAgICByZXR1cm4gZXNkaGNfaXNfdXNkaGMoaW14X2RhdGEpID8g
MSA8PCAyOSA6IDEgPDwgMjc7DQo+ICB9DQo+IA0KPiAtc3RhdGljIHZvaWQgZXNkaGNfc2V0X3Rp
bWVvdXQoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsIHN0cnVjdA0KPiBtbWNfY29tbWFuZCAqY21k
KQ0KPiAtew0KPiAtICAgICAgIHN0cnVjdCBzZGhjaV9wbHRmbV9ob3N0ICpwbHRmbV9ob3N0ID0g
c2RoY2lfcHJpdihob3N0KTsNCj4gLSAgICAgICBzdHJ1Y3QgcGx0Zm1faW14X2RhdGEgKmlteF9k
YXRhID0gc2RoY2lfcGx0Zm1fcHJpdihwbHRmbV9ob3N0KTsNCj4gLQ0KPiAtICAgICAgIC8qIHVz
ZSBtYXhpbXVtIHRpbWVvdXQgY291bnRlciAqLw0KPiAtICAgICAgIGVzZGhjX2NscnNldF9sZSho
b3N0LCBFU0RIQ19TWVNfQ1RSTF9EVE9DVl9NQVNLLA0KPiAtICAgICAgICAgICAgICAgICAgICAg
ICBlc2RoY19pc191c2RoYyhpbXhfZGF0YSkgPyAweEYwMDAwIDogMHhFMDAwMCwNCj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgRVNESENfU1lTVEVNX0NPTlRST0wpOw0KPiAtfQ0KPiAtDQo+ICBz
dGF0aWMgdTMyIGVzZGhjX2NxaGNpX2lycShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgdTMyIGlu
dG1hc2spDQo+ICB7DQo+ICAgICAgICAgaW50IGNtZF9lcnJvciA9IDA7DQo+IEBAIC0xNDMyLDcg
KzE0MzEsNiBAQCBzdGF0aWMgc3RydWN0IHNkaGNpX29wcyBzZGhjaV9lc2RoY19vcHMgPSB7DQo+
ICAgICAgICAgLmdldF9taW5fY2xvY2sgPSBlc2RoY19wbHRmbV9nZXRfbWluX2Nsb2NrLA0KPiAg
ICAgICAgIC5nZXRfbWF4X3RpbWVvdXRfY291bnQgPSBlc2RoY19nZXRfbWF4X3RpbWVvdXRfY291
bnQsDQo+ICAgICAgICAgLmdldF9ybyA9IGVzZGhjX3BsdGZtX2dldF9ybywNCj4gLSAgICAgICAu
c2V0X3RpbWVvdXQgPSBlc2RoY19zZXRfdGltZW91dCwNCj4gICAgICAgICAuc2V0X2J1c193aWR0
aCA9IGVzZGhjX3BsdGZtX3NldF9idXNfd2lkdGgsDQo+ICAgICAgICAgLnNldF91aHNfc2lnbmFs
aW5nID0gZXNkaGNfc2V0X3Voc19zaWduYWxpbmcsDQo+ICAgICAgICAgLnJlc2V0ID0gZXNkaGNf
cmVzZXQsDQo+IA0KPiANCj4gPiAgfQ0KPiA+DQo+ID4gQEAgLTE3NzcsNiArMTc4Miw4IEBAIHN0
YXRpYyBpbnQgc2RoY2lfZXNkaGNfaW14X3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ID4gICAgICAgICAgICAgICAgKiB0byBkaXN0aW5ndWlzaCB0aGUgY2FyZCB0eXBl
Lg0KPiA+ICAgICAgICAgICAgICAgICovDQo+ID4gICAgICAgICAgICAgICBob3N0LT5tbWNfaG9z
dF9vcHMuaW5pdF9jYXJkID0gdXNkaGNfaW5pdF9jYXJkOw0KPiA+ICsNCj4gPiArICAgICAgICAg
ICAgIGhvc3QtPm1heF90aW1lb3V0X2NvdW50ID0gMHhGOw0KPiA+ICAgICAgIH0NCj4gPg0KPiA+
ICAgICAgIGlmIChpbXhfZGF0YS0+c29jZGF0YS0+ZmxhZ3MgJiBFU0RIQ19GTEFHX01BTl9UVU5J
TkcpDQoNCkl0J3MgaW5kZWVkIGEgYmV0dGVyIHdheS4gSSB3aWxsIHNlbmQgdjIgcGF0Y2guDQoN
ClRoYW5rcw0KTHVrZQ0KDQo=
