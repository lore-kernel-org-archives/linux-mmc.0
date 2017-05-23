From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: spi: disable dma mapping code, as it does not work
Date: Tue, 23 May 2017 12:23:21 +0200
Message-ID: <CAPDyKFoNy3cN-tbgN8xU2eT4261zObNsyYzMaCN2V-qsnTW4_Q@mail.gmail.com>
References: <c73b9ba9-1699-2aff-e2fd-b4b4f292a3ca@raspberrypi.org>
 <CAPDyKFrPZ-aByeigb7KnUFZOnzHdDFyXXcwQrRub30czXW+xKQ@mail.gmail.com> <205f0c9b-1037-437d-f87f-c51c0b58313a@raspberrypi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:36134 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758496AbdEWKXX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 May 2017 06:23:23 -0400
Received: by mail-qt0-f180.google.com with SMTP id f55so123304427qta.3
        for <linux-mmc@vger.kernel.org>; Tue, 23 May 2017 03:23:22 -0700 (PDT)
In-Reply-To: <205f0c9b-1037-437d-f87f-c51c0b58313a@raspberrypi.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Phil Elwell <phil@raspberrypi.org>
Cc: Martin Sperl <kernel@martin.sperl.org>, Heiner Kallweit <hkallweit1@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 23 May 2017 at 12:11, Phil Elwell <phil@raspberrypi.org> wrote:
> On 23/05/2017 08:58, Ulf Hansson wrote:
>> On 22 May 2017 at 11:09, Phil Elwell <phil@raspberrypi.org> wrote:
>>> since:
>>>         commit 0589342c27944e50ebd7a54f5215002b6598b748
>>>         Author: Rob Herring <rob.herring@calxeda.com>
>>>         Date:   Tue Oct 29 23:36:46 2013 -0500
>>>
>>>              of: set dma_mask to point to coherent_dma_mask
>>>
>>>              Platform devices created by DT code don't initialize dma_mask pointer to
>>>              anything. Set it to coherent_dma_mask by default if the architecture
>>>              code has not set it.
>>>
>>> the mmc-spi driver no longer detects the sd-cards any longer.
>>>
>>> This patch disables the offending section in mmc_spi
>>> so that the driver works again and detects the sd card normally.
>>>
>>> There is no real negative impact as the spi-framework
>>> does no longer rely on driver-provided DMA mappings but
>>> maps the transfers transparently.
>>>
>>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>>> Submitted-by: Phil Elwell <phil@raspberrypi.org>
>>> ---
>>>  drivers/mmc/host/mmc_spi.c | 11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
>>> index ae19d83bb9de0..16946e2513afa 100644
>>> --- a/drivers/mmc/host/mmc_spi.c
>>> +++ b/drivers/mmc/host/mmc_spi.c
>>> @@ -1387,6 +1387,16 @@ static int mmc_spi_probe(struct spi_device *spi)
>>>         if (!host->data)
>>>                 goto fail_nobuf1;
>>>
>>> +       /* for some reason mmc_spi does not work with this enabled
>>> +        * it is not needed anyway, as the SPI framework does DMA
>>> +        * transfers now automatically
>>> +        * the patch that introduced this was:
>>> +        * commit 0589342c27944e50ebd7a54f5215002b6598b748
>>> +        * Author: Rob Herring <rob.herring@calxeda.com>
>>> +        * Date:   Tue Oct 29 23:36:46 2013 -0500
>>> +        *      of: set dma_mask to point to coherent_dma_mask
>>> +        */
>>> +#if 0
>>>         if (spi->master->dev.parent->dma_mask) {
>>>                 struct device   *dev = spi->master->dev.parent;
>>>
>>> @@ -1402,6 +1412,7 @@ static int mmc_spi_probe(struct spi_device *spi)
>>>                                 host->data_dma, sizeof(*host->data),
>>>                                 DMA_BIDIRECTIONAL);
>>>         }
>>> +#endif
>>>
>>>         /* setup message for status/busy readback */
>>>         spi_message_init(&host->readback);
>>
>> Phil, I am not sure how to go with this.
>>
>> Your change drops the dma implementation in the mmc_spi driver as
>> host->dma_dev now never gets assigned. I do think that makes sense as
>> the dma support should be implemented in the spi master driver and not
>> in the spi client driver, which currently is the case for mmc_spi.
>>
>> Then perhaps a more proper change would be to remove the dma
>> implementation in mmc_spi altogether?
>
> I don't have enough in-depth SPI knowledge to make that decision - I'm happy to go
> with what the SPI experts recommend.

Okay. Let's see.

>
>> And one more thing, next time also cc the spi-list and Mark Brown, to
>> try to some broader input.
>
> Thanks for the tip, Ulf - I just went with what scripts/get_maintainer.pl suggested.
> Perhaps that list needs to be updated?

No, this is more a special case I would say.

Kind regards
Uffe
