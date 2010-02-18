From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 3/3] mmc: omap_hsmmc: enable SDIO card interrupts
Date: Thu, 18 Feb 2010 13:21:21 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002181231520.24812@utopia.booyaka.com>
References: <cover.1265801967.git.david.vrabel@csr.com> <846fbf1a68cde5fd2d7c7ab084ace239c8de6867.1265801967.git.david.vrabel@csr.com> <f4f02c7875316b7f65466a5ac06f5b2b2960aa96.1265801967.git.david.vrabel@csr.com> <9ce6cf93ba1e6c3fd239f732ea5889a856948db3.1265801967.git.david.vrabel@csr.com>
 <004901cab001$6b19f6c0$544ff780@am.dhcp.ti.com> <4B7C4608.5010008@csr.com> <alpine.DEB.2.00.1002171254040.24812@utopia.booyaka.com> <4B7D3EAE.1010908@csr.com> <alpine.DEB.2.00.1002180951330.24812@utopia.booyaka.com>
 <004001cab0c9$b208b2b0$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <004001cab0c9$b208b2b0$544ff780@am.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: 'David Vrabel' <david.vrabel@csr.com>, sakoman@gmail.com, r-woodruff2@ti.com, sawant@ti.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

(cc'ing Steve, Richard, Anand)

On Thu, 18 Feb 2010, Madhusudhan wrote:

> Not to add further confusion but as far as I understand SDIO should be 
> able to asynchronously wakeup OMAP regardless of MMC clocks being OFF . 
> As per the SDIO spec DAT1 line is used for signaling the card interrupt 
> to the host. The TRM clearly shows a GPIO connected to DAT1 line for 
> wakeup through the SDIO interrupt. Wouldn't this help?

Is the integration code in arch/arm/*omap* set to enable wakeup on the 
DAT1 ball on the OMAP?  I don't see any trace of that in the code.  That 
would surely prevent wakeup from succeeding on an off-mode enabled kernel.  
Sounds like there may be other problems.  Why not give it a try with an 
SDIO card and see if you can get it to work?

> Definitely these are good features that are being added. Just that there 
> are confusions around and not everyone has a setup to validate these 
> features.

Hopefully someone inside TI is validating SDIO wakeup on Linux?

> If I look in the mainline kernel today there is only one SDIO card 
> driver " sdio_uart.c".

[paul@twilight current]$ find . -name "*sdio*c" -print | fgrep -v /core/
./drivers/ssb/sdio.c
./drivers/bluetooth/btsdio.c
./drivers/bluetooth/btmrvl_sdio.c
./drivers/mmc/host/mvsdio.c
./drivers/net/wimax/i2400m/sdio-rx.c
./drivers/net/wimax/i2400m/sdio-tx.c
./drivers/net/wimax/i2400m/sdio.c
./drivers/net/wimax/i2400m/sdio-fw.c
./drivers/net/wireless/iwmc3200wifi/sdio.c
./drivers/net/wireless/libertas/if_sdio.c
./drivers/net/wireless/wl12xx/wl1251_sdio.c
./drivers/net/wireless/b43/sdio.c
./drivers/media/dvb/siano/smssdio.c
[paul@twilight current]$

There appear to be least seven SDIO card drivers in 2.6.34-rc7. At least 
one of these is for a TI chip - the wl1251.  I think some of the 
Gumstix Overo OMAP3 boards are using an SDIO-connected Marvell Libertas:

http://www.gumstix.com/store/catalog/product_info.php?products_id=252
  
David is probably testing with a Bluetooth card - maybe he can comment 
further.

> And at least I don't see a way I can test any of these features myself.

Could you clarify?


- Paul
