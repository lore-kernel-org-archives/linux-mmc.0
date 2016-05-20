From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v3 5/5] mmc: sdhci-of-arasan: implement enhanced strobe
 callback
Date: Fri, 20 May 2016 09:49:11 +0800
Message-ID: <573E6D17.7090601@rock-chips.com>
References: <1462871343-32361-1-git-send-email-shawn.lin@rock-chips.com>
 <1462871407-32566-1-git-send-email-shawn.lin@rock-chips.com>
 <CAD=FV=VU7cY+jQ3Tys5vLY_=pP-w5-cKxNTs5JBRxkwr+nVjmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAD=FV=VU7cY+jQ3Tys5vLY_=pP-w5-cKxNTs5JBRxkwr+nVjmQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi

=E5=9C=A8 2016-5-20 8:11, Doug Anderson =E5=86=99=E9=81=93:
> Hi,
>
> On Tue, May 10, 2016 at 2:10 AM, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>=
 wrote:
>> Currently sdhci-arasan 5.1 can support enhanced strobe function,
>> and we now limit it just for "arasan,sdhci-5.1". Add
>> mmc-hs400-enhanced-strobe in DT to enable the function if we'r sure
>
> nit:s/we'r/we're/
>
> [ ... ]
>> @@ -79,6 +81,21 @@ static void sdhci_arasan_set_clock(struct sdhci_h=
ost *host, unsigned int clock)
>>          }
>>   }
>>
>> +static void sdhci_arasan_hs400_enhanced_strobe(struct mmc_host *mmc=
,
>> +                                       struct mmc_ios *ios)
>> +{
>> +       u32 vendor;
>> +       struct sdhci_host *host =3D mmc_priv(mmc);
>> +
>> +       vendor =3D readl(host->ioaddr + SDHCI_ARASAN_VENDOR_REGISTER=
);
>> +       if (ios->enhanced_strobe)
>> +               vendor |=3D VENDOR_ENHANCED_STROBE;
>> +       else
>> +               vendor &=3D (~VENDOR_ENHANCED_STROBE);
>
> nit: no extra parentheses:
>
>    vendor &=3D ~VENDOR_ENHANCED_STROBE;
>
>
> Other than the nits this patch looks good to me.  Feel free to add my
> Reviewed-by when nits fixed.

okay, will fix them.

Thanks for your review!

>
> -Doug
>
>
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
