Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2085.outbound.protection.outlook.com [40.107.255.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429932C18C;
	Fri, 30 Aug 2024 02:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724985170; cv=fail; b=tTpSJmLPe+u8kcn12/WkAFwOH/OmrysW3fenu6RyXqmAF7AAZLfr1uNy0MbbeqAPUZZO6lumLXIPp/amfgNZtms47ZQPIC4UqHwEzDQADAYMU0JP6X2gHuRSylqlH5VIVZZdFz8sh6ZeE5ztObezKZXCp0wq8CuUgK3FdPpcHS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724985170; c=relaxed/simple;
	bh=Lk8hru3/Y791MHcJEZX+I5CAXUso3n5GCOQSHjux+kI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XInOjO/dzfCLPOn6oH9PuBOpt12zVOIQe+EqfZAIWOULERQnUS0dZeps4djzOWyI1n0cbny68krDngzyEDWXOfR3j2EFrSa5TaIsnEx5BUdqoJHMTS1ZuwfSXp+6m0/nEg6vxyCabltQSfMCxYrFSuvLeT9V0hWMk2zq0f2K4Qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=iEr3y3ZA; arc=fail smtp.client-ip=40.107.255.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="iEr3y3ZA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sywUvmoh2CRvqFCXI+acpZQ5y8Op2ui6pDg4v1WsouN4BBv5+6Qx4+PksOClHIwbJpIx76hjZRxDiBVSCNACTMV78iY40svlA3ddGj/MAJBtjuizPRIDiroxRAcZCgldn0+mGxFcpHUsfaAKypQxeANTKraNjvkKqmJEvH4UGfrVgZqqyOlejzUkFfaIdmwxoVZotadsnUkr24ZpZz0TrJWH1UdVKztkfTqoXLpyPyJ+87rGE6lF73H7+JVwi3bTlBH5Iqqp3Z+7crSUaFk70kb1DSCSPykwvhoiYcAy+B9IgGsLm6CtFrg/W40Gzz6PfWWqW5CYBIbUoBIkix5ytQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8cRkkhyTMwoZQYjmxjJUvc+d424QcrwpHmrkoCXBLM=;
 b=T+7TpboAgXcysUzLmkxu5TwIbDMrOClXa8RHXngoKeovROVQDUwtL1Dwog4GwTnBRasRT+tAwJQQR9sUuC/7d8jwsnWj/nbyQyYKc7X9+kL/yWOJgMEXI0iv4zvHdDQ2uu/ehzCGe8J3YxdA9Dk+otGWOAkFPwOuPQ12nNi9pMg1W8tdb76p+r1+E5KW07XNDvV69RVRL5oS5jRO8svV0UWDRfiCDAezel78WSRfAQ58AvdyKn9xlneuBczxgc1pPt1q3Mbq6YZ3r0IC18c+0M2PuBPVCCBFbKT7faWVmi2Gd0HUn+a1AyNFXg7W8NXNNuKMSg/Flz/OkF7NgBhVgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8cRkkhyTMwoZQYjmxjJUvc+d424QcrwpHmrkoCXBLM=;
 b=iEr3y3ZAUEJ8V5rQw+qCTjo9CzbklTKloRKmlX3NvSm3yBBBwyq9708G44wV+mWV8g9LBoKKNW0rsjWyUcWbilogig0jnQ0QGMTXX1oucqQuQkWMwfle0rs7GgGyfi8S06ODwDk0/3NxchQv/BrDPWYwal+qp7CysPxs3GwtkJXj7f8deZfoyeHdQovOGmaI/zZLhGww3eqeZchjgGSPkb3tDZiLGiUxp+VhM4BR9+UIMYYa1Znp92YnbzTs01XkurxyCxlHk8cNL0jY6J22DQfErv6hamix1E8w5VbobnuGWxMXwsKA2gO3jw2ZBUX8yRNEgSC1eCR1JRbBU/KtRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5178.apcprd06.prod.outlook.com (2603:1096:400:1f7::12)
 by KL1PR06MB7288.apcprd06.prod.outlook.com (2603:1096:820:140::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Fri, 30 Aug
 2024 02:32:42 +0000
Received: from TYZPR06MB5178.apcprd06.prod.outlook.com
 ([fe80::f6de:c016:c33a:318]) by TYZPR06MB5178.apcprd06.prod.outlook.com
 ([fe80::f6de:c016:c33a:318%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 02:32:42 +0000
From: zhangxirui <xirui.zhang@vivo.com>
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com,
	bastien.curutchet@bootlin.com,
	festevam@gmail.com,
	imx@lists.linux.dev,
	jh80.chung@samsung.com,
	kernel@pengutronix.de,
	linus.walleij@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	michal.simek@amd.com,
	nico@fluxnic.net,
	orito.takao@socionext.com,
	rric@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org,
	sugaya.taichi@socionext.com,
	u.kleine-koenig@pengutronix.de,
	xirui.zhang@vivo.com
Subject: Re: [PATCH 0/9] mmc: convert to devm_clk_get_enabled() API
Date: Thu, 29 Aug 2024 20:47:50 -0600
Message-Id: <20240830024750.2908738-1-xirui.zhang@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAPDyKFrN9L+u_X7Ur+j--i-tewd31EXzwCojOP+Sxuyxpk4Phg@mail.gmail.com>
References: <CAPDyKFrN9L+u_X7Ur+j--i-tewd31EXzwCojOP+Sxuyxpk4Phg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:195::16) To TYZPR06MB5178.apcprd06.prod.outlook.com
 (2603:1096:400:1f7::12)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5178:EE_|KL1PR06MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 55008c2c-bdae-4bf6-4b40-08dcc89c05e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzkzcmhQQXM4bEx5WDhnb0hpY3E1Yy9PUDBtWkxFRnJOTC9RMEVXdVF0WmVt?=
 =?utf-8?B?TEl0bEY3c24wcEpjNUoveURtQjhteFdndndUa3IyRUtSemxnYWVweFdoVjkv?=
 =?utf-8?B?ZStCYW51dTU1aTJudmRUQmZTMFJTTythR0FlUFhwT25aeUw0Y2t1L3R2TDJt?=
 =?utf-8?B?MkltWWNwSU1XVlVsaUtWL1hZOHB6KzU1WlBvU1dpTHhJOWhDS2VHR00rMWVT?=
 =?utf-8?B?amQzQWJEdGxhODdkTUI4a1MxTDREc1g2bE55SkMvbTNSVXh3di9DUWcvcjZh?=
 =?utf-8?B?bW1jRldKb1ZLNXFKNjNtdGRicTNrR1EzRXRUZFp3RW1QbGV1MWhtYklCVFRj?=
 =?utf-8?B?di9wMmRZdUxPY2FOQStSb1dzUDNxWTZrTGdFd0owSFJNODc0ODJtbFVlUExU?=
 =?utf-8?B?WUg3VDVSTDhBdlh6d2hTeHpLaGtTZGZ4bldoRGVKSVBlWVdTaHEzdlJ4bWZD?=
 =?utf-8?B?TWlFUlRBU2o0bmhEcE1FaVZCNGo5Vy9jdE5BSW5JOTM0a3R1WVNnRWVFYTVh?=
 =?utf-8?B?K3ByRzhOSzBobGp3TmZ3OCtwUDF6Sjl6WHJLMFdCdDFDWkYzK1ZmT1ZlT2Fn?=
 =?utf-8?B?UWdpNnZKb25HUVZhaG0zbVlVWnJxUWZTY1BEK0JTWFc0SkczS09hYmtpbEtS?=
 =?utf-8?B?Nk42c1VTZnV5M28xWkdkQ0xiODlWcTFKL3plMWZ4UU1PMUFmYkRrbklkUU4w?=
 =?utf-8?B?RGtubWR2WVd6ajJNMnRIY0V6dkZoTGJJNWI0ZVk2bTNiTFdnMkRoMkg0ckV4?=
 =?utf-8?B?STJvK05SdGdtdkUzb3F0QWNMNU9OMlZ1OFpaeXRpQVFpNDN2NHJSMzR4TlJH?=
 =?utf-8?B?bEhwOU0xTFR5OXZOeWdvWW5iSkdwSHdCK25xck04YWZIZ2ZCSnArVEtDUXJ0?=
 =?utf-8?B?RVNsdy9pbXBtcklNZE9lV0lMejJ1dHdKcFNIRTFNV0wyNXJMNjJMWDRMTi9Y?=
 =?utf-8?B?TWRWNmxTS0h3NXVpOW5zVitudnh0bUFvRk9RektsaDJESVhhc05kOG9RN3RI?=
 =?utf-8?B?cUNLanFtajJDOXkySjJhZmduUll5RUptQkJQa1FteUs4YldpWkpoU1lMWWl6?=
 =?utf-8?B?OGJHbExZQWJQK2g3czhlK0FsblliL054Q3F5UWZjaHR2Qlg3YVFYbEZIZVdH?=
 =?utf-8?B?bmxUejNsL2VaWWtYS1o0ekx4S0UyenRodWlGQkZmc1VIMWdGTEV1TmJ5UDNX?=
 =?utf-8?B?UTh1UktnSEM1SE1lamdxSTFIVU4vTlZmSGlWQUgzVVhsdHoxSEwxdnlnbUNt?=
 =?utf-8?B?cDNEODVEVWxXYVVpSEJIRnNTODJBa3hJNm45V3FXRXZzd0hVdXNPdUVCVU1h?=
 =?utf-8?B?MEo5MjF1WkNhY1NESk9WMXVNa3pRbk5qeHVPdURHQjdyQXFKRzFnbnRlSllF?=
 =?utf-8?B?WUxyRm44Qy9XdVV2ZHpSK2ovZWFTb1N0Z2lpbURCckNiZXZoaVBISG9abDk4?=
 =?utf-8?B?cEpsa05LVEwxRWcvdFIwU2NlK0JlQ1NRNmo0Mm1tN1FkL3pBZHZaYXhTcGRa?=
 =?utf-8?B?TDZtOUFmQXlxVDRCMGxaWFJRdEtGV21sTEMvRDF0VVNhKzJoY1hoT0RMc3Bt?=
 =?utf-8?B?QVNLdTRJekp4MW83WDB1RGIzbGgyeERUclJzNzJPVU9NQkpWQ2djRUpiR0Uy?=
 =?utf-8?B?Ri9SSTlHTjdzb2Z5azUzWHFvVUZjZFpwbGErUEFGdk96dWhaSVVMUjJHQUl6?=
 =?utf-8?B?bkFHbXF4a2NQTE5KZUdGa1VoMFRrUnpSSUkrQnFhTm1JQnlBTWRBMXp6eHE2?=
 =?utf-8?B?d2NjUnRKYUhIc3pvblNIcnpMdGxTLzlUZXFBQ2tJbEtrQW12OEQ4Y2ViTi9P?=
 =?utf-8?B?enQxeVQwQnNWTE5WN3lOOWE5TkVYcEc0WWNYcXZtSWlxeWgwKzVIV1RINEg0?=
 =?utf-8?B?cmxZWjJmQkdGWFlPNlNFNk9PMCtqczFWbm5yU2dJZC93bUxGcWE2S0t3RnVj?=
 =?utf-8?Q?b7UnmHUuwgc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5178.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHJOdjlIb3dSa3g1NGVMRmFPd2ZhcnRScUQzOHpROUIyZVprSUc3REJpYzla?=
 =?utf-8?B?VU5GTVcwZTZJVkFTMWZGek1wVU1Oa3VmRUxoa0R0RWk0L3E5S2YyRE5vaEF0?=
 =?utf-8?B?eGdDemxPRm5BaVJJRk5KR2ZkUEpZVk5vcS9WWUtFa3F1V1pubWRYalBCbTQv?=
 =?utf-8?B?N3dQL29KdDRxWEJJUU1CTmM0MVNjREJPcFhwMUZoaGxYQWphcU9lYnlyV0lF?=
 =?utf-8?B?S1ltb09DNlp6T0JLaURUMFFqQ21tdmNaQjd3dk5XRm4vSHRTVnYzRDYrWEJo?=
 =?utf-8?B?VzF2bkNiSWtsajl0RlN2dklkTFYwSmtnME5DZ0JjNlNnVEtYM1pDdWw5ZUoy?=
 =?utf-8?B?bHBVTG9VUkN6N0FHdWwxTk15WXF5MHRTOFc1NTFRMVp5Rk45WEViUHA1TnRL?=
 =?utf-8?B?YlR6V0x4N0hPb3p6YklmaTMxbzZGQlplQjVJSCtXQng0em01ZDI5U2dQbC93?=
 =?utf-8?B?Zktkb1RJSGJRMi9OUVk2eHFEL2ZPSDFERGluRHI3WURibHRwUVJPYW9EeUV6?=
 =?utf-8?B?c1E0UWpSZHc1VEFIdGwzK3FXZjJzRkdSMlFLU1lTZ0RhUmQzVFNRcVVYaWh4?=
 =?utf-8?B?VVd4NWVGSWhKOEZpK01PUURNSHgzZDZKMC94OHc4ejkzOEJBM1RVNnpqbFVy?=
 =?utf-8?B?cXcwWU5pWVEzUTROcXNNY0RoeUEzdWJKampYZ0FuRHRPRjF2MksrL2V3aE5C?=
 =?utf-8?B?T2N1endrT0huRU15TDU4QklIQm5jUDRVMTlOM1krTTFNa05Edk9YK3NBREdl?=
 =?utf-8?B?cjMyTXpPczNkaTNpaDhGLzhCTDROc2dxYllqbUdCOTdtK1ZBdTRwbkpUQTJH?=
 =?utf-8?B?bS9FVElVa29pTE1ocm5mWGtDcDQyc3JlTEpBWU15ZEJKNmhmM0xxb09xL2RJ?=
 =?utf-8?B?SkhaWUhNb0FxQTg2VVNUdVZ2N1ZacjdiWS84M3JTTU4xTWcrQmIyOTlKMnNu?=
 =?utf-8?B?a0w3RWM1R3haOTBkSmpPVW1mRHE1TWo4Tnh6MUsyYVVuSmdkUEJHNnZOVm1Y?=
 =?utf-8?B?a0laaE0rUmkyZjlxNmJqSS9xQmZJclNxRmxxSEp3Wlp2SlVrK0xCZndLQjhG?=
 =?utf-8?B?VVB3NXdjeWxtM0J3MU5JQSs1MytyYlBCeWNMSldjeUFPU1BXS0VEZGRLUTA3?=
 =?utf-8?B?ZklYNXd6S1YzcXY3bldCbW9KaXBTZXF1V1dESThtcXNUY2RLdDdobllvRzJr?=
 =?utf-8?B?cVJlS3lzVDVDWFZneEdhK1lJbHAwa2o5VXIzbkVkYnF5aFNNUXprcys1LzBo?=
 =?utf-8?B?MDk0L3hlNmZtbGxZSGg0cUlSaHRuYzVrMEQ1bGJWc0ZaOS9HcTZKSjU5a0Vm?=
 =?utf-8?B?dFhGY0lhMHRmcFRPZUNuV0FlazlDTFo3L2V3QmlvbnNNRlZVZDNsNzVWaHJt?=
 =?utf-8?B?U0dNL29nUlRqb2xZcDIzb2R5NFcrdktGcVlHeE1vcTFkWEYwd1o3cTl1Qytr?=
 =?utf-8?B?SHd6WGpYQmViQ2V6cEQ0TjlwbDJJc0ZkSlh3cnJLT2hPZVNITDVNRzUweWNi?=
 =?utf-8?B?czhTZkxFMXh3UzFaZVl5SU14TWs3bnVxV0x5TDUvZXFqNnFic2U2bzVRalh5?=
 =?utf-8?B?OWRmQlhsWk14S0IvZ1F4dncxYnhqeEpSNWNpYjI0TUVrLzhsSzc0Ri8zenc3?=
 =?utf-8?B?MzhnQTBTaVdJd0dVUURTNlM0OFUycUtpbU1VQ21uRThhbTdmeUZjYURJR3Ex?=
 =?utf-8?B?TE1ocnNEaUc1aWNEUEFnMnpaOXhTMnRBSUZWYUJGSml3L2syZlZCVjBCWU4w?=
 =?utf-8?B?M3JoZ2lMTjhyYm9scVd1S0dZNmxjNHNGZmF4TW1jQmhXUGU5Sks4OXhSQXVj?=
 =?utf-8?B?TmliblZ3cWpydnZBZ1E2TWU5QjZSRUF5NGdNTExGdGxFbm5ja2pCTG9jWjFw?=
 =?utf-8?B?Y2FDSVNyZzh1a1RZd20yNmZvditibUFsMDY1UXpRYzdtZXNGdVptc3JMR0o2?=
 =?utf-8?B?Y3BWNWtzS2g3eGJHR29wZXRTSllCazNWZVFEYUtIS1JTOEo1UHMrUlo4Q2NG?=
 =?utf-8?B?MDZ3YnFpRFA3SjNYNzlWYVA1Mzkvd25yOCtVbGJGaWRCOWZvMjZISUJtbTM2?=
 =?utf-8?B?bUJzSWVHRWd5aTFJYVFQNzJrN0xZaWlYY3VTckppQkVLUFNMbmE5Z2lKNUF4?=
 =?utf-8?Q?KbFfVaM7f5vktSJ4zsBBqpV1c?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55008c2c-bdae-4bf6-4b40-08dcc89c05e5
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5178.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 02:32:42.1792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25EgtvvA4fQFCMMKkkEbOPyEOjT02X1v4NHYkhzkRvzCUsiPJnMgxEpewUcMjebhcSOr0I5SCSUZL9HAQCrGow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7288

On Wed, 28 Aug 2024 at 17:11, Ulf Hansson <ulf.hansson@linaro.org> wrote: 

> On Tue, 27 Aug 2024 at 09:34, zhangxirui <xirui.zhang@vivo.com> wrote:
> >
> > This series use devm_clk_get_enabled() to simplify code
> > and avoids the calls to clk_disable_unprepare()
> 
> I agree that it simplifies code - but it also changes the behaviour,
> in which order clocks are getting unprepared/disabled during the
> ->remove() phase. In other words, this needs to be thoroughly tested
> and not just considered as a trivial cleanup series.
> 
> For example, if there is a PM domain attached to the mmc host device,
> is it really okay to allow powering-off the PM domain before the
> clocks are being gated? This could potentially happen if we apply the
> $subject series.

Thanks for the reply, are you saying that merging the above patch will 
lead to the following issue?

before：
bus_remove -> driver_remove -> clk unprepare 
           -> dev_pm_domain_detach
           -> device_unbind_cleanup
after：
bus_remove -> driver_remove (delete clk unprepare) 
           -> dev_pm_domain_detach 
           -> device_unbind_cleanup (devm_clk_get_enbaled ->relase(clk unprepare))

But I think this issue is not only specific to the MMC host, it will also 
occur with other devices, if there is a PM domain attachded an use devm_clk_get_enbaled API. 

So, can we solve this problem by swap device_ubind_cleanup and dev_pm_domain_detach ? 
clk unprepare -> power off not power off -> clk unprepare

bus_remove -> driver_remove 
           -> device_unbind_cleanup
           -> dev_pm_domain_detach 

Thanks.

> >
> > zhangxirui (9):
> >   mmc: cavium-thunderx: Use devm_clk_get_enabled() helpers
> >   mmc: davinci_mmc: Use devm_clk_get_enabled() helpers
> >   mmc: dw_mmc-hi3798cv200: Use devm_clk_get_enabled() helpers
> >   mmc: mvsdio: Use devm_clk_get_enabled() helpers
> >   mmc: mxcmmc: Use devm_clk_get_enabled() helpers
> >   mmc: mxs-mmc: Use devm_clk_get_enabled() helpers
> >   mmc: sdhci: milbeaut: Use devm_clk_get_enabled() helpers
> >   mmc: sdhci-of-arasan: Use devm_clk_get_enabled() helpers
> >   mmc: sdhci_f_sdh30: Use devm_clk_get_enabled() helpers
