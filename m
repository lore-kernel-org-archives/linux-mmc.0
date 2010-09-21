From: claud yu <claud.yu@gmail.com>
Subject: Re: [PATCH] add support PXA168/PXA910/MMP2 SD Host Controller
Date: Tue, 21 Sep 2010 17:42:47 +0800
Message-ID: <AANLkTi=9uptdMS9DwMwtvoiePBcr9=kmxkf96=Jw02Pr@mail.gmail.com>
References: <AANLkTi=jeL0J1kfT+toB3BEAGJ5Cc5jZsHstD1hutNQB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62200 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980Ab0IUJms (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Sep 2010 05:42:48 -0400
Received: by yxp4 with SMTP id 4so1569545yxp.19
        for <linux-mmc@vger.kernel.org>; Tue, 21 Sep 2010 02:42:48 -0700 (PDT)
In-Reply-To: <AANLkTi=jeL0J1kfT+toB3BEAGJ5Cc5jZsHstD1hutNQB@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Kyungmin Park <kmpark@infradead.org>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>

Hi ,

I had worked with MMP2 platform several weeks. The mmc/sdio interface
have constraint about transfer size. The transfer size must be 8-byte
alignment. If any transfer size is 4 byte alignment and not 8-byte
alignment. This peripheral ip can't support(miss dma end interrupt or
bad transmission) even DMA mode or PIO mode.

Claud Yu
