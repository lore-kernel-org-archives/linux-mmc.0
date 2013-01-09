From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: [PATCH v5 0/4] mmc: core: Signal voltage switch procedure for UHS mode
Date: Wed, 9 Jan 2013 11:35:51 +0100
Message-ID: <CA+20K0BE2e5codiJf4a8yjyRvxgGd74nRVp_gT_sONdnM3evdQ@mail.gmail.com>
References: <1357653962-10887-1-git-send-email-johan.rudholm@stericsson.com>
	<CAPDyKFpTb2QeSxxQLX9smSdx9_4XqvennLV1v22hfeo-aSXa+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54306 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755272Ab3AIKfv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Jan 2013 05:35:51 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so2026110obb.33
        for <linux-mmc@vger.kernel.org>; Wed, 09 Jan 2013 02:35:51 -0800 (PST)
In-Reply-To: <CAPDyKFpTb2QeSxxQLX9smSdx9_4XqvennLV1v22hfeo-aSXa+w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Johan Rudholm <johan.rudholm@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>, Kevin Liu <keyuan.liu@gmail.com>, Philip Rakity <prakity@nvidia.com>, Daniel Drake <dsd@laptop.org>, Aaron <leafy.myeh@allwinnertech.com>, Subhash Jadavani <subhashj@codeaurora.org>, Wei WANG <wei_wang@realsil.com.cn>

Hi,

2013/1/8 Ulf Hansson <ulf.hansson@linaro.org>:
> On 8 January 2013 15:05, Johan Rudholm <johan.rudholm@stericsson.com> wrote:
>> This patch series attempts to make the 1.8V signal voltage switch
>> required for UHS mode work according to the SD specification.
>>
>> These patches have been tested with a couple of UHS SD cards, one of
>> which sometimes requires up to five power cycles before it accepts the
>> signal voltage switch. The patches have also been tested with various
>> other SD cards, as well as one SDIO WLAN chip (cw1200) to check
>> for regressions. The patches have also been tested with
>> CONFIG_MMC_CLKGATE.
>>
>> As usual, I'd be very grateful if someone could help me test this patch
>> with an UHS SDIO card and perhaps also a combo card (which does seem to
>> be rare these days?)?
>>
>> This patch series is based on previous RFC/patch:
>>
>> [RFC/PATCH v2] mmc: core: Fixup signal voltage switch
>>
>> and more recently on Kevin Liu's patches:
>>
>> [PATCH v2 1/3] mmc: core: enhance the code for signal voltage setting
>> [PATCH v2 2/3] mmc: core: cycle power the card in voltage switch rather than mmc_sd_get_cid
>>
>> Changelog:
>>         v4 -> v5
>>         - Reset signal_voltage in struct ios if switch fails
>>         v3 -> v4
>>         - Added "mmc: core: Break out start_signal_voltage_switch",
>>           which divides up mmc_set_signal_voltage to avoid a recursive
>>           call from mmc_power_up. This removed the third argument
>>           (cmd11) of the function
>>         - Minor bug fixes
>>         v2 -> v3
>>         - Minor bug fixes
>>         v1 -> v2
>>         - Move mmc_power_cycle to the mmc_set_signal_voltage function
>>         - Check card_busy before switching voltages
>>         - Return -EPERM if signal voltage switch with cmd11 is
>>           requested, but no start_signal_voltage_switch is defined.
>>         - If we're switching back to 3.3 V, just do the switch without
>>           checking card_busy etc
>>         v2 -> This patch series
>>         - Removed the extra argument to the card_busy host_ops function
>>         - Added mmc_power_cycle
>>         - Some clarifying comments
>>         v1 -> v2
>>         - Removed reset of signal voltage in mmc_sd_get_cid, since
>>           "mmc: core: reset signal voltage on power up"
>>         previous two patches -> v1:
>>         - Keep calls to mmc_host_clk_hold / mmc_host_clk_release
>>         - Add retry-loop / power cycle in sdio.c
>>         - Fall back to 3.3 V if the switch repeatedly fails
>>         - Add an extra argument to the card_busy host_ops function,
>>           which can be used to signal polling use of the function
>>
>> Johan Rudholm (4):
>>   mmc: core: Add mmc_power_cycle
>>   mmc: core: Add card_busy to host_ops
>>   mmc: core: Break out start_signal_voltage_switch
>>   mmc: core: Fixup signal voltage switch
>>
>>  drivers/mmc/core/core.c  |  114 +++++++++++++++++++++++++++++++++++++++-------
>>  drivers/mmc/core/core.h  |    5 +-
>>  drivers/mmc/core/mmc.c   |    8 ++--
>>  drivers/mmc/core/sd.c    |   23 +++++++---
>>  drivers/mmc/core/sdio.c  |   23 ++++++++--
>>  include/linux/mmc/host.h |    3 ++
>>  6 files changed, 144 insertions(+), 32 deletions(-)
>>
>> --
>> 1.7.10
>>
>
> For those patches in this patchset that does not already have my signoff-by;
>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Also, since Wei very kindly agreed to test the patch set with the rtsx driver:

Tested-by: Wei WANG <wei_wang@realsil.com.cn>

Kind regards, Johan
