From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Support non-power-of-two block sizes for
 ux500v2 variant
Date: Thu, 29 Nov 2012 12:38:27 +0100
Message-ID: <CAPDyKFoq2f2tZqoKAjMjhA3yJFinXM25rJPCyiGaqHw=fEUoMg@mail.gmail.com>
References: <1350050522-8852-1-git-send-email-ulf.hansson@stericsson.com>
	<20121121153811.GN3290@n2100.arm.linux.org.uk>
	<CAFEEs1kzJUgsvnzgWwU4i7o1jkE=8iTq5+NJ_t1jdiHEm7b-RQ@mail.gmail.com>
	<20121121165048.GO3290@n2100.arm.linux.org.uk>
	<CAFEEs1nb+UD+8_jsKvGKhyFqGDogN5wsmV30PnELqahTMDyRVA@mail.gmail.com>
	<20121122173708.GJ5764@n2100.arm.linux.org.uk>
	<50B34270.7070403@stericsson.com>
	<20121126102712.GC19440@n2100.arm.linux.org.uk>
	<50B349D3.2050806@stericsson.com>
	<CAFEEs1nZboGyAfpYQ2hUvp366FiS0=8u5zL6Vr1RfXac_Ls_dw@mail.gmail.com>
	<20121128171221.GF19440@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:61863 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab2K2Li1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Nov 2012 06:38:27 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so11850515iea.19
        for <linux-mmc@vger.kernel.org>; Thu, 29 Nov 2012 03:38:27 -0800 (PST)
In-Reply-To: <20121128171221.GF19440@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Per Forlin <per.lkml@gmail.com>, Ulf HANSSON <ulf.hansson@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>

On 28 November 2012 18:12, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Nov 28, 2012 at 05:55:13PM +0100, Per Forlin wrote:
>> I have tried to work out an if-statement to check this properly. Here
>> is my conclusion,
>> This only works if sg len is 1 (in the SDIO case)
>>
>> if (WRITE)
>>   align = sg->offset & 3
>> else if (READ)
>>   align = 0
>>
>> if (sg->offset & 3 && (PAGE_SIZE - (sg->offset + align) < host->size))
>>    error; /* cannot be handled by mmci driver */
>
> This looks wrong.  For starters, why in the write case do you _add_ the
> byte offset in the word to sg->offset ?  So, if we're offset by one byte,
> it becomes two bytes.  Makes no sense.
>
> Secondly, (PAGE_SIZE - whatever) < host->size will be mostly always true.
> What that means is the check is effectively just "sg->offset & 3".
>
> Ah, maybe that's what you're trying to do - obfuscate the code in the hope
> that I won't analyse it so you can get your check past me and then remove
> all the obfuscation later... but maybe I'm just paranoid. :)
>
>> Is this if-statement align with your view of the alignment issue ?
>
> I've no idea why you're making it soo complicated.
>
> Let's review.  It copes fine with aligned buffers.  It copes fine with
> misaligned buffers that don't cross a page boundary.  It also copes
> fine with transfers that end with a non-word sized number of bytes
> (which we don't need a check for).
>
> So:
>
>         /* We can't cope with a misaligned transfer which crosses a page */
>         if (sg->offset & 3 && (sg->offset + sg->len > PAGE_SIZE ||
>                                data->sg_len > 1))
>                 bad;

This is ok for read but not for write. If your data also resides in
any of the last 3 bytes of the PAGE, you might get page faults since
at the final writesl you will access data outside the PAGE. That is
what pseudo code was trying to accomplish as well.

You might want to solve this similarly as we did for pio_read with a
local cache buffer in pio_write. That should not be that hard to fix.
Do you think this is what we want?

>
> See what I've done there?  I've taken the English and converted it directly
> to code.  And the comment also matches the code.
>
> And this way we continue to allow buffers that the string-IO operations
> can cope with just fine, but avoid the issue of a word crossing a page
> boundary.

Some overall ideas we might want to consider, maybe as a the second step.

>From mmci perspective it is good that we can cope with any constraints
at all from alignment perspective. Although, that will require a quite
extensive hacks in both pio_read and pio_write. By looking into how
other host drives has solved this, for example "dw_mci_push*"
functions gives you an idea. In the end this will mean complicated
code which will be affecting "hot path" and maybe performance. Do we
think this is ok? Is it worth a try?

Per and myself was kind of going in the opposite direction, thus keep
code simple and make sure it is optimized. On the other hand it means
putting constraints on buffer alignment. Right now there is no SDIO
API to tell SDIO clients about alignments constraints. Additionally
drivers is normally interested in using buffers that can be handled in
an optimized manner.

Kind regards
Ulf Hansson

> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
