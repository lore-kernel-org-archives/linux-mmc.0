Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013006.outbound.protection.outlook.com [52.101.72.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73426140E34
	for <linux-mmc@vger.kernel.org>; Mon,  1 Sep 2025 06:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707505; cv=fail; b=N9w6oJwYWION0hWEClC1IL3iuPZYMsu/mVC+pDrrXAeqzeNFxIiwsXulvRrCh0Xc0/g2xNYeIkGBzkILxE6mdUerXNYPEW7H88PM5PKDoYLs2roVBYIvYCrWYeOqu/vG9FN69RJBO+QAC0tZxX8fuX1CKKOyH/uz0Ab35rEdcIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707505; c=relaxed/simple;
	bh=HFqVaslCER3w4I5iBXzdSBCnPVGtTSzOvtQ1ydF3VrQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hS9a2aDWGvBpc6cPJhwn7/YyATEa10AnPN+/1e1ASm+EjI5GmFqETCeEI0wEfCiRW97pMM3jtDdvB6dTC2s28fbAJRGDR2p5ZrDMw4rl5hQroOI2C3GykWhZRfvOka3F+yefZfE91ID8NUQrYLj+eY4djDpdM1pymLR+A0CwGYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=SMwGGa6k; arc=fail smtp.client-ip=52.101.72.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="SMwGGa6k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBmsFdZrWvTRfUKyaZJYNZfJXfx8yXDgIWQ2WhC+nnXCW6QWuRiqld2ky7sDB2gcdIGNhdjxNWwton1Bzj38FifxdZqr2/x4Z2Y3vYL8FGB+/R7hINTWjKC2i9Qc/qbP8OMgHg78R+xt+BTDhk4Pw4O3s/O5ph0beNqCPFAdwdpmwn/KZUs0CHo9GLCLKAhVUq0KVGrkG1zUa4uJ7K6Kcz8Fvo7/GwVcmR5NxHghwbB/9NEus7odqPlhU9DPaOil37j+0IORTfrfVTBuGx4BWCLoJmfNZ7QoeDUJMFngSYA0XgYV7UNs+3BT2X1h9mhSzwfGlejEdVQJUMLkSIrlbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRLvho5fBKx0lDlagZMEY6iq6DOXAfYgxA5RqPo5Zmk=;
 b=AlDgue/dGm3c/1SwmzB0BR1130JhNvdYMOZOypsQVjAgJKR30jSYLTJpuz8NxgEPYUk3tsvIGod0ZNHDvixdmfMykWM4/Gw3rVRTs3xMbKjOLyjirfhW2xXkxVhPXTV6H5oy0j2qoffoKpvhW7aN1uqheCHHCf9acSAiB2xl9QkqkjfOOWI3I7VnYpIlv/9tZx60zm+sAufruvBKJU8ArBbbJ83giHewymSUWI5hUTsz3+2mh0635fDN50X79U5DERGeULsW2RBgvVz+/srJOLqzBBZ3QYpWuZce0ZWP52u/FDvXZKkGEx9b9Lmtu0JNsXrJ0F0rXAucjKk8tA397Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRLvho5fBKx0lDlagZMEY6iq6DOXAfYgxA5RqPo5Zmk=;
 b=SMwGGa6kgw/wHmSTEMRWg+6ey5GmJo2imyAh8y4/flU8P5jTdF4/XdIP3j/Orfggt/QTeYpd1GYmvWxQft9S7C3f0r9FNsQ3qgwRp6ndzJxWwh354QXRwQPhp/yy+HFxEWWEvmS2N0lknOoLXR6opXwevTuSc+0EU4r8Ukk6XL2BVbDavcMKOfeOHIAekeJJ7s6gWhgR49AL5d5dQ7utYsVPFmfc2Vb6KmkAI2BTxEblfZFOCFbl0nzSB8yzEtqR/PJEqMrlWI5BfaufejJDcoOTgZ4x8a6uQiG2OpsLRICTyTvfHSunonnxjMSxxfErejcOmaFlK9ioRfhUupsr+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8866.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:234::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 1 Sep
 2025 06:18:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 06:18:19 +0000
Message-ID: <e6f0ec2b-0d5e-4b3f-b32f-13120c86f85e@siemens.com>
Date: Mon, 1 Sep 2025 08:18:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc-utils: Correctly handle write counter overflow status
To: Avri Altman <Avri.Altman@sandisk.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>
References: <31174fae-a3bf-4415-a8a5-76d252a6fbd4@siemens.com>
 <PH7PR16MB619601040C92D28ECC72F7AFE507A@PH7PR16MB6196.namprd16.prod.outlook.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <PH7PR16MB619601040C92D28ECC72F7AFE507A@PH7PR16MB6196.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8866:EE_
X-MS-Office365-Filtering-Correlation-Id: c1dc985e-090e-4ea5-b66f-08dde91f5869
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFZXVEExWTZ1cFhqYVp0SVBhNnZpOUFuaWhJRUtReUFFOXQ5T3A3ZDRxSktM?=
 =?utf-8?B?OE00Z0srcXZBSCtaQmVyUWhuL2djcC9DZ0g2bkRIMnN4SSsxWm5PWVBTaDRm?=
 =?utf-8?B?SDF6Wkc3Mm8rMHVaSzVMYkprV2V4dGRaUzEycWYvNVlvR2dUeUxzVDVmREhx?=
 =?utf-8?B?K2hTWUk2RWorNEVmaDVmaDYxWXhMY282MGFYZmtWNkd6RjRFTkJLRXZCTE9S?=
 =?utf-8?B?ZDRqeFVXN3JpS25ZcWU2ckM0K1JNWThKNDhMSkc2RHhZZGk1SWtNeFhHS2Nx?=
 =?utf-8?B?cXEvNHNJcVZoYlhnNEFsMXRRZXRxeXM2bWpPOEl6VDl3K21TVlc0eHNDZVk0?=
 =?utf-8?B?Q2RSQlhHMnltSEZwT1oyb2didWpoMEowVEVEM1dRTnp5UkxkRG43M0w1Wnd4?=
 =?utf-8?B?bmpZQ0xmaDlvR0lLa3FUUXdrS0F3SW0zeTIzOXA3Zk9GZXRBSDg1TEZhZFNv?=
 =?utf-8?B?REdNY0hyaVZlZTNUQmgzSU9kQnkrdzROVkVJOXJpdnRMRlMvSWdIUFN1bTd3?=
 =?utf-8?B?NkdrOGNPcmVycUdQdmhOa1d6UjlHU3NWclNlNmx1N1orT1FPbGhBazFNVlpV?=
 =?utf-8?B?ZlZManRjcDAwV0dpTmxhUTA1UzBFYld1MUNQWXFtTGdpdDRUakNqN1hhTmZQ?=
 =?utf-8?B?My8vRW1DNUt0aGZnVXJtQ3ZCNWg2ZUxka1VuTy9ITUpYZU12Zk4zQVpHbmVY?=
 =?utf-8?B?ckJHS1M2akg3eEVSTVkycG54OTY0Y2dNdzZCTE1reC9LbmhINnFzeEowS3dz?=
 =?utf-8?B?M0hmQ2dPbzlUN28rb1pLcTB6N2VQYVVzSFVYc1pUZEFLMWhySnd5WkhGQ2lZ?=
 =?utf-8?B?Z2QxcnpEOXRiNUtGcXJ6bnloTTZHSVBqa1g5V0hpaUkxUnFDMVJ3a1dwcVVx?=
 =?utf-8?B?ZTcwcDNick93cDhLaEdEbkxScXZVN00xcGY0SFZSdE9MaVZJODhITjBwaW43?=
 =?utf-8?B?c1p1SGxDUnEvMFZBR25PQSsyVnB2Tk54MHVaVkFxU2JXT0RsRGZ4WHJYRWVq?=
 =?utf-8?B?MFVaRnBZeE82bmZaMzRsY0cxMlp6SlhvaWxJL2xMWEpTZFVVVjV2K0ZNQUZL?=
 =?utf-8?B?ZThWRit4Nm9HeVJEYXlXQ0FZbm8yUmNMNWZMdlNZZjh5Q2tFL1BSVEVZdFE3?=
 =?utf-8?B?QWRiamVCUGdNY3k1NWdFVFFKbHViOWUyTlkrZWI0WTY5ZUp6T2RHdkJqQjVa?=
 =?utf-8?B?ZmlubEkwYkIybVJkbVJyS2cxalBLeG9YblVkVkViRkN6NC9kckU4T2Fyd1ND?=
 =?utf-8?B?Ry9PWlRkb0ppK01weDNFcysydjNFaUlQaWlhL1RkV1FQMkNrTkZ5SGxvQ2RV?=
 =?utf-8?B?cXljYXB1UUhmSHg1UktQNFVOYktXZVNON3BKZmxBNkxiNVBOdmREWFNyUHE0?=
 =?utf-8?B?M0tjY204N1NHZlV5Wi9pbktpY3BtdzlLb29GZXpJaXlwbmI3RjFCd09GeFVr?=
 =?utf-8?B?WWJ6SzRQTktwQnU3N0tFYmtnZ2NiTEpGMVJEK3ZrUllMVytTay92R0YrSUZm?=
 =?utf-8?B?MU0rMWhmZEkrcEk4TkVuUWlkQnRuRklYNUJ4b2FXUksyMDdTb2xxL0Vjd00y?=
 =?utf-8?B?dnQzbmNzMnVtcndvYi9IejI2K05yYklwcU5JdmJGcUwzYmlHRFZiOWRuTmpS?=
 =?utf-8?B?SUtsVW1xK1RzUU5QZzZPOGxzN0cxcVlrR1p1VHUrWTdxYmxWWFdHVVpMYkVm?=
 =?utf-8?B?Y3doR0IvTHg3TWRibzhZajRtVWMrS3hNTUZqdFBhc3FWWmZUSTVIb1FDcmtT?=
 =?utf-8?B?RldlN09sM1MraEpqbUptVzVJVGZiWEhFUjQ2ai90L2JYL2FJQTRUcXZLK1Va?=
 =?utf-8?B?bXUvZk9FaVZWa1dGSXBWRDAwUnZLYUxhZFZ4K3M5bG1oUk5IU214cUs2NW0z?=
 =?utf-8?B?QlhpZ21tUWdYc1l0UGZGdE1IeHhSTStEbjNuR1pNSHlIb00ya2orY1AxNjh6?=
 =?utf-8?Q?sIcnItT0Q4E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjF3aWpKTTU4bllXaHc2KzkvQ1FDdUlLQXZBWFpJb1dQRWZHZVhaT25iNW9k?=
 =?utf-8?B?eDY0VXNIVy9SVkJrNCtDRVBxbUNsaHhBSTlZcTljbHVSNHBQU0Z2cnNJVC9J?=
 =?utf-8?B?eTR0UVhkY2w3MEZUWGJvQWhUbHVCdlRBc2hqMzl6RnU2Z0hheHVUQkdJY2w1?=
 =?utf-8?B?UzYwZlVRazVSVlpDRmNHdmxjbEJGZk42S0dxOW92RGF6OHJBVFhobTVVMW9H?=
 =?utf-8?B?SGI4YytVeVZ4aU5LVmVrOGZMZU5HdlZTWlpQbVlIT05WSCs0b0dnVkl6Z0pV?=
 =?utf-8?B?c2VxanYvSFA0OFJGY2ExK2sxYmN4akVMOGxRdzlZanVoT3lSUjdDMDNmK1c3?=
 =?utf-8?B?c1E0MjhINWdxMGdjQWRrTXI0OExObHFRRzJ5cy95L1VYME1TUlQrMWtDWkZH?=
 =?utf-8?B?UTN6ZFJJaEJlL1F0bW9MT25zOE9SVS9rcDFvREFja2Z2NEk0ZWJDN3ZGTnN4?=
 =?utf-8?B?RDFrMGNYTmlSRFN1cSt4M1ZMcitFazAydU5Kek1udVMxUDArbFY2NjhFVU9U?=
 =?utf-8?B?ZlB3eW42TTVvS1ZFYmI1RUNzUXlqdUtGOEdjRDBkOGkzNmErZ1ZnZUw3USts?=
 =?utf-8?B?NWxXVFpGbGluSXVHSllKZnNCdzZwUDZScnh6Rit3VlZFeURhdGw2WUlEYVpm?=
 =?utf-8?B?TkVjdXh5RjRnNWpyUGV1aEltckw1RDZHc2o0QUdtUnZPMFc2NXpVKytYS1Vs?=
 =?utf-8?B?cmNYRDNTdjNSM1l3d05SajYwbEROT0hFRkV3bTczQ0Z3TTVuamFWYWdiUXR1?=
 =?utf-8?B?SkJna1h1Z0VWM2l2N0QrS1dsek02TlVBdXllWlJ4MFFPQmxJWDc4dUc4YVhV?=
 =?utf-8?B?TXU5RFJodjdmc0RRdzFyb3Bxd1NZaUp2QWVkTEgyVzNWMll6T244eWRXYWFp?=
 =?utf-8?B?b1AvRzhSMDNXbUFITFZidEZ5VnAvaktRMGJ0UDBnSGFZQkxZVWRUS09pUWw1?=
 =?utf-8?B?eEF3cFN6QUYyYXM2NVhRaSs3alo1bm42dm50eTEzZ2FQYnBqOW1tR3dwN0ZJ?=
 =?utf-8?B?NUxkQkM0N25Xc3NDaXNDWFQwTUFlLzYxalRkdnVqV0VTd1ZZMmxTQ1piZHQ0?=
 =?utf-8?B?bnVUSFBPczQ4TXlNdE5nSml4Ui9iNzIwTmlKVVcyZkl2eFVYZWFMajdHQWQ5?=
 =?utf-8?B?SzdHQVNmVDRka0o4V1JhUmhKQVRpK3FXNW5DNm5meS9Za1lQSk9MVHZhNmpK?=
 =?utf-8?B?QU1uQXN0dExsSDFzNUROeEYxKzRNOURHN051a0N4MzlSamtwa3ptQ0J3dEZ5?=
 =?utf-8?B?RFNQZzFqbE8xQzJHRFBzWDNnVXQrZmZyVG5oNnFmYjQ4NVNpbHh5QnVxd21B?=
 =?utf-8?B?QThwN3loa2hYNXRDWjZ1MWM1SEo4T3dsUEowN0c0QTlmZmFMRlZLRzFBZS8y?=
 =?utf-8?B?azFGd1RtTlQ3c1hwZlczL3RrZHNuOFBxYkk3bzVKRFZkbGpKOXhVSnN5RFQ0?=
 =?utf-8?B?R1pqWnVnOUZGa00wdTNiTG9FNmFVc0lSTXkzTVdnc0wrQzlINldSSWJra0Fp?=
 =?utf-8?B?ZEVvQnZhWUU1UEwrV1c3eGM1NWFuOEloLy9KbGovRTQ3Z1AzNDZ4SWIvUGpz?=
 =?utf-8?B?Vm9hRmExNVo3MGIxYXVLeGZVMS9oLzM0VnZvTVBCTi9FZEhqblhkNlJqYUd1?=
 =?utf-8?B?U3lUK0czZUFiUWwxS01TMEtLREM5dUdPVkVCNENCMnpiL0s3M0RUYzNpMlly?=
 =?utf-8?B?UXFDZXVLbWdWRTZJT1Q2YnlQZGJMSUxHQjFueGp1RmNYUzFiRWZXWkdmZ3Bq?=
 =?utf-8?B?Wk51blRDRVZ0VWlGMW40YnVzUzN3SllsNnVFYkRtT0NPcVJpcTlGa2xOT1Fs?=
 =?utf-8?B?bFpTU3MzcXB5TlFyb1g0aDBCaFJ2RmtaTVFLcGljU3Z5MHF3UkFNTmQrL2Y1?=
 =?utf-8?B?K3VVSGJ2Nzd2T0h0YUhEcE13VVdYK2RrU1JDVUM5a0phMnFOZVJRYm9qWnRt?=
 =?utf-8?B?UVY3TkRZK3A3TmZWNUtkWk4yU1dmTlJtVGgvRnZOYnk4SlJXT3ZEV3d3T1lB?=
 =?utf-8?B?RUdTMHM3aEM1bWlIdjJjZloxM09JU0thQVZxZFRKN2lmSzRVMVppOXQvV3BR?=
 =?utf-8?B?SlF3RlB5dkdTUlpEM1NSSkx2WS91dmhGUFA4M2FPMUIwbmZWRktiaGFVY29h?=
 =?utf-8?Q?Q2IsU8qsCfvjaEjrdFmdA/gFs?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1dc985e-090e-4ea5-b66f-08dde91f5869
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 06:18:19.6267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVnha//WP4XLxNhnbFYgAYjv2YnOcnN3H4N8Wp/ydTgZ0JyyYZYMHq52dIV1fRP+2fIQCdC7ZOx5BWF716i3Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8866

On 01.09.25 08:14, Avri Altman wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> The result field of an RPMB frame will have bit 7 set as soon as the
> set -> permanently set
> 
>> write counter reached its limit (0xffffffff) - even if the operation was
>> successful. Handle that correctly to avoid false error reports.
> Correct.
> 
>>
>> Only the result returned from key programming does not need special
>> handling as the write counter is still 0 after that step.
>>
> 
> 
> Fixes tag
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> Tested against a QEMU RPMB model that was tuned to reach a counter
>> expiry quickly.
> Move this above your signature
> And yeah - In this rare case the device is most likely worn off so maybe add an indication of that?
> 

Should this be issued at the end of every command that sees this bit set?

>>
>>  mmc_cmds.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/mmc_cmds.c b/mmc_cmds.c
>> index 16c6b2e..e91813a 100644
>> --- a/mmc_cmds.c
>> +++ b/mmc_cmds.c
>> @@ -2103,6 +2103,8 @@ enum rpmb_op_type {
>>         MMC_RPMB_READ_RESP = 0x05
>>  };
>>
>> +#define RPMB_WRITE_COUNTER_EXPIRED     0x80
>> +
>>  struct rpmb_frame {
>>         u_int8_t  stuff[196];           /* Bytes 511 - 316 */
>>         u_int8_t  key_mac[32];          /* Bytes 315 - 284 */
>> @@ -2321,7 +2323,7 @@ static int rpmb_read_counter(int dev_fd, unsigned
>> int *cnt)
>>         }
>>
>>         /* Check RPMB response */
>> -       if (frame_out.result != 0) {
>> +       if ((be16toh(frame_out.result) & ~RPMB_WRITE_COUNTER_EXPIRED) !=
>> 0) {
> Actually, we could ignore bit 7 since there can only be 7 possible responses:
> e.g. if (be16toh(frame_out.result) & 7) ?
> 

Ack, will introduce an op result mask instead.

Jan

> Thanks,
> Avri
> 
>>                 *cnt = 0;
>>                 return be16toh(frame_out.result);
>>         }
>> @@ -2442,7 +2444,8 @@ int do_rpmb_read_block(int nargs, char **argv)
>>         }
>>
>>         /* Check RPMB response */
>> -       if (frame_out_p[blocks_cnt - 1].result != 0) {
>> +       if ((be16toh(frame_out_p[blocks_cnt - 1].result) &
>> +            ~RPMB_WRITE_COUNTER_EXPIRED) != 0) {
>>                 printf("RPMB operation failed, retcode 0x%04x\n",
>>                            be16toh(frame_out_p[blocks_cnt - 1].result));
>>                 exit(1);
>> @@ -2573,7 +2576,7 @@ static int rpmb_auth_write(int nargs, char **argv,
>> uint16_t addr,
>>         }
>>
>>         /* Check RPMB response */
>> -       if (frame_out.result != 0) {
>> +       if ((be16toh(frame_out.result) & ~RPMB_WRITE_COUNTER_EXPIRED) !=
>> 0) {
>>                 printf("RPMB operation failed, retcode 0x%04x\n",
>>                        be16toh(frame_out.result));
>>         }
>> @@ -2621,7 +2624,7 @@ static int rpmb_auth_read(int nargs, char **argv)
>>         }
>>
>>         /* Check RPMB response */
>> -       if (frame_out.result != 0) {
>> +       if ((be16toh(frame_out.result) & ~RPMB_WRITE_COUNTER_EXPIRED) !=
>> 0) {
>>                 printf("RPMB operation failed, retcode 0x%04x\n",
>> be16toh(frame_out.result));
>>                 goto out;
>>         }
>> @@ -2783,7 +2786,7 @@ int do_rpmb_write_block(int nargs, char **argv)
>>         }
>>
>>         /* Check RPMB response */
>> -       if (frame_out.result != 0) {
>> +       if ((be16toh(frame_out.result) & ~RPMB_WRITE_COUNTER_EXPIRED) !=
>> 0) {
>>                 printf("RPMB operation failed, retcode 0x%04x\n",
>>                            be16toh(frame_out.result));
>>                 exit(1);
>> --
>> 2.43.0


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
