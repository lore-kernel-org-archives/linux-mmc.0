Return-Path: <SRS0=RjyY=7H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F5DC433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 08:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90351207FB
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 08:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h2w1oTn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388352AbgEYIsm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 May 2020 04:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388342AbgEYIsl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 May 2020 04:48:41 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4F7C05BD43
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2020 01:48:41 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id u79so9549339vsu.4
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2020 01:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GeODa0YbiTjbooy9JHHC15ZmQa3mj5lyrBd83ZZUO4Y=;
        b=h2w1oTn2afNYUAiEwaZkklboJKWXBctne83Cc9a9u+fdFQSeX+39nRiBV1k+paJgkg
         OGpSXepJMqTiWYil+kmALPik7Qhs2kcryCnAHY/5u7nC8u8U2bG98H0wLoVZyWjOWQoR
         ii6CgGNDtNG2SpInmFkEUL0ZpHiGrElshtenbPJA0izbisyK7lizeg7jwP3NgC5qP75U
         vac7nz/vxymHuFoQtN+I5Yn9MDUCPClEn079BXVx83LomJXi5G8RlyF6ZjLtgIDq+MkP
         aoQIykw/OQvXg9pgx6DJ0AjdYUyDyDUu/841HkIxdohjtDZj7+jgX2qxfybe5Hc1/aaL
         RHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GeODa0YbiTjbooy9JHHC15ZmQa3mj5lyrBd83ZZUO4Y=;
        b=UyLBISG0HOXVaGEP4i9RY9zkP1MLwYsC/mWD8qSdOr0t15DZgdWdm0m9M2CyABXR7h
         t/OX7OkqhiDM3bmHsZ+94frwjsmVC2oBJK0g8SuFjgp3NCuErf3TChXWtnSFhZ7cCX3f
         sV5lnjZgQJ3gvJncK9owxK7XLBGx3HxWEMno0sDLJvgMzSeru2s03Wj4TjxWNAvEVc20
         Zz4oFd0NJIJ5pxFp0nIanAxPBPncE77EiJ6n70781wQgnf58C7u4YY8jW24m9/k9ZwM6
         hpHDEgGieIb/tfVYVrGy18P6XJ9BCGOn+zJrMm2RomQ668m2E06b0Y8Sag+kOByzqdd2
         tWCw==
X-Gm-Message-State: AOAM532XWhbQYChtiBDHZf8YQAgUf2lJhjlDmi83U1GZREhnL8UHVxxf
        h88KbmXhwMejEIZKVi1PuIENs9dluY5043vrqvWU35WEs1M=
X-Google-Smtp-Source: ABdhPJwCcH4pYSZrf2SKmkEOCli6MSxdBz6f7xVXY4gZ5TdGNjJ0pX2ecAHPY0hqztpn3/kyrwxrYrPLPmlnUmgnX6Y=
X-Received: by 2002:a67:2441:: with SMTP id k62mr3914343vsk.165.1590396520572;
 Mon, 25 May 2020 01:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <HKAPR02MB429107D62F3E9F86E76AD550E0B40@HKAPR02MB4291.apcprd02.prod.outlook.com>
In-Reply-To: <HKAPR02MB429107D62F3E9F86E76AD550E0B40@HKAPR02MB4291.apcprd02.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 May 2020 10:48:04 +0200
Message-ID: <CAPDyKFqDveZ0+eh3QeXGr6gvek5YTr1chvinZN1twPT5uu7=4w@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: fix use-after-free issue
To:     =?UTF-8?B?5b2t5rWpKFJpY2hhcmQp?= <richard.peng@oppo.com>
Cc:     "Markus.Elfring@web.de" <Markus.Elfring@web.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 22 May 2020 at 11:29, =E5=BD=AD=E6=B5=A9(Richard) <richard.peng@opp=
o.com> wrote:
>
>  The data structure member =E2=80=9Crpmb->md=E2=80=9D was passed to a cal=
l of
>  the function =E2=80=9Cmmc_blk_put=E2=80=9D after a call of the function =
=E2=80=9Cput_device=E2=80=9D.
>  Reorder these function calls to keep the data accesses consistent.
>
> Fixes: 1c87f7357849 ("mmc: block: Fix bug when removing RPMB chardev ")
> Signed-off-by: Peng Hao <richard.peng@oppo.com>

I downloaded the patch from patchwork, but it seems like it got
mangled somehow. Perhaps you can try to download it from patchwork and
run checkpatch on it to see if it works for you? Otherwise the problem
may be at my side.

In any case, I manually fixed it up this time. So, applied for fixes
and by adding a stable tag, thanks!

Kind regards
Uffe



> ---
>  drivers/mmc/core/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 8499b56..e6e025c 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2483,8 +2483,8 @@ static int mmc_rpmb_chrdev_release(struct inode *in=
ode, struct file *filp)
>  struct mmc_rpmb_data *rpmb =3D container_of(inode->i_cdev,
>    struct mmc_rpmb_data, chrdev);
>
> -put_device(&rpmb->dev);
>  mmc_blk_put(rpmb->md);
> +put_device(&rpmb->dev);
>
>  return 0;
>  }
> --
> 2.7.4
> ________________________________
> OPPO
>
> =E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=
=E4=BB=B6=E5=90=AB=E6=9C=89OPPO=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=
=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E9=82=AE=E4=BB=B6=
=E6=8C=87=E6=98=8E=E7=9A=84=E6=94=B6=E4=BB=B6=E4=BA=BA=E4=BD=BF=E7=94=A8=EF=
=BC=88=E5=8C=85=E5=90=AB=E4=B8=AA=E4=BA=BA=E5=8F=8A=E7=BE=A4=E7=BB=84=EF=BC=
=89=E3=80=82=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E4=BA=BA=E5=9C=A8=E6=9C=AA=
=E7=BB=8F=E6=8E=88=E6=9D=83=E7=9A=84=E6=83=85=E5=86=B5=E4=B8=8B=E4=BB=A5=E4=
=BB=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=E3=80=82=E5=A6=82=E6=9E=
=9C=E6=82=A8=E9=94=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=
=E8=AF=B7=E7=AB=8B=E5=8D=B3=E4=BB=A5=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E9=
=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=
=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E3=80=82
>
> This e-mail and its attachments contain confidential information from OPP=
O, which is intended only for the person or entity whose address is listed =
above. Any use of the information contained herein in any way (including, b=
ut not limited to, total or partial disclosure, reproduction, or disseminat=
ion) by persons other than the intended recipient(s) is prohibited. If you =
receive this e-mail in error, please notify the sender by phone or email im=
mediately and delete it!
