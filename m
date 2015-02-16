From: Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [RFC PATCH] mmc: dw_mmc: add status check before clock update
Date: Mon, 16 Feb 2015 17:33:31 +0100
Message-ID: <54E21BDB.5040903@samsung.com>
References: <1423572711-13787-1-git-send-email-a.hajda@samsung.com>
 <1423578559-27947-1-git-send-email-a.hajda@samsung.com>
 <CAGOxZ52E2ymA4WUrqLS28uPmF=3DGExkoFvw=HezC70xs=8dvA@mail.gmail.com>
 <54DB09EA.30602@samsung.com> <54DB13A7.8090101@samsung.com>
 <54DB1B78.1010709@samsung.com>
 <CABxcv=nXuKpGJdBiO2NwUhkYUi7SyuhO1HeEoSUoAESVmEq4XQ@mail.gmail.com>
 <54DDA825.1080509@samsung.com> <54DDB23B.3050407@samsung.com>
 <54DDDBA8.9090405@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:61781 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336AbbBPQdo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Feb 2015 11:33:44 -0500
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NJV00M28I6TW290@mailout4.w1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 16 Feb 2015 16:37:41 +0000 (GMT)
In-reply-to: <54DDDBA8.9090405@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>
Cc: Alim Akhtar <alim.akhtar@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>

On 02/13/2015 12:10 PM, Jaehoon Chung wrote:
> On 02/13/2015 05:13 PM, Andrzej Hajda wrote:
>> On 02/13/2015 08:30 AM, Jaehoon Chung wrote:
>>> Hi, Andrzej.
>>>
>>> On 02/13/2015 01:53 AM, Javier Martinez Canillas wrote:
>>>> Hello Andrzej,
>>>>
>>>> On Wed, Feb 11, 2015 at 10:06 AM, Andrzej Hajda <a.hajda@samsung.com> wrote:
>>>>> On 02/11/2015 09:32 AM, Jaehoon Chung wrote:
>>>>>> On 02/11/2015 04:51 PM, Andrzej Hajda wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> Thanks for comments.
>>>>>>>
>>>>>>> On 02/10/2015 03:54 PM, Alim Akhtar wrote:
>>>>>>>> Hi Andrzej,
>>>>>>>>
>>>>>>>> On Tue, Feb 10, 2015 at 7:59 PM, Andrzej Hajda <a.hajda@samsung.com> wrote:
>>>>>>>>> According to specs for version 250A, status register should be
>>>>>>>>> tested before clock update. Otherwise in case MMC card is missing
>>>>>>>>> mci_send_cmd timeouts and subsequent CTYPE registry write causes system hang.
>>>>>>>>> This behavior has been observed on Exynos5422/Odroid-XU3.
>>>> I've also observed the same behavior (mmc command send timing out and
>>>> system hang) on an Exynos5420 Peach Pit Chromebook and an Exynos5800
>>>> Peach Pi Chromebok which both have the same dw_mmc 250A IP version.
>>>>
>>>> Unfortunately $subject doesn't seem to be enough since even with that
>>>> applied I got:
>>>>
>>>> [    4.264418] mmc_host mmc1: Timeout sending command (cmd 0x202000
>>>> arg 0x0 status 0x80202000)
>>>> [    4.283988] random: nonblocking pool is initialized
>>>> [   28.054406] INFO: rcu_sched detected stalls on CPUs/tasks:
>>>> [   28.058412] 0: (5 ticks this GP) idle=65f/140000000000001/0
>>>> softirq=215/216 fqs=39
>>>> [   28.066129] (detected by 1, t=4765 jiffies, g=-294, c=-295, q=2)
>>>> [   28.072202] Task dump for CPU 0:
>>>> [   28.075412] kworker/u16:0   R running      0     6      2 0x00000002
>>>> [   28.081749] Workqueue: kmmcd mmc_rescan
>>>> [   28.085570] [<c04c2698>] (__schedule) from [<00000000>] (  (null))
>>>> [   28.091724] rcu_sched kthread starved for 796 jiffies!
>>>>
>>>>>>>>> +static bool dw_mci_wait_busy(struct dw_mci *host)
>>>>>>>>> +{
>>>>>>>>> +       unsigned long timeout;
>>>>>>>>> +
>>>>>>>>> +       if (host->verid < DW_MMC_250A)
>>>>>>>>> +               return true;
>>>>>>>>> +
>>>>>>>> I wonder this might be true for 240A as well.
>>>>>>> Odroid-U3 board with Exynos4412 and MMC 240A does not have this problem.
>>>>>>> On the other side busy check does not hurt it anyway.
>>>> This problem also does not happen on an Exynos5250 Snow Chromebook
>>>> which has a dw_mmc IP version 241A.
>>>>
>>>>>> Which kernel version do you use?
>>>>>> I also have the exynos5422 board, but i didn't find the below error yet.
>>>>>> It doesn't relate with IP version.
>>>>>> If you share your environment, i can check with exynos5422 board.
>>>>> linux-next on odroid-xu3. With MMC card removed, booting from sdcard.
>>>>> Please also note that broken-cd quirk is on in dts.
>>> I can't find this problem on exynos5422 board.(Odroix-xu3)
>>> Could you share the properties into dts file?
>> It is just linux-next with exynos_defconfig and
>> arch/arm/boot/dts/exynos5422-odroidxu3.dts, without changes:
>> ...
>> &mmc_0 {
>>         status = "okay";
>>         mmc-pwrseq = <&emmc_pwrseq>;
>>         broken-cd;
>>         card-detect-delay = <200>;
>>         samsung,dw-mshc-ciu-div = <3>;
>>         samsung,dw-mshc-sdr-timing = <0 4>;
>>         samsung,dw-mshc-ddr-timing = <0 2>;
>>         pinctrl-names = "default";
>>         pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
>>         bus-width = <8>;
>>         cap-mmc-highspeed;
>> };
>> ...
> This is node relevant to eMMC.
> I have tested with exynos5422 board(Odroid-xu3) and latest linux-next.
> (Without eMMC card, just booting from SD-card.)
> root-device is SD-card, right? When i try to boot with platform image, it's working fine from Sd-card.
> I can't find anything..

Strange, I have tested it on two odroids-xu3, the same effects.
Full configuration:
Board: odroid-xu3, rev 0.2, 20140529
Configuration: eMMC slot empty, Kernel in MicroSD slot, SanDisk 4GB HCI,
SW1 set to off (boot from uSD)
Kernel: linux-next + Addy's patches '[PATCH v4 0/3] about data busy'[1],
with exynos_defconfig.

And below mmc logs (I have disabled &mmc_2 node, just to make logs cleaner).
I have also used maxcpus=0 and loglevel=9. And every mci_write has been
prepended by:
   pr_err("%s:%pS:%s:%d: status=%#x %s(%#x)=%s(%#x)\n", current->comm,
__builtin_return_address(0), __func__, __LINE__, (u32)mci_readl(dev,
STATUS), #reg, SDMMC_##reg, #value, (u32)(value))
Without eMMC card:
http://paste.debian.net/149780/
With eMMC card:
http://paste.debian.net/149786/

I have already sent dirty patch resolving the issue for my boards [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel.mmc/31209

Regards
Andrzej

>
> Best Regards,
> Jaehoon Chung
>
>> Regarding hardware:
>> eMMC card removed,
>> booting from sdcard.
>>
>> Regards
>> Andrzej
>>
>>>
>>> Best Regards,
>>> Jaehoon Chung
>>>
>>>> I tested by trying to add wifi support to the Peach Pit/Pi Chromebooks
>>>> which have an SDIO wifi chip attached to mmc@12210000. This [0] is the
>>>> patch I've on top of linux-next fwiw.
>>>>
>>>>>> I'm not sure but this patch could be dropped.
>>>>>> Because this patch is just only checking whether card is busy or not.
>>>>>>
>>>>>> this patch(mmc:dw_mmc: fix bug that case 'timeout sending command') can cover your patch.
>>>>> I will test it.
>>>>>
>>>> I tested it and although the mentioned patch does fix the mmc commands
>>>> send timing out, now card detection seems to not be working since the
>>>> kernel keeps waiting for aiting for root device /dev/mmcblk1p4...
>>>>
>>>> and the this error is shown:
>>>>
>>>> [    4.249434] dwmmc_exynos 12210000.mmc: Data busy (status 0x306)
>>>>
>>>> So I tried the other patch from Addy's series "mmc: dw_mmc: Don't
>>>> start command while data busy" but it did not have an effect. I still
>>>> see the data busy error and the uSD card is not detected.
>>>>
>>>> Best regards,
>>>> Javier
>>>>
>>>> [0]: http://paste.debian.net/plain/145877
>>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>

