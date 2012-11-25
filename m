From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH 1/2] sdhci: add quirk for lack of 1.8v support
Date: Sun, 25 Nov 2012 12:50:21 -0600
Message-ID: <CAMLZHHTjCoxy7JB-bQRRVxoheMaTDkOE4GyUwyHsF2vQ+x1WBg@mail.gmail.com>
References: <20121125180121.31FB3FACF5@dev.laptop.org>
	<047F3E93-113E-4974-9A0C-39DBBBE6D78C@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:52862 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246Ab2KYSuV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Nov 2012 13:50:21 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so3374991dak.19
        for <linux-mmc@vger.kernel.org>; Sun, 25 Nov 2012 10:50:21 -0800 (PST)
In-Reply-To: <047F3E93-113E-4974-9A0C-39DBBBE6D78C@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@nvidia.com>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "jrudholm@gmail.com" <jrudholm@gmail.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On Sun, Nov 25, 2012 at 12:36 PM, Philip Rakity <prakity@nvidia.com> wrote:
> The same effect can be achieved by setting the quirk
> SDHCI_QUIRK_MISSING_CAPS
> reading caps[0] and removing from caps[1] the UHS values in the controller specific code for your board.
>
> What is the reason you cannot do this ?

The same reasons we already touched upon in the other thread.
http://marc.info/?l=linux-mmc&m=135240077826454&w=2
http://marc.info/?l=linux-mmc&m=135240181826846&w=2

To reiterate (I know this has been broken out over a couple of weeks):

There is no controller-specific or board-specific code. We are working
with the device tree. It must be done generically.

SDHCI_QUIRK_MISSING_CAPS seems to be aimed at cases where the
controller does not report caps, or it is lying about the caps it
does/doesn't support. In this case our controller is being truthful,
so this does not feel appropriate.

Also, the only realistic way that I can see to combine
SDHCI_QUIRK_MISSING_CAPS with the device tree would be to put the
caps/caps1 override data in the device tree. This just seems ugly, and
feels like it is taking the wrong approach of again suggesting that
the controller is providing bad data, when in this case actually it is
correctly saying that 1.8v is supported (by the controller - it
obviously cannot speak for external components).

We don't have a regulator to work with here.

Thanks
Daniel
