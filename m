From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: core: Improve marking broken HPI through devicetree
Date: Tue, 19 Apr 2016 21:20:18 +0200
Message-ID: <CAPDyKFrOygcS-S0K0nDpPhKoOLsBV+W1-PnQ7EYZ5Z4r_zAiGw@mail.gmail.com>
References: <1461049934-12848-1-git-send-email-oliver@schinagl.nl>
	<1461049934-12848-2-git-send-email-oliver@schinagl.nl>
	<CAPDyKFqftYtrHvcQB7te1fuWxjWtrhOGY=5DnRTnrRxHm2cQ-A@mail.gmail.com>
	<5715FD6B.5000809@schinagl.nl>
	<5716150D.7060200@redhat.com>
	<57162854.5050109@schinagl.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35774 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754382AbcDSTUU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2016 15:20:20 -0400
Received: by mail-wm0-f48.google.com with SMTP id e201so25691782wme.0
        for <linux-mmc@vger.kernel.org>; Tue, 19 Apr 2016 12:20:19 -0700 (PDT)
In-Reply-To: <57162854.5050109@schinagl.nl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Michal Hocko <mhocko@suse.com>, Lars-Peter Clausen <lars@metafoo.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Wenkai Du <wenkai.du@intel.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Jaehoon Chung <jh80.chung@samsung.com>, Michal Suchanek <hramrach@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

[...]

> Well I think we still have a very small sample size, the sun4i, sun5i and
> sun7i boards (all using the same mmc controller afaik) have the broken-hpi
> set, the sun6i and sun8i seem to be working fine (different mmc
> controller?).
> I'm not so sure it is an eMMC specific problem though. The module we're
> using is a high-end micron part, industrial grade. Granted, it could be
> still broken there, but I find it less likely. Micron has an interessting
> technical document:
> "TN-52-05 e.EMMC Linux Enablement"
> talking specifically about HPI on eMMC.
> It also mentions HPI is a mmc/jedic 4.41 thing, afaik our controller is only
> 4.3 (which might not even matter according to Ulf if it is just a command).
>
> The datasheet of the chip I use, MTFC4GACAANA, also mentions explicitly that
> it supports HPI.
>
> Granted, it could still be broken, but I have doubts.

Perhaps the same eMMC is used without errors on other controllers?

>
>>
>> But given how rare eMMC-s are on sun4i/sun5i/sun7i I think the current
>> solution where we set a flag on the emmc dt node rather then on the
>> host node / in the host driver is fine.
>
> Yeah it is very limited, that is true, and I suppose I can live with that.
>>
>>
>> Taking your case into account too, that will bring us up to 2 cases
>> where we set the broken-hpi flag on the emmc node, which does not
>> really seem like a number to worry about.
>
> Actually, 4 :), there are 3 sun5i (tablets?) devices that suffer from this
> and my device now. The sun6i and sun8i devices are only 2 (the sinlinx
> devices in the current kernel) that a very quick grep (mmc-card ) showed.
> Grepping for non-removable yielded a bit more, like the chip sun5i-like
> device with a "non-removable" mmc, not sure what to make of that though.
>>
>>
>> TL;DR: Thanks for writing this patch set, but given recent developments
>> I believe that it is best to keep handling broken-hpi as we are doing
>> in current kernels and no changes are necessary.
>
> I would still recommend to add the capability and raise the flag for the
> sun[457]i devices though, as my gut thinks it's a problem with the sunxi IP
> there. But with the emmc-card level work around, it does solve/fix it, so
> what is the best way?

The best is clearly to make a proper debug investigation before we
decide to add a DT binding for the host.

I don't know on what level you are able to measure signals on the HW,
but if not, perhaps the newly TRACE support in the MMC core can help.

Kind regards
Uffe
