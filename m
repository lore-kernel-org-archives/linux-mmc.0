From: Caleb Crome <caleb@crome.org>
Subject: Re: How to prevent high speed mode due to signal integrity problem
Date: Mon, 5 Dec 2016 16:36:55 -0800
Message-ID: <CAG5mAdyyOq-m61OfTAsE532CLDhQgejYL=dGv_Cg89PbbQZGZg@mail.gmail.com>
References: <CAG5mAdyAkc3bJS6VD-1s5pKkE7E7XDSA4eq5Ree9ysP5YZd96A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34793 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbcLFAhV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Dec 2016 19:37:21 -0500
Received: by mail-oi0-f47.google.com with SMTP id y198so361903857oia.1
        for <linux-mmc@vger.kernel.org>; Mon, 05 Dec 2016 16:37:16 -0800 (PST)
In-Reply-To: <CAG5mAdyAkc3bJS6VD-1s5pKkE7E7XDSA4eq5Ree9ysP5YZd96A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello,
   We have a board here where there is a signal integrity problem on the MMC
bus.  It works fine at 25MHz, but does not work in higher speed modes.

Is there an easy way to disable all the high speed modes?  Perhaps from the
device tree?

I tried searching the archives, but gmane seems to be not working.

I'm using a stock 4.8.11 kernel.
Host processor is i.MX6

Thanks,
  -Caleb
