Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AECDC04FE0
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Aug 2023 15:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjHGPv7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Aug 2023 11:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjHGPv6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Aug 2023 11:51:58 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E973171E
        for <linux-mmc@vger.kernel.org>; Mon,  7 Aug 2023 08:51:54 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-c2cf4e61bc6so5108690276.3
        for <linux-mmc@vger.kernel.org>; Mon, 07 Aug 2023 08:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691423513; x=1692028313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fywVO3lf7mQtJxXDySZPqv0vkHYL4Ucsl/1T7KbfFw0=;
        b=YEEAhG6FfOCvgKllcbCs6rN8SsxbA/TeCFqwQuVfthmEHVcho1S5Pd5mSLN+6tXv5V
         1FJlibgt3ADfPmZsQ5F8EpJybfTs8SQaAHpx4OAk8BfAb4JV0Bkn/fTO+GHumm/tTR7W
         YPNp85lAGLnuf/oE8KpRs0Sxgf+mPuNz1owr4PFuZZ7RvuZIryqy93ywQmJ1R8SrP8JK
         KhMObsY9SqtnDdSXZnWtNkoBH8/fuyJhr6FVJvtCkKzAunqOppCVJUP31bWfONFqdYBG
         AD0pR3U5e2hdDEBAmsCprvLAR6M4d8otzYVbdQJikpG+uvMZVlu/SZPg1OEvKUeM7vMT
         n8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691423513; x=1692028313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fywVO3lf7mQtJxXDySZPqv0vkHYL4Ucsl/1T7KbfFw0=;
        b=dMhxY0C11mbMOzK1YJtXU3aD5AE2XHao1NDuAZTdoF8fE25veOBKhZpXNWwh9gdMvW
         BpDuOtLnQkM9/b+fMHmBRp10R4QoNd4NbK0EUygteb55NhJ0xthX8+/dpFADxlwnV3LM
         CMfJANd2qvUFwPrmokMfYHXJJhWHHWYbDdooS+HPHz01oQv0PV1n5BmGoobGElUUQCCq
         MM9Xrllm7Z0DHgbka58VgpGLiu6NehYue81Qr/wOQGDFBiNIEQHBY220e81WBpPfsAdf
         Jb3PTkfw0JOwpsbpBQPxXu/nmN0AurTVwP3tmgo8gHFqfwSS9WjRJkoI2WX326EncguP
         lOpQ==
X-Gm-Message-State: AOJu0YyMh1eHwiiTKjwS5S9SdsUp6iUbRX/rYQYqmL+sHrRZgOn7f+T8
        U3lPgsa5XCaS99sHeppF1qfk9votlyLuAfmjZyt11w==
X-Google-Smtp-Source: AGHT+IHotlZf+gkYBU+hlFS/BaBSmIccrU6QFT+2vGHAtsc9eE269pZH6xcQbzUh4Xs2WZxxw1GaJxKs/vfyVAadD7k=
X-Received: by 2002:a25:d1d2:0:b0:d3c:932b:806f with SMTP id
 i201-20020a25d1d2000000b00d3c932b806fmr9771257ybg.43.1691423513649; Mon, 07
 Aug 2023 08:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230725-mmc-removable-v1-1-b2e0c4f18e6d@weissschuh.net>
In-Reply-To: <20230725-mmc-removable-v1-1-b2e0c4f18e6d@weissschuh.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Aug 2023 17:51:17 +0200
Message-ID: <CAPDyKFrWXQHWaEX5=rq-Gf5-by90iqtxWCuUu_QquRaMfhHtVw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: propagate removable attribute to driver core
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 25 Jul 2023 at 16:17, Thomas Wei=C3=9Fschuh <linux@weissschuh.net> =
wrote:
>
> Userspace can use this to distinguish hotpluggable mmc devices such as
> sdcards from non-hotpluggable ones such as eMMC.
> One example is the lsblk tool from util-linux.
>
> Note that dev_set_removable() is not related to GENHD_FL_REMOVABLE which
> is not applicable as per the comment in drivers/mmc/core/block.c
>
> Link: https://github.com/util-linux/util-linux/issues/2379
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/bus.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 2c3074a605fc..0af96548e7da 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -310,6 +310,9 @@ int mmc_add_card(struct mmc_card *card)
>
>
>         dev_set_name(&card->dev, "%s:%04x", mmc_hostname(card->host), car=
d->rca);
> +       dev_set_removable(&card->dev,
> +                         mmc_card_is_removable(card->host) ?
> +                         DEVICE_REMOVABLE : DEVICE_FIXED);
>
>         switch (card->type) {
>         case MMC_TYPE_MMC:
>
> ---
> base-commit: 0b5547c51827e053cc754db47d3ec3e6c2c451d2
> change-id: 20230725-mmc-removable-5cfdca9ed062
>
> Best regards,
> --
> Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>
