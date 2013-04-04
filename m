From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v2] mmc: dwmmc: let device core setup the default pin
 configuration
Date: Thu, 04 Apr 2013 14:47:02 +0900
Message-ID: <004201ce30f7$d4beea20$7e3cbe60$%jun@samsung.com>
References: <1364882999-31670-1-git-send-email-thomas.abraham@linaro.org>
 <CAD=FV=Xck5XW3LPmvkMfP=dfmnDH+kG4VYkRetW+SJ-bAz7SqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:62819 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab3DDFrF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Apr 2013 01:47:05 -0400
In-reply-to: <CAD=FV=Xck5XW3LPmvkMfP=dfmnDH+kG4VYkRetW+SJ-bAz7SqQ@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Doug Anderson' <dianders@chromium.org>, 'Thomas Abraham' <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Girish Shivananjappa' <girish.shivananjappa@linaro.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-arm-kernel@lists.infradead.org, 'Tomasz Figa' <t.figa@samsung.com>, =?windows-1252?Q?'Heiko_St=FCbner'?= <heiko@sntech.de>, 'Linus Walleij' <linus.walleij@linaro.org>, patches@linaro.org

On Wednesday, April 03, 2013, Doug Anderson wrote:
> Thomas,
> 
> On Mon, Apr 1, 2013 at 11:09 PM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
> > With device core now able to setup the default pin configuration,
> > the pin configuration code based on the deprecated Samsung specific
> > gpio bindings is removed.
> >
> > Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > Reviewed-by: Doug Anderson <dianders@chromium.org>
> > Tested-by: Doug Anderson <dianders@chromium.org>
> 
> You missed Seungwon's other feedback.  Please change the title from
> "mmc: dwmmc: let device core setup the default pin configuration" to
> "mmc: dw_mmc: let device core setup the default pin configuration".
> He requested that the tag have the underscore in it for consistency.
> 
> If you're resending, it also seems like it might be nice to rebase this atop:
> 
> 0f6e73d mmc: dw_mmc: Add MSHC compatible for Exynos4412
> 
> ...just to avoid the simple merge conflict when applying?
> 
> Otherwise everything here looks great...
> 
> -Doug
Thomas,
It's a conflict to merge. Please do rebase the patch.

Thanks,
Seungwon Jeon

