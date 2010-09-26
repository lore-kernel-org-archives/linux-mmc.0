From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] add support PXA168/PXA910/MMP2 SD Host Controller
Date: Sun, 26 Sep 2010 05:05:33 -0400
Message-ID: <AANLkTinJXmUAzsRMRFX9Pzz-md7biRu-t9UKxgkAxTTP@mail.gmail.com>
References: <AANLkTi=jeL0J1kfT+toB3BEAGJ5Cc5jZsHstD1hutNQB@mail.gmail.com>
	<AANLkTi=9uptdMS9DwMwtvoiePBcr9=kmxkf96=Jw02Pr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37356 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775Ab0IZJFe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Sep 2010 05:05:34 -0400
Received: by iwn5 with SMTP id 5so3760158iwn.19
        for <linux-mmc@vger.kernel.org>; Sun, 26 Sep 2010 02:05:34 -0700 (PDT)
In-Reply-To: <AANLkTi=9uptdMS9DwMwtvoiePBcr9=kmxkf96=Jw02Pr@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: claud yu <claud.yu@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Kyungmin Park <kmpark@infradead.org>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>

On Tue, Sep 21, 2010 at 5:42 AM, claud yu <claud.yu@gmail.com> wrote:
> Hi ,
>
> I had worked with MMP2 platform several weeks. The mmc/sdio interface
> have constraint about transfer size. The transfer size must be 8-byte
> alignment. If any transfer size is 4 byte alignment and not 8-byte
> alignment. This peripheral ip can't support(miss dma end interrupt or
> bad transmission) even DMA mode or PIO mode.
>

8 bytes alignment limitation has been solved from A0, bytes alignment is OK now.
> Claud Yu
>
