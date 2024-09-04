Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5079A19B3C3
	for <linux-mmc@vger.kernel.org>; Wed,  4 Sep 2024 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725443709; cv=fail; b=h2DLsR5aJbGSmhi+6JrqF31t6/5cIVXJks6a9dKJ9pASYZ2WC7fvM+eITZeuO0xNAwTpbQGlaBTYDzyAMsW63mkhG9zUzXG64zxGc/i5DVCC2ZZpmrFMrDaMS6yW4NYIQ0KdZYo2c75TfH7wwANJBIqfXEKJTIl/RjNcq1WE4+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725443709; c=relaxed/simple;
	bh=vtWWythHhBlsR+UNkReOVHnKQs6rpUhOhB5RqGUxpmE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xqf6dB5bo9lmaJ7YQkDRhoH+hNqLT7VS6XrR1zZT4NRpYrsJjQEywfV1u+jTmC3V/+ofMe7cuA9mxw6BtONoBw/a1xhO0yvQe5H/d5wuGZQ1EarBAEvRqk5A0PGhNl6okAJJQEHa1d/FiAdfFpEkBe4kdDX+Uhekj/3p3CrtYRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iVWPu54v; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=lqeev9Da; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iVWPu54v";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lqeev9Da"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725443707; x=1756979707;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vtWWythHhBlsR+UNkReOVHnKQs6rpUhOhB5RqGUxpmE=;
  b=iVWPu54v3/Eq+dGWX3T/uPKOWlvVE2CdmFDGyjYkQPojTxdrXpPhuvDM
   mWQOcli13X3KfKRQaLMP6sPVokDH5vaigZtJM1wBReXIBMgSDah+JE9uQ
   0crCqeaUB2m4x1vpNuW86CmX2JOgNiD5WgJ9wq/XBJI0Pcts14jG1A8X5
   jGrUz7OvoBXYZfiWIyl9u0GCRONM32sj4w6dQJuUYgQYmOX6GlKUxxwtt
   Aqd9FRGdoRmrQ3cC+/O9Moc93HoN/pu+zOaQE37jgTlB6GlMLcREEh72Z
   1OyZCueM3lIW683vSfAJd6O7//t39Pq66TnYqspnELzOtJrPGfq+z9CZz
   g==;
X-CSE-ConnectionGUID: IJLV1IqGQgW1JfQEl4b5uw==
X-CSE-MsgGUID: h2yXVI/PR6+3LjXZfZPvSQ==
X-IronPort-AV: E=Sophos;i="6.10,201,1719849600"; 
   d="scan'208";a="26912555"
Received: from mail-bn8nam11lp2176.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.176])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2024 17:55:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJRjZ1B0Uhu2fruLLQw8o0bxuY+Zh83zl+XqYLgr6dnIXYJQiwpoO0zOZMs8mlkE+ZSAedUcsWy35PMaBgPCUlgY6p8i6qOklLtqUesX7e0XIYcZIXui9vwcLp1PQ7ReEU0YW3N6vocIYzBaABult5SM1i7f30NVmikWdTj3jOQJQ9MaDq2EmgBFLd7hpZBRNMgzWGoBlF4m6VaS/V69aDaPAPlSCwbdWbzashmNKrc4oF7MGbgofZxBCTmxFGd2kxDFeLiJKS6bukZt6f6I8eiEt7XXeIJ7VggIosbfFU9tFOqk7c9Bhk/eX+x39trJExdEB2YEh5nCzn3IXrNgKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtWWythHhBlsR+UNkReOVHnKQs6rpUhOhB5RqGUxpmE=;
 b=A7JXjDr84GiYTfnmpB/wuqMGIhXI2ouK/h+CRijMItL2kOEwBsRP5+Kh0dkoYeri4XaMLWt+qwE8JDPnhNVWwaE9OqspCeapGSY6Lko0bw4dq5gtqg8xfnFLJozSrmKogT61pEpf8dOJdmmHZiWFcmLXgBVD/YmbhAS+JvxQIgtjbpF2nRODrWW6sziQwVVtP/wXXr7zhjqsdbe7nDZCeXjtIeM1GabhS5mJjwhLgzsnUQBWChypouUfLEXcPnRBJTTO63S9ysZgv6TAFWLN3jXF44EcLL00eeGZhblu2WA01Q7Wx1QUBK2kqaXFHbbpJhiQbPcuwcqYAWT/cUd9Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtWWythHhBlsR+UNkReOVHnKQs6rpUhOhB5RqGUxpmE=;
 b=lqeev9Da18UwCR+LYQvIYF8+e6zgBaGwlGm6RquLLAVLC97oabyK/qiIUqrRBdc0mU8nOzBlt2ms3HXj857AXD3fPr5weJiVv588Cv3cwWukN2ZcFPxpwQt3XwoiAhp0+9Y5sA7QowA2H7N/14TLg2Wtj59BXi80cyfy5hHx2vk=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DS1PR04MB9557.namprd04.prod.outlook.com (2603:10b6:8:21d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Wed, 4 Sep 2024 09:55:03 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 09:55:03 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>
Subject: RE: [PATCH v5 3/9] mmc: core: Add open-ended Ext memory addressing
Thread-Topic: [PATCH v5 3/9] mmc: core: Add open-ended Ext memory addressing
Thread-Index: AQHa+HxAmR+nx/fkjE+azv7SJpSWG7JFilMAgAAxt5CAAZz2AIAAFfcg
Date: Wed, 4 Sep 2024 09:55:03 +0000
Message-ID:
 <DM6PR04MB6575EAFF1D517456F9808EBFFC9C2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240827122342.3314173-1-avri.altman@wdc.com>
 <20240827122342.3314173-4-avri.altman@wdc.com>
 <8c040805-e3cf-43d3-b806-206c3147052c@intel.com>
 <DM6PR04MB657547F546A2FF09FF839176FC932@DM6PR04MB6575.namprd04.prod.outlook.com>
 <DM6PR04MB6575D8B74C3FFE15B9AA8F9AFC9C2@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To:
 <DM6PR04MB6575D8B74C3FFE15B9AA8F9AFC9C2@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DS1PR04MB9557:EE_
x-ms-office365-filtering-correlation-id: 525f7603-9415-4c51-6e8f-08dcccc7a5d0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZUlNSzN4QkJwWkZaRERkZk94NFJGVjlaQkh5b1FuYW9ZaWpUbjR1TW9CVHpH?=
 =?utf-8?B?ZnBTQ2N4ZWFsRGxVRzVBcFdSOFBoeVRFL3VUZEJ6dXRWaWhjd0huWU52dU9n?=
 =?utf-8?B?V2VhTU9vcXdaWnVTSGJTaE9WWkUxQVZITnJPOFRLdTBLTUgwWU1mWS9SbTZD?=
 =?utf-8?B?V3c2eHJqaGxuK1o4YnFrbEJuNUllVmkrNE5hYXdBVjVQMWdkbmNQYWxScFAr?=
 =?utf-8?B?MHFQSU5Vb1lkTlpKalNwUzY5dlRMYjl5bGYzbWcxb0lnT09Nd0o3THF1NlBV?=
 =?utf-8?B?eDQ1VlpyVDE2bExyUWpncFowTnZwVE53Um55VVdzZ2NSaUIxMmVGUEsxTXdo?=
 =?utf-8?B?NVVHWlFwNlc4MFV6VWQ4SHNLR3NLMnQ1ZkY0c0NVU05pc2J3YVFSY2tRMjRD?=
 =?utf-8?B?UFdaaGtuRFBpbkYyZjJSZEwyOTZVOHU2Yno5dDBqdWt6aGVGRzQyZFlRL1dB?=
 =?utf-8?B?K2MwZTM5citLNWJWblZFbUIvNkJJU1JONmtDTGhYWTdhNFhvQkp2Q2dhSWkv?=
 =?utf-8?B?aWQ3Q0MrQUppZ0JHTDdLdUQ1bWUzeXYzUTUyRUdZdHVVazhLckFiSENtOFdD?=
 =?utf-8?B?MzQ3WThMbTkvRncrbE9FM2JZZlM2UE9lYnFKazYvekpHNmp4d0kxL2NBTlQ4?=
 =?utf-8?B?dStUOHBJek00U0R4Uy9wNlpDc2dROTdJYTNVMHdXSk9ja3oyTnJiVFNHNHVQ?=
 =?utf-8?B?MzJEek5LY3BNTGJBT0hKOHE3N1BLM0tTUnQ1TVhWdm9tdXBRd2FGRnJTVW1P?=
 =?utf-8?B?VVAzZXhqNkhZQ1dmQVI2QVJ4VDV5a2x2Y3QzaGFuQ1E4TGgzL2U4UzM5RDFy?=
 =?utf-8?B?Q05XVHVxb3V1V2lTMHdibkxpOVdKMUE2aXlRNUltZjZGNm8waVhDRUNzRHVO?=
 =?utf-8?B?OFUyeXVOamFWWGpweEhIR2ZNSWdqb05oSE1FcFZJV01EeFliTTBVZ1lVTjBH?=
 =?utf-8?B?S1AvL2FWNzFmMnowU0NhQ09ZVk56SlF1WUFkdmJmYzJJc2VaMmFUdDVTZnRS?=
 =?utf-8?B?ZjBNbkFCQzJtZHZncVljdTRzMEtNNUhERjdWV1RSQ2ZxS2o4TWxTeTNqQkdu?=
 =?utf-8?B?MUhKZ05wbGU4WXpsUC82WUFWaVBidTZUNEJaK1pVRVl3OXhQQmxrZkdaeVVy?=
 =?utf-8?B?VXc0cWM1Mis1a3lJTUdnazNEaDVDcFNWY3VIWm9mRTlaKzNyaEFTMGQ4dXZI?=
 =?utf-8?B?STNBYWN6KzRWRko2R3FnZ1pNcHJpRDBzdUtEV0kvR09ITm1XNnNCRDUvT3d2?=
 =?utf-8?B?dzMzYjUrUm9YaGFBSnowMlNjbFI2dGVRVDJVWS81UlIwUU5hN1E3RCt1Z2Y2?=
 =?utf-8?B?R2FxVThWMk80ZFB1cWx2M0swdk82dTRBbktqdjErYkpJOHdodXVvTHlXYzJ2?=
 =?utf-8?B?SXcwWEhjaEZUZGRrRkZDSkhiNWpnaXV0NE5jclQ0L005MzV5d1lRRGRmUDZT?=
 =?utf-8?B?dGU2VVpaQ25Ja1ZJNGV1THc4cnJCWTBmc2RGeVJVMEIzbzhWSThEZ0dGWDAx?=
 =?utf-8?B?anZ2OTU1bjBjU0tRWExhd0N5bWcwMk5CUFpEMi9EdjZsWU95SHZqQVVRalZi?=
 =?utf-8?B?YmJOZGhiMEo0TUVZU20rR2lYdFJHN0Jsa2FmM0tWTzhrdWhQM3Z0Yzk1Tzdj?=
 =?utf-8?B?N1JDV3FYOU1rV2tvTm1COCtXWGFYYVcyOUpINFpZS0N6MUpYWFVGMG1HeHhi?=
 =?utf-8?B?M0pOR2dBYmdPRkJvOERCTGhRUlNCRHUzQnA2SEVqOUpMUitIb0dqbHJGYnpn?=
 =?utf-8?B?WnJhZlo4bFZKTUNvbmxYdS9GV282bHJwbVlyK1kwRGsrNDlHUE5URFdtVjNm?=
 =?utf-8?B?d1dZSG5HSDJTS2MwbmZWTWQ5SDRzY3dIMkhlUEdIQWlVSkRRamhSMlRqb3lW?=
 =?utf-8?B?NkJHUnBPeDdLVWVocTJneTRYYlM1eHJNcGhCbDNSSHFBOXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ui9KVUdiN0tEeFBrM1dTUHlxa2RERkVhWU5UakFSRFZXUUI4TjBpMTZFcUlo?=
 =?utf-8?B?c1RPMVI3UXdTb2tRVnFmR2lqQWV5bHNVSG9uM08xL0J0Zjhqa1Jra3h4cjdp?=
 =?utf-8?B?ZFVwNFlZNlRQbHc5TE1ta3p0c05RZ3VyeVZsRmdQRFQ3NDJYRzNqWU5hYjhW?=
 =?utf-8?B?TzR0RHBETkpFR2JCai9OMmFrRkFEOHBleHFkWURFa3lrWXZFbGdrSTBNN1lt?=
 =?utf-8?B?RTJVQ0RqUTdrUU12U1p2aFNxQk5TbEJuODB6TmxQaTNnOW1QT0xHZ2hOT3pX?=
 =?utf-8?B?ZG41MHhpTUx3aXJ3ZmlndVVNN0p4ZWJ2RFhBd1BWdEpTVUdDYnRGL0xVMExW?=
 =?utf-8?B?YTVvZ1VPd2lDaDJmSlpxb2FxN2w3VmpFU2dFQWlOVlI3U3J6VDlYR0xueU1i?=
 =?utf-8?B?cWdnaUJ5aUpTY2pxWkxOQ1FzMXZuWGZ1L2tNdjUxWWg2L045Qm8xVnJZQkdY?=
 =?utf-8?B?L3QrTDRiUWQ3OU5IVzJRSzVUZVVna2lJMTM2NFl1T1pTN2ZsRGFNOEp1QVhY?=
 =?utf-8?B?VkUxSUFRNlpWMzZwaGdsdEdoNVptM1FtSXRaQm1tMjNLWmwzKzRrUitXb2Ex?=
 =?utf-8?B?eXpIL2FaYURqRVR6WFRaKzhrcmZzdExxclJWdWdYcE1kbDYvOTBRRTJ1RGxk?=
 =?utf-8?B?dHRMNWRTbS9uNTltcHUrSHUxK0lOdlBSN2k1cTMyeGZIT0ZkbStQemUya2Fr?=
 =?utf-8?B?enY2c0M2cnhydjRqQzl0TEZRTmM4MlNUYm1odFl4NHYrbWhmZ1FDdVJGUmc3?=
 =?utf-8?B?ZUlKNmJZWWVNc3dMUW8yU2tUc2dMNTZUQk44UmYwR2tUeDVaRmtvN3cxaXlG?=
 =?utf-8?B?WU9YK0VFbkhnN3NoemxaQTA2S1d3Zm1uU2pxb25oV1cwUmUrYWkyWlhqNDN2?=
 =?utf-8?B?cHVZanZRRE1ZS0l3ZFJSTlp4M0JZdU54ZEhwcmNScW5HelBxY0ZsTEIveWtt?=
 =?utf-8?B?cDhTeksrQTZod0tWaTBrR0F3Z1p5anlZR2gzRmdxTWdvMVBzcVF0ancvanlI?=
 =?utf-8?B?UEFYM1hnK3p1L0hZTUpxQkFNRVVBWWk4eTlCdGpzZEduZzkrS29EZitDYXFV?=
 =?utf-8?B?SnRGSjJRMDZhQ1I5NGVpRjVEdC9WRlI2ajZJSU9zbUVlVGpvZG0yU1lvMElO?=
 =?utf-8?B?MXNLbFlkdkx5ektUN3Z2MDBCNFpiUnJDTFJoVVpNNDJ4ODA1TzhHZkFhM2I0?=
 =?utf-8?B?WDQxREFDR0Z2NGR3ai9SR1NuaXNNd0xGT04yWk1KK0kxd05sdmYwRWcxdWRU?=
 =?utf-8?B?ZDNnTmIwbXQ3TGlEU054MTlORzFlaGFOQllYckNFUnVVa0dEZTRsOW5GTy9o?=
 =?utf-8?B?ajFSalNTeGUvQ1kyR2c5SzBPOHIrY29aQ2ZzejhsYk1Rdkk3M2tpaVhaMmNY?=
 =?utf-8?B?MHN1c1hjbkxwdTFTV3JTQTVMalpGMUlmWWIzcGwzVnJ4WHpNd1VyT29QVWJn?=
 =?utf-8?B?Wlptbk03TWo1c09ncUZSa1RldmNUV3pLTVQvSTI4QTlENC9WTjg1MkRqZ2FP?=
 =?utf-8?B?dkdKNW1SQ3gxU3g2WkQ2d29IODZUZkMyR004YkdQSzhXeUxWUWJSK2RURzlC?=
 =?utf-8?B?R2ovTWk3cjkvM0o1ZFFmVGo5WXVTaWdHZkw2UEM3Q3NJam82U0l0dWo4SDc1?=
 =?utf-8?B?TGszN3NtV09wT3VmaUtqT1B5RVNhaHlvQ2Q5VDFTelcxWkVVM3dSWEVDOW9l?=
 =?utf-8?B?VmwwWVZFMVNhSG81dGRIT2dsS1FTaS9rZ3ZUbVNsdytRekVuUVpxdnZoOFc4?=
 =?utf-8?B?dzBpUlJEc2laZ1g0cVV3WmUyd0FmclZSMWxKZlIrL3VTbW9DQThlYmIxd0pk?=
 =?utf-8?B?ZUpmOGQ1bUtVQXdLaXRTcDJmU3Evd0lOKzNoa2QydTZXQXFRZHpmNCt3SHhF?=
 =?utf-8?B?cEpDU0xPSUdsS0cralZyNFdCQ1A5QVJIOWtUZEtjWjlhYlBPUFQ1a055VVRt?=
 =?utf-8?B?VnRtSFMrSVU5Y1pFWHVwM3VqYndaN1VLeHNBRGZKbGZyMlV5OVdRd3dMSm5o?=
 =?utf-8?B?N1pGRzNoQzlMQ2JCN3dxM1hJNHE1ZE9XeE9aM0NQMTN4dm5HMFpwWDYrVXA3?=
 =?utf-8?B?bGsza01Qbk9ianU5Y0puUWN6emFZblg0V1VOU21tZHNjOWdKV2VUMWdIV1ZW?=
 =?utf-8?Q?Ia3TZDNMY3JJ9ngmNlBG7KyFn?=
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
	e3uiqPKNrH9GNUachEtPTYmDvMR3ito5oZwM8tpenXxzgs9lLTYIldS3VIEc/JCbICyfYxWDZTLz1AnCrlZ4Gplb5NNI8IlWD1G5VyPlxymbnzJhaoV8m8J9sC0sdyoOrpp/DCupzFFXT4SqEfiEN+ZMmfIswSL2fmpOYk3uhD9j35zETpGEHsEIxSYuKmZJVdCikZzdPDEOZuwyf50vWa5t07pvp2flkNPUZnME3McfbFOAPlolne8nU+710/yHLYu795k2OAVjNL/3/pf5OifGxm3Uzzw9BIYYU4hpT+i68aeKUuoc/8g7C6tlXd2c10bSBvZ/yZNQrGi3+cncC1+SF7eYoma4r8SscXzeJIZNgSyMTzaXXUrBEkN4WiumnD/u/SoEM6Kc9Erl9SvSdaWfKFvl9fNoMPgJ5hxEa2u2VsBVgor28OKuecKT3M5lRsE/wL1Jz66VpdhHUG5Ja9UDLsvinL8yqnQduD3zvy50rSzDpI3fVsCdhZoyGW07Vm1Maiwx2lQer/9lm6bse+ecdJCM8ljpEA/UBlItNhxEY4+iMe25HqSDUs0mY4q/LubKnpXjWW8uZXeaB/zDc3mus+w1wXvy0q/57h4jHB62+KOTFyPWNUH4ySrJNaym
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525f7603-9415-4c51-6e8f-08dcccc7a5d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 09:55:03.2177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RcigPox641CXvijAFBovAEfGfHWmCboK4kVh+Cp8a9p1WEgUscb1BuyOynjGt3dRLLllRn+y/M9nhQzApshZMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9557

PiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgKGRvX2RhdGFfdGFnID8gKDEgPDwgMjkpIDog
MCk7DQo+ID4gPiA+ICAgICAgICAgICAgICAgYnJxLT5zYmMuZmxhZ3MgPSBNTUNfUlNQX1IxIHwg
TU1DX0NNRF9BQzsNCj4gPiA+ID4gICAgICAgICAgICAgICBicnEtPm1ycS5zYmMgPSAmYnJxLT5z
YmM7DQo+ID4gPiA+ICsgICAgIH0gZWxzZSBpZiAobW1jX2NhcmRfdWx0X2NhcGFjaXR5KGNhcmQp
KSB7DQo+ID4gPiA+ICsgICAgICAgICAgICAgbW1jX2Jsa193YWl0X2Zvcl9pZGxlKG1xLCBjYXJk
LT5ob3N0KTsNCj4gPiA+ID4gKyAgICAgICAgICAgICBtbWNfc2VuZF9leHRfYWRkcihjYXJkLT5o
b3N0LCBibGtfcnFfcG9zKHJlcSkpOw0KPiA+ID4NCj4gPiA+IERpZCB5b3UgY29uc2lkZXIgaGF2
aW5nIG1tY19zdGFydF9yZXF1ZXN0KCkgc2VuZCBDTUQyMj8NCj4gPiA+IGUuZy4NCj4gPiA+DQo+
ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9jb3JlLmMgYi9kcml2ZXJzL21tYy9j
b3JlL2NvcmUuYyBpbmRleA0KPiA+ID4gZDZjODE5ZGQ2OGVkLi4yMjY3N2EwMWMwZTMgMTAwNjQ0
DQo+ID4gPiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL2NvcmUuYw0KPiA+ID4gKysrIGIvZHJpdmVy
cy9tbWMvY29yZS9jb3JlLmMNCj4gPiA+IEBAIC0zMzYsNiArMzM2LDkgQEAgaW50IG1tY19zdGFy
dF9yZXF1ZXN0KHN0cnVjdCBtbWNfaG9zdCAqaG9zdCwNCj4gPiA+IHN0cnVjdCBtbWNfcmVxdWVz
dCAqbXJxKSAgew0KPiA+ID4gICAgICAgICBpbnQgZXJyOw0KPiA+ID4NCj4gPiA+ICsgICAgICAg
aWYgKG1ycS0+Y21kICYmIG1ycS0+Y21kLT5leHRfYWRkcikNCj4gPiA+ICsgICAgICAgICAgICAg
ICBtbWNfc2VuZF9leHRfYWRkcihjYXJkLT5ob3N0LCBtcnEtPmNtZC0+ZXh0X2FkZHIpOw0KT2gg
LCBhbmQgeWVzIC0gVG8gc3RhdGUgdGhlIG9idmlvdXM6IGFzeW5jIHJlcXMgYXJlIHdvcmtpbmcg
ZmluZSBub3cuDQpOb3Qgc3VyZSB3aHkgaXQgd2Fzbid0IHdoZW4gSSB3YXMgY2FsbGluZyBpdCBm
cm9tIG1tY19ibGtfcndfcnFfcHJlcC4NCg0KVGhhbmtzLA0KQXZyaQ0KDQo+ID4gPiArDQo+ID4g
V2lsbCBnaXZlIGl0IGEgdHJ5Lg0KPiBJbiB0aGUgcHJvcG9zZWQgZm9ybSwgdGhpcyBkb2Vzbid0
IHdvcmsuDQo+IE1haW5seSBiZWNhdXNlIG1tY19zZW5kX2V4dF9hZGRyIGV2ZW50dWFsbHkgY2Fs
bHMgbW1jX3N0YXJ0X3JlcXVlc3QgYnkNCj4gaXRzZWxmOg0KPiBtbWNfd2FpdF9mb3JfY21kKCkg
LT4gbW1jX3dhaXRfZm9yX3JlcSgpIC0+IF9fbW1jX3N0YXJ0X3JlcSgpIC0+DQo+IG1tY19zdGFy
dF9yZXF1ZXN0KCkuDQo+IA0KPiBBbHNvLCBzaW5jZSBuZWVkIHRvIGNhbGwgQ01EMjIgZm9yIGFu
eSBhZGRyZXNzLCBpdCBpcyBvayBtcnEtPmNtZC0+ZXh0X2FkZHIgdG8gYmUNCj4gMHgwLCBUaGVu
IG5lZWQgaXQgdG8gYmUgYSBsaXR0bGUgYml0IGJ1bGtpZXIsICBlLmcuOg0KPiBieSBhZGRpbmcg
YSAiY2hlY2tfc2R1YyIgYXJndW1lbnQgdG8gbW1jX3N0YXJ0X3JlcXVlc3QsIGlmIChtcnEtPmNt
ZCAmJg0KPiBjaGVja19zZHVjKSkgQW5kIG1ha2UgaXQgdHJ1ZSBpbiBtbWNfYmxrX21xX2lzc3Vl
X3J3X3JxIGFuZA0KPiBtbWNfYmxrX3JlYWRfc2luZ2xlLCBmYWxzZSBvdGhlcndpc2UsIEJ1dCB0
aGlzIHNlZW1zIHRvIGJlIGFuIGludmFsaWQgb3B0aW9uIHRvDQo+IG1lLg0KPiANCj4gQW5kIHRo
ZXJlIGlzIHRoYXQgdGhpbmcgb2YgYWRkaW5nIGR3b3JkIHRvIG1tY19jb21tYW5kLg0KPiANCj4g
V2hhdCBkbyB5b3UgdGhpbms/DQo+IA0KPiBUaGFua3MsDQo+IEF2cmkNCj4gPg0KPiA+IFRoYW5r
cywNCj4gPiBBdnJpDQo+ID4NCj4gPiA+ICAgICAgICAgaW5pdF9jb21wbGV0aW9uKCZtcnEtPmNt
ZF9jb21wbGV0aW9uKTsNCj4gPiA+DQo+ID4gPiAgICAgICAgIG1tY19yZXR1bmVfaG9sZChob3N0
KTsNCj4gPiA+DQo+ID4gPiA+ICAgICAgIH0NCj4gPiA+ID4gIH0NCj4gPiA+ID4NCg0K
