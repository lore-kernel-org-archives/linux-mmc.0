Return-Path: <SRS0=yZYV=3L=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182A5C3F68F
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Jan 2020 14:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53372465B
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Jan 2020 14:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nh2IUE2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgAVO1z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Jan 2020 09:27:55 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41028 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgAVO1z (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jan 2020 09:27:55 -0500
Received: by mail-lf1-f66.google.com with SMTP id m30so5456352lfp.8
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2020 06:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ts1uyTmC70B3zgbOliuD1/15f5l4omJ+ePakmk26HAk=;
        b=nh2IUE2MY1s6Y2a8zvdyS63aJeyxj+t9p8Pno9lRrHJNGlhWOkFmHqFSVranO9OLpj
         fGgT3oT70mnmDett6pM5mp4l8fWfMk1YtmaFEEy1KDfUmIpxltnBjj11xB/w02GMTWeQ
         306p1YYrm0vKlAGNFXLbDzqzaF5zMoRIWp3V8LrlDRZvxxXF/E9MmwZ3s7jvy2zd89av
         7td3nX9UMVBFiVjidYm1cKDuENsPuKVh009CAaSv5453Rwu6iGuqy2QwUgzWws342vw6
         RJoMr/Cqrd8cn7jnhch3xCQzQ6+hBrSxjBDWrCvQS0Wnl9HwJyn0fBGfPvXjLO7O/IVc
         0Vvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ts1uyTmC70B3zgbOliuD1/15f5l4omJ+ePakmk26HAk=;
        b=J1FQzk25Vff7+xYQ/dQJSYPeN5cRMYAZBX+lh1exgHei8Eu4wCp+queB75B+CkvrJJ
         EzLLZkQGiVo4P7Rfpq66U/1sdPL5p1MMLANioGj4Bzy5F0zUPs8AOVfpVUAjZ08vzEdG
         GmIEp3W1Vl8zfrj3MPBRurYB9dugiBfOpJtnF0R0uzf8Y9V5w+7O3ihb7zILJYZRsjbT
         XVM0wKjdkjR/EpGuOqkYBrxnDOHdSfZgv6Im4u9vsHCS+jx/AM4wKycmn5P4FrFYvEtK
         vRsD1jFCq9z7cYQdlHwu0VJbDXorYNF/vdsvB3WIcMRX5etm3M8z/UaZhgj+EmDngHnb
         1GJw==
X-Gm-Message-State: APjAAAWovfc8CL6qYHzqzetz/07peZYj6XIEZ0oW1Lq7V7WXpy4xKmi6
        djo4UQIgUmfs9GH4h+DY+zpbxT/PYuE=
X-Google-Smtp-Source: APXvYqzAc0fE6fZPXT4LYq62AsCagh3IGhLZNPzVToTYlnWKjX2jBoFYzLuIWbEcRyDq4gnEkizhUw==
X-Received: by 2002:a19:dc14:: with SMTP id t20mr1918545lfg.47.1579703271840;
        Wed, 22 Jan 2020 06:27:51 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id u17sm20369548ljk.62.2020.01.22.06.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 06:27:50 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, mirq-linux@rere.qmqm.pl
Subject: [PATCH 0/3] mmc: core: Update timeouts for __mmc_switch()
Date:   Wed, 22 Jan 2020 15:27:44 +0100
Message-Id: <20200122142747.5690-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This small series updates timeouts used when sending CMD6 for eMMC, through the
__mmc_switch() function.

Ulf Hansson (3):
  mmc: core: Specify timeouts for BKOPS and CACHE_FLUSH for eMMC
  mmc: block: Use generic_cmd6_time when modifying
    INAND_CMD38_ARG_EXT_CSD
  mmc: core: Default to generic_cmd6_time as timeout in __mmc_switch()

 drivers/mmc/core/block.c   |  6 +++---
 drivers/mmc/core/mmc_ops.c | 34 +++++++++++++++++-----------------
 2 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.17.1

