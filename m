From: Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>
Subject: Re: xHCI problem? [was Re: Erratic USB device behavior and device
 loss]
Date: Sat, 17 Sep 2016 17:12:05 +0530
Message-ID: <1474112525.11383.3.camel@researchut.com>
References: <Pine.LNX.4.44L0.1609161729340.1657-100000@iolanthe.rowland.org>
Reply-To: rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1609161729340.1657-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hello Alan,


On Fri, 2016-09-16 at 17:40 -0400, Alan Stern wrote:
> We're still getting runtime suspends, but now at 2-second intervals.   
> This is partly because the driver isn't calling
> pm_runtime_mark_last_busy(), but there may be more to it.  The 2-second 
> period is the default autosuspend timeout for USB devices.  However, I 
> don't see the activity that rtsx_usb_get_card_status() should produce 
> when rtsx_usb_suspend() runs; I don't know why not.
> 
> We're also getting occasional I/O attempts while the device is
> suspended.  They must be on some other pathway, not the one fixed by
> the patch above.  Let's see if we can find out just where they come
> from.
> 
> Ritesh, please try applying this patch on top of the previous one.  It 
> will produce output in the kernel log whenever these bad I/O attempts 
> occur.  Also, enable dynamic debugging for the rtsx_usb driver:
> 

Please find links to the usbmon trace and the kernel trace.

https://people.debian.org/~rrs/tmp/4.8.0-rc6ulf1alan1+.kern.log
https://people.debian.org/~rrs/tmp/usb-4.8.0-rc6ulf1alan1+.log.gz

Thanks.

>         echo 'module rtsx_usb =p' >/sys/kernel/debug/dynamic_debug/control
> 
> before starting the test.  (You may need to mount a debugfs filesystem 
> on /sys/kernel/debug first.)
> 
> Alan Stern
> 
> 
> 
> Index: usb-4.x/drivers/usb/core/hcd.c
> ===================================================================
> --- usb-4.x.orig/drivers/usb/core/hcd.c
> +++ usb-4.x/drivers/usb/core/hcd.c
> @@ -1647,6 +1647,8 @@ int usb_hcd_submit_urb (struct urb *urb,
>                 status = map_urb_for_dma(hcd, urb, mem_flags);
>                 if (likely(status == 0)) {
>                         status = hcd->driver->urb_enqueue(hcd, urb,
> mem_flags);
> +                       if (status == -EHOSTUNREACH)
> +                               dump_stack();
>                         if (unlikely(status))
>                                 unmap_urb_for_dma(hcd, urb);
>                 }
> 
- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX3SwNAAoJEKY6WKPy4XVpMaYQAK3p/meduq2SLRKjcLuher/+
U6W0+6t1MJmNLZgArqEYLprGQs8dboDUVuYdOkpDyjsL3oRVc2RFRhKP4n5uyeqf
UOyyJC/Dn8JpW5abQPdQOi8/zeY019P1MPKd/lAvjs+MXOdRvOluwne3KGeVJzrc
nWNt9YMZCvxscbXjJVqNWFh8utg6BVVoJ72sqkHYL6N+cWKwKb4QphgNXbhoPQq3
K7KwsBywQHty/Wf4TXB6n8z/6zR6uNHQjaveboUvidkMhWXYFSVag6ba6ZOsAyoL
nPWvowTTKO3snKh2AzHhJEzgky2EXMoxG5+GzA3nBA9suAapxuS7tTSt5YAShupv
at1FASeb8kyZ7vt3Srq7WQN7OIlER9zvVvapENJHwqATnHAQ+35h+7o1CrZLjDyF
UB5qKWOOQlFmiEfjjs15bLumBQqA4vX7JvYqJxNX7AtOPUXZHvs85eX7S4s18TZ7
OYO5JkS0xcLD6HMvuxzwO+UDS5DYknwma8gAPvHg1mX8QQMOPNkbnd7Igt9kjhMR
ZioeP0xLyyUGwjGErQpzgQwHlk5bMQhQ4iiOxi4nz4aCWLCs2YwzojfwtfDxSYnV
rCSjWEAanG3eRP7iPBtbdrbFmWsjSsavopXXlLPNYDjBjnpm2/IcyIlC/dTKKYJz
0rkc0hreSRuSDMPxbkfV
=d/iL
-----END PGP SIGNATURE-----

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
