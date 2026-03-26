Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6687738B121
	for <linux-mmc@vger.kernel.org>; Thu, 26 Mar 2026 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528496; cv=pass; b=RLtyx19s3O2T6uKeL9OdFv8HhZUBTfwL+MC15j+KeXAwfTRFrOfneVgNHYLlmT4jbnJx/i24lvX42HjUOyY7zkEqIXZ8vT3G5SOVx5tzjGZSdrszt2bo11I/LHQ0w1urMlRAIQ9CrryilvJTDdLOeMvT33WtfwQLkzj27lAaXEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528496; c=relaxed/simple;
	bh=p+oFtCDEdez9suBe9pe1fZYHjfKOx23fi/EG0H17aGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFkEruigKp3QQzYr1KpBVcO98xKdy5gYqDa9DMT76sAUKH7+GPCDea+merdmt5jQmog84SxiPZ4/TERfJngo6zyWt9MMT8TXMv+13JfY1ukLFD3Q6thJQuA6bOZj0e0KwXpg/VPI3Y/v9BWdvCb+Rle6FWGWzbfnl6m3Jl7pJ2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hZZYgoI3; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hZZYgoI3"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a27b5ad832so1048279e87.2
        for <linux-mmc@vger.kernel.org>; Thu, 26 Mar 2026 05:34:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774528494; cv=none;
        d=google.com; s=arc-20240605;
        b=CEHSoIAEucWsBArSOoN2MCm1BfLTaw2JN2CVjxUbZxVz/aLUMgAr/v4fAQNn+HHQrq
         heUwKIXDe/GVnyGKWpkYy+LYT792bqQzpjjgfxIwI6KcwCVdnuFAvWVEwYR1oO4h+zbZ
         eybATWEcyosPBoV3aDsciWb7Y1erPsdWvj6j0e5cXI/L50UdkF2e+s2MjndIQmZmo/PL
         +1H/dpJzjliqCli929hR/dHrxw8ludRUSJ7QjqcvlDShBh/MdaIePvPElykqmwHgIf9A
         O5/LJiEuqJf1Xr9D3zZ9ZSc+y2CBa6YcmmEQChmVzjOnRucwt3wTCdxVShSX1xicSXYy
         vlDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fMtjTcJq5eIA2qihI+2nGicxmL8Td67ZjB3pSoQD8ho=;
        fh=LJUC49DbYv35aR0rdP6MssAN7iNYv+GJZ5BARiQ/aY8=;
        b=dR/Bf0YdoYyToYLqv34tqnp03TWzg1OiFWht//2+IR7YDhwyFW21/UtFHrB5b3yFik
         VKvu1rClnTVzqnTorBmWV8Aa3gG/QltHpvLbmBpeI3QBR2k9GfWylx5/8toBhzIx7XsY
         WKxbw8Tt6KhVEYr96Fht6RL7BEQbqpIzq98jt+lIO3CnHUOggWC7b/GtTRE08Fol7Kip
         CvEET/0mdDSbpaNVIg3cEsCkKikZpao4nj3Le2lgDZHCgvcBeDLIcxtCkXjdDVhu/meh
         g+c9NVaPwOdaZDiSK/OWMyI4E+6u7Cel96qGma9tYs1KQQY1R0t6lgLhW9lfSD/AoEn0
         IA5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774528494; x=1775133294; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fMtjTcJq5eIA2qihI+2nGicxmL8Td67ZjB3pSoQD8ho=;
        b=hZZYgoI3hZE5jscwY/qgSvmSORNBapT/tnNUPeOYH6nSseyEGXl7xg043KwGvyQ5XQ
         39qBu0hUvs+id894K45MXjjb6hRr2s9+KV0jHYz905AFh/zJF7tkMXcKUwMOQMSe/sZ9
         c+AvYiJN5f/KXuqWaYijmCA3iFUUPDMvQ1WW59A6rMVtqtRnUHyxfrkQmJ7tt/emBdMo
         aEOs1SlkXT0z8GwwZeXG/0zvlgrHD69dX8QVk5naCNB7QHExGd4Gi9ZNpyQO9a4WAwCJ
         Aa+kPaoFIfonDIoOk41YCP5QqlQgOfSyl4n46heEFQtmzQF+gXSFC/nGnPWaiBJK/cul
         gZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774528494; x=1775133294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMtjTcJq5eIA2qihI+2nGicxmL8Td67ZjB3pSoQD8ho=;
        b=caSFoxfnk3oNYdoVDLKEWdI0i5XvewXWrIfdOW40qqeNLNZYbeWiEkoGDQMhPAEZLn
         5UIafR+jb/NgpfcvolB+I0M9WX3X7OzN2WgaKy485jOnrvpw4JTPzjauqhrFYXxK35J7
         Gl/rxQbHYpPh8tBJ+DmdnplmExJrZhRbe3u/tkMHa35KRskX/3t+o3UVgcg11jQdjqJW
         3GS0WxeFXlsVUz4W2HmleNdBsExT9HPD/5da9X9wFwe5JFpZpFf2IQ6hB5N+PHrPP4/J
         rBNhS3WFNVp9jaq2KQP2ZG+DBOHgeqhnWwgvGy+JxHlK2x69u1SFCe6wSenf5hzKEftU
         kQHA==
X-Forwarded-Encrypted: i=1; AJvYcCUIioWJXqfIL1DQQWJgGTnmOwAFwpsyRpDNkXILEM4Q9YNzbXDdjzRn7fMJN6WzGNSZLgRUF/sAtZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwKbzteZPLOEXjT4CDn6t7XU7efHTYHL0pxdW/HsgiSTaBg7VQ
	WGXCK5baf24YjjUNo80ZM62UzmHQTPpdzGIBZ0g7KZqSW3yZHyKPnBvLBby7kD6EkZ6Fa13mHXg
	nJqS7Eb16RewZZVwcd+YGaNvKNs8ZcNZfp5lOFZ7qmA==
X-Gm-Gg: ATEYQzzVuMoe4ujTwWCPTcyydC/wYVrxZgbFAuJhY1T+TkwkdMSW/NFhqxkFfwzVUBZ
	lMcxszP1M8uMRX9kLTigzmZecRKzqIgMdFdmO2uu1nNBeCrZZLrzMvias6pNMAonnt2p1AWrfaT
	7ionGjREFwkTanJX/Iax3UU3N7T4Oyd1jVektUBljmqiKLX8iXMy8gQvKXAtmuP5cHul0ihRsX/
	jEdqLO+Zu+IzBvcFLKr4vd2NdN5SAOK1lW7To6KT1imkI/TraJi2hDG5bnZFlrk+0AqvIWaRCJg
	ni0qi7A=
X-Received: by 2002:a05:6512:3e0c:b0:5a1:43f3:764a with SMTP id
 2adb3069b0e04-5a29b979b0amr2997503e87.5.1774528493504; Thu, 26 Mar 2026
 05:34:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326030759.8107-1-ot_cathy.xu@mediatek.com>
In-Reply-To: <20260326030759.8107-1-ot_cathy.xu@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 26 Mar 2026 13:34:16 +0100
X-Gm-Features: AQROBzAUMJTYzzyeSawXUe9OdLfBc-C70N5GR1BByMjzhb7eLn_1dlJggBGZnww
Message-ID: <CAPDyKFoemi7Ss8706XVUCu6L64CUgcdGQNe9jBFSxaOPp2umEQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] mmc: mtk-sd: disable new_tx/rx and modify related
 settings for mt8189
To: Cathy Xu <ot_cathy.xu@mediatek.com>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Mengqi Zhang <Mengqi.Zhang@mediatek.com>, 
	Wenbin Mei <Wenbin.Mei@mediatek.com>, Andy-ld Lu <Andy-ld.Lu@mediatek.com>, 
	Axe Yang <Axe.Yang@mediatek.com>, Yong Mao <yong.mao@mediatek.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Mar 2026 at 04:08, Cathy Xu <ot_cathy.xu@mediatek.com> wrote:
>
> Disable new_tx/rx to avoid data transmission instability, and adjust
> .data_tune, .stop_dly_sel, and .pop_en_cnt to fit the overall
> configuration after disabling new_tx/rx, making it more compatible
> with mt8189.
>
> Fixes: 846a3a2fdff5 ("mmc: mtk-sd: add support for MT8189 SoC")
> Cc: stable@vger.kernel.org
> Tested-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> Signed-off-by: Cathy Xu <ot_cathy.xu@mediatek.com>

Applied for fixes and by dropping the stable-tag as it's superfluous
in this case. Thanks!

Kind regards
Uffe



> ---
>  drivers/mmc/host/mtk-sd.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 302ac8529c4f..b2680cc054bd 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -682,15 +682,15 @@ static const struct mtk_mmc_compatible mt8189_compat = {
>         .needs_top_base = true,
>         .pad_tune_reg = MSDC_PAD_TUNE0,
>         .async_fifo = true,
> -       .data_tune = true,
> +       .data_tune = false,
>         .busy_check = true,
>         .stop_clk_fix = true,
> -       .stop_dly_sel = 1,
> -       .pop_en_cnt = 2,
> +       .stop_dly_sel = 3,
> +       .pop_en_cnt = 8,
>         .enhance_rx = true,
>         .support_64g = true,
> -       .support_new_tx = true,
> -       .support_new_rx = true,
> +       .support_new_tx = false,
> +       .support_new_rx = false,
>         .support_spm_res_release = true,
>  };
>
> --
> 2.45.2
>
