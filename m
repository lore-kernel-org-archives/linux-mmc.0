From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCHv9 1/5] mmc: dw_mmc: Slot quirk "disable-wp" is deprecated.
Date: Fri, 01 Aug 2014 10:58:50 +0200
Message-ID: <1765329.zdt1X395r3@diego>
References: <1406784907-26349-1-git-send-email-jh80.chung@samsung.com> <53DA8CCB.3080900@samsung.com> <53DB1703.4090002@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:54942 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750851AbaHAI51 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 1 Aug 2014 04:57:27 -0400
In-Reply-To: <53DB1703.4090002@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Doug Anderson <dianders@google.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Dinh Nguyen <dinguyen@altera.com>, Mark Rutland <mark.rutland@arm.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>, cpgs <cpgs@samsung.com>

Am Freitag, 1. August 2014, 13:26:43 schrieb Jaehoon Chung:
> Hi, All.
> 
> It seems too late that this patch-set is merged into linux-3.16.
> Also there are some conflicts in device-tree. (I will remove the conflicts)
> So if everybody is ok, I will rebase on linux-next after released
> linux-3.16. At that time, i will send this patch-set to stable kernel, too.
> how about?

> And I want to know who can apply this patch-set(#3~#5).

I guess each SoC maintainer could take the changes to their work-area, once 
the core changes have landed in the mmc tree. So I would take the Rockchip 
patch, Kukjin the Exynos one and Dinh the socfpga patch.


Heiko

> 
> Best Regards,
> Jaehoon Chung
> 
> On 08/01/2014 03:36 AM, Kukjin Kim wrote:
> > On 08/01/14 01:02, Doug Anderson wrote:
> >> Jaehoon
> >> 
> >> On Wed, Jul 30, 2014 at 10:35 PM, Jaehoon Chung<jh80.chung@samsung.com>  
wrote:
> >>> Slot quirks "disable-wp" is deprecated.
> >>> Instead, use the host quirk "disable-wp".
> >>> (Because the slot-node is removed in dt-file.)
> >>> 
> >>> Signed-off-by: Jaehoon Chung<jh80.chung@samsung.com>
> >>> Tested-by: Sachin Kamat<sachin.kamat@samsung.com>
> >>> Acked-by: Seungwon Jeon<tgih.jun@samsung.com>
> >>> ---
> >>> 
> >>>   drivers/mmc/host/dw_mmc.c  |   11 +++++++++--
> >>>   include/linux/mmc/dw_mmc.h |    2 ++
> >>>   2 files changed, 11 insertions(+), 2 deletions(-)
> >> 
> >> Thanks for taking my suggestion and making it backward compatible.
> >> This looks great to me.  It tested this in both the backward
> >> compatible way (with the warning) and the non-backward compatible way.
> >> I think we should land and patch #2 ASAP and then we can land the rest
> >> of the series as SoC maintainers see fit.
> > 
> > Yes, right if we don't want to see useless merge conflicts...
> > 
> > When I sent ack on exynos stuff, there was no conflict with my tree but
> > happens it now.
> > 
> > - Kukjin
> > 
> >> Reviewed-by: Doug Anderson<dianders@chromium.org>
> >> Tested-by: Doug Anderson<dianders@chromium.org>

