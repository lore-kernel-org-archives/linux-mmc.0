Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E57C4332F
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Nov 2022 09:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241141AbiKRJqn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Nov 2022 04:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241075AbiKRJqH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2022 04:46:07 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514638FF85
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2022 01:45:51 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id t17so3363971pjo.3
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2022 01:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I/T+U5xig92E26QLpbaS0JSSh1bc8Rb/sitkqdj++UY=;
        b=JOeqFuFFwdPXlKF/IsyzIs6DdoUpWL3QnvPerUT6qUDQ/k92uJaCqhtD7Fc4bCtows
         OUEyFCX8NnigPC8tbvLj/2c8yugL1LZI9S7sRjhAES6ktj9Lk9CWDSs5AZBocVognEY+
         wwcM3I30ICZkffrQxtaDaLwXwM7FqxNWfPfEjj2jnOlRfS9sTjB8bjzpj6+BSn7w27R7
         g1a83DUiuh+EJOzdOJdPWVrZi5VVI8qd3UtQSd1SUl2dRpkR/QvRGZIjRlRxeFwwqLsh
         1iMjDPSV3J1mUtX8WCeag/bmAQGTd3ykiH18Tr2MXUOS03LwI5rWlg+DHp7kcFn6SuO3
         Hs+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/T+U5xig92E26QLpbaS0JSSh1bc8Rb/sitkqdj++UY=;
        b=4JBwavow7yxNbMZzlgrKXaXXjC4lf8XqPa1UeOJxohbPd5ozZ1z0LMVDaC6cT8NxPh
         8XVpKO4W1RGRaXIOHAsuPHn/SL7MUdUha144S6Uy0iz8qTJDGkeDyQY47Hj7LshxaIFc
         B0acuHAqCk9xzetFbvwfnW9XqhxZViM91pzKgf04Z7WITLkUbZtH7PZn/lnUE8wv0RhT
         y6Uau+rNUuBgPTP/V4RYw/biTuK/fKnFxI4XODG0mJMHx2XTg4MIRL6W/YbxtFaQBtjq
         cjh3akghCqYVDK7EqqAJy4q1N+eD4Tet2sK98RLt0zX1tLxcZYCtOxyHveVKFalU7s8P
         kJlQ==
X-Gm-Message-State: ANoB5pmPMNzK6DSXECPR7uG0JOpthjwyAuqT0rMrJQFF54YHWHH+FuM3
        vDydHuQ4Eq8ateuWcC5IlOlO9kIJIpMulnvsBY0bBg==
X-Google-Smtp-Source: AA0mqf6Zz+/3z6sAV/yHE3t91vfJQXsNWGj/WE9TxWgU8z2rLno2nn1d/ELMhcsSCI9WAtkmIncf/hcMFTim2OZEAPY=
X-Received: by 2002:a17:90b:1d45:b0:218:6db5:fd98 with SMTP id
 ok5-20020a17090b1d4500b002186db5fd98mr7768758pjb.164.1668764750852; Fri, 18
 Nov 2022 01:45:50 -0800 (PST)
MIME-Version: 1.0
References: <20221111122314.307-1-charl.liu@bayhubtech.com>
In-Reply-To: <20221111122314.307-1-charl.liu@bayhubtech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Nov 2022 10:45:13 +0100
Message-ID: <CAPDyKFo-p+dv9jiLhJB8YuKAq5jN5K=x3Pj2thiZ3jhr49hykA@mail.gmail.com>
Subject: Re: [PATCH V3 1/1] mmc: sdhci: Fix the SD tuning issue that the
 SDHCI_TRANSFER_MODE is cleared incorrectly
To:     Charl Liu <charl.liu@bayhubtech.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, shaper.liu@bayhubtech.com,
        chevron.li@bayhubtech.com, thomas.hu@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 11 Nov 2022 at 13:23, Charl Liu <charl.liu@bayhubtech.com> wrote:
>
> When cmd->opcode == MMC_SEND_TUNING_BLOCK, the SDHCI_TRANSFER_MODE
> should also be kept
>
> Signed-off-by: Charl Liu <charl.liu@bayhubtech.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> change in V1:
> Keeping the SDHCI_TRANSFER_MODE when cmd->opcode == MMC_END_TUNING_BLOCK
>
> change in V2:
> add the mmc_op_tuning interface to judge if the opcode is tuning CMD
>
> change in V3:
> cancel the redundant code
> ---
>  drivers/mmc/host/sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index fef03de85b99..98ee688de50d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1465,7 +1465,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>                 if (host->quirks2 &
>                         SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD) {
>                         /* must not clear SDHCI_TRANSFER_MODE when tuning */
> -                       if (cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
> +                       if (!mmc_op_tuning(cmd->opcode))
>                                 sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
>                 } else {
>                 /* clear Auto CMD settings for no data CMDs */
> --
> 2.32.0
>
