From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Re: [PATCH 2/3] mmc: sunxi: Set the 'New Timing'
 register for 8 bits DDR transfers
Date: Tue, 2 Aug 2016 10:37:46 +0200
Message-ID: <439e8a4c-1219-bb01-1be9-f1e4d77f3fcf@redhat.com>
References: <cover.1469082481.git.moinejf@free.fr>
 <bc7b767cad6db159a44c4b98d5b1f3eb53c26bd3.1469082481.git.moinejf@free.fr>
 <20160721085615.GG5993@lukather>
 <20160721112655.941b1dad04f7a5b94d4172c1@free.fr>
 <20160729191730.GG6215@lukather>
 <9414aab0-ac2b-01c2-e16b-8f7394ea7b68@redhat.com>
 <20160801155246.b7b3c7f0f582394b4c25f6dc@free.fr>
Reply-To: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Return-path: <linux-sunxi+bncBDRZXY4CYYORBX5XQG6QKGQEFFSMNJQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160801155246.b7b3c7f0f582394b4c25f6dc-GANU6spQydw@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: moinejf-GANU6spQydw@public.gmane.org
Cc: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 01-08-16 15:52, Jean-Francois Moine wrote:
> On Sat, 30 Jul 2016 12:19:03 +0200
> Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>
>> Jean-Francois, can you submit a v2 of your patch and make the writing of
>> SDXC_REG_NTSR depend on a new sun8i-a83t-mmc compatible ?
>>
>> Also you should probably drop the bits about the clock stuff from the
>> commit message as that just seems to confuse people.
>
> Hi Hans,
>
> I submitted a new patch (sorry, I forgot the history), but it asks for
> some explanation.
>
> - in the old timings, the phase delays are set in the clock.
>   That's why there is a function clk_set_phase() which is called from
>   the MMC side.
>
> - in the new timings, the delays are in the MMC register SDXC_REG_NTSR
>   only.
>   In this case, the function clk_set_phase() is of no use
>   (also, by test, it seems that the phase delays set by hardware
>    reset do work, so, there is no need to set them), but,
>
> - there is a bit in the clock telling that the new timings are used,
>   i.e. that the phase delays of the clock must be ignored.
>
>   Not setting this bit prevents the device to work (at least in the
>   A83T, the H3 seems more helpful).

Thanks for the explanation, it would be good to put this in the commit
msg of v3 of the patch.

Regards,

Hans
