From: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
Subject: arm, am1808: using mmc1 controller and dma
Date: Fri, 02 Dec 2011 08:35:22 +0100
Message-ID: <4ED87FBA.40409@denx.de>
Reply-To: hs-ynQEQJNshbs@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jarkko Lavinen <jarkko.lavinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hello,

trying Linux 3.2.0-rc3 on an am1808 based board using MMCSD1 controller,
and facing problems with using DMA. Deactivating use_dma=0 in the
davinci_mmc controller and mmc works in pio mode without problems.
So there are no hardware problems, pinmux is ok, psc are all on.

Tried this on the AM1808 evalboard TMDXEXP1808L, and Linux 3.1
works with DMA without problems. Difference: On the AM1808 Evalboard
TMDXEXP1808L MMCSD0 controller is used on my am1808 based board
MMCSD1!

Debugging in code and found, that on the am1808 evalboard I get
on startup (first DMA access):

CMD13, arg 0x00000000, R1/R5/R6/R7 response

a status back in mmc_davinci_irq():

TRNDNE (0x1000) Transfer done
RSPDNE (0x0004) Response succesfully has received
DATDNE (0x0001) The data has been fully transmitted

On the am1808 based board with using MMCSD1 I get:

CMD13, arg 0x00000000, R1/R5/R6/R7 response

TRNDNE (0x1000) Transfer done
DRRDY  (0x0400) MMCDRR is ready New data arrived and can be read by cpu or dma
RSPDNE (0x0004) Response succesfully has received

after that command, I see  no more mmc accesses ... some ideas?

Looking in the sprufu5.pdf (AM18x ARM Microprocessor Enhanced Direct
Memory Access (EDMA3) Controller" chapter "2.6 Event, Channel, and
PaRAM Mapping":

"Most of the DMA channels are tied to a specific hardware peripheral
event, thus allowing transfers to be triggered by events from device
peripherals or external hardware."

The mapping is defined in the device specific manual
http://www.ti.com/lit/ds/sprs653b/sprs653b.pdf
chapter "5.9.1 EDMA3 Channel Synchronization Events"

and there I found:

EDMA0 Controller Event 16 MMCSD0 Receive
EDMA0 Controller Event 17 MMCSD0 Transmit

EDMA1 Controller Event 28 MMCSD1 Receive
EDMA1 Controller Event 29 MMCSD1 Transmit

The Linux 3.1 Code is using
EDMA1 Controller Event 28 MMCSD1 Receive
EDMA1 Controller Event 29 MMCSD1 Transmit

as events for the MMCSD1 controller ... so, this should be ok ...
I see no more differences between MMCSD0 and MMCSD1 ... maybe I
miss something?

Have somebody running an am1808 based board with using MMCSD
controller 1?

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
