From: Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [RFC PATCH] mmc: dw_mmc: add status check before clock update
Date: Wed, 11 Feb 2015 10:06:00 +0100
Message-ID: <54DB1B78.1010709@samsung.com>
References: <1423572711-13787-1-git-send-email-a.hajda@samsung.com>
 <1423578559-27947-1-git-send-email-a.hajda@samsung.com>
 <CAGOxZ52E2ymA4WUrqLS28uPmF=3DGExkoFvw=HezC70xs=8dvA@mail.gmail.com>
 <54DB09EA.30602@samsung.com> <54DB13A7.8090101@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:11742 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbbBKJGH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Feb 2015 04:06:07 -0500
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NJL00EGZO4Y1K00@mailout1.w1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 11 Feb 2015 09:10:10 +0000 (GMT)
In-reply-to: <54DB13A7.8090101@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Alim Akhtar <alim.akhtar@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>

On 02/11/2015 09:32 AM, Jaehoon Chung wrote:
> On 02/11/2015 04:51 PM, Andrzej Hajda wrote:
>> Hi,
>>
>> Thanks for comments.
>>
>> On 02/10/2015 03:54 PM, Alim Akhtar wrote:
>>> Hi Andrzej,
>>>
>>> On Tue, Feb 10, 2015 at 7:59 PM, Andrzej Hajda <a.hajda@samsung.com> wrote:
>>>> According to specs for version 250A, status register should be
>>>> tested before clock update. Otherwise in case MMC card is missing
>>>> mci_send_cmd timeouts and subsequent CTYPE registry write causes system hang.
>>>> This behavior has been observed on Exynos5422/Odroid-XU3.
>>>>
>>> A similar patch was posted recently[1], did you check that?
>>> [1] http://www.spinics.net/lists/linux-doc/msg28092.html
>> No, thanks for pointing it. I will look at it closer.
>>
>>>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>>>> ---
>>>> Hi,
>>>>
>>>> This version corrects usleep to usleep_range function call.
>>>>
>>>> Regards
>>>> Andrzej
>>>> ---
>>>>  drivers/mmc/host/dw_mmc.c | 26 ++++++++++++++++++++++++--
>>>>  drivers/mmc/host/dw_mmc.h |  1 +
>>>>  2 files changed, 25 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>>> index 67c0451..6619c8a 100644
>>>> --- a/drivers/mmc/host/dw_mmc.c
>>>> +++ b/drivers/mmc/host/dw_mmc.c
>>>> @@ -878,6 +878,25 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
>>>>                 cmd, arg, cmd_status);
>>>>  }
>>>>
>>>> +static bool dw_mci_wait_busy(struct dw_mci *host)
>>>> +{
>>>> +       unsigned long timeout;
>>>> +
>>>> +       if (host->verid < DW_MMC_250A)
>>>> +               return true;
>>>> +
>>> I wonder this might be true for 240A as well.
>> Odroid-U3 board with Exynos4412 and MMC 240A does not have this problem.
>> On the other side busy check does not hurt it anyway.
> Which kernel version do you use? 
> I also have the exynos5422 board, but i didn't find the below error yet.
> It doesn't relate with IP version.
> If you share your environment, i can check with exynos5422 board.

linux-next on odroid-xu3. With MMC card removed, booting from sdcard.
Please also note that broken-cd quirk is on in dts.

>
> I'm not sure but this patch could be dropped.
> Because this patch is just only checking whether card is busy or not.
>
> this patch(mmc:dw_mmc: fix bug that case 'timeout sending command') can cover your patch.

I will test it.

Regards
Andrzej
>
> Best Regards,
> Jaehoon Chung
>
>> Relevant part of dmesg for Exynos4412/mmc_240a:
>> ...
>> [    2.193967] mmc1: req done (CMD55): -110: 00000000 00000000 00000000
>> 00000000
>> [    2.194000] mmc1: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 7
>> width 0 timing 0
>> [    2.194010] mmc1: starting CMD1 arg 00000000 flags 000000e1
>> [    2.194821] mmc1: req done (CMD1): -110: 00000000 00000000 00000000
>> 00000000
>> [    2.194854] mmc1: clock 0Hz busmode 2 powermode 0 cs 0 Vdd 0 width 0
>> timing 0
>> [    3.195404] mmc1: clock 0Hz busmode 2 powermode 1 cs 0 Vdd 7 width 0
>> timing 0
>> ...
>> and for Exynos5422/mmc_250a:
>> [    3.530672] mmc0: req done (CMD55): -5: 00000000 00000000 00000000
>> 00000000
>> [    3.530707] mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21
>> width 0 timing 0
>> [    3.530716] mmc0: starting CMD1 arg 00000000 flags 000000e1
>> [    3.531004] mmc0: req done (CMD1): -5: 00000000 00000000 00000000
>> 00000000
>> [    3.531039] mmc0: clock 0Hz busmode 2 powermode 0 cs 0 Vdd 0 width 0
>> timing 0
>> [    4.031304] mmc_host mmc0: Busy timeout (cmd 0x202000 arg 0x0)
>> [    5.031323] mmc0: clock 0Hz busmode 2 powermode 1 cs 0 Vdd 21 width 0
>> timing 0
>> [    5.536385] mmc_host mmc0: Busy timeout (cmd 0x202000 arg 0x0)
>>
>>>> +       timeout = jiffies + msecs_to_jiffies(500);
>>>> +       while (time_before(jiffies, timeout)) {
>>>> +               if (!(mci_readl(host, STATUS) & SDMMC_STATUS_BUSY))
>>>> +                       return true;
>>>> +
>>>> +               usleep_range(1000, 2000);
>>>> +       }
>>>> +       dev_err(host->dev, "Busy timeout\n");
>>> Probably you need a controller reset here to bring back controller is
>>> original state.
>> OK.
>>
>> Regards
>> Andrzej
>>
>>
>>>> +
>>>> +       return false;
>>>> +}
>>>> +
>>>>  static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>>>>  {
>>>>         struct dw_mci *host = slot->host;
>>>> @@ -891,8 +910,11 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>>>>                 sdmmc_cmd_bits |= SDMMC_CMD_VOLT_SWITCH;
>>>>
>>>>         if (!clock) {
>>>> -               mci_writel(host, CLKENA, 0);
>>>> -               mci_send_cmd(slot, sdmmc_cmd_bits, 0);
>>>> +               if (dw_mci_wait_busy(host)) {
>>>> +                       mci_writel(host, CLKENA, 0);
>>>> +                       mci_send_cmd(slot, sdmmc_cmd_bits, 0);
>>>> +               } else
>>>> +                       return;
>>>>         } else if (clock != host->current_speed || force_clkinit) {
>>>>                 div = host->bus_hz / clock;
>>>>                 if (host->bus_hz % clock && host->bus_hz > clock)
>>>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>>>> index 0d0f7a27..ea6d4d1 100644
>>>> --- a/drivers/mmc/host/dw_mmc.h
>>>> +++ b/drivers/mmc/host/dw_mmc.h
>>>> @@ -15,6 +15,7 @@
>>>>  #define _DW_MMC_H_
>>>>
>>>>  #define DW_MMC_240A            0x240a
>>>> +#define DW_MMC_250A            0x250a
>>>>
>>>>  #define SDMMC_CTRL             0x000
>>>>  #define SDMMC_PWREN            0x004
>>>> --
>>>> 1.9.1
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>

