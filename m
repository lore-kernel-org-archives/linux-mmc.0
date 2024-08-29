Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78AE157A55
	for <linux-mmc@vger.kernel.org>; Thu, 29 Aug 2024 07:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724915427; cv=fail; b=MQMY9wSkez9ogcj6FNu4eWgw7KTh1wjqPx8KfkZHuCqf3hRIEYLIJQYY9tY75BubRZuaLAiAfJAPaupyOxCjYQhJsEhcRyx0O5e2AwmdS4Q8pMgg5PXS3HgY0+N1u0YfMe8aKb3NrkQz4jxixI5olzCVKHCyRnt1ElqbICPxksA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724915427; c=relaxed/simple;
	bh=W8olMNWWQiCJENmMnkLJN4OUe3Hhwex5BigIFyvrOYw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tkIIL3y1IrM2ePXprt1u9Ma0GAuwQ8rRnsu5E+V9euRRxM6fXhoOD9ksRCZx1bVtoGkkxOTKI8uy/uO7/cuTA8/ZkUgQ9nwlaFsZfchbvzymwyfse3aga0loIrpTfi3ichhGlGGDqom/HUs1T5tLjpOcJ6ncgt/Nokk257wlwyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZVcCHcH9; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=mIY64en+; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZVcCHcH9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mIY64en+"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724915425; x=1756451425;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W8olMNWWQiCJENmMnkLJN4OUe3Hhwex5BigIFyvrOYw=;
  b=ZVcCHcH9SlZ+jyqsWjD1sMjVzvxCSolmsrhh2tI+SMMwSkXMDc39GWC7
   ZdjCVoyrhxUz6eZs9SmN5vVEee1v/zq0HBA8r81KGn/Q1GtN70YnJMMyR
   eH2pYUXx228IcVzreR4/CIFdw2MNypmObaBbq2Q43xtvgzy3WVDa8toBH
   gB/Jabovlhl31LC3b62CmjCupJqEE6WMFtYgNrtvhPGswkuwrspv1PmWE
   ekIZBQv8rVr7MKJ/FaPrQuA3ntK8rshYo72g+uonIu4swl68f6MhjW+1A
   3MN/n5+gtFFL2u3VV5Uunzhmyd/ucdQ0BwkNcSD6ZN8GHWS+2qfpmw9zP
   w==;
X-CSE-ConnectionGUID: klxsV4QiTZi4vHBfs5BZSw==
X-CSE-MsgGUID: nJVP1PsRQvyA+nD1gZOmGg==
X-IronPort-AV: E=Sophos;i="6.10,185,1719849600"; 
   d="scan'208";a="25453117"
Received: from mail-eastus2azlp17011029.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([40.93.12.29])
  by ob1.hgst.iphmx.com with ESMTP; 29 Aug 2024 15:10:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=di0d986qYyLMmtvzUhi1VDYLTuOdu27dxuLTfTBvrNmyH4RML+aV3/aodtM0CRtJdvPRJQDP/t4EiMo4eV7VExm7lMHdbDEZ8dUlju1/5kgMR822393lw8V4lvrE1L4mA7hpKPeBpwxkuiQj8kYq2orKGQfXE/0BflCftxII2Y6CogM3EiwTOwijM4Eea2ysgA4IPpTtAb6dX6Y7zW1+y3oIB30nbP4Y6hKMSprUsUtZz+wk0UZ5qmefs/zChK0X9XW+uQxNc8NcPWONk8WsOYI9QXC3xjvHdcq+jFPMFAtebZtQnZcSr4cgKMAlysvdDtlHeq2TvHNa/92OpDT5ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8olMNWWQiCJENmMnkLJN4OUe3Hhwex5BigIFyvrOYw=;
 b=DZzjRByrF5ks1m7DSrPVb9iS8EIVVmQdznAogep1nTko+Ky4Ff0Nv16Ti2oKXwK7DA3yXbaeMEVZgmPT1kY1mukr6mXg0tX6gK9OGJ+lVFKFGrOmuar82zp8TKB4oKWPWZbDuKa7sK0f9T0meNUaB1FtpVrs5OW7iXCPwLMKU6HgutwWO/OJjTQG/EdwSTju6IfxSEh7LnSYRlmUq4l5pfBFKq5FBgkfwbKXbAVmTALxr6vGQz15WJ4dlI3So0jHnny8bvqEb1Wu8vIR2bURX6tdjEFFTstkH+IiMJPoKAWBphO9sB1gDTgXm+yrxPMKbfguFOHpxFCeN4WDivZk4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8olMNWWQiCJENmMnkLJN4OUe3Hhwex5BigIFyvrOYw=;
 b=mIY64en+Vjt75vjX+4ut4G9gEiqr+BejkCpT/JdXis7N1ZFribeC74M7+ZN8okDjJxvJ8sRnCEuBmt3+egd46PpxdWEwvbP5rEY5hECpvDE2CAJLfQXn2h6qR/pUWDQKyZ8Ag+lVt4KbnG0p1CTJXiLNclntuBB3kiw6FBt+qYw=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MW4PR04MB7249.namprd04.prod.outlook.com (2603:10b6:303:78::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.19; Thu, 29 Aug 2024 07:10:16 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 07:10:15 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v4 0/9] Add SDUC Support
Thread-Topic: [PATCH v4 0/9] Add SDUC Support
Thread-Index:
 AQHa9sJ1Fgtj888U6kGa1b/dDuzVu7I5GbsAgAADPMCAAZo3oIAACNUAgAAL2xCAACT3IIAB0j8AgAET1qA=
Date: Thu, 29 Aug 2024 07:10:15 +0000
Message-ID:
 <DM6PR04MB65750684859B0DB12EB9D9AFFC962@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240825074141.3171549-1-avri.altman@wdc.com>
 <3d7a9953-afed-4b45-a209-b797634e6bd8@intel.com>
 <DM6PR04MB65756CEE03C15524EF646C3BFC8B2@DM6PR04MB6575.namprd04.prod.outlook.com>
 <DM6PR04MB65751048E9B35CFED478F180FC942@DM6PR04MB6575.namprd04.prod.outlook.com>
 <cb9c225c-b5c2-43ba-a6d5-843dc2790fd4@intel.com>
 <DM6PR04MB657568FC857DA6877F2BA7FFFC942@DM6PR04MB6575.namprd04.prod.outlook.com>
 <DM6PR04MB65752FFC3CB355F2FC704C16FC942@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAPDyKFpSA_Esoh=2_j28JMotxqhOrRxnzj3xfZg9BoWUd=B72A@mail.gmail.com>
In-Reply-To:
 <CAPDyKFpSA_Esoh=2_j28JMotxqhOrRxnzj3xfZg9BoWUd=B72A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|MW4PR04MB7249:EE_
x-ms-office365-filtering-correlation-id: 47b01f25-6124-4c63-7868-08dcc7f9a1b8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aEZZVE1IRCt1K2xnTkJSWG02TXVQUUJ1c21oVFNyTW9PMjM2T3hRYkdjYUVq?=
 =?utf-8?B?UmM2YklOemFNRWRUbFg4SkpxMzNXMlFIazJTWExzZDFhL05qOWlRRHl2aEx1?=
 =?utf-8?B?SWJacm9wMURvM2pLWkRKb1BkMG84VmJySnN6TitnUXF5dUZKYmEvZzBNYkZY?=
 =?utf-8?B?c29mb0NUN0lDRjBiWCtzdlVPWVhCVzM5aFV3VExvcXFXTUEzdzMwYlAwTFBZ?=
 =?utf-8?B?cjljZWk1clZIZFRYOS9rUmF6KzhMeEhMdEU1WDZ3STR1MFU1cnpveThReGZS?=
 =?utf-8?B?Mm5SU0owenZkVjNpdEtUcTRRMEVOVmYrUm9xVXNRd2Q1Y3pCQTZjM05BbFNy?=
 =?utf-8?B?N3Jkc3NyMkkrV013S3ZyZHBRWHVVYnZkS1NTNDhqc1BvcDBVQjIrMElGYnR2?=
 =?utf-8?B?ZWQvVW1OTDJxb1ZaZGplSHhOZ3lMY3B6ZG44TzE5MWNoR3o0eElOYmJqaGhB?=
 =?utf-8?B?WTVOODRTVkVyUmN3MERDMW1OUzVNMStxSXJjQzh4bzBYbURZSHZjMVJ2MHlO?=
 =?utf-8?B?bUlpbHhjZkVXYkZEWVYzMGx5aUhmV05mMGFsaDluOFhFTjZ6VE9QWmNuSVc5?=
 =?utf-8?B?dUNBSHZWMzN6dXlQeUNoUmUvbG8rU0UvUGVBT04vSE9SdmVJY2Z0RUt0OUd1?=
 =?utf-8?B?czhrWVprQUhoTXBVZm9OWVd5R2tzVVo1MlgrOGhsckhJcDl2eXltNkd4N1Vr?=
 =?utf-8?B?TGdIaUFXYmJWb0NsYlRkek9hWGJBVlRMSTVJWklvbmFNVXZvL1FKTlFMQjlL?=
 =?utf-8?B?ZWNGdmpBZmpCck1vazNRRTVhNklmcUIrWnRNQ2J2OERFV21waWg1d0sxUGVv?=
 =?utf-8?B?Q3ZFVStJWU9RMk5MTlZLYjlETjNoaUY0VmZ0NGVxVS9RV0pZY1FDUTFtbzBB?=
 =?utf-8?B?bXFpdEhEbVF4dzMvTE53MndnZi9xZGlPTk9ZR3ZBemNHWGk5bm9XcVFaT0JH?=
 =?utf-8?B?N2xjUmF5ekR5OUlIYzlpL0dJQ29SOWdRL3JlQjV0Y0VFcWM3K3ZVNG11SXJu?=
 =?utf-8?B?ZW1McVUzdXg4NVhNSVJFNzhqbzU0WDB2Ymw1d2VBbFRzMTU5L1NvaHZRTDVt?=
 =?utf-8?B?c0xCc000NjVldWoyMnVXcmNvNktzK1ZwT2l3SlZySU1ENEprbHF2dDlrNGdi?=
 =?utf-8?B?anEvN1lSNkpFdzR2ODBkOVZQQktQZVhadlJDcW4yR1ByT0VYd29WZHRPUlYw?=
 =?utf-8?B?WnJuZEtEN1FnaWtVMjBrdFh3S09sV3R1VzNSdWN6SnN6Qnl1WmZkWGpaYXV2?=
 =?utf-8?B?Y2RPWjZnMEFiSGVEZGZxNTlFV1dpdUJwNVlzSE1FNGtpb0IvOU5XdmlvSUls?=
 =?utf-8?B?RUttZHE5NEM1MUVqVmZ0bnFiSCt3bUN1OTVvcG8vQ3FleFVlYjJZVWdOZk5o?=
 =?utf-8?B?NTZ5cmpFL00xRGVIbTJDWXVkSWdQaW8rLzZHelh0TEZzelR4bDFBaG9DbE02?=
 =?utf-8?B?dHZuZDloSkYyK0NyYTU0Z0Y2ZXY1MlNrc0lMTDl1Z2VlU0dsQlZjK2JhS0FX?=
 =?utf-8?B?RXorREtCblBNVk9McDdEV3c5UzhERDJzTUVjSFF1VjJJeFAyNURQczlIMXJS?=
 =?utf-8?B?ZHJxZTIxRzlORGdhVURncGQzOWxLaWNjNUpmbVJpdkxjdUVwa1BNR2lCcGpX?=
 =?utf-8?B?c3doSkRqT3VMSmJvVTVVejVRYUc1UGNjc0hiUXhjL2l1VU9GazFZeEZsTW5I?=
 =?utf-8?B?b1lraGQ4QlBLUEVZQWVnaDZ0Ymg4eDJiOTJRSmdqWG1qeEE5dnc2aFNLZHFo?=
 =?utf-8?B?L1U4NGRjSXlaMEFSVWxxeS9ISTZDM3luQjRlMGdmaVNrdGUzUlJrWmJzV2lY?=
 =?utf-8?B?ck5Yazh0Z0FYMytqUUxvS1EyVEdLQnhtZC9HQklrajM0amN0L1dZYjN2OVRP?=
 =?utf-8?B?TjdGRHJWRFYwUlhrUE5yVlJEU2MvSGd4dG40bnAwYjQvcGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N21DYU0ya1ZkYjEwejduSkVZdlljSWFNK1l6MVZKM0JkenBaV0VtY0xhaWkr?=
 =?utf-8?B?N21wVm8zM29oUTY3NFVadWlpMzdCWCtkRkxtU2ptczZmS0s4NnNHenZNR0Jx?=
 =?utf-8?B?Sm9tcEZsNTNmL2FvV1l5amRvZ1ErSldQeDU5TnV2UXloR3VEWE95RzFpRW5W?=
 =?utf-8?B?Z3E0UGZtSng5MjBqZXBtSWNnUjlhdFl3WXBScE4vTDZ3RCtndVlIUkNxUHhx?=
 =?utf-8?B?ell3RnhkbHVKa0J6SzZTL2lQc0hKZlpMVitudytNRTVRMzg3eldDOVl2WXFx?=
 =?utf-8?B?aGdkVDJ4ZGYrQmNmemZ3OUxQZTZjV2M2S0pEc0hOYlpvSUZDTFpoaDhabXNl?=
 =?utf-8?B?RXpjQ0hTSnVtdGxUSFhCRG5GdU5ZcFhzZG9Yam92QTczMkJ6M2VGUmpWcG9V?=
 =?utf-8?B?UENnNmlSYVRDZnQ2TWZsRFJ0K3BNWVV5U01nRVBDVGRaRFdDeU5UZGR5MlRy?=
 =?utf-8?B?Q2FzVlNiYWRHdWRiTTR4MEw1ZlVldlRBRjZOdHFUeVdhK2I3U1pXMXFDdCsr?=
 =?utf-8?B?UEF2MUdhTCs0aVdHakQ3NHZlanNlY1pYMnN0OHlkRjhiK1lCSHhYMjVVblk2?=
 =?utf-8?B?OWNyZ0dleTdsVjVOWmRHZ0xuclA3YXovZ0xySFRqQng3UGhCVlQ1NHB2em1K?=
 =?utf-8?B?RVJJYzdsVUZIOEVXaXdQRU4ydjNBei9MTWJqSWFMQUlXRmNmeTFOTDNSV0Q5?=
 =?utf-8?B?ZCtDS1IzZFBKblF5NzFYSFlxL0Q5K044bmthT0N0MFBEUG8zU28yRSt6SFRs?=
 =?utf-8?B?SXR6MWl4OTZ2ZGRKYTk0V0JpTFgrNTgwZHdmK0VFSXhzNHZOdkhmaGM5cDNN?=
 =?utf-8?B?OFNsVFNNR1FZUG10ZjYyWUxXeVN0Ujljd0tRb0ZJaWRRTTduR3g5YXVTa01Y?=
 =?utf-8?B?dWFzcm9IbHgwaWcxQVNXZE9xWVFxdWNKZWQ4Z1lnZzBVQWZ4d0JRMkgrVEJG?=
 =?utf-8?B?VG1DTittSHI1U3N5U2tEVWFBQlZlWTRncWVHVVdXQ0pGYU5LMW92bGFLMkov?=
 =?utf-8?B?REVHS3hTeTVRSThZSmZQaUNxWnEvN0V6NFZGS2xLYnZtSDlNQjdES1VKZExu?=
 =?utf-8?B?QW41SUJPVGx4SzNRQWhJTWpPQmJuSjFONWNMWkN5L0VwMjF1L1BqN1ZYQTZU?=
 =?utf-8?B?R1BtdG13SmZ2WHlYYjZZMGwvRWJxREN4QktTUG9YMVBFZHJrWTNhSHVPanFP?=
 =?utf-8?B?bW5hWFJ2UGdJWEkvdFVGL2VrbmVzV0s0dmYzNGZlZzA0WTFLcUQ2eklTU3o3?=
 =?utf-8?B?eUh5ZnhHQmJEd1pzWFpwdGpJUjhFblNJbW5yRlJyT29ycTN5V2NBdmpobVZ6?=
 =?utf-8?B?ZzJISHQybmFSNGl2WW1wZHo4TnVyVDUyWU0wclFpNWZ3UG5RK1lhQmV6dllR?=
 =?utf-8?B?bThGekdCajNnb1N4MTZ6VlA4L0owYmsxWTk1OU93VFA2TS9FYXN0YS9VOHMz?=
 =?utf-8?B?eGs5YUhxdjREVXI2TXdxTTJCZEJaWXJwTDZobjRQd29IN0xRNnVlZGM0ZlBO?=
 =?utf-8?B?OUJqWjRFb1JoU1NSL0xDaS9uSmFuY3prVjJiTHlNRC9kOVQrdEhqR0V3bFQz?=
 =?utf-8?B?Z1Q5c2F4NXJOalJNWS95M1pncGMrb2dZNmcrQTFPRUpDNk1IWVZwcUpkaCtn?=
 =?utf-8?B?bGdzY0hJcnFJdE5GK09FYUdUeWNQdU9GWkpuVkVlb3I4UnNDTzQzVGNJcEJz?=
 =?utf-8?B?emJkSUNpUWtNMGdzZHNGMTJDb2Z4OUR2QmpUNy9QbEJhNDdCVDNMK3J1dVl5?=
 =?utf-8?B?S1gvZ2J3Z1ZGbjhUL3R3UzBrSnE4YUFWYXYrSUgydC96V25nb3ZjVEtpVTMy?=
 =?utf-8?B?UGRxTys1RzQ3cUlYc2FhN1JMQWZIQVJtL3hSa1Q2QkwxZFVFeG8ycFBkU1Zo?=
 =?utf-8?B?MmgvYm16dmxtOEZuRXpycnBHR3RXUkRNeVpwV29aakdsMk9hbUMwNDI0eTFH?=
 =?utf-8?B?V0xiS3FQTkxPVlN4VEYydFlXemZGSURUWnlONVZINjNQSmsvckkvYmFkakY4?=
 =?utf-8?B?dFRQdFBrQkRaUWxyYTJnd0pVbjBmTTVNNGRuSmQveG1jRll3T2ZZSElkVm5Y?=
 =?utf-8?B?cjV2WDVRUWJZenU1cWFkQlVUUjJ5S3k3cmc2dDY1OVpYZlEyUlduUk9rblNq?=
 =?utf-8?Q?J6tT47PN8yc+Aut8cMu7PsAAm?=
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
	usYwQdJmhLTBPF8TKtb6ub1fKf+HXWtKsX4dwcBhFISCPrbsFgfLGNWR2Ry3g0Wni7WEgE1WYfFufWDg4uFhGG854jscKqqNxeTPgYDfmROF31B2/GY7oHB8PBJuOpG4Z2CYyCX3Y9vYsPxHuT5Xe4bJgQaBNpHCy6BzE9kRl9S6KZ3szrmd5COsn36TZ3zLe8ks6J1zmfiESdRdr8M5xODYBlYHF8eYpCJX+GRaV5Osb3VLk1xNxqxaG0n2yrY3Bz/zjpG6dLzErMYM/EMj+gDSslkzgW/HpKQsPZzJMguygehkz/ADMU806VzuyfV6Aa4y3rVNqCXOEia52S/w8aJQi1T3j/i7NaMqrq6W6xwBPp/BQeLrivcoUWEaiCjTzhWYATYCCtuGTR7nz0mKq7CfF1R3wvP2la7ooiamqBrT0togRMRRcfmzOVKss0m3dbxfGDUvOpdUgD6Xd1Z4yFQBZxbrKMLg6Nb8dvumtkY28No9vlVLTbfTmPgRB+Buj+e8e151TtnWNb6up4Qg8Vew0Nvv7raMeu9qjJtWc36A/1L5Tts5DJKDrO7PvmuEvYYPeF+/BcrXEPL4lmlmH5N+kG4z9PBnX0GJuAQBWqkfurd6Y4eG3Rc2hkf2SI/Z
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b01f25-6124-4c63-7868-08dcc7f9a1b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 07:10:15.3282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YOlaGkZaV7AMCBavIyf4SR07ZoDRbJij9oMIKYrBdmsSXni/nwPTMn8VneksTtN8DlHX0PaI4KdZ9mKa7IyItg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7249

PiA+ID4gPiA+IFdoYXQgdGVzdCBkaWQgeW91IGhhZCBpbiBtaW5kPw0KPiA+ID4gPg0KPiA+ID4g
PiBEb2Vzbid0IGFsbCB0aGUgSS9PIG5lZWQgQ01EMjIgZmlyc3Q/DQo+ID4gU28gSSB0cmllZCB0
byBhZGQgaXQsIGFuZCBpdCBsb29rcyBsaWtlIEknbGwgYmUgbmVlZGluZyAyIC0gMyBwYXRjaGVz
IHRvIGVuYWJsZQ0KPiBtbWNfdGVzdCBmb3Igc2R1Yy4NCj4gPiBIb3cgYWJvdXQgZGlzYWJsZSBp
dCBmb3Igbm93LCBwbGFubmluZyB0byBhbWVsaW9yYXRlIGl0IGluIHRoZSB2ZXJ5IG5lYXIgZnV0
dXJlPw0KPiANCj4gRG9uJ3QgZ2V0IG1lIHdyb25nLCBJIGFtIGZpbmUgYnkgdGhpcyB0b28sIGFz
IEFkcmlhbi4NCj4gDQo+IEhvd2V2ZXIsIHRoZSBwdXJwb3NlIG9mIGFkZGluZyBzdXBwb3J0IGZv
ciBTRFVDIHRvIG1tY190ZXN0IHdvdWxkIGFsc28gYmUgdG8NCj4gaGVscCB1cyB0ZXN0IHdoaWxl
IGRldmVsb3BpbmcgdGhlIG5ldyBjb2RlIHRvby4NClRoYW5rcy4gIEl0cyBvbiBteSB2ZXJ5IG5l
eHQgdG8tZG8gbGlzdC4NClJpZ2h0IGFmdGVyIHByb3Blcmx5IGRvY3VtZW50aW5nIG1tY190ZXN0
Lg0KDQpUaGFua3MsDQpBdnJpDQoNCj4gDQo+IFsuLi5dDQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4g
VWZmZQ0K
