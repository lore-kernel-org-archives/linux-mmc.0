From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v11 2/9] mmc: cavium: Add core MMC driver for Cavium SOCs
Date: Wed, 8 Mar 2017 10:45:19 +0100
Message-ID: <CAPDyKFrc5T1A=bcYtDELmpxNuwbDCAKxjZP3=cx6N9s5RZ-JuA@mail.gmail.com>
References: <20170206133953.8390-1-jglauber@cavium.com> <20170206133953.8390-3-jglauber@cavium.com>
 <CAPDyKFpZs-WZ32NQTc3zY6RdWJecZkUvbEbszAJfv4H2Rw2JCQ@mail.gmail.com> <20170307104922.GA19134@hardcore>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170307104922.GA19134@hardcore>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, David Daney <david.daney@cavium.com>
List-Id: linux-mmc@vger.kernel.org

[...]

>> > Voltage is limited to 3.3v and shared for all slots.
>>
>> What voltage? The I/O voltage or the voltage for the card?
>>
>> VMMC or VMMCQ?
>
> From my understanding both, VMMC and VMMCQ are fixed at 3.3v.

Okay, then make sure to explicitly state that here.

[...]

>> > +       if (bad_status(&rsp_sts))
>> > +               req->cmd->error = -EILSEQ;
>>
>> I don't think you should treat all errors as -EILSEQ. Please assign a
>> proper error code, depending on the error.
>
> Agreed, -ETIMEDOUT seems more appropriate for the timeouts. I'll go for
> -EIO for the dbuf_err (buffer space missing). What should I use for the
> CRC errors, -EILSEQ?

Yes, correct.

[...]

>> What does this really mean? Is this about HW support for better
>> dealing with data requests?
>
> Did David's reponse answer your questions?

Yes.

[...]

>> > +       /*
>> > +        * Legacy platform doesn't support regulator but enables power gpio
>> > +        * directly during platform probe.
>> > +        */
>> > +       if (host->global_pwr_gpiod)
>> > +               /* Get a sane OCR mask for other parts of the MMC subsytem. */
>> > +               return mmc_of_parse_voltage(dev->of_node, &mmc->ocr_avail);
>>
>> Does really the legacy platforms use the mmc voltage range DT bindings!?
>
> The legacy DT's use (in the mmc slot nodes):
>
> voltage-ranges = <3300 3300>;
>
>> I would rather see that you assign a default value to mmc->ocr_avail,
>> than using this binding.
>
> The volatage seems to be identical for all legacy bindings I can find,
> so is it better to not parse it and use the 3.3 as default?

Yes, I think so.

[...]

>> > +union mio_emm_cmd {
>> > +       u64 val;
>> > +       struct mio_emm_cmd_s {
>> > +#ifdef __BIG_ENDIAN_BITFIELD
>>
>> Huh. Sorry, but this is a big nack from me.
>>
>> This isn't the common method for how we deal with endian issues in the
>> kernel. Please remove all use of the union types here and below. The
>> follow common patterns for how we deal with endian issues.
>
> May I ask why you dislike the bitfields? Or maybe it is easier when I
> explain why I decided to keep them:

My main concern is that is different compared to how we deal with
endian issues in the kernel.

I just don't like homebrewed hacks, but prefers sticking to defacto
standard methods.

>
> - One drawback of bitfields is poor performance on some architectures.
>   That is not the case here, both MIPS64 and ARM64 have instructions
>   capable of using bitfields without performance impact.
>
> - The used bitfield are all aligned to word size, usually the pattern in
>   the driver is to readq / writeq the whole word (therefore the union
>   val) and then set or read certain fields. That should avoid IMHO the
>   unspecified behaviour the C standard mentions.
>
> - I prefer BIT_ULL and friends for single bits, but using macros for
>   more then one bit is (again IMHO) much less readable then using
>   bitfiels here. And all the endianess definitions are _only_ in the
>   header file.
>
> Also, if I need to convert all of these I'll probably add some new bugs.
> What we have currently works fine on both MIPS and ARM64.

I understand that is will have an impact, however there are plenty of
good references in the kernel for how to do this.

[...]

Kind regards
Uffe
