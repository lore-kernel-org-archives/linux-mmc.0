Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299D0282E1
	for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 16:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MJBVwqhq"
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E9F107
	for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 08:22:13 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d865854ef96so5948588276.2
        for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 08:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699978933; x=1700583733; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+RFtXci+rLVkSeKqmBaQ1L78i1nOP+qB624bLxsqmV4=;
        b=MJBVwqhqhKTBvLtVy0vjniPxjN1ny3F4vifE0La7Zjr4AVVGaBuU38zcHQqcKBzopP
         f5CyEIQDIunBI/lOyw/19QIvvdViBPSZHA3SOcYifjj8KtZjMwEUiYYSlaNa9K2ZJ/I7
         Ua+c1GKJxsN2dagZmdNao8fP3r76TbwgyTjgBgnW7D0S1ruRgNeAqvbSwAD3taIBsCyM
         Wganji6/Kmko0ATMFU97HsWOleRVW5FJqTmsmp2zPWHMDazU33c9Uc4rq97EkFZfcxs9
         9Cv1byK/IGRKi5w+oa+s0C3ukkKUXzyqfugAG4vSd2PVX1f7c8WEfVfbneLM2MP8NJIJ
         f3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699978933; x=1700583733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RFtXci+rLVkSeKqmBaQ1L78i1nOP+qB624bLxsqmV4=;
        b=DSKSE+D+59br9bbuH9Xsf/3+LzJhCRc3mRXZWIagnDTTLpAVKnwAjutrAL3iSxXz74
         MmMkxqroyPxjQ3yRhgQXxFjKXhS1ksj8jI1wZjlHpMq1v4guANn67A+HUmcKLPM18nhl
         jGLzbvMcfIHIs6TZ3hGkEepEJI9XPLDkegrpuWGVelHJFy6eptavtrA7ItgcO3mDAmcR
         Gx5jOkr+h95Dl5pAR0vLr9d1sNQXjmMTjIEVrjW7tC928kDxYVclFUw0nrVl/fHNAFzg
         a+1nTLKneFsXPichQmbAg+aCrwerHxNxj60+aEgvPuLPzkKopREuIjZN0QhpyRCvzH7H
         iXxQ==
X-Gm-Message-State: AOJu0Yza/+F+tvgT5nbK7RT4wkkhe3n9qzjyG7no1lZJJQRLmry0sHFK
	qYjIMDmfB2uVs3rkMw5XiRi7Ljxyde6YiwIBQnyF/E0nyD10WK0CNp4=
X-Google-Smtp-Source: AGHT+IEsfxkXYHGHSAJkPOd/3KKxxPiDPe0BdMqXtV7OQoP48wO4GfK0nXvb+7TLjhkcDIDd7KbrcDm2iHc0Ra6qql8=
X-Received: by 2002:a25:b401:0:b0:db0:20e2:a0b9 with SMTP id
 n1-20020a25b401000000b00db020e2a0b9mr358966ybj.43.1699978931288; Tue, 14 Nov
 2023 08:22:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231105102944.1974512-1-avri.altman@wdc.com>
In-Reply-To: <20231105102944.1974512-1-avri.altman@wdc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 14 Nov 2023 17:21:35 +0100
Message-ID: <CAPDyKFp52a8RGNn3sqQ7accGV7jEsoCZPnHjh4-1Fg9H+xDedw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Remove obsolete quirk for Sandisk cards
To: Avri Altman <avri.altman@wdc.com>
Cc: linux-mmc@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Nov 2023 at 11:29, Avri Altman <avri.altman@wdc.com> wrote:
>
> This quirk applies to an old set of Sandisk cards that are no longer
> being sold for many years now, and it is vanishingly unlikely that will
> ever meet a V6.7 kernel.

Are you really sure about that? The postmarket-os products are being
used in all kinds of different deployments, for example.

>
> I came across those old cards when I tried to decide what to do with
> Sandisk cards that their quirk is designated by OEM id. For many years
> we read wrong oemid, reading 16 bits instead of 8. Fixing it however,
> turned out to be impractical, and it's better that each eMMC vendor will
> handle its own devices.

Right, but I assume the quirk is working as expected for these old
Sandisk eMMCs, no?

>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c  | 32 +-------------------------------
>  drivers/mmc/core/quirks.h | 12 ------------
>  include/linux/mmc/card.h  |  1 -
>  3 files changed, 1 insertion(+), 44 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 152dfe593c43..6aa68ac1129e 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1122,17 +1122,7 @@ static void mmc_blk_issue_erase_rq(struct mmc_queue *mq, struct request *req,
>         nr = blk_rq_sectors(req);
>
>         do {
> -               err = 0;
> -               if (card->quirks & MMC_QUIRK_INAND_CMD38) {
> -                       err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> -                                        INAND_CMD38_ARG_EXT_CSD,
> -                                        erase_arg == MMC_TRIM_ARG ?
> -                                        INAND_CMD38_ARG_TRIM :
> -                                        INAND_CMD38_ARG_ERASE,
> -                                        card->ext_csd.generic_cmd6_time);
> -               }
> -               if (!err)
> -                       err = mmc_erase(card, from, nr, erase_arg);
> +               err = mmc_erase(card, from, nr, erase_arg);
>         } while (err == -EIO && !mmc_blk_reset(md, card->host, type));
>         if (err)
>                 status = BLK_STS_IOERR;
> @@ -1182,17 +1172,6 @@ static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
>                 arg = MMC_SECURE_ERASE_ARG;
>
>  retry:
> -       if (card->quirks & MMC_QUIRK_INAND_CMD38) {
> -               err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> -                                INAND_CMD38_ARG_EXT_CSD,
> -                                arg == MMC_SECURE_TRIM1_ARG ?
> -                                INAND_CMD38_ARG_SECTRIM1 :
> -                                INAND_CMD38_ARG_SECERASE,
> -                                card->ext_csd.generic_cmd6_time);
> -               if (err)
> -                       goto out_retry;
> -       }
> -
>         err = mmc_erase(card, from, nr, arg);
>         if (err == -EIO)
>                 goto out_retry;
> @@ -1202,15 +1181,6 @@ static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
>         }
>
>         if (arg == MMC_SECURE_TRIM1_ARG) {
> -               if (card->quirks & MMC_QUIRK_INAND_CMD38) {
> -                       err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> -                                        INAND_CMD38_ARG_EXT_CSD,
> -                                        INAND_CMD38_ARG_SECTRIM2,
> -                                        card->ext_csd.generic_cmd6_time);
> -                       if (err)
> -                               goto out_retry;
> -               }
> -
>                 err = mmc_erase(card, from, nr, MMC_SECURE_TRIM2_ARG);
>                 if (err == -EIO)
>                         goto out_retry;
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index cca71867bc4a..028f55f07ba3 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -22,18 +22,6 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>  #define INAND_CMD38_ARG_SECERASE 0x80
>  #define INAND_CMD38_ARG_SECTRIM1 0x81
>  #define INAND_CMD38_ARG_SECTRIM2 0x88
> -       /* CMD38 argument is passed through EXT_CSD[113] */
> -       MMC_FIXUP("SEM02G", CID_MANFID_SANDISK, 0x100, add_quirk,
> -                 MMC_QUIRK_INAND_CMD38),
> -       MMC_FIXUP("SEM04G", CID_MANFID_SANDISK, 0x100, add_quirk,
> -                 MMC_QUIRK_INAND_CMD38),
> -       MMC_FIXUP("SEM08G", CID_MANFID_SANDISK, 0x100, add_quirk,
> -                 MMC_QUIRK_INAND_CMD38),
> -       MMC_FIXUP("SEM16G", CID_MANFID_SANDISK, 0x100, add_quirk,
> -                 MMC_QUIRK_INAND_CMD38),
> -       MMC_FIXUP("SEM32G", CID_MANFID_SANDISK, 0x100, add_quirk,
> -                 MMC_QUIRK_INAND_CMD38),
> -
>         /*
>          * Some MMC cards experience performance degradation with CMD23
>          * instead of CMD12-bounded multiblock transfers. For now we'll
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 7b12eebc5586..edb27f3c6489 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -284,7 +284,6 @@ struct mmc_card {
>                                                 /* (missing CIA registers) */
>  #define MMC_QUIRK_NONSTD_FUNC_IF (1<<4)                /* SDIO card has nonstd function interfaces */
>  #define MMC_QUIRK_DISABLE_CD   (1<<5)          /* disconnect CD/DAT[3] resistor */
> -#define MMC_QUIRK_INAND_CMD38  (1<<6)          /* iNAND devices have broken CMD38 */
>  #define MMC_QUIRK_BLK_NO_CMD23 (1<<7)          /* Avoid CMD23 for regular multiblock */
>  #define MMC_QUIRK_BROKEN_BYTE_MODE_512 (1<<8)  /* Avoid sending 512 bytes in */
>                                                 /* byte mode */
> --
> 2.42.0
>
