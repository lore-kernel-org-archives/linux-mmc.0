Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A6812F38B
	for <linux-mmc@vger.kernel.org>; Mon, 26 Aug 2024 06:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724655488; cv=fail; b=YbTZNiSv5hBrzg471CSxUM+xIgHdFA2vaJGCIxP6M2kcvLsWQkOkDaXsB/9aeB5q3QwGkQkIXp9bgaChPu7pyCZHmGif++uctZ/P9pjBvDH8al7DzmT2gS20krXzBJ24kRzrMsKzPBgCIpNY79fpfIXxzEUFKyvlmIs8/q/5HXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724655488; c=relaxed/simple;
	bh=GBZjTS0lmXL2cUcoD49QJY2ilVrqDYNRPGBH6/zeSgQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ONwSe+/nzgZjkDgphUDhunyFa/wIMRzFIJaa+0vRR4LKDum7mYmdpZ1NRZssDEBbye996xp3o06FcCaij3l60BPpgZRwwejRh3BSeLknxej3c9spopMPoP+7gaWX/pd+RIsBunnWUEdd+ZIbI48Rumd2yFOhIXFMZD/GLGBF8CM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ldWhX7Mr; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=a5W78QLK; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ldWhX7Mr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="a5W78QLK"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724655486; x=1756191486;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GBZjTS0lmXL2cUcoD49QJY2ilVrqDYNRPGBH6/zeSgQ=;
  b=ldWhX7MrhBTinMKAVz/F49H8xL8yvHXZ0l098yaYhkobNBHvHtVyT+TD
   4FLxgIjin+2dp9rSabqYiv5Ery+tSY+7QRH7tpHlDN/35k0OPH6SCyxFA
   ckii6RMqJLYcLXzF3hR9mJK8VWm225JV75b0DaLOFDIwndmXGsjhq2Egc
   FOINsNi01vaZSJ+5OIMVSBKmfQE5zd1vTq5K4FtCA/NSJuTg1hryTRkqe
   cprnhS/NclzlkZU8d9VlCGbnOLG2TTQWCYWJ0WzP4bHSz5a6x4W9wVW/W
   w4cI/3ByKfGeB07Jk/vuUDImaw1u2c8hciD/hFO4jJm5VB5YSmdZUNCU9
   w==;
X-CSE-ConnectionGUID: s1+O+neVQbi7m3w4TTBEnA==
X-CSE-MsgGUID: 2NCjULBATa6FlC3QWoZqRg==
X-IronPort-AV: E=Sophos;i="6.10,176,1719849600"; 
   d="scan'208";a="25946739"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2024 14:58:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6dlT0Indv3kIxYZxClK4XYXmW3sAzBy6JWg9u2nbeTf1H5DBl0WGCrRapIDlRHYYDKnwBSdLY4iZ+Y+MBYPjRiXx+sHzYJKCfdOWWqUHn39JcqdbiKfA7BhyRiXKv4eMrokfKO517LUmrjK/hj+lYGEl5IoYrQeTgLt1ZFp4Y0orFQWnXgUE4IBADV85ZMWFA3pnPFTykrXFbawbQ6ZuPOJzm6Z7TTb8VFozYjTOpaM8YtQkPjr1AuT5t5RjPmQtp/oTsKt+t+KqxJbtxPMC5cLQk80TuwQ2xEZtQCHNMcYTopYzClW46XKZ9K2LL5MGUAdol46k/jDY+5fAt8P4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBZjTS0lmXL2cUcoD49QJY2ilVrqDYNRPGBH6/zeSgQ=;
 b=wXViMQY0lFc5NkyEszZZWUPiViHWUWFjhHEkVDI9SKqfnBzsXUjuUXHGa2wXwcxK+KUw62KYho5CKql6mzJHVsqppEtJ3SnDu37pkKASpZPTEbJTueYMhKB04s5uH9sWBsWDlmTOgUoZuINdXBQwA6e8xwRkfTi504ChaUFQbvfKwpN84BJ1T9x7bLsQDIdw75Oq5U/EpSndhHBcNliPHhu9YmpKxrZNoxsj2z8OVQ0zKHiNqAkcoGjtgZKt5acimptxLTpm89NX9988UJM07ukqOO1w4vz8gm7+OqmUAanorXbOOyQMRaTQtJjw3VDFnV/8acE9O70J/SsQzjNp/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBZjTS0lmXL2cUcoD49QJY2ilVrqDYNRPGBH6/zeSgQ=;
 b=a5W78QLK15FYYTlIeIUY31wReKm54cnqQeeEaoBGAU2Uyhfh7Wjwb4jSzGvD5i1XcCMms0PseXUzqJB6knKFC41ESDex+OLHqEwE9bm4/+QEauWyetL+Tedxmr9n80TqEYNfz501MFNMsIkr1NGs9E5+cX/6bwSCZYA3kcIQ93c=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BL3PR04MB8138.namprd04.prod.outlook.com (2603:10b6:208:349::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Mon, 26 Aug 2024 06:58:03 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 06:58:03 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Ricky WU <ricky_wu@realtek.com>
Subject: RE: [PATCH v4 0/9] Add SDUC Support
Thread-Topic: [PATCH v4 0/9] Add SDUC Support
Thread-Index: AQHa9sJ1Fgtj888U6kGa1b/dDuzVu7I5GbsAgAADPMA=
Date: Mon, 26 Aug 2024 06:58:03 +0000
Message-ID:
 <DM6PR04MB65756CEE03C15524EF646C3BFC8B2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240825074141.3171549-1-avri.altman@wdc.com>
 <3d7a9953-afed-4b45-a209-b797634e6bd8@intel.com>
In-Reply-To: <3d7a9953-afed-4b45-a209-b797634e6bd8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BL3PR04MB8138:EE_
x-ms-office365-filtering-correlation-id: 3d756496-5982-4aab-97a1-08dcc59c6e37
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U0pTS1g1RXhtTk82RGFQY2VxbzdoU3RERTFFdExGMnN4VWFkVVNvM1NtNlVv?=
 =?utf-8?B?b0lBNlFIZ0RRSE42VU5FQXl5eEJRT0VLbG1LS0pnU2NhNlJiSjhyaHJ4aVVw?=
 =?utf-8?B?ZGlSZlBOc1ZmUGEvWE1lYzZyTHNWd1ptWnlCZHV2a2p1aXNUMGdya09BRjA5?=
 =?utf-8?B?QUNxcnRMWk5lUytONHU5UVpjdFAyWWU3aUkxMC9kY0RRaUlZb1B6d0hLOXZr?=
 =?utf-8?B?OUE0VW95RjAvM2QvcUJPa1V0Y2pjeEZmN083dFJiaGRwY3dPUlNxUUE3NlhB?=
 =?utf-8?B?Q3NGRXpyTWFzVzhWQUxpVEpPQU9TNXNqMWgySGV3cCs5UVF2clFkNEdlbGpt?=
 =?utf-8?B?MG8xd2EraTdqK0hqSEZ5U3VFbTNCSFkwS3RUcWVWcUJPbXZ4dzdMbFduU28r?=
 =?utf-8?B?ZzBqdEhZNzBURld3bXhLbWpqOTl4SjBYcUk3RXkrU0lRc3hjMWlaZy9tckt6?=
 =?utf-8?B?TzVlWjRjdXVlRUhYNmlyTko0MHNyMzVYSFBMVURVWWZUZ05aTGVwSWF6OXNC?=
 =?utf-8?B?amRvbkRmUnRtQ0tOdFpxbjlaQ0I4TEc0RXp5VU1xVGUyZ2NtQ2NKZTRVZHh2?=
 =?utf-8?B?b2ZVYW0vMkovZWJ4TExzS3dCc3VscXczUE9VYmFLdDhoR2tSYzFxSGNzdnQ4?=
 =?utf-8?B?N1FwUEt1dHRxU3JNbHhvdHY5M0tkc3VvTjluWGdhUVJ4Ym1vQmVqNml0V09E?=
 =?utf-8?B?VmZsSVdsVjhtcXllS1pGdTc3VkNyWkxMV1F2dTJyMFFiYmh4QVhQS29WS3lv?=
 =?utf-8?B?dDdYQ2xCOHFzbVVvSDFFR01IY3c0OEJBYlVxR3pXdllZYW5NakJzNjRUM05y?=
 =?utf-8?B?YUJuZTd4VDRtaFFTcElHbENPT29Rbzk5QjhMaVpHMXhkZldOVVFrdHIwakI2?=
 =?utf-8?B?Ri9uOXdFR3prZ3N2eFoyNFZ0VmdhM21hRUIvZXh6NG9xanl2OU02OWwreW85?=
 =?utf-8?B?OFdtbG04bVQvSUJVY1gzZE5hUzBjeU5CbCtpYzZVUHdGQXFRQ2ZVcFpmSktJ?=
 =?utf-8?B?WUQwU253NXpoYm9jVUVPK2hHOUZLZjRyMmdlaUdwMnczckFPdnRWdEhXd29t?=
 =?utf-8?B?WlVCZjVMMjMxc0dPRE5wS0NFb1hUbGVRc09CM094NTRpNFNqS2sxVithcjY2?=
 =?utf-8?B?R3FnWW5GaXJIZy9HUUFZWkZVVlBkQ25aQTMzaURNWFZBTWhFdzZtMGttaXh0?=
 =?utf-8?B?UEFWa2tDVzl3T09CWllURWV1WGJMM0s1amdCYmZvWVFLRW4zRzRlWEpxN05h?=
 =?utf-8?B?ZG1aenMwVE5wK1Z6L2ZXeFF0M290WExwOXdCK3hFS1ltTmt3ajd5NURHbEh5?=
 =?utf-8?B?SlZHL0Z5ajVrVDd3VFJyV1JBSmxiZUxKWmRaSmlkYTdsMm5mYy8vN25YTTAz?=
 =?utf-8?B?RUYxT00zK3Z4UEkzbDB0ZDdqd1B6VEdKa1lJNHJLY2M4Z01WdmFLa0pZYXNa?=
 =?utf-8?B?SjRzYWFJa051eFk2VzVqNDNXNHloS1pOUFp4QXc4YVFuSHU0RHFGSFR5T3FM?=
 =?utf-8?B?S0VNOG9FRnF3bm56YkFEaHRDUXBhdTI2c0tUcVZXRm9XYVZyY0l4OXJRTEZ4?=
 =?utf-8?B?dUVMTTJjY3FsQWZYL1hWZGcvWktwNmpCbG1kSmZpRHd1RG5ib3BjZkRkcDBs?=
 =?utf-8?B?TUtZOG5BdE9JbUNvSWNaRGMxOUE3QzZCeUVHVWh4WWNmcGNkdi9jblRtcFJG?=
 =?utf-8?B?RFRNQjVKSjZISGtMR3MvbWp0WGtvRUdyTjdPbHczTHZxd2E5eVF4L2oxMnRP?=
 =?utf-8?B?T1JnU0wxL0x5YkZoL0M1WWQ5QjUwNkxUdHJUZk1RMzZhUWQwUU5lQXVhZzBi?=
 =?utf-8?Q?a6kCVPX1H+em3iXp+5EFD5TF5mpYw6X2XoY0o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VHJIUEZ2S0FCWmppYW9ORjA2czRYN0VzalkyVnRqaGpBUkJaeVNwLzRiOWxw?=
 =?utf-8?B?eHBDcy9FTk1oenZ5MTJrTVdNTERvWElpM2VRS3VtNmNmVytLbWgwQWtVUWlV?=
 =?utf-8?B?bE9JSlhOUXgzRFo4b2FwK1dkY2tQaDhORFRWM2J5bE51WjBBVjhYVUlNNnBF?=
 =?utf-8?B?Q3JqUjhYNnRXOTUyVE5hMkp4TXgzSjBqU2puelZHaUs0Qk01YWl4NkdRSkk4?=
 =?utf-8?B?elkzYWtBSnRtZzZvM3hpVEp3eUw5MGJsSHlhVUU2c3dSTHU3TUt5YXRoMVJm?=
 =?utf-8?B?MW9TdVVmSk50MlZCVFdRQ1dhZHBZVEN1YXdBY0pQWjAzNkZLenJpVkFuTDJR?=
 =?utf-8?B?REdNeG9zZiszbzNjb1VLM2kwVVphT09MZHpRYzM0VkQ0Q0M3djRManByTzNY?=
 =?utf-8?B?NjJmOGRIS0IwdkZCeElxeFdabXJ5UE9kMCt5THBzUnhhdjBmcFM0ZUJ2VmxX?=
 =?utf-8?B?RGEzT1FLQU1FQlYzRDRLVXZpR29qSG81SmZvUERhTGFldHhWMWFxdDF6RWtX?=
 =?utf-8?B?SGlhY2FTWHIveGxLR3ZHZm9ENGduWXo0MUhTMTFFQUI5eFJJQk16WDNiQWNz?=
 =?utf-8?B?ZTlpQUFmcnZSbnFFUUF2MnI5TFdNWlpQWStxQzhHYUFGY1lEbHV1SCtCQThu?=
 =?utf-8?B?SVVxZzdJV1JRS3hISXVKTi93L2xkMVhWMFRtVnp1aDJEZm96cnZFaTQwby8w?=
 =?utf-8?B?K2Rxc25mRkdvUzRPZEVGSU9yMSsrZ0R5S0ZBNVpGSjlTQzNFM1BDMVFTeDhn?=
 =?utf-8?B?a1R1amJTKzNMbENTNW1XZnZoS1JYck1VMXUwcldBVDNwbmxyL2FlK0JCWU1U?=
 =?utf-8?B?TXg2NzViMm8zQW9ZTVRXcTViTCsveGdEN0IxcXdidjJOelZUc1A0NFJLa2tY?=
 =?utf-8?B?Wi9KZVROMk5ZUEFRaHR5S0M5NzU2MlZiRUQ3WjRRRFNsM09tRWVPUVJ0L0E4?=
 =?utf-8?B?SGhKUUt6WGVQSkZEak9sWDF1ZE45czlLbEQyRG5SL1hTekRJcUplWTJLdzFG?=
 =?utf-8?B?T2swcEwzM2lxdXJpaUx3QVJQelZXak1nekM5eTU2RFF6WW1sMDAvTHdyVWkx?=
 =?utf-8?B?aGZzMFlwNW5uVjJjMUVkRjZkK2tiQjVhUEhPdlJ5cHByajl1MlRzdFpPaUxP?=
 =?utf-8?B?K1BpazlXcEsrWEZ1M1J6WTUwcGdNRG9kd1RFc25UbGJIVGRRci82RjBIY2dP?=
 =?utf-8?B?dlVYT1FQYjZoc3N3V1U5OFZWUUdEdFk1eDUwZk5VdnNpR1Q4RGliR01aWDF2?=
 =?utf-8?B?K0dPTnRZOTE0Y2FMVWVHOFdieHhROVA4VTV6cmtwQlI4Y0xvbHhlWEp3RW9Y?=
 =?utf-8?B?K21FMGhXTTR6Z0hhQXl6T213QmxTRzhWbWxXL28zbkYyU0lrck1ZRy94aVY0?=
 =?utf-8?B?MGQvUGVEbXo2MjRQRmwwa0hUTlhHT1o4ejNiTDhNMWd0ei9aMkFrZ3BQWUgw?=
 =?utf-8?B?WFlYS1hId3k4dlA4QVN2MnprNy9rRVpwK3kxK3JCWHZCQld1Q09Jd05TUFFP?=
 =?utf-8?B?Q0lDS1lkcHdPMzhZZW5pWlZpTUZKTmtUTTJBV2pBeExyVHdKWlU1ZUhtZ0FU?=
 =?utf-8?B?OVpYSGhTbHhuL0FTWmQxcWJnNnRYaDNjMTExOG1ZaHd2bUJHMExMV2xDSnAr?=
 =?utf-8?B?SXh4WC9XaHdHZnIvL0pFamdnWHNYZVpGR1FIVW9WeFJ5SnNsa3lQMFVTRUdK?=
 =?utf-8?B?azZCYUV5d1BXQ0dwL2ptM1JGUDFHdGx1K2F3Q1RLVjBzbWVEWk1UaW4rdThJ?=
 =?utf-8?B?eXUwT1VkVVRURTRJOHB1WjBZSVVXZzhqVkNqZUttVTNMaXZ2bDAzWnNxczhm?=
 =?utf-8?B?RkZPRUZ2MmdEUlhHajkzYWl1amFhNmMreFROMVg2Y0lLRHc5WmVpTXNzMXJs?=
 =?utf-8?B?ZDFSbkdZUDJBUWE5cTFWNXBrSFBqRFlPRmN5ZmJnOGxvTmJObVQ3bkRHTW10?=
 =?utf-8?B?aFFTMEc2YUNpWGlCN20wS05IZXdJWWRrRkR2cFVWb2pYTkRRSEFuVjhFcUY4?=
 =?utf-8?B?bEozSG5rNjMyanAyUDRiUk15ZkVvVXpFMHAxZERDblYwcU1mNlM5bEwvKzZj?=
 =?utf-8?B?MUhWZUJVbEFWQUZlSzhNVGhnNzYvbWJIc3I3eC80YjRwTzA1ZUJWMUNmZzl4?=
 =?utf-8?Q?+O4Vt66/+T0bMkXi/khWP4Sx4?=
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
	1aD4Mt25KvjUJUhNtP45WdKSHYnOB5QytnqcqrA9e1rV1c6hvA5Z9HDL7B85h41ZeMnV4IDdKGtHTOlxNRB3rpjKLdmoNi5w/o5A2Z8iAdu67YlAP0YsaMtdZY4m4ITOPUAEMr2jUCAdoPD03Ewc1k392pLwrxn+eyvucAbz0UYfezq6OdqVW+Ag1Uboi54XlJq+onq/9w1asDx27IQ0c6musQ6aS+GHFTkHTnH0qyZXM8Z29J/tM9kDAc7vwiABd13j4+fS6jDFFjmE2g1w3RF+xs3EovefEL/AOm9WCpu2HSrvMOLWYRbYcIJmsr04e8VKOc50TpHyC3evNyPUOmrgGOIaK8O2RZOJcN60A//ProqDiuVhtnRO+oKe0r4kzhU03PuX/U8dFLZWHLKMnlaF018jZ572b9+8wXdTsWj84dANfQ6q4wGD5TQBN8Ec6I/VUtG3Qs1zXwscngH5EdJDdmINlxemY3RzHVfFNJSgb0bm7p0daWJh8Qo2ybfhIDrdTgUq2R3LtZ23gTinb0Cy4zBi1+FelSYTb2Fg0MlV2b7vZ/qbDMT/vusceH5MOdd1Xq80ouge21fpLyNUJZWk7egisVNd/wCQjWuhbRar3KKVtt/Tl1MJgo790GSH
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d756496-5982-4aab-97a1-08dcc59c6e37
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 06:58:03.4339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ymOtJhZwzNTVviA3aYnXRHaQAjMrf9IEHejQXiJVjEc2hv61OpfLZCc1Tvf/0ytn27stzj/WZtusWklI3bEfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8138

PiANCj4gT24gMjUvMDgvMjQgMTA6NDEsIEF2cmkgQWx0bWFuIHdyb3RlOg0KPiA+IFVsdHJhIENh
cGFjaXR5IFNEIGNhcmRzIChTRFVDKSB3YXMgYWxyZWFkeSBpbnRyb2R1Y2VkIGluIFNENy4wLiAg
VGhvc2UNCj4gPiBjYXJkcyBzdXBwb3J0IGNhcGFjaXR5IGxhcmdlciB0aGFuIDJUQiBhbmQgdXAg
dG8gaW5jbHVkaW5nIDEyOFRCLg0KPiA+IFRodXMsIHRoZSBhZGRyZXNzIHJhbmdlIG9mIHRoZSBj
YXJkIGV4cGFuZHMgYmV5b25kIHRoZSAzMi1iaXQgY29tbWFuZA0KPiA+IGFyZ3VtZW50LiBUbyB0
aGF0IGVuZCwgYSBuZXcgY29tbWFuZCAtIENNRDIyIGlzIGRlZmluZWQsIHRvIGNhcnJ5IHRoZQ0K
PiA+IGV4dHJhIDYtYml0IHVwcGVyIHBhcnQgb2YgdGhlIDM4LWJpdCBibG9jayBhZGRyZXNzIHRo
YXQgZW5hYmxlIGFjY2Vzcw0KPiA+IHRvIDEyOFRCIG1lbW9yeSBzcGFjZS4NCj4gPg0KPiA+IFNE
VUMgY2FwYWNpdHkgaXMgYWdub3N0aWMgdG8gdGhlIGludGVyZmFjZSBtb2RlOiBVSFMtSSBhbmQg
VUhTLUlJIOKAkw0KPiA+IFNhbWUgYXMgU0RYQy4NCj4gPg0KPiA+IFRoZSBzcGVjIGRlZmluZXMg
c2V2ZXJhbCBleHRlbnNpb25zL21vZGlmaWNhdGlvbnMgdG8gdGhlIGN1cnJlbnQgU0RYQw0KPiA+
IGNhcmRzLCB3aGljaCB3ZSBhZGRyZXNzIGluIHBhdGNoZXMgMSAtIDEwLiAgT3RoZXJ3aXNlIHJl
cXVpcmVtZW50cyBhcmUNCj4gPiBvdXQtb2Ytc2NvcGUgb2YgdGhpcyBjaGFuZ2UuICBTcGVjaWZp
Y2FsbHksIENNRFEgKENNRDQ0K0NNRDQ1KSwgYW5kDQo+ID4gRXh0ZW5zaW9uIGZvciBWaWRlbyBT
cGVlZCBDbGFzcyAoQ01EMjApLg0KPiA+DQo+ID4gRmlyc3QgcHVibGljYXRpb24gb2YgU0RVQyB3
YXMgaW4gWzFdLiAgVGhpcyBzZXJpZXMgd2FzIGRldmVsb3BlZCBhbmQNCj4gPiB0ZXN0ZWQgc2Vw
YXJhdGVseSBmcm9tIFsxXSBhbmQgZG9lcyBub3QgYm9ycm93IGZyb20gaXQuDQo+ID4NCj4gPiBb
MV0gaHR0cHM6Ly9sd24ubmV0L0FydGljbGVzLzk4MjU2Ni8NCj4gDQo+IFBlcmhhcHMgYWRkIHN1
cHBvcnQgZm9yIG1tY190ZXN0LCBhbmQgaXQgd291bGQgYmUgYmV0dGVyIGlmIGVuYWJsaW5nIFNE
VUMNCj4gd2FzIHRoZSBsYXN0IHBhdGNoLCBzbyBiaXNlY3RpbmcgZG9lc24ndCBsZWF2ZSBhIGtl
cm5lbCB0aGF0IGhhbGYtc3VwcG9ydHMgU0RVQy4NCkRvbmUuDQoNClRoYW5rcywNCkF2cmkNCg0K
PiANCj4gPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgaW4gdjQ6DQo+ID4gIC0gU3F1YXNoIHBhdGNo
ZXMgMSAmIDIgKFVsZikNCj4gPiAgLSBBbWVuZCBTRF9PQ1JfMlQgdG8gU0RfT0NSX0NDUyBpbiBt
bWNfc2RfZ2V0X2NpZCAoVWxmKQ0KPiA+ICAtIFVzZSBjYXJkIHN0YXRlIGluc3RlYWQgb2YgY2Fw
czIgKFJpY2t5ICYgVWxmKQ0KPiA+ICAtIFN3aXRjaCBwYXRjaGVzIDUgJiA2IChVbGYpDQo+ID4N
Cj4gPiBDaGFuZ2VzIGluIHYzOg0KPiA+ICAtIFNvbWUgbW9yZSBrZXJuZWwgdGVzdCByb2JvdCBm
aXhlcw0KPiA+ICAtIEZpeCBhIHR5cG8gaW4gYSBjb21taXQgbG9nIChSaWNreSBXVSkNCj4gPiAg
LSBGaXggQUNNRDIyIHJldHVybmVkIHZhbHVlDQo+ID4gIC0gQWRkICdUZXN0ZWQtYnknIHRhZyBm
b3IgdGhlIHdob2xlIHNlcmllcyAoUmlja3kgV1UpDQo+ID4NCj4gPiBDaGFuZ2VzIGluIHYyOg0K
PiA+ICAtIEF0dGVuZCBrZXJuZWwgdGVzdCByb2JvdCB3YXJuaW5ncw0KPiA+DQo+ID4gLS0tDQo+
ID4NCj4gPiBBdnJpIEFsdG1hbiAoOSk6DQo+ID4gICBtbWM6IHNkOiBTRFVDIFN1cHBvcnQgUmVj
b2duaXRpb24NCj4gPiAgIG1tYzogc2Q6IEFkZCBFeHRlbnNpb24gbWVtb3J5IGFkZHJlc3NpbmcN
Cj4gPiAgIG1tYzogY29yZTogQWRkIG9wZW4tZW5kZWQgRXh0IG1lbW9yeSBhZGRyZXNzaW5nDQo+
ID4gICBtbWM6IGNvcmU6IEFkZCBjbG9zZS1lbmRlZCBFeHQgbWVtb3J5IGFkZHJlc3NpbmcNCj4g
PiAgIG1tYzogaG9zdDogQWx3YXlzIHVzZSBtYW51YWwtY21kMjMgaW4gU0RVQw0KPiA+ICAgbW1j
OiBob3N0OiBBZGQgY2xvc2UtZW5kZWQgRXh0IG1lbW9yeSBhZGRyZXNzaW5nDQo+ID4gICBtbWM6
IGNvcmU6IEFsbG93IG1tYyBlcmFzZSB0byBjYXJyeSBsYXJnZSBhZGRyZXNzZXMNCj4gPiAgIG1t
YzogY29yZTogQWRkIEV4dCBtZW1vcnkgYWRkcmVzc2luZyBmb3IgZXJhc2UNCj4gPiAgIG1tYzog
Y29yZTogQWRqdXN0IEFDTUQyMiB0byBTRFVDDQo+ID4NCj4gPiAgZHJpdmVycy9tbWMvY29yZS9i
bG9jay5jICB8IDU2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0NCj4gPiAgZHJp
dmVycy9tbWMvY29yZS9idXMuYyAgICB8ICA0ICsrLQ0KPiA+ICBkcml2ZXJzL21tYy9jb3JlL2Nh
cmQuaCAgIHwgIDMgKysNCj4gPiAgZHJpdmVycy9tbWMvY29yZS9jb3JlLmMgICB8IDYzICsrKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0NCj4gLS0NCj4gPiAgZHJpdmVycy9tbWMv
Y29yZS9jb3JlLmggICB8IDE0ICsrKysrKystLQ0KPiA+ICBkcml2ZXJzL21tYy9jb3JlL3F1ZXVl
LmggIHwgIDEgKw0KPiA+ICBkcml2ZXJzL21tYy9jb3JlL3NkLmMgICAgIHwgMzYgKysrKysrKysr
KysrKystLS0tLS0tLQ0KPiA+ICBkcml2ZXJzL21tYy9jb3JlL3NkLmggICAgIHwgIDIgKy0NCj4g
PiAgZHJpdmVycy9tbWMvY29yZS9zZF9vcHMuYyB8IDE2ICsrKysrKysrKysgIGRyaXZlcnMvbW1j
L2NvcmUvc2Rfb3BzLmgNCj4gPiB8ICAxICsNCj4gPiAgZHJpdmVycy9tbWMvY29yZS9zZGlvLmMg
ICB8ICAyICstDQo+ID4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYyAgfCA0MCArKysrKysrKysr
KysrKysrKysrKystLS0tDQo+ID4gaW5jbHVkZS9saW51eC9tbWMvY2FyZC5oICB8ICAyICstICBp
bmNsdWRlL2xpbnV4L21tYy9jb3JlLmggIHwgIDEgKw0KPiA+ICBpbmNsdWRlL2xpbnV4L21tYy9z
ZC5oICAgIHwgIDQgKysrDQo+ID4gIDE1IGZpbGVzIGNoYW5nZWQsIDE5NSBpbnNlcnRpb25zKCsp
LCA1MCBkZWxldGlvbnMoLSkNCj4gPg0KDQo=
