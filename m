From: Richard Zhao <richard.zhao@linaro.org>
Subject: [PATCH V2 07/14] ARM: mxc: audmux-v2: add clk_prepare/clk_unprepare
Date: Fri, 11 Nov 2011 09:10:22 +0800
Message-ID: <1320973829-4388-8-git-send-email-richard.zhao@linaro.org>
References: <1320973829-4388-1-git-send-email-richard.zhao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1320973829-4388-1-git-send-email-richard.zhao@linaro.org>
Sender: netdev-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org, netdev@vger.kernel.org, linux-serial@vger.kernel.org
Cc: linux@arm.linux.org.uk, amit.kucheria@canonical.com, kernel@pengutronix.de, ben-linux@fluff.org, cjb@laptop.org, alan@linux.intel.com, eric.miao@linaro.org, Richard Zhao <richard.zhao@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/plat-mxc/audmux-v2.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-mxc/audmux-v2.c b/arch/arm/plat-mxc/audmux-v2.c
index 8cced35..0e51fc3 100644
--- a/arch/arm/plat-mxc/audmux-v2.c
+++ b/arch/arm/plat-mxc/audmux-v2.c
@@ -73,13 +73,13 @@ static ssize_t audmux_read_file(struct file *file, char __user *user_buf,
 		return -ENOMEM;
 
 	if (audmux_clk)
-		clk_enable(audmux_clk);
+		clk_prepare_enable(audmux_clk);
 
 	ptcr = readl(audmux_base + MXC_AUDMUX_V2_PTCR(port));
 	pdcr = readl(audmux_base + MXC_AUDMUX_V2_PDCR(port));
 
 	if (audmux_clk)
-		clk_disable(audmux_clk);
+		clk_disable_unprepare(audmux_clk);
 
 	ret = snprintf(buf, PAGE_SIZE, "PDCR: %08x\nPTCR: %08x\n",
 		       pdcr, ptcr);
@@ -172,13 +172,13 @@ int mxc_audmux_v2_configure_port(unsigned int port, unsigned int ptcr,
 		return -ENOSYS;
 
 	if (audmux_clk)
-		clk_enable(audmux_clk);
+		clk_prepare_enable(audmux_clk);
 
 	writel(ptcr, audmux_base + MXC_AUDMUX_V2_PTCR(port));
 	writel(pdcr, audmux_base + MXC_AUDMUX_V2_PDCR(port));
 
 	if (audmux_clk)
-		clk_disable(audmux_clk);
+		clk_disable_unprepare(audmux_clk);
 
 	return 0;
 }
-- 
1.7.5.4
