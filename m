Return-Path: <SRS0=NqgV=6W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5E7C38A2A
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 15:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3547624984
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 15:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgEHPWj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 May 2020 11:22:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:41720 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgEHPWj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 8 May 2020 11:22:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D636CAE61;
        Fri,  8 May 2020 15:22:40 +0000 (UTC)
Date:   Fri, 8 May 2020 17:22:36 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Raul Rangel <rrangel@chromium.org>
Cc:     linux-mmc@vger.kernel.org, murphyt7@tcd.ie, dianders@chromium.org,
        evgreen@chromium.org, Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: Problems using AMD eMMC with AMD IOMMU
Message-ID: <20200508152236.GQ8135@suse.de>
References: <CAHQZ30CXW7W6Wv12u45Mpn4+_oQhcR=_hpu-gOv8PqvajnLC4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQZ30CXW7W6Wv12u45Mpn4+_oQhcR=_hpu-gOv8PqvajnLC4Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, May 06, 2020 at 03:00:21PM -0600, Raul Rangel wrote:
> Any suggestions would be appreciated.

Two possibilities:

	1) Please try the 5 patches from this branch:
	   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/log/?h=iommu/fixes

	   The fix some race-condition issues, I think it is unlikely
	   you hit them, but it is worth a test.

	2) Dma-iommu code does sg-merging, which the previous DMA-API
	   implementation did not. Can you try attached diff from Robin
	   Murphy to disable sg-merging? It that helps it is an issue in
	   the eMMC driver.

Regards,

	Joerg

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index a2e96a5fd9a7..a6b71bad518e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -779,7 +779,7 @@ static int __finalise_sg(struct device *dev, struct 
scatterlist *sg, int nents,
  		 * - but doesn't fall at a segment boundary
  		 * - and wouldn't make the resulting output segment too long
  		 */
-		if (cur_len && !s_iova_off && (dma_addr & seg_mask) &&
+		if (0 && cur_len && !s_iova_off && (dma_addr & seg_mask) &&
  		    (max_len - cur_len >= s_length)) {
  			/* ...then concatenate it with the previous one */
  			cur_len += s_length;
@@ -799,6 +799,7 @@ static int __finalise_sg(struct device *dev, struct 
scatterlist *sg, int nents,
  		if (s_length + s_iova_off < s_iova_len)
  			cur_len = 0;
  	}
+	WARN_ON(count < nents);
  	return count;
  }
