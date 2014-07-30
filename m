From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCHv7 5/5] mmc: dw_mmc: replace "disable-wp" from slot's quirk
 to host's quirk
Date: Wed, 30 Jul 2014 11:47:26 +0900
Message-ID: <53D85CBE.8090104@samsung.com>
References: <1406514579-3769-1-git-send-email-jh80.chung@samsung.com>
 <1406514579-3769-6-git-send-email-jh80.chung@samsung.com>
 <CAD=FV=VnP7q0UE0uP_8Hzbhtu6qJqz2kUR9E_sfk4wHbBH_7cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:20750 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbaG3Cr2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Jul 2014 22:47:28 -0400
In-reply-to: <CAD=FV=VnP7q0UE0uP_8Hzbhtu6qJqz2kUR9E_sfk4wHbBH_7cg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@google.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, Dinh Nguyen <dinguyen@altera.com>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>, CPGS <cpgs@samsung.com>

Hi, Doug.

Thanks for review.

On 07/30/2014 03:01 AM, Doug Anderson wrote:
> Jaehoon,
> 
> On Sun, Jul 27, 2014 at 7:29 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Replaced the "disable-wp" into host's quirks.
>> (Because the slot-node is removed at dt-file.)
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Tested-by: Sachin Kamat <sachin.kamat@samsung.com>
>> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
>> ---
>>  drivers/mmc/host/dw_mmc.c  |   12 +++++-------
>>  include/linux/mmc/dw_mmc.h |    6 ++----
>>  2 files changed, 7 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 1ac227c..4a4f66f 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -997,7 +997,7 @@ static int dw_mci_get_ro(struct mmc_host *mmc)
>>         int gpio_ro = mmc_gpio_get_ro(mmc);
>>
>>         /* Use platform get_ro function, else try on board write protect */
>> -       if (slot->quirks & DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT)
>> +       if (slot->host->quirks & DW_MCI_QUIRK_NO_WRITE_PROTECT)
> 
> It doesn't seem like it would be hard to include support for the old
> binding (and just print a warning).  Then this could land ahead of the
> device tree changes.
> 
> Generally I think we're supposed to keep support for old device trees
> if possible (except in extreme cases).
Ok, I see. I will add the Warning message like this. ("Recommend not to use the slot-node...")
Then Developers can change the device-tree, right.

Today, i will send the patch. If you have any other comment, let me know, plz.
I want to merge this patch-set into 3.16.

Best Regards,
Jaehoon Chung
> 
> -Doug
> 

