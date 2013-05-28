From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH V3 3/4] mmc: block: Enable runtime pm for mmc blkdevice
Date: Tue, 28 May 2013 14:49:26 +0800
Message-ID: <CAMj5Bkj3U3+jq0nFjnrh8pKSU=JELNpB4h61Xexu_PmS8-ii=g@mail.gmail.com>
References: <1366106437-18004-1-git-send-email-ulf.hansson@stericsson.com>
	<1366106437-18004-4-git-send-email-ulf.hansson@stericsson.com>
	<CAMj5BkiOmh8sz-=b0z1VF9owGPX0KpbZeNfPzETemCb=C2odGQ@mail.gmail.com>
	<CAPDyKFqDU1Dh1Ya+pQzAmzh=Nk5dPZ2-k2Nu8osfo+Fi=DYP8Q@mail.gmail.com>
	<CAMj5Bki+1=DSzQWYyEC1L=Pa6LpSFQKF3YvoUkkuq62wHuMWow@mail.gmail.com>
	<CAPDyKFoOFBo4=etE=D0sHzZdp6ft32Bd0dM4JmzGO3kQ-kicrg@mail.gmail.com>
	<CAPDyKFokFQ1r4Xrh8Lk_hLUzgxR6EX2kxN0Yrj_mOHyyH9FHsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f181.google.com ([209.85.215.181]:48933 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932702Ab3E1Gt1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 May 2013 02:49:27 -0400
Received: by mail-ea0-f181.google.com with SMTP id a11so4184334eae.26
        for <linux-mmc@vger.kernel.org>; Mon, 27 May 2013 23:49:26 -0700 (PDT)
In-Reply-To: <CAPDyKFokFQ1r4Xrh8Lk_hLUzgxR6EX2kxN0Yrj_mOHyyH9FHsw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Maya Erez <merez@codeaurora.org>, Subhash Jadavani <subhashj@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Liu <kliu5@marvell.com>, Adrian Hunter <adrian.hunter@intel.com>, Daniel Drake <dsd@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>

> >>
> >> Maybe I make misunderstood, or do some mistake.
> >> since CONFIG_MMC_UNSAFE_RESUME has to be set, is that mean sd card can not
> >> be unpluged with the feature enabled.
> >> It can be reproduced here if unplug card in suspend or not.
> >>
> >> static void mmc_sd_detect(struct mmc_host *host)
> >> {
> >>  err = _mmc_detect_card_removed(host);
> >>
> >> if (err) {
> >>                 mmc_sd_remove(host);
> >>                 /* host -> card is NULL now */
> >>                 mmc_get_card(host->card);
> >> }
> >>
> >
> > I have no idea how you applied and tested this patch, but it seems
> > like you have screwed it up. The above code is aligned with this
> > patch.
>
> Sorry, the above code is NOT aligned with the code in this patch.
>
> >
> > mmc_get_card is called before "err = _mmc_detect_card_removed(host)".
> > And mmc_put_card, immediately after "err =
> > _mmc_detect_card_removed(host)".
> >
> > Please consider re-applying the patch and re-test.

The patches works fine.

I am sorry, my mistake.
When back-port to 3.9, some mess up :(

Thanks
