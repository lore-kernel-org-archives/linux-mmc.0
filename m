From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH] mmc: cavium: Depend on GPIO driver
Date: Wed, 4 Oct 2017 16:12:38 +0200
Message-ID: <20171004141238.GA15989@hc>
References: <1506945761-23482-1-git-send-email-jglauber@cavium.com>
 <b822ae64-42a3-2ffd-a6bd-8534f8c3d46b@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-sn1nam02on0056.outbound.protection.outlook.com ([104.47.36.56]:51708
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752255AbdJDOMv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 4 Oct 2017 10:12:51 -0400
Content-Disposition: inline
In-Reply-To: <b822ae64-42a3-2ffd-a6bd-8534f8c3d46b@caviumnetworks.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, David Daney <david.daney@cavium.com>, "Steven J. Hill" <Steven.Hill@cavium.com>

On Mon, Oct 02, 2017 at 10:06:05AM -0700, David Daney wrote:
> On 10/02/2017 05:02 AM, Jan Glauber wrote:
> >Without the ThunderX/OcteonTx GPIO driver the MMC driver
> >would not power up any MMC devices. Therefore add a
> >dependency to the GPIO driver and remove the unneeded GPIOLIB
> >dependency.
> >
> >Signed-off-by: Jan Glauber <jglauber@cavium.com>
> >---
> >  drivers/mmc/host/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> >index 8c15637178ff..a47a2f1d8ae4 100644
> >--- a/drivers/mmc/host/Kconfig
> >+++ b/drivers/mmc/host/Kconfig
> >@@ -663,7 +663,7 @@ config MMC_CAVIUM_OCTEON
> >  config MMC_CAVIUM_THUNDERX
> >  	tristate "Cavium ThunderX SD/MMC Card Interface support"
> >  	depends on PCI && 64BIT && (ARM64 || COMPILE_TEST)
> >-	depends on GPIOLIB
> >+	depends on GPIO_THUNDERX
> 
> We could just "select" GPIO_THUNDERX instead so that people aren't
> forced to manually unwind all the dependencies.

I thought about select vs. depends, but the Documentation prefers
depends as a select would not automatically enable everything
GPIO_THUNDERX needs. See in Documentation/kbuild/kconfig-language.txt
the note about select.

--Jan

> Also, what do we do if the required GPIO lines are on I2C expanders?
> This patch doesn't help in this hypothetical case.  In the end it is
> the responsibility if the system designer to ensure the proper
> drivers are available in their kernels.  I think the patch is a step
> in the right direction, but just wanted to note that it doesn't
> cover all possible cases.
> 
> In any event, you can add ...:
> 
> Acked-by: David Daney <david.daney@cavium.com>
> 
> ... to either this version, or an alternative patch that does the
> "select" instead.
> 
> Thanks
> 
> 
> >  	depends on OF_ADDRESS
> >  	help
> >  	  This selects Cavium ThunderX SD/MMC Card Interface.
> >
