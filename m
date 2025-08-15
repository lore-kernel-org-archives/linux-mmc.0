Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B4B278157
	for <linux-mmc@vger.kernel.org>; Fri, 15 Aug 2025 12:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755260655; cv=none; b=bcfADAycDMSs3Gs9Wl4nLGfMdDtCtnmkNdlnlT9zaUWESwoS/vMsX07y0vgs1HIO1HE2Bu/ZQ4L2TBnIqzbgRsAbYmOlm0ypRIzcH15b+jUxk8vXTOpwVYLEOQEC0FTCPau5atCnssb/NnMw0AFEqtwHZc1r++qepNwuvQFzRUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755260655; c=relaxed/simple;
	bh=DwtYpRH0b7X/lUlfIsy5hJeDIKdwN+1I/IdUDixnATQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VrjaD5NbxBzZhULemKZkvwA0Ygker7xDj93kvG+/22HeEQT6eynH00WiqeFAJivfss9z0deT8y2JTG5DEBUbiVOCu3TAlzHVXe+TMeem6YLwZCQ/bDrkFEBLODgK3W6MwFRMgbYSL4YjU2DITqQzzsA7u/rc3Zya8L2GUhzaTRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fuCN4Rkf; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fuCN4Rkf"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d60504db9so16079297b3.2
        for <linux-mmc@vger.kernel.org>; Fri, 15 Aug 2025 05:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755260653; x=1755865453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5a1hcAV+aFoGNWJ/TQ9KJVVsUbsqFwHIGVoQOC8GMQ=;
        b=fuCN4Rkf+vpwJhhCq0fGxO5/ng4aPH99iEh80x1rMuRmQ1GHO4jMEo3zNRPnU41z3P
         s2XgW93tzgixlgTMLycK3lizDJdN+wz+MvzQuY+9k1bqmkarAs6y8Pe4qhxc4P4BvChi
         jlJK2/lYncj5zFs6XJlJxk1vpDZqalj3p3H8MpE56nuPuDIdkgwwaExZmw8Bcq13bD4w
         WN6Mo3mrIUsDChhzh+IZKLZn9QtVLI8wdvRCXa3vtK/OrHs8kqlmYl+NgI5VtXsfuDxC
         JIl6KtWQuu8oUwWGoY1AFwkA8G2Rlo+pV/3vUph8VUwKpKdJD+LlmKHUCiGge30NCO/Y
         wqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755260653; x=1755865453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5a1hcAV+aFoGNWJ/TQ9KJVVsUbsqFwHIGVoQOC8GMQ=;
        b=RwBrYdV/VSuw9NMQ1zjx2RbaxG7PjpR/WvzWMQb9Ybok3FObQLT5MmFuWNkl5phoLS
         o4Qu6nAacxOaqpj+rxl6Eg07n95am/v8XVjJHHiDZxusACRxzgshOpCMxkr63MEpFBwF
         YkLJXz5KOFyFuTx11isBZKlTl7g1EvHuH3VAqSwr1sO+zDDaEYKuafR370KZwXHO6EP/
         v6hgIbP+Vz0zAhOsX9YXrfONnCBtxb1nZ+JMTafjZDeNOAsQkoR0rYhLmmEMlwDQyJsH
         DG3HKW+pwrmCzExMr2x51EbgKSPdyOvyBgyqFAnpaUOSjmY8ifprdvtHCX1jSqUriusj
         5cCw==
X-Forwarded-Encrypted: i=1; AJvYcCX1LyQuPllPy7XWfyJdu3FvTeWVPZISE5530RaJDHngQEFF7Q62iRt09OyY2vilE7dRFMcQvrfRmPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr0Jmf5zNSRmac1/c4qCQGSnpm7BzzOScDPj/bPrVSpKfRZ0M4
	YEO1WA9gkeQlRtiDF4OmmgQmD9qSGtvqIjjmiClIoVHhWkFrRScArJNo1aQGVjXhauf+a5mwEtN
	RBZPkTWKnP/aqcrzIYQxXV5V2WJ/p9Kvwbglcf9CwoOyrQRNh0LNu29Y=
X-Gm-Gg: ASbGnctuB78nta1cBXBoaNiok+UPhMM0+zVft2nejCT1cnqePhdA7tRrza1Ya/wBbfE
	e0PWYdpUqmzXS2v8vqbrwXReLUX67+ITHdz8zvGAhXu5CZEP6E0wjKAvf0x89jWAvUThY0eaeJa
	ek5ZyBAmqfIw2u3ySG4+LR7GuTMSBwn+DOISmuPnys5xh0rJi6eAtK7loIsSVrta4/WWQyegieG
	oPyL9I8
X-Google-Smtp-Source: AGHT+IET0jvBPg59oKauMRn6o6ClybC0fgYZHTLg2pDO7eeUoj22mK437Hop7Rqk1JEhtNNTge2rfC/nIhIs3Pgaue0=
X-Received: by 2002:a05:690c:338e:b0:71d:5438:36d5 with SMTP id
 00721157ae682-71e6df4c581mr20897317b3.40.1755260652902; Fri, 15 Aug 2025
 05:24:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716-mobileye-emmc-for-upstream-4-v3-0-dc979d8edef0@bootlin.com>
 <20250716-mobileye-emmc-for-upstream-4-v3-5-dc979d8edef0@bootlin.com>
In-Reply-To: <20250716-mobileye-emmc-for-upstream-4-v3-5-dc979d8edef0@bootlin.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 15 Aug 2025 14:23:37 +0200
X-Gm-Features: Ac12FXyI_8ufmFHbQWW66qRqG75PXzoyZ-dSldUZIb8uICL3J9Y4gmA6xP8P8Xo
Message-ID: <CAPDyKFr4urmw75MB48nCOYq+8n1DEufqY9b7EN8mooL2xTY0pw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] mmc: core: add mmc_read_tuning
To: =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Jul 2025 at 17:47, Beno=C3=AEt Monin <benoit.monin@bootlin.com> =
wrote:
>
> Provide a function to the MMC hosts to read some blocks of data as part
> of their tuning. The card parameter is optional since it is not
> available from the execute_tuning() operation, but present in
> execute_hs400_tuning() and prepare_sd_hs_tuning().
>
> This function only returns the status of the read operation, not the
> data read.
>
> Signed-off-by: Beno=C3=AEt Monin <benoit.monin@bootlin.com>
> ---
>  drivers/mmc/core/mmc_ops.c | 79 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/mmc/host.h   |  2 ++
>  2 files changed, 81 insertions(+)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 66283825513cb4ff993a1b2ec1f0b0cac4e74487..d29e5daf3e326ab37e61c9945=
6421b1f66bcb0de 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -1077,3 +1077,82 @@ int mmc_sanitize(struct mmc_card *card, unsigned i=
nt timeout_ms)
>         return err;
>  }
>  EXPORT_SYMBOL_GPL(mmc_sanitize);
> +
> +/**
> + * mmc_read_tuning() - read data blocks from the mmc
> + * @card: mmc card to read from, can be NULL
> + * @host: mmc host doing the read
> + * @blksz: data block size
> + * @blocks: number of blocks to read
> + *
> + * Read one or more blocks of data from the beginning of the mmc. This i=
s a
> + * low-level helper for tuning operation. If card is NULL, it is assumed=
 that
> + * CMD23 can be used for multi-block read.

It makes sense to have a comment for this, but I would just just drop
the "struct mmc_card *card" as an in-parameter. If it turns out to be
needed later on, we would need additional changes to enable the caller
of mmc_read_tuning() to pass the "card" along.

> + *
> + * Note: Allocate and free a temporary buffer to store the data read. Th=
e data
> + * is not available outside of the function, only the status of the read
> + * operation.
> + *
> + * Return: 0 in case of success, otherwise -EIO / -ENOMEM / -E2BIG
> + */
> +int mmc_read_tuning(struct mmc_card *card, struct mmc_host *host,
> +                   unsigned int blksz, unsigned int blocks)
> +{
> +       struct mmc_request mrq =3D {};
> +       struct mmc_command sbc =3D {};
> +       struct mmc_command cmd =3D {};
> +       struct mmc_command stop =3D {};
> +       struct mmc_data data =3D {};
> +       struct scatterlist sg;
> +       void *buf;
> +       unsigned int len;
> +
> +       if (blocks > 1) {
> +               if (mmc_host_can_cmd23(host) &&
> +                   (!card || (mmc_card_can_cmd23(card) &&
> +                    !mmc_card_blk_no_cmd23(card)))) {
> +                       mrq.sbc =3D &sbc;
> +                       sbc.opcode =3D MMC_SET_BLOCK_COUNT;
> +                       sbc.arg =3D blocks;
> +                       sbc.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
> +               }
> +               cmd.opcode =3D MMC_READ_MULTIPLE_BLOCK;
> +               mrq.stop =3D &stop;
> +               stop.opcode =3D MMC_STOP_TRANSMISSION;
> +               stop.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
> +       } else {
> +               cmd.opcode =3D MMC_READ_SINGLE_BLOCK;
> +       }
> +
> +       mrq.cmd =3D &cmd;
> +       cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> +
> +       mrq.data =3D &data;
> +       data.flags =3D MMC_DATA_READ;
> +       data.blksz =3D blksz;
> +       data.blocks =3D blocks;
> +       data.blk_addr =3D 0;
> +       data.sg =3D &sg;
> +       data.sg_len =3D 1;
> +       if (card)
> +               mmc_set_data_timeout(&data, card);
> +       else
> +               data.timeout_ns =3D 1000000000;
> +
> +       if (check_mul_overflow(blksz, blocks, &len))
> +               return -E2BIG;
> +       buf =3D kmalloc(len, GFP_KERNEL);
> +       if (!buf)
> +               return -ENOMEM;
> +
> +       sg_init_one(&sg, buf, len);
> +
> +       mmc_wait_for_req(host, &mrq);
> +       kfree(buf);
> +
> +       if (sbc.error || cmd.error || data.error)
> +               return -EIO;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(mmc_read_tuning);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 68f09a955a902047ac517441b6820fa6e4166a13..5a6471a6219222b199a16afd9=
e6bd5ab74b05c86 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -743,5 +743,7 @@ int mmc_send_status(struct mmc_card *card, u32 *statu=
s);
>  int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
>  int mmc_send_abort_tuning(struct mmc_host *host, u32 opcode);
>  int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
> +int mmc_read_tuning(struct mmc_card *card, struct mmc_host *host,
> +                   unsigned int blksz, unsigned int blocks);
>
>  #endif /* LINUX_MMC_HOST_H */
>
> --
> 2.50.1
>

Otherwise this looks good to me!

Kind regards
Uffe
