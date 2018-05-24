From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v2 10/13] dmaengine: pxa: document pxad_param
Date: Thu, 24 May 2018 09:07:00 +0200
Message-ID: <20180524070703.11901-11-robert.jarzmik@free.fr>
References: <20180524070703.11901-1-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180524070703.11901-1-robert.jarzmik@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, netdev@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-mtd@lists.infradead.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Add some documentation for the pxad_param structure, and describe the
contract behind the minimal required priority of a DMA channel.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 include/linux/dma/pxa-dma.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/dma/pxa-dma.h b/include/linux/dma/pxa-dma.h
index e56ec7af4fd7..9fc594f69eff 100644
--- a/include/linux/dma/pxa-dma.h
+++ b/include/linux/dma/pxa-dma.h
@@ -9,6 +9,15 @@ enum pxad_chan_prio {
 	PXAD_PRIO_LOWEST,
 };
 
+/**
+ * struct pxad_param - dma channel request parameters
+ * @drcmr: requestor line number
+ * @prio: minimal mandatory priority of the channel
+ *
+ * If a requested channel is granted, its priority will be at least @prio,
+ * ie. if PXAD_PRIO_LOW is required, the requested channel will be either
+ * PXAD_PRIO_LOW, PXAD_PRIO_NORMAL or PXAD_PRIO_HIGHEST.
+ */
 struct pxad_param {
 	unsigned int drcmr;
 	enum pxad_chan_prio prio;
-- 
2.11.0
