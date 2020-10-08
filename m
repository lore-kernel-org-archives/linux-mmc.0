Return-Path: <SRS0=iGfF=DP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C88C43467
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 10:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CF94217BA
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 10:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgJHK6u (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Oct 2020 06:58:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:63890 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgJHK6u (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 8 Oct 2020 06:58:50 -0400
IronPort-SDR: IK4xDdyQCzPo+t8MmDOnXUDRgZCaMJ7MISxA0+AEcvp0ZbAY9DwUe9P6Ris82KfikQJT0VdYwR
 ILWFqLJ+BXdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="145182255"
X-IronPort-AV: E=Sophos;i="5.77,350,1596524400"; 
   d="scan'208";a="145182255"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 03:58:50 -0700
IronPort-SDR: 8sd9nLNJnObfiYi8NdqPtHp397fUVU8PhBz5+MoA1xr9FOAR2lFSppsRviOf3tvrKYvf6VWhGL
 nK7jjAGVKOoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,350,1596524400"; 
   d="scan'208";a="297914543"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by fmsmga007.fm.intel.com with ESMTP; 08 Oct 2020 03:58:47 -0700
Subject: Re: [PATCH v4 4/4] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        muhammad.husaini.zulkifli@intel.com
Cc:     Michal Simek <michal.simek@xilinx.com>,
        andriy.shevchenko@intel.com,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lakshmi.bai.raja.subramanian@intel.com,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20201008020936.19894-1-muhammad.husaini.zulkifli@intel.com>
 <20201008020936.19894-5-muhammad.husaini.zulkifli@intel.com>
 <CAPDyKFpUv8yeVrWVLRKvz4eKsSDdk0y4dKY2mYs07zpA2UqNdw@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <35692f1c-62a4-6c71-d67a-2a216e97e7d5@intel.com>
Date:   Thu, 8 Oct 2020 13:58:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpUv8yeVrWVLRKvz4eKsSDdk0y4dKY2mYs07zpA2UqNdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 8/10/20 12:27 pm, Ulf Hansson wrote:
> On Thu, 8 Oct 2020 at 04:12, <muhammad.husaini.zulkifli@intel.com> wrote:
>>
>> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
>>
>> Voltage switching sequence is needed to support UHS-1 interface.
>> There are 2 places to control the voltage.
>> 1) By setting the AON register using firmware driver calling
>> system-level platform management layer (SMC) to set the register.
>> 2) By controlling the GPIO expander value to drive either 1.8V or 3.3V
>> for power mux input.
>>
>> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  drivers/mmc/host/sdhci-of-arasan.c | 126 +++++++++++++++++++++++++++++
>>  1 file changed, 126 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
>> index 46aea6516133..ea2467b0073d 100644
>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>> @@ -16,6 +16,7 @@
>>   */
>>
>>  #include <linux/clk-provider.h>
>> +#include <linux/gpio/consumer.h>
>>  #include <linux/mfd/syscon.h>
>>  #include <linux/module.h>
>>  #include <linux/of_device.h>
>> @@ -23,6 +24,7 @@
>>  #include <linux/regmap.h>
>>  #include <linux/of.h>
>>  #include <linux/firmware/xlnx-zynqmp.h>
>> +#include <linux/firmware/intel/keembay_firmware.h>
>>
>>  #include "cqhci.h"
>>  #include "sdhci-pltfm.h"
>> @@ -136,6 +138,7 @@ struct sdhci_arasan_clk_data {
>>   * @soc_ctl_base:      Pointer to regmap for syscon for soc_ctl registers.
>>   * @soc_ctl_map:       Map to get offsets into soc_ctl registers.
>>   * @quirks:            Arasan deviations from spec.
>> + * @uhs_gpio:          Pointer to the uhs gpio.
>>   */
>>  struct sdhci_arasan_data {
>>         struct sdhci_host *host;
>> @@ -150,6 +153,7 @@ struct sdhci_arasan_data {
>>         struct regmap   *soc_ctl_base;
>>         const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
>>         unsigned int    quirks;
>> +       struct gpio_desc *uhs_gpio;
>>
>>  /* Controller does not have CD wired and will not function normally without */
>>  #define SDHCI_ARASAN_QUIRK_FORCE_CDTEST        BIT(0)
>> @@ -361,6 +365,112 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
>>         return -EINVAL;
>>  }
>>
>> +static int sdhci_arasan_keembay_voltage_switch(struct mmc_host *mmc,
>> +                                      struct mmc_ios *ios)
>> +{
>> +       struct sdhci_host *host = mmc_priv(mmc);
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
>> +       u16 ctrl_2, clk;
>> +       int ret;
>> +
>> +       switch (ios->signal_voltage) {
>> +       case MMC_SIGNAL_VOLTAGE_180:
>> +               clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>> +               clk &= ~SDHCI_CLOCK_CARD_EN;
>> +               sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>> +
>> +               clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>> +               if (clk & SDHCI_CLOCK_CARD_EN)
>> +                       return -EAGAIN;
>> +
>> +               sdhci_writeb(host, SDHCI_POWER_ON | SDHCI_POWER_180,
>> +                                  SDHCI_POWER_CONTROL);
>> +
>> +               /*
>> +                * Set VDDIO_B voltage to Low for 1.8V
>> +                * which is controlling by GPIO Expander.
>> +                */
>> +               gpiod_set_value_cansleep(sdhci_arasan->uhs_gpio, 0);
>> +
>> +               /*
>> +                * This is like a final gatekeeper. Need to ensure changed voltage
>> +                * is settled before and after turn on this bit.
>> +                */
>> +               usleep_range(1000, 1100);
>> +
>> +               ret = keembay_sd_voltage_selection(KEEMBAY_SET_1V8_VOLT);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               usleep_range(1000, 1100);
> 
> No, sorry, but I don't like this.
> 
> This looks like a GPIO regulator with an extension of using the
> keembay_sd_voltage_selection() thingy. I think you can model these
> things behind a regulator and hook it up as a vqmmc supply in DT
> instead. BTW, this is the common way we deal with these things for mmc
> host drivers.

It seemed to me that would just result in calling regulator API instead of
GPIO API but the flow above would otherwise be unchanged i.e. no benefit

