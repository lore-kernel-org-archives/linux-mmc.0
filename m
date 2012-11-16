From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: [RFC RESEND PATCH 3.7.0-rc4 0/4] introduce of_simple_module_id_table macro
Date: Fri, 16 Nov 2012 13:27:20 +0000
Message-ID: <1353072440-22497-1-git-send-email-srinivas.kandagatla@st.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:40754 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751450Ab2KPN2u (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Nov 2012 08:28:50 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: grant.likely@secretlab.ca, rob.herring@calxeda.com, viresh.linux@gmail.com, g.liakhovetski@gmx.de, ian@mnementh.co.uk, thomas.ab@samsung.com
Cc: srinivas.kandagatla@st.com, spear-devel@list.st.com, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch series introduces of_simple_module_id_table macro and as an example
uses this macro in 3 files.

Most of the device tree supported drivers have of_device_id table setup with 
single compatible entry, this use-case is very simple and common.

#ifdef CONFIG_OF
static struct of_device_id xxx_of_match[] = {
	{ .compatible = "yyy,zzz" },
	{ },
};
MODULE_DEVICE_TABLE(of, xxx_of_match);
#endif

This patch adds a macro for this simple type of device table.
Other subsystems like pm, platform, have similar macros in kernel for
simplest cases.
Now the user can just replace the above code with

of_simple_module_id_table(xxx_of_match, "yyy,zzz");

There are more than 200+ hits for this type of pattern in the current kernel.

Am happy to run a script to generate cleanup patches for the hits,
However I would like to know your overall opinion on this type of patch.

Sorry for the first mail, my script used "mm" instead of "mmc".
Thanks,
srini

Srinivas Kandagatla (4):
  of: introduce of_simple_module_id_table macro.
  mmc:exynos: use of_simple_module_id_table macro.
  mmc:sdhci-spear: use of_simple_module_id_table macro.
  mmc:shmobile: use of_simple_module_id_table macro.

 drivers/mmc/host/dw_mmc-exynos.c  |    7 +------
 drivers/mmc/host/sdhci-spear.c    |    8 +-------
 drivers/mmc/host/sh_mobile_sdhi.c |    6 +-----
 include/linux/of.h                |   10 ++++++++++
 4 files changed, 13 insertions(+), 18 deletions(-)

