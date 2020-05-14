Return-Path: <SRS0=Uo47=64=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C81AC433DF
	for <linux-mmc@archiver.kernel.org>; Thu, 14 May 2020 05:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1562206B6
	for <linux-mmc@archiver.kernel.org>; Thu, 14 May 2020 05:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="e6yV7w5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgENFp1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 May 2020 01:45:27 -0400
Received: from mail-mw2nam10on2062.outbound.protection.outlook.com ([40.107.94.62]:6171
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725788AbgENFp0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 14 May 2020 01:45:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzI0Hcronl/c8q2u5fLDE7Oo3lncHNmiE1ntxNUEcOfXhr3XtVODHj05GoRKWAmMtR8SU6X9yMvG1u0yOYIRZWzpYcMUVoXOqnyjPzwLp6We2QoXV9jOAPX42uLxenAtX7CFwLO5fdjoFC9MpIkRmpV0QgrtVFbDsWIyCW9R5XFzd1I9+klWt5MZw5yjRsc+oUJ1br8YOTbhza0cdKQMuweHkRCG1993rqlbE9wtrTZIPQZWIvj6WoWO2aqcetcfbuL0r/L7J0AwaVj2Ofi43+UfDGJcRrdEo5dVQ3AACparFglkX0PR/80Oq8/FFSKAqC2ZkLeldGfYugIZFvKasg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArkW/HFMb27nayLDxyZKBgq93jVJk6WQt1UUtfOHKWo=;
 b=gSyVosgqjPQ/qLxdpRTjtnBu4CcJv0NICdvXab++Uqyd1RKez1BhcgfkM5Cp6KYaDGWXbEWHJURV5na8dJWZqwR30meSkVjMT81kFMkBxf0MVxJYxPyfvhThT0T8jRQaNg8t2uBwCVMXs43UHnwU57UDP1/taGGcY58iuwCEZ+YRKdY8bE/CzSHB6CVRXZ+iz6IYDTBTIGxURL4GqX1gbBitYLxnyLe3w90k+AewlHc8T9G0uxhVE1BPoPmCa2CNyjUWYlJ2xztbVnofa5Tx2Agn6HZxlCRVa/L1e3Uz7KCREtXoICB1bmTdukGSsPPbo5u4U9T+3Zzfs18o1d4fmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArkW/HFMb27nayLDxyZKBgq93jVJk6WQt1UUtfOHKWo=;
 b=e6yV7w5+dUqZrqFaJVFwx/dejrOE2yCgCUBzyRnKo7cLZMK8b8u7AdtC/C9NV2FOCoZNEZapCgmOZ79kzJe0bS9XZhySf6oa1g7rsQrz0VQZ2Fope2kRjY+WNVgLBWPjenc/eUbdJI4HnEmxRDjUwRPEB2FtmDAr2dgQ4wZ9+5U=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=synaptics.com;
Received: from BYAPR03MB3573.namprd03.prod.outlook.com (2603:10b6:a02:ae::15)
 by BYAPR03MB3573.namprd03.prod.outlook.com (2603:10b6:a02:ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Thu, 14 May
 2020 05:45:22 +0000
Received: from BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d8fb:de22:43b7:fcb7]) by BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d8fb:de22:43b7:fcb7%7]) with mapi id 15.20.2979.033; Thu, 14 May 2020
 05:45:22 +0000
Date:   Thu, 14 May 2020 13:45:07 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "mmc: sdhci-xenon: add runtime pm support and
 reimplement standby"
Message-ID: <20200514134507.54c17936@xhacker.debian>
In-Reply-To: <CAPDyKFpE_uqiNQ22Fq9hDfb5pzMBdgmwgUbasEsEdXFkEOmq6A@mail.gmail.com>
References: <20200513174706.3eeddb2b@xhacker.debian>
        <CAPDyKFpE_uqiNQ22Fq9hDfb5pzMBdgmwgUbasEsEdXFkEOmq6A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:404:f6::27) To BYAPR03MB3573.namprd03.prod.outlook.com
 (2603:10b6:a02:ae::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TY2PR04CA0015.apcprd04.prod.outlook.com (2603:1096:404:f6::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Thu, 14 May 2020 05:45:20 +0000
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f51e4e1c-b680-426d-af11-08d7f7c9fe2c
X-MS-TrafficTypeDiagnostic: BYAPR03MB3573:
X-Microsoft-Antispam-PRVS: <BYAPR03MB3573D6CFE583C338A36CCE0CEDBC0@BYAPR03MB3573.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zj7/kpX33SiZZYRu1KO37tUpC4iTWV7zL4HDJllMEhOUDAepOyz3chXWsBTJ5Lyt4POSXcJqprmJNPobnp/XhUR2XfTR0mY38ZyhYRv34oJvBKk2WPLQvFjQ1ZErvmGy9CbAJCDKXwIfnfhVNPcaOpBCHuHYu2TpYY3ZC0Uo6X0fIcRyCKyHtEYAmG8uaZ1HY1RPDbG4IjQcEjWVGbivwCyQxe1wUFjkbKE+tBr1vGi5bh/+jlBOXsVWcmmVkweJOVPmSsqDxkYwU7xyDjjJQ0imU+3ltQKzIpWROrrUmenvCekKJMUJD0pHoXC8BON7BHttztVYQUbqOprVWoL0hU7MY+4/THGmee8FaG+dn4fr9rQx7k0U3T6VoZxhLebljDY/femrtOXYXYCsNDKWjANpTSRRWnCQulTTHHDBlRQk3OpmT/yJVMn1G7fQlED4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3573.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(346002)(376002)(366004)(39860400002)(7696005)(52116002)(6666004)(54906003)(9686003)(2906002)(55016002)(316002)(6916009)(478600001)(86362001)(1076003)(66476007)(5660300002)(26005)(66946007)(8676002)(6506007)(16526019)(956004)(4326008)(8936002)(66556008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: xjK5rixhy/7oezfD/Bl9G7Y+lhegjZG77zv/61Qy5dMai+ggq5Hx1J/2n0c0e7GYKYA5wAfUnxpiDWYb4Ztqulv0tv6suofJ9s5D89Rk8ZDQCDYO1MhkuzDQCSKM2jWBl9lZk4+ixcUnZGev3OIMwqMMHAnCTFhkAwKUK/Re6Ny0qp+IzRbsAgHuqKVa67nQQyBqHlgv/o1bPh/7KaE/KZNM9aQWIEB+/kma6fsr5+q9mc4RaW/buEmLnlpYbYGwwdg92z/9Z71qUrflJyvqL245wFOlNcMivywBOvP/muQBeN3amE/nwMArcaQEwyeYzLvIZdActC+uTtm9g7+VE3Z0WbEtNbigF3Nl05yv/A0gInoNZM7p13cqe2RTCCL1diDtPRIboqQvmg5hrMs52wxOWJBp+koAiq+uwGDYF2pfBUWbMxXEmpukHZuPjXGqnSZImsM7ZJ06Udv6fyab7a/7aRy27F2VfF0D1MH7zVLWb8Y7KsGP84L4xA+v4JiJ
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f51e4e1c-b680-426d-af11-08d7f7c9fe2c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 05:45:22.3411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QymwCzVsAt7wG4gG2uRwKcM/TVdV+7I3pthS/uu0c73AmX2xSriItsaxlOjaTzCGYzA4VM0Bs6nVljZMVHFHgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3573
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 13 May 2020 14:15:21 +0200 Ulf Hansson wrote:

> 
> 
> On Wed, 13 May 2020 at 11:47, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> >
> > This reverts commit a027b2c5fed78851e69fab395b02d127a7759fc7.
> >
> > The HW supports auto clock gating, so it's useless to do runtime pm
> > in software.  
> 
> Runtime PM isn't soley about clock gating. Moreover it manages the

Per my understanding, current xenon rpm implementation is just clock gating.

> "pltfm_host->clk", which means even if the controller supports auto
> clock gating, gating/ungating the externally provided clock still
> makes sense.

       clock -----------  xenon IP
      |___ rpm           |__ HW Auto clock gate

Per my understanding, with rpm, both clock and IP is clock gated; while with
Auto clock gate, the IP is clock gated. So the only difference is clock itself.
Considering the gain(suspect we have power consumption gain, see below), the
pay -- 56 LoCs and latency doesn't deserve gain.

Even if considering from power consumption POV, sdhci_runtime_suspend_host(),
sdhci_runtime_resume_host(), and the retune process could be more than the clock
itself.


> 
> Kind regards
> Uffe
> 
> >
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  drivers/mmc/host/sdhci-xenon.c | 87 +++++++---------------------------
> >  drivers/mmc/host/sdhci-xenon.h |  1 -
> >  2 files changed, 16 insertions(+), 72 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> > index 4703cd540c7f..85414e13e7ea 100644
> > --- a/drivers/mmc/host/sdhci-xenon.c
> > +++ b/drivers/mmc/host/sdhci-xenon.c
> > @@ -15,8 +15,6 @@
> >  #include <linux/ktime.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > -#include <linux/pm.h>
> > -#include <linux/pm_runtime.h>
> >
> >  #include "sdhci-pltfm.h"
> >  #include "sdhci-xenon.h"
> > @@ -539,24 +537,13 @@ static int xenon_probe(struct platform_device *pdev)
> >         if (err)
> >                 goto err_clk_axi;
> >
> > -       pm_runtime_get_noresume(&pdev->dev);
> > -       pm_runtime_set_active(&pdev->dev);
> > -       pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> > -       pm_runtime_use_autosuspend(&pdev->dev);
> > -       pm_runtime_enable(&pdev->dev);
> > -       pm_suspend_ignore_children(&pdev->dev, 1);
> > -
> >         err = sdhci_add_host(host);
> >         if (err)
> >                 goto remove_sdhc;
> >
> > -       pm_runtime_put_autosuspend(&pdev->dev);
> > -
> >         return 0;
> >
> >  remove_sdhc:
> > -       pm_runtime_disable(&pdev->dev);
> > -       pm_runtime_put_noidle(&pdev->dev);
> >         xenon_sdhc_unprepare(host);
> >  err_clk_axi:
> >         clk_disable_unprepare(priv->axi_clk);
> > @@ -573,10 +560,6 @@ static int xenon_remove(struct platform_device *pdev)
> >         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >         struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> >
> > -       pm_runtime_get_sync(&pdev->dev);
> > -       pm_runtime_disable(&pdev->dev);
> > -       pm_runtime_put_noidle(&pdev->dev);
> > -
> >         sdhci_remove_host(host, 0);
> >
> >         xenon_sdhc_unprepare(host);
> > @@ -593,78 +576,40 @@ static int xenon_suspend(struct device *dev)
> >  {
> >         struct sdhci_host *host = dev_get_drvdata(dev);
> >         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > -       struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> >         int ret;
> >
> > -       ret = pm_runtime_force_suspend(dev);
> > +       ret = sdhci_suspend_host(host);
> > +       if (ret)
> > +               return ret;
> >
> > -       priv->restore_needed = true;
> > +       clk_disable_unprepare(pltfm_host->clk);
> >         return ret;
> >  }
> > -#endif
> >
> > -#ifdef CONFIG_PM
> > -static int xenon_runtime_suspend(struct device *dev)
> > +static int xenon_resume(struct device *dev)
> >  {
> >         struct sdhci_host *host = dev_get_drvdata(dev);
> >         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > -       struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> >         int ret;
> >
> > -       ret = sdhci_runtime_suspend_host(host);
> > +       ret = clk_prepare_enable(pltfm_host->clk);
> >         if (ret)
> >                 return ret;
> >
> > -       if (host->tuning_mode != SDHCI_TUNING_MODE_3)
> > -               mmc_retune_needed(host->mmc);
> > -
> > -       clk_disable_unprepare(pltfm_host->clk);
> >         /*
> > -        * Need to update the priv->clock here, or when runtime resume
> > -        * back, phy don't aware the clock change and won't adjust phy
> > -        * which will cause cmd err
> > +        * If SoCs power off the entire Xenon, registers setting will
> > +        * be lost.
> > +        * Re-configure Xenon specific register to enable current SDHC
> >          */
> > -       priv->clock = 0;
> > -       return 0;
> > -}
> > -
> > -static int xenon_runtime_resume(struct device *dev)
> > -{
> > -       struct sdhci_host *host = dev_get_drvdata(dev);
> > -       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > -       struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> > -       int ret;
> > -
> > -       ret = clk_prepare_enable(pltfm_host->clk);
> > -       if (ret) {
> > -               dev_err(dev, "can't enable mainck\n");
> > +       ret = xenon_sdhc_prepare(host);
> > +       if (ret)
> >                 return ret;
> > -       }
> > -
> > -       if (priv->restore_needed) {
> > -               ret = xenon_sdhc_prepare(host);
> > -               if (ret)
> > -                       goto out;
> > -               priv->restore_needed = false;
> > -       }
> >
> > -       ret = sdhci_runtime_resume_host(host, 0);
> > -       if (ret)
> > -               goto out;
> > -       return 0;
> > -out:
> > -       clk_disable_unprepare(pltfm_host->clk);
> > -       return ret;
> > +       return sdhci_resume_host(host);
> >  }
> > -#endif /* CONFIG_PM */
> > -
> > -static const struct dev_pm_ops sdhci_xenon_dev_pm_ops = {
> > -       SET_SYSTEM_SLEEP_PM_OPS(xenon_suspend,
> > -                               pm_runtime_force_resume)
> > -       SET_RUNTIME_PM_OPS(xenon_runtime_suspend,
> > -                          xenon_runtime_resume,
> > -                          NULL)
> > -};
> > +#endif
> > +
> > +static SIMPLE_DEV_PM_OPS(xenon_pmops, xenon_suspend, xenon_resume);
> >
> >  static const struct of_device_id sdhci_xenon_dt_ids[] = {
> >         { .compatible = "marvell,armada-ap806-sdhci",},
> > @@ -678,7 +623,7 @@ static struct platform_driver sdhci_xenon_driver = {
> >         .driver = {
> >                 .name   = "xenon-sdhci",
> >                 .of_match_table = sdhci_xenon_dt_ids,
> > -               .pm = &sdhci_xenon_dev_pm_ops,
> > +               .pm = &xenon_pmops,
> >         },
> >         .probe  = xenon_probe,
> >         .remove = xenon_remove,
> > diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
> > index 593b82d7b68a..2b9b96e51261 100644
> > --- a/drivers/mmc/host/sdhci-xenon.h
> > +++ b/drivers/mmc/host/sdhci-xenon.h
> > @@ -89,7 +89,6 @@ struct xenon_priv {
> >          */
> >         void            *phy_params;
> >         struct xenon_emmc_phy_regs *emmc_phy_regs;
> > -       bool restore_needed;
> >  };
> >
> >  int xenon_phy_adj(struct sdhci_host *host, struct mmc_ios *ios);
> > --
> > 2.26.2
> >  

