From: Hein_Tibosch <hein_tibosch@yahoo.es>
Subject: Re: [PATCH] Fix sd/sdio/mmc initialization frequency retries
Date: Mon, 03 Jan 2011 02:08:52 +0800
Message-ID: <4D20BF34.7070008@yahoo.es>
References: <4D1A1B19.8000902@windriver.com> <4D1E4084.3080601@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bosmailout06.eigbox.net ([66.96.187.6]:52850 "EHLO
	bosmailout06.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755121Ab1ABSzG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 2 Jan 2011 13:55:06 -0500
Received: from bosmailscan16.eigbox.net ([10.20.15.16])
	by bosmailout06.eigbox.net with esmtp (Exim)
	id 1PZSQi-0000HX-7u
	for linux-mmc@vger.kernel.org; Sun, 02 Jan 2011 13:13:20 -0500
In-Reply-To: <4D1E4084.3080601@yahoo.es>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Ross <andy.ross@windriver.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Pierre Ossman <pierre@ossman.eu>, Ben Nizette <bn@niasdigital.com>, Sascha Hauer <s.hauer@pengutronix.de>, Adrian Hunter <adrian.hunter@nokia.com>, Matt Fleming <matt@console-pimps.org>

On 1-1-2011 04:43, Hein_Tibosch wrote:
> On 29-12-2010 01:15, Andy Ross wrote:
>> I'm working with a eMMC device that broke after this commit:
>>
>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=88ae8b86648
>>
>> The older hack I'd been given hard-coded the initialisation frequency
>> at 200kHz (instead of 400kHz in the original upstream) and works fine.
>>
>> But the new code tries to dynamically detect the highest frequency
>> that will work, but as far as I can tell the logic is wrong.  It will
>> continue trying after failed mmc_send_*_cond() calls, but *not* after
>> failures later on in mmc_attach_{sd,sdio,mmc}.  My boards (at 400kHz)
>> are getting successful returns from mmc_send_op_cond(), but failing in
>> mmc_attach_mmc().  If I retry at 300, it works.
>>
>> Tested on the same controller using a sdhc card.  No idea how the
>> extra retries will affect other hardware (though as the original code
>> was fixed at 400, presumably very few devices will care?).
>
> <snip>
>
> Don't know why all these additions of claim/release?
> In some cases it will lead to unnecessary releases, just because
> later in the branch claim will be called.
>
> I think in all 3 cases (sd/sdio/mmc) the change can be much simpler.
> For instance for sd.c I would do this:
>
> ---
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 49da4df..18331eb
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
>
> <snip>
>
> @@ -825,6 +829,7 @@ int mmc_attach_sd(struct mmc_host *host, u32 ocr)
>  	if (err)
>  		goto remove_card;
>
> +	mmc_claim_host(host);
>  	return 0;
>
>  remove_card:
> @@ -833,7 +838,6 @@ remove_card:
>  	mmc_claim_host(host);
>  err:
>  	mmc_detach_bus(host);
> -	mmc_release_host(host);
>
>  	printk(KERN_ERR "%s: error %d whilst initialising SD card\n",
>  		mmc_hostname(host), err);
> --
>
I tested the simplified patch as described above on AVR32 with an sd-card.

It worked well and the timing was the same as before: each frequency tried
takes about 22 ms. The third time, at 200Khz, the card got initialized.

But not much time is lost, in a meanwhile it was starting up the USB host

Hein

