Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1D42D8393
	for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979125; cv=none; b=AJu1SnJ5djF3LiNKLxnPW+q4zva8eD1o04zWBv34rfygLY58xafTPQolITKyzq1+saqkf7APKKTKLelbkGLWU80cV49P7K7wf14h9SWIvqnhuHQVf05+X+BW1vXuhDcaDkkts11mECCZ30SoGSRECol2mJouSYuNvVo8KOqLPUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979125; c=relaxed/simple;
	bh=CY9cIs+GAycG0BsLVMBnwB1DBDgapJYHX6gajxVkx40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cj7lyeM24VNMVbBUbGIO/NM3XNNCyJ6e+t71jsEEZPbDrWXrMVP0jY6qLRtOscE1sGjkXEaPKhy63nRZHo4p7PdxLDdq4vrq/i8FUJk9COCIoN60AC6dNh6Itrj+97B5+tmCg13UgVckUrrUxsV6WJ6gaORRs6XW1LI0h2B6tfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GCFvfPYN; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GCFvfPYN"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59431f57bf6so6278243e87.3
        for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 05:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765979122; x=1766583922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GJY2xsOcGCbmVygXp1kujCxIBc5qH720XDao5/Bx6Oo=;
        b=GCFvfPYNlD+OcExUi6RhLNBq5g0MOdwk3K7U1iCcfPDi0RB4GAj/QQInwDAjb2lWr6
         3TL7cM1/977HdtuoDXxd2r71oV6q+pOFdqEccRelLcgkVlS/ZxWQa8QDioo/qyLpRuXL
         y0vEMW0xVRrjn/QXz5lo3DpyXn8yLk+6glZ+pbQHEZ+MdCG+hTgKZzkrSdG9651DQl1g
         MwMEYh65ZxdTMWv7rTpvrdxy3t++7KVMk753MgJO2ornxvmTVzPuzp+LWM92Qux/czjM
         Iyp7Gx06nijMfIUZS0lynB38L4WyvkjQr5HCzL4s07eikecPCgCeqLhsI/jG3N93u3Av
         tr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765979122; x=1766583922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJY2xsOcGCbmVygXp1kujCxIBc5qH720XDao5/Bx6Oo=;
        b=U3cZLj/qtyqRmA1/x0gT5uQAaEF0IsADgjFTlJ9n/8mrO/raG5EVR6yXubaF3EifUD
         tcFVMVbz7JX2dg/ai9fVCz+FIiReqqU3gkOajq/sjd2fbqwwpkt7X63sQ7ev3nxgA4DL
         aJBI/tbXuE3QwogXMHN/+13nWdzeEtN2xoCqlWkb2zeUD49TfR4fyzb7p5vCbSo3WM1L
         qYiasAkgAHcLfIzFYYMMLHxbHI+20zdNqneVlycxluY6k0QFQNa+iiqOgcgzK59FNx5V
         CCeoGv01oGEsvWjNjxNhA2YKbIc2t4ER75Y5Eu9fTjmwGjRWPQLe6tATJOWmc7de82BK
         opmw==
X-Gm-Message-State: AOJu0YxBBmZhmc59v+vhMkc/Lyb3JXWPjQS7SjZPzgG2gLEvVbx0wnw7
	U5mHijy8hiQ8qGyIR/rKk3a9E0CBpNwlFwqxUGwtdElHMltWrSL0iTEXXRfkhErrAAmrLroOlCK
	wE8a631/lIhuxz/z1unV2jXcTLgkU74H+DQIiEDY7dQ==
X-Gm-Gg: AY/fxX7VOe6s9gd8En+mHEZm7s9LBnedPRBY0y6xIXWSgB1cTlw6k+pWhN3fXEV6olO
	atRqa4U3Rqbg/whGtXfIV7nQFKZAh4KZl5xtIGFvFwkZWta/dRDUEgwo9maD4hqEQT51zrqmf2A
	z0aY8eD/579ew6yc50cmVCoE/uIlqvTXuiZpag2nmZhOrIodsg7eIKfYiqT5Smpd+f9bubWdgCQ
	5UCJ8dbUzP+QmcgH3jXHeqsOxbnqWadl3sbI23uA9VUcX5nXFdo++dAeRM27ychhsyLnak=
X-Google-Smtp-Source: AGHT+IEzvIPQeQe+4BQkLwY/CnFB4NdVoHOSjL/RREkTxfCYcCeKcde/RuPZczALQSrFmQypLV3dZQlz1B8TouEhKb4=
X-Received: by 2002:a05:6512:6d3:b0:595:7fed:aae9 with SMTP id
 2adb3069b0e04-598faa21c46mr6132895e87.12.1765979121557; Wed, 17 Dec 2025
 05:45:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1765958648-218422-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1765958648-218422-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 17 Dec 2025 14:44:45 +0100
X-Gm-Features: AQt7F2pQMXWZToNNO_CCgt4lRVYMhS60K5woMnjiywDzOa3vLj3TH41-xwVCPWM
Message-ID: <CAPDyKFq2F6VU3xaP=cg66vTXj1wGK3mVVsF5mzb3HRuVhooe5w@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix descriptor increasing case in 64-bit case
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

+ Dan

On Wed, 17 Dec 2025 at 09:04, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> The original 'for ( ; length ; desc++)' loop unconditionally increments
> the 'desc' pointer. However, in 64-bit mode (when 'is_64bit' is true),
> the 'desc' pointer is not initialized or used; only the 'desc64' pointer
> is valid. This leads to incorrect memory access and potential undefined
> behavior.
>
> This commit replaces the flawed 'for' loop with a 'while' loop and ensures
> that the correct pointer ('desc' or 'desc64') is incremented based on the
> 'is_64bit' flag within each iteration.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

I amended this change into the offending commit and added a
reported-by tag from Dan with a corresponding closes-tag, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/dw_mmc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 2d81d021..5d84d44 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -594,7 +594,7 @@ static inline int dw_mci_prepare_desc(struct dw_mci *host, struct mmc_data *data
>
>                 u64 mem_addr = sg_dma_address(&data->sg[i]);
>
> -               for ( ; length ; desc++) {
> +               while (length > 0) {
>                         desc_len = (length <= DW_MCI_DESC_DATA_LENGTH) ?
>                                    length : DW_MCI_DESC_DATA_LENGTH;
>
> @@ -640,10 +640,13 @@ static inline int dw_mci_prepare_desc(struct dw_mci *host, struct mmc_data *data
>                         mem_addr += desc_len;
>
>                         /* Save pointer to the last descriptor */
> -                       if (is_64bit)
> +                       if (is_64bit) {
>                                 desc64_last = desc64;
> -                       else
> +                               desc64++;
> +                       } else {
>                                 desc_last = desc;
> +                               desc++;
> +                       }
>                 }
>         }
>
> --
> 2.7.4
>
