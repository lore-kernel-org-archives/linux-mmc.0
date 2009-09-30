From: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: stalled mmc patches
Date: Wed, 30 Sep 2009 15:27:37 -0700 (PDT)
Message-ID: <381322.67385.qm@web28315.mail.ukl.yahoo.com>
References: <20090929131540.27d72d52.akpm@linux-foundation.org> <20090929235647.1c79e421@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from web28315.mail.ukl.yahoo.com ([87.248.110.134]:34672 "HELO
	web28315.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751120AbZI3W1e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 30 Sep 2009 18:27:34 -0400
In-Reply-To: <20090929235647.1c79e421@mjolnir.ossman.eu>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pierre Ossman <pierre-list@ossman.eu>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <damm@opensource.se>, Paul Mundt <lethal@linux-sh.org>

Pierre Ossman wrote:
> On Tue, 29 Sep 2009 13:15:40 -0700
> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
>> http://userweb.kernel.org/~akpm/mmotm/broken-out/sdio-recognize-io-card-without-powercycle.patch
> 
> I think it was a libertas card that I had problems with. So if someone
> has one of those and some time for hacking and testing. They'd need to
> make sure the card remains powered between inits to fully expose the
> bug I saw.
> 
> PS. try to clear my @drzeus.cx addresses from your address books. They
> will cease to function in the future.
> 
> Rgds

I'm fine with that. Let's give a chance to someone to make that particular test while the patch is being tested in -mm.
If no one complains after a reasonable period of time I'd vote for merging it :)

Cheers,
Albert


      
