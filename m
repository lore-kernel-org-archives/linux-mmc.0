Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F7367E69
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jan 2024 12:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706616442; cv=none; b=SsZMS0Vj7QFCn8S4+iduBeY8zCMCJgXFEthq5Tx52bd/3IoMjUdGkGiG2D29csPtZwXccrJuKYM5dPfX5DOWO36tsM4ynHx6oQBlI7YqR2aLPaATmpMu9RTsR+uOV++4Ivu4DpLQaheeLM2LZoAhH7R6Cchh8O+zs59zJN4+MeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706616442; c=relaxed/simple;
	bh=FPK5d6wZ3tRsi+P+mD8Fl6iT3s4MZM+/HZrzEsQWlMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CpeIDrPNLrjjVYdZxFlJ0zCpMZ1acK9bHaTDiobSSnK1X1kBJvSe7qoR/dNJTUmwD0obrrUmyYAnUUMK/ylv5DRoSPYLZBju6hk2K9mFfUcAqGx5EhIr9Re01MU1qNxHpIsHsazVCSslQXe91VLfeVaKqOZYMXveFWsyOyhZOwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kn6MSuMt; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kn6MSuMt"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-602b7cef983so45878087b3.3
        for <linux-mmc@vger.kernel.org>; Tue, 30 Jan 2024 04:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706616440; x=1707221240; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=63pL5ic4j14Z3rxqAwcvu11MNf/ECwDkUdquteX6BAo=;
        b=kn6MSuMtOrYVRVWE2jIc88jNFZ0QcWg1hbUppKOJyBg8AHN2HaUa96ePkhaeY+2AcV
         fNgdEJzNTnz4VCmQsAsOE77IHsomJLzqep5MWzOvzWPLNmp70UV3pUyTzoe5czUUSDet
         cs6pu8B+OCACb5R0Fx1iWtcTvx6ndCkTZ6oILr4TW9wXgVAWG3n+32AxfM+jQoW5Na1M
         rNOxBeeOf1l7IBYf4tz7AFHe1ESZqzmtY7xsMLRNhj668Gd2cc/kuGvM2PnEpDBhgx9I
         YqXgj1m4QiLKoDEYbuw0PsZ+MSJH2WCdzN7RTpnEfzUf0Ujryp4/34ywrXTkMH2/EmlQ
         v2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706616440; x=1707221240;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=63pL5ic4j14Z3rxqAwcvu11MNf/ECwDkUdquteX6BAo=;
        b=HIYVXoT7Qsk8+ChQq1Hq+mKkdTZ8/PM5Zsan9oDFA52tZmMoGhCxRxxxX97viR/19c
         vKa6cGSbiHRD9AEVTubQgjGzY8bHJQtLceVtme6cuGezsOymNDCCW8bp9R/UuRDVPbv+
         VQh75Aggq6DrzSQDtU24WOVRhOrkMt+AFmPOCWYQ9GXoeZTGDHetu+M4Mj35uCDlsuoN
         t/KUbis2J/hUtTBey1tRolv/3gMA7uaIYTlVysPH7YRwnkLDCJ5Ze+UUaxwFMNKZdCo1
         H/Sul3r0ojiLN7OgQrmqhsm8ZlzXCd6ZaLFFwOhbiSctKsMDlp42DPC1hnd1iJ+PrNDh
         QdhQ==
X-Gm-Message-State: AOJu0YyeY8ccpYuVAp2Ik6Z/TYtLwzX7DCuKkrRpBwyqxRRxn3L4AtKY
	bmIa3PRhHPHpjOrtIucAt2+KEVzrCLl0KM8Z3lMLdjn0bEC8roSgmEwYeAzvt1uYdeUHs9NjRU0
	HU06efcamRTpxRsgktMkaz9EXmmVhHNyoja5Vyw==
X-Google-Smtp-Source: AGHT+IHh26xMVRbTQoIdXhYrRHLz+HXM2q/jhvMQqq2NnnS84TTGT/FvWrIgUfAdMbTgWpv+93PdlF8+WHDn5Um7O3o=
X-Received: by 2002:a05:690c:f8d:b0:5ff:d4c1:48f9 with SMTP id
 df13-20020a05690c0f8d00b005ffd4c148f9mr8705324ywb.0.1706616439736; Tue, 30
 Jan 2024 04:07:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125-mmc-no-blk-bounce-high-v1-1-d0f92a30e085@linaro.org>
In-Reply-To: <20240125-mmc-no-blk-bounce-high-v1-1-d0f92a30e085@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 30 Jan 2024 13:06:43 +0100
Message-ID: <CAPDyKFrOOX1PaqrH08icGFMLYeCv9ru7FwjN-Xhp6H_jUSt0BA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core Drop BLK_BOUNCE_HIGH
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jan 2024 at 09:50, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> The MMC core sets BLK_BOUNCE_HIGH for devices where dma_mask
> is unassigned.
>
> For the majority of MMC hosts this path is never taken: the
> OF core will unconditionally assign a 32-bit mask to any
> OF device, and most MMC hosts are probed from device tree,
> see drivers/of/platform.c:
>
> of_platform_device_create_pdata()
>         dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>         if (!dev->dev.dma_mask)
>                 dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
>
> of_amba_device_create()
>         dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>         dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
>
> MMC devices that are probed from ACPI or PCI will likewise
> have a proper dma_mask assigned.
>
> The only remaining devices that could have a blank dma_mask
> are platform devices instantiated from board files.
>
> These are mostly used on systems without CONFIG_HIGHMEM
> enabled which means the block layer will not bounce, and in
> the few cases where it is enabled it is not used anyway:
> for example some OMAP2 systems such as Nokia n800/n810 will
> create a platform_device and not assign a dma_mask, however
> they do not have any highmem, so no bouncing will happen
> anyway: the block core checks if max_low_pfn >= max_pfn
> and this will always be false.
>
> Should it turn out there is a platform_device with blank
> DMA mask actually using CONFIG_HIGHMEM somewhere out there
> we should set dma_mask for it, not do this trickery.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/queue.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index a0a2412f62a7..316415588a77 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -351,8 +351,6 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
>         if (mmc_can_erase(card))
>                 mmc_queue_setup_discard(mq->queue, card);
>
> -       if (!mmc_dev(host)->dma_mask || !*mmc_dev(host)->dma_mask)
> -               blk_queue_bounce_limit(mq->queue, BLK_BOUNCE_HIGH);
>         blk_queue_max_hw_sectors(mq->queue,
>                 min(host->max_blk_count, host->max_req_size / 512));
>         if (host->can_dma_map_merge)
>
> ---
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> change-id: 20240124-mmc-no-blk-bounce-high-d84e8898c707
>
> Best regards,
> --
> Linus Walleij <linus.walleij@linaro.org>
>
