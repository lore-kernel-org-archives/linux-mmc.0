From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH] mmc: core: Remove timeout when enabling cache
Date: Tue, 20 Nov 2018 15:39:16 +0530
Message-ID: <327f0d23-efd7-a8e3-23d8-945132573c06@ti.com>
References: <20181106133007.12318-1-sjoerd.simons@collabora.co.uk>
 <9051c212-6e2a-bc39-3686-693e6cd87f1d@ti.com>
 <303b49cbb5b687d6b6a7ad4048eda459586c0806.camel@collabora.co.uk>
 <20181107084741.GA31092@kunai>
 <CAPDyKFpedP1f4XZYvebFCuooYrBa2ux9F9mYRNi1Q=M-5eJ0Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpedP1f4XZYvebFCuooYrBa2ux9F9mYRNi1Q=M-5eJ0Rg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, kernel@collabora.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hongjie Fang <hongjiefang@asrmicro.com>, Bastian Stender <bst@pengutronix.de>, Kyle Roeschley <kyle.roeschley@ni.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Shawn Lin <shawn.lin@rock-chips.com>, Harish Jenny K N <harish_kandiga@mentor.com>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Hi Uffe,

On 20/11/18 2:54 PM, Ulf Hansson wrote:
> On 7 November 2018 at 09:47, Wolfram Sang <wsa@the-dreams.de> wrote:
>>
>>> That also happens to be one of the cards we deploy; However i did
>>> wonder about adding a quirk but decided against it as it was not clear
>>> to me from the specification that CACHE ON really is meant to complete
>>> within GENERIC_CMD6_TIMEOUT. That and i fret about ending up in hit-a-
>>> mole games as the failure is really quite tedious (boot failure).
>>
>> I agree that we should use the more defensive variant as a default. I
>> mean there should be no performance regression since most cards will
>> respond just faster, or? The only downside I could see is that we might
>> miss a real timeout with no bounds set and might get stuck?
> 
> Well, you have a point, but still it's kind of nice to know which
> cards are behaving well and which ones that doesn't. Hence I think I
> prefer to stick using a quirk, unless you have a strong opinion.
> 
> Note that, in this case we can use CMD13 to poll for busy, which then
> means it also works for those hosts that doesn't support HW busy
> detection, without getting additional delays. If this hasn't been the
> case, we must be using a quirk, but now we are more free to choose.
> 
>> Maybe it is
>> worth contacting eMMC spec people to at least know what is the expected
>> behaviour?
> 
> According to the spec, the GENERIC_CMD6_TIMEOUT should be sufficient.
> So this card is not conforming to the spec, I think it's as simple as
> that.
> 

Is the QUIRK patch acceptable as it is or do you require some sort of
errata from the card manufacturers?

Thanks,
Faiz
