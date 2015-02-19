From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: fix bug that cause mmc_test failture
Date: Thu, 19 Feb 2015 14:39:53 -0800
Message-ID: <CAD=FV=Xxoo=HGhLad4pr=TKN7sWQ5Pzai=dGGvUUZe173DhLOA@mail.gmail.com>
References: <1422273849-29773-1-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35052 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217AbbBSWjz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Feb 2015 17:39:55 -0500
Received: by iecrl12 with SMTP id rl12so3849864iec.2
        for <linux-mmc@vger.kernel.org>; Thu, 19 Feb 2015 14:39:54 -0800 (PST)
In-Reply-To: <1422273849-29773-1-git-send-email-addy.ke@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Addy Ke <addy.ke@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Dinh Nguyen <dinguyen@altera.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Olof Johansson <olof@lixom.net>, Sonny Rao <sonnyrao@chromium.org>, Alexandru Stan <amstan@chromium.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Addy,

Your subject needs work.  It should at least touch on what the bug
was.  Please use a subject more like:
  mmc: dw_mmc: fix mmc_test by not sending abort for DRTO / EBE errors

On Mon, Jan 26, 2015 at 4:04 AM, Addy Ke <addy.ke@rock-chips.com> wrote:
> The STOP command can terminate a data transfer between a memory card and
> mmc controller.
>
> As show in Synopsys DesignWare Cores Mobile Stroage Host Databook:
> Data timeout and Data end-bit error will terminate further data transfer
> by mmc controller. So we should not send abort command to terminate a
> data transfer again if we got DRTO and EBE interrupt.

OK, I see this in the section "Error Detection".

Looking at the section titled "Error Handling" in the version of the
databook I see it suggesting "STOP or ABORT" in the case of Data
Errors which might include "end bit not found".  In another section
(the Card Interface Unit (CIU) section) it talks about the data end
bit error and suggests issuing the stop/abort command.

...that being said, it does appear that you're right that we don't
want to send an abort in the EBE case since it appears necessary to
fully fix mmc_test...

> After this patch, all mmc_test cases can pass on RK3288-Pink2 board.

I didn't find this to be the case.  I asked Alexandru to
double-confirm for me and he agrees, it doesn't fix mmc_test.
Probably because your code is broken.  See below.


> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 4d2e3c2..4bd7df1 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1520,7 +1520,10 @@ static void dw_mci_tasklet_func(unsigned long priv)
>                         if (test_and_clear_bit(EVENT_DATA_ERROR,
>                                                &host->pending_events)) {
>                                 dw_mci_stop_dma(host);
> -                               send_stop_abort(host, data);
> +                               if (data->stop ||
> +                                   !(host->data_status & SDMMC_INT_DRTO) ||
> +                                   !(host->data_status & SDMMC_INT_EBE))
> +                                       send_stop_abort(host, data);

Your concept appears right, but your code is totally wrong.  Let's
imagine that data->stop is NULL so your check matters.  Now:

DRTO is set, EBE is set: you won't send stop abort
DRTO is set, EBE is _not_ set: you _will_ send stop aborft
DRTO is _not_ set, EBE is set: you _will_ send stop aborft

I can fix this with:

-                                   !(host->data_status & SDMMC_INT_DRTO) ||
-                                   !(host->data_status & SDMMC_INT_EBE))
+                                   !(host->data_status & (SDMMC_INT_DRTO |
+                                                          SDMMC_INT_EBE)))

When I do that then mmc_test is working much better.  Note that is
appears that both EBE and DRTO are necessary here.  Can you please
respin?  Please make sure to include Addy and Javier on your patch as
they may be able to do some extra testing.

-Doug
