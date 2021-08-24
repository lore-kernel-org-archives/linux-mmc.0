Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B2EC4338F
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C857E61357
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237779AbhHXOfW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbhHXOfU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2021 10:35:20 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE96C061764
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 07:34:35 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id c12so38106339ljr.5
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 07:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A3zus4L9/1X3IRfkH/arm7eFOx451ofwKweEFTUHk28=;
        b=NLFfjLxUv2lt5o3iPtPmbMJj2BPSMI6NguDbGQ1cJZ6jjdWqcDt/Qn7nCBGwJuZ1M7
         KvvfhGyyIUJGaf1EN/ahVfRHbGEr5fOVBm2AmO0ooqPHfz620o4CYlPKXMaqngO3J/EQ
         ruSS/zmWSKGZQowOfWWY5gVfN5DFJ2O8Ieer0AULJ4r3u8SKDsP7ENe1E2dSPSFL+L1j
         ou49ivM+LiiZUyDdfDgRZdo57npy+25e9KMt9H5Vs5Yr/0ihsEtBusMvYPs+sC43mRlo
         r0f8gmqkEyJCN/AnImNZ1cnxCMDJTpdKkLM+mZte7tba/UP9u4XA3R7fKi5jbaLO6wns
         /zSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A3zus4L9/1X3IRfkH/arm7eFOx451ofwKweEFTUHk28=;
        b=UHIUv1H1RDOn+JH5mZP/rxxnvRxJ0BIq4rYvuYXksQ3LdGZ0x2D8emEYWgX1cabUkT
         YhG42Y1I7Gd5k3me477SMrPVxfS0an6HExrsNDwoMRt9pISfOg+4SdO2Sbr/QekL/mTy
         CdHDYxOWsQvAkfC3fuAaDcAGa6JTv8IrH3RHD0AewzJTzXNr3l9xQQRLYSXIWMJLRYmE
         Mo9xnm6kt9mVXWKO0Ya4gouFQPmjcOSKLpHJZ7EX36qL1bb25GAokmPiBQWJlwhbew9e
         HcaNGNIlI5UPwfVCgDLrekwM48tnI62xKzQwLP6ueFW2we5+sWLrMOyDaWIv2Wbnqwi/
         77qA==
X-Gm-Message-State: AOAM533SJNEP+KeYT1F/Ea0z/SWLTpmlC8BrbuNgs3aOp5s9a1gGwTlf
        umw1PZllc4HyUmI4KmFLqgej0U6baxPLUqdg8TuYMQ==
X-Google-Smtp-Source: ABdhPJx6jFSFXyIRyp9flVNu2zS1UnWtwBbMkKL1udOoiLVlezBtSgdjUdM2LYVN0fRhALww/4PlSe7dH+C+t3O8hNY=
X-Received: by 2002:a2e:bd09:: with SMTP id n9mr32556182ljq.76.1629815674010;
 Tue, 24 Aug 2021 07:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210817224208.153652-1-huobean@gmail.com> <20210817224208.153652-3-huobean@gmail.com>
In-Reply-To: <20210817224208.153652-3-huobean@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Aug 2021 16:33:58 +0200
Message-ID: <CAPDyKFrQLDiamWZGzDDoA0EeRhR+VaeWuUHiu9EAMqDrQT-5CA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mmc: core: Let BKOPS timeout readable/writable via sysfs
To:     Bean Huo <huobean@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bean Huo <beanhuo@micron.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 18 Aug 2021 at 00:42, Bean Huo <huobean@gmail.com> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> For special cases, the application in the userspace wants to change
> BKOPS operation timeout value, also, wants eMMC back to R1_STATE_TRAN
> after BKOPS timeouts. A fixed BKOPS timeout value(120s) is no longer
> feasible, therefore, it is better to let the user controls its timeout
> value.

I am not fond of exporting tweakable timeout values through sysfs.
Primarily because it's ABI and it becomes difficult to change.

Can you perhaps explain in more detail when you want to have a
different timeout?

Perhaps we can do something similar as we currently do for
mmc_santize(), where we allow userspace to pass the cmd-timeout?

Kind regards
Uffe

>
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> ---
>  drivers/mmc/core/mmc.c     | 32 ++++++++++++++++++++++++++++++++
>  drivers/mmc/core/mmc_ops.c |  3 +--
>  include/linux/mmc/card.h   |  1 +
>  3 files changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 838726b68ff3..617ff18b5b0e 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -29,6 +29,7 @@
>  #define DEFAULT_CMD6_TIMEOUT_MS        500
>  #define MIN_CACHE_EN_TIMEOUT_MS 1600
>  #define CACHE_FLUSH_TIMEOUT_MS 30000 /* 30s */
> +#define MMC_BKOPS_TIMEOUT_MS   (120 * 1000) /* 120s */
>
>  static const unsigned int tran_exp[] = {
>         10000,          100000,         1000000,        10000000,
> @@ -836,6 +837,35 @@ static ssize_t mmc_dsr_show(struct device *dev,
>
>  static DEVICE_ATTR(dsr, S_IRUGO, mmc_dsr_show, NULL);
>
> +static ssize_t bkops_timeout_ms_show(struct device *dev,
> +                                    struct device_attribute *attr, char *buf)
> +{
> +       struct mmc_card *card = mmc_dev_to_card(dev);
> +       return sysfs_emit(buf, "%d\n", card->bkops_timeout_ms);
> +}
> +
> +static ssize_t bkops_timeout_ms_store(struct device *dev,
> +                                     struct device_attribute *attr,
> +                                     const char *buf, size_t len)
> +{
> +       struct mmc_card *card = mmc_dev_to_card(dev);
> +       unsigned int new;
> +       int ret;
> +
> +       ret = kstrtouint(buf, 0, &new);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (new == 0)
> +               return -EINVAL;
> +
> +       card->bkops_timeout_ms = new;
> +
> +       return len;
> +}
> +
> +static DEVICE_ATTR_RW(bkops_timeout_ms);
> +
>  static struct attribute *mmc_std_attrs[] = {
>         &dev_attr_cid.attr,
>         &dev_attr_csd.attr,
> @@ -862,6 +892,7 @@ static struct attribute *mmc_std_attrs[] = {
>         &dev_attr_rca.attr,
>         &dev_attr_dsr.attr,
>         &dev_attr_cmdq_en.attr,
> +       &dev_attr_bkops_timeout_ms.attr,
>         NULL,
>  };
>  ATTRIBUTE_GROUPS(mmc_std);
> @@ -1624,6 +1655,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                 card->ocr = ocr;
>                 card->type = MMC_TYPE_MMC;
>                 card->rca = 1;
> +               card->bkops_timeout_ms = MMC_BKOPS_TIMEOUT_MS;
>                 memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
>         }
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 0c54858e89c0..9af5e4671de2 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -19,7 +19,6 @@
>  #include "host.h"
>  #include "mmc_ops.h"
>
> -#define MMC_BKOPS_TIMEOUT_MS           (120 * 1000) /* 120s */
>  #define MMC_SANITIZE_TIMEOUT_MS                (240 * 1000) /* 240s */
>
>  static const u8 tuning_blk_pattern_4bit[] = {
> @@ -958,7 +957,7 @@ void mmc_run_bkops(struct mmc_card *card)
>          * urgent levels by using an asynchronous background task, when idle.
>          */
>         err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> -                        EXT_CSD_BKOPS_START, 1, MMC_BKOPS_TIMEOUT_MS);
> +                        EXT_CSD_BKOPS_START, 1, card->bkops_timeout_ms);
>         /*
>          * If the BKOPS timed out, the card is probably still busy in the
>          * R1_STATE_PRG. Rather than continue to wait, let's try to abort
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 74e6c0624d27..9e038d212067 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -294,6 +294,7 @@ struct mmc_card {
>
>         bool                    reenable_cmdq;  /* Re-enable Command Queue */
>
> +       unsigned int            bkops_timeout_ms;
>         unsigned int            erase_size;     /* erase size in sectors */
>         unsigned int            erase_shift;    /* if erase unit is power 2 */
>         unsigned int            pref_erase;     /* in sectors */
> --
> 2.25.1
>
