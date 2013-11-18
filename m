From: "Stephen Hurd" <shurd@broadcom.com>
Subject: RE: [PATCH] mmc: disable UHS on broadcom sdhci
Date: Mon, 18 Nov 2013 20:09:10 +0000
Message-ID: <156984479488CD49A184F5CAB4AF93460709F237@IRVEXCHMB14.corp.ad.broadcom.com>
References: <1384559782-7614-1-git-send-email-grundler@chromium.org>
 <20131116073454.GA20132@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mms2.broadcom.com ([216.31.210.18]:2515 "EHLO mms2.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640Ab3KRUJO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Nov 2013 15:09:14 -0500
In-Reply-To: <20131116073454.GA20132@quad.lixom.net>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>, Grant Grundler <grundler@chromium.org>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Olof Johansson <olofj@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

> > SDHCI_QUIRK2_BCM57785_CR:
> >     Bit twiddles some Broadcom-specific registers and supresses an error
> >     about the 64k bar0.

> I think this can be done without spending a global SDHCI quirk bit. This
> is just a one-time setup that needs to be done, isn't it? It's hard
> to tell since there's no official errata described, but if it is, then
> overriding the probe function is the way to go instead, flipping these
> bits there and then call the regular probe.

My initial recollection is that this bit twiddling needs to be done any time the clock is touched, so it's not just one-time setup.  I'll ask the guys about it and get back to you.

The 64k bar0 suppression is just cosmetic, but I don't see anything in the public specs suggesting that there is a max limit on the size of the bar... not sure that it's appropriate to give a warning on it for *any* device, but it's absolutely incorrect for this device.


