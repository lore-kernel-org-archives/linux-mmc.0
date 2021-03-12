Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCACC43381
	for <linux-mmc@archiver.kernel.org>; Fri, 12 Mar 2021 09:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1A1F65005
	for <linux-mmc@archiver.kernel.org>; Fri, 12 Mar 2021 09:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbhCLJXA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 12 Mar 2021 04:23:00 -0500
Received: from mail-co1nam11on2089.outbound.protection.outlook.com ([40.107.220.89]:12640
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232833AbhCLJWn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 12 Mar 2021 04:22:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlDmGREfFU6g5cb2l5r/1RiRti583peZnUKbASBO0A+3hPs9C47UWQEzmw7tFj2XZz0+6wJh7fazvuqiP/8IIciDWOWSXiXu3etKeoPbjjHXHwoXbjGQtBAPBETuRUfG7oEzGxmdoDZPhLsZ6LHmitk9lXjY5NHd6hDxW2d4rFsHNJ5niVX6YEIp0bBIjCg1VxJ5ErVoe05ou7yHZcRydtvYr4EaAhCSiZbAqtSYV1Xn+5xza9wQKddZxDD9jnsFLsFdorgZ7Bo8C73Blj8uZhhTdXVm+jEukFq6JD3h3yGzBXAfaXzHWpUX/Q2CW/572DNfRPHAvsXHKBHACoSiFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOwpCyxP9SZOWLK0dwZTL1FpqWTNVuqC98KQMnt21/g=;
 b=le30Sk1DEB2Pgu34q7/am0gjm+iScksOYEg35lB5GfzQNW4w0inzzMAYAKMku9oPxqWipIztzS2pOsjkJkleAx2+tjzt9WVCkBEW6oQMRsisswBAUqAO2Eca4uA49gX5J5wumAZ53F5LH/3DW6pYJ+ySi5J/LLdld3UtZ0h8IY/4HEgZmygZxjFioRKsBAKohhoiOzqlABHPUMjjH5+fct5FI4oBxHLKab/sbfm0hNFhUebYGedXFUOockNeSjm9wsRWlTUmp9R5skl4ED2eMPfQr+ZTEqHOOkqFnXp6Z/Fz//d/OOhYdCm3taL9rTXgbaDG5K/cuvrnEh+Wb88+aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOwpCyxP9SZOWLK0dwZTL1FpqWTNVuqC98KQMnt21/g=;
 b=QQSF5uU+Q5EWZrGRFbwSO93qLNYRSU0PGPufQVx1JqVg7Ix5JxoSlZUvANLjWQJ/EHRPoHIZTpW5E+YWxlcqYLOc2qoOE4q/CVvd5QI9jly0QgsERL3fm0dJWNk5qAhps8HVre9UIcCIn4a8bI+HVZf305Wc6LlbIRsSQvzoZDw=
Authentication-Results: rock-chips.com; dkim=none (message not signed)
 header.d=none;rock-chips.com; dmarc=none action=none
 header.from=synaptics.com;
Received: from BN3PR03MB2307.namprd03.prod.outlook.com
 (2a01:111:e400:7bb1::16) by BN6PR03MB2900.namprd03.prod.outlook.com
 (2603:10b6:404:10e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 12 Mar
 2021 09:22:36 +0000
Received: from BN3PR03MB2307.namprd03.prod.outlook.com
 ([fe80::246d:2f3d:93bf:ee56]) by BN3PR03MB2307.namprd03.prod.outlook.com
 ([fe80::246d:2f3d:93bf:ee56%4]) with mapi id 15.20.3912.031; Fri, 12 Mar 2021
 09:22:36 +0000
Date:   Fri, 12 Mar 2021 17:22:23 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 3/3] mmc: sdhci-of-dwcmshc: add rockchip platform
 support
Message-ID: <20210312172223.05c537d8@xhacker.debian>
In-Reply-To: <9b7106e4-8817-6b49-e400-daa7b33a96ca@rock-chips.com>
References: <1615443684-198078-1-git-send-email-shawn.lin@rock-chips.com>
        <1615443684-198078-3-git-send-email-shawn.lin@rock-chips.com>
        <20210311145924.498c690a@xhacker.debian>
        <9b7106e4-8817-6b49-e400-daa7b33a96ca@rock-chips.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR21CA0008.namprd21.prod.outlook.com
 (2603:10b6:a03:114::18) To BN3PR03MB2307.namprd03.prod.outlook.com
 (2a01:111:e400:7bb1::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR21CA0008.namprd21.prod.outlook.com (2603:10b6:a03:114::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.3 via Frontend Transport; Fri, 12 Mar 2021 09:22:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b7b70e0-714a-45d4-b7ca-08d8e5385fb4
X-MS-TrafficTypeDiagnostic: BN6PR03MB2900:
X-Microsoft-Antispam-PRVS: <BN6PR03MB2900108206E83E974F3461D8ED6F9@BN6PR03MB2900.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D0Mjrch3+FueE++xYqkRC3XX9o0ksHIfLxtvCZVoH7g2D1QwUSGVTXjydlOH16yHIUR1LhI1KAc/0zTwken6TJ7UYlaUOVzoZm/i/jxIVFzRLQQ5BMBAjyPYTx2RdgEn+eXdPh1X8e8FMtVaEV1lh3kJ94WJzkeIwU/+jeWJH6Xm5o5jK9P8mx+2Uvf3d017hEVupNW24Ji6ySSLCH0QSxguxs7P4INlh0Yy8UQdtbKWZqlQtdBDu0WtNiaRyYPhBjwwkXx0pRfnvYXlGwgk2/sPVj8iZlFfJ4iodgW4UBE3VWt4nF/T6Rc2wKDQHuuGbErjXSVSbleGP00fNYO7ttDGebK5dSj9UO++fOg7esQjYdaVqp4ciY5JMB6vXx8L/D55XKdEP3hRjCsrVtqYXhygQSHJF2tJ8GtgXk3BIsbJurLXNouh6+gXCZu1m5n0owqoH1DHpSXaYOtnY6zm42k6sJwCnDJWG1YxbVZaUAV7MwVO4912Lfj6puhusbFEpiRcI9kkn9u+hKZONYkotp1/p2WDIFJLVNWRq2+NwFyrOfgO2BwO/uGlRD5IyCpK2QJysF5+/fo60DlPmzxjQWccSbbok9aH4zcCwplE2D8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR03MB2307.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39850400004)(366004)(346002)(376002)(136003)(83380400001)(186003)(53546011)(6506007)(16526019)(956004)(6666004)(55016002)(26005)(9686003)(316002)(5660300002)(66556008)(54906003)(66946007)(2906002)(66476007)(8676002)(1076003)(478600001)(8936002)(7696005)(86362001)(52116002)(4326008)(6916009)(133343001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MpYSan+zmpiw5vxzQl0KjEXHoOJ5jTKqN2vkxeQYpSqt6DlAnUXOE3Kahg5k?=
 =?us-ascii?Q?m9/yNgaDUJfRCY4pWhVZRVwmKb2xhMJE1q5bTmKPUPuNfbhfKijYnckyJO8z?=
 =?us-ascii?Q?UrxG2VL3V/kFGCjhmP24+NMpVX8lbezLrSjofMUlUOcfm/Y87YRQMUY3N5Nv?=
 =?us-ascii?Q?1takc3GJXpC9B3eG7jlD7aYp6/YwHwrLRRCU1SG7kank3jjqOBg7ovdW2sun?=
 =?us-ascii?Q?qx1+xZwQjQibe+ncCfmYmQX1xlxyttRdR89AlkPiXVjflPH5gUq1TixFJs5n?=
 =?us-ascii?Q?ILMdSlYOapOQAJ6D0JUslMWRULNpFCiyYDvknpgFA2cWJgd/nBCBnAIbd7SM?=
 =?us-ascii?Q?MJ4mBf8wZywA9RwmdFwnkpPoRMy3PU8AwN1U+4vibnk6Nuk8hEBFzbtpuYlZ?=
 =?us-ascii?Q?pimoV9wu4TheVLP0l58E/cOZzC6AqRv+5r6OLaDaBvSsC177i3lR7U5cG6O4?=
 =?us-ascii?Q?f1fzRSODPX1+EPkB+/9vuZbWrbazDp6aXR7WWP1EEDa/PHgbIEVxRv9B+D3y?=
 =?us-ascii?Q?/Td9Bu7YFAe4DkgNnWSerKNSRTgcp3mecw8+md6nEJqVSPUg3C/qoPECN0QJ?=
 =?us-ascii?Q?tiqlp/l3E41sOflHYYi3bTfqSUZ1JM2lX3UdW158VkmBtZwr55f1c03ekKVu?=
 =?us-ascii?Q?mrP3GSznij6RraSuZVlURn43j74EiAxrtyL3G2CkEc/hPaKG9Q2yWdig8+wV?=
 =?us-ascii?Q?BAgAUwHfjOhqQIK47ABsYGmBOw55cArIaNxbCeLI+cFF9KEBSaGMeOg4GrLk?=
 =?us-ascii?Q?LmaEjDZ8VaqCiXGrhF6ibwEaBcTvDjHzv5g2ODkbZJPy+dQOgLSTXLIukK/q?=
 =?us-ascii?Q?Ol4ExfEzymCPZ2i8qQ9/lbsAnkiRds3S6wcPku+TCZocQiVlfzFmatLKKiOA?=
 =?us-ascii?Q?dYF+F3kd6C2RvYBWDG5sJMFgHU26Z8QZgcUE0oXAl24vQn0YM9fn5tnOuJ+l?=
 =?us-ascii?Q?seydSL/Kmw5KShF7i1KLB+WNrziOiCmXuQOIVgcupyA/emf/GNK29pofhrmM?=
 =?us-ascii?Q?CHQV9lIQPWC6S9eiSuEHkFi8EMuk2EUfiPKlnIE3IYK3FKCsqjuwx9rOeV1Q?=
 =?us-ascii?Q?eToMX3GWFpLr4FTYdkkGrj2alzJB3vKkp+mp9ctNWTu0B89Wlac4CVrfortu?=
 =?us-ascii?Q?bi7sQqB67z1Yw8/OH1WGbSJ/7oe1FfWWYG9AdkNvgIkXPuEsw9ShWk2SjPPT?=
 =?us-ascii?Q?6OpIk1p6QSV66tJMeHOw4Wxo6kn15fL1+261s4OCtjM3laUVQ6YoRXn2omfG?=
 =?us-ascii?Q?x5K5yX8V0HxBy/AXUtD3ioAB4ustUOau9UtDpTJ3FjbJKvn2YuNWkxOb9fdI?=
 =?us-ascii?Q?LcZUJGbEDgloY/O7vQC6kKhp?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7b70e0-714a-45d4-b7ca-08d8e5385fb4
X-MS-Exchange-CrossTenant-AuthSource: BN3PR03MB2307.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 09:22:36.1692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHyC0bJnIt/ewrgZV8LAnH5qFeQ6WszA+PxeUS3MI2oaTh0rB+wt+PtPjMqe44RsdBWheV6smNpFWCpyRnvd2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2900
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi

On Thu, 11 Mar 2021 15:08:03 +0800
Shawn Lin <shawn.lin@rock-chips.com> wrote:


> 
> Hi Jisheng
> 
> On 2021/3/11 14:59, Jisheng Zhang wrote:
> > Hi Shawn,
> >
> > On Thu, 11 Mar 2021 14:21:24 +0800 Shawn Lin <shawn.lin@rock-chips.com> wrote:
> >  
> >>
> >> sdhci based synopsys MMC IP is also used on some rockchip platforms,
> >> so add a basic support here.
> >>
> >> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> >> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> >> ---
> >>
> >> Changes in v4:
> >> - add comments for disabling rx invert
> >> - add tag from Adrian
> >>
> >>   drivers/mmc/host/sdhci-of-dwcmshc.c | 225 ++++++++++++++++++++++++++++++++++--
> >>   1 file changed, 218 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> >> index 59d8d96..dabc1ec 100644
> >> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> >> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> >> @@ -9,9 +9,11 @@
> >>
> >>   #include <linux/clk.h>
> >>   #include <linux/dma-mapping.h>
> >> +#include <linux/iopoll.h>
> >>   #include <linux/kernel.h>
> >>   #include <linux/module.h>
> >>   #include <linux/of.h>
> >> +#include <linux/of_device.h>
> >>   #include <linux/sizes.h>
> >>
> >>   #include "sdhci-pltfm.h"
> >> @@ -21,11 +23,43 @@
> >>   /* DWCMSHC specific Mode Select value */
> >>   #define DWCMSHC_CTRL_HS400             0x7
> >>
> >> +/* Rockchip specific Registers */
> >> +#define DWCMSHC_HOST_CTRL3             0x508  
> >
> > Maybe 0x500 can be read from VENDOR_PTR_R while 0x8 is the offset?  
> 
> It should be but we didn't add this info for this IP so we have
> to hardcode the register offset.

Per my understanding, this register always exists, so mind to double check
whether you can access the register and read out 0x500. If the vendor offset
can't be read out on your side, mind to add var such as vendor_ptr etc. then
configure it as 0x500 for RK? I believe HS400 ES support code is common
to this IP, the only difference maybe the vendor offset can be dynamically
read out while RK may need to hardcode the offset as you said.

Thanks

