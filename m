Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013040.outbound.protection.outlook.com [52.101.67.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A59346BF;
	Mon,  8 Jul 2024 02:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720405591; cv=fail; b=FWvhiM8JSnILV+R2bIrT5nuODJKMJvMF5ZJxegC2BiofTTqrf4ogjllKpAxiSsVaUBpTf9+xV37oP6Lr9rvOJ7J9J3lQr2Sl/FXjVeOHcXNwrL5xTYUlt1EkkZN6FoBgjfR/hNICpQPY+S28PbL2Hnni+nQqi10F0iUPEOwIVrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720405591; c=relaxed/simple;
	bh=+48lWDFV1o1bpC7DMKPU7zLx+t9eGt/OfRusVk8ziW4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fH327GTRLUZi4jKNMsQTDieqqLiXguC3UCJiTt3YGd5uefGc0pOW86WAW0AMVHlWjTtwegAGERjsJmfRjnAuJEAz4UGRAaNlnPfxT92e3I0/GbtXkI3+lEjG875hSGPDCPNQDtFrTnkJanFC1zJgg78HgN/Qtq9+8XGVq2X9HgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=s1gKaDYx; arc=fail smtp.client-ip=52.101.67.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s1gKaDYx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKgXGBl1YuoKdk5XI2sBuBUftTmEnMBTos1vFa3AjmIVzfxNIiGpMV7TrRQ5M3CRZuvjql1WbTzIazmaJXoxb+Itqzjma764sD+r3B5NFxvUIwRR92vPJ4e3mTktk7QuPFwH+Ise/8eGAQDbxOnml0LX/4hXh9PP7E6btarYjqbHp8BEg+U1lMTOzK9uAH5kVQPQ5rJL4S2ccRNmvG/nM93dZEROkH4toO0yiMFKv0q3iQ22A3ZtR8lOYeeFXhUgVVW/calZT8/I5F9+jlClvYtPRRNyGa145dWd4YVHZ/hvmQO+3D5awQsOW8Ljea7kcadda4XPDllx0pWXUClYAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+48lWDFV1o1bpC7DMKPU7zLx+t9eGt/OfRusVk8ziW4=;
 b=oC9RlFe/1ZPrqzzB+LMjIAkzMCQ14hkWtkdkXbIs7lCItrUlZInDKLWvG4fg+JwEQMj6E8SIVtHLltoVNivKlIkBnj6l0oE5gvQa59UTxGHF6ei3lUoDqpuzgAUr7ifolI7ORBAKEu+grinKsfSupAadOiiQbrbqIr668kG2331Is42bo0ZEIDJBlzvrxyfmpc1h7At6qFCoy7MPVckUyZfrCCNsHq2q7hLCodufp4NJ8H64C0Ew0x5g5c+fRl2iKrcdRoxFaPYIwYVjXFOVnvW3sCHVISNVFlnA8Wfq607Tdk39A1oXMeuIAS09P1NdeXl4x9R3r6gpaN6xa1YBPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+48lWDFV1o1bpC7DMKPU7zLx+t9eGt/OfRusVk8ziW4=;
 b=s1gKaDYxf+UpBbIjQZg1NGPwfWsGhDiLJ8DXs/2XAFA7nUtyUcmMPC69BEuaAg6nWNmuJhSw1blHBIdo85PT95WKdGXcbGIGXYmIYOn9fVw76oSPCyv6iiwhe52JikdEOaCMS6y2T80X/LYa5VJaRvzQi65FGhI/pq7+HVi3vBU=
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AM9PR04MB8132.eurprd04.prod.outlook.com (2603:10a6:20b:3eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 02:26:26 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 02:26:26 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: "Ciprian Marian Costea (OSS)" <ciprianmarian.costea@oss.nxp.com>, Adrian
 Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, dl-S32 <S32@nxp.com>
Subject: RE: [PATCH 1/4] mmc: sdhci-esdhc-imx: disable card detect wake for
 S32G based platforms
Thread-Topic: [PATCH 1/4] mmc: sdhci-esdhc-imx: disable card detect wake for
 S32G based platforms
Thread-Index: AQHazuHd7/mDp106lUOSJxlcHUVFAbHsHeGg
Date: Mon, 8 Jul 2024 02:26:26 +0000
Message-ID:
 <DU0PR04MB9496A41A7573FD1E3027C1B090DA2@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20240705134647.3524969-1-ciprianmarian.costea@oss.nxp.com>
 <20240705134647.3524969-2-ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20240705134647.3524969-2-ciprianmarian.costea@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|AM9PR04MB8132:EE_
x-ms-office365-filtering-correlation-id: 1b0be72b-739d-4089-64a8-08dc9ef55e09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z0djVXlLdis2TEpGOG5FRkk1Ym4xdk51VHFzQlRKUU56Y2doMlNxMUI2bXJC?=
 =?utf-8?B?dGVPM2FHRWwreWRSVXA4N3N6YkZOTVlRMVlmclpnSy81VTYzejg1TmM1cytW?=
 =?utf-8?B?UUF4QmE2YXlRU0FVTWg3QVVxTklLR2ZLdGovK0FXWUFpMWxIcjlhUGVTQm5V?=
 =?utf-8?B?QmQ3YjNodXNhSy8wVU9xbTVQdHFkb2w1ZzRLdGVZbCtmRU5PMmliWkgyQTZx?=
 =?utf-8?B?SE1aa0ZmdnJNdm91LzM3TE13YVplSVZCSDZETTQxTFR3K3RJdURmMDNYMlEr?=
 =?utf-8?B?anBtLzU2L0IxM2U2OHMxZnAzZGdGdko0cVlUTExsb3JjREF3ZldZWjBGT1ZH?=
 =?utf-8?B?SUtQZ1drbU1XMEc1VEIvaHkxRnUvaUZUS2lucTRYaTJVMDBGcEp0b2lXSTJK?=
 =?utf-8?B?bEQrWlVXcXlNSEFYN0xLT3dQWkVOMjVpZStwTkVqU2FOa2lzRkhDdEN2MG5p?=
 =?utf-8?B?R20vRW81YlR5NWY0R1h6MlBIWmVZVjYrTmRuaXdjTUF0SmlweVY3NjhxbXZ1?=
 =?utf-8?B?NWpiaVlxMzQ1ekNrSTdnUVk3VzU3N2hSUVRCSitGRHRFQmdXemV0LzgyUkZG?=
 =?utf-8?B?RHFaTkRBVXJGQXorWFdQNWNWVUNmV1dwbFZPeGcvZG9ZcUdXNG1uUW9oMGw0?=
 =?utf-8?B?NUx6d0h3OTl0NUhWQ0dFYzY5d2duQm12NVMxZDJEOHpHdnE5ZVk3L1l1WGVv?=
 =?utf-8?B?WTlPdG9FcVFvcTRNOXM1SUVZald5MmxaWDVndzNSenN6WW9pa1A3TFhoeHhL?=
 =?utf-8?B?QlZPNUZWY2VhMVBQaTdhSmRLS3E1aTJZSnE1RisydmNHR1FVT2I2NXFtV1dx?=
 =?utf-8?B?dmlIS09HejBTM1FwTWhIOU1WWnpzejFIL0tBRU1QcFlscityTTVhbkNUdWd6?=
 =?utf-8?B?WWxOQlJDNDhEMit4SnZPZTFBb1hHTzhWMWM1aUhRd0hZaytrMlRmNnJQelJv?=
 =?utf-8?B?SVdWZUpNTlVobVZ3VE05Z0t6VWZnREdEZG9ja05NdVZKWDNoNEFhSFZGUTdw?=
 =?utf-8?B?empIZVJuOHNMZkRWUFkwM0RLbnpWNVRUL2lIQUxkc2wvL0pqUG04NVphMVdz?=
 =?utf-8?B?Qzl1TXNSdGVldFJneE53bzNBK3RIUy9sREcwS0kweW9KYjVEY1pGa2pzZ080?=
 =?utf-8?B?eGR2djFlejJCdjIvR1lHQ0hrWkM5V2sxU0psbXVpOTlPZ056c0xkdE9qTnpv?=
 =?utf-8?B?dkNtcFRtNFpCdTNqaXE2ZE9PL3RHbWtsa0tDMno2eW9rS0IyemF5RjFDWURs?=
 =?utf-8?B?c1FjclA2NUhnQ2RrK2JnajZ5OWJOVkFnOWpQQ1pUVVlrZXV6b0hoWGJBYnN1?=
 =?utf-8?B?ZGZ1aSsrZnJXMGlGTSt0dmFjYTVFN1k4N2hEVE1ZaTI2QXBJWGNUa0VzWXJt?=
 =?utf-8?B?Qms1ejU0ejNFejJaTkFtTFlhZnBYaGpZcW85ZmVXQXlaY2hSU296a2Nmb2Fi?=
 =?utf-8?B?R2FocjlrSXQ4ajFKZjBqUVIvbUdVcU9INE9uOWtjeFdtRWRvZzZLakhiMWxo?=
 =?utf-8?B?Ui9aWnE1cE5jcVdseGpORkQxV3F6c2oyWExUZVVSbGhyS1hYc3NWNHorZHow?=
 =?utf-8?B?eFRHQURCWW5RR05oQWZiYk52ZTFDMXYvZXp2REpCYnMreERqTkppVDlSVXBF?=
 =?utf-8?B?ZWpqTVFHUFBzZjZGNlhrVnFKZGYwODl1Q0VOZUVvbjRLbzlTYWlyVENTZHkx?=
 =?utf-8?B?cWhVVmovRU9PNUNBVjVvSS93Z3VOdk4wLzR3L29LRkh6eDJNL2VGMkFzU0JG?=
 =?utf-8?B?aExZaU03VXRkQWYyWjFOY1VrUXY5MHZHU3RuazBieGFRbmV4YjJDK3BkSTEx?=
 =?utf-8?B?N2c3QnhCeExHZ3B2WVBKaWJ1dktScDY2UjFiT05oSy8vQ1QwZU9IM0JDK2pO?=
 =?utf-8?B?NzAvS3I0QlRnUjFlY3FWaGJsNll4cW9RU1RUeFpFbkUwV1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RUdVWnFTSno1L1IxSm01WXhFbnJKVzJYSGlGVWJVTjZZRnUxd0RjeUhCVjhU?=
 =?utf-8?B?U0s2cHBXYUY2MC9RL2orWFRVMDRDQUJaMlo0ZG9oK0pqMU1UZjBjVTVVR0dI?=
 =?utf-8?B?d2FhK08zRmdObFVxKzdnSjIvcnIvMzZtYzZTa3lhb0pFNXRVbWViKzhFVnVp?=
 =?utf-8?B?cG1HZjZRbFRPSWNBbllkQTE5a0Vsdi9mUGZXalBGRkxDZDF5cFlWTjZ5YWM3?=
 =?utf-8?B?dlZVdTREZ1I0cVE4TzFlMkNFdEJkcEFZblBtamtBR2NJa0RXZW91Ymp3MG5D?=
 =?utf-8?B?ZlhLYVNsQkJabUdTZ2xlQ1FpcHFDb0dFTTZ3OG1wbFZrQ0VhbkxCVTNFc1lh?=
 =?utf-8?B?bExjdVFjbzV2ZEh5WUoyUUdEZFUzcHVvOGJWVmtMcFJNNW0wWmNZWFV2cDJC?=
 =?utf-8?B?bmNPMEsxWnNRTmI3TVI4M1VmQmNyWnM0N0VUQ0JmSFFxUW5jcmxDQUxZcmp1?=
 =?utf-8?B?RVllVVN4SFNjQmhBUlg3eFZOMVMwYzQvTTFLOVpUSW53M05IUVBtcFRqYko5?=
 =?utf-8?B?ZEVlSGRVUlQyWUdQSkl5TkN4VmhlVUVENDB6T1Q0S2JTTENvN0FXLzRvRXRD?=
 =?utf-8?B?ak9FWlRaRVA0OVkzdlhieEdLZkd0VUErTVV0VHY3YUtlOUVsWEFqdlRvTis0?=
 =?utf-8?B?UGxlOEx3UnFKeHMwNmNONTRpcjhTbnVKV0xRVlRFMVMwWkpVU2YxRXZXMUx5?=
 =?utf-8?B?YzFWdjdyek90MWlPYksxbDJUTlArN2hyZlViTWlrQjdYbFJzc08wblhUS2F4?=
 =?utf-8?B?VW9zU1NFT0w5WmVtUFQ4cmJWM1VETkFOcHZReEtPSERpSHRzcmxBdmk2VVpP?=
 =?utf-8?B?dmlSUFdJVjF5SThMOWtpbUpkcVU4UUh2bmlCYy93T1BwTG52VDFQZzQ4czV5?=
 =?utf-8?B?YWJuV3R2bmgwdGdUOFlKRVM4WXNmUkNVd0dIUTRLMjdDRUo5TGZKRDNuUmRY?=
 =?utf-8?B?U3JMOElaeDFzYWhDSmNjaVFpeFhKUmV5SGZMWnFkZ3hoUkxoTmUwYmpHdDRr?=
 =?utf-8?B?dGs3UmhBYnlvMjVySjdlVlhpQXpZSzNsWVVsRkdTb2J1VFhyNy9YWEl0Tktr?=
 =?utf-8?B?VXg2RFhXOUZnRWFoUUhXdHd0RWFyY1hzNVM1UmVkTURXK01Jd3JmM0dDQjEy?=
 =?utf-8?B?ZkExY3ZNRldJWk4wemF3K2dDRDNFVXdRbGxJWXpTV0xWOVkzeWpPMTBRMlNq?=
 =?utf-8?B?RE5MY2RXVkZmM3pXcXA5RE0zdjJNZVhtYytOenVEZDQ4b3JWNlIzYXZnbFM2?=
 =?utf-8?B?R0F4S0tqak5CdS94ODl0dlNHbVN2SGhrcy90Z0xCSWVGVzhoak9kN2UzL0JV?=
 =?utf-8?B?N2RyTi9sSlp6MWlneDArbTEvZEJjTitjNU9SR2FrVXRDQXZrc3BvUENXQ1Iz?=
 =?utf-8?B?MUlPenBpaUlCUEh2RmN5VTN5TUR0dzBuWERjSVFXU2VLTmhGd2JGZXBzV01O?=
 =?utf-8?B?bkRhTVJpQW8wVnpCNjZwNDVuYlRlOXBYSklFR3lVT1R4S2duU2lNcmVDOE1x?=
 =?utf-8?B?ZldzR3lvTGlZZlN6R212bE1ETzZJS0NMTUtiWXlJa1dvM1lUeVZwTDQzZkVQ?=
 =?utf-8?B?b3ZXZFh5VVJ6Qk5iUllkZ2dvNUV1Vkw3YjhwRk5Sd241NnIzMFJwTzNFajV1?=
 =?utf-8?B?RERhU1hPNHRCVmVsUCtFZEdwR3kvWXNTSXVNZmYvemtqVm9LaEdDbUE5TUln?=
 =?utf-8?B?U3crSVNaMXBZL1ovMnRqUm8yRFI5VWdzMTZ1d0FFVlpFYm54c2ljeXlDZDQ2?=
 =?utf-8?B?RGoyeTNnMlloQkN2MVI2czREOFRHck5qOFFudlQvbFd1bU1YbmRMR2k0L0VS?=
 =?utf-8?B?VExZMDZpNlVyczdGNWgvd2kvanNXR2tzbThaTjZiY3U5STlkN2ppend4ZTVq?=
 =?utf-8?B?ZWx1c1hsYkRKSXpTN0J6Zm0rejNQb1RUWmlCSnRjUEltOFFDazFKVFY1bUM2?=
 =?utf-8?B?MFgwRGpZeXU5RE5kYXdMMmdCS2djSnFDU3g3WXVpbmdwdnBFT3JUQSt3c3V5?=
 =?utf-8?B?RFd3T2NDQ21tY0tWT253VlJ4bkkza09MWTcyU1NMZDRUTm5aSUh5c1NJR3pn?=
 =?utf-8?B?MDdMWUpiMkQyWllyVGN5RFNtNDZaSW05VDkxc05wWmVuMUpRUFRDQktiQkNt?=
 =?utf-8?Q?IKtc=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0be72b-739d-4089-64a8-08dc9ef55e09
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 02:26:26.1140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6XVywzLz6b1LeKaddlT+S/Djx7Ie+Q/qaKdzNQi6NhyafEdbr4T1udfXbe9buLZTUpghCX3NRcxldq14dvpl7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8132

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaXByaWFuIE1hcmlhbiBDb3N0
ZWEgKE9TUykgPGNpcHJpYW5tYXJpYW4uY29zdGVhQG9zcy5ueHAuY29tPg0KPiBTZW50OiAyMDI0
5bm0N+aciDXml6UgMjE6NDcNCj4gVG86IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT47
IEFkcmlhbiBIdW50ZXINCj4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgVWxmIEhhbnNzb24g
PHVsZi5oYW5zc29uQGxpbmFyby5vcmc+OyBTaGF3biBHdW8NCj4gPHNoYXduZ3VvQGtlcm5lbC5v
cmc+OyBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+Ow0KPiBQZW5ndXRyb25p
eCBLZXJuZWwgVGVhbSA8a2VybmVsQHBlbmd1dHJvbml4LmRlPjsgRmFiaW8gRXN0ZXZhbQ0KPiA8
ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
bGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsNCj4gaW14QGxpc3RzLmxpbnV4LmRldjsgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkbC1TMzINCj4gPFMzMkBueHAuY29tPjsg
Q2lwcmlhbiBNYXJpYW4gQ29zdGVhIChPU1MpDQo+IDxjaXByaWFubWFyaWFuLmNvc3RlYUBvc3Mu
bnhwLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDEvNF0gbW1jOiBzZGhjaS1lc2RoYy1pbXg6IGRp
c2FibGUgY2FyZCBkZXRlY3Qgd2FrZSBmb3IgUzMyRw0KPiBiYXNlZCBwbGF0Zm9ybXMNCj4gDQo+
IEluIGNhc2Ugb2YgUzMyRyBiYXNlZCBwbGF0Zm9ybXMsIEdQSU8gQ0QgdXNlZCBmb3IgY2FyZCBk
ZXRlY3Qgd2FrZSBtZWNoYW5pc20NCj4gaXMgbm90IGF2YWlsYWJsZS4NCj4gDQo+IEZvciB0aGlz
IHNjZW5hcmlvIHRoZSBuZXdseSBpbnRyb2R1Y2VkIGZsYWcgJ0VTREhDX0ZMQUdfU0tJUF9DRF9X
QUtFJyBpcw0KPiB1c2VkLg0KDQpGcm9tIG15IHNpZGUsDQpSZXZpZXdlZC1ieTogSGFpYm8gQ2hl
biA8aGFpYm8uY2hlbkBueHAuY29tPg0KDQpCdXQgYmV0dGVyIHRvIHdhaXQgdGhlIGNvbW1lbnRz
IGZyb20gQWRyaWFuIGFuZCBVbGYuDQoNCkJlc3QgUmVnYXJkcw0KSGFpYm8gQ2hlbg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQ2lwcmlhbiBDb3N0ZWEgPGNpcHJpYW5tYXJpYW4uY29zdGVhQG9zcy5u
eHAuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMgfCA4
ICsrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14
LmMNCj4gYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+IGluZGV4IDQwYTZl
MmY4MTQ1YS4uMjFkOTg0YTc3YmU4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3Nk
aGNpLWVzZGhjLWlteC5jDQo+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14
LmMNCj4gQEAgLTIwMSw2ICsyMDEsOSBAQA0KPiAgLyogRVJSMDA0NTM2IGlzIG5vdCBhcHBsaWNh
YmxlIGZvciB0aGUgSVAgICovDQo+ICAjZGVmaW5lIEVTREhDX0ZMQUdfU0tJUF9FUlIwMDQ1MzYJ
QklUKDE3KQ0KPiANCj4gKy8qIFRoZSBJUCBkb2VzIG5vdCBoYXZlIEdQSU8gQ0Qgd2FrZSBjYXBh
YmlsaXRpZXMgKi8NCj4gKyNkZWZpbmUgRVNESENfRkxBR19TS0lQX0NEX1dBS0UJCUJJVCgxOCkN
Cj4gKw0KPiAgZW51bSB3cF90eXBlcyB7DQo+ICAJRVNESENfV1BfTk9ORSwJCS8qIG5vIFdQLCBu
ZWl0aGVyIGNvbnRyb2xsZXIgbm9yIGdwaW8gKi8NCj4gIAlFU0RIQ19XUF9DT05UUk9MTEVSLAkv
KiBtbWMgY29udHJvbGxlciBpbnRlcm5hbCBXUCAqLw0KPiBAQCAtMjk4LDcgKzMwMSw3IEBAIHN0
YXRpYyBzdHJ1Y3QgZXNkaGNfc29jX2RhdGEgdXNkaGNfczMyZzJfZGF0YSA9IHsNCj4gIAkuZmxh
Z3MgPSBFU0RIQ19GTEFHX1VTREhDIHwgRVNESENfRkxBR19NQU5fVFVOSU5HDQo+ICAJCQl8IEVT
REhDX0ZMQUdfSEFWRV9DQVAxIHwgRVNESENfRkxBR19IUzIwMA0KPiAgCQkJfCBFU0RIQ19GTEFH
X0hTNDAwIHwgRVNESENfRkxBR19IUzQwMF9FUw0KPiAtCQkJfCBFU0RIQ19GTEFHX1NLSVBfRVJS
MDA0NTM2LA0KPiArCQkJfCBFU0RIQ19GTEFHX1NLSVBfRVJSMDA0NTM2IHwNCj4gRVNESENfRkxB
R19TS0lQX0NEX1dBS0UsDQo+ICB9Ow0KPiANCj4gIHN0YXRpYyBzdHJ1Y3QgZXNkaGNfc29jX2Rh
dGEgdXNkaGNfaW14N3VscF9kYXRhID0geyBAQCAtMTcyNiw3ICsxNzI5LDgNCj4gQEAgc3RhdGlj
IGludCBzZGhjaV9lc2RoY19pbXhfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
Cj4gIAkJaG9zdC0+bW1jLT5jYXBzIHw9IE1NQ19DQVBfMV84Vl9ERFIgfCBNTUNfQ0FQXzNfM1Zf
RERSOw0KPiANCj4gIAkJLyogR1BJTyBDRCBjYW4gYmUgc2V0IGFzIGEgd2FrZXVwIHNvdXJjZSAq
Lw0KPiAtCQlob3N0LT5tbWMtPmNhcHMgfD0gTU1DX0NBUF9DRF9XQUtFOw0KPiArCQlpZiAoIShp
bXhfZGF0YS0+c29jZGF0YS0+ZmxhZ3MgJiBFU0RIQ19GTEFHX1NLSVBfQ0RfV0FLRSkpDQo+ICsJ
CQlob3N0LT5tbWMtPmNhcHMgfD0gTU1DX0NBUF9DRF9XQUtFOw0KPiANCj4gIAkJaWYgKCEoaW14
X2RhdGEtPnNvY2RhdGEtPmZsYWdzICYgRVNESENfRkxBR19IUzIwMCkpDQo+ICAJCQlob3N0LT5x
dWlya3MyIHw9IFNESENJX1FVSVJLMl9CUk9LRU5fSFMyMDA7DQo+IC0tDQo+IDIuNDUuMg0KDQo=
