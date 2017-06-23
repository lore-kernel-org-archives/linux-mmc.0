From: Ivan Mikhaylov <ivan@de.ibm.com>
Subject: [PATCH 0/2] add eMMC support for fsp2 board
Date: Fri, 23 Jun 2017 18:47:24 +0300
Message-ID: <20170623154726.15019-1-ivan@de.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alistair Popple <alistair@popple.id.au>, Matt Porter <mporter@kernel.crashing.org>, Adrian Hunter <adrian.hunter@intel.com>, Patrice Chotard <patrice.chotard@st.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-mmc@vger.kernel.org, kernel@stlinux.com
List-Id: linux-mmc@vger.kernel.org

fsp2 based on powerpc 476fpe using eMMC arasan, so we added support
of this inside our dts and also enabled via additional
dependence for sdhci-st driver in Kconfig.

this code depends on commit c4b56b023daa91953e9ebe91143e6ca156f0bcb7
which is located in powerpc linux tree in 'next' branch.

Ivan Mikhaylov (2):
  mmc/host: add FSP2(ppc476fpe) into depends for sdhci-st
  44x/fsp2: enable eMMC arasan for fsp2 platform

 arch/powerpc/boot/dts/fsp2.dts          |   19 +++++++++++++++++++
 arch/powerpc/configs/44x/fsp2_defconfig |    2 ++
 drivers/mmc/host/Kconfig                |    2 +-
 3 files changed, 22 insertions(+), 1 deletions(-)
