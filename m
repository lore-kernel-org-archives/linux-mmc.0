From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] ARM: dts: Add mmc0 and mmc1 aliases for rk3288
Date: Wed, 13 Aug 2014 20:40:04 -0700
Message-ID: <CAD=FV=XNJ9RRnOaJ5e-D60S5vjZu6UbphdWqqfRq_YfZaXoq+A@mail.gmail.com>
References: <1407974880-30626-1-git-send-email-dianders@chromium.org>
	<53EC177B.1080706@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:53853 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422AbaHNDkG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Aug 2014 23:40:06 -0400
Received: by mail-vc0-f177.google.com with SMTP id hy4so770878vcb.36
        for <linux-mmc@vger.kernel.org>; Wed, 13 Aug 2014 20:40:04 -0700 (PDT)
In-Reply-To: <53EC177B.1080706@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Addy <addy.ke@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Sonny Rao <sonnyrao@chromium.org>, stefan@agner.ch, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Addy,

On Wed, Aug 13, 2014 at 6:57 PM, Addy <addy.ke@rock-chips.com> wrote:

> I think maybe it is suitable as follows:
> mmc0 = &sdmmc
> mmc1 = &sdio0
> mmc2 = &sdio1
> mmc3 = &emmc

Right, except the only ones that have landed in Heiko's tree are sdmmc
and emmc, so we can't do sdio0 and sdio1 yet.  You could post support
for sdio0 and adio1?

Also: it's really handy if emmc is 0.  See below: I don't think it's
great to use the ID to find the sysconfig registers.


> So we can get ctrl_id:
> ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");

Somehow I hadn't realized that was there.  I guess we could use that
too.  I'd vote to remove that and use the standard "mmc" numbering
(and get some momentum to land those patches).  If you want I'll
repost using the mshc stuff, though.


> and can get offset of registers:
> offset = 0x200 + ctrl_id * 8 + 4 * drive_or_sample

I thought the plan was to actually implement the phase stuff as a clock driver.

...even if we didn't, I'd rather not rely on ID like this to find the
right address.  It's really non-obvious.
