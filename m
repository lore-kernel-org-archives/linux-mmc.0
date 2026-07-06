Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28FE1C5D72
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 05:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783315180; cv=fail; b=L1dceZfMJuMI/ERU/1OR0uoYUGv60W65yXTrA9MSZ1D9E/JR7dlm8Yjzu0Dhuj8Ph783dfGx89kWWBhRVOGdxjD6I8wlaIwJa6h6MBZBEYDTM2GPwZdmE/UlzzDWK1X4AID/kO5VlNq1k6GmEox3N9/C7ZJ/lvGuOZEt1AEbo8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783315180; c=relaxed/simple;
	bh=o9nzeT/4nLXha8nOimHnMzWgKZtaf11r9LMjw5g1Vu4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eHEzFiFciWA7iygKEISSPaGPc9kNrpCA8Oyk5DLV8yNZUSkPPsrOpFHxzzE3XgJ0/Pro6JJr/zerEW2MNIvGYL57G00vgKZpycZ1Q83NrnrSX93mEdeNeCSNxJc+V3Qf4KmbFDL+C5Ul6WW+ytygRPKxuz95YiDHkvIBxPS5qrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=cOCHX6vm; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="cOCHX6vm"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1783315178; x=1814851178;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o9nzeT/4nLXha8nOimHnMzWgKZtaf11r9LMjw5g1Vu4=;
  b=cOCHX6vm1M17nuvXXCqb8E65K4XukHcUTQk94OkWMNigBklUa41Cdb1s
   aBnC2MRCCVyV4Y9kSbLdCDQWIMKTsUpnBJCfKfjWAu8vzVe5VR4Uji1YI
   WD+iW4gfX2/deBhnLYY0L3sG114mNFMZL3J9R+qy1ERRF872XI40rH6zf
   syZumDzYZxIQmK7duGdZy7xmlq5Zg9hhQz0lzqKf/Q0xPkaYznZH6CdLB
   Zs0DiW7cUEj92XCr2lwSt7sT/wydBDC4VLDP3AQA/XUPPjG7KfnKnZbJz
   Lw6mZo6A69qS4lwYQYSaArI4Io0zg/wpeMfWTpfLs672qqoFN2QAvqvVd
   w==;
X-CSE-ConnectionGUID: 1vYR+JyRT6WLoCgLNAKiGw==
X-CSE-MsgGUID: CDrct4RnQhaajs//r5d1xw==
X-IronPort-RemoteIP: 52.101.85.126
X-IronPort-MID: 25842874
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-westusazon11020126.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.126])
  by ob1.hc6817-7.iphmx.com with ESMTP; 05 Jul 2026 22:18:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYdrpa8QzykWAd7SXNeP5HXhUo6Is2hkzRRzokLlqgqZwSBqEyiDdP9qWnaZ+CATmHxqzEE+PAMSiWDFkzO4xqMF+2D4U8R6gjQsE3NMsIyOIHwGbeTidp2Yjm9p31LQFKaNckNw9MIxmZCiGFcunzdLPAjQMx3HGJyVmBapqRKukHfWC8qgqN/m7hZfFjXl3NOn+Hvuz6mRkhpeNQFDPCij5gB686EQyvsEgBhd87JJNJ2o0pF9QgtJq6w7o7KX+g1sEKIUy/SLRVIB+slVDl8pV1DVs/LO5ZtsY0o0a+gF6oWuGgXGYpUY7pXEJyiBW8bUGQDJ7LnWYwVK4UluYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9nzeT/4nLXha8nOimHnMzWgKZtaf11r9LMjw5g1Vu4=;
 b=cqhQJFVYvIYpfUIkr4rlctHFrJGRxf1khEh9Q0hjA3wYP3RxbOIC0FIm7TMQEf+UuKFvj/5BK8x2CUD/K2eePea8vYWv/91C/lRJqu60Y8mulc9FofYD3Y3ZujM7cGyDx6DcUqyYHrv2LKXofOt8rHlfxfLmE0LNTbfRfpMwL8aJGzARJqn897b42evVVyiirsRFUMYvO2ZOeFJO9nMt5J8x+v8eC3qJ2WWZcu5eq10aCyQ4HqUCK1ecfgzTi4fqatQGDYjrA/1O8Ox8mvyDcL9foWnASYFTEaxG+rGmjDlVL6j5g44Uhr46ls7tW7KAv6FsxjfX8v6BcHed0pUhtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 PH7PR16MB5856.namprd16.prod.outlook.com (2603:10b6:510:30b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 05:18:27 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%6]) with mapi id 15.21.0181.010; Mon, 6 Jul 2026
 05:18:27 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Ao Sun <ao.sun@transsion.com>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>
CC: "beanhuo@micron.com" <beanhuo@micron.com>, "jens.wiklander@linaro.org"
	<jens.wiklander@linaro.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Hongyan Xia
	<hongyan.xia@transsion.com>, Jiazi Li <jiazi.li@transsion.com>
Subject: RE: [PATCH] mmc: block: fix RPMB device unregister ordering
Thread-Topic: [PATCH] mmc: block: fix RPMB device unregister ordering
Thread-Index: AQHdDG1XO/m3q5FHI0eWeqkT/BL0AbZf8nug
Date: Mon, 6 Jul 2026 05:18:26 +0000
Message-ID:
 <DS1PR16MB6753A02E9B66E4310CF8980FE5F12@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20260705105843.168-1-ao.sun@transsion.com>
In-Reply-To: <20260705105843.168-1-ao.sun@transsion.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|PH7PR16MB5856:EE_
x-ms-office365-filtering-correlation-id: 87c24ffb-854e-41db-4d7f-08dedb1e027b
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|38070700021|55112099003|11063799006|5023799004|6133799003|56012099006;
x-microsoft-antispam-message-info:
 ryq5u0l+j7bAwL0odszGI+ON0AiZysprhaXRUAfoWsy3oTY5FTwVS+qJbtTMriZg/TO1VF61RW2Wuye1FEVS6LYLBcJVQjcRb73jldJA9UgHMDKAbAqB8kvODbZIXPeenuPj4pe7dvcS0ak8RDaA5FFn+RXUUFmTc3vWDE1L5sVc51VlSNdEWWw1hFvf+bVBx8CWBIxlHvVLg0xerBQRjHQRVkyQxnidcJJwpeC3zdYoHfmFDNyCT6KNci/jyv49WA8fnIEdaUBkAgV6H4L1EriG9YdsXY7IWYd3PrCC/sv6+3NoN3yBzDYIVkxAVTzeMtTiVk43iM1ZSr0H9ESHcQzIWvmXtg1dLLeMxWMD/md3KdGxsecbBEVUdqcKwyQkCmHibv7uiCZ2jjDQsyxBzMfvUzMyiYs6HZ9mZoH5/AQaHfUzi7Zf+qa3Tr+KuEcThIJNxgBwgu7qgQG9RPN3gZptIAeVEhte9bfs8TIcMSvZW6+vGXHnlOVDiyVeRb2u/1oJb5XZz4YCxJMSOPJFsp0kSc6MYfTvTHXYaSxPCb176bReWlox0jcbmNgl8QX2X8n4ZGTBwqFnrpKf09qMalwNNDH7e9yJlcrQBr99fPi2jtCgULLRWPllOSAzA0DxwSHuh/1pTER4w91gCSpR6LSfyGEd+jUGKg8OwtZQctKiREvkylYBzol6rK99jlhoJH14qUrnk2FwUEyDO3DEGGSF2CUA+92FGs8FgecXoF8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(38070700021)(55112099003)(11063799006)(5023799004)(6133799003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXd5S2FDRnNwSk9tU1VuMFplUnQxSlg2dnl5TDVDd0lTcEdGZi91ZXprN3lm?=
 =?utf-8?B?TTF1Q1N6cjN0U2xtZDFsMUw4QldrRlc1OGVWQ214Zi9wL2R5YmtTVkNoNVZG?=
 =?utf-8?B?ai9meUpPYXVnTXdjOEExcXRjUU1mUitpSlo4b2hGNGl1czN1OHhHTzdtWU9V?=
 =?utf-8?B?azdXRmhzNFlQZW9JbWRzdzB1SXdPUWdvTDVIaHVMWEFKNUkyeEVZREVPVjVU?=
 =?utf-8?B?NHBER2hXL2F6RFBPa1huZFZod0ZmSmVCL1NVNk51a2N3QWJIaVpuYjRiOW53?=
 =?utf-8?B?SGhjQXBicFdlbGN5alBoaXB1RDNIWVU0MTFDSXBFMWNQaE1PRXl3RUtGUExD?=
 =?utf-8?B?VlIyK3ZFdW4wUzMrSHY0anNyV21tTDJ2R3VNWWZFL1o0bFRzYzNFL3BpajZ5?=
 =?utf-8?B?YXl1VXVIeU93WDN0QTFLQytOKzVzZ0tOS1ViS2Q0MU1OUXVQZndFc3pKbjV4?=
 =?utf-8?B?WXY2Vk5uWnRCaXlFMG43QnIvR1IxUkJ0NVhpRFlXcUNvWWV1UWhSWGZLWTk1?=
 =?utf-8?B?RnltVE1nYUU0eDFpNGFLbWZBUTlrZk55RTFRd2NmdHlOZXNKbm5ObWl0azEr?=
 =?utf-8?B?MUd1YUY2RFQ3MUtqYjRtRHM5aDU3YkllRncxa2dzV2Fpa3lVZm44a0ptQjdn?=
 =?utf-8?B?QnQ4NGNWdXZKYVYvcDJFQWE3ZkRmdGhSeGNMQ0txYVl6VlM2RUgremxUSTVl?=
 =?utf-8?B?dWdLRjFya0tXQjhUQjFwb2taRjJkSHVxTFVueUNHdDMwYS9KeEdaY3YyU1Z4?=
 =?utf-8?B?ZEswK3Naa2NCTnV3RktldkJzdC9KaHNMc1RmZXdUS3ZiTnhaWThEdWZKVG9P?=
 =?utf-8?B?bFc2OTZJMm5aWjc4bFFmTUFNMTAwaTJkNC9iYXhaS2JKRUhOb3V6VG9ERnFp?=
 =?utf-8?B?dHJ0RG4vVk8vWlEwekxpNWhobnVIZlNJcFFYVmRrQTdwTmtVRmlJY3dwWjlG?=
 =?utf-8?B?Z0pGQjIzQlpPbWsrMk4vRE9FUjVERS9kMjliZnAxdEtKMzlFV1BkMHNFRENK?=
 =?utf-8?B?M2UwbHliMmlZdkZkMXNONEVvYllmS1htNWZMMGNEQTl2NENHbFRoNmZCOFp5?=
 =?utf-8?B?djN5SG1DT053UnVxRkZ5TXdwaFhBOHhMT3hxNmpsdzFGRmJZdTFqVlB3QURM?=
 =?utf-8?B?SkYrSTlkMFlCQzl2TzBGaXJBZTgzcCtzZWlGRkFYcnBVcVdEeDMxSmdHa1o0?=
 =?utf-8?B?cDdxa0dIMC9lUHQ0OXZ5emc2Y1lraVhsQkxyOURoSnRta2NkSFdqY0lIeEgr?=
 =?utf-8?B?ZVUxQmkrc0N4Y01icjlxbzRqQlAzOUIzZjBiMXVNM3hRRDAyMzdOMzdxa0pv?=
 =?utf-8?B?ZGlQYm5PTFdidnZGNWZTdE1QMkFNdG5UMjN1dmM1c1JacVhUQnpicVBQbVR4?=
 =?utf-8?B?Skp6Z0RDNm5UUFc1NVk1d2lrdmM3aWRTN2QwWGFOWHBFYzhFbVQ0QzhTZWxi?=
 =?utf-8?B?Z21yWnFJNFk1R0xRVU1jRWovdlVRdlljUGRRWFUrclF4b3pUVGtvWU0reDRa?=
 =?utf-8?B?aHFZNFh0ZVhvTjY5emp0RG5CaUFORXFhTXQxalVxQVVDYnl2d3MxSmlsdXhn?=
 =?utf-8?B?QVgwaVBhN2EzcysvM05XVndaRE95ZFgwQy93SUFLaWJRdEM3dldRa2hhSEh6?=
 =?utf-8?B?RExjeU11bUJKR2ltRWdCNGh6bEFBZUZnMll4N0xxaUdTSUZmWlFxWno5ZnZX?=
 =?utf-8?B?M2N3eXdXKzJ3cFFpWUhxa0ZwNmtCWUh4bmQ4VmNocUx3RjNCMFlZQ0xFczlN?=
 =?utf-8?B?cXd2QmxzcHd6NWVNc09lc1Y3amUwWE5VWHhJMzBPOEp2d21POFQrc2lJdEtl?=
 =?utf-8?B?MmFGWjh6S1pOWE45Z05vbkgzbXlsbmV2SDkzZE5PNlJqV1BFemxpVXFPTFZq?=
 =?utf-8?B?bEs1YkZ5VGoyMUxKTWtaMWZKRG56SHVJRTVvd3hDU0piMThmQ0RmOHpLQlh6?=
 =?utf-8?B?QUphcS8zaFg5YUtTVldheWMwRWF3ZmdrV0xoTDU1SUFVZHZadm5KbGc0OHZa?=
 =?utf-8?B?dTRwL0ovK3pLVTNjbXhtOFdVMElwc2FHM2ZsUi9LVkF4TUtJQmVIZEhyNlhn?=
 =?utf-8?B?SG85ajJQM0gzdHdoRUdmSTFuTmZtWmdQVGIrdUJpTER4SlNnV1N5ZkhYYXIv?=
 =?utf-8?B?cW9ydlJYZVFRaVg3YURZVzdhY3JxSS9qTmZhMUtJc05zV3ZQb1VMOGlTTGdV?=
 =?utf-8?B?Q2hPVDhsN0lVMjZ0enNxclRXaERpUGpwUXZrYjc5MjNvMFZLdllmOHc3ekRW?=
 =?utf-8?B?OXpZN2N4TzFmZHA3M3VJcUFkVUdsazZrd3BpL1htR3pIRi9kQWtuQkFSQkdT?=
 =?utf-8?B?alE2MW96ZGI0RVBYV1IxWjMwak9TN080eXMvaHB3dVdmcWEyY0dTZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	iC5w95ssJDUOlkPDtQOn6W7l92DNJ36kE6SL39d7vi6D358eyJ31pcBaSGqyU6q6au1VGub6wLbqxgmYDKP2bxJi0IOl+5Rm8eKEsML7b9QX7L7VkOCCMzw5Rn0uCqIb0EFRC4RWisykgfq4h2bwLOTBsJ41V2RBLnF1FTCNmdEKNRUWlYueJNUGg0lGZ0BKmj5a8/HktcT2gdwjwRepfmqnwDcuJt21IHBgw4kVbGF5ORo1KngT365/pSkTdf39QgpxAFNbKJm4ohwu+o6mBqHXtQMxE3AcNKpWTvi2g7NFeigs2TyVDEbaxClfWNJDv7qyGQXGU/UYtafCquQaDQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jGwAK7hf2pKXMZVrA0wYd5erOmnlP3aGEwxIfldmJruz/3MqpA5fC04WI+rGVu+LhTh+7xOCk0s54ZCZNhB2gKwAz30H+q8kc1VAeSfeMrNSYpF3Y8MaeNu2/SXPlZC0ItgH10XKt5i5NO5OmDp/VaDPIyQWczUcrVkhCrogL0k/0ds2XRGXiKL9gAwEIZVVW59R5Tm74FCRIzGTQCgb+VaWJ0BM78JOAzU4RHW8cqkTMAZAqDSFHilS+6MXxtTN3As0xNepqBynWGQj/4x/8ZkeIxVfZ41WLztlAKH7e02PGkw5eMHw2WvHIKdvk0QriLbwqslSBKr8XEVbXXDSJTGu5r8DVwQl7GpIvKNykpUC1jrTpgJZOVigBd2H/sibLE++vT66cCHVJ1k3T7N6rr0aR5rs4/PkQF+Fg15wlxjd+I381RLhh/eSSB5YNhV5emRGbfFt9rEYE+aJZPSTjAYWo9gGtM+UHgRsAOO5PaN8bRv1vS1OQi75IajsdMFTvrYOQ3/eKLtAkQLg7J5U6ynwlhUtugYoE4P/o7fTY+skcNG3vQ0AejHsL7e/NC5bpAZhhKOnTfymUSHQtPu3r2SOWPq/qLAGe/eMR1M4rdKyZtzRW0shbeJYZ+agaqpR7csthd3HaYJEZncd2gWxvw==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c24ffb-854e-41db-4d7f-08dedb1e027b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 05:18:26.9997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GcYtgVWAfY7VhvMriqH8Z+VqFeAlR4SaSVWN0GK4Sq2DrQkA5fZqi1OQZEvZkblT/eOCArkGIjGNKEzHsWc36Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR16MB5856

PiBGcm9tOiBBbyBTdW4gPGFvLnN1bkB0cmFuc3Npb24uY29tPg0KPiANCk1heWJlIG9uZSBtb3Jl
IHByZWxpbWluYXJ5IHNlbnRlbmNlIGdpdmluZyBzb21lIGJhY2tncm91bmQ6DQpTaW5jZSBjb21t
aXQgNzg1MjAyOGEzNWYwICgibW1jOiBibG9jazogcmVnaXN0ZXIgUlBNQiBwYXJ0aXRpb24gd2l0
aCB0aGUgUlBNQiBzdWJzeXN0ZW0iKSwgZWFjaCBtbWMgUlBNQiBwYXJ0aXRpb24gaXMgcmVwcmVz
ZW50ZWQgYnkgdHdvIGRldmljZSBvYmplY3RzOg0KIC0gdGhlIG1tYy1vd25lZCBkZXZpY2UgKGBy
cG1iLT5kZXZgLCBiYWNraW5nIHRoZSBsZWdhY3kgL2Rldi9tbWNibGtYcnBtYiBjaGFyIGRldmlj
ZSkgYW5kDQogLSB0aGUgcnBtYi1jb3JlIGRldmljZSAoYHJkZXZgLCBiYWNraW5nIC9kZXYvcnBt
Yk4pLg0KDQo+IFRoZSBjaGlsZCBSUE1CIGRldmljZSBob2xkcyBhIHJlZmVyZW5jZSB0byBpdHMg
cGFyZW50LCBzbyB0aGUgcGFyZW50J3MgcmVsZWFzZQ0KPiBjYWxsYmFjayBjYW5ub3QgYmUgaW52
b2tlZCBpZiB0aGUgY2hpbGQgZGV2aWNlIGlzIHN0aWxsIHJlZ2lzdGVyZWQuDQo+IA0KPiBSZW1v
dmUgcnBtYl9kZXZfdW5yZWdpc3RlcigpIGZyb20gdGhlIHBhcmVudCByZWxlYXNlIGhhbmRsZXIg
YW5kDQo+IHVucmVnaXN0ZXIgdGhlIGNoaWxkIFJQTUIgZGV2aWNlIGluIHRoZSByZW1vdmUgcGF0
aCBiZWZvcmUgdGVhcmluZyBkb3duIHRoZQ0KPiBwYXJlbnQgZGV2aWNlLg0KPiANCj4gQWxzbyBk
ZWxldGUgdGhlIGV4dHJhIGJsYW5rIGxpbmUgYmV0d2VlbiBtbWNfYmxrX3JlbW92ZV9ycG1iX3Bh
cnQoKSBhbmQgey4NCj4gDQoNCk1heWJlIGFkZDoNCkZpeGVzOiA3ODUyMDI4YTM1ZjAgKCJtbWM6
IGJsb2NrOiByZWdpc3RlciBSUE1CIHBhcnRpdGlvbiB3aXRoIHRoZSBSUE1CIHN1YnN5c3RlbSIp
DQphbmQgYWxzbw0KQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCg0KPiBTaWduZWQtb2ZmLWJ5
OiBKaWF6aSBMaSA8amlhemkubGlAdHJhbnNzaW9uLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQW8g
U3VuIDxhby5zdW5AdHJhbnNzaW9uLmNvbT4NClJldmlld2VkLWJ5OiBBdnJpIEFsdG1hbiA8YXZy
aS5hbHRtYW5Ac2FuZGlzay5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL21tYy9jb3JlL2Jsb2Nr
LmMgfCAzICstLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvYmxvY2suYyBiL2RyaXZl
cnMvbW1jL2NvcmUvYmxvY2suYyBpbmRleA0KPiBjMGZmZTA4MTdmZDQuLmFiZDVhZTRlZjJiYSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tbWMvY29yZS9ibG9jay5jDQo+ICsrKyBiL2RyaXZlcnMv
bW1jL2NvcmUvYmxvY2suYw0KPiBAQCAtMjc3Niw3ICsyNzc2LDYgQEAgc3RhdGljIHZvaWQgbW1j
X2Jsa19ycG1iX2RldmljZV9yZWxlYXNlKHN0cnVjdA0KPiBkZXZpY2UgKmRldikgIHsNCj4gICAg
ICAgICBzdHJ1Y3QgbW1jX3JwbWJfZGF0YSAqcnBtYiA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0K
PiANCj4gLSAgICAgICBycG1iX2Rldl91bnJlZ2lzdGVyKHJwbWItPnJkZXYpOw0KPiAgICAgICAg
IG1tY19ibGtfcHV0KHJwbWItPm1kKTsNCj4gICAgICAgICBpZGFfZnJlZSgmbW1jX3JwbWJfaWRh
LCBycG1iLT5pZCk7DQo+ICAgICAgICAga2ZyZWUocnBtYik7DQo+IEBAIC0yOTkxLDggKzI5OTAs
OCBAQCBzdGF0aWMgaW50IG1tY19ibGtfYWxsb2NfcnBtYl9wYXJ0KHN0cnVjdA0KPiBtbWNfY2Fy
ZCAqY2FyZCwgIH0NCj4gDQo+ICBzdGF0aWMgdm9pZCBtbWNfYmxrX3JlbW92ZV9ycG1iX3BhcnQo
c3RydWN0IG1tY19ycG1iX2RhdGEgKnJwbWIpDQo+IC0NCj4gIHsNCj4gKyAgICAgICBycG1iX2Rl
dl91bnJlZ2lzdGVyKHJwbWItPnJkZXYpOw0KPiAgICAgICAgIGNkZXZfZGV2aWNlX2RlbCgmcnBt
Yi0+Y2hyZGV2LCAmcnBtYi0+ZGV2KTsNCj4gICAgICAgICBwdXRfZGV2aWNlKCZycG1iLT5kZXYp
Ow0KPiAgfQ0KPiAtLQ0KPiAyLjM0LjENCg0K
