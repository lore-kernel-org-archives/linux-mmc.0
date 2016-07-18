From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sd: Extend sysfs with OCR register
Date: Mon, 18 Jul 2016 13:20:03 +0200
Message-ID: <CAPDyKFo9+yJdDOtxaipMEEv9e2WO5i2Fro3RYdCQ2aMe=QpYSA@mail.gmail.com>
References: <20160713212225.106498-1-prtvar.b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37776 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbcGRLUF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jul 2016 07:20:05 -0400
Received: by mail-wm0-f45.google.com with SMTP id i5so111672762wmg.0
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2016 04:20:04 -0700 (PDT)
In-Reply-To: <20160713212225.106498-1-prtvar.b@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bojan Prtvar <prtvar.b@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Weijun Yang <york.yang@csr.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Shawn Lin <shawn.lin@rock-chips.com>, Carlo Caione <carlo@endlessm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 13 July 2016 at 23:22, Bojan Prtvar <prtvar.b@gmail.com> wrote:
> We already exported OCR for mmc cards. Let's export it
> for sd cards as well.
>
> Signed-off-by: Bojan Prtvar <prtvar.b@gmail.com>

I decided to squash this change into the earlier applied: "mmc: core:
Extend sysfs with OCR register".

Thanks and kind regards
Uffe

> ---
>  drivers/mmc/core/sd.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index b95bd24..3dd0861 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -675,6 +675,7 @@ MMC_DEV_ATTR(manfid, "0x%06x\n", card->cid.manfid);
>  MMC_DEV_ATTR(name, "%s\n", card->cid.prod_name);
>  MMC_DEV_ATTR(oemid, "0x%04x\n", card->cid.oemid);
>  MMC_DEV_ATTR(serial, "0x%08x\n", card->cid.serial);
> +MMC_DEV_ATTR(ocr, "%08x\n", card->ocr);
>
>
>  static struct attribute *sd_std_attrs[] = {
> @@ -690,6 +691,7 @@ static struct attribute *sd_std_attrs[] = {
>         &dev_attr_name.attr,
>         &dev_attr_oemid.attr,
>         &dev_attr_serial.attr,
> +       &dev_attr_ocr.attr,
>         NULL,
>  };
>  ATTRIBUTE_GROUPS(sd_std);
> --
> 2.8.0.GIT
>
