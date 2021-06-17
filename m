Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8936BC2B9F4
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Jun 2021 10:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60289611CE
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Jun 2021 10:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhFQKHB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhFQKHB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Jun 2021 06:07:01 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B698C06175F
        for <linux-mmc@vger.kernel.org>; Thu, 17 Jun 2021 03:04:54 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id 68so2660882vsu.6
        for <linux-mmc@vger.kernel.org>; Thu, 17 Jun 2021 03:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yc3v3gAfLxnXDzM8KeyqkmyumlBhFvvZJHDrxz2cMIU=;
        b=sI3eyR4FhUDZbzi6XsgSlIBX6O2vmLnEK0oMfoI5SmlPbHNO3BoVwb5qyzvxgc+vuC
         R7A1svAj17X/tiWOml6tNAQV84dFmYoffEbhD6MnqZ4aVe62FVO4EJ5JPZgvTCs7KIIH
         85Ehn7kD/Fp2EkJr8XwNVq23CxYCenQORBAcGvkxncV/nsZFeHTfEPDQ2/k19MPJfUU1
         j2q6v5bcOb79E7u4QdV5cVVm6cFK5q8aQqFlOupvLSzeKUeFAQFHQeAmoZMS7Ag2iuG7
         vDdudKcblojjxBs6c62twU8w/fVSumeLeBNbF9Fb/Zux+HkWPcrZWqL6yxQoFAjaxRcJ
         atZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yc3v3gAfLxnXDzM8KeyqkmyumlBhFvvZJHDrxz2cMIU=;
        b=Y/tXD+aueddNSueXJviWbiqBi+ZmqJbN1fK0AAGmnCKzf2xsz4edGYdfI3azt3st7R
         xTQRxLk0jaY04B0GGHySZ2mDY/+txOf83RR4GfPFpit08SY6d3ctaut07/ECBVAOMgr4
         uZBBtO9pVFZ8POi6CpeOl95qZDCBEnxN5Y8N5Hy+AqT3PDPm6p/EIhvyWAcMZreG6WmD
         gNcWV5OP5eo4pMKxDr0Vvtsi3iFq3I5ENcgCxL1RdTELCMBtpu8aL29sb1FfvzX2asze
         G1Fki8PAM89SgGcltGE+Md0DwJZEW9ZrBelr/shrs5ehma7ITuYavX83VUaERu4y8gYC
         YsTw==
X-Gm-Message-State: AOAM531kDpfXaYGJ7wV2FjePqbop4WHphMnBrgLymX3sqi+y+pMzsyMq
        IG/QkyPhcxniL+osZ+TmCnvdS1QY3aszQYNTn9fUAg==
X-Google-Smtp-Source: ABdhPJw29hnXb1KQzO/v8lJ0U0DUEo8Sjzq3oZXt2JE/qO1kK7A4zJfyHhgbucCOZ9JfQCjRKnVQTqu7QMYJQLRCEUQ=
X-Received: by 2002:a05:6102:386:: with SMTP id m6mr3631602vsq.48.1623924293206;
 Thu, 17 Jun 2021 03:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210603182242.25733-1-rashmi.a@intel.com> <20210603182242.25733-2-rashmi.a@intel.com>
 <397dc803-f4ea-e8d3-9956-de8b3f537e2f@xilinx.com>
In-Reply-To: <397dc803-f4ea-e8d3-9956-de8b3f537e2f@xilinx.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Jun 2021 12:04:17 +0200
Message-ID: <CAPDyKFpTf8DvauD17JR+jMH1TypgPiNs86k3YtaD4g10fRp65Q@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFvigJxQQVRDSOKAnSAxLzJdIG1tYzogc2RoY2ktb2YtYXJhc2FuOiBVc2UgY2xvYw==?=
        =?UTF-8?B?ay1mcmVxdWVuY3kgcHJvcGVydHkgdG8gdXBkYXRlIGNsa194aW4=?=
To:     Michal Simek <michal.simek@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Cc:     rashmi.a@intel.com, linux-drivers-review-request@eclists.intel.com,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon <kishon@ti.com>, Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-phy@lists.infradead.org, Mark Gross <mgross@linux.intel.com>,
        kris.pan@linux.intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com,
        Adrian Hunter <adrian.hunter@intel.com>,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 4 Jun 2021 at 08:13, Michal Simek <michal.simek@xilinx.com> wrote:
>
>
>
> On 6/3/21 8:22 PM, rashmi.a@intel.com wrote:
> > From: Rashmi A <rashmi.a@intel.com>
> >
> > If clock-frequency property is set and it is not the same as the current
> > clock rate of clk_xin(base clock frequency), set clk_xin to use the
> > provided clock rate.
> >
> > Signed-off-by: Rashmi A <rashmi.a@intel.com>
> > Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >  drivers/mmc/host/sdhci-of-arasan.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> > index 839965f7c717..0e7c07ed9690 100644
> > --- a/drivers/mmc/host/sdhci-of-arasan.c
> > +++ b/drivers/mmc/host/sdhci-of-arasan.c
> > @@ -1542,6 +1542,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
> >               }
> >       }
> >
> > +     sdhci_get_of_property(pdev);
> > +
> >       sdhci_arasan->clk_ahb = devm_clk_get(dev, "clk_ahb");
> >       if (IS_ERR(sdhci_arasan->clk_ahb)) {
> >               ret = dev_err_probe(dev, PTR_ERR(sdhci_arasan->clk_ahb),
> > @@ -1561,14 +1563,22 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
> >               goto err_pltfm_free;
> >       }
> >
> > +     /* If clock-frequency property is set, use the provided value */
> > +     if (pltfm_host->clock &&
> > +         pltfm_host->clock != clk_get_rate(clk_xin)) {
> > +             ret = clk_set_rate(clk_xin, pltfm_host->clock);
> > +             if (ret) {
> > +                     dev_err(&pdev->dev, "Failed to set SD clock rate\n");
> > +                     goto clk_dis_ahb;
> > +             }
> > +     }
> > +
> >       ret = clk_prepare_enable(clk_xin);
> >       if (ret) {
> >               dev_err(dev, "Unable to enable SD clock.\n");
> >               goto clk_dis_ahb;
> >       }
> >
> > -     sdhci_get_of_property(pdev);
> > -
> >       if (of_property_read_bool(np, "xlnx,fails-without-test-cd"))
> >               sdhci_arasan->quirks |= SDHCI_ARASAN_QUIRK_FORCE_CDTEST;
> >
> >
>
> Manish/Sai: Please retest this on Xilinx SOC.
>
> Thanks,
> Michal

I am about to queue this patch, but it would be nice to get your
confirmation and tested-by tags before doing so. Would that be
possible within the next couple of days?

Kind regards
Uffe
