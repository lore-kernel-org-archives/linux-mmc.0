From: Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH v5 0/5] brcmfmac: sdio: Deal better w/ transmission errors related to idle
Date: Tue, 18 Jun 2019 14:02:04 +0300
Message-ID: <87v9x39mxf.fsf@kamboji.qca.qualcomm.com>
References: <20190617175653.21756-1-dianders@chromium.org>
        <CAPDyKFpaX6DSM_BjtghAHUf7qYCyEG+wMagXPUdgz3Eutovqfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpaX6DSM_BjtghAHUf7qYCyEG+wMagXPUdgz3Eutovqfw@mail.gmail.com>
        (Ulf Hansson's message of "Mon, 17 Jun 2019 20:38:49 +0200")
Sender: netdev-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>, Adrian Hunter <adrian.hunter@intel.com>, Arend van Spriel <arend.vanspriel@broadcom.com>, brcm80211-dev-list.pdl@broadcom.com, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Double Lo <double.lo@cypress.com>, Brian Norris <briannorris@chromium.org>, linux-wireless <linux-wireless@vger.kernel.org>, Naveen Gupta <naveen.gupta@cypress.com>, Madhan Mohan R <madhanmohan.r@cypress.com>, Matthias Kaehlcke <mka@chromium.org>, Wright Feng <wright.feng@cypress.com>, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, netdev <netdev@vger.kernel.org>, brcm80211-dev-list <brcm80211-dev-list@cypress.com>, YueHaibing <yuehaibing@huawei.com>, Allison Randal <allison@lohutok.net>, Thomas Gleixner <tgl>
List-Id: linux-mmc@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On Mon, 17 Jun 2019 at 19:57, Douglas Anderson <dianders@chromium.org> wrote:
>>
>> This series attempts to deal better with the expected transmission
>> errors related to the idle states (handled by the Always-On-Subsystem
>> or AOS) on the SDIO-based WiFi on rk3288-veyron-minnie,
>> rk3288-veyron-speedy, and rk3288-veyron-mickey.
>>
>> Some details about those errors can be found in
>> <https://crbug.com/960222>, but to summarize it here: if we try to
>> send the wakeup command to the WiFi card at the same time it has
>> decided to wake up itself then it will behave badly on the SDIO bus.
>> This can cause timeouts or CRC errors.
>>
>> When I tested on 4.19 and 4.20 these CRC errors can be seen to cause
>> re-tuning.  Since I am currently developing on 4.19 this was the
>> original problem I attempted to solve.
>>
>> On mainline it turns out that you don't see the retuning errors but
>> you see tons of spam about timeouts trying to wakeup from sleep.  I
>> tracked down the commit that was causing that and have partially
>> reverted it here.  I have no real knowledge about Broadcom WiFi, but
>> the commit that was causing problems sounds (from the descriptioin) to
>> be a hack commit penalizing all Broadcom WiFi users because of a bug
>> in a Cypress SD controller.  I will let others comment if this is
>> truly the case and, if so, what the right solution should be.
>>
>> For v3 of this series I have added 2 patches to the end of the series
>> to address errors that would show up on systems with these same SDIO
>> WiFi cards when used on controllers that do periodic retuning.  These
>> systems need an extra fix to prevent the retuning from happening when
>> the card is asleep.
>>
>> I believe v5 of this series is all ready to go assuming Kalle Valo is
>> good with it.  I've added after-the-cut notes to patches awaiting his
>> Ack and have added other tags collected so far.
>>
>> Changes in v5:
>> - Add missing sdio_retune_crc_enable() in comments (Ulf).
>> - /s/reneable/re-enable (Ulf).
>> - Remove leftover prototypes: mmc_expect_errors_begin() / end() (Ulf).
>> - Rewording of "sleep command" in commit message (Arend).
>>
>> Changes in v4:
>> - Moved to SDIO API only (Adrian, Ulf).
>> - Renamed to make it less generic, now retune_crc_disable (Ulf).
>> - Function header makes it clear host must be claimed (Ulf).
>> - No more WARN_ON (Ulf).
>> - Adjust to API rename (Adrian, Ulf).
>> - Moved retune hold/release to SDIO API (Adrian).
>> - Adjust to API rename (Adrian).
>>
>> Changes in v3:
>> - Took out the spinlock since I believe this is all in one context.
>> - Expect errors for all of brcmf_sdio_kso_control() (Adrian).
>> - ("mmc: core: Export mmc_retune_hold_now() mmc_retune_release()") new for v3.
>> - ("brcmfmac: sdio: Don't tune while the card is off") new for v3.
>>
>> Changes in v2:
>> - A full revert, not just a partial one (Arend).  ...with explicit Cc.
>> - Updated commit message to clarify based on discussion of v1.
>>
>> Douglas Anderson (5):
>>   Revert "brcmfmac: disable command decode in sdio_aos"
>>   mmc: core: API to temporarily disable retuning for SDIO CRC errors
>>   brcmfmac: sdio: Disable auto-tuning around commands expected to fail
>>   mmc: core: Add sdio_retune_hold_now() and sdio_retune_release()
>>   brcmfmac: sdio: Don't tune while the card is off
>>
>>  drivers/mmc/core/core.c                       |  5 +-
>>  drivers/mmc/core/sdio_io.c                    | 77 +++++++++++++++++++
>>  .../broadcom/brcm80211/brcmfmac/sdio.c        | 17 ++--
>>  include/linux/mmc/host.h                      |  1 +
>>  include/linux/mmc/sdio_func.h                 |  6 ++
>>  5 files changed, 99 insertions(+), 7 deletions(-)
>>
>> --
>> 2.22.0.410.gd8fdbe21b5-goog
>>
>
> Applied for fixes, thanks!
>
> Some minor changes:
> 1) Dropped the a few "commit notes", that was more related to version
> and practical information about the series.
> 2) Dropped fixes tags for patch 2->5, but instead put a stable tag
> targeted for v4.18+.
>
> Awaiting an ack from Kalle before sending the PR to Linus.
>
> Kalle, perhaps you prefer to pick patch 1, as it could go separate.
> Then please tell - and/or if there is anything else you want me to
> change.

TBH I haven't followed the thread (or patches) that closely :) So feel
free to take them and push them to Linus.

-- 
Kalle Valo
