From: Jae hoon Chung <jh80.chung@gmail.com>
Subject: Re: [PATCH v7] mmc: support BKOPS feature for eMMC
Date: Tue, 21 Feb 2012 23:21:38 +0900
Message-ID: <CAELcNGTfqtduibsaXTE-a1GRe=9cHEMeEZB5cxtSnG+ufvFFUQ@mail.gmail.com>
References: <4F190E26.4040909@samsung.com>
	<CAKLKtzcoOXJoZX7E87u-yfbYMCz26y3KWmqn-dA-UkJ=HiYW7A@mail.gmail.com>
	<4F3B1D69.8060308@samsung.com>
	<6c3f05d8d59e75411f3284e8344e0bdd.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50108 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755448Ab2BUOVm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Feb 2012 09:21:42 -0500
Received: by bkcjm19 with SMTP id jm19so5358544bkc.19
        for <linux-mmc@vger.kernel.org>; Tue, 21 Feb 2012 06:21:40 -0800 (PST)
In-Reply-To: <6c3f05d8d59e75411f3284e8344e0bdd.squirrel@www.codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Konstantin Dorfman <kdorfman@codeaurora.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Saugata Das <saugata.das@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>

2012/2/21 Konstantin Dorfman <kdorfman@codeaurora.org>:
> Hello Jaehoon,
> I'm testing your patch and will post review soon.
> Have you ever seen urgent BKOPS triggered?
> I have BUGON() on such event and till now never seen it.
Hi Konstantin..
Actually, i didn't urgent BKOPS(level-3), but i have seen the level-2.
I think that maybe eMMC4.41 is triggered the urgent BKOPS with level-2.
(Now, i didn't see the spec, tomorrow i will check this.)
Thanks for testing..and i will wait for your review..

Best Regards,
Jaehoon Chung
>
> --
> Konstantin Dorfman
> Consultant for Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
