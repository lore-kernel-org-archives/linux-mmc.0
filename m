Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4503A1CFE
	for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882616; cv=none; b=nPVxKzmPZtvoCDZPqUN7hijG8y30u56OouCQ+YGE9FfdRo2DV4GgacXNbP0hrziJqv+itzmDKyo6QLe4aD8nv1CwOAtC7PMGr+Rr4ImOtHEg4azRaluSOq0XYxnCBhi5tMh5pGsCJDSKdri9E1A9W+ImeX3+kRtqshHYjguXWh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882616; c=relaxed/simple;
	bh=DlS06Pjgk/46EKqBjrrww2QHkktHCCuHzNeSfhAUx4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWx7uyFCJDhexPHf2LQ4ysoMKnLh7dvNWpIQMQnJ+L9fkADButMLSKXFVx1JqLa77SI9WHUbbllHfT098AkKj3agLx0NK4/uPHdEgUG/+oaouArmn0LPDbT9x5p/cY42NixdzdugV2GLv2gVg7pgZqo45r1w8kSowYC783QxRPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AcnNmPFA; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AcnNmPFA"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-787e84ceaf7so30652837b3.2
        for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 09:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762882613; x=1763487413; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7MADnIkU7xOrr/MM2P4jAeg7XkEdpz6a4qe2VMmU4+A=;
        b=AcnNmPFAXj3rrb5O148VLNN1bCcrspWHkXc8RkZoZ7jkmblNXYI702K+YRNFTfekBV
         BlmZ/IvhPzTt7DXAoca1bFFFPNJVTMeYqN8QpvqAKe/SKjJzHnCipVJ4hkCNoV3ruBWx
         U0WRlk6G/WRHR2EOYurFsTigTtYk8z0aIxGQKWxKotYem+JF1uUrgglnXOyqblBAbKCD
         Nqf4wKR0BUeLDlMhvhsAzjKOx7skCSC2T0DvpZ5f9czzpKyMiSOItPofmQWhsYTbb4Qj
         Wwh8Hfwev3jNSW+cBtjUcLxL+R1E9GUV8gD8rlB9wInacvfOK17TxYUOJJu02V692TY0
         /tKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762882613; x=1763487413;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MADnIkU7xOrr/MM2P4jAeg7XkEdpz6a4qe2VMmU4+A=;
        b=wfc/Tltxw2ai5LnxM+X46gABLV9GbX6gqBRAjCXEsTb+wjQc0yHcTGbMznUAjZl/o/
         YqHaVL4SAfoVTv+4n2xjIHqEteqjJdnfm/xhBTkmD56Fu7SAaY4Nm2zvOqn/nrLOj+5A
         hKlAxjooLnFAJS5RWnrPf4akuGo64dmxLJW/1+KZgu9eyDQ94gK7HVXDsnScJ1F5PTWC
         tgKYP8IiB1fTS017LFGOTch+L64Xvl0GNollLmw66GXyPISmNFTZsqZv9qf1X/jMi9t/
         jaSN/rIFtgWaJfvcQKvRoUWVwob2JdZ55gOX0EPQwApW9yrL62F6WA1CN0q3awQejmLI
         lQNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcOqemhGCwj+E7MzsY/+a6r6e41+kAMHt+YkassCQi8MYahgjzLyNKzxeO46fvA3qDwJXpRKY4+Xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWUE83I07M04cD9i1TH1wIK9jf/uTpB9hoEAeZizP3ExPxaN5S
	T41KXvFAZusk3uX0d/ols/fy15s1AEwnvMQ4lBdqjdsTYW6+Rvtq5zszrEZeLUz79QJeyk31QAp
	I7l/2DbT26Z+syvOsfhqiFYK1XZGsa9d/8rNlhHkBTw==
X-Gm-Gg: ASbGncv5mEGdIYCSOO6wYHZwLU8Ir55Ijve3NzTa3qoSGKHiejTDZe28LJf3fcrCVse
	KCpTaxdL6UGYXAlYfqhC4RFLCK+mPf6yiYjR/iDhf/PFUUV8D6x1gR8DzRxqy2UOsC/6F9PbauP
	kt6xcgkBR9yZ0fLtR7maEBLwGfJ8zdBS2Edu1dI6ikBZnNoWC1N4bZ2u3S5O97G0Z6sz6X4CleH
	OwY6sowye3EdcRq22DhcKrATE4G1Ro9Y9fl/GV7Soc8mq4z02DGh0rO5ONSJBlTkKCfQzq0
X-Google-Smtp-Source: AGHT+IE8EqENW+ka3s5tGfwqiSIEe4stsUThcevDIM606OIDbbMBTKFRsfridyMjoX/1S3u13ea3XAYaXtSepBQyUkk=
X-Received: by 2002:a05:690c:4d09:b0:786:5789:57dc with SMTP id
 00721157ae682-787d541b354mr123645707b3.41.1762882613604; Tue, 11 Nov 2025
 09:36:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1762228283-5025-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1762228283-5025-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Nov 2025 18:36:17 +0100
X-Gm-Features: AWmQ_bmfDFVlk3K_o1BypDDZfP9YmJgmbccvjnXKBDypfp4_lyMPMlf6pXf8dB8
Message-ID: <CAPDyKFrdnzqeC=b5LBH+AsrDmbwXWTrZZpAHo58pB3=OdQf1cQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc-rockchip: Fix wrong internal phase calculate
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>, 
	Detlev Casanova <detlev.casanova@collabora.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Nov 2025 at 04:51, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> ciu clock is 2 times of io clock, but the sample clk used is
> derived from io clock provided to the card. So we should use
> io clock to calculate the phase.
>
> Fixes: 59903441f5e4 ("mmc: dw_mmc-rockchip: Add internal phase support")
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied for fixes and by adding a stable-tag, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/dw_mmc-rockchip.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index 82dd906..6813549 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -42,7 +42,7 @@ struct dw_mci_rockchip_priv_data {
>   */
>  static int rockchip_mmc_get_internal_phase(struct dw_mci *host, bool sample)
>  {
> -       unsigned long rate = clk_get_rate(host->ciu_clk);
> +       unsigned long rate = clk_get_rate(host->ciu_clk) / RK3288_CLKGEN_DIV;
>         u32 raw_value;
>         u16 degrees;
>         u32 delay_num = 0;
> @@ -85,7 +85,7 @@ static int rockchip_mmc_get_phase(struct dw_mci *host, bool sample)
>
>  static int rockchip_mmc_set_internal_phase(struct dw_mci *host, bool sample, int degrees)
>  {
> -       unsigned long rate = clk_get_rate(host->ciu_clk);
> +       unsigned long rate = clk_get_rate(host->ciu_clk) / RK3288_CLKGEN_DIV;
>         u8 nineties, remainder;
>         u8 delay_num;
>         u32 raw_value;
> --
> 2.7.4
>
