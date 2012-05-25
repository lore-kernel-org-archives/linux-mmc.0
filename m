From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH 3/3] mfd: Enable Debounce logic for SD hotplug detection
Date: Fri, 25 May 2012 13:52:40 +0530
Message-ID: <CANfBPZ9NysNJHeSSo+jHdOESo5M9DsyCBuTNspc5wTctTGZabw@mail.gmail.com>
References: <1337890467-32573-1-git-send-email-vishp@ti.com> <1337890467-32573-4-git-send-email-vishp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:34147 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756118Ab2EYIXD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 25 May 2012 04:23:03 -0400
Received: by bkwj4 with SMTP id j4so744618bkw.22
        for <linux-mmc@vger.kernel.org>; Fri, 25 May 2012 01:23:00 -0700 (PDT)
In-Reply-To: <1337890467-32573-4-git-send-email-vishp@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Viswanath Puttagunta <vishp@ti.com>
Cc: Linux-mmc <linux-mmc@vger.kernel.org>, T Krishnamoorthy Balaji <balajitk@ti.com>, Semen Protsenko <semen.protsenko@ti.com>, Volodymyr Riazantsev <v.riazantsev@ti.com>

On Fri, May 25, 2012 at 1:44 AM, Viswanath Puttagunta <vishp@ti.com> wr=
ote:
>
> Enable debounce logic in TWL6030 so that erroneous
> disconnect/connect interrupts will be suppressed.
>
> This will fix issue where SD card is either plugged
> or unplugged very slowly.
>
> Change-Id: Icc3afa4c66b3bc7920f27ff9c9a3f32e67d5833c
> Signed-off-by: Viswanath Puttagunta <vishp@ti.com>

Would be better without the Change-Id.
Also, this needs to be posted to linux-omap and linux-mfd, apart from l=
inux-mmc.

> ---
> =A0drivers/mfd/twl6030-irq.c | =A0 =A08 ++++++++
> =A0include/linux/i2c/twl.h =A0 | =A0 =A05 +++++
> =A02 files changed, 13 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
> index b76902f..05bb6e1 100644
> --- a/drivers/mfd/twl6030-irq.c
> +++ b/drivers/mfd/twl6030-irq.c
> @@ -317,6 +317,14 @@ int twl6030_mmc_card_detect_config(void)
>
> =A0ret);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL6030_MODULE_ID0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (MMC_MI=
NS_DEB_MASK | MMC_MEXT_DEB_MASK),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TWL6030=
_MMCDEBOUNCING);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("twl6030: Failed to write MMC_ME=
XT_DEB_MASK %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0return twl6030_irq_base + MMCDETECT_INTR_OFFSET;
> =A0}
> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> index 1f90de0..672dcfb 100644
> --- a/include/linux/i2c/twl.h
> +++ b/include/linux/i2c/twl.h
> @@ -147,6 +147,11 @@
> =A0#define SW_FC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(=
0x1 << 2)
> =A0#define STS_MMC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1
>
> +#define TWL6030_MMCDEBOUNCING =A0 =A0 =A0 =A0 =A00xED
> +#define MMC_DEB_BYPASS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x1 << 7)
> +#define MMC_MINS_DEB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0(0xF << 3)
> +#define MMC_MEXT_DEB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x7 << 0)

Some description about what these values mean (timing etc) would be hel=
pful.

> +
> =A0#define TWL6030_CFG_INPUT_PUPD3 =A0 =A0 =A0 =A00xF2
> =A0#define MMC_PU =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x=
1 << 3)
> =A0#define MMC_PD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x=
1 << 2)
> --
> 1.7.4.1
>
