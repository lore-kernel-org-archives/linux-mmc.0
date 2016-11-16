From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] RFC: mmc: block: replace semaphore with freezing
Date: Wed, 16 Nov 2016 16:20:47 +0100
Message-ID: <CACRpkdY+jdU4ETuMJsY-efSkjwE0fWWRZoyCyrYAs_GxUo-DhQ@mail.gmail.com>
References: <1479293464-4576-1-git-send-email-linus.walleij@linaro.org> <CAJZ5v0gCDQXebsQoCYJY5FyE6oJUw4s6sQrNbKLuxpLvOe2RoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:36029 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932677AbcKPPUs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2016 10:20:48 -0500
Received: by mail-qt0-f171.google.com with SMTP id w33so105139326qtc.3
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2016 07:20:48 -0800 (PST)
In-Reply-To: <CAJZ5v0gCDQXebsQoCYJY5FyE6oJUw4s6sQrNbKLuxpLvOe2RoA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Jiri Kosina <jikos@kernel.org>

On Wed, Nov 16, 2016 at 1:46 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:

> Well, we had a session at the KS regarding usage of the freezer on
> kernel threads and the conclusion was to get rid of that (as opposed
> to freezing user space, which is necessary IMO).  So this change would
> go in the opposite direction. :-)

Aha so I should not make this thread look like everyone else, instead
everyone else should look like this thread, haha :D

Ah well, I'll just drop it.

Linus
