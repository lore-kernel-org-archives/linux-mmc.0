From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: release correct resource
Date: Tue, 17 Apr 2012 12:13:53 +0530
Message-ID: <CANfBPZ-ZyQ8Wk1OkR-sgs=OCyDOn7hWqnqNTkzbZyVx0sFXNtA@mail.gmail.com>
References: <20120414134125.GT24211@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120414134125.GT24211@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Sat, Apr 14, 2012 at 7:11 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> res can be one of several resources, as this variable is re-used seve=
ral
> times during probe. =A0This can cause the wrong resource parameters t=
o be
> passed to release_mem_region().
>
> Get the original memory resource before calling release_mem_region().
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A04 +++-
> =A01 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index d12bdbe..4b2e1f0 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2027,7 +2027,9 @@ static int __devinit omap_hsmmc_probe(struct pl=
atform_device *pdev)
> =A0err_alloc:
> =A0 =A0 =A0 =A0omap_hsmmc_gpio_free(pdata);
> =A0err:
> - =A0 =A0 =A0 release_mem_region(res->start, resource_size(res));
> + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + =A0 =A0 =A0 if (res)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_mem_region(res->start, resource=
_size(res));
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> --

Thanks Russell. I'll send it to Chris to be queued for 3.4-fixes.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
