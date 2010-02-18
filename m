From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH 0/3] mmc: omap_hsmmc: support SDIO cards
Date: Thu, 18 Feb 2010 09:02:37 +0200
Message-ID: <4B7CE60D.1090904@compulab.co.il>
References: <cover.1265801967.git.david.vrabel@csr.com> <4B73BFD3.8090106@compulab.co.il> <4B73E59F.3020400@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <4B73E59F.3020400@csr.com>
Sender: linux-omap-owner@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, madhu.cr@ti.com, Mike Rapoport <mike@compulab.co.il>
List-Id: linux-mmc@vger.kernel.org

David Vrabel wrote:
> Mike Rapoport wrote:
>> Hi David,
>>
>> David Vrabel wrote:
>>> These patches add support for SDIO cards to the omap_hsmmc driver.  Less
>>> restrictions on the sizes of transfers, power management changes to 
>>> prevent SDIO cards from being turned off and losing all state, and card
>>> interrupts.
>>>
>>> I've been unable to test these exact patches as I only have an N900 for 
>>> testing and the N900 support in mainline is incomplete.
>> I've tried your patches on CM-T35 that has 8686 SDIO and the result was
>> absence of MMC/SDIO devices at all :( Morover, kmmcd hangs:
>>
>> [  399.427764] INFO: task kmmcd:149 blocked for more than 120 seconds.
>> [...]
>> [  399.485290] [<c01e6264>] (mmc_wait_for_cmd+0x64/0x74) from
>> [<c01e86b0>] (mmc_go_idle+0x60/0xac)
> 
> I suspect interrupts aren't enabled correctly as this command does not
> complete.  Try reverting this hunk.
> 
> @@ -426,12 +431,6 @@ omap_hsmmc_start_command(struct omap_hsmmc_host
> *host, struct mmc_command *cmd,
>                 mmc_hostname(host->mmc), cmd->opcode, cmd->arg);
>         host->cmd = cmd;
> 
> -       /*
> -        * Clear status bits and enable interrupts
> -        */
> -       OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
> -       OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
> -
>         if (host->use_dma)
>                 OMAP_HSMMC_WRITE(host->base, IE,
>                                  INT_EN_MASK & ~(BRR_ENABLE | BWR_ENABLE));

Reverting this hunk and reverting/adjusting changes to IRQ handler makes
SD card recognizable again. No luck with SDIO interrupts though...

I've managed to get libertas_sdio loading properly, but I get lookups when there's
some traffic on the interface:

[ 1277.755859] BUG: soft lockup - CPU#0 stuck for 61s! [libertas_sdio/0:1212]
[ 1277.762786] Modules linked in: libertas_sdio libertas cfg80211 lib80211
firmware_class omap_hsmmc ads7846 twl4030_keypad
[ 1277.773803]
[ 1277.775299] Pid: 1212, comm:      libertas_sdio/0
[ 1277.780029] CPU: 0    Not tainted  (2.6.33-rc4-07945-gd19df2c-dirty #173)
[ 1277.786895] PC is at handle_IRQ_event+0x20/0xf0
[ 1277.791442] LR is at handle_level_irq+0xdc/0xf4
[ 1277.796020] pc : [<c0074ea8>]    lr : [<c0076e10>]    psr: 40000113
[ 1277.796020] sp : cfb61ce8  ip : fb058000  fp : fb058018
[ 1277.807556] r10: c0382508  r9 : 00000000  r8 : 00000022
[ 1277.812805] r7 : 00000001  r6 : 00000000  r5 : 00000143  r4 : cf990c80
[ 1277.819366] r3 : 00000088  r2 : c03c815c  r1 : cf990c80  r0 : 00000143
[ 1277.825958] Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[ 1277.833282] Control: 10c5387d  Table: 8fa1c019  DAC: 00000017


> 
> David


-- 
Sincerely yours,
Mike.

