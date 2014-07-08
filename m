From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v3] s3cmci: port DMA code to dmaengine API
Date: Tue, 08 Jul 2014 15:56:14 +0300
Message-ID: <2209409.5C7y4zWhxp@vasilykh-desktop-i5>
References: <1401643329-6460-1-git-send-email-anarsoul@gmail.com> <201407072312.40687.arnd@arndb.de> <CAPDyKFoVtJLyBrjwyQYKK6h=8aNd7+SMYU9bS8iStcSZkWs3Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:50130 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754250AbaGHM5f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jul 2014 08:57:35 -0400
Received: by mail-wi0-f179.google.com with SMTP id cc10so941337wib.0
        for <linux-mmc@vger.kernel.org>; Tue, 08 Jul 2014 05:57:34 -0700 (PDT)
In-Reply-To: <CAPDyKFoVtJLyBrjwyQYKK6h=8aNd7+SMYU9bS8iStcSZkWs3Fw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, arm-linux <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Jaehoon Chung <jh80.chung@samsung.com>, Mark Brown <broonie@kernel.org>, Ben Dooks <ben-linux@fluff.org>

On 8 July 2014 14:51:01 Ulf Hansson wrote:

> Sorry for the delay.
> 
> Thanks! Applied for next with Arnd's ack.
> 
> Kind regards
> Uffe

Thank you!

And since now old s3c24xx DMA (non-dmaengine) has no users we can remove it 
completely.

I'll send a patch soon.

Regards
Vasily
