From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/5] mmc: omap_hsmmc: Enable omap_hsmmc for Keystone 2
Date: Thu, 22 Oct 2015 11:28:55 +0200
Message-ID: <CAPDyKFr6qt60gECs5y=Qq6XbFhiqWGrOcMozB4vNwaR8PHnu4A@mail.gmail.com>
References: <1445377809-12516-1-git-send-email-fcooper@ti.com>
	<1445377809-12516-2-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445377809-12516-2-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>, Muralidharan Karicheri <m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>
List-Id: linux-mmc@vger.kernel.org

On 20 October 2015 at 23:50, Franklin S Cooper Jr <fcooper@ti.com> wrote:
>
> From: Lokesh Vutla <lokeshvutla@ti.com>
>
> Enable omap_hsmmc for Keystone 2 architecture which reuses the HSMMC
> IP found on OMAP platforms.
>
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 8a1e349..2ccec71 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -366,7 +366,7 @@ config MMC_OMAP
>  config MMC_OMAP_HS
>         tristate "TI OMAP High Speed Multimedia Card Interface support"
>         depends on HAS_DMA
> -       depends on ARCH_OMAP2PLUS || COMPILE_TEST
> +       depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || COMPILE_TEST

How about:
"depends on ARM || COMPILE_TEST"

>
>         help
>           This selects the TI OMAP High Speed Multimedia card Interface.
>           If you have an omap2plus board with a Multimedia Card slot,
> --
> 2.6.1
>

Kind regards
Uffe
