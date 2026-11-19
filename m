Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795081547;
	b=RK3N/3UaV3tSfgryciwf1rPDbqy/RqG/K2ffcrQeDKxqqiGfPFcOza8vj1MhWxokSTH7
	 ii79/KqAQl2qsHVCbscPCR1IKqZwwxjBaKrYqpDA67/lPxMFKDa7jgiy9SNsGz8Xpd3JT
	 p1XcwcBxxcf123IsJYJYqyLlfTonDQ/P7z+TXvKt+dYR17p5FL2kLleLTqHl8IU92G0jc
	 xhgj4fvPKngb84I31IuFhdNz+Ehf7BzcUhE3XDPiFVxHwLjt9IQ6D93HVEMjT3ZzHVDz6
	 cQNaMglvr1AbGYEBSMlktb+ec6tR+rS2LSUh8Bc/QHYutb1WvgFv3b3YSFeXM1JxmPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081547;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=3J5cBs+9d3aQnyAQqLt35rCtokIOt4sFe5+IBM3QZpc=;
	b=soX6aIhKTSuv+25WBnDcu9QJIGFC0h4YLdxYu0vV7Hwqd71rbUXcDvgl6MCRunXAiW6e
	 2fMcmiPaUz6m31qINzJ8Q9teFG9mTlHw6GmOEtC1KJdZ8Tp/KHttvRXLFNrsUZwaIYKGx
	 Nnuq409lEGimTu2uFKg1nIwcq6pqAXtb65eGPylG7J6EOreOQsksiE/G7hgff7UvVe0Ej
	 20dyxCTDV1tpDj39yzTiA2j6e2O/WGHR/5enfXyqjRbb0Dk8kSElz/qIUr9qxVRdD4QSd
	 gwQHpLM8Y3RWAcPaoWcnAyDOu+7XQRazvKLt8OxN+EyNwXpvkfb+DKW73o2WxU8t2Ew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=WMXtIaGH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.23
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF36606A32F;
	Thu, 19 Nov 2026 09:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AF36606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=WMXtIaGH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DiuRRRX32LkfMHvmlMIt6TiqyWeKfO4J4q4F6NBnFRh6rmd05BEobcLzs8jtP/4oNfZZwUWTH0kADVRWORhCYCTQJUqSL6aWVcIj4jBdosOF+kpZjIhPpI4sT+z5l9j9yNpRpWnwHmsITi1V8VLgE9NQWP1j6MpC3XUHD74Sb6qqBLbdLwTjDPh+3Axl7oOipGWscemOhRo8dJdA1G/tpGsczctwei9kQvwYtxDCn6SpMXgh3RBTNeeHS084v5tXQ/N0nN65jcQaiHugVVqQhQhcnbSW26imGy5ogXyQumJrd0QZihQLZmAEOi4u2K4yyXgWjhGEqWFIa4Yco8z7+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3J5cBs+9d3aQnyAQqLt35rCtokIOt4sFe5+IBM3QZpc=;
 b=CvgUsUHpITOAuJM+jc0QDzd2lgeyoCtnhh4dRtJo8PQkuO2zPIhAou8c5ZRnNigJIfQKojIhfqhXCjCE+t4abYBn0jd/vEqz2kq3ud8EPNdEOXhYQ+N1Zyqwau1Vasot+cqZAZLxMlrFUzGaPedUVvYfrKK5ilFTQKdpddWIxQzUVvVsBjstG3fBkksFCWUvql54X1WQIQBPpm1xAvTKM6KQ8WBsMfQYLrkOSCgjT4Qc95feRsPoNxE+YptxHOub0dFQmbPTjGOYmGkND7FBb2OcZ9zPGAFMBUlfowW/g9ELi8/l8A8S1Y40w1/CsU1in3WFwMDEpLRh87uvuV4FVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3J5cBs+9d3aQnyAQqLt35rCtokIOt4sFe5+IBM3QZpc=;
 b=WMXtIaGHHD8fn632Mb3Jm6j/s1rU2pm32S5VjLAViNuAz2qJ5v5DchKHxIb58pEjJBXgHJWSUB4H5SdgUeRMmNUf7pj2BpW5x2vcU/QhaICihClqxZinTMNn7ONN3jp+GcG8D38076xhVIYIwjl8qUzmOh3nMD90ejR2Yqq+cB/yB8zrCa76hhF2p/XfV9Y4kvkk9XMPPSmuK/zoX+1mi+brkopPmEyKv4F0WtPq8cqX/7Cl1Oz/iRfS69EuAIcrejkTASctI5EKCmoOpVBmo4RDbqB6fRbhCdPlNbnqbkkInfUhV72LL0+JW0Yxq8uh8DwvQwXZc/70lc6gOq/U2w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SJ0PR03MB6987.namprd03.prod.outlook.com (2603:10b6:a03:43b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 19 Nov
 2026 09:45:44 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%3]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 09:45:44 +0000
From: tze.yee.ng@altera.com
To: Adrian Hunter <adrian.hunter@intel.com>,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>
Subject: [PATCH v4 1/3] mmc: sdhci-cadence: abort failed tuning command on SD6HC
Date: Thu, 19 Nov 2026 17:45:33 +0800
Message-ID: <20261119-sd_cadence_ddr50_v3-v4-1-95a94a0aaaf3@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261119-sd_cadence_ddr50_v3-v4-0-95a94a0aaaf3@altera.com>
References: <20261119-sd_cadence_ddr50_v3-v4-0-95a94a0aaaf3@altera.com>
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.16.0
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:a03:54::17) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SJ0PR03MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e33cc40-2a5f-42c1-1117-08df4621e14b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|261102123227099003|261026121527099003|56012099006|11063799006|10067099003|261022105027099003|261022075727099003|261021123027099003|261026140227099003|261028144727099003|261022113327099003|261021121427099003|261009223027099003|6133799003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oQ+/pbE1wyaAj6M36P6CwwsCsT2n25w9h0V2bO0d0Qel0Ri+NM/jATLsUz74XAqpf1mc4RRwcxbUMU/Gf5jLmJGmtLBFkehVjYWDtgVVZUFFUpZLZWbZV5eThToW1GQ2L7eAHNUuHgxDkRIzc+VXNr9tVtdT5dKGYd3MFzZDXqEDKIAT/IQFtCpFKGzDaKJ52MXE4MPM6LfdWA4d820WGlkUfgZ+Et//2vD7+joaklDwzrlZKEAfrtzvYD/7QAUcX/EhrzPFwfDL8m+1fOBhQMU8EHX/Qt3HTgE6XxL+IuH0dGwO9pPui33sgleHZmuC/2obomRQM6J3GTLynOVyMhBfxQxqPhiUVVCTd9DaZti3eqasb8gzHSlljYWUFoIrF5yQJCepypj1t7HZDD0+NMxzcjSaK7Sk4EMeRvwYTpF1789fdKgZtyhjmhQ+8XhjZbkZfXKhoZCQKF/XLmg8t6OOkkjw7aQfRBI4D3wM9BP4gUzSNXVIjJg6eRdrRGy3q5Vz81jcCFXj/2Ah5ZvMgCjU2pBKJQnWLrnMP/FYut/78tTL3Phh2WItf/4Nu75bfN8O8+V4RGzD4THSWVu6SyfRKw0Skhw9dBvoM6El5U8OEE9y7kPEj8X9GamlmakzJwbvY7ldAI9AJgiL66Hv17amY79ipfEI4h+JSPEuePQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(261102123227099003)(261026121527099003)(56012099006)(11063799006)(10067099003)(261022105027099003)(261022075727099003)(261021123027099003)(261026140227099003)(261028144727099003)(261022113327099003)(261021121427099003)(261009223027099003)(6133799003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFd5ekthNVp1Rld0WkdnenpURHNUdng3TWVzU0dwZlV1RGxYOWZieTI3N0Zr?=
 =?utf-8?B?ZllTSG9RTklaTm4vejhvYUMrRXFMK3VqMkpaZTcvWlpqM2Z0dWM5bnhMSVhu?=
 =?utf-8?B?M3FCd0ZhTE00UlBrUnl2OG0yK1hxSHgyUkJiMm56c3gvTXZTbGp0UlRlR29x?=
 =?utf-8?B?SEJONXdOclJWaWtLeURqdE8yVCt4WlVhQitNekowU3VFTHdGMzR5anRySWYr?=
 =?utf-8?B?YlQxcWJ3M2F5bTRVRWx2MjN4OXViQzNma2l2NVBpRXlYQ2lpUldXa2JpMnZI?=
 =?utf-8?B?VmE2RnNDUTdtdWlhY252MUt3bTZkRlRtY2ozRmdHVWNyRTlWdTJERHdoaXdY?=
 =?utf-8?B?RVluMThZbkcycTdRV1JYVElVenF0OENtdHZHMlBKN01kQ3gxeTIzemtuUG9a?=
 =?utf-8?B?aUtEZVNCcWV1bTFMVlRsMTgxelRUMUVoaWFQS3hyRmdRUmVqbnJCVk9DQmQy?=
 =?utf-8?B?eDM2SHNMQ3JVUms5S2FWTDlrR1EwRURDbTM4NFR3UzIvRHQ2VDRIMWN5aE00?=
 =?utf-8?B?dExjUEJpNGxLLzN5TUJuQjFaK0QyMWdhMk05Q09VYTNmS3kwZkJibVFNVjVj?=
 =?utf-8?B?UW1HcXRTL1FXbHNuL3cyY1BZaW9aN1hFM3I2M0pwTk53MnBKL1FsU09aeURU?=
 =?utf-8?B?R0pidy9KaHZISThNaTh5WHBkVzh2MjdqUkNLVVdpTm94YWRZZTNaTWhldVdp?=
 =?utf-8?B?VUlMU2pvMjFuckRTMWcwaHg1eWNKUFJFRkxSRTZmc0EvakJsay9qZWE1MTlk?=
 =?utf-8?B?SURoWTNteERCTVdMZDI5Lzc1UlVIMDZNUFc4VjFEeFJQWGxBM29uanlEcWg1?=
 =?utf-8?B?dmtnNklOd1RMTTE1QmF5OGpDQ3FSUGhudjBRdm9CUk5nSXEyK29icDQ1RUIv?=
 =?utf-8?B?bTRFSjUwSGsweXo1QU00eEttU09Nd3BhYXdtVC9Wem4xNVhaVU1RWW9BMEdi?=
 =?utf-8?B?bHZRaVZGd1RqdUNFQXV4QVVNQ05IQnN5cHlVWkpaSTNoakVlZFJrVjhlYWQw?=
 =?utf-8?B?RTd4cDVNd1ZlSnEzM24wOWtHdTE1SE1UM1dVVkZ1UHJsbXVReisvMmloL0xS?=
 =?utf-8?B?V29HSWxTZk5DcUFkTDEyMFdHOE1MU0R0VmJBUTBOK2kyUDRYZzlOUWdpY1JP?=
 =?utf-8?B?aWFSRmo0aUc3ZHQ1ZVdSTXppVXFaWmtyRmxqdTdYUFdzbForUFl4N0hOdWph?=
 =?utf-8?B?WnhWRmM4T296a0k0SEtKR1RqUE4yMHY0bFZaUlVLV1I3VUFKelNhQVZVYnhC?=
 =?utf-8?B?K29VTHZMcFpSRExoY2ZIcHFrdkJwS1BnZnpWYzRJTWlabURNaFR0eHdqQktw?=
 =?utf-8?B?dWFyOXliSmxkZGdMUzljaG55SEt2cUtMVjdxeHJsci82MVg3OUJ2dm5tbzZR?=
 =?utf-8?B?ZUdvOVFyVEJLSzdONlkvcWFzSHd6S3UwU2c4ZzR3VjBNdkdDL0pOMTJuOUlS?=
 =?utf-8?B?OUM5VkhFYXBROWZYbjAwa0RwVDRJKzduREFaK1RzdEJENzBHOWZEN2ZERXBx?=
 =?utf-8?B?NEhhcmtRaWhxMTBVVndWWEpWOEhjS1NoZ3M2REpZYnlQaVgzLzNJS0MxKzkr?=
 =?utf-8?B?RlpSMlhESk0rTXVpekRtd0tQemRvWjVsYmFZOUo5ekJwYjBMMnhkcEc1WHo3?=
 =?utf-8?B?d3FaYWxvTFRaVUtIcjlZSFBYNHNrNHZRT3lLTU1ZSG12RnE4VU5zNUJoNXJU?=
 =?utf-8?B?dTJ0Qng1UmpJT2VESWlKZTZ0Mkkrb3l4d3gwU1AxMWNjNURJVFJUTFZJYWNV?=
 =?utf-8?B?Qmk1Uzg2Q3B6ekpkdy94ektqcGxGd0I2WFk2bHRrdEFDL1hkeDFINE1mVTg3?=
 =?utf-8?B?ajB0eVVzOEIwVU9WTXY4Sm1ZQVRuQmJkdkFDNk1lNVoyRmlHWEpKcU95Um9D?=
 =?utf-8?B?bGd3MnQ4NlYzMmNPQXdLS0lnbHFpU3l3Ym5NUGRxcTZ1R3NHVVFGd1BqUTJU?=
 =?utf-8?B?VGVxMXh2SHNRUlpUQ3BnN29ySVRXcDFaMUpyazhlcml2dlVoV0pmZWNhYUlz?=
 =?utf-8?B?SFhOVnQxblFvaGlxL05kODBaYWpTNTRFaWpLU0ZXdGpWUG5LQnUwdzdDQ1Aw?=
 =?utf-8?B?WFE2R1oyNnFRSjVJeTljOXNKcERYZTVTQXdHTDkraS9MWVN0TWxLMzdKOVRS?=
 =?utf-8?B?RzRyM3B4YmpYTGRIMi90VUgvNlh2SXpJbDc5allTb0p1aUw4SWVtRTBpVUht?=
 =?utf-8?B?RkRtaGRqZFR5SjdhNmZTa1FPK2hTUVNxSHVDZ0JEQXYwNDc3bEx4Wmt4Unhn?=
 =?utf-8?B?WFVjTmt6RHdXUTRFeUtDblN4ZDk2WHlySW9jci9Zb1RoYXpWelRTdkM3ditT?=
 =?utf-8?B?QXNUN2t3UEkveTRBWnpoVEtOQlRLbm1jck04TTBKUW56RnR5NHZnZz09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e33cc40-2a5f-42c1-1117-08df4621e14b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 09:45:44.0118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6WAMfgEFGL14/eDsZMs67zROPdYXgY9SokJVaPVpgV/Xdk61yHd5EJlH5pkNVkM77y3+prRLwOhXoHtpRMVCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6987

From: Tze Yee Ng <tze.yee.ng@altera.com>

SD6HC uses a software tuning loop that calls mmc_send_tuning() for every
tap but never aborts a command that fails. When a CMD21 fails with a
command error the eMMC can remain in the Data state and reject the next
command, so the CMD6 that mmc_select_hs400() issues right after tuning
times out.

Request the command error from mmc_send_tuning() and, on a command
error, abort the tuning command with mmc_send_abort_tuning(). This
matches the generic sdhci tuning path. SD is unaffected because
mmc_send_abort_tuning() only acts on the CMD21 tuning command and is a
no-op for the SD CMD19 one.

sdhci_cdns_execute_tuning() is shared with SD4HC, so limit the abort to
SD6HC (SDHCI_SPEC_420 and later); only SD6HC has been tested and SD4HC
can opt in once validated.

Suggested-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
Changes in v4:
- Limited the abort to SD6HC (host->version >= SDHCI_SPEC_420)
  because sdhci_cdns_execute_tuning() is shared with SD4HC, which has
  not been tested; reworded the commit message accordingly. 
- Added Tanmay's Reviewed-by.

Changes in v3:
- New patch replacing the v2 1/4 PHY settle: abort the failed tuning
  command (mmc_send_abort_tuning(), a no-op for SD) instead of masking
  the post-tuning command timeout with a settle delay. (Tanmay Kathpalia)
---
 drivers/mmc/host/sdhci-cadence-core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-cadence-core.c b/drivers/mmc/host/sdhci-cadence-core.c
index 745455743b01..5e5a74ca25ce 100644
--- a/drivers/mmc/host/sdhci-cadence-core.c
+++ b/drivers/mmc/host/sdhci-cadence-core.c
@@ -330,9 +330,19 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
 	}
 
 	for (i = 0; i < SDHCI_CDNS_MAX_TUNING_LOOP; i++) {
+		int cmd_error = 0;
+
 		if (sdhci_cdns_set_tune_val(host, i) ||
-		    mmc_send_tuning(host->mmc, opcode, NULL)) { /* bad */
+		    mmc_send_tuning(host->mmc, opcode, &cmd_error)) { /* bad */
 			cur_streak = 0;
+			/*
+			 * Abort a failed tuning command so an eMMC does not
+			 * stay in the Data state and reject the next command.
+			 * Restrict to SD6HC; the shared path also serves the
+			 * untested SD4HC. A no-op for SD in any case.
+			 */
+			if (cmd_error && host->version >= SDHCI_SPEC_420)
+				mmc_send_abort_tuning(host->mmc, opcode);
 		} else { /* good */
 			cur_streak++;
 			if (cur_streak > max_streak) {

-- 
2.43.7

