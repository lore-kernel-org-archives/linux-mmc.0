Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793945831;
	b=A5PdgKbP8yCA/+RDunoEWM+bOz8KEqC7jxJV59IAgM3O+8DkQtxSfwam7H45YWJrPEqk
	 tubuz/Wzs0ORqXuz+kILuPjf0NIKsFkBnRWypCpEh5ub8jSAEHlXKfgBfRf1So6bHfFiH
	 VgDWQOLKaxfSEr+VNKd+AWb5JWdeOvff9G23P8JVQRZ1EmW6vyudfui9iBIjecjTRofC8
	 gJ7FZbe0MkpzE1FasIscnMaO0ez3kohwEKGksMMqqDPSqkTLSOBZ7EaULypfzPJh08mbl
	 6/tdcKjPIW53E9+VOWedJp3wLG7HSbTRLWNLPYhJQFC/RyipLsqr+Pizk8UDhYPA69w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793945831;
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
	bh=Pck6a+JPGL846+roQy08yzkIjrfAJw5qyxmSsoEyow8=;
	b=q4zfEj753hEP96N5RDIBRnpDxc3iIULUER/W64qqcYWtHQ5lvIRenzYcQE8yQQYqritF
	 lyDW1lrR9pvlw3mn/tYUIbRV2G2o4Qus7KzNTzr6MZgLELyD/7RdPhZLX1lDZLC8RGzIg
	 43XnyTHMtYHJKxXdvY95imo7GPBEADuLP2KZHc6FxwFWDEgp/gRSoOtVLk/9SEl9nkWvX
	 iaxM9AM6EiYL4W9F+4OJWr2Od46j60k1fL521u2uWcyUp8W4LJnpjKXXj11GfUYVMDSFU
	 Lqj9L+Bk6WSButYhlVXAP3NJdoTi2z1C0Nbf6/ON/WeXq4qeGbJrGIHA6JZRVLQ1feA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=VEARyzo8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.61
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B14B606A32D;
	Fri,  6 Nov 2026 06:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B14B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=VEARyzo8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SD+DHGHMbMG/m24O5GAqcGMCUuacZQJh9BiMNSCgyoLX785LOnCAH2oJCAWlUHhakOC3m+1lS5LEwaS53J2xtISPjovJuQxgvpqgqLPEFKwelwZNxX9hFs1Mr9dKPFU+wdtNLP4f0iGcax4C4vHE6o+nTxwvnAKS3CzV3o6aOiYBoNkjXOGrlRgcYqKsIKnHwEj7np016aqFj9pC7NslmplVMwiueooC2PiUpmDvttCjIpcwcuMMvSTYQL2bwj4W8AGzOycgV6C2QEeN9PReNiEJPlCArJJx59Ilw7gfIPnOKm/Esr8vLF+Q4hYeQJI4dRgCKBsj6k1EfQN1CG7MKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pck6a+JPGL846+roQy08yzkIjrfAJw5qyxmSsoEyow8=;
 b=kIWMB+hwcRfaukb0TC2ZrgxpyMeYpWX5cjWuIoBDRSy7Xf6AOguGBSXdAWx2exl1eD6Lefi3RDm5KVCDYMD5XIsE27WqmbGX+WzO5xIGrV9q+vuDYUDWOP10mnmuYRMHfwcXKgyjJ5SlvwUx6bkbYh3KKYG2tQy8TuQpN/dJBE859qkhouoKFmbswetCJ0ppDwNoPiLsvagy5IlSdS6sIUI6FF18egWNOcJ5C08OevR8lrpukDZ+WDztcF79iiKqmP7tPGjdreFjAShDrOa3Kt49R1UpNED1QRdlDJ7CQ4QYRssCB26GDokXjFlbKv1ExeDeiXymIzk+ZO3u0S84LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pck6a+JPGL846+roQy08yzkIjrfAJw5qyxmSsoEyow8=;
 b=VEARyzo8CXdJSIlkbRu7NE4wjD0VazSaWfi/HStFSBEdfDvYbOpJojQrslJnsH1iCYQiq0F8pgnjzxx1DexrUPsKNqym/becrcwXXGyCl0Lo0Cn43q8M+9WAIvhTTRXtdKgcwoNUyxVdASn9ikGrnbB+TgnbxTDyugPldQOHIanwjChRpDgsz1qZE+sxFD4x7uh0BWZEgAvb5msK6b+5c+YvVeXkKjq6EeNKj06lAIKGepf3wuCdzhAI9QutfNt1uP1xX4cpQ5BSJSqIgdQ6prOjYNNnb1sAuIaHdKkwVl1Fc5Q0TaOEt3mskpERSo/R78FkB3CQ0q12wuBz/ue1xg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by EA8PPF1471CA897.namprd03.prod.outlook.com (2603:10b6:30f:fff5::845) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 06:17:03 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%3]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 06:17:03 +0000
From: tze.yee.ng@altera.com
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>
Subject: [PATCH v3 1/4] mmc: sdhci-cadence: abort failed tuning command on SD6HC
Date: Fri,  6 Nov 2026 14:16:52 +0800
Message-ID: <20261106-sd_cadence_ddr50_v3-v3-1-cb50afece614@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261106-sd_cadence_ddr50_v3-v3-0-cb50afece614@altera.com>
References: <20261106-sd_cadence_ddr50_v3-v3-0-cb50afece614@altera.com>
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.16.0
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::20) To SJ0PR03MB5950.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|EA8PPF1471CA897:EE_
X-MS-Office365-Filtering-Correlation-Id: 61ad52f5-ec4b-4f04-9c78-08df3bcd92fc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003|261026121527099003|261026140227099003|11063799006|10067099003|261102123227099003|6133799003|55112099003|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	RbE15CIDzy6M1xpLrT4OaLyPfHtEr2K64IOreoPFyYHzHRECzvC6JHMT+GiAdiJXjTE3OfHRwrRqAVNhqg3TnX84Za3EbadFWIu3tXqy/rZU6pUHqWwlF6qMoL24hi+R2uSouRvaxUC2w5Tf7RqZv4Qyp1v04Mo7W6WSXoyKddYKzCjwWiA71xxjIDqxJHsVmlmCHpW818X+WZ26U++22qFh93s1aZJI62wYw8Lr6iwVwnn73Dt34xlEJwyY/3Xtj2G7LtasMtu+qLIXvSfB/l9CbdNJ3GCMVMVLRtL3tKw2uVEUfWXj7QBjJIIU97tVTZoiN/yuH2rCZT5gHXw5Qwl2kIyXhCGxP3OIw10Q8mPUKc5MFVpkbAgRhC0betMNkMmy6+5EabmLKUsu5OQFMO5rw2PmeHpQNRYzeWnz8IWfVtKhbVemXj7MonwIL/2uKhE1ci/Cy9ztoxuSjcV6y+YvKES6dHmuizU6Rr9/usMkfRN7MSl2V6yTDrqDSDS2iHnZULbTAxDugqd5k4HsUVU+jICU9tevWJvhONv3s6MSpKG4yaGdkv7otEPqWFnMfqVoms/LupC1NCscxEuCI9b/2JUo3m1oIntGNxblpicZiqfFsPM3HMlf1VXPLi1+baZ9MqztK0cvzKS85AjLMc3bNFeIrf0glJbyek+ARsc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(261026121527099003)(261026140227099003)(11063799006)(10067099003)(261102123227099003)(6133799003)(55112099003)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFc0RnVCblNuSDRQV05DZjlDQ2l3NzErOTkydjBaRWh5ZUsvZ3RHa1QxdENS?=
 =?utf-8?B?a1UwV1lZUEpMQi9qbjROYUtQTWhwaGJMOXZOM1BndTFvazJCeElpMElvOG9D?=
 =?utf-8?B?Uk95MVkzQ25NVHBUWlNRaEpHTVh5S0dtRW04NU1ySG9VWVBXS1JGMWhHNEda?=
 =?utf-8?B?NlZqSUY1VHhHU3RBWExGSE9RSmNWVExNT0ZsQnlTZDV6dGt5dzlqQkg5S1J4?=
 =?utf-8?B?UmpxcTUxM205aEkvd280eUI0WWtmWlRkeGJ2cks2MDNGMnpoWDVlRjM1alJh?=
 =?utf-8?B?YWQzZkU4UHdSV1lnRVhmSXhZVE9VZzIxYnVLM0YxYlA5VFFlbzRxNGIrZ1V6?=
 =?utf-8?B?bHhxcHM0ZE92ZDBKSVU2c000cG1pcUhoL20wVnpBTkJIVHpmRUFPT1JHUWc2?=
 =?utf-8?B?SldvREVTL3FYZU0raHh0dXp0ckVMNGZqM3BxM05QRWxLQmNYK0d4Uk0ram9N?=
 =?utf-8?B?dGsxRlhlQXc5T3FqaXUyTkVQQTFlb1BNUG9DczgwSklCVEoxNS83WDdjaXl5?=
 =?utf-8?B?SFo0R2svNEhnVjB3R0VJcGlyY0UxN3NPa2tKU1lEbzlDRVpFSnIzZ3Fxd2lz?=
 =?utf-8?B?MHhaNDVvQUZHUEdQb0RVbHJhazBsTklmUjE0M0JJTkNiNjJXdjZLRU5XWkUz?=
 =?utf-8?B?VldTZmxQUmZHNlBGYXFpQTRLQkRsUDVuUnVscDloV0NSNmxxVC9jT2ZGMGpp?=
 =?utf-8?B?bDJMYUM3VHVnVW5IOXQ5dUZPVEtpWGpCdGdlblpjVis4VFNNaURQUFZkOWhL?=
 =?utf-8?B?U1Y4UHc5eDhaeC9pY1NlelNNcnI0MlZhQmxPNU54L0ovWmxveXB3VmVqelJm?=
 =?utf-8?B?eTBHRExjamh3S1FGWWJVMVRZQlRUL3BIRDhYWEl0WlZXMmNXREpRTFR6ZzRQ?=
 =?utf-8?B?TDdlK3ZMdVF2dllvOEh0Z3dsM2Q2U21jY0xCTDFHaFM3UWdId0JHRDdUL3VY?=
 =?utf-8?B?Ty9pZC81VUNNK0lMdU91akE1MVRnOGZocWtCbHM4elRxYmh1bTg0MVpuS3Vp?=
 =?utf-8?B?MXBGWnFWRFlNbG90SEFxS2YvOFBGbCtMWUplZ2FxeG9VMUlla2ZNRjR1bE5S?=
 =?utf-8?B?dnpPSEI2TU4vUVZSaWlUazZtd0wvaUkyYjRYbmI2c0dHY2dQYTNoejUzNmpD?=
 =?utf-8?B?M0NUQVZEQ0hMRVk0Y3N6cnJhandTVGhZTEtia3JTTmhHTkxvOVBOU3VDcHVw?=
 =?utf-8?B?S1ZJRjFraUJqUUE5T1d0YVBMUmFuNEJtU0cybTdja3A4aHdEM3dtd3JnUUZt?=
 =?utf-8?B?eTF4UUhRT3VLbUVYVXJRMjhrNlZEYXBINko1YzBVZmI1cFJvcTRVSFkzQTIz?=
 =?utf-8?B?cStGM1o2K1Fmdm5TT3AvU3QxdFkzeXE5NkRSOWlwM0llNXVyN3FUNXRDOU8w?=
 =?utf-8?B?cEVCVHJMU1Z0SGk5b1BCQlI4elBCeHo1VlVMQzMzbWxPbVE4aTdrajY3Z290?=
 =?utf-8?B?UTI3RlJhN0wwRTNIYlJYTXZldGJ4MjRXTUlScjRLdDhKeVZKTGdDVWhXc3l2?=
 =?utf-8?B?cW5RZWcyOHBnbzl5VkF4VXpJbjRVL05jdlBGbjBNWHVjTWh1Qit2WG9aVHdp?=
 =?utf-8?B?eWlVYURDZVZKSCsyN2VRblFoWTJVV0dxSW9wS2d2WDRJbGJoazUxYi82UFlC?=
 =?utf-8?B?NDZJY21YOEZSN0JWNjhEcmtCSTIvTDBkT0pockJaRmJmNHErMkJxNXNjOUd6?=
 =?utf-8?B?NFU3UUNOWFdrcnRzc1NGT21LK0pSV3JGZng3ajM2bzRLV1YyRklWbEMxcWR1?=
 =?utf-8?B?WGRvYjJYSnFPL2t3aHBBenovbFpCK2JZSW90cGtPMmx2Zkc1djJVakh1L3B0?=
 =?utf-8?B?NWZDWmhpRUpVOGhXZzdyUW9rbGFxRXNPNXZ4bW04RDQ3NE81MjdpVzZOZlV3?=
 =?utf-8?B?TzMzOEVuQU5TUHB4ZlFQUTFXbjZQSG5yMktZSHI5bmNDS21QbjRBVmVHK1N1?=
 =?utf-8?B?cWFYejRSMHBVWkhaaTJDd0g4bXhDaGVucmROLzN6UEw1c3RuZi9iR3JzL0No?=
 =?utf-8?B?MWxMQngrTnltdXFWbDFqMXk1VDV0THNUMXE2VzdFT0ZnaUNBYVNxK1BBaFhD?=
 =?utf-8?B?RHVYVEg4WUtCMWNWRU1GUndiUHNzU3dQYXlhVzk3NitERzAwajJrc0Y0S3VO?=
 =?utf-8?B?UGs0UXU1ZEpzS3lad1dtOGIySXVqZmVsamtQM1FqcnprbFNiYWtsMmJtcEdG?=
 =?utf-8?B?MC9zczk2Z0xKU3EvTjRzNlMvRUVJNGY2OTBYaGxPS3AvTTJ2M2ZTRmJYLzVE?=
 =?utf-8?B?aUF0NkVGM2IrUFA1MG5VSWhiVTZhUS9Mb3ZYdnJ4dndmVHlBd2x5cUpCNVk4?=
 =?utf-8?B?NFB1SUdYY2ovODluVkJtaW9VVUJ5ajF5RWs4S0t5N0VFNmNkK1RFQT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ad52f5-ec4b-4f04-9c78-08df3bcd92fc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 06:17:03.2929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0RofN0//0GHq9HNyOI5XHkqKqBk5Wqs5GaaTf5HyX+WmMitf579/JxpKjxe9egSy3HSuyrLRcKLH+0je3FirA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA8PPF1471CA897

From: Tze Yee Ng <tze.yee.ng@altera.com>

SD6HC uses a software tuning loop that calls mmc_send_tuning() for every
tap but never aborts a command that fails. When a CMD21 fails with a
command error the eMMC can remain in the Data state and reject the next
command, so the CMD6 that mmc_select_hs400() issues right after tuning
times out. SD is not affected because CMD12 cannot abort CMD19.

Request the command error from mmc_send_tuning() and, on a command
error, abort the tuning command with mmc_send_abort_tuning(), which is a
no-op for SD. This matches the generic sdhci tuning path.

Suggested-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
Changes in v3:
- New patch replacing the v2 1/4 PHY settle: abort the failed tuning
  command (mmc_send_abort_tuning(), a no-op for SD) instead of masking
  the post-tuning command timeout with a settle delay. (Tanmay Kathpalia)
---
 drivers/mmc/host/sdhci-cadence-core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-cadence-core.c b/drivers/mmc/host/sdhci-cadence-core.c
index 745455743b01..a94296cebf47 100644
--- a/drivers/mmc/host/sdhci-cadence-core.c
+++ b/drivers/mmc/host/sdhci-cadence-core.c
@@ -330,9 +330,18 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
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
+			 * stay in the Data state and reject the next command;
+			 * a no-op for SD.
+			 */
+			if (cmd_error)
+				mmc_send_abort_tuning(host->mmc, opcode);
 		} else { /* good */
 			cur_streak++;
 			if (cur_streak > max_streak) {

-- 
2.43.7

