Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4E932A3D7
	for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770737053; cv=pass; b=fkb6FOFKu81RL+klakU/FD+xsLm+qqIhJSkKlpNGEg/JwpLGr7Y51MQwBHMn2CZ5KTO67h6/UcsmclJR/ue9jtBlb9Y0i3jNHg0PC+XT3S6ak/Jd/Qj3r3L/uO4QuJbpDqgbmKYNXfWj0guR8cLvfTXeftJDW3deIJD0g2ZiSSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770737053; c=relaxed/simple;
	bh=k0gmt2SK6YJLMLSXE/TJpOL6RyovHLpu3hpDi2DSn3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eFiSNjn2wdVaq7JOhSEYkY2tu5GNhxjqdLQtXinUZyNVaIce202EjW2wptX82gQNNd7GQnuvhJrtjG6ZIG+nZWOl+GhAbQD65erN/PmOg8dQrcboO4CYRuOFhr3npj1YqOM7+4/J+rNoPL76zeSStt85U3+yPwX8FO+bEvziOD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D72UpHgx; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D72UpHgx"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59e4989dacdso3589162e87.1
        for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 07:24:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770737051; cv=none;
        d=google.com; s=arc-20240605;
        b=EX/Xff8IMGhN2wj5+xPzK8S5ZTTgsTcNq+gqEjkNXnDCm2VS7R32+vkaUMdkzD26iD
         XZw/jz7SJIhSo74GzuvCsxpRi2mp2RryHLVH7OlqpchBN0AmPitsBssAtImal/GOHuHx
         Z8lwobd2C10nG5NsJ1jEG/z22bOI6+w8FqhH8c2/E7mbKCeLVWb821fZD8HiPBaJAZCp
         CbABazQDzi7c7T5TbQmDcNjBpkMCp/j+7Z8yT99ugZFCiG/qpCpIGLyoiYOxGIDcAy5+
         /jld8SXSY/9PIZwPoj+XObe3ObPm4WNp9askZHW69SrmMMlsenXC9BRtQRpJYdCJZ42R
         Ez5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GxQFlDkHrupA4LseelclaxK8eMfOdVdlkWQK4k7mZ+0=;
        fh=F4F/bq2Ajmh2waB3vXFgAatAF/UIpYR6WKOdLaA8rxA=;
        b=CUkOLskCm0tZCB/qMwhsaACLPKgOpFFw4/VF4sh3s0Tz+8UOkjWvLGEUbpfvQjnOUJ
         UNScL/hTHFHDogm3iGTR1LU5XDOlMUB1FM6ijkmzw7QwpTD0GBsBi9NdGERoIyAPBoaE
         yd+5dPiLy4/ZXbb+65FXP1EuIEzsE5dI8ujGt/2qiCfihdhgZmrkesrT+1SxHGHJ4Cdy
         VErgNYGTa9gBE7PZls3NoToC0oNI34q9/QjkWaw6dxGKM5hb7BlzRWNDo6di1L3OHGwm
         vNRKhzXXErYxUyK1P+txq/H6zElRj/VWSW/dBq5WnuWfrjZBdjtv9wvz+yR/x4xfa2FK
         t+rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770737051; x=1771341851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GxQFlDkHrupA4LseelclaxK8eMfOdVdlkWQK4k7mZ+0=;
        b=D72UpHgxhDUkjrXSG0pnzdiDMJKPqQXlXpA9RzIdiiltVSj8RkQvuY4wBIa2SbfZym
         +kSztaMsXMC3M7wmBJtuE6Cfj7N7bd8KUyoM3xoaB77afcJGcjLjweWGdF+mpOccHVYw
         Q7WHJumbRqt+N/Rs1ejDbYGatWJ4dM0iDkxOwdc+DNmuDiwsSlRYX5vOvnaCmKCJaeO/
         dVaeikN7Sa/l7JhiQgSB1iSisN+oo5x8feMgOr04iyHxfJIlt8X/kAciqNgcPEVlMOtu
         IdyVo1zUuBxX8rLLPPOhZA9DT+yOxm3nDXzOZQPCQg54xRptxKlNWo0/rpzWCuigt/th
         hpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770737051; x=1771341851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxQFlDkHrupA4LseelclaxK8eMfOdVdlkWQK4k7mZ+0=;
        b=YHbzjCe+O23VChEmIhwJdjxKCujVqiT8zgsshbygMSv/COdUMEw/3fPWR4jOFeWP3o
         GYwvuSB6f5e7F2CFJICTWKOr8cwVvqNPpyNfhEj4oSAlfWv4R0KUCtRdW7JfglJW904Y
         wNJMdiRZdSq/cojvWaO8MnDyuQDeUlfWeGGhA6CIXEZuM9XoFYS4/wVQUXurYxHajwOo
         y+9F82tYR1jFbhyvRT5KYG6imHeN5BlGIPeit3Tm6GKpf6g9cwNFy7xnbWDAncvTEIAu
         H3GZ+QUU6BUnAwfZviVuFYORt4vu3gMZG1fTjgCRQ1d8s8hzVSg9B0QCEHXlNwUwlai8
         WjlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYi0pLiDN9nQ+dT03nUpS5Fny1U1f6ipSLF3S6rl7wVJ71OqWCQsyzPK0ynJJgvuoSxczvG9mt2Fw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw18dRW05OI1LKe9pH5gAyuQ4ZXaMU1FmQFKa6pyXggcBHAH5df
	O3Mmy/nvn0iZqkL56BX2JQd7XrWbxgCGuhHLOEKyDUNEs31LFOrWWKDJRAFW/4lzFMtf+haIoww
	jx2Y84K7vYEE4hmzQLYpUOb/R/KwBqcm+oo62aSzynQ==
X-Gm-Gg: AZuq6aLm4lVE1q6iIMisBM+pUyzu/PhqeIbcDXPaY+2jpMQqkwnKPpl0EDWQchos+xK
	W9IJSW8IQ52hLsqz4254zeEDJC27tAzbJZ11zRhUWESDSxtORQnR8d1ZvkThDOzfFpCZo2ED6cs
	dN3ci4AFnVCSFON/iFcxnajwklvb2chMjBlI5Ll3uxLSIGQMJ3CqWAdukbDKYBAFIMUk8+sJRp0
	tlh6HUmnW4V+Ipdx9MSKve+m1YG+2EFTczIgYCIWQee6JtzGmDShICd4xbGNcGIY04GKsf7yc1r
	ba7KcgvQh11KRJrrmbnGiRor2lFZAWxTrBczinqV
X-Received: by 2002:a05:6512:ad5:b0:59e:45ae:7034 with SMTP id
 2adb3069b0e04-59e55bdc59fmr883838e87.36.1770737050449; Tue, 10 Feb 2026
 07:24:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210-qcom-ice-fix-v2-0-9c1ab5d6502c@oss.qualcomm.com> <20260210-qcom-ice-fix-v2-3-9c1ab5d6502c@oss.qualcomm.com>
In-Reply-To: <20260210-qcom-ice-fix-v2-3-9c1ab5d6502c@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 10 Feb 2026 16:23:32 +0100
X-Gm-Features: AZwV_QjnOROVr9Ygs9hCFhr8L9ZPMcLim0_8y8vdfEht-oO3Vkh2tAqIyIExc0o
Message-ID: <CAPDyKFoYAqkLxJTN8BWGWkcjaD7fs+XkfqWhgnTbhekUnXUw9A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] mmc: sdhci-msm: Remove NULL check from devm_of_qcom_ice_get()
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-scsi@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Feb 2026 at 07:56, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> Now since the devm_of_qcom_ice_get() API never returns NULL, remove the
> NULL check and also simplify the error handling.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Please take this through the qcom-soc tree.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/mmc/host/sdhci-msm.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 3b85233131b3..8d862079cf17 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1906,14 +1906,14 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>                 return 0;
>
>         ice = devm_of_qcom_ice_get(dev);
> -       if (ice == ERR_PTR(-EOPNOTSUPP)) {
> +       if (IS_ERR(ice)) {
> +               if (ice != ERR_PTR(-EOPNOTSUPP))
> +                       return PTR_ERR(ice);
> +
>                 dev_warn(dev, "Disabling inline encryption support\n");
> -               ice = NULL;
> +               return 0;
>         }
>
> -       if (IS_ERR_OR_NULL(ice))
> -               return PTR_ERR_OR_ZERO(ice);
> -
>         if (qcom_ice_get_supported_key_type(ice) != BLK_CRYPTO_KEY_TYPE_RAW) {
>                 dev_warn(dev, "Wrapped keys not supported. Disabling inline encryption support.\n");
>                 return 0;
>
> --
> 2.51.0
>
>
