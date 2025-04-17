Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02021DE883;
	Thu, 17 Apr 2025 12:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744891470; cv=fail; b=hq3FLROz55ItOofLV0WYy4Xp94fNVYXHdORIO7Igb3vpJxRLhpiVD5Rr1WhoN+9AAh5SQeZAYf7gqLTwxuUukOlSIY2l+1Cg1mWxc47UdKtAh9B4pMuqkTC/8d+eg3JprOG+NPuxMJI1rxSIMrsjQn8CfHLNtps9MBatbO8t1hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744891470; c=relaxed/simple;
	bh=iT4+jlwF97ebOyz5btzvKBAwZ6JfEQbuyH4VtvHNvqs=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QdHiytNfrjsM6CY2XNtQIlfvm6FOzoWQDnGcFbxLCL2iAW5WMGgjnMVcon41wFojyYXnqGEaz2B5CQLYXvkg+iX6zSkqSfWX6aorwA0Ln3q//HLKAfTsefsbiX22/+wI7DJdFkzsJ4DzhUc40wMrpxXLa6SjZWjxUlpA5yZDO90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HANBsJzJ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HANBsJzJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744891468; x=1776427468;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iT4+jlwF97ebOyz5btzvKBAwZ6JfEQbuyH4VtvHNvqs=;
  b=HANBsJzJ5KG5zQhgBX8WfbjyzSIzNh2Kk29RhWbD8k4yuR0PP6hwVo47
   V6zYjMSw+nvEHzZP6+TJX/HwnMO8NuRlqBsgyD+ynLjYx+rkgbZfO8Iyq
   /WigmyakbH1Ra5OekvCGPPB++L1BiG0lwFcySSCTFZAbw2rUdCqzwy+Sn
   sFFnPwLaYoa7bZeBe+vXNKVpRN+KNpvQPVhrcV1FsZQ2Ii7Hv4ytNnWx6
   nAWDp0eMhtYRkGSduprBhI/RpJozv/pNnPXo5vH1KuU2mApjhL+9UNCrx
   wYmAQ4fQ9FWvnPzdbHBWGKnzQW9ekqfv5PereqFQPWvG7/qQPZmdqDj75
   w==;
X-CSE-ConnectionGUID: SqUzM+FKR42P1PqZu3i+Ww==
X-CSE-MsgGUID: 9t7PQT0iQwWXlXAde8Sb6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="46358813"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="46358813"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 05:04:26 -0700
X-CSE-ConnectionGUID: qWwckD8ORuygahSQb7DMlQ==
X-CSE-MsgGUID: MT+6wme+SaiZ6BrqfPWpyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="130743590"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 05:04:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Apr 2025 05:04:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 17 Apr 2025 05:04:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 17 Apr 2025 05:03:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9DKft3luTcPmgLkHA9Jk3DKv4fxwis04xt6pdyNOiJpPeIdQ7FAz2RBkbtmC3Ff7dNZXQroQUFJFZD+jNlnrZaGfSCnLWVrvXhWcZxV/L9kMTm+G324INH/wfqqhHp/KI+Yqn71VzlIx0yqqH/SoQg5JrVe+PVoPASM0YIeqIfSN96qJgKSgxQwbEWlpV0PNbn/w4YLFOUp0c9JrBX3la4hM7WAH5B85At+UxjRy+dwg+iwqWIY9SbtaEPqLAPxg/QiAxj2W0/AHGxZDCztvWPrkEbXGHhSa1eWveoxoEJEUb/+d5GnA6tJVOedT/t1ImOJ7qd7P8eUDmu96hz1EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inF8MLAishDCqsBLbBK+df9/QgQL+9shT7FKeXdUAWY=;
 b=C5iCRyNNnoTMnMx/OnNNgWjc165ZF6qvn+EZjgxgJdNthV5i5cBrfg5TXcsnoNquwxTbqdGqT4q2+yCh4gWcWKebwGac7AAfcudtdn3uQWGSHvjTghh65P5mc67T3ApXPlTRm9a8nFLMccV7PFIxeqjI0S/tL/09LJPZtAvFcOTXxNpk0WMnkR/qNDwOsq/fu1sGSgU+I+9Gw0ko+EETkoIBUb5qbFtta8ZQTqqryvIJWxg/nBzdkto9tuWPA6FozNXZylAGlavb49sjOLIRu5o4UfxdcnaUuANNtv1zGBk8Ze9EDkoAqO5ZQyiXQjPxvfVp6B5ZIlXcvDs/HAooUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8)
 by SA1PR11MB8476.namprd11.prod.outlook.com (2603:10b6:806:3af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.25; Thu, 17 Apr
 2025 12:03:21 +0000
Received: from PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301]) by PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301%2]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 12:03:20 +0000
Message-ID: <48664ea9-f949-43de-8706-463e78afcb61@intel.com>
Date: Thu, 17 Apr 2025 15:03:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix V1P8_SIGNAL_ENA and HIGH_SPEED_ENA
From: Adrian Hunter <adrian.hunter@intel.com>
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Josua Mayer
	<josua@solid-run.com>, Moteen Shah <m-shah@ti.com>, Hiago De Franco
	<hiago.franco@toradex.com>
References: <20250407222702.2199047-1-jm@ti.com>
 <3f31eded-4a7b-43f0-819f-a3be48cffc7b@ti.com>
 <da959d37-1513-4679-bb09-d08bdbe00fa8@intel.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <da959d37-1513-4679-bb09-d08bdbe00fa8@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0214.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:88::11) To PH7PR11MB6054.namprd11.prod.outlook.com
 (2603:10b6:510:1d2::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6054:EE_|SA1PR11MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: f9a960e2-8a93-49a3-0c81-08dd7da7d8bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkJDVFU2QlppRWxlSUlGTmwwSUdNdTY5ZUdESHRKTGJLVEE5bTd4bWZqQktN?=
 =?utf-8?B?UTFZbUxVTDlaMlQ0eHAxbEt5N2U0OEVrbUFCYno2Q01XaU9zSitGbmx2bVRz?=
 =?utf-8?B?WjNxa2VMUGZKRStNTjNneTVTcnA3K1YyQ3hSSzNOVmtpN2xwZHZhS2ZvdlRK?=
 =?utf-8?B?WHJaR3pDdHRGY2dsYWdVT1pNc0NLTTB2SnVFTDhkWTdyOEI1UDZTei9ERWt0?=
 =?utf-8?B?WVJ5ZTVoVGNyeC8yMTZhK3JDcWdmTVdkeWh3cExlUFdwK2lhODR2Uk1qT25W?=
 =?utf-8?B?aVlHbDRJdHJYcndwM1hlZFM0encxWGJhdjcxWHpXc0RjYUdOelhVdHNmV2l5?=
 =?utf-8?B?b3gwMmdEVVJyTmxZbGdCbkFWbDdMN0Jqa240N2FEc3JUYWdvVEp3QkdCTmU0?=
 =?utf-8?B?cUlRUHlCeHJQbHl6UjBOU0hCWm5zbGY1aGUrYktkamIycTh0WGVYNkw4eHFE?=
 =?utf-8?B?cUxvM1NBd2xGVVU0eUVrVGFoYUN0aTN2aXovVzE5Q01FSEIrQndGbHlCclk1?=
 =?utf-8?B?NmlZWWdoMG95VSt6YW9oUkYvM2laQ1JVQ1ZhaGhUQ05TV2hKVzhyUStrTEFH?=
 =?utf-8?B?eUNEWEFFSmZqdHY0emtaWUFHQVd4aXlLYVNvWHBRVWoxeXlpMlQzM0o0cmlL?=
 =?utf-8?B?NTdiTFZkUHBERVZkQkRJdzRublZBSkhXNWtkUW1zamJucThWOU00c3dTRmRW?=
 =?utf-8?B?RW5LNUJJUXNxMGpsYTE2bjRLOHR3cnRxRjgydjBwSXgwWU1qQ1NBN2FmZmRx?=
 =?utf-8?B?RE5UWSt6VGZuZGdjd1ZrVVpPVTF5aU41WUF2dVJkck9ReGhTemxCRkRxanQr?=
 =?utf-8?B?cmFNcjkzWXp2NGNISmo0cE1sUjJabTZQZ3YvdmxhbnJNODhmbEEyWjRWdGZR?=
 =?utf-8?B?SUtQVGdCNjhTYzRVUWZicjZNdTFvZWJlcDhJSU8zY2NwZGhZMDk0cjZieEhV?=
 =?utf-8?B?TVVNVnRaOVRSdTlGQWQ4WmRXNkw5SHJqbHhZL3g4OWRsL2hoMkxBaWFIVEdt?=
 =?utf-8?B?L1dsNk4vZWJBd3FxN1EzcTVtOHZ0cGZzdGFMam5NRVRTdXhkS3FUZWI4RXJj?=
 =?utf-8?B?OFpjQTltWGVlVEg2TjdaQ3M0dmo4d0E1bWFLbW1oeTB0K0Q3RzcxejhOTCsx?=
 =?utf-8?B?MGt5SW9yYW4yVUtXcHZzZGF3V3NFekcwWmJ3N0liRTNLZFc3QUtPdGtoWmtm?=
 =?utf-8?B?aTVqZVlMbE0rVTg4cm9STUVBSUFrbDVOZzZwcUZnU2V1Q2NlMzFZeEhQQnIz?=
 =?utf-8?B?bFFvRmpOTElxNGx0bnFWc1d2M05pRmhXcWVNUEh6N1ZTcUNPK00yZTVNcVRi?=
 =?utf-8?B?R1lTTkJ2TkNJek5YSmp0OEhIUzFxYUJlWkx2ekhDb3N5T25Na2FZUW1ybHJj?=
 =?utf-8?B?RUEvdzg5UkE5MUtHajh5d0p6MWhDUlpIcmY5VGNtODNKR3JYaW4rcVp0MGZp?=
 =?utf-8?B?eUxiT2ljMk9Ub2d6bVM2eWJlRUtuK1VUSk1SMlgvdG1DSUpHU0RGY1lpRTRV?=
 =?utf-8?B?azZmendOWVV6T3BiM1hjQXZPZ0lRS25ONWo0WmlLSjBRcnZMUlQ3ZUc1UWp3?=
 =?utf-8?B?bnlHYnJwaVhTSk02NFU0aFR4aVBrdWpZK3VOcWJ6MnYrUjgzS3hBdlpRVS83?=
 =?utf-8?B?eVVVcWVTazIvaHkxSlRhaHIwcEpEYjlXZy9lK0FjMmhUVHJaZk1JaEpCODFK?=
 =?utf-8?B?QXRFWStwZFF3MGtsZ3VCTUZkNGRGdkJrYnREaUUycTJXZk5FYURGMzZNMXFO?=
 =?utf-8?B?dzYrSnZSeGpGSkEzbXpBS25mbjlCdVp2cE1tTThRTkwrUUYwTVM0QVNZclJa?=
 =?utf-8?B?aHVESXJ0RWYyUmh3Vlp6OHVadXZkcnRKT3dpTjJRV1FyazIyZTdSTXM2ZmZG?=
 =?utf-8?B?Qk5lN1Y5MkdOTDNEQWRNMUdZZDRMZVppTlFJd3NEbGR5UGRrVmZmSllRdWxs?=
 =?utf-8?Q?wsCRtABQ3RU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6054.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1d4bTcwK2NMaFN5VlNKb2x1WDFhRi9RU053Q1ZSYURyTWdvL0ZBc3Fad1dE?=
 =?utf-8?B?L0YvbUs3bDJlTVl3U2NSRUZDUGlaVTR5enRpRS9IejZGd1dRQ1o0Z2x3RUhU?=
 =?utf-8?B?dFpqQ1VQMjlqelJ3TVE2clFuUjdJZm4xSVBkcDVmeFNsZzZPdHVVTFpxRjBP?=
 =?utf-8?B?K0hIQ0ZiK3h2SEFYaG1Ic3hDUldXRVFTU2VqeGc1eGVkU1NHeWhoRTBIRG95?=
 =?utf-8?B?enNxWmkyYUtuTSt6NTdFSGUyVS9IeWpnZ0hScVRlK0N1eXpaVjJGUVlvZ0xx?=
 =?utf-8?B?aCtBSEZ4d00yYmlCTHhWOUlPampCa1N6ZkdnTXdGenZ6MEhSSGFTMUY3Ti9m?=
 =?utf-8?B?THV3cXovMTY1RS85SXR4eUdOdXJNZjQ3RkwySXpCVnBzakhKSy9Sdmd5NDBB?=
 =?utf-8?B?azlEY2pEd0ZqbnZMWU9ZcER3akt6cE5qaHdvTmpjZDRKWm1UWkt4aXByK2Ex?=
 =?utf-8?B?TWM4QThPdWR5emFuY1dmQkhrNnV6c3VrdlZ1UE9ndzhhbHVZaE9Xa1lGdnNY?=
 =?utf-8?B?bVBxR1FJREJIUmo0MFppdkRiMERodVlpS0UxU1hNaDc3eDlnOUVZUUFTRk5t?=
 =?utf-8?B?cjFNYWNzNHNIVllNR21KM3p2QWpqb1VhNFpUS2IvL3ZlZEtXVDl4UzVsU3Rj?=
 =?utf-8?B?RFB5Y1hIMWNjUDNTVHJ4djVVeXFLTlJkQlBmN0VlZ0k0bTR4UnkzMTViNWNK?=
 =?utf-8?B?QmZxbi93V0lieWppSEd5Z1dtbkVNZFlDZEtPMHlGZ2pEVHpiZFA4Wmo1eVZu?=
 =?utf-8?B?Qld6YXJ5eEV3L3NVbmx4SU9rSWYxRzN4YVpGNlp2Q2ZXZUpEU3FIb1BmV2Z5?=
 =?utf-8?B?dUFYMDdvRUJ2MTV5K1BrUjgreHdjR2hXSmpRTzZ4T205bHBmTk5vZXo3Z01x?=
 =?utf-8?B?MUcvU282aVZNOVA0TldDYXBwOStONXMvWEhUdGlYMFhjdUh5aWlXZ0pYK1lZ?=
 =?utf-8?B?dUtoZjhOR2RRWUg5dnhRUzdIK2dlVzhWbUEvZG04QkZ0ZlRvYUJ5dldsNFVu?=
 =?utf-8?B?YjM5NG9PWm9jdkN4K1NPSWJhTWRSOGt4TUJtd1lYSnRpQ0dnTWdzRk13MEt1?=
 =?utf-8?B?VlJlN2Q5U1kzZE9wYXRvY05WV1ZyMlZJZDFKQmxYeXZhZEFtYnEvRHFhcWxn?=
 =?utf-8?B?TWFDRUg3bmx6MWRuNllySFNZY0NXZUgzdjNSYUVvSHFKRXk2eW9DS3NEa2VM?=
 =?utf-8?B?QU1UelJrTXdpQjFrbDIvd2NYM3ZJQTJISzlCSFdSS3pUc3FsOXdreFlLaW5p?=
 =?utf-8?B?SmE5bUkwK3duU1B4YUw4UXF6eEZ3SEJyaCtLV1BJV3dNcjdnWEFzMTdDMy9x?=
 =?utf-8?B?QUEyQXRVMGpUOWFnSnV4ZnMvOU1YTWlrYTlqVlFuSGw1M1QyZTRLRzZCVDB5?=
 =?utf-8?B?VHpHYlBtRnpSZ2NQNWR4UDA0a2RndXBGWkYxNGxTYXZlcW5LTUcvdUtlV3Nx?=
 =?utf-8?B?SEUraGR5S2drNUdWY05adHRRdHNJbTdqNUtQR2dBQUlmWGZON1BMWHhwajV3?=
 =?utf-8?B?WGNtTml3VW43TUZ2UTZ4b29JZVRPL3JUMnJJaDhnZ1BPY2hpMUFPbi9KLzZF?=
 =?utf-8?B?NlJLZ2FyaGorQkhRTjZwVFZVOU5BbWZXTUlqaHB1ZzAvNmdDSDdnYW9adTl6?=
 =?utf-8?B?aExDUDJ1MmxqZWJadysra0lEZkJRcG5tWGdXaXBZSU80SjRNVVkzMDdOZ1Ns?=
 =?utf-8?B?VGNuNElDd3pHNFZ2T1lEckl5QWIzbDA4QzI1SWI4VWw2QVh2TEJ4eTZ4NHMv?=
 =?utf-8?B?aE5XY3dwc2haZ2IyVzNXckFFaVZaNTZCYnRCYVBzQTRyOHZxcVJzZjN0UzhH?=
 =?utf-8?B?NnFRZlFLZ3lqSDdpSjVycWVqWDNKMVJ2ZjV0MThFYmhPZHFmWjZicENSSXB6?=
 =?utf-8?B?cHpMckd6VWlXcWxkdERMWnRsM1VZODlnK2R2anFoelUzcWY2K3pibHNVVGQz?=
 =?utf-8?B?YXhoS3ZDTUs3SHF1VXVFdG5DYStDdUdoTWFkcytwU3BPcG5XaFRXSE0rWEYw?=
 =?utf-8?B?QklCUTVtZm1NamRQWGpUaDVYR09tQkpsa1Y1d3E0cUx4OFlDWW5SVHl3VlN4?=
 =?utf-8?B?QjdaMWIxZ2YrVFlBTVhDWC9IQWtlSG9pdlpqY09vcTR5QmtZWkMyZVhtUFhl?=
 =?utf-8?B?cXpvUTNCUGtDa1JINHVubUVQZk55eWwvclp1Q1RsWmVlbnJGZmQ4WXkrRkhJ?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a960e2-8a93-49a3-0c81-08dd7da7d8bc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6054.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 12:03:20.8746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Eh8o9oe3oxdRdcgx02B47FbjMHI1sMWYd6Hluply0Iq1ihCMq/lzNMjOjnGbeLc/IrA5dwRYxSrXUf4d6gYHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8476
X-OriginatorOrg: intel.com

On 16/04/25 22:11, Adrian Hunter wrote:
> On 16/04/25 19:59, Judith Mendez wrote:
>> Hello Adrian,
>>
>> On 4/7/25 5:27 PM, Judith Mendez wrote:
>>> For all TI devices, timing was closed For Legacy and HS modes in
>>> half cycle timing, where data is launched on the negative edge of
>>> clock and latched on the following positive edge of clock. The
>>> switch to full cycle timing happens when any of HIGH_SPEED_ENA,
>>> V1P8_SIGNAL_ENA, or UHS_MODE_SELECT is set.
>>>
>>> Currently HIGH_SPEED_ENA is set for HS modes and violates timing
>>> requirements for TI devices so add a .set_hs_ena callback in
>>> sdhci_am654 driver so that HIGH_SPEED_ENA is not set for this mode.
>>>
>>> There are eMMC boot failures seen with V1P8_SIGNAL_ENA with a
>>> specific Kingston eMMC due to the sequencing when enumerating to
>>> HS200 mode. Since V1P8_SIGNAL_ENA is optional for eMMC, do not
>>> set V1P8_SIGNAL_ENA be default. This fix was previously merged in
>>> the kernel, but was reverted due to the "heuristics for enabling
>>> the quirk"[0]. The new implementation applies the quirk based-off of
>>> bus width, which should not be an issue since there is no internal
>>> LDO for MMC0 8bit wide interface and hence V1P8_SIGNAL_ENA should only
>>> effect timing for MMC0 interface.
>>
>>
>> On this patch series, I am bringing back the fix for V1P8_SIGNAL_ENA,
>> Ulf requested a change [0] which I am planning to do for v2. But I was
>> hoping to get your opinion on whether Hiago's suggestion [1] is doable
>> so I can add that as well to v2. Thanks for your attention.
>>
>>
>> [0] https://lore.kernel.org/linux-mmc/CAPDyKFqx-G4NynanFWrspz7-uXXF74RfjcU-Sw2nq2JhL3LPuQ@mail.gmail.com/
>> [1] https://lore.kernel.org/linux-mmc/20250412132012.xpjywokcpztb4jg4@hiago-nb/
>>
> 
> Sorry for the slow reply - been a bit distracted.
> 
> I'll look at it properly tomorrow, but noticed
> sdhci_am654_write_b() already is dealing with SDHCI_HOST_CONTROL
> and SDHCI_CTRL_HISPD.  Can you make use of that instead of
> a .set_hs_ena callback?

Patch 1 continues to look unneeded because sdhci_am654_write_b()
seems to do the same thing.

WRT patch 2, the suggestion to add a DT property and check the bus
width seems fine to me.  DT properties can be added to identify
"broken" hardware that cannot be identified by the compatible
string.

