Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946C225CC69
	for <linux-mmc@vger.kernel.org>; Mon,  9 Jun 2025 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749479164; cv=none; b=NorO8TdW/McyRpfZ3jFMVWxoI0jMOYUxDccLHkvRX6aW5TCvLsobaR2NGpUWIvQh3lqmZzQmKSCINUkGLTRaKVvRfbVNubW4g7k9EEFBw9zUXeCSyaXcTch9I0nJBaZsqzhULA2Nx1jGx8YTzbbJez9VZBEPvpUsIx2sZjWjZBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749479164; c=relaxed/simple;
	bh=gdvZDOuvL6fapYTdmREqzJtRfeKF8oOA7wtfhf4NLzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nc03vw0FQBlt18H78qebZE9IkdQb4/XPxARPabbU2bILcRQy0P91D5kLktFp9FDD3OUjiqzRntzzeRasDvr8jh7HfboGaVZsUwcvUjWVb9GzZC3wLv2XArp+Jv5DVyTu0+GTo9eRQ40UofY6r3L2HkZBmzjnEHq5g0RK3val6Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tn/VpdC2; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tn/VpdC2"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e7d8eb10c06so3197282276.0
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jun 2025 07:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749479161; x=1750083961; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kmc+XBP73DggJUv8T7xxNG1d8C/BNb5bhPDGJBM+T0c=;
        b=tn/VpdC24PWsIq1hGuP+HHprklAYiYaU+h7u6yC7ep1Wqtomes71dfnI7X38gUzXWT
         h4WdoHhxjNqY70Q7X4y/V4CjUiTfqhgsKzCrMcAltMlnKETK9lacl2vO2BuOKipO2Mde
         gNHTuiux48H865j3FUsr6g+uuUN4ME0DNhb87jbNO7qpJleNcFEroXvaOxcZMcL4X4qs
         ShnRSDoJn3I9MRBir/2u+/OapGuplqYbChS3vZiUm8qO1ELtX70imM4LlRnwSpmNxZoU
         L8mjc4ruZrKSHpjpi0O0kpf3pO5z+jjvFAl6fXyGvCpENk+iFALWDiEaPHUeFjrpoffg
         Cfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749479161; x=1750083961;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmc+XBP73DggJUv8T7xxNG1d8C/BNb5bhPDGJBM+T0c=;
        b=FhT2Zq9Acq7BwaMT1/oaCOlu/VDdaxU7nmEcYqoqnj6fDdvrWXx/uE2GeXiOUfpU6d
         WOx2p5tLFAAmAWZvUKk6v723Zk02P+/GgUxG25Yy9fCDbG6Nsswuhs5fsNokoLC+CTgg
         qAKh1cCD2W3M1/mdkS/0TFDJI0oWpKANNBT7gxS68cg52xMxSMZiryXrSOgSkAbAHDNt
         NEd6hlB5ZsnnIniDzyE4LyxGY2AiuijMbLpd+NWPql2k2eHllQ+QGzye9WjCksu6F+p6
         DOoVgqnioU+dhNPH+rqovXqSsvxGxvDig+pxUifI+XrjDaCLwtLvul2BjdCyuJRU/Dtc
         Wllg==
X-Forwarded-Encrypted: i=1; AJvYcCVNBqleZg9aZ9QlZB0V1s9/nt8uSKDdRG6wJaasI/kPFUln6uWFRkeTEDw9K7tQ3jheral5aPOting=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy84fzochq5An/maHvGzZEt4+0SZfxFFepVohF/fFj9KKUh8frW
	zE+AqgOiIuEi05FQn/i5dbcf7hKMHUy/xrYXnmo8bsqFtcMLcJwRws9r6IjorzzDkWzPSyUGG3p
	RB7dDvdBIYLWpIMjglIMoDElLxTu+a0xLb0h1zAgUCNaHhxoLrOn1zfY=
X-Gm-Gg: ASbGncvAbqvzX/OPzt0ej3TANtuu4oTSgDg0nYN+jKR/PdFhZvvwfSODsri5Rz0wHU6
	rhzTSQj0LfLyn04m7GpIWq1EuZtIaviuUmxw4nYQDPoZW6unJdI/c6VwbTXFcBIjwq+lXsZp9jl
	i9+UOZkp7hS4UFBIwEjMi2iKPlGIni8XVxqoIHMxFh2wpZ
X-Google-Smtp-Source: AGHT+IFKLep+oVnJLAdhYlsfnnGURCM0jm5x9XuhkDAOYH3BwxGyY+sHbb4Wkeme1jFAonQLcsi0Q2V0d9n0diMCHJo=
X-Received: by 2002:a05:6902:f84:b0:e81:9aa9:88cd with SMTP id
 3f1490d57ef6-e81a20d40demr18795796276.8.1749479161518; Mon, 09 Jun 2025
 07:26:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174908565814.4056588.769599127120955383.stgit@mhiramat.tok.corp.google.com>
In-Reply-To: <174908565814.4056588.769599127120955383.stgit@mhiramat.tok.corp.google.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Jun 2025 16:25:24 +0200
X-Gm-Features: AX0GCFvF_id35MOPl_pL8yIz8wUA8Ns9lzvlVE2LmtTNl-drJlr2CqeBViKQxTQ
Message-ID: <CAPDyKFrejbW1d+jSSJE4K8Zb08CeMHiH9pC=Sr=Y51Lyy4Fhow@mail.gmail.com>
Subject: Re: [PATCH] mtk-sd: Fix a pagefault in dma_unmap_sg() for not
 prepared data
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Jun 2025 at 03:07, Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> mtk-msdc driver causes a kernel crash after swiotlb buffer is full.
>
> ---
> mtk-msdc 11240000.mmc: swiotlb buffer is full (sz: 16384 bytes), total 32768 (slots), used 32732 (slots)
> mtk-msdc 11240000.mmc: msdc_track_cmd_data: cmd=18 arg=0397A6F8; host->error=0x00000004
> Unable to handle kernel paging request at virtual address ffffffffc0001fc0
> ---
>
> When swiotlb buffer is full, the dma_map_sg() returns 0 to
> msdc_prepare_data(), but it does not check it and sets the
> MSDC_PREPARE_FLAG.
>
> swiotlb_tbl_map_single() /* prints "swiotlb buffer is full" */
>   <-swiotlb_map()
>     <-dma_direct_map_page()
>       <-dma_direct_map_sg()
>         <-__dma_map_sg_attrs()
>           <-dma_map_sg_attrs()
>             <-dma_map_sg()  /* returns 0 (pages mapped) */
>               <-msdc_prepare_data()
>
> Then, the msdc_unprepare_data() checks MSDC_PREPARE_FLAG and calls
> dma_unmap_sg() with unmapped pages. It causes a page fault.
>
> To fix this problem, Do not set MSDC_PREPARE_FLAG if dma_map_sg()
> fails because this is not prepared.
>
> Fixes: 208489032bdd ("mmc: mediatek: Add Mediatek MMC driver")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Applied for fixes and by adding a stable-tag, thanks!

Note that it looked like the patch was not entirely correctly
formatted, but I fixed it up when applying. Please have a look at the
fixes branch to make sure things look okay to you.

Kind regards
Uffe



> ---
>  drivers/mmc/host/mtk-sd.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 345ea91629e0..3594010bc229 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -827,9 +827,10 @@ static inline void msdc_dma_setup(struct msdc_host *host, struct msdc_dma *dma,
>  static void msdc_prepare_data(struct msdc_host *host, struct mmc_data *data)
>  {
>         if (!(data->host_cookie & MSDC_PREPARE_FLAG)) {
> -               data->host_cookie |= MSDC_PREPARE_FLAG;
>                 data->sg_count = dma_map_sg(host->dev, data->sg, data->sg_len,
>                                             mmc_get_dma_dir(data));
> +               if (data->sg_count)
> +                       data->host_cookie |= MSDC_PREPARE_FLAG;
>         }
>  }
>
>
