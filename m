Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DCA1C6A3
	for <linux-mmc@vger.kernel.org>; Wed, 15 Nov 2023 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l0u5JlgW"
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABBD2706
	for <linux-mmc@vger.kernel.org>; Wed, 15 Nov 2023 07:51:44 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d9abc069c8bso6811789276.3
        for <linux-mmc@vger.kernel.org>; Wed, 15 Nov 2023 07:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700063503; x=1700668303; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NVUEiYhT9QTGpoJea11QrcP/Cme2INTlTLciRBieU0M=;
        b=l0u5JlgWM7npximMwdh1RG8id31C5DqCWFoQszEQ4fJDVIJ0AY/D8O9Tzb+hbpu8Tz
         2YeIf1pOJSptIzSaoY38nBsii4vjOgNz3zki+9v77lR49iA/d6rizwlgXuLuz+2yO7tC
         m10nTgOmHBIDXD1FIF9l4UNJqqln7q9IjMfxlcg6qWXB6+OuD9JBkcGHUI4mbGXpa5nb
         bcuiG49i/uoqN194OtUTr6p4zoc6w5L3HmkZoTFh7pjsVJ9bSqq54yFlQ/lyxlxhX/ZC
         N5+6I9hDmX1T7YkdpJx/yde/tkTpG4JD5EXUPZnfMNh8UB3CktavfEOSxMTVG0aNaJCX
         foeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700063503; x=1700668303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NVUEiYhT9QTGpoJea11QrcP/Cme2INTlTLciRBieU0M=;
        b=o4wy2hCLqlxO2QSRrOkWDDn4lYJb8xCFbEtkfL+XcdyOqPDbN2GV9R27VoEqrdSYmD
         yVQe9KSqcVtkJfKqhTicRlntcG+Ju/RFbjkEHN22Lam8fTwFE0ozOsvI1RljMFHwFlGC
         n5pfDDOaU3N6gfuC8YB26cPtwj28Zr8/juVGSJxEUSr5RNFAokyvTjKXXfNd7ypO+0K5
         rtWT7FkO7U1AhhSMpQRTPkvOo1ngc7no8eh7Q/s/F/1vzWXpzpMEBy1Eb5w8NqQOiZwE
         syMJBVACYFksqMYEUYdes/bERQUsGhwXfPDYoUYmmeSAmKHj9jOWdW5rXiW/Gw2drXxh
         /D4w==
X-Gm-Message-State: AOJu0YwA7kXeARXVJU2F7qCsoPutt8Ef7l6yVVGxlp8hz3V+E/U9J1Ju
	26jMBQG8a2ziO+w1yTusP7z7enYei1JUeQPLJMSiqP64vj+saTV+B2U=
X-Google-Smtp-Source: AGHT+IHTFTHFvhwHLNCXuf+NGuLV7xZ7niNbBW+KqVJpJIoTUotWzji6xRZRz/lqg7+7vgBLHJpzScvnlrBc2AffKLI=
X-Received: by 2002:a25:adce:0:b0:db0:3039:2444 with SMTP id
 d14-20020a25adce000000b00db030392444mr2222823ybe.41.1700063503677; Wed, 15
 Nov 2023 07:51:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030062226.1895692-1-avri.altman@wdc.com>
In-Reply-To: <20231030062226.1895692-1-avri.altman@wdc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 15 Nov 2023 16:51:07 +0100
Message-ID: <CAPDyKFpSk50AQ_WQ7Q52pKrOGPwZ+QVfRPiSftcB_wUJ4LS_SQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Remove packed command leftovers
To: Avri Altman <avri.altman@wdc.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Oct 2023 at 07:22, Avri Altman <avri.altman@wdc.com> wrote:
>
> Packed commands support was removed long time ago, but some bits got
> left behind. Remove them.
>
> Fixes: 03d640ae1f9b (mmc: block: delete packed command support)
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/mmc.c   |  5 -----
>  include/linux/mmc/card.h |  3 ---
>  include/linux/mmc/core.h |  1 -
>  include/linux/mmc/mmc.h  | 10 ----------
>  4 files changed, 19 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 8180983bd402..5e577aa31bf2 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -613,11 +613,6 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>                 } else {
>                         card->ext_csd.data_tag_unit_size = 0;
>                 }
> -
> -               card->ext_csd.max_packed_writes =
> -                       ext_csd[EXT_CSD_MAX_PACKED_WRITES];
> -               card->ext_csd.max_packed_reads =
> -                       ext_csd[EXT_CSD_MAX_PACKED_READS];
>         } else {
>                 card->ext_csd.data_sector_size = 512;
>         }
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index daa2f40d9ce6..24aaa819f9f0 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -52,9 +52,6 @@ struct mmc_ext_csd {
>         u8                      part_config;
>         u8                      cache_ctrl;
>         u8                      rst_n_function;
> -       u8                      max_packed_writes;
> -       u8                      max_packed_reads;
> -       u8                      packed_event_en;
>         unsigned int            part_time;              /* Units: ms */
>         unsigned int            sa_timeout;             /* Units: 100ns */
>         unsigned int            generic_cmd6_time;      /* Units: 10ms */
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 6efec0b9820c..2c7928a50907 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -27,7 +27,6 @@ struct mmc_command {
>         u32                     opcode;
>         u32                     arg;
>  #define MMC_CMD23_ARG_REL_WR   (1 << 31)
> -#define MMC_CMD23_ARG_PACKED   ((0 << 31) | (1 << 30))
>  #define MMC_CMD23_ARG_TAG_REQ  (1 << 29)
>         u32                     resp[4];
>         unsigned int            flags;          /* expected response type */
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 6f7993803ee7..cf2bcb5da30d 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -257,8 +257,6 @@ static inline bool mmc_ready_for_data(u32 status)
>  #define EXT_CSD_FLUSH_CACHE            32      /* W */
>  #define EXT_CSD_CACHE_CTRL             33      /* R/W */
>  #define EXT_CSD_POWER_OFF_NOTIFICATION 34      /* R/W */
> -#define EXT_CSD_PACKED_FAILURE_INDEX   35      /* RO */
> -#define EXT_CSD_PACKED_CMD_STATUS      36      /* RO */
>  #define EXT_CSD_EXP_EVENTS_STATUS      54      /* RO, 2 bytes */
>  #define EXT_CSD_EXP_EVENTS_CTRL                56      /* R/W, 2 bytes */
>  #define EXT_CSD_DATA_SECTOR_SIZE       61      /* R */
> @@ -321,8 +319,6 @@ static inline bool mmc_ready_for_data(u32 status)
>  #define EXT_CSD_SUPPORTED_MODE         493     /* RO */
>  #define EXT_CSD_TAG_UNIT_SIZE          498     /* RO */
>  #define EXT_CSD_DATA_TAG_SUPPORT       499     /* RO */
> -#define EXT_CSD_MAX_PACKED_WRITES      500     /* RO */
> -#define EXT_CSD_MAX_PACKED_READS       501     /* RO */
>  #define EXT_CSD_BKOPS_SUPPORT          502     /* RO */
>  #define EXT_CSD_HPI_FEATURES           503     /* RO */
>
> @@ -402,18 +398,12 @@ static inline bool mmc_ready_for_data(u32 status)
>  #define EXT_CSD_PWR_CL_8BIT_SHIFT      4
>  #define EXT_CSD_PWR_CL_4BIT_SHIFT      0
>
> -#define EXT_CSD_PACKED_EVENT_EN        BIT(3)
> -
>  /*
>   * EXCEPTION_EVENT_STATUS field
>   */
>  #define EXT_CSD_URGENT_BKOPS           BIT(0)
>  #define EXT_CSD_DYNCAP_NEEDED          BIT(1)
>  #define EXT_CSD_SYSPOOL_EXHAUSTED      BIT(2)
> -#define EXT_CSD_PACKED_FAILURE         BIT(3)
> -
> -#define EXT_CSD_PACKED_GENERIC_ERROR   BIT(0)
> -#define EXT_CSD_PACKED_INDEXED_ERROR   BIT(1)
>
>  /*
>   * BKOPS status level
> --
> 2.42.0
>
