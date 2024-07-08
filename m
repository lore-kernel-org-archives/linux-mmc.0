Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD94913A407
	for <linux-mmc@vger.kernel.org>; Mon,  8 Jul 2024 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441486; cv=none; b=hDaZNpN3ZqiOXOOhL5VAExCz/KPNIDtojDw77MTdq92+PGD9wUGRjgLGx9Bl5oF0Huofa/uXtOhcdP3KTJ8FN63z3JRRSv0cHbPzq1y8RNYVb8ojeXlSj7gNHYTvkHHlkSla7zNWBWHpm59OOLMVA08wB5uECda/RlakIFBrxJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441486; c=relaxed/simple;
	bh=9dx+1t0EH+JyvUfSEueYnrqzhW9tjyVNxMt4fmD8BkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lv2k/588XuG9qrFxyxJW8s6eKl1YuaTccCEAR3vvJKOBPiuxg4gRugthATXslinKkW7T6U60FxCDs5pTls63KMKXJ6nwmx6KGPb5qe2m+dgs/sb7SSewUEvL1K00df5Xt6icWF74Mkg5JPe7ldc3309nMwuFCBzZz08NGnGbwX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V2Y4Zg3f; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V2Y4Zg3f"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e036d1ce4f7so2570431276.0
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jul 2024 05:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720441483; x=1721046283; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6eRPNGTqIoXzzDaZTM/Tr50ep2o9S4rIQJljxJPqpqo=;
        b=V2Y4Zg3fUP7QQJbxLn8eIOSSBqQEB96ZxPf2Ymm6QgQUD67OA7M1d96CFwuSkfKyR1
         GSHEnWO4uTo2lHcQhgz8+vGYRwI93+mRFuZQbWbWTh/VK3PiVODpCwrI3/eCq5NVwqdJ
         Xy/5NrC/dEYEtXpG0uXpeBGLThdHpTl7WLfpXlwX1Sq40ggAQfVSCh/cgiHo2GasSupp
         eVtePL+5KpVJMQyfMTiXdbpwcZ0hJBjENIwWjDqXC+GmNda7/NVbXwTBDeVV8RWqskjQ
         HNw4pC6T/UZjWV5bPb4V8IJ3k8IxJW9I9r/t1W/ebiMcGUCGpFMk9h8qAUEXVCQ7bapX
         qVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720441483; x=1721046283;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6eRPNGTqIoXzzDaZTM/Tr50ep2o9S4rIQJljxJPqpqo=;
        b=IaBuqe08D8f1pe15GG9Qp9wpIjEClMPzVEzfHtwyKfg1bEF6K6FxtO18eLSX0SKM3+
         B0CcxzoUwNFDIeiL/n5LwJWHCJACd8dLbifWzgQviW7zbl5KLAqapAa10TEO9PwdY5bI
         XhutQrmJyyXn1MIODqTUi7QjKVXY5fqmqpRrKkT4SCSsnZBrGu/JghSa3O4h8iolAPpA
         VOM+q9JXCz1tBKRLM1MlZ2qYbNXbkCyfU3b5ucbwkfaD2aZz2+LrTMK6V5zLnx9LRs3a
         nHRTtv4eAFWryD2DkJrNmaA8JoRF+TdXRFIG0g62sAbIb9mdqyMovoIqQ1a5Hj+u2Zko
         uKWw==
X-Forwarded-Encrypted: i=1; AJvYcCW4Z1KtXj4d+1x+m1djQMOKkbZwRBOWE+trUBXtNNR+MV0+IkItfcKwnakl2OG1TYS2JMEVpoAWQrGdh0CsHYvAHdHcFWgKPmj3
X-Gm-Message-State: AOJu0YxspoKn9CDetD9HiwPEgzAZ5xRbUcmowZSiMbQXUDWbAYAGvXEu
	YloDOH6y1UFFu82GpPp3le1zjfWiuqHQp1zUkIzunRY348DBQmDzMygJuxfZyP2p4c5ngV5h5Wk
	CE21LctJr4dZXMpbU8jhtuU29819VyxF1oBmWaQ==
X-Google-Smtp-Source: AGHT+IHl3b/Ar3/pE/PZjIf5qiMkFEnQS3z5ng1Yvah7bFG+Q0Vdpj1Y/cyeF92Xic9N7Tkw5LUBVLrQqCOtgisQjOI=
X-Received: by 2002:a25:e90c:0:b0:e03:4f13:75da with SMTP id
 3f1490d57ef6-e03c289a18dmr8025908276.7.1720441482828; Mon, 08 Jul 2024
 05:24:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705-sdhci_am654-const-regmap_config-v1-1-c166a8d48a66@gmail.com>
In-Reply-To: <20240705-sdhci_am654-const-regmap_config-v1-1-c166a8d48a66@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 8 Jul 2024 14:24:06 +0200
Message-ID: <CAPDyKFq3axtXAsPfZsowEjE0rJ-YJvxO_1XM8okoZyCFN9+Ksg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci_am654: Constify struct regmap_config
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jul 2024 at 12:51, Javier Carrasco
<javier.carrasco.cruz@gmail.com> wrote:
>
> `sdhci_am654_regmap_config` is not modified and can be declared as const
> to move its data to a read-only section.
>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci_am654.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 17ad32cfc0c3..64e10f7c9faa 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -90,7 +90,7 @@
>  /* Command Queue Host Controller Interface Base address */
>  #define SDHCI_AM654_CQE_BASE_ADDR 0x200
>
> -static struct regmap_config sdhci_am654_regmap_config = {
> +static const struct regmap_config sdhci_am654_regmap_config = {
>         .reg_bits = 32,
>         .val_bits = 32,
>         .reg_stride = 4,
>
> ---
> base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
> change-id: 20240705-sdhci_am654-const-regmap_config-f97903ce0e7f
>
> Best regards,
> --
> Javier Carrasco <javier.carrasco.cruz@gmail.com>
>
