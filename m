From: Doug Anderson <dianders@google.com>
Subject: Re: [RESEND PATCH v2 2/4] mmc: core: changes frequency to hs_max_dtr
 when selecting hs400es
Date: Thu, 29 Sep 2016 12:47:37 -0700
Message-ID: <CAD=FV=XptsmgTm-CA1tOd6Dhk7eYbU1qyewkKbBCYP02uGoovg@mail.gmail.com>
References: <1474589577-11193-1-git-send-email-shawn.lin@rock-chips.com> <1474589577-11193-2-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37683 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755540AbcI2Trj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Sep 2016 15:47:39 -0400
Received: by mail-wm0-f46.google.com with SMTP id b80so4164741wme.0
        for <linux-mmc@vger.kernel.org>; Thu, 29 Sep 2016 12:47:39 -0700 (PDT)
In-Reply-To: <1474589577-11193-2-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>

Hi,

On Thu, Sep 22, 2016 at 5:12 PM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Per JESD84-B51 P69, Host need to change frequency to <=52MHz

Technically Page 49.  In the PDF you go to page 69, but the heading on
the top of the page says 49.

> after setting HS_TIMING to 0x1, and host may changes frequency
> to <= 200MHz after setting HS_TIMING to 0x3. That means the card
> expects the clock rate to increase from the current used f_init
> (which is less than 400KHz, but still being less than 52MHz) to
> 52MHz, otherwise we find some eMMC devices significantly report
> failure when sending status.

Technically it seems like things ought to be OK at the slow speed
since technically we're allowed to talk "high speed" at 400 kHZ (or at
any rate <= 52MHz).  ...but I guess I could also see some cards not
liking that.  Though I'm no expert, feel free to add my reviewed-by if
it is useful:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
