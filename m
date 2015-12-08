From: Scott Wood <scottwood@freescale.com>
Subject: Re: [v3, 1/5] powerpc/fsl: move mpc85xx.h to include/linux
Date: Tue, 8 Dec 2015 11:44:49 -0600
Message-ID: <1449596689.15946.124.camel@freescale.com>
References: <1448594417-22515-1-git-send-email-yangbo.lu@freescale.com>
	 <1448594417-22515-2-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0115.outbound.protection.outlook.com ([157.56.111.115]:54240
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751245AbbLHSSb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 8 Dec 2015 13:18:31 -0500
In-Reply-To: <1448594417-22515-2-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: X.Xie@freescale.com, LeoLi@freescale.com

On Fri, 2015-11-27 at 11:20 +0800, Yangbo Lu wrote:
> Move mpc85xx.h to include/linux and rename it to fsl-svr.h as
> a common header file. It has been used for mpc85xx and it will
> be used for ARM-based SoC as well.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> ---
> Changes for v2:
> 	- None
> Changes for v3:
> 	- Added this patch
> ---
>  arch/powerpc/include/asm/mpc85xx.h       | 95 -----------------------------
> --
>  drivers/clk/clk-qoriq.c                  |  2 +-
>  drivers/i2c/busses/i2c-mpc.c             |  2 +-
>  drivers/iommu/fsl_pamu.c                 |  2 +-
>  drivers/net/ethernet/freescale/gianfar.c |  2 +-
>  include/linux/fsl-svr.h                  | 97
> ++++++++++++++++++++++++++++++++
>  6 files changed, 101 insertions(+), 99 deletions(-)
>  delete mode 100644 arch/powerpc/include/asm/mpc85xx.h
>  create mode 100644 include/linux/fsl-svr.h

Pass -M -C to git format-patch so it detects moves and copies, and shows what
changed during the move/copy.

Could you make it include/linux/fsl/svr.h instead?

-Scott

