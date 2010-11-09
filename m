From: Philip Rakity <prakity@marvell.com>
Subject: Fwd: can we remove the quirk  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN ?
Date: Tue, 9 Nov 2010 03:45:15 -0800
Message-ID: <65EBF3EE-DE1E-46A4-BF41-A9D5A6096673@marvell.com>
References: <4D68A6A7-2D95-463F-875B-DB52ECCC53F1@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:40704 "HELO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754265Ab0KILrt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 9 Nov 2010 06:47:49 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Zhangfei Gao <zhangfei.gao@gmail.com>


reposting since we are discussing removing quirks.   

We could partition the quirks into one set for controller quirks and one set for platform quirks.  That would give us another 32 quirks. 

Philip

Begin forwarded message:

> From: Philip Rakity <prakity@marvell.com>
> Date: September 24, 2010 2:31:25 AM PDT
> To: Anton Vorontsov <cbouatmailru@gmail.com>
> Subject: Re: can we remove the quirk SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN ?
> 
> 
> you are right -- it would work -- was trying to get rid of quirk since really not needed.  Do not agree with Pierre.  Understand when registers in sdhci.c need changes quirks are good.  getting valves from platform code seems the wrong usage model.
> 
> On Sep 24, 2010, at 2:27 AM, Anton Vorontsov wrote:
> 
>> On Fri, Sep 24, 2010 at 02:15:57AM -0700, Philip Rakity wrote:
>>> 
>>> For our controller the original code would not work, since we get a clock value but the clock value may not be right.  The chip sd bus frequency can be adjusted in the platform init code to a higher value.  This value needs to be communicated to the sd layer.
>>> 
>>> Are you happy that the patch does not break your code?  If so I can submit patch with extended rationale.
>> 
>> Hm. Why would the driver won't work if you do
>> specify SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN? Or there's some additional
>> patch that you're talking about?
>> 
>> Thanks,
>> 
>>> 
>>> Philip
>>> 
>>> Eg
>>> ________________________________________
>>> From: Anton Vorontsov [cbouatmailru@gmail.com]
>>> Sent: Thursday, September 23, 2010 11:59 PM
>>> To: Philip Rakity
>>> Subject: Re: can we remove the quirk  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN ?
>>> 
>>> On Thu, Sep 23, 2010 at 04:57:41PM -0700, Philip Rakity wrote:
>>>> 
>>>> would be much better if I enclosed the code that compiles.
>>>> 
>>>> Philip
>>>> 
>>>> ====
>>>> 
>>>> I was looking at my code and then realized  the quirk is not needed since host->ops->max_clock is REALLY the test.
>>>> 
>>>> Do you concur ?  if so -- want to co sponsor the patch
>>>> 
>>>> I have NOT tried it since do not have your system.
>>> 
>>> See why there is a quirk:
>>> 
>>> http://kerneltrap.org/mailarchive/linux-kernel/2010/2/19/4540115
>>> 
>>> Thanks,
>>> 
>>>> Philip
>>>> 
>>>> ====
>>>> 
>>>> b/drivers/mmc/host/sdhci-cns3xxx.c
>>>> index b7050b3..27c896d 100644
>>>> --- a/drivers/mmc/host/sdhci-cns3xxx.c
>>>> +++ b/drivers/mmc/host/sdhci-cns3xxx.c
>>>> @@ -91,7 +91,6 @@ struct sdhci_pltfm_data sdhci_cns3xxx_pdata = {
>>>>     .quirks = SDHCI_QUIRK_BROKEN_DMA |
>>>>               SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
>>>>               SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
>>>> -               SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
>>>>               SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
>>>>               SDHCI_QUIRK_NONSTANDARD_CLOCK,
>>>> };
>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>> index 401527d..3d809f5 100644
>>>> --- a/drivers/mmc/host/sdhci.c
>>>> +++ b/drivers/mmc/host/sdhci.c
>>>> @@ -1779,18 +1779,20 @@ int sdhci_add_host(struct sdhci_host *host)
>>>>             mmc_dev(host->mmc)->dma_mask = &host->dma_mask;
>>>>     }
>>>> 
>>>> -     host->max_clk =
>>>> -             (caps & SDHCI_CLOCK_BASE_MASK) >> SDHCI_CLOCK_BASE_SHIFT;
>>>> -     host->max_clk *= 1000000;
>>>> -     if (host->max_clk == 0 || host->quirks &
>>>> -                     SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN) {
>>>> -             if (!host->ops->get_max_clock) {
>>>> -                     printk(KERN_ERR
>>>> -                            "%s: Hardware doesn't specify base clock "
>>>> -                            "frequency.\n", mmc_hostname(mmc));
>>>> -                     return -ENODEV;
>>>> -             }
>>>> +     if (host->ops->get_max_clock)
>>>>             host->max_clk = host->ops->get_max_clock(host);
>>>> +     else {
>>>> +             host->max_clk =
>>>> +                     (caps & SDHCI_CLOCK_BASE_MASK)
>>>> +                             >> SDHCI_CLOCK_BASE_SHIFT;
>>>> +             host->max_clk *= 1000000;
>>>> +     }
>>>> +
>>>> +     if (host->max_clk == 0) {
>>>> +             printk(KERN_ERR
>>>> +                    "%s: Hardware doesn't specify base clock "
>>>> +                    "frequency.\n", mmc_hostname(mmc));
>>>> +             return -ENODEV;
>>>>     }
>>>> 
>>>>     host->timeout_clk =
>>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>>> index d316bc7..d7c85fb 100644
>>>> --- a/drivers/mmc/host/sdhci.h
>>>> +++ b/drivers/mmc/host/sdhci.h
>>>> @@ -237,8 +237,6 @@ struct sdhci_host {
>>>> #define SDHCI_QUIRK_DELAY_AFTER_POWER                        (1<<23)
>>>> /* Controller uses SDCLK instead of TMCLK for data timeouts */
>>>> #define SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK          (1<<24)
>>>> -/* Controller reports wrong base clock capability */
>>>> -#define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN            (1<<25)
>>>> /* Controller cannot support End Attribute in NOP ADMA descriptor */
>>>> #define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC            (1<<26)
>>>> /* Controller is missing device caps. Use caps provided by host */
>>>> 
>>> 
>>> --
>>> Anton Vorontsov
>>> email: cbouatmailru@gmail.com
>>> irc://irc.freenode.net/bd2
>> 
>> -- 
>> Anton Vorontsov
>> email: cbouatmailru@gmail.com
>> irc://irc.freenode.net/bd2
> 

