Return-Path: <SRS0=Im6a=45=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6325EC2BB1D
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 16:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7F22071C
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 16:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oCQZb+GF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgCLQCy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Mar 2020 12:02:54 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:40769 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbgCLQCy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Mar 2020 12:02:54 -0400
Received: by mail-vk1-f195.google.com with SMTP id k63so1718461vka.7
        for <linux-mmc@vger.kernel.org>; Thu, 12 Mar 2020 09:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hf3bjyDMd8ksot/S8GxWuRCf4BHQlE9gJbI13xPJZ3s=;
        b=oCQZb+GFZx3OkvymlCmpxvLCkSF7X63HTCwXC7L59gaA+gIuUQ9O7w5b4B80QIPhRn
         aOQyns+vVx6SQeBRCxheKkTHwfni0IKj3Z53rxhBM+pB8smc6rMz+2k/d8gmnDQsgCre
         Wp96aCrzy9TALc6xA0gSOvwas/M8sBzUEhpGVgJh3mi8x08DZbmLVvBtJUMnDB5qwFG/
         O/bbiwYoyYCMK5A53Q006XfGayxilIlN32XD76iBW2S/m5Pz45N3TAuNzG/jswytsXhp
         lj44mbXSZSXpt75UUJ59BRply2Y8waGvMDHNw07BnxeBO22DmNWQ5z5H8csWgoHM6TY9
         wA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hf3bjyDMd8ksot/S8GxWuRCf4BHQlE9gJbI13xPJZ3s=;
        b=FN287fX+5amGU2n88e4JfSNi77jRjqtrR1fJx4Vh5TDkl26fwtZ1ek7XoGQFtyjVEY
         W8q9OwSFdL20MSwtUmN5XKs4Gtn4F5VdYKBayGIeM72TNkfpPVzmea46GiJa9y4rg2UY
         3O1r2ToeQ7kr2bWdfzts6eaz+35pQJM3+meEhL26NEFvRvxyCdzbpMmoTh8BWH2a7bFV
         384p93Qi51ygZ5TpVzNJ6EGR6qy192T90EC4BvIy05qyT+U2zWowR6tTvXebpPlanjwv
         peSX8YPBQFKBkhshMa6TAQEWvV+eiwkEF7wduJP8sKw79HtEy8QL8p3xkEi3pUUTyHNZ
         kFAw==
X-Gm-Message-State: ANhLgQ3REKrc++KK31UXdPjnyevDdwhmVcbHjWBPSB51UgvtDB2c38wD
        dXQ7jI6gv9QckZutKgw649KNvf4SRR/SsrKdmMIGjw==
X-Google-Smtp-Source: ADFU+vuqphbaV1Dc45Az5Tu1YBqEzn/9z0SpAENYMlXGk19jh5sQFclaN4idolRXdBcumhfdo7QfSEufrsZvdgLUBhQ=
X-Received: by 2002:a1f:b695:: with SMTP id g143mr5837231vkf.59.1584028973369;
 Thu, 12 Mar 2020 09:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200312142501.9868-1-adrian.hunter@intel.com> <20200312142501.9868-3-adrian.hunter@intel.com>
In-Reply-To: <20200312142501.9868-3-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 12 Mar 2020 17:02:17 +0100
Message-ID: <CAPDyKFoMSXq=HDH7u+SMMp9Q4-RLDMq2QigLoyg-0o+FgSxHUw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] mmc: core: Do not check CRC response for switch
 from HS400 to HS200
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Kyungmin Seo <kyungmin.seo@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 12 Mar 2020 at 15:25, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Switching from HS400 to HS200 may experience CRC errors. Do not check
> CRC response in that case.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---

[...]

> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 619088a94688..2baaa66e491d 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -552,12 +552,13 @@ int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
>   *     @timing: new timing to change to
>   *     @send_status: send status cmd to poll for busy
>   *     @retry_crc_err: retry when CRC errors when polling with CMD13 for busy
> + *     @no_crc_resp: do not require to check CRC response
>   *
>   *     Modifies the EXT_CSD register for selected card.
>   */
>  int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>                 unsigned int timeout_ms, unsigned char timing,
> -               bool send_status, bool retry_crc_err)
> +               bool send_status, bool retry_crc_err, bool no_crc_resp)
>  {
>         struct mmc_host *host = card->host;
>         int err;
> @@ -594,6 +595,8 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>         } else {
>                 cmd.flags |= MMC_RSP_SPI_R1 | MMC_RSP_R1;
>         }
> +       if (no_crc_resp)
> +               cmd.flags &= ~MMC_RSP_CRC;

So potentially this means the host driver will complete the command
successfully, even if it receives a CRC error.

As I understood it, the idea was to poll for busy, *if* we encountered
CRC errors, so then how would you know about that?

Seems like we should drop the above code and be checking for -EILSEQ
of the request instead? No?

>
>         if (index == EXT_CSD_SANITIZE_START)
>                 cmd.sanitize_busy = true;
> @@ -639,7 +642,7 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>                 unsigned int timeout_ms)
>  {
>         return __mmc_switch(card, set, index, value, timeout_ms, 0,
> -                           true, false);
> +                           true, false, false);
>  }
>  EXPORT_SYMBOL_GPL(mmc_switch);
>
> diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
> index 38dcfeeaf6d5..1a75c347b8a7 100644
> --- a/drivers/mmc/core/mmc_ops.h
> +++ b/drivers/mmc/core/mmc_ops.h
> @@ -40,7 +40,7 @@ int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
>                       enum mmc_busy_cmd busy_cmd);
>  int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>                 unsigned int timeout_ms, unsigned char timing,
> -               bool send_status, bool retry_crc_err);
> +               bool send_status, bool retry_crc_err, bool no_crc_resp);
>  int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>                 unsigned int timeout_ms);
>  void mmc_run_bkops(struct mmc_card *card);
> --
> 2.17.1
>

Kind regards
Uffe
