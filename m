From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [RFC PATCH] mmc: core: HS DDR switch, don't change timing before
 checking status
Date: Fri, 24 Mar 2017 11:51:30 +0100
Message-ID: <20170324105130.anwxsgoqeiffdcmb@rfolt0960.corp.atmel.com>
References: <98664253-9a68-fa59-7f17-438b0d522fe8@microchip.com>
 <20170310142117.6060-1-ludovic.desroches@atmel.com>
 <CAPDyKFqpX3ZQSxiZsMyei9K0v9eSqVSBC89_U2=VtokGSqtFfA@mail.gmail.com>
 <20170317163311.vhhcwgr2asjxuoh7@rfolt0960.corp.atmel.com>
 <CAPDyKFqJA-Tj=Q+-gR+gOUNokzN0QpxHBgaEVqOGtCWiXt6Bzw@mail.gmail.com>
 <20170322104933.72klypbhx3hqioax@rfolt0960.corp.atmel.com>
 <CAPDyKFo9hoaA7wptkkyhitFmV_92=M=001EOgMtSBp=b2c7nYw@mail.gmail.com>
 <20170322161738.mw65ykldgfuwjhcg@rfolt0960.corp.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:31350 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752612AbdCXKvd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Mar 2017 06:51:33 -0400
Content-Disposition: inline
In-Reply-To: <20170322161738.mw65ykldgfuwjhcg@rfolt0960.corp.atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Ludovic Desroches <ludovic.desroches@atmel.com>, nicolas.ferre@microchip.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Wed, Mar 22, 2017 at 05:17:38PM +0100, Ludovic Desroches wrote:
> On Wed, Mar 22, 2017 at 12:18:00PM +0100, Ulf Hansson wrote:
> > [...]
> > 
> > >> >>
> > >> >> We had other reports for similar problems. The following change fix
> > >> >> those issues, have you tried this out?
> > >> >>
> > >> >> [PATCH] mmc: core: Restore parts of the polling policy when switch to HS/HS DDR
> > >> >> https://patchwork.kernel.org/patch/9515239/
> > >> >
> > >> > I did the test with next and the behavior is the same.
> > >> >
> > >> > mmc0: Invalid UHS-I mode selected
> > >> > mmc0: switch to bus width 8 ddr failed
> > >> > mmc0: error -110 whilst initialising MMC card
> > >> >
> > >> > It seems the root cause is to perform mmc_set_timing before mmc_switch_status.
> > >>
> > >> Okay, I see! This sounds a bit weird.
> > >>
> > >> As you know, the CMD6 has been a problematic historically, mostly
> > >> because of busy detection issues. We have now tried to make the code
> > >> more robust in __mmc_switch() and its friends.
> > >> That said, before considering to apply your fix, I would really like
> > >> us to investigate this a bit more, to make sure we find the correct
> > >> solution and of course to avoid regressions for other cases.
> > >>
> > >> Recently reported issues [1] that was observed for sdhci-esdc-imx,
> > >> which has been fixed now, can be summarized in these two issues:
> > >>
> > >> *) Only 3.3V I/O voltage DDR mode was supported by the SoC. Still the
> > >> mmc core tried to set 1.8V, which caused errors when switching to HS
> > >> DDR mode.
> > >> -> To fix this, we invented MMC_CAP_3_3V_DDR [2] and a corresponding
> > >> DT binding ("mmc-ddr-3_3v"). Hosts/SoCs, that supports only 3.3V DDR
> > >> mode, should set this.
> > >>
> > >> **). Changing host's timings couldn't be done while the card was busy,
> > >> because of internal limitations by the sdhci-esdhc-imx controller. The
> > >> consequence was that the following CMD13 command (to get the switch
> > >> status), returned the error code -110, perhaps similar to your case.
> > >> ->To fix this, we decided to move the update of the host's timing, to
> > >> after we verified the card isn't being busy [3].
> > >>
> > >>
> > >> From your description to the problem you encounter, I would recommend
> > >> the following debug steps to try to understand what really goes on.
> > >> 1.
> > >> Check if the 3.3V DDR issue is applicable for your case as well, and
> > >> fix it if it is.
> > >
> > > There is a regulator driven by the sdhci controller to manage 3.3V and
> > > 1.8V I/O voltage.
> > >
> > >>
> > >> 2.
> > >> Both sdhci-esdhc-imx and sdhci-of-at91, don't have
> > >> MMC_CAP_WAIT_WHILE_BUSY set. However, both sdhci variants are using
> > >> the ->card_busy() host ops (assigned to sdhci_card_busy()), which
> > >> triggers __mmc_switch() to call mmc_poll_for_busy() when it switches
> > >> to HS DDR mode (CMD6). Could it be that sdhci_card_busy() isn't
> > >> working properly for sdhci-of-at91? This could lead to that that
> > >> mmc_poll_for_busy() believes the card isn't busy, while it actually
> > >> is.
> > >>
> > >> To check whether theory 2 stands, I would explore these debug alternatives.
> > >> *) Remove the assignment of ->card_busy() in sdhci.c, which makes
> > >> mmc_poll_for_busy() to use CMD13 polling instead. If this works, it
> > >> would be useful to know how many times a CMD13 is sent to find out
> > >> when card moves out of busy state.
> > >
> > > It doesn't work.
> > 
> > Okay. So what kind of error do you get when sending the CMD13 to poll? -110?
> 
> No error when I poll after CMD6. Here is a log with CMD13 to perform the
> polling:
> 
> mmc0: clock 52000000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 8 timing 1
> mmc0: starting CMD8 arg 00000000 flags 000000b5
> mmc0:     blksz 512 blocks 1 flags 00000200 tsac 400 ms nsac 1000
> mmc0: sdhci: IRQ status 0x00000001
> mmc0: sdhci: IRQ status 0x00000002
> mmc0: req done (CMD8): 0: 00000900 00000000 00000000 00000000
> mmc0:     512 bytes transferred: 0
> === mmc_select_hs_ddr: l.1072 ===
> --- __mmc_switch ---
> __mmc_switch: mmc_wait_for_cmd
> mmc0: starting CMD6 arg 03b70601 flags 0000049d
> mmc0: sdhci: IRQ status 0x00000001
> mmc0: sdhci: IRQ status 0x00000002
> mmc0: req done (CMD6): 0: 00000800 00000000 00000000 00000000
> __mmc_switch: mmc_poll_for_busy
> mmc0: starting CMD13 arg 00010000 flags 00000195
> mmc0: sdhci: IRQ status 0x00000001
> mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> mmc_poll_for_busy: l.512
> __mmc_switch: mmc_set_timing
> mmc0: clock 52000000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 8 timing 8
> __mmc_switch: mmc_switch_status
> mmc0: starting CMD13 arg 00010000 flags 00000195
> mmc0: sdhci: IRQ status 0x00038000
> mmc0: req failed (CMD13): -110, retrying...
> mmc0: sdhci: IRQ status 0x00038000
> mmc0: req failed (CMD13): -110, retrying...
> mmc0: sdhci: IRQ status 0x00038000
> mmc0: req failed (CMD13): -110, retrying...
> mmc0: sdhci: IRQ status 0x00038000
> mmc0: req done (CMD13): -110: 00000000 00000000 00000000 00000000
> mmc0: clock 52000000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 8 timing 1
> mmc0: Invalid UHS-I mode selected
> mmc0: switch to bus width 8 ddr failed
> mmc0: error -110 whilst initialising MMC card
> mmc0: clock 0Hz busmode 2 powermode 0 cs 0 Vdd 0 width 1 timing 0
> 
> 
> > 
> > >
> > >> **) While using ->card_busy(), I would just add some simple debug
> > >> prints in mmc_poll_for_busy() to prints its return values.
> > >
> > > No error returned. I exit the function after the while loop.
> > 
> > If I understand correctly, the ->card_busy() callbacks immediately
> > reports the eMMC card as *not* being busy, right?
> 
> Yes, with sdhci_card_busy() this time:
> 
> === mmc_select_hs_ddr: l.1072 ===                                                                       
> --- __mmc_switch ---
> __mmc_switch: mmc_wait_for_cmd
> mmc0: starting CMD6 arg 03b70601 flags 0000049d
> mmc0: sdhci: IRQ status 0x00000001
> mmc0: sdhci: IRQ status 0x00000002
> mmc0: req done (CMD6): 0: 00000800 00000000 00000000 00000000
> __mmc_switch: mmc_poll_for_busy
> mmc_poll_for_busy: ops->card_busy
> mmc_poll_for_busy: l.513
> __mmc_switch: mmc_set_timing
> mmc0: clock 52000000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 8 timing 8
> __mmc_switch: mmc_switch_status
> mmc0: starting CMD13 arg 00010000 flags 00000195
> mmc0: sdhci: IRQ status 0x00038000
> mmc0: req failed (CMD13): -110, retrying...
> mmc0: sdhci: IRQ status 0x00038000
> mmc0: req failed (CMD13): -110, retrying...
> mmc0: sdhci: IRQ status 0x00038000
> mmc0: req failed (CMD13): -110, retrying...
> mmc0: sdhci: IRQ status 0x00038000
> mmc0: req done (CMD13): -110: 00000000 00000000 00000000 00000000
> mmc0: clock 52000000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 8 timing 1
> mmc0: Invalid UHS-I mode selected
> mmc0: switch to bus width 8 ddr failed
> mmc0: error -110 whilst initialising MMC card
> 
> 
> > 
> > >
> > > I continue the investigation to figure out why calling mmc_set_timing before
> > > mmc_switch_status causes an issue.
> > 
> > Great!
> > 
> > Please tell if you need some further help with some more ideas.
> 
> Ok thanks.
> 
> To compare, if I put mmc_set_timing after mmc_switch_status:

I think I have found the root cause with the help of the hardware guy
but there is still some block magic.

sdhci_set_uhs_signaling configures the host with SDHCI_CTRL_UHS_DDR50
when we need MMC_TIMING_MMC_DDR52 or MMC_TIMING_MMC_DDR52.

In my case, I have to configure another register to indicate we want to use
MMC_DDR52. It seems we are the only one to do this. I am wondering how it is
managed by other controllers.

It seems this was the root cause. If I configure the other register, it
works but I don't understand how it could work in the past.

The explanation I get from the hardware guy is that the MMC_DDR52
timings are totally different from the UHS_DDR50 ones but the MMC_HS timings
may work with the MMC_DDR52 ones.
Before the CMD13 was sent with MMC_HS timings, now with MMC_DDR52 ones.
It should explain the CMD13 issue but why next steps passed? The next CMD13 is
triggered by the mmc_switch to enable HPI and it works as we can see in
these logs:

> 
> mmc0: clock 52000000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 8 timing 1
> mmc0: starting CMD8 arg 00000000 flags 000000b5
> mmc0:     blksz 512 blocks 1 flags 00000200 tsac 400 ms nsac 1000
> mmc0: sdhci: IRQ status 0x00000001             
> mmc0: sdhci: IRQ status 0x00000002
> mmc0: req done (CMD8): 0: 00000900 00000000 00000000 00000000
> mmc0:     512 bytes transferred: 0             
> === mmc_select_hs_ddr: l.1072 === 
> --- __mmc_switch ---                                                 
> __mmc_switch: mmc_wait_for_cmd                 
> mmc0: starting CMD6 arg 03b70601 flags 0000049d                                                   
> mmc0: sdhci: IRQ status 0x00000001                                                                      
> mmc0: sdhci: IRQ status 0x00000002             
> mmc0: req done (CMD6): 0: 00000800 00000000 00000000 00000000
> __mmc_switch: mmc_poll_for_busy                              
> mmc_poll_for_busy: ops->card_busy              
> mmc_poll_for_busy: l.513          
> __mmc_switch: mmc_switch_status
> mmc0: starting CMD13 arg 00010000 flags 00000195
> mmc0: sdhci: IRQ status 0x00000001
> mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> __mmc_switch: mmc_set_timing
> mmc0: clock 52000000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 8 timing 8
> --- __mmc_switch ---
> __mmc_switch: mmc_wait_for_cmd
> mmc0: starting CMD6 arg 03a10101 flags 0000049d
> mmc0: sdhci: IRQ status 0x00000001
> mmc0: sdhci: IRQ status 0x00000002
> mmc0: req done (CMD6): 0: 00000800 00000000 00000000 00000000
> __mmc_switch: mmc_poll_for_busy
> mmc_poll_for_busy: ops->card_busy
> mmc_poll_for_busy: l.513
> __mmc_switch: mmc_switch_status
> mmc0: starting CMD13 arg 00010000 flags 00000195
> mmc0: sdhci: IRQ status 0x00000001
> mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> mmc0: new DDR MMC card at address 0001

Regards

Ludovic
