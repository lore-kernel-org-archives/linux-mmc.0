From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v11 4/5] powerpc/fsl: move mpc85xx.h to include/linux/fsl
Date: Wed, 20 Jul 2016 13:24:00 +0200
Message-ID: <4016699.uYaV8nWfqC@wuerfel>
References: <1468723822-30457-1-git-send-email-oss@buserror.net> <1468723822-30457-5-git-send-email-oss@buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468723822-30457-5-git-send-email-oss@buserror.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Saturday, July 16, 2016 9:50:21 PM CEST Scott Wood wrote:
> From: yangbo lu <yangbo.lu@nxp.com>
> 
> Move mpc85xx.h to include/linux/fsl and rename it to svr.h as a common
> header file.  This SVR numberspace is used on some ARM chips as well as
> PPC, and even to check for a PPC SVR multi-arch drivers would otherwise
> need to ifdef the header inclusion and all references to the SVR symbols.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> Acked-by: Wolfram Sang <wsa@the-dreams.de>
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> Acked-by: Joerg Roedel <jroedel@suse.de>
> [scottwood: update description]
> Signed-off-by: Scott Wood <oss@buserror.net>
> 

As discussed before, please don't introduce yet another vendor specific
way to match a SoC ID from a device driver.

I've posted a patch for an extension to the soc_device infrastructure
to allow comparing the running SoC to a table of devices, use that
instead.

	Arnd
