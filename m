From: Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>
Subject: Re: xHCI problem? [was Re: Erratic USB device behavior and device
 loss]
Date: Tue, 20 Sep 2016 20:47:06 +0530
Message-ID: <1474384626.21100.6.camel@researchut.com>
References: <Pine.LNX.4.44L0.1609201012290.1459-100000@iolanthe.rowland.org>
Reply-To: rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1609201012290.1459-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alex Dubov <oakad-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hello Alan,

On Tue, 2016-09-20 at 10:16 -0400, Alan Stern wrote:
> This is a lot better.  No more I/O errors.
> 
> We still have irregular suspends and resumes, but that's to be 
> expected.  More worrying are the spontaneous disconnects.  They don't 
> seem to be related to the suspend/resume activity.
> 
> You can disable suspend for this device entirely by doing:
> 
>         echo on >/sys/bus/usb/devices/2-4/power/control
> 

Yes. But that'd also mean to write that value upon every suspend/resume cycle
because the rtsx usb driver still declares support for autosuspend.
Should that be dropped ?

> I'm afraid that this won't prevent the device from disconnecting
> itself, though.  This appears to be some sort of hardware bug that
> can't be fixed in software.

And that'd mean that upon every reset, the driver will again enable autosuspend
for that driver.


It is an upsetting state for this device but thank you, to all of you, for
helping debug this problem.

- -- 
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX4VLyAAoJEKY6WKPy4XVprEgQAKdYcFIF1ICNGHkF+oyDe1VY
DqyxTa0vLPbXWsG6GaV4Jdwld+gVKiWIVNKxbLpboBHj/vj0bkzoPJ0z4xI+Oc8p
bu6T5Io6nAaegdGa6XvYIAXk1fIlXEehBFVM6OyzC1EUJAjgYhIDVlG8mqZKxqVp
GGsX1e5UFdS0vCqjYqSxI5IHrqsm1M4lXuwr8ia66qyuSfpg8trizLiWrdiEa7hv
hRtI81XxITvVJ4+2ernO6Y+RO/z6WQLs1SAhXvDEH3RlYh/RoEBpolqMIO8LVWMK
jd4GSsYmMKiG1eJJq3UYM+iPDANIIi4gdO0hf/24vNcsVa8eF5kcKT+bxufRaiB/
5TzZS0RARBdq1+N6bK/wF8lDL4bWy4Sl1mts/dXJaCOlOoLeQ/u/J55K58mDJb2O
gdvEvzD/S9NNeawL2ow4sxaM8EBpeyJtBTyVIbLJVFmetauVs+ClI0uLoNMW/N+u
qMDE8yhiey4ClXa0WmVZHN4qjfNAnW4OSMtrq8+TLa1yhVj/ONNBo8QkfjuKBHwE
ELDrX3/N9JsZo6ZX0CPNVhodvck8ZVKrk8w3jAlcqQ0FlJy5MMFoqGEvqJ1EIfNv
IQ5FKrI08RIA7yw6keTy3nybzyY3MhepLJWxiEVyKRCopiHk96DmEGJmOmor7VIQ
hjgbpCikJ7sXPcn0n97u
=DBja
-----END PGP SIGNATURE-----

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
