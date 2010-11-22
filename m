From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 0/4] fix a memory leak related to
	request_mem_region/release_mem_region usage
Date: Mon, 22 Nov 2010 16:42:39 +0800
Message-ID: <1290415359.5471.4.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33207 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab0KVIho (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Nov 2010 03:37:44 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, Vipin Bhandari <vipin.bhandari@ti.com>, David Brownell <dbrownell@users.sourceforge.net>, Nicolas Pitre <nico@fluxnic.net>, Eric Miao <eric.y.miao@gmail.com>

This serial of patches fixes a memory leak related to request_mem_region
and release_mem_region usage.

request_mem_region() will call kzalloc to allocate memory for struct resource.
release_resource() unregisters the resource but does not free the allocated
memory, thus use release_mem_region() instead to fix the memory leak.


Axel Lin (4):
  [ARM] davinci_mmc: fix a memory leak
  [ARM] mvsdio: fix a memory leak
  [ARM] pxamci: fix a memory leak
  [ARM] mxcmmc: remove a unnecessary release_resource() call

 drivers/mmc/host/davinci_mmc.c |    5 +++--
 drivers/mmc/host/mvsdio.c      |    4 ++--
 drivers/mmc/host/mxcmmc.c      |    1 -
 drivers/mmc/host/pxamci.c      |    4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

-- 
1.7.2



