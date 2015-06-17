From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] mmc: core: Do not set mmc voltage to 1.8V when
 'no-1-8-v' is present
Date: Wed, 17 Jun 2015 13:25:21 -0300
Message-ID: <CAOMZO5Aq-aTjQ1rddBJcrJ56jRV1Q=dLgK5j4TasKdykiWLniQ@mail.gmail.com>
References: <1434227067-9600-1-git-send-email-festevam@gmail.com>
	<CAPDyKFq29S3K0sxCkUHO=QO0MqM0PskcjoM62EZysNc19SxP6w@mail.gmail.com>
	<CAOMZO5CSvYHNwmeRsSJ+KYfAkisX+_2DePawd6AWHP-ANErq5Q@mail.gmail.com>
	<CAOMZO5Amb9hR=DOxd_wynwqc3Dfo0rLfdJS-dkKiOqB89PyMwQ@mail.gmail.com>
	<CAPDyKFotVdm5vDwjqUw=cD9jmRU86ZBbq1c-qmiFa4Yj2JivxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:33464 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbbFQQZY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Jun 2015 12:25:24 -0400
Received: by laka10 with SMTP id a10so36906811lak.0
        for <linux-mmc@vger.kernel.org>; Wed, 17 Jun 2015 09:25:22 -0700 (PDT)
In-Reply-To: <CAPDyKFotVdm5vDwjqUw=cD9jmRU86ZBbq1c-qmiFa4Yj2JivxQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Dong Aisheng <aisheng.dong@freescale.com>, Kevin Lemoi <kevin.lemoi@savant.com>, Otavio Salvador <otavio@ossystems.com.br>, Sascha Hauer <kernel@pengutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>

Hi Ulf,

On Tue, Jun 16, 2015 at 6:31 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> I had a closer look, should have done that before.
>
> I think we need to decide what "no-1-8-v" should be used for.
> Currently the DT documentation is unclear and depending on what SDHCI
> variant, the binding has different purpose. It's a mess!

Thanks for your feedback.

>
> sdhci-pltfm + sdhci-esdhc-imx use the "no-1-8-v" DT binding to enable
> the SDHCI_QUIRK2_NO_1_8_V. The sdhci driver uses this quirk to mask
> the bus speed modes for SD UHS cards.
>
> In this regards, consider the two below options.
>
> 1) We have DT bindings for SD UHS speed modes, which somehow makes the
> "no-1-8-v" binding redundant (or deprecated).
>
> 2) If you can model the VCCQ power supply as as a regulator, you could
> use regulator_is_supported_voltage() API to find out similar
> information used to set SDHCI_QUIRK2_NO_1_8_V. In fact, sdhci already
> does that to mask MMC_CAP2_HSX00_1_2V, unless 1.2V is supported.
>
> In a third case, sdhci-pxav3 use the "no-1-8-v" DT binding to mask
> SDHCI_CAN_VDD_180/SDHCI_CAN_VDD_330, which seems wrong, as it has
> nothing to do with the power to the card (VMMC). It's also used it to
> mask MMC_CAP_1_8V_DDR.
>
> The summary, is that I would rather see us to move away from using the
> "no-1-8-v" DT binding and use the proper SD UHS bus speed modes
> binding instead.

Makes sense indeed.

The challenge here is that we still need to keep the old dtb's working.

Motivation for this patch was a custom mx6sl board that works fine
with 3.14, but after upgrading the kernel to 4.0 the eMMC no longer
can mount the rootfs. This is a regression caused by commit
312449efd16bb06, which applies 1.8V to the eMMC card that can only
operate at 3.3V.

Same thing happens on imx6q-sabresd: we have 3.3V voltage being
supplied to the eMMC, but now we are operating it at 1.8V, even though
if we have 'no-1-8-v' property in the device tree.

While I understand the need for improvement that you clearly
described, I would also like that the old dtb's could still work
'as-is' with a modern kernel.

The path I propose here was the minimal invasive method I could come
up to allow the old dtb compatibility.

Thanks,

Fabio Estevam
