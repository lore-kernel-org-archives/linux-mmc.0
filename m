Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF224C43217
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Dec 2021 09:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbhLMJsj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Dec 2021 04:48:39 -0500
Received: from mail-eopbgr10070.outbound.protection.outlook.com ([40.107.1.70]:42885
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234581AbhLMJpU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 13 Dec 2021 04:45:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtolGTj0xkbhmBFfO/CUpdu93DQ/4baZsBLWiLLw/H191N77xukXADMsvcf7/D0RzwYN/tisQwXF6ZbJC/h9cXB3vYmvGxcPxLOZRZ3bcxhJrPU9LVvkyos89fZnLIwmNDQ1bDDNK3u9mjZFQanXkkqcnlcFPImoRJhrbexjP6/ufKXNu2DLCK215bvxPzCK4smaezfLvv5BICcWNqooqtLOI0s7kEgPlna4eVkXWJOh57392Pv6AFn601ELQsXReRXl5jN6bF5CpVVU/M2nTTGUTSvkXe0u6S+e9D3xeXUs0SEmfyhoeExT9DolgH3NdVcaoEpCH1Gnzc36cN2paQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mQBNJi9RufuM8RvcE1bfiRCJil/mBdAEuZcF6DMvL0=;
 b=j5clwwn46GFywfZYL5hlZIh8nNXLMnSLOeob5BTzVezMeurdk7Ia7QCzz8hj84qR/8CNxON6VfpA9spRsjXXo3hKq9aYEoDP/+qwyHc/Ovp+OpYhOw7OGOD73Pw4pmJqz5t9z7I3UO7kTAImG0R1nmLqpFFtS4zQLaaTsSOOTE0jpO3FW/0s9jki6xyi9k3/mkAMnePmYSxIGBfyHrtDEFazRwp50M4cx+15QYegLUy3mX4CcUrtFentby1SV5h8AwML7xRJIP1ZN/NIfdmPCQOJfWjz4FHyFi/Da0AuSPwIVN93Xo5B5nhS+ToXTTBvh25fEO5ct8LpirKfaJ1krA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mQBNJi9RufuM8RvcE1bfiRCJil/mBdAEuZcF6DMvL0=;
 b=px8hELj5cc4VpyUJlfPQ+NMvxqi9at+1gzwev2bBtGozxiZY2CkhOUxukodldGIpURZdcGP8YZETyjKQHWv9+sTdTzj6bnoS8HNgxO2aUFYADnd3MD/2YecP9x/p+AdQJTbGFmt3d/FMi3X0Ls/TpeTL4BfdMn2pFKsjWRU0Xbs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from HE1PR0402MB3355.eurprd04.prod.outlook.com (2603:10a6:7:81::28)
 by HE1PR0402MB3594.eurprd04.prod.outlook.com (2603:10a6:7:82::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Mon, 13 Dec
 2021 09:45:17 +0000
Received: from HE1PR0402MB3355.eurprd04.prod.outlook.com
 ([fe80::905c:4765:6fc:3c66]) by HE1PR0402MB3355.eurprd04.prod.outlook.com
 ([fe80::905c:4765:6fc:3c66%5]) with mapi id 15.20.4755.021; Mon, 13 Dec 2021
 09:45:17 +0000
Date:   Mon, 13 Dec 2021 10:45:14 +0100
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Avri Altman <avri.altman@wdc.com>, linux-mmc@vger.kernel.org,
        Quentin Schulz <foss+kernel@0leil.net>
Subject: Re: [PATCH] mmc_cmds: add HS400 data rates
Message-ID: <20211213094514.rzalbzlgedpctekw@fedora>
References: <20211202161910.3944640-1-quentin.schulz@theobroma-systems.com>
 <CAPDyKFoVyqR6h6oy7uhCfReQKk3_ErQF9iBG6bwDrxzSAY2HPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFoVyqR6h6oy7uhCfReQKk3_ErQF9iBG6bwDrxzSAY2HPg@mail.gmail.com>
X-ClientProxiedBy: AM5PR0301CA0012.eurprd03.prod.outlook.com
 (2603:10a6:206:14::25) To HE1PR0402MB3355.eurprd04.prod.outlook.com
 (2603:10a6:7:81::28)
MIME-Version: 1.0
Received: from fedora (92.42.140.82) by AM5PR0301CA0012.eurprd03.prod.outlook.com (2603:10a6:206:14::25) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 13 Dec 2021 09:45:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcec19bb-87bf-4ead-7fcd-08d9be1d449d
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3594:EE_
X-Microsoft-Antispam-PRVS: <HE1PR0402MB35949501F8968E2B37ACAAE8C2749@HE1PR0402MB3594.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GzSADp/yIUZMwQhfoKIN8G9jgd8zAZjIHLRrfI6Uc+ikr6koz3+ybfVvwmS6auZJmE6WPE5OVWE2ZlOVGLtbYMqKKX0duZ/LqDh+tjhRxXuMg8wvlyN3a9HwOtahFk9eABu4WV25qgEmmvOnsFor76APicMVc7eyv12F5ce/9YXGZdYJckzYNVH9qdFS5t13doihku6h313w2Ctsa4FTFZn8/bRDFMkRR/CokaS6X7TWfzdaoAnfSwMYgaMcW30Z21ZnKApB5e9z0zqpU7HFUMeXFKQEmmZSLZhz1FlhVN2X6uj5d53GA/uTVJv7spx6XdYNGttFiIvSVKLbsXC+ZGe/EwC31wHx5m/hx7v//SokGGAI2mGfJYnv8PUJ64HF4Sm/B1Pe6iwwUsdJOePMq7s8w3OVNAQu9kbbqkhnvcoCooLeZtZP/W2KlxaKLnETt31/L9GvdeiLmEPxtWPnlidVTvFRn5r8L+nS7OTq5BsqxDV6IzjphNtnmGBgz/Kr2Ct7wdOBE/kUygN80/SP4cDtUfkbglBoOo2ApxkAhH4I/m/C95qDYm3ZgateqOUvXAOtVpL7nIsLCL1Pm0T0Slyx/htyf+9u3Raydt3aCU0t1UPHL7WYdK4RPhI+Zurv+okswkhv6HwG/UMwHjrUhu7ewtMxShHEXiJ0brRkeIWQszLfAfNZ/Unovx/FIwbKaxayEOfN9zeGQhtUnbZX2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3355.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(186003)(52116002)(2906002)(316002)(6496006)(6916009)(9576002)(4326008)(38100700002)(66476007)(5660300002)(26005)(55016003)(38350700002)(8676002)(1076003)(9686003)(8936002)(66946007)(3716004)(33716001)(44832011)(956004)(86362001)(66556008)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTRsVk5TdXQwaUp3d0ZINmRQV2NnWm1OMnRhWHNFWW1oM0dmd0dXYm9kTzdq?=
 =?utf-8?B?TWoxempLSHRkRTNJT1BIMG0zeE93SS80Y1lrbXVUcytWZTY2MjkybzBwU3lC?=
 =?utf-8?B?ejA2bW1WOENnZ2c3Q1hqR2NVK1NzRUtDSG1aNStJTm82bklPaDdMNGllQ0tm?=
 =?utf-8?B?L3BiSjNwZ2tpNlNDbkNoeVdKdnNRS01wOWQ1Y0JrZ3VoaEdwQ3VlUTcvTWRE?=
 =?utf-8?B?WmdhSGNxSGhxWm5LUEhGZk1HUWhWY09HeVR6U1cvZjR6aUdyV3hTRFd1VnBy?=
 =?utf-8?B?TTdmMjdCWGNOUUIzUHlCd1VyQTdSZ1J3ckhPVVJYR1J6UEF1eE9MZzIrZVFv?=
 =?utf-8?B?T0dZNFh4N3g2SytrMlhvYmtMWkVrckFUWTQrc0RoNXFIZnRMR0UwcEJrSGpK?=
 =?utf-8?B?bEFPL2NGaUVEeEZyWXJ3aWVMMlhpREZoUVA1Vm82VXFnaitHWlhUbjVLcVJp?=
 =?utf-8?B?SXNRaWxHYTFIM1pOTFFxclVBVU1iY0ZHSmRYOXNsTmVydHFQN0FpdExKdVBo?=
 =?utf-8?B?TEplUW1GTy9MM1hCTzBIbGkwRVBKRitRd2VwTC9TVnBNNzdCcHJsRUJiMVRE?=
 =?utf-8?B?TEdvdHI1MUdscW1hckpxTTJwTERUZVp1K3dyRjc2cHpCQWFBakJnaU9aZUpZ?=
 =?utf-8?B?dHBSVXpGUTJWb1ZQSWRSeXFTdUFGRStWSkZ1OE8vdyt1TThId3F4L1J4bmVk?=
 =?utf-8?B?NUpnMjg2SGlkVCtzMkg1WmJRK0RxOFFjcGZhVDI1bDhSdnBiNXhOV2lzQyt0?=
 =?utf-8?B?ZEZSTEhnYU83WlJYalVaaXlvRGpBejVnNUZ3N0pVV1JVYlVYQVJFR1ZhdUs0?=
 =?utf-8?B?by9YdzZIT1BzekVOSVp2TUM3VWpuSjZMeStGQUxUdEtldEsvWGgvS3BZWjZ6?=
 =?utf-8?B?V1UwV0R2SG1wcncxRXdXTWsybWZQU0l4djlRemNiR3kzQUVUYjZudytkQzM3?=
 =?utf-8?B?NDhXV1o1TE9oMkZ2SzNCb1l3emJ5Vk84eDdQT3FyVEsyVTVldFNJV2xZSm8r?=
 =?utf-8?B?R2hlTGM5UXo0ZG5XQmI3MndiR2xoaEZZNWUzL1p3b1RaQ1dVck1id0xxbGFK?=
 =?utf-8?B?WkcrOWEyWjY4MUg2SVUyR21WOW1UcVVPTmFQbERzcUorMUQrOUx2UUpZWHVN?=
 =?utf-8?B?WUMyZUQzVVlsTnJjcjIwRHBBOWlNbjNJYUZ0dUdJWEFDRFBNeWI2bENWRmd4?=
 =?utf-8?B?RVovSGZJdEJHb3dVREpFTUtMNENjRWFwZnJVZUc4eE83eC9tTjhCZmdHLzV6?=
 =?utf-8?B?dUFsSmVJZW5SVFhSeHFCaUxud2ZjbkFPY3JnWWNiOEF4SDBYU2dZOXAydkRN?=
 =?utf-8?B?Q0tKbGpCK3EyNlhTc1J4NzZ4YkQ4eEdlNHB2dEZBOEk2MjJML1o2OTluY0pG?=
 =?utf-8?B?TXJFWkhjajd1RXp4cm85LzFYYTdjamRhTlBUTnI1ckJrQ00xV2FLbnpVb1U4?=
 =?utf-8?B?SENFN1h5YW9PZkhsclM1azZTV2ZQcGtQRi8ycDdxcmpDbkJIakV1d3IvOVRV?=
 =?utf-8?B?WkhJVXBaN1JLM1VGM2xmc1F1ZmIrYmw2eUJrSzdvbGxDcTN2OUZYWnFRem1t?=
 =?utf-8?B?bnlJOUNyenVIV1ZhU21KQ0ZCMEQ4dXFEQ1BjbWdvZDlpR2paQ0FmTTA1dG5G?=
 =?utf-8?B?QjMyWmx2YW9rbUxGandRSkVlcVlhdmNKRVNRa0Q0QjQrVldxZUhmd0M4SnU2?=
 =?utf-8?B?TVZleG1NR3p3U0ZlZDdzcVI2VWpZZUMzZVhmNnZLdVhaMmI1aGh4L3FmR3hZ?=
 =?utf-8?B?RmR1UFFNdkZXSTRWQ2Vuc1BOZ2RJVjFFdTNMY0JFZ1VmdnlTc1FtbTVoM3pW?=
 =?utf-8?B?dmpsTUVxRjFiWGU0YUZnWmZldnpOUVRpK25yekhBMWpOZVFCT3J5Qk1leEdx?=
 =?utf-8?B?Wm1UREtJYXhQQmJXbXRBV2dpSUM2KzhqZ3NRc1Y4dHZoOTlxanlZc0ZqUHpj?=
 =?utf-8?B?QU94eVZYclErd3ppT2pkVDhsdmRyTERMcTZ5U1k4aW9LcjBDc0YyNzZqdjEw?=
 =?utf-8?B?QS9OeGNOUTdDcEErVjBSOG9KU3pSUEYzRmV0SFkvNEpKdFpPd3pZWmNnRkZl?=
 =?utf-8?B?Lyt2ejV5UGg1a3NyMzN1c2JyTzBxclV5UUpQN0xLVVdBSWI1b2JRSGQxazhG?=
 =?utf-8?B?aVU2eVJmS21aNGdOK2gxVkJNYXNuR1BNdHNIc3RkajBoUk9hazFhVEk1eHpN?=
 =?utf-8?B?d2llVTJEVlRDWXlQWTRwV0k1dk9lQUdtUy9BSnZZZmU0bzB5STRLQzJmOStI?=
 =?utf-8?B?SlFPVURGd0tzNTR6Sk1uMm05SnBkNE9jUGJDM09VYXgzcC9OczllWlFlVHlX?=
 =?utf-8?B?TUtzVTcxMEFJYUxRMk1qNlMycVorVmkvcmE4aFZObnNuWllxOUFkZz09?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcec19bb-87bf-4ead-7fcd-08d9be1d449d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3355.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 09:45:17.0230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9M/NS+nKceX6velpGqRNeTGzYNAKR/89baPUQ8M7XHXUZ8n0FTUFQtq4wSp7VEVE4UEe5uc2reIReLIydGDtYfiT8DVzX1UoaEazkro7jjJLpWQLmm3sA7to5s6h9EJX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3594
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

On Wed, Dec 08, 2021 at 11:14:01AM +0100, Ulf Hansson wrote:
> + Avri
> 
> On Thu, 2 Dec 2021 at 17:19, Quentin Schulz
> <quentin.schulz@theobroma-systems.com> wrote:
> >
> > JEDEC 5.1 JESD84-B50.1 DEVICE_TYPE [196] specifies that bit 6 is for
> > "HS400 Dual Data Rate e•MMC at 200 MHz – 1.8 V I/O" and bit 7 for
> > "HS400 Dual Data Rate e•MMC at 200 MHz – 1.2 V I/O" so let's add those.
> >
> > Cc: Quentin Schulz <foss+kernel@0leil.net>
> 
> Future wise, please don't use this to cc yourself another email. No
> need to resend this time.
> 

I've contributed to OSS projects with three different companies, each
obviously having a different mail address.

The point of the Cc was to be nice and give a way to contact me, were my
mail address in the SoB to bounce in a few years.

How do you usually handle that? or do you not care that much? Being
curious how different project tackle this kind of issues.

> > Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> Even if the patch is trivial and looks good to me, I have added Avri
> who helps to maintain mmc-utils, to make sure there are no objections.
> 

Thanks for forwarding to the appropriate people.

BTW, I struggled to find how to contribute to mmc-utils, would anyone be
ok with adding a CONTRIBUTING or README at the root of the project?

Kind regards,
Quentin
