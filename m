From: Sebastian Rasmussen <sebras@gmail.com>
Subject: Re: [PATCH] mmc: support BKOPS feature for eMMC
Date: Thu, 27 Oct 2011 22:51:53 +0200
Message-ID: <CAAgDR1PJFX1c3xexgv7=Ccm3HGRtu0VMDy6APWUExSHOO3aE4A@mail.gmail.com>
References: <4EA93C08.9030009@samsung.com>
	<loom.20111027T202726-264@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43596 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100Ab1J0Uvy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2011 16:51:54 -0400
Received: by ggnb1 with SMTP id b1so3036965ggn.19
        for <linux-mmc@vger.kernel.org>; Thu, 27 Oct 2011 13:51:53 -0700 (PDT)
In-Reply-To: <loom.20111027T202726-264@post.gmane.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.lkml@gmail.com>
Cc: linux-mmc@vger.kernel.org

Hi!

> This patch only starts BKOPS if it's urgent or critical.

Almost, it starts BKOPS when it is urgent, which per spec means level
2 or 3, i.e. when performance is impacted or when it is critical.
Better use the specs terminology as far as possible to relieve
everyone of confusion.

> I would be preferable to run bkops periodically and only when
> the card is idle to minimize the risk of reaching URGENT.

Well, you kind of need both. If the eMMC is kept busy to such an
extent that the block device is never idling then you would definitely
require this patch, right? Otherwise you may end up wasting the time
between the last command sent and when the device has been deemed to
be idle for long enough.

So basically the OP's patch fixes the case where, e.g. sustained
(re-)writing, keeps the block device busy until and after it reaches
the critical BKOPS level, while your proposal takes care of the other
case where the block device is not accessed all the time.

> The specs says:
> -----
> Hosts shall still read the full status from the BKOPS_STATUS byte per=
iodically
> and start background operations as needed.
> -----

Sure, if there is idle time to do it, then why not.
If there is no idle time and URGENT_BKOPS is asserted, then the
framework can not wait until the next idle period, but should issue
BKOPS as soon as possible after the current command is finished.

> I'm thinking of checking BKOPS_STATUS when the card is idle and then =
run bkops
> even if level is only 1 (Operations outstanding =96 non critical). Wo=
uld this make
> sense?

I guess this boils down to how you define idle..? Does it mean
immediately after the current command has been fully serviced, or does
it mean some arbitrary time after the last sent command has been fully
serviced? My assumption is that you are refering to the latter, in
which case certain access patterns may cause problems. So, how do
_you_ define idle? :)

 / Sebastian
