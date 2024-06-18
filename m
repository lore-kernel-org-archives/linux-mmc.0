Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B222D81E
	for <linux-mmc@vger.kernel.org>; Tue, 18 Jun 2024 06:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718691041; cv=fail; b=GjA+kMXODpMY/HWsINFCtMQHNPAD3WuQ8dhNfXT4PLFWSeAD8/w+JkJ5rQFNoHZFIuQJbqGaJNXyu/0/fRL+WzlAlg2hENVjg1YuowTX4rdA3rB34etgEwMf593FnMDE/TZPtb7rlqO5BjUMXFHemheU45Bp2Elq5Yfy6XAbHU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718691041; c=relaxed/simple;
	bh=HmnstD1yJ/UqItA/gL2eneVkOII9XBO717oFoKDtgnA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f4MCs0Zln4MB4asARBENeYX5qeqG7er62F8t69wW56M+6y+4fP5XABLGt70v8CshH7Es4n6iLYsCPtghxZYncsjeCmlmPAeIPxpzySWiodwFsaSTCF6Sw8N+I3abCJUdF4f3t1nVT5NUF8Ou8Bm9Ls4Kv0ypiQQFSzNrhXnR4Dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gaa1MMLY; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ZWZHaysm; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gaa1MMLY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZWZHaysm"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718691039; x=1750227039;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HmnstD1yJ/UqItA/gL2eneVkOII9XBO717oFoKDtgnA=;
  b=gaa1MMLYm119EK2tbJ1LHsMvIJVrSSkQ2GqnRFmzufylTt4qas6tinHZ
   WhVxAbdmT+GuRDuDPxfwl9QVYn/jLpDWG3ODCEjVNkC/mRXdQ/uFmmxZ5
   r+h0qYk2hkkiRuLhnwl6wU4vm7a4QGzDQ1gXEVHd0YR2wuOPldwvBajCB
   9d6ZysglfJQY0hpoxOneEABjod/FKrTTr8+oNYak+fOcGzcGnMs45Q5oe
   T9zQ3Rv8itVsMXcQM8OXNX+KSNAmvTVXHcdJnc3Ia46I/aK3/TOQBO95A
   SfeyiQgxQg3AY4JHWjMSW6+MRANfKDqf4wIFFFHYW/N5PN176/ZPDwPB5
   Q==;
X-CSE-ConnectionGUID: 2vzPmCKTQbarisS1kSRWZg==
X-CSE-MsgGUID: XoFzsKuHQRy7Wshq+CPf3w==
X-IronPort-AV: E=Sophos;i="6.08,246,1712592000"; 
   d="scan'208";a="18618401"
Received: from mail-bn8nam11lp2176.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.176])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2024 14:10:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKYlwRChGIB6j03H8m/b0wb+KQSKT8QroHXcTlmjdNQx/kTwIxJb5iNpANOrOEYtwqgVYwvyXhNmWZEpN8Ick7A/JKOHzpxf+C2rsucUfMDspO0J9UUEb53OdQdeI7gnZseOAVnD31gCBrFhyuVgUJt8N+oM0w6VDooMsQgQ+DsWXlZydqIm0q2SE6BzJZQ/u0+lxeiACrC+FNhoP1umu+LnCS78fiTuzMCH9eL0TpqsqA4JHFQ3itMt0L3KDJOtAhsmiH+WxcgCWoP37kDFd2IRnVlmvUudCBjCNAJ7CjeEnGLzYM8wmwIW3z4bVlEx9f62ScN0p92GR7GcyTVdlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmnstD1yJ/UqItA/gL2eneVkOII9XBO717oFoKDtgnA=;
 b=MDocIZDJPHII0ibBUP8VsaqXYGbMAQmn7FtoS6I19cFNaaYEXtJWaS8GBqaRvOwwPrg0hYxB3EXtNF58vfYdsggVLI3H5AeYMDa1c6jX1Vzvj2Y0L6ggSTYoQCabOSJtw/H4s1mXOp/B4MlHCbMDKz7OxQ9XcU11ADwDuK53JbjkzNywzgyFOY1RL2muqOAaPNPm1f+1TiXdSkGrUvU8clMUpRjDrl9qe5MEWi5SF3T+oyE1MiTCdcr6rx0oyvDJMNJ2XhVmT16eUIGqb79ozymwVnRtiE00mhlqe7vERyasR9FJB4UgmW9Xeix5P9o1pQrktdIQ27bJOpJk3Qwpyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmnstD1yJ/UqItA/gL2eneVkOII9XBO717oFoKDtgnA=;
 b=ZWZHaysmnHNDFBRRgwmCWeRLJST60b90lywNfv/gce71ujuYoBsxSjHz+xSWgbpyQk2FOyPoBbnAJpiUQpK+RuqtFGoprdvNbhhv2TTbKlC0vDLJepO9lA//9cy/dq3jqzZuo93Cm9XF6eev4g1wuFFpBjwRe+vZomXmB0hJfak=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH0PR04MB8263.namprd04.prod.outlook.com (2603:10b6:510:104::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 06:10:36 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%6]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 06:10:36 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Zhan Liu <liuzhanjobs@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH v1] mmc-utils: FFU Status check for device without FW
 install support
Thread-Topic: [PATCH v1] mmc-utils: FFU Status check for device without FW
 install support
Thread-Index: AQHawUG2n+peSbUYwUuUi15hDIbG6rHNB1sg
Date: Tue, 18 Jun 2024 06:10:36 +0000
Message-ID:
 <DM6PR04MB6575ACD3487FDAFB2B14389AFCCE2@DM6PR04MB6575.namprd04.prod.outlook.com>
References:
 <CABqN7BxTNMFz5hxPePYV0sM02XwRsv+g7Siw-ZKZ7_X++H0JtQ@mail.gmail.com>
 <CABqN7ByLAm7rB=wq07AoL2A1o2-Tz=rqmP-Ctf1SS8uQYeor7Q@mail.gmail.com>
In-Reply-To:
 <CABqN7ByLAm7rB=wq07AoL2A1o2-Tz=rqmP-Ctf1SS8uQYeor7Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH0PR04MB8263:EE_
x-ms-office365-filtering-correlation-id: b6d1507a-7e9b-4528-dd9a-08dc8f5d5ebf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?N01YbUg1cGkzdVpNMzhLR010SlAzNTZpa1Fod0pWR0I0OFordGIvK3Zlam1K?=
 =?utf-8?B?Vm1adEh1L1ZNZW5mUGdsV3BFdjFEaE9IVmQrb3NOYS9RL3BPamc1MEFncVNC?=
 =?utf-8?B?eTN4S3FDN0xvSENyTTJzdjBuelZaSVk5bWlyQXYvWTdDL1VQVXFsVEZVWTV4?=
 =?utf-8?B?SmtwT29mSEdwMVIxRUtQYTZ4dXFzMmdKaTRScGU3NHRmRHEwaGNWTENOd1A3?=
 =?utf-8?B?MnlQVUFLa0ZUNHRtSi91U2FNdjIyWTFmS3dxQi9jellld3Z4d3QvYTROZ3dV?=
 =?utf-8?B?YTIwVndlOXBuUVprU3h3V0RaYlQrQTI1M29jWWFpcGZiSXJzam1uMlcxMVZn?=
 =?utf-8?B?bmdlckh3Y25uVlBCaE5kOXptcHViSkphRjNQdFNja1lQWnJLcER0UWR2M0tB?=
 =?utf-8?B?Vm5CVTltUklMNDl6UkxrUXE5T2ltajZPQlFobXNrOHQ5OWdxeGR1WmRvY2hz?=
 =?utf-8?B?L3hrT3FwZVdaZFErRFYvY0xoaUVlTVp1aTFOVGsrUHBQT2Y3OFc2cjJzU25w?=
 =?utf-8?B?b1NEbUZ5VTBpSFB4ZGVlbTRwOGVseGtZUklmL0h5THVnNXo0K21FVGRVTEY3?=
 =?utf-8?B?RWZtaTRhZ2RzRGp5MlR5Nml5SVRtT3g3ZnBZRUhJWjQxRzRwc0tOeTJMdkMw?=
 =?utf-8?B?TkxVMkRrK0JGZWkra1ZWMVlEU3luOUVDSFZjakRIMDQ2N3Z0bHhOUjAvUVM0?=
 =?utf-8?B?SUZ1L3JBVzREbDd5NmJka1B0RTVNWThvSEg4d2xsSi9ZSk9mSDZCalByTldu?=
 =?utf-8?B?MmNmOHk1cXAvUzk4Nnh6Ni9HZjkvSkdDb3lNMHp4UU9tekloUG0rNG9oNlIr?=
 =?utf-8?B?L1ZyQTJYaXhycXJ2Y3FybkwvNXZEcmtjdkZ2aUlUbUMyZzZhQXdZTVhmUlJG?=
 =?utf-8?B?NWdUTmQ3K3RUSDByV3gwLy84eVhZMlJxZFZDVTJzNWhBUlpWVGR5dXV1SWhx?=
 =?utf-8?B?L2Z4TGdXWFR1SmdUV1Y5dE1tTDdnSzVjcDJOOEFkU2dHQmw2T0lqRDZLNEk3?=
 =?utf-8?B?NiswV2pWUkNEdU1BN3Rnb2dIZXNDT3FSbDNtVll2THg2emVTTStobmI2ZWlZ?=
 =?utf-8?B?TlpPblBMM25zN1VTdTdIY2dLcVQ2UWszZHRRdTU3MGxJbEw2SFBQaGpCK05h?=
 =?utf-8?B?YVJ4d3pXd3RxT3F6ZDB2L01tKzdqS0ZqaC84aHY2TTNUUCttbTNIN3JDWG90?=
 =?utf-8?B?cUVOM3pBVURITGUrOW1zeVIwT1h3YmpsS3R2VFp6aDVXdVhjejlSWEt3dlk5?=
 =?utf-8?B?RVBteUg0SkF4MWN0dXo1cVJoOG1jcGtORHE1Mk9WQnZSTFE1R25DUEg0ekh6?=
 =?utf-8?B?YktHUnZFbjFZWnk3TWtISzJNa2Z1ZEdQcGJBUGM1NGVSUFVra1YxdU84dysv?=
 =?utf-8?B?L1Z3bDlTdjNrZUNOR292M3hKaUovKzczYTFMR0lYUmIxZ3ljTEF6U1k2Qy9q?=
 =?utf-8?B?THRkQnZGa29vQzNaZFdLeWluVkhoWE50ZnlqUEZuNE5VdHRnd0dBMnJ5aWQv?=
 =?utf-8?B?dUI0NjMrdGh1clJGUm4vOTVoMi94a0NxT2pDMng5OEwrOEhKZVNiUGViNlVi?=
 =?utf-8?B?ZFNXNXFldmFaTUliQTRwT1VJa20xdlE5RVUxRUxSQldRRklQNTRSbmJvd2hu?=
 =?utf-8?B?c1pQUHRacFdZcmtINjhIcGlOcTI4RWFoaXg0em42aUpDSCtOTjdGZC9rekxV?=
 =?utf-8?B?L3Z0aXROUHh6dkYrakhzUHVLQUF2VTdGRmd4cGozVzJKOFhwY2VJQ3dyWFhJ?=
 =?utf-8?B?dHVCM1YrRGw1RjRaSW0rVzJFT3VQSzcwU1VwWVhZSDFQY1VGV1NPNEphRy9t?=
 =?utf-8?Q?U7jGDublB9uELSwDNs19nJdSg0tBmQtX0bsxg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WCtPalpZUGpqY1pDckl5OTBrZ1lVeEhoelU5ckdqTjBuRHY0QW5EcldabEQ1?=
 =?utf-8?B?ZW9ZWGVIbjY2SlNMaEp6QTJvSHlya0ZaWndSODR4MzFBbDVlZWYweWhMc3dC?=
 =?utf-8?B?a2J2MmtNWTI5MTJUYkNtZkdkNFkwbWJSdFdkemJabnNpcDdISWdoSXErcDhF?=
 =?utf-8?B?cEMvOFpPbW9vRVlPdFFxN3RuNWVETWxwUEcrTTdUZFpPdVZpdTU1aW5xdHF1?=
 =?utf-8?B?aUNFby82Vk9SVDI1ZXJqeXZyUktyL1FwOHd6ekhxR2tROXFPQWR2akR0YXZV?=
 =?utf-8?B?bXJYdUhhdXhKdGZpOVVCR0dlMFFXMUtCSlBKemVtZGtzaDhkdzArcElFcW9t?=
 =?utf-8?B?WUdsSU5YQUU3eEk5ek5Uc2pNeGlyTmlwaE1pL3IyaVRCYTg1ZUc0UUl0VExj?=
 =?utf-8?B?OUNJU1ovUTZ5aUVYeHozMkthSVJYa203TXdpUkpVUitZQllwdXJGSTZyM0l2?=
 =?utf-8?B?eitnalQ5TXpCVWFXS3VLamlETkN5Vkp4c2dMTjNweUJaNVdYN2ljMkJYRlk2?=
 =?utf-8?B?bU1UUDVUM08yL3gvVFVUcW8rZlAveW9ZazBjTi9iSEx0REhUMnVXOUovMXdY?=
 =?utf-8?B?MFlpaXdBQ2NybGJ1d2lVNFFxelJoRmR4WmhCaVBLZzltUU5kQmROWmxxYWlv?=
 =?utf-8?B?Y2o2cTNVMGs3aW4yaFdmTGhRWnVBUk5pUFp1M3NGVzkzQWNQMHNLWk5wdXNq?=
 =?utf-8?B?cWdBY1hLTEpGREhwUUZ0eEJYd0RDeXNOWWY3Wk1aelllRE54ZFA2d3FQcGVM?=
 =?utf-8?B?RUlWakFjSjlyUU1WcGMxUkgvTzFoUHIxZ3dwVHJTMVdkM3N4MTNoenI0T01S?=
 =?utf-8?B?RVpnRStramE0aGhIV0ZwcS9aRGV0T3RyTVVxSy9VeWFHbzZNZXNrT3hxdG9k?=
 =?utf-8?B?UlZyVUs2RUNWakF4OU5CcW5QYUdFYU41dXA1WitVVlVxYklsY1FEcWZMTHN1?=
 =?utf-8?B?YWdKZ0w2aVJoOWJIRkNCS0hEaWUwR2ZOaVBNSnRkaGhjODRnbFBGSEFxc3Rq?=
 =?utf-8?B?aXNBeDdhZDFKM2t5R0xlNnlvYktTRHRsTlE1NGQzVVd3dWZEbmFFb2Vtendj?=
 =?utf-8?B?SHROTFRDUnpsSFNrS2pLekVxWmRvZXltR0tiTGVGd1ZnTCs0Zm91czB4a1lj?=
 =?utf-8?B?Zk95S2MxMWNRVDZCUlhoNjlZV2dWekw3OStpcDU5UlNBajBqZ3FiNENEcEla?=
 =?utf-8?B?d2U2OVczSk9adW9YOGU3TTFGcjZGajkycjdld2RkNStBT25EUjFnY011YjBL?=
 =?utf-8?B?TnZYeldyWHJqOVBwNkt2blVCMFhhazA3MllCd3Q1RDI0SDdJeFNCQW5Jck1E?=
 =?utf-8?B?bmlVenhBeTloWU1YNTQyNUZtZ2o4N1dFaHdQOG5Mekk2NnFoL1NwTjQxczc3?=
 =?utf-8?B?WlV4cXFyWTlKZlhEL1YrdXFtSmNJMlJzNjNjbnhJbEdFSitRZXB2Z0lpOFNP?=
 =?utf-8?B?VDZKWjhIOWhzbVBEL0E5aGxSVG4zcE5HcThyL0NQRTFYVUJwa3QwOS9QWmtS?=
 =?utf-8?B?cTkyeit0OWpxMzRzU0gwbVp3Zk02U1BDMVE1Z2xDUGc4M01hYU1KVjExSFY4?=
 =?utf-8?B?dUpZMTR0Mk52bTNpTGRjQ2tJRlBNYkpkL0VYd0gwVDdoN3Q0NzZHaUJnY0Jj?=
 =?utf-8?B?Y2dwTkV5ZkxzOTYyNndCWXRCY0MvVVJFMmV0UGtqQmhOcU1XWmE5MmQ2cG9p?=
 =?utf-8?B?clJrWnRzRlRxVnZJWmhIRWptRnpDYi9vdEcxMjVUNmNqZ2pTRlRXU0EvaFVz?=
 =?utf-8?B?a0NBZ0srTWJIOEVCRnRFajB1Vi9lbDF6SnFqWHNBNDZIOEZBM2hzbHdjUTFw?=
 =?utf-8?B?TGxTSkhVVHpyTkdpc1hOR0QrUWVvWk45WHJzNUNBQVJzNU1GNEV0RW8ydzNF?=
 =?utf-8?B?WVdldmtEWGtRQVo1QzBrd1hNMU1zUktWRHZvejA3ZkpKRUNnZGNldktkbkMx?=
 =?utf-8?B?aDNkQXZxMDc4Smw4T1l6NnZET01IQkhpbWZ4T3krSkhHQnZTVWJCa2JLeFpU?=
 =?utf-8?B?MGR2NllpSHRBVlNLcE9hcFpJSFNuQ3RQUmd4anhUKzFpZFplZmdjSmFWY0R4?=
 =?utf-8?B?aWtsZUNEaEdMVDlxQTVqS25RTXZ1bFlwQ0VVNzdsTlUycmFOVDNiQVB6bVBt?=
 =?utf-8?Q?qdzyqYdUxiejyKFOk6fmvtamn?=
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
	wZxYD4zwl2SqWxX3ePxpCHz0A2cP+EJ7YxLHCfqZPHgltY8d7PDGgiMa2KCbwVwupIs2gp6XJKAc9qNpvMb9H1C/0+TiavUqnxq3I5FzUanwfwxPET/zTaZSSixMjqRfVhFFFi6tWfxXSV0K/4Fz0ollngXIaWtz9hxGAQGoNznXFP5OlpJTx+whUgEk9lIbwmmMyJ+/dzzUAYhEvqigBWhfwjuDvl3RDiLZr75bhSnIWxpEAQeTkDB2nWUqxXf9H0cz+7Tv+3VzZRA5E1P8XBwmX+cLfwJPgkHeF3vtFAspRxblXwRYJC7O/2voCXcL21evxV3CUPWXmDMCR77q6PKTj+wUCDA6ObvlKzyEo7g7CFqLYUIcJ+06ZexyHKDilT4Ur7uk9PLL+Vbc59T5HUaDPlQ+EnXX85COPXQxUk6JdwIY44Ea4l3JAoyTM6/22QfnMjDmGrVlb/9ODWne06/81DzrJVsd3wRWZs77/rrUX1lw4Iq6mz2BFPXbcEP1lgwkEXjLNhaadUfd9jaBsj3RDPt8xE8XDtwcIGxWWFDNVjpGx4AURiPKkCBhD2TdO7UzVk0gWtvKq8pS2sx/+4enKOXYm7A2XN1SCT13UR+UadZmT+miFu+blJRGkgpa
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d1507a-7e9b-4528-dd9a-08dc8f5d5ebf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 06:10:36.3631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J5D+9TbQ5wc8RpPTOptlZjdsMaUteO62V0VPRINZbI14yfpF/IQrJGtAb7B6ICEtfOt0fA0WMlUHUgXba0Yekg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8263

SGksDQo+IEkgaGF2ZSBzdWJtaXR0ZWQgdGhpcyBwYXRjaCBvbiBBcHIgMTksIDIwMjQuIEhvd2V2
ZXIsIEkgaGF2ZSBuZXZlciBnb3QgYW55IHJlcGx5DQo+IGV0Yy4gYW5kIG5vdyBJIGRpZCBub3Qg
c2VlIHRoaXMgaW4gdGhlIHBhdGNoIGxpc3QgKGV2ZW4gaWYgSSBzZWFyY2ggYW55IHBhdGNoIHVu
ZGVyDQo+IG15IG5hbWUpLiB0aGVyZWZvcmUsIGl0IG5vdCByZWplY3RlZCwgYXBwcm92ZWQgZXRj
LiBJdCBqdXN0IGRpc2FwcGVhcmVkLiBDYW4geW91DQo+IHBsZWFzZSBsZXQgbWUgd2hhdCBpcyBn
b2luZyBvbj8NCkl0IGRpZG4ndCBkaXNhcHBlYXIuIEl0IHdhc24ndCBhY2NlcHRlZCB5ZXQuDQpU
aGUgcmV2aWV3IHByb2Nlc3MgaXMgc29ydCBvZiBhIGRpYWxvZy4gU2luY2UgeW91IGlnbm9yZWQg
bXkgY29tbWVudHMgZm9yIHlvdXIgZmlyc3QgdmVyc2lvbiwNCkkgZm91bmQgbGl0dGxlIHBvaW50
IHRvIGtlZXAgY29tbWVudGluZyB5b3VyIGNoYW5nZXMuDQpJZiB5b3Ugd2FudCB0byByZS1pbml0
aWF0ZSB0aGUgcmV2aWV3LCBwbGVhc2UgcmVzZW5kIC0gdXNlIHRoaXMgdGltZSB0aGUgY29ycmVj
dCB2ZXJzaW9uIG9mIHlvdXIgcHJvcG9zYWwgd2hpY2ggaXMgMi4NClRyeSB0byBmb2xsb3cgdGhl
IGtlcm5lbCBzdWJtaXNzaW9uIGd1aWRlbGluZXMgKHRoZXJlIGFyZSBzb21lIGZvciBhIHJlLXN1
Ym1pc3Npb24gdG9vKS4NCg0KVGhhbmtzLA0KQXZyaSANCg==
