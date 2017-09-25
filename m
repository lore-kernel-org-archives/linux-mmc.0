From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH v2] mmc: core: apply NO_CMD23 quirk to an ATP card
Date: Mon, 25 Sep 2017 13:23:03 +0200
Message-ID: <1506338583.2143.5.camel@googlemail.com>
References: <1504998772.4004.2.camel@googlemail.com>
         <1505000687.23171.20.camel@googlemail.com>
         <CAPDyKFp5JJUp7Rec=eFZd_m9yVKbO91CNR_HbN+rpUm5KTYJgA@mail.gmail.com>
         <27444e34-fcad-2244-5125-fc31a5755a12@rock-chips.com>
         <1506196286.1683.7.camel@googlemail.com>
         <10a81e7b-fe56-be68-dc46-4cf2870fd7a2@rock-chips.com>
Reply-To: chf.fritz@googlemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37726 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934105AbdIYLXG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Sep 2017 07:23:06 -0400
Received: by mail-wm0-f66.google.com with SMTP id f4so6907848wmh.4
        for <linux-mmc@vger.kernel.org>; Mon, 25 Sep 2017 04:23:06 -0700 (PDT)
In-Reply-To: <10a81e7b-fe56-be68-dc46-4cf2870fd7a2@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, info@atpinc.com

On Mon, 2017-09-25 at 11:33 +0800, Shawn Lin wrote:
> >> I'm just curious about if these ATP cards could work for ACMD23?
> >>
> >> Could you kindly try this patch?
> >>
> >> |https://patchwork.kernel.org/patch/9887651/
> > 
> > By looking at your patch I can see that bool variable 'need_acmd23' is
> > only set when card does not support CMD23. But here this card (falsely)
> > claims to support CMD23, which is the whole point of the NO_CMD23 quirk.
> > 
> > So testing your patch would not make any difference, because its
> 
> yup, sorry fot that. I mean you could hack it a little to mask
> CMD23 support and let ACMD23 take effect, and see how it would
> go?

forcing ACMD23 instead of CMD23 works fine:

dd if=/dev/urandom of=/mnt/test bs=1M count=100 conv=fsync
100+0 records in
100+0 records out
104857600 bytes (105 MB) copied, 9.9496 s, 10.5 MB/s

It's as fast as using my NO_CMD23 quirk.

> >>>>           /*
> >>>> +        * Some SD cards lockup while using CMD23 multiblock transfers.
> >>>> +        */
> >>>> +       MMC_FIXUP("AF SD", CID_MANFID_ATP, CID_OEMID_ANY, add_quirk_sd,
> >>>> +                 MMC_QUIRK_BLK_NO_CMD23),
> >>>
> >>> Is really all ATP cards having this problem? Perhaps we should
> >>> consider making this a bit more fine grained?
> >>>
> >>> On the other hand, this may be the safest way to do it...
> > 
> > I also thought about this and set CID_OEMID_ANY because I wanted to be
> > on the safe side. Maybe ATP can comment on this (in CC)?

Thanks
 -- Christoph

