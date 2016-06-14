From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: [Linux-kernel] [PATCH] mmc: mmci: add missing include of
 mmci_qcom_dml.h
Date: Tue, 14 Jun 2016 14:44:33 +0100
Message-ID: <1465911873.26723.3.camel@codethink.co.uk>
References: <201606100156.EWHSQe2w%fengguang.wu@intel.com>
	 <49d030df-f0b5-6bed-7f4c-a101b6e15752@codethink.co.uk>
	 <a2843535-fbea-927b-226b-e51e49f2761d@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:55562 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbcFNNol (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jun 2016 09:44:41 -0400
In-Reply-To: <a2843535-fbea-927b-226b-e51e49f2761d@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: kbuild test robot <lkp@intel.com>, linux-kernel@lists.codethink.co.uk, linux-arm-kernel@lists.infadead.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, kbuild-all@01.org

On Thu, 2016-06-09 at 18:45 +0100, Ben Dooks wrote:
[...]
> After looking at the build, it looks like this is broken
> for the case of building mmci as a module. I think this is
> the right fix.
> 
> commit be3bf8f3b56d9cfb2fcba88e638ec853d0484cbb
> Author: Ben Dooks <ben.dooks@codethink.co.uk>
> Date:   Thu Jun 9 18:42:53 2016 +0100
> 
>     mmci: fixup module build with new mmci_qcom_dml
> 
>     Fix the module build for the mmci code if it is built as
>     a module and the MMC_QCOM_DML option is also set. If so
>     then we need to build a composite module of the two files
>     to ensure they link properly.
> 
>     Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index af918d2..b57db76 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -3,7 +3,8 @@
>  #
> 
>  obj-$(CONFIG_MMC_ARMMMCI)      += mmci.o
> -obj-$(CONFIG_MMC_QCOM_DML)     += mmci_qcom_dml.o
> +mmci-y                         += mmci_core.o
> +mmci-$(subst m,y,$(CONFIG_MMC_QCOM_DML)) += mmci_qcom_dml.o
[...]

If mmci_core.o and mmci_qcom_dml.o will always be linked together then
MMC_QCOM_DML should be a boolean and you don't need any substitution
here.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.


