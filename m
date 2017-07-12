From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 2/2] mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8
 and Meson8b SoCs
Date: Wed, 12 Jul 2017 15:42:45 +0200
Message-ID: <CAPDyKFoKaT_3MVF7SrS8bVm7iG=y6K+-R1+YNj=9bTS6qNrcug@mail.gmail.com>
References: <20170506171857.16492-1-martin.blumenstingl@googlemail.com>
 <20170506171857.16492-3-martin.blumenstingl@googlemail.com>
 <CAPDyKFrrSLCjbXO9R4VqPpabiFsbE6_RqR=U7otVF4Ncv0jHjQ@mail.gmail.com>
 <CAFBinCD3modyyOpi3OY5XLhjX0UCuV+WPY2Z=mdvwdMCyeGoqg@mail.gmail.com>
 <CAPDyKFptXRPk7mVUiRHf=hECDbeyhTxuf3K1M6NkZcVEF0Enww@mail.gmail.com>
 <CAFBinCD=uH=oQmWAcsMpxtbJCnJZernZx3XoNaPixUUQ7pk76w@mail.gmail.com>
 <CAPDyKFrbxMpgDrZXKmrN4fyJWJ_ZML3jPxBs+YDEz=L1kA-BaA@mail.gmail.com> <CAFBinCA-goSsyq7bo=ozPRnOqc8br4KDJJ_Lao5h==Xneh02nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFBinCA-goSsyq7bo=ozPRnOqc8br4KDJJ_Lao5h==Xneh02nw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Carlo Caione <carlo-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 11 July 2017 at 23:23, Martin Blumenstingl
<martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
> Hi Ulf,
>
> sorry for the delay, I've been pretty busy.
> however, I'll have more time to work in this driver this and next week
>
> On Mon, Jun 19, 2017 at 1:50 PM, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>>>
>>>> [...]
>>>>
>>>>>>> +       if (!(cmd->flags & MMC_RSP_CRC))
>>>>>>> +               send |= MESON_MX_SDIO_SEND_RESP_WITHOUT_CRC7;
>>>>>>> +
>>>>>>> +       if (cmd->flags & MMC_RSP_BUSY)
>>>>>>> +               send |= MESON_MX_SDIO_SEND_CHECK_DAT0_BUSY;
>>>>>>
>>>>>> In case the controller has HW support of busy detection, please
>>>>>> consider to enable MMC_CAP_WAIT_WHILE_BUSY for this driver. Then also
>>>>>> assign host->max_busy_timeout a good value.
>>>>> the IRQS register has bit 4 (CMD_BUSY) - but apart from that there is
>>>>> no other documentation (about timeout values, etc.). the vendor driver
>>>>> also neither uses MMC_CAP_WAIT_WHILE_BUSY nor host->max_busy_timeout
>>>>> should I leave this as it is?
>>>>
>>>> Please don't just leave it as is. This is an important thing to get right.
>>>>
>>>> You should be able to explore this area and see how the controller
>>>> behaves without too much of documentation. Regarding timeouts, it may
>>>> very well be that the controller don't have a timeout, which is why
>>>> you need a software timeout. That's not so uncommon actually.
>>> during my experiments I've never seen an interrupt when a command
>>> timed out (nor could I find information about a timeout register in
>>> the documentation). do you have any pointers (like a previous mail
>>> where you've explained) how I can "explore the controller's timeout
>>> behavior"?
>>
>> Sorry, I don't have an pointers.
>>
>> Anyway. If you do a big erase operation on an SD card, the card should
>> signal busy on DAT0 for a rather long time.
> erase operation = mount sd card; rm big_file.bin; sync ?
> or is there some other way?

There is tool called fstrim, maybe you can you that as well.

Don't forget that the mount options of the fs also matters of what
will happen for the so called discard operations (translates to erase
in SD).

>
>> You could probably explore how long it takes for the card to respond
>> under those circumstances, and try both with and without
>> MESON_MX_SDIO_SEND_CHECK_DAT0_BUSY.
> so I simply read the card status through sysfs? or would I need to get
> some of this information from the controller?
> I found that the IRQC register contains a few interesting bits:
>     u32 sdio_force_data:6; /*[13:8]
>         * Write operation: Data forced by software
>         * Read operation: {CLK,CMD,DAT[3:0]}*/
> I dumped these while transferring some data, the values seem to be
> changing constantly (0x3f, 0x1f, 0x20, ...)
> if I interpret those bits correctly then they are the status of the
> corresponding pin

Okay! So if the controller doesn't fully support HW busy detection,
you should at least be able to implement the ->card_busy() host ops,
which is used to poll the DAT0 line for busy detection.

>
>> Of course you also need to try with and without
>> MMC_CAP_WAIT_WHILE_BUSY, as the core may sometimes convert R1B to R1
>> responses depending on that cap.
> so MESON_MX_SDIO_SEND_CHECK_DAT0_BUSY + MMC_CAP_WAIT_WHILE_BUSY should
> go together?
> and MESON_MX_SDIO_SEND_CHECK_DAT0_BUSY should not be set when
> MMC_CAP_WAIT_WHILE_BUSY isn't?

Yeah, something like that.

So if you controller fully supports HW busy detection, the driver
should set MMC_CAP_WAIT_WHILE_BUSY and then act accordingly when R1B
responses are expected.

[...]

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
