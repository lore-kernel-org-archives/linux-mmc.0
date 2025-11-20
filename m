Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94348372AA1
	for <linux-mmc@vger.kernel.org>; Thu, 20 Nov 2025 07:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763622741; cv=fail; b=T3m4sGVIWuk6/HEQhXA8dYlGJLhd/ML06IeE2bW0u/2BQKYa3m0Ug1DWidfAjIkBksnH/f+2vBogfWKHAIURRKFtO3m0dEaPfP/tZ1Sdg0KRlztsVDTMtlAHW1Tk6xmhc/wpzYgo4yyKILRrJ1cAFTwLdjhMTvV1h/+kWR6Mgy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763622741; c=relaxed/simple;
	bh=yGoBa7wJ7h0DtXHaUo1Ah3uKgBWtj/uQzkTcH+CSlOQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FCmSHhDrDmTVYeId12BbhRx5k3FUQHL1P5HCES2iu9VBDZjIqkqZMF4tEJohxqavO8utFY/kjwSID8R2B5F4Ptzb7epYFxfbyrEqLgG1mD2TrJCnWB4bHuQ5wR9eYtu+KTYwY7bmTgUZoBUeQoK5/079KxlEbS4+05a8wI5K8ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=doD2xguG; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="doD2xguG"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1763622739; x=1795158739;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=yGoBa7wJ7h0DtXHaUo1Ah3uKgBWtj/uQzkTcH+CSlOQ=;
  b=doD2xguGLQNsiKE+jjyUlqXg81+rvZGPPTkCAi+FdevICBX+Qd5L2A0h
   /4XVYIWm490bm8P6Ji7ClHe/ZHtHe5o3DttE0AVU3193iziWio9U1lW6c
   //b0SBPzPwldqQxRcUZArNqozR850PQpD0iwz2nROT2Fzn9wey85xe5rj
   ug4rMGAUdKKha7tGt2Khw1s1d9oYHlDYd6DbWuS0AINOZXZi8QGdJfHBK
   2j1QaVH5SxXbNoKWRLEetPf1o2nDKdEQgGq8+RSPzdw7Do1JvCBSSF7Iw
   8YakW9A4Ac78jDmSPMMVOSntL1X9LFe5b73P7XV1C3gFv8j6pe3wxDoAP
   Q==;
X-CSE-ConnectionGUID: UQlyUaefR1GrlSUlOhQ5GA==
X-CSE-MsgGUID: MaO1CsDhTqWKReVUWeDZqw==
Received: from mail-southcentralusazon11021084.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.84])
  by ob1.hc6817-7.iphmx.com with ESMTP; 19 Nov 2025 23:11:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h07mvmGL5IJNkTxuBZf83Pe/R7iNTyBnsYczyid+CSukuO7+FAgCfuIdfSY3IEt2tIvMCIGaPMMQQq4YG4uL1OARTZHsxw8jGAMxcUdur+BU9GAKkYqg96LpLxgzohKJnG7ffRH/oe/ac/hJGQpDlf1e465uUaE6qnwYzV3IsvfYYeYA2HHX5fbmCymDFYmYn6y0sGVIXeCg656Ii5LeCINotVz94kOMZb1ZC52RKrnFWpW/SJDXoEB1hzZT6iSFaOszb3GiaIk4lLsP4mh7PRXbArR5hpfqIXo7aUP+q4JQQLufLfJKdqFV+on1ZYGr7DU59CL7YJDbDFZocwqYAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGoBa7wJ7h0DtXHaUo1Ah3uKgBWtj/uQzkTcH+CSlOQ=;
 b=wVCaKhFCiYirjucOS4aGTpLEhR2zDV2pDtA1Zob0hhzXd37JACKuUWwuCYkgRI0FaQcHiZPyXC1wRAFix5jBRCV/2Ke0Ovgq0Qc2LJSwEp43eoDdW3HInfKfS8srta98oMsuAtNX0x3sF+HL23QXjrJtjbv5CzFLFIxrnfHGMg81Ojx1U5xqqI38kGz7jy3bB1Yc2dssVPhuj9mHt2JYSFQjpm+W4WBEz6fxs/cGHxg/JN4ei9CAaF8XeiB077jOtw2fdGBlgMKeNMuUCQDwvI6h5WWpFr8HGB+MQS1nQtUd5EvLJQtWFDbg4QzJKeJzJ88s4ZVhYy+D4Y3e/vG1Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 SJ2PR16MB5794.namprd16.prod.outlook.com (2603:10b6:a03:573::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.16; Thu, 20 Nov 2025 07:11:09 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%5]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 07:11:08 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: R Rapp1321 <rrapp1321@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: Issue enabling Secure Write Protect mode
Thread-Topic: Issue enabling Secure Write Protect mode
Thread-Index: AQHcWPgNlyHreSNBv0ejp5FJ/OSf3rT7Jvig
Date: Thu, 20 Nov 2025 07:11:08 +0000
Message-ID:
 <DS1PR16MB6753BDDA989F5C3FB93C9825E5D4A@DS1PR16MB6753.namprd16.prod.outlook.com>
References:
 <CADQ69Q6MZYbWh2gV8LfPG80gK2etyhGkjFvZ26+r5gzSbLxwaQ@mail.gmail.com>
In-Reply-To:
 <CADQ69Q6MZYbWh2gV8LfPG80gK2etyhGkjFvZ26+r5gzSbLxwaQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|SJ2PR16MB5794:EE_
x-ms-office365-filtering-correlation-id: 9dd93c45-1081-4c91-afbe-08de2803fab0
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?d0xkTkV2aUxQNVdUY1pXM0FxeEh5Nmd3VXdRQkRPMStrTXR3T0cvQTFZc3JK?=
 =?utf-8?B?NW1UTmR2MGRNaE1vSlVHN2xsaDhKU2ZSQmFvTEdDQmg0WlU2YS80VkVIUTdz?=
 =?utf-8?B?YUg1V1ZFMUp5K3d4VTNiUkNrMzBwd3hqaFR1RWgyNjVpbTNWcUFpY1FKd21P?=
 =?utf-8?B?WExOeWx1NSt6K1RKWTNyUGhuMkVQMGtuak5oV3ZiYjJOU3R5OE13Y0dqVWVq?=
 =?utf-8?B?L2xZNFhOdEJyZXVQZjgyYkRjeVpHZVFTZUdsZjJqenJCVy9XVjI0MHpyWThz?=
 =?utf-8?B?Y0ZHc0w5bEE3eWQ2ZEJleWJobkZsL25pMVprMzM3UjA4dWJxN3U4cE5KK0Yw?=
 =?utf-8?B?OENmY2pQOXRDbzMzOERpNkcwMDJEWEltVjhtRjBrVW1ZYXcra0tHcE1RL3ZY?=
 =?utf-8?B?SFRuZk9vdlhVVVFBRms1YnRrdGxqbE10S2g5NmNsNkRPWkRTb0NUYmtkNHgr?=
 =?utf-8?B?LzN2by95RkpaQU8zM3VTa1U1TDN1WEo4K01qd2JGZEg4R2xVNDdqV1k1aVNk?=
 =?utf-8?B?VjRKcG9SWFJnVGN4OVk0WUJhbDZUSDkwbWMyZnJmbVExN0paWFlQdjAwMFk0?=
 =?utf-8?B?MlZmV2FTaUZYQzNudlp2YjNVNHV0VGtTNTBQQmduMnpFVGF3VHV6WXV5TFFC?=
 =?utf-8?B?a3NzUk50T2VZcGVVR2JSYklEZUZpMGJtRXNtaU9mcnJwRlFlWDFFRUg5SUMw?=
 =?utf-8?B?RUtFaGQvTWpJZ056dUhzdlc3ZlFEMW5XVUIvelRwbUVtbUlhZnNzOEZEd0lH?=
 =?utf-8?B?VmYzY2lsTTZQcTBtdzJPdGxMeE05dGIvR1lYK2RUVzFGS29Yd1NoZk5iOUgv?=
 =?utf-8?B?cHNDN0plU1VUYko5U1ZXUmV0T0RFZWVKdDQzcmNKdWRpVnNLNlN2dkhKNWo3?=
 =?utf-8?B?NTEvbVFPQjM2cFNzQmFYTDNrT1c1RTV5ZXpweklxU0dlTVh0YjZjZnRTd1dk?=
 =?utf-8?B?a0Y0ZTNaQy9yZGRML25Xb1JTZWdndkdrbkdxQjN0bHFlNkxiQjJNTHNUazFJ?=
 =?utf-8?B?VHplL3ZNSDNBZWpEeUhZRzlmVXVBMG1KeUs5MVdrbURxN0dJcHBoMGlwL1dl?=
 =?utf-8?B?Q0NaODNPYllwMytGciswd3FOM0hMZmhoQU1pNVRiMHdmdVRxQnFSRXQ0cHVt?=
 =?utf-8?B?TmtGK2ZORE9jREFUZEVLZWJBZFdZRmhmTzVkYmtqNHNuVTFjWG9Sc05NSC9H?=
 =?utf-8?B?OXQvTDhmRlZBZUJyZVJxUFV3SzQ0Y3RVWXNFSXRlNm8zeFgwU3Byc3lmNTdr?=
 =?utf-8?B?dUx4ZXZaRlg2aFAxRjlHUHBsRENHdksrVkZwVGVaZDR4bSttT21TL090Y3Ft?=
 =?utf-8?B?RFh5cmcvV2RBTWdHUmVmTkk2aHd2Y25oMTUzVDdiYXFrcVorc2lGTXBVd2wr?=
 =?utf-8?B?NUJrRHMwWlIrM0VzajNiRmE0TWswbmtNemNtWUkvaUNxTWFKK2VmaGVIU2VG?=
 =?utf-8?B?Wkxkb3AxYUpOL2srNWExK0NrbHFyckR6Ym1OR2E0U25tM2tzU0ZnbnJidlVv?=
 =?utf-8?B?dEdsenpLNmtIblg1NFRzUWIvOE9aYUhDTUlYeDBwcWN6SmFkTG0rTng1ZWVS?=
 =?utf-8?B?azJwWVpFMnFwMk9zVDZ2Q0NQS2lWR1BIcGFjMSs1bnhYS3BxcXJCOUV1b0hr?=
 =?utf-8?B?NFJGNjdMempoODBMVk5xeWtPVm9iWFdIb081S0x6dmxwYU1GOVd5ZkFGbUFt?=
 =?utf-8?B?UUxMY2VlMlpjVktRQThPdnJvVTZZVGpBc3BiZ1ByLzR3NnRJRUZUYTlBQS90?=
 =?utf-8?B?eUVJSVAzRXVrSUlpQmh6RDRLTW5UNi9rVTdhSjE5WjBWUHh2UCtWV3g3RURa?=
 =?utf-8?B?YzFicnk1V0hUL0FoY3lzTEdtSitvQkprcUx6d2hIKzlpYjdFcTZUbjNKTXhX?=
 =?utf-8?B?dmpIM3ZvUmlid3Y4MlNlRWZ6NWlPc0M0cUdCc09McmFMYm1UMWVkTGdvRUxl?=
 =?utf-8?B?Y1ZWWm5EM2hCWkhkdXRVZ1NkUE5XZmZJeklLeGR0ZnkrbS85ckVJQ3lERUhT?=
 =?utf-8?B?VlFFVzBXY2lBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WnRNK0l2Y3hCQmZ5N1BQeGFnTjNhdkRoWTZpK0tKQ29YRHRRS00zeFdqc0JX?=
 =?utf-8?B?VSsrNEdwYWN2R2dyanZpMHNzV3Q4OTBBR3FVaUdEZkxFdmN6TzlOV21RZm5u?=
 =?utf-8?B?VXNsSmRSNXFlUGwvZmtNeHZKa1E2SnNXRk1ITkxuYW10S0I4WThlZ1NDUXk5?=
 =?utf-8?B?a21GSytuTVJoUDV2SVVHbEdsUGwwWFNERzB6aFE3MTdLcWxNL3RjTUsxYk85?=
 =?utf-8?B?TkllbE5YVXQ4Ymg3S3kreEJrbzFEQmhSSGpkYnRoOXhPd3dzbHh1SUhpeGFl?=
 =?utf-8?B?bGZ3WHYwS01NWThsdVJYWmRzR05FZlBMZGNkTDZncnlCVjZxcVJwZkNYQ0FB?=
 =?utf-8?B?cG04M0d0UnUzbUxZRUJVZjEveGZZNm0zQzh0MGF0bm5FSy9VMVdUU2NCbW1j?=
 =?utf-8?B?Q1c1S2pjQjBIUmV2UW1rRHNCdmVuOVM0bDh3OVpOKzJOVjR5VllMZmRUdi8x?=
 =?utf-8?B?NVppMTdzY1loRHRRU2Vnb2JnQzlsdTg3Tmk3akd3aDl2UzFWaW55WUY5bDNy?=
 =?utf-8?B?b25Ua0pnR2FOL0dBdnZJM01yQ3YyU2hEcHhYcGZMamRjbmphUVRWekhkRGQr?=
 =?utf-8?B?and5OW53czVpOGlrSUZKWjJrU2lBYldXc0ZCK3RvTUdIZ0xuVGpZL1ZXTDZ4?=
 =?utf-8?B?bGxqYVowUXp4ano5WjlaZU96ZnIzQ3lnZkJXUnNVODIwWXUwTlZLWkIwMlZI?=
 =?utf-8?B?cTFZUHlUVGhJUmVrU243bmRZTXdqdk1CeVZPN3B0b3lwWkI4RzRUMHB3YlZ0?=
 =?utf-8?B?alFJcWNsVEN5MGFXOWRoSlBaQWpMRncvNTFTNDdQd2VFM1N5NWp5VitXS1hp?=
 =?utf-8?B?SVhiMmpxM1pxTmh0bDNnclpFVmc1RkhrUGp1U2k4Z2w4UHgzUUwzVTVaMWFJ?=
 =?utf-8?B?KzVCdjNPVXZLWG1IMTc1WjNSVzNIZWkxYUlPTTBxcUxEa3ZYVWwyaU51Ykwv?=
 =?utf-8?B?VnVCdFluSjFqeUFDTnprQThFcUxsSlNzWlNzemx5Y3JxWUowVnh6bFZDd2Jk?=
 =?utf-8?B?Z3RqR2xPL21tYVkwUWtDcitISzQ2L0pNSVZiSlBFS1hiUlNCUGdkNEp5SENp?=
 =?utf-8?B?QXpvM3BzK2Y2djh3eUI1RzlYUDBIRWpRZllOVkdzQ3hBYTJWQjU1YmE4aGZr?=
 =?utf-8?B?ckZRUnpReHZ3ZW9rK1RTVWZaWUhmcnJOZ3RxYmQxWGtBeWdpYU1uNWRFbEJu?=
 =?utf-8?B?K2xuN1owN1JlSnp3UXZxVVRFU3lncGZ0T2JOeG9LTmE2b1RlSUNmMktuSDFx?=
 =?utf-8?B?UitHdDhwaUs1K1ZqalgvWXdPc0VRRXNmYTNDV3R6cXRhQTIyT09aTGl4cFM3?=
 =?utf-8?B?eEpBazhkVGpYTzdOc2p6NU1kY1VIaFFRMjlLV001N09wSUx3TGo3SUV4K2o0?=
 =?utf-8?B?RktTQ0tTZmNSalBMaGpsVGY1VFM1NDE3QVpXcE5XQlFlSENha0FPR3pZYS9F?=
 =?utf-8?B?VWNoSGNJdlZzdGp2ZVlhMzgyOU51N3NmYVA5cU5ld1VVY3pEQlkreGhYN0I2?=
 =?utf-8?B?YzJDeGhtQWxSb1FTNWRGS0wrdXVjV0l2UlRxYWhicWk5S2I3bkVtRDhCYXV1?=
 =?utf-8?B?WjdadmZZRWh2eXJ2djQ2dFJOTlRGK0k0NjM0SlU4N3VKVEtZbzFKM0Y3ZDNt?=
 =?utf-8?B?VjFWY3NlRldtQys0T25TSW5UaVh3dk4vOHlqM3U4NzlNN2FpeHpYamlReCs4?=
 =?utf-8?B?NG54ejZkSW1aM3UzYmJaWDlNOE8zN2QxY3BlUFNqM2RPWFlBQWJwVDRkdk4x?=
 =?utf-8?B?YkVtd2RvTG1NSnlDR1dVY3VETnBMaTlHQXZMMjVGOUVHaG0wcTBJWHhvQUdE?=
 =?utf-8?B?RHdyay9aanNybVlUQVo0akN2Y3AwY0Qxcmo3QnNYY3B4czc5ZTRSeWNqaGtX?=
 =?utf-8?B?Q0xYZDdxOXUvd2FUUnRhTVU1dG80OTZmMURGQkxvTDRBV1NVU2d5OXhhU2NU?=
 =?utf-8?B?azhyUEFERVh3TDNjczRYRGZjK0Q4cVVnVnJRaHA1R1NtR0NPOTVwV2pMYWZ6?=
 =?utf-8?B?REFVbHdSUkhXRllZVmI0UndKSkdpbk5DbzNUeTJLWlREVHRZekFzTXR5dXl6?=
 =?utf-8?B?M3pTd2pZU2crSCt3aWFtSzdVK3dicVlhcisyQmYvWmlMSGJ1cXF5Q3gveGJO?=
 =?utf-8?Q?IymNxfKJtWeJefU/Em+Pwajnk?=
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
	vIFccMMjUTIdDNZHqzwPvSNqqILVwjcGXl6MSJfGwgX5LC4d04LFFX3W9xr7F795abd4Rlwt/hb+ee9LW8b/zLCb19pSHEP7a1nQXRPcwTC4KxHNBZ0w8LAFWHmUS3eEnOywGYLJC925JYnqUO6SMtgK4bZj2SJvTTSY+VnbZkKcO6HWwaYqKka8h1+aJynGgl7FSVrwTwxnlCAFqfWMN+8lzOxV2ngjvcjeg4lr5MGZeskWTTi3P3mZhmIpcVrIQDuJCnxShNmNSozVCu1GZF7c0l/vzH55mAGj9jMzm68bhqVpaLd5PySkKx+igREg5cebO3fPRvX1lswJhWZyKNKm+CxqYI621Tvl5uaqJMQoDr0xHVHinfkmKWh78rOCsDj5eSzWX2KUAx7BJi1GeU1JoLG7B+Pz6KItH5Lctov6VffbsER71QjIsZ3P3sA3bBGGt9Ir+Bj/5uppgdTVfseFegmRrmAbOmA4wyJML4vNXym698C2tz/pyseEiRwphoFvYyLld4R5B8sZbvhmxVWfKcR/C9FWTTl96zPgmr80AWq53TdfHwlD2uyi2bH+kBwYg9kTNbK0ckSpOEG6uv1BARhynSgWWduzSOyKudtI9vrQTZUiNFvazF6mKVV4BXSlmvkzpRco9XH8Wkz5/A==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd93c45-1081-4c91-afbe-08de2803fab0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 07:11:08.8539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lKyAOr3DhsiNfZYpwH8KGB+yt5PqB82LAerzECnBZTGnBpUl42QKemkHojqLg3+b8RVmTg4aos10f83861sxKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR16MB5794

PiBIZWxsbywNCj4gSSBoYXZlIGFuIGVNTUMgdGhhdCBJIGhhdmUga2V5ZWQuIEkgYW0gdHJ5aW5n
IHRvIGVuYWJsZSBTZWN1cmUgV3JpdGUgUHJvdGVjdC4NClRyeSBlbmFibGluZyBTZWN1cmUgV3Jp
dGUgUHJvdGVjdGlvbiBtb2RlIGZpcnN0Og0KbW1jIHJwbWIgc2VjdXJlLXdwLW1vZGUtb24gPGRl
dmljZT4gPHJwbWIgZGV2aWNlPiA8a2V5IGZpbGU+DQpTZWUgaHR0cHM6Ly9tbWMtdXRpbHMucmVh
ZHRoZWRvY3MuaW8vZW4vbGF0ZXN0L0hPV1RPLmh0bWwNCg0KVGhlbiB0aGUgYmVsb3cgY29tbWFu
ZHMuDQoNClRoYW5rcywNCkF2cmkNCg0KPiBJZiBJIGRvIHRoaXM6DQo+IC4vbW1jIHJwbWIgc2Vj
dXJlLXdwLWVuYWJsZSAvZGV2L21tY2JsazAgL2Rldi9tbWNibGswcnBtYiBrZXkgRmlsZQ0KPiAN
Cj4gVGhlbiBkbzoNCj4gLi9tbWMgcnBtYiBzZWN1cmUtd3AtZW4tcmVhZCAvZGV2L21tY2JsazAg
L2Rldi9tbWNibGswcnBtYiBrZXkgRmlsZQ0KPiANCj4gVGhpcyByZXR1cm5zOg0KPiBTRUNVUkVf
V1BfTU9ERV9FTkFCTEUgMFgwMA0KPiBTRUNVUkVfV1BfTU9ERV9DT05GSUcgMFgwMA0KPiANCj4g
SSBiZWxpZXZlIEkgbmVlZCB0byBnZXQgU0VDVVJFX1dQX01PREVfRU5BQkxFIHNldCB0byAxLg0K
PiANCj4gV2hhdCBhbSBJIG1pc3Npbmc/DQo+IA0KPiBUaGFua3MgZm9yIHRoZSBoZWxwIQ0KPiBS
b2IgUmFwcA0KDQo=
