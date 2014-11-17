From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-sirf: add sirf tuning function (cmd 19)
Date: Mon, 17 Nov 2014 14:54:13 +0100
Message-ID: <CAPDyKFprzeMS7Di7XUYTeZx-WE2UT+zmNKZM_8kHYhOLSoTfLQ@mail.gmail.com>
References: <1415720864-3936-1-git-send-email-21cnbao@gmail.com>
	<CAPDyKFopdcLXVCuoifd7K8NaRY4UXDbDmNJvyFeUQZs62or9Ag@mail.gmail.com>
	<CAGsJ_4yOCwt1YYd6UuAXjeO2iWhQB4XtouyriX1YsK7BnyNNLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:37544 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888AbaKQNyO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Nov 2014 08:54:14 -0500
Received: by mail-qg0-f52.google.com with SMTP id a108so3385833qge.39
        for <linux-mmc@vger.kernel.org>; Mon, 17 Nov 2014 05:54:13 -0800 (PST)
In-Reply-To: <CAGsJ_4yOCwt1YYd6UuAXjeO2iWhQB4XtouyriX1YsK7BnyNNLA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Minda Chen <Minda.Chen@csr.com>, Barry Song <Baohua.Song@csr.com>

On 17 November 2014 10:30, Barry Song <21cnbao@gmail.com> wrote:
> 2014-11-12 17:35 GMT+08:00 Ulf Hansson <ulf.hansson@linaro.org>:
>> On 11 November 2014 16:47, Barry Song <21cnbao@gmail.com> wrote:
>>> From: Minda Chen <Minda.Chen@csr.com>
>>>
>>> Add manual tuning function in CSR atlas7 SoC. It is mainly used
>>> for the UHS-I SD card working SDR50 SDR104 mode.
>>>
>>> The tuning principle can be seen in SD spec part1 v3.01 4.2.4.5
>>> (tuning command).
>>>
>>> SD host send the cmd19 and set the delay value(0-127).
>>> and the sdcard return 64 bytes data. If the data is same with
>>> the tuning data. The delay value is valid. Execute this commmand
>>> 128 times. And calculate the longest window of the valid values.
>>> The value in the middle of this window is the best value.
>>>
>>> Signed-off-by: Minda Chen <Minda.Chen@csr.com>
>>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>>> ---
>>>  drivers/mmc/host/sdhci-sirf.c | 105 +++++++++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 104 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
>>> index dd29d47..c71cf4e 100644
>>> --- a/drivers/mmc/host/sdhci-sirf.c
>>> +++ b/drivers/mmc/host/sdhci-sirf.c
>>> @@ -8,14 +8,18 @@
>>>
>>>  #include <linux/delay.h>
>>>  #include <linux/device.h>
>>> -#include <linux/mmc/host.h>
>>>  #include <linux/module.h>
>>>  #include <linux/of.h>
>>>  #include <linux/of_gpio.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/mmc/host.h>
>>> +#include <linux/mmc/mmc.h>
>>>  #include <linux/mmc/slot-gpio.h>
>>>  #include "sdhci-pltfm.h"
>>>
>>> +#define SDHCI_CLK_DELAY_SETTING 0x4C
>>>  #define SDHCI_SIRF_8BITBUS BIT(3)
>>> +#define SIRF_TUNING_COUNT 128
>>>
>>>  struct sdhci_sirf_priv {
>>>         struct clk *clk;
>>> @@ -49,7 +53,106 @@ static void sdhci_sirf_set_bus_width(struct sdhci_host *host, int width)
>>>         sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>>>  }
>>>
>>> +static int sdhci_sirf_execute_tuning(struct sdhci_host *host, u32 opcode)
>>> +{
>>> +       int tuning_seq_cnt = 3;
>>> +       u8 phase, *data_buf, tuned_phases[SIRF_TUNING_COUNT];
>>> +       u8 tuned_phase_cnt = 0;
>>> +       const u8 *tuning_block_pattern = tuning_blk_pattern_4bit;
>>> +       int size = sizeof(tuning_blk_pattern_4bit);
>>> +       int rc, longest_range = 0;
>>> +       int start = -1, end, tuning_value = -1, range = 0;
>>> +       u16 clock_setting;
>>> +       struct mmc_host *mmc = host->mmc;
>>> +
>>> +       data_buf = kmalloc(size, GFP_KERNEL);
>>> +       if (!data_buf)
>>> +               return -ENOMEM;
>>> +
>>> +       clock_setting = sdhci_readw(host, SDHCI_CLK_DELAY_SETTING);
>>> +       clock_setting &= ~0x3fff;
>>> +
>>> +retry:
>>> +       phase = 0;
>>> +       do {
>>> +               struct mmc_command cmd = { 0 };
>>> +               struct mmc_data data = { 0 };
>>> +               struct mmc_request mrq = {
>>> +                       .cmd = &cmd,
>>> +                       .data = &data
>>> +               };
>>> +               struct scatterlist sg;
>>> +
>>> +               sdhci_writel(host,
>>> +                       clock_setting | phase | (phase << 7) | (phase << 16),
>>> +                       SDHCI_CLK_DELAY_SETTING);
>>> +
>>> +               cmd.opcode = opcode;
>>> +               cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
>>> +
>>> +               data.blksz = size;
>>> +               data.blocks = 1;
>>> +               data.flags = MMC_DATA_READ;
>>> +               data.timeout_ns = NSEC_PER_SEC; /* 1 second */
>>> +
>>> +               data.sg = &sg;
>>> +               data.sg_len = 1;
>>> +               sg_init_one(&sg, data_buf, size);
>>> +               memset(data_buf, 0, size);
>>> +               mmc_wait_for_req(mmc, &mrq);
>>
>> These piece of code, which sends the tuning command don't belong in
>> the host driver. Instead I would like this to be handled from a helper
>> function from the mmc core.
>>
>> I realize that there already a few existing host drivers that
>> implemented similar code and I don't like it. We should convert them
>> to use a common helper function from the core instead.
> yes. that is fine.
>
> our engineering is currently very busy and might have no time to
> handle this for this moment.
> do you think we can move your requirement to a new refine task of next
> window after you pick up this in this window?

No.

You don't have to adopt the other host drivers at this point, only to
fix yours accordingly. The rest we can take care of later.

Br
Uffe
