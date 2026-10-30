Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793337973;
	b=ZfVtvKeM77yId7RQ/qytfQq6p6W8Bn2HuWtYAx5BTlFZJSwaAYeXPTs4LaQHruWuIsU3
	 3lcR6O8sHruwYnJ3uWZbh7OvIOSN0nvGnjXwJNpfDusJiueL/Ns/+xID3sSOUPQfcdjUT
	 U+X6PbjBFZGCr+qRQPsvsAiVTRAysD1xhHWXPOhMoeuvT8QGVQBeDWHfnAlkmzhCm6Bhv
	 CiXqK3qx3G1b9IUTBEkpu1uUvXi52RMEkjNOXLpMlm47XVdoriD0R2dYArp00+OF6gtCS
	 UtfhkEz/D1Sf3H6j8MI/iSZEpz4hdiTs8AeEERtP2x/kEWqqjkaxfIfmssTn37QLXBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793337973;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=RwY9ncPNUidyY6GcL/Nu6REhsseut7+sFxbbvFeEapk=;
	b=wGOqrK2c/BO2ZwntYVUdwqvQ104/dTA8YWAwBSZuxNhsVzqqeKHaP17MqOp3MMrNTUW5
	 8jbh4kHQrRFR3leFdXilBjBJpke4FAZQjZGo/uAKZvISN21hIBaxKLAoo1cc+x8UtZkwZ
	 dqYePZcxdIuN7z1e+kiZF0rWJQjc7OCciIr9sgdSrCHm8ksyeUiZXRtTVJ7YdqFYSJ6so
	 X+cCrd3L/5fZf2vutCrZF6dgiULgv2ssLD24+ekNRBEmXDvVNSAhPyr+psOpGJMTYoQuT
	 cy+dfAqOfMGYCGl08GMMjA/zOb2DIM5KsQofbfz0R6B0nmuPQF2X9cCglDiPZsBwFJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=jQ18aXf9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.53
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010053.outbound.protection.outlook.com [52.101.193.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F9E606A31A;
	Fri, 30 Oct 2026 05:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31F9E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=jQ18aXf9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWQWkCyqFv5c9ORyLsel0DzzW9rS16bK3Hkq34zbJKdq55F8ZnVcOz4q/DlR3ClJg9LeBEEB5K5VXLGLk9wixeP4ejtigLzfOhsNeVD1QhYEjJoYke3QuWUcvwzN/zHvp7TCqpAClP4P0eVyveIp3JeuHOYWwLr5PUR32WoxzcNj2qQxk/6pJxw9rFJxvlmLZ0fiPncETH5okNoDCh73HPwZQgFHYE1aFdfrdCQzogG4KtfEIvuM/iLzgIzF9szI5AOcXN7JbY2dz0oHehEwu6JbRWO/f5HuvWY9z8ZP5Pxouyiz5cAicNl/5XNuTA1/pJTdB2yn9G0ngKv6vkOAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwY9ncPNUidyY6GcL/Nu6REhsseut7+sFxbbvFeEapk=;
 b=m/3TUGIglw73RxM/atAb/qyVgEDkkxm5QiIj4nIm6d9em79YcQX59uMGupTIHxGJ6Wmo6IdPsQFHXvSIno2EhngsLF6tk7k2is1U7xsl+rFgo/YfI4c5PUSKxe+JAJmyTVad0WaRejgEBgxdzrVQzwbo9+xFbdmuVkhP75PSWJ1u/kyZA2YCTg9YOCCxqK3DdHEnXj3JtOr//mWgKDHmhl1W+HuLqttLu3ExwdBHmr8FpdzG0egCC8uAfEAGYrn2yXKISFdcfeDgKINBfMh+5T0w44ufKxbf8hRLabiT7AhEFMSOGveYb7iFsYSaOWgF8bEvItwCB0lp3x5ed4LFlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwY9ncPNUidyY6GcL/Nu6REhsseut7+sFxbbvFeEapk=;
 b=jQ18aXf99kYyGUqhFHq/AoccfpXDwYy/HTkOz9OAXQNAKAoVDuITeFY+LemMjgLa2KznIRQ6r8ALfLb5ohQachExslgnH3zI3Qc9Ksvo9XoW2D6aARtizXvg1w06Hv1c2dqeN/baFqUX5kVA0CnOLmFHBIUR5JteUIwe5uPxWTFhZmYY5/mU/o6UhabLQlYCEw5uumzuYjXfdn2fhK2noDumj8Jnnv7PtRBr62Ula4bwv8nF8kjjmVmGhwqVNSlYZ1Aq5BGaOlVm6RWnvAOJeLVW51qCV6Ia8CTim2Oi+Mh3YTIIQ6kWwvT8CCS0gC8/QupngqSM/nxD8siY+gcmwQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CO1PR03MB5937.namprd03.prod.outlook.com (2603:10b6:303:6e::18)
 by MN6PR03MB8005.namprd03.prod.outlook.com (2603:10b6:208:4f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Fri, 30 Oct
 2026 05:26:05 +0000
Received: from CO1PR03MB5937.namprd03.prod.outlook.com
 ([fe80::f970:684e:8c80:91c3]) by CO1PR03MB5937.namprd03.prod.outlook.com
 ([fe80::f970:684e:8c80:91c3%4]) with mapi id 15.21.0546.016; Fri, 30 Oct 2026
 05:26:04 +0000
Message-ID: <2723bf11-8477-4f52-a95c-4ede190ecbd5@altera.com>
Date: Fri, 30 Oct 2026 13:25:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] mmc: sdhci-cadence: add PHY settle after tuning
 for SD6HC
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <cover.1791459448.git.tze.yee.ng@altera.com>
 <073f81c6e6dcc931d6e12c358b48679b2855a72a.1791459448.git.tze.yee.ng@altera.com>
 <dab17adc-1691-463f-bb85-7d1276fbf28f@altera.com>
Content-Language: en-US
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
In-Reply-To: <dab17adc-1691-463f-bb85-7d1276fbf28f@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0179.namprd05.prod.outlook.com
 (2603:10b6:a03:339::34) To CO1PR03MB5937.namprd03.prod.outlook.com
 (2603:10b6:303:6e::18)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR03MB5937:EE_|MN6PR03MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: 70609453-8f7a-4bb0-5218-08df36464926
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|261026140227099003|4143699003|11063799006|261028144727099003|56012099006|261026121527099003|261021123027099003|261021121427099003|261022105027099003|261022115727099003|261022075727099003|10067099003|22082099003|18002099003|55112099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	JT+hdKIN/FxoLbkF+/toydgkEl8+sm5JTfBkfObmW7Lj8PFRvD7uV79RtjklcRbNl8aWU7oGc2598zz4lkhx4mXLWotHczZTaEW0bj1ZlZayERNA2DxBuJk+XStiFskcI5W1NgMcYc0T5sJsAo5yzZ/mXCvqaC2PLiHadn5BN1eIq+N5OhdOvQp7m1pIa9lBLj81o1WilmbgmgdoKejaRuJ+trFZNP06ErLJBFaPCmj/7Mk8zX/+IDgMvKOgqbBZJtCgEMDIhMLVig58t6X0ZJ16skGK/cSKRpKcGIs0+qXEiP8sbAnOmAMLCJv+N3o/4YIA/qQtxVbxfDBSe8QyrP/OuwnJULf+l6MyzhvE54zDWtVsxYMdYNldByEw7b2GEkOSw0LF39yiUfeCBNAfG9VhseNzEnFgljDZ3ppkmBHTFteVuedyfQ1uJOOgk2GTUABdGCV7mDZjmxF8Aii4XxrfkY/zhKU0rgKYXhHd4s9xdLCFdbbpSe6l2BJDIV/nq6YxvSgA1TUSglz6PdTbp035OQTKRCRs53u9DmL5A2LM0+ey3VY7ZKihP4biuircVz+r0HpwpKMLdFJ5wBGD8LXGpTVFknTE5avY9I9olPXsWcIa3ZQePPC8qid4RvKaVjtCTQD5/AkdHHw3599Y+qiJKliKWjuxtm6HvfQ4CPQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR03MB5937.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261026140227099003)(4143699003)(11063799006)(261028144727099003)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022115727099003)(261022075727099003)(10067099003)(22082099003)(18002099003)(55112099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3pmQ3pNZEJNbEVicjJXdkxHeWpvNlhsYkJrUTF6OVJsQUxiQjhYY3QzY094?=
 =?utf-8?B?WWtHWVIvUFYzZlBCTFZEREJKL0FxOTFhSGlhek45RlJ6b2ljd1hreGpCVzRm?=
 =?utf-8?B?MnNpdGYvaDlpREQ0WWgxUWkrZ0RBbXFmQXhRMW5YNERkT3Zma3E0ZmwyUEZa?=
 =?utf-8?B?bndiRTE4eWVaZFR3SFdsVXA4TFBKeTBQYzZMcXhjZExhdnJZd1JjR0dWT3Jq?=
 =?utf-8?B?Nk9yUlBxeGVlUEdQSFBTWmgyK0JwamRnWWVzcyt3K3loL2FSVkpvMnN2TUt0?=
 =?utf-8?B?RjIvQjMyV3B3cDVvRHoyWWJvdnNpZ2I5WnZWWVNsL24zZnZzMkhENUk3NU9q?=
 =?utf-8?B?eGlJQW5zNFh0UVl2U2dDTW52WEp5SUtyN0NEVlRTejM3N2QvTkh3NVZhWll1?=
 =?utf-8?B?a2pWMVY5N1JHQ3QrcFIzUERDemZqNDBLSU9TSUxKSjhrajNiblpMOWdJb2ZJ?=
 =?utf-8?B?MWxpTkZ0RnNTZTFRR1N4UGI5VFdvcmhuaW9YVzQ4ejg4aVg5aGErNXM5RFZo?=
 =?utf-8?B?T3cySEs1UVN0OHdGQklsVHdRenN3VnVMZm4rVkN6WS9TMlhCVFJ1cGE1Q2xI?=
 =?utf-8?B?d2k0QmwwMWJNRDJ2bGpGZEUvWlRuYmp4YWwzU2pQMDlCVmZQOHdhSWtHNDFp?=
 =?utf-8?B?Mlk2REtveFp2ZlVsMHhPYnBTa2gwOVRLRDg3bWtIL0FxWXp3UVZjVzk5L2hq?=
 =?utf-8?B?UEh2R2RzR0JTOWUyc0hCK2VDeTRoVTRHWUt2N1hjMEx5T1RadnpwTHNNWUpO?=
 =?utf-8?B?RS81dzZ4OGMvcWxEaHpVd0EvdzBvbzFvRUxhZmVKZUpmNWhwVVZMaWd6VW1s?=
 =?utf-8?B?NGNMTUNqN1NXSXpPNWc3aXFKcUU0c2N6d3NCUTduS0lENExVSWZqYVUwZU95?=
 =?utf-8?B?L1hhQU1weVVVZWg1RTIvMTdqUWh3UCtUK1huMFJ1T21GWjFRK2dtRHc5YTVt?=
 =?utf-8?B?REF5d2pKZzNCSkNmY3lBNmtNZ2RyaGFCSnlxdW1IYjFQUUUvMHZYazVrZ2tX?=
 =?utf-8?B?TTM1RldKMmdGNis3VUhlakdpQXo0MFpaOFFWamlTMFR0VXRSOXg4eWdDMkVW?=
 =?utf-8?B?ZUQ1N255Uy9lZ0VZME9YdXp6bFdvY0lBQXZBcjBIM3VKaSt5T2xSalRCZDB5?=
 =?utf-8?B?L1A1R0JPKzI3Sm5vSkxOcnNyUGpXdmFxZlVSUSsxQUZkY2FraGcvL0E5MWZz?=
 =?utf-8?B?aFFXV3lWUitkbnJSc1pBQUl2OUxvcXYydWswd0tCaU13WE5mMFdPclNGa25x?=
 =?utf-8?B?KzZEUWo5aHg0UndkbmtPVHQxWlppR1I3NzE3bVQxWnpYRlFmMlJ5b0VkbHgz?=
 =?utf-8?B?Q09FekcyQWRyaU9wTk1EUHFwOS9rK3loTmpGY1YvMVZUbkRIcVR2Q2NXTU9i?=
 =?utf-8?B?NUN2dXlnVzR5MGI4eEk0RG1IVkZEU29hN1ZTNnptWnRsSFZZUmJvOStOR3ZB?=
 =?utf-8?B?UHI4dUhIRUdFSm9yUlc0b2Q1RW90a0U0bE1DZ1VMUk5KdVpHajI5RVpqSjVC?=
 =?utf-8?B?WUZ5VW15OExCWGNuTjk1TCtJMXo5aUE2ZzZ2Vll1dkJxZU1qL3Q4LytKdDl4?=
 =?utf-8?B?eVlhRXdDUHRjZ0FLTm10aHo2Vms2QmdncmRqUXA2ZkhmMVk2eDJJc2VMNFJn?=
 =?utf-8?B?UDdCL0ZVSHViWHpmamlpekpmaVF2bDVNdnZaSWFicFlxOUZqMnRaSGpFLzZp?=
 =?utf-8?B?bHFoekxkV3ZJSUg2MVVrZ1p4ZlBMUkllRHRRU2Iyb24zZFNBYXNkMGJQL2tQ?=
 =?utf-8?B?MDRzNWN0L3JmRmVYWnZKUUIvbjhhN3FpMytHV2N1RDBjRmNGczFMTXloVXRQ?=
 =?utf-8?B?TXVOMkpKc1RNenJVS0hNQzhLd0NOYUI1ZUZQbmNTVWxqVzZMK3NRRE5teGlD?=
 =?utf-8?B?b3JOaWhzUHBVQkNJZk9PYlVROUw3N1RBMzJtS0lIWURYdlp5dm5veDlObytZ?=
 =?utf-8?B?Q2dJOWtiZkJTaE4rT2RpVnJnUUpCeEhqdG1jRjh5aXFnd0VZTHh2Q242dVVy?=
 =?utf-8?B?VmtvSUlmUEVXTmpMTHQrWHF5cER5cUNiSDRUbG9qM21kMkxFMEgvWllOSmFo?=
 =?utf-8?B?WHE4cCtINlpRYmN4ZkNsRmV5Z1liOGthOTQ3akxRUVFOOGIvS1dlaDJoVGZ3?=
 =?utf-8?B?dlZnZVJsR3BuU1o0ZldCbEd5TTJrSXhXb3E5aURwZXNNRkNncVlyRVNHQ3NE?=
 =?utf-8?B?Rlp4c1lBRDNvbXlDOGJ4eGJnRXhkeWlOeXdISUdCVXNNSWwyYVJTcVg5Ukdo?=
 =?utf-8?B?VTE5YmdpSTFYZCtOS3poSGJTNkZ0SEpZdmpjOVZTNFZ0cFg5TXBQV1NDV3Bv?=
 =?utf-8?B?ZkRQM1ZGdXdReWRJb0lBTFQ3SFBuS3psaFZBQnl1QkRBSUY1N1pvQT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70609453-8f7a-4bb0-5218-08df36464926
X-MS-Exchange-CrossTenant-AuthSource: CO1PR03MB5937.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 05:26:04.6746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czvhiINOZ2RVlxAKYlRrWzFPh5jIfwsG0GDpr757ChKaANfVk0n/kGoHepw4xPnIg7fibeYCvGUl9U/GUyVzJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB8005

Hi Tanmay,

Thanks for the detailed walk-through against the spec, it matches what
I see on the hardware.


On 26/10/2026 4:17 am, Kathpalia, Tanmay wrote:
> I'll test aborting each CMD21 that fails with a command error, and
> also a single abort after tuning completes, to see whether that
> removes the CMD6 failure. If you can test the same, that would help.
> I would prefer that fix over an unconditional sleep.

I tried the abort approach and dropped the PHY settle entirely, it 
works. I now pass the command error back from mmc_send_tuning() and call 
mmc_send_abort_tuning() whenever a tap fails with a command error, i.e. 
the same thing the generic sdhci tuning path (sdhci_abort_tuning()) 
already does. Aborting only the failed tuning commands was enough; I did 
not need the extra single abort after the scan.

Tested on Agilex5 SoCDK, both media:

- eMMC (HS400): HS200 -> HS -> HS400 completes and the CMD6
   response timeout is gone. 8 GiB dd + 8 GiB fio (crc32c verify) + 2 GiB
   image write/verify all clean.

- SD (SDR104): 2 GiB image write/verify clean. Abort is a no-op here
   since CMD12 is not defined for CMD19, so the SD path is unchanged.

An ftrace of the tuning scan confirms your theory directly: a CMD21 
fails in the command phase, I issue CMD12 to abort it, and tuning then 
converges.

err_stats after boot: Command Timeout = 0, Tuning Error = 0. The one 
non-zero command CRC is the abort itself. The CMD12 is sent at that same 
failing tap, so the card's response to it is mis-sampled and counted 
(CMD12 is not a tuning opcode). The command is still delivered, the card 
leaves the Data state, so it is cosmetic. The data timeouts are tuning 
taps whose data phase did not return; data CRCs are suppressed as usual.

For v3 I'll drop the unconditional PHY settle in this patch and replace
it with the abort-on-command-error change.

Thanks,
Tze Yee
