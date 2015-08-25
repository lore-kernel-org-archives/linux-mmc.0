From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] mmc: sunxi: Don't start commands while
 the card is busy
Date: Tue, 25 Aug 2015 15:58:45 +0200
Message-ID: <CAPDyKFpJGBA7GN=PJmWdpT+_OiPF_ET0i9wC7XYBCJA9EwLrgw@mail.gmail.com>
References: <1436541284-11800-1-git-send-email-hdegoede@redhat.com>
	<CAPDyKFoNe0bghfSXs48stHzZToTc7Hjd5gVPy-VbDF8bzdVVMQ@mail.gmail.com>
	<55BC8ADE.3070802@redhat.com>
	<CAPDyKFrYvL33DsaATg4fyAJg=G3SEuOP+xU=o_UwasmNZ+a07Q@mail.gmail.com>
	<55DC5B09.2020705@redhat.com>
Reply-To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDF57NG2XIHRBFXJ6GXAKGQEXJKW3TI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <55DC5B09.2020705-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Eugene K <sigintmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 25 August 2015 at 14:09, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Hi,
>
>
> On 25-08-15 14:05, Ulf Hansson wrote:
>>
>> On 1 August 2015 at 11:01, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>>
>>> Hi,
>>>
>>> On 21-07-15 14:15, Ulf Hansson wrote:
>>>>
>>>>
>>>> On 10 July 2015 at 17:14, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>>>>
>>>>>
>>>>> Some sdio wifi modules have not been working reliable with the
>>>>> sunxi-mmc
>>>>> host code. This turns out to be caused by it starting new commands
>>>>> while
>>>>> the card signals that it is still busy processing a previous command.
>>>>
>>>>
>>>>
>>>> Which are those commands?
>>>
>>>
>>>
>>> The code were things get stuck when not waiting for the busy signal uses
>>> the following sdio helper functions:
>>>
>>> sdio_readb/sdio_writeb
>>> sdio_f0_readb/sdio_f0_writeb
>>> sdio_readw/sdio_writew
>>> sdio_readl/sdio_writel
>>> sdio_readsb
>>> sdio_memcpy_fromio/sdio_memcpy_toio
>>>
>>> And directly issues the following command:
>>>
>>>          mmc_dat.flags = write ? MMC_DATA_WRITE : MMC_DATA_READ;
>>>          mmc_cmd.opcode = SD_IO_RW_EXTENDED;
>>>          mmc_cmd.arg = write ? 1<<31 : 0;        /* write flag  */
>>>          mmc_cmd.arg |= (fn & 0x7) << 28;        /* SDIO func num */
>>>          mmc_cmd.arg |= 1<<27;                   /* block mode */
>>>          /* for function 1 the addr will be incremented */
>>>          mmc_cmd.arg |= (fn == 1) ? 1<<26 : 0;
>>>          mmc_cmd.flags = MMC_RSP_SPI_R5 | MMC_RSP_R5 | MMC_CMD_ADTC;
>>>
>>> I do not know if the busy wait is necessary for all
>>> of these, but the hack in the android kernel code,
>>> which inserts calls to a wait_card_busy function directly
>>> into: drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c
>>>
>>> Does so for all of these.
>>>
>>>> Or more interesting, which response types do
>>>>
>>>> these commands expect?
>>>> I don't think this is a sunxi specific issue, I have seen similar
>>>> issues for other host controllers.
>>>
>>>
>>>
>>> Agreed, recent dw-mmc patches address the same issue, also involving
>>> broadcom sdio wifi chips.
>>>
>>>> I am thinking that perhaps this should be managed by the mmc core
>>>> instead of local hacks to sunxi. Potentially we could make the core to
>>>> invoke the already existing host_ops->card_busy() callback when
>>>> needed...
>>>
>>>
>>>
>>> I'm fine with solving this either way, implementing host_ops->card_busy()
>>> for sunxi is easy, and if the core os modified to call that function
>>> before issue sdio io ops (which seems to be the common thing here),
>>> then that indeed is better then having the sunxi code always do
>>> the busy check.
>>
>>
>> Okay, so let's make the core to call the ->card_busy() callback and
>> then it's up to each host driver to implement that callback.
>
>
> Ok, do you plan to do a patch for this, or do you expect to get
> one submitted to you ?

I prefer to get a patch submitted to me. My bandwidth has been limited
and still have a lot to catch up with...

Kind regards
Uffe
