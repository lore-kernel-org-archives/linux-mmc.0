From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 0/6] ARM: sunxi: Add driver for SD/MMC
 hosts found on allwinner sunxi SOCs
Date: Wed, 05 Feb 2014 16:47:35 +0100
Message-ID: <52F25D17.9080309@redhat.com>
References: <20140204191648.29809.14611.stgit@dizzy-6.o2s.ch> <20140205103949.GC3192@lukather> <1676482.sbjAhaSLaV@dizzy-6.o2s.ch>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBLF2ZGLQKGQEL5IEQ7A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1676482.sbjAhaSLaV-GPtPHOohwllnsqa/0SyWJQ@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: =?ISO-8859-1?Q?David_Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Simon Baatz <gmbnomis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi David,

On 02/05/2014 02:01 PM, David Lanzend=F6rfer wrote:
> Hi Maxime
>> I have four comments here:
>>    - Read Documentation/SubmittingPatches, especially Section 5 and 12
>>      (hints, you forgot the clock maintainers for your clock patches
>>      and you didn't put any signed-off-by tags)
> Oops. I added signed-offs now
>>    - You ignored pretty much all the comments that were made during the
>>      review of the first version. Go through
> Uh? I just fixed the commits and squashed them together for easier handli=
ng.
> I'm even using mmc_of_parse now...
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/2193=
39.
>> html and address the comments that were made.
>>    - Each of your patches should compile. Fix the order of your
>>      patches.
> Done.
>>    - Submit a v3, with the changes you made. Otherwise we have no way
>>      of knowing what have been fixed and what didn't
> Too many patches would be bloaty.
> That's why I've squashed them into small and corrected patches.

The squashing is fine, what Maxime means is that normally you would include
a changelog in the coverletter (the [patch 0/x] mail) documenting changes
done since the previous posting of the patchset, so for v3 that would have =
been
something like:

Changes since v1:
-use mmc_of_parse instead of diy dt parsing
-add nodes for all mmc controller to the dtsi files, including sofar unused
  controllers

Changes since v2:
-Add missing Signed-off-by tags
-stop using __raw_readl / __raw_writel so that barriers are properly used

I've probably forgotten a few things, it would be good if you could send
a reply to the:
"[PATCH v3 0/7] ARM: sunxi: Add driver for SD/MMC hosts found on allwinner =
sunxi SOCs"
mail with the above changelog, amended with whatever I've forgotten to add
to the above changelog

Thanks & Regards,

Hans

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.
