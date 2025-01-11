Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358011547E7;
	Sat, 11 Jan 2025 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736577152; cv=none; b=VwTkVt1OleavXQ9uHE+NlTh3OOtnkTnPyTsn+0TtO73tztWgEOuMqMXRhxTqY06ZUd4Sduqqwre8xfoQNp9hTWTpADjDbQDJVEPrx6U31qndLXFCghSdp2BMCGFIFl7hRl6Fpd8v6pmLNGXkRRhfo49E83pZqztZgwM56uPFaFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736577152; c=relaxed/simple;
	bh=BzP2ouTwnQQD9TJULB2LZIUBdwPr5rtnagkdMKgFz2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VD2g5g/qb8dvmFa5lTjtvIR4kaSFFJXq331ZohhWuD7MQOY+Yuf7cHp+VkLS/X0NRDn1Cx/yPXDHU7xXnpZQRmWvD/krNCo1nCFZi2vgbUrOADGDK82WaeUgmY3Iek0rpp6yuxvFB4cewpVVnBoJgMosc93Dq0pqz0nMW/QCFqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PGdB0ni0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PGdB0ni0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=JgjXS+/cEpO15uspwQhs/bCHN/H5hRYsjkj1heBZCD0=; b=PGdB0ni0ZE5I8lgMbntppiv3E1
	1cx0tMVhYWL5FGOb6XokMUlJ4AS/CY9TLsf0J2IAfR9g3Gpdds18orFoJ/281abBu08p2/zE8B131
	w1aa6knboUWtMqxU2mKKPcg18XZ5rLk8NBb8tQj468cvIN4bETIucs/HYj8yJUA4kd8mc3u4+C+ZD
	qXG/+t5oZh6NjddUYZfxGJr4CXFE1FXohWWFomlWw/tpYvZOERuTnG168x9A/u+uGMbKo6i04gwIY
	ZuSNUA+Ob91SOxIipsm7cT6BAxemSRsi6sSH09ZkQyQEd8g2CZ+ezmziEQmiVq97cs2KovYAyAc1x
	DnFfU7sQ==;
Received: from [50.53.2.24] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tWV2s-00000000Hra-39yo;
	Sat, 11 Jan 2025 06:32:30 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-mmc@vger.kernel.org
Subject: [PATCH] memstick: core: fix kernel-doc notation
Date: Fri, 10 Jan 2025 22:32:30 -0800
Message-ID: <20250111063230.910945-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the correct kernel-doc format for function parameters (':'
instead of '-') to eliminate kernel-doc warnings.
Add some "Returns:" notations to functions.

memstick.c:206: warning: Function parameter or struct member 'host' not described in 'memstick_detect_change'
memstick.c:222: warning: Function parameter or struct member 'host' not described in 'memstick_next_req'
memstick.c:222: warning: Function parameter or struct member 'mrq' not described in 'memstick_next_req'
memstick.c:248: warning: Function parameter or struct member 'host' not described in 'memstick_new_req'
memstick.c:265: warning: Function parameter or struct member 'mrq' not described in 'memstick_init_req_sg'
memstick.c:265: warning: Function parameter or struct member 'tpc' not described in 'memstick_init_req_sg'
memstick.c:265: warning: Function parameter or struct member 'sg' not described in 'memstick_init_req_sg'
memstick.c:295: warning: Function parameter or struct member 'mrq' not described in 'memstick_init_req'
memstick.c:295: warning: Function parameter or struct member 'tpc' not described in 'memstick_init_req'
memstick.c:295: warning: Function parameter or struct member 'buf' not described in 'memstick_init_req'
memstick.c:295: warning: Function parameter or struct member 'length' not described in 'memstick_init_req'
memstick.c:366: warning: Function parameter or struct member 'card' not described in 'memstick_set_rw_addr'
memstick.c:513: warning: Function parameter or struct member 'host' not described in 'memstick_add_host'
memstick.c:549: warning: Function parameter or struct member 'host' not described in 'memstick_remove_host'
memstick.c:571: warning: Function parameter or struct member 'host' not described in 'memstick_free_host'
memstick.c:582: warning: Function parameter or struct member 'host' not described in 'memstick_suspend_host'
memstick.c:594: warning: Function parameter or struct member 'host' not described in 'memstick_resume_host'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Alex Dubov <oakad@yahoo.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mmc@vger.kernel.org
---
 drivers/memstick/core/memstick.c |   46 +++++++++++++++++------------
 1 file changed, 27 insertions(+), 19 deletions(-)

--- linux-next-20250108.orig/drivers/memstick/core/memstick.c
+++ linux-next-20250108/drivers/memstick/core/memstick.c
@@ -200,7 +200,7 @@ static int memstick_dummy_check(struct m
 
 /**
  * memstick_detect_change - schedule media detection on memstick host
- * @host - host to use
+ * @host: host to use
  */
 void memstick_detect_change(struct memstick_host *host)
 {
@@ -210,13 +210,15 @@ EXPORT_SYMBOL(memstick_detect_change);
 
 /**
  * memstick_next_req - called by host driver to obtain next request to process
- * @host - host to use
- * @mrq - pointer to stick the request to
+ * @host: host to use
+ * @mrq: pointer to stick the request to
  *
  * Host calls this function from idle state (*mrq == NULL) or after finishing
  * previous request (*mrq should point to it). If previous request was
- * unsuccessful, it is retried for predetermined number of times. Return value
- * of 0 means that new request was assigned to the host.
+ * unsuccessful, it is retried for predetermined number of times.
+ *
+ * Returns: value of 0 means that new request was assigned to the host.
+ * Otherwise a negative error code is returned.
  */
 int memstick_next_req(struct memstick_host *host, struct memstick_request **mrq)
 {
@@ -242,7 +244,7 @@ EXPORT_SYMBOL(memstick_next_req);
 
 /**
  * memstick_new_req - notify the host that some requests are pending
- * @host - host to use
+ * @host: host to use
  */
 void memstick_new_req(struct memstick_host *host)
 {
@@ -256,9 +258,9 @@ EXPORT_SYMBOL(memstick_new_req);
 
 /**
  * memstick_init_req_sg - set request fields needed for bulk data transfer
- * @mrq - request to use
- * @tpc - memstick Transport Protocol Command
- * @sg - TPC argument
+ * @mrq: request to use
+ * @tpc: memstick Transport Protocol Command
+ * @sg: TPC argument
  */
 void memstick_init_req_sg(struct memstick_request *mrq, unsigned char tpc,
 			  const struct scatterlist *sg)
@@ -281,10 +283,10 @@ EXPORT_SYMBOL(memstick_init_req_sg);
 
 /**
  * memstick_init_req - set request fields needed for short data transfer
- * @mrq - request to use
- * @tpc - memstick Transport Protocol Command
- * @buf - TPC argument buffer
- * @length - TPC argument size
+ * @mrq: request to use
+ * @tpc: memstick Transport Protocol Command
+ * @buf: TPC argument buffer
+ * @length: TPC argument size
  *
  * The intended use of this function (transfer of data items several bytes
  * in size) allows us to just copy the value between request structure and
@@ -360,7 +362,9 @@ static int h_memstick_set_rw_addr(struct
 /**
  * memstick_set_rw_addr - issue SET_RW_REG_ADDR request and wait for it to
  *                        complete
- * @card - media device to use
+ * @card: media device to use
+ *
+ * Returns: error setting for the current request
  */
 int memstick_set_rw_addr(struct memstick_dev *card)
 {
@@ -487,6 +491,8 @@ out_power_off:
  * memstick_alloc_host - allocate a memstick_host structure
  * @extra: size of the user private data to allocate
  * @dev: parent device of the host
+ *
+ * Returns: %NULL on failure or the allocated &memstick_host pointer on success
  */
 struct memstick_host *memstick_alloc_host(unsigned int extra,
 					  struct device *dev)
@@ -507,7 +513,9 @@ EXPORT_SYMBOL(memstick_alloc_host);
 
 /**
  * memstick_add_host - start request processing on memstick host
- * @host - host to use
+ * @host: host to use
+ *
+ * Returns: %0 on success or a negative error code on failure
  */
 int memstick_add_host(struct memstick_host *host)
 {
@@ -543,7 +551,7 @@ EXPORT_SYMBOL(memstick_add_host);
 
 /**
  * memstick_remove_host - stop request processing on memstick host
- * @host - host to use
+ * @host: host to use
  */
 void memstick_remove_host(struct memstick_host *host)
 {
@@ -565,7 +573,7 @@ EXPORT_SYMBOL(memstick_remove_host);
 
 /**
  * memstick_free_host - free memstick host
- * @host - host to use
+ * @host: host to use
  */
 void memstick_free_host(struct memstick_host *host)
 {
@@ -576,7 +584,7 @@ EXPORT_SYMBOL(memstick_free_host);
 
 /**
  * memstick_suspend_host - notify bus driver of host suspension
- * @host - host to use
+ * @host: host to use
  */
 void memstick_suspend_host(struct memstick_host *host)
 {
@@ -588,7 +596,7 @@ EXPORT_SYMBOL(memstick_suspend_host);
 
 /**
  * memstick_resume_host - notify bus driver of host resumption
- * @host - host to use
+ * @host: host to use
  */
 void memstick_resume_host(struct memstick_host *host)
 {
