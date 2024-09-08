Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEB836B0D
	for <linux-mmc@vger.kernel.org>; Sun,  8 Sep 2024 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725797572; cv=fail; b=VT/LoBt+1ZfN5PaZciq7HcMlhi0qZWkcDvEn1S7LRSqUYEH5uUVTVOo0+we/o3dKXCnHdRcOJ+cmvfJ6vwvqbq2nvNBhEQ2DecC9YlgK5s7gUKmbdwPLdP5TQYwHqiSI47qxh6gnnIU4Yzqb7pYATCXCJqJCyBU1tbGMrCzrPH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725797572; c=relaxed/simple;
	bh=w7FWDa4LwHL0MBB2YgMJFXBRkwh7qwf/ORXCySZWU9M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gTJrHpZSNmNW6EWGEPNI3dK8pDZofG2AvxiTG70wiKBIuq0JCgKDyhgm9kz6ZVG7YeeMVEKLZKbMHo+Vmlm6SC+LzbKvhgwZZjMBVyei616X+gdF2YMDGrs4p8iMEHkvicAGU9dphBLvfVYJ6cj+mG6cJxRlvpouPuwvh+AYvIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XAqhMa4U; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=YXHTqsXv; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XAqhMa4U";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YXHTqsXv"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725797569; x=1757333569;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w7FWDa4LwHL0MBB2YgMJFXBRkwh7qwf/ORXCySZWU9M=;
  b=XAqhMa4UdiDOvGyLH7C3xKnsnDzd7xp+/5YSK4pMAPJrG0wlcce7dS4R
   191idCsOcEPf+997ETiPM2se0DKB5wF40HRRM1d7XLoqpw8RMPPXOSLGH
   i7jmUV5LDpMGyFmFoH+ucadk18FVc/OyC5YvNe+ykKdV4lG7rsXTQQgTM
   TqDIPR8nvHY3W70mSmchF89093lSiLlgfWxS8TYS8BTFSBhyapA7JtMU7
   Od2h2SaD7DUXlK3uSpPg8f0YYRlNxRgWn/BpdZbWaC0e8ncQEgbSGFk7R
   zDZxWEGp2C9BZOF6NiXlNyKT98n24rARqIJoULKNRZGW7efWDveC2kRT9
   A==;
X-CSE-ConnectionGUID: Oww6JoyMSlKZyY93g6JOwg==
X-CSE-MsgGUID: 2Fl84VkgQAeiWFQEUn6pTg==
X-IronPort-AV: E=Sophos;i="6.10,212,1719849600"; 
   d="scan'208";a="27192624"
Received: from mail-centralusazlp17011028.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([40.93.13.28])
  by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2024 20:11:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Py/2AFjbeYBNqeISSqsYJSU1bxap3Mxi1GxPFwBpWGZE4ciDpr/7sIWGD9UVYGnezkhHCZT6Ox8P0kS7zJ9Squ51j5q2dsJyWcBBY0nCocd7e+1HFNDK5m7023/7nf27L2WdB8olsqlghowZ/1Ab+6khK40LrKxAX1NmEzBMYFRIOP4+MypWiWO69P474sVHpdvEEevTXaPliJZpxpEWhOH/0JsjdHh2uAF6CLSdQhDmSBGk2MIpmHyhXZE0U350OoZpLh2jooetXCXU5pB2flOKMKTZP8WxovWiaJU98Jwipk16gi3AkRva/Q4TioFDvLwlT0ZBs4QlVn2DR4Mtdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7FWDa4LwHL0MBB2YgMJFXBRkwh7qwf/ORXCySZWU9M=;
 b=wM2K1dlYUPHamZXwKmRXc5JF9AFFKciP0IWlIAYHPu3MJGm4CegCmTAzmAeU5I4x01eUqWYYrPnLZ7qNLrn9jvXct9QVa2EWZPmUQ+ZaSE+m0MFtm3ETdsj7mYSQ1O8vRV5rFkp82Ai2eMbEeNYfwXS3gjGAzSCUcaKoCHbHg6jWZ9Yo8q/Fz27Ag2SXDDc19igLTY6fLrvP7eI7bOfve/+TLlark1cY0Hw7L5NvhptsXZs0iLo+tQnVQI2AihGQa8Nsfn6d5biUJvTy1J/WywqdurNjC75V/nQY1Dc6+MINk1fCj7q4wKMjmeEHBZWk/XDYb5ILMWCy0ih/l6yTSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7FWDa4LwHL0MBB2YgMJFXBRkwh7qwf/ORXCySZWU9M=;
 b=YXHTqsXv5767mjyJ2OODL51GkJoNQtUV2k8bvUbrkQi9YXRD3YGyeJeeJiPHOhzBCgJsoHYheVgcBfuQOtkEuRzuf9iu0VxufmXGlQbft+/2Zuz5oUehr3TnCHZZYt0vBDqBZ4bMsya7uiXqe7TA0nl7DlOMVDaLxusB0IAn02w=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SJ0PR04MB7597.namprd04.prod.outlook.com (2603:10b6:a03:320::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Sun, 8 Sep
 2024 12:11:38 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7939.017; Sun, 8 Sep 2024
 12:11:38 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Christian Loehle <christian.loehle@arm.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: RE: [PATCH v7 09/10] mmc: core: Prevent HSQ from enabling for SDUC
Thread-Topic: [PATCH v7 09/10] mmc: core: Prevent HSQ from enabling for SDUC
Thread-Index: AQHbAdkMBvLgh5DIsUSlSwPzCfYQI7JNytwAgAABUWA=
Date: Sun, 8 Sep 2024 12:11:38 +0000
Message-ID:
 <DM6PR04MB65759D7DE903446671DF8D1EFC982@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240908102018.3711527-1-avri.altman@wdc.com>
 <20240908102018.3711527-10-avri.altman@wdc.com>
 <6cb63826-e6b4-4e3b-92e3-5a5c912eedea@arm.com>
In-Reply-To: <6cb63826-e6b4-4e3b-92e3-5a5c912eedea@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SJ0PR04MB7597:EE_
x-ms-office365-filtering-correlation-id: 513c798f-75c8-4fac-ffc2-08dccfff6461
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TVhwUlE5MmJSZWFWdDBtU21UaGY0bzRndnRDU3JpSExRNlVsV3hZVFdidDlM?=
 =?utf-8?B?TmM3VUxTaUdaaW15RXBYZy9haGl2cHdkOHJ5YUpVTS9KYWppYWg1aHRaMHhx?=
 =?utf-8?B?WkJUenN2bGl1MllaL0l5U0kzajFuSWlaV3YrMDVRWG1UQThiWllXVW4yamV3?=
 =?utf-8?B?KzEraU1tbWduZ1hHVFJjNlFZcTl5SWMzOE5HNkpiRkRWMmVrYVZJLy8wdlpW?=
 =?utf-8?B?WkN4SlFnbWVHVFZyL29PQlpCMXU0RkVqdHJPUzdsQTNEZHlXb1g4eE5RRG8z?=
 =?utf-8?B?NjhXdUhVdEtjcVU0UGs4QXB5TVdpVkhlZzBaZkRVVUd0RFBwRlNLYnlMWmxF?=
 =?utf-8?B?VEpRa0JLYjlsb2hOc3BJZ0ZTQUxjUzJLekxQd1pycGdlUXJ4Um5wQ0E4M0R3?=
 =?utf-8?B?WGJvRFBDY0dKTjdWWDZxcXNrMHpMUlpyTGpySUhtTHR6SkVoR09QKzZ1eXZU?=
 =?utf-8?B?d3l1R0xocGJyd29DQjd6dWxCaEkrMGpWWnhreGNMemxIM0EzQWdMQ2xkOXFS?=
 =?utf-8?B?MlhJaFI1cUFtcUlrWkN5RTA3YWZPUnREZFFQblQ0UFA1M2EvZjRDYTUyUndu?=
 =?utf-8?B?OTdFd2JkWDN2NVp1UGZmTEJ5UFVCNDFHWisrT3EvNmxPU1VDUDFUWG9halBB?=
 =?utf-8?B?eFhyTDRPbVhYWEh3SmRqd1BTTk1Ua0NDa0MyNnFIUGt0NE9BcnJBSUhFRytV?=
 =?utf-8?B?QVdoTVdQVjFrV1doMmtTWmQydldBbEpLcEVQTEpYUzdFaXA4ZHVaeW9Xc1RM?=
 =?utf-8?B?R0tSVDBxaUpTVUJsWjJnQmZnZzNhK2phOVd6Sm9ybmtaM2ZQVDJkQWFaSit4?=
 =?utf-8?B?Y3BCL2hBcjNWaUdvUGFmQm8wekljWXJYSE5uS3d2QjEwMWVnRk8vbjdPK1Qw?=
 =?utf-8?B?Y01HM05pSlk1c3ZkUFV0c2hLRCtkaGxsYkJ6VzNSazJPSDdKTWZmRVZUTnI5?=
 =?utf-8?B?ZjNHNHIyVTlNYnpRalpBQ1VkK24rbHF6TTExZnB5QUt5d283d044ZXJ6NU83?=
 =?utf-8?B?V21JelZ5TDE1RStpT1dMZXVEV0VZVEQvZTBjS09FMnIwRnVGMlJhZiswcG9H?=
 =?utf-8?B?TDhBK1VIRlFLMjM0d25RNEZ0STBDQ2c0UGNMMmdnbkJtZng0Vm91UWJxZkxB?=
 =?utf-8?B?WVR1dnF1aTVqb1psMU5nYXJtKzdQcXhHVVA1Yy9QRGhxcXZFUGNWT2hLTlkv?=
 =?utf-8?B?Vmhub1B5V1hSM1k1WGZ4MUlGN2NmY0kwQVpQTHYxR2FYQXlQQ0t0LzJFNGw5?=
 =?utf-8?B?bG12UVdSNU1KcnpqUmkzelY1MlRvemU1WmYxL1VaYnU3RGJ0OE54bmtSVjBI?=
 =?utf-8?B?ZWVWYnB0WExEeUZuSUxnaWF2WmIvdUQzMVVzbDNrSXhwU0kzZmpabTBwTCs4?=
 =?utf-8?B?Nm15cUxnL1NGT1Y5aXcwWkZJeXVJVlpRdTZRMENMblVQa1pPWTc1czgwKzJ6?=
 =?utf-8?B?QnV2d1BWWElnSDZtTmdpOGo2YmJkZkJzMXRIeEM2ZXJNV3ArS0RqV083czBG?=
 =?utf-8?B?M0JhemUrK1lGZ3JsdVRBbkxnZjR5WFIydU1pdmJWSWQxLzBMRXhmY1FCNDNC?=
 =?utf-8?B?MU1xVUVFTlY1RjBDTThXZ1VTS0tUM2VPV0lMdXEvckliazdUc2VDRHcrL2VH?=
 =?utf-8?B?U3h0U2xUbUx0ck44MUVTbHhGaU5FV0JESjBhNDNqekhocE5LYlFreGJYMmQv?=
 =?utf-8?B?cDFWSitWOHppYStTbEdFY3B1WVZZREJ6ZjFTUWF3alhWQXc0U1Bhd2NQSmw3?=
 =?utf-8?B?MEd5cXNGejJoS3BqaGRtSDg3dTY2RnBMZGtFVHVoK3BwdDYrNHFFVzBTWjl2?=
 =?utf-8?B?TzRjdHk5ekJZelltRVZWcGFCL2ZhT05zWUoweTNwQ1JjdlJuTzg4SlkxSTF6?=
 =?utf-8?B?aVEwSEhjOU9DdjF0TFg0dHkwSmJuRWp4dUd3bmxPdGxPMFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MERvYnBNOEhneGtYWHNTVVB4UDBmSlV3OWw5aFhVbCt1WkhJbzI3aTRjRDBu?=
 =?utf-8?B?MGdzc2RpNHFsbVE3aXdrZzRNelBHa2pRZVVIU04wT1B2VENyeVdDVGRLN2FM?=
 =?utf-8?B?R2UvYTRYTStnQkx5K0J2Q3pVL0IvQ1h1aW9iTU0zR2pvK2tibXVtVDU4VmM1?=
 =?utf-8?B?UzM3QnNOdmFVZlhFbitmNWY4STBTK3FNUlZxRjIrWW9FVHFyMm9jWFUzYjNm?=
 =?utf-8?B?bTd0T2Q1bXlGbG9tSzc1UUhRYWhuRVJKVWtvQ2JpVTZkaHIvc2h4anovb1lx?=
 =?utf-8?B?ZmNEK2pqczladWtTc3RBNnNLMXYwbFVwTHRhdFQwOVpmV3ZxY2RxcnBTRS83?=
 =?utf-8?B?QVF6YWVjVVREQlJGZ2FWeHUxMlEyVUdwRUs0eDNYY0FUQjNiNTlnZi9RQmFS?=
 =?utf-8?B?UWJYVEdzLzQxTnhHUTFETEcyUVZUbUdMcld6VGZpY3ZaVjVqais4TFN0d1I3?=
 =?utf-8?B?Wlk2cmdkc1FBa3cwQXpuZkc5NGdFVjVoVE1GdWMwRWlNTmpDMmFiOHJVYS9Q?=
 =?utf-8?B?Wkt4aldmK0lzU2FneTNSQUcxclZub0R2Tjd6V3ljM2F3Q2Eybml1eHYwMHdn?=
 =?utf-8?B?SWozY3hxSEhHc011ZnA0RG5NNTFDOFk2ZUF6M3BRS0c1UU9vcW9Qb21wbXd0?=
 =?utf-8?B?Y2RkWDdvZDhjdU1xUVVrTmRqNy9mMGxuUVMrV2hmbFZsUy9DVm9tOW5OWWEw?=
 =?utf-8?B?SnIrcGlkREREeityUE1BSHVaRWdkUGMvbmxkaXVhSVg1N0VqbmRka1JIZWlV?=
 =?utf-8?B?Z29pZ0hjTnRtdHhFTHhJUy9LbktzSmU5bVlzSTJlaXBYbE5xeVZhUmRod0d6?=
 =?utf-8?B?ci9jWjEzbGJWUFhhZGJrM3Vubm1PWmN3U2x0Rjc4WDEvNDFUcTJHZ2ZBaVNX?=
 =?utf-8?B?WFkzc3ZwNmtoK0NpbERJSjNMN0F2MXhSQzhnR29nYmFFRTAxRXBsRjBoY0NK?=
 =?utf-8?B?ZGw3c2Y4SGVYMWhidzB5Wnd4aVNOdHgrU3J3TC94cGRXdS84eGVsR0lxWHhW?=
 =?utf-8?B?TkZPM2ovZE5WeElnUThZZS8rQlNCVWJ0ZUlWUGd4VloyNFZxbEV1T29xaGNB?=
 =?utf-8?B?UEMzcGQ1Z29uRE5qUmh1cGtIckZQY0ZIUXVnU3JNaTJ2WFlxVHRRalo0dExV?=
 =?utf-8?B?L1ArODZRS21IZ2l3Ynl5cStIb2lkU1czeDhlanRweEtOMVk5dVVFelZVVnRC?=
 =?utf-8?B?RHpsUnBGR0pQUW5OWmN4WWxuNFgwVFE1V2thNnVFVm9lMjAwMlJVTFB4anY3?=
 =?utf-8?B?UmgwUzNwS3Bib28wTUQyOGluNFV2bEpYT0FEZnFmZ2QzUVhRYnNXd1Nsa2Jw?=
 =?utf-8?B?YytjaklxVzBXZ2tLQ0xwcjE5ZWtTTit3SmRqYjBtMDlVVVY1MmVFbFV4c3JK?=
 =?utf-8?B?UGVsYlp2Z09tRXJkNnV2amRsRGFzTnZHRC94emRBTzJqSGs2bERrdUUwN09j?=
 =?utf-8?B?OE1XU1hEZEsycFcvMHRiSGY4eVVRY2xobFJIY24zNldWa0VVR1YwSWtzK2ln?=
 =?utf-8?B?TDRaTWdNV0lEa1VIWkVTaFJ1Yzh5TDZVdTMraE5NbUVlWUk5Y2wydVJkNDg2?=
 =?utf-8?B?VW1UUFlSWlg0d2tuaS9WRndIQWNKaVpPMWw0S2ZVbm1VcWUwY2RtUWVIV2J1?=
 =?utf-8?B?Y0dqdzAzelI1T3p1SkJIeDRPQkwzdi9XYUI3c3hkRDdFTzdCTTcwb28ydVNv?=
 =?utf-8?B?cFlUUjJMOVRkSFYzS2lrMGk1SGNvNEF0RU9kZ0syS0ZieGxOMUZBRHk2Y2tH?=
 =?utf-8?B?YXBubFBuUnhPUTVXTG02YnJ3VTVjL1dMUGxRbExxeHdqelVmdEQya3RhU0pQ?=
 =?utf-8?B?WnZSUk9ORXpWdnhQSnprVnhsb285TzFrNGdyWjJwdllUY3JZejNyNnNUQnB3?=
 =?utf-8?B?ZlI2MDdQajA0VkhZcDRHY0JEWXVmYzRIdkgzcXBpTEpvN0sxSHNENURYMStE?=
 =?utf-8?B?cHZSUWw0UHB2OXpZQlhCeDFLcVBxZ3BLMGk0eFpBWkNsU0FDOW9RY1QxT2t4?=
 =?utf-8?B?eEZuYUFudDFCK2hiNU1HL1VBZU9uNnVIZGxKRkpqS3JxSm1rdUdqWVNXd3pT?=
 =?utf-8?B?RWxJZjhXTHBha3p5Umw2UVBTamE1dmZ1bkVOc2ZsYjdJQW1SbFVGeVJYMVNM?=
 =?utf-8?Q?SXVdxqlp90Biuo1qHl5h+UeCW?=
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
	qjCWMXZJUbGr1LPIpjS92ymrzQKZEjpGQGXXe2LoT+eiG3Xa6tho+X3D1sQBTpQBk1WSUvHaGOjZZEktIUSnMM6RDIptJ0d554tbUy+OMbApeFAlZXfPvGshGM5dD4CBNOBDbsO2H8cXd61w/06rdFHX3y3NZ9rQ3zx+Yh2pHwDSuKjAx6YbEVeZRvix1AhLqx8UVnzyA38/fctlMFzDSZplROsxLEyyZW3Fcvvpj1I6nFls/OjorMqt9betO4DBiEJ2oSwwNQcR/pXiirgbkErzDBU/CqD0HSntlvyz6h5keARXjSWbfg/s8ceEuBTYWkZaIIU0XncnwjE+Q6i8esri6xeL6OqjBu7jQXkKegtKtYu5SMm6mEu2WhDTv0tiYQy9i0SGHjTS9y4Cxf7gLLka2GKK0aKhK/QvCr3Z9mZa6W/plp+G5Hv9FRBSPDIBsfjHIU/OQHK3/dj7Id41qewqRCMCfXpEp/0aYlKTSA0TugqBXyR+Izm9gSY4yJNjyevHeBOaLop+CaF4vMCGEMTksVDZd7kdZzu7UYob/dTdwLtgp83ze85Ey7hCYipfd4AjzMKWSaaxOu6C/JLLguBV2nG/0IVMF3JldBl0JsqN9qYcCMg3wVNdXLJVjepP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 513c798f-75c8-4fac-ffc2-08dccfff6461
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2024 12:11:38.7330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: //RQumAncL+zY3g9Q9+Uwy/AQh6XRX4oQob4TQ1aWc9jnf+CjF6aAvFemrjmzDAOaI1PYwVua2G9VhdSSvhvBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7597

PiBPbiA5LzgvMjQgMTE6MjAsIEF2cmkgQWx0bWFuIHdyb3RlOg0KPiA+IFByZXZlbnQgSG9zdCBT
b2Z0d2FyZSBRdWV1ZSBmcm9tIGVuYWJsaW5nIGZvciBTRFVDLiBJbiBTRFVDLCBDTUQ0NCBpcw0K
PiA+IG1vZGlmaWVkIHRvIGluY2x1ZGUgNi1iaXQgdXBwZXIgYWRkcmVzcyBieSB1dGlsaXppbmcg
aXRzIHJlc2VydmVkIGJpdHMuDQo+ID4gRXhjbHVkZSBoc3EgZm9yIFNEVUMgZm9yIG5vdy4NCj4g
DQo+IFRoZSBtZXNzYWdlIGhlcmUgaXMgbWlzbGVhZGluZywgYWN0dWFsbHkgaHNxIGhhcyBub3Ro
aW5nIHRvIGRvIHdpdGggdGhlIGFjdHVhbCBDUQ0KPiBhcyBpbiBDTUQ0NCwgaXQncyBqdXN0IGEg
aGFjayB0byBwcmVzZW50IGl0c2VsZiB0byB0aGUgbW1jIHN1YnN5c3RlbSBhcyBzdWNoIHRvDQo+
IHRoZW4gZ2V0IG1vcmUgaW4tZmxpZ2h0IHJlcXVlc3RzIGZyb20gbW1jIGNvcmUsIHdoaWNoIGNh
biBiZSBwcmVwYXJlZCBpbg0KPiBhZHZhbmNlIGFuZCBiZSBpc3N1ZWQgYXN5bmNocm9ub3VzbHkg
dG8gdGhlIGNvbXBsZXRpb24gb2YgdGhlIHByZWNlZGluZw0KPiByZXF1ZXN0IChpbiBhdG9taWMg
Y29udGV4dCkuIFNvIHRoZSBjYXJkIGlzIGNvbXBsZXRlbHkgb2JsaXZpb3VzIHRvIGhzcS4NCj4g
VGhpcyBpcyBwcmVzdW1hYmx5IGJyb2tlbiB0aG91Z2ggYnkgdGhlIG1hbmRhdG9yeSBDTUQyMiBm
b3IgU0RVQy4NClRoYW5rcy4NClNvbWVob3csIEkgdGhvdWdodCB0aGF0IGhzcSByZWxpZXMgb24g
aHcgY29tbWFuZCBxdWV1ZSBlbmdpbmUuDQpJZiB0b3RhbGx5IG5lY2Vzc2FyeSwgSSB3aWxsIGZp
eCBpdCBpbiB0aGUgbmV4dCBzcGluLg0KDQpUaGFua3MsDQpBdnJpDQo+IA0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogQXZyaSBBbHRtYW4gPGF2cmkuYWx0bWFuQHdkYy5jb20+DQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvbW1jL2NvcmUvc2QuYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tbWMvY29yZS9zZC5jIGIvZHJpdmVycy9tbWMvY29yZS9zZC5jIGluZGV4DQo+ID4gMWQwOWYw
ZjJlNzY5Li41ZDM1ZmM4ODAyYzcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMvY29yZS9z
ZC5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvY29yZS9zZC5jDQo+ID4gQEAgLTE1NTgsNyArMTU1
OCw3IEBAIHN0YXRpYyBpbnQgbW1jX3NkX2luaXRfY2FyZChzdHJ1Y3QgbW1jX2hvc3QgKmhvc3Qs
DQo+IHUzMiBvY3IsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZnJlZV9jYXJkOw0K
PiA+ICAgICAgIH0NCj4gPg0KPiA+IC0gICAgIGlmIChob3N0LT5jcWVfb3BzICYmICFob3N0LT5j
cWVfZW5hYmxlZCkgew0KPiA+ICsgICAgIGlmICghbW1jX2NhcmRfdWx0X2NhcGFjaXR5KGNhcmQp
ICYmIGhvc3QtPmNxZV9vcHMgJiYNCj4gPiArICFob3N0LT5jcWVfZW5hYmxlZCkgew0KPiA+ICAg
ICAgICAgICAgICAgZXJyID0gaG9zdC0+Y3FlX29wcy0+Y3FlX2VuYWJsZShob3N0LCBjYXJkKTsN
Cj4gPiAgICAgICAgICAgICAgIGlmICghZXJyKSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAg
IGhvc3QtPmNxZV9lbmFibGVkID0gdHJ1ZTsNCg0K
