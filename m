From: Fabio Estevam <festevam@gmail.com>
Subject: Re: How to prevent high speed mode due to signal integrity problem
Date: Mon, 5 Dec 2016 22:46:52 -0200
Message-ID: <CAOMZO5A5ejaX6DE22DS2Fh_NNTmcpak4SWhbZhsjg6108rvwGw@mail.gmail.com>
References: <CAG5mAdyAkc3bJS6VD-1s5pKkE7E7XDSA4eq5Ree9ysP5YZd96A@mail.gmail.com>
 <CAG5mAdyyOq-m61OfTAsE532CLDhQgejYL=dGv_Cg89PbbQZGZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:36454 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbcLFAqx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Dec 2016 19:46:53 -0500
Received: by mail-oi0-f49.google.com with SMTP id v84so360742815oie.3
        for <linux-mmc@vger.kernel.org>; Mon, 05 Dec 2016 16:46:53 -0800 (PST)
In-Reply-To: <CAG5mAdyyOq-m61OfTAsE532CLDhQgejYL=dGv_Cg89PbbQZGZg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Caleb Crome <caleb@crome.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Caleb,

On Mon, Dec 5, 2016 at 10:36 PM, Caleb Crome <caleb@crome.org> wrote:
> Hello,
>    We have a board here where there is a signal integrity problem on the MMC
> bus.  It works fine at 25MHz, but does not work in higher speed modes.
>
> Is there an easy way to disable all the high speed modes?  Perhaps from the
> device tree?
>
> I tried searching the archives, but gmane seems to be not working.
>
> I'm using a stock 4.8.11 kernel.
> Host processor is i.MX6

Would max-frequency = <25000000>; do the trick?

Please take a look at Documentation/devicetree/bindings/mmc/mmc.txt .
