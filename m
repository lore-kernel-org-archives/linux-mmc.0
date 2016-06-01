From: Stephen Boyd <stephen.boyd@linaro.org>
Subject: Re: [PATCH v3 09/12] EXAMPLE CODE: usb: port: Parse pwrseq phandle from
 Device Tree
Date: Wed, 01 Jun 2016 11:16:34 -0700
Message-ID: <146480499491.3686.4996610748316511864@sboyd-linaro>
References: <1464768141-25420-1-git-send-email-k.kozlowski@samsung.com>
 <1464768141-25420-10-git-send-email-k.kozlowski@samsung.com>
 <146477144362.1485.3331887341591876278@sboyd-linaro>
 <20160601120520.GB16740@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34946 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758328AbcFASQm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jun 2016 14:16:42 -0400
Received: by mail-pf0-f178.google.com with SMTP id g64so19711520pfb.2
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jun 2016 11:16:41 -0700 (PDT)
In-Reply-To: <20160601120520.GB16740@shlinux2>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org

Quoting Peter Chen (2016-06-01 05:05:20)
> On Wed, Jun 01, 2016 at 01:57:23AM -0700, Stephen Boyd wrote:
> > Quoting Krzysztof Kozlowski (2016-06-01 01:02:18)
> > > Parse usb-pwrseq property from Device Tree to get the phandle to pwrseq
> > > device.  The pwrseq device will be used by USB hub to cycle the power
> > > before activating ports.
> > > 
> > > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > 
> > Drive by review comment.
> > 
> > I was hoping this would help me with a problem I'm having where I have a
> > hub (smsc4604) that needs to be taken out of reset before my HSIC
> > controller sends a USB reset to it, but it seems this is more about
> > doing some sort of power on sequence after enumeration?
> > 
> 
> No, you may need to do reset before enumeration, the general purpose of
> reset is eliminate unstable hardware state, and let the controller find
> the device.
> 
> Try to do it at bootloader to see if it works for you.
> 

Sorry the bootloader doesn't do this so that doesn't work for me.
