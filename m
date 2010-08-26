From: Yusuke Goda <yusuke.goda.sx@renesas.com>
Subject: Re: [PATCH 4/4] ARM: mach-shmobile: ap4evb: Fix hotplug for SDHI1
Date: Thu, 26 Aug 2010 14:00:13 +0900
Message-ID: <4C75F4DD.5020804@renesas.com>
References: <1282663622-20564-1-git-send-email-arnd@arndnet.de>
 <1282663622-20564-5-git-send-email-arnd@arndnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-reply-to: <1282663622-20564-5-git-send-email-arnd@arndnet.de>
Sender: linux-sh-owner@vger.kernel.org
To: Arnd Hannemann <arnd@arndnet.de>
Cc: ian@mnementh.co.uk, sameo@linux.intel.com, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


Arnd Hannemann wrote:
> On AP4EVB the card detect pin of the top SD/MMC slot is not directly connected
> to the tmio/mmcif controller but to a GPIO pin, so polling needs to be done for
> SDHI1 and MMCIF in order to support hotplug for that slot. SHDI1 and MMCIF
> share that slot, and the used controller is selected by a DIP switch.
> This patch adds a helper function to check if a card is present in that
> particular slot, registers this function with SDHI1 and MMCIF and enables
> polling for SDHI1.
> 
> Signed-off-by: Arnd Hannemann <arnd@arndnet.de>

I confirmed normal operation in the following environment.
 - AP4EVB board
 - CN7 (MMCIF)

Tested-by: Yusuke Goda <yusuke.goda.sx@renesas.com>

