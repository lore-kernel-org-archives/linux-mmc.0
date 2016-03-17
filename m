From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC] improve mmc init sequence
Date: Thu, 17 Mar 2016 11:43:09 +0100
Message-ID: <CAPDyKFq3PWHZpzi4CyPU4WYHdRXK7QVQW7+Ekf+2AkWxey971g@mail.gmail.com>
References: <56EA2758.7090200@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34407 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966973AbcCQKnK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Mar 2016 06:43:10 -0400
Received: by mail-wm0-f42.google.com with SMTP id p65so19809348wmp.1
        for <linux-mmc@vger.kernel.org>; Thu, 17 Mar 2016 03:43:09 -0700 (PDT)
In-Reply-To: <56EA2758.7090200@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 17 March 2016 at 04:41, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Hello Ulf,
>         I notice we add MMC_CAP2_NO_SDIO to avoid sending sdio commands
> during initialization. So that means we can use it to improve mmc init
> sequence if a specific board use one slot just for emmc or sd. But I realize
> that we can move a step further to add more cap2 like NO_SD/
> NO_MMC in order to reduce the boot time. Does that make sense? If the
> answer is *yes*, I am happy to push some patches for it since I have
> been doing it on my local tree and testing for a long time.

I am not against it, so please go ahead!

Although, you need to give some proof of the amount of saved boot time
(or better the decreased initialization time of a couple of different
cards).

Kind regards
Uffe
