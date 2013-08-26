From: Yuvaraj Kumar <yuvaraj.cd@gmail.com>
Subject: Re: [RFC V2 1/4] mmc: dw_mmc: exynos: move the exynos private init
Date: Mon, 26 Aug 2013 14:50:39 +0530
Message-ID: <CAKuRcOKSzXXGnN1jZhYhimnRqmKM4pc2qB2N0AgXdRX1VFLb3Q@mail.gmail.com>
References: <1377256509-18922-1-git-send-email-yuvaraj.cd@samsung.com>
	<1377256509-18922-2-git-send-email-yuvaraj.cd@samsung.com>
	<5217673C.1040305@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <5217673C.1040305@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, ks.giri@samsung.com, Tomasz Figa <t.figa@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, thomas.ab@samsung.com
List-Id: linux-mmc@vger.kernel.org

On Fri, Aug 23, 2013 at 7:14 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi Yuvaraj,
>
> On 08/23/2013 08:15 PM, Yuvaraj Kumar C D wrote:
>> Currently platform specific private data initialisation is done by
>> dw_mci_exynos_priv_init and dw_mci_exynos_parse_dt.As we already have
>> separate platform specific device tree parser dw_mci_exynos_parse_dt,
>> move the dw_mci_exynos_priv_init code to dw_mci_exynos_parse_dt.
>> We can use the dw_mci_exynos_priv_init to do some actual platform
>> specific initialisation of SMU and etc.
>>
>> changes since V1: none
>>
>> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
>> ---
>>  drivers/mmc/host/dw_mmc-exynos.c |   31 +++++++++++++++----------------
>>  1 file changed, 15 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
>> index 9990f98..19c845b 100644
>> --- a/drivers/mmc/host/dw_mmc-exynos.c
>> +++ b/drivers/mmc/host/dw_mmc-exynos.c
>> @@ -72,22 +72,8 @@ static struct dw_mci_exynos_compatible {
>>
>>  static int dw_mci_exynos_priv_init(struct dw_mci *host)
>>  {
>> -     struct dw_mci_exynos_priv_data *priv;
>> -     int idx;
>> -
>> -     priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
>> -     if (!priv) {
>> -             dev_err(host->dev, "mem alloc failed for private data\n");
>> -             return -ENOMEM;
>> -     }
>> -
>> -     for (idx = 0; idx < ARRAY_SIZE(exynos_compat); idx++) {
>> -             if (of_device_is_compatible(host->dev->of_node,
>> -                                     exynos_compat[idx].compatible))
>> -                     priv->ctrl_type = exynos_compat[idx].ctrl_type;
>> -     }
>> +     struct dw_mci_exynos_priv_data *priv = host->priv;
>>
>> -     host->priv = priv;
>>       return 0;
>>  }
>>
>> @@ -177,12 +163,24 @@ static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>>
>>  static int dw_mci_exynos_parse_dt(struct dw_mci *host)
>>  {
>> -     struct dw_mci_exynos_priv_data *priv = host->priv;
>> +     struct dw_mci_exynos_priv_data *priv;
>>       struct device_node *np = host->dev->of_node;
>>       u32 timing[2];
>>       u32 div = 0;
>> +     int idx;
>>       int ret;
>>
>> +     priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
>> +     if (!priv) {
>> +             dev_err(host->dev, "mem alloc failed for private data\n");
>> +             return -ENOMEM;
>> +     }
>> +
>> +     for (idx = 0; idx < ARRAY_SIZE(exynos_compat); idx++) {
>> +             if (of_device_is_compatible(np, exynos_compat[idx].compatible))
>> +                     priv->ctrl_type = exynos_compat[idx].ctrl_type;
>> +     }
>> +
>>       of_property_read_u32(np, "samsung,dw-mshc-ciu-div", &div);
>>       priv->ciu_div = div;
>>
>> @@ -199,6 +197,7 @@ static int dw_mci_exynos_parse_dt(struct dw_mci *host)
>>               return ret;
>>
>>       priv->ddr_timing = SDMMC_CLKSEL_TIMING(timing[0], timing[1], div);
>> +     host->priv = priv;
>
> I'm not sure whether my thinking is right or not.
> if host->pdata is present, then dw_mci_parse_dt() didn't called at dw_mci_probe.
Yes, you are right.
> then how host->priv set to priv?
Earlier host->priv set to priv in both non-DT and DT case.True, with
this patch it does it only in DT case.
Is there any platform/board which still uses dw_mmc and its platform
extension driver with non DT case?
I found a reference of non-DT case where host->pdata is present in
dw_mmc-pci.c driver but does not
use platform extension driver (exynos/socfpga).
>
> Best Regards,
> Jaehoon Chung
>
>>       return 0;
>>  }
>>
>>
>
