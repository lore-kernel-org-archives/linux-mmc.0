From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 2/2] mmc: sdhci-cadence: add Cadence SD4HC support
Date: Fri, 16 Dec 2016 12:07:42 +0100
Message-ID: <CAPDyKFqmTP1+pe7UNavOAZA0QWFOu8M4FcQOpGkqZj=nnpP9qA@mail.gmail.com>
References: <1481201455-3483-1-git-send-email-yamada.masahiro@socionext.com>
 <1481201455-3483-3-git-send-email-yamada.masahiro@socionext.com>
 <20161212171408.2yf4jauz7czv44fy@rob-hp-laptop> <CAK7LNATO+vpxmDV-XEupjeXXhPNdrXHNwfwWcAVWLdbJi+37QA@mail.gmail.com>
 <CAPDyKFrejOSGVWb=gsuCixxj_OXfLfo22VwLDC_Y4scw+Se8FQ@mail.gmail.com> <CAK7LNASaKpGyE_qpQGyqxeVRSkqwj6Rm4WKNq2Zs4Woj4MY01A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK7LNASaKpGyE_qpQGyqxeVRSkqwj6Rm4WKNq2Zs4Woj4MY01A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Cooper <alcooperx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, Andrei Pistirica <andrei.pistirica-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

[...]

>>
>> I think a better approach is to use the new sdhci-caps* bindings to
>> mask those caps that can't be trusted. And then use the generic mmc
>> bindings for speed modes instead.
>>
>> That should be a safer approach, right!?
>
> Right.
>
> But, if I know the caps register bits 63-32 are all zero,
> I need not explicitly specify sdhci-caps-mask, right?

Maybe not. I don't have a strong opinion here, so l am fine with
whatever you choose.

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
