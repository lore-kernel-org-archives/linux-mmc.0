Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E8DC433DB
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jan 2021 14:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 747A021D7F
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jan 2021 14:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389426AbhASOsl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Jan 2021 09:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387746AbhASNYk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jan 2021 08:24:40 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13884C061574
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jan 2021 05:23:54 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id d3so4150511uap.4
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jan 2021 05:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ILw/qF7TdwrNklRAXcaeusociLizcCnnQ8u/QLIywg4=;
        b=FjML5doNoJ4DXnisvfUP6oGcL6UAd9gJmPklavYNzbOvo34D/b3MCwN05tXLr3txiP
         1DeCL1/EyWrUU52yj6qJpN9ukP0rHothhu4Ef47wUFdQO6J2wNQQVm5zGf9fyaqbB6oh
         EVhxzlo7iPvxSOX6OV3BU26yD/HkruslcyFCyT504jUKzaIcdSYJ0UyVVW89Wwz9W63t
         jbaqRCEZztz/iXYh/KvhkmNWa/OcUDPjN9VSGtDEZutij8X4tLeGdAve0Ycv3k7D7os8
         HXeJbU90+JD1EAETpLYDyA3YLr9PsrOehnJ+U3Rpno9hrdEruPRxY9NUXf0oeUdh1EVj
         Tacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ILw/qF7TdwrNklRAXcaeusociLizcCnnQ8u/QLIywg4=;
        b=bVgzaJpokfGvwm4i0k/BUUs6cSCPpbAwsG6Cxf3M4kEe9OZaNstpxg+jRBZLXYX0cF
         HYjgb+PP00YiL/0NGkWi8qmza7KYDRdXTE161bYzenjOCpnxZLfakIEJreCJut0imx36
         VYaG3LRBpnEDeGloivC17/yWGYcylx1RGAj18kj24pG70jAK+VcMBtn5+szJsv6Zh7wP
         fJ0ilHHjexwjXobYsIULz6BtdsotKcC3plRa70Nq3QMgF5pBcVGya/BSiF7f3fy1kWG6
         lCTw1QTOQ5PRnsT3PeCtoLPo2oNye4H83W+397e+PDLFowa2DRU88yZ8v/s+OYk2LAf4
         Kd7A==
X-Gm-Message-State: AOAM533xSOF25+IS8vvMfuUxPyQR9/HV+Hu4Y+3qOiJ67+zY3Itep0CY
        vj+sOtUVV4Vg73QojygFB2WaeCzzK4G+wn5jNCXmsQ==
X-Google-Smtp-Source: ABdhPJx5Lv2FXPGPnZs7Sl4lSF8XEJWk4UFMIcwq5sOFzftyYVlxhOL5xtGfGG+rw0aT/4OB6QOznxNjpYWkeH8WxtA=
X-Received: by 2002:a9f:2271:: with SMTP id 104mr2176025uad.15.1611062633277;
 Tue, 19 Jan 2021 05:23:53 -0800 (PST)
MIME-Version: 1.0
References: <20210112141754.76539-1-fengnanchang@gmail.com>
In-Reply-To: <20210112141754.76539-1-fengnanchang@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Jan 2021 14:23:17 +0100
Message-ID: <CAPDyKFpxGCu9JMxvkrdLz8YmzUk89PnRaNiWpoBGRA0uAcEGJw@mail.gmail.com>
Subject: Re: [PATCH] mmc: limit the number of retries when analyse tuples failed
To:     Fengnan Chang <fengnanchang@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 12 Jan 2021 at 15:18, Fengnan Chang <fengnanchang@gmail.com> wrote:
>
> when analyse tuples failed, may enter an endless loop=EF=BC=8Cso limit th=
e number of retries.
>
> Signed-off-by: Fengnan Chang <fengnanchang@gmail.com>
> ---
>  drivers/mmc/core/sdio_cis.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
> index dcb3dee59fa5..a3f0c3cc0c2c 100644
> --- a/drivers/mmc/core/sdio_cis.c
> +++ b/drivers/mmc/core/sdio_cis.c
> @@ -266,6 +266,7 @@ static int sdio_read_cis(struct mmc_card *card, struc=
t sdio_func *func)
>
>         do {
>                 unsigned char tpl_code, tpl_link;
> +               int  tries =3D 100;
>

From a general point of view I agree, we should set a limit to avoid
looping forever. Although, I am wondering why exactly is 100 a good
value for retries?

Did you encounter this problem and tried to limit the loop to 100 to
fix the problem - or is the fix done based on pure code analysis?

An option to limit the loop with retries is to bail out when a timer
elapses. Perhaps that is better suited for this case or what do you
think?

>                 ret =3D mmc_io_rw_direct(card, 0, 0, ptr++, 0, &tpl_code)=
;
>                 if (ret)
> @@ -318,6 +319,9 @@ static int sdio_read_cis(struct mmc_card *card, struc=
t sdio_func *func)
>                         prev =3D &this->next;
>
>                         if (ret =3D=3D -ENOENT) {
> +                               tries--;
> +                               if (!tries)
> +                                       break;
>                                 /* warn about unknown tuples */
>                                 pr_warn_ratelimited("%s: queuing unknown"
>                                        " CIS tuple 0x%02x (%u bytes)\n",
> --
> 2.25.1
>

Kind regards
Uffe
