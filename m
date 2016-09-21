From: Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>
Subject: Re: xHCI problem? [was Re: Erratic USB device behavior and device
 loss]
Date: Wed, 21 Sep 2016 17:12:04 +0530
Message-ID: <1474458124.8192.6.camel@researchut.com>
References: <Pine.LNX.4.44L0.1609201012290.1459-100000@iolanthe.rowland.org>
         <1474456212.8192.2.camel@researchut.com>
         <CAPDyKFrWHaPhubTsPjd7GpZcoQnGM9u1YEiy=iGpb1Qa2rJqPA@mail.gmail.com>
Reply-To: rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFrWHaPhubTsPjd7GpZcoQnGM9u1YEiy=iGpb1Qa2rJqPA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Alex Dubov <oakad-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hello Ulf,

On Wed, 2016-09-21 at 13:17 +0200, Ulf Hansson wrote:
> 
> I am pretty sure the memstick driver causes additional access to the
> usb device without first calling pm_runtime_get_sync(). To eliminate
> those cases from causing the issues, could you try disable the
> memstick driver all-together?

I'm assuming you are referring to the rtsx_usb_ms driver ?

What is the oddest thing right now, is that none of the rtsx modules are
reported loaded.

rrs@learner:~$ lsmod | grep -i rts
2016-09-21 / 17:07:08 ♒♒♒  ☹  => 1  

where as the module was built for the kernel, and does load when asked manually.

rrs@learner:~$ less /boot/config-4.8.0-rc7alxb+ 
2016-09-21 / 17:07:54 ♒♒♒  ☺  
rrs@learner:~$ find /lib/modules/4.8.0-rc7alxb+/ | grep rtsx
/lib/modules/4.8.0-rc7alxb+/kernel/drivers/mmc/host/rtsx_usb_sdmmc.ko
/lib/modules/4.8.0-rc7alxb+/kernel/drivers/mmc/host/rtsx_pci_sdmmc.ko
/lib/modules/4.8.0-rc7alxb+/kernel/drivers/mfd/rtsx_usb.ko
/lib/modules/4.8.0-rc7alxb+/kernel/drivers/mfd/rtsx_pci.ko
/lib/modules/4.8.0-rc7alxb+/kernel/drivers/memstick/host/rtsx_pci_ms.ko
/lib/modules/4.8.0-rc7alxb+/kernel/drivers/memstick/host/rtsx_usb_ms.ko
2016-09-21 / 17:08:09 ♒♒♒  ☺  

rrs@learner:~$ sudo modprobe rtsx-usb-sdmmc
2016-09-21 / 17:08:46 ♒♒♒  ☺  

rrs@learner:~$ dmesg | tail -n 5
[ 6870.017311] usb 2-4: Device not responding to setup address.
[ 6870.223471] usb 2-4: device not accepting address 19, error -71
[ 6870.223536] usb usb2-port4: unable to enumerate USB device
[ 7958.474543] [drm:intel_pipe_update_end [i915]] *ERROR* Atomic update failure
on pipe A (start=166356 end=166357) time 3 us, min 1073, max 1079, scanline
start 1088, end 1080
[ 9814.785241] usbcore: registered new interface driver rtsx_usb
2016-09-21 / 17:10:07 ♒♒♒  ☺  



- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX4nIMAAoJEKY6WKPy4XVpg4gP/Rkp5Wje2vTUHwnrJZzAKd65
V1VWkTyCfpbCTw4nAyMbzDevyoXJf3P+ktrcyQonvoZr/dsd/LOmjSXcjNJaFX0z
Vj+1lGOZeN1mr6vKMbh2y188oU4RyHkeCfg7SNdo1VuhVST/m2jOecCznXuEtpiS
TI66lmre0SNRusKHRQNDtaP4hFW0KDBmtXvc8pnNOL5781qua0pF12VIP5SsqriP
3d/DcqlVR0Lqh7X7wdt5Knp9ilSvsrCgGbimBarRUYnrOrhklJH9UwKXcHWVypzt
M0XvjO7R6JrBUoM6s8EA6gKmNxwlsIrjKFUFlTT6HPLb52fjpYkbYqCRUmqyIJZB
t3uA0hNKcqLav+Fg7ugT6ePAPeVkANDnbrPE+g69KOtM/CEJHbHkLxqznb/0lpMU
+SAp/Jz1CmDLt8M3s8gS9iCUWVrWy1oyDpMQsYIrTYOG6oOEOoTYEf/g5D6PBtY0
r1tD5bU/cZJV61YKer2xRDNu1YbAYkvX3XskFD7DFsnZpCyBXKGZ7gWpWety9kJJ
iBiqvn5Rk7jvL6EhIb/TQ867QLmhQCzZumPClFM4z7b8G2E440vykw5D5sKv91+H
qu9Abcxe0R0T9pxCFRz+//DYlxGvDDlUSyNBkrv6aGS1rNeDY/e4FWbNuEz9UoGn
LNiunOtwzBndajfEFETk
=tEAz
-----END PGP SIGNATURE-----

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
