From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] mmc: sunxi: Don't start commands while the card is
 busy
Date: Tue, 25 Aug 2015 14:09:45 +0200
Message-ID: <55DC5B09.2020705@redhat.com>
References: <1436541284-11800-1-git-send-email-hdegoede@redhat.com>
 <CAPDyKFoNe0bghfSXs48stHzZToTc7Hjd5gVPy-VbDF8bzdVVMQ@mail.gmail.com>
 <55BC8ADE.3070802@redhat.com>
 <CAPDyKFrYvL33DsaATg4fyAJg=G3SEuOP+xU=o_UwasmNZ+a07Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47898 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755058AbbHYMJs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 25 Aug 2015 08:09:48 -0400
In-Reply-To: <CAPDyKFrYvL33DsaATg4fyAJg=G3SEuOP+xU=o_UwasmNZ+a07Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, Mike Turquette <mturquette@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com, Eugene K <sigintmailru@gmail.com>

Hi,

On 25-08-15 14:05, Ulf Hansson wrote:
> On 1 August 2015 at 11:01, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 21-07-15 14:15, Ulf Hansson wrote:
>>>
>>> On 10 July 2015 at 17:14, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Some sdio wifi modules have not been working reliable with the sunxi-mmc
>>>> host code. This turns out to be caused by it starting new commands while
>>>> the card signals that it is still busy processing a previous command.
>>>
>>>
>>> Which are those commands?
>>
>>
>> The code were things get stuck when not waiting for the busy signal uses
>> the following sdio helper functions:
>>
>> sdio_readb/sdio_writeb
>> sdio_f0_readb/sdio_f0_writeb
>> sdio_readw/sdio_writew
>> sdio_readl/sdio_writel
>> sdio_readsb
>> sdio_memcpy_fromio/sdio_memcpy_toio
>>
>> And directly issues the following command:
>>
>>          mmc_dat.flags = write ? MMC_DATA_WRITE : MMC_DATA_READ;
>>          mmc_cmd.opcode = SD_IO_RW_EXTENDED;
>>          mmc_cmd.arg = write ? 1<<31 : 0;        /* write flag  */
>>          mmc_cmd.arg |= (fn & 0x7) << 28;        /* SDIO func num */
>>          mmc_cmd.arg |= 1<<27;                   /* block mode */
>>          /* for function 1 the addr will be incremented */
>>          mmc_cmd.arg |= (fn == 1) ? 1<<26 : 0;
>>          mmc_cmd.flags = MMC_RSP_SPI_R5 | MMC_RSP_R5 | MMC_CMD_ADTC;
>>
>> I do not know if the busy wait is necessary for all
>> of these, but the hack in the android kernel code,
>> which inserts calls to a wait_card_busy function directly
>> into: drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c
>>
>> Does so for all of these.
>>
>>> Or more interesting, which response types do
>>>
>>> these commands expect?
>>> I don't think this is a sunxi specific issue, I have seen similar
>>> issues for other host controllers.
>>
>>
>> Agreed, recent dw-mmc patches address the same issue, also involving
>> broadcom sdio wifi chips.
>>
>>> I am thinking that perhaps this should be managed by the mmc core
>>> instead of local hacks to sunxi. Potentially we could make the core to
>>> invoke the already existing host_ops->card_busy() callback when
>>> needed...
>>
>>
>> I'm fine with solving this either way, implementing host_ops->card_busy()
>> for sunxi is easy, and if the core os modified to call that function
>> before issue sdio io ops (which seems to be the common thing here),
>> then that indeed is better then having the sunxi code always do
>> the busy check.
>
> Okay, so let's make the core to call the ->card_busy() callback and
> then it's up to each host driver to implement that callback.

Ok, do you plan to do a patch for this, or do you expect to get
one submitted to you ?

Regards,

Hans


> As an optimization, we might consider (in a separate step) to add
> MMC_RSP_BUSY to the response type. I realize that would somewhat be a
> violation of the spec, but apparently the SDIO spec isn't really clear
> on this area.
>
>>
>>> Within this context, could I ask whether you controller supports IRQ
>>> based HW-busy detection? Or you need polling of the status register?
>>
>>
>> I'm afraid that we need to poll the status register. I've been unable
>> to find an irq flag corresponding to this.
>
> Okay, thanks for the info.
>
> [...]
>
> Kind regards
> Uffe
>
