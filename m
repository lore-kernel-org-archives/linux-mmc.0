From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/5] MMC: mmci: Provide bindings for Device Tree
Date: Thu, 15 Mar 2012 20:58:30 +0000
Message-ID: <201203152058.31398.arnd@arndb.de>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
 <201203151532.44363.arnd@arndb.de>
 <CAFEEs1=TJaCYmaWd7zd28NsV8ubZBpBn7p=Mi7vGtmV_vpfh1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAFEEs1=TJaCYmaWd7zd28NsV8ubZBpBn7p=Mi7vGtmV_vpfh1w@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Per Forlin <per.forlin@stericsson.com>
Cc: niklas.hernaeus@linaro.org, linux-mmc@vger.kernel.org, cjb@laptop.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Thursday 15 March 2012, Per Forlin wrote:
> On Thu, Mar 15, 2012 at 4:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 15 March 2012, Lee Jones wrote:
> >> > I would like to see what the minimal required change is to support DT
> >> > for mmci without factorization.
> >> > 1. Minimal change in mmci.
> >> > 2. Add mmci_dt.c which contains the DT-populate code.
> >> >
> >> > The factorization could be done as step 2 I think.
> >> >
> >> > What do you say?
> >>
> >> I'm wondering what the difference is as the work has already been done.
> >>
> >> It was Arnd's suggestion to separate out the two types of variants, and
> >> I'm quite fond of the new (fully featured) layout.
> >
> > Right, I usually prefer cleanups or other refactoring to be done first, and
> > then features added on top.
> >
> > You could in theory add have just patches 3/4/5 all applied without
> > the refactoring, but that I would be worried that this causes dependencies
> > between the mmci driver and ux500 specific functionality like the
> > stedma40_filter function.
> >
> About DT
> I think I need to catch up on the DT-design a bit. I will try to catch
> up on the DT-implementation and maybe then the refactorization will
> make sense to me :)
> 
> Board specific data in mmci-driver
> The stedma40 filter function is not really specific for ux500. ux500
> use stedma40 but it should be possible to replace this DMA.IP with
> some other DMA-controller. This is board specific configuration. You
> should not need to change the mmci-driver just because the dma-driver
> has changed, right?
> Or will the board-configuration now be placed in mmci-ux500?

Right, the DMA configuration does not really belong in there, but
the voltage setup might (unless we convert that to the regulator
setup).

> Common DT populate code for all mmc host drivers
> Some parts of the DT-population is common for all the host driver, for
> instance setting the CAP and CAP2. This code should be moved to a
> common place to be used by other host drivers as well.

Good idea, yes. We should also have a generic mmc binding document
that describes how to set flags like 8-bit mode. We already have
two conflicting variants in .dts files and we should make sure
we bring everybody back together here.

> About refactoring
> There are numbers of patches stashed up for MMCI waiting for verdict
> here http://git.kernel.org/?p=linux/kernel/git/linusw/linux-stericsson.git;a=shortlog;h=refs/heads/mmci.
> If doing a refactorization please rebase it on top of these patches.
> This needs to be done carefully, there may be more to considerations
> than just DT. Maybe the timing is better to do this for 4.5, just
> after 4.4 is closed. Then we can make sure that all new patches are
> made on top of the refactorized base.

Yes, thanks for the info. Doing this for 3.4 is definitely out of the
question then, and hopefully we can use the new dma bindings when it's
done for 3.5

	Arnd
