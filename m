From: Daniel Mack <daniel@caiaq.de>
Subject: MXC MMC driver and SDIO peripherals
Date: Wed, 21 Oct 2009 21:20:38 +0200
Message-ID: <20091021192038.GK14091@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org, libertas-dev@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi,

we're having trouble getting SDIO connected harware to fly on MX31 based
designs. In particular, a SD8686 chip supported by the libertas_sdio
driver will hang forever when built without CONFIG_MMC_DEBUG=y. With
that option selected, however, the behaviour is a little different, and
I can at least see the following messages on a recent 2.6.32-rc5 based
MX31 tree.

Is there any common pitfall for such setups? I did more or less the same
thing on PXAs (same WLAN chip, same kind of interface, same firmware),
and haven't seen any such effects, so I suspect the MXC specific parts
to be the reason for that. Any ideas?

Thanks,
Daniel


[    1.450000] mmc0: new SDIO card at address 0001
...
# modprobe libertas_sdio
[   15.180000] libertas_sdio: Libertas SDIO driver
[   15.180000] libertas_sdio: Copyright Pierre Ossman
[   15.190000] libertas_sdio mmc0:0001:1: firmware: requesting sd8686_helper.bin
[   15.320000] libertas_sdio mmc0:0001:1: firmware: requesting sd8686.bin
[   15.840000] libertas: 00:19:88:03:13:5a, fw 8.73.7p3, cap 0x00000393
[   16.870000] libertas: problem fetching packet from firmware
[   18.840000] libertas: command 0x001e timed out
[   18.840000] libertas: requeueing command 0x001e due to timeout (#1)
[   18.870000] libertas: Received result 0 to command 1e after 1 retries
[   18.910000] libertas: wlan0: Marvell WLAN 802.11 adapter

# ifconfig wlan0 up
[  216.760000] ADDRCONF(NETDEV_UP): wlan0: link is not ready
[  217.800000] libertas: problem fetching packet from firmware
[  219.770000] libertas: command 0x0010 timed out
[  219.770000] libertas: requeueing command 0x0010 due to timeout (#1)
[  219.800000] libertas: Received result 0 to command 10 after 1 retries

# iwlist wlan0 scan
[  244.260000] libertas: problem fetching packet from firmware
[  247.800000] libertas: command 0x0006 timed out
[  247.800000] libertas: requeueing command 0x0006 due to timeout (#1)
[  248.260000] libertas: Received result 0 to command 6 after 1 retries
[  249.920000] libertas: problem fetching packet from firmware
[  253.560000] libertas: command 0x0006 timed out
[  253.560000] libertas: requeueing command 0x0006 due to timeout (#1)
[  254.920000] libertas: problem fetching packet from firmware
wlan0     Failed to read scan data : Resource temporarily unavailable
