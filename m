Return-Path: <SRS0=4qKy=EL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0CCC00A89
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Nov 2020 12:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 421A4206D4
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Nov 2020 12:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vcWgMVlh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbgKEM7h (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 07:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730754AbgKEM7g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 07:59:36 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776F8C0613D2
        for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2020 04:59:36 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id y78so702830vsy.6
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2020 04:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FJbxzbaK6alRkN3KAA7qm2brnHJLmJglDmQHC6FtNQo=;
        b=vcWgMVlhE34b/olsri9mfPB13ZaXcEYETJs1qQQzR07ZkuON1LaZ8aEEwlOXIFB5Y9
         qfcBeVJf+T1jW0qDs4GSwkdn6E7WLcKR4MwBHiWuuDOhJWVdUlMbKHj7boMMmXDHPVME
         t3PboL0B4NcAyAEKxGtZiqFVVdx75LIL8OswUPL8B0HINCN2mnT2d9k3prthz+NYVk3N
         rq4GxVuDVOvw0QisftrD1fBTqIp1jfi8pftfyKXAwnRuG4EKUWAny+ecMjcPv2wMM0Uu
         dDF4mxpq8ujzOEAp90ltQfgqvXKPPD6SmZAfWemTq1vjemDcHQzwqnhuX563ySNiMWFW
         kWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FJbxzbaK6alRkN3KAA7qm2brnHJLmJglDmQHC6FtNQo=;
        b=Rkj3KeTvJF2bab5F0ThJjISi0/L0xLiAoxZTtDzB0NppuCWvaFkb7koAFCjCgx24bI
         uZulCDSUpiy7yYE9AqIV0sknTcgqDMQeNM1LGilONU69qDb9leoeE7/Nk9/Uk9wffyr9
         WZ6/X1s0trYpC6x9xkCJqTUYK6cDri8ixyZHtL9nsV84AlhwYsSsnT8HDD3LX+wpVEVF
         mFbARotI5Q/ORNMG6OuQ8uDPa+N+mCcudEUD3IsUX3ohrdk5LkVji/iwpnzEttlq10NA
         Rd+PWRsby0hWXEjx2zUo5eCl3VsNUAhGPCirVCMqAbqVO6vq7xhtnXYhDsOvMnpw5DtZ
         mq+g==
X-Gm-Message-State: AOAM530NYxJK7MOYJk4rR2o85dC9KmE+WickAA8L7hGLf8HuRjK/UBDu
        BDqlX8bZpLdtDI/jT7Z0TFZGV/vuZgHnttOb3S1yRg==
X-Google-Smtp-Source: ABdhPJzuaWYUBOkIwMRMHkD3BonAxkMWZ4mYIpHjfRENMAj704ilgvW/QZXAPp2KzESWhBRBWn2emfLqZwnsvGHyORk=
X-Received: by 2002:a67:f24e:: with SMTP id y14mr957295vsm.55.1604581175676;
 Thu, 05 Nov 2020 04:59:35 -0800 (PST)
MIME-Version: 1.0
References: <20201031134818.2135446-1-trix@redhat.com>
In-Reply-To: <20201031134818.2135446-1-trix@redhat.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Nov 2020 13:58:58 +0100
Message-ID: <CAPDyKFrC1Cy4gH9FOo90T7eCf8Gw1jgPGtDazGqF-q5SFW2dZA@mail.gmail.com>
Subject: Re: [PATCH] memstick: mspro_block: remove unneeded semicolon
To:     trix@redhat.com
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 31 Oct 2020 at 14:48, <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> A semicolon is not needed after a switch statement.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/mspro_block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
> index cd6b8d4f2335..afb892e7ffc6 100644
> --- a/drivers/memstick/core/mspro_block.c
> +++ b/drivers/memstick/core/mspro_block.c
> @@ -276,7 +276,7 @@ static const char *mspro_block_attr_name(unsigned char tag)
>                 return "attr_devinfo";
>         default:
>                 return NULL;
> -       };
> +       }
>  }
>
>  typedef ssize_t (*sysfs_show_t)(struct device *dev,
> --
> 2.18.1
>
