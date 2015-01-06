From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v3 1/4] mmc: dw_mmc: exynos: incorporate ciu_div into
 timing property
Date: Mon, 5 Jan 2015 17:07:18 -0800
Message-ID: <CAD=FV=U0U2ycmd4jyVyFiEq0+3ujSpdBeFg27iYYbMRxpRCmmQ@mail.gmail.com>
References: <1420008185-24758-1-git-send-email-alim.akhtar@samsung.com>
	<1420008185-24758-2-git-send-email-alim.akhtar@samsung.com>
	<CAD=FV=WXzPt=VKxB=KHK+hC=RN6WbmdnQcLUT4zFQ0Ud7BFanQ@mail.gmail.com>
	<CAGOxZ509kASim7keNkAGj5gAGO02=7vZM=VL-MRMObv3x+CzTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGOxZ509kASim7keNkAGj5gAGO02=7vZM=VL-MRMObv3x+CzTg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alim Akhtar <alim.akhtar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alim Akhtar <alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, kgene <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alexandru Stan <amstan-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Alim,

On Sun, Jan 4, 2015 at 2:43 PM, Alim Akhtar <alim.akhtar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> You are breaking backward compatibility here.  If your change is
>> merged then all old boards will instantly break.  Since the "dts" and
>> code changes will likely be merged through different trees you'll end
>> up with a bunch of broken trees until everything is merged together.
>> Even if you don't subscribe to the stable bindings theory this is not
>> acceptable.
>>
> yes the major concern in this series is probably this, which breaks
> things unless everything merge in one go and via one tree. Thats why I
> re-based everything including dts change on mmc-tree for this case and
> added device-tree mailing list for more opinion etc.

Got it.  I doubt that folks will like this, but I could be wrong.  In
order for this to work, you'd need all changes in the series to land
in _both_ the ARMSoC tree and the MMC tree.  That's not unheard of,
but it doesn't seem ideal.

You also break bisect-ability here since without the code the DTS
change will break things and without the DTS change the code will
break things.

If you add all the above to the fact that bindings are supposed to be
stable (ish) I'm not convinced this will land.


-Doug
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
