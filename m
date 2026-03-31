Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1387393DD8
	for <linux-mmc@vger.kernel.org>; Tue, 31 Mar 2026 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961045; cv=fail; b=ZBffDesOBvqr/ze54mYfmUPwpzOUMxPP24X326tHAu3WbdLVSzWiLIUCmgeiEzIfCWBpEBwAgFfsVTzUEhOBvW5PNfAi8SJabBYPREPdg9I40GanK5sAwY1BI+YAG4XNLfZA6XE7qEzzOxBLb1x8lZ2OIRspo52ww6iwRYOus2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961045; c=relaxed/simple;
	bh=2hrysrcz6WgSZPPuK9GQ2bQ/kA3VVM2lJto2YtJNmc8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSvPOqTw1Vk3+TH8S9bnCPF5WCPOE/20sdKwMJGeC4yoZP/JBaf7YN3129a2Mo62nZ20TSsCRADG6wXDwUgsYapTg7nFszvkXqZhg2TbCWZzIp2ao6mNHlwmse7M2dw+Q59oXsOmGoZsuCELsiIcT7n8lJokBVxay+/F2CF9xbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sUaWYjr8; arc=fail smtp.client-ip=52.101.43.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sUaWYjr8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNqjcDHcJmyvG2wnu1elzk5UMXQhccCGPxGlp1gBC4ZuHyAxiZWazWHJVdZmN3afxrEwfbjyKJfq6NTxK4eYc/xXqrUNKFqB5ItzN3iJf25vv4VnKFJNlIUwCup0pZbN8SSYKkNlgg1yyVb/UeVw4j1bydg7nLIGi1gd6OJJeDaiW+gcOnKzPw2b2Lgf9km6SAJCwPUVaXz5HnVyyrzmkvN6EoBv2k2QCsji9/bGE+sqZkcQmNifiCe1xOOQTjJLy5ddTk1mNa7/7PJ+eupDK7rRRxIld/delvyeV5cn2jy4ef//itjp1J6rZm/BXL+TUh9HcCVEzPdZl5q0SwHSIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbVV1RGbvIoetSH7Sgn1DFrzR8NEuOOjf5Cc5qD1TBY=;
 b=qwGfWvG4n+ebw0dJuduS//kQW7T9xhGl5GaW3Pd+Ug2vkagZ2FueVMcfT9N+QSMi3DNHyWJ2x+CCvhN82wuNmyTr9aObD3m1KRPYTYUHQHPR3rraohyeVyi4Jsq+Gofrn5t0Jh2GzaRpYWtHQJ8H7qE3jA8mSmD34p63X6UYxwygI3sRX4EvC7POfxw28CcV1pAxX7pR5a1AUNzAOMTFK+gS2972GZhOUg2p4MCZMhg6RNdJzLf4JPEDJb2g/0mPyfDT2NsMf354kPbibikWl/QMfEcKW2Yq6pSTZQG+CjjOw9FthZyaVVZ1uAtK0ttgdROQJ2ZMREbE23Kj9qnkeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbVV1RGbvIoetSH7Sgn1DFrzR8NEuOOjf5Cc5qD1TBY=;
 b=sUaWYjr8i2pYuNL4CKsWyq8gjP0NhFfLwIOVP8TI45u/8mkAWNefUjEI0DSRb3HyMsChpguPkm6Uckjp/S9CADMXM833Aks9wXm8ObWK3bQ/vyk2e9AiTAq2mPzHjUoYvOXSfjrm9RIp3JNSfrHLhOA4XvArfy0ArbBe7K3roe0=
Received: from BL1PR13CA0246.namprd13.prod.outlook.com (2603:10b6:208:2ba::11)
 by CH3PR10MB7436.namprd10.prod.outlook.com (2603:10b6:610:158::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 12:43:59 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::84) by BL1PR13CA0246.outlook.office365.com
 (2603:10b6:208:2ba::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 12:43:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 12:43:59 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 31 Mar
 2026 07:43:58 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 31 Mar
 2026 07:43:58 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 31 Mar 2026 07:43:58 -0500
Received: from localhost (uda0271908.dhcp.ti.com [128.247.77.70])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62VChwIc2774867;
	Tue, 31 Mar 2026 07:43:58 -0500
Date: Tue, 31 Mar 2026 07:43:58 -0500
From: Bin Liu <b-liu@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH] mmc: block: optimize size of struct mmc_queue_req
Message-ID: <20260331124358.prh7rboe76xgibbe@iaqt7>
References: <CAPDyKFq42GDC6V4WZpax_tFM69JPafB9_UOAsfkJN1ZxAP7LeQ@mail.gmail.com>
 <20260327200851.3669019-1-b-liu@ti.com>
 <CAPDyKFrzbfjYs2S6dPdZd+tv+sWcxJQnNEn-Q4me2tFZMOOo1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPDyKFrzbfjYs2S6dPdZd+tv+sWcxJQnNEn-Q4me2tFZMOOo1g@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|CH3PR10MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: a48f9f45-7034-4142-aede-08de8f232e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aZKbRIoTaJvKLllTKAz+3fRNT7WKqTlzuk35IBI9oNoSEs/G7e8PrkWeS4C8N7CNXbRqEW61lQMZjmNYpBV6qgkUbwQSzj6F9wyScqTRn+MsQ+eWvMMX2/cXDnboyiMius9Y20ACaHj/HV20wE08uQPxh888y+0DnHTmFBHJUNxYWb23uZPu6b23p2STOem/qprTXneBApXE3B4F59oz7pNQGm8106djqQFqHZWQrN5atk5NYfp+lOe2PNRyCb4npoSgmAiK4IXPZbVinZr1l+LpkVKKWiqTIqplkc0egW/pHUd7ootSDNlAd2gtrPEWHDEunMsMDTOhRucQLWJGDo0vcmaymzkRnM6aM7GfQVZ8f9+bqr/yE/c1lfWU0F0Crs6YI7M5a/Yywtvy7o9HBif08gb+MZxwU4IGc6ZYiS2n+O9NsKS/1JoHOylOzv+kQBVqU5AJx+Ka6M2wvuP51VmYBfY9xMn1UJs9COfcLgBTzhkep+ZGUVEZOfugyezSiiEvw6SkkCgXX2BC3zTIKXpKYeis9GaFV2VQB5SKT2wbladtZcGKTFUnpntgAGuYPIvaD6wZPpwlHaaluzd8x7nU7nReIZzZMNALKz5dbI/8kMwRC+BilI78ssR/KkxvCdY/QkhwmQSRpKUVlyf3MVLZtyOnopzrInsu8G+4YvckgdMcUPVUp3+LhHrSwJiySvVtNSDFbaSjuIHOLGL4T36jMuj9EkCBvGZ91r1f5lzXhMqW7c1YnMVwVebfO4Hnv5FDEXnasykrvHlflZIkeA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QKYMgZWGIVaiC0LsnzJ7lEgiVkNak8wyaMPE0YbYm7IuZz+uE3FUcBBXabOfAU4edNL2LPPEXYhkwDYzftxnxhtGb+wBHYHx0kbwfSmhuC9OHgB++7tB1wxQLT2R+qLH9mX3gc9THJLf+GXainCfSQSJ1wCtR4+sPgfTlv05F3SugIxrMZt6mCR7GxeIQ9JPwz2UkSXNDu+mb8QmxSd7tOMhlATa40dwD/BHqRrW1zoX/XIhnlw62lWMzMI0K8mnDEMey9PTmbOeGqRfWD1B7uHq2u4PlRepyIhLo8P9kEnEbV4MIJ2sxqcS85UyswDLCoIh8WVWM4qUBP+zArsW7TYBXWqrZ4QbZRH2hhHUOnHzuidnhJSl5RKa5phCDW76cbIWCzT7iaao38P+eNowYkEppDKoGtet8iHhZZYT6Nb2IIcbO0RybfPWsch/VKsZ
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 12:43:59.2912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a48f9f45-7034-4142-aede-08de8f232e25
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7436

Hi Ulf,

On Tue, Mar 31, 2026 at 12:35:35PM +0200, Ulf Hansson wrote:
> On Fri, 27 Mar 2026 at 21:08, Bin Liu <b-liu@ti.com> wrote:
> >
> > ioc_count won't be more than MMC_IOC_MAX_CMDS (255),
> > retries won't be more than MMC_NO_RETRIES (6),
> >
> > so change both to u8 type.
> >
> > Signed-off-by: Bin Liu <b-liu@ti.com>
> > ---
> >  drivers/mmc/core/queue.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
> > index 7bf20e3db5b6..71c82153dce0 100644
> > --- a/drivers/mmc/core/queue.h
> > +++ b/drivers/mmc/core/queue.h
> > @@ -69,8 +69,8 @@ struct mmc_queue_req {
> >         enum mmc_drv_op         drv_op;
> >         int                     drv_op_result;
> >         void                    *drv_op_data;
> > -       unsigned int            ioc_count;
> > -       u16                     retries;
> > +       u8                      ioc_count;
> > +       u8                      retries;
> >         u16                     flags;
> 
> The previous patch I applied added *u32* flags, so this doesn't apply
> on my next branch. Did I apply the wrong patch?

My apologies. I forgot I have already amened my local tree to the
following for the v4 of the previous patch.

-       int                     retries;
+       u16                     retries;
+       u16                     flags;

Sorry. I will correct this.

> 
> Moreover, flags can be u8 too, so please convert this too.

I did u8, u8. u16 here only because the total of the 3 variables are 4
bytes (instead of 3). But I can use u8 for all 3 of them.

Will send v2 today.

-Bin.
> 
> >  };
> >
> > --
> > 2.34.1
> >
> 
> Kind regards
> Uffe
