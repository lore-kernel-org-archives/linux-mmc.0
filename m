From: Ritesh Raj Sarraf <rrs@researchut.com>
Subject: Re: xHCI problem? [was Re: Erratic USB device behavior and device
 loss]
Date: Mon, 05 Sep 2016 18:29:04 +0530
Message-ID: <1473080344.10346.4.camel@researchut.com>
References: <Pine.LNX.4.44L0.1609041544190.7019-100000@netrider.rowland.org>
Reply-To: rrs@researchut.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:32911 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932119AbcIEM7M (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Sep 2016 08:59:12 -0400
Received: by mail-pf0-f172.google.com with SMTP id g202so41668424pfb.0
        for <linux-mmc@vger.kernel.org>; Mon, 05 Sep 2016 05:59:11 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1609041544190.7019-100000@netrider.rowland.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, USB list <linux-usb@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Sun, 2016-09-04 at 15:46 -0400, Alan Stern wrote:
> 
> This is not the problem I was discussing with Ulf.  The problem was why
> the device kept going into and out of runtime suspend every three
> seconds.  The kernel log above does not say whether this was happening.
> One way to tell is to look at a usbmon trace (like we did before).

https://people.debian.org/~rrs/tmp/usbmon.txt.gz

This should have the logs you asked for, running on 4.8-rc4.


- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJXzWwYAAoJEKY6WKPy4XVpFKgP/i76Ek/1e1CYqStgakQUtmPb
eeGuSPFVqvQt4PEvGNvMtXcLMx5IKIEpKbqua7N4/ZfKmf5EA00wUCXzm85MnyAp
fIN9K1uOW1ZepnsViJ/U1bNZvHVDXy/LEfd5me+7JzWsPqaR/KjyZmZ8VSlu+aov
CvBDrt41x9plf1xJBYffHc2KvdM0lYFJjft2Gop9qr/hMhIy8RcJdbylPpnf4rtU
cbm3Ti3DdA+r86MLCKagq50Iow3xcfBEEYZLnn+ucnpTOWz56TyO3+44sjgLgrpy
IDRBlCbgk2RZkm8lpj+d052ssk3MjLBupBFkoRfXfXfear3zLrut2Q51xjeJIINz
oZdmAxozsvGxCtgC6dIb/79clruL8kqdr/TqF/YtwzB6JnFvZEgzBcpAlxFBxTlK
RtvAyPVs4Np1vtTli/Uv1O+odoR0FPhzpV+nDSsea7im6/oMav40UpXvgs72EEUS
cr5SwY8xClfNeemCHFZ/wFeYwPfjPfNU5Lgm/Hkpx6oaOABCnfacF1nWxbIRbuoh
gP9vW/Z0LI4azo940xlWfRiDck5W9IQXeI3v2wXVVIE8TDwxraQzyBXKKPBFxmfX
jTKWLRDDqyOWGcWxLJpMHMOa9rNtAZeiBI7TMbnqZKj6eLsdjuOW76zDhEHnMAtb
dUCOFYRG24arYTUpIVnB
=YG3r
-----END PGP SIGNATURE-----

