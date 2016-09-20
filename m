From: Ritesh Raj Sarraf <rrs@researchut.com>
Subject: Re: xHCI problem? [was Re: Erratic USB device behavior and device
 loss]
Date: Tue, 20 Sep 2016 21:21:27 +0530
Message-ID: <1474386687.21100.10.camel@researchut.com>
References: <Pine.LNX.4.44L0.1609201141591.1379-100000@iolanthe.rowland.org>
Reply-To: rrs@researchut.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36035 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932484AbcITPvd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Sep 2016 11:51:33 -0400
Received: by mail-pf0-f169.google.com with SMTP id q2so8667157pfj.3
        for <linux-mmc@vger.kernel.org>; Tue, 20 Sep 2016 08:51:33 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1609201141591.1379-100000@iolanthe.rowland.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Alex Dubov <oakad@yahoo.com>, USB list <linux-usb@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Tue, 2016-09-20 at 11:43 -0400, Alan Stern wrote:
> > Yes. But that'd also mean to write that value upon every suspend/resume
> cycle
> > because the rtsx usb driver still declares support for autosuspend.
> > Should that be dropped ?
> 
> No, the value doesn't change across a suspend/resume cycle.
> 

I just verified, and yes, you are right. The value doesn't change.

> > > I'm afraid that this won't prevent the device from disconnecting
> > > itself, though.  This appears to be some sort of hardware bug that
> > > can't be fixed in software.
> > 
> > And that'd mean that upon every reset, the driver will again enable
> autosuspend
> > for that driver.
> 
> Yes, that's true.  I'm curious to see if preventing autosuspends will 
> get rid of the resets.  My guess is that it won't.

No. We tried it in the beginning. And the resets were still seen.

Thanks.

- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX4Vr/AAoJEKY6WKPy4XVpqSoP/jimRbblWfR56HM3RuK6jLTp
XHm2lJj6LopxC7BDPVF+SIMULlTyPh2hjbF2MVw9yNwsv1nruGQspzZ5VrBWlTsK
8Fs2sJif7Y8tWVFEMZczghrEoHN0KLe5vW4W6rX8xjjH5nL6ljtUeBDT6DyvD7yT
WymQWfObwp6VnjoR3nZ1SzB4DN/oGH10NaMjkk234mTkhU9Pl+UXFmesDdWn8Y64
3l5SpemMbNQaCaa/jyFQBJXu3+OTYVQafHjcl0bb3aRt4sHq5neS5zc/EIjz+Cpo
kqQwpQ6FslvSvamlwwB8mqDalPQZHeIvUNFMjlldpiAs8iCVeMHpolWI/CXCfo+1
BwVv8Kc1VnoMsjZ7uEUQJY9F1Q7YJ+4gFK6WSAhz7B9Na/0ztPJgq0tFYnVQgrwx
zUnLL7jPZZ4Wt8if9UayPtCUCdqHBSIfeoJ7+HMkC6FPt5GGCsrhtZX0u0Onop7F
Ka/VNgpMUNccgPvdqq3zYKyNIaAIUPf0jSyFbwxVXGbCLSZi8f4QmSw7k3BvkqNN
lR+pyqjKbImTpzqk0QT22SGT+4MeQgclbEUkpfA8PaPyb+9uLjgtZgp1ucTlMzOV
c3mXaTzRtSihagSW4hNyqYOINtBnvZp3n2fWDPgjJu+LWGOhpqY7P8mq8gFj77Fp
G49mKNuDiOkPWH3qHJgA
=bGWs
-----END PGP SIGNATURE-----

