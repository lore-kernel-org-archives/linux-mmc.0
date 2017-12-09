From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH v2] mmc: core: apply NO_CMD23 quirk to an ATP card
Date: Sat, 09 Dec 2017 23:44:25 +0100
Message-ID: <1512859465.7186.4.camel@googlemail.com>
References: <1504998772.4004.2.camel@googlemail.com>
         <1505000687.23171.20.camel@googlemail.com>
         <CAPDyKFp5JJUp7Rec=eFZd_m9yVKbO91CNR_HbN+rpUm5KTYJgA@mail.gmail.com>
         <27444e34-fcad-2244-5125-fc31a5755a12@rock-chips.com>
         <1506196286.1683.7.camel@googlemail.com>
         <10a81e7b-fe56-be68-dc46-4cf2870fd7a2@rock-chips.com>
         <1506338583.2143.5.camel@googlemail.com>
         <54d00dd9-a733-0319-e6d2-6ea77a49afa2@rock-chips.com>
         <1512394717.27568.11.camel@googlemail.com>
Reply-To: chf.fritz@googlemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:35933 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751401AbdLIWoa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 9 Dec 2017 17:44:30 -0500
Received: by mail-wr0-f178.google.com with SMTP id v105so13993761wrc.3
        for <linux-mmc@vger.kernel.org>; Sat, 09 Dec 2017 14:44:30 -0800 (PST)
In-Reply-To: <1512394717.27568.11.camel@googlemail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc <linux-mmc@vger.kernel.org>

On Mon, 2017-12-04 at 14:38 +0100, Christoph Fritz wrote:
> Finally I got this microSD to SD adapter to test the ATP card on RK3288
> platform too. As expected, card fails without the patch:
> 
>  $ dd if=/dev/urandom of=./test bs=1M count=10
> 
> does freeze system without any response
> 
> So I can verify failing CMD23 behaviour on imx6 and rk3288 running
> kernel 4.14. Applying the patch does fix the issue on both platforms.
> 
> Could you queue up this patch now?

*ping*

Meanwhile I found another card which fails CMD23 by testing it on rk3288
and i.MX6.

I'll send a patch for both cards as v3 of this Patch.

best regards
 -- Christoph

