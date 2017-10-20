From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 4/4] mmc: sdhci-msm: Add sdhci msm register write APIs
 which wait for pwr irq
Date: Fri, 20 Oct 2017 11:05:29 -0700
Message-ID: <20171020180529.GC1165@minitux>
References: <1506490483-46871-1-git-send-email-vviswana@codeaurora.org>
 <1506490483-46871-5-git-send-email-vviswana@codeaurora.org>
 <20171014073118.GD1575@tuxbook>
 <cf405901-e711-4ef9-dffd-1e94a023c4a1@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:52294 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752900AbdJTSFd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Oct 2017 14:05:33 -0400
Received: by mail-pf0-f196.google.com with SMTP id e64so12102104pfk.9
        for <linux-mmc@vger.kernel.org>; Fri, 20 Oct 2017 11:05:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cf405901-e711-4ef9-dffd-1e94a023c4a1@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vijay Viswanath <vviswana@codeaurora.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, will.deacon@arm.com, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, riteshh@codeaurora.org, subhashj@codeaurora.org

On Fri 20 Oct 03:54 PDT 2017, Vijay Viswanath wrote:

> On 10/14/2017 1:01 PM, Bjorn Andersson wrote:
> > On Tue 26 Sep 22:34 PDT 2017, Vijay Viswanath wrote:
> > 
> > > diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> > [..]
> > > +	if (!done) {
> > > +		if (!wait_event_timeout(msm_host->pwr_irq_wait,
> > > +				msm_host->pwr_irq_flag,
> > > +				msecs_to_jiffies(MSM_PWR_IRQ_TIMEOUT_MS)))
> > > +			__WARN_printf("%s: pwr_irq for req: (%d) timed out\n",
> > > +					mmc_hostname(host->mmc), req_type);
> > 
> > Bumped my MSM8974AB device to latest linux-next and found this patch; I
> > see this print every five seconds during boot and the eMMC never comes
> > up.
> > 
> > Regards,
> > Bjorn
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> Hi Bjorn,
> 

Hi Vijay,

> I couldn't get one 8974 device. I tested the latest linux-next on db410c and
> its not showing any issue. 8974 is an older msm and has some differences in
> the controller like your "mmc: sdhci-msm: Enable delay circuit calibration
> clocks" patch.
> 

In particular there seems to be some quirks that appeared in 8974pro
(which this is).

> I am currently going through the programming guide to see what could be the
> reason. Can you please share the full logs from the device with me so that I
> can focus my search?
> 

Of course, sorry for the drive-by report without much to go on. I did
some more testing and you can find an extract of the kernel log below.
I was apparently not patient enough before, after 124 seconds we're
through all the timeouts and my eMMC is "functional" - so things are
working, but we're getting stuck waiting for the timeout every time
we're waiting for the pwr irq.


As you can see below we get sdhci_msm_handle_pwr_irq() with status
BUS_ON, so we set io-level HIGH. Then we don't get any more pwr
interrupts, so the io_level remains "high" - although I believe we're
actually low (vqmmc is always 1.8V on this board).

Worth noting is the large comment in sdhci_msm_check_power_status()
related to !host->pwr, host->pwr is always 0 on this board.

# dmesg |grep mmc0
[    1.734573] mmc0: sdhci_msm_handle_pwr_irq: Handled IRQ(0), irq_status=0x0, ack=0x0
[    1.857611] mmc0: sdhci_msm_handle_pwr_irq: Handled IRQ(0), irq_status=0x0, ack=0x0
[    1.889400] mmc0: sdhci_msm_handle_pwr_irq: Handled IRQ(0), irq_status=0x0, ack=0x0
[    2.141634] mmc0: sdhci_msm_handle_pwr_irq: Handled IRQ(0), irq_status=0x0, ack=0x0
[    2.163023] mmc0: sdhci_msm_handle_pwr_irq: Handled IRQ(0), irq_status=0x0, ack=0x0
[    2.238875] mmc0: sdhci_msm_handle_pwr_irq: Handled IRQ(0), irq_status=0x0, ack=0x0
[    2.509617] mmc0: sdhci_msm_check_power_status: request 2 curr_pwr_state 0 curr_io_level 0
[    2.509710] mmc0: sdhci_msm_pwr_irq()
[    2.509723] mmc0: sdhci_msm_handle_pwr_irq: Handled IRQ(30), irq_status=0x2, ack=0x1
[    2.536468] mmc0: sdhci_msm_check_power_status: request 2 done
[    2.546363] mmc0: sdhci_msm_check_power_status: request 8 curr_pwr_state 2 curr_io_level 8
[    2.551220] mmc0: do not wait for power IRQ that never comes, req_type: 8
[    2.559502] sdhci_msm f9824900.sdhci: mmc0: clock=0 uhs=0 ctrl_2=0x0
[    2.572777] mmc0: sdhci_msm_check_power_status: request 8 curr_pwr_state 2 curr_io_level 8
[    2.577353] mmc0: do not wait for power IRQ that never comes, req_type: 8
[    2.592564] mmc0: sdhci_msm_check_power_status: request 8 curr_pwr_state 2 curr_io_level 8
[    2.597230] mmc0: do not wait for power IRQ that never comes, req_type: 8
[    2.605589] mmc0: Switching to 3.3V signalling voltage failed
[    2.618172] mmc0: sdhci_msm_check_power_status: request 4 curr_pwr_state 2 curr_io_level 8
[    7.687764] sdhci_msm f9824900.sdhci: mmc0: pwr_irq for req: (4) timed out
[    7.687795] mmc0: sdhci_msm_check_power_status: request 4 done
[    7.717799] mmc0: Setting clock at rate 400000 at timing 0
[    7.717887] mmc0: sdhci_msm_check_power_status: request 2 curr_pwr_state 2 curr_io_level 8
[    7.722170] mmc0: sdhci_msm_check_power_status: request 2 done
[    7.736229] mmc0: sdhci_msm_check_power_status: request 4 curr_pwr_state 2 curr_io_level 8
[   12.807757] sdhci_msm f9824900.sdhci: mmc0: pwr_irq for req: (4) timed out
[   12.807785] mmc0: sdhci_msm_check_power_status: request 4 done
[   12.813531] sdhci_msm f9824900.sdhci: mmc0: clock=400000 uhs=0 ctrl_2=0x8
[   12.826189] mmc0: sdhci_msm_check_power_status: request 4 curr_pwr_state 2 curr_io_level 8
[   17.847757] sdhci_msm f9824900.sdhci: mmc0: pwr_irq for req: (4) timed out
[   17.847784] mmc0: sdhci_msm_check_power_status: request 4 done
[   17.853520] mmc0: Setting clock at rate 400000 at timing 0
[   17.887757] mmc0: SDHCI controller on f9824900.sdhci [f9824900.sdhci] using ADMA 64-bit
[   17.897018] mmc0: sdhci_msm_check_power_status: request 2 curr_pwr_state 2 curr_io_level 8
[   17.902821] mmc0: sdhci_msm_check_power_status: request 2 done
[   17.916694] mmc0: sdhci_msm_check_power_status: request 4 curr_pwr_state 2 curr_io_level 8
[   22.967759] sdhci_msm f9824900.sdhci: mmc0: pwr_irq for req: (4) timed out
[   22.967787] mmc0: sdhci_msm_check_power_status: request 4 done
[   22.973533] sdhci_msm f9824900.sdhci: mmc0: clock=400000 uhs=0 ctrl_2=0x8
[   22.986192] mmc0: sdhci_msm_check_power_status: request 4 curr_pwr_state 2 curr_io_level 8
[   28.007753] sdhci_msm f9824900.sdhci: mmc0: pwr_irq for req: (4) timed out
[   28.007777] mmc0: sdhci_msm_check_power_status: request 4 done
[   28.013515] mmc0: Setting clock at rate 400000 at timing 0
[   28.021738] mmc0: sdhci_msm_check_power_status: request 2 curr_pwr_state 2 curr_io_level 8
[   28.024798] mmc0: sdhci_msm_check_power_status: request 2 done
[   28.038879] mmc0: sdhci_msm_check_power_status: request 4 curr_pwr_state 2 curr_io_level 8
[   33.047769] sdhci_msm f9824900.sdhci: mmc0: pwr_irq for req: (4) timed out
[   33.047793] mmc0: sdhci_msm_check_power_status: request 4 done
[   33.053536] sdhci_msm f9824900.sdhci: mmc0: clock=400000 uhs=0 ctrl_2=0x8
[   33.066199] mmc0: sdhci_msm_check_power_status: request 4 curr_pwr_state 2 curr_io_level 8
[   38.087755] sdhci_msm f9824900.sdhci: mmc0: pwr_irq for req: (4) timed out
[   38.087779] mmc0: sdhci_msm_check_power_status: request 4 done
[   38.093514] mmc0: Setting clock at rate 400000 at timing 0
[   38.105722] mmc0: sdhci_msm_check_power_status: request 2 curr_pwr_state 2 curr_io_level 8
[   38.105748] mmc0: sdhci_msm_check_power_status: request 2 done
[   38.118881] mmc0: sdhci_msm_check_power_status: request 4 curr_pwr_state 2 curr_io_level 8
[   43.127756] sdhci_msm f9824900.sdhci: mmc0: pwr_irq for req: (4) timed out
[   43.127780] mmc0: sdhci_msm_check_power_status: request 4 done
[   43.133523] sdhci_msm f9824900.sdhci: mmc0: clock=400000 uhs=0 ctrl_2=0x8
[   43.146184] mmc0: sdhci_msm_check_power_status: request 4 curr_pwr_state 2 curr_io_level 8
[   48.167756] sdhci_msm f9824900.sdhci: mmc0: pwr_irq for req: (4) timed out
[   48.167780] mmc0: sdhci_msm_check_power_status: request 4 done
[   48.173515] mmc0: Setting clock at rate 400000 at timing 0
[   48.179810] mmc0: sdhci_msm_check_power_status: request 2 curr_pwr_state 2 curr_io_level 8
[   48.184800] mmc0: sdhci_msm_check_power_status: request 2 done
[   48.198880] mmc0: sdhci_msm_check_power_status: request 4 curr_pwr_state 2 curr_io_level 8
[   53.207753] sdhci_msm f9824900.sdhci: mmc0: pwr_irq for req: (4) timed out
[   53.207777] mmc0: sdhci_msm_check_power_status: request 4 done
[   53.213518] sdhci_msm f9824900.sdhci: mmc0: clock=400000 uhs=0 ctrl_2=0x8
[   53.226181] mmc0: sdhci_msm_check_power_status: request 4 curr_pwr_state 2 curr_io_level 8
[   58.247754] sdhci_msm f9824900.sdhci: mmc0: pwr_irq for req: (4) timed out
[   58.247777] mmc0: sdhci_msm_check_power_status: request 4 done
[   58.253513] mmc0: Setting clock at rate 400000 at timing 0
[   58.259414] mmc0: sdhci_msm_check_power_status: request 2 curr_pwr_state 2 curr_io_level 8
[   58.264797] mmc0: sdhci_msm_check_power_status: request 2 done
[   58.278877] mmc0: sdhci_msm_check_power_status: request 4 curr_pwr_state 2 curr_io_level 8
[   63.287754] sdhci_msm f9824900.sdhci: mmc0: pwr_irq for req: (4) timed out
[   63.287779] mmc0: sdhci_msm_check_power_status: request 4 done
[   63.293521] sdhci_msm f9824900.sdhci: mmc0: clock=400000 uhs=0 ctrl_2=0x8
[   63.306184] mmc0: sdhci_msm_check_power_status: request 4 curr_pwr_state 2 curr_io_level 8
[   68.327764] sdhci_msm f9824900.sdhci: mmc0: pwr_irq for req: (4) timed out
[   68.327792] mmc0: sdhci_msm_check_power_status: request 4 done
[   68.333530] mmc0: Setting clock at rate 400000 at timing 0
[   68.341746] mmc0: sdhci_msm_check_power_status: request 2 curr_pwr_state 2 curr_io_level 8
[   68.344812] mmc0: sdhci_msm_check_power_status: request 2 done
[   68.358891] mmc0: sdhci_msm_check_power_status: request 4 curr_pwr_state 2 curr_io_level 8
[   73.367756] sdhci_msm f9824900.sdhci: mmc0: pwr_irq for req: (4) timed out
[   73.367783] mmc0: sdhci_msm_check_power_status: request 4 done
[   73.373525] sdhci_msm f9824900.sdhci: mmc0: clock=400000 uhs=0 ctrl_2=0x8
[   73.386186] mmc0: sdhci_msm_check_power_status: request 4 curr_pwr_state 2 curr_io_level 8
[   78.407759] sdhci_msm f9824900.sdhci: mmc0: pwr_irq for req: (4) timed out
[   78.407786] mmc0: sdhci_msm_check_power_status: request 4 done
[   78.413521] mmc0: Setting clock at rate 400000 at timing 0
[   78.449337] mmc0: sdhci_msm_check_power_status: request 2 curr_pwr_state 2 curr_io_level 8
[   78.449363] mmc0: sdhci_msm_check_power_status: request 2 done
[   78.462325] mmc0: sdhci_msm_check_power_status: request 4 curr_pwr_state 2 curr_io_level 8
[   83.527756] sdhci_msm f9824900.sdhci: mmc0: pwr_irq for req: (4) timed out
[   83.527781] mmc0: sdhci_msm_check_power_status: request 4 done
[   83.533524] sdhci_msm f9824900.sdhci: mmc0: clock=400000 uhs=0 ctrl_2=0x8
[   83.546187] mmc0: sdhci_msm_check_power_status: request 4 curr_pwr_state 2 curr_io_level 8
[   88.567758] sdhci_msm f9824900.sdhci: mmc0: pwr_irq for req: (4) timed out
[   88.567786] mmc0: sdhci_msm_check_power_status: request 4 done
[   88.573522] mmc0: Setting clock at rate 400000 at timing 0
[   88.611069] mmc0: sdhci_msm_check_power_status: request 4 curr_pwr_state 2 curr_io_level 8
[   93.687759] sdhci_msm f9824900.sdhci: mmc0: pwr_irq for req: (4) timed out
[   93.687788] mmc0: sdhci_msm_check_power_status: request 4 done
[   93.694461] mmc0: sdhci_msm_check_power_status: request 2 curr_pwr_state 2 curr_io_level 8
[   93.699369] mmc0: sdhci_msm_check_power_status: request 2 done
[   93.713422] mmc0: sdhci_msm_check_power_status: request 4 curr_pwr_state 2 curr_io_level 8
[   98.727752] sdhci_msm f9824900.sdhci: mmc0: pwr_irq for req: (4) timed out
[   98.727779] mmc0: sdhci_msm_check_power_status: request 4 done
[   98.733523] sdhci_msm f9824900.sdhci: mmc0: clock=400000 uhs=0 ctrl_2=0x8
[   98.746184] mmc0: sdhci_msm_check_power_status: request 4 curr_pwr_state 2 curr_io_level 8
[  103.767770] sdhci_msm f9824900.sdhci: mmc0: pwr_irq for req: (4) timed out
[  103.767795] mmc0: sdhci_msm_check_power_status: request 4 done
[  103.773531] mmc0: Setting clock at rate 400000 at timing 0
[  103.799563] mmc0: sdhci_msm_check_power_status: request 2 curr_pwr_state 2 curr_io_level 8
[  103.799589] mmc0: sdhci_msm_check_power_status: request 2 done
[  103.812552] mmc0: sdhci_msm_check_power_status: request 4 curr_pwr_state 2 curr_io_level 8
[  108.887755] sdhci_msm f9824900.sdhci: mmc0: pwr_irq for req: (4) timed out
[  108.887779] mmc0: sdhci_msm_check_power_status: request 4 done
[  108.893522] sdhci_msm f9824900.sdhci: mmc0: clock=400000 uhs=9 ctrl_2=0x8
[  108.906185] mmc0: sdhci_msm_check_power_status: request 4 curr_pwr_state 2 curr_io_level 8
[  113.927755] sdhci_msm f9824900.sdhci: mmc0: pwr_irq for req: (4) timed out
[  113.927778] mmc0: sdhci_msm_check_power_status: request 4 done
[  113.933513] mmc0: Setting clock at rate 400000 at timing 9
[  113.939901] mmc0: Setting clock at rate 200000000 at timing 9
[  113.944801] mmc0: sdhci_msm_check_power_status: request 2 curr_pwr_state 2 curr_io_level 8
[  113.950642] mmc0: sdhci_msm_check_power_status: request 2 done
[  113.964587] mmc0: sdhci_msm_check_power_status: request 4 curr_pwr_state 2 curr_io_level 8
[  119.047754] sdhci_msm f9824900.sdhci: mmc0: pwr_irq for req: (4) timed out
[  119.047778] mmc0: sdhci_msm_check_power_status: request 4 done
[  119.053513] sdhci_msm f9824900.sdhci: mmc0: clock=200000000 uhs=9 ctrl_2=0xb
[  119.066531] mmc0: sdhci_msm_check_power_status: request 4 curr_pwr_state 2 curr_io_level 8
[  124.087755] sdhci_msm f9824900.sdhci: mmc0: pwr_irq for req: (4) timed out
[  124.087779] mmc0: sdhci_msm_check_power_status: request 4 done
[  124.093514] mmc0: Setting clock at rate 200000000 at timing 9
[  124.099657] sdhci_msm f9824900.sdhci: mmc0: Found good phase = 0
[  124.105439] sdhci_msm f9824900.sdhci: mmc0: Found good phase = 1
[  124.111537] sdhci_msm f9824900.sdhci: mmc0: Found good phase = 2
[  124.117501] sdhci_msm f9824900.sdhci: mmc0: Found good phase = 3
[  124.123514] sdhci_msm f9824900.sdhci: mmc0: Found good phase = 4
[  124.129501] sdhci_msm f9824900.sdhci: mmc0: Found good phase = 5
[  124.135411] sdhci_msm f9824900.sdhci: mmc0: Found good phase = 6
[  124.141423] sdhci_msm f9824900.sdhci: mmc0: Found good phase = 7
[  124.147389] sdhci_msm f9824900.sdhci: mmc0: Found good phase = 8
[  124.153403] sdhci_msm f9824900.sdhci: mmc0: Found good phase = 9
[  124.159448] sdhci_msm f9824900.sdhci: mmc0: Found good phase = 10
[  124.165417] sdhci_msm f9824900.sdhci: mmc0: Found good phase = 11
[  124.171433] sdhci_msm f9824900.sdhci: mmc0: Found good phase = 12
[  124.177483] sdhci_msm f9824900.sdhci: mmc0: Found good phase = 13
[  124.183709] sdhci_msm f9824900.sdhci: mmc0: Setting the tuning phase to 9
[  124.189943] mmc0: new HS200 MMC card at address 0001
[  124.198091] mmcblk0: mmc0:0001 MAG2GC 14.6 GiB 
[  124.201538] mmcblk0boot0: mmc0:0001 MAG2GC partition 1 4.00 MiB
[  124.205695] mmcblk0boot1: mmc0:0001 MAG2GC partition 2 4.00 MiB
[  124.211637] mmcblk0rpmb: mmc0:0001 MAG2GC partition 3 4.00 MiB, chardev (247:0)


Please let me know if I can assist you with anything additional!

Regards,
Bjorn
