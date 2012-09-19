From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: Fixup broken suspend and eMMC4.5 power off notify
Date: Wed, 19 Sep 2012 18:06:08 +0200
Message-ID: <CAPDyKFoJn=NrzxXsLyp_ygQj=09faa_p0Q8i7M+MEypF7Y_ACQ@mail.gmail.com>
References: <1347528053-8521-1-git-send-email-ulf.hansson@stericsson.com>
	<CAGxe1ZFJhc-c8rS0KGdfTvejs27jjpz7T4Z2AVwoB-=7QOMemg@mail.gmail.com>
	<CACRpkdaV_PDaYH+RgM2pa9f9Gp97-D9xbxfDkPUBfXSR+-csAg@mail.gmail.com>
	<201209141504.14658.arnd@arndb.de>
	<CAGxe1ZEYgs3va6SR83UeN02Lnjr4Wd-dGWsPqTputcaiSJW6mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:59356 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756619Ab2ISQGK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Sep 2012 12:06:10 -0400
Received: by weyx8 with SMTP id x8so672708wey.19
        for <linux-mmc@vger.kernel.org>; Wed, 19 Sep 2012 09:06:09 -0700 (PDT)
In-Reply-To: <CAGxe1ZEYgs3va6SR83UeN02Lnjr4Wd-dGWsPqTputcaiSJW6mA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>, Chris Ball <cjb@laptop.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Saugata Das <saugata.das@linaro.org>, Asutosh Das <asutoshd@codeaurora.org>

Hi Chris,

Just pinging you to see if you have an opinion in merging this without
full testing on eMMC4.5 device?

I am kind of eager to fixup the broken suspend for eMMC with sleep,
which this does. :-)

Kind regards
Ulf Hansson

On 17 September 2012 06:50, Girish K S <girish.shivananjappa@linaro.org> wrote:
> On 14 September 2012 20:34, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Friday 14 September 2012, Linus Walleij wrote:
>>> On Fri, Sep 14, 2012 at 10:25 AM, Girish K S
>>> <girish.shivananjappa@linaro.org> wrote:
>>> > On 14 September 2012 12:37, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> >> Hi Girish,
>>> >>
>>> >> I should also have stated that this patch has not been tested with an
>>> >> eMMC 4.5 device, thus the power off notification is not fully tested.
>>> >> Unfortunate I don't have such a device available right now. What I did
>>> >> test was that patch must not break anything and tested that the
>>> >> suspend/resume sequence is fixed for eMMC with sleep support. I also
>>> >> tested this with MMC_CAP2_POWEROFF_NOTIFY enabled.
>>> >>
>>> >> Are you able to help out in testing with a eMMC 4.5 device with
>>> >> POWER_OFF_NOTIFY support?
>>> >
>>> > I am also facing the same  problem. The board that i used earlier to
>>> > upstream 4.5 patches is not functioning. Thats the reason for the
>>> > delay in upstreaming or sending the patch. Once i get it repaired i ll
>>> > definitely do it.
>>> > It would be helpful if somebody in the list can do this in the mean time.
>>>
>>> Let's page Arnd, I was under the impression that he has a eMMC 4.5
>>> board so maybe he can test it?
>>
>> I have a few eMMC samples but am only using them with my (slow) thinkpad
>> SD card reader. I also don't know which eMMC-4.5 features they implement,
>> as some may be early prototypes.
>>
>> What exactly do you need tested?
> Poweroff Notify feature with the above patch in suspend to ram.
>>
>>         Arnd
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
