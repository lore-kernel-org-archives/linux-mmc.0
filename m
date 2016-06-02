From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v3 09/12] EXAMPLE CODE: usb: port: Parse pwrseq phandle
 from Device Tree
Date: Thu, 2 Jun 2016 09:24:19 +0800
Message-ID: <20160602012419.GA7953@shlinux2>
References: <1464768141-25420-1-git-send-email-k.kozlowski@samsung.com>
 <1464768141-25420-10-git-send-email-k.kozlowski@samsung.com>
 <146477144362.1485.3331887341591876278@sboyd-linaro>
 <20160601120520.GB16740@shlinux2>
 <146480499491.3686.4996610748316511864@sboyd-linaro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <146480499491.3686.4996610748316511864@sboyd-linaro>
Sender: linux-pm-owner@vger.kernel.org
To: Stephen Boyd <stephen.boyd@linaro.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Jun 01, 2016 at 11:16:34AM -0700, Stephen Boyd wrote:
> Quoting Peter Chen (2016-06-01 05:05:20)
> > On Wed, Jun 01, 2016 at 01:57:23AM -0700, Stephen Boyd wrote:
> > > Quoting Krzysztof Kozlowski (2016-06-01 01:02:18)
> > > > Parse usb-pwrseq property from Device Tree to get the phandle to pwrseq
> > > > device.  The pwrseq device will be used by USB hub to cycle the power
> > > > before activating ports.
> > > > 
> > > > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > > 
> > > Drive by review comment.
> > > 
> > > I was hoping this would help me with a problem I'm having where I have a
> > > hub (smsc4604) that needs to be taken out of reset before my HSIC
> > > controller sends a USB reset to it, but it seems this is more about
> > > doing some sort of power on sequence after enumeration?
> > > 
> > 
> > No, you may need to do reset before enumeration, the general purpose of
> > reset is eliminate unstable hardware state, and let the controller find
> > the device.
> > 
> > Try to do it at bootloader to see if it works for you.
> > 
> 
> Sorry the bootloader doesn't do this so that doesn't work for me.

I mean try to see if the HUB can work if you reset it at bootloader.
If it works, it means you need to do reset before enumeration, and you
don't need to do anything after enumeration.

-- 

Best Regards,
Peter Chen
