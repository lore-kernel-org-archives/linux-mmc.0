From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: Problems after recent changes to meson-gx-mmc driver
Date: Sun, 10 Sep 2017 18:20:05 +0200
Message-ID: <b31253d8-38a3-dd25-1d74-6afde6ae8362@gmail.com>
References: <e2171288-84ef-82db-2efc-300935e6c062@gmail.com>
 <1504965959.24771.42.camel@baylibre.com>
 <763e9339-92a4-c2c4-bbe6-ee9f831148ec@gmail.com>
 <6a4baa6c-e5f0-fe51-f958-adde9e39b4c9@gmail.com>
 <1505056105.24771.53.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:44150 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750857AbdIJQUM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 10 Sep 2017 12:20:12 -0400
Received: by mail-wm0-f54.google.com with SMTP id 189so2488796wmh.1
        for <linux-mmc@vger.kernel.org>; Sun, 10 Sep 2017 09:20:12 -0700 (PDT)
In-Reply-To: <1505056105.24771.53.camel@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Am 10.09.2017 um 17:08 schrieb Jerome Brunet:
> On Sat, 2017-09-09 at 22:20 +0200, Heiner Kallweit wrote:
>> I checked further and setting the tx clock phase back to 0 fixes the issue for
>> me.
>> ("mmc: meson-gx: change default tx phase" changes it from 0 to 270.)
>> But as you write 0 seems to break certain other systems.
> 
> That was my second guess ...
> 
> As I mentioned in the commit message, 270 is working fine for the setups I have
> tested but I always wondered if that would be the case for every possible
> setups/boards/modes.
> 
> Would you mind testing 90 and 180 as well with your setup ? I'll make another
> pass on the different setups I have access to. Please stick to hs200 and drop
> hs400 for this test. I'm still unsure if doubling the clock after doing the
> tuning may affect the phase tuning ... lets keep that out of the way for now.
> 
I tested the other tx clock settings with HS200/200MHz.

0: No errors
90: 6 CRC errors, otherwise system works normal.
180: Lots of CRC errors, but system still works.
270: So many errors that root file system gets corrupted and is mounted r/o.

Seems like we won't find a tx clock phase working on all systems.
So maybe the tuning needs to be extended to check all tx / rx clock
phase combinations.

IIRC I went with a fixed tx clock phase because other combinations of
tx / rx clock phase selected by an experimental tuning algorithm
worked fine when tuning but produced errors later.
