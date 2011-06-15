From: "uulinux" <uulinux@gmail.com>
Subject: [Question] mmc :  block.c what will be done in the block layer after __blk_end_request(req, -EIO, brq.data.blksz)
Date: Wed, 15 Jun 2011 22:49:52 +0800
Message-ID: <201106152249504228872@gmail.com>
References: <201106152237557440366@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:52725 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755253Ab1FOOuM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2011 10:50:12 -0400
Received: by pvg12 with SMTP id 12so337284pvg.19
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jun 2011 07:50:12 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>

Hi, everyone:

    I am familiar with block layer, so I want to know what will be done in the block layer after __blk_end_request(req, -EIO, brq.data.blksz). Will the rest of requests in queue of this file be removed from the queue?

    I use mail list for first time,  if there are any problem, please let me know.

