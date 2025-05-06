Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DE01DED60
	for <linux-mmc@vger.kernel.org>; Tue,  6 May 2025 19:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560558; cv=fail; b=PZNbwLCQGGY/23cfT/H3uNDoKVXaFcVZE7IJSeL4Ywv95NcqE6mzoDmWkFrtUqrOEWbvAcQeEj9M3+YS7nj2P8oBMebuUqYSJxl/tT8SO+k2CHcstfWDULaY7U+mg01+jZ1PDEkSMwJALwfAvtcqgU4k4r2PvVrFGp1zadRh/Pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560558; c=relaxed/simple;
	bh=fwKiTf1SP7OUckwRhmcY+eEzSocZD4Vv5b/UPAjkaSk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UUkdUbBFWDkG+YTFGtnCpqBCrHIbev34PiwNj0RocmRcN0fI82Z+KPmk/jSf44fKhi6SyQnNRf4Q/I9fUtd1M92FW4lJ3/01wsex/iXgHuasG2t5AQlj5527kimrvFfVOFtKLgzBmpWaF+50Wwkwj4vYHn1p9TfUtjCRBXV8ymg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=1zwYJGQt; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="1zwYJGQt"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1746560556; x=1778096556;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fwKiTf1SP7OUckwRhmcY+eEzSocZD4Vv5b/UPAjkaSk=;
  b=1zwYJGQtKihpbNvdgdROx3iHMOo6auS82ecOJDGZZLP3JUqcqIBYT+ni
   wwQ3cjsZRRCP+faQ9/I9J17pmyWovQ+swliDUT/TYum3bcXLdg7txml6X
   +DKI8YO+UDL2odn4nkerp3s2y5LnukYlyEdn8OykvWiZJsyF8GK4hxuRt
   YPaebq5HChrRXO5y3dz23E+VxCIJuvpgQjj9j3ZnBmzniMSJ+ogm9jdul
   3L/nj6z3UYg1+UJFxg2MPROv2CW36FbwivXgAeD5t5IslfOjWyPMo2+Mx
   uYXx8kBOFV7qpCFu/TfSQ3ZFyL1T+GtCONM0RoPgzDuG7s6SCGTOJViyH
   w==;
X-CSE-ConnectionGUID: mpN0xSfOTa+MAzaoLayV3A==
X-CSE-MsgGUID: n8w6GsQhQquyOHkVS/8aLw==
X-IronPort-AV: E=Sophos;i="6.15,267,1739808000"; 
   d="scan'208";a="81342177"
Received: from mail-bn8nam04lp2047.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.47])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2025 03:42:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hn/v3V4Aq5xeFfCKqXiiLX5ZVyVQq7aOe5EFNlKxSHGtkEEtS/cN9Fnz7jMbUf38H+v+XPJwg66QS2TSM51G0sr5Iji9Uj6tA/n4MMDrFG8jtRMfYlgBwbnBk2NKp0O3c4VMdsiPoE4EYtD2aAmMFg5gfH3AhtqX1KtZ3lywkoGlCcC4bYBkPohBUv/Vnorh+flGSIJX+7mYV8QgIUfXkBYTB9z42+kY5T+9IUYq8SRnHzfYiB+ckTQjCmpkloUknRhtC4IHxNq+joM6fSClUL3POonBp/bF8pgsC/CtquaO1/M7lhZG/F2CT06B1q8EsamhhXW1qzn3dQu1mXxFfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwKiTf1SP7OUckwRhmcY+eEzSocZD4Vv5b/UPAjkaSk=;
 b=KfRfSkV+4AvVDntDdOO7KqK9lg9qiFkaV1IdbAZjvnXBonZV4KI5k5tAmzWkSPIPjuZRWncPocbJ6op7wTYJTd3hj48ZkuybZRvHo63Sn5P5FAzJYguieLMKCgrrmoUv20BSSc/hsfVzGW/IEW5hq1d9FKL5vrOuorNUIxgDezI41avmwSMXoXz73QCYpHD0jEFDunj0uRhIvYd6HxZHDXQpw+9y+zwPpCnwfmjIyBgGpbOHNeKuQVxAGT+tmx2xgpw4oyaaqVvcqMTnp3W4TwsvX04/m6XFNqQ7rhpYQ+s69QWT+VdhkVtKqDKYl1SD+m04/f/fZTQQ3mjtYiREFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by PH7PR16MB5115.namprd16.prod.outlook.com (2603:10b6:510:2bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 19:42:26 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::436c:8204:2171:b839]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::436c:8204:2171:b839%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 19:42:26 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ulf Hansson
	<ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: RFC: mmc-utils versioning
Thread-Topic: RFC: mmc-utils versioning
Thread-Index: AQHbufIY6yy7oWpkvkaN0QBX5RMRQLPEDMyAgAE1/ACAAMcCwA==
Date: Tue, 6 May 2025 19:42:26 +0000
Message-ID:
 <PH7PR16MB61969260F3C367D70860F211E589A@PH7PR16MB6196.namprd16.prod.outlook.com>
References:
 <CABGWkvp-peEfhc57-+g+_w4DWWqdWVgw6CFF0tS7yjGsTtTufQ@mail.gmail.com>
 <CAPDyKFqWRDTqXjkb84BG=Kid+MQO_R-cJNcYFB3scnEhhsX46g@mail.gmail.com>
 <CABGWkvr2TPKkqQKYZkx7u0rhf4xyg7WNg6H7+hdpETSqv6MF2w@mail.gmail.com>
In-Reply-To:
 <CABGWkvr2TPKkqQKYZkx7u0rhf4xyg7WNg6H7+hdpETSqv6MF2w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|PH7PR16MB5115:EE_
x-ms-office365-filtering-correlation-id: 84c111e1-719f-47c6-2305-08dd8cd62152
x-ms-exchange-atpmessageproperties: SA
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OTBUTlhrYkhtMkRMUXVzQkFwN0xuK2RKcGFKREIvNXZwdmd3SmFaTFA5YUph?=
 =?utf-8?B?NkcxTGR5Y3dqVkZpS1N2WWZOZ2xGa1BzUjFiRW5mTzk5M3BtVFVNdkp1Qllh?=
 =?utf-8?B?UUdUODFpeFZnRTZiTldFM1dYa2dKMS9Nalc2d2YvaDQ5L1psanBQZmJJaDBR?=
 =?utf-8?B?MVlGaTN2Nm5laUJGWmtnZTJzMFBhZ01iRnVqMFlkT0MwOTBnMDcwWFBBaFpB?=
 =?utf-8?B?ckk2MlJ5OG9VMmZYQkg4UCt0a3VyM2ZJS3Nsa2ZtWS9hM1haQzdGbktYUWgr?=
 =?utf-8?B?MVRLTXhtbmZwSVJVaXN2aWg2d1FGUlU0eVU3bUwyQlpyNEtEY0g4Z2JSTktT?=
 =?utf-8?B?aUEvdGlCK3pWVVZTck9YV01hRW9YRmNNNjRyK1FINHR6TXpTYlR4UFowdmI3?=
 =?utf-8?B?NjBHZDN3RkZhYndKNk9vRWtsUVRiSHIweVppWFhzTEt4cXFxZGxFb2xxUTdX?=
 =?utf-8?B?elJLS1gxeGFLazZFQVdzcW5iTnVNUWJzc1pMaXJpZ2VlUkFjTjJ2SE54aFM1?=
 =?utf-8?B?WllRbnNqNzZCTEpDajBZK0NiUzNJZjR2cWllYWpJcUlmVGJFZmtiSkJZWGxq?=
 =?utf-8?B?bFZWUE1TeEJmTnV2bXBJSEUwU280RU56NzFlcXUreXd1Zm93eXhKaXZQZVZU?=
 =?utf-8?B?bHVvUDkvN3U2dmNxYkp5aVZKLzVqRDhoVm9iSWtvQ0N5enNZNWE2ZFBjR1c0?=
 =?utf-8?B?QWxySXZBYm1qbWtMYnY1dldhOGpBWjdYMTBtLzAvWFFuRkFTYTZaYmtWekN6?=
 =?utf-8?B?eUhyS3gxYTFOWGJaMk8yYnVGcDRKN2dXV2V4ZDQ2emtwSkdmK1JWVS95UUwy?=
 =?utf-8?B?MDN4Q2thbS9pdmxJcjIvZklXbE5ENmRiRjNhOHpKTzFORFVFODVvVkx1dk4r?=
 =?utf-8?B?bHhnMEdDbFlvcXcxWStFVUVvVFV4UFR1NEN2OGdSaEh6UVA1NUhZU09Gc1Rz?=
 =?utf-8?B?MzdhUWxEQ0VCbDVaUlc3K01BeDVZZHR1WDIrVXRsYmZuSUdwNVNyNzF3Nmsx?=
 =?utf-8?B?aEVrTHREdXgwMi9FYzdCNld6ZXpKaGF2eWVtRVh4aWNDQmJSZ3VDclE3UGlq?=
 =?utf-8?B?SDdhZ2ZPeDhKdndvaHhUcTFOcHZROUIxUjlFT2l0OGNGZ1F4ZXR4ZEVQb3h4?=
 =?utf-8?B?NnRpNVFlMVZzaHovQWEybmt5VWNKYVB5VGk0OVBVVkUyMTJMTjN0b0xHdFJr?=
 =?utf-8?B?blQzTzlLalhmbmFwVm5yRVhuMUQwWk56QndYeU9YNkZwKzEySTlNbVhxcTFW?=
 =?utf-8?B?d2dPdTBxMVRuWGY2UUxmckpwV283NWpPWjRUQlZ6RXliWmtLZkN3SWdpSzgy?=
 =?utf-8?B?dE4zZFFMbzlHeHU1bEFIL3c0NWU4YjhPS1kwWlUydVZGeTcwR3d1MnhyZ2x5?=
 =?utf-8?B?enl5aGkwUEVOZmEyMys5MFJnUFZGQXlROWxSUmpBcWpQcjI1ZzQvSUl1dU84?=
 =?utf-8?B?TzJ5eEpSUjJ4UklnbUlPdTI2K1lnUjI0Nm1Md1Z0VW9iL2ZmVHRqOGFhYmRW?=
 =?utf-8?B?M1FUQWJpNzkrZUtWK1RsVjhFckR2OVFlL3k0OFBOblNvc2o3ZDR6cmJGR0o4?=
 =?utf-8?B?RjV2QWlmTzNqbWJGSlZTcktFeERNQjVEMTJ0aHlzbzZNRmhVTlpzL0wrVTRa?=
 =?utf-8?B?eG9IMVJmM1ZKVlRyS0k1Ujlkb2RNR1J4cHMxZEd1UzNWTWJTQjNhMEtoa1p4?=
 =?utf-8?B?TEhCL3J4ZVU4WjQ4T1gvZU9YNmlIOEhhUXdRUHR0TGpoYzBWd1VvcUFhZ0hS?=
 =?utf-8?B?cW91LzJ5QmR4ODM5YXhLVDU3U0hnSFg0cWZaUEFqVzRHQTJMME9qa2g2RFJq?=
 =?utf-8?B?bEI1UVZQeGVubmQrdW51N21Hc3o1WnpMM2gxdmJVVWZQYnVyNmthMFRub0Rn?=
 =?utf-8?B?VjJkVjRFTHpIcUE4WENSdWFybmpHd2VLY3NRWVBXZC9VclNNNWUzbFA3YXZ4?=
 =?utf-8?B?NjdlREllVDFLOWYvTDJ5NDEvRzB4cE1XSnNKY0htS2VUQ000UXVndzhIWnYx?=
 =?utf-8?B?dFQyYU0vVkpRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cldPdGtJZnk2TXlWdlYvSzgzdjBmcmQwWXVxbXl4T1VxZEhETUZsUDhTTXly?=
 =?utf-8?B?YXo5a05BT2dpVlZ5K3RJQndUc05UYjJMS0RmcFFTYUN0UWJ0TXNuSGdCdTVL?=
 =?utf-8?B?bSt6T0NhZHdQVmRqWjZtaTJiS2IyaGgxSzhmY1FRMUlMVVREa1VXcXpqSnNi?=
 =?utf-8?B?WlVQbForS0w3anZoYUZCVUNvQzQzcUpFY1g0L3Fxa0hpZnM1VmROZUNXQ2ZM?=
 =?utf-8?B?TnVVb3RabWxBZEFEcCtCUkFkN1dpMXNkNU5paG1Td0xaZkNLS3hCWHpDVU5i?=
 =?utf-8?B?dyt0M0xXcE9ENHlOMmI1V2pOWGtjZ3VuTmZFdEV1b0EwRnBsQVJOZjhpLzNo?=
 =?utf-8?B?VXBBZGY3d1M3aHFsN1dQRWVYNHRrNTdXazM3cGE0N2FqZ2F3QkRZT1Uwa3NJ?=
 =?utf-8?B?WFgyTXladWxOMk9peFB6eWVJNkt2VHJvQUJMa3NoTGhjTEZueE1idXo1TWRv?=
 =?utf-8?B?eTJKeS83R3loWFFhdUV3UHRkNENBdjVxcUNGcnVpQitpQUd1QmR6NWNnRG13?=
 =?utf-8?B?S0pQS1JPeWN3NDRhVVBHekFoanVNTEYrdkUyOXVQOEpYSlU5UUs4bm5QQTls?=
 =?utf-8?B?OVYwU0pOTHMxMFlkVXNjWjZMbzdMN1RDS25qQlhmNWJvZC9DOHBQd3dNa0s1?=
 =?utf-8?B?Q2JGcklPcUl2Ym5WNUJRRmNMVzF3cUlyOW1Kb3dNQ1FzRzR5WXYvMi96SkFy?=
 =?utf-8?B?WUkrcE5CUmhRUTlMTGJLNnAwTU9kNjdWMlpnNUdTQlRBdi95K1lLNzNJL3RF?=
 =?utf-8?B?M1A4d3RaRklBTmkxTU44YzlTUnJIMlB1MkNXMEJnbWlVc1hHQ0lRMTZIUTJI?=
 =?utf-8?B?YWtmbXgxZ1lydFJhWUpwanEvU0ZnQThOOVZMWEVMUFJhMUljUmtzdGR1RVNQ?=
 =?utf-8?B?UWdFcGhwOWtDMkdaaVAxdWNURUdrd1djWEQwd05BNWswMmhzQmJIaUQ0ZWM1?=
 =?utf-8?B?cjVyRXRPM2ZhSzFRT01oc1pYbnF5WWdhd1Y2aUkyeHVNczRRQnN0WEpSU214?=
 =?utf-8?B?T0ZxRjFzS3g1b3BkMWdCZUJlSEtSUlVuOTVucTBLRXVOYlMya05SaTNSd0Zt?=
 =?utf-8?B?cW44YnVLRWN0dFBObHBKYnM2T2ljQm1rNVZ4ZU9nMXloUGllWXdIRC8wUmo5?=
 =?utf-8?B?emNWTkxRYnJ4Qzlvbm5mUEFKUnlpRHl0cVJ3cmhmV1RaL3QvRjdPZ1d1dGJr?=
 =?utf-8?B?RmZmc1VvSS9lTEFBNk5OdnZmRGpqdng3dmxPdnhFNEV1SzlNV3lyMm1McDM1?=
 =?utf-8?B?NElxYVVWY1Bjb2ZVanR2cm8vQWhaR0twUGhiaVVvR0ZUQmY5Mmx1aEJHdW4w?=
 =?utf-8?B?NGNZUU5NNk5OVWJ2NWdvVjJHemJVR2swTXJ3ZHprYWhVUXZuVlN5ZDNyRHhT?=
 =?utf-8?B?WW1Ec0I0NzRoTFUyNndNdDU2NnFxeExPb0RuSnlGUEt0OGowTGtiOGFmVUV1?=
 =?utf-8?B?WUxXdGRPejRZU252b1ZUNWpiVmVXbWpLZGo3eWJGM3FianZjWFFFTThscE1E?=
 =?utf-8?B?WDhzNjVrOWhuM3lLZFpFSGRNdjFSWUMreis5ZzdPOEtNMVJ3VUJNdVdRSm5N?=
 =?utf-8?B?WSsvajVVelF0aFFPNEVmTjJ4aWUydytoVTFaN1l5TkxaN3J6a25mUWNlYWs3?=
 =?utf-8?B?L3c3Z1dSMzBTK3FhOGh1MFA0SDFzWmJpMWwwSlVjSFpvQ0ZlQ0tYRVVMclBB?=
 =?utf-8?B?ZkhCYjl5SlBkbTEvbFJ1dTZCamVWRjdwMXd5SWl1R3E1ajFSVjQrTVViRjNH?=
 =?utf-8?B?NWVCWGF6YVV2OXBZWERlNDE4VDR5SS9vTVpDMW04M1NLZjZ4MVNmb3hnZ1JO?=
 =?utf-8?B?MURDS2YrWjJ5UlUwaTZSY1B1SEh6d0hoMmFXWTRaUGVzdGV4MUdoSWNGZklp?=
 =?utf-8?B?L0FFT3lIWWRxZWdGd3I3a1pML3F3a0tLWURpS1BDQmdKdWJBTnRGWDJJMzds?=
 =?utf-8?B?ZGZNbDk0Q2ViSmxYZWNCQ0NjMDRXRjFHQUNHSkJpWkJabGJiVGRQTGx5M1BK?=
 =?utf-8?B?VWsvMmNOMElnM2RFanlybzJad1BpdU9JRUdzZloxVnZnckN6Z0tqNGp4TkJi?=
 =?utf-8?B?eHh0UjRUWnlHa1NTUlpEUUlBWGptelBKUW4xZzhOQzd1Yyt6UzhTQWtwdXNJ?=
 =?utf-8?Q?b7pnZgDDZQ5py/YUSwwocNwux?=
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
	Hwf5bZ+0fJL9/49akU5ygu5P8tw2y9eetMGd+z4nrnbRBkSKUAoQOqn0lQMvbLvftwfc2P/b/J4td0y1MK8mfEW/ppk5ZeXh7jwpGynSWgYJ4OnsifnR4u2orYS0vKIfsmQRzkAG5tLRbo5E0qFJ8N/nWVC+ha98ftUS8Ydyvd4EQVxFoLuu2ciNOi8r8T4LzgHUdTC7PF1HmjTUrW7zZkStNdpsgi4tVXzYNLetcZJQ1Jq67eydyMh5PzlV+LA/EO2iuHyx8/pVP6BaB36AgTm4gtqFmoqfdP0LL7KQEp/Dy/+EsUXqbcw/2GcEClCd8XgXaaYNKwUE17LE79Btgwo2B18JYUC50qdp1S/9FFAM0Dtqdo01DQ9akKgqRIyeQk0nH8loRAYspanlfcckzs/LgYJg+2uSho9ffIp6s6werXwWH1PNtGBcESIQQCYJepVQTv+DW1oWIjghnHKhCbv1T3lXVTnGBQGAiq+8Ucxg74i2ChQqAwZXbne6oCYx/0/cN8F2uOLi3LH55ydFwihzyjFFr8phxf/M+PBRivyQu5tT2XgUt9fZ4jYjDoXYBuQ6PKVi2tida6UfSvIwVOH5wcnZHFxo+H9Oyhk2Gl4SEqg6zI8HnlXd7tov7Bs8
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c111e1-719f-47c6-2305-08dd8cd62152
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 19:42:26.5724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SgZO6tXXGWbAOFWj8S3YieuV03+W5XQJpQJ896db1BqdSz3G1Mh6HfUzYOKkxvzCmk71/nZ0z+DHdaqgZPZRNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR16MB5115

PiBIZWxsbyBVbGYsDQo+IA0KPiBPbiBNb24sIE1heSA1LCAyMDI1IGF0IDM6MjDigK9QTSBVbGYg
SGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4NCj4gd3JvdGU6DQo+ID4NCj4gPiBPbiBX
ZWQsIDMwIEFwciAyMDI1IGF0IDE5OjA1LCBEYXJpbyBCaW5hY2NoaQ0KPiA+IDxkYXJpby5iaW5h
Y2NoaUBhbWFydWxhc29sdXRpb25zLmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gSGVsbG8gVWxm
IGFuZCBBdnJpLA0KPiA+ID4NCj4gPiA+IFdvdWxkIGl0IGJlIHBvc3NpYmxlIHRvIHRhZyBmdXR1
cmUgcmVsZWFzZXM/IFRoYXQgd2F5LCBCdWlsZHJvb3Qncw0KPiA+ID4gYXV0b2J1aWxkIHNlcnZp
Y2Ugd291bGQgYXV0b21hdGljYWxseSBub3RpZnkgdGhlIG1haW50YWluZXJzIG9mIHRoZQ0KPiA+
ID4gcGFja2FnZSBvZiBhIG5ldyByZWxlYXNlLCBhbmQgaW4gdHVybiB1cGRhdGUgdGhlIHBhY2th
Z2Ugd2l0aCB0aGUNCj4gPiA+IGxhdGVzdCBjaGFuZ2VzLg0KPiA+DQo+ID4gSXQncyBjZXJ0YWlu
bHkgZG9hYmxlLiBTZXR0aW5nIGEgdGFnIGlzIHNpbXBsZSwgYnV0IGhhdmluZyBhIG1vcmUNCj4g
PiBmb3JtYWwgcmVsZWFzZS1jeWNsZSB3aXRoIHJlbGVhc2Utbm90ZXMsIGV0YywgaXMgdG8gbWUg
YSBiaXQgdG9vIG11Y2guDQo+ID4NCj4gPiBXb3VsZCBqdXN0IGEgdGFnIGJlIG9rYXkgd2l0aCBz
b21lIGtpbmQgb2Ygc3VtbWFyeSBvZiB0aGUgdXBkYXRlcw0KPiA+IHNpbmNlIHRoZSBsYXN0IHRh
Zz8NCj4gDQo+IFllcywgSSB0aGluayBzbw0KTG9va3MgZ29vZCB0byBtZSBhcyB3ZWxsLg0KDQpU
aGFua3MsDQpBdnJpDQo=
