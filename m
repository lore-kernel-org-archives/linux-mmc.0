From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] mmc:sdhci:add support to request/free pins for
 controllers sharing hardware bus
Date: Mon, 25 Apr 2011 20:48:45 -0700
Message-ID: <6DDE4CDE-F6ED-4B5C-A486-E97185AEFCEB@marvell.com>
References: <5EB3BFCD089AD643B9BB63439F5FD5E9A127@SHAASIEXM01.ASIA.ROOT.PRI>
 <BANLkTinj4pnDG=cCJY3JGYGXOYoVPHtA9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:50236 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932970Ab1DZDtx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 25 Apr 2011 23:49:53 -0400
In-Reply-To: <BANLkTinj4pnDG=cCJY3JGYGXOYoVPHtA9A@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Binghua.Duan@csr.com" <Binghua.Duan@csr.com>, "andreiw@motorola.com" <andreiw@motorola.com>


Hi Barry,

How are SDIO interrupts handled ?

Philip

On Apr 25, 2011, at 8:34 PM, Barry Song wrote:

> From: Bin Shi <bin.shi@csr.com>
> 
> some controllers share data bus or other pins between
> multi-controllers and need to switch the functions of shared pins
> runtime.
> this patch requested those shared pins before actual hardware access
> and release them after access
> 
> Signed-off-by: Bin Shi <bin.shi@csr.com>
> Cc: Binghua Duan <binghua.duan@csr.com>
> Cc: Andrei Warkentin <andreiw@motorola.com>
> Cc: Philip Rakity <prakity@marvell.com>
> Signed-off-by: Barry Song <21cnbao@gmail.com>
> ---
>  drivers/mmc/host/sdhci.c |   13 +++++++++++++
>  drivers/mmc/host/sdhci.h |    2 ++
>  2 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f70e21e..92ae9f7 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1143,6 +1143,13 @@ static void sdhci_request(struct mmc_host *mmc,
> struct mmc_request *mrq)
> 
>        host = mmc_priv(mmc);
> 
> +       /*
> +        * some controllers share data bus or other pins between
> multi-controller
> +        * and need to switch the function of pins runtime
> +        */
> +       if (host->ops->get_shared_pins)
> +               host->ops->get_shared_pins(host);
> +
>        spin_lock_irqsave(&host->lock, flags);
> 
>        WARN_ON(host->mrq != NULL);
> @@ -1417,6 +1424,12 @@ static void sdhci_tasklet_finish(unsigned long param)
>        spin_unlock_irqrestore(&host->lock, flags);
> 
>        mmc_request_done(host->mmc, mrq);
> +
> +       /*
> +        * release shared pins so that other controllers can use them
> +        */
> +       if (host->ops->put_shared_pins)
> +               host->ops->put_shared_pins(host);
>  }
> 
>  static void sdhci_timeout_timer(unsigned long data)
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index c6e25a7..5a26cfe 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -231,6 +231,8 @@ struct sdhci_ops {
>        unsigned int    (*get_ro)(struct sdhci_host *host);
>        void    (*platform_reset_enter)(struct sdhci_host *host, u8 mask);
>        void    (*platform_reset_exit)(struct sdhci_host *host, u8 mask);
> +       unsigned int    (*get_shared_pins)(struct sdhci_host *host);
> +       unsigned int    (*put_shared_pins)(struct sdhci_host *host);
>  };
> 
>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> --
> 1.7.1

