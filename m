From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 2/3] mmc: sunxi: Fix DDR MMC timings for A80
Date: Mon, 30 May 2016 20:05:29 +0200
Message-ID: <822dc3f1-9afe-f356-e0e7-89073586d401@redhat.com>
References: <1464505484-3661-1-git-send-email-wens@csie.org>
 <1464505484-3661-3-git-send-email-wens@csie.org>
 <99d78ff3-db4d-45cc-024a-d94583b56f35@redhat.com>
 <CAGb2v65=ZM+deSmTmMnT6XFJv8PuY+Kba3kJGKrk_46hxxRyHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57913 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161249AbcE3SFf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 30 May 2016 14:05:35 -0400
In-Reply-To: <CAGb2v65=ZM+deSmTmMnT6XFJv8PuY+Kba3kJGKrk_46hxxRyHA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>

Hi,

On 30-05-16 14:59, Chen-Yu Tsai wrote:
> On Mon, May 30, 2016 at 7:34 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 29-05-16 09:04, Chen-Yu Tsai wrote:
>>>
>>> The MMC clock timings were incorrectly calculated, when the conversion
>>> from delay value to delay phase was done.
>>>
>>> The 50M DDR and 50M DDR 8bit timings are off, and make eMMC DDR
>>> unusable. Unfortunately it seems different controllers on the same SoC
>>> have different timings. The new settings are taken from mmc2, which is
>>> commonly used with eMMC.
>>
>>
>> Hmm, I'm not really all that familiar with mmc, but can't an external
>> sdcard connected to mmc0 use DDR too ? Assuming the answer is yes, then
>> we really need to update the driver to use the right per controller
>> timings.
>
> I would very much like that to happen. However, SD card UHS-1 DDR modes
> require 1.8V signaling, which is unavailable on _all_ sunxi boards.
> This seems like a limit of most of the SoCs not having a separate IO
> voltage rail for mmc pins.
>
> Until then, I wouldn't worry that much.
>
>>> The settings for the slower timing modes seem to work despite being
>>> wrong, so leave them be.
>>
>>
>> If you're sure the timings are wrong, please fix them. Sometimes wrong
>> timings do seem to work, but lead to unreliable communication, or turn
>> out to work on some boards and not on others due to routing differences.
>
> Unfortunately I did try putting in the correct numbers for them, and my
> eMMC then failed to probe. It seems the core switches up from 400kHz to
> 50MHz then to 50MHz DDR, and it fails somewhere in there, maybe at 50MHz.
>
> I'm not sure if we need to add DT bindings to specify different delays
> for different controllers, though. Seems like we'll never actually use
> it.
>
> Hope this answers your questions.

Yes that answers my questions, and with my questions answered, this series is:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

