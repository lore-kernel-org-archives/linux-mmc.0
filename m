From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH] mmc: core: Remove timeout when enabling cache
Date: Tue, 20 Nov 2018 16:09:32 +0530
Message-ID: <568297e2-9fe2-1d34-beda-35d4906e3b8b@ti.com>
References: <20181106133007.12318-1-sjoerd.simons@collabora.co.uk>
 <9051c212-6e2a-bc39-3686-693e6cd87f1d@ti.com>
 <303b49cbb5b687d6b6a7ad4048eda459586c0806.camel@collabora.co.uk>
 <20181107084741.GA31092@kunai>
 <CAPDyKFpedP1f4XZYvebFCuooYrBa2ux9F9mYRNi1Q=M-5eJ0Rg@mail.gmail.com>
 <20181120102300.GA1056@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181120102300.GA1056@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sjoerd Simons <sjoerd.simons@collabora.co.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, kernel@collabora.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hongjie Fang <hongjiefang@asrmicro.com>, Bastian Stender <bst@pengutronix.de>, Kyle Roeschley <kyle.roeschley@ni.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Shawn Lin <shawn.lin@rock-chips.com>, Harish Jenny K N <harish_kandiga@mentor.com>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Hi,

On 20/11/18 3:53 PM, Wolfram Sang wrote:
> 
>>>> That also happens to be one of the cards we deploy; However i did
>>>> wonder about adding a quirk but decided against it as it was not clear
>>>> to me from the specification that CACHE ON really is meant to complete
>>>> within GENERIC_CMD6_TIMEOUT. That and i fret about ending up in hit-a-
>>>> mole games as the failure is really quite tedious (boot failure).
>>>
>>> I agree that we should use the more defensive variant as a default. I
>>> mean there should be no performance regression since most cards will
>>> respond just faster, or? The only downside I could see is that we might
>>> miss a real timeout with no bounds set and might get stuck?
>>
>> Well, you have a point, but still it's kind of nice to know which
>> cards are behaving well and which ones that doesn't. Hence I think I
>> prefer to stick using a quirk, unless you have a strong opinion.
> 
> No strong opinion. Especially not if you say it is in the spec (although
> "must be sufficient" would be better than "should be" ;)). Also, I
> assume this failure is reproducible and should turn up during
> development? Compared to "happens once in a while randomly"?

At least for me, the failure happens only on some units but is
consistent for a given unit.

> 
> Yet, if we add a quirk for that, then we should probably mention it in
> an error message when we hit -ETIMEDOUT for cache on ("does your card
> need this quirk?")? It can be pretty time consuming to track this down
> otherwise, I'd think.
> 

The QUIRK needs to be card specific. The software should automatically
detect the card (from the CID) and apply the quirk. Please see patch in
my original reply.

Thanks,
Faiz
