From: Ritesh Raj Sarraf <rrs@researchut.com>
Subject: Re: xHCI problem? [was Re: Erratic USB device behavior and device
 loss]
Date: Tue, 06 Sep 2016 22:38:54 +0530
Message-ID: <1473181734.10190.2.camel@researchut.com>
References: <1473080344.10346.4.camel@researchut.com>
         <Pine.LNX.4.44L0.1609051157310.25234-100000@netrider.rowland.org>
         <CAPDyKFpnCXhdoKgoG576teC=y38vbC1x=-ehC_9EWEeKr_K6BQ@mail.gmail.com>
Reply-To: rrs@researchut.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36163 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938654AbcIFRJE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Sep 2016 13:09:04 -0400
Received: by mail-pf0-f171.google.com with SMTP id 128so886539pfb.3
        for <linux-mmc@vger.kernel.org>; Tue, 06 Sep 2016 10:09:04 -0700 (PDT)
In-Reply-To: <CAPDyKFpnCXhdoKgoG576teC=y38vbC1x=-ehC_9EWEeKr_K6BQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>
Cc: USB list <linux-usb@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hello Ulf,

On Tue, 2016-09-06 at 11:42 +0200, Ulf Hansson wrote:
> 
> By reviewing the code of the rtsx_usb_sdmmc driver, particularly how
> it calls pm_runtime_get|put() I am guessing those calls may not be
> properly deployed. Perhaps rtsx_usb_sdmmc should convert to use the
> usb_autopm_put|get_interface() and friends, although I didn't want to
> make that change at this point so instead I have cooked a patch that
> might fixes the behaviour.
> 
> Ritesh, can you please try it out to see what happens?

I was able to hit the issue again, with your patch applied. I tried it on top of
the 4.8-rc5 kernel.

I ensured to capture usbmon trace.
https://people.debian.org/~rrs/tmp/usbmon-ulf.txt.gz


- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJXzvgmAAoJEKY6WKPy4XVpJ/oQAIR/bC82KdqD3xuQpq8r62RT
fV8DSduNhr394GIDO5PBDSKUAFDKCHL9SyCBx9I5zx1U7OF+IfvhgpRji+XcBsQ5
TOtDAhiiTatKfWl/zLGbVqukNS8QLzyU26w0HRabvK3RZ0lGxBugQ8KneUC8wA/Q
NYWAgio5gN5jpD6BgGEZXo6cdzcdI1HM5kyNxcs4VfhD0zDor4wlrW024458a3Fs
02QAkmyV1aBwR4w/Ntw7D9DXb8sVujGgeEOr+KukzdFOPW+w4JOANv3gregDnKSc
EgIYmtTE95d0jWyJuS5sbZlbf4QOcrv9eVwn86TOdhZHU1XlaqaIEbRPzu15ZtZF
B+zYbWg+TgTYFgTYJoaB8T+CUJMMnNh62IC72LXa5K/C0kjgjlHUzis04XdFmT2q
jYC767M1utXi7a4LcXxw8V8uoV0nnmuvxWzhrcdBxi6+a85BLL8bPKT+nrGxkxB0
Hg7Wmnc9moohpjYD3KlAYR3bW56dDYrGgsj8xRUnplBkUp10g2vhix7bk/q+eUwU
gJghnI/WgEE5hBQabtuqCTCsvMdTXmZVjzMg1k43V5v+UR0a7mKVW0uBWu5cU38p
Ga9ZrNmPEzxOVmeXH3XCB8fCXRgce8ieu/KEPHpvbegia0nX4X7BcCHhK2KGsqnX
Y4f+TvpJw2idUe/cvdtw
=/aP1
-----END PGP SIGNATURE-----

