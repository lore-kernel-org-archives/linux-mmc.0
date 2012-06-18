From: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH] spi: spi-pl022: Adjust probe() to of_get_named_gpio()
	returning -EPROBE_DEFER
Date: Mon, 18 Jun 2012 14:56:48 +0200
Message-ID: <4FDF2590.4010901@antcom.de>
References: <1340011219-31657-1-git-send-email-stigge@antcom.de>
	<CACRpkdYTE0imxEAdq0=wJO49iBAj=8xGjn_PevFm1Bsr3MvUQg@mail.gmail.com>
	<CAAAP30GAwQZtjAjtX=Q8K0Szo83QwqCZNtr09GxrgcvcR-CKeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAAAP30GAwQZtjAjtX=Q8K0Szo83QwqCZNtr09GxrgcvcR-CKeA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Alexandre Pereira da Silva <aletes.xgr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ulf.hansson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 06/18/2012 01:51 PM, Alexandre Pereira da Silva wrote:
> On Mon, Jun 18, 2012 at 8:47 AM, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> On Mon, Jun 18, 2012 at 11:20 AM, Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org> wrote:
>>
>>> The patch to gpiolib-of.c providing -EPROBE_DEFER as a hint to defer
>>> of_get_named_gpio*() to a later probe() breaks spi-pl022.c.
>>>
>>> This patch adjusts to this change, using -EPROBE_DEFER as indication to defer.
>>>
>>> Signed-off-by: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
>>
>> Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> Acked-by: Alexandre Pereira da Silva <aletes.xgr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
>>> Should this patch be joined with gpiolib-of's patch to of_get_named_gpio()? Or
>>> should they just be issued as a series?
>>
>> If it's not bisectable unless you change this in the same patch then join
>> them. Else I'd put them in a series and try to figure out a good tree for
>> merging them.
> 
> Ok, so lets keep the original patch as is for now.

When Linus Acked both patches for *spi-pl022* (dt + gpio/defer fix), and
they are not yet applied, please merge them. No need to introduce
intermediate breakage.

You can keep my Signed or Acked line for exactly this.

We'll keep the patch for *gpiolib-of* separate, of course.

Thanks,

Roland

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
