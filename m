Return-Path: <SRS0=dyeO=7K=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D11C433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 28 May 2020 10:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45CB3208DB
	for <linux-mmc@archiver.kernel.org>; Thu, 28 May 2020 10:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TNl9YAq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387782AbgE1KPa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 May 2020 06:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387784AbgE1KP0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 May 2020 06:15:26 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E925C05BD1E
        for <linux-mmc@vger.kernel.org>; Thu, 28 May 2020 03:15:26 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id c1so226480vsc.11
        for <linux-mmc@vger.kernel.org>; Thu, 28 May 2020 03:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AzqkVBJAEezGbPEnQ6uyheJO4QQHaf1fZB6CgYZ5GhI=;
        b=TNl9YAq56NVOoL4WpJXdcweyHrJJZGLtV4nph0+3bV/dpqv5D/SjxK56d3U6e7qGqT
         xHzO6JegyIhHwvLwwcZCu3WaJPLS0lyHfPr2toQPJEmvUVw3QmvAVsQfnxLxm0Id8CZ8
         da+8BovUcJPMHdoK79SVAa82OHPlwOkqHdWctoTo+Db4/gxFZhBfbs7o0DDNh3jdkSfP
         YLtzY+4ucal9tH3M/IHuyng4oRKzYcLOSPe95P9uR6B8ShVwJwJuSUuNsup9TjqHzmuA
         Mp0CqkSXHY32HJY2qo5CS955oAgACWWwrS5pvimZn6ipnolyUFoHa0pNCR+NHHNrjweb
         LF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AzqkVBJAEezGbPEnQ6uyheJO4QQHaf1fZB6CgYZ5GhI=;
        b=cLsmk0ihXBgwLH0KP/IanJYXCOY/DYqRC9BU/mjb6K4ofw7n3r9Kv77Hvp3Hh0DRLb
         5kNdOH1H/JomvNQ3pn2x5LRjuaXkPYXEt2PimLeeyTylfldmKLcN4mnCzgEJVYey0DsW
         TUpv6OAxcpjZCQZTZ7cAYinFw/u/+Z0cPxYsH+UoB4DXGoj0derbHLTLU1a1YDIJ1FTB
         FZ6GTZgjCNEBWUR4D+6GjyeX+E1y3Q6G2pKl9rjP+S8Y9ioGo6PB7oPRbPaZoczvQREN
         gOSEMnxLQQgoT9v6gRBowIaFoQnGWHsPoqBK1kdhb9Oflr08rjZ5Jff5kR20UjlzVKEs
         7Eag==
X-Gm-Message-State: AOAM533TiZkPrF32+YqhP0UxjhuYctr1dS1NQoMYttAVNmYPzgqFVyCV
        M0s4ynRcveCDSF+EinZITNcLRszT95cN8KX1xHkbog==
X-Google-Smtp-Source: ABdhPJwknd/TqAO5JEEbX65YNKoBZH9XT7CwcVbXUlXdM+hW4Ksyx7qjx91yH/na5/7yPqt0RUdXIIJlNf0OgxgTToA=
X-Received: by 2002:a67:690e:: with SMTP id e14mr1366342vsc.34.1590660925499;
 Thu, 28 May 2020 03:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200527110858.17504-1-pali@kernel.org>
In-Reply-To: <20200527110858.17504-1-pali@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 May 2020 12:14:48 +0200
Message-ID: <CAPDyKFoA56NpRGyzWkc4N1288t=q8e7hqyCg_b-zDfeDEcwtAw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: core: Do not export MMC_NAME= and
 MODALIAS=mmc:block for SDIO cards
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 27 May 2020 at 13:09, Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> SDIO non-combo cards are not handled by mmc_block driver and do not have
> accessible CID register which is used for MMC_NAME=3D construction.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> Reviewed-by: Marek Beh=C3=BAn <marek.behun@nic.cz>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
> Changes in V2:
> * Use early returns pattern
> ---
>  drivers/mmc/core/bus.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 74de3f2dd..b1cb447da 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -93,6 +93,13 @@ mmc_bus_uevent(struct device *dev, struct kobj_uevent_=
env *env)
>                         return retval;
>         }
>
> +       /*
> +        * SDIO (non-combo) cards are not handled by mmc_block driver and=
 do not
> +        * have accessible CID register which used by mmc_card_name() fun=
ction.
> +        */
> +       if (card->type =3D=3D MMC_TYPE_SDIO)
> +               return 0;
> +
>         retval =3D add_uevent_var(env, "MMC_NAME=3D%s", mmc_card_name(car=
d));
>         if (retval)
>                 return retval;
> --
> 2.20.1
>
