From: Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>
Subject: Re: xHCI problem? [was Re: Erratic USB device behavior and device
 loss]
Date: Sun, 04 Sep 2016 17:02:17 +0530
Message-ID: <1472988737.7071.19.camel@researchut.com>
References: <1472132041.13456.11.camel@researchut.com>
         <Pine.LNX.4.44L0.1608251254220.1395-100000@iolanthe.rowland.org>
         <CAPDyKFq2SYtwWCNhSzQcxj8XdYmAhTqn6mxRKMJ7eKZAk=itWg@mail.gmail.com>
Reply-To: rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFq2SYtwWCNhSzQcxj8XdYmAhTqn6mxRKMJ7eKZAk=itWg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hello Alan, Ulf.

Sorry for the delayed reply. Last week was a sickly week for me.

On Tue, 2016-08-30 at 10:14 +0200, Ulf Hansson wrote:
> On 25 August 2016 at 19:17, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
> > Ulf:
> >
> > Ritesh has collected logs showing that his Realtek RTS5129 USB card
> > reader (drivers/mfd/rtsx_usb.c, drivers/mmc/host/rtsx_usb_sdmmc.c) goes
> > into runtime autosuspend every 3 seconds and then immediately resumes.
> > This sounds like something is failing to call
> > pm_runtime_mark_last_busy().  He's using a 4.7 kernel.
> >
> > In addition, the device gets disconnected from the USB bus from time to
> > time.  This appears to be a completely separate issue.
> >
> > For now, I'd like to fix the runtime PM problem.  But I don't know
> > anything about the mmc core, so perhaps you can help.
> >
> 

@Alan,

I noticed that, even with the 1-line patch that disabled autosuspend attribute
for this driver, I still occasionally hit the driver error messages.

[19608.533058] usb 1-4: reset high-speed USB device number 13 using xhci_hcd
[19608.692846] usb 1-4: Device not responding to setup address.
[19608.898254] usb 1-4: Device not responding to setup address.
[19609.099553] usb 1-4: device not accepting address 13, error -71
[19609.259474] usb 1-4: reset high-speed USB device number 13 using xhci_hcd
[19609.420221] usb 1-4: device descriptor read/64, error -71
[19609.699656] usb 1-4: device descriptor read/all, error -71
[19609.859678] usb 1-4: reset high-speed USB device number 13 using xhci_hcd
[19609.859768] usb 1-4: Device not responding to setup address.
[19610.062891] usb 1-4: Device not responding to setup address.
[19610.266148] usb 1-4: device not accepting address 13, error -71
[19610.426157] usb 1-4: reset high-speed USB device number 13 using xhci_hcd
[19610.426252] usb 1-4: Device not responding to setup address.
[19610.629533] usb 1-4: Device not responding to setup address.
[19610.832791] usb 1-4: device not accepting address 13, error -71
[19610.833374] usb 1-4: USB disconnect, device number 13
[19611.506151] usb 1-4: new high-speed USB device number 14 using xhci_hcd
[19611.666770] usb 1-4: device descriptor read/64, error -71
[19611.929563] usb 1-4: Device not responding to setup address.
[19612.136298] usb 1-4: Device not responding to setup address.
[19612.342800] usb 1-4: device not accepting address 14, error -71
[19612.502791] usb 1-4: new high-speed USB device number 15 using xhci_hcd
[19612.662829] usb 1-4: device descriptor read/64, error -71
[19612.929561] usb 1-4: Device not responding to setup address.
[19613.132883] usb 1-4: Device not responding to setup address.
[19613.336162] usb 1-4: device not accepting address 15, error -71
[19613.496165] usb 1-4: new high-speed USB device number 16 using xhci_hcd
[19613.509674] usb 1-4: device descriptor read/8, error -71
[19613.626406] usb 1-4: device descriptor read/8, error -71
[19613.889528] usb 1-4: new high-speed USB device number 17 using xhci_hcd
[19613.889639] usb 1-4: Device not responding to setup address.
[19614.092899] usb 1-4: Device not responding to setup address.
[19614.296169] usb 1-4: device not accepting address 17, error -71
[19614.296216] usb usb1-port4: unable to enumerate USB device
[20357.431911] SGI XFS with ACLs, security attributes, realtime, no debug
enabled


Earlier, only the device resets error was seen. But I was able to see this once
again.

> Sorry for the delay! We have had some regressions for 4.8 rc1 in the
> mmc block layer. Those problem should be resolved by now.
> 
> By reading from the runtime PM issues you have, the problems could
> very well be related. Although I don't believe the issues was present
> in a 4.7 kernel.
> 

This issue has been around with previous kernels too.

> Perhaps you can run a test on a 4.8 rc4 kernel, just to double check.
> The 4.8 rc4, contains the following fixes in the mmc block layer.
> 
> commit 7afafc8a44bf ("block: Fix secure erase")
> commit 869c554808cc ("mmc: fix use-after-free of struct request")

I'll share my 4.8-rc4 results soon.

Thanks,
Ritesh

- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJXzAZBAAoJEKY6WKPy4XVpKk4P/0lwMRmZYVhUf19s6yqviMzB
5YPMKCahz5KyPEBP5bdfDW6TCi83UI34yn/FCUj0l4kRRb41zL7JUZ/PYjyFfq3c
2d6viAx4+Qjqn26sZ+PDciEaBKHAQWEu1SYgGfxk+5fmXUc/aLQpY9h+DAHB30xU
H80FQz5Ct6rFwp5TkHmFALSk0Ue1bF/ZJy9AvsOkGZCN+1lYekEh8Ry26RvKsIEc
2i5wJ5CDJXQT1AiV5Jwy6WfiEy8a8FKlxRuo767e9Ftp/sZhUaulhYXsBaJOm6ZT
ckBbib9HEtfKM/nL/Cp3kjBqR7PHWdxeFER9x+r/KWCQYalD1MlbtP48oekFGr7U
h/XqLNuHdaKdfLFctHx4HZ/vQCBQ8XW0dYfpXSnoNOzm7I8qxp5icUZGad5BTxSE
QDbg8A6vW1gZ8dxRVG39+JHVHUxx2AXvUM720aUpRdik8c6+kz/pcIwXPLvboPsY
WGKDiI1Q8EE7/8910+g/qghOI97o0dgasdVY9FZGhYL427BzanAPcXm5aGXeyFJk
5mA+TNASC8gviYC5z7hc0lOouoprNyt1ssp6hZFPmkEsOyKpy6rQrf2VJcJuoYdH
PHsfJFUkM7/t2PygEhRBV266DVCzOR1Ut968T++ErnHmEVkHse94cRNvbXZVYkHJ
XsagbkAA/uxsIdubWV85
=GIR5
-----END PGP SIGNATURE-----

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
