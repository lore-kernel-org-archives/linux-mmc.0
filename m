Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9403603D8;
	Sun,  5 Jul 2026 08:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783240222; cv=fail; b=GbaoIvRoPL64pPR/ckzOyJvqrFg9lC6KMlCaSB64tnBcYfemF5X5fG2e4HIkGg3IcABsAItAssvfK0+O+BwCnH81fe5IpBHUYOGfDqGY5ROpY37skkA5nu/7l5isOl5C1LYooUrZ362qoOdx/sa35XVlI8iBUwVwFpy8c8U0Hrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783240222; c=relaxed/simple;
	bh=ZiM76GGbm3Qv/OIFQPJ7s535VGpMHDuRNF+v1uhPzjk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qxNleRT4YGrDMV4PWAz44bUC+wyW6/Z/7ELu3UZ5az94F/wKhhjulz5H+73T1wrYYiUdVTOObNgVUzrC49e0gNv/yLx8PWaqIizBtqwexdSzD9TQ5DE9RFQQgvPrzTdzsJvFQMF9UI3kwb3YHRieY4RhBRkbbTq8w2j94dp6FD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YklZWOLE; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YklZWOLE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783240220; x=1814776220;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZiM76GGbm3Qv/OIFQPJ7s535VGpMHDuRNF+v1uhPzjk=;
  b=YklZWOLEH3zfKgN4uIvvto4n4FQXOemEYds2R5bMaGVvqH853QHSlZx1
   epF4ezP2a1ykNp4Hfq83hUNLKpj7xRxrLgYD86BmCbPNkcmXtzRUkGrn4
   fV+UyZhISoZVJd+s2Cy7xacgbfuNR1qjnSPZAGNGvAIR3Z+TXMvhWpuGQ
   uO4K2/OympbwBcGv05iRc//Bchf0K4V7ute8xbhyEaH5CZeA2saf8vi9h
   nDfvKvRFUiV2sIBNh89o9JsiAfn5XVxspYhtalvAKdImZ2M04XSGTKz/i
   NSsbwRGVQ7ydFSLSzukQgBYxkCEhmw+hNV5403ocJnPC2n+OI+pszSktz
   w==;
X-CSE-ConnectionGUID: 09YsFzw7S2eiU4VTWc5faw==
X-CSE-MsgGUID: 9oGuMIehQpy0z4C6Q5d/4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11837"; a="101449418"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="101449418"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 01:30:19 -0700
X-CSE-ConnectionGUID: BvkcY58NR++v8vDdNSCTLw==
X-CSE-MsgGUID: 6bLAsCBJQdigkvIphIK78Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="283528939"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 01:30:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 5 Jul 2026 01:30:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 5 Jul 2026 01:30:19 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.68)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 5 Jul 2026 01:30:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRgpndHLS7sQ9tMAMK+4Q1ecBxVXN3hNa2LSc/4Q9wewGMPUXeFrIPK8Og+n4vHtyN0HNKLfEWNReHDHuwQZPa7rptXkBzD3e81DWj0jwBkmJk3CFFdetYo3I3QZFVPRU+zbIfiixTq1hN8Esb0Sgee8BYf1sIJfq24+155CFpnWs4+SrvcSZebE6BCs22BaCRYJ5P7WXszL3wTEs6bKgVSyCwgRPBS0JiebAWZa9LAjmERlNJ77Wjm5ZxRGUvwNPpe1lFG0oWcUHYFQleXii8efNtm7BbsPKAAGE0drPDLVyMgvHOSo0SZ8+eUHGmHPkcfCWbdk+Iq2n+aVlhEckA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6gUi4iZ1n/3HPfROuEbZyCRK+CXKasnvNAgkmlL70s=;
 b=pGc1M5N73y63YPVP46nbze1rIZ1/nrYPPAx1HbH/Gd0joOJRfGLaet4lSIrupq9NhuSDpPxTH8ingqLReuvXa3bWp+QMRelKXn5dL9Ma07d+pZ2jtasY+lSLLaCY2MxUhA6ZyoVSQBe70/oBhsC8FJLLLO35GagSSWOVDl4tzQkJ1BnCcMt5i7jZE0Gh+PsYe5kQcpNxxQRfCUVCjp4QKjtjFPvA5RarQFSdOApu7x49YBuEp6yiX4V9TLHsER3I5J+jxFc3yJIgQuOZDwlquDkV5uCfsLAMW3UXBv2psve4vU80bDX3Z+KbuQNaShKvqvg16yW8s6Kwz0pG/Uh4Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SN7PR11MB6602.namprd11.prod.outlook.com (2603:10b6:806:272::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Sun, 5 Jul
 2026 08:30:11 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0181.010; Sun, 5 Jul 2026
 08:30:11 +0000
Message-ID: <0b8c3e61-e0d8-46dd-8c91-e793310087ab@intel.com>
Date: Sun, 5 Jul 2026 11:30:06 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] mmc: sdhci-esdhc-imx: disable irq during suspend
 to fix unhandled interrupt
To: <ziniu.wang_1@oss.nxp.com>, <ulfh@kernel.org>, <haibo.chen@nxp.com>,
	<Frank.Li@nxp.com>
CC: <s.hauer@pengutronix.de>, <kernel@pengutronix.de>, <festevam@gmail.com>,
	<imx@lists.linux.dev>, <linux-mmc@vger.kernel.org>, <s32@nxp.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20260703104208.3426374-1-ziniu.wang_1@oss.nxp.com>
 <20260703104208.3426374-5-ziniu.wang_1@oss.nxp.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260703104208.3426374-5-ziniu.wang_1@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0075.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::7) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SN7PR11MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: 9876c819-37b8-472b-8640-08deda6fa0d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|4143699003|6133799003|18002099003|56012099006|11063799006|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info: h+w2if1ZeAij+igQeZTFU3K0s+9aStj9j0wtgGbhBOTH0vQBbVOB03pDiU17AhQIrLm2ianB2xstRCi0rkcfeESyfwlztj/JiZuULi6D8zqiVtjt5/g0K8hRUw7GMqKXEsUCpeN4tD2ldZJdellfUtDUaGutILH+rBG60qyqyWYLP47DgNBgLV5I2JFz7PXI0gSbdjUerClfigsLNB68RO9+yPoUO3+R0Jtnq2NZNmQJ4LThg+Y3pQZqvhOt/qxFrkJQgukpo7Ml7iTTTM+p6pcnobvvy6xauO41tqPzmpb9/U2t0prtuvSNY6Cmr/ECseqXSWAD+0u5diVwBAdap7hw1Kxk1yMfAKvFlNHfcxqbmJlbXHyPC+vPfl34VnsSH8CbBbGrpSW5vfxI+x871FsyPTS/obtSzZQFDfWXeiEto+JDG8P+uVATa4mpeOVCJ+PMo7nsVSrosJomKKKyK+bnfzGBT2nz1AZObURw0xHsMlU3LhvWDrIuScrrcXlbD91Tqu9LX1o6LptxV3mL1Nuosvg/mI2mnxEHUub65CjSCgep+ReD4X18oEh8H2HDckSBzhdHV4Jp0c5t0eXMTWefLN5i6srXYUnXrO0BmaxSvjrZuPeFlZ710XLzrW1fFuKTDv+pUB2RDn8Gp9ca/SnyjUQo8gC2fe4YL0QwXW0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(4143699003)(6133799003)(18002099003)(56012099006)(11063799006)(3023799007)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEtJaVlCdU8rclJmWk1QUHNkRTdPNGkvY1dPZ2FhRHdVcVFDZW1NeDJ4em95?=
 =?utf-8?B?eGFNalF0VXgzbzJLQlFSQm04MCszZDRmbGtHQ09CM28zZ0NzQXB1My80b01M?=
 =?utf-8?B?K2VCd1d6ODlUY0FQT1YzTmVsNFY1eGthZFNUTTlrNktGRXZjRGpVYzhZdkxO?=
 =?utf-8?B?OUxUN293d0VUTmxURnc5RlVkRVNsZ0VSQlFna0lpemIxNXdSczVjWmp1SUMz?=
 =?utf-8?B?ZlM5RFlXUlQvb3AxaWIxMnB0MVNZK2J0UXdMYUFyOFE4MVlWZ2Fub2QyTXdH?=
 =?utf-8?B?ZmRNWG1RSWxhZVV2WUhJbGtvcFFNQWsrZjNaSm5MYzZ4S2dQeTRITVhtV3hH?=
 =?utf-8?B?N1JDMGtaVWtXVUpHUG5OMkdtMDQ1MFl3WWE4U0Zhc2dPVXRaWkowTVozeFkr?=
 =?utf-8?B?TStNWHJCSTNBQ2hHeHJCWFMycDNpRFQzbG0zNHRpbTVRWmdnTFVuSzE3MUhV?=
 =?utf-8?B?T3hieHpDcXg4dndBUC9qbjZxRVVjVS9NalFETDg3QkZDdVZoL1VNelVZRXpU?=
 =?utf-8?B?YUtEdThEU005TkpOTzlmMDJaZEpHdWxURjFZL1E5NlJvU1ZEOW03YUhQczI3?=
 =?utf-8?B?czVMVmVoWDV3eTVneXhJaE11cENmUVI1ZzQzMlUzSU9aSm1RbUdyTzNRY3dL?=
 =?utf-8?B?L2g5SFUvcExUekVvUGZhRlUwb2hOSGdNZmVwQUZNSmRZOWlkYzBHVU8rK1ly?=
 =?utf-8?B?TGczTFZtZjdra01SSU4ydzYrNHZ4OTlZTXcrSEoyTXFPOEhwYTBOWmgvdW54?=
 =?utf-8?B?YzRqNFNMZWQ1R2Uya2trRVdSQjQ5b2ZCVFIxNU5EVTFRdTVnV0ZmdE9rY1kv?=
 =?utf-8?B?UGRqNUpEWXdTdGt5a2lMc3hFSmNOdkRpMVJYeEl5MUtDN1dKV2JiYkRGRHdX?=
 =?utf-8?B?MU9XdDh6c0RucFhKVFNCcEtBMjdBOURSL1ZxMEpqQ0tCUFpubWRzL3ZrWWdK?=
 =?utf-8?B?MzAwMHRMOUliNGNZcUxSei9yUjNObWptUjhoQktBUXZYS1FWNjcvWU1tL0ND?=
 =?utf-8?B?YlJENGNxR0NQQ29rZmt5RTFtYmFpWXA1ZTRFd24xVk1iQ05HUlllYXp4TXdT?=
 =?utf-8?B?WkZZMEh5MVdFUStaNlpCNVVaS3NPT091K3hZRWdFM0JVbXVjY1BtZGJMdTlT?=
 =?utf-8?B?ZmI2MDhvTExWQ1FjdkdDTlVkVEkwaDR2YUc2WnROV2lGVGlHdmNXRkJXdVVl?=
 =?utf-8?B?THhPK2l1MVFvRG9SOStCQjcxNDkyNEFQV2h1K3ZyOXpadi91b3BJcXBaTjd1?=
 =?utf-8?B?WC9XVHA3WlJtVXVDbXJQZFc1R0hUTm02czdoNys0VDljU3ZhRUZES1ZCajZi?=
 =?utf-8?B?ekZMb25rdVBFWVh3aUNBS1JZM0NsdC9TM1haNGl4ZlRhanZVb0xIMFk0L082?=
 =?utf-8?B?dmZKV2lsQy9FVzZuUjR4M1BMRXVNeWd3Z2ovQ3AzWWc1TlFpUHFtZkp5UTRR?=
 =?utf-8?B?Nk5tWTc3bU93RzdIMDZ2UHJ0WXRENklNaW0vc0k1Mkl3NjV4UE9UT0x4QTZt?=
 =?utf-8?B?anZJWFZHMmFkMG40TE1Bckw1Zm80T1NRNWhRaFpqcEhVTUxQNDY3TW9SanBl?=
 =?utf-8?B?Q1FXU2x6VzNsUWw3dDJhSk9KMlVjTEFDNWZUMFZLYVlPSjE2bDV0YzBZNHYw?=
 =?utf-8?B?UXZSdHp5dTU3by9hUkliUkswZGQxckM2c1ZSNWxMcEdTWUNQMWh2Y1hVeld1?=
 =?utf-8?B?eS9NZy9qK0NXR1J3eGhLaVNqTUpoYzAvYWcvRGVJVkdvZjR1UExjbU9EaDFS?=
 =?utf-8?B?Yk9yNUxuV0hvSFJjVWRDWWZybkhLTHl4MkNMSk5Lb3JTc3ZSNVEwWVNhaDBZ?=
 =?utf-8?B?RE5UdDNmRlRRbXVBM2FBdEc4ZnJxbXZzL281VEtxeGt0dXFGQlpVeTlYWHZG?=
 =?utf-8?B?c2J2TGFEd3VYR25pcktMN1gxVEFPOExVbVhEaHllTnQyK0tldlFXMGtuNEtJ?=
 =?utf-8?B?a2FGc1Fkd1FNUnI0eUV1YW5GY05haldvNStwOUJocXpWN0ZYa2NaZkVkZnNU?=
 =?utf-8?B?YXdFZkFoK3gyQU5zaFZ6ZUYzQjFON3lvRHJCanpRdjRsVExVamY2bnVYWk9q?=
 =?utf-8?B?UjlMWnNXaHhnK1FXakN5dXZTeFRpQkNxcFUzbWRlOE5KdmFESlZ0QWlteElz?=
 =?utf-8?B?S3llZks5MStsS1czRXJMNjMzUWFGcytQb1pqK3AvdythMm9Ham0wRlc0OC9o?=
 =?utf-8?B?cG4vK0twdkd2cjQwaXM4WWcvSmxzNUI5SG40c2FQaVk0b3FGSkkvWWVZZFM2?=
 =?utf-8?B?aGFpcDBiNHpXZWlMSFMvQm9HS0FiWWEydWN1djV0YmVVYVoyZWRIaUhwcGx1?=
 =?utf-8?B?RzdHcy9XMzE2WUkvUnpNUzhLTElTUW9DYWZicUJGNGlpdmJ3TXdIUT09?=
X-Exchange-RoutingPolicyChecked: UIIJaAcK5cuuxAS32gcIzqe+VentDDD2+Tk+aRFXQK2kW94E1AKe7svJyIsVS1+H76ySUEmfCW2PIBw5XqxNaZRXsDs8OvBVBZKi75euOFU6XpQ2IwIVOCkXcz7Auz4J2eRVbk2hEcsUeaP4E1KDB56S44Vt+Vo5FLwP5UvBOUkdhKlHZp0UPHzJTx0BrH7nKkyJgtJrZvbaP3kNtsJv/6fTn/AoMhcUyXjYKAqijuABwVvJFWgHDB+iLjsFbGmLorZyifFXxScSwYpKdNXmACs1piya4sDpfUWH/p9K/146cjkg9UDCOKnov2Rf2icFWtuYeMlF39Qf2+Te//2cNg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9876c819-37b8-472b-8640-08deda6fa0d1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2026 08:30:11.0384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fn+rPn1Rc0BGlcAXhgWBpnaYxVqm265fmBaEhhX6CEceSsnrEIub3e0OCeUMle7WXXc0JcDl/GnIwvqhPcvUiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6602
X-OriginatorOrg: intel.com

On 03/07/2026 13:42, ziniu.wang_1@oss.nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
> 
> When using WIFI out-of-band wakeup, an "irq xxx: nobody cared" warning
> occurs. This happens because the usdhc interrupt is not disabled during
> system suspend when device_may_wakeup() returns false.
> 
> The sequence of events leading to this issue:
> 1. System enters suspend without disabling usdhc interrupt
> (because device_may_wakeup() returns false for usdhc device)
> 2. WIFI out-of-band wakeup triggers system resume via GPIO interrupt
> 3. WIFI sends a Card interrupt before usdhc has fully resumed
> 4. usdhc is still in runtime suspend state and cannot handle the
> interrupt properly
> 5. The unhandled interrupt triggers "nobody cared" warning
> 
> Fix this by unconditionally disabling the usdhc interrupt during suspend
> and re-enabling it during resume, regardless of the wakeup capability.
> This ensures no interrupts are processed during the suspend/resume
> transition.
> 
> Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
> Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 3b1e63425a19..ade99dabdb5f 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -2075,9 +2075,10 @@ static int sdhci_esdhc_suspend(struct device *dev)
>  	if (mmc_card_keep_power(host->mmc) && esdhc_is_usdhc(imx_data))
>  		sdhc_esdhc_tuning_save(host);
>  
> +	/* The irqs of imx are not shared. It is safe to disable */
> +	disable_irq(host->irq);

Pre-existing, but IRQ stays disabled even if there is an error later on

> +
>  	if (device_may_wakeup(dev)) {
> -		/* The irqs of imx are not shared. It is safe to disable */
> -		disable_irq(host->irq);
>  		ret = sdhci_enable_irq_wakeups(host);
>  		if (!ret)
>  			dev_warn(dev, "Failed to enable irq wakeup\n");
> @@ -2128,10 +2129,10 @@ static int sdhci_esdhc_resume(struct device *dev)
>  	/* re-initialize hw state in case it's lost in low power mode */
>  	sdhci_esdhc_imx_hwinit(host);
>  
> -	if (host->irq_wake_enabled) {
> +	if (host->irq_wake_enabled)
>  		sdhci_disable_irq_wakeups(host);
> -		enable_irq(host->irq);
> -	}
> +
> +	enable_irq(host->irq);

Is it OK to enable interrupts before sdhc_esdhc_tuning_restore()
and esdhc_set_dll_override() ?

>  
>  	/*
>  	 * restore the saved tuning delay value for the device which keep

