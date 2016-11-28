From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3] mmc: block: delete packed command support
Date: Mon, 28 Nov 2016 00:23:40 -0800
Message-ID: <20161128082340.GA5391@infradead.org>
References: <1480066500-4983-1-git-send-email-linus.walleij@linaro.org>
 <CAPDyKFoQOb19xq2zLZuAHp_JCcpyeo5MvtvFnNjq8hRcPZcTxA@mail.gmail.com>
 <50128E8A-D7B3-49E3-9E18-4AD240F1EBD0@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:59092 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754074AbcK1IXm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Nov 2016 03:23:42 -0500
Content-Disposition: inline
In-Reply-To: <50128E8A-D7B3-49E3-9E18-4AD240F1EBD0@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Namjae Jeon <namjae.jeon@samsung.com>, Maya Erez <qca_merez@qca.qualcomm.com>

On Sun, Nov 27, 2016 at 02:25:15PM +0000, Alex Lemberg wrote:
> I understand your concerns about the current packed commands
> support and the problem of transition to blk_mq.
> But as I mentioned in previous email thread, the packed commands
> feature is still in use on eMMC4.5 or eMMC5.1 devices on hosts
> without SW/HW CMDQ support.
> Taking this feature out meaning stop supporting one of important
> performance features of eMMC devices.
> Looking forward this feature is replaced with a CMDQ, but should we
> kill it for those who doesn’t have a CMDQ? 

No driver actually uses it, as-is it's simply dead code.
