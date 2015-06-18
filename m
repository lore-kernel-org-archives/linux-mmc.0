From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH v2] mmc: core: Do not set mmc voltage to 1.8V when
 'no-1-8-v' is present
Date: Thu, 18 Jun 2015 22:25:31 +0800
Message-ID: <20150618142530.GB2383@shlinux1.ap.freescale.net>
References: <1434227067-9600-1-git-send-email-festevam@gmail.com>
 <CAPDyKFq29S3K0sxCkUHO=QO0MqM0PskcjoM62EZysNc19SxP6w@mail.gmail.com>
 <CAOMZO5CSvYHNwmeRsSJ+KYfAkisX+_2DePawd6AWHP-ANErq5Q@mail.gmail.com>
 <CAOMZO5Amb9hR=DOxd_wynwqc3Dfo0rLfdJS-dkKiOqB89PyMwQ@mail.gmail.com>
 <CAPDyKFotVdm5vDwjqUw=cD9jmRU86ZBbq1c-qmiFa4Yj2JivxQ@mail.gmail.com>
 <CAOMZO5Aq-aTjQ1rddBJcrJ56jRV1Q=dLgK5j4TasKdykiWLniQ@mail.gmail.com>
 <CAPDyKFrha3mjG3q1Y-3723RW0oo1EuJJjxESYagsvHJR8xG_sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bbn0108.outbound.protection.outlook.com ([157.56.111.108]:27213
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753570AbbFRO30 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 18 Jun 2015 10:29:26 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFrha3mjG3q1Y-3723RW0oo1EuJJjxESYagsvHJR8xG_sQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@freescale.com>, Kevin Lemoi <kevin.lemoi@savant.com>, Otavio Salvador <otavio@ossystems.com.br>, Sascha Hauer <kernel@pengutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>

On Thu, Jun 18, 2015 at 09:58:43AM +0200, Ulf Hansson wrote:
> On 17 June 2015 at 18:25, Fabio Estevam <festevam@gmail.com> wrote:
> > Hi Ulf,
> >
> > On Tue, Jun 16, 2015 at 6:31 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> >> I had a closer look, should have done that before.
> >>
> >> I think we need to decide what "no-1-8-v" should be used for.
> >> Currently the DT documentation is unclear and depending on what SDHCI
> >> variant, the binding has different purpose. It's a mess!
> >
> > Thanks for your feedback.
> >
> >>
> >> sdhci-pltfm + sdhci-esdhc-imx use the "no-1-8-v" DT binding to enable
> >> the SDHCI_QUIRK2_NO_1_8_V. The sdhci driver uses this quirk to mask
> >> the bus speed modes for SD UHS cards.
> >>
> >> In this regards, consider the two below options.
> >>
> >> 1) We have DT bindings for SD UHS speed modes, which somehow makes the
> >> "no-1-8-v" binding redundant (or deprecated).
> >>
> >> 2) If you can model the VCCQ power supply as as a regulator, you could
> >> use regulator_is_supported_voltage() API to find out similar
> >> information used to set SDHCI_QUIRK2_NO_1_8_V. In fact, sdhci already
> >> does that to mask MMC_CAP2_HSX00_1_2V, unless 1.2V is supported.
> >>
> >> In a third case, sdhci-pxav3 use the "no-1-8-v" DT binding to mask
> >> SDHCI_CAN_VDD_180/SDHCI_CAN_VDD_330, which seems wrong, as it has
> >> nothing to do with the power to the card (VMMC). It's also used it to
> >> mask MMC_CAP_1_8V_DDR.
> >>
> >> The summary, is that I would rather see us to move away from using the
> >> "no-1-8-v" DT binding and use the proper SD UHS bus speed modes
> >> binding instead.
> >
> > Makes sense indeed.
> >
> > The challenge here is that we still need to keep the old dtb's working.
> 
> We need to keep something that's been "broken" for ever to keep
> working. Huh, it prevents us from doing the correct solution. :-(
> 
> How hard is it to update the DTBs in these cases?
> 
> >
> > Motivation for this patch was a custom mx6sl board that works fine
> > with 3.14, but after upgrading the kernel to 4.0 the eMMC no longer
> > can mount the rootfs. This is a regression caused by commit
> > 312449efd16bb06, which applies 1.8V to the eMMC card that can only
> > operate at 3.3V.
> >
> > Same thing happens on imx6q-sabresd: we have 3.3V voltage being
> > supplied to the eMMC, but now we are operating it at 1.8V, even though
> > if we have 'no-1-8-v' property in the device tree.
> >
> > While I understand the need for improvement that you clearly
> > described, I would also like that the old dtb's could still work
> > 'as-is' with a modern kernel.
> >
> > The path I propose here was the minimal invasive method I could come
> > up to allow the old dtb compatibility.
> 
> No, I don't want to sprinkle the core with hacks to make host driver
> works. Those hacks will have to reside in host drivers instead.
> 
> Unless updating the DTB is out of the questions.... I suggest the
> following instead.
> 
> 1)
> Let's add MMC_CAP_3V_DDR and a corresponding DT binding for it. Adopt
> mmc_select_hs_ddr() and mmc_select_card_type() to know about this
> configuration.
> 

Yes, that's probably a quirk way to fix the issue.
Host needs to consider the DDR mode support for both 3V and 1.8v way.
If host does not support 1.8V VIO but it supports DDR,
then we only claim 3V DDR support.

It may be something like the treating way of MMC_CAP2_HSX00_1_2V
in sdhci.c.

> 2)
> If we can assume that "no-1-8-v" for sdhci has the meaning of enabling
> MMC_CAP_3V_DDR, let's do that parsing in
> drivers/mmc/host/sdhci-pltfm.c.
> 

For me, no-1-8-v may be better only reflect the host VIO capability, no
DDR functionality.

> 3)
> Update the DT documentation to better describe the "no-1-8-v" binding.
> Let's also move it to be a sdhci specific binding and not a generic
> mmc binding, to limit its use.
> 
> 4)
> Update the DTB files in the kernel for imx to use new binding for
> MMC_CAP_3V_DDR where applicable. Moreover convert the DTB for imx to
> use the proper bindings for UHS bus speed modes. Thus imx should have
> moved away from the "no-1-8-v" for future DTB updates.
> 

Yes, i agree from a long term, we should move away from no-1-8-v
since no-1-8-v is not well defined.
Another issue of this way is that how about host also not support 1.2v?
no-1-2-v?

One different option for a long term fix may be adding VIO capability in
device tree.
Then each host could claim it's VIO capability in device tree.
Then Host driver could select the correct DDR/UHS/HSxx mode based
on VIO capability.

Regards
Dong Aisheng

> Kind regards
> Uffe
