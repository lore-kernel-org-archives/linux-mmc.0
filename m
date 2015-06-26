From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: msm: Boost controller core clock
Date: Fri, 26 Jun 2015 14:59:22 +0300
Message-ID: <1435319962.32171.10.camel@linaro.org>
References: <1435317417-369-1-git-send-email-ivan.ivanov@linaro.org>
	 <558D38DF.1080201@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33189 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbbFZL70 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Jun 2015 07:59:26 -0400
Received: by wiwl6 with SMTP id l6so43427524wiw.0
        for <linux-mmc@vger.kernel.org>; Fri, 26 Jun 2015 04:59:25 -0700 (PDT)
In-Reply-To: <558D38DF.1080201@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Peter Griffin <peter.griffin@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org


On Fri, 2015-06-26 at 14:34 +0300, Georgi Djakov wrote:
> On 06/26/2015 02:16 PM, Ivan T. Ivanov wrote:
> > Ensure SDCC is working with maximum clock otherwise card
> > detection could be extremely slow, up to 7 seconds.
> > 
> > Signed-off-by: Ivan T. Ivanov ivanov@linaro.org>
> > ---
> >  drivers/mmc/host/sdhci-msm.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> > index 4a09f76..b2556bc 100644
> > --- a/drivers/mmc/host/sdhci-msm.c
> > +++ b/drivers/mmc/host/sdhci-msm.c
> > @@ -489,6 +489,11 @@ static int sdhci_msm_probe(struct platform_device *pdev)
> >                 goto pclk_disable;
> >         }
> > 
> > +       /* Vote for maximum clock rate for maximum performance */
> > +       ret = clk_set_rate(msm_host->clk, INT_MAX);
> > +       if (ret)
> > +               dev_warn(&pdev->dev, "core clock boost falied\n");
> 
> failed?
> 
> Otherwise looks good to me.
> 

Oops, will fix.

Thanks,
Ivan

> > +
> >         ret = clk_prepare_enable(msm_host->clk);
> >         if (ret)
> >                 goto pclk_disable;
> > --
> > 1.9.1
> > 
> 
> 
