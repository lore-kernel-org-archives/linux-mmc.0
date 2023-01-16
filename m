Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322A5C54EBE
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Jan 2023 12:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjAPMSC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Jan 2023 07:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjAPMRu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2023 07:17:50 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323111E281
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 04:17:28 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id y1so30168458plb.2
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 04:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UtLlpqyTeU+jIvE+zQK1ZQtO8VhJ1e0EqEgPPnCC8Vg=;
        b=VufIXqa9BNuskTdh092+yH/ghPEm8050FiWAKZjMEpxtgncak9a9ATug9O0hGnHpQH
         BuPOYISSyOj/bHBE5PyjLEIh6TepUnCy+lZxrFkY8EC8BDOqIsF+a4YS5H1UwEHrOZ95
         LxnRolNrf8VvRIV5V99KisTHvH7JvenyatnKs2vkRjeGnFcHRjwdBXpQ2LjVNbSI/GT7
         XZYD2yXIOGI0pKIp/7RcA5nYv/zgucC2rjy36kXc39QS58hQZGo9PYq+8tXnWdJaHnhC
         DhcoCd8NbgpZfYDLIxXPq91etyV/7butWdUOLT8wnqsyeot1GtM1lHFDz2yE/f9Al76X
         OLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UtLlpqyTeU+jIvE+zQK1ZQtO8VhJ1e0EqEgPPnCC8Vg=;
        b=nYlecYbZU1po4wozvfLlZsrojKfZTm2xQRBGzycs/L0IeGfcjuhnRSH7VdlUfUiPiK
         nxOKwbHynIkr3GwLln/3p17p0MHRbLTo/TnUISiR72Glep2Y0kLIL/gbt1y7A2D39UNS
         coWlQ1tCpfeH2kICyraDyzkxnhJINeqlUsbYYOW2PMYw9flkAwoixECfDgoEAgK2/EjU
         kiNhC63oXCfH4H0CcOeW0VDRFtpBGQiRpX1EN4Jx/t4kqKc8WdmXGUn5EnUPyo6LPi+H
         uwzeOehbf8N1jHw2TK5zXByJckUfy6ffm69E5P6iL22FnoGri6aIcHOLv4PJXUwL8cvG
         dOog==
X-Gm-Message-State: AFqh2koPNTvkHiE+IUSYVJStMKRqegQurQmv4/fyrF0uLf7npFcgcNTf
        DC3BMgqMeeqE/5ruaDwCiHM2bX78EJ6mXiBPhj9DXw==
X-Google-Smtp-Source: AMrXdXsrRJ6QKv7W46pkETfhObL49mmGA3ruRRJ86rQyjtq7LV+/ScXpcAt+DhyxsQszfdgCS2KldXRGT90fJxkN+XQ=
X-Received: by 2002:a17:903:2cf:b0:192:9d79:d3db with SMTP id
 s15-20020a17090302cf00b001929d79d3dbmr883684plk.129.1673871447663; Mon, 16
 Jan 2023 04:17:27 -0800 (PST)
MIME-Version: 1.0
References: <8bb3d7c3a36985e030ba40e853c57578de8fb303.1673866725.git.lukas@wunner.de>
In-Reply-To: <8bb3d7c3a36985e030ba40e853c57578de8fb303.1673866725.git.lukas@wunner.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Jan 2023 13:16:51 +0100
Message-ID: <CAPDyKFozQ3x7dv4i77k7S=K_6gAMJ7T_2WbUurGObhhZ2RiZhA@mail.gmail.com>
Subject: Re: [PATCH] mmc: pwrseq_sd8787: Allow being built-in irrespective of dependencies
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-mmc@vger.kernel.org,
        Matt Ranostay <matt@ranostay.consulting>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 16 Jan 2023 at 12:15, Lukas Wunner <lukas@wunner.de> wrote:
>
> pwrseq_sd8787 is forced to be built as a module if its dependencies are.
>
> That's unnecessary, it's perfectly fine for it to be built-in even
> though the wireless drivers that need it are modules.
>
> Relax the depends definition in Kconfig accordingly.
>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Matt Ranostay <matt@ranostay.consulting>
> Cc: Lubomir Rintel <lkundrak@v3.sk>
> Cc: Claudiu Beznea <claudiu.beznea@microchip.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
> index 6f25c34e4fec..e9e9d31b39b4 100644
> --- a/drivers/mmc/core/Kconfig
> +++ b/drivers/mmc/core/Kconfig
> @@ -15,7 +15,7 @@ config PWRSEQ_EMMC
>
>  config PWRSEQ_SD8787
>         tristate "HW reset support for SD8787 BT + Wifi module"
> -       depends on OF && (MWIFIEX || BT_MRVL_SDIO || LIBERTAS_SDIO || WILC1000_SDIO)
> +       depends on OF && (MWIFIEX != n || BT_MRVL_SDIO != n || LIBERTAS_SDIO != n || WILC1000_SDIO != n)
>         help
>           This selects hardware reset support for the SD8787 BT + Wifi
>           module. By default this option is set to n.
> --
> 2.39.0
>
