From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC] mmc: core: Extend sysfs with DSR register
Date: Tue, 12 Jul 2016 11:56:58 +0200
Message-ID: <CAPDyKFrrCovUcZ0waTWaO2Y-UKeBRBwbwe2573CGgoSi7u_90A@mail.gmail.com>
References: <20160707081930.53884-1-prtvar.b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38508 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964AbcGLJ5A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2016 05:57:00 -0400
Received: by mail-wm0-f53.google.com with SMTP id o80so18304530wme.1
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2016 02:57:00 -0700 (PDT)
In-Reply-To: <20160707081930.53884-1-prtvar.b@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bojan Prtvar <prtvar.b@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 7 July 2016 at 10:19, Bojan Prtvar <prtvar.b@gmail.com> wrote:
> Hi,
>
> On embedded platform we have a small diagnostic application which
> has to record following emmc registers on every power cycle:
> CID, CSD, EXT_CSD, OCR, RCA and DSR. The CID, CSD, EXT_CSD and OCR
> are accessible via ioctl(MMC_IOC_CMD) or through sysfs. The RCA
> should always be 1 on any linux platform. I can't find a better way
> for accessing the DSR then as proposed below.
>
> Regards,
> Bojan
>
> User space access to Driver Stage Register (DSR) can be useful
> for diagnostics purpose.

Can you please rephrase this changelog, similar to how changlog looks
like for the patch which added the OCR register to sysfs.

Kind regards
Uffe

>
> Signed-off-by: Bojan Prtvar <prtvar.b@gmail.com>
> ---
>  Documentation/mmc/mmc-dev-attrs.txt |  1 +
>  drivers/mmc/core/mmc.c              | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/Documentation/mmc/mmc-dev-attrs.txt b/Documentation/mmc/mmc-dev-attrs.txt
> index 8163eca..404a0e9 100644
> --- a/Documentation/mmc/mmc-dev-attrs.txt
> +++ b/Documentation/mmc/mmc-dev-attrs.txt
> @@ -29,6 +29,7 @@ All attributes are read-only.
>         raw_rpmb_size_mult      RPMB partition size
>         rel_sectors             Reliable write sector count
>         ocr                     Operation Conditions Register
> +       dsr                     Driver Stage Register
>
>  Note on Erase Size and Preferred Erase Size:
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 1848334..4363fdc 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -745,6 +745,22 @@ static ssize_t mmc_fwrev_show(struct device *dev,
>
>  static DEVICE_ATTR(fwrev, S_IRUGO, mmc_fwrev_show, NULL);
>
> +static ssize_t mmc_dsr_show(struct device *dev,
> +                           struct device_attribute *attr,
> +                           char *buf)
> +{
> +       struct mmc_card *card = mmc_dev_to_card(dev);
> +       struct mmc_host *host = card->host;
> +
> +       if (card->csd.dsr_imp && host->dsr_req)
> +               return sprintf(buf, "0x%x\n", host->dsr);
> +       else
> +               /* return default DSR value */
> +               return sprintf(buf, "0x%x\n", 0x404);
> +}
> +
> +static DEVICE_ATTR(dsr, S_IRUGO, mmc_dsr_show, NULL);
> +
>  static struct attribute *mmc_std_attrs[] = {
>         &dev_attr_cid.attr,
>         &dev_attr_csd.attr,
> @@ -764,6 +780,7 @@ static struct attribute *mmc_std_attrs[] = {
>         &dev_attr_raw_rpmb_size_mult.attr,
>         &dev_attr_rel_sectors.attr,
>         &dev_attr_ocr.attr,
> +       &dev_attr_dsr.attr,
>         NULL,
>  };
>  ATTRIBUTE_GROUPS(mmc_std);
> --
> 2.8.0.GIT
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
