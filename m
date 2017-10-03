From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [RFC v2 0/2] Add support for Meson MX "SDIO" MMC controller
Date: Tue, 3 Oct 2017 13:19:08 +0200
Message-ID: <CAFBinCDrEmj27ewWQ4+rNXtFSWR3dUoF5H2qZmn2=bpP6OXSZw@mail.gmail.com>
References: <20170924190528.21841-1-martin.blumenstingl@googlemail.com> <20170927193616.32gxszmk4cjjoqmo@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:34942 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbdJCLT3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Oct 2017 07:19:29 -0400
In-Reply-To: <20170927193616.32gxszmk4cjjoqmo@rob-hp-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: ulf.hansson@linaro.org, mark.rutland@arm.com, carlo@caione.org, khilman@baylibre.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org

Hi Rob,

On Wed, Sep 27, 2017 at 9:36 PM, Rob Herring <robh@kernel.org> wrote:
> On Sun, Sep 24, 2017 at 09:05:26PM +0200, Martin Blumenstingl wrote:
>> This is the successor to Carlo Caione's "Add support for Amlogic Meson
>> MMC driver" series (v5) from [0].
>> This new driver is for the "SDIO" controller found in Amlogic Meson6,
>> Meson8 and Meson8b SoCs and supports an internal mux to allow connecting
>> three cards to it.
>>
>>
>> changes since RFC v1 at [1]:
>> - added COMMON_CLK dependency as reported by the kbuild test robot
>> - use of_platform_device_{create,destroy} instead of open-coding it's
>>   logic
>> - moved struct device (which was an array) from meson_mx_mmc_host to
>>   the corresponding meson_mx_mmc_slot
>> - use struct mmc_command's busy_timeout instead of hard-coding the
>>   timeout values in meson_mx_mmc_start_cmd()
>> - don't use arrays with only one element for the clock parents in
>>   meson_mx_mmc_register_clks()
>> - removed the wrapper functions meson_mx_mmc_readl() meson_mx_mmc_writel()
>> - allow setting the MMC clock to 0 for UHS speed mode (the actual
>>   hardware clock cannot be gated as far as I know, so instead the
>>   lowest supported rate is chosen)
>> - remove unused #include <linux/init.h>
>> - add MMC_CAP_ERASE
>> - removed multiple slot support after discussing this with Ulf
>>   (this is a feature that needs to be part of the MMC core before drivers
>>   can use it)
>> - removed SDIO interrupt support (as I currently don't have a way to
>>   test it)
>> - merge meson_mx_mmc_apply_ios into meson_mx_mmc_set_ios (as that's
>>   the only place where it's needed after removing multiple slot support)
>> - updated the commit message of the driver patch to indicate the
>>   difference between the meson-mx-sdio.c and meson-gx.c (and the "still
>>   missing SDHC") driver
>> - NOTE: I did not add Rob's ACK on the dt-bindings patch because I
>>   introduced the "mmc-slot" compatible for the child nodes as suggested
>>   by Ulf (and I want confirmation from the DT maintainers that I did this
>>   correctly)
>
> Didn't slot support get removed as no h/w really uses that feature?
I have at least one boards which uses it: Endless Mini (EC-100)
the SoC itself has two MMC controllers, but that board has:
- an eMMC module (connected to a yet unsupported MMC controller)
- an internal SD card (connected to the SDIO controller from this patch)
- a RTL8723BS wifi SDIO card (also connected to the SDIO controller
from this patch)

so it's pretty rare - but such hardware exists.


Regards,
Martin
