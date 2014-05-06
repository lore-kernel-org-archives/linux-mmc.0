From: =?ISO-8859-1?Q?Emilio_L=F3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
Subject: Re: [PATCH v10 01/15] clk: sunxi: factors: automatic reparenting
 support
Date: Tue, 06 May 2014 17:24:08 -0300
Message-ID: <536944E8.5060300@elopez.com.ar>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com> <1399046249-19472-2-git-send-email-hdegoede@redhat.com> <20140506185131.GI9464@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140506185131.GI9464@lukather>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?ISO-8859-1?Q?David_Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

El 06/05/14 15:51, Maxime Ripard escribi=F3:
> Hi Emilio,
>
> On Fri, May 02, 2014 at 05:57:15PM +0200, Hans de Goede wrote:
>> From: Emilio L=F3pez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
>>
>> This commit implements .determine_rate, so that our factor clocks ca=
n be
>> reparented when needed.
>>
>> Signed-off-by: Emilio L=F3pez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>
> Any chance you merge this? Since it's pretty consensual, needed by
> other drivers, and that you are the author, I can it can go in.

I merged it on my tree for Mike on April 22nd

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/249259=
=2Ehtml

It seems Mike has taken another copy for 3.16 though

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/253661.h=
tml

Mike, do you want to drop the patches and have me take both of them, or=
=20
would you prefer it if I dropped my copy?

Cheers,

Emilio
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
