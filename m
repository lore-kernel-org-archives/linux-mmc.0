Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D2B1C9DDB
	for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2024 12:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330270; cv=fail; b=OWlA49kia56E70gW9/FAQ/tyJQojiXiWfsKNEwhqSmLkJuiFRzOWzEJo82X49O15da0sW516xgvnpf4ZIBZQzpKjm4ipJEvSN6sfQ8FL9dXthqEomB6TdP1aLrjw26ajyOa2II/0biv3yTgnuYQox9EPDraiT3bOIhyOLA0M1Jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330270; c=relaxed/simple;
	bh=YDIFDrFw9QrsxyaAoHHz9rImhISKCVhg35+PYMiBMA0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OflXOhz4yUFI00aDW/f/BzwLNV44Q/QYa5eqle6ip4IuPTGPXbzb/qZM/qNsUyPhRoVAXq+UcgR7ONN839zlWhx3yzoYJqLA/0chmvpAQ/Q53m4fWG0zRMlGLvvYa48z8NZJ+KPBSnGW6ZJUU3pfcPL/YRjAs3HCE0aUPiAPdUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dhlRG4Ge; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=nb2zxliF; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dhlRG4Ge";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nb2zxliF"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724330268; x=1755866268;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YDIFDrFw9QrsxyaAoHHz9rImhISKCVhg35+PYMiBMA0=;
  b=dhlRG4GeKW3zCasTO9tRNeFlR1hOegsTHM9uRv7k8rPD8ua5YAlenSru
   OGKUzmN4YsA9b7RzO+ZgmBEiY25xx6Z5ajoZpF/JXKLTYJaZS4Xows5LK
   tyHatWdPPTfDxt13J2GwkvHBbd1qzoSWVm+aQERVDKYbbCxyoNOiZGLJI
   rX1h04LrlWv5d0Z2+Jfw6BZMfxmD2sW/picBNRdJPRVRtZHEdfjGMowUZ
   rr4UCaGYK5LCUaiMBGzoiofWRJlXQzcf4etQdLCIex5Whj5mQc4UUAgMF
   pCsDg/+63C7C+beWbb1SiN7j6844HXUibuJru68NVOaqKcEPe7sqDFJAE
   g==;
X-CSE-ConnectionGUID: LnngwoGrS2i6N5hSXp4bBw==
X-CSE-MsgGUID: bKXV7gUxRtGiI5xa7Fhx6Q==
X-IronPort-AV: E=Sophos;i="6.10,167,1719849600"; 
   d="scan'208";a="24283927"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2024 20:37:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PzLdE7H+Gq8t1hjKIm2OBpj1WI/nZMJ10d6gTzoCFqVOS0QS035Y4HWleVLD/959MHZ/hqOf7CXLalPFy67zOKpKr1FYSDhQ5Mysjela7uCqg5Bu2N7m5Dnq+a644W4hjn0i19bGwTqcfWqsW1dI3gY/SFy13RYedJh34M64OeBbxNOd3k1vAdzk1lMKhzh9Ws308SQDCrs+C/L/Vof2OM/v1SF4+RtqijvQJMLCWEngY7Fy5g0ZuE9F6kFyxT1QGOI0Zo1dl+MTed6HkMoHpjyuEi2IuucdrljWQoi5OAc/F6s3Lru7hNX4S3q7QksepENKbwJpRRhPLCxN38yf0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDIFDrFw9QrsxyaAoHHz9rImhISKCVhg35+PYMiBMA0=;
 b=t1DtTtC4BHKrV2q94hoqNahl7v0orMC4R9WUmgK6BtgE/cTPAmPM/LD2hKnCX59RliidpSHkSANdAJM2iPMml/lwPCrqZihYNgwUWKAA1Drs2I5Ae/VH26e7ogjQyRp3eixrwOlqhrHHNZ0w/Q06Gpza+V1QtLgvsKwi6fNjeiy1ZpgI+4pEYMMyaWsDs7IuC4ERqUewt4I9spR4fhARobidINDczhZBDt5Z612MzoZ/aTbyeLf9JMFU+4BeK2tfqXb1/I6GVpyAxOKPCHlUgR1pwM5ib1Y5uffojaPl6JSspptRip4urKhn3G34BLgkqkRMPXC+O2kysW1nHO5Rhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDIFDrFw9QrsxyaAoHHz9rImhISKCVhg35+PYMiBMA0=;
 b=nb2zxliFn4Np9bh24Aa+BjuFeqp6Bx1EVkwgX3SPUn0BeOZqKxSWQBt0XRrzRAGK8mUrW4OC8B+xyOVv+j/fj9NDZKqB3ySYV8yqhT5xHWgfAVcuITMkrbP7YWBH+gSSioB/mBAZrynZZI9rzZWyec6hZ/jxWYhQn469Cqg8GR0=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN0PR04MB8079.namprd04.prod.outlook.com (2603:10b6:408:15f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Thu, 22 Aug
 2024 12:37:40 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 12:37:39 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ricky WU
	<ricky_wu@realtek.com>
Subject: RE: [PATCH v3 03/10] mmc: sd: Add Extension memory addressing
Thread-Topic: [PATCH v3 03/10] mmc: sd: Add Extension memory addressing
Thread-Index: AQHa7hwC+CQNgix2hEWNeg8y9qBeWLIzN00AgAAMIKA=
Date: Thu, 22 Aug 2024 12:37:39 +0000
Message-ID:
 <DM6PR04MB6575C5D92FB32C5064CD169DFC8F2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240814072934.2559911-1-avri.altman@wdc.com>
 <20240814072934.2559911-4-avri.altman@wdc.com>
 <CAPDyKFqboXgBtK8uEV+17r5N+4GWgvL6e_wgLBztCaBDs2Ws9w@mail.gmail.com>
In-Reply-To:
 <CAPDyKFqboXgBtK8uEV+17r5N+4GWgvL6e_wgLBztCaBDs2Ws9w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN0PR04MB8079:EE_
x-ms-office365-filtering-correlation-id: 32775f4c-2bdb-4839-39d4-08dcc2a735cb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c3NOYnlpdVBqSTE5NGNacy9rdFcwVXcrNVI4Y29PYkQ3YnlDSXRZT1lDSVpq?=
 =?utf-8?B?ZGZUVEwvUU40cEYzeFVsQmYvcnVQN3dPY2F2dktYcndWaFBrYkJ1Z253cEo2?=
 =?utf-8?B?bHhsVUdKNVRqVnNtS2ZVeER3Q2M0S0dxVUZxOVYwcllPeWVzdDlBVmMwZXVz?=
 =?utf-8?B?eU1DYW54RDR4TnVOUytJYVNyNFA2aExwUUI4WFVQNVNSdkFXa3Q1dzVGblNZ?=
 =?utf-8?B?ajZ0S2Y4Z0hQaUFHZnBhMElRM0NwdElXeWVxbVJlZWlSSmNZbWFmMUppbTR3?=
 =?utf-8?B?QUdYaVcyQWkxK0JRUndvd1dmSXlLYXhuVHd4KzJ1eENraGg3Vm83d3BDUTJk?=
 =?utf-8?B?V3RVT0FtWTZGeVBFYUViSUNCYklCZElXRTdXWXplUnA2S1J3Mlg0Z2VmK1l0?=
 =?utf-8?B?QlU5L250Sk8va2x6dVYyOVJPZG1ScjJ3M041eDZMUk9DZVp2M2ExYTBPcHdv?=
 =?utf-8?B?eE9CL00vRVhyd3JRdll4V09jQU10dEVnTWQ4ZDFXcFhNR0RXK3lJY0VGZGFW?=
 =?utf-8?B?MS9WR21VU2tCNjl6aVVISnN1em55OS8wbVhnWDhndWhpYTZaTFU1Tm02RlJW?=
 =?utf-8?B?NTVqRlVhaUxkSkloYUNBQ1lrUTNrMUVJZDR5enhRRVVuYVZFUWpFV20zc1Y3?=
 =?utf-8?B?Q29XVUJUdUg5UDBtWXpYVndQZXIrU1dtRXNSdll3eTcvN2tLZEUyczV1TTBN?=
 =?utf-8?B?cFBERlc0OVZETThCVFVaanNkU2dydEtTcEw3Mm9WNDZtOHQ5dkNIaEJkN1Ev?=
 =?utf-8?B?VjdlcWQ2VnNMVlFONlJlWDMya2doQklpR0pFUEhoNEJKRFVqOElpSUd3ZWJW?=
 =?utf-8?B?cEtQYy9kNzBOUDdIdUl3eGJPM1d5czdibmRTUW1mS2t3ZHd4OHlRTmM4d2Jh?=
 =?utf-8?B?QzZsbXE3MHVrR3pSZDZ0cGtJeHlSY2NIc3J3OFl6WkJPbURRMkhrZHpLZ3pW?=
 =?utf-8?B?YzFydHlDR2xybFJqYnhmdEh0YlNvQ1pENVVIRHhCL2ppckRPd2NTa2F3MUlY?=
 =?utf-8?B?a0FjaUMwY0FDaGFtR3NYY29VUlBHUGxmcjF5Z2JaSkZmYXNvSnpESVFZc0pS?=
 =?utf-8?B?QWtPWlBYNkhtUlpVRlhUcms2ZXhVRmdVeEV1THZQNXJtMVptTTNLNER2L1Jk?=
 =?utf-8?B?UVBxaTZKSUx5YkR2L2NGUiszb01qaEF3OHpzVGNJUFFOR1BFL3cvTXVGdWY1?=
 =?utf-8?B?bWFHeVllbkc1dWVobDZEcERhL1JQMzhNWHNwaUk2S051Um1JTENuUUJjTytY?=
 =?utf-8?B?YUpoWk41OHViem9SRkU1YUk1ZCtNZkQrZUhMdWpWZlBXN2dzRUxrM2FvcTk2?=
 =?utf-8?B?ZjFkSFlraGk3cjRhZE5RSG1IUkl2em1wZGR4bkVhaGIrdm9qQ1BLRUZXalNG?=
 =?utf-8?B?NFMrZzMyUXcwNmFnV05kZzcvNXdUTU1wTk5Nd3BSNUMxMjhacmQ4aFIxbENI?=
 =?utf-8?B?cG1pVkxKa0hGLzFCd0pYVmlqOGxQbGNHdjMxdVR3Vis5Zmp6UFJtelIwQU5R?=
 =?utf-8?B?RjRyTnRleG53VkZaWlFMMlErK3g0L21EcitKTTBPRm85QUpNTCtzOTRwN203?=
 =?utf-8?B?VUMvOU1COWl2WUppN29qWThnNm1keGJvKzNQWTdZeHlRMTZIdjk4V21RRC9Q?=
 =?utf-8?B?S0M3eG1TaTNubWVPMk1ITXVDY25BUFl4NTgwb0FRUm1aMUVxM2pXUHN2czg2?=
 =?utf-8?B?MzdwSXRYZEViY0JXM1ZLalp1bTgwN1FyYWI3SE82TUZkK0VCc0FiSENqdXZI?=
 =?utf-8?B?QzFLeDNrSVBjL1M5T1Vhemh2RkFlL0lTc0FxdHlQYUM4M0RDZUtNbTBrU0Iy?=
 =?utf-8?B?VmovSjc2UjVwUm9POUNMTEJTdHdHNkRBZmRzUXRzZkswK1lGSWRDSm5ocVJI?=
 =?utf-8?B?bHl0ZGJXUEZneUtoV3M2ekc1OEMxOFVab3FaRkREYko2TWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OWVVNWxHcitwRWd6M0lBL0k4SWw1Uy9XejZQNCsxS3k4eDgyaTVxaU5Yc1lr?=
 =?utf-8?B?NTJzVTIwdHFsZk9OY2hjVC9GOTg4YTY0MjVHTkV3MmJBSjI5bzNNZ3R5c3hy?=
 =?utf-8?B?QVlGMnRWRVZEN25RVzVUUytXKzVsQXRyRzMrNVZIUklMbDA1MURmaHJNdUcw?=
 =?utf-8?B?dVk4MFVRSEwwdGZsMUpvay9rS1NKT1UyanBURjc4dlEwNVAyN0VtcHdqek5n?=
 =?utf-8?B?WjltU29MTHY1NE5FcUVFcmtyK2FzS3ZFeW54aXlSbGhINERERVJjekhEdmhk?=
 =?utf-8?B?KzU5VktUNXRVTjNHTjBoRGJmdEVXcWFQUW1pbXY4b0VIMDQzdHBQdWxiemNJ?=
 =?utf-8?B?ZU5CanZSS3l6Y0l4ak1NUDY4cFhJdllwRkxYZStVSUZSMGk3aG9OaGxubVYz?=
 =?utf-8?B?K3JNU2oybFRQOTR1SVQ0eFBBRHdaOWs4ZENLdWw5cUN1R1Q4cm9XS1J5Vis3?=
 =?utf-8?B?QVpuM3RQaElReTVxUkY1Zjg1RmNTbmNYV2M1K0JzWTI3V1owbFpKNXJwVE9C?=
 =?utf-8?B?L0pMSXRGQlJGNlJmUWI2dUxwUkZvTThieVBsUEN5TlBHVnlBN25HNCtmK2NP?=
 =?utf-8?B?UnpLWmJ2TGNYRitvSHp1eTNvMWdBMHNTa1lPR3RWUWdjbGxpU1RKUENCUjIv?=
 =?utf-8?B?MkZSK0U0dGJqYWJuVENNUlhac0NPTlhNQUNxMzFtRkp4SFZtYzVzTDBIeXA3?=
 =?utf-8?B?bzNEY0hPU0lMSTlvR0V4QTk3dmdibStoK0ZhTisyRXVINkNIdlFrY2g0TUNM?=
 =?utf-8?B?TEpTeXJkRXUwOEpCek5qMUJua29qMjlpa2FaSEQwVWI3NkJ2ZndJcnBxekFL?=
 =?utf-8?B?TnVYQWNEbnVLVDVDRDF2ald3MCtHZFlsOUxkR2NiRU4ybitmTmxOVDlwUzFL?=
 =?utf-8?B?bDQxZ05GN3k0MzRWTHhZeVRQYU43cmZrUTlBWElxdWVRS3BLUmVKN1VMNzR0?=
 =?utf-8?B?Y05rRFRreGdRNzYyVFExaDI1dncvQjRacUEvQWl1WmJDTzVObXJGNXoxQkk0?=
 =?utf-8?B?cEVTWC9VbTNVZERuTWtBbXJSc29YZFFzOFRKTHV6NnRUYk5xeDFHeGtHSi9G?=
 =?utf-8?B?KzFXZHh4Vmh5empFWnhUVEhwS3d2eFdsZmdRVjdJWFlEME45enZzcjRXMkFk?=
 =?utf-8?B?MmJWZElDdVEvUm5qL3lOOVEvakJFLzdTNVhkR21SeGRPemtxVmVoZDZuck9J?=
 =?utf-8?B?UVc3UnVnYkh3Vk9aV3pEbmxpTGpMTEw4UDgxVUNCaE1KVVEwTEVnSGIxT2F1?=
 =?utf-8?B?ek1ocDhrYVNhZyt6bW9DditWamFrWEhyOUZqMDVucE13RHNCMXY2S0FZRnU2?=
 =?utf-8?B?aDczVm1VTkRNem1OdThRUDJUQVVXN3dUSCs0bXpTVXMwTk0zb1dFTXJLNjVT?=
 =?utf-8?B?cTNXMjJjTllIaUIyS3YybkxkUTU2ZkFiUFZTMDZ3VGxBYSt0QXRtcU1CTTdE?=
 =?utf-8?B?a3pKNStkcWNTYnZMQnZKNDRpaEgvTkNuVlFkUnVIa09EMGM5VnFBcmw5YTNs?=
 =?utf-8?B?NFFLdTQ5Um5jTko0dGR3SlBoUGNFa2NYODNERXJBWjlMVTNhQnpxL3NUU25X?=
 =?utf-8?B?WFZjY0RJOFlNMExNR1VwcjRWMnJkYlAydWIxYlp0d0VycUJ3dFpiTVIwWk8w?=
 =?utf-8?B?MTZXbVJ4dmc1N01oK2xoaGVRWlMwb1ZTQ2NIbWNVYnhCd051TERDOTVZM0VN?=
 =?utf-8?B?WXM1ZVplYUJLOXYzMDduTVhIT2Zqc0JSOEZLa09oV3Z6TEpVZkRBK0xSclRu?=
 =?utf-8?B?aFhVRFRIc0ZHWFFIVGo0RkNUQW5zMVNRVisxQk5QMlJvZE1WMGFrTHp6VFk0?=
 =?utf-8?B?VHhmNDVxM2FrQkdZdTJGN3RZQ3VTNzUrRDhEWnhra055eDY0RVVIS0FkS1hq?=
 =?utf-8?B?VUxybTc1ZlV1RWNheGdmdnpJdjVLejZSZlI3ODQrRWhqcGg4ZEV1Qzd5OXBB?=
 =?utf-8?B?TFY1TXM1MllhQ2FWNlFPM0NNbWR3eVJCM3FBYWRRR3VhMEVBRFBUNFdUUjls?=
 =?utf-8?B?NmtablROMDhyREgra2Z2ODJsYXZvYTVzQzV1VTFqV0N4aW1rc1pkM3piSWIr?=
 =?utf-8?B?bHlOQk5jZVg3dkRxRWhybmVCU2FESU45VU90aDZFeVc2OWowTkVJUmFWTzBh?=
 =?utf-8?B?SXFQUUMrcFlsMEZQN3ZXV2ZpM1dUZThvUnVSSmNSNy9iZE1OcmdBYjdQKzZF?=
 =?utf-8?Q?cIAb3TH+HgdJQszgLeeXfKDhh29ivRul+KyWFIIS9hxK?=
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
	598F6HmMS8Au4ZSDj2bkG0T3lIH5ZfQXBD9HSTeND7YBM+FxmFFroYGT98TEnjRMxpCd4VSrStQMj73IgMgdQsRrtuiXmuA3tAWBTCyb6OIIFYjxyWeFDrcxGzJmt7/9/49z2woeuap1aRZliz4RzPr9OvZ990UaKEE8upu5QHr5NtdZkBEWx3yN3O7zx6HSd+ipC2oUZSKxoPqsqqe1C0KLSfLRcjDYzdbbNVgv8tAaaYNGg1k2qGDwcrvEtXZpZDSjcXd6c1gaiBcJ0NuuEHswZTVCW3v6iOAlogb5Urg4OfWC/G+CrWR2X/g94W5mdhBiYpmGI8rJz5govfa7nSdgt9wUc9pJn8yue2inN8ppePTPnkKXc/+FbJFCmcqePK04r4j5jMPXsy6UvtG9Dxa14QJdsclRSeuVTK3MRPgG4+p3KrtDkmh0NdINSPfaUV03FIIJB1wNzqz4a3JK5FMAtiyvRkjxLSAXarkF1lErpudHYwhnKnOZDHBx7SrDmex5lyjJ3KUutdUkZNWKjwiWTfhLsRapkrfhSlzMmMXPcxHtahxOuazmIlon00laYSr4n+4FP5VYg1y2VnrFkHqKReU9PeDvd7hGkjqvefkXt4XYHPzFGZftp2BpI2ms
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32775f4c-2bdb-4839-39d4-08dcc2a735cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 12:37:39.7488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +5eIgN3+Bq1mXAWQoTn/C8mXXJxGKP5Jie+gRkx03Ng6652jB7TzaCsXP8MAicUDpmdR3pSLPJf4nPJXrNUHCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8079

PiA+ICtFWFBPUlRfU1lNQk9MX0dQTChtbWNfc2VuZF9leHRfYWRkcik7DQo+IA0KPiBXaHkgaXMg
dGhpcyBleHBvcnRlZD8NCj4gDQo+IEkgd2FzIHRoaW5raW5nIHRoYXQgaXQgc2hvdWxkIG9ubHkg
YmUgdGhlIG1tYyBjb3JlIChub3QgdGhlIG1tYyBibG9jayBkZXZpY2UNCj4gZHJpdmVyKSB0aGF0
IG5lZWRzIHRvIGtlZXAgdHJhY2sgb2YgaG93IHRoZSBjYXJkIHNob3VsZCBiZSBhZGRyZXNzZWQu
IEluIHRoYXQNCj4gY2FzZSwgd2h5IGlzIHRoZSBFWFBPUlRfU1lNQk9MX0dQTCBuZWVkZWQ/DQo+
IA0KPiBPaCB3ZWxsLCBJIGd1ZXNzIEkgbmVlZCB0byBsb29rIGF0IHRoZSBmb2xsb3dpbmcgcGF0
Y2hlcyBpbiB0aGUgc2VyaWVzIHRvDQo+IHVuZGVyc3RhbmQgYmV0dGVyLg0KSSBleHBvcnRlZCBp
dCBmb2xsb3dpbmcgYSBrZXJuZWwgdGVzdCByb2JvdCB3YXJuaW5nIGdvdCBhIGluIHYxOg0KPj4g
RVJST1I6IG1vZHBvc3Q6ICJtbWNfc2VuZF9leHRfYWRkciIgW2RyaXZlcnMvbW1jL2NvcmUvbW1j
X2Jsb2NrLmtvXSB1bmRlZmluZWQhDQoNClRoYW5rcywNCkF2cmkNCg==
