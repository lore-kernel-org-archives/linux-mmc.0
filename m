From: <wei_wang@realsil.com.cn>
Subject: [PATCH v2] Add new model: rts5249
Date: Thu, 11 Apr 2013 10:43:39 +0800
Message-ID: <cover.1365648007.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel/>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: "devel" <devel-bounces@linuxdriverproject.org>
To: cjb@laptop.org, sameo@linux.intel.com
Cc: gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Wei WANG <wei_wang@realsil.com.cn>, rogerable@realtek.com, devel@linuxdriverproject.org
List-Id: linux-mmc@vger.kernel.org

From: Wei WANG <wei_wang@realsil.com.cn>

v2:
1. Modify copyright notice
2. Add macro definitions for phy registers
3. Replace mdelay with msleep

Wei WANG (1):
  mfd:rtsx: Support RTS5249

 drivers/mfd/Makefile         |    2 +-
 drivers/mfd/rts5249.c        |  241 ++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/rtsx_pcr.c       |    5 +
 drivers/mfd/rtsx_pcr.h       |    1 +
 include/linux/mfd/rtsx_pci.h |   36 +++++++
 5 files changed, 284 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mfd/rts5249.c

-- 
1.7.9.5
