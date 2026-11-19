Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795081549;
	b=rQdZfTEGFh9n3pVrsczzVoqL7VluQZHGio69/zXrLcdVqV3O2YQ9odQcr421LuaM+T7N
	 xW9JSNrIsUBEY5tL28Y+2zo1/m3cVHPU7RmXDf9EOEocUzqsEQt8n2Rb6Hz/HXNq9XJM4
	 xkHYxrHiehMdyu87coJ7tcaDvUMADgE6Q5CRm2eIsthPkhlnEkOSlTDx8shrnQjVGEFb+
	 MbRHzmZ/Q0G5C72ZDblEQ74M4NtubU9/4ETGMi8+RCwPKcDNu5jZMlOQo/gBr3R3+Z8vs
	 PLgvrsB/D6KTkK9W2HcaJuaCopk8DvhRA7g2elW2YQfnx5iOvh7lWCU53Rzbbp/a4BQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081549;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=7yI0m5vEIofrsKXUkPh/xf7LkoSo+M/vUBFhX8VUEgo=;
	b=ndsjMwhKGJx4fUyZArwHuzUjCuieVdCyJOW99b0I06piE2/go999TSi7Md4hzmCVEukX
	 Fhw7v9Dak87XiPbP4ebkLpvBMtwj7S/GjyfQLoJNfe+/aRJoyh4Oibh55Nu0xM2r8d6c4
	 +b7STIpFk6dg+Y/s9hpP3+jwbe6Dfuayq0Uh04ZGDcYws3KLbWTgqk0nyvo3sMV+g6BD9
	 5NvocfJPRN6Mp4FZzhZl78P2LwfrH7QdgfJfM07o/NwBPz+9CF0wOoxJiO+C5qysANzN6
	 S+hnnqZkFYuRn5pNIeTANzyny+YpFG+yZZyfT61I214UfJHNP2cCuna+blYtDw5oirQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=S0lhVJJo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.5
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010005.outbound.protection.outlook.com [52.101.201.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA0A606A33D;
	Thu, 19 Nov 2026 09:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EA0A606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=S0lhVJJo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPOj+LIok/RqBdYafEkMPJWDl+RfehJGOuuXbQTfYZRsGn7HES2Ca//OL9o4wTjUJMqyndrNAhCmLmlRtMa0A0VC5/r4F1AaN7Zupis4Tf6fprz/zEMKpiS3agDKcbmZiWIFB+yj0FD0sWgGA16Y6xz87OzQA3Wvv2LJs0IIAHI1Ye0z6cg/VexCor8z2qcL6e4vN/8hwf7kFAkQ32bonANfTX848hzBWB6fI5Az+DTQGPfWkoH9pP416IxFDjFyTO4cdG7wqnLzkhMrO8uPtvlWoEcqA6IWf944QWAXatJBtDYvxOZzlhmbdTd3YI0hq3dZLxOh3nis8a5jomZGFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yI0m5vEIofrsKXUkPh/xf7LkoSo+M/vUBFhX8VUEgo=;
 b=p4NJcmYWHjxY0jqnfH1g0RlyGI60RaIwLHvEBvpezuiz4BeMJQA+zaL8ScMwwmMx5SucyZ1emkxemJSJqsg2khu8/rOiDCd+6rNzzL02xV+ZjncWHUTIwKg7Fabk8vjOYRGyrgv3NtMB8xUGizxY8O7P+EXMpC71gislhD6BA1T9QgHvOsgMBCJsve8YbGRojvRLpvOir+mqokOjIndGTQfadv1H3I2VTn9uhNaObnoOpTnnCD82jWGtMWKfLHWaXL57DXoKK0XyN45+A1fp+MoVGw1kONjgGjKTWWS45nVpAAWEI2leYNjZvFr3omtCE9PbCY1Q/lha08pmr54RiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yI0m5vEIofrsKXUkPh/xf7LkoSo+M/vUBFhX8VUEgo=;
 b=S0lhVJJoIfNspzZFou4BeIEjiO1eufMd+qirsQoubwDpUTiwHUsGNA3XwKtxiBEKEMNoxR0H13tVP3lwU0wdd7hzV36nb5ZCgZWTvJE08diuhElIVFyIxR8LHMmKh/g6G0bpnq7wWfRNUQm2nrUKQEpC4ibg69+cOyweZ79U7MiUXkgXlzR4FPwntd8eO8lVfpuiqsZoQHloYoJZShtAsFhDIqZuaqyWn/WE/QJfK11NmkSn6iqsOyBZJ/OqTQn22KwO1e3dSHo8xGEzUaNdsCOc3M8OW2EW+/0mN0dgR62wi1sBt1Z8bBAAhXh1mHeYnuEUi+TfHx6+vJET+zDDlg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SJ0PR03MB6987.namprd03.prod.outlook.com (2603:10b6:a03:43b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 19 Nov
 2026 09:45:46 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%3]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 09:45:46 +0000
From: tze.yee.ng@altera.com
To: Adrian Hunter <adrian.hunter@intel.com>,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>
Subject: [PATCH v4 2/3] dt-bindings: mmc: cdns,sd6hc: add SD6HC DDR50 read-path tuning
Date: Thu, 19 Nov 2026 17:45:34 +0800
Message-ID: <20261119-sd_cadence_ddr50_v3-v4-2-95a94a0aaaf3@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261119-sd_cadence_ddr50_v3-v4-0-95a94a0aaaf3@altera.com>
References: <20261119-sd_cadence_ddr50_v3-v4-0-95a94a0aaaf3@altera.com>
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.16.0
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:a03:54::17) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SJ0PR03MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d6517ac-f0c8-451d-b9c8-08df4621e2de
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|261102123227099003|261026121527099003|56012099006|11063799006|10067099003|261022105027099003|261022075727099003|261021123027099003|261026140227099003|261028144727099003|261021121427099003|261009223027099003|55112099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	CVrAme0EahYYoNKetf2OSWqwoKiz2gB52ptLw7ineyRiNHEZYsZuDbBkjt9t1pgIEXxNl9EHK8EEDf34BZEFw0Wd8mRzEnFvVo417sW/+748yIVLaxGTbmeuWAExAFhZdkzV3oBKd4/tKDpWCgaKWhhFSsq7LDHvRF6SjtfQxtlJPhOAReOexmMm5Rdtb+ZMj7zgiP5P7H9E2M6SbXfnrSg3PGKrcOGV9KNRvY6SDae22Hq2wuSmYyNt0CayZ8+mfRL1WpuUFJKNQk76ycCSJAsU5cVNj7ETWNNOYKhTstFAjoRl18Z7rvSa+LtQwEZbhY7+OXUuNOCTqmqVarVxPbWWfdj7AEYqgt/p0oeMuSlBga0mJdl4+DG+3iWTor3EkS648iWZ4ZuMcPGgfcSYEMbZjhkDTbEdzJnL8t6jC917gkBz2W4ieDJrZIbpsTA2HNF5k3Foe9Rx0ipV3Va1O0SiTWM5GJPxJoE2DOyCODZCNr4Q2PrI2LzRDZDpStMl+/GWfrAUMPXYjcctfhWgebBDmJA7YjTxJob4C5s27qq5GI5jJPCdpAj9NuO/aCMdetdQrzlKkOY7+psKwWJ8MrK78q+KMSfEBXBwOnrc87tNZejpdSogQZxXYks8zMOq1x5veel4dOWkUCqtNKc1mmhECxCAckGUZvypfx6qB7M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(261102123227099003)(261026121527099003)(56012099006)(11063799006)(10067099003)(261022105027099003)(261022075727099003)(261021123027099003)(261026140227099003)(261028144727099003)(261021121427099003)(261009223027099003)(55112099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTRpQ3dJcDkvRlhUZnVOdUNYNHM3ek9vSkltd0NLcWdqaXhFWFRtM2FpS1VV?=
 =?utf-8?B?b2NaWUhYMlo0SExPYjlxNXpyTmo3T2FaLzczKzFHcHRqN0E1VWpncUlKZlV6?=
 =?utf-8?B?VDlMcWQxTlhwWlB6RDVTRGNTVk1nTDFHenN3K1dsby92TUZWN2N3YWJvaXNo?=
 =?utf-8?B?bndLa29qQ0RpZ1BvQUV3UzI0dkdJS0xCbCtvS1E4bk5NT20zWE9sVFZHQk1F?=
 =?utf-8?B?bGpKc1lkTmNvWTNIWFRaT0lkUmViWUNqV3Z0TlNteGVPNEt1a01XeXlyaUJG?=
 =?utf-8?B?ejR6SWpPRHMvbzIzekgwNGozbnc1QnhmVVYvNm03UFJVYUtQRjVwSjZSMlpx?=
 =?utf-8?B?aEJTU09Nemtvck42b1hIaFJ3eGlyNHNZTFkzK1NwSnlBaFhZbml6MWJycUp6?=
 =?utf-8?B?dk5BVURuUFFud1liMFZTUmVMOUdzTzFRNjg2djBMRGtRUzR0d21VdEZXTS9h?=
 =?utf-8?B?R1BMTWNZY3lGdTJSOTFVMmp4R29rTVhBSDI4OGxPWDZkNXgvUWFkbjVJVHFh?=
 =?utf-8?B?ZmorSmFBZHRidU5ZQTIxc1RUK3dSM3dGcXNwQk0vcDBEOGxRbXorRVd5TFk0?=
 =?utf-8?B?U1Z4RFc5cmlMZjFTOWV4eWZwNTFjak4xMy8xNi82M1FINkRna3YrSGMrKzl0?=
 =?utf-8?B?N1ZDcjArdnR5R3U1UDBKM1hKUnZwdEVENmJadkozTytQcDduelZPNEQ3cXlm?=
 =?utf-8?B?bUp0ckZGZlBUbEVDUkdCRHhuZmdUcldoemRROUJGcGM2T25uOEVmd0dzbXg2?=
 =?utf-8?B?ckFrZzB4VlVrdmpmTmRGMjk4NkRoYXRGVndTWjE0RG16alpJNDlaU0hHTUxF?=
 =?utf-8?B?QWNwd2JYTjQzQlhkb3hOWkJnbWpWM3kzdWt5Vit2K3V2N2lXbjRVb3VFck5O?=
 =?utf-8?B?NVNYVHJBRVN3QnNCSGZ3c2k1NEJ1VjNHSG85U0ZKc2p5YTZ5KytPY1dOaXV0?=
 =?utf-8?B?TGVJcGpaUlBBNXF6YUZFbkM0cWkxL1Y2N3Y5aytReENSaXZCbXhSc3lYb2Mv?=
 =?utf-8?B?MGxwckx3YkFZNmFMcld3OTFmMXV6R25wWTlIUWZreGhUZWg0NTJqVS9RbnMv?=
 =?utf-8?B?WktRc05IV3JjMHdsTHkrWGxWQThZNlF5eVZkQW85OXRwVjE0cHIwektvV3px?=
 =?utf-8?B?RTZNUjJaSEZSOE5xMW5EUjVlN0xubUNzVXRCcDExcWhKdldrRm0zOE1LdFJp?=
 =?utf-8?B?aEVqbVZLRFBERTVxN00wN1lGMGFMYStsZ3NCeXZTYU1OL0k2SUlBQzJ1VUZ4?=
 =?utf-8?B?b1RlSHltczJRNG42dTJBNUxoQ09EcUlucE4yVEo1WDdEaGNhN2pFampFWWl2?=
 =?utf-8?B?aTFYMGFjZytEUTRQdWg1Y1dFMzdRS3dlbjhVemFUQmRwU25WYVV6RjdQUENV?=
 =?utf-8?B?Wm04SmZiSmk1bnl3NUU4ZFY2aVd1YkVwK2ZzK1R4SjA3TElHSWdSckJ0SkdS?=
 =?utf-8?B?RVBXRmlOcW90ZldTUDhkQVU1aVdqOFA1NkJqZDJETU9qR2NLWC8vaHZSakNB?=
 =?utf-8?B?em1UZVZGMlJoaU9LZmp1TitTQ05JelprdXREVXpXNjdaaE1kRjA5cmpVU0U2?=
 =?utf-8?B?cW5GMllhNFUzM2p3eFFSQ0cxbjllSTFiYnR0SHhoOHZPZUdWQi8zVnFUdHd1?=
 =?utf-8?B?SFhEYUV3QnEwRjdMNWR3SFFJdmZmZkZnQmNmaklrSVh4YTAzMXhhRitnQUJw?=
 =?utf-8?B?N05UTTNxeFNRSnhaSWplOEpaTkt5ZUJ6ZWdpVW92VUh2dm9Sell1NGkwRndy?=
 =?utf-8?B?RFZXUXg2OWpadjM1Z2JXUy9EV1R3NFRpclRUZ2ZCOWJFUnphVXh6dHNzeXN6?=
 =?utf-8?B?MmdMbmh4bFhUTXFQc09NTzdHeUhucmZtVnB4RFJDejJ4eXQ3OVVHZmN2N004?=
 =?utf-8?B?YTRuRzZtajlubTNsV2ZtM1JzbFRNWmxrZ2J2Y3EwQkt3OXUyanhuYStNOFor?=
 =?utf-8?B?eXdNb0pMbEdaYytsbDI2QWJmNVdWZDg4blo5eEJiaHF3bUJqc3R6Tno5Ymcw?=
 =?utf-8?B?RmxkQ0pCOUtWeS9nK0tmMXVOZ2lxSlJpcURKNEIyeVdCZ2FGbGZlTVV1UnlR?=
 =?utf-8?B?b3ZiRXd2LytlSW55MldCUFZ3b1lMd0RvOUVrNldncWdRNlY5ajdRWk9PUUh4?=
 =?utf-8?B?TWNFZFI1bFdvSExtaGlLbzV3ZDk0YUkvMHg1WDlydkR5WGlmdEhGNjRwSkRt?=
 =?utf-8?B?bzZCMVZ6Q292eEhIV0xKSElLQTZTNkRmak01ZXZVSEk2STNzcEM0Q292OU9a?=
 =?utf-8?B?S0RWZmF1QzZuWDJPN0ZGNVBTM0hEakI5cDdYVXE3NExxa3liN2Q4dFBZK2pz?=
 =?utf-8?B?d0ZuajZ0MDBzWHk3Wi8vdVA1aE9DeU51SzJudHdzK1BrN01nZDlJQT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6517ac-f0c8-451d-b9c8-08df4621e2de
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 09:45:46.6986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USKZs/NgpWkUtVkNcu2HUv4jEWxOJGQlKkJvYPcJ+u+w0shipln/BYWKPS/Any8EjnbJkzixh6GzXd7qWQQDRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6987

From: Tze Yee Ng <tze.yee.ng@altera.com>

DDR50 has no CMD19 tuning, so the SD6HC read path must be centred by
static, board/SoC-characterised PHY settings. Add two optional SD6HC
properties for the extended-read DDR modes (SD DDR50 and eMMC DDR52):

  - cdns,ddr-read-dqs-delay:    read-DQS delay as a count of DLL delay
    elements (0-255), each cdns,delay-element-ps wide, that centres the
    read eye (default 0).
  - cdns,ddr-no-lpbk-dqs:       disable the loopback DQS read strobe and
    use the fabricated phony DQS instead. Loopback DQS is the recommended
    default; set this only on boards that need the phony DQS read path.

Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
Changes in v4:
- Dropped the cdns,ddr-phony-dqs-timing property; the phony DQS
  timing is always derived by the driver. (Tanmay Kathpalia)
- Dropped Krzysztof's Reviewed-by since property set changed. 
- The two remaining properties are unchanged.

Changes in v3:
- Re-expressed cdns,ddr-read-dqs-delay-ps as cdns,ddr-read-dqs-delay: a
  count of DLL delay elements (0-255, each cdns,delay-element-ps wide)
  that maps 1:1 to the 8-bit PHY field, instead of a picosecond value.
  (Krzysztof Kozlowski)
- Added $ref uint32 and maximum: 255; dropped the redundant minimum: 0.
- Used plain description: text for the three new properties.

Changes in v2:
- Retitled to "dt-bindings: mmc: cdns,sd6hc:". (Tanmay Kathpalia)
- Renamed cdns,ddr50-* -> cdns,ddr-*. (Tanmay Kathpalia)
- cdns,ddr-read-dqs-delay-ps is now in picoseconds. (Krzysztof Kozlowski)
- Replaced the read-DQS source selector with a cdns,ddr-no-lpbk-dqs
  boolean. (Krzysztof Kozlowski)
- Reworded the phony-dqs-timing text. (Krzysztof Kozlowski,
  Tanmay Kathpalia)
- Dropped the SD4HC note. (Tanmay Kathpalia)
- Scope the new properties to the extended-read DDR modes (DDR50 and
  DDR52). (Tanmay Kathpalia)
---
 Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml b/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
index d5ea2717904b..9f48a737241a 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
@@ -74,6 +74,25 @@ properties:
     maximum: 1000
     default: 24
 
+  cdns,ddr-read-dqs-delay:
+    description:
+      Read-DQS delay (DLL_SLAVE[7:0]) that centres the read eye in the
+      extended-read DDR modes (SD DDR50, eMMC DDR52), which have no CMD19
+      tuning. Expressed as a count of DLL delay elements, each element
+      cdns,delay-element-ps wide, written directly to the 8-bit hardware
+      field.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 255
+    default: 0
+
+  cdns,ddr-no-lpbk-dqs:
+    description:
+      Disable the loopback DQS read strobe and use the fabricated (phony)
+      DQS instead in the extended-read DDR modes (SD DDR50, eMMC DDR52).
+      Loopback DQS is the recommended default; set this only on boards that
+      require the phony DQS read path.
+    type: boolean
+
 required:
   - compatible
   - reg

-- 
2.43.7

