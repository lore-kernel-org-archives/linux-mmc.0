From: Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [linux-pm] subtle pm_runtime_put_sync race and sdio functions
Date: Thu, 27 Jan 2011 19:20:10 +0100
Message-ID: <AANLkTikH0aHQNzShAYQfPLPg4C_0HS_pWEqbJJ4aHZgm@mail.gmail.com>
References: <Pine.LNX.4.44L0.1012212032590.11252-100000@netrider.rowland.org>
	<201012221329.40251.rjw@sisk.pl>
	<87k4hrtfcb.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87k4hrtfcb.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Kevin,

> Therefore, what is ideally needed is the ability for A's suspend to
> simply call pm_runtime_suspend() so the subsystem can do the work.
> However, since runtime transitions are locked out by this time, that
> doesn't work. =A0IOW, what is needed is a way for a system suspend to=
 say
> "please finish the runtime suspend that was already requested."
>
> What I've done to work around this in driver A is to manually check
> pm_runtime_suspended() and directly call the subsystem's runtime
> suspend/resume (patch below[1]. =A0NOTE, I've used the _noirq methods=
 to
> ensure device A is available when device B needs it.)

suppose this driver runs on a platform that has runtime PM disabled.
How is it going to work then?

Thanks,
   Vitaly
--
To unsubscribe from this list: send the line "unsubscribe linux-wireles=
s" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
