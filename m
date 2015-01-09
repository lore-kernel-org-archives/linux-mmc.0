From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Subject: [PATCH v3 0/4] mmc: sdhci: adding support for a new Fujitsu sdhci IP
Date: Fri,  9 Jan 2015 19:41:41 +0800
Message-ID: <1420803705-4539-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: ulf.hansson@linaro.org, andy.green@linaro.org, linux@arm.linux.org.uk, patches@linaro.org, chris@printf.net, Vincent Yang <Vincent.Yang@tw.fujitsu.com>, jaswinder.singh@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hello,

  Fujitsu have an sdhci IP which is implemented in a SoC we're 
adding to mainline, the most recent series for that was sent 
here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/314615.html

  We welcome any comment and advice about how to make any
improvements or better align them with upstream.

Changes since v2:
* Removed voltage-ranges because it is no longer a required property.
* Removed unnecessary error message.
* Used the devm_* managed functions and updated the error handling
accordingly.
* Removed #ifdef CONFIG_PM_RUNTIME and also updated some other #ifdef.
* Moved vendor specfic stuff prior to sdhci_add_host().
* Handled runtime PM on module removal.

Changes since v1:
* Thanks to Uffe, removed ARCH_MB86S7X dependency and separated
mmc patches to this patchset.
* Node name changed from "fujitsu,mb86s70-sdh30" to
"fujitsu,mb86s70-sdhci-3.0".

Thanks.

Vincent Yang (4):
  mmc: sdhci: add a voltage switch callback function
  mmc: sdhci: add a quirk for tuning work around
  mmc: sdhci: add a quirk for single block transactions
  mmc: sdhci: host: add new f_sdh30

 .../devicetree/bindings/mmc/sdhci-fujitsu.txt      |  30 ++
 drivers/mmc/host/Kconfig                           |   8 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci.c                           |  14 +-
 drivers/mmc/host/sdhci.h                           |   1 +
 drivers/mmc/host/sdhci_f_sdh30.c                   | 306 +++++++++++++++++++++
 include/linux/mmc/sdhci.h                          |   4 +
 7 files changed, 361 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
 create mode 100644 drivers/mmc/host/sdhci_f_sdh30.c

-- 
1.9.0
