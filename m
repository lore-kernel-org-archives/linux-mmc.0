From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk
 numbering w/ device tree
Date: Wed, 4 May 2016 09:18:01 +0200
Message-ID: <20160504071801.GA17045@amd>
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
 <20160429181248.GW19428@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160429181248.GW19428@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Douglas Anderson <dianders@chromium.org>, ulf.hansson@linaro.org, jh80.chung@samsung.com, shawn.lin@rock-chips.com, adrian.hunter@intel.com, stefan@agner.ch, linux-mmc@vger.kernel.org, computersforpeace@gmail.com, dmitry.torokhov@gmail.com, Heiko Stuebner <heiko@sntech.de>, jszhang@marvell.com, linux-rockchip@lists.infradead.org, devicetree-spec@vger.kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, vbyravarasu@nvidia.com, lars@metafoo.de, jonathanh@nvidia.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, grundler@chromium.org, galak@codeaurora.org, lporzio@micron.com, robh+dt@kernel.org, chaotian.jing@mediatek.com, sergei.shtylyov@cogentembedded.com, sudeep.holla@arm.com, zhonghui.fu@linux.intel.com, kirill.shutemov@linux.intel.com
List-Id: linux-mmc@vger.kernel.org

On Fri 2016-04-29 19:12:48, Russell King - ARM Linux wrote:
> On Fri, Apr 29, 2016 at 10:32:15AM -0700, Douglas Anderson wrote:
> > This series picks patches from various different places to produce what
> > I consider the best solution to getting consistent mmc and mmcblk
> > ordering.
> > 
> > Why consistent ordering and why not just use UUIDs?  IMHO consistent
> > ordering solves a few different problems:
> 
> NAK.  Really.  Use UUIDs, that's the proper solution here.

Except that UUIDs do not solve the problem.

You have just booted of nfsroot, and you want to format u-SD card in
the external slot. How do you do that?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
