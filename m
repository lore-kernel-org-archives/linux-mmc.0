From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/3] mmc: sdhci: refactor PM in sdhci-pltfm and support PM for
 cadence port
Date: Mon, 31 Jul 2017 21:56:46 +0900
Message-ID: <1501505809-393-1-git-send-email-yamada.masahiro@socionext.com>
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
To: linux-mmc@vger.kernel.org
Cc: Barry Song <baohua@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Al Cooper <alcooperx@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, bcm-kernel-feedback-list@broadcom.com, Gregory Fong <gregory.0xf0@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Brian Norris <computersforpeace@gmail.com>, linux-arm-kernel@lists.infradead.org, Piotr Sroka <piotrs@cadence.com>
List-Id: linux-mmc@vger.kernel.org


[1] adds clk handling for suspend/resume hooks of sdhci-pltfm.
    This also cleans up sdhci-brcmstb.c and sdhci-sirf.c

[2] exports suspend / resume, which will be used by [3]

[3] implements suspend / resume for sdhci-cadence.c



Masahiro Yamada (3):
  mmc: sdhci: enable/disable the clock in sdhci_pltfm_suspend/resume
  mmc: sdhci-pltfm: export sdhci_pltfm_suspend/resume
  mmc: sdhci-cadence: add suspend / resume support

 drivers/mmc/host/sdhci-brcmstb.c | 37 +------------------
 drivers/mmc/host/sdhci-cadence.c | 77 +++++++++++++++++++++++++++++++++++-----
 drivers/mmc/host/sdhci-pltfm.c   | 22 ++++++++++--
 drivers/mmc/host/sdhci-pltfm.h   |  2 ++
 drivers/mmc/host/sdhci-sirf.c    | 39 +-------------------
 5 files changed, 91 insertions(+), 86 deletions(-)

-- 
2.7.4
