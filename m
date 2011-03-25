From: Chris Ball <cjb@laptop.org>
Subject: Re: outstanding tmio patches
Date: Fri, 25 Mar 2011 10:54:48 -0400
Message-ID: <m3ipv7l07b.fsf@pullcord.laptop.org>
References: <Pine.LNX.4.64.1103231505450.6836@axis700.grange>
	<m3k4folztx.fsf@pullcord.laptop.org>
	<m3mxkjl2nr.fsf@pullcord.laptop.org>
	<Pine.LNX.4.64.1103251518290.22824@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1103251518290.22824@axis700.grange> (Guennadi
	Liakhovetski's message of "Fri, 25 Mar 2011 15:19:50 +0100 (CET)")
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Fri, Mar 25 2011, Guennadi Liakhovetski wrote:
> Hm, strange, now all patches should be correct - if the correct versions 
> are taken. Let's do it easier: I've uploaded all 15 patches (14 mine and 1 
> from Simon) as a quilt series to
>
> http://download.open-technology.de/tmio-for-2.6.39/

Thanks, I just needed to pull changes from Linus into mmc-next.

I've pushed everything out to mmc-next now.  If anyone else is able to
grab mmc-next and supply a Tested-by: for their hardware, that'd be
appreciated.

Also, if anyone thinks that some of this should wait until .40, now's a
good time to speak up.  :)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
