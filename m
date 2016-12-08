From: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Subject: Re: [PATCH v4 2/2] mmc: sdhci-cadence: add Cadence SD4HC support
Date: Thu, 8 Dec 2016 21:52:41 +0900
Message-ID: <CAK7LNAQkJO0vN9T-pB3ys4N=3pG9wdWZ9z+VkYToL7F_fLo9dA@mail.gmail.com>
References: <1480903854-22701-1-git-send-email-yamada.masahiro@socionext.com>
 <1480903854-22701-3-git-send-email-yamada.masahiro@socionext.com> <CAPDyKFqbAzCyXArikgTUeTrs9vOzfwKWJcs3TgF7D-4f_xfjfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFqbAzCyXArikgTUeTrs9vOzfwKWJcs3TgF7D-4f_xfjfQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Cooper <alcooperx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andrei Pistirica <andrei.pistirica-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, Joshua Henderson <joshua.henderson-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

2016-12-08 21:32 GMT+09:00 Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>:
> On 5 December 2016 at 03:10, Masahiro Yamada
> <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org> wrote:
>> Add a driver for the Cadence SD4HC SD/SDIO/eMMC Controller.
>>
>> For SD, it basically relies on the SDHCI standard code.
>> For eMMC, this driver provides some callbacks to support the
>> hardware part that is specific to this IP design.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
>
> Thanks, applied for next!
>


Very sorry for my fix at the last minute.

I've just posted v5.

Please make sure to apply v5.

Thanks!



-- 
Best Regards
Masahiro Yamada
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
