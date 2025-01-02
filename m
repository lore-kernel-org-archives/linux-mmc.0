Received: from esa.hc188666.iphmx.com (esa.hc188666.iphmx.com [68.232.145.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820A1188938
	for <linux-mmc@vger.kernel.org>; Thu,  2 Jan 2025 08:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.145.191
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735805300; cv=fail; b=YqKOHwgCTsOw6JzOjziRnH6bDogSw2yFuxwdZthwh/nLITVz87Qemll+Ui8DzfG5WRgHlYIKlpnhJgq/B80lYqKgSNy8dc9DUavvykL6zAFs3hcRqsJi7Qcx69hS0oGq8IFObhVl5mUCnPgyjWfEof6CLBRGwxHKKprXilxUYTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735805300; c=relaxed/simple;
	bh=3pJfcRYunriUp/eb6OP7H9nlbzgE4k1XPFaJt+6UzjU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Y//5beGsREZIfaC0EaKMaILXYtH9wGsTMQVJNwWVxj8zldSAf4CeV7skpRw1tDWysKCToB4g5AdW+ikatbO9devh5DPLZ95OqbpL90pXGj8ubWmGdS7+4m6vrwosAs1O+CW618edSQ9xf3Hdo8b02tJGjkvFV19tMCUmy542uzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=conduent.com; spf=pass smtp.mailfrom=conduent.com; dkim=pass (2048-bit key) header.d=conduent.com header.i=@conduent.com header.b=LMHGYu6U; dkim=pass (1024-bit key) header.d=conduent.com header.i=@conduent.com header.b=Z6zV+v6d; arc=fail smtp.client-ip=68.232.145.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=conduent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=conduent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=conduent.com header.i=@conduent.com header.b="LMHGYu6U";
	dkim=pass (1024-bit key) header.d=conduent.com header.i=@conduent.com header.b="Z6zV+v6d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=conduent.com; i=@conduent.com; q=dns/txt; s=sept2021;
  t=1735805298; x=1767341298;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=3pJfcRYunriUp/eb6OP7H9nlbzgE4k1XPFaJt+6UzjU=;
  b=LMHGYu6Un6seZBkJikxeF8XwKwldaHAHuyDMoUmt184HRxhZD6drZ+vE
   eknHsRg7jl5wmOT3bICXta9QxwrSMkF2KDUcBa7i4uHCuHOg+Po/M26vW
   /5wYTVZqrBSz+utBKaTJ/hduOTMb/Ru0cdK/1i7sBwmcjSlmEM/X3PsGy
   hsIf7of61YrnwFDMuD+P3jJzqatoAKIrgpdOG1ZmfHHIvErHcIiWLOswl
   V6R71h5/WEhvtLy6FtyfDS5LeuYA29ErifnIiKwcPjPR3c7NUdZDUmtk9
   MBEM8VEicQyVyE8SSdh44YN9IREZ1bapbDkEEYFhvVNU7AxwYcnkgugYJ
   Q==;
X-CSE-ConnectionGUID: UxVMuoY/Tn6zz6bUVg4VOg==
X-CSE-MsgGUID: QQimPx/0QLedwspdm3D1Ig==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.12,284,1728964800"; 
   d="scan'208";a="98953350"
Received: from mail-francecentralazlp17010005.outbound.protection.outlook.com (HELO PA5P264CU001.outbound.protection.outlook.com) ([40.93.76.5])
  by ob1.hc188666.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 03:07:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqQWzN/75n/wvSJMBfOsq2cAuQ2RxFPnS1sUWblqZg7McnHpY+9s/C9J1gjLROxfuNIjyDc9PK9QTGS5/LFLg9ChDHfgRApGFzkjnWsdn8myfs8UwdU9bgJ2HD6iW8CapCS40FsCKnE/O4/4Lw+IhtDig7pjngcZN2Gj3r72OVA010xn+vIC5oMDEqrbp+Uwb70fy3GJ4L7NE20QsOyw/RukUtlRagySbQPSQ6A4FE+pzIJ3aEsuRdau/r+XrjRAq0ADbpPz5gbiprwlztfMiMV/jOAWmipA03lBDk3ALIXIc5UfBJ26NFldj3ZOI0NPuZ9JWR96hgQUkTYFJQOGSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pJfcRYunriUp/eb6OP7H9nlbzgE4k1XPFaJt+6UzjU=;
 b=rCro74+SlRnvIRIYS3Qnd2dQVNcFzhBdaqUImZogc2jn4s6tiHj23vjenvDsxPEASo9He2ebMiWtvfBySdvx5FRwWTiI7u4kqxOF28p9WREkdCpLnIWmnjh3rH1z0QnYlMjh3MA+zHBwzjVtnI7EE2koHaK7kO5sVCaR+gMcHJ9qVTlEOu18Bp0iDpiUk+FzeQDPns/mqWnk0sOPExLyF5FiGaDoT8YosutXsdkZofenslIPPAFY2gBRGWeyY1yCjD1MAYfmOVCU2JsRKjNQ2KmbQSvKNzTqtH21aMuRuOHaLOkhRYrpjg1jr23wwUcrDc/SZpQPcqQoXtIxt4R3nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=conduent.com; dmarc=pass action=none header.from=conduent.com;
 dkim=pass header.d=conduent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=conduent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pJfcRYunriUp/eb6OP7H9nlbzgE4k1XPFaJt+6UzjU=;
 b=Z6zV+v6dPf7mfNlqt0Q0Zvihvk3dlXQLsc6Uzu5lohJUH5ZIwePY2AHxoMFKhVWFxSRAEi86WvBRHeETz+ywN6Mb27EUKU3jPFnkNoGpj/3cNQeFC7tpJv28pd63/+v9Zsw4MqOsOlcP4BDtviwPPt+zfv2DZ4KZrr4fyPtsr7k=
Received: from PAYP264MB3440.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11c::12)
 by PR0P264MB2170.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:169::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Thu, 2 Jan
 2025 08:07:02 +0000
Received: from PAYP264MB3440.FRAP264.PROD.OUTLOOK.COM
 ([fe80::dcdb:eb6d:38ef:853a]) by PAYP264MB3440.FRAP264.PROD.OUTLOOK.COM
 ([fe80::dcdb:eb6d:38ef:853a%6]) with mapi id 15.20.8314.013; Thu, 2 Jan 2025
 08:07:02 +0000
From: "Torrelli, Maxime" <Maxime.Torrelli@conduent.com>
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC: "Bove, Frederic" <Frederic.Bove@conduent.com>
Subject: [eMMC] - Partition on eMMC boot block device is not visible anymore
 in kernel v6.1.53 and above
Thread-Topic: [eMMC] - Partition on eMMC boot block device is not visible
 anymore in kernel v6.1.53 and above
Thread-Index: AQHbXOpMPxhaTZEN9EGrb5ULucOC4g==
Date: Thu, 2 Jan 2025 08:07:02 +0000
Message-ID:
 <PAYP264MB3440EA9BD04E467466A0DAE495142@PAYP264MB3440.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=conduent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAYP264MB3440:EE_|PR0P264MB2170:EE_
x-ms-office365-filtering-correlation-id: 7e794f43-6653-4a24-a450-08dd2b047066
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b0dpcFJGMURZSjNhcEgrdk04U0JxV1JUUlRxSld5K016RlVQZDgyMXkyejhm?=
 =?utf-8?B?d3BFUGFCTW1rTDV1aGlrNWU2YmI1U1dYbk9VU1NKUGZtQVVsMnR6dGlzaFJo?=
 =?utf-8?B?K1JtSDluUDh0cmp1K2xYdG5OTXJGNnN2Z2NPejZRdUt4QnVDWVJRTzJqNVZV?=
 =?utf-8?B?ZnVIQm1vRTZ0eU95UU10K2hmaDdiajlENlNIZEVkV0lFR2g0ZmRUVnRvQkps?=
 =?utf-8?B?aVRQaC9PSnBVS1V6VnlXS2dQNGpZelowZkNXZHc5NDFvR2VxdXdSZmg3N29m?=
 =?utf-8?B?VDg5bEdjbE5jWHg1NUwwcXRMQjVDdzVMWk5JSEVHcnFuR21kemp0bkNNNFQx?=
 =?utf-8?B?R2MyWXArcCt4Z29ZMkdwRk1FcDFEOE1ucHVUdGdqWG9mRlNlNXJyTFlxaWpx?=
 =?utf-8?B?SDlicDRlSWswOTR2RUdwR1dZSEZyTS93aUtsMDU5RHFBTDF4ZzRVMUczc2c1?=
 =?utf-8?B?T2I2S0kwSldPYnlJb21VZytkS2lFQ0kzYTQrbjAvV1RraU1Rc1EyOVJlSW9i?=
 =?utf-8?B?UGJvRmtYSUxUV1Y3Q3ZQYzJlalJFSzBQZEc1L1oxVXdyMTdXalZDTVpSL093?=
 =?utf-8?B?a1Y0dXlhTk10RWtJeE02UTFtQU03bnQ3aG1zOUpJVnRCNDFZU09UNTM0UWpV?=
 =?utf-8?B?K3JEMVErc1I1K0ZxSGk3ZUYwditsbjJwS1lxM2psWWVQOCt3TmhSdnFBRWNO?=
 =?utf-8?B?UzZCejJtWHhObHRENHRWMFpWZ0J2R2ZjbENBMEhucHphNUtmYytSa1VkMzMy?=
 =?utf-8?B?eko0R2NnUmtaMVU3UllRUHp1V0hMNTVmRWF3dDhqZXZGSUV3dGcxVUxGa3Jz?=
 =?utf-8?B?dGVVNjB5dFIrZ2JCbTNHYkN5TzkwNUcycTBsM0ZJVEFqM2RORXI2aVJXc1ZG?=
 =?utf-8?B?SmViTWJPdVAzc1ozVTU1TVZSYUc0SHg2ZTdid21lKzF0QnNHSEZUR0tDRGQ1?=
 =?utf-8?B?QjVpWmpaZWNUMDhsM3haU2xpVjRsN3l6aHhjYVNtS2J0T25ZQmxmeEswOUdV?=
 =?utf-8?B?VmcvcHN5T1pQK3l6b1dOMkpVdGMzWUVjdWxZd2JrQm9DTWxIaFBNQjJndURG?=
 =?utf-8?B?L0U1bHRNZ0s3YVRMaDdsUHliN0c1cjV0bzc3VGxqNVRIdGhsdEtLa0JCaXhZ?=
 =?utf-8?B?d081TnZQNXRnY3RhOWhaZUhGcHNlNlRaa2k2Uk5MKzB5L1ZSbXU1a1I2YTgw?=
 =?utf-8?B?RU1FY295bElEQlJYNS9sRmdidHJoQUpuMkRST0NUaGtFOTlXZjFRcjQrRDFi?=
 =?utf-8?B?SFFNVnFLblVzS3NkQWpBbzNRNUdieFBvVitkSHBRbVowaHVOOG9rUjBpbkFr?=
 =?utf-8?B?RlZnSjFyYnQyS2c5N3E4aExEbUJJWHdUdmxDMGRVT050Yzh5NUg0Y3JidHp0?=
 =?utf-8?B?QUpsN2h3NWlZVUd5dURFaDNxYjE1Z3RxS2F6NjR1ZENXWG13MjhINXhFRm5U?=
 =?utf-8?B?cG5nTHE1aTM2WnBYZTYwQjBnVmhZMlZUdzVFOVR3aUxSTXhqc0tqY3hLKzZZ?=
 =?utf-8?B?QVBCYU90U01qZXdDRTdLU0dNYkpVSDFxR0ZsNy9ZV2UwWElNdHZkUktyaWFJ?=
 =?utf-8?B?TzBYbFNDSmNpdUdXaWRsSkdmcGFQUmJEWFU3WHdmemc1U2RFUVc0VEhrOHVD?=
 =?utf-8?B?TzRPd1ZBWVU4Si9DVEJjajA1ZUFxYm9FaS96Y1IvT2FVdGgwcVZkSEh0VnVl?=
 =?utf-8?B?SkRCd0txRkxiZkZWby9pbjlZV0VCN1FIOWgwSWhuTDdFclZhUTJnVVhHT0hJ?=
 =?utf-8?B?ak9rTTJqUU8rNlRTckdHbjFoZ3lKbjVpMzlRL25ta0R2WUhubTBXcmppaXB4?=
 =?utf-8?B?UjlrU3RpcDRZVjFKamxZN1Vnc2RURDM0QVpUOFdTeFJiTkZJZVhzanlPNUx0?=
 =?utf-8?B?cFhRWWM0Qi9IUUVpK2pvS1k5Mi95UWNvQWdoUDREZ2pveDdCcGQ1QVA5VHI5?=
 =?utf-8?Q?ydcBy17Q20/lilibpQDOpuxH/gUplZzu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3440.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OG5xeXVkNnNjdHVHZ1oySHlicXlRWXZhVUZjd2plTXVXZ1JkSkltNWtPVUpC?=
 =?utf-8?B?MDRZc25pbUJReFVjK1hXY2pyaWduaTduK05DRytlaktEV2IvV0JLY3BaUlVP?=
 =?utf-8?B?WmxXOHdhYm1vTHBsS3d2bkpCaWZZc0d5VHlkdDNrTHZOWVVnMm5iQWZsa3Y2?=
 =?utf-8?B?emRVaU5EaWNhTUhpRXhKdU9lbFZPNjdydUVzdkd5L2ZPS2ppMm1JYXo5MlNC?=
 =?utf-8?B?QStkZDlsWkdENno0ckEyUUthNElPVXlMWFpCTDFxV3ZuV21CRjh1WElkK29o?=
 =?utf-8?B?N05yNDFYK2pTTHpWaW1GRVB5c25Hd2l0UER0TzNHYlE0b24zam11b0xMb2J2?=
 =?utf-8?B?MU1CakxaWDJkSi9aYi9GMTZBVXJQZGt0amxWT05MTTZWZllvYXA4Z2RjbjB5?=
 =?utf-8?B?Kzdoa2RtL0VQb2t5bFJLMVpDQTdnaGJFeVpYRWRGNnFNLzFxL094OGdBRFFs?=
 =?utf-8?B?T2hGKy9FLzVHdTNDUFB1K0xUMnhFdzVkMjdSV3lzTnp3L3ZPa3hueUo1UnZm?=
 =?utf-8?B?R2xyZGtSQzRXUVBzTG5BZWxNbk8xZCtnR3BTSjJxcHF3c0tDb2M2TGsxMTlV?=
 =?utf-8?B?UlQ5eDZPSnpFcTl2eSs4K3F5alUvQzdQUzduZXVjekZjY2VBbEloUzB2YTdI?=
 =?utf-8?B?bFhjZUtwTnNnTXhKeEN4TEZzalp0NHQzbXdWYis2eC9VeXZIMW8zQkdVL01x?=
 =?utf-8?B?S0V6dlpKRlB0MVRvUFBwKyttUUxqTXJiRHN2T3JNMHlYcGlyNUNjK3hadHpU?=
 =?utf-8?B?U1dCSCtTUmF6enRqS0tRa2Y4UjQ0Q1Q5ZTBzTTNIVkpvb2cvaVhwWXl0SExQ?=
 =?utf-8?B?N1R4aDlTOTcrMm5vWlVMWUJNZ0NHRk9IUHhJak16QnRrLytBOXJnb2ZjUnJV?=
 =?utf-8?B?bGFXZldRSSthb3VHUVh5a3JDTHlSV0pUSmgyN0JLRk44Sk5iaXVrQTYyREdE?=
 =?utf-8?B?QUF3azY1TEFpQ2NlMHpOWEJVR1Rkc1RZNHZCMGdpNWsva0lSUUR5M0MwTWV3?=
 =?utf-8?B?WStaS1V3K0dBekJLOGJFQ04xcGw3T3k4TFoxSnljS3ZSTEJ0dkdEZUN4R09I?=
 =?utf-8?B?MkF6WjRrdDNrQnY2VU1BWVU4WU1SbU5Uc0FIYXd4VFd0akFCRHBsbjZTR29T?=
 =?utf-8?B?dytYYWh6VTdrYnZWeEIyTUdmcDBCYzhzY1grbThINnRIQ3dVckN2Q3N4YWtT?=
 =?utf-8?B?TkpmTDVZMXgvQWpZbEFwK1g2OFBRUUtLb0YxOEFEQXE1b2JjdUJiYllrM1p4?=
 =?utf-8?B?cDNydERWUlQ1WWwvajlLU0hwMFZnc29McXprMStUQjZzT1VCSE91RFQ1N0NE?=
 =?utf-8?B?MERTZVBxb0gzMVZISzVRNWJjTUxWc2xpNHpuM1docFYxMHFKKzBnbW9vL2Z6?=
 =?utf-8?B?MWhGazE4aE43RGJxUzB3NmxQS1Bmd0dVOHZHMHhHSzZtNUNMV2NsYVArWmRr?=
 =?utf-8?B?M3YyeDRXaTlZcWkxQVBrL1hJVkFmVEtPTjdBR09nMUt5WGx3cVFZMkJSY2k5?=
 =?utf-8?B?NVN2NVcxaGU3dTN1Q1c0TjM2SUtRZFdkd0dmKzN4MG1oTEVmVEpka0tGOHNr?=
 =?utf-8?B?LzRPeGhoTmhqNzV4eTdxVTdQdC8zRFpYS3BLd3paN2sxV1BXSVlZeUNtUktY?=
 =?utf-8?B?ZFhlYlViR2hvY21xOFYrSzJkS2txRk9leHRjN0pGZVNZSlhWdW0rdUZyZGtD?=
 =?utf-8?B?ZUFqRW91M0J1V1NiUUcrMU1BWXhoOVVqbjhVZGN5KzlHOGRZM1RCeGxNbys0?=
 =?utf-8?B?M2IrRXJwZHdGcmlhMGx2L3JSZHM1ajFPaUJzM1VsdldEVXB2eGJFREFpdldE?=
 =?utf-8?B?eGFNT1NHZUg5R3dmUmxNZVl0ZkZTRGgyQlIrRmRXTmgyYk9PeTAyNFBGQ1dO?=
 =?utf-8?B?M0NGRnpFMGpxYkF4emVXWDZVTHFReGlvcDlhc3RmME16M3N6a0lwczFNT3NJ?=
 =?utf-8?B?MWhkOG1EUFZLdnhmYzk5UGlwaHNicVZJNVNLOWVjQS9WVHpXdkU3eE0wTTd5?=
 =?utf-8?B?Q2JtYTZiR3JlVW1ZdG5Va01oTUg4a1J4SDZBaGUyenJMaDF5WXp5UlJXODdp?=
 =?utf-8?B?Mi84Y05QUmY4dTl4L2w1eDBHSEg2YTVMczMzS1FMOENYRUpxdkwzMk9ZS3FS?=
 =?utf-8?Q?DpwkFz0ZMsd3QrnR9NdEfKFzD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: conduent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3440.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e794f43-6653-4a24-a450-08dd2b047066
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2025 08:07:02.1597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1aed4588-b8ce-43a8-a775-989538fd30d8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7V+wya7cuZcVvRyniVD6u3y967EbnCIWAtNDWPnd0DfF7iWyxz5Z+dplT8FF2TSQs9D6wGBDdARW+6EJU4/TFUVwalRbMnp1zPE3CGLJRdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2170

SGVsbG8gZGVhciBNTUMgY29tbXVuaXR5LAoKSSBob3BlIG15IHJlcXVlc3QgZG9lcyBub3QgYnJl
YWsgYW55IHJ1bGUgcmVnYXJkaW5nIHRoaXMgbWFpbGluZyBsaXN0IGFuZCBpdHMgdXNlLiBJZiBp
dCBkb2VzLCBwbGVhc2UgbGV0IG1lIGtub3cgaG93IHRvIHByb2NlZWQuCgpXZSByZWNlbnRseSB0
cmllZCB0byBtaWdyYXRlIGZyb20ga2VybmVsIHY1LjEwIHRvIHY2LjYuIER1cmluZyB0aGlzIG1p
Z3JhdGlvbiB3ZSBkaXNjb3ZlcmVkIHRoYXQgYSBwYXJ0aXRpb24gc3RvcmVkIGluIGFuIGVNTUMg
Ym9vdCBkaXNrIHdhcyBub3QgdmlzaWJsZSBhbnltb3JlIGZyb20gdGhlIHN5c3RlbSAoaS5lLiAv
ZGV2L21tY2JsazJib290MHAxIGRvZXMgbm90IGV4aXN0KS4KClBsZWFzZSBmaW5kIGJlbG93IHRo
ZSBkZXRhaWxlZCBsaXN0IG9mIGJsb2NrIGRpc2tzIG9mIHRoZSBlTU1DOgogICAgKiBicnctcnct
LS0tIDEgcm9vdCBkaXNrIDE3OSwgIDAgT2N0IDEwIDE3OjQxIC9kZXYvbW1jYmxrMgogICAgKiBi
cnctcnctLS0tIDEgcm9vdCBkaXNrIDE3OSwgIDggT2N0IDEwIDE3OjQwIC9kZXYvbW1jYmxrMmJv
b3QwCiAgICAqIGJydy1ydy0tLS0gMSByb290IGRpc2sgMTc5LCAxNiBPY3QgMTAgMTc6NDAgL2Rl
di9tbWNibGsyYm9vdDEKICAgICogYnJ3LXJ3LS0tLSAxIHJvb3QgZGlzayAxNzksIDI0IE9jdCAx
MCAxNzo0MCAvZGV2L21tY2JsazJncDAKICAgICogYnJ3LXJ3LS0tLSAxIHJvb3QgZGlzayAxNzks
IDI1IE9jdCAxMCAxNzo0MSAvZGV2L21tY2JsazJncDBwMQogICAgKiBicnctcnctLS0tIDEgcm9v
dCBkaXNrIDE3OSwgMzIgT2N0IDEwIDE3OjQwIC9kZXYvbW1jYmxrMmdwMQogICAgKiBicnctcnct
LS0tIDEgcm9vdCBkaXNrIDE3OSwgMzMgT2N0IDEwIDE3OjQxIC9kZXYvbW1jYmxrMmdwMXAxCiAg
ICAqIGJydy1ydy0tLS0gMSByb290IGRpc2sgMTc5LCAgMSBPY3QgMTAgMTc6NDEgL2Rldi9tbWNi
bGsycDEKICAgICogYnJ3LXJ3LS0tLSAxIHJvb3QgZGlzayAxNzksICAyIE9jdCAxMCAxNzo0MSAv
ZGV2L21tY2JsazJwMgogICAgKiBjcnctLS0tLS0tIDEgcm9vdCByb290IDI0MywgIDAgT2N0IDEw
IDE3OjQxIC9kZXYvbW1jYmxrMnJwbWIKCkFmdGVyIGFuYWx5c2lzLCB3ZSBkaXNjb3ZlcmVkIHRo
ZSByZWFzb24uIFdoZW4gdGhlIHZlcnNpb24gdjYuMS41MyB3YXMgcmVsZWFzZWQsIGEgY2hhbmdl
IGluIGZpbGUgYmxvY2svaW9jdGwuY8KgYWRkZWQgdGhlIGZvbGxvd2luZyBsaW5lcyB0byB0aGUg
ZnVuY3Rpb24gImJsa3BnX2RvX2lvY3RsIjoK4oCC4oCC4oCC4oCC4oCC4oCCPiArwqBpZiAoZGlz
ay0+ZmxhZ3MgJiBHRU5IRF9GTF9OT19QQVJUKQrigILigILigILigILigILigII+ICvigILigILi
gILigILigILigIJyZXR1cm4gLUVJTlZBTDsKVGhpcyBjaGVjayB3YXMgdGhlbiBtb3ZlZCB0byBi
bG9jay9wYXJ0aXRpb25zL2NvcmUuY8Kgd2hlbiB2Ni4xLjc2wqB3YXMgcmVsZWFzZWQuIFRoaXMg
Y2hhbmdlIGFkZGVkIHRoZSBmb2xsb3dpbmcgbGluZXMgaW4gdGhlIGZ1bmN0aW9uICJiZGV2X2Fk
ZF9wYXJ0aXRpb24iwqBhcmUgOgrigILigILigILigILigILigII+ICsgaWYgKGRpc2stPmZsYWdz
ICYgR0VOSERfRkxfTk9fUEFSVCkgewrigILigILigILigILigILigII+ICvigILigILigILigILi
gILigIJyZXQgPSAtRUlOVkFMOwrigILigILigILigILigILigII+ICvigILigILigILigILigILi
gIJnb3RvIG91dDsK4oCC4oCC4oCC4oCC4oCC4oCCPiArwqB9CgpXaXRoIGtlcm5lbCB2NS4xMCB0
aGUgcGFydGl0aW9uIC9kZXYvbW1jYmxrMmJvb3QwcDEgd2FzIG5vdCB2aXNpYmxlIGF0IGJvb3Qg
YnV0IGEgc2ltcGxlIGNhbGwgdG8gInBhcnR4IC1hIC9kZXYvbW1jYmxrMmJvb3QwIiBhbGxvd2Vk
IHVzIHRvIGFjY2VzcyB0aGlzIHBhcnRpdGlvbi4gV2l0aCBrZXJuZWwgdjYuMS41MyBhbmQgYWJv
dmUsICJwYXJ0eCAtYcKgL2Rldi9tbWNibGsyYm9vdDAiIGZhaWxzIGFuZCB3ZSBjYW5ub3QgYWNj
ZXNzIHRoZSBwYXJ0aXRpb24uCgpXaGF0IGlzIHRoZSByZWFzb24gZm9yIHRoaXMgY2hhbmdlID8K
CklzIHRoZXJlIGFueSBydWxlIGZvcmJpZGRpbmcgdG8gY3JlYXRlIGEgcGFydGl0aW9uIGluIGFu
IGVNTUMgYm9vdCBibG9jayBkaXNrID8KCklzIHRoZXJlIGFueSB3YXkgd2UgY2FuIGFjY2VzcyB0
aGlzIG1tY2JsayBib290IHBhcnRpdGlvbiB3aXRoIGtlcm5lbCB2Ni4xLjUzIGFuZCBhYm92ZSA/
wqAKClRoYW5rcyBmb3IgeW91ciBoZWxwICEKCgpTYWx1dGF0aW9ucy9HcmVldGluZ3MsCsKgCk1h
eGltZSBUT1JSRUxMSQo=
