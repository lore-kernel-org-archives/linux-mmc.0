Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DBE2F6931
	for <linux-mmc@vger.kernel.org>; Mon,  8 Dec 2025 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765186522; cv=fail; b=M8fjOdWe8DP6DZRYgN3aaE1SUY5nuA5+4sxLNMv7hjUZyAwi1hneIz4DIcQI1wLy7zDr4UeuiFBAAYabExrWs1xYVOosY18xgf81QKf+0kU0Fh28XR1BLlMwwA1QkaLqqg25conAODb73amwVXxf/+zW2vtmOwAQtiNQa13tpU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765186522; c=relaxed/simple;
	bh=EGNZZsjahHiDmXYQ5nlqErI0rP4SgkLr/pvcffFcg/A=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZjShr3BzwtzUbVuXjkyyPSsEXhOvkpeUvA4n/uKZK5K+O6CEtKtWwl+yuA9v2t7Tlq6CD9WaFhtAC+3cWgagUV9nI5hQh5rYaugwS05+QtXxH5HpAOJWlzh6RSsdh6Aau4lJw+DCtw5c4REZu6EwVAAa9/ao3PmqAK4OHAl10F0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=ZjlMZaR0; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="ZjlMZaR0"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1765186521; x=1796722521;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=EGNZZsjahHiDmXYQ5nlqErI0rP4SgkLr/pvcffFcg/A=;
  b=ZjlMZaR00mqn5f5Ywp6F3cGspp8qjTEeoD3Lq1JOB27lI7URmHydosKZ
   CCyX0pT9NllAXUZNfBbVy8nphOYsgTBPx4hLE6JSWFr0GMwIky0RJvtPm
   oGx12JgrsKbgLweVauRQEqHFkhkJL9GaEEyPPSx6yavNICF8gR/u1dD5a
   0bB1/u0jh4kj0egrZbPKV4u3LgaBA5J0knvqFtnaGeHYmqXjSNvoNmCqE
   esUj/iD1I50ReCJczkHtjFe4WSifw2JSE7TBqbZTN5tQ7T9zY3Wr9Jzkr
   6dQuXweTMwSPo2nwk2Rbmk6kQKXneg7XH199KSzyU83B8f29awr3dvFrB
   A==;
X-CSE-ConnectionGUID: u1JhHNRfSlyrpMExR9S0VA==
X-CSE-MsgGUID: DtwRguoMTVS18OqeaMjohA==
Received: from mail-southcentralusazon11022108.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.108])
  by ob1.hc6817-7.iphmx.com with ESMTP; 08 Dec 2025 01:34:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VT3N2Rsll+VYpZQ4GAEXgnziAgGTVsg7TMW0QKEtQ4Z733/iX9+Kc1DqiUuKHBmKNtjPJGsfKFlVTQ4wIQSmB3/lgBsmNJ/rTQc9VlFlMJQM8zscWDoHKYTs2OkABPlg9Fhkb3Fh4w1bfgiXy9JStCX4QaGbXqynoontJyM/c1ATbtgywtg9F69OGUqJqH47u9RAthC8Fkf2C8bisdKiLr879YlFRLnSnhSZChLm4OGjINx6l4Ea0xy7U2PU887WCWTedzRwQq2rRT3MAEZ02Fss8ZPbzHCRxQCkcjg30GwoemC7Ps5S4d8xADv8Gobkmv7zZBfCXHYGpLVAzK5S9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGNZZsjahHiDmXYQ5nlqErI0rP4SgkLr/pvcffFcg/A=;
 b=aNRFbX33z0KgKO9ZzB3bxW6zNk0YuQ/jKxZPU6fjB6V7HCge0a/NPfChC0dStALrjQQfZQP+nw6K5bz2rxSAFI0BUnBkylcYG4U55+PqiqaKpAOYxRD33nDUJWmhVcZjxJdF0zNPRbT4bjkox5NANDf/SyqZpGou9R6G31x1+vK/ghC9YTtE+6Inqa1nxJHr3u80Gctzc+j4lvAUHetNi1ZKOrw3Sb1md0vuOKhtekZqgjVESL1eeEMev0oqwzP7MFF9m4uFr3E8pHFkJ7m7SR+gQcH2h+woT8O6FogTifKZ3+HChHdrRCNINTU4bHg2iF1XDF+ahJN2ztcFa7ztUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 PH7PR16MB4598.namprd16.prod.outlook.com (2603:10b6:510:125::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.14; Mon, 8 Dec 2025 09:34:10 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%5]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 09:34:10 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v2 0/2] mmc: core: Extend manufacturing date beyond 2025
Thread-Topic: [PATCH v2 0/2] mmc: core: Extend manufacturing date beyond 2025
Thread-Index: AQHcYCa4HuKdBMa2WEG0w7ax6wml9rUXis7w
Date: Mon, 8 Dec 2025 09:34:09 +0000
Message-ID:
 <DS1PR16MB675383ECC94C7BB9882B58F2E5A2A@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20251128052011.204735-1-avri.altman@sandisk.com>
In-Reply-To: <20251128052011.204735-1-avri.altman@sandisk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|PH7PR16MB4598:EE_
x-ms-office365-filtering-correlation-id: 59e05913-9a3f-4a70-bd8c-08de363cf0dd
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bE1pclNWNjJ6cGtuZ3BIckIwTitBNCtTZTFXZ0xtdXlheXRxZFhtS1FCUU1X?=
 =?utf-8?B?WDY5UlIraFRDdERXRHBrWFRlRlRYbStqa29DR08zNHRaNUw5M0NZcjVHelRh?=
 =?utf-8?B?STlqUHdFNkYxK3dzQWR0ekJjREltV0FpMmxrU2lOVzNYT0Rxckl5cHZNclNw?=
 =?utf-8?B?Y21BQm12N3NHT1hYemxIcndrcTlrRUszOEJVazQ2RVR2aGpjU3M1ZnZGZUcz?=
 =?utf-8?B?akdKU3VMY1AyRXAwSTZjT0E2Y2IzTmprYUVSSG1sdzRtU1FManR2RVB2TlVs?=
 =?utf-8?B?L2ZCbXh0SFRIdWtXcnF0ekRzTGpMTGZGQnljRXZqcjQrYlpuTEhzZkV5VXZ0?=
 =?utf-8?B?enZvT0RjeStFNEIwdExtUk5OMUluQjRJc2RMNHZTeFNOa0MrZkhhcHhQNk9V?=
 =?utf-8?B?RTFySFhsWEw2QW80dmtDK1FXbU5NbGVwdk9LTkdmUFpGa1Fhb2RyMEJqZXZ0?=
 =?utf-8?B?enQ5UXdDS0tTT2NRUE9WYm5WR1VpQTZNL3AxbUNIL2NlRFJXNkhXcUxEZlQ3?=
 =?utf-8?B?Z1JFL285S1RnZUNHb0ZBNWVSUy9UbnFXV2tyTmhVbnd1OUl4Kzl1Umt3djlJ?=
 =?utf-8?B?RzRFdEJreFdFeW5hQjZFbnkreUtjOGZvUDlJYjViTk8veFVka1ZjTkIrYy9l?=
 =?utf-8?B?Mm5EWjRyTW9mZlFLN2NrOVRhQnMxc3cvdzd5aFFJZkhGTk1zY2xWY3pTYnpT?=
 =?utf-8?B?S0I1T1lKTWljQzFVSUZOVWQ4VmdaUnkwWjVZUFdtbUtvTy9LN1JPUzBTRXc0?=
 =?utf-8?B?RndtTXQ2QTV1VlVSaXkzdmluNTByWFBFVXN1Q1NSRW4yZkQ1Y2ZHYVBtalJK?=
 =?utf-8?B?MGNTZXh0c2J6bmdkWHdjRjU3M0orRG1EVWpWVER6TnJGaW1xNERhWkU0SEpP?=
 =?utf-8?B?TlZ0aDJyeUd3ZjBWaVFEaXpyeDhoUU5GTk1ESUhuL1E0M3lic3NyR2ZDQStw?=
 =?utf-8?B?UmF5UlRxNmsvRlJSODlWeHFLRmI1UHR5c0pkeDUwVzhGVDgya002K1A2VjEy?=
 =?utf-8?B?RE8ycUc5Ri9QeHN4WVE1Vitnb1hIU0NRZmVCeS95KzdzcmFqYzV4QzQzdUcz?=
 =?utf-8?B?QVdTVnlUZGIrcTlrejFQeGl3bUpWOWVpaW1jWnZIYXdPSFY0NmF5KzNTd0xq?=
 =?utf-8?B?WmhxM2dFRVpneFp2elE0ZWliWFJBMmtUcU81VVU3eXBSSnN5VWZJSG9DZDZn?=
 =?utf-8?B?dVNydGZYS0srRXlkQTVtWUdROFU3aXNXdHpvQnpvWTg1Ly9ZWjBsaHFRclBo?=
 =?utf-8?B?aXZZV3VYNGMvTWlzdkJZaTFsSjlEc3BNcCs3a1BuQ2FjM2JIdW9EZDFhUGk4?=
 =?utf-8?B?ZmFaeTJZdktoc1BtMXdFcUZ3clNTMlVYeldxdHRCaVovUGNNa0FsL0pLaFZP?=
 =?utf-8?B?MEd5aGhXOE9IR3dKZ2JaT2dMV25YdEVZckRNSk1tYkhwZTJiTWtaejlIWkxj?=
 =?utf-8?B?d3lhY3Z5YUxnVEZlc3F3MU5IOE9wYjZERWs2N1RqTlQ4UlltS1oySjB1NlZY?=
 =?utf-8?B?OFh3bS95Q0ZtMEF4YzcyYkdxSW52NVQvVXFiQUJlOUI1WkQvUTdEd1JQTXl2?=
 =?utf-8?B?NWRhOEVyZTQzdXQ0ZkN4SzN4UUpST3E0ZnNuZFNqdjExMmpBc3VlbXZXQUg1?=
 =?utf-8?B?M2VKaWZVNmFQWVY3dnhnbzhrWjBwZDZURlJtcmppVDJ6MG0vV3I4MG5nczFX?=
 =?utf-8?B?NkU1UFdNdkI1eUF4RERrMVJLcWIzYlFmZ2JkOC80Zjh4SlFJVXRhaDhkNHA2?=
 =?utf-8?B?R3JVby9LZElyVkduU2N5ZjlpMEVZMzNiRWFXYTBsT2N3NitJOXc0cjRxVjdX?=
 =?utf-8?B?Zjk0RVh0NUN5bGs4MjNnWVNKSlV3UWt3R2xkREUzZGZMYnlLeUJybmJnRnhF?=
 =?utf-8?B?Z3lIZ3Z0bU5mZmJoL1lKTHVXS25tWUlXMk5pMWxSWGlRZXRtb2w0MFA4SVlu?=
 =?utf-8?B?YzhuMGZETzdLZ2ZtcjJKT2xKbldtZk95MUlBVTZJa3JtcTU1SEl1WnlGTTln?=
 =?utf-8?B?eTk0TzhJZDNqSmd5aVpCTFprbENmSWx3UTB2UVpSTTZiNXliUjV0dms3U3RM?=
 =?utf-8?Q?kDZVfu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M1JxR3VPWHVNaEpYTVBCUE91NXJDQ2VOaUpnNjZGSXlIall6cDJ2dXBFV25n?=
 =?utf-8?B?V0hpV2hCWVBiOEJhTGhoa29qeTJDU1EzVFIvbTQxcnF0b28xd0JORU90WXBp?=
 =?utf-8?B?cFlEU296NmwvVzZZcjBzTHgybE5ZY0pGMnFvSDJNMkNXVHdjaVFaYWNwNlp1?=
 =?utf-8?B?Y1dHTm9neTRHajVtRk9Sa2RVNUJ1NzJNaDVlS0YrRE5WNWxESDJiYkhpTk9W?=
 =?utf-8?B?OW1RMW82ZG0va05ISTF5NVgwUmNKWUI0UVB3ejFxVVhjOGZPRGh4cGtXa1NM?=
 =?utf-8?B?UWNpVlNRLyt3aDlSdVNaUnJJcmc2WDVlL0pJcjlFYmJKaGdOS0dMU2lmMXFo?=
 =?utf-8?B?WGJXSFhlZXVxWFZ6cnVubHJ0SmlYZ2Jac1pUQ0ZQdVhvRjltZmk0c2E4MVRt?=
 =?utf-8?B?aHpFSzdZc005Zm9Oc2Z0eUEyTlZaNFdGUVBtVElYYktKYjhCc3laT2lPbThI?=
 =?utf-8?B?eW9jcFN4ZzhIQ09xQ0VsR2dEREkxTUh1M3V5NGFvTXV1V29CaktMQ1I2cVky?=
 =?utf-8?B?NGp5WSsycHRNQUhIa1piNUU5U1B3eFdrSWQxbWJlYW02ZVRKSWUzdlNBcXBU?=
 =?utf-8?B?N0wzS3RIVllYbllFMXlUVm5FUWdsNTMrbk5LOG11YUNCWlBVc09CREY3cW5y?=
 =?utf-8?B?alBhSGZhcEZ4SVYvZ0RjelltUWJpSmNjVWdQVnk2M01aZndEa0d0dVV0SFgy?=
 =?utf-8?B?WTkzblRYbEFmNGJWOE1OYlNUSGxMclhOTGRzdEZGVStUVXFOblpVSzZ6OStM?=
 =?utf-8?B?YmtHSU9rcExQZGZoZTdlYmlWMVorNkVmbjl3TnBJTkZGTTh5a3ExdXlXTzJR?=
 =?utf-8?B?eHZpMFBnZXFZUGVqWndJQmJrVnZrQUdaNGJYZHk2RktVNUlSRkVzRk1VbXpL?=
 =?utf-8?B?dCtRRUVYNkRZUmhFOGFhTlFFU1lIZUpYdlVLVEhjV3NPN1RlUjBkSldFQzN3?=
 =?utf-8?B?OTE5cnYxN0xINDU5Z1dlWGIrSkN4bGxkMjE1SjNkRm8yVUd0ZXJjd2NaVDUz?=
 =?utf-8?B?UVBzU0o5TFBDd2lGUCsxSEd4b1UzL1hvRzVhZ2wvQUhOZ2hZWkhydDdUWkF2?=
 =?utf-8?B?by9IZ2lyT3R2QXYrSkwvT2hFc05MelUyT3owL3p1UXV5ZjRRUlFtY3BnNXhZ?=
 =?utf-8?B?bnJpMWFFSW1IZGZuSDJPeU1pY1R2Zk1yUXR5ZDNVclhDdzg3Q1g1MVkyMFlv?=
 =?utf-8?B?djVIR3NFeFRuMkdhdk9MNWRrSTlEeGxtK3pJMmZOeHdFQnhMSU1qNmhiVWxQ?=
 =?utf-8?B?V1RCZ0ZidFlvYjBhKytSaGc5OFB0NkpCcmI3N3UxRS8wQkhSaUQxRzVidHl6?=
 =?utf-8?B?dTFWaGl3dmZzNCtoUzZHd3ZVWkdGczRxcUhJdTdTWTNZUWcxWUorbzZsY1R1?=
 =?utf-8?B?TE9qd0VjUCtKUXdiNENISnVQR2EyNUNkNm5oZlRlcHhHSUlHcFN2U0MxZ2Rn?=
 =?utf-8?B?NWd6cU0vY1VHNnl3Q21GVzhmL0FIMU5kOWtYY1M0WkNLV0lCekV4SHhQR0xw?=
 =?utf-8?B?dGFjOXJSdkp2QkhEZDZ6L0IxQlBxSkVGWnFiWGp3RGt3enB2cGdFWDUzMkxG?=
 =?utf-8?B?WnQrcjQxTjlieXE2YlJYVEVJZTJqN2xIVE9uQ2ZYTzcvbE5JNFd4bUhyTmNr?=
 =?utf-8?B?TXFpbUJNaXQ2N3RVdkgvZEJ0WHdsQ3gwRXVURWxqbmlpNFJLQ01KQ2owV1hL?=
 =?utf-8?B?WjdCQlBIZlZqRTV0R2s3QnRGbXZZUDFaUnlDOGpKZlkxLzd4Nlg3bWJWYWps?=
 =?utf-8?B?TUhzZmJyNjBxd3lCMmRZRVVneVY2dzYxWXNmblZCcUs4eFQ2RG1NbkFYazc2?=
 =?utf-8?B?VTNjQ0xsdkNSWlVzZi93M014U3Y4ZHdoUjMvaWVwdXNqNHpYRVpENGxMY0E0?=
 =?utf-8?B?eEJoTldwNjlIeStQTW1HQkkzdmU5MlFJZ0NTUHAwYTZiekRhMnNBeHVISFcy?=
 =?utf-8?B?TWNSdGlRLzFObzN5dEwzQi8rVXZ0TnFmZ015TFU4c0tab0Jydm5rY2taTFNB?=
 =?utf-8?B?UEdLcFBaeGJsMkw1WTVOVUJZdVBYRkYxYmZaVWJCb3I3QUs4YW9aVDdybytK?=
 =?utf-8?B?dFljd1NCWkd2UnJBWGw5cVZBOFJnakpWNlVQRHFVTWdVQnRwQzVZRi8zb1JT?=
 =?utf-8?Q?GExJtpGTKPhwRObn2zJX9BvH/?=
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
	zYYq+PGGx08zPSDlf8fvuliQCGltp8zgGsc5h3oC8hfqtWColLWbHT0xuvI7ynRYCLikPsM5U5FubSQK3iWCH6ZXebzDRgpiB+Z13OAJVTXiFT/j/kBI9bVhBPfRHtILLPmOonauAZgqu0qZ4vB6nIjGYfivnDwIemdVYwP6uMiUXJ3D5JU7F2xjvF9pbKNP0kZgPCgjkmyJFzZKqCbVUCgYLvodezZ5cYmnhMbI8907KUo553V3V6d5HVONTtJn2uB/CQFyG9PcKkCo9sRqeLt7hwYRqKB6xK5fYYguZOTc7ciAyFGLICYKWiHgxLxBCMNhQGVBt+jhgo9BuEwPdGRfw+YMGvzwoMp2c79f301+6OrnzgEx5vgqLiw4dKw8sQSJUM85iF0JzBlkVi1ntvUoOZmEObheIR89FUKusV0lVkC66gdnJAh7nTeDnulgR5K9nE/F7nWDwGQNYqBZsnQIQRPELLaobVVmI9SFZ5vYVLLaMn5PLgLSkLGsowkWjTFo0jHGQtjx48iXLsL3R4NqITXiJfJ21exN1c6tVdPLZ3pgcShCRcr5FuTvMulkEWT8LU+UMQ87YxEg0cPSAXrRAOSvZci9Ms34MCJEpZyWi9TCBvdjkLVdpqYawSZ8fjQd5RJdrOPRDSSAZHQwQw==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e05913-9a3f-4a70-bd8c-08de363cf0dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2025 09:34:09.9914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fDZxDFHfLRRBXM9vPY7bbqjkkGhx70txCA7fIky1QuJCbElWq7F+iy7GuOfCuuJt2DIiCkt+nxyRNrRAfAsY0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR16MB4598

PiBIaSBVbGYsDQo+IA0KPiBUaGlzIHBhdGNoIHNlcmllcyBhZGRyZXNzZXMgdGhlIHVwY29taW5n
IGV4aGF1c3Rpb24gb2YgdGhlIGVNTUMgbWFudWZhY3R1cmluZw0KPiBkYXRlIChNRFQpIHllYXIg
ZmllbGQsIHdoaWNoIGlzIGxpbWl0ZWQgdG8gYSA0LWJpdCB2YWx1ZSBpbiB0aGUgQ0lEIHJlZ2lz
dGVyLiBVbmRlcg0KPiB0aGUgY3VycmVudCBzdGFuZGFyZCAoRVhUX0NTRF9SRVY9OCksIHRoZSBy
ZXByZXNlbnRhYmxlIHllYXJzIGVuZCBpbiAyMDI1Lg0KPiANCj4gVGhlIGZpcnN0IHBhdGNoIGlt
cGxlbWVudHMgdGhlIHJlY2VudGx5IGFwcHJvdmVkIEpFREVDIHN0YW5kYXJkIHVwZGF0ZSBmb3IN
Cj4gRVhUX0NTRF9SRVY9OS4gVGhpcyB1cGRhdGUgcm9sbHMgb3ZlciB0aGUgNC1iaXQgeWVhciBj
b2RlcyB0byBjb3ZlciBhIG5ldyAxNi0NCj4geWVhciBwZXJpb2QsIGV4dGVuZGluZyB0aGUgcmFu
Z2UgdXAgdG8gMjAzOC4NCj4gDQo+IFRoZSBzZWNvbmQgcGF0Y2ggaW50cm9kdWNlcyBhIHF1aXJr
IHRvIGhhbmRsZSB2ZW5kb3Itc3BlY2lmaWMgYmVoYXZpb3IuDQo+IFNvbWUgZU1NQyB2ZW5kb3Jz
IGFyZSBub3QgeWV0IHVwZGF0aW5nIHRoZWlyIGRldmljZXMgdG8gRVhUX0NTRF9SRVY9OSBidXQN
Cj4gc3RpbGwgbmVlZCB0byByZXBvcnQgbWFudWZhY3R1cmluZyBkYXRlcyBmb3IgMjAyNiBhbmQg
YmV5b25kLiBUaGVzZSBkZXZpY2VzIHJlLQ0KPiBwdXJwb3NlIHRoZSB5ZWFyIGNvZGVzIGZvciAy
MDEwLTIwMTIgdG8gcmVwcmVzZW50IDIwMjYtMjAyOC4NClVsZiBoaSwNCldvdWxkIGFwcHJlY2lh
dGUgaWYgeW91IGNvdWxkIGxvb2sgYXQgdGhpcyBiZWZvcmUgeWVhciBlbmQuDQoNClRoYW5rcywN
CkF2cmkNCg0KDQo+IA0KPiBUaGFua3MsDQo+IEF2cmkNCj4gDQo+IC0tLQ0KPiBDaGFuZ2VzIGlu
IHYyOg0KPiAtIG1vdmUgdGhlIGZpeHVwIHRvIGBtbWNfZXh0X2NzZF9maXh1cHNgDQo+IC0gU3Rh
dGUgdGhlIGNvcnJlY3Qgc3BlYyByZWxlYXNlDQo+IC0gRml4ZWQgYSB0eXBvIGluIHRoZSBjb21t
aXQgbWVzc2FnZSBvZiB0aGUgc2Vjb25kIHBhdGNoLg0KPiAtLS0NCj4gDQo+IEF2cmkgQWx0bWFu
ICgyKToNCj4gICBtbWM6IGNvcmU6IEFkanVzdCBNRFQgYmV5b25kIDIwMjUNCj4gICBtbWM6IGNv
cmU6IEFkZCBxdWlyayBmb3IgaW5jb3JyZWN0IG1hbnVmYWN0dXJpbmcgZGF0ZQ0KPiANCj4gIGRy
aXZlcnMvbW1jL2NvcmUvY2FyZC5oICAgfCAgNiArKysrKysNCj4gIGRyaXZlcnMvbW1jL2NvcmUv
bW1jLmMgICAgfCAxMiArKysrKysrKysrKysNCj4gIGRyaXZlcnMvbW1jL2NvcmUvcXVpcmtzLmgg
fCAgMyArKysNCj4gIGluY2x1ZGUvbGludXgvbW1jL2NhcmQuaCAgfCAgMSArDQo+ICA0IGZpbGVz
IGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykNCj4gDQo+IC0tDQo+IDIuMzQuMQ0KDQo=
