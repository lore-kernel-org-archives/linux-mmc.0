From: dragos.tatulea@intel.com
Subject: [PATCH v2 02/26] pstore: add flags
Date: Thu,  8 Nov 2012 15:06:00 +0200
Message-ID: <1352379984-18381-3-git-send-email-dragos.tatulea@intel.com>
References: <1352379984-18381-1-git-send-email-dragos.tatulea@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352379984-18381-1-git-send-email-dragos.tatulea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: kirill.shutemov@linux.intel.com, irina.tirdea@intel.com, octavian.purdila@intel.com, tony.luck@intel.com, keescook@chromium.org, dragos.tatulea@gmail.com, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Let the back end tweak pstore behaviour.  Flags added are:

	PSTORE_NO_HEADINGS

		Omit pstore heading lines from dumped data

	PSTORE_MAX_KMSG_BYTES

		Default kmsg_bytes to ULONG_MAX

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 fs/pstore/platform.c   |    9 ++++++++-
 include/linux/pstore.h |    4 ++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 108bd69..b9ab942 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -128,7 +128,11 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 		size_t len;
 
 		dst = psinfo->buf;
-		hsize = sprintf(dst, "%s#%d Part%d\n", why, oopscount, part);
+		if (psinfo->flags & PSTORE_NO_HEADINGS)
+			hsize = 0;
+		else
+			hsize = sprintf(dst, "%s#%d Part%d\n", why, oopscount,
+					part);
 		size = psinfo->bufsize - hsize;
 		dst += hsize;
 
@@ -237,6 +241,9 @@ int pstore_register(struct pstore_info *psi)
 		return -EINVAL;
 	}
 
+	if (psinfo->flags & PSTORE_MAX_KMSG_BYTES)
+		kmsg_bytes = ULONG_MAX;
+
 	if (pstore_is_mounted())
 		pstore_get_records(0);
 
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index 3a293ff..27f1995 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -40,9 +40,13 @@ enum pstore_type_id {
 
 struct module;
 
+#define PSTORE_NO_HEADINGS	BIT(0)
+#define PSTORE_MAX_KMSG_BYTES	BIT(1)
+
 struct pstore_info {
 	struct module	*owner;
 	char		*name;
+	unsigned int	flags;
 	spinlock_t	buf_lock;	/* serialize access to 'buf' */
 	char		*buf;
 	size_t		bufsize;
-- 
1.7.9.5
