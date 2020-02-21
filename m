Return-Path: <SRS0=+wZv=4J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB1AC11D25
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Feb 2020 01:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41DD2071E
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Feb 2020 01:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KeLcOadt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgBUBZ6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 20 Feb 2020 20:25:58 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43269 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729476AbgBUBZ5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Feb 2020 20:25:57 -0500
Received: by mail-pf1-f195.google.com with SMTP id s1so321718pfh.10
        for <linux-mmc@vger.kernel.org>; Thu, 20 Feb 2020 17:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=J27tQOPYceXfH5oaFJMMhJDT732qIsb34aA7vP0bweA=;
        b=KeLcOadtXcfeKufQnhfHWukRpP0rcjyigVh9n2QuBfFREEOJgQ9cERYSzBVO1H24bf
         GslQJhgovU12DwmWhdY1905yRIetjAfxvF7MTGnZ2UE9m8YX3B2TXbn2ONVNoNQ+/ySK
         CkCd9IBBjpBTwn/oXa+CPLoM/O9/n5cl7IGqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=J27tQOPYceXfH5oaFJMMhJDT732qIsb34aA7vP0bweA=;
        b=qlpf25VqUKHuonNpwEYBfT7+Cn2Ydvi5h0+ulZ0lHJ4AdBUm5yt6nAD8UeG1EkstwJ
         MVFtzpdVHLX9rP7pjv7/nkvXsf9aslcUs0eq7y0phHQwHZ7OQa8OjKfInVVK0gThIE8S
         NFUzM8LF3zwVQckMfOB8Bf3mj18U59lEjCD/gO0feyp7F0MHiz441G1rLHFw0HKC9hpS
         5IZs3N5L/6pwMT2v2Poiv4XQQ07U/2KdUeTdA0ecN6JA/Q9cwyP1iwMBzCJFTiFVx04h
         jld+iPL1P5RzJ2k0NirA3YkXltobuZffxdz4mHRO/xEPSqa5vPAl5FK99IK07kVq52Er
         dR2g==
X-Gm-Message-State: APjAAAVn6aqHOh3+jbCUBa7C8ZLdUV8HuiIUHsMSI17vUMBja1+gWxBI
        OnEf8L+mrCJKg7tTq05L2T9HoQ==
X-Google-Smtp-Source: APXvYqwnp1RJPUUY+xeDLnhF608PQs6KEBc6Qiwmq2RWYeRfku/XGkGrTRPkQ7mJPGNM+td+uYP8jA==
X-Received: by 2002:a63:ed16:: with SMTP id d22mr8697865pgi.314.1582248356653;
        Thu, 20 Feb 2020 17:25:56 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j17sm818392pfa.16.2020.02.20.17.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 17:25:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1582105474-27866-1-git-send-email-vbadigan@codeaurora.org>
References: <1581413771-18005-1-git-send-email-vbadigan@codeaurora.org> <1582105474-27866-1-git-send-email-vbadigan@codeaurora.org>
Subject: Re: [PATCH V2] mmc: mmc_test: Pass different sg lists for non-blocking requests
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     asutoshd@codeaurora.org, stummala@codeaurora.org,
        sayalil@codeaurora.org, cang@codeaurora.org,
        rampraka@codeaurora.org, dianders@google.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        robh+dt@kernel.org, ulf.hansson@linaro.org
Date:   Thu, 20 Feb 2020 17:25:55 -0800
Message-ID: <158224835519.184098.16667027079485274979@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Quoting Veerabhadrarao Badiganti (2020-02-19 01:44:31)
> Supply a separate sg list for each of the request in non-blocking
> IO test cases where two requests will be issued at same time.
>=20
> Otherwise, sg memory may get unmapped when a request is done while
> same memory is being accessed by controller from the other request,
> and it leads to iommu errors with below call stack:
>=20
>         __arm_lpae_unmap+0x2e0/0x478
>         arm_lpae_unmap+0x54/0x70
>         arm_smmu_unmap+0x64/0xa4
>         __iommu_unmap+0xb8/0x1f0
>         iommu_unmap_fast+0x38/0x48
>         __iommu_dma_unmap+0x88/0x108
>         iommu_dma_unmap_sg+0x90/0xa4
>         sdhci_post_req+0x5c/0x78
>         mmc_test_start_areq+0x10c/0x120 [mmc_test]
>         mmc_test_area_io_seq+0x150/0x264 [mmc_test]
>         mmc_test_rw_multiple+0x174/0x1c0 [mmc_test]
>         mmc_test_rw_multiple_sg_len+0x44/0x6c [mmc_test]
>         mmc_test_profile_sglen_wr_nonblock_perf+0x6c/0x94 [mmc_test]
>         mtf_test_write+0x238/0x3cc [mmc_test]
>=20
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
>=20
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

> Changes since V1:
>         - Freeing-up sg_areq memory.
>         - Added check to ensure sg length is equal for both the sg-lists
>           supplied in case of non-blocking requests.
> ---
>  drivers/mmc/core/mmc_test.c | 42 ++++++++++++++++++++++++++++++++++++---=
---
>  1 file changed, 36 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> index 492dd45..f8f884a 100644
> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -1411,6 +1417,22 @@ static int mmc_test_area_map(struct mmc_test_card =
*test, unsigned long sz,
>                 err =3D mmc_test_map_sg(t->mem, sz, t->sg, 1, t->max_segs,
>                                       t->max_seg_sz, &t->sg_len, min_sg_l=
en);
>         }
> +
> +       if (err || !nonblock)
> +               goto err;
> +
> +       if (max_scatter) {
> +               err =3D mmc_test_map_sg_max_scatter(t->mem, sz, t->sg_are=
q,
> +                                                 t->max_segs, t->max_seg=
_sz,
> +                                                 &sg_len);
> +       } else {
> +               err =3D mmc_test_map_sg(t->mem, sz, t->sg_areq, 1, t->max=
_segs,

'repeat' is always set to 1. Why not remove that argument and update the
code? As a follow up patch.

> +                                     t->max_seg_sz, &sg_len, min_sg_len);
> +       }
> +       if (!err && sg_len !=3D t->sg_len)
> +               err =3D -EINVAL;
> +
> +err:
>         if (err)
>                 pr_info("%s: Failed to map sg list\n",
>                        mmc_hostname(test->card->host));
> @@ -1458,15 +1480,16 @@ static int mmc_test_area_io_seq(struct mmc_test_c=
ard *test, unsigned long sz,
>                         sz =3D max_tfr;
>         }
> =20
> -       ret =3D mmc_test_area_map(test, sz, max_scatter, min_sg_len);
> +       ret =3D mmc_test_area_map(test, sz, max_scatter, min_sg_len, nonb=
lock);
>         if (ret)
>                 return ret;
> =20
>         if (timed)
>                 ktime_get_ts64(&ts1);
>         if (nonblock)
> -               ret =3D mmc_test_nonblock_transfer(test, t->sg, t->sg_len,
> -                                dev_addr, t->blocks, 512, write, count);
> +               ret =3D mmc_test_nonblock_transfer(test, t->sg, t->sg_are=
q,
> +                                t->sg_len, dev_addr, t->blocks, 512, wri=
te,
> +                                count);

This is only called one time so it may be simpler to pass 't' instead of
pick it apart and pass it as many arguments. Not a problem in this
patch, besides that we're now passing even more arguments here making
this harder to read. Also, the blksz could be hardcoded in the function
instead of passing it as 512.

>         else
>                 for (i =3D 0; i < count && ret =3D=3D 0; i++) {
>                         ret =3D mmc_test_area_transfer(test, dev_addr, wr=
ite);
> @@ -1584,6 +1608,12 @@ static int mmc_test_area_init(struct mmc_test_card=
 *test, int erase, int fill)
>                 goto out_free;
>         }
> =20
> +       t->sg_areq =3D kmalloc_array(t->max_segs, sizeof(*t->sg), GFP_KER=
NEL);

It's more idiomatic to use sizeof(*t->sq_areq) here.

> +       if (!t->sg_areq) {
> +               ret =3D -ENOMEM;
> +               goto out_free;
> +       }
> +
>         t->dev_addr =3D mmc_test_capacity(test->card) / 2;
>         t->dev_addr -=3D t->dev_addr % (t->max_sz >> 9);
>
