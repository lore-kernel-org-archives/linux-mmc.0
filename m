Return-Path: <SRS0=N8Xy=7R=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43FDC433E0
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Jun 2020 21:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0BD6206E6
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Jun 2020 21:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C6Vm6wpq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgFDVi2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Jun 2020 17:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgFDVi2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Jun 2020 17:38:28 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6BDC08C5C0
        for <linux-mmc@vger.kernel.org>; Thu,  4 Jun 2020 14:38:27 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id 1so4409209vsl.9
        for <linux-mmc@vger.kernel.org>; Thu, 04 Jun 2020 14:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JRp2wYqbXrMgYp/QENHpDRubY4qw9bzxCheGtbXjIjc=;
        b=C6Vm6wpq8tO5BXMIfpCa7ToFiJzsgMfpS1YUp1RfsSInHqAsQ5544mizqTL9TsT8Fi
         yIU/DyY8lg/igaKj8G7tWkJUWQXoeUDQBEDeW1Bnmyb34ShM7GP+DTySRJozInJ7WvT+
         Whr6r8fu1eb77Q1Tmdro2AjHSXhA49BauIQWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JRp2wYqbXrMgYp/QENHpDRubY4qw9bzxCheGtbXjIjc=;
        b=ow8df9ck9aQ9+9pxoDz2VpxlENmiB0BwFFS73XYP07Do18pc/Y6CEme+qSke1Grs0h
         TleB5umEwieyJ+xSVgTp/YlPGZ9oFRtfrRDEMXaCO99ZR3774hDuLA/iSoEd4ubVZ5hq
         VKs523JpV83fk8AfHMQ94VW3pusBkwtMlQOxTA0KParjH/6QWVWjIRJDuLf67TCs9Ih9
         0MOujxop06RFwqMjB4SHyJqhKceLMMSmveP5nQetcqHPeE5nHYsf7K43lfVp9raInbpr
         zN6ioL4QDunGUMZOy76KFTSA7w4dmGSv4cT0/wdcaOLBiti7UffzqDU2u+rRW96hVpPo
         nZcQ==
X-Gm-Message-State: AOAM533mZHMyq/fDSF7YUen+cFFip2QzE+s+LsPPIjOtihj2avnxto/n
        H0R9f0WSRY0WQS37keb+nZvuKEqJf2E=
X-Google-Smtp-Source: ABdhPJx9lsUG6QTrhH1stulAU4xlyZ9udDpB5aGmDtDJBV4ScmR0B6RClHj16qmsSVgHN2EmbleTrA==
X-Received: by 2002:a67:f9d7:: with SMTP id c23mr4550952vsq.91.1591306706540;
        Thu, 04 Jun 2020 14:38:26 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id v141sm916017vkd.9.2020.06.04.14.38.25
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 14:38:25 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id d21so4060386vsh.12
        for <linux-mmc@vger.kernel.org>; Thu, 04 Jun 2020 14:38:25 -0700 (PDT)
X-Received: by 2002:a67:e445:: with SMTP id n5mr4808001vsm.73.1591306705318;
 Thu, 04 Jun 2020 14:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200604100102.13572-1-zbestahu@gmail.com>
In-Reply-To: <20200604100102.13572-1-zbestahu@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 4 Jun 2020 14:38:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XOmAmvGqQScTNDzG3mT3pbTqz=zdxARdOJU3P3EB7R7Q@mail.gmail.com>
Message-ID: <CAD=FV=XOmAmvGqQScTNDzG3mT3pbTqz=zdxARdOJU3P3EB7R7Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdio: Return ret if sdio_disable_func() fails
To:     Yue Hu <zbestahu@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>, huyue2@yulong.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Thu, Jun 4, 2020 at 3:01 AM Yue Hu <zbestahu@gmail.com> wrote:
>
> From: Yue Hu <huyue2@yulong.com>
>
> We should return any possible error returned by mmc_io_rw_direct()
> rather than only -EIO in sdio_disable_func() failure path.
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  drivers/mmc/core/sdio_io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Seems sane to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
