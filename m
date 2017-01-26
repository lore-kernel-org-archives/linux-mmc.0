From: Jeremy McNicoll <jmcnicol@redhat.com>
Subject: Re: [PATCH V3 2/6] sdhci: Add quirk for delayed IRQ ACK
Date: Thu, 26 Jan 2017 17:32:13 -0500
Message-ID: <bc53f54e-167d-cfea-4165-c95008712144@redhat.com>
References: <1485250588-24698-1-git-send-email-jeremymc@redhat.com>
 <1485250588-24698-3-git-send-email-jeremymc@redhat.com>
 <3ff707f3-4e5b-a19e-8c03-c9e9455d507a@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <3ff707f3-4e5b-a19e-8c03-c9e9455d507a@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, Jeremy McNicoll <jeremymc@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, andy.gross@linaro.org, sboyd@codeaurora.org, robh@kernel.org, arnd@arndb.de, bjorn.andersson@linaro.org, git@kchr.de, ulf.hansson@linaro.org, jszhang@marvell.com
List-Id: linux-mmc@vger.kernel.org

On 2017-01-25 5:18 AM, Ritesh Harjani wrote:
> Hi Jeremy,
>
> From what I can see in codeaurora tree, quirk
> (SDHCI_QUIRK2_SLOW_INT_CLR) is only required for sdhci-msm with minor
> number 2B. I think this patch may not be relevant for msm8992 controller.

minor number 2B ?  Is that a typo ?

Please check the code from here:

https://android.googlesource.com/kernel/msm.git/+/android-msm-bullhead-3.10-n-preview-1/drivers/mmc/host/sdhci-msm.c?autodive=0%2F%2F#3213

Ok, in the tree there is a check for both 0x3E and 0x2E.


> And as you have also mentioned in your V2, that even without this
> change, the detection is fine. The delay you are observing could be due
> to something else unless we are sure.
>

It is, I did some more testing without this patch and a hack to deal
with a _KNOWN_ rpm-smd issue on the msm899(2/4).  The detection time was
much quicker and very reliable.  Bjorn Andersson is aware of the issue
and I would like to defer to him as to what solution he would like to
pursue.

> On reading history of this quirk, I see that this patch was a SW
> workaround for some HW issue in very initial controller.
> This was fixed for later controllers.
> For this reason, in my opinion we can drop this patch.
>

Agreed as I mentioned above the root cause (reasonably confident) of the 
inconsistent / slow SDHCI detection time seems to be due to the rpm-smd 
issue mentioned above.   It seems as though this quirk was masking / 
altering things enough to provide an appearance of slightly better 
detection.  Mind you my sample set was only 1 device. It would have been 
nice to get data over a larger sample size.

> But, as we discussed on IRC, let's investigate more on your issue before
> finalizing on this patch for merging.
>

At this point I am satisfied that dropping this patch still allows
SDHCI detection to occur.  Will drop as part of V4.

-jeremy

> Regards
> Ritesh
>
> On 1/24/2017 3:06 PM, Jeremy McNicoll wrote:
>> On msm8992 it has been observed that IRQs were not getting
>> ACK'd correctly when clocked at speeds greater than 400KHz.
>>
>> Signed-off-by: Jeremy McNicoll <jeremymc@redhat.com>
>> ---
>>  drivers/mmc/host/sdhci-msm.c |  7 +++++++
>>  drivers/mmc/host/sdhci.c     | 12 ++++++++++--
>>  drivers/mmc/host/sdhci.h     |  2 ++
>>  3 files changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index f3f3fb3..11dc389 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -1304,6 +1304,13 @@ static int sdhci_msm_probe(struct
>> platform_device *pdev)
>>                     CORE_VENDOR_SPEC_CAPABILITIES0);
>>      }
>>
>> +    /* Enable delayed IRQ handling workaround on 8992 */
>> +    if (core_major == 1 && core_minor == 0x3e) {
>> +        /* Add 40us delay in interrupt handler when operating
>> +         * at initialization frequency of 400KHz. */
>> +        host->quirks2 |= SDHCI_QUIRK2_SLOW_INT_CLR;
>> +    }
>> +
>>      /* Setup IRQ for handling power/voltage tasks with PMIC */
>>      msm_host->pwr_irq = platform_get_irq_byname(pdev, "pwr_irq");
>>      if (msm_host->pwr_irq < 0) {
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 06dfac2..68a21a3 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2742,11 +2742,19 @@ static irqreturn_t sdhci_irq(int irq, void
>> *dev_id)
>>              result = IRQ_WAKE_THREAD;
>>          }
>>
>> -        if (intmask & SDHCI_INT_CMD_MASK)
>> +        if (intmask & SDHCI_INT_CMD_MASK) {
>> +            if ((host->quirks2 & SDHCI_QUIRK2_SLOW_INT_CLR) &&
>> (host->clock <= 400000)) {
>> +                udelay(40);
>> +            }
>>              sdhci_cmd_irq(host, intmask & SDHCI_INT_CMD_MASK);
>> +        }
>>
>> -        if (intmask & SDHCI_INT_DATA_MASK)
>> +        if (intmask & SDHCI_INT_DATA_MASK) {
>> +            if ((host->quirks2 & SDHCI_QUIRK2_SLOW_INT_CLR) &&
>> (host->clock <= 400000)) {
>> +                udelay(40);
>> +            }
>>              sdhci_data_irq(host, intmask & SDHCI_INT_DATA_MASK);
>> +        }
>>
>>          if (intmask & SDHCI_INT_BUS_POWER)
>>              pr_err("%s: Card is consuming too much power!\n",
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 400f3a1..7fa1004 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -24,6 +24,8 @@
>>   * Controller registers
>>   */
>>
>> +#define SDHCI_QUIRK2_SLOW_INT_CLR    (1<<5)
>> +
>>  #define SDHCI_DMA_ADDRESS    0x00
>>  #define SDHCI_ARGUMENT2        SDHCI_DMA_ADDRESS
>>
>>
>
