From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [Query] mmc/sdhci: Suspend hangs if card is inserted at suspend.
Date: Thu, 17 Nov 2011 18:46:58 +0100
Message-ID: <4EC54892.5010906@stericsson.com>
References: <4EBCC49E.5060008@st.com> <877h36hvki.fsf@laptop.org> <4EC1FCC1.6070609@st.com> <5D8008F58939784290FAB48F549751984E6510F91D@shsmsx502.ccr.corp.intel.com> <4EC21EC1.2090607@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:35619 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751333Ab1KQRrU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2011 12:47:20 -0500
In-Reply-To: <4EC21EC1.2090607@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, Viresh KUMAR <viresh.kumar@st.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shiraz HASHIM <shiraz.hashim@st.com>, Armando VISCONTI <armando.visconti@st.com>

Sujit Reddy Thumma wrote:
> Hi Ulf,
> 
> I see similar issue with your patch in 3.2 "mmc: core: Prevent too long 
> response times for suspend".
> 
>                  if (mmc_try_claim_host(host)) {
> <snip>
> /* if CONFIG_MMC_UNSAFE_RESUME is not set, remove() callback would get 
> blocked until mmcqd gets mmc_claim_host() causing deadlock here */
>                                  if (host->bus_ops->remove)
>                                          host->bus_ops->remove(host);
> <snip>

You are definitely right. I did not test my patch properly, without 
CONFIG_MMC_UNSAFE_RESUME, I realize now.

>                  } else {
>                          err = -EBUSY;
>                  }
>          }
> 
> Proabably, we can do something like this:
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 5278ffb..0177d4a 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2309,6 +2309,7 @@ int mmc_suspend_host(struct mmc_host *host)
>                                   * We simply "remove" the card in this 
> case.
>                                   * It will be redetected on resume.
>                                   */
> +                               mmc_do_release_host(host);
>                                  if (host->bus_ops->remove)
>                                          host->bus_ops->remove(host);
>                                  mmc_claim_host(host);
> @@ -2317,8 +2318,9 @@ int mmc_suspend_host(struct mmc_host *host)
>                                  mmc_release_host(host);
>                                  host->pm_flags = 0;
>                                  err = 0;
> +                       } else {
> +                               mmc_do_release_host(host);
>                          }
> -                       mmc_do_release_host(host);

Your changes looks feasible! Thanks for fixing this issue!


>                  } else {
>                          err = -EBUSY;
>                  }
> 
> Please let me know if you agree. I can post a patch for this.
> 


BR
Ulf Hansson
