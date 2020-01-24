Return-Path: <SRS0=bXXM=3N=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3750C2D0DB
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jan 2020 11:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A36A20704
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jan 2020 11:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="V1JMWp+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389695AbgAXLme (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:42:34 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:44983 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388706AbgAXLmd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 24 Jan 2020 06:42:33 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 483y1J1HmQzB3tj;
        Fri, 24 Jan 2020 22:42:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1579866150;
        bh=XaZMz/ewQ8WVnUJd7DwXYe7WjqOD/WGfWhNKLiw8QQQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=V1JMWp+0dsJ2f3QmYFJcjDhHPizqFbFS3hAUoOBJcqaLytxd3C9jX04ajMBQoMCjy
         gPnP+iyQ1qiwWQ5W11MhbrOQjOfrfdoDRUuQUUESHIeGINrHV+cELguNJXf2m7L1IY
         A8RiCUpdjCVX0jciX26B/YpYc+jNt8Vjbh+8Tj9sE3oQIOkZ/Dxobk0uPSYJKejiJz
         YvoBIZgRcDEyVkp2RtvV78dWumjWi0tjJCraXvrMcVoEMIRkcMAPqRO/8B/aHAiTVf
         DXszYFKoYxPUnYHRjiPiDtPIEKpT4xYJSoTA6r+qDwO1NbTNGwo+Dbu5gGXzMK2RuM
         n61wxB0rhvm2g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        "linux-mmc\@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Julian Margetson <runaway@candw.ms>,
        "contact\@a-eon.com" <contact@a-eon.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [FSL P5020 P5040 PPC] Onboard SD card doesn't work anymore after the 'mmc-v5.4-2' updates
In-Reply-To: <CAPDyKFoydOuSE=Eaq168=2_Ycouo7hzyw+RZXhGq7q4D4Qe8TQ@mail.gmail.com>
References: <20200108093903.57620-1-hdegoede@redhat.com> <20200108093903.57620-2-hdegoede@redhat.com> <61bc9265-ece0-eeb6-d4a1-4631138ecf29@intel.com> <8d67882d-04a8-0607-be4e-c1430b7fda21@redhat.com> <84a32714-ba08-74a0-0c76-3c36db44dd68@intel.com> <93446e09-5f12-800a-62fa-bf3ecea7273d@redhat.com> <399ac7d5-2518-799a-595e-f6b6878cf4ab@intel.com> <a9ab8946-c599-5f83-7527-2387a9e82e8a@xenosoft.de> <CAPDyKFoydOuSE=Eaq168=2_Ycouo7hzyw+RZXhGq7q4D4Qe8TQ@mail.gmail.com>
Date:   Fri, 24 Jan 2020 22:42:24 +1100
Message-ID: <8736c5hyhr.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> writes:
> On Thu, 16 Jan 2020 at 12:18, Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>>
>> Hi All,
>>
>> We still need the attached patch for our onboard SD card interface
>> [1,2]. Could you please add this patch to the tree?
>
> No, because according to previous discussion that isn't the correct
> solution and more importantly it will break other archs (if I recall
> correctly).
>
> Looks like someone from the ppc community needs to pick up the ball.

That's a pretty small community these days :) :/

Christian can you test this please? I think I got the polarity of all
the tests right, but it's Friday night so maybe I'm wrong :)

cheers


From 975ba6e8b52d6f5358e93c1f5a47adc4a0b5fb70 Mon Sep 17 00:00:00 2001
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 24 Jan 2020 22:26:59 +1100
Subject: [PATCH] of: Add OF_DMA_DEFAULT_COHERENT & select it on powerpc

There's an OF helper called of_dma_is_coherent(), which checks if a
device has a "dma-coherent" property to see if the device is coherent
for DMA.

But on some platforms devices are coherent by default, and on some
platforms it's not possible to update existing device trees to add the
"dma-coherent" property.

So add a Kconfig symbol to allow arch code to tell
of_dma_is_coherent() that devices are coherent by default, regardless
of the presence of the property.

Select that symbol on powerpc when NOT_COHERENT_CACHE is not set, ie.
when the system has a coherent cache.

Fixes: 92ea637edea3 ("of: introduce of_dma_is_coherent() helper")
Cc: stable@vger.kernel.org # v3.16+
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig | 1 +
 drivers/of/Kconfig   | 4 ++++
 drivers/of/address.c | 6 +++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 62752c3bfabf..460678ab2375 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -235,6 +235,7 @@ config PPC
 	select NEED_DMA_MAP_STATE		if PPC64 || NOT_COHERENT_CACHE
 	select NEED_SG_DMA_LENGTH
 	select OF
+	select OF_DMA_DEFAULT_COHERENT		if !NOT_COHERENT_CACHE
 	select OF_EARLY_FLATTREE
 	select OLD_SIGACTION			if PPC32
 	select OLD_SIGSUSPEND
diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 37c2ccbefecd..d91618641be6 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -103,4 +103,8 @@ config OF_OVERLAY
 config OF_NUMA
 	bool
 
+config OF_DMA_DEFAULT_COHERENT
+	# arches should select this if DMA is coherent by default for OF devices
+	bool
+
 endif # OF
diff --git a/drivers/of/address.c b/drivers/of/address.c
index 99c1b8058559..e8a39c3ec4d4 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -995,12 +995,16 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
  * @np:	device node
  *
  * It returns true if "dma-coherent" property was found
- * for this device in DT.
+ * for this device in the DT, or if DMA is coherent by
+ * default for OF devices on the current platform.
  */
 bool of_dma_is_coherent(struct device_node *np)
 {
 	struct device_node *node = of_node_get(np);
 
+	if (IS_ENABLED(CONFIG_OF_DMA_DEFAULT_COHERENT))
+		return true;
+
 	while (node) {
 		if (of_property_read_bool(node, "dma-coherent")) {
 			of_node_put(node);
-- 
2.21.1


