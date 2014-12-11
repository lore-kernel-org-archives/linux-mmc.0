From: Eliad Peller <eliad@wizery.com>
Subject: SDIO device binding
Date: Thu, 11 Dec 2014 15:32:51 +0200
Message-ID: <CAB3XZEfX7oAmJe=86j+WC0w73kQxO4C=Ufdy6eMgtYYh8Swv2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:57738 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932159AbaLKNcw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Dec 2014 08:32:52 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Cc: Chris Ball <chris@printf.net>, Hans de Goede <hdegoede@redhat.com>

hi,

I'm looking for the proper way to pass SDIO device properties using devicetree.

There seems to be a patchset sent previously by Sascha Hauer to handle
it, but for some reason it didn't get merged, and i can't find any
further discussion regarding the patches.

https://patchwork.ozlabs.org/patch/355235/
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/261575.html

Was there any issue with the patches, or is there any other binding
that should be used instead?

thanks,
Eliad.
