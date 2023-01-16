Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1494C63797
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Jan 2023 12:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjAPMRG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Jan 2023 07:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjAPMRF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2023 07:17:05 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B477C1CF60
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 04:17:04 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id 20so2839543plo.3
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 04:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WiDjPImFP/3NhlWJraNf85+Pcm+wTN124g/r+QcZ5QA=;
        b=m5ctym40YljO2q9b/kEqp8bBP56026lZc8mcVQzHmSAH5BCUvTgHAx1MmVLiieHNCY
         /PvOIgJlb3MnK7ic/jCOW3pzDByBJ6QSWi+NL0OchA2uqsugnst7O/rhqhyOy1orpkKY
         1vjowTMawfVwMB9hbFymPKaVNWnPCRJhdEU64IunqfyT0UoViTvBM7A/f2yHX78Kvywk
         BBHfxMBB/qpkHu1u8HefAX8UQK2d62HmrVlPUL6bTxsKI3dX0bXyTiyOgo1FSzlvgIZs
         JMrvt4185slG4raykDVdr6Bm8WpCye1nknE2R6Lf2H+ubGka4hQMU72blN3WTUcH2BFG
         MjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WiDjPImFP/3NhlWJraNf85+Pcm+wTN124g/r+QcZ5QA=;
        b=Wj7ZmalIyN7V1ov3JBa4Kdhe9uiijXelW496uzih4/VA+01j+iua6ARxxNIG0E+r/M
         MkFBJWjZh18j3qlZninWvK3U8cpOFaSjMhoraAHU4Xfww/Cb1yCHL8RRsgtf6eZ0nSk0
         qPziDrPnA9VALN7qpaUwoZpdrs6ZrEheEMt2BsgyCzpExWomCnod8OkzAFt3CoRt3OyO
         ek1hmo9s5gEs8Vdhj58q6Lav25ZIYr4EKalEPSFi4Q41R4CqnFfmuubhx06rPkQAHb6w
         VgzkqiQCS9z+CNbl0qYFpRsK4YYzi+JXYUEJpPvRfrEWWyJNxKyPth8y9fdY2T9bDGQm
         zM3g==
X-Gm-Message-State: AFqh2kp6uWHjm4LkUEhhm0nvqJ/iln5/NFyK6AVHHUUvoz9TQHSrs9Gu
        FnM6e0eiHOdORGbfFW4zZFhfeQgowji2GNtzh2nJsQQMxj7lBQ==
X-Google-Smtp-Source: AMrXdXv+v7rh2S4hgSP52Ss1lcKL8Es8wj8wKgX4qenrftmbItiz/1omsR0u0yN0zU8hS0mlxhlA/XBcLDCiXFas5X4=
X-Received: by 2002:a17:903:2cf:b0:192:9d79:d3db with SMTP id
 s15-20020a17090302cf00b001929d79d3dbmr883572plk.129.1673871424232; Mon, 16
 Jan 2023 04:17:04 -0800 (PST)
MIME-Version: 1.0
References: <a650c8b930a30f5902f4fcfe23877314d098abde.1672763862.git.geert+renesas@glider.be>
In-Reply-To: <a650c8b930a30f5902f4fcfe23877314d098abde.1672763862.git.geert+renesas@glider.be>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Jan 2023 13:16:28 +0100
Message-ID: <CAPDyKFpVfgv_31tMF3JMzK9qXO1OiN5LRxxym=ajGVefygoVYw@mail.gmail.com>
Subject: Re: [PATCH trivial] mmc: sdio: Spelling s/compement/complement/
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 3 Jan 2023 at 17:38, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>
> Fix a misspelling of "complement".
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/sdio_io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
> index 79dbf90216b599c7..b774bf51981d05a4 100644
> --- a/drivers/mmc/core/sdio_io.c
> +++ b/drivers/mmc/core/sdio_io.c
> @@ -766,7 +766,7 @@ EXPORT_SYMBOL_GPL(sdio_retune_crc_disable);
>   *     sdio_retune_crc_enable - re-enable retuning on CRC errors
>   *     @func: SDIO function attached to host
>   *
> - *     This is the compement to sdio_retune_crc_disable().
> + *     This is the complement to sdio_retune_crc_disable().
>   */
>  void sdio_retune_crc_enable(struct sdio_func *func)
>  {
> --
> 2.25.1
>
