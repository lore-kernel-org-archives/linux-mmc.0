From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V1] mmc: sdhci: Fix sdhci_do_enable_v4_mode
Date: Mon, 17 Dec 2018 09:07:19 +0100
Message-ID: <CAPDyKFpG-70QdtGoRMbTXS9OGfb_xn2N1VTVnQK_HiZAakRP9Q@mail.gmail.com>
References: <1544733246-11678-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544733246-11678-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 13 Dec 2018 at 21:34, Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> V4_MODE is Bit-15 of SDHCI_HOST_CONTROL2 register.
> Need to perform word access to this register.
>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 99bdae53fa2e..fde984d10619 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -127,12 +127,12 @@ static void sdhci_do_enable_v4_mode(struct sdhci_host *host)
>  {
>         u16 ctrl2;
>
> -       ctrl2 = sdhci_readb(host, SDHCI_HOST_CONTROL2);
> +       ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>         if (ctrl2 & SDHCI_CTRL_V4_MODE)
>                 return;
>
>         ctrl2 |= SDHCI_CTRL_V4_MODE;
> -       sdhci_writeb(host, ctrl2, SDHCI_HOST_CONTROL);
> +       sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
>  }
>
>  /*
> --
> 2.7.4
>
