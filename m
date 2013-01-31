From: "Manjunathappa, Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/3] Add DT support for davinci_mmc driver
Date: Thu, 31 Jan 2013 16:03:04 +0530
Message-ID: <1359628387-14437-1-git-send-email-prakash.pm@ti.com>
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
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mporter-l0cyMroinI0@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, hs-ynQEQJNshbs@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Patch set adds DT support for davinci_mmc driver and is
verified on da850-evm without card_detect/write_protect and
EDMA support.

This patch depends on below patches under review:
1) Patch "pinctrl: pinctrl-single: use arch_initcall and module_exit"
	http://www.gossamer-threads.com/lists/linux/kernel/1669067
2) Patch "drivers/pinctrl: grab default handles from device core"
	http://www.gossamer-threads.com/lists/linux/kernel/1664015?page=last
3) Patch "mmc: davinci: allow driver to work without DMA resource"
	http://permalink.gmane.org/gmane.linux.kernel.mmc/18978

Applies on top of v3.9/dt branch of linux_davinci tree:
git://gitorious.org/linux-davinci/linux-davinci.git

Manjunathappa, Prakash (3):
  ARM: davinci: da850: override mmc DT node device name
  mmc: davinci_mmc: add DT support
  ARM: davinci: da850: add mmc DT entries

 .../devicetree/bindings/mmc/davinci_mmc.txt        |   23 +++++++
 arch/arm/boot/dts/da850-evm.dts                    |   13 ++++
 arch/arm/boot/dts/da850.dtsi                       |   15 ++++
 arch/arm/mach-davinci/da8xx-dt.c                   |    8 ++-
 drivers/mmc/host/davinci_mmc.c                     |   69 +++++++++++++++++++-
 5 files changed, 126 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/davinci_mmc.txt

-- 
1.7.4.1
