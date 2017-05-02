From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/5] mmc: Improve/fix support for SDIO IRQs
Date: Tue, 2 May 2017 09:06:06 +0200
Message-ID: <CAPDyKFrRUveS9BKX7duAFgjyEkDKUueVD4d+9Euf0J3em2U2pQ@mail.gmail.com>
References: <1492636631-28254-1-git-send-email-ulf.hansson@linaro.org> <CAD=FV=UDq0KUkpohniViFwNFjyT=7hVLz1GYvrw7aLZkoNWG3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34994 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbdEBHGI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 May 2017 03:06:08 -0400
Received: by mail-qk0-f179.google.com with SMTP id q1so35145400qkd.2
        for <linux-mmc@vger.kernel.org>; Tue, 02 May 2017 00:06:08 -0700 (PDT)
In-Reply-To: <CAD=FV=UDq0KUkpohniViFwNFjyT=7hVLz1GYvrw7aLZkoNWG3g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@google.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Brian Norris <briannorris@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 28 April 2017 at 23:26, Doug Anderson <dianders@google.com> wrote:
> Ulf,
>
> On Wed, Apr 19, 2017 at 2:17 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> Changes in v2:
>>         - Folded in a new change, patch 1/5 to fix a race condition while
>>         processing SDIO IRQs.
>>         - Fixed review comments provided by Dough.
>>         - Updated change logs.
>>         - Small changes to how ->ack_sdio_irq() is being invoked, to simplify
>>         code.
>>         - Added a revert patch of the dw_mmc change for runtime PM issues, which
>>         was a quick fix for stable/fixes.
>>
>> Some general description of the series:
>>
>> Regressions for SDIO IRQs have been reported for dw_mmc, caused by enabling
>> runtime PM support for it.
>>
>> This series extends and improves the SDIO IRQs support in the core, such that
>> it better suites the need for dw_mmc, particulary around runtime PM.
>>
>> Do note, so far this is only compile tested. I would thus appreciate help in
>> testing and of course also in reviewing.
>>
>>
>> Ulf Hansson (5):
>>   mmc: core: Prevent processing SDIO IRQs when none is claimed
>>   mmc: sdio: Add API to manage SDIO IRQs from a workqueue
>>   mmc: dw_mmc: Convert to use MMC_CAP2_SDIO_IRQ_NOTHREAD for SDIO IRQs
>>   mmc: dw_mmc: Prevent runtime PM suspend when SDIO IRQs are enabled
>>   Revert "mmc: dw_mmc: Don't allow Runtime PM for SDIO cards"
>>
>>  drivers/mmc/core/host.c     |  2 ++
>>  drivers/mmc/core/sdio_irq.c | 27 +++++++++++++++++++++++++--
>>  drivers/mmc/core/sdio_ops.h |  2 ++
>>  drivers/mmc/host/dw_mmc.c   | 44 ++++++++++++++++++++++++++++++++------------
>>  include/linux/mmc/host.h    |  3 +++
>>  5 files changed, 64 insertions(+), 14 deletions(-)
>
> On an rk3288-veyron-jerry system (with Marvell WiFi), I applied your
> series atop v4.11-rc8.  I did basic tests and WiFi seemed to be
> working OK.  I most certainly didn't stress things out, but doing
> basic transfers / pings worked.

Great, thanks for testing!

>
> Oh, but maybe suspend / resume is a bit unhappy?  It's a little hard
> to tell because it doesn't work 100% reliably (with respect to WiFi)
> even without your changes, but with your changes it seems to be broken
> worse.  AKA: i can often get suspend/resume to work without your
> changes, but I've never seen it work with your changes.  I get errors
> like:
>
> [   36.498454] call ff0f0000.dwmmc+ returned 0 after 5 usecs
> [   40.210761] Bluetooth: Host sleep enable command failed
> [   40.216594] Bluetooth: HS not activated, suspend failed!
> [   40.222537] dpm_run_callback(): pm_generic_suspend+0x0/0x48 returns -16
> [   40.229923] call mmc1:0001:2+ returned -16 after 4919039 usecs
> [   40.236442] PM: Device mmc1:0001:2 failed to suspend async: error -16
> [   45.330750] mwifiex_sdio mmc1:0001:1: mwifiex_cmd_timeout_func:
> Timeout cmd id = 0x107, act = 0x0
>
>
> It appears that ("mmc: dw_mmc: Convert to use
> MMC_CAP2_SDIO_IRQ_NOTHREAD for SDIO IRQs") is the one causing it.
> It's plausible that dw_mmc is interacting with things in a bad way,
> though.
>
> I probably can't spend another few days debugging this this right now,
> though.  :(  Anyone else on this thread want to dig?  If not, I might
> be able to come back to this in a bit...

I understand that this is hard to test, simply because the PM support
for SDIO in general is fragile/broken. I am work on fixing this as
well, however let's first fix the behavior for SDIO IRQs. :-)

That said, your report provides me with valuable information. I
believe the problem is that I naively thought the
*system_freezable_wq*, would be suitable to manage SDIO IRQ. Of
course, during suspend the SDIO func driver may decide to send
commands to quiescence its device and those commands may trigger SDIO
IRQs. Using the system_freezable_wq, makes those works that becomes
scheduled to be put on hold.

As simple test can you re-place "system_freezable_wq" with "system_wq"
in sdio_signal_irq() (drivers/mmc/core/sdio_irq.c)?

Kind regards
Uffe
