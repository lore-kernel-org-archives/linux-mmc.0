From: Stephen Boyd <stephen.boyd@linaro.org>
Subject: Re: [PATCH v3 09/12] EXAMPLE CODE: usb: port: Parse pwrseq phandle
 from Device Tree
Date: Thu, 02 Jun 2016 16:59:55 -0700
Message-ID: <146491199510.7580.5649614149557346848@sboyd-linaro>
References: <1464768141-25420-1-git-send-email-k.kozlowski@samsung.com>
 <1464768141-25420-10-git-send-email-k.kozlowski@samsung.com>
 <146477144362.1485.3331887341591876278@sboyd-linaro>
 <20160601120520.GB16740@shlinux2>
 <146480499491.3686.4996610748316511864@sboyd-linaro>
 <20160602012419.GA7953@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160602012419.GA7953@shlinux2>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-pm@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, Kukjin Kim <kgene@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Kumar Gala <galak@codeaurora.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-mmc@vger.kernel.org

Quoting Peter Chen (2016-06-01 18:24:19)
> On Wed, Jun 01, 2016 at 11:16:34AM -0700, Stephen Boyd wrote:
> > > 
> > > No, you may need to do reset before enumeration, the general purpose of
> > > reset is eliminate unstable hardware state, and let the controller find
> > > the device.
> > > 
> > > Try to do it at bootloader to see if it works for you.
> > > 
> > 
> > Sorry the bootloader doesn't do this so that doesn't work for me.
> 
> I mean try to see if the HUB can work if you reset it at bootloader.
> If it works, it means you need to do reset before enumeration, and you
> don't need to do anything after enumeration.
> 

Ah ok. Yes, I need to deassert the reset before enumeration. Right now I
have a driver for the 4604 hub controller that deasserts a reset gpio
and sends an i2c command to put the controller into "hub" mode. If I do
this before the usb controller driver probes then everything works. If I
do it after the controller probes it doesn't.
