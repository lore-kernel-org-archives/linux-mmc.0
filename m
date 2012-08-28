From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc: break out early if clock is 0
Date: Tue, 28 Aug 2012 07:04:39 -0400
Message-ID: <87vcg3wa48.fsf@octavius.laptop.org>
References: <1345648201-10746-1-git-send-email-shawn.guo@linaro.org>
	<87txvox7ba.fsf@octavius.laptop.org>
	<CAAQ0ZWSpxAn+F45C_tuW1Co1370-DVb=dXSzDt9GBy9Mq_vLqg@mail.gmail.com>
	<87ehmrykv8.fsf@octavius.laptop.org>
	<CAAQ0ZWS34QtkOGgidi=PyKX3=xHxRYdU+AQgV4kK9pJyeSCtHQ@mail.gmail.com>
	<876283yhjm.fsf@octavius.laptop.org>
	<CAAQ0ZWTjW83tFO8Ou9bffmHjPqd61GYg-yBjxmk=2HKzt_WFKg@mail.gmail.com>
	<20120828034316.GA28396@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46343 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752572Ab2H1LEr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Aug 2012 07:04:47 -0400
In-Reply-To: <20120828034316.GA28396@kroah.com> (Greg Kroah-Hartman's message
	of "Mon, 27 Aug 2012 20:43:16 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org

Hi,

On Mon, Aug 27 2012, Greg Kroah-Hartman wrote:
> On Tue, Aug 28, 2012 at 09:50:13AM +0800, Shawn Guo wrote:
>> On 28 August 2012 08:41, Chris Ball <cjb@laptop.org> wrote:
>> > So, as I understand it, you did the right thing in having "Cc:
>> > <stable@vger.kernel.org>" inside your commit message, and the
>> > wrong thing in sending the mail to stable@ at the same time.
>> > That's why I removed it from CC.
>> >
>> Ah, ok.  So it seems that I should have --suppress-cc in the git
>> send-email command for such patches.
>
> Not really, I don't mind it getting sent to stable@ for stuff like this,
> it's trivial to filter away, and it helps me track, or pay attention to,
> stuff that will be showing up in Linus's tree sometime soon.
>
> So don't worry about it.

Oh, that's good -- I'm sorry for the bogus correction, Shawn!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
