From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-pm] subtle pm_runtime_put_sync race and sdio functions
Date: Tue, 21 Dec 2010 20:42:59 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1012212032590.11252-100000@netrider.rowland.org>
References: <201012212231.57420.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201012212231.57420.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 21 Dec 2010, Rafael J. Wysocki wrote:

> It basically goes like this.  There's device A that is only resumed when it's
> needed to carry out an operation and is suspended immediately after that.
> There's another device B that needs A to do something during its suspend.
> So, when the suspend of B is started, A is woken up, does its work and is
> suspended again (using pm_runtime_suspend()).  Then B is suspended.
> 
> We currently require that ->suspend() and ->resume() callbacks be defined
> for A (presumably pointing to the same code as its runtime callbacks) so that
> things work correctly, but perhaps we can just relax this requirement a bit?
> I'm not 100% sure that's a good idea, just considering it.

I still don't know.  It would require a lot of special conditions: no
child devices, not runtime-PM-disabled, not runtime-PM-forbidden...  
Also, A's parent would have to be coded carefully; otherwise A's
runtime resume would prevent the parent from suspending.

This just doesn't fit very well with the runtime PM model, or at least, 
not in the form you described.

Consider this instead:  Since A is required to be functional before B
can be used, A must be registered before B and hence B gets suspended
before A.  Therefore during the prepare phase we can runtime-resume A
and leave it powered up; when B needs to suspend, it won't matter that
the runtime-PM calls are ineffective.  Then when A's dpm_suspend
occurs, it can safely go to a low-power state and stay there.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
