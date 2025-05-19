Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95B0278E75
	for <linux-mmc@vger.kernel.org>; Mon, 19 May 2025 12:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747657943; cv=none; b=ao0E/pFjiEKVXyKwrsZBc1CxsP95PztTRP/bc24gqbr1ZkNo0jnt+fIIFEgY0o4elJJ8lMporN38MHcJ3ay0k+AN6mecx2i6c8UBbgNbkMUeCHmOwKOfxzTudgPasOW6dCh0NMiMdavz6LmltY/VPxBCZhbI5gUtutsvT4EpzOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747657943; c=relaxed/simple;
	bh=yJmJBDqZKvDuVrVsQTB7p+hv1xxsfW41J0kmo5sfZwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=We3KrIl8W6yiP5csJxWZT0H+6pZ8/tOKOZpO7tInhCVq+5Fx+YcZ6YOe6R7n7Fl9Qm+7NaSj8znzT5EOw6trfMR7ZVhHRRUuV0igptigkYztb2z+BLDdU1ub0kHf4Qp/cYik3W3ao+xu2ubRW1PmeX94ONXFOrI5HuYRMP6BOMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dX0dEEfL; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dX0dEEfL"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e7b4ba530feso3579948276.1
        for <linux-mmc@vger.kernel.org>; Mon, 19 May 2025 05:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747657941; x=1748262741; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vHsufu+SF6+BkfAoJdbGGEtsqtE+xN15rWNgtA6qUrk=;
        b=dX0dEEfL8+/Zke7XLR3A1vpOdD8VXakOBGZsEawh/ukpJAYXVvLqlxbIfDr2/SxcvK
         gAc8AEqTd1yuzZ0KHrF8hvUVAHrOtvbOMi/nHuWTDsuJ6vqjAe9MXUj5uQRXLwN71RHc
         mqv/c9mg36/HcuZdL7wgWW2SfH3vJhAcB5T5Zz3QEXw1nZFhczHl9sBcmUYZOIGynMiE
         +RAlGt6Vom6X8fVjC1DhYUgP9zZc4mQ9/Y6Wz+kQQ9QrEmiaWUy+IGuLeVUiWhOXQzAC
         9gm4FfL1lR6T371ZC5xuVBQLB7BGd+kENa/RngcriSBwQqP16gR74OThZn2mtAiuRupi
         9bzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747657941; x=1748262741;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHsufu+SF6+BkfAoJdbGGEtsqtE+xN15rWNgtA6qUrk=;
        b=LMwF3wQW+X9OLUlEbN4m0FKngLQLlN8jk9++wKN00akYnOSWmyvUW0m7mmvSxZjpNQ
         oO3OQWB0qiPWweSTg5MJrSTw1xcyOw3faYfBgfduAmyk7MN8JOHfDwxE+TRTce2qODeS
         cqvyApz2wlgPAOp+75TfPDdrpapYWmDnY3sqeQ8nxTQlZhrZM+apGa9n78fuPpsN0Ypt
         c4Ry4pYyTtuJZiDKCOCOJA48SLrY1U6rQeYs9Q3ZuoVFr+hu3TtIw/bYh4hXKzFTJs5M
         QK/MuIHU+SMj3FKlBGwZOXeekTKeqxQqUViAmM2KA6yUcxq9D68o4XCDvtcafbfnd8lX
         etNw==
X-Forwarded-Encrypted: i=1; AJvYcCWwFm+duNoTpi13ilLm4F3t3VNFP9v8pQAwrXsFW+2YSC7oSYugDGrZinEv8pEXLPeYCEcs6SriZBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzERs04MKo985UiPaAfX30XWDhQBvb7aAL/BmL6srPGxgE6k0SD
	A63OUNi1zIvwoogGnM1aclXE4+zLB33tJ0SXNezQs7KFStsAMsEJO7Rimso/g+nz1H2wECazAAt
	TZaCxcU79HPsl7zwdDeR1mDssERWMDYCgZ7wko0YHeA==
X-Gm-Gg: ASbGncumeZ0ySCJmsLjqs63wtOnR0egXwZmJBO0brd/BqzokVzMTLA+W3s88sSHPdf1
	w+G+zADe3Hiz12HGJtprKTWy2ThEZaL3n8xrOulkuYeOThn1ie2iYFbcu+hjInmdxePecbLCwf3
	21FztuhxE3fDJYJjNwjeIuWOCIH4iON8JXwg==
X-Google-Smtp-Source: AGHT+IGQJih7ABrJkyHXOxVQqXeWFy+8tRFAAwAelY8XbJK42oN2ccbF+YYkI6zd7QDW809w0lHa6Kx2D4jNl++RLr8=
X-Received: by 2002:a05:6902:1201:b0:e78:f901:6074 with SMTP id
 3f1490d57ef6-e7b6d39c8e6mr15228387276.5.1747657940585; Mon, 19 May 2025
 05:32:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516-b4-usdhc-v2-1-3fccd02f5602@nxp.com>
In-Reply-To: <20250516-b4-usdhc-v2-1-3fccd02f5602@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 19 May 2025 14:31:44 +0200
X-Gm-Features: AX0GCFu0noKnxB0Y5FfzLidgfrO3RarPEU6zn_6BF2jOJDmCis2kwv2FoOkskmk
Message-ID: <CAPDyKFrknTGmptb4K28eHtELEdu_7WXtJwV5L5zyxfzuGeR5WA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: fix few build warnings
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Luke Wang <ziniu.wang_1@nxp.com>, imx@lists.linux.dev, 
	linux-mmc@vger.kernel.org, s32@nxp.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 May 2025 at 09:44, Haibo Chen <haibo.chen@nxp.com> wrote:
>
> drivers/mmc/host/sdhci-esdhc-imx.c:1566 sdhci_esdhc_imx_hwinit() warn: inconsistent indenting
> drivers/mmc/host/sdhci-esdhc-imx.c:1251 esdhc_executing_tuning() error: uninitialized symbol 'target_min'.
> drivers/mmc/host/sdhci-esdhc-imx.c:1251 esdhc_executing_tuning() error: uninitialized symbol 'target_max'.
>
> Fixes: be953af79cc6 ("mmc: sdhci-esdhc-imx: widen auto-tuning window for standard tuning")
> Fixes: 541a95e64d76 ("mmc: sdhci-esdhc-imx: optimize the manual tuing logic to get the best timing")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/all/202505160225.Csr5USfq-lkp@intel.com/
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index c0160c69a027826c4099c9bcf82cd4d83f1113fd..741db169f44d9c9c1e5e1dee591b72221fa1e2b9 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1216,8 +1216,8 @@ static int esdhc_executing_tuning(struct sdhci_host *host, u32 opcode)
>         int win_length, target_min, target_max, target_win_length;
>         u32 clk_tune_ctrl_status, temp;
>
> -       min = ESDHC_TUNE_CTRL_MIN;
> -       max = ESDHC_TUNE_CTRL_MIN;
> +       min = target_min = ESDHC_TUNE_CTRL_MIN;
> +       max = target_max = ESDHC_TUNE_CTRL_MIN;
>         target_win_length = 0;
>         while (max < ESDHC_TUNE_CTRL_MAX) {
>                 /* find the mininum delay first which can pass tuning */
> @@ -1591,8 +1591,8 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
>                          * wider, give auto tuning enough space to handle the sample
>                          * point shift cause by temperature change.
>                          */
> -                        tmp &= ~ESDHC_TUNING_WINDOW_MASK;
> -                        tmp |= FIELD_PREP(ESDHC_TUNING_WINDOW_MASK, ESDHC_AUTO_TUNING_WINDOW);
> +                       tmp &= ~ESDHC_TUNING_WINDOW_MASK;
> +                       tmp |= FIELD_PREP(ESDHC_TUNING_WINDOW_MASK, ESDHC_AUTO_TUNING_WINDOW);
>
>                         /* Disable the CMD CRC check for tuning, if not, need to
>                          * add some delay after every tuning command, because
>
> ---
> base-commit: 484803582c77061b470ac64a634f25f89715be3f
> change-id: 20250516-b4-usdhc-bcd8cea08ed6
>
> Best regards,
> --
> Haibo Chen <haibo.chen@nxp.com>
>
