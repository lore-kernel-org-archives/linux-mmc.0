From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH v3] mmc: dw_mmc: let device core setup the default pin configuration
Date: Tue, 9 Apr 2013 11:37:01 +0530
Message-ID: <CAJuYYwQmK=Lxw_+3GDHw=_c=3UJJNi0rcNjxNKPtDMPMw29YoQ@mail.gmail.com>
References: <1365170015-3009-1-git-send-email-thomas.abraham@linaro.org>
	<003501ce3453$502adf80$f0809e80$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ia0-f181.google.com ([209.85.210.181]:39215 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932614Ab3DIGHC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Apr 2013 02:07:02 -0400
Received: by mail-ia0-f181.google.com with SMTP id o25so6028041iad.12
        for <linux-mmc@vger.kernel.org>; Mon, 08 Apr 2013 23:07:01 -0700 (PDT)
In-Reply-To: <003501ce3453$502adf80$f0809e80$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Girish Shivananjappa <girish.shivananjappa@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, arm-linux <linux-arm-kernel@lists.infradead.org>, Tomasz Figa <t.figa@samsung.com>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, Patch Tracking <patches@linaro.org>

On 8 April 2013 17:49, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> On Friday, April 05, 2013, Thomas Abraham wrote:
>> With device core now able to setup the default pin configuration,
>> the pin configuration code based on the deprecated Samsung specific
>> gpio bindings is removed.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
>
> I hope that your another patch is merged.
>  ARM: dts: add pinctrl nodes for Exynos5250 SoC
> I didn't check whether it is applied.

Hi Seungwon,

Thanks for your Ack. Yes, the pinctrl nodes for Exynos5250 have been
merged through kgene's tree.

Regards,
Thomas.

>
> Thanks,
> Seungwon Jeon
>
