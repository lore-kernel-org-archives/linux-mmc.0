Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71231C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Feb 2022 12:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbiB1MFE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Feb 2022 07:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiB1MFD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Feb 2022 07:05:03 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE2C13E98
        for <linux-mmc@vger.kernel.org>; Mon, 28 Feb 2022 04:04:25 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id t13so8942558lfd.9
        for <linux-mmc@vger.kernel.org>; Mon, 28 Feb 2022 04:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8WnObInMC2ofWUsTKYtPij+k1Wh0DXe/u1zG3p1IPf4=;
        b=JqfBkaGJmDTS5BLvufjhP/LEar/dzjQ6i7GPUZzQbUUApCYFA5AQYeQ/dfEM6n3HG6
         CaZx9w0fjnDcQCHoNddRQS/A54mr7vTrErGBM5tIFsv7T/+VRPuNDLeW23vIDovdwSP7
         1YlExP3x/CuK+MMWXD+8VX40ycwwMQg9kW/7AfxgyIM/5HUHjOIhV6o04w+Sz1TY6zGJ
         yK5nlmPf9dv+VtE25IFeAdYzaQl0yQmQdb0DFN6YWjq3GJl8OCOtYnx1B1DzLqs0Htc5
         BO28nMs1x1Ceqic4zFgJpRukkI19rYnBqN13EUOvPUo4O19aDegrb8WhpA5zTdnQRqGM
         OE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8WnObInMC2ofWUsTKYtPij+k1Wh0DXe/u1zG3p1IPf4=;
        b=IZ9k8ya0r6bDmoStsJ+O4mO2wXJO7Dh9VBqLpPaO1UGKoIjEK1PB+r0TFZGA5E68uU
         z7t4GtvdqgFAYG0eFOQpSYZP1wINcdUVoNEGwdWYtCOYhmtXvxeEIktLnUwjVKCA6vqj
         KwakwaWSyJpNBIczRzVp/Vh1D6C1UHKXMLKxxNVvqC60YbRmiyJHudhKUm475Dik9Sss
         HvFU2o34ixuWV82ZKL2sq4uLTHoAOCUQ2gb2YNIwORMM8A0iUoHng05RyDa6ViU+Cx3O
         nE+gSQFR/yanhpqCtxndzh8XDsRiRXv5MDxBBeZtLeqxqJ1+Oa/6JHfQNxJwvtCYlwqu
         4lfw==
X-Gm-Message-State: AOAM5305rC1FtHJitug305OkG6ZIy3eF7AmqXKTLqF1T5jOtYBCsMTzk
        yO86Cc9vliwqjfSXGHR0eN3zkX4/P/gO54tx7PvXn4U3Pie0Zw==
X-Google-Smtp-Source: ABdhPJxpZi2fIFjY4KRz6vVxIdDcBSJGElXWDH3T1Fddx90I97shcxEvbgmXGqeayZecnO4XROSRNKyZGUYTNmYasOI=
X-Received: by 2002:ac2:5de4:0:b0:443:5b80:d4c4 with SMTP id
 z4-20020ac25de4000000b004435b80d4c4mr12437782lfq.373.1646049863342; Mon, 28
 Feb 2022 04:04:23 -0800 (PST)
MIME-Version: 1.0
References: <1644395927-4138-1-git-send-email-wangqing@vivo.com>
 <CAPDyKFqg5N1tCqQ2u2jt5qU0qLuDJRSJRtq_aMVDc7XNDbRvkw@mail.gmail.com> <bcd6688f-6f42-ca8f-ab9c-978eeff4f4e3@wanadoo.fr>
In-Reply-To: <bcd6688f-6f42-ca8f-ab9c-978eeff4f4e3@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Feb 2022 13:03:47 +0100
Message-ID: <CAPDyKFo-4hkTo8F9q4+BmxUH_Y4nk_K0N20q53xrdJLAFRutcQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mtk-sd: use div64_u64() instead of do_div()
To:     Qing Wang <wangqing@vivo.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 17 Feb 2022 at 21:00, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 17/02/2022 =C3=A0 16:39, Ulf Hansson a =C3=A9crit :
> > On Wed, 9 Feb 2022 at 09:39, Qing Wang <wangqing@vivo.com> wrote:
> >>
> >> From: Wang Qing <wangqing@vivo.com>
> >>
> >> do_div() does a 64-by-32 division.
> >> When the divisor is u64, do_div() truncates it to 32 bits, this means =
it
> >> can test non-zero and be truncated to zero for division.
> >>
> >> fix do_div.cocci warning:
> >> do_div() does a 64-by-32 division, please consider using div64_u64 ins=
tead.
> >>
> >> Signed-off-by: Wang Qing <wangqing@vivo.com>
> >
> > Applied for next, thanks!
>
>
> This is wrong.
>
> See [1].

Thanks for reporting this, I am dropping the patch from my next branch!

See more comments below.

>
>
> Wang Qing, you should really warn all the people you have sent such patch=
es.
>
> CJ
>
> [1]:
> https://lore.kernel.org/linux-kernel/19b96972-cee7-937f-21ce-c78982ed2048=
@linaro.org/
>
>
> >
> > Kind regards
> > Uffe
> >
> >
> >> ---
> >>   drivers/mmc/host/mtk-sd.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> >> index 65037e1..777c9a8
> >> --- a/drivers/mmc/host/mtk-sd.c
> >> +++ b/drivers/mmc/host/mtk-sd.c
> >> @@ -766,7 +766,7 @@ static u64 msdc_timeout_cal(struct msdc_host *host=
, u64 ns, u64 clks)
> >>                  clk_ns  =3D 1000000000ULL;
> >>                  do_div(clk_ns, mmc->actual_clock);
> >>                  timeout =3D ns + clk_ns - 1;
> >> -               do_div(timeout, clk_ns);
> >> +               div64_u64(timeout, clk_ns);

I guess a proper patch would be to convert clk_ns into an u32 instead!?

> >>                  timeout +=3D clks;
> >>                  /* in 1048576 sclk cycle unit */
> >>                  timeout =3D DIV_ROUND_UP(timeout, BIT(20));
> >> --

Kind regards
Uffe
