From: Alim Akhtar <alim.akhtar@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: add support for ARM64
Date: Tue, 9 Sep 2014 17:01:26 +0530
Message-ID: <CAGOxZ506d5FNs1mZTX=ck9WPZsqzR+3ON-aKS2P8v5_iRyFV7w@mail.gmail.com>
References: <1409307891-16523-1-git-send-email-alim.akhtar@samsung.com> <CAPDyKFqk1pwGFuitE0Fk1pqyP_FZiQK1=5OtGUM9Zw6Mp_rWXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yh0-f44.google.com ([209.85.213.44]:47020 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352AbaIILcH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Sep 2014 07:32:07 -0400
In-Reply-To: <CAPDyKFqk1pwGFuitE0Fk1pqyP_FZiQK1=5OtGUM9Zw6Mp_rWXw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Chris Ball <chris@printf.net>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Bresticker <abrestic@chromium.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

Hi Ulf,

On Tue, Sep 9, 2014 at 12:21 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 29 August 2014 12:24, Alim Akhtar <alim.akhtar@samsung.com> wrote:
>> There are upcoming ARM64 SoCs with dw_mmc host controller.
>>
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>> ---
>>  drivers/mmc/host/Kconfig |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index a43295c..72dd6c2 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -580,7 +580,7 @@ config SDH_BFIN_MISSING_CMD_PULLUP_WORKAROUND
>>  config MMC_DW
>>         tristate "Synopsys DesignWare Memory Card Interface"
>>         depends on HAS_DMA
>> -       depends on ARC || ARM || MIPS || COMPILE_TEST
>> +       depends on ARC || ARM || ARM64 || MIPS || COMPILE_TEST
>
> Before enabling this, wouldn't it be better to add the needed support
> in dw_mmc first? Or there are no changes needed?
>
> There are also ongoing development and discussions for exynos7, which
> I guess relates to this?
> http://www.spinics.net/lists/linux-mmc/msg28294.html
Thanks for looking into this.

Yes, this patch is being tested on exynos7 platform which is ongoing
development.
The above link is one of them.
I feel this patch is too generic in nature and we now known at least
exynos7 is going to use this.
I don't know if there are any other ARM64 platform with dw_mmc controller.

So, I am going to leave this upto you to decide when to take this
patch, incase you decided to take it after exynos7 support lands, I
will send a reminder for this.
>
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
Alim
