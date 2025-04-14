Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DE645C18;
	Mon, 14 Apr 2025 06:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744613347; cv=fail; b=U+CuX4WlyabWyi9lGvrzpOCwwzUrCogKV2a1iVwG1F/NidoBy/iOnUDNngOhAduafh5S4jLz+DZWaCkWZWpSO+ZUdDoYQo0wkSszxXkdpxTL8rAWtJdAleYD99LQ6RujENuoqx+wWT847X85OZ6RdQH5ZDTufl4rvdnqATzmnmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744613347; c=relaxed/simple;
	bh=TypUddpTzZadBR/5MoZsg7/5F0ctY5m5FCfVngkmuoU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kGF223hB+6LFyuxx13pPYZF9feFF8YKkiM9oKoKrt+APX1Kj11H+LIx6VKPXjyR/+OIG5KHmA2kciLsLgU1qwn9GoHumBPLmRAxKYO5I8zvFu0/VgcCnLcV0MSON/7jCA1hbQzmL72pLpQXXJZyd+/9S8mY0hFNvjlY4qnDCyUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TvZYJFdD; arc=fail smtp.client-ip=40.107.22.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TvZYJFdD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocLeZhQ1VzL6eYQWYKwl0ub5ULso4R2tCN9dIRCH9x5Ch305XIhsborRszjF2QwX1ulEjD85GeEWwgUeU2qBOkxFN9cHdsBoIinvh+rjwqKius6taHcJmLayXq8XRI9I/GpfQxGSASxMTFIodnxpIorfExwCKWHdJEQUOTcYRsF020LwJdl+sjqsGh21+R8HapHR4X4lQuBwolS3dge2ZA09uzVTL8l38kfOTUvJulJ9HTu2hm0bqaHe4y7SwFzfCdGmy+lBeYB3odyXyHp8/dLcV8YvMxhzjSaKN5Xs6pou9gVv4e3KM3TicRcGeI2JSWZdIeF3E9Eh6tv1M2dlEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TypUddpTzZadBR/5MoZsg7/5F0ctY5m5FCfVngkmuoU=;
 b=anY2jOJgqBI1HHv1Thj3n2stua9tWmtYFnbCQwtqKBwMVhJnwbV2aXn0Y7m3tT1u7JojZ3Vcx9+m9tAH2f/8pLo/SHQ+a8i6KOmDucKXY4+GtiJlhGLPw4+maJsK5nmKtGXuilBBhJ2CxH3nXwiif9oXNYnFEc2Sk4FPf2Q1gkh+elFZQ3CnqxzezCz4gmsOzQCf0b90GAphAXRzr9VtQrY4n5OyRbNzsKw9891/osp0lycKJ/6weRCzWzZgGMk9QRcFH4mRaiJYd8qUFxu1wFL2raUDOzd/5qJJPnBy/3RUE6nIDew8mWSymhtKXbjNgZ0w3Z5Me5b9TgruB1zywg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TypUddpTzZadBR/5MoZsg7/5F0ctY5m5FCfVngkmuoU=;
 b=TvZYJFdDo89tBB4T5UcQAkVuosG+lo90jfXD4eAm9XTARrdHALV51Ggc2Lz1duHUgsSPNsWaCqgsDLg6SzB0TQrXsNRWBwK49NEVuuDtujjSB+UtrQEqhLdVOEmV3tqTqpTIeltgLHB/sAoMpL7HiVw1CWEkqPFI43g/yTlg5m6ZohjMj6gze3/JRTqLM0ctXerdcCb8XyvrLW/ETZCXXTLCA1LaovpfU7D1ZYBnRIZ0JNWVDuOmHMdbR0Yc3rCQpGvWOe5edleZbIjOyp7PXDhodx1zmuM4xY1YXd63Pr26Bi9qsR7aF6Ye5dAJOixRyzvKR3n5eW4cendIpWlezQ==
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by PA2PR04MB10279.eurprd04.prod.outlook.com (2603:10a6:102:406::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 06:49:02 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%5]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 06:49:02 +0000
From: Luke Wang <ziniu.wang_1@nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Arnd Bergmann <arnd@kernel.org>,
	Bough Chen <haibo.chen@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>
CC: Arnd Bergmann <arnd@arndb.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Josua Mayer
	<josua@solid-run.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, dl-S32
	<S32@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH] [v2] mmc: esdhc-imx: convert to modern PM_OPS
Thread-Topic: [EXT] [PATCH] [v2] mmc: esdhc-imx: convert to modern PM_OPS
Thread-Index: AQHbqsAQEeWYoKBe402OH8kq6kt3qrOeTE4wgAANHgCABGJDAA==
Date: Mon, 14 Apr 2025 06:49:01 +0000
Message-ID:
 <DU2PR04MB856727E826EC17365709C9C2EDB32@DU2PR04MB8567.eurprd04.prod.outlook.com>
References: <20250411085932.1902662-1-arnd@kernel.org>
 <DU2PR04MB8567B7E1DF735B19F54A987FEDB62@DU2PR04MB8567.eurprd04.prod.outlook.com>
 <0204ba93-a987-4e88-9992-e160b488b680@intel.com>
In-Reply-To: <0204ba93-a987-4e88-9992-e160b488b680@intel.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8567:EE_|PA2PR04MB10279:EE_
x-ms-office365-filtering-correlation-id: 08bd7fbb-f6d2-446c-4d6f-08dd7b2070ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aU1CcTFvM2FaL2t4N2tyYUVvQk5Jekc3Q0FuMHpRTFFQaE1YTHpubFJPSU1h?=
 =?utf-8?B?QjJlOVE2SkFRdUZ3Qno0ek5KY1BhOVFWUGRZQkVUTmVwb1h0N2dBdENSYnM3?=
 =?utf-8?B?dmdKS1piTHNmcDZqSHBaWXZoOHZ2VloyTmlQem5UTUdwTEJpZGRNNjlFWHFk?=
 =?utf-8?B?RUhXZW1hVkNsVWYvdzhjQVB2SUdmcHFOU3FhM01wdW84UjdkeTRpYzJxVXll?=
 =?utf-8?B?TmFrTld4VlhnV2hrSkdTWUVUYWRsSVJhc3NLem1rNnQyUVNMbk5ycVJQSmZC?=
 =?utf-8?B?Y0xaTm10RzB2akM3QWV3Tk41eHd1NUtGcHRoOWNiRFNhNnFMMDRlYThiQ2xK?=
 =?utf-8?B?Y29wcE12ZThmTjRGa0NOZkNESExpTXBCK3UrVjZGbzlrMGh6bE9yVzZFbW9Z?=
 =?utf-8?B?bzFTU21zczhUaHFTRDNSTFNiMTFRQmVwTEEvS1d3NG5IM3NCTjFoSVI2Vy9E?=
 =?utf-8?B?NU9wVG9NeGNtRWRlQ2dvZGhERFNKMXJXQUk5U2Vld0ZlODYwSnV0dEFyNUZi?=
 =?utf-8?B?Y0F4UWR4T2NNUzZKVHoyTjZZQVRKQUl0bDAyRmtMdGJHTkhyR2ZQVHppSjA0?=
 =?utf-8?B?TmVXT2VkdGk4cUdnSnNVajdJOWhidWNNWFFmUmVRelpHeVQ5Qko3M2NjUGxI?=
 =?utf-8?B?eXF0M0c4c1kvOVQwejQraWE1UFp0TGJvbjBkWStISFJVQTdnYWNmbm5kNUhQ?=
 =?utf-8?B?UnBrb3kyZXAyNUZqNkUvV1M0Rm4rb0Y5cHg2a3JPZHBaY1FUbmwyb1lmRzFP?=
 =?utf-8?B?QVV6Q1VEd0t5ZzBuNkdmNzhEemliVVBiYUxPejZkWTRHTjlkREpFUmxLWjZt?=
 =?utf-8?B?bEpRdXN3WEo4WWY2T3VjQ3UrcEhlV1hEcDBEQXBoK3R3ZFBFY2p2a21GZEpo?=
 =?utf-8?B?ZnBPRlFyUEladyswckdqbWRackpvUkRKMmZFTmpMMThqaDNReHNiUWQ1b1dB?=
 =?utf-8?B?dTJMSUhFVXZYS0s0a3BtSzNoL0hxbndPcStoc255emhvbTAxdEZ6cmpiR3NV?=
 =?utf-8?B?YTdwcmFqYnAzVWk3QkEyTmdhdHhZaDhqYW1JR2lpNWNwa2hvUHBWNmRHUDRH?=
 =?utf-8?B?cThVbUw2MFlpbTlBbHh1VFRjVGlBSWxWTTh0dnNBNkZyWVQ3NWxPc21kNUxt?=
 =?utf-8?B?Ky9jb1RUOUVvbFlZdy9oRW1xcjhpc04xYmlWbUo0ZjZCNzZrSlBjSDVSMHpO?=
 =?utf-8?B?VFQ4WnRxZndqaHErd0VRc2N2SXNuOGdHVGR5Z1FJQkp0dDZWcklEVXE4SDVt?=
 =?utf-8?B?L2IrN1grS2YzM1o4dWRkczZlN1QwUDAzRy9SeVJ0N1Ftd1Q5Yzh4ZlZTQlBk?=
 =?utf-8?B?dnpuUDUyS0d5ZkJ5OFQ4VHhMbGVvUmpjVDVvZnRKdFZNZzBHZ1ZEcklDNlk4?=
 =?utf-8?B?UFBiUGtnK0JhT2VRNzV3RjNYTjVVMUc1bjc4WlVGK01jWmhzWnlXOVZDS2ov?=
 =?utf-8?B?NVJSYnp1ZlkwZXFZYWV6NlYzOGZKeWJoN1NsVFQ0OWlsa2VjbTBUbmMvS3E3?=
 =?utf-8?B?K083TlNQOUFyYWw0Um1WTFlUTGtHRkE1OFlmQ0M1ejQvNE5yRDQ5REpST1hM?=
 =?utf-8?B?cmdsM3ZsN3NqSThlUjN2MTFMamlnYmxlMGtWYVVWVUZtWkQ1WlJ2UTQvOE1y?=
 =?utf-8?B?VVVMQjRUUUVSZDJualk0dXl0NGRrM2pOQTNyMG5tVE5SQzVlbzh3ekdZWG8r?=
 =?utf-8?B?Zm8yWVpTN3dmWEdrMmVjUFBocDMxelQvRDFwZ0JNcUcrS2JaVWFKdTFCTTBO?=
 =?utf-8?B?aDB6SU1UU1NJQnIrdjVnR0ZjcDE4Z2IxcmpmUDVUaE1TU3NQUld0K3hicU8x?=
 =?utf-8?B?VndDcHhLNkUvY2hTSE5qdHBaOURTMkRpWmRPbmpFc1RpVWZPdmhPd1dydlJi?=
 =?utf-8?B?K2czKzlReFUzRTEwNFg4ZkVqVEVLTDcyK2lFQ2hVa0ZXQWFYdFVRZERFL1Y1?=
 =?utf-8?B?Y1hqWDFuMVBoTm92MjdvK2lNZUtaSko3MDlVWG1RNWxxS1FHMS9BQlcxeWI2?=
 =?utf-8?B?dUdoWWs4TFlnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2ZwT3cwdTJKOERTeHJFNndPbVBIcitGMWtWd0lGNHpmVjV0SXVQejlmUkhv?=
 =?utf-8?B?SW13YkFaYlV6MFJjV2J5RlovdDVwa1JkeVcvWlZLbHRzbmhSZUFIZG5pdlFj?=
 =?utf-8?B?V3pjMUptR0lQcW01Qjc4aWNyUDRTZjVCbWtIa29JZ2ZObGt4eVVjVldmL3JD?=
 =?utf-8?B?M0h3cmdrOXVWbGYyNHV0RUhQUUFVMkNwaGU4eGlTQ0RGck1vd05PZUV3NnNi?=
 =?utf-8?B?dFZvckhzQm9obktsYVFWeENDYjN1VWpLaDM5WSt4aTVSSVFxNWdjZXh6RGw0?=
 =?utf-8?B?R1RCdFpJazFEKytsY25JNUxtVGZUSE5DWlFNcjFNeFZTN2JWbTdWbUVMKzR2?=
 =?utf-8?B?aVBtcjZrTURDQldna3g3Q0hKN0REdHo5em1Db1orK09KSkd6ZkFmMGJ6WXgv?=
 =?utf-8?B?LzBYQ0RyWXVVNHBra0FTbk5rNElOUlZOUGlLcDNmSzNtYmgrN2tFL21EcHll?=
 =?utf-8?B?eUZuQVNpMTVoWmZURTYyQjVqamg3aXZSL0tYS0FUOEc1WHo1N1AzSUgvUE00?=
 =?utf-8?B?RmVrZXhLbFRXV1Z3bUxBZis1YnU0Mk44alNzcHlNOW8zSkFhOEw2TUliSXI1?=
 =?utf-8?B?VXFCWnhKamtKUHN6aEkxayt4U0k1S0lEcFNqbm9IWnBLTk0zeUhJR3pqdkdH?=
 =?utf-8?B?dDh5cWRoQnlXYzF5d1pmQ2V3dDl3L004OWwyREs3NmVEeWpIS3VGN2gyc3Nw?=
 =?utf-8?B?QWc2L1lyRDVET2xnYVZpT1ZHVjZHNHhraXRMSjF3WEJReDg4SncxeU5YT09S?=
 =?utf-8?B?bWkyUkE1bXZtajBuWWgrL2dYb0ZPQlJKaDcza0hnbWtQSlU0TjB1djZiOG1X?=
 =?utf-8?B?dHFuMnllSDdEVVRXU2ROanVYVWFGVFZvOWhhM1ZTL1RyM2xQam8wNlpaWC9u?=
 =?utf-8?B?WnNCUUF0am5QcEg1b2xwTEFlUEhNQmlpbTVKTEdnTGE5dTV0NGNpRWpEclNw?=
 =?utf-8?B?bWMzemptNnRBTDAraWJGYllPM2Y5cXZrV2ZXd2lXY1lJeURma3IzeEY3NUpj?=
 =?utf-8?B?eHVIZEp2eWVjN3BNM05KY3BQMTlmelRqNXlESVk2UFp5RnRwL0pFV2dYRUFR?=
 =?utf-8?B?YWtrYWQwbi9sRVJlWFh0MEk4MnFUZzBSK0RFRmxXaFNFdGxZQTV0RjcyOVNl?=
 =?utf-8?B?VWtRRDNjc3A0d05NSVZXazN3MXEyOGNuQXhaYzRvcDExQ3crb2R6bEN0cWR5?=
 =?utf-8?B?V3hSSk5xaUQ1WSt5NnZuN29zSG5YZmFCWTJraFFqMUc1UVlvVzZIQURnc2Vq?=
 =?utf-8?B?YythajFobE1pWmFNM0UrNTF1ODRRQlI3OG5HTUxPenpySXc0b25SL1p1UmMr?=
 =?utf-8?B?bUJtUUhhMTZISnl4TzVXaXFkQVAvU1lRNVFDbmZ1ZnVHUE11TTcxSE10YnBj?=
 =?utf-8?B?TmhEVkEzbWFud0ZrMkdoTGdaNFJ4Z3pHek9ZR3lrbjNVdmRIZEwySEtLMzgv?=
 =?utf-8?B?SzJDMHFFUXo4N09KNkoxTFBqcFUwSE9pSE5kbFU4WFZ0UXhjQVcxWGlCUEx2?=
 =?utf-8?B?d3ZqcmlsdVp0R25UUVhLWk0yZU5pa0hDTlZiMnV1STdDSThhSlVoVEZoQUI0?=
 =?utf-8?B?SWlEMFVrLzljUlFmYmJBR2I5M2poaXM1OTlsVnppMVdTTzBsRFRtbTIxRXBv?=
 =?utf-8?B?d1lNVGpNZThZSFcrZEtVWE1HaW8waTh6QVUrWnQ5YXAwem5VL0JOZjZqdzVz?=
 =?utf-8?B?K1JHWHhkVlk3d1V1UFBMMEhOOXV0UkgxS0piVkNZSmpZajYvRHd4TnFOTm9y?=
 =?utf-8?B?dE5Sd0VRU0ErMlV3aHlrNlVRdW9ZSGhWQ1ZpaDhVZmxrbWVSdWszalMwTWxV?=
 =?utf-8?B?cnRNbGQ1NGJ3T29iOEo2ZlRNL0x0akJsUEhkRzR6Rld3OXAybm91VkxnZ3RL?=
 =?utf-8?B?Y25lM0hsRFZMMzUrZ1ZoUVZuQy9vZUNJVVRNR0pLd0lRMDZrTlcydWozc3pi?=
 =?utf-8?B?cjcyczJPeWdNZWFtUE9HNmp3WVVYdG5pQzd5TDVJNkdkcmxmcWRLTHVQYW12?=
 =?utf-8?B?bWVhM0dhUnZHanhPZk1YQ0lhSEc0bjBkVWRTZkFOYjMwbkFQM1AwQnYwREE4?=
 =?utf-8?B?SkdTUEdyOERTWVQ3TUpzazloVFZVU2RsN3FlTkJBckNjZ0RCR3Q5cUtMektC?=
 =?utf-8?Q?1QhA/kj+HdzAP+sV8zMSOy4As?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 08bd7fbb-f6d2-446c-4d6f-08dd7b2070ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 06:49:01.9813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z0kRk1OIVekhsKrn+dAb4asLsemtQUlOc7PtOGiLfht93dkeWOyTBZ9nTvF076wUYZVGevLIbVIV2zErC/NgCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10279

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWRyaWFuIEh1bnRlciA8
YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgQXByaWwgMTEsIDIwMjUg
Nzo0NyBQTQ0KPiBUbzogTHVrZSBXYW5nIDx6aW5pdS53YW5nXzFAbnhwLmNvbT47IEFybmQgQmVy
Z21hbm4NCj4gPGFybmRAa2VybmVsLm9yZz47IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNv
bT47IFVsZiBIYW5zc29uDQo+IDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPjsgU2hhd24gR3VvIDxz
aGF3bmd1b0BrZXJuZWwub3JnPjsgU2FzY2hhDQo+IEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4
LmRlPg0KPiBDYzogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT47IFBlbmd1dHJvbml4IEtl
cm5lbCBUZWFtDQo+IDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBGYWJpbyBFc3RldmFtIDxmZXN0
ZXZhbUBnbWFpbC5jb20+OyBKb3N1YQ0KPiBNYXllciA8am9zdWFAc29saWQtcnVuLmNvbT47IGlt
eEBsaXN0cy5saW51eC5kZXY7IGxpbnV4LQ0KPiBtbWNAdmdlci5rZXJuZWwub3JnOyBkbC1TMzIg
PFMzMkBueHAuY29tPjsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW0VYVF0gW1BBVENI
XSBbdjJdIG1tYzogZXNkaGMtaW14OiBjb252ZXJ0IHRvIG1vZGVybiBQTV9PUFMNCj4gDQo+IENh
dXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBj
bGlja2luZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCBy
ZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQNCj4gdGhpcyBlbWFpbCcgYnV0dG9u
DQo+IA0KPiANCj4gT24gMTEvMDQvMjUgMTQ6MDIsIEx1a2UgV2FuZyB3cm90ZToNCj4gPiBUZXN0
ZWQtYnk6IEx1a2UgV2FuZyA8emluaXUud2FuZ18xQG54cC5jb20+DQo+IA0KPiBEaWQgeW91IHRl
c3Qgd2l0aCAiIyBDT05GSUdfUE0gaXMgbm90IHNldCI/IEJlY2F1c2UgRldJVw0KPiBpdCBkb2Vz
IG5vdCB3b3JrIGZvciBtZSBvbiB4ODYgd2l0aCBDT05GSUdfQ09NUElMRV9URVNUPXkNCg0KSGkg
QWRyaWFuDQoNClNvcnJ5LCBJIGRpZG4ndCB0ZXN0IHdpdGggIiMgQ09ORklHX1BNIGlzIG5vdCBz
ZXQiLiBJIGRpZCB0aGUgZnVuY3Rpb25hbCB0ZXN0IGFuZCBpdCB3b3JrIGZpbmUuDQpJZiAjIENP
TkZJR19QTSBpcyBub3Qgc2V0LCB0aGVyZSBpbmRlZWQgYmUgcHJvYmxlbXMgd2l0aCBjb21waWxh
dGlvbi4NCg0KUmVnYXJkDQpMdWtlDQo=
