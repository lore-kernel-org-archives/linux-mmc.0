From: Ritesh Raj Sarraf <rrs@researchut.com>
Subject: Re: xHCI problem? [was Re: Erratic USB device behavior and device
 loss]
Date: Sun, 04 Sep 2016 23:31:14 +0530
Message-ID: <1473012074.5339.6.camel@researchut.com>
References: <1472132041.13456.11.camel@researchut.com>
         <Pine.LNX.4.44L0.1608251254220.1395-100000@iolanthe.rowland.org>
         <CAPDyKFq2SYtwWCNhSzQcxj8XdYmAhTqn6mxRKMJ7eKZAk=itWg@mail.gmail.com>
         <1472988737.7071.19.camel@researchut.com>
Reply-To: rrs@researchut.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33117 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754299AbcIDSBT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Sep 2016 14:01:19 -0400
Received: by mail-pa0-f45.google.com with SMTP id cm16so7637950pac.0
        for <linux-mmc@vger.kernel.org>; Sun, 04 Sep 2016 11:01:19 -0700 (PDT)
In-Reply-To: <1472988737.7071.19.camel@researchut.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>
Cc: USB list <linux-usb@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Sun, 2016-09-04 at 17:02 +0530, Ritesh Raj Sarraf wrote:
> > Sorry for the delay! We have had some regressions for 4.8 rc1 in the
> > mmc block layer. Those problem should be resolved by now.
> > 
> > By reading from the runtime PM issues you have, the problems could
> > very well be related. Although I don't believe the issues was present
> > in a 4.7 kernel.
> > 
> 
> This issue has been around with previous kernels too.
> 
> > Perhaps you can run a test on a 4.8 rc4 kernel, just to double check.
> > The 4.8 rc4, contains the following fixes in the mmc block layer.
> > 
> > commit 7afafc8a44bf ("block: Fix secure erase")
> > commit 869c554808cc ("mmc: fix use-after-free of struct request")
> 
> I'll share my 4.8-rc4 results soon.

As I hoped, I was able to reproduce this with 4.8-rc4 too.

[  857.999547] systemd[1]: apt-daily.timer: Adding 10h 21min 53.234725s random
time.
[13071.615285] usb 2-4: USB disconnect, device number 2
[13072.794802] usb 2-4: new high-speed USB device number 7 using xhci_hcd
[13072.925092] usb 2-4: New USB device found, idVendor=0bda, idProduct=0129
[13072.925094] usb 2-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[13072.925095] usb 2-4: Product: USB2.0-CRW
[13072.925096] usb 2-4: Manufacturer: Generic
[13072.925097] usb 2-4: SerialNumber: 20100201396000000
[13093.499011] usb 2-4: reset high-speed USB device number 7 using xhci_hcd
[13093.612239] usb 2-4: Device not responding to setup address.
[13093.818896] usb 2-4: Device not responding to setup address.
[13094.025491] usb 2-4: device not accepting address 7, error -71
[13094.138844] usb 2-4: reset high-speed USB device number 7 using xhci_hcd
[13094.252178] usb 2-4: device descriptor read/64, error -71
[13094.489037] usb 2-4: device descriptor read/all, error -71
[13094.602374] usb 2-4: reset high-speed USB device number 7 using xhci_hcd
[13094.602453] usb 2-4: Device not responding to setup address.
[13094.808929] usb 2-4: Device not responding to setup address.
[13095.015523] usb 2-4: device not accepting address 7, error -71
[13095.128879] usb 2-4: reset high-speed USB device number 7 using xhci_hcd
[13095.145799] usb 2-4: device descriptor read/all, error 8
[13095.145842] usb 2-4: USB disconnect, device number 7
[13095.492216] usb 2-4: new high-speed USB device number 8 using xhci_hcd
[13095.605642] usb 2-4: Device not responding to setup address.
[13095.812294] usb 2-4: Device not responding to setup address.


- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJXzGFqAAoJEKY6WKPy4XVpZzcP/jCzROd3+k0oF+cgK4WqKKEN
Wb/LOHezZlyNXnZ4/UxT0ox9Agc9AMQEvx4+77Itm5khQ+H3ZMEQNQg0jSENZ6aT
KjPSC3fUZ93PBGyCzec+CTj4UY49WJ1hZ4dvv7WW7WEuR8gxZxV+Z0VcG7kD8h0E
aOwJ5PVbyNSY7ZCH8NNRPnx5v74C/b+1OlFbRV1SNTUBU06ekeImy5IuvGwF45Gq
cLbKMIjJmUsg/jSol/pqUg1Sewj+z1part7sF5ZeAYM/ntwb4JAWwYvcWNI7VMxW
skT7HqyQ/qKk++UShxGsHYqV8Ec5Rx5tAUTgEH68Y7y4i9YDSTOnqXDgjTANz5RL
yaZS856dGoIs96/mHCjzMV+1NYpTo2aMPO1/JDs6nvKfBtyIVDbTsB8qbdP5vqnb
x1GmzB6j8wDHBTAtJIifkB8XGQfcxbDto2LG6/OnPPN3/aiTMCKB6ZND2HISNGfr
IeN39Ay35zn9epq6D3usdd1TAlF5xqo1djHyFDYfXE0gZsJZiCCs9GC2NaP46ZYp
G7a4O1UpbPKhRq7peyh2f/GzHg+3k1J+PD+I1Us/w2Dj1ObCr7M4ToF70AQ2xISE
DFBuP7dWue6waQup7S3zNLqyP5K101NkKQbSrXJHEhxIaqNFbEZg1D8MuC4I0gHA
i4uloGV6oSg973dwyTiU
=q0wG
-----END PGP SIGNATURE-----

