From: Angelo Dureghello <angelo70@gmail.com>
Subject: Re: davinci_mmc issues on kernel 3.17.0
Date: Thu, 20 Nov 2014 19:32:06 +0100
Message-ID: <546E33A6.3060502@gmail.com>
References: <546DCF68.6040100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:50471 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755887AbaKTScJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Nov 2014 13:32:09 -0500
Received: by mail-wi0-f182.google.com with SMTP id h11so6329937wiw.9
        for <linux-mmc@vger.kernel.org>; Thu, 20 Nov 2014 10:32:08 -0800 (PST)
Received: from [192.168.0.2] (host15-234-dynamic.54-79-r.retail.telecomitalia.it. [79.54.234.15])
        by mx.google.com with ESMTPSA id u5sm5227075wiz.9.2014.11.20.10.32.07
        for <linux-mmc@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Nov 2014 10:32:07 -0800 (PST)
In-Reply-To: <546DCF68.6040100@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

i fixed my mmc r/w issues.

In PIO 4-bit mode the davinci mmc host driver passed all the
mmc_test driver tests. But for some reason, in kernel 3.17,
i still have issues when i "fsck" just after the mkfs.
I still see errors.

So i moved back to DMA 4-bit mode (DMA/TI EDMA engine enabled),
as my board was working in kernel 3.5.1.

In DMA mode, there was some conditions where the mmc access
was blocking. This was due to the fact that the davinci mmc
host driver was not able to get all the edma chan slots needed
for the r/w operations. This because my board.c was reserving
several chans / slots for the audio.

I reduced those reservations, and all is fine.

Regards
Angelo
