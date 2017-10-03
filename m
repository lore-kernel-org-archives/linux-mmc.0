From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 3/3] mmc: dw_mmc: Add locking to the CTO timer
Date: Tue, 3 Oct 2017 11:45:50 -0700
Message-ID: <CAD=FV=U78WfojBJYEObr1M6aR=zxNC1MkOLuREnGXABFoqYXPw@mail.gmail.com>
References: <20170927205631.31559-1-dianders@chromium.org> <20170927205631.31559-4-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:47148 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbdJCSpw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Oct 2017 14:45:52 -0400
Received: by mail-qt0-f179.google.com with SMTP id z50so9776360qtj.4
        for <linux-mmc@vger.kernel.org>; Tue, 03 Oct 2017 11:45:52 -0700 (PDT)
In-Reply-To: <20170927205631.31559-4-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Brian Norris <briannorris@chromium.org>, Alexandru M Stan <amstan@chromium.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>

Hi,

On Wed, Sep 27, 2017 at 1:56 PM, Douglas Anderson <dianders@chromium.org> wrote:
> This attempts to instill a bit of paranoia to the code dealing with
> the CTO timer.  It's believed that this will make the CTO timer more
> robust in the case that we're having very long interrupt latencies.
>
> Note that I originally thought that perhaps this patch was being
> overly paranoid and wasn't really needed, but then while I was running
> mmc_test on an rk3399 board I saw one instance of the message:
>   dwmmc_rockchip fe320000.dwmmc: Unexpected interrupt latency
>
> I had debug prints in the CTO timer code and I found that it was
> running CMD 13 at the time.
>
> ...so even though this patch seems like it might be overly paranoid,
> maybe it really isn't?
>
> Presumably the bad interrupt latency experienced was due to the fact
> that I had serial console enabled as serial console is typically where
> I place blame when I see absurdly large interrupt latencies.  In this
> particular case there was an (unrelated) printout to the serial
> console just before I saw the "Unexpected interrupt latency" printout.
>
> ...and actually, I managed to even reproduce the problems by running
> "iw mlan0 scan > /dev/null" while mmc_test was running.  That not only
> does a bunch of PCIe traffic but it also (on my system) outputs some
> SELinux log spam.
>
> Fixes: 03de19212ea3 ("mmc: dw_mmc: introduce timer for broken command transfer over scheme")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/mmc/host/dw_mmc.c | 92 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 82 insertions(+), 10 deletions(-)

I'm hoping that someone upstream might have some time to test and
review these three patches since I believe that they fix a regression
in 4.14.  I pinged Shawn Lin and found that it's a Chinese holiday
right now so he won't be able to test util next week, but presumably
others might be noticing problems with SD cards or eMMC using dw_mmc
on kernel 4.14, especially with serial console enabled?

Adding linux-rockchip to the CC here.  Original patches can be found
on patchwork.kernel.org...

Thanks!

-Doug
