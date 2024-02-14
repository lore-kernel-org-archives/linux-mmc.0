Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B241B7F9
	for <linux-mmc@vger.kernel.org>; Wed, 14 Feb 2024 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707909406; cv=none; b=HZcUfw+ud3KFZJTEGm3B+8A3qqJ7+ozv+RqmtIuscqfjwncVoBb0vF0J4xE0SyV4QkzKGdKi83V+RNrI3lFRWQOQe6mpR78QlbHuTJFwK+dM4HxMArL8SfyOG05TrCrUmEMj9UEBCeScgKb3y+5RoNGc8C5oT7O+0+2YcHygxEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707909406; c=relaxed/simple;
	bh=CorA3UG1u4Z30koMSg5l+MLwFOJanBiEK6JJM33nAkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1lLsh9mmWuG3aTjIbvCSp49t2rORF7GLs078mB4w0JSq/QKEMm63ER8CswjhotJ01Jccb7s1M/iR2loV/3C8e9pXjshM6e2O1bZWU66BbEqMv4PynF3TnaMY99hPKrSvYoY7SiSOyyvllrjU35SXDCm09hGiye87H0r/nw2DrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MnACvIFJ; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MnACvIFJ"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso5572461276.3
        for <linux-mmc@vger.kernel.org>; Wed, 14 Feb 2024 03:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707909404; x=1708514204; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uj6mDAYoRHzkcy8dqG4hUvzPf2kuoVsNIBmDePLCGTA=;
        b=MnACvIFJY5VoncDRNkpZ+d3mGxbk5VggNN0kc5RVbpfeDBHidEtBB0avzUwYmZ3r/t
         y0a7BHRSQKt5jj/tVvfk5r8jDxOOT5jqCdOnXNjM0SHV3ioc+nWDvFUezFjrvuEvvijr
         MrKr+wcCMMm1kRhrRgiqOzwuNLhJ4wfuVj8kuiX92ojMDkgjeKYwTQiZDA7T1RcM5ZHT
         VsyxSfAtu6PuziaEY1a15lShleW7uoaWBsu2adCm2PeH7Rf3tccT/mwYvXNCtRzbJ8VP
         5J9lA9B6m/I4loHsvUDGsPpVzC+swLKQixsREx518rCzzW4UJFlAyfVSjXEdP0mX8g/w
         i5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707909404; x=1708514204;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uj6mDAYoRHzkcy8dqG4hUvzPf2kuoVsNIBmDePLCGTA=;
        b=ICiaajyvajx6NPzlIJ0kPchp6O+kBqkSV6zjRX7B8oBB593DBdCxeu0O6+kqe1FVoD
         AnWTA8yMYdrBdkw5CDZL+sa2B5r/fd4PHChrfExw39bO6N0WwzKMi/RS5lWB8tfDD+8g
         bl+ZIk4c70rClyaWBvhgk655isIsnRWxDwbdkrNo9NJRr/D0pYdU+QDIJPUk7C7GpDI4
         N111D+NISOlDpx5sYn78TNsl+/Ee9CvwtxNNuWM2kJJNt6gtBuje4Lv2PY0afSU9NmWZ
         mjGyR1j3QQTu5int0lKCYc6qNFMbNABKZlbhZJXR5sTzoYNC4rwOVjZ8+ECVFdQJdsei
         8uoA==
X-Forwarded-Encrypted: i=1; AJvYcCVafAqavmnxO8UReULLdzSkF+N4vPljdwTF6lyRJR4AXSUsSWqFRcecF5p6JPOU/oZcGf+4YIMNgPL7+Gt/FUDjXqhVN8Lo6DVa
X-Gm-Message-State: AOJu0YyTV/SaGnkdKhj08XujPa99BRPOYVfUp4cDOEzxYQ0Hya1cdM1O
	QQWcI2L8L444WST/afbyRwpAhGucuTMq6ktsPase89OhR2JzdBEvcThSMr+qL/bFohbI0e7je2A
	lCyHxekQNaETQ6WMWqEcMp+IXBOQFU2RZyDUUeA==
X-Google-Smtp-Source: AGHT+IGR6d9+WdNJXu0uxM+Xlzc9aogCPu7mnmTFb0vI1BVAlCSxaoGjJYxY6TTrV91065vIGhvBhfdccdgYl7fPDE8=
X-Received: by 2002:a25:b29f:0:b0:dc7:6f13:61d1 with SMTP id
 k31-20020a25b29f000000b00dc76f1361d1mr2242861ybj.20.1707909403782; Wed, 14
 Feb 2024 03:16:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207143951.938144-1-christophe.kerello@foss.st.com>
In-Reply-To: <20240207143951.938144-1-christophe.kerello@foss.st.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 14 Feb 2024 12:16:07 +0100
Message-ID: <CAPDyKFpsABh4qsJv7sJiSZGWiBPM+umN2kp7teUYqdReC2a-zw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: stm32: fix DMA API overlapping mappings warning
To: Christophe Kerello <christophe.kerello@foss.st.com>
Cc: alexandre.torgue@foss.st.com, yann.gautier@foss.st.com, 
	linus.walleij@linaro.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Feb 2024 at 15:40, Christophe Kerello
<christophe.kerello@foss.st.com> wrote:
>
> Turning on CONFIG_DMA_API_DEBUG_SG results in the following warning:
>
> DMA-API: mmci-pl18x 48220000.mmc: cacheline tracking EEXIST,
> overlapping mappings aren't supported
> WARNING: CPU: 1 PID: 51 at kernel/dma/debug.c:568
> add_dma_entry+0x234/0x2f4
> Modules linked in:
> CPU: 1 PID: 51 Comm: kworker/1:2 Not tainted 6.1.28 #1
> Hardware name: STMicroelectronics STM32MP257F-EV1 Evaluation Board (DT)
> Workqueue: events_freezable mmc_rescan
> Call trace:
> add_dma_entry+0x234/0x2f4
> debug_dma_map_sg+0x198/0x350
> __dma_map_sg_attrs+0xa0/0x110
> dma_map_sg_attrs+0x10/0x2c
> sdmmc_idma_prep_data+0x80/0xc0
> mmci_prep_data+0x38/0x84
> mmci_start_data+0x108/0x2dc
> mmci_request+0xe4/0x190
> __mmc_start_request+0x68/0x140
> mmc_start_request+0x94/0xc0
> mmc_wait_for_req+0x70/0x100
> mmc_send_tuning+0x108/0x1ac
> sdmmc_execute_tuning+0x14c/0x210
> mmc_execute_tuning+0x48/0xec
> mmc_sd_init_uhs_card.part.0+0x208/0x464
> mmc_sd_init_card+0x318/0x89c
> mmc_attach_sd+0xe4/0x180
> mmc_rescan+0x244/0x320
>
> DMA API debug brings to light leaking dma-mappings as dma_map_sg and
> dma_unmap_sg are not correctly balanced.
>
> If an error occurs in mmci_cmd_irq function, only mmci_dma_error
> function is called and as this API is not managed on stm32 variant,
> dma_unmap_sg is never called in this error path.
>
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>

Applied for fixes and by adding a fixes- and stable-tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmci_stm32_sdmmc.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
> index 35067e1e6cd8..f5da7f9baa52 100644
> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> @@ -225,6 +225,8 @@ static int sdmmc_idma_start(struct mmci_host *host, unsigned int *datactrl)
>         struct scatterlist *sg;
>         int i;
>
> +       host->dma_in_progress = true;
> +
>         if (!host->variant->dma_lli || data->sg_len == 1 ||
>             idma->use_bounce_buffer) {
>                 u32 dma_addr;
> @@ -263,9 +265,30 @@ static int sdmmc_idma_start(struct mmci_host *host, unsigned int *datactrl)
>         return 0;
>  }
>
> +static void sdmmc_idma_error(struct mmci_host *host)
> +{
> +       struct mmc_data *data = host->data;
> +       struct sdmmc_idma *idma = host->dma_priv;
> +
> +       if (!dma_inprogress(host))
> +               return;
> +
> +       writel_relaxed(0, host->base + MMCI_STM32_IDMACTRLR);
> +       host->dma_in_progress = false;
> +       data->host_cookie = 0;
> +
> +       if (!idma->use_bounce_buffer)
> +               dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
> +                            mmc_get_dma_dir(data));
> +}
> +
>  static void sdmmc_idma_finalize(struct mmci_host *host, struct mmc_data *data)
>  {
> +       if (!dma_inprogress(host))
> +               return;
> +
>         writel_relaxed(0, host->base + MMCI_STM32_IDMACTRLR);
> +       host->dma_in_progress = false;
>
>         if (!data->host_cookie)
>                 sdmmc_idma_unprep_data(host, data, 0);
> @@ -676,6 +699,7 @@ static struct mmci_host_ops sdmmc_variant_ops = {
>         .dma_setup = sdmmc_idma_setup,
>         .dma_start = sdmmc_idma_start,
>         .dma_finalize = sdmmc_idma_finalize,
> +       .dma_error = sdmmc_idma_error,
>         .set_clkreg = mmci_sdmmc_set_clkreg,
>         .set_pwrreg = mmci_sdmmc_set_pwrreg,
>         .busy_complete = sdmmc_busy_complete,
> --
> 2.25.1
>
