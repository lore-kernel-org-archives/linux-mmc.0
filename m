From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v2 5/7] samples: kdbus: disable for mn10300
Date: Thu, 18 Jun 2015 17:47:51 +0530
Message-ID: <1434629873-11668-6-git-send-email-sudipm.mukherjee@gmail.com>
References: <1434629873-11668-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33718 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932319AbbFRMSl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Jun 2015 08:18:41 -0400
In-Reply-To: <1434629873-11668-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Howells <dhowells@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-am33-list@redhat.com, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

While building it failed with:
In function 'prime_new':
error: '__NR_memfd_create' undeclared (first use in this function)

memfd_create syscall has not yet been implemented for mn10300.
so disable compilation of samples/kdbus for now with mn10300.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 samples/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index a4c6b2f..20c55af 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -57,7 +57,7 @@ config SAMPLE_KDB
 
 config SAMPLE_KDBUS
 	bool "Build kdbus API example"
-	depends on KDBUS
+	depends on KDBUS && !MN10300
 	help
 	  Build an example of how the kdbus API can be used from
 	  userspace.
-- 
1.8.1.2

