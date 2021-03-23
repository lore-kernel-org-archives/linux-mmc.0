Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E658C433E3
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Mar 2021 14:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF633619C5
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Mar 2021 14:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhCWOR5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Mar 2021 10:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbhCWORX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Mar 2021 10:17:23 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C260C061764
        for <linux-mmc@vger.kernel.org>; Tue, 23 Mar 2021 07:17:21 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 15so25890466ljj.0
        for <linux-mmc@vger.kernel.org>; Tue, 23 Mar 2021 07:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bdl+x23wbkMq1ajHWMfZREaO/rjXDa07bOSsisAzV7U=;
        b=GmG9jrViJfUJdGLL9uJU6PEDNGypYU9hT51k9kPwLinUVKm2vzUBA4RcMGKVq9QMOm
         UmzJLKAjExxWK/BjAroZtj/LM4lC/goDPyTbp7fa6awFDF1qSVmtLQpwlgf2WYxC/zCU
         qexq911Y/Z3m6oBqEzBWck436lArhgzjgNE03L+J8xdLUkv9VfuEcxmzp6jTjgnjS5Gq
         ahJIK+oE0C57MPWtwTK8IZ20SVYSd9Y6Kue9yeyvpOlC+GO+1YB29aSB/6PE9h/kllzA
         miHmIOh1bd5WZS3114+ovFPSpt5cE8/rvD/JLixLpl4jlGR1QoKJAJoAT/g/xkSOXWi8
         iaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bdl+x23wbkMq1ajHWMfZREaO/rjXDa07bOSsisAzV7U=;
        b=RwR5XNdkcvVSxthlzIeHkpB7/IeNsXktC+E9NJ17kx5TSHoGqD+A+S4c+SlbFrMKR8
         MydoC/DtD/oWw6AYhjQ6aKcFvahVy1vlIv0gfiX44D1gNjRUNx41v2d363vpTgQtObr7
         dB/XfhX4e8cBsblWIUKMR9NX0hXuB5XDu6IubOehZpMtVZXsfyRAsuezDxIUyv9xPczw
         XxeA4JpJqbf8X6eW6+n7itFUZFHPxnd2RsyPPRMquL3k40NN5OJkNN5F39KvgTlRmktg
         o4wG1vDdrj48XrRbvhMmHkCOkK+idZW5YB5S0n3g5piqmOT4lSCv1E6QEP9LaqYRv53H
         LkGw==
X-Gm-Message-State: AOAM533DOKM3dmmqnIovO0/MGG/hTGst1stG19P4SMIrKivG67oAbSLO
        ip0i3gEEMuf1WBDNFxOrk9dtFgQWo2vBxUblGTlYvw==
X-Google-Smtp-Source: ABdhPJwRR/dBiBhqoEmX9sdQj/8typtDFnx7SQcJbyzxkiH65gMHVbrkvd2E/OpdXj3KESVU3xnEDMnivBle4GWzpnA=
X-Received: by 2002:a2e:988a:: with SMTP id b10mr3334032ljj.341.1616509040051;
 Tue, 23 Mar 2021 07:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <MN2PR08MB63973BF8F3C6959487BF5707B86A9@MN2PR08MB6397.namprd08.prod.outlook.com>
 <DM6PR04MB657581DC8163F06128E561BAFC6A9@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB657581DC8163F06128E561BAFC6A9@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Mar 2021 15:16:43 +0100
Message-ID: <CAPDyKFq0z-c5ffFY3xMb0GZd=xkSAvZgh3agVNxuV3J1LV05pg@mail.gmail.com>
Subject: Re: [PATCH RESEND V4] mmc-utils: let FFU mode use CMD23 and CMD25
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>,
        Chris Ball <chris@printf.net>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 17 Mar 2021 at 12:27, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> >
> > As per specification, the host can use either CMD24 or CMD25 in
> > closed-ended or open-ended way.
> > CMD25 is better option as it can flash the firmware image in one go.
> >
> > Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> > Reviewed-by: Avri Altman <avri.altman@wdc.com>
> > Reviewed-by: Bean Huo <beanhuo@micron.com>
> > Tested-by: Bean Huo <beanhuo@micron.com>
>
> Ulf hi,
> This patch looks good to me.
> Will you consider picking it up?

Yes, certainly. Although, please allow me a few more days, to get the
time to look at the mmc utils patches.

>
> Thanks,
> Avri

Kind regards
Uffe
