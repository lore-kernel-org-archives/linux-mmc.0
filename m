From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [GIT PULL v2] at91: fixes for 3.7-rc7
Date: Tue, 20 Nov 2012 09:59:27 +0100
Message-ID: <50AB466F.5010500@atmel.com>
References: <50AA5ED5.8090901@atmel.com> <CAOesGMjAYtEkmEYnzCQ4G821BWG9D6LHvgt5aOMJgus_hzFkRA@mail.gmail.com> <50AA6C76.3000606@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50AA6C76.3000606@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-mmc@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, Ludovic Desroches <ludovic.desroches@atmel.com>, Chris Ball <cjb@laptop.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Arnd, Olof,

Just for the record, I do not want to put pressure at a such late time in
the 3.7-rc process. So, I just reworked that pull-request because the previous
one was wrong:
- wrong patch content (DT nodes with wrong size)
- not all tags in patches (Jean-Christophe and Arnd tags were missing...)

Just to start from a sane base if I have to rebase this work for 3.8, I let you know
that I have updated this tag...

The following changes since commit 641f3ce64b050961d454a0716bb6dbf528315aac:

  ARM: at91/usbh: fix overcurrent gpio setup (2012-11-16 10:46:29 +0100)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-fixes

for you to fetch changes up to 6a342d1ee6ff7d5b3e5a0665457f1772e7fe640a:

  ARM: at91/dts: add nodes for atmel hsmci controllers for atmel boards (2012-11-20 09:51:07 +0100)

----------------------------------------------------------------
Add entries for enabling the use of sd/mmc driver on AT91.
Those entries where missing for device tree use on these
platforms.

----------------------------------------------------------------
Ludovic Desroches (3):
      ARM: at91: add clocks for DT entries
      ARM: at91/dts: add nodes for atmel hsmci controllers for atmel SOCs
      ARM: at91/dts: add nodes for atmel hsmci controllers for atmel boards

 arch/arm/boot/dts/at91sam9260.dtsi          |  9 +++++++++
 arch/arm/boot/dts/at91sam9263.dtsi          | 18 ++++++++++++++++++
 arch/arm/boot/dts/at91sam9263ek.dts         | 10 ++++++++++
 arch/arm/boot/dts/at91sam9g20ek_2mmc.dts    | 12 ++++++++++++
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |  9 +++++++++
 arch/arm/boot/dts/at91sam9g25ek.dts         | 18 ++++++++++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi          | 18 ++++++++++++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts      | 19 +++++++++++++++++++
 arch/arm/boot/dts/at91sam9n12.dtsi          |  9 +++++++++
 arch/arm/boot/dts/at91sam9n12ek.dts         |  9 +++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi           | 18 ++++++++++++++++++
 arch/arm/mach-at91/at91sam9260.c            |  1 +
 arch/arm/mach-at91/at91sam9263.c            |  2 ++
 arch/arm/mach-at91/at91sam9g45.c            |  2 ++
 arch/arm/mach-at91/at91sam9n12.c            |  1 +
 arch/arm/mach-at91/at91sam9x5.c             |  2 ++
 16 files changed, 157 insertions(+)

Bye,
-- 
Nicolas Ferre
