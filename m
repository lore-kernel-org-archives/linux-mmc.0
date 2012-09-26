From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: Fixup broken suspend and eMMC4.5 power off notify
Date: Wed, 26 Sep 2012 13:19:09 +0200
Message-ID: <CACRpkda65BcOtKLrEdx+TE7yw8+tk2B+PyP84X6=sLx09VAUPQ@mail.gmail.com>
References: <1347528053-8521-1-git-send-email-ulf.hansson@stericsson.com>
	<CAGxe1ZFJhc-c8rS0KGdfTvejs27jjpz7T4Z2AVwoB-=7QOMemg@mail.gmail.com>
	<CACRpkdaV_PDaYH+RgM2pa9f9Gp97-D9xbxfDkPUBfXSR+-csAg@mail.gmail.com>
	<201209141504.14658.arnd@arndb.de>
	<CAGxe1ZEYgs3va6SR83UeN02Lnjr4Wd-dGWsPqTputcaiSJW6mA@mail.gmail.com>
	<CAPDyKFoJn=NrzxXsLyp_ygQj=09faa_p0Q8i7M+MEypF7Y_ACQ@mail.gmail.com>
	<m3sjadfpdh.fsf@pullcord.laptop.org>
	<CAPDyKFrt4sB2PM8JuOODy7B7ME2wRx9Dy5yKPK23E47E-OMwmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:54288 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076Ab2IZLTK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Sep 2012 07:19:10 -0400
Received: by vcbfo13 with SMTP id fo13so463915vcb.19
        for <linux-mmc@vger.kernel.org>; Wed, 26 Sep 2012 04:19:10 -0700 (PDT)
In-Reply-To: <CAPDyKFrt4sB2PM8JuOODy7B7ME2wRx9Dy5yKPK23E47E-OMwmA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, Girish K S <girish.shivananjappa@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Saugata Das <saugata.das@linaro.org>, Asutosh Das <asutoshd@codeaurora.org>

On Tue, Sep 25, 2012 at 11:19 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> I am not sure how long we should wait for eMMC 4.5 to be tested. Until
> testing is resolved the eMMC 4.3 and onwards are having a broken
> suspend sequence using SLEEP, which I think is really bad.

To me this sounds like a case for even adding Cc: stable@kernel.org
to this when merged.

Breaking existing devices is worse than breaking future devices, so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
