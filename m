From: Alim Akhtar <alim.akhtar@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: fix card read threshold for PIO mode
Date: Sat, 22 Nov 2014 18:56:46 +0530
Message-ID: <CAGOxZ51DPL+6HTSG6yeCqqRxtq7XBuWki7gdB-ieamVUKixCDQ@mail.gmail.com>
References: <1416551950-8277-1-git-send-email-shawn.guo@linaro.org> <20141121233155.GC11253@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20141121233155.GC11253@dragon>
Sender: stable-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Chris Ball <chris@printf.net>, stable@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi Shawn,

On Sat, Nov 22, 2014 at 5:01 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Seungwon, Jaehoon,
>
> On Fri, Nov 21, 2014 at 02:39:10PM +0800, Shawn Guo wrote:
>> Commit f1d2736c8156 ("mmc: dw_mmc: control card read threshold")
>> introduces a regression for use case where PIO mode is used, i.e.
>> CONFIG_MMC_DW_IDMAC is not disabled.  It stops kernel from booting
>
> s/not disabled/disabled
>
>> like below.
>
> For understanding the problem better, can you guys please to test the
> dw_mmc driver on Samsung platforms with CONFIG_MMC_DW_IDMAC disabled.
> I'm wondering this is a problem specific to my platform or a common one.
>
I tested PIO mode on exynos5800-peach-pi board with Ulf's -next
branch, and it works fine.
To confirm PIO mode works, I ran iozone and it gave  low performance
number (as expected) then IDMA mode.

One thing to note, is your controller version is 210a, so not sure if
something more in missing from driver.
Also from log its looks like you card clock is 26Mhz, did you tried
running at 52Mhz?

> Shawn
>
>>
>> dw_mmc 9408000.dwmmc: fifo-depth property not found, using value of FIFOTH register as default
>> dw_mmc 9408000.dwmmc: Using PIO mode.
>> dw_mmc 9408000.dwmmc: Version ID is 210a
>> dw_mmc 9408000.dwmmc: DW MMC controller at irq 72, 32 bit host data width, 32 deep fifo
>> dw_mmc 9408000.dwmmc: 1 slots initialized
>> ...
>> Waiting for root device /dev/mmcblk0p2...
>> mmc_host mmc0: Bus speed (slot 0) = 52000000Hz (slot req 50000000Hz, actual 26000000HZ div = 1)
>> mmc0: new high speed SDHC card at address b368
>> mmcblk0: mmc0:b368 AF UD 3.84 GiB
>>
>> Rather than clearing read threshold bits, the best thing that function
>> dw_mci_ctrl_rd_thld() should do is leaving the bits untouched, in case
>> that card read threshold setup is not needed.
>>
>> The patch fixes the regression by changing dw_mci_ctrl_rd_thld() a bit
>> to do nothing in case card read threshold bits setup is not needed.
>>
>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>> Fixes: f1d2736c8156 ("mmc: dw_mmc: control card read threshold")
>> Cc: <stable@vger.kernel.org> # 3.13+
>> ---
>>  drivers/mmc/host/dw_mmc.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 69f0cc68d5b2..52c04ba69970 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -628,13 +628,13 @@ static void dw_mci_ctrl_rd_thld(struct dw_mci *host, struct mmc_data *data)
>>
>>       if (host->timing != MMC_TIMING_MMC_HS200 &&
>>           host->timing != MMC_TIMING_UHS_SDR104)
>> -             goto disable;
>> +             return;
>>
>>       blksz_depth = blksz / (1 << host->data_shift);
>>       fifo_depth = host->fifo_depth;
>>
>>       if (blksz_depth > fifo_depth)
>> -             goto disable;
>> +             return;
>>
>>       /*
>>        * If (blksz_depth) >= (fifo_depth >> 1), should be 'thld_size <= blksz'
>> @@ -644,9 +644,6 @@ static void dw_mci_ctrl_rd_thld(struct dw_mci *host, struct mmc_data *data)
>>       thld_size = blksz;
>>       mci_writel(host, CDTHRCTL, SDMMC_SET_RD_THLD(thld_size, 1));
>>       return;
>> -
>> -disable:
>> -     mci_writel(host, CDTHRCTL, SDMMC_SET_RD_THLD(0, 0));
>>  }
>>
>>  static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
>> --
>> 1.9.1
>>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Regards,
Alim
