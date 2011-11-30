From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: [PATCH 1/1] mmc:Support of PCI mode for the dw_mmc driver
Date: Wed, 30 Nov 2011 20:57:31 +0530
Message-ID: <CANYdXnr1+gNmE0nTf0BOHMFZnwsJgYKk8ZcAJqdutDTx25gnWQ@mail.gmail.com>
References: <1322656585-8363-1-git-send-email-shashidharh@vayavyalabs.com>
	<4ED63861.7030607@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38132 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754456Ab1K3P1c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2011 10:27:32 -0500
Received: by iage36 with SMTP id e36so905494iag.19
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2011 07:27:32 -0800 (PST)
In-Reply-To: <4ED63861.7030607@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Philip Rakity <prakity@marvell.com>, "Mark F. Brown" <mark.brown314@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org

Hi James,
  Sorry for the minor alignment issues.Will fix them . I actually did
compile the code but as separate driver not along with the kernel. In
fact, I have also tested the PCI patch ,but not as separate files but
with the earlier #ifdef method  I had sent in initial patch .

On Wed, Nov 30, 2011 at 7:36 PM, James Hogan <james.hogan@imgtec.com> w=
rote:
> Hi,
>
> *sigh* You haven't actually tried compiling this have you? How do you
> know whether it works or not? You really really should at least make
> sure it compiles (for simple changes) and works without breaking
> anything (for anything non-trivial like adding support for a new bus
> like PCI)!
>
> Couple of other minor things below.
>
> On 11/30/2011 12:36 PM, Shashidhar Hiremath wrote:
>> Support of PCI mode for the dw_mmc driver. This Patch adds the
>> support for the scenario where the Synopsys Designware IP
>> is present on the PCI bus. The patch adds the minimal modifications
>> necessary for the driver to work on PCI platform. Also added separat=
e
>> files for PCI and PLATFORM modes of operation.
>>
>> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
>> ---
>> v2:
>> *As per Suggestions by Will Newton and James Hogan
>> -Reduced the number of ifdefs
>> v3:
>> *As per Suggestions by Will Newton and James Hogan
>> -Added separate files for PCI and PLATFORM Modes similar to SDHCI dr=
iver
>> v4:
>> *As per Suggestions by James Hogan
>> -Fixed Indentation Issue.
>> -Added Proper error Handling for probe and remove sequences.
>> -Modified location of some code.
>> -Added isr_flags to dw_mmc.h and removed the ifdef PCI from driver.
>>
>> =C2=A0drivers/mmc/host/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 2=
3 ++++++
>> =C2=A0drivers/mmc/host/dw_mmc-pci.c =C2=A0 | =C2=A0158 +++++++++++++=
++++++++++++++++++++++++++
>> =C2=A0drivers/mmc/host/dw_mmc-pltfm.c | =C2=A0134 ++++++++++++++++++=
+++++++++++++++
>> =C2=A0drivers/mmc/host/dw_mmc.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0151 +++=
++++++++++------------------------
>> =C2=A0drivers/mmc/host/dw_mmc.h =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
7 ++
>> =C2=A0include/linux/mmc/dw_mmc.h =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0=
6 +-
>> =C2=A06 files changed, 377 insertions(+), 102 deletions(-)
>> =C2=A0create mode 100644 drivers/mmc/host/dw_mmc-pci.c
>> =C2=A0create mode 100644 drivers/mmc/host/dw_mmc-pltfm.c
>>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index 87d5067..2d8fad6 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -534,6 +534,29 @@ config MMC_DW_IDMAC
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Designware Mobile Storage IP block. This=
 disables the external DMA
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 interface.
>>
>> +config MMC_DW_PCI
>> + =C2=A0 =C2=A0 tristate "Synopsys Designware MCI support on PCI bus=
"
>> + =C2=A0 =C2=A0 depends on MMC_DW && PCI
>> + =C2=A0 =C2=A0 help
>> + =C2=A0 =C2=A0 =C2=A0 This selects the PCI bus for the Synopsys Des=
ignware Mobile Storage IP.
>> + =C2=A0 =C2=A0 =C2=A0 Select this option if the IP is present on PC=
I platform.
>> +
>> + =C2=A0 =C2=A0 =C2=A0 If you have a controller with this interface,=
 say Y or M here.
>> +
>> + =C2=A0 =C2=A0 =C2=A0 If unsure, say N.
>> +
>> +config MMC_DW_PLTFM
>> + =C2=A0 =C2=A0 tristate "platform driver helper for Synopsys Design=
ware Mobile Storage IP"
>
> It would be nice if this followed the same pattern as MMC_DW_PCI, i.e=
=2E
> something like "Synopsys DesignWare MCI support as platform device"
> (makes it look nicer on the menu :) ).
>
> Presuming this is the more common case, it might make sense for it to=
 be
> default y too (the driver cannot be used by default until one or both=
 of
> these options has been selected).
>
>> + =C2=A0 =C2=A0 depends on MMC_DW
>> + =C2=A0 =C2=A0 help
>> + =C2=A0 =C2=A0 =C2=A0 This selects the common helper functions supp=
ort for Host Controller
>> + =C2=A0 =C2=A0 =C2=A0 Interface based platform driver.Please select=
 this option if the IP
>> + =C2=A0 =C2=A0 =C2=A0 is present as a platform device.
>> +
>> + =C2=A0 =C2=A0 =C2=A0 If you have a controller with this interface,=
 say Y or M here.
>> +
>> + =C2=A0 =C2=A0 =C2=A0 If unsure, say N.
>> +
>> =C2=A0config MMC_SH_MMCIF
>> =C2=A0 =C2=A0 =C2=A0 tristate "SuperH Internal MMCIF support"
>> =C2=A0 =C2=A0 =C2=A0 depends on MMC_BLOCK && (SUPERH || ARCH_SHMOBIL=
E)
>
> <snip>
>
>> +static int dw_mci_pltfm_probe(struct platform_device *pdev)
>> +{
>> + =C2=A0 =C2=A0 struct dw_mci *host;
>> + =C2=A0 =C2=A0 struct resource *regs;
>> + =C2=A0 =C2=A0 int =C2=A0ret;
>> +
>> + =C2=A0 =C2=A0 host =3D kzalloc(sizeof(struct dw_mci), GFP_KERNEL);
>> + =C2=A0 =C2=A0 if (!host)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
>> +
>> + =C2=A0 =C2=A0 regs =3D platform_get_resource(pdev, IORESOURCE_MEM,=
 0);
>> + =C2=A0 =C2=A0 if (!regs) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENXIO;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_free;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 host->irq =3D platform_get_irq(pdev, 0);
>> + =C2=A0 =C2=A0 if (host->irq < 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D host->irq;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_free;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 host->dev =3D pdev->dev;
>> + =C2=A0 =C2=A0 host->irq_flags =3D 0;
>> + =C2=A0 =C2=A0 host->pdata =3D pdev->dev.platform_data;
>> + =C2=A0 =C2=A0 ret =3D -ENOMEM;
>> + =C2=A0 =C2=A0 host->regs =3D ioremap(regs->start, resource_size(re=
gs));
>> + =C2=A0 =C2=A0 if (!host->regs)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_free;
>> + =C2=A0 =C2=A0 platform_set_drvdata(pdev, host);
>> + =C2=A0 =C2=A0 ret =3D dw_mci_probe(host);
>> + =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_out;
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
>> +err_out:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iounmap(host->regs);
>> +err_free:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(host);
>
> alignment needs fixing here. There's no need for the else either.
>
> Thanks
> James
>



--=20
regards,
Shashidhar Hiremath
