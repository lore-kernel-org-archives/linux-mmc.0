From: addy ke <addy.ke@rock-chips.com>
Subject: Re: [PATCH v4 1/3] mmc: dw_mmc: update clock after host reach a stable
 voltage
Date: Thu, 19 Feb 2015 18:30:35 +0800
Message-ID: <54E5BB4B.8090405@rock-chips.com>
References: <1423828368-18456-1-git-send-email-addy.ke@rock-chips.com> <1423894668-8886-1-git-send-email-addy.ke@rock-chips.com> <1423894668-8886-2-git-send-email-addy.ke@rock-chips.com> <CAGOxZ53ndi_hYDGBGhY-7q8aOrFid1=D=_5KEbUvzTsnybJQ3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGOxZ53ndi_hYDGBGhY-7q8aOrFid1=D=_5KEbUvzTsnybJQ3Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alim.akhtar@gmail.com
Cc: jh80.chung@samsung.com, ulf.hansson@linaro.org, olof@lixom.net, a.hajda@samsung.com, dianders@chromium.org, heiko@sntech.de, cf@rock-chips.com, lintao@rock-chips.com, huangtao@rock-chips.com, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi, Alim

Sorry for late reply.

On 2015/2/16 07:28, Alim Akhtar wrote:
> Hi Addy,
> 
> On Sat, Feb 14, 2015 at 11:47 AM, Addy Ke <addy.ke@rock-chips.com> wrote:
>> As show in mmc_power_up(), in MMC_POWER_UP state, the voltage isn't
>> stable and we may get 'data busy' which can't be cleaned by resetting
>> all blocks. So we should not send command to update clock in this state.
>>
>> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
>> ---
>>  drivers/mmc/host/dw_mmc.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 4d2e3c2..3472f9b 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1102,7 +1102,8 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>                 drv_data->set_ios(slot->host, ios);
>>
>>         /* Slot specific timing and width adjustment */
>> -       dw_mci_setup_bus(slot, false);
>> +       if (ios->power_mode != MMC_POWER_UP)
>> +               dw_mci_setup_bus(slot, false);
>>
> This looks a HACK to me.
> If stabilizing host voltage regulator is the problem, can you try out
> below patch, and see if this resolve your issue?

I have test by:
cd /sys/bus/platform/drivers/dwmmc_rockchip
for i in $(seq 1 10000); do
  echo "========================" $i
  echo ff0c0000.dwmmc > unbind
  sleep .5
  echo ff0c0000.dwmmc > bind
  sleep 2
done

There is no error.
I think this patch can resolve my issue, thank you.

Do you send this patch upstream, or can I put it in my patch list?

> 
> ===========
> [PATCH] mmc: dw_mmc: Wait for host voltage regulator to be stable
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 4d2e3c2..dc10fbb 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1202,6 +1202,9 @@ static int dw_mci_switch_voltage(struct mmc_host
> *mmc, struct mmc_ios *ios)
>   }
>   mci_writel(host, UHS_REG, uhs);
> 
> + /* wait for 5ms so that host voltage regulator is stable */
> + usleep_range(5000, 5500);
> +
>   return 0;
>  }
> 
> ===============
> 
>>         if (slot->host->state == STATE_WAITING_CMD11_DONE && ios->clock != 0)
>>                 slot->host->state = STATE_IDLE;
>> --
>> 1.8.3.2
>>
>>
> 
> 
> 
