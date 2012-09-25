From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: Fixup broken suspend and eMMC4.5 power off notify
Date: Tue, 25 Sep 2012 11:19:33 +0200
Message-ID: <CAPDyKFrt4sB2PM8JuOODy7B7ME2wRx9Dy5yKPK23E47E-OMwmA@mail.gmail.com>
References: <1347528053-8521-1-git-send-email-ulf.hansson@stericsson.com>
	<CAGxe1ZFJhc-c8rS0KGdfTvejs27jjpz7T4Z2AVwoB-=7QOMemg@mail.gmail.com>
	<CACRpkdaV_PDaYH+RgM2pa9f9Gp97-D9xbxfDkPUBfXSR+-csAg@mail.gmail.com>
	<201209141504.14658.arnd@arndb.de>
	<CAGxe1ZEYgs3va6SR83UeN02Lnjr4Wd-dGWsPqTputcaiSJW6mA@mail.gmail.com>
	<CAPDyKFoJn=NrzxXsLyp_ygQj=09faa_p0Q8i7M+MEypF7Y_ACQ@mail.gmail.com>
	<m3sjadfpdh.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36788 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754371Ab2IYJTf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Sep 2012 05:19:35 -0400
Received: by wibhr7 with SMTP id hr7so320461wib.1
        for <linux-mmc@vger.kernel.org>; Tue, 25 Sep 2012 02:19:33 -0700 (PDT)
In-Reply-To: <m3sjadfpdh.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Girish K S <girish.shivananjappa@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Saugata Das <saugata.das@linaro.org>, Asutosh Das <asutoshd@codeaurora.org>

On 20 September 2012 03:35, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Wed, Sep 19 2012, Ulf Hansson wrote:
>> Just pinging you to see if you have an opinion in merging this without
>> full testing on eMMC4.5 device?
>>
>> I am kind of eager to fixup the broken suspend for eMMC with sleep,
>> which this does. :-)
>
> Well, we don't need "full testing", but I don't think it's a good idea
> to merge this without any testing at all on eMMC 4.5.  Might as well
> just wait a little longer and send it as a 3.7 fix with a stable@ tag?
> Do we have any ETA on when someone will be able to test?
>

Unfortunately still no progress for testing for eMMC 4.5. Sorry for that.

Tanya Brokhman and possibly Arnd Bergman is trying to help out, which
is really great. Although I have yet not received an answer. Hopefully
soon. :-)
My self is trying to get a hold of an eMMC 4.5 device, so I can do the
test myself.

I am not sure how long we should wait for eMMC 4.5 to be tested. Until
testing is resolved the eMMC 4.3 and onwards are having a broken
suspend sequence using SLEEP, which I think is really bad. This also
includes eMMC4.5 devices, for which hosts is not using the new
POWER_OFF _NOTIFY CAP.

Kind regards
Ulf Hansson

> Thanks,
>
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
