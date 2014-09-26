From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] mmc: atmel-mci: fix mismatched section on atmci_cleanup_slot
Date: Fri, 26 Sep 2014 21:34:58 +0200
Message-ID: <201409262134.58457.arnd@arndb.de>
References: <1411467606-13041-1-git-send-email-pramod.gurav@smartplayin.com> <1411467606-13041-2-git-send-email-pramod.gurav@smartplayin.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411467606-13041-2-git-send-email-pramod.gurav@smartplayin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pramod Gurav <pramod.gurav@smartplayin.com>
Cc: linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@atmel.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

As of 528bc7808f4e ("mmc: atmel-mci: Release mmc resources on failure in probe"),
the atmci_probe() function calls atmci_cleanup_slot in the failure path.

This causes a new warning whenever the driver is built:

WARNING: drivers/mmc/host/built-in.o(.init.text+0xa04): Section mismatch in reference from the function atmci_probe() to the function .exit.text:atmci_cleanup_slot()
The function __init atmci_probe() references
a function __exit atmci_cleanup_slot().

Gcc correctly warns about this function getting dropped in the link stage
for the built-in case, which would cause undefined behavior when this error
path is hit. The solution is to simply drop the __exit annotation.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 528bc7808f4e ("mmc: atmel-mci: Release mmc resources on failure in probe")

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 772ef5b0e4d5..974626087732 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2244,7 +2244,7 @@ static int __init atmci_init_slot(struct atmel_mci *host,
 	return 0;
 }
 
-static void __exit atmci_cleanup_slot(struct atmel_mci_slot *slot,
+static void atmci_cleanup_slot(struct atmel_mci_slot *slot,
 		unsigned int id)
 {
 	/* Debugfs stuff is cleaned up by mmc core */
