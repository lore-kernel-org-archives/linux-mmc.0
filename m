From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: use goto rather than return directly
Date: Tue, 23 Oct 2018 15:01:43 +0200
Message-ID: <CAPDyKFrfwJeupJ50smx8Qu5Zpk74ATcQXGVqu5sAsFY2ou3VFw@mail.gmail.com>
References: <1539677982-13762-1-git-send-email-zhang.chunyan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539677982-13762-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <zhang.chunyan@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 16 October 2018 at 10:19, Chunyan Zhang <zhang.chunyan@linaro.org> wrote:
> The driver should clean resources requested in the function before
> unnormal return.
>
> CC: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> Fixes: bd9b902798ab ("mmc: sdhci: Implement an SDHCI-specific bounce buffer")
> ---
>  drivers/mmc/host/sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 1b3fbd9..f6b57e1 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3991,7 +3991,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>                 /* This may alter mmc->*_blk_* parameters */
>                 ret = sdhci_allocate_bounce_buffer(host);
>                 if (ret)
> -                       return ret;
> +                       goto unreg;

Instead of making the error path a bit more complicated, I suggest to
convert sdhci_allocate_bounce_buffer() from returning an int to a
void. Simply because it always returns 0 and thus we can remove this
error path altogether.

>         }
>
>         return 0;
> --
> 2.7.4
>

Kind regards
Uffe
