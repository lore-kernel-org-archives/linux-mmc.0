From: Balaji T K <balajitk@ti.com>
Subject: Re: Uninitialized rx_req/tx_req (was: Re: [PATCH v2 2/3] mmc: omap_hsmmc:
 Skip platform_get_resource_byname() for dt case)
Date: Thu, 12 Sep 2013 20:40:11 +0530
Message-ID: <5231D953.4070908@ti.com>
References: <CAMuHMdVVjkZBZyJe2qnUxHeRVo+8WD_Vx1ZKin_pA7XLRCW8uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVVjkZBZyJe2qnUxHeRVo+8WD_Vx1ZKin_pA7XLRCW8uw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Matt Porter <matt.porter@linaro.org>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Vinod Koul <vinod.koul@intel.com>, Tony Lindgren <tony@atomide.com>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Dan Williams <djbw@fb.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-mmc@vger.kernel.org

On Thursday 12 September 2013 06:11 PM, Geert Uytterhoeven wrote:
> On Tue, Mar 5, 2013 at 10:13 PM, Matt Porter <mporter@ti.com> wrote:
>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>
>> MMC driver probe will abort for DT case because of failed
>> platform_get_resource_byname() lookup. Fix it by skipping resource
>> byname lookup for device tree build.
>>
>> Issue is hidden because hwmod popullates the IO resources which
>> helps to succeed platform_get_resource_byname() and probe.
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>   drivers/mmc/host/omap_hsmmc.c |   28 +++++++++++++++-------------
>>   1 file changed, 15 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_h=
smmc.c
>> index e79b12d..8ae1225 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -1896,21 +1896,23 @@ static int omap_hsmmc_probe(struct platform_=
device *pdev)
>>
>>          omap_hsmmc_conf_bus_power(host);
>>
>> -       res =3D platform_get_resource_byname(pdev, IORESOURCE_DMA, "=
tx");
>> -       if (!res) {
>> -               dev_err(mmc_dev(host->mmc), "cannot get DMA TX chann=
el\n");
>> -               ret =3D -ENXIO;
>> -               goto err_irq;
>> -       }
>> -       tx_req =3D res->start;
>> +       if (!pdev->dev.of_node) {
>> +               res =3D platform_get_resource_byname(pdev, IORESOURC=
E_DMA, "tx");
>> +               if (!res) {
>> +                       dev_err(mmc_dev(host->mmc), "cannot get DMA =
TX channel\n");
>> +                       ret =3D -ENXIO;
>> +                       goto err_irq;
>> +               }
>> +               tx_req =3D res->start;
>>
>> -       res =3D platform_get_resource_byname(pdev, IORESOURCE_DMA, "=
rx");
>> -       if (!res) {
>> -               dev_err(mmc_dev(host->mmc), "cannot get DMA RX chann=
el\n");
>> -               ret =3D -ENXIO;
>> -               goto err_irq;
>> +               res =3D platform_get_resource_byname(pdev, IORESOURC=
E_DMA, "rx");
>> +               if (!res) {
>> +                       dev_err(mmc_dev(host->mmc), "cannot get DMA =
RX channel\n");
>> +                       ret =3D -ENXIO;
>> +                       goto err_irq;
>> +               }
>> +               rx_req =3D res->start;
>>          }
>> -       rx_req =3D res->start;
>>
>>          dma_cap_zero(mask);
>>          dma_cap_set(DMA_SLAVE, mask);
>
> Now this is in mainline, I get (gcc 4.1.2):
>
> drivers/mmc/host/omap_hsmmc.c: In function =91omap_hsmmc_probe=92:
> drivers/mmc/host/omap_hsmmc.c:1779: warning: =91rx_req=92 may be used
> uninitialized in this function
> drivers/mmc/host/omap_hsmmc.c:1779: warning: =91tx_req=92 may be used
> uninitialized in this function
>
> Indeed, rx_req and tx_req are not initialized in the DT case.
>
> Initializing them to zero is probably not the right fix. Where are th=
e values
> supposed to come from in the DT case?
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linu=
x-m68k.org
>
> In personal conversations with technical people, I call myself a hack=
er. But
> when I'm talking to journalists I just say "programmer" or something =
like that.
>                                  -- Linus Torvalds
>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
