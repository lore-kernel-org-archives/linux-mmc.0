From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCHv9 1/5] mmc: dw_mmc: Slot quirk "disable-wp" is deprecated.
Date: Fri, 01 Aug 2014 03:35:38 +0900
Message-ID: <53DA8C7A.60205@samsung.com>
References: <1406784907-26349-1-git-send-email-jh80.chung@samsung.com>	<1406784907-26349-2-git-send-email-jh80.chung@samsung.com> <CAD=FV=VfXOqt1A=8-1kq5nhnMrk7PbpCWj-A-UWQN12_U8sW4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:53658 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbaGaSfq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Jul 2014 14:35:46 -0400
In-Reply-To: <CAD=FV=VfXOqt1A=8-1kq5nhnMrk7PbpCWj-A-UWQN12_U8sW4g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@google.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, Dinh Nguyen <dinguyen@altera.com>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>, cpgs <cpgs@samsung.com>

On 08/01/14 01:02, Doug Anderson wrote:
> Jaehoon
>
> On Wed, Jul 30, 2014 at 10:35 PM, Jaehoon Chung<jh80.chung@samsung.com>  wrote:
>> Slot quirks "disable-wp" is deprecated.
>> Instead, use the host quirk "disable-wp".
>> (Because the slot-node is removed in dt-file.)
>>
>> Signed-off-by: Jaehoon Chung<jh80.chung@samsung.com>
>> Tested-by: Sachin Kamat<sachin.kamat@samsung.com>
>> Acked-by: Seungwon Jeon<tgih.jun@samsung.com>
>> ---
>>   drivers/mmc/host/dw_mmc.c  |   11 +++++++++--
>>   include/linux/mmc/dw_mmc.h |    2 ++
>>   2 files changed, 11 insertions(+), 2 deletions(-)
>
> Thanks for taking my suggestion and making it backward compatible.
> This looks great to me.  It tested this in both the backward
> compatible way (with the warning) and the non-backward compatible way.
> I think we should land and patch #2 ASAP and then we can land the rest
> of the series as SoC maintainers see fit.
>
Yes, right if we don't want to see useless merge conflicts...

- Kukjin

> Reviewed-by: Doug Anderson<dianders@chromium.org>
> Tested-by: Doug Anderson<dianders@chromium.org>
