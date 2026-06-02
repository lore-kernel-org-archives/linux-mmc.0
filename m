Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4E022D7B9;
	Tue,  2 Jun 2026 10:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780394466; cv=fail; b=gnOiRdM84nawNqdP2g4zCDPtWTl0+TPU8F/DNSR3mfg0qbZhGv8fswOqi3LMhwx8basKd/dRCV1Mht5yNEUyYK16fhD0g4K9jJXRIvAT6EZ3S1CHOM34JhhRFM3swzW7CnvF0O6ClVnxftF29Yj+FwKBNa5bCAaopS0BMMD4U5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780394466; c=relaxed/simple;
	bh=zFDi6poNhdXijDXEjbAqCOqF2xpNHLMx81QWlOq0smw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g3MjM69ZfF+pQ+D8y/9102SCNsQIReex2v2KxDzC2gdN/Y2rhRrLKXhPvy68ZsI7dMMgtGLKXQ0yuyjqzTLL0ZWzek/ITN8gA4fDUT4bgq9L5rr0ZsYgChuzPhR+GWxuAFYE0UYiBH/wFzZEi0RiIdGTu43AIuF4Fa+RJU9y9Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=QA8bJ4zf; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="QA8bJ4zf"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1780394464; x=1811930464;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=zFDi6poNhdXijDXEjbAqCOqF2xpNHLMx81QWlOq0smw=;
  b=QA8bJ4zfJwfaRWrS8K+/BoO1Kp0htsotLcTokOlEuTQY3rk3riZKHKQF
   DgcERMoLC+O3bu7clllEfZlhytra4FjAvk4pirWShxhIF60UHM1sr9pQN
   V526RIS5M/XLNl/NnG3iK79v0ClN3pcX8FvEzs3+vwK+Wl5rpl4YMfXjL
   c8ogJnEUXrWhTy2Rfukn6O1GuJFIk+Cmc7TZka4XUiKxhyRYxQHNhqiHU
   UNu/m65+NfzF6n9+9omwuvZpg0ZV5i0yGADd20oVOFAlJdReIbtDLyak5
   q8RXexpE1dNbUmAtZPhMGzpy30tAlXS+W0XGKqe2qaZ40p8ucc8kNOHT5
   w==;
X-CSE-ConnectionGUID: LXxfIQ9wTcyF1ynL0iOImg==
X-CSE-MsgGUID: i4Ew74fGQzuQMztiL1r0iQ==
X-IronPort-RemoteIP: 52.101.61.8
X-IronPort-MID: 23863720
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-centralusazon11010008.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.8])
  by ob1.hc6817-7.iphmx.com with ESMTP; 02 Jun 2026 02:59:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jh43D3oCRMVHqixjW/D/EkMgBx48zbRF66j4Hy1CwL9qr7FVBm7yX2MbI/8z5t1auahmQ5XnUn/zWJdwrzK/M0NuPDbDOOymumRu1Jf8oVQYcGcK/msg/B2fLr28PGRUcr5s7i+E4MCSivehJgRKJgKBV12hjvyCoXiOSGOn7Dq46LqZVLeh4F5jW3lgv4Jy/UrpCj7rO6gb8iSrx/izpxMTCMd/RCcmmNWEwsh08/jIqR2pY3b7zd1C/CqXthvMdDD31SMt7pTxkEiGZocQkioLlJbDNArB0AAxzT4h1KMfkPHgDhoP3PPWJv4ftvYz3q0wmLbdzJAAQIkuzLetQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFDi6poNhdXijDXEjbAqCOqF2xpNHLMx81QWlOq0smw=;
 b=q5kfOix9otKlrfoF3GBNCNQ9E8UinMzhfK+L7eVAHnxFWFBp/bltnBX2+tUoT3/EtvG4riLOWmyqDX/g23KR8tzO+vYUaV8Cvnl1GHHIVm1oxJMjKFo//Dx32jNhHdZ0pDlKLkpwEAnNvoAskMrOzftS/Kye+SKvIL++4YvT5OJeg8kv2h6i73i6M+qxSMAIYV1o8c0Ve/V5WCGPWV2qvKA4RAyb0r31Zb7YgF8w6c1iAEh8eBG+2tJzAhggr+LhE309RUyBjmME83c8Cl26aIXWK/u5mMbSx5r28PjBQarGBTmWY3wWBJj7DFa6PLcqCwttUvOi5D+p4K6JG/8Omw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 LV0PR16MB7012.namprd16.prod.outlook.com (2603:10b6:408:346::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 2 Jun
 2026 09:59:54 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%6]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 09:59:54 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Chanwoo Lee <cw9316.lee@samsung.com>, Ulf Hansson <ulfh@kernel.org>, Pedro
 Demarchi Gomes <pedrodemargomes@gmail.com>, Sarthak Garg
	<quic_sartgarg@quicinc.com>, Linus Walleij <linusw@kernel.org>, "open
	list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..."
	<linux-mmc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: core: sd: Remove unused buffer allocation in
 sd_enable_cache()
Thread-Topic: [PATCH] mmc: core: sd: Remove unused buffer allocation in
 sd_enable_cache()
Thread-Index: AQHc8nP9QJqpQmeC9kyeJwYDwMAFlrYrCAZg
Date: Tue, 2 Jun 2026 09:59:54 +0000
Message-ID:
 <DS1PR16MB675382B4B93A929E5D277CC0E5122@DS1PR16MB6753.namprd16.prod.outlook.com>
References:
 <CGME20260602094117epcas1p398765b6fb4a8ee28836cfde89744430f@epcas1p3.samsung.com>
 <20260602094058.358267-1-cw9316.lee@samsung.com>
In-Reply-To: <20260602094058.358267-1-cw9316.lee@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|LV0PR16MB7012:EE_
x-ms-office365-filtering-correlation-id: f53eb1a6-908a-4ab9-dde8-08dec08db1ec
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|56012099006|4143699003|22082099003|18002099003|11063799006|55112099003|38070700021;
x-microsoft-antispam-message-info:
 ono3NrTyGVME9HP+4trc9YHi0lAl4FR3GnQ3hHtlqcKwBZ5l58HlLfQ+7anZ5mGsi6mTJtXPHO2aOXumnJDXqqaqI2IU7zqbFLMYZqK7VP6BE8Bqo331tWilMnC+tNgt8F+6S4tbVyNyuDlw7WEZrzQIiSfq5AnPbbrHc/Eq2w6hnnf+ChQ+o1CBkTeozMyvWtgpZiz2JZvlxRs0hlPZtmyAUJDAvyTuCXobiIiBV26ExoTM9Qs3cZ207aGP4KcwE8VRxkHwuboft0fKtjJGPQFpO6fA316HgKj34KvvrIA42Q2D3FsTKyBDsZu9MKuDLNnNP58V8f/PxECtXSvzr9yz1ioYk95nfjEuwrd/xuFU7EBUvD3DcV9MwjGSatxLSPM21+McPIK9X2Qm2twVLwr8Sbp9htSpE7AmYKfZx58NjHp/rBrhmCGCF5xRSHOB+xXk95n3pjsvqHxVyPEIAOylbTEE+kzyZR0kCWOGpJ0a9ArfyjJ7sOtlWmzUJ0s39kqyZIz/fWFymdt50gD/RDfVZ37rXV+S4bZaSFzApBS6azTDm9oEk3HaMiV/w3lNzbE9tXQTNIsoYYCQf+7hkaAVZkL05I7ZQksuJRqmkzyBJLHSBVOaVZsVPAFtDsP5rii8oonAUjVOicDlbtLksDQgK+9qNSkbtTycNBPQfpYfWLeT9+1XIpkeTTElV/OzJEpl+bGgbq2QE/uQOrf+aLrzdlx+RBwY9PsLKBnTyxV4y2Z1vcAgL+hMe7Cf/5eC
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099006)(4143699003)(22082099003)(18002099003)(11063799006)(55112099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkw1ekxuMWdUenBCQXdNMWdVc1BmZjNmZ1QyeXY0cndYL29JTDBrOFJ3bkQz?=
 =?utf-8?B?QlNwUFJuK0E1ZjlUTjdjWDBZL0RHcW5yZkFYazNZSnBUaVNKZktiUVlzUWhV?=
 =?utf-8?B?S1BvcGlxdUFyQ3phd3o4YzhkQjZFcW83aUk5U3c0eC9tdzRFWEJaNjJKdGxG?=
 =?utf-8?B?Z2lnVm51ZHZoL3k3dFlFZDlFQkhwYVZ6b01TV0d6WXR0ZmRtOHF3eUQ4MFp1?=
 =?utf-8?B?YWJyTmxRMTdzZ0VPckJwQUgzSGxsM3d3czBwM0psWFdVbkpaSEZONmlTUDRw?=
 =?utf-8?B?N3hRN1RBRUgyWVVoaEtJWVRJYzR4aGtWdVR6WUcxS2liMHJVRitjUUFEQ0dl?=
 =?utf-8?B?THlUWjhJeVg0TlF2REErZjlPVEpYbGdVME5OVUNhdGI3ay9Jak0zQ2h0QzAy?=
 =?utf-8?B?QVBzc3B4dVcxWTZpQU9tQ1ZZUVhsV1NiTy8zTFpvaStGNkxwMEQvS1U0N29p?=
 =?utf-8?B?QzRVMUw3ajY3dVlaQTlZaWNxUmtZVXluaFQ3RlRPVVhoZjEvSFAveFl3SVdB?=
 =?utf-8?B?blVESVNnaXpPWDB5eGEzWmh1U1FYQnRyOGFoRGN2Q2JhY0c0NUhXU2VDTTJI?=
 =?utf-8?B?SWVKMVo3L2gyZUZSbkk4Wk9VV2FuZ3pNcUlxUEhlai9WR1dFd0RjbXRQRzNC?=
 =?utf-8?B?eVN2N0dpSmJIQStBR3pUZi8vVlYycUQxR2hlV21OOS9SbnlUaXJyZ0krdDU1?=
 =?utf-8?B?ME5URkV3WDlSUWVoTVR6TTNBMDQ4VlYxUklHdTVaZFJjY2NwUG8xc2NXVzJN?=
 =?utf-8?B?d01US0RsUVdQYVd2OU5INFgwQUlXUHBUZE5jVStndndFbGlzUHpxcUM3ZUM2?=
 =?utf-8?B?bUVPektybVpUa0pHc2lnZ1laeWs0UU8yd0hXaTdnMFBPbHZMbVNPZkRXWHZp?=
 =?utf-8?B?NThDb3VibHQ3SDYrdzg4MW5OMGphWEg1aFcxY3Q2allROU8vaWxYZ2tLZnJs?=
 =?utf-8?B?QVFsMEMxZ1BTd1JlUXNFOFlUN3dtN1JjYVJQdm9yRGhjVTFZaDM4WTFLSUxW?=
 =?utf-8?B?Z0IyVlFMTVRRWHE0d2pDd1VqR2F4d3g4VmhGSkRvay9zNW4yOG5lanJYUW9y?=
 =?utf-8?B?KzdLOVNSd0ovajUrOUZ6MllUWk1Fa3Jsbi9HOEJDbTQ4RXFFWnlKQlF6RDVX?=
 =?utf-8?B?UVlJOXJmV01xTTkxVDNMYW00aHh0RXhoSUpWTUV3Q2tZSElpUnc2QkYvZC9F?=
 =?utf-8?B?V3ZxNmJ3VXJKcWZLaFpYeFl5VWU4N01ra0VkWUFvYTB3VXZ6SHBtM2hWU1Ez?=
 =?utf-8?B?RlhnVnNqMDVpZGdmQlFxaGJhRzVvekVpZFYxcU5PZ3dPQ2lrN3BaYnV4TS9M?=
 =?utf-8?B?L0I2Znk4WWNQQjVaZkFDUFgzMHovbDBaWDNDSzZybVZyU2xLclNjQnBNa2hL?=
 =?utf-8?B?NnJYTlJsckdyMVNXTzI0Lzh1blFvSlBIM0paaG4xVGdOMDZBaHA4MlpXUHdZ?=
 =?utf-8?B?QllndllOVlJQWkdNTkpOQXZPdjQ4OGFpNW9hQ1JRVTZPZkRpV0V2bkQwS2lh?=
 =?utf-8?B?WDFVOURRNEEraC9xSmwvclUrSWJqZzFvTGhvclh6R1JUYXhXUTVNcmhUR2F1?=
 =?utf-8?B?L2Rlc2phdG43UHFqVWpIM2VMMXRyY2RNaVFQeXlyWlFRZVF6aVNZc21PaUlo?=
 =?utf-8?B?QjV5Y3NDaDdNb1VSbVRTM3E0OXZGRjJuQnhVMWhNanQ4cnRaY00wdWhBNTAz?=
 =?utf-8?B?ek1jTldxajdsWW96OHF4TkxBY3FzbkFianorZVFZVmdFVTM3YThieG5qSlFy?=
 =?utf-8?B?TTh5N01RVkxybHJpaFZYU3l3MmFoOUllUjFYZlpEekhMOWZWM1Q3SmVnTUNP?=
 =?utf-8?B?NitRcjl3MWtrcnhuSUVZQTYwWG91T2hUSmhoQXVSV3NpcklGb2tZNWpCMkJD?=
 =?utf-8?B?YVVSVTVUeWtBbUQzTDRaUlNpdXgxZlFNMURrQVgrRW5keEs2ejl6M2RodkEw?=
 =?utf-8?B?STl1Y0VUQXRPZzB6cHdsNUE2ZW90dkE2U3pUUFZ5c3dvVmNpWUJKcEc1U09S?=
 =?utf-8?B?Z0hTRE5LQzhEWVZGY1lnM3dGdll2T3dlTmQxVmVUVWNqaXNWTHlGdmU0TGlq?=
 =?utf-8?B?WTgrRU5EZjV3UkhlOGxndndmME8rUCt2TytiVkREcTRnQ2FZdkhobzZCbGh6?=
 =?utf-8?B?d1NoTzJuMkVnejcwOTFUM0FnVVF1ZFQ4a0FyaTc2dFZyeS9GYVNyL3JVUDVp?=
 =?utf-8?B?b0FMek5QWGVlU0ovdEVvbi8rZzZwdTRuMmVVcVVkZ0JVcklVekJwUElIU1Bt?=
 =?utf-8?B?T1VpUlJZVzdTeDVKUHJwcnVmSytFOFJZckNMa0c1Wk5HbDlBdG96cHlNZnAw?=
 =?utf-8?B?TXZnUHRHb2ZaM01xdHlOVnpOalVmcWRzbkdVUFNhOG50R0VBQmlUdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	haY/+g+nRNSd+ZEiyntSIsZ97GzsJxOef4yPG7krMJ/2jGzxD6zIqfp6m0th9tzpoBnXcKT8l8pXvk2OiOtxqsYBJnMkwJV/ZmW8O77E4mfFfR4QAnBuKTlFnL5NEQw+WqZMATcbl9t4mQNRyQdGmPGAhAMlTEam/pppt7h57dLxj7FgN4/PNBeCQ1phY0ZDbJU0GH64Ec+wh3mmpLkIoFMB1ffHrxGr1Zh2zH3LJj4jR/AGQjjEEWlxnxaBqXwTDQAfYnGBvhp4a/jl9VeJq/fcBQV6vJzPmlW5kU368f9Os+mmDklDcO0ZstFjFFJ47e1s8AZMHiMLXp4vAMr0Qg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gebwisOT8R18h828nGFEUGF3YC0VNu4UOUF1c3oA4VBozk1eDR7HMnL9dsuHDEkbqG5zmNI9ztoiUobgE/K/1KIRFc4rwAvVs4i8Wv6wCnt3n7rIpuzK7j2d18ixuDTE7EaNqS2SL7qCWgIkVDnbYg8O/jjukEYJwLDKfMJEzo8B0uk1KcK24k0TJf74CDypnzSJ/g7l8W+8PHLVwKUIGJENm+wUQoco15GltLAJ7VAldJ8c4TJd7bZNHeAXxV6hLTPwLcY9mh3Uyi/v8o+Ih48HEPXjFIwX7XFEYsO39VfN1KgGbgn4A/t3N3kIQnNUulor1hVIbc3uEuPwkchc5+6RSttjyVBRFfpAmg7i5ryjvHQe1tXsPtHuFW4Jc6Z/FeY2Cz839zWdToO0Xh5zShzor6D6ZuHPMKkrlD6qlsysJsp7/hOU1zUOCyhvL/SlDAiXlgxBDpYzTaaOoZSMU+M0Cz9FqoGg0/5dXHwcaKwou3IJ9ngnKIa1wD6RTn6vRUcxOpnm6FLlhb8qAVkDbB6LWXs1eu6v3uPGgFccLtE9DpWjGUjruhlx5vQNsil5Im10I1VI05ytXjaf7KipS5USmGl+rDI3Ud/MhlyXYfKq2HiwaxQj8wC1Jeub/O9BO1S2HMhOfTdhlPFwMjxSbw==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f53eb1a6-908a-4ab9-dde8-08dec08db1ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 09:59:54.1077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6HMKjPc0DCoDrm5AfKaE+c/wzRQnRSyhRsnfprMC879XU8Dejb0fdJVb+rYY+OLZ7p5a5k9nRupsYb85m9qJKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR16MB7012

PiBzZF9lbmFibGVfY2FjaGUoKSBhbGxvY2F0ZXMgYSA1MTItYnl0ZSBidWZmZXIgdGhhdCBpcyBu
ZXZlciB1c2VkLg0KPiBzZF93cml0ZV9leHRfcmVnKCkgYWxsb2NhdGVzIGl0cyBvd24gaW50ZXJu
YWwgYnVmZmVyLCBhbmQgbm8gcmVhZC1iYWNrIHZlcmlmaWNhdGlvbg0KPiBpcyBkb25lIGluIHRo
aXMgZnVuY3Rpb24uIFJlbW92ZSB0aGUgdW5uZWNlc3NhcnkgYWxsb2NhdGlvbi4NCj4gDQo+IEZp
eGVzOiAxMzAyMDZhNjE1YTkgKCJtbWM6IGNvcmU6IEFkZCBzdXBwb3J0IGZvciBjYWNoZSBjdHJs
IGZvciBTRCBjYXJkcyIpDQo+IFNpZ25lZC1vZmYtYnk6IENoYW53b28gTGVlIDxjdzkzMTYubGVl
QHNhbXN1bmcuY29tPg0KUmV2aWV3ZWQtYnk6IEF2cmkgQWx0bWFuIDxhdnJpLmFsdG1hbkBzYW5k
aXNrLmNvbT4NCg==
