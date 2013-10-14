From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH V2] PM / Runtime: Respect autosuspend when idle triggers suspend
Date: Mon, 14 Oct 2013 16:43:56 -0700
Message-ID: <87li1vh0zn.fsf@linaro.org>
References: <1381735264-3077-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1381735264-3077-1-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Mon, 14 Oct 2013 09:21:04 +0200")
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Mika Westerberg <mika.westerberg@linux.intel.com>, Rob Landley <rob@landley.net>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> For devices which don't have a .runtime_idle callback or if it returns
> 0, rpm_idle will end up in triggering a call to rpm_suspend, thus
> trying to carry out a runtime_suspend directly from runtime_idle.
>
> In the above situation we want to respect devices which has enabled
> autosuspend, we therfore append the flag sent to rpm_suspend with
> RPM_AUTO.
>
> Do note that driver's still needs to update the device last busy mark,
> to control the delay for this circumstance.
>
> Updated runtime PM documentation accordingly.
>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Rob Landley <rob@landley.net>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Kevin Hilman <khilman@linaro.org>
