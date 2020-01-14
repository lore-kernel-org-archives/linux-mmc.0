Return-Path: <SRS0=RtJ+=3D=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727D9C33C9E
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Jan 2020 15:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CBD222C4
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Jan 2020 15:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="HocCrJwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgANPxl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:53:41 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:29585 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgANPxl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 14 Jan 2020 10:53:41 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47xw3l0wKzz1p;
        Tue, 14 Jan 2020 16:53:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1579017219; bh=WJES05a9q/Yz+/GLxjqe+7uuVcSWzHk5zQpuYKeJNvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HocCrJwo5pCvfNXW11D/biBMBOR3tsJQ9Ffa1+kPlqoUrQNfoiiCgwMw1uMNO0WQ+
         bZXvvoiz6gz/kGZSiF3UeGMcIQyMNAqvyXHSbzo8Lv/GX3FMaZJK6piq3RXj83Vk+y
         pYXke4w0o06OkSPFyVyvWau6j5WHIb1pD57He0So7d8BHqqACeyPeaqWXTCxj5zZrI
         ttgajllrpHxqxFP9OL4BP9xB6OqrakEMsKUMzIn8723ckSI/4ALWfZjJ0YTtYz2nHD
         CdQmkE4C92spzqwAQap2r5jeZL4/9PO9nMvCypgDZgRsTxhCZ09pZT9bmkvzfa81t2
         JQcj+UgRdmw1A==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Tue, 14 Jan 2020 16:53:33 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci: fix minimum clock rate for v3 controller
Message-ID: <20200114155333.GA29422@qmqm.qmqm.pl>
References: <3f3b2ac4634802af591a20b1b98dc8d0158aec45.1577962196.git.mirq-linux@rere.qmqm.pl>
 <4264051e-6126-83c3-e49e-3d9050ff35ce@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4264051e-6126-83c3-e49e-3d9050ff35ce@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jan 14, 2020 at 03:08:08PM +0200, Adrian Hunter wrote:
> On 2/01/20 12:51 pm, Micha³ Miros³aw wrote:
> > For SDHCIv3+ with programmable clock mode, minimal clock frequency is
> > still base clock / max(divider). Minimal programmable clock frequency is
> > always greater than minimal divided clock frequency. Without this patch,
> > SDHCI uses out-of-spec initial frequency when multiplier is big enough:
> > 
> > mmc1: mmc_rescan_try_freq: trying to init card at 468750 Hz
> > [for 480 MHz source clock divided by 1024]
> 
> The maximum divisor in programmable clock mode is 1024.  So I do not
> understand what is wrong.  Can you explain some more?

This part of code misses the fact, that you can choose (switch) between
base clock mode and programmable clock mode. The code in
sdhci_calc_clk() already does the choosing part. This is actually
required on high programmable clock base to get conformant frequency for
the card initialization phase.

Best Regards,
Micha³ Miros³aw

[...]
> > index 275102c0a1bf..0036ddf85674 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -3902,11 +3902,9 @@ int sdhci_setup_host(struct sdhci_host *host)
> >  	if (host->ops->get_min_clock)
> >  		mmc->f_min = host->ops->get_min_clock(host);
> >  	else if (host->version >= SDHCI_SPEC_300) {
> > -		if (host->clk_mul) {
> > -			mmc->f_min = (host->max_clk * host->clk_mul) / 1024;
> > +		if (host->clk_mul)
> >  			max_clk = host->max_clk * host->clk_mul;
> > -		} else
> > -			mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_300;
> > +		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_300;
> >  	} else
> >  		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
