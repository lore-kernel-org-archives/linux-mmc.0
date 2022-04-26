Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440B3C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Apr 2022 22:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243596AbiDZWoE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Apr 2022 18:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344279AbiDZWoB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2022 18:44:01 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762BE24BEE
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2022 15:40:51 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x17so83764lfa.10
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2022 15:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=biobxbArxCFnV7SkOqCZoDDVkLOu3kKmDY8PEIpBlo0=;
        b=M9LULXxGSCNnLCd8cz6+jw+CCZa6E2LlfApK6H8owjcwzjtavjcTEG3czC9d4vlYsx
         G46QKRj+RsxxwHH9u6RjiTJN0nzWPJy+2Zs+2HIH94lOn//Qxr/OO6iUWV6g5N1/IKpe
         w9zDj62sp9jErudaMnTTracHzlLA6zART5rioHL6Y+wvLWsNbtlvCB439mljB6aaAqE4
         qvYhzGJ5ivke23v0rsFicpuskqu5zarS7J36ezy8ym+0HjX1OsOFfiqtIUzSTz6q172S
         iU4Z3ildcsot3NvqEdNpF3NFLH26wLJv3j/U7cCsrSathz+M1dLGaeqWRu3Qe4xaaQ7t
         rsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=biobxbArxCFnV7SkOqCZoDDVkLOu3kKmDY8PEIpBlo0=;
        b=QXYet4mKOTQhitz4+lkbJZnEeO7miJNzC3wS48PNjqxR7Z3lntAJU3Wbxz731BNra4
         DQmpV+q+ornVIJotZxG2Qj/rszfd7UxwCIcG+vMt+sBVyQKIS4/RpI0hVhe40I64SlFw
         1X5g74vJ7KDyaEsuPFJXDhosERJw5HOpGfrDXHk07GH9+nzmC8Ixj7EfjWBIWWvL4IVG
         hFMY0R3LPPskiYJiSukZONH7LkKb9JboRGd1HAZ2TSKb8lH4Kf4cCPQAyGOUuTlLqYMr
         3FRHh4m2ro7dju4lR146N3BV754Car57viALbFErgjfmKA1g/paXOiE63SWaUQ2gjEo8
         4ShA==
X-Gm-Message-State: AOAM533PNJpVXsWUqzfdA70iYy5hwLlOGebAfDbvnkR8HsZ8uyQoEo6y
        UOLTROeD5Psde1u8TIliJK5w7lqIwQ+TsNP7O+yiqA==
X-Google-Smtp-Source: ABdhPJyhfk4rCuEowaImYKv2c8HGRdv2m6BsDVErkDWH2TMfvsipsBdzt20Vg/ITAOdCUiIf6B02XDj/rTSk3lau+hQ=
X-Received: by 2002:a05:6512:2627:b0:44a:f55c:ded9 with SMTP id
 bt39-20020a056512262700b0044af55cded9mr18506377lfb.373.1651012849709; Tue, 26
 Apr 2022 15:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <1650969330-9711-1-git-send-email-quic_spathi@quicinc.com>
In-Reply-To: <1650969330-9711-1-git-send-email-quic_spathi@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Apr 2022 00:40:13 +0200
Message-ID: <CAPDyKFqOcQjGOQp=c8+ChRU=LhjoOpz95H+VE_eas42uSv8Rgg@mail.gmail.com>
Subject: Re: [PATCH V1] FROMLIST: mmc: core: Export core functions required
 for clk scaling
To:     Srinivasarao Pathipati <quic_spathi@quicinc.com>
Cc:     digetx@gmail.com, axboe@kernel.dk, quic_kamasali@quicinc.com,
        quic_nitirawa@quicinc.com, avri.altman@wdc.com,
        quic_merez@quicinc.com, s.shtylyov@omp.ru,
        quic_sayalil@quicinc.com, colyli@suse.de, cw9316.lee@samsung.com,
        dsterba@suse.com, joel@jms.id.au, quic_sbhanu@quicinc.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        Nitin Rawat <nitirawa@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 26 Apr 2022 at 12:43, Srinivasarao Pathipati
<quic_spathi@quicinc.com> wrote:
>
> From: Ram Prakash Gupta <rampraka@codeaurora.org>
>
> Export core function required for clk scaling post design change.
> This would help make clk scaling part of vendor module.
>
> Bug: 192337957
> Link: https://lore.kernel.org/lkml/1571668177-3766-2-git-send-email-
> rampraka@codeaurora.org/
> Signed-off-by: Nitin Rawat <nitirawa@codeaurora.org>
> Signed-off-by: Ram Prakash Gupta <rampraka@codeaurora.org>
>
> Signed-off-by: kamasali <quic_kamasali@quicinc.com>
> Signed-off-by: Srinivasarao Pathipati <quic_spathi@quicinc.com>

NAK. These are all internal functions of the mmc core.

Without knowing about the details of why you need this, I can't really
help. Can you try to explain the use case behind this in more detail?

Kind regards
Uffe

> ---
>  drivers/mmc/core/core.c  |  3 +++
>  drivers/mmc/core/core.h  |  2 +-
>  drivers/mmc/core/mmc.c   | 20 +++++++++++++-------
>  drivers/mmc/core/queue.c |  1 +
>  include/linux/mmc/mmc.h  |  9 +++++++++
>  5 files changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 8cc2b74..7fc77d1 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -920,6 +920,7 @@ void mmc_set_clock(struct mmc_host *host, unsigned int hz)
>         host->ios.clock = hz;
>         mmc_set_ios(host);
>  }
> +EXPORT_SYMBOL_GPL(mmc_set_clock);
>
>  int mmc_execute_tuning(struct mmc_card *card)
>  {
> @@ -1003,6 +1004,7 @@ void mmc_set_initial_state(struct mmc_host *host)
>
>         mmc_crypto_set_initial_state(host);
>  }
> +EXPORT_SYMBOL_GPL(mmc_set_initial_state);
>
>  /**
>   * mmc_vdd_to_ocrbitnum - Convert a voltage to the OCR bit number
> @@ -1266,6 +1268,7 @@ void mmc_set_timing(struct mmc_host *host, unsigned int timing)
>         host->ios.timing = timing;
>         mmc_set_ios(host);
>  }
> +EXPORT_SYMBOL_GPL(mmc_set_timing);
>
>  /*
>   * Select appropriate driver type for host.
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index f5f3f62..a086152 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -42,7 +42,7 @@ struct device_node *mmc_of_find_child_device(struct mmc_host *host,
>  void mmc_init_erase(struct mmc_card *card);
>
>  void mmc_set_chip_select(struct mmc_host *host, int mode);
> -void mmc_set_clock(struct mmc_host *host, unsigned int hz);
> +extern void mmc_set_clock(struct mmc_host *host, unsigned int hz);
>  void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode);
>  void mmc_set_bus_width(struct mmc_host *host, unsigned int width);
>  u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index b4bcebc..2a642fc 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -975,7 +975,7 @@ static int mmc_select_powerclass(struct mmc_card *card)
>  /*
>   * Set the bus speed for the selected speed mode.
>   */
> -static void mmc_set_bus_speed(struct mmc_card *card)
> +void mmc_set_bus_speed(struct mmc_card *card)
>  {
>         unsigned int max_dtr = (unsigned int)-1;
>
> @@ -995,7 +995,7 @@ static void mmc_set_bus_speed(struct mmc_card *card)
>   * If the bus width is changed successfully, return the selected width value.
>   * Zero is returned instead of error value if the wide width is not supported.
>   */
> -static int mmc_select_bus_width(struct mmc_card *card)
> +int mmc_select_bus_width(struct mmc_card *card)
>  {
>         static unsigned ext_csd_bits[] = {
>                 EXT_CSD_BUS_WIDTH_8,
> @@ -1060,11 +1060,12 @@ static int mmc_select_bus_width(struct mmc_card *card)
>
>         return err;
>  }
> +EXPORT_SYMBOL_GPL(mmc_select_bus_width);
>
>  /*
>   * Switch to the high-speed mode
>   */
> -static int mmc_select_hs(struct mmc_card *card)
> +int mmc_select_hs(struct mmc_card *card)
>  {
>         int err;
>
> @@ -1078,11 +1079,12 @@ static int mmc_select_hs(struct mmc_card *card)
>
>         return err;
>  }
> +EXPORT_SYMBOL_GPL(mmc_select_hs);
>
>  /*
>   * Activate wide bus and DDR if supported.
>   */
> -static int mmc_select_hs_ddr(struct mmc_card *card)
> +int mmc_select_hs_ddr(struct mmc_card *card)
>  {
>         struct mmc_host *host = card->host;
>         u32 bus_width, ext_csd_bits;
> @@ -1151,8 +1153,9 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
>
>         return err;
>  }
> +EXPORT_SYMBOL_GPL(mmc_select_hs_ddr);
>
> -static int mmc_select_hs400(struct mmc_card *card)
> +int mmc_select_hs400(struct mmc_card *card)
>  {
>         struct mmc_host *host = card->host;
>         unsigned int max_dtr;
> @@ -1246,6 +1249,7 @@ static int mmc_select_hs400(struct mmc_card *card)
>                __func__, err);
>         return err;
>  }
> +EXPORT_SYMBOL_GPL(mmc_select_hs400);
>
>  int mmc_hs200_to_hs400(struct mmc_card *card)
>  {
> @@ -1524,7 +1528,7 @@ static int mmc_select_hs200(struct mmc_card *card)
>  /*
>   * Activate High Speed, HS200 or HS400ES mode if supported.
>   */
> -static int mmc_select_timing(struct mmc_card *card)
> +int mmc_select_timing(struct mmc_card *card)
>  {
>         int err = 0;
>
> @@ -1559,12 +1563,13 @@ static int mmc_select_timing(struct mmc_card *card)
>         mmc_set_bus_speed(card);
>         return 0;
>  }
> +EXPORT_SYMBOL_GPL(mmc_select_timing);
>
>  /*
>   * Execute tuning sequence to seek the proper bus operating
>   * conditions for HS200 and HS400, which sends CMD21 to the device.
>   */
> -static int mmc_hs200_tuning(struct mmc_card *card)
> +int mmc_hs200_tuning(struct mmc_card *card)
>  {
>         struct mmc_host *host = card->host;
>
> @@ -1579,6 +1584,7 @@ static int mmc_hs200_tuning(struct mmc_card *card)
>
>         return mmc_execute_tuning(card);
>  }
> +EXPORT_SYMBOL_GPL(mmc_hs200_tuning);
>
>  /*
>   * Handle the detection and initialisation of a card.
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 7b07520..cb679a7 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -68,6 +68,7 @@ enum mmc_issue_type mmc_issue_type(struct mmc_queue *mq, struct request *req)
>
>         return MMC_ISSUE_SYNC;
>  }
> +EXPORT_SYMBOL_GPL(mmc_issue_type);
>
>  static void __mmc_cqe_recovery_notifier(struct mmc_queue *mq)
>  {
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index d9a65c6..2884634 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -449,4 +449,13 @@ static inline bool mmc_ready_for_data(u32 status)
>
>  #define mmc_driver_type_mask(n)                (1 << (n))
>
> +struct mmc_card;
> +
> +extern int mmc_select_bus_width(struct mmc_card *card);
> +extern int mmc_select_hs(struct mmc_card *card);
> +extern int mmc_select_hs_ddr(struct mmc_card *card);
> +extern int mmc_select_hs400(struct mmc_card *card);
> +extern int mmc_hs200_tuning(struct mmc_card *card);
> +extern int mmc_select_timing(struct mmc_card *card);
> +
>  #endif /* LINUX_MMC_MMC_H */
> --
> 2.7.4
>
