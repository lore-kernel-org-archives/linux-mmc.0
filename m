From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] mmc: core: Do not set mmc voltage to 1.8V when
 'no-1-8-v' is present
Date: Mon, 15 Jun 2015 09:23:01 -0300
Message-ID: <CAOMZO5CSvYHNwmeRsSJ+KYfAkisX+_2DePawd6AWHP-ANErq5Q@mail.gmail.com>
References: <1434227067-9600-1-git-send-email-festevam@gmail.com>
	<CAPDyKFq29S3K0sxCkUHO=QO0MqM0PskcjoM62EZysNc19SxP6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:35442 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933AbbFOMXD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Jun 2015 08:23:03 -0400
Received: by labko7 with SMTP id ko7so56643123lab.2
        for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2015 05:23:01 -0700 (PDT)
In-Reply-To: <CAPDyKFq29S3K0sxCkUHO=QO0MqM0PskcjoM62EZysNc19SxP6w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Dong Aisheng <aisheng.dong@freescale.com>, Kevin Lemoi <kevin.lemoi@savant.com>, Otavio Salvador <otavio@ossystems.com.br>, Sascha Hauer <kernel@pengutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>

Hi Ulf,

On Mon, Jun 15, 2015 at 9:08 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> What card (eMMC, SD, MMC) and which host driver is being used here?

It is an eMMC and the host driver is sdhci-esdhc-imx.c.

>> --- a/drivers/mmc/core/host.c
>> +++ b/drivers/mmc/core/host.c
>> @@ -527,6 +527,8 @@ int mmc_of_parse(struct mmc_host *host)
>>                 host->caps2 |= MMC_CAP2_HS400_1_8V | MMC_CAP2_HS200_1_8V_SDR;
>>         if (of_find_property(np, "mmc-hs400-1_2v", &len))
>>                 host->caps2 |= MMC_CAP2_HS400_1_2V | MMC_CAP2_HS200_1_2V_SDR;
>> +       if (of_find_property(np, "no-1-8-v", &len))
>> +               host->caps2 |= MMC_CAP_3_3V_ONLY_DDR;
>
> Do you intend to use 3.3V as the I/O voltage level for an eMMCs
> running in DDR mode? Isn't that violation of the eMMC spec?

Yes, I would like to use 3.3V as the I/O voltage level for an eMMC in DDR mode.

This was the behaviour prior to 312449efd16bb0, which I would like to
keep so that our custom board based on mx6sl could work. It works fine
with 3.14 kernel, but not on 4.1-rc due to the fact that the board
cannot provide 1.8V level, hence 'no-1-8-v' property is passed in the
device tree. With this patch applied 3.3V is applied and the eMMC can
successfully operate in 3.3V DDR mode.

Regards,

Fabio Estevam
