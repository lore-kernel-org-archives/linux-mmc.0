From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH 4/5] ARM: keystone: defconfig: Enable MMC support
Date: Tue, 20 Oct 2015 16:50:08 -0500
Message-ID: <1445377809-12516-4-git-send-email-fcooper@ti.com>
References: <1445377809-12516-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1445377809-12516-1-git-send-email-fcooper@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux@arm.linux.org.uk, ssantosh@kernel.org, ulf.hansson@linaro.org, m-karicheri2@ti.com, grygorii.strashko@ti.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-mmc@vger.kernel.org

Newer Keystone 2 devices support MMC and can boot from MMC. Therefore,
enable MMC support along with MMC OMAP HS whose driver is reused.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/configs/keystone_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index e0e0365..ed3e83e 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -137,6 +137,8 @@ CONFIG_I2C_DAVINCI=y
 CONFIG_SPI=y
 CONFIG_SPI_DAVINCI=y
 CONFIG_SPI_SPIDEV=y
+CONFIG_MMC=y
+CONFIG_MMC_OMAP_HS=y
 # CONFIG_HWMON is not set
 CONFIG_POWER_SUPPLY=y
 CONFIG_POWER_RESET=y
-- 
2.6.1
