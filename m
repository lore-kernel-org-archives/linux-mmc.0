Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFAE1990BB
	for <linux-mmc@vger.kernel.org>; Thu,  5 Sep 2024 09:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529669; cv=fail; b=Fy9cRnIcoS+OiYKM0F27nlMJcpMuj0kKW4o6Kg2OAewlyOcau40+LrUcSwhpQnf7csb+z8TABHvWNdYWJvktk0Cek2/WdLTeyQgcqAZQXoxpl550C3Nh6DVQomZ9AKkLDFo5Z5VHn2oEg7jgNqsFLt4s2o6bLunQeMd25lKdDDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529669; c=relaxed/simple;
	bh=jKsdj69MZY1qQz1gH6+wFJWb11bRjthZ02FMKKXAUTA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tbP0rZ7prN+87wRSW4yIUCrCEKhiZsmmQyccA0sprOF7QFf61Y6MFiPhuOpAM87XUFQVtcjDJEnQ+DOxfMl0UJYYbUp5l5rOMLgHkdGOaOZoT18/f4g38LmRrNQZ67GVBP6EdPXLruF9TUTIJl2uBjXsidCCKMJK8H56x40Bd9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GfUedUIq; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=g/60YI54; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GfUedUIq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="g/60YI54"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725529667; x=1757065667;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jKsdj69MZY1qQz1gH6+wFJWb11bRjthZ02FMKKXAUTA=;
  b=GfUedUIqaBSlN+1swl/7m9yAmEJLw8pPL7DVP4ejYaKHSDvgztJB7Tl1
   JXaH8ozI9nVp7n2cJpbY8wzlMI2mmNqVmvFkBf2jcjAU2ytTjHviBHXKI
   8GTAVNAtDgFm3gC9UE0jCl/1c6qQOvsawYGr2UNKV73Z/iIaA5cdNBzVb
   ZBlXMCTaXRpfe/LIfhgWYd+7+PFLPxTSpCUSQPGfhdAPddUEhxq6v0d32
   821NxGT5aQ4iRAGr7BIKoSyoT4JH7bPkSREqPAUzmoE1Hwz7/ql8DK3sd
   AbFv/wG3oHPz6BUb16imCjXusmT8hAiaLJX/F1JtElRlxw9oA8hLp2nIr
   A==;
X-CSE-ConnectionGUID: k4OJsVD3QEOSkQccCruMbg==
X-CSE-MsgGUID: W4zET/Y9TbOtMev/+bRalQ==
X-IronPort-AV: E=Sophos;i="6.10,204,1719849600"; 
   d="scan'208";a="26370479"
Received: from mail-westcentralusazlp17010001.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.1])
  by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2024 17:47:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kk6GPd8qySnXMCWRq/OSsBu3XY5j9QlvoIfUisc+CCBksOBHYhhHW8JtZQLlXMvpY3slM8fm4yAp2ZeFmU7zLgRmPgllbYZ63NPCzsx3vAty1G3LnokTtKOXZaxepACtDj9jao57LEGe3k1Bw567UENJSbuCwwof/Wwq+CKF2IboVWOj3lESIfyhFIaKY2pH3TfYiULZJ7D4Sw5QTmDydBdBktyFuKigp1VvxoZEu+VVSgywEgpxP5rHtAolwGdNWMbA5LoEaizSlC3VUCQAEOjMItr1cD/3rAjMyeMy6KlODzQxYLNra2tIiARfqBs/HNtJgKF4HB0Vc8IFkeyxng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKsdj69MZY1qQz1gH6+wFJWb11bRjthZ02FMKKXAUTA=;
 b=jbEsUsvdhk7vSmB+0ixqmEQ71qedF9KtqpleC2YkGU93axLDSGdvLmDYHSDcytqGeEbSRmYhFHNIXAhjOE9y2WWDdVulXmr7y/aGmBEqRgRfF6hZk6O/hshqwfqE3LdXxhnoswZh1hm6pODdDuVntfgRoKU4ZatOjph4u/ESZmJreb/dxMpxOWxrYilOekxJuwZCPgD+OG/4hhOJ/2zn1aDFTftUUXWiTq3ORB/5Hb494TC7PIBpsT16KBLpYIBsrO8PsgEU7SI/yV8tOx0DwllOrqjLJpLKADYbybESen769SJmBZxhT++UEoxVam8KHC5Z9DSK5ejZEBrb51o4zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKsdj69MZY1qQz1gH6+wFJWb11bRjthZ02FMKKXAUTA=;
 b=g/60YI54ICBDYpcBdH+ht09N1RyIIKxuLe9UPvfpYHljJZcHcnXGvgBnYw/EjO9CNlPoneC9WBVefR0nKddMMr7Q1RPLvOXBNzlVKKyDO9RutdAqPzb7+25yKi72aOGk8HGGu+SbCAjCZDiGGXH+Ekq5Yl2LnyTgY9h7v3LdMME=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH2PR04MB6617.namprd04.prod.outlook.com (2603:10b6:610:6e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Thu, 5 Sep 2024 09:47:41 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 09:47:41 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Christian Loehle <christian.loehle@arm.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: RE: [PATCH v6 3/9] mmc: core: Add open-ended Ext memory addressing
Thread-Topic: [PATCH v6 3/9] mmc: core: Add open-ended Ext memory addressing
Thread-Index: AQHa/tpuqzDYrSc/4UWqwA3ouia0pLJIMa6AgACDBQCAAChjAIAAFT9Q
Date: Thu, 5 Sep 2024 09:47:41 +0000
Message-ID:
 <DM6PR04MB65753DB2321673246E9D4081FC9D2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240904145256.3670679-1-avri.altman@wdc.com>
 <20240904145256.3670679-4-avri.altman@wdc.com>
 <1cfe2dc9-5525-43df-9d79-98472df1d3d5@arm.com>
 <DM6PR04MB65750F714B37FC40466063C5FC9D2@DM6PR04MB6575.namprd04.prod.outlook.com>
 <79dd252f-3e44-4459-bf64-4608eda377ea@arm.com>
In-Reply-To: <79dd252f-3e44-4459-bf64-4608eda377ea@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH2PR04MB6617:EE_
x-ms-office365-filtering-correlation-id: 122a1a06-8d15-4bd6-e2b3-08dccd8fc8f2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dE5RMGpadEl0bjcrWllWNUpRVHJNWHNZUWZxNElERklUUGdNWmJTOFJwV2c4?=
 =?utf-8?B?UENjLzFIZ0dqWGpIYkZpWjd6Qytwc01sanhFZElLSktLZmplRWhBS3RVMUps?=
 =?utf-8?B?VUZmN292L0hBWlZSdHk5RGJhcFVUV1NXUDFZcG5LdzZqSXhKb05vRWRMdVUv?=
 =?utf-8?B?eWk4V0Jzb3FOa21PWXpyT3RTbmxLNHROenJCODNiVFVuajVBb09HcWZuQWEy?=
 =?utf-8?B?OVhRTWpLQ3hBek9WdFhEQWlTNlVpUTVYNllpUE9tV3EreVkwZWgySGJwamli?=
 =?utf-8?B?Tk5ra21XTjhJZUR5ekh6bENvNFQ2V0xQRWtoSm9Fd2pLdERuTEhWS3RmVyt3?=
 =?utf-8?B?cFIycmlrZkt1eHI5R2E0R1FoTkYwZTZJZEVSb2lOK0JnSXR6UkFGRFlJQUJh?=
 =?utf-8?B?anFmbjYzT2FzeGh0ZHJqMkNuUTlYKzVOdW5zMVdXK0xmbmptTFdWb1IvK2Rr?=
 =?utf-8?B?bHc3T1IvVXFrWlNKNmpwbkdHYjZWZUhYV0t2STF5TlhpNzJOTnFlbE1idUp2?=
 =?utf-8?B?VmdydXhyblRseHNCckRDT2JYNHU5RHJpanl1OElLcU03L1lMblVhVFFuZWR5?=
 =?utf-8?B?aGVGYXd2L3U2V0lxZFZtWkpUTGNSZ0VwdlJUallaQU00L3RpM1B1eEhCSUFs?=
 =?utf-8?B?V2dkK1hKWG5WRW9aVWNFU2c5NVkrNmlTSk9icktVNjZsYVQ5OGNnd01XTzZv?=
 =?utf-8?B?MzFhaEp6cld4SDVmYVpld0dZN3NxRDB1RTQ0ek5POVdyZUhrZmR2V3ljdFVC?=
 =?utf-8?B?WEJMVGNzcjRLTkxuTE1XSkFVR0hna2tXYm8rRjgydTJ2VWFFYUFvNk5DWWZE?=
 =?utf-8?B?bnVUVzJ4QjdESi9tSUJheE1SaUxEbTRUa1dSNytWTFppVWdMNmFjY3dsWDFJ?=
 =?utf-8?B?Mms3WDhVcEZ1a3JZdUUxcitNSGNOODBaYkMxaUZlamdSajBYUm5BMTVTalFV?=
 =?utf-8?B?RmFuL0gzQlJkOGtLOFRCK2piM01ZZzRKVVp0eXovbEpXRGdla0VkZVRJT1gz?=
 =?utf-8?B?VjF4RUFKV3E0STJILzBXelNwdy9FdGIrcDQ0bHp0akZpbzZYaHRuZVI4Yjc3?=
 =?utf-8?B?WWQ5bzduV1ZtYjlscWpxanlVU1lnOFNMWFgvbngzVWJTbjVTM2VLcDRmY2M4?=
 =?utf-8?B?dGNybDhWb3dsenlEMi8xdlpjRFBkY0hxMVc5dVQ4ZjVYZWFMNXFFdHFwNjNu?=
 =?utf-8?B?WnZaSXZ1dkh2VDBuVG0zSVdBWU52K0I5WHlQN1djaDhzWWhzTGpiUFdoRmFa?=
 =?utf-8?B?dVVzbVBId1E1YkVCYlJ2UnRVbG5LeDhYbHN3aTV4QlB0RXJCZXdGLzlzOUIr?=
 =?utf-8?B?YTBOZEEvQjY2bHNrS3Jhc28wTm5nODEzem91UDNsbUdObEJDT0E1S3hsSmhi?=
 =?utf-8?B?QWoyd3lNWjY5U21VcVZxZm1DM21vM21IOU9DQVJWV1ZMc05tdHdBRUtIWGV0?=
 =?utf-8?B?aVRjbEZTTiszY0tKTlVvQzRXRGVrK3BqT3JzYjEzbnR5VUZUQjVhWXNsY0tH?=
 =?utf-8?B?Sk1lNFl1STBWR2ZMZEV6TGM3UklHbDN1VE1pSXZ4amtWWEtnU1pyVURuVTE1?=
 =?utf-8?B?OTVnNlhjUHd0enJCc3pCSGswYXlsVU5BK1ZQQVNGQmo1a0NyTCtscjh2RDBh?=
 =?utf-8?B?M093VmdUSEUxWHBDZEJ6aDlWcWRGT3JUd3JWYVB2cnJuVE1xdDhQTldrMDdt?=
 =?utf-8?B?eGVVUVQya2Zsa3dZaWRETWRUaVUrM3JlYlZCS0h4WmkwRGJoQStOYXd5ZExZ?=
 =?utf-8?B?UzhvUjVjQW9hd3dBcTlrSzlHSjdQTDJXcnJsMU5IcVh4emx0cGgwb1FrZkI2?=
 =?utf-8?B?QWsyeGpJK3huYUp3a1FpYzhUNkhVVnkzeXZRREFmZnhldkhGTk1VVG1yVGVT?=
 =?utf-8?B?ZERuYkJ3dldOcjJmTzI4WEVPaitUQ3VWbFVVQkt6Z3MrR3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dFFZRDFob3ZQdFdibFNRSklMK3V2dlkxYmo1Y1ExT2tlWkxDcHJjRXVDOFRT?=
 =?utf-8?B?T0hFWWpkWkN3UkR6YlJyMnIycXNkTGh0VER2b3JXZlFyQVhSc295c0dTZ29m?=
 =?utf-8?B?MXhGdHJDM0RlcW5XRW9vakVsUElwOGxRT1RxajJveG1GalZCY01JU0VLbVdC?=
 =?utf-8?B?NytySmlsd09pUzQzcXBMekNGckE5ZVBLdlRkanp4SExOWVJJUWs5Y1NWOElD?=
 =?utf-8?B?NEo3a3FuckxaNWpXZm9DOElMVm5janJRUExveXRZMzY4WlhFczY0dkRMaEtm?=
 =?utf-8?B?Z2RWTFJqenRKQmFPY3FqUmpSUHdkMFY2a1lGaVZ3RGcxbmM1blV5Nk05N3ZO?=
 =?utf-8?B?VzE0V283Rmd3MVBneTZCeWMzd0VVQkV4YlJzR2VRQ2c4N1FWV1NnNDRGRitn?=
 =?utf-8?B?WmpPOHZEZU1QVkxjVEk2emk5STNSS2ZKcmhEdmgxOER2WTlMeXNsVVhtdHRY?=
 =?utf-8?B?dGk1ZXZYSjRiRHVWVjVob1dZL2tjYjlweTdLejFvclFoTHhCTVkxQkpmdFd3?=
 =?utf-8?B?L25pbmVmQ0N0anRVNVZ3S0RkT1hKUFRzczJoZUppWWpnVGRWQmdYblMxMCtm?=
 =?utf-8?B?YlV4Y2tZZWNkVldlOVY1eFJBTVdIWkozbFN5clV6Q1lhcE9GV0xyeEpQS0JL?=
 =?utf-8?B?b3k2VG9NU0dIdGkxbHFnOTlDeFUxL3BTVG4yWFVSeDB4bmRPVTZKSEFnTlNK?=
 =?utf-8?B?dy8rVHlpTHVVdjVrQjYrVXovVDBhN0Y4bVgvTmYyTEZmY2xHQWdaVWhkWWJZ?=
 =?utf-8?B?aWtMQk5YZG9MM0JRd3RzYzdJY2RWcy9FRkVscURJNU5VamdpanZhM3pScU5v?=
 =?utf-8?B?WFM1cUgrSGNCWWRUdmFuR0ZqVDlRWlJnTnd0VFU0enFGVkNrSnZHNmJrM29j?=
 =?utf-8?B?MG44T0tFOWkvR2JEYmpVWHV6dGFSMmtIVEwzRDQrczlGRWVpVVlWaU9tK1E5?=
 =?utf-8?B?NUN1b2FMMDdDOWhBVG9iVzc0bkt2Z012a2dPL2xKUzNXLzdwWWx6NWpBMldI?=
 =?utf-8?B?TUcvWmpLeFU0SllsQkFoOEc5bjFodW05WnI1ZFRrVmJ4eFJWL2QrL0xjU3gv?=
 =?utf-8?B?M2daaFdXbVQrcEUzWWJsV21QN2J1ZytDWmFwL0Z5SWhSaVpKck5CcmlndUFq?=
 =?utf-8?B?WWNLZ1RVM3RxSThoRksvcFVLWnI5bktVMTZhUit1TzBKQklhaGNBUDR4clRG?=
 =?utf-8?B?cFNteTJtazhTK0pKbjZra2dOa21CMk90REhvT3BTcnNoUlkxWmVrZDdGMjMw?=
 =?utf-8?B?K3c1QjZ1TWp0Q3prTzM4aXk0WU4xN3dFcmg5Y0N4R2p4RXl5OExGRzl0UnpY?=
 =?utf-8?B?aDVjSExDQktmTDIzZ0dub3VDbVZ4L1NVUlFJL1g2MlRhT3lpa0JIbktybEp5?=
 =?utf-8?B?NDZWOFpsUWc5a2JtUTRyUXNwK1VudE5INkFjS0hCcFp6OWRsWEZPWkQ1M3lF?=
 =?utf-8?B?bGdlN0xLUitGODhjU0kvamUvMDBTWmZoY3U2Nzk5OEpBU1M3N3RJNHBtSzVP?=
 =?utf-8?B?YmE3QVd3WTkvRTRVZHREVS9sbU4zK21Gd0p0MjJUWHRoK1lQb3c4MlF4dDFP?=
 =?utf-8?B?cVVvSkMwR2k5RVZCTE54MHAyd1BYRGJxei9JcC9QQzMyT0oyZnhxYnJBeGxn?=
 =?utf-8?B?dmp2ckYya05YbVB3RWxHeXJkSG5saE1qcVIwYklmSE5XOEZZd1RTQzBOdy9L?=
 =?utf-8?B?T2Z5ZnNBOVRhZjdWUndsUTJnbmlSaTdIUkwxSFZoOUpZYy9zZjAwZWVTQnJq?=
 =?utf-8?B?UzFKaHBiMzBMdGc2VWcxckVrSHd3SmVpOC9JZDNXU2dDVlJyUDlVaG9lYUps?=
 =?utf-8?B?OWNsN1JFTUl5RXJ6dkhnYU1oVWtvaWpiNmNxTVFQUXFXUVJCTmFHaWNFcTB2?=
 =?utf-8?B?clVmQTYvekNxRWVsUU5kd1JDRDlvMlRSYnJ4WTBFSTBHNk96TjVKNXFna1lh?=
 =?utf-8?B?SE02WlZ0Q0wyZ0NYa3prRy9DS1c4K3hMOUdlb1l2ZlBLTXBKL0x2Nk0rc2tD?=
 =?utf-8?B?eXJaK0owZWRURkR3OEZkbUtxT3ZxNkw4dUpsaXpxL1RVNVRBWWNlSGpVQjlM?=
 =?utf-8?B?cFA5ZFlPTzJkbHlzaXl5VDdXNHN1M0pPWFo3TGN1UnBjK3g1MURZdG5kMXZH?=
 =?utf-8?Q?Jc5ib6xf5Qojk7/jCy1axpzZo?=
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
	jpQ6WWt39sm+RcuCrJ+OQfjeQWcpaFZzfnn8pTMgmP0FflOwm8JMWy+2eUgv1UuFlBTUAnzirRnSl01BONpQJIg2YYqOOyE6a6/2kTcuZLQN25f7dnssBRo97OhNj8N1X3e34AawtfGdmjHwBCzv+GK0cc0fw203+OFS/sLTpQ1fp2x/T0BU6hY3c7iAKPYkjWPqLHU/9Z/xYOqbymspXTwQkPz0HPClyjAdSSSVTE8fqkR1HER78+u4GEJSalgESd5IOe/B67iRlE4oKjfAf7kYVRNl0eNqdvz4vHBRxvpTzR2BuQoN4nk4VsSM3JdA0dmnuuNToBTHrHJSYe+9h92oP44w7ymy7Zt0ERD0PVewQoIIsNl8Q2b5s42PTjfWEdF73Tsmg6WXFnyvL1Gyb9ez06luiJEEg8W/zi0qSwAnVKlNbNZpEuGRnSbNq8RztCyQHNKjxZoJqtqNMbxu1Rp9V8++ktyGQDkR2ndflpY8gbJzpyvl+r3ZCnBa59GqYrheSOABeSXC812qf9KHm3YsoIutCRO/JemdjoESWv5DZX2NFxH2BZ9b0coEHc4wKmoXDaJ468NL5P+WdGgpdN+16JciKsNjhWYxQW+7cZFvqyDPzf0Sy86vrfKJnzsf
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 122a1a06-8d15-4bd6-e2b3-08dccd8fc8f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 09:47:41.4942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cbe2cjDFi4yCJfiq13igRLaFmNGGLoc5dsNqFWH/gHSWgI18DzPWPwKWlDrTViGd6WPqCwZcV+8b9hoDxTEqfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6617

PiA+Pj4gKyAgICAgLyogZm9yIFNEVUMgKi8NCj4gPj4+ICsgICAgIHU4IGhhc19leHRfYWRkcjsN
Cj4gPj4+ICsgICAgIHU4IGV4dF9hZGRyOw0KPiA+Pj4gKyAgICAgdTE2IHJlc2VydmVkOw0KPiA+
Pg0KPiA+PiBJcyB0aGVyZSBhIHJlYXNvbiBmb3IgaGFzX2V4dF9hZGRyIGJlaW5nIHU4Pw0KPiA+
IFRoZW9yZXRpY2FsbHkgYSBzaW5nbGUgYml0IHN1ZmZpY2VzLCBhbmQgc2luY2UgZXh0X2FkZHIg
dXNlcyBvbmx5IDYNCj4gPiBiaXRzLCBJIGhhZCB0aGF0IGJpdCB0byBzcGFyZSBpbiBleHRfYWRk
ciwgYnV0IEkgc2VlIG5vIHJlYXNvbiB0byBiZSBjaGVhcCBoZXJlIC0NCj4gc2VlIHRoZSByZXNl
cnZlZCB1MTYuDQo+ID4NCj4gPj4gV2hhdCdzIHRoZSByZXNlcnZlZCBmb3I/DQo+ID4gTm90IHRv
IGJyZWFrIHRoZSBwYWNrZWQgNGJ5dGVzIGFsaWdubWVudCBvZiBtbWNfY29tbWFuZC4NCj4gDQo+
IEZXSVcsIHRoYXQncyB3aGF0IGl0IGxvb2tzIGxpa2Ugc28gSSB3YXMgYSBiaXQgc3VycHJpc2Vk
Og0KPiANCj4gcGFob2xlIC1DIG1tY19jb21tYW5kIHZtbGludXgNCj4gIHN0cnVjdCBtbWNfY29t
bWFuZCB7DQo+ICAgICAgICAgdTMyICAgICAgICAgICAgICAgICAgICAgICAgb3Bjb2RlOyAgICAg
ICAgICAgICAgIC8qICAgICAwICAgICA0ICovDQo+ICAgICAgICAgdTMyICAgICAgICAgICAgICAg
ICAgICAgICAgYXJnOyAgICAgICAgICAgICAgICAgIC8qICAgICA0ICAgICA0ICovDQo+ICAgICAg
ICAgdTMyICAgICAgICAgICAgICAgICAgICAgICAgcmVzcFs0XTsgICAgICAgICAgICAgIC8qICAg
ICA4ICAgIDE2ICovDQo+ICAgICAgICAgdW5zaWduZWQgaW50ICAgICAgICAgICAgICAgZmxhZ3M7
ICAgICAgICAgICAgICAgIC8qICAgIDI0ICAgICA0ICovDQo+ICAgICAgICAgYm9vbCAgICAgICAg
ICAgICAgICAgICAgICAgaGFzX2V4dF9hZGRyOyAgICAgICAgIC8qICAgIDI4ICAgICAxICovDQo+
ICAgICAgICAgdTggICAgICAgICAgICAgICAgICAgICAgICAgZXh0X2FkZHI7ICAgICAgICAgICAg
IC8qICAgIDI5ICAgICAxICovDQo+ICAgICAgICAgdTE2ICAgICAgICAgICAgICAgICAgICAgICAg
cmVzZXJ2ZWQ7ICAgICAgICAgICAgIC8qICAgIDMwICAgICAyICovDQo+ICAgICAgICAgdW5zaWdu
ZWQgaW50ICAgICAgICAgICAgICAgcmV0cmllczsgICAgICAgICAgICAgIC8qICAgIDMyICAgICA0
ICovDQo+ICAgICAgICAgaW50ICAgICAgICAgICAgICAgICAgICAgICAgZXJyb3I7ICAgICAgICAg
ICAgICAgIC8qICAgIDM2ICAgICA0ICovDQo+ICAgICAgICAgdW5zaWduZWQgaW50ICAgICAgICAg
ICAgICAgYnVzeV90aW1lb3V0OyAgICAgICAgIC8qICAgIDQwICAgICA0ICovDQo+IA0KPiAgICAg
ICAgIC8qIFhYWCA0IGJ5dGVzIGhvbGUsIHRyeSB0byBwYWNrICovDQo+IA0KPiAgICAgICAgIHN0
cnVjdCBtbWNfZGF0YSAqICAgICAgICAgIGRhdGE7ICAgICAgICAgICAgICAgICAvKiAgICA0OCAg
ICAgOCAqLw0KPiAgICAgICAgIHN0cnVjdCBtbWNfcmVxdWVzdCAqICAgICAgIG1ycTsgICAgICAg
ICAgICAgICAgICAvKiAgICA1NiAgICAgOCAqLw0KPiANCj4gICAgICAgICAvKiBzaXplOiA2NCwg
Y2FjaGVsaW5lczogMSwgbWVtYmVyczogMTIgKi8NCj4gICAgICAgICAvKiBzdW0gbWVtYmVyczog
NjAsIGhvbGVzOiAxLCBzdW0gaG9sZXM6IDQgKi8gfTsNCk1vdmluZyB0aGUgc2R1YyBtZW1iZXJz
IHRvIHRoZSBlbmQgbWluaW1pemVzIHRoZSBwYWRkaW5nIGZ1cnRoZXI6DQokIHBhaG9sZSAtQyBt
bWNfY29tbWFuZCB2bWxpbnV4DQpzdHJ1Y3QgbW1jX2NvbW1hbmQgew0KICAgICAgICB1MzIgICAg
ICAgICAgICAgICAgICAgICAgICBvcGNvZGU7ICAgICAgICAgICAgICAgLyogICAgIDAgICAgIDQg
Ki8NCiAgICAgICAgdTMyICAgICAgICAgICAgICAgICAgICAgICAgYXJnOyAgICAgICAgICAgICAg
ICAgIC8qICAgICA0ICAgICA0ICovDQogICAgICAgIHUzMiAgICAgICAgICAgICAgICAgICAgICAg
IHJlc3BbNF07ICAgICAgICAgICAgICAvKiAgICAgOCAgICAxNiAqLw0KICAgICAgICB1bnNpZ25l
ZCBpbnQgICAgICAgICAgICAgICBmbGFnczsgICAgICAgICAgICAgICAgLyogICAgMjQgICAgIDQg
Ki8NCiAgICAgICAgdW5zaWduZWQgaW50ICAgICAgICAgICAgICAgcmV0cmllczsgICAgICAgICAg
ICAgIC8qICAgIDI4ICAgICA0ICovDQogICAgICAgIGludCAgICAgICAgICAgICAgICAgICAgICAg
IGVycm9yOyAgICAgICAgICAgICAgICAvKiAgICAzMiAgICAgNCAqLw0KICAgICAgICB1bnNpZ25l
ZCBpbnQgICAgICAgICAgICAgICBidXN5X3RpbWVvdXQ7ICAgICAgICAgLyogICAgMzYgICAgIDQg
Ki8NCiAgICAgICAgc3RydWN0IG1tY19kYXRhICogICAgICAgICAgZGF0YTsgICAgICAgICAgICAg
ICAgIC8qICAgIDQwICAgICA4ICovDQogICAgICAgIHN0cnVjdCBtbWNfcmVxdWVzdCAqICAgICAg
IG1ycTsgICAgICAgICAgICAgICAgICAvKiAgICA0OCAgICAgOCAqLw0KICAgICAgICB1OCAgICAg
ICAgICAgICAgICAgICAgICAgICBoYXNfZXh0X2FkZHI7ICAgICAgICAgLyogICAgNTYgICAgIDEg
Ki8NCiAgICAgICAgdTggICAgICAgICAgICAgICAgICAgICAgICAgZXh0X2FkZHI7ICAgICAgICAg
ICAgIC8qICAgIDU3ICAgICAxICovDQogICAgICAgIHUxNiAgICAgICAgICAgICAgICAgICAgICAg
IHJlc2VydmVkOyAgICAgICAgICAgICAvKiAgICA1OCAgICAgMiAqLw0KDQogICAgICAgIC8qIHNp
emU6IDY0LCBjYWNoZWxpbmVzOiAxLCBtZW1iZXJzOiAxMiAqLw0KICAgICAgICAvKiBwYWRkaW5n
OiA0ICovDQp9Ow0KDQpJIGd1ZXNzIEkgY2FuIGRvIHRoYXQuDQoNClRoYW5rcywNCkF2cmkNCg0K
PiANCj4gaGFzX2V4dF9hZGRyIGFsc28gc2hvdWxkIGJlIGVxdWl2YWxlbnQgdG86DQo+IG1tY19j
YXJkX3VsdF9jYXBhY2l0eShjYXJkKSAmJiBvcGNvZGUgaW4gWzE3LDE4LDI0LDI1LDMyLDMzXSBi
dXQgdGhlIGZsYWcgaXMNCj4gYWxzbyBmaW5lLg0KPiANCj4gSSdtIGEgYml0IGhlc2l0YW50IHRv
IHB1dCBteSBSLWIgYnV0IGl0IGFsbCBsb29rcyBwbGF1c2libGUgdG8gbWUgRldJVy4NCg==
