Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023109.outbound.protection.outlook.com [40.93.201.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D865313C8E8;
	Thu,  5 Feb 2026 03:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770262524; cv=fail; b=VUfYlA3PCfYEIfFozw7yqc7uEREJWei4jMzJRg+m3DoosqSHPhtx0Hp0IMpJRpCuJwkYRZ+6g8E3UzALv2L7drao6FRdVyhbHYRKkqKoUVJoDdnxlrGtkh+N9n+r+Z2NBj0ewo1ULc/OJGJtGIz8s+IxL2GUdzct2TKBKv1SSYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770262524; c=relaxed/simple;
	bh=SnO+1EeyWk7CSx6TnGyR2kTdJLgYmVUSL0dmrjWk5bM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z0gzPgEDaNFZ5sorrKXwuB9E3C+t9lkUdJdewY2kZ7Z/NMIh9C52tYl61qV2G6AD9keLIOhH+d5SewqvyMH3QIGFFVM1/UwPBNHfGcVW47OOUuoVWVnJuMTohqcfZdJzYLnUEABcRdnjqM5Ss8pGA2tlRZoAt8/4nLMFNzE6mYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=HHdygZaR; arc=fail smtp.client-ip=40.93.201.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="HHdygZaR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gieVEn3f4rWb+dG9oWGtzZ84tmBEQYU+iIQXoHaqIEGPJEkyAQSv0Uc7njDA1jqxs0bZ/fDtGNOuyRdXEfxynFV6pOCobqd4OEpVwCQta9XpM+GEY02rt/Hg0Adrt2N9KBjJsQOiHdyQH2X+sR6rT9ZBxAteL8pOFxoXLOcSQ5+nSSqgdJ3DHRwOi4YWGCx8Er7/t9jOpRmT+xnyZnvr6wjXhqY54NPAAcLZX6HX2Bf1YuJnRcwaayrbejNAhdvVkCM+JeWs4y/ZW9Qc0QhPO8aprm8vHrSS82ve0iwEqYxMnkvqyimWOKRUAhQfL1bywse+mKFmPvDIoPE0AIrrqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuRzw+3EdG2xi74a5vwLDkKPXQPFp/zYd6F4+B1YoGE=;
 b=x88Y23zBltEGuo2m1njXlbWaROXXRJg3/TcxhjEREMDObmZfoaL5WIRBbQKv5e9+nxy6vCFCAWAx8Mc34puoV0nRF2uf/HHf7GK+HW75qBc42qYK9Aiz6xfz9EJnUrTLTlhX41e+r3j7q8ZTAg0qoUOMWl9qyjPSYF8iHPvT9d9QbeCAldQ+feUsKETAkyFnD81TIhL5MOIf0By6X9dDv9RrkvKc60VSkfBtHq10Lf0xRLbA+s/bfkN9GcoGcv/TeGD69/kVJ4qwoKRJ6+Ijof8+P8MJDsCOHtkgZpMdGou1QkSBMEcF22UGNnMH5BeQkdxsrjo7Gc5Zk4/ThgoRpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuRzw+3EdG2xi74a5vwLDkKPXQPFp/zYd6F4+B1YoGE=;
 b=HHdygZaRCNT0BxGf2u3px1ksYB8otUtoJZKk7VV2u2V4iuvyrf+N0VUxEInRFpehHf/ayUFXGuOSR/J2gQBfkaihkzZTyrkeiqwTaZiTm9nfH0rXxRKPRoTmr+vBst9YgQwKD0P08Ci80zXQhFo5+HBp5mVWfUKlhKrNlXgVeGoQuEWDFdvY2UqkDTe7QnCzUyUAZK/LX218yug2X+nBNqBL631vltH5W20lYQ/xzhOhfJc4BFXisPIBlbEZU6OQRPaIKuyPaD6BESGRzsuwAUr2XQNYmZMmNFQUGM0qxOGR4JL6yH7jm/nLLAzXVWlR1rzfsJw+yiqjiJRTnrZtGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from PH0PR18MB4558.namprd18.prod.outlook.com (2603:10b6:510:ac::13)
 by SA3PR18MB5391.namprd18.prod.outlook.com (2603:10b6:806:2f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 03:35:21 +0000
Received: from PH0PR18MB4558.namprd18.prod.outlook.com
 ([fe80::7a75:75a5:694b:2311]) by PH0PR18MB4558.namprd18.prod.outlook.com
 ([fe80::7a75:75a5:694b:2311%7]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 03:35:21 +0000
Message-ID: <e5fda69c-9605-4b0e-bd7d-90e64b4f388c@axiado.com>
Date: Thu, 5 Feb 2026 11:35:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] dt-bindings: mmc: axiado: Add axiado eMMC variant
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: SriNavmani A <srinavmani@axiado.com>,
 Prasad Bolisetty <pbolisetty@axiado.com>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter
 <adrian.hunter@intel.com>, Michal Simek <michal.simek@amd.com>,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-0-5457d0ebcdb4@axiado.com>
 <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-5-5457d0ebcdb4@axiado.com>
 <20251227-industrious-mammoth-of-culture-ff9dbe@quoll>
Content-Language: en-US
From: Tzu-Hao Wei <twei@axiado.com>
In-Reply-To: <20251227-industrious-mammoth-of-culture-ff9dbe@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0023.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::19) To PH0PR18MB4558.namprd18.prod.outlook.com
 (2603:10b6:510:ac::13)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR18MB4558:EE_|SA3PR18MB5391:EE_
X-MS-Office365-Filtering-Correlation-Id: 65aac12f-ce34-4aee-b55f-08de64679740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|42112799006|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cElyT2wzMzB2R2VocEJ1cDNkQ1hxTlNwOVRVcEVzNE1TSE9vcld6VFVlTG9j?=
 =?utf-8?B?QjRpKzNnSGt4WEJ0aDFrR09mZFJnYkE3M3FjNVcyUFBWQnZLR2RtaHBIcFpH?=
 =?utf-8?B?aldIeXFTUmJDVWFoZkRxcnArclcrRmxjSFZXM2hvUEdyYnY5NTV2OFRkMysr?=
 =?utf-8?B?Ni9LQ0NJUWpiOWpRRit5VjZONy9pOUpjenpmN3JQZEpkUWg2OENhSGlZMG9D?=
 =?utf-8?B?MnBVaXpDV2tXT0djc2dJbnZTWmdZSHFDMXFvNFFpTVpDbkFZWFAzQnFLVFFS?=
 =?utf-8?B?RmgzaXdlOC90VXQ1b1Z1TERRSkZ3bG4vR2Q1bGlzMHBKYVJteVRjdXE0d0Rz?=
 =?utf-8?B?bWl1NUVIOUhuSHpkSXVBZVJFdG5tK3VzQmx6azJwMi83dVA4dExFYU9SS0hv?=
 =?utf-8?B?SkN4NUMrOHNiVTB3R2tLSWpCbnk5cE5lZ3hOLytkR25XVXZZQUdZTW5sa1kx?=
 =?utf-8?B?ekhDcVhZVkdpYnZaSzVhVkxVcmRlVDYyWDZZdUV4OFlFNmtpeDJrVFhDQVBp?=
 =?utf-8?B?Y3FNYXlUZzlSZnVpdHQ0VnBkVndYelpmWW9mUXh2N2Nsd3MxajlRYm5QdmFq?=
 =?utf-8?B?UGdMbmpuaklNTUpQdndkTVRORXBRc1FSMDNBUnlHSE81SXUrb0dDa0FDTGhV?=
 =?utf-8?B?WDQwdmJVZXdVNHUvdHNyR0JwWUNtODM4S2ExSVFyQVBOWmg0Zk9zM2tQRCtE?=
 =?utf-8?B?MXhxWDV1S01MWWY4YUcrMW9RcE9hdm9HeHF1UmJRYm96QVV1SDBSZmNUdlpK?=
 =?utf-8?B?Z0tQajRJRXVuNDhEaFNCTDBFT3B4Q0ZXSzJjeWNtQlRiSjJyZ1BxUlJuVHJ0?=
 =?utf-8?B?S2dRL25ONTNBRTY2YXVubGhlK2tsMHdSM3lIOEUyNUFHc3JsaHBiUDFCTExB?=
 =?utf-8?B?U3hzWGRKdWVJZWRjYjlUa1d0a3QyVXp3VU1UQ3BONmI3TWo5dmlqclRRVnUy?=
 =?utf-8?B?MW1FTEwxQXJLRHJzN2ZFZ3E4WERDMGhMTmlMNVhJQWdmZ09EckpXNGRQWno5?=
 =?utf-8?B?bHNsM0JsOXU0c2ljMVg5WTJnZVFVUS91NnE1YVdXQ3ZDRmJkWEtRY1BVWW1p?=
 =?utf-8?B?L1NmeHZqWTlsTzJDajFwaTU2NzNXYXBscEFtcS9BVElSWU03cjFXV2VMSi9M?=
 =?utf-8?B?eTFsRmZVUzd2S3pldGZLdHRmSnBqaUZqUG9CUmc2MnZFY0tRVXg5aTZsS3BQ?=
 =?utf-8?B?dXBWZjBvQUJieEFrSnVpUzlkZDNkYlRHT3JTQ3BWTi9MMWwycFFlVHNYUUZX?=
 =?utf-8?B?MlBXSmlrNnZMOW0ydGhLWVpHS0M0aXVxazExdHFRdjNRMS9heUtHK0Zod20z?=
 =?utf-8?B?MDUrVnhtWnJGWStJRlJsTUd0YVgvZVBLQWJZanAxemRPdnBVajAvWjNsZlFp?=
 =?utf-8?B?d0wwNnp0eWNMZXhxUlZBK2JWSE5Bb01xOURNWWx1M2JhSDlNbDZReWVxSXNx?=
 =?utf-8?B?NCtCcnc5QmozRVJmRFo0UjVERXRXUjAzd2xzL0JvUGIzVXk3dkdTL2RURTJG?=
 =?utf-8?B?MHJKVlJiUUU2cEJjeGU4eUpNZlZhaHBJVVYwSTcxTUIrRVVmU2NBVEwzZjlK?=
 =?utf-8?B?WlVUUWpxVmdnZkJjSHFNcXlRY2xtejhXalFFbkNEd2Y5Uk4zaGJvUC9XczNq?=
 =?utf-8?B?NktGUXZhcHY3TjVyTWZQMGpsa1VFK2k5ZDV0T2RjQklkTVRzbjU5dUN6OUdZ?=
 =?utf-8?B?b0llbXRpM29qejBsV0pLNWxJR3l1c1BnRFZIUDVuT0l5WTQ2ei9UcDhBUXEy?=
 =?utf-8?B?Y2g2WUVvbTR6YTZrTHZxRks2dEpUSVhSN3NUSE9EbTNzc2dUZEdTRzg2bGhG?=
 =?utf-8?B?QnlrRDZsc0VlMEFhTG9GeER0dWlFZ25pbkVkZFdMVmIrY3h3R21qclhueTVY?=
 =?utf-8?B?dnBIR2ROYThPQ3loMFJkTkxRMk0xcFNMakhROEowZkhLLzViN3hPVnorWllI?=
 =?utf-8?B?ajRGRGhBU0cwWFg4dDFJdFVWdUM0dG9NbzlCMkY5Q2wrSXIxNjRsZkpYOXdm?=
 =?utf-8?B?NGtOSVNFa2wzTkREQStlNU5WVWNmYmFWancyZzQ1anVsbG1uNXJrRHhzd3BV?=
 =?utf-8?B?dXA2OW5BL0YxZU56bUJ3ZjVPNEcyVk1tV0hOUS9hMkNnTkdIQ0M3ZW0xMWVh?=
 =?utf-8?Q?BMH4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4558.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(42112799006)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1pLL1V6NkVJMUdrY1hwdlhsN3lYNGFsdC9ERjZkcXVRZFJXa0FkWHVkNjR6?=
 =?utf-8?B?bXhJeWwvNko3c3NEdjhLUVppd25Ebjg0b0FCNFFyRnF0Z01HOVEvdmxnRXpD?=
 =?utf-8?B?cEh6Rmp5aXdJWFJra2xwejUzeUhobTVoeHdjYk5IVzJNSVpoaHJ5WWsxUnd1?=
 =?utf-8?B?WktacEYrLzF6MHlHdmFDVFZpNDhJKzlOSkQ2VktWcGF3U1JFREJ2QUhyT0k0?=
 =?utf-8?B?cE9JcW1TdW0xcVZITk9GdU5McjZEdW1CZlgvZjgyRVFOQ2hFcnFESElPWWFj?=
 =?utf-8?B?R2huVHRWR25TaDE4b2p2V1NINjF2LzB4SGlLVnhLK1pzWGNBbEdxbndmZjBW?=
 =?utf-8?B?QzNNczdRSHdPa3VFTWJuYkhsbmtXMDJEVDNiVjdLTHJCU1pBOXdGejYvL3Nq?=
 =?utf-8?B?ZTFiYWhKVmJNMTNwRnNoaHREYkIwZzI0dUZCTEhVaUs5dmxxZDBCYlVpeENC?=
 =?utf-8?B?M3hINkpFTG9EZ3RjVWhHTDluMzRmRTdLSnhRTk5sSWNJV2NGa3ExZHNFMFF5?=
 =?utf-8?B?SWZFZC8yM2tGWUJVZktybjNPZExEc3dKQUs5cjE1ZVNrUGJGdWs5VGVPL3p1?=
 =?utf-8?B?NlhkcXFWc1A4aVBpdHc4M25qL3dkd29IQW1OVjh3YnNNVnZWNElVQkNMU2cw?=
 =?utf-8?B?aURFMm5tWkRjS1dUai9tNTN4bER2eG85c00xb1c2S1U4ZjFIRCtIVlQzNjZO?=
 =?utf-8?B?TmtheHVWSUk4VW55Z2JxdjRQYlpCM0drd0xrekZBcUNJYStVRHQxUEtWOERp?=
 =?utf-8?B?ZkV6ZGUwYWVjZm14ekdQdjNKd2ZVOU15T1VRRE5tRTRoTCtQSVUydVBnVFZW?=
 =?utf-8?B?OFNsVmp3VlR3clFyS3dDRnFodmN4WHRIU1dVOXZTR0tiR3ZwYW43aVUraWVW?=
 =?utf-8?B?MFBBdDNqTHdsMmFzWVJxU2xGdXltaG9RYzg4eU1Ob0RKVGIxVXhRWWJFV3BS?=
 =?utf-8?B?RVA0TXVTMVR4TEZQYmdpdGJCUUd4d00xQ1lYclhmK1RwdkJncTZpRzgwYnJz?=
 =?utf-8?B?TDVDRlFvQ1dQZitETzdzZjZZZmlEbWsrb29OclVWQUhhUWt6S2dhbmhadWh4?=
 =?utf-8?B?T2VvZzFRR0J6czRLYi9JNGlLWVNrTTJSMndUWmRtbFNZeHJ4Y3hBb256aGxH?=
 =?utf-8?B?Q0lGa3FIVmlnTGI3K3hBTUVsN0hBMTYydWNOYnR3U1U5VDBEaHNNRGxPaEls?=
 =?utf-8?B?MlBaY0VVYmtrdWlHdFYxSEI0eDhlZ3NqQTU5U0ZMdjk5cHNmMXVMTE8ySEcr?=
 =?utf-8?B?cTJIaG5ZRDNERmNmb0Ztd3pwUXlVcS8vYVpMUXZqZ09QOFpJR3BXZ1MzcXdL?=
 =?utf-8?B?VCsvWlNnbXBCRDZEQUtFV3pzNjlPSkpJb2owNGVodEMxSVpwSjdmbi8rUzRh?=
 =?utf-8?B?TGt2cXhXRmNHUUJuVFlHWkFQazM1QmZGN3dENHNabWRvdkdUU3R0V3k1QXlN?=
 =?utf-8?B?SGdPKzF5YjFjUWE0dWhHSHBselkvL2NQdUp5QkdLUVhhUzNON2drWjNXa0Q1?=
 =?utf-8?B?VlJ1a0grL3YzendLdXpYWHllY011Y2lnQnJKRVNwMG9HcktLbkE0eFliV2I3?=
 =?utf-8?B?dDFlclY3S0Z0WmhrV2g2QXIrc1hWd2ZBY2FoYWI1RlFtblFVNkpKNXJFaHdS?=
 =?utf-8?B?TzhHY2g5Vk1xNzJ6SmNyS09MbW5RWllKd2hUdFF1ejlhRG11cnViWjh2b2pl?=
 =?utf-8?B?SGZlY0p6clJhVElpZkZaSURxT00yNDNYdGlIZHNJTWMwTDFhaVJpQkh0V2dz?=
 =?utf-8?B?bDFXWDJDeG81OTVXaTgyRU1XNTJtdjE1MENEM01aZ0FHbVJQcUdORDNmcEt1?=
 =?utf-8?B?cWswN0pqQnljdCtrUElsQmJXNTEyei9wdWRnZHY3aGNRdHdKTlIrMWlkUVAw?=
 =?utf-8?B?L3AyRGlzR0Q4WjRtcFlJa2lUSzVKOXhGLzJYY0MrbHJ2VFhtNG1laUxmcTds?=
 =?utf-8?B?REM4OEh2VTRzMEFHdUZrbk5Ba1phdEgxajFaTXVBdHkwNWtuOGJNaXVjSGwx?=
 =?utf-8?B?Wnh4MjVObU0vVndCUllVenNUQjJyS213TG5PNW5vVzl0RVY1SDZPczFpMnBF?=
 =?utf-8?B?UXgySXhQYnhWMFM5SlVCU2tnanNjS01SU3RrYzJIVCt3SDJ0WlFQL2E4Q292?=
 =?utf-8?B?REtkajhXOUlQZk82SWZYODRoTUloMW1LOXV3QVlnUUVJS2QxSzV1MjJqNFVz?=
 =?utf-8?B?dWw5bGI0aXk4YTdMSjRadEJTRFZRaldzTHdzMmZiNG1ITXdXVFQzZ0lnMDhP?=
 =?utf-8?B?dW5OWVZCTkdPYWYvY2UxRjU5WkZxRjMxcmQyT2grTjhNdGRYOC9LZjBQTS8z?=
 =?utf-8?B?OHR4L25sL2crQUUyR2kySUwwZ0tyUlRwdWVtblQvM0JVQlY3WEVhZz09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65aac12f-ce34-4aee-b55f-08de64679740
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4558.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 03:35:21.7024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScKGCS0wXbSQrCh/OEt+mKoAoOdsces9oe0777CsCMgxFppbCGWbl20jzctEtvOk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR18MB5391

On 12/27/2025 8:50 PM, Krzysztof Kozlowski wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> On Mon, Dec 22, 2025 at 04:45:04PM +0800, Tzu-Hao Wei wrote:
>> From: SriNavmani A <srinavmani@axiado.com>
>>
>> Add device tree binding variant for the Axiado AX3000 Arasan eMMC
>> controller. This variant identifies the specific eMMC controller
>> implementation used on the AX3000 SoC and enables the appropriate
>> driver configuration.
>>
>> Signed-off-by: Tzu-Hao Wei <twei@axiado.com>
> 
> Incorrect DCO chain.
> 
> 
> Best regards,
> Krzysztof
> 
Fixed DOC chain in the new patchset.

Best regards,
TH
