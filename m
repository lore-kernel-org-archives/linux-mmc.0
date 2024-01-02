Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6E4156F7
	for <linux-mmc@vger.kernel.org>; Tue,  2 Jan 2024 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WJI8GFYQ"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5e75005bd0cso86554737b3.1
        for <linux-mmc@vger.kernel.org>; Tue, 02 Jan 2024 08:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704214664; x=1704819464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P7mw9sYe2c4ti/SYwthiIEsX16vYxBmZCGPwYl/4Wm0=;
        b=WJI8GFYQWnOyHnWLqgfWAvH9TyPAr8aBI1paYB/5hiUKcAg3n0ZVBfdjo/vstHK/j3
         2V+12chWljFoCRQU8f/hCk8r2raCU/eRQWJODhPWOYbEG21XJP4xkEgOVzoc0vgEgYaG
         9sD280wUaQaqzbs8m+exqnu/d7P2EQbbPXW9Jvh5A6L2SE7sCPy5n5v/hk6cZ7zCybLv
         bSoASoPJ9nurRYAWvIDENuFdiJQAMSi9CgaRHd4HePIobyf24zo3Ov8E7U28RJ7A+PQ1
         67kkv2PD1EhfunJpwE5s3YDcqUmxcuKLbGxF/fpqZkU1kjj9LR2SseI+tizKU/DhIinL
         4S9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704214664; x=1704819464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7mw9sYe2c4ti/SYwthiIEsX16vYxBmZCGPwYl/4Wm0=;
        b=h5STNiJmJifeRmQ5Gy1ShF+4JhVWJ5ykun4dczTaK7bOCFgIhxuWgCCCs3TD6cWsUH
         yMyaMuYW+Bg6WPQS562qnyqDHpB8C3WJBHhxEhtEyuyhXWkv9KEkYQleaIn9ZPEnMdLy
         56d4+SboE9KTZ6euIK0wQWmMkRFmP2cbOsTtjrHUrYDAwcPfC3p3UtH9qDE1HDvCAsjn
         U1jy+HbVYad2hP9Ye57F28ALsGttlHLqYNglZCN/RhqOnKpVw7L+K0BesYE5gPmsg5rG
         StkkdZJq04Rymgyijr9qziiEiGqvB9iBTB/iZ10pejFMSAgA4Ucks6UK7pruETLqn89H
         dl7Q==
X-Gm-Message-State: AOJu0YzWpyjqWVOY6oUWpK0E4lg7/eBTw+P4OEBL6fgC+RzzHix7v4IF
	4Lje4tEQJQbahfAuuBgIH0K+YJIzP5FSgfl9ao29j3IGFgk86A==
X-Google-Smtp-Source: AGHT+IGiPhJOvkXq8K67MCuEJDvv31lDX3hkO3sQTLR2RzvsBVTJnxsVkQzQRyAgjzoE0B1L1g65UJ2h/Z4CL/yHUxE=
X-Received: by 2002:a81:7b04:0:b0:5e2:2125:2763 with SMTP id
 w4-20020a817b04000000b005e221252763mr12300180ywc.19.1704214663745; Tue, 02
 Jan 2024 08:57:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218224832.81347-1-bo.ye@mediatek.com>
In-Reply-To: <20231218224832.81347-1-bo.ye@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 2 Jan 2024 17:57:07 +0100
Message-ID: <CAPDyKFpW_2vYPkOHHihib+EKi74-TGzW4_2Z4jnRJhdH+=Yi-g@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: add wp_grp_size node
To: Bo Ye <bo.ye@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, yongdong.zhang@mediatek.com, 
	"lin.gui" <lin.gui@mediatek.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Dec 2023 at 23:48, Bo Ye <bo.ye@mediatek.com> wrote:
>
> From: "lin.gui" <lin.gui@mediatek.com>
>
> Detail:
> Add node "wp_grp_size", corresponding to WP_GRP_SIZE
> (write protect group size) of eMMC's CSD register.
>
> Scenario:
> The eMMC card can be set into write-protected mode to
> prevent data from being accidentally modified or deleted.
> Wp_grp_size (Write Protect Group Size) refers to an
> attribute of the eMMC card, used to manage write protection,
> and is the CSD register  [36:32] of the eMMC device.
> Wp_grp_size (Write Protect Group Size) indicates how many
> eMMC blocks are contained in each write protection group on the eMMC card.
>
> Final rendered file:
> "/sys/class/mmc_host/mmc0/mmc0:0001/wp_grp_size"
>
> Signed-off-by: Lin Gui <lin.gui@mediatek.com>
> Signed-off-by: Bo Ye <bo.ye@mediatek.com>

Applied for next, thanks!

Note that checkpatch complained about the patch (see below), but I
fixed it up this time.

WARNING: From:/Signed-off-by: email name mismatch: 'From: "lin.gui"
<lin.gui@mediatek.com>' != 'Signed-off-by: Lin Gui
<lin.gui@mediatek.com>'

Kind regards
Uffe



> ---
> Change in v2:
> -remove Change-Id
> -replace space with tabulation
> ---
>  drivers/mmc/core/mmc.c   | 16 +++++++++++++++-
>  include/linux/mmc/card.h |  2 ++
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 705942edacc6..e0d72378ac77 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -136,6 +136,17 @@ static void mmc_set_erase_size(struct mmc_card *card)
>         mmc_init_erase(card);
>  }
>
> +
> +static void mmc_set_wp_grp_size(struct mmc_card *card)
> +{
> +       if (card->ext_csd.erase_group_def & 1)
> +               card->wp_grp_size = card->ext_csd.hc_erase_size *
> +                       card->ext_csd.raw_hc_erase_gap_size;
> +       else
> +               card->wp_grp_size = card->csd.erase_size *
> +                       (card->csd.wp_grp_size + 1);
> +}
> +
>  /*
>   * Given a 128-bit response, decode to our card CSD structure.
>   */
> @@ -186,6 +197,7 @@ static int mmc_decode_csd(struct mmc_card *card)
>                 b = UNSTUFF_BITS(resp, 37, 5);
>                 csd->erase_size = (a + 1) * (b + 1);
>                 csd->erase_size <<= csd->write_blkbits - 9;
> +               csd->wp_grp_size = UNSTUFF_BITS(resp, 32, 5);
>         }
>
>         return 0;
> @@ -790,6 +802,7 @@ MMC_DEV_ATTR(csd, "%08x%08x%08x%08x\n", card->raw_csd[0], card->raw_csd[1],
>  MMC_DEV_ATTR(date, "%02d/%04d\n", card->cid.month, card->cid.year);
>  MMC_DEV_ATTR(erase_size, "%u\n", card->erase_size << 9);
>  MMC_DEV_ATTR(preferred_erase_size, "%u\n", card->pref_erase << 9);
> +MMC_DEV_ATTR(wp_grp_size, "%u\n", card->wp_grp_size << 9);
>  MMC_DEV_ATTR(ffu_capable, "%d\n", card->ext_csd.ffu_capable);
>  MMC_DEV_ATTR(hwrev, "0x%x\n", card->cid.hwrev);
>  MMC_DEV_ATTR(manfid, "0x%06x\n", card->cid.manfid);
> @@ -850,6 +863,7 @@ static struct attribute *mmc_std_attrs[] = {
>         &dev_attr_date.attr,
>         &dev_attr_erase_size.attr,
>         &dev_attr_preferred_erase_size.attr,
> +       &dev_attr_wp_grp_size.attr,
>         &dev_attr_fwrev.attr,
>         &dev_attr_ffu_capable.attr,
>         &dev_attr_hwrev.attr,
> @@ -1764,7 +1778,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                         mmc_set_erase_size(card);
>                 }
>         }
> -
> +       mmc_set_wp_grp_size(card);
>         /*
>          * Ensure eMMC user default partition is enabled
>          */
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 7b12eebc5586..b9c3c6303a22 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -32,6 +32,7 @@ struct mmc_csd {
>         unsigned int            r2w_factor;
>         unsigned int            max_dtr;
>         unsigned int            erase_size;             /* In sectors */
> +       unsigned int            wp_grp_size;
>         unsigned int            read_blkbits;
>         unsigned int            write_blkbits;
>         unsigned int            capacity;
> @@ -306,6 +307,7 @@ struct mmc_card {
>         unsigned int            eg_boundary;    /* don't cross erase-group boundaries */
>         unsigned int            erase_arg;      /* erase / trim / discard */
>         u8                      erased_byte;    /* value of erased bytes */
> +       unsigned int            wp_grp_size;    /* write group size in sectors */
>
>         u32                     raw_cid[4];     /* raw card CID */
>         u32                     raw_csd[4];     /* raw card CSD */
> --
> 2.18.0
>
