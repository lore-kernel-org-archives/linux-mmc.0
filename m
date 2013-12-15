From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Re: [PATCH 1/5] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
Date: Sun, 15 Dec 2013 19:41:28 +0100
Message-ID: <52ADF7D8.2010900@redhat.com>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com> <1387058295-20641-2-git-send-email-hdegoede@redhat.com> <20131215134415.GE3651@lukather> <52ADBAA3.7060507@redhat.com> <20131215162109.GI3651@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBYHPW6KQKGQETKZK5TQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20131215162109.GI3651@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, =?ISO-8859-1?Q?David_Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 12/15/2013 05:21 PM, Maxime Ripard wrote:
> On Sun, Dec 15, 2013 at 03:20:19PM +0100, Hans de Goede wrote:
<snip>

>>>> +static const struct of_device_id sunxi_mmc_of_match[] = {
>>>> +	{ .compatible = "allwinner,sun4i-mmc", },
>>>> +	{ .compatible = "allwinner,sun5i-mmc", },
>>>
>>> Please use sun5i-a13-mmc as your compatible.
>>
>> Can you explain a bit why? In essence currently we have
>> 2 versions of the mmc controller, those found on sun4i
>> and those found on sun5i and sun7i. I thought that the
>> norm was to use the oldest soc version in which a revision
>> of an ip-block first appears as the compatible string ?
>
> Indeed.
>
>> Note I've tested this with both a13 and a10s SOCs, if we
>> add a sun5i-a13-mmc we should also add a sun5i-a10s-mmc
>> and a sun5i-a20-mmc, or would that then be sun7i-a20-mmc?
>
> And the A13 has been the first SoC in the sun5i family, hence why we
> should use sun5i-a13 as the prefix here. If the A10s and A20 would not
> have been compatible with the A13 MMC controller, we would have used
> sun5i-a10s-mmc and sun7i-a20-mmc, respectively.

Ah I see, you meant s/allwinner,sun5i-mmc/allwinner,sun5i-a13-mmc/

I interpreted your remark as adding an extra allwinner,sun5i-a13-mmc
compatible string. Using allwinner,sun5i-a13-mmc instead of
allwinner,sun5i-mmc makes sense. David having us both editing the
driver at the same time seems counter-productive, can you take care
of this too?

>
>> To me just having sun5i-mmc for sun5i+ socs seems simpler.
>
> And if we ever find out that A10s or A13 differs in some way, we will
> end up introducing a compatible that will be sun5i-a10s-mmc, along
> with the sun5i-mmc we already have, which is not really the more
> consistent thing we would have done.
>
>> <snip>
>>
>>>> +	mmc->ops		= &sunxi_mmc_ops;
>>>> +	mmc->max_blk_count	= 8192;
>>>> +	mmc->max_blk_size	= 4096;
>>>> +	mmc->max_segs		= PAGE_SIZE / sizeof(struct sunxi_idma_des);
>>>> +	mmc->max_seg_size	= (1 << host->idma_des_size_bits);
>>>> +	mmc->max_req_size	= mmc->max_seg_size * mmc->max_segs;
>>>> +	/* 400kHz ~ 50MHz */
>>>> +	mmc->f_min		=   400000;
>>>> +	mmc->f_max		= 50000000;
>>>
>>> Hmmm, the tables earlier seem to suggest it can do much more than that.
>>
>> I know, but this is what the allwinner android kernels are using, actually
>> in case of sdc3 they are putting 200000000 in f_max (as that is often
>> used for sdio cards) but then later in set_ios they clamp the passed
>> in clock to 47000000 Mhz, so I seriously doubt that 200Mhz has actually
>> worked. Hence I've simply gone for a safe range for now. If someone has
>> cards capable of doing 200 MHz we could certainly run various tests and
>> try to improve this, but for now this seems a sane range to start with.
>
> That's probably something that you should mention in your comment then :)

Good point, David ?

<snip>

>>> Hmmm, I see no implementation for this function. Didn't you forget
>>> a file here? (and it should probably be a separate patch anyway).
>>
>> The implementation is part of Emilio's clk branch, but he forgot
>> to add a header for it, so I'm fixing that up here, I guess this
>> should go through Emlio's tree as a separate patch.
>
> As far as I know, this work has never been posted, let alone
> merged.

I don't know if it has been posted, but it has been in his tree for a
while now. Anyways I'll send him a standalone patch for the clk/sunxi.h
file.

 > Anyway, the dependencies you have is something that you should
 > mention in your cover letter, so that we know what to merge, in which
 > order, and when to merge it.

Right, my bad, sorry. I was so happy I was finally ready to send the patch
upstream (I finally had fixed everything on my todo list), I rushed the
cover letter a bit. I was planning on putting things like this in there,
as well as why we didn't try to extend the mmc-dw driver, but I forgot.

Thanks & Regards,

Hans
