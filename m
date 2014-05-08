From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: rtsx: usb backend needs LED support
Date: Thu, 08 May 2014 10:25:19 +0200
Message-ID: <4607495.q99siu2peP@wuerfel>
References: <cover.1398735435.git.micky_ching@realsil.com.cn> <CAPDyKFrA39eFnoy-sAGcAUeDqtB78cvAivV+mmRR5C-tov-9eg@mail.gmail.com> <536B3B6F.1010209@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:65522 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbaEHIZ3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 May 2014 04:25:29 -0400
In-Reply-To: <536B3B6F.1010209@realtek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roger <rogerable@realtek.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Lee Jones <lee.jones@linaro.org>, micky <micky_ching@realsil.com.cn>, Chris Ball <chris@printf.net>, Samuel Ortiz <sameo@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@oracle.com>, devel@linuxdriverproject.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Wei WANG <wei_wang@realsil.com.cn>

On Thursday 08 May 2014 16:08:15 Roger wrote:
> 
> Would this patch be merged into linux-next or Lee's mfd.git 
> ib-mfd-mmc-memstick-3.16 branch?

It should get merged into whatever tree holds the existing patches, yes

> By the way, should I resend my version?

Actually I found another issue with it and fixed it up here, let me
send the version that works for me.

	Arnd
