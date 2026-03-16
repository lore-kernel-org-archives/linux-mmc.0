Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67E137BE6A;
	Mon, 16 Mar 2026 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773653709; cv=fail; b=mHlcIrtRZAmUdstBxs5cUkODstazAyb2EyM/AxU7kCcugSAl0fugVWqE7s5AopQMqGBQz27Z/AGVD32Ce4ZUPZahbOHXof9WkZXxaIsRhWCjoWOSm9b7YipQYxggaOXfQ0MNR56Nn72HEjfGzzztumVRd7uFA6gIpaRex+EzbE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773653709; c=relaxed/simple;
	bh=1HcQEd9gQNgFL9I3W22eKKUQznCMiofwPK+peupcBPE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uozm7Sv453EN7V3rCAFfEto0vufv7PtpaLdU0xLxGxr7gXepki0VJ8y3PryTXHeIsSsq8LReSn90PhK/XeO4MIChY1IiTNXLGhsR5S9MZPemIVTrkEMH8vcuMZXGz9Y03dgM8iKFbk9vRbxh2rnHYSE63NyJAtlBSHcnomCaxBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dfj70M/G; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dfj70M/G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773653707; x=1805189707;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1HcQEd9gQNgFL9I3W22eKKUQznCMiofwPK+peupcBPE=;
  b=Dfj70M/GKyFKRsejLSw2Iko8g/m5f9SE9Hqh/ao4wenzQGhM46/qF9eo
   g3upGXlEYivFsZ9r9znynaK2F/GxZBIJ1LpDMq54AIWqy0359GS1dTVj+
   FPsbb181uIG3mXojY39n2YtGDa3HuekH/NvC2pwGfpD1q/svZt3SadwCJ
   2vuoWSs8SqjjF4yJRqMK5D/Xf8Qncs8rKADSM6DEKEJEZnynieb4OJBDg
   CvH00FsE76JlLS/H6e5oS2ErEAG2BwioWGB0aZgWlY9kxyqiGSCMMG0Y8
   lpl+gZJlZfnyyqtUezbQyKYd5afccoVeYZC16jp8Kw8QfW+6fdjZQcZ+/
   g==;
X-CSE-ConnectionGUID: 0GL5B0yaSmujkS4GhKiafA==
X-CSE-MsgGUID: K5tToJsVStSDlBftqEJMwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="92233108"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="92233108"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 02:35:06 -0700
X-CSE-ConnectionGUID: olTIGRsTQcGKcud65rXjEQ==
X-CSE-MsgGUID: viLtdvF0RzGMvxjHWCxoPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="221943757"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 02:35:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 02:35:05 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 02:35:05 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.48) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 02:35:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ek02ZOJViuuikGF/1oF+hHkjsybhjxS8QkZbIygAz1Cbr+al55lLLQrFS4zTr5WrId8EApQ5KI021YArhTgBmsXCSuTJfYxoSHaLGlVNV9Pqh3QVvxwJIXZ37Sm7KqsvnKtDNQb/bGxnuWhElF6fBjqOzZzfhfelWeoFYhVcyY/gCwtaTyUxpdBZ0aA8K0JZE3XaPt4WIy6qOrbWn2PpYe4upceE9EuXy04KKeN45dNSXEn6M7/eyfdyM/Hx+lXN8bxWEobfYpJf1PZQFlUrDHgad3DTOG6GZ116nIw7MdK3b+geOGn4GonP2wUqNwxtEXxJTXkqOFlKBN03R3CtNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDkmsXSMC3KdO4O3U8jDaRo8MxZ67RfLHrybyq085gc=;
 b=Ex8qTUdrutwZ58V4W7blrlYZUfl4BtbA23r89F1jcN4wQIjk5q/NtVth+IMsrjuXKzUzBRrt5ArlGWGWMIeFU+AZEsLOmNWTGMpKD1oXCwjhRGKlM6HqTQPNDWK+XnwgcJWGYmh1A2+zvyur/t6BWfuYc9tcBCXpwiIy5jLYcBdgpTvJhr03NB32WFrc6GS/fk11EGQHE/6LewsSxJBq4y/gLkMF78wcZP31qsSGH5X79w97YG9xN+/Y9k7Oqb5KA1/QlUDlLcyBYTZVoZ75vWJahXNIcwHEDT7wK7kFMBXxGnGYbo5fV8UJiW5hJgavRXINRCY5q3jj9PQ6KEQlAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by MN2PR11MB4567.namprd11.prod.outlook.com (2603:10b6:208:26d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 09:35:02 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 09:35:02 +0000
Message-ID: <d822d905-f956-42b4-8441-e5c786d326de@intel.com>
Date: Mon, 16 Mar 2026 11:34:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] mmc: sdhci-of-k1: enable essential clock
 infrastructure for SD operation
To: Iker Pedrosa <ikerpedrosam@gmail.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan
	<dlan@kernel.org>, Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Javier Martinez Canillas <javierm@redhat.com>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com>
 <20260309-orangepi-sd-card-uhs-v2-1-5bb2b574df5d@gmail.com>
 <a416dc43-58fd-4462-9ec5-b3dadbbacf8b@intel.com>
 <CABdCQ=PeB5hhkk3eO3Mu89bb7m=4ccZrwouuZScGOTHwN5owQw@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <CABdCQ=PeB5hhkk3eO3Mu89bb7m=4ccZrwouuZScGOTHwN5owQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P194CA0026.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::23) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|MN2PR11MB4567:EE_
X-MS-Office365-Filtering-Correlation-Id: 01f0f8cd-f420-460a-cbb6-08de833f4c36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: vAitGOOH2nDDrOzQC7eBYkEPwadS3Ss6CuqVzKGyeFs3H6fmcem31ePQ0GruJKQ60W49O+spFYAri3OfkpdxEtTXeeL2zTbDtgNOH/bvYuwYnuTUUvyfUZ+RTC209Vhu509+dlJImZVY7fb16nv+N6SeKgc3j9clXsnb+Mkg2psWR700ZhIBzWrZscJkyIDDZiJKTPcX4zsgpDXTNSlCf7gmx022aoJ+EIOwmd9QhCko5ZnSlfxnSdX0xmXP3mPrI6xprTzoYDDDefJS/BiQlGhGlWY0KUmeqRZMFNgguEOF2SN4sc3QGVqaz+2UJCLb+UBpIP654+cSeqaKcuQEuJi3HR1Lw5qky9w9Dk1mbaqZgup5gYn1tGDS0wkdoSzEjVwcxYqZV1sMVm/5mPzZVausJyJ0dbhWOQVW92BFm6MTPt5DHo4DQPVp/4Kr//vKHJ83lVWs8/jnhcxUHxJ3PHH/L1i0A83I1VyFpOlNjeid+UiWFK2cNtNPf9CwYiXnxa5S43oJmmdG4e4xv4TeXQ73Ks5zws6GttNQcMzpIhjKevq088h3U+39iTQAmnvruuIDux5m/l/u3tEUwOc9XTwqvRhYfk+Srn09JwkxeDMGD0qRm+HGHfi3Tjvn2pIE1QOPmOfdk+P1pcnmpJK9OA015hoqSkADNSDe+qn0l2ZddZmLmzBLd9dCwoK3Opz54ywcGRmSiqFxHzqrvxdAKfhGlrVA8cGusYMB5a/CA5ViceG5H4SgMysPeYdNzylN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmRUMGRoMTBPUEJZYU52YzJ0L2FrVzhiV0cxbEVPQ1o3dG13c3JROUdkeDhw?=
 =?utf-8?B?aG5KUGVHc3ZFcjFuYTBMcUcrb0x1dlkwZWpnRGJFZU5GM3hNaGl2cFZEWVpD?=
 =?utf-8?B?TUU5NEE0bEY1RE94UXdtdmVkUXZjaFZCKzRqTU9hSEt1eFZpcW1mS0FheVRh?=
 =?utf-8?B?aXVyU3NMc2FUMVdGcmNkQXBVUWFwU0FVYnE2Unh5ZnF6Vnh0R094Qm9mOE51?=
 =?utf-8?B?bUJ4c3dWQmNmVFdkSktHeTlJelNqdDI4c2hjcGpUWEgvS1ZJOHNyM3V4MXNw?=
 =?utf-8?B?TEwweHlMeGtRRU1TNTdBc0ZjR2VyNGozWE11SkUwdS81OFBLNDQwSVFYdTNF?=
 =?utf-8?B?NHZXdkU5UnRlKzlqVjAxNVFXbjc2aVV5Mk42VUVmTENOU3JCY1FsQWFhUUp0?=
 =?utf-8?B?NEZQQ2s4alBKcVlrNTJoYm44ZyswS1NDM29Ma1UrNnF2bGpHRkZQSWlwaVFC?=
 =?utf-8?B?WnM3dFU5M3V5Y0dZRXFDV1lxZU1adTYzWlZiR3hXcWNTZGd5VTMvVnFxVkhG?=
 =?utf-8?B?UFZBaDZpNTl6RVd4SFE3clNqd0Rub1RMUzhHeFE4STltU09RS3RrTExaVTRU?=
 =?utf-8?B?cDdEOFdWeEFKY21teVQ2Znhza1dtWkNvZmhUbW8vSDRTampDYUs5eE9BNjJl?=
 =?utf-8?B?NEpJQkJvNFBYYkZlS1JJTlNOYVJnRnlweGlRdjhJek55S0ZiVzI5OWhqaDZE?=
 =?utf-8?B?d0tRR1o4UTdpdGg2alhlTS95SWMyOFNuK0ovZ2ZrYlZ0SmhLbVFtTFNab2dn?=
 =?utf-8?B?WTd5SU1CWTAwUExUVndTUDdiQVFFNDY4NmtEUWtwZzE2eDVOazNlemtrdmRH?=
 =?utf-8?B?R3RGOCt5U2JQUHN5VFRVMUVhM2EyRmozRytmZmRaVkNIM0RBY2RjTVFuaXlm?=
 =?utf-8?B?b3VIUS8xbEtnejV4blNiSkxFZ2FEcnRIbzhLNkQyb3hXT2xLMUtZRVp1TWRy?=
 =?utf-8?B?cWFkWFdIWk43d25DcVFZVnJyU2xSR1c0WFlCeThtMElSdEVFdTRVNkRlUmR6?=
 =?utf-8?B?RDRjbTdOVHdOQ1p3R0NDQlpaZ1ZLRnJKMFVrNG83MGFrV21UMWUyN3I0SGdR?=
 =?utf-8?B?WTVPdjVUWERVdGo1NW82TmJLZHhwakh0ckQyRDFWKzY5L3R6TXAyQ21yQjRW?=
 =?utf-8?B?cE5uQW83cVRNUUVIVEtPUkZnTGQ1dXZOUUF4QmNrYTVHT1JyQXVDT2x2L3Vp?=
 =?utf-8?B?ZjUxNlkvRFJPaUFUcEV6OE9uazZ5U3M2dEdWMUdzQWtJS1hHc092NHlubi9E?=
 =?utf-8?B?dWVzVkVIak1qK21TQ001S1RkNlVVRXRJTzhEd1Z6a2FFSzdjclNic2xzaGpQ?=
 =?utf-8?B?cXFMUm5SNktsaWllbFo0Q2lwVTN5RUxMUmR0M08zb3o3c3I0dHo4QXVBdE9p?=
 =?utf-8?B?dXNWRWh6ak9vUk1xTFgxODRZRUtBUWVYRGNzSVFBdWx1VFpGOTRydGxTUlBo?=
 =?utf-8?B?TXJSNWFUY01DSXlKbzJEYU11UXFya29Ed3NVZ2xac1dJR2JZWlQzTDNyQUQv?=
 =?utf-8?B?ZzdtMjkwQmNjV0lhZ1JkaG4yZTU5M2hFai9FMm1BUGY0dzhlaGtxbTJETkxo?=
 =?utf-8?B?QkhMN0E3MFV5NkJyYk9KNTVoRlFHNHpOTVNoMDZ6a3hwaUZ1ZHMxblJtNmsr?=
 =?utf-8?B?N2tuTnNRL1BGL0V1QTFDOHZjdXl5blFZbjRERSs3cGVwK2JCSFNwQUFZNmYr?=
 =?utf-8?B?M3A2MjFpVjIwVkNDUGxaenpHVXVpRE9hM3BLMUc1QmZWMFhCQTdGN05tT2Ny?=
 =?utf-8?B?akdab25SanZWQ2duczJvN0J3dHpXNHc3YnIxVHhEZ1FEUWZucHZYd0JUUW9z?=
 =?utf-8?B?UnJSMFRmdGFNcXRnMVZGcFhhWk5Xb0FROFFBb1VCRGk3dHNSaWRUS1VDRWpr?=
 =?utf-8?B?bWxHUk1LN0dMZlJ4UWtUS2JQUzh1dWc4ei9oTU5qWnBxRW1lM2NWQVAvRmpn?=
 =?utf-8?B?Z1Vtd3NnS29jcC9NeUlHd1l4WlBXd01USzJpMVIxR2hYWTkxcStIZUJpMkNx?=
 =?utf-8?B?b3YrSU54NHNRTWtaQmZUdERRdHNGZmV2KzN2b1R1L0ZKczZMcWE5RktrQ0FF?=
 =?utf-8?B?bEttVTNkRm5TQUd0bjRWQ2ZiSldVMk1DbmxPNHgyZlBZZDVVU1dGc05nOERp?=
 =?utf-8?B?aGlWRDU5NFJpa2k4c0RxQ2ViajJmTHk3ZkJ3OFpMNU1EcDlac0hHd3J3anV6?=
 =?utf-8?B?dU13YkxqbTJlcStJbkpzaVgrc3g2ZFZhLzJYaEFBZ2VORXhtaGNjZVhUKzla?=
 =?utf-8?B?bHFTeUl3QVI5ZmdVMzVpMzdjaElsSFBEbTBUa0ZQUm9DMzFCZFBNaytkdG1k?=
 =?utf-8?B?MFdMb1BtSzgrOWE0d0ZGT0l2WFlXSmFLanJEVitKR0d3eGwzUjZjd25MNE1E?=
 =?utf-8?Q?MsOdhXANz3YHurqI=3D?=
X-Exchange-RoutingPolicyChecked: J9YZg1NB6zgDoQ+rcDv9Qq1nWdWZ9abEuEkyqm9EOyvIldQXimIL6GQA+UAm/TaoA6BE8Hti+C/g/ub9eA+fyiw9D/+leBovA2K/Z5RjxlI+zRGDeonNoVaCEh/W/0wGS8hs6MucGtB+5qxT2J4nUF/qkhNS9GMj1hDu6+unfSZbidXbWuJx3sScPzdwz6oluVtoF8wJN5GqjnYZcgn99xxpEJnkcrlbGdffjyMax7I/LtU/4MPB95e0DHXw5mimMHB3Jf1oN5Vh3MftYZTZFPVwV8FFMxygZT7DzVaeqEGE0mQOHIjjwWiDbEn5/c8D3ByzfEzYNdH6YjsZllQgaA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f0f8cd-f420-460a-cbb6-08de833f4c36
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 09:35:02.2617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3iqOZ4fyvqIBus8wipxkTcwCh2aOo2LRbDGAvOV/sbuGqd2f3y3srh0l6G+QM5XAfV4N4plyJLdDUttdCyBQNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4567
X-OriginatorOrg: intel.com

On 16/03/2026 11:04, Iker Pedrosa wrote:
> El vie, 13 mar 2026 a las 14:04, Adrian Hunter
> (<adrian.hunter@intel.com>) escribió:
>>
>> On 09/03/2026 13:40, Iker Pedrosa wrote:
>>> Ensure SD card pins receive clock signals by enabling pad clock
>>> generation and overriding automatic clock gating. Required for all SD
>>> operation modes.
>>
>> Need to say why update to "SPACEMIT_SDHC_LEGACY_CTRL_REG" is Ok for
>> non-SD
> 
> After analyzing the reference driver implementation[1], the
> SDHC_LEGACY_CTRL_REG setting is applied to both eMMC and SD
> controllers.
> 
> The reference driver sets GEN_PAD_CLK_ON for any controller with
> MMC_CAP2_NO_SDIO set (SDIO disabled). Since both our eMMC and SD
> controllers have no-sdio; in their device tree configurations, both
> should receive this setting.
> 
> [1] https://github.com/orangepi-xunlong/linux-orangepi/blob/orange-pi-6.6-ky/drivers/mmc/host/sdhci-of-x1.c#L482
> 

"I copied it from somewhere else" is not the best explanation,
but better than nothing I guess.  However I meant add the
explanation to the commit message.

