From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] irq: If an IRQ is a GPIO, request and configure it
Date: Fri, 5 Aug 2011 09:29:21 +0100
Message-ID: <20110805082921.GA4977@opensource.wolfsonmicro.com>
References: <1312498820-2275-1-git-send-email-swarren@nvidia.com>
	<1312498820-2275-2-git-send-email-swarren@nvidia.com>
	<20110805000148.GB13321@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF049F171EC1@HQMAIL01.nvidia.com>
	<20110805053510.GA16956@opensource.wolfsonmicro.com>
	<20110805080620.GE28651@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20110805080620.GE28651@trinity.fluff.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "olof@lixom.net" <olof@lixom.net>, "ccross@android.com" <ccross@android.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Chris Ball <cjb@laptop.org>, Liam Girdwood <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Aug 05, 2011 at 09:06:20AM +0100, Ben Dooks wrote:

> I would say that setting the interrupt should deal with all the necessary
> configuration to get that interrupt working. In the case of pretty much all
> of the SoCs I have been involved with have always set the GPIO's function
> to allow the interrupt to pass through.

That's what Stephen is trying to do, essentially.  It's looking like
it's more sensible to fix it in the Tegra interrupt drivers, though.
