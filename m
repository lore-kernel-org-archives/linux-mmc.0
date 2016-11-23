From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [GIT PULL] DWMMC controller for next
Date: Wed, 23 Nov 2016 21:31:23 +0900
Message-ID: <a6358997-0e19-05b6-e488-3a17bdac5952@samsung.com>
References: <63a0b568-cd9e-d038-b7eb-08b7868f96f2@samsung.com>
 <CAPDyKFo+W12sV-U8r44ySerWHi2tAwEEnGNMd97iUN8NLV4duA@mail.gmail.com>
 <CGME20161123114758epcas5p25465d2ecaf5f7332003aa0eab61cac31@epcas5p2.samsung.com>
 <CAPDyKFokGM+-6hjGpgJRJOVwANX43gEww4p17LCxvD=e0Qbj=g@mail.gmail.com>
 <ed2ab8e4-6209-49d4-8ef3-76db0a0342bf@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:49154 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933392AbcKWMbZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Nov 2016 07:31:25 -0500
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OH300FMQHGAAZ80@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 23 Nov 2016 21:31:22 +0900 (KST)
In-reply-to: <ed2ab8e4-6209-49d4-8ef3-76db0a0342bf@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 11/23/2016 08:50 PM, Jaehoon Chung wrote:
> On 11/23/2016 08:47 PM, Ulf Hansson wrote:
>> On 22 November 2016 at 17:13, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> On 22 November 2016 at 10:59, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>>> Dear Ulf,
>>>>
>>>> Could you pull these patches on your next branch?
>>>> If there is a problem, let me know, plz.
>>>>
>>>> The following changes since commit e2081b37d910c5e6c6925d9b4d0a7a6283f84ec5:
>>>>
>>>>   Merge branch 'fixes' into next (2016-11-21 11:09:18 +0100)
>>>>
>>>> are available in the git repository at:
>>>>
>>>>   https://github.com/jh80chung/dw-mmc.git for-ulf
>>>>
>>>> for you to fetch changes up to e25fd245b557482a8e0f7ab87841085f30706f3a:
>>>>
>>>>   Documentation: synopsys-dw-mshc: remove the unused properties (2016-11-22 10:34:05 +0900)
>>>>
>>>> ----------------------------------------------------------------
>>>> Colin Ian King (1):
>>>>       mmc: dw_mmc: fix spelling mistake in dev_dbg message
>>>>
>>>> Jaehoon Chung (9):
>>>>       mmc: dw_mmc: display the real register value on debugfs
>>>>       mmc: dw_mmc: fix the debug message for checking card's present
>>>>       mmc: dw_mmc: change the DW_MCI_FREQ_MIN from 400K to 100K
>>>>       mmc: dw_mmc: use the hold register when send stop command
>>>>       mmc: dw_mmc: call the dw_mci_prep_stop_abort() by default
>>>>       mmc: dw_mmc: use the cookie's enum values for post/pre_req()
>>>>       mmc: dw_mmc: remove the unnecessary mmc_data structure
>>>>       mmc: dw_mmc: The "clock-freq-min-max" property was deprecated
>>>>       Documentation: synopsys-dw-mshc: remove the unused properties
>>>>
>>>>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt |  8 ++------
>>>>  drivers/mmc/host/dw_mmc.c                                  | 92 ++++++++++++++++++++++++++++++++++++++++++++------------------------------------------------
>>>>  include/linux/mmc/dw_mmc.h                                 |  6 ++++++
>>>>  3 files changed, 52 insertions(+), 54 deletions(-)
>>>>
>>>> Best Regards,
>>>> Jaehoon Chung
>>>
>>> Dear Jaehoon, thanks for the pull request. I have add queued it all up
>>> for my next branch!
>>>
>>>
>>> Kind regards
>>> Uffe
>>
>> Jaehoon,
>>
>> It seems like some of these patches breaks Exynos 5250-arndale. Can
>> you please have a look and see what you think?
>> https://kernelci.org/boot/all/job/ulfh/kernel/v4.9-rc5-78-g52eb5d4531e4/
> 
> I will check and reply. Thanks for noticing.

Ulf,

I'm not sure but if more stable than now..i think that needs to check NULL pointer.
What do you want how i do? Send patch or revert commit?

I didn't have the 5250-arndale..so i can't test..How about the below?

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 881ca3e..7a0cb97 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -167,12 +167,14 @@ static int dw_mci_regs_show(struct seq_file *s, void *v)
 {
        struct dw_mci *host = s->private;
 
-       seq_printf(s, "STATUS:\t0x%08x\n", mci_readl(host, STATUS));
-       seq_printf(s, "RINTSTS:\t0x%08x\n", mci_readl(host, RINTSTS));
-       seq_printf(s, "CMD:\t0x%08x\n", mci_readl(host, CMD));
-       seq_printf(s, "CTRL:\t0x%08x\n", mci_readl(host, CTRL));
-       seq_printf(s, "INTMASK:\t0x%08x\n", mci_readl(host, INTMASK));
-       seq_printf(s, "CLKENA:\t0x%08x\n", mci_readl(host, CLKENA));
+       if (host->regs) {
+               seq_printf(s, "STATUS:\t0x%08x\n", mci_readl(host, STATUS));
+               seq_printf(s, "RINTSTS:\t0x%08x\n", mci_readl(host, RINTSTS));
+               seq_printf(s, "CMD:\t0x%08x\n", mci_readl(host, CMD));
+               seq_printf(s, "CTRL:\t0x%08x\n", mci_readl(host, CTRL));
+               seq_printf(s, "INTMASK:\t0x%08x\n", mci_readl(host, INTMASK));
+               seq_printf(s, "CLKENA:\t0x%08x\n", mci_readl(host, CLKENA));
+       }
 
        return 0;
 }

Best Regards,
Jaehoon Chung

> 
> Beset Regards,
> Jaehoon Chung
> 
>>
>> Kind regards
>> Uffe
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

