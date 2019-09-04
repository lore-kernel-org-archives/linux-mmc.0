From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V7 5/5] mmc: host: sdhci-pci: Add Genesys Logic GL975x
 support
Date: Wed, 4 Sep 2019 12:53:12 +0300
Message-ID: <f2180ae3-2393-2802-e8f0-6d382aea639f@intel.com>
References: <20190830022542.8571-1-benchuanggli@gmail.com>
 <CAHp75Vfx4FukybSjQjiNNQpHUNQrUsvwOen4ibqxOONKTJNxww@mail.gmail.com>
 <CACT4zj_+7r=0pO-c4H_QzEJzY=pSJn5pQkAK-5bM+vR6u8qS3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACT4zj_+7r=0pO-c4H_QzEJzY=pSJn5pQkAK-5bM+vR6u8qS3Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Chuang <benchuanggli@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Michael K. Johnson" <johnsonm@danlj.org>, Ben Chuang <ben.chuang@genesyslogic.com.tw>
List-Id: linux-mmc@vger.kernel.org

On 4/09/19 3:58 AM, Ben Chuang wrote:
> On Tue, Sep 3, 2019 at 6:05 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>>
>> On Fri, Aug 30, 2019 at 5:28 AM Ben Chuang <benchuanggli@gmail.com> wrote:
>>>
>>> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>>>
>>> Add support for the GL9750 and GL9755 chipsets.
>>>
>>> Enable v4 mode and wait 5ms after set 1.8V signal enable for GL9750/
>>> GL9755. Fix the value of SDHCI_MAX_CURRENT register and use the vendor
>>> tuning flow for GL9750.
>>>
>>
>>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>>
>> Usually last one for latest developer / submitter goes on.
>>
>>> Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
>>> Signed-off-by: Michael K Johnson <johnsonm@danlj.org>
>>
>>
>>> +#define GLI_MAX_TUNING_LOOP 40
>>
>>
>>> +static void gli_set_9750(struct sdhci_host *host)
>>> +{
>>> +       u32 driving_value = 0;
>>> +       u32 pll_value = 0;
>>> +       u32 sw_ctrl_value = 0;
>>> +       u32 misc_value = 0;
>>> +       u32 parameter_value = 0;
>>> +       u32 control_value = 0;
>>
>>> +
>>
>> Redundant blank line.
>>
>>> +       u16 ctrl2 = 0;
>>
>> Do you need these all assignments above?
>>
>>> +       driving_value = sdhci_readl(host, SDHCI_GLI_9750_DRIVING);
>>> +       pll_value = sdhci_readl(host, SDHCI_GLI_9750_PLL);
>>> +       sw_ctrl_value = sdhci_readl(host, SDHCI_GLI_9750_SW_CTRL);
>>> +       misc_value = sdhci_readl(host, SDHCI_GLI_9750_MISC);
>>> +       parameter_value = sdhci_readl(host, SDHCI_GLI_9750_TUNING_PARAMETERS);
>>> +       control_value = sdhci_readl(host, SDHCI_GLI_9750_TUNING_CONTROL);
>>
>>
>>
>>> +
>>> +       udelay(1);
>>
>> This misses the answer to question why. Why this is needed and why
>> timeout is this long?
>>
>>> +
>>> +       gl9750_wt_off(host);
>>> +}
>>
>>> +static int __sdhci_execute_tuning_9750(struct sdhci_host *host, u32 opcode)
>>> +{
>>> +       int i;
>>
>>> +       int rx_inv = 0;
>>
>> Duplicate assignment.
>>
>>> +
>>> +       for (rx_inv = 0; rx_inv < 2; rx_inv++) {
>>
>>> +               if (rx_inv & 0x1)
>>> +                       gli_set_9750_rx_inv(host, true);
>>> +               else
>>> +                       gli_set_9750_rx_inv(host, false);
>>
>> gli_set_...(host, !!rx_inv);
>>
>>> +
>>> +               sdhci_start_tuning(host);
>>> +
>>> +               for (i = 0; i < GLI_MAX_TUNING_LOOP; i++) {
>>> +                       u16 ctrl;
>>> +
>>> +                       sdhci_send_tuning(host, opcode);
>>> +
>>> +                       if (!host->tuning_done) {
>>
>>> +                               if (rx_inv == 1) {
>>
>> It's an invariant to the loop. So, you may do this check after outter loop.
>>
>>> +                                       pr_info("%s: Tuning timeout, falling back to fixed sampling clock\n",
>>> +                                               mmc_hostname(host->mmc));
>>
>>> +                                       sdhci_abort_tuning(host, opcode);
>>
>> It will also de-duplicates this call.
>>
>>> +                                       return -ETIMEDOUT;
>>> +                               }
>>> +                               sdhci_abort_tuning(host, opcode);
>>> +                               break;
>>> +                       }
>>
>>> +               }
>>> +       }
>>> +
>>> +       pr_info("%s: Tuning failed, falling back to fixed sampling clock\n",
>>> +               mmc_hostname(host->mmc));
>>> +       sdhci_reset_tuning(host);
>>> +       return -EAGAIN;
>>> +}
>>
>>> +static void sdhci_gli_voltage_switch(struct sdhci_host *host)
>>> +{
>>
>> Any comment why?
>>
>>> +       usleep_range(5000, 5500);
>>> +}
>>
>>> +static u32 sdhci_gl9750_readl(struct sdhci_host *host, int reg)
>>> +{
>>> +       u32 value;
>>> +
>>> +       value = readl(host->ioaddr + reg);
>>
>>> +       if (unlikely(reg == SDHCI_MAX_CURRENT)) {
>>> +               if (!(value & 0xff))
>>> +                       value |= 0xc8;
>>> +       }
>>
>> if (a) {
>>  if (b) {
>>    ...
>>  }
>> }
>>
>> is the same as
>>
>> if (a && b) {
>>  ...
>> }
>>
>>> +       return value;
>>> +}
>>
>>> +#define PCI_DEVICE_ID_GLI_9755         0x9755
>>> +#define PCI_DEVICE_ID_GLI_9750         0x9750
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
> 
> Hi, Andy,
> 
> Thank you for your comments to make the code better.
> Waiting to see if Adrian has any other comments.

Nope! :-)

Please go ahead and address Andy's comments.
