From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] subtle pm_runtime_put_sync race and sdio functions
Date: Sun, 26 Dec 2010 12:45:29 +0100
Message-ID: <201012261245.29680.rjw@sisk.pl>
References: <AANLkTimj0E3Rz_8WQrU4wGg3ONyXzkUT9+U3Xqz7Cq0X@mail.gmail.com> <Pine.LNX.4.44L0.1012252041260.10725-100000@netrider.rowland.org> <AANLkTinyKfwcZLD5D4rdF6OpQqr79F==GRjAMBjjbupW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52371 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751784Ab0LZLqW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 26 Dec 2010 06:46:22 -0500
In-Reply-To: <AANLkTinyKfwcZLD5D4rdF6OpQqr79F==GRjAMBjjbupW@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>, Kevin Hilman <khilman@deeprootsystems.com>

On Sunday, December 26, 2010, Ohad Ben-Cohen wrote:
> On Sun, Dec 26, 2010 at 4:48 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > Is there a separate handler responsible for powering the device back
> > on?  What are the names of these handlers?
> 
> wl1271_sdio_power_on() and wl1271_sdio_power_off().
> 
> If you're taking a look, please do so using the latest code as seen on mmc-next:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git mmc-next
> 
> > That's not a race
> 
> It is.
> 
> If system suspend will continue uninterruptedly, and the driver will
> be suspended (by the SDIO subsystem), then the device will be powered
> down, and everything will work.
> 
> But if something will interrupt the suspend transition _before_ our
> driver is suspended (e.g. some other suspend() handler will fail),
> then we have a problem, because the device will not be reset as the
> driver needs it to be.

Now, that's interesting.  (It still is not a race, though.)
Why does the driver need the device to be reset even though it hasn't
been suspeneded yet?

Rafael
