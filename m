Return-Path: <SRS0=gs89=3J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96519C33CB7
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 09:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7DF207FF
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 09:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RZHZvJdK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgATJoJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jan 2020 04:44:09 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:43284 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgATJoI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jan 2020 04:44:08 -0500
Received: by mail-vk1-f194.google.com with SMTP id h13so8375134vkn.10
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jan 2020 01:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8WXD++puZRBDfX+XovxCYxezYIYsgF4bFnxytu5iD+I=;
        b=RZHZvJdKK+liUUkELaYnw7PGaEroFf9bWYekXdHa0nKjOWN1cV6Cs1e09zCuchePzu
         RijCqeXtUHanoE2AIw5XN23OfQwNyKbfztEp2OtpSMASCijrurE07e2dKXVxsyCWVEPs
         FWZ+WLM/N+K0H92fquLbaCGqfEj23QyGNxICFJJN+fa9gGLppp/qEiQorEXFSC6szQDG
         xGtnebS9HNjcCQiiFhJdJxZECbi+meO5SGl50HCnbJjPJFvhh5ru4R0X++MQ+sap0bVH
         fqWYqYINlrp62H/fNGfi/JgDYS74n82ogq5FiUOnZ0de3oJZDIs57MqeT3ZH4AVoczYX
         KuZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8WXD++puZRBDfX+XovxCYxezYIYsgF4bFnxytu5iD+I=;
        b=gTAcwUxWjUCfHRUF9SV3ClOsdenmem17BRM7SHyuEb9m+vKMS3sy4vfva+y2pYS69u
         K7c/FuzXlLbhL+4G8PxPGHwc9VdmDSZDJiDjl7fNIFeZZOutjlk7v+zUHxQeQfFhzF7E
         b2J5Eoc25BtYlwsWcyUCqB1ltKQAyIzufRLQAGGCWyz6Lnq2IQ6zMj95zBfc4rk0fALI
         AlViy1fWKPvY2XvEulLopOBu0Y8jcG77Q6lO66KeFdoAJEuRgVVAk1EC1R5AOK7MAzmu
         urpoQpLZWVgsbFgraOMk57zScqOVpmo8QYw3ci4nZsQKCgt1tYDxZ5jbI1BXYVdmFUpo
         HH1Q==
X-Gm-Message-State: APjAAAUqEQAVZVZ7H80n500qP8YRSvSEH7fRNbEEnEpLw71g5trRX8Ea
        FNMhZFd0OO1BN+D2/tpb1jDRru3VfaLRp/yYidd0FA==
X-Google-Smtp-Source: APXvYqx+cHz8q5EP3Nl248rDH5+9yKyZOEZH6I3T1+KhPmpO6mTORqbQWVIORQg+2MtPoXgeClbCG0k4xhRdmPE3Nqc=
X-Received: by 2002:ac5:cde3:: with SMTP id v3mr378521vkn.43.1579513446738;
 Mon, 20 Jan 2020 01:44:06 -0800 (PST)
MIME-Version: 1.0
References: <9aff1d859935e59edd81e4939e40d6c55e0b55f6.1578390388.git.mirq-linux@rere.qmqm.pl>
 <CAPDyKFqXmbnH_NWZZTHHCE+Lt-f3JHAhJ8-=aoKNEPyQed44YA@mail.gmail.com> <20200117141145.GD26135@qmqm.qmqm.pl>
In-Reply-To: <20200117141145.GD26135@qmqm.qmqm.pl>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 20 Jan 2020 10:43:28 +0100
Message-ID: <CAPDyKFqmXiv75XCK6-tNJn5xTxyYpZcKRGKhvg-G0ycSZ_xw7g@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: tegra: fix SDR50 tuning override
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lucas Stach <dev@lynxeye.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 17 Jan 2020 at 15:11, Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qm=
qm.pl> wrote:
>
> On Thu, Jan 16, 2020 at 03:39:54PM +0100, Ulf Hansson wrote:
> > On Tue, 7 Jan 2020 at 10:47, Micha=C5=82 Miros=C5=82aw <mirq-linux@rere=
.qmqm.pl> wrote:
> > >
> > > Commit 7ad2ed1dfcbe inadvertently mixed up a quirk flag's name and
> > > broke SDR50 tuning override. Use correct NVQUIRK_ name.
> > >
> > > Fixes: 7ad2ed1dfcbe ("mmc: tegra: enable UHS-I modes")
> > > Cc: <stable@vger.kernel.org> # 4f6aa3264af4: mmc: tegra: Only adverti=
se UHS modes if IO regulator is present
> >
> > I am dropping this tag, simply because I don't understand what it shoul=
d tell.
>
> It tells the maintainer that he needs to cherry-pick this commit if
> its not in particular stable version already. I guess this is only
> for v4.4, as v4.9+ already have it, and v3.16 does not include the
> Fixed commit.

Alright, I updated myself on stable rules and found this, thanks!

So I have amended the patch to add back the tag, let's give this a try.

Kind regards
Uffe
