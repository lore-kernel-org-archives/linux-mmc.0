Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553AA261B73
	for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2025 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514565; cv=none; b=kYuizuVSMNiufiU6xOuwgMBouwgmoen60/g+NHUM+y65x39VesTIiew1Z3vMurUamc4AIWri8QxWn3sPLaCRubPswVYqE93L1JoSdJTUP86NDYpbUC0drtcFTk8JD4F5SV76rokU7X2zkJLfHIuW3vxsgiIrPbtYGAivtV5P86w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514565; c=relaxed/simple;
	bh=cQh8V4MSHSCq71cP6DQMTdJxWDVSbyeNn5X8j2CTEFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=isLLMNRCfHERJhVZ7Ogir22SKgITDM2u9UFFYv9E2F3aeaY8womVvExwxTZ0gyy39z2oXVX/VhL+S0UKARlzxkTQuRkYJmO7XI+PkCO7ilj2bkWhUBUlws5ulVXPGbWg+t8OiDxxW5A46tSKecvpZdHkl3Fgvg4z1M9/UQtoN0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v/UTAnAs; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v/UTAnAs"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d601859f5so32019857b3.0
        for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2025 03:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755514562; x=1756119362; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gf/h379UViupe5+NY6kzAfazLWPK0066Pyufbr9DpO4=;
        b=v/UTAnAsfZ+Xw+dqX1khMjCRZWNf8vHq2E7fq22bPB7stDeNTYEPNAIPYzRbDRko9E
         E+V+ikM9tFz9gnqR3tpd32FbvAKD4MmW+GKaOfR+VFbrU0VcHmwFlKCAIPDzoRnWeDUM
         Mi7TutgMukyq8gI7Fx/QmyX4r5SDBp5DDPnYNZLX1DHrx2o7R3AnM7LwQSs7l8RNtvwA
         oTJETfl3B9xncplFgg6mkufeCFJgmjqPTJ2MJflsvZOGxQfmb892SvGSDl9NOFBPYTgr
         RSRSC+uA9X4zjig+8leK5sFHp5hAqieq0k4V0Lyo6kla/BM2IKAHoow8bIqhywZ84SwP
         3jnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755514562; x=1756119362;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gf/h379UViupe5+NY6kzAfazLWPK0066Pyufbr9DpO4=;
        b=KNvStmgxvlg4xuKlckeYaXpcNNYPLnivW58pGrSc7YvAuiFBC6csYsbyE6jNd6FvgD
         6bzrLYeW4XQRJsfnmwVNhH3voliDoAwGOXAcWz+T7rgx+IalNpNGYJUmHj33IGGA7fQQ
         JL6oMNQPkdinKMFwJIbWLbLgTOQ5MgiBKdNsD6SlYsWQQEz/34dAxfyrpzqmnc9SI1Rk
         uqlufdPN1x7IwT5CW7iVdrdBsoWyiD2iA9Y0tlBPxTCLsoZ27cPcNgILX+OM7ZbQcROr
         YuE8foPTuF4b8YfXEw0uYviPRUtetr+oQuwPZ3t67VehXEpOeUdfsrN2txb5UtloxgvP
         3cqw==
X-Forwarded-Encrypted: i=1; AJvYcCV7PTqd6UDJOWIJ1/QUfcGXCm4CqCaXwcs361qQKaGZh9ZcjC7raOEYR6RId93SHK1GHx4ZvpNyx6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyKI52pbpqYGZ/wAywZrhHZghH5mxE0hBezeYvfoBtKUPPGkuA
	3EAQqyIZc2w6il8Pw6h5xyQUm5qnIPan4qfce2zWhI1GP5YVOK2wPWLTxYwbqIjJtYv6y+JQxRk
	qDh8afk9/0SysIqu/MccIjVXyEJ9JSIrbgTNjp/oFVQ==
X-Gm-Gg: ASbGnctnfxyhwF8ItLvCcFvIOpxFowl+Kgmah3d8z65O64ze5aTb54+0nFSKZUGN1ha
	3iZECtyE1R7+fQTN5i7fCtBsZnOLn0ai4ylkP0MDNrKy7kMrkgFEhBWer58QgkZCtRSdiSiYfjL
	srqQ0cHSwxpIhqot/aVmt6PkUbMh7scKy23AGy7/7oqn8O4H0eN1tmzD5MUQYAFEkuM5tbi+Szw
	fTX3iO5
X-Google-Smtp-Source: AGHT+IGpvbrDi4hUl48Zba/3/rBPfc8NraKhAc4AfrhtmjNoilheS+QB0WSMwYa9e4qE4gIontoviX/Mi8xWRVPKC+8=
X-Received: by 2002:a05:690c:6605:b0:71a:3849:f88e with SMTP id
 00721157ae682-71e6ddb2fb5mr146226437b3.17.1755514562208; Mon, 18 Aug 2025
 03:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812092908.101867-1-zhao.xichao@vivo.com>
In-Reply-To: <20250812092908.101867-1-zhao.xichao@vivo.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 18 Aug 2025 12:55:26 +0200
X-Gm-Features: Ac12FXwa1IzQiF3BDBFOd_R2WYobNi0PZbh6LfTaEAaRBfzgD2wCR6ijr3XXs00
Message-ID: <CAPDyKFqeA895DBDKJUcerXAYLGG_Em-vBu9eRMoVEwc0LyX=ug@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-mx-sdhc: use PTR_ERR_OR_ZERO() to simplify code
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com, 
	martin.blumenstingl@googlemail.com, linux-mmc@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Aug 2025 at 11:29, Xichao Zhao <zhao.xichao@vivo.com> wrote:
>
> Use the standard error pointer macro to shorten the code and simplify.
>
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-mx-sdhc-clkc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-mx-sdhc-clkc.c b/drivers/mmc/host/meson-mx-sdhc-clkc.c
> index cbd17a596cd2..6d619bd0a8dc 100644
> --- a/drivers/mmc/host/meson-mx-sdhc-clkc.c
> +++ b/drivers/mmc/host/meson-mx-sdhc-clkc.c
> @@ -84,10 +84,8 @@ static int meson_mx_sdhc_gate_clk_hw_register(struct device *dev,
>                 return ret;
>
>         clk_bulk_data[bulk_index].clk = devm_clk_hw_get_clk(dev, hw, name_suffix);
> -       if (IS_ERR(clk_bulk_data[bulk_index].clk))
> -               return PTR_ERR(clk_bulk_data[bulk_index].clk);
>
> -       return 0;
> +       return PTR_ERR_OR_ZERO(clk_bulk_data[bulk_index].clk);
>  }
>
>  int meson_mx_sdhc_register_clkc(struct device *dev, void __iomem *base,
> --
> 2.34.1
>
