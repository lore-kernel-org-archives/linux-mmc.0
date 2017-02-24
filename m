From: Yong Mao <yong.mao@mediatek.com>
Subject: [PATCH v1] Fixed bug where clock frequency could be set wrong
Date: Fri, 24 Feb 2017 16:22:06 +0800
Message-ID: <1487924527-22584-1-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:41852 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751057AbdBXIWZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Feb 2017 03:22:25 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, yong mao <yong.mao@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, linux-mmc@vger.kernel.org, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

yong mao (1):
  mmc: mediatek: Fixed bug where clock frequency could be set wrong

 drivers/mmc/host/mtk-sd.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

-- 
1.8.1.1.dirty

