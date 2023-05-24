Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E228C77B7A
	for <linux-mmc@archiver.kernel.org>; Wed, 24 May 2023 13:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbjEXNLj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 May 2023 09:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbjEXNLY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 May 2023 09:11:24 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9081B3
        for <linux-mmc@vger.kernel.org>; Wed, 24 May 2023 06:11:22 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-55db055b412so88488577b3.0
        for <linux-mmc@vger.kernel.org>; Wed, 24 May 2023 06:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684933882; x=1687525882;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oso4v1E0bkWDfuZFGRWc8pQY1FBubFJsVEaGbMpS84k=;
        b=Apaj5KDsXHrYKpPqQC4wT+FQzOj8DqWhEJZX9xCxaPJsp2jqKzPsDXRXg8F7SFc0g2
         LJ8kgR+31Wig8EpUQA38/eY6S2skw/bt6HFl6O1U2zauerZFWECwx/byD4KS9v/J/tj1
         +0Vbcmd6oAnsVQtqzT5zTfoLiMLO5Y1ihXZuRmUl1R57aCUBtuWiHOqf84g6zWIJa5Ax
         rcSjKLFL/PI2iktW5Ws8dbE55HWnIvvXtYPdpI86pli3OiQaBOpGi1zue9rWPUQ6urzV
         rJehoLTPlOTNvJUfCsYVgxxm5+uTLx8WctKuoYZebj3UXmDs6TywBX37LTf4HVSTVAew
         Aeag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684933882; x=1687525882;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oso4v1E0bkWDfuZFGRWc8pQY1FBubFJsVEaGbMpS84k=;
        b=NfcfYmvX60eGqi/SNHe1W7T7Tyd6jaT6JQH+cpCnyq9nkSCqfsZE1emP2UhuG9Dv3U
         jDjqD6w3dY/LSYZbfaS+Q4wFUfr7EQ4Nh78/wdS3jllAgjr82HTwLrEs2T8NqgZwGdlG
         so+6OOXXTEph65LVWmk9RC2+rk50ezSTxD0kAhVNXpAfLdCoJjq7FZFFF3SnIf79Y/zc
         12RR23E/lg1YrTSgci3tJefPwCZ0iVuPv2DD2CK30Xh/I4UDG9CYlcxLUI8kXitBWCpt
         W5QEluReetSuwt33ATQSqxsiAYffoELjYwArzDy8RPGgYE1to/+8jFiPW61V4cDPiJJW
         uq8Q==
X-Gm-Message-State: AC+VfDxSZFtfwRSVdNGsEUj2FR3nmpWef3BoLNQX5yURXVA/2HY1ul6n
        0WpD+18v/fZcjQ5V/2OVRTBWTrk2+Hy4qJf8jjaHrw==
X-Google-Smtp-Source: ACHHUZ6bcKDs7Amsm5cCpd2ysnRqkResVkUy0BUfWRZFtHYtlv9QgDcmI01yi3hpqYLAG1pkAX3zEoSaS0pxpIYQtvA=
X-Received: by 2002:a0d:cb55:0:b0:54c:1716:b20 with SMTP id
 n82-20020a0dcb55000000b0054c17160b20mr18232628ywd.17.1684933881824; Wed, 24
 May 2023 06:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230510064434.1.I935404c5396e6bf952e99bb7ffb744c6f7fd430b@changeid>
In-Reply-To: <20230510064434.1.I935404c5396e6bf952e99bb7ffb744c6f7fd430b@changeid>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 May 2023 15:10:46 +0200
Message-ID: <CAPDyKFoWoJLf8utGxv3RytkvVypaC0Qdo6OZUyfupfo822SA3g@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: Avoid ugly error message when SDIO wakeup
 IRQ isn't used
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yong Mao <yong.mao@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 10 May 2023 at 15:46, Douglas Anderson <dianders@chromium.org> wrote:
>
> When I boot a kukui-kodama board, I see an ugly warning in my kernel
> log:
>   mtk-msdc 11240000.mmc: error -ENXIO: IRQ sdio_wakeup not found
>
> It's pretty normal not to have an "sdio_wakeup" IRQ defined. In fact,
> no device trees in mainline seem to have it. Let's use the
> platform_get_irq_byname_optional() to avoid the error message.
>
> Fixes: 527f36f5efa4 ("mmc: mediatek: add support for SDIO eint wakup IRQ")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/mtk-sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index edade0e54a0c..8ce864169986 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2707,7 +2707,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
>
>         /* Support for SDIO eint irq ? */
>         if ((mmc->pm_caps & MMC_PM_WAKE_SDIO_IRQ) && (mmc->pm_caps & MMC_PM_KEEP_POWER)) {
> -               host->eint_irq = platform_get_irq_byname(pdev, "sdio_wakeup");
> +               host->eint_irq = platform_get_irq_byname_optional(pdev, "sdio_wakeup");
>                 if (host->eint_irq > 0) {
>                         host->pins_eint = pinctrl_lookup_state(host->pinctrl, "state_eint");
>                         if (IS_ERR(host->pins_eint)) {
> --
> 2.40.1.521.gf1e218fcd8-goog
>
