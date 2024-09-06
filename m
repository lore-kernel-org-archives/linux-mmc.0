Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA2175809
	for <linux-mmc@vger.kernel.org>; Fri,  6 Sep 2024 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725610827; cv=fail; b=SVo6XzZmWXPUD0XeFzcpNpLMpHjpEJNMFDRWSz+RoB0Ki8FYPKM9Sfe83CThk+0UUUILm47nQGt5fTQ3/jgJ6LS2h9aAOPdloOQeAbvXluZj/2rizEsdKYLVFeIU//c+jDpjZAdZMRKlYu3/tQcWyjc948vXmfU5w/nxf//Eg5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725610827; c=relaxed/simple;
	bh=ZiLj+XsJwBrB91U2BbF/Z+6j44aztf0+m1gxllqk8kE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T8MID+5oB8hXrLmmnKmSsf8UuxOLUwN+CRN2/N8cChDTRAEp6x9MWFLV9sKHmaSMWluoK8SaVHgP6+GTyEZkzT3Tq1KS0HNenlvEzKP7ICyMmuZkWfdQZ+QATEjzQFYhY0eDtkpFkyHaaIlgOfJkhbtlHI+7xykFlSp+7GtUcoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=L8j2otiZ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=yuJwd2n1; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L8j2otiZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yuJwd2n1"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725610825; x=1757146825;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZiLj+XsJwBrB91U2BbF/Z+6j44aztf0+m1gxllqk8kE=;
  b=L8j2otiZ1jlkZVsy3pM6Gyp8wzKZNAlRKZOUafny1dJbuMw3QDwDAd38
   fxbAQPOwEWK9nvYPwpUmL15B07xJjNhJou3OCqovvB5h92h36rC3oK5tl
   Xf5R7LAcuZSL/ve3k/OofXbWzGUGP64nxSP5P0mjVLo8Eny0MMOm8vKRC
   MATubgr6wooak7y6FaaTCwCRRX5jHLtEM6GjV2bPlV4xMZOUsU8iXebeZ
   B2QK2HlHnt2vQYUIytJDS/BNzrYl7140wyHL9AsIWpEUTlIjoUyVb9p0d
   QdeslhUkjH1tiJJoglFUfBxi+LiIhm2zTBFoP1wT6vBVwd3e59d1r4cQ0
   g==;
X-CSE-ConnectionGUID: si3vt/9xRceLaPheXeSErA==
X-CSE-MsgGUID: UPm1VHkRQsil4LzppUbSjQ==
X-IronPort-AV: E=Sophos;i="6.10,207,1719849600"; 
   d="scan'208";a="26074414"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2024 16:20:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKDOS6vFd3D15R/FFdaEKszURWkTNH4eT4bojG2u5uSdgaDgoQqXMScChhB/uusupOOiOohp+b0N5tx13ntiFkEiyR8qaYWiPFV2Ac7OPhULVeFdY1IbtnxxZGbdQSOs1SvaVWoXwbZabmT9oALcXrAOtNfsAFO1GT0Q47l0Ngt6qBZLcBO1EZfTJ35pto7GKpScDUdKjDdy3tRJUPDuMgCBv0Bfupt8x590WbqYwxMywgdFcU3bez7RLJ61Veur1kiHJQpWFqZJfnXB3J6TWFW+SywGWmrDQeF1+87w73zSGvD+ZeMTzfyNT0KhbuPRj+tBd12OZq2F8C3vYDB3Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiLj+XsJwBrB91U2BbF/Z+6j44aztf0+m1gxllqk8kE=;
 b=GN9wUNmTccYJ6xJ0wGQFvp61023Sj4nEqVpSx5FqpnypA7ImjxDll9db9BMmDg8H95XMn8jB3sR5NZBTUuqR9xlVEx+NfPugEX1y9UUk6ELCllsEeqoimo9BKoqruftcgFJbqDR7gC+rGnEU1Z4f1+o8324XE2FE7lEVsZwgkVbHgRlfdVlbjqSC7qhuslr4FO+Fg0dGcqOVX+2KPC5jhalggJTIFADQM96sWQ0hejPm41L7DMuNuL2UEToypJ5D3o3xUMAmRng4tB9DB1VhJf2n2w7UklRN6lUMSjZ0qFjy6ghUnd80ehObbUXdiqHOhz13lQth1r/MubusopOY3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiLj+XsJwBrB91U2BbF/Z+6j44aztf0+m1gxllqk8kE=;
 b=yuJwd2n1RJyTiUnO/h0OfuRgL3LFoehWj35GFWqWTVOf9CFXiGyBmf5KryLrPP4jhB8gQXVJiqrJs1yUV45TQuomUtk3cXEEmL5VMEd2MjGvmxrNXO1q0fRyWVyWBdzk9rPOuNSI3lQzm/CRrzQhG50Mxsmem/E4zWJ05zQopDE=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CO6PR04MB7826.namprd04.prod.outlook.com (2603:10b6:5:358::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Fri, 6 Sep 2024 08:20:22 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 08:20:22 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>
Subject: RE: [PATCH v6 3/9] mmc: core: Add open-ended Ext memory addressing
Thread-Topic: [PATCH v6 3/9] mmc: core: Add open-ended Ext memory addressing
Thread-Index: AQHa/tpuqzDYrSc/4UWqwA3ouia0pLJKaKAAgAAC7QA=
Date: Fri, 6 Sep 2024 08:20:22 +0000
Message-ID:
 <DM6PR04MB6575CF2F7CBDEB87949965D7FC9E2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240904145256.3670679-1-avri.altman@wdc.com>
 <20240904145256.3670679-4-avri.altman@wdc.com>
 <fc704a6e-962e-4294-9d97-ca43144adbc6@intel.com>
In-Reply-To: <fc704a6e-962e-4294-9d97-ca43144adbc6@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CO6PR04MB7826:EE_
x-ms-office365-filtering-correlation-id: 2a2e72d5-f292-4765-40a6-08dcce4cc0a1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d2ZyQWdhZUxFZWltaDBoSEZmU1lYWmtFTXNGemFLVk96YkdZQk4rTU8rZ2tJ?=
 =?utf-8?B?REtkTjEreFVNTEx3Sng5cFQzdnVtckpYb3JTNVA0T3ZRT2RwRFNSNnBmdGYx?=
 =?utf-8?B?US9nK1p0TDc3clR1aS9qSld6MUF2eDhDVjczOEh6c0Q3Y0Y5S05MR2RIWFFP?=
 =?utf-8?B?NXdBaTBnTFF3VU42MzU4RVY4SVpHOVJwcmFsUjBoTmN0WkV2QVpNWWk1VHZl?=
 =?utf-8?B?ZmJiSXBNb0svc3lnWUxGVDlyL3h5eGo3ejEwRWI5eVlKOXYvVFZ3T1R6ODRS?=
 =?utf-8?B?bEVYUDZjazVnVDBYVGNZUEZsNGVPZ3RlcS9tdW1KQUJidkVMUytkS2ZVaVN3?=
 =?utf-8?B?QTRobVV0VVRZQjBmOE83VjgrTDM3dU5lQkJrM1N6RTVHcW8xVVFGUWlLVXdF?=
 =?utf-8?B?c1cxazVxNWdQUytialBVWjU0L1R5aXZtNjZWR3R0RmwxNWxOMjQrbXlVU0RR?=
 =?utf-8?B?UDNYaWJjRHJ2UDZHL0xaU1V5TzU3N2xPN1lDd0VCdk1jMjl5dGZ6SHRITG5X?=
 =?utf-8?B?RVB3MzZKOVJEa0poQWpJUW1aeGV1aG1TOGJpazBucHRnRzllNy9MUSsxMkM1?=
 =?utf-8?B?M0xRdmFrQjVFbEpDN3lVVTVjeEQ5eWljWkpnM1d4KzE3R1AwVmtWQS8xU0l4?=
 =?utf-8?B?elI4ZXNJNHVkTWYwRERhNC90SEdsUysvUlVmVWpacGoxUjU1aTRyTy83L1dy?=
 =?utf-8?B?ejlyekFLMEJISzdURVR3aitGTlpEcjQ1TExxd3JrV2lRdkJLTmZwc3JuY2ZH?=
 =?utf-8?B?VEpKZCtOSEIyYzdkU3hnVi9DRjVwMTZnK3BlNFhWamRlWU1mL2NmYXJXNW03?=
 =?utf-8?B?czZZb0p6dUJ3aERIbzZFUE1nb3NINklreVRnTzhYL0NteEQ1RmpNenh2eXVv?=
 =?utf-8?B?Nis5QnlTZkUwaWNnZ2NJTkt4aVdsZXZSbG9QT1J1MnlqZVhEakZLRnNTRlpR?=
 =?utf-8?B?bHQzbGdWTWV5TTh0WExSTGlqSEJmZ2lVVjhodGtkOEJjK0d1WHVlQU1PS0di?=
 =?utf-8?B?b2RtWU9hUTM0Mm5BeklQUnliMjJ6Wnl5QUNWaitYY3FRbUJRM2lERkVDb0Fz?=
 =?utf-8?B?RWgvRXZTcjM4VERmZVdsd2ZxWnZxU3RTMWZtb3hobWJqWW0rK1ZLL1ZIVlZt?=
 =?utf-8?B?QVJiNnMxczByK0QyUU9nRGRGZzA5NFRGT05Relg2TzdKWDMyQ2l5NXBPeTA1?=
 =?utf-8?B?U2cvVUxhNWNhaVZZcXQ4RnMyUEVBb09NdlVuejdSUCtOMDhrM09Va1VjMzRa?=
 =?utf-8?B?eTJ2MiszdU1GYmtaYjE4N3BpdERIT205TEtoQ20vTHdVTUxJRDgxejR0R3dN?=
 =?utf-8?B?d0ZqaHZ3S0hJYll6VGNMK0ZZbW5pMVFvWHpTSUJwL2dYdEh1dy9xdkx2dTBU?=
 =?utf-8?B?NThsS2tkRWlaaGRCSmtVczhOVjIxa1RQZTJOQTZUM2x0ekdGUFp5M2RQSXly?=
 =?utf-8?B?dUhBTEhlZ2g2MFRybWtwN05qNGxhUlhnRDZUOW1WeDdUeDBRZXVwN05Ea0Va?=
 =?utf-8?B?YjVRbWVwczlwckNQRUJOUVNYZ1ZXUTVuaUs1ekpGRlBJQVNIOHFSK3FnbDlX?=
 =?utf-8?B?UnZkbHZkV1V2akRzcmV5cmUwdXRiaU1CZXhtbmpXUzVHOXFnbFNMNmljT3hn?=
 =?utf-8?B?Qnc0SGdGcVhldS82OS8yRlN4dVdGVXU2bjMra2NtcGNGd0lKRW1KaFNuTndx?=
 =?utf-8?B?djM1RzV1S2tjekNOUzJwL2RtME5HR0J5dVpQaTN3OU0zdmMrdkJkdHlJTDdJ?=
 =?utf-8?B?UGROcVhZanVUR0E3UzA3M2Zqb3hCZkkyYjZ2M1oyVXFsWXM2Q2RhcjJIWXQy?=
 =?utf-8?B?UFBEc2diQlgxUkh3bVJTRlFVb083MXl1MU81eEtvNUtyU05EZUlpRHNEZW5s?=
 =?utf-8?B?emhnSEtRdVBabERTSG1UaU9ubmk4bnZQYmRGRVFRRVpHeEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aXNlM0RCYngwWU5hZGdBT1VUMllpRFR5NkJqVlE4TFdhT3ZiVWlvYWhXNWJT?=
 =?utf-8?B?UUp0L2hTVXJ4dGoreko5c3NUeDc0WXExRjZPeElHNTFtZjFqUHhRTVo1ZURr?=
 =?utf-8?B?OXI5aFU2K1BodkQ4Q3FoUUR5ck1kNXU2YXVWc0tRTXJCbVRSVmFMS1g1RDhq?=
 =?utf-8?B?KzMwNXovS2pFM09GUFZLcXJXMGY2ektQVkRwR1dkMS9tOVR0dXB3azBhUlAy?=
 =?utf-8?B?V0tlc0hGSjFFa0dTbFZ5T0RNamt4MDFPT0FxdDAzYWV0MTdoN1E4SllUT3V0?=
 =?utf-8?B?b3BDc2MySlhCYVpyejQ5U0JvcGVCTlZqS3QrRlNEbjNTVU1DSm1XNjdIYm9v?=
 =?utf-8?B?blF2WUgzYUt5a1UwWGtUTGtWMmZYTncxdDE4OEdWT0RiSkRuMVBwN3pXV3RH?=
 =?utf-8?B?NDZ0aUdqUC8vNVdlNjllMGxJRGFCSUVaNW9SUlhOMzJVQXZ0dE96c3pGZ3dU?=
 =?utf-8?B?Qm1HSlNIL2tIUllMN1o1dFkzdW16c2dkNFdGUnFWUGt1VStKZ1dIRnh5bmFj?=
 =?utf-8?B?dmRaNWhEY2RPblBDR3BmR2kyR2dBOEhmRkN1NFkxV1c4UU43WkdnczBiRVNs?=
 =?utf-8?B?dlhjY0RWUVRMQyt1VmJ3Ym52YVBkckMzTmxmbmhLNWlRSnVCTFlvdFIwNXk3?=
 =?utf-8?B?L1hQTXBYekN3QzgxS0RObm1UUEp5SEx5UlR6NGxZdERVVXNjN3ZNbHJpTlBY?=
 =?utf-8?B?WlpaaVkyeDRsdkZiTUtxakl1aVVENDJVMjN1NWRXaHkwMHFmeWdjMU01ZWto?=
 =?utf-8?B?aGhUZFVxVU9CWGZPK0xsNUlHSGhQUFlSdG1VVG5xVUlpMlFGSHpMUU5PdVVN?=
 =?utf-8?B?a2QzUDk4dExkdFpSQVJhUDBYa045aTQzZTAwL0RzY1Vpeko5YnBJdzBlc2Nk?=
 =?utf-8?B?bGVyRWZzUkRHak5HdHlqSGNqa2ZWYmRyREVmNnFsYzN5V3JxUDk1UU92UE9X?=
 =?utf-8?B?cVdpZW5la3NtZXNuVTgxVlVRNml1VXI0T1dZeUlVNTVCVUFLbldBdGtxTENM?=
 =?utf-8?B?ZDNBZUpmLy81d3BuTllTbnFkOTJ2SXQ0bHFFblFkMk1YUXROTVQyMDNUT2RK?=
 =?utf-8?B?aUU0KzB3T3orVHlvRXYrR0dMYzliS21Rck1EMDcyVTZrY01XeXdFN0RhWVE0?=
 =?utf-8?B?dU5Za213Z2NRdDVJYU9SdkxlK1EyOXFUNk4rcHQzOUY4QjlZWGpqeXd2bVZo?=
 =?utf-8?B?Rkd4azhNZStwYU53dml6c0lYSWdBMEduT2psRWRPRmlxM1ZJeUVKK09TSUFv?=
 =?utf-8?B?YmFZUnk3aVhnenJRSE16cG5sR0QxeDRYN2Jza25FUm5VUFhDdExXUzBvaGhh?=
 =?utf-8?B?MTlvVEYrL05KdXNzOStOeldpd25ZMDI5bi82WVRFejNiVFdCaS9kczVtVExM?=
 =?utf-8?B?b2FTd1hSQnh3eXVsQURydW4xeXZUYmFQdHlORXFERnl5amVaNGxtV3VYRGxx?=
 =?utf-8?B?YkNtNGZWUlN2UVhGcGYzbGdqWGtiRXNLc08ybkFpZTE2MElVaUpXR0JRUHFP?=
 =?utf-8?B?dXhZaVlENFJyNG5LZ1AweEhrcFRoRDROMkF3aFQ5VElxZDQxZmdWUml5UHRF?=
 =?utf-8?B?WnA0SFBVN0VQS0s3MVhKQWsydmN3MVNuaWdFRWUzQUJ5SW5maGpYRkpFQ0gv?=
 =?utf-8?B?V0hVUFhkTVc0MFFqOS9HWS9OSWVBUmdmd2lKK0FaWkdUdm5vVXZvTlgxU2ph?=
 =?utf-8?B?bEZZSGp1bGVpV3VvQ0xlWWtBWDBJSk1JL0tPekJNZXRJZ1luVXBsdHRmRVhn?=
 =?utf-8?B?Q1M4RmtCU29wUDlOUjZGU0d1b1BEMXVEWjAxR0V1MHNjVldBUC9icmN2U295?=
 =?utf-8?B?dnBYMFFEY1B1aEx6KzQvVXUvTnpHc3JJMkJjemk5enVVQmNNNm9EMml0YU9K?=
 =?utf-8?B?VVJOM25yS2o0dTlzeWV3VWxuMmpZVWNSc1MzZzFtWmJHdVVKWVhxUTNBWm81?=
 =?utf-8?B?UUxPZTIwKzJ4NjdqZGpTOVZqOXozMEIxcEFnWWZiVGtVSnlTcWFiSU1CRTVF?=
 =?utf-8?B?Tk82bTlGVDVEN2lubEZ1em91NXZWWGp4enF4c3dZMmhTdS9BMVRQUXlsQ3Yz?=
 =?utf-8?B?eUVxRkpzb3JFeldsTUx5dk5kb2ppTEFIOUZ2b1dkc2JJRERaTVRWZWpnYldl?=
 =?utf-8?B?cTRSdkRsUnJidHA0ZmNjaWdIcTlhdTdrYlZRNi8ySUdMTjJvMkprdTRCWEVS?=
 =?utf-8?Q?9axZZW1E1exPe6akwpw3oUVogdY4tC7dlDgAhJiPrY/O?=
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
	YZ8u8xm6t/Li/29mQil0ojcorULb3XRNCFjVZAWTuWTdU090PBtkMgNnFYE6tcxUou82tOt/HbIVTahHoAIUecHNfoirtku9GbWvSo1A4Vmx8ADQVyO6g7Gez8J0l1grcqEaThV6V6TFd0NRXz4wqOQamUXUopZL+TZmpDIYna12Pp72xcOmyfupJt/gPsi9J8T5lKTVg2lgkloqwt37RyK7ADNJPqyt1x8PS2hTmHLVmNRhGY1uWiyO35byIhcoYnlcVG1NriIrfEKx/JbwxS8DTz31FWapr6W/ByTCNXrZsw3BVin2zgYckXlPRinJ5/aqJABgaYOqZbP7suAQzMIMfn+stWxNiL2bh0gvnInVIjPQyO8RapdU4tQH1qhSJIXmkncqD281lxL2BsIv/MWRfRO9suRkgyGxxCGWklHZi8Z/sh5cVEqUf5n4yTkFZ0xFnGtLt68TKEbj4R/OnhK7C0EXgDgDOh3aQjBmeU2j8qrgy3evl0CsEhmeKFf2aIo/XxeiuNzRtw6GYtze5T0KC7LvGvfcNQVs2nwQHbX3RGARsZ7MbmfAjlx76GAUNHahXTsPrBAF4Piv7r0Fspumi4tYu6yJCOXBxyc16W3CXOTsl6oNeQ0bZfVPwhBQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2e72d5-f292-4765-40a6-08dcce4cc0a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 08:20:22.4341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vIlUl1pU9bwsKF9f9mIlKKknfnekFI+/zkiJydD/3fITw59ccJlcD6gcalvE9DCkqGJF2a2Z3KBACqR1QA8PFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7826

PiANCj4gT24gNC8wOS8yNCAxNzo1MiwgQXZyaSBBbHRtYW4gd3JvdGU6DQo+ID4gRm9yIG9wZW4t
ZW5kZWQgcmVhZC93cml0ZSAtIGp1c3Qgc2VuZCBDTUQyMiBiZWZvcmUgaXNzdWluZyB0aGUgY29t
bWFuZC4NCj4gPiBXaGlsZSBhdCBpdCwgbWFrZSBzdXJlIHRoYXQgdGhlIHJ3IGNvbW1hbmQgYXJn
IGlzIHByb3Blcmx5IGNhc3RpbmcgdGhlDQo+ID4gbG93ZXIgMzIgYml0cywgYXMgaXQgY2FuIGJl
IGxhcmdlciBub3cuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBdnJpIEFsdG1hbiA8YXZyaS5h
bHRtYW5Ad2RjLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tbWMvY29yZS9ibG9jay5jIHwg
NiArKysrKy0NCj4gPiAgZHJpdmVycy9tbWMvY29yZS9jb3JlLmMgIHwgMyArKysNCj4gPiAgaW5j
bHVkZS9saW51eC9tbWMvY29yZS5oIHwgNSArKysrKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDEz
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL21tYy9jb3JlL2Jsb2NrLmMgYi9kcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmMgaW5kZXgNCj4g
PiBjYzczMTgwODljZjIuLjU0NDY5MjYxYmMyNSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21t
Yy9jb3JlL2Jsb2NrLmMNCj4gPiArKysgYi9kcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmMNCj4gPiBA
QCAtMjI2LDYgKzIyNiw3IEBAIHN0YXRpYyB2b2lkIG1tY19ibGtfcndfcnFfcHJlcChzdHJ1Y3QN
Cj4gPiBtbWNfcXVldWVfcmVxICptcXJxLCAgc3RhdGljIHZvaWQgbW1jX2Jsa19oc3FfcmVxX2Rv
bmUoc3RydWN0DQo+ID4gbW1jX3JlcXVlc3QgKm1ycSk7ICBzdGF0aWMgaW50IG1tY19zcGlfZXJy
X2NoZWNrKHN0cnVjdCBtbWNfY2FyZA0KPiA+ICpjYXJkKTsgIHN0YXRpYyBpbnQgbW1jX2Jsa19i
dXN5X2NiKHZvaWQgKmNiX2RhdGEsIGJvb2wgKmJ1c3kpOw0KPiA+ICtzdGF0aWMgaW50IG1tY19i
bGtfd2FpdF9mb3JfaWRsZShzdHJ1Y3QgbW1jX3F1ZXVlICptcSwgc3RydWN0DQo+ID4gK21tY19o
b3N0ICpob3N0KTsNCj4gDQo+IE5vdCB1c2luZyBtbWNfYmxrX3dhaXRfZm9yX2lkbGUoKSBhbnlt
b3JlLg0KRG9uZS4NCg0KPiANCj4gPg0KPiA+ICBzdGF0aWMgc3RydWN0IG1tY19ibGtfZGF0YSAq
bW1jX2Jsa19nZXQoc3RydWN0IGdlbmRpc2sgKmRpc2spICB7IEBADQo+ID4gLTE3MTAsNyArMTcx
MSw3IEBAIHN0YXRpYyB2b2lkIG1tY19ibGtfcndfcnFfcHJlcChzdHJ1Y3QgbW1jX3F1ZXVlX3Jl
cQ0KPiA+ICptcXJxLA0KPiA+DQo+ID4gICAgICAgYnJxLT5tcnEuY21kID0gJmJycS0+Y21kOw0K
PiA+DQo+ID4gLSAgICAgYnJxLT5jbWQuYXJnID0gYmxrX3JxX3BvcyhyZXEpOw0KPiA+ICsgICAg
IGJycS0+Y21kLmFyZyA9IGJsa19ycV9wb3MocmVxKSAmIDB4RkZGRkZGRkY7DQo+IA0KPiBhcmcg
aXMgMzIgYml0cyBzbyBub3QgbmVlZGVkDQpEb25lLg0KDQo+IA0KPiA+ICAgICAgIGlmICghbW1j
X2NhcmRfYmxvY2thZGRyKGNhcmQpKQ0KPiA+ICAgICAgICAgICAgICAgYnJxLT5jbWQuYXJnIDw8
PSA5Ow0KPiA+ICAgICAgIGJycS0+Y21kLmZsYWdzID0gTU1DX1JTUF9TUElfUjEgfCBNTUNfUlNQ
X1IxIHwgTU1DX0NNRF9BRFRDOw0KPiBAQA0KPiA+IC0xNzU4LDYgKzE3NTksOSBAQCBzdGF0aWMg
dm9pZCBtbWNfYmxrX3J3X3JxX3ByZXAoc3RydWN0IG1tY19xdWV1ZV9yZXENCj4gKm1xcnEsDQo+
ID4gICAgICAgICAgICAgICAgICAgICAgIChkb19kYXRhX3RhZyA/ICgxIDw8IDI5KSA6IDApOw0K
PiA+ICAgICAgICAgICAgICAgYnJxLT5zYmMuZmxhZ3MgPSBNTUNfUlNQX1IxIHwgTU1DX0NNRF9B
QzsNCj4gPiAgICAgICAgICAgICAgIGJycS0+bXJxLnNiYyA9ICZicnEtPnNiYzsNCj4gPiArICAg
ICB9IGVsc2UgaWYgKG1tY19jYXJkX3VsdF9jYXBhY2l0eShjYXJkKSkgew0KPiANCj4gVGhlICdl
bHNlJyBpc24ndCBhY3R1YWxseSBuZWVkZWQsIGlzIGl0PyAgTWlnaHQgYXMgd2VsbCBrZWVwIHNi
YyBhbmQgZXh0X2FkZHINCj4gc2VwYXJhdGUgaW4gdGhpcyBwYXRjaC4NClNvcnJ5IC0gSSBkb24n
dCBmb2xsb3cgd2hhdCB5b3UgbWVhbi4NCkRvZXNuJ3QgdGhlIGVsc2UgaW1wbGllcyBvcGVuLWVu
ZGVkPw0KDQo+IA0KPiA+ICsgICAgICAgICAgICAgYnJxLT5jbWQuZXh0X2FkZHIgPSAoYmxrX3Jx
X3BvcyhyZXEpID4+IDMyKSAmIDB4M0Y7DQo+IA0KPiAnJiAweDNmJyBzaG91bGQgbm90IGJlIG5l
ZWRlZC4gaS5lLiB3ZSBlaXRoZXIgdmFsaWRhdGUgYmxrX3JxX3BvcyhyZXEpIChubyBwb2ludCkN
Cj4gb3Igd2UgYXNzdW1lIGl0IGlzIHZhbGlkLg0KRG9uZS4NCg0KPiANCj4gPiArICAgICAgICAg
ICAgIGJycS0+Y21kLmhhc19leHRfYWRkciA9IDE7DQo+IA0KPiBJZiB5b3Ugc3dpdGNoIHRvIGJv
b2wsIHRoYXQgY291bGQgdXNlICd0cnVlJyBpbnN0ZWFkIG9mICcxJw0KRG9uZS4NCg0KVGhhbmtz
LA0KQXZyaQ0KDQo+IA0KPiA+ICAgICAgIH0NCj4gPiAgfQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbW1jL2NvcmUvY29yZS5jIGIvZHJpdmVycy9tbWMvY29yZS9jb3JlLmMgaW5kZXgN
Cj4gPiBkNmM4MTlkZDY4ZWQuLmEwYjI5OTk2ODRiMyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L21tYy9jb3JlL2NvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvY29yZS5jDQo+ID4g
QEAgLTMzNiw2ICszMzYsOSBAQCBpbnQgbW1jX3N0YXJ0X3JlcXVlc3Qoc3RydWN0IG1tY19ob3N0
ICpob3N0LA0KPiA+IHN0cnVjdCBtbWNfcmVxdWVzdCAqbXJxKSAgew0KPiA+ICAgICAgIGludCBl
cnI7DQo+ID4NCj4gPiArICAgICBpZiAobXJxLT5jbWQgJiYgbXJxLT5jbWQtPmhhc19leHRfYWRk
cikNCj4gPiArICAgICAgICAgICAgIG1tY19zZW5kX2V4dF9hZGRyKGhvc3QsIG1ycS0+Y21kLT5l
eHRfYWRkcik7DQo+ID4gKw0KPiA+ICAgICAgIGluaXRfY29tcGxldGlvbigmbXJxLT5jbWRfY29t
cGxldGlvbik7DQo+ID4NCj4gPiAgICAgICBtbWNfcmV0dW5lX2hvbGQoaG9zdCk7DQo+ID4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW1jL2NvcmUuaCBiL2luY2x1ZGUvbGludXgvbW1jL2Nv
cmUuaCBpbmRleA0KPiA+IGYwYWMyZTQ2OWIzMi4uNDFjMjFjMjE2NTg0IDEwMDY0NA0KPiA+IC0t
LSBhL2luY2x1ZGUvbGludXgvbW1jL2NvcmUuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvbW1j
L2NvcmUuaA0KPiA+IEBAIC03Niw2ICs3NiwxMSBAQCBzdHJ1Y3QgbW1jX2NvbW1hbmQgew0KPiA+
ICAgKi8NCj4gPiAgI2RlZmluZSBtbWNfY21kX3R5cGUoY21kKSAgICAoKGNtZCktPmZsYWdzICYg
TU1DX0NNRF9NQVNLKQ0KPiA+DQo+ID4gKyAgICAgLyogZm9yIFNEVUMgKi8NCj4gPiArICAgICB1
OCBoYXNfZXh0X2FkZHI7DQo+ID4gKyAgICAgdTggZXh0X2FkZHI7DQo+ID4gKyAgICAgdTE2IHJl
c2VydmVkOw0KPiA+ICsNCj4gPiAgICAgICB1bnNpZ25lZCBpbnQgICAgICAgICAgICByZXRyaWVz
OyAgICAgICAgLyogbWF4IG51bWJlciBvZiByZXRyaWVzICovDQo+ID4gICAgICAgaW50ICAgICAg
ICAgICAgICAgICAgICAgZXJyb3I7ICAgICAgICAgIC8qIGNvbW1hbmQgZXJyb3IgKi8NCj4gPg0K
DQo=
