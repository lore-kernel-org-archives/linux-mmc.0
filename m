Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28C714D2BD;
	Fri,  5 Jul 2024 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187248; cv=fail; b=SitraL5s1zOy9to9lGptgPEyeJxXPhKHcSSH2sGpqSMnvclVddMxLEmM2IML8yf8huslvfGRtVG1L2a3sV0/KIwC9tiUJAq+sq5ksgOW6y3Ew1D0nZEjgl4F06F8OWc2su/rEBbbz4OS2tkbgDYZC1sk0rJEV5+YomV9yerByOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187248; c=relaxed/simple;
	bh=WA3wpQYMiw+SuvwzzQm8hfOQzI2ldcitSNgjB50H6Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fwG5pQdM0+9PupmUWMNICoMlpNk0jp6xKWgy7jR1eETKWBLzIMMOR8p6/nOLrRB4zSYfPhkxRpIxrQcqQnWL4GN/8lMhrrHUb01TKA7BjeVVKpYwWkm7MKyWlr5F66V4y8ttQOFfol68i1Wc7vuftEHVuqRBehtqWxAEddrvUf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WLPu8z3s; arc=fail smtp.client-ip=40.107.104.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WLPu8z3s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYfpsC7WdcCcxAbFXc6M3XF92GM/6VXvpnVmBK9/DXmqfptKGWL8nPp2eWdws/Vk+GRAxUvkXNjumv1uGO7tNDGHwnqtFbCB4LZ9GQILxRDmNsU+beehR3BCjtIr5y7w0c7zXJCSqw6LdU8knis2YvRkEZNhFDp4SC3y0P+zPr43NnZnSm/PTdJiFXDxah2pNFZTkshQG3SeOSVQQIwKmnZaRXhy9EQztM4+ZvvH3VQ5TG857KieLYIYPGmJYjI1hvVvas2/coxdOISm/ZA4s4KBCTRhEozE2F0v1VMVhkS2y5XToP2IJuLeZV+wgWt2FYoJnXxaragmQX/CFAwe7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqXn2Spewu7hks/6PVU+Dt4N+nV0Zeg0eP7GR31+71M=;
 b=nJ+1fEKiSWsJdRHtzIaW30qygfYyIdjkf3Zszo6IyXEFSvuok7eWIkEcJXBv7hQIdxfY50uQ+w5ZKt8issnGFKrbvNfSrrqhhq7aezxedw/BjA7iFd39uRdKhF2tZ6wc+qOKNvsc+uAy0YkeVLDE9G10b6Nyih6UMCboOVT6gTWgIIF5CxEESAxqMmXaoLiJr787LGW3cMLAg6rpbivbdpadapyBYZv2eX3tngUxSiaUuyUl2Fdo7fmgibuAAU6CcJKYo6BiuhOzKEIlgIPoxb0GdcqOK8Ceq5DfFul0QQZS5TQEv+X+88tuundAsR1tGSQiauSmdhobgDADdRVDdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqXn2Spewu7hks/6PVU+Dt4N+nV0Zeg0eP7GR31+71M=;
 b=WLPu8z3sC1GUqmGsuRULbl2yguAEtWHFhCx8qwDis9/AKOIte7lLj1ETGLaER9QXqiQkYlBribj4gMo7R/IaYQ/34yb4Om2wgY9ylR053hJ9TJ+vxOsBiVTd28dnmiqpjWpgoRJE1pP7cXTO0uo/o6hySHrZOFnI1J4AU+DnDro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by GV1PR04MB10244.eurprd04.prod.outlook.com (2603:10a6:150:17b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 13:47:21 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 13:47:20 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	s32@nxp.com,
	Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH 1/4] mmc: sdhci-esdhc-imx: disable card detect wake for S32G based platforms
Date: Fri,  5 Jul 2024 16:46:44 +0300
Message-ID: <20240705134647.3524969-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705134647.3524969-1-ciprianmarian.costea@oss.nxp.com>
References: <20240705134647.3524969-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0033.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::6) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|GV1PR04MB10244:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c9e5d8-9f4e-4f4c-e42a-08dc9cf8fd7c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R25Jb0FGVG5NNnQ1UmdyajNIQ1hsU3Q3SUdJV0pWRjhoZ0VJSThGU0RPY2h1?=
 =?utf-8?B?bjlkZDZhRDFSdXZNUDg2a1Z6T3JVUG9KYjZEWWF6bzZKVjkxUVkyL3ZoMlhi?=
 =?utf-8?B?N3YxYVB4ZVdFR0FmRkF3SDRMK2Z0TXNXVlBOcXBOSGNLV05YMTlTOWRucldW?=
 =?utf-8?B?QlQ0UlFUSVBGYktzZlc5QXozbWNhZjdGWEVjb2xxQit1SmhmQTBXY0ZySkxp?=
 =?utf-8?B?WDVLMk43QnJSS1dSa1BUT0JkcHFQY2pwNGhMWWFNZzZJbVZIMTRBMFBxaUtD?=
 =?utf-8?B?RzZHbEY3LzUzU2tRQi90c1poT3NvTzh0emZoa1pKd2wweU5SSXhsL3djNGRF?=
 =?utf-8?B?Y2RkWmtWMWw4NXFKVEdqOUtLeXFoejlLcFdUbnBIa3lRN2lLeGNEbWZEellR?=
 =?utf-8?B?enZNY1cvSlRKK3FkTTJPM1BmRTNwQWRaYWRiKzlDcWNzNTNsUUpwaG00R1dD?=
 =?utf-8?B?WCtac1d3SENqZGN4eHJSMndtQ0laYVg3RWJJaXFYWGJ2bVJOSDhRMlZGVndW?=
 =?utf-8?B?KzF2aGQ2YUNlb0pXNHIyTEFPNXFydUJiVzNwdHVkYUVJRnRNQ0QwQ0lNS1V2?=
 =?utf-8?B?VU4yRE9GQ3JpVFlQNUxTTmJZUW5Va0J5SCtUNHlzN012TUlnT3NlalluTjBJ?=
 =?utf-8?B?dlNtSzZObm92UU1pQzhFaDNIbHp5Q0ZqVHEyTWhMUEVTdDZoUFROTXdqZHB1?=
 =?utf-8?B?ajZSMHB4K1hraWVoaUxLWkd1M2hnazJNYk5TeU9pRmpEYzJXUzhrYURaV2Rl?=
 =?utf-8?B?ckwyay8zL0w4MlF5Q1NpSzhIbncwd0NRcW5rL096aUN2Y2t2OUROWC9BYmxC?=
 =?utf-8?B?blYwcERYTlVFeDRzN0tGRWZ2YUw5bVBHc29zMkducW16MUpQSWpBd2JpK2FS?=
 =?utf-8?B?VkRwdWJyNGFaeXdyRzkycGJEaFcxQ0N4LzVMUzhzSEpyKzIvUFBkU0daTDdh?=
 =?utf-8?B?MHFraHNmT2MvYjdsbmRWYXNhY3kwRkN4cFBHZVo4Rm9TU1YySzhrN3F3ZjNi?=
 =?utf-8?B?bUc1RkcwYUJpTkZydXlRQTNhc0JaclFYTkxQcjY4azc3UjNBUmRWVUc3TCsw?=
 =?utf-8?B?ZTBWWjFwdjJic1ZIMXlYOFNOKzI2eGplWmZsMVRzdmh4c1J3NC9LVmprUHNa?=
 =?utf-8?B?ck9NMW1tTnFvMjh4clFwM0ttTlM4eERVaEM2SUxwTVlsU0wvWWxnMk9VMU5j?=
 =?utf-8?B?M0pvZUZLSzdJcnc5SVRvTVNUY1JkL3ZyNkYrWmZ5WTgwaWNHSTBVT000cDNk?=
 =?utf-8?B?elBaVDFGbkw1YVdMVGRtajZnclZYMkN0QnplTUxyR00vU1pwcFRSK05TbkFk?=
 =?utf-8?B?Qjl6eXdZQnRpMXp5SUc4VXlndFR3ZUtKV1drS0NnQkdUZ1puOG5IOGtsZ2Y1?=
 =?utf-8?B?b0VKNVI3cHg3UC9rQW9CNzNjWGhWMWEybDFQL0tsakJGRlZQaFpGNC9tSlJ0?=
 =?utf-8?B?M1hSMDdDRUU1MGxua2JVbjFKWHpURjZ4OEhZL1libWlaYW5iY2VBdzhSZW91?=
 =?utf-8?B?NVVOVHRiaXJESDhYcThDdThZdEp4OUNyNzJPYXdJM2Y5aU4vcUhJb3V1d0Vh?=
 =?utf-8?B?ajY3OW5BZTVhNmZXaFc3NkJkSWcyazlBcnhSdUhRWmU1aGt0UXhQLzdWMzQy?=
 =?utf-8?B?TnBNd2N1cTVUWS9UelhOdGdnVzNRanpIdDU2L2c4elg2c2FFdkNHK3U3cHNx?=
 =?utf-8?B?bTFHV25wMHhLQTdyMHBTR2I3YlRFOEVvRW9uRVZLb0dyc25pMGhLOWVobHpw?=
 =?utf-8?B?NmhOejVCNnFEcjI3SnBjZGdEMmpxcTNqSmhnelBpbWZINmEvSnZwRkJhbTNY?=
 =?utf-8?B?MzkwSHZmbjhHd0x6Y0wwUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2FuVFZLem4rcU1oU0JIZWhaaVdZOCtzZUljTFVCcENwK0IvSjNmNWE2NmEy?=
 =?utf-8?B?dHVRTXRJYW9uNnJDVzltM05zeE5lMlBjYWVHOVQrUVRyTUE1SDBCZ3pEWEE1?=
 =?utf-8?B?UUNjRkNKSXhZWGFkeEk2SEZadWVFSzRQQzJ4c3FpSzhwTnpUV2JlbG5yeUJ6?=
 =?utf-8?B?czJmS05adDU4Z0VHMG9MVStqVzF3MXRweXZPUzFLeDdSSlVPWUZ1ZGtIQzNV?=
 =?utf-8?B?bk9MV0NBZy9IbFdPeTVjSFJaTzNGNzlzdkR4c1VDaEkrbGRpRHNGYVBnSWR2?=
 =?utf-8?B?aFRqbWkydWV4eU9vMzFUclZxVUFqYUZxMUhoQkF1VTg5ZWVUcmsrWjlVZ0Mx?=
 =?utf-8?B?aHN2RDZHU1psc3hyb1BWWm4vaUtsdzNLbkh4NlZJazZDVEFWTGwwYnFJVm9Z?=
 =?utf-8?B?TUd5dzVxWm9aa1ZWMW0xNFo3RmJ0ZFFJRUZITllNaEYrZWVMSXZoVHozQkNv?=
 =?utf-8?B?bTljMzFMQ0pYLzlIejVoR3EwYVZyanZwUm83VEIxVTFDcm4wV2t3OUtZelRT?=
 =?utf-8?B?WmF5R3JSOGpRRXRZMTlmR1NaQlZFdHlvY21rditzRUVyUTNkVytSYXlWNW4w?=
 =?utf-8?B?UDRpd3BZK0FaazZQemVLN2xCVExCVVFRM25NQVJ0NXlrSy9ROFdDRzMrMzdk?=
 =?utf-8?B?WDcvd0Z2dkdFa1Jhd1VBU2Fja2cxYlVQcjJzR3kwZGRTcit5QzNJeUpsVW1H?=
 =?utf-8?B?MFJHeHphSmVXTlkzbURNQWVuYStoeXF4QXBscTBRYW4yOTNwVEFvWTBHMXdH?=
 =?utf-8?B?em9ZMXlmVTdKbHZabXJKM3A2RWlJZE1Yb2RmdVVEUENrci9NRTcyTFN1VlRI?=
 =?utf-8?B?K0Z2dDhzYW9rczNRc2dZMjZmYWtOb3J2M210U3NteTQ3ekcwRE5UZEM5ek8y?=
 =?utf-8?B?WEk3cThpeEpScHFxQ3pmSmM0YWRUeVRISllEYnJyWUJ4K0dvTnIvSEFFQ09B?=
 =?utf-8?B?UCtScUd1ck5sYlpMeExBMXAzODExN0hVR2xPTWp4ZFR4TlM1TnE3dUtZQWp5?=
 =?utf-8?B?RHQ5U0xadEZpamNSd2Fmc1MwM281bzBnWlBvaGRLYms0Tk5vMStLcExZVXlF?=
 =?utf-8?B?clUzdXRxRW1KaFQ0U25CaGtmZWVzejZnb0dSWkRkM254MXhuVHM1Ykh1MDMz?=
 =?utf-8?B?Z2QwYnBFRllKL0IveWVTWW9Bd2lDdVpsYUpKM3hUWWpMdzlPcHRJaWp1Vlgx?=
 =?utf-8?B?d2w0b2FTc1dBS2tpaXl6bWlUYzdQRnBsMEY5cWJyRVFBc0ZYVEtlYmVqem1p?=
 =?utf-8?B?cFYyRnFCRlFLTjVVZExJb1NGVXdQWXVFSkV3bERVYXVaVWhiOXQzZkN3Rmd0?=
 =?utf-8?B?RUZkaU9SNWpNdmxlbDhKakZ1MCtvd1o3SHA5bjliekIzVTJOTUgwTElyTW91?=
 =?utf-8?B?Yk0xUkVSa0g5OHhVN0hWOUEwYlhMZlI0M1ZmTDl3aGhRTjRUeTRDOEpDL2ds?=
 =?utf-8?B?UEZpYy9aM0I0MFZEWW1FQmFvMzlkVmR2a1hidVA1Q2gyVHYyMlpodlBtUFpj?=
 =?utf-8?B?Q3AvZlorSXBnWmV2SEF6M3lSVXQwZU01UWpzOVd1Z0dOMnZMa1lyQXhEbFUr?=
 =?utf-8?B?bzB6SGZKYmZGc2RPbUd6OEo1TUFlVW53T3ovb1liU1l4Vm5XRmhUQ1VGYTRa?=
 =?utf-8?B?ZWdyei9Oako0K2hXUzNzbVZmTEFrRC9LV2EyZnFwWXhwTTk1S1dMOUtUemk0?=
 =?utf-8?B?V0xDUk05aGVRNjZobFU1S2dsZ3pXYXI5TDltSkg3YXpTNzFCdzFkN3IwM3dW?=
 =?utf-8?B?Ly9wT2NrREVpc1RCNnBKcy9zbHVHWE1KY0cxZE90NE8wNHJDTUMxREtaemRR?=
 =?utf-8?B?S2dieWYrakhFbEkxOU9BdHo0MHk3TW45Z09vNXVHMDFTandFM3FOTG0xb1ZL?=
 =?utf-8?B?R05RRzVhVThyNHBTb1VySVMxT2U5a282M1I5UndHWkhXU0Y5b1JpQWZmK1pE?=
 =?utf-8?B?L1o5YmplK0REYTFsc3M4RTN2SVZhL2RQNkR6Ymg0U0RJYUp5REVrV0J1N1p0?=
 =?utf-8?B?cnQxSVFyYytaK0VoVVY5WXRRTUNIaTc1RlBGMEVJYkprRkJ6ZmMzckM5N3ow?=
 =?utf-8?B?QUtXQURBb29NMUM2eTRVWmNodGtFR0szMmFJRDR6aXQ0dUlNM0lESk5Edmpm?=
 =?utf-8?B?aWpnUE5rK1M1KzRaOWZhTjEzVkRxL2Zkb3pialhYN0l4c1ZnQ1RON0p2YmM5?=
 =?utf-8?B?U2c9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c9e5d8-9f4e-4f4c-e42a-08dc9cf8fd7c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 13:47:19.9254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YVOlZxA7dC56B8CAMjFRQatOyd6cvIDzpmXEpQv3kfkwv9DBMAmd/0XlbgGDOiYt0ZEfMDT2+slZ5tHSqlR+sBYQh7Tg+wIrypNZ1FwDz6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10244

In case of S32G based platforms, GPIO CD used for card detect
wake mechanism is not available.

For this scenario the newly introduced flag
'ESDHC_FLAG_SKIP_CD_WAKE' is used.

Signed-off-by: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 40a6e2f8145a..21d984a77be8 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -201,6 +201,9 @@
 /* ERR004536 is not applicable for the IP  */
 #define ESDHC_FLAG_SKIP_ERR004536	BIT(17)
 
+/* The IP does not have GPIO CD wake capabilities */
+#define ESDHC_FLAG_SKIP_CD_WAKE		BIT(18)
+
 enum wp_types {
 	ESDHC_WP_NONE,		/* no WP, neither controller nor gpio */
 	ESDHC_WP_CONTROLLER,	/* mmc controller internal WP */
@@ -298,7 +301,7 @@ static struct esdhc_soc_data usdhc_s32g2_data = {
 	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
 			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
-			| ESDHC_FLAG_SKIP_ERR004536,
+			| ESDHC_FLAG_SKIP_ERR004536 | ESDHC_FLAG_SKIP_CD_WAKE,
 };
 
 static struct esdhc_soc_data usdhc_imx7ulp_data = {
@@ -1726,7 +1729,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		host->mmc->caps |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
 
 		/* GPIO CD can be set as a wakeup source */
-		host->mmc->caps |= MMC_CAP_CD_WAKE;
+		if (!(imx_data->socdata->flags & ESDHC_FLAG_SKIP_CD_WAKE))
+			host->mmc->caps |= MMC_CAP_CD_WAKE;
 
 		if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
 			host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
-- 
2.45.2

