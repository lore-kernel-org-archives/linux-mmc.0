From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc-exynos: fixed wrong sample-clock selection
Date: Wed, 17 Sep 2014 11:36:37 +0900
Message-ID: <5418F3B5.40706@samsung.com>
References: <1410776768-1303-1-git-send-email-jh80.chung@samsung.com>
 <CAGOxZ53veu=t+8yzkqCmh0wTWKBBDvuE99qbNbfZuuPxAG=m=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:18483 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720AbaIQCgl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Sep 2014 22:36:41 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NC000F0LXX2NYE0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 17 Sep 2014 11:36:38 +0900 (KST)
In-reply-to: <CAGOxZ53veu=t+8yzkqCmh0wTWKBBDvuE99qbNbfZuuPxAG=m=Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alim Akhtar <alim.akhtar@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>

Hi, Alim.

On 09/17/2014 07:27 AM, Alim Akhtar wrote:
> Hi Jaehoon,
> 
> On Mon, Sep 15, 2014 at 3:56 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Almost all case is selected to 0.
>> (It's not correct sample-clock value.)
>> Since it set to wrong value, HS200 mode don't work fine.
> Can you please explain what problem you are facing here?

When i try to use HS200 with some eMMC card, Some card is working fine and other isn't working fine.
(DWMMC is occured the DCRC error.)
DCRC error might be occurred when the wrong sample-clock is set.
So i tried to see what value is selected to sample-clock.
(Selected value - Working fine card : 0, Not working fine card : 0)

When i skip to 0, it's selected to other value for best sample-clock.
(Selected value - Working fine card : 4, Not working fine card : 6)

After working fine card is selected to 6, it's working fine.
I didn't know which value is set for other card. But in my case, best sample-clock is selected to 0.

I think it has the some problem for selecting the sample-clock.

Best Regards,
Jaehoon Chung

> It is not clear from your patch description.
>> If we want to select the correct value, it has to check from 1 to 7.(skip 0)
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>>  drivers/mmc/host/dw_mmc-exynos.c |    9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
>> index 0fbc53a..5294035 100644
>> --- a/drivers/mmc/host/dw_mmc-exynos.c
>> +++ b/drivers/mmc/host/dw_mmc-exynos.c
>> @@ -25,6 +25,7 @@
>>  #define NUM_PINS(x)                    (x + 2)
>>
>>  #define SDMMC_CLKSEL                   0x09C
>> +#define SDMMC_CLKSEL_CCLK_SAMPLE_MASK  0x7
>>  #define SDMMC_CLKSEL_CCLK_SAMPLE(x)    (((x) & 7) << 0)
>>  #define SDMMC_CLKSEL_CCLK_DRIVE(x)     (((x) & 7) << 16)
>>  #define SDMMC_CLKSEL_CCLK_DIVIDER(x)   (((x) & 7) << 24)
>> @@ -330,6 +331,12 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode,
>>         if (!blk_test)
>>                 return -ENOMEM;
>>
>> +       /*
>> +        * In order to check all selclk_sample clock,
>> +        * it needs to reset to 0.
>> +        */
>> +       dw_mci_exynos_set_clksmpl(host, 0);
>> +
>>         start_smpl = dw_mci_exynos_get_clksmpl(host);
>>
>>         do {
>> @@ -372,7 +379,7 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode,
>>                                 "Tuning error: cmd.error:%d, data.error:%d\n",
>>                                 cmd.error, data.error);
>>                 }
>> -       } while (start_smpl != smpl);
>> +       } while (start_smpl < SDMMC_CLKSEL_CCLK_SAMPLE_MASK);
>>
>>         found = dw_mci_exynos_get_best_clksmpl(candiates);
>>         if (found >= 0)
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

