Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F14C433E0
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F299364E60
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238814AbhCCBqt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Mar 2021 20:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383168AbhCBKrU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Mar 2021 05:47:20 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD59C061756
        for <linux-mmc@vger.kernel.org>; Tue,  2 Mar 2021 02:46:39 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id j188so4294826vke.13
        for <linux-mmc@vger.kernel.org>; Tue, 02 Mar 2021 02:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ef2O5NL0Jf/SRcnD4ZQcM2BLQkBkWgDo+EABNwcEgQQ=;
        b=famOJKdlx+UgKQfiiMCahDIqboeS5/AwttgLlvF4FmUgRqusCcztXGTTaeBWPNwAeZ
         ERRMW6QNNYL+VV+aKS9Yw2dWodpkMZ9jGpCXkOK1NuvC5mP2ReEzuR/GLV4OA76DIvSh
         +DwttiBCZRziMKWu0SzS6rcpwpKSMlott2irTrJSOPpholxqAXDbXHwJGHjr96XpfUE/
         iJHdW+hqU5DltrC7QCTirLL6LiBDv3ZLRX86d0Tdi25k0dZWSf1IwSqUJEZs+56cR+Bp
         EA5ktx+ZgegT1XPw7yEFwLjxbtX5Cw+PlDRAygQqCb3bOl9eQ9r+mfznvkkH0Di+5Lwo
         eOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ef2O5NL0Jf/SRcnD4ZQcM2BLQkBkWgDo+EABNwcEgQQ=;
        b=S8Gr/xVrvalX7VqqsRr1IFV78NUrf/IHDjEBdyv9cLA2HMko9OuSF0UaLE3yIAZnjV
         XisD1o/kmZdxSy694a+BqK5Ykz8aZBRK6pgeaX6nsBJfQmHanI2Jj0dAFKOrtFDGXdyw
         pjW1B8kqWag1oWexoQzm48+hbdAUBAkk8+Wz0D9HpQpqpPr3ClDXlWAe1AtKHWF569Tj
         bulhfLQxmlO6BywC4fLAXI+rub7PzERZMIJvSyDsFUKNagZ4ACJ7dyjInv+Hp81vPqma
         i5MGeb8gRHaL3Wgo9U57oB7FIi+TI1VpFNFfUzN7wNQFoEkBoKL0rHA+1DLqIoLGRpXc
         g+xQ==
X-Gm-Message-State: AOAM5322nBPfCVEf9UqNKWDf0WuJ7lAZ9qOWmCztxcQOs38tepZkhbVi
        +uLIuJXwEs6zzU/rvdCmce9hfItUSrQX2KrYHGAL2Q==
X-Google-Smtp-Source: ABdhPJy1RoI+P6DlS4SxWqy8KSOQ/Tn5qyIUdL/+aV/m6/WFfzv0Bc/lRV5U8HFtTb0pi5UBEspCt9doY3PZkLWQFmg=
X-Received: by 2002:a05:6122:7c7:: with SMTP id l7mr1417814vkr.6.1614681998332;
 Tue, 02 Mar 2021 02:46:38 -0800 (PST)
MIME-Version: 1.0
References: <20210215003249.GA12303@lupo-laptop>
In-Reply-To: <20210215003249.GA12303@lupo-laptop>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 2 Mar 2021 11:46:02 +0100
Message-ID: <CAPDyKFou4VdtUV66-c8y_tV9g9oaUCa8nphsLW6gH0_bi7y_dA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] Make cmdq_en attribute writeable
To:     Luca Porzio <porzio@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Zhan Liu <zliua@micron.com>, Luca Porzio <lporzio@micron.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Adrian

On Mon, 15 Feb 2021 at 01:33, Luca Porzio <porzio@gmail.com> wrote:
>
> cmdq_en attribute in sysfs now can now be written.
> When 0 is written:
>   CMDQ is disabled and kept disabled across device reboots.
> When 1 is written:
>   CMDQ mode is instantly reneabled (if supported).
>
> Signed-off-by: Luca Porzio <lporzio@micron.com>
> Signed-off-by: Zhan Liu <zliua@micron.com>

Luca, thanks for your patch! I am about to start to review this.

I have also looped in Adrian to get his opinions.

Get back to you soon!

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc.c   | 152 ++++++++++++++++++++++++++++++---------
>  include/linux/mmc/card.h |   1 +
>  2 files changed, 118 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 0d80b72ddde8..5c7d5bac5c00 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -794,7 +794,120 @@ MMC_DEV_ATTR(enhanced_rpmb_supported, "%#x\n",
>  MMC_DEV_ATTR(rel_sectors, "%#x\n", card->ext_csd.rel_sectors);
>  MMC_DEV_ATTR(ocr, "0x%08x\n", card->ocr);
>  MMC_DEV_ATTR(rca, "0x%04x\n", card->rca);
> -MMC_DEV_ATTR(cmdq_en, "%d\n", card->ext_csd.cmdq_en);
> +
> +
> +/* Setup command queue mode and CQE if underling hw supports it
> + * and assuming force_disable_cmdq has not been set.
> + */
> +static int mmc_cmdq_setup(struct mmc_host *host, struct mmc_card *card)
> +{
> +       int err;
> +
> +       /* Check HW support */
> +       if (!card->ext_csd.cmdq_support || !(host->caps2 & MMC_CAP2_CQE))
> +               card->force_disable_cmdq = true;
> +
> +       /* Enable/Disable  CMDQ mode */
> +       if (!card->ext_csd.cmdq_en && !card->force_disable_cmdq) {
> +               err = mmc_cmdq_enable(card);
> +               if (err && err != -EBADMSG)
> +                       return err;
> +               if (err) {
> +                       pr_warn("%s: Enabling CMDQ failed\n",
> +                           mmc_hostname(card->host));
> +                       card->ext_csd.cmdq_support = false;
> +                       card->ext_csd.cmdq_depth = 0;
> +               }
> +
> +       } else if (card->ext_csd.cmdq_en && card->force_disable_cmdq) {
> +               err = mmc_cmdq_disable(card);
> +               if (err) {
> +                       pr_warn("%s: Disabling CMDQ failed, error %d\n",
> +                           mmc_hostname(card->host), err);
> +                       err = 0;
> +               }
> +       }
> +
> +       /*
> +        * In some cases (e.g. RPMB or mmc_test), the Command Queue must be
> +        * disabled for a time, so a flag is needed to indicate to re-enable the
> +        * Command Queue.
> +        */
> +       card->reenable_cmdq = card->ext_csd.cmdq_en;
> +
> +       /* Enable/Disable Host CQE */
> +       if (!card->force_disable_cmdq) {
> +
> +               if (host->cqe_ops && !host->cqe_enabled) {
> +                       err = host->cqe_ops->cqe_enable(host, card);
> +                       if (!err) {
> +                               host->cqe_enabled = true;
> +
> +                               if (card->ext_csd.cmdq_en) {
> +                                       pr_info("%s: Command Queue Engine enabled\n",
> +                                           mmc_hostname(host));
> +                               } else {
> +                                       host->hsq_enabled = true;
> +                                       pr_info("%s: Host Software Queue enabled\n",
> +                                           mmc_hostname(host));
> +                               }
> +                       }
> +               }
> +
> +       } else {
> +
> +               if (host->cqe_enabled) {
> +                       host->cqe_ops->cqe_disable(host);
> +                       host->cqe_enabled = false;
> +                       pr_info("%s: Command Queue Engine disabled\n",
> +                           mmc_hostname(host));
> +               }
> +
> +               host->hsq_enabled = false;
> +               err = 0;
> +       }
> +
> +       return err;
> +}
> +
> +
> +static ssize_t cmdq_en_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +       struct mmc_card *card = mmc_dev_to_card(dev);
> +
> +       return sprintf(buf, "%d\n", card->ext_csd.cmdq_en);
> +}
> +
> +static ssize_t cmdq_en_store(struct device *dev, struct device_attribute *attr,
> +                                const char *buf, size_t count)
> +{
> +       struct mmc_card *card = mmc_dev_to_card(dev);
> +       struct mmc_host *host = card->host;
> +       unsigned long enable;
> +       int err;
> +
> +       if (!card || kstrtoul(buf, 0, &enable))
> +               return -EINVAL;
> +       if (!card->ext_csd.cmdq_support)
> +               return -EOPNOTSUPP;
> +
> +       enable = !!enable;
> +       if (enable == card->ext_csd.cmdq_en)
> +               return count;
> +
> +       mmc_get_card(card, NULL);
> +       card->force_disable_cmdq = !enable;
> +       err = mmc_cmdq_setup(host, card);
> +       mmc_put_card(card, NULL);
> +
> +       if (err)
> +               return err;
> +       else
> +               return count;
> +}
> +
> +static DEVICE_ATTR_RW(cmdq_en);
> +
>
>  static ssize_t mmc_fwrev_show(struct device *dev,
>                               struct device_attribute *attr,
> @@ -1838,40 +1951,9 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>          * Enable Command Queue if supported. Note that Packed Commands cannot
>          * be used with Command Queue.
>          */
> -       card->ext_csd.cmdq_en = false;
> -       if (card->ext_csd.cmdq_support && host->caps2 & MMC_CAP2_CQE) {
> -               err = mmc_cmdq_enable(card);
> -               if (err && err != -EBADMSG)
> -                       goto free_card;
> -               if (err) {
> -                       pr_warn("%s: Enabling CMDQ failed\n",
> -                               mmc_hostname(card->host));
> -                       card->ext_csd.cmdq_support = false;
> -                       card->ext_csd.cmdq_depth = 0;
> -               }
> -       }
> -       /*
> -        * In some cases (e.g. RPMB or mmc_test), the Command Queue must be
> -        * disabled for a time, so a flag is needed to indicate to re-enable the
> -        * Command Queue.
> -        */
> -       card->reenable_cmdq = card->ext_csd.cmdq_en;
> -
> -       if (host->cqe_ops && !host->cqe_enabled) {
> -               err = host->cqe_ops->cqe_enable(host, card);
> -               if (!err) {
> -                       host->cqe_enabled = true;
> -
> -                       if (card->ext_csd.cmdq_en) {
> -                               pr_info("%s: Command Queue Engine enabled\n",
> -                                       mmc_hostname(host));
> -                       } else {
> -                               host->hsq_enabled = true;
> -                               pr_info("%s: Host Software Queue enabled\n",
> -                                       mmc_hostname(host));
> -                       }
> -               }
> -       }
> +       err = mmc_cmdq_setup(host, card);
> +       if (err)
> +               goto free_card;
>
>         if (host->caps2 & MMC_CAP2_AVOID_3_3V &&
>             host->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index f9ad35dd6012..e554bb0cf722 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -272,6 +272,7 @@ struct mmc_card {
>  #define MMC_QUIRK_BROKEN_HPI   (1<<13)         /* Disable broken HPI support */
>
>         bool                    reenable_cmdq;  /* Re-enable Command Queue */
> +       bool                    force_disable_cmdq; /* Keep Command Queue disabled */
>
>         unsigned int            erase_size;     /* erase size in sectors */
>         unsigned int            erase_shift;    /* if erase unit is power 2 */
> --
> 2.17.1
>
