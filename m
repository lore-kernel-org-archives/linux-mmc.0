From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH v4 12/15] sdhci pxa add platform specific code for UHS
 signaling
Date: Wed, 11 May 2011 18:53:19 -0700
Message-ID: <6FADF026-7C19-464C-A249-69FEAA93B3B3@marvell.com>
References: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
 <1304578151-1775-13-git-send-email-arindam.nath@amd.com>
 <BANLkTikdwJ3KOhxtJu9Msq6G-SmutGaSHg@mail.gmail.com>
 <1D15C758-EA6C-446C-9A49-2F7279806697@marvell.com>
 <BANLkTikRynkL0vLZ4oJyAkafM27qKc6-xQ@mail.gmail.com>
 <BE2CEC2C-53ED-4D80-974F-6552107C2B66@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:34259 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750775Ab1ELB6z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 May 2011 21:58:55 -0400
In-Reply-To: <BE2CEC2C-53ED-4D80-974F-6552107C2B66@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, Arindam Nath <arindam.nath@amd.com>, "cjb@laptop.org" <cjb@laptop.org>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "henry.su@amd.com" <henry.su@amd.com>, "aaron.lu@amd.com" <aaron.lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>


resend

On May 11, 2011, at 2:47 AM, Philip Rakity wrote:

> 
> On May 11, 2011, at 2:28 AM, zhangfei gao wrote:
> 
>> On Wed, May 11, 2011 at 4:52 AM, Philip Rakity <prakity@marvell.com> wrote:
>>> 
>>> \
>>> On May 11, 2011, at 1:48 AM, zhangfei gao wrote:
>>> 
>>>> On Thu, May 5, 2011 at 2:49 AM, Arindam Nath <arindam.nath@amd.com> wrote:
>>>>> Marvell controller requires 1.8V bit in UHS control register 2
>>>>> be set when doing UHS.  eMMC does not require 1.8V for DDR.
>>>>> add platform code to handle this.
>>>>> 
>>>>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>>>>> Reviewed-by: Arindam Nath <arindam.nath@amd.com>
>>>>> ---
>>>>> drivers/mmc/host/sdhci-pxa.c |   36 ++++++++++++++++++++++++++++++++++++
>>>>> 1 files changed, 36 insertions(+), 0 deletions(-)
>>>>> 
>>>>> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
>>>>> index 5a61208..b52c3e6 100644
>>>>> --- a/drivers/mmc/host/sdhci-pxa.c
>>>>> +++ b/drivers/mmc/host/sdhci-pxa.c
>>>>> @@ -69,7 +69,40 @@ static void set_clock(struct sdhci_host *host, unsigned int clock)
>>>>>       }
>>>>> }
>>>>> 
>>>>> +static int set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
>>>>> +{
>>>>> +       u16 ctrl_2;
>>>>> +
>>>>> +       /*
>>>>> +        * Set V18_EN -- UHS modes do not work without this.
>>>>> +        * does not change signaling voltage
>>>>> +        */
>>>>> +       ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>>>> +
>>>>> +               /* Select Bus Speed Mode for host */
>>>>> +       ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
>>>>> +       if (uhs == MMC_TIMING_UHS_SDR12)
>>>>> +               ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
>>>>> +       else if (uhs == MMC_TIMING_UHS_SDR25)
>>>>> +               ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
>>>>> +       else if (uhs == MMC_TIMING_UHS_SDR50) {
>>>>> +               ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
>>>>> +               ctrl_2 |= SDHCI_CTRL_VDD_180;
>>>>> +       } else if (uhs == MMC_TIMING_UHS_SDR104) {
>>>>> +               ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
>>>>> +               ctrl_2 |= SDHCI_CTRL_VDD_180;
>>>>> +       } else if (uhs == MMC_TIMING_UHS_DDR50) {
>>>>> +               ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
>>>>> +               ctrl_2 |= SDHCI_CTRL_VDD_180;
>>>>> +       }
>>>>> +       sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>>>>> +       pr_debug("%s:%s uhs = %d, ctrl_2 = %04X\n",
>>>>> +               __func__, mmc_hostname(host->mmc), uhs, ctrl_2);
>>>>> +       return 0;
>>>>> +}
>>>> 
>>>> Why move common register accessing from sdhci.c to specific driver?
>>> 
>>> In general case you do not know what the specific host controller work arounds are required.
>>> on mmp2 this code works (no need for V18 for low speed UHS)
>>> but other controllers it could be different
>> 
>> Sorry, not understand, the patch is for sd uhs card or for emmc?
>> For sd uhs card, no workaround is needed on mmp2, but require external
>> pmic to provide 1.8v io voltage.
> 
> 
> require 1.8V when setting UHS modes.  See latest MMP2 Documentation.
>> 
>>> 
>>>> 
>>>>> +
>>>>> static struct sdhci_ops sdhci_pxa_ops = {
>>>>> +       .set_uhs_signaling = set_uhs_signaling,
>>>>>       .set_clock = set_clock,
>>>>> };
>>>>> 
>>>>> @@ -141,6 +174,9 @@ static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
>>>>>       if (pdata->quirks)
>>>>>               host->quirks |= pdata->quirks;
>>>>> 
>>>>> +       /* enable 1/8V DDR capable */
>>>>> +       host->mmc->caps |= MMC_CAP_1_8V_DDR;
>>>>> +
>>>>>       /* If slot design supports 8 bit data, indicate this to MMC. */
>>>>>       if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
>>>>>               host->mmc->caps |= MMC_CAP_8_BIT_DATA;
>>>>> --
>>>>> 1.7.1
>>>>> 
>>>>> 
>>> 
>>> 
> 

