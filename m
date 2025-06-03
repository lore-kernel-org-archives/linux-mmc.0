Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD153229B12
	for <linux-mmc@vger.kernel.org>; Tue,  3 Jun 2025 13:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748957686; cv=none; b=bJLPHsKxamazaHA1Zd1nANhtoTBXc/SMgvQovOfYp0qtKRIOA9vJ6EuLDpiKx3acGmpuXliLq7hgTHGz+Ur3C2UgpV333/APImY5IeyZSE5VfPOf6aAiGbnlc0OrGPWKGcMKWP1sOQ9hNzeNz8KT4Kt9V5VGVf9JzEneUkISYD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748957686; c=relaxed/simple;
	bh=SrhzCvdR8YuAr+YwML3vHp57imhJuC83RgqHYrjmhx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OFYRDdiIHmwKqecH4LTDY7MJe7y64I8ciOhhEoniCj9jSnFukZHnVqfBCxc5Le3oMWOTdpzDOL3bkAnFjAmbK6JhMSPVWUvLyy5TQtiIoGL6aUImDGpqR4qYewJjLCuQJ3MnZLP1vkgNj28lofdX5/tnWZcDSxN0z9JdoeHt1wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnixcVQ7; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnixcVQ7"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-747c2cc3419so2976926b3a.2
        for <linux-mmc@vger.kernel.org>; Tue, 03 Jun 2025 06:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748957684; x=1749562484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trNEQykqDi6CfLI+wLybBJ7HMWeWXO7YE3wr77B1xOU=;
        b=QnixcVQ7uVIxanRezK6GA2VzVz75DJ6GbYeoLh321poklUGqAfdeCq4XeuptDJzP/O
         FgKehu2ezbv+dHJPvQnFcDK+p7T0fYPgA4FWeAXEzb4eIzuSrIwRM6JS1QrxAnntuBqw
         dIov0senltaHMOhKzlIIIQRSs0rAYDa3zV9YzNngDg9ZSs/dxcBkaikW41g1XB/lNP0J
         8kYEHEHeoOUVxOzyJrRTIzYL58n0egoyrgvcQ/jitfRuuk7IRU7ke9cRlGsCZ64BF6Y2
         dsbOjZMZJZr7S4yyZ/riVqo89PwLxTATi8eYEdjAuP+QXgZhDrA/vCtZObBNRRtbFlzX
         J9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748957684; x=1749562484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trNEQykqDi6CfLI+wLybBJ7HMWeWXO7YE3wr77B1xOU=;
        b=Q0OAfoFRDKyBkXLVXkVaSu3T/FsgXzIJbdqOiavbGHLF6fwccCxCTfTY9bCiybHWxo
         cTIccBhpm608P9aATplbWwYvMb4Qdwu2f5BytWR7pNyVFUXNMINmGzYx6ZqjH9DfuEEB
         kL0tpi/u+h8USbwwAX2B+rdxtPj+aqyzznPiA0jEE9OcsJCiWHl6G1Dqe1hmFtPr9Fpq
         WYOSdaJ5J3jIKh8VpsMZQju0AE7SGHSdIZqTYajb8t4Xu7DOAuNq+o1Vwl6+xffcPlWI
         Em4Yg6AznXs0jAjB6IuKALkhIhJC14pp8x9EPAonSnEI9NbaQiXDhr1EAWrNvmSgBBeA
         OaPA==
X-Forwarded-Encrypted: i=1; AJvYcCUSgc/cfIMs9UXNxeHiIhw53BxA8mRc7xhssZ/K8+TXrnGIJNNXmIyPJA1qqBazCNmS6JzhSjx3PYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySpo3g2D2zSz8YJxL4pX/LMUPoS/31G4mvWI/6bjD1lQ020rvn
	vT+gTPfgn27Z0kn6mUYUNuMcfL4k46fobSpVo0DZaEqYcOkbkEG+ak6ihr7GbBmFjgLswFK0kQu
	Z8lORvLGZvhUmTPWOkIpG2piDKP7piT0gsg6f
X-Gm-Gg: ASbGnctxg/On+X8z2+OkrAk8BYF2/WV1HO9KuMbpcPNKWjf/P3ht3SaPaAvufdhwoN3
	eTtCxyLDm+4Bsc7EnzxXOTB0qXIAt3YLjyyJ2A4hC3jDORdi4d8ct/QOFO1B2P9HofvkauF9Hoi
	T95rvhZoXzLDaHc55rYUiTBf78SfSYBuPIjIeCcXXfeqTzPLoeLkSJrK/DE1+UZniY
X-Google-Smtp-Source: AGHT+IHhWi1qtCAZfHrBmZFFUS5eIhspUwqpuRxatCXVCYGjm/rPbNwgSo176ui+AKedax9GXTrgjGFVYrdyMcWkuxc=
X-Received: by 2002:a05:6a00:1793:b0:736:50d1:fc84 with SMTP id
 d2e1a72fcca58-747c1c5f723mr21877575b3a.21.1748957684000; Tue, 03 Jun 2025
 06:34:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1748933789.git.zhoubinbin@loongson.cn> <7da94643484f7184be40fa517a8a74ce3cdefe19.1748933789.git.zhoubinbin@loongson.cn>
In-Reply-To: <7da94643484f7184be40fa517a8a74ce3cdefe19.1748933789.git.zhoubinbin@loongson.cn>
From: Manuel Lauss <manuel.lauss@gmail.com>
Date: Tue, 3 Jun 2025 15:34:06 +0200
X-Gm-Features: AX0GCFvc-Rj0xrqJlyuASFH3G_0A7CzwCw-355bTxWMzz-YLhiBr1FXRjybkYdo
Message-ID: <CAOLZvyG-vxBnYaPD-AuEyhjmXU-DQNOEmZUJVYcsLkOgdOObHA@mail.gmail.com>
Subject: Re: [PATCH v3 03/36] mmc: au1xmmc: Use devm_mmc_alloc_host() helper
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Huacai Chen <chenhuacai@kernel.org>, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jun 3, 2025 at 2:25=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.cn>=
 wrote:
>
> Use new function devm_mmc_alloc_host() to simplify the code.
>
> Cc: Manuel Lauss <manuel.lauss@gmail.com>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  drivers/mmc/host/au1xmmc.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
> index 057d42307832..85470773650d 100644
> --- a/drivers/mmc/host/au1xmmc.c
> +++ b/drivers/mmc/host/au1xmmc.c
> @@ -937,11 +937,10 @@ static int au1xmmc_probe(struct platform_device *pd=
ev)
>         struct resource *r;
>         int ret, iflag;
>
> -       mmc =3D mmc_alloc_host(sizeof(struct au1xmmc_host), &pdev->dev);
> +       mmc =3D devm_mmc_alloc_host(&pdev->dev, sizeof(*host));
>         if (!mmc) {
>                 dev_err(&pdev->dev, "no memory for mmc_host\n");
> -               ret =3D -ENOMEM;
> -               goto out0;
> +               return -ENOMEM;
>         }
>
>         host =3D mmc_priv(mmc);
> @@ -953,14 +952,14 @@ static int au1xmmc_probe(struct platform_device *pd=
ev)
>         r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         if (!r) {
>                 dev_err(&pdev->dev, "no mmio defined\n");
> -               goto out1;
> +               return ret;
>         }
>
>         host->ioarea =3D request_mem_region(r->start, resource_size(r),
>                                            pdev->name);
>         if (!host->ioarea) {
>                 dev_err(&pdev->dev, "mmio already in use\n");
> -               goto out1;
> +               return ret;
>         }
>
>         host->iobase =3D ioremap(r->start, 0x3c);
> @@ -1109,9 +1108,6 @@ static int au1xmmc_probe(struct platform_device *pd=
ev)
>  out2:
>         release_resource(host->ioarea);
>         kfree(host->ioarea);
> -out1:
> -       mmc_free_host(mmc);
> -out0:
>         return ret;
>  }
>
> @@ -1151,8 +1147,6 @@ static void au1xmmc_remove(struct platform_device *=
pdev)
>                 iounmap((void *)host->iobase);
>                 release_resource(host->ioarea);
>                 kfree(host->ioarea);
> -
> -               mmc_free_host(host->mmc);
>         }
>  }

This is also fine with me.

Manuel
