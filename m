Return-Path: <SRS0=+sp8=A4=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE32EC433E2
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Jul 2020 13:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6B4D2070E
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Jul 2020 13:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgGQNJq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:09:46 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:34471 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgGQNJq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jul 2020 09:09:46 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N9L64-1ksdTn3NFE-015KpQ; Fri, 17 Jul 2020 15:09:44 +0200
Received: by mail-qk1-f180.google.com with SMTP id k18so8646519qke.4;
        Fri, 17 Jul 2020 06:09:43 -0700 (PDT)
X-Gm-Message-State: AOAM533tKii7/GaHJG0kOFfsZT3GGFLHGuw+uD6YhyCdeh5AdICzd280
        KeVFlzFShr/DT/qxSZQmcN/oCFbxcsFFiXYEbEA=
X-Google-Smtp-Source: ABdhPJyMn8BMOQetMHxeZULv+RBoPE70laJ0tRwka+aAxlKtKitAI/Tvkp5yakr56ftuXBiqMpwqJcJDKRo8uCRWbEc=
X-Received: by 2002:a37:b484:: with SMTP id d126mr8777330qkf.394.1594991382483;
 Fri, 17 Jul 2020 06:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200619125801.9530-1-faiz_abbas@ti.com> <20200619125801.9530-8-faiz_abbas@ti.com>
 <3ed03440-7fbd-6abc-8a15-67e7217e2c3d@ti.com> <2e50333c-5387-236f-3fb2-6d8014b224e0@ti.com>
 <CAK8P3a1JpCCCV-CVQj3+eMfWF+=4AuHPpv390Tyj2pKn63_ZVg@mail.gmail.com>
 <75cd485b-e3eb-19ee-ad1f-84cb04b0c807@ti.com> <933d7132-5d9f-89df-8dec-5d9f6d3e0eee@ti.com>
In-Reply-To: <933d7132-5d9f-89df-8dec-5d9f6d3e0eee@ti.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Jul 2020 15:09:26 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Uc1X9PY6OnxbgEyBVY1=sx1drW7JrGzcPv1KrXaK7aQ@mail.gmail.com>
Message-ID: <CAK8P3a3Uc1X9PY6OnxbgEyBVY1=sx1drW7JrGzcPv1KrXaK7aQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] arm64: defconfig: Enable AM654x SDHCI controller
To:     Tero Kristo <t-kristo@ti.com>
List-Id: <soc.lore.kernel.org>
Cc:     Faiz Abbas <faiz_abbas@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        ARM-SoC Maintainers <soc@kernel.org>,
        Nishanth Menon <nm@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:HxeDZWRPYSNnOleicueUNPsXJGN0jBATXMNJHugDJH4mbxG/cEE
 FsG9U3xj9n+57beTL/9M1nqP6rA23OqSGtr7RuWX+VoPRcdaDYgS7Lzuyzj4AYRW0tMW9RS
 o0FrlTmcVnAf+44ZmZLXAatdvkLqRFgY7QDQem87lT5zb6xcfATWT2XwZYTG/t8yfvbcX/B
 hjXkPSLGC8k6UsXDxqKCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W6iJD+SFmhQ=:RZ4oPMGibGX12/tp4tvEbC
 ajaHDTbrZTHaWRlnS/mtH/z3Jjqp/85/++VoqIFdiZmkJFeOhjF7J0eWSf5cbPg7rw6bd5oav
 YiHdpazogsIiGCg447DjAmk19ydAnEHDqnugX7TC/mzpQ1P9BBe1abH02aPV9lWxL6MgWqXdO
 uguCKYCXjefJZHYXqEraM+uJPlNkrjN/iL+6QDb8Tq3q+1XUAUfcSSSmx0zGhxYyqkAAefflD
 aIoNAgXf/oGTiQZsUAtONhMMv7UhkOCEjJj81UjlwlVC97TTifzvFBwPtZD37QlMyS4asPUus
 tyPUvU/g8lRb7wlUpfqkoWytUXDTh8R28BmH+CcNP1moQWyD23ixcDeWlkTPrHqf8ceetD9FD
 hDrykIKKX/yvvsPJDZJJaqi3fzgfSKioO3ExViOtf6789ze9TWXLZ9H3qGAN1OV+6QUqDGz+l
 5h4Np0DCT+1xYzxIxljDSAh4FXXM3kK5pVlwHVWjxY+PejQkYfB0ZR65PZTqMq9t1tOoxRn5m
 /6ssjoC2EAa8U0TRXcs1wRGoUmgQMeo6tnGYnMSS2RYebr9FzhXgDHyxknUS66nepgFcPw/SC
 RPyCMVcPAlzbsVkrl+W3qpRihWBQwK8IFbw1wliVe3oPhRPkH7L7uNtu0/A9GWiTkxqvBIW5s
 aVYH7pLo12yDfcwYy/ThknLFmGJUt4eQpxKbkopGo+p4+49L+4+kPlYxW4XNXs9Rt1L70Ogm4
 TEDOHOOceriAYf4UxyaXQi32BnlOdb/+9mBC22LIgcxjX7Qw25pXkUnEy+Iyp/B0LS4XCmcZh
 QP5rnCK9YxT20QwMH5hoQ4mdqCNBtOW4fWKVkXwWrRBLX8hxCMXyxycN4ydUsUVNBN77F7A1m
 4iPdgCE+7VL0YtCuuT5JEqfCf+3b3BJeOdv+gBaXYC6bZVEhg7rqis8pqkAOorr0hvk+tGuD8
 hXRDFvGAk41Hi3ijP+CffxVngEnDWenk17UDIWWxcSOYw2r10vI49
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Jul 17, 2020 at 1:20 PM Tero Kristo <t-kristo@ti.com> wrote:
> On 17/07/2020 11:38, Faiz Abbas wrote:
> > On 16/07/20 11:58 pm, Arnd Bergmann wrote:
> >> On Thu, Jul 16, 2020 at 3:25 PM Sekhar Nori <nsekhar@ti.com> wrote:
> >> I tend to ignore individual patches to the defconfig file unless
> >> they are sent to:soc@kernel.org. The best way to get them
> >> included is to have the platform maintainers pick up the
> >> changes and send them that way as a separate pull request
> >> at the same time as sending any DT updates.
> >>
> >> The MAINTAINERS file lists Tero and Nishanth as maintainers
> >> for the platform. If they want, I can apply this one directly, but in
> >> the future, send it to them.
> >>
> >
> > Thanks for clarifying Arnd. Tero, can you pick this up?
>
> Ok, this topic has been bit unclear for me also, but if you say I can
> pick the patches myself and send a pull request out, I can do that.

Right. To clarify, the soc tree usually has separate branches for dts
files, soc specific drivers, defconfig files and 32-bit platform code.

When you pick up patches into your tree, please put them into
branches that fit into those categories. You can group the patches
into branches with more fine-grained categories if it makes sense
(e.g. adding a particularly large driver, adding a new dts files for a
new soc, or cosmetic cleanups across dts files).

If any of the categories only have a couple of patches in them, you
can decide to forward those as patches to soc@kernel.org, but a
pull request is always ok as well, even for a one-line patch.

        Arnd

       Arnd
