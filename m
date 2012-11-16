From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: [RFC PATCH 3.7.0-rc4 1/4] of: introduce of_simple_module_id_table macro.
Date: Fri, 16 Nov 2012 13:21:27 +0000
Message-ID: <1353072087-21777-1-git-send-email-srinivas.kandagatla@st.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:38664 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751599Ab2KPNW7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Nov 2012 08:22:59 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: grant.likely@secretlab.ca, rob.herring@calxeda.com, viresh.linux@gmail.com, g.liakhovetski@gmx.de, ian@mnementh.co.uk, thomas.ab@samsung.com
Cc: srinivas.kandagatla@st.com, spear-devel@list.st.com, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

Most of the drivers have of_device_id table setup with single compatible
entry, this use case is very simple and common.

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

macro without worrrying about ifdef'ng it.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 include/linux/of.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index b4e50d5..adb812b 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -280,6 +280,15 @@ extern void of_detach_node(struct device_node *);
 
 #define of_match_ptr(_ptr)	(_ptr)
 
+#define of_simple_module_id_table(name, compat) \
+	static struct of_device_id name[] = { \
+	{ \
+		.compatible = compat, \
+	}, \
+	{} \
+}; \
+MODULE_DEVICE_TABLE(of, name)
+
 /*
  * struct property *prop;
  * const __be32 *p;
@@ -438,6 +447,7 @@ static inline int of_machine_is_compatible(const char *compat)
 }
 
 #define of_match_ptr(_ptr)	NULL
+#define of_simple_module_id_table(name, compat)
 #define of_match_node(_matches, _node)	NULL
 #define of_property_for_each_u32(np, propname, prop, p, u) \
 	while (0)
-- 
1.7.0.4

