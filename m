From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: [PATCH] mmc: mmci: Support non-power-of-two block sizes for
 ux500v2 variant
Date: Mon, 15 Oct 2012 12:24:56 +0200
Message-ID: <CA+20K0CD_vizPB1DyJa8-bndWuapKmzx7DVq95fwd2MKedZb5A@mail.gmail.com>
References: <1350050522-8852-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:65364 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab2JOKY5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Oct 2012 06:24:57 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so3545813iag.19
        for <linux-mmc@vger.kernel.org>; Mon, 15 Oct 2012 03:24:56 -0700 (PDT)
In-Reply-To: <1350050522-8852-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Per Forlin <per.forlin@stericsson.com>

2012/10/12 Ulf Hansson <ulf.hansson@stericsson.com>:
> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> For the ux500v2 variant non power of two block sizes are supported.
> This will make it possible to decrease data overhead for SDIO
> transfers. Although we need to put some constraints to the alignment
> of the buffers when enabling this feature.
>
> Buffers must be 4 bytes aligned due to restrictions that the PL18x
> FIFO accesses must be done in a 4 byte aligned manner. Moreover we
> need to enable DMA_REQCTL for SDIO to support write of non 32 bytes
> aligned sg element lengths. In PIO mode any buffer length can be
> handled as long as the buffer address is 4 byte aligned.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Per Forlin <per.forlin@stericsson.com>

Acked-By: Johan Rudholm <johan.rudholm@stericsson.com>
