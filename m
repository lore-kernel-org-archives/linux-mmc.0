From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: Do not use platform_get_irq() to count
 interrupts
Date: Wed, 2 Oct 2019 12:11:45 +0300
Message-ID: <bc48041c-df06-8108-9c45-3dfb1d527678@cogentembedded.com>
References: <20191001180703.910-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191001180703.910-1-geert+renesas@glider.be>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Stephen Boyd <swboyd@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 01.10.2019 21:07, Geert Uytterhoeven wrote:

> As platform_get_irq() now prints an error when the interrupt does not
> exist, counting interrupts by looping until failure causes the printing

   s/the//?

> of scary messages like:
> 
>      renesas_sdhi_internal_dmac ee140000.sd: IRQ index 1 not found
> 
> Fix this by using the platform_irq_count() helper to avoid touching
> non-existent interrupts.
> 
> Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to platform_get_irq*()")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This is a fix for v5.4-rc1.
> ---
>   drivers/mmc/host/renesas_sdhi_core.c | 26 ++++++++++++++------------
>   1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index d4ada5cca2d14f6a..122f429602d825bd 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
[...]
> @@ -825,24 +825,26 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>   		host->hs400_complete = renesas_sdhi_hs400_complete;
>   	}
>   
> -	i = 0;
> -	while (1) {
> +	/* There must be at least one IRQ source */
> +	num_irqs = platform_irq_count(pdev);
> +	if (num_irqs < 1) {
> +		ret = num_irqs;
> +		goto eirq;

    This will return 0 with failed probe if 'num_irqs' is 0, I don't think you 
want this...

[...]

MBR, Sergei
