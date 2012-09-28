From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH v4 06/15] mmc: sdhci-pxav3: controller can't get base clock
Date: Fri, 28 Sep 2012 10:34:33 +0800
Message-ID: <CADz5_g+M3kXLiQKaqqdALTEPgRQyQ2Q0DYLSjyiq8N3ckV8QMw@mail.gmail.com>
References: <1348659527-4200-1-git-send-email-keyuan.liu@gmail.com>
	<1348659527-4200-7-git-send-email-keyuan.liu@gmail.com>
	<CAMj5BkhJuoBNtFDgAm-=TwxZFeZ-xakNaQx_s5B+7ARUUkPnnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:39392 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952Ab2I1Cee (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Sep 2012 22:34:34 -0400
Received: by mail-wi0-f170.google.com with SMTP id hm2so102426wib.1
        for <linux-mmc@vger.kernel.org>; Thu, 27 Sep 2012 19:34:33 -0700 (PDT)
In-Reply-To: <CAMj5BkhJuoBNtFDgAm-=TwxZFeZ-xakNaQx_s5B+7ARUUkPnnw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

2012/9/27 zhangfei gao <zhangfei.gao@gmail.com>:
> On Wed, Sep 26, 2012 at 7:38 PM, Kevin Liu <keyuan.liu@gmail.com> wrote:
>> From: Kevin Liu <kliu5@marvell.com>
>>
>> Enable the quirk SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN since
>> SD_CAPABILITIES_1[15:8](BASE_FREQ) can't get correct base
>> clock value. It return a fixed pre-set value like 200 on
>> some sdhci-pxav3 based platforms like MMP3 while return 0
>> on the other sdhci-pxav3 based platforms.
>> So we enable the quirk and get the base clock via function
>> get_max_clock.
>
> Could you provide get_max_clock as well.
Thanks, will add this.
