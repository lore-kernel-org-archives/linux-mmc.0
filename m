From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH V5 1/2] mmc: dw_mmc: exynos: Support eMMC's HS400 mode
Date: Thu, 26 Feb 2015 10:22:28 +0900
Message-ID: <54EE7554.6060506@samsung.com>
References: <1422499318-13726-1-git-send-email-alim.akhtar@samsung.com>
 <1422499318-13726-2-git-send-email-alim.akhtar@samsung.com>
 <CAL_Jsq+Mr=WOoCjWRnHnUqo8+UmqxxHbMG3M8+kLNgfhPASteA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:13261 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925AbbBZBWa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Feb 2015 20:22:30 -0500
In-reply-to: <CAL_Jsq+Mr=WOoCjWRnHnUqo8+UmqxxHbMG3M8+kLNgfhPASteA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, "chris@printf.net" <chris@printf.net>, Doug Anderson <dianders@chromium.org>, "kgene@kernel.org" <kgene@kernel.org>, a.kesavan@samsung.com, alim.akhtar@gmail.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Dear, Rob.

On 02/25/2015 11:38 PM, Rob Herring wrote:
> On Wed, Jan 28, 2015 at 8:41 PM, Alim Akhtar <alim.akhtar@samsung.com> wrote:
>> From: Seungwon Jeon <tgih.jun@samsung.com>
>>
>> Implements HS400 mode support for exynos host driver.
>> This also include some updates as new mode is added.
>>
>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>> [Alim: addressed review comments]
>> ---
>>  .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |    7 +
>>  drivers/mmc/host/dw_mmc-exynos.c                   |  185 ++++++++++++++++----
>>  drivers/mmc/host/dw_mmc-exynos.h                   |   19 +-
>>  drivers/mmc/host/dw_mmc.c                          |   16 +-
>>  drivers/mmc/host/dw_mmc.h                          |    2 +
>>  5 files changed, 195 insertions(+), 34 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>> index ee4fc05..aad9844 100644
>> --- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>> @@ -36,6 +36,8 @@ Required Properties:
>>    in transmit mode and CIU clock phase shift value in receive mode for double
>>    data rate mode operation. Refer notes below for the order of the cells and the
>>    valid values.
>> +* samsung,dw-mshc-hs400-timing: Specifies the value of CIU TX and RX clock phase
>> +  shift value for hs400 mode operation.
> 
> What are the units?

Do you means what is "sumsung,dw-mshci-hs400-timing" unit?
It's timing value for eMMC/SD/SDIO clock phase.(It's exynos specific value.)
Using timing value can shift the H/W clock phase.
If invalid timing value is set, eMMC/SD/SDIO can produce the CRC error.

Do you think it can't include into device-tree?
I want to know your thinking. let me know, plz.

Best Regards,
Jaehoon Chung

> 
> Rob
> 

