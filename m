Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDE039EF2A;
	Mon, 24 Aug 2026 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787557527; cv=fail; b=Qq4ysmjTfmM9A/Ln8RrQewM44mmQ3lEsNmBK8E9Ulm3u2oc2BGxtGXyelYO7PeEmPlpvtBBhlLYcF3KzMjHkoYJ2Zq58m/DGBZj9XRGfl8hXdrELz+GklDf2N7e4IfLgQpIU30o2i09pSvhiaZfB6xaPOtICw89b3fuEccdWXTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787557527; c=relaxed/simple;
	bh=uvycw6EAL6orsncf4sAcPiIRuc6naKJzFFMnk2VDW0o=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CjY6H2trHXCWEIHA2auD/g9tjn2Pu6CQFBwHQQdR1zHfgowpZYRvei5Bg7Epd4ObKz41yBFBF5l/xkdduMhMiiz+l/cGFbplrIyFBJEQQ5MzfgG6Ck+xYVasg6XmT5sPDXy0M4JmzFzYJY+gHQ8RX+8JL93Mq+olVLkA0bhf7PQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqZ1yCMy; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqZ1yCMy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787557524; x=1819093524;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=uvycw6EAL6orsncf4sAcPiIRuc6naKJzFFMnk2VDW0o=;
  b=lqZ1yCMyCRQZlCtEDGv4rRLGY3TnLlvHs5o87fC9zK7uz6NQ2PqDxBLN
   EvJ8vlz2W5cQJcfA6yuAWKxjDzgx4ktEFAzlBIBVDPRldQaBpGE+13bzv
   mjqdUyN9GiStmyfQiL238Zx5UCI5u11gqV6Pny7BS6cMboopV47y2302C
   ISA8qZMrGDpvmOfKRrP6Idy9fWbXAFtKByDh9ACiGD8b3th9CrSztArCe
   YeUPxqscKIDsniYaZo/D/lTpxBIUiqlAzgITurgwARwsZgHw6LCd1/q5x
   Ns8fvdGJbgpPuDT2bdC8aTMksvJRkxz/+QQMtHhQrfmVYCBVuzx3f5Df8
   Q==;
X-CSE-ConnectionGUID: 2KDFA1HdR2eJZkViAis0jA==
X-CSE-MsgGUID: sxEWBvTrTTG0gN19srixeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="88202899"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="88202899"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 00:44:06 -0700
X-CSE-ConnectionGUID: XKAZ8z7OTE6s4GUv+OHIyQ==
X-CSE-MsgGUID: Wcw90xQoSJupsVFcgtpWFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="266398708"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 00:43:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 00:43:45 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 00:43:45 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.44) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 00:41:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjjVPUZ8X07MkEeoATevHTmzSi55WIcKQusb8b5PO7e3rK+etaCNNhAygTsrWZPlIqjcEOXV7ffMb7QigF1VVtlTjOpmVAhxzSdHsUgBVNrB07TNOyzmU/0rFbh8CmhT84xdbM0BQWP/vlh6QXjnUrNfk/HqUG9zM5n9blexfaNubQ1OY9tM64wiCAlxYzhaqkW88AfjJf3/OSS1RTtfPOjSbu6aMENRYjXGP50UiROMM4gIvkLqxhdxvHhA1herUnBRxkdtUoT4A69+HQNR6bxrcFptrdXI319bYTNjySH6LxQrZjEWTfPxgI2RDDWXLtsrL0KmUGaITedJoFO6gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zP9WTIVnBCZNflq+Fb8J/uMZZzVlpbCt2xzgrBR/l44=;
 b=iY6uFN4eqAKjU9myLaItis2bn6qRcpIFuK8tPRMzEX20DXlwjd+WB+fG07QJAvzw5ku8lOPP2slBPl0q+khzsWwqZPg61VaDZ3P+nYbUlR6G49gSEtRLwBMp7yfB+w5PsIX8BaeUCDT33/As26fnsvqS9YAAtUdTWqknFcxQsLIkZLMZsQX0+zAg4c/95nETwgcPiu7Dgzim/BMxVErgPOMCBPcr8KNfIjT5Yb5owCIi5wwjxpaTmoVOhDqckCsFW9fHXvPtwvCYv63p46SWX3AEhHHKtfuBMl53znm4J/6rZ1Yb0rdHDDrwp0f5DG3D85HIijjR6zE1Uzecyy/gUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by MN2PR11MB4757.namprd11.prod.outlook.com (2603:10b6:208:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 06:20:55 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 06:20:55 +0000
Message-ID: <dfcde50d-2ea8-4b7e-b140-9263d43d288b@intel.com>
Date: Mon, 24 Aug 2026 09:20:50 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-s3c: check clk_prepare_enable return in probe
To: Jiawen Liu <1298662399@qq.com>, Ben Dooks <ben-linux@fluff.org>, "Jaehoon
 Chung" <jh80.chung@samsung.com>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <tencent_76880DF24877C8490B50E7D7BC52A55EA105@qq.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <tencent_76880DF24877C8490B50E7D7BC52A55EA105@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0227.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::15) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|MN2PR11MB4757:EE_
X-MS-Office365-Filtering-Correlation-Id: e779ae80-0586-4ab7-16c6-08df01a7dad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KoB2oF9lCJ5Xf0EL4UB5bD9DgSmMD6gdFu23jfhefhc5zrwodCL2IYUQFuTwG01OxgUOM3kMzmN6flsZwy4ATNtONgHBhlRB+W7RdsEboXKweAB18oASvz9QcShL1oXHssflP6Rt/4DrkGi3aVB0YC+tSjdGbwLFRo+w3F0OzraDBLXmbiXWa98w/ncI2LXZFhvdelVGYCFa8gmzK60X95LpEB2bnPBesQYCptQPqLpER07Dz3JPaIMZmVYSLHEgVBYaOczSKNmjjki1xy7bSBwJjDx1P4xoayNe2oXjKTmwxXzgN1I9yej/HpPQMKnX6zuRq//TpFX4eXYhn62N4vZ3My3TVetAtCmwC8knmCKauZziSE+t8AQ1FcrwU0cxcow8c8e+Sfgd6QhMnc6iQD928YMU329x7TNPr63747PbZYnyr/mh3xLnyfTtuP5Hp9EgMXbCbyVmXlzSZglKHgnwr+9eNQsqFo02CwtnlBtWLsdEyX7YGCYZeG3f1MkBF5670zHmIzzroJRjXw9W6o07wzJJcSfDoIZubvZDshvxZcGTse+TULGLZbxBHEzKipwj+Kxwn4EJMnzVkie39C0FTLQyTVWAtvn5DuT1vf4er+h04k3jRU2nfzBwyrQKuuM54r9r6xiYThrxkSMGvYRKoflALW1FebRDKsn0FvE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGRTQmdPVmxqRndYWm0yRC9YYXJEU0dKZi9vV2UxQm9ERVo3N0FpeUlodlJl?=
 =?utf-8?B?aHVBbVRxV1NtS2Y4OFl2akoreDdZR0ZpdkpYWG9PQU1ybGI5d1cyOThvdGlp?=
 =?utf-8?B?YXd5Z01qV0pGZzlCNHhVY3N3QlZ2Y0k2MkwwM0c0eWtqdW55Yy9tdUZuQU9N?=
 =?utf-8?B?Z0tSTmc5VWZrL0lOanF1OVRKNEo3dWpRakNxUldLYmtQaXdIUVFINndGRy9B?=
 =?utf-8?B?aitGTmpGaEJnd1lEdUFZbWIwL2piZWI2TmZ5bHhWOGtpWVhEN2Y5VW1DUDEr?=
 =?utf-8?B?S0Q5U244MTBjODFQQzh5aElZMkVDNW9UdjhVVjZQcmZyclFSNUdkelVpNnN5?=
 =?utf-8?B?bHpzcnRNUCtTNUwzM0RKbjZvZEh4WExabjR4VSt4cC9wUU1ObC85S1JZWWwv?=
 =?utf-8?B?NktDMWlyeERWMmMvOFQ1SmlSb3VyR3hQZm9jcllpNFVGTXBtNXBaSFdVVEw3?=
 =?utf-8?B?T25xbkxCVS9jczBvYXlhUEhhZ2svZHFIdVE3Z2puMFJVQjRnMmkvd2VmYzhG?=
 =?utf-8?B?bys1ODhnS2FkaUQxUVBaZmVVQTJZYnk0QkUxNXladUtSc3BJam9tQkRNakVv?=
 =?utf-8?B?b2R1NnBBZkZEV2xIMExJTW1mY0lzUnVVaDlKNUdSdUF5SmtLNmVIK0JOMG5V?=
 =?utf-8?B?VXpET1BORGdObHZhSFBGV0liWXRGcU4vRldLazVIekJvSm1odUlYV2tvTkhR?=
 =?utf-8?B?UmN2TllyM2lWcmlKcUYybWt0SWIvM3U0RzhGa3FIaUVKRWd6Vy94dGFiaHh4?=
 =?utf-8?B?WE9JOGtQNDBMVXJyTWkrZjNhOEZUMUlZWU53aDhEY280VlVMWXV2QlhRaU82?=
 =?utf-8?B?N3BQSjcyVll6S21lOWk3V1RvWHpRWGtCM2g1c3pkelFlak9MRW9OUjdlNFFH?=
 =?utf-8?B?aEIxU0R2UlZJVVpkRzJsdHMvejIrd3QzSk10Qk01T1l3RXh4TlQ5a0F6WUpJ?=
 =?utf-8?B?bjB6OTlvbDkvV3RMYmRGL3ZWc3dvdkN6OWszek5FSTJWZVdhZlh1OGV5T3p5?=
 =?utf-8?B?bWg0ajBhMnRLeDI3TUJJelptWDI1ckg0RGtERk5PZTdXUVpHSExmbWhEelhH?=
 =?utf-8?B?Um43TTBsVitzVHdhQXlYYTYwOFc1SjczcW9uZGJRa2ZwMFpjUUJLTTBuZHh3?=
 =?utf-8?B?aG5jVncxbmU4LzdrcGM4WVZIbGMyQnpzMitDREZ3VHFoSXdKNHIwNzkzZGIw?=
 =?utf-8?B?YU9CRWNCSzdxbzZnNmYrZnlQNU95S3pMbzREZUdrR01UMkVXQlczdll5Q25F?=
 =?utf-8?B?NVUrcUJBSkpubDI1L2JRUHV0OUx0YW1GUGRIdGFpbHc0VkJXRStwcFJ2K214?=
 =?utf-8?B?VTEwemlJeGlYMk8wTEZIUHE1SFZPZGQzYWZPVExXRXBYSGRtMlFINTJUbk5F?=
 =?utf-8?B?SUxIb2JONllsbHhvbUViMGE3cmJ3YzVwQmZ4b1Zzb2hGbStKWXBNakdZNWVB?=
 =?utf-8?B?TWtTbWhJQnVtNG5VSFVkSVFXMnV6TFd5UWlyOXZucmVHbWFBVzM0OUJJU2Jh?=
 =?utf-8?B?a2xHNWNFUk05VSt1S045Y2l6ZXAyeTFJcTN6Y0RPSk1adDdkVjRJOG9sWjEx?=
 =?utf-8?B?ZlVZWlJuQllwZDVwYURxTytZd3g4YnEwU2NSY0ltM0tWck52T09JQ1VlaHNH?=
 =?utf-8?B?NE9lK2JsRWpOZ1g5V09ZM2VScG9KV3FtcSsyTkhieCtyT0RjWHJmVkZxWWhL?=
 =?utf-8?B?dFVWejFCYWlKT0NtazJqYk81MElYM0kzUGlabDRPSGFUVmlNVUR2M0VTc1NG?=
 =?utf-8?B?VU5FSjd3RStTampEdzlMR2VoUEZXbUM4L1BKUFNhMFNYeVkzWEhnLzRyN1dN?=
 =?utf-8?B?bWh0Q3M0aUIvTlFPWWp6TGJseUJLWUdjZkFGbjNqT1dQZHQ0QWNqNkNSWmtE?=
 =?utf-8?B?VHhpRmUxWFhWdWdIVVAvYmg0SHNZemZTWFZ2R1RFank2UXhhamYyY1hEVWQ2?=
 =?utf-8?B?OG4wazI0UjN3Mm8vRWl2M0I1emQ5OHF3QzQ1UEdlUXl0aEVMV2ZnS0R5b3Rx?=
 =?utf-8?B?ZU9oeWltTUg3aWVxNGUyT1lFRzVjZm5PcWFUNVg1dThuek9XS2xuWFRIK2RN?=
 =?utf-8?B?YmI3bzhWRFJhMS9jbUJ0M0JwTWRBRzRqejk3ekdsM2lxbTRyejY3V0dUTWY3?=
 =?utf-8?B?MHFIVzQrZEp1N0UwODBDa2ozRk5WU1BjVm5tY1QzZHFzQ2pMWGVLMHlrOTF0?=
 =?utf-8?B?WkwrcFlUVXJqNVVyOXMzbXIzaWFDRjVCb2dMWEFMOUZpNWxMSWY4b01oQXN3?=
 =?utf-8?B?bG11andYYUZIN1kwcDNBL2VuMUY2dldNZXA2MElDUkNpRGMxb0xMS2dYMTB0?=
 =?utf-8?B?azZraENmS1lYVUhHMG9OTnVrdlU0NHFxVjRid2NwbWZKMmlZWjROTWc5bnEz?=
 =?utf-8?Q?FalsdirU8p0QOI3g=3D?=
X-Exchange-RoutingPolicyChecked: westc7gNs7PbMSLfwdTxdrQ1D5tOOS7XtMmyOL3wa5Xq6bySTvIVCBuZ6pkiHtrg4e4eiETTWhFwa721pY6Csw5nDjzVmfUQycSpUdK/zRGsKTeZFWhbUMiXoxqwH7eYwRORouvDB1X5wqYjGciXTU6aVcy2V9qxPkmzN+Oho4Zm9vhzPgsSXMiPDptn808C+yAoLO0sZpINtK8QTYLL67FNEzsox3Q2ouKcvAD7ltLzh2s9c8FxPB6D6ivdbaDGLQUNu44wMIRExJfrTx9sjhY2wadHe/qy+Sl8lvyrJf5avIZ+yUrzCiU14uasO4HL1q0YIkPsoy5Jy8VF1P7ZHA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e779ae80-0586-4ab7-16c6-08df01a7dad1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 06:20:55.4549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1hoeE9pFOyLPg+mBKLrkERm7APUl9/v3KEyyzFPciQqMuG41E4kBhr/i+hGgXwXvJcK0D3NWO7h+cP09fiSYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4757
X-OriginatorOrg: intel.com

On 18/08/2026 16:07, Jiawen Liu wrote:
> sdhci_s3c_probe() ignores the return value of
> clk_prepare_enable(sc->clk_io). If this call fails, the clock is not
> enabled, but the driver continues and later calls
> clk_disable_unprepare() on it, leading to an unbalanced clock
> disable/unprepare.
> 
> Fix this by checking the return value and propagating the error,
> cleaning up only resources acquired before the failed enable.
> 
> Signed-off-by: jiawen <1298662399@qq.com>

scripts/checkpatch.pl says:

WARNING: From:/Signed-off-by: email name mismatch: 'From: Jiawen Liu <1298662399@qq.com>' != 'Signed-off-by: jiawen <1298662399@qq.com>'

Please adjust that.

> ---
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -534,7 +534,11 @@
>  	}
>  
>  	/* enable the local io clock and keep it running for the moment. */
> -	clk_prepare_enable(sc->clk_io);
> +	ret = clk_prepare_enable(sc->clk_io);
> +	if (ret) {
> +		dev_err(dev, "failed to enable io clock\n");
> +		return ret;
> +	}
>  
>  	for (clks = 0, ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
>  		char name[14];
> 

