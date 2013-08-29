From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH v7 0/3] mmc: dw_mmc: fixes for suspend/resume on exynos
Date: Thu, 29 Aug 2013 09:39:07 -0700
Message-ID: <1377794350-12335-1-git-send-email-dianders@chromium.org>
References: <1377188348-3418-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1377188348-3418-1-git-send-email-dianders@chromium.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chris Ball <cjb@laptop.org>
Cc: James Hogan <james.hogan@imgtec.com>, Seungwon Jeon <tgih.jun@samsung.com>, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, linux-mmc@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, Doug Anderson <dianders@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, Grant Grundler <grundler@chromium.org>, linux-samsung-soc@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

This series of patches addresses some suspend/resume problems with
dw_mmc on exynos platforms, espeically exynos5420.  This patchset was
tested on the current ToT Chromeos 3.8 tree (which has lots of
backports from 3.10/3.11) and on ToT Linux (v3.11-rc6).  I have
confirmed basic booting and that SD cards work across suspend/resume
(both if they are plugged in and if they are not plugged in).

I have received confirmation from Samsung that the problem solved for
exynos5420 is a silicon errata and that this is a good fix.

Changes in v7:
- Avoid printing the same clock over and over again w/ MMC_CLKGATE.

Changes in v6:
- Took out TODO comment copied from main platform code.
- Replaces previous pathes that ensured saving/restoring clocks.

Changes in v5:
- Cleaned up dw_mci_exynos_resume_noirq() comment as per Seungwon.
- Don't memcpy dev_pm_ops structure, define a new one.

Changes in v4:
- Take Seungwon's suggestion and don't add any dw_mmc-pltfm code.

Changes in v3:
- Add freeze/thaw and poweroff/restore noirq entries.

Changes in v2:
- Use suspend_noirq as per James Hogan.

Doug Anderson (3):
  mmc: dw_mmc: Add exynos resume_noirq callback to clear WAKEUP_INT
  mmc: dw_mmc: Honor requests to set the clock to 0 (turn off clock)
  mmc: dw_mmc: Set timeout to max upon resume

 drivers/mmc/host/dw_mmc-exynos.c | 53 +++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/dw_mmc.c        | 39 ++++++++++++++++++-----------
 2 files changed, 77 insertions(+), 15 deletions(-)

-- 
1.8.4
