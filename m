From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] mmc: use PM QoS instead of delayed clock gating
Date: Sat, 28 Jan 2012 13:35:35 +0100
Message-ID: <201201281335.35397.rjw@sisk.pl>
References: <Pine.LNX.4.64.1201191631210.12537@axis700.grange>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54230 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752778Ab2A1Mb7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 28 Jan 2012 07:31:59 -0500
In-Reply-To: <Pine.LNX.4.64.1201191631210.12537@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, linux-sh@vger.kernel.org

Hi,

On Thursday, January 19, 2012, Guennadi Liakhovetski wrote:
> Hi all
> 
> I've already sent one of these two patches yesterday, but I forgot to 
> include Rafael on the CC list and forgot to mention, that the patch should 
> be treated as a regression fix and should go into 3.3. The reason why the 
> commit
> 
> commit 7e09bedba1b87f9c7b34ba895b57baf0c36ccdc8

I think that should be 597dd9d79cfbbb1636d00a7fd0880355d9b20c41, right?

> Author: Sujit Reddy Thumma <sthumma@codeaurora.org>
> Date:   Mon Nov 14 13:53:29 2011 +0530
> 
>     mmc: core: Use delayed work in clock gating framework
> 
> can be considered a regression is, that it extends the powered-on time of 
> the controller(s) and, possibly, of respective power domains by 200ms (by 
> default), which is an essential change in behaviour in the negative 
> direction.
> 
> However, if this is indeed the desired change, maybe the better approach 
> now would be to modify this behaviour in individual drivers, which is 
> exactly what the two patches in this series are doing.

I agree that doing such things at the framework level is not a good idea,
which this example clearly shows.

The commit above had made the assumption that every platform would
regard performance as more important than power saving and made a wholesale
change that affected everyone.  In some cases, however, the change is not
welcome and is not too easy to work around (because of the user space interface
file added in the process).

Quite frankly, I think it would be better to simply revert that commit (along
with the later one fixing it) at this point, because there may be more cases
where it actually makes things worse.

As for the patches, I'll reply to each of them separately.

Thanks,
Rafael
