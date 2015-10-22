From: Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH v3 1/5] mmc: sdhci-pxav3: enable proper resuming on Armada
 38x SoC
Date: Thu, 22 Oct 2015 15:38:02 +0200
Message-ID: <CAPv3WKcKe_UKX0-yPF=Mxi_FPvkXziRGKVCy+g4EbUq7V37xPw@mail.gmail.com>
References: <1444926346-29763-1-git-send-email-mw@semihalf.com>
	<1444926346-29763-2-git-send-email-mw@semihalf.com>
	<CAPDyKFqoNh+yThhMQHbJV4izcH=ZviQsoaY7YXfS3dCxdF8myQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqoNh+yThhMQHbJV4izcH=ZviQsoaY7YXfS3dCxdF8myQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Grzegorz Jaszczyk <jaz@semihalf.com>, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf

2015-10-22 15:29 GMT+02:00 Ulf Hansson <ulf.hansson@linaro.org>:
> On 15 October 2015 at 18:25, Marcin Wojtas <mw@semihalf.com> wrote:
>> When resuming from suspend on Armada 38x SoC MBus windows have to be
>> re-configured and for that purpose mv_conf_mbus_windows function needed
>> rework. MBus windows register base address obtaining was moved to
>> armada_38x_quirks function in order to be kept in pxa global structure,
>> because it is used during a resume.
>>
>> This commit fixes resuming from suspend by calling MBus windows
>> configuration routine and therefore enabling proper DMA operation.
>>
>> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
>> ---
>>  drivers/mmc/host/sdhci-pxav3.c | 35 ++++++++++++++++-------------------
>>  1 file changed, 16 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
>> index f5edf9d..54a253c0 100644
>> --- a/drivers/mmc/host/sdhci-pxav3.c
>> +++ b/drivers/mmc/host/sdhci-pxav3.c
>> @@ -63,6 +63,7 @@ struct sdhci_pxa {
>>         struct clk *clk_io;
>>         u8      power_mode;
>>         void __iomem *sdio3_conf_reg;
>> +       void __iomem *mbus_win_regs;
>>  };
>>
>>  /*
>> @@ -81,30 +82,16 @@ struct sdhci_pxa {
>>  #define SDIO3_CONF_CLK_INV     BIT(0)
>>  #define SDIO3_CONF_SD_FB_CLK   BIT(2)
>>
>> -static int mv_conf_mbus_windows(struct platform_device *pdev,
>> +static int mv_conf_mbus_windows(struct device *dev, void __iomem *regs,
>>                                 const struct mbus_dram_target_info *dram)
>>  {
>>         int i;
>> -       void __iomem *regs;
>> -       struct resource *res;
>>
>>         if (!dram) {
>> -               dev_err(&pdev->dev, "no mbus dram info\n");
>> -               return -EINVAL;
>> -       }
>> -
>> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> -       if (!res) {
>> -               dev_err(&pdev->dev, "cannot get mbus registers\n");
>> +               dev_err(dev, "no mbus dram info\n");
>>                 return -EINVAL;
>>         }
>>
>> -       regs = ioremap(res->start, resource_size(res));
>> -       if (!regs) {
>> -               dev_err(&pdev->dev, "cannot map mbus registers\n");
>> -               return -ENOMEM;
>> -       }
>> -
>>         for (i = 0; i < SDHCI_MAX_WIN_NUM; i++) {
>>                 writel(0, regs + SDHCI_WINDOW_CTRL(i));
>>                 writel(0, regs + SDHCI_WINDOW_BASE(i));
>> @@ -122,8 +109,6 @@ static int mv_conf_mbus_windows(struct platform_device *pdev,
>>                 writel(cs->base, regs + SDHCI_WINDOW_BASE(i));
>>         }
>>
>> -       iounmap(regs);
>> -
>>         return 0;
>>  }
>>
>> @@ -135,6 +120,11 @@ static int armada_38x_quirks(struct platform_device *pdev,
>>         struct sdhci_pxa *pxa = pltfm_host->priv;
>>         struct resource *res;
>>
>> +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mbus");
>
> You change from using platform_get_resource(pdev, IORESOURCE_MEM, 1)
> to above name based lookup.
>
> I guess it's intentional, but there's no information about it in the
> change-log, perhaps add it?
>

Sure, good point.

Best regards,
Marcin
