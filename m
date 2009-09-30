From: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: + sdio-pass-whitelisted-cis-funce-tuples-to-sdio-drivers.patch added to -mm tree
Date: Wed, 30 Sep 2009 15:23:09 -0700 (PDT)
Message-ID: <911053.9483.qm@web28307.mail.ukl.yahoo.com>
References: <200909132245.n8DMj6l2007798@imap1.linux-foundation.org> <812485.11160.qm@web28310.mail.ukl.yahoo.com> <20090929202527.610c2138@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from web28307.mail.ukl.yahoo.com ([87.248.110.126]:47101 "HELO
	web28307.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752083AbZI3WXH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 30 Sep 2009 18:23:07 -0400
In-Reply-To: <20090929202527.610c2138@mjolnir.ossman.eu>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pierre Ossman <pierre@ossman.eu>
Cc: akpm@linux-foundation.org, linux-mmc@vger.kernel.org, Michael Buesch <mb@bu3sch.de>

Pierre Ossman wrote:
> Hi Albert,
> 
> I've had some more time to think about this, and I think I was overly
> harsh when criticizing your initial approach to this. The type field
> seems like a fairly reasonable way to extend the system (although the
> spec does not say anything about how to deal with unknown types). I
> would assume that there is some official registry for these types
> though, to avoid conflicts...
> 
> Anyway, my ideal solution would be something like this:
> 
>  - We start checking the type field in cistpl_funce. We already know
>    about types 0 and 1 (and now 4).
> 
>  - We use this as a key for a subfunction, instead of the "func"
>    parameter. We'd still need to verify that a type 0 is only used in
>    the global CIS table, and a type 1 only in a local though.
> 
>  - Any known good types are silently returned upwards, queued for the
>    function driver.
> 
>  - Any unknown types emit a warning in dmesg, but do not abort the
>    init. This way we can have some kind of log if there is a parsing
>    bug, or a buggy card.
> 
> All of this might not be needed in an initial version, but this would
> be the model that would make blissful. :)
> 
> Rgds

Do you mean something like the following patch? (against 2.6.31)

Thanks,
Albert

diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
index 963f293..20b4193 100644
--- a/drivers/mmc/core/sdio_cis.c
+++ b/drivers/mmc/core/sdio_cis.c
@@ -98,10 +98,56 @@ static const unsigned char speed_val[16] =
 static const unsigned int speed_unit[8] =
     { 10000, 100000, 1000000, 10000000, 0, 0, 0, 0 };
 
-static int cistpl_funce_common(struct mmc_card *card,
+
+typedef int (tpl_parse_t)(struct mmc_card *, struct sdio_func *,
+               const unsigned char *, unsigned);
+
+struct cis_tpl {
+    unsigned char code;
+    unsigned char min_size;
+    tpl_parse_t *parse;
+};
+
+static int cis_tpl_parse(struct mmc_card *card, struct sdio_func *func,
+             const char *tpl_descr,
+             const struct cis_tpl *tpl, int tplc,
+             unsigned char code,
+             const unsigned char *buf, unsigned size)
+{
+    int i, ret;
+
+    /* look for a matching code in the table */
+    for (i = 0; i < tplc; i++, tpl++) {
+        if (tpl->code == code)
+            break;
+    }
+    if (i < tplc) {
+        if (size >= tpl->min_size) {
+            if (tpl->parse)
+                ret = tpl->parse(card, func, buf, size);
+            else
+                ret = -EILSEQ;    /* known tuple, not parsed */
+        } else {
+            /* invalid tuple */
+            ret = -EINVAL;
+        }
+        if (ret && ret != -EILSEQ && ret != -ENOENT) {
+            printk(KERN_ERR "%s: bad %s tuple 0x%02x (%u bytes)\n",
+                   mmc_hostname(card->host), tpl_descr, code, size);
+        }
+    } else {
+        /* unknown tuple */
+        ret = -ENOENT;
+    }
+
+    return ret;
+}
+
+static int cistpl_funce_common(struct mmc_card *card, struct sdio_func *func,
                    const unsigned char *buf, unsigned size)
 {
-    if (size < 0x04 || buf[0] != 0)
+    /* Only valid for the common CIS (function 0) */
+    if (func)
         return -EINVAL;
 
     /* TPLFE_FN0_BLK_SIZE */
@@ -114,16 +160,24 @@ static int cistpl_funce_common(struct mmc_card *card,
     return 0;
 }
 
-static int cistpl_funce_func(struct sdio_func *func,
+static int cistpl_funce_func(struct mmc_card *card, struct sdio_func *func,
                  const unsigned char *buf, unsigned size)
 {
     unsigned vsn;
     unsigned min_size;
 
+    /* Only valid for the individual function's CIS (1-7) */
+    if (!func)
+        return -EINVAL;
+
+    /*
+     * This tuple has a different length depending on the SDIO spec
+     * version.
+     */
     vsn = func->card->cccr.sdio_vsn;
     min_size = (vsn == SDIO_SDIO_REV_1_00) ? 28 : 42;
 
-    if (size < min_size || buf[0] != 1)
+    if (size < min_size)
         return -EINVAL;
 
     /* TPLFE_MAX_BLK_SIZE */
@@ -138,40 +192,26 @@ static int cistpl_funce_func(struct sdio_func *func,
     return 0;
 }
 
+/* Known CIS FUNCE tuples table */
+static const struct cis_tpl cis_tpl_funce_list[] = {
+    {    0x00,    4,    cistpl_funce_common        },
+    {    0x01,    0,    cistpl_funce_func        },
+    {    0x04,    1+1+6,    /* CISTPL_FUNCE_LAN_NODE_ID */    },
+};
+
 static int cistpl_funce(struct mmc_card *card, struct sdio_func *func,
             const unsigned char *buf, unsigned size)
 {
-    int ret;
-
-    /*
-     * There should be two versions of the CISTPL_FUNCE tuple,
-     * one for the common CIS (function 0) and a version used by
-     * the individual function's CIS (1-7). Yet, the later has a
-     * different length depending on the SDIO spec version.
-     */
-    if (func)
-        ret = cistpl_funce_func(func, buf, size);
-    else
-        ret = cistpl_funce_common(card, buf, size);
-
-    if (ret) {
-        printk(KERN_ERR "%s: bad CISTPL_FUNCE size %u "
-               "type %u\n", mmc_hostname(card->host), size, buf[0]);
-        return ret;
-    }
+    if (size < 1)
+        return -EINVAL;
 
-    return 0;
+    return cis_tpl_parse(card, func, "CIS FUNCE",
+                 cis_tpl_funce_list,
+                 ARRAY_SIZE(cis_tpl_funce_list),
+                 buf[0], buf, size);
 }
 
-typedef int (tpl_parse_t)(struct mmc_card *, struct sdio_func *,
-               const unsigned char *, unsigned);
-
-struct cis_tpl {
-    unsigned char code;
-    unsigned char min_size;
-    tpl_parse_t *parse;
-};
-
+/* Known CIS tuples table */
 static const struct cis_tpl cis_tpl_list[] = {
     {    0x15,    3,    cistpl_vers_1        },
     {    0x20,    4,    cistpl_manfid        },
@@ -250,31 +290,37 @@ static int sdio_read_cis(struct mmc_card *card, struct sdio_func *func)
             break;
         }
 
-        for (i = 0; i < ARRAY_SIZE(cis_tpl_list); i++)
-            if (cis_tpl_list[i].code == tpl_code)
-                break;
-        if (i >= ARRAY_SIZE(cis_tpl_list)) {
-            /* this tuple is unknown to the core */
+        /* Try to parse the CIS tuple */
+        ret = cis_tpl_parse(card, func, "CIS",
+                    cis_tpl_list, ARRAY_SIZE(cis_tpl_list),
+                    tpl_code, this->data, tpl_link);
+        if (ret == -EILSEQ || ret == -ENOENT) {
+            /*
+             * The tuple is unknown or known but not parsed.
+             * Queue the tuple for the function driver.
+             */
             this->next = NULL;
             this->code = tpl_code;
             this->size = tpl_link;
             *prev = this;
             prev = &this->next;
-            printk(KERN_DEBUG
-                   "%s: queuing CIS tuple 0x%02x length %u\n",
-                   mmc_hostname(card->host), tpl_code, tpl_link);
-        } else {
-            const struct cis_tpl *tpl = cis_tpl_list + i;
-            if (tpl_link < tpl->min_size) {
-                printk(KERN_ERR
-                       "%s: bad CIS tuple 0x%02x (length = %u, expected >= %u)\n",
+
+            if (ret == -ENOENT) {
+                /* warn about unknown tuples */
+                printk(KERN_WARNING "%s: queuing unknown"
+                       " CIS tuple 0x%02x (%u bytes)\n",
                        mmc_hostname(card->host),
-                       tpl_code, tpl_link, tpl->min_size);
-                ret = -EINVAL;
-            } else if (tpl->parse) {
-                ret = tpl->parse(card, func,
-                         this->data, tpl_link);
+                       tpl_code, tpl_link);
             }
+
+            /* keep on analyzing tuples */
+            ret = 0;
+        } else {
+            /*
+             * We don't need the tuple anymore if it was
+             * successfully parsed by the SDIO core or if it is
+             * not going to be queued for a driver.
+             */
             kfree(this);
         }


      
