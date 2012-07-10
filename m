From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: fix runtime suspend crash: add host
 checks in callbacks
Date: Tue, 10 Jul 2012 09:55:47 +0530
Message-ID: <CANfBPZ-ucJkgJLt4eXRvfGTCJnWTxHUuL9Cnp9GoaQq7keHGqg@mail.gmail.com>
References: <1341620786-13598-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1341620786-13598-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Chris Ball <cjb@laptop.org>, linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>, Rajendra Nayak <rnayak@ti.com>, Adrian Hunter <adrian.hunter@intel.com>, "open list:MULTIMEDIA CARD (...), linux-kernel@vger.kernel.org (open
	list)" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Sat, Jul 7, 2012 at 5:56 AM, Kevin Hilman <khilman@ti.com> wrote:
> Due to the way the driver core takes runtime PM references during
> probe, a driver's runtime PM callbacks may not be called until probe
> returns.  During probe, drvdata is set to the 'host' pointer but if
> probe fails, drvdata is set to NULL.
>
> The runtime PM callbacks currently blindly dereference this host
> pointer, but if probe fails, and the runtime PM callbacks are called
> after probe returns, a NULL pointer dereference will result.
>
Pardon my ignorance, but why would runtime suspend be called for a
device whose probe has failed ? AFAIK, MMC stack wouldn't make
the _enable()/disable() calls, which call runtime PM APIs, unless the
probe is successful.
 Is there a stacktrace for the offending caller ?

> Fix this by simply checking to be sure the host pointer is non-NULL.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Applies to v3.5-rc5.  Fix is needed for v3.5-rc.
>
Can you please let me know which commit introduced this problem
in the first place ? There were not many changes in MMC PM code
in this merge window.
