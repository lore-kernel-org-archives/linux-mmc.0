Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F20C433B4
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Apr 2021 05:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73A8861104
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Apr 2021 05:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhDTFyL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Apr 2021 01:54:11 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12062 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbhDTFyD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Apr 2021 01:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618898012; x=1650434012;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JFUux4KVzDdP8Fih8AzvsE90HWHsIn+1zpR633Gfcc8=;
  b=QMyDZrv12gzY1rXiSof0He5YNuPkdnMhiSDIPsRMX3JTZ/bjnI1I2xO6
   W64UG9UzSExtdxcPW7kDXyG/lyGw1w2xGX+Ywtg9CTpXLvMAWNK/OPPX9
   TYKOn1S6tlZmB3usmHaNWICe93etfbpz5tChFbE3VqLWqLkPMIvsLzQwu
   BMT0rp+BCQUcj00zRSrWETdExM1295lgR+NlMDCKEWOj2jQ3yFqC9AfVK
   iKbU7YNPcFyFcXmzE/echdpYZR657iBNJ7yDfu/UkqNL1exM/yr089Rlq
   ysaaAltC7vVYTsqE5sieh9JSEv0nqYaX1DcnNt289X9Ch94jbFULfSQcx
   A==;
IronPort-SDR: 9yNgFEZc3sHAYB4pXh83QI8fe7ZKb3XYp5u4HT1GgVwBzljCRW/Dn/MLUALmIGOQjmNopjqQYB
 POMy5oMpot4QIWw6pvDWzqCRhlrtV8oRlLaHWt/46WSZtEt/gO3tZhDOaegxmMJqrFkVTsJWhV
 DghwjnJ9wObhf3jVPPbSXmuMr8T2sr7tEWvDX6ecm3MfCU5E6F+dzAegXnkFvpDr1H59ifpknV
 P3/kEQFCOqd6VZNu1zKUr7hB1bjAyGpH4syy7woAWXJxu/+IdwQ0B08ndkpQO9LhBEK7f+F/pD
 aMI=
X-IronPort-AV: E=Sophos;i="5.82,236,1613404800"; 
   d="scan'208";a="165514333"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2021 13:53:32 +0800
IronPort-SDR: tnHWxLFFuoZiKJaZs5skVN2hKCjWP7qvYbjgHmlFuQ1ThueQlyCxinvqeAlzrrtZbcTumt0f/z
 Uxd9bskig3K/9OkIhLA8ITtp6e34F8Pc5q7IUMzubx12KzyMFI2aq7QjgqPcg7DwHViMl7MPqu
 9ZbJNTKFLo8BpTThKO2+JPWRimaQvP5RbgC7pZJT8h9JKcLdLMR8rVLSWJqOkP/2+9XgT7bFjD
 vVttYVsB77x0N9xgCXCbor12L8FUf1+CG7snfJgudMLWOeCT6fQ0zba6euUEB+VzL8c38cBGPg
 9U9kFTKrPGKXoqGiapc5kpQW
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 22:32:39 -0700
IronPort-SDR: PANqtgwPXzfIIHQNwVNg8ZtYYTEwduwvMNVlo8WsFgTiU5VWHQYgJysY0vqvSVekqjA16dA2Do
 t/4TjaTTYnJrv+2agkMpzCZD8xMtrgVda3n1JY+GqzqqOfkGFfdlLQbkCVnDDA8wV1fgeWlnIx
 yZauTkF4qB4o7Z3AaPvVzBOAMc25UVQ/HzvZMKCPp4FKS3Qhoc0qoJqHDgButQQVXridGmEO8v
 4km6sPgKpcwuQcP/1RbZoAYL9MdezM+wGLwuE/5k4h5xPBEd0B9QgFfkx4nfeJLhmCda3/HMk5
 AIU=
WDCIronportException: Internal
Received: from bxygm33.sdcorp.global.sandisk.com ([10.0.231.247])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Apr 2021 22:53:30 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 0/2] Do not flush cache when it is disabled
Date:   Tue, 20 Apr 2021 08:53:04 +0300
Message-Id: <20210420055306.4858-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

v2 -> v3:
 - rebase onto recent cache changes

v1 -> v2:
 - Attend Adrian's comments

Cache is a temporary storage space in an eMMC device. Volatile by
nature, the cache should in typical case reduce the access time compared
to an access to the main nonvolatile storage.

The cache function can be turned ON and OFF. Once OFF, the host is not
expected to issue a flush-cache command to the device.

Avri Altman (2):
  mmc: block: Issue flush only if allowed
  mmc: block: Update ext_csd.cache_ctrl if it was written

 drivers/mmc/core/block.c   | 19 +++++++++++++++++++
 drivers/mmc/core/mmc.c     |  2 +-
 drivers/mmc/core/mmc_ops.h |  5 +++++
 3 files changed, 25 insertions(+), 1 deletion(-)

-- 
2.25.1

