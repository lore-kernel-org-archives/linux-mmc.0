Return-Path: <SRS0=dyeO=7K=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E35C433DF
	for <linux-mmc@archiver.kernel.org>; Thu, 28 May 2020 10:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E852D20707
	for <linux-mmc@archiver.kernel.org>; Thu, 28 May 2020 10:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VAV5oYZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387806AbgE1KPh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 May 2020 06:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387788AbgE1KPa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 May 2020 06:15:30 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEC9C05BD1E
        for <linux-mmc@vger.kernel.org>; Thu, 28 May 2020 03:15:29 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id z12so9496600uap.6
        for <linux-mmc@vger.kernel.org>; Thu, 28 May 2020 03:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BKEIjQJJ2XLguXGcY1rDMpRw0nRNveaRpquZJVMVnN0=;
        b=VAV5oYZPbSfl1mtfwGLOgjRNNdmZXdqLTgn2STY1fmyoFIfKHwiaiNVNx95/Zu3pls
         sv1wgi5AgbjUdWpr8QI0gQCI1FKJPR8UPqejSYWd1J+pjZRAfo+1ZVDVMvwNSpjN/9qL
         2vqaTAf7fmlANLPG6iZyNEVAzs5HlGvn83BSddlMwe9jQ3dfzHP6PBJTOenuzYXv79HA
         cqI/zBUtNNwq/3tCGjVUqjdWe4vfzTlpfzoFI/veMOT+ddmi5gZvtrI8cqR+quC3TGC1
         vO/QkCWmQw54XLR8vsgwYURGI1jl7KhAFrpVZHy52zJCsoRXXILG4gC0PMxtlXJ6KulR
         cLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BKEIjQJJ2XLguXGcY1rDMpRw0nRNveaRpquZJVMVnN0=;
        b=F9qGnrCxkx6521yBGRgBinzuIARoyJTZAXCzTCV+f6xy9V6FgQ3L3GeI4Q3lPXPcuP
         hLEgvRu7WUjGenEqdzl0fHkDczvum1013i0Fqg/qoayW4SoZ0EwsARif4nqvfEmSkfuw
         dZ3ZB2VRw8X2DBWdccxJhCtIR3Gwmv0rmE/HVUKFe1gBjLdfbjHfg1T5G+VBmYUb0r1e
         pB2LGcmoG+vQs5FSe8eQ6fU2ICPZpwdB0N2y/jxgjG4+fES+gdnH2R2ORmKjCOMLpn1l
         bv9sicKcPhRQIt6791/esrvLxEh681SLtVdtIwKXasVWcmTPsyIMgpv5c/fHHZfjkJrj
         bRAg==
X-Gm-Message-State: AOAM530KTjT+efhThtArzv626XWDYNtW/E4yioKjl72ZBVdl8ZLb8C/R
        wDmEceLfTJ7z/DFECrh8FXX6kIZpuWduKEcUVG4gqK0GWMw=
X-Google-Smtp-Source: ABdhPJx8ruuWKsaOFlI5aHqXzRzJdm+MXa3lFs2gDbssBdgU8tMH2X9vljvFTY62HtS3+JpPq7vEx1jfxJxgtoYTohI=
X-Received: by 2002:ab0:70c9:: with SMTP id r9mr1356601ual.15.1590660929116;
 Thu, 28 May 2020 03:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200526154334.21222-2-pali@kernel.org> <20200527110858.17504-1-pali@kernel.org>
 <20200527110858.17504-2-pali@kernel.org>
In-Reply-To: <20200527110858.17504-2-pali@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 May 2020 12:14:51 +0200
Message-ID: <CAPDyKFpgvfzgb4Td+57dRAu95y8fRSF01CBi-PBYNdpm_4-WWQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: core: Export device/vendor ids from Common
 CIS for SDIO cards
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 27 May 2020 at 13:09, Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Device/vendor ids from Common CIS (Card Information Structure) may be
> different as device/vendor ids from CIS on particular SDIO function.
>
> Kernel currently exports only device/vendor ids from SDIO functions and n=
ot
> "main" device/vendor ids from Common CIS.
>
> This patch exports "main" device/vendor ids for SDIO and SD combo cards a=
t
> top level mmc device in sysfs hierarchy.
>
> Userspace can use e.g. udev rules to correctly match whole SDIO card base=
d
> on Common CIS device/vendor id and not only one particular SDIO function.
> Having this information in userspace also helps developers to debug whole
> SDIO card as e.g. kernel mmc quirks use device/vendor ids from Common CIS
> and not from particular SDIO function. Also it allows to write userspace
> applications which list all connected SDIO cards based on CIS ids.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> Reviewed-by: Marek Beh=C3=BAn <marek.behun@nic.cz>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
> Changes in V2:
> * Make sd_std_group static
> * Put more information into commit message
> ---
>  drivers/mmc/core/bus.c  |  7 +++++++
>  drivers/mmc/core/sd.c   | 26 +++++++++++++++++++++++++-
>  drivers/mmc/core/sdio.c | 20 +++++++++++++++++++-
>  3 files changed, 51 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index b1cb447da..70207f11a 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -93,6 +93,13 @@ mmc_bus_uevent(struct device *dev, struct kobj_uevent_=
env *env)
>                         return retval;
>         }
>
> +       if (card->type =3D=3D MMC_TYPE_SDIO || card->type =3D=3D MMC_TYPE=
_SD_COMBO) {
> +               retval =3D add_uevent_var(env, "SDIO_ID=3D%04X:%04X",
> +                                       card->cis.vendor, card->cis.devic=
e);
> +               if (retval)
> +                       return retval;
> +       }
> +
>         /*
>          * SDIO (non-combo) cards are not handled by mmc_block driver and=
 do not
>          * have accessible CID register which used by mmc_card_name() fun=
ction.
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 76c7add36..ee1a51ff6 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -707,7 +707,12 @@ static ssize_t mmc_dsr_show(struct device *dev,
>
>  static DEVICE_ATTR(dsr, S_IRUGO, mmc_dsr_show, NULL);
>
> +MMC_DEV_ATTR(vendor, "0x%04x\n", card->cis.vendor);
> +MMC_DEV_ATTR(device, "0x%04x\n", card->cis.device);
> +
>  static struct attribute *sd_std_attrs[] =3D {
> +       &dev_attr_vendor.attr,
> +       &dev_attr_device.attr,
>         &dev_attr_cid.attr,
>         &dev_attr_csd.attr,
>         &dev_attr_scr.attr,
> @@ -726,7 +731,26 @@ static struct attribute *sd_std_attrs[] =3D {
>         &dev_attr_dsr.attr,
>         NULL,
>  };
> -ATTRIBUTE_GROUPS(sd_std);
> +
> +static umode_t sd_std_is_visible(struct kobject *kobj, struct attribute =
*attr,
> +                                int index)
> +{
> +       struct device *dev =3D container_of(kobj, struct device, kobj);
> +       struct mmc_card *card =3D mmc_dev_to_card(dev);
> +
> +       /* CIS vendor and device ids are available only for Combo cards *=
/
> +       if ((attr =3D=3D &dev_attr_vendor.attr || attr =3D=3D &dev_attr_d=
evice.attr) &&
> +           card->type !=3D MMC_TYPE_SD_COMBO)
> +               return 0;
> +
> +       return attr->mode;
> +}
> +
> +static const struct attribute_group sd_std_group =3D {
> +       .attrs =3D sd_std_attrs,
> +       .is_visible =3D sd_std_is_visible,
> +};
> +__ATTRIBUTE_GROUPS(sd_std);
>
>  struct device_type sd_type =3D {
>         .groups =3D sd_std_groups,
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index ebb387aa5..2d86a9db5 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -27,6 +27,24 @@
>  #include "sdio_ops.h"
>  #include "sdio_cis.h"
>
> +MMC_DEV_ATTR(vendor, "0x%04x\n", card->cis.vendor);
> +MMC_DEV_ATTR(device, "0x%04x\n", card->cis.device);
> +MMC_DEV_ATTR(ocr, "0x%08x\n", card->ocr);
> +MMC_DEV_ATTR(rca, "0x%04x\n", card->rca);
> +
> +static struct attribute *sdio_std_attrs[] =3D {
> +       &dev_attr_vendor.attr,
> +       &dev_attr_device.attr,
> +       &dev_attr_ocr.attr,
> +       &dev_attr_rca.attr,
> +       NULL,
> +};
> +ATTRIBUTE_GROUPS(sdio_std);
> +
> +static struct device_type sdio_type =3D {
> +       .groups =3D sdio_std_groups,
> +};
> +
>  static int sdio_read_fbr(struct sdio_func *func)
>  {
>         int ret;
> @@ -598,7 +616,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, =
u32 ocr,
>         /*
>          * Allocate card structure.
>          */
> -       card =3D mmc_alloc_card(host, NULL);
> +       card =3D mmc_alloc_card(host, &sdio_type);
>         if (IS_ERR(card)) {
>                 err =3D PTR_ERR(card);
>                 goto err;
> --
> 2.20.1
>
