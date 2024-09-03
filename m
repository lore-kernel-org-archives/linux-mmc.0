Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64C91D0492
	for <linux-mmc@vger.kernel.org>; Tue,  3 Sep 2024 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367074; cv=none; b=rX3E4avunbmAWgive1EmosclT4XNZEbcvDh4rSx0uVxYO44yayoJIN8hZ7LT2gn3J5j7AWqCgpo54P3fxzzkBAF3QoYDw/zz8im7DTeEeDyCx+wAHwzTQr+G5OHpqTZ4YLT07sCFEfvD7RaroaCSzPl8eASR9OwE/vdVsQm6dYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367074; c=relaxed/simple;
	bh=vAJYUB1JYAdTSCX3IiQu6MnRzSD3ZDq0H7nrMseKveQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ay2uaADvYuHN4ijW95gvvFpk43cFRI3mNur5JFVh+fm0hTMj2+VmZxjwsrVf0Fo9zCC8dGT5k0xKSmkiV9UQffWgN/ZKjEf06J5WJwMB7vPyziwO5JfBCR5fGdyD7r5VEHTvlyzoPj1FbAy7aV3pZG1lEFQZlF19dhcnnHQc31o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DSHOxEmR; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DSHOxEmR"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e1a74ee4c75so4171993276.3
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2024 05:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725367071; x=1725971871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gDo+yVD+3RYI+5zJwy/WNiTtLCeqz/kJT8uN33xHNmA=;
        b=DSHOxEmRM+WOqbDOk8xdSm/1Rg8Rdt4NVzNc5xWfnTKdbAscy4IchfB7kEvG4/BXzT
         Z8kEnjYRDRJvr1kQvAxLvNJ/Rkhtv8odHEeLM15wHFZrjVGbRtuB7fY1gp5ipUQELxMc
         lWkDZVkYhLSnLxMXy3UvZL2g3OqC5AlFS16L0a4bvXNs/Z+Erasrclayn5VxJc+lbrGR
         aFsvrIO79DyOFJNKEWVq3bB2Oy84bfp7UdlP/9YQYrI3yK6KSDuqEQbX9TOfiSGYekLR
         5SssdRf9nRrOY0jzzeaM0E1uYVNWTTFjyPwrevp7dw8A/7Sd+DnvPbs7NUKrOqIvUGbq
         OCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725367071; x=1725971871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDo+yVD+3RYI+5zJwy/WNiTtLCeqz/kJT8uN33xHNmA=;
        b=jzTN+m7Kjfc/m6RbqTcyDEbP9UCYxcfjBStMMF+++NxDjGQtismhA6+pr+rh5eu3Kb
         EdTXfyf2/OlobNdGiGqXF8h50ByXJhcibfJ14o3oCaM9KHSMrdsESYi7nmQQV6nQ32hi
         gOhi7K82EI6zPzOpffMKNkbIizXCCS6gw1HPirVVR1YK8qNLOteQDPk6azZF7Nc2wgPU
         l3z2fvaFRwLcnxuIFVWwJCHAU4nmpd+km1Hs5gv7II3yvKmWXKDIfdEfQ2i4hHNR9SEl
         lLl/mi4w5UUqLG+qoJJWMfICvl3ayU9iYgZxS1KbvbqlCDX5h7eq+HJvc+pKxu/TaT3s
         vLpA==
X-Forwarded-Encrypted: i=1; AJvYcCVdxzPsqJwSivniGDzbtkp7tF2Kp4g/w6Uckke1eynyltsX3kyx2Q34SphuFbu0Qnk5HzvM/Td0YQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdyJUiMKp1xOx9IxzjKK80vzsM1+DsUSAA3MALjUaiuRZA3h+2
	vj0UaB3c9Uy5xUU2sbhPV9uj/PHSSzXxWa7LApEYmCNbc6z/vJ0f/Vsz3A489SkKzjE10WhI5YQ
	8VUvSJabqr2Mqay70UDHC6z2RODUe/UlSGwSGRQ==
X-Google-Smtp-Source: AGHT+IG7wVWvBwVm8d9fEbO3Oflgii2VupDav0zWIgeWSdeL76IOqUTeZJcnUewS4XpCOBcCGjv00I2YWnT5Qsdy31k=
X-Received: by 2002:a05:6902:2493:b0:e11:7850:ac6e with SMTP id
 3f1490d57ef6-e1a7a1d0785mr13896773276.50.1725367070896; Tue, 03 Sep 2024
 05:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240829061840epcas1p4ceeaea9b00a34cae0c2e82652be0d0ee@epcas1p4.samsung.com>
 <20240829061823.3718-1-sh8267.baek@samsung.com> <20240829061823.3718-2-sh8267.baek@samsung.com>
In-Reply-To: <20240829061823.3718-2-sh8267.baek@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Sep 2024 14:37:15 +0200
Message-ID: <CAPDyKFrpLoV_X0cp4ycEeEj_Vhv0+1nmQ87+QVNV-o+Z0YEgmw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: cqhci: Fix checking of CQHCI_HALT state
To: Seunghwan Baek <sh8267.baek@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	ritesh.list@gmail.com, quic_asutoshd@quicinc.com, adrian.hunter@intel.com, 
	grant.jung@samsung.com, jt77.jang@samsung.com, junwoo80.lee@samsung.com, 
	dh0421.hwang@samsung.com, jangsub.yi@samsung.com, sh043.lee@samsung.com, 
	cw9316.lee@samsung.com, wkon.kim@samsung.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Aug 2024 at 08:18, Seunghwan Baek <sh8267.baek@samsung.com> wrote:
>
> To check if mmc cqe is in halt state, need to check set/clear of CQHCI_HALT
> bit. At this time, we need to check with &, not &&.
>
> Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")
> Cc: stable@vger.kernel.org
> Signed-off-by: Seunghwan Baek <sh8267.baek@samsung.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cqhci-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index c14d7251d0bb..a02da26a1efd 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -617,7 +617,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>                 cqhci_writel(cq_host, 0, CQHCI_CTL);
>                 mmc->cqe_on = true;
>                 pr_debug("%s: cqhci: CQE on\n", mmc_hostname(mmc));
> -               if (cqhci_readl(cq_host, CQHCI_CTL) && CQHCI_HALT) {
> +               if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT) {
>                         pr_err("%s: cqhci: CQE failed to exit halt state\n",
>                                mmc_hostname(mmc));
>                 }
> --
> 2.17.1
>
