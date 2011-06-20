From: Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH 0/4] PCI: fix cardbus and sriov regressions
Date: Mon, 20 Jun 2011 15:47:13 -0700
Message-ID: <1308610037-6261-1-git-send-email-linuxram@us.ibm.com>
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: jbarnes@virtuousgeek.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, svenkatr@ti.com, yinghai@kernel.org, cjb@laptop.org, linux-pci@vger.kernel.org, linux-net-drivers@solarflare.com, bhutchings@solarflare.com, Ram Pai <linuxram@us.ibm.com>
List-Id: linux-mmc@vger.kernel.org

The following patch-set fixes regressions caused by:

the commit "PCI: update bridge resources to get more big ranges when allocating space (again)"
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=da7822e5ad71ec9b745b412639f1e5e0ba795a20

patch 1/4: correctly calculates the additional resource size for hotplug bridges.
patch 2/4: ability to resize assigned pci-resource.
patch 3/4: makes SRIOV BARs a nice-to-have resource, which means resources will
		be attempted to assign, but not gauranteed to succeed.
patch 4/4: makes cardbus bridge resources nice-to-have resource.


The regression was caused because on some platforms with limited i/o and mem
resources, the nice-to-have resources were allocated ahead of
absolutely-required resources, thus starving the latter. The patchset will
ensure that all the mandatory resource requirements are satisfied before any
nice-to-have resource requirements are satisfied.
