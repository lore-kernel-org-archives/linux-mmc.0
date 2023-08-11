Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82648C001B0
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Aug 2023 10:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbjHKKq1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Aug 2023 06:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbjHKKqU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Aug 2023 06:46:20 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504C818E
        for <linux-mmc@vger.kernel.org>; Fri, 11 Aug 2023 03:46:19 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a751d2e6ecso1629167b6e.0
        for <linux-mmc@vger.kernel.org>; Fri, 11 Aug 2023 03:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691750778; x=1692355578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5qiK9QQkmWGibkXDupuX1/u2qOmOZsbLeQR1shFpbLw=;
        b=N8KQMpWUaBQoFASi1LrYMn01wqD5AzTzOt1sXSrT6FI4DBBUJJVewfHliIzgpUKz/M
         To/be8Z/aiy43kJPnDlEpj1T9R7GnmNoCgsS6Rc1RIJZ2aiW0IOEnj77NHwenhuTar+n
         SRoXK1npqZmq7aVkojzc4ffmWWwO89YxYb3V09fN5kNXBLoVv9s2ndZp86rchm1waNQN
         F7GUV+NzoAaHe5ypWeMc+N8C1Rlj/M+OGx7tGhEz4WUe+oN3Md37l8EuH5f4PteCwuE1
         OBvMWpnaJKf2jewHFyNKZIX4SmTIKGmfUvgVCjSlH5RNHXF8iyaaXWMDVnVxpveKRk7f
         HYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691750778; x=1692355578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qiK9QQkmWGibkXDupuX1/u2qOmOZsbLeQR1shFpbLw=;
        b=RWPN0rN0THSoAXu8GY/4PmcpHiOGqEp7zFs3Rojxfhlu2gWz6YHaIL2ADyfj7+35HZ
         TGRX1JHa/SJH7t8ajcBWfZ79tbh7XTAj+0AjAleETmyiEquoaUbqSIXg5ZWujiRA5rIz
         TN2KLXdEbZGpBCFXIwAe0LgGmpexCTsna0mHM64Ov2/dZkTVXirgCYwW2MlcxvE7AxMf
         dTvBTFlQlrAsphfV1iSmfTkdHc+gdde7rSeiSbSFwO0JLMjGZsp/w87ZKjQTD/kQLDjR
         VFxf11Hh4aaxNCJ+bhhWteFDJLKM/kbuuzvL8EBNNF7tGdkdr9sompUq0J1w/FZlEMWH
         s28w==
X-Gm-Message-State: AOJu0Ywgi4C0Al4ok8mRiDUnzzh7ouzTTR20LHL/XHv1y2OzMRIvmkZg
        ds65hp7xQitdn0A1P1QOJqJh8bAKBEOG6HbRtKXsog==
X-Google-Smtp-Source: AGHT+IFe/i5L5NvxoTbpB+1MM9NrtWX08M2yz/sA2CoxQuo7uMIN2bfeqZkvP9FofDet5W1M6/Oi+s9uPSCT+BYGPIU=
X-Received: by 2002:a05:6358:920f:b0:139:d4f2:b03e with SMTP id
 d15-20020a056358920f00b00139d4f2b03emr1684222rwb.6.1691750778606; Fri, 11 Aug
 2023 03:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230811101404.4463-1-victorshihgli@gmail.com>
In-Reply-To: <20230811101404.4463-1-victorshihgli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 11 Aug 2023 12:45:42 +0200
Message-ID: <CAPDyKFrCObwmjnZP0Nc3FUfckvjSFMSM0dpfmp_2gPpgYdiRhg@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: core: Cleanup mmc_sd_num_wr_blocks function
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 11 Aug 2023 at 12:14, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Use mmc_app_cmd function to simplify code in
> mmc_sd_num_wr_blocks function.
>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>

Applied for next (by amending a minor part, see below), thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index f701efb1fa78..c665b25bffc3 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -918,17 +918,9 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
>
>         struct scatterlist sg;
>
> -       cmd.opcode = MMC_APP_CMD;
> -       cmd.arg = card->rca << 16;
> -       cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
> -
> -       err = mmc_wait_for_cmd(card->host, &cmd, 0);
> -       if (err)
> -               return err;
> -       if (!mmc_host_is_spi(card->host) && !(cmd.resp[0] & R1_APP_CMD))
> -               return -EIO;
> -
> -       memset(&cmd, 0, sizeof(struct mmc_command));
> +       err = mmc_app_cmd(card->host, card);
> +               if (err)

This is one more indentation than required. As I said above, I have
fixed it up before applying, no action from you needed this time.


> +                       return err;
>
>         cmd.opcode = SD_APP_SEND_NUM_WR_BLKS;
>         cmd.arg = 0;
> --
> 2.25.1
>
