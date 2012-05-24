From: <ludovic.desroches@atmel.com>
Subject: [PATCH v5 0/4] atmel-mci device tree support
Date: Thu, 24 May 2012 17:15:52 +0200
Message-ID: <1337872556-17667-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:47620 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755926Ab2EXPQQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 May 2012 11:16:16 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nicolas.ferre@atmel.com, plagnioj@jcrosoft.com

Hi,

This patch-set adds device tree support for atmel-mci.

Regards

Ludovic

v5:
- cleanup
- split dts commit: one for SOCs, one for boards

v4:
- cleanup
- add extra chips and boards for atmel-mci dt support

v3:
- use cd-inverted instead of cd-invert to follow mmc common binding.
- don't assign a pointer to pdev->dev.platform.
- add mci controller nodes to other chips and boards.
- put all dts file changes together.

v2:
- squash patch v1 2/4 and 3/4.
- change atmci_get_of_slots to atmci_of_init and manage pdata allocation into
it.
- correct potential issue (e.g. having only one slot which is not slot0 into
the dt) about slots by adding a reg property corresponding to the slot id.

