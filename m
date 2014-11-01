From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [Regression Resend] mmc: mx28: sd card detection broken since
 3.18-rc1
Date: Sat, 1 Nov 2014 22:40:04 +0100 (CET)
Message-ID: <1747777414.897866.1414878004147.JavaMail.open-xchange@oxbsltgw09.schlund.de>
Reply-To: Stefan Wahren <stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, festevam@gmail.com, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi,

i was testing Linux Kernel 3.18-rc2 with my i.MX28 board (I2SE Duckbill) and ran
into the problem that the sd card isn't detected from the Kernel at booting
(driver: mxs-mmc.c). That results in a endless wait for the root partition

Here are the relevant messages (bad case):

[...]
[    1.501883] mxs-mmc 80010000.ssp: initialized
[    1.521203] TCP: cubic registered
[    1.530850] NET: Registered protocol family 10
[    1.548469] mip6: Mobile IPv6
[    1.551698] sit: IPv6 over IPv4 tunneling driver
[    1.566016] ip6_gre: GRE over IPv6 tunneling driver
[    1.575831] NET: Registered protocol family 17
[    1.581640] bridge: automatic filtering via arp/ip/ip6tables has been
deprecated. Update your scripts to load br_netfilter if you need this.
[    1.595635] Key type dns_resolver registered
[    1.604302] registered taskstats version 1
[    1.618188] stmp3xxx-rtc 80056000.rtc: setting system clock to 1970-01-01
00:00:03 UTC (3)
[    1.675580] Waiting for root device /dev/mmcblk0p3...

In Linux Kernel 3.17 that problem didn't exist (good case):

[...]
[    1.546857] mxs-mmc 80010000.ssp: initialized
[    1.576363] TCP: cubic registered
[    1.588856] NET: Registered protocol family 10
[    1.608208] mmc0: host does not support reading read-only switch. assuming
write-enable.
[    1.616927] mip6: Mobile IPv6
[    1.620028] sit: IPv6 over IPv4 tunneling driver
[    1.629900] mmc0: new high speed SDHC card at address 0007
[    1.642901] ip6_gre: GRE over IPv6 tunneling driver
[    1.652047] mmcblk0: mmc0:0007 SD16G 14.6 GiB
[    1.662108] NET: Registered protocol family 17
[    1.678091]  mmcblk0: p1 p2 p3
[...]

I've have bisected the problem to this commit:

commit 89168b48991537bec2573b3b6a8841df74465b12
Author: Linus Walleij <linus.walleij@linaro.org>
Date:   Thu Oct 2 09:08:46 2014 +0200

    mmc: core: restore detect line inversion semantics
   
    commit 98e90de99a0c43bd434da814c882c4332441871e
    "mmc: host: switch OF parser to use gpio descriptors"
    switched the semantic behaviour of card detect and read
    only flags such that the inversion capability flag would
    only be set if inversion was explicitly specified in the
    device tree, in the hopes that no-one was using double
    inversion.
   
    It turns out that the XOR:ing between the explicit
    inversion was indeed in use, so we need to restore the
    old semantics where both ways of inversion are checked
    and the end result XOR:ed.
   
    Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
    Tested-by: Javier Martinez Canillas <javier@dowhile0.org>
    Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
    Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Kernel command line: -e noinitrd console=ttyAMA0,115200 root=/dev/mmcblk0p3 rw
rootwait

It looks to me that the patch didn't fix all host controller.

BR Stefan
