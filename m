Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7822B31960D
	for <linux-mmc@vger.kernel.org>; Wed, 18 Feb 2026 12:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771418030; cv=none; b=Q6kFdIAOW+58W6fYfXQvLTl8/oBwojegwpwcg/jRa/iAvCu5pyI0G/cuKjoJFsaNx33aVZ+IY6Q0Ig9kuVbPw9CwuXdTr6KbBntGl2vHr19Sz4IG0N39Vj/HO5li1F1MhOCtqFOmYdh8F3ncZmrZDkHOM+1JF54OzKks49c2v2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771418030; c=relaxed/simple;
	bh=PcdZIrVKr/Pd1Zn/N/Z35F9qghKTj/esGt6SKwLxzS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jtf+j14gENGDA+A/0w6XKI63Go3x25heJjaIImZktpw3elfQaf4I9NmXLnWPMvM1TFa+GwV8dhmJwXyDyqFWkK5EcHbt/3oCPQUbOJqSN5ZUmTUsPnCt58UtEXczQdcA+cgrSR85eYw524HTim0dR2LBlTAeRRUa6ysvSeQ1iNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvxHpD9F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvxHpD9F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F30EC2BCAF
	for <linux-mmc@vger.kernel.org>; Wed, 18 Feb 2026 12:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771418030;
	bh=PcdZIrVKr/Pd1Zn/N/Z35F9qghKTj/esGt6SKwLxzS4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WvxHpD9FwSWpsrs6FKcLEMn3HuFKNyIKS0XxxxZFyVahyWEQhyi2dKjsB4W7Zuykm
	 JZDio9KPtRbeWiUSyu/ISvTmF+wQpY4qUD5CVQWjKqkC6gkHX8UR4pPg+yUOn+0QlD
	 EnG81OqeJKvn8chTH7I9Sifb2AosVlLCPMWyuMqvZpCPSH9JIOVp3t8HROOpCdbkns
	 jAfT+bT9vACxPANRAt0BwOTQx/ezNTzf17B5f/eOK2PsKrOEqCxOrPfB2LDfgVFIN8
	 HjvbH+ag1lKzTSwICd0lYRX/9xKTtfTj+HvQDD33winl1sPVZx0YF43WF2l7JIJT7G
	 OfiWmhj2gVCpw==
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64ad9fabd08so4545783d50.2
        for <linux-mmc@vger.kernel.org>; Wed, 18 Feb 2026 04:33:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXeXC/4onPZ6zJXiBUXr2dYsdeRkl8vw6hjk8eAVE8tyK6IvrenjwzNLOq3pPWBZ4l4vvuPgddKTaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNHNSTuvGAoto3id1/wr9zSGUJ1CD5B0eTxVCmNELbD04ENtAF
	o+UJwvcyXo1mTUCw4315mMkh+UJJtrReELjiTfm4cCPDvRdKUU09T5RC3QA9JPALDcUe+2Hflwp
	FWsR4AK8qsqEAPeL/pUuR8HzlW0PfV9M=
X-Received: by 2002:a05:690e:20c3:b0:649:f002:582b with SMTP id
 956f58d0204a3-64c14ac48e4mr10700712d50.7.1771418029646; Wed, 18 Feb 2026
 04:33:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024-sdhci-bb-regression-v1-1-b57a3d4dbc9f@linaro.org>
In-Reply-To: <20251024-sdhci-bb-regression-v1-1-b57a3d4dbc9f@linaro.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 18 Feb 2026 13:33:38 +0100
X-Gmail-Original-Message-ID: <CAD++jLkWut=YDiv0uEffmYNTjrHhwY3=O3+ffDtMVU80wczXBQ@mail.gmail.com>
X-Gm-Features: AaiRm50ISFJ2laD-LdXSm0tILGGW0eWjtaB7cSVwFtj6rrKYccvTvDDUG284NZs
Message-ID: <CAD++jLkWut=YDiv0uEffmYNTjrHhwY3=O3+ffDtMVU80wczXBQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Disable bounce buffer on SDIO
To: Michael Garofalo <officialtechflashyt@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	linux-mmc@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Michael,

1. Did you verify that you were using in-tree drivers with B43?

2. Did you get a chance to test this?

Yours,
Linus Walleij

On Fri, Oct 24, 2025 at 10:40=E2=80=AFAM Linus Walleij <linus.walleij@linar=
o.org> wrote:
>
> As reported by Michael Garofalo, the b43 WLAN driver request
> a strict 64 byte block size because of FIFO limitations.
>
> When the bounce buffer is active, all requests will be coalesced
> into bigger (up to 64KB) chunks, which breaks SDIO.
>
> Fix this by checking if we are using an SDIO card, and in that
> case do not use the bounce buffer.
>
> Link: https://lore.kernel.org/linux-mmc/20251006013700.2272166-1-official=
TechflashYT@gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ac7e11f37af71fa5a70eb579fd812227b9347f83..c349e5b507b63a5ee9a9dcb08=
ac95cae6b3d7075 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -650,6 +650,21 @@ static void sdhci_transfer_pio(struct sdhci_host *ho=
st)
>         DBG("PIO transfer complete.\n");
>  }
>
> +static bool sdhci_use_bounce_buffer(struct sdhci_host *host)
> +{
> +       /*
> +        * Don't bounce SDIO messages: these need the block size
> +        * to be strictly respected (FIFOs in the device).
> +        */
> +       if (mmc_card_sdio(host->mmc->card))
> +               return false;
> +
> +       if (host->bounce_buffer)
> +               return true;
> +
> +       return false;
> +}
> +
>  static int sdhci_pre_dma_transfer(struct sdhci_host *host,
>                                   struct mmc_data *data, int cookie)
>  {
> @@ -663,7 +678,7 @@ static int sdhci_pre_dma_transfer(struct sdhci_host *=
host,
>                 return data->sg_count;
>
>         /* Bounce write requests to the bounce buffer */
> -       if (host->bounce_buffer) {
> +       if (sdhci_use_bounce_buffer(host)) {
>                 unsigned int length =3D data->blksz * data->blocks;
>
>                 if (length > host->bounce_buffer_size) {
> @@ -890,7 +905,7 @@ static void sdhci_set_adma_addr(struct sdhci_host *ho=
st, dma_addr_t addr)
>
>  static dma_addr_t sdhci_sdma_address(struct sdhci_host *host)
>  {
> -       if (host->bounce_buffer)
> +       if (sdhci_use_bounce_buffer(host))
>                 return host->bounce_addr;
>         else
>                 return sg_dma_address(host->data->sg);
> @@ -3030,7 +3045,7 @@ static void sdhci_pre_req(struct mmc_host *mmc, str=
uct mmc_request *mrq)
>          * for that we would need two bounce buffers since one buffer is
>          * in flight when this is getting called.
>          */
> -       if (host->flags & SDHCI_REQ_USE_DMA && !host->bounce_buffer)
> +       if (host->flags & SDHCI_REQ_USE_DMA && !sdhci_use_bounce_buffer(h=
ost))
>                 sdhci_pre_dma_transfer(host, mrq->data, COOKIE_PRE_MAPPED=
);
>  }
>
> @@ -3104,7 +3119,7 @@ void sdhci_request_done_dma(struct sdhci_host *host=
, struct mmc_request *mrq)
>         struct mmc_data *data =3D mrq->data;
>
>         if (data && data->host_cookie =3D=3D COOKIE_MAPPED) {
> -               if (host->bounce_buffer) {
> +               if (sdhci_use_bounce_buffer(host)) {
>                         /*
>                          * On reads, copy the bounced data into the
>                          * sglist
>
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20251024-sdhci-bb-regression-a26822c56951
>
> Best regards,
> --
> Linus Walleij <linus.walleij@linaro.org>
>
>
