Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD6C199385
	for <linux-mmc@vger.kernel.org>; Thu,  6 Feb 2025 17:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738864530; cv=fail; b=Lmj62PnpVTCrcmAO1R6QxrHLjxOc29VB5Pg+A+uHWbgRE7QxJUf/mYIAfIX9YXwUkMVr6T5cB3r0jGR4oNNucitEXC89VF+QTPi63LEpbC8dZ1vrlZX90la+oH28HK4yBeD+/C1r0lYIzg0P6jljVSJyO2ql8WyZZrZdRWtVMWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738864530; c=relaxed/simple;
	bh=rwJssYO3Bd26XxIGXRwpdUV5ZIi0cbPdNGSX3G6T6Ng=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jSAb7oAsN1E1y/fzjk/a+DGzCh9o2ZCLGYJP/TgMYFkkvnB31oGrL9jblL8gzEyw4+B1xRQWwVfwXTsod+fHY5wB0pIwqKtgIjhgS0Z+DKVqleY1NTfrVIjIUaIuGa+G/fkoQez/5cEWXIlG3J2jtKri2zxaGSy6tZ8/Llq4M7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WNv7YZ8v; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=x3baRPAH; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WNv7YZ8v";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="x3baRPAH"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1738864528; x=1770400528;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=rwJssYO3Bd26XxIGXRwpdUV5ZIi0cbPdNGSX3G6T6Ng=;
  b=WNv7YZ8vKkcKzFp7uszazKaZTDTwKsM6Km/mxlB8zFewUgzBGNtwHLpq
   qSdoWApcXOmv4BUUqPighVR7cm9VbZXKaOZZggD11DROIBzxDtrrddD09
   pchOuUGhoGeHMQ4xY+0kDnYviLX5Lkx7Iq0/eRKCtgt2xNVAX4K1rjr09
   G0HEMxp5JvVrGMZQ/Fi0WhI6KqOmUbpZsIFz9oDbKYFDgsKUzN1lN81d8
   Oh8NWADw9teiwL0gneAoulBU4vlYBZplxwduT6FY+bNAPJaRK5aRhdAod
   +m5/MlBZ5xL3R00XG2yT80TprAOuKalaLky2Xubh1dW/vOMKo5oTCcAmo
   g==;
X-CSE-ConnectionGUID: mpojPDsLRwi5x4cS9ETQ5Q==
X-CSE-MsgGUID: /Q+0GSG2Qb2ISkivH5MXzw==
X-IronPort-AV: E=Sophos;i="6.13,264,1732550400"; 
   d="scan'208";a="39026939"
Received: from mail-westcentralusazlp17012036.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.6.36])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2025 01:55:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+Z2ESYRXBbd9ELCr+nw76z9W5vF5XKbYq6kLGclxEwljohI1BPpZWXgA2AHdY9ItGTMrxH2kpeBIETczeV0sE15PmqQTAx7bznNcUG4Fj5qnHKYlDhEb7rW2PEWKMiXQaNSP14egHKpT9jcUxPIWd+qk/TQaKbY9yzwSgI1aZNkruJCjcNdOkGlUFAWFMZVczgjzrAiWKtd4i7c5hJim0jrJUjYape/ohADm2Sn6ApSukJJ0KsqrHL2TRyTT8mxI0Tz/1iKhOGUlJ8zIzCHU8d4VPMLSZ5zW7wxblQVD2EY3g9lMIzPY6RBrprx/ot0gS2cMoprx/8iaapYZCigag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwJssYO3Bd26XxIGXRwpdUV5ZIi0cbPdNGSX3G6T6Ng=;
 b=YKQ6yZQycAG+6AaUMlABHW8bqYlFOy/8wgZiMgB03VuX8x/Mq7KaU9O4UabTApymNGiNuSAFImrH/woZK+ywePfLTCBfj5NPe641lThN+zpWUSOZqxQFVVJFg+vGCk8C0X9iz6ydgespoXcFQ1Mx/TdCq/dIShYaQbgh3Fe1h4yAJLvQIE3szk80GPFx9D1Jva+gktjDDt0Wk2c0IU1TsjIlCZOoXKIcmYHK7GkOFNoghka33b4+mw8djqL3mGylaeugNxdePAVjMreR/g+vJjdQasiIMzjkf3Nqs9awarTEfM1ymt6haPoOh050erVC6FsxX6fMB8mRoM8Y6VkjjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwJssYO3Bd26XxIGXRwpdUV5ZIi0cbPdNGSX3G6T6Ng=;
 b=x3baRPAHdqGO85IM+41YH1EaHb5Xb/bScAwie1ihEY78BEjabCugC9z5rMnGJPdFGyD3clcDbSNSkUjyXrW0eZusr41v0QyDd8D7gD2rYqdTpqN2hRxF35k8qhYP+2fwzAtBZjyNWfR95gLRP712sN8oZNF622T7J/BWAMs4J5A=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH0PR04MB8004.namprd04.prod.outlook.com (2603:10b6:610:f4::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.12; Thu, 6 Feb 2025 17:55:21 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.8422.011; Thu, 6 Feb 2025
 17:55:21 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Christian Loehle <christian.loehle@arm.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc-utils: Documentation: Add missing entry for
 "writeprotect user get" command
Thread-Topic: [PATCH] mmc-utils: Documentation: Add missing entry for
 "writeprotect user get" command
Thread-Index: AQHbeHL19QwTRLn1uUStnDSOr7ADQrM6W3aAgAAzq3A=
Date: Thu, 6 Feb 2025 17:55:20 +0000
Message-ID:
 <DM6PR04MB65756959E4A73064DA3B57A4FCF62@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20250206083835.1294859-1-avri.altman@wdc.com>
 <5f758b8a-3921-46ec-a3e9-5f9520a1abde@arm.com>
In-Reply-To: <5f758b8a-3921-46ec-a3e9-5f9520a1abde@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH0PR04MB8004:EE_
x-ms-office365-filtering-correlation-id: 11b04b75-ecff-4327-ca02-08dd46d76c90
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c1pGVjVWRlFJTzRwR2Z4eE03YVplSWk5NjB4czkwYlRGZTYrZE9ReStnek9w?=
 =?utf-8?B?dStOY0llc1VqVXJyaUZ1UHphSk82UWRWS1h1eGE5M3ZTdHB2WXQrWDZJNmpG?=
 =?utf-8?B?Q3VoUS9RdnZxeFgyYzAwazN0dXJjc2Z5Y2JNalUyYm42dW5aZkhNZk5tdDJX?=
 =?utf-8?B?K21IejJaNkN1VWlrSy9UU2c0bU5BOWNQNlBTQTIxejltSmdIb3AxOERtNlpT?=
 =?utf-8?B?V0lXZ3p4YVlMVkRhd3E1Rm1LRmo5WEw4NlJFN1dId1Nya2U4SnFZTEVMRE9C?=
 =?utf-8?B?RDFzM3NpTWFsWXVCYm54c3FzVWtYRHVjZmoxdGlhWUY0ckM4cGdqVEM0QWdV?=
 =?utf-8?B?K3dQVVBKTjNUQUI1amtHZ0tDSzJWbXhHckUxSm5MakpPT2UxSzRwVmdEdGVY?=
 =?utf-8?B?Zy9HcFp4ajZObHEvcGhQWXdVRzgrR2l6Zm8wZHEySmtzejlrTlpHejhLTENu?=
 =?utf-8?B?ODFET1pIaG5DSWRJUXlQUDZIU05RWERHYVNpRTZwb2I5ZWt4bHRGMHoxWmRi?=
 =?utf-8?B?WGdWbzJDUnlnY2gyYTNQd3p5ZG5tUHZ1dGMyWnBQN3lXbC9CNFJoT1lnSHAy?=
 =?utf-8?B?czR5aGJ5bXFMNkt0RU43c0VocFN0NzhiTG5OSG9ON21lb1NkSVFHalRKbUUw?=
 =?utf-8?B?QlRQN2d5R1pmSGZJSkZsaXY0QSs4WktZTi9NVEYxWmk2NncxNG40V2VUcFFH?=
 =?utf-8?B?TDFrSjFNTGlNNEszazBzaDFsVituRUZRemtVaUwzdEhDTHhlTmhQQTRkOEI5?=
 =?utf-8?B?RG5USk5VSUJHOWpmU0s5VzBZRVgvelcwZ2JKSGJhZFJBakE1cHY3aUVjOVNE?=
 =?utf-8?B?a0Y0WGVubVZ3dFNjcWNPcDA4aDJ4YTN1b1BtY1huWDdlT3pJS0NGWlRFcTJ2?=
 =?utf-8?B?d2RFNUgwVU5UZWtobzMyWlNEVTc1M3ErUVo3RzFBZWNXbEhlMUFVRXBJR0pl?=
 =?utf-8?B?SGFZZ0kyOHM2L2xUbDA5RUZZOFlRd3JsWTRHL05nK3NNMElPNTdrb0RoUGtm?=
 =?utf-8?B?dS9MN3dsSFRlMVBSS3l4Tyt5dWdGNitUSVJvdnBBditnRkhCdEFOYU5SOHhi?=
 =?utf-8?B?N1VkTXRvSkJ2QnRKblNJNHRsR1JTQXZxT21ncjFoMVBOUXNYQmlHUUxkMW1O?=
 =?utf-8?B?THc4YUtsUDI4b3pVa0diaURjK1daQklUMmJFSFQwbmtkZWRiMUpEMVl1RGlq?=
 =?utf-8?B?NDFLN1VKRGtBSGxVUXBqcnhnb0lRV0JGV1kwVUlRTVlRQmRlM2x3NmZXMTZ1?=
 =?utf-8?B?WjBZOWROaWpVMlJsS00zdllSMkNGL2ZYelcwTlZZNWMrR3dUbGNSOGE5dDVy?=
 =?utf-8?B?RGtzMmJXTmRzUFFHK3FQaWNCSVk5dFZFY3hINGxOVk5Ya2V4dHV1RUVRcEhG?=
 =?utf-8?B?T2pmOWNxaCtWL3R3MGc1c2xXbW91ODNyc0VtVlZUYzQ5b0k0M0ZMcy9ueDR6?=
 =?utf-8?B?WmNiRG9YbVg4L2ordGY0Qkl1T2ltMWp6aU4xSmtEWi9HSStyaW1jVWlRUFhz?=
 =?utf-8?B?ZlJNTnVHdzFIaVlBUjg4WG9IOCtlb3c1UlNaMU5KWU04Y2pWK0JiNnhLbEdT?=
 =?utf-8?B?azZHN0h3ZXA1TXRTc25SeU1EUjVCYnlwNlpiUDdSZ21SWmxwNlV0aU10WHVm?=
 =?utf-8?B?cmc5M0xpTHJsMGYzVmpQbCtJWUJXUHMrNHJJUk04Szh5UlV6WGJIQWVvQ1Ny?=
 =?utf-8?B?bkdHNDFUalNMRFU4ZmhwN0pqY3NTRmgrV2ZiNWtnQVJWM1F4L1JacnEwSzc1?=
 =?utf-8?B?UTN2ZnV0TkhSVW1CbGdmZmFPZnBCbGZoRE5MOVNtY0VBYnpsekdKSWdpNEFp?=
 =?utf-8?B?SE1sVzlMdHhGMGg3T2doZlhFVUNhS29hS3MwekNTUDdnQXBtSkpmTEQ4U3hq?=
 =?utf-8?Q?JjYnw4A5TYI3t?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OVAyVFBaRDlBeC9sc0pkdG4xWnFIYjN6WWc4MFVzVExpS3Z5N3JXV0JVQkkw?=
 =?utf-8?B?aGxQV1BOaFQxK3dIQWJlYXFoek9rYTI3aW54S2N1OHhObndRQ3hwQXY1aEta?=
 =?utf-8?B?YUVTQ1ZUdVRYbnA5ZEkrSmJCTWRaVllaQnhIMFZsQlBxVUZjSWZTUkg2cUdH?=
 =?utf-8?B?c0xZWGhoN0Q1NGhtTWJFc1kxb1RBZFBYb01XUmtkV2VLSmp0ODBoUlJtZFcr?=
 =?utf-8?B?NWtSMzArOTVNY2NjdSt1UnVKN0p5R0ZoMU11RW9USWlMa2JRdTBmaVFYYmRo?=
 =?utf-8?B?bjlsb0QxMjVnQ0g4YmdGdTRwNDlya0sxTEE1K0NvSFNZRVl2YmtBQUZsOVpq?=
 =?utf-8?B?bUdyK3ZyKzI5THAwNHZoeU1KWXNnK0FVaWVJdGhHOUM1WHcycFk5Z1NuVFdL?=
 =?utf-8?B?a1ZTWXlGUXhwWlFhU2pTVWJlWVNiNTlMRFUxOXBvblBDcTBzbzdTMGR6ajVN?=
 =?utf-8?B?d2I1TXNJd3JpRUhoa1BvQlBQbDZBaFRaZk02V3lZTkIzdC9YUjM1MHhpZXBJ?=
 =?utf-8?B?a1RJRE1WOFFCWURTQXg0NE1hc3Nsc0hmdjFIc1dTa2Z6dUcxUXA4cTZCNXl0?=
 =?utf-8?B?a3pQTm1FZnFoZm5xSkNHc3c4dklzSXBKOWJqaFpCRWtMbkxORkl4MVBZSEMy?=
 =?utf-8?B?cUQxMHBOUDQ4amZHTlR0bmVuZVlwa1QyNHRSWkZ0ZDZYeTkxem1xRmRqanJI?=
 =?utf-8?B?Rm9qVytocE1oeUFJYWpZZjlZVUZqSXZpQXRrSjBnY0NSWHJsbUZVUGtndWtZ?=
 =?utf-8?B?ZE95dnpTcE9KdzEydVY1N1pQaWhtUlNFdUR3MGozZVU5RHR3ZEdqQ2t0dWUy?=
 =?utf-8?B?b2h1dE04TXlBbHNwdWFWM1ZmMXZmSWY0UTVMaGtHYUtzTzF3bkRIY2ZnbjM5?=
 =?utf-8?B?ZVpDYUd5eUxzRXlVRSt4MVJMbUZCNk1kWllqSXgzTmorREk0TDZPMUFvWEwv?=
 =?utf-8?B?T0ZrMXBRU3dhNzZHZHBqM3lnVWZ2c2lhTG1SQlpPbVFtb2p1QytnV1d1UEJo?=
 =?utf-8?B?VkZZaklzaXdHWlNxZjZ3UjlyaFk5RENybVRCSTZpUzMxN3k5elVQSWtTdlBN?=
 =?utf-8?B?YnliTlQxcU9YOEdLcmJOejA5Vi8rRm84b0NVb1JoRHZONDNpUm15bS9HYzk2?=
 =?utf-8?B?WnRraEE1RUUrcml3RkVLclh2ZTNabTRWbm44Vit6M1dhV3JFUTErSTBjVW82?=
 =?utf-8?B?ZzBDN0QzOXRCVmw1c3R0WXRLOGJHdWZKdk1VdjBZOFc2cWJDclpUL1BtbjFq?=
 =?utf-8?B?TmZ5d043dGJZQU1SYnhlQXF6VU1UMjZJRVA1aXVBaitTdk53MDZ0T0RsdHBU?=
 =?utf-8?B?bEN0QksxczRlTzBUOWVnL3lwTVQrMEl5WjlvajlqeUZsVERFeW5IT1FCajNh?=
 =?utf-8?B?TVBjWTVWL0dOR21lQTJiODJkMXpTY045ZnVhbHRmdGN6cWNTYy81OEI1aFgv?=
 =?utf-8?B?dDhTako2V0h3TzhvQUxFQjZGM0R0RjFEUi9GVndyQ3Vra2lsdnhXeVhRa3lW?=
 =?utf-8?B?eWM2NUlmT3BhdjJrd0FKcDl4dTZ3c1YyOFNLSEZzNzgrK3NnTzZlUWcxc0F6?=
 =?utf-8?B?d2QzRDF2YzBzQmc2dTF1K3VFTFRQQW4zQTJmUEZ4ZHliYkNwcFkrYWlYbkdi?=
 =?utf-8?B?N3N0K0dSd3VNOGVtOWJ5ZEh2OGdCbldERDNVR0FRRFQrcUc3RHh6VXlrbzVJ?=
 =?utf-8?B?RzJReFRocXh0VDdlWE9jY1A1Y3dsRGErTHBYOFpIUkdySjJkYnlQdDVrYzBy?=
 =?utf-8?B?cnp2WnVMRW9IS01ZWTFFYytzc3ZhdWZxYzNJKzVCellUdDdsMVUzTUgyTEQy?=
 =?utf-8?B?V2N4aWNIOW5MUk05T1JjSWZaR3hCNWNyUXZweGI0Mmd6M2lsbVM2T011aHlY?=
 =?utf-8?B?LzZjdnA3M2M5Q0R2L2R3WFh6QlNYZCtrZ3RydjlXbGJDdVBBYWtXVEFpaSt0?=
 =?utf-8?B?Wm5kT1o1M2N4NER2M2xVT2Vvb1cyR0o5M1hwdmhSKzVWVDZGTlNONFlVRGhm?=
 =?utf-8?B?cFYyRXdsZTUrajNKampWeHNoZWJzbml3R1dlc0lkR3dxNG4vNlFQUEJoNjNS?=
 =?utf-8?B?a1NwSFJDaWlLRXMyZlVTVU1uM1RibUk4dWpwUVRVQmtLTTUveTlWRHJiakJT?=
 =?utf-8?B?dHJOWmJSdlZYR3d3aWpnMzM1ZzNhSHlmR3JveDA4WU83bUN0bUJTUmJlRjd4?=
 =?utf-8?Q?GzRAIMq9graXsS2wg5EDgT60bPC2ADK0eZMQ2fsnf2bc?=
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
	HtrZW7s9SvK7LQzLBo4QFGP6qp4C4bxqTbZ+gVJJy3jmXUzfOBE+HkNG+IXSoSOQMVguC3tZYvWpVP80Yw1KWciPr2Rr+8ckNG2KyMhik4knY97ko6BAnwI7KOxrJxBqpIfF1uWwwVrnStck2pM5TiP/0GXQRP3DZkZ2lNic9FKXhKqTjDZngT3jcu/MwfKBJT2/Yh5sao0cMZMw2dzC1bAAUYPfHurQyWBKuNXbhnYW7o4T/rJyjc8nX7IVdjI9WSi6tQQ/am6untAkaP77P/t1gwNehMyPyplVKNV9pRdxmF/6JELSJyhaq88PWCyLaM7soE88kfkUxOfpbYxIkdk8yVF1UzJFfNmWwgpGkSrLgRoEo80oSmsEpMXUvtbocNeybdumj4ihSa0+Vl+ad66CNEkBedq0HwF5xWrcTrLs3zMxGP42MH+kGh5NB3bsOyg9cZr8ekK8OZ5/s1mYvrKynx66tPeT8bpI/qeKj4/9/O/KryQxIY0fln+8VlxIt2KKVHI/A8jKgx0p15F+ZyBQdLfJts/0/VeFxRmOsNB6Ap320JwWSrbmR6dUc+ZftWsQa5qZgzTzOWb1MGHfFq3sbAu7HqKkINMZRYzkyj12PMwDirPcbPAO62G99E4F
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b04b75-ecff-4327-ca02-08dd46d76c90
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 17:55:20.9303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qksDmG04xBtoRz/xJl7tti8+K5erF3OE+GCqYxgXSpvj8bXfUU5OI9Ghbs36xAqbFEJcPPr80GBiK0VuW5Ys9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8004

PiBPbiAyLzYvMjUgMDg6MzgsIEF2cmkgQWx0bWFuIHdyb3RlOg0KPiA+IFRoaXMgY29tbWl0IGFk
ZHMgbWlzc2luZyBkb2N1bWVudGF0aW9uIGZvciB0aGUgIndyaXRlcHJvdGVjdCB1c2VyIGdldCIN
Cj4gPiBjb21tYW5kIHRvIGJvdGggdGhlIG1hbiBwYWdlIChtbWMuMSkgYW5kIHRoZSBkb2N1bWVu
dGF0aW9uIHBhZ2UNCj4gPiAoZG9jcy9IT1dUTy5yc3QpLg0KPiA+DQo+ID4gVGhlICJ3cml0ZXBy
b3RlY3QgdXNlciBnZXQiIGNvbW1hbmQgcHJpbnRzIHRoZSB1c2VyIGFyZWFzIHdyaXRlIHByb3Rl
Y3QNCj4gPiBjb25maWd1cmF0aW9uIGZvciB0aGUgc3BlY2lmaWVkIGRldmljZS4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEF2cmkgQWx0bWFuIDxhdnJpLmFsdG1hbkB3ZGMuY29tPg0KPiA+IC0t
LQ0KPiA+ICBkb2NzL0hPV1RPLnJzdCB8IDMgKysrDQo+ID4gIG1tYy4xICAgICAgICAgIHwgMyAr
KysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kb2NzL0hPV1RPLnJzdCBiL2RvY3MvSE9XVE8ucnN0DQo+ID4gaW5kZXggMDk1YTli
ZC4uMzkwMmZhNCAxMDA2NDQNCj4gPiAtLS0gYS9kb2NzL0hPV1RPLnJzdA0KPiA+ICsrKyBiL2Rv
Y3MvSE9XVE8ucnN0DQo+ID4gQEAgLTI4LDYgKzI4LDkgQEAgUnVubmluZyBtbWMtdXRpbHMNCj4g
PiAgICAgICAgICBJZiA8bnVtYmVyPiBpcyBwYXNzZWQgKDAgb3IgMSksIG9ubHkgcHJvdGVjdCB0
aGF0IHBhcnRpY3VsYXIgZU1NQyBib290DQo+IHBhcnRpdGlvbiwgb3RoZXJ3aXNlIHByb3RlY3Qg
Ym90aC4gSXQgd2lsbCBiZSB3cml0ZS1wcm90ZWN0ZWQgdW50aWwgdGhlIG5leHQgYm9vdC4NCj4g
PiAgICAgICAgICAtcCAgUHJvdGVjdCBwYXJ0aXRpb24gcGVybWFuZW50bHkgaW5zdGVhZC4gTk9U
RSEgLXAgaXMgYSBvbmUtdGltZQ0KPiBwcm9ncmFtbWFibGUgKHVucmV2ZXJzaWJsZSkgY2hhbmdl
Lg0KPiA+DQo+ID4gKyAgICBgYHdyaXRlcHJvdGVjdCB1c2VyIGdldCA8ZGV2aWNlPmBgDQo+ID4g
KyAgICAgICAgUHJpbnQgdGhlIHVzZXIgYXJlYXMgd3JpdGUgcHJvdGVjdCBjb25maWd1cmF0aW9u
IGZvciA8ZGV2aWNlPi4NCj4gPiArDQo+ID4gICAgICBgYHdyaXRlcHJvdGVjdCB1c2VyIHNldCA8
dHlwZT4gPHN0YXJ0IGJsb2NrPiA8YmxvY2tzPiA8ZGV2aWNlPmBgDQo+ID4gICAgICAgICAgU2V0
IHVzZXIgYXJlYSB3cml0ZSBwcm90ZWN0aW9uLg0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL21tYy4x
IGIvbW1jLjENCj4gPiBpbmRleCA1NDM3NDJjLi43ZTk0NTU3IDEwMDY0NA0KPiA+IC0tLSBhL21t
Yy4xDQo+ID4gKysrIGIvbW1jLjENCj4gPiBAQCAtMjcsNiArMjcsOSBAQCBJZiBcZkludW1iZXJc
ZlIgaXMgcGFzc2VkICgwIG9yIDEpLCBvbmx5IHByb3RlY3QgdGhhdA0KPiBzcGVjaWZpZWQgZU1N
QyBib290IHBhcnRpdA0KPiA+ICAuYnINCj4gPiAgSXQgd2lsbCBiZSB3cml0ZS1wcm90ZWN0ZWQg
dW50aWwgdGhlIG5leHQgYm9vdC4NCj4gPiAgLlRQDQo+ID4gKy5CIHdyaXRlcHJvdGVjdCB1c2Vy
IGdldCA8ZGV2aWNlPg0KPiANCj4gU2hvdWxkIGJlIEJJIGZvciBjb25zaXN0ZW5jeSBJIGd1ZXNz
Lg0KRG9uZS4NCg0KPiANCj4gPiArUHJpbnQgdGhlIHVzZXIgYXJlYXMgd3JpdGUgcHJvdGVjdCBj
b25maWd1cmF0aW9uIGZvciA8ZGV2aWNlPi4+ICsuVFANCj4gPiAgLkJJIHdyaXRlcHJvdGVjdCAi
ICIgdXNlciAiICIgc2V0ICIgIiBcZkl0eXBlXGZSICIgIiBcZklzdGFydFwtYmxvY2tcZlIgIiAi
DQo+IFxmSWJsb2Nrc1xmUiAiICIgXGZJZGV2aWNlXGZSDQo+ID4gIFNldCB0aGUgd3JpdGUgcHJv
dGVjdCBjb25maWd1cmF0aW9uIGZvciB0aGUgc3BlY2lmaWVkIHJlZ2lvbiBvZiB0aGUgdXNlciBh
cmVhIGZvcg0KPiB0aGUgZGV2aWNlLg0KPiA+ICAuYnINCj4gDQo+IFNvbWV3aGF0IGEgbnVpc2Fu
Y2UgdG8gaGF2ZSB0byBtYWludGFpbiBhbmQgc3luYyBhbGwgb2YNCj4gZG9jcy9IT1dUTy5yc3QN
ClRoaXMgaXMgZm9yIGh0dHBzOi8vbW1jLXV0aWxzLnJlYWR0aGVkb2NzLmlvL2VuL2xhdGVzdC8N
CkdvdCBjb21wbGFpbnRzIGZyb20gZmllbGQgYXBwbGljYXRpb24gZW5naW5lZXJzIHRoYXQgc3Vj
aCBwYWdlIGlzIG1pc3NpbmcuDQoNClRoYW5rcywNCkF2cmkNCg0KPiBtbWMuMQ0KPiBtbWMuYw0K
PiBmb3IgdGhlc2Ugc2ltcGxlIGNvbW1hbmRzLg0KPiBBbnl3YXkgd2l0aCB0aGUgbWlub3Igbml0
Og0KPiBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIExvZWhsZSA8Y2hyaXN0aWFuLmxvZWhsZUBhcm0u
Y29tPg0KDQo=
