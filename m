From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 0/5] SDIO support for "powered" suspend
Date: Tue, 09 Feb 2010 15:29:21 -0500
Message-ID: <1265747366-6676-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:12186 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab0BIU3t (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Feb 2010 15:29:49 -0500
Received: from localhost.localdomain ([66.130.28.92])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KXL00I4TCXNVXE0@VL-MH-MR002.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Tue, 09 Feb 2010 15:29:47 -0500 (EST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org

This patch series provide the core changes needed to allow SDIO cards to
remain powered and active while the host system is suspended, and let
them wake up the host system when needed.  This is used to implement
wake-on-land with SDIO wireless cards at the moment.  Patches to add that
support to the libertas driver will be posted separately.


Nicolas



