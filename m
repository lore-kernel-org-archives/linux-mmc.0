From: Andreas Fenkart <afenkart@gmail.com>
Subject: Re: [PATCH v7 1/4] mmc: omap_hsmmc: Enable SDIO IRQ.
Date: Wed, 5 Mar 2014 09:27:42 +0100
Message-ID: <CALtMJEArwH4g1o+_v8daoxiYZtpHvPMbxM4CZjTxnyGgxTS+aQ@mail.gmail.com>
References: <1393331866-28307-1-git-send-email-afenkart@gmail.com>
	<1393331866-28307-2-git-send-email-afenkart@gmail.com>
	<20140227213335.GJ11654@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20140227213335.GJ11654@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, Daniel Mack <zonque@gmail.com>, Kumar Gala <galak@codeaurora.org>, linux-doc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

2014-02-27 22:33 GMT+01:00 Tony Lindgren <tony@atomide.com>:
>
> Thanks for updating this, I finally got around to spend some
> time with it again. I've folded in your fixes and quirk support
> into my earlier patch from [0] as that had a better changelog
> describing the earlier work.
thanks, always struggled with that

> And I've also now made the SDIO support to depend on properly
> configured wake-up irq from device tree as otherwise wake from
> idle states won't work properly. I've also cleaned up the the
> wake-up irq initialization a bit.
Looks much better now.

Mind that the sdio irq is level triggered. So we have to disable the
IRQ in the handler otherwise we enter an infinite loop.



> The wake-irq is needed for omaps with wake-up path and also
> when doing GPIO remuxing. So the wake-up handling is pretty
> much the same for both cases.
I added this comment to the patch, since I was puzzled that you need
a wake_irq even whithout remuxing.

>
> I've kept your Signed-off-by, can you please check if the patch
> below works for you with the second patch I'll post shortly?

Will send out another patch soon. Left your Signed-off as well, not
in the sense of your agreement, but didn't dare to remove it because
of your contributions.

>
> Regards,
>
> Tony
>
> [0] https://www.mail-archive.com/linux-mmc@vger.kernel.org/msg22290.html
>
