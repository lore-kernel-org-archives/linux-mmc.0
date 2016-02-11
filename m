From: Matt Redfearn <matt.redfearn@imgtec.com>
Subject: Re: [PATCH v5] mmc: OCTEON: Add host driver for OCTEON MMC controller
Date: Thu, 11 Feb 2016 08:24:24 +0000
Message-ID: <56BC4538.20207@imgtec.com>
References: <1455125775-7245-1-git-send-email-matt.redfearn@imgtec.com>
 <CAPDyKFrMgt9snP2NLbQ6EQ5X7gjQLA+e+TEfqgjzLYTuH+G1OA@mail.gmail.com>
 <56BB9877.9000305@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:35038 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbcBKIY0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Feb 2016 03:24:26 -0500
In-Reply-To: <56BB9877.9000305@caviumnetworks.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Zubair.Kakakhel@imgtec.com, Aleksey Makarov <aleksey.makarov@caviumnetworks.com>, Chandrakala Chavva <cchavva@caviumnetworks.com>, Aleksey Makarov <aleksey.makarov@auriga.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Aaron Williams <aaron.williams@cavium.com>

Hi,
I will split the DT binding document into a separate patch, and move the 
legacy FDT patch-up code to
arch/mips/cavium-octeon/octeon-platform.c as suggested by Florian.

Ulf, your objections to the structure of the DT and driver were the only 
driver for the changes v4->v5.
I changed the DT binding and the structure of the driver to more closely 
resemble the atmel-mci driver, which has the same concept of one 
controller, multiple slots.

Thanks,
Matt

On 10/02/16 20:07, David Daney wrote:
> On 02/10/2016 11:01 AM, Ulf Hansson wrote:
>> On 10 February 2016 at 18:36, Matt Redfearn 
>> <matt.redfearn@imgtec.com> wrote:
>>> From: Aleksey Makarov <aleksey.makarov@caviumnetworks.com>
>>>
>>> The OCTEON MMC controller is currently found on cn61XX and cnf71XX
>>> devices.  Device parameters are configured from device tree data.
>>>
>>> eMMC, MMC and SD devices are supported.
>>>
>>> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
>>> Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
>>> Signed-off-by: David Daney <david.daney@cavium.com>
>>> Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
>>> Signed-off-by: Leonid Rosenboim <lrosenboim@caviumnetworks.com>
>>> Signed-off-by: Peter Swain <pswain@cavium.com>
>>> Signed-off-by: Aaron Williams <aaron.williams@cavium.com>
>>> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
>>> ---
>>> v5:
>>> Incoroprate comments from review
>>> http://patchwork.linux-mips.org/patch/9558/
>>> - Use standard <bus-width> property instead of <cavium,bus-max-width>.
>>> - Use standard <max-frequency> property instead of <spi-max-frequency>.
>>> - Add octeon_mmc_of_parse_legacy function to deal with the above
>>>    properties, since many devices have shipped with those properties
>>>    embedded in firmware.
>>> - Allow the <vmmc-supply> binding in addition to the legacy
>>>    <gpios-power>.
>>> - Remove the secondary driver for each slot.
>>> - Use core gpio cd/wp handling
>>
>> Seems like you decided to ignore most comments realted to the DT
>> bindings from the earlier version.
>> Although, let's discuss this one more time.
>
> I think you may have misread the patch.  The DT bindings have been
> changed based on the feedback we received on v4.
>
>>
>> Therefore I recomend you to split this patch. DT documentation should
>> be a separate patch preceeding the actual mmc driver patch.
>
> You may have missed it the first time it was posted, but the legacy DT
> bindings have been around for a while.
>
> See:
>
> https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-May/015482.html 
>
>
>
>> The DT patch needs to be acked by the DT maintainers.
>
> The legacy DT has been deployed in firmware for several years now.  We
> are adding more "modern" bindings, and the DT maintainers are
> encouraged to review that portion, but the legacy is what it is and it
> isn't changing.
>
>>
>> Until we somewhat agreed on the DT parts, I am going to defer the
>> in-depth review of the driver code as I have limited bandwidth.
>>
>
> As I stated above, the legacy DT bindings are not changing and must be
> supported.  Waiting for legacy DT bindings to change is equivalent to
> infinite deferral.
>
>> Does that make sense to you?
>>
>
> I understand why you would say this.  However, I think it doesn't
> fully take into account the need to support devices that have already
> been deployed.
>
> That said, Matt really needs to get the DT maintainers reviewing the 
> new DT bindings.
>
>
> David Daney

