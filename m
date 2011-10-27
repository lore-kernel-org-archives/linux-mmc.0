From: Sebastian Rasmussen <sebras@gmail.com>
Subject: Re: [PATCH] mmc: debugfs: expose the SDCLK frq in sys ios (v3)
Date: Fri, 28 Oct 2011 00:02:40 +0200
Message-ID: <CAAgDR1N=mPVMoQNHmFvX2BvH_nmuemzQx3+z16qqS7BjQeOWDg@mail.gmail.com>
References: <1319031945-2630-1-git-send-email-peppe.cavallaro@st.com>
	<1319696209-3171-1-git-send-email-peppe.cavallaro@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44567 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099Ab1J0WCl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2011 18:02:41 -0400
Received: by ywm3 with SMTP id 3so3076714ywm.19
        for <linux-mmc@vger.kernel.org>; Thu, 27 Oct 2011 15:02:40 -0700 (PDT)
In-Reply-To: <1319696209-3171-1-git-send-email-peppe.cavallaro@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: linux-mmc@vger.kernel.org

Hi!

> +++ b/drivers/mmc/host/sdhci.c
> @@ -1107,9 +1113,13 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>                        if ((host->max_clk / div) <= clock)
>                                break;
>                }
> +               real_div = div;
>                div >>= 1;
>        }
>
> +       if (real_div)
> +               host->mmc->actual_clock = (host->max_clk * clk_mul) / real_div;

What triggered me to look at this is that usually a divider of 0 means
that the clock is not divided at all, and your code seemed to set
host->mmc->actual_clock to 0 in this case. After further inspection I
realize that real_div appears to always be >= 1 which means that the
if-statement is unnecessary. Or did I miss something?

 / Sebastian

PS. I don't have a good SDHCI spec, is it publicly available
somewhere? I have only found Pierre Ossman's old wiki on
archive.org...
