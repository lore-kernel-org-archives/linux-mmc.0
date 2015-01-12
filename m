From: Alim Akhtar <alim.akhtar@gmail.com>
Subject: Re: [PATCH v3 1/4] mmc: dw_mmc: exynos: incorporate ciu_div into
 timing property
Date: Mon, 12 Jan 2015 19:22:47 +0530
Message-ID: <CAGOxZ52Fn3Q=mhkX+CPZsnNz-T5z09xR6ZGYhjYMQ9BOugs_+g@mail.gmail.com>
References: <1420008185-24758-1-git-send-email-alim.akhtar@samsung.com>
 <1420008185-24758-2-git-send-email-alim.akhtar@samsung.com>
 <CAD=FV=WXzPt=VKxB=KHK+hC=RN6WbmdnQcLUT4zFQ0Ud7BFanQ@mail.gmail.com>
 <CAGOxZ509kASim7keNkAGj5gAGO02=7vZM=VL-MRMObv3x+CzTg@mail.gmail.com> <CAD=FV=U0U2ycmd4jyVyFiEq0+3ujSpdBeFg27iYYbMRxpRCmmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yh0-f43.google.com ([209.85.213.43]:45328 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236AbbALNx2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Jan 2015 08:53:28 -0500
In-Reply-To: <CAD=FV=U0U2ycmd4jyVyFiEq0+3ujSpdBeFg27iYYbMRxpRCmmQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, kgene <kgene@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Abhilash Kesavan <a.kesavan@samsung.com>, Alexandru Stan <amstan@google.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Olof Johansson <olof@lixom.net>, Kevin Hilman <khilman@linaro.org>

Hi Doug,

On Tue, Jan 6, 2015 at 6:37 AM, Doug Anderson <dianders@chromium.org> wrote:
> Alim,
>
> On Sun, Jan 4, 2015 at 2:43 PM, Alim Akhtar <alim.akhtar@gmail.com> wrote:
>>> You are breaking backward compatibility here.  If your change is
>>> merged then all old boards will instantly break.  Since the "dts" and
>>> code changes will likely be merged through different trees you'll end
>>> up with a bunch of broken trees until everything is merged together.
>>> Even if you don't subscribe to the stable bindings theory this is not
>>> acceptable.
>>>
>> yes the major concern in this series is probably this, which breaks
>> things unless everything merge in one go and via one tree. Thats why I
>> re-based everything including dts change on mmc-tree for this case and
>> added device-tree mailing list for more opinion etc.
>
> Got it.  I doubt that folks will like this, but I could be wrong.  In
> order for this to work, you'd need all changes in the series to land
> in _both_ the ARMSoC tree and the MMC tree.  That's not unheard of,
> but it doesn't seem ideal.
>
> You also break bisect-ability here since without the code the DTS
> change will break things and without the DTS change the code will
> break things.
>
> If you add all the above to the fact that bindings are supposed to be
> stable (ish) I'm not convinced this will land.
>
Hmmm......Ok, let me take a re-look on this, I will try to use
existing bindings.
>
> -Doug



-- 
Regards,
Alim
