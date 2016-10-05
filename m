From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [RFC 1/2] sdhci: Add device tree property sd-broken-highspeed
Date: Wed, 5 Oct 2016 15:03:44 -0500
Message-ID: <CAL_JsqLjtn2-FaO_h9JWOsZqttQ35yV6KOnQz2Z-cMr=0GHJCg@mail.gmail.com>
References: <1474660869-15532-1-git-send-email-zach.brown@ni.com>
 <1474660869-15532-2-git-send-email-zach.brown@ni.com> <CAPDyKFogDKM86XKo1iQE1KU5HpEic23FD5YQGF9QjSFYBDJn4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753120AbcJEUEJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 5 Oct 2016 16:04:09 -0400
In-Reply-To: <CAPDyKFogDKM86XKo1iQE1KU5HpEic23FD5YQGF9QjSFYBDJn4Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Zach Brown <zach.brown@ni.com>, Adrian Hunter <adrian.hunter@intel.com>, Mark Rutland <mark.rutland@arm.com>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Oct 5, 2016 at 1:33 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 23 September 2016 at 22:01, Zach Brown <zach.brown@ni.com> wrote:
>> Certain board configurations can make highspeed malfunction due to
>> timing issues. In these cases a way is needed to force the controller
>> and card into standard speed even if they otherwise appear to be capable
>> of highspeed.
>>
>> The sd-broken-highspeed property will let the sdhci driver know that
>> highspeed will not work.
>>
>> Signed-off-by: Zach Brown <zach.brown@ni.com>
>> ---
>>  Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
>> index 8a37782..59332ea 100644
>> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
>> @@ -52,6 +52,8 @@ Optional properties:
>>  - no-sdio: controller is limited to send sdio cmd during initialization
>>  - no-sd: controller is limited to send sd cmd during initialization
>>  - no-mmc: controller is limited to send mmc cmd during initialization
>> +- sd-broken-highspeed: Highspeed is broken, even if the controller and card
>> +  themselves claim they support highspeed.
>
> Regarding a broken card, that is managed via the card quirks and not in DT.
>
> If this is about a controller limitation, we already have the option
> to describe what it supports, so we don't need an option to tell what
> it *not* supports.
>
> For example "cap-sd-highspeed" tells whether the controller supports
> SD high-speed, please use that instead.

If a controller has a capability register and it lies (perhaps the
board has limitations that the SoC does not), then you may need to
disable a feature.

Rob
