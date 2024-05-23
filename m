Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C85F14AD25
	for <linux-mmc@vger.kernel.org>; Thu, 23 May 2024 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474639; cv=fail; b=n0vDZydB6rYejX8Go5GqrdBIBS/RSyb1WxtQTelIDH3F5SROulUpVfN4qyNWEJZ3bgeQmBQcAExrc8Jn7LJxprJmo/TADXd+S1L9SlVDoaVAwNbhqMsNzVFF4zRxI64e+s9e/kkM5mSgp8/S/rn7vrk9xrzZlJzpWkIapqTi+SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474639; c=relaxed/simple;
	bh=kk2K48dF1Tzc3oYTCUv+5zdKK+DQQ1z63KaBaN1MAAk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M8AKKNWGoQWy9KpxoJ9OWLvh0YR5JNccXISdyGRFXxqq5s7JfA+eNVuRj92IQYn/OpbcXbTR72PEuSsOWE9Lz0ngfNXq8/kb08YcQ4L5tyTB03blVJxvcJGOaNBMB1YncQQwjjRR2fzAFbkdM6gEcNrLXc9ZMepe43oRNvqwmJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cKZ9pg2v; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=B1p7A5fG; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cKZ9pg2v";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="B1p7A5fG"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716474638; x=1748010638;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kk2K48dF1Tzc3oYTCUv+5zdKK+DQQ1z63KaBaN1MAAk=;
  b=cKZ9pg2vV+5fOIaRrddWrekQgMXj/E14aCOMiBxgDp+9HMRoTc/vSGG/
   L5WsJm4RrEUDlXzUFhB/bsPK9prY8dkBv7F6iL3SW13qfMd9pYSv+CJd4
   PuvvrxwDnT680SoWTHsrcQhC//kpYP/t70fRGkP86vkT3XVuNMpciGNSX
   z8GHJ6QJR0roNZms0swWzNC7XU0Y3lLgVNrh7gJPBZRwiC8Erl+3eWmKc
   1b3QFPG3TyHoneIxE7Wv6E7LCY/8Z2bOz7Gk3G6nFwQ1nB2kNf0UYZucv
   S4qMVDK6bjIC58iEmisrYugjjBt3CkJw+NM463LOyWU+Vat7OsNA9t5dS
   A==;
X-CSE-ConnectionGUID: k+xq2fgrTaaKhobvN+zAJg==
X-CSE-MsgGUID: nVgCXGZzQr66t7rbIGtmeQ==
X-IronPort-AV: E=Sophos;i="6.08,182,1712592000"; 
   d="scan'208";a="16817142"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 23 May 2024 22:30:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Npn8kTjjk8BLUUgunt79sOT45MWUH73PIoRKdAnCObK13MKTrRGPyDXLVxbkodVDwLiLOAZ/n/jaXcPfh5k1Xa7v4pZCey9jpr3dHQR1KUkOGkmFpKpujLbuRDi18Ch2FnFdy7yXPFA70373tgSHF8evVAW1AhjlxTRDoZBTEWbLp64NNdQGwRTTsq0AIZCErX/MBOIXwwBDNVGra63cpznAjYqe15UwTm6SLsjAKRWecsHlbJW8W9IYGXI7pCRvE7fQB0qQXVMTiGaE08QP7gxKBQVDDOlzWH4JbT15z/xnQ80XE/Ka3m0e7daC2Vy3DVWX5jq75Ii+ws+efhh2Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QSkI5aK+QHg8AXgw0idUjWghUuc4mgZGY3/1t/krmA=;
 b=GcBqUf8zZyoDINmHgCchpnJ3aly0CL6AaZcF/dTZkYofXepFBTk24vEQAgIGodTu4154GNXWr7+53kunoabbor1NEGCOMMkCI4KinPcL/cIBIgxPoFUbUhlWsw8Yyp4p5gNCLi/G54MPh308v2O4uQ2JAIoikxQDBnTr+eN450WG3Oe7talKRK5w5nZ0WAUkBvFOqJabtGiNI2X4LQbIfNGm6WZTVIwZYS9jmLsmxYcFwzVFuGB7ZqjlLf386E2RJbU6xd8QQ4t5/AnxRuBEiFpFQ3WDX6pigZRF40zMJMfMHGLtdypf4LHd70q4NNL54MMn5+asfJkXInNyhn+8PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QSkI5aK+QHg8AXgw0idUjWghUuc4mgZGY3/1t/krmA=;
 b=B1p7A5fGWaThDtUmomV3bXjmP0dfrC44CCOGGqCCiagp/zIAmW67cer7bBkN7GJDtnT4NAmZCYabKPh1+mqQ0dQF4kKDymkdv2u9JiLQUubElYngdxgET0D1gOxzuTBJzxVxCI6amPtTKztqvN+5s4nE3qW7j5f0yrt2LEEXRQo=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN0PR04MB7999.namprd04.prod.outlook.com (2603:10b6:408:15a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.20; Thu, 23 May 2024 14:30:31 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%5]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 14:30:31 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: "Loureiro, Joao" <Joao.Loureiro@philips.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH] Add functionality to read the bootpart register
Thread-Topic: [PATCH] Add functionality to read the bootpart register
Thread-Index: AQHarRANmhBF4ZCxpE6S3dg1Ljmf3bGkzUdfgAATdCA=
Date: Thu, 23 May 2024 14:30:31 +0000
Message-ID:
 <DM6PR04MB65755894FA1876D24A4E17F8FCF42@DM6PR04MB6575.namprd04.prod.outlook.com>
References:
 <AM9P122MB0281EA706B05ACFB3E0E2405F2F42@AM9P122MB0281.EURP122.PROD.OUTLOOK.COM>
 <AM9P122MB0281612AE803A7E6B5A5A153F2F42@AM9P122MB0281.EURP122.PROD.OUTLOOK.COM>
In-Reply-To:
 <AM9P122MB0281612AE803A7E6B5A5A153F2F42@AM9P122MB0281.EURP122.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN0PR04MB7999:EE_
x-ms-office365-filtering-correlation-id: 4ace3851-e99d-46d3-0a8a-08dc7b34e66c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?30vT35Meopl2FTIZ7qQtu14xF7Cu2faSAq7mM2TJmY0dwXRw69M15A4Etf?=
 =?iso-8859-1?Q?QGu9f3sAFtkHiTmelTx3z9C2+97b0xTmw+lfqlZXLVI8N3zGpW3qMkr9BU?=
 =?iso-8859-1?Q?weey2G7TnaoBo7A5B57VLlZLDhjLmsjSIkbwxxnpBPDy5xzLSxyT1KAhS4?=
 =?iso-8859-1?Q?UwycRcxVAb9X6X2qwEcMJkRmxp+McnyAyfnxPkhJLZsRG/wCyOuYLHUo8h?=
 =?iso-8859-1?Q?/qsBRfS536KaxmPSRMA8FUS3ngMYlnD0CXayRu80YAoRloCq1Ohku1v8sl?=
 =?iso-8859-1?Q?MeBp6Ii9hYXDrX7qtjIW7wmaAwnqnwrEXGin1rsiietsevELG4TpLTMuH3?=
 =?iso-8859-1?Q?ulrAQiIwJOmCaG1SRIo8NIZVXLC+MxyMlWBGU63ctKj9/sDLXvKH4PIrdK?=
 =?iso-8859-1?Q?znTaGFC+V1oUOOQMu6l6JIQdz1r0zSsv4MLxqAF99g7Xh8eOvaXdEnpTOP?=
 =?iso-8859-1?Q?wd6bzEjULKQqGwtJQQGL9O/Z+//mm4w/Q9R3dnLCts0Y5mRhHBLpRq9jL0?=
 =?iso-8859-1?Q?2Ur7CFoynBd4r42DpphiukZ+fF3K1DisZWWWMB0GjsCsRzidZ3/Lej1nki?=
 =?iso-8859-1?Q?5lKETCMmeQRjgZtpYXWEcFTxjT93Swp28K/IFnFS7sh9dYZlrJhc0sGbMn?=
 =?iso-8859-1?Q?6xkBWygd4f4a8wOZUkv1EfcqfYr8iH3BkKlsUZuhTgnGLm8bsm1FHDNXnP?=
 =?iso-8859-1?Q?lwmpBeSCNn6xyUx4xxCYpG3lllc7k8Vyb5z8hCgeN3hdx0BVJCJAkzMY0I?=
 =?iso-8859-1?Q?028BPIRNxlYWLOquQP4vvabU8+CYfMHq/WJ3qQsEESWUq5G9Az3iNKCAhO?=
 =?iso-8859-1?Q?fUpY0ayuk8l69fLKl95urYxq9gpvtrSNrS5ubnfioyB2lkLNM4+vFxPPxn?=
 =?iso-8859-1?Q?+NIuCYFG56dJKyBNEEsy5XRiWHrdQvGFT0rGqmDs6dDPk8n9YE4U8BNyWg?=
 =?iso-8859-1?Q?jXxTQ3nAu4se867pMJvTWRD2r9CuyjfNJZzUaJjzYH7YyeGjS1UAa+f5Nr?=
 =?iso-8859-1?Q?KP5Gl21Y3Wbp3Aq23JeTCAJgyBj66qoIXnGqTczvX+Jparpb6rgQvnxtuv?=
 =?iso-8859-1?Q?5H9SaPq3PbjZr1Ox3N+Kh6YI01YW9uRpRc3pNM5tdeUcwZy44JkLLwAjiG?=
 =?iso-8859-1?Q?0a99f8ZdBq6l/e/kyu9N0H7ky0Bad19sPO5UpcyjhYN7UteWgRe/xWPoeK?=
 =?iso-8859-1?Q?hT27PUSQMNCfHIgdKViZ10fHn5B1ALG4JVxmVRAcS6ZlC9dwM4H59fJsvR?=
 =?iso-8859-1?Q?xExLP0X5FHbjuXZoZCaookVXxTMYM9lvLejmwG+LBAeDR8d/blwKgc0fqH?=
 =?iso-8859-1?Q?6RGvjiT6X9ECBnjNkvUj0aseopEArc7ffaMz/yFt27B+wg3Ns4Mjpk/iMf?=
 =?iso-8859-1?Q?cEi9PbL3ai0uQT/KHsNoSqY1jpQJc5nw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?bfgN5SgA86xBW9Gqnuca6JJpGRJrLjS7iOUbnm8+Js9ogbirlYaIiUsx0q?=
 =?iso-8859-1?Q?eXVA7xWHvQxj420lbEWPb82zQ66jgF910uyFAT4Y2PNvw6JP+1XlezgP30?=
 =?iso-8859-1?Q?rZH/YuI8yaVshIexOhg0zxwwejNdhYKzacDIveYWJwIp8w65A45vdeh3o7?=
 =?iso-8859-1?Q?GGo0Jp6DUg0Lz5a9NxV/rceiTQH8K1uUPc36D0eDV4Iqu2AvxqRFEccWeJ?=
 =?iso-8859-1?Q?lKSZwcTOP/ZwW68mzDy/PwoaySDbYAcZDtwZ+5i/jyl8Kv7LsvWtUe7HCl?=
 =?iso-8859-1?Q?r8wBJuZ/QdYRxD7g1aS1TEGxtOCZevRlZGvdg8JsWz/uafkzE/9Xf43um1?=
 =?iso-8859-1?Q?jHRWSoDvKaHYZYqEvUwztD9UofvyCa0kLHaq/FoSeHzzGuw6qMbpvsyBjX?=
 =?iso-8859-1?Q?KxVMJTgmjAHg+3PgY+Hd75eswmXA0BByzU0HLRSySWzM9tbBJWvtniBzJ1?=
 =?iso-8859-1?Q?ZU0OSc43ZkYZr00Y0oHYkJfs2UaLJAWEj8pkFsS9RE6ua3ThceIbebwos8?=
 =?iso-8859-1?Q?ZhYoaZoi6m/EXMe57vMw1jmJDOm31zrqH++pk6eUVsbX+QPBWXrx4BUXrf?=
 =?iso-8859-1?Q?do8GuKlzYANIkqEP5cShOxlAjXca+MjJrAnV8tIsG8NZFFfThqcpQp6fTs?=
 =?iso-8859-1?Q?Iw/KypNvm1b+V5jwAtVWG+MGof/5m06yznCnxuy5RYJf6pxp9M+dA7cyFP?=
 =?iso-8859-1?Q?HJB4hJqpYcgTC7nH30jXDYDbBqU+3fjG+Qdxc6mUj95EpbgUHpYolEEUAo?=
 =?iso-8859-1?Q?i7RZWw6CMBWeQb3EhVmamO9yjFxzPKvzuvKDVDUS3WYz4TJ/kPY2x2mZXd?=
 =?iso-8859-1?Q?mg6CYg/zqNUMSV91HDj4IPmEfAqxLpoUVvM3PKZ6dQIOkwYFaIIW8XbXLs?=
 =?iso-8859-1?Q?YWOWenLksudJgVRMXHwrkadqrp/kqBM6fei/zDpFjzEm0IvQbYWkQ1+muQ?=
 =?iso-8859-1?Q?HbCn8107kon8OXRCN7zYbClPEvbyPt4tOg+luubkxUEROmuZOBuG7wx+n8?=
 =?iso-8859-1?Q?WmR4qcO13Er9Q9QiMatdE0+fIvlC+Wq5Xgqi/W1LNut0dAO7V6yQZvjjJE?=
 =?iso-8859-1?Q?q4FKS1KXKOsuheiQG6bzJCa+TgvlBOevhHJUKl2I8/kUumk2YUa+0Fo5Q0?=
 =?iso-8859-1?Q?vHyOzYdBTmURR6mFm3oPqMXH/tmA2T+AiZmGmi3VYolhXrDcZGFlB2lY+6?=
 =?iso-8859-1?Q?4l4b18gXpfgO3bH21+ip0O2FvuhTzy6+15h4PeEhaknqund6+ip1LZM/cP?=
 =?iso-8859-1?Q?/yemqDDaynWgCUhFF9QtuGSBxx1j0NnFOsb/QxK4E63Cjx2CLEd1FV89iM?=
 =?iso-8859-1?Q?RuED0ntC9z2cUjH9/mVJ5aYQzGTzvkIFJ0dBHyJaers4LH2e8Zdkm2wr5J?=
 =?iso-8859-1?Q?1wlX42PKqeWOZBd5ipmrpMiVCiGmjKXaNpU7xgSnajzUuSdT37rW1MpjyN?=
 =?iso-8859-1?Q?TTvHEuxD/I2v2OO2pGzlTbG/j5SzYAL6hYzQ9R6Yv6TAL98lh/xpxuAr0O?=
 =?iso-8859-1?Q?IXuSDacT1ZU3XGOuRTyqBV1KRcgVzUzfoEA8nUH4H69DrD63VbZiLMxCSe?=
 =?iso-8859-1?Q?z3XcSPBPEKzLtzABKbH+lDscoMgaIwhTqgGOBfDuk9gO92qztafYjlPy7i?=
 =?iso-8859-1?Q?a5Zz/8AQqn62c698MtZJrCfGUA6P3jre1E0gyDiga0TeA01923LEIAY7yp?=
 =?iso-8859-1?Q?/eJOAlXm1zOEozO9PSvgZ7UNo+dmjLoQ8KQyaHXR?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	moLiqiEpNWLZQqEmgfrJPoVv7q+VnIljzs/H5bX2R8vQ1+ykkaWR87koO5xvJJiAqVucq0uOYxRwE1+oRHBwL1T+eUyZoSyoXtm4IhE8QYNh2KDZILRNGv279b9TxEVZNd5AS5RPN3LpXSYQoFxlzI/yvlz6ywwYprLZQhrg6TxzQDa4+EgZ+GfJME2bmXQxNxhrFyI3sX1+ugLAjJ3WJynz6gmH6Pygh6dIdBB2skqBoQ0NIVWAbxncBOucvPmd2RpnnatVUqlPa+0Nk2kk+PT/kMoto7NuPrskrrY1zPeHoo36fo84S90n53FePdtJOg3/ixC+QEbyT74Sx704nRPGyJgzcW9PrjTsnPucjb0vnK5UHo7afDpS6MqCXnzCi6zmMUnQpWnZsay76gmRTx2D8LeSwAemSRMiG+7LmbC4jaHh9eSF8vsOAd2JFmsQKnnQsNZm6nH0RDy1UAuUWMFs04R7tMO+g9wzAGyABjplpgysAtstgje84dDjETGxufwY22DcIM6NH/N2DeZKNNS5vzHemsB+gisgP3+79RWXqAFochWj8E5uOyIXgHY8zeBNZtje/8DhM+h4zRF+A3Jki4+WHzdMn95yvt2cTzepfMTXUt3SiD0iS4Iss+1v
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ace3851-e99d-46d3-0a8a-08dc7b34e66c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 14:30:31.3808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yIv4Rke/sIv+176Wc36BTrgQld+vMe1d+UGI/k3CP3PR9OvWWZgG/64sLW6uzglJFiVqNEqExliwwq4D4+fSpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7999

> Currently the only way to read the bootpart register is to dump the whole
> extcsd register. This patch adds the possibility to read the bootpart reg=
ister
> directly for situations where the whole extcsd is too verbose.
>=20
> Signed-off-by: Jo=E3o Loureiro <joao.loureiro@philips.com>
You forgot to mark your patch version.

> ---
>  man/mmc.1  |  3 +++
>  mmc.c      |  5 +++++
>  mmc_cmds.c | 54
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mmc_cmds.h |  1 +
>  4 files changed, 63 insertions(+)
>=20
> diff --git a/man/mmc.1 b/man/mmc.1
> index bccabf3..8aff106 100644
> --- a/man/mmc.1
> +++ b/man/mmc.1
> @@ -59,6 +59,9 @@ Disable the boot partition for the <device> with
> <boot_partition> set to 0.
>  To receive acknowledgment of boot from the card set <send_ack>  to 1, el=
se
> set it to 0.
>  .TP
> +.BR "bootpart read <device>"
> +Read the boot partition information for the <device>.
> +.TP
>  .BR "bootbus set <boot_mode> <reset_boot_bus_conditions>
> <boot_bus_width> <device>"
>  Set Boot Bus Conditions.
>  <boot_mode> must be "single_backward|single_hs|dual"
> diff --git a/mmc.c b/mmc.c
> index bc8f74e..26c4f13 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -126,6 +126,11 @@ static struct Command commands[] =3D {
>                 "Enable the boot partition for the <device>.\nDisable the=
 boot
> partition for the <device> if <boot_partition> is set to 0.\nTo receive
> acknowledgment of boot from the card set <send_ack>\nto 1, else set it to
> 0.",
>           NULL
>         },
> +       { do_read_boot_en, -1,
> +         "bootpart read", "<device>\n"
> +               "Read the boot partition information for the <device>.",
> +         NULL
> +       },
>         { do_boot_bus_conditions_set, -4,
>           "bootbus set", "<boot_mode> " "<reset_boot_bus_conditions> "
> "<boot_bus_width> " "<device>\n"
>           "Set Boot Bus Conditions.\n"
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 936e0c5..add9e56 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -233,6 +233,29 @@ static void print_writeprotect_boot_status(__u8
> *ext_csd)
>         }
>  }
>=20
> +static void print_boot_en_status(__u8 *ext_csd) {
> +       __u8 reg;
> +
> +       reg =3D ext_csd[EXT_CSD_BOOT_CFG];
> +       printf("Configuration bytes [PARTITION_CONFIG: 0x%02x]\n " \
> +                  "Boot partition: ", reg);
> +       switch ((reg & EXT_CSD_BOOT_CFG_EN)>>3) {
> +       case 0x0:
> +               printf("disabled\n");
> +               break;
> +       case 0x1:
> +               printf("1\n");
> +               break;
> +       case 0x2:
> +               printf("2\n");
> +               break;
> +       case 0x7:
> +               printf("user area\n");
> +               break;
> +       }
> +}
Maybe re-use print_boot_en_status in do_read_extcsd() as well?

Thanks,
Avri

> +
>  static int get_wp_group_size_in_blks(__u8 *ext_csd, __u32 *size)  {
>         __u8 ext_csd_rev =3D ext_csd[EXT_CSD_REV]; @@ -602,6 +625,37 @@ i=
nt
> do_disable_512B_emulation(int nargs, char **argv)
>         return ret;
>  }
>=20
> +int do_read_boot_en(int nargs, char **argv) {
> +       __u8 ext_csd[512];
> +       int fd, ret;
> +       char *device;
> +
> +       if (nargs !=3D 2) {
> +               fprintf(stderr, "Usage: mmc bootpart read </path/to/mmcbl=
kX>\n");
> +               exit(1);
> +       }
> +
> +       device =3D argv[1];
> +
> +       fd =3D open(device, O_RDWR);
> +       if (fd < 0) {
> +               perror("open");
> +               exit(1);
> +       }
> +
> +       ret =3D read_extcsd(fd, ext_csd);
> +       if (ret) {
> +               fprintf(stderr, "Could not read EXT_CSD from %s\n", devic=
e);
> +               exit(1);
> +       }
> +
> +       print_boot_en_status(ext_csd);
> +
> +       close(fd);
> +       return ret;
> +}
> +
>  int do_write_boot_en(int nargs, char **argv)  {
>         __u8 ext_csd[512];
> diff --git a/mmc_cmds.h b/mmc_cmds.h
> index 5f2bef1..12716b5 100644
> --- a/mmc_cmds.h
> +++ b/mmc_cmds.h
> @@ -25,6 +25,7 @@ int do_writeprotect_boot_set(int nargs, char **argv);
> int do_writeprotect_user_get(int nargs, char **argv);  int
> do_writeprotect_user_set(int nargs, char **argv);  int
> do_disable_512B_emulation(int nargs, char **argv);
> +int do_read_boot_en(int nargs, char **argv);
>  int do_write_boot_en(int nargs, char **argv);  int
> do_boot_bus_conditions_set(int nargs, char **argv);  int
> do_write_bkops_en(int nargs, char **argv);
> --
> 2.34.1
>=20
>=20
> ________________________________
> The information contained in this message may be confidential and legally
> protected under applicable law. The message is intended solely for the
> addressee(s). If you are not the intended recipient, you are hereby notif=
ied
> that any use, forwarding, dissemination, or reproduction of this message =
is
> strictly prohibited and may be unlawful. If you are not the intended reci=
pient,
> please contact the sender by return e-mail and destroy all copies of the =
original
> message.
