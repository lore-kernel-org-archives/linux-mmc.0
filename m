From: Per Forlin <per.lkml@gmail.com>
Subject: Re: [PATCH] mmc: support BKOPS feature for eMMC
Date: Thu, 27 Oct 2011 19:35:55 +0000 (UTC)
Message-ID: <loom.20111027T202726-264@post.gmane.org>
References: <4EA93C08.9030009@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:50087 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751754Ab1J0TkK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Oct 2011 15:40:10 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1RJVo8-00078V-8V
	for linux-mmc@vger.kernel.org; Thu, 27 Oct 2011 21:40:08 +0200
Received: from 57.79.167.152 ([57.79.167.152])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 27 Oct 2011 21:40:08 +0200
Received: from per.lkml by 57.79.167.152 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 27 Oct 2011 21:40:08 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Jaehoon Chung <jh80.chung <at> samsung.com> writes:

> +++ b/drivers/mmc/core/core.c
> @@ -238,6 +238,50 @@ mmc_start_request(struct mmc_host *host, struct
mmc_request *mrq)
>  	host->ops->request(host, mrq);
>  }
>=20
> +/**
> + *	mmc_start_bkops - start BKOPS for supported cards
> + *	@card: MMC card to start BKOPS
> + *
> + *	Start background operations whenever requested.
> + *	when the urgent BKOPS bit is set in a R1 command response
> + *	then background operations should be started immediately.
> +*/
This patch only starts BKOPS if it's urgent or critical. I would be pre=
ferable
to run bkops periodically and only when the card is idle to minimize th=
e risk of
reaching URGENT.

The specs says:
-----
Hosts shall still read the full status from the BKOPS_STATUS byte perio=
dically
and start background operations as needed.
-----

I'm thinking of checking BKOPS_STATUS when the card is idle and then ru=
n bkops
even if level is only 1 (Operations outstanding =E2=80=93 non critical)=
=2E Would this make
sense?

Regards,
Per


