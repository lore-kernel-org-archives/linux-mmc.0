From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RESEND] mmc: omap_hsmmc: support more DT properties
Date: Tue, 4 Mar 2014 09:37:17 -0800
Message-ID: <20140304173716.GC17470@atomide.com>
References: <1393881376-10751-1-git-send-email-zonque@gmail.com>
 <5315FD28.4020800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:26993 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622AbaCDRhX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Mar 2014 12:37:23 -0500
Content-Disposition: inline
In-Reply-To: <5315FD28.4020800@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@TI.COM>
Cc: chris@printf.net, linux-mmc@vger.kernel.org, Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org

* Balaji T K <balajitk@TI.COM> [140304 08:22]:
> On Tuesday 04 March 2014 02:46 AM, Daniel Mack wrote:
> >This should probably be done implicitly through mmc_of_parse(), but that
> >doesn't play well along with the multi-slot model the hsmmc driver
> >features. Hence, for now, do it manually. The properties are already
> >documented in Documentation/devicetree/bindings/mmc/mmc.txt.
> >
> >Signed-off-by: Daniel Mack <zonque@gmail.com>
> >Acked-by: Balaji T K <balajitk@ti.com>
> >---
> >This is a resend of a patch that was already acked by Balaji T K:
> >
> >   http://www.spinics.net/lists/linux-mmc/msg25029.html
> 
> Hi Chris,
> 
> To make it easier for you, I have collected omap_hsmmc patches [1]
> and pushed a branch omap_hsmmc-for-3.15 based on 3.14rc2.

You should probably send this as a proper pull request to Chris
with [GIT PULL] in the Subject line as it can otherwise get
easily lost.

Regards,

Tony
 
> Please pull or cherry pick
> 
> The following changes since commit b28a960c42fcd9cfc987441fa6d1c1a471f0f9ed:
> 
>   Linux 3.14-rc2 (2014-02-09 18:15:47 -0800)
> 
> are available in the git repository at:
>   git://git.ti.com/~balajitk/ti-linux-kernel/omap-hsmmc.git omap_hsmmc-for-3.15
> 
> Balaji T K (14):
>       mmc: omap_hsmmc: use devm_regulator API
>       mmc: omap_hsmmc: handle vcc and vcc_aux independently
>       regulator: add pbias regulator support
>       mmc: omap_hsmmc: adapt hsmmc to use pbias regulator
>       ARM: dts: add pbias dt node
>       ARM: OMAP: enable SYSCON and REGULATOR_PBIAS in omap2plus_defconfig
>       mmc: omap_hsmmc: remove pbias workaround
>       mmc: omap_hsmmc: fix return error code for of_get_hsmmc_pdata
>       mmc: omap_hsmmc: remove redundant reset done
>       mmc: omap_hsmmc: save clock rate to use in interrupt context
>       mmc: omap_hsmmc: fix request done for sbc error case
>       mmc: omap_hsmmc: split dma setup
>       mmc: omap_hsmmc: add cmd23 support
>       mmc: omap_hsmmc: add autocmd23 support
> 
> Dan Carpenter (1):
>       mmc: omap_hsmmc: remove a duplicative test
> 
> Daniel Mack (1):
>       mmc: omap_hsmmc: support more DT properties
> 
> Nishanth Menon (2):
>       mmc: omap_hsmmc: Add support for quirky omap3 hsmmc controller
>       ARM: dts: omap3-ldp: fix mmc configuration
> 
>  .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    1 +
>  .../bindings/regulator/pbias-regulator.txt         |   27 ++
>  arch/arm/boot/dts/dra7.dtsi                        |   17 ++
>  arch/arm/boot/dts/omap2430.dtsi                    |   17 ++
>  arch/arm/boot/dts/omap3-ldp.dts                    |   23 ++
>  arch/arm/boot/dts/omap3.dtsi                       |   17 ++
>  arch/arm/boot/dts/omap4.dtsi                       |   17 ++
>  arch/arm/boot/dts/omap5.dtsi                       |   17 ++
>  arch/arm/configs/omap2plus_defconfig               |    2 +
>  drivers/mmc/host/omap_hsmmc.c                      |  242 +++++++++++++------
>  drivers/regulator/Kconfig                          |    9 +
>  drivers/regulator/Makefile                         |    1 +
>  drivers/regulator/pbias-regulator.c                |  255 ++++++++++++++++++++
>  13 files changed, 569 insertions(+), 76 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/regulator/pbias-regulator.txt
>  create mode 100644 drivers/regulator/pbias-regulator.c
> 
> [1]
> http://www.spinics.net/lists/linux-omap/msg102811.html
> http://lkml.org/lkml/2014/2/14/13
> http://www.spinics.net/lists/linux-mmc/msg25029.html
> http://www.spinics.net/lists/linux-omap/msg103488.html
> http://www.spinics.net/lists/linux-omap/msg103608.html
> http://comments.gmane.org/gmane.linux.kernel.mmc/24777
> 
