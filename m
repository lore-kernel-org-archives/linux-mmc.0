From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH v3] mmc: core: apply NO_CMD23 quirk to some specific
 cards
Date: Mon, 11 Dec 2017 21:19:23 +0100
Message-ID: <1513023563.9782.26.camel@googlemail.com>
References: <1504998772.4004.2.camel@googlemail.com>
         <1505000687.23171.20.camel@googlemail.com>
         <CAPDyKFp5JJUp7Rec=eFZd_m9yVKbO91CNR_HbN+rpUm5KTYJgA@mail.gmail.com>
         <27444e34-fcad-2244-5125-fc31a5755a12@rock-chips.com>
         <1506196286.1683.7.camel@googlemail.com>
         <10a81e7b-fe56-be68-dc46-4cf2870fd7a2@rock-chips.com>
         <1506338583.2143.5.camel@googlemail.com>
         <54d00dd9-a733-0319-e6d2-6ea77a49afa2@rock-chips.com>
         <1512394717.27568.11.camel@googlemail.com>
         <1512859465.7186.4.camel@googlemail.com>
         <1512859675.7186.8.camel@googlemail.com>
         <CAPDyKFpo5JC6W2SFeS9_bkWO=bH6JFT48o3dQpMYKSi6FKu+yQ@mail.gmail.com>
Reply-To: chf.fritz@googlemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:44317 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbdLKUT0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Dec 2017 15:19:26 -0500
Received: by mail-wm0-f53.google.com with SMTP id t8so16791352wmc.3
        for <linux-mmc@vger.kernel.org>; Mon, 11 Dec 2017 12:19:26 -0800 (PST)
In-Reply-To: <CAPDyKFpo5JC6W2SFeS9_bkWO=bH6JFT48o3dQpMYKSi6FKu+yQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On Mon, 2017-12-11 at 14:00 +0100, Ulf Hansson wrote:
> If/when Shawn find some time to re-spin his series, adding support for
> ACMD23 [1], we may be able to revert this change. Let's see.

If you or Shawn want me to test then again, please give me a head up.

> However, using the quirks as a fix for stable is certainly a good approach.

Thanks
 -- Christoph

