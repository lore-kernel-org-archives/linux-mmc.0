Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1335338D;
	Mon,  7 Oct 2024 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314239; cv=fail; b=QPRzCghnrwB7vKUAeZsEJ2mw2cFg/tK4H6ZcASjKFUBtqoknoaltFF3qN1Zb6F0fUdLWz8Pba1ebJTMxZrVDqNGjC436ijSK0BfxHRW6Ql2NjTGDGI/GW3EzUgdKIN+vAJRFrZOAwtgLi9AmalK12aYbWIVK2Yhf7hfb4jtQVSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314239; c=relaxed/simple;
	bh=E5GTDjq5ej8lNP/6f+b1V7KfRRR9tn+3XMIiIhq5aWw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=isYH07SCN62ynflUL+6AGFaKeuHjxaz1pwauSO3M6Cvb/eFqJiWn8tD6AYw3tJ5wQRz5oI29LwwiWrV+U8hBTPHcEdKFPPN2+VrfyAtaIwawA+tbBwjupgw9h/Infx3UNl0zyeZ1bp/cjGUE8MvlTn/QbJJtXDGWkQ6k7kXXTqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=HZP2xNmM; arc=fail smtp.client-ip=40.107.22.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="HZP2xNmM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvgS+4nf2vPubKdu2qcawujfF8uC1YWu5T36qXCBtVKEsW5X84yAujN7asRZGRtzOfayCBwv4Io5Y4IGSUYR165D6ZE9kQVkPM3+BLEnVrjJkmq+Jlks66KMLJBQ2fUwj6luw3AUjUHj0dMLPbyOaaqfLgRHgN6meB43TroLzwZAxi0r8RotJlSYLshPN2OP+5fojm3RSgIPTe6vKxK+zx0YPl5ZVWmBIMM7X7PhtHIjGyqsgpglfF0SJx4Wwvas0G/HrQyTevRMFW5p+/pXCaflTYzWHDYd2DUZ/wpiyYtpEExWdbSFY4nHJvzVfXIxgetWvYSraAJ+4s9h2rnkXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5GTDjq5ej8lNP/6f+b1V7KfRRR9tn+3XMIiIhq5aWw=;
 b=W0hD2a+2BwUoHSU/gMqynNIUh6p8DwwA1a9HNolF7HLYcc2FcNYVF0k6cLyyt49tQt+mvbqbID1Y/v0B5lCTwCCnlKN4K3xJQCMCMLsbJWW3zB2tl0SDa3mICgJdQQyP2S5pNy631owj+D01GWpUTquM11rf6FZ8XvzCdtx5RaiuMNBOjuD8l7RNSAuPnBz8XgGF4kDn5jKmiyEv3pGTvjA/zbgS8AwjUtgIlO+ry7LfwqOBjoHOUbwLxCvOgiq+pFKJE+ZIK2p9azM0H5F6iXLcfmv0sfHifjcv3fZEYJn//OS2f3c+GNvjS84gaT64KUrabB+92KIHCo69fzhfbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5GTDjq5ej8lNP/6f+b1V7KfRRR9tn+3XMIiIhq5aWw=;
 b=HZP2xNmMCPbxEFF0n66Gk+caSzs7sSjAIGuUMTUJPeC2J0rtPGb/uJ29JUwH7NWzjXfoHkOyDKFyfvRS4/yQg20/bVYpY9rk2VBNIey/a4ygzqOYCXS+CrPsPDwd9DR9w+iU0sdIzP9qcN9y3jI9Yk586a+r79UM/SQB11rSt+Q=
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com (2603:10a6:10:1a0::11)
 by DB9PR06MB7516.eurprd06.prod.outlook.com (2603:10a6:10:257::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 15:17:12 +0000
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0]) by DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 15:17:12 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "m.felsch@pengutronix.de"
	<m.felsch@pengutronix.de>, GEO-CHHER-bsp-development
	<bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: mmc-pwrseq-simple: add support for
 reset control
Thread-Topic: [PATCH 1/2] dt-bindings: mmc: mmc-pwrseq-simple: add support for
 reset control
Thread-Index: AQHbFlYFMAy48xaGhkKxPcYJRjcHabJ5rGeAgAG+44A=
Date: Mon, 7 Oct 2024 15:17:12 +0000
Message-ID: <e5c3daec-ab85-42e5-b8b5-25fbc3e1271b@leica-geosystems.com>
References: <20241004120740.2887776-1-catalin.popescu@leica-geosystems.com>
 <kpg2cwn7eq7wclpmcudwmygqzzn7s5fb4i7c2dbjlks5bttghs@aekop3ugv26s>
In-Reply-To: <kpg2cwn7eq7wclpmcudwmygqzzn7s5fb4i7c2dbjlks5bttghs@aekop3ugv26s>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBAPR06MB6901:EE_|DB9PR06MB7516:EE_
x-ms-office365-filtering-correlation-id: bba456e2-10f8-43ea-ae5c-08dce6e31e77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WGxGWHJPeWVEb0FqNVVHT3hPOEZyN1FEUGhDZWp1dVYvT3NldVc0MVk3R0Ew?=
 =?utf-8?B?VEh6M0tKc0ZWenVENm1QMURIVnlaN0ZhS1dOQkVXR2VSOHpvMVFScTJtcjhm?=
 =?utf-8?B?VkhMNndhQlJYcmZEYzFoV0dnTDB5YUNOdjNXSnNPZDB4aVl0MmJ1QzIweEF3?=
 =?utf-8?B?RTMvSUhEU1NiaTh6ckhKSkJQMWlzbWk5Yi9nRk9lRHluYXVyTVZISTlrOVdh?=
 =?utf-8?B?eENaQmx3TjBGQ0pxSHFHWmVGaUR3all3SmcvQ2pSWVNyZjVLZmczVDhGVUIr?=
 =?utf-8?B?WENKcVRmOTA5WjByVHVFWGtFT3lRSTQrWDYvUFF1ZmRkL3AxN1hCYkkxSExm?=
 =?utf-8?B?VzgzZm93bFZvckErV0t2dnVUNGkyZVJmV3BhNVVYQVBkK3NJTW1zQmIyWFAw?=
 =?utf-8?B?K056NXZnMVVlbys3VGN1VjZDd0d0VFJLdGVJaTVKaS9JK3lMUm01U1UvUVQ4?=
 =?utf-8?B?NExxY0MycU55ZWNvTlZMbUFzK25nVTV6d1daS0hpU3lPSzUzQ0hPbFhobDI0?=
 =?utf-8?B?eXpOOENGajBNUUdxWDN4Sndtelh3RXVBdXFDSVhERGR6azBDTG84NDFTZkpx?=
 =?utf-8?B?OEwwL1ZHaUpqeTB0dE9GZDREOWlZNnlXNWVma2Q2c2lLVzI3RFpFS2U3bjQx?=
 =?utf-8?B?WTN6SVlWUW4wSW5DVjA5bW1WMUtqQ3ZlNlMvVkFDMUJMd3lMSFVFZ205YXll?=
 =?utf-8?B?UVMrb2tXcWc1YUlValBsR3J1VVQzeVdjckw3Q1NOVWptRXRXK3ZjNFFGazRh?=
 =?utf-8?B?TlJyS1lhdE9tOW8wNzlQQlQzS3ZUOVJnMGwxSmJwNEVCWGFjWEVqQWhtbEJR?=
 =?utf-8?B?MklUREpIdTN4KzBOV2o0OVFqTm8yNXJ3QjVJb3RxT3lNRVJnU3ppTno3cmtr?=
 =?utf-8?B?cGpqU1daR051eTVxVzVpTG9yWUlzZ2VkTnV3RS94eGVDbVB2azlaN1FBc1R1?=
 =?utf-8?B?SzBzckZ3NXViZjZGdUE5bkV6SU9GOUxYV0JRQXZoRkVyTHN0Q01DSjl3UThI?=
 =?utf-8?B?YXdtTmJheWM2c2xmbVh5TExNT3psV21HTS9UYnczWUNocFVqbm1WWmdpVmxM?=
 =?utf-8?B?R1d1b1BlV2pFaE9GeVZhUEQydG1yY0hBWXI5YjR6eG1wTE1aZFpVK0JrZlpR?=
 =?utf-8?B?WFh3WlNQTVhobDF1TmQvdmF1T3M5T3Q3eHh0by9ETCtYRlRLOW5XM25vZE9l?=
 =?utf-8?B?SmI4T0p4blowbTBDMHowU1NwQk1LV2w3anoyUVRwNHptRXhKa3dpM0E1c2xC?=
 =?utf-8?B?bFBHQ3BoNERXakc5VUluQWRCWjBmVVVFL3hoSVZVWHhCUXN1Ni93MUJRVFI2?=
 =?utf-8?B?a0VISzVyQUo4SW1PckVsZlplbnlEbUFCbGY4RnRQSzRRRnpXVHlZdW1UQmhW?=
 =?utf-8?B?bXdZeGIvajZWcnBGTVZFQTZRd01vM1F4QlhnT1dWaVVDNXh0QlRmZTB2TElH?=
 =?utf-8?B?eENZWXJzRExiZEo4ZXdRaFdwNzAxekZrblJSdHFCaTAvMVRhSFRTQU0zY3hV?=
 =?utf-8?B?MXYvU0hPSmR2aFZURjR4T1BCd3A0Tmcza3JMTWtsSWsxZ3pTU1lCMHE5Z2xR?=
 =?utf-8?B?NHhQYmQzSTlMMXgyL2p3Mk5SNEJKTXpsVXpnaFlrZFloWTVreG1aQUdsaUpE?=
 =?utf-8?B?VSt0QzJhTFpFL00xdDVYbXE4b2ZUMjY1YjVIcDJxK1kvcHZXaVRubXVrWnh4?=
 =?utf-8?B?MzdDUWU5RVpvK1l5dUxpdHR0TzA4Zmw2OTdEQS9sNmNUaGw0ZkVndGJSK1Zm?=
 =?utf-8?B?Vlk1VlZKekVBdnpicmJWczk2dEt4Zk1tSDNvRTNBWFdLRExISmVINkpKOGFR?=
 =?utf-8?B?OUkyUmUvUWVsTi81QWtyZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR06MB6901.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NmhYOXdhSUFsRnM1Nlg5eGpIUkRzSE5pTnh6d3R2anZLMGlYNm1ueWFzUGdy?=
 =?utf-8?B?UzB0TnFQbG40OXhHTzBjWHB2bVk3dXFGSnJiaCsrY1dSdmFNbWlJZkU4enFY?=
 =?utf-8?B?MTlEQ3U4Y3hRcUZ3cU9CWC9Vbmt1eGJyeWREYS94SVhBYnN1YWJJUjBCSkZN?=
 =?utf-8?B?RWV6UFBLVjFEOUE2QUdxZHJ2YllBb3o1LzRjUkhzL2dleGFRYVhoMG44cWZj?=
 =?utf-8?B?bEpTSi9QSzloVkwxRUVudm5lcXo1NC85TWV2ZzVuRUttdU83c25DOUwwcEhx?=
 =?utf-8?B?NGhYSmdmQUMyZTZwK3hLWXUrVFhQem4zRldUd2tqb0drM1JPcFN6TXJQSXlR?=
 =?utf-8?B?V20wRHRjRUxOUHg4OHc3eE9hNXFrK0Z6aU5mSVVGVExHbXRBK2Z0RGZZbFVj?=
 =?utf-8?B?SzZpdTdSRGswZHd6ZmdqY1NHMkxERVVESDh5b0tFWWt2bGhhaGJwZFUzZ0dP?=
 =?utf-8?B?KzVTNWdVaFBsQXZ0S1Azb0xiN0JPQXBLSU5xbTR6eU1mU21sNWJmUzJMbEZL?=
 =?utf-8?B?RURHWHlLMk1UUmZlcUFkM3Q4MnVxMGZCVW9QRkROaW4zNFNPOGowUzdPTmNm?=
 =?utf-8?B?VDBWVGFaS21TTWJTaGNnN2V3QnZRb0UwdjBwbEo5enNuYzFsN3BUT0FRZHBq?=
 =?utf-8?B?T21sQmE2SmtNYWVXbEpuY0pRVm1hR1pBOUNPK3NDc1Q2NWs5WkJvaDhTOHFU?=
 =?utf-8?B?RnI5aS9ya1pRc21tSktjeStSWmhoamYzZ1h3WnJEQVNpYnZ4Y05DZmwvUE4x?=
 =?utf-8?B?K0hrUFBFZHpVQXF3RnlZdTRXbXF5YjlHbk1RbUQya2R4cmordjZFZmFGZjhJ?=
 =?utf-8?B?VUU4R242TFJPMFg0dGhiZ20yUVV6N25VcDJiUFdUWjh1Q0ZVb1lVa2t2RHZw?=
 =?utf-8?B?d0RWejRWQjdtS0hYcHorWmc5OVJlZWhRemQ1WXNQUlJWSC9yRENJK2RuT0tE?=
 =?utf-8?B?T1labE9MbUhmYWM1UGZtTVAxajF5TGlFZGNwVDMwQ1lRNGhrT1FUMU5PZUYw?=
 =?utf-8?B?VmxONTdjTHlveXUyU0JWZFFXL0hCaGRjelZrdWU5VmVxNlBmdzNjRVFuNlhH?=
 =?utf-8?B?V2M2a0RzZTBCTUVGOXlCb0tnUXU3QW1qMjhGU1N1cXJKeDhuNTd4NTlwTkpj?=
 =?utf-8?B?OWdRU2dJVkVFV2ZGVk8vYjNacWlhdTBrNi9ZNnlWLzh1RStKemZGTkRCV0Ur?=
 =?utf-8?B?SDA2SUl3cWJkSnFuWFplNG1aTVpGZkwzSUhPbkVrbThsQUQxd1BjdG1oN3RT?=
 =?utf-8?B?bTRTOW0vNVlKUktpRGhwcGlWbU9PWkZJTGJySGNNb0pCQXNHYURJZ3oxcWZv?=
 =?utf-8?B?ekloSkFoV2l5ZGZDa2J4NEtyNHB3RjRKSS9nNWErY3p4K1BWUHFGWDZwcFdi?=
 =?utf-8?B?V3d2cUcrU0hIYVJoNXBMUmJ5S1pFazVWckFRTm5GdThCTUtud1h5dHRrL1lZ?=
 =?utf-8?B?VkdwbDhYRi9iQzZsV3BrRGQxK2I1RXNNamJINHFNaTVnUFgvQ1JDMjAvVTZl?=
 =?utf-8?B?c3NScXRwcjUzb3pqM0lPNHl6RUR3UFltc2FDUm9teDVHc3hTbGN0MjVaZklH?=
 =?utf-8?B?LzhrWW43TUY3L2xYYzAyd2hBVHZjaFE5eFpURFBIYmYxWmoyUjg1R0FiMTZD?=
 =?utf-8?B?NlNXcGRoaUhaSG5CWnlzVHlDaHdEQkwyUWZnZmswTkdPQ1p4ZDVoSW1vTTR5?=
 =?utf-8?B?YThNc01xUDJGdVBySDgrck9ubTlIclkyNEE1cGpncW80dkdERUZjV09uNm5y?=
 =?utf-8?B?clNJZ1kraWZDd3d1YXR6Zlc0eE5GTUdsS25oZTVJUXMramJPWjB2OFgrOERR?=
 =?utf-8?B?cjlVc3hrMkR4cEs3ODZGN0pjOG5NSytuY28xcTNDNFArNHJtUTQwNFhMcG02?=
 =?utf-8?B?bTcxdHZRTnU3UVFWYTlqcXZuSFVxZTZZSEVORnBrU2pQbTlELytwOHo1Z3hh?=
 =?utf-8?B?SkpiSTV4YktqdE5KOEc3Qzk2ZXl2a1BodDFyNUp5ZEVMM3d1NnVlWVU4SUtD?=
 =?utf-8?B?Nkd5K1ZRVVBaNTFSM2pJUW8rU0JoZjBoczNQNFVxMXM5NW9nSnVWN1o1cHRv?=
 =?utf-8?B?bEhHa1ppa215OXNTTGFIWlhjQnR3WGN6MG85WVhzT3RCYmxNdHdCRDcwL1k4?=
 =?utf-8?B?R1l1bzIvUmRzZlJ5WWJnTmRaNko4dEhWdURaVXFIVklDTy9mZkJuQm54UTZS?=
 =?utf-8?B?SEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C721919BF129B34A95B92F864B00AF42@eurprd06.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bba456e2-10f8-43ea-ae5c-08dce6e31e77
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 15:17:12.2548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /p900YXdhWnslGV2m1k2+PRGDAfp5nxSKTvapNGua+AhfS0L6W0AAOas/dCa2Dit8MIBtBqvHTKX/jPztA/f+mWOrw7OQAXaugeAMwte5t4Rj475U7Eikgh0JaXc4wZX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7516

T24gMDYvMTAvMjAyNCAxNDozNywgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gW1NvbWUg
cGVvcGxlIHdobyByZWNlaXZlZCB0aGlzIG1lc3NhZ2UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZy
b20ga3J6a0BrZXJuZWwub3JnLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6
Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4NCj4gVGhpcyBlbWFp
bCBpcyBub3QgZnJvbSBIZXhhZ29u4oCZcyBPZmZpY2UgMzY1IGluc3RhbmNlLiBQbGVhc2UgYmUg
Y2FyZWZ1bCB3aGlsZSBjbGlja2luZyBsaW5rcywgb3BlbmluZyBhdHRhY2htZW50cywgb3IgcmVw
bHlpbmcgdG8gdGhpcyBlbWFpbC4NCj4NCj4NCj4gT24gRnJpLCBPY3QgMDQsIDIwMjQgYXQgMDI6
MDc6MzlQTSArMDIwMCwgQ2F0YWxpbiBQb3Blc2N1IHdyb3RlOg0KPj4gQWRkIGNvbXBhdGlibGUg
dmFsdWUgIm1tYy1wd3JzZXEtc2ltcGxlLXJlc2V0IiB0byBzdXBwb3J0IHJlc2V0IGNvbnRyb2wN
Cj4+IGluc3RlYWQgb2YgZ3Bpb3MuIFJlc2V0IGNvbnRyb2xzIGJlaW5nIHJlZmNvdW50ZWQsIHRo
ZXkgYWxsb3cgdG8gdXNlDQo+PiBzaGFyZWQgcmVzZXRzIG9yIGdwaW9zIGFjcm9zcyBkcml2ZXJz
LiBTdXBwb3J0IG9mIHJlc2V0IGNvbnRyb2wgaXMNCj4+IGxpbWl0ZWQgdG8gb25lIHNpbmdsZSBy
ZXNldCBjb250cm9sLg0KPiBEcml2ZXIgc3VwcG9ydCBpcyBub3QgdGhhdCByZWxldmFudCB0byB0
aGUgYmluZGluZ3MuDQo+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDYXRhbGluIFBvcGVzY3UgPGNhdGFs
aW4ucG9wZXNjdUBsZWljYS1nZW9zeXN0ZW1zLmNvbT4NCj4+IC0tLQ0KPj4gICAuLi4vYmluZGlu
Z3MvbW1jL21tYy1wd3JzZXEtc2ltcGxlLnlhbWwgICAgICAgfCAyMSArKysrKysrKysrKysrKysr
Ky0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bW1jL21tYy1wd3JzZXEtc2ltcGxlLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbW1jL21tYy1wd3JzZXEtc2ltcGxlLnlhbWwNCj4+IGluZGV4IDAwZmVhYWZjMTA2My4u
ZGEyMTgyNjBhZjAxIDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21tYy9tbWMtcHdyc2VxLXNpbXBsZS55YW1sDQo+PiArKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbW1jL21tYy1wd3JzZXEtc2ltcGxlLnlhbWwNCj4+IEBAIC0x
NiwxMiArMTYsMTMgQEAgZGVzY3JpcHRpb246DQo+Pg0KPj4gICBwcm9wZXJ0aWVzOg0KPj4gICAg
IGNvbXBhdGlibGU6DQo+PiAtICAgIGNvbnN0OiBtbWMtcHdyc2VxLXNpbXBsZQ0KPj4gKyAgICBl
bnVtOg0KPj4gKyAgICAgIC0gbW1jLXB3cnNlcS1zaW1wbGUNCj4+ICsgICAgICAtIG1tYy1wd3Jz
ZXEtc2ltcGxlLXJlc2V0DQo+IE5vcGUsIHRoYXQncyB0aGUgc2FtZSBkZXZpY2UuDQo+DQo+PiAg
ICAgcmVzZXQtZ3Bpb3M6DQo+PiAgICAgICBtaW5JdGVtczogMQ0KPj4gICAgICAgIyBQdXQgc29t
ZSBsaW1pdCB0byBhdm9pZCBmYWxzZSB3YXJuaW5ncw0KPj4gLSAgICBtYXhJdGVtczogMzINCj4+
ICAgICAgIGRlc2NyaXB0aW9uOg0KPj4gICAgICAgICBjb250YWlucyBhIGxpc3Qgb2YgR1BJTyBz
cGVjaWZpZXJzLiBUaGUgcmVzZXQgR1BJT3MgYXJlIGFzc2VydGVkDQo+PiAgICAgICAgIGF0IGlu
aXRpYWxpemF0aW9uIGFuZCBwcmlvciB3ZSBzdGFydCB0aGUgcG93ZXIgdXAgcHJvY2VkdXJlIG9m
IHRoZSBjYXJkLg0KPj4gQEAgLTUwLDYgKzUxLDIyIEBAIHByb3BlcnRpZXM6DQo+PiAgIHJlcXVp
cmVkOg0KPj4gICAgIC0gY29tcGF0aWJsZQ0KPj4NCj4+ICthbGxPZjoNCj4+ICsgIC0gaWY6DQo+
PiArICAgICAgcHJvcGVydGllczoNCj4+ICsgICAgICAgIGNvbXBhdGlibGU6DQo+PiArICAgICAg
ICAgIGNvbnRhaW5zOg0KPj4gKyAgICAgICAgICAgIGVudW06DQo+PiArICAgICAgICAgICAgICAt
IG1tYy1wd3JzZXEtc2ltcGxlLXJlc2V0DQo+PiArICAgIHRoZW46DQo+PiArICAgICAgcHJvcGVy
dGllczoNCj4+ICsgICAgICAgIHJlc2V0LWdwaW9zOg0KPj4gKyAgICAgICAgICBtYXhJdGVtczog
MQ0KPj4gKyAgICBlbHNlOg0KPj4gKyAgICAgIHByb3BlcnRpZXM6DQo+PiArICAgICAgICByZXNl
dC1ncGlvczoNCj4+ICsgICAgICAgICAgbWF4SXRlbXM6IDMyDQo+IFNvIGJhc2ljYWxseSB0aGV5
IGFyZSB0aGUgc2FtZS4uLiBTb3JyeSwgdGhpcyBhbGwgcGF0Y2ggbWFrZXMgbGl0dGxlDQo+IHNl
bnNlIHRvIG1lLiBZb3UgYXJlIG5vdCBkb2luZyBoZXJlIG11Y2guIEl0J3MgZXhhY3RseSB0aGUg
c2FtZSBkZXZpY2UNCj4gd2hpY2ggeW91IG5vdyBkZXNjcmliZSBpbiB0d28gd2F5cyAoZmlyc3Qg
bm8tZ28pIGJ1dCB0aGUgdHdvIHdheXMgYXJlDQo+IGFjdHVhbGx5IHRoZSBzYW1lIChzZWNvbmQg
bm8tZ28pLg0KDQpUaGF0J3MgYmVjYXVzZSB0aGUgcmVzZXQgZnJhbWV3b3JrIGRvZXNuJ3Qgc3Vw
cG9ydCBhIGxpc3Qgb2YgcmVzZXQgZ3Bpb3MgDQooYXNzdW1pbmcgdGhhdCBSRVNFVF9HUElPIHdh
cyBlbmFibGVkKSwgYnV0IG9ubHkgYSBzaW5nbGUgcmVzZXQgZ3Bpby4NCg0KQm90aCBncGlvIGFu
ZCByZXNldCBmcmFtZXdvcmtzIGFyZSBleHBlY3RpbmcgdGhlIHNhbWUgRFQgcHJvcGVydHkgDQoo
InJlc2V0LWdwaW9zIikgc28gdXNpbmcgYSBkaWZmZXJlbnQgY29tcGF0aWJsZSB0byBkaWZmZXJl
bnRpYXRlIGIvdyB0aGUgDQoidG9vbCIgKGdwaW8gb3IgcmVzZXQgY29udHJvbCkgdG8gdXNlIGZv
ciB0aGUgcG93ZXIgc2VxdWVuY2Ugc2VlbWVkIGZpbmUgDQp0byBtZS4NCg0KPg0KPiBCZXN0IHJl
Z2FyZHMsDQo+IEtyenlzenRvZg0KPg0KDQo=
