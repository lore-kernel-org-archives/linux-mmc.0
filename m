Return-Path: <SRS0=vd7C=2A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C214FC2D0C5
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 10:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975032073B
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 10:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ay8xBFol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfLJKGO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:06:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35439 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfLJKGN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2019 05:06:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so19328564wro.2
        for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2019 02:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=yWA8VuK4fbXWgl7ohEQh+n62QMSnzlWImVwiKu0V3pU=;
        b=ay8xBFolpoZbEI0WIoC+oZXq9WoJqWUz/KTAkTpaMy4Tgc7Wz9t2HM6ZPg7QRC9SFy
         30c+BofWslloaWCCK8mVqcOrrMXbY/jDq1ej6KZcqv8TawX51qgQR7UqaLOJ8zhjXbDs
         L6QZ5Cl2g9lA/rDptk0Sb/cEQq1vKdOYOvderokk3AhS9NbkyVtpPJ096a30i0F6huqb
         gGQ/xVyLvYlkhFDBxWv72bnbFSx7vEkc+V+rluB2GDYzHVfdQVAA4bNqPwCba/mi9HME
         rLpYRLq9CrkXCQcvTjQblEpa6coyNP5V0yxOoWT7s9rXpaIZZ8j8JQrT5Go2g2Oi0KNs
         ih6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=yWA8VuK4fbXWgl7ohEQh+n62QMSnzlWImVwiKu0V3pU=;
        b=YUUb/nIdHQTIyWg8dA2OurZ6VIVwCjVvkw+YPOToUYczbwk8CVmZvd97VCIXkZe+J8
         b6d2ZDmqKisHprvLUe3qulV/UB4on8m4EkIaHJmnUSSza3VcHDYWn6pav1nXqordE0tw
         EA5eZF2m46A/wGcQigEasrgJDuQsmxHnBfnBbEUba0QStIDs5Us3H+sCqS9H4tcY8Ryb
         7SnNeC3Ki/JIXiHqOUgoEnZwZx0EezmdUVog4Rg/WnixaMS2Znj1G0ybKZeLBNS7uasq
         qQzpIJyiM4vJLD/t31DnEwhFcWhU12+RsCmfgfFA/cMjse/cWt6BW2DkkrJw59agEzws
         qzQw==
X-Gm-Message-State: APjAAAW2MzvCs2MgqEAbvOj+v9CAVpklr82/FVn3iwLsSa66mBI/H1q4
        ByJ+L7hw0GRs8atEedHKp/JZPw==
X-Google-Smtp-Source: APXvYqzRvBg9WoInjKPSS6kGkuYA+0mP75qg4hZ64I7fw/nPlmqw0YzWtInIDsLmMwZvk0LZtYBZhg==
X-Received: by 2002:adf:fe12:: with SMTP id n18mr2166082wrr.158.1575972371615;
        Tue, 10 Dec 2019 02:06:11 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k4sm2582166wmk.26.2019.12.10.02.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 02:06:10 -0800 (PST)
References: <20191206170821.29711-1-ulf.hansson@linaro.org> <20191206170821.29711-3-ulf.hansson@linaro.org>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 2/9] mmc: meson-gx: Convert to pinctrl_select_default_state()
In-reply-to: <20191206170821.29711-3-ulf.hansson@linaro.org>
Date:   Tue, 10 Dec 2019 11:06:10 +0100
Message-ID: <1jv9qowl4d.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On Fri 06 Dec 2019 at 18:08, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Let's drop the boilerplate code for managing the default pinctrl state and
> convert into using the new pinctrl_select_default_state().
>

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

> Cc: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index e712315c7e8d..35400cf2a2e4 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -161,7 +161,6 @@ struct meson_host {
>  	bool dram_access_quirk;
>  
>  	struct pinctrl *pinctrl;
> -	struct pinctrl_state *pins_default;
>  	struct pinctrl_state *pins_clk_gate;
>  
>  	unsigned int bounce_buf_size;
> @@ -327,7 +326,7 @@ static void meson_mmc_clk_ungate(struct meson_host *host)
>  	u32 cfg;
>  
>  	if (host->pins_clk_gate)
> -		pinctrl_select_state(host->pinctrl, host->pins_default);
> +		pinctrl_select_default_state(host->dev);
>  
>  	/* Make sure the clock is not stopped in the controller */
>  	cfg = readl(host->regs + SD_EMMC_CFG);
> @@ -1101,13 +1100,6 @@ static int meson_mmc_probe(struct platform_device *pdev)
>  		goto free_host;
>  	}
>  
> -	host->pins_default = pinctrl_lookup_state(host->pinctrl,
> -						  PINCTRL_STATE_DEFAULT);
> -	if (IS_ERR(host->pins_default)) {
> -		ret = PTR_ERR(host->pins_default);
> -		goto free_host;
> -	}
> -
>  	host->pins_clk_gate = pinctrl_lookup_state(host->pinctrl,
>  						   "clk-gate");
>  	if (IS_ERR(host->pins_clk_gate)) {

