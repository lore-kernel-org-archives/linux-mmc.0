From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [RFC 2/2] mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8
 and Meson8b SoCs
Date: Tue, 18 Jul 2017 13:17:21 +0200
Message-ID: <CAFBinCBmqkL7dRdRrrtyHJ3KFSaV9DEdQicev0x9t2eUAnhAzA@mail.gmail.com>
References: <20170506171857.16492-1-martin.blumenstingl@googlemail.com>
 <20170506171857.16492-3-martin.blumenstingl@googlemail.com>
 <CAPDyKFrrSLCjbXO9R4VqPpabiFsbE6_RqR=U7otVF4Ncv0jHjQ@mail.gmail.com>
 <CAFBinCD3modyyOpi3OY5XLhjX0UCuV+WPY2Z=mdvwdMCyeGoqg@mail.gmail.com>
 <CAPDyKFptXRPk7mVUiRHf=hECDbeyhTxuf3K1M6NkZcVEF0Enww@mail.gmail.com>
 <CAFBinCD=uH=oQmWAcsMpxtbJCnJZernZx3XoNaPixUUQ7pk76w@mail.gmail.com>
 <CAPDyKFrbxMpgDrZXKmrN4fyJWJ_ZML3jPxBs+YDEz=L1kA-BaA@mail.gmail.com>
 <CAFBinCA-goSsyq7bo=ozPRnOqc8br4KDJJ_Lao5h==Xneh02nw@mail.gmail.com> <CAPDyKFoKaT_3MVF7SrS8bVm7iG=y6K+-R1+YNj=9bTS6qNrcug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f174.google.com ([209.85.217.174]:32939 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751380AbdGRLRn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jul 2017 07:17:43 -0400
In-Reply-To: <CAPDyKFoKaT_3MVF7SrS8bVm7iG=y6K+-R1+YNj=9bTS6qNrcug@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, Carlo Caione <carlo@endlessm.com>

Hi Ulf,

On Wed, Jul 12, 2017 at 3:42 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 11 July 2017 at 23:23, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>> Hi Ulf,
>>
>> sorry for the delay, I've been pretty busy.
>> however, I'll have more time to work in this driver this and next week
>>
>> On Mon, Jun 19, 2017 at 1:50 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>>
>>>>> [...]
>>>>>
>>>>>>>> +       if (!(cmd->flags & MMC_RSP_CRC))
>>>>>>>> +               send |= MESON_MX_SDIO_SEND_RESP_WITHOUT_CRC7;
>>>>>>>> +
>>>>>>>> +       if (cmd->flags & MMC_RSP_BUSY)
>>>>>>>> +               send |= MESON_MX_SDIO_SEND_CHECK_DAT0_BUSY;
>>>>>>>
>>>>>>> In case the controller has HW support of busy detection, please
>>>>>>> consider to enable MMC_CAP_WAIT_WHILE_BUSY for this driver. Then also
>>>>>>> assign host->max_busy_timeout a good value.
>>>>>> the IRQS register has bit 4 (CMD_BUSY) - but apart from that there is
>>>>>> no other documentation (about timeout values, etc.). the vendor driver
>>>>>> also neither uses MMC_CAP_WAIT_WHILE_BUSY nor host->max_busy_timeout
>>>>>> should I leave this as it is?
>>>>>
>>>>> Please don't just leave it as is. This is an important thing to get right.
>>>>>
>>>>> You should be able to explore this area and see how the controller
>>>>> behaves without too much of documentation. Regarding timeouts, it may
>>>>> very well be that the controller don't have a timeout, which is why
>>>>> you need a software timeout. That's not so uncommon actually.
>>>> during my experiments I've never seen an interrupt when a command
>>>> timed out (nor could I find information about a timeout register in
>>>> the documentation). do you have any pointers (like a previous mail
>>>> where you've explained) how I can "explore the controller's timeout
>>>> behavior"?
>>>
>>> Sorry, I don't have an pointers.
>>>
>>> Anyway. If you do a big erase operation on an SD card, the card should
>>> signal busy on DAT0 for a rather long time.
>> erase operation = mount sd card; rm big_file.bin; sync ?
>> or is there some other way?
>
> There is tool called fstrim, maybe you can you that as well.
>
> Don't forget that the mount options of the fs also matters of what
> will happen for the so called discard operations (translates to erase
> in SD).
I conducted a series of tests:

(the system boots with / mounted read-only):
mount -o remount,rw,discard
dd if=/dev/zero of=test.bin bs=1M count=1k

the actual test:
rm test.bin; sync

here are the results:

without MMC_CAP_WAIT_WHILE_BUSY, with MESON_MX_SDIO_SEND_CHECK_DAT0_BUSY:
[ 98.891623] meson_mx_mmc_start_cmd: starting CMD38 with timeout = 33130
[ 99.341293] meson_mx_mmc_irq: CMD38 IRQS = 0x00000220 (timeout = 33125)

without MMC_CAP_WAIT_WHILE_BUSY, without MESON_MX_SDIO_SEND_CHECK_DAT0_BUSY:
[ 197.591441] meson_mx_mmc_start_cmd: starting CMD38 with timeout = 4000
[ 197.591446] meson_mx_mmc_irq: CMD38 IRQS = 0x00000220 (timeout = 4000)
[ 202.881495] meson_mx_mmc_start_cmd: starting CMD38 with timeout = 30250
[ 202.881501] meson_mx_mmc_irq: CMD38 IRQS = 0x00000220 (timeout = 30250)

(I think the first one is is some other delete command, the actual rm
is probably the second one)

with MMC_CAP_WAIT_WHILE_BUSY (mmc->max_busy_timeout = ~0;), with
MESON_MX_SDIO_SEND_CHECK_DAT0_BUSY:
[ 65.701441] meson_mx_mmc_start_cmd: starting CMD38 with timeout = 33125
[ 65.984235] meson_mx_mmc_irq: CMD38 IRQS = 0x00000220 (timeout = 33125)

so in all conditions CMD38 completes in less than 1 second
the card I'm using is a cheap "Intenso SDHC class 10" with 16GiB: [0]

an additional "fstrim /" didn't result in any CMD38 (because, just
like you said: the card is mounted with the discard flag)

>>
>>> You could probably explore how long it takes for the card to respond
>>> under those circumstances, and try both with and without
>>> MESON_MX_SDIO_SEND_CHECK_DAT0_BUSY.
>> so I simply read the card status through sysfs? or would I need to get
>> some of this information from the controller?
>> I found that the IRQC register contains a few interesting bits:
>>     u32 sdio_force_data:6; /*[13:8]
>>         * Write operation: Data forced by software
>>         * Read operation: {CLK,CMD,DAT[3:0]}*/
>> I dumped these while transferring some data, the values seem to be
>> changing constantly (0x3f, 0x1f, 0x20, ...)
>> if I interpret those bits correctly then they are the status of the
>> corresponding pin
>
> Okay! So if the controller doesn't fully support HW busy detection,
> you should at least be able to implement the ->card_busy() host ops,
> which is used to poll the DAT0 line for busy detection.
only the DAT0 or DAT3:0?
the latter is what Amlogic does with their 8-bit bus capable drivers,
see [1] and [2]
(meson-gx-mmc.c is the upstream variant of [2] - where we don't
implement .card_busy or MMC_CAP_WAIT_WHILE_BUSY though)

>>
>>> Of course you also need to try with and without
>>> MMC_CAP_WAIT_WHILE_BUSY, as the core may sometimes convert R1B to R1
>>> responses depending on that cap.
>> so MESON_MX_SDIO_SEND_CHECK_DAT0_BUSY + MMC_CAP_WAIT_WHILE_BUSY should
>> go together?
>> and MESON_MX_SDIO_SEND_CHECK_DAT0_BUSY should not be set when
>> MMC_CAP_WAIT_WHILE_BUSY isn't?
>
> Yeah, something like that.
>
> So if you controller fully supports HW busy detection, the driver
> should set MMC_CAP_WAIT_WHILE_BUSY and then act accordingly when R1B
> responses are expected.
could you please have a look at my test results above and let me know
whether I should do more tests or which implementation you'd prefer
(from what I understood so far: if our hardware doesn't support
MMC_CAP_WAIT_WHILE_BUSY then I should implement .card_busy - but what
about MESON_MX_SDIO_SEND_CHECK_DAT0_BUSY then)?


Regards,
Martin


[0] http://intenso.de/multimedia/produktblatt/1343573205_en.pdf
[1] https://github.com/endlessm/linux-meson/blob/876ccc6ef48f406d8307dd741609c089e6e7e242/drivers/amlogic/mmc/aml_sdhc_m8.c#L2187
[2] https://github.com/endlessm/linux-s905x/blob/74ef17c59dab367c6040040940b77382a6098a58/drivers/amlogic/mmc/aml_sd_emmc.c#L3024
