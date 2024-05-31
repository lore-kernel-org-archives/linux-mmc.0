Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2471415575A;
	Fri, 31 May 2024 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154743; cv=none; b=NunbCoasuH6IEc2/mlwE3bse2nRuqghZNoyxQ5gtM8/xy36V9AWqWwAbiMzHbjkWWLKlND9eunDU1P7sajV3B5Hyi7fQxLJFpnJafDQQNA6ILcpvVaZW+U1/BQQPYy9PgTQIbb42kILEnQaIjvGhbD7Iz8/CIlHhnXIV33YCF00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154743; c=relaxed/simple;
	bh=8rvouJXSTI4Pm7kS/trxN1GuwWPDuIYI3MqGF8IM4eE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8QUzmN0fcGWyJ89tBD4u2FtOd4tEtMMTQiTcLhIvfc6IZOXmBcv8oI6dI8BcYawD3BLOC0KYG/06w1Ojnw3uo6OV4BJwSEiGPtml/lYX47aUc1R+4oC8M4ec574Mmf9Ht0OKi5FA+zszOLkPO1bWG+9RE7sEKqyuPlwBW7Fg9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cv9TEttt; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cv9TEttt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717154741; x=1748690741;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8rvouJXSTI4Pm7kS/trxN1GuwWPDuIYI3MqGF8IM4eE=;
  b=Cv9TEtttqn1D+ZYS4iIpUZbvlJJVlggevmk9d1Sx1ONYiyRopsQgcjVm
   t7T7u6Rn8M9wQOFlSYV/0ql87u5SwLTmqjtFPNv3Ud+0n8++kE2evl/Hj
   494mXNJlZU2Fx5XGEBRpRmhB+Y0ypMYMdqb8PFaVTplRR4IT27NhYp660
   f+NVWA/KuWxLW7ph9IyEs1d9XsWTONpbjhGXRXT2v5Sc24YdGziKAchIK
   heb/SzV02wzyH+Jp4E4tjR0OfcozssPrZSNjM+GoCWGJInpKIIMYuonfD
   m7VVoM0SVs2ksscs8th+uMZ85HAGJnYybEJDwGB76a4fQIyi02F8n96Rb
   g==;
X-CSE-ConnectionGUID: fLejgK87QGW19IpwjfMmzw==
X-CSE-MsgGUID: l8ZdtoDUTXiRc40UXErvHg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13916927"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="13916927"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 04:25:39 -0700
X-CSE-ConnectionGUID: s/V0LCyfQgubFb97mBSlCQ==
X-CSE-MsgGUID: sIKyOqq8S72f1xaIKEPK5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36232672"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.41.28])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 04:25:36 -0700
Message-ID: <a4542d2a-490f-40ab-a2a8-a42b921d2656@intel.com>
Date: Fri, 31 May 2024 14:25:30 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V16 12/23] mmc: sdhci-uhs2: add reset function function
To: Victor Shih <victorshihgli@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
 Greg.tu@genesyslogic.com.tw, dlunev@chromium.org,
 Ben Chuang <ben.chuang@genesyslogic.com.tw>,
 Victor Shih <victor.shih@genesyslogic.com.tw>, ulf.hansson@linaro.org
References: <20240522110909.10060-1-victorshihgli@gmail.com>
 <20240522110909.10060-13-victorshihgli@gmail.com>
 <42f2b1d4-e6c2-4860-956d-4f10c3b05529@intel.com>
 <CAK00qKBA81zx=QmU7m=pZXOzdY4syOht4p_-SU7fdw+-an0ciQ@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAK00qKBA81zx=QmU7m=pZXOzdY4syOht4p_-SU7fdw+-an0ciQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 31/05/24 13:32, Victor Shih wrote:
> On Fri, May 24, 2024 at 3:23 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 22/05/24 14:08, Victor Shih wrote:
>>> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>>>
>>> Sdhci_uhs2_reset() does a UHS-II specific reset operation.
>>>
>>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
>>> ---
>>>
>>> Updates in V15:
>>>  - Refer the SD Host Controller Standard Specification Section 3.10
>>>    to add reset command data mechanism.
>>>
>>> Updates in V14:
>>>  - Since mmc_card_uhs2() is the same as sdhci_uhs2_mode(), so drop
>>>    sdhci_uhs2_mode() and use mmc_card_uhs2() instead of sdhci_uhs2_mode().
>>>
>>> Updates in V13:
>>>  - Use ios timing to stead MMC_UHS2_SUPPORT for indicate the UHS2 mode.
>>>
>>> Updates in V8:
>>>  - Adjust the position of matching brackets.
>>>
>>> Updates in V6:
>>>  - Remove unnecessary functions and simplify code.
>>>
>>> ---
>>>
>>>  drivers/mmc/host/sdhci-uhs2.c | 57 +++++++++++++++++++++++++++++++++++
>>>  drivers/mmc/host/sdhci-uhs2.h |  1 +
>>>  drivers/mmc/host/sdhci.c      |  3 +-
>>>  drivers/mmc/host/sdhci.h      |  1 +
>>>  4 files changed, 61 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
>>> index 9cb0f1b2a37d..7652158ea151 100644
>>> --- a/drivers/mmc/host/sdhci-uhs2.c
>>> +++ b/drivers/mmc/host/sdhci-uhs2.c
>>> @@ -10,7 +10,9 @@
>>>   *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>>   */
>>>
>>> +#include <linux/delay.h>
>>>  #include <linux/module.h>
>>> +#include <linux/iopoll.h>
>>>
>>>  #include "sdhci.h"
>>>  #include "sdhci-uhs2.h"
>>> @@ -21,6 +23,8 @@
>>>  #define SDHCI_UHS2_DUMP(f, x...) \
>>>       pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
>>>
>>> +#define UHS2_RESET_TIMEOUT_100MS             100000
>>> +
>>>  void sdhci_uhs2_dump_regs(struct sdhci_host *host)
>>>  {
>>>       if (!(mmc_card_uhs2(host->mmc)))
>>> @@ -49,6 +53,57 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host)
>>>  }
>>>  EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
>>>
>>> +/*****************************************************************************\
>>> + *                                                                           *
>>> + * Low level functions                                                       *
>>> + *                                                                           *
>>> +\*****************************************************************************/
>>> +
>>> +/**
>>> + * sdhci_uhs2_reset - invoke SW reset
>>> + * @host: SDHCI host
>>> + * @mask: Control mask
>>> + *
>>> + * Invoke SW reset, depending on a bit in @mask and wait for completion.
>>> + */
>>> +void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
>>> +{
>>> +     u32 val;
>>> +
>>> +     sdhci_writew(host, mask, SDHCI_UHS2_SW_RESET);
>>> +
>>> +     if (mask & SDHCI_UHS2_SW_RESET_FULL)
>>> +             host->clock = 0;
>>> +
>>> +     /* hw clears the bit when it's done */
>>> +     if (read_poll_timeout_atomic(sdhci_readw, val, !(val & mask), 10,
>>> +                                  UHS2_RESET_TIMEOUT_100MS, true, host, SDHCI_UHS2_SW_RESET)) {
>>> +             pr_warn("%s: %s: Reset 0x%x never completed. %s: clean reset bit.\n", __func__,
>>> +                     mmc_hostname(host->mmc), (int)mask, mmc_hostname(host->mmc));
>>> +             sdhci_writeb(host, 0, SDHCI_UHS2_SW_RESET);
>>> +             return;
>>> +     }
>>> +}
>>> +EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
>>> +
>>> +static void sdhci_uhs2_reset_cmd_data(struct mmc_host *mmc)
>>> +{
>>> +     struct sdhci_host *host = mmc_priv(mmc);
>>> +
>>> +     sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
>>> +
>>> +     if (host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_A ||
>>> +         host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_A_HD ||
>>> +         host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B ||
>>> +         host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD) {
>>
>> Please use mmc_card_uhs2()
>>
> 
> Hi, Adrian
> 
>      I will update this in the v17 version.
> 
> Thanks, Victor Shih
> 
>>> +             sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
>>> +
>>> +             sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
>>> +             sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
>>> +             sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK, SDHCI_UHS2_INT_ERROR_MASK);
>>> +     }
>>> +}
>>> +
>>>  /*****************************************************************************\
>>>   *                                                                           *
>>>   * Driver init/exit                                                          *
>>> @@ -57,6 +112,8 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
>>>
>>>  static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
>>>  {
>>> +     host->mmc_host_ops.uhs2_reset_cmd_data = sdhci_uhs2_reset_cmd_data;
>>
>> As noted for patch 8, any host controller resets needed
>> should be done before completing the request, so a call
>> back function should not be needed.
>>
> 
> Hi, Adrian
> 
>      I want to confirm further, so can I call
> sdhci_uhs2_reset_cmd_data() directly
>      in the mmc_wait_for_req_done()?

No

>      Am I understanding something wrong?

See the response to your questions over patch 8.

> 
> Thanks, Victor Shih
> 
>>> +
>>>       return 0;
>>>  }
>>>
>>> diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
>>> index 2bfe18d29bca..caaf9fba4975 100644
>>> --- a/drivers/mmc/host/sdhci-uhs2.h
>>> +++ b/drivers/mmc/host/sdhci-uhs2.h
>>> @@ -177,5 +177,6 @@
>>>  struct sdhci_host;
>>>
>>>  void sdhci_uhs2_dump_regs(struct sdhci_host *host);
>>> +void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
>>>
>>>  #endif /* __SDHCI_UHS2_H */
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 8fc3e001db74..f212da6dc2aa 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -236,7 +236,7 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
>>>  }
>>>  EXPORT_SYMBOL_GPL(sdhci_reset);
>>>
>>> -static bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
>>> +bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
>>>  {
>>>       if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
>>>               struct mmc_host *mmc = host->mmc;
>>> @@ -249,6 +249,7 @@ static bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
>>>
>>>       return true;
>>>  }
>>> +EXPORT_SYMBOL_GPL(sdhci_do_reset);
>>>
>>>  static void sdhci_reset_for_all(struct sdhci_host *host)
>>>  {
>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>> index 13703f1a3710..83d994c8d89e 100644
>>> --- a/drivers/mmc/host/sdhci.h
>>> +++ b/drivers/mmc/host/sdhci.h
>>> @@ -845,6 +845,7 @@ void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
>>>  int sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
>>>  void sdhci_set_bus_width(struct sdhci_host *host, int width);
>>>  void sdhci_reset(struct sdhci_host *host, u8 mask);
>>> +bool sdhci_do_reset(struct sdhci_host *host, u8 mask);
>>>  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
>>>  int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
>>>  int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode);
>>

