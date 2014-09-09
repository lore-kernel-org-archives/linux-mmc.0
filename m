From: Pavel Machek <pavel@denx.de>
Subject: Re: [GIT PULL 1/2] SOCFPGA updates for 3.18
Date: Tue, 9 Sep 2014 23:02:32 +0200
Message-ID: <20140909210232.GA539@amd>
References: <1409847105-27241-1-git-send-email-dinguyen@opensource.altera.com>
 <20140909141756.GA30100@amd> <4134101.OOENTRabu1@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4134101.OOENTRabu1@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, marex@denx.de
Cc: khilman@linaro.org, dinh.linux@gmail.com, linux-mmc@vger.kernel.org, arm@kernel.org, olof@lixom.net, dinguyen@opensource.altera.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Tue 2014-09-09 17:02:34, Arnd Bergmann wrote:
> On Tuesday 09 September 2014 16:17:56 Pavel Machek wrote:
> > > Jaehoon Chung (1):
> > >       ARM: dts: socfpga: unuse the slot-node and deprecate the supports-highspeed for dw-mmc
> > > 
> > 
> > This patch is a bad idea. It removes support for two mmc cards on a
> > single controller -- configuration hardware supports and configuration
> > that allows using u-SD card on mcvevk board.
> > 
> 
> Your objection comes too late, and to the wrong patch, since the
> driver and all other users have already been changed. We had a long
> discussion about this when the issue first came up, and we could
> not find any example of dw-mmc actually being used in a scenario
> with one controller that has multiple devices attached.

Well, this is not first time I raised this. 3.17 is not yet out, so we
still have chance to fix regressions without major fuss.

> Apparently every user out there instead uses multiple controller
> instances instead. Are you sure that the socfpga implementation
> is an exception from this?

Marek Vasut has the hardware. His board apprently has uSD and eMMC,
and I believe it has just one controller. I'll try to get details.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
