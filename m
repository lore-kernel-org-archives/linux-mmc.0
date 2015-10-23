From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RESEND PATCH v4 3/3] mmc: sdhci-of-arasan: add runtime pm
 support
Date: Fri, 23 Oct 2015 11:44:18 +0800
Message-ID: <5629AD12.2020709@rock-chips.com>
References: <1445504810-5642-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFqzA31PVdqw0mLi=ZOezcXH1hECHgzpMDzt_th4zdY_dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqzA31PVdqw0mLi=ZOezcXH1hECHgzpMDzt_th4zdY_dw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, Michal Simek <michal.simek@xilinx.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 2015/10/22 20:08, Ulf Hansson wrote:
> On 22 October 2015 at 11:06, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>> This patch add runtime_suspend and runtime_resume for
>> sdhci-of-arasan. Currently we also power-off phy at
>> runtime_suspend for power-saving.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> Serise-changes: 4
>> - remove ifdef for PM callback statement
>> - fix missing pm_runtime_set_active
>> - remove pm_runtime_dont_use_autosuspend from remove hook
>> - add pm_runtime_force_suspend|resume for PM callback to
>>    deal with suspend invoked from rpm
>> - remove wrappers of phy ops
>>
>> ---
>>
>> Changes in v2: None
>>
>>   drivers/mmc/host/sdhci-of-arasan.c | 85 ++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 82 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
>> index 4f30716..fb1915c 100644
>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>> @@ -30,6 +30,8 @@
>>   #define CLK_CTRL_TIMEOUT_MASK          (0xf << CLK_CTRL_TIMEOUT_SHIFT)
>>   #define CLK_CTRL_TIMEOUT_MIN_EXP       13
>>
>> +#define ARASAN_RPM_DELAY_MS            50
>> +
>>   /**
>>    * struct sdhci_arasan_data
>>    * @clk_ahb:   Pointer to the AHB clock
>> @@ -71,6 +73,46 @@ static struct sdhci_pltfm_data sdhci_arasan_pdata = {
>>                          SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>>   };
>>
>> +#ifdef CONFIG_PM
>> +static int sdhci_arasan_runtime_suspend(struct device *dev)
>> +{
>> +       struct sdhci_host *host = dev_get_drvdata(dev);
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_arasan_data *sdhci_arasan = pltfm_host->priv;
>> +       int ret;
>> +
>> +       ret = sdhci_runtime_suspend_host(host);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (!IS_ERR(sdhci_arasan->phy))
>> +               phy_power_off(sdhci_arasan->phy);
>> +
>> +       clk_disable(sdhci_arasan->clk_ahb);
>> +       clk_disable(pltfm_host->clk);
>
> The above calls can be changed to clk_disable_unprepare(). Vice verse
> in sdhci_arasan_runtime_resume() below.
>
>> +
>> +       return 0;
>> +}
>> +
>> +static int sdhci_arasan_runtime_resume(struct device *dev)
>> +{
>> +       struct sdhci_host *host = dev_get_drvdata(dev);
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_arasan_data *sdhci_arasan = pltfm_host->priv;
>> +
>> +       clk_enable(pltfm_host->clk);
>> +       clk_enable(sdhci_arasan->clk_ahb);
>> +
>> +       if (!IS_ERR(sdhci_arasan->phy))
>> +               phy_power_on(sdhci_arasan->phy);
>> +
>> +       return sdhci_runtime_resume_host(host);
>> +}
>> +#else
>> +#define sdhci_arasan_runtime_suspend NULL
>> +#define sdhci_arasan_runtime_resume NULL
>> +#endif
>> +
>>   #ifdef CONFIG_PM_SLEEP
>>   /**
>>    * sdhci_arasan_suspend - Suspend method for the driver
>> @@ -87,6 +129,12 @@ static int sdhci_arasan_suspend(struct device *dev)
>>          struct sdhci_arasan_data *sdhci_arasan = pltfm_host->priv;
>>          int ret;
>>
>> +       ret = pm_runtime_force_suspend(dev);
>> +       if (ret) {
>> +               dev_err(dev, "problem force suspending\n");
>> +               return ret;
>> +       }
>> +
>
> I think your are in right track, but unfortunate you still have some
> work to do. :-)
>
> You can't call sdhci_suspend_host() with a runtime suspended host. You
> will for example access sdhci internal registers, even-though the
> clock to the SDHCI controller is gated, which is not a good idea.
>
> Now, this leads me to the following questions/ideas, which I am really
> glad we can bring up within this context.
>
> So, sdhci_suspend_host() and sdhci_runtime_suspend_host() performs
> very similar actions, but not completely the same.
>
> I have a feeling that we might be able to merge the above functions
> into one function. The only thing that may differ between system PM
> and runtime PM, is probably the wakeup settings and since that is
> possible to control before the sdhci variant host driver decide to
> call these functions, merging them might work.
>
>>From a wakeup point of view, does your case have different settings
> between system PM and runtime PM?
>
> What do you think?

My case doesn't have diff settings between system PM and runtime PM.
If my understanding is proper, I guess you want to remove 
sdhci_suspend|resume_host and assign  pm_runtime_force_suspend|resume to 
SET_SYSTEM_SLEEP_PM_OPS directly by sdhci variant HCs?

If that is the case, I guess we should look more precisely into other
sdhci variant HCs to check whether they need to do diff things for 
system PM and RPM or not.


>
>>          ret = sdhci_suspend_host(host);
>>          if (ret)
>>                  return ret;
>> @@ -140,18 +188,39 @@ static int sdhci_arasan_resume(struct device *dev)
>>                  }
>>          }
>>
>> -       return sdhci_resume_host(host);
>> +       ret = sdhci_resume_host(host);
>> +       if (ret)
>> +               goto err_resume_host;
>> +
>> +       ret = pm_runtime_force_resume(dev);
>> +       if (ret) {
>> +               dev_err(dev, "problem force resuming\n");
>> +               goto err_force_resume;
>> +       }
>> +
>> +       return 0;
>>
>> +err_force_resume:
>> +       sdhci_suspend_host(host);
>> +err_resume_host:
>> +       if (!IS_ERR(sdhci_arasan->phy))
>> +               phy_power_off(sdhci_arasan->phy);
>>   err_phy_power:
>>          clk_disable(pltfm_host->clk);
>>   err_clk_en:
>>          clk_disable(sdhci_arasan->clk_ahb);
>>          return ret;
>>   }
>> +#else
>> +#define sdhci_arasan_suspend NULL
>> +#define sdhci_arasan_resume NULL
>>   #endif /* ! CONFIG_PM_SLEEP */
>>
>> -static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspend,
>> -                        sdhci_arasan_resume);
>> +static const struct dev_pm_ops sdhci_arasan_dev_pm_ops = {
>> +       SET_SYSTEM_SLEEP_PM_OPS(sdhci_arasan_suspend, sdhci_arasan_resume)
>> +       SET_RUNTIME_PM_OPS(sdhci_arasan_runtime_suspend,
>> +                               sdhci_arasan_runtime_resume, NULL)
>> +};
>>
>>   static int sdhci_arasan_probe(struct platform_device *pdev)
>>   {
>> @@ -237,6 +306,12 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>>                  }
>>          }
>>
>> +       pm_runtime_set_active(&pdev->dev);
>> +       pm_runtime_set_autosuspend_delay(&pdev->dev, ARASAN_RPM_DELAY_MS);
>> +       pm_runtime_use_autosuspend(&pdev->dev);
>> +       pm_runtime_enable(&pdev->dev);
>> +       pm_suspend_ignore_children(&pdev->dev, 1);
>> +
>>          ret = sdhci_add_host(host);
>>          if (ret)
>>                  goto err_pltfm_free;
>> @@ -244,6 +319,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>>          return 0;
>>
>>   err_pltfm_free:
>> +       pm_runtime_disable(&pdev->dev);
>>          sdhci_pltfm_free(pdev);
>>   err_phy_power:
>>          if (!IS_ERR(sdhci_arasan->phy))
>> @@ -265,6 +341,9 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
>>          if (!IS_ERR(sdhci_arasan->phy))
>>                  phy_exit(sdhci_arasan->phy);
>>
>> +       pm_runtime_get_sync(&pdev->dev);
>> +       pm_runtime_disable(&pdev->dev);
>> +
>
> I think a pm_runtime_put_noidle() would be good as well, since it
> restores the usage counter.
>
>>          clk_disable_unprepare(sdhci_arasan->clk_ahb);
>>
>>          return sdhci_pltfm_unregister(pdev);
>> --
>> 2.3.7
>>
>>
>
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>


-- 
Best Regards
Shawn Lin
