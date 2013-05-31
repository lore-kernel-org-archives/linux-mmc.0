From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v2] dmaengine: shdma: fix a build failure on platforms
 with no DMA support
Date: Fri, 31 May 2013 10:00:29 -0500
Message-ID: <51A8BB0D.9060907@ti.com>
References: <Pine.LNX.4.64.1305310423360.1470@axis700.grange> <51A88707.4040601@ti.com> <alpine.DEB.2.00.1305311504460.6919@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1305311504460.6919@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 05/31/2013 08:08 AM, Guennadi Liakhovetski wrote:
> On Fri, 31 May 2013, Dan Murphy wrote:
>
>> On 05/30/2013 10:01 PM, Guennadi Liakhovetski wrote:
>>> On platforms with no support for the shdma dmaengine driver build is
>>> currently failing with
>>>
>>> drivers/built-in.o: In function `sh_mobile_sdhi_probe':
>>> drivers/mmc/host/sh_mobile_sdhi.c:170: undefined reference to`shdma_chan_filter'
>>>
>>> Fix the breakage by defining shdma_chan_filter to NULL in such
>>> configurations.
>>>
>>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
>>> ---
>>>
>>> v2: in "next" shdma_chan_filter() is defined in shdma-base.c, which is 
>>> built if CONFIG_SH_DMAE_BASE is defined. This version uses the correct 
>>> symbol.
>>>
>>> This is for "next." Compile-tested only. I'll test it on hardware next 
>>> week, but I don't think it shall break anything.
>>>
>>>  include/linux/sh_dma.h |    4 ++++
>>>  1 files changed, 4 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/include/linux/sh_dma.h b/include/linux/sh_dma.h
>>> index b64d6be..1fd8a20 100644
>>> --- a/include/linux/sh_dma.h
>>> +++ b/include/linux/sh_dma.h
>>> @@ -99,6 +99,10 @@ struct sh_dmae_pdata {
>>>  #define CHCR_TE	0x00000002
>>>  #define CHCR_IE	0x00000004
>>>  
>>> +#if IS_ENABLED(CONFIG_SH_DMAE_BASE)
>>>  bool shdma_chan_filter(struct dma_chan *chan, void *arg);
>>> +#else
>>> +#define shdma_chan_filter NULL
>> OK I did not see a reply to my previous comment
>> Would this not be better as a
>> #else
>> static inline bool shdma_chan_filter(struct dma_chan *chan, void *arg) { return false; }
>> #endif
>>
>> Otherwise runtime will call a NULL pointer
> Have you looked at the code?:
>
> 		if (fn && !fn(chan, fn_param)) {
>
> Have you considered, when this channel allocation at all has a chance to 
> get as far as to checking the filter? Have you thought about the meaning 
> of "inline" when uing a function to assign it to a pointer? Are you sure 
> "will" is the right word here?
My consideration was that since this is an exported symbol that a driver could call this API explicitly without checking for
the function pointer first, there is a potential of calling a NULL pointer.

Dan
> Thanks
> Guennadi
>
>>> +#endif
>>>  
>>>  #endif
>>
>> -- 
>> ------------------
>> Dan Murphy
>>
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/


-- 
------------------
Dan Murphy

