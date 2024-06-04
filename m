Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70305146007
	for <linux-mmc@vger.kernel.org>; Tue,  4 Jun 2024 11:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499667; cv=none; b=aO7MSL2M3C1xwgza57AabnY3z9s4XwV88VnQd6k5moFqiE5BU0qyQsH5aM6ghKLVRKKc0sSnenlF8/5KCM2WJpW/k9POMmh+TnrwCGipEcXSpuKshsMLqCrHfdQ6ZIa4aRQC2UaEe83mArD3UONMOO1swEh2ZXyBf12E61ZH78c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499667; c=relaxed/simple;
	bh=8x1HdwF7lm+0XQBbxfRRHEcS3NdGYDmeY4IfWWJhKmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkcr9j3n41EhLjMRQcTiItlCqVqNk4iQwcdtN9rnSXVy4msZtE0VYGd6NnoK53LaBRtOlYwrlb0SsUZaG1EpYdL9NQW1DchEa0TK+60V6zQiJHGUpvEJ4vFFq3E5fd4Cil8TpRMNbTDY9iHY0vJIK4CJrYaKbfBs2rFDKz3+V8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L8ErJXtm; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L8ErJXtm"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dfa48f505dfso5448131276.3
        for <linux-mmc@vger.kernel.org>; Tue, 04 Jun 2024 04:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717499663; x=1718104463; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eq/HBqCgJ9qMRdIfKiqytQyj6xuMx2f9KN0gcUKcbJM=;
        b=L8ErJXtmEE2WvNIVwgoyzEo/wH/g+tbUdpd6r0uhW9HMX9ju6/ZXs1HUJUuX0QE3bm
         H5WqUZwVcaFBSXtaLj0n1dX28Uy+OMTilHd3wLAubmO8K1aBXyORPtHzRE3odMo2lI9a
         qVBKQ7k2KVtJpX7u2QVahqlPr3M5juWvfFq0aBGqYNzpE6omwylyG1MVenWVtSg8nCCP
         80BzUtnxwIOejo0L6rgoOKBqrm7ZGLq44HWswTTxELQRhY5qqb+ht9DvSoIitS2uoDzB
         P3KUwfNYH2XKf9yeswk/3B/jfTJvQPmvpKnjaXb4ZNWV8nct5CyGzmccynhVf2QWaWSz
         trfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717499663; x=1718104463;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eq/HBqCgJ9qMRdIfKiqytQyj6xuMx2f9KN0gcUKcbJM=;
        b=rTVFLm0C3CdLPLUoZ9ciglWiuT6uUPC+XPgRa622+NfL5+oAmrSXtTssz0Mb1/xLi3
         5viqiZXDSBpkmdQroT06e8Bvii6UnrwmgJ4W2nvUhZhQdwR8B8u1xwzC3K4rxl7/H0+e
         lrZSvqdRuBKjf29VwDC6Lbq4+J9zQK1nmXLirZMOMe3FrjT30YRbxhfZacFGs6ljC2IK
         J3B5JYhdZnmhWvtjxLNvi9xPJEjqFJzfFoSE/CPEck0dI8dhuTM8jUdZx4IvTadpEczP
         Gf3mF0WRfi59A18Dy8HOxdZrAOkYQ6x5tdKGDBBL1k/RJOBOtDfOCLwFJIeIrtGx2pkJ
         jmzg==
X-Forwarded-Encrypted: i=1; AJvYcCV/XZ7BY62Fg64NflyLMqiXPDNozq8yPuQY1OPUgAzHJaAUWGt8VflIwJEcnc2Y1jzjue7A0BVDPANBWcSsr7RYThAaDIQ5cYIv
X-Gm-Message-State: AOJu0YxmEszs8QLSIfjSXDlri9is/Xi4Tk/2SouXysWquAwGwkL3ONbu
	XU6aR+wBdtsLnbP4LiKfkoMdRfKZHhuvoE/lg2W6orQgz0SkeW93wWCBTmCNGOZ7jM34nf7Kdw9
	UqOYyRk11S1R691KEDVMeU0dnuu9Dx1DfsFElnH6VikN1Se+X
X-Google-Smtp-Source: AGHT+IHnH3LEJPAZmIpQIaepZMJj/R7GrQgTTuSPsTt7P5EJQI8pQUPXtqblajPZ78RjjZhiUbK9MzR/x9xrz3DwFdo=
X-Received: by 2002:a25:dbc4:0:b0:de6:1645:499a with SMTP id
 3f1490d57ef6-dfa73c24476mr11467680276.30.1717499663432; Tue, 04 Jun 2024
 04:14:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530215547.2192457-1-heiko@sntech.de>
In-Reply-To: <20240530215547.2192457-1-heiko@sntech.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Jun 2024 13:13:47 +0200
Message-ID: <CAPDyKFp3hPJ02W8O0T1RjcNYor3HCK9VTjOHmjPKoP7YJ+1-jw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: set CQE irq-handler for rockchip variants
To: Heiko Stuebner <heiko@sntech.de>
Cc: adrian.hunter@intel.com, serghox@gmail.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quentin.schulz@cherry.de, 
	Heiko Stuebner <heiko.stuebner@cherry.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 May 2024 at 23:55, Heiko Stuebner <heiko@sntech.de> wrote:
>
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>
> The dwcmshc used on Rockchip rk3568 and rk3588 can use cqe, so set
> the needed irq handler.
>
> Tested on a rk3588-tiger SoM with dd, hdparm and fio. fio performance
> does increase slightly from
>
> Run status group 0 (all jobs):
>    READ: bw=209MiB/s (219MB/s), 209MiB/s-209MiB/s (219MB/s-219MB/s), io=4096MiB (4295MB), run=19607-19607msec
>
> without CQE to
>
> Run status group 0 (all jobs):
>    READ: bw=215MiB/s (225MB/s), 215MiB/s-215MiB/s (225MB/s-225MB/s), io=4096MiB (4295MB), run=19062-19062msec
>
> with CQE enabled.
>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 4410d4523728d..3c203857189f9 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -908,6 +908,7 @@ static const struct sdhci_ops sdhci_dwcmshc_rk35xx_ops = {
>         .get_max_clock          = rk35xx_get_max_clock,
>         .reset                  = rk35xx_sdhci_reset,
>         .adma_write_desc        = dwcmshc_adma_write_desc,
> +       .irq                    = dwcmshc_cqe_irq_handler,
>  };
>
>  static const struct sdhci_ops sdhci_dwcmshc_th1520_ops = {
> --
> 2.39.2
>
