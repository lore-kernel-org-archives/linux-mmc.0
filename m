From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] mmc: omap: Use dma_request_chan() for requesting DMA
 channel
Date: Tue, 3 May 2016 23:00:47 +0300
Message-ID: <a7e34ffa-19d4-48fb-8d13-a151fbafd842@ti.com>
References: <1461935197-28664-1-git-send-email-peter.ujfalusi@ti.com>
 <CAPDyKFqTsJ3gcDGVWpbmQ4rzM8TQK7km3NTT=d0D9Dt7ydUafg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44992 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752195AbcECUAy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 3 May 2016 16:00:54 -0400
In-Reply-To: <CAPDyKFqTsJ3gcDGVWpbmQ4rzM8TQK7km3NTT=d0D9Dt7ydUafg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kishon <kishon@ti.com>, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 05/03/16 11:46, Ulf Hansson wrote:
> On 29 April 2016 at 15:06, Peter Ujfalusi <peter.ujfalusi@ti.com> wro=
te:
>> With the new dma_request_chan() the client driver does not need to l=
ook for
>> the DMA resource and it does not need to pass filter_fn anymore.
>> By switching to the new API the driver can now support deferred prob=
ing
>> against DMA.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> CC: Ulf Hansson <ulf.hansson@linaro.org>
>> CC: Jarkko Nikula <jarkko.nikula@bitmer.com>
>> ---
>>  drivers/mmc/host/omap.c | 45 ++++++++++++++++++++++----------------=
-------
>>  1 file changed, 22 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
>> index b9958a123594..a8d9228657b2 100644
>> --- a/drivers/mmc/host/omap.c
>> +++ b/drivers/mmc/host/omap.c
>> @@ -23,7 +23,6 @@
>>  #include <linux/spinlock.h>
>>  #include <linux/timer.h>
>>  #include <linux/of.h>
>> -#include <linux/omap-dma.h>
>>  #include <linux/mmc/host.h>
>>  #include <linux/mmc/card.h>
>>  #include <linux/mmc/mmc.h>
>> @@ -1321,8 +1320,6 @@ static int mmc_omap_probe(struct platform_devi=
ce *pdev)
>>         struct omap_mmc_platform_data *pdata =3D pdev->dev.platform_=
data;
>>         struct mmc_omap_host *host =3D NULL;
>>         struct resource *res;
>> -       dma_cap_mask_t mask;
>> -       unsigned sig =3D 0;
>>         int i, ret =3D 0;
>>         int irq;
>>
>> @@ -1382,29 +1379,31 @@ static int mmc_omap_probe(struct platform_de=
vice *pdev)
>>                 goto err_free_iclk;
>>         }
>>
>> -       dma_cap_zero(mask);
>> -       dma_cap_set(DMA_SLAVE, mask);
>> -
>>         host->dma_tx_burst =3D -1;
>>         host->dma_rx_burst =3D -1;
>>
>> -       res =3D platform_get_resource_byname(pdev, IORESOURCE_DMA, "=
tx");
>> -       if (res)
>> -               sig =3D res->start;
>> -       host->dma_tx =3D dma_request_slave_channel_compat(mask,
>> -                               omap_dma_filter_fn, &sig, &pdev->dev=
, "tx");
>> -       if (!host->dma_tx)
>> -               dev_warn(host->dev, "unable to obtain TX DMA engine =
channel %u\n",
>> -                       sig);
>> -
>> -       res =3D platform_get_resource_byname(pdev, IORESOURCE_DMA, "=
rx");
>> -       if (res)
>> -               sig =3D res->start;
>> -       host->dma_rx =3D dma_request_slave_channel_compat(mask,
>> -                               omap_dma_filter_fn, &sig, &pdev->dev=
, "rx");
>> -       if (!host->dma_rx)
>> -               dev_warn(host->dev, "unable to obtain RX DMA engine =
channel %u\n",
>> -                       sig);
>> +       host->dma_tx =3D dma_request_chan(&pdev->dev, "tx");
>> +       if (IS_ERR(host->dma_tx)) {
>> +               ret =3D PTR_ERR(host->dma_tx);
>> +               if (ret =3D=3D -EPROBE_DEFER)
>> +                       goto err_free_iclk;

and one clk_put(host->fclk) is missing from here.

>> +
>> +               host->dma_tx =3D NULL;
>=20
> Instead of setting this to NULL, let's keep its value and later check
> it with IS_ERR() when needed.

I thought about it, but decided against without need to have changes in=
 other
places in the driver.

>=20
>> +               dev_warn(host->dev, "TX DMA channel request failed\n=
");
>> +       }
>> +
>> +       host->dma_rx =3D dma_request_chan(&pdev->dev, "rx");
>> +       if (IS_ERR(host->dma_rx)) {
>> +               ret =3D PTR_ERR(host->dma_rx);
>> +               if (ret =3D=3D -EPROBE_DEFER) {
>> +                       dma_release_channel(host->dma_tx);
>=20
> host->dma_tx can be NULL here, so this isn't safe.

Oh, true.

>=20
>> +                       clk_put(host->fclk);
>> +                       goto err_free_iclk;
>> +               }
>> +
>> +               host->dma_rx =3D NULL;
>=20
> Instead of setting this to NULL, let's keep its value and later check
> it with IS_ERR() when needed.
>=20
>> +               dev_warn(host->dev, "RX DMA channel request failed\n=
");
>> +       }
>>
>>         ret =3D request_irq(host->irq, mmc_omap_irq, 0, DRIVER_NAME,=
 host);
>>         if (ret)
>> --
>> 2.8.1
>>
>=20
> Kind regards
> Uffe
>=20


--=20
P=C3=A9ter
