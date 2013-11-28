From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 2/8] mmc: omap: Fix DMA configuration to not rely on device
 id
Date: Thu, 28 Nov 2013 18:13:24 +0200
Message-ID: <52976BA4.1000700@bitmer.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com> <1384396537-3486-3-git-send-email-tony@atomide.com> <20131118184723.GR10317@atomide.com> <87ioveeo0x.fsf@octavius.laptop.org> <20131127225704.208445df2aa7fc5fc6cb5faa@bitmer.com> <86fvqhjz4q.fsf@void.printf.net> <20131127215918.GD26766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:48107 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755090Ab3K1QNm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Nov 2013 11:13:42 -0500
In-Reply-To: <20131127215918.GD26766@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Jarkko Lavinen <j.lavinen@samsung.com>

Hi

On 11/27/2013 11:59 PM, Tony Lindgren wrote:
> * Chris Ball <cjb@laptop.org> [131127 13:48]:
>> Hi,
>>
>> On Wed, Nov 27 2013, Jarkko Nikula wrote:
>>> Can you enlighten me what's the proper way to get patches to mmc since
>>> I cannot figure out working methodology from MAINTAINERS file?
>>
>> Sorry about this, Jarkko.
>>
>> Since I don't have omap.c hardware, I'm generally going to wait for
>> a Tested-by/Acked-by from someone else on patches like these.  We
>> actually have a maintainer already listed for the driver, Jarkko
>> Lavinen <jarkko.lavinen@nokia.com>.
>>
>> So, maybe the MAINTAINERS section for drivers/mmc/host/omap.c needs
>> an update?  Feel free to send me patches to it.  Either way, I'll
>> start treating Aaro and Jarkko (Nikula) as maintainers for this
>> driver.
> 
Oh, I see. I even didn't check ./scripts/get_maintainer.pl nor check
MAINTAINERS file further than main MMC entry as I knew Jarkko L. is not
working anymore for Nokia. Sorry, we should have noticed that.

> Hmm looks like here's a reasonably recent update that we've missed
> from Jarkko Lavinen to update his email address:
> 
> http://lkml.org/lkml/2013/10/4/142
> 
> I've updated Jarkko Lavinen's address in this mail, we should
> probably also patch the MAINTAINERS file for that, and then see if
> Aaro and Jarkko Nikula are interested to be listed there as well.
> 
I can volunteer. Not that I know much about mmc but I like to keep my
legacy hw still running :-)

-- 
Jarkko
