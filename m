From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V3 29/30] mmc: sdhci-pci: Enable Software Command Queuing
 for some Intel controllers
Date: Fri, 8 Jul 2016 13:59:14 +0300
Message-ID: <577F8782.5050403@intel.com>
References: <1467973391-29221-1-git-send-email-adrian.hunter@intel.com>
 <1467973391-29221-30-git-send-email-adrian.hunter@intel.com>
 <75c625a19ac4402ab306a75fe741a5bd@bgmail103.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:14166 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754155AbcGHLD3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 8 Jul 2016 07:03:29 -0400
In-Reply-To: <75c625a19ac4402ab306a75fe741a5bd@bgmail103.nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venu Byravarasu <vbyravarasu@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>

On 08/07/16 13:46, Venu Byravarasu wrote:
> 
> 
>> -----Original Message-----
>> From: Adrian Hunter [mailto:adrian.hunter@intel.com]
>> Sent: Friday, July 08, 2016 3:53 PM
>> To: Ulf Hansson
>> Cc: linux-mmc; Alex Lemberg; Mateusz Nowak; Yuliy Izrailov; Jaehoon Chung;
>> Dong Aisheng; Das Asutosh; Zhangfei Gao; Dorfman Konstantin; David
>> Griego; Sahitya Tummala; Harjani Ritesh; Venu Byravarasu
>> Subject: [PATCH V3 29/30] mmc: sdhci-pci: Enable Software Command
>> Queuing for some Intel controllers
>>
>> Set MMC_CAP_SWCMDQ for Intel BYT and related eMMC host controllers.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  drivers/mmc/host/sdhci-pci-core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-
>> core.c
>> index 358ac0978cde..4504fc381877 100644
>> --- a/drivers/mmc/host/sdhci-pci-core.c
>> +++ b/drivers/mmc/host/sdhci-pci-core.c
>> @@ -356,7 +356,7 @@ static int byt_emmc_probe_slot(struct sdhci_pci_slot
>> *slot)  {
>>  	slot->host->mmc->caps |= MMC_CAP_8_BIT_DATA |
>> MMC_CAP_NONREMOVABLE |
>>  				 MMC_CAP_HW_RESET |
>> MMC_CAP_1_8V_DDR |
>> -				 MMC_CAP_CMD_DURING_TFR |
>> +				 MMC_CAP_CMD_DURING_TFR |
> 
> What exactly got changed in this patch?
> 
>> MMC_CAP_SWCMDQ |

It adds MMC_CAP_SWCMDQ to slot->host->mmc->caps for Intel BYT and related
eMMC host controllers.

>>  				 MMC_CAP_WAIT_WHILE_BUSY;
>>  	slot->host->mmc->caps2 |= MMC_CAP2_HC_ERASE_SZ;
>>  	slot->hw_reset = sdhci_pci_int_hw_reset;
>> --
>> 1.9.1

