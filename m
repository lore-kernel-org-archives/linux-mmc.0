From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sh_mmcif: fix use after free
Date: Tue, 30 Oct 2012 18:37:19 -0400
Message-ID: <878vanio2o.fsf@octavius.laptop.org>
References: <Pine.LNX.4.64.1210231406080.13115@axis700.grange>
	<878vapq8fj.fsf@octavius.laptop.org>
	<Pine.LNX.4.64.1210302306190.29432@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1210302306190.29432@axis700.grange> (Guennadi
	Liakhovetski's message of "Tue, 30 Oct 2012 23:08:57 +0100 (CET)")
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Guennadi,

On Tue, Oct 30 2012, Guennadi Liakhovetski wrote:
>> In future, feel free to note the
>> stable@ situation by adding:
>> 
>>    Cc: stable@vger.kernel.org [3.6]
>
> Hm, a bit confused. I seem to remember, that one of subsystem maintainers, 
> to whom I also submitted a patch, that should also have been forwarded to 
> stable, told me, that adding this "Cc: stable@..." tag was a task of 
> subsystem maintainers, in that case his task, and not of individual 
> submitters, which might only indicate their opinion in this respect. Am I 
> wrong?

Oh, interesting; I haven't seen that complaint myself.  I don't think
there's a kernel-wide rule about this, but I might be wrong.

Personally, I'm happy with receiving the stable@ tag because I like it
when patch authors think about -stable and I want to encourage them to
do so.  (Often they know whether a patch is needed in -stable better
than I do.)

Of course, the stable@ team isn't going to do anything until the patch
enters mainline, and the patch is only going to enter mainline through
my tree after I've had a chance to change the stable@ tag if necessary,
so there's no problem for me there.

Sorry to leave you in the middle of conflicting advice. :-)  The stable@
hint is appreciated in either form; I was just trying to save you some
typing.

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
