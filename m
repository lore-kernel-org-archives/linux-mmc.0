From: minda chen <mdchen8791@gmail.com>
Subject: Re: FW: [PATCH] mmc: core: sd: check card write-protect lock while resuming
Date: Thu, 28 Aug 2014 10:02:06 +0800
Message-ID: <CAGOPJ8trAePgNK3DtNjrGf5y7rKp-j9L7k2ivn8qwoGTKuMANQ@mail.gmail.com>
References: <1408356012-18867-1-git-send-email-Barry.Song@csr.com>
	<CAPDyKFpFLoREZ=rYp8bQvJ7Fczq=HyLL90jv7Hjzai9xTNBNYg@mail.gmail.com>
	<5EB3BFCD089AD643B9BB63439F5FD5E9012C98252C@SHAASIEXM01.ASIA.ROOT.PRI>
	<CAPDyKFp4vV_n5KEGSkdjfDMtbvhFzrdU0oB6N6WpmS9Ant8EOw@mail.gmail.com>
	<7960C73727803F45B9F4D2B2441DA8AC0CE80220@SHAASIEXM01.ASIA.ROOT.PRI>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f67.google.com ([209.85.215.67]:34912 "EHLO
	mail-la0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932408AbaH1CCI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Aug 2014 22:02:08 -0400
Received: by mail-la0-f67.google.com with SMTP id pi18so239598lab.10
        for <linux-mmc@vger.kernel.org>; Wed, 27 Aug 2014 19:02:06 -0700 (PDT)
In-Reply-To: <7960C73727803F45B9F4D2B2441DA8AC0CE80220@SHAASIEXM01.ASIA.ROOT.PRI>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, chris@printf.net, workgroup.linux@csr.com

2014-08-26 13:01 GMT+08:00 Minda Chen <Minda.Chen@csr.com>:
>
>
> -----Original Message-----
> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> Sent: Friday, August 22, 2014 6:00 PM
> To: Barry Song
> Cc: Chris Ball; linux-mmc; linux-arm-kernel@lists.infradead.org; Minda Chen; DL-SHA-WorkGroupLinux
> Subject: Re: [PATCH] mmc: core: sd: check card write-protect lock while resuming
>
> On 22 August 2014 08:55, Barry Song <Barry.Song@csr.com> wrote:
>>> -----Original Message-----
>>> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>>> Sent: Monday, August 18, 2014 7:58 PM
>>> To: Barry Song
>>> Cc: Chris Ball; linux-mmc; linux-arm-kernel@lists.infradead.org;
>>> DL-SHA- WorkGroupLinux; Minda Chen; Barry Song
>>> Subject: Re: [PATCH] mmc: core: sd: check card write-protect lock
>>> while resuming
>>>
>>> On 18 August 2014 12:00, Barry Song <Barry.Song@csr.com> wrote:
>>> > From: Minda Chen <Minda.Chen@csr.com>
>>> >
>>> > After suspending, unplug the sdcard, and set sd WP lock, insert it
>>> > again, then resume the system. resume codes do not check the the
>>> > sdcard write-proctect lock. now check it.
>>> >
>>> > Signed-off-by: Minda Chen <Minda.Chen@csr.com>
>>> > Signed-off-by: Barry Song <Baohua.Song@csr.com>
>>> > ---
>>> >  drivers/mmc/core/sd.c | 7 +++++++
>>> >  1 file changed, 7 insertions(+)
>>> >
>>> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
>>> > 0c44510..890557a 100644
>>> > --- a/drivers/mmc/core/sd.c
>>> > +++ b/drivers/mmc/core/sd.c
>>> > @@ -910,6 +910,7 @@ static int mmc_sd_init_card(struct mmc_host
>>> *host, u32 ocr,
>>> >         int err;
>>> >         u32 cid[4];
>>> >         u32 rocr = 0;
>>> > +       bool oldro, ro;
>>> >
>>> >         BUG_ON(!host);
>>> >         WARN_ON(!host->claimed);
>>> > @@ -922,6 +923,12 @@ static int mmc_sd_init_card(struct mmc_host
>>> *host, u32 ocr,
>>> >                 if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) != 0)
>>> >                         return -ENOENT;
>>> >
>>> > +               if (host->ops->get_ro) {
>>> > +                       ro = host->ops->get_ro(host) ? true : false;
>>> > +                       oldro = mmc_card_readonly(oldcard) ? true : false;
>>> > +                       if (oldro ^ ro)
>>> > +                               return -ENOENT;
>>> > +               }
>>>
>>> Seems like this code belongs better in mmc_sd_setup_card(). Could you
>>> try moving it there.
>> [Barry Song]
>> Well. How about:
>>
>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
>> 0c44510..643bc82d8 100644
>> --- a/drivers/mmc/core/sd.c
>> +++ b/drivers/mmc/core/sd.c
>> @@ -815,6 +815,7 @@ int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
>>         bool reinit)
>>  {
>>         int err;
>> +       int oldro, ro = -1;
>>
>>         if (!reinit) {
>>                 /*
>> @@ -861,23 +862,28 @@ int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
>>         /*
>>          * Check if read-only switch is active.
>>          */
>> -       if (!reinit) {
>> -               int ro = -1;
>>
>> -               if (host->ops->get_ro) {
>> -                       mmc_host_clk_hold(card->host);
>> -                       ro = host->ops->get_ro(host);
>> -                       mmc_host_clk_release(card->host);
>> -               }
>> +       if (host->ops->get_ro) {
>> +               mmc_host_clk_hold(card->host);
>> +               ro = host->ops->get_ro(host);
>> +               mmc_host_clk_release(card->host);
>> +       }
>>
>> -               if (ro < 0) {
>> -                       pr_warning("%s: host does not "
>> -                               "support reading read-only "
>> -                               "switch. assuming write-enable.\n",
>> -                               mmc_hostname(host));
>> -               } else if (ro > 0) {
>> -                       mmc_card_set_readonly(card);
>> -               }
>> +       if (ro < 0)
>> +               pr_warning("%s: host does not "
>> +                       "support reading read-only "
>> +                       "switch. assuming write-enable.\n",
>> +                       mmc_hostname(host));
>
> I don't wont this pr_warning to spam the log each resume.
> I suppose we could print it only for !reinit, right?
>
ok
>> +
>> +       if (!reinit && (ro > 0))
>> +               mmc_card_set_readonly(card);
>> +       else if (reinit && (ro >= 0)) {
>> +               /* check if the write-protection lock is changed */
>> +               oldro = mmc_card_readonly(card) ? 1 : 0;
>> +               ro = (ro > 0) ? 1 : 0;
>> +
>> +               if (oldro ^ ro)
>> +                       return -ENOENT;
>
> This will have the effect of quickly returning an error to the mmc bus' ->suspend callback. That path are not able remove the card device, which I guess is what you would like to happen, right?
>
> I am not completely sure, but I believe the card will still be operational after resuming. Moreover it will be using the initialization frequency and 1-bit bus width and thus performing poorly. This is definitely not what we want.
>
> How did you test this patch? Can you confirm my theory above?
Sorry, I didn't check it carefully.

>
> The card may only be removed from the mmc_rescan work, scheduled at PM_POST_SUSPEND phase. What I think you should do here, is to also set the card state into MMC_CARD_REMOVED, by invoking mmc_card_set_removed(). Thus the SD's bus_ops->detect callback will remove the card during this phase.
>
> Kind regards
> Uffe
>
>  To report this email as spam click https://www.mailcontrol.com/sr/MZbqvYs5QwJvpeaetUwhCQ== .
>
>
> Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
> More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
> New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.

I have a suggestion.

Compared with first patch ,mmc_sd_setup_card function select card
command (cmd7) is executed. So In mmc_rescan function the card can not
be removed. How about reset the card in this case?

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 0c44510..7db61dc 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -815,6 +815,7 @@ int mmc_sd_setup_card(struct mmc_host *host,
struct mmc_card *card,
    bool reinit)
 {
    int err;
+   int oldro, ro = -1;

    if (!reinit) {
        /*
@@ -858,18 +859,16 @@ int mmc_sd_setup_card(struct mmc_host *host,
struct mmc_card *card,
            return err;
    }

+   if (host->ops->get_ro) {
+       mmc_host_clk_hold(card->host);
+       ro = host->ops->get_ro(host);
+       mmc_host_clk_release(card->host);
+   }
+
    /*
     * Check if read-only switch is active.
     */
    if (!reinit) {
-       int ro = -1;
-
-       if (host->ops->get_ro) {
-           mmc_host_clk_hold(card->host);
-           ro = host->ops->get_ro(host);
-           mmc_host_clk_release(card->host);
-       }
-
        if (ro < 0) {
            pr_warning("%s: host does not "
                "support reading read-only "
@@ -878,6 +877,15 @@ int mmc_sd_setup_card(struct mmc_host *host,
struct mmc_card *card,
        } else if (ro > 0) {
            mmc_card_set_readonly(card);
        }
+   } else if (reinit && (ro >= 0)) {
+       /* check if the write-protection lock is changed */
+       oldro = mmc_card_readonly(card) ? 1 : 0;
+       ro = (ro > 0) ? 1 : 0;
+
+       if (oldro ^ ro) {
+           mmc_go_idle(host);
+           return -ENOENT;
+       }
    }

    return 0;
