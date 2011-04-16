From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH] mmc: sdhci: add support for pre_req and post_req
Date: Sat, 16 Apr 2011 18:06:00 -0500
Message-ID: <BANLkTi=pqGyijbfuHD=uQzPnaYvNOQyzdg@mail.gmail.com>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
	<1302972516-8673-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og115.obsmtp.com ([64.18.0.246]:37277 "EHLO
	exprod5og115.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754347Ab1DPXGD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Apr 2011 19:06:03 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3GN4AAV011602
	for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 19:04:10 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3GN2jnI011132
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 19:04:10 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so5175435wyb.15
        for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 16:06:00 -0700 (PDT)
In-Reply-To: <1302972516-8673-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org, cjb@laptop.org, per.forlin@linaro.org

Hi Shawn,

On Sat, Apr 16, 2011 at 11:48 AM, Shawn Guo <shawn.guo@linaro.org> wrot=
e:
> pre_req() runs dma_map_sg() post_req() runs dma_unmap_sg.
> If not calling pre_req() before sdhci_request(), request()
> will prepare the cache just like it did it before.
> It is optional to use pre_req() and post_req().
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> I worked out the patch by referring to Per's patch below.
>
> =A0omap_hsmmc: add support for pre_req and post_req
>
> It adds pre_req and post_req support for sdhci based host drivers to
> work with Per's non-blocking optimization. =A0But I only have imx esd=
hc
> based hardware to test. =A0Unfortunately, I can not measure the
> performance gain using mmc_test, because the current esdhc driver on
> mainline fails on the test. =A0So I just did a quick test using 'dd',
> but sadly, I did not see noticeable performance gain here. =A0The
> followings are possible reasons I can think of right away.
>
> * The patch did not add pre_req and post_req correctly. =A0Please hel=
p
> =A0review to catch the mistakes if any.
> * The imx esdhc driver uses SDHCI_SDMA (max_segs is 1) than SDHCI_ADA=
M
> =A0(max_segs is 128), due to the broken ADMA support on imx esdhc. =A0=
So
> =A0can people holding other sdhci based hardware give a try on the
> =A0patch?
>
> Hopefully, I can find some time to have a close look at the mmc_test
> failure and the broken ADMA with imx esdhc.
>

I'll try it out...

A
