Return-Path: <SRS0=zOov=BA=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14933C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jul 2020 21:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8B712073A
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jul 2020 21:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbgGUV2v (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:28:51 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:57091 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730214AbgGUV2u (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jul 2020 17:28:50 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mc0Er-1kXaox3bKx-00dUij; Tue, 21 Jul 2020 23:28:49 +0200
Received: by mail-qt1-f174.google.com with SMTP id e12so286991qtr.9;
        Tue, 21 Jul 2020 14:28:48 -0700 (PDT)
X-Gm-Message-State: AOAM532p9c3ushlnXnWNzO3TZkd19rn8dGWVMilr+mXoAk7QatC3u3/i
        iPBp6vsQOzhi9+cLu0TOQTDoqiva4cStJT5bINM=
X-Google-Smtp-Source: ABdhPJyHziGF4HFhHNTWIdmNTeJezHXP51PejxqSdbTC7t3xHTxw8+J9ZAPV/mtYZnOeTdBLEx83edOMw3nAuOM7JGo=
X-Received: by 2002:ac8:6743:: with SMTP id n3mr7804927qtp.7.1595366927645;
 Tue, 21 Jul 2020 14:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200721212336.1159079-1-helgaas@kernel.org>
In-Reply-To: <20200721212336.1159079-1-helgaas@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 Jul 2020 23:28:31 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0aqus-7Z-qSc9J+gOsSCX5Ad570F-3a_HB1MHfJor7Bg@mail.gmail.com>
Message-ID: <CAK8P3a0aqus-7Z-qSc9J+gOsSCX5Ad570F-3a_HB1MHfJor7Bg@mail.gmail.com>
Subject: Re: [PATCH 0/5] minor rtsx cleanups
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ricky Wu <ricky_wu@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rui Feng <rui_feng@realsil.com.cn>, Klaus Doth <kdlnx@doth.eu>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:4apkgCuGVwjG1fSFYMnNcVMn9c3IUfp7i++rQEf43fS+6FmRjAS
 dtGTaktKo1OIWhPbCGs5C7mJwWR5HNQ7duGQ17fp8QKv5LRtMfCL5I5L0TIv3MGqGbn884s
 1Mtgltm+HQ3Phw4vOLlW9otq/PWFtfgPmhnkvoq2ML9/c/fIaXg5JBWJnSCcNWUTBke01Od
 lYLc+7+Iqt6XmBdJEi20w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lQeZ/MSEWbY=:VS08gaRT2ZIlKcK0IstbK3
 Ig5t417b4+pidSjhEJJFq4NucELDUcbiBEGFHHUyu8yp/tDK6SPMPKe1XGeqzU0Qb+rhqpy9f
 pvh4T7764pVTSZZkwTknXdrfQ/BQMAS4Y39OaSTWKRwj1PN36ZSwYwTJ+sHgYjpPemKlE0RJy
 L1R0bJb/Ykpt2nn7s1hjNetUUP3ivQzR9H/WWRL9qVkzJmsQBY5joLEbY633wDFymlJnUluqt
 02+/HDb/fBuURn8BdSfu7yxOmgY2u+WAwlqV0W3J7Bn+145HqWG6MA1r0pF2f+V5PuCEj69qQ
 60vNWJIRa/gXJMZiTFT5At6y39eZ6SbfxzhQK+7UxQM2P5aBBrGGhv/sYNaMor/pmW4wzlSPA
 1m7F3fKrSboyPqSHFwTFl3JBZHufIcFQyFJ9mYM8mFiX09wnoPZ4IPpguPj8MagyedOsTs2Yl
 ZwORXmqCvrU3ku/M3hp5UsrCoY6zcllRjyJjOBTnZhruidJYsQD00i0mVmdCQJHJNm2A+1vhV
 IFBvkpVIaFrWkZ61/Z6eoJHfjyzSLAkgh6iDGmdEl5LUiiYnphaGvZhaSpccwr3wnu7qgCAtr
 eJwvoSPMp5N9BCQ7Gzfhaux+4svoTQYTENJ9GYHzI/9AkVO4Aed/GJAenWpyR6BfmV1FcT9Vh
 +mA8kcgDstx4lmx3adkvR7ZhTusMDkQjefH9MsSnYe+GyD+euVRdNRcHIwdhYEJTaxHqfN4hL
 IcIB3sItee0avUyDAI5PdIPgRZlUITjeCShndduMyCaTqwHyopi1K4haDsU5vTa9U20sbZn+z
 utTHi9steOuEb0RjLI15xcXZyjxyLnTczuhWt2KTo2eH34izpciCVXUrgu8F8UOKpklO9FWG0
 ekLQFmUrEDEf7kJ3O1agRLUTxw+KywgF0z8odcwwEljskcXsgzkUXvsKtiNRsVepQcoZEBc/7
 /SQimvQ+8XAAXLpICAYd58X4kED1yXpFebv8mUHa7SCmZUfIXyH/T
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jul 21, 2020 at 11:23 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Clean up some needlessly device-specific stuff in the Realtek card reader
> drivers.
>
> This implements some of my suggestions from
> https://lore.kernel.org/r/20200720220651.GA1035857@bjorn-Precision-5520
>
> This will conflict with Ricky's post here:
> https://lore.kernel.org/r/20200706070259.32565-1-ricky_wu@realtek.com
>
> I'll be happy to update this on top of Ricky's patch after it's applied, or
> Ricky could pick up these patches and base his on top.


Looks all good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
