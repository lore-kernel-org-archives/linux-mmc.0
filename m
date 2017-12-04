From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH v2] mmc: core: apply NO_CMD23 quirk to an ATP card
Date: Mon, 04 Dec 2017 14:38:37 +0100
Message-ID: <1512394717.27568.11.camel@googlemail.com>
References: <1504998772.4004.2.camel@googlemail.com>
         <1505000687.23171.20.camel@googlemail.com>
         <CAPDyKFp5JJUp7Rec=eFZd_m9yVKbO91CNR_HbN+rpUm5KTYJgA@mail.gmail.com>
         <27444e34-fcad-2244-5125-fc31a5755a12@rock-chips.com>
         <1506196286.1683.7.camel@googlemail.com>
         <10a81e7b-fe56-be68-dc46-4cf2870fd7a2@rock-chips.com>
         <1506338583.2143.5.camel@googlemail.com>
         <54d00dd9-a733-0319-e6d2-6ea77a49afa2@rock-chips.com>
Reply-To: chf.fritz@googlemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:46270 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753594AbdLDNik (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Dec 2017 08:38:40 -0500
Received: by mail-wr0-f180.google.com with SMTP id x49so17312250wrb.13
        for <linux-mmc@vger.kernel.org>; Mon, 04 Dec 2017 05:38:39 -0800 (PST)
In-Reply-To: <54d00dd9-a733-0319-e6d2-6ea77a49afa2@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi Shawn and Ulf

On Tue, 2017-09-26 at 08:56 +0800, Shawn Lin wrote:
> Back to $subject patch, It still need to verify this conclusion on other
> platforms or get acknowledgement from the vendor.

to quote myself:

On Sat, 2017-09-23 at 21:51 +0200, Christoph Fritz wrote:
> > SoC am335x (omap_hsmmc) works fine because it lacks CMD23 host support.
> > My RK3288 board supports only micro-SD cards. If you want me to, I could
> > get an adapter (micro-SD -> SD) but the shipping takes ~40 days.

Finally I got this microSD to SD adapter to test the ATP card on RK3288
platform too. As expected, card fails without the patch:

 $ dd if=/dev/urandom of=./test bs=1M count=10

does freeze system without any response

So I can verify failing CMD23 behaviour on imx6 and rk3288 running
kernel 4.14. Applying the patch does fix the issue on both platforms.

Could you queue up this patch now?

Thanks
  -- Christoph

