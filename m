Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35361C7EE37
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Jun 2023 09:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbjFIJAe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 9 Jun 2023 05:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240499AbjFII7Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Jun 2023 04:59:24 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BA730E2
        for <linux-mmc@vger.kernel.org>; Fri,  9 Jun 2023 01:58:56 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f6c6020cfbso12224411cf.2
        for <linux-mmc@vger.kernel.org>; Fri, 09 Jun 2023 01:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686301135; x=1688893135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ae0EhWdWYuSdNnJ1IWTbNmO0VX4QhrHcm/Crk+TcHM=;
        b=aKNV+D3WITvOGHV4ccVfqyavaU1ZyOOI781ocaNxuUr/KGXR2SPlizx0YgjziNkL59
         2SJgaW1bBq9NV4hOyXufH2QcjgIX+tiX2goFHgTHLFOkYmwlrKiDV/Lw3rrv+/ekB3Kd
         FrL/wQBsafphXm113/3zDrWRWXocELMsfnkN96IJ2daPnSKTBZM4wqmVpfJticC/3hoH
         WE9MeVOx538kcp4YIgqJnwDkLhZXH0FILQUQkiQhuqAMnUWqnXwluqDpKWtyTGMMSy9Q
         3kmFmm8ovi9YNv23+xcay1m57Mi1R7SDZ1+YXdm8qQG9BjADze7BOLW8eqJ6orWrHx1n
         b3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686301135; x=1688893135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ae0EhWdWYuSdNnJ1IWTbNmO0VX4QhrHcm/Crk+TcHM=;
        b=YeLknhWCa7/ABuT9DLN9TvvrG6lwyGdvDKFQrabewTXTMBNRGJy9I5uR4rfBb+A8SG
         B7KZAFHDNAIzXl6+o/+7ttHgurr8aIwqc5ZahMWRVx3rPxK8B/IM/VVmHB79zhCBL5l3
         9AdiqfBLsOdG6zDF87Anh4h9Jlc91zvAh3GnIWHW+Iu/GTbNNOrg2TDBO+ZDIQCSWm+M
         pRk1ZSTGwYUZvTCjdJweIocfksdrmK27fqrA7BUFnQJmEWkTq7GDef3jp4gHdeOoRdqC
         TubZ0d83Gv1A54zmkZ+iDWnl9q6Yqpfq1yalhCicG5ku4aLCqYa2VHWFofeRESeabUrs
         t5Mw==
X-Gm-Message-State: AC+VfDxQOnv/MfkmrSx31f0R398/MFiihNMKUai1Tq6dOICoOBROPmWT
        hgKHNEwygCbJ1+n/R5H288g4zq2PKeHNtis7v+OGQw==
X-Google-Smtp-Source: ACHHUZ6CesUmn134+xMuZF1GTUPeVibyKCvXiVZEsmz1NtCn+EZ+JjXuyueV/0pNvswdUa/QY+xbuAq+uhp0y1cVr8w=
X-Received: by 2002:ac8:5b4a:0:b0:3f6:b347:6153 with SMTP id
 n10-20020ac85b4a000000b003f6b3476153mr1264420qtw.6.1686301135753; Fri, 09 Jun
 2023 01:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230329202148.71107-1-dennis@kernel.org> <ZCTOMVjW+pnZVGsQ@snowbird>
 <CAPDyKFrcdJuyA9B-JDReacT2z1ircDoY4oTXZQ8AVFk6UEFYsw@mail.gmail.com>
 <ZCclEE6Qw3on7/eO@snowbird> <CAPDyKFqc33gUYXpY==jbNrOiba2_xUYLs-bv0RTYYU5d8T0VBA@mail.gmail.com>
 <CAPDyKFos3i60U0g0vJstetvLMyouiTpUP8-Jop_LMB9T-ZNU=w@mail.gmail.com>
 <ZII-vJWGb7F97S_A@V92F7Y9K0C.corp.robot.car> <2023060930-uphold-collie-3ec5@gregkh>
 <ZILRw9MBGNwH9NsG@V92F7Y9K0C.lan> <2023060922-nimbly-emblaze-bd6b@gregkh>
In-Reply-To: <2023060922-nimbly-emblaze-bd6b@gregkh>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Jun 2023 10:58:44 +0200
Message-ID: <CACRpkdaGDONmRNASF1UEnKHDrcNYtdHWJFMmqzP998mhc0WfAQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: inline the first mmc_scan() on mmc_start_host()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dennis Zhou <dennis@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Jun 9, 2023 at 10:53=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
> On Fri, Jun 09, 2023 at 12:16:19AM -0700, Dennis Zhou wrote:

> > As a path forward I can add a command line flag as a bool to handle thi=
s
> > and that should hopefully take care of the regresion aspect to this.
>
> command line flags are horrible and should never be used.  Why can't you
> dynamically detect this type of thing and handle it that way?

If nothing else works, if this is device tree, a machine-specific quirk can=
 be
done:

if (of_machine_is_compatible("vendor,machine")) {...}

Yours,
Linus Walleij
