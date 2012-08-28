From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc: break out early if clock is 0
Date: Mon, 27 Aug 2012 20:43:16 -0700
Message-ID: <20120828034316.GA28396@kroah.com>
References: <1345648201-10746-1-git-send-email-shawn.guo@linaro.org>
 <87txvox7ba.fsf@octavius.laptop.org>
 <CAAQ0ZWSpxAn+F45C_tuW1Co1370-DVb=dXSzDt9GBy9Mq_vLqg@mail.gmail.com>
 <87ehmrykv8.fsf@octavius.laptop.org>
 <CAAQ0ZWS34QtkOGgidi=PyKX3=xHxRYdU+AQgV4kK9pJyeSCtHQ@mail.gmail.com>
 <876283yhjm.fsf@octavius.laptop.org>
 <CAAQ0ZWTjW83tFO8Ou9bffmHjPqd61GYg-yBjxmk=2HKzt_WFKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36798 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133Ab2H1DnV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Aug 2012 23:43:21 -0400
Received: by dady13 with SMTP id y13so2996862dad.19
        for <linux-mmc@vger.kernel.org>; Mon, 27 Aug 2012 20:43:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAAQ0ZWTjW83tFO8Ou9bffmHjPqd61GYg-yBjxmk=2HKzt_WFKg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Tue, Aug 28, 2012 at 09:50:13AM +0800, Shawn Guo wrote:
> On 28 August 2012 08:41, Chris Ball <cjb@laptop.org> wrote:
> > So, as I understand it, you did the right thing in having "Cc:
> > <stable@vger.kernel.org>" inside your commit message, and the
> > wrong thing in sending the mail to stable@ at the same time.
> > That's why I removed it from CC.
> >
> Ah, ok.  So it seems that I should have --suppress-cc in the git
> send-email command for such patches.

Not really, I don't mind it getting sent to stable@ for stuff like this,
it's trivial to filter away, and it helps me track, or pay attention to,
stuff that will be showing up in Linus's tree sometime soon.

So don't worry about it.

greg k-h
