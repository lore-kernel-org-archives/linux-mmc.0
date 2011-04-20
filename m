From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH] mmc: mxs-mmc: add support for pre_req and post_req
Date: Wed, 20 Apr 2011 10:01:22 +0200
Message-ID: <BANLkTimwvX633UaUoc4P4DD1xnpLbMTrZA@mail.gmail.com>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
	<1303058010-30256-1-git-send-email-shawn.guo@linaro.org>
	<20110417164830.GE17935@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:43308 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750Ab1DTIBX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2011 04:01:23 -0400
Received: by qyk7 with SMTP id 7so2103648qyk.19
        for <linux-mmc@vger.kernel.org>; Wed, 20 Apr 2011 01:01:23 -0700 (PDT)
In-Reply-To: <20110417164830.GE17935@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, linaro-kernel@lists.linaro.org, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On 17 April 2011 18:48, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Mon, Apr 18, 2011 at 12:33:30AM +0800, Shawn Guo wrote:
>> pre_req() runs dma_map_sg() post_req() runs dma_unmap_sg.
>> If not calling pre_req() before mxs_mmc_request(), request()
>> will prepare the cache just like it did it before.
>> It is optional to use pre_req() and post_req().
>>
>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>> ---
>> =A0drivers/mmc/host/mxs-mmc.c | =A0 75 +++++++++++++++++++++++++++++=
+++++++++++++--
>> =A01 files changed, 72 insertions(+), 3 deletions(-)
>>
>
> Here is the result of mmc_test case 37 ~ 40, which are designed to se=
e
> the performance improvement introduced by non-blocking changes.
>
> Honestly, the improvement is not so impressive. =A0Not sure if the pa=
tch
> for mxs-mmc pre_req and post_req support was correctly produced. =A0S=
o
> please help review ...
My guess is that dma_unmap is not run in parallel with transfer.
Please look at my patch reply.

>
> --
> Regards,
> Shawn
Regards,
Per
