From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RESEND 04/12] mmc: sdhci-pxav3: Remove unused clk_enable
 from sdhci_pxa
Date: Mon, 27 Oct 2014 14:39:20 +0100
Message-ID: <CAPDyKFokMoL7ueeQf_vMAhJJ9SZJPBy0AZFWrGtDFyv5iR1wrg@mail.gmail.com>
References: <1413883364-681-1-git-send-email-sebastian.hesselbarth@gmail.com>
	<1413883364-681-5-git-send-email-sebastian.hesselbarth@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413883364-681-5-git-send-email-sebastian.hesselbarth@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Chris Ball <chris@printf.net>, =?UTF-8?Q?Antoine_T=C3=A9nart?= <antoine.tenart@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 21 October 2014 11:22, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:
> clk_enable from struct sdhci_pxa is unused, remove it from the privat=
e
> driver data.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com=
>

Thanks! Applied for next!

Kind regards
Uffe


> ---
> Cc: Chris Ball <chris@printf.net>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: "Antoine T=C3=A9nart" <antoine.tenart@free-electrons.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/mmc/host/sdhci-pxav3.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-=
pxav3.c
> index 48bc8179c8fc..d1f63d32b2cd 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -59,7 +59,6 @@
>  #define SDCE_MISC_INT_EN       (1<<1)
>
>  struct sdhci_pxa {
> -       u8      clk_enable;
>         u8      power_mode;
>  };
>
> --
> 2.1.1
>
