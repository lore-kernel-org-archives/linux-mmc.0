From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3] mmc: mmci: Fixup and cleanup code for DMA handling
Date: Wed, 16 Jan 2013 12:01:51 +0100
Message-ID: <CAPDyKFqGxy_KgRE0fKPU1KpdWxHz1j7A2RnfNYrq-zkRq5cXHg@mail.gmail.com>
References: <1357570707-28207-1-git-send-email-ulf.hansson@stericsson.com>
	<20130113192428.GU23505@n2100.arm.linux.org.uk>
	<CAPDyKFrV8h+2ebfT6AK-ACfr716CE-f7+HGuh_+rOjbVnGOdfw@mail.gmail.com>
	<20130116104947.GQ23505@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:36419 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756369Ab3APLBx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Jan 2013 06:01:53 -0500
Received: by mail-lb0-f169.google.com with SMTP id gk1so941147lbb.14
        for <linux-mmc@vger.kernel.org>; Wed, 16 Jan 2013 03:01:51 -0800 (PST)
In-Reply-To: <20130116104947.GQ23505@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Per Forlin <per.forlin@stericsson.com>

On 16 January 2013 11:49, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jan 16, 2013 at 11:23:57AM +0100, Ulf Hansson wrote:
>> On 13 January 2013 20:24, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Mon, Jan 07, 2013 at 03:58:27PM +0100, Ulf Hansson wrote:
>> >> @@ -374,19 +415,12 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
>> >>        * contiguous buffers.  On TX, we'll get a FIFO underrun error.
>> >>        */
>> >>       if (status & MCI_RXDATAAVLBLMASK) {
>> >> -             dmaengine_terminate_all(chan);
>> >> -             if (!data->error)
>> >> -                     data->error = -EIO;
>> >> -     }
>> >> -
>> >> -     if (data->flags & MMC_DATA_WRITE) {
>> >> -             dir = DMA_TO_DEVICE;
>> >> -     } else {
>> >> -             dir = DMA_FROM_DEVICE;
>> >> +             data->error = -EIO;
>> >> +             mmci_dma_data_error(host);
>> >
>> > Please explain the change of behaviour here.  Before your change, we _only_
>> > set data->error if the error is not set.  Here, we overwrite the error code
>> > no matter what.  What is the reasoning for that change?
>> >
>> > The reason the code is like it _was_ is so that any bytes remaining in the
>> > FIFO are _only_ reported as an error if there wasn't a preceding error.
>> > That is the behaviour I desired when I wrote this code.
>>
>> Since we need to do dmaengine_terminate_all(chan), that will mean
>> another request could potentially already be prepared and thus it
>> could also be terminated.
>>
>> Then by always reporting an error the async request handling in the
>> mmc protocol layer, can do proper error handling and clean up the
>> previously prepared request.
>
> Sigh, I don't think you understand what this code is doing at all then.
>
> We will _always_ report _an_ error as the code originally stands if we
> encounter MCI_RXDATAAVLBLMASK being set.  The error that we report will
> be the _correct_ one - either the one which preceeds this condition
> occuring _or_ an IO error because not all data was read from the FIFO
> by the DMA engine.
>
> If the DMA engine fails to read all the data from the FIFO, _and_ there
> was a preceeding error, we should _not_ overwrite the preceeding error.
> This is exactly what the original code does.
>
> Your version _always_ overwrites the previous error.  This could result
> in FIFO/CRC errors always being reported as an IO error rather than
> their proper error codes, and therefore _breaking_ error handling.

Sorry, Russell I was talking junk. :-) Please ignore my last respond.

It shall be safe to keep the original behavior. The important thing is
that an error code get set, so the async request handling can clean up
a prepared request, which was already handled.
I will fixup the patch and send a v4, thanks a lot spotting this.

Kind regards
Ulf Hansson
