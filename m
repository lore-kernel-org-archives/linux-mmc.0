Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3802D1FF7A8;
	Tue,  8 Oct 2024 07:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728371730; cv=fail; b=T9Ry/b1rWDzi+/YcLUpBrDTVhzPGJsVaw9AxfkntgcXxeCAeDs4CcZJ9lY1JX6AEkc/wMu9shqLoj8EioAveHHnPbU0gOknEO349QUz78aa96vl9WENOfm2Phro+k31RXSyGQa4D/eSKCIYjwXrgAFoQTSDeKH6HUjwu0A8Y63w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728371730; c=relaxed/simple;
	bh=pyYFn5n5KYxMlZf1SnCjg9Cu8WJSgdfz4BsLUftb8jw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JymtcPcjSWIxNNSe2qYV4E+CWLrGl563SUMu/R7XaPQ6HKMTA6KLKpmkPR82hn7yC+gLPWgVcn7SHHFGHAsSPGNn8BsSuZvs0qif9BAcs0oB3BxSrliNGUFtDw59qwq2IReUds0tHHXM2XBRxDOBvMxsRL5QOxoMb6NCWGA8KvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=l4FUYy7x; arc=fail smtp.client-ip=40.107.22.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="l4FUYy7x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/NMvDoTKUZRfIORwKiPKOymAza+mgriXiEHexwjnVEWAaus+OMci5XnwQTgOyVzRR8Th4HoznV8XlpBvrpjwwZWvj07qzjxa5fTk0goTm8DfmlRu4FiNrQUBHFJtGtAU5NUKA+XqiSKXn1mvGeA5pst30QbVP6Z5/MxZeMAWHEmrvsL70TSCl085K7o8ozliVohCuCOxLEC7BnCG3CVYLzb/RaAW3xkfO+Pf+jTZMuzfeGTvhZkVRABsj59lp8s1LEnbKW1f7+JSc+yc/ED/53aCnn1BUhC52O0ZjBlDiaRVQRImZjQ80Khe2VgOtzGVHS2EnWKwXQbNqIXqoog5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyYFn5n5KYxMlZf1SnCjg9Cu8WJSgdfz4BsLUftb8jw=;
 b=F5tiU9nzPJQEwj2NzgP+2MpYfOT4WueW6mQOYBXRocwqu7B04fYZIQHKsL1pSdLdlJlu4UV9/DBO+Ro1W5dgu7jcURd68LJ6rA4O8ThoYRfNQHwuS9y7cISk8VwMsSt7d0tivpn6V0Z9ucz/SEStFiQyJZU3lPPUIbul3ICt33xffsq6a0WjmNfZz6GaiJKnQUn0OCIw66RTpcm9504FyVcJt/Z8JoLVTRTruKnepuGtLom3P4P3nq7vDqIsrXQb08Gpo9vjU6Xf0bEFbMv8RK0qD5pFSMR/fXYifThuWVhM297amONS0SVcZvMNS9s26F44b3RbFSC9woV97UbItQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyYFn5n5KYxMlZf1SnCjg9Cu8WJSgdfz4BsLUftb8jw=;
 b=l4FUYy7xRNPDb+ClAi2abNARPGKJq07ttb/8asYVxZTm+1YLteUQQsyR5zNwuRXvZzYJDw6yqaUWSN3HTUwGoXGlGLw9B4LTU8nzgvNnRf/e7963rxtnnBW3ZFYxTSbHhbmR8oTeXjgKym7rHYg9vKWtmK4UTktwp48/Nh2DsAg=
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com (2603:10a6:10:1a0::11)
 by PAXPR06MB8157.eurprd06.prod.outlook.com (2603:10a6:102:1a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 07:15:25 +0000
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0]) by DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0%5]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 07:15:25 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Rob Herring <robh@kernel.org>
CC: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: mmc-pwrseq-simple: add support for
 reset control
Thread-Topic: [PATCH 1/2] dt-bindings: mmc: mmc-pwrseq-simple: add support for
 reset control
Thread-Index: AQHbFlYFMAy48xaGhkKxPcYJRjcHabJ4e4gAgAL0GACAAAeHgIAA/9wA
Date: Tue, 8 Oct 2024 07:15:25 +0000
Message-ID: <fbdf9165-39b6-4d8f-97ee-a6694d02719d@leica-geosystems.com>
References: <20241004120740.2887776-1-catalin.popescu@leica-geosystems.com>
 <20241005182632.GA496820-robh@kernel.org>
 <92a27d06-cd37-42ff-ac48-687981d24d41@leica-geosystems.com>
 <20241007155939.GA849826-robh@kernel.org>
In-Reply-To: <20241007155939.GA849826-robh@kernel.org>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBAPR06MB6901:EE_|PAXPR06MB8157:EE_
x-ms-office365-filtering-correlation-id: 492060e5-53d5-4881-9857-08dce768fad9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y3o5NnplekN6MjJTWGJvdzBzQko2SGhjMG0ra3YzYVA2TWFnd3BNTnBvNEdK?=
 =?utf-8?B?a0huTDZHa3F3YkNMZ2huQ2toMEo3NUdkUGRKZjRYOWlCMDl5d3VrU2Z3Y0hI?=
 =?utf-8?B?bHhwN1Z0NXI0czZ4V3l2RUQ4a09NMjZjZjB5My9WT2EzWVk1ZDJvZkR4ZlJr?=
 =?utf-8?B?d09TZW40R1NBRDZvb25BZHpXa25pM09GbHR0K3dpSjFKSGlzZVlTM01HVGRX?=
 =?utf-8?B?M2hJc0UxeXVkZloyQ1E1UTRKbTNLcWcrZFZmUlpwUzZ3a25DRDJBTEJkdXNR?=
 =?utf-8?B?NHoyUFd0bVo3MzNDbUZwaHYzRTMzRE5ITDFLbWR6eVdzYjBPdTNFcmlrZ3c4?=
 =?utf-8?B?djgwRDN4QnV4VFp0TURsaHlQUGRkWllKZlVyVThIV29LdWxKcjBxZnM4dmdm?=
 =?utf-8?B?RkFrd3VuQWpnWTRYUEFZT0tmdVB0NGJadGNpRnp5TFBjUkxpTTFXZXlMbFBi?=
 =?utf-8?B?MWlYcVNrZUZKVDRKQThYV0F1N205QkJhV2RwUXRhUE9QMTJmMEt0akNoQStl?=
 =?utf-8?B?S09WMGcrM2pUV0VvS2Z0LzN3aTFRTWRiTTdkSUZXTThOdGhhMFYzM3VjTlRX?=
 =?utf-8?B?MERFbnZUY0JCRnJFM0dGK012TndNaXNuaUtnMk9ld3lEOFdqemMvSTNDOHlY?=
 =?utf-8?B?TUozWjlVSWM5dTdUMnAzbys2OUFYQ2h4MUE4ZlNSN2pqWkhtN20xb3E1L0tU?=
 =?utf-8?B?R1d0MnBzZWg0MVFlaGtadW9sWVZYOVYyMm9CTkhZRkNWUlhrWmRJd25rMC9t?=
 =?utf-8?B?WkcrT3A1QkJNRlg5YXFKdTBCMm00K3AzV2VCMnhuL3NxbzV3cVAybElaZERW?=
 =?utf-8?B?WDh3WVJubXVTNFZEVVl3Y0w5c0NLeURzUzBaMyt2QjI4enB4akpSMDNGV290?=
 =?utf-8?B?NVdXWnhqWVV4UzNHZnJ6dnBFd0VPRTZrNmMxMVhNRkNaeTlWazlmb3hXTjFK?=
 =?utf-8?B?Q1ErN0l6MXEzSkR5NkVLUW4zOHVmUmJIcmFpMkpXYTV4bnl5bmNtRXpQaEhG?=
 =?utf-8?B?RFlpN1QrWXZYQlAvVGQ5N1lXMVJzM3JaSU92L3hpcjZvaUEyRnhIUW0veDJl?=
 =?utf-8?B?TjF3MVMxaXhuZDdnTjFVd2xtWkxiV0c5R0JoYmxNWjBEU1l6K0Izemh1MXBn?=
 =?utf-8?B?TXBaUmR3dXpQRWVIMm9IK3gvRmRpWTdtOW9QLzdQOFYwalRxUjR0b2VybElH?=
 =?utf-8?B?YjlQNU9uczB5bUxvZmsyeXFHaHV2SFBiemFxZ0JESnZYcVlITlkzNEdrWUtW?=
 =?utf-8?B?TjhRUUlBbXdWdVl1ZFNWcmZIaW15Rk9oWWxIanRmN2R2aUV4MWlNdGkwZnNN?=
 =?utf-8?B?K04vanloRERoRVhvS2xxQWd3YnA5RU55VGZaRXNIa3pDN1lHTzdnYzQwY2Fl?=
 =?utf-8?B?L1E2ajJGbkdYWExwa2pydFdyeXpnQW9FaThERmtGMFYxa2x5T3YwUC9JNzhU?=
 =?utf-8?B?eWEvNk1sdEl4UVZENnBUSUNFTU02TWtuWWVhem9wMVRUc1VuQ0I3NTZBQ3Nl?=
 =?utf-8?B?YlhzNWxUWFBMNlZReXM2bitGNHlPLzhTS0RWVGdBSlloemsyaG1hWW0xekgw?=
 =?utf-8?B?Tlp1Z2VzWUtNSzRSSXJZN216akxtTE5HRi9rSWEzd0w3d005VHZocE0vMldi?=
 =?utf-8?B?QXExa3F6eTdESU1ML2hhTVR2YXVucVYzOVdLN1lFbXlCR3RiUEN1TWk2NjhQ?=
 =?utf-8?B?NVdEa0gxWkhlYStwQlFKNHk4VFQ2Mi9FYmI1a05VU0wrcXlaWUNoVStxTXls?=
 =?utf-8?B?bHo3alU5aTdJU1lVRnN5T3NjQUxMU2YreVZXNmhScXV4eVhXaDdEb29obGZp?=
 =?utf-8?B?OVdaZWRxNWYrL2s0aGs5QT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR06MB6901.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZStQN3ltMU9ER0pGck1BQlZVWE1XNlZ6V085MDI5dnJZZk9IQWNvK1hCSm5k?=
 =?utf-8?B?UUZ2dXZXU2Q1QTIwbnpjdkdtZVlrVVV2YkZWVytUQklLZjI3bldIdzcvNk5v?=
 =?utf-8?B?emUwekZhQzEyWllCQjJlWXN2SHF4SWhNcmpyc0JDRmd2amhsYS9NMS9pYkNa?=
 =?utf-8?B?UmsxaHM1WjhzZC9zSlJKMXpPSkRGLzRZckwvZjBQbHBUYXVEOTI5alduRmhk?=
 =?utf-8?B?UXE4WmdTN05LQXhlaGtHZGNEQWJSd1o4ZmNXSU9FbFJwRHg4UjZLY3FCRHYy?=
 =?utf-8?B?b0I4eDVKbmwrQ1NOcEFkbU5Fcm42SEFUQlpUdUNYRHM2MVhWWjlURk1SeVFt?=
 =?utf-8?B?OGF4WElxbk5yanFNZXhxcjY2VkxFQmxTTVNobU5ZRHBhMGk1NG9DbEN4RVl6?=
 =?utf-8?B?aGppVzVvcmpyY21yanpqd1d5NUtWWVkyUitsbTRUaThpWGM3WHp6N1dtOGMv?=
 =?utf-8?B?dDl0M2pQc0VkWEVpTXFvVWxHbXloUHdodnZsOTgvbzdTT2VhM3htSDZwUWtn?=
 =?utf-8?B?Y0dFelRHNi9DdG9jVndQUzJ3WU5scUtxYmg3dmRzekZ5eVIyUnFiSXFXcFls?=
 =?utf-8?B?WGpGWmF3bDFnN3l1T3FTTVl4cS9TVmxtZGpUSXhqYnk3aDhLeVBGUmNFR0Iw?=
 =?utf-8?B?S0VPdDM3bGpncnVTVTRkSFFkUmJvVjNNWk1qNjdTZzg4UGoxVS96Z1UvVCt4?=
 =?utf-8?B?V0MxMFdTQmxWK0E2QzNYL05yL0FiTlVhS290ME51N1A2MTltK3FOMllnSzdR?=
 =?utf-8?B?Ykd0bFF6ZDFOYlR3WUxkQ3BsbGQ1dWwvRE1WSlpaNnJLRWYxdGRaTEdiZW9X?=
 =?utf-8?B?VEkwaHIzUjBTNDE4aWxIc0MzZnpPb0g1M2x6N0J4MlFublRkeFNYZmd2YTh3?=
 =?utf-8?B?WHBpRml2QWYrcUljSWh2bHpYTXQrVlpGMDgySERIKzlvSXptNHhzVFIxNksz?=
 =?utf-8?B?Tk9ueUN5d3daRWhWVUk2ODJ1cEttYUlIcjhUUFpiTE5rUkpQZ1k4anA1d3dK?=
 =?utf-8?B?bkpxZm9kbitDU0NNZ0ZvcWl4U1d0V3hYRmtMKy9nR09YbTJvUjdQQkhYa2ov?=
 =?utf-8?B?a0J5Zmtrek1vVktMUkVhOXgxM21lRis0TjV0NjJjeVowdlI5eUhaeUxHRkZh?=
 =?utf-8?B?TUw5Yk9SZWJpNGhMU3JzVzB4RmU0OUMxQ1VvZlRieG9ZUFFWWGVObVcyRUZD?=
 =?utf-8?B?bFFYNVIrWFZxWWFyVzMzK2w3dC9TMkUwdFZOVzBla2dpbHg4QXIzNytUTENM?=
 =?utf-8?B?YXQ4Z3JZdnBqYXhZaXRXL2hCbkNBSlhFblhid0VteGhYQWdxb0FTQklnVGNt?=
 =?utf-8?B?SUVQNGFUQ0Foenk0MWZ2eGxKaDlFZ0IvaU54YnRXQ2dZaWRWSS85N0pRbStp?=
 =?utf-8?B?OWxiWkRmRk9lVVM0dUpJM0FZOXNNbzJDTkZqNkdYeGVhV0dnWnpSQVFzbG53?=
 =?utf-8?B?U3huSHhxN2dDdzhlRE9EaTlIVXJFL1F0TEV1dzgxako3T3dkVmdnWlJEcVBX?=
 =?utf-8?B?SXhGejU1Z29sUXZJMzNuN1E4cHJhcThIYWxBS3hSVnZZTThEaVlLVm9UaHdX?=
 =?utf-8?B?SjhvVHNBZ2JpVDlKWGpDbE5MUEd3ZXl0QzVDbVFHVzRWTEgvcGtVL2VVc3ZF?=
 =?utf-8?B?VnI0TWhENjVDLzEvZnVFV3kvOGl6Z3NraTd2eWZ2VlNPd0diUnRycHkwZmJG?=
 =?utf-8?B?dDBYcnNEWUFhMWlOa2k5eTRVc2t1NGZVSGVtdkM3RGFIZmtRcWlaK2JiT1VD?=
 =?utf-8?B?L2dWUExQUXJKVkRQdGZaUDdhYmJ2ZlpDRlhyaS9TUms5NzREYms1L0RobGRu?=
 =?utf-8?B?ODZWblREdW14VVo0M0Fkc29pWnJwbkxzVjFhRzROV1ZkVU1zNHh3UmxuZlJQ?=
 =?utf-8?B?dWRWcktpNEtWQ1RSSSs5S255QWVZQVdKbGgyT3hCTklwZllaNkpRUEFYQWRv?=
 =?utf-8?B?RzNNK091amRHME0wVXZLb21CUlhrQ05YV1JUWGw1M2QzSU9VVXhJeG1PMzVs?=
 =?utf-8?B?eUlRSWZZMmMwd1A0b3lBZFVsSjdxRDYzL1hjM2dDazgrK1lxYWR3b1c1V0dE?=
 =?utf-8?B?anRCeDFVTmdGREhiWFhQeGp6OVZQUDVRV1NBdG5BcXNCZmhvR285NExneVRi?=
 =?utf-8?B?eUZHRklucDR3NlpPSXdFZGQwNmNkbjh3eXFqSXFsZVhwTncyb1NmYUFrYlNT?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FE385822FCDD14EA8EF30D48B4067FB@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBAPR06MB6901.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 492060e5-53d5-4881-9857-08dce768fad9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 07:15:25.0730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gmX/N7oQ4Fd1wXzF6/qr0Tkjkba5qUmdXnG6xLwpKFisoKVoj99GrMABGeOP4hHQ7gN6eDtzvxxC7TIo/8KYRUaitOQ0DrJVP+GH3IoLIaDWcR5wIo5EDrl0JUGlf9vw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB8157

T24gMDcvMTAvMjAyNCAxNzo1OSwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IFtTb21lIHBlb3BsZSB3
aG8gcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIHJvYmhA
a2VybmVsLm9yZy4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1z
L0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+DQo+IFRoaXMgZW1haWwgaXMgbm90
IGZyb20gSGV4YWdvbuKAmXMgT2ZmaWNlIDM2NSBpbnN0YW5jZS4gUGxlYXNlIGJlIGNhcmVmdWwg
d2hpbGUgY2xpY2tpbmcgbGlua3MsIG9wZW5pbmcgYXR0YWNobWVudHMsIG9yIHJlcGx5aW5nIHRv
IHRoaXMgZW1haWwuDQo+DQo+DQo+IE9uIE1vbiwgT2N0IDA3LCAyMDI0IGF0IDAzOjMyOjQyUE0g
KzAwMDAsIFBPUEVTQ1UgQ2F0YWxpbiB3cm90ZToNCj4+IE9uIDA1LzEwLzIwMjQgMjA6MjYsIFJv
YiBIZXJyaW5nIHdyb3RlOg0KPj4+IFtTb21lIHBlb3BsZSB3aG8gcmVjZWl2ZWQgdGhpcyBtZXNz
YWdlIGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIHJvYmhAa2VybmVsLm9yZy4gTGVhcm4gd2h5
IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVu
dGlmaWNhdGlvbiBdDQo+Pj4NCj4+PiBUaGlzIGVtYWlsIGlzIG5vdCBmcm9tIEhleGFnb27igJlz
IE9mZmljZSAzNjUgaW5zdGFuY2UuIFBsZWFzZSBiZSBjYXJlZnVsIHdoaWxlIGNsaWNraW5nIGxp
bmtzLCBvcGVuaW5nIGF0dGFjaG1lbnRzLCBvciByZXBseWluZyB0byB0aGlzIGVtYWlsLg0KPj4+
DQo+Pj4NCj4+PiBPbiBGcmksIE9jdCAwNCwgMjAyNCBhdCAwMjowNzozOVBNICswMjAwLCBDYXRh
bGluIFBvcGVzY3Ugd3JvdGU6DQo+Pj4+IEFkZCBjb21wYXRpYmxlIHZhbHVlICJtbWMtcHdyc2Vx
LXNpbXBsZS1yZXNldCIgdG8gc3VwcG9ydCByZXNldCBjb250cm9sDQo+Pj4+IGluc3RlYWQgb2Yg
Z3Bpb3MuIFJlc2V0IGNvbnRyb2xzIGJlaW5nIHJlZmNvdW50ZWQsIHRoZXkgYWxsb3cgdG8gdXNl
DQo+Pj4+IHNoYXJlZCByZXNldHMgb3IgZ3Bpb3MgYWNyb3NzIGRyaXZlcnMuIFN1cHBvcnQgb2Yg
cmVzZXQgY29udHJvbCBpcw0KPj4+PiBsaW1pdGVkIHRvIG9uZSBzaW5nbGUgcmVzZXQgY29udHJv
bC4NCj4+PiBDYW4ndCB5b3UgZG8gdGhpcyB3aXRob3V0IGEgYmluZGluZyBjaGFuZ2U/IEp1c3Qg
dXNlIHJlc2V0IGNvbnRyb2xzIHdoZW4NCj4+PiB0aGVyZSBpcyBvbmx5IDEgR1BJTy4NCj4+IFRo
YXQncyBhIGdvb2QgcXVlc3Rpb24uIFRoZSBpZGVhIHdhcyB0byBrZWVwIGluIHBsYWNlIHRoZSBn
cGlvIHN1cHBvcnQNCj4+IHcvbyBpbXBhY3RpbmcgYW55IHBsYXRmb3JtIHVzaW5nIHB3cnNlcS1z
aW1wbGUuDQo+IFdoeSB3b3VsZCBpdCBtYXR0ZXI/IElmIG5vdCBzaGFyZWQsIHRoZW4gdGhlIGJl
aGF2aW9yIHNob3VsZCBiZSB0aGUNCj4gc2FtZS4gSWYgc2hhcmVkLCB3ZSB3YW50IHRvIG1haW50
YWluIHRoZSBicm9rZW4gYmVoYXZpb3I/DQpJbmRlZWQsIHlvdSdyZSByaWdodC4gSSB3aWxsIHBy
b3ZpZGUgYSBuZXcgcGF0Y2hzZXQgdy9vIHRoZSBiaW5kaW5nIA0KY2hhbmdlIGFuZCB1c2luZyBy
ZXNldCBjb250cm9sIGZvciAxIGdwaW8gdXNlLWNhc2UuDQo+PiBBbHNvLCBsYXRlciBvbiB3aGVu
IHN1cHBvcnQgZm9yIGEgbGlzdCBvZiByZXNldCBncGlvcyB3aWxsIGJlIGFkZGVkIHRvDQo+PiB0
aGUgcmVzZXQgZnJhbWV3b3JrLCB0aGlzIHdvdWxkIG5vdCB3b3JrIGFueW1vcmUuLi4NCj4gV2h5
IG5vdD8NCj4NCj4gSG93IGFuIE9TIGhhbmRsZXMgcmVzZXQtZ3Bpb3MgaXMgdXAgdG8gdGhlIE9T
LiBJdCBjYW4gZXZvbHZlLiBUaGUNCj4gYmluZGluZyBjYW4ndCBldm9sdmUgYmVjYXVzZSBpdCBp
cyBhbiBBQkkuDQo+DQo+IEFsc28sIGEgbGlzdCBpcyBraW5kIG9mIGJyb2tlbiB0byBiZWdpbiB3
aXRoIGZvciBhICJnZW5lcmljIiBiaW5kaW5nLg0KPiBXaGF0J3MgdGhlIG9yZGVyIHRoZSBsaW5l
cyBzaG91bGQgYmUgYXNzZXJ0ZWQvZGVhc3NlcnRlZD8gV2hhdCBhYm91dA0KPiB0aW1pbmcgcmVx
dWlyZW1lbnRzPyBZb3UgZG9uJ3Qga25vdyBiZWNhdXNlIGV2ZXJ5IGRldmljZSBpcyBkaWZmZXJl
bnQuDQo+IFRoaXMgYmluZGluZyB3b3VsZCBub3QgYmUgYWNjZXB0ZWQgbm93LCBzbyBleHRlbmRp
bmcgaXQgaXMgcXVlc3Rpb25hYmxlLg0KPg0KPiBSb2INCg0KDQo=
