From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc: agressive clocking framework v9
Date: Thu, 4 Nov 2010 17:20:05 -0400
Message-ID: <AANLkTikPFrwkU9wuxHwL2mkyaOLFbh8A36hOxVXa+kLZ@mail.gmail.com>
References: <1288869390-20465-1-git-send-email-linus.walleij@stericsson.com>
 <4CD2B1FF.6030708@csr.com> <4CD2C240.8030400@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61816 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830Ab0KDVUj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Nov 2010 17:20:39 -0400
Received: by gyh4 with SMTP id 4so1798291gyh.19
        for <linux-mmc@vger.kernel.org>; Thu, 04 Nov 2010 14:20:38 -0700 (PDT)
In-Reply-To: <4CD2C240.8030400@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: David Vrabel <david.vrabel@csr.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ghorai Sukumar <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>, Adrian Hunter <adrian.hunter@nokia.com>, Kyungmin Park <kmpark@infradead.org>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>

On Thu, Nov 4, 2010 at 10:25 AM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> Since the runtime_pm_get/put calls are balanced for the host
> enable/disable case and the clock gating is orthogonal,
> I need to create an orthogonal instance of hooks, maybe it's
> easiest to just spawn a second dummy device like mmc0_clk
> for this to be able to use the runtime PM hooks?

What about:
- register the (generic ?) runtime PM handlers to mmc_host_class
- call the runtime pm get/put API on host->class_dev (in
mmc_start_request/mmc_request_done)
- use runtime PM autosuspend for taking care of the required delay

The host controller will get the idle notification directly to its
runtime PM handlers. It's not via set_ios, I know, but it looks so
simple and intuitive..

>
> Back to hacking!
>
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
