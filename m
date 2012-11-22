From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 2/2] mmc: dw_mmc: Handle wp-gpios from device tree
Date: Thu, 22 Nov 2012 14:49:52 +0900
Message-ID: <000e01cdc875$314ea960$93ebfc20$%jun@samsung.com>
References: <1353535387-32106-1-git-send-email-dianders@chromium.org>
 <1353535387-32106-2-git-send-email-dianders@chromium.org>
 <000701cdc852$a5e4a130$f1ade390$%jun@samsung.com>
 <CAD=FV=Xz_nQSLqoR7TSd8vn5No9+TVa9q-hp1i0BpgUK=G3EoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAD=FV=Xz_nQSLqoR7TSd8vn5No9+TVa9q-hp1i0BpgUK=G3EoQ@mail.gmail.com>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Doug Anderson' <dianders@chromium.org>
Cc: linux-samsung-soc@vger.kernel.org, 'Thomas Abraham' <thomas.abraham@linaro.org>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Olof Johansson' <olof@lixom.net>, 'Arnd Bergmann' <arnd@arndb.de>, 'Will Newton' <will.newton@imgtec.com>, 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thursday, November 22, 2012, Doug Anderson <dianders@chromium.org> wrote:
> On Wed, Nov 21, 2012 at 5:42 PM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> > Hi,
> >
> > wp-gpios has been implemented in dw_mmc-exynos.c
> > It can be reused for EXYNOS platform? We need to modify some though.
> 
> Yup, I've seen that.  Patch 1/2 ("mmc: dw_mmc: exynos: Stop claiming
> wp-gpio") addressed that.  For some reason I can't find that on
> LKML.org yet.  Strange.  :-/  I'll forward it on to you shortly.
> 
> In any case: I found that the exynos code didn't actually work.  It
> claimed the GPIO but didn't ever look at it.
> 
> I have the beginnings of the code to implement this properly in the
> exynos code but I stopped working on it when I decided that other SoCs
> could also benefit from the code and it fit better in the general
> dw_mmc driver.
> 
> If you disagree and would like me to cleanup the version of this patch
> that's just in the exynos driver and post that, I will.  Just let me
> know.
Yes, origin code of dw_mmc-exynos didn't work fine. We need to modify it.
Anyway, some problem in mailing? I didn't get 1/2 of patch.
In addition, it's not found in any mail-archive. After resolved, I can review.

Thanks, 
Seungwon Jeon
> 
> 
> Thanks for the review!
> 
> -Doug
