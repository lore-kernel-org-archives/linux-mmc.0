Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B69C48BC2
	for <linux-mmc@archiver.kernel.org>; Mon, 21 Jun 2021 23:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC87A611C1
	for <linux-mmc@archiver.kernel.org>; Mon, 21 Jun 2021 23:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbhFUXzb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 21 Jun 2021 19:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbhFUXz3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Jun 2021 19:55:29 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7466C0617AD
        for <linux-mmc@vger.kernel.org>; Mon, 21 Jun 2021 16:53:13 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id o21so9436046pll.6
        for <linux-mmc@vger.kernel.org>; Mon, 21 Jun 2021 16:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KLTgOAPTL/hdLPXehUk7jin9tlU4DA3I5amBsr+XFlI=;
        b=IakNO8AV5d2AjRngN+nO9dr4scVOZ/i0GXGfPwpIa86ahW3Gx5lGZr/Qvp7nX9QLEF
         ah2PHyMzxecYm5jvWAhtwLlNrNpFAqJF7xOfwTdlDZQDqN2rtdNZFIoQTtMU1ur4ZApC
         7UbMpvJg4P3n/t96Z0aCStxGsE3he4J8bRing=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KLTgOAPTL/hdLPXehUk7jin9tlU4DA3I5amBsr+XFlI=;
        b=Q/eTAN/3NReUdcfI6CQ0st/A3Ev9FX9kSkHcVlE67MYtW49eD5HXp4MQ3Up8b0nt1R
         LuBjWk1yUEWHFgNn9OZ0lAKOCD0SEPTCOLRWk0cw7eLvaP8l16FUqEZ+ttZT4xXbOvan
         2gP8+mfGIzWqqfGwYjE0fda0jpvjDP+qyw3J9wXGmLHuvZt2oiEvZRtG7UDcrmcHvRt5
         AXzIaJ2kOSu7NdjwswAfgdF1PL3+y6vVnvXF981uXBq1Wqnz+LY0+YQBUwCSvfq+8s9F
         qnMG7WIQ3PYvq+cvtgnQXH5mwP43XgwvU2ZW/OB6+6fs80n+bG113bpQZ91ZG6Sp7l9A
         9kqw==
X-Gm-Message-State: AOAM533xqfmRQcgUfhvQ8QZEzWtRSpHD5+lFD5h6YT0MUDOBygUlMPIg
        ajWuAvk58tOA/nv2gtfQF2vIMA==
X-Google-Smtp-Source: ABdhPJwRWBAs+yleFm5GhcTuxr1KlXgWqhCk+RoJTuTTOnsjL0UiSKVoBvEouzqIK5zI5rTU5FaO7A==
X-Received: by 2002:a17:90a:be03:: with SMTP id a3mr611377pjs.43.1624319593246;
        Mon, 21 Jun 2021 16:53:13 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:bdc1:a4b1:b06e:91d1])
        by smtp.gmail.com with ESMTPSA id s27sm4339663pfg.169.2021.06.21.16.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 16:53:12 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        rafael.j.wysocki@intel.com, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, adrian.hunter@intel.com,
        bhelgaas@google.com
Cc:     robdclark@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_c_gdjako@quicinc.com,
        iommu@lists.linux-foundation.org, sonnyrao@chromium.org,
        saiprakash.ranjan@codeaurora.org, linux-mmc@vger.kernel.org,
        vbadigan@codeaurora.org, rajatja@google.com, saravanak@google.com,
        joel@joelfernandes.org, Douglas Anderson <dianders@chromium.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] drivers: base: Add bits to struct device to control iommu strictness
Date:   Mon, 21 Jun 2021 16:52:44 -0700
Message-Id: <20210621165230.2.Icfe7cbb2cc86a38dde0ee5ba240e0580a0ec9596@changeid>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210621235248.2521620-1-dianders@chromium.org>
References: <20210621235248.2521620-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

How to control the "strictness" of an IOMMU is a bit of a mess right
now. As far as I can tell, right now:
* You can set the default to "non-strict" and some devices (right now,
  only PCI devices) can request to run in "strict" mode.
* You can set the default to "strict" and no devices in the system are
  allowed to run as "non-strict".

I believe this needs to be improved a bit. Specifically:
* We should be able to default to "strict" mode but let devices that
  claim to be fairly low risk request that they be run in "non-strict"
  mode.
* We should allow devices outside of PCIe to request "strict" mode if
  the system default is "non-strict".

I believe the correct way to do this is two bits in "struct
device". One allows a device to force things to "strict" mode and the
other allows a device to _request_ "non-strict" mode. The asymmetry
here is on purpose. Generally if anything in the system makes a
request for strictness of something then we want it strict. Thus
drivers can only request (but not force) non-strictness.

It's expected that the strictness fields can be filled in by the bus
code like in the patch ("PCI: Indicate that we want to force strict
DMA for untrusted devices") or by using the new pre_probe concept
introduced in the patch ("drivers: base: Add the concept of
"pre_probe" to drivers").

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 include/linux/device.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index f1a00040fa53..c1b985e10c47 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -449,6 +449,15 @@ struct dev_links_info {
  *		and optionall (if the coherent mask is large enough) also
  *		for dma allocations.  This flag is managed by the dma ops
  *		instance from ->dma_supported.
+ * @force_strict_iommu: If set to %true then we should force this device to
+ *			iommu.strict regardless of the other defaults in the
+ *			system. Only has an effect if an IOMMU is in place.
+ * @request_non_strict_iommu: If set to %true and there are no other known
+ *			      reasons to make the iommu.strict for this device,
+ *			      then default to non-strict mode. This implies
+ *			      some belief that the DMA master for this device
+ *			      won't abuse the DMA path to compromise the kernel.
+ *			      Only has an effect if an IOMMU is in place.
  *
  * At the lowest level, every device in a Linux system is represented by an
  * instance of struct device. The device structure contains the information
@@ -557,6 +566,8 @@ struct device {
 #ifdef CONFIG_DMA_OPS_BYPASS
 	bool			dma_ops_bypass : 1;
 #endif
+	bool			force_strict_iommu:1;
+	bool			request_non_strict_iommu:1;
 };
 
 /**
-- 
2.32.0.288.g62a8d224e6-goog

