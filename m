From: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH v2 08/11] mmc: pwrseq_simple: Add support for a delay
Date: Wed, 21 Jan 2015 14:54:06 +0100
Message-ID: <54BFAF7E.1030703@collabora.com>
References: <1421338359-27467-1-git-send-email-tomeu.vizoso@collabora.com>	<1421338359-27467-9-git-send-email-tomeu.vizoso@collabora.com>	<54B7F9FB.7030100@wwwdotorg.org> <CAPDyKFoO6evBoAbEE30XiZg51KsM-sD4viFMvqaDwGoHeVL-6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFoO6evBoAbEE30XiZg51KsM-sD4viFMvqaDwGoHeVL-6w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Dylan Reid <dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 01/21/2015 11:44 AM, Ulf Hansson wrote:
> On 15 January 2015 at 18:33, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
>> On 01/15/2015 09:12 AM, Tomeu Vizoso wrote:
>>>
>>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
>>
>>
>> Ah, having read the explanation in the next patch, I think ...
>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
>>> b/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
>>
>>
>>> +- delay : delay to wait after driving the reset gpio active [ms].
>>
>>
>> ... delay is the wrong name. reset-pulse-width or reset-pulse-length would
>> be better. delay sounds like a delay after resetting the device before it
>> can be accessed.
> 
> I agree with Stephen's proposal.

Cool.

> This patch needs to be rebased and retested on latest version the
> mmc-pwrseq patches.

Sure.

> Moreover, if you think the patchset which $subject
> patch is a part of is material for 3.20, I will need to share an
> immutable branch with the mmc-pwrseq patches for ARM SOC to pull in,
> tell me if you need that.

I don't think this will make 3.20 as I have other series with higher
priority and there's quite some work left to do on this one.

Regards,

Tomeu

> Kind regards
> Uffe
> 
