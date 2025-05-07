Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27348257441
	for <linux-mmc@vger.kernel.org>; Wed,  7 May 2025 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619014; cv=fail; b=LRa9NPPjF+VNiRNRmAI92zyx93NEnuWSP1pUyXWvSu5QONzmAMZHiQzO12WMT1EriRyZisHa4IlXmqGejAMg/DFgx4cMsTCyry5iLdKndM+I0OemXvlur8mu69j74fm64hyvzZXuzn9adYcYWdVeD+vVNab5l2bdigxSw8fSFc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619014; c=relaxed/simple;
	bh=W7NYuNUW5WpCUYm5Ys4/jhgeTindVE6nc2EzW7XgCjs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VQ80fMOE03LNQIxgI45ydRAlUpspEm2GYmP7M2DUjcJypFFkpI4h1Z9NNwOJ8P/VDpbsJDRfrWkbOX1etyhSv9do1WfvkytpPDXtkL8G9mRYb75Oxe651KBbPBbc3adI8bjfH60IqGmg1acv5azy0Lazzc8MdBP5xYROa2d2ZDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=S/KDgH2u; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="S/KDgH2u"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1746619013; x=1778155013;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W7NYuNUW5WpCUYm5Ys4/jhgeTindVE6nc2EzW7XgCjs=;
  b=S/KDgH2ujxGAG8IZv2HaJNGoCHcNbRP8L3TX8pM//fcufHxcoG49AQKE
   cY5ITQR5BY8e5DwQucrMLVRlGgWf3H7i+sGMlX3bMlUZY1BBurhShVMTM
   YLhDYOBIbKL13c2UF53XhmgR0L1QZyVKReZJFmVxkxn1TKRTHaXybh0gI
   i/IcNJfq5t3P5rhhCGwwMRg7bsvyswyaL1XC2ROubSrFna4dNqN5a6IzQ
   tzsyQ5q1FHUPsb0LOH1fZPSgiTMYJczQ4HPqWuq78wY6HNU+P5DzKOG0g
   Q2JZ66/Dq4iD1SF5IwVIZW81+Wr0gyclHfB/dXJSpmDZDfBi21YN+56Xr
   g==;
X-CSE-ConnectionGUID: QUjg8zrAS/KKAyojxEl/rg==
X-CSE-MsgGUID: XwhzOVI8Qcuj5eh1+2TejA==
X-IronPort-AV: E=Sophos;i="6.15,269,1739808000"; 
   d="scan'208";a="79674794"
Received: from mail-dm6nam10lp2042.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.42])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2025 19:56:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5Ar1OiPruBFSOWHJhGL1GVMXW7707BE+9CwlsipYQDowmxwxQUkejAet9mWw7RyBj1Cx1+XkYNHhFl1ImSFnUr5k0gL3gHdtWg3msVhl1ssxzBpl9FxkAam9aka20McellQ1vaaSaig+tpXxFghfpCh7boTW2UOCmpqOenyWbxboW8iWvZDKY1787/6rlOtYFcmhDJ5RzwLdcwrVcrEwvKQA5GHRF2PvNTwLp6MoFvtxQAAhdxU5qleoSjnghEcXhJILtwCJhQs7R3GTZPoxGXuEDmPzwjIgvtp7XSmDll/N/cpFO/Fc0uhEKgo0L7uLE6weHNAlhJUP1l9chX3YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7NYuNUW5WpCUYm5Ys4/jhgeTindVE6nc2EzW7XgCjs=;
 b=wEn7OtDqno0ueAdDcEVO8FPQmhTI/2q7AKf6CrNODnKaBjYLDtwPktE9cWXx3Og/GYwgwR+FzdhCmlmJmnMw0HvbvI332WJVUlvD1Yjt/EZKdoGEoDsIyAj7R722s/SeL2+PIVxblfuKB+KQPmbWDDxhgWJqhCJ+71kjkbMSjqPsqAKzs6jWz37iBqsLBE59nWWVgmIZgRqB3amTfHO2YSttSZK/U4QzUKtczWw44YGKkpiCRxL/z8DK3T6du32kYOwg07TBp3VPFKp72H5NI8tpqAmMt63+USmvMnG4rsnvTk6Ea0wacbPksBN3ft7kxdlxpd7Mh+X1AUFehNYPTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by LV8PR16MB6240.namprd16.prod.outlook.com (2603:10b6:408:1cf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Wed, 7 May
 2025 11:56:50 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::436c:8204:2171:b839]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::436c:8204:2171:b839%5]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 11:56:49 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: RFC: mmc-utils versioning
Thread-Topic: RFC: mmc-utils versioning
Thread-Index: AQHbufIY6yy7oWpkvkaN0QBX5RMRQLPEDMyAgAE1/ACAAMcCwIAA8ccAgAAegxA=
Date: Wed, 7 May 2025 11:56:49 +0000
Message-ID:
 <PH7PR16MB619636B39BB8ADE5D6ADC3C9E588A@PH7PR16MB6196.namprd16.prod.outlook.com>
References:
 <CABGWkvp-peEfhc57-+g+_w4DWWqdWVgw6CFF0tS7yjGsTtTufQ@mail.gmail.com>
 <CAPDyKFqWRDTqXjkb84BG=Kid+MQO_R-cJNcYFB3scnEhhsX46g@mail.gmail.com>
 <CABGWkvr2TPKkqQKYZkx7u0rhf4xyg7WNg6H7+hdpETSqv6MF2w@mail.gmail.com>
 <PH7PR16MB61969260F3C367D70860F211E589A@PH7PR16MB6196.namprd16.prod.outlook.com>
 <CAPDyKFpZMq7J9Q8wwt0_mR2Kv_2=-=gd7g5edksuyyG=tROx-A@mail.gmail.com>
In-Reply-To:
 <CAPDyKFpZMq7J9Q8wwt0_mR2Kv_2=-=gd7g5edksuyyG=tROx-A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|LV8PR16MB6240:EE_
x-ms-office365-filtering-correlation-id: f507f89e-6b2f-4a9e-9b5a-08dd8d5e402c
x-ms-exchange-atpmessageproperties: SA
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b3dpazJrVVNqT2ZhYzNWOEN6KzJrSXNqdUhoakMxdTFSM092VHMxRTdpTWRL?=
 =?utf-8?B?WWNjcW41SmlQb2M5bk94K1hXaWJob05BVVVaWU1TRTRrQk4ycGhxdzVPSmZi?=
 =?utf-8?B?bktXRXQ1QXJHampRQlF5L0VsSHlRSEFUWm4vazRmaG9VcUY0eWVWNE5IVUMz?=
 =?utf-8?B?cVprT1VOcjYrbmVEeXFieWY1NWZ1OTdBY3lFVk12OW1UdFZKQWdzb3FRRHRH?=
 =?utf-8?B?eVE0TjVUcTh4TG14amNhMXJ1L1pJRGdUSkJnYXZUTDgxUnNKcmM5TmxHSm1k?=
 =?utf-8?B?RnBJdEhSMUdRZXVWakJVNDlVMDNYWmtVUnhVUDVjMGdVbDNoV2JBTXV3ZG5D?=
 =?utf-8?B?djhJcFp0V3Ewcm1rTk50NDl0MkRoOFJHeHRKUUtuZENTeVFZY0JrZkhWcUhU?=
 =?utf-8?B?SDlLT1hMUEh5RWpobldjQVRLUk9mRXhNT1lKRVlzS2tQTmtuRXNrWlZ2ZHhq?=
 =?utf-8?B?N2ZhWVBaaUZ1dC9VQU5OWTZsUGdySE95SFdMZmtPNThHNXduc2JPVW0yVDN4?=
 =?utf-8?B?dzQ4Tkx5a29VWWV6V25YTk8rMkF5S2xPeDBCa3VHRTFrUEFaaUxHWFBodGRu?=
 =?utf-8?B?elBDVy9pTDF1Y2Y4ZFZkcVNBS2FBMzZTbm5FeDBFV293cVhXWVZwdFZsUkxT?=
 =?utf-8?B?ZGpWekRFc0tJTytvUURNYkNab3ZkN1FVVHB3UEpCWDlZZ3hTVDBJY3ViWW5U?=
 =?utf-8?B?a0liWElqSGZHb0s3VFBHVHFYTHQxQnE5RjY0MzU4bGkxQnFLVndMNmUwU1lS?=
 =?utf-8?B?VCttQVl5YlNCdmd1dlpRWTh0MHBpdy8waFZkbHpFVkZsOVlnVWlOaWlXMmhI?=
 =?utf-8?B?eGlzanh3N3RSeXZlYWRoeWs4cENSanlTTndDUzJJaTNPWFQ0ZUlmaW11YmRP?=
 =?utf-8?B?cVp1cG1XNUpyTkZTa213ZjZtMDduTHV3WlI5MGlxY0VWWTkzR0RMUEUwY3pQ?=
 =?utf-8?B?di9KSys1ZUtWSzUyOFRxVm5vUWZ4Qy8rU0YxWTRHYkpLQTRuREJ4MDJaNTBW?=
 =?utf-8?B?ekU0bjU4UTFCdkhlNUpneHJtUnFoSmdkdzJPS1dmTTdSbnpFU0hINklxWU85?=
 =?utf-8?B?WStERUFsT1V0akdQQlZnbE9Na2pLR3NDMURXdGwrbUEyS28rZ1B3My8zVkFM?=
 =?utf-8?B?cmhTVzh6R3NiZHRKQS9PMW5jZERqMDU2MVlQaldDenR2QUhLYUZpbWVwMm1J?=
 =?utf-8?B?cnRuQTBCblRzWWNBeGl6R0lXdEszNmNUblB1ZkEzTHAxWFc1bFRjQ3VyRTVm?=
 =?utf-8?B?SFRuNVZWM0xVOUV5MVJmbDVnazY1ODhlVm1RangvV1RHeGJ5bDJxN1BoeHh3?=
 =?utf-8?B?RVhsNEVRMmtrajNTcUFFeEF3bmw3REdrUlNkUHhyam5NOVhKWmNUVDNPRDlQ?=
 =?utf-8?B?MHczODZrdzdFRVNTSklxRWlvMnhBUHgycnN6R2h5K1FDdXkxWFRnNmFSS2Uw?=
 =?utf-8?B?OEM5VHp4VHFZOUlKN0xQZEwvbnFqSzlEUWtaTndFTkZYTXpjd0Y4RlZGaEE2?=
 =?utf-8?B?eVZwdGFoK1VHM2piRFNydXpuR3F4UDdmd1UyQklDaE15a3BjQ01JeWE1ZGUz?=
 =?utf-8?B?L1pXYmNXSkZZMFpOOWFlUjFDd0REL3d6SkgwU2JVOEtJc1pzeHFHd216dVlj?=
 =?utf-8?B?eUQ5cVV5bmJoTFdtdFh6OTlURTJVMTVpM2ZSUzRtazNOZjN0T0hLbXNaR0V5?=
 =?utf-8?B?ZjhiVlpCelNkNFJicWJDeXpiclZtdWp2NVNjK09XcVpqQy9LaUlFd3pFNDRO?=
 =?utf-8?B?bWlHek5sMml6dy9XbndXMlg0dWtqWVlqYjV1ZVNuVWE3RW9haUVodkozZmJI?=
 =?utf-8?B?TWxId1owaS9xaUNIYnJuaDJuTE91VUh5UHFBWU01ZENPS0VSUzQvdElkWVN3?=
 =?utf-8?B?dGR6eHNITXZ3MnJEaFhNT2hGbnQ4bEhkODdWRUFMVGNUUHhFbk11dWJOL2d5?=
 =?utf-8?B?d20vVEo5Um1QVkxVbm0vNGYzcmZ4cVNWNmpDcjBKUkdrSXFZc3N2bWJPRjlp?=
 =?utf-8?B?S3NGMktzNDF3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y2JtdlJDclVvclJ4eGRNbjhGOUVPSGcvaDV6T0RIUEs5dS95QnJaUjdidkI5?=
 =?utf-8?B?L0dkNWN4V25PcTN3STBVbGVEeUlkc1BxSDJjS0RXTjR0Qlk2dFp0aTBxMEpY?=
 =?utf-8?B?ZFNkT1dzcE1QbGRXK1pCNmIvaG9PLzM5UzFMUld2VXVUQmpHUWRPbGQ4RVB3?=
 =?utf-8?B?eXRhV1k3LzE0a3lsODl3dnUrcHJXcjI3dmVBNzVIbzZRTDFObkhzazJqVlNE?=
 =?utf-8?B?V3BFYkVoaFovRFlpRHNJZGhiWGR3QUpGc0tSZCtERkw5WlA5a2k5KzZSZGhB?=
 =?utf-8?B?dzJvTEhKMmk4c3k5RFcxSjF6VGcwMVpEelFSQlludzk2Q2xPMVd0dVl3NWpQ?=
 =?utf-8?B?cld2WU5KUXBlOS80RVBpM1I3dDRFOEhwR21semFTdUpQZDlDWDZjT0o2ZHky?=
 =?utf-8?B?cGZRTFEyTHI5VE9CMVJPbkxvME9VYmxhUEhHNXk5MDVXTmlobWdCZEU1ZjNT?=
 =?utf-8?B?YlhPS3V6QXJEV2gyNFVaMzYrRDZETlhWcjlqeUcvTHRHdkJRbkRQMVZ0MVl2?=
 =?utf-8?B?RWVnTktEaWpGVUJ3UXI2WmxlMkMvaXIwSW1ZVjAyT3lyUHR5RldXR3ljQUp2?=
 =?utf-8?B?WHRKK0xYdFVwbEl3dzQzdzVNYzJpNWhDVit4YjdjUlNZZXVJTmZCK0ZUVDY3?=
 =?utf-8?B?NE91THk2c04yNEtmK3lrcXhPcklLRW5FQlBEckc2Sm9iR3MzZkltUXBTSkYx?=
 =?utf-8?B?QXR5eTJ2Z3RoYWZjTzRvZnlEYnY1NkpwMjJxMVd3cjZRa2RDV3lVS0c2dEFh?=
 =?utf-8?B?cTRlTEFuUkt5aVh1YVNyQnNzQ2FnVjFIRi9FUUNub3Y0ZUprMCs4R0ZkSEkv?=
 =?utf-8?B?a0lMNmZBanhjWk01SlYzL3JXaHViNzYxS0V6bi9KTE55UlJhdkZUaUZGWkhT?=
 =?utf-8?B?K3ZrUG9wdHBHYzk3WGh6aHpOTXZJQ1h3S3QxSVRMS3FOaXErRCtyNy90MUdt?=
 =?utf-8?B?bDFJUk1lMUYxTjZlZzROZVZoMVhRc1hsYmVZUXF6OUZiSlJkWG5Talo2emxl?=
 =?utf-8?B?VytTNDNjblRuSjNERmQ5Qlh5UFBFNUtPSkdBaWw2RGVEcEVYdXBqWTUwdHls?=
 =?utf-8?B?WTdQQ1M0eS96TWJobjNYZDZjcElUU0NnRzQ5SzZoMDJBalpmN2hhM0pOWk1G?=
 =?utf-8?B?alJVdEZZamRnd2l3Ulk0QU9XNHRCKzNIbkllOERVbjF0eDQwOFlqRnZ2a2pP?=
 =?utf-8?B?cEUzK21lNEtDZ2tNcTZzUG5XbmhUVU9DVnpXQ0lvd0FJQVdxTkxiWVRKNTUv?=
 =?utf-8?B?akQxcXFpMmdhZ0xydUUxcFI3Rmo2SzlKZW9wamZIRjBnc1RaT2QrNWI5eFdK?=
 =?utf-8?B?RjYwNVROY3pzVFExVzh0amJDaDBLbnlEcjYxcmpobjdxYTkxSGZyMjRUMy9J?=
 =?utf-8?B?UjBnOEcwUVVtZ1dvVlEybnBpVkQ5TnlEdlZmQ3pFRjFiQkcvVnJtditsNXp4?=
 =?utf-8?B?ejVIY3dpcXNlVU5jRTdEb3pUVXZwbTBRQ2R1bWxncVJqZTBDNmg1bjlBanJY?=
 =?utf-8?B?bzhZVFM5SUUrY0NTWUR2azRlN1JNK3RkRkc3cXNaWE5zR1JkQnNxT2dvUmQ3?=
 =?utf-8?B?MUE2WnJBVUJtZGh3TFJhR21qV0VKeXpJTzJNVmpteUl5b1VjQTFZNzdvM3Mx?=
 =?utf-8?B?WmN0RjUzcy80STNYQUFPZzM1ZkhTU1VQTm1FMWN1MXdXOXpYTHMyKzVsVTZE?=
 =?utf-8?B?WGxtcUdGaGR3VVc0alk0QW9tZDN1TzJBOWlUcjU3ZHJNYThwNkRRN3FRNUVm?=
 =?utf-8?B?ZGhFTjJDLy9lWFE4bk80Y0lZa1ZjWTFiV2lSYnFIR01qWldKQXlxWWhlLzI4?=
 =?utf-8?B?cHh5SURqUjJpZnNBc0xYY1UwdDhZRGk1VmhGN2VuVnQrTFA5VEt3QnZPK21z?=
 =?utf-8?B?VkpHZHVwbFhZQ0tIeHJQbWVQMWZ5YUtLZ29KSUdLOGJuSS9CR2R5bkl0aU0w?=
 =?utf-8?B?SnI1TEIzZHRpd2sySitEcW5RREQvZlVMaGpiR2kyK25DT3JKYVNzc1cwM1Jl?=
 =?utf-8?B?c1NoOXRBTTlqWW1FR2lvSEdsek95a21uZEJaaXhqTE9kV3QyN01tbFRqN1R2?=
 =?utf-8?B?RFU0c2V0TWZrcDN3L0F5M002dW90RnVnd3BCaVlhTHJJK3V2UVBVbEtGcHIv?=
 =?utf-8?Q?cJzDk9Vv73qJeeSUl8lcYaHrB?=
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
	EGuzVkgtX0YI3jll1Q31kPtgRYYIOfH52jOIZrBI0fXD7RUyfyvsIMuQFmhJvP3xrncIw31DLPdO1XPS6nzn2V+vKNlA9axCO4S8X0XR1/O8NPEHOhra/KQQFQFFIgbQK4rCzmpKBlARL0Vk8dwjKDcIrrqsv7Qyz7A42ioNj7hKOq4aTouOSxV2mIX6zpsTJwbFusbAab52tgSrvw8LNbwuAx1WKqF845hmLPe1jQId5DdQTBf3Ap5wylTvc1ojCth/HfGYUij4azCvk3qToVUI1+DcK7+8UNGP5U7xOwdtITFcpYR4UoH/DUrUdv0vhRq+BuVUTgNiR7J0AIxFm4PtIobh50EfMexCN++zLZWaz4l0Pub0lUqtKvJoJ15pOrEUWQQv+qzZf5wnhwcqo1g7ivA65JFIhm0K6xD1P1ztMhCIx0aiKdGafs/iM0ToXATboeqg4CVC3h8QGOVRNKg4Kdzp0WMjtQkujvkaNYITLwxMU1V/L71EuMxi2OQ1gAj1YtRuCnwoMhjHumCr+uxbzEomEzT1MB7b5d5nI2ux+HpcaqA63I1RaExZXpPd7F+pxot8UobDfmKn3m9cTk3kHwH6srcKDfAmpLuVhFB3x96A3uWN65UPaiEUhRM90vJGsbyjl8Fx+qLpSg/f9g==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f507f89e-6b2f-4a9e-9b5a-08dd8d5e402c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 11:56:49.9302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gmBpzUeouRPfPEpbe8FkS8IyyAjQXT2PrbPSlhm5DmG920SGlExLIIzuo7R9dxR0FPSjMBrxReld5Lh6UkTxpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR16MB6240

PiA+ID4gPiA+IFdvdWxkIGl0IGJlIHBvc3NpYmxlIHRvIHRhZyBmdXR1cmUgcmVsZWFzZXM/IFRo
YXQgd2F5LA0KPiA+ID4gPiA+IEJ1aWxkcm9vdCdzIGF1dG9idWlsZCBzZXJ2aWNlIHdvdWxkIGF1
dG9tYXRpY2FsbHkgbm90aWZ5IHRoZQ0KPiA+ID4gPiA+IG1haW50YWluZXJzIG9mIHRoZSBwYWNr
YWdlIG9mIGEgbmV3IHJlbGVhc2UsIGFuZCBpbiB0dXJuIHVwZGF0ZQ0KPiA+ID4gPiA+IHRoZSBw
YWNrYWdlIHdpdGggdGhlIGxhdGVzdCBjaGFuZ2VzLg0KPiA+ID4gPg0KPiA+ID4gPiBJdCdzIGNl
cnRhaW5seSBkb2FibGUuIFNldHRpbmcgYSB0YWcgaXMgc2ltcGxlLCBidXQgaGF2aW5nIGEgbW9y
ZQ0KPiA+ID4gPiBmb3JtYWwgcmVsZWFzZS1jeWNsZSB3aXRoIHJlbGVhc2Utbm90ZXMsIGV0Yywg
aXMgdG8gbWUgYSBiaXQgdG9vIG11Y2guDQo+ID4gPiA+DQo+ID4gPiA+IFdvdWxkIGp1c3QgYSB0
YWcgYmUgb2theSB3aXRoIHNvbWUga2luZCBvZiBzdW1tYXJ5IG9mIHRoZSB1cGRhdGVzDQo+ID4g
PiA+IHNpbmNlIHRoZSBsYXN0IHRhZz8NCj4gPiA+DQo+ID4gPiBZZXMsIEkgdGhpbmsgc28NCj4g
PiBMb29rcyBnb29kIHRvIG1lIGFzIHdlbGwuDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gQXZyaQ0K
PiANCj4gT2theS4gSSBndWVzcyBtYWtpbmcgYW4gaW5pdGlhbCByZWxlYXNlIHdpdGggdmVyc2lv
biAxLjAgaXMgdGhlIG5leHQgc3RlcCwgdW5sZXNzDQo+IHlvdSBoYXZlIHNvbWUgb3RoZXIgc3Vn
Z2VzdGlvbnMuIEkgd2lsbCBsb29rIGludG8gaXQgc29vbi4NCj4gDQo+IE5vdCBzdXJlIHdlIG5l
ZWQgdG8gZGVjaWRlIG9uIHdoYXQgZnJlcXVlbmN5IHdlIHNob3VsZCBkbyByZWxlYXNlcywgSSBn
dWVzcw0KPiB3ZSBjYW4gZGVjaWRlIG9uIGEgY2FzZS1ieS1jYXNlIGJhc2lzLCBkZXBlbmRpbmcg
b24gd2hhdCB3ZSBoYXZlIGFwcGxpZWQNCj4gbGF0ZWx5Lg0KPiANCj4gQW55IG90aGVyIGNvbW1l
bnRzPw0KTm90IGZyb20gbXkgc2lkZS4NCg0KVGhhbmtzLA0KQXZyaQ0KDQo+IA0KPiBLaW5kIHJl
Z2FyZHMNCj4gVWZmZQ0K
