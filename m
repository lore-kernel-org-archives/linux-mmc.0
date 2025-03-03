Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011032.outbound.protection.outlook.com [52.101.125.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD76122611;
	Mon,  3 Mar 2025 02:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740968013; cv=fail; b=SrKg0ynrplxkUWz/iX/u06EpTXvp5nuLFYBHhZqH3VMX8ESivom18mG0awo5uNmgpISHWaF09YT+MZgyLVlOlK56U2rQsQGsuoU7HkBcCY45MZ0y0TnM4w+h9auX7Rt7b4ocjcv/VLFcGFbDo+p2EXwAn6fpVMQiE7iPeuNNOz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740968013; c=relaxed/simple;
	bh=ahj/KRnuSLuauzm5IQLFH4ggxWiA9q7LChQjtUAtUFQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YFciIK2dEmLTwnBOlA05xk0iEJhaw6XFN4LxH/whkCkHh48Q3yhgiN3qT5m6k9F/AuWhr/XuSFHdK6evt8wzYjvquU/5Er9I+4mtfDts5CDjYqhelgoFs2d0XOiJrTb2DntscrrwgJ9PEBNhdysajlfamjkZCAMmc0fBp4Iegkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=dNhT/4/Q; arc=fail smtp.client-ip=52.101.125.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="dNhT/4/Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxfMkKGeBebj4bWT0Tt8HzAKUWPnZ+h+No6g4Vqy09OsbPaQlcBJ28HDWuPpfRjyd6lN+gF2fmHU1DIIWWe/UP6Holpa80JARN5V8zhbVGErjC3CxEy/wTgbxzLjG1zqHT9YLYIkG1oaa4DaQb2xPiaO62iYAZ8ebYn9YSjJAXIN0SHinIP+iDCUEYWZGsQ/qg/SeQ7kC2ldTKcxZ73TyJCX3LqnNtN8OeL778ulymaOlSE2ahq2VKulDjM79NjCrxujA/mBdGK4f3tQGOqYGZSJZnGR8oxWG3L3I00OMMmvPsIzT2wjhZS6O1Q9XfLQcncNWFnsbiaJEpc/qFQ5IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahj/KRnuSLuauzm5IQLFH4ggxWiA9q7LChQjtUAtUFQ=;
 b=n+4jZ2kbbCr9RLUtwAhs3220rMkfdCW598pZEPVGpKW7i86upJlMkoGhf0GBF9Xt2RFoYOy4iq86Dl4pNc4qQ3CjIBRtz8jziIJjIQf3saHrh6LyHnK1dW0u281+75sSkI+sk59lukPu3IE17cUIxLiuumAS6mYRnHqgCn5KHSULLM1W4KnMKF7zQjx68Vl6ibca9xwqZWyquuyzyLhCAqDvR29s4gtYiMRNnrYTDg54bcTid8Sfkeqbi4wIDViKgk7/dgOyf7ESvOzYC5BV3RHEGGa86YrHEdjhP1JHBdgj6k3NGdZLEu4SwmpBlYsS3KZKIz2EoV+xbR9f5D4bpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahj/KRnuSLuauzm5IQLFH4ggxWiA9q7LChQjtUAtUFQ=;
 b=dNhT/4/QQR4113s0Mh6T977AYZyVsvMEJ/p02u/e3/0D70XlQCx15rxOetmTqgkOAVcaxBnDN1ER+Vq2rh4RPhdAGtKaFVjA1aXdzzUo4M9fZGl8TBa/qJT+m9WiWjbYYb3pQKcbKdmnJ1vRZuxshNlzxT5Jtcvc9YFn1g6l6ow=
Received: from TYWPR01MB11877.jpnprd01.prod.outlook.com (2603:1096:400:3fb::6)
 by OS3PR01MB9269.jpnprd01.prod.outlook.com (2603:1096:604:1c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 02:13:27 +0000
Received: from TYWPR01MB11877.jpnprd01.prod.outlook.com
 ([fe80::20c4:1e10:5d7b:1bb8]) by TYWPR01MB11877.jpnprd01.prod.outlook.com
 ([fe80::20c4:1e10:5d7b:1bb8%3]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 02:13:24 +0000
From: Guan Wang <guan.wang.jy@renesas.com>
To: Avri Altman <Avri.Altman@sandisk.com>, Guan Wang <guan.wang.jy@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
CC: Avri Altman <avri.altman@wdc.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Jens
 Axboe <axboe@kernel.dk>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: block: add reset workaround for partition switch
 failures
Thread-Topic: [PATCH] mmc: block: add reset workaround for partition switch
 failures
Thread-Index: AQHbhnj+ymQtGXVrfECCNmxi9v9UvbNay6IAgAXZGoA=
Date: Mon, 3 Mar 2025 02:13:24 +0000
Message-ID:
 <TYWPR01MB118773DE1E42233671F2CF007D9C92@TYWPR01MB11877.jpnprd01.prod.outlook.com>
References: <20250224045918.3321394-1-guan.wang.jy@renesas.com>
 <PH7PR16MB6196112328A147FC59643B76E5CD2@PH7PR16MB6196.namprd16.prod.outlook.com>
In-Reply-To:
 <PH7PR16MB6196112328A147FC59643B76E5CD2@PH7PR16MB6196.namprd16.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11877:EE_|OS3PR01MB9269:EE_
x-ms-office365-filtering-correlation-id: 1d78fc31-fb3f-47f7-8049-08dd59f8fa95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?Q2FKZ2hVajU2WThoRlBydVpWQ3VGdmNubFE3eGgvOExnZlAyeTl3RllzaThm?=
 =?gb2312?B?aU1oR1FPekwrRDIwU0tzeExaSi9NajI0WU16MDNScmxrenJ2Y1VDMWRRZUpx?=
 =?gb2312?B?bDVKWmhoaXFUUmhRNERvOXFBd1VNWG54K0hDU3B1K2xWMGIxZWZlU3FyNHBl?=
 =?gb2312?B?Ri91RDVuUGlCYUVOTkhzM2N0Mm1BQUFvVktPK1VzVzE0Vml6d2JDR3Jodzl3?=
 =?gb2312?B?UlA0OGJLUzZtRzYzSENTNm9WYnJBR3htMDlqa3VSZUdyZVJqbzdtKzJaOTh3?=
 =?gb2312?B?bVNGRkF1Q0N5WTJFTDVxZjFPU1hLcjRlQ21vdGltV0lyNFAwTlpyL1I0NVl4?=
 =?gb2312?B?dFV6TE12cktjakVzNzZvSnl1VXRHQVBrcjg1V0t1dlQvWFpqWENMc1hsMFp2?=
 =?gb2312?B?V2RTMVdZYmdEa0tsZ1cxQXU5eDlFOGUwdFB2amF6N2NMNml6Zm5JZ29MRHhQ?=
 =?gb2312?B?NVpXTzB1eDl4RktsL1FhRVdMWlhBNVMyNGpsTmdocjJXcEZuNmRSSVNMZm0v?=
 =?gb2312?B?NkpzY0hwQ2hSdVQrRi9Kb1NiUDEvM1BaS1RXZWNPaGJIYktYMExQdytHU0Nj?=
 =?gb2312?B?N2RISExxSlY5ZWZaNlMrRFZyWi9QUC9lR2ZreUc5ZVF5MEdFR3VRaGtlc1FB?=
 =?gb2312?B?OS8vUWJvM0pwWlhkbHovTTN6SmVWRlp0VUxJTkFPQkErc2x1bENUVnJkNDNh?=
 =?gb2312?B?akJqdGhNT1BoNHV3azBiZWpFSm9aNWdoZXBseGNwTzhQNVBMMnJNQUNwM3d2?=
 =?gb2312?B?STJOajFzNHMyUldMNjlsYUhoYW11MkQyaDE0YUYwSVg0c0hLWU0zYlFza3hM?=
 =?gb2312?B?UXpMT091Q1QyYUYyZnQzVTI3Zkt4cExPQ1dBRXh1bDhEeUJKV0xkNkRQbVVH?=
 =?gb2312?B?U0dpS21NS2RUMWpVckdjY2JSYnVUUmNwRzg5aWlLNzdQbHRwY1psa3NwOElT?=
 =?gb2312?B?SWYySGp1ZjJVYVhsSkxQYjNPekVTVGhJcC84UXBKRmxhTW1jb0hha1hPbEZh?=
 =?gb2312?B?bVdvMlJ4QkNIUE1VbVJHWTV3Tmw3anB3RUhTZU11UzZQcWJRd21LVk9tdkFm?=
 =?gb2312?B?TmxoTkJaclJsbEVGMkVad0FFcmJWdTdTQmNuNnVlYyttNmlnVU1nRGJld3hH?=
 =?gb2312?B?VkowMzdnVnVreFgwK1pHd1lhN3oyVTI2ZmxrZVlaMXllN0NCcmEwTTFoTkJn?=
 =?gb2312?B?SmEvVG1JU3JhSzh4dnA1dG1qZ2xLNU5DWVVWSHR0anJHVzJFamRGWGdVakxz?=
 =?gb2312?B?by9EaHMwRGRTQ2dXYkl0djFDajBqQUIvUStxWG43elRMYVZPQ0J6YStjWHlz?=
 =?gb2312?B?L2VIRFdPVDdjZ2oyYmxDVUIzeFdvOHo1dkxCOFhOL2ZrMEJ5dEkraDNHU2Jz?=
 =?gb2312?B?R0NRRUQxeXVuTkhrZEIycGZHclpPeGt3cVdTVG95SGREa285V0VldU8rcVJO?=
 =?gb2312?B?dHR2SlZ3V2pPYnhTVlVHSmhYeTl1dWU3TEFpU3hpVTArdWZsRjNhQVNYTGpm?=
 =?gb2312?B?b2dZWjduNENrTi9xeit4T3l0ZDFQZDNLd2RHTGxGcFZET3dlTS80YXQ0U1oy?=
 =?gb2312?B?TCtqbVFiRUlPcSs1SHUzUm5jaFM0ZVJleHpGVldsRnJQQXNtVXBpenZWSkhw?=
 =?gb2312?B?TlJnc0xiTFJVU3BVV0dsZjVNOWZORERZNG1KSU5kbFRyNjF5WkRTS3g4ckJ6?=
 =?gb2312?B?SDVZS2ZWZDZpWDVibUpuS3VFRmovY3RyN3hqOGRUYUc2NzhZTU5BNHdXek51?=
 =?gb2312?B?Um05d2IzMXlRczgyRUNseE5YelVLUEtrNXVnTkpJN3JPajI2UWJISlM4S215?=
 =?gb2312?B?YWtYbTlkTGVXN25LQ2ZvSzNFOFRUSmU4M1lNODdGZ0wvckNvUmZIb1BNU3NI?=
 =?gb2312?B?SnZzeDB0SHlXOUxsNU5NSHBJU1Z6NWxNR0hlanFzMDdEOU4rN1BXT2h1Tk85?=
 =?gb2312?Q?YI0YF0qfUt6z3tEgElwa9qagT08pan4A?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Y1JUMGpJNWFKNE56QjRRREdGMmdpVVNQRyt1WU9XN3dvYnRWZWFyRnRLQ3BG?=
 =?gb2312?B?K0ttcFJTa09IQjVlUklTNW5taEl4NURpSjVrK2pPQ0NobUJtVE1hbUovRmdH?=
 =?gb2312?B?OEY1eFp3c1RCWE1CVzRmdUVTSFhNRmlTaHlmMWJGcXZDSlcwVEdnQ2xuOVky?=
 =?gb2312?B?emhqNWYzV1NtbDJlV0c0N1Ywb0Z4aHoxS0JCWTB3UHg1NTN6MCtVaW5veVZy?=
 =?gb2312?B?UFRjbk1iSmZuUFVsTEhzdm16ejFnck4rSlNkTW94bG1rRTRIWkVaejFMZlY3?=
 =?gb2312?B?S1Q3c0o5TUdyb3lFWXdXakVTaEtjMW1hOWlFWTlOcG83UnBoZ1hGZmduMXZC?=
 =?gb2312?B?alVLRHdTYU91QXlGZDdWSWxPTkh6T3RaNWRGclRpTGNJT1Y4UElSYkFqWnM4?=
 =?gb2312?B?MGs0UWt6RW5JUmJ3QlgzL1J0OUF2RjM4eWYyZENkbjlwa1o0akpWY2F1Y2tk?=
 =?gb2312?B?bDc0SVVRcU8yVHNEbmN1QjFodHZ1NHhId0pzUHVmTVRmN3RleTExc1duTUtx?=
 =?gb2312?B?K1hmaElNMkp3T1JLMUF6TzRxK3JwR2pidDJZV3RaaC9zTG90Y0xDTHg5ZEFl?=
 =?gb2312?B?Rm8rUzl3K0tqSlN1eFBVZlJGOWxRdFl6WCt4RWNsUlRUZW9mNlB1bDlmNGNy?=
 =?gb2312?B?QXdJYVB0dWpVd1d1Y1RmZ296bWQ4Q3BTUlRzc210aXdGVTRMVmFCWEpFRlp0?=
 =?gb2312?B?UUFWRTh3VVNUTmpqRFQvVnI1QlRhZTR6Vll5dms0MlVtM1ZST3o2VGs5RjNr?=
 =?gb2312?B?Q2I5Q0VpMGpYYUE0YzVUeS9XeXRBTFJCeWV5QjZEeTlyckJ5eDhzakg4cTNw?=
 =?gb2312?B?eU0rTGJHaWtGZEJjQTZ3ZCtiaGNCU1AvRUQ1SXF5dUZES2UwVFZOZURzMW1o?=
 =?gb2312?B?dFBzOE03S1ZZRU10b3JYelNnbU5nTTJhMW5KY3VONXMzV2dxZnppdE02Y2px?=
 =?gb2312?B?UzBwejlBQmZUK0s2b0RJditQZVVpQU1zMG5KOHh1VzhFeTVyUzliZnpMTTlQ?=
 =?gb2312?B?czVPSTFuMXg5T3cxV2FJNUQvSEdCdnhXQ2pHS2lCUndnNHY3cURkSHlzbWEz?=
 =?gb2312?B?TmxmeHdBbDlSYkFBOERKUm9kNTlraEtxT3l3VlVmMGRpM2dHZzloNFdZTXRu?=
 =?gb2312?B?OHpxQjZ2RC9zTHpvcmxRa2dBLzE2SzBYZStDa2FUMVpVb2tiTjBEWU8waW94?=
 =?gb2312?B?a2xtcng2UDNMZWNYT3BoZ204bGgrRkFpYkJPc2ZkdjVKcXJMM0haQUc2Ulk0?=
 =?gb2312?B?ZmtKT2lwbHYySHdBNzJUUDR6dzEwekpOMXNrQW9TcUpZVERIcU1WempFU1Nv?=
 =?gb2312?B?aGpHZkNxaGxhdHJmZ3lieDk1d3BDVVF5dVRzc1VtdldmRlNUSklDbnFTMHpZ?=
 =?gb2312?B?OUx1c1hsbjIzbHJrSXNJL0xPdGpmZ2syRXMrWFR0K1lPWk0vNzF6bFZqZEdG?=
 =?gb2312?B?K2IwMW9qTGFKVk8yQUpIcmpHaE5MZ3A3UkNQNFBoUS9OTXlxNUVoajBwRVh0?=
 =?gb2312?B?Sk9UNkdrNTZIeGxwSDhTZk9Ga0UvV3NpK1k2azFTYW8yZktSOWhiVG83NWpy?=
 =?gb2312?B?NXIxV0wxZDdMdW9TVmdLY1UwcGQyaDd2TU1hT0JpMVF4K0pGQkttcHgxY3J3?=
 =?gb2312?B?SCtDTTVVWVFHM1orcmdKRlNoS3lPS0owWXROTUNWaU1Za1JJYmR0d2tWS3kx?=
 =?gb2312?B?cmVDWk45WTZGTmlFWG9YdWtwdGNCUFZySGRqY2hsV0tpcThiU1ZPeloyS3lH?=
 =?gb2312?B?K0JIWlA3d2hMSmRrMDUvRjFtZVZ5bExKU1V5Q2xsZmMwbThTcE4zbFVhbG9Q?=
 =?gb2312?B?R1NzQ0h5c21ESVo2SDlTV2lmWDlaVDFCOFFYVSt4L2M5dFB5VDBjVWpBNHVP?=
 =?gb2312?B?aHRPUTdwKzBFTEo5ZW42RFJWamZYM3NYeFhNS1JhVjZ6dThmQm9Sc3BoK0tM?=
 =?gb2312?B?RmhQbm5FSENXN0NlQUFyaTlZdlBlaHBna1JSYm1ka0gvUzRSWE9rMkFENGxX?=
 =?gb2312?B?ankrOUV1d09zS1dSMmlrMThkOFd2cm90K2liQW9aVEJnWkE1Qm8rK2hnYWNv?=
 =?gb2312?B?eG8yRFk0Q3NlWGhzeUo1TXg5c09RWkZ0bGF5S3E5TURZQm9wR0ZFay8rNU9R?=
 =?gb2312?Q?ysNyyPi1Y1Hu4m3yxV9SlPgit?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d78fc31-fb3f-47f7-8049-08dd59f8fa95
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 02:13:24.6719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vknLydsL+vfxPLDF7bWg2sbZmaXtpiuwmvav6XV88yq5lNIxBSElA6jA3eRnhUjYFIHnBHTed/yYLRnZGUiXKtVP/elMY1gz22+jkfFfIDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9269

SGVsbG8sDQo+PiBTb21lIGVNTUMgZGV2aWNlcyAoZS5nLiwgQkdTRDRSIGFuZCBBSU0yMEYpIG1h
eSBlbnRlciBhbiB1bnJlc3BvbnNpdmUgDQo+PiBzdGF0ZSBhZnRlciBlbmNvdW50ZXJpbmcgQ1JD
IGVycm9ycyBkdXJpbmcgUlBNQiB3cml0ZXMgKENNRDI1KS4gVGhpcyANCj4+IHByZXZlbnRzIHRo
ZSBkZXZpY2UgZnJvbSBzd2l0Y2hpbmcgYmFjayB0byB0aGUgbWFpbiBwYXJ0aXRpb24gdmlhIA0K
Pj4gQ01ENiwgYmxvY2tpbmcgZnVydGhlciBJL08gb3BlcmF0aW9ucy4NCj5EaWZmZXJlbnQgY2Fy
ZHMgb24gdGhlIHNhbWUgcGxhdGZvcm0/DQo+Q2FuIHlvdSBzaGFyZSB3aGljaCBwbGF0Zm9ybSwg
YW5kIGZldyBsaW5lcyBmcm9tIHRoZSBsb2cgc3VwcG9ydGluZyB5b3VyIGFuYWx5c2lzPw0KDQpJ
IHRlc3RlZCBvbiBSLUNhciBHZW4zLzQgcGxhdGZvcm1zLCB3aGljaCB1c2UgdGhlIHNhbWUgaG9z
dCBjb250cm9sbGVyIElQIGFuZCB0aGUgdG1pb19tbWMgaG9zdCBkcml2ZXIuDQpUaGUgdGVzdHMg
d2VyZSBjb25kdWN0ZWQgb24gZGlmZmVyZW50IGJvYXJkIGFuZCBlTU1DIGNvbWJpbmF0aW9uczoN
Ci0gR2VuMyBCb2FyZCB3aXRoIFNhbXN1bmcgZU1NQyAoQkdTRDRSKSCh+iBJc3N1ZSBvYnNlcnZl
ZA0KLSBHZW4zIEJvYXJkIHdpdGggTWljcm9uIGVNTUMgKEFJTTIwRiwgbmV3IHZlcnNpb24pIKH6
IElzc3VlIG9ic2VydmVkDQotIEdlbjMgQm9hcmQgd2l0aCBNaWNyb24gZU1NQyAoQUlNMjBGLCBv
bGQgdmVyc2lvbikgofogTm8gaXNzdWUNCi0gR2VuNCBCb2FyZCB3aXRoIE1pY3JvbiBlTU1DIChH
MU0xNUwpIKH6IE5vIGlzc3VlDQoNClRoZSBpc3N1ZSBvbmx5IG9jY3VycyBpbiB0aGUgUlBNQiBw
YXJ0aXRpb24gZHVyaW5nIHdyaXRlIG9wZXJhdGlvbnMsIHdoZXJlIGEgQ1JDIGVycm9yIGlzIHRy
aWdnZXJlZC4NClRvIGludmVzdGlnYXRlIGZ1cnRoZXIsIEkgaGFja2VkIHRoZSBob3N0IGRyaXZl
ciB0byBnZW5lcmF0ZSBhIGR1bW15IENSQyBkdXJpbmcgdGhlIENNRDI1IGRhdGEgcGhhc2UuDQpU
aGUgcmVwcm9kdWNlZCBsb2cgaXMgYXMgZm9sbG93czoNCiQgLi9tbWMgcnBtYiByZWFkLWNvdW50
ZXIgL2Rldi9tbWNibGswcnBtYg0KWyAgIDc1LjU1Nzg0OF0gd190OiAtLT5TVEFSVF9DTUQ2IChh
cmc6IDNiMzAzMDEpDQpbICAgNzUuNTU3ODYzXSB3X3Q6ICAgIHJlc3BbMF09OTAwDQpbICAgNzUu
NTU3ODc1XSB3X3Q6IC0tPlNUQVJUX0NNRDEzIChhcmc6IDEwMDAwKQ0KWyAgIDc1LjU1Nzg4NF0g
d190OiAgICByZXNwWzBdPTkwMA0KWyAgIDc1LjU1Nzg5NF0gd190OiAtLT5TVEFSVF9DTUQyMyAo
YXJnOiAxKQ0KWyAgIDc1LjU1NzkwM10gd190OiAgICByZXNwWzBdPTkwMA0KWyAgIDc1LjU1Nzkx
NV0gd190OiAtLT5TVEFSVF9DTUQyNSAoYXJnOiAwKQ0KWyAgIDc1LjU1NzkyNF0gd190OiAgICBy
ZXNwWzBdPTkwMA0KWyAgIDc1LjU1NzkzMV0gISEhISEhISEhISEhISEhISwgbWFrZSBhIGR1bW15
IHdyaXRlIENSQyBvbiBEQVQNClsgICA3NS41NjM2MzFdIHdfdDogKGRhdGFfZXJyKSAtODQgc3Rh
dD0yMDgyMDYwNCBlcnJvcj01ODAwICh3aGljaCBtZWFucyBlTU1DIGRldmljZSBmZWVkYmFja2Vk
IG5hZ2F0aXZlIENSQyBzdGF0dXMpDQpbICAgNzUuNTYzNjcyXSByZW5lc2FzX3NkaGlfaW50ZXJu
YWxfZG1hYyBlZTE0MDAwMC5zZDogX19tbWNfYmxrX2lvY3RsX2NtZDogZGF0YSBlcnJvciAtODQN
ClsgICA3NS41NzMxMTJdIHdfdDogLS0+U1RBUlRfQ01ENiAoYXJnOiAzYjMwMDAxKQ0KWyAgIDc1
LjU3MzEzMl0gd190OiAoY21kX2VyciAtMTEwKSBzdGF0PTIwYzAwNDAxIGVycm9yPTEyMDAwDQpb
ICAgNzUuNTczMTU0XSB3X3Q6IC0tPlNUQVJUX0NNRDYgKGFyZzogM2IzMDAwMSkNClsgICA3NS41
NzMxNjldIHdfdDogKGNtZF9lcnIgLTExMCkgc3RhdD0yMGMwMDQwMSBlcnJvcj0xMjAwMA0KWyAg
IDc1LjU3MzE4M10gd190OiAtLT5TVEFSVF9DTUQ2IChhcmc6IDNiMzAwMDEpDQpbICAgNzUuNTcz
MTk3XSB3X3Q6IChjbWRfZXJyIC0xMTApIHN0YXQ9MjBjMDA0MDEgZXJyb3I9MTIwMDANClsgICA3
NS41NzMyMTFdIHdfdDogLS0+U1RBUlRfQ01ENiAoYXJnOiAzYjMwMDAxKQ0KWyAgIDc1LjU3MzIy
NV0gd190OiAoY21kX2VyciAtMTEwKSBzdGF0PTIwYzAwNDAxIGVycm9yPTEyMDAwDQpBZnRlciB0
aGlzIGlzc3VlIG9jY3VycywgdGhlIGVNTUMgZGV2aWNlIG5vIGxvbmdlciByZXNwb25kcyB0byBD
TUQ2LCBldmVuIHN1YnNlcXVlbnQgYWNjZXNzZXMgdG8gdGhlIG1haW4gcGFydGl0aW9uIHByb2Nl
ZWQgYWJub3JtYWxseS4NCkhvd2V2ZXIsIGlmIHdlIHBlcmZvcm0gYW4gZU1NQyBjYXJkIHJlc2V0
IGF0IHRoaXMgcG9pbnQsIHRoZSByZXRyeSBvZiBDTUQ2IHdvcmtzIGFzIGV4cGVjdGVkLg0KDQpC
VFcsDQpJIG5vdyBiZWxpZXZlIHRoYXQgc2VuZGluZyBDTUQxMiBpcyBhIGJldHRlciBzb2x1dGlv
biBpbiB0aGlzIGNhc2UgcmF0aGVyIHRoYW4gcGVyZm9ybWluZyBhIHJlc2V0Lg0KQWNjb3JkaW5n
IHRvIGluZm9ybWF0aW9uIGZyb20gdGhlIGVNTUMgdmVuZG9yLCBldmVuIGluIGEgY2xvc2VkLWVu
ZCB3cml0ZSBvcGVyYXRpb24gKENNRDIzICsgQ01EMjUpLCBDTUQxMiBpcyByZXF1aXJlZCBpZiBh
bnkgY29tbXVuaWNhdGlvbiBlcnJvciBvY2N1cnMuDQpUaGUgSkVTRDg0IHNwZWNpZmljYXRpb24g
YWxzbyBtZW50aW9ucyBhIHNpbWlsYXIgcmVxdWlyZW1lbnQ6ICJBIHN0b3AgY29tbWFuZCBpcyBu
b3QgcmVxdWlyZWQgYXQgdGhlIGVuZCBvZiB0aGlzIHR5cGUgb2YgbXVsdGlwbGUgYmxvY2sgd3Jp
dGUgdW5sZXNzIHRlcm1pbmF0ZWQgd2l0aCBhbiBlcnJvci4iDQpJIGp1c3Qgc2ltcGx5IHRlc3Rl
ZCB0aGlzIGFwcHJvYWNoIG9uIHRoZSBhZmZlY3RlZCBib2FyZCwgYW5kIGl0IGNhbiB3b3JrIHN1
Y2Nlc3NmdWxseS4NCg0KPj4gDQo+PiBUaGUgcm9vdCBjYXVzZSBpcyBzdXNwZWN0ZWQgdG8gYmUg
YSBmaXJtd2FyZS9oYXJkd2FyZSBpc3N1ZSBpbiANCj4+IHNwZWNpZmljIGVNTUMgbW9kZWxzLiBB
IHdvcmthcm91bmQgaXMgdG8gcGVyZm9ybSBhIGhhcmR3YXJlIHJlc2V0IHZpYQ0KPj4gbW1jX2h3
X3Jlc2V0KCkNCj4+IHdoZW4gdGhlIHBhcnRpdGlvbiBzd2l0Y2ggZmFpbHMsIGZvbGxvd2VkIGJ5
IGEgcmV0cnkuDQo+U2FtZSBmdyBidWcgaW4gMiBkaWZmZXJlbnQgcHJvZHVjdHM/DQo+DQo+V2h5
IGRvIHdlIG5lZWQgdG8gZml4IGl0IGhlcmU/DQo+VGhlIGlvY3RsIHdpbGwgZXZlbnR1YWxseSBy
ZXR1cm4gYW4gZXJyb3IsIGFuZCByZXNldCBpcyBuZWVkZWQgYW55d2F5Lg0KPklmIHRoZSBlTU1D
IGlzIHRoZSBwcmltYXJ5IHN0b3JhZ2UsICB0aGUgcGxhdGZvcm0gaXMgcmVib290aW5nIHdpdGhv
dXQgYmVpbmcgYXdhcmUgd2hhdCB3ZW50IHdyb25nLg0KDQpJbiB0aGUgbWFpbiBwYXJ0aXRpb24s
IGEgc2ltaWxhciByZXNldCBvcGVyYXRpb24gaXMgYWxyZWFkeSBpbXBsZW1lbnRlZCBpbiBtbWNf
YmxrX2lzc3VlX3J3X3JxKCksDQpTbyBJIGJlbGlldmUgYXBwbHlpbmcgdGhlIHNhbWUgYXBwcm9h
Y2ggZm9yIFJQTUIgc2hvdWxkIGJlIGFjY2VwdGFibGUuDQoJCWNhc2UgTU1DX0JMS19BQk9SVDoN
CgkJCWlmICghbW1jX2Jsa19yZXNldChtZCwgY2FyZC0+aG9zdCwgdHlwZSkpDQoJCQkJYnJlYWs7
DQoJCQltbWNfYmxrX3J3X2NtZF9hYm9ydChtcSwgY2FyZCwgb2xkX3JlcSwgbXFfcnEpOw0KCQkJ
bW1jX2Jsa19yd190cnlfcmVzdGFydChtcSwgbmV3X3JlcSwgbXFycV9jdXIpOw0KCQkJcmV0dXJu
Ow0KDQoNCkJlc3QgUmVnYXJkcywNCkd1YW4gV2FuZw0K
