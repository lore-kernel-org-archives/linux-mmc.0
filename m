Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342401CB31C
	for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2024 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333069; cv=fail; b=jT9MQFoBQTdR+MvXxbybpludKsuxtGzaT4ibS5nduPYW4mMAttWL3wtB6cBZTAYlrwpPgR/Z4+gDzD2L9HBB4Daq4TBWK12lwyHzbres8NzLeMc3h4J1+1E9uQSodxunK84wYf4UEOo37jly7PjpQ56VlRbcrbEAXTRiVGcP6zI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333069; c=relaxed/simple;
	bh=4tf6OrhrJgS1WAZGjmxG7Um+hvXzMPmQt4PhNPRdA0M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cd8siWaR+E/9t7Ekevxfa7RGqDR+jodOZLmBU1J1Yc9t2avin5V3vjKkzqlCKcGH0OrE0WAnGoB/OjNOXHe8wSgWx2aZm9V2ZcC7ukPxBlEympAClDQIvgPLHCggxvDStHen1KvXDRIlZRwvwSEmXK17d11zxKFezodFtuHJ3FQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JXhCOY1m; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Rz5hkalg; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JXhCOY1m";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Rz5hkalg"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724333067; x=1755869067;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4tf6OrhrJgS1WAZGjmxG7Um+hvXzMPmQt4PhNPRdA0M=;
  b=JXhCOY1mQ5cgB+qEVI9sAfpDudaVVogeecYRqXpVXjFZcDURdqadwQrb
   r0hAG7CI69ZtlqlWZEZtUI5kWt2Nrls2Re7v8tZiR2lcxSBFykGnoQdx3
   IZ5Jwvn2jtiIRzeANyjN7Mt3DVO4kGToPeX/zcurjLWqFQZcFQvlj5JQi
   bjqVvWQtTWt+DE4QtRvbdhrp2f9CJnO4qu89oHjQiazB84kuVF6jrtSXx
   ch11pL88dAUJJlAMzIM32kcaJY4Tv+X5P0Afr19Dix7TyxZB2F520QH23
   R6uLcu5Wmb0MX5ngPBq2TWxNylv7lXtkoCvyTqm8ZhDZ5W0M3Hip9Ywfo
   Q==;
X-CSE-ConnectionGUID: 6Y/YvB7fSjecFLmcEmy+LA==
X-CSE-MsgGUID: lJKjLb7vSTyWwhuiS3UnrQ==
X-IronPort-AV: E=Sophos;i="6.10,167,1719849600"; 
   d="scan'208";a="25203252"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2024 21:24:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pk3RERxhrXIDVrC8wIO6jR6r8R7wISENbfUaG1rrQJaVVbITu2DLNdSGvbJeZRCH2MDvC2pIScUiFOb2W4myYsPChLubnSaKurALIULuENSD/YWCAmOAH2xtdzNMsKPjtZn4Zgas5NWvqJH7RVJs83IQDoMUNjtLPEFSPSpavItO8vfIf+OCZmV6kF03VSr4RcnRQjCC3UqQiQPbaVfAnJuGarcOBBxDA5/OqnK/WicSh8jLwp+VJ1KFWSUT/Yp7d9kSO5e5V2oNrk9mdzeMOqy2z6NlbybD1CClrb2ya74HB/klIlQNF3g4WyhV4xFOm8lfj2GS37gGP4ju9iWI9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tf6OrhrJgS1WAZGjmxG7Um+hvXzMPmQt4PhNPRdA0M=;
 b=OtOBRd16p8cLqxUf5IUYLtIjHbUsCeVIZ63dtxiqk8yOKWKQ/qjSslfmvsz4IvyXOvdiBaoq5Az2wAWw4rSSKejCGXw1DL5li+Eu2NK5LR1D2nmsSVA0QI8LYVGpw5gWQptjama4hALwjYDdyKIKQgXoF1tmdu8NqyFor9zAZhyxg05gNRV2eB8W/X2dMyFaR8c3SXpFcuYng3IcLQ8x4OUFDTj5Uex06gUZCpPKzkWk4Ef1so95tjh6k7Aa97TaSgg6frctuGPngKqKm+eaznPgnkQ7fXVDcpT2ihnELO6lQlS5Sz1SanYcfWA8g55jXG9lMOin6iI8+NijLkkjKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tf6OrhrJgS1WAZGjmxG7Um+hvXzMPmQt4PhNPRdA0M=;
 b=Rz5hkalgH9PNGCbSn0O15l53z1zJaX5IkR47FDm+JKFCKo+5VYGrxXfx/tJbbbe6PPYY0gzjMJAHzeQJ0ke24wPXgg39v7HRJiE5dnzTwhPzFcvfL6/PbqjEKG4amzYGwJzU91f6Zi3FC/5vsqXl0MyU1gSR8LOtDkswcIZ/3Gg=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BY5PR04MB6487.namprd04.prod.outlook.com (2603:10b6:a03:1c4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 13:24:22 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 13:24:22 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ricky WU
	<ricky_wu@realtek.com>
Subject: RE: [PATCH v3 05/10] mmc: host: Always use manual-cmd23 in SDUC
Thread-Topic: [PATCH v3 05/10] mmc: host: Always use manual-cmd23 in SDUC
Thread-Index: AQHa7hwEpRS+2PLnQkey7+kJ95NKxrIzQr0AgAANhyA=
Date: Thu, 22 Aug 2024 13:24:22 +0000
Message-ID:
 <DM6PR04MB6575DB8E6A8D140097924E26FC8F2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240814072934.2559911-1-avri.altman@wdc.com>
 <20240814072934.2559911-6-avri.altman@wdc.com>
 <CAPDyKFpD75pagXXq6GTvY-P8h9MuhZH00S6NjC_OVZM99C8xSA@mail.gmail.com>
In-Reply-To:
 <CAPDyKFpD75pagXXq6GTvY-P8h9MuhZH00S6NjC_OVZM99C8xSA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BY5PR04MB6487:EE_
x-ms-office365-filtering-correlation-id: 671ab278-e48d-493a-9951-08dcc2adbc6f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NnRBQkdCTDhXT2VEL3FvM0F0OUhLNEJmVGZ6NXBZcGRtakdLWWNhNUxYT0ky?=
 =?utf-8?B?Y3UxV3phOVdlQWNRQWc3THhkZWFsNjcvZWFFenlvbW9iZmd0dGRqZDJncHFi?=
 =?utf-8?B?dzJEV2NJNmlHZzhUTGxOdXpENHpGRFErckpRQmdvcDhlR1ZQQmMvRnF5bU5G?=
 =?utf-8?B?YWhDaEZKMFQ0ZzEySzVYQjh0d1lycHlmOXk4MkFqTzRYdGVsMmVOMWdyTEZN?=
 =?utf-8?B?dFU5SkJGTW5CVm1PbElKMkRURHJ4Mm9Dd0dzaDU5ZmhOeC9WZURRSXhCMEE1?=
 =?utf-8?B?cnkrNXdrL0JGMlkrODhGN2V6T01xRGJ4cU1CTFhPaEFlcUxGTnZrQzdXRm15?=
 =?utf-8?B?ZXB2RWRnbHFXNVVrb01hengvZTVEOGNuVEVrTUVRRTl0VVFYQlJzR1lMU0ww?=
 =?utf-8?B?V05mWWt1dWx3dkFudDZOK0JGd25jb1hnR2w0WDNRMU1oZjBKOFRKSFJhR3oy?=
 =?utf-8?B?MDJCWVBjbzArNUtnN3l3SDczLzZubXg3YmdaTCs3dXl5cHJpamMrNXdmbURj?=
 =?utf-8?B?NzhwNmd0MHJaZVErTmx1ZGU2bXkyeVpxb1IzQzVweTlZWEhjT2YwR0p3M3Ft?=
 =?utf-8?B?eUluaXJqNVdzb0FTWTZ5bzdoU1ZjOTZQOEF2SzYxUjBXb2pzSnovdzN3MTcw?=
 =?utf-8?B?dHhua0thNUk0NVRoZHlzWUM0SHRsbWtmblFPdnJaVlprRzlqd1RHSHF3Ym1a?=
 =?utf-8?B?Wk1rRHlXK1hsT3IzMjVkOXA3TmxTdlNod3lYMmhmcUhvdyt0N1BWd0dTVUNr?=
 =?utf-8?B?Q3hRQTgwRnN0SEZvMC9KUkp5S2I2QU0rWWhSU2xSYjZueW1oRHZlUE5pWEoz?=
 =?utf-8?B?K29ZYlBOeUgrQVRmNDQrSkZxMFFJWWF3UTBFMnAyNjJyUjdSR3BqTUNOYmYr?=
 =?utf-8?B?R3JIbWxWMllXSFo1WVgxMnB6M1pLckVaQ2kzVXFESHpPekQ1em5TTEFTWTJN?=
 =?utf-8?B?MkhVaUtYTEVpWGszNEVqa1N4NkgzT1F3YUp6Rkp2VHpaYTNUMXJvNlNPQzM4?=
 =?utf-8?B?MFl0RVpPZDkxYmFlN2VZQnpvMW1tekxQMEN5bzM1SU9sVGhCYzFEVW45TnN5?=
 =?utf-8?B?bjFlSlZ2VGJXYU1JMUh1cWFSOFVuNnVBdUoxWkU4UURsYzdpWTJhazNCb0po?=
 =?utf-8?B?VjN5UUpiM1RZVjUrMEt4aWF0NzN5OGZKNG9YaENSbzRrMXRjcVgvb0YrZ015?=
 =?utf-8?B?Mi9TeXE1WERuSEx3UE9Td2xQOU80dXY3NXk5bTc5ZTNVcXI4NW0xbFc0eEdQ?=
 =?utf-8?B?MnpCdC82dVRPdms5b0QwYWgvMzFMNS9OLzVwY2hpSVg4bzhSTWgvK25JTHFK?=
 =?utf-8?B?ODZRYzRwTzhqWDd0Y0kyWnoxQlV4bkNjSXJ3MS8zRnBqRFRhdmhDZzYwZ042?=
 =?utf-8?B?RGZUQVNya1BKVzdCWEFHQnQ2VWVBb2NDZFhOZVYwaUpHWHM5T3BLdFVsK2s3?=
 =?utf-8?B?ZEovaEU0SEx6Q1lVQk14b3lhVTFndGt1WjRCNHRoL2pRbzY2TkFwZ3hXM3Jj?=
 =?utf-8?B?ZTJrSzJwZUVqZHU5WHhJN1lnQ1RmMkxKWmI3aVFXYnpJeDhWWmZrRDlnZUFS?=
 =?utf-8?B?bUVOV3BPZHYvR3gvMXlkWVBIbGFpRlFONllLbUxveSt2cTFhMnNxcXRNRmxP?=
 =?utf-8?B?NXFuQ3hDS1poQkZWbk14SlNrZXR0amtkbWNJQ2ZtclJwaFVZKy9yN1JEcnVI?=
 =?utf-8?B?dTh6emhXa09JVjdvNVNNZUI1YjZRRWFjeWN5Mm1BaDFIN1ZsTDRkeG1kOU5k?=
 =?utf-8?B?T2VIS3NiRS9rUEJwTURpVHhpZCtSd2tsZURDNnZJUE5RdFhuZTFIQnBqMzVZ?=
 =?utf-8?B?clBSOG5qOUpRNVF0aFN5OVpLRE53YWRvMHR3NVBSOUtOeHhSNUluTnprOG1P?=
 =?utf-8?B?YTBnUlo2b3psdGlQcDRFUml4S2xQY3hBT2Z1eHFpbHQwSEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c3Zob0pDS2FRbFJvU0FNUm8vemNYUnh3WlRpNnhGWmdPaTBIV25hQnBxWkZY?=
 =?utf-8?B?OWRLM0tZZXdpL2RyQnJwUXFFdGJOaXh6VGpFVGJ1TmVqUTJ1cUVXTjJLZUFN?=
 =?utf-8?B?WTl0NFFRM1Z2ZGFneTE0bjVTdVgwWnNQOHI2RDZWMHlqbjRlR2Z4VHZtTHpz?=
 =?utf-8?B?eVlmSDF4SzNaS0dsbzRjY3d4TGYxMTQ4c1d2bmdwenBaN29meE96SnRSS1N3?=
 =?utf-8?B?eWRjL3lQUFhOWnliZGxvR1F4U0tlaGxMRDh3blZvaVJ2aVpKTEJsMHAycnpP?=
 =?utf-8?B?VHlLZnFrWmRSSTdaM3N1bUpraS9NK3h3OUh3MHNsRHh6TnFhWERtZ20rRkhv?=
 =?utf-8?B?T2ZXSW80RXBJUWJLUGR3eXBzVlI3TVZhZjlFNWxkK1VIaTF4TVdwcEIycjFQ?=
 =?utf-8?B?UG5JMDlLcG5CQlNNamdrN2YxZ0tOVEJBV3FHRytmV3N1b1dLUEdBWExLK0Ur?=
 =?utf-8?B?NHRjc1MvWFhTbnl2YldvdDZ6YVl1TGhVWjNwM3ZScEtuNDZtRHAyLytrelFK?=
 =?utf-8?B?Y0xWMllkQ3ZPSWxyYy9HSmdXR0RVNzBLZi9Mcm40OW93aEhaRFkva0JQRmFq?=
 =?utf-8?B?L01kaTlWemhpQ0JsY0FGSXNxdHFXTUNLOEYybWlsYzI2OENJVEQ2clo1ZlRt?=
 =?utf-8?B?ZmJBWnNZbEVkOHEvRDQxYm53cjhZT2xjUkhBZ003UElUdEw3dkpOVmdSTE4x?=
 =?utf-8?B?Rm1JVERCUm16Qmd4U0JEMWc4QmlnOVBJT1lLbkZXZ04xMXFyKzhiNjJtblJC?=
 =?utf-8?B?T215eE5WcWdsSmNsNGlULy9nQllUa09mWEZ5NnU2bG1GTlFnVlNML3Z6bWFp?=
 =?utf-8?B?VVBWdE1aT2NWM0F3elFnbFdRS0xsNmxBcVorM1RzcnVldGxsYm84a0E4SVJF?=
 =?utf-8?B?cWVKUkxVY2FvREtkWUdnY1MyYmxDWTNJZlN1M0g4RUMrTHUxUjlCQms1dnJk?=
 =?utf-8?B?WWoxNXFmNnIxd1NpV3d3M3pabUVqNXVFcWZRdmc4RFdnVHllT0x3OUZyajRK?=
 =?utf-8?B?R2FOT2lVKzRWR2E3a2k2TTVIVTR0NFJIMjg5SU0rRURpOWxlZ3kxektHUUhr?=
 =?utf-8?B?R1dqK1FQa0drbkVEWFJrbnRaWmoyb3g4dkVwU3c5ZWhMenFlbVdaM1NVRmlH?=
 =?utf-8?B?ZnB0Z0pOVWJlRzJGNUNnVFhVbmdFaEdjYVdjOTlGNlcvRW1DK21tTDJVaXUw?=
 =?utf-8?B?dEJGTkhoYlpwa0lLaDRiSGlmY2Y2cEZIKzlobnRsQTFGTkk3Z25SNlZJdWtj?=
 =?utf-8?B?aUszMURoRHRkc0l4ckRaQVRxZzlRQ1k2SDRKUytFaTRVNy9PVkdheU5BVlU2?=
 =?utf-8?B?U29mMUtmbDBHQXJON1dEWXljTTNBQnBtUFZvSDh1NDVxWFI1TGUwS1hDMDJQ?=
 =?utf-8?B?anE0TWttUlNaUVVMc2NId2g0bENvdWlqcFNXWi9NZTU4UDdXTFFVRFZsNWhn?=
 =?utf-8?B?VzArTmZnZFJZZUR3bDYyZzdnclZrbFB1S0hWOXdYRzNycTlEQTNJclNDRXlO?=
 =?utf-8?B?Z2JnbXVQWnB1VmVMQ0luWlRMTEMxZUg1MkNCNkhkOGxOcVlud3RoNktyK0J3?=
 =?utf-8?B?c1FHZlV0SWxhRzhSV2gzcjZURUFweVJQajIvVTVxajNrd1FHTVRoVDhLcHJT?=
 =?utf-8?B?MEtiZ2JRT3RsV1RvTlkwTGVPb2UxTUxLd2ZBN1ZWaTVRUUlpK3VBWHJ1WXM0?=
 =?utf-8?B?MW1yamNXWXBJYUFReXM4eFlXMUpURUZNdGlrZDd4cEdQYjEvM0lRWlpmMmdK?=
 =?utf-8?B?QU95bmhCeUEyTUJlSXI1bUtOcDFNY2hiT0ZsbnhxdHZhZHZSblowUU0vL1Bx?=
 =?utf-8?B?UUlxTHI3L3dSa2ZKcGpGQmJRVXZDZFFTdTlkRzZmbSt1a1grMnJmSzhKaHVU?=
 =?utf-8?B?OW1FNmtFcFh5Y0s2V3NDM1NrUlh0LzV4ZTRSNkFTOW9jQnRpdnA0KzBmNjNt?=
 =?utf-8?B?ak5HSE11d2xXaDlVRkI0Q3ZpVFR2MWQxOXoxNjFKbk5Ib0JocWw1OUJJV1N5?=
 =?utf-8?B?ODFFSVVnQjNGemo3Tzk2c2dpN0FIWDl0aFg5emJKK01xa1BDUGpEa3R3WDRX?=
 =?utf-8?B?SWNwY2FLVUdxVUpxZlVrTTc2QnFOdTVDOTAxUHc5S0N5T2hRdXZqYnVpUnRD?=
 =?utf-8?B?MmtFd3o3M2dtdE9rakFOcCsxTXVoTW1ibWJvUGNUVDNLRHgrSk5Tck9ja21D?=
 =?utf-8?Q?s4j5L33nw5rrpO+zRPOZwDhHid45La4tFUiMeKjxJxuc?=
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
	60PNLKoSkur+zcUiG/f5gtxqGZswvFIKKPUAYUBnnSJ8a1jrREqAr/zneYECAtbwyZ+Zbp5E79h5YCAVqE4z/CK/XXX0OzcuuSpNkuY3BnfNcXMRGnSA8tw3ThHtOQTJ9qr2NMUQMlhM++OzK2b5Sfy+Pp9hjpN8CMpNfaH3vxBvVrL2Wi1Z/IEZd3R0fi2/4aESx2v0aM5rkOnZ09myamMZXFLMUqqW1eIx/OlZRER1kvu8HIdjRgUL8ernkpVbWWwHmcdO1nP4gD2A/sWvZVRqY8RdNg4XNMGASUTYDF3LBVbMUQecQxMv9+18hnlgJ1UVDIqsikEgWgA6pBf9q/sXzOofPGzO2ZH4MOuvaTQ9Vgw02NDdd/mX1t/ECwcuFEIHODRLn4SjUQDWplJNDWIVpyfVdyxAVXpNKaALLvPOb/DCQ5jUBp0lA/0vAHxMwMey+I3ldL/aC+Iw/9U+FjyCd9CgEabWyHh0PpoqPIyLFHVcCxzMo+3gw9zRZttigSTijyfw/FE4yZoCN21PqrZEidIMQLJXVPFClLhWg+QXpICKu8BzSi1owyNYjyl80znz98N17phjY8GuE0tua6y9IIFqWhkKvRO/4ks1wwVUzB/rOfCLxUw/SKpxhLe9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 671ab278-e48d-493a-9951-08dcc2adbc6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 13:24:22.6247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DZRb+TwXOYoRReQXRPb9PiPWmoU9/U+3rFs1AdLAZSSj/zz/iFbVm314NFhonyX6SG+6XdQvHikFrQwD/8NN2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6487

PiBPbiBXZWQsIDE0IEF1ZyAyMDI0IGF0IDA5OjMxLCBBdnJpIEFsdG1hbiA8YXZyaS5hbHRtYW5A
d2RjLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBJbiBNdWx0aS1CbG9jayByZWFkL3dyaXRlLCBDTUQy
MyBtdXN0IHByZWNlZGUgQ01EMjIuICBUaGVyZWZvcmUgYWx3YXlzDQo+ID4gdXNlIG1hbnVhbCBj
bWQyMyBzbyB0aGF0IHdlJ2xsIGJlIGFibGUgdG8gY29udHJvbCB0aGUgc2VxdWVuY2Ugb2YNCj4g
PiBjb21tYW5kcy4gIEFsc28sIGFkZCBhbiBhcHBsaWNhYmxlIG1tY19jb21tYW5kIG1lbWJlciBm
b3IgYm90aA0KPiA+IG1tY19ibGtfcmVxdWVzdCBhbmQgbW1jX3JlcXVlc3QgdG8gYWNjb21tb2Rh
dGUgdGhlIGFkZHJlc3MgZXh0ZW5zaW9uDQo+ID4gY29tbWFuZC4NCj4gPg0KPiA+IFRlc3RlZC1i
eTogUmlja3kgV1UgPHJpY2t5X3d1QHJlYWx0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEF2
cmkgQWx0bWFuIDxhdnJpLmFsdG1hbkB3ZGMuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21t
Yy9jb3JlL3F1ZXVlLmggfCAxICsNCj4gPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jIHwgNCAr
Ky0tDQo+ID4gIGluY2x1ZGUvbGludXgvbW1jL2NvcmUuaCB8IDEgKw0KPiA+ICAzIGZpbGVzIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IFBsZWFzZSBzcGxp
dCB0aGlzIHVwLiBUaGUgY29yZSBjaGFuZ2VzIGNlcnRhaW5seSBkb24ndCBuZWVkIHRvIGJlIG1p
eGVkIHdpdGgNCj4gY2hhbmdlcyB0byBzZGhjaS4NCk9LLiAgSSB0aGluayBzd2l0Y2hpbmcgNSAm
IDYgd2lsbCBkby4NCg0KVGhhbmtzLA0KQXZyaQ0KDQo+IA0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbW1jL2NvcmUvcXVldWUuaCBiL2RyaXZlcnMvbW1jL2NvcmUvcXVldWUuaCBpbmRl
eA0KPiA+IDE0OTg4NDBhNGVhMC4uN2UxOTFkN2YwNDYxIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvbW1jL2NvcmUvcXVldWUuaA0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvcXVldWUuaA0K
PiA+IEBAIC00MCw2ICs0MCw3IEBAIHN0cnVjdCBtbWNfYmxrX2lvY19kYXRhOyAgc3RydWN0IG1t
Y19ibGtfcmVxdWVzdCB7DQo+ID4gICAgICAgICBzdHJ1Y3QgbW1jX3JlcXVlc3QgICAgICBtcnE7
DQo+ID4gICAgICAgICBzdHJ1Y3QgbW1jX2NvbW1hbmQgICAgICBzYmM7DQo+ID4gKyAgICAgICBz
dHJ1Y3QgbW1jX2NvbW1hbmQgICAgICBleHQ7DQo+ID4gICAgICAgICBzdHJ1Y3QgbW1jX2NvbW1h
bmQgICAgICBjbWQ7DQo+ID4gICAgICAgICBzdHJ1Y3QgbW1jX2NvbW1hbmQgICAgICBzdG9wOw0K
PiA+ICAgICAgICAgc3RydWN0IG1tY19kYXRhICAgICAgICAgZGF0YTsNCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jIGlu
ZGV4DQo+ID4gNGI5MWM5ZTk2NjM1Li5mNjJiNDg5YzllOWMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9tbWMvaG9zdC9zZGhjaS5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5j
DQo+ID4gQEAgLTEzOTksMTMgKzEzOTksMTMgQEAgc3RhdGljIGlubGluZSBib29sIHNkaGNpX2F1
dG9fY21kMTIoc3RydWN0DQo+ID4gc2RoY2lfaG9zdCAqaG9zdCwgIHN0YXRpYyBpbmxpbmUgYm9v
bCBzZGhjaV9hdXRvX2NtZDIzKHN0cnVjdCBzZGhjaV9ob3N0DQo+ICpob3N0LA0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBtbWNfcmVxdWVzdCAqbXJxKSAg
ew0KPiA+IC0gICAgICAgcmV0dXJuIG1ycS0+c2JjICYmIChob3N0LT5mbGFncyAmIFNESENJX0FV
VE9fQ01EMjMpOw0KPiA+ICsgICAgICAgcmV0dXJuIG1ycS0+c2JjICYmIChob3N0LT5mbGFncyAm
IFNESENJX0FVVE9fQ01EMjMpICYmDQo+ID4gKyAhbXJxLT5leHQ7DQo+ID4gIH0NCj4gPg0KPiA+
ICBzdGF0aWMgaW5saW5lIGJvb2wgc2RoY2lfbWFudWFsX2NtZDIzKHN0cnVjdCBzZGhjaV9ob3N0
ICpob3N0LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IG1tY19yZXF1ZXN0ICptcnEpICB7DQo+ID4gLSAgICAgICByZXR1cm4gbXJxLT5zYmMgJiYgISho
b3N0LT5mbGFncyAmIFNESENJX0FVVE9fQ01EMjMpOw0KPiA+ICsgICAgICAgcmV0dXJuIG1ycS0+
c2JjICYmIChtcnEtPmV4dCB8fCAhKGhvc3QtPmZsYWdzICYNCj4gPiArIFNESENJX0FVVE9fQ01E
MjMpKTsNCj4gPiAgfQ0KPiANCj4gSSBhbSBhIGJpdCB3b3JyaWVkIHRvIHNlZSB0aGF0IHdlIGFy
ZSBnb2luZyB0byBuZWVkIHVwZGF0ZXMgaW4gaG9zdCBkcml2ZXJzIHRvbywNCj4gdG8gc3VwcG9y
dCBDTUQyMiBhbmQgU0RVQyBjYXJkcy4gQnV0IGlmIHRoYXQncyB0aGUgY2FzZSwgc28gYmUgaXQu
DQo+IA0KPiBJbiBhbnkgY2FzZSwgYXQgbGVhc3Qgc29tZSBtb3JlIGluZm9ybWF0aW9uIGFib3V0
IHdoeSB0aGlzIGFwcHJvYWNoIGlzDQo+IG5lZWRlZCB3b3VsZCBiZSBuaWNlLg0KRG9uZS4NCg0K
VGhhbmtzLA0KQXZyaQ0KDQo+IA0KPiA+DQo+ID4gIHN0YXRpYyBpbmxpbmUgdm9pZCBzZGhjaV9h
dXRvX2NtZF9zZWxlY3Qoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsDQo+ID4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGludXgvbW1jL2NvcmUuaCBiL2luY2x1ZGUvbGludXgvbW1jL2NvcmUuaCBpbmRl
eA0KPiA+IDJjNzkyOGE1MDkwNy4uNTU2MGU3MGNiOGQ0IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1
ZGUvbGludXgvbW1jL2NvcmUuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvbW1jL2NvcmUuaA0K
PiA+IEBAIC0xNDIsNiArMTQyLDcgQEAgc3RydWN0IG1tY19kYXRhIHsNCj4gPiAgc3RydWN0IG1t
Y19ob3N0Ow0KPiA+ICBzdHJ1Y3QgbW1jX3JlcXVlc3Qgew0KPiA+ICAgICAgICAgc3RydWN0IG1t
Y19jb21tYW5kICAgICAgKnNiYzsgICAgICAgICAgIC8qIFNFVF9CTE9DS19DT1VOVCBmb3INCj4g
bXVsdGlibG9jayAqLw0KPiA+ICsgICAgICAgc3RydWN0IG1tY19jb21tYW5kICAgICAgKmV4dDsg
ICAgICAgICAgIC8qIFNEX0FERFJfRVhUIGZvciBTRFVDICovDQo+ID4gICAgICAgICBzdHJ1Y3Qg
bW1jX2NvbW1hbmQgICAgICAqY21kOw0KPiA+ICAgICAgICAgc3RydWN0IG1tY19kYXRhICAgICAg
ICAgKmRhdGE7DQo+ID4gICAgICAgICBzdHJ1Y3QgbW1jX2NvbW1hbmQgICAgICAqc3RvcDsNCj4g
PiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0K
