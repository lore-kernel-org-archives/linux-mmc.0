From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 06/10] mmc: omap_hsmmc: add support for pbias
 configuration in dt
Date: Thu, 13 Jun 2013 11:38:12 +0200
Message-ID: <CACRpkdbaCDNsquDPWiYWFTxwBfzZ9mkrCV93cZbYSKwoQR21iQ@mail.gmail.com>
References: <20130523184045.GD13507@atomide.com>
	<1370546059-24181-1-git-send-email-balajitk@ti.com>
	<1370546059-24181-7-git-send-email-balajitk@ti.com>
	<20130612143718.GB8164@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:60298 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758395Ab3FMJiN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jun 2013 05:38:13 -0400
Received: by mail-oa0-f43.google.com with SMTP id i7so9064714oag.16
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jun 2013 02:38:12 -0700 (PDT)
In-Reply-To: <20130612143718.GB8164@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Balaji T K <balajitk@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "Cousson, Benoit" <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On Wed, Jun 12, 2013 at 4:37 PM, Tony Lindgren <tony@atomide.com> wrote:

> Linus W may have some comments on this, although this is not the standard
> muxing stuff.

It's in the wrong subsystem and needs to be rewritten IMO.

Yours,
Linus Walleij
