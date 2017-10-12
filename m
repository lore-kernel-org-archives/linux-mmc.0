From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: eMMC tuning issue on Odroid C2 and a possible solution
Date: Thu, 12 Oct 2017 22:05:45 +0200
Message-ID: <1507838745.16356.270.camel@baylibre.com>
References: <b931985f-16b2-0a90-e73b-b6c349ad7d6c@gmail.com>
         <1507821759.16356.225.camel@baylibre.com>
         <aa13028e-b42a-094f-7bd1-ef22e8cdacbd@gmail.com>
         <1507836874.16356.258.camel@baylibre.com>
         <fa52e311-bafe-0a6a-1b85-ac8f40db62ed@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:45452 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753101AbdJLUFs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Oct 2017 16:05:48 -0400
Received: by mail-wm0-f51.google.com with SMTP id q124so16126124wmb.0
        for <linux-mmc@vger.kernel.org>; Thu, 12 Oct 2017 13:05:48 -0700 (PDT)
In-Reply-To: <fa52e311-bafe-0a6a-1b85-ac8f40db62ed@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, Kevin Hilman <khilman@baylibre.com>

On Thu, 2017-10-12 at 21:49 +0200, Heiner Kallweit wrote:
> > The result of the tuning does not depends on starting point, so I don't
> > really
> > understand how it would significantly change things.
> > 
> 
> I think it depends on the tx phase starting point.
> 

If the result of the tuning is not independent of the starting, instead of just
telling me, it is fairly easy for you to give actual result, like I asked you:

> > Ok, starting from Rx:0 Tx:270 then tuning gives you Tx:300 Rx:90
> > And what different did it gives you starting Rx:0/Tx:0 ?

And if the result are indeed vastly different, let's debug and get a real
explanation.

> Tuning does:
> rx phase tuning
> tx phase tuning
> rx phase tuning
> 
> Result of each step depends on result of previous step.

Again, we don't agree. 

> So also the initial
> rx phase tuning result depends on the starting point of tx phase.

The first Rx tuning is there only to get a sane starting point for the tx tuning
,as explained in the code. This is the reason why is not done when re-tuning.


