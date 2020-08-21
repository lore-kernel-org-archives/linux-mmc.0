Return-Path: <SRS0=v+1n=B7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54188C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 13:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DC3D207DE
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 13:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xWvEjuaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgHUNEq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbgHUNEX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Aug 2020 09:04:23 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A35C061385
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2020 06:04:22 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id r7so772351vsq.5
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2020 06:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PUu3fHHmkeuVepi71Wapqf6SIBAbLgY60c5ePr4Tr5Q=;
        b=xWvEjuaMvJemjlkfe+Ap9R17WJfFuWvMW6PrxySz5Z1aapbrNHnl3KUUcxr3zD3Tym
         CAK5E4QdvKEQ0yuv0xBEURL/POiwwYxlhZyie+qmxKeaJ2NplhRBZBCoDDui+TvDB9aa
         BSvOSr8sUOrq59sepQNZxAwLrw5cKeWVI8eLZEIKQTknFjJRA/cJ5JAY03MaYw+Kluat
         metgRHL7rPEgMnYg4twc4abWb4W+L+53V273bOY17j2+vrrCyfj9Si0sEMLgAA+iopDU
         r3wMBePsk3WYs9cmq38TcHhLG/k8RYfCKDH8ajy7Gd0z5OvYI7wnpaIOye4FC6xXbSxW
         k8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PUu3fHHmkeuVepi71Wapqf6SIBAbLgY60c5ePr4Tr5Q=;
        b=tX9zjP/BEhwg8dtfOex62KvJwEdMYsLKZ4uuQWtpiehmjTmkBpppErke6AH47L329t
         we3Sq8dLomPXqj/e54HOiS2lpCdSzSC9NnNYTzoDsZ5HvY7Yo2niu4UqSHckHmN6NSSI
         P3WBY6ue9WGxPiUOff7xtQfRcr93Q7JNFCputDLEUIci430sKw+LFvCmonA4kVWucKT3
         drTMPiFHF//qBZyYdukbJKuMbqmjJyzVxi4eVkr4sMMcyDxtHeJhTwLsksGqJn88+zJ6
         xqnDyzpbRJBdIcdDgOGu0xug1DLyqtYqqd24PxqdSExmcK9A3wNqVyk/mcif66Q7SVOY
         dq9w==
X-Gm-Message-State: AOAM533Q71KOHOXdKdmiGOuzP+TKbqfXxrcixM3xiSnTo6iak+VbaMes
        0JuFhQImzfbmQKj4n0QJF67BZ1+1c6wXah5Xgzc1WQ==
X-Google-Smtp-Source: ABdhPJxbYaWSzJFov0NskkKmoYuLGjGxBhpX8rOfjV11Vo8G+t407OAs3qSCHQhDuSlVhwUhaDTTVZG4FsZQNUnlNu4=
X-Received: by 2002:a05:6102:382:: with SMTP id m2mr1515570vsq.34.1598015061334;
 Fri, 21 Aug 2020 06:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <1597135057-22272-1-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1597135057-22272-1-git-send-email-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Aug 2020 15:03:45 +0200
Message-ID: <CAPDyKFpdijC4V=eq6mOXAzyt_spBizi6wz-ZMy53pZJwT27e2A@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: host: sdhci-esdhc-imx: reset usdhc before sending
 tuning command for manual tuning method
To:     Haibo Chen <haibo.chen@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 11 Aug 2020 at 10:42, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> According to IC suggestion, everytime before sending the tuning command,
> need to reset the usdhc, so to reset the tuning circuit, to let every
> tuning command work well for the manual tuning method. For standard
> tuning method, IC already add the reset operation in the hardware logic.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index a76b4513fbec..cf335c661cc7 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -987,10 +987,20 @@ static int usdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  static void esdhc_prepare_tuning(struct sdhci_host *host, u32 val)
>  {
>         u32 reg;
> +       u8 sw_rst;
> +       int ret;
>
>         /* FIXME: delay a bit for card to be ready for next tuning due to errors */
>         mdelay(1);
>
> +       /* IC suggest to reset USDHC before every tuning command */
> +       esdhc_clrset_le(host, 0xff, SDHCI_RESET_ALL, SDHCI_SOFTWARE_RESET);
> +       ret = readb_poll_timeout(host->ioaddr + SDHCI_SOFTWARE_RESET, sw_rst,
> +                               !(sw_rst & SDHCI_RESET_ALL), 10, 100);
> +       if (ret == -ETIMEDOUT)
> +               dev_warn(mmc_dev(host->mmc),
> +               "warning! RESET_ALL never complete before sending tuning command\n");
> +
>         reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
>         reg |= ESDHC_MIX_CTRL_EXE_TUNE | ESDHC_MIX_CTRL_SMPCLK_SEL |
>                         ESDHC_MIX_CTRL_FBCLK_SEL;
> --
> 2.17.1
>
