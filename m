Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D56C1BDAA0;
	Tue,  6 Aug 2024 09:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722936245; cv=fail; b=aDM75e8WprSdmwVqYcn87NhanNOZDHa37vOq4p/0cXQb3fik5uN13ntsBpzbV2qXLgc3RQSi23fV+Z7A7nzoST5iFRbQzbtu9YMKjk0lpQdPH/QePlqkaqjAP3wsBHiazjlUbareEUYCDgXRvm8wWAy/F1zUl60nqJWPZkP+Noc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722936245; c=relaxed/simple;
	bh=zcMiJSY3LofeRSh+fbVNTpX7F5qR5Hf57lWi74x7KTw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e5Iz7BqPCzoyoRqsEemQJwWA2LBPFwHERRDiNm4Lp6VuuYiviGZa93XOSSdyOWi/oaO0GIs8YGulHbvXP4bvLxq1cZPkOxxLcPGLpJQUNZRTPC66Rd0YMuXH5ufw73Aixn9M7na4czI7UhGUnkFuFE8gUanWCPjF8fOvsOKoJIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTixvis9; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTixvis9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722936243; x=1754472243;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zcMiJSY3LofeRSh+fbVNTpX7F5qR5Hf57lWi74x7KTw=;
  b=lTixvis9YJcSWKXIkHBNJGdu7DuNfADHF21inufOifNaIgjef1mb1Y5m
   zDa8aJXMdH1ELj4nQCMvlOQkX8F3uHyJqDEbBFTsrjqfLgNNTkDBQfPmA
   Sqf9apC6ihQst9MPWSkmW348AQwssrhgu3Yjs1iy21zKQ+EtVVpwqNOJ6
   RHzydKOD6a00gYkrHPs58NU1aPVTCvEd7AGqyNff83oSQQKmDFeS6ONg2
   9lBcxkM+9CjZRLGUhgaZtwnBSSYtmw9zHY8Fw1i7jNDZE0nEoIx0jEREi
   LoqqdQSW1O+InMKzKTl9/WK60RK1M4HVddoxNk99XC3bGqKlfr/qkn2xq
   A==;
X-CSE-ConnectionGUID: IJ9J5Xm4RKWWdUKAaGfY9g==
X-CSE-MsgGUID: RsioQtnIQnqybPWrQD4EjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="24804490"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="24804490"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 02:24:02 -0700
X-CSE-ConnectionGUID: tPmp0XXUSrCyhbWoh7Pz5Q==
X-CSE-MsgGUID: NgYuYPyGT0GnDpeFeC2ADA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="56394576"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Aug 2024 02:24:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 02:24:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 02:24:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 6 Aug 2024 02:24:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 02:24:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZRIFIxNp+K3sp9fQivRdvG8K/vmfx0AgRaZ+gj3cOheVQnRike0RkXEMwbXcn4wJ1XLM/Ie3oEkkHO7Z9EI2ZWggPOs/S/j64YvrAYYgcZdCv3+al8V6ceTxR6iNK+s4l2Xsa3a/4K+vCmSYgrmgJQPcnY4gAUWewpkCIv3DvC6aq5q2uCqOdGS1a2X/fVTsX3GaPmNP3uoG1fcTm2NTEAHxRob9GFV4tZIJotfG78zrZT09/31D/8NPZIUzgiaxjHLKjduoKOlJi89cpJLFN+o9DqYtUlV1Onuajc4+BDDEOS3AZvSyjb1iXzfqKijQQrTRp0fjhF/P0Uq+Yxsog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4YngrO/ie+momr1mtK1eZHFOBeLltyFaAyqihqLPRQ=;
 b=JSCArwNtpqDj3t1vV+WCH6YnQ0TLhxpfTzxuILazpw5zh6iEPtYAKfNPtGBDXs4blVQGWEKXuyXWny9TQBPWDzpY0ETyhvBpUDxQTRql9zcd4OT0jiqrpQ/ARjH5a+8fcMuCnXlQg1vBzHeU7eRlv1uFCzv1IlS3DTh5vpRtmKWH6Kd+5bUq3ZqcKzLNpRgD/si4yYMZO6+CvPcjklTknPjJNq+9v2KKkDTWc9SwyZmfsrNLgCoC3guz/OKEMGCsF/Unp1HOencGxtoKdBWD02ngLc47smEaZqwbHZHGaaj3sM7VcZB7h53NSh3oUdfrnEuNcfBZaxSmNm7qG/Rgyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by PH7PR11MB6425.namprd11.prod.outlook.com (2603:10b6:510:1f7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 09:23:58 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%5]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 09:23:58 +0000
Date: Tue, 6 Aug 2024 17:23:43 +0800
From: Philip Li <philip.li@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
CC: kernel test robot <lkp@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
	Joern Engel <joern@lazybastard.org>, Keith Busch <kbusch@kernel.org>, "Jens
 Axboe" <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Wolfram Sang <wsa-dev@sang-engineering.com>, "Florian
 Fainelli" <f.fainelli@gmail.com>, Thomas Bogendoerfer
	<tsbogend@alpha.franken.de>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>, <linux-nvme@lists.infradead.org>,
	<oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH v2 6/6] mtd: parser: add support for Airoha parser
Message-ID: <ZrHrn9NzeOhp+Sdl@rli9-mobl>
References: <20240804174414.18171-7-ansuelsmth@gmail.com>
 <202408050612.Ya1m6REu-lkp@intel.com>
 <66b0b109.050a0220.93681.d015@mx.google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <66b0b109.050a0220.93681.d015@mx.google.com>
X-ClientProxiedBy: SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|PH7PR11MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d420c8-411f-450f-7a99-08dcb5f9805a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jzyyp7gTaT3aB+la4mG/9m15tLlGBBHKgdGii3IFm+/D5N2TLFtniRb/8DWJ?=
 =?us-ascii?Q?2UNcLRhuKcBuWsCg9FI3l2LD4Fb2BrtlFqfW9v2u1bI93++AwxHA7mK1zUik?=
 =?us-ascii?Q?OKBvQwAJzgTKEBL5XUtQyYTUjAorpyg/nzNWzQJhix7Vo6cGW+DwCSsTwuMY?=
 =?us-ascii?Q?FntftSDcxtwzeBgyXdr/8QcC1a1SlILGtogvfP2oMp86wRrrtWeurxlGb3Fa?=
 =?us-ascii?Q?6DIvD+mIEihZ71rXi4VEKGhbfgwb/f5cCJUBwfTcS5kCwdlDEhDdOLN78H9h?=
 =?us-ascii?Q?BbRnR9LeOpigKBhfIMz8IuoBLmGCMawkgr4FNZiQI0pw5v39Fx121iiLE7m9?=
 =?us-ascii?Q?N+4AeBxvlOihExKUInHxkP1xL7BGZl1t2I1UEJyUyVqdASmqFFXVnPTY+Zt3?=
 =?us-ascii?Q?5Kcj7pfBC8qhcjxvAcn6LYevrh+mcFyPQFYUpZ53qA5xA6ZUbOk0zAUoCWto?=
 =?us-ascii?Q?amai+gukVhEdzWdNZDYgQk/KMGpaC/SR7QZsyhjp8ov3oYb88SQm6EG9RJ1Q?=
 =?us-ascii?Q?YcI4sHoZMF426okbfZSmw9TTXrusHpsNELnu9H/NSS0GKb7dkG4uTgKncRQS?=
 =?us-ascii?Q?CSX5YZCuQiZVegaLVib2pt2oVxDX7aev6OCD1jcdCQR0Qp6YS8zeiJnMWsTK?=
 =?us-ascii?Q?tHINkcQ6bapPFgU6NMLSv0AQVRs7ejpWYg6avSWPJcEr+Bxz/caHuEX1oipy?=
 =?us-ascii?Q?KIhzsFqyGX1lJ7WlZVR+7vsx++hJ0ZA8UoUOtHwz5GkwoqVU6rKyRhUq5SWP?=
 =?us-ascii?Q?HPS22WswK/SpCcQ2jxaTUckm8TGUdi/S+qS/39p3JR+bQKDqqney3dXG8g+w?=
 =?us-ascii?Q?jYkUmMfbqG5RXa/EIoouXIv8a3TRXDw6ZcpZPeLD1NjTzgcNGyEg73tcHE5j?=
 =?us-ascii?Q?y+KA0i9bHudnFNNUFm9RF/+K0RPq8f80quLAG3iO04M5AdzS590bnFajUb3x?=
 =?us-ascii?Q?wSdoMbIwRNINisi9/OzZxtAX2wuf1vAmjXBeCkGBT9AJ3XzGLKE3kky2AoKT?=
 =?us-ascii?Q?bPaugrvs15bOfHoMHNt9oSr3I2abmc8mgEiiz3b3WfQ8zwlw328YMOrkz7hT?=
 =?us-ascii?Q?FBN7hdbk8UrfBafk25KCkLz/Ay3Hn8dH/d2KzxaqDralP9mNtx0pk54hI/uE?=
 =?us-ascii?Q?FZmeQpSZd86ZQxDyLICx3HT2RR2vTo9OfKWpHg+jqezEC1dJF6Y9XevCoS/w?=
 =?us-ascii?Q?oH44UFD0AMGEnh9eOezsYvL4MseaAdWaCkC7c9CY/ZbHHAgCgWI6o6zNCgdY?=
 =?us-ascii?Q?gEVlF9XBRIfkzBgNBecwu9l0qzpanHzZvEg0gfrI2G/W0+yQjopU3uXX0s1C?=
 =?us-ascii?Q?f/nQrXpfmiZ7nKmEiEafiC8x?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JMHHKJor+0bgFFsTR5gpmDeuVYkSvj8gAqUrpndUVz1sCJ4ExYzBlv5e2zo0?=
 =?us-ascii?Q?zZ0EV5XUb8L8aRtx5JHJTNSGcpJ9KB2FTkzz72by2dY5IZM1oqIz0t2o2pB+?=
 =?us-ascii?Q?q8f5xTLR2FsfMPaNGlPH+UcaqjT+PH2Mmbf34GirmVxYOr8meL+fSqcrS7M1?=
 =?us-ascii?Q?sDi3Q5Lfh+BC5TF1LewUPD9DXqlHAWfOAbnApT5JldeRqbqCjzViu8iI/eod?=
 =?us-ascii?Q?ntXnSEPcNHsYKP9oSuj/bd9nb1t9zIw8jbvzzlQJLujoSXnkTy0R5Ldt387A?=
 =?us-ascii?Q?PO+6SaN0cHbB+r6cGBdB/u3DGzQ/EkhNwGfK+cQEoa/ghOagkWsasVx9gblT?=
 =?us-ascii?Q?BrZiGbrwL6JarfYSoXTv4V7cTbhSOr5WSUTVP9Cg2pq1rKfpOT1EiUXmvpVZ?=
 =?us-ascii?Q?bApfNfOEYoUnYt0nYoID0uev9eRbaRDjqDNx6G42NW7YBHoLLPMXDyx62Liq?=
 =?us-ascii?Q?VTakSTOG/Rwk+ixvq6S+Ifc8N/44pBXc0F2KwBTKVbtZcskaCZwIs9v3eptG?=
 =?us-ascii?Q?gf2MfoAhf8Bma/ptIhMyqzc3MzWDxGy7+xrXc1E5b4FTMdxkT7/843MZaoAv?=
 =?us-ascii?Q?wWX5gSs9ruyz9w8c53YXnza33IG4VD9w03IcpYL4rTbssQj/aPrfmYaIwktH?=
 =?us-ascii?Q?pE2049s6KqHi6LDIgULT6gbIynEedaaZQl0xVeWyoZscQMtc2/HQ85zx//It?=
 =?us-ascii?Q?OcCDlIjNYv4JR5l+J01T8lEK5f+cYbAQZxHY2FEqqhqIwut+Ts6FOTlHv6Th?=
 =?us-ascii?Q?c78grABoBFBbGMQSRc5hSCg7PAj4RScxHECK1zSAZA6pqgBNBA5O94Dm3xQ3?=
 =?us-ascii?Q?y/tTgK1ixdRdhTaQ5PrNUu6+xvYpYnzk12KhwXEHMn+9NP634tCmf94xuCse?=
 =?us-ascii?Q?MSCOgB8gZizRHaFbKisdm4K9j57R0eJlRq2pyYT05lorS7Nf9cprFeqFghCy?=
 =?us-ascii?Q?MNt5BBfY+gsIZiB4wJ87q11jUH+XrpsPDkXyl+1Ek9BUGhxdm9ciBWI0spL6?=
 =?us-ascii?Q?RPlSKpAEPR6S3RBKDXT/mUjTWq43arUuRkC6GupduTj7W+aS5wcP8Ghkcxce?=
 =?us-ascii?Q?lw4UPEpuEFvtntfOT/L608kyiTGGAXllQL3A/fL5cNiXEiGTeeyJFRDetCUU?=
 =?us-ascii?Q?Pb/7cIpmnFZ7Piu5JDQAGzpg9o+mohJQ0/uSPulbG3h5ZFI3GUF1wKbqKjYJ?=
 =?us-ascii?Q?pYlCQckNjKowbHLsnIrysZu3cNOWrSIEhWLqn+/Qmasf7xxLAy0E7XzhhGEL?=
 =?us-ascii?Q?nXaoXiWl/poKpKA8QrRRzIJ8Fdxcwrqub2sjg2rGqLnuTBAcOx2v7AVRMnwV?=
 =?us-ascii?Q?lSlf2b/r9Zqq77VNEqkagfbLZjpeVd3ePLy3U8c9H/MEMgnAYYT0lb3XxSLI?=
 =?us-ascii?Q?6UbqpWAe48+spUAwv2pZOf+MisHRoXC9538PLwLMjkMbqezkxZ7uuJZdBwej?=
 =?us-ascii?Q?FxmYd8LnIvwAkQNEBSwPoAuJ3ZgPL6sYWkpjlIVapULKeN13gxYCtV5sMXeF?=
 =?us-ascii?Q?wIl1wQTcbaUijUDcs+b8Al+VU+9kMfb9EVrF+L+b+BgzJjZQHQKp0j77gzJv?=
 =?us-ascii?Q?niIbN1SgmZNQC3OvbzaodoC1KR9A7vXr5ppus21L?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d420c8-411f-450f-7a99-08dcb5f9805a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 09:23:58.7640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGCROC1TLXFXfdLFjHh6Rakgh/LRTWfRhJN2fyCpbfZj4+QRctw4SyQJ0M+RbwJcIURXlMV5vfjdkP6C2m7Z9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6425
X-OriginatorOrg: intel.com

On Mon, Aug 05, 2024 at 04:54:45AM +0200, Christian Marangi wrote:
> On Mon, Aug 05, 2024 at 06:52:04AM +0800, kernel test robot wrote:
> > Hi Christian,
> > 
> > kernel test robot noticed the following build errors:
> > 
> > [auto build test ERROR on robh/for-next]
> > [also build test ERROR on linus/master v6.11-rc1 next-20240802]
> > [cannot apply to mtd/mtd/next mtd/mtd/fixes]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/dt-bindings-nvme-Document-nvme-card-compatible/20240805-014740
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> > patch link:    https://lore.kernel.org/r/20240804174414.18171-7-ansuelsmth%40gmail.com
> > patch subject: [PATCH v2 6/6] mtd: parser: add support for Airoha parser
> > config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20240805/202408050612.Ya1m6REu-lkp@intel.com/config)
> > compiler: xtensa-linux-gcc (GCC) 14.1.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240805/202408050612.Ya1m6REu-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202408050612.Ya1m6REu-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    drivers/mtd/parsers/ofpart_airoha.c: In function 'airoha_partitions_post_parse':
> >    drivers/mtd/parsers/ofpart_airoha.c:33:16: error: implicit declaration of function 'kzalloc' [-Wimplicit-function-declaration]
> >       33 |         prop = kzalloc(sizeof(*prop), GFP_KERNEL);
> >          |                ^~~~~~~
> > >> drivers/mtd/parsers/ofpart_airoha.c:33:14: error: assignment to 'struct property *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
> >       33 |         prop = kzalloc(sizeof(*prop), GFP_KERNEL);
> >          |              ^
> > 
> > 
> > vim +33 drivers/mtd/parsers/ofpart_airoha.c
> > 
> >     10	
> >     11	int airoha_partitions_post_parse(struct mtd_info *mtd,
> >     12					 struct mtd_partition *parts,
> >     13					 int nr_parts)
> >     14	{
> >     15		struct mtd_partition *part;
> >     16		int len, a_cells, s_cells;
> >     17		struct device_node *pp;
> >     18		struct property *prop;
> >     19		const __be32 *reg;
> >     20		__be32 *new_reg;
> >     21	
> >     22		part = &parts[nr_parts - 1];
> >     23		pp = part->of_node;
> >     24	
> >     25		/* Skip if ART partition have a valid offset instead of a dynamic one */
> >     26		if (!of_device_is_compatible(pp, "airoha,dynamic-art"))
> >     27			return 0;
> >     28	
> >     29		/* ART partition is set at the end of flash - size */
> >     30		part->offset = mtd->size - part->size;
> >     31	
> >     32		/* Update the offset with the new calculate value in DT */
> >   > 33		prop = kzalloc(sizeof(*prop), GFP_KERNEL);
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 
> Mhhh somehow I can't repro this with instructions?

Hi Ansuel, would you mind sharing the steps of reproduce? I can reproduce this with steps
described in the repro link [1]

[1] https://download.01.org/0day-ci/archive/20240805/202408050612.Ya1m6REu-lkp@intel.com/reproduce

> -- 
> 	Ansuel
> 
