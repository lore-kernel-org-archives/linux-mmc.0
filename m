Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2054.outbound.protection.outlook.com [40.107.249.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEE418EAB;
	Thu, 22 May 2025 03:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747883779; cv=fail; b=GFNNBwW2LaIuk4ckP7ugWNYruIawqRBUDLzo93pcHubLZ5J34uKjqFOMqRM0QLxUcOG2CXqD/AXTnjGRQ3QCGGeU5KEZ0kwHpUXZkol6pjwtb+4HZmVIPl0/ng+/6LFZr04iH4uiRf+OwYaQCsCkq2b6aJK9JvERVzeu2sUaiJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747883779; c=relaxed/simple;
	bh=X7I4t19FQz8PfXQIdft24AQAfnB/GXDUWj4vOZYHKrE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OtKGAAFAiLjg1WUmY+qRXIDQyvgYdZ+D97VNC995ewv+IF5ROEASjuAjeGvYfkARkMYUIAnsAqJHwosYpIqo9axikZfer7Qp1wH6k6mPs/AxqDW9cdlG8e3yKbahxLWArAR9IvGqN3FOYw5iW/2kOiNL6jMKM+nyriz4tR4j/vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PgvRIm0X; arc=fail smtp.client-ip=40.107.249.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PgvRIm0X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzS1mrMIEZytt4sHc2cz/wLNsbrGoYYipG95HBwvN3q9AhYUyCi6cMI4Bsz/CBSSvjXUpDBOalrimsZlb2oah9NmznOUP/i9O+NwpY2txsh8aa844rxd3uBH3ML4Yn6bO80xRyn22dyFDD2BcQfZo/C5Rx9iF0OQO3XnnWRveOPMemTfTxdaKyp+WbsN2h6SES4kl6fTrFkfFMYBGFJF0e8pemlqr4OAnib0XssNGvrWFUSCy2zxTGOTDci+44EhduDHqqWrgHXg6Oo18lQ4kyeB64YCIhasbqSVXLQYxC2wrScN2Fr8VO+1l4y7MJ/iX3nXxztThB4X+s4vt6oXUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7I4t19FQz8PfXQIdft24AQAfnB/GXDUWj4vOZYHKrE=;
 b=QTTn/a9yTXQOajLznYjNNUgrf4JYLlA0FFieRJjF7ygl7PdcHK4cHTnYuWzlVWBkoZYjh35rxdp30H63bmrTem08OZjwG0tRCQP7sq4x0qyw2GivH0ir+Lqkxuo1OEz/YMBP3i0UXMmI8L29rbONg2NIQKmnCdcrhJYkw7lhWG7xYGSc9jEvubRVbbXIYOrG56kWosDRMUx+abhOSRmfDGpz4ppQ3iFnmWHSkdD80ZU/Pr5/rL+Z6DDwSak0AttMmOryFHDBNBNFEswvIugOg6AYfES2D4gcsQ3WO+tpULe6FhxmZprGV8XE1KMiqU/Q0bGcO+V9uuFHZbuKlUesAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7I4t19FQz8PfXQIdft24AQAfnB/GXDUWj4vOZYHKrE=;
 b=PgvRIm0XWUcFE05w/qHKzH/ngv0/t439GqPUtrxn2GiMm3br3WGHyAhKquOq2vtSbEgG8oNVLEgClCIdwCM1YRHcpgri8Gbwtn4PzIWbT2XDczVAkH568bLEremYMcAIPMdYiJdHJVk7keb9TtUbZTumkyD5TWMgXEBVLbw5d0QAApqJZgXr5IpqndwyVCPenzjaAGpFPFqMxEoNAC5/JhOYRsbYBdTj1pLzdXkuOIaX9VJUda7uYhHn+pP+ErA1nNTt3yaDIr3/ag4teiwjCZPSF3GlihQrBt5VLeKbP2mr0zmP7NUTBHg5c61K1t0uFtJNn8/skQ8nytUMSHFBvg==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by VI1PR04MB7168.eurprd04.prod.outlook.com (2603:10a6:800:129::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 03:16:11 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.8722.031; Thu, 22 May 2025
 03:16:11 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Frank Li <frank.li@nxp.com>, Luke Wang <ziniu.wang_1@nxp.com>
CC: "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, dl-S32 <S32@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: sdhci-esdhc-imx: do not change pinctrl state in
 suspend if function irq is wakeup source
Thread-Topic: [PATCH] mmc: sdhci-esdhc-imx: do not change pinctrl state in
 suspend if function irq is wakeup source
Thread-Index: AQHbygCrODuPKxSNKESLE+EO5yGJEbPdPc6AgAC6N2A=
Date: Thu, 22 May 2025 03:16:11 +0000
Message-ID:
 <DU0PR04MB949685245DB01F28E15C24D29099A@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20250521033134.112671-1-ziniu.wang_1@nxp.com>
 <aC33qfRFEvNbwSRn@lizhi-Precision-Tower-5810>
In-Reply-To: <aC33qfRFEvNbwSRn@lizhi-Precision-Tower-5810>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|VI1PR04MB7168:EE_
x-ms-office365-filtering-correlation-id: 7c5d9c6f-1ce3-41be-3da2-08dd98df00e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?gb2312?B?TFlkVmpQakNkVlVVR2NCQStXSHhRYnNNYmxuWXRFNzV1MlR4V3BRV2IvaXR1?=
 =?gb2312?B?ZmMxSmMwUFlqMEZZbDRoSExRbjlQdXRoOEd0T2dmQUg5cjN4bUxhbi9kM1hX?=
 =?gb2312?B?SjBWRTBQeU1uQWE1bm9lNkVrbnJ3MXo2NXZRdWdGOU50QVFhOGQrSWgzUFdJ?=
 =?gb2312?B?ajJuZlZvamtuYUFzUWpYcEhyM3FpTFd3UGtHa2hrbFFQQVBNUXhnaWYzeDNn?=
 =?gb2312?B?NzlKWVlIa1hRNEtOTlVsWkdScWJ4TTRWOVVad3F4bHlZREhLZ05pWVg2QmNj?=
 =?gb2312?B?UXRXNUlUMWM0VENrZ3BjZlpQQzlZYkFOV091aG84R2NsYllxNGxZaFlFRGJC?=
 =?gb2312?B?VUVPYXRNSDF1dXpiNytnLzhnRTBBSjdkVFdxdTU5Vml5WFN2bFJ5Qjk5OTJi?=
 =?gb2312?B?VEpVVXJuM0VUbXN4Y3UyYSt6NU0yOEcyN1dkNDBtMnhSYmVLRTUvYWpQNVNC?=
 =?gb2312?B?OGJITDBKcGFobDZoeVlDdFA2d3F6QXNWNWpZZ3RMd2w1NDIrNHNsQ3dUWUhM?=
 =?gb2312?B?a3ZOclRYQlZTaVR2Ym9ORG9MMzI3NFFlMTRVa1Z5TzR3R1JwVTRtdWFqaFc1?=
 =?gb2312?B?SXIwVEM4NDM2UE9PNklPL2lBcyszWE9DcDEvYXROSEFYbG5UMzNic1ZQUmI5?=
 =?gb2312?B?K2FMdTVNaWtKeEFKRlVjWUk4NXBQY1g2R2YvQmR3OTdnazJsVXViSHN6OTN6?=
 =?gb2312?B?U2VmOHYvQVBPMlNvcU1UQWhOV1hxemptTzhnQmNYTVp5eVZFNlJKNGwyVTFz?=
 =?gb2312?B?bmQwZ2lrVDNzSy94N0RVYllhanU0RUxzUkltc2VHdjluUWlES1cydHZrNlJS?=
 =?gb2312?B?Qmk3OWl1T2ZRbGlja2FoOXBKUFgyQjBtaDRhWHBrek9IRVdpZzUzNE9rQktw?=
 =?gb2312?B?K2FsNlRkSitiMEV3SjdabFpEMnBlc3hLYVJXZndWU2xubW1lUzRWZkFzQkZR?=
 =?gb2312?B?RnlBTVVvbXV1enJYMzRHYTA3UG10Ri9mM0sxRHZLQkJzSDMxR3p0ZmxTS0hB?=
 =?gb2312?B?aUtJNzJMdTJGL0I2V3BQSHdKWnovMDdBWFJ0bENwMTZXbGgzL0d2bGdrQ2Ji?=
 =?gb2312?B?ejkyclhmbTF4Y0Z1VlpadmFlL09FdHRpWFZkOHlEVW03TkZVa1M4VWptSkdZ?=
 =?gb2312?B?aDlocFJrWEFneFVsZThXb3hSemxuODZOb0tVS1dQUXdoL1BPT295TUxnUGpV?=
 =?gb2312?B?S0V3VHptb3hwS0RHUVdQUXF5UjRLbzRKVTBEWTBKK05KakJYOFNqbFdHWWgv?=
 =?gb2312?B?YUFSZjN2bXI5aGZyeWdkK3A1ZHRYRVdDcEFPR2Nvc09GUE1TcVJNN3dsMHlL?=
 =?gb2312?B?MFF4T0g3KzUrWGZ0Z1ZWZlRET0hHeStYSEYyZG1kbWIwY003eWROODUrR2xn?=
 =?gb2312?B?SkJGSVJUWlliVEw4WGY0OGxlZngybG4zZ2xqWFRDdDJuTTNNaDd0RWtFSXdv?=
 =?gb2312?B?YmRTNldsd1k0SVB6SHZkbVdlemFCaUQ5aU52TzR2UTFoMG9FS3dTOFYrS2dL?=
 =?gb2312?B?bHV5TkREcHVRdjUwdzZlYVROY1ZlUFdHbkFUTnFOQjJmVDB1cGxlNmM2My9I?=
 =?gb2312?B?Nm12OG5rOTNhVEt6ZVlBQnU2OGxLRDgxNXNXdGJtYWVwNFJyZWJlc0dKVzlI?=
 =?gb2312?B?VUZ6c0J1Y1UybXVVTGt2VGRLUXp5eDZYRTE3bEVRQ1hqaG9vQ0pTN1BCdWg1?=
 =?gb2312?B?eGwvU0k2eGpIY1BjNDJCK1Y5RXFLaTVqNDExemQ4VmxTTVdTamhvK3ZJelpZ?=
 =?gb2312?B?b1JWY2t5VzA4d28xVlhxWU1EOTMyUVdrZVVVdDdZbmcrV3JTUUR1OGczZEVy?=
 =?gb2312?B?SFFCbDFxbVUxZ0ErL3NhTmdoblZlWFpFendXa2tLMTFTNEl1VVhpLzlPMVRN?=
 =?gb2312?B?V1pXaFEvOXFWVEhsNmFwd01aQzU3cEl5YTJabkg5TWowVzlYS3lkcUsxL0h0?=
 =?gb2312?B?bFYrUTB5YVgwczFlSlJnQUJJektpZlpYeE9SUzFETlNvQ215TjA5eWtFdjgr?=
 =?gb2312?B?U1JDV3NZM1FRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?blRpbzZCODU1MVRCSHZQbGdSQSs5R0RLT2FscW9NdmMweTJCVVJNQTIxUGkr?=
 =?gb2312?B?MysxRU9aZUJCNEZUVk1zTkpwUG5rV2hIQmVzTSt2cndYakJ2UlhCWTQzYzNr?=
 =?gb2312?B?bnVBT25yNElFOHJIVnhwTFpKdUhHYUNzTTQ0NWhHVlRteVpZeGtaMWZjcnFP?=
 =?gb2312?B?b3A0NFVMeHZWeGZEeVptbWRkN2RUaU5mc1ZQMmJTckwyYVU0QmQwVGwrWWxs?=
 =?gb2312?B?NWYrME93UStYTGNualFtbXdxYVpHS2I4WHFRRDZwdU5WclRhYnJybGRyTmpo?=
 =?gb2312?B?akw2UzFTR20ySmZsY01odThIMkJFV2xMWXNqVU1nWjljOTJOTDA5SkRwZTlq?=
 =?gb2312?B?KzlWV2xaYStncmZ3T1REVlMyTXpseUdIQS9zSlF2TEdXbzJ0MFZ1VlRTSVM1?=
 =?gb2312?B?OVpkSERLaTFJQUpsbnNOdHlnT2N3VUU5QjFhSW44NGo5U0RQdFpzd2JwRVoz?=
 =?gb2312?B?bEtuL0Q1ZjVucUl1UTB3WHJmOEV3cHIrMXFFOFh5VWtTSnV1dnZUdWxHWmJN?=
 =?gb2312?B?ajFja1JISXgvdDc2VjNuN2dZNldtd2dzZ1JhZllRM2NMbzlBRkdHMmhZUkJV?=
 =?gb2312?B?bTRpRys0Q0hnK1RmNGovT2V5ck9uVUlCcVowYnBnajFtVllidndCY3BMTTB5?=
 =?gb2312?B?cjhhdWdXS21DejkxZ0ZtL2Q0NGFtejN6SHhyNE1nWm9rVU5YcG0xREFQWjN1?=
 =?gb2312?B?VmUxTk5CTVc3b3F2TjlpSGlkWE1TZis1bFBnWDRLNHZBWG1FUXo3ZUt4cEhG?=
 =?gb2312?B?UVg3WGNpM05VVjRnaEtyWU9MMG1IdXRFTzQxa3RaamVUUVc1Q1c2ZGFhajJ1?=
 =?gb2312?B?YUZQQWh5ZUJpOHpvbmdiMkFuZnhRdHpaemlvVGpaVU9BMXNGdmlqNXh4cFNO?=
 =?gb2312?B?azM1U1l5Q0xMQTVZQXpJNWFIUGc4SmYzVVhjWXRMWnJpNGQ4TDVIOTZIWkFH?=
 =?gb2312?B?SjZvSTMwU0JNbjRLc0JHYmdHOWNjSnJwMXdtMDVZYWRsajU2cVJKZE81eFFP?=
 =?gb2312?B?M05Da1R3WGVaMWFkQ3NTMFNUQXlVN3YwVWZLOW5qVENqaVZKQnVtWWNlZWJn?=
 =?gb2312?B?dmhhSDFWK21DdHJ5VkNNS2dHazJ4USthUmpEbmNDVVg1V0ZLYURCdXdkR01L?=
 =?gb2312?B?cHNWM1I4NzlYTkkvQ0Y3TWpobFNvRmtTb1BqMkFmK3Vzb2NKR2tYVDJoVG04?=
 =?gb2312?B?UHliOHBmNnpGN1BWZGdsWHExaTRySXlTVElYbGhacFVhUzcxbHNRdFV5bEM0?=
 =?gb2312?B?bTQ0VUViSXhUd0JkMCt2b0labzJnSkZZV2tWU0MwVG1rc0hMd0w1bFI3ZHQz?=
 =?gb2312?B?UnprU3F2OFVxQVRNVVhSaFFEMWd1L2xJeGJJbzhPcm9JQi9MTUFsVDdVWXBp?=
 =?gb2312?B?Nys3emlFRHkrUVZYdGR0SmZhVWZOdHI0N0EzQ2h2VDZnYU9UeEFIVncvNnpU?=
 =?gb2312?B?WjRyUnRDN1M0VldmL3U0cGVTdkhGbjZ1eWZ0VGFVMEpwZVN3ZjYyRXdlbmd6?=
 =?gb2312?B?NDRaR0VYOVJMcDBEeVAvMUVWN1AxWGN6WEtmaDg2eHNQQjBYY0M3enh2QktG?=
 =?gb2312?B?MGo4UWU5ckMyKy9lU0cxSUtEajhVaXJOa1R6MDFiQlBlcE12QUJTZThCRmlC?=
 =?gb2312?B?cVdMSTJUMVZjWGd6RTlITURCeXFyNSs1aDg3V2xlVFYwV1VMN0RlTUlFdEd1?=
 =?gb2312?B?aXdCbkdNdkg5QlFrU1pGdmppRnFWRk9SWUNSQXZTRWhzY0I5eTB5OUZpVUtJ?=
 =?gb2312?B?SlVuczBxbDRzdDVkR1hORFpaN0U2VDd5alhqeW04OFZSRWtsemtNZEVVRW55?=
 =?gb2312?B?ODQ5VTVXTTYxNkhJd1lkVThKYlRRT3VaL1pMM3cxejRWcjVhaG92ZlFFNTdS?=
 =?gb2312?B?bGx6MnloV0NBanc4Z1BBUUFWdWNHUmdSVmtWTUFsVjJPSUpTTThvWm1Bakda?=
 =?gb2312?B?dTEyNER0VlBCcjdnd2FzZ1pIS1hUSGlmUXpNZHQxU3lLRldWckpOcHM3T0VS?=
 =?gb2312?B?T0xnZUxNaXFrZnNwUGs2b3R6citlUEFFSTlzNXRDcWdpYkNnYTFQUXRkZ1BL?=
 =?gb2312?B?a3kyRWhDdk9YMTNodTloZDBpTDA2cnFQQ2RmYWVKcXVuVU9pSSs1U2dkSUlp?=
 =?gb2312?Q?deTM=3D?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5d9c6f-1ce3-41be-3da2-08dd98df00e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 03:16:11.6833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2fxC89ycikbsI/jMnuwlE/up5VEN72Rv+FWKfinZEBsFSnZHe8+7Ax/kJyf+uMzAnGMwjCSgUC+WOeEBa+Nlww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7168

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNcTqNdTCMjHI1SAyMzo1Ng0KPiBUbzogTHVrZSBXYW5nIDx6
aW5pdS53YW5nXzFAbnhwLmNvbT4NCj4gQ2M6IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNv
bT47IGFkcmlhbi5odW50ZXJAaW50ZWwuY29tOw0KPiB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOyBs
aW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhhdWVy
QHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNv
bTsNCj4gaW14QGxpc3RzLmxpbnV4LmRldjsgZGwtUzMyIDxTMzJAbnhwLmNvbT47DQo+IGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBtbWM6IHNkaGNpLWVzZGhjLWlteDogZG8gbm90
IGNoYW5nZSBwaW5jdHJsIHN0YXRlIGluDQo+IHN1c3BlbmQgaWYgZnVuY3Rpb24gaXJxIGlzIHdh
a2V1cCBzb3VyY2UNCj4gDQo+IE9uIFdlZCwgTWF5IDIxLCAyMDI1IGF0IDExOjMxOjM0QU0gKzA4
MDAsIHppbml1LndhbmdfMUBueHAuY29tIHdyb3RlOg0KPiA+IEZyb206IEhhaWJvIENoZW4gPGhh
aWJvLmNoZW5AbnhwLmNvbT4NCj4gPg0KPiA+IHBpbmN0cmwgc2xlZXAgc3RhdGUgbWF5IGNvbmZp
ZyB0aGUgcGluIG11eCB0byBjZXJ0YWluIGZ1bmN0aW9uIHRvIHNhdmUNCj4gPiBwb3dlciBpbiBz
eXN0ZW0gUE0uIEJ1dCBpZiB1c2RoYyBpcyBzZXR0aW5nIGFzIHdha2V1cCBzb3VyY2UsIGxpa2Ug
dGhlDQo+ID4gY2FyZCBpbnRlcnJ1cHQoU0RJTykgb3IgY2FyZCBpbnNlcnQgaW50ZXJydXB0LCBp
dCBkZXBlbmRzIG9uIHRoZQ0KPiA+IHJlbGF0ZWQgcGluIG11eCBjb25maWd1cmVkIHRvIHVzZGhj
IGZ1bmN0aW9uIHBhZC4NCj4gPiBlLmcuIFRvIHN1cHBvcnQgY2FyZCBpbnRlcnJ1cHQoU0RJTyBp
bnRlcnJ1cHQpLCBpdCBuZWVkIHRoZSBwaW4gaXMNCj4gPiBjb25maWcgYXMgdXNkaGMgREFUQVsx
XSBmdW5jdGlvbiBwaW4uDQo+IA0KPiBJIHRoaW5rIGl0IHNob3VsZCBiZSBkdHMgc2V0dGluZ3Mg
d3JvbmcuIERvZXMgb25lIFBBRCBzZXQgYXMgZnVuY3Rpb24gaW1wYWN0DQo+IHBvd2VyIG11Y2g/
DQoNCkhpIEZyYW5rLA0KDQpJIGRvdWJsZSBjaGVjayB0aGUgcG93ZXIgdGVhbSwgb24gaW14OTMt
MTF4MTEtZXZrIGJvYXJkLCBGb3IgU0QgY2FyZCBvbiB1c2RoYzIsIHN3aXRjaCB0aGUgUEFEIHRv
IGdwaW8gZnVuY3Rpb24gd2lsbCBzYXZlIGFib3V0IDN+NG13LA0KRm9yIFNESU8gd2lmaSBvbiB1
c2RoYzMsIHN3aXRjaCB0aGUgUEFEIHRvIGdwaW8gZnVuY3Rpb24gd2lsbCBzYXZlIGFib3V0IDAu
OH4xbXcuICh3aXRob3V0IHdha2V1cCkNCg0KUmVnYXJkcw0KSGFpYm8gQ2hlbg0KPiANCj4gRnJh
bmsNCj4gDQo+ID4NCj4gPiBGaW5kIHRoZSBpc3N1ZSBvbiBpbXg5My0xMXgxMS1ldmsgYm9hcmQs
IFNESU8gV2lGaSBpbiBiYW5kIGludGVycnVwdA0KPiA+IGNhbid0IHdha2V1cCBzeXN0ZW0gYmVj
YXVzZSB0aGUgcGluY3RybCBzbGVlcCBzdGF0ZSBjb25maWcgdGhlIERBVEFbMV0NCj4gPiBwaW4g
YXMgR1BJTyBmdW5jdGlvbi4NCj4gPg0KPiA+IEZvciB0aGlzIGNhc2UsIGRvIG5vdCBjaGFuZ2Ug
dGhlIHBpbmN0cmwgc3RhdGUgaW4gc3VzcGVuZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhh
aWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBMdWtlIFdh
bmcgPHppbml1LndhbmdfMUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9ob3N0
L3NkaGNpLWVzZGhjLWlteC5jIHwgMTYgKysrKysrKysrKysrLS0tLQ0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+ID4gYi9kcml2ZXJzL21t
Yy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+ID4gaW5kZXggNWYxYzQ1YjJiZDVkLi5mMjA2YjU2
MmE2ZTMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXgu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gPiBAQCAt
MjA1NywxMiArMjA1NywyMCBAQCBzdGF0aWMgaW50IHNkaGNpX2VzZGhjX3N1c3BlbmQoc3RydWN0
IGRldmljZQ0KPiAqZGV2KQ0KPiA+ICAJCXJldCA9IHNkaGNpX2VuYWJsZV9pcnFfd2FrZXVwcyho
b3N0KTsNCj4gPiAgCQlpZiAoIXJldCkNCj4gPiAgCQkJZGV2X3dhcm4oZGV2LCAiRmFpbGVkIHRv
IGVuYWJsZSBpcnEgd2FrZXVwXG4iKTsNCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJLyoNCj4gPiAr
CQkgKiBGb3IgdGhlIGRldmljZSB3aGljaCB3b3JrcyBhcyB3YWtldXAgc291cmNlLCBubyBuZWVk
DQo+ID4gKwkJICogdG8gY2hhbmdlIHRoZSBwaW5jdHJsIHRvIHNsZWVwIHN0YXRlLg0KPiA+ICsJ
CSAqIGUuZy4gRm9yIFNESU8gZGV2aWNlLCB0aGUgaW50ZXJydXB0IHNoYXJlIHdpdGggZGF0YSBw
aW4sDQo+ID4gKwkJICogYnV0IHRoZSBwaW5jdHJsIHNsZWVwIHN0YXRlIG1heSBjb25maWcgdGhl
IGRhdGEgcGluIHRvDQo+ID4gKwkJICogb3RoZXIgZnVuY3Rpb24gbGlrZSBHUElPIGZ1bmN0aW9u
IHRvIHNhdmUgcG93ZXIgaW4gUE0sDQo+ID4gKwkJICogd2hpY2ggZmluYWxseSBibG9jayB0aGUg
U0RJTyB3YWtldXAgZnVuY3Rpb24uDQo+ID4gKwkJICovDQo+ID4gKwkJcmV0ID0gcGluY3RybF9w
bV9zZWxlY3Rfc2xlZXBfc3RhdGUoZGV2KTsNCj4gPiArCQlpZiAocmV0KQ0KPiA+ICsJCQlyZXR1
cm4gcmV0Ow0KPiA+ICAJfQ0KPiA+DQo+ID4gLQlyZXQgPSBwaW5jdHJsX3BtX3NlbGVjdF9zbGVl
cF9zdGF0ZShkZXYpOw0KPiA+IC0JaWYgKHJldCkNCj4gPiAtCQlyZXR1cm4gcmV0Ow0KPiA+IC0N
Cj4gPiAgCXJldCA9IG1tY19ncGlvX3NldF9jZF93YWtlKGhvc3QtPm1tYywgdHJ1ZSk7DQo+ID4N
Cj4gPiAgCS8qDQo+ID4gLS0NCj4gPiAyLjM0LjENCj4gPg0K
