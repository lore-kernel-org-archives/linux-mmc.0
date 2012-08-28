From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH v4 4/9] mmc: dw_mmc: lookup for optional biu and ciu clocks
Date: Tue, 28 Aug 2012 16:53:23 +0530
Message-ID: <CAJuYYwQe1R7=Tj_pg8u2Wc9XwjeZP9jYbTDtUk7vVTomQTW_qg@mail.gmail.com>
References: <1345981927-26359-1-git-send-email-thomas.abraham@linaro.org>
	<1345981927-26359-5-git-send-email-thomas.abraham@linaro.org>
	<002501cd8509$e97dad60$bc790820$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <002501cd8509$e97dad60$bc790820$%jun@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, jh80.chung@samsung.com, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

On 28 August 2012 16:13, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> On Sunday, August 26, 2012 Thomas Abraham <thomas.abraham@linaro.org> wrote:
>> Some platforms allow for clock gating and control of bus interface unit clock
>> and card interface unit clock. Add support for clock lookup of optional biu
>> and ciu clocks for clock gating and clock speed determination.
>>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>>  drivers/mmc/host/dw_mmc.c  |   42 +++++++++++++++++++++++++++++++++++++++---
>>  include/linux/mmc/dw_mmc.h |    4 ++++
>>  2 files changed, 43 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index cd58063..679473c 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1953,18 +1953,38 @@ int dw_mci_probe(struct dw_mci *host)
>>               return -ENODEV;
>>       }
>>
>> -     if (!host->pdata->bus_hz) {
>> +     host->biu_clk = clk_get(host->dev, "biu");
>> +     if (IS_ERR(host->biu_clk))
>> +             dev_dbg(host->dev, "biu clock not available\n");
>> +     else
>> +             clk_prepare_enable(host->biu_clk);
>> +
>> +     host->ciu_clk = clk_get(host->dev, "ciu");
>> +     if (IS_ERR(host->ciu_clk))
>> +             dev_dbg(host->dev, "ciu clock not available\n");
>> +     else
>> +             clk_prepare_enable(host->ciu_clk);
>> +
>> +     if (IS_ERR(host->ciu_clk))
>> +             host->bus_hz = host->pdata->bus_hz;
>> +     else
>> +             host->bus_hz = clk_get_rate(host->ciu_clk);
> I have remained comment in [PATCH 3/9] mmc: dw_mmc: lookup for optional biu and ciu clocks
> Could I get your opinion?

Are you referring to the following comment.

> I have posted similar patch some time back.
> bus_hz represents input rate for cclk_in of mshc.
> Host of samsung soc doesn't use input clock from system directly.
> As you have introduced CLKSEL in your another patch, input clock can be
> changed prior to cclk_in.
> For non-samsung  host, we don't need to consider this with generic way?

The biu and ciu clocks are generic clocks which a platform can
instantiate. The other option being to use the platform data to
specify the clock speed using pdata->bus_hz.

The use CLKSEL register is now moved into exynos specific code. So
non-samsung host is not affected in any way.

Thanks,
Thomas.
