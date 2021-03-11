Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B045EC433DB
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 11:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C85A64FC9
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 11:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbhCKLt7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 11 Mar 2021 06:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbhCKLth (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Mar 2021 06:49:37 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A072CC061574
        for <linux-mmc@vger.kernel.org>; Thu, 11 Mar 2021 03:49:36 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id j15so410975vkc.1
        for <linux-mmc@vger.kernel.org>; Thu, 11 Mar 2021 03:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8J99SnIHN40QUiCh4vdDv5XtXr5pbmjm/XVHbBVvsdo=;
        b=h8ZLqeB7M7wbPWxGDpPzKfQIuZJOHhG5As4FbvW0Yf0l9V0uLDCrQXDxPM1kZkevHe
         gKH2xuExf1aX5ktCcJFGF1FYQcI2oVicL4gNYiWPyhrbXk0+aMaAm1YgpsGLPArfP2Hq
         pRolEovwCCiNMCFeoq6NfmiLG9FG8oV3VwsA/AIExOxEOsRCzGdPLsWOQSzVESgbyDXa
         ma2C1jPVLKyk3mri8cXR+J3Uo/LdfN5/cyNgYTQy3tSdO/psFgUvNL3immA3AS81ZQY6
         xuAtBD74h0YpLmU2c/rjrg2K0hkzBLhZXIYsJusVcYd3kjTEmz7m+62wyvRv8F2NSeT/
         qCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8J99SnIHN40QUiCh4vdDv5XtXr5pbmjm/XVHbBVvsdo=;
        b=efEakBSc53CXZgOYJ/yYjfl1EbQd6ublN9agTz92X7fO5SWe2MBaNEkP/r5QU9EIV+
         EtSVo3VZKvPiejLH2vQAk/mKhc3S0dIJSEnzjUckNmDUegHsHni3sbAhP2BIyxzMcU4s
         Ey+ugsHT4lwyHWDDlhg3iULHFJU6MYE5SdzEDkHlyKT21qdj6kSrKy11hlwccCaVxP/A
         YuvESy3TMUq/3ODO/sckECY3PY/qdr4VIwQMINpbGfxhaGCIrMP8EjSKn/ueduhlYQJj
         yz/GCIlo94rbqNV86rdppf/3aw2aIglaiHtg4QMoqxd9A4sOISqqsqceGdK2z3mILlOZ
         05jw==
X-Gm-Message-State: AOAM532GkH+R+7zoYG+VAB3CB5Xj9yer6hxHfkhTyREEolckMTwFw6iB
        3DbYrhVOpawAsETr79k47Ok6A6Ta9XMqvBQJdpopWA==
X-Google-Smtp-Source: ABdhPJx6dRR9fk/pnTw3aBPdfGpJrX8AMeRQ74wps29lBE0pAN6F0BFTtUFED9CQBE4m/6bTv6K1fofytFjXA13eo9k=
X-Received: by 2002:a1f:2e88:: with SMTP id u130mr4253740vku.15.1615463375690;
 Thu, 11 Mar 2021 03:49:35 -0800 (PST)
MIME-Version: 1.0
References: <20210311174157.561dada9@xhacker.debian>
In-Reply-To: <20210311174157.561dada9@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 Mar 2021 12:48:59 +0100
Message-ID: <CAPDyKFqYzJX1eP6VxSXWDPAAKj7NYu1+8YwTmtH1nFbzm+MRag@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdio: fix a typo in the comment of SDIO_SD_REV_3_00
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 11 Mar 2021 at 10:42, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>
> I believe "Spev" is typo, should be "Spec".
>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  include/linux/mmc/sdio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/mmc/sdio.h b/include/linux/mmc/sdio.h
> index e28769991e82..2a05d1ac4f0e 100644
> --- a/include/linux/mmc/sdio.h
> +++ b/include/linux/mmc/sdio.h
> @@ -82,7 +82,7 @@
>  #define  SDIO_SD_REV_1_01      0       /* SD Physical Spec Version 1.01 */
>  #define  SDIO_SD_REV_1_10      1       /* SD Physical Spec Version 1.10 */
>  #define  SDIO_SD_REV_2_00      2       /* SD Physical Spec Version 2.00 */
> -#define  SDIO_SD_REV_3_00      3       /* SD Physical Spev Version 3.00 */
> +#define  SDIO_SD_REV_3_00      3       /* SD Physical Spec Version 3.00 */
>
>  #define SDIO_CCCR_IOEx         0x02
>  #define SDIO_CCCR_IORx         0x03
> --
> 2.30.2
>
