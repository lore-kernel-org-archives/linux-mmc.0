Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B8F185939
	for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2024 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332858; cv=fail; b=G/7JeNQG0JFJnZ0KFssCKrAFuJx+cNyPwWthm9XdpHPq2mlmBclAb+JHqGoLL8bl7jnSoV3FuYMvzF+f+DufBGdqBTIWQ/9iJVTb45n8xvdxNU26fvmWJWN22Bg/1bEclj2vigzeQyMWojflCep1XqkVkVZPDEzilJmC/AzcRzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332858; c=relaxed/simple;
	bh=J9ngp+G5tvm7l0PdQeF+xGFsOIFY0hk78sx3OeTEL/c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hN77Re9sqA7oQvfw5DzUUe9ClbJc/1CRrOSy8ig8kNKgpOGO8d76HGSHstLiszvrXE/LaFxssJM8wIuIiHB6ZdHF0jj97iRjfwO9QpM6IMrpKaxcw3iMRt61A4HrTV6WcBEb8szLc6rAODVWsh/JsyjTnHGe4lG7wiSAqulqgs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bSndWo0Q; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=RATyr17B; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bSndWo0Q";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RATyr17B"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724332856; x=1755868856;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J9ngp+G5tvm7l0PdQeF+xGFsOIFY0hk78sx3OeTEL/c=;
  b=bSndWo0QAHrptl3Q+i73kcx5mLriNsPeRY/m3wJRiq8C44vbHlQ7ZU6o
   uAC+yZ0kIRkf9z6R5x3D8bcANg3GNNoR7R5Z6Mt4raNfa65JHP+EfYfGJ
   a1wonsjXbNy+exurIeZ45PTaSBDd7fCjEFicpM43IMLx9kbve1BRONKes
   +xoWpo6sZ2G5Fp+tV4RcqQLo3JET1WXOACQhCMx2R4B6g3D9qnluf5MpV
   u4RP29KEeniWQiJS5kayfHjsxC/tup/gzmkP9dUk9ZVoDnU+NegBR81Cv
   iFcAVH6oQRWWYy8hhJvoME+odB/mhPSSopJscP29EIAkiLixUYvhckLAY
   g==;
X-CSE-ConnectionGUID: iTD9Fs6FREelYI7maf8PLw==
X-CSE-MsgGUID: r2Q7waAVQgqPXVgqZMPg4Q==
X-IronPort-AV: E=Sophos;i="6.10,167,1719849600"; 
   d="scan'208";a="24286626"
Received: from mail-mw2nam10lp2045.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.45])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2024 21:20:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBrbi5Y8KDaEkceoGcl0Elcmk5mQWLc7rABf1jdiihuwtJwfhVlHy6Q+IREFkkzWsDDsrrRllT5qYoCUM9w0QKDkSQF9pTRSYmz+vuMaJI7RcFXycaoQAaSRAXPxGz4pIYwi4O7U7ha96v0Vmw3KMyD4j9DgKeP+HDbV3ra/utqcH7PhHzbQs++9O1qb9gTXYjZ//12xvPrUCHO2WFW8pAJRSRihFYajc3x05QxzgZ/5eKBIS7caQWYnhiPveemKxpVEd4hOIZwhj0y+Vla2JHIy415WaGj4NLMfJXoJtpZ2LD4bDCJ+MR5qRYomucDp9rQ04Zm+9ze6W3HotyNBvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9ngp+G5tvm7l0PdQeF+xGFsOIFY0hk78sx3OeTEL/c=;
 b=DJ9Thy/79N5UvbzbL0/+gXZTbAtBNBNu3Esihw8l2yoB2jh0PHUng0o40TMTxDSJ86dIVNx565bNEJ3LcWljunSPLodjbMicLkNhxFeFLx6uwPxuyK2daFJ/kUOjJbMgK0ruQbgzEmOSz7OMe2BfR585JKwzArLEFIYwd0GBWb+t41Wt0z1Pno9NqvCbB4iKAyoSsY1EsRxx/SCKblYpZqn90A9u+mS7o+CqV3X1IZhb32d3wuj9btpXRO2/CzevXY/POdbDYClMB11ZZhXTLsvsVsnNcvKmbFibqTbxTbE4Ig5LxsTW6CthYL25kQ+cf2TY3e9YLvwL0uq++Ts16w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9ngp+G5tvm7l0PdQeF+xGFsOIFY0hk78sx3OeTEL/c=;
 b=RATyr17BSji6oVKM+jpgn3T9bbL+jTtYE2xwTlllWz627h8N54DKzf9g4oshcELklIEdaUPzoVGylNuNzs8Ps5V8n4o5UuQW5ce3Fy54vDawiqjDc3BjP/rpwVWuzue6qTZcEx5T9zS8X4SoJVCzGIx68cmi9Z6/kXqW1JZJgnk=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SJ0PR04MB7215.namprd04.prod.outlook.com (2603:10b6:a03:293::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 13:20:52 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 13:20:51 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ricky WU
	<ricky_wu@realtek.com>, Adrian Hunter <adrian.hunter@intel.com>
Subject: RE: [PATCH v3 00/10] Add SDUC Support
Thread-Topic: [PATCH v3 00/10] Add SDUC Support
Thread-Index: AQHa7hvyewG+Um17tUSMut5xtKNlzrIzQ3mAgAAMOoA=
Date: Thu, 22 Aug 2024 13:20:51 +0000
Message-ID:
 <DM6PR04MB657512BAB1302F50DC266BF6FC8F2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240814072934.2559911-1-avri.altman@wdc.com>
 <CAPDyKFrQuZDWT0HSSTs-aP5Svedg2eEPq8mnNisU2kyCOjRgOg@mail.gmail.com>
In-Reply-To:
 <CAPDyKFrQuZDWT0HSSTs-aP5Svedg2eEPq8mnNisU2kyCOjRgOg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SJ0PR04MB7215:EE_
x-ms-office365-filtering-correlation-id: 3bfbecea-6a0f-48ef-58b9-08dcc2ad3ed6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dWsyeEhUdHUzd2lOTWJnVjFuUEpaMU5oWWxxeWc4anVZenVsN3hjM2hGQW5J?=
 =?utf-8?B?cU9NTGxMUEQ2UTVFYXVvdGdXRmxzQzgzYTZoQnNqcEZqbUhTNnFKemtBTDlD?=
 =?utf-8?B?SVZhYlpnRGdRN0Z6Q2Z4WHVZQVpTNVhmOW5tSlZpaDcwQTNGUDdZZTZJQit6?=
 =?utf-8?B?YkdxVnBERnkxUTh2bmNmOHZsdUVzZlpZa0Z3TW1lcUluaTNBZlVIWXNHK1Qr?=
 =?utf-8?B?NWRhNHFPaXNyUysyaVRGV0pvUlZCYnJKQkIvMmtvWERDV0xDU0NzUWRodDZG?=
 =?utf-8?B?dkE5VGxyWUVoRS92NWZnMTZKcVorNENYY2JwR3NKVXBhM0UxYisvcnJVbzRH?=
 =?utf-8?B?cjc5QUk0WTM2UUpWY2gxdGhRNE93SnB4VzREdDJZbU1IeXkyQnoxVlFoR3Nw?=
 =?utf-8?B?V3MxTkNVbjFGNGNhRkNWRzcwbE9QVHhpUG1obFZISUFvNVhDSEhJcGZHSVR6?=
 =?utf-8?B?OUQvTTlSV0tENXFQU3lGbUF3OGtQZVJXQ3hLQldvWElCOHVQa25HdUFVUVZD?=
 =?utf-8?B?WlNLSDUwVEhicFMvbFhsMG9qUGJxKzBTV1pZZStBMTI2ekw4SGtiTmVmOHJt?=
 =?utf-8?B?YmJWeHQyZC81S3pNZERjay9ncHcrV2t0R3RhdFcxMUg5SFowL3I4YmZ3NzM1?=
 =?utf-8?B?U05wb3hjb0hLdWlYdDhob1JndzNqU1A2RTcxTCttT2lEak1VR0V1cEVQWGNo?=
 =?utf-8?B?cUFOZXB6OEFyazA4U0ZDSlNEaXNVdXZ5YUM5L1FnWElSUUtURW5Ra3MyR1Vr?=
 =?utf-8?B?L1JTaVl6KzRlbENOaEc2UWpyM1plaXJDdHIyc0dNdGwrNitYNFJlMDVmQnYv?=
 =?utf-8?B?dzhKNHo0aTFoS2VqbVZYMVN2RFl3WHk4Vm04UklCZlFrblBZMnVockltTkZV?=
 =?utf-8?B?eDVCMnhmRXhubnNrazI4RHZZTy9lMmxxc2ErV3dIUGdXRVN4TUV5M1VmNmJh?=
 =?utf-8?B?Y0dmL1NKVlh6SEZJc21rZ2ovcWFjUkZlWVhJNm9lNWVDWVBpMkJCMDkyR3lx?=
 =?utf-8?B?SUl0c1krMUpvTk1MVTZ3bm1KOEhtZjZRMVFkNHJSY0R5WFBhMTBCRzJRQVpH?=
 =?utf-8?B?L3RITHlyQjZxQ1J0ZlNUeWZDUThvaVVmTnZQeTJFZi9aYnFUbnpOS1l2WUw1?=
 =?utf-8?B?bnU4cm1OS1diSXNpaXBTdTEvcytsVEY4VUFCSGE1cVlUcGU5RnI4STZoTm0y?=
 =?utf-8?B?UXhIM0JLa2ZhNTRUSmFxcDRqalZNc3ZQT2pOcVROb2s4L29SRGx3cXJPN3ZZ?=
 =?utf-8?B?bloyMk1XMVFTS09YbFR4aFZBOU0zNGgweUQ3QXk3TU1NVFh6Z3Zuc1Q3cWpn?=
 =?utf-8?B?SWc4SU9ZQTBWMGZ4WndibTJ2c3lQbjFBcVJaQzdLRlBsMEk5bG02bkhmaVB0?=
 =?utf-8?B?a2xySWJaaHU2d2ZsZFpNTDU2NVpnR0Q3S1JZc2R0cm9IN2lncEdiTkZmMHUr?=
 =?utf-8?B?a25xd1liM0VRV2lFeUdiRTFWVmlrc0JSeDZ3OXFKYnFJOEdDb1FkVkdiMEtR?=
 =?utf-8?B?U0hYVVd4YnFUVHh2VVNqem9uckpRMFVlU2ZFb05BT2ZIRzVNSWtBWkRLeHBw?=
 =?utf-8?B?Nng4NDJ1VUdWd3hZMThoaXhCekIxNTM1cE5HZmdMc0RUTVpXR2o0UWxoOG5U?=
 =?utf-8?B?QUsyTWt2MzJPd2dkN3ozMnFDUDZXZWlma3IzaXZaNS9YblJqeG9TaEYra3pY?=
 =?utf-8?B?MnN6T3J5dnh1cUMvTkpueWhzZ1p5MXNrWmxNdmgrUncwdSswUjVuRGdhRFRF?=
 =?utf-8?B?ZWFOUDJuQi9DTTVGVVFzOE5ZbjdtcnVUYW9ZYXg2QU43UmhWYUYvTTIxZTBy?=
 =?utf-8?Q?4b4+hq261ZvblmREXR6AJXmeMdzFrCUm0tuWQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TlkwQnN1QVJBcERiRUV5Z3I5LzVZZWVNL2t3SGFtUDArSTFWRlozQWRMTGRM?=
 =?utf-8?B?SUpQUWkrUnd0N0h5VDgwak1hSmUwaFJwSmt2bDNWN2wvRzRaK3hSYlNmcWdi?=
 =?utf-8?B?bTM2b0dZZ0VpczU5U3pEekQ1ZnJ2R2ZLeGlHa1Q4ZkY0bGs2MVZzOGQ0UXlH?=
 =?utf-8?B?bUpKdkw4TER0MEJncmtIaVNubll4ZGVvTnBDd3d2V3g0K2x5blNHT1JnaUVq?=
 =?utf-8?B?MGt6UExKd0pyTzRQWGUyeDJJNmRKaEZlSkNFaElyeHR4dmJPci9ud1dBTHFp?=
 =?utf-8?B?U1NUWURscjRoL2RXY0lxdHZuTVB2WDZwTm8zWTUrMm5obDY4Mm1rS1JZRHo2?=
 =?utf-8?B?VWhUL2dZWjBsY3oxdjNqNVFGT3gxaEZhRmM5UXY4ajVVaFNwZHVPZjNURTZ0?=
 =?utf-8?B?TWozQkU2cVBZRzhsMHFRcC9jaTRjRUp3cGFidlVSS0tiZ3cxaHpWRndnbEtE?=
 =?utf-8?B?YTczcXBzT1FjL3Q1b1l2djNUSkRLUkV2Zi9PSm83SlNlemJPWWhzRURHMVVq?=
 =?utf-8?B?NU9pWjZWUHM0aDN5QXBMMkd5QkRRQ1dBNGZEMWVsdXI3MFV5QnlGbi82OUFo?=
 =?utf-8?B?Qm1FRDd5QTFhRzdqYkFjeUVLc2grRTlnaFRzRHRZZElVTExUT3NWeEVwMWtY?=
 =?utf-8?B?cWFmMFRlMm5RcDBUcHgxTm5MK2NrREpKYnFaeWsxWjR3K056Q2pSQTgrZDF5?=
 =?utf-8?B?TWhBTjdsOEgrVThHVlZpSWFaRzNGU0JyeGVkK2lWMmtBZWwxMzgyRDRrTGNZ?=
 =?utf-8?B?QXBVTm1SM3hFSEdVNlhSOVRXcDlRUzVUMElMOVppcElLOWFWUkF1OEloampT?=
 =?utf-8?B?VEpLc3EvKytoQjNUa0tybkptMTI4YlZIcTBHZlh5bDlpVHF2ZVk3eExRTTFa?=
 =?utf-8?B?UzIzNHM4bVJHQ2ZhTEE0eGg3OVo4QzR3QXh3NDRBOWN0bEdqWVhGb05JS3JN?=
 =?utf-8?B?bTdHL3lrdjRwM1NwYkE5S3kyQ2ZzWWNWS245UkxPQ3QvaDZBeEh6Q2paeEV5?=
 =?utf-8?B?d1RBTHE0djA2MG5DQjdQRThjK0JDZlJvbGZTTExWNWdaR3FIemRtdENua3NT?=
 =?utf-8?B?UU5BWFprZFFtYmhoU0pWRDNLR2pkaWIrRXphQ0tmNDU0aUdRTHUxTXVTdEJP?=
 =?utf-8?B?WkxhWld1SE9IOTJuM3dVL2NVbHdHTldNTTFLU2ZKS3NDUWpEZldFMEpIMHEw?=
 =?utf-8?B?K2ROOXp1U1daY0I4dDZEU0RxMEQ3MGV6YkhnY3FIM0N2QUdKaHFaa1N5b2c3?=
 =?utf-8?B?NjNOV09MSTBWQjUvTmo3S3AxdlNoUHFSbUxNMGhHZ3cvMTQ0bEF6VDN1L1Fv?=
 =?utf-8?B?ZTBnQkhVSVZoc0lFaytweGNDejdXV3V5NC92R1dMTUR0SnVnR2VxUHF0ODE2?=
 =?utf-8?B?Qm55a2hyT0R0dy9tTUcrVDA1bGhQOHYvNGtQWUQvVXVhNm5XbWRZNGhURkp3?=
 =?utf-8?B?U2E5MGduRmRNMWJzeFVTNDYwRHNsdXFqaFBNSFN3WlNVWjVYMnYwa3gyMGs4?=
 =?utf-8?B?UHlLTzMyUDlISU9HNVM5WUxZQkVVdzk2MmpPY2RGM2JwUTh1VTNwYndIVmVl?=
 =?utf-8?B?dVNsMlNPbWE4dHdOeW52b1poMEkzNmtPUGQxSXJ5c3plN1poSFdSSnZYYjh1?=
 =?utf-8?B?QnZmV1prczIzclQrUnovOVJhTGw1MGNkSkdDZnNwRnp3WGdETGFDZStzNER5?=
 =?utf-8?B?WHpoZjdidktZY1VYSDg2cjk4TnROYVYzckNFbUNiS2MzUWhyK0lSSkJPeldX?=
 =?utf-8?B?TnVUZ1BscUkveFhYcDhQaGxsamwvbkZFNWdYL1FLbEZXZDM5TldrU3BrL3BZ?=
 =?utf-8?B?TkE3TTUrSlVWSjlSYlJrM0R3R1RRaXpTcFcvMXBRb0NqcTBzRVNveGhXWHZn?=
 =?utf-8?B?NHEzczd3b1VCeWdLU1d3Qyt2SW55N1RyRFF5ajJJT2Q3SWlzMWlYbEt6V1pE?=
 =?utf-8?B?emljci9WYkFoQmhRMitVYTZPT3Z5MWpMSEJQbU9DNjF2SkdlazBlOFpMYzZF?=
 =?utf-8?B?K3h3a0xqY2dmS0FYWWVUalQ1dm9yZnVjczU4Q2h1ZWNqZDNiQUcydzJ1ZFVN?=
 =?utf-8?B?WkwzQmJJbm1kbm9sdEZEcURCcmQ5U001Y2pPWmkxcVZGYS9iVFRIQ0lFWVZJ?=
 =?utf-8?B?U1lhV0J0MUVkRU5VWEV6UUcvU2lpTlV5TGdCYTJpaWhLU1Z0V24yZks3NENs?=
 =?utf-8?Q?1lqbO3eBpf0pdx3uqfKCozzLyCllr0cI02JKpOs6IUZa?=
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
	C3SAnW+2iBOlZG19Ux2sONPQAhukC2We3FumstZOFT4FaubPOwMeIKKL7VDAIZzbJYw+d9qzx69tGclAtVLGe14zH7e+ANqN8iwL83ahp4Ptvf5AXGwLRw9J1BVZPlejcUuV1b1Nat1sUThSkpnNrodXJ2h7Dl/y74cGAoaYB/hSURnv/JvlsGXFx/vWXRCAoDeMqEHFaL4k7KBTeQF+Lb6CjpXXCTjPmDLxhr9lQODFxvhKRWl+cYb9euJjaXtoTXTEVULT3WSi2RB8QHHMI4ptXAB3pFifhVmLcFzx8MhSPdgUolln3m01//tXAJwVUMLcc+84lEFyaq447ppG/UjUPf9JsPnslmfQn0B1OZUWBHSWPt7OKiXlJCCUoRpwBZTYoLRBdnhUDSTt2wWiKskqX+6hn6R02syVStjYgkFZqvulGMmIQsHfJvnpS1utuTZ7Hff8tkMzxSb9Ms0m5QKNIaEZI29sIHF+Or/DmHnEV4voxd+QoVaS3/p2NijDKpFP1v9K1HC93lTUaXtbXBUQxx/pPrsZD08cDqSjxV8tfDg3S+IAJmR/kOhL2Ml0g+mJ9ZEvfmIqgMRD2orMllQPTRMwFFRX760flTQZymUDCAhH/CMrB/t5wJju7bg2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfbecea-6a0f-48ef-58b9-08dcc2ad3ed6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 13:20:51.8704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iCrUbx4U8igIlO7jf8vCr2xpko1YsdIJqhrN0eprhxzEJ+ln/uk8sdeFGe7JNuSVnCtAPWSwgXIRXiuFaVsiHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7215

PiBPbiBXZWQsIDE0IEF1ZyAyMDI0IGF0IDA5OjMxLCBBdnJpIEFsdG1hbiA8YXZyaS5hbHRtYW5A
d2RjLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBVbHRyYSBDYXBhY2l0eSBTRCBjYXJkcyAoU0RVQykg
d2FzIGFscmVhZHkgaW50cm9kdWNlZCBpbiBTRDcuMC4gIFRob3NlDQo+ID4gY2FyZHMgc3VwcG9y
dCBjYXBhY2l0eSBsYXJnZXIgdGhhbiAyVEIgYW5kIHVwIHRvIGluY2x1ZGluZyAxMjhUQi4NCj4g
PiBUaHVzLCB0aGUgYWRkcmVzcyByYW5nZSBvZiB0aGUgY2FyZCBleHBhbmRzIGJleW9uZCB0aGUg
MzItYml0IGNvbW1hbmQNCj4gPiBhcmd1bWVudC4gVG8gdGhhdCBlbmQsIGEgbmV3IGNvbW1hbmQg
LSBDTUQyMiBpcyBkZWZpbmVkLCB0byBjYXJyeSB0aGUNCj4gPiBleHRyYSA2LWJpdCB1cHBlciBw
YXJ0IG9mIHRoZSAzOC1iaXQgYmxvY2sgYWRkcmVzcyB0aGF0IGVuYWJsZSBhY2Nlc3MNCj4gPiB0
byAxMjhUQiBtZW1vcnkgc3BhY2UuDQo+ID4NCj4gPiBTRFVDIGNhcGFjaXR5IGlzIGFnbm9zdGlj
IHRvIHRoZSBpbnRlcmZhY2UgbW9kZTogVUhTLUkgYW5kIFVIUy1JSSDigJMNCj4gPiBTYW1lIGFz
IFNEWEMuDQo+ID4NCj4gPiBUaGUgc3BlYyBkZWZpbmVzIHNldmVyYWwgZXh0ZW5zaW9ucy9tb2Rp
ZmljYXRpb25zIHRvIHRoZSBjdXJyZW50IFNEWEMNCj4gPiBjYXJkcywgd2hpY2ggd2UgYWRkcmVz
cyBpbiBwYXRjaGVzIDEgLSAxMC4gIE90aGVyd2lzZSByZXF1aXJlbWVudHMgYXJlDQo+ID4gb3V0
LW9mLXNjb3BlIG9mIHRoaXMgY2hhbmdlLiAgU3BlY2lmaWNhbGx5LCBDTURRIChDTUQ0NCtDTUQ0
NSksIGFuZA0KPiA+IEV4dGVuc2lvbiBmb3IgVmlkZW8gU3BlZWQgQ2xhc3MgKENNRDIwKS4NCj4g
Pg0KPiA+IEZpcnN0IHB1YmxpY2F0aW9uIG9mIFNEVUMgd2FzIGluIFsxXS4gIFRoaXMgc2VyaWVz
IHdhcyBkZXZlbG9wZWQgYW5kDQo+ID4gdGVzdGVkIHNlcGFyYXRlbHkgZnJvbSBbMV0gYW5kIGRv
ZXMgbm90IGJvcnJvdyBmcm9tIGl0Lg0KPiA+DQo+ID4gWzFdIGh0dHBzOi8vbHduLm5ldC9BcnRp
Y2xlcy85ODI1NjYvDQo+IA0KPiBJIHJlYWxpemVkIHRoYXQgeW91IGRpZG4ndCBzZW5kIHRoaXMg
dG8gQWRyaWFuIEh1bnRlci4gUGxlYXNlIHJlLXBvc3QgYW5kIGFkZA0KPiBoaW0sIEkgYW0gc3Vy
ZSBoZSB3aWxsIGhhdmUgc29tZSB2YWx1YWJsZSBmZWVkYmFjayBmb3IgdXMuDQpXaWxsIGNjIGhp
bSBvbiB0aGUgbmV4dCB2ZXJzaW9ucy4NCg0KVGhhbmtzLA0KQXZyaQ0KDQo+IA0KPiBLaW5kIHJl
Z2FyZHMNCj4gVWZmZQ0KPiANCj4gPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgaW4gdjM6DQo+ID4g
IC0gU29tZSBtb3JlIGtlcm5lbCB0ZXN0IHJvYm90IGZpeGVzDQo+ID4gIC0gRml4IGEgdHlwbyBp
biBhIGNvbW1pdCBsb2cgKFJpY2t5IFdVKQ0KPiA+ICAtIEZpeCBBQ01EMjIgcmV0dXJuZWQgdmFs
dWUNCj4gPiAgLSBBZGQgJ1Rlc3RlZC1ieScgdGFnIGZvciB0aGUgd2hvbGUgc2VyaWVzIChSaWNr
eSBXVSkNCj4gPg0KPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gIC0gQXR0ZW5kIGtlcm5lbCB0ZXN0
IHJvYm90IHdhcm5pbmdzDQo+ID4NCj4gPiAtLS0NCj4gPg0KPiA+IEF2cmkgQWx0bWFuICgxMCk6
DQo+ID4gICBtbWM6IHNkOiBTRFVDIFN1cHBvcnQgUmVjb2duaXRpb24NCj4gPiAgIG1tYzogc2Q6
IEFkZCBTRCBDU0QgdmVyc2lvbiAzLjANCj4gPiAgIG1tYzogc2Q6IEFkZCBFeHRlbnNpb24gbWVt
b3J5IGFkZHJlc3NpbmcNCj4gPiAgIG1tYzogY29yZTogQWRkIG9wZW4tZW5kZWQgRXh0IG1lbW9y
eSBhZGRyZXNzaW5nDQo+ID4gICBtbWM6IGhvc3Q6IEFsd2F5cyB1c2UgbWFudWFsLWNtZDIzIGlu
IFNEVUMNCj4gPiAgIG1tYzogY29yZTogQWRkIGNsb3NlLWVuZGVkIEV4dCBtZW1vcnkgYWRkcmVz
c2luZw0KPiA+ICAgbW1jOiBob3N0OiBBZGQgY2xvc2UtZW5kZWQgRXh0IG1lbW9yeSBhZGRyZXNz
aW5nDQo+ID4gICBtbWM6IGNvcmU6IEFsbG93IG1tYyBlcmFzZSB0byBjYXJyeSBsYXJnZSBhZGRy
ZXNzZXMNCj4gPiAgIG1tYzogY29yZTogQWRkIEV4dCBtZW1vcnkgYWRkcmVzc2luZyBmb3IgZXJh
c2UNCj4gPiAgIG1tYzogY29yZTogQWRqdXN0IEFDTUQyMiB0byBTRFVDDQo+ID4NCj4gPiAgZHJp
dmVycy9tbWMvY29yZS9ibG9jay5jICB8IDYyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0NCj4gLS0tLQ0KPiA+ICBkcml2ZXJzL21tYy9jb3JlL2J1cy5jICAgIHwgIDQgKystDQo+
ID4gIGRyaXZlcnMvbW1jL2NvcmUvY2FyZC5oICAgfCAgMyArKw0KPiA+ICBkcml2ZXJzL21tYy9j
b3JlL2NvcmUuYyAgIHwgNjMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0K
PiAtLQ0KPiA+ICBkcml2ZXJzL21tYy9jb3JlL2NvcmUuaCAgIHwgMTQgKysrKysrKy0tDQo+ID4g
IGRyaXZlcnMvbW1jL2NvcmUvcXVldWUuaCAgfCAgMSArDQo+ID4gIGRyaXZlcnMvbW1jL2NvcmUv
c2QuYyAgICAgfCAxNiArKysrKystLS0tDQo+ID4gIGRyaXZlcnMvbW1jL2NvcmUvc2Rfb3BzLmMg
fCAzNCArKysrKysrKysrKysrKysrKystLS0NCj4gPiBkcml2ZXJzL21tYy9jb3JlL3NkX29wcy5o
IHwgIDEgKyAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jICB8IDM4DQo+ID4gKysrKysrKysrKysr
KysrKysrKy0tLS0gIGluY2x1ZGUvbGludXgvbW1jL2NhcmQuaCAgfCAgMiArLQ0KPiA+IGluY2x1
ZGUvbGludXgvbW1jL2NvcmUuaCAgfCAgMSArICBpbmNsdWRlL2xpbnV4L21tYy9ob3N0LmggIHwg
IDYgKysrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L21tYy9zZC5oICAgIHwgIDQgKysrDQo+ID4gIDE0
IGZpbGVzIGNoYW5nZWQsIDIwNCBpbnNlcnRpb25zKCspLCA0NSBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IC0tDQo+ID4gMi4yNS4xDQo+ID4NCg==
