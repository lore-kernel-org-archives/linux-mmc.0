Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B5727B353
	for <linux-mmc@vger.kernel.org>; Thu, 22 Jan 2026 18:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769105067; cv=pass; b=WBhZtE6muwazPhKrr9ZqozpdqvRPMsycolkTqro26fFX8LT7x/PBWdBniDaPZ+dTLnbsdnN5mIx/It2j6DxO/KdjGWikOxZAz0QHa4cGB1lV/HYShMkDmj8e/sSEcNk+4Eb1eY0i0g8zi8segyqLqJEGHuZ0Xkk2Gij/ZqCadw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769105067; c=relaxed/simple;
	bh=+is2jLbMzq0Z6Kfc8fC+eUDq4l5RgoKWrFKSARRKu4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3YgMF4mdPOSJso6q6inSuzuGqodGbYYRnckad63B21duvDKT0dc9AnLgv7wXNFKPFzZ8tdCsScVEZt8C6W1SuLeqiPvYiCtVpNBjMCikU79kozZYEtMPelZrt2Hr+jCbn8SbXqno5QEozMysK/P94RHbgekqHiJcs1ODxBTzl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SKJzSfL5; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SKJzSfL5"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59dd34f8120so1476313e87.3
        for <linux-mmc@vger.kernel.org>; Thu, 22 Jan 2026 10:04:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769105046; cv=none;
        d=google.com; s=arc-20240605;
        b=VcGkKkq/i2dK80DxmDHC/rRd1Mele71NIReC4WV59dHX3jk15LPTh/zKanzKakzaad
         MmkxI8zbgYu/ls8IGeb+hOA/Josngw4AyDPtxb2JDyHlNfxW379g1F8FuNnIV1HQPjsf
         8/tfFbe78q69PqCaNy0VTkdPPfillzC16ApRm3nNBnSp9JgsFX+2uMacMK6KZvjpHJVf
         QAc3GD1hKi17nL4KLoaY+Ce6dvlrCuDA8AWxpALgN911ODp/2exxgElB14tLB9THFqQl
         9/kiKxal60WtJchvVb20BS4wqsiV0dl2ANDXNha7Lb9IQDTM9YP2eudjsoTxWYkGdQh8
         j9hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+7GHTE3dRB5BqKenpbv68JYHRVBWjnrm6Bs4wCM6D8g=;
        fh=lv/93G5qe+cTmhzs1mQWnILj9dEionhefPGo0Qp4B9A=;
        b=B+sGVlI3PLlFijgV6I+Mg3qDr1yhGINCINsbYabmqYCQscULWxha8DFFA1SI1M7A66
         QxnEXXQ7gv4rB/kHJ8+4xjiJQQOiNXeG06geLYwntd+/UC+aC5MYrPoYhq/nzNFso1HC
         +mV9lH0fLr07Rsg+f5lf76LroI6CFvj2c1kyS/3ssbzpK4lzniYd5jf99Tj6Rsf4oOV2
         721MyfVKfqryLfddn3054WRaWNhAsGJcEt1OcrJp4Ovs60a8hKfvzM/riGvJDBwc2chL
         cl3hjZ75TRDpknQ/3FKvOoqVkrmHPrKKwtDSBF+03KMktp8nhcr9eUEi3dyDhpsA0B2s
         ZXGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769105046; x=1769709846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+7GHTE3dRB5BqKenpbv68JYHRVBWjnrm6Bs4wCM6D8g=;
        b=SKJzSfL5d3wEX2z6hbrPD6DLES1jROK4dOOOSXJP5GWwvKwsEfEhvs+WUuFeVPTZxV
         OAN94/BVDIKBh03rLQHKuGJ/uLPHPgBGa58Mklud7zz74G/KHKUdDIsnOoCj2M9j9aj8
         Y/5bNTZ82CcxDuCcFs3s+86T84gpUfntljgvEnazTwgscayv5uBLrDDdAb4xZYZ6j4kn
         cJO1arn893VS1VQl9R9nu2JMEpWORBQg603NX8WGIEyWVJfjIJD6fstntBI8G/nbETWB
         O+O+pvHRINiSRXcjxZa+BJXz+j3StGPZKrmerzp+/+KozQ+S1UR2sE4ASPOIbqsEToV4
         A33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769105046; x=1769709846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7GHTE3dRB5BqKenpbv68JYHRVBWjnrm6Bs4wCM6D8g=;
        b=wagy/4Ofbve0Y9ja453LG2+7xUWqoOjlbsHwnkGbDsfjWJD4AogdQOppwCmZ2oPF9S
         +v+tPRvxWmlA9HAVoQSQqzjcvl6Orem90CFmc5vZ7UPpSLULTx9+WxLD6pDJ1bTDkTqZ
         zxbR/QH2pDbDX6glc3U9J4fQQ8Ar5CrUcSZEtzi9dVe6B5nnR6rpTsmgIhXOGOtmfx9r
         aSR7DogDZuEkGFcHrcAXZysP3Q6hS0BoN+oalsnd05c44KbHWHTkA6xxchctKdUVGQ/K
         7gNOJfI+1AAfmmHaBLiVDC+FUa5SfQ+3TLSoWON4uJzWydPeO9AMUPQbiufRGSF2xD37
         ekFA==
X-Forwarded-Encrypted: i=1; AJvYcCUvdNUu9CwPdw69/0gs195PnSmdpZLzeaQLfO1tKIPfjR3+wrMzvO5OUtrzLjglaMdMbWdvnm+PsL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3LKAO5xKfPV68M5f9d8WzC8sL7rm37/bCC2SqcsmUb8TAz0f7
	Hurbe4c+BeCkdt0CTETRgmiwJQrpwddZ8LxXWEVRcc9BaXaRuVwwLbYKl0GHtjBhzDKX85BzQHJ
	0LwuoKqDAqylHshsde2D9iAZWh+jqD+Zp+2EPst55VA==
X-Gm-Gg: AZuq6aJ30QRcivnmwP+AUyiL80/rQVGIG4DDsMIRfLLjcO9/kXbyeyd/q0A2OXBPs3h
	ebtfwyOtVHYs9Q0rwQ82s62LjmVq1fM8FXcm/gQSQsMrlifG6PVLXcs/rf7/aUhgpqwu4D7DKgA
	zgTBLeFIHB5kKUaf6Zv7C8Z99axHezhcrG493FBdPtl81ypkeqNYNzPa5CDBSd67mUuQygR3GP9
	WZNm03UVa6C+CLPbA+L6lOtRJmv3K2I5cHu1jveMnix+eviR+lYF/RqNQfH15V1WlMAWchh
X-Received: by 2002:a05:6512:3b97:b0:59c:ba5b:ff62 with SMTP id
 2adb3069b0e04-59de490d21amr53289e87.15.1769105045566; Thu, 22 Jan 2026
 10:04:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120-mmci_qcom_dml-v1-1-9b334479968e@qq.com>
In-Reply-To: <20260120-mmci_qcom_dml-v1-1-9b334479968e@qq.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 22 Jan 2026 19:03:29 +0100
X-Gm-Features: AZwV_QjDIpmCdl3xsITbV6Pt2jHn3-Pc7ojNKEOQi8IB6Ipjt84DU72iscHsb2U
Message-ID: <CAPDyKFpJuUL-GfpYDUNK_e0r-CS=oX-tPXozOtvVmFZ8XLBTTw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: Fix device_node reference leak in of_get_dml_pipe_index()
To: Felix Gu <ustc.gu@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
	Stephen Boyd <sboyd@codeaurora.org>, linux-arm-msm@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Felix Gu <gu_0233@qq.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Jan 2026 at 15:26, Felix Gu <ustc.gu@gmail.com> wrote:
>
> When calling of_parse_phandle_with_args(), the caller is responsible
> to call of_node_put() to release the reference of device node.
> In of_get_dml_pipe_index(), it does not release the reference.
>
> Fixes: 9cb15142d0e3 ("mmc: mmci: Add qcom dml support to the driver.")
> Signed-off-by: Felix Gu <gu_0233@qq.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmci_qcom_dml.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
> index 3da6112fbe39..67371389cc33 100644
> --- a/drivers/mmc/host/mmci_qcom_dml.c
> +++ b/drivers/mmc/host/mmci_qcom_dml.c
> @@ -109,6 +109,7 @@ static int of_get_dml_pipe_index(struct device_node *np, const char *name)
>                                        &dma_spec))
>                 return -ENODEV;
>
> +       of_node_put(dma_spec.np);
>         if (dma_spec.args_count)
>                 return dma_spec.args[0];
>
>
> ---
> base-commit: 9b7977f9e39b7768c70c2aa497f04e7569fd3e00
> change-id: 20260117-mmci_qcom_dml-e169407da7bf
>
> Best regards,
> --
> Felix Gu <gu_0233@qq.com>
>
