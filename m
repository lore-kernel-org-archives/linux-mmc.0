From: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: Re: zaurus: mmcblk0: error -110
Date: Tue, 12 Apr 2011 18:53:29 -0400
Message-ID: <m339lnxes6.fsf@pullcord.laptop.org>
References: <20110412151547.GC20815@atrey.karlin.mff.cuni.cz>
	<m3aafvz30t.fsf@pullcord.laptop.org>
	<20110412193944.GC2665@atrey.karlin.mff.cuni.cz>
	<m3oc4bxne1.fsf@pullcord.laptop.org>
	<20110412205421.GD2665@atrey.karlin.mff.cuni.cz>
	<m3fwpnxj1w.fsf@pullcord.laptop.org>
	<20110412224333.GA22640@atrey.karlin.mff.cuni.cz>
Reply-To: Zaurus PDA developers list <zaurus-devel-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <zaurus-devel-bounces-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20110412224333.GA22640-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org> (Cyril Hrubis's
	message of "Wed, 13 Apr 2011 00:43:33 +0200")
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/zaurus-devel>,
	<mailto:zaurus-devel-request-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/zaurus-devel>
List-Post: <mailto:zaurus-devel-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:zaurus-devel-request-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/zaurus-devel>,
	<mailto:zaurus-devel-request-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: zaurus-devel-bounces-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org
Errors-To: zaurus-devel-bounces-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org
To: Cyril Hrubis <metan-+ZI9xUNit7I@public.gmane.org>
Cc: eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, zaurus-devel-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Apr 12 2011, Cyril Hrubis wrote:
>> > mmc0: error -95 whilst initialising SD card
>> 
>> That's interesting.  Would you mind trying to bisect?  (Knowing whether
>> 2.6.38 final does it, for example, would be very helpful.)
>
> It may need one or two tries on 2.6.38 but it's there too.
>
>> There aren't many -EOPNOTSUPP returns in the stack.  I see:
>> 
>> card/block.c: mmc_blk_issue_secdiscard_rq and mmc_blk_issue_discard_rq
>> card/core.c: mmc_erase
>> core/sd_ops.c: mmc_app_cmd
>> 
>> Mind doing some instrumentation to figure out which it is?
>
> Fails in the mmc_app_cmd.

Okay.  mmc_app_cmd() hasn't changed for years, so I'm afraid I don't
have any strong leads for you -- further bisection (you're pretty
sure this is a regression?) would be very useful.

Thanks,

- Chris.
-- 
Chris Ball   <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>   <http://printf.net/>
One Laptop Per Child
