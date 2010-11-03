From: Chris Ball <cjb@laptop.org>
Subject: Re: about mmc stack
Date: Wed, 3 Nov 2010 18:19:25 +0000
Message-ID: <20101103181925.GA11498@void.printf.net>
References: <AANLkTinahihPVywkb3CVy53V0gqXii32pT=AaxNDxdxF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39983 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752198Ab0KCST1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 3 Nov 2010 14:19:27 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinahihPVywkb3CVy53V0gqXii32pT=AaxNDxdxF@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Musfiq Niaz Rahman <musfiq@csebuet.org>
Cc: linux-mmc@vger.kernel.org

Hi Niaz,

On Fri, Oct 22, 2010 at 12:27:23PM -0700, Musfiq Niaz Rahman wrote:
> Hi,
> 
> I am trying to understand the linux mmc stack implementation for
> educational/research purpose and finding it very hard to track the
> inter-relation among the source files. Do you have a high-level design
> documentation of the stack or any other place where i can find the
> design or notes on the implementation?

I'm afraid we don't, that I know of.  While this is no substitute for
good documentation, for what it's worth I think that ftrace is a fairly
excellent tool for understanding new areas of the kernel.  For example:

# mount -t debugfs debugfs /sys/kernel/debug
# cd /sys/kernel/debug/tracing/
# echo function_graph > current_tracer 
# echo "mmc*" > set_ftrace_filter 
# echo "sdhci*" >> set_ftrace_filter 
# echo 1 > tracing_enabled
# echo 1 > tracing_on
<insert an SD card>
# echo 0 > tracing_on
# cat trace

Produces (cleaned up a little):

 0)   6.798 us    |  sdhci_irq();
 0)               |  sdhci_tasklet_card() {
 0)   2.825 us    |    mmc_detect_change();
 0)   9.134 us    |  }
 0)               |  mmc_rescan() {
 0)   0.951 us    |    mmc_bus_get();
 0)   0.570 us    |    mmc_bus_put();
 0)   0.541 us    |    mmc_bus_get();
 0)   1.368 us    |    mmc_bus_put();
 0)   0.552 us    |    mmc_host_enable();
 0)               |    mmc_power_up() {
 0)               |      mmc_set_ios() {
 0)               |        sdhci_set_ios() {
 0)   0.571 us    |          sdhci_set_clock();
 0)   0.583 us    |          sdhci_set_power();
 0)   7.305 us    |        }
 0)   8.582 us    |      }
 0) ! 11031.80 us |      mmc_delay.clone.0();
 0)               |      mmc_set_ios() {
 0)               |        sdhci_set_ios() {
 0)   5.720 us    |          sdhci_set_clock();
 0)   0.623 us    |          sdhci_set_power();
 0) + 13.022 us   |        }
 0) + 14.557 us   |      }
 0) ! 10898.94 us |      mmc_delay.clone.0();
 0) ! 21959.72 us |    }
 0)               |    mmc_io_rw_direct_host() {
 0)               |      mmc_wait_for_cmd() {
 0)               |        mmc_wait_for_req() {
 0)   5.675 us    |          sdhci_led_control();
 0)   9.187 us    |          sdhci_request();
 1) + 74.351 us   |        } /* mmc_wait_for_req */
 1) + 77.657 us   |      } /* mmc_wait_for_cmd */
 1) + 79.294 us   |    } /* mmc_io_rw_direct_host */
 1)               |    mmc_io_rw_direct_host() {
 1)               |      mmc_wait_for_cmd() {
 1)               |        mmc_wait_for_req() {
 1)   5.826 us    |          sdhci_led_control();
 1) + 10.550 us   |          sdhci_request();
 ------------------------------------------
 1)  kworker-5451  =>  ksoftir-5404 
 ------------------------------------------

 1)               |  sdhci_tasklet_finish() {
 1)   0.758 us    |    sdhci_set_clock();
 1)   0.545 us    |    sdhci_reset();
 1)   1.920 us    |    sdhci_reset();
 1)               |    mmc_request_done() {
 1)   5.916 us    |      sdhci_led_control();
 1)   2.835 us    |      mmc_wait_done();
 1) + 10.659 us   |    }
 1) + 26.404 us   |  }
 ------------------------------------------
 0)   ksoftir-3    =>  kworker-5451 
 ------------------------------------------

 0) + 61.690 us   |        }
 0) + 63.350 us   |      } /* mmc_wait_for_cmd */
 0) + 65.213 us   |    } /* mmc_io_rw_direct_host */
 0)               |    mmc_go_idle() {
 0)               |      mmc_set_chip_select() {
 0)               |        mmc_set_ios() {
 0)               |          sdhci_set_ios() {
 0)   0.702 us    |            sdhci_set_clock();
 0)   0.815 us    |            sdhci_set_power();
 0)   8.680 us    |          }
 0) + 10.787 us   |        }
 0) + 11.936 us   |      }
 0) ! 1972.149 us |      mmc_delay();
 0)               |      mmc_wait_for_cmd() {
 0)               |        mmc_wait_for_req() {
 0)   5.648 us    |          sdhci_led_control();
 0)   9.014 us    |          sdhci_request();
 ------------------------------------------
 0)  kworker-5451  =>   ksoftir-3   
 ------------------------------------------

I'm going to make the hopefully-not-outrageous claim that this already
gives us a reasonable idea of how the subsystem works.  We can see that
sdhci_irq() received an interrupt for the card insertion event, which
gives us an intuition that sdhci_* is responsible for actively talking
to the hardware.  We then hit mmc_detect_change() and mmc_rescan(), and
that triggers are a bunch of commands to the card that are created with
mmc_wait_for_cmd() and fulfilled with sdhci_request(), and we can see
that when we hit sdhci_request() we next end up in sdhci_tasklet_finish(),
which means we got an answer to our command from the controller, and we
then go on to mmc_request_done().

This understanding (of an mmc_ layer that decides which commands to submit
and an sdhci_ layer that talks to the hardware) maps on to the directory
structure -- the mmc_ level commands are in core/, and the sdhci_ level
commands are in host/.

ftrace is also useful for attacking bugs, rather than just sprinkling
printk() everywhere -- you can compare ftrace captures across working
and failing runs, and work out where the callpath starts to differ
in the failing state.

Hope that helps,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
