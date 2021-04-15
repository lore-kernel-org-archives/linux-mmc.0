Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6F4C433B4
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 12:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21DB461139
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 12:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhDOMDb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 15 Apr 2021 08:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhDOMDa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Apr 2021 08:03:30 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6803AC061756
        for <linux-mmc@vger.kernel.org>; Thu, 15 Apr 2021 05:03:07 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id o2so3290494vkn.1
        for <linux-mmc@vger.kernel.org>; Thu, 15 Apr 2021 05:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3QIBHoMu5EbRCWYG2M6emH3zmg/eaWsR3cuaHJ11glI=;
        b=dCq0K9/n/8M3yF4cCAveE3AoMzabLitZqdBYH8zNnSq6DC+oQNf/94IpSchjfwNDO8
         +TgGhKuYLKQa13hgyOXoNdvK+QhiJIrY2Zcj/+NPHSp53nvLwJUdJhKimCFzoZWW/t3B
         SG9rm31+d8AsTFrq7l4Vm6zCTBfIosV4/z0x35vT7qHU5dHJus6S2xTGOJxpWBhDDB9G
         ILR6H+W12/pQX1if/0zUZve7ibqCQ6JG149oFGqQkIA5k+Wy2KFwQimHF6qA3ZyADtDY
         Wrls8HjwC1XTNFoLIpYNPBBHQ3hevtDYd678PXyh808MaPKbPpuhAdvrnne85j2m7Sjf
         ypVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3QIBHoMu5EbRCWYG2M6emH3zmg/eaWsR3cuaHJ11glI=;
        b=m9sJrDQYfWpKBgV+suhV3qyQFF7/119vQNGaY5COhy+wyhulDlVW7FjBXfHAPXKDaH
         OKfAM07XQcpbfEyBBEAQmn28cF2z/OEP54vk6qQ//RCaZkpTtKyfttMyIHw+P/GAxqPU
         kluUqsy9+IHkoK1XNJ1QraWCj7rMxcGEGiz70kXfMK2QzC8AaNkDUoJH16gUGDU4TDhw
         q8Gz7BCTiPBC3tT9FghPf3Ba4djArN+sM8+G6kzLLwDabmS8j/nlM502iYdyB5ANwhEL
         NlC1wRZ3laEyiqGhYH7qgsaZSgKORFZrOFdXwQh+D+2tSEdh/AAMXF6+OhSaSUhIEZJ+
         H6Tg==
X-Gm-Message-State: AOAM5327I01qiaqUNbmGI7/9jLfoHAbU2GpXi+RByJPH4hxKGsBabaoC
        LxJ2H1Ag62cyPFbB35Lzl/Xi4oFQN4xFqQBO5BNqVw==
X-Google-Smtp-Source: ABdhPJyyNe77t41hhK2Coubzx2cqNjbIKfBKN8GPSKlWdgisgvTh30oPYop2+OGDM1PqxdlkQwlJ3uQ66XA4eW6cLr4=
X-Received: by 2002:a1f:8d14:: with SMTP id p20mr1432935vkd.6.1618488186344;
 Thu, 15 Apr 2021 05:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <1618366903-94346-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1618366903-94346-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 15 Apr 2021 14:02:29 +0200
Message-ID: <CAPDyKFr_Rnds6=W-TpOMhVcO9aP9OLapqCy1rFp8EHriWuQbuw@mail.gmail.com>
Subject: Re: [PATCH] memstick: r592: remove unused variable
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 14 Apr 2021 at 04:21, Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following clang warning:
>
> drivers/memstick/host/r592.c:363:6: warning: variable =E2=80=98len=E2=80=
=99 set but not
> used [-Wunused-but-set-variable].
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/host/r592.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
> index d2ef463..026fada 100644
> --- a/drivers/memstick/host/r592.c
> +++ b/drivers/memstick/host/r592.c
> @@ -360,12 +360,11 @@ static void r592_write_fifo_pio(struct r592_device =
*dev,
>  static void r592_flush_fifo_write(struct r592_device *dev)
>  {
>         u8 buffer[4] =3D { 0 };
> -       int len;
>
>         if (kfifo_is_empty(&dev->pio_fifo))
>                 return;
>
> -       len =3D kfifo_out(&dev->pio_fifo, buffer, 4);
> +       kfifo_out(&dev->pio_fifo, buffer, 4);
>         r592_write_reg_raw_be(dev, R592_FIFO_PIO, *(u32 *)buffer);
>  }
>
> --
> 1.8.3.1
>
