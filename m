Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4584A346FB5
	for <linux-mmc@vger.kernel.org>; Tue, 31 Mar 2026 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774953374; cv=pass; b=Hk/vmy/GaDHPVIOUVcc0DeyL376TumgoofLJYMhX7eUBZOXcBU39RInr9A4EW7n5k6MCKJHJhByqvw+86rxnxUGor5wkbV6HeiIVKHp/4T507KjMaSQRxtni5uexKi2Gl5QbZnQjuYI8i2vWyCq+3z/fZvZ7n/Zlf0uymX8JEoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774953374; c=relaxed/simple;
	bh=b+mKvgtFhwIOAsx4TPN500V8sWWdNxriT2m+zHY+Uwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdKmrzXbhSVNKTycEmPxmZbSPSJLVpG5/6eIbR6u7tdDOn4l28EmWlBycEgCO9zJ96ZgPXniHYFwePREE0tLFYsYXByFXac6xr3mRFCXsArYEcEpWr2y9kkSA6kLOXaddtGAJfveHmFOtlqSLGvBLmC0DGQu6c6sSw6IkMjwtns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VE2REPFM; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VE2REPFM"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38c68e6b62cso38880761fa.0
        for <linux-mmc@vger.kernel.org>; Tue, 31 Mar 2026 03:36:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774953371; cv=none;
        d=google.com; s=arc-20240605;
        b=eN91j+hdVwoeFtqTi7ZtMCrG8YA8oVD0Sno3yshV0B8l/nSYS6RYrh4Jj+lLVIY0AD
         C6vuLPdHho3/loohbIuE5pyIBr0WCaV/r0U1F3bYahbveSSCL0PcnHq7Vk5vAOsp0fma
         /0nCm5RaI/rJ8zmpwMAF1NUcotEOj1rW8NsMDFQG32IFgymxEBMi8xExw+K3ElwpwBVX
         m9Lwu6ys6NFPgyX9rsA5rVeX3e7XyNQC3XBKYQ7E133khnUdsunV+LGnX9pc3GziLU7M
         3ykriGqv/Z8/LY8Z72tm4MfExKRvO+EOxWRZYS7OBxrkocxoEFj+3puVobNV6OoyCMYR
         wu3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ovx7k3oVmcSQfAcpaNdG6XI4jcdt4qV1kvDGM+BOrpg=;
        fh=5obraWZEuawUzlBY+W1a+TGNwKFOLyq9QOdFgtgXiNc=;
        b=LbydeISJCpkfDUwiam7mC/fn1NeJORROXEZJPbC4+ihPRm2Iu9dmOYvsCx5o+FnxCb
         ApHnKdfuU4ELBqa6ACww3uGQoc5EW25ieaFHAd3QOvSqjeJ2u/XNyqz+m3bTHcQVhz1f
         ASEenxVh4kyZ7W7ADXqC5V+5wBt6V8HcKDS9nB+rT6jfJX6pr1nT8yTxHTfI+zZBiTbv
         hYW7tCGyzl3sQLS2hssAMdGhXA1iRqgnEbvP5P3myOqbiaYKH9GvyLwDwljfl5UTx1lL
         Sk44xqDCCrWsKQRZPTPGAxHGneavUTI2ERvfD2mZ2aWK2cM/BVelrlmFzv321XuxHldM
         qEFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774953371; x=1775558171; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ovx7k3oVmcSQfAcpaNdG6XI4jcdt4qV1kvDGM+BOrpg=;
        b=VE2REPFMT5TnLycQd3aZqw55PfvqzH7COP1+YPlK+D4ktOxMHSe1y6kfQl/oWBa1tI
         sV5qBtoslDMjfhNuZdITj2ETLN7IvDW8MUpAQsCk8IOibHAFajFLSQc/sdu9222elLeU
         5VI5DsLp8A9SJDR8epbujZ9HnyPsF+LqQKIcAr6cZAPvhr6Z5QrHHqhA/5C4ItfXimaS
         51Gznb4D2kyF+erbq3cPqPZHnti6vJjonrTJqs9B7UB1E4QfHh0Sht+gO7/QCUjxz/1F
         xC72NfBOHEjLrt2K8B8JlpxBvMlnOgEp2dNaflB1udYoxabKT/lXp9bEozYwh+21VRkC
         rdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774953371; x=1775558171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovx7k3oVmcSQfAcpaNdG6XI4jcdt4qV1kvDGM+BOrpg=;
        b=TokjZhqde1pmAAIeH7wbdEqffPin082+A5T2SxjYcGYbYG9u9ruePJsGiVYMUEOFTi
         GIsYq4EzZTyFwzsT7a7EuVlVJ6hC5WNUwbMywisqSjWyR+myE+ppJ2qcZ/OVkOxvBbS8
         UFXT2o7VsJo+aEnIh+0KeVWJS3JHmXObAeUhgCQA+A+Mi6KH1g6bi9JPvmKePCdMeS6e
         KgljE8PHCngd2qbrgYK+D/EbGPRR35vcSHShTZ1iJaTjhfchIrNhatUxzz0uyRHIlQwS
         udDTCD1TFRxI6RUT2Pm/B+waWPuZF+G0lPPTZtJHg5hnKyv1AV7Lgh4gexV7v505MOuw
         Nhig==
X-Gm-Message-State: AOJu0YzF3JG9ddDkVjw+BT1HX/PGbA2E61nAbs2Mu0e58+Q4d6k5JYKh
	lsBdr8nFZxH+EXWO1WuQ38ftV0MlP4pfKQEvjWK49punzusOFG7YXwXbYXeIpu7006MkSUkBGlY
	9UCre+lyq31vYL78ub15SEL+cSUm81bS0Ql04cBGkKw==
X-Gm-Gg: ATEYQzy2GQ08/Wqf86a92TwYw/zZp2M3xj5DTUiQXUOq+TBLiP/TUfoGiEUk2inESqZ
	GXeVDq3R9jLNxGircGyrc3KWqa2klRCW5d/VOUucOXK2XOoe7B+jd1y5Xi+x6yHIDKpK17xV1RS
	FRC0U4RXY2HPaUESL36ie49E7gCrD0LyKYqlN5KbLqUW2xaVW6kOJczdzHc8fSNiFYeYKd29J0/
	9AJOMnK51rcx2YA35mQ0OC77EDEfO5wmxEYBb0pbHCiBa8Me5hXMXoOmSezKBzm4Wod8q6HnvUe
	ZPLVSse/cyikB/UVQ2o=
X-Received: by 2002:a05:6512:61:b0:5a2:ad7d:8c2 with SMTP id
 2adb3069b0e04-5a2ad7d096cmr3425793e87.39.1774953371345; Tue, 31 Mar 2026
 03:36:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPDyKFq42GDC6V4WZpax_tFM69JPafB9_UOAsfkJN1ZxAP7LeQ@mail.gmail.com>
 <20260327200851.3669019-1-b-liu@ti.com>
In-Reply-To: <20260327200851.3669019-1-b-liu@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 31 Mar 2026 12:35:35 +0200
X-Gm-Features: AQROBzCFUkXDjWTFuCN08J3PQp2NWRXv_TdZEYt_9AE6qZS92lvXVxKmyhCNdq4
Message-ID: <CAPDyKFrzbfjYs2S6dPdZd+tv+sWcxJQnNEn-Q4me2tFZMOOo1g@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: optimize size of struct mmc_queue_req
To: Bin Liu <b-liu@ti.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Mar 2026 at 21:08, Bin Liu <b-liu@ti.com> wrote:
>
> ioc_count won't be more than MMC_IOC_MAX_CMDS (255),
> retries won't be more than MMC_NO_RETRIES (6),
>
> so change both to u8 type.
>
> Signed-off-by: Bin Liu <b-liu@ti.com>
> ---
>  drivers/mmc/core/queue.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
> index 7bf20e3db5b6..71c82153dce0 100644
> --- a/drivers/mmc/core/queue.h
> +++ b/drivers/mmc/core/queue.h
> @@ -69,8 +69,8 @@ struct mmc_queue_req {
>         enum mmc_drv_op         drv_op;
>         int                     drv_op_result;
>         void                    *drv_op_data;
> -       unsigned int            ioc_count;
> -       u16                     retries;
> +       u8                      ioc_count;
> +       u8                      retries;
>         u16                     flags;

The previous patch I applied added *u32* flags, so this doesn't apply
on my next branch. Did I apply the wrong patch?

Moreover, flags can be u8 too, so please convert this too.

>  };
>
> --
> 2.34.1
>

Kind regards
Uffe
