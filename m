From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/5] mmc: omap_hsmmc: Enable omap_hsmmc for Keystone 2
Date: Thu, 22 Oct 2015 15:32:38 +0200
Message-ID: <CAPDyKFr+Nj510TC=J1oswSAxX++fAu=LLWjytcMx1vBeHA7VTA@mail.gmail.com>
References: <1445377809-12516-1-git-send-email-fcooper@ti.com>
	<1445377809-12516-2-git-send-email-fcooper@ti.com>
	<CAPDyKFr6qt60gECs5y=Qq6XbFhiqWGrOcMozB4vNwaR8PHnu4A@mail.gmail.com>
	<20151022105841.GR32532@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151022105841.GR32532@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Franklin S Cooper Jr <fcooper@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>, Muralidharan Karicheri <m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>
List-Id: linux-mmc@vger.kernel.org

On 22 October 2015 at 12:58, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Oct 22, 2015 at 11:28:55AM +0200, Ulf Hansson wrote:
>> On 20 October 2015 at 23:50, Franklin S Cooper Jr <fcooper@ti.com> wrote:
>> >
>> > From: Lokesh Vutla <lokeshvutla@ti.com>
>> >
>> > Enable omap_hsmmc for Keystone 2 architecture which reuses the HSMMC
>> > IP found on OMAP platforms.
>> >
>> > Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>> > ---
>> >  drivers/mmc/host/Kconfig | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> > index 8a1e349..2ccec71 100644
>> > --- a/drivers/mmc/host/Kconfig
>> > +++ b/drivers/mmc/host/Kconfig
>> > @@ -366,7 +366,7 @@ config MMC_OMAP
>> >  config MMC_OMAP_HS
>> >         tristate "TI OMAP High Speed Multimedia Card Interface support"
>> >         depends on HAS_DMA
>> > -       depends on ARCH_OMAP2PLUS || COMPILE_TEST
>> > +       depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || COMPILE_TEST
>>
>> How about:
>> "depends on ARM || COMPILE_TEST"
>
> I'd much prefer the former actually - it's already hard enough to use
> the config tools with the kernel due to the number of silly options
> being presented, there's no need to make it worse.
>
> In fact, I'd like to see more of the former (provided done sensibly)
> to reduce the number of config options seen for configurations to cut
> down on the shere noise of useless options.  For example, if I've
> decided I don't want to support TI OMAP platforms, then I shouldn't
> be offered the TI OMAP MMC driver.

Okay, fair enough and I don't have any strong opinions around this.

I queued up the patch for next, thanks!

Kind regards
Uffe
