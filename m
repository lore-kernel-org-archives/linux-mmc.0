From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: sdio_f0_readb()
Date: Fri, 14 Jul 2017 11:12:12 +0200
Message-ID: <CAPDyKFp7xdh-0p72njRA1O=VhyG4S+tF5CHZmxe-H-PPLf1pAg@mail.gmail.com>
References: <cc6dd05c-b1bc-8096-b79d-dd140fb6397e@mnementh.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:35950 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751340AbdGNJMN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Jul 2017 05:12:13 -0400
Received: by mail-qt0-f171.google.com with SMTP id i2so57554144qta.3
        for <linux-mmc@vger.kernel.org>; Fri, 14 Jul 2017 02:12:13 -0700 (PDT)
In-Reply-To: <cc6dd05c-b1bc-8096-b79d-dd140fb6397e@mnementh.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 13 July 2017 at 18:04, Ian Molton <ian@mnementh.co.uk> wrote:
> Hi folks,
>
>
> What is the function sdio_f0_readb() so special for? it seems to be used
> by a tiny handful of drivers and is equivalent to sdio_readb() with the
> function parameter set to 0.
>
> Its twin sdio_f0_writeb() does some very minimal checking for register
> bounds.
>
> Is it really worth all this abstraction for a few (usually wifi)
> drivers? surely the driver knows which registers it should touch anyway?
> its not like most bus drivers perform this sort of checking...
>
> Should this be done away with before more drivers start using it? I'm
> happy to submit a patch to remove sdio_f0*()

Why not just submit the patch - and let people discuss about it? :-)

Kind regards
Uffe
