From: Pavel Machek <pavel@denx.de>
Subject: Re: [PATCHv10 0/5] ARM: remove the sub-node and deprecate
 supports-highspeed property for dwmmc.
Date: Mon, 25 Aug 2014 13:37:19 +0200
Message-ID: <20140825113719.GA31960@amd>
References: <1407397082-32495-1-git-send-email-jh80.chung@samsung.com>
 <20140825112151.GA21336@amd>
 <53FB1DD5.3050207@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53FB1DD5.3050207@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, kgene.kim@samsung.com, heiko@sntech.de, tgih.jun@samsung.com, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, linux-samsung-soc@vger.kernel.org, dinguyen@altera.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Mon 2014-08-25 20:28:21, Jaehoon Chung wrote:
> On 08/25/2014 08:21 PM, Pavel Machek wrote:
> > On Thu 2014-08-07 16:37:57, Jaehoon Chung wrote:
> >> Since used the mmc_of_parse(), didn't parse the sub-node.
> >> So we can remove the sub-node, because almost SoC used the only one card per a host.
> >> And supports-highspeed can be replaced with "cap-mmc/sd-highspeed"
> >> property.
> > 
> > Would it be better to fix parsing of the device tree, and not to
> > change all the device trees?
> > 
> > Someone will want to do two slots sooner or later...
> > 
> 
> First, I had considered that controller can be supported the multiple slot.
> But MMC maintainers and other people suggested that consider the only one card per a host.
> Two slots or more don't have any benefit, (power or performance, etc).

Would you elaborate?

If I have a device like a phone, I may want to put one "slot" inside
phone for basic system, and offer second slot for user expansion
(initially empty).

Or I may want to have internal slot with a card to boot from and have
external slot (initially empty) for system update for embedded system.

I see quite an obvious benefit there.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
