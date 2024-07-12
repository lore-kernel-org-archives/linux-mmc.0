Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013051.outbound.protection.outlook.com [52.101.67.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2ED944E;
	Fri, 12 Jul 2024 02:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720751697; cv=fail; b=hCeJzvfpPPE6/mCiI0Sp7ZVNxkOlktnDRQcxKLnY2yWy2RDbwiHVH28MpxOa0CfC/J9M5p1YjZd1Nm11AGRequhVYCdZCKcA6DXKZGevjdvMDtWYR9D5Mvf2b/8HLVLQiaKexSW9lPAY6ReuMmBK4BPY/hnVxTgUhQRo25OcYzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720751697; c=relaxed/simple;
	bh=9tnLKmOz/1jSkpC8NmVLGM1WBd2UorN3+mToRG1SjhM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e/oINudeWJjZdEenBB3+SquN7EpS1yguQ4d/GTZf11BOhQZEyT3abCBoMVjzhLQBH0Mh9JjNM5wluIFK4T6cr00SaS9o+uhdaheAbao1lIkKA0CJeVB2zKVp6bCu+2DncVHKzkilweZG1idGS0AAXseVY1Wyq63NqZB+WSwpiwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SD+ZtFzE; arc=fail smtp.client-ip=52.101.67.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SD+ZtFzE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kf/5isPB/ey2JMuGKbnQWyQ41yf1EMIA5ZzaXdXK74dScJcF1Ia4fWw0oV55TFhVkYxOk3CWQNCe/3Srkf9jbgzzhrks5bstJ6AIIA1n8QWVh31NyOJIpfrEQvcqi9NhwLtq4KPsb0CS8Rj9hCe1ePaxAu4UeTa/zVYDRkyPpNxJ71cTzvyCMiT6eh2T17DCMTyd3ElTPuOnV4uC/Za1nOakoAI9q2JWRuqFkES7At4yZmZaMUQ/YM+pxykJIPxl0+8xcxUvc6fhqHMAzBEBH5uwSmD88Ggjf/P14wT5D3t9gzrkd3ED7GNqELmGaIRSONFjs8lGCpVyEqERaAtSDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tnLKmOz/1jSkpC8NmVLGM1WBd2UorN3+mToRG1SjhM=;
 b=YwS0dPC0vzONmBMRN4PlXRa+aACsUOdWEdbkyGm5yhxZWdGlecpi19Ut0kQr5piVGaTBf+g4SXmc4Jd0tiF2P8wkQHqr08poNtp69u5NT5vsD86gLPlBY8FbfRdtgl8AXPfdpwrq4Ar2tvXFyFFP7wFWvpeNKhs2Xc+sK92bQiBTfp2RDMtxkhepMYJCNw6kAE8OV+GXIkslhGaHHASDj75xCR6LB9K2JyhCe5ld1HLx5jN91YNFcfQKIVo1+x1nOWq7CyeJClnGsC6vtlLI4o7W++7u1v1iyASHiK3wbjmr3dhnp54045jl2D3r1aFQhcY5ecOaCfKw40qE9eQuDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tnLKmOz/1jSkpC8NmVLGM1WBd2UorN3+mToRG1SjhM=;
 b=SD+ZtFzEwjpTU+jw5PuBF8Sh+5cH0cme0Jnxsi8jqrUtvc6P5iYH9AMYHmJ3idKOQl+1M/RGW0MoSo1cYc2dhHt3jPK7JgcVg8CLxjj4/bg4apYRX390ut17qbqNHMIAj75ToGvXTjY4S1IwqBwinKDvUi7DtxPLJWdUhJCRRJg=
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AS8PR04MB7766.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 02:34:52 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 02:34:51 +0000
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
Subject: RE: [PATCH 3/3] MAINTAINERS: add 's32@nxp.com' as relevant mailing
 list for 'sdhci-esdhc-imx' driver
Thread-Topic: [PATCH 3/3] MAINTAINERS: add 's32@nxp.com' as relevant mailing
 list for 'sdhci-esdhc-imx' driver
Thread-Index: AQHa0S/U5BC34yc4YUKwHPr2qbDc57HyZY8Q
Date: Fri, 12 Jul 2024 02:34:51 +0000
Message-ID:
 <DU0PR04MB9496C669AE89F94ED744E5AD90A62@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20240708121018.246476-1-ciprianmarian.costea@oss.nxp.com>
 <20240708121018.246476-4-ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20240708121018.246476-4-ciprianmarian.costea@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|AS8PR04MB7766:EE_
x-ms-office365-filtering-correlation-id: 50e271a2-cb31-42e2-eab4-08dca21b34c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a29qUDlXcy9kVzZkQTJPWXgwNVNvMStjWCt4a0lYeWpEdzJWL1dqYjdpTnVY?=
 =?utf-8?B?K1BzNHMzTUJaTXY4a004OGNaRlpBRUQ2MlJMbk5XMTh5ZUt3ZE1OSmZFZ3RK?=
 =?utf-8?B?VUxSVVFBbGFwMkQrUkJNUExLRjdPS2ZlRmFhVlNIVlI0ZWlleGFmaGJGWk9U?=
 =?utf-8?B?emNsK2xRRXZiRmJiL0pvcHdncklSc1pVZkF6QnlYaXMrS3BFcHh6TGYwaG4z?=
 =?utf-8?B?V3NrU282SmF4ZjMrL3VlZ1NpYkRJQWdxRG9mUXk2NWJxbzRoTThDd1NsZFZ0?=
 =?utf-8?B?VkpncXc1eHlvMUN6c3Q2NUdYUUJBajBnbTZadzRNcVZudUhFcnloVmlIbTgy?=
 =?utf-8?B?UWdmYUthZmV4N29Od0h5M05oYlZCcXdITjRkT09xb1psemhYa1VHMWIza0JD?=
 =?utf-8?B?T1QzK3lOVHBVb2NWY2pFb0pFRHZKczJaQ1FCcy9KTTd4bUF3RkRmRmZvY24y?=
 =?utf-8?B?VXhnenFWYWtadzRQR2ZaZ05iSVdHY0ZrTGpjaG90eHUrL0g2dnlYRklMSnFD?=
 =?utf-8?B?ZlZ1Q3l1M3kyU3F1bjBkQkxwZkJMMm43UUZxQjRISXRXZ3VQZEdFL1ZRQkdo?=
 =?utf-8?B?V3FhT0p5YUZOSlRuamY0aVdrbjM5TlRQc2xVamV6a205dWNGV0tqck8rYU9S?=
 =?utf-8?B?T1lXbEllcko4NEIyR0gyNVhHcFdBUW5wN1BJVzg2and0ZVp4RkFnVFg4M0Jw?=
 =?utf-8?B?VTUvSU8wRzJ3WlpJbGNMWi9mbkh6bnhJSXQ1dnBqOWNMdEtQV0dUeFVkOWli?=
 =?utf-8?B?VDZqQXREQk5HdkplenFtSjVGM2J3TW0wc1U2aUtRSFZpVFhYNXU3anp6cUV2?=
 =?utf-8?B?YkRNWlRGTkxJSnliY2tUVWQvMGd1K1ZvZEluY0Y3TXhER1hSUktkN2x1MmV1?=
 =?utf-8?B?RWFwck1Yd2tpc1AyVXdsbzVtUjk4RlJiRURlTWhTTmdMZStoV1Y0NThhUTVH?=
 =?utf-8?B?ZEpBUk4zNzBwUjZveGpYdkJxWkVnVlRGMFA3YzBVd1pFTEFnSXVqdWJqOStX?=
 =?utf-8?B?NVdabWFOdVI3U3BFSGV4YWFHcURWNExLdStQQ1NMb0RMMHIxeFBKdVpSRms1?=
 =?utf-8?B?VkhzWk9teHErM05UcXM2ZkxJd2hxeW85M1pPWmZzQW90N0lINVlGaEJobjlq?=
 =?utf-8?B?OVhnczFGQVI0R3Z6TEpIanp3YWIzR1NUVEVOZXBXZmNYYmlwYXBFUUZxVkMw?=
 =?utf-8?B?UWlKV09qejAyRmxEMEltYmY5TE5yUFNqNlB4ek04RkFMZllqcXpRbVFNd0Mw?=
 =?utf-8?B?dWZlNWxpcU9OQzFlbXBXamVaK29VT0hiQ1J3RDRyU2N2NTNIRTFzVVlmZWZG?=
 =?utf-8?B?K3BzM3hibzdKeEovQ20ySkJPc0pVYjVoanpaY2orcXk3NVd0ZEhBOExQT05O?=
 =?utf-8?B?SFAxZmdHQUJCZEpLZG9FdGU5Zzg5SHI1QitFcFJ6WnlOQXo4SnNUSERvN2U1?=
 =?utf-8?B?VXdZTk8ycWFpc2IyWFc1Vm5BRTVuOFY0UFUwWnk0azVkRjVBUUc1QWRlbnJW?=
 =?utf-8?B?ems0UmY4QnJiY2NjVGdmV1VFWlRjczlQaE1IL0toVy9IbEFGcHVERmJXYUxL?=
 =?utf-8?B?eVJ1OTl3STY4Y0lSR0xQaUEvWFRiR0M3eU50cGhTREVaUDRvZlFxTWt5R2x2?=
 =?utf-8?B?d0U3MHNaemZVRXV3THZFK24zTXlzU2ZOVW1wSkk0Qm1yVzFKbnNZekFzemF5?=
 =?utf-8?B?ejBjeENSQ1RaN0Q0cnM4NHgwNjdQSVlPc25mTmVubVdsV2ZiRXdGWmNFVFlL?=
 =?utf-8?B?WDFEQ3V6M1RQRDZ5cW1FM25yaVJ6RktMT2g3anR5OTdKVDF3eFA1cGV3YklR?=
 =?utf-8?B?Q0JDdEhGOEh3RWZVUHFWY2tna2NiTVdGckMrMWpqRGhTNDVWTWp6WnhWeHp2?=
 =?utf-8?B?Z0FFbkpoTDM5SW1CZkVBRFh0OVlmZldQSmM0TndXYkZucUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bmVldElyc1pZWUpWYU9CeEFLZ3Q0ek9rc2ovWUZsVy9Hck8yeTgvbHFqZ0lr?=
 =?utf-8?B?L1B4U3FLcWVPQ1lGVnh0YkhubmpOSHp3VFdXRU9MVElaOEVFMmdISk5BbklU?=
 =?utf-8?B?eWRiZng4dGFKTS83b3RmbnFGY0xpWGZaRk5UeXlQQ1I0bFBjMDc5bUtjN25u?=
 =?utf-8?B?MXNaQStVS0p0VitacmpZTXlibFZwbEJoZTlzdm96b2RKUmVpQXZ3M2hhaGw1?=
 =?utf-8?B?cWJVaXI3eTIveEJDRCtVclpEdHVkZE1hSGluSVJLWmNXdlRhYTlxNWNtcGUv?=
 =?utf-8?B?Z05DdTMyZUthalJINmtwUEpuSHhaWEFscUtDY3BNQmhUWmwxaEc5MHM1akVk?=
 =?utf-8?B?Zy8zY3J3eHpGZ2hqdXRUNUF4Q3hRS2w5cSs0VWQ4NWlBbUN4eW84TXBhVFJW?=
 =?utf-8?B?RlNVUWtQSTlYY0daNFpsSVc4U21wTmZhUzZyS3IzTEJjcGdMUm1LVElJMERL?=
 =?utf-8?B?Q1dRNTR2RUNSTmxPcFdaQWhGMnlSK0VQQ1o5MkgxRUFXQUs2dW1VcGFEbDhr?=
 =?utf-8?B?NFhUd0xWR3pqbVkvR0MrN0JFNnZZbUI3L3lMVFV3alpZMzh4WmtkQTNpb0lF?=
 =?utf-8?B?WjExWXhEeUREN0FXdkY5dWNCZUx0RWFYV2tET1BOMXJSWlRLNEhIamIwRGgw?=
 =?utf-8?B?bmhEWjltOHd0ZDcwQjd5Q0VBcHo3QUpkSGdqUkZ0ZDZ5L2xickxtNlVhL1Rq?=
 =?utf-8?B?MlNVQkkySHgzSFYyWldMV3dRQkRCVlBRNjByc2cxcFI1N3J6azdOemFSd1px?=
 =?utf-8?B?R3hYaGlmYkFSTytaMnljNTVOcm15T3JOd3cwTHdGS2lLbEt3N2lxY2Q3amsx?=
 =?utf-8?B?SytvRk55NktudnNzanRlVUlvK2V2ZTZ2RDZhRVplT2xoQUFkMU41dktmZkdY?=
 =?utf-8?B?NHF3MnZCZzBXZjIyUXd5QUlpcjdSaWZtMVU2Wi92ZkxxZ3BDOFJhWS95eWly?=
 =?utf-8?B?MFhtMnU3aklUczlqQzBtZ25nQ2w1OHQrTXpiZk5VY3pFcmpnVEVqMjhxVzhl?=
 =?utf-8?B?MzkxQm1Ib09LRUZnaDZzQnExZi9xN09pSWdsRmZnSGRueGNuQXVJdkI4R2Na?=
 =?utf-8?B?SFB5SFlTVnBFWmNxcGdZYmZDM2FESW5ja2xYZkdmM0JVa20vTS9HL2xEbHJQ?=
 =?utf-8?B?Z3hKbWhWVlNMSnpwbWRRcTAzRE9Qb2hDZDNBWFJvY2JqYkhhdlMvZFNCdEVS?=
 =?utf-8?B?UHFldGpDWG5pM2FSd3J2dzVaZmszVFh0QVVkZ0pMNjNCRk0xOG1Rc1ZBdnZu?=
 =?utf-8?B?UVJYcFVDNlJ3eWdab1VUOWRrWGt1dTBXTU1wZFlSZllWYS8vQVJtVmIwZ0RH?=
 =?utf-8?B?Y0ZHTFBRY2JNZVY5cnJaWkdIYlV0U1l2SGpsM3ZCV01BU1BBalNyRWxNRDI5?=
 =?utf-8?B?UzJsekh2THhGUGhkL3lySXZwVWdOYUcrWE9vTDlDaTNkTEVXc0t4L1pOSkNI?=
 =?utf-8?B?YXNld3RoVkpFcXpCNXNRRExQOG90OUJ0b05rZk96ZlBXZUNTTWRtajF0Vk95?=
 =?utf-8?B?UVdqWXdMdVVGUWd4NzQvUVVKcHpSdUlsS28vbHFKUnhRUnJYQnBtc3NUVk5C?=
 =?utf-8?B?blNGMnpKWGgzRXgwTW1jZkRiTkxNcVBicTI3Nnc1RlJDNlBFRGo3bVRhRVg4?=
 =?utf-8?B?Y1pCTTJmemtiUi9CU0MwanYvY0owT0ZJMlJXQ0ZDWmlxWkdIelFPNmpkb0lE?=
 =?utf-8?B?QmJXV0RadnRmNXhvVWJLYlFsTnJNUHZmbFFDVi9SUm5ZbFEwTkpWcER3QndO?=
 =?utf-8?B?bEFpeTRnbmFUSmdpb3BCM1lyZ3FOeTlHamIrYm4wc0xTbnBnRmVqblEwdkZ6?=
 =?utf-8?B?TUZyOGhRZlhpTzR2M0VHYnBIYkVLRWpTaVZXZ0o5Zys5YlI4QW9pNTc5U1N2?=
 =?utf-8?B?VWVDZVAvaHFFcm8xUmxlYlZhaTNKNjV4cEF2TC85L1g0UkRjZFhnNW02R2dY?=
 =?utf-8?B?U2RHU0NrbzBVeG9XeXpobUUyZkkrMy9pbE1HWE1mM3lxZ1pQakFMSlBXKzJK?=
 =?utf-8?B?MDZuR1EyenhzUlIvUlgrSmFyZFJSM2phRFF4SG5RV282ZnpKVzI1YmhqdVlS?=
 =?utf-8?B?R2lkeTBTQlJ1Tk5WckpHRHJqN00yVnJ6eXpJS2FBQUFpdWhGQllqamQ3MVpF?=
 =?utf-8?Q?QfU8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e271a2-cb31-42e2-eab4-08dca21b34c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 02:34:51.2626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1OaDUOLbYdbbbxqqb7SscY/9tA7LGS4TNvL926E6giKMjQFt1J7lK8mHYiBR7PPCbKLWY5vJGU7KgIEbDdXQLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7766

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaXByaWFuIE1hcmlhbiBDb3N0
ZWEgKE9TUykgPGNpcHJpYW5tYXJpYW4uY29zdGVhQG9zcy5ueHAuY29tPg0KPiBTZW50OiAyMDI0
5bm0N+aciDjml6UgMjA6MTANCj4gVG86IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT47
IEFkcmlhbiBIdW50ZXINCj4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgVWxmIEhhbnNzb24g
PHVsZi5oYW5zc29uQGxpbmFyby5vcmc+OyBTaGF3biBHdW8NCj4gPHNoYXduZ3VvQGtlcm5lbC5v
cmc+OyBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+Ow0KPiBQZW5ndXRyb25p
eCBLZXJuZWwgVGVhbSA8a2VybmVsQHBlbmd1dHJvbml4LmRlPjsgRmFiaW8gRXN0ZXZhbQ0KPiA8
ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
bGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsNCj4gaW14QGxpc3RzLmxpbnV4LmRldjsgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkbC1TMzINCj4gPFMzMkBueHAuY29tPjsg
Q2lwcmlhbiBNYXJpYW4gQ29zdGVhIChPU1MpDQo+IDxjaXByaWFubWFyaWFuLmNvc3RlYUBvc3Mu
bnhwLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDMvM10gTUFJTlRBSU5FUlM6IGFkZCAnczMyQG54
cC5jb20nIGFzIHJlbGV2YW50IG1haWxpbmcgbGlzdA0KPiBmb3IgJ3NkaGNpLWVzZGhjLWlteCcg
ZHJpdmVyDQo+IA0KPiBTaW5jZSBOWFAgUzMyRzIgYW5kIFMzMkczIFNvQ3Mgc2hhcmUgdGhlIFNE
SENJIGNvbnRyb2xsZXIgd2l0aCBJLk1YDQo+IHBsYXRmb3JtcyBpdCB3b3VsZCBiZSB2YWx1YWJs
ZSB0byBhZGQgJ3MzMkBueHAuY29tJyBhcyBhIHJlbGV2YW50IG1haWxpbmcgbGlzdCBpbg0KPiB0
aGlzIGFyZWEuDQo+IA0KDQpBY2tlZC1ieTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29t
Pg0KDQpSZWdhcmRzDQpIYWlibyBjaGVuDQo+IFNpZ25lZC1vZmYtYnk6IENpcHJpYW4gQ29zdGVh
IDxjaXByaWFubWFyaWFuLmNvc3RlYUBvc3MubnhwLmNvbT4NCj4gLS0tDQo+ICBNQUlOVEFJTkVS
UyB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPiBpbmRleCBhMzljMjM3ZWRiOTUuLjI2
YjFlYzJiYTA5NCAxMDA2NDQNCj4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gKysrIGIvTUFJTlRBSU5F
UlMNCj4gQEAgLTIwMDk4LDYgKzIwMDk4LDcgQEAgU0VDVVJFIERJR0lUQUwgSE9TVCBDT05UUk9M
TEVSIElOVEVSRkFDRQ0KPiAoU0RIQ0kpIE5YUCBpLk1YIERSSVZFUg0KPiAgTToJSGFpYm8gQ2hl
biA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiAgTDoJaW14QGxpc3RzLmxpbnV4LmRldg0KPiAgTDoJ
bGludXgtbW1jQHZnZXIua2VybmVsLm9yZw0KPiArTDoJczMyQG54cC5jb20NCj4gIFM6CU1haW50
YWluZWQNCj4gIEY6CWRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gDQo+IC0t
DQo+IDIuNDUuMg0KDQo=
