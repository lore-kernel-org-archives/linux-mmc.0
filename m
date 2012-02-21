From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v3 0/6] mmc: sdhci-s3c: Rework platform data and add device
 tree support
Date: Tue, 21 Feb 2012 20:37:26 +0900
Message-ID: <00b901ccf08d$2fc18b50$8f44a1f0$%kim@samsung.com>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
 <003401cce730$baf979a0$30ec6ce0$%kim@samsung.com>
 <m2aa4pkq5g.fsf@bob.laptop.org> <4F3CFEED.6060206@samsung.com>
 <m239abgc32.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <m239abgc32.fsf@bob.laptop.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: 'Thomas Abraham' <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

Chris Ball wrote:
> 
> Hi,
> 
Hi,

> On Thu, Feb 16 2012, Kukjin Kim wrote:
> > I mean if I or you create topic branch for this whole series, can be
> > merged into both tree for avoiding conflicts with further working. Of
> > course, the topic branch don't have to rebase after merging into each
> > tree.
> >
> > If you're ok on this and my opinion, let me create the topic branch.
> 
> Okay, sure.  Thanks,
> 
I created topic branch for this we talked. You can pull that following:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
v3.4-for-cjb

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit d65b4e98d7ea3038b767b70fe8be959b2913f16d:

  Linux 3.3-rc3 (2012-02-08 19:21:53 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
v3.4-for-cjb

Thomas Abraham (6):
      mmc: sdhci-s3c: Remove usage of clk_type member in platform data
      ARM: EXYNOS: use 'exynos4-sdhci' as device name for sdhci controllers
      ARM: SAMSUNG: remove all uses of clk_type member in sdhci platform
data
      mmc: sdhci-s3c: derive transfer width host capability from max_width
in platform data
      mmc: sdhci-s3c: Keep a copy of platform data and use it
      mmc: sdhci-s3c: Add device tree support

 .../devicetree/bindings/mmc/samsung-sdhci.txt      |   70 ++++++
 arch/arm/mach-exynos/clock.c                       |   24 +-
 arch/arm/mach-exynos/common.c                      |    5 +
 arch/arm/mach-exynos/mach-armlex4210.c             |    3 -
 arch/arm/mach-exynos/mach-nuri.c                   |    3 -
 arch/arm/mach-exynos/mach-origen.c                 |    2 -
 arch/arm/mach-exynos/mach-smdk4x12.c               |    2 -
 arch/arm/mach-exynos/mach-smdkv310.c               |    4 -
 arch/arm/mach-exynos/mach-universal_c210.c         |    2 -
 arch/arm/plat-samsung/devs.c                       |    4 -
 arch/arm/plat-samsung/include/plat/sdhci.h         |   35 +++-
 arch/arm/plat-samsung/platformdata.c               |    2 -
 drivers/mmc/host/sdhci-s3c.c                       |  235
+++++++++++++++++++-
 13 files changed, 341 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
