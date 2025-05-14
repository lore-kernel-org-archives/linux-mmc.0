Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F2822257E;
	Wed, 14 May 2025 09:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747213867; cv=fail; b=g1W/XWTfJZrvI2Ab5Zca5YLjUofgRWzioZLKIGBFuTx5VBk6SUW8w7Nqv+7fR6J5tZ9CGio+EVzSknGlixK88i7tOLSYygweeWKsTzAgitEoJCGYP5oQQuk2CqfiO2qbwP1Z+9iVFJCPC+HeARFWjgld9i3N8fSc/YlOMgqBIts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747213867; c=relaxed/simple;
	bh=fsaL6POyIa5YvKtMnbQIpugP1pZEhYqDmWAk7BTfHj8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tvGAbDxGpW7wU5xXDU+CLtGK2a84B2VzLOWsOjuun44pkXNlqx2xI2SrQvY0z1ymmQQr31Ytkften9doS4U6w0lcOGcI8kCzqYJoK1ulyT/TWSGIrd/xmng3wLAuxqAc3ZkuR2+L6b2mwI5rq844hMxeWI9A+obNNVSNxh82OI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cs+8TQRi; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cs+8TQRi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747213862; x=1778749862;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fsaL6POyIa5YvKtMnbQIpugP1pZEhYqDmWAk7BTfHj8=;
  b=Cs+8TQRi6BG6oYWl8sxV/lbzK6cL5rD3gLf5zlThEMIrEFD8I8bIAOen
   CzNkBATHK2zCpVlhHgbSAKlvECmZNVedCW+XCOIgFPwj1mZu7BIXH/o3/
   vQRu+Wnxws/gLS4DjKp49/fcFKreup6JrUgn7dVmnf/Cbbj/3m1lvbKNx
   z58OB9sh9PCL0lof2+VepKhEU2So5dA/fGTGvj1E9LMKqIGHqT1UeNdXu
   40NWX7wYsqtYg8igLzcyvJcONch0eJzqdJd8vW8GGHH8v+ueluoRRImFV
   4SohxHx2REpUzVRuqUggHiSEL4r1LwSrqq2JohcckpcpjRgLvxUxkT9MD
   Q==;
X-CSE-ConnectionGUID: YkVyB/YVRpaQMmFBe1LGHg==
X-CSE-MsgGUID: hl58raCBT4C8PSouyNVgeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="59328845"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="59328845"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 02:11:01 -0700
X-CSE-ConnectionGUID: MTRxhxsKRreV63NbzGRCPA==
X-CSE-MsgGUID: J6bxYaMMSrusV/hQovv7mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="138904216"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 02:11:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 14 May 2025 02:11:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 14 May 2025 02:11:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 14 May 2025 02:11:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFiQ8Q2PPwLSDywEGTLzA6XRcfIYEHpgNHoe0TBXLCRzQRHi2R4BLzrumtuw+AF6fk9g1//fDPeR/Hm07WvCt6Q2Tgg96GUdUyyuWlqeLfeBAihmR6NZWCfrV8yDx9cw+R10M7LVd0byqhcI5yraPJN82qgtuihj04BIiuFcrg20m/WY+kunMlAKC7yHE8HNufuoX0otANVePYiPYSUuLV31HRYLyi4OFGH/bssWMQK/9kALCbNhum2JPIHafPZG6a971L94ZMYRg1fR84Ds7kiWStBNxrDWaRFkpZw+7iHqKB1X1ovWxlaEPdz3BarNPsvNf/aoEcmRlPs9rYTWtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R86VC3wCip76NUUKPmyWP7LlQOvAg6Dqza6JbUUtk9s=;
 b=hq5oYz7sZ12K9c3AsgL7UIpwXlRZ3Uw8PIqd2HnZI4b4ZUAyZCKN416lVGWiqBxtPKnekyjzbzSqYUi1dhL9iLtCf63Q2yinpDP3bUILzOsNUSU69IVeZ7AXiNKd0wBMaW5Cn49XHRefpwEvQQCSNwkuzufiMC6/ecLBpJtappzlFwg5tWfxTf/VfCE+RZtpFICXFSrOrh6ce3P55rqR0o9nAc2/Q9vSEcya+m8oTHQYNCzkr0Kj3GCl5iTg/3puZilIknPT+FTqnrsIfXKWCvS4CS2uNfhdF/mkWM+GeTBZTn2fzidzPVpeAnKPSwUGCgAMMay0cn6+a1lpDC1m3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8)
 by SJ0PR11MB5103.namprd11.prod.outlook.com (2603:10b6:a03:2d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 09:10:17 +0000
Received: from PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301]) by PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301%2]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 09:10:17 +0000
Message-ID: <d3222aeb-4920-41a2-a8d7-2551115ab776@intel.com>
Date: Wed, 14 May 2025 12:10:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] mmc: sdhci_am654: Add SDHCI_QUIRK2_SUPPRESS_V1P8_ENA
 quirk to am62 compatible
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: Josua Mayer <josua@solid-run.com>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Francesco Dolcini
	<francesco@dolcini.it>, Hiago De Franco <hiagofranco@gmail.com>, Moteen Shah
	<m-shah@ti.com>
References: <20250514002513.1179186-1-jm@ti.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250514002513.1179186-1-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0058.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::12) To PH7PR11MB6054.namprd11.prod.outlook.com
 (2603:10b6:510:1d2::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6054:EE_|SJ0PR11MB5103:EE_
X-MS-Office365-Filtering-Correlation-Id: 4283fafa-56df-4b8f-679e-08dd92c724b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDFhaU5zek9lSnVxREZubTQxS3BXSDM0NHB1QUxyTFovT2NUdUUzUVpVU3du?=
 =?utf-8?B?QWgzbENlbW5EOEhSKzQ4Y3FWQUFsMkVqWGRPUkhHTmYwMUFlQy9aeHNya3Ux?=
 =?utf-8?B?YUVWRGtoU1BJbEZQUXpKLzJYaHM2YzNGWnE4SG41Vm5pcWdQMmd2YVptOTRY?=
 =?utf-8?B?NmVkeXo1N0N6VGVkQjdoN2Zsejh2NjhNU3FtMTFQVjhNMGttMGoyTjBqZlVz?=
 =?utf-8?B?ZldONFJZa1FpSFJNNnUrbW5LRG42dlJoRjlxRThjK1h5ZVFIT0IvRVc0SFpM?=
 =?utf-8?B?bXRaY3QvQW5ZWERDMXJOZ0gxL2kvK1dpTVpBeUdMS0t0TmxqdG90bks5M3RB?=
 =?utf-8?B?d0FMaHJDb0pUelMzTnpzSFhrOE9xNk1NSjFCQkRMRXNMY1pHL3l1VEJ3UWEr?=
 =?utf-8?B?eUpoSW1GYjZiamM4NlpXeCtIYVlpelRzSFZBd2VMbTFKWTkrR1NicEprTW9s?=
 =?utf-8?B?NmpTeThpRVlMdkpTdEdiTjBsdGl5QUFMMG14VW56ajJoemtILzVpclp4R1JI?=
 =?utf-8?B?cHpmdnBiOWp6UWtKYk1USkdLR2YySkxRTGVXVHViZ2EzRk42b2E3YWJVS1M5?=
 =?utf-8?B?U05rbjNXUGJhdktIYmxxdmY1UXpCZ3VNMFN6a0x4emo0Rm5ZUks4aCtRbXc2?=
 =?utf-8?B?MFdUN1NaQ1k2VUJyQ0dpWjVHSEtmMFh6V0YydjhKd1ppbmlEeFIyUWt5UDJp?=
 =?utf-8?B?K1NqdGVjTVRiMldKcWFDZ1BXbTlFK3VGVVBkTzJaQlllelVLOURjUTNsYTU3?=
 =?utf-8?B?aiswZUJjTlpHTytRejNHbzlubW45Y1dQZVRpTFYzclZEVVhMUkRVSVFYd0VE?=
 =?utf-8?B?cDRpNWIySmhaYllCSHJPeUhzdlRqSFdnWllCdFhucUNsVjY4ZTJZMUFEcHFR?=
 =?utf-8?B?eTk0TmVCTlk1Z2NOdzFEekdCdjJlQUpDOU1NdVBwRCtuQ2diTXJUc3ZiTTBm?=
 =?utf-8?B?aVdiaHV0WENiY3gxa3RBSGUzbU9qMnpWUDR1U1pXcmhLdjBzQmpQK0wzSHJ4?=
 =?utf-8?B?bGRUY2lISE41WFByUmJUeFlVc1h4eEgvLzBzRTdCakdxNGtFV3J4V1MybGN2?=
 =?utf-8?B?dkpnY3dXaEd4UlJmREcwbGZuK0diRFA4VzE2RDhoZXFJWW5IVWRhdTlIWGoy?=
 =?utf-8?B?NjI3REl6NGovYWpkbmFLeWFuNGRScTBVSlJjVUU1bHFsRitJTkJhNGhqcloz?=
 =?utf-8?B?OVlrR3NBRlp6SHFUeVJsSUQ4TDBwNndaTGh2QmhZSUMvRkhTZUxIM05nTmRh?=
 =?utf-8?B?cWlxMlVldXBKa2crdFl4TFR2VVp5N3pZQ0hwUEc0VS9zWVZvaTVCNzY5SFB2?=
 =?utf-8?B?eHVsb2pET1ZoY0xKd2NVOFk0NCtQVEZhcTZZUjd1d3ZjaDZ1N2E5ck5BU1o0?=
 =?utf-8?B?M3ROWkFVSTArM0xuODVLRkl2ZktmNTk0Tm9JVElRQ0pFeEFRV3hhbGd1MW1y?=
 =?utf-8?B?ZVgzS1pDQUVIemVxS2pnaU14M29uWmo2LytpWU8zQVZnRWFmbXgxZHJublUw?=
 =?utf-8?B?REdNYjZ6VURPYjA4ZytITTI2aEtQeEdlaWFuT1lTWDl1b2lWKzd4ckxYWlIy?=
 =?utf-8?B?czN3VlhvV2ZLbkhLNGpxZHBYL1ZhSEptTzRYc3VhT1c3aCsxUU9SY0E3dmVi?=
 =?utf-8?B?bnBhKzArV1kxZ0NqTThrTEQ1LzJuc0xPUGNDeHYrRkczUmxpT09nZW80a3Nt?=
 =?utf-8?B?UmFpNitIYkY3by9WZ3kvcDZiNEh2SndQN0J0dDBTK0hGOXJrL2NEQy9SMWVF?=
 =?utf-8?B?SXg4TzJ0UnhNaW12UGFieFR6bE83ZmEveklHSlJ3d2d2Q3BNcTNvUGVTdWo1?=
 =?utf-8?B?S0Y1OTZvc3dHbzh6Nzc4OW83dG9HZitEK2ttd2JIaWxJaHB5NTVHNkx5Wlcr?=
 =?utf-8?B?d0tMRkxWaituQXhjWmtobGVMcnBVeVkrVjVKcnhCTmxPS2x3eDZLV0ozNHJW?=
 =?utf-8?Q?yPrP9TJ7hag=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6054.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1JLYXZWU3lQWmNGazBlV3BYOEtyWU4wUkhFNVIySDdtNkF3RERGTWY5YUFV?=
 =?utf-8?B?bE5lTDNzcStsZDIxWk9wWXBncVJBT3dGaGFialJYa0pTeW5SQUl5c2VFOW80?=
 =?utf-8?B?R3c5RjJzVjhTMmtZYk5EajhrRVhZUGZXMWdraFByTTFaTUdQQTBkMXBiQVln?=
 =?utf-8?B?MTV0S3pPMnVqTGV4a0VHNVFJWTlWb3VrdUhYU0c0ZjZxN2ZlTkEwbWFkUG5J?=
 =?utf-8?B?cFM4bC84eHJqa0RLSnB4a1lnbFhQNUN3c2RwSG56OEh5VzZvYzRoUmp2QUd3?=
 =?utf-8?B?UVJENjJyaEM1Q0w3emk2eUhVc0tMb1hUOEgzclNqWUFkUTdjQUl3UkttZU1W?=
 =?utf-8?B?eTJ1WTlnVmNIQVRBZDlzb0ZtS1hDdUJvOFpFNE1sYW9zcTNJbmhScHFSbjhU?=
 =?utf-8?B?Wi9xUVJkZ0ZnbTlUc3d4WmZhalRyYldpS05hQmM1VkFFQUVrUGt2WUExRGcv?=
 =?utf-8?B?aksydExTT3M3QkthNGVVSGJ2L095MTFiTlcxZ3UreXpUV0xyZjlKckhCRlR0?=
 =?utf-8?B?NXBORERmZU1iNGpFOEJ6OVJUYnM1dXFWMGhkOHJpOVpCYUV3ZjlGbjBnUU5N?=
 =?utf-8?B?Y0lmS09UVWNuTjF2SzN3RzlnMkRncEU2amp2TWpYQXR2K3VqVEdCUXcxZUdM?=
 =?utf-8?B?S2Y4akZPaUFiZEJLdkxtcUxVNENTRFltY0lFWGo2QnAyL3NPSXJLTW5vUEFX?=
 =?utf-8?B?Ty9WM3Ewd3RyeisrZmh2UHplTTkrSXIzeWYrQVV2QTNRcXRVSDd1UWZIL2Zs?=
 =?utf-8?B?UkE5ZU40SzRPRUtwRDhaQnI1U0JaY2R1Uk5Lc0d4L1IvaTJ5UEo2bXdRVzVO?=
 =?utf-8?B?MGJkYWp5aXZqWlUwcUxMK0pxU0ZGVy92SmFpUEEvNmdkMTdGcnBHenJJYm5L?=
 =?utf-8?B?NnlGV1JYNUhmSkZ3L2VPRTM4MnFiZ0tXSVNxbGRJdk9ZclpVRlB6blJKK2Zn?=
 =?utf-8?B?V1F2VzFpNGpXOFdzVlF2TWVVTlBUSWxiZ0dSZGIrZHZmNXplMTNkdHJYWkxi?=
 =?utf-8?B?STNwaUNRZDN5aGJpcVZmdEZkakRwMDVqc0ZCWDJmbDlHdldwQWdLRm1yY0h0?=
 =?utf-8?B?QmhSd1FlY2RFenRYMndjVWZlcGlrR2ZaOG44YmcwY2YxSXVOaU1XcFpqQkFo?=
 =?utf-8?B?MUNPU3dMWXpCWit5N2ZzYUVlSXp4cFVYbGhyM3JFa0xzQ2VvMEVHZFphNC95?=
 =?utf-8?B?ME94SFFQRjNOZmhxK1Z5UloydTV1OEpQSzBBVTA1NDFSN1ZyRERKWm4zcnlz?=
 =?utf-8?B?MU1ocFBEUURUamovWi9iQVY0MExuUmVoSzBUYkdqS093MnMvb2gyM2dObGZJ?=
 =?utf-8?B?ekZkb252MGpXUEpjekZ1Q3NqdkhvRi8zdFZXSFdRTzZLN0RYSEpDTmNteVFK?=
 =?utf-8?B?WEN1WXh0Z1Jla25SRWVzNmt3YStEMnl2cTRBdXZhNWlVcnVueDVXU3gvRzRp?=
 =?utf-8?B?RGRvQW1qQ3Z5WExGQVcyb0Uvdit0dGpSdmp1RmRmWThIcDM0SXVQV1g0c3Rw?=
 =?utf-8?B?Lyt4L2tiaFVJdWhLak05amRxTDJ2Ym16V0prcmtjZ1BBWmt2WWpZcWd5UmZp?=
 =?utf-8?B?RzVNTkkreVdUeXd1d0l5ZzV5ZFJuS1loL25vdVF6RHp2V0dCaEkxeHFRWC81?=
 =?utf-8?B?ZEVLRFRVVDBCUjkrMWswY3laOFVleHdOYkpGeXRLRjBtUTkwcVdwYjcyMTZH?=
 =?utf-8?B?N215b3kvaUJlaFRPczVXd292TzVKT1pHRU5DTHJoNVYwVDlwZnVaTTVrdE1G?=
 =?utf-8?B?SEdlTlR2bzB4Ymx5WnRxWlJ1KzUvdUpvb3dneXNUSnZsWmk1MzhXcU0zL2R2?=
 =?utf-8?B?UE9SS1A2Q1BWODZkNHYxNzZaekp5SHNMdXdKN1ZhZHE0bjJlYmkwa2pqSkZ5?=
 =?utf-8?B?M2pDMzBISUF6MnpNRlpvRFYyTEpCbzBwdEpXQnZEdDgzUnF6d1AyN0N1c2hs?=
 =?utf-8?B?QzQ0ODlBc2EveXVWZCtHa3pNMXlXTTZkV1hIbkdIL3BjaVVhcFV0bW5YaXlS?=
 =?utf-8?B?Z1N4cWxjbWZSTkhUUCtmV2ZZeDQ4UmNSTm1xZUhSWktBS2QvS0ZqTkxBT3pl?=
 =?utf-8?B?TU9UbUlTRzFwQ2pmOCtEQVdLNmFReFNQVllhdkpRK2dINUhPc0QxeUJPYVQ4?=
 =?utf-8?B?aGlDZ3R4TXV6ZER4U0hGajZZSEZtdDJ5Y2M0Y0hjSUE1MUNzdVJ1NjE5d2pQ?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4283fafa-56df-4b8f-679e-08dd92c724b0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6054.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 09:10:17.1066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SAaSSJgovlANOcI8z3C37nvbZXXzfP7e6ifoZdvK2SEg84635ZqSuYD31D5fqG0DNA5+6Q92s7LVDo+RaPFlCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5103
X-OriginatorOrg: intel.com

On 14/05/2025 03:25, Judith Mendez wrote:
> Add a new struct for platform data for the ti,am62-sdhci compatible to
> apply additional quirks, namely "SDHCI_QUIRK2_SUPPRESS_V1P8_ENA", to
> host controllers with am62 compatible.

Could add:

Note, the fix was originally introduced by commit 941a7abd4666
("mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch") but was
found to be applied too broadly and had to be reverted.

> 
> This fixes MMC init failures seen across am62x boards.
> 
> Fixes: ac5a41b472b4 ("Revert "mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch"")
> Fixes: 941a7abd4666 ("mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch")
> Cc: stable@vger.kernel.org
> Suggested-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Judith Mendez <jm@ti.com>

Minor cosmetic comments, otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes since v4:
> - Drop support for quirk in sdhci.c
> - Add quirk member to driver data struct that shall be per compatible quirks
> 
> Tested on am62x SK, am64x EVM and am64x SK. Tested-bys are welcome
> 
> Link to v4:
> https://lore.kernel.org/linux-mmc/20250424180036.1541568-1-jm@ti.com/
> Link to v3 RESEND:
> https://lore.kernel.org/linux-mmc/8678d284-db12-451a-b789-2b75f9932f9f@ti.com
> Link to v2:
> https://lore.kernel.org/linux-mmc/20250417182652.3521104-1-jm@ti.com/
> Link to v1:
> https://lore.kernel.org/linux-mmc/20250407222702.2199047-1-jm@ti.com/
> ---
>  drivers/mmc/host/sdhci_am654.c | 41 +++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index f75c31815ab0..c2bea228a67a 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -155,6 +155,7 @@ struct sdhci_am654_data {
>  	u32 tuning_loop;
>  
>  #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
> +#define SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA BIT(1)
>  };
>  
>  struct window {
> @@ -166,6 +167,7 @@ struct window {
>  struct sdhci_am654_driver_data {
>  	const struct sdhci_pltfm_data *pdata;
>  	u32 flags;
> +	u32 quirks;
>  #define IOMUX_PRESENT	(1 << 0)
>  #define FREQSEL_2_BIT	(1 << 1)
>  #define STRBSEL_4_BIT	(1 << 2)
> @@ -356,6 +358,29 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
>  	sdhci_set_clock(host, clock);
>  }
>  
> +static int sdhci_am654_start_signal_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> +	int ret;
> +
> +	if ((sdhci_am654->quirks & SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA) &&
> +	    ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
> +		if (!IS_ERR(mmc->supply.vqmmc)) {
> +			ret = mmc_regulator_set_vqmmc(mmc, ios);
> +			if (ret < 0) {
> +				pr_err("%s: Switching to 1.8V signalling voltage failed,\n",
> +				       mmc_hostname(mmc));
> +				return -EIO;
> +			}
> +		}
> +		return 0;
> +	}
> +
> +	return sdhci_start_signal_voltage_switch(mmc, ios);
> +}
> +
>  static u8 sdhci_am654_write_power_on(struct sdhci_host *host, u8 val, int reg)
>  {
>  	writeb(val, host->ioaddr + reg);
> @@ -650,6 +675,18 @@ static const struct sdhci_am654_driver_data sdhci_j721e_4bit_drvdata = {
>  	.flags = IOMUX_PRESENT,
>  };
>  
> +static const struct sdhci_pltfm_data sdhci_am62_4bit_pdata = {
> +	.ops = &sdhci_j721e_4bit_ops,
> +	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +};

sdhci_am62_4bit_pdata is the same as sdhci_j721e_4bit_pdata

> +
> +static const struct sdhci_am654_driver_data sdhci_am62_4bit_drvdata = {
> +	.pdata = &sdhci_am62_4bit_pdata,
> +	.flags = IOMUX_PRESENT,
> +	.quirks = SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA,
> +};
> +
>  static const struct soc_device_attribute sdhci_am654_devices[] = {
>  	{ .family = "AM65X",
>  	  .revision = "SR1.0",
> @@ -872,7 +909,7 @@ static const struct of_device_id sdhci_am654_of_match[] = {
>  	},
>  	{
>  		.compatible = "ti,am62-sdhci",
> -		.data = &sdhci_j721e_4bit_drvdata,
> +		.data = &sdhci_am62_4bit_drvdata,
>  	},
>  	{ /* sentinel */ }
>  };
> @@ -906,6 +943,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>  	pltfm_host = sdhci_priv(host);
>  	sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>  	sdhci_am654->flags = drvdata->flags;
> +	sdhci_am654->quirks = drvdata->quirks;
>  
>  	clk_xin = devm_clk_get(dev, "clk_xin");
>  	if (IS_ERR(clk_xin)) {
> @@ -940,6 +978,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>  		goto err_pltfm_free;
>  	}
>  
> +	host->mmc_host_ops.start_signal_voltage_switch = sdhci_am654_start_signal_voltage_switch;
>  	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
>  
>  	pm_runtime_get_noresume(dev);
> 
> base-commit: aa94665adc28f3fdc3de2979ac1e98bae961d6ca

