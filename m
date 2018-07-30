From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] mmc: sunxi: remove output of virtual
 base address
Date: Mon, 30 Jul 2018 17:06:39 +0200
Message-ID: <CAPDyKFpa=BHDQfBFxc6LUjq1fBuC2=rqYp28xWS3QBc=rTOYjQ@mail.gmail.com>
References: <20180723153431.8669-1-andre.przywara@arm.com>
Reply-To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDF57NG2XIHRBAGT7TNAKGQE7WX3EII-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20180723153431.8669-1-andre.przywara-5wv7dgnIgG8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 23 July 2018 at 17:34, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org> wrote:
> Recent Linux versions refuse to print actual virtual kernel addresses,
> to not give a hint about the location of the kernel in a randomized virtual
> address space. This affects the output of the sunxi MMC controller
> driver, which now produces the rather uninformative line:
>
> [    1.482660] sunxi-mmc 1c0f000.mmc: base:0x(____ptrval____) irq:8
>
> Since the virtual base address is not really interesting in the first
> place, let's just drop this value. The same applies to Linux' notion of
> the interrupt number, which is independent from the GIC SPI number.
> We have the physical address as part of the DT node name, which is way
> more useful for debugging purposes.
> To keep a success message in the driver, we make this purpose explicit
> with the word "initialized", plus print some information that is not too
> obvious and that we learned while probing the device:
> the maximum request size and whether it uses the new timing mode.
> So the output turns into:
> [    1.750626] sunxi-mmc 1c0f000.mmc: initialized, max. request size: 16384 KB, uses new timings mode
> [    1.786699] sunxi-mmc 1c11000.mmc: initialized, max. request size: 2048 KB
>
> Signed-off-by: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sunxi-mmc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 8e7f3e35ee3d..c18cf035ac00 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1407,7 +1407,10 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
>         if (ret)
>                 goto error_free_dma;
>
> -       dev_info(&pdev->dev, "base:0x%p irq:%u\n", host->reg_base, host->irq);
> +       dev_info(&pdev->dev, "initialized, max. request size: %u KB%s\n",
> +                mmc->max_req_size >> 10,
> +                host->use_new_timings ? ", uses new timings mode" : "");
> +
>         return 0;
>
>  error_free_dma:
> --
> 2.14.4
>
