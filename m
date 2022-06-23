Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99BCC433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Jun 2022 13:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbiFWNyW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Jun 2022 09:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiFWNyV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Jun 2022 09:54:21 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01373190B
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jun 2022 06:54:19 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id f39so17856560lfv.3
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jun 2022 06:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tfyugb+VK3SgQwCDhaT7lGAM/LqJxpybK+Hc9WzFhzQ=;
        b=mQzYdMV1CCi2YOP1mcnFFsH2intAb3xNeNh4JQJqOcnCrvbR3FHp1x8Y69dLYpT6NK
         QPsAOC73P/q95/mm+3RG7i6fcO2LNzzQeasKQG9g1tGBUfX9eyYiPI8ut2wI+5b9XYys
         CwL1HtPmzRUhyx1gxrB6LzROBvt81qCeaHVsyk1OqWIBETj+BDvrXT4BCtj/y2UExvLW
         7gFcUIbPjCSY85mR+fzeyubdtrMYJEKfIXl+I/yE2GaTNndWs+dixFP85jEUuZwYXNpf
         PKwTxKxqPobcDyh2Ql3zd52Bhd2zm58McIIkMEfYsHNE3rdm689o9R8tDvTw3BaIxJBA
         fIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tfyugb+VK3SgQwCDhaT7lGAM/LqJxpybK+Hc9WzFhzQ=;
        b=CgvuoElrF4gD4x21k+tLw3Ip0ylO36fxZ1p38kwuzw7AyMfQDkBx0co3quA71ettuo
         Dtmor7kkE+/6XX2f6qsqOwlue8YqBXNPfeewkz1kBExkWD0l9c9b02dwqSLdq00iD4Nq
         Ct8tFO99meTqJ6wFEy5sQE6daRWIUmJrK7pZJEPX21BKBthp1PgbzUqLsLUB/zTFjTNc
         JEMCSgBmHqtWr6teX6syn2g2I90sb9ksB+wwm5ubNwQ5QC/IAsJDYHVjLyQbuzhhIT7A
         N6u1uNiC3IpWGUEDGjmN4pBfQ0T7XUFmFfNaEubpUrEbs8vWSjhZKuoVqk7dCwpyXIpt
         zTqQ==
X-Gm-Message-State: AJIora96Vgeg0kkzWRvqlaI8SCAA7Ilz7O08NUtnVR/GjFedJtticaXI
        7IhEm1i4+OlT+8KWwosjKCyf7cm33ClamMmb6WHMxg==
X-Google-Smtp-Source: AGRyM1uFayviSfvWLDlRHgU6O1QCdl6DS51+zpC7nX7dalGdEzTq2NeLL8I42F7LNZxAdS3PrNXFat9Oy0e+B1LmL1g=
X-Received: by 2002:a05:6512:3054:b0:47f:7bb1:2fd2 with SMTP id
 b20-20020a056512305400b0047f7bb12fd2mr5547605lfb.71.1655992458169; Thu, 23
 Jun 2022 06:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220623080009.1775574-1-vincent.whitchurch@axis.com>
In-Reply-To: <20220623080009.1775574-1-vincent.whitchurch@axis.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Jun 2022 15:53:41 +0200
Message-ID: <CAPDyKFpg9Gs3qOeXWM2A1gSDEKA89i72NoTcF0M_a3jO-AC+dw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Allow speed modes to be adjusted via module param
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     kernel@axis.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 23 Jun 2022 at 10:00, Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> During board verification, there is a need to test the various supported
> eMMC/SD speed modes.  However, since the framework chooses the best mode
> supported by the card and the host controller's caps, this currently
> necessitates changing the devicetree for every iteration.
>
> To make changing the modes easier, allow the various host controller
> capabilities to be cleared via a module parameter.  (A per-controller
> debugfs wouldn't work since the controller needs to be re-probed to
> trigger re-init of cards.  A module parameter is used instead of a

I think we could make use of a per-controller debugfs thing, if used
in combination with MMC_CAP_AGGRESSIVE_PM and runtime PM.

As runtime PM also has sysfs interface for each device, we can control
runtime PM for the card's device (to trigger re-initialization of the
card). In between runtime suspend/resume of the card's device, we
should be able to change the supported speed modes, through debug fs.

Would this work for you?

Kind regards
Uffe

> global debugfs to allow this to be also set via the kernel command
> line.)
>
> The values to be written are the raw MMC_CAP* values from
> include/linux/mmc/host.h.  This is rather low-level, and these defines
> are not guaranteed to be stable, but it is perhaps good enough for the
> indented use case.  A warning is emitted when the caps clearing is in
> effect.
>
> Example of use:
>
>  # grep timing /sys/kernel/debug/mmc0/ios
>  timing spec:   9 (mmc HS200)
>
>  // MMC_CAP2_HS200_1_8V_SDR
>  # echo $((1 << 5)) > /sys/module/mmc_core/parameters/caps2_clear
>
>  # echo 16d40000.mmc > /sys/bus/platform/drivers/dwmmc_exynos/unbind
>  # echo 16d40000.mmc > /sys/bus/platform/drivers/dwmmc_exynos/bind
>  # grep timing /sys/kernel/debug/mmc0/ios
>  timing spec:   8 (mmc DDR52)
>
>  // MMC_CAP_1_8V_DDR
>  # echo $((1 << 12)) > /sys/module/mmc_core/parameters/caps_clear
>
>  # echo 16d40000.mmc > /sys/bus/platform/drivers/dwmmc_exynos/unbind
>  # echo 16d40000.mmc > /sys/bus/platform/drivers/dwmmc_exynos/bind
>  # grep timing /sys/kernel/debug/mmc0/ios
>  timing spec:   1 (mmc high-speed)
>
>  # echo 0 > /sys/module/mmc_core/parameters/caps2_clear
>
>  # echo 16d40000.mmc > /sys/bus/platform/drivers/dwmmc_exynos/unbind
>  # echo 16d40000.mmc > /sys/bus/platform/drivers/dwmmc_exynos/bind
>  # grep timing /sys/kernel/debug/mmc0/ios
>  timing spec:   9 (mmc HS200)
>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/mmc/core/host.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 2ed2b4d5e5a5..37971b7c7f62 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -34,6 +34,10 @@
>  #define cls_dev_to_mmc_host(d) container_of(d, struct mmc_host, class_dev)
>
>  static DEFINE_IDA(mmc_host_ida);
> +static unsigned int caps_clear, caps2_clear;
> +
> +module_param(caps_clear, uint, 0644);
> +module_param(caps2_clear, uint, 0644);
>
>  #ifdef CONFIG_PM_SLEEP
>  static int mmc_host_class_prepare(struct device *dev)
> @@ -411,6 +415,14 @@ int mmc_of_parse(struct mmc_host *host)
>                 host->caps2 &= ~(MMC_CAP2_HS400_1_8V | MMC_CAP2_HS400_1_2V |
>                                  MMC_CAP2_HS400_ES);
>
> +       if (caps_clear || caps2_clear)
> +               dev_warn(host->parent,
> +                        "clearing host controller caps %#x caps2 %#x\n",
> +                        caps_clear, caps2_clear);
> +
> +       host->caps &= ~caps_clear;
> +       host->caps2 &= ~caps2_clear;
> +
>         /* Must be after "non-removable" check */
>         if (device_property_read_u32(dev, "fixed-emmc-driver-type", &drv_type) == 0) {
>                 if (host->caps & MMC_CAP_NONREMOVABLE)
> --
> 2.34.1
>
