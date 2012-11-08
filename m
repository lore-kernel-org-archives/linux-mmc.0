From: Daniel Drake <dsd@laptop.org>
Subject: Re: UHS-I voltage switching on OLPC XO-1.75
Date: Thu, 8 Nov 2012 13:10:15 -0600
Message-ID: <CAMLZHHTngbFFxF1Qat3HBKFBEc-2iSZLvwCL8GW75yHetahT1w@mail.gmail.com>
References: <5817E66E-3B94-42E1-AB06-699935D83379@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52310 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806Ab2KHTKP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Nov 2012 14:10:15 -0500
Received: by mail-pb0-f46.google.com with SMTP id rr4so2251283pbb.19
        for <linux-mmc@vger.kernel.org>; Thu, 08 Nov 2012 11:10:15 -0800 (PST)
In-Reply-To: <5817E66E-3B94-42E1-AB06-699935D83379@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@nvidia.com>
Cc: Johan Rudholm <jrudholm@gmail.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Thu, Nov 8, 2012 at 1:03 PM, Philip Rakity <prakity@nvidia.com> wrote:
> Don't know enough about the device tree to help.  Originally I suggested a
> quirk simular to what you are suggesting but it was felt to be too specific
> since the bits in caps2 achieve the same effect.  Maybe your board specific
> code can check if the regulator is capable of switching and can be turned on
> and off.  Not sure how to do the later.  Checking the usage count does not
> help.  You want exclusive access.  Mark Brown might know how to do this else
> perhaps the regulator framework needs extending.

We don't have a regulator in this case. If we did we'd probably be in
a different situation.

An option closer to overriding caps/caps1 in the board code is to put
the caps/caps1 overrides in the device tree directly. Doesn't sound
pleasing either, and I'm not sure that it makes sense; really the
hardware's reporting of its own capabilities is not wrong, it just
does not consider the capabilities of the surrounding components on
the motherboard. So a quirk feels more natural to me...

Daniel
