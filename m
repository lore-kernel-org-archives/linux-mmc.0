From: Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [linux-pm] subtle pm_runtime_put_sync race and sdio functions
Date: Thu, 27 Jan 2011 23:18:27 +0100
Message-ID: <AANLkTinbHx1XtxpWDr+UCUBo6xRCs=zT1AD_y2kXo0cL@mail.gmail.com>
References: <Pine.LNX.4.44L0.1101271439020.2090-100000@iolanthe.rowland.org>
	<87tyguje7j.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87tyguje7j.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jan 27, 2011 at 9:15 PM, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org> wrote:
>
>> If it is, then you can call omap_pm_runtime_suspend() directly instead
>> of calling dev->bus->pm->runtime_suspend().
>
> Personally, I prefer going through dev->bus as we try to avoid SoC
> specific calls in the driver.
>
> This same HW block might be re-used on non-OMAP SoCs (e.g. TI DaVinci)
> that would have different PM at the susbystem level.
>
> So, to summarize, as long as folks are OK with drivers directly calling
> the subsystem runtime PM callbacks, I'll go this route.

I personally think it's okay for the moment. Generally speaking, SD
bus driver might not have runtime PM support so it's better to have
this explicitly called and not compiling for other platforms rather
than have it compiling but working not the way it's expected to.

~Vitaly
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
