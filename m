From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Crash during reboot due to 7628774 "mmc: core: Handle card
 shutdown from mmc_bus"
Date: Tue, 2 Jul 2013 12:40:10 +0200
Message-ID: <CAPDyKFrd7L0XvFCkRQku_nc8U5jSuRaqks-aOxTOMfj7fr_L=g@mail.gmail.com>
References: <51D1E77A.3010601@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f181.google.com ([209.85.128.181]:57728 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782Ab3GBKkN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Jul 2013 06:40:13 -0400
Received: by mail-ve0-f181.google.com with SMTP id db10so4585940veb.26
        for <linux-mmc@vger.kernel.org>; Tue, 02 Jul 2013 03:40:11 -0700 (PDT)
In-Reply-To: <51D1E77A.3010601@wwwdotorg.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>

On 1 July 2013 22:32, Stephen Warren <swarren@wwwdotorg.org> wrote:
> It looks like commit 7628774 "mmc: core: Handle card shutdown from
> mmc_bus" causes a crash during "reboot" at least on Tegra platforms. The
> issue appears to be in:
>
>> static void mmc_bus_shutdown(struct device *dev)
>> {
>>       struct mmc_driver *drv = to_mmc_driver(dev->driver);
>>       struct mmc_card *card = mmc_dev_to_card(dev);
>>       struct mmc_host *host = card->host;
>>       int ret;
>>
>>       drv->shutdown(card);
>
> Since drv == NULL.
>
> Is this expected (and hence there's a missing guard on that function
> call), or is the root-cause some other issue?

Hi Stephen,

It is expected that drv is NULL, and obviously needs to be a check for
it before calling it, my bad!

A fixup patch is on it's way asap.

Kind regards
Ulf Hansson
