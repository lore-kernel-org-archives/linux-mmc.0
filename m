From: Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: [PATCH V2 23/27] mmc: mmci: add variant property to request a
 reset
Date: Mon, 1 Oct 2018 14:16:00 +0200
Message-ID: <a956549b-a84e-2582-1fce-3b15495f208c@st.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
 <1537523181-14578-24-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFqxBuQcafS2KFqPDwb4=V1Jwoovb4+VsJZjAA5CeKs2kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqxBuQcafS2KFqPDwb4=V1Jwoovb4+VsJZjAA5CeKs2kw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Gerald Baeza <gerald.baeza@st.com>, Loic Pallardy <loic.pallardy@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

hi Ulf

On 10/01/2018 11:30 AM, Ulf Hansson wrote:
> On 21 September 2018 at 11:46, Ludovic Barre <ludovic.Barre@st.com> wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> Some variants could require a reset.
>> STM32 sdmmc variant needs to reset hardware block
>> during the power cycle procedure (for re-initialization)
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   Documentation/devicetree/bindings/mmc/mmci.txt | 2 ++
>>   drivers/mmc/host/mmci.c                        | 9 +++++++++
>>   drivers/mmc/host/mmci.h                        | 4 ++++
>>   3 files changed, 15 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
>> index 03796cf..e952707 100644
>> --- a/Documentation/devicetree/bindings/mmc/mmci.txt
>> +++ b/Documentation/devicetree/bindings/mmc/mmci.txt
>> @@ -11,6 +11,8 @@ Required properties:
>>   - compatible             : contains "arm,pl18x", "arm,primecell".
>>   - vmmc-supply            : phandle to the regulator device tree node, mentioned
>>                              as the VCC/VDD supply in the eMMC/SD specs.
>> +depend of variant:
>> +- resets                 : phandle to internal reset line.
>>
> 
> This looks like a thing depending on the SoC, rather than on the
> variant. Therefore, I suggest you move this to be an optional DT
> property.

could be replaced by:

Optional properties:
- resets                 : phandle to internal reset line.
			   Should be defined for sdmmc variant.

> 
> Also, please move the DT doc update into a separate patch.

OK

> 
>>   Optional properties:
>>   - arm,primecell-periphid : contains the PrimeCell Peripheral ID, it overrides
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index b1d5bc5..6b3c33f 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -37,6 +37,7 @@
>>   #include <linux/pm_runtime.h>
>>   #include <linux/types.h>
>>   #include <linux/pinctrl/consumer.h>
>> +#include <linux/reset.h>
>>
>>   #include <asm/div64.h>
>>   #include <asm/io.h>
>> @@ -1854,6 +1855,14 @@ static int mmci_probe(struct amba_device *dev,
>>
>>          dev_dbg(mmc_dev(mmc), "clocking block at %u Hz\n", mmc->f_max);
>>
>> +       if (variant->reset) {
>> +               host->rst = devm_reset_control_get_exclusive(&dev->dev, NULL);
> 
> As suggested, let's make this optional and not depending on the variant.

I done like that because is required for my variant (if no reset, no 
power cycle for sdmmc).

If you prefer, I could move to optional with 
"devm_reset_control_get_optional_exclusive"
And I add a comment in mmci dt binding to specify that not optional
for sdmmc. (see above)

> 
>> +               if (IS_ERR(host->rst)) {
>> +                       ret = PTR_ERR(host->rst);
>> +                       goto clk_disable;
>> +               }
>> +       }
>> +
>>          /* Get regulators and the supported OCR mask */
>>          ret = mmc_regulator_get_supply(mmc);
>>          if (ret)
>> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
>> index e130689..f0fa185 100644
>> --- a/drivers/mmc/host/mmci.h
>> +++ b/drivers/mmc/host/mmci.h
>> @@ -247,6 +247,7 @@ struct mmci_host;
>>    * @start_err: bitmask identifying the STARTBITERR bit inside MMCISTATUS
>>    *            register.
>>    * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER register
>> + * @reset: true if variant has need reset signal.
>>    */
>>   struct variant_data {
>>          unsigned int            clkreg;
>> @@ -285,6 +286,7 @@ struct variant_data {
>>          bool                    qcom_dml;
>>          bool                    reversed_irq_handling;
>>          bool                    mmcimask1;
>> +       bool                    reset;
>>          unsigned int            irq_pio_mask;
>>          u32                     start_err;
>>          u32                     opendrain;
>> @@ -318,6 +320,8 @@ struct mmci_host {
>>          struct clk              *clk;
>>          bool                    singleirq;
>>
>> +       struct reset_control    *rst;
>> +
>>          spinlock_t              lock;
>>
>>          unsigned int            mclk;
>> --
>> 2.7.4
>>
> 
> Kind regards
> Uffe
> 
