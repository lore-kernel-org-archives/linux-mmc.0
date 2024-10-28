Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2103.outbound.protection.outlook.com [40.107.249.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF8E1CDA17;
	Mon, 28 Oct 2024 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112359; cv=fail; b=FicY6Ay4IzYrTn8blTAjQG4noFCMx0fOFRpPeEMPZk+akFGPjEJHXJRyS5qBTpmBI7wy3s98rhL+v7Z9CvOsTxq+lferWQfAMF5dO5DbZQ82G8Otu/rfSBWVnIC8tNIp0f0o0hDvqArV4DqEjcWR2Yg32JF0bpN21hBYU8ho5nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112359; c=relaxed/simple;
	bh=MbCTOsqx0DQJFJDHkVAWd8QgV5AWEBcy1DUkXzEEI24=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZMQZOD9NRxBqtE2FO5AyXHBIS9l/XxStQEj0b2jydDriKONvVcgMeouREEaMaVxuxmbCDTfjd9TZ1d9Xh+mWctCCvKuhdPStoqvm4KkVSNmoSjBaxhZTybuW8aRoQtBrVmcTOezxOp8xQMEjgcoRVc8zVV8jHxBZlQvjBA9WLoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=ebShD7EK; arc=fail smtp.client-ip=40.107.249.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="ebShD7EK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfq2Pb+tZDADueKA2hyflBusSU50eyUEv4ED1YRGY2gr7ahhScfBqw6tV321fzpXAUEcWA7Wcsi4LikpTAIe25G4ljzGbHjRBNy4bPgTVkq6GnKdhbw1CdzuX0HZedJCkwzVwkymTDhY1Q+1JSXLP6Xm8Sp9oSTJw4dqV56qj86cybahlZBc1OrPetvr4O3TPJUU69a+AAS63yrje4T88d9e+VGy8vS47F6Z9gTIAGmWIKKCwJ2uVPBot/BeAWlfOWBC/i3K/OXItpqyO0giu3TSHdvwQ53p7I/5AxOey9nkVYWNguImRn4DgzdSnibFgzLQLrgKPxEVBKuartaUbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbCTOsqx0DQJFJDHkVAWd8QgV5AWEBcy1DUkXzEEI24=;
 b=CypdwJlopVWca180PkhQki0lDRNoGC65Baja1jOEKnH48NYsxry0vLZcz7m4xYjVz/aykDrXuZhETYuoJ3Ny1h1z0jnVkBOpCRjwr8anaNPLfXMLJh4pr1BzUTHXAV59iyoWKe57DAVUl25tcBUhtOcQtg7L+eEhv2eVviKp/UgmZ5TLzkSpO1tyDZJTln8K1qNJTY21fDR7cdR/F01jJ0mkSJfdmeNFH5f4X3yyT7nsVF7M3j01Nnnpey3Dsakw1TXL3OgkdeMwwJdU3pEp86EciAv9KhwUe4FDRVWQb7/x2SabpGDf9Ja0/oGY8Kd7sR5puQ9ZrUwGwiGLlznvwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbCTOsqx0DQJFJDHkVAWd8QgV5AWEBcy1DUkXzEEI24=;
 b=ebShD7EKMp42HZ3UsAK8T8P6D+yj8Fp2dWuDFSoz56SzZEyyFtP3wjv4zYapY9Y4LGTCwqjqK39w1GmCKbrR8oF1cwX4r3JSIklxQtq2L3PhkYgvUAKsY5bDMcdDOLD0hfRftgns4tAgK+CICCg+H4h6QqHFsN4xry2u+nQK4qg=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB7925.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 10:45:52 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 10:45:52 +0000
From: Josua Mayer <josua@solid-run.com>
To: Bough Chen <haibo.chen@nxp.com>, Peng Fan <peng.fan@nxp.com>, Adrian
 Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
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
Thread-Index: AQHbKH5HOJuwCzLfNkCusXVof1dxZbKba/0AgAASVgCAAH3MgA==
Date: Mon, 28 Oct 2024 10:45:52 +0000
Message-ID: <913d8706-ec58-4197-889a-0d2d94c67ccc@solid-run.com>
References: <20241027-imx-emmc-reset-v1-1-d5d0c672864a@solid-run.com>
 <PAXPR04MB84591664B7A4455E6F0BD19E884A2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <DU0PR04MB9496769805197714F198EC0F904A2@DU0PR04MB9496.eurprd04.prod.outlook.com>
In-Reply-To:
 <DU0PR04MB9496769805197714F198EC0F904A2@DU0PR04MB9496.eurprd04.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|AS8PR04MB7925:EE_
x-ms-office365-filtering-correlation-id: a37d4509-46db-49ea-fc20-08dcf73db196
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cFpOZ3VWa2RHcy9HWTNRQk9hRVkyNlhLNEsvTmUwYVJzQ044YklyY1I2U3Nu?=
 =?utf-8?B?aVNiL01OMXJDc3VFWEF5aWN4STJzWXg0R29kUmpyV1BiUWJXcmVtczE5MDl6?=
 =?utf-8?B?UXd0NDJlU21Sejd2ZWpQU1RoUWtmMHNIMGdZcnlhZkl0NW9ycUpJZ3IySksw?=
 =?utf-8?B?OWJZYWU0UzJqdTlzL0thR3ZzQ1lHUlJsM0duY1dZbUhLcmY3dFNKMTVvQUl6?=
 =?utf-8?B?a2RNMUZsS1l6WFpKQjZTWitCNWlGY244N1hNa2VyZGFWekRqOXFFWHVZMnRG?=
 =?utf-8?B?U0R6SUVIU0Z5OTBlVFRILzJHTWlycFRkYzJ0M3Y0OWVsUjdSaHkwOW9objBm?=
 =?utf-8?B?dVlqUDFsVzcyYjF6K2U4K3Q3N0ZHcWViN3pzNkJLT01IUlVRZ0VsbmhzQ0RM?=
 =?utf-8?B?UDlYQjdCZGp0dmJQUTRlVTZWL3FNQUJUd0xxT3pmNTcwKzdsQjJkUHZSUTgx?=
 =?utf-8?B?Qi9tVGhhMFJFZTF1QThQV3R4YjE5bXdKTTRVcFlCczAyc2NtSHhvdmp3aHk1?=
 =?utf-8?B?TmFNZDRrdW91ekVzY09XdXdnL1NRUWRqUW12Z3BqOS96bkMwZHJMZVVuL3Fy?=
 =?utf-8?B?WmVmaTNjaTFEWTZUbUNwb1dZcGtIK1BnZVgwNDk2cVNWdTc3QVBwMmhrcjFQ?=
 =?utf-8?B?RG9KL0tnaTlCUGw5dHhISy9nK0JRTHI5QVhxUEpXWmlVZ29KV0RzcFN1b2pX?=
 =?utf-8?B?UmU1MkJCVzRkYzI4VkVUL1FQL09lcUdzc0QxNEhIZnRRb0RWZXpQK1MzekN4?=
 =?utf-8?B?ZUswNE5zaUxuLzd5UGJFVXFlMmdtazJKcjJlRVEycjdqMUEwOHVxVys0VXQ3?=
 =?utf-8?B?UGRkdlN4WHp5RHNCbzVkMkk4aWlkTWh1Syt2TUpqaGFkMnFnMlhvaWVTc0xh?=
 =?utf-8?B?N0NlUDBNOHNxaVkrcGlMSlRoeW5ZVUpaalNCSnRPNUo2amZrL2l1WFdKS0w1?=
 =?utf-8?B?TEh2Zlk5UWtnKytxU2pKRWdhZU9rQWpVQTdvbTZ1RGorR2M1dWRZenI2U1ow?=
 =?utf-8?B?UFlYSml4Ry9pTElsOGRaUGI5dkFVVXlONXB1NTVWeURYTSsvSlBiRjdHY0FH?=
 =?utf-8?B?TWJ0VDNiWFJvYlVFODh2UTRuVnRVUVVFUjFRNUxWSDlJdHYyeENzS3pEb0NO?=
 =?utf-8?B?VWZpLzdZcG9RQjdUQ0tBbHNnQUdNWlJrWktFb2RMQ0svZkp2cDEvWmYveXRL?=
 =?utf-8?B?L244OUNYNk1MQlo3N2hjbGQ1RWZVeW1jcHBKcXdPWExyaGovWExGRXhYK2Nh?=
 =?utf-8?B?SWdZeGVGMGY1MHBUMTBQKzhJY2o5eXozNzQwTWVjUlhqck9Uc0NlY3o4M0VZ?=
 =?utf-8?B?K2w3bmc5aS83UCsxVG5jWDBlck9wdVhtUHhiRm16YWlJWjJZSXBlbExjYlYv?=
 =?utf-8?B?UHlqOXpkbk9UV0tySmtVMSs1dFFnUDl6TjEwVFJ4Kyt6czBQSm5tUVFXWlBx?=
 =?utf-8?B?VXJSaEs4NGtqbHVZVnhlR3RxT2lWelA1RFFzZ1JETUpodlJmUVFFN1ordFZZ?=
 =?utf-8?B?a0hKekdWbzd3RW1OQXJRZW5xVkF0UlBUOGFEY3ZkUWtCQ0lYb2tiemxNNEJR?=
 =?utf-8?B?UTNncUhHS1pzeWV6NHAvMThyNjZRM1NpbWppb0VGQVFJMS9aNGNtUTBuRnZF?=
 =?utf-8?B?QXJtcHkrdzhsK2VvMGxXTTJaWmxVdk93K1NxdFFQVk92a3hPclBocWlTbDlO?=
 =?utf-8?B?VGduL2lKNTc5Z3NDOHlydXZmcGNYRjNrcGdKOXdlRTJNdk5KVVJYMDFleFQy?=
 =?utf-8?B?YjUwQUNJcmJqSFJKcnN6MTQ2djF3VXZ2d0dZTXlORHcwWTNBUnlMdi9rbnlm?=
 =?utf-8?Q?2PUHmnJf1KYlbSxnreH27XDtp91Ig15NW86Os=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXNmWSsxenZnYVIvKzFYVXByL1VzcHpYTURteEhISnJIeFNXNmxQc2FvdVpU?=
 =?utf-8?B?WVVGTXh3b2RNTnRJZ1dhZGxrUzdoT0dMYW9RczhzelpXQW1hM0ZJYzhZK2Ja?=
 =?utf-8?B?QTRYb3NrV1NkNzVabTRxbkROWVdBWUpTQ0VLNzM5NnlJNEhydXo4YXZVTWM3?=
 =?utf-8?B?dE5nUlB3bjNRRDBMbVA3T3NXSFZNdEE1WlR0dEFJSEpTVU9xR1dpN09MRFBX?=
 =?utf-8?B?d0g2VXBvUEJmS215UDRPRnpaSE9mNXdNaXU2ckR0SjBST1NYb1BvMFdpcDl6?=
 =?utf-8?B?TnNScVFza3dVcjMyVHBWdFJyRGJaOW1EWFpPaS9URDRGZmtxVksvM05OZDJN?=
 =?utf-8?B?eFFqaDEwNmhEU001Vk04QTBzYlJXbWZrOU94cjJxTEJ0T0ZYS3ZFQWRNcmlK?=
 =?utf-8?B?ak9mTVVRMWhkMVdUUkN6SEt3QmM5TktQaTlpT3BTWDh6NzYzTTRLS0FiOEMy?=
 =?utf-8?B?K0hHKzYrZFd6cXJhNy9kdElYajlSaXhvSHVCd2RhSVJzZUlFK0drcGZBSVVu?=
 =?utf-8?B?ekVIaUJTTmk3Zm8zcGZkQlY3RlBFVld4V1orODU5eW9KL3EyVmZNaGNTS0h4?=
 =?utf-8?B?WHFaemd2YkFJTStKeE1wQnFLa1pIWEtIRUxOL1ZCbkpYVlBPT2s1Q285UUpH?=
 =?utf-8?B?L2dGUHJ3MUpJYWsrYm5FQjB0dTZtQmFqOXFZanBwMUJFU1FDZHpSTHlFa2M1?=
 =?utf-8?B?TkM2cWZQOE9LbVZVYzFUVVEyd1FtbmV2dUZKcHZuSGpJbVJGTmtJckFVWlYy?=
 =?utf-8?B?UmszdWFmaFo3V2dSOHBOcHNmZDU5M2hLZXZvRWFzQXIra2hHYUVqSG5VUDFv?=
 =?utf-8?B?Q2Z1cDRqNXRmQXUrZnppdUE1bXFQRjFBUCs1R0RNOVZXakJ0aVp2WHBSK0hq?=
 =?utf-8?B?UnFLNk45d0VCWVB0WWdNeGhrR2o4UGJGVmNTa2ZpM0dUUE14enIyZVhRSEJp?=
 =?utf-8?B?ZUJPcnZ4MklpZzFhUGxMMTZkNGhPaUhMQmluUUZrM081MnJ6SUNzbnhHaFda?=
 =?utf-8?B?L212NmJWcytmWGdGbEd5MTlTeVVmQ1VoWGhiYU9NamlKTGhGRFdXckdhRVo4?=
 =?utf-8?B?TnIvbVJJMkxnY1Z5NFhtdG1ndnZhZnRmb1oxSGcvMEdLOTEzWHNKYXpsRXBW?=
 =?utf-8?B?cDI0eFZKeGxhUkNWN2twSGkrbjJOU0wxcktYT2Vua3ppaW81WTRtYXpuTjND?=
 =?utf-8?B?ZTJ4T1Q3aUV3aGhnVUN2dUpKd2FKTytlWTlUM29pSktmYUc5VHYvNk4zbzVW?=
 =?utf-8?B?UytOZytYMlFld1NkNCtWdGZvUVpuMG9IN0U3dnJ4MjhMR1N0TUhqOWhmSGx0?=
 =?utf-8?B?Z2JKUE14UWxNTDhQVlRNbUw0NnNNVGFnN2JkdHIxY0tRL3BoN0JxVjRmQWR1?=
 =?utf-8?B?NC84TUZpZVh4R1AxSHdoVmU1RHRHTm1YUHRQcEVWS2VGYmxSMm1Qakh6YndO?=
 =?utf-8?B?UThrNmRvTVlubHpiSzQ1U1RZdWJFRFgyeDFRbU9pNDFTbDAveUlncktiL08w?=
 =?utf-8?B?VGJNcmtkSWVkVTVTRDRudkVzYWpKY2VsZ3F5UTJpK0hvZm8yNlZpUEhiZ2ly?=
 =?utf-8?B?ZlJIRmJKMGV3bXdUTmpIcG1IWkR6NVBNeEV5N3JYQjhCeC9kVm5QWFpBL1pN?=
 =?utf-8?B?S0d6R3p3Ymw2QzJwWkg3d1dSY3kxL0lZYVNzQXhWRE1kdFlMcDdTWEMvS21z?=
 =?utf-8?B?MldEZFJHOE5VMTMzdDFoL1hsYkpjZ3hPaVgxWVNQbndLcTlWOG9jSUJGVy9u?=
 =?utf-8?B?NWVNZHpaek02Q3hCN1NUNjVhRkkwc1VtY3dnMFdNbFZ1ZmNkSnY4SUxPd0J6?=
 =?utf-8?B?U0Yzbll6Q1Fqa0h6M09kT1VycDk2ejQvZGFnYkkvcnd6Y0NuZDl1ckV2TDhX?=
 =?utf-8?B?SXppS0dHVFFsZ1NTNVJiU0JnUmM5elhHc0JQYkpsa1NoL05EMzFBNFlhTVlL?=
 =?utf-8?B?WExDWFBJRUxZdWJGU01mS25HdTBwM3lpeU91OFVtLzNVUEJNU0tmZS81M0ht?=
 =?utf-8?B?ZXU3K1hMMGRpL2w3UW1SWE5LYmFzbEV5T3V3SEdRdlBkR2t6QzdLTzlPTXlR?=
 =?utf-8?B?Z055MFdVVVNQMUR4K0VoZFFYZXdiQ3piTC83NTRpRmM4RHlHZ05Zb2dkLzZu?=
 =?utf-8?Q?17tw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <669CAD45DAAD5C4B8CD7F31BE7E8E267@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a37d4509-46db-49ea-fc20-08dcf73db196
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 10:45:52.4228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0gh6iwY4R2lC8TC17FisV34TDoVxSX97crB3RnVI4MhK3HLh3EaGWkvysTJJGp2/dxk9l8hEJ5B0/5Cq4te+cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7925

QW0gMjguMTAuMjQgdW0gMDQ6MTUgc2NocmllYiBCb3VnaCBDaGVuOg0KPj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPj4g
U2VudDogMjAyNOW5tDEw5pyIMjjml6UgMTA6MTANCj4+IFRvOiBKb3N1YSBNYXllciA8am9zdWFA
c29saWQtcnVuLmNvbT47IEFkcmlhbiBIdW50ZXINCj4+IDxhZHJpYW4uaHVudGVyQGludGVsLmNv
bT47IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT47IFVsZiBIYW5zc29uDQo+PiA8dWxm
LmhhbnNzb25AbGluYXJvLm9yZz47IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz47IFNh
c2NoYSBIYXVlcg0KPj4gPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+OyBQZW5ndXRyb25peCBLZXJu
ZWwgVGVhbQ0KPj4gPGtlcm5lbEBwZW5ndXRyb25peC5kZT47IEZhYmlvIEVzdGV2YW0gPGZlc3Rl
dmFtQGdtYWlsLmNvbT4NCj4+IENjOiB5YXphbi5zaGhhZHkgPHlhemFuLnNoaGFkeUBzb2xpZC1y
dW4uY29tPjsgUmFiZWVoIEtob3VyeQ0KPj4gPHJhYmVlaEBzb2xpZC1ydW4uY29tPjsgaW14QGxp
c3RzLmxpbnV4LmRldjsgbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsNCj4+IGRsLVMzMiA8UzMy
QG54cC5jb20+OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+PiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+PiBTdWJqZWN0OiBSRTogW1BBVENIXSBtbWM6IGhv
c3Q6IHNkaGNpLWVzZGhjLWlteDogaW1wbGVtZW50IGVtbWMgaGFyZHdhcmUNCj4+IHJlc2V0DQo+
Pg0KPj4+IFN1YmplY3Q6IFtQQVRDSF0gbW1jOiBob3N0OiBzZGhjaS1lc2RoYy1pbXg6IGltcGxl
bWVudCBlbW1jIGhhcmR3YXJlDQo+Pj4gcmVzZXQNCj4+Pg0KPj4+IE5YUCBFU0RIQyBzdXBwb3J0
cyBjb250cm9sIG9mIG5hdGl2ZSBlbW1jIHJlc2V0IHNpZ25hbCB3aGVuIHBpbm11eCBpcw0KPj4+
IHNldCBhY2NvcmRpbmdseSwgdXNpbmcgdVNESEN4X1NZU19DVFJMIHJlZ2lzdGVyIElQUF9SU1Rf
TiBiaXQuDQo+Pj4gRG9jdW1lbnRhdGlvbiBpcyBhdmFpbGFibGUgaW4gTlhQIGkuTVg2USBSZWZl
cmVuY2UgTWFudWFsLg0KPj4gQnV0IHRoaXMgcmVsaWVzIG9uIHRoZSBQQUQgYmVlbiBjb25maWd1
cmVkIGFzIFJFU0VULCBzaG91bGQgdGhpcyBmbG93IGJlaW5nDQo+PiBkZWZhdWx0IGVuYWJsZWQg
d2hldGhlciB0aGUgUEFEIGlzIGNvbmZpZ3VyZWQgYXMgUkVTRVQgb3Igbm90Pw0KPiBObywgZnJv
bSBteSB1bmRlcnN0YW5kaW5nLCBldmVuIHRoZSBQQUQgaXMgY29uZmlndXJlZCBhcyBSRVNFVCwg
c3RpbGwgbmVlZCBTVyB0byBjb25maWcgSVBQX1JTVF9OIHRvIGNvbnRyb2wgdGhlIG91dHB1dCBv
ZiB0aGlzIHBhZC4NCj4gSm9zdWEsIHlvdSBjYW4gZG91YmxlIGNvbmZpcm0gdGhpcyBvbiB5b3Vy
IGJvYXJkLg0KQ29ycmVjdCwgb25seSB3aGVuIGEgcGFkIGlzIGNvbmZpZ3VyZWQgZm9yIGVtbWMg
cmVzZXQgZnVuY3Rpb24NCmRvZXMgdGhlIHJlc2V0IHNpZ25hbCBhZmZlY3QgYW55IGJvYXJkIGNp
cmN1aXQuDQoNCldlIHRlc3RlZCB0aGlzIHdoZW4gd2UgaGFkIHdyb25nIHBpbm11eCBhbmQgcmVz
ZXQgZGlkIG5vdCB0b2dnbGUuDQoNCj4gQnkgdGhlIHdheSwgSSBjaGVjayB0aGUgY29kZSwgd2hl
biB5b3UgZG8gdGhlIHRlc3QgdG8gc3VwcG9ydCB0aGlzIHJlc2V0IG9wZXJhdGlvbiBvbiBlTU1D
LCBkaWQgeW91IGFkZCAgImNhcC1tbWMtaHctcmVzZXQiIGluIGR0cz8NCg0KQ29ycmVjdDoNCg0K
PiBGcm9tIGN1cnJlbnQgY29kZSBsb2dpYywgdGhlIGNhbGxiYWNrIHlvdSBhZGQgaGVyZSBzZWVt
cyBvbmx5IGNhbiBiZSBjYWxsZWQgYnkgZU1NQyBkZXZpY2UsIHNvIHdpbGwgYmUgc2FmZSBmb3Ig
c2QgYW5kIHNkaW8gZGV2aWNlLiBBbmQgaWYgeW91ciBhbnN3ZXIgZm9yIG15IHF1ZXN0aW9uIGlz
ICJ5ZXMiLCB0aGVuIHlvdXIgY2hhbmdlIHdpbGwgYWxzbyBiZSBzYWZlIGZvciBlTU1DIGRldmlj
ZSB3aGljaCBkbyBub3QgdXNlIHRoaXMgcmVzZXQgZnVuY3Rpb24gYmVmb3JlLg0KSSBiZWxpZXZl
IHNvLiBPbmx5IHdoZW4gZHRzIGRlY2xhcmVzIHRoZSBjYXBhYmlsaXR5IHdpbGwgc2RoY2lfaHdf
cmVzZXQNCg0KZ2V0IGNhbGxlZCwgYW5kIHRoZW4gaXQgd2lsbCBjYWxsIGVzZGhjLWlteCBkcml2
ZXIgaHdfcmVzZXQuDQoNClNlZSBhbHNvIGRyaXZlcnMvbW1jL2NvcmUuYzogX21tY19od19yZXNl
dA0KDQo+DQo+DQo+Pj4gSW1wbGVtZW50IHRoZSBod19yZXNldCBmdW5jdGlvbiBpbiBzZGhjaV9v
cHMgYXNzZXJ0aW5nIHJlc2V0IGZvciBhdA0KPj4+IGxlYXN0IDEwdXMgYW5kIHdhaXRpbmcgYW4g
ZXh0cmEgMzAwdXMgYWZ0ZXIgZGVhc3NlcnRpb24uDQo+Pj4gVGhlc2UgcGFydGljdWxhciBkZWxh
eXMgd2VyZSBpbnNwaXJlZCBieSBzdW54aS1tbWMgaHdfcmVzZXQgZnVuY3Rpb24uDQo+Pj4NCj4+
PiBUZXN0ZWQgb24gU29saWRSdW4gaS5NWDhEWEwgU29NIHdpdGggYSBzY29wZSwgYW5kIGNvbmZp
cm1lZCB0aGF0IGVNTUMNCj4+PiBpcyBzdGlsbCBhY2Nlc3NpYmxlIGFmdGVyIGJvb3QuIGVNTUMg
ZXh0Y3NkIGhhcyBSU1RfTl9GVU5DVElPTj0weDAxLA0KPj4+IGkuZS4NCj4+PiByZXNldCBpbnB1
dCBlbmFibGVkLCBMaW51eCB2NS4xNS4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEpvc3VhIE1h
eWVyIDxqb3N1YUBzb2xpZC1ydW4uY29tPg0KPj4+IC0tLQ0KPj4+ICBkcml2ZXJzL21tYy9ob3N0
L3NkaGNpLWVzZGhjLWlteC5jIHwgMTIgKysrKysrKysrKysrDQo+Pj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxMiBpbnNlcnRpb25zKCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9z
dC9zZGhjaS1lc2RoYy1pbXguYw0KPj4+IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1p
bXguYw0KPj4+IGluZGV4DQo+Pj4gOGYwYmM2ZGNhMmIwNDAyZmQyYTA2OTU5MDNjZjI2MWE1YjRl
MTlkYy4uZWJjZmE0MjdjY2E2Y2MyNzkxDQo+Pj4gYTE3MDFhMzUxNWVmNjUxNTc3OWFhNCAxMDA2
NDQNCj4+PiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+Pj4gKysr
IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPj4+IEBAIC0zMyw2ICszMyw4
IEBADQo+Pj4gICNkZWZpbmUgRVNESENfU1lTX0NUUkxfRFRPQ1ZfTUFTSwkweDBmDQo+Pj4gICNk
ZWZpbmUJRVNESENfQ1RSTF9EM0NECQkJMHgwOA0KPj4+ICAjZGVmaW5lIEVTREhDX0JVUlNUX0xF
Tl9FTl9JTkNSCQkoMSA8PCAyNykNCj4+PiArI2RlZmluZSBFU0RIQ19TWVNfQ1RSTAkJCTB4MmMN
Cj4+PiArI2RlZmluZSBFU0RIQ19TWVNfQ1RSTF9JUFBfUlNUX04JQklUKDIzKQ0KPj4+ICAvKiBW
RU5ET1IgU1BFQyByZWdpc3RlciAqLw0KPj4+ICAjZGVmaW5lIEVTREhDX1ZFTkRPUl9TUEVDCQkw
eGMwDQo+Pj4gICNkZWZpbmUgIEVTREhDX1ZFTkRPUl9TUEVDX1NESU9fUVVJUksJKDEgPDwgMSkN
Cj4+PiBAQCAtMTQwMiw2ICsxNDA0LDE1IEBAIHN0YXRpYyB1MzIgZXNkaGNfY3FoY2lfaXJxKHN0
cnVjdCBzZGhjaV9ob3N0DQo+Pj4gKmhvc3QsIHUzMiBpbnRtYXNrKQ0KPj4+ICAJcmV0dXJuIDA7
DQo+Pj4gIH0NCj4+Pg0KPj4+ICtzdGF0aWMgdm9pZCBlc2RoY19od19yZXNldChzdHJ1Y3Qgc2Ro
Y2lfaG9zdCAqaG9zdCkgew0KPj4+ICsJZXNkaGNfY2xyc2V0X2xlKGhvc3QsIEVTREhDX1NZU19D
VFJMX0lQUF9SU1RfTiwgMCwNCj4+PiBFU0RIQ19TWVNfQ1RSTCk7DQo+Pj4gKwl1ZGVsYXkoMTAp
Ow0KPj4+ICsJZXNkaGNfY2xyc2V0X2xlKGhvc3QsIEVTREhDX1NZU19DVFJMX0lQUF9SU1RfTiwN
Cj4+PiArCQkJRVNESENfU1lTX0NUUkxfSVBQX1JTVF9OLA0KPj4+IEVTREhDX1NZU19DVFJMKTsN
Cj4+PiArCXVkZWxheSgzMDApOw0KPj4gUGxlYXNlIGFkZCBhIGNvbW1lbnQgb24gd2h5IDEwdXMg
b3IgMzAwdXM/IFRoaXMgaXMgYm9hcmQgcmVsYXRlZCBvciBzb2MNCj4+IHJlbGF0ZWQgb3IgY2Fy
ZCByZWxhdGVkPw0KPiBBZ3JlZSwgcGxlYXNlIGFkZCBjb21tZW50IGFuZCBleHBsYWluLg0KDQpU
aGV5IHdlcmUgY29waWVkIGZyb20gZHJpdmVycy9tbWMvaG9zdC9zdW54aS1tbWMuYy4NCg0KSSB3
YXMgaG9waW5nIHNvbWVib2R5IGtub3dzIG9yIHJlY29nbmlzZXMgdGhlc2UgbWFnaWMgbnVtYmVy
cy4NClRoZXkgYXJlIGludGVuZGVkIHRvIGJlIGdlbmVyaWMgYWNyb3NzIGFsbCBlTU1DIChub3Qg
U29DKS4NCg0KDQpzaW5jZXJlbHkNCkpvc3VhIE1heWVyDQoNCj4NCj4gUmVnYXJkcw0KPiBIYWli
byBDaGVuDQo+PiBUaGFua3MsDQo+PiBQZW5nLg0KPj4NCj4+PiArfQ0KPj4+ICsNCj4+PiAgc3Rh
dGljIHN0cnVjdCBzZGhjaV9vcHMgc2RoY2lfZXNkaGNfb3BzID0gew0KPj4+ICAJLnJlYWRfbCA9
IGVzZGhjX3JlYWRsX2xlLA0KPj4+ICAJLnJlYWRfdyA9IGVzZGhjX3JlYWR3X2xlLA0KPj4+IEBA
IC0xNDIwLDYgKzE0MzEsNyBAQCBzdGF0aWMgc3RydWN0IHNkaGNpX29wcyBzZGhjaV9lc2RoY19v
cHMgPSB7DQo+Pj4gIAkucmVzZXQgPSBlc2RoY19yZXNldCwNCj4+PiAgCS5pcnEgPSBlc2RoY19j
cWhjaV9pcnEsDQo+Pj4gIAkuZHVtcF92ZW5kb3JfcmVncyA9IGVzZGhjX2R1bXBfZGVidWdfcmVn
cywNCj4+PiArCS5od19yZXNldCA9IGVzZGhjX2h3X3Jlc2V0LA0KPj4+ICB9Ow0KPj4+DQo+Pj4g
IHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2RoY2lfcGx0Zm1fZGF0YSBzZGhjaV9lc2RoY19pbXhfcGRh
dGEgPSB7DQo+Pj4NCj4+PiAtLS0NCj4+PiBiYXNlLWNvbW1pdDogOTg1MmQ4NWVjOWQ0OTJlYmVm
NTZkYzVmMjI5NDE2YzkyNTc1OGVkYw0KPj4+IGNoYW5nZS1pZDogMjAyNDEwMjctaW14LWVtbWMt
cmVzZXQtNzEyN2QzMTExNzRjDQo+Pj4NCj4+PiBCZXN0IHJlZ2FyZHMsDQo+Pj4gLS0NCj4+PiBK
b3N1YSBNYXllciA8am9zdWFAc29saWQtcnVuLmNvbT4NCj4+Pg0K
