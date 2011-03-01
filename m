From: Eric Miao <eric.miao@linaro.org>
Subject: Re: [PATCH V3 4/4] mmc: sdhci-esdhc: enable esdhc on imx53
Date: Tue, 1 Mar 2011 11:06:07 +0800
Message-ID: <AANLkTinabUZ8wot=iu7Yp6LnmVWu_k1Ha2srHaipy0qx@mail.gmail.com>
References: <1298892725-23672-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1298892725-23672-4-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20110228144741.GF15532@pengutronix.de> <010C9052C42A00499CE76D637FA5EE900C7B7B@039-SN1MPN1-001.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52945 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160Ab1CADG2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Feb 2011 22:06:28 -0500
Received: by iwn34 with SMTP id 34so3713045iwn.19
        for <linux-mmc@vger.kernel.org>; Mon, 28 Feb 2011 19:06:27 -0800 (PST)
In-Reply-To: <010C9052C42A00499CE76D637FA5EE900C7B7B@039-SN1MPN1-001.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhu Richard-R65037 <R65037@freescale.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Zhao Richard-B20223 <B20223@freescale.com>, "cjb@laptop.org" <cjb@laptop.org>, "eric@eukrea.com" <eric@eukrea.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Freescale@lists.linaro.org" <Freescale@lists.linaro.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linuxzsc@gmail.com" <linuxzsc@gmail.com>

>> Hmm, to me, just using cpu_is_mx53() is more readable than introducing
>> another layer of flags/quirks.
> Hi Wolfram:
> I discussed it with Richard Zhao before sending out these V3 patches.
> As we know that there is not only mx53 has this issue, maybe some following SOCs have this issue too.
> So we make a decision that we introduce another flags/quirks to declare it for all those SOCs that required this
> mechanism in the end.

I agree with Richard here that a flag/quirk will be more generic than
cpu_is_*(). Otherwise we may end up one day growing a big list of
these cpu_is_*().

One other point to consider is the SoC stepping, as this might be
fixed in later steppings, and keeping cpu_is_mx53() or
cpu_is_mx53_stepping_b2_or_above() doesn't look very good in
the driver code itself.
