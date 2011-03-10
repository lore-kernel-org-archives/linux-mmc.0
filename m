From: Grant Grundler <grundler@chromium.org>
Subject: Re: [PATCH] SDHCI: Suspend/Resume needs to save/restore INT_ENABLE on ARM/Tegra2
Date: Wed, 9 Mar 2011 16:32:23 -0800
Message-ID: <AANLkTikJe-M2ZZhiDExXK9BCsh9-0M+BuYFBgJwW0vU5@mail.gmail.com>
References: <20110308213921.00625208186@grundler.mtv.corp.google.com>
	<AANLkTik3vKKs+Sxe1g+igFOpqmdYDMec7MH1mKjv0qGw@mail.gmail.com>
	<AANLkTikwapQ_Qe-U=Noan45kztNrLzZA39Oj8jLBuzV+@mail.gmail.com>
	<AANLkTikBm00dzzGU_Rap9A0RmebnW6TOvG4LS3cXs1XW@mail.gmail.com>
	<AANLkTi==6jPPBJQou8KAGZCKtmmN44Q85PR5x2_KOR2J@mail.gmail.com>
	<AANLkTinKiLF2+Yb0q9UmA21h1-uVRCSRmXNXzOWJNtnJ@mail.gmail.com>
	<AANLkTimOnOvePrb2dT7z15RMepMEBtA4NtKLgAJVk1gW@mail.gmail.com>
	<AANLkTi=gVXFUajp3K_bhy8P0VcJ2v4=xNYPE7WySQEiL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:46771 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727Ab1CJAc1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Mar 2011 19:32:27 -0500
Received: from kpbe13.cbf.corp.google.com (kpbe13.cbf.corp.google.com [172.25.105.77])
	by smtp-out.google.com with ESMTP id p2A0WPUt006505
	for <linux-mmc@vger.kernel.org>; Wed, 9 Mar 2011 16:32:26 -0800
Received: from gwaa12 (gwaa12.prod.google.com [10.200.27.12])
	by kpbe13.cbf.corp.google.com with ESMTP id p2A0ULQc017046
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 9 Mar 2011 16:32:24 -0800
Received: by gwaa12 with SMTP id a12so249057gwa.28
        for <linux-mmc@vger.kernel.org>; Wed, 09 Mar 2011 16:32:24 -0800 (PST)
In-Reply-To: <AANLkTi=gVXFUajp3K_bhy8P0VcJ2v4=xNYPE7WySQEiL@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: Olof Johansson <olof@lixom.net>, Dmitry Shmidt <dimitrysh@google.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Venkat Rao <vrao@broadcom.com>, Sandeep Kumar <sandeepm@broadcom.com>

On Wed, Mar 9, 2011 at 4:07 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
...
> I believe Grant's change is necessary for any SDHCI controller with
> SDIO and suspend/resume.

BTW, to pick nits, I'm not the author. Note the S-o-b lines in the
original patch:

Signed-off-by: Venkat Rao <vrao@broadcom.com>
Reviewed-by: Olof Johansson <olofj@chromium.org>
Reviewed-by: Grant Grundler <grundler@chromium.org>


cheers,
grant
