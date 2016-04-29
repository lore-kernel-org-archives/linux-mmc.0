From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk numbering
 w/ device tree
Date: Fri, 29 Apr 2016 14:39:35 -0700
Message-ID: <CAD=FV=V9V8P=d59RX1eaAdVxJgMxub1F6hzQNw1QW+7t=3POBw@mail.gmail.com>
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
	<20160429181248.GW19428@n2100.arm.linux.org.uk>
	<CAD=FV=VMxBYXOYOyHPeqcaWX7oU8pVrdLHOsWOWUgq-q5FshAw@mail.gmail.com>
	<20160429195741.GY19428@n2100.arm.linux.org.uk>
	<CAD=FV=UGyi0r3kDmc1cpcANTP-2u+7UEgW3r9kRvF2f8qcWH+g@mail.gmail.com>
	<20160429211328.GZ19428@n2100.arm.linux.org.uk>
	<CAD=FV=V8BOsO36eUOGAcXp04xCiN13UGG0Vaf2yhh1MQn85FjA@mail.gmail.com>
	<20160429212920.GA19428@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-spec-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160429212920.GA19428-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-spec-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Venu Byravarasu <vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>Pawel Moll <p>
List-Id: linux-mmc@vger.kernel.org

Russell,

On Fri, Apr 29, 2016 at 2:29 PM, Russell King - ARM Linux
<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> No, because you haven't taken the time to think and consider my
> reply, which gives you insight into how your "problem" is no
> different from the situation that everyone else has, where it
> isn't a problem.

I have certainly considered it.


> I think the "problem" here is that you've got used to coreboot
> doing something that very few other boot loaders do, namely it
> automatically extracting a rootfs UUID for you.  The rest of the
> world doesn't have that luxury.

Earlier in this thread Rob nicely proposed a solution to my TFTP.  I
agreed that was a nice solution.  I can certainly use it.  Certainly
there are many places where UUIDs are awesome.  ...but that's still no
reason to assign a random number when a sane and logical numbering
system exists for MMC parts on a given SoC.


> So, instead, you want to stuff more code into the kernel to work
> around what you think is a problem - a problem which seems to be
> unique to yourself.

Not so much.  I think many people have expressed interest in something
like this.  It seems unlikely to be unique.


> The UUID and label solutions were created by x86 people to work
> around exactly this dynamic device problem, and as my previous
> replies have shown, it is superior to fixing the device assignment
> as you're trying to do.

Sure.  They don't have the luxury of having a simple and consistent
numbering so they're forced to use UUIDs for booting and have the
extra mental work of mapping IDs to physical hardware.  ...so they're
forced to use UUIDs.


> However, I don't expect that you'll like this answer, and you'll
> probably just re-post your same question after each and every
> paragraph rather than considering whether the already existing
> solutions could solve your "problem".  So I'm just wasting my time.

Really I just reposted it several times because I notice that you seem
to ignore many points of my emails.  I was really hoping to get you to
address this point.  I notice that you still didn't.  Either you are
just trying to annoy me, or you don't have an answer to how my patch
series hurts you.


> This is my last reply.

Excellent.  I look forward to your silence.

-Doug
