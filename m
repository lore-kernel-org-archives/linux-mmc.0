From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 00/11] mmc: sdhci: Cleanup assignment/definition of PM ops
Date: Thu, 28 Jul 2016 19:27:25 +0900
Message-ID: <5799DE0D.1070205@samsung.com>
References: <1469619127-29283-1-git-send-email-ulf.hansson@linaro.org>
 <CGME20160727125014epcas1p2abc4b94e9598b972770f1d783b171f71@epcas1p2.samsung.com>
 <CAPDyKFraYeLZ25Z4FoEcmrz5eYcyXHjtF17q7mAs2N-SCfE+Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:35471 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448AbcG1K11 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jul 2016 06:27:27 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0OB000T10T1PVXE0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 28 Jul 2016 19:27:25 +0900 (KST)
In-reply-to: <CAPDyKFraYeLZ25Z4FoEcmrz5eYcyXHjtF17q7mAs2N-SCfE+Sw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>

Hi Ulf,

On 07/27/2016 09:50 PM, Ulf Hansson wrote:
> On 27 July 2016 at 13:31, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> The code in various sdhci drivers can be cleaned up in regards how PM ops is
>> being defined and assigned. This series attempts to clean up this code.
>>
>> In the end we want system PM sleep callbacks to be defined within #ifdef
>> CONFIG_PM_SLEEP and not as currently within CONFIG_PM.

It seems that dwmmc controller can also apply the similar cleanup patches.
After checking, i will send the patches..

Best Regards,
Jaehoon Chung

>>
>> Ulf Hansson (11):
>>   mmc: sdhci-pci-core: Simplify code by using SET_SYSTEM_SLEEP_PM_OPS
>>   mmc: sdhci-acpi: Simplify code by using SET_SYSTEM_SLEEP_PM_OPS
>>   mmc: sdhci-of-esdhc: Simplify code by using SIMPLE_DEV_PM_OPS
>>   mmc: sdhci-pxav3: Remove non needed #ifdef CONFIG_PM for dev_pm_ops
>>   mmc: sdhci-s3c: Remove non needed #ifdef CONFIG_PM for dev_pm_ops
>>   mmc: sdhci-sirf: Remove non needed #ifdef CONFIG_PM* for dev_pm_ops
>>   mmc: sdhci-esdhc-imx: Assign system PM ops within #ifdef
>>     CONFIG_PM_SLEEP
>>   mmc: sdhci-esdhc-imx: Use common sdhci_suspend|resume_host()
>>   mmc: sdhci-pltfm: Make sdhci_pltfm_suspend|resume() static
>>   mmc: sdhci-pltfm: Convert to use the SET_SYSTEM_SLEEP_PM_OPS
>>   mmc: sdhci-pltfm: Drop define for SDHCI_PLTFM_PMOPS
>>
>>  drivers/mmc/host/sdhci-acpi.c      |  8 +-------
>>  drivers/mmc/host/sdhci-bcm-kona.c  |  2 +-
>>  drivers/mmc/host/sdhci-cns3xxx.c   |  2 +-
>>  drivers/mmc/host/sdhci-dove.c      |  2 +-
>>  drivers/mmc/host/sdhci-esdhc-imx.c | 10 +++++++---
>>  drivers/mmc/host/sdhci-iproc.c     |  2 +-
>>  drivers/mmc/host/sdhci-of-esdhc.c  | 16 ++++++----------
>>  drivers/mmc/host/sdhci-of-hlwd.c   |  2 +-
>>  drivers/mmc/host/sdhci-pci-core.c  | 16 +++++-----------
>>  drivers/mmc/host/sdhci-pltfm.c     | 13 +++++--------
>>  drivers/mmc/host/sdhci-pltfm.h     |  7 -------
>>  drivers/mmc/host/sdhci-pxav2.c     |  2 +-
>>  drivers/mmc/host/sdhci-pxav3.c     |  9 +--------
>>  drivers/mmc/host/sdhci-s3c.c       |  9 +--------
>>  drivers/mmc/host/sdhci-sirf.c      |  4 +---
>>  drivers/mmc/host/sdhci-tegra.c     |  2 +-
>>  drivers/mmc/host/sdhci_f_sdh30.c   |  2 +-
>>  17 files changed, 35 insertions(+), 73 deletions(-)
>>
>> --
>> 1.9.1
>>
> 
> I decided to queue up this for next, as most of these are rather
> trivial changes and to get it tested in next.
> 
> Feel free to add acks/reviewed-by, or tell me to drop these changes!
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

