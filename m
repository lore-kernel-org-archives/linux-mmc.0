Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA17BE5D
	for <linux-mmc@vger.kernel.org>; Sun, 19 May 2024 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716130457; cv=fail; b=Ul+Ox0YE1vnLL0iNKOYVufGNxnQnYuxpBNrcpLV6O36JNMYBElHiCIL99NFn/+KQx3VAUVHq4dFV5U+pbbAMetQ1sndu0N6m8zZ6hWpWPy8xLRh1+slrNpJX+hbzo9k1kODmDhZNzGxAgcHd4mTdBdlNFGhDun79lXVB0Oz2AgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716130457; c=relaxed/simple;
	bh=sFEavGOqe/SAyNiGowBNhrOEUdT53MQNJZ96BJCmKmQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cXrDdeaGtch7J9LtH0EBgv5mOUi50Hp5MAyXggXLNXzyS4sqnmSGFFD/w0kuG9mTMY0fvblrVve5hLbUmnZ2zLUNyXhwExhPjd+aI6561rZTYBCM8Q4fFcK4pT/D8K5/41Ee/64ipRpOKndWsxUiQz/nQpz4dP2+D2GhO2MFmao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Forv5T8N; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=M2e4Y2T6; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Forv5T8N";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="M2e4Y2T6"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716130455; x=1747666455;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=sFEavGOqe/SAyNiGowBNhrOEUdT53MQNJZ96BJCmKmQ=;
  b=Forv5T8NQQtNDyI5U7OEN3PrnY8eEyTeINOTdptQrA+MjEb8qZov11/Q
   YzdCEDCsox7hckTeni3SlLG+GvX93dpDcDbxLIkSZM4kcQwQIuVDvn7sC
   ZCo0mJZkSAS6OUF01r1GbgSp66RjPBb5yKHt2L5MX7oJg/9mrUtx/QYtw
   550MRtt30kUvrR0uZ1jz3SvOWoPT0avvZ9UinIOjQtjssbVmbTm+L8PJM
   cbF6zFm1bhdj+uHuPunWEV3QuYEbufNUCZpv0ZjyhZJhtJ21tJikk5+70
   AsFD+L/DfcqwHQtdvMlC+EfUGBmWoELjLgT+JSFF3Ta847QbSr/mscL3a
   w==;
X-CSE-ConnectionGUID: mdnwFO/VR4moBdvM9qOKtw==
X-CSE-MsgGUID: QG23ULXmS2Ki8KZ8QaIbeg==
X-IronPort-AV: E=Sophos;i="6.08,173,1712592000"; 
   d="scan'208";a="16677193"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2024 22:54:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9zQaKFeor+oZLrvlIcVPznCIikaWR6N/++hpXtpHpGJFMHeLTqHLdDUibnFN2CbEohQ5vZudFlYQ9XR6UeXHPf+9RBNjx9H4S6t+pAR45yT8zvx9FvaMbqf1SImVWUjpHkbdOzOR+ltD7nDcCP1UgScKCKbR5qScRyiTl9IIUD2kNFpa0i5Ac4Hmmr/lfpDcqXt/y0vz8e0bNE3ZpwSZety3ynEd0HNaCIQIANNX7/LJyhk4r+a043OlZ69nXYv5XCpwffIFaKzkF2SGDNDK7WnLCC2snenpO2deW/idZGPByANlU3ZzCi/Enb2ncrE70z8NO+KgjOYukS9Ab0GJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzM+q5d35l2vY0SlDDWO7ysSrs+4rkC61XvvkDEkLjk=;
 b=DWDzGa8WMdR4xyUMgEfTKequM8pZoGLWBHqVjD82nZ3zSPE5y3gcpcbg0AnTou+TWaI4U7h6YmLzsMIT37IG4qqVCKdN5h4QGtq9QWvBap18GMarW4H5KefiV/h8DmXH4eA8zGSmCDKyVnRieAfFSiwI6nTZcaxmZ3NVf6SnViQY8nd1kZlehzClH0ppK+gqq30KKihybna43Zsh1N6oLnLkrQlGgy3UNjyP1CBVeq33IKAvsQAz/NDMOfZgIrEqqkQAVr9QFmts2Rkhhol6QxIwYbDVRiL/9Wcy4j5WOhPOliU5tslFw0oOrWws5BMhTtn3HFY3mnIbYBT9a4N42Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzM+q5d35l2vY0SlDDWO7ysSrs+4rkC61XvvkDEkLjk=;
 b=M2e4Y2T6Qenpli2Pab0Y46xdCfUrvYTXv04gcHiU7WDzfuvfCmtcqkWVaqGSYQKdoPIRFxJtd2Q3bP0UvoJ9nqFj+STNF8mYtKLnHRL6cQUl4N7rlnUy3sy98eAg9CVs449hvs7e+IJ+YmmH9kIEYLJOEcySBU6BpYKQ5DzP3CY=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SA3PR04MB8626.namprd04.prod.outlook.com (2603:10b6:806:2f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34; Sun, 19 May
 2024 14:54:05 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::73a8:8d4e:8c05:62a5]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::73a8:8d4e:8c05:62a5%5]) with mapi id 15.20.7587.030; Sun, 19 May 2024
 14:54:05 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: "linux-mmc@danman.eu" <linux-mmc@danman.eu>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>
Subject: RE: [PATCH] mmc-utils: implemented CMD42 locking/unlocking
Thread-Topic: [PATCH] mmc-utils: implemented CMD42 locking/unlocking
Thread-Index: AQHaqbt6tJbSe7J5F0aYFSUNoe3rsLGemxwA
Date: Sun, 19 May 2024 14:54:05 +0000
Message-ID:
 <DM6PR04MB65756D83C351681616139155FCE82@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240519070843.467268-1-linux-mmc@danman.eu>
In-Reply-To: <20240519070843.467268-1-linux-mmc@danman.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SA3PR04MB8626:EE_
x-ms-office365-filtering-correlation-id: 238d2204-7429-474a-c938-08dc78138782
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YyXEd0wkL0xkZSNRdDMVQdDkSHtxjWwT/YgrvXYesLe9Q4RB/6fybZIqsOEU?=
 =?us-ascii?Q?/c3vlSrmruLxNaXZI/evdtJPJgY1oelsy+8ChFuTJVS6YK4xZX2iVMImkZyZ?=
 =?us-ascii?Q?8sxlZBGAG98fFBmZ2Cdd2BZzYhGYMvIDIsGx7nCn9fqGnlo9WRIBwyfTxMWs?=
 =?us-ascii?Q?NFYePlO4wW6mevxVbSjHSL6HDMpWjYpFrE+dMf8m9o+4lH8BT/ByQeYrnEgq?=
 =?us-ascii?Q?hekMRfFTV/BDvLoT30E/R5NLN8meNyF44ZAjZgNMmPlDUVJU3hzEPVEeWCS5?=
 =?us-ascii?Q?uqukKkW9s2g5kOkUqpf2vpAJA0T+67Hl4YJsobWC2uiP2XT0cTjCKm34JcU7?=
 =?us-ascii?Q?P0i8GzGZSK55sgZnyYSu3K7AvnKBwR/cv8KAXXP0jDo6dm5BG78KSlbakS0Q?=
 =?us-ascii?Q?zCCTTdF0HIOlG3r3gKTkFXszbkeL25NkNB85bLs5mbahQVU7RPUZM9rPSe+9?=
 =?us-ascii?Q?4SF6qM6ACSGmJMYkVfmZzOS1Ch7sinfKBwpaOMYp47pUXBRXWnk64H3fzoJ7?=
 =?us-ascii?Q?ZaWjurQIU7PlN7Tlrp6zh1kpHJwgv9b6qyD9rFRC1g69t2s1Coh3W0RnAWnj?=
 =?us-ascii?Q?XNruamXDOxpUc8dXD24wCiJY6Df68fdE7XPECb0djliW1jUmWh3HeQ+e31Cz?=
 =?us-ascii?Q?/BRZ0s3FFMOYkQgyYIM9pDzCK9fsSGNDt6/Yywv3iM+20K5IjeSQKL9knZl/?=
 =?us-ascii?Q?V8EiyXvxdEls5y3LxoUD9PEiRmbfaMpzRFiU8UhPMgR9HEFrvcvOOfsSvf9w?=
 =?us-ascii?Q?7O4UCTkJBSdTGeqWGD3icB6hTis99UUWhY0QYvA86wZeZW4+TdLQonS3ifsS?=
 =?us-ascii?Q?4CdEYl/ntzlm9n86ohiPNQjSuEUqXajg+NB8kMNY4uMI6SWuRwtd8qB+Ebz4?=
 =?us-ascii?Q?BSCF11dCw8G5NBsxzA4Przc/9x90v3GGRLUvMu8R70aPn3CkfOuz6uK3x6Dl?=
 =?us-ascii?Q?ymtXUoP17nMCBS5uiPZXJTnfeeyjlQe1RdSacyUbfuV1Pew2XHQ5zgIUOkPl?=
 =?us-ascii?Q?QSH3TJVPNhx4EZxRyHLKBzRrwKFaTwdhDn6ZCYWjgWRMTLYCDrUH76nr78vJ?=
 =?us-ascii?Q?W8K2llFtoyV/SPv9KLDGbpAylDYzoUSytxNMLyNq4lpmaeDbZWR7RY74Wl/v?=
 =?us-ascii?Q?zEBrI05hBugKgOJ1aH8DCouVTHByfnF7EfSiZWeY1x+9uwccJpepm89KbYAs?=
 =?us-ascii?Q?udiChgGNzjAq4zOepld/sf9rHIVwJ0H6w9d/WO1G+wJBSiz+bWj7I9SCG6LX?=
 =?us-ascii?Q?XUXwqwOgS0hMx3sBMsCBcQxhn2pnjrfWID4ChXtGOg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mwD1lKJW6wwzlztKFpDiSl2uOUhQO7ks1ruLDDzdNh+JN+tgyiL5626d25+H?=
 =?us-ascii?Q?wwMv331MzdupXLZ64vWn2hsNGCnx/vHVmSpviiXoRqEAnexeS62Vbb1MVMzm?=
 =?us-ascii?Q?DSSDm7MxaZd2Dqf44sgppnmXaMRq6jxtMLc1gK8WmQ4DLCkJiFJ+e92G85ps?=
 =?us-ascii?Q?j03x+qN8vtGWEhJqQm6eaunr6ptj2AqFknPFFJAUBQJMbMEBC7OV3WvukAVo?=
 =?us-ascii?Q?mv/a52oZ11mlVhUs4WkBpYCKicOk/Hm/7Xac3WaDGpJOu7XLCL/dIVKH4IKm?=
 =?us-ascii?Q?Ht/TF84TfScSqOkPPkFUYRjBuB+Jb8EOsbgzxJytKaECETHr1mdsM1IVhXTq?=
 =?us-ascii?Q?8wFAPfFzkHK1ocYRecBC7TeqT9Wkz6DLHYNGWBt3GycpNScoIOrzFnizIIfv?=
 =?us-ascii?Q?ElVeFSBBoUPtCUGMfKM61Mc9bt5f/b3K5R1k/EvlAZPq19jXiox5gEzBEOe8?=
 =?us-ascii?Q?Y3xHcseFSTQ4MxWAP3GcBvNGwaIFNUpYb3VbVmg8ThoWCVlI8ohXuJECzWvG?=
 =?us-ascii?Q?p6DLGp+zcPcVmyeKw3tSLsHe9teQ+p13ObJ1zPVCvqT1m7kBhZGyzOAqtB3s?=
 =?us-ascii?Q?sIh7EEf3aa8Q/63XcBYvZNQbwvVgIFtnnJLXhG3nyZu6rO5QJ7p+oAf4pm+P?=
 =?us-ascii?Q?6wSu9yDzk7oqGZhBbHjfwvH0bnETDV51qJedkkgvFwvtdsp+K1cVdBhuP6mh?=
 =?us-ascii?Q?HiJfFBdk8JfKhLIyy6a5SymmfotVsSMuKtPjzP6UD2WBQM8/Kf22TaUXJjZw?=
 =?us-ascii?Q?7NRcIQ1vB4bdIPKEMAlJo+IkHggv3BGfgJr/z7wFMmLgS3DC6L35F/TTNuKb?=
 =?us-ascii?Q?gSL0P1YEKgEMcJI4SYVy89e4xnq/l2zu6j19tXdjbTasCi57xLtNsgD1DkzE?=
 =?us-ascii?Q?DstW+AIqTF65qRpJ+748NnOwMA+C4AuWT6fP8tbvlJH5VQouH2cjbCiYxYbk?=
 =?us-ascii?Q?quM1rbeC6z4WSAH5ixNkAW0Wn+oCuC8YcW6fwBVQPbwEB99Pd1gdECnxUabj?=
 =?us-ascii?Q?8loulS+5VWh7qKOxFLmm1QcMMtDjZYNj7XvVXNQ7t2nit9PXHJTP/X7Xjnw1?=
 =?us-ascii?Q?4GL/u5oMPt+V/EZyRQ76Qnp6ogycWJmoyemeZNWHPPY8K2kmeLSrOdBzwPIl?=
 =?us-ascii?Q?SIwbOTZ95/R50ohdfevEF+Q96M89LWDKkb2oufgABauLWeu+VA/IKqYc7vz1?=
 =?us-ascii?Q?ja3oJfVv+s42diKLfZ5TKgxCm02B4AJFnK/u6JOk6SzhB51NJiXWD8BqHj4h?=
 =?us-ascii?Q?ff+NESHzMpsUbl0/6lR7RiNu/2BrZxo2g77qrkjB29qmplHtct41h9b2/su9?=
 =?us-ascii?Q?pWg1pYb9ECTTJsrVDlw74r6FrpVLco+Sfqs4AIrZ4MXgeAi0DJqrr38wqfj6?=
 =?us-ascii?Q?QD3EIol6+s63X9SffvXRmwpTupi92iCkBcs/EHhJF+Em8WRFkcjunLKzEqPL?=
 =?us-ascii?Q?6ymvRC01Ph9oDKgmZb47KKvurq4kluUoz2ULbh0W3yzclHE2AZrQJRWn/0El?=
 =?us-ascii?Q?xifpfJFedWdyqSYHOhveo+y8kENqXh2Derdj/qEPP3cz7OwJ6GWcbXlG0ipd?=
 =?us-ascii?Q?ZMGOKhnuyxVKxuOtGixmK7sjbxMm/wm30+85VDLT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e5dPnA/bIHd7SIL6ZQ2cv+eyu0JVF5kqCuKp/4s09w6xbbpxUJqWhvEfIQLF/MhJnLyhUFc9JvnL1DbaHkdZcgo1Qksa6CzTiIhOLzjZhspPHjtyXebV+HKY+QrLEIbZlcpN/idIaK6QoAmTHxpbfce5WeNy+P/nVw2ubDaBEo9YOB+ojBltUxy5JYubKtb5kYz3LZRQ7bcSUbvhl7ITPfoc0ZUx6OEQJOTjznWOmW5DqYEYKu/VX8nE0Ru/tkAmmG2wypJmkkofCnppK+lnFCH0aYvJHYDys7VaOoas4ACX+ao5HLASmZwMOzNrU9hikz3I8HuOk5Bht8Ay833FCTkONZ4hIY3uv+fgbVq7LYnodzzdUVx0Oic3USFIJD5MGoo6rx2/49o676zzApUXZRESAOPMtt6IbQi4RlO+Y16UwNIIayIg0sDDKlyBxrT8aB8GrJ8iAVEkyZeEVXMiXUpgdrPq0AArvFG3IMYJACgNG5vFVvcwvDjcuoaXnBYCfVCpLG35BoC9cOciayPmEcqA2T25x9GprM9FBV/YBSb7JZFjd1M6hN+OsXcI0hsPjwxxSeHJQbwB5Yu68rJ4O5hGmaFBLJZLEX272Evt00uWpxw/+pswhRK8a4aIwf1o
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238d2204-7429-474a-c938-08dc78138782
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2024 14:54:05.2848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7IZd0NGYSneN5TJ7tD7PKuwbnsauo5ctakXFdMrafYvuDSdNWLf/igzK7IDU0R/3baIBIRZPBnIvy07+xzKWEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8626

Hi,
Please see some comments below.
Please don't send a v2 yet - allow few days to look into the details of thi=
s feature.

> From: Daniel Kucera <linux-mmc@danman.eu>
>=20
> Implemented locking/unlocking using CMD42 according to Micron
> Technical Note
>=20
> original link https://media-www.micron.com/-
> /media/client/global/documents/products/technical-note/sd-
> cards/tnsd01_enable_sd_lock_unlock_in_linux.pdf?rev=3D03f03a6bc0f8435fafa=
93a
> 8fc8e88988
> currently available at https://github.com/danielkucera/esp32-
> sdcard/blob/master/tnsd01_enable_sd_lock_unlock_in_linux.pdf
The above technical note specifically refers to SD,  Is this designated for=
 SD only?
If yes please make note of that.
If not - Please relate in your commit log to the differences, if any, betwe=
en eMMC & SD.

The above technical note contains an implementation for mmc-utils.
Are you the author of that code?

>=20
> Signed-off-by: Daniel Kucera <linux-mmc@danman.eu>
> ---
>  mmc.c      |  11 +++++
>  mmc.h      |  11 +++++
>  mmc_cmds.c | 117
> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mmc_cmds.h |   2 +
>  4 files changed, 141 insertions(+)
>=20
> diff --git a/mmc.c b/mmc.c
> index bc8f74e..3ff7308 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -250,6 +250,17 @@ static struct Command commands[] =3D {
>                 "be 1.",
>         NULL
>         },
> +       { do_lock_unlock, -3,
> +       "cmd42", "<password> " "<parameter> " "<device>\n"
> +               "Usage: mmc cmd42 <password> <s|c|l|u|e> <device>\n"
> +               "s\tset password\n"
> +               "c\tclear password\n"
> +               "l\tlock\n"
> +               "sl\tset password and lock\n"
> +               "u\tunlock\n"
> +               "e\tforce erase\n",
> +       NULL
> +       },
>         { do_softreset, -1,
>           "softreset", "<device>\n"
>           "Issues a CMD0 softreset, e.g. for testing if hardware reset fo=
r UHS works",
> diff --git a/mmc.h b/mmc.h
> index 6f1bf3e..f8bac22 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -30,6 +30,7 @@
>  #define MMC_SEND_STATUS                13      /* ac   [31:16] RCA      =
  R1  */
>  #define R1_SWITCH_ERROR   (1 << 7)  /* sx, c */
>  #define MMC_SWITCH_MODE_WRITE_BYTE     0x03    /* Set target to value */
> +#define MMC_SET_BLOCKLEN       16  /* ac [31:0] block len R1 */
>  #define MMC_READ_MULTIPLE_BLOCK  18   /* adtc [31:0] data addr   R1  */
>  #define MMC_SET_BLOCK_COUNT      23   /* adtc [31:0] data addr   R1  */
>  #define MMC_WRITE_BLOCK                24      /* adtc [31:0] data addr =
       R1  */
> @@ -46,6 +47,7 @@
>                                               [1] Discard Enable
>                                               [0] Identify Write Blocks f=
or
>                                               Erase (or TRIM Enable)  R1b=
 */
> +#define MMC_LOCK_UNLOCK                42  /* adtc R1b */
>  #define MMC_GEN_CMD            56   /* adtc  [31:1] stuff bits.
>                                               [0]: RD/WR1 R1 */
>=20
> @@ -70,6 +72,15 @@
>  #define R1_EXCEPTION_EVENT      (1 << 6)        /* sr, a */
>  #define R1_APP_CMD              (1 << 5)        /* sr, c */
>=20
> +#define MMC_CMD42_UNLOCK       0x0 /* UNLOCK */
> +#define MMC_CMD42_SET_PWD      0x1 /* SET_PWD */
> +#define MMC_CMD42_CLR_PWD      0x2 /* CLR_PWD */
> +#define MMC_CMD42_LOCK         0x4 /* LOCK */
> +#define MMC_CMD42_SET_LOCK     0x5 /* SET_PWD & LOCK */
> +#define MMC_CMD42_ERASE                0x8 /* ERASE */
> +#define MAX_PWD_LENGTH         32 /* max PWDS_LEN: old+new */
> +#define MMC_BLOCK_SIZE         512 /* data blk size for cmd42 */
> +
>  /*
>   * EXT_CSD fields
>   */
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 936e0c5..07ba18a 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -129,6 +129,123 @@ int send_status(int fd, __u32 *response)
>         return ret;
>  }
>=20
> +//lock/unlock feature implementation
C99 style single line comments (//) should not be used. Prefer the block co=
mment style instead.
See: https://www.kernel.org/doc/html/latest/process/coding-style.html#comme=
nting
Please change throughout.

> +int do_lock_unlock(int nargs, char **argv)
> +{
> +       int fd, ret =3D 0;
> +       char *device;
> +       __u8 data_block[MMC_BLOCK_SIZE] =3D {0};
Just empty braces please.

> +       __u8 data_block_onebyte[1] =3D {0};
> +       int block_size =3D 0;
> +       struct mmc_ioc_cmd idata;
> +       int cmd42_para;                 //parameter of cmd42
> +       char pwd[MAX_PWD_LENGTH+1];     //password
> +       int pwd_len;                    //password length
> +       __u32 r1_response;              //R1 response token
> +
> +       if (nargs !=3D 4) {
> +               fprintf(stderr, "Usage: mmc cmd42 <password> <s|c|l|u|e>
> <device>\n");
> +               exit(1);
> +       }
> +
> +       strcpy(pwd, argv[1]);
> +       pwd_len =3D strlen(pwd);
> +
> +       if (!strcmp("s", argv[2])) {
> +               cmd42_para =3D MMC_CMD42_SET_PWD;
> +               printf("Set password: password=3D%s ...\n", pwd);
> +       } else if (!strcmp("c", argv[2])) {
> +               cmd42_para =3D MMC_CMD42_CLR_PWD;
> +               printf("Clear password: password=3D%s ...\n", pwd);
> +       } else if (!strcmp("l", argv[2])) {
> +               cmd42_para =3D MMC_CMD42_LOCK;
> +               printf("Lock the card: password=3D%s ...\n", pwd);
> +       } else if (!strcmp("sl", argv[2])) {
> +               cmd42_para =3D MMC_CMD42_SET_LOCK;
> +               printf("Set password and lock the card: password - %s ...=
\n", pwd);
> +       } else if (!strcmp("u", argv[2])) {
> +               cmd42_para =3D MMC_CMD42_UNLOCK;
> +               printf("Unlock the card: password=3D%s ...\n", pwd);
> +       } else if (!strcmp("e", argv[2])) {
> +               cmd42_para =3D MMC_CMD42_ERASE;
> +               printf("Force erase (Warning: all card data will be erase=
d together with
> PWD!)\n");
> +       } else {
> +               printf("Invalid parameter:\n" "s\tset password\n" "c\tcle=
ar
> password\n" "l\tlock\n"
> +                       "sl\tset password and lock\n" "u\tunlock\n" "e\tf=
orce erase\n");
> +               exit(1);
> +       }
> +
> +       device =3D argv[nargs-1];
> +
> +       fd =3D open(device, O_RDWR);
> +       if (fd < 0) {
> +               perror("open");
> +               exit(1);
> +       }
> +
> +       if (cmd42_para =3D=3D MMC_CMD42_ERASE)
> +               block_size =3D 2; //set blk size to 2-byte for Force Eras=
e @DDR50
> compatibility
> +       else
> +               block_size =3D MMC_BLOCK_SIZE;
> +
> +       ret =3D set_block_len(fd, block_size); //set data block size prio=
r to cmd42
> +       printf("Set to data block length =3D %d byte(s).\n", block_size);
> +
> +       if (cmd42_para =3D=3D MMC_CMD42_ERASE) {
> +               data_block_onebyte[0] =3D cmd42_para;
> +       } else {
> +               data_block[0] =3D cmd42_para;
> +               data_block[1] =3D pwd_len;
> +               memcpy((char *)(data_block+2), pwd, pwd_len);
> +       }
> +
> +       memset(&idata, 0, sizeof(idata));
> +       idata.write_flag =3D 1;
> +       idata.opcode =3D MMC_LOCK_UNLOCK;
> +       idata.arg =3D 0;          //set all 0 for cmd42 arg
> +       idata.flags =3D MMC_RSP_R1 | MMC_CMD_AC | MMC_CMD_ADTC;
> +       idata.blksz =3D block_size;
> +       idata.blocks =3D 1;
> +
> +       if (cmd42_para =3D=3D MMC_CMD42_ERASE)
> +               mmc_ioc_cmd_set_data(idata, data_block_onebyte);
> +       else
> +               mmc_ioc_cmd_set_data(idata, data_block);
> +
> +       ret =3D ioctl(fd, MMC_IOC_CMD, &idata);           //Issue CMD42
> +
> +       r1_response =3D idata.response[0];
> +       printf("cmd42 response: 0x%08x\n", r1_response);
> +       if (r1_response & R1_ERROR) {           //check CMD42 error
> +               printf("cmd42 error! Error code: 0x%08x\n", r1_response &=
 R1_ERROR);
> +               ret =3D -1;
> +       }
> +       if (r1_response & R1_LOCK_UNLOCK_FAILED) {      //check lock/unlo=
ck error
> +               printf("Card lock/unlock fail! Error code: 0x%08x\n",
> +               r1_response & R1_LOCK_UNLOCK_FAILED);
> +               ret =3D -1;
> +       }
> +
> +       close(fd);
> +       return ret;
> +}
> +
> +//change data block length
> +int set_block_len(int fd, int blk_len)
> +{
> +       int ret =3D 0;
> +       struct mmc_ioc_cmd idata;
> +
> +       memset(&idata, 0, sizeof(idata));
> +       idata.opcode =3D MMC_SET_BLOCKLEN;
> +       idata.arg =3D blk_len;
> +       idata.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
> +
> +       ret =3D ioctl(fd, MMC_IOC_CMD, &idata);
> +
> +       return ret;
> +}
> +
>  static __u32 get_size_in_blks(int fd)
>  {
>         int res;
> diff --git a/mmc_cmds.h b/mmc_cmds.h
> index 5f2bef1..9ee78a2 100644
> --- a/mmc_cmds.h
> +++ b/mmc_cmds.h
> @@ -50,3 +50,5 @@ int do_general_cmd_read(int nargs, char **argv);
>  int do_softreset(int nargs, char **argv);
>  int do_preidle(int nargs, char **argv);
>  int do_alt_boot_op(int nargs, char **argv);
> +int do_lock_unlock(int nargs, char **argv);
> +int set_block_len(int fd, int blk_len);
Please make set_block_len() static - as its only caller is do_lock_unlock.

Thanks,
Avri

> --
> 2.34.1
>=20

