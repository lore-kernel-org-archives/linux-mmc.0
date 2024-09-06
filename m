Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E211C9DFE
	for <linux-mmc@vger.kernel.org>; Fri,  6 Sep 2024 11:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725620843; cv=fail; b=hHtwRH+MzBtfppiJ7ry56SsXhLG6+2S2B9JlHVK7FH5LiE9xuA+d9weU7wNr3jCpM8mCwyTKB065OVZeNKpKzOStptnS+jLsaixm8rvupwnLZUJZ9SEr1mxLKSnukvaFVZJt+lf2STjNDhKh+FPRXuttdX4NNNk4yqCwCXqnM/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725620843; c=relaxed/simple;
	bh=sfUL5mZkzBAk+WCz1bZ1ZvitPcNqkBCOpXcDFZZ1RgU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f+7iopz6Pf9h8EYHrsFuLcZpJy2gA+4dItr0GBHHeqlsWOQ3oyeD0ByZHLsYRze/q7Wk8XGqfMQakp2Yfs1fncKqUu0y3k8J73WypTF57sU0ATt9dFF6VWoV8AvIXGhPOU2as5lbgGJeggv7oH0F6NgmppEpjmQhbjw0+U3Ezo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=DHxel5FT; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=iA4VN2Y2; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DHxel5FT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="iA4VN2Y2"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725620841; x=1757156841;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sfUL5mZkzBAk+WCz1bZ1ZvitPcNqkBCOpXcDFZZ1RgU=;
  b=DHxel5FT0lG4muOF1h8FKqkcYm4ALi6j63B1amphbuV2/Hg9w2jPzB+R
   KopzTMxez63tC2TMfBRKKxKK31RAaq7hj1/QZbeo2WLBOTpC68N+JfMqi
   R7bMwRjn8vBH5FZmclw0KZVr+Jh9LNrfroh78EKeUDu5ZwA1FgZfc2Ku0
   wG6k46/OWK0HNooaBKN9fJ0RW3At5HK3vlo3J9q75xylMarGvdk9Re6lr
   509Frmu9xmSOLECpI0P9r6GYB8te3pZUzb7gtiiDlXX/YCprZzkkYKQre
   MNWHGTaLe6JMGS8bjb734G9qbUWHrHT6zTiXWztA1v5lJFTroQzZx8N7f
   Q==;
X-CSE-ConnectionGUID: 2Fi0DtOkTU+cl+ARsIrSSA==
X-CSE-MsgGUID: wvNK9vT0Qt2emcwqaebnyA==
X-IronPort-AV: E=Sophos;i="6.10,207,1719849600"; 
   d="scan'208";a="26468426"
Received: from mail-eastus2azlp17010002.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([40.93.12.2])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2024 19:07:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ur/hJ6v/TBXU4NtZSUpIjRm2wQc4EXAgzn/PTMeGwA8XrLLgr6IJiuCHH2UOdm9s1Y2iuMphRrgRPLguTzNXVv0qbJdFpSAnMmlFNycvzYMfDolTZDVfQNfot7M7bFjKH1zj46rTuXfDYeK7IbWy1pHaPx5sMcFTp+x1VxuCmjLJJB/LeZQ4fZ0OZGKBCbZLVwXMaCUavp7hpEwjKuW5ktTHRkUuHz/6ligbynN0z3ujhF4VcVzdj7vOM5ED0xeet5qCfmXGB2du4fqVnmWA6LN3Ciyk1CHSFrEpVJs8gxjwePJMhOHa7AzeaRAc1Niu+FOBp7Eta6JHrEE7pFgY1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfUL5mZkzBAk+WCz1bZ1ZvitPcNqkBCOpXcDFZZ1RgU=;
 b=cWyOag2QyM14xXOLZBmgPdBZFamMd5+19BsgL/RDZF78x5GsP8PJ9Dh2CGsc7fqdwZXRAFquIunlVe60qPMauvur3THVUAgKc+23FyyGS9+mzLZ3tAN9Vg/gYrkVLQncMviK04f2wkpZ6ojVRc4fFIJY1zv7uDV1koZ7lcFUr+zArV3Qn26zgUoBBu0BXsQtZZ9CohxTTL/pMxw0VrccihdvPHPN3MxzvIpRH1JbZkClP3GZChxjKRSsrwNocNmywQhTvaJJwKuZpjZ3sZo/bf5CvxVCPu59Z3obEaJy57SsauC4UhliifFFszg33MuTu803cDrKcF4/IEJSsXeABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfUL5mZkzBAk+WCz1bZ1ZvitPcNqkBCOpXcDFZZ1RgU=;
 b=iA4VN2Y2ymVFIrVfPSuXvhwGdXEByrS79bwHx9XZnV1VR29qzlcpImdl8waUUOrjjIN/dHDShjujTQEDiAQ9z3e8m4px9/DF1EBuWwcn0+dkH6sq2Un/X7wWXv5D6ZjEcY4VhMZgMWmy+boxtiipqOevztXPQ08+rvStwaHE3JM=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BL0PR04MB6548.namprd04.prod.outlook.com (2603:10b6:208:1c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 11:07:16 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 11:07:16 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>
Subject: RE: [PATCH v6 7/9] mmc: core: Adjust ACMD22 to SDUC
Thread-Topic: [PATCH v6 7/9] mmc: core: Adjust ACMD22 to SDUC
Thread-Index: AQHa/tp3OrPjlwRmPEm+NCm6CVtovLJKmWOAgAACHIA=
Date: Fri, 6 Sep 2024 11:07:16 +0000
Message-ID:
 <DM6PR04MB6575273C3060A3F3E820DC15FC9E2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240904145256.3670679-1-avri.altman@wdc.com>
 <20240904145256.3670679-8-avri.altman@wdc.com>
 <3016fd71-885b-4ef9-97ed-46b4b0cb0e35@intel.com>
In-Reply-To: <3016fd71-885b-4ef9-97ed-46b4b0cb0e35@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BL0PR04MB6548:EE_
x-ms-office365-filtering-correlation-id: 45966efd-ab00-4678-2111-08dcce641182
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZmVtZWgwdHB2SFJiSlc0aDVqTHN0WlhOLy9hcmE0QWJZVVZiR21qR2ptS3R5?=
 =?utf-8?B?clJSTm9Qa2QrSkJVaGpmMDlKN3hsVDB3Um9pdHl1MEVFTHFjemk4Y2VRNUVj?=
 =?utf-8?B?U0Urc1ZhLytoZklMb2dNWDJwQ1dlSnBCUU1WdUJVZnM3YzdTcHN6NTl4elRC?=
 =?utf-8?B?TW9FcDZINmlDcFQyZ3RKUWJtbFI4cjFmREdlTUZoSGVmMXJ5L0wvd3NNc2Fz?=
 =?utf-8?B?QkVMZk1TTThOS2ZEaFJzWUpBNUtjM2tZeW5iYThqb0JwUzcwb1hCL0pRa2xr?=
 =?utf-8?B?VTJWb1VYUUg3eWVZdFZNZkNWeS9ZWVhSNC9VK042dzZkSWlhZDBWbXVWbk5N?=
 =?utf-8?B?OGVIR0Fha1dVQTdXUFNRRzRmYklWZ3dtWTQ2VkJCWTkrc3loenhMZmRvUDBh?=
 =?utf-8?B?SFpJcUd0UlFWMkpLUWdnMVV3T3pZQlZTK2ZwWFQxRmVPV3NwUmw0Q2ROUVZF?=
 =?utf-8?B?K2tyQXJta01rcElXSWV2K0VQSGVPYVk1a3J2OFc2NVZ0R1pyYkZFa24wVGhL?=
 =?utf-8?B?dm1RbXlTdnpOK2lrTU5hUlpDRVlXcUM1UGI0NDNtZXZjVTAvMDBVUU9qalhF?=
 =?utf-8?B?Zjl5ZXFJQzg0dERQNWdKek9RbndBU2ZmR2lVbTZGUWc1Sy9oRGxjeHZXN2I5?=
 =?utf-8?B?blVSZEhRRVlzRW1KdWg2dHA4aHo1a1RwT200Y1QrR2I3L2FaLzBMbXBaREJ3?=
 =?utf-8?B?S09mdXR2OEVlN0V3TjIrRVVNZ05FL2VQNkpBV1pSUnhVVUV2Mm9zOVVOQW5m?=
 =?utf-8?B?TGRPcWRPZG5pWmRpYStOYzZNM0R6RFBaYURGeXloZmd1VHVmTFdsb0JFMyt6?=
 =?utf-8?B?YWt5ek42aGZXdk9TUUhTa2FPNVc0TkFhWVZnYml6K2NtdFlja2R3aXdIS01i?=
 =?utf-8?B?UWQ1K0tOa1Fla1hzWnlhY0tHUWlCYXNBb1B4YVB0aHFJR2R6M2VrTFo4OWI3?=
 =?utf-8?B?aXhEdlJsbTFWY0c0UlBNY3VYdTZnbzFHeTFQVTRDWE9pQ2tzU3JJMWtiVU5h?=
 =?utf-8?B?Rlh2Ti8ya3JBT0Y4S2RZNzB1SDhqQnlEcXMxempqQ2lvWW9iM3VQMks4WXFG?=
 =?utf-8?B?VktyR3FxMC9RYUNsQmdyQkdZb0lHODhvckRLalB0SGU4eUEya1laVC9NVERE?=
 =?utf-8?B?MXYzT2xvbzN0QkpoaWZjKzQ2SUFXV3M3TE92Z3hxa1hscTFXYVZwNEFXT2Nj?=
 =?utf-8?B?UVZMcGNDbXg0QU4zdGNXK1ZuZlhXSzJzeGFxYVhxS3RUOU44b25yOXFPcFVw?=
 =?utf-8?B?aldDU2VyWkNqNmVkRnE0eTgycEQrVm1OL0s0TjVrUG5uakxVSzBjc1B2SnZO?=
 =?utf-8?B?ODdjY0E2OHZwNVlQZ2JBczFPYzh2dEVyUDhTQmI1SHMxZ21mNDdDZ2dXS3M3?=
 =?utf-8?B?dTkramYwV1B6U0xBeXBFRDd5ZzZQNzlrMVk5VVByUFBxdjlyLzd0ZlA3ckZr?=
 =?utf-8?B?NTd4djNWMDFQdDloZk1UWlc1WmtydTN3dGhScHBRZGJnVHJMSlplL1p1MkFP?=
 =?utf-8?B?SXdFRVNmTW81V29LSmR4dmpFdzJDWlJsbG9hR2NDcUdZOTZuRXA0K1dlelNW?=
 =?utf-8?B?TXVYV05LQnptVDlndXdxdTNkcDNRbUtUMTNoSEpRWDBJOEhyem1NbXBVSnhx?=
 =?utf-8?B?Rmk1YUQyS0Myc1FBWEhESkNxeVBCOHBQZ0xuVnBkRjY4NmJnTnVLTjNjYWNE?=
 =?utf-8?B?QU0vSldXSlNud3NZVFFIcUNDcEJlcmhaWTQveGpFSStYbi9lQmN2ZWdkUDdU?=
 =?utf-8?B?L1N5VEZudE1HYmZFSmVONUd4Si9ONWVYVW83TjMxVUJrZjJrdE5aT3ZHYTlj?=
 =?utf-8?B?T0FjZHp5STBlcXdjRlM3S0Q1UGdsV1k5RnFjckdNc0V6OE92cC9qM3o0Y1Va?=
 =?utf-8?B?OUZYQnNlVUNDWXhhaDNPYitRSzljenBDSkZmZUdxZjY4OFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MUFHU2xQcHFEVmtKQm96SHFzS1dCNjFaNjkvamxOZURNN2ErU1FBRGhrN2tI?=
 =?utf-8?B?Mk1OSDJya3M5eHc2eEZqYzFoYWhqeTN3dHM0NXpFU043OXBTR0swSzBWdkZi?=
 =?utf-8?B?a29uYlFqYUlxZDZEbmRLWUhHSTVHR2lpbnJ4MVk3TXppdWYvYktzZVlZN2di?=
 =?utf-8?B?dXI3eVEwbTFobmwxaUF4VTdtcGxncE1Ccnd0dXU4dUcxVUdrM3NBalVPV1Bv?=
 =?utf-8?B?OXBubGVVdDhqVUlFQnlGMWZHallVaVB2M29LMDlwRGZaNnFvbnNrSFV4SWRT?=
 =?utf-8?B?V1BJYWh0VGZ3c2xsNTVlOVp5Si9QSzZiLzRyU2Z4TTZneFpic2pQYkUrT0lw?=
 =?utf-8?B?eHdSTC84VzdrM3hDSkJLQVVWajRUYVZRVUEzWFB4WnZibFVNSnZRUFdnNEd1?=
 =?utf-8?B?Y3EzZ0tVekNCb2RYcXpKUlQwVEROeXV2T2diNkgyTTlIYm13a3JITVZHQW1u?=
 =?utf-8?B?eG42Mm9ONldrK1R3VldFUEt0cWRjMmRISFlWWDNnSHFsQWIrdXgzZ2VXc2RE?=
 =?utf-8?B?a2FrS3FJVEl0TmJMdjUwcDRaUGZXaGRuVWdocENyM2YramlzeTUwaGFHNUZT?=
 =?utf-8?B?YXo1bjdSL2FlN1FHRFBsSVd4Z2xWSmZpR1k3TE45c05PRFNST1VuYy9FLzN0?=
 =?utf-8?B?VFVLWEgwQlIxNHB4dVFKZDBsdTlhaGhTS2dvSjNTV2w3R0xPOUI2cU1EazVr?=
 =?utf-8?B?M29vQ0JUcHZzLy8yM0tMdTZaK0V6VndjVUl6bGJpZDBieFZnU0dGTlB4T09h?=
 =?utf-8?B?TmZkUlZCUmo0eW5qMWYwc0JCRGlibkRPc1ZOL2pPeGNjVUhBZVJRcVdPT21F?=
 =?utf-8?B?UkZiQTg5YnFFK1BiT3hwcXFaQ0l0QnVhYlB4QjdtaWZTMG1qaVA3Y3FKeUVz?=
 =?utf-8?B?ajIrWlFDUmRWM2tRSndHSExRQ3JwV29iOTduUVNHRVdCTVB3RjBZRGtweExz?=
 =?utf-8?B?SmZJOUhlRDB6SjhGd2JEbEwzWHBaN1pFT2crcENHanpSSXNGMlYwZFlkNUdF?=
 =?utf-8?B?S2dTRVBVMVk0S2l1TUNtTkRYRHBGVkhUdUtUNEFPbEdQcEFiY3NSSEM4alN5?=
 =?utf-8?B?a0t1NHR1ZVhLMVpkc3BtbXZIOEF1WVljMWhpdVNNSUZyMzhsN0dTK254Yy9F?=
 =?utf-8?B?RHpTQVRTUnRRKzhJV2JhR3NyaDE3Rm4xU09nbUd6ZXMxNnZ4ckF1VUdkTmJN?=
 =?utf-8?B?U0hocGVUOVN5aURQOUlmQU1ubnhWK21YTlNPRmRacWFrL0R5VitXZUd0YzB1?=
 =?utf-8?B?UjVJRzZpazFIbTMwZTlmKzI0RW5zdFRvOXcvbGMzSlNSTHhWUUVSMHBuT2pt?=
 =?utf-8?B?N0diNkhKQVJHRzQwdnFZSTBwQ3IzNnBDUWFxOFo0SmhDMFBVYUp4azB5M3hv?=
 =?utf-8?B?QUJBKzMxZWZDd1haZmJQY2hBQ3RPeks2Y2srQkljZ25weWE5R2pPeDdsYjFQ?=
 =?utf-8?B?SEMzbnNoM0tEb1I1UGI4ZVdtRGt4N2VhV1JPWmlpbGVkN1FkYWZzS3VOWDRl?=
 =?utf-8?B?eXhaeWc2Ti9xZTRmSEFldzcyc0ZWeVlEOHBSTzFiQ21XM3JGWjVFM3hPUG9k?=
 =?utf-8?B?SkRrZDNjdVZScFZMOEZ5VWJreW53R0pWVkFSTDRkYjZMZXQ4OXBJbmFkREZ0?=
 =?utf-8?B?MzF3cU1EdW1kNVJmVUE5Z2UwcXhlZnkzV0wxbXhTWFB2Vmhrc0MzL3VJZEZr?=
 =?utf-8?B?WUE2L1dOZDErMENqVDFqSTgzRlFuTnFwVG9kYXFaUzdUQXBwRHRQcHd0WnJB?=
 =?utf-8?B?MlR2UUlDbnh5R2pvY0N2dHN4RytkaHZqcjUzR2lRY01LY2d4ZVNpaCtmaStm?=
 =?utf-8?B?WWdNMjJwWm4vT0VsQ05xazJLdzR1UElZVTMxOFhTS0ViWWZaYW9iUWFHdENn?=
 =?utf-8?B?aEFZeWJ5Wkd6NVFkQ3BwYzU2Wi9YMVgrQzFmblR5NWI1U0R2YTgyNExJMmFV?=
 =?utf-8?B?dnBLbVZ1QlQ2bjY1V3VOeEVNdGpCM0lRYkVnM0xFOU5MWW4xczZlbG5Fcncw?=
 =?utf-8?B?Z2o4dHhObE5UVGQ1NmdRQXVCQlk4am1WS2pRejFnbTdUSXB4VTZycDZvY0l3?=
 =?utf-8?B?V2hOOTBRQllxaE93QlcxUDBnZldGSkdSaUwraGc0QjN3YU0yTDBVbU9nVmY0?=
 =?utf-8?Q?0kLbOpS9wdeVk5hIFQ3wqcOqr?=
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
	ASH0X4lb7XsL5MQUxLUjR/S2yTB0ewXAR/bZIPLB4o7UkRv7l/SSPw6M9KM1h+RNjVX2WqNI2huo/Fhoj4upgbYUhPjTkut879JCXMP4MziEd/VUxtfdKsEEQtjwwImVQhl6VSqcyHvYnJ1HiJZODaODY9LMmUKiVOQF92BL27tzi7D7E57R60N+bvk3z3WAhmZ7RadMzpbL5EjMbZngw0OMW4JW214OcFRfEIt/F9qM2Z6MH6kjPtKz0HmIBbTVy1xbyhKBCSMyTPMTTpdBv4azKSlfdDXG1eQAftcGvvXI2/I7eUegi7fbk+RbhJ91OQQnVVAx2QepWc/xo1NP0Jw74u5VvKrE9Npj7P+vUJgKQBS3e9JnJyfDxC2de4UJ43sHa8Cp/WZc3Ck0tlJGOPQ2ZHFjROfxZgbZaHVNWUf67GtCzUO19Nb2BjHW16jlqkg7JmIpp+ulG9W0qPUUCptnvCJjHj4Q6d/ASVOqLh+F1PxfN1Ykr0bZedPQzxaoeBAMqOSFBighDkZksTDI3EuP2AfFZoBFx7yoyl47Ud67y2JkeRgM84qIhCN4zaRfFRaUrGEV5hoA6/6g3s2LqwfDSllQigpZJVu0cjtYQhwpGxqO14onyXaHntbRPHO5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45966efd-ab00-4678-2111-08dcce641182
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 11:07:16.5149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gc3WRiJduSlgTrx1wPxwKRlxrR4b/uoErnYrbvE7wFIMonD1freoxcPCxgt2z6hqg5bT8Z/QTqtR939E3h5vAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6548

PiBPbiA0LzA5LzI0IDE3OjUyLCBBdnJpIEFsdG1hbiB3cm90ZToNCj4gPiBBQ01EMjIgaXMgdXNl
ZCB0byB2ZXJpZnkgdGhlIHByZXZpb3VzbHkgd3JpdGUgb3BlcmF0aW9uLiAgTm9ybWFsbHksIGl0
DQo+ID4gcmV0dXJucyB0aGUgbnVtYmVyIG9mIHdyaXR0ZW4gc2VjdG9ycyBhcyB1MzIuICBTRFVD
LCBob3dldmVyLCByZXR1cm5zDQo+ID4gaXQgYXMgdTY0LiAgVGhpcyBpcyBub3QgYSBzdXBlcmZs
dW91cyByZXF1aXJlbWVudCwgYmVjYXVzZSBTRFVDIHdyaXRlcw0KPiA+IG1heSBleGNlZWRzIDJU
Qi4gIEZvciBMaW51eCBtbWMgaG93ZXZlciwgdGhlIHByZXZpb3VzbHkgd3JpdGUNCj4gPiBvcGVy
YXRpb24gY291bGQgbm90IGJlIG1vcmUgdGhhbiB0aGUgYmxvY2sgbGF5ZXIgbGltaXRzLCB0aHVz
IHdlIG1ha2UNCj4gPiByb29tIGZvciBhDQo+ID4gdTY0IGFuZCBjYXN0IHRoZSByZXR1cm5pbmcg
dmFsdWUgdG8gdTMyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQXZyaSBBbHRtYW4gPGF2cmku
YWx0bWFuQHdkYy5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbW1jL2NvcmUvYmxvY2suYyB8
IDI5ICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAy
MyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbW1jL2NvcmUvYmxvY2suYyBiL2RyaXZlcnMvbW1jL2NvcmUvYmxvY2suYyBpbmRleA0K
PiA+IDUwZDM3YzRmNWE1MC4uZjM2NjExNTEyYTFkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
bW1jL2NvcmUvYmxvY2suYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvYmxvY2suYw0KPiA+
IEBAIC01MCw2ICs1MCw3IEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC9tbWMvc2QuaD4NCj4gPg0K
PiA+ICAjaW5jbHVkZSA8bGludXgvdWFjY2Vzcy5oPg0KPiA+ICsjaW5jbHVkZSA8YXNtL3VuYWxp
Z25lZC5oPg0KPiA+DQo+ID4gICNpbmNsdWRlICJxdWV1ZS5oIg0KPiA+ICAjaW5jbHVkZSAiYmxv
Y2suaCINCj4gPiBAQCAtOTk0LDExICs5OTUsMTAgQEAgc3RhdGljIGludCBtbWNfc2RfbnVtX3dy
X2Jsb2NrcyhzdHJ1Y3QgbW1jX2NhcmQNCj4gKmNhcmQsIHUzMiAqd3JpdHRlbl9ibG9ja3MpDQo+
ID4gICAgICAgaW50IGVycjsNCj4gPiAgICAgICB1MzIgcmVzdWx0Ow0KPiA+ICAgICAgIF9fYmUz
MiAqYmxvY2tzOw0KPiA+IC0NCj4gPiArICAgICB1OCByZXNwX3N6Ow0KPiANCj4gQ291bGQgZG8g
dGhlIGluaXRpYWxpemF0aW9uIGhlcmUgaS5lLg0KPiANCj4gICAgICAgICB1OCByZXNwX3N6ID0g
bW1jX2NhcmRfdWx0X2NhcGFjaXR5KGNhcmQpID8gOCA6IDQ7DQpEb25lLg0KDQo+IA0KPiA+ICAg
ICAgIHN0cnVjdCBtbWNfcmVxdWVzdCBtcnEgPSB7fTsNCj4gPiAgICAgICBzdHJ1Y3QgbW1jX2Nv
bW1hbmQgY21kID0ge307DQo+ID4gICAgICAgc3RydWN0IG1tY19kYXRhIGRhdGEgPSB7fTsNCj4g
PiAtDQo+ID4gICAgICAgc3RydWN0IHNjYXR0ZXJsaXN0IHNnOw0KPiA+DQo+ID4gICAgICAgZXJy
ID0gbW1jX2FwcF9jbWQoY2FyZC0+aG9zdCwgY2FyZCk7IEBAIC0xMDA5LDcgKzEwMDksMTQgQEAN
Cj4gPiBzdGF0aWMgaW50IG1tY19zZF9udW1fd3JfYmxvY2tzKHN0cnVjdCBtbWNfY2FyZCAqY2Fy
ZCwgdTMyDQo+ICp3cml0dGVuX2Jsb2NrcykNCj4gPiAgICAgICBjbWQuYXJnID0gMDsNCj4gPiAg
ICAgICBjbWQuZmxhZ3MgPSBNTUNfUlNQX1NQSV9SMSB8IE1NQ19SU1BfUjEgfCBNTUNfQ01EX0FE
VEM7DQo+ID4NCj4gPiAtICAgICBkYXRhLmJsa3N6ID0gNDsNCj4gPiArICAgICAvKg0KPiA+ICsg
ICAgICAqIE5vcm1hbGx5LCBBQ01EMjIgcmV0dXJucyB0aGUgbnVtYmVyIG9mIHdyaXR0ZW4gc2Vj
dG9ycyBhcyB1MzIuDQo+ID4gKyAgICAgICogU0RVQywgaG93ZXZlciwgcmV0dXJucyBpdCBhcyB1
NjQuICBUaGlzIGlzIG5vdCBhIHN1cGVyZmx1b3VzDQo+ID4gKyAgICAgICogcmVxdWlyZW1lbnQs
IGJlY2F1c2UgU0RVQyB3cml0ZXMgbWF5IGV4Y2VlZCAyVEIuDQo+ID4gKyAgICAgICovDQo+ID4g
KyAgICAgcmVzcF9zeiA9IG1tY19jYXJkX3VsdF9jYXBhY2l0eShjYXJkKSA/IDggOiA0Ow0KPiA+
ICsNCj4gPiArICAgICBkYXRhLmJsa3N6ID0gcmVzcF9zejsNCj4gPiAgICAgICBkYXRhLmJsb2Nr
cyA9IDE7DQo+ID4gICAgICAgZGF0YS5mbGFncyA9IE1NQ19EQVRBX1JFQUQ7DQo+ID4gICAgICAg
ZGF0YS5zZyA9ICZzZzsNCj4gPiBAQCAtMTAxOSwxNSArMTAyNiwyNSBAQCBzdGF0aWMgaW50IG1t
Y19zZF9udW1fd3JfYmxvY2tzKHN0cnVjdA0KPiBtbWNfY2FyZCAqY2FyZCwgdTMyICp3cml0dGVu
X2Jsb2NrcykNCj4gPiAgICAgICBtcnEuY21kID0gJmNtZDsNCj4gPiAgICAgICBtcnEuZGF0YSA9
ICZkYXRhOw0KPiA+DQo+ID4gLSAgICAgYmxvY2tzID0ga21hbGxvYyg0LCBHRlBfS0VSTkVMKTsN
Cj4gPiArICAgICBibG9ja3MgPSBrbWFsbG9jKHJlc3Bfc3osIEdGUF9LRVJORUwpOw0KPiANCj4g
U2VwYXJhdGUgaXNzdWUsIGJ1dCB0aGlzIHNob3VsZCBwcm9iYWJseSBiZSBHRlBfTk9JTywgb3Ig
anVzdCBoYXZlIHRoZSBidWZmZXIgaW4NCj4gbW1jX2hvc3Qgb3IgbW1jX2NhcmQNCk9LLiAgTWFy
ayB0aGlzIHRvIGJlIGZpeGVkIGluIGEgc3Vic2VxdWVudCBwYXRjaC4NCg0KPiANCj4gPiAgICAg
ICBpZiAoIWJsb2NrcykNCj4gPiAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiA+DQo+
ID4gLSAgICAgc2dfaW5pdF9vbmUoJnNnLCBibG9ja3MsIDQpOw0KPiA+ICsgICAgIHNnX2luaXRf
b25lKCZzZywgYmxvY2tzLCByZXNwX3N6KTsNCj4gPg0KPiA+ICAgICAgIG1tY193YWl0X2Zvcl9y
ZXEoY2FyZC0+aG9zdCwgJm1ycSk7DQo+ID4NCj4gPiAtICAgICByZXN1bHQgPSBudG9obCgqYmxv
Y2tzKTsNCj4gPiArICAgICBpZiAobW1jX2NhcmRfdWx0X2NhcGFjaXR5KGNhcmQpKSB7DQo+ID4g
KyAgICAgICAgICAgICB1NjQgYmxvY2tzXzY0ID0gZ2V0X3VuYWxpZ25lZF9iZTY0KGJsb2Nrcyk7
DQo+ID4gKyAgICAgICAgICAgICAvKg0KPiA+ICsgICAgICAgICAgICAgICogRm9yIExpbnV4IG1t
YyBob3dldmVyLCB0aGUgcHJldmlvdXNseSB3cml0ZSBvcGVyYXRpb24gY291bGQNCj4gPiArICAg
ICAgICAgICAgICAqIG5vdCBiZSBtb3JlIHRoYW4gdGhlIGJsb2NrIGxheWVyIGxpbWl0cywgdGh1
cyBqdXN0IG1ha2Ugcm9vbQ0KPiA+ICsgICAgICAgICAgICAgICogZm9yIGEgdTY0IGFuZCBjYXN0
IHRoZSByZXNwb25zZSBiYWNrIHRvIHUzMi4NCj4gPiArICAgICAgICAgICAgICAqLw0KPiA+ICsg
ICAgICAgICAgICAgcmVzdWx0ID0gYmxvY2tzXzY0ID4gVUlOVF9NQVggPyBVSU5UX01BWCA6DQo+
ID4gKyAodTMyKWJsb2Nrc182NDsNCj4gDQo+IFBlcmhhcHM6DQo+ICAgICAgICAgICAgICAgICBy
ZXN1bHQgPSBjbGFtcF92YWwoZ2V0X3VuYWxpZ25lZF9iZTY0KGJsb2NrcyksIDAsIFVJTlRfTUFY
KTsNCkRvbmUuDQoNClRoYW5rcywNCkF2cmkNCj4gDQo+ID4gKyAgICAgfSBlbHNlIHsNCj4gPiAr
ICAgICAgICAgICAgIHJlc3VsdCA9IG50b2hsKCpibG9ja3MpOw0KPiA+ICsgICAgIH0NCj4gPiAg
ICAgICBrZnJlZShibG9ja3MpOw0KPiA+DQo+ID4gICAgICAgaWYgKGNtZC5lcnJvciB8fCBkYXRh
LmVycm9yKQ0KDQo=
