From: Olliver Schinagl <oliver@schinagl.nl>
Subject: [PATCHv1 0/2] mmc: Move broken-hpi also to the chipset level
Date: Tue, 19 Apr 2016 09:12:12 +0200
Message-ID: <1461049934-12848-1-git-send-email-oliver@schinagl.nl>
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
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Michal Hocko <mhocko@suse.com>, Lars-Peter Clausen <lars@metafoo.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Wenkai Du <wenkai.du@intel.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Hans de Goede <hdegoede@redhat.com>, Jaehoon Chung <jh80.chung@samsung.com>, Michal Suchanek <hramrach@gmail.com>
Cc: Olliver Schinagl <oliver@schinagl.nl>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

A few months ago, hans de Goede and I where talking about the behavior of HPI on
eMMC modules. We came to the conclusion that more often then not, the mmc
chipset might be the problem and not the eMMC module itself. To remedy this the
broken-hpi parameter is now also checked on the chipset level.

On the sunxi platform, all the eMMC users with emmc modules that support HPI
need the broken-hpi flag, indicating that the sunxi mmc controller is likely
not properly supporting HPI. We disable this on the chipset level for these
chipsets.

As for the broken-hpi flag in the devicetree's, those should in theory be
removed from the boards in question in a separate patch when in agreement, as
technically, the eMMC module supports HPI just fine and thus the we are lying
about what really is broken.

This was tested on an OLinuXino Lime2 with 4GB industrial grade Micron eMMC
flash.

Olliver Schinagl (2):
  mmc: core: Improve marking broken HPI through devicetree
  mmc: sunxi: Mark the HPI of the mmc controller broken by default

 drivers/mmc/core/host.c      | 2 ++
 drivers/mmc/core/mmc.c       | 2 +-
 drivers/mmc/host/sunxi-mmc.c | 4 ++--
 include/linux/mmc/host.h     | 1 +
 4 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.8.0.rc3
