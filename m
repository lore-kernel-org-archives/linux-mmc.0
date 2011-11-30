From: James Hogan <james@albanarts.com>
Subject: Re: [PATCH 1/1] mmc:Support of PCI mode for the dw_mmc driver
Date: Wed, 30 Nov 2011 21:49:50 +0000
Message-ID: <20111130214950.GA25968@balrog>
References: <1322656585-8363-1-git-send-email-shashidharh@vayavyalabs.com>
 <4ED63861.7030607@imgtec.com>
 <CANYdXnr1+gNmE0nTf0BOHMFZnwsJgYKk8ZcAJqdutDTx25gnWQ@mail.gmail.com>
 <4ED64EAB.4050405@imgtec.com>
 <CANYdXnrfr26BbsgypmxUDka7w9K7BUB-4b_tPSPKxh-2B3Ah8A@mail.gmail.com>
 <CANYdXnqgnvf5XnQ=dcuAu7C2WBNTMjJODqsgYB807OPTtROF+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:39732 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032Ab1K3VuA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2011 16:50:00 -0500
Received: by eeuu47 with SMTP id u47so674676eeu.19
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2011 13:49:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANYdXnqgnvf5XnQ=dcuAu7C2WBNTMjJODqsgYB807OPTtROF+A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: James Hogan <james.hogan@imgtec.com>, Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Philip Rakity <prakity@marvell.com>, "Mark F. Brown" <mark.brown314@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org

On Wed, Nov 30, 2011 at 11:50:31PM +0530, Shashidhar Hiremath wrote:
> Hi James,
>   For some reason I was unable to reproduce the errors during compila=
tion.
>   Can you send me one instance of the error ?

  CC [M]  drivers/mmc/host/dw_mmc.o
drivers/mmc/host/dw_mmc.c: In function =E2=80=98dw_mci_start_command=E2=
=80=99:
drivers/mmc/host/dw_mmc.c:272:2: warning: passing argument 2 of =E2=80=98=
dev_printk=E2=80=99 from incompatible pointer type [enabled by default]
include/linux/device.h:788:12: note: expected =E2=80=98const struct dev=
ice *=E2=80=99 but argument is of type =E2=80=98struct device **=E2=80=99
drivers/mmc/host/dw_mmc.c: In function =E2=80=98dw_mci_submit_data_dma=E2=
=80=99:
drivers/mmc/host/dw_mmc.c:466:2: warning: passing argument 1 of =E2=80=98=
dma_map_sg_attrs=E2=80=99 from incompatible pointer type [enabled by de=
fault]
include/asm-generic/dma-mapping-common.h:41:19: note: expected =E2=80=98=
struct device *=E2=80=99 but argument is of type =E2=80=98struct device=
 **=E2=80=99
drivers/mmc/host/dw_mmc.c:469:2: warning: passing argument 2 of =E2=80=98=
dev_printk=E2=80=99 from incompatible pointer type [enabled by default]
include/linux/device.h:788:12: note: expected =E2=80=98const struct dev=
ice *=E2=80=99 but argument is of type =E2=80=98struct device **=E2=80=99
drivers/mmc/host/dw_mmc.c: In function =E2=80=98dw_mci_request_end=E2=80=
=99:
drivers/mmc/host/dw_mmc.c:807:3: warning: passing argument 2 of =E2=80=98=
dev_printk=E2=80=99 from incompatible pointer type [enabled by default]
include/linux/device.h:788:12: note: expected =E2=80=98const struct dev=
ice *=E2=80=99 but argument is of type =E2=80=98struct device **=E2=80=99
drivers/mmc/host/dw_mmc.c:812:3: warning: passing argument 2 of =E2=80=98=
dev_printk=E2=80=99 from incompatible pointer type [enabled by default]
include/linux/device.h:788:12: note: expected =E2=80=98const struct dev=
ice *=E2=80=99 but argument is of type =E2=80=98struct device **=E2=80=99
drivers/mmc/host/dw_mmc.c: In function =E2=80=98dw_mci_tasklet_func=E2=80=
=99:
drivers/mmc/host/dw_mmc.c:947:7: warning: passing argument 1 of =E2=80=98=
dev_err=E2=80=99 from incompatible pointer type [enabled by default]
include/linux/device.h:797:12: note: expected =E2=80=98const struct dev=
ice *=E2=80=99 but argument is of type =E2=80=98struct device **=E2=80=99
drivers/mmc/host/dw_mmc.c: In function =E2=80=98dw_mci_init_slot=E2=80=99=
:
drivers/mmc/host/dw_mmc.c:1654:37: warning: passing argument 2 of =E2=80=
=98mmc_alloc_host=E2=80=99 from incompatible pointer type [enabled by d=
efault]
include/linux/mmc/host.h:333:25: note: expected =E2=80=98struct device =
*=E2=80=99 but argument is of type =E2=80=98struct device **=E2=80=99
drivers/mmc/host/dw_mmc.c: In function =E2=80=98dw_mci_init_dma=E2=80=99=
:
drivers/mmc/host/dw_mmc.c:1761:8: warning: passing argument 1 of =E2=80=
=98dma_alloc_coherent=E2=80=99 from incompatible pointer type [enabled =
by default]
/home/james/src/kernel/linux/arch/x86/include/asm/dma-mapping.h:115:1: =
note: expected =E2=80=98struct device *=E2=80=99 but argument is of typ=
e =E2=80=98struct device **=E2=80=99
drivers/mmc/host/dw_mmc.c:1764:4: warning: passing argument 1 of =E2=80=
=98dev_err=E2=80=99 from incompatible pointer type [enabled by default]
include/linux/device.h:797:12: note: expected =E2=80=98const struct dev=
ice *=E2=80=99 but argument is of type =E2=80=98struct device **=E2=80=99
drivers/mmc/host/dw_mmc.c:1780:5: warning: passing argument 1 of =E2=80=
=98dev_err=E2=80=99 from incompatible pointer type [enabled by default]
include/linux/device.h:797:12: note: expected =E2=80=98const struct dev=
ice *=E2=80=99 but argument is of type =E2=80=98struct device **=E2=80=99
drivers/mmc/host/dw_mmc.c:1784:3: warning: passing argument 1 of =E2=80=
=98dev_err=E2=80=99 from incompatible pointer type [enabled by default]
include/linux/device.h:797:12: note: expected =E2=80=98const struct dev=
ice *=E2=80=99 but argument is of type =E2=80=98struct device **=E2=80=99
drivers/mmc/host/dw_mmc.c:1792:2: warning: passing argument 1 of =E2=80=
=98_dev_info=E2=80=99 from incompatible pointer type [enabled by defaul=
t]
include/linux/device.h:803:12: note: expected =E2=80=98const struct dev=
ice *=E2=80=99 but argument is of type =E2=80=98struct device **=E2=80=99
drivers/mmc/host/dw_mmc.c: In function =E2=80=98dw_mci_probe=E2=80=99:
drivers/mmc/host/dw_mmc.c:1825:4: warning: passing argument 1 of =E2=80=
=98dev_err=E2=80=99 from incompatible pointer type [enabled by default]
include/linux/device.h:797:12: note: expected =E2=80=98const struct dev=
ice *=E2=80=99 but argument is of type =E2=80=98struct device **=E2=80=99
drivers/mmc/host/dw_mmc.c:1831:4: warning: passing argument 1 of =E2=80=
=98dev_err=E2=80=99 from incompatible pointer type [enabled by default]
include/linux/device.h:797:12: note: expected =E2=80=98const struct dev=
ice *=E2=80=99 but argument is of type =E2=80=98struct device **=E2=80=99
drivers/mmc/host/dw_mmc.c:1837:4: warning: passing argument 1 of =E2=80=
=98dev_err=E2=80=99 from incompatible pointer type [enabled by default]
include/linux/device.h:797:12: note: expected =E2=80=98const struct dev=
ice *=E2=80=99 but argument is of type =E2=80=98struct device **=E2=80=99
drivers/mmc/host/dw_mmc.c:1878:2: warning: passing argument 1 of =E2=80=
=98mci_wait_reset=E2=80=99 from incompatible pointer type [enabled by d=
efault]
drivers/mmc/host/dw_mmc.c:1797:13: note: expected =E2=80=98struct devic=
e *=E2=80=99 but argument is of type =E2=80=98struct device **=E2=80=99
drivers/mmc/host/dw_mmc.c:1921:24: error: =E2=80=98struct dw_mci=E2=80=99=
 has no member named =E2=80=98irq=E2=80=99
drivers/mmc/host/dw_mmc.c:1944:2: error: =E2=80=98pdev=E2=80=99 undecla=
red (first use in this function)
drivers/mmc/host/dw_mmc.c:1944:2: note: each undeclared identifier is r=
eported only once for each function it appears in
drivers/mmc/host/dw_mmc.c:1961:2: error: =E2=80=98struct dw_mci=E2=80=99=
 has no member named =E2=80=98irq=E2=80=99
drivers/mmc/host/dw_mmc.c:1961:2: warning: passing argument 1 of =E2=80=
=98_dev_info=E2=80=99 from incompatible pointer type [enabled by defaul=
t]
include/linux/device.h:803:12: note: expected =E2=80=98const struct dev=
ice *=E2=80=99 but argument is of type =E2=80=98struct device **=E2=80=99
drivers/mmc/host/dw_mmc.c:1966:3: warning: passing argument 1 of =E2=80=
=98_dev_info=E2=80=99 from incompatible pointer type [enabled by defaul=
t]
include/linux/device.h:803:12: note: expected =E2=80=98const struct dev=
ice *=E2=80=99 but argument is of type =E2=80=98struct device **=E2=80=99
drivers/mmc/host/dw_mmc.c:1977:15: error: =E2=80=98struct dw_mci=E2=80=99=
 has no member named =E2=80=98irq=E2=80=99
drivers/mmc/host/dw_mmc.c:1986:6: warning: passing argument 1 of =E2=80=
=98dma_free_coherent=E2=80=99 from incompatible pointer type [enabled b=
y default]
/home/james/src/kernel/linux/arch/x86/include/asm/dma-mapping.h:142:20:=
 note: expected =E2=80=98struct device *=E2=80=99 but argument is of ty=
pe =E2=80=98struct device **=E2=80=99
drivers/mmc/host/dw_mmc.c: In function =E2=80=98dw_mci_remove=E2=80=99:
drivers/mmc/host/dw_mmc.c:2004:3: warning: passing argument 2 of =E2=80=
=98dev_printk=E2=80=99 from incompatible pointer type [enabled by defau=
lt]
include/linux/device.h:788:12: note: expected =E2=80=98const struct dev=
ice *=E2=80=99 but argument is of type =E2=80=98struct device **=E2=80=99
drivers/mmc/host/dw_mmc.c:2013:15: error: =E2=80=98struct dw_mci=E2=80=99=
 has no member named =E2=80=98irq=E2=80=99
drivers/mmc/host/dw_mmc.c:2015:2: warning: passing argument 1 of =E2=80=
=98dma_free_coherent=E2=80=99 from incompatible pointer type [enabled b=
y default]
/home/james/src/kernel/linux/arch/x86/include/asm/dma-mapping.h:142:20:=
 note: expected =E2=80=98struct device *=E2=80=99 but argument is of ty=
pe =E2=80=98struct device **=E2=80=99
drivers/mmc/host/dw_mmc.c: In function =E2=80=98dw_mci_resume=E2=80=99:
drivers/mmc/host/dw_mmc.c:2069:2: warning: passing argument 1 of =E2=80=
=98mci_wait_reset=E2=80=99 from incompatible pointer type [enabled by d=
efault]
drivers/mmc/host/dw_mmc.c:1797:13: note: expected =E2=80=98struct devic=
e *=E2=80=99 but argument is of type =E2=80=98struct device **=E2=80=99

>=20
> On Wed, Nov 30, 2011 at 9:31 PM, Shashidhar Hiremath
> <shashidharh@vayavyalabs.com> wrote:
> > On Wed, Nov 30, 2011 at 9:11 PM, James Hogan <james.hogan@imgtec.co=
m> wrote:
> >> Hi,
> >>
> >> On 11/30/2011 03:27 PM, Shashidhar Hiremath wrote:
> >>> Hi James,
> >>> =C2=A0 Sorry for the minor alignment issues.Will fix them .
> >>
> >> Thanks
> >>
> >>> I actually did
> >>> compile the code but as separate driver not along with the kernel=
=2E In
> >>> fact, I have also tested the PCI patch ,but not as separate files=
 but
> >>> with the earlier #ifdef method =C2=A0I had sent in initial patch =
=2E
> >>
> >> But the new patch was completely different, you can't just rework =
the
> >> entire patch and expect it to compile and work without at least tr=
ying
> >> it to make sure, as evidenced by the fact that with mmc_next + you=
r
> >> patch, I get:
> >> dw_mmc.c: 7 errors, 22 warnings
> >> dw_mmc-pci.c: 2 errors
> >> dw_mmc-pltfm.c: 6 errors, 1 warning
> >>
> > ohh,
> > will compile and fix it
> >> Cheers
> >> James
> >>
> >>> On Wed, Nov 30, 2011 at 7:36 PM, James Hogan <james.hogan@imgtec.=
com> wrote:
> >>>> *sigh* You haven't actually tried compiling this have you? How d=
o you
> >>>> know whether it works or not? You really really should at least =
make
> >>>> sure it compiles (for simple changes) and works without breaking
> >>>> anything (for anything non-trivial like adding support for a new=
 bus
> >>>> like PCI)!
> >>
> >>
> >
> >
> >
> > --
> > regards,
> > Shashidhar Hiremath
>=20
>=20
>=20
> --=20
> regards,
> Shashidhar Hiremath
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
