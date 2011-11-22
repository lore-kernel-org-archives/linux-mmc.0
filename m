From: Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>
Subject: Re: [GIT PULL] ARM: amba: Enable module alias autogeneration for
	AMBA drivers
Date: Tue, 22 Nov 2011 16:19:42 +0100
Message-ID: <20111122151942.GA24821@mail.gnudd.com>
References: <20111122120756.GF2066@localhost.localdomain>
	<1321961573-4562-1-git-send-email-dave.martin@linaro.org>
	<20111122115632.GA5165@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20111122120756.GF2066-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Pawel.Moll-5wv7dgnIgG8@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, julia-dAYI7NvHqcQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

>>   lkml.org/lkml/2011/11/4/125 (0/2: description of the work)
>>   lkml.org/lkml/2011/11/4/126 (1/2: turn the if plethora to table lookup)
>>   lkml.org/lkml/2011/11/4/127 (2/2: partial split to type-specific files).
> 
> Splitting this up doesn't look like a silly idea -- I thought it was
> unfortunate to have to patch a core file just to add a bus type.
>
> I guess the question is how many new buses we get over time.

Well, CERN will have 2 in a short time. And I'm sure the bus concept
is so good that a number of them exists as external patches. Being
forced to patch a core file is not good, with conflicts that accumulate
over time.

I'd better be able to drop in my own file and add a kconfig-aware line
in Makefile.  I think the implementation is straightforward. Who should
I send it to?

thanks
/alessandro

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure 
contains a definitive record of customers, application performance, 
security threats, fraudulent activity, and more. Splunk takes this 
data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d
