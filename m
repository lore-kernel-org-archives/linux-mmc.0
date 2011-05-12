From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: tmio: fix PM in DMA mode
Date: Thu, 12 May 2011 18:12:35 -0400
Message-ID: <m3oc37woto.fsf@pullcord.laptop.org>
References: <Pine.LNX.4.64.1104291909290.17813@axis700.grange>
	<m3fwom6niy.fsf@pullcord.laptop.org>
	<Pine.LNX.4.64.1105121015490.24486@axis700.grange>
	<Pine.LNX.4.64.1105121212120.24486@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1105121212120.24486@axis700.grange> (Guennadi
	Liakhovetski's message of "Thu, 12 May 2011 12:19:10 +0200 (CEST)")
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

Hi Guennadi,

On Thu, May 12 2011, Guennadi Liakhovetski wrote:
>> > Please could you send a full patchset against mmc-next for tmio for .40?
>> 
>> Can I also base my patches on next-2.6? I need both - latest mmc and pm, 
>> so, using next would make it much easier.
>
> I rebased my stack on top of today's next, no changes were required, so, 
> here's the order, I have the patches in my tree:
>
> https://patchwork.kernel.org/patch/711251/
> https://patchwork.kernel.org/patch/757602/
> https://patchwork.kernel.org/patch/757612/
> https://patchwork.kernel.org/patch/724081/
> https://patchwork.kernel.org/patch/761882/
> https://patchwork.kernel.org/patch/761902/
> https://patchwork.kernel.org/patch/761922/
> https://patchwork.kernel.org/patch/761942/
> https://patchwork.kernel.org/patch/777232/
> https://patchwork.kernel.org/patch/777262/
>
> As long as we manage to get these in 2.6.40 merge window early enough, 
> we'll be able to push related arch patches via shmobile trees.

Thanks, all looks good to me -- pushed to mmc-next, and I'll try to
merge early in .40.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
