Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F9AEB64D7
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Jun 2023 11:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjFTLL3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Jun 2023 07:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjFTLLQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2023 07:11:16 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08354199E
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 04:11:02 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-bdd069e96b5so4448109276.2
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 04:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687259461; x=1689851461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uTL9Euyng6z1pku0LKEe2QHGHr9MYbB6eqz71pTaUo=;
        b=oyprWDQfidfgGB1TO8blK5X+lxrnG05L+hrtfPty+F02NFSoi5tZuaDVysinoqnxXc
         rfpZ3ys8UNlCNCqMzn6eErGjrF5yNlx9o7Whgmh/i7Oiac9FYrT1NVSk+LALO9A7O1lV
         0piyel07/SdPtfv43PqobZTfWvwfFsjUaRIE8TnS3p5zQ97ft8fn8ZsblGKb17YmieOm
         GYsuwbRDq9Iof5RlDiNvzmHSRcoMKRf2UYhjNEmaD35nQqYwAeRHpaPbdrop/YqNiGJG
         R9gVTOWdnxaF09HF/am5Ic2UlIoInLE54R6JMsfgm+6kJzTfEtVowlX48S4aWH1B6FE9
         +bEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687259461; x=1689851461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3uTL9Euyng6z1pku0LKEe2QHGHr9MYbB6eqz71pTaUo=;
        b=H/KiaUkq8vBJr1dxKiAlNN95g4yyMvP4riFVIOEUJW0P61HMDcJWVbVsmDpoGFyT9R
         mulymCnI209slLY1FgbQk3aTCDSnZus1BVP+Y9dK/CaoCKovlu+LTcjkR3SQyPOdy5zD
         y/pBuzjb+x8orfciNnvVIdbWxtT+OOLxP/oAFJcGeF7OhWq9Ee4HuZlRhZCt20UIQu00
         JgVpjpR91gseLtgHWaws74MAyScD04FtI1WfV3avvyOQhUHJLlcuHxjGrYeLdCVgMA+k
         YpH2hB0sLw2y8n1+nPdbLNcPvmJDeb2RR66oCgyyXI/ZsWHemsE8VgMz6s1BHTMPCDFu
         5G4w==
X-Gm-Message-State: AC+VfDwaZF/+J8hhReLF/tZkN/4TkkAGtbhyrzMFPYnye6hOMoF+jWbU
        4vCIDrS1Y2SO0mZfqVQReWHMsP0xy2V4+BGI4sxr1g59GWRWy4Gc
X-Google-Smtp-Source: ACHHUZ4RtspCftydGbG4YMPRjEPCSehQ1yJefEn7Mp+QWzJPVLE02QuA81thepnjQ3GIl6XauJnjfrS/cy7lmM69uc8=
X-Received: by 2002:a05:6902:1546:b0:bfb:b6aa:3ebd with SMTP id
 r6-20020a056902154600b00bfbb6aa3ebdmr815134ybu.4.1687259461083; Tue, 20 Jun
 2023 04:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230620091113.33393-1-ulf.hansson@linaro.org>
 <a09b7efa-c74d-bc5a-44c0-5710c1aa078b@foss.st.com> <CACRpkdYJeE9s_A04jvMSAbHpvPC2cSLuW_e+dnc2hK40qML7+g@mail.gmail.com>
In-Reply-To: <CACRpkdYJeE9s_A04jvMSAbHpvPC2cSLuW_e+dnc2hK40qML7+g@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 20 Jun 2023 13:10:25 +0200
Message-ID: <CAPDyKFrfV+-YpR1+zCps6k=dkD61Ziz+6e0N7m9Sbr2s9x-H8g@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: Add support for SW busy-end timeouts
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Yann Gautier <yann.gautier@foss.st.com>, linux-mmc@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 20 Jun 2023 at 12:19, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
>
> On Tue, Jun 20, 2023 at 11:27=E2=80=AFAM Yann Gautier <yann.gautier@foss.=
st.com> wrote:
>
> > STM32 variants also have busy_detect =3D true.
> > Could that be an issue to initialize this work, which seem dedicated to
> > ux500?
>
> As Ulf says it is just initialized then it is left unused.
>
> I renamed the software timeout ux500_busy_timeout_work() from the
> previous name busy_timeout_work() but I actually thought it could
> make sense to enable it on STM32 as well. It is essentially a last
> resort fallback if the card does not properly report busy end or the bloc=
k
> fails to detect it for some reason.

There is HW busy-timeout for the STM32 variant, so I don't think it's neede=
d.

However, that HW timeout does have an upper limit. If the requested
timeout for the command is longer than what the HW can support, maybe
a software timeout can be used in some clever way. The tricky part is,
if I recall correctly from previous conversations at LKML, one can not
skip to set the HW timeout. This means, this is going to be a bit more
messy to support.

Br
Uffe
