From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH v1 1/3]mmc: implemented runtime pm for mmc host
Date: Wed, 26 Jan 2011 20:19:08 +0100
Message-ID: <AANLkTikXsaU+6rDByji4jsSP4==cvUCBvSxuXug6UmBD@mail.gmail.com>
References: <20110114082310.GB27523@intel.com>
	<8250E4885F9967469CAC3FB5CBA2CE69934E7AA2FE@irsmsx501.ger.corp.intel.com>
	<5D8008F58939784290FAB48F54975198351D4FA654@shsmsx502.ccr.corp.intel.com>
	<8250E4885F9967469CAC3FB5CBA2CE69934E7AAB20@irsmsx501.ger.corp.intel.com>
	<5D8008F58939784290FAB48F5497519835247E72AD@shsmsx502.ccr.corp.intel.com>
	<8250E4885F9967469CAC3FB5CBA2CE69934E7AACCC@irsmsx501.ger.corp.intel.com>
	<20110120050803.GA5732@void.printf.net>
	<AANLkTimZyv9f5b5VxmmYyO3qPrb9Y25-=yUV_GYma3e_@mail.gmail.com>
	<8250E4885F9967469CAC3FB5CBA2CE69934EFA98B2@irsmsx501.ger.corp.intel.com>
	<AANLkTi=KKfxTRzW1iyLKjM0Ho6x7kYpwGwx7F-gD4EaM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=KKfxTRzW1iyLKjM0Ho6x7kYpwGwx7F-gD4EaM@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: "Tardy, Pierre" <pierre.tardy@intel.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

2011/1/26 Linus Walleij <linus.walleij@linaro.org>:
> 2011/1/25 Tardy, Pierre <pierre.tardy@intel.com>:

>> @@ -1231,6 +1233,27 @@ static void sdhci_set_ios(struct mmc_host *mm=
c, struct mmc_ios *ios)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>>
>> =A0 =A0 =A0 =A0/*
>> + =A0 =A0 =A0 =A0* get/put runtime_pm usage counter at ios->clock tr=
ansitions
>> + =A0 =A0 =A0 =A0* We need to do it before any other chip access, as=
 sdhci could
>> + =A0 =A0 =A0 =A0* be power gated
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 lastclock =3D host->iosclock;
>> + =A0 =A0 =A0 host->iosclock =3D ios->clock;
>> + =A0 =A0 =A0 if (lastclock =3D=3D 0 && ios->clock !=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&host->lock, fl=
ags);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(host->mmc->parent)=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&host->lock, flags);
>> + =A0 =A0 =A0 } else if (lastclock !=3D 0 && ios->clock =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&host->lock, fl=
ags);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_mark_last_busy(host->mmc->p=
arent);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_autosuspend(host->mmc->=
parent);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&host->lock, flags);
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 /* no need to configure the rest.. */
>> + =A0 =A0 =A0 if (host->iosclock =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> +
>> + =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0 * Reset the chip on each power off.
>> =A0 =A0 =A0 =A0 * Should clear out any weird states.
>> =A0 =A0 =A0 =A0 */
>
> Aha I get it. So it uses the freq shift from the existing clock gate
> code to hint rpm, that's actually how I envisioned that this would
> work for this case.
>
> Now I really started liking this patch.
> Acked-by: Linus Walleij <linus.walleij@stericsson.com>

Which shall be interpreted as for the patch with the above code, not
the one which is subject for this post I believe.

Pierre, I can't locate your patches for some reason, care to repost
them?

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
