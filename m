From: David Howells <dhowells@redhat.com>
Subject: [PATCH 15/39] Annotate hardware config module parameters in
 drivers/mmc/host/
Date: Thu, 01 Dec 2016 12:31:33 +0000
Message-ID: <148059549344.31612.12236882756723838011.stgit@warthog.procyon.org.uk>
References: <148059537897.31612.9461043954611464597.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <148059537897.31612.9461043954611464597.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gnomes@lxorguk.ukuu.org.uk, Ulf Hansson <ulf.hansson@linaro.org>, minyard@acm.org, linux-mmc@vger.kernel.org, dhowells@redhat.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Pierre Ossman <pierre@ossman.eu>
List-Id: linux-mmc@vger.kernel.org

When the kernel is running in secure boot mode, we lock down the kernel to
prevent userspace from modifying the running kernel image.  Whilst this
includes prohibiting access to things like /dev/mem, it must also prevent
access by means of configuring driver modules in such a way as to cause a
device to access or modify the kernel image.

To this end, annotate module_param* statements that refer to hardware
configuration and indicate for future reference what type of parameter they
specify.  The parameter parser in the core sees this information and can
skip such parameters with an error message if the kernel is locked down.
The module initialisation then runs as normal, but just sees whatever the
default values for those parameters is.

Note that we do still need to do the module initialisation because some
drivers have viable defaults set in case parameters aren't specified and
some drivers support automatic configuration (e.g. PNP or PCI) in addition
to manually coded parameters.

This patch annotates drivers in drivers/mmc/host/.

Suggested-by: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Pierre Ossman <pierre@ossman.eu>
cc: Ulf Hansson <ulf.hansson@linaro.org>
cc: linux-mmc@vger.kernel.org
---

 drivers/mmc/host/wbsd.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index c3fd16d997ca..76c7f643fab5 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1995,11 +1995,11 @@ static void __exit wbsd_drv_exit(void)
 module_init(wbsd_drv_init);
 module_exit(wbsd_drv_exit);
 #ifdef CONFIG_PNP
-module_param_named(nopnp, param_nopnp, uint, 0444);
+module_param_hw_named(nopnp, param_nopnp, uint, other, 0444);
 #endif
-module_param_named(io, param_io, uint, 0444);
-module_param_named(irq, param_irq, uint, 0444);
-module_param_named(dma, param_dma, int, 0444);
+module_param_hw_named(io, param_io, uint, ioport, 0444);
+module_param_hw_named(irq, param_irq, uint, irq, 0444);
+module_param_hw_named(dma, param_dma, int, dma, 0444);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Pierre Ossman <pierre@ossman.eu>");
