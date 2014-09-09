From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/7 v3] mmc: use .multi_io_quirk on omap_hsmmc
Date: Tue, 9 Sep 2014 08:36:10 +0200
Message-ID: <CAPDyKFoVROGoj3fYSsLZLm1mOrD2o9UfYo03=4MbRj=PSuhXhg@mail.gmail.com>
References: <87r3zvzohj.wl%kuninori.morimoto.gx@gmail.com>
	<87bnqx78xr.wl%kuninori.morimoto.gx@gmail.com>
	<878um178vn.wl%kuninori.morimoto.gx@gmail.com>
	<CAPDyKFoj2_3APb1q_tJ8P8qmDb8RftOyx4+j_Sbb74kDSKEe7Q@mail.gmail.com>
	<87zje97izx.wl%kuninori.morimoto.gx@gmail.com>
	<CAPDyKFpns_+s3LQ-j=yE6vx-uzRtm5MwhxZVeB8r=fnBqJ8vBA@mail.gmail.com>
	<87oaup72ew.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87oaup72ew.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 9 September 2014 08:07, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
>
> Hi Ulf
>
>> > This means we need to copy this ops for each driver ?
>> > Otherwise, it breaks behavior if many drivers were probed.
>>
>> The are only one driver for omap_hsmmc, this is not tmio, which
>> certainly is a different story.
>>
>> What you need to do, is to make omap_hsmmc_ops non const - and assign
>> the function pointer here. That should work.
>
> I meant this case
>
> omap_hsmmc@0 0xAAAAAA irq = xxxx (MULTI read workaround is needed)
> omap_hsmmc@1 0xBBBBBB irq = yyyy (MULTI read workaround is not needed)
>
> Maybe current omap doesn't have 2 hsmmc on 1 SoC (I don't know)
> but, we don't know the future ?
> Of course I can follow your style if this issue never happen

The above can be handled by having different omap variants structs,
like how mmci does it. Also, I don't think we need to worry about that
now. So please adopt to my proposal.

Kind regards
Uffe
