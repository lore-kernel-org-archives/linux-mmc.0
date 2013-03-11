From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [GIT PULL] ARM: tegra: DT-related fixes needed by the MMC tree
Date: Mon, 11 Mar 2013 14:44:10 -0600
Message-ID: <1363034651-21472-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:58885 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994Ab3CKUoS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Mar 2013 16:44:18 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@wwwdotorg.org>

In order to convert the Tegra MMC driver to using mmc_of_parse(), some
bugs in the Tegra device-tree content need to be fixed first; it's
currently wrong but unused, and mmc_of_parse() causes that data to be
used for the first time.

----------------------------------------------------------------

The following changes since commit 6dbe51c251a327e012439c4772097a13df43c5b8:

  Linux 3.9-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.10-fixes-for-mmc

for you to fetch changes up to 908ab9368866e6edf0edebdd546adefd5f3128f9:

  ARM: dts: tegra: fix the activate polarity of cd-gpio in mmc host

----------------------------------------------------------------

Joseph Lo (1):
      ARM: dts: tegra: fix the activate polarity of cd-gpio in mmc host

 arch/arm/boot/dts/tegra20-colibri-512.dtsi |    2 +-
 arch/arm/boot/dts/tegra20-harmony.dts      |    4 ++--
 arch/arm/boot/dts/tegra20-paz00.dts        |    2 +-
 arch/arm/boot/dts/tegra20-seaboard.dts     |    2 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi    |    2 +-
 arch/arm/boot/dts/tegra20-trimslice.dts    |    2 +-
 arch/arm/boot/dts/tegra20-ventana.dts      |    2 +-
 arch/arm/boot/dts/tegra20-whistler.dts     |    1 +
 arch/arm/boot/dts/tegra30-beaver.dts       |    2 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi      |    2 +-
 10 files changed, 11 insertions(+), 10 deletions(-)
