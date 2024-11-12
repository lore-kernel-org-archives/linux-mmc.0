Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAB5219E21
	for <linux-mmc@vger.kernel.org>; Tue, 12 Nov 2024 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437077; cv=none; b=YwbERUMqCmmYTF5mCquRCcOgYjsZMDvrfCCX+gIDPqyKiIjCZzWO0FNAmMUYWcTs9q8qLhw4Rd5rDq4s5FQMwVmHxCc8T4u9j+OyT3SHW5+sn1TRh7xprGEsYMAbJaBKmNI/4dTbWOAtIwYAxmaMKS1XHgCtHgZvzEuwh0ZNzg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437077; c=relaxed/simple;
	bh=Oa/YrficsfeyjH0/jTjfnABLWOfA6T78uM65AF9s+o8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JuZL0G+QQi+wmQvtZtKh0ejNJyTI5zFJrDbIg41XZ/e/oPp74Gmy2ResR19915oVmKN1gcamZT+MFY2VKZMFFyO+YRVi/x4wlnQtehXyhMgYk5/Gef0vmMkgKvTKUVI66HrpkXwhjdlCvc2OrfCIDcpFk34BgA24PrHCw7kUQfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TNZTecwv; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TNZTecwv"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ea7c9226bbso59411077b3.3
        for <linux-mmc@vger.kernel.org>; Tue, 12 Nov 2024 10:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731437073; x=1732041873; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xGvVgCeLO47x1MsXySaQq6071hjPH/NhHOthZqYhKSQ=;
        b=TNZTecwvlx2iw0NB+5v5GER1r97bOxENB1eMz5KB28cOyVBciLOVze0vhbmFNskiIt
         iD/lRXPfodp/5YeLrbpyMMqdOhSkqLdIp80dkqWUST5hc8JwXcCizlA5A9HF3sMMLGQo
         UanHNml33M3SSmTxkqbFYpfZ5RQd2pe8NrG/bKY6f92RKZ0NrFmnTGu4WtwYXL9ASfAc
         XVhHDMhDD5YqURN7lFoA8LyFLSeNMOSOeikTz9Zal1LZOFZbBXaW9m3n12Vze65n0Miz
         m8CyvxWhiaZVQz2fpXkHCwgr0Tz3m+PynHPnL0X292CoDpa2y1+Qj3X/Dpk3hCxPAfLZ
         QNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731437073; x=1732041873;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xGvVgCeLO47x1MsXySaQq6071hjPH/NhHOthZqYhKSQ=;
        b=keEsj5t8XrkUPMQrNyX+9hWt2JZKuQ4Vbtpu8AiVsX611IVKdBNK+9mLwz9UyuCS1r
         GknIbpAhf3NVimv5cCx/N/VEuLZnKIh4nAwzC8ABhI+mLTutEKckTFTYhPajAkFC6EZj
         kW2O6BYthKVDx405kNsNJ8VoUyp7EY/G9QqxYsQ+vXdtigNlQfkk3SDEV7teKbXCBnGx
         6hoCpqWspIpqJyV1G1LdOxxNNc9+WfmVnsnEEYaO6uQ7ZNufdz8JNVFZYy1xFMVwktDh
         TGX230QFK4MoMzLK/eW7FKjHbbTaTenEnc6CpqbYX4FcA5QBUes+K0pKAhV5REhl0jN+
         NtsA==
X-Forwarded-Encrypted: i=1; AJvYcCUUJIEZjegU7bzXeJQSCTdwB8CELvKfeAb5pLaXYPKZkJMEX8GQCiT32Cc5egHp3bvNnrLm33/t+0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVMloSvBcjuZLZ6vYJ/uVQxNvyFsRoTPEf+vmo/0LSik6YXZe/
	RVWwKlkilhkuT4C5eRtMSRloImNLCNoAegCIafEVi8ii9U2myNxozrIEjL35z/2m/I8ykpCcRZG
	D8gsB7zdWAh9qsKt+h37oiUHh5+mjIJqrvzG+FQ==
X-Google-Smtp-Source: AGHT+IEe8csqC3Pg0F21RvUMA9aG223tYNBFweh8Drp5qTSmfQtunv7apTIfO3K79mr2mEtEH9f9z4XcBwW5aOMunNg=
X-Received: by 2002:a05:690c:2501:b0:6dd:cdd7:ce49 with SMTP id
 00721157ae682-6eca4640ff7mr44651927b3.6.1731437073569; Tue, 12 Nov 2024
 10:44:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241110114700.622372-1-aurelien@aurel32.net>
In-Reply-To: <20241110114700.622372-1-aurelien@aurel32.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Nov 2024 19:43:57 +0100
Message-ID: <CAPDyKFp4t0zHo_sJ3F7D1atwiPK+e38KbhTfcr76Jv+32yUw6w@mail.gmail.com>
Subject: Re: [PATCH] Revert "mmc: dw_mmc: Fix IDMAC operation with pages
 bigger than 4K"
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: linux-kernel@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, 
	Sam Protsenko <semen.protsenko@linaro.org>, 
	"open list:SYNOPSYS DESIGNWARE MMC/SD/SDIO DRIVER" <linux-mmc@vger.kernel.org>, Ron Economos <re@w6rz.net>, Adam Green <greena88@gmail.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 10 Nov 2024 at 12:47, Aurelien Jarno <aurelien@aurel32.net> wrote:
>
> The commit 8396c793ffdf ("mmc: dw_mmc: Fix IDMAC operation with pages
> bigger than 4K") increased the max_req_size, even for 4K pages, causing
> various issues:
> - Panic booting the kernel/rootfs from an SD card on Rockchip RK3566
> - Panic booting the kernel/rootfs from an SD card on StarFive JH7100
> - "swiotlb buffer is full" and data corruption on StarFive JH7110
>
> At this stage no fix have been found, so it's probably better to just
> revert the change.
>
> This reverts commit 8396c793ffdf28bb8aee7cfe0891080f8cab7890.
>
> Cc: stable@vger.kernel.org
> Cc: Sam Protsenko <semen.protsenko@linaro.org>
> Fixes: 8396c793ffdf ("mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K")
> Closes: https://lore.kernel.org/linux-mmc/614692b4-1dbe-31b8-a34d-cb6db1909bb7@w6rz.net/
> Closes: https://lore.kernel.org/linux-mmc/CAC8uq=Ppnmv98mpa1CrWLawWoPnu5abtU69v-=G-P7ysATQ2Pw@mail.gmail.com/
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> I have posted a patch to fix the issue, but unfortunately it only fixes
> the JH7110 case:
> https://lore.kernel.org/linux-mmc/20241020142931.138277-1-aurelien@aurel32.net/
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 41e451235f637..e9f6e4e622901 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2957,8 +2957,8 @@ static int dw_mci_init_slot(struct dw_mci *host)
>         if (host->use_dma == TRANS_MODE_IDMAC) {
>                 mmc->max_segs = host->ring_size;
>                 mmc->max_blk_size = 65535;
> -               mmc->max_req_size = DW_MCI_DESC_DATA_LENGTH * host->ring_size;
> -               mmc->max_seg_size = mmc->max_req_size;
> +               mmc->max_seg_size = 0x1000;
> +               mmc->max_req_size = mmc->max_seg_size * host->ring_size;
>                 mmc->max_blk_count = mmc->max_req_size / 512;
>         } else if (host->use_dma == TRANS_MODE_EDMAC) {
>                 mmc->max_segs = 64;
> --
> 2.45.2
>
