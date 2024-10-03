Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164771527B4
	for <linux-mmc@vger.kernel.org>; Thu,  3 Oct 2024 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974066; cv=fail; b=WNz5LxlHxhUN6gt1abF0QYKqyzi409pjLNkNPYOBvMsHp3L5MvlV/GbH4ICHetAjIhpF9SBUGGiuYu8AIzGrtOGgkCSiofRuP+WEOVWrnwsV4l8y7dCG6UHdlO+alwWJFK6Xnz1RXO8LL+pQZ87W8t7C3qJrdsc9pBYx6izYAxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974066; c=relaxed/simple;
	bh=c5paqw8s7McB5IX+Q+3eJqCxE2EW1agPcmwnKxdI6sI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V35Vl6IaMm6k+uAX8SzdB3wVUwX2iTwkiYovBeq3+pckjfm9XXnXp263D7Zx6/aBcOLwkxhUG9iSY08ZfUKFJ7IqrH5jAskAoabqYyjkZziyJG51B7ivvx/Kxe5HsD9dKO954ogehgD0V+IbETL6QzlSHOljFYeDrx+5cIb5zwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Y8V20bFk; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=WM9mpmld; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y8V20bFk";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WM9mpmld"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1727974065; x=1759510065;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c5paqw8s7McB5IX+Q+3eJqCxE2EW1agPcmwnKxdI6sI=;
  b=Y8V20bFkIbpp/OtSI1CslLFPFX0kvr1dhgd0R8sL5s+H9yPEe7cHP9Y7
   tSEq7IM+N4VUFueNxbrcOGp1dK/MmiqRN8U2qG/XTShXIi0NNPqZ4MB1a
   J0CgdMs4QR6KJk08xv4BpHfy/8e0PgTQ7GuaY8sRdXFEZoCpg2sdtmMnk
   FgGBZr2Z5YZmgvk1xrJqu3Vf3XHzLjAvr73loWZ8EeurekYKCY2W7PJ6r
   EB0/b2ixniEGX2W1ysXGAYI/FiNu6P6ZwwBkuQzaZk2yWnEwKB14Yx1dk
   PdrSOpvSZfaeXtIPvpi9BAtOyhUILb+aPxb19qyQTa7lAHSvPNOU9Cp3W
   w==;
X-CSE-ConnectionGUID: EwvzP9cjT/WQOzV4wV7Jag==
X-CSE-MsgGUID: iaS3L0aLS+uoxfevpNdhZw==
X-IronPort-AV: E=Sophos;i="6.11,175,1725292800"; 
   d="scan'208";a="29255789"
Received: from mail-southcentralusazlp17012055.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.14.55])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2024 00:47:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WbI9UeS8aPJZ2ATCC7egl/3psFb67xmCBA/thb9XR2MuukDfyA8No5FinSemmzJI7aA8N85KDuCEx3fsKlPF2xW/b8DL+XDksAMrk8p8Bk8Gs0Lq4D3CAT7Ii1PgGANDbDzE6Q6lhcp0KpdQEvU5ttt1F8sK/A1sSj0A9mJgoB2FwGo6fX+A4rISYDMTemNI6gQ9YQxUnbL+zcxIQY9axhv3qnBVDyFphYI/kadPEPhm7VGcdRc2G3842S823wnjDqB/We0yhxBYO3NSMkKhu3v4Ncfz8lYRgj1/f2y5zliPn1stvK+aP24A0qY5Br6qxoVfoIvV6FE3yLxxLLsSCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5paqw8s7McB5IX+Q+3eJqCxE2EW1agPcmwnKxdI6sI=;
 b=G0P7gwmJzTFgrIfHVX6rB7IYkGwPZaV39wNhQh7HE3dc79k69bYaNPaARc7Dm8EeovHmqmU4O1GJ/zQwQKFcfOF8Uka896mpHYihF22/FsBDOL9KUA5DeZTqoANWVT4DcRxskK+PrgX0PZ6ZumrliyJrNQctIsHFJYheI4IcuaSJlk828RXoPL8OKzAUIojyQY0zH2PQ+alo6NHE6goKLIVFLVcrOlUmmThTjH4Ty5/8Hkl3F6Q7RuCTIxZHxnSDG4HGwJgHyY06stWZyt6VMRXj+FW4Iyoz+IM1KQPLWQnzUxwJLqKw4zo1ebsAoVQ5tpphYZIUdaMn8YguBokd5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5paqw8s7McB5IX+Q+3eJqCxE2EW1agPcmwnKxdI6sI=;
 b=WM9mpmldeHwsz6Md0DyOS4BJWOQdGJyZejjJSwDqDOd5RXsASG5eUkQxk0NxRg9J7weNrSSRSFNAtEmBFaa5xSl028l70l+ndStG+P/7SNIsrC3DOa8glrj1OcSvXw0yjdlMLdzBB6SlFt6By/pzVmJ9sPuAW2zAOY/eT0310bw=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SA1PR04MB8888.namprd04.prod.outlook.com (2603:10b6:806:38e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 16:47:34 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%6]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 16:47:34 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Christian Loehle <christian.loehle@arm.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ricky
 WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>
Subject: RE: [PATCH v7 09/10] mmc: core: Prevent HSQ from enabling for SDUC
Thread-Topic: [PATCH v7 09/10] mmc: core: Prevent HSQ from enabling for SDUC
Thread-Index: AQHbAdkMBvLgh5DIsUSlSwPzCfYQI7JNytwAgAABUWCAJ4n7AIAADeow
Date: Thu, 3 Oct 2024 16:47:34 +0000
Message-ID:
 <DM6PR04MB6575F5409D68ABF703903970FC712@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240908102018.3711527-1-avri.altman@wdc.com>
 <20240908102018.3711527-10-avri.altman@wdc.com>
 <6cb63826-e6b4-4e3b-92e3-5a5c912eedea@arm.com>
 <DM6PR04MB65759D7DE903446671DF8D1EFC982@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAPDyKFr8--BF6MrN7pyutziU9BNwPQLEi9QJ6Y2FT_jbSD9asA@mail.gmail.com>
In-Reply-To:
 <CAPDyKFr8--BF6MrN7pyutziU9BNwPQLEi9QJ6Y2FT_jbSD9asA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SA1PR04MB8888:EE_
x-ms-office365-filtering-correlation-id: adfa7526-8c13-427d-f1ef-08dce3cb1492
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cC9oUUVFOSs1dW9XU1FMODl5MWQrT1J3ekE2SUFwYTlvelpuaDRCOEY2M25q?=
 =?utf-8?B?cXZsVERBdUg3RXNtbEREYzFWK0dTV3JOK3psbk5FN3BGaDQ2TTd2ZjNLMGp2?=
 =?utf-8?B?Vll4REtsZmxJWEZWMWxwVjRYbUJMcnI0eGYzZjREeDlTTUtZakxIei94Y0R4?=
 =?utf-8?B?S3dURWQ0dWtmNjcwYmF2NG5GeDVPVGZkdGRaNkUwN2ZlUFJOaUtXOEdTQjQz?=
 =?utf-8?B?a1ZyYzRnUi9nazBnN3dqYWhHVXJxbk9NR2p6Q0NJOFdSRXVhYnhjR1c0Rzkx?=
 =?utf-8?B?OWE1L3QyKzZnMXNRL3lnNVplMkllYzNmQklGZllxYVU0RkRWZ21nU3E4T3BM?=
 =?utf-8?B?Z2FObHJZQWg1dzQrczdGSFhWSTJzWnFqREI1TGVtcitkNksyZGJkMG9iZnA2?=
 =?utf-8?B?dkgza0o2YVA2ZzNOeEoyRlkvNVBGVzZEYUxCNU1Sb0VhVXE2RDNNYVU2K2hJ?=
 =?utf-8?B?c0lFMUZyaHkxOFVvMGcySGlHaGdlNnBMNDdyNmQySlgxNHlONzdiclQwVkhy?=
 =?utf-8?B?aVo2OG9mSjB4SWxUa0RCRnNpanlXQk1aZzdhKzJZTVNBcjZ1OG0vUEk2VDJm?=
 =?utf-8?B?ZDNDY1JPRlRKK0lxdUo3TGdoaWUwc0ZhdzZOUFhGM1Rlb0R0b2U2T0RVaUd1?=
 =?utf-8?B?RUJMMTNzS2pHRFZ3WXJMTTJXU0o0TkhkQU9DVGVEVnBXTXFKSHd0bzNCSGZ3?=
 =?utf-8?B?RHdSakM1bGY0YzlveFJjc2VtNTNKRHhRSjBJRG52QmpuczB1SllEb3FiM0dn?=
 =?utf-8?B?SCs0VjQ2TW91bis0VFNFTlk5VU9hNEJueGV2SHNFQnp5dmdEMENVTXVkNnJC?=
 =?utf-8?B?eVc5SHpMdHpoRXVZWUxmeE05OWdFLy9MYnV0THE3Zi9LcGtONzJBeG54NW9Y?=
 =?utf-8?B?QVZGK0lsRWdUV0tmNE1RRUdrbS9TR0lmT3prUHBaQWdGeCtCcFZldWFubHpv?=
 =?utf-8?B?Mkk4U2NSNjFHcVJwTUdNTjg4cCt5bzNLSUZwc3RsZERwWUxpcVlkZ2tybm8v?=
 =?utf-8?B?NTZWVlYrZlpCQXFObVhXcldiZExvYzJJa3gvbHlDcEV5ZGcvWlhQb04zdXdF?=
 =?utf-8?B?dXR2UnNIMEc0NFcxQlFHelVrQUVkbVovamx6NUpsMWFCakNFMnJ1bU14ZlN6?=
 =?utf-8?B?c2g0RDB3SWJYWnFWKzdoSnpoOVNyYlkrSU40c2dJSWl2Q2dUeGhmVVBIVVNQ?=
 =?utf-8?B?bEJCTnY1bUJBQnBDdnl5VDU5bktTN1g2MElUZ2p4ZTlpdHJqb2FqZFJ1VWJL?=
 =?utf-8?B?QWFTSDlSbW04S0RObXU4YUlxY2VzcVNCZzlEYUw3RlF3RjRNUkVHYmJzYzJN?=
 =?utf-8?B?dWJBOW50YXpKNkYrcmZLS0srRzFOM2ZXZy9MUDdRdHc4YnpNNWsvdERmUTli?=
 =?utf-8?B?UHdBeG8vbzl4bzI2eWY4ZWg0QlNTaU1BbWtoSXJtbnNHUnE5aGJlRi9TbUhS?=
 =?utf-8?B?MmV0WUJpUm1rU0tJOU5SOCtIRktjcnB0Q045eGlhbFRmalUwakY2VDR0Mytq?=
 =?utf-8?B?YjI1bUsrODBnYzQyVXNLd09za0pQRUpzTmluSUdJTmFJc2RwcTFqT2o3Y3lw?=
 =?utf-8?B?elVFT3VoTkZwdkFmRmRja25YWDJlU2g0a2Y3ME5JcWZYM1BLbzZhbVBnVkVT?=
 =?utf-8?B?NVV1OFIzNUJjM0pKTDF3US84YWhMK0Vjd0loU0tzZVpNV1pKK2UzamFKd0dI?=
 =?utf-8?B?aUNaRm9XTDFHalZIQXl3SThHZHoxN0ViSktST2VoT1lZN1JpRlExVGlObUg2?=
 =?utf-8?B?RkxlWFozS3hSZVVZNDNrL3ptelJ4eFVCQXJQcU9kVU8rMFRWYmRaVWJ6OEVU?=
 =?utf-8?B?SFZRYjJhamxGZmlTWk9BZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWxVYlZ5MWdmMGpHbUw3UFRUVjJLUktIUUpWZmNuWFhlbzBJZytHbjh6ZFpZ?=
 =?utf-8?B?UFV6RG5sM2ZvdkcrTS9XaTFGamw4M0wyVnZrallZQVBjKzR0b1VJOFYzSHB1?=
 =?utf-8?B?QStWZVJBcE9HYzFKYlpYMzVsTDU3cXN1d3Q0TEU2eGZzQVMvVGJaVjBYWG13?=
 =?utf-8?B?NXhWUk1IQlhpMi9rRHFPT010OXBMaUlWa1RlT2dSdHBFV3A3QnBUMm9UZUNP?=
 =?utf-8?B?K3FqSE1vZ3lrTG1adTkrUG5SK21qTHlCNzZnU0JQNC9jMVluMGg2bU5Ya0xr?=
 =?utf-8?B?ZFF6VjBFU01XSWRaRzVvMUxmU3VNWkdRRnhTeVFhZXdQMVBaZmZhb0cxYU1K?=
 =?utf-8?B?YWtpNDdjTlZwbHZhVnlKaEhaZWhxQjRRckNKY0hqUTFxVStOeVp6ck03YURL?=
 =?utf-8?B?VzZhbDhoTVozS2crUU5QS3lITmNZTkFGajhVYnR0UTFJc1NrQVF3V0x2bk1R?=
 =?utf-8?B?R1k5T3FHL2hBcHp6emsrdHBwanNSYWN5d011VENqaXRjYThBdTRIUEtuYjd2?=
 =?utf-8?B?STd6Q3VPOC9IU3RMeFF5RmVJVzQ0emd4MzdPcTdtRnlzWE4yVXFHckEvaUZw?=
 =?utf-8?B?ekhjOEJFNmJRemJiU2VLWjdDbytNVitMRnB0UkJRakZ5YTNIbU5jbjNPZnZQ?=
 =?utf-8?B?RjdLaUw0a1REdEJJMytSdGlnWE5rbUxZL1ZKdDVIUjNyMDRxZ0M5QkJZSmRp?=
 =?utf-8?B?R2dIOVNhaUJoZG9kanU3R2JoKzJyeDlrdWhrOGdWRDZvK3RWMUFhYml5UmVD?=
 =?utf-8?B?cGFXZ1ZVZXpwa3VnZ2tvdUd0dHNxMnduMS9KdUkwaUxWTHFJdGlrSFE4MTAr?=
 =?utf-8?B?QVZjYWFEYVBCUmRxeUNNYWh1UW9CbG9HTWdhUHpaa2VQbDdDbWRyN3ZvK0RH?=
 =?utf-8?B?SDVXL3VIeldLakRzODRjamRWaGJNRE9ScHZPQVYrSWhCaDlMcXJMT1BrcG9U?=
 =?utf-8?B?QVl5a0N3dDBZVzJOaTFzcFhtZHczRm5ZSGo4ekVzeE9tWWxCSEJhbmplTjlw?=
 =?utf-8?B?VjNWMzA2NFQ2cU5rd3p6ZDVpSVB0U1RteTJ0dlFJZ2p0WjNNU2JXNHVGVkJC?=
 =?utf-8?B?bFI2WCtXM2VaTk80VzNsMHlib05rYU4xaUpWZmtzNWk2TmU2TENqQ0hsdWJr?=
 =?utf-8?B?NHJ0V05SSGQrVXpFQ1NkNGJPMWVhMmtndTAxekhIYmZ6T3pkVDRNUk5xbEFZ?=
 =?utf-8?B?bUpudXMyaHRuK3Y2MjFHRnc1anNLaXd4bUxISlFmTGFndVpPMURrcWxMQkJL?=
 =?utf-8?B?eDNabWo1VTd5QzFlNEhpY240ZDdEV3J4SzY1WElRaWdwN3N3UHo4dFYzNGJV?=
 =?utf-8?B?M1pPanRPemxMZTdySzRwNXBraHNkcUFLcmZYMTdWVTJyalQ1SXNUUjk4YWRm?=
 =?utf-8?B?Nzc3ZEZubXRTZDV3VVVyZzlKOUZNTEFtNS9Pbjh2WXliYjNjMm9IK01GSHFo?=
 =?utf-8?B?blJyRDRtUzRXWWZyZGZsMG1ORjJHbkdrMVA1a1V4L0U1MmtOZ3BDYW80T2Zq?=
 =?utf-8?B?OTVLd2RveEpxZEV4Qkp5RTNlcnB6NXdMbnNkWGVRQUx3eG5iaFBRZldOMTVp?=
 =?utf-8?B?MnY2c3FSQnY2ZzcwNXYvSHhuNFZpNXF1YWw1MG1lSCtJcDNqc1IxV1IySkdx?=
 =?utf-8?B?bzFPR3B5dlpDTmtScHEyNlFpcnJmVVQrell0YXoralpPbmVVOVREZGJaV3VY?=
 =?utf-8?B?clR2K2xrRFlEb0ovMzd2Rk8rQ2JDZkRQZjN6aHlFT3JjbUQ2T21GZmFKZHBH?=
 =?utf-8?B?cW9ndUVMZW1DbmxlWXVHQStFQ3dLdGYzM3NYTEx5UXhPTmlpMkVobTA0VlRo?=
 =?utf-8?B?cUU3OGpqT0pUYVo0ditSUWJEdWlid3VaWmJiOFg3T0lSUldOZ21sTnpUb3pS?=
 =?utf-8?B?ZkpMRkNJMDJCZjF2R3dxM0wrMER4UGRGUkRaOHRyWHllWU5RcW9EMGFJSE1n?=
 =?utf-8?B?QUxNbjBDRHJybDRyY2Q4djFqNVA2UGhMcXNaS3lNdWJZN1lvVjdDSFZzSDlp?=
 =?utf-8?B?T0t4aGcrMCtiRnl2eGtRN3c0QndRZDhrQWs3dDN2RlYxdzE1RHh4MzBVckNT?=
 =?utf-8?B?Zlk5K3IvMEI5bG5IakxkVFo5ZW9TZmlhY3JwM0VWL3pkZ0wzYUtCSzY5emRP?=
 =?utf-8?B?Q0lyQWhXR1N2YmNCdnBVNFRHY0VxQTVqN3I4eFhMQUc4b1E3UktOSXIvK3ZW?=
 =?utf-8?Q?g9YC2M8VT6eai3t8avHzbTihiGC41wNCwifj6NMR5Yvy?=
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
	+LlLMWvVpFZYCYke4IimazvYjfrgAx7SwXZyQGdED0Vt8TEYYCtHY9/h5OQlJacUHTUXK43rtw0w+eULRWYZog2WxBQA7ebDxeA3muxpbl+7E/8dmCZ+HCbR5Xj7yW4j+PpUC+VnT3vFPYwPrHRH2voZTcL/iA4O1MvPHoZbVXrzVwkJPswn4c9gvwmk2bR/jTK7Cw3Ue8HihHudu5lF247g/N3PTI4+i6ZYbMWpC0U2ryNB4Cp76xj79VlSNf7dqFtmdpnLyAXPsdE7v4CHFXW+wkZUox3/1oOQtgI0e05hoEDxRvaIIqDzuZBAy9qdXiSmtz6sf9/YYZ//tsGMQTarq9mZ2bX5hWKNHCNM8MZ9zm6JbX3iw/pLdOpvCTLTGV2ukJk7LsTBVPY3YRikaVJAgs5vHMIfSdQBjDiWtyI2oBNFOz0+zlAVVkjv/F0vzh1xulEL+0SVBo5oRASPHiNvyg2ehswN6xYAPDioHoKI+hnq3DU5OzaE3NKWxSIGA9TUP4PCopEVOvWx30UXN6MqVRKsZ8AQU3fQuw5lO2Ql1ySrWWSmycCgiP+MEge1saZehHjzXwkudcRsxMrMDJOu83zNnkSfqBG9vKPJJBaygmJoF67ccUoPK7Rb7pUM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adfa7526-8c13-427d-f1ef-08dce3cb1492
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 16:47:34.2407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GKNo1WItstgWxJcp4qWRDQz05OGSl/0Ma45MteoVD/E/Tana9HxwYLuPjlnM4wGnwuWiuciJaiHyU+DnBj3OqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8888

PiBPbiBTdW4sIDggU2VwdCAyMDI0IGF0IDE0OjExLCBBdnJpIEFsdG1hbiA8QXZyaS5BbHRtYW5A
d2RjLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+IE9uIDkvOC8yNCAxMToyMCwgQXZyaSBBbHRtYW4g
d3JvdGU6DQo+ID4gPiA+IFByZXZlbnQgSG9zdCBTb2Z0d2FyZSBRdWV1ZSBmcm9tIGVuYWJsaW5n
IGZvciBTRFVDLiBJbiBTRFVDLCBDTUQ0NA0KPiA+ID4gPiBpcyBtb2RpZmllZCB0byBpbmNsdWRl
IDYtYml0IHVwcGVyIGFkZHJlc3MgYnkgdXRpbGl6aW5nIGl0cyByZXNlcnZlZCBiaXRzLg0KPiA+
ID4gPiBFeGNsdWRlIGhzcSBmb3IgU0RVQyBmb3Igbm93Lg0KPiA+ID4NCj4gPiA+IFRoZSBtZXNz
YWdlIGhlcmUgaXMgbWlzbGVhZGluZywgYWN0dWFsbHkgaHNxIGhhcyBub3RoaW5nIHRvIGRvIHdp
dGgNCj4gPiA+IHRoZSBhY3R1YWwgQ1EgYXMgaW4gQ01ENDQsIGl0J3MganVzdCBhIGhhY2sgdG8g
cHJlc2VudCBpdHNlbGYgdG8gdGhlDQo+ID4gPiBtbWMgc3Vic3lzdGVtIGFzIHN1Y2ggdG8gdGhl
biBnZXQgbW9yZSBpbi1mbGlnaHQgcmVxdWVzdHMgZnJvbSBtbWMNCj4gPiA+IGNvcmUsIHdoaWNo
IGNhbiBiZSBwcmVwYXJlZCBpbiBhZHZhbmNlIGFuZCBiZSBpc3N1ZWQgYXN5bmNocm9ub3VzbHkN
Cj4gPiA+IHRvIHRoZSBjb21wbGV0aW9uIG9mIHRoZSBwcmVjZWRpbmcgcmVxdWVzdCAoaW4gYXRv
bWljIGNvbnRleHQpLiBTbyB0aGUNCj4gY2FyZCBpcyBjb21wbGV0ZWx5IG9ibGl2aW91cyB0byBo
c3EuDQo+ID4gPiBUaGlzIGlzIHByZXN1bWFibHkgYnJva2VuIHRob3VnaCBieSB0aGUgbWFuZGF0
b3J5IENNRDIyIGZvciBTRFVDLg0KPiA+IFRoYW5rcy4NCj4gPiBTb21laG93LCBJIHRob3VnaHQg
dGhhdCBoc3EgcmVsaWVzIG9uIGh3IGNvbW1hbmQgcXVldWUgZW5naW5lLg0KPiA+IElmIHRvdGFs
bHkgbmVjZXNzYXJ5LCBJIHdpbGwgZml4IGl0IGluIHRoZSBuZXh0IHNwaW4uDQo+IA0KPiBJIHN1
Z2dlc3Qgd2UgYXQgbGVhc3QgdXBkYXRlIHRoZSBjb21taXQgbWVzc2FnZSBzbyB3ZSB1bmRlcnN0
YW5kIHdoeSB3ZQ0KPiBkb24ndCBhbGxvdyBoc3EgZm9yIFNEVUMuIEl0IHNlZW1zIHBvc3NpYmxl
IHRvIG1ha2UgaXQgd29yayBmb3IgaHNxLCBidXQgSQ0KPiBkb24ndCBtaW5kIGlmIHdlIGNvbnNp
ZGVyIHRoYXQgYXMgYW4gaW1wcm92ZW1lbnQgb24gdG9wIG9mIHRoZSBpbml0aWFsDQo+IHN1cHBv
cnQgZm9yIFNEVUMuDQo+IA0KPiBEb2VzIHRoYXQgbWFrZSBzZW5zZT8NClllcy4gV2lsbCBkby4N
Cg0KVGhhbmtzLA0KQXZyaQ0KDQo+IA0KPiBbLi4uXQ0KPiANCj4gS2luZCByZWdhcmRzDQo+IFVm
ZmUNCg==
