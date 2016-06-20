From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 1/4] phy: rockchip-emmc: give DLL some extra time to be
 ready
Date: Mon, 20 Jun 2016 09:19:09 -0700
Message-ID: <20160620161908.GA30459@google.com>
References: <1463092986-61777-1-git-send-email-briannorris@chromium.org>
 <5767EB7E.3040606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34745 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888AbcFTQTN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2016 12:19:13 -0400
Received: by mail-pa0-f50.google.com with SMTP id bz2so52301319pad.1
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jun 2016 09:19:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5767EB7E.3040606@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Doug Anderson <dianders@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>, linux-arm-kernel@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

+ linux-mmc, Ulf

On Mon, Jun 20, 2016 at 06:41:26PM +0530, Kishon Vijay Abraham I wrote:
> On Friday 13 May 2016 04:13 AM, Brian Norris wrote:
> > From: Shawn Lin <shawn.lin@rock-chips.com>
> > 
> > According to the databook, 10.2us is the max time for dll to be ready to
> > work. However in testing, some chips need 20us for dll to be ready. This
> > patch adds some extra margin for dllrdy to be ready, fixing our
> > -ETIMEDOUT issues.
> > 
> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> 
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks! I take it that to mean you're agreeing with Doug's suggestion
here:

https://lkml.org/lkml/2016/6/13/1067

"Since [the $subject series patches] aren't in 4.7-rc1 presumably they
would also make sense to take through the MMC tree if others agree."

Ulf,

I see I didn't CC you or linux-mmc on this patch series. Please let me
know if I should resend, or if you can pick these up off of LKML -- Doug
gave nice patchwork links in his linked series. NB: patch 2 has a
version 2, while the others were left unmodified.

Regards,
Brian
