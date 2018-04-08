From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: dw_mmc-k3: Fix DDR52 mode by setting required clock
 divisor
Date: Sun, 8 Apr 2018 09:51:49 +0800
Message-ID: <9d4bec45-42e3-da8d-ff29-1f24db27faf5@rock-chips.com>
References: <20180329182423.21201-1-ryan@edited.us>
 <e3ec3a77-f2f3-2164-4dbb-80e1ba3ebc63@rock-chips.com>
 <CAGoBSJq+tSpvFZsJLPffTaFBg5o2Nn2eeXXvHqt4Us_dd7==1w@mail.gmail.com>
 <bed16723-6bf0-4bcf-f44c-ebcf7a1e7cc5@rock-chips.com>
 <CAGoBSJogjG9efE9EKdinTCN9Px0zsW1_=5msXjHrLZXVjLBgow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGoBSJogjG9efE9EKdinTCN9Px0zsW1_=5msXjHrLZXVjLBgow@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryan Grachek <ryan@edited.us>
Cc: shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>, liwei <liwei213@huawei.com>, Suzhuangluan <suzhuangluan@hisilicon.com>
List-Id: linux-mmc@vger.kernel.org

On 2018/4/6 21:41, Ryan Grachek wrote:
> On Wed, Apr 4, 2018 at 7:51 PM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>> [+ Zhangfei Gao who added support for hi6220]
>>
>> On 2018/4/4 23:31, Ryan Grachek wrote:
>>>
>>> On Tue, Apr 3, 2018 at 6:31 AM, Shawn Lin <shawn.lin@rock-chips.com
>>> <mailto:shawn.lin@rock-chips.com>> wrote:
>>>
>>>      On 2018/3/30 2:24, oscardagrach wrote:
>>>
>>>      Need at least one line commit body.
>>>
>>>          Signed-off-by: oscardagrach <ryan@edited.us
>>> <mailto:ryan@edited.us>>
>>>
>>>          ---
>>>             drivers/mmc/host/dw_mmc-k3.c | 10 ++++++++--
>>>             1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>>          diff --git a/drivers/mmc/host/dw_mmc-k3.c
>>>          b/drivers/mmc/host/dw_mmc-k3.c
>>>          index 89cdb3d533bb..efc546cb4db8 100644
>>>          --- a/drivers/mmc/host/dw_mmc-k3.c
>>>          +++ b/drivers/mmc/host/dw_mmc-k3.c
>>>          @@ -194,8 +194,14 @@ static void dw_mci_hi6220_set_ios(struct
>>>          dw_mci *host, struct mmc_ios *ios)
>>>                   int ret;
>>>                   unsigned int clock;
>>>             -     clock = (ios->clock <= 25000000) ? 25000000 : ios->clock;
>>>          -
>>>          +       /* CLKDIV must be 1 for DDR52/8-bit mode */
>>>          +       if (ios->bus_width == MMC_BUS_WIDTH_8 &&
>>>          +               ios->timing == MMC_TIMING_MMC_DDR52) {
>>>          +               mci_writel(host, CLKDIV, 0x1);
>>>          +               clock = ios->clock;
>>>          +       } else {
>>>          +               clock = (ios->clock <= 25000000) ? 25000000 :
>>>          ios->clock;
>>>          +       }
>>>
>>>
>>>      I undertand DDR52/8-bit need CLKDIV fixed 1, but shouldn't the
>>> following
>>>      change is more sensible?
>>>
>>>      if (ios->bus_width == MMC_BUS_WIDTH_8 && ios->timing ==
>>>      MMC_TIMING_MMC_DDR52)
>>>               clock = ios->clock * 2;
>>>      else
>>>               clock = (ios->clock <= 25000000) ? 25000000 : ios->clock;
>>>
>>>
>>>      The reason is ios->clock is 52MHz and you could claim 104MHz from the
>>>      clock provider and let dw_mmc core take care of the divder to be 1.
>>>      Otherwise, you just force it to be DDR52/8-bit with a clk rate of
>>> 26MHz.
>>>
>>>
>>>                   ret = clk_set_rate(host->biu_clk, clock);
>>>                   if (ret)
>>>                           dev_warn(host->dev, "failed to set rate
>>>          %uHz\n", clock);
>>>
>>>
>>>
>>
>> For future wise, please use plain mode mail, but not HTML format.
>>
>>> Your feedback is correct. I see the Rockchip dwmmc driver has a similar
>>> implementation. After applying your suggested changes, however, my board
>>> reports "dwmmc_k3 f723d000.dwmmc0: failed to set rate 104000000Hz"
>>> during intialization of eMMC. In addition, I do not see CLKDIV being
>>> set to 1. clk_set_rate fails and I wonder if this is out-of-scope of
>>> the driver.
>>>
>>> If I set CLKDIV where I did prior, with your changes, the device fails
>>> to set the clock and falls back to 52 MHz (26 MHz) and works fine, but
>>> again, CLKDIV is reported as 0 (even though it is 1.) One thing of
>>> interest to note is when I manually set the clock by doing:
>>> (echo 104000000 > /sys/kernel/debug/mmc0/clock) the device reports back
>>> 'mmc_host mmc0: Bus speed (slot 0) = 198400000Hz (slot req 104000000Hz,
>>>    actual 99200000HZ div = 1)' which works reliably and clk_set_rate does
>>> not report any error.
>>>
>>
>> When looking closely into the code, at least dw_mci_hi6220_set_ios
>> goes wrong with the bus_hz, since it should be ciu_clk but not biu_clk.
>> "b" stands for bus, and "c" stands for card IMHO, however bus_hz
>> describs the clock to the card, provided by controller. Does the
>> following patch help?
>>
>>
>> diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
>> index 89cdb3d..9e78cf2 100644
>> --- a/drivers/mmc/host/dw_mmc-k3.c
>> +++ b/drivers/mmc/host/dw_mmc-k3.c
>> @@ -194,13 +194,21 @@ static void dw_mci_hi6220_set_ios(struct dw_mci *host,
>> struct mmc_ios *ios)
>>          int ret;
>>          unsigned int clock;
>>
>> -       clock = (ios->clock <= 25000000) ? 25000000 : ios->clock;
>> +       if (ios->bus_width == MMC_BUS_WIDTH_8 &&
>> +           ios->timing == MMC_TIMING_MMC_DDR52)
>> +               clock = ios->clock * 2;
>> +       else
>> +               clock = (ios->clock <= 25000000) ? 25000000 : ios->clock;
>>
>> -       ret = clk_set_rate(host->biu_clk, clock);
>> +       ret = clk_set_rate(host->ciu_clk, clock);
>>          if (ret)
>>                  dev_warn(host->dev, "failed to set rate %uHz\n", clock);
>>
>> -       host->bus_hz = clk_get_rate(host->biu_clk);
>> +       clock = clk_get_rate(host->ciu_clk);
>> +       if (clock != host->bus_hz) {
>> +               host->bus_hz = clock;
>> +               host->current_speed = 0;
>> +       }
>>
>>   }
>>
>>
>>> I am not sure where to begin debugging these clock issues and welcome
>>> any feedback.
>>
>>
> 
> The change results in the following:
> 'dwmmc_k3 f723e000.dwmmc1: failed to set rate 25000000Hz'
> 'dwmmc_k3 f723d000.dwmmc0: failed to set rate 25000000Hz'
> 'dwmmc_k3 f723f000.dwmmc2: failed to set rate 25000000Hz'
> 
> and later on:
> 'dwmmc_k3 f723d000.dwmmc0: failed to set rate 52000000Hz'
> 'dwmmc_k3 f723d000.dwmmc0: failed to set rate 104000000Hz'
> 
> Eventually mmc1 (UHS-1 MicroSD) will settle down after repeated
> attempts at setting 25 MHz:
> 'mmc_host mmc1: Bus speed (slot 0) = 100000000Hz (slot req
> 100000000Hz, actual 100000000HZ div = 0)'
> 'mmc1: new ultra high speed SDR50 SDHC card at address 0001'
> 'mmcblk1: mmc1:0001 GB1QT 29.8 GiB'
> 
> Same for mmc2 (SDIO WL1835MOD WiFi):
> 'mmc_host mmc2: Bus speed (slot 0) = 100000000Hz (slot req 50000000Hz,
> actual 50000000HZ div = 1)'
> 'mmc2: new high speed SDIO card at address 0001'
> 
> So mmc1 and mmc2 will initialize eventually. I had not observed this
> behavior prior. It appears to fail setting
> all devices to an initial rate of 25 MHz. However, the same cannot be
> said for mmc0 (eMMC).
> Again, I observed being able to set the clock manually through debugfs
> to 104MHz(/2) which is successful
> and the card becomes stable and will initialize properly.
> 
> 'echo 104000000 > /sys/kernel/debug/mmc0/clock'
> 'mmc_host mmc0: Bus speed (slot 0) = 200000000Hz (slot req
> 104000000Hz, actual 100000000HZ div = 1)'
> 
> So it seems to settle down at 50 MHz, but only if set manually. It
> does appear CLKDIV is being set accordingly now.

Hmm.... I can't see any differences.. And failed to set clock rate
in the first place and finally got it, which beyond the mmc driver
scope. Maybe hisilicon guys have more idea here.

> 
> 
> 
