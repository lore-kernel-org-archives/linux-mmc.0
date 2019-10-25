From: Rob Herring <robh+dt@kernel.org>
Subject: Re: Onboard SD card doesn't work anymore after the 'mmc-v5.4-2'
 updates
Date: Fri, 25 Oct 2019 17:28:45 -0500
Message-ID: <CAL_JsqLZV1sXc053QMLcV-dV1BbGcRtX3eu1zbtNA_N3hzQE4g@mail.gmail.com>
References: <7b549219-a2e1-08c7-331b-9c3e4fdb8a8f@xenosoft.de>
 <3aeae0d8-e9be-2585-cbbd-70263cb495f1@xenosoft.de>
 <20191015125105.GU25745@shell.armlinux.org.uk>
 <5611f3bc-68aa-78ec-182a-1cb414202314@xenosoft.de>
 <20191015131750.GV25745@shell.armlinux.org.uk>
 <87muds586t.fsf@mpe.ellerman.id.au>
 <31d58f086f964937b27209bc18b334d9c9791767.camel@kernel.crashing.org>
 <CAL_JsqJpFy-g3earNjZs7jANx4pyRd=CDvZN3emMdXL5YNkYHQ@mail.gmail.com>
 <20191023143159.GB25745@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20191023143159.GB25745@shell.armlinux.org.uk>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, mad skateman <madskateman@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, "R.T.Dickinson" <rtd2@xtra.co.nz>, Christian Zigotzky <chzigotzky@xenosoft.de>, "contact@a-eon.com" <contact@a-eon.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Christian Zigotzky <info@xenosoft.de>
List-Id: linux-mmc@vger.kernel.org

On Wed, Oct 23, 2019 at 9:32 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Wed, Oct 23, 2019 at 08:52:33AM -0500, Rob Herring wrote:
> > > I think this should have been done the other way around and default to
> > > coherent since most traditional OF platforms are coherent, and you
> > > can't just require those DTs to change.
> >
> > You can blame me. This was really only intended for cases where
> > coherency is configurable on a per peripheral basis and can't be
> > determined in other ways.
> >
> > The simple solution here is simply to use the compatible string for
> > the device to determine coherent or not.
>
> It really isn't that simple.

This doesn't work?:

        if (IS_ENABLED(CONFIG_PPC) || of_dma_is_coherent(dev->of_node))
                value |= ESDHC_DMA_SNOOP;
        else
                value &= ~ESDHC_DMA_SNOOP;

While I said use the compatibles, using the kconfig symbol is easier
than sorting out which compatibles are PPC SoCs. Though if that's
already done elsewhere in the driver, you could set a flag and use
that here. I'd be surprised if this was the only difference between
ARM and PPC SoCs for this block.

> There are two aspects to coherency, both of which must match:
>
> 1) The configuration of the device
> 2) The configuration of the kernel's DMA API
>
> (1) is controlled by the driver, which can make the decision any way
> it pleases.
>
> (2) on ARM64 is controlled depending on whether or not "dma-coherent"
> is specified in the device tree, since ARM64 can have a mixture of
> DMA coherent and non-coherent devices.
>
> A mismatch between (1) and (2) results in data corruption, potentially
> eating your filesystem.  So, it's very important that the two match.
>
> These didn't match for the LX2160A, but, due to the way CMA was working,
> we sort of got away with it, but it was very dangerous as far as data
> safety went.
>
> Then, a change to CMA happened which moved where it was located, which
> caused a regression.  Reverting the CMA changes didn't seem to be an
> option, so another solution had to be found.
>
> I started a discussion on how best to solve this:
>
> https://archive.armlinux.org.uk/lurker/thread/20190919.041320.1e53541f.en.html
>
> and the solution that the discussion came out with was the one that has
> been merged - which we now know caused a regression on PPC.
>
> Using compatible strings doesn't solve the issue: there is no way to
> tell the DMA API from the driver that the device is coherent.  The
> only way to do that is via the "dma-coherent" property in DT on ARM64.
>
> To say that this is a mess is an under-statement, but we seem to have
> ended up here because of a series of piece-meal changes that don't seem
> to have been thought through enough.
>
> So, what's the right way to solve this, and ensure that the DMA API and
> device match as far as their coherency expectations go?  Revert all the
> changes for sdhci-of-esdhc and CMA back to 5.0 or 5.1 state?

The other option is similar to earlier in the thread and just add to
of_dma_is_coherent():

/* Powerpc is normally cache coherent DMA */
if (IS_ENABLED(CONFIG_PPC) && !IS_ENABLED(CONFIG_NOT_COHERENT_CACHE))
    return true;

We could do the all the weak arch hooks, but that seems like overkill
to me at this point.

Rob
