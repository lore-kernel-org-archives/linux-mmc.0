From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 2/9] mmc: mmci: add support for not-amba, but still
 compatible, variants
Date: Thu, 19 Jan 2017 17:11:32 +0000
Message-ID: <20170119171132.GI27312@n2100.armlinux.org.uk>
References: <1484552238-23171-1-git-send-email-andrea.merello@gmail.com>
 <1484552238-23171-3-git-send-email-andrea.merello@gmail.com>
 <CAPDyKFqX+_ZPWm__FQqNqBDxWnmVCHTBaMN=Tbbeh+E=kuGMMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:34862 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753174AbdASRLt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jan 2017 12:11:49 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFqX+_ZPWm__FQqNqBDxWnmVCHTBaMN=Tbbeh+E=kuGMMg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andrea Merello <andrea.merello@gmail.com>, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, bruherrera@gmail.com

On Thu, Jan 19, 2017 at 05:58:10PM +0100, Ulf Hansson wrote:
> + Russell
> 
> On 16 January 2017 at 08:37, Andrea Merello <andrea.merello@gmail.com> wrote:
> > The STM32F4xx family contain a SDIO IP that looks like a variant of
> > the PL180, however, inspite it's actually attached to a APB bus, it
> > cannot be handled by the AMBA bus code, because it lacks of the ID
> > registers that AMBA primecell IPs have.
> >
> > This patch prepares for supporting the STM32 variant by letting the
> > driver register also as a platform driver, that can be matched from
> > the OF with specific "compatible" strings
> 
> NAK!

Also NAK.

> Too much code are depending on the amba bus in the driver. I sincerely
> hope you haven't tried this approach for other amba drivers, because
> it will screw them up and they will become a nightmare to maintain!
> 
> Moreover, there is a way to override the use of the AMBA IDs
> registers. I think you can use that instead! No?

Exactly right.  Nothing wrong with creating an amba device in response
to probing a platform device - which becomes a shim which keeps the
main driver clean and maintanable.  The shim could also be used to
create amba device for other AMBA drivers too, it doesn't have to be
MMCI specific.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
