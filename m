Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164FB57F1CA
	for <linux-mmc@vger.kernel.org>; Mon, 19 Oct 2026 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420191; cv=pass; b=d5WLIhu4ncUsAK2DKoKgcSzM2R044zFrhS70fVoMcIgm9l0Ex8Ctqwu5wS8KO1cGvH64D8xj0M4ozBgvCmFIKKa5Hz+mLnGKG3CAbFxfX0U3WScN/oFWSMJqdL+XNoYpygQg93IJVWgNNHcoIAxQaGf/d+GOXD37DrTWCQQi3Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420191; c=relaxed/simple;
	bh=1815ZKD8D0Cw6LnUL4cFghBinoHsDcTyW6YJxteqQLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWLOxyV7QuZ3ffZjSFGpYXf3APZVXkIzJOht/spXP0Sv6nD4MK6n5vu2uQFJdrK0Hc6UkO34XjKM7DY83ThtQUkByyPajEn9E7KSjlwoLkpfDG3oqIvEMzizfjMFdFDu9NtvlVlNecb/h/UAgkAXJYgiBKySXJ2zvKdOMII+kMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yo5M6yyv; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yo5M6yyv"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93e503815adso197746185a.1
        for <linux-mmc@vger.kernel.org>; Mon, 19 Oct 2026 07:29:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792420189; cv=none;
        d=google.com; s=arc-20260327;
        b=fTXGOuNWY4YVLLPAWz6FwelbGjS0kR7KA6CdOmToS1kyIhVglb7Z8BiVpcK5Q34qBn
         8YiYpaJJz8QLhe5i7oBobJa68DeqETX4IwDfeGypMG0y3M0qXrHuxiCMfyUK+LNGSClu
         SBuFyb5Sd2bVhN4kRLdbYGCFQaxPSvnV/RMZoSf2ml1DcUO1gO9FkUpUsR4HsWNJXTyI
         gqKYCo3xOzKdcO3KA4HL0X8b1auLm1QAi13ofz87U2OMxfxcZlud/sxGYpaOe+/7XjTy
         LhYlicv0zVP4ORuU6Mv2N9cpn709H7KmLzxaOTsQjIxJd2V3Ro3Q+pE6Z2JRR9GgS1je
         HkMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G0dMN6vSXcfuXrHsY+C/X/nR9uDe+9XWJ3CV7QZbaZk=;
        fh=v2qUanTAdtzoZ16r/rn4hZ464xRNG9cubrwsUgRziks=;
        b=G/x0h4imwtfwVGrVnRjm+iPwQ513wz+bwZKhMZu95SXD8TZaPEc8HQiFx4YJ/fMmjE
         U0RMrzRUblOim4fptwOuc+1VSZfv7yhUF9cP47p1/bDEmcSLhpMyPOnb7L4bUNUMGh9S
         tXgK6kzqBUu4uvo/O0bZPLzNgFtArwuruvNafrOKIuXma8Fi9m27enjgzsSqQNWk4U5q
         230AjYj1r55j9Z/vdAZY0e8A4OIIDGQMhBCzvtbUo+EFhRk0eVXl0oXUzPGIAwpCobyo
         v2SeSDiIRbvWFATiVstKh/ngdHgT1IpLIIOjX8RzSL+2LcQBMxi4w/JzvnyWrmfEgyiR
         xQ5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792420189; x=1793024989; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G0dMN6vSXcfuXrHsY+C/X/nR9uDe+9XWJ3CV7QZbaZk=;
        b=Yo5M6yyvHjhJgBBk9/3+cZeYfCGs9gWgqFXTDtzLSKQ6bJbWDcLAG5cKsnKgEkHCML
         oBPGqsqWTlyC1LRO0kAwI6WSPMiqDpouBk2VysUpqMrN8sxojVjjL44stj0PHvKCQB88
         rwGKiHX+86r/AS8BrUB5JOgL3wVn9JElWr4qVB8KCPJ5puw+IzJpVrKrpkY4bqIe87hb
         eShcKku/GZVA5xWsj4DIvRkbfmEC5SBw70Rz5J9t6cnBn6bE0gW/1jCKSX00/MYDPNbF
         zZhghVWaOtvGrICp1o5Vih5YcRoW+jtd7Ij3FOSLlcgkDLqrIlMtFvC3aRetHT4WUf/M
         5EiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792420189; x=1793024989;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G0dMN6vSXcfuXrHsY+C/X/nR9uDe+9XWJ3CV7QZbaZk=;
        b=grIFBaoadcL8SOQQhf0A4FxZZy+aN77BNMdvNxk413n7kRqydxLzuRIAXKZD4Lzj8+
         evNFwsDDO9HEhQ337usmXTL7PZ3GWfKYyTZUW9H0Vtkn17xeAkBtE+vwYp6U+VDFqwk7
         r9VIdy45KRGO6RP7Nz0LmcLSRVxK/aF3sp2RQvZnJagj51zkhgodG1cLiwGSBhIA8GdS
         nJ2tfa/a6onmOPTgHn0YrX02FXSxhWcj0tBqu8tdueOqzaHmZLTH6vh+baN5C+Dr+4tS
         BnKWkwbKFQjIbNq3rliZlSPw8vRBPkDDpSCSQRPSqjuWDYA7iDz6Y6I4jDT9k7t/dKae
         eSVA==
X-Forwarded-Encrypted: i=1; AKwUvBxOSo1RSLhTsUXEwBxuwsTAo2oZD3llyAwTjPoCfrjF0DyGtPCyl/n/nrMVzGefYuIYxDY3WgV4MHM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLFfGiNKT/OdxU9MhINb89qudfZTJH6T5A8hr0fUpBqximANs59
	NP90wkXHrGyqNeYQynZKoOaQhYeoNSfz7Vu96w0CO4PL9tcptDt00LoMKkkvSgvk3hTlqarbwhz
	IIU/Vsh6G2MkNOxAC4qno2+xiJvLmiO6w7k6I
X-Gm-Gg: AYBFou0V9UAUlscwSYyswYlhnwK255V1m+smd1XDQ6AkH6aRP9r/s/+7Ak7axE5Rxcs
	QUx8JZfg+5oDaRLiXn9+rjgDKH/8+G4dHksJakTPd9mtWe57HLhFua3KDG8AB68FsY9plzAH5+e
	btlOF4m8IkXEhk2kJdihtvJSjjT8KXpFhvknbGhYt2xF6eXnOkFvFwo1mZ2sjB/ZGEAiuPhy+k7
	yGFzYpa1C8ZKYQcfO0HF+8z+d2Fe61AdnPS8I39o97fCtF2Skd/n/CjCncf2PqcXGfMeZqkzSuP
	mokk9cCPfFU8rulg52QRXsjU31bokCWS6CjVvahQxWnEEe6rR8iCT5vHLNjpxBJC8U2i86P/KMb
	odqNUJIbkNjFQ
X-Received: by 2002:a05:620a:8808:b0:93e:c12c:f12e with SMTP id
 af79cd13be357-93f29df8430mr1133759085a.73.1792420188341; Mon, 19 Oct 2026
 07:29:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261019135307.2074577-1-bruceli20040604@gmail.com>
In-Reply-To: <20261019135307.2074577-1-bruceli20040604@gmail.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 19 Oct 2026 18:29:37 +0400
X-Gm-Features: AclHuK9cnl2EsfcrhGGH-sXis-mAncR2ezLY-0k25GrZdO9W1GU6GuzZn-sH_E4
Message-ID: <CABjd4YzjRAJ8+U+fmSNjbx7AbD8Caiit5MpE=NEL=SsmSc5SQQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: wmt-sdmmc: release DMA descriptors after stopping
 the host
To: Guanxin Li <bruceli20040604@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 5:53=E2=80=AFPM Guanxin Li <bruceli20040604@gmail.c=
om> wrote:
>
> wmt_mci_remove() currently frees the DMA descriptor buffer before calling
> mmc_remove_host() and freeing the controller IRQs. The controller may sti=
ll
> be using the descriptors, and an interrupt handler may still access them
> during this window.
>
> Stop the MMC host and free both IRQs before releasing the DMA buffer to
> prevent DMA or interrupt accesses to the freed memory during device remov=
al.
>
> Signed-off-by: Guanxin Li <bruceli20040604@gmail.com>
> ---
>  drivers/mmc/host/wmt-sdmmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
> index 489daee4f4fc..c44befabc909 100644
> --- a/drivers/mmc/host/wmt-sdmmc.c
> +++ b/drivers/mmc/host/wmt-sdmmc.c
> @@ -896,14 +896,14 @@ static void wmt_mci_remove(struct platform_device *=
pdev)
>         writeb(0xFF, priv->sdmmc_base + SDMMC_STS1);
>
>         /* release the dma buffers */
> -       dma_free_coherent(&pdev->dev, priv->mmc->max_blk_count * 16,
> -                         priv->dma_desc_buffer, priv->dma_desc_device_ad=
dr);
> +

If you are moving the function call, please move the comment too (or
better yet delete it altogether, as it doesn't add much information).
And no double blank lines please.

>         mmc_remove_host(mmc);
>
>         free_irq(priv->irq_regular, priv);
>         free_irq(priv->irq_dma, priv);
> -
> +       dma_free_coherent(&pdev->dev, priv->mmc->max_blk_count * 16,
> +                         priv->dma_desc_buffer, priv->dma_desc_device_ad=
dr);
>         iounmap(priv->sdmmc_base);
>
>         clk_disable_unprepare(priv->clk_sdmmc);

Other than the above,

Reviewed-by: Alexey Charkov <alchark@gmail.com>

Best regards,
Alexey
