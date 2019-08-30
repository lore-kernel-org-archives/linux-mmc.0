From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: sdhci-of-aspeed: Uphold clocks-on post-condition
 of set_clock()
Date: Fri, 30 Aug 2019 10:01:27 +0200
Message-ID: <CAPDyKFrKXfB1F2dh63KrkCiKGbmbBWaAM16vJqtQncnF4YctQw@mail.gmail.com>
References: <20190830074644.10936-1-andrew@aj.id.au> <20190830074644.10936-2-andrew@aj.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190830074644.10936-2-andrew@aj.id.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Jeffery <andrew@aj.id.au>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Joel Stanley <joel@jms.id.au>, Ryan Chen <ryanchen.aspeed@gmail.com>, openbmc@lists.ozlabs.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-aspeed <linux-aspeed@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, 30 Aug 2019 at 09:46, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The early-exit didn't seem to matter on the AST2500, but on the AST2600
> the SD clock genuinely may not be running on entry to
> aspeed_sdhci_set_clock(). Remove the early exit to ensure we always run
> sdhci_enable_clk().
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  drivers/mmc/host/sdhci-of-aspeed.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index d5acb5afc50f..a9175ca85696 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -55,9 +55,6 @@ static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>         int div;
>         u16 clk;
>
> -       if (clock == host->clock)
> -               return;
> -
>         sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
>
>         if (clock == 0)
> --
> 2.20.1
>

Further down in aspeed_sdhci_set_clock() you should probably also
remove the assignment of host->clock = clock, as that is already
managed by sdhci_set_ios().

Kind regards
Uffe
