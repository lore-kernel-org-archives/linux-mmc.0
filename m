Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F7C3101C4
	for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2025 10:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514516; cv=none; b=ePgHixoXR/3H21uxs/g409/bVZzynOOFSCgrjhsspHX1ScTOv2qp1rOu3BBSlbbYn7m7hg4fOCk9PZAkZujcos6M3svYPxOVmjpCfWOzurwbj+IW4eLEY5g0PSvLimqw/1QqIEAfSCZ75ic/qRLgZkibOykVsx4rHG5EwmfhodI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514516; c=relaxed/simple;
	bh=FJ519jWH9KWAI2H67Tholf7HmFlB87+jCNjkI7Ma76k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MD1oYJVBcA9v3IKO4LAZGV7DQwpyclv1Z4Uanib3I3gTneFJuBjwczZlQLk4l2ucnTB8ZWN/q+MHek1SsarDozw1LJcpiPMGUWX/M+Ez9dO1PaZIVFAJdNDP8xadukb2G2kUX/taVmk8jgc2NIVn7dxbbEKCC+OlJf4n5cdR0Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k48YcGtx; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k48YcGtx"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d603acc23so32236907b3.1
        for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2025 03:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755514514; x=1756119314; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cRZb2JpwGfgK0Dvyni/lGLUSOMBzhH0cIWS+Rzvv3Hw=;
        b=k48YcGtxlfSYR9PBWChf+LVHYtP4S/gAJLeQD4OajBYmJVId/6KgQ2x6S/zCULd3kn
         evIja1kpFM1Jc90MXRQbREk4IArIA7ueaiQLJasEFdBbHgWUCoZXgbmCA8R8XBLJAknD
         AXBI1ZxP5dCN99mlPqMc0TwBxzJ2X/l6mjGBJf0jZ0gE7gMHfe0mTlcKQ8C034cudVWf
         56osERU3gA0G2nhJczJGGQIR5SgXpyT78JC+2u39W1gxUHCOBSz7NEd0q8byFZcY100o
         IbgngaIyJAQ1O8BkFXivZrqjAatAyKSAp7SzGss0o1FdUuCEoTwshQilyi+giCJDbRgr
         te0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755514514; x=1756119314;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRZb2JpwGfgK0Dvyni/lGLUSOMBzhH0cIWS+Rzvv3Hw=;
        b=hiJt/L0LCM55nLDjU5U3sayp8QhtVaDxDwah57o5Mez7BX+uhBymF7R4giqes0FicG
         6lCiep3kBwjT2ysB+uysdVUuS2ii4llQyaitT2VS7Dy5TgP1YV+azX/dNRJX/dyguxi9
         0IpXXbTAgB8t3bl0wNTjKkb6/lGmOFV9FBawO0JL01RnRZJNO/WsIKYkRQw7oN2Wo2H2
         KZvY0hPN9J4S9eIe7VWPQFH5AAFLaTFSeCKN8vTw5C6kyLWeP22CQX6TH7vky+rzFzph
         lSnftyAh4Bx8ptB5MSBL3qvcinwBXeCzQSuFk54aj9DNMTCjr+QlpFjZR6l+Iidn+YAV
         QzAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBZx1IawXhomkSpg0VgxRfpnpz51F6CpVkdA+1WC4ByizeDG2ymmsmTYDeCfy3c+1IUvahVEdpp/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI6xfogCs61ycaT1Fmv1XRjW42c7eYqL8AeoD0Qnxzocb6ge8z
	DIvSu8YkLcM5ur2UW7yqeGoeu0eF/2VPvC+GB9XRueI8Kqo4xqzjkoN+4g0Mb2AX7TGQhypM+zS
	2jhLOODawBbxeYU9W1f8MpgDa87UaKnidTq8or0777A==
X-Gm-Gg: ASbGncvSJnrYYuVhwd9ulSBIxVb8dLCWkIhzW2OhqS7CLCsG+qvxgtgu1Rmkda/MUyO
	rV5jQk/QuPeS40W12qcqvXFjMFsVXHF3tkO9EVwoiZ5OGnwJlfsmbc55yASw0692ZUpCwv7pEeU
	38xXoNJ8n5mM/J4qDIZyNrtWB9UY+4PTUSxka1X3cWwTOsNSn1hp1FWcAiQWJXl+ZZDh29QxZ/x
	XeALNpf
X-Google-Smtp-Source: AGHT+IESjdzn9W2JnsSauD18554Pkmz/p+/H6LoVzd2oHmARAOOT0+bzfJ7oITTTCicEmYqOeZmBCi19VjziTAWluD4=
X-Received: by 2002:a05:690c:4b8b:b0:71c:1e93:272d with SMTP id
 00721157ae682-71e77506f84mr94612597b3.31.1755514514246; Mon, 18 Aug 2025
 03:55:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731094116.2163061-1-colin.i.king@gmail.com>
In-Reply-To: <20250731094116.2163061-1-colin.i.king@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 18 Aug 2025 12:54:38 +0200
X-Gm-Features: Ac12FXwmA01YCEQ2jCJwvBR_wmGb3MGLVpLbRcdACzXEkQ4qTCrGPjPh1dPBI50
Message-ID: <CAPDyKFrPhVezQprofCFyP5nbytyBCWsmxAu-ZbO_Bbx+d5aXrA@mail.gmail.com>
Subject: Re: [PATCH][next] mmc: davinci: Remove space before newline
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-mmc@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Jul 2025 at 11:41, Colin Ian King <colin.i.king@gmail.com> wrote:
>
> There is a extraneous space before a newline in a dev_err message.
> Remove the space.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/davinci_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index c691f1b60395..2a3c8058b0fb 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -588,7 +588,7 @@ static void mmc_davinci_request(struct mmc_host *mmc, struct mmc_request *req)
>                 cpu_relax();
>         }
>         if (mmcst1 & MMCST1_BUSY) {
> -               dev_err(mmc_dev(host->mmc), "still BUSY? bad ... \n");
> +               dev_err(mmc_dev(host->mmc), "still BUSY? bad ...\n");
>                 req->cmd->error = -ETIMEDOUT;
>                 mmc_request_done(mmc, req);
>                 return;
> --
> 2.50.0
>
