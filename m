From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] mmc: omap: Use dma_request_chan() for requesting DMA
 channel
Date: Wed, 4 May 2016 06:59:54 +0300
Message-ID: <8797d828-eb71-c747-f63a-e77762c51d82@ti.com>
References: <1461935197-28664-1-git-send-email-peter.ujfalusi@ti.com>
 <CAPDyKFqTsJ3gcDGVWpbmQ4rzM8TQK7km3NTT=d0D9Dt7ydUafg@mail.gmail.com>
 <a7e34ffa-19d4-48fb-8d13-a151fbafd842@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50187 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708AbcEDEAu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 4 May 2016 00:00:50 -0400
In-Reply-To: <a7e34ffa-19d4-48fb-8d13-a151fbafd842@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kishon <kishon@ti.com>, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 05/03/2016 11:00 PM, Peter Ujfalusi wrote:
>>> @@ -1382,29 +1379,31 @@ static int mmc_omap_probe(struct platform_d=
evice *pdev)
>>>                 goto err_free_iclk;
>>>         }
>>>
>>> -       dma_cap_zero(mask);
>>> -       dma_cap_set(DMA_SLAVE, mask);
>>> -
>>>         host->dma_tx_burst =3D -1;
>>>         host->dma_rx_burst =3D -1;
>>>
>>> -       res =3D platform_get_resource_byname(pdev, IORESOURCE_DMA, =
"tx");
>>> -       if (res)
>>> -               sig =3D res->start;
>>> -       host->dma_tx =3D dma_request_slave_channel_compat(mask,
>>> -                               omap_dma_filter_fn, &sig, &pdev->de=
v, "tx");
>>> -       if (!host->dma_tx)
>>> -               dev_warn(host->dev, "unable to obtain TX DMA engine=
 channel %u\n",
>>> -                       sig);
>>> -
>>> -       res =3D platform_get_resource_byname(pdev, IORESOURCE_DMA, =
"rx");
>>> -       if (res)
>>> -               sig =3D res->start;
>>> -       host->dma_rx =3D dma_request_slave_channel_compat(mask,
>>> -                               omap_dma_filter_fn, &sig, &pdev->de=
v, "rx");
>>> -       if (!host->dma_rx)
>>> -               dev_warn(host->dev, "unable to obtain RX DMA engine=
 channel %u\n",
>>> -                       sig);
>>> +       host->dma_tx =3D dma_request_chan(&pdev->dev, "tx");
>>> +       if (IS_ERR(host->dma_tx)) {
>>> +               ret =3D PTR_ERR(host->dma_tx);
>>> +               if (ret =3D=3D -EPROBE_DEFER)
>>> +                       goto err_free_iclk;
>=20
> and one clk_put(host->fclk) is missing from here.
>=20
>>> +
>>> +               host->dma_tx =3D NULL;
>>
>> Instead of setting this to NULL, let's keep its value and later chec=
k
>> it with IS_ERR() when needed.
>=20
> I thought about it, but decided against without need to have changes =
in other
> places in the driver.

This sentence does not make too much sense ;) Let's try it again:
So, I have considered to use PTR_ERR in the driver for the DMA channel,=
 but I
wanted to avoid too broad changes in the driver. Keeping the ERR_PTR wo=
uld
bring no runtime benefit since we only care if we have channel or not.

--=20
P=C3=A9ter
