From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [PATCH v2 0/2] add call backs in sdhci-pxa.c
Date: Wed, 18 May 2011 04:40:40 -0400
Message-ID: <BANLkTimwFxEdS6H+UvJAYoafyGe1g2eHGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46237 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565Ab1ERIkl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 May 2011 04:40:41 -0400
Received: by vws1 with SMTP id 1so929950vws.19
        for <linux-mmc@vger.kernel.org>; Wed, 18 May 2011 01:40:41 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Philip Rakity <prakity@ma>

v2, sync to mmc-next

patch 1: move sdhci_priv and sdhci_ops definition to
include/linux/mmc/sdhci.h from drivers/mmc/host/sdhci.h
1. platfrom could directly overwrite sdhci_ops with soc specific ops,
this case occurs at different controller share the same driver, while
different ops they may use, so move sdhci_ops definition to include
2. platform code will use sdhci_priv to access host->private

Patch 2: Introduce several call backs.
pxa955 may require external gpio to detect card insert and remove.
soc_set_ops is used to overwrite host ops directly from platfrom ops.
