Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A44D2D73B4
	for <linux-mmc@vger.kernel.org>; Thu, 25 Sep 2025 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815020; cv=fail; b=T9eMUy5u7qfxrkMq1sOKYuG7WBU7lSa0eusZWOUBVaCy7i2e9cD5ESrJII3Bkdgqwg1pqpS2WMcAUD4/a8X8rDGiZ+nL1dEXY2kTXseEAPT7h2SCdUYY1aB0mTdTHGfXszKC0YvH18pegR1d30OKkPPWvgqLCTIKN18hrQWpFj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815020; c=relaxed/simple;
	bh=VO1ohPcu7NUwzRetJIeYV6a4UHo429ALf4PCrrvZGZc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d8iCGmNKfJ3oMC/Ou3nqEGoeFO3gv195aY61Qyfln+Kj0G8gGCowZIacTts1hTDEv/e1+5ceF8Gt06FVXt1kSOXUTjq6+5ZXbPtPDq3Yw3Khs9Yt/ou7lxhHsfQab/sbyi3mSMgsdspSKvBX/Pk7roSfZJqgUCDNdfgJ6gk3GYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=XDeC2GzR; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="XDeC2GzR"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1758815018; x=1790351018;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VO1ohPcu7NUwzRetJIeYV6a4UHo429ALf4PCrrvZGZc=;
  b=XDeC2GzRxnG77Xkzf+lgiP+xodXiFHmQcrV3IAB4CDJ0Hw4YfLiBfdj3
   ra6AxST8jEIM0dH1aObzA8IDzIbJiXUTJkgUSg5zt1BSlOsggdgwlWPAt
   93H/MktSyA1kA/9NJsDgmjWwCUHD3Fm2xANAnICOtnYDtU41cefJCDhzr
   AfA0qG01Y4RYzngf/RxMxFuVqFSuA091o4nxhmeM8NoZuTtEttGkpjfty
   PbSnaweECZMK2y856liqwnbhbLzZeHMXq1CVqLiJYIc7Kuamtyt8Mk5Yp
   szkpLgKQk0Ds9FA95ULcTj+JuZJyVIJtnSXrqIFS3z2ZQGeiDKUpSWoa6
   Q==;
X-CSE-ConnectionGUID: DsToYme5Tx6Z+6KxIb0BJg==
X-CSE-MsgGUID: W/O+qtx5RvKZmjOUh0sUOg==
Received: from mail-eastusazon11021073.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.73])
  by ob1.hc6817-7.iphmx.com with ESMTP; 25 Sep 2025 08:43:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOIWV2UFh43E/PBL01qjc9hTszkMe0ivqqi7FbRB/y6zhsy453Np9PaixfwzjA9ku6kDtiFwOSFFW6JdS9UIjTn1TRBi4ayRk6TARb++mp98iZZvsXAqnr3tf1ApzJ1ca9XKr50GaBBdPiFpaDON3tyF0hmLHxgJnzgfDPVo5UnG1SLMG5GTKD15yYFCVAWbuUvhyQpgEogGKfgFkziRVZyscTVtRdH78VESWyjDSuPn5MC+IpqieYMNUfzYAaryIkOhItoyLZBoHSa5j0n5t4GqFJXSB5bIe8wYOuNyGWbFEP9HLjmWg608OGhBzr7Q/G7rrP0sM+BNdBDBekIRtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VO1ohPcu7NUwzRetJIeYV6a4UHo429ALf4PCrrvZGZc=;
 b=sqNHcycWsl37CzwsokaY4sEwnCXaZrlWgBlID9Mc4qpT1DHabRTy5uBsG7rq/Heq09wR+lZkGUl+3FQiUo65oZ9Fhks9j9YZGSigH4peuB3bclA/SU62ghzF/9E54iEjbM3ZKg8acTwSwLW12vUiVukDD/3D0Udc/TwZ/1/PrbXBcYVdi86VeW+IQbLMWnQxtte3GHCu5js6Ox61Z6uSolC675zcZ4QdWHHKjp8oI9rGcZsyUH//C+9gd2cK366r7QC4p0HwuEPveNz56gammLTtlzcmeSRvhBbCLw6zG1/IIEgDtMjcegpCfiISuY8KhUiJ2vgvqq3hvZMzwwHEYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by SJ2PR16MB5595.namprd16.prod.outlook.com (2603:10b6:a03:586::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 15:43:28 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::df4a:1576:a40e:5491]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::df4a:1576:a40e:5491%5]) with mapi id 15.20.9137.021; Thu, 25 Sep 2025
 15:43:28 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v2] mmc-utils: Correctly handle write counter overflow
 status
Thread-Topic: [PATCH v2] mmc-utils: Correctly handle write counter overflow
 status
Thread-Index: AQHcGyJ4+2gT7fMgeEaZfQh0Pvb0NLSiGk8AgAHufACAACU3EA==
Date: Thu, 25 Sep 2025 15:43:28 +0000
Message-ID:
 <PH7PR16MB6196BB890A60C66FD6B300E5E51FA@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <167acbaa-c61f-4d75-b2b6-9acee22ddee9@siemens.com>
 <fc592d6d-5f6b-4afd-9e4a-e77987a88a56@siemens.com>
 <CAPDyKForTu9xdtPbYZ-DyLPGrnx7c6aXE8E1qoz9U_yZzAhRWQ@mail.gmail.com>
In-Reply-To:
 <CAPDyKForTu9xdtPbYZ-DyLPGrnx7c6aXE8E1qoz9U_yZzAhRWQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|SJ2PR16MB5595:EE_
x-ms-office365-filtering-correlation-id: fba6d122-14fa-470c-bf38-08ddfc4a45de
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Sll0Y3VINW83RXFRQWRWNVYxRTg2QUR4bEovcHI0NUF1OXRubVRqTUZHaTdx?=
 =?utf-8?B?c3RlUDB2S0tJQ1BpZ1p3SzQ3UlQwUmdieHdyWC9TYXp6ajBrTVlYRkVQMFk2?=
 =?utf-8?B?ZTJ2WU1wRENlblJkZnlPZHpadGZsekt6WkFPeThjZTJvcnp2OEZzOHJSQ0h2?=
 =?utf-8?B?ekRZbHV6M2Y5UjFlS3pwT0s4eHFwUUtPajZSUmQyWnFDOFRhRG1WY0ZLNkNz?=
 =?utf-8?B?MXk5cnk4OVh1YXVKVzdBNCt3cHExY0tlOGVxdWxVZmU5dzhzUWlhZzdXTmE1?=
 =?utf-8?B?VGxXRDZXYUZwWEphMmpxamJyWWhyY0JCUjRLQnIzazRZVFNRam9xSmYvUEZ4?=
 =?utf-8?B?MEp2UGRQQ0VsTVVHMWRvUUptZ2I0cDNSNlVOVHVDYW1SL0YxNk0wVGhlQlNB?=
 =?utf-8?B?YkRLVUdtMzBEUVVXWVJaSzZvWUtSSmo5VzIzcld2SDYra3R0a0ZhUzhCazRI?=
 =?utf-8?B?WWdsSXp2NUN3NEpqQkJLTlB2SFQvZEZ1WXhxMTlpZlFCNTVMejVWWlF1OG1B?=
 =?utf-8?B?WEJ0STJYY1RDYnhwZVd3SEVyZEhidzg5ZDR1bC9hdXVIUkllSHJqWjAyTEhP?=
 =?utf-8?B?VTVlTmNOb1dWbnlZcEFYVUN0ci8rWEVLblp4NWExY2h5WFNDQ01SQVh0Njd1?=
 =?utf-8?B?SkQvVzRDaDd2Tll1WnIxVnc5Y0IyVFZNZHZuOUFSRXl6TmlmdTM4eEk5ajEv?=
 =?utf-8?B?bWZMQmFHelRRanV3QzlPSnFCMU55UU5rRzRoeFJGWE4yNGNlRVJIZDhGalRW?=
 =?utf-8?B?MVBmdUlSQnZXc2NzbWtYWE5Ka2NmRWRKTElkVmtHT0tsQ3c5VkZ3ZG80Ni80?=
 =?utf-8?B?LysrekwvMkUrS09Ca3UwSDVvMTBIemRNN3lMc0xQbERyL08zMCtJV0JkZ0dQ?=
 =?utf-8?B?VDA1RHNvUkFaM3oyZDBmTHpUeko0MGNrUHBrK09jUnJkenpURWY5MkVZZHNQ?=
 =?utf-8?B?cUNzZ1hrdDVneUxka0tnalZ3aW5lcEJRYWZpVlNZM1ZTWjdjTHMzdzdBdFVx?=
 =?utf-8?B?YTdTdmdLeU1UREsvZjJ0dXY3SWcyQjJzdTBmSERONlU1RDRrN2FuZmJLZUtP?=
 =?utf-8?B?aC9hbjl0bEsrb1lMUlRXR0V5R21ZSkRnZHB0aGF6VXFqK3RvcUNnQ1NBNWlt?=
 =?utf-8?B?VHRzcGRZVG5hQVlQckR1MFN6Z0VPeC9xR05UcDdEalpWNEdKbHF2ZXRKZzFq?=
 =?utf-8?B?OVFsSGdoeEdhbHVkZG0zOXNVS2hQN2w4bDdHRDFWbUVZYTA5SHQ0NXNySmdU?=
 =?utf-8?B?MzE3YmpRcERaYk4xUy9zdFYxZVplbFliRU1qeHJJNEdTY2VQVU5qdkFkWi92?=
 =?utf-8?B?TUV5Smx0ZjdTWlplRkJmTktWUjhLN2FrSnlPWXY1VVhWdlZlcUVwQStBckNG?=
 =?utf-8?B?Y2k0eWlFQk1ROHBueUtVYldVU29HVktYRjc3cmZPTENSZHZzMzlYblZSNkJL?=
 =?utf-8?B?anJTTkxEb0NDRTYwa1l1Q3p5WlJNeWVPWSt3U3pRQjc5ZFpreFkxWHBLZURE?=
 =?utf-8?B?ajc3SStrRWM4Y0YyaXVoK0xLQ0xTUzdlbE53VVNWUTZ0Q0hJTWkrMUZ2enV6?=
 =?utf-8?B?T3M0YXQ1UmNObEtHaGVicjJ6ZWJ5cFBQRzNvZytBT3pwTGtVZjZBR2Zna3JD?=
 =?utf-8?B?OWhVaWx4eEdIdXVGSmUyNjEwZTVUZEFxQXJtekE0Mm1ERmpSUmlsWFd0SzAw?=
 =?utf-8?B?bllYanM2U2lBYVphbzhHNzJmY254QzEvbHI4YUM4azVKcG1PUmFpQWJSL3FR?=
 =?utf-8?B?YkRITWNuVlVhZ1hYZTlzYVp0VTFldEpxU3FCMDAzK0x1bHJ1d3Y2Y3VJSVl3?=
 =?utf-8?B?T1J2NHFaRklVcVpmWmlJQjRpNzRoTjJhY2FLYTFLN1BpSmE4SlZOOHJ4ZzVJ?=
 =?utf-8?B?Y1RCUkQ2b1VFdEhZWmd6cmFLZW1GcmszQlRreW14TmQwNmZPTnRxTzcxU3hF?=
 =?utf-8?B?dVY2QlBKblNySUpwdWl5MmFmY2FGL0NCcjZTVlNVdkdvY1gxdFc3bEpUbEx2?=
 =?utf-8?B?SWQzek5QckpBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bjRLUEZXUFpQdXRXcXMrVkM2MmJTWExkQ1YzTUwyM0RZc3RlaU9DSEZzc3pm?=
 =?utf-8?B?OEg4ZHBPVTlvSTZGTGRhNHJkVjV6NXRoTGRnRlJlalgvQm5odXRVZktCbjBy?=
 =?utf-8?B?UzEvOGgwUjc0UWNsYnlKQ0NiM29yNWdoMmpRZkVZalo3TG0ySnNCNzNzR1Vq?=
 =?utf-8?B?WTY4cGFEZXFSNDFKc1E3VGsxYkZjU0ZQcDIvYTdMaDlkclpwN1IvbDQzWW5Q?=
 =?utf-8?B?d0dXMGw0azk3NEVlQ01VWUt6WjhHRWY4SGRLT0dpaFA3NFEyZSs4TWVHTkNl?=
 =?utf-8?B?R2p1Tk5xdlc2UTVqMDdQWHIrTkYvV3FQbFVIRCsrcWwvTGpnKzVjd2wydkxX?=
 =?utf-8?B?TXhLQVpCSmg5NUFXQ0tBcG9zVmZuc0hobi9pd0Y0aWNsU1k4RmpzUUQrUXV2?=
 =?utf-8?B?RFlWRm9iWXMvdnd2dDdTekl6Y0tvQjJJeCtwQVA1MzZrTkczQ1kzRGVtc3Z1?=
 =?utf-8?B?RXlHNGdZUlJnSFZDVUo2WWN0NTZ4KzBJNUlpaitMdEYxNkM2dUxQS3JYV3NU?=
 =?utf-8?B?a1dxLzYvczBsU2hUdFJuQ2MzcFJOdFAwRzBtQjl4SDkxVWFsVldRaEtCSzBL?=
 =?utf-8?B?MDl1NTIrTmpHR1FUN3llSHFBYTYrQkwzTTVtdVZyRFFLZmZPNU4vb0x3aG9W?=
 =?utf-8?B?dnlMQTFWemdZZit6OWFvL05UVWdxUzM0ZWdqUm0rVmZDTkUzT3g5TENXYlhy?=
 =?utf-8?B?VUk1aGZKclJqbnIrL2lCdWVMWWwwZkNyNy96d2FUTGFzR09obE9qNVhrRi93?=
 =?utf-8?B?Yks3TGF4U2huSDBzRkpGeTEwWnRaV1dMUkFzOUloaXVSeWJZUVVBQ1lVOUhC?=
 =?utf-8?B?TFN1Tk1MYjMxMHFxR05JTTQyWEJ0cHRRWUZiOFUyUnNiQTlrMGprd2hON01R?=
 =?utf-8?B?bXZrQ3F6RVFoRElVek5hczl0cXh6ejlwOXZpTGtDcVZCNk9LSGNHZmVFaWJC?=
 =?utf-8?B?TDNUM3J5OVkveHFraThENEJSeUtOM3dTcmNUVWIyTkZCWHJYY0MrNEQwaTFt?=
 =?utf-8?B?L0xuQUlRS0RDa283T0tyOVcyOE02UXFXalIzcHNjazBLUlF4OGtVQUEwRmI5?=
 =?utf-8?B?WFhPL09Ob2oxMENxOGM4YllTdGF2OC9GZVhMa0VYQ1d0bnVSVDBaZWNwNmFS?=
 =?utf-8?B?TWNWSTV4cnVyQ2JyS01QVy9HT3ppTy90NG9DcWJ4Y2l2cXJvb2VoMzMycThw?=
 =?utf-8?B?T1hMYmd2WjI4VFRoN1JjelZPOENIakFZRm0yVDl6NEtpb3NWUnliOUh5b3VZ?=
 =?utf-8?B?MGxER1ZOclAvOHlJOVZSUStET040R2pyKzVMbm5pTXYwVzRYQTRpZitrZWRi?=
 =?utf-8?B?bHBxaVBMNkRFTWNndVh4Q3pQQndrK1RNKytXRVJqb2lxakYvaGlPUHI3ZTVU?=
 =?utf-8?B?TzNqT2k4QjR2QitKNDdpd0VGSnVEMHJ2dXYrVW5VbXJLUkdtTTE2TmxEU3M0?=
 =?utf-8?B?ZFdLdTJ2VWEvK1h1VURrSXR3R1JqTTBoOUsvTG95d2haNnA1WUZlWVE2TjUz?=
 =?utf-8?B?ZjBRQ0VtUEtHSUNHbHhaMzlIc0hDQ3ZzR1hldkNuSTJiZW1Ha0dLRUJWSzlL?=
 =?utf-8?B?dDZ1N0dOK2hsQzF6RHJpOUxmWHpnSHFhTlA1MDNlL1RuSTA0WEdCaHNvZkFE?=
 =?utf-8?B?QmtmYThHYXZINkhtU08yelJYMUgxdFBMOVlzVFlMOWplY2cybmNXd2dVRERW?=
 =?utf-8?B?bnZKK0tPclFudmhzRFZ6cmtGcU0rSzZEeERIUHV4Mnd2ZTlGQ25nRnZab3My?=
 =?utf-8?B?bm1QQ1hkNDUydU5hVG9wTzE5dEpwRmt0VGtWeDVFcmJQNkxJZ1EvQ1V5Q3ZF?=
 =?utf-8?B?dGNJWC9YUTNnZVZSTXdLSm90YnVGNWtQUStEc2tGblhKUmlCdExuME9CWlRy?=
 =?utf-8?B?MHU5N21CYmdqUE5tWjdueUpUYVJvNU9DZ2I2M3BLcHBtS28xMmgwdGJJVjdh?=
 =?utf-8?B?aThoZXN4R0Vyc0llUy9Wc2NBdEhwd3ZodkU2T21wb2M1RFJLRjBWV2N2WllS?=
 =?utf-8?B?U3FEQzRmWkhKZE5JZHhKL1NzNm9IUXRiK2hwUUhvQkNpUmpLNk1FTzBuQWNi?=
 =?utf-8?B?L1NDcE5LcmxWQUVIc2w0NmViUWRSY1ptRHIrTXByMG9nV3FxbG5za3h6dUpM?=
 =?utf-8?Q?laTvUj+HMH7YgdYRXqM2tZCU5?=
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
	bldxFP6Z6JUwGjOuPs4Rg+nSkEOjTtEK6o3wparziKwBMjO83A1euDYGiKrOuwYPAfrrq3gLfG/pWsPr8Zgl0zNbeeJxZvlge/NK0hjPNj/7Tdzo+tXP8KU8xQYrdZVjvIokvOJmcGpbN6YvtoLVHhS4h3wsIGjNc6rlFZE3KGq99IJyyl1NXi3iAs/j8cAdGC4n5bfoAODEAnbT6KIYqJEjO543cV8MgGQsZUFv/317UIt/epugjTicyX6755f20KXAUFaQZOb+j9LqRrcJCJk6qI6i/UlJwo/13VqqjZYyPvKMpJLqkjVu7ckoUZbMQGUeiwCdmJtnR5Bssv4ROZ9iOVwwqLyZtYyixXcLL8tNZ7fE/GO1yhFDHEJ+iSROej4Dc3nF0BCqdNGGK3ZuX9GvKVl10M2O+9Vj7XKcMpiPEnMMcrOV/UvmG5dXlk+NaMyWA7MpE1jUBRfSNtJsFU+0aEFxMSj0Ki3054KvaNk+I7dlwS16Ue5LSgCEUYSFd6VIDbtauAGOwbMxEJGIgU+rPXWx1hNnTf49cLKSKbPkjxnqpgbfLRJPkRLOt9ocYj+1XLmYLnsyPPp6JlH7O/Ksa29iY6r2XOuZ7rWIC3FAOiD3CGinJau4SIub6Jl/R2O0JKxIANAjs0Dnhg9k1g==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba6d122-14fa-470c-bf38-08ddfc4a45de
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 15:43:28.5866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B3bl5xgzGOWV9Px05tz0ZKfZHF/RIhJy0ai1HxTaq8ypt/XmM3wRpDaFLc4vTzFkUNcb3iDdHU6z76P1Vm8tmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR16MB5595

PiA+ID4gKyNkZWZpbmUgUlBNQl9PUF9SRVNVTFRfTUFTSyAgICAgICAgICAweDdmDQo+ID4gPiAr
DQo+ID4gPiAgc3RydWN0IHJwbWJfZnJhbWUgew0KPiA+ID4gICAgICAgdV9pbnQ4X3QgIHN0dWZm
WzE5Nl07ICAgICAgICAgICAvKiBCeXRlcyA1MTEgLSAzMTYgKi8NCj4gPiA+ICAgICAgIHVfaW50
OF90ICBrZXlfbWFjWzMyXTsgICAgICAgICAgLyogQnl0ZXMgMzE1IC0gMjg0ICovDQo+ID4gPiBA
QCAtMjI5NSw3ICsyMjk3LDcgQEAgaW50IGRvX3JwbWJfd3JpdGVfa2V5KGludCBuYXJncywgY2hh
ciAqKmFyZ3YpDQo+ID4gPiAgICAgICB9DQo+ID4gPg0KPiA+ID4gICAgICAgLyogQ2hlY2sgUlBN
QiByZXNwb25zZSAqLw0KPiA+ID4gLSAgICAgaWYgKGZyYW1lX291dC5yZXN1bHQgIT0gMCkgew0K
PiA+ID4gKyAgICAgaWYgKChmcmFtZV9vdXQucmVzdWx0ICYgaHRvYmUxNihSUE1CX09QX1JFU1VM
VF9NQVNLKSkgIT0gMCkgew0KPiA+ID4gICAgICAgICAgICAgICBwcmludGYoIlJQTUIgb3BlcmF0
aW9uIGZhaWxlZCwgcmV0Y29kZSAweCUwNHhcbiIsDQo+ID4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgYmUxNnRvaChmcmFtZV9vdXQucmVzdWx0KSk7DQo+ID4gPiAgICAgICAgICAgICAgIGV4
aXQoMSk7DQo+ID4gPiBAQCAtMjMyMSw3ICsyMzIzLDcgQEAgc3RhdGljIGludCBycG1iX3JlYWRf
Y291bnRlcihpbnQgZGV2X2ZkLA0KPiB1bnNpZ25lZCBpbnQgKmNudCkNCj4gPiA+ICAgICAgIH0N
Cj4gPiA+DQo+ID4gPiAgICAgICAvKiBDaGVjayBSUE1CIHJlc3BvbnNlICovDQo+ID4gPiAtICAg
ICBpZiAoZnJhbWVfb3V0LnJlc3VsdCAhPSAwKSB7DQo+ID4gPiArICAgICBpZiAoKGZyYW1lX291
dC5yZXN1bHQgJiBodG9iZTE2KFJQTUJfT1BfUkVTVUxUX01BU0spKSAhPSAwKSB7DQo+ID4gPiAg
ICAgICAgICAgICAgICpjbnQgPSAwOw0KPiA+ID4gICAgICAgICAgICAgICByZXR1cm4gYmUxNnRv
aChmcmFtZV9vdXQucmVzdWx0KTsNCj4gPiA+ICAgICAgIH0NCj4gPiA+IEBAIC0yNDQyLDcgKzI0
NDQsOCBAQCBpbnQgZG9fcnBtYl9yZWFkX2Jsb2NrKGludCBuYXJncywgY2hhciAqKmFyZ3YpDQo+
ID4gPiAgICAgICB9DQo+ID4gPg0KPiA+ID4gICAgICAgLyogQ2hlY2sgUlBNQiByZXNwb25zZSAq
Lw0KPiA+ID4gLSAgICAgaWYgKGZyYW1lX291dF9wW2Jsb2Nrc19jbnQgLSAxXS5yZXN1bHQgIT0g
MCkgew0KPiA+ID4gKyAgICAgaWYgKChmcmFtZV9vdXRfcFtibG9ja3NfY250IC0gMV0ucmVzdWx0
ICYNCj4gPiA+ICsgICAgICAgICAgaHRvYmUxNihSUE1CX09QX1JFU1VMVF9NQVNLKSkgIT0gMCkg
ew0KPiA+ID4gICAgICAgICAgICAgICBwcmludGYoIlJQTUIgb3BlcmF0aW9uIGZhaWxlZCwgcmV0
Y29kZSAweCUwNHhcbiIsDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgYmUxNnRvaChm
cmFtZV9vdXRfcFtibG9ja3NfY250IC0gMV0ucmVzdWx0KSk7DQo+ID4gPiAgICAgICAgICAgICAg
IGV4aXQoMSk7DQo+ID4gPiBAQCAtMjU3Myw3ICsyNTc2LDcgQEAgc3RhdGljIGludCBycG1iX2F1
dGhfd3JpdGUoaW50IG5hcmdzLCBjaGFyDQo+ICoqYXJndiwgdWludDE2X3QgYWRkciwNCj4gPiA+
ICAgICAgIH0NCj4gPiA+DQo+ID4gPiAgICAgICAvKiBDaGVjayBSUE1CIHJlc3BvbnNlICovDQo+
ID4gPiAtICAgICBpZiAoZnJhbWVfb3V0LnJlc3VsdCAhPSAwKSB7DQo+ID4gPiArICAgICBpZiAo
KGZyYW1lX291dC5yZXN1bHQgJiBodG9iZTE2KFJQTUJfT1BfUkVTVUxUX01BU0spKSAhPSAwKSB7
DQo+ID4gPiAgICAgICAgICAgICAgIHByaW50ZigiUlBNQiBvcGVyYXRpb24gZmFpbGVkLCByZXRj
b2RlIDB4JTA0eFxuIiwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgIGJlMTZ0b2goZnJhbWVf
b3V0LnJlc3VsdCkpOw0KPiA+ID4gICAgICAgfQ0KPiA+ID4gQEAgLTI2MjEsNyArMjYyNCw3IEBA
IHN0YXRpYyBpbnQgcnBtYl9hdXRoX3JlYWQoaW50IG5hcmdzLCBjaGFyICoqYXJndikNCj4gPiA+
ICAgICAgIH0NCj4gPiA+DQo+ID4gPiAgICAgICAvKiBDaGVjayBSUE1CIHJlc3BvbnNlICovDQo+
ID4gPiAtICAgICBpZiAoZnJhbWVfb3V0LnJlc3VsdCAhPSAwKSB7DQo+ID4gPiArICAgICBpZiAo
KGZyYW1lX291dC5yZXN1bHQgJiBodG9iZTE2KFJQTUJfT1BfUkVTVUxUX01BU0spKSAhPSAwKSB7
DQo+ID4gPiAgICAgICAgICAgICAgIHByaW50ZigiUlBNQiBvcGVyYXRpb24gZmFpbGVkLCByZXRj
b2RlIDB4JTA0eFxuIiwNCj4gYmUxNnRvaChmcmFtZV9vdXQucmVzdWx0KSk7DQo+ID4gPiAgICAg
ICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+ID4gICAgICAgfQ0KPiA+ID4gQEAgLTI3ODMsNyArMjc4
Niw3IEBAIGludCBkb19ycG1iX3dyaXRlX2Jsb2NrKGludCBuYXJncywgY2hhciAqKmFyZ3YpDQo+
ID4gPiAgICAgICB9DQo+ID4gPg0KPiA+ID4gICAgICAgLyogQ2hlY2sgUlBNQiByZXNwb25zZSAq
Lw0KPiA+ID4gLSAgICAgaWYgKGZyYW1lX291dC5yZXN1bHQgIT0gMCkgew0KPiA+ID4gKyAgICAg
aWYgKChmcmFtZV9vdXQucmVzdWx0ICYgaHRvYmUxNihSUE1CX09QX1JFU1VMVF9NQVNLKSkgIT0g
MCkgew0KPiA+ID4gICAgICAgICAgICAgICBwcmludGYoIlJQTUIgb3BlcmF0aW9uIGZhaWxlZCwg
cmV0Y29kZSAweCUwNHhcbiIsDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgYmUxNnRv
aChmcmFtZV9vdXQucmVzdWx0KSk7DQo+ID4gPiAgICAgICAgICAgICAgIGV4aXQoMSk7DQo+ID4N
Cj4gPiBBbnkgbmV3cyBvbiB0aGlzIG9uZT8NCj4gDQo+IEkgd2FzIHdhaXRpbmcgZm9yIHlvdSBh
bmQgQXZyaSB0byByZWFjaCBhIGNvbmNsdXNpb24uIEF2cmksIGlzIHRoaXMgZ29vZCB0byBnbyBv
cg0KPiBkbyB5b3UgZXhwZWN0IEphbiB0byBzZW5kIGEgbmV3IHZlcnNpb24/DQpNeSBwb2ludCB3
YXMgdGhhdCwgZ2l2ZW4gdGhlIEJ5dGUgb3JkZXIgb2YgdGhlIFJQTUIgZGF0YSBmcmFtZSBpcyBN
U0IgZmlyc3QsDQp3ZSBvbmx5IG5lZWQgdG8gY2hlY2sgdGhlIGxvd2VyIDMgYml0cywgYW5kIHRo
ZSBleHByZXNzaW9uIGFib3ZlIGRvZXNuJ3QgZG8gdGhhdCBJTUhPLg0KSGVuY2UsIEkgY291bGRu
J3QgYWRkIG15IHJldmlld2VkLWJ5IHRhZy4NCklmLCBob3dldmVyLCBzb21lb25lIGVsc2UgZmlu
ZHMgdGhpcyBjb2RlIHVzZWZ1bCBJIGhhdmUgbm8gb2JqZWN0aW9uIHRvIGFjY2VwdCBpdC4NClRo
ZSBwYXRjaCBpbiBpdHMgZW50aXJldHkgaXMgZml4aW5nIGEgdmFsaWQgaXNzdWUuICBUaGVyZWZv
cmU6DQoNCkFja2VkLWJ5OiBBdnJpIEFsdG1hbiA8YXZyaS5hbHRtYW5Ac2FuZGlzay5jb20+DQoN
Cg0KDQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0K
