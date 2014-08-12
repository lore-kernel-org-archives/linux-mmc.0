From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: No UHS support for O2 Micro, Inc. OZ600FJ0/OZ900FJ0/OZ600FJS?
Date: Tue, 12 Aug 2014 22:10:14 +0200
Message-ID: <CAPDyKFpbVbJN5c8GoF1bwSkYx69M8wLnOgs5vgBqt0DrfczLsA@mail.gmail.com>
References: <CAFvQSYQtVWOqjjn_3Tr6R2VfgKb-=z2sb39A0HowJPehYYagQw@mail.gmail.com>
	<CAFvQSYS32yVA4-gLUzyfzZWbBqSBsGHEAUdA6DPwZnw6U2E0OQ@mail.gmail.com>
	<CAFvQSYSaxWSSNo0_zAHFcOkpbeaJP9UOtmBSZnYYrbE6+ON9YQ@mail.gmail.com>
	<CAFvQSYSj0rj8pGoBhuR1NURAk0Jbj0aKJgy=RDc9vVgaFxu1yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:52850 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754456AbaHLUKP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Aug 2014 16:10:15 -0400
Received: by mail-qc0-f179.google.com with SMTP id m20so3237650qcx.24
        for <linux-mmc@vger.kernel.org>; Tue, 12 Aug 2014 13:10:14 -0700 (PDT)
In-Reply-To: <CAFvQSYSj0rj8pGoBhuR1NURAk0Jbj0aKJgy=RDc9vVgaFxu1yg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Clemens Eisserer <linuxhippy@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 17 July 2014 14:15, Clemens Eisserer <linuxhippy@gmail.com> wrote:
> Hi again,
>
> Is this the wrong mailing list to ask about throughput issues with
> linux card reader drivers in general?
> If it is not, please point me to the right list.

This is the right list, I guess people have been busy. :-)

I would as as few initial steps do the following:

1) Check the kernel log once the card is inserted to see what type of
card it is detected as.
2) There are a debugfs directory corresponding to each card and host.
There you can find out what bus mode/width the card is operating in as
well as the current bus frequency.

Kind regards
Uffe
