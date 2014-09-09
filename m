From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: SD-card endurance, wear and crappiness
Date: Tue, 9 Sep 2014 10:54:51 +0200
Message-ID: <CA+20K0DfrGWOSQDgDNPzBYw8W=yq3s9EohEwiTxtUMnPp_sJEA@mail.gmail.com>
References: <CA+20K0DpX_zts4DgLstU4UUM1WZQWxPQWXBOjwreD6RZeUwfsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:38686 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbaIIIyw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Sep 2014 04:54:52 -0400
Received: by mail-qg0-f47.google.com with SMTP id i50so2573679qgf.34
        for <linux-mmc@vger.kernel.org>; Tue, 09 Sep 2014 01:54:51 -0700 (PDT)
In-Reply-To: <CA+20K0DpX_zts4DgLstU4UUM1WZQWxPQWXBOjwreD6RZeUwfsQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, arnd@arndb.de
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Ulf, Arnd,

do you guys have any thoughts on this?

Kind regards, Johan

2014-09-03 16:24 GMT+02:00 Johan Rudholm <jrudholm@gmail.com>:
> Hi all,
>
> as you know, NAND flash can be programmed a limited number of times
> before it reaches end of life, the number of times varies with the
> NAND technology used, among other things.
>
> As far as I can tell from the simplified SD-spec, there is no way of
> asking the card about how many program/erase cycles it can handle, or
> how many p/e cycles are left before reaching EOL. Right?
>
> So, if one should want to give the user some kind of early warning
> that it's time to change SD-cards, is there a way? Also, when a card
> has reached EOL, is there a way of telling this condition apart from
> all other error conditions that may arise? As you know, depending on
> the quality of the card and controller, read timeouts, write timeouts,
> lockups etc may occur but can usually be fixed with a power cycle.
>
> I'm thinking of collecting simple statistics from for instance
> card/block.c and exposing it via an ioctl or sysfs. The statistics can
> be gathered and processed by some user space process which can
> determine if the user needs to be alerted. The statistics can be, for
> instance:
>
> * Writes/reads that timeout, but succeed after a retry
> * Writes/reads that timeout and never succeeds
> * Different kinds of errors in the card status
> * Anything else?
>
> Perhaps it's not possible to detect worn out cards this way, but at
> least it could point out and warn about crappy cards?
>
> Any thoughts about this?
>
> Kind regards, Johan
