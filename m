Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42061779A5
	for <linux-mmc@vger.kernel.org>; Thu,  3 Oct 2024 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727973832; cv=fail; b=IbQvR6prr5h1WplrbZU1W26AbKoZDrhQnfK11WZj6VXPIuCXoSCHTOCZ1CBRYWgMDTTt37CdUnqGp1X8prul1sgYH/JMbN9HcszRTWN9GEgEIIHZMWADZWDBqxligrk6M5bu1Qv54vu5RIzZnZIpo6L25j5J4E4VGgR1sj2qDUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727973832; c=relaxed/simple;
	bh=H7lyPrDe4fMiJdbe5ODrZ0+kvWfHUjjLVdeyVIHerEA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LtihLk2ScnCfWgO95ydwOA/GK+uwxZZ9Z2W4LsakdkCLOzJueU4MhpIHU4QqH2Q7ZF3KjxH1dS7rtTEfZBU1vC/kTJDxMzfKII8SmSlrxUO2bqTqyOdwTVnakkKN/53/3YgvY7DWaIxF5QParVgdDyv9oGpOSZMIydinhF0FSpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PJkls+fO; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=JewiyF/3; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PJkls+fO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JewiyF/3"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1727973831; x=1759509831;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H7lyPrDe4fMiJdbe5ODrZ0+kvWfHUjjLVdeyVIHerEA=;
  b=PJkls+fOzEUYURWLWjlIW4Ix0oLxLdMtwN41tnFHLszYnhL/qNXDVMeK
   GUNXzvEJCq8A0Pgjy9/c4YczXtyS6mzat9QDxBLOqcQ98DyLiH9H7Cgw1
   kdqFOwWyM3i8uMVUg23rctCa+q8gGH5obcb2T1aF/YYaLAQf+pdFz1V1K
   dLwNoJ5VOADuj1CMwfeIRPsQ0URGzt2ooEjzOx7FtbbwoJp/hj3exhG1M
   Fi6lLHtEgxHmXfvesQgFIggJak0fmYucx5vNrxidknXXEi+1Rv9j3m4v5
   73mBIm5/TUxT6bR0MqY5E2qzPahDzCEepa2IkqHhBYjSpvkxgCv/HocEh
   w==;
X-CSE-ConnectionGUID: C/79u6rTQiyxLHjF2ZXEfw==
X-CSE-MsgGUID: lAHWgOuXTDO4YpzIJipgjw==
X-IronPort-AV: E=Sophos;i="6.11,175,1725292800"; 
   d="scan'208";a="28248691"
Received: from mail-eastus2azlp17010002.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([40.93.12.2])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2024 00:43:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wl39YqPmh2skihbouIsc0D1fS8JFEtArqB1K5hqn4ERi1qMv1jdi/p4NZXsu4PVM22l6sJBRX5InSPyu55uX1c2hg5+tvnBmuT42WU0wWzLSKycG65U+Iyek/ZaVmCzVHy75sY7jArT44qKy7KLW+arybWSmmijPsB0zEvsJ5go9B59kRZgQLtiIluTHwNuT+aw8sUSW17tabRm2iAJrNG5aBUW0Mbc7EI/n9gIT97RGjI/z77Arhx9SDepTvgXs3IYHBBIKxvSl6in3tIZn62s4Xiqx6J8p0MsWKFGa8xh5gN0Na2rVwbSbDAAqpWCMn8jdcJ+58va5sfrGpn2g2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7lyPrDe4fMiJdbe5ODrZ0+kvWfHUjjLVdeyVIHerEA=;
 b=IX205rfvYww9Q4+xLZLNaT90oy2eQk315rYEl1lQvx++c2VThOkPZIMuFMU3swMPwOlJeyOjakQq57rrET7HyUi8n7h2e51dwzq7y/hmaMOLX7eVbyNdxFg+FUWLO2JYwfh3rm00IPD5XR/f+gJWCtF8PqdiaC5oeYOA3OdoSCL3iL2fNw9HklQV9DZ5TgF1bDSYgU8TlKo8+F5vKQVtTjQ4GJNJ1mlH3rKMspOyR6AU8AIUrBOi4ah0zstUGH5R59rAZe8pXJUzwPYr7sMXszh2vXw6Bwlb3vNb6u8SxkJebmGPzaLlUb7/09EZico+nHHF99pIAzpLWLdLIFRVBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7lyPrDe4fMiJdbe5ODrZ0+kvWfHUjjLVdeyVIHerEA=;
 b=JewiyF/3a0FY3hr/I+46U3x35f3SN+OV+lA9ngI512Ckdi4L3v638A2Bq3r9q4dUHvXmuLlH3dMyiiGb36sGNpT+HfPCBh8XDMS6bswsO7u7avRcJNsheBa7leSwunc2idJdV8ey8H/xVdmlTFqGXEJ7PhSYwD7Pv9kw3AUbcKA=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CO6PR04MB7875.namprd04.prod.outlook.com (2603:10b6:303:13c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 16:43:46 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%6]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 16:43:46 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter
	<adrian.hunter@intel.com>, Ricky WU <ricky_wu@realtek.com>, Shawn Lin
	<shawn.lin@rock-chips.com>, Christian Loehle <christian.loehle@arm.com>
Subject: RE: [PATCH v7 03/10] mmc: core: Don't use close-ended rw for SDUC
Thread-Topic: [PATCH v7 03/10] mmc: core: Don't use close-ended rw for SDUC
Thread-Index: AQHbAdj+8mcMGbU+ZEez1XagySjilrJ1Un8AgAAQiXA=
Date: Thu, 3 Oct 2024 16:43:46 +0000
Message-ID:
 <DM6PR04MB6575999D16F0A2771A6B6C1FFC712@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240908102018.3711527-1-avri.altman@wdc.com>
 <20240908102018.3711527-4-avri.altman@wdc.com>
 <CAPDyKFo0UfP5_tKykRq7fwqDdQxnKETDia-21h-=0nY-0mkPrA@mail.gmail.com>
In-Reply-To:
 <CAPDyKFo0UfP5_tKykRq7fwqDdQxnKETDia-21h-=0nY-0mkPrA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CO6PR04MB7875:EE_
x-ms-office365-filtering-correlation-id: 2049fdb2-1d42-4b51-7696-08dce3ca8cf6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TXlwc3d2aHBHVjJkcmV6TVVpYXo2NDhQd0JCNTNzV21DZ2Y2b1NsT2hlY21L?=
 =?utf-8?B?WVViK3Juckw2M2hsQnBYRWV4ck5IZ3FOT3pWalM1ak0zOWRrV1JaMEd6NGNk?=
 =?utf-8?B?ZThROWlUbENUTEhqZzU4RVBDRHU5Ukw1dTdMT1cweTZrMUNyYUhiY21SSmZJ?=
 =?utf-8?B?Z092R1c2U0NCRHFuMUNIK3FGMFRtSzVtRG5iTFNja1pVd1VhcnpGdEpMUFNz?=
 =?utf-8?B?b3B1bWFNcHVhclhBdDNObmp3VUp2cG9nSDFDWW1PNGl0NllOOFNoK3YxZ1c4?=
 =?utf-8?B?NVJvR3cwRFVxaHNreGJmTmxSWW45SHlvcGxIejBmQitiZDhBOUdaOWRxSmZX?=
 =?utf-8?B?UThvZmtuUGxja1duRW4wVnVncUo2bENJbjZjUHZPZzNLbllRUEdLS3ViRE5X?=
 =?utf-8?B?R0M5eEd3L01zenBITHZpb2lMeUhUdVhBSFJHT2dNVGxGb1gxNjQwalFtNklH?=
 =?utf-8?B?QnJhR2dQS2prR2pRNG1tUXhYYzFLcmVlZDcycTNTZjdSdEJ4SFFzamROanJo?=
 =?utf-8?B?TUtrRFBTa2tWRSsrVGtEU3dFN05HaVZ3eHVEOTRjYjZ2NU5lS2ZRN3RQRmpG?=
 =?utf-8?B?RVl4OGdRUkR6ekU5b1VCMXRnRDNPNmVBdnQrbVZxSUhMVFdRNHN4NzR3RTlB?=
 =?utf-8?B?bkVsbFJGSDZIVHZPZHNWVmVxMEJjTDF4YSsvSVNQNWMyOGt1SzFVYjBMa2NQ?=
 =?utf-8?B?SkVvWm9kOHZQYkhKd05IN1VSUnZodXU2K2YwSWpyeDFtai9odUdKeEIvdzZY?=
 =?utf-8?B?NTQrblZhMlZIZndYdzdTdVZ6UDZ2T1lVQUk3SSt3eFREbEtGSC9nMUREQmt3?=
 =?utf-8?B?NmlPcDU0dVNrdk42MmtlQUFzWkxzK1JUWUFmQXpINFRjdG93QnlkRDhmZmE2?=
 =?utf-8?B?YjJONnFWdHRMYXA0UHhNTE5nU2I2bHBLV2FXR2VPQjBGQjRqV1RXY0pSUFFu?=
 =?utf-8?B?WU82THgrbUczQ1QzWU1rRm5TNzRvZ3J6ZlM1MEpwVGMvL0VsTmZIVERqVDBk?=
 =?utf-8?B?bFJETklnMk80THVnU25nTWJBdnl5Z2lOMk04VjBsSUVNSG9yd3IvTUhPQllv?=
 =?utf-8?B?amtKY1JTdGhsNVFDeHEzVzFYSDViazRSRFNZNWt3alEwZ2tzd1JKMDE0Slps?=
 =?utf-8?B?bkFwSDBIVS9yVjRveHB5cmpDbWZmYjZMK00vQjFPVlM5Ky9oWnNPMmpqaVJo?=
 =?utf-8?B?ZmRxaDFRMmxkajNtdm9DTnFPbi8wYXhVL1lKRjFmUkNHdUZuYVg2aXd2MHdx?=
 =?utf-8?B?V0dnMUJCdmtIeHVvRkFhV2FXS2ZxUzI5N0VOK2VzaGEvWXR1R1F0VVYwcnNR?=
 =?utf-8?B?eFJaRmxmcWJ6U1hydUd2MlVld2JFZEYyeGUxM1Fnb0tONTJiL25sTEpNamRT?=
 =?utf-8?B?UitWWVlpM0JmOEF6STRvY3Zwdk1CMW9NRFVsSVNDT3oxQVpRSkVXdk0zQlEw?=
 =?utf-8?B?NHVxMnp5WFVVa0kwcUlvTGlFZWJFYk9oVTdrc1U3QzYwU3IyY0J2Q3JPcGpi?=
 =?utf-8?B?NnA4UkVUZFk1ZWJtSkxUMVZrZWE3UDc5M2dIZ25KbkRDVGdkNTlUekVVM2dZ?=
 =?utf-8?B?dCswTllpTmRSZTMwQmR0dUYwdkhVYnAvVzdpcHp1Vk5FM1M0OFBNS1djbXBI?=
 =?utf-8?B?MDQ2am0vZnpaVlgwN3VVNlJDdEcvc1hwaXZzQ1pBaFFMZGpJS01CYXpOdHRo?=
 =?utf-8?B?LzdwaXdCekRYRkptRnlXTDZCcjlnLzVqeUZPNnFpcXp5NFVyZ29RVGkwZmUv?=
 =?utf-8?B?VFFLVWkxUWVpb1BxR3BUSHVXUEZQZjh3aXlCTzdQbHQraitnYjhNQ0pOZnB0?=
 =?utf-8?B?NFIxbzl1Qno5TlZWaWdZQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VnY0bjBpYWtKb0Q3cldwd0F6QlpieUIzVzBSTXJvRzhZUld2TSt2a0gvSGEy?=
 =?utf-8?B?Qm1LNzVIbENXWXJScUM1OGtpZ2o1ZG41MTMyYzNhOEVqSExqQ3FHOHJmSElL?=
 =?utf-8?B?cTI4UWVNK2paVlVwQngxZllKam1VZlZjQUgxS0FNUy9yeGdwVnpBWS9JR0w2?=
 =?utf-8?B?K2s4OUw4bzFCakhSektjRThEQ1V4cEtUYkFVWmpoeERBODhrd3RmRlc4TlBi?=
 =?utf-8?B?UjBTMVJON0lSOHJXMkVSYzB1QVZVTzkxT045TFFCOUVMR29ETGdKVXAwT3RL?=
 =?utf-8?B?enU0MmdleDNqRzlLME9ITS91UmVtSUVVOWw5RjVJTkh1MVJmWXNtcmRqVFVM?=
 =?utf-8?B?bGRhY2JKeGlxNkVrNWQzMmVrVStPbU5BOU1ubkJQMWVWTUtObWRJaGxjS1hM?=
 =?utf-8?B?MFY0SW0zSnExN1R0aVZnYkFSU0c4YTgxdFcxUkptWXYwZ1FrcWxLNVVHdy8y?=
 =?utf-8?B?YjhGRVQ1Zlo0THEwQTBYak96aW4xZW5nTUlFd3pIYlZldDh2YXBJTXJhcHp3?=
 =?utf-8?B?YXZTS3F1NjgrMDhqaExEbUZWc0R5NHBnUklpZnpSOWdjK2RBaUtMc1ZmVUlp?=
 =?utf-8?B?ZXI5WURtQ3RZUDkxVkRzV1hHeXNCZXU1SWx5ZjZZU1JqZ2VYNnVXL3JjZ0Ru?=
 =?utf-8?B?QTB6TFd6NElJQ3E5c0xmeTZpTHFyaTMxNXBnd1VPRmJVMDFkSElxdkgweHBl?=
 =?utf-8?B?R3AxNGlpV0ZDMGpKUVhZMUNHWTQyUk9xdWNCWE5uSG5IZHk0aFpHQ0tFRVU4?=
 =?utf-8?B?WGJYVzhtOXd2bkFzSysxYUIyMm0rbmxRYUwwQkluQ3M2QzNQM2pqMkRWcHJ4?=
 =?utf-8?B?SUZBUW94V3JHNEdLbU43NGJVZmY5RHNOS3FOaDNYcGtzZUFOM2NpcG12eWFB?=
 =?utf-8?B?TjllanQ3V3ROU0hLSWUwYksrZW42NmovSW9IdWk1dHdQVHVHZUpmanlHRlFL?=
 =?utf-8?B?ZWU5YXNlQlBJaFJTZktFTG0xNmpiYmNEdkQ0aXVNSzlvVzU2RjhmbUV3NjZG?=
 =?utf-8?B?N0k0WFR6YVltOXV3OStHbmtuSWNNVkU1ZDNZdjdEaHF0bXU3czJtdEMrTGdz?=
 =?utf-8?B?YWYzY3hwMXFKVWhNMmdaaytJS3ZzMS85bVBWUk10OUpsOWUrWTM2Z0lSZDB2?=
 =?utf-8?B?LzZPSnk3SG4wME5BSmQybDhoUWh6OXZiSHh6bGlHWW1rbGFKOCtpZm1naExn?=
 =?utf-8?B?UWhpQVBpdjZ3a3lNZTQ4VzdyTGxzSEloSWRsaEp2TnBLYjRZNjNpQm55dFVW?=
 =?utf-8?B?YUFnK3NpWVcycTVYbUxXMVhUazhvQzVEQVZrcXpxb2JGUUtmWHlOUnFLRFZs?=
 =?utf-8?B?RlZNNzRGQUFPeDFoTHl5UTBNRnVUdDN2bHpYQlJEaklwTGtKYW5HY0RLbXlO?=
 =?utf-8?B?V3I4eXp5cnJ2d25wQUtuNjBxanZiMFBnWmFOdVNJZm9MVEZ4L3Y5VmdVRGtB?=
 =?utf-8?B?QkROTTE2eUhna21nL2xNR20rM1hiOHFNWUFMQU5hZ1M0T3BLdlB2akRZV2t4?=
 =?utf-8?B?UENkTGF4S1ZQTyt6Z1NzM3BSbjdvNzc1Q3BvTzhpTjVIOE1laStJNy92a29R?=
 =?utf-8?B?QnFGMTByS24rZUFuREtSaGhLeDFpRUpOZ1pXL0ZHa2h5YXNyZXhyOWZTcGF2?=
 =?utf-8?B?a0F6emJUQ1hqbUdWVVRENzM5S1hleWpaazVETGg5Zlc1dHcwYzUyN3ErRGtP?=
 =?utf-8?B?cmZlY1duRjNyaHFzcjF3S2RIN3VaSUx4KzBtdmZRanZjZjI3ck9aNGFKZ3Ro?=
 =?utf-8?B?UmI5YktOOUZ4VkFrRitXMm4yVTVLOVNqeDNuVUJOQk9yeG8yWG9DeEhBTVVh?=
 =?utf-8?B?clFuVWJnY0g3V0hTa2duNS9YeUhJTkxMdzJDN05xUmtWTnBRdzM2aDN6SURY?=
 =?utf-8?B?SXJVZUpORE53OE5oRXNGK01zWTR1RjI4dUVZQTJvM1hKYUtGakl0UlZ3S0Nm?=
 =?utf-8?B?QUpPdUFTT0tUWUVGbTZ6OW5NTEk2aFBpSHBST0RFcU4zTmZXbG9IazdTdExZ?=
 =?utf-8?B?YWtMSTJSdzZ0c3F2UU5iUExIYWtWVEdReFZFWEFuTVBRRy91OE9nSWtJTlZX?=
 =?utf-8?B?d2FKRXJqcUVKOG9DQ0h5Nm1ZYUFQYVBDVHhyb0hFbEs1RnpQVHpwSnY2OHc1?=
 =?utf-8?B?R1FnK0oyQXhscUdkTlUxc0NDQnEzcFJBUjV1L2FmUiszbVd6WmNtSU51TjBR?=
 =?utf-8?Q?0R92V903QttecsdtuGlBIvM9Lis+ahFoMyaitiZBv5PI?=
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
	gIid7L3z01llPDZkMNyKl9FKxhUXF6ARzHANNTBhvlyR0U7ALLscqd6Qtyj+H0ucRcQN9IljKLDFyidlUnPUNUko7h8DNl49EuSLqfGXe8A+5IlCckFVzP5MUD+tj1hbifyfv33C1pKqrBLH5tNNcrylEyHURe0xAnDKLF8/z/CIfgVXKc0oS59Bhh2xyblpFgg81pcl6sXJoR7v0Gvw3p55s95rhMOBQDkQJsEnq13n9K/TEPRBz+LwVbKsWl+LTHfbtjroVRAJReTm1ZYQi2v9v/qwpBVDAn3JqCLSyaJAVYJ7vw3ilDXxMhvVZ5pNVkhYqipcUSmX0rRg+IMFSfcFcbUK5/SQ8whzlgH0DQAOLHuqTuCFQfKBLDTsbiSqDg0SzLTQGOgluIR6eDiejwkkQdu4/tOJ+s5yk/pphJ9dfgRaNnX1+oRaWgmgOvPb7vwqbXR9O6DlaFgxambKqgRHzL14EXcay0peptb99FgWup03rIDpOgVNgAmr9e0WaL5J0zpf0g3iGji1biOA/Fh3P8vLr4LckRIhWScggmrV6ji7TuCAe2hHEa0A3t48IP/9Zvdua0UPRmpoNPlAlCFN2fWCa/NLd1+iHRUdtCMvIoKEZ8oJKn4tSpf+P7ea
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2049fdb2-1d42-4b51-7696-08dce3ca8cf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 16:43:46.7141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hZqsJzkTt8jIRqS78wSNHFwwJ7cEHk9XNFP7QLBfjSBWImS9Id1nFvX2iBg8mA/cp2WnZbWROUiTUtJjfPYIRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7875

PiBPbiBTdW4sIDggU2VwdCAyMDI0IGF0IDEyOjIyLCBBdnJpIEFsdG1hbiA8YXZyaS5hbHRtYW5A
d2RjLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgU0RVQyBzcGVjIGV4cGVjdHMgQ01EMjIgdG8g
Z2V0IHNxdWVlemVkIGJldHdlZW4gQ01EMjMgYW5kIHRoZQ0KPiA+IHJlYWQvd3JpdGUgY29tbWFu
ZCwgZS5nLiBDTUQyMy0+Q01EMjItPkNNRDE4IGFuZCBDTUQyMy0+Q01EMjItDQo+ID5DTUQyNS4N
Cj4gPiBBdCB0aGlzIGVhcmx5IHN0YWdlIG9mIGFkb3B0aW9uLCB3ZSB3YW50IHRvIGF2b2lkIGFu
IGFtaWQgc3RyZWFtIG9mDQo+ID4gZml4ZXMgJiBxdWlya3Mgb2YgYm9ndXMgaHcsIHRoYXQgdGVu
ZHMgdG8gYXBwbHkgZXh0cmEgbG9naWMNCj4gPiBzcGVjaWZpY2FsbHkgYXJvdW5kIGF1dG8tY21k
MTIgJiBhdXRvLWNtZDIzLg0KPiA+DQo+ID4gTGV0J3MgbGVhdmUgY2xvc2UtZW5kZWQgb3V0IGZv
ciBub3csIGFuZCByZS1jb25zaWRlciB0aGlzIHNob3VsZCB0aG9zZQ0KPiA+IGNhcmRzIGJlY29t
ZSB1YmlxdWl0b3VzLCBpZiBhbnkuDQo+IA0KPiBUaGlzIG1ha2VzIHNlbnNlIHRvIG1lLiBIb3dl
dmVyLCBmb3IgY2xhcml0eSBJIHdvdWxkIGFsc28gc3RhdGUgaW4gdGhlIGNvbW1pdA0KPiBtZXNz
YWdlIHRoYXQgaXQgYWxzbyBtZWFucyB0aGF0IEJMS19GRUFUX0ZVQSB3aWxsIG5vdCBiZSB1c2Vk
IGZvciBJL08sIGJ1dA0KPiBpbnN0ZWFkIHdlIHdpbGwgcmVseSBvbiBCTEtfRkVBVF9XUklURV9D
QUNIRS4NCkRvbmUuDQoNClRoYW5rcywNCkF2cmkNCg0KPiANCj4gPg0KPiA+IFJldmlld2VkLWJ5
OiBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBBdnJpIEFsdG1hbiA8YXZyaS5hbHRtYW5Ad2RjLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJp
dmVycy9tbWMvY29yZS9ibG9jay5jIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21t
Yy9jb3JlL2Jsb2NrLmMgYi9kcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmMgaW5kZXgNCj4gPiBmNThi
ZWE1MzQwMDQuLjA1YTc3NDVjMmE2OCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21tYy9jb3Jl
L2Jsb2NrLmMNCj4gPiArKysgYi9kcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmMNCj4gPiBAQCAtMjU0
Nyw3ICsyNTQ3LDcgQEAgc3RhdGljIHN0cnVjdCBtbWNfYmxrX2RhdGENCj4gKm1tY19ibGtfYWxs
b2NfcmVxKHN0cnVjdCBtbWNfY2FyZCAqY2FyZCwNCj4gPiAgICAgICAgIGlmIChtbWNfaG9zdF9j
bWQyMyhjYXJkLT5ob3N0KSkgew0KPiA+ICAgICAgICAgICAgICAgICBpZiAoKG1tY19jYXJkX21t
YyhjYXJkKSAmJg0KPiA+ICAgICAgICAgICAgICAgICAgICAgIGNhcmQtPmNzZC5tbWNhX3ZzbiA+
PSBDU0RfU1BFQ19WRVJfMykgfHwNCj4gPiAtICAgICAgICAgICAgICAgICAgIChtbWNfY2FyZF9z
ZChjYXJkKSAmJg0KPiA+ICsgICAgICAgICAgICAgICAgICAgKG1tY19jYXJkX3NkKGNhcmQpICYm
ICFtbWNfY2FyZF91bHRfY2FwYWNpdHkoY2FyZCkNCj4gPiArICYmDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgY2FyZC0+c2NyLmNtZHMgJiBTRF9TQ1JfQ01EMjNfU1VQUE9SVCkpDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgbWQtPmZsYWdzIHw9IE1NQ19CTEtfQ01EMjM7DQo+ID4gICAg
ICAgICB9DQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0K
