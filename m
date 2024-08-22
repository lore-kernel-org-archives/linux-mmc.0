Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6891DDF4
	for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2024 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334221; cv=fail; b=lyZVUfsZaYm7dXI8PlrOVDKJECSjcJgpq8zAZwCSfc0KJqREsPRmeDJ76sYYbPk4XQwKYvf92UwUy3eOt29jSxUrTFwlCJQHQ3u/aOyM0D9p3UxOnHLI4SYbPeB3qypiZ8KKcSokNLWM7knVb3FoAp63ITxn2sDt5YFg8ga7woU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334221; c=relaxed/simple;
	bh=Jnjrnc1hENrI4nFEFKRolTYeRUZs982BD/gNcTkMZwE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p2aVJBwXkArRAtKSlo9TnpHfctWjDQXJExgMlr2x4LAe4FKcmEVCDLgXuyOcwtiFfEJO9Td+dF8P/HmwMz044LNHG2hrF0DQWmjXQAUIWkORAWnemO1MiD9KPti+wLy+3m7TgkcYd/bZAinMVysuTovrWPSPb3KLu0+5TsDqLA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bguIUPTK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ZWvGYGM/; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bguIUPTK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZWvGYGM/"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724334219; x=1755870219;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jnjrnc1hENrI4nFEFKRolTYeRUZs982BD/gNcTkMZwE=;
  b=bguIUPTK2jGo4sXf2WiCBq9bZpWGoQoTOKl/IOf4mSsXGf7xvHBp/s7+
   PcGDPcuM+h8nxmSnr2GYkiLpRn4uYMQJk0nLsk8sMfYSV2PYRbjr4IBGJ
   tGXsGSN/92MhJM/rC/hFbT5mOOCgKxCsftbphEaGXEx2bbTbd3zbbERTq
   VlnjHQ28v1JsJcLXZyCNyPOwMBnq13HQlmxpt9pYL038SgvQ1INfJrnSU
   IzHYZt0umyuC0EfVFDWFA30+SJCfZAJiP2fBBI/ZG3N5xpXnuSrx4k8g8
   soxGCJwnr2XAr3pvxE1ScdIWK9aVVTI5DpMy1I3Mi1EkH8av1BB9J7IdD
   A==;
X-CSE-ConnectionGUID: ggO29oJJQzqv+ozlH5uKXQ==
X-CSE-MsgGUID: tVyTAWP2S+2vYOzbTfQ3ug==
X-IronPort-AV: E=Sophos;i="6.10,167,1719849600"; 
   d="scan'208";a="24923477"
Received: from mail-westusazlp17012038.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([40.93.1.38])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2024 21:43:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQRcn2lTIeQ2fMEsZhocE+gT1yX1af7RzIQb6+3raoxEWkt55bvK42sorzC5+FjsYhLTxCKMeK5bYSf9o9DZBbbNCAYqKpjNSURIB0cCIlLcjHyYGb0WKFjSVubT5w1KWI3KhGK/PhlhuOJWqsDhhnVvnHvuEfaRUg/j0LsxLZRPdBHmcC8WgvRpyGEoO58Lq0c6qvtT+FAUUEQn+rFZLvCs6jWOrqb+L0XNy+cS22ZfPWrWQE1M6V0NeBL6oc2y400Mt1FKkKwGVQLndbqv5a4cBY4u10yxsJBoOabMSZ+iyfmuIQ4/ce8PYDm+ciI6nT7JzxDXFfeXXt2O+EO4Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jnjrnc1hENrI4nFEFKRolTYeRUZs982BD/gNcTkMZwE=;
 b=pJCE8hKvqkGNfnPKCuClz/0cDhpP/Ig9FTB89Bwk939E7Yj5p9CN0d7oIt/cuMw6y3RBBDo4IZXQOh5t0T8hXHGngMj3ARzEIp/9cYYpFD0UitULNZIMigWB5LVTd8BKPNuNJWdLuhyz7DmDEgVRLeuNIY5prvKrxt5dsA091VoO9plhrFIJJ2PCWR5toum25jrVHezlENpALYvuSJG+qQStxwyr8flRWAvO4EXcUo7yHkmpP7iYPfXGBZKo/+tWBErhLmOEtp64Z2HI0rD4801VS5x6j3DfXCzTNLCeCDNyxloQOLaDqMh23KwsAUXmcjs4k4hFc8MeFsYszu1cXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jnjrnc1hENrI4nFEFKRolTYeRUZs982BD/gNcTkMZwE=;
 b=ZWvGYGM/OUY/Gqz+bfHQaDGp9WzA65Jubyr3az1JZG48vvvzyHP9rYSyn1ykW16mWsRpTmHKXPSI4Ec3N7CZHqBdkC9gkw5fgNAImgugU/xgj+NQNnaRPL7U+eFTM/xRvF0sgwIPuBNPQLRuc1pJflVXoyHw7EEaFcoKjQaTLZQ=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CO6PR04MB8332.namprd04.prod.outlook.com (2603:10b6:303:137::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.20; Thu, 22 Aug 2024 13:43:31 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 13:43:31 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ricky WU
	<ricky_wu@realtek.com>
Subject: RE: [PATCH v3 04/10] mmc: core: Add open-ended Ext memory addressing
Thread-Topic: [PATCH v3 04/10] mmc: core: Add open-ended Ext memory addressing
Thread-Index: AQHa7hwB6RhBkIEGlUuUXm7iT7S0ILIzP/IAgAAAOoCAABNeoA==
Date: Thu, 22 Aug 2024 13:43:30 +0000
Message-ID:
 <DM6PR04MB6575C1547AAF752CA2803814FC8F2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240814072934.2559911-1-avri.altman@wdc.com>
 <20240814072934.2559911-5-avri.altman@wdc.com>
 <CAPDyKFpNCZi6biSaCLUFKaB-Xc4Kg4Z1NjzjW5vcY4TeLKDD4g@mail.gmail.com>
 <CAPDyKFqQ-zS9vQP63+DxL1J4UA31FAW1dA7HfHv+BKS5SZjXyQ@mail.gmail.com>
In-Reply-To:
 <CAPDyKFqQ-zS9vQP63+DxL1J4UA31FAW1dA7HfHv+BKS5SZjXyQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CO6PR04MB8332:EE_
x-ms-office365-filtering-correlation-id: 0c81fc30-dd5e-4512-c817-08dcc2b068e9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RFVseTliWDIyNC9BL2gyWEg4NGtyRGtiYktLMWUrNExxbFBXYjRKOElxbnRT?=
 =?utf-8?B?bm5lclNZWGJKSm5mUG9GM0ZZSGpjMjZuNmlPN3gwSEJqVXhtUVNSQnZqL29k?=
 =?utf-8?B?T25TQjhsSUl5Mkdna2E1UTJkaytWZGpKNUJoWC9GY2N1bTNDSW1WcGJhWUZw?=
 =?utf-8?B?ckYveUExQ0wySUtDREU1N2J3aWhCaGxOZWZwNzJkN2U4Zlc0Sm42SFJMQ3E4?=
 =?utf-8?B?YTJGbDMzMG10SmpqN2tQSEFXRHNkWm5ReVl1ZTgwZ01DL1ZxcEVKM2F5cGdk?=
 =?utf-8?B?M3pYWXdpdVJabTdTSENGWkVrSUt1VUFjQnV4SFpFbHBPUmorUUw2VytrRkls?=
 =?utf-8?B?VUd3TW5IcnM4Vkc3eHVVYVdRT3pKR0o3TWhUbjVDTEpYVUFTazYwcCtkVEVq?=
 =?utf-8?B?UUZsdlkwNXdseHVRc3MxNHBLS05kTElISS9KTnhWR2hweG52T3dxaFU1TFhx?=
 =?utf-8?B?Uk1uZVc3d2ZTMDF2VW93aXJwdGxxdmhOdGVpSEJCZGJ1V3AyNDgrZG9aZkFY?=
 =?utf-8?B?NEIwbGpMRDdwbXhGYUdUY0VCaXhIaWkxR2s3SjVEVTMzSk9uNC83VHpHUEFF?=
 =?utf-8?B?aDB1LzJnTjJndU0wOHNQSUU5NlV0TEEvS2tvMFNrcEZwL25rS2hpUm43ZXhX?=
 =?utf-8?B?WCtndWpUb2tyMlJXV2dqTENDYll0dUhyaWkzNWdaTnpQT1NkTEQwaTV5WCtt?=
 =?utf-8?B?bXY0WjV2aTdsOS84OU9aR2ZrdlowdjdsbEhnempHQmVxZjkybGV6S2k5Yyt6?=
 =?utf-8?B?ajE0SHI3VEhVcjhDaDk0dWVYZjNqWUx5WFd2Ny9lT0gyZStRM3lVTTZjMGQx?=
 =?utf-8?B?RGxSU3k1eGhZTHlzYXd1MUZxS2RzbC9nUk1teTFNWXJZN3c4RGZZS3BRNFVM?=
 =?utf-8?B?cWUyaTBVMDRiUk5VMVlXUmYrYWlNYjVXK25iTHUyYlJubURob3VTaGhlZTNo?=
 =?utf-8?B?RkpGVlBYQ1RPS29ZbFcvMGw5dFozdTduNC93SmJSRWR4M2xkSk5nZUhZa0Vr?=
 =?utf-8?B?eGgvcFREVEZJdFREZ3I1UmlodTk3dStGR3JjUmtBamR2QlFyNVNFUDhBVFE0?=
 =?utf-8?B?ZkhLRlRSVHJqVk1EYUlPNDhBVFdRN2gzMTJ3bXFkNit2STI2SHVJR1B4MDZk?=
 =?utf-8?B?NW8yQkRZQjBvQ2lQdzlJWUd4c3hWeFBkMEJBZlVHSkprTlFja2MvK3QySWpk?=
 =?utf-8?B?VURQR2FnSlMzcjY0ZXB2b3d5M0ZkaWs1Ly9VdVZjd1JIY1N6L1RnRnZiY2o1?=
 =?utf-8?B?ZDFGVkMxNUIyL1dkRkZLbllibDRTNTZRR1hsb1V1VEZIRGk2Z2NGMkxtbnhl?=
 =?utf-8?B?M3RPS25zZE5FbkNKL2FzVEJYWjU4eUxHN1RGL3BZSGRBdTVrRGphbHhYS3h1?=
 =?utf-8?B?c1owdis1OGgweWpadmMwUllTTTl4ZXBYSFYva21DVmR5QkF3NmdGdWJwcVlG?=
 =?utf-8?B?U2Z6ZHNqUW5FejRLeDVmclkwaXhrdldndkZKaFhDK0NGU0hwUGJxaExpQU9L?=
 =?utf-8?B?R0pnYkUxdUlhUi9nbm1CU3lrdHdxOWVoTy91VDFXYzY5cXpxYWIrSGVhd2wy?=
 =?utf-8?B?L2d1S2dEcG5xK2VyTWJkczJXU1Jhc1EzNUVvQ1ZtanZWRnNYbDFmZnVVTmM2?=
 =?utf-8?B?eG5ycmJ1Q3VOVjNiVGN0aTZTZDZ6aExTWlpCSHovdkRYOTAzVzJxTEZBMDNo?=
 =?utf-8?B?TkE5TVU5NzdUbGFPeitqcFJUbHdDR00yL2hzc2JhZ0gvVktTb2FGeEgzRTky?=
 =?utf-8?B?ei9oU2hWeis5MVhUcmpGMlk2cS9FVjVKajdnSzI4VDVxdTJGSkZZMTN0OTdr?=
 =?utf-8?B?ZW1oNVRrS3laRFdNWnFLTjJjS1NGNXJVVE5kaWZkRGtSdlZra1F4bWlubjI3?=
 =?utf-8?B?eCtEZHIxeCs0bEE5ZldwQ1prWVh0bzl0TXFhMmlpdWxiNHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NHltcW96RHR2cCtaRGdqSlpQMGJNZ3Jlb3BBK0FUdGJDZDIvSnVLcEQvcEhF?=
 =?utf-8?B?d2hVWUUxSnN1em8xK2pmN0Y0T0diMzdBbVlaVk9TSDhyUU9wTXhmUk8xZ09Y?=
 =?utf-8?B?aXZIN0VtNFJsdU9MSTZmbW9EdlA5VVlnYThBTlZOODF4c0U0a2daaXZubXhE?=
 =?utf-8?B?QTRDYndQWDEzaGVxWEh6SkR5VWVaYnpVcUgyVFFDUEFyUDVMN09JKzhjTUhJ?=
 =?utf-8?B?TVRXck9EcnFPVnVPYzh3bUVOTXpIQ2FPYWxBb2xrVnJNV0xOV1Jnd25uNzZY?=
 =?utf-8?B?QmtleWVITlBLUXhVU2FzVlNienlKKzU1RmVoOE4zc1FHdlRsaytubWEzenVJ?=
 =?utf-8?B?OUd5eWtGa2xqNlVrR3R6dVVLZGtDNUt4bk5BWVg0YmNteDlub1JrckVFaWxH?=
 =?utf-8?B?dE9welV3VXpodjJEcW9JNTR5b24rczlZSHd3elNEbW5tQnVxQ2Z6QWFqaEpr?=
 =?utf-8?B?UFRsWFRHS2hPRVk2V0NHUC9ZUzhXNHJJekQrR2xZbTVWbTNjMEo1MjJLeVJV?=
 =?utf-8?B?TU1ZVHlQQU92bTZHYzNiWmcwVjZYMG4ycWdQSHRHOHk3ajdLbXM3ZEZsQmth?=
 =?utf-8?B?eG9DbjJCWXFCNWFralFjY2FJV0R5UlA2Mmc4S3orU1NZU21jUGcySVhTZW0x?=
 =?utf-8?B?d0JwREcvTW5Jb0JrS2JIeHMrZ3o5NUQ2V0JGZG1pQUVGei9uVGt6eHpyVGxB?=
 =?utf-8?B?M1RxWCtqRVFVTnZkd0oyQ1lSK3QyNk9aSDJ4U1VzVEVrcnBvS291eTJoVTh5?=
 =?utf-8?B?Uy9mMzJrbHRMUUlaVGwzaldvMkNtYjhNR1dtMTF6dTdWeUhlQkV6OHRFSFRq?=
 =?utf-8?B?TDFjd3hYTlpJaXBRQzRDdWxPcW91MXpqUjQ0L1puRjR5cFM1L1dVamVOUGxK?=
 =?utf-8?B?YzJRakFwMG9DTmxhNFF5WjQ0T3RRcWh6alZWazRtSkUyVk01L3VhUldhcDEw?=
 =?utf-8?B?TkRlNGd5YkY4NDF3bTdVelcwVWJLL2dqWjF4TEVKbWozMVJzQ2ZRODNpZWds?=
 =?utf-8?B?dUZnS1IyQTNQcVZCTjdmSmRGYUtqdG1IZm1IMFM5bDAzemVwQm9iYXpLVUlu?=
 =?utf-8?B?aEQrQnNhRU5zTUJXRkNWVzIwS1FrTTVibmcra2hPOEZkZ3MrR2FjYkRPQ29v?=
 =?utf-8?B?YXRVbGVka1BYNDV6cVluUWRjTjJJWlM2WWMwaExUQnIwU3pJeTg0czkxSlB3?=
 =?utf-8?B?bitLNGNNSWhmMlNMYnpEMDBMZjBvR3V3N2JBZGVSczFOajFqMTM3bG41OGtO?=
 =?utf-8?B?QXN2WFlkdktpeVJMMXJqaGpHN0IzWncxMkdXMzQ5aGJNRjFqMFYySEVmUzV0?=
 =?utf-8?B?UzJXblAzT0s4ak4wdGUvc3I1YlNCRmhESFAzdDc1MURGMzJYNmN3STFOWTVB?=
 =?utf-8?B?a2grT3F1Q2xuVmMvc0lCdWZjcjFGTnhjRDdrTnVRMjdrL1pQbGZWc3UwTkRO?=
 =?utf-8?B?b3NGd3dlWlpCMGNBaXJUSk9jSXFPSHZhVjE2YnpPOHNpYXV2d1hqN0hwZXJQ?=
 =?utf-8?B?M0svaytlNzE0TlZKeG91U3ZlY2xCaHg4ZCtOSzh1cFZpUFMweGhqV1hxT2pv?=
 =?utf-8?B?akl3QWV5Q2daOExvZ09JWHRTMDgwY2FYN0VMcWJ3bUdTaVFDQzNoOVJ4S1Jz?=
 =?utf-8?B?ZjBLTmZKYzZGdjVvYnJlTXFzTG80M2grSWtZSlNCc3pkUE9JQ21kaStHMDQz?=
 =?utf-8?B?cjE2dEpicS9CVVFqVjdES3BJMHBNT01rWmd5TXMrUXYwL0lHY0pqQnZUSXJV?=
 =?utf-8?B?NVMyUStyVWVoWE4xWnBCWmpTSnROWU9xZC85eDlwK2J2dE92NC93ZEdSVm9q?=
 =?utf-8?B?VERlMEtqNVFGL256cFh3RkNyVWhoNTd1K1QxdFRUR0VYOE5lUnpKcm9QejYz?=
 =?utf-8?B?QzVnQnVOVUlFYjV0VzlhYkw4RHlrdkM4UnI2SlF6L0JkS21FcnVRRzRxWUxG?=
 =?utf-8?B?TVpBVDhkcGZlSlpWS1ZlR2c2Znl0NkpSQTlqK20yN3g1V3hnNTN3Smo3MzhL?=
 =?utf-8?B?TkxhWkdENmtXQ1hjalZyaW43bHBvemhucFo2ZUFTTGFJMnhkbU9sVlhZdXhj?=
 =?utf-8?B?bmVNNXJKbHV2YXdFS1Y0YytNK3ord0c4WTg1WmczYk52M0NTVnRDckV3MHg1?=
 =?utf-8?B?cCtkTGNXREczTWhVYmIyczFLS01RMldTY01rdTdwckdrN2FSbVpEb0NROUNX?=
 =?utf-8?Q?Hxoa3WdA9mKp7USGN6LXnH/aO8/7hlJwASzf5aNbotIm?=
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
	WLFQK284J9vZsW1BEoFIWI+PuaYpgUa9Az7cVLLkdoRN02rEq6pm6b6bEEUmRis7uS+3b/f2CwTgrssXmvVMv+p/mGCTeae6HqvglOKbIcAvTqh+7q+Qm44svaYf66vxNbWBoyBwkWWYxZaxNHLU1ovrNze9P8n0QxFO//7P1GbeWNH3VJcTNcw9mlhvfFEIFea9VXpZpWDCyf4BJuH1+2lcReahW1JcVfT6sjI5OLUCfiiDNc69d+JpmEmRA3N/7no7whUkt7w4FrcIe+ybwmdNt8fxqCDChkcKquKS/8EDtpYwENi1/LfkFYu42B1Mv/eCFMM9AxhZARRlG+lTMJt0Hx3Tdhq1n/ZdzqZnIoHtcoNq3VgV0yqiZG54O0FiI8Nbt0Y8lEFN+GERjnjrGKjcBg6IGMpmyTXkgfLo/Hl60/oMoLrwG5gAHNFfvHLz7Nm4vdSWoNGnh6wx03qJ4dsuVr2pJxt/7ud/RjqEziFU7lapPCPFouYW1MkIDKh5JIX/1KsBgygOmenU9dJOgjQ3YH+4X6RbLzJWsx4QWz6KKUzeVD8sg1GBFnh/lyC09rZnnwjuLAcU/HNRwff4m9HVbA4OjIwC3yA/1LHn+Kum/LIrLk6pGKQ/5ql3VlMi
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c81fc30-dd5e-4512-c817-08dcc2b068e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 13:43:30.9679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W8zCl0unYuOpzoYPicO3SUS/P53ec8JOrv2Xe6VKm6b4toYtwV+k0IrOQ4dZGLnygdEDQxWXROn8FL7kSprITw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8332

PiBPbiBUaHUsIDIyIEF1ZyAyMDI0IGF0IDE0OjIzLCBVbGYgSGFuc3NvbiA8dWxmLmhhbnNzb25A
bGluYXJvLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBPbiBXZWQsIDE0IEF1ZyAyMDI0IGF0IDA5OjMx
LCBBdnJpIEFsdG1hbiA8YXZyaS5hbHRtYW5Ad2RjLmNvbT4NCj4gd3JvdGU6DQo+ID4gPg0KPiA+
ID4gRm9yIG9wZW4tZW5kZWQgcmVhZC93cml0ZSAtIGp1c3Qgc2VuZCBDTUQyMiBiZWZvcmUgaXNz
dWluZyB0aGUNCj4gY29tbWFuZC4NCj4gPiA+IFdoaWxlIGF0IGl0LCBtYWtlIHN1cmUgdGhhdCB0
aGUgcncgY29tbWFuZCBhcmcgaXMgcHJvcGVybHkgY2FzdGluZw0KPiA+ID4gdGhlIGxvd2VyIDMy
IGJpdHMsIGFzIGl0IGNhbiBiZSBsYXJnZXIgbm93Lg0KPiA+ID4NCj4gPiA+IFRlc3RlZC1ieTog
Umlja3kgV1UgPHJpY2t5X3d1QHJlYWx0ZWsuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQXZy
aSBBbHRtYW4gPGF2cmkuYWx0bWFuQHdkYy5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJz
L21tYy9jb3JlL2Jsb2NrLmMgfCA2ICsrKysrLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9tbWMvY29yZS9ibG9jay5jIGIvZHJpdmVycy9tbWMvY29yZS9ibG9jay5jDQo+ID4gPiBp
bmRleCAyYzk5NjMyNDhmY2IuLjExMjlmNGUxYTI2OCAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZl
cnMvbW1jL2NvcmUvYmxvY2suYw0KPiA+ID4gKysrIGIvZHJpdmVycy9tbWMvY29yZS9ibG9jay5j
DQo+ID4gPiBAQCAtMTgwLDYgKzE4MCw3IEBAIHN0YXRpYyB2b2lkIG1tY19ibGtfcndfcnFfcHJl
cChzdHJ1Y3QNCj4gPiA+IG1tY19xdWV1ZV9yZXEgKm1xcnEsICBzdGF0aWMgdm9pZCBtbWNfYmxr
X2hzcV9yZXFfZG9uZShzdHJ1Y3QNCj4gPiA+IG1tY19yZXF1ZXN0ICptcnEpOyAgc3RhdGljIGlu
dCBtbWNfc3BpX2Vycl9jaGVjayhzdHJ1Y3QgbW1jX2NhcmQNCj4gPiA+ICpjYXJkKTsgIHN0YXRp
YyBpbnQgbW1jX2Jsa19idXN5X2NiKHZvaWQgKmNiX2RhdGEsIGJvb2wgKmJ1c3kpOw0KPiA+ID4g
K3N0YXRpYyBpbnQgbW1jX2Jsa193YWl0X2Zvcl9pZGxlKHN0cnVjdCBtbWNfcXVldWUgKm1xLCBz
dHJ1Y3QNCj4gPiA+ICttbWNfaG9zdCAqaG9zdCk7DQo+ID4gPg0KPiA+ID4gIHN0YXRpYyBzdHJ1
Y3QgbW1jX2Jsa19kYXRhICptbWNfYmxrX2dldChzdHJ1Y3QgZ2VuZGlzayAqZGlzaykgIHsgQEAN
Cj4gPiA+IC0xNjY0LDcgKzE2NjUsNyBAQCBzdGF0aWMgdm9pZCBtbWNfYmxrX3J3X3JxX3ByZXAo
c3RydWN0DQo+ID4gPiBtbWNfcXVldWVfcmVxICptcXJxLA0KPiA+ID4NCj4gPiA+ICAgICAgICAg
YnJxLT5tcnEuY21kID0gJmJycS0+Y21kOw0KPiA+ID4NCj4gPiA+IC0gICAgICAgYnJxLT5jbWQu
YXJnID0gYmxrX3JxX3BvcyhyZXEpOw0KPiA+ID4gKyAgICAgICBicnEtPmNtZC5hcmcgPSBibGtf
cnFfcG9zKHJlcSkgJiAweEZGRkZGRkZGOw0KPiA+ID4gICAgICAgICBpZiAoIW1tY19jYXJkX2Js
b2NrYWRkcihjYXJkKSkNCj4gPiA+ICAgICAgICAgICAgICAgICBicnEtPmNtZC5hcmcgPDw9IDk7
DQo+ID4gPiAgICAgICAgIGJycS0+Y21kLmZsYWdzID0gTU1DX1JTUF9TUElfUjEgfCBNTUNfUlNQ
X1IxIHwNCj4gTU1DX0NNRF9BRFRDOw0KPiA+ID4gQEAgLTE3MTIsNiArMTcxMyw5IEBAIHN0YXRp
YyB2b2lkIG1tY19ibGtfcndfcnFfcHJlcChzdHJ1Y3QNCj4gbW1jX3F1ZXVlX3JlcSAqbXFycSwN
Cj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIChkb19kYXRhX3RhZyA/ICgxIDw8IDI5KSA6
IDApOw0KPiA+ID4gICAgICAgICAgICAgICAgIGJycS0+c2JjLmZsYWdzID0gTU1DX1JTUF9SMSB8
IE1NQ19DTURfQUM7DQo+ID4gPiAgICAgICAgICAgICAgICAgYnJxLT5tcnEuc2JjID0gJmJycS0+
c2JjOw0KPiA+ID4gKyAgICAgICB9IGVsc2UgaWYgKG1tY19jYXJkX2lzX3NkdWMoY2FyZC0+aG9z
dCkpIHsNCj4gPiA+ICsgICAgICAgICAgICAgICBtbWNfYmxrX3dhaXRfZm9yX2lkbGUobXEsIGNh
cmQtPmhvc3QpOw0KPiA+DQo+ID4gSWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseSwgdGhpcyBtZWFu
cyB0aGUgYXN5bmMgcmVxdWVzdCBtZWNoYW5pc20gd2lsbA0KPiA+IG5vdCBiZSBkaXNhYmxlZCBm
b3IgU0RVQyBjYXJkcy4NCj4gDQo+IC9zL3dpbGwgbm90L3dpbGwNCk9yaWdpbmFsbHksIEkgd2Fz
bid0IHdhaXRpbmcgZm9yIGlkbGUuDQpJIGFkZGVkIGl0IGJlY2F1c2Ugb24gc29tZSBwbGF0Zm9y
bXMsIGZvciBhIHNlcmllcyBvZiByZXF1ZXN0cywNCkF0IHNvbWUgcG9pbnQgdGhlIGhvc3QgY29u
dHJvbGxlciB3YXMgc2VuZGluZyB0aGUgcmVhZCBvciB3cml0ZSBiZWZvcmUgY21kMjIuDQpJIHRo
b3VnaHQgdGhpcyBhcHByb2FjaCB3b3VsZCBhc3N1cmUgdGhlIHByb3BlciBzZXF1ZW5jZSwgd2l0
aG91dCBxdWlya2luZyBhIGJ1bmNoIG9mIGh3Lg0KSSBhbSBvcGVuIGZvciBvdGhlciBzdWdnZXN0
aW9ucyB0aG91Z2guDQoNClRoYW5rcywNCkF2cmkNCj4gDQo+ID4NCj4gPiBNYXliZSB0aGlzIGlz
IHRoZSBlYXNpZXN0IHdheSB0byBtb3ZlIHRoaXMgZm9yd2FyZCBmb3Igbm93LCBidXQgaXQncw0K
PiA+IHN0aWxsIGEgYml0IHNhZCBpZiB3ZSBjYW4ndCBrZWVwIHVzaW5nIGl0IGZvciBTRFVDIGNh
cmRzIHRvby4NCj4gPg0KPiA+IE5vIG1hdHRlciB3aGF0LCBjYW4geW91IHBsZWFzZSBlbGFib3Jh
dGUgd2h5IHlvdSBoYXZlIGNob3NlbiB0aGlzDQo+IGFwcHJvYWNoPw0KPiA+DQo+ID4gPiArICAg
ICAgICAgICAgICAgbW1jX3NlbmRfZXh0X2FkZHIoY2FyZC0+aG9zdCwgYmxrX3JxX3BvcyhyZXEp
KTsNCj4gPiA+ICAgICAgICAgfQ0KPiA+ID4gIH0NCj4gPiA+DQo+ID4gPiAtLQ0KPiA+ID4gMi4y
NS4xDQo+ID4gPg0KPiA+DQo+ID4gS2luZCByZWdhcmRzDQo+ID4gVWZmZQ0K
