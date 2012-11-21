From: Per Forlin <per.lkml@gmail.com>
Subject: Re: [PATCH] mmc: mmci: Support non-power-of-two block sizes for
 ux500v2 variant
Date: Wed, 21 Nov 2012 17:13:55 +0100
Message-ID: <CAFEEs1kzJUgsvnzgWwU4i7o1jkE=8iTq5+NJ_t1jdiHEm7b-RQ@mail.gmail.com>
References: <1350050522-8852-1-git-send-email-ulf.hansson@stericsson.com>
	<20121121153811.GN3290@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:63987 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753Ab2KUQN5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Nov 2012 11:13:57 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so2841091lbb.19
        for <linux-mmc@vger.kernel.org>; Wed, 21 Nov 2012 08:13:55 -0800 (PST)
In-Reply-To: <20121121153811.GN3290@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Wed, Nov 21, 2012 at 4:38 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Oct 12, 2012 at 04:02:02PM +0200, Ulf Hansson wrote:
>>  /*
>> + * Validate mmc prerequisites
>> + */
>> +static int mmci_validate_data(struct mmci_host *host,
>> +                           struct mmc_data *data)
>> +{
>> +     if (!data)
>> +             return 0;
>> +
>> +     if (!host->variant->non_power_of_2_blksize &&
>> +         !is_power_of_2(data->blksz)) {
>> +             dev_err(mmc_dev(host->mmc),
>> +                     "unsupported block size (%d bytes)\n", data->blksz);
>> +             return -EINVAL;
>> +     }
>> +
>> +     if (data->sg->offset & 3) {
>> +             dev_err(mmc_dev(host->mmc),
>> +                     "unsupported alginment (0x%x)\n", data->sg->offset);
>> +             return -EINVAL;
>> +     }
>
> Why?  What's the reasoning behind this suddenly introduced restriction?
> readsl()/writesl() copes just fine with non-aligned pointers.  It may be
> that your DMA engine can not, but that's no business interfering with
> non-DMA transfers, and no reason to fail such transfers.
>
> If your DMA engine can't do that then its your DMA engine code which
> should refuse to prepare the transfer.
>
> Yes, that means problems with the way things are ordered - or it needs a
> proper API where DMA engine can export these kinds of properties.
The alignment constraint is related to PIO, sg_miter and that FIFO
access must be done with 4 bytes.

For a 8k buffer sg miter may return 3 buffer
1. 7 bytes
2. 4096
3. 4089

DMA can handle this because it will treat this a one buffer being 8 k.
PIO will do three transfer due to sg_miter (7, 4096, 4089).
One could change the driver to not use sg_miter and just access the 8k
buffer directly to avoid the issue.

BR
Per



> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
