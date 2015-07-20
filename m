From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCHv2] mmc:Add pointer cast to uintptr_t for slave_id_rx and
 tx in the function, sh_mmcif_request_dma_one
Date: Mon, 20 Jul 2015 16:21:46 +0200
Message-ID: <CAPDyKFqgo9-kFe+HPqG57m_RJytdT-HsLpF2ZDppWyHmOi8RcA@mail.gmail.com>
References: <1431366550-22045-1-git-send-email-xerofoify@gmail.com>
	<5589FD65.7040807@gmail.com>
	<1435107273.2504.43.camel@perches.com>
	<7719575.AWrtW5tPaL@wuerfel>
	<55953D85.3000507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55953D85.3000507@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nick <xerofoify@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 2 July 2015 at 15:32, nick <xerofoify@gmail.com> wrote:
>
>
> On 2015-06-24 03:16 AM, Arnd Bergmann wrote:
>> On Tuesday 23 June 2015 17:54:33 Joe Perches wrote:
>>> On Tue, 2015-06-23 at 20:44 -0400, nick wrote:
>>>> On 2015-06-23 08:40 PM, Joe Perches wrote:
>>>>> On Wed, 2015-06-24 at 00:24 +0000, Kuninori Morimoto wrote:
>>>>>>>>
>>>>>>>> It's far more common (~10:1) in the kernel to cast using
>>>>>>>>  (<type> *)(unsigned long)<foo>
>>>>>>>> than
>>>>>>>>  (<type> *)(uintptr_t)<foo>
>>>>>>>>
>>>>>>> Joe,
>>>>>>> I agree it's more common in the kernel but one of the maintainers when I sent
>>>>>>> this patch a month ago requested I use uintpr_t instead of unsigned long for
>>>>>>> the casting. Otherwise I would have done the cast to fix the build warning
>>>>>>> with unsigned long instead.
>>>>>>
>>>>>> This mail
>>>>>> http://thread.gmane.org/gmane.linux.kernel.mmc/32304
>>>>>
>>>>> uintptr_t was introduced to avoid ptrdiff_t misuse in
>>>>> commit 142956af5250 ("fix abuses of ptrdiff_t") by Al Viro.
>>>>>
>>>>> unsigned long is preponderant, long is used about 1/4 as
>>>>> often as unsigned long, uintptr_t is relatively uncommon.
>>>>>
>>>>> If someone wants to go and convert the 800 or so casts to
>>>>> long or unsigned long to uintptr_t so that's the style most
>>>>> frequently used, that'd be different.  I'm not going to
>>>>> submit any patches for that.
>>>>>
>>>>>
>>>> I am not disagreeing it was just easier to listen to the maintainer rather
>>>> then get in a technical argument over which type is better for the cast.
>>>
>>> Laurent has authored a couple patches to that file and he gave
>>> you his opinion about using uintptr_t.
>>>
>>> I'm giving an opinion too, just with a little statistics.
>>>
>>> I think it's better to use the style that the kernel generally
>>> uses.
>>>
>>> I'll stop replying now.
>>
>> Instead of debating the type of cast that is used here, it would be nicer
>> to do a patch that avoids the cast in the driver entirely, by changing
>> the pdata to contain a void* type from the start, and to pass the
>> shdma_chan_filter function pointer along with it from platform code.
>>
>> That would make the sh_mmcif driver independent of the underlying dma
>> driver.
>>
>>       Arnd
>>
> Arnd,
> I would have to agree with you but would like the other people in this discussion to agree
> before I rewrite this function and pdata structure to do this. Otherwise this patch will
> be the current solution for this.
> Cheers,
> Nick
> P.S. Sorry for the late reply been very busy.

Let's follow Arnd's suggestion!

Kind regards
Uffe
