From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH v5 4/9] mmc: dw_mmc: lookup for optional biu and ciu clocks
Date: Fri, 7 Sep 2012 11:56:34 +0530
Message-ID: <CAJuYYwQhzgntE6dY_pKcEzBVshAwcxi9AMjG9YN0ebqEh8dSeQ@mail.gmail.com>
References: <CAJuYYwQ50HCSrDgxrvhRh5X2ECxi_g=_akoa6o9FYCQ5GqHUCQ@mail.gmail.com>
	<1346787968-23709-1-git-send-email-thomas.abraham@linaro.org>
	<50470DAE.4020300@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <50470DAE.4020300@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, will.newton@imgtec.com, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, tgih.jun@samsung.com, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hi Jaehoon,

Thanks for reviewing the patch.

On 5 September 2012 14:00, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> On 09/05/2012 04:46 AM, Thomas Abraham wrote:
>> Some platforms allow for clock gating and control of bus interface unit clock
>> and card interface unit clock. Add support for clock lookup of optional biu
>> and ciu clocks for clock gating and clock speed determination.
>>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> Acked-by: Will Newton <will.newton@imgtec.com>
>> ---
>>  drivers/mmc/host/dw_mmc.c  |   50 +++++++++++++++++++++++++++++++++++++++++--
>>  include/linux/mmc/dw_mmc.h |    4 +++
>>  2 files changed, 51 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 227c42e..e8c8491 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1960,13 +1960,40 @@ int dw_mci_probe(struct dw_mci *host)
>>               return -ENODEV;
>>       }
>>
>> -     if (!host->pdata->bus_hz) {
>> +     host->biu_clk = clk_get(host->dev, "biu");
>> +     if (IS_ERR(host->biu_clk)) {
>> +             dev_dbg(host->dev, "biu clock not available\n");
>> +     } else {
>> +             ret = clk_prepare_enable(host->biu_clk);
>> +             if (ret) {
>> +                     dev_err(host->dev, "failed to enable biu clock\n");
>> +                     return ret;
> didn't clk_put() for biu_clk?

Yes, I missed that. Thanks for pointing this out. I will fix this.

>> +             }
>> +     }
>> +
>> +     host->ciu_clk = clk_get(host->dev, "ciu");
>> +     if (IS_ERR(host->ciu_clk)) {
>> +             dev_dbg(host->dev, "ciu clock not available\n");
>> +     } else {
>> +             ret = clk_prepare_enable(host->ciu_clk);
>> +             if (ret) {
>> +                     dev_err(host->dev, "failed to enable ciu clock\n");
>> +                     goto err_clk_biu;
>> +             }
>> +     }
>> +
>> +     if (IS_ERR(host->ciu_clk))
>> +             host->bus_hz = host->pdata->bus_hz;
>> +     else
>> +             host->bus_hz = clk_get_rate(host->ciu_clk);
>> +
>> +     if (!host->bus_hz) {
>>               dev_err(host->dev,
>>                       "Platform data must supply bus speed\n");
>> -             return -ENODEV;
>> +             ret = -ENODEV;
>> +             goto err_clk_ciu;
>>       }
>>
>> -     host->bus_hz = host->pdata->bus_hz;
>>       host->quirks = host->pdata->quirks;
>>
>>       spin_lock_init(&host->lock);
>> @@ -2116,6 +2143,17 @@ err_dmaunmap:
>>               regulator_disable(host->vmmc);
>>               regulator_put(host->vmmc);
>>       }
>> +
>> +err_clk_ciu:
>> +     if (!IS_ERR(host->ciu_clk)) {
>> +             clk_disable_unprepare(host->ciu_clk);
>> +             clk_put(host->ciu_clk);
>> +     }
>> +err_clk_biu:
> I think right that is located the clk_put(host->ciu_clk) at here

In the next version of this patch, if clk_prepare_enable() fails for
host->ciu_clk, the put(host->ciu_clk) is also done before returning.

Thanks,
Thomas.

>> +     if (!IS_ERR(host->biu_clk)) {
>> +             clk_disable_unprepare(host->biu_clk);
>> +             clk_put(host->biu_clk);
>> +     }
>>       return ret;
>>  }
>>  EXPORT_SYMBOL(dw_mci_probe);
>> @@ -2149,6 +2187,12 @@ void dw_mci_remove(struct dw_mci *host)
>>               regulator_put(host->vmmc);
>>       }
>>
>> +     if (!IS_ERR(host->ciu_clk))
>> +             clk_disable_unprepare(host->ciu_clk);
>> +     if (!IS_ERR(host->biu_clk))
>> +             clk_disable_unprepare(host->biu_clk);
>> +     clk_put(host->ciu_clk);
>> +     clk_put(host->biu_clk);
>>  }
>>  EXPORT_SYMBOL(dw_mci_remove);
>>
>> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
>> index a37a573..787ad56 100644
>> --- a/include/linux/mmc/dw_mmc.h
>> +++ b/include/linux/mmc/dw_mmc.h
>> @@ -78,6 +78,8 @@ struct mmc_data;
>>   * @data_offset: Set the offset of DATA register according to VERID.
>>   * @dev: Device associated with the MMC controller.
>>   * @pdata: Platform data associated with the MMC controller.
>> + * @biu_clk: Pointer to bus interface unit clock instance.
>> + * @ciu_clk: Pointer to card interface unit clock instance.
>>   * @slot: Slots sharing this MMC controller.
>>   * @fifo_depth: depth of FIFO.
>>   * @data_shift: log2 of FIFO item size.
>> @@ -158,6 +160,8 @@ struct dw_mci {
>>       u16                     data_offset;
>>       struct device           *dev;
>>       struct dw_mci_board     *pdata;
>> +     struct clk              *biu_clk;
>> +     struct clk              *ciu_clk;
>>       struct dw_mci_slot      *slot[MAX_MCI_SLOTS];
>>
>>       /* FIFO push and pull */
>>
>
