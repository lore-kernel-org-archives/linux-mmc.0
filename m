From: Johan Rudholm <jrudholm@gmail.com>
Subject: SD-card endurance, wear and crappiness
Date: Wed, 3 Sep 2014 16:24:37 +0200
Message-ID: <CA+20K0DpX_zts4DgLstU4UUM1WZQWxPQWXBOjwreD6RZeUwfsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:35521 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932320AbaICOYi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Sep 2014 10:24:38 -0400
Received: by mail-qc0-f172.google.com with SMTP id o8so8862705qcw.3
        for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2014 07:24:37 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi all,

as you know, NAND flash can be programmed a limited number of times
before it reaches end of life, the number of times varies with the
NAND technology used, among other things.

As far as I can tell from the simplified SD-spec, there is no way of
asking the card about how many program/erase cycles it can handle, or
how many p/e cycles are left before reaching EOL. Right?

So, if one should want to give the user some kind of early warning
that it's time to change SD-cards, is there a way? Also, when a card
has reached EOL, is there a way of telling this condition apart from
all other error conditions that may arise? As you know, depending on
the quality of the card and controller, read timeouts, write timeouts,
lockups etc may occur but can usually be fixed with a power cycle.

I'm thinking of collecting simple statistics from for instance
card/block.c and exposing it via an ioctl or sysfs. The statistics can
be gathered and processed by some user space process which can
determine if the user needs to be alerted. The statistics can be, for
instance:

* Writes/reads that timeout, but succeed after a retry
* Writes/reads that timeout and never succeeds
* Different kinds of errors in the card status
* Anything else?

Perhaps it's not possible to detect worn out cards this way, but at
least it could point out and warn about crappy cards?

Any thoughts about this?

Kind regards, Johan
