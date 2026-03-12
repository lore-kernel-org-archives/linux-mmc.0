Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66B934CFA7;
	Thu, 12 Mar 2026 19:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773343575; cv=fail; b=l5EMCgwe9K1p/hjkrjv5kr7WWwEplZbakZeLaIPqHsjO4VXDemQNH2bwc9kKXpTR3vdcifnhkJbZdNaA70xNzZEOL2XJXDGK5xqwjrmuNFDkCr/8oUX6C2rd9zS2cKIhdRh4wgoeWYcnCjvteWJbek7yN+YkqODOcLUDMRgNH7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773343575; c=relaxed/simple;
	bh=2ESUeG6vmfWMOnv3l9f7BsBvqIFIFYHE2vBKeNs7LNM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=juhXe4wCFr8KPpHsCcpr6KIQsHIWT7iwWBJ7E6a6O+dw0Ip8QIfw9N6RF8FcoaCGo1SS8fyaRopgWgOXbbdA2lUxusbUv78qpj4VgUk5Vg1s3ri14jDstI1vvSrJs0eYtM0ejejQ8fXW4B3s3Uxprz4B9BCPhMXkLqkf4khbRQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=ZWtJhZIN; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="ZWtJhZIN"
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62CJ2Wgk3125602;
	Thu, 12 Mar 2026 19:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=G3
	iaT3Eafti6eVtRtw8DbO8svC7/86bEBfyKm87Jrqc=; b=ZWtJhZINgEPgfbS2eC
	tFYoaIquWfqvz9v1Z+vZyHtHjS9Wk/N44KyvkBCpIIkzgCIryovM6Ur2IEsCwkbX
	UjYqu8uxwVnwjLMVK8bqUkyexIeS0Cw52RBL6aqwTkb7xAXg4lUHYwQKjci9uUVr
	NYvbCCaXNrLNIL66c8Z96o6vz0kOv9Xh1idruBOIjyrt3bYytotnPvRewsFkPWLx
	8B0+9GCic1Yy78salYnLDo+pji92DMgDJIjGrXx6QDC5OYAFnL28E0l6How46840
	qDPDpBIVafEl3gXYeQaUfTPdEO8AbEbIB8p6hBu9ldUV+ZcBHJljusxM09OXNRIl
	NISg==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4cv1wv1bfa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 19:25:47 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 1DE2B27641;
	Thu, 12 Mar 2026 19:25:46 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 12 Mar 2026 07:25:34 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 12 Mar 2026 07:25:34 -1200
Received: from BN1PR07CU003.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 07:25:34 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wzrL6+9PpjIuo1J5Jh5cyAJdpVnn7M7AhtKeB5oL0ZjuXJoL5ys2Z8LptU4Qlh7gHKsgjoWlcWEzSOSzkTrhB4mpcaGg97Np9Q9VuP8LLYU+/hoeTXkwmmoXueEP/X/nbCw5P1hPuHUzjL7rUK5NJ3/LpHReWsPhD7AFMViM9UciBcYTjCLV6R7+jpxqE6CcfT56lcWPqs5rRAayDN/Z4fNke0rpWmD+3TJIxTt30qVoa/Z5WzPQoVgLK9RjzmSIGP9AlPhMOrPEGMH0hfOKQeMbkoonoFXwhPKjvpX6oZtonahOgxd/f7IEOmMsCmS0nTXlktKtpIw/QZU1cGG12w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3iaT3Eafti6eVtRtw8DbO8svC7/86bEBfyKm87Jrqc=;
 b=j1DECeQkpHvVC2Nib/zmZeXdtohQccPAizbvFTt+fKkdvWJszhM+jqR/sQSlCVeHIgqFeYKNYUi0viQ3+wX+FFSpMOvRSIe97uaXbHZUemrWE5DsWOfnEJN3GOhU0L2IEW553L92vXIsaKHPpuize7IBYzB87D6Ri/Fp2Wrdfdz0yhzsSEWxbbJMW3219Uz+gGMDVhF/oDQFoUGzYawu1p54CDLa/XU42/wqWwnBpU/Naav+pL7wSqIv8wnDt+u/L7KnkuPdcPe1MqTN8aZRaYq98q5p60pvT065CBde0E9xYw3r3oGOIq0M0zglxOLmG0VU3DQ2q5lVol8H4zjehA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 CY5PR84MB3100.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:930:27::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.16; Thu, 12 Mar 2026 19:25:31 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::a85b:624:a74f:e211]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::a85b:624:a74f:e211%6]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 19:25:31 +0000
From: "Hawkins, Nick" <nick.hawkins@hpe.com>
To: Shawn Lin <shawn.lin@linux.dev>,
        "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>,
        "jszhang@kernel.org" <jszhang@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] mmc: sdhci-of-dwcmshc: Add HPE GSC eMMC support
Thread-Topic: [PATCH v3 2/2] mmc: sdhci-of-dwcmshc: Add HPE GSC eMMC support
Thread-Index: AQHcsYKKHx5nl1txH0qoWMtEbiYJWLWqkIQAgACzP7A=
Date: Thu, 12 Mar 2026 19:25:31 +0000
Message-ID: <DM4PR84MB19274AAA6B344A850A1824958844A@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20260311181112.1700667-1-nick.hawkins@hpe.com>
 <20260311181112.1700667-3-nick.hawkins@hpe.com>
 <c4271da0-87c9-d7c2-db46-e7ed7f5e4fdf@linux.dev>
In-Reply-To: <c4271da0-87c9-d7c2-db46-e7ed7f5e4fdf@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|CY5PR84MB3100:EE_
x-ms-office365-filtering-correlation-id: 2a125ffb-8b69-42b6-486b-08de806d2044
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|18002099003|22082099003|56012099003|7053199007|38070700021;
x-microsoft-antispam-message-info: dR+3vmAsi7ZYeZdPQzTHkMrepOrjd92eYvOf5AgYIOGU4sxWA/IOioRwAOBRy5buUNHjpr/6v1xK/qQ7p7/pieHmhQKphhg+Sj6KIvun8Y7a344LNE1pAqvw3Gl89paflWn92nYIKgKfM/YOB5q3U/PhB5Mtf6i+2xsdcg0S31CfkXY1Y2f11YKC6VCVGP9AF0Lgm4Bg97QagUqRk40g+Lgtng5NSowBABAickpflmAv7tjSYB927DNNOSHVvun+YGp+Q5suA79SJ0UCP7IqjuSiwO4Jb/6WLlO0iyJZf6ZSn3kaeTRbE64bIfgRxeMNLDw3w5ODIOtRGVJB5hBsAymKLdWCXoZSkGw2qeSu9KFE+AbxnZToEryUC7Fym0GbhBzfu3uZCm0NuejaKzBIikeGjeylrQ79soScR1g1uZ2n2ysjUbzJ1kvqMExy3xaCvbOjiI2/F25S0JXZsdyxT6ohENf+j0HR0E5q/9tXygG1BN7L03uUFxC3w1GoV7cdmmAVfj0Bs0AmbfM6DoqhJCjlYosW6tueP16r2o6jFMT2JcrGONmT+VyHmrKxXO63slvLt4FYPZYfovQjcUC76vJX0wW0eGGYNjaNQnxh1yJMIGSzugGPYz2bOlAiOM/YJhJpv0PnWMplC3fSLBcuQneQmv4tcbtVv+CQi+L1B1O2cpaFgaG3O5EcyLD1iNSH2RC6/Zz5Q//T/RjP9G1oPS+HfYm+E6HrATpc6Xs2IqlQKaWHfyL3/YNR/ESVx5KlYkcevPbiXlDpC51BoM7jf3zfOmInrRXScYDH2FlU+Ow=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aIlNwEkgZNNkBkbPu60xUQ3jO7EBqrHgkyLDicJdWqFTPR3NPYmO1GCsm9Rb?=
 =?us-ascii?Q?W8W5ZVavQsA2bEvr8dwjV0jFLyykd/W3V+Ll479PQfx/z2Llvq3uAy2OEElN?=
 =?us-ascii?Q?VBi6IDfzrllcU0hULlQSScJ7lcJHU8/CeG/cvLI4SgnebA1c1kWedsD+H8SH?=
 =?us-ascii?Q?XsDEv64BoeMr9zE/163ekR64G5mxKMzpmPzxsvtX5vzJp65GvKdsUTTJicC4?=
 =?us-ascii?Q?3uusIf82hoLwmVtlDRg9T0pcmqSkJ2xPmVj2vomOYOkdUc1a9iVtPQcmVFz7?=
 =?us-ascii?Q?pj9+2jdtkhFnpMh+QC/G0HWh/DMj4bKHBkCzZemgC0Oy/Zdu/GsqKudSf5TW?=
 =?us-ascii?Q?VDRdp3Nxi1u6pKUokerSk7Zo3XtqBZgnJ4pwMpCEyIewMbQR7jA9xm7rBqdb?=
 =?us-ascii?Q?1eZ0ptTdPrOXnjthYOeu83tY0ARjeN0r/TCAMQXKlwN+Xa3HEVkQI7FaZaU0?=
 =?us-ascii?Q?p1LZJMW5VFK2WaCMTuqVibB4ur187nsi8hIZDENBWQlrGvhqHtshQuXOutZ4?=
 =?us-ascii?Q?P9tX4zl3XXBCmAhMDGbhSLpOtgRNu37a7XCAHHzHL65NP4czAIbQ+tVwt2LA?=
 =?us-ascii?Q?K2FIZrOCde8yC2lE4NDsCqi1aANPK4qoLZZPVVSXTtHopL2Avu/BiFa+n24Z?=
 =?us-ascii?Q?aZ61xinmSZU4ohRmKvqQExQ1MbvpHz33CQbyLOPvlelHmadl6S0eHe96I9uk?=
 =?us-ascii?Q?JSS0rFh5XcjpBbGeZb0SxZ4EaGT7fl7eD/QbscoIJSSO7lI+GH5H7R12j5Bh?=
 =?us-ascii?Q?YgTS0wIIrt6Uah8/DtTE70BM1f9idhwq6JmaXUX1vmt+/kGf4l5D/e7BYDD0?=
 =?us-ascii?Q?8wRsDlLxtczMHpBFsuDV0KH6MWJkn7g7UCgRcc3F7UH34+ME/KnAQUDH5SwT?=
 =?us-ascii?Q?+idOahqamqwGrE584ZkUVRvr+JC2g6ROMeCjBM3pqjkx1s1adHZ+kyC/+Vzy?=
 =?us-ascii?Q?KggOS3cT3Tl/C81xuUl4NMU3QoWEhCsOywGfF03YtEqiicfe9ZoAtLVN/7s5?=
 =?us-ascii?Q?caJrtQbyO9XtIXJ2inY+YF7wXgrc0dYKWD3LqoZLv6Ik9geS+VT5GGb5+c0p?=
 =?us-ascii?Q?46WKNi7POcrCI2WhdTTYkg1AlhYWYMLrwJhTqgjJc4Cp9rc7NtPWr63i/wj4?=
 =?us-ascii?Q?B2HX/0ZLyQ6pIYcKImVZllOFMnSldYuN9OTGhxKL2lIAWcYPPzbopeb61Qcz?=
 =?us-ascii?Q?WFJ6pBXNy6d5T+PXRLTPe37GdvZy6D8y6PQsEDU4cf88eC2X2LkgkGNgbBwy?=
 =?us-ascii?Q?iSEH4vocYkDipJhQRXELLqqgs52cgcivU1YYxWTQCbS73yTLot3bcTVzkMkO?=
 =?us-ascii?Q?WfRb09e5DwuVqt/gvw5Ekf74fV8amM9DRuqpsLGYHW211E+qKOZhUwtoV98w?=
 =?us-ascii?Q?8UlXJpj8Ci0NHa5ONGjiC1nCQKgDiR6IJJxakKhM4dYHfbYbOOjoxFRT57es?=
 =?us-ascii?Q?B0vu1YBvGqgKKswRrbY4lrmaDTwaOEWFhkl7dkmPT4XQ79+mqQdYZ0Y35kRS?=
 =?us-ascii?Q?u/MPjZyyh7mttR8ooyE1lKOyG5gWVyQoGQn8KnGLgFhtn+ZMqTofa0sbWWcg?=
 =?us-ascii?Q?fbLdPGrOjp/xmMToJj7OaYn3glponjn36CbLHjbtOunS9kEj4bWsu25W5IBp?=
 =?us-ascii?Q?tbGwQ0HvhdAm2h2yhOn4ztMp3mQWCWOG0UEuio4jMOCQqvrjXClIWUIk+7jp?=
 =?us-ascii?Q?HiUNKK7jDg1Iz8KjaluXcuF8c8NOWmxwNknzTHBlwbdPKSjT9F/xuL408y5o?=
 =?us-ascii?Q?zzHG7f080A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LB7y+oGVUgAkOrPeXiDFecxbfmA+0hkzsQWsAtGIIrD9xTPgEtEtjxD0FGbwQomV4WZ2YidVI+5u3bCFeN+AQ71OpQpkYt7HI7JZp+3Y9mCinhfOS3iFpzFYIc0LMD+hjDzC6W/s01WcSrWKHt7ONWqnG8/o7aEfv+TzWckqNbrVJkF4Dx9GqGmL2BBCNyvo/dSh/CZBFkAZahY2Xcbm9Rocsa9ByJwK1n/nIoDm2LIrLsUC9xqOXhJmADR32qCeoBFJMzie3F+RT3OjU3WIqudXGKGHR+IFSnHmvHPKN9luLiFw971Sf14astirlGKVoaR0ypexmgwI7PG4Nftptg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a125ffb-8b69-42b6-486b-08de806d2044
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 19:25:31.4254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OHUQv9Tsfe385geRpGRhvJt2Z1jKXIZMNeJbTFFlFZME3DSNwnnTLbK8X4Ji/BbYQtgqIaOQzx1FJF11bcOpwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR84MB3100
X-OriginatorOrg: hpe.com
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDE1NyBTYWx0ZWRfX/jmjzQQs4enl
 tnnHbfMdbtpawWEmeh+uVmzJ9Cgf9Js291nsr3wPGwWnl/k0u/LVFDwiuLyPKh7pPH4ugp2hCcS
 6ptxn2FNOIFlffTGkOSzr/yuxs2GmXLuLTUZG/y+r6uKWdLWXpy6sakYIavlHRhWzKT7NKqJw00
 RqFKBsNFDmUsCNuBpu5nX+0Ub6W4WZofYj9l6c4FKhX3N2jNRa8BaJeFjVK/13K9MVV+eAXb7zR
 tFwqKjWRuIHrERl38uEiw/EpHUAXoxqy9Y69e6fCW8fyYgqjICrkboNLQu+kR+fsCb5DTZaUc1K
 lnG9cpMkSSKzCeglwLpQyAlepiqfDF3sODJkOTIcyP6ilvyMjcLywpnDoDvs8gZWdA040xQN1rM
 nyfHNeYEm8FTjZh+IC8FQs/zD5RRNKf1D7dvvy1Bpu3OsJwB8Es2S9gQWp0NzIWDJHIINjCSlkP
 IfilLfmCXBLA+aS7k+Q==
X-Proofpoint-ORIG-GUID: 5RZljOViYR6hgIGzyDRwpTz_o9FU5CwB
X-Authority-Analysis: v=2.4 cv=a4s9NESF c=1 sm=1 tr=0 ts=69b3133b cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=RtSn8ETxjE2H05FtM2s8:22
 a=MvuuwTCpAAAA:8 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
 a=s8YR1HE3AAAA:8 a=WLT0F-LzL-FLioC06D0A:9 a=CjuIK1q_8ugA:10
 a=cvBusfyB2V15izCimMoJ:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-GUID: 5RZljOViYR6hgIGzyDRwpTz_o9FU5CwB
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120157

Hi Shawn, thank you for your input.

See below:

> -----Original Message-----
> From: Shawn Lin <shawn.lin@linux.dev>=20
> Sent: Thursday, March 12, 2026 3:25 AM
> To: Hawkins, Nick <nick.hawkins@hpe.com>; ulf.hansson@linaro.org; adrian.=
hunter@intel.com; jszhang@kernel.org
> Cc: shawn.lin@linux.dev; robh@kernel.org; krzk+dt@kernel.org; conor+dt@ke=
rnel.org; shawn.lin@rock-chips.com; linux-mmc@vger.kernel.org; devicetree@v=
ger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3 2/2] mmc: sdhci-of-dwcmshc: Add HPE GSC eMMC suppo=
rt


> > +static int dwcmshc_hpe_gsc_init(struct device *dev, struct sdhci_host =
*host,
> > +				struct dwcmshc_priv *dwc_priv)
> > +{
> > +	struct regmap *soc_ctrl;
> > +	int ret;
> > +
> > +	/* Disable cmd conflict check and configure auto-tuning */
> > +	dwcmshc_hpe_vendor_specific(host);
> > +
> > +	/* Look up the GXP sysreg syscon for MSHCCS access */
> > +	soc_ctrl =3D syscon_regmap_lookup_by_phandle(dev->of_node, "hpe,gxp-s=
ysreg");
> > +	if (IS_ERR(soc_ctrl)) {
> > +		dev_err(dev, "failed to get hpe,gxp-sysreg syscon\n");
> > +		return PTR_ERR(soc_ctrl);
> > +	}
> > +
> > +	/* Set SCGSyncDis (bit 18) to disable sync on HS200 RX delay lines */
> > +	ret =3D regmap_update_bits(soc_ctrl, HPE_GSC_MSHCCS_OFFSET,
> > +				HPE_GSC_MSHCCS_SCGSYNCDIS,
> > +				HPE_GSC_MSHCCS_SCGSYNCDIS);
> > +	if (ret) {
> > +		dev_err(dev, "failed to set SCGSyncDis in MSHCCS\n");
> > +		return ret;
> > +	}
> > +
> > +	sdhci_enable_v4_mode(host);

> Sorry, I overlooked this part when in v2. But we enable it in
> dwcmshc_probe() based on the capabilities, isn't it? Unless your
> hardware didn't set SDHCI_CAN_64BIT_V4 but actually it does support
> it? Then it perhaps should be a quirk, although we in general would like
> to avoid more quirks... It depends on Adrian.

> Btw, unlated to your patch, but th1520 did it the same way... Hmm

The GSC's IP is configured with a 32-bit DMA AXI
interface, so SDHCI_CAN_64BIT_V4 (caps bit 27) is not set by the
hardware. However, the controller still requires Host V4 mode
(HOST_CTRL2_R bit 12) to be enabled. Since dwcmshc_probe()
only calls sdhci_enable_v4_mode() when SDHCI_CAN_64BIT_V4
is set, the explicit call in dwcmshc_hpe_gsc_init() is necessary.

Thanks,

-Nick H


=20
