From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: Handle wp-gpios from device tree
Date: Wed, 21 Nov 2012 20:33:55 -0800
Message-ID: <CAD=FV=Xz_nQSLqoR7TSd8vn5No9+TVa9q-hp1i0BpgUK=G3EoQ@mail.gmail.com>
References: <1353535387-32106-1-git-send-email-dianders@chromium.org>
	<1353535387-32106-2-git-send-email-dianders@chromium.org>
	<000701cdc852$a5e4a130$f1ade390$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000701cdc852$a5e4a130$f1ade390$%jun@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, Thomas Abraham <thomas.abraham@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Will Newton <will.newton@imgtec.com>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Nov 21, 2012 at 5:42 PM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> Hi,
>
> wp-gpios has been implemented in dw_mmc-exynos.c
> It can be reused for EXYNOS platform? We need to modify some though.

Yup, I've seen that.  Patch 1/2 ("mmc: dw_mmc: exynos: Stop claiming
wp-gpio") addressed that.  For some reason I can't find that on
LKML.org yet.  Strange.  :-/  I'll forward it on to you shortly.

In any case: I found that the exynos code didn't actually work.  It
claimed the GPIO but didn't ever look at it.

I have the beginnings of the code to implement this properly in the
exynos code but I stopped working on it when I decided that other SoCs
could also benefit from the code and it fit better in the general
dw_mmc driver.

If you disagree and would like me to cleanup the version of this patch
that's just in the exynos driver and post that, I will.  Just let me
know.


Thanks for the review!

-Doug
