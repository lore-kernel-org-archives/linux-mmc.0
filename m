Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E260315ADF
	for <linux-mmc@vger.kernel.org>; Tue,  2 Jan 2024 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sTbeuXO7"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dbdb8e032f7so7277412276.1
        for <linux-mmc@vger.kernel.org>; Tue, 02 Jan 2024 08:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704214670; x=1704819470; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4472QStNp6Zr1RLAldtMI7Jne10bfsy1ti/c3TxR+2Y=;
        b=sTbeuXO7zin5KluO+qE6w4bhCBqDWrpbyu71ZjYVZQ61Q/uU/0tolijSQ0xX0oAyX7
         Ky3rjocPVD0ge5LkVDOxmeTnybINYQB1rbABbfhjOeDeYAkix0CWxp8vXjjwDLvQznWT
         IZdbnndQRTHFX0GdIxxjsIhjS5OLOYnP3PgU+teCuXiLFOorhnaSxrD1xUUIGRN7luuh
         FntnnnKBrhKkGum0TPVlKuiBSQY1LbDhLgiCcKqhwmwGdGMmcZPW1PVLsY1OtsKPGrz4
         sPQQHqcFYQjvgIva/RF5UGbiSlBgMWvwi0QNlAgACNOueLs9CGaIjP8uU3WW4e+fEn3i
         kIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704214670; x=1704819470;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4472QStNp6Zr1RLAldtMI7Jne10bfsy1ti/c3TxR+2Y=;
        b=f+iLvxBBBHcsNtRL6dC2jP9CcuVHmhof2G2+co75nMAUUuNrz4VRoWyg6u0vo99ePM
         mJ/UBg9J90lwSnBLBK6fLBsDv+xucZrt/TrSVzfL1O81GTDOEzXbgzDsD5GpU0ZO6Vkr
         6QNfvJzdMtuGuXubu3pJc8OT+hZ4wol1i07FzKFWdUDmrrH+EgefMNjeX4iu74943yzF
         kfe3m/7t/jON+UsLQnpkKf038MekR0Tv1X0TrySWB1wQZMIqqvDmWQ3LFxU8S8vqclLT
         8IjXbzkGO4NuVcoj9nvlweIvp79NnrMizdm6j3CE9Rc9CNf5Xglh5XCKgwOXuPrURiIO
         k4BQ==
X-Gm-Message-State: AOJu0Yx5SxR/E0F6YfJNyxUrJK8dT1h7I1+B68nfdbFWOVGXppaGnGGX
	vNmvRe5/h7m6pJHaSmDT2hMwzE+bg4SrWoaDxnm2wPPMpWCk1A==
X-Google-Smtp-Source: AGHT+IGaie7llkC0WY/ixF26z8u+KlGBuJcMXc/mTXO9lJk5lRRKNK+aRovxY0vGl7k6LwgOSjGmAgsCULdJSRRqxi8=
X-Received: by 2002:a25:b2a2:0:b0:dbd:9bd9:2159 with SMTP id
 k34-20020a25b2a2000000b00dbd9bd92159mr10842360ybj.45.1704214669983; Tue, 02
 Jan 2024 08:57:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231225093839.22931-1-mengqi.zhang@mediatek.com> <20231225093839.22931-2-mengqi.zhang@mediatek.com>
In-Reply-To: <20231225093839.22931-2-mengqi.zhang@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 2 Jan 2024 17:57:14 +0100
Message-ID: <CAPDyKFpJYKLCrrb0-dPLNGcaLRjevWkrrXpJY70rbwjsUJdYug@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] mmc: core: Add HS400 tuning in HS400es initialization
To: Mengqi Zhang <mengqi.zhang@mediatek.com>
Cc: chaotian.jing@mediatek.com, matthias.bgg@gmail.com, 
	wenbin.mei@mediatek.com, yangyingliang@huawei.com, adrian.hunter@intel.com, 
	avri.altman@wdc.com, vincent.whitchurch@axis.com, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Dec 2023 at 10:39, Mengqi Zhang <mengqi.zhang@mediatek.com> wrote:
>
> During the initialization to HS400es stage, add hs400 tuning flow as an
> optional process. For Mediatek IP, HS00es mode requires a specific
> tuning to ensure the correct HS400 timing setting.
>
> Signed-off-by: Mengqi Zhang <mengqi.zhang@mediatek.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v1 https://patchwork.kernel.org/project/linux-mediatek/patch/20231201030547.11553-1-mengqi.zhang@mediatek.com/
> v2 https://patchwork.kernel.org/project/linux-mediatek/patch/20231222062236.26370-1-mengqi.zhang@mediatek.com/
> ---
>  drivers/mmc/core/mmc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 705942edacc6..d5173a9bb4b0 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1822,8 +1822,13 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>
>                 if (err)
>                         goto free_card;
> -
> -       } else if (!mmc_card_hs400es(card)) {
> +       } else if (mmc_card_hs400es(card)) {
> +               if (host->ops->execute_hs400_tuning) {
> +                       err = host->ops->execute_hs400_tuning(host, card);
> +                       if (err)
> +                               goto free_card;
> +               }
> +       } else {
>                 /* Select the desired bus width optionally */
>                 err = mmc_select_bus_width(card);
>                 if (err > 0 && mmc_card_hs(card)) {
> --
> 2.25.1
>
