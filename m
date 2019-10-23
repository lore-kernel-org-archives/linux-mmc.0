From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Onboard SD card doesn't work anymore after the 'mmc-v5.4-2'
 updates
Date: Wed, 23 Oct 2019 17:41:24 +1100
Message-ID: <31d58f086f964937b27209bc18b334d9c9791767.camel@kernel.crashing.org>
References: <7b549219-a2e1-08c7-331b-9c3e4fdb8a8f@xenosoft.de>
 <3aeae0d8-e9be-2585-cbbd-70263cb495f1@xenosoft.de>
 <20191015125105.GU25745@shell.armlinux.org.uk>
 <5611f3bc-68aa-78ec-182a-1cb414202314@xenosoft.de>
 <20191015131750.GV25745@shell.armlinux.org.uk>
 <87muds586t.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <87muds586t.fsf@mpe.ellerman.id.au>
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
To: Michael Ellerman <mpe@ellerman.id.au>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Christian Zigotzky <chzigotzky@xenosoft.de>, Paul Mackerras <paulus@samba.org>
Cc: ulf.hansson@linaro.org, "R.T.Dickinson" <rtd2@xtra.co.nz>, linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, "contact@a-eon.com" <contact@a-eon.com>, mad skateman <madskateman@gmail.com>, linuxppc-dev@lists.ozlabs.org, Christian Zigotzky <info@xenosoft.de>
List-Id: linux-mmc@vger.kernel.org

On Wed, 2019-10-23 at 16:42 +1100, Michael Ellerman wrote:
> 
> Right, it seems of_dma_is_coherent() has baked in the assumption that
> devices are non-coherent unless explicitly marked as coherent.
> 
> Which is wrong on all or at least most existing powerpc systems
> according to Ben.

This is probably broken on sparc(64) as well and whatever else uses
DT and is an intrinsicly coherent architecture (did we ever have
DT enabled x86s ? Wasn't OLPC such a beast ?).

I think this should have been done the other way around and default to
coherent since most traditional OF platforms are coherent, and you
can't just require those DTs to change.

> > Any ideas from the PPC maintainers?
> 
> Fixing it at the source seems like the best option to prevent future
> breakage.
> 
> So I guess that would mean making of_dma_is_coherent() return true/false
> based on CONFIG_NOT_COHERENT_CACHE on powerpc.
> 
> We could do it like below, which would still allow the dma-coherent
> property to work if it ever makes sense on a future powerpc platform.
> 
> I don't really know any of this embedded stuff well, so happy to take
> other suggestions on how to handle this mess.
