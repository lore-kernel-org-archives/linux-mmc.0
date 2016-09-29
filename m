From: Doug Anderson <dianders@google.com>
Subject: Re: [RESEND PATCH v2 1/4] mmc: core: switch to 1V8 or 1V2 for hs400es mode
Date: Thu, 29 Sep 2016 12:49:50 -0700
Message-ID: <CAD=FV=U0souQowEKK1JBMTGqXqx9g-_xt3mJB_hJXnJgog8+PQ@mail.gmail.com>
References: <1474589577-11193-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38463 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755540AbcI2Ttx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Sep 2016 15:49:53 -0400
Received: by mail-wm0-f49.google.com with SMTP id w72so4670618wmf.1
        for <linux-mmc@vger.kernel.org>; Thu, 29 Sep 2016 12:49:52 -0700 (PDT)
In-Reply-To: <1474589577-11193-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 4.4#@263.net

Hi,

On Thu, Sep 22, 2016 at 5:12 PM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> When introducing hs400es, I didn't notice that we haven't
> switched voltage to 1V2 or 1V8 for it. That happens to work
> as the first controller claiming to support hs400es, arasan(5.1),
> which is designed to only support 1V8. So the voltage is fixed to 1V8.
> But it actually is wrong, and will not fit for other host controllers.
> Let's fix it.
>
> Fixes: commit 81ac2af65793ecf ("mmc: core: implement enhanced strobe support")
> Cc: <stable@vger.kernel.org> 4.4#
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>
> ---
>
> Changes in v2:
> - fix copy-paste error, mea culpa
>
>  drivers/mmc/core/mmc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

This matches what's done for hs200 and also seems sane.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
