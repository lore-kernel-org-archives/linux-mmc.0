Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83E42746B
	for <linux-mmc@vger.kernel.org>; Wed, 17 Apr 2024 06:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713335544; cv=fail; b=MZTJoqgW+XF0hUvB35EFQ7/5iV+0P9urVgaWHEXvIIdc9z5dg95WVi8BVG6w1jZcLnYeXJzyyRVCjAQvjPf7yH2AhzDOnMmYiva0zA7bYWhV3p4AdbbDO6GC7uISAzxJeforC/wi7S6bJjWb+RdgYcz4y//G/cBV4aMXqF/WO80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713335544; c=relaxed/simple;
	bh=dnRJ8PfKznqNIk25QrpJYwEP7VbV9XItG1dxpgVtsOU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JVd7Rrk/J8guFbNPytSvD4cni9ZBttqp7AnbqigBqcWBuGdc+MOhKrJlgizNQZyFoDdO4bleeaW7dtCY4OxsylarT8rgMOa592OO6kbqANFai1tI61UtTFVsNbyW5JMdWKjmtH78aZdzrIA7bQpxh242q1WTcROgONeHujFrWY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oEBIhw06; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=fH4gyjSC; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oEBIhw06";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fH4gyjSC"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713335542; x=1744871542;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dnRJ8PfKznqNIk25QrpJYwEP7VbV9XItG1dxpgVtsOU=;
  b=oEBIhw06H7K0ppDXyPdSoxuycyfHelC2DkVVn42JWSQqV0Zo4uv3pDC1
   nNo/CC9A3ckKpaVKbErL3suw6u/nzQwkJd4espUCjwg/nFLGora5MHxjQ
   xHWsBM3ICReIEWGccIX29CE8Fsl69cEkOMrv/WuWg2Csr90xMa3XF3AzD
   qYQF87zPfaDlFKU9Gbccyn8BwNn5PJNHc9uP/acDj9GiY/5DAZRxTerAu
   YO0UF3DOQsD0cQvDWEhufRbIfT9+dbxhagFkdWMy0dKc14iQ3+GUr5IpQ
   /Zgd7s8uYZG/qQSzv+tEfh1Bynx1dCuMeex5gt6/WkofXj2S3NH6ditLp
   w==;
X-CSE-ConnectionGUID: w1ce0wvNTyW2Iy8xcTf92w==
X-CSE-MsgGUID: XeJpHNRzTgWoAaPnDrw4dg==
X-IronPort-AV: E=Sophos;i="6.07,208,1708358400"; 
   d="scan'208";a="14195274"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2024 14:32:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdxreEu+cxf5t3m+BUCRNzQCsQ7dWsC9LU0kTXj2Y4M9vRDtjEwKbQ69PWHx6TbboHZ6tUpqBEPDj1ovShkJP7c0CFk6L6Iu2qh5+DYFxb8iUczxnABGUAC0dMcw7XDFiU25z+MnnEAO/O3BFvSf39vNkSEnXn/j+9u/bBXBk3AHOPNpR++ZUlCZ0qwMu2vqzZHy1LZlbKcJHCj1FgLLRyEgo/gYWgvhzc84sWigtlKMaHlhyc753gugbCGOGEXyfNRLSoyIsL49l4DlfhxGyOfzVa2hI213Yi+ihNj/WpinGWUebsDemc+jUy3vmo9ZroVk1noG2IsBckgZJmb95Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnRJ8PfKznqNIk25QrpJYwEP7VbV9XItG1dxpgVtsOU=;
 b=OYBpoOzlW4niEGJwPJCEl+IKnpKbStShK4FwyTfDfnM1+Qq8hlMTIKZ5B2grDOHuTg2mvjBR56eHCxIKc3oL+DCW16tS9IsSpc4SMdQlvsLZuFdNZtdHD8MulHlxjjBV5kiFuEm8M4XW+LiSsiyOHct23Ujg7L5m/rhM/cGgo4fBzYGtW+HKcJoQyJTltBmILlWC/ZuHw5FiCuXnPpo1yIQWUXR0Y5um8G6w3oFcmoBH5A0qVdqYUM4/5HXWzaGzOBIINz+8v1rGSK4Ed5DUtGTUh2LKMVHG1K7DH6A9hOb9vnxOlNJt2Y7KvCTeuHNo7B5xtC0kMtzW7I+q4YJ8xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnRJ8PfKznqNIk25QrpJYwEP7VbV9XItG1dxpgVtsOU=;
 b=fH4gyjSC+bYuLq6ri8LLN+xMcDVrKb5zaSgb1I77OQxrZ45S4VSEcRksL0wiX9EM8Qm3yxfg0ZtzGcfeI2ZGehU93ZP88yY6vSfhY891rP1qSn24pJ2TvH85tYOCQXn8ZuAgyR7LbjJhOCuuASP7lFQb4WVwL0nyZ0/uIGmJw34=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH2PR04MB6537.namprd04.prod.outlook.com (2603:10b6:610:6a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Wed, 17 Apr 2024 06:32:19 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 06:32:19 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Felix Qin <xiaokeqinhealth@126.com>
CC: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc: core: increase the number of retries of the cdir
Thread-Topic: [PATCH] mmc: core: increase the number of retries of the cdir
Thread-Index: AQHakJD/QPnwZHBqmU26gnfuc2BKTw==
Date: Wed, 17 Apr 2024 06:32:19 +0000
Message-ID:
 <DM6PR04MB6575F838F1F1CBFD4224765EFC0F2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240416145912.114409-1-xiaokeqinhealth@126.com>
 <d13bf7701ab694fe273b82318f3c6bc3@manjaro.org>
In-Reply-To: <d13bf7701ab694fe273b82318f3c6bc3@manjaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH2PR04MB6537:EE_
x-ms-office365-filtering-correlation-id: 157868cd-fd5d-45c8-8f95-08dc5ea821e6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 nXqawZCq68VytGmoUop8s+B0cqfYuipsIOIftlChGJ9EaDNUIEm2gi7Hz52miU3mSe0MQerB377mD7T1zAhHFpI8YFIA1zyMKO20J2WzXzCjKp9WZboLLj1Zsy+dLID094Kg64xhFlIECukmyBVzflvg71bICd6ccWcPrjE+pL+SpwQ2lun/VwqiFEnXNgVdlfXUpzriWLFjGCGrO261w0vaGYHlnoEhdmggSVH8isb32xE6Y/6JwHmyOMrB+Wv+cKHqgZHaucuK7zstp2mnrOr5A7jFBxUEaJXgl5zhUb1Blr7tLG+KTVbYdSeRjNLXGz9NQhOAm0RNv5vkMYAWo0wKF7RbrC69Gob5YuZgEG0cLVIulx2bQUXXc3wwqDaGifloJ4rgI1dP7slyVh/9+S1oRErBxOpTpUMf/VJMkIDg9YalkM6S81X2DVZ0ytam4za83K+UcqqlqVuzCapblHqapFS8m0zGrjroiWpxr5/K0CuQ7F4uXtgUGCIrq0dJjbHSh9PEAtKG22BlGPRJpu7INZupZuCaSx4MZb8MpemxexEoFoN5xSUVyh1y0LQJpbLLkUClUVhrd7J68gnJ6qIwApQPw3qqAivo/uv3nbMDu2fesHWVx61nOkXg8ANEkLnHNjJHPnRl0khLz101dfWjIMesQmpb+vQ68aFO7TroadTRKh4N+WrLMcjWuJdIiqhVv/f9LEtRCs/Z/I1eAg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?btnA0VyYcHZi9z2q3wbaHG+w4zNdbH+xwJnQUIN6o6sFB9VDg5g0NM0l2zh+?=
 =?us-ascii?Q?888mSOMV0EyE0HRRdF3wpwFP0bFt8UjbAq/klOzWvdkYCDZkVwon2KKeRoPM?=
 =?us-ascii?Q?eretphooo1DZZLS7JgyrJoPLOMUeyWmZvX8q8V/GE9gSCS646yQaVQtDzfgs?=
 =?us-ascii?Q?d86HI7A24KWug0lrNBzzLnNKfAksOrdngdi5MIaMMbOO2vZk7gl7eglLwmtm?=
 =?us-ascii?Q?FVZ/vlPwwFVnAyJkTMVxK6fpvU9aN/Rpdg64WLX72onLn/ZYM6kUBEPhwPwi?=
 =?us-ascii?Q?NvGuL3pWz7kX8QMxuWCGSr+nq++KIe4Nefu/3S2pjxRiYGfpKFcCHRLWKEqx?=
 =?us-ascii?Q?N0z7MTU2eRMxkQBHMoAosnsDYi+PU+IY2VEuQ+ls5cvsaBRWbl5G0Ym/Nqtn?=
 =?us-ascii?Q?vz3DOGwAmjQxVHoAp0xZjk1A9g6j/ZivvEc/hBN2Sq9KRC3rPbzNqSkXDNI6?=
 =?us-ascii?Q?9I1xTSQfAJUZ3ycS8e+QfVEkBQi1/2qSooJdi7dQ0ULzIiWD8yJM+JJSTcox?=
 =?us-ascii?Q?guoJiK0IImQ08rz5jT2Xya6LqGwlfv1fq7waTM8+hoCet0C22Sv+VxImQf8K?=
 =?us-ascii?Q?eSr7dRvMsjVpEnf6EeCa1pefd8W48oaDqHzoM7VBikudkbH/u9e50rgRAegn?=
 =?us-ascii?Q?TcTt8j29yi/XcW6moYs31a6lBoGgT57emGFBWkwrWWkMmqzisZ5C2OWTf0MN?=
 =?us-ascii?Q?nfzb9DTOz9kXiIdEewK5IudsK5kPhote92gn3AifzM+vXC5b06464fbjJxCi?=
 =?us-ascii?Q?QXfHjsfeliYkv5X7L/RvF0wEzB5xMGNR9yrzuUhYZUfuawTRnaD+62lNIq0P?=
 =?us-ascii?Q?lSYW5S1H9IvNoHaLZTR021zekxVbXB+4iJPeWP6oCGeXUEdY9x7K/E48OItg?=
 =?us-ascii?Q?VgB07YcjnZZjqGws9vmA85UtQZtezEEyMaooiItGd3A6sTLv7hzYtUvehxsB?=
 =?us-ascii?Q?VVcAFUCn1NTT67FRASvAo+1mx0YzY96++l3k1HzOmpKFR6GQIcD5uc6GUNDv?=
 =?us-ascii?Q?hJktAajtPagdLhRSMn7A4l+86xNA0L76IGQinRoCh18Zpc2jvsYv5sw8iIY4?=
 =?us-ascii?Q?IyeAYgbT2+JrriCUU0Nwd+YcYkw++H6MAWG0ICkZw64ypgkDjF8fMzdsqNV5?=
 =?us-ascii?Q?umHXlE1TWCBqXmNXZ0N/DHsavZcVomANEYSB8siwXthRlJBlCZOUNWNauZDt?=
 =?us-ascii?Q?rH6dTyAn+oWzEydz2Npvu9um/FfaEO0gnvp6GK5N9gPSEYf9iujjdSO1aXaH?=
 =?us-ascii?Q?FkFzhVqpnCob8ZlGIkNjSDoIh49PlXnyGofLmvWfe0xwdGFNJX0uOrr9KPDi?=
 =?us-ascii?Q?RIHLxd6fzR+o3ipeLtBDBtOAEXXWJwMlcTVlarmHMYq9JS6uE6OwNxFb0yOz?=
 =?us-ascii?Q?im1a9VqmGF2SPUlb6giSBW88Cy08roqhIj1XHIRhmMqxlPgu+yFCiCRp50oV?=
 =?us-ascii?Q?ysHB7uav84pcyvahl+XZr3IJ8cULC80mKOXKMi9Y/4oOEleTXBcnJd2pncka?=
 =?us-ascii?Q?OLZ6rInPrvhIw8RsN5xOcxz6YKhqB2VTN9jKnpbxJahUsLnNSSOUPmhR6Ras?=
 =?us-ascii?Q?dGIyL17AsArgJhIWlNgAnsfi7s2HX/ThQzZyKw/n?=
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
	S+8PvAdzKUXuW+MufvB69hG5cOhtAT8Aa6NrnwmRKFZqkZf9H0MOwMMewP7FrqtrsvsF+o7f9BQSzOw/F5VI4ZSZhbFth0nlpH38jH+k/+SZN6MySrkXyjfUgppAZpYI+V0Gr2m/CKRPbOujwE+eFExIj1TVmvfsLowLNTCRDdmm649LTsDhLbMPUsB3IN3FTHvlB+P0WH5w7JeJeN6gcIb3gi5sgQDnXQSnpDFBnqAyE3AP1KK8OUkEH9VwNyJoIoXvAOTL7x8VOIk751iK20BUOt7YYQFeL7Qj3klNOBJvnKPqFWRAM2NtsnIxqOIj2bmxI0Yxss2U9vCZEBc8k8ta31C4hE7n6KwRQdxz/R7Vgi9zileYnONJR0cG8OwME7iTP8cusWvN3slrDuCtET/YSiWy2tFgw+FLRhm/wZobZNkBJBZRMt7DedCe7JKxYG3BAJHadiA9b1L0uLwaNCD16OLtJW/8ll98TH4O81wsBHBtfPKNd5CtrmNTk3SQQgJs/+T3gn1VF7KFfBAS34jXkfFHPpyiLv6OvXDR7of3ETEi04kziOLpLGQaO+DkGusUQJm/Hr5Ncjn6TBAKPgHY5FwNpOXcPbYZONGk8CBESk88MVOonNxZ0F0eQhA1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 157868cd-fd5d-45c8-8f95-08dc5ea821e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 06:32:19.5888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0nUcEbQzBbDFl0YWyIL6FZ5vyvNzNDzQQ2cfAYcwvujcOc0O8ApSxzdtEykM47Zl9Bxq9YikIBZ9ergmE1w32w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6537

> On 2024-04-16 16:59, Felix Qin wrote:
> > Extensive testing has shown that a few specific SD cards require an
> > increase in the number of command retries to successfully initialize.
Acked-by: Avri Altman <avri.altman@wdc.com>
