From: David Lechner <david@lechnology.com>
Subject: [PATCH 0/4] davinci_mmc device tree fixes
Date: Wed,  9 Mar 2016 17:50:01 -0600
Message-ID: <1457567405-30475-1-git-send-email-david@lechnology.com>
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
To: ulf.hansson@linaro.org, k.kozlowski.k@gmail.com, linux-mmc@vger.kernel.org
Cc: khilman@deeprootsystems.com, nsekhar@ti.com, David Lechner <david@lechnology.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

I'm working on getting a davinci device working with device tree. I came across
some issues in the davinci_mmc driver.

David Lechner (4):
  mmc: davinci: remove matching string
  mmc: davinci: fix unwinding in probe
  mmc: davinci: prepare clock
  mmc: davinci: suppress waring when using DT

 drivers/mmc/host/davinci_mmc.c | 86 ++++++++++++++++++++----------------------
 1 file changed, 41 insertions(+), 45 deletions(-)

-- 
1.9.1
