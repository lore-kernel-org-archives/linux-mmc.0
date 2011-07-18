From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH] mmc: enable background operations for emmc4.41 with HPI support
Date: Mon, 18 Jul 2011 13:21:48 +0530
Message-ID: <CAF=Qhp0pMOzXCmbqn=cfOsRe7fyuc3pV0HzBkmr83rxWM8a1Dg@mail.gmail.com>
References: <1309868840-15089-1-git-send-email-hanumath.prasad@stericsson.com> <CANfBPZ8HS3n0kmejZnD-zzRkphpAW9poC_4i-8ppwqrXxDv42g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62244 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028Ab1GRHwI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jul 2011 03:52:08 -0400
Received: by yxi11 with SMTP id 11so1184524yxi.19
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2011 00:52:08 -0700 (PDT)
In-Reply-To: <CANfBPZ8HS3n0kmejZnD-zzRkphpAW9poC_4i-8ppwqrXxDv42g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Hanumath Prasad <hanumath.prasad@stericsson.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linus.walleij" <linus.walleij@stericsson.com>, "per.forlin" <per.forlin@linaro.org>, "chuanxiao.dong" <chuanxiao.dong@intel.com>

<snip>

> How does BKOPS work with card power management ? On some controllers,
> regulators are switched off in between transactions after some delay.
> Wouldn't the card need power to do it's BKOPS ?

AFAIK eMMC card has two voltages one for core rail and other for IO rail.
Power Management is done with IO rail but the core rail voltages
should be present
through out and I think BKOPS uses core rail voltages.

Regards,
Kishore
