From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: sd: check card write-protect lock while resuming
Date: Fri, 22 Aug 2014 12:00:01 +0200
Message-ID: <CAPDyKFp4vV_n5KEGSkdjfDMtbvhFzrdU0oB6N6WpmS9Ant8EOw@mail.gmail.com>
References: <1408356012-18867-1-git-send-email-Barry.Song@csr.com>
	<CAPDyKFpFLoREZ=rYp8bQvJ7Fczq=HyLL90jv7Hjzai9xTNBNYg@mail.gmail.com>
	<5EB3BFCD089AD643B9BB63439F5FD5E9012C98252C@SHAASIEXM01.ASIA.ROOT.PRI>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:39663 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbaHVKAD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Aug 2014 06:00:03 -0400
Received: by mail-lb0-f170.google.com with SMTP id l4so9254979lbv.1
        for <linux-mmc@vger.kernel.org>; Fri, 22 Aug 2014 03:00:01 -0700 (PDT)
In-Reply-To: <5EB3BFCD089AD643B9BB63439F5FD5E9012C98252C@SHAASIEXM01.ASIA.ROOT.PRI>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <Barry.Song@csr.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Minda Chen <Minda.Chen@csr.com>, DL-SHA-WorkGroupLinux <DL-SHA-WorkGroupLinux@internal.csr.com>

On 22 August 2014 08:55, Barry Song <Barry.Song@csr.com> wrote:
>> -----Original Message-----
>> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>> Sent: Monday, August 18, 2014 7:58 PM
>> To: Barry Song
>> Cc: Chris Ball; linux-mmc; linux-arm-kernel@lists.infradead.org; DL-SHA-
>> WorkGroupLinux; Minda Chen; Barry Song
>> Subject: Re: [PATCH] mmc: core: sd: check card write-protect lock while
>> resuming
>>
>> On 18 August 2014 12:00, Barry Song <Barry.Song@csr.com> wrote:
>> > From: Minda Chen <Minda.Chen@csr.com>
>> >
>> > After suspending, unplug the sdcard, and set sd WP lock, insert it
>> > again, then resume the system. resume codes do not check the the
>> > sdcard write-proctect lock. now check it.
>> >
>> > Signed-off-by: Minda Chen <Minda.Chen@csr.com>
>> > Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> > ---
>> >  drivers/mmc/core/sd.c | 7 +++++++
>> >  1 file changed, 7 insertions(+)
>> >
>> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
>> > 0c44510..890557a 100644
>> > --- a/drivers/mmc/core/sd.c
>> > +++ b/drivers/mmc/core/sd.c
>> > @@ -910,6 +910,7 @@ static int mmc_sd_init_card(struct mmc_host
>> *host, u32 ocr,
>> >         int err;
>> >         u32 cid[4];
>> >         u32 rocr = 0;
>> > +       bool oldro, ro;
>> >
>> >         BUG_ON(!host);
>> >         WARN_ON(!host->claimed);
>> > @@ -922,6 +923,12 @@ static int mmc_sd_init_card(struct mmc_host
>> *host, u32 ocr,
>> >                 if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) != 0)
>> >                         return -ENOENT;
>> >
>> > +               if (host->ops->get_ro) {
>> > +                       ro = host->ops->get_ro(host) ? true : false;
>> > +                       oldro = mmc_card_readonly(oldcard) ? true : false;
>> > +                       if (oldro ^ ro)
>> > +                               return -ENOENT;
>> > +               }
>>
>> Seems like this code belongs better in mmc_sd_setup_card(). Could you try
>> moving it there.
> [Barry Song]
> Well. How about:
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 0c44510..643bc82d8 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -815,6 +815,7 @@ int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
>         bool reinit)
>  {
>         int err;
> +       int oldro, ro = -1;
>
>         if (!reinit) {
>                 /*
> @@ -861,23 +862,28 @@ int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
>         /*
>          * Check if read-only switch is active.
>          */
> -       if (!reinit) {
> -               int ro = -1;
>
> -               if (host->ops->get_ro) {
> -                       mmc_host_clk_hold(card->host);
> -                       ro = host->ops->get_ro(host);
> -                       mmc_host_clk_release(card->host);
> -               }
> +       if (host->ops->get_ro) {
> +               mmc_host_clk_hold(card->host);
> +               ro = host->ops->get_ro(host);
> +               mmc_host_clk_release(card->host);
> +       }
>
> -               if (ro < 0) {
> -                       pr_warning("%s: host does not "
> -                               "support reading read-only "
> -                               "switch. assuming write-enable.\n",
> -                               mmc_hostname(host));
> -               } else if (ro > 0) {
> -                       mmc_card_set_readonly(card);
> -               }
> +       if (ro < 0)
> +               pr_warning("%s: host does not "
> +                       "support reading read-only "
> +                       "switch. assuming write-enable.\n",
> +                       mmc_hostname(host));

I don't wont this pr_warning to spam the log each resume.
I suppose we could print it only for !reinit, right?

> +
> +       if (!reinit && (ro > 0))
> +               mmc_card_set_readonly(card);
> +       else if (reinit && (ro >= 0)) {
> +               /* check if the write-protection lock is changed */
> +               oldro = mmc_card_readonly(card) ? 1 : 0;
> +               ro = (ro > 0) ? 1 : 0;
> +
> +               if (oldro ^ ro)
> +                       return -ENOENT;

This will have the effect of quickly returning an error to the mmc
bus' ->suspend callback. That path are not able remove the card
device, which I guess is what you would like to happen, right?

I am not completely sure, but I believe the card will still be
operational after resuming. Moreover it will be using the
initialization frequency and 1-bit bus width and thus performing
poorly. This is definitely not what we want.

How did you test this patch? Can you confirm my theory above?

The card may only be removed from the mmc_rescan work, scheduled at
PM_POST_SUSPEND phase. What I think you should do here, is to also set
the card state into MMC_CARD_REMOVED, by invoking
mmc_card_set_removed(). Thus the SD's bus_ops->detect callback will
remove the card during this phase.

Kind regards
Uffe
