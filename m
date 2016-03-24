From: Fabio Estevam <festevam@gmail.com>
Subject: Re: SDIO wifi card is not detected with 4.5-rc kernels
Date: Thu, 24 Mar 2016 14:50:56 -0300
Message-ID: <CAOMZO5BXRhc4hV52hnBDRL1nr1SnnTumf_8S2cHOGovVJF+yBA@mail.gmail.com>
References: <CA+7w51i3Kf2Jm=AXP5QhDj_8ZmzhUowbwwNEtu8UgiNkWwMYxg@mail.gmail.com>
	<CA+7w51gXWgfU0NzfKSkRtimgOH7v5G3TMTb8WNGg6GXg-xTf5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36880 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbcCXRu5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Mar 2016 13:50:57 -0400
Received: by mail-ig0-f174.google.com with SMTP id l20so17244568igf.0
        for <linux-mmc@vger.kernel.org>; Thu, 24 Mar 2016 10:50:57 -0700 (PDT)
In-Reply-To: <CA+7w51gXWgfU0NzfKSkRtimgOH7v5G3TMTb8WNGg6GXg-xTf5w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Laszlo Fiat <laszlo.fiat@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Thu, Mar 24, 2016 at 2:45 PM, Laszlo Fiat <laszlo.fiat@gmail.com> wrote:
> Hello,
>
> The original issue I reported on 17 Feb is that the SDIO WIFI card is
> not detected with 4.5RC and now mainline 4.5.0 kernel on baytrail
> tablets.
> BzukTuk commented on the bug report, that he has bisected the problem,
> and found that reverting  patch
> 520bd7a8b4152aacfbd34eb7f7a447354b631039 ("mmc: core:
> Optimize boot time by detecting cards simultaneously")  solves the problem.
> I tested this, by compiling a 4.5.0 kernel with that patch reverted,
> and the SDIO WiFi works that way.

Adding Ulf on Cc.
