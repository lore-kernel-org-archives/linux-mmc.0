Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CEF23F40C;
	Tue, 22 Apr 2025 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745317476; cv=fail; b=XFbyrOOcc7as2RFq++1MnDIDiNk44LHzywj3SRfVKBEVizhoaoNNY90rm43n7wDmCJn6av+6P6939SEuqNPxRA2Ma9zv1a+Dgo6tTKrKSZSR+CDXvCBdKsK2I2ccc1KAscj01PffcxqjW1OEYREA/ubTQPtiQHOAoykfsnhaZNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745317476; c=relaxed/simple;
	bh=lfNHCRTH8a6jl0oVcv8nz8NB+aldepW3nopQq17rhbI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FDg7eBZK+VqCcVCnnt7e/1Mz6jzf4iZcxxd+OfCi1U4ItLqlqbUrSDujq+hd0UEylx3NhnDrd727YBRzdSoiAN8aCCYgpKUS9WaHrYbKZr2fyprEG4QKpLAAQkYb9Z/qGSpt8BSy4xQTaFG08MKWrbO6bwrouL957G1qFmZHbOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TxQeEdGn; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TxQeEdGn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745317475; x=1776853475;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lfNHCRTH8a6jl0oVcv8nz8NB+aldepW3nopQq17rhbI=;
  b=TxQeEdGnMewuIvbNccIRGLaL7i56SeJq7GzHuw8blcC+LjLSlDGuR/Kk
   LbhxD6AulVEdxoFuwZ+8WEnropfoOxpPizEejwa4OoJ3wFmNSJ8sK8sBP
   f3G+uG8wjApAhsD4EJ2Fi+7vUOqduAw2n+q14aSf1w7a/mgNV/B3QWOfN
   Sn7v4LAA6i76gaFeKfVPvad0DZFwXJo9uTDU+xBr/063QB7DTVP9QpVhW
   aRcMR1ijpRDPIBogP340qIFkgIFMl/n12yNPnJ/xycjrOzBgGvsIc1F4V
   3PrtV8TNR2mybqEwCGRgls4lQRpx7V9QuwbwAdgzq+lqLztc0aYQAB+BN
   w==;
X-CSE-ConnectionGUID: kgnuR+ltT1ysM2TyC0CrhQ==
X-CSE-MsgGUID: 5tZYujy8R1y8FPDh1CPTcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="58237229"
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="58237229"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 03:24:34 -0700
X-CSE-ConnectionGUID: PFOCNb2/TWWI7/iv+lEmkA==
X-CSE-MsgGUID: /2vcUocFRpK/qHKPt7ivFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="131722794"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 03:24:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Apr 2025 03:24:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 22 Apr 2025 03:24:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 22 Apr 2025 03:24:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogof+4ZMZdRQWkyXkI4638qPP5KXQjBL6b5rZHgclyfgX6B+Zl0+lBocWbG6FFD2IuTrM+kVmGLkK6PUhq8E12L/qgmxB1+w4MNSfN8OgO9pZSAcA/y5f1DhU87Fz0P03v4F2tkTre7PRIdJ5mHX7eHV8deZlD82gFSbwoc0SSrI7/b8fMVfOEnL/Wfk7XtWIKJ2yR1tgpfRN0W+7bm8G94k4RLNy4m1fhg7tHHvpA9ejkl+jJ10R57XZPlC8eShvW/bfX2o2p5GfgOTo7oRxlI63NyRYTvOedskRk86hA22wmtDlNw5lE68qLeR8f7yVnW3Jc9iX7qaOWV3tsOC+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpYWjOKyl8zmqpcCuvmHXfCojATvEgRKTmendezb2OM=;
 b=Re8GI/yorDfijcl8iNaAIcNE/xASzHHrWLj4f254BA7OK2/KKJt1JJ+2V0v0MPV2vqyp2jR0iZgNXv/hfstVuFGS9sgLn9NPNofXXOu1mfPmmxzexxKmLhFymwcK+wwIwcEeITk991wZpL1W5/rwNaMbeUNCGjYXui/wGVZizFKvqIr1m12OTYPIbqC6PR7JDsxOT2K27aeNSDb0gjP3GHPZ8uSSZy8+4ZHLWHy6HEg033fj2O/hpQvSYMel6ylxVUmTHSuLDcrQ8p9gwQAdJte5jxrzK6jT7ucKLIhm6txVtN9s/xVQ3xPSTyRBHNu+/SpbCGUcVwEOsDYvw2jnnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8)
 by SA2PR11MB4794.namprd11.prod.outlook.com (2603:10b6:806:f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 10:23:59 +0000
Received: from PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301]) by PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301%2]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 10:23:59 +0000
Message-ID: <ac3546ef-bffa-47ac-9c65-c3250da5387d@intel.com>
Date: Tue, 22 Apr 2025 13:23:50 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: calculate data timeout value
 based on clock
To: <ziniu.wang_1@nxp.com>, <ulf.hansson@linaro.org>, <haibo.chen@nxp.com>
CC: <shawnguo@kernel.org>, <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
	<festevam@gmail.com>, <imx@lists.linux.dev>, <linux-mmc@vger.kernel.org>,
	<s32@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20250409072604.3410459-1-ziniu.wang_1@nxp.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250409072604.3410459-1-ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::28) To PH7PR11MB6054.namprd11.prod.outlook.com
 (2603:10b6:510:1d2::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6054:EE_|SA2PR11MB4794:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b72a532-2a33-443e-c078-08dd8187cb6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWluSlBPWVJhdWpoTTFXVU5XRjZJQVRxZEQ5dC9nVHhUSzlsaG9Qc0N2T0M2?=
 =?utf-8?B?cnlmQTV4YWRCaUtSWTFkMnBHUHJRWXA5NVBsZnVCeDVqeENXV3h6V1FXbG5S?=
 =?utf-8?B?TWRYNXVaa2g5QVFqNFg3aU5FWGsxbHdqU3RQenhqdFZXN1VqcXp4UEJuS1NE?=
 =?utf-8?B?cWs3bnJQRHVLaGxnMDVRTytuUTE4bGZlQS9rb0dpNzlFRUY4bmJMZU8zM1Bx?=
 =?utf-8?B?S3pyM1cvMnpMU3hDRzY5cFlaL252QjJITVpJdWxvT2h1ZjRBSk5zcjkwRWY5?=
 =?utf-8?B?b3d1QURXK3JaRVFBd1ZLYUxvMXNWM2xQNlk4UnFydWVuNjBFeUtod29ZZXlX?=
 =?utf-8?B?TzNlalBoY3lqUW9LYlgvbTlrUUNUd0lhT0EwTXFsWmpSVU95eTErSzkvTkVt?=
 =?utf-8?B?TzRaenk0VkhaRWVmMlVkdllKQktRaDhHYkFpL29DQml3N2tkSmQxRzBuY25u?=
 =?utf-8?B?WldTVHlHd0c0bWNJYS95NDVISTBlUGQ0ajVlOWF0VUtXOGkyWDVvY3l1S3BO?=
 =?utf-8?B?Rm9UdzN4QWoyYXppa2RPWlFWUHJJVWJnT0x1OFBScVRya1N6V0dLSWhPMlNF?=
 =?utf-8?B?YTRscFRrcjZPRXNxRUFQU1kyT25MRnIrTnpsRjlBOTBRaUc1UGdOR1Y2Y0pM?=
 =?utf-8?B?NndnZVBhSGZDTWxLSDFuMWo0REUyQWo5OWdTQ0Rlc1huVldhZ3ozcTJNRG5W?=
 =?utf-8?B?YS9wZnBMSkdMY2FVRE1NNExxWGdqVXRkeWVjOTVGdGIzSFJ6TmRyNytkTzZU?=
 =?utf-8?B?MHE5QTJLL094NTgyK1UwRFNPUjZEVXVJdE9TTGFuRFNjc01NNFkwei8wcmNh?=
 =?utf-8?B?c2dic1BDSW9EelZTT2JGZTNmUXJweE1nenVibHV0SkFZWjYrMUFXTzhZUVNG?=
 =?utf-8?B?eXFoVmVhR3FrdUpFbDhmQXlLYkp5STBhRi9ZRVg1S2tBenBmTFlqbTBHQ3lK?=
 =?utf-8?B?TnEzYjRzZ2dNN3JNQlB6cFVhZ1J0Qk1veU9qc0srU2pjSDVoNWRKWnNtUlVi?=
 =?utf-8?B?SFd2TFRUeDg5ZGFVQWUxaVd1MXNoWW56WWtaeWllT3RjRGtkODhZeXd3bmNm?=
 =?utf-8?B?NWRyYmR0N0Flb29lWEJoMWZRL1RsRnZ1RjFpMFd6U212OFJud0Y2b05uTndR?=
 =?utf-8?B?NUtwL2syT2ZqbVZldkllakxjVWV5L0ZWdStqTUM1KzlWVWZRc1ZCSVU3bkZ2?=
 =?utf-8?B?dTJtWCsxdGhCOWR2eGR0SkVhR0xvNXkvYXhsdlZjWFVMOWpMWjNIOFZsNGx6?=
 =?utf-8?B?bEZyaVMxNHJ6OVI2KzJzenFNaC9GdG1UTUZIclFsMDg1SVhGUEZiQ1ZkMFdX?=
 =?utf-8?B?YWEralZFWUJSNDRseEVNb3krKzhhUFVDdExuQ3M0SVZVRUYxQ0tFL1RZbSty?=
 =?utf-8?B?WDNXdVgweEFETkdFZ2Z5V0I2SEhGZ1hoMmZDVXJJa25zZkZDaWxlV2FXNk9v?=
 =?utf-8?B?cUJJZmhPMC9JM0hRcEhYWG9LNzV0c3pwNEdoZHRyeUxpNW0zVmRkZm5BbXhK?=
 =?utf-8?B?OFdsZVlHMkZvSUx2T0dnL0pKN3lOeFNQVmNwajluN0Y4eWcvOFIrTzZ4V2V2?=
 =?utf-8?B?YkpFbEsyemRhbUdiRFREa0JwcWRaZEV6Rmp3SXcvV3k2VVpZaHB0NHJtVlhN?=
 =?utf-8?B?L25iRG4vNzRLWURwSndCYmk5Qy9XNnRUVDNQYTgyV3VJLytyZlZpbGM5a0Ft?=
 =?utf-8?B?cXBzeHp5cFQ1WVV4ckN4eGhpeUNoRXREVWFpazU4cDQyMU1NZVVZcUpZcUhl?=
 =?utf-8?B?RU1HVHRqdWFqOUFaSk9mWk9qWndPODlTeTJnV0VYR2wvRkVYY2Roa3VNVS9W?=
 =?utf-8?B?NWYzaWt5YjdVbnpKTm1jRWRJdUFDQXRDb2RaMTNmYUlNaTkvcUpKU3IwRi9v?=
 =?utf-8?B?UjZOODEvK0VMeUZJbkFZSnlCUEpNSWV6UkZETHU0N1dBNUxMNTJvaVhVdU1M?=
 =?utf-8?Q?jMV2XsyMLR0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6054.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZE0zSkRmMlJLMHQ3ZW03eUtwSHdFaVExK3RMQnMzSThyaTRUdGFMYUtSanUx?=
 =?utf-8?B?dUk5anN3YW5QdjNSaE5FSGFzbFJIVU1SdGlCTW8vT1FHU3lSTmlxcEhLUmdh?=
 =?utf-8?B?dklpdjkwMkRZaUxTVnRUbXovRnNTR0FFaTBuVXlEdDIrL2VSSlBhTFRoWWNt?=
 =?utf-8?B?UlBkTUM0aDlGMjZMUjVxc2FVSW1oTDNxTStoaFlpTWZ1Ym1SYlZaU3RDYXlF?=
 =?utf-8?B?Y3BPa084dFg3Tld0WHAybllqMlozNWtjYWgwYmQyejRBYnd2NFdNY1BuWEU2?=
 =?utf-8?B?Z21ka0k4aG1tcWxqN3BwQnNGc0pFMTl5bEpXK2F2Zjg1Nm5nMTJYQzVucnFM?=
 =?utf-8?B?ZHFzNWk1cmJaejJDUXZOYWNiN1BLUUhDamMrdHlSZkhUWUs0cmNTK044Z2Zv?=
 =?utf-8?B?dzlSY1M1OTNTM0l4Z05CUFJCS2FSalZ2UlNPQUhPdmpaRHRDS2Z4VndVU2w1?=
 =?utf-8?B?aEZYMmN4ak9YQVBlQy9DeWJQb1hIZzNsYWhOVkhFd0tWa3J3MU9aa3N3TXBU?=
 =?utf-8?B?K09qQStGUU1hVEtHSG50S3graUpzNWlCM3JkV2JlSFlZbC9KWDBHdWkyaGZq?=
 =?utf-8?B?cXlPcjE1UitHd3JMS1lxcUtoa2tYcTkxSXZ0d0JSL3Awd0pBNStpQi9YUER0?=
 =?utf-8?B?NDRsZ2FpRmtTMlZLK2tZWkVmd2VJMWFYWEFFNXVGQVFmckhxUnVxMzhFOC9u?=
 =?utf-8?B?aHdmWG5tSVhneE9kZGEwekZsQnFmOC96d1QyaCtFKzQvNk1ZRUVjM0ZkZWdH?=
 =?utf-8?B?bzE5WkRCa09LVkZzWWN1dDdDaHhod2F6T1B2YjAxZ1U4NmlMSWR6NnFQNm9l?=
 =?utf-8?B?enBFQ1Exdk9DdWFuYVg2NkZEMGZGdzVsYTFYSzhwbzhna2k5Z240QWl0SFR3?=
 =?utf-8?B?VjNUL2Q5Ry95dzFCc0dCMnZTVndtVXB5S3NMUWtMSGNQckRtU1dqWVZxQWdW?=
 =?utf-8?B?K0hEaUR1dTNBR3d3UjQxbTJqTFRsZ3g3TS9GU0VMbkp6Yld5SFRNVzVGRkxM?=
 =?utf-8?B?b1FHWnlOb1BVS0JseWpvL01yZ2RCV3RiQ01PVnRuYUoyTDFqby84T2lKWHF1?=
 =?utf-8?B?NFBwcHNQNThCUVhCaHpTV2JObmxuRFBvdDBQV1ltU3dYNlhnNjBhQVRyMlRp?=
 =?utf-8?B?UXA3TXJkUkdJblU4K2RKMFdZckhXa1liMktQYnlSSEJWV1ljVm1PR25tbElM?=
 =?utf-8?B?MnZGYVB4T1Q5Z1d4UFRobzdRelJ5azAxSXJtZndnQ3FOelVEQ3hQa21WNnU3?=
 =?utf-8?B?MmN2dVErNHkxT3hlTWdqL2VOZUpQbzlBOWU3bm5PWHBIQUsxSDhwb1JVQStL?=
 =?utf-8?B?OFhNTE03Z3gwR1E1aUtjMHRlRjFFeitpd1NlbUllcjNDUDRKQ2FHT3Z5VFJn?=
 =?utf-8?B?L1o3NlBRT2ZvMlhteWxiOUE0a3pNTGFIVHUxT0tScGt1VUhPOWtjSVVUZmVI?=
 =?utf-8?B?Vzhua2NvYW1SaHhZYkJuWHI5ZFJGSHVNTXFmcm1GS21qMXpSOStmbGo5eW1Z?=
 =?utf-8?B?VzNaY2RrMExhb0M1WUZXb05WMlExdS9ML29GMTVPa2VzQ2pSWmxVck42dTIv?=
 =?utf-8?B?b3FLTVB1d09ucE5BRDRENmprdjcyR09OYzgvdHNLeGRjdG5Hd294VGRuUTNj?=
 =?utf-8?B?eXAvN3NydWdDL0VJQ3pQVE5uZmxPUHFtaEdhNEdJbU4zOWZqY2czZzhlaVdX?=
 =?utf-8?B?cWFOdFZud1hUbGFyLzVYUWlpb0lxWmVYcXkzWGk5Z0xQM2xaUHV4U0pHa294?=
 =?utf-8?B?Ui9VZnBaVVlGU0V5Nk5qNzB2S1daRDdiL1pGckE1TGdjZk5RNDhDU056bmpr?=
 =?utf-8?B?Y0ROZHFRNHhJMlFtQkV3a0swc2N2SmI4WXpHcyt4dnZKeDdCR1ZnTzlUeWsx?=
 =?utf-8?B?MEJ6VlQ1dThYOGtReVllWUhZS0ZnV3F1VDlObi9Tdm81WFl5TThVblFqdnVV?=
 =?utf-8?B?VHlGNlBYWHg4YVJTUGp2TFc0MFlEUXlsZkRPTG12TFluN0FRTlpvNTlQV2ti?=
 =?utf-8?B?SGxqL1I1MEJpcWphdkRxdGh6NnRUYzEvcGdySVlDZWhBN3RhaHNLejY4QWsz?=
 =?utf-8?B?d0FUWlhLSU9lSWxtamJIUmVWNlRXTGtkbjJ2YkxtcnhCVFR4enNMSnlPaHB6?=
 =?utf-8?B?YXV3SXVPUnlxYmRCUTgzMWJSa0R0OFoyR0QyemVSd3JoK2czQnRJazBoaTBo?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b72a532-2a33-443e-c078-08dd8187cb6e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6054.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 10:23:59.3279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbE95tTuwitgyaSl4beKrz2ynaZFMO2XuWxQYmCAV9yH+RqCqtimCFpL3A3Yl8jteIwX38o/f9c1uUHQ4tpYRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4794
X-OriginatorOrg: intel.com

On 9/04/25 10:26, ziniu.wang_1@nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
> 
> Calculate data timeout value based on clock instead of using max value.
> 
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>

We overlooked that Haibo wanted the "bit[23]" comment dropped,
but nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> v1->v2:
>  * Added SDHCI_TIMEOUT_CONTROL to esdhc_writeb_le()
>  * Removed esdhc_set_timeout() to use common __sdhci_set_timeout().
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index ff78a7c6a04c..a34cabee5916 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -870,6 +870,16 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
>  
>  		esdhc_clrset_le(host, mask, new_val, reg);
>  		return;
> +	case SDHCI_TIMEOUT_CONTROL:
> +		/*
> +		 * ESDHC_SYSTEM_CONTROL bit[23] used to control hardware reset
> +		 * pin of the card. Write 0 to bit[23] will reset the card.
> +		 * Only write DTOCV field here.
> +		 */
> +		esdhc_clrset_le(host, ESDHC_SYS_CTRL_DTOCV_MASK,
> +				FIELD_PREP(ESDHC_SYS_CTRL_DTOCV_MASK, val),
> +				ESDHC_SYSTEM_CONTROL);
> +		return;
>  	case SDHCI_SOFTWARE_RESET:
>  		if (val & SDHCI_RESET_DATA)
>  			new_val = readl(host->ioaddr + SDHCI_HOST_CONTROL);
> @@ -1385,17 +1395,6 @@ static unsigned int esdhc_get_max_timeout_count(struct sdhci_host *host)
>  	return esdhc_is_usdhc(imx_data) ? 1 << 29 : 1 << 27;
>  }
>  
> -static void esdhc_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
> -{
> -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> -
> -	/* use maximum timeout counter */
> -	esdhc_clrset_le(host, ESDHC_SYS_CTRL_DTOCV_MASK,
> -			esdhc_is_usdhc(imx_data) ? 0xF0000 : 0xE0000,
> -			ESDHC_SYSTEM_CONTROL);
> -}
> -
>  static u32 esdhc_cqhci_irq(struct sdhci_host *host, u32 intmask)
>  {
>  	int cmd_error = 0;
> @@ -1432,7 +1431,6 @@ static struct sdhci_ops sdhci_esdhc_ops = {
>  	.get_min_clock = esdhc_pltfm_get_min_clock,
>  	.get_max_timeout_count = esdhc_get_max_timeout_count,
>  	.get_ro = esdhc_pltfm_get_ro,
> -	.set_timeout = esdhc_set_timeout,
>  	.set_bus_width = esdhc_pltfm_set_bus_width,
>  	.set_uhs_signaling = esdhc_set_uhs_signaling,
>  	.reset = esdhc_reset,
> @@ -1777,6 +1775,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  		 * to distinguish the card type.
>  		 */
>  		host->mmc_host_ops.init_card = usdhc_init_card;
> +
> +		host->max_timeout_count = 0xF;
>  	}
>  
>  	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)

