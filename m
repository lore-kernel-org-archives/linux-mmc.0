From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Onboard SD card doesn't work anymore after the 'mmc-v5.4-2'
 updates
Date: Mon, 28 Oct 2019 19:45:34 +1100
Message-ID: <47e67f44f5e955108759fe32400d2622c4a5ba3f.camel@kernel.crashing.org>
References: <7b549219-a2e1-08c7-331b-9c3e4fdb8a8f@xenosoft.de>
 <3aeae0d8-e9be-2585-cbbd-70263cb495f1@xenosoft.de>
 <20191015125105.GU25745@shell.armlinux.org.uk>
 <5611f3bc-68aa-78ec-182a-1cb414202314@xenosoft.de>
 <20191015131750.GV25745@shell.armlinux.org.uk>
 <87muds586t.fsf@mpe.ellerman.id.au>
 <31d58f086f964937b27209bc18b334d9c9791767.camel@kernel.crashing.org>
 <CAL_JsqJpFy-g3earNjZs7jANx4pyRd=CDvZN3emMdXL5YNkYHQ@mail.gmail.com>
 <20191023143159.GB25745@shell.armlinux.org.uk>
 <CAL_JsqLZV1sXc053QMLcV-dV1BbGcRtX3eu1zbtNA_N3hzQE4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <CAL_JsqLZV1sXc053QMLcV-dV1BbGcRtX3eu1zbtNA_N3hzQE4g@mail.gmail.com>
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
To: Rob Herring <robh+dt@kernel.org>, Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, mad skateman <madskateman@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, "R.T.Dickinson" <rtd2@xtra.co.nz>, Christian Zigotzky <chzigotzky@xenosoft.de>, "contact@a-eon.com" <contact@a-eon.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Christian Zigotzky <info@xenosoft.de>
List-Id: linux-mmc@vger.kernel.org

On Fri, 2019-10-25 at 17:28 -0500, Rob Herring wrote:
> This doesn't work?:
> 
>         if (IS_ENABLED(CONFIG_PPC) || of_dma_is_coherent(dev-
> >of_node))
>                 value |= ESDHC_DMA_SNOOP;
>         else
>                 value &= ~ESDHC_DMA_SNOOP;

CONFIG_PPC is restrictive. What about sparc64 ? There could be others
.. .we can't suddenly requests people to add new properties for what
was implied behaviours before hand, esp since it's not in the base 1275
spec, no ?

I would suggest of_dma_is_coherent is *true* by default unless
overriden to do something else.

Cheers,
Ben.
