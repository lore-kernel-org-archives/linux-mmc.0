From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3] mmc: mmci: Fixup and cleanup code for DMA handling
Date: Wed, 16 Jan 2013 11:23:57 +0100
Message-ID: <CAPDyKFrV8h+2ebfT6AK-ACfr716CE-f7+HGuh_+rOjbVnGOdfw@mail.gmail.com>
References: <1357570707-28207-1-git-send-email-ulf.hansson@stericsson.com>
	<20130113192428.GU23505@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:39618 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758824Ab3APKX7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Jan 2013 05:23:59 -0500
Received: by mail-lb0-f180.google.com with SMTP id gj3so892404lbb.25
        for <linux-mmc@vger.kernel.org>; Wed, 16 Jan 2013 02:23:58 -0800 (PST)
In-Reply-To: <20130113192428.GU23505@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Per Forlin <per.forlin@stericsson.com>

On 13 January 2013 20:24, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jan 07, 2013 at 03:58:27PM +0100, Ulf Hansson wrote:
>> @@ -374,19 +415,12 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
>>        * contiguous buffers.  On TX, we'll get a FIFO underrun error.
>>        */
>>       if (status & MCI_RXDATAAVLBLMASK) {
>> -             dmaengine_terminate_all(chan);
>> -             if (!data->error)
>> -                     data->error = -EIO;
>> -     }
>> -
>> -     if (data->flags & MMC_DATA_WRITE) {
>> -             dir = DMA_TO_DEVICE;
>> -     } else {
>> -             dir = DMA_FROM_DEVICE;
>> +             data->error = -EIO;
>> +             mmci_dma_data_error(host);
>
> Please explain the change of behaviour here.  Before your change, we _only_
> set data->error if the error is not set.  Here, we overwrite the error code
> no matter what.  What is the reasoning for that change?
>
> The reason the code is like it _was_ is so that any bytes remaining in the
> FIFO are _only_ reported as an error if there wasn't a preceding error.
> That is the behaviour I desired when I wrote this code.

Since we need to do dmaengine_terminate_all(chan), that will mean
another request could potentially already be prepared and thus it
could also be terminated.

Then by always reporting an error the async request handling in the
mmc protocol layer, can do proper error handling and clean up the
previously prepared request.

Kind regards
Ulf Hansson
