Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DD837F32D;
	Fri, 21 Aug 2026 10:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787309778; cv=fail; b=s1UvHn4MAhLyEFRqX+aJ6xucqP9NS0qX9WUNclD5AUIr8yzoexfSk1UbIQheDIa4LkXCW63b5hzn1ZfP4g8MVd4R0RHGXnqykn8NRO5mzD5CuXwZpPdMFvxbJZ5lL1YVCL9wajwx3FukIY/3TsNow7lqL4zjXZ7ttiKu1kAnoxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787309778; c=relaxed/simple;
	bh=UjniWGViU4XkCcy7NaLEp34I7qhk19rBxodTwLDQlbk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lHLXuUoOau7mOu0d7BbyK2l+C/H5FYnOZshTRYrNlQrDZB/T3p/fvUyNnnsoIYn/MbZxVmwteJS/yCgerxT0QCxZRFGvl6V7/u8euDFK1MD/s+rozNy6ZYEZ8PiHVaCXQaBF0AEA9CEmhbm5dSUCvpASesMsUTBTr5Gu9Ci+Xpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Pk6r4CqQ; arc=fail smtp.client-ip=52.101.85.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pk6r4CqQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJEOSJHt52oM3auQhhCx0s3cBXOIOIxWvTqFbGlr4pV9Z0LRcvrMkBp6I4XpFIe/1DjS+PLISs1NcnrYhMRKprNAZB0qXwV1am9zJulI2LJKees6nPyWeWtA/zGriO+ylYgod2jt4sy+EoxZ0XI2p9rnyiT3dyc460+A/GNuA1FZW8tfdNhJHzEbJVn9j6w/a68VqixNGnJsEoz7gl4HLqw2OCl7B6AbYupyfjCnKMRQpCFlii/eM1fB4S5Nuj6ZNHYOKDs6S930otxRy1/lrxc52OuK7auInZ77ChiWwyMqo1zBvGTNSBLCRZg/tQ58L7ug66o1zJ8EdZxNEph+kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0KP1CVviwJmQQN3FEHfy11YDTSlCdnZqE0N40hpbfA=;
 b=uiZhdD4bNIVvlhV0YXjBtzLE0GGQ+aU9jfzlNSDUmagSHAlnUsSeb4CN+QZe9S/G2O2YvZ/DMbHu4wENi6QisZyslbRbgjZCRut15pon7I9K2L6/vnOkDfEYURrXMjBH7kuu6mbjhOkW2I4WWW+xu7ZUGYu9PyKaKBw5/cDGJ8T2JBwKiKzm73UNyR2sdAC1YphMt43HgCcqu1sJnKn4FIIS1QdhDDaXN33spkIGfux1UZrpPDJvQ+Ek+zG1F1CqBg8+JFffOdIupaXOXHqUUmIc4c17edDycAzAvVRMVmVYaZUCqBiVMhYwM0h4rmQ9k1VNLrLso+q6xlXqA8rLMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0KP1CVviwJmQQN3FEHfy11YDTSlCdnZqE0N40hpbfA=;
 b=Pk6r4CqQufJO+JciZi38Fd3QgqKrFVha0M0p/foU3KGCu17XxaUlO8lyef4wN347zhmoL51qzb/A0iF1cpOWiXpWI3WA27Lj2cr2iTlJjl2klTjcfmN/Emdl1++ikGb4t6YLRQmpNvbtJ2d6Az/djLSgWJPuHT41c2ecWzO/XqY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CY1PR12MB9557.namprd12.prod.outlook.com (2603:10b6:930:fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 10:56:14 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 10:56:14 +0000
Message-ID: <5d066598-7aff-4912-89c6-23761fdccc7b@amd.com>
Date: Fri, 21 Aug 2026 12:56:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mmc: Make sure clk_init_data is fully initialized
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Ulf Hansson <ulfh@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
References: <cover.1787240090.git.geert+renesas@glider.be>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <cover.1787240090.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::11) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CY1PR12MB9557:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb210b5-889b-4fb9-ba8a-08deff72d1d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/mUGVvVnwxc1Nzew9B19ilobS7c+hQVwJHCGOAXktuC5SibE20DFjn1G57a0PxSo8TaIQtLpAdMij9gTfpXIHxhF3EtuY0vJnbSSOp/v8rsIFNVaA5v2dh8u33s4CjtbfpILjFYRyn18wDCtrGI+xJHyb6M+wDQVJKMWQw/el9OjPnoDP/vtejKpZoPjnUtBrHgyTtc7WO/k0m60kKmsVkV1A7/wmymSqc1i1tRgE7cMPTIA2HRitnuT8jsmQjcwgaSVmXM9Qs3sP9abtFZ7iPflJQmzztsTgl8JxQoLRIliNHrO+VNeO7imA4GlPmAgzj5FJy+imijW2tWXYaoW4EUjuCTbO3DX1u5uyAOEqG05O3ZX6LWqozV4D6h07N5wGAtVfR4SzsKCtgrifBuFGJscy9YZYuElBzPHY8+zJksYtGt5C2Ugl8SoHO9LGeaoQg5IIvtmUWp4eezo0Cez2fgQwVkyfv61rtGvTzdd87KhxUHEMCdngOfVNczUOdWbb8UOY3ADyd0OEmGlGsWQ5FrmvRilS/dvu+gYe/I3j7Q8UIicfqe6/Jw6vmvbkQgzZZxQXlSaR3WsUkAfoA0His+nD4lbRklbIcHL09EAsdhDDZWsql1vJ64PCD3hvsRb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUhXeERFQ1NEeVJSUjBUbDNTK2Q4Ym9XbTNtQnkxSUx6M1cyT1hZeTBaaU9a?=
 =?utf-8?B?S1Qrb29iMFd6WmtSVENNYTA0NFJIamxBaGlJODhNcTdCN2NLM0tMeGw1NndV?=
 =?utf-8?B?cFoyWFYxM0N1cHYzSFVkb0xGZU04anJFK1BKZTdzTk9Pb3BOQ3V2dEg1UnJH?=
 =?utf-8?B?UHBkTjJ0UktVNE1Veit0MEJvbG1id0R6TXhNeTBxSWJXU0txVXVFT0orOWQ0?=
 =?utf-8?B?cEkrVlFKT0lIaUpLdllYSUhGV0M0dW9oLzZWZ2hGbzZXN1FWTnlUYUtZY1Zo?=
 =?utf-8?B?d2Ewa0FYcWtHeEovUG0xRmxIdG9UeGtSV3N2K2N3Sksyc0xMd0FoVGVkdHhG?=
 =?utf-8?B?VE02cUdQZHJsZUFVSGdQSXJOaE45TW9LdXNab0FENWdVS0tLN0NZWlpuVFcw?=
 =?utf-8?B?WHlUb1JONFBlaFcvdmlleWl4RGV4VW5BVXFtN0Y0TmtzVTZiQnNVOSs0SDhw?=
 =?utf-8?B?UmtGbXRNd0N1VitId2RZSzFMMGk5UWJjWk40VEdxOWpPYmtUWStYTXZpSVJR?=
 =?utf-8?B?bVhNaURycndNZWlzSXNTRmVQZlZqajhBajcycG1DL1BPeGVYT1BPODhoMXRi?=
 =?utf-8?B?L25RZExvWW83aEsxUHVRMzE2ZllYbXlBYVYrUXNhMHRueEZXYVF1QStkNGk4?=
 =?utf-8?B?Nm5tVUVRM0NzelpMemlKSUdnTk43cHI2KysraGI3SkRlbmxOYXBTQ1JpYi96?=
 =?utf-8?B?WTIvWmVaUEJVNTEzajl4UWRhbWg5RnI0U2pSaDRwRDVPVHp2UGw1ZFhxamdt?=
 =?utf-8?B?SVNvak80RkF3Zi9WOTlGbzBqRU53ZFo2WnN5L2g4aWIzZDBtMGwvalhzbkdK?=
 =?utf-8?B?WU9jWmVQMVp1WXZRdFkyQTJtSXpTNGhtMDN0MnF3R0ZqSGhEa1g3a2p4cFZi?=
 =?utf-8?B?TEU4Y3A0Zk9WbEdHOTgxcVRGWGhGamNQM1dldGRVR3dvSDdlUFAxZWJLc3c5?=
 =?utf-8?B?cDE2Lyt1K05qZ1BsMDFxQmJ6dExoL0FNN3FsOStFVjRLVm9TdmxsVXZOWXlI?=
 =?utf-8?B?SjdiSHJQOEEzQ0V3bHVKbmVDWitPZDVYaW9aRGwzMzZsaDk0QWdleHJpMDN0?=
 =?utf-8?B?UWRpNS84cW9ldVpOMWpGV3VsSThUWHRMSkFrMnFBZFY5M0RjVFh4WUczVVJN?=
 =?utf-8?B?bXcvM2l5VVIvSFFRcXhodGNhYVRjSGJNck5kaU44czdYTGFvbVN0dnhjNnhs?=
 =?utf-8?B?alRFbDA4Nk00TVp1V1cyZzlPQTBLS2ZpWnFsdm9hSlZoTWg4UnZnZGNCTHhn?=
 =?utf-8?B?MklyVEFZdFdHSXl3V1FDTlNRTnRlK0VsUnNoUW80aGZ5ak42YVVjcUE5YUxS?=
 =?utf-8?B?T2psMFF6eEdMWVNtaHJpNWoyQXZFeUpaTmtvMnp1ME8vSWM4TkE4VFBTaDN6?=
 =?utf-8?B?c1l1eTRBckRwY0FEVkJqV2UraUl0TkRmd0pMb2FpL3htU3AzUEt2bG9ucWJi?=
 =?utf-8?B?V2tsdHBDd1o2UWJ5eHF3bXRPc0ZNWExpME9DMUl6UEI2N3AxZm95TjNJWEM3?=
 =?utf-8?B?M3d3aHVUOTdJR0N4ZEVScnJHdjBESDUxM0pKZVBqUlY0US8xdzMwa1dacG1I?=
 =?utf-8?B?eXhmeFVWOXE2R1cwRk9qQU9YMGZRNzNtNXlQMjlWdkdhcENnNlJsYUxmc0ZY?=
 =?utf-8?B?ZnJhR21jbkRjOUhuMlZRbUwyekJzcDArWHQvYW82bXMrYmR4RWtjVFN5Nzlm?=
 =?utf-8?B?cENoOHlJdi9ibXBZeStMTkNKbXkyUEhnbGplUVZUUGlOWEVsUTRzVUdzUnEx?=
 =?utf-8?B?MFQ1WTFLNG5QUlNEckJ4dG9Yay9QM29kWldSbUZOa0RDL0o1cHN2Uk5JS3o5?=
 =?utf-8?B?U1FGdzd3UGIwNTVMTDFXVkFISU9tZEdJd1J0bEc1U3NiN0Y2SGxJd1pHcU1D?=
 =?utf-8?B?cWJVZ25ja3FHSEZqM3I1Yjg5QnFFK0dHTnk4eEx4ZGVBZURMc281NnhIenZi?=
 =?utf-8?B?MU1zUk04QXd0SDJ4eGFIckRTajh2cURQWHRiY0RFWmxldkVHdXJCbUlXV29Z?=
 =?utf-8?B?eWVZcFRFckJjOXdGNDY1Y0Vqb24zdlBXZC9yK2R2bWx0bzZXa1AvU2J5RC9P?=
 =?utf-8?B?UGpHR1hvcDEwM3JIdUV1NTBaTVN5R0k4bkJjb1hHWHlpS2haSFJYSEZCZG02?=
 =?utf-8?B?d2lxcXE2KzE1VFpCdDVPVkphVVB4Kzg2ZllhNFYwZk5CZDFzTit4dEpza1kw?=
 =?utf-8?B?R2VFc016L1ZuRU5TZmR1b3NTZHZYSVlaWVZKL2xqaU5EZzdMNkpJVzEyR0V4?=
 =?utf-8?B?MytMNEtTSngwenZlNE9McnFYTVM5M2ZtRE9UU24xQlNTK3RXL09hZ29wRTZI?=
 =?utf-8?B?clVoNGtJZWhDSHVWNktGUDl4eHJibFR3QTNJdzhuQzRJTVZtUFArdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb210b5-889b-4fb9-ba8a-08deff72d1d8
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 10:56:14.6449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1FMy9F9jWiXD9Nt2Av1iL+kJixYrc40G1Yb9VEBROoUJCsTyp2ndYXkQWoEt2liQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9557



On 8/21/26 12:06, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> Hence this series aims to make sure all members are fully initialized,
> to avoid such bugs, and to prevent future breakage when converting
> drivers to a different method for specifying the parents.
> 
> Part One[1] fixed all cases that I identified to be real bugs, in
> response to a crash I saw on BeagleBone Black.
> 
> This series is the MMC subpart of Part Two, which fixes remaining cases
> that are currently harmless.  These are still fragile, and may cause
> future breakage when converting drivers to a different method for
> specifying the parents.
> 
> Thanks for your comments!
> 
> [1] "[PATCH treewide 0/5] clk: Make sure clk_init_data is fully
>       initialized (part 1)"
>      https://lore.kernel.org/cover.1787165329.git.geert+renesas@glider.be
> 
> Geert Uytterhoeven (2):
>    mmc: meson-gx: FIXME: Make sure clk_init_data is fully initialized


It looks like a broken series to me.

Thanks,
Michal


