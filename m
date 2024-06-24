Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112C6137C2E
	for <linux-mmc@vger.kernel.org>; Mon, 24 Jun 2024 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228381; cv=none; b=R6jo9FNNchZHLa2QdYfnXSPGQ3hQgtiZbi9hXkUi0idM1X58tqPw11XtWFydhBVeL7BYxJN/qmT2aQwxUDy9CpYYwuwj9NvHyYzks7nNsQFi4edaZm9gWRDyUKxHOxHG5tktfJ2oI4xmNHwokRw1QsHcYW/BnhqwtH2g/vGOttk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228381; c=relaxed/simple;
	bh=2fHLwq6Sx13RJTIxbWO0DRg6QnzlfDOKqNQsOy+e+ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ek4TwG+mYs21X3+d/QrVGj6OIYaQD2Z92vPQsxlEXCYnsw4kEHL6Ufsq2gjXMC4uUglUTCvAevDQvB+wH/Nq3cg0J2WSpodQIlMIBFtEYSfHyHbMqWIsfyhX6X8zDT4mk73ghgJ6UNR9utJITW/q1aBCwnVwthxRZrr8oqYL3dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=efilo41k; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="efilo41k"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719228377; x=1750764377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2fHLwq6Sx13RJTIxbWO0DRg6QnzlfDOKqNQsOy+e+ks=;
  b=efilo41kmBPQnD9w2hs5RqNJT5hmx7rZLh9bo3f81hl8cJYPQ/QuqqK8
   C+XmERqe9DM4iP+YluIh20/Tgg34sUGwVUwcE1FGNx9kHAJrLmFnRk+o6
   p4z5b9eP3wCP4Kqg2xIKR8gGBNOG5UhLO71KedTVMheKLNavU0A/Ps8xw
   z7FEL1g/ds+PLieNZypK7vgVyyTTfZ+/78FVyosPHnItwLZ5KqJAnwJU3
   fK7214B/wP3s9UwUnIBt6YusZtXTUikhEMVK22XOW+P3eGwCorxn5EuQn
   8FAjvX6grCag7RLdNmCDpw1wuzzXABKFYPjDloPG5FF2SCRUMR9rbFHBT
   g==;
X-CSE-ConnectionGUID: N+kdGaFRRNC8m0WkdIflAg==
X-CSE-MsgGUID: xKG5mJcaRxqQr7DrVU94cA==
X-IronPort-AV: E=Sophos;i="6.08,261,1712592000"; 
   d="scan'208";a="20200260"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2024 19:26:11 +0800
IronPort-SDR: 66794b63_VYQmn3UP1bkF46epE3RJcDy/0nPlZWg5w1EzfHdxzyvbP1U
 gNNE/BC5djamC0xBcQQ+v58FO5ONbGqbE+svkXQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jun 2024 03:33:08 -0700
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Jun 2024 04:26:10 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 1/2] mmc-utils: Add documentation section
Date: Mon, 24 Jun 2024 14:25:41 +0300
Message-ID: <20240624112542.25657-2-avri.altman@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240624112542.25657-1-avri.altman@wdc.com>
References: <20240624112542.25657-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds the essentials for mmc-utils documentation to meet
read-the-docs requirements. run `make html-docs` and direct your browser
to ./docs/_build/html/index.html.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 .gitignore      |  1 +
 Makefile        |  5 ++++
 docs/HOWTO.rst  | 67 +++++++++++++++++++++++++++++++++++++++++++
 docs/Makefile   | 20 +++++++++++++
 docs/README.rst | 76 +++++++++++++++++++++++++++++++++++++++++++++++++
 docs/conf.py    | 53 ++++++++++++++++++++++++++++++++++
 docs/index.rst  | 17 +++++++++++
 7 files changed, 239 insertions(+)
 create mode 100644 docs/HOWTO.rst
 create mode 100644 docs/Makefile
 create mode 100644 docs/README.rst
 create mode 100644 docs/conf.py
 create mode 100644 docs/index.rst

diff --git a/.gitignore b/.gitignore
index 2a0cb30..be1ead0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,4 @@
 .*.o.d
 *.o
+docs/_build
 /mmc
diff --git a/Makefile b/Makefile
index a890833..533f884 100644
--- a/Makefile
+++ b/Makefile
@@ -47,6 +47,7 @@ manpages:
 clean:
 	rm -f $(progs) $(objects)
 	$(MAKE) -C man clean
+	$(MAKE) -C docs clean
 
 install: $(progs)
 	$(INSTALL) -m755 -d $(DESTDIR)$(bindir)
@@ -56,3 +57,7 @@ install: $(progs)
 -include $(foreach obj,$(objects), $(dir $(obj))/.$(notdir $(obj)).d)
 
 .PHONY: all clean install manpages install-man
+
+# Add this new target for building HTML documentation using docs/Makefile
+html-docs:
+	$(MAKE) -C docs html
diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst
new file mode 100644
index 0000000..0ce7279
--- /dev/null
+++ b/docs/HOWTO.rst
@@ -0,0 +1,67 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+Running mmc-utils
+-----------------
+**Name**
+    mmc - a tool for configuring MMC storage devices
+**Synopsis**
+    ``mmc [options] [mmc-block-device]...``
+**Description**
+    *mmc-utils* is a single-threaded tool that will perform a specified type of mmc action as specified by the user.
+    The typical use of mmc-utils is to access the mmc device either for configuring or reading its configuration registers.
+**Options**
+    ``help | --help | -h | (no arguments)``
+        Shows the abbreviated help menu in the terminal.
+
+**Commands**
+    ``extcsd read <device>``
+        Print extcsd data from <device>.
+
+    ``extcsd write <offset> <value> <device>``
+        Write <value> at offset <offset> to <device>'s extcsd.
+
+    ``writeprotect boot get <device>``
+        Print the boot partitions write protect status for <device>.
+
+    ``writeprotect boot set [-p] <device> [<number>]``
+        Set the boot partition write protect status for <device>.
+        If <number> is passed (0 or 1), only protect that particular eMMC boot partition, otherwise protect both. It will be write-protected until the next boot.
+        -p  Protect partition permanently instead. NOTE! -p is a one-time programmable (unreversible) change.
+
+    ``writeprotect user set <type> <start block> <blocks> <device>``
+        Set user area write protection.
+
+    ``scr read <device path>``
+        Print SCR data from <device path>. The device path should specify the scr file directory.
+
+    ``ffu <image name> <device> [chunk-bytes]``
+        Run Field Firmware Update with <image name> on <device>. [chunk-bytes] is optional and defaults to its max - 512k. Should be in decimal bytes and sector aligned.
+
+    ``erase <type> <start address> <end address> <device>``
+        Send Erase CMD38 with specific argument to the <device>. NOTE!: This will delete all user data in the specified region of the device. <type> must be one of: legacy, discard, secure-erase, secure-trim1, secure-trim2, or trim.
+
+    ``gen_cmd read <device> [arg]``
+        Send GEN_CMD (CMD56) to read vendor-specific format/meaning data from <device>. NOTE!: [arg] is optional and defaults to 0x1. If [arg] is specified, then [arg] must be a 32-bit hexadecimal number, prefixed with 0x/0X. And bit0 in [arg] must be 1.
+
+    ``lock <parameter> <device> [password] [new_password]``
+        Usage: mmc lock <s|c|l|u|e> <device> [password] [new_password]. <password> can be up to 16 character plaintext or hex string starting with 0x. s=set password, c=clear password, l=lock, sl=set password and lock, u=unlock, e=force erase.
+
+    ``softreset <device>``
+        Issues a CMD0 softreset, e.g., for testing if hardware reset for UHS works.
+
+    ``preidle <device>``
+        Issues a CMD0 GO_PRE_IDLE.
+
+    ``boot_operation <boot_data_file> <device>``
+        Does the alternative boot operation and writes the specified starting blocks of boot data into the requested file. Note some limitations: The boot operation must be configured, e.g., for legacy speed. The MMC must currently be running at the bus mode that is configured for the boot operation (HS200 and HS400 not supported at all). Only up to 512K bytes of boot data will be transferred. The MMC will perform a soft reset, if your system cannot handle that do not use the boot operation from mmc-utils.
+
+
+
+    ``mmc rpmb write-block <rpmb device> <address> <256 byte data file> <key file>``
+        Writes a block of data to the RPMB partition.
+
+    ``mmc rpmb read-counter <rpmb device>``
+        Reads the write counter from the RPMB partition.
+
+    ``mmc rpmb read-block <rpmb device> <address> <blocks count> <output file> [key file]``
+        Reads blocks of data from the RPMB partition.
diff --git a/docs/Makefile b/docs/Makefile
new file mode 100644
index 0000000..d4bb2cb
--- /dev/null
+++ b/docs/Makefile
@@ -0,0 +1,20 @@
+# Minimal makefile for Sphinx documentation
+#
+
+# You can set these variables from the command line, and also
+# from the environment for the first two.
+SPHINXOPTS    ?=
+SPHINXBUILD   ?= sphinx-build
+SOURCEDIR     = .
+BUILDDIR      = _build
+
+# Put it first so that "make" without argument is like "make help".
+help:
+	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
+
+.PHONY: help Makefile
+
+# Catch-all target: route all unknown targets to Sphinx using the new
+# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
+%: Makefile
+	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
diff --git a/docs/README.rst b/docs/README.rst
new file mode 100644
index 0000000..dd07ffc
--- /dev/null
+++ b/docs/README.rst
@@ -0,0 +1,76 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+README Intro
+--------------------
+
+mmc-utils is a tool for configuring MMC storage devices from userspace.
+
+
+Source
+------
+
+mmc-utils resides in a git repo, the canonical place is:
+
+https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc-utils.git
+
+
+Mailing list
+------------
+
+The project uses the kernel's mmc mailing list.  There you should submit your
+patches, ask for help, or discuss mmc-utils related issues. A patch should be
+sent as a mail to the linux-mmc@vger.kernel.org mailing list with maintainers
+as Cc recipients.  Archives can be found here:
+
+    https://www.spinics.net/lists/linux-mmc/
+
+or here:
+
+    https://lore.kernel.org/linux-mmc/
+
+
+Author
+------
+
+mmc-utils was written by Chris Ball <cjb@laptop.org> and <chris@printf.net>.
+
+
+Maintainers
+-----------
+
+Avri Altman <avri.altman@wdc.com>
+Ulf Hansson <ulf.hansson@linaro.org>
+
+
+Building
+--------
+
+Just type::
+
+ $ make
+ $ make install
+
+Note that GNU make is required.  Make install also builds the man page
+
+To cross-compile mmc-utils you can use environment variables. e.g. to build
+statically linked for ARM64::
+
+ $ make clean
+ $ CC=aarch64-linux-gnu-gcc CFLAGS=' -g -O2 -static' make
+
+
+Documentation
+-------------
+
+mmc-utils uses Sphinx_ to generate documentation from the reStructuredText_ files.
+To build HTML formatted documentation run ``make html-docs`` and direct your
+browser to :file:`./docs/_build/html/index.html`.
+
+.. _reStructuredText: https://www.sphinx-doc.org/rest.html
+.. _Sphinx: https://www.sphinx-doc.org
+
+
+License
+-------
+
+This project is licensed under GPL-2.0-only.
diff --git a/docs/conf.py b/docs/conf.py
new file mode 100644
index 0000000..9c08a23
--- /dev/null
+++ b/docs/conf.py
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Configuration file for the Sphinx documentation builder.
+#
+# This file only contains a selection of the most common options. For a full
+# list see the documentation:
+# https://www.sphinx-doc.org/en/master/usage/configuration.html
+
+# -- Path setup --------------------------------------------------------------
+
+# If extensions (or modules to document with autodoc) are in another directory,
+# add these directories to sys.path here. If the directory is relative to the
+# documentation root, use os.path.abspath to make it absolute, like shown here.
+#
+# import os
+# import sys
+# sys.path.insert(0, os.path.abspath('.'))
+
+
+# -- Project information -----------------------------------------------------
+
+project = 'mmc-utils'
+copyright = '2024, Chris Ball'
+author = 'Chris Ball'
+
+
+# -- General configuration ---------------------------------------------------
+
+# Add any Sphinx extension module names here, as strings. They can be
+# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
+# ones.
+extensions = [
+]
+
+# Add any paths that contain templates here, relative to this directory.
+templates_path = ['_templates']
+
+# List of patterns, relative to source directory, that match files and
+# directories to ignore when looking for source files.
+# This pattern also affects html_static_path and html_extra_path.
+exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']
+
+
+# -- Options for HTML output -------------------------------------------------
+
+# The theme to use for HTML and HTML Help pages.  See the documentation for
+# a list of builtin themes.
+#
+html_theme = 'alabaster'
+
+# Add any paths that contain custom static files (such as style sheets) here,
+# relative to this directory. They are copied after the builtin static files,
+# so a file named "default.css" will overwrite the builtin "default.css".
+html_static_path = ['_static']
diff --git a/docs/index.rst b/docs/index.rst
new file mode 100644
index 0000000..9f61927
--- /dev/null
+++ b/docs/index.rst
@@ -0,0 +1,17 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. mmc-utils documentation master file, created by
+   sphinx-quickstart on Sat Jun 22 16:14:46 2024.
+   You can adapt this file completely to your liking, but it should at least
+   contain the root `toctree` directive.
+
+Welcome to mmc-utils's documentation!
+=====================================
+
+.. toctree::
+   :maxdepth: 2
+   :caption: Contents
+
+   ../README.rst
+   ../HOWTO.rst
+
+
-- 
2.34.1

