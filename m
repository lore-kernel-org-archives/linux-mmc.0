From: Ivan Mikhaylov <ivan@de.ibm.com>
Subject: [PATCH v1 0/2] add eMMC support for fsp2 board
Date: Fri, 30 Jun 2017 14:53:29 +0300
Message-ID: <20170630115331.73869-1-ivan@de.ibm.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Alistair Popple <alistair@popple.id.au>, Matt Porter <mporter@kernel.crashing.org>, Adrian Hunter <adrian.hunter@intel.com>, Patrice Chotard <patrice.chotard@st.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: kernel@stlinux.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-mmc@vger.kernel.org

fsp2 based on powerpc 476fpe using eMMC arasan, so we added support
of this inside our dts and also enabled via additional
dependence for sdhci-st driver in Kconfig.

this code depends on commit c4b56b023daa91953e9ebe91143e6ca156f0bcb7
which is located in powerpc linux tree in 'next' branch.

Ivan Mikhaylov (2):
  mmc/host: add FSP2(ppc476fpe) into depends for sdhci-st
  44x/fsp2: enable eMMC arasan for fsp2 platform

 arch/powerpc/boot/dts/fsp2.dts          |   33 +++++++++++++++++-------------
 arch/powerpc/configs/44x/fsp2_defconfig |    2 ++
 drivers/mmc/host/Kconfig                |    2 +-
 3 files changed, 22 insertions(+), 15 deletions(-)
