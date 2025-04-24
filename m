Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013031.outbound.protection.outlook.com [40.107.162.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EF91EBA08;
	Thu, 24 Apr 2025 07:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745480035; cv=fail; b=nkBxrWRaSCw50k98iD7fMYf8Z1Vh0/WxbvwLACiIgX14+S29cM9uYuZaR5LZrtvlP1heRncU2yEToHkjHwtoXIDDozf2iSnB895zLuprcvgnHZtsQv+lsjwMVLpi5p0mFJZoRim0CgmSlMAkWAKB9OWITSpK3URgCfaXhXvQbzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745480035; c=relaxed/simple;
	bh=FKYSr+UXwCR4CKuitMnOQXfWFT+Ukc6PmObEY1KyrQo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nv5x94qzYKo7/MkGub1P4vhttDlRmr41xMFJJV8k+2K+b4pSdIU6UVoLjgY16Z7CEhXgK/rM+6M5FwG8ld9o/San+wtCg5eeJljaPjl1bzOiqS3O4ZzNcps1uoann+Y4VjH76lfvX/vjjDxsAKO/+7ODMHOuGj8uvD6feiypHw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZPRS6F25; arc=fail smtp.client-ip=40.107.162.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZPRS6F25"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3YXHw9wuce74Wm5sIYsHon06MUw6ffZNfwQnqBQXrgAFOD9CDwWlX3dY6ASpWuL9o72ZkKxR++q+Ip5DGrPeKMZblc6aS8kjVlRdSOjHJ+U8qyBJxeIQ7VTOkHfnjv65mXjyRGPkjHeZ+0zhULHNK3hyjlW4fDuq4O44IAF8z5GRPBGaumhsFfexeSTa0wlIMqNFhgvYGlSn0XKPc/bzyIawF9RwSU0jffHpMXomn9SW/rrCgx2NqMkDh5CImltgoAVStkxMhLYErZB+pHB2cRpuJzT6SMcZ8mhJPpmsDdkLb9uJNz4jA11g4yvj7p/zwm3vj6YX3tUnwsyLvUgcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKYSr+UXwCR4CKuitMnOQXfWFT+Ukc6PmObEY1KyrQo=;
 b=QHClZdzp1xR8T7vTyy4ek5+Ld/jWPmC73mK7X+snctwe4I6QF9j+KchV6UMWit7a2kya2BWHIG5oQJp/wV2bm6v+/oDGsgjb96t0qum6BfYFbWZbttDnnm5N+/ep/KQ99tB5IqkHuqoa1Lnd+AjqqFbv2fRCI5zyb43J1NxUHtH0hspC1LSEa5pjZLPaLsIv4QEQ0FdAr5hMQQffbo7IY1q5utEYMxToNBOphmv7VnkmEqZrcNQseRyFCOHmGLFpiEsY/yEk3DcyKg/wBRP5ZzBZzmSZ5zQ6CS/GZ19NubwRzV0vqFHaCxyWxTN22O1HnBeOHb5xqdNx92YEqtXdXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKYSr+UXwCR4CKuitMnOQXfWFT+Ukc6PmObEY1KyrQo=;
 b=ZPRS6F25uyibuLl1PXruMAPLxOjPrq5yB2/CrdgA4TxDLuMK2Cnrr99BuOPdRwDbiG0Mowgba4GOSpLQL1PqwB6hKRZPKZg3wXU5+uewplBUvmujs0I9dEd7FWuDkLpklCQev7iBVLNebDLShWhFfagvytfwcxmsyMuwA3SKoAoB49MeHI6F7r12HQ/CA1xil61BrUkbiPBM/y4wNExevmwAM0+uH8UcRn2RYH3CEooQjwhtkC2typGTtXr+KwqIGIkgs/OKCsIS0pAP8BA9TwVu/0sxdJDb/Cw9QizoKsCI0jc7C0R2nlx6UPd6l1aMkL00lOrphjTwwA7FruF4tA==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AM0PR04MB7010.eurprd04.prod.outlook.com (2603:10a6:208:199::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Thu, 24 Apr
 2025 07:33:50 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%5]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 07:33:50 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Randy Dunlap <rdunlap@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Luke Wang <ziniu.wang_1@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, dl-S32 <S32@nxp.com>
Subject: RE: [PATCH -next] mmc: sdhci-esdhc-imx: fix defined but not used
 warnings
Thread-Topic: [PATCH -next] mmc: sdhci-esdhc-imx: fix defined but not used
 warnings
Thread-Index: AQHbtMtvnXsGEc7cZ0CW9zbeR2q8rbOybF4w
Date: Thu, 24 Apr 2025 07:33:50 +0000
Message-ID:
 <DU0PR04MB9496CB9B253C34CBADC79EA090852@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20250424034610.441532-1-rdunlap@infradead.org>
In-Reply-To: <20250424034610.441532-1-rdunlap@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|AM0PR04MB7010:EE_
x-ms-office365-filtering-correlation-id: bf679b81-2d68-46c2-2450-08dd83025ba7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?SUo2MkhneTBOOUdXMFF3Z2dIL3VXZzg4cU9WYkkwQ1VoYjloNDlKSSt3dFJL?=
 =?gb2312?B?R0VXSDR5TFIwcUV5RERFdDZtR0pGakcvdURUYjFtQVF1SnZHTHg3QVVvdGNQ?=
 =?gb2312?B?SW1CZUVlTW91YllPSTJ0Q1pWRWhudnVLT0krdkMrenkyZk5iWDZrQXk3bUVv?=
 =?gb2312?B?VEUybFo4bHFDS0tQQkZpSjhueDBzZ2YzWmZ1TGZDWDZ2S00zamczK0RHQnFH?=
 =?gb2312?B?c2d0M3d5ckYyUjN1Q0t6THhua296TGhhV3Y3d0VQWTNWZXVXRUVSU3hWazlN?=
 =?gb2312?B?TzBJL004UjhGSGV1TGI3T0xqZHBjakdITng5UFVlN2RoZERBNVRZbjRJSE9M?=
 =?gb2312?B?ZkdZY05ZcHZVRmV0TFcwN2p4cnVNdUwyMkxSb1ZYM3MrR3pUNVdCYW5tNDRu?=
 =?gb2312?B?YzY1dENCL3ZsOWI3cXdMRTRFVlkwdkk4cXNhU3JBdVdyWHE1Y2pldFk1TWQz?=
 =?gb2312?B?WmhZckVTL1ZVS0RLN1J4VU9KOUd4dC85NTJuenpEVWZ1a3J2Mi9hN1FtVVN6?=
 =?gb2312?B?RzdjZ1hiczRwZjYxSitJUW1wczdjMlJ6eHNGOFdaZW5oTVpkaHpHMUU0ZWdp?=
 =?gb2312?B?c0RwZm1nS2RWVk43L3QrbUgxVWxWckdtdXMyMHdUT0NRVXJZSWFpME41Nkk2?=
 =?gb2312?B?RGhiZDV5cHIwQ1VtL3ZUL1dYZUNWK0RlQTlMSyt1TFZHSFA2NFVBaG5RSjNI?=
 =?gb2312?B?L25KSUtzTFFLckNEYWR6K285U0tEaVIxVTRNRzhQemlvVHJVd2ljcmpZdnJJ?=
 =?gb2312?B?QU83ZlJsK3hEZ1EyTXJzY0NRZ0ZXemtRYXpJSjBXNGo5bGp0U3lIK1VqWUtK?=
 =?gb2312?B?OEYrUm4zOFI2S2toZ1pNK1dDaUFyRXkwVTdlWThaVGNJUk5nd2h2VWpkeFVK?=
 =?gb2312?B?NWJmV01OLzRHNXVFSVpLZWVTaHhrTlNlWXM0SW9JNFIwYVorYkl4RnlvTmtK?=
 =?gb2312?B?T2FiQVNCbFBFRm05SVhjclVRYVorZm5vc2gzbm50SjZTOU9lSG43QWJaRmR6?=
 =?gb2312?B?b3krQzZ1K25PREpJbm03RWxBVXZvREdnNzhadXJXakdqazBXZjdVNk9zd040?=
 =?gb2312?B?NUNMTmhpK01xZUxaZ1VqcmRXUFFpQTJBZzk5SnJBY0dXRm1VOVl1Rm52endV?=
 =?gb2312?B?ZGUxRENTL1ZVWDdoUm9jdWdBZkE2SzhURlhTU2ZSeGpwOVZxdUVWS08rQjZD?=
 =?gb2312?B?UWJRNVVpdVV0dTArOHVhZ3dycEtabUhIUFpXQmdpa1M4L2xTM2dzbWc5QlFk?=
 =?gb2312?B?ZEhIdVN6c1JSRkgva2RjTzl2OHgwRG5xNUVGbk8rV1JtY2srWU03d004T1NI?=
 =?gb2312?B?VHVNQUo5cjRqaWloZWFpVkRoTU8wajVwRjlzNWxyVEdtdkV0ZVIrMGtUTVJy?=
 =?gb2312?B?WXdXM1Rtd1QwSGZKZzFUTHlONWk4ZVNWb3ZxN1BWRFhiM0wvMWg3dW02Vy9v?=
 =?gb2312?B?MWZBN1FDd3BzWmY1NHBNbVlXdS93NXpNYmNuS1drUFJlbHdoUEovRExhandM?=
 =?gb2312?B?TldlUnlxVlZYcks1ak42VVh4L0pqNDh1bnVYRUdUaEk5YmhXL1BESEYyTS96?=
 =?gb2312?B?eXRvLzJKbjByWjFtSkNCZUtwbTJZR2tpNU5QYnlzRzh1ajdSRGhqVklNZGJo?=
 =?gb2312?B?dWNBekk3Z21DY2liSFhFVklpbmdpOHVlTm5ja2s0VVJQeVNBZng2YU5WRDhX?=
 =?gb2312?B?WkZFdzB1WFpmK2xuL0RuaGh5ZWJJalBtalZQVU14YVdXZ3A2Z202aFNzVGc4?=
 =?gb2312?B?N3FUMEZBbUR2Mkk2QW1lc203ajVJOG50Qkh0TFpnc3EvWkFScEVldXRzOVZm?=
 =?gb2312?B?SHhKcXZxTE9ob3pwcFVrU2ZwS0k3ek15VzJSVlY3bzV0SjBjZnZLckQxUlpx?=
 =?gb2312?B?dDI5TnlicHFYd0Vid1FYTXBBblBkUEs1ZjFveHZUeElBT1N5VC9pWUZ0aHRR?=
 =?gb2312?Q?CnzNRgXw5xs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?eUFjRlJkem50Q0czTVZIRFNuenFBamd1VGpNZWdQK3VtUUllQWxmVUdsS2ds?=
 =?gb2312?B?RGs1Zmpkdk04VjYxT0pMQlBUdmlRTXg4Smxjek9seDdReVBCWnhxTmcxMEUr?=
 =?gb2312?B?U2hQMHh2VWNtVmVESnhzVE9sTUJxUElWbDlqTUpJaGRKd0dabktwc292NWt1?=
 =?gb2312?B?VFZYVmxVS1ZYY09lNHhyZndnYk5zWEVHYzdVR3ZxSngvSHVseFMrUkk4aEtX?=
 =?gb2312?B?SVRsNlNiY1JYcmNkUzVKQ3NoQVFlWlZrMkd5dTlpVVM0SVpCcWNQeHlOZkxL?=
 =?gb2312?B?aFFDTm1iNkxqOXA0cllXeWdndEhxcXBTRjllWDQ5Zkcvam9tVkVLZkhOREs3?=
 =?gb2312?B?T1RaTURvZm9rcmJFSFlUakVOcnl0d1krTlIyd2dybDVxR2NPZUlYc0dzNzk4?=
 =?gb2312?B?aEZrNkVIYXJzdnhJZkJYZXVlYlZPdTNSM1dnSUpyVnRRRm1uUTlEc2FTclY4?=
 =?gb2312?B?d2VjckNkSkwxaW9TbzZhVlNucXlIRm0xYlplcUZRU2tDUXdNUU1DcU9HSXh5?=
 =?gb2312?B?N0Y0QTQ3eGlFZi9iOTc5a3laQXBYVmlGZDNFMkRvSXdBR0xCSFltYVRpSXN4?=
 =?gb2312?B?cE9NY001MmkyWVJVeVo0bEdaQzVMcXoxZ0M4bm9oQzhnZjBqSUxTcFJhWEVW?=
 =?gb2312?B?OFNlTy8wVGxkeFlBYm9GODlYQ245aUg0TDJuTmZBZk1EREpIUVkrcHVWTThW?=
 =?gb2312?B?R2g5MjdlT3g4aVpWWVlua3g2TE5QYW9EMytveEJCMmFqZStzcnFRVW9KYll6?=
 =?gb2312?B?VTZONGtGMUM2bkFBZ1lnYTdoTDA5UFdvclZCRFpwSUU1VG9SSHBlNWdCY2lK?=
 =?gb2312?B?bVZONFA1aEd3eWdTY2t1Vld2QU4zY0dMSXliRVVQb0IrMVdxZVdiWHlMYXVB?=
 =?gb2312?B?dU95WEN3NmtZNjJHdDdLSzFFczdWY25KU3l5RHNRUmRQRkIyUkZjT1RadUJ4?=
 =?gb2312?B?K3l6OG9NNkJ1ajlBRDlWdmdJTmZ1YldWMXVCL2hqOGE3OXM3SHg0cllOYXZh?=
 =?gb2312?B?QjUxSTdkcldxUk5HYTRETVk2OUNrUHJ3WTNRTndDeTBuNW4zVUNLSjZVUnpi?=
 =?gb2312?B?cFRiVXlKdm1kcEczM3FQWjBiTEFDYnhadGVlc1NpNWo3REFvVWI1dWFNQml5?=
 =?gb2312?B?bzVrbDBFK3BDZjROSlJqVlgxVFJwS21qdFB0T2ZNL3V0VisvNHpyTkFlbDRa?=
 =?gb2312?B?SEtJdGJJK0U0MS9tZWpXelYrRDVxc1ZGVzJ4NEJyUjE3RThnM01SM1lmcDhv?=
 =?gb2312?B?Q3ZGS0pRYmQ2ZjNZWmxyZVNUOThnVUpUdjNKTFRpaWF3amhRY0R1eWdNMDdI?=
 =?gb2312?B?T3Y0dDIwMzZpcmVYR09SNEI4UHZZb3diaG5FTTdxQ0c5dXArUW1VZ3drNUNX?=
 =?gb2312?B?RU0ySnl4Q3hsWlMxenBkbHN3b0IrNkhZbGFyaUYyMlZRYlBKbElvSEQxRGF2?=
 =?gb2312?B?cnd3Q3BCVng5RGRGQ1diK0gxSlZQYUJlWVpTTThNdzNjVGkxWHpVRFpDLzFu?=
 =?gb2312?B?bTRzcFlIY2ZGSUh3NUJHMHVCTVdtQ1pyVFpTL045WEZvTWtINm1XTGhPREZU?=
 =?gb2312?B?UklSNWFEbmR4TGtlWCswVXZVeVd1QXVNVVlkRVN5bW53MzZkMjYyOWt4anVp?=
 =?gb2312?B?ZTlieThMUjk4ZGloalRJNFJFVjZtYmxHNW5lalZvY1BTaDJMbUt2WU9UWmsy?=
 =?gb2312?B?ZGxjd0RPZVB3Y3RrM3BhVEdBemRQbFlPVDJQNE40dUE4bUhRY1NFbEFLOVRE?=
 =?gb2312?B?aCtUbzFtYzRoNzZrcGpFWkhyekFaa0hQTW1wV2N5ME5wSytncEVmVERodkE1?=
 =?gb2312?B?RmFKTlg0M1Rac0lvMUtoQW1ZTHF2R2FZSWFxby90bENWbHEraVhXNHJlRGg3?=
 =?gb2312?B?d2NSQkQxMmZsYzhXMjl0R0VPT3pjOXkydHdqUHg0bGZudnNtNlJtSTRhWG5x?=
 =?gb2312?B?M0Uwcnl5TU51UDNRRCtyWlQ3SWZOSEl3WTVYMVVIZ1RZV2FHNXlUcExockNo?=
 =?gb2312?B?Rk1TZTNGTzlUUlRpdmFHa1hmS0pDSnY1S01rbmxVVDNlSTZYTjVVR3NPL0JR?=
 =?gb2312?B?clRrUk81bkgzcDM3SVBiOGRjNTgvallDbVlUY0lrQzIrSnNnN3NiZmhFcVE5?=
 =?gb2312?Q?tDsQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bf679b81-2d68-46c2-2450-08dd83025ba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 07:33:50.6933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jz/bAezG+wwZ72QZNZp60f6dZkm/z0fHeen6PhjwUga3QAYG00VLa3PB0hlmu3UtZJnbT1r9E+xSU9BMcLyOnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7010

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYW5keSBEdW5sYXAgPHJkdW5s
YXBAaW5mcmFkZWFkLm9yZz4NCj4gU2VudDogMjAyNcTqNNTCMjTI1SAxMTo0Ng0KPiBUbzogbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogUmFuZHkgRHVubGFwIDxyZHVubGFwQGlu
ZnJhZGVhZC5vcmc+OyBMdWtlIFdhbmcNCj4gPHppbml1LndhbmdfMUBueHAuY29tPjsgVWxmIEhh
bnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+Ow0KPiBsaW51eC1tbWNAdmdlci5rZXJuZWwu
b3JnOyBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+Ow0KPiBpbXhAbGlzdHMubGludXgu
ZGV2OyBkbC1TMzIgPFMzMkBueHAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggLW5leHRdIG1tYzog
c2RoY2ktZXNkaGMtaW14OiBmaXggZGVmaW5lZCBidXQgbm90IHVzZWQgd2FybmluZ3MNCj4gDQo+
IFtTb21lIHBlb3BsZSB3aG8gcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGRvbid0IG9mdGVuIGdldCBl
bWFpbCBmcm9tDQo+IHJkdW5sYXBAaW5mcmFkZWFkLm9yZy4gTGVhcm4gd2h5IHRoaXMgaXMgaW1w
b3J0YW50IGF0DQo+IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlv
biBdDQo+IA0KPiBGaXggd2FybmluZ3Mgd2hlbiBDT05GSUdfUE09eSBhbmQgQ09ORklHX1BNX1NM
RUVQIGlzIG5vdCBzZXQgYnkNCj4gc3Vycm91bmRpbmcgdGhlIDIgZnVuY3Rpb25zIHdpdGggI2lm
ZGVmIENPTkZJR19QTV9TTEVFUC4NCj4gDQo+IGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMt
aW14LmM6MTY1OToxMzogd2FybmluZzoNCj4gJ3NkaGNfZXNkaGNfdHVuaW5nX3Jlc3RvcmUnIGRl
ZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1mdW5jdGlvbl0NCj4gIDE2NTkgfCBzdGF0aWMg
dm9pZCBzZGhjX2VzZGhjX3R1bmluZ19yZXN0b3JlKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KQ0K
PiBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jOjE2Mzc6MTM6IHdhcm5pbmc6DQo+
ICdzZGhjX2VzZGhjX3R1bmluZ19zYXZlJyBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQt
ZnVuY3Rpb25dDQo+ICAxNjM3IHwgc3RhdGljIHZvaWQgc2RoY19lc2RoY190dW5pbmdfc2F2ZShz
dHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCkNCg0KUmV2aWV3ZWQtYnk6IEhhaWJvIENoZW4gPGhhaWJv
LmNoZW5AbnhwLmNvbT4NCg0KUmVnYXJkcw0KSGFpYm8gQ2hlbg0KPiANCj4gRml4ZXM6IDNkMWVl
YTQ5Mzg5NCAoIm1tYzogc2RoY2ktZXNkaGMtaW14OiBTYXZlIHR1bmluZyB2YWx1ZSB3aGVuIGNh
cmQNCj4gc3RheXMgcG93ZXJlZCBpbiBzdXNwZW5kIikNCj4gU2lnbmVkLW9mZi1ieTogUmFuZHkg
RHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+IENjOiBMdWtlIFdhbmcgPHppbml1Lndh
bmdfMUBueHAuY29tPg0KPiBDYzogVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+
DQo+IENjOiBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnDQo+IENjOiBIYWlibyBDaGVuIDxoYWli
by5jaGVuQG54cC5jb20+DQo+IENjOiBpbXhAbGlzdHMubGludXguZGV2DQo+IENjOiBzMzJAbnhw
LmNvbQ0KPiAtLS0NCj4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMgfCAgICAy
ICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiAtLS0gbGludXgt
bmV4dC0yMDI1MDQyMy5vcmlnL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4g
KysrIGxpbnV4LW5leHQtMjAyNTA0MjMvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXgu
Yw0KPiBAQCAtMTYzNCw2ICsxNjM0LDcgQEAgc3RhdGljIHZvaWQgc2RoY2lfZXNkaGNfaW14X2h3
aW5pdChzdHJ1Yw0KPiAgICAgICAgIH0NCj4gIH0NCj4gDQo+ICsjaWZkZWYgQ09ORklHX1BNX1NM
RUVQDQo+ICBzdGF0aWMgdm9pZCBzZGhjX2VzZGhjX3R1bmluZ19zYXZlKHN0cnVjdCBzZGhjaV9o
b3N0ICpob3N0KSAgew0KPiAgICAgICAgIHN0cnVjdCBzZGhjaV9wbHRmbV9ob3N0ICpwbHRmbV9o
b3N0ID0gc2RoY2lfcHJpdihob3N0KTsgQEAgLTE2ODgsNg0KPiArMTY4OSw3IEBAIHN0YXRpYyB2
b2lkIHNkaGNfZXNkaGNfdHVuaW5nX3Jlc3RvcmUoc3QNCj4gICAgICAgICAgICAgICAgICAgICAg
ICBob3N0LT5pb2FkZHIgKyBFU0RIQ19UVU5FX0NUUkxfU1RBVFVTKTsNCj4gICAgICAgICB9DQo+
ICB9DQo+ICsjZW5kaWYNCj4gDQo+ICBzdGF0aWMgdm9pZCBlc2RoY19jcWVfZW5hYmxlKHN0cnVj
dCBtbWNfaG9zdCAqbW1jKSAgew0K
