From: Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>
Subject: Re: xHCI problem? [was Re: Erratic USB device behavior and device
 loss]
Date: Tue, 20 Sep 2016 18:06:17 +0530
Message-ID: <1474374977.12288.2.camel@researchut.com>
References: <Pine.LNX.4.44L0.1609191340320.1458-100000@iolanthe.rowland.org>
Reply-To: rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1609191340320.1458-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alex Dubov <oakad-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Mon, 2016-09-19 at 13:48 -0400, Alan Stern wrote:
> 
> This ought to help.  Ritesh, please apply this patch on top of the 
> two earlier ones and let's see what happens.
> 
> Alan Stern
> 
> 

Please find the logs at the following links. On this boot, I did not see any
kernel stack being printed.

https://people.debian.org/~rrs/tmp/4.8.0-rc7ulf1alan2+.kern.log
https://people.debian.org/~rrs/tmp/usb-4.8.0-rc7ulf1alan2+.log


> 
> Index: usb-4.x/drivers/memstick/host/rtsx_usb_ms.c
> ===================================================================
> --- usb-4.x.orig/drivers/memstick/host/rtsx_usb_ms.c
> +++ usb-4.x/drivers/memstick/host/rtsx_usb_ms.c
> @@ -681,6 +681,7 @@ static int rtsx_usb_detect_ms_card(void
>         int err;
>  
>         for (;;) {
> +               pm_runtime_get_sync(ms_dev(host));
>                 mutex_lock(&ucr->dev_mutex);
>  
>                 /* Check pending MS card changes */
> @@ -703,6 +704,7 @@ static int rtsx_usb_detect_ms_card(void
>                 }
>  
>  poll_again:
> +               pm_runtime_put(ms_dev(host));
>                 if (host->eject)
>                         break;
>  
- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX4S1BAAoJEKY6WKPy4XVprAUP/jPnuxUAZ+6qKiCVx6qB69d+
wHQDkFOxmlTwTh5GyMa+oxEqvi0shvOKZ/ef7Oz0NA9DSiLonFw4aqSzF7jBRbee
UTKIgnNxHmJC6pdMPXWo5HVLBn6qYtX4pJFX6g1MwmjEDa9pjYWK9p7QzHkrx1GB
Z3X7TcWYk3DJS04GbFO9pMDl0P1phLR2VtnfzQwqtgF/g2fy7USpft1bYIQLQzxb
oOSAEDnTCtpurdAfLWq8OVQbL3rrf+HD3InVtdCZa+lwNSNwNfUZWnKKkS1S1tq+
hgKxvGOTEGunhm6Px6iQUCE9yxsvfmDK2GBxc/a3Tqpcy5ndZv/5laKFhXTt27pa
OuGksYgHCf2vWGHFuYHJH6cQKxgdsnnE7yGwbC8zYnrCT9O3hcLPxbVbzJorWFU0
YMNKt7RYZXrNQss9J4ufkTSLvzbUqsiYJwWH27LbQ5zHC7b9/ebgnMW6JIb1x+2p
iuz6MERvyxVxorG3R260GWSz/5SM/VVnTqzlRUnMHcVAyUHNGPGoqLu5LkrmI2VT
Zwcikip9G3fE79786eKF50X7dp2kU2p+W2bBmcJEWpWV9Vz5PiQdibsiu3CQilKc
QGxrKLp0OSsUvtwb4ceD/RWu7F99F7VCu3f/ohYYS2iciux5sFky+27GfY0fEJ2u
ikPpuK6xNWWSDgaNVVHD
=Nq4a
-----END PGP SIGNATURE-----

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
