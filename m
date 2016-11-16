From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] RFC: mmc: block: replace semaphore with freezing
Date: Wed, 16 Nov 2016 13:46:10 +0100
Message-ID: <CAJZ5v0gCDQXebsQoCYJY5FyE6oJUw4s6sQrNbKLuxpLvOe2RoA@mail.gmail.com>
References: <1479293464-4576-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1479293464-4576-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Jiri Kosina <jikos@kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Nov 16, 2016 at 11:51 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> The MMC/SD block core request processing thread is taking a
> semaphore in the request processing section and the same
> semaphore is taken around suspend/resume operations.
>
> The purpose of the semaphore is to block any request from being
> issued to the MMC/SD host controllers when the system is
> suspended. A semaphore is used in place of a mutex since the
> calls are coming from different threads.
>
> This construction predates the kernel thread freezer mechanism:
> we can easily replace the semaphore by instead activating the
> freezer with set_freezable() and call try_to_freeze() instead
> of the up(); schedule(); down(); construction that is devised
> to let the suspend/resume calls get in and grab the semaphore.
>
> Tested with a few suspend/resume to memory cycles on the Ux500
> when doing intense dd operations in the background: the
> thread thaws and resumes operation after resume.

Well, we had a session at the KS regarding usage of the freezer on
kernel threads and the conclusion was to get rid of that (as opposed
to freezing user space, which is necessary IMO).  So this change would
go in the opposite direction. :-)

Thanks,
Rafael
