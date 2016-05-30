From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 2/3] mmc: sunxi: Fix DDR MMC timings for A80
Date: Mon, 30 May 2016 20:59:57 +0800
Message-ID: <CAGb2v65=ZM+deSmTmMnT6XFJv8PuY+Kba3kJGKrk_46hxxRyHA@mail.gmail.com>
References: <1464505484-3661-1-git-send-email-wens@csie.org>
 <1464505484-3661-3-git-send-email-wens@csie.org> <99d78ff3-db4d-45cc-024a-d94583b56f35@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:50298 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620AbcE3NAW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 May 2016 09:00:22 -0400
In-Reply-To: <99d78ff3-db4d-45cc-024a-d94583b56f35@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Mon, May 30, 2016 at 7:34 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 29-05-16 09:04, Chen-Yu Tsai wrote:
>>
>> The MMC clock timings were incorrectly calculated, when the conversion
>> from delay value to delay phase was done.
>>
>> The 50M DDR and 50M DDR 8bit timings are off, and make eMMC DDR
>> unusable. Unfortunately it seems different controllers on the same SoC
>> have different timings. The new settings are taken from mmc2, which is
>> commonly used with eMMC.
>
>
> Hmm, I'm not really all that familiar with mmc, but can't an external
> sdcard connected to mmc0 use DDR too ? Assuming the answer is yes, then
> we really need to update the driver to use the right per controller
> timings.

I would very much like that to happen. However, SD card UHS-1 DDR modes
require 1.8V signaling, which is unavailable on _all_ sunxi boards.
This seems like a limit of most of the SoCs not having a separate IO
voltage rail for mmc pins.

Until then, I wouldn't worry that much.

>> The settings for the slower timing modes seem to work despite being
>> wrong, so leave them be.
>
>
> If you're sure the timings are wrong, please fix them. Sometimes wrong
> timings do seem to work, but lead to unreliable communication, or turn
> out to work on some boards and not on others due to routing differences.

Unfortunately I did try putting in the correct numbers for them, and my
eMMC then failed to probe. It seems the core switches up from 400kHz to
50MHz then to 50MHz DDR, and it fails somewhere in there, maybe at 50MHz.

I'm not sure if we need to add DT bindings to specify different delays
for different controllers, though. Seems like we'll never actually use
it.

Hope this answers your questions.

Regards
ChenYu

> Thanks & Regards,
>
> Hans
>
>
>
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  drivers/mmc/host/sunxi-mmc.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
>> index 7fc8b7aa83f0..5873dc344ab2 100644
>> --- a/drivers/mmc/host/sunxi-mmc.c
>> +++ b/drivers/mmc/host/sunxi-mmc.c
>> @@ -970,8 +970,8 @@ static const struct sunxi_mmc_clk_delay
>> sun9i_mmc_clk_delays[] = {
>>         [SDXC_CLK_400K]         = { .output = 180, .sample = 180 },
>>         [SDXC_CLK_25M]          = { .output = 180, .sample =  75 },
>>         [SDXC_CLK_50M]          = { .output = 150, .sample = 120 },
>> -       [SDXC_CLK_50M_DDR]      = { .output =  90, .sample = 120 },
>> -       [SDXC_CLK_50M_DDR_8BIT] = { .output =  90, .sample = 120 },
>> +       [SDXC_CLK_50M_DDR]      = { .output =  54, .sample =  36 },
>> +       [SDXC_CLK_50M_DDR_8BIT] = { .output =  72, .sample =  72 },
>>  };
>>
>>  static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
>>
>
