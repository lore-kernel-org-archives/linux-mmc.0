From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: [PATCH 4/4] mmc: add MMC_QUIRK_NONSTD_FUNC_IF
Date: Sun, 9 Jan 2011 17:48:24 +0100
Message-ID: <AANLkTin+1A2PbBOBv3z4=ZgwETghcrtYD7yaYgXLcJ6b@mail.gmail.com>
References: <1294175416-12358-1-git-send-email-ohad@wizery.com>
	<1294175416-12358-4-git-send-email-ohad@wizery.com>
	<AANLkTimg7DU=1bYv-k2-WwiSurHmsrjN_+zb_=irZv9n@mail.gmail.com>
	<AANLkTi=HyXUAMALQD4MMZrw=Por8bTkJ6HxSC10UrDt4@mail.gmail.com>
	<AANLkTikwaSmwy2b6if-=BhU9c5Ea_9xyOdKDC0VhpBox@mail.gmail.com>
	<AANLkTik8FNxAhGz8Dzj=h4S1hyDGUYw4HSAhzwHWfWpG@mail.gmail.com>
	<AANLkTinrz+qonuPSo-HOJ2zmjwmyn0YJkMTg+MwKXN2s@mail.gmail.com>
	<AANLkTik7yr6bXcGpNt09zoXU_P03RE=vo2HepDa2fhuW@mail.gmail.com>
	<AANLkTinmhoY+TqmF_scKnzG-Kjjof=YDf2kzfJfr1gjy@mail.gmail.com>
	<AANLkTimSEAnQkH9m7DsCM7kOGS8Ffbhx7B9h-GRCS_d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:64277 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848Ab1AIQsZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Jan 2011 11:48:25 -0500
Received: by qwa26 with SMTP id 26so19092237qwa.19
        for <linux-mmc@vger.kernel.org>; Sun, 09 Jan 2011 08:48:24 -0800 (PST)
In-Reply-To: <AANLkTimSEAnQkH9m7DsCM7kOGS8Ffbhx7B9h-GRCS_d2@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, "DE CESCO, Jonathan" <jonathanc@ti.com>

On Fri, Jan 7, 2011 at 12:16 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Hi Pierre,
>
> On Wed, Jan 5, 2011 at 2:28 PM, Pierre Tardy <tardyp@gmail.com> wrote:
>> Well... TI is selling quirky hw, would make sense that you handle this. :-)
>
> Heh I'd happily take over - just say the word :)
Well anyway, I needed this for my power/clock gating stuff also.

> Do we really need to hook up code with quirky cards ? why not just
> directly indicate the exact MMC_QUIRK_* instead (just like USB is
> doing) ? that may simplify the whole thing.
Semi agree, see the new patches for example of needed hooks, and how I
made it generic.
The problem I was trying to resolve is add anti clock gating quirk for
every sdio but wl1271

> Fill it up here,
hope example patches answer your issues.

Pierre
