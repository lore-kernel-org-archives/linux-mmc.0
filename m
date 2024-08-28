Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CDC1A2C29
	for <linux-mmc@vger.kernel.org>; Wed, 28 Aug 2024 15:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858648; cv=none; b=UZNJ64nK1mzgNymKbc2mcjEi959pvWPBaGJTFWRTgtpFBx8uguzK1CNhP7JbcOvW0vKFyPfr/JwnJnLzmtzVbzPKsLR2Jbm9elzZAtHme5QBVb4eyMoRBHUoaavCjODy4mfCPjdOTPGQBaDhd+o1BfwyeA616NtltdFfAcFAvcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858648; c=relaxed/simple;
	bh=6lTLmMep23Gq5QDy6ixw4lnYp4CtXa4Ieur1dYyWCo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+cu/3N2Hjymm+qokjT5rn4YLWNYdLWAePXKFZHMs2FiV82qZ6raS1Y9EGLxsUrjZVUsGBwKwaDQ0UpmogXpxjAqCD/CKAZCIORf2rJ/4ASea42mPyJPZDEhyy1b9djaVVCYuU0qqORK36moFjfCgwa0C51A9F6BKPDTB3SfLSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gccSKr4s; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gccSKr4s"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e16518785c2so5831498276.1
        for <linux-mmc@vger.kernel.org>; Wed, 28 Aug 2024 08:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724858644; x=1725463444; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=72MBiybvQQGr50cURl2SciPMebMKvOrZROMVK8UusrA=;
        b=gccSKr4s21mz2NQe+Qdn99WAo3HasqNLC9SPNDguR6GDG+tPDS96WqyKwqsDBnZWfm
         6xcSQ8W6Z/JjEru3IOmB2CUr/VyIJuccopJ9oTNVY6oBaFsCbOzRjkgteN4WhASlx2W0
         hYn2OLbRS/CnNNQdN469FR2NHjWW3wArMuxTSinCpNWci05PbbZ4ryoBJEZiPuc1m3K4
         4jwYV5MqHk8EV9h1xOPkmULR5xVc8un2ENPUb2dnQ+hdx95QeE/ys8+HEUzoq7162GeD
         +vdH5xBIbEJOkVuOq65OgMqrTZzxev/ltENwFe+frU+ieQdbo3eAoIu1BANHNG2SHMDE
         MMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724858644; x=1725463444;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72MBiybvQQGr50cURl2SciPMebMKvOrZROMVK8UusrA=;
        b=MqqoNBDM0Z6GYmeBBVubZ8kMe0/3TDiJ2cM6kj7mrXvKypY1kNW2paMLChsrd/uuBC
         o96QCllCXcT9WsVpw78FdnI4qnrg4Iw0r46nJ5zSjwJA6wYTWW83sOOt81SmJNn53CIe
         oMrhJri6acTtXnIR1mSubwDsPz7bj6NpIB0mJq6o4Rq6Uuzv36c5z2m99dQxnL9dGstu
         /6wVhaX2NnlL7xLTo15vra2lgdalkkbQZOl+4Vs88xdMTgllG+tTMuZgUnqtOvuv1SzI
         Grt0KEi3/GJqb+uWv2XJBqI0ZQX4j6y8+MPkb4QpjzuBtTHKLM3gkW7NTbLnHMpESM66
         H8UA==
X-Forwarded-Encrypted: i=1; AJvYcCW4QSu/oMfQOdfL67Ruh0bQyzK+t5kOrLBub6NN0cizDNgg6x+VCpeLqxS1oHABN2CsBYvg+WB7z4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDvXSmFzUc329Vhr8ToQ3GN6Hv/hbieYhNCL3zSrC4xdp8QLzL
	vCsBm04VIBKCuiEfzH4kEyGWeX2GZfpUWhGyspfVX5tKfPPzVjteeykIocKYB3pKzg1UYN2DOzI
	X1btlHyzIsMi+J+dW8yFEAp2qgP65j19D5+ZZzg==
X-Google-Smtp-Source: AGHT+IEw1gwe9loKd33j5BnDay0Z4DWKG87t3uM+kiZ9PMG5kVY3N6xYGb1nm3Gus4eDR9IPgRMJdqjCoZ65T21zh3o=
X-Received: by 2002:a05:6902:1791:b0:e08:7607:bbf3 with SMTP id
 3f1490d57ef6-e17a8b0fccemr17946173276.34.1724858644032; Wed, 28 Aug 2024
 08:24:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306232052.21317-1-semen.protsenko@linaro.org>
In-Reply-To: <20240306232052.21317-1-semen.protsenko@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Aug 2024 17:23:28 +0200
Message-ID: <CAPDyKFrviGd6ECV-8LOENgepUZZ1OV2j+d+H5NPCjnHYfrijWQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Arnd Bergmann <arnd@arndb.de>, 
	Christoph Hellwig <hch@lst.de>, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@gmail.com>, 
	Matt Fleming <matt@console-pimps.org>, Christian Brauner <brauner@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, linux-mmc@vger.kernel.org, 
	linux-block <linux-block@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 00:20, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> Commit 616f87661792 ("mmc: pass queue_limits to blk_mq_alloc_disk") [1]
> revealed the long living issue in dw_mmc.c driver, existing since the
> time when it was first introduced in commit f95f3850f7a9 ("mmc: dw_mmc:
> Add Synopsys DesignWare mmc host driver."), also making kernel boot
> broken on platforms using dw_mmc driver with 16K or 64K pages enabled,
> with this message in dmesg:
>
>     mmcblk: probe of mmc0:0001 failed with error -22
>
> That's happening because mmc_blk_probe() fails when it calls
> blk_validate_limits() consequently, which returns the error due to
> failed max_segment_size check in this code:
>
>     /*
>      * The maximum segment size has an odd historic 64k default that
>      * drivers probably should override.  Just like the I/O size we
>      * require drivers to at least handle a full page per segment.
>      */
>     ...
>     if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
>         return -EINVAL;
>
> In case when IDMAC (Internal DMA Controller) is used, dw_mmc.c always
> sets .max_seg_size to 4 KiB:
>
>     mmc->max_seg_size = 0x1000;
>
> The comment in the code above explains why it's incorrect. Arnd
> suggested setting .max_seg_size to .max_req_size to fix it, which is
> also what some other drivers are doing:
>
>    $ grep -rl 'max_seg_size.*=.*max_req_size' drivers/mmc/host/ | \
>      wc -l
>    18
>
> This change is not only fixing the boot with 16K/64K pages, but also
> leads to a better MMC performance. The linear write performance was
> tested on E850-96 board (eMMC only), before commit [1] (where it's
> possible to boot with 16K/64K pages without this fix, to be able to do
> a comparison). It was tested with this command:
>
>     # dd if=/dev/zero of=somefile bs=1M count=500 oflag=sync
>
> Test results are as follows:
>
>   - 4K pages,  .max_seg_size = 4 KiB:                   94.2 MB/s
>   - 4K pages,  .max_seg_size = .max_req_size = 512 KiB: 96.9 MB/s
>   - 16K pages, .max_seg_size = 4 KiB:                   126 MB/s
>   - 16K pages, .max_seg_size = .max_req_size = 2 MiB:   128 MB/s
>   - 64K pages, .max_seg_size = 4 KiB:                   138 MB/s
>   - 64K pages, .max_seg_size = .max_req_size = 8 MiB:   138 MB/s
>
> Unfortunately, SD card controller is not enabled in E850-96 yet, so it
> wasn't possible for me to run the test on some cheap SD cards to check
> this patch's impact on those. But it's possible that this change might
> also reduce the writes count, thus improving SD/eMMC longevity.
>
> All credit for the analysis and the suggested solution goes to Arnd.
>
> [1] https://lore.kernel.org/all/20240215070300.2200308-18-hch@lst.de/
>
> Fixes: f95f3850f7a9 ("mmc: dw_mmc: Add Synopsys DesignWare mmc host driver.")
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/all/CA+G9fYtddf2Fd3be+YShHP6CmSDNcn0ptW8qg+stUKW+Cn0rjQ@mail.gmail.com/
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Applied for fixes and by adding a stable-tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 8e2d676b9239..cccd5633ff40 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2951,8 +2951,8 @@ static int dw_mci_init_slot(struct dw_mci *host)
>         if (host->use_dma == TRANS_MODE_IDMAC) {
>                 mmc->max_segs = host->ring_size;
>                 mmc->max_blk_size = 65535;
> -               mmc->max_seg_size = 0x1000;
> -               mmc->max_req_size = mmc->max_seg_size * host->ring_size;
> +               mmc->max_req_size = DW_MCI_DESC_DATA_LENGTH * host->ring_size;
> +               mmc->max_seg_size = mmc->max_req_size;
>                 mmc->max_blk_count = mmc->max_req_size / 512;
>         } else if (host->use_dma == TRANS_MODE_EDMAC) {
>                 mmc->max_segs = 64;
> --
> 2.39.2
>
