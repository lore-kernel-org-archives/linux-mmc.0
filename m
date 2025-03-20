Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D601E0E00;
	Thu, 20 Mar 2025 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742455563; cv=fail; b=Wmz0nCen3N9Yb433A7cM+Cq7zMFGpDui7YmHa10WBpw+JhTRb87BY+X8itezeXgcp+rG5BVPky2B6rBo/oultLOC1l59AplN4+pCgModojRzJK6pJuxAlqcJiFxZp3Ep3ADa4B8eX91XUcUGHkcXh0kvi49Ksjpeo4Ym6mJsGsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742455563; c=relaxed/simple;
	bh=k9PcWjhn+YReWrccqHNIvfBWAVpSFLSJWP2BQeyYZHA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pwObm07xJvp+BGwmHV2f5xQNfzAsEOAD9IEIs6aUYVMXNuruqGEKUUiOJ59KoTlSZl+Bf0EVDnekkgZYTBNSJ/b1H39Dv16CAFIDMFBTE7RClrdbPvBGXVW4quJlGM2dDJLGybebAOUy/BhOhC6zrpLzS1+egymPYKgsgdN55jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WW6zPNPx; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WW6zPNPx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742455562; x=1773991562;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k9PcWjhn+YReWrccqHNIvfBWAVpSFLSJWP2BQeyYZHA=;
  b=WW6zPNPxa1rZJbirtCDVPMiV8ILoGdCdAdNmiFtcFV3TX/yRlr0yWy8Y
   VByDzNy2AeZZq43RHYxorPrGYeuQb2GnkgdkNi7YULu6K1q+tF7r6mJEU
   GrQqmq2w92YOFPXWwB3zChPPgRXHyyJFgo7jEkp4X/AlmuAhfdOQasuXI
   uWbbfMI5h5Gk7AJnzlcp62yebI8SARBMHQkFKQYtvnZd3AB2bPG2KgfOc
   l42C8jVpTkdqNNZAVuc/UriNqOb7DM1TcCwIJIpSK3lIMfgqJ2csubm5j
   aeWq9ENB87KDmTNwo0jOWWGnHYUdK8kIJnlRuy8I/ma6itKAYW9woSO4d
   g==;
X-CSE-ConnectionGUID: c3c+iMehR2Cus55JcNqBYA==
X-CSE-MsgGUID: LhlGaxIjRaKkfKPO6l1GRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43684566"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="43684566"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 00:26:01 -0700
X-CSE-ConnectionGUID: 9wzEvCn8Smel09Y8bBOo3A==
X-CSE-MsgGUID: +TIRZHTlQcurbbyovltTZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="127691061"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 00:26:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 00:26:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 00:26:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 00:25:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSVDrLltC5fqldjGUuh1oYHTwSBfhAwDa+nuxBLnMSOIE0lnVJoafZ1sBpW5p41MUX0Frxvcd/ETDBllCqDlU0Em8GZDCsOGtJOTFYKp73GUhZFKuh8acKVxB9Q5VceCwCvqaEiH0ThvRtYPqxzmTTOJ+NhyB0eUS6VCqlwpyMkWc25bxa5+IFctcPir6CNmnmLjtRk+MLZxUPMOHxuu/FI+wMIJ7XormEg6yYM/wzlqQCrGJGc3UPolp4ENDlhK2DDw9RPyRBPYtlppgCSBxqRBD05bAnF8gQGFGAlK46FIa8lCIWf7jItvuyUxib2gVzjD8+gJ6unh+zwEqDIOzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Td712y001tkPNaFU/brBd1cU6sO3gUXapNaFpz5LlPE=;
 b=Ex2xp30sd/PB61B9TL0Kx/YpYMFM2e3VI2QIVH69M5NHq7oAAI7fLZ3UpvEqMy5BIZ/Oz3dGTy1sRHwPZ0yZA9oAnFAlvLz1UqMuTm4FHsAx/4AHNE1iFStOU5DbxVYspjPQlxJoF569K7Fd0W/IHEvfP2w+83caOIRLzlmSTSaDsxWpZKi38dXBVwUs9XkcFZlx61q0qLcrjzgKNINviULY+Gu6xZlGYZEBpvdjHG2F4ZL5qDn6S4ugWvM/jai7Idx0I9dQUh25/K2QAnyfeBiD4hogESUrDgs7D7dc5cC9JiVB+5Hn1MJw3Aij/ZvX8cLyhWSrKaQOEKpdgveQlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by DS7PR11MB6040.namprd11.prod.outlook.com (2603:10b6:8:77::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Thu, 20 Mar 2025 07:25:57 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 07:25:56 +0000
Message-ID: <5081fa69-32cb-4fd4-bad5-5f33032efc39@intel.com>
Date: Thu, 20 Mar 2025 09:25:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: host: Wait for Vdd to settle on card power off
To: Erick Shepherd <erick.shepherd@ni.com>, <linux-mmc@vger.kernel.org>
CC: <ulf.hansson@linaro.org>, <linux-kernel@vger.kernel.org>
References: <20250314195021.1588090-1-erick.shepherd@ni.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250314195021.1588090-1-erick.shepherd@ni.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0018.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::25) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|DS7PR11MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: d343872e-c27b-47ee-96d3-08dd6780744e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEoxellBOXkxNGpuTmYrWFV0L2xBV2lDOXV3Qm1Va3RVTkJyWDVJbnZEeW11?=
 =?utf-8?B?c3VWUnVtRkFLcUFKMGxqN3JNZWNRWWNKSWFMdTUvSmdoS0FXQzFEdHZ3WG5u?=
 =?utf-8?B?MVRKd3pQcVVKeGV0a3dJblk3K1BPRmErdG54aXVrNnNLYk5neVEyM0ZERXZz?=
 =?utf-8?B?dlZWNmNsa0VDOENlN2M2bUNGaGNOTnZEdVJKbWtPOU1jdGVTWitSWmVVZUJy?=
 =?utf-8?B?MDhrL2hYZzZYbnNtM1I0NlViUjUvREJ1NUx6VW11dzNSTG92UWlkZnZDSmRK?=
 =?utf-8?B?TzhUdlpBTysxR2xQVlFWeHo3VytmSHpwRGJuVnUranN1RHppMjdJK3plQkFz?=
 =?utf-8?B?YWtiM3k4cE1oT2QzdWNJVGFTZUtvSk05Q3YzMVRNVlFOZzJ5bGVnSDBxSFBB?=
 =?utf-8?B?bGhqNTQ3T2FiOUk0U1RSQm43RUxZNi9NZTZvemtLTXM2MzZ2UzZXR0llSEpQ?=
 =?utf-8?B?RHlFeFYzZWdiUGR4VnQvNDd3amJDc2NCaG1Zd1pWVXdlUEQ4Wll0YkdpbWhI?=
 =?utf-8?B?VzhOa1NnMVpiaFpxaDFENFpnekk3NmtTT0szSWVobHI3TEo1OGtkZk1GMHd3?=
 =?utf-8?B?TjIvSmc1ZHNkL3p1dXF0bkhabWlHcVpQVlVkeU5UbWdpNHd5M1lMc01jM0ph?=
 =?utf-8?B?bVR5RGhSYmpVUHJ5UkgxUzloY0s1L21kamg0Zi9XZVBVN1FaTnREV2M0ZENh?=
 =?utf-8?B?eE41aWxlNzh2WWp3MHdwVXdiMUJiWTVZVVpZR1ZyMVBsSW8vRmROTjg3ZUMv?=
 =?utf-8?B?RnpQZ0N2MU1EejV0SXJyb21mM0U2QmRTMTlDZGNvMExNcjVhaEJ6cWFOTTM1?=
 =?utf-8?B?OVFUZmw0K29wQk90WHUra2lRSDJrLzY1WUg4T1JJZmRsaHlwemhKbDVZL3Az?=
 =?utf-8?B?blpnbmRmWnBGc1RXSFNsUUlUUFlzUFlJQ0pnaE1CK2ZDUWRsaVZGUHlnaU9H?=
 =?utf-8?B?K0tWSUJDSUJXbGh2K25PTlJxLzUzVFRyNDJzdE1CL1VRQkp6dEtJbEl4UXds?=
 =?utf-8?B?cWJ6WXRTU2xVdkIwRXk4L2RPQ3lxcW1aSzNUOGlqdC9kZzkxNUdQait3TzZr?=
 =?utf-8?B?RnBqaW1Bc2QzZFlVNGdPblI5SXZwcUN1MEh3RjVCUWxRcUlkQ2lyTlR2cVZC?=
 =?utf-8?B?cU1lcnhLR3Q0SmJoQzNndnRTUktObUp3WEVtcHJRZnd4NEd6VXNVOFVsNFly?=
 =?utf-8?B?VDE0cmVZQ0kvaG0vb0k5QzVES2ZucG40Sm81UFNZc2FUb21SQWV3S2RkRXVw?=
 =?utf-8?B?dTA3bEtTT3BtU243Y2FoUlNrQUlscnJsZmROdHU1OGFZcm40b1lzOW0xWTBi?=
 =?utf-8?B?SFJzM1N5TWxvV0cyUXJoSTB0d2JXOW8yd0NBOHNTcFlFckJraEIyVWhXM1gv?=
 =?utf-8?B?OTBvZGNKeTlKYnNKdWlkYlhtQXAyZEt5YVJOZjFaaWZFZ2ZtL0V4dXQ5ZW5D?=
 =?utf-8?B?d24vSENXU3dKZzB6c3cyQTZGbjRRZVc2R1FuRVBRQnp4c0xYTmh5NVI1ZVN3?=
 =?utf-8?B?MUswdWw2QnJCZkRrS0JNangxMHlIb3BWRWcwVUsxSW1TMXEyMy94UjZVSldX?=
 =?utf-8?B?Q052MmlIekRGb0xJaDFDNTJYeXU4dUJZWjRoM3RVSWUzTE5WWmhLZzA1RWtK?=
 =?utf-8?B?aktiQjBsYWs0ODJ5aXZCR3pXejJiaHNqVmVobUZLU2padTY1YjZOaWhZQzdl?=
 =?utf-8?B?Tk9kMHZOZHE4RUVzc01NMjkwdHpLNk03ZlhuRWxjdWs0KzZSQ2loYTE2aTNG?=
 =?utf-8?B?N1c2Sy9rc3FBdThJL2o1RjNhUVFlT0pjMjNBMzZpZC8wdWk4dVUrZ1dxaDZ0?=
 =?utf-8?B?aVpSb0FOcmJwei9KT0dnKzYwdVVpUWx6WjJoUE81WUFNdCtkQXBpTDhKL1d3?=
 =?utf-8?Q?ae1HyjVceCa11?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3ZGaXFlVEE4OWNyUzRTTnkrZGZvSDRtNGtoK2RUOUtBUXJDVXRqeUh1bHE4?=
 =?utf-8?B?M3NodGZZbnpEaEozb0t0T1VqK256bTk1YVdYYmowdVNreXNvanFaNzcvY0F2?=
 =?utf-8?B?d05rUWY2aThndWI0Y1BlRzdDbTkzY3Evb0xsck9lNkdBTi8rQ0Q3NzZIV1li?=
 =?utf-8?B?NE5pVzhwdWFMODIyTmlXQTR5cGdyMVRudHJSVzAyQ0hOT1BKeFRwd1F1TjFW?=
 =?utf-8?B?UjZsT2dLS0UraXZIand2cEwvejNuQ1NLRkNXREFIYmxRNVl5YjI4TnZjWlRB?=
 =?utf-8?B?dW5EV1ViR0hNZG5EMEg0Q1pnZ3FGZGtCbHhETFFKQ0hMQ0FYZU1jUEtWTU04?=
 =?utf-8?B?OVJaZXgzUmlPMkhhZ25xRFQzTnk4cW5kYUFCeGlrUHZ0Z3lhd08yMHYydGov?=
 =?utf-8?B?Y3FIcGpFYVV3OG1oazZnbDlPa09paWhnUVFEZVZ2dmdzYXVOaTNsZVJZbFdT?=
 =?utf-8?B?L1hzbVc5V3d0RDhOQ05IZjdqTDEzU2svSHBmZlJiZGtCNExaWEpvRnpydTls?=
 =?utf-8?B?OUNueDVTZTBOWCs2b2ZQS25Vd2J6ekg4SElQcWZyaWo4MUU5clgwLy8wQTVk?=
 =?utf-8?B?K2grZjlTZ0JOcGVkOHRrQndaVEpGdW5Pcklmdmp1d1IwU0RsUnl2SldhVi82?=
 =?utf-8?B?MHhGd3FMYzJielRXRm05VGFWWHJsQVZId2d0cmpFTmR2L3o1RWYxcEMzL3I2?=
 =?utf-8?B?V2NlNE43eVdWOUxNZ2svUDltVEl4d0lsMGtocDJ4NGFXQU4zVFNtaG5kRStn?=
 =?utf-8?B?MTBEZHRUZ3d4a2ZHODZoanlXQ1duRm41cEUzQ3JSang0Nkk0UlRLUzZCakFi?=
 =?utf-8?B?SnJpVFpyNnVJSkYvSTJLaEVaSUFNNUpKN3djQzJ5ME1kQTVYc29weGY3M2Ix?=
 =?utf-8?B?emM2YzB1MzNrSWdTVzZWck9QeEhKL21EZllkbTFqeUI1T3ZNejNPaCtHZ0dF?=
 =?utf-8?B?MTJkOGVKeHZsK2xQaWh3UVJyemZpUXIxNXZWTU10UEFTUHViSlVhVlcvempR?=
 =?utf-8?B?MExPb21kalltQmEvWXEzWXRXV0w4ZEpkY1hkc1Y4bmRkdGtZYnJjZEwybFk0?=
 =?utf-8?B?M1YwOGluN2tTS3Y3NlAxNTVub1ZNM3VKTDhxajBDRWhtR3FmT1FvWEZvQWE2?=
 =?utf-8?B?aTJRRjJBNnJrNVRnbGZoenF3UzRGL2RoVjZwM1VLRFlacjZCNEU1eEFYVEpH?=
 =?utf-8?B?RXNVdHdHcmQ4TUx1KzkyVnBwUHFxNlcyaEQ3YjZ0SlpCYllWeGR5ek5Ucm5K?=
 =?utf-8?B?SlFJbmxad3hTbzJFN1gyYWs0Y1pNeS9ldDBKTWQxYVFMNm55NE83dmZZd2o2?=
 =?utf-8?B?OGpmdGtEZkZHQ3duMUdjam1sc2Vwd1BEcVBqREIzYlhTTjBGTURFb2JCalZ1?=
 =?utf-8?B?WU56TWhaYm84VjVWY1Y5b3JyUm9JOVdZanNqNGxUS0pFVzNQR0tjTTk5U2VL?=
 =?utf-8?B?dW1kaHhxaFU3bjRScCs5K01oTkFtdncyMnRRUEw5cVJQT1VUWnNPNldBeHd2?=
 =?utf-8?B?UlBCZGE1UVYzeVNrV09ZVUlrbmNHelhWYi9SYjdUN0d3TkRsZ1RjcEZwRW5X?=
 =?utf-8?B?TXljakVUVmxHbmN6RSs5RmZIeUt0Qit6eHhiYjUxaUx5YzVCcFNxQnkrVnFL?=
 =?utf-8?B?eEFjLzQ3SmE0aVhqS3BsbVBvM2FRZjdwY0FwVFhSY1JaMDJQejJuZDJ1Z0hP?=
 =?utf-8?B?OEpOUkN1SG1OZlR5VDVYNnV0ekZ0bjdIZXpRWDA0QnhQdG1wWVRReDVhRitt?=
 =?utf-8?B?VmtWWUV4RnpDU0pMUEJsWld6T3hCVm5MeDg0SW1HL3dRQnFBRmhRalVQbFpF?=
 =?utf-8?B?REJVcE92aktNS3E3TS9lRmFGbzBYVDl0V0tiNUEzNnpXVkRPTUwxYzQ3ZzMy?=
 =?utf-8?B?ZWRXejBhbWNKVkwvck1qbnVkK29sd3Y5R2hjZG9iY0VydjNtZkJOUzRqRmQw?=
 =?utf-8?B?U21Wd204VzZlK2F6VnpDTkgvTlY5N2JreTJ1TE5SeVJYUTdXSHZhQmF0c0Q5?=
 =?utf-8?B?U1pNNGcvWHdWN0hlQVVkdWxXTlhWZFlpZzhmU1lPSEJhUW5FMmx4bWlpRXJv?=
 =?utf-8?B?bFlTU2xqQ0hBZE1RNGJBcnhMWk1CYzdwaU5yZnRNM2FtYkFsdnlORDRtQ2lQ?=
 =?utf-8?B?MFF5eVRkZ3A2RXk0bWFGSEYxaTlHem1la09FUEcvWWJTcFIyc285S2Eza21Q?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d343872e-c27b-47ee-96d3-08dd6780744e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 07:25:56.4989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6vKGubrG66Z5mCuZq8+4z4U0bLPsM2PiOvp8VhNNZq2oz2d4kqM3oFRCfCEKbPOcgjOcTo68yDNZeDKAV/33Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6040
X-OriginatorOrg: intel.com

On 14/03/25 21:50, Erick Shepherd wrote:
> The SD spec version 6.0 section 6.4.1.5 requires that Vdd must be
> lowered to less than 0.5V for a minimum of 1 ms when powering off a
> card. Increase wait to 15 ms so that voltage has time to drain down
> to 0.5V and cards can power off correctly. Issues with voltage drain
> time were only observed on Apollo Lake and Bay Trail host controllers
> so this fix is limited to those devices.
> 
> Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>

Can we leave a blank line after the block.  It was that way before.

With that, you can add:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 1f0bd723f011..b1f7c11ea61e 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -610,9 +610,12 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
>  
>  	sdhci_set_power(host, mode, vdd);
>  
> -	if (mode == MMC_POWER_OFF)
> +	if (mode == MMC_POWER_OFF) {
> +		if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_APL_SD ||
> +		    slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BYT_SD)
> +			usleep_range(15000, 17500);
>  		return;
> -
> +	}

Blank line here

>  	/*
>  	 * Bus power might not enable after D3 -> D0 transition due to the
>  	 * present state not yet having propagated. Retry for up to 2ms.

