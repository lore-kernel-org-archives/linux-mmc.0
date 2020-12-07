Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4EFC4167B
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Dec 2020 03:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 256EB22D06
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Dec 2020 03:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgLGD1a (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 6 Dec 2020 22:27:30 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:8953 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbgLGD13 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Dec 2020 22:27:29 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Cq7y65zFtzhnVr;
        Mon,  7 Dec 2020 11:26:22 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.9) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Dec 2020 11:26:39 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 0/1] dt-bindings: mmc: eliminate yamllint warnings
Date:   Mon, 7 Dec 2020 11:26:25 +0800
Message-ID: <20201207032626.1445-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch is based on the latest linux-next code.


Zhen Lei (1):
  dt-bindings: mmc: eliminate yamllint warnings

 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 26 +++++++++++------------
 1 file changed, 13 insertions(+), 13 deletions(-)

-- 
1.8.3


