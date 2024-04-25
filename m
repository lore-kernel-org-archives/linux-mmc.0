Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E861D14D2B6
	for <linux-mmc@vger.kernel.org>; Thu, 25 Apr 2024 16:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062171; cv=none; b=muE/3rPXqWJenKSt/e2j5V0BHF64TEQp+IDFX39mV5U3S9pwgELSIFKN/YewaoHaPY3Qz852E01HgXTnDtp8i8JiiTZYepXlxDrtoU7IYu87vMNQu2Q6ludgegfWV8Xjv7wyJZkXhhQ8A4od+o7hAGkj4HOl+RaLat5mCae250U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062171; c=relaxed/simple;
	bh=/rReCEuAMvcIKbmMv9ogQv0Z3HLmmd9oE09QV3FUlWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AeTkD8IvArpByd1zhVJW42h48Hq2kLhPZ/5jVG4deJ0hdDR/SVgEtin1ptvxfGfyaU9PSY502d67Px9Q5af6qvJQ/Fqix6vd4n46DWOnbXldfpo+l3ngmYxg8VBdeB8wMcCuEMlliVViDJdvydVT3ETS7mDgQ6/5EOvZx62jjus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bq/9dLZv; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bq/9dLZv"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-61b4cbb8834so12792557b3.0
        for <linux-mmc@vger.kernel.org>; Thu, 25 Apr 2024 09:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714062169; x=1714666969; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4MKpUjL2KzQj6h5dKRJa50XoAW5l7/ldp0RpO3SKl4M=;
        b=bq/9dLZv+XLsn+Mt2oAST13u4T6rT4u/mW+cRkGpNfloChh+Dg+I1EhfNvAIgC4UAx
         Cw4AYlf7zPZjicBf0VIM6SFmvHj0Yrcu+tVeHZcWeirG/R/2/HRM1CBenDMjqxA4zPSH
         wHEBbamTTgXsRmzwtnwKhEuawpydJEhrJfcP9IZIxABBkm9F8nIdBle191dhamfYNVBk
         cSGslWpE2HtoHV7PCLkv2nNqyGSkYiSACmVvs2Xw63To6Rz2EpdiFDfdzCfh2+F/MI4s
         UB9DkKQJmVZRiiNOGepz1uvVT5NVXDmU8xU9yJYabGE/XcnvylnUQh0IztyJu+CP/HbP
         Ywzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714062169; x=1714666969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4MKpUjL2KzQj6h5dKRJa50XoAW5l7/ldp0RpO3SKl4M=;
        b=YkxJoZRRkmk0wZ2raioEm+3hhpR0leqkDIcDPXJkLNqm+AG/R/NCgWbV1okGlyJuef
         6gepzE8oVYBSbhOmWKjV5zW6ERo+bUSwGBILCYThexoIQ2aLvOZEubInBKSe4apwSrZS
         JDXykEVlbsaEKxY+W2oR9FEKvjW863Bb71/z3fUX1zeUk2p4ME+otxGNqzCZHzS3uj94
         X9R7Ub5jbwyRdO3jr9wV/dp6MxWyJeAFlIHFNAG/ISyz74kRFK2mbNT2EMGRJ4WX5c6C
         T71vNDJ4jGQqvqckzd4YWXMLxOH8KfhkxvHq3FpzlqfHmBUh2uvLhKvLh8i+BoRbf3x5
         jvXg==
X-Gm-Message-State: AOJu0YwA2oLMiPzhxLjbefbG2uUskgRzLdP+1X8E70UaNBXq6+T+pJBk
	2DXOaddV0ysObjJPx4hQl/suJp9PPyPfCxt9A2chhG+DJLZ1c/BMymQwT4K4KkccM+rzdlHWnIg
	tmvN/XnKBsYUj+AY6iR6kyyHMhSaf2o9mtfzOzw==
X-Google-Smtp-Source: AGHT+IHrGBjRWx+miqjtWMw1Fv88F4iCyOHrsayI3iFSE23Qx1hC89dADnEC3+0DcmZ43uwnayrhh+t5CHgiCqzIknI=
X-Received: by 2002:a05:6902:1b89:b0:de5:4eef:1b5b with SMTP id
 ei9-20020a0569021b8900b00de54eef1b5bmr175734ybb.5.1714062168943; Thu, 25 Apr
 2024 09:22:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422153607.963672-1-saproj@gmail.com>
In-Reply-To: <20240422153607.963672-1-saproj@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 25 Apr 2024 18:22:13 +0200
Message-ID: <CAPDyKFri5Zk63vnp6sMRSMfprLCo4SdVBJf-C1zgYQKWyizSJg@mail.gmail.com>
Subject: Re: [PATCH] mmc: moxart: fix handling of sgm->consumed, otherwise
 WARN_ON triggers
To: Sergei Antonov <saproj@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-block@vger.kernel.org, 
	linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Apr 2024 at 17:36, Sergei Antonov <saproj@gmail.com> wrote:
>
> When e.g. 8 bytes are to be read, sgm->consumed equals 8 immediately after
> sg_miter_next() call. The driver then increments it as bytes are read,
> so sgm->consumed becomes 16 and this warning triggers in sg_miter_stop():
> WARN_ON(miter->consumed > miter->length);
>
> WARNING: CPU: 0 PID: 28 at lib/scatterlist.c:925 sg_miter_stop+0x2c/0x10c
> CPU: 0 PID: 28 Comm: kworker/0:2 Tainted: G        W          6.9.0-rc5-dirty #249
> Hardware name: Generic DT based system
> Workqueue: events_freezable mmc_rescan
> Call trace:.
>  unwind_backtrace from show_stack+0x10/0x14
>  show_stack from dump_stack_lvl+0x44/0x5c
>  dump_stack_lvl from __warn+0x78/0x16c
>  __warn from warn_slowpath_fmt+0xb0/0x160
>  warn_slowpath_fmt from sg_miter_stop+0x2c/0x10c
>  sg_miter_stop from moxart_request+0xb0/0x468
>  moxart_request from mmc_start_request+0x94/0xa8
>  mmc_start_request from mmc_wait_for_req+0x60/0xa8
>  mmc_wait_for_req from mmc_app_send_scr+0xf8/0x150
>  mmc_app_send_scr from mmc_sd_setup_card+0x1c/0x420
>  mmc_sd_setup_card from mmc_sd_init_card+0x12c/0x4dc
>  mmc_sd_init_card from mmc_attach_sd+0xf0/0x16c
>  mmc_attach_sd from mmc_rescan+0x1e0/0x298
>  mmc_rescan from process_scheduled_works+0x2e4/0x4ec
>  process_scheduled_works from worker_thread+0x1ec/0x24c
>  worker_thread from kthread+0xd4/0xe0
>  kthread from ret_from_fork+0x14/0x38
>
> This patch adds initial zeroing of sgm->consumed. It is then incremented
> as bytes are read or written.
>
> Signed-off-by: Sergei Antonov <saproj@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Fixes: 3ee0e7c3e67c ("mmc: moxart-mmc: Use sg_miter for PIO")

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/moxart-mmc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
> index b88d6dec209f..9a5f75163aca 100644
> --- a/drivers/mmc/host/moxart-mmc.c
> +++ b/drivers/mmc/host/moxart-mmc.c
> @@ -300,6 +300,7 @@ static void moxart_transfer_pio(struct moxart_host *host)
>         remain = sgm->length;
>         if (remain > host->data_len)
>                 remain = host->data_len;
> +       sgm->consumed = 0;
>
>         if (data->flags & MMC_DATA_WRITE) {
>                 while (remain > 0) {
> --
> 2.40.1
>
>
