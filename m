From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v2 1/7] mn10300: fix build failure
Date: Thu, 18 Jun 2015 17:47:47 +0530
Message-ID: <1434629873-11668-2-git-send-email-sudipm.mukherjee@gmail.com>
References: <1434629873-11668-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434629873-11668-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-am33-list@redhat.com, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: linux-mmc@vger.kernel.org

allmodconfig build fails with the error:
invalid use of undefined type 'struct kprobe_ctlblk'

just declared the two basic structures after checking the struct in other
architectures.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 arch/mn10300/include/asm/kprobes.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/mn10300/include/asm/kprobes.h b/arch/mn10300/include/asm/kprobes.h
index c800b59..c90d2b1 100644
--- a/arch/mn10300/include/asm/kprobes.h
+++ b/arch/mn10300/include/asm/kprobes.h
@@ -47,4 +47,16 @@ extern int kprobe_exceptions_notify(struct notifier_block *self,
 
 extern void arch_remove_kprobe(struct kprobe *p);
 
+struct prev_kprobe {
+	struct kprobe *kp;
+	unsigned long status;
+};
+
+struct kprobe_ctlblk {
+	unsigned int kprobe_status;
+	struct pt_regs jprobe_saved_regs;
+	char jprobes_stack[MAX_STACK_SIZE];
+	struct prev_kprobe prev_kprobe;
+};
+
 #endif /* _ASM_KPROBES_H */
-- 
1.8.1.2
