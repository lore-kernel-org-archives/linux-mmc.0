Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E711993B0
	for <linux-mmc@vger.kernel.org>; Thu, 15 Aug 2024 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723726663; cv=fail; b=Qw5FQrlqpV64f71iZ7DrkaPspet/QrCK5dsoP32ln4/yuNI0Dg4p+PmhlBahq5KZ8adSSQlTEiJJhK6lpq0MsUpmvmZuraSKuWOrzrdEkb3kp4WyX+0RkeFw2zhUN5exLswUyWZ+TAqqEwl8o+qrzCsUodF8fPyO4ZQX54PTl1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723726663; c=relaxed/simple;
	bh=tlTUCnTyHchkJWUHAhD8I7ng6SrMOSlPVxk4EPfYdvA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qG/05Md2XN8YHDnukq9OzIOm9w0YAyRiv1Zh/jhgrYcrQSEohsnwxMcNKPKUPilSkiq2PjekGS3UAOxOcO1/ErqLziwEE+RGylP/ZSSBLcOwxUsXYVmsQYK3bqaaKi+2lIv2i6DLBL1LjFMjjSAkp6YgjUgonT5vIO21gBLl9SY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oreCyk0J; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=p+ZqOBBg; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oreCyk0J";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="p+ZqOBBg"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723726661; x=1755262661;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tlTUCnTyHchkJWUHAhD8I7ng6SrMOSlPVxk4EPfYdvA=;
  b=oreCyk0JTFIG9tdTNWvFJYrLozvHyOhuvaVDIFGps16iuFsikblxCkeu
   AXqMUOLLfVLGUDRkDwhaXwoHR4XE8GI4UzEEqWt3KVb/CuQgxWpxiqz8K
   Ga7hP/zaeBXW1Nub1UrBDUghI9kDvOZZjWU2mTf2rELHKOXj54Iliuct5
   iZ9RHz7fcwmKoacxIXjQURA1YXlPh5PtW7gqY4S8eB6bUSM1xW15mrMRE
   509YIeFBTjM2NpI7p1lv6Dh2MV/aD2iRtCDzM95MR585JchNTWyamq50g
   q0Xrq6C4Sdt+etHwbDWeY4vxY+Te0KEKvH1e8BDX7KMP1xqATgIo0jskn
   A==;
X-CSE-ConnectionGUID: g1VLg7u8RyaOHYgyNThFcA==
X-CSE-MsgGUID: SLLcDEygTMecMtu5++764w==
X-IronPort-AV: E=Sophos;i="6.10,148,1719849600"; 
   d="scan'208";a="23731230"
Received: from mail-southcentralusazlp17012054.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.14.54])
  by ob1.hgst.iphmx.com with ESMTP; 15 Aug 2024 20:57:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJ39SDWV6BtP9o/3YiO9uRKIfajeU3OmiF+uEDhz0wMELzlFNR6kguwQTxMeq3RpUBgOK5707ynSC6HMv8pxnCRJSsq873ZIB03KxquqsYuQUq31u9s3LU0cZHSx9PFsvPNiMoc/TCWQegIfdDFLcjRQR8XGpzZ/+emc+YOFh3ukCKGHNI3oduoa1Mmt3oqJ28suTQHBFyDsov5SuXxtxgBk+JJ+nVRxsJzoZhcXrZQfHIsajPCgGbhLqiiqGA1HJM5Ou3qLlRCP2OEXZ4vqHQ4XUHm5TZyEVHfoftKlTIMrFFaxid9VIzrbrNXL3ambWStj2wSDueXNRd4fMuZPlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlTUCnTyHchkJWUHAhD8I7ng6SrMOSlPVxk4EPfYdvA=;
 b=ba895kLJYjO5Kjxqd4SnMMJ1sHm+h+ejxlvhSTrclB1LSA7d387NvRuIsxl944+8NOThCFCp63abykgRqpItKE5J3HChzYkzThEoEJiLxrbqzQQcdgzn23CqfKnrET1z2vp7Fyk9Mg6F2iPX9lvGW/osRZ8h7tp8pOAm2J+G10UO530XfQmjvrrfZhwo1AQwuJPGvCxMpEH/f7a+7RtpLzR3s6+bCLGMRDaJRAdwRqVrXZ/cLqHAGpOfBE3q4s5UoYL7g0PBHb8Nd1uhZBr4Be4TYANo/zJ8pvp/NgzHilI62wk4/qxERM6LrJWpIspZeJe+cXJIsPJoQ0yA5gGiFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlTUCnTyHchkJWUHAhD8I7ng6SrMOSlPVxk4EPfYdvA=;
 b=p+ZqOBBgLNGMp//g94hNFhzsWJZ4YwD3X7vW88ppNuaBO3ipYhjOugqAk5GzE6JpGDxhwTILdOs5pjmYUrCV0pihVAupxfWO1KhSeyxb02k0iF5fVuTbpFVKGrKHO3BDRxSlPTIid7quiEhG9f/A7BX4KsgUCdwofKvA51kmJVE=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH0PR04MB7208.namprd04.prod.outlook.com (2603:10b6:510:b::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.19; Thu, 15 Aug 2024 12:57:31 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 12:57:31 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Ricky WU <ricky_wu@realtek.com>
Subject: RE: [PATCH v3 10/10] mmc: core: Adjust ACMD22 to SDUC
Thread-Topic: [PATCH v3 10/10] mmc: core: Adjust ACMD22 to SDUC
Thread-Index: AQHa7hwTtEBxsM8fmkqPrLsNwRFwJ7IoNLCAgAAR3nA=
Date: Thu, 15 Aug 2024 12:57:31 +0000
Message-ID:
 <DM6PR04MB65751ADBBDD03386CCF2A7F3FC802@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240814072934.2559911-1-avri.altman@wdc.com>
 <20240814072934.2559911-11-avri.altman@wdc.com>
 <aa4bd0dc-b349-4ef7-83a7-59af67d61cbf@rock-chips.com>
In-Reply-To: <aa4bd0dc-b349-4ef7-83a7-59af67d61cbf@rock-chips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH0PR04MB7208:EE_
x-ms-office365-filtering-correlation-id: d58f0c20-898b-40fa-56e8-08dcbd29d314
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L1l0SHZsUFp3VGgrOGRMUGZtUktjVGowOHIxbnpQNytJbjFKcXh4WHhkZ0Fo?=
 =?utf-8?B?ZmcwRUJFWVVFMWV5dHFTM2w4TXcrR01wbnV1T1pSMmZqbnBqWThEUzY3RWg5?=
 =?utf-8?B?TVA0REM0RFQrRFVGc0U4LzcyVzJxc3ROT1JsSHIyNEFiNmhTSXlhTlRtQi8y?=
 =?utf-8?B?a1VSbnIzY2xSOTVqbVFrL3kvQnl0SGYvM2taT3dOQVh4NFhaMnVGeE0zTDdR?=
 =?utf-8?B?a3F2aUpleGRDZkczZlZxK0FqeXpUbkVtSXZhOUZZL01EVzhaVjRUd1JMK1hG?=
 =?utf-8?B?Z2UvdGp0TEFQd2FySUE3SEpLc29rQUl5Z2x6RFpuYWppV0hNR0FZLzA0eDUv?=
 =?utf-8?B?S0xKK2hBZ1dkUnVxUHZ2bWViczcxUjVoTjRCYzdzZGdRVVoweFU4aGdWZ0k2?=
 =?utf-8?B?TjN4Y1lUK1V1MGRSdHJmdTc0TFhVOTdjYTd3aVh1bDNOKzJDYno4TTkrcWJt?=
 =?utf-8?B?YTEyQWJudmlLcFd5c1Z2dnBleXAzTHVyclFMVjg5a0JkVE1FdGFKQzlNQW9W?=
 =?utf-8?B?akFPUFZNcHJNazYzRUNSVHE4UzVISGpFcjlHYkZQVzhjMGo0QXZRRnB2b3Fq?=
 =?utf-8?B?eFFXL1M2emdPUURIYXRMQnR1R2N6a21rcWhZZklST0FhdzByTmlxQlJnWXZF?=
 =?utf-8?B?ZitYWjRQTitjUlVPOWI5SE45dUZFcEUyTklxWUhlald1cjhsYXZZL1dSOXl1?=
 =?utf-8?B?U0hKTmMzQkdGTU1XSXUzcExRK0dTTTdTeUd3NEd3SEdGMkhqRlU3N0h3S0ln?=
 =?utf-8?B?aTR5VmhIMW0rSUROVWJrRVY3TFJ4Sm1sVjN0dzBzVlNiWjlMVEM2RVZMcHBh?=
 =?utf-8?B?RDZkak9PWHphdEV6ZFVVbkFWclRBRk9QU29FVkFmS2t1QVhvUFh0ODRUUkNV?=
 =?utf-8?B?N3hIN0M2N21mUW9oZDVlMWFyQi9ocUNQeEtrRllSeFViQWtKbkYzczYzWjhq?=
 =?utf-8?B?blNOd3hHSWhSWDRoaWI2QWx2UFA1b0NMRkNKc0cvbWFiVjdmaTRBZ0xrL1Bq?=
 =?utf-8?B?MUltNDBESFQ0WVkzWGJJdkhCc2FRamxISVpPeStVajl1R0R4Q3EyWGx6M0Jy?=
 =?utf-8?B?eEpsaVhhYnc5cjJIYXBjWXBjQWwrOUgrREkyZDhJS1JWVnlIRGNMcHlIbFc1?=
 =?utf-8?B?VXZOVDdsL2NxL2pkTGxjOHJwMVd4dFgrREdkMkIzNzIzeWczTyszeXZZZXcr?=
 =?utf-8?B?QUhIUVRPNjVPeWp1VmJsN1puUUlUeUFiUjI5bG8xdCtXYXltUWFtU0JkRFMr?=
 =?utf-8?B?VlhPUFNJZ09uN0VpTmYrT2FleFkvOGZFcm0zK3BGVWNHaWNFaTlYRGRDS1lh?=
 =?utf-8?B?ZjJ3YXRyZzUwaDdwZ2VCZExjRGc5NnF3VzNYSDBEYmtBdGNoWTc0a1RIQ3Zt?=
 =?utf-8?B?RDM2Zlk4eUZ4ejdnMW5seFZoUUZHYmFFQUI5T1F4Vlo3dFY3ZGdFQkFhRk5y?=
 =?utf-8?B?NVMwa1RrWjgwTkV0by9IUzhOcHdXZXRoTVAxd0ZOOGIrTk12Ti9SRXZaOG8r?=
 =?utf-8?B?RTdiOTFBOGhoc1dLM1Irek5iaXY2QTR6alh4b0N0bW1rYkNRbmVsRFNTakNB?=
 =?utf-8?B?d0M1c3MrSlRXVzAranFyY2pSSEhYWTIvYnBjK09jM2kxVXV6bXluaEg3SGNV?=
 =?utf-8?B?cGdVVlFpWmZiMGJINEZUak95SDUycEhYOUlpNDBocXhzNm95bGtud3d1N2xQ?=
 =?utf-8?B?dWs1cnBmS2hIMzN6MDZFWEJBWFB3SlNxb3R6b0ZmYkJWakRiczR5VlVyV01Y?=
 =?utf-8?B?ZWpXRnJaRHZDME9KdWd0MlNJcEE5VytiTmhiODdpUG52ajEzT2NSMHNOZG9v?=
 =?utf-8?B?dVozYk1tS1dYNHlkRXY3M1NwUkNWNStHeFVqK0I2STk5empOOHlCYWJSUFdB?=
 =?utf-8?B?T0RvMXBnNFA4OVk3Mk1SUDlWL0hoczhZenRNYXJzUGlUZHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?clJibWdlOW5QZTZpTXVudkgwcmlPTFlVTzJNMmxNc1k2ek1nUy9ncFg5Z2RS?=
 =?utf-8?B?QnVLRnRNRFNVcFdYWklvS1JBOFJTUGxJaWhMMU4xaVRLNmQrOGFBb2dScEJy?=
 =?utf-8?B?ZmNFU05WeXhBLytWdTV3Q0sxMW56SE5JV04wVFB6UVdwbE9JZWNua2F3d1BF?=
 =?utf-8?B?SVdRRGdDZzByWklTR0JsdG9uTlV4bVIyd0h3b3VMTFVyQ2JSRmtkOXBnZEJF?=
 =?utf-8?B?MG1qQjlydXFkaG82d2dpM1dmUUZVOFdNWjBhVDlML2JXSWIvSi9DMTFVMWVp?=
 =?utf-8?B?UXE0eFdpL1FFcitkRUtqdUdqay93cGhkaEEyYUQ4WDNSZ21EVVA3NkpWVjYx?=
 =?utf-8?B?b1NNUW9zNDlFNjMxS3ZNN2FDdHBZandFMTB0dzVwQnVTK3BSc24xV0RGbzhr?=
 =?utf-8?B?c0RWbjBFMjlMaHcrL2w1ajd5eFhPbjhaaldPZ1o5REk4WFhDeXErZ3VEZEdY?=
 =?utf-8?B?Um1UMFJXdDh2ZlZRMzRpRUtSTFZmU1o1dEs1YVJId0ltMHRTa1YzbnR0aDZV?=
 =?utf-8?B?T0xNeDFLU0pCWWt6OXREWDlIcTJwcE5hOG5waGZIc3h0UzVHNmxOOVpFbUwy?=
 =?utf-8?B?d041UlZYMDVxTHQvQmJMdEJTWFhMMlJSYmJKaEtHcSs2REhEQ09pRkNiWWND?=
 =?utf-8?B?WVRqTGZ6cGQyajJUZmF3TnJYUTNzNHI3NC9NMS9pR3ZMWkVNUFVkdnQyeUlF?=
 =?utf-8?B?Z1FIRDd6UXc2aHF6dU9jekg3b3IyMzBzNUxOcjBML29XbXI4YlVyWTZQa2tw?=
 =?utf-8?B?UUplTHJ6dytuSmlyNWFxQ1poVWI0Z24zUEZuNHExSXJ6SGVwU3dRU2tGaUhX?=
 =?utf-8?B?UHdZbDlEeENtOFlXSWVKS0ZjR1RwM1QrQTY4R29YTTEvUWJCejIwazVjMlF3?=
 =?utf-8?B?VjJ5SWJCWGlQUlFZRkZ5WU85eDkzMEpTUmNsK205TTlIRDhoY3RZeWZiM1Zm?=
 =?utf-8?B?SE9Va2lNR1FVVU1SVXJ4Y2dFUXZrOTNrL2F2aU9FaTdMdmVIWVJ4Vy9KbHFq?=
 =?utf-8?B?ZURmZmg1SFREeUpreWthQ3V4cnJobURlOXZYbzE0L283UVNmM3Nxd1FURVlW?=
 =?utf-8?B?MDQyNVpjQ2VicFp5VzFRODRvSkozdUx1cXZLK284WFlSQzNYdGZsRmE4cXZD?=
 =?utf-8?B?NTg3VGI5U0FLWEREUnNSUnRWTzVWc3FuSVJCUjFxM2RNck10UFZ0WW1RdnNy?=
 =?utf-8?B?U3hVLzZPcXVVOXZkWWZTeGZnVHpabklZVEdQZzMyenY2a1duY0dKZENlckhE?=
 =?utf-8?B?OU02MmN0bWNtY0o3VmZuRlhZdXpRSDM2amZQcjFTdVRHRVgzNGxoMXpGMnBt?=
 =?utf-8?B?QWg0eUJwRVRmc3NiMWJxemdjN3hYM1p5aStQOXFNZDJ2U0g0aUJ6UE1OUTdt?=
 =?utf-8?B?VVFrR0hXWWtyYm8xMGFaeDg4SWx1ekQ0SUI1THVMemtsK3lCQlJDWFJBQlBr?=
 =?utf-8?B?TlVETFE2MTBIdjFZL0pSSVVUZGxIcDBHUEFuSCtXL1ZycnFqK3FnRTlReWFa?=
 =?utf-8?B?eldjVi9yMWlaTkJvdFZGWlJCazNGb0FQTGNUMit6N1VNVW9MSUlSWXh3akc3?=
 =?utf-8?B?dFZxcXhUT05yMlppR0Z2QjUwV2oybVhmVXhlOEtCR1lsTFNaRWNyK0dVb1JN?=
 =?utf-8?B?Ym04VE9pb0RlWUJmamFOYUJBb2tINmdaVEJEVkN1VjJOaG1iMk56L2xwSXND?=
 =?utf-8?B?MnhSbnlHc1VKWkhaUmNzM216ckJhTlNjaDhrenl1TlIwNUwweFArU3BreC9Y?=
 =?utf-8?B?TnJKTkJqa0IyblJHK2xsa0FyTXRnSXhJRGZEWHlKa1VDOFF6emV6OGN1UEh3?=
 =?utf-8?B?dzZpbk5qMW11dktWeDk0SndKYTErOC9HcmFYckNyb1dQRS80eWRLaHJTVWV5?=
 =?utf-8?B?czVWS2wvZlJ0alpVMHpud1RNbWJrT2F3N3pZdzhkZHRQNS9OOHZUcHhnL0hQ?=
 =?utf-8?B?WXNZNlpTNlpuclN6U1V5WVlhTWV5amdkWkNsbHQ4MzFEeGNHS09Ec1NHdHhC?=
 =?utf-8?B?VkRHRTNrT2VBOXFlRVkxQStINitZWEtyMkYvbW9nVUJzWjBKWWpwMFJJdGI1?=
 =?utf-8?B?SFphdy9wdFBNYUhJelhLdWk3MWZ5c3JNbHdaaDZDSURBdHJiTTgzTEdTajBk?=
 =?utf-8?Q?Q/8cFiwInn2CAxoZhjfvVpPfw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3U/erX6v+hfghK8pTNXa/42AVpYQlQfoHudBObJzxdf/VGSsT9709oVJDOf3icU1Ty0TGodBcQZ83FI0Gfxm7H9HPrBYQYV2y+F4QNjZ/oDME3q/xl0wRIZle598h5WpF/CfpI/Sf1JEJLdIwKFU93cj1PhQxaen2yGaO6sFAR4wyoa/toR+cbtT8SkYUmhVg8irD2kYdR5WrCjq00UUW4bGEL/GYdaKhwE67OwfFUjBUr9XQX1LI9zQHHlAVqtcy3BDWl58a3ASMDDrh5JckH3tY4EBScNL0o0vSWT9E69eGkWp7iWgVBPplBnzYk6UyYJE8QVy6lr21R4kf7la62LVXlgPlWYtK2b57625FJNKWw2z5Fun20xef8JlEdpea2tNVThwVK0Up901C+Zft9vJ2fNH+fgkuIjbPFPy9mzmaesBcWguekZ3NdKwigRBHWI0tNL+2nMMkJmmJjhmhySJ6qtB8N3zYszna/WrlK7NyhVe/9Gg1kSGJmwsfOP6CONWFfvEJ2XTapYBaS1Wf0LcHH4vHPGWX31I5PKPeli700BWC9cGgtxW56/YuJPPpSVvK9Ctlr0oxZDWzWeBNNs1ANxJKGHPpSNmvzvoYTSQhQWdpqCTdojg39VIwuq7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d58f0c20-898b-40fa-56e8-08dcbd29d314
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 12:57:31.2301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VBHr5pwaMltjpdj5fxUphCdLbr/eklk3LhmuGss73K5u0s2Ir/9xg3Uqy/FVmXboVEIW+2UJaj/OqRDPULZVDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7208

SGksDQpUaGFua3MgZm9yIGhhdmluZyBhIGxvb2suDQoNCj4gSGkgQXZyaSwNCj4gDQo+IOWcqCAy
MDI0LzgvMTQgMTU6MjksIEF2cmkgQWx0bWFuIOWGmemBkzoNCj4gPiBAQCAtOTQ4LDEzICs5NDks
MjAgQEAgIHN0YXRpYyBpbnQgbW1jX3NkX251bV93cl9ibG9ja3Moc3RydWN0IG1tY19jYXJkDQo+
ICpjYXJkLCB1MzIgKndyaXR0ZW5fYmxvY2tzKQ0KPiA+ICAgICAgIGludCBlcnI7DQo+ID4gICAg
ICAgdTMyIHJlc3VsdDsNCj4gPiAgICAgICBfX2JlMzIgKmJsb2NrczsNCj4gPiAtDQo+ID4gKyB1
OCByZXNwX3N6Ow0KPiA+ICAgICAgIHN0cnVjdCBtbWNfcmVxdWVzdCBtcnEgPSB7fTsNCj4gPiAg
ICAgICBzdHJ1Y3QgbW1jX2NvbW1hbmQgY21kID0ge307DQo+ID4gICAgICAgc3RydWN0IG1tY19k
YXRhIGRhdGEgPSB7fTsNCj4gPiAtDQo+ID4gICAgICAgc3RydWN0IHNjYXR0ZXJsaXN0IHNnOw0K
PiA+DQo+ID4gKyAvKg0KPiA+ICsgKiBTRCBjYXJkcywgc3BlY2lmaWNhbGx5IGhpZ2ggdm9sdW1l
IGNhcmRzLCBleHBlY3QgdG8gYmUgYWxsb3dlZCB3aXRoIHRoZQ0KPiA+ICsgKiBmdWxsIDUwMG1z
ZWMgYnVzeSBwZXJpb2QgcG9zdCB3cml0ZS4gT3RoZXJ3aXNlLCB0aGV5IG1heSBub3QgaW5kaWNh
dGUNCj4gPiArICogY29ycmVjdGx5IHRoZSBudW1iZXIgb2YgYnl0ZXMgd3JpdHRlbi4NCj4gPiAr
ICovDQo+ID4gKyBpZiAobW1jX2NhcmRfaXNfc2R1YyhjYXJkLT5ob3N0KSkNCj4gPiArIG1tY19k
ZWxheSg1MDApOw0KPiANCj4gQ291bGQgeW91IGtpbmRseSBwb2ludCBtZSB0byB0aGUgcmlnaHQg
c2VjdGlvbiBvZiBTRCBzcGVjIHdoaWNoIHN0YXRlcw0KPiB0aGlzIDUwMG1zIGJlZm9yZSBBQ01E
MjIgPyBJcyBpdCB0aGUgd3JpdGUgYnVzeSB0aW1lPw0KWWVzLiBJIGVuY291bnRlcmVkIGl0IHdo
aWxlIHRlc3RpbmcgU0RVQzogDQpJZiB0aGVyZSBhcmUgc29tZSBwaHkgZXJyb3JzIChwcm9iYWJs
eSBjYXVzZWQgYmVjYXVzZSB0aGUgbWljcm8tdG8tU0QgYWRhcHRlciBJIHdhcyB1c2luZyksDQpU
aGUgZmlyc3QgZ2V0LXN0YXR1cyByZXNwb25zZSBjb250YWlucyBhbiBlcnJvciBiaXQsIGFuZCB0
aGUgcmVjb3ZlcnkgZmxvdyBpcyBlbnRlcmVkIGltbWVkaWF0ZWx5Lg0KVGh1cywgdmlvbGF0aW5n
IHRoZSBtaW4gNTAwbXNlYyBhbGxvdHRlZCB0byB0aGUgY2FyZCB3cml0ZS4NCg0KPiANCj4gQW5k
IGFzIHlvdSBtZW50aW9uZWQgaGlnaCB2b2x1bWUgY2FyZHMsIEkgYW0gY3VyaW91cyBpZiAxVEIg
c2FuZGlzaw0KPiBNaXJjb1NEWEMgbmVlZCA1MDBtcyBkZWxheSBhcyB3ZWxsPw0KVGhlb3JldGlj
YWxseSBzaG91bGQgYmUgYXBwbGllZCB0byBhbGwgY2FyZHMuDQpCdXQgc2luY2UgdGhpcyBjb2Rl
IGlzIHRoZXJlIHNpbmNlIGZvcmV2ZXIsIGFuZCBubyBpc3N1ZSBvYnNlcnZlZCB0aHVzIGZhciAt
IA0KSSBwcmVmZXJyZWQgbGltaXRpbmcgdGhpcyB0byB1bHRyYSBjYXBhY2l0eSBjYXJkcyBvbmx5
Lg0KDQpUaGFua3MsDQpBdnJpDQoNCg==
